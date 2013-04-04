Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139]:42890 "EHLO e9.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758672Ab3DDLjo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Apr 2013 07:39:44 -0400
Received: from /spool/local
	by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Thu, 4 Apr 2013 07:39:43 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 666256E8044
	for <linux-pci@vger.kernel.org>; Thu,  4 Apr 2013 07:39:37 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r34BddPh306112
	for <linux-pci@vger.kernel.org>; Thu, 4 Apr 2013 07:39:39 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r34BddCn009897
	for <linux-pci@vger.kernel.org>; Thu, 4 Apr 2013 07:39:39 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: [PATCH 3/5] PCI: Use cached MSI cap while enabling MSI interrupts
Date: Thu,  4 Apr 2013 19:39:30 +0800
Message-Id: <1365075572-20763-4-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1365075572-20763-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1365075572-20763-1-git-send-email-shangw@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch intends to use the cached MSI capability offset in
pci_dev instead of polling that from config space when enabling
MSI interrupts.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 drivers/pci/msi.c |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 5f51e10..182474d 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -552,14 +552,14 @@ out_unroll:
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
+	pci_read_config_word(dev, msi_control_reg(dev->msi_cap), &control);
 	/* MSI Entry Initialization */
 	entry = alloc_msi_entry(dev);
 	if (!entry)
@@ -570,9 +570,9 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
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
@@ -818,13 +818,12 @@ static int pci_msi_check_device(struct pci_dev *dev, int nvec, int type)
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
-- 
1.7.5.4

