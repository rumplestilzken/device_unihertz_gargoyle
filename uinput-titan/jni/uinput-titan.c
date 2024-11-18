#define _GNU_SOURCE
#include <linux/input.h>
#include <linux/uinput.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <inttypes.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <pthread.h>
#include <stdbool.h>
#include <android/log.h>
#include <sys/time.h>

#include <jni.h>

#define  LOG_TAG    "UINPUT-TITAN"

#define  LOGI(...)  __android_log_print(ANDROID_LOG_INFO, LOG_TAG, __VA_ARGS__)
#define  LOGE(...)  __android_log_print(ANDROID_LOG_ERROR, LOG_TAG, __VA_ARGS__)

// some good resources
// standard android kernel event codes: https://android.googlesource.com/kernel/common/+/android-4.14-p/include/uapi/linux/input-event-codes.h
// event code doc: https://android.googlesource.com/kernel/common/+/android-4.14-p/Documentation/input/event-codes.rst
// multitouch doc: https://android.googlesource.com/kernel/common/+/android-4.14-p/Documentation/input/multi-touch-protocol.rst

// android keylayout file codes: http://www.temblast.com/ref/akeyscode.htm



//now() is in total us mod 10^15
uint64_t now() {
    uint64_t t;
    struct timeval tv;
    gettimeofday(&tv, NULL);
    t = tv.tv_usec;
    t += (tv.tv_sec % (1000*1000*1000)) * 1000*1000LL;
    return t;
}

static uint64_t lastKbdTimestamp;

typedef enum device_type {
    NOTSET,
    TITAN,
    POCKET,
    SLIM
} device_type;

static int screen_width = 0;
static int screen_height = 0;
static device_type dev = NOTSET;

static void insertEvent(int fd, int type, int code, int value) {
    struct input_event out_e;
    memset(&out_e, 0, sizeof(out_e));
    gettimeofday(&out_e.time, NULL);
    out_e.type = type;
    out_e.code = code;
    out_e.value = value;
    write(fd, &out_e, sizeof(out_e));
}


