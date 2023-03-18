PRODUCT_RELEASE_NAME := Titan

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE = gargoyle
PRODUCT_BRAND = Unihertz
PRODUCT_SYSTEM_BRAND = Unihertz
PRODUCT_MANUFACTURER = A-gold
PRODUCT_NAME = Titan
PRODUCT_MODEL = Titan

LOCAL_PATH := device/unihertz/

RESOURCE_PATH := device/unihertz/

#Copy keyboard files into place.
PRODUCT_COPY_FILES += \
    $(RESOURCE_PATH)/keyboard/system_usr_idc/aw9523-key.idc:$(TARGET_COPY_OUT_SYSTEM)/usr/idc/aw9523-key.idc \
		$(RESOURCE_PATH)/keyboard/system_usr_idc/mtk-kpd.idc:$(TARGET_COPY_OUT_SYSTEM)/usr/idc/mtk-kpd.idc \
		$(RESOURCE_PATH)/keyboard/system_usr_idc/mtk-pad.idc:$(TARGET_COPY_OUT_SYSTEM)/usr/idc/mtk-pad.idc \
		$(RESOURCE_PATH)/keyboard/system_usr_keychars/aw9523-key.kcm:$(TARGET_COPY_OUT_SYSTEM)/usr/keychars/aw9523-key.kcm \
		$(RESOURCE_PATH)/keyboard/system_usr_keylayout/Generic.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/Generic.kl \
		$(RESOURCE_PATH)/keyboard/system_usr_keylayout/mtk-kpd.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/mtk-kpd.kl

# # make file for new hardware  from
# #
# LOCAL_PATH := $(call my-dir)
# #
# # this is here to use the pre-built kernel
# ifeq ($(TARGET_PREBUILT_KERNEL),)
# TARGET_PREBUILT_KERNEL := $(LOCAL_PATH)/kernel
# endif
# #
# file := $(INSTALLED_KERNEL_TARGET)
# ALL_PREBUILT += $(file)
# $(file): $(TARGET_PREBUILT_KERNEL) | $(ACP)
# $(transform-prebuilt-to-target)
# #
# # no boot loader, so we don't need any of that stuff..
# #
# LOCAL_PATH := device/unihertz/gargoyle
# #
# include $(CLEAR_VARS)
# #
# # include more board specific stuff here? Such as Audio parameters.
# #
