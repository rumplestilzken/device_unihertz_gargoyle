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

RESOURCE_PATH := device/unihertz/gargoyle_slim

#Init Scripts
PRODUCT_COPY_FILES += \
	$(RESOURCE_PATH)/rumplestilzken_firstboot.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/rumplestilzken_firstboot.sh \

PRODUCT_COPY_FILES += \
	$(RESOURCE_PATH)/excluded-input-devices.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/excluded-input-devices.xml \

PRODUCT_COPY_FILES += \
	$(RESOURCE_PATH)/bootanimation.zip:$(TARGET_COPY_OUT_SYSTEM)/product/bootanimation.zip \
	$(RESOURCE_PATH)/bootanimation.zip:$(TARGET_COPY_OUT_SYSTEM)/product/bootanimation-dark.zip

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
	
#Install Kika as system app
#PRODUCT_PACKAGES += \
#	Kika-Keyboard_com.iqqijni.bbkeyboard \
