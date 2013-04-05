Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:50616 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161463Ab3DECym (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Apr 2013 22:54:42 -0400
Received: from /spool/local
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Thu, 4 Apr 2013 20:54:41 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com [9.17.195.228])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id B90413E40039
	for <linux-pci@vger.kernel.org>; Thu,  4 Apr 2013 20:54:25 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r352sbPe106324
	for <linux-pci@vger.kernel.org>; Thu, 4 Apr 2013 20:54:37 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r352sbu5009605
	for <linux-pci@vger.kernel.org>; Thu, 4 Apr 2013 20:54:37 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: [PATCH 3/4] PCI: Use cached MSI cap while enabling MSI interrupts
Date: Fri,  5 Apr 2013 10:54:32 +0800
Message-Id: <1365130473-7413-4-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1365130473-7413-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1365130473-7413-1-git-send-email-shangw@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch intends to use the cached MSI capability offset in
pci_dev instead of polling that from config space when enabling
MSI interrupts.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 drivers/pci/msi.c |   32 +++++++++++++++-----------------
 drivers/pci/msi.h |    1 -
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 1ec1ba9..449db36 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -299,10 +299,10 @@ void __write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 		int pos = entry->msi_attrib.pos;
 		u16 msgctl;
 
-		pci_read_config_word(dev, msi_control_reg(pos), &msgctl);
+		pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
 		msgctl &= ~PCI_MSI_FLAGS_QSIZE;
 		msgctl |= entry->msi_attrib.multiple << 4;
-		pci_write_config_word(dev, msi_control_reg(pos), msgctl);
+		pci_write_config_word(dev, pos + PCI_MSI_FLAGS, msgctl);
 
 		pci_write_config_dword(dev, msi_lower_address_reg(pos),
 					msg->address_lo);
@@ -546,14 +546,14 @@ out_unroll:
 static int msi_capability_init(struct pci_dev *dev, int nvec)
 {
 	struct msi_desc *entry;
-	int pos, ret;
+	int ret;
 	u16 control;
 	unsigned mask;
 
-	pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
-	msi_set_enable(dev, 0);	/* Disable MSI during set up */
+	/* Disable MSI during set up */
+	msi_set_enable(dev, 0);
 
-	pci_read_config_word(dev, msi_control_reg(pos), &control);
+	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
 	/* MSI Entry Initialization */
 	entry = alloc_msi_entry(dev);
 	if (!entry)
@@ -564,9 +564,9 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
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
@@ -807,13 +807,12 @@ static int pci_msi_check_device(struct pci_dev *dev, int nvec, int type)
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
@@ -915,7 +913,7 @@ int pci_msix_table_size(struct pci_dev *dev)
 	if (!pos)
 		return 0;
 
-	pci_read_config_word(dev, msi_control_reg(pos), &control);
+	pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &control);
 	return multi_msix_capable(control);
 }
 
diff --git a/drivers/pci/msi.h b/drivers/pci/msi.h
index 65c42f8..6aa7b19 100644
--- a/drivers/pci/msi.h
+++ b/drivers/pci/msi.h
@@ -6,7 +6,6 @@
 #ifndef MSI_H
 #define MSI_H
 
-#define msi_control_reg(base)		(base + PCI_MSI_FLAGS)
 #define msi_lower_address_reg(base)	(base + PCI_MSI_ADDRESS_LO)
 #define msi_upper_address_reg(base)	(base + PCI_MSI_ADDRESS_HI)
 #define msi_data_reg(base, is64bit)	\
-- 
1.7.5.4

