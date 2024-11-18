#pragma once

#include <jni.h>

#ifdef __cplusdplus
extern "C" {
#endif
    JNIEXPORT void JNICALL Java_com_rumplestilzken_gargoylesettings_provider_NativeProvider_setupNativeBindings(JNIEnv* env, jobject obj);
#ifdef __cplusplus
}
#endif

static uint64_t lastKbdTimestamp;