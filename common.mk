RESOURCE_PATH := device/unihertz/

#Init Scripts
PRODUCT_COPY_FILES += \
	$(RESOURCE_PATH)/rumplestilzken_firstboot.rc:$(TARGET_COPY_OUT_SYSTEM)/bin/rumplestilzken_firstboot.rc \


PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    persist.restricted_networking_mode=0 \
    persist.rumplestilzken.settings=true \
