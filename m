Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:63618 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753938Ab3DLUrj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 12 Apr 2013 16:47:39 -0400
Received: by mail-ie0-f179.google.com with SMTP id qd14so1122500ieb.24
        for <linux-pci@vger.kernel.org>; Fri, 12 Apr 2013 13:47:38 -0700 (PDT)
Subject: [PATCH 0/6] PCI warning cleanups
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Fri, 12 Apr 2013 14:47:36 -0600
Message-ID: <20130412204510.5237.25443.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These follow Andy's pcie_port_acpi_setup() warning fix.  With these,
building drivers/pci with "make W=1" is clean except for some ftrace-
related thing that I don't know how to fix.

The last "extern" patch doesn't fix any warnings, but makes function
declarations in PCI consistent.

If there are no issues, I'll put these in v3.10.

---

Bjorn Helgaas (6):
      PCI: Make local functions/structs static
      PCI: Remove unused variables
      PCI: Fix __must_check annotation on pci_create_sysfs_dev_files()
      PCI: Remove __must_check from definitions
      PCI: Warn about failures instead of "must_check" functions
      PCI: Remove "extern" from function declarations


 drivers/pci/bus.c                      |    7 ++
 drivers/pci/hotplug/acpiphp.h          |   26 ++++-----
 drivers/pci/hotplug/cpci_hotplug.h     |   36 ++++++------
 drivers/pci/hotplug/cpqphp.h           |   70 +++++++++++-------------
 drivers/pci/hotplug/cpqphp_nvram.h     |   12 ++--
 drivers/pci/hotplug/ibmphp.h           |   68 +++++++++++------------
 drivers/pci/hotplug/pci_hotplug_core.c |   10 +--
 drivers/pci/hotplug/pciehp.h           |   22 ++++---
 drivers/pci/hotplug/rpadlpar.h         |    8 +--
 drivers/pci/hotplug/rpaphp.h           |   16 +++--
 drivers/pci/hotplug/shpchp.h           |   26 ++++-----
 drivers/pci/hotplug/shpchp_sysfs.c     |    2 -
 drivers/pci/msi.c                      |    4 +
 drivers/pci/pci-sysfs.c                |    2 -
 drivers/pci/pci.c                      |    8 +--
 drivers/pci/pci.h                      |   89 ++++++++++++++----------------
 drivers/pci/pcie/aer/aerdrv.h          |   14 ++---
 drivers/pci/pcie/portdrv.h             |   18 +++---
 drivers/pci/pcie/portdrv_pci.c         |   17 ++----
 drivers/pci/setup-bus.c                |    4 +
 drivers/pci/setup-res.c                |    2 -
 drivers/pci/slot.c                     |    7 ++
 include/linux/pci-aspm.h               |   20 +++----
 include/linux/pci-ats.h                |   26 ++++-----
 include/linux/pci.h                    |   95 ++++++++++++++++----------------
 include/linux/pci_hotplug.h            |   12 ++--
 include/linux/pcieport_if.h            |    4 +
 27 files changed, 307 insertions(+), 318 deletions(-)
