Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from xspv0103.northgrum.com ([134.223.120.78]:13364 "EHLO
	xspv0103.northgrum.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752828AbbIQVWg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Sep 2015 17:22:36 -0400
From: "Tang, Jason (ES)" <Jason.Tang2@ngc.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Subject: [PATCH v1 00/07]: PCI: Static Enumeration
Date: Thu, 17 Sep 2015 21:10:35 +0000
Message-ID: <c9fbda5b67024d81895e5ca70a52db71@XCGVAG27.northgrum.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On many architectures, PCI devices are enumerated by the BIOS/firmware
prior to the kernel booting. This is a problem if a PCI device is
powered on after the PCI subsystem has scanned the various root
complexes. Whereas PCI Hotplug devices have memory ranges reserved for
them ahead of time, no such facility exists for bridges or other
endpoints.

The upcoming patches modifies PCI Hotplug to support static enumeration.
Via the kcmdline, the user can specify how many bus numbers to reserve
for hotplug bridges. This is necessary for the case where a bridge is
hot-added after enumeration. The patches also allow the user to specify
which bridges are hotpluggable, even though that bridge might not
natively have that PCI capability.

The kcmdline syntax for static enumeration is as follows:

  pci=hpbuses=<val>,enum=<device1>;<device2...>

"hpbuses" is used to reserve bus numbers for hotplug bridges. "enum" is
used mark bridges as hotpluggable. <device> has the form:

  <domain>:<bus>:<slot>.<func>

All <device> values are in hexadecimal.

These patches were tested on an x86_64 system that was booted over PXE
and with a ramdisk. With static enumeration, the root filesystem cannot
be on a PCI device. Reenumeration occurs during system initialization,
prior to loading any devices. If an initrd normally mounts the real root
filesystem from a PCI device, that device's addresses could change as a
result of enumeration.

The v0 patches and original discussions are at
http://permalink.gmane.org/gmane.linux.kernel.pci/42082.

Changes from v0 -> v1:
  * Rewrite, by adding support for hotpluggable bridges
  * New hpbuses kcmdline to reserve buses for hotplug bridges
  * Simplified enumeration code
  * Rebased to kernel 4.2-rc7


Jason Tang (7):
      PCI: Use child bus's number instead of assuming max+1
      PCI: Track subordinate values in struct pci_bus
      PCI: Let kcmdline reserve bus numbers for hotplug bridges
      PCI: Add Kconfig option for static enumeration
      PCI: Let kcmdline specify static enumeration profile
      PCI: Use static enumeration to mark a bridge as hotpluggable
      PCI: Override firmware settings if static enumeration is set

 Documentation/kernel-parameters.txt |  11 ++++
 drivers/pci/Kconfig                 |  12 ++++
 drivers/pci/Makefile                |   2 +
 drivers/pci/pci.c                   |   7 +++
 drivers/pci/pci.h                   |  10 +++
 drivers/pci/pci_static_enum.c       | 120 ++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c                 |  32 ++++++++--
 include/linux/pci.h                 |   2 +
 8 files changed, 191 insertions(+), 5 deletions(-)
