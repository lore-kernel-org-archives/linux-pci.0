Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:63414 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753742Ab3DVXKz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Apr 2013 19:10:55 -0400
Received: by mail-ie0-f180.google.com with SMTP id to1so11108ieb.39
        for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2013 16:10:55 -0700 (PDT)
Subject: [PATCH v4 06/22] PCI: Use cached MSI-X cap while enabling MSI-X
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Mon, 22 Apr 2013 17:10:53 -0600
Message-ID: <20130422231053.32621.21415.stgit@bhelgaas-glaptop>
In-Reply-To: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
References: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Gavin Shan <shangw@linux.vnet.ibm.com>

The patch uses the cached MSI-X capability offset in
pci_dev instead of reading it from config space when enabling
MSI-X interrupts.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/msi.c |   36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 0138550..79d9d04 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -598,14 +598,14 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
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
@@ -613,9 +613,8 @@ static void __iomem *msix_map_region(struct pci_dev *dev, unsigned pos,
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
@@ -635,7 +634,7 @@ static int msix_setup_entries(struct pci_dev *dev, unsigned pos,
 		entry->msi_attrib.is_64		= 1;
 		entry->msi_attrib.entry_nr	= entries[i].entry;
 		entry->msi_attrib.default_irq	= dev->irq;
-		entry->msi_attrib.pos		= pos;
+		entry->msi_attrib.pos		= dev->msix_cap;
 		entry->mask_base		= base;
 
 		list_add_tail(&entry->list, &dev->msi_list);
@@ -645,7 +644,7 @@ static int msix_setup_entries(struct pci_dev *dev, unsigned pos,
 }
 
 static void msix_program_entries(struct pci_dev *dev,
-					struct msix_entry *entries)
+				 struct msix_entry *entries)
 {
 	struct msi_desc *entry;
 	int i = 0;
@@ -675,23 +674,22 @@ static void msix_program_entries(struct pci_dev *dev,
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
 
@@ -705,7 +703,7 @@ static int msix_capability_init(struct pci_dev *dev,
 	 * interrupts coming in before they're fully set up.
 	 */
 	control |= PCI_MSIX_FLAGS_MASKALL | PCI_MSIX_FLAGS_ENABLE;
-	pci_write_config_word(dev, pos + PCI_MSIX_FLAGS, control);
+	pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, control);
 
 	msix_program_entries(dev, entries);
 
@@ -720,7 +718,7 @@ static int msix_capability_init(struct pci_dev *dev,
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
 
-	pci_read_config_word(dev, msi_control_reg(pos), &control);
+	pci_read_config_word(dev, msi_control_reg(dev->msix_cap), &control);
 	return multi_msix_capable(control);
 }
 

