Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:35025 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754722AbaGDIPJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jul 2014 04:15:09 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Wuyun <wuyun.wu@huawei.com>,
	Xinwei Hu <huxinwei@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v2 1/5] PCI/MSI: MSI cleanup, msi_setup_entry()
Date: Fri, 4 Jul 2014 16:14:52 +0800
Message-ID: <1404461692-5572-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Move MSI entry stuff to a new function
msi_setup_entry(), simplify msi_capability_init()
code like MSI-X do.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/msi.c |   51 +++++++++++++++++++++++++++++++++------------------
 1 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 50a7e4e..c306883 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -581,6 +581,38 @@ error_attrs:
 	return ret;
 }
 
+static struct msi_desc *msi_setup_entry(struct pci_dev *dev)
+{
+	u16 control;
+	struct msi_desc *entry;
+
+	/* MSI Entry Initialization */
+	entry = alloc_msi_entry(dev);
+	if (!entry)
+		return NULL;
+
+	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
+
+	entry->msi_attrib.is_msix	= 0;
+	entry->msi_attrib.is_64		= !!(control & PCI_MSI_FLAGS_64BIT);
+	entry->msi_attrib.entry_nr	= 0;
+	entry->msi_attrib.maskbit	= !!(control & PCI_MSI_FLAGS_MASKBIT);
+	entry->msi_attrib.default_irq	= dev->irq;	/* Save IOAPIC IRQ */
+	entry->msi_attrib.pos		= dev->msi_cap;
+	entry->msi_attrib.multi_cap	= (control & PCI_MSI_FLAGS_QMASK) >> 1;
+
+	if (control & PCI_MSI_FLAGS_64BIT)
+		entry->mask_pos = dev->msi_cap + PCI_MSI_MASK_64;
+	else
+		entry->mask_pos = dev->msi_cap + PCI_MSI_MASK_32;
+
+	/* Save the initial mask status */
+	if (entry->msi_attrib.maskbit)
+		pci_read_config_dword(dev, entry->mask_pos, &entry->masked);
+
+	return entry;
+}
+
 /**
  * msi_capability_init - configure device's MSI capability structure
  * @dev: pointer to the pci_dev data structure of MSI device function
@@ -596,32 +628,15 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
 {
 	struct msi_desc *entry;
 	int ret;
-	u16 control;
 	unsigned mask;
 
 	msi_set_enable(dev, 0);	/* Disable MSI during set up */
 
-	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
-	/* MSI Entry Initialization */
-	entry = alloc_msi_entry(dev);
+	entry = msi_setup_entry(dev);
 	if (!entry)
 		return -ENOMEM;
 
-	entry->msi_attrib.is_msix	= 0;
-	entry->msi_attrib.is_64		= !!(control & PCI_MSI_FLAGS_64BIT);
-	entry->msi_attrib.entry_nr	= 0;
-	entry->msi_attrib.maskbit	= !!(control & PCI_MSI_FLAGS_MASKBIT);
-	entry->msi_attrib.default_irq	= dev->irq;	/* Save IOAPIC IRQ */
-	entry->msi_attrib.pos		= dev->msi_cap;
-	entry->msi_attrib.multi_cap	= (control & PCI_MSI_FLAGS_QMASK) >> 1;
-
-	if (control & PCI_MSI_FLAGS_64BIT)
-		entry->mask_pos = dev->msi_cap + PCI_MSI_MASK_64;
-	else
-		entry->mask_pos = dev->msi_cap + PCI_MSI_MASK_32;
 	/* All MSIs are unmasked by default, Mask them all */
-	if (entry->msi_attrib.maskbit)
-		pci_read_config_dword(dev, entry->mask_pos, &entry->masked);
 	mask = msi_mask(entry->msi_attrib.multi_cap);
 	msi_mask_irq(entry, mask, mask);
 
-- 
1.7.1


