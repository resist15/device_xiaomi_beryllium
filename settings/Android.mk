LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional

LOCAL_SRC_FILES := $(call all-java-files-under, src)

LOCAL_PACKAGE_NAME := XiaomiSettings

LOCAL_PRIVATE_PLATFORM_APIS := true
LOCAL_CERTIFICATE := platform
LOCAL_DEX_PREOPT := false
LOCAL_PROGUARD_FLAG_FILES := proguard.flags

LOCAL_STATIC_ANDROID_LIBRARIES := \
    SettingsLib

LOCAL_RESOURCE_DIR := \
    $(LOCAL_PATH)/res \
    $(TOP)/packages/resources/devicesettings/res

include $(BUILD_PACKAGE)

include $(call all-makefiles-under,$(LOCAL_PATH))
