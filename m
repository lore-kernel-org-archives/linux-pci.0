Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:33915 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757733AbaFSIbd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jun 2014 04:31:33 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Wuyun <wuyun.wu@huawei.com>,
	Xinwei Hu <huxinwei@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 4/5] PCI/MSI: MSI cleanup, msi_setup_entry()
Date: Thu, 19 Jun 2014 16:30:48 +0800
Message-ID: <1403166648-7932-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Move MSI entry stuff to a new function
msi_setup_entry(), simplify msi_capability_init()
code like MSI-X do.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/msi.c |   71 +++++++++++++++++++++++++++++++---------------------
 1 files changed, 42 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index d8e431d..8e17446 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -582,6 +582,35 @@ error_attrs:
 	return ret;
 }
 
+static int msi_setup_entry(struct pci_dev *dev)
+{
+	u16 control;
+	struct msi_desc *entry;
+
+	entry = alloc_msi_entry(dev);
+	if (!entry)
+		return -ENOMEM;
+
+	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
+
+	entry->msi_attrib.is_msix	= 0;
+	entry->msi_attrib.is_64		= !!(control & PCI_MSI_FLAGS_64BIT);
+	entry->msi_attrib.entry_nr	= 0;
+	entry->msi_attrib.maskbit	= !!(control & PCI_MSI_FLAGS_MASKBIT);
+	entry->msi_attrib.default_irq	= dev->irq;	/* Save IOAPIC IRQ */
+	entry->msi_attrib.pos		= dev->msi_cap;
+	entry->msi_attrib.multi_cap = (control & PCI_MSI_FLAGS_QMASK) >> 1;
+
+	if (control & PCI_MSI_FLAGS_64BIT)
+		entry->mask_pos = dev->msi_cap + PCI_MSI_MASK_64;
+	else
+		entry->mask_pos = dev->msi_cap + PCI_MSI_MASK_32;
+
+
+	list_add_tail(&entry->list, &dev->msi_list);
+	return 0;
+}
+
 /**
  * msi_capability_init - configure device's MSI capability structure
  * @dev: pointer to the pci_dev data structure of MSI device function
@@ -597,51 +626,30 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
 {
 	struct msi_desc *entry;
 	int ret;
-	u16 control;
 	unsigned mask;
 
 	msi_set_enable(dev, 0);	/* Disable MSI during set up */
 
-	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
 	/* MSI Entry Initialization */
-	entry = alloc_msi_entry(dev);
-	if (!entry)
-		return -ENOMEM;
-
-	entry->msi_attrib.is_msix	= 0;
-	entry->msi_attrib.is_64		= !!(control & PCI_MSI_FLAGS_64BIT);
-	entry->msi_attrib.entry_nr	= 0;
-	entry->msi_attrib.maskbit	= !!(control & PCI_MSI_FLAGS_MASKBIT);
-	entry->msi_attrib.default_irq	= dev->irq;	/* Save IOAPIC IRQ */
-	entry->msi_attrib.pos		= dev->msi_cap;
-	entry->msi_attrib.multi_cap = (control & PCI_MSI_FLAGS_QMASK) >> 1;
+	ret = msi_setup_entry(dev);
+	if (ret)
+		return ret;
 
-	if (control & PCI_MSI_FLAGS_64BIT)
-		entry->mask_pos = dev->msi_cap + PCI_MSI_MASK_64;
-	else
-		entry->mask_pos = dev->msi_cap + PCI_MSI_MASK_32;
+	entry = list_first_entry(&dev->msi_list, struct msi_desc, list);
 	/* All MSIs are unmasked by default, Mask them all */
 	if (entry->msi_attrib.maskbit)
 		pci_read_config_dword(dev, entry->mask_pos, &entry->masked);
 	mask = msi_mask(entry->msi_attrib.multi_cap);
 	msi_mask_irq(entry, mask, mask);
 
-	list_add_tail(&entry->list, &dev->msi_list);
-
 	/* Configure MSI capability structure */
 	ret = arch_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSI);
-	if (ret) {
-		msi_mask_irq(entry, mask, ~mask);
-		free_msi_irqs(dev);
-		return ret;
-	}
+	if (ret)
+		goto err;
 
 	ret = populate_msi_sysfs(dev);
-	if (ret) {
-		msi_mask_irq(entry, mask, ~mask);
-		free_msi_irqs(dev);
-		return ret;
-	}
+	if (ret)
+		goto err;
 
 	/* Set MSI enabled bits	 */
 	pci_intx_for_msi(dev, 0);
@@ -650,6 +658,11 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
 
 	dev->irq = entry->irq;
 	return 0;
+
+err:
+	msi_mask_irq(entry, mask, ~mask);
+	free_msi_irqs(dev);
+	return ret;
 }
 
 static void __iomem *msix_map_region(struct pci_dev *dev, unsigned nr_entries)
-- 
1.7.1


