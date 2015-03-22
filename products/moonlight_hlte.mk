#Squisher Choosing
DHO_VENDOR := moonlight

PRODUCT_PROPERTY_OVERRIDES += \
    drm.service.enabled=true \
    ro.goo.rom=moonlight-hlte

# Boot Animation
PRODUCT_COPY_FILES += \
    vendor/moonlight/proprietary/boot_animations/1080x1920.zip:system/media/bootanimation.zip

# Inherit device configuration
$(call inherit-product, device/samsung/hlte/full_hlte.mk)

# Inherit common moonlight files.
$(call inherit-product, vendor/moonlight/products/common_phones.mk)

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := hlte
PRODUCT_NAME := moonlight_hlte
