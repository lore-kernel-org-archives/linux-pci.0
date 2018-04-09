Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:41629 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751505AbeDIWCG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Apr 2018 18:02:06 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Alex_Gagniuc@Dellteam.com, Scott Bauer <scott.bauer@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 0/4] PCI/AER: Use-after-free fix
Date: Mon,  9 Apr 2018 16:04:40 -0600
Message-Id: <20180409220444.6632-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

AER error handling walks the PCI topology below a root port, saving
pointers of the pci_dev structs affected by the error along the way.

At the same time, the pcie hotplug driver could be freeing those very
same structures, causing the AER driver to reference freed memory.

This series fixes this by synchroniziing the aer driver with the pci
hotplug driver during. The final patch is the one that ultimately provides
the locking by having AER lock the same pci lock rescan/remove mutex as
the pciehp driver. The first three patches are prepping to make it safe
for the aer bottom half handler to hold that lock.

Keith Busch (4):
  PCI/AER: Remove unused parameters
  PCI/AER: Replace struct pcie_device with pci_dev
  PCI/AER: Reference count aer structures
  PCI/AER: Lock pci topology when scanning errors

 drivers/pci/pcie/aer/aerdrv.c      | 28 +++++++++++++++++++++-------
 drivers/pci/pcie/aer/aerdrv.h      |  9 +++------
 drivers/pci/pcie/aer/aerdrv_core.c | 38 +++++++++++++++++---------------------
 3 files changed, 41 insertions(+), 34 deletions(-)

-- 
2.14.3
