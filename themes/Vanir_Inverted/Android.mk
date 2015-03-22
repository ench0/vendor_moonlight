LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional

LOCAL_PACKAGE_NAME := MoonLight_Inverted

LOCAL_AAPT_FLAGS := -c xhdpi -x

include $(BUILD_PACKAGE)