static int uinput_init() {
    int fd = open("/dev/uinput", O_RDWR);

    struct uinput_setup setup = {
        .id = {
               .bustype = BUS_VIRTUAL,
               .vendor = 0xdead,
               .product = 0xbeef,
               .version = 3,
               },
        .name = "titan-uinput",
        .ff_effects_max = 0,
    };
    ioctl(fd, UI_DEV_SETUP, setup);

    struct uinput_abs_setup abs_setup_x = {
        .code = ABS_X,
        .absinfo = {
                    .value = 0,
                    .minimum = 0,
                    //.maximum = 2880,
                    .maximum = screen_width,
                    .fuzz = 0,
                    .flat = 0,
                    //.resolution = 2880,
                    .resolution = screen_width,
                    },
    };
    ioctl(fd, UI_ABS_SETUP, abs_setup_x);

    //while the touchpad only goes to 720 in the y, we want to map directly to the display so we use 1440 */
    struct uinput_abs_setup abs_setup_y = {
        .code = ABS_Y,
        .absinfo = {
                    .value = 0,
                    .minimum = 0,
                    //.maximum = 1440,
                    .maximum = screen_height,
                    .fuzz = 0,
                    .flat = 0,
                    //.resolution = 1440,
                    .resolution = screen_height,
                    },
    };
    ioctl(fd, UI_ABS_SETUP, abs_setup_y);

    struct uinput_abs_setup abs_setup_pressure = {
        .code = ABS_PRESSURE,
        .absinfo = {
                    .value = 0,
                    .minimum = 0,
                    .maximum = 255,
                    .fuzz = 0,
                    .flat = 0,
                    .resolution = 0,
                    },
    };
    ioctl(fd, UI_ABS_SETUP, abs_setup_pressure);

    struct uinput_abs_setup abs_setup_touch_major = {
        .code = ABS_MT_TOUCH_MAJOR,
        .absinfo = {
                    .value = 0,
                    .minimum = 0,
                    .maximum = 100,
                    .fuzz = 0,
                    .flat = 0,
                    .resolution = 0,
                    },
    };
    ioctl(fd, UI_ABS_SETUP, abs_setup_touch_major);

    struct uinput_abs_setup abs_setup_touch_minor = {
        .code = ABS_MT_TOUCH_MINOR,
        .absinfo = {
                    .value = 0,
                    .minimum = 0,
                    .maximum = 100,
                    .fuzz = 0,
                    .flat = 0,
                    .resolution = 0,
                    },
    };
    ioctl(fd, UI_ABS_SETUP, abs_setup_touch_minor);

    struct uinput_abs_setup abs_setup_position_x = {
        .code = ABS_MT_POSITION_X,
        .absinfo = {
                    .value = 0,
                    .minimum = 0,
                    //.maximum = 2880,
                    .maximum = screen_width,
                    .fuzz = 0,
                    .flat = 0,
                    .resolution = 0,
                    },
    };
    ioctl(fd, UI_ABS_SETUP, abs_setup_position_x);

    //while the touchpad only goes to 720 in the y, we want to map directly to the display so we use 1440 */
    struct uinput_abs_setup abs_setup_position_y = {
        .code = ABS_MT_POSITION_Y,
        .absinfo = {
                    .value = 0,
                    .minimum = 0,
                    //.maximum = 1440,
                    .maximum = screen_height,
                    .fuzz = 0,
                    .flat = 0,
                    .resolution = 0,
                    },
    };
    ioctl(fd, UI_ABS_SETUP, abs_setup_position_y);

    struct uinput_abs_setup abs_setup_tracking_id = {
        .code = ABS_MT_TRACKING_ID,
        .absinfo = {
                    .value = 0,
                    .minimum = 0,
                    .maximum = 10,
                    .fuzz = 0,
                    .flat = 0,
                    .resolution = 0,
                    },
    };
    ioctl(fd, UI_ABS_SETUP, abs_setup_tracking_id);


    // linux event codes defined here: https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/input-event-codes.h
    // more accurate android event codes defined here: https://android.googlesource.com/kernel/common/+/android-4.14-p/include/uapi/linux/input-event-codes.h
    // and here is how they map https://source.android.com/devices/input/keyboard-devices
    //general events
    ioctl(fd, UI_SET_EVBIT, EV_SYN);
    ioctl(fd, UI_SET_EVBIT, EV_KEY);
    ioctl(fd, UI_SET_EVBIT, EV_REL);

    // keyboard events
    ioctl(fd, UI_SET_KEYBIT, KEY_LEFT);
    ioctl(fd, UI_SET_KEYBIT, KEY_RIGHT);
    ioctl(fd, UI_SET_KEYBIT, KEY_UP);
    ioctl(fd, UI_SET_KEYBIT, KEY_DOWN);
    ioctl(fd, UI_SET_KEYBIT, KEY_TAB);
    ioctl(fd, UI_SET_KEYBIT, KEY_RIGHTALT);
    ioctl(fd, UI_SET_KEYBIT, KEY_LEFTSHIFT);
    ioctl(fd, UI_SET_KEYBIT, KEY_APPSELECT);
    ioctl(fd, UI_SET_KEYBIT, KEY_NUMERIC_POUND);
    ioctl(fd, UI_SET_KEYBIT, KEY_H);
    ioctl(fd, UI_SET_KEYBIT, KEY_J);
    ioctl(fd, UI_SET_KEYBIT, KEY_K);
    ioctl(fd, UI_SET_KEYBIT, KEY_L);
    ioctl(fd, UI_SET_KEYBIT, KEY_4);
    ioctl(fd, UI_SET_KEYBIT, KEY_5);
    ioctl(fd, UI_SET_KEYBIT, KEY_6);
    ioctl(fd, UI_SET_KEYBIT, KEY_ENTER);

    // lets us behave as a touchscreen. Inputs are directly mapped onto display
    ioctl(fd, UI_SET_PROPBIT, INPUT_PROP_DIRECT);

    // touch events
    ioctl(fd, UI_SET_EVBIT, EV_ABS);
    ioctl(fd, UI_SET_KEYBIT, BTN_TOUCH);

    const char phys[] = "this/is/a/virtual/device/for/scrolling";
    ioctl(fd, UI_SET_PHYS, phys);
    ioctl(fd, UI_DEV_CREATE, NULL);
    return fd;
}


static int open_ev(const char *lookupName) {
    char *path = NULL;
    for(int i=0; i<64;i++) {
        asprintf(&path, "/dev/input/event%d", i);
        int fd = open(path, O_RDWR);
        if(fd < 0) continue;
        char name[128];
        ioctl(fd, EVIOCGNAME(sizeof(name)), name);
        if(strcmp(name, lookupName) == 0) {
            LOGI("open_ev name = %s and lookupName = %s\n",name, lookupName);
            return fd;
        }

        close(fd);
    }
    free(path);
    return -1;
}

static int original_input_init() {
    int fd = open_ev("mtk-pad");
    if(fd<0) return fd;
    ioctl(fd, EVIOCGRAB, 1);
    return fd;
}


static void ev_parse_rel(struct input_event e) {
    const char *relName = "Unknown";
    switch(e.code) {
        default:
            fprintf(stderr, "Unknown rel %d\n", e.code);
            break;
    }
    printf("Got rel event %s: %d\n", relName, e.value);
}

