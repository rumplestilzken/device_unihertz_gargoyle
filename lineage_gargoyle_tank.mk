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

RESOURCE_PATH := device/unihertz/gargoyle_tank

#Init Scripts
PRODUCT_COPY_FILES += \
	$(RESOURCE_PATH)/rumplestilzken_firstboot.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/rumplestilzken_firstboot.rc \
	$(RESOURCE_PATH)/rumplestilzken_firstboot.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/rumplestilzken_firstboot.sh \

#Install Kika as system app
#PRODUCT_PACKAGES += \
#	Kika-Keyboard_com.iqqijni.bbkeyboard \
