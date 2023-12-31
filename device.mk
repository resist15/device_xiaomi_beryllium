#
# Copyright (C) 2023 Paranoid Android
#
# SPDX-License-Identifier: Apache-2.0
#

# AID/fs configs
PRODUCT_PACKAGES += \
    fs_config_files

# Audio
PRODUCT_PACKAGES += \
    android.hardware.audio@5.0-impl:32 \
    android.hardware.audio.effect@5.0-impl:32 \
    android.hardware.audio.service \
    android.hardware.soundtrigger@2.2-impl:32 

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/audio/,$(TARGET_COPY_OUT_VENDOR)/etc)

PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/config/a2dp_in_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_in_audio_policy_configuration.xml 

PRODUCT_ODM_PROPERTIES += \
    ro.vendor.audio.sdk.fluencetype=fluence 

PRODUCT_SYSTEM_PROPERTIES += \
    audio.deep_buffer.media=true \
    audio.offload.min.duration.secs=30 \
    audio.offload.video=true \
    ro.af.client_heap_size_kbyte=7168 \
    ro.config.vc_call_vol_steps=11

PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.audio.button_jack.profile=volume \
    persist.vendor.audio.button_jack.switch=0 \
    ro.vendor.audio.soundfx.usb=true \
    vendor.audio.noisy.broadcast.delay=600 \
    vendor.audio.offload.pstimeout.secs=3 

# Bluetooth
PRODUCT_SYSTEM_PROPERTIES += \
    persist.bluetooth.a2dp_offload.disabled=false \
    persist.vendor.bt.a2dp.aac_whitelist=false \
    persist.vendor.btstack.enable.twsplus=true \
    persist.vendor.btstack.enable.twsplussho=true \
    ro.bluetooth.a2dp_offload.supported=true \
    vendor.bluetooth.soc=cherokee 

PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.qcom.bluetooth.enable.splita2dp=true \
    persist.vendor.qcom.bluetooth.a2dp_offload_cap=sbc-aptx-aptxtws-aptxhd-aac-ldac \
    persist.vendor.qcom.bluetooth.aac_frm_ctl.enabled=true \
    persist.vendor.qcom.bluetooth.twsp_state.enabled=false \
    vendor.qcom.bluetooth.soc=cherokee

# Board Platform
TARGET_BOARD_PLATFORM := sdm845

# Camera
PRODUCT_PACKAGES += \
    android.hardware.camera.provider@2.4-impl:32 \
    android.hardware.camera.provider@2.4-service \
    libpiex_shim_beryllium \
    libdng_sdk.vendor \
    vendor.qti.hardware.camera.device@1.0.vendor

PRODUCT_SYSTEM_PROPERTIES += \
    camera.disable_zsl_mode=true \
    persist.vendor.camera.perfcapture=1 \
    vendor.camera.aux.packagelist=org.codeaurora.snapcam,com.android.camera,co.aospa.sense

# Context Hub
PRODUCT_PACKAGES += \
    android.hardware.contexthub@1.0-impl.generic \
    android.hardware.contexthub@1.0-service

# Control groups and task profiles
PRODUCT_COPY_FILES += \
    system/core/libprocessgroup/profiles/cgroups_28.json:$(TARGET_COPY_OUT_VENDOR)/etc/cgroups.json \
    system/core/libprocessgroup/profiles/task_profiles_28.json:$(TARGET_COPY_OUT_VENDOR)/etc/task_profiles.json

# Data modules
PRODUCT_SYSTEM_PROPERTIES += \
    persist.data.df.dev_name=rmnet_usb0 \
    persist.vendor.data.mode=concurrent \
    ro.vendor.use_data_netmgrd=true

# Display post-processing
PRODUCT_SYSTEM_PROPERTIES += \
    ro.qualcomm.cabl=0 \
    ro.vendor.display.ad=1 \
    ro.vendor.display.ad.hdr_calib_data=/vendor/etc/hdr_config.cfg \
    ro.vendor.display.ad.sdr_calib_data=/vendor/etc/sdr_config.cfg \
    ro.vendor.display.sensortype=2

# DPM
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    persist.vendor.dpm.loglevel=0 \
    persist.vendor.dpm.nsrm.bkg.evt=3955

# Display Device Config
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/display/display_19260591652815745.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/displayconfig/display_19260591652815745.xml \
    $(LOCAL_PATH)/configs/display/display_19261151497321857.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/displayconfig/display_19261151497321857.xml

