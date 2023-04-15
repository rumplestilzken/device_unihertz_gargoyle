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

RESOURCE_PATH := device/unihertz/gargoyle/

#SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += device/unihertz/gargoyle/sepolicy

#Init Scripts
PRODUCT_COPY_FILES += \
	$(RESOURCE_PATH)/rumplestilzken_firstboot.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/rumplestilzken_firstboot.sh \

#Copy keyboard files into place.
PRODUCT_COPY_FILES += \
    $(RESOURCE_PATH)/keyboard/system_usr_idc/aw9523-key.idc:$(TARGET_COPY_OUT_SYSTEM)/usr/idc/aw9523-key.idc \
	$(RESOURCE_PATH)/keyboard/system_usr_idc/mtk-kpd.idc:$(TARGET_COPY_OUT_SYSTEM)/usr/idc/mtk-kpd.idc \
	$(RESOURCE_PATH)/keyboard/system_usr_idc/mtk-pad.idc:$(TARGET_COPY_OUT_SYSTEM)/usr/idc/mtk-pad.idc \
	$(RESOURCE_PATH)/keyboard/system_usr_keychars/aw9523-key.kcm:$(TARGET_COPY_OUT_SYSTEM)/usr/keychars/aw9523-key.kcm \
	$(RESOURCE_PATH)/keyboard/system_usr_keylayout/Generic.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/Generic.kl \
	$(RESOURCE_PATH)/keyboard/system_usr_keylayout/mtk-kpd.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/mtk-kpd.kl

#Install Kika as system app
#PRODUCT_PACKAGES += \
#	Kika-Keyboard_com.iqqijni.bbkeyboard \
