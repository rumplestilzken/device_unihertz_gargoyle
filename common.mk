RESOURCE_PATH := device/unihertz/

#BOARD_VENDOR_SEPOLICY_DIRS += device/unihertz/sepolicy

TARGET_NO_KERNEL_OVERRIDE := true

#Init Scripts
PRODUCT_COPY_FILES += \
	$(RESOURCE_PATH)/init/rumplestilzken_firstboot.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/rumplestilzken_firstboot.rc \
	$(RESOURCE_PATH)/init/rumplestilzken_uinput-titan.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/rumplestilzken_uinput-titan.rc \

#Allow resigned images.
PRODUCT_BROKEN_VERIFY_USES_LIBRARIES := true

PRODUCT_PACKAGES += \
    uinput-titan \
    gargoyleSettings \
    Kika-Input \
    OpenCamera \

#PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
#    persist.restricted_networking_mode=0 \
#    persist.rumplestilzken.settings=true \
