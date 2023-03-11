$(call inherit-product, device/lineage/gsi/lineage_gsi_arm64_vN.mk)

#Copy keyboard files into place.
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/keyboard/system_usr_idc/aw9523-key.idc:$(TARGET_COPY_OUT_SYSTEM)/usr/idc/aw9523-key.idc \
		$(LOCAL_PATH)/keyboard/system_usr_idc/mtk-kpd.idc:$(TARGET_COPY_OUT_SYSTEM)/usr/idc/mtk-kpd.idc \
		$(LOCAL_PATH)/keyboard/system_usr_idc/mtk-pad.idc:$(TARGET_COPY_OUT_SYSTEM)/usr/idc/mtk-pad.idc \
		$(LOCAL_PATH)/keyboard/system_usr_keychars/aw9523-key.kcm:$(TARGET_COPY_OUT_SYSTEM)/usr/keychars/aw9523-key.kcm \
		$(LOCAL_PATH)/keyboard/system_usr_keylayout/Generic.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/Generic.kl \
		$(LOCAL_PATH)/keyboard/system_usr_keylayout/mtk-kpd.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/mtk-kpd.kl
