Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:33406 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129AbcGJL5x (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 10 Jul 2016 07:57:53 -0400
From: Christoph Hellwig <hch@lst.de>
To: linux-pci@vger.kernel.org
Cc: agordeev@redhat.com
Subject: [PATCH 1/5] pci: add a pci_msix_desc_addr helper
Date: Sun, 10 Jul 2016 20:57:42 +0900
Message-Id: <1468151866-7776-2-git-send-email-hch@lst.de>
In-Reply-To: <1468151866-7776-1-git-send-email-hch@lst.de>
References: <1468151866-7776-1-git-send-email-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

To factor out the calculation of the base address for a given MSI-X vector.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/msi.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index a080f44..0d94fbf 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -207,6 +207,12 @@ static void msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
 	desc->masked = __pci_msi_desc_mask_irq(desc, mask, flag);
 }
 
+static void __iomem *pci_msix_desc_addr(struct msi_desc *desc)
+{
+	return desc->mask_base +
+		desc->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE;
+}
+
 /*
  * This internal function does not flush PCI writes to the device.
  * All users must ensure that they read from the device before either
@@ -217,8 +223,6 @@ static void msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
 u32 __pci_msix_desc_mask_irq(struct msi_desc *desc, u32 flag)
 {
 	u32 mask_bits = desc->masked;
-	unsigned offset = desc->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE +
-						PCI_MSIX_ENTRY_VECTOR_CTRL;
 
 	if (pci_msi_ignore_mask)
 		return 0;
@@ -226,7 +230,7 @@ u32 __pci_msix_desc_mask_irq(struct msi_desc *desc, u32 flag)
 	mask_bits &= ~PCI_MSIX_ENTRY_CTRL_MASKBIT;
 	if (flag)
 		mask_bits |= PCI_MSIX_ENTRY_CTRL_MASKBIT;
-	writel(mask_bits, desc->mask_base + offset);
+	writel(mask_bits, pci_msix_desc_addr(desc) + PCI_MSIX_ENTRY_VECTOR_CTRL);
 
 	return mask_bits;
 }
@@ -284,8 +288,7 @@ void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 	BUG_ON(dev->current_state != PCI_D0);
 
 	if (entry->msi_attrib.is_msix) {
-		void __iomem *base = entry->mask_base +
-			entry->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE;
+		void __iomem *base = pci_msix_desc_addr(entry);
 
 		msg->address_lo = readl(base + PCI_MSIX_ENTRY_LOWER_ADDR);
 		msg->address_hi = readl(base + PCI_MSIX_ENTRY_UPPER_ADDR);
@@ -315,9 +318,7 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 	if (dev->current_state != PCI_D0) {
 		/* Don't touch the hardware now */
 	} else if (entry->msi_attrib.is_msix) {
-		void __iomem *base;
-		base = entry->mask_base +
-			entry->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE;
+		void __iomem *base = pci_msix_desc_addr(entry);
 
 		writel(msg->address_lo, base + PCI_MSIX_ENTRY_LOWER_ADDR);
 		writel(msg->address_hi, base + PCI_MSIX_ENTRY_UPPER_ADDR);
-- 
2.1.4