static void ev_parse_syn(struct input_event e) {
    const char *synName = "Unknown";
    switch(e.code) {
        case SYN_REPORT:
            synName = "Simple report\n";
            break;
        case SYN_MT_REPORT:
            synName = "Multi-touch report";
            break;
        default:
            fprintf(stderr, "Unknown syn %d\n", e.code);
            break;
    }
    printf("Got syn event %s: %d\n", synName, e.value);
}

static void ev_parse_key(struct input_event e) {
    const char *keyName = "Unknown";
    switch(e.code) {
        case BTN_TOOL_FINGER:
            keyName = "tool finger";
            break;
        case BTN_TOUCH:
            keyName = "touch";
            break;
        default:
            fprintf(stderr, "Unknown key %d\n", e.code);
            break;
    }
    printf("Got key event %s: %d\n", keyName, e.value);
}

static void ev_parse_abs(struct input_event e) {
    const char *absName = "Unknown";
    switch(e.code) {
        case ABS_MT_POSITION_X:
            absName = "MT X";
            break;
        case ABS_MT_POSITION_Y:
            absName = "MT Y";
            break;
        case ABS_MT_TOUCH_MAJOR:
            absName = "Major touch axis";
            break;
        case ABS_MT_TOUCH_MINOR:
            absName = "Minor touch axis";
            break;
        case ABS_X:
            absName = "X";
            break;
        case ABS_Y:
            absName = "Y";
            break;
        case ABS_MT_TRACKING_ID:
            absName = "MT tracking id";
            break;
        default:
            fprintf(stderr, "Unknown abs %x\n", e.code);
            break;
    }
    printf("Got abs event %s: %d\n", absName, e.value);
}

int isInRect(int x, int y, int top, int bottom, int left, int right) {
    return
        (x > left && x < right && y > top && y < bottom);
}


int injectKeyDown(int ufd, int key){
    __android_log_print(ANDROID_LOG_INFO, "UINPUT-TITAN-KB-INJECT", "injecting down key = %d\n", key);
    insertEvent(ufd, EV_KEY, key, 1);
    insertEvent(ufd, EV_SYN, SYN_REPORT, 0);
    return 0;
}

int injectKeyUp(int ufd, int key){
    __android_log_print(ANDROID_LOG_INFO, "UINPUT-TITAN-KB-INJECT", "injecting up key = %d\n", key);
    insertEvent(ufd, EV_KEY, key, 0);
    insertEvent(ufd, EV_SYN, SYN_REPORT, 0);
    return 0;
}

int injectKey(int ufd, int key) {
    injectKeyDown(ufd, key);
    injectKeyUp(ufd, key);
    return 0;
}

int injectAbsEvent(int ufd, int x, int y, bool first){
    insertEvent(ufd, EV_ABS, ABS_MT_TRACKING_ID, 0 );
    if(first){
        insertEvent(ufd, EV_KEY, BTN_TOUCH, 1 );
    }
    insertEvent(ufd, EV_ABS, ABS_MT_POSITION_X, x );
    insertEvent(ufd, EV_ABS, ABS_MT_POSITION_Y, y );
    insertEvent(ufd, EV_ABS, ABS_MT_TOUCH_MAJOR, 1 );
    insertEvent(ufd, EV_ABS, ABS_MT_TOUCH_MINOR, 1 );
    insertEvent(ufd, EV_SYN, SYN_MT_REPORT, 0 );
    insertEvent(ufd, EV_SYN, SYN_REPORT, 0 );
    return 0;
}

int injectAbsFinal(int ufd){
    insertEvent(ufd, EV_KEY, BTN_TOUCH, 0 );
    insertEvent(ufd, EV_ABS, ABS_MT_TRACKING_ID, -1 );
    insertEvent(ufd, EV_SYN, SYN_MT_REPORT, 0 );
    insertEvent(ufd, EV_SYN, SYN_REPORT, 0 );
    return 0;
}

bool IsCurrentlySelectedTextBox = false;

bool setIsCurrentlySelectedTextBox() {
    //TODO: Make call with JNI to verify if TextBox is selected
    //TODO: Change to cursor mode if TextBox is selected
    //TODO: If TextBox is no longer selected, use normal scrolling behavior
}

