FINALPACKAGE=1

INSTALL_TARGET_PROCESSES = SpringBoard
ARCHS = armv7 armv7s arm64 arm64e
TARGET = iphone:clang::7.1
SYSROOT = $(THEOS)/sdks/iPhoneOS13.6.sdk

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = IncreaseContrast
$(BUNDLE_NAME)_FILES = Switch.xm
$(BUNDLE_NAME)_LIBRARIES = Accessibility flipswitch
$(BUNDLE_NAME)_INSTALL_PATH = /Library/Switches
$(BUNDLE_NAME)_CFLAGS = -fobjc-arc -Iheaders

include $(THEOS_MAKE_PATH)/bundle.mk
