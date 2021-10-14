# Versioning System
KANGOS_MAJOR_VERSION = SnowCone
KANGOS_RELEASE_VERSION = PREVIEW
KANGOS_BUILD_TYPE ?= UNOFFICIAL
KANGOS_BUILD_VARIANT := VANILLA

ifeq ($(WITH_GAPPS), true)
    KANGOS_BUILD_VARIANT := GAPPS
    $(call inherit-product, vendor/gapps/common/common-vendor.mk)
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
KANGOS_VERSION := KangOS-$(KANGOS_BUILD_VERSION)-$(KANGOS_BUILD)-$(KANGOS_BUILD_TYPE)-$(KANGOS_BUILD_DATE)
KANGOS_RELEASE := KangOS-$(KANGOS_BUILD_VERSION)-$(KANGOS_BUILD)-$(KANGOS_BUILD_TYPE)-$(KANGOS_BUILD_VARIANT)-$(KANGOS_BUILD_DATE)

PRODUCT_GENERIC_PROPERTIES += \
  ro.kangos.device=$(KANGOS_BUILD) \
  ro.kangos.version=$(KANGOS_VERSION) \
  ro.kangos.build.version=$(KANGOS_BUILD_VERSION) \
  ro.kangos.build.type=$(KANGOS_BUILD_TYPE) \
  ro.kangos.build.variant=$(KANGOS_BUILD_VARIANT) \
  ro.kangos.build.date=$(KANGOS_BUILD_DATE) \
  ro.kangos.build.fingerprint=$(KANGOS_BUILD_FINGERPRINT)