// 0x0             X axis
// |----------------------------------|
// |                                  |
// |                                  |
// |                                  |
// |                                  |
// |                                  |
// |                                  |
// |                                  | Y axis
// |                                  |
// |                                  |
// |                                  |
// |                                  |
// |                                  |
// |----------------------------------| 1440x1440
// display resolution is 1440x1400
// keyboard touchpad resolution is 1440x720
// using system input swipe is much much too slow :/
// currently, this is only used for vertical swipes, but it has the capabilities to be used for horizontal swipes as well
int injectSwipe(int ufd, int xstart, int ystart, int xend, int yend){

    int x = 720;
    int y = 720;
    int swipe_size = 60;
    int swipe_increment = 20;
    bool vertical = false;
    bool positive = false; // positive is down, !positive is up
    if ( abs(xstart - xend ) > abs(ystart - yend)){
        vertical = false;
        if( ( xstart - xend ) > 0){
            positive = true;
        }
        else{
            positive = false;
        }
    }
    else{
        vertical = true;
        if( ( ystart - yend ) > 0){
            positive = true;
        }
        else{
            positive = false;
        }
    }

    LOGI("SENDING SWIPE\n");
    injectAbsEvent(ufd, x, y, true);
    if(vertical && positive){
        for(int j = y+swipe_increment; j <= y+swipe_size; j += swipe_increment){
            injectAbsEvent(ufd, x, j, false);
            usleep(500);
        }
    }
    if(vertical && !positive){
        for(int j = y-swipe_increment; j >= y-swipe_size; j -= swipe_increment){
            injectAbsEvent(ufd, x, j, false);
            usleep(500);
        }
    }
    if(!vertical && positive){
        for(int i = x+swipe_increment; i >= x+swipe_size; i += swipe_increment){
            injectAbsEvent(ufd, i, y, false);
            usleep(500);
        }
    }

    if(!vertical && !positive){
        for(int i = x-swipe_increment; i >= x-swipe_size; i -= swipe_increment){
            injectAbsEvent(ufd, i, y, false);
            usleep(500);
        }
    }

    injectAbsFinal(ufd);
    LOGI("SENT SWIPE\n");

    return 0;
}


struct input_event input_event_buffer[2048];
static int buffer_index = 0;
static int touched = 0;
static int sent_events = 0;
static int first_x = -1;
static int first_y = -1;
static int latest_x = -1;
static int latest_y = -1;
// since we are mapping a 720 resolution touchpad onto a 1440 resolution screen, we have to multiply the y value to
// get decent scrolling behaviour
static float y_multiplier = 1;
// TODO: pick a proper multiplier. best so far is 1.7 for y
static float x_multiplier = 1;
static bool isSwipeActivated = false;
static bool isSwipeLeftActivated = false;
static bool isSwipeRightActivated = false;


static void buffer(struct input_event e){
    input_event_buffer[buffer_index] = e;
    buffer_index++;
    return;
}

static void reset(){
    LOGI("reset\n");
    buffer_index = 0;
    touched = 0;
    sent_events = 0;
    first_x = -1;
    first_y = -1;
    latest_x = -1;
    latest_y = -1;
    return;
}

static void replay_buffer(int ufd, int correct_x){
    int last_value = 0;
    struct input_event ieb;
    int values[2];
    int valuesCount = 0;
    if (correct_x){
        for(int i = 0; i < buffer_index; i++){
            if(input_event_buffer[i].type == EV_ABS && input_event_buffer[i].code == ABS_MT_POSITION_X){
                input_event_buffer[i].value = first_x;
            }
            if(input_event_buffer[i].type == EV_ABS && input_event_buffer[i].code == ABS_MT_POSITION_Y){
                if(valuesCount < 2)
                    values[valuesCount] = input_event_buffer[i].value;
                valuesCount++;
            }
            write(ufd, &input_event_buffer[i], sizeof(input_event_buffer[i]));
            last_value = input_event_buffer[i].value;
            ieb = input_event_buffer[i];
        }
    }
    else{
        for(int i = 0; i < buffer_index; i++){
            if(input_event_buffer[i].type == EV_ABS && input_event_buffer[i].code == ABS_MT_POSITION_Y){
                if(valuesCount < 2)
                    values[valuesCount] = input_event_buffer[i].value;
                valuesCount++;
            }
            write(ufd, &input_event_buffer[i], sizeof(input_event_buffer[i]));
            last_value = input_event_buffer[i].value;
            ieb = input_event_buffer[i];
        }
    }
/*
    //Give several events after swipe ends to smooth experience
    for(int i = 0; i < 50; i++) {
        if(values[0] > values[1])
        {
            ieb.value = last_value + 10;
        }
        else
        {
            ieb.value = last_value - 10;
        }
        write(ufd, &ieb, sizeof(ieb));
        last_value = ieb.value;
    }
*/
    buffer_index = 0;
    return;
}

// send all of the events we have been saving, including the latest SYN
static void act(int ufd, int correct_x){
    if(!sent_events){
        LOGI("act: adding tracking id\n");
        insertEvent(ufd, EV_ABS, ABS_MT_TRACKING_ID, 0 );
    }
    LOGI("act: replaying buffer\n");
    replay_buffer(ufd, correct_x);
    return;
}

