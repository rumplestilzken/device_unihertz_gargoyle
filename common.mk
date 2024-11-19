RESOURCE_PATH := device/unihertz/

# WITH_ADB_INSECURE := true
ALLOW_MISSING_DEPENDENCIES = true

#BOARD_VENDOR_SEPOLICY_DIRS += device/unihertz/sepolicy
# Overlays
DEVICE_PACKAGE_OVERLAYS += $(RESOURCE_PATH)/overlay-lineage

TARGET_NO_KERNEL_OVERRIDE := true

#Init Scripts
PRODUCT_COPY_FILES += \
	$(RESOURCE_PATH)/init/rumplestilzken_firstboot.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/rumplestilzken_firstboot.rc \
	$(RESOURCE_PATH)/init/rumplestilzken_uinput-titan.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/rumplestilzken_uinput-titan.rc \

#Kika-Input
KIKA_PATH += $(RESOURCE_PATH)/prebuilt/kika-input/
#lib
PRODUCT_COPY_FILES += \
	$(KIKA_PATH)/lib/libChangjieD1.so:$(TARGET_COPY_OUT_SYSTEM)/app/lib/libChangjieD1.so \
   	$(KIKA_PATH)/lib/libChangjieH1.so:$(TARGET_COPY_OUT_SYSTEM)/app/lib/libChangjieH1.so \
	$(KIKA_PATH)/lib/libChsPinyin.so:$(TARGET_COPY_OUT_SYSTEM)/app/lib/libChsPinyin.so \
	$(KIKA_PATH)/lib/libChtZhuyin.so:$(TARGET_COPY_OUT_SYSTEM)/app/lib/libChtZhuyin.so \
	$(KIKA_PATH)/lib/libDutch.so:$(TARGET_COPY_OUT_SYSTEM)/app/lib/libDutch.so \
	$(KIKA_PATH)/lib/libEnglish_GB.so:$(TARGET_COPY_OUT_SYSTEM)/app/lib/libEnglish_GB.so \
	$(KIKA_PATH)/lib/libEnglish.so:$(TARGET_COPY_OUT_SYSTEM)/app/lib/libEnglish.so \
	$(KIKA_PATH)/lib/libFrench_FR.so:$(TARGET_COPY_OUT_SYSTEM)/app/lib/libFrench_FR.so \
	$(KIKA_PATH)/lib/libGerman.so:$(TARGET_COPY_OUT_SYSTEM)/app/lib/libGerman.so \
	$(KIKA_PATH)/lib/libIdiomTD.so:$(TARGET_COPY_OUT_SYSTEM)/app/lib/libIdiomTD.so \
	$(KIKA_PATH)/lib/libIdiomTH.so:$(TARGET_COPY_OUT_SYSTEM)/app/lib/libIdiomTH.so \
	$(KIKA_PATH)/lib/libIQQI-jni-Resource.so:$(TARGET_COPY_OUT_SYSTEM)/app/lib/libIQQI-jni-Resource.so \
	$(KIKA_PATH)/lib/libiqqijni.so:$(TARGET_COPY_OUT_SYSTEM)/app/lib/libiqqijni.so \
	$(KIKA_PATH)/lib/libiqqipy.so:$(TARGET_COPY_OUT_SYSTEM)/app/lib/libiqqipy.so \
	$(KIKA_PATH)/lib/libItalian.so:$(TARGET_COPY_OUT_SYSTEM)/app/lib/libItalian.so \
	$(KIKA_PATH)/lib/libjni_kikaime.so:$(TARGET_COPY_OUT_SYSTEM)/app/lib/libjni_kikaime.so \
	$(KIKA_PATH)/lib/libmjp.so:$(TARGET_COPY_OUT_SYSTEM)/app/lib/libmjp.so \
	$(KIKA_PATH)/lib/libPortuguese_PT.so:$(TARGET_COPY_OUT_SYSTEM)/app/lib/libPortuguese_PT.so \
	$(KIKA_PATH)/lib/libRussian.so:$(TARGET_COPY_OUT_SYSTEM)/app/lib/libRussian.so \
	$(KIKA_PATH)/lib/libSpanish_ES.so:$(TARGET_COPY_OUT_SYSTEM)/app/lib/libSpanish_ES.so \

