
# get the ndk here:https://developer.android.com/ndk/downloads

export NDK_PROJECT_PATH=$(pwd)
export ANDROID_NDK ?= /home/nick/Android/Sdk/ndk/28.0.12433566/
LOCAL_LDLIBS := -llog

uinput-titan: uinput-titan.c
	$(ANDROID_NDK)toolchains/llvm/prebuilt/linux-x86_64/bin/clang uinput-titan.c -o uinput-titan -Wall -Wextra -Wl,-llog -I$(ANDROID_NDK)/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include/ -L$(ANDROID_NDK)/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/aarch64-linux-android/28

clean: uinput-titan
	rm -rf libs obj
