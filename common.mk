RESOURCE_PATH := device/unihertz/

#BOARD_VENDOR_SEPOLICY_DIRS += device/unihertz/sepolicy

#Init Scripts
PRODUCT_COPY_FILES += \
	$(RESOURCE_PATH)/init/rumplestilzken_firstboot.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/rumplestilzken_firstboot.rc \
	$(RESOURCE_PATH)/init/rumplestilzken_uinput-titan.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/rumplestilzken_uinput-titan.rc \

#Kika-Input
KIKA_PATH += $(RESOURCE_PATH)/prebuilt/kika-input/
#lib
PRODUCT_COPY_FILES += \
	$(KIKA_PATH)/lib/libChangjieD1.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libChangjieD1.so \
   	$(KIKA_PATH)/lib/libChangjieH1.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libChangjieH1.so \
	$(KIKA_PATH)/lib/libChsPinyin.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libChsPinyin.so \
	$(KIKA_PATH)/lib/libChtZhuyin.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libChtZhuyin.so \
	$(KIKA_PATH)/lib/libDutch.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libDutch.so \
	$(KIKA_PATH)/lib/libEnglish_GB.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libEnglish_GB.so \
	$(KIKA_PATH)/lib/libEnglish.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libEnglish.so \
	$(KIKA_PATH)/lib/libFrench_FR.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libFrench_FR.so \
	$(KIKA_PATH)/lib/libGerman.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libGerman.so \
	$(KIKA_PATH)/lib/libIdiomTD.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libIdiomTD.so \
	$(KIKA_PATH)/lib/libIdiomTH.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libIdiomTH.so \
	$(KIKA_PATH)/lib/libIQQI-jni-Resource.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libIQQI-jni-Resource.so \
	$(KIKA_PATH)/lib/libiqqijni.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libiqqijni.so \
	$(KIKA_PATH)/lib/libiqqipy.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libiqqipy.so \
	$(KIKA_PATH)/lib/libItalian.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libItalian.so \
	$(KIKA_PATH)/lib/libjni_kikaime.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libjni_kikaime.so \
	$(KIKA_PATH)/lib/libmjp.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libmjp.so \
	$(KIKA_PATH)/lib/libPortuguese_PT.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libPortuguese_PT.so \
	$(KIKA_PATH)/lib/libRussian.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libRussian.so \
	$(KIKA_PATH)/lib/libSpanish_ES.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libSpanish_ES.so \

#lib64
PRODUCT_COPY_FILES += \
	$(KIKA_PATH)/lib64/libChangjieD1.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libChangjieD1.so \
   	$(KIKA_PATH)/lib64/libChangjieH1.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libChangjieH1.so \
	$(KIKA_PATH)/lib64/libChsPinyin.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libChsPinyin.so \
	$(KIKA_PATH)/lib64/libChtZhuyin.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libChtZhuyin.so \
	$(KIKA_PATH)/lib64/libDutch.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libDutch.so \
	$(KIKA_PATH)/lib64/libEnglish_GB.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libEnglish_GB.so \
	$(KIKA_PATH)/lib64/libEnglish.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libEnglish.so \
	$(KIKA_PATH)/lib64/libFrench_FR.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libFrench_FR.so \
	$(KIKA_PATH)/lib64/libGerman.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libGerman.so \
	$(KIKA_PATH)/lib64/libIdiomTD.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libIdiomTD.so \
	$(KIKA_PATH)/lib64/libIdiomTH.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libIdiomTH.so \
	$(KIKA_PATH)/lib64/libIQQI-jni-Resource.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libIQQI-jni-Resource.so \
	$(KIKA_PATH)/lib64/libiqqijni.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libiqqijni.so \
	$(KIKA_PATH)/lib64/libiqqipy.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libiqqipy.so \
	$(KIKA_PATH)/lib64/libItalian.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libItalian.so \
	$(KIKA_PATH)/lib64/libjni_kikaime.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libjni_kikaime.so \
	$(KIKA_PATH)/lib64/libmjp.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libmjp.so \
	$(KIKA_PATH)/lib64/libPortuguese_PT.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libPortuguese_PT.so \
	$(KIKA_PATH)/lib64/libRussian.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libRussian.so \
	$(KIKA_PATH)/lib64/libSpanish_ES.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libSpanish_ES.so \

#Allow resigned images.
PRODUCT_BROKEN_VERIFY_USES_LIBRARIES := true

PRODUCT_PACKAGES += \
    uinput-titan \
    gargoyleSettings \
    Kika-Input \ 

#PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
#    persist.restricted_networking_mode=0 \
#    persist.rumplestilzken.settings=true \