static bool isSwipeLeft() {
   LOGI("Checking Swipe Left");

   char buf[100];
   int x_buf[10];
   int x = 0;
   for(int i = 0; i < buffer_index-1; i++)
   {
     struct input_event e = input_event_buffer[i];
     if(e.code == ABS_MT_POSITION_X)
     {
        snprintf(buf, 100, "ieb:%d", e.value);
//        LOGI(buf);
        x_buf[x] = e.value;
        x++;
     }
   }

   int x_buf2[10];
   for(int i = 0; i < 10; i++) {
        x_buf2[i] = x_buf[10-i];
   }

   int current_xbuf = 0;
   for(int i = 0; i < 10; i++)
   {
        if(current_xbuf == 0)
        {
            current_xbuf = x_buf2[i];
        }

        if(x_buf2[i] == 0)
        {
            continue;
        }

        snprintf(buf, 100, "ieb2:%d", x_buf2[i]);
//        LOGI(buf);

        if(current_xbuf > 0 && current_xbuf < x_buf2[i])
        {
            LOGI("Swipe Left Occurred");
            return true;
        }

        current_xbuf = x_buf2[i];
   }

   return false;
}

static bool isSwipeRight() {
       LOGI("Checking Swipe Right");

       char buf[100];
       int x_buf[10];
       int x = 0;
       for(int i = 0; i < buffer_index-1; i++)
       {
         struct input_event e = input_event_buffer[i];
         if(e.code == ABS_MT_POSITION_X)
         {
            snprintf(buf, 100, "ieb:%d", e.value);
//            LOGI(buf);
            x_buf[x] = e.value;
            x++;
         }
       }

       int current_xbuf = 0;
       for(int i = 0; i < 10; i++)
       {
           if(current_xbuf == 0)
           {
               current_xbuf = x_buf[i];
           }

           if(x_buf[i] == 0)
           {
               continue;
           }
            snprintf(buf, 100, "ieb2:%d", x_buf[i]);
//            LOGI(buf);

            if(current_xbuf > x_buf[i])
            {
                LOGI("Swipe Right Occurred");
                return true;
            }

            current_xbuf = x_buf[i];
       }

       return false;
}

static bool isSwipe(){
      return isSwipeActivated;
}



static void decide(int ufd){
    uint64_t d = now() - lastKbdTimestamp;
    int y_threshold = 30 * y_multiplier;
    int x_threshold = 30 * x_multiplier;


    //TODO handle tap events for tab here before the KB delay

    //500ms after typing ignore
    if(d < 500*1000) {
        reset();
        return;
    }

   // TODO: arrow key mode?
/*
   if(isSwipeActivated) {
        LOGI("isSwipeActivated:true");
        if(isSwipeLeft()){
            LOGI("Injecting Swipe Left");
            injectKeyDown(ufd, KEY_LEFTSHIFT);
            injectKey(ufd, KEY_LEFT);
            injectKeyUp(ufd, KEY_LEFTSHIFT);
            //reset();
        }
        else if(isSwipeRight()){
            LOGI("Injecting Swipe Right");
            injectKeyDown(ufd, KEY_LEFTSHIFT);
            injectKey(ufd, KEY_RIGHT);
            injectKeyUp(ufd, KEY_LEFTSHIFT);
            //reset();
        }
        return;
    }
    */

    if( (abs(first_y - latest_y) > y_threshold) || (abs(first_x - latest_x) > x_threshold)){
        LOGI("decide: acting\n");

        // TODO: correct y values to avoid activating the notification panel. this goes along with picking a proper multiplier. Also might need to do the same to avoid activating the switcher?
        act(ufd, latest_x);
        sent_events = 1;
    }
    return;
}

static void finalize(int ufd){
    insertEvent(ufd, EV_ABS, ABS_MT_TRACKING_ID, -1 );
    insertEvent(ufd, EV_SYN, SYN_MT_REPORT, 0 );
    insertEvent(ufd, EV_SYN, SYN_REPORT, 0 );
    return;
}