# DRM
PRODUCT_PACKAGES += \
    android.hardware.drm-service.clearkey \
    android.hardware.drm@1.3.vendor 

PRODUCT_VENDOR_PROPERTIES += \
    drm.service.enabled=true

# Fastbootd
PRODUCT_PACKAGES += \
    fastbootd

PRODUCT_SYSTEM_PROPERTIES += \
    ro.fastbootd.available=true

# Fingerprint
PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint@2.3-service.beryllium

# FRP
PRODUCT_VENDOR_PROPERTIES += \
    ro.frp.pst=/dev/block/bootdevice/by-name/frp

# GPS
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/gps/,$(TARGET_COPY_OUT_VENDOR)/etc)

# Graphics
PRODUCT_SYSTEM_PROPERTIES += \
    debug.sf.early_app_phase_offset_ns=500000 \
    debug.sf.early_gl_app_phase_offset_ns=15000000 \
    debug.sf.early_gl_phase_offset_ns=3000000 \
    debug.sf.early_phase_offset_ns=500000 \
    ro.surface_flinger.force_hwc_copy_for_virtual_displays=true \
    ro.surface_flinger.max_frame_buffer_acquired_buffers=3 \
    ro.surface_flinger.max_virtual_display_dimension=4096 \
    ro.surface_flinger.protected_contents=true \
    sdm.debug.disable_inline_rotator=1 \
    sdm.debug.disable_inline_rotator_secure=1

PRODUCT_VENDOR_PROPERTIES += \
    ro.hardware.egl=adreno \
    ro.hardware.vulkan=adreno \
    ro.opengles.version=196610

# HIDL
PRODUCT_PACKAGES += \
    android.hidl.allocator@1.0 \
    android.hidl.allocator@1.0.vendor \
    libhwbinder \
    libhidltransport \
    libhwbinder.vendor \
    libhidltransport.vendor

# HotwordEnrollement app permissions
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/permissions/privapp-permissions-hotword.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-hotword.xml

# HW crypto
PRODUCT_PACKAGES += \
    vendor.qti.hardware.cryptfshw@1.0-service-qti.qsee

# IMS
PRODUCT_SYSTEM_PROPERTIES += \
    persist.vendor.ims.disableUserAgent=0

# Init
PRODUCT_PACKAGES += \
    fstab.qcom \
    fstab.qcom.ramdisk \
    init.target.rc \
    init.beryllium.rc \
    init.beryllium.power.rc \
    init.qcom.sensors.sh \
    ueventd.beryllium.rc

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

# Keymaster
PRODUCT_PACKAGES += \
    android.hardware.keymaster@4.0.vendor \
    android.hardware.gatekeeper@1.0.vendor

# Lights
PRODUCT_PACKAGES += \
    android.hardware.light@2.0-service.beryllium

# Listen
PRODUCT_VENDOR_PROPERTIES += \
    ro.audio.soundtrigger=sva \
    ro.audio.soundtrigger.lowpower=true \
    ro.vendor.audio.soundtrigger=sva \
    ro.vendor.audio.soundtrigger.lowpower=true \
    ro.vendor.audio.soundtrigger.20.key.level=40 \
    ro.vendor.audio.soundtrigger.20.user.level=60 \
    ro.vendor.audio.soundtrigger.20.key.adsp.level=40 \
    ro.vendor.audio.soundtrigger.20.user.adsp.level=40 \
    ro.vendor.audio.soundtrigger.gmm.level=50 \
    ro.vendor.audio.soundtrigger.gmm.user.level=10 \
    ro.vendor.audio.soundtrigger.cnn.level=27 \
    ro.vendor.audio.soundtrigger.vop.level=10 \
    ro.vendor.audio.soundtrigger.gmm.adsp.level=50 \
    ro.vendor.audio.soundtrigger.gmm.user.adsp.level=10 \
    ro.vendor.audio.soundtrigger.cnn.adsp.level=27 \
    ro.vendor.audio.soundtrigger.vop.adsp.level=10 \
    ro.vendor.audio.soundtrigger.training.level=60 \
    ro.vendor.audio.soundtrigger.hist.duration=1500

# LMKD
PRODUCT_PRODUCT_PROPERTIES += \
    ro.lmk.low=1001 \
    ro.lmk.medium=800 \
    ro.lmk.critical=0 \
    ro.lmk.critical_upgrade=false \
    ro.lmk.upgrade_pressure=100 \
    ro.lmk.downgrade_pressure=100 \
    ro.lmk.kill_heaviest_task=true \
    ro.lmk.kill_timeout_ms=100 \
    ro.lmk.use_minfree_levels=true \
    ro.lmk.log_stats=true

