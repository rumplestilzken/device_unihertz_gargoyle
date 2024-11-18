#include <jni.h>

class JNIProvider {
    public:
    JNIEXPORT void JNICALL Java_com_rumplestilzken_gargoylesettings_provider_NativeProvider_setupNativeBindings(JNIEnv* env, jobject obj);

    JNIEnv * e;
    jobject jobj;
}