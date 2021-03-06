#
# Copyright (C) 2017 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

LOCAL_PATH := device/samsung/a3y17lte

DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

# Device uses high-density artwork where available
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# Boot animation
TARGET_SCREEN_WIDTH := 720
TARGET_SCREEN_HEIGHT := 1280

# Ramdisk
PRODUCT_PACKAGES += \
    init.wifi.rc

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:system/etc/permissions/android.hardware.fingerprint.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \

# WiFi
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/wifi/p2p_supplicant_overlay.conf:system/etc/wifi/p2p_supplicant_overlay.conf \
    $(LOCAL_PATH)/configs/wifi/wpa_supplicant_overlay.conf:system/etc/wifi/wpa_supplicant_overlay.conf

PRODUCT_PACKAGES += \
    macloader \
    wifiloader \
    hostapd \
    libwpa_client \
    wpa_supplicant

# external/wpa_supplicant_8/wpa_supplicant/wpa_supplicant_conf.mk
PRODUCT_PACKAGES += \
    wpa_supplicant.conf

# Audio
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/audio/audio_policy.conf:system/etc/audio_policy.conf \
    $(LOCAL_PATH)/configs/audio/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
    $(LOCAL_PATH)/configs/audio/media_codecs_google_telephony.xml:system/etc/media_codecs_google_telephony.xml \
    $(LOCAL_PATH)/configs/audio/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml \
    $(LOCAL_PATH)/configs/audio/mixer_paths.xml:system/etc/mixer_paths.xml

# Lights
PRODUCT_PACKAGES += \
    lights.universal7870

# Fingerprint
PRODUCT_PACKAGES += \
    fingerprintd \
    mcDriverDaemon \
    fingerprint.exynos5 \
    libbauthtzcommon_shim

# Inherit from Exynos7870-common
$(call inherit-product, device/samsung/exynos7870-common/device-common.mk)

# call the proprietary setup
$(call inherit-product, vendor/samsung/a3y17lte/a3y17lte-vendor.mk)

# adb 
ifeq ($(TARGET_BUILD_VARIANT),eng)

PRODUCT_PROPERTY_OVERRIDES += \
       ro.secure=0 \
       ro.adb.secure=0 \
       ro.hardware=universal7870 \
       persist.service.adb.enable=1 \
       persist.service.debuggable=1 \
       persist.sys.usb.config=adb \
       ro.securestorage.support=false

endif
