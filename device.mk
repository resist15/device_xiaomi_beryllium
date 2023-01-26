#
# Copyright (C) 2023 Paranoid Android
#
# SPDX-License-Identifier: Apache-2.0
#

# Board Platform
TARGET_BOARD_PLATFORM := sdm845

# Input
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/idc/uinput-fpc.idc:system/usr/idc/uinput-fpc.idc \
    $(LOCAL_PATH)/configs/idc/uinput-goodix.idc:system/usr/idc/uinput-goodix.idc

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
    $(LOCAL_PATH)/configs/keylayout/sdm845-tavil-snd-card_Button_Jack.kl:system/usr/keylayout/sdm845-tavil-snd-card_Button_Jack.kl \
    $(LOCAL_PATH)/configs/keylayout/uinput-fpc.kl:system/usr/keylayout/uinput-fpc.kl \
    $(LOCAL_PATH)/configs/keylayout/uinput-goodix.kl:system/usr/keylayout/uinput-goodix.kl

# Kernel
TARGET_KERNEL_VERSION := 4.9

# Media
PRODUCT_SYSTEM_PROPERTIES += \
    debug.stagefright.omx_default_rank.sw-audio=1

# Native libraries whitelist
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/public.libraries.txt:$(TARGET_COPY_OUT_VENDOR)/etc/public.libraries.txt

# Overlays
PRODUCT_PACKAGES += \
    AOSPABerylliumFrameworksOverlay \
    BerylliumCarrierConfigOverlay \
    BerylliumFrameworksOverlay \
    BerylliumNoCutoutOverlay \
    BerylliumSettingsOverlay \
    BerylliumSystemUIOverlay \
    BerylliumWifiOverlay 

# Protobuf
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full-vendorcompat \
    libprotobuf-cpp-lite-vendorcompat

# QTI common
TARGET_COMMON_QTI_COMPONENTS := \
    media \
    overlay \
    wlan

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += $(LOCAL_PATH)

# WLAN
PRODUCT_PACKAGES += \
    libwpa_client 

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/wifi/,$(TARGET_COPY_OUT_VENDOR)/etc/wifi)

# Inherit the proprietary files
$(call inherit-product, vendor/xiaomi/beryllium/beryllium-vendor.mk)
