Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:47633 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727818AbeISFa3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 01:30:29 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv3 00/10] PCI error handling
Date: Tue, 18 Sep 2018 17:56:52 -0600
Message-Id: <20180918235702.26573-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This version is reduced in scope from the previous. The more ambitious
handling from the previous version exacerbates other pre-existing
deadlocking issues that are taking some time to fix.

This is mostly a reduced set from v2, but slightly reordered. There is
one prep patch that fixes the bridges pci state when it is initially
saved, and one AER patch that fixes a use-after free.

Keith Busch (10):
  PCI/portdrv: Use subsys_init for service drivers
  PCI/portdrv: Restore pci state on slot reset
  PCI/AER: Take reference on error devices
  PCI/ERR: Use slot reset if available
  PCI/ERR: Handle fatal error recovery
  PCI/ERR: Always use the first downstream port
  PCI/ERR: Simplify broadcast callouts
  PCI/ERR: Report current recovery status for udev
  PCI: Unify device inaccessible
  PCI: Make link active reporting detection generic

 drivers/pci/hotplug/pciehp.h      |   6 -
 drivers/pci/hotplug/pciehp_core.c |   2 +-
 drivers/pci/hotplug/pciehp_hpc.c  |  22 +--
 drivers/pci/pci.c                 |  66 ++++++++-
 drivers/pci/pci.h                 |  66 ++++++++-
 drivers/pci/pcie/aer.c            |  19 ++-
 drivers/pci/pcie/dpc.c            |  10 +-
 drivers/pci/pcie/err.c            | 276 ++++++++++----------------------------
 drivers/pci/pcie/pme.c            |   2 +-
 drivers/pci/pcie/portdrv_pci.c    |   8 ++
 drivers/pci/probe.c               |   1 +
 drivers/pci/slot.c                |   2 +-
 include/linux/pci.h               |   1 +
 13 files changed, 220 insertions(+), 261 deletions(-)

-- 
2.14.4
