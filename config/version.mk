# Versioning System
KANGOS_CODENAME := Snowflakes
KANGOS_MAJOR_VERSION := v3.0
KANGOS_RELEASE_VERSION := rc1
KANGOS_BUILD_TYPE ?= UNOFFICIAL
KANGOS_BUILD_VARIANT := VANILLA

# Gapps
ifeq ($(WITH_GAPPS),true)
$(call inherit-product, vendor/gapps/config.mk)
KANGOS_BUILD_VARIANT := GAPPS

# Common Overlay
DEVICE_PACKAGE_OVERLAYS += \
    vendor/kangos/overlay-gapps/common

# Exclude RRO Enforcement
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS +=  \
    vendor/kangos/overlay-gapps

$(call inherit-product, vendor/kangos/config/rro_overlays.mk)
endif

# KangOS Release
ifeq ($(KANGOS_BUILD_TYPE), OFFICIAL)
  OFFICIAL_DEVICES = $(shell cat vendor/kangos/kangos.devices)
  FOUND_DEVICE =  $(filter $(KANGOS_BUILD), $(OFFICIAL_DEVICES))
    ifeq ($(FOUND_DEVICE),$(KANGOS_BUILD))
      KANGOS_BUILD_TYPE := OFFICIAL
    else
      KANGOS_BUILD_TYPE := UNOFFICIAL
      $(error Device is not official "$(KANGOS_BUILD)")
    endif
endif

# System version
TARGET_PRODUCT_SHORT := $(subst kangos_,,$(KANGOS_BUILD_TYPE))

KANGOS_DATE_YEAR := $(shell date -u +%Y)
KANGOS_DATE_MONTH := $(shell date -u +%m)
KANGOS_DATE_DAY := $(shell date -u +%d)
KANGOS_DATE_HOUR := $(shell date -u +%H)
KANGOS_DATE_MINUTE := $(shell date -u +%M)

KANGOS_BUILD_DATE := $(KANGOS_DATE_YEAR)$(KANGOS_DATE_MONTH)$(KANGOS_DATE_DAY)-$(KANGOS_DATE_HOUR)$(KANGOS_DATE_MINUTE)
KANGOS_BUILD_VERSION := $(KANGOS_MAJOR_VERSION)-$(KANGOS_RELEASE_VERSION)
KANGOS_BUILD_FINGERPRINT := KangOS/$(KANGOS_MOD_VERSION)/$(TARGET_PRODUCT_SHORT)/$(KANGOS_BUILD_DATE)
KANGOS_VERSION := KangOS-$(KANGOS_CODENAME)-$(KANGOS_BUILD_VERSION)-$(KANGOS_BUILD)-$(KANGOS_BUILD_TYPE)-$(KANGOS_BUILD_DATE)
KANGOS_RELEASE := KangOS-$(KANGOS_CODENAME)-$(KANGOS_BUILD_VERSION)-$(KANGOS_BUILD)-$(KANGOS_BUILD_TYPE)-$(KANGOS_BUILD_VARIANT)-$(KANGOS_BUILD_DATE)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.kangos.device=$(KANGOS_BUILD) \
  ro.kangos.version=$(KANGOS_VERSION) \
  ro.kangos.build.version=$(KANGOS_BUILD_VERSION) \
  ro.kangos.build.type=$(KANGOS_BUILD_TYPE) \
  ro.kangos.build.variant=$(KANGOS_BUILD_VARIANT) \
  ro.kangos.build.date=$(KANGOS_BUILD_DATE) \
  ro.kangos.build.fingerprint=$(KANGOS_BUILD_FINGERPRINT)
