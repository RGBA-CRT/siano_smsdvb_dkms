# SPDX-License-Identifier: GPL-2.0
PWD := $(shell pwd)

smsmdtv-objs := smscoreapi.o sms-cards.o smsendian.o
smsdvb-objs := smsdvb-main.o

ifeq ($(CONFIG_SMS_SIANO_RC),y)
	smsmdtv-objs += smsir.o
endif

ifeq ($(CONFIG_SMS_SIANO_DEBUGFS),y)
	smsdvb-objs += smsdvb-debugfs.o
endif

obj-m += smsmdtv.o smsdvb.o

ifneq ($(KERNELRELEASE),)
KVER ?= $(shell uname -r)
endif
KDIR ?= /usr/lib/modules/$(KVER)/build

default:
	echo "KDIR=$(KDIR)"
	$(MAKE) -C $(KDIR) M=$(PWD)

clean:
	$(MAKE) -C $(KDIR) M=$(PWD) clean
