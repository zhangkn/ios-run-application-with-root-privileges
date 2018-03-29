

THEOS_DEVICE_IP=usb2222	#5C9
TARGET = iphone:latest:8.0
ARCHS = armv7 arm64
THEOS=/opt/theos
THEOS_MAKE_PATH=$(THEOS)/makefiles
include $(THEOS)/makefiles/common.mk
# include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = KNcreateOnDisk
KNcreateOnDisk_FILES = main.m KNAppDelegate.m KNRootViewController.m
KNcreateOnDisk_FRAMEWORKS = UIKit CoreGraphics 

# KNAppDelegate.m:15:10: error: unused variable 'success' [-Werror,-Wunused-variable]
KNcreateOnDisk_CFLAGS += -Wno-error

include $(THEOS_MAKE_PATH)/application.mk
after-install::
	# Taokeceshiji1:~ root# uicache
	install.exec "killall \"KNcreateOnDisk\"" || true

#要先设置用户属主,再设置文件执行权限
	install.exec "chown root:wheel /Applications/KNcreateOnDisk.app/fake"
	install.exec "chmod 775 /Applications/KNcreateOnDisk.app/fake"
	install.exec "chown root:wheel /Applications/KNcreateOnDisk.app/KNcreateOnDisk"
	install.exec "chmod 6775 /Applications/KNcreateOnDisk.app/KNcreateOnDisk"

	install.exec "uicache "