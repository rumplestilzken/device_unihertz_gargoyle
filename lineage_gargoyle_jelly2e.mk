$(call inherit-product, device/unihertz/common.mk)

RESOURCE_PATH := device/unihertz/gargoyle_jelly2e

#Init Scripts
PRODUCT_COPY_FILES += \
	$(RESOURCE_PATH)/rumplestilzken_firstboot.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/rumplestilzken_firstboot.sh \

#bootanimation
TARGET_BOOTANIMATION := $(RESOURCE_PATH)/bootanimation.zip

#IMS
PRODUCT_PACKAGES += \
    MTK-IMS-R \
