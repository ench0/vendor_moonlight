PRODUCT_PACKAGE_OVERLAYS += vendor/moonlight/overlay/common

#optional theme files
PRODUCT_PACKAGE_OVERLAYS += vendor/moonlight/overlay/theme

# DSPManager and NFC
$(call inherit-product, vendor/moonlight/products/media_sexificators.mk)
$(call inherit-product, vendor/moonlight/config/nfc_enhanced.mk)

# Add some tones (if this grows to more than like... 5 ringtones and 5 notifications, old ones will be dropped)
$(call inherit-product, vendor/moonlight/proprietary/ringtones/MoonLightRingtones.mk)

# Build packages included in manifest
PRODUCT_PACKAGES += \
    IndecentXposure \
    LockClock \
    Terminal \
    busybox \
    Email \
    Launcher3 \
#    MoonLightUpdater \
    LiveWallpapersPicker

# QuickBoot (included automagically for non-oppo qcom devices)
PRODUCT_PACKAGES += \
    QuickBoot \
    init.moonlight.quickboot.rc

MoonLight_Version=5.0.2
MoonLight_BUILD=$(MoonLight_Version)

ifeq ($(RELEASE),)
ifneq ($(FORCE_BUILD_DATE),)
BUILD_DATE:=.$(FORCE_BUILD_DATE)
else
BUILD_DATE:=$(shell date +".%m%d%y")
endif
MoonLight_BUILD=$(MoonLight_Version)$(BUILD_DATE)
endif

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# Build Properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.error.receiver.system.apps=com.google.android.feedback \
    ro.com.google.locationfeatures=1 \
    ro.setupwizard.mode=OPTIONAL \
    ro.setupwizard.enterprise_mode=1 \
    ro.config.ringtone=Hydra.ogg \
    ro.config.notification_sound=Proxima.ogg \
    ro.config.alarm_alert=Alarm_Beep_03.ogg \
    ro.modversion=$(MoonLight_BUILD) \
    ro.goo.version=$(MoonLight_BUILD) \
    ro.rommanager.developerid=moonlight \
    wifi.supplicant_scan_interval=300 \
    persist.sys.root_access=3 \
    persist.sys.purgeable_assets=1 \
    ro.build.selinux=1

# nomnomnom
PRODUCT_PROPERTY_OVERRIDES += persist.sys.dun.override=0

ifeq ($(MOONLIGHT_FAILSAFE),)
# Build.Prop Tweaks
PRODUCT_PROPERTY_OVERRIDES += \
    mot.proximity.delay=20 \
    net.bt.name=Android \
    ro.ril.disable.power.collapse=0 \
    ro.vold.umsdirtyratio=20 \
    pm.sleep_mode=0 \
    ro.config.nocheckin=1 \
    ro.goo.developerid=moonlight \
    ro.kernel.android.checkjni=0 \
    ro.kernel.checkjni=0 \
    ro.lge.proximity.delay=20
endif

# Version information used on all builds
PRODUCT_BUILD_PROP_OVERRIDES += BUILD_DISPLAY_ID=LRX22G BUILD_ID=LRX22G BUILD_VERSION_TAGS=release-keys USER=android-build BUILD_EST_DATE=$(shell date +"%s")

PRODUCT_COPY_FILES += \
    vendor/moonlight/proprietary/common/xbin/sysrw:system/xbin/sysrw \
    vendor/moonlight/proprietary/common/xbin/sysro:system/xbin/sysro \
    vendor/moonlight/proprietary/common/xbin/moonlightinteractivegovernorgovernor:system/xbin/moonlightinteractivegovernorgovernor \
    vendor/moonlight/proprietary/common/xbin/moonlightflash:system/xbin/moonlightflash \
    vendor/moonlight/proprietary/common/init.moonlight.rc:root/init.moonlight.rc \
    vendor/moonlight/proprietary/common/bin/otasigcheck.sh:system/bin/otasigcheck.sh \
    vendor/moonlight/proprietary/common/bin/sysinit:system/bin/sysinit \
    vendor/moonlight/proprietary/common/etc/init.d/00firsties:system/etc/init.d/00firsties

ifeq ($(MOONLIGHT_FAILSAFE),)
# Blobs common to all devices
PRODUCT_COPY_FILES += \
    vendor/moonlight/proprietary/common/bin/fix_permissions:system/bin/fix_permissions \
    vendor/moonlight/proprietary/common/xbin/hunter:system/xbin/hunter \
    vendor/moonlight/proprietary/common/xbin/testinitd:system/xbin/testinitd \
    vendor/moonlight/proprietary/common/xbin/moonlightcheckcpu:system/xbin/moonlightcheckcpu \
    vendor/moonlight/proprietary/common/xbin/moonlightnice:system/xbin/moonlightnice

