Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
To: bhelgaas@google.com
Cc: marc.zyngier@arm.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/MSI: Improve MSI alias detection
Date: Wed, 31 May 2017 18:52:28 +0100
Message-Id: <20170531175230.16529-2-robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently, we consider all DMA aliases when calculating MSI requester
IDs. This turns out to be the wrong thing to do in the face of pure DMA
quirks like those of Marvell SATA cards, where we can end up configuring
the MSI doorbell to expect the phantom function alias, such that it then
goes on to happily ignore actual MSI writes coming from the card on the
real RID.

Improve the alias walk to only account for the topological aliases that
matter, based on the logic from the Intel IRQ remapping code.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/pci/msi.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index ba44fdfda66b..7b34c434970e 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1468,13 +1468,21 @@ struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
 }
 EXPORT_SYMBOL_GPL(pci_msi_create_irq_domain);
 
+/*
+ * If the alias device/RID is on a different bus, it's a topological alias
+ * we should care about; otherwise, it's a DMA quirk and we don't.
+ */
 static int get_msi_id_cb(struct pci_dev *pdev, u16 alias, void *data)
 {
 	u32 *pa = data;
+	u8 bus = PCI_BUS_NUM(*pa);
+
+	if (pdev->bus->number != bus || PCI_BUS_NUM(alias) != bus)
+		*pa = alias;
 
-	*pa = alias;
 	return 0;
 }
+
 /**
  * pci_msi_domain_get_msi_rid - Get the MSI requester id (RID)
  * @domain:	The interrupt domain
@@ -1488,7 +1496,7 @@ static int get_msi_id_cb(struct pci_dev *pdev, u16 alias, void *data)
 u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
 {
 	struct device_node *of_node;
-	u32 rid = 0;
+	u32 rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
 
 	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
 
@@ -1504,14 +1512,14 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
  * @pdev:	The PCI device
  *
  * Use the firmware data to find a device-specific MSI domain
- * (i.e. not one that is ste as a default).
+ * (i.e. not one that is set as a default).
  *
- * Returns: The coresponding MSI domain or NULL if none has been found.
+ * Returns: The corresponding MSI domain or NULL if none has been found.
  */
 struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
 {
 	struct irq_domain *dom;
-	u32 rid = 0;
+	u32 rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
 
 	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
 	dom = of_msi_map_get_device_domain(&pdev->dev, rid);
-- 
2.12.2.dirty
