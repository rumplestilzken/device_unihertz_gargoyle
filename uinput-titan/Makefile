
# get the ndk here:https://developer.android.com/ndk/downloads

ANDROID_NDK ?= ~/android-ndk/
LOCAL_LDLIBS := -llog

uinput-titan: uinput-titan.c
	$(ANDROID_NDK)toolchains/llvm/prebuilt/linux-x86_64/bin/clang uinput-titan.c -o uinput-titan -Wall -Wextra -Wl,-llog -I/home/nick/dev/Android/Sdk/ndk/25.2.9519653/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include/

clean: uinput-titan
	rm uinput-titan
