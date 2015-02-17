Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:37492 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753021AbbBQHO2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Feb 2015 02:14:28 -0500
Received: from /spool/local
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Tue, 17 Feb 2015 17:14:25 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 60CA32BB004D
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2015 18:14:23 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t1H7EEwf45416596
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2015 18:14:23 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t1H7DnKd011044
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2015 18:13:49 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: linux-pci@vger.kernel.org, benh@kernel.crashing.org,
	bhelgaas@google.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH RESEND v2 0/7] powerpc/powernv: Unified PCI slot reset and hotplug
Date: Tue, 17 Feb 2015 18:13:16 +1100
Message-Id: <1424157203-691-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patchset was built based on patchset "powerpc/powernv: Simplify EEH
implementation", which can be found from:

https://patchwork.ozlabs.org/patch/439956/

The patchset corresponds to skiboot changes, which manages PCI slots
in a unified way: OPAL APIs used to do slot reset, power management,
presence status retrival. The patchset shouldn't be merged before
the OPAL firmware counterpart is merged:

https://patchwork.ozlabs.org/patch/440463/

The kernel changes have been split into 2 parts:
(A) Use the unified PCI slot reset OPAL API, PATCH[1] and PATCH[2]
(B) powernv-php driver to support PCI hotplug for PowerNV platform, starting
    from PATCH[3]. The device tree is scanned when the driver is loaded. If
    any PCI device node is equipped with property "ibm,slot-pluggable" and
    "ibm,reset-by-firmware", it's regarded as hotpluggable slot and the driver
    creates/registers slot for it. After that, the sysfs entries can be used
    to operate the slot.

    PATCH[3/4/5/6]: Necessary code changes to PPC PCI subsystem in order to
                    support PCI slots for PPC PowerNV platform.
    PATCH[7]      : powernv-php driver to support PCI hotplug for PowerNV
                    platform.


Hotplug testing 
===============
# cat /proc/cpuinfo | grep -i powernv
platform        : PowerNV
machine         : PowerNV 8286-41A

# pwd
/sys/bus/pci/slots
# ls
C10  C11  C12  C14  C15  C6  C7  C8  C9

# lspci -s 0003::.
0003:00:00.0 PCI bridge: IBM Device 03dc
0003:01:00.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:02:01.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:02:08.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:02:09.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:02:10.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:02:11.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:03:00.0 USB controller: Texas Instruments TUSB73x0 SuperSpeed USB 3.0 xHCI Host Controller (rev 02)
0003:09:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5719 Gigabit Ethernet PCIe (rev 01)
0003:09:00.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5719 Gigabit Ethernet PCIe (rev 01)
0003:09:00.2 Ethernet controller: Broadcom Corporation NetXtreme BCM5719 Gigabit Ethernet PCIe (rev 01)
0003:09:00.3 Ethernet controller: Broadcom Corporation NetXtreme BCM5719 Gigabit Ethernet PCIe (rev 01)
0003:0f:00.0 Network controller: Mellanox Technologies MT27500 Family [ConnectX-3]
# pwd
/sys/bus/pci/slots/C10
# cat address
0003:09:00
# cat cur_bus_speed
5.0 GT/s PCIe
# cat max_bus_speed
8.0 GT/s PCIe
# cat power
1
# echo 0 > power
# lspci -s 0003::.
0003:00:00.0 PCI bridge: IBM Device 03dc
0003:01:00.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:02:01.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:02:08.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:02:09.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:02:10.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:02:11.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:03:00.0 USB controller: Texas Instruments TUSB73x0 SuperSpeed USB 3.0 xHCI Host Controller (rev 02)
0003:0f:00.0 Network controller: Mellanox Technologies MT27500 Family [ConnectX-3]
# echo 1 > power
# lspci -s 0003::.
0003:00:00.0 PCI bridge: IBM Device 03dc
0003:01:00.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:02:01.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:02:08.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:02:09.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:02:10.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:02:11.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:03:00.0 USB controller: Texas Instruments TUSB73x0 SuperSpeed USB 3.0 xHCI Host Controller (rev 02)
0003:09:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5719 Gigabit Ethernet PCIe (rev 01)
0003:09:00.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5719 Gigabit Ethernet PCIe (rev 01)
0003:09:00.2 Ethernet controller: Broadcom Corporation NetXtreme BCM5719 Gigabit Ethernet PCIe (rev 01)
0003:09:00.3 Ethernet controller: Broadcom Corporation NetXtreme BCM5719 Gigabit Ethernet PCIe (rev 01)
0003:0f:00.0 Network controller: Mellanox Technologies MT27500 Family [ConnectX-3]

Changelog
=========
v1 -> v2
   * Keep opal_pci_reinit(). In case the slot is resetted by kernel,
     instead of skiboot, this API should be called to restore states
     for those affected devices.
   * Reworked slot ID scheme so that old/new kernel can work with
     skiboot with or without unified PCI slot management support.
   * Code cleanup here and there.
   * Separate powernv-php driver to support PCI hotplug for
     PowerNV platform.
   * Check if the OPAL API supported by firmware before calling
     into it, which is necessary for back-compability.
   * Separate patch for factoring pnv_pci_poll().


Gavin Shan (7):
  powerpc/powernv: Use PCI slot reset infrastructure
  powerpc/powernv: Issue fundamental reset if required
  powerpc/pci: Move pcibios_find_pci_bus() around
  powerpc/pci: Don't scan empty slot
  powerpc/powernv: Introduce pnv_pci_poll()
  powerpc/powernv: Functions to retrieve PCI slot status
  PCI/hotplug: PowerPC PowerNV PCI hotplug driver

 arch/powerpc/include/asm/eeh.h                 |   1 +
 arch/powerpc/include/asm/opal.h                |  14 +-
 arch/powerpc/include/asm/pnv-pci.h             |   3 +
 arch/powerpc/kernel/pci-hotplug.c              |  39 ++-
 arch/powerpc/platforms/powernv/eeh-powernv.c   | 258 +++++++++--------
 arch/powerpc/platforms/powernv/opal-wrappers.S |   2 +
 arch/powerpc/platforms/powernv/pci.c           |  43 +++
 arch/powerpc/platforms/powernv/pci.h           |   1 +
 arch/powerpc/platforms/pseries/pci_dlpar.c     |  32 ---
 drivers/pci/hotplug/Kconfig                    |  12 +
 drivers/pci/hotplug/Makefile                   |   4 +
 drivers/pci/hotplug/powernv_php.c              | 126 ++++++++
 drivers/pci/hotplug/powernv_php.h              |  70 +++++
 drivers/pci/hotplug/powernv_php_slot.c         | 382 +++++++++++++++++++++++++
 14 files changed, 817 insertions(+), 170 deletions(-)
 create mode 100644 drivers/pci/hotplug/powernv_php.c
 create mode 100644 drivers/pci/hotplug/powernv_php.h
 create mode 100644 drivers/pci/hotplug/powernv_php_slot.c

-- 
1.8.3.2

