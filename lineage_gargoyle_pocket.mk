$(call inherit-product, device/unihertz/common.mk)

#Treble
#PRODUCT_FULL_TREBLE :=  true
#PRODUCT_FULL_TREBLE_OVERRIDE := true

#PRODUCT_RELEASE_NAME := Titan

# Device identifier. This must come after all inclusions
#PRODUCT_DEVICE = gargoyle
#PRODUCT_BRAND = Unihertz
#PRODUCT_SYSTEM_BRAND = Unihertz
#PRODUCT_MANUFACTURER = A-gold
#PRODUCT_NAME = Titan
#PRODUCT_MODEL = Titan

RESOURCE_PATH := device/unihertz/gargoyle_pocket

#Init Scripts
PRODUCT_COPY_FILES += \
	$(RESOURCE_PATH)/rumplestilzken_firstboot.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/rumplestilzken_firstboot.sh \

PRODUCT_COPY_FILES += \
	$(RESOURCE_PATH)/excluded-input-devices.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/excluded-input-devices.xml \

#bootanimation
TARGET_BOOTANIMATION := $(RESOURCE_PATH)/bootanimation.zip

#Copy keyboard files into place.
PRODUCT_COPY_FILES += \
    $(RESOURCE_PATH)/keyboard/system_usr_idc/aw9523-key.idc:$(TARGET_COPY_OUT_SYSTEM)/usr/idc/aw9523-key.idc \
	$(RESOURCE_PATH)/keyboard/system_usr_idc/mtk-kpd.idc:$(TARGET_COPY_OUT_SYSTEM)/usr/idc/mtk-kpd.idc \
	$(RESOURCE_PATH)/keyboard/system_usr_idc/mtk-pad.idc:$(TARGET_COPY_OUT_SYSTEM)/usr/idc/mtk-pad.idc \
	$(RESOURCE_PATH)/keyboard/system_usr_idc/qwerty.idc:$(TARGET_COPY_OUT_SYSTEM)/usr/idc/qwerty.idc \
	$(RESOURCE_PATH)/keyboard/system_usr_idc/qwerty2.idc:$(TARGET_COPY_OUT_SYSTEM)/usr/idc/qwerty2.idc \
	$(RESOURCE_PATH)/keyboard/system_usr_idc/titan-uinput.idc:$(TARGET_COPY_OUT_SYSTEM)/usr/idc/titan-uinput.idc \
	$(RESOURCE_PATH)/keyboard/system_usr_keychars/aw9523-key.kcm:$(TARGET_COPY_OUT_SYSTEM)/usr/keychars/aw9523-key.kcm \
	$(RESOURCE_PATH)/keyboard/system_usr_keychars/Generic.kcm:$(TARGET_COPY_OUT_SYSTEM)/usr/keychars/Generic.kcm \
	$(RESOURCE_PATH)/keyboard/system_usr_keychars/qwerty.kcm:$(TARGET_COPY_OUT_SYSTEM)/usr/keychars/qwerty.kcm \
	$(RESOURCE_PATH)/keyboard/system_usr_keychars/qwerty2.kcm:$(TARGET_COPY_OUT_SYSTEM)/usr/keychars/qwerty2.kcm \
	$(RESOURCE_PATH)/keyboard/system_usr_keychars/Virtual.kcm:$(TARGET_COPY_OUT_SYSTEM)/usr/keychars/Virtual.kcm \
	$(RESOURCE_PATH)/keyboard/system_usr_keylayout/Generic.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/Generic.kl \
	$(RESOURCE_PATH)/keyboard/system_usr_keylayout/aw9523-key.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/aw9523-key.kl \
	$(RESOURCE_PATH)/keyboard/system_usr_keylayout/AVRCP.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/AVRCP.kl \
	$(RESOURCE_PATH)/keyboard/system_usr_keylayout/qwerty.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/qwerty.kl \
	$(RESOURCE_PATH)/keyboard/system_usr_keylayout/mtk-kpd.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/mtk-kpd.kl

KIKA := device/unihertz/prebuilt/kika-input/

#lib
PRODUCT_COPY_FILES += \
	$(KIKA)/lib/libChangjieD1.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libChangjieD1.so \
   	$(KIKA)/lib/libChangjieH1.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libChangjieH1.so \
	$(KIKA)/lib/libChsPinyin.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libChsPinyin.so \
	$(KIKA)/lib/libChtZhuyin.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libChtZhuyin.so \
	$(KIKA)/lib/libDutch.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libDutch.so \
	$(KIKA)/lib/libEnglish_GB.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libEnglish_GB.so \
	$(KIKA)/lib/libEnglish.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libEnglish.so \
	$(KIKA)/lib/libFrench_FR.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libFrench_FR.so \
	$(KIKA)/lib/libGerman.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libGerman.so \
	$(KIKA)/lib/libIdiomTD.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libIdiomTD.so \
	$(KIKA)/lib/libIdiomTH.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libIdiomTH.so \
	$(KIKA)/lib/libIQQI-jni-Resource.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libIQQI-jni-Resource.so \
	$(KIKA)/lib/libiqqijni.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libiqqijni.so \
	$(KIKA)/lib/libiqqipy.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libiqqipy.so \
	$(KIKA)/lib/libItalian.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libItalian.so \
	$(KIKA)/lib/libjni_kikaime.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libjni_kikaime.so \
	$(KIKA)/lib/libmjp.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libmjp.so \
	$(KIKA)/lib/libPortuguese_PT.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libPortuguese_PT.so \
	$(KIKA)/lib/libRussian.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libRussian.so \
	$(KIKA)/lib/libSpanish_ES.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libSpanish_ES.so \

#lib64
PRODUCT_COPY_FILES += \
	$(KIKA)/lib64/libChangjieD1.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libChangjieD1.so \
   	$(KIKA)/lib64/libChangjieH1.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libChangjieH1.so \
	$(KIKA)/lib64/libChsPinyin.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libChsPinyin.so \
	$(KIKA)/lib64/libChtZhuyin.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libChtZhuyin.so \
	$(KIKA)/lib64/libDutch.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libDutch.so \
	$(KIKA)/lib64/libEnglish_GB.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libEnglish_GB.so \
	$(KIKA)/lib64/libEnglish.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libEnglish.so \
	$(KIKA)/lib64/libFrench_FR.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libFrench_FR.so \
	$(KIKA)/lib64/libGerman.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libGerman.so \
	$(KIKA)/lib64/libIdiomTD.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libIdiomTD.so \
	$(KIKA)/lib64/libIdiomTH.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libIdiomTH.so \
	$(KIKA)/lib64/libIQQI-jni-Resource.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libIQQI-jni-Resource.so \
	$(KIKA)/lib64/libiqqijni.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libiqqijni.so \
	$(KIKA)/lib64/libiqqipy.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libiqqipy.so \
	$(KIKA)/lib64/libItalian.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libItalian.so \
	$(KIKA)/lib64/libjni_kikaime.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libjni_kikaime.so \
	$(KIKA)/lib64/libmjp.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libmjp.so \
	$(KIKA)/lib64/libPortuguese_PT.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libPortuguese_PT.so \
	$(KIKA)/lib64/libRussian.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libRussian.so \
	$(KIKA)/lib64/libSpanish_ES.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libSpanish_ES.so \

#IMS
PRODUCT_PACKAGES += \
    MTK-IMS-R \
	KeyMapper