# Misc Files
PRODUCT_COPY_FILES += \
    vendor/moonlight/proprietary/common/etc/resolv.conf:system/etc/resolv.conf

# Keyboard Files
PRODUCT_COPY_FILES += \
    vendor/moonlight/proprietary/common/lib/libjni_latinime.so:system/lib/libjni_latinime.so \
    vendor/moonlight/proprietary/common/lib/libjni_latinime.so:system/lib/libjni_latinimegoogle.so

# proprietary guts
PRODUCT_COPY_FILES += \
    vendor/moonlight/proprietary/common/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/moonlight/proprietary/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd

# init.d Tweaks
PRODUCT_COPY_FILES += \
    vendor/moonlight/proprietary/common/etc/sysctl.conf:system/etc/sysctl.conf \
    vendor/moonlight/proprietary/common/etc/init.d/09cron:system/etc/init.d/09cron \
    vendor/moonlight/proprietary/common/etc/init.d/98SONIC_SHOCK:system/etc/init.d/98SONIC_SHOCK \
    vendor/moonlight/proprietary/common/etc/init.d/99moonlight:system/etc/init.d/99moonlight \
    vendor/moonlight/proprietary/common/etc/init.d/90userinit:system/etc/init.d/90userinit \
    vendor/moonlight/proprietary/common/etc/cron/cron.minutely/00nicetweaks:/system/etc/cron/cron.minutely/00nicetweaks \
    vendor/moonlight/proprietary/common/etc/cron/cron.daily/00sqlitespeed:/system/etc/cron/cron.daily/00sqlitespeed

# system and persistent /data boot.d Tweaks - triggered when ro.boot_complete is set to 1
PRODUCT_COPY_FILES += \
    vendor/moonlight/proprietary/common/bin/afterboot:system/bin/afterboot \
    vendor/moonlight/proprietary/common/etc/boot.d/00moonlightnice:system/etc/boot.d/00moonlightnice

# Backup Tools
PRODUCT_COPY_FILES += \
    vendor/moonlight/proprietary/common/bin/automagic.sh:system/bin/automagic.sh \
    vendor/moonlight/proprietary/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/moonlight/proprietary/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/moonlight/proprietary/common/bin/50-moonlight.sh:system/addon.d/50-moonlight.sh \
    vendor/moonlight/proprietary/common/bin/blacklist:system/addon.d/blacklist \
    vendor/moonlight/proprietary/common/bin/whitelist:system/addon.d/whitelist
endif

PRODUCT_PACKAGE_OVERLAYS += \
    vendor/moonlight/overlay/dictionaries

# Required CM packages
PRODUCT_PACKAGES += \
    Camera \
    Development \
    LatinIME \
    su \
    BluetoothExt

# CM Hardware Abstraction Framework
PRODUCT_PACKAGES += \
    org.cyanogenmod.hardware \
    org.cyanogenmod.hardware.xml

# Optional CM packages
PRODUCT_PACKAGES += \
    Basic \
    SoundRecorder \
    libemoji

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libstagefright_soft_ffmpegadec \
    libstagefright_soft_ffmpegvdec \
    libFFmpegExtractor \
    libnamparser

# Extra tools in CM
PRODUCT_PACKAGES += \
    libsepol \
    e2fsck \
    mke2fs \
    tune2fs \
    mkfs.f2fs \
    fsck.f2fs \
    fibmap.f2fs \
    bash \
    vim \
    zip \
    unrar \
    nano \
    htop \
    lsof \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat \
    ntfsfix \
    ntfs-3g \
    gdbserver \
    micro_bench \
    oprofiled \
    procmem \
    procrank \
    sqlite3 \
    strace

ifneq ($(TARGET_ARCH),arm64)
PRODUCT_PACKAGES += \
    powertop
endif

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

# Theme engine
PRODUCT_PACKAGES += \
    ThemeChooser \
    ThemesProvider

PRODUCT_COPY_FILES += \
    vendor/moonlight/config/permissions/org.cyanogenmod.theme.xml:system/etc/permissions/org.cyanogenmod.theme.xml

## STREAMING DMESG?
PRODUCT_PACKAGES += \
    klogripper

## FOR HOTFIXING KERNELS MAINTAINED BY BUNGHOLES
PRODUCT_PACKAGES += \
    utility_mkbootimg \
    utility_unpackbootimg

-include vendor/cyngn/product.mk

$(call inherit-product-if-exists, vendor/moonlight-private/Private.mk)
$(call inherit-product-if-exists, vendor/extra/product.mk)
