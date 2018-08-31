Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:14083 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbeIABem (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Aug 2018 21:34:42 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 00/16] PCI, error handling and hot plug
Date: Fri, 31 Aug 2018 15:26:23 -0600
Message-Id: <20180831212639.10196-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series is all about error handling and hot plug. It should get the
AER fatal handling much like how it was before where we don't always
tear down and re-enumerate the topology, but even better in taht it
won't trigger hotplug events to the extent possibe to suppress link
events that occur from the secondary bus reset.

Ports that do not implement an out-of-band presence detection mechanism
may still have their device removed on the DPC and AER error handling,
but at least error handling for non-hot pluggable ports won't experience
removals anymore.

Some of these are simple bug fixes, some are more complicated. Patch
11 fixes a long-standing issue where a RP detected fatal error never
restored the downstream bridges, making recovery of end devices below
those switches bound to fail after a secondary bus reset resets the
bridge's config memory and bus windows.

Comments welcomed!

Keith Busch (15):
  PCI: Fix pci_reset_bus
  PCI/AER: Remove dead code
  PCI/ERR: Use slot reset if available
  PCI/ERR: Handle fatal error recovery
  PCI/ERR: Remove devices on recovery failure
  PCI/ERR: Always use the first downstream port
  PCI/ERR: Simplify broadcast callouts
  PCI/ERR: Report current recovery status for udev
  PCI/portdrv: Provide pci error callbacks
  PCI/portdrv: Restore pci state on slot reset
  PCI/pciehp: Fix powerfault detection order
  PCI/pciehp: Implement error handling callbacks
  PCI/pciehp: Ignore link events during DPC event
  PCI/DPC: Wait for reset complete
  PCI: Unify device inaccessible

Lukas Wunner (1):
  PCI: Simplify disconnected marking

 drivers/pci/hotplug/pciehp.h      |   1 +
 drivers/pci/hotplug/pciehp_core.c |  51 +++++++
 drivers/pci/hotplug/pciehp_hpc.c  |  34 +++--
 drivers/pci/hotplug/pciehp_pci.c  |   9 +-
 drivers/pci/pci.c                 |  32 ++++-
 drivers/pci/pci.h                 |  12 +-
 drivers/pci/pcie/aer.c            |  15 +-
 drivers/pci/pcie/dpc.c            |  40 ++++--
 drivers/pci/pcie/err.c            | 293 ++++++++++++++------------------------
 drivers/pci/pcie/portdrv.h        |   6 +
 drivers/pci/pcie/portdrv_pci.c    |  37 ++++-
 include/linux/pci.h               |   6 +
 12 files changed, 299 insertions(+), 237 deletions(-)

-- 
2.14.4
