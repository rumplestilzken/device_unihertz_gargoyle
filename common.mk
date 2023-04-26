RESOURCE_PATH := device/unihertz/

BOARD_VENDOR_SEPOLICY_DIRS += device/unihertz/sepolicy

#Init Scripts
PRODUCT_COPY_FILES += \
	$(RESOURCE_PATH)/init/rumplestilzken_firstboot.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/rumplestilzken_firstboot.rc \
	$(RESOURCE_PATH)/init/rumplestilzken_uinput-titan.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/rumplestilzken_uinput-titan.rc \

PRODUCT_COPY_FILES += \
	$(RESOURCE_PATH)/prebuilt/uinput-titan:$(TARGET_COPY_OUT_SYSTEM)/bin/uinput-titan \

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    persist.restricted_networking_mode=0 \
    persist.rumplestilzken.settings=true \
