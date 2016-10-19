Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:54261 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932504AbcJSOMa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2016 10:12:30 -0400
Message-Id: <cover.1476875113.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 19 Oct 2016 16:07:13 +0200
Subject: [PATCH 0/9] PCIe port PM: high gloss polish & hotplug support
To: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Keith Busch <keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Linux v4.8 added support to runtime suspend PCIe ports to D3hot.

Patches 1 to 6 of this series apply high gloss polish to that code to
speed it up, reduce its size and improve its readability.  None of these
patches should result in a functional change.  (And they didn't in my
tests.)

Patches 7 and 8 are cleanups / refactorings for acpiphp.  They're prep
work for patch 9 and likewise shouldn't cause a functional change.

Patch 9 extends runtime PM support to hotplug ports.


@Keith Busch: I seem to recall you're working with large arrays of NVMe
drives connected to native PCIe hotplug ports.  Perhaps you could give
this series a spin, it might save quite a bit of power.

To ease reviewing I've pushed this series to GitHub:
https://github.com/l1k/linux/commits/pcie_port_pm_v1

Thanks,

Lukas


Lukas Wunner (9):
  PCI: Don't acquire ref on parent in pci_bridge_d3_update()
  PCI: Autosense device removal in pci_bridge_d3_update()
  PCI: Speed up algorithm in pci_bridge_d3_update()
  PCI: Activate runtime PM on a PCIe port only if it can suspend
  PCI: Consolidate conditions to allow runtime PM on PCIe ports
  PCI: Unfold conditions to block runtime PM on PCIe ports
  ACPI / hotplug / PCI: Use cached copy of PCI_EXP_SLTCAP_HPC bit
  ACPI / hotplug / PCI: Make device_is_managed_by_native_pciehp() public
  PCI: pciehp: Add runtime PM support for PCIe hotplug ports

 drivers/pci/bus.c                  |   2 +-
 drivers/pci/hotplug/acpiphp_glue.c |  31 +-----------
 drivers/pci/hotplug/pciehp_ctrl.c  |   6 +++
 drivers/pci/pci-acpi.c             |  24 +++++++++
 drivers/pci/pci.c                  | 101 ++++++++++++++++++-------------------
 drivers/pci/pci.h                  |   4 +-
 drivers/pci/pcie/portdrv_pci.c     |  13 ++---
 drivers/pci/remove.c               |   2 +-
 include/linux/pci_hotplug.h        |   2 +
 9 files changed, 89 insertions(+), 96 deletions(-)

-- 
2.9.3

