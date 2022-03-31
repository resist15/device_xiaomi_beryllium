#
# Copyright (C) 2023 Paranoid Android
#
# SPDX-License-Identifier: Apache-2.0
#

# Board Platform
TARGET_BOARD_PLATFORM := sdm845

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += $(LOCAL_PATH)

# Inherit the proprietary files
$(call inherit-product, vendor/xiaomi/beryllium/beryllium-vendor.mk)
