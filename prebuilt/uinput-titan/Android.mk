LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := jni_titanprebuilt
LOCAL_SRC_FILES := libjni_titan.so
LOCAL_SHARED_LIBRARIES := liblog libstdc++
LOCAL_MODULE_TAGS := optional
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_SRC_FILES := uinput-titan
LOCAL_MODULE := uinput-titan
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_SHARED_LIBRARIES := liblog libstdc++
LOCAL_MODULE_TAGS := optional
include $(BUILD_PREBUILT)