#lib64
PRODUCT_COPY_FILES += \
	$(KIKA_PATH)/lib64/libChangjieD1.so:$(TARGET_COPY_OUT_SYSTEM)/app/lib64/libChangjieD1.so \
   	$(KIKA_PATH)/lib64/libChangjieH1.so:$(TARGET_COPY_OUT_SYSTEM)/app/lib64/libChangjieH1.so \
	$(KIKA_PATH)/lib64/libChsPinyin.so:$(TARGET_COPY_OUT_SYSTEM)/app/lib64/libChsPinyin.so \
	$(KIKA_PATH)/lib64/libChtZhuyin.so:$(TARGET_COPY_OUT_SYSTEM)/app/lib64/libChtZhuyin.so \
	$(KIKA_PATH)/lib64/libDutch.so:$(TARGET_COPY_OUT_SYSTEM)/app/lib64/libDutch.so \
	$(KIKA_PATH)/lib64/libEnglish_GB.so:$(TARGET_COPY_OUT_SYSTEM)/app/lib64/libEnglish_GB.so \
	$(KIKA_PATH)/lib64/libEnglish.so:$(TARGET_COPY_OUT_SYSTEM)/app/lib64/libEnglish.so \
	$(KIKA_PATH)/lib64/libFrench_FR.so:$(TARGET_COPY_OUT_SYSTEM)/app/lib64/libFrench_FR.so \
	$(KIKA_PATH)/lib64/libGerman.so:$(TARGET_COPY_OUT_SYSTEM)/app/lib64/libGerman.so \
	$(KIKA_PATH)/lib64/libIdiomTD.so:$(TARGET_COPY_OUT_SYSTEM)/app/lib64/libIdiomTD.so \
	$(KIKA_PATH)/lib64/libIdiomTH.so:$(TARGET_COPY_OUT_SYSTEM)/app/lib64/libIdiomTH.so \
	$(KIKA_PATH)/lib64/libIQQI-jni-Resource.so:$(TARGET_COPY_OUT_SYSTEM)/app/lib64/libIQQI-jni-Resource.so \
	$(KIKA_PATH)/lib64/libiqqijni.so:$(TARGET_COPY_OUT_SYSTEM)/app/lib64/libiqqijni.so \
	$(KIKA_PATH)/lib64/libiqqipy.so:$(TARGET_COPY_OUT_SYSTEM)/app/lib64/libiqqipy.so \
	$(KIKA_PATH)/lib64/libItalian.so:$(TARGET_COPY_OUT_SYSTEM)/app/lib64/libItalian.so \
	$(KIKA_PATH)/lib64/libjni_kikaime.so:$(TARGET_COPY_OUT_SYSTEM)/app/lib64/libjni_kikaime.so \
	$(KIKA_PATH)/lib64/libmjp.so:$(TARGET_COPY_OUT_SYSTEM)/app/lib64/libmjp.so \
	$(KIKA_PATH)/lib64/libPortuguese_PT.so:$(TARGET_COPY_OUT_SYSTEM)/app/lib64/libPortuguese_PT.so \
	$(KIKA_PATH)/lib64/libRussian.so:$(TARGET_COPY_OUT_SYSTEM)/app/lib64/libRussian.so \
	$(KIKA_PATH)/lib64/libSpanish_ES.so:$(TARGET_COPY_OUT_SYSTEM)/app/lib64/libSpanish_ES.so \

#Allow resigned images.
PRODUCT_BROKEN_VERIFY_USES_LIBRARIES := true

PRODUCT_PACKAGES += \
    uinput-titan \
    gargoyleSettings \
    Kika-Input \
    OpenCamera \

PRODUCT_SYSTEM_PROPERTIES += \
    ro.system.ota.json_url="https://github.com/rumplestilzken/unihertz_titan_lineageos20/releases/download/ota/ota.json"
