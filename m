Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:35133 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753665Ab3DVXLJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Apr 2013 19:11:09 -0400
Received: by mail-ie0-f174.google.com with SMTP id 10so13940ied.19
        for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2013 16:11:09 -0700 (PDT)
Subject: [PATCH v4 08/22] PCI: Use cached MSI/MSI-X offsets from dev,
 not from msi_desc
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Mon, 22 Apr 2013 17:11:07 -0600
Message-ID: <20130422231107.32621.49426.stgit@bhelgaas-glaptop>
In-Reply-To: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
References: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We always know the type (MSI vs MSI-X), so we can use the correct
cached capability offset rather than relying on the copy in the
msi_attrib.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/msi.c |   22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 79d9d04..631249e 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -241,7 +241,7 @@ void __read_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 		msg->data = readl(base + PCI_MSIX_ENTRY_DATA);
 	} else {
 		struct pci_dev *dev = entry->dev;
-		int pos = entry->msi_attrib.pos;
+		int pos = dev->msi_cap;
 		u16 data;
 
 		pci_read_config_dword(dev, msi_lower_address_reg(pos),
@@ -296,7 +296,7 @@ void __write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 		writel(msg->data, base + PCI_MSIX_ENTRY_DATA);
 	} else {
 		struct pci_dev *dev = entry->dev;
-		int pos = entry->msi_attrib.pos;
+		int pos = dev->msi_cap;
 		u16 msgctl;
 
 		pci_read_config_word(dev, msi_control_reg(pos), &msgctl);
@@ -385,7 +385,6 @@ static void pci_intx_for_msi(struct pci_dev *dev, int enable)
 
 static void __pci_restore_msi_state(struct pci_dev *dev)
 {
-	int pos;
 	u16 control;
 	struct msi_desc *entry;
 
@@ -393,22 +392,20 @@ static void __pci_restore_msi_state(struct pci_dev *dev)
 		return;
 
 	entry = irq_get_msi_desc(dev->irq);
-	pos = entry->msi_attrib.pos;
 
 	pci_intx_for_msi(dev, 0);
 	msi_set_enable(dev, 0);
 	arch_restore_msi_irqs(dev, dev->irq);
 
-	pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &control);
+	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
 	msi_mask_irq(entry, msi_capable_mask(control), entry->masked);
 	control &= ~PCI_MSI_FLAGS_QSIZE;
 	control |= (entry->msi_attrib.multiple << 4) | PCI_MSI_FLAGS_ENABLE;
-	pci_write_config_word(dev, pos + PCI_MSI_FLAGS, control);
+	pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);
 }
 
 static void __pci_restore_msix_state(struct pci_dev *dev)
 {
-	int pos;
 	struct msi_desc *entry;
 	u16 control;
 
@@ -416,13 +413,12 @@ static void __pci_restore_msix_state(struct pci_dev *dev)
 		return;
 	BUG_ON(list_empty(&dev->msi_list));
 	entry = list_first_entry(&dev->msi_list, struct msi_desc, list);
-	pos = entry->msi_attrib.pos;
-	pci_read_config_word(dev, pos + PCI_MSIX_FLAGS, &control);
+	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &control);
 
 	/* route the table */
 	pci_intx_for_msi(dev, 0);
 	control |= PCI_MSIX_FLAGS_ENABLE | PCI_MSIX_FLAGS_MASKALL;
-	pci_write_config_word(dev, pos + PCI_MSIX_FLAGS, control);
+	pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, control);
 
 	list_for_each_entry(entry, &dev->msi_list, list) {
 		arch_restore_msi_irqs(dev, entry->irq);
@@ -430,7 +426,7 @@ static void __pci_restore_msix_state(struct pci_dev *dev)
 	}
 
 	control &= ~PCI_MSIX_FLAGS_MASKALL;
-	pci_write_config_word(dev, pos + PCI_MSIX_FLAGS, control);
+	pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, control);
 }
 
 void pci_restore_msi_state(struct pci_dev *dev)
@@ -863,21 +859,19 @@ void pci_msi_shutdown(struct pci_dev *dev)
 	struct msi_desc *desc;
 	u32 mask;
 	u16 ctrl;
-	unsigned pos;
 
 	if (!pci_msi_enable || !dev || !dev->msi_enabled)
 		return;
 
 	BUG_ON(list_empty(&dev->msi_list));
 	desc = list_first_entry(&dev->msi_list, struct msi_desc, list);
-	pos = desc->msi_attrib.pos;
 
 	msi_set_enable(dev, 0);
 	pci_intx_for_msi(dev, 1);
 	dev->msi_enabled = 0;
 
 	/* Return the device with MSI unmasked as initial states */
-	pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &ctrl);
+	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &ctrl);
 	mask = msi_capable_mask(ctrl);
 	/* Keep cached state to be restored */
 	__msi_mask_irq(desc, mask, ~mask);

