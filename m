Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:58079 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932131AbcGLJUo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jul 2016 05:20:44 -0400
From: Christoph Hellwig <hch@lst.de>
To: linux-pci@vger.kernel.org
Cc: agordeev@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] pci: make the entries argument to pci_enable_msix optional
Date: Tue, 12 Jul 2016 18:20:16 +0900
Message-Id: <1468315218-20490-4-git-send-email-hch@lst.de>
In-Reply-To: <1468315218-20490-1-git-send-email-hch@lst.de>
References: <1468315218-20490-1-git-send-email-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The entries argument isn't needed if the list of entries does not
contain any holes.  Make it optional so that we can the need for
having to allocate a msix_entry structure for this (common) case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Alexander Gordeev <agordeev@redhat.com>
---
 drivers/pci/msi.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index a385f39..98ace67 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -695,7 +695,10 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
 
 		entry->msi_attrib.is_msix	= 1;
 		entry->msi_attrib.is_64		= 1;
-		entry->msi_attrib.entry_nr	= entries[i].entry;
+		if (entries)
+			entry->msi_attrib.entry_nr = entries[i].entry;
+		else
+			entry->msi_attrib.entry_nr = i;
 		entry->msi_attrib.default_irq	= dev->irq;
 		entry->mask_base		= base;
 		entry->nvec_used		= 1;
@@ -713,11 +716,11 @@ static void msix_program_entries(struct pci_dev *dev,
 	int i = 0;
 
 	for_each_pci_msi_entry(entry, dev) {
-		entries[i].vector = entry->irq;
+		if (entries)
+			entries[i++].vector = entry->irq;
 		entry->masked = readl(pci_msix_desc_addr(entry) +
 				PCI_MSIX_ENTRY_VECTOR_CTRL);
 		msix_mask_irq(entry, 1);
-		i++;
 	}
 }
 
@@ -930,7 +933,7 @@ EXPORT_SYMBOL(pci_msix_vec_count);
 /**
  * pci_enable_msix - configure device's MSI-X capability structure
  * @dev: pointer to the pci_dev data structure of MSI-X device function
- * @entries: pointer to an array of MSI-X entries
+ * @entries: pointer to an array of MSI-X entries (optional)
  * @nvec: number of MSI-X irqs requested for allocation by device driver
  *
  * Setup the MSI-X capability structure of device function with the number
@@ -950,22 +953,21 @@ int pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries, int nvec)
 	if (!pci_msi_supported(dev, nvec))
 		return -EINVAL;
 
-	if (!entries)
-		return -EINVAL;
-
 	nr_entries = pci_msix_vec_count(dev);
 	if (nr_entries < 0)
 		return nr_entries;
 	if (nvec > nr_entries)
 		return nr_entries;
 
-	/* Check for any invalid entries */
-	for (i = 0; i < nvec; i++) {
-		if (entries[i].entry >= nr_entries)
-			return -EINVAL;		/* invalid entry */
-		for (j = i + 1; j < nvec; j++) {
-			if (entries[i].entry == entries[j].entry)
-				return -EINVAL;	/* duplicate entry */
+	if (entries) {
+		/* Check for any invalid entries */
+		for (i = 0; i < nvec; i++) {
+			if (entries[i].entry >= nr_entries)
+				return -EINVAL;		/* invalid entry */
+			for (j = i + 1; j < nvec; j++) {
+				if (entries[i].entry == entries[j].entry)
+					return -EINVAL;	/* duplicate entry */
+			}
 		}
 	}
 	WARN_ON(!!dev->msix_enabled);
-- 
2.1.4

