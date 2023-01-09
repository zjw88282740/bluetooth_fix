ARCHS=armv7 armv7s arm64 arm64e
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = bluetoothfix

bluetoothfix_FILES = Tweak.x

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk
