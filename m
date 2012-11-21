Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:46265 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756362Ab2KUUfB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 Nov 2012 15:35:01 -0500
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/9] PCI: Remove use of CONFIG_HOTPLUG
Date: Wed, 21 Nov 2012 15:34:51 -0500
Message-Id: <1353530100-728-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a respin of the patches to remove CONFIG_HOTPLUG for the PCI
subsystem.  The end result is the same as the patches in the big
patchset I sent out earlier this week but the changelog entries have
been changed to be consistent with the capitalization of PCI.  The
removal of the __dev* entries has also been squashed into a single
patch.

Bill Pemberton (9):
  microblaze/PCI: Remove CONFIG_HOTPLUG ifdefs
  mips/PCI: Remove CONFIG_HOTPLUG ifdefs
  powerpc/PCI: Remove CONFIG_HOTPLUG ifdefs
  sh/PCI: Remove CONFIG_HOTPLUG ifdefs
  unicore32/PCI: Remove CONFIG_HOTPLUG ifdefs
  PCI: Remove CONFIG_HOTPLUG ifdefs
  PCI: Move pci_uevent into pci-driver.c
  PCI: Always build setup-bus when PCI is enabled
  PCI: Remove __dev* markings

 arch/microblaze/pci/pci-common.c    |   4 --
 arch/mips/pci/pci.c                 |   2 -
 arch/powerpc/kernel/pci-common.c    |   4 --
 arch/powerpc/kernel/pci_64.c        |   4 --
 arch/sh/drivers/pci/pci.c           |   2 -
 arch/unicore32/kernel/pci.c         |   2 -
 drivers/pci/Makefile                |   7 +-
 drivers/pci/hotplug.c               |  37 ----------
 drivers/pci/hotplug/cpcihp_zt5550.c |   4 +-
 drivers/pci/ioapic.c                |   6 +-
 drivers/pci/pci-driver.c            |  42 +++++++----
 drivers/pci/pci-sysfs.c             |   7 --
 drivers/pci/pci.c                   |   4 +-
 drivers/pci/pci.h                   |   5 --
 drivers/pci/pcie/aer/aerdrv.c       |   4 +-
 drivers/pci/pcie/portdrv_pci.c      |   2 +-
 drivers/pci/probe.c                 |  20 +++---
 drivers/pci/quirks.c                | 134 ++++++++++++++++++------------------
 drivers/pci/xen-pcifront.c          |  10 +--
 include/linux/pci.h                 |   8 +--
 20 files changed, 125 insertions(+), 183 deletions(-)
 delete mode 100644 drivers/pci/hotplug.c

-- 
1.8.0

