Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e38.co.us.ibm.com ([32.97.110.159]:42773 "EHLO
	e38.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161460Ab3DECyl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Apr 2013 22:54:41 -0400
Received: from /spool/local
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Thu, 4 Apr 2013 20:54:40 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com [9.17.195.226])
	by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 6F4521FF0026
	for <linux-pci@vger.kernel.org>; Thu,  4 Apr 2013 20:49:39 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r352scVx125838
	for <linux-pci@vger.kernel.org>; Thu, 4 Apr 2013 20:54:38 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r352sbWm032608
	for <linux-pci@vger.kernel.org>; Thu, 4 Apr 2013 20:54:38 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: [PATCH 4/4] PCI: Use cached MSI-X cap while enabling MSI-X
Date: Fri,  5 Apr 2013 10:54:33 +0800
Message-Id: <1365130473-7413-5-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1365130473-7413-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1365130473-7413-1-git-send-email-shangw@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch intends to use the cached MSI-X capability offset in
pci_dev instead of polling that from config space when enabling
MSI-X interrupts.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 drivers/pci/msi.c |   34 +++++++++++++++-------------------
 1 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 449db36..212cea3 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -599,14 +599,14 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
 	return 0;
 }
 
-static void __iomem *msix_map_region(struct pci_dev *dev, unsigned pos,
-							unsigned nr_entries)
+static void __iomem *msix_map_region(struct pci_dev *dev, unsigned nr_entries)
 {
 	resource_size_t phys_addr;
 	u32 table_offset;
 	u8 bir;
 
-	pci_read_config_dword(dev, msix_table_offset_reg(pos), &table_offset);
+	pci_read_config_dword(dev,
+		msix_table_offset_reg(dev->msix_cap), &table_offset);
 	bir = (u8)(table_offset & PCI_MSIX_FLAGS_BIRMASK);
 	table_offset &= ~PCI_MSIX_FLAGS_BIRMASK;
 	phys_addr = pci_resource_start(dev, bir) + table_offset;
@@ -614,9 +614,8 @@ static void __iomem *msix_map_region(struct pci_dev *dev, unsigned pos,
 	return ioremap_nocache(phys_addr, nr_entries * PCI_MSIX_ENTRY_SIZE);
 }
 
-static int msix_setup_entries(struct pci_dev *dev, unsigned pos,
-				void __iomem *base, struct msix_entry *entries,
-				int nvec)
+static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
+			      struct msix_entry *entries, int nvec)
 {
 	struct msi_desc *entry;
 	int i;
@@ -636,7 +635,7 @@ static int msix_setup_entries(struct pci_dev *dev, unsigned pos,
 		entry->msi_attrib.is_64		= 1;
 		entry->msi_attrib.entry_nr	= entries[i].entry;
 		entry->msi_attrib.default_irq	= dev->irq;
-		entry->msi_attrib.pos		= pos;
+		entry->msi_attrib.pos		= dev->msix_cap;
 		entry->mask_base		= base;
 
 		list_add_tail(&entry->list, &dev->msi_list);
@@ -676,23 +675,22 @@ static void msix_program_entries(struct pci_dev *dev,
 static int msix_capability_init(struct pci_dev *dev,
 				struct msix_entry *entries, int nvec)
 {
-	int pos, ret;
+	int ret;
 	u16 control;
 	void __iomem *base;
 
-	pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
-	pci_read_config_word(dev, pos + PCI_MSIX_FLAGS, &control);
+	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &control);
 
 	/* Ensure MSI-X is disabled while it is set up */
 	control &= ~PCI_MSIX_FLAGS_ENABLE;
-	pci_write_config_word(dev, pos + PCI_MSIX_FLAGS, control);
+	pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, control);
 
 	/* Request & Map MSI-X table region */
-	base = msix_map_region(dev, pos, multi_msix_capable(control));
+	base = msix_map_region(dev, multi_msix_capable(control));
 	if (!base)
 		return -ENOMEM;
 
-	ret = msix_setup_entries(dev, pos, base, entries, nvec);
+	ret = msix_setup_entries(dev, base, entries, nvec);
 	if (ret)
 		return ret;
 
@@ -706,7 +704,7 @@ static int msix_capability_init(struct pci_dev *dev,
 	 * interrupts coming in before they're fully set up.
 	 */
 	control |= PCI_MSIX_FLAGS_MASKALL | PCI_MSIX_FLAGS_ENABLE;
-	pci_write_config_word(dev, pos + PCI_MSIX_FLAGS, control);
+	pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, control);
 
 	msix_program_entries(dev, entries);
 
@@ -721,7 +719,7 @@ static int msix_capability_init(struct pci_dev *dev,
 	dev->msix_enabled = 1;
 
 	control &= ~PCI_MSIX_FLAGS_MASKALL;
-	pci_write_config_word(dev, pos + PCI_MSIX_FLAGS, control);
+	pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, control);
 
 	return 0;
 
@@ -906,14 +904,12 @@ EXPORT_SYMBOL(pci_disable_msi);
  */
 int pci_msix_table_size(struct pci_dev *dev)
 {
-	int pos;
 	u16 control;
 
-	pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
-	if (!pos)
+	if (!dev->msix_cap)
 		return 0;
 
-	pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &control);
+	pci_read_config_word(dev, dev->msix_cap + PCI_MSI_FLAGS, &control);
 	return multi_msix_capable(control);
 }
 
-- 
1.7.5.4