int tapped = 0;
int was_tapped = 0;
int tap_x = 0;
int tap_y = 0;
static int64_t last_single_tap_time = 0;
static int64_t last_double_tap_time = 0;
// a touch starts with BTN_TOUCH DOWN. Store first x/y here
// store and act on every SYN
// when we see a difference > 60 start piping stored, and future syns until BTN_TOUCH UP
static void handle(int ufd, struct input_event e){
    /* LOGI("saw type = %d, code = %d, value = %d\n", e.type, e.code, e.value); */
    if(e.type == EV_KEY && e.code == BTN_TOUCH && e.value == 1) {
        LOGI("BTN_TOUCH DOWN\n");
        touched = 1;
        buffer(e);

    }
    else if(touched){
        if(e.type == EV_KEY && e.code == BTN_TOUCH && e.value == 0){

            if (isSwipeActivated) {
                if(latest_x < screen_width/2)
                {
                    injectKey(ufd, KEY_LEFT);
                }
                else
                {
                    injectKey(ufd, KEY_RIGHT);
                }
            }

            if (sent_events){
                LOGI("BTN_TOUCH UP: sent events\n");
                buffer(e);
                act(ufd, 0);
                finalize(ufd);
                reset();
            }
            else{
                buffer(e);
                LOGI("BTN_TOUCH UP: resetting\n");
                if(was_tapped){
                    LOGI("entered was_tapped");
                    uint64_t d1 = now() - lastKbdTimestamp;
                    uint64_t d2 = now() - last_single_tap_time;
                    bool isD1 = d1 > 100*1000LL;
                    bool isD2 = d2 < 1300*1000LL;
                    char buf[100];
                    char buf2[100];
                    char buf3[100];
                    char buf4[100];
                    snprintf(buf, 100, "d1:%d", d1);
                    snprintf(buf2, 100, "d2:%d", d2);
//                    LOGI(buf);
//                    LOGI(buf2);
                    if(isD1) {
                        LOGI("isD1:true");
                    }
                    else
                    {
                        LOGI("isD1:false");
                    }

                    if(isD2) {
                        LOGI("isD2:true");
                    }
                    else
                    {
                        LOGI("isD2:false");
                    }

                    if(isD1 && isD2) {
                        LOGI("double tap time check passed");
                        //if(isInRect(tap_x, tap_y, 1200, 1224, 600, 800)) {
                        char buf5[100];
                        char buf6[100];
                        snprintf(buf, 100, "tap_x:%d", tap_x);
                        snprintf(buf2, 100, "tap_y:%d", tap_y);
                        snprintf(buf3, 100, "top:%d", latest_y+180);
                        snprintf(buf4, 100, "bottom:%d", latest_y-180);
                        snprintf(buf5, 100, "left:%d", latest_x-180);
                        snprintf(buf6, 100, "right:%d", latest_x+180);
//                        LOGI(buf);
//                        LOGI(buf2);
//                        LOGI(buf3);
//                        LOGI(buf4);
//                        LOGI(buf5);
//                        LOGI(buf6);

                        if(isInRect(tap_x, tap_y, latest_y-180, latest_y+180, latest_x - 180, latest_x + 180)) {
                            LOGI("double tap first rect passed");
                                isSwipeActivated = true;
                            /*
                            if(isInRect(latest_x, latest_y, 1200, 1224, 600, 800)) {
                                LOGI("Double tap on space key\n");
                                injectKey(ufd, KEY_TAB);
                            }
                            */
                        }

                        was_tapped = 0;
                        LOGI("setting was_tapped = 0");
                    }
                    last_single_tap_time = now();
                }
                else{
                    LOGI("setting was_tapped = 1");
                    was_tapped = 1;
                    tap_x = latest_x;
                    tap_y = latest_y;
                    last_single_tap_time = now();
                }

                reset();

            }
        }
        else if(e.type == EV_ABS && e.code == ABS_MT_POSITION_X) {
            buffer(e);
            if(first_x == -1){
                LOGI("setting first_x to %d\n", e.value);
                first_x = e.value;
                latest_x = e.value;
            }
            else{
                LOGI("setting latest_x to %d\n", e.value);
                latest_x = e.value;
            }
        }
        else if(e.type == EV_ABS && e.code == ABS_MT_POSITION_Y) {
            e.value = y_multiplier * e.value;
            buffer(e);
            if(first_y == -1){
                LOGI("setting first_y to %d\n", e.value);
                first_y = e.value;
                latest_y = e.value;
            }
            else{
                LOGI("setting latest_y to %d\n", e.value);
                latest_y = e.value;
            }
        }
        else if(e.type == EV_SYN && e.code == SYN_REPORT) {
            buffer(e);
            LOGI("SYN seen, deciding\n");
            decide(ufd);
        }
        else {
            //we have started a touch, but haven't decided to act yet.
            //save so we can replay if we decide to act
            buffer(e);
        }
    }
    return;
}