# Media
PRODUCT_SYSTEM_PROPERTIES += \
    debug.stagefright.omx_default_rank.sw-audio=1

# MI Extras
PRODUCT_PACKAGES += \
    XiaomiSettings

# Native libraries whitelist
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/public.libraries.txt:$(TARGET_COPY_OUT_VENDOR)/etc/public.libraries.txt

# Netflix property
PRODUCT_VENDOR_PROPERTIES += \
    ro.netflix.bsp_rev=Q845-14477-1

# Network manager
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.data.iwlan.enable=true \
    ro.telephony.iwlan_operation_mode=legacy

# Neural Network
PRODUCT_PACKAGES += \
    android.hardware.neuralnetworks@1.3.vendor

# Overlays
PRODUCT_PACKAGES += \
    AOSPABerylliumFrameworksOverlay \
    BerylliumCarrierConfigOverlay \
    BerylliumFrameworksOverlay \
    BerylliumNoCutoutOverlay \
    BerylliumSettingsOverlay \
    BerylliumSystemUIOverlay \
    BerylliumWifiOverlay 

# Paranoid Sense
PRODUCT_SYSTEM_PROPERTIES += \
    ro.face.sense_service.camera_id=5

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.full.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.full.xml \
    frameworks/native/data/etc/android.hardware.camera.raw.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.raw.xml \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.fingerprint.xml \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepdetector.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.vulkan.compute-0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.compute.xml \
    frameworks/native/data/etc/android.hardware.vulkan.level-1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.level.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.version.xml \
    frameworks/native/data/etc/android.software.opengles.deqp.level-2020-03-01.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.opengles.deqp.level.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.software.vulkan.deqp.level-2020-03-01.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.vulkan.deqp.level.xml

# Power
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/power/powerhint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/powerhint.xml

# Protobuf
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full-vendorcompat \
    libprotobuf-cpp-lite-vendorcompat

# QTI common
TARGET_COMMON_QTI_COMPONENTS += \
    audio \
    av \
    bt \
    charging \
    display \
    gps \
    init \
    media \
    overlay \
    perf \
    telephony \
    usb \
    vibrator \
    wfd \
    wlan

# RCS
PRODUCT_SYSTEM_PROPERTIES += \
    persist.rcs.supported=1

# Recovery
PRODUCT_PACKAGES += \
    librecovery_updater_xiaomi

PRODUCT_SYSTEM_PROPERTIES += \
    ro.recovery.ui.margin_height=87

# RIL
PRODUCT_SYSTEM_PROPERTIES += \
    persist.sys.fflag.override.settings_provider_model=false \
    persist.vendor.radio.apm_sim_not_pwdn=1 \
    persist.vendor.radio.custom_ecc=1 \
    persist.vendor.radio.flexmap_type=none \
    persist.vendor.radio.force_on_dc=true \
    persist.vendor.radio.procedure_bytes=SKIP \
    persist.vendor.radio.rat_on=combine \
    persist.vendor.radio.report_codec=1 \
    persist.vendor.radio.sib16_support=1 \
    ril.subscription.types=NV,RUIM \
    ro.com.android.dataroaming=true

# Screen density
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# Sensors
PRODUCT_PACKAGES += \
    android.hardware.sensors@1.0-impl:64 \
    android.hardware.sensors@1.0-service \
    libsensorndkbridge

# Shipping API
PRODUCT_SHIPPING_API_LEVEL := 27

# SOC
PRODUCT_VENDOR_PROPERTIES += \
    ro.soc.model=SDM845

# Setup dalvik vm configs
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += $(LOCAL_PATH)

# Treble
PRODUCT_USE_VNDK_OVERRIDE := true

# WiFi Display
PRODUCT_PACKAGES += \
    libwfdaac_vendor

# WLAN
PRODUCT_PACKAGES += \
    libwpa_client 

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/wifi/,$(TARGET_COPY_OUT_VENDOR)/etc/wifi)

# Zram
PRODUCT_SYSTEM_PROPERTIES += \
    ro.zram.first_wb_delay_mins=180 \
    ro.zram.mark_idle_delay_mins=60 \
    ro.zram.periodic_wb_delay_hours=24

# Inherit the proprietary files
$(call inherit-product, vendor/xiaomi/beryllium/beryllium-vendor.mk)
