Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Pan Bian <bianpan201603@163.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
Subject: [PATCH 1/1] PCI: check return value of pci_find_ext_capability
Date: Sun, 23 Apr 2017 22:00:20 +0800
Message-Id: <1492956020-32271-1-git-send-email-bianpan201603@163.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Pan Bian <bianpan2016@163.com>

Function pci_find_ext_capability() will returns 0 on failure, and its
return value should be checked before it is used. However, in function
pcie_port_enable_msix(), its return value is not checked. This patch
adds the check.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/pci/pcie/portdrv_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index cea504f..001951d 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -103,6 +103,8 @@ static int pcie_port_enable_msix(struct pci_dev *dev, int *irqs, int mask)
 		 * interrupt message."
 		 */
 		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
+		if (!pos)
+			goto out_free_irqs;
 		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &reg32);
 		entry = reg32 >> 27;
 		if (entry >= nr_entries)
-- 
1.9.1