void *keyboard_monitor(void* ptr) {
    int ufd = *(int*)ptr;
    /* (void)ptr; */

    int saw_function = 0;
    uint64_t last_saw_function = 0;
    static uint64_t hold_time = 300000;

    uint64_t test_time = 0;

    int shift_toggle = 0;
    int alt_toggle = 0;
    int shift_lock = 0;
    int alt_lock = 0;

    struct input_event kbe;

    //aw9523-key
    __android_log_print(ANDROID_LOG_INFO, "UINPUT-TITAN-KB-MON-THREAD", "start\n");
    int fd = open_ev("aw9523-key");
    if(fd<0){
        __android_log_print(ANDROID_LOG_INFO, "UINPUT-TITAN-KB-MON-THREAD", "open failed!\n");
        return NULL;
    }
    __android_log_print(ANDROID_LOG_INFO, "UINPUT-TITAN-KB-MON-THREAD", "opened successfully\n");

    while(1) {
        if(read(fd, &kbe, sizeof(kbe)) != sizeof(kbe)){
            break;
        }
        else{

            if(kbe.type == EV_KEY){
                __android_log_print(ANDROID_LOG_INFO, "UINPUT-TITAN-KB-MON-THREAD", "read key code = %d, value = %d\n", kbe.code, kbe.value);
            }

            // can possibly remap more keys, specfically hjkl to arrow keys by mapping them to FUNCTION in the kl
            // then send  like we did with APP_SWITCH

            // for presses, we want to act on key down
            if(kbe.type == EV_KEY && kbe.value == 1){
                lastKbdTimestamp = now();
                if(kbe.code == KEY_APPSELECT){
                    __android_log_print(ANDROID_LOG_INFO, "UINPUT-TITAN-KB-MON-THREAD", "read function\n");
                    saw_function = 1;
                    last_saw_function = now();
                }
                else if(kbe.code == KEY_LEFTSHIFT){
                    if (shift_lock){
                        shift_lock = 0;
                    }
                    else if(!shift_toggle){
                        shift_toggle = 1;
                    }
                    else if (shift_toggle){
                        shift_lock = 1;
                        shift_toggle = 0;
                    }
                    __android_log_print(ANDROID_LOG_INFO, "UINPUT-TITAN-KB-MON-THREAD", "shift_toggle = %d, shift_lock = %d\n", shift_toggle, shift_lock);
                    __android_log_print(ANDROID_LOG_INFO, "UINPUT-TITAN-KB-MON-THREAD", "alt_toggle = %d, alt_lock = %d\n", alt_toggle, alt_lock);
                }

                else if(kbe.code == KEY_RIGHTALT){
                    if (alt_lock){
                        alt_lock = 0;
                    }
                    else if(!alt_toggle){
                        alt_toggle = 1;
                    }
                    else if (alt_toggle){
                        alt_lock = 1;
                        alt_toggle = 0;
                    }
                    __android_log_print(ANDROID_LOG_INFO, "UINPUT-TITAN-KB-MON-THREAD", "alt_toggle = %d, alt_lock = %d\n", alt_toggle, alt_lock);
                    __android_log_print(ANDROID_LOG_INFO, "UINPUT-TITAN-KB-MON-THREAD", "shift_toggle = %d, shift_lock = %d\n", shift_toggle, shift_lock);
                }
                else if (kbe.code == KEY_ENTER) {
                    isSwipeActivated = false;
                }
                else{
                    if(shift_toggle){
                        shift_toggle = 0;
                    }
                    if(alt_toggle){
                        alt_toggle = 0;
                    }
                    __android_log_print(ANDROID_LOG_INFO, "UINPUT-TITAN-KB-MON-THREAD", "shift_toggle = %d, alt_toggle = %d\n", shift_toggle, alt_toggle);
                }
            }/*
            // for holds we want to act on key up
            else if(kbe.type == EV_KEY && kbe.value == 0){
                test_time = now() - last_saw_function;
                __android_log_print(ANDROID_LOG_INFO, "UINPUT-TITAN-KB-MON-THREAD", "test_time = %"PRIu64" hold_time = %"PRIu64"\n", test_time, hold_time );
                if(kbe.code == KEY_APPSELECT && (test_time < hold_time)){
                    __android_log_print(ANDROID_LOG_INFO, "UINPUT-TITAN-KB-MON-THREAD", "sending alt and shift\n");
                    if(shift_toggle || shift_lock){
                        injectKey(fd, KEY_RIGHTALT);
                    }
                    if(alt_toggle || alt_lock){
                        injectKey(fd, KEY_LEFTSHIFT);
                    }
                    else{
                        injectKey(fd, KEY_RIGHTALT);
                        injectKey(fd, KEY_LEFTSHIFT);
                    }
                    saw_function = 0;
                }

                else if(kbe.code == KEY_APPSELECT && (test_time >= hold_time)){
                    __android_log_print(ANDROID_LOG_INFO, "UINPUT-TITAN-KB-MON-THREAD", "sending appselect on ufd\n");
                    injectKey(ufd, KEY_APPSELECT);
                    saw_function = 0;
                }

            }*/
        }
    }
    __android_log_print(ANDROID_LOG_INFO, "UINPUT-TITAN-KB-MON-THREAD", "error, returning\n");
    return NULL;
}

