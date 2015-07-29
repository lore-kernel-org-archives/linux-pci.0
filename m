Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bjorn Helgass <bhelgaas@google.com>,
	Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH 3/3] PCIE: Remove symbol export for pcie_set_mps()
Date: Wed, 29 Jul 2015 16:18:55 -0600
Message-Id: <1438208335-19457-4-git-send-email-keith.busch@intel.com>
In-Reply-To: <1438208335-19457-1-git-send-email-keith.busch@intel.com>
References: <1438208335-19457-1-git-send-email-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Dave Jiang <dave.jiang@intel.com>

The setting of PCIe MPS should be left to the PCI subsystem and not
the driver. An ill configured MPS by the driver could cause the device
to not function or unstablize the entire system. Removing the exported
symbol.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/pci/pci.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0008c95..92349ee 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4121,7 +4121,6 @@ int pcie_set_mps(struct pci_dev *dev, int mps)
 	return pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
 						  PCI_EXP_DEVCTL_PAYLOAD, v);
 }
-EXPORT_SYMBOL(pcie_set_mps);
 
 /**
  * pcie_get_minimum_link - determine minimum link settings of a PCI device
-- 
1.7.10.4

