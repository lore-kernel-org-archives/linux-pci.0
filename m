Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ia0-f175.google.com ([209.85.210.175]:43962 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753629Ab3DVXKt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Apr 2013 19:10:49 -0400
Received: by mail-ia0-f175.google.com with SMTP id i38so8482iae.34
        for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2013 16:10:48 -0700 (PDT)
Subject: [PATCH v4 05/22] PCI: Use cached MSI cap while enabling MSI interrupts
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Mon, 22 Apr 2013 17:10:46 -0600
Message-ID: <20130422231046.32621.65448.stgit@bhelgaas-glaptop>
In-Reply-To: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
References: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Gavin Shan <shangw@linux.vnet.ibm.com>

The patch uses the cached MSI capability offset in pci_dev instead
of reading it from config space when enabling MSI interrupts.

[bhelgaas: removed unrelated msi_control_reg() changes]
Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/msi.c |   24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 60a4b10..0138550 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -546,14 +546,13 @@ out_unroll:
 static int msi_capability_init(struct pci_dev *dev, int nvec)
 {
 	struct msi_desc *entry;
-	int pos, ret;
+	int ret;
 	u16 control;
 	unsigned mask;
 
-	pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
 	msi_set_enable(dev, 0);	/* Disable MSI during set up */
 
-	pci_read_config_word(dev, msi_control_reg(pos), &control);
+	pci_read_config_word(dev, msi_control_reg(dev->msi_cap), &control);
 	/* MSI Entry Initialization */
 	entry = alloc_msi_entry(dev);
 	if (!entry)
@@ -564,9 +563,9 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
 	entry->msi_attrib.entry_nr	= 0;
 	entry->msi_attrib.maskbit	= is_mask_bit_support(control);
 	entry->msi_attrib.default_irq	= dev->irq;	/* Save IOAPIC IRQ */
-	entry->msi_attrib.pos		= pos;
+	entry->msi_attrib.pos		= dev->msi_cap;
 
-	entry->mask_pos = msi_mask_reg(pos, entry->msi_attrib.is_64);
+	entry->mask_pos = msi_mask_reg(dev->msi_cap, entry->msi_attrib.is_64);
 	/* All MSIs are unmasked by default, Mask them all */
 	if (entry->msi_attrib.maskbit)
 		pci_read_config_dword(dev, entry->mask_pos, &entry->masked);
@@ -807,13 +806,13 @@ static int pci_msi_check_device(struct pci_dev *dev, int nvec, int type)
  */
 int pci_enable_msi_block(struct pci_dev *dev, unsigned int nvec)
 {
-	int status, pos, maxvec;
+	int status, maxvec;
 	u16 msgctl;
 
-	pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
-	if (!pos)
+	if (!dev->msi_cap)
 		return -EINVAL;
-	pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
+
+	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &msgctl);
 	maxvec = 1 << ((msgctl & PCI_MSI_FLAGS_QMASK) >> 1);
 	if (nvec > maxvec)
 		return maxvec;
@@ -838,14 +837,13 @@ EXPORT_SYMBOL(pci_enable_msi_block);
 
 int pci_enable_msi_block_auto(struct pci_dev *dev, unsigned int *maxvec)
 {
-	int ret, pos, nvec;
+	int ret, nvec;
 	u16 msgctl;
 
-	pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
-	if (!pos)
+	if (!dev->msi_cap)
 		return -EINVAL;
 
-	pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
+	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &msgctl);
 	ret = 1 << ((msgctl & PCI_MSI_FLAGS_QMASK) >> 1);
 
 	if (maxvec)

