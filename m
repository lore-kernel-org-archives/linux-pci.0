Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:37334 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757566Ab3GYR5Q (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 25 Jul 2013 13:57:16 -0400
Received: by mail-ob0-f174.google.com with SMTP id wd20so2196897obb.19
        for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2013 10:57:15 -0700 (PDT)
Subject: [PATCH 0/2] PCI: Convert hotplug core and pciehp to be builtin only
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
	linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Paul Mundt <lethal@linux-sh.org>,
	Paul Mackerras <paulus@samba.org>,
	Yinghai Lu <yinghai@kernel.org>, linuxppc-dev@lists.ozlabs.org
Date: Thu, 25 Jul 2013 11:57:12 -0600
Message-ID: <20130725175242.6006.56007.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Yinghai is working on a regression fix ("PCI: Separate stop and remove
devices in pciehp") that needs to go into v3.11, and his fix will be
simpler if we remove the module option for pciehp in v3.11.  That will mean
he won't have to export pci_stop_bus_device() and pci_remove_bus_device()
for use by modules.

So these two patches convert CONFIG_HOTPLUG_PCI and CONFIG_HOTPLUG_PCI_PCIE
to be bool (not tristate) and update defconfig files that had
CONFIG_HOTPLUG_PCI=m.

The motivation was for CONFIG_HOTPLUG_PCI_PCIE, but I also converted
CONFIG_HOTPLUG_PCI to bool because the CONFIG_HOTPLUG_PCI=m and
CONFIG_HOTPLUG_PCI_PCIE=y combination was accepted by Kconfig and builds a
kernel, but pciehp doesn't actually work in that case (pointed out by
Yinghai, thanks!)

These are intended for v3.11.

---

Bjorn Helgaas (2):
      PCI: hotplug: Convert to be builtin only, not modular
      PCI: pciehp: Convert pciehp to be builtin only, not modular


 arch/ia64/configs/generic_defconfig    |    2 +-
 arch/ia64/configs/gensparse_defconfig  |    2 +-
 arch/ia64/configs/tiger_defconfig      |    2 +-
 arch/ia64/configs/xen_domu_defconfig   |    2 +-
 arch/powerpc/configs/ppc64_defconfig   |    2 +-
 arch/powerpc/configs/ppc64e_defconfig  |    2 +-
 arch/powerpc/configs/pseries_defconfig |    2 +-
 arch/sh/configs/sh03_defconfig         |    2 +-
 drivers/pci/hotplug/Kconfig            |    5 +----
 drivers/pci/pcie/Kconfig               |    5 +----
 10 files changed, 10 insertions(+), 16 deletions(-)
