LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := uinput-titan
LOCAL_MODULE_HOST_OS := linux

LOCAL_CPPFLAGS := -Wall -Wextra -Wl
LOCAL_LDLIBS := -llog

LOCAL_SRC_FILES := uinput-titan.c

include $(BUILD_EXECUTABLE)

clean: uinput-titan
	rm -rf libs obj