bool parseScreenDimensionInformation(){
    FILE * fp;
    char path[1035];

    //Execute command to get dump of screen information
    //Slim:   mBaseDisplayInfo=DisplayInfo{"Built-in Screen", displayId 0", displayGroupId 0, FLAG_SECURE, FLAG_SUPPORTS_PROTECTED_BUFFERS, FLAG_TRUSTED, real 768 x 1280, largest app 768 x 1280, smallest app 768 x 1280, appVsyncOff 8300000, presDeadline 9366667, mode 1, defaultMode 1, modes [{id=1, width=768, height=1280, fps=60.0, alternativeRefreshRates=[]}], hdrCapabilities HdrCapabilities{mSupportedHdrTypes=[], mMaxLuminance=500.0, mMaxAverageLuminance=500.0, mMinLuminance=0.0}, userDisabledHdrTypes [], minimalPostProcessingSupported false, rotation 0, state ON, type INTERNAL, uniqueId "local:0", app 768 x 1280, density 320 (375.138 x 349.591) dpi, layerStack 0, colorMode 0, supportedColorModes [0], address {port=0}, deviceProductInfo null, removeMode 0, refreshRateOverride 0.0, brightnessMinimum 0.0, brightnessMaximum 1.0, brightnessDefault 0.4, installOrientation ROTATION_0}
    fp = popen("su -c dumpsys display | grep mBaseDisplayInfo", "r");
    if(fp == NULL)
    {
        LOGI("Failed to read display information.");
        exit(1);
    }

    char output[2000] = "";
    char output2[2000] = "";
    const char token[] = ",";
    //Get output from fp and concatnate it into output
    /* Read the output a line at a time - output it. */
    while (fgets(path, sizeof(path), fp) != NULL) {
        strcat(output, path);
    }

    /* close */
    pclose(fp);

    //Log Output
//    LOGI(output);

    //Copy for manipulation
    strcpy(output2, output);

    //Pull " real 768 x 1280" from output2
    char* str = strtok(output2, token);
    char value[100];
    while (str != NULL) {
        LOGI(" %s\n", str);
        if(strstr(str, "real"))
        {
            //value = str;
            strcpy(value,str);
            break;
        }
        str = strtok(NULL, token);
    }

    //Strip value down to dimensions
    char sub[100];
    int c = 0;
    int len = *(&value+1)-value;
    while (c < len) {
      sub[c] = value[7+c-1];
      c++;
    }

    //Parse Dimensions into screen_width and screen_height
    char width[10], height[10];
    int count = 0;
    char* ptr = strtok(sub, "x");
    do{
        //LOGI("LOG:%s",ptr);
        if(count == 0)
        {
            strcpy(width,ptr);
            screen_width = atoi(width);
        }
        else
        {
            strcpy(height,ptr);
            screen_height = atoi(height);
        }
        count++;
    }
    while(ptr = strtok(NULL, "x "));

    //LOGI("'%s'", value);
    //LOGI("'%s'", sub);
    //LOGI("Width:'%s'", width);
    //LOGI("Height:%s'", height);
    LOGI("Screen Width Detected:'%d'", screen_width);
    LOGI("Screen Height Detected:'%d'", screen_height);

    if(screen_width == 0 || screen_height == 0)
    {
        return false;
    }

    return true;
}

device_type getDeviceType() {
    device_type device = NOTSET;
    if(screen_height == 1440 && screen_width == 1440)
    {
        device = TITAN;
    }
    else if (screen_height == 1280 && screen_width == 768)
    {
        device = SLIM;
    }
    else if (screen_height == 720 && screen_width == 720)
    {
        device = POCKET;
    }
    return device;
}

void prepareDevice(device_type dev) {

    if(dev == SLIM) {
        y_multiplier = 2.5;
    }

}

int main() {
    LOGI("start\n");

    bool gotScreenDimensions = parseScreenDimensionInformation();
    if(!gotScreenDimensions)
    {
        LOGE("Could not parse display dimensions.");
        exit(1);
    }

    device_type device = getDeviceType();
    if(device == NOTSET)
    {
        LOGE("Device could not be detected.");
        exit(1);
    }

    dev = device;
    prepareDevice(dev);

    int ufd = uinput_init();
    int origfd = original_input_init();

    LOGI("keyboard thread\n");
    pthread_t keyboard_monitor_thread;
    pthread_create(&keyboard_monitor_thread, NULL, keyboard_monitor, (void*) &ufd);
    LOGI("keyboard thread created\n");

    while(1) {
        struct input_event e;
        if(read(origfd, &e, sizeof(e)) != sizeof(e)) break;
        if(0) switch(e.type) {
            case EV_REL:
                ev_parse_rel(e);
                break;
            case EV_SYN:
                ev_parse_syn(e);
                break;
            case EV_KEY:
                ev_parse_key(e);
                break;
            case EV_ABS:
                ev_parse_abs(e);
                break;
            default:
                fprintf(stderr, "Unknown event type %d\n", e.type);
                break;
        };
        handle(ufd, e);
    }
}


