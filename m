Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:33756 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757712AbaFSIbc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jun 2014 04:31:32 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Wuyun <wuyun.wu@huawei.com>,
	Xinwei Hu <huxinwei@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 3/5] PCI/MSI: Cache Multiple Message Capable info in msi_desc
Date: Thu, 19 Jun 2014 16:30:30 +0800
Message-ID: <1403166630-5252-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Multiple Message Capabale is read-only indicates the max
vector number device support. Cache it in msi_desc to avoid
access these bits repeatly. Then we remove the unused
function msi_capable_mask().

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/msi.c   |   15 +++++----------
 include/linux/msi.h |    1 +
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index dd34dbe..d8e431d 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -168,11 +168,6 @@ static inline __attribute_const__ u32 msi_mask(unsigned x)
 	return (1 << (1 << x)) - 1;
 }
 
-static inline __attribute_const__ u32 msi_capable_mask(u16 control)
-{
-	return msi_mask((control >> 1) & 7);
-}
-
 /*
  * PCI 2.3 does not specify mask bits for each MSI interrupt.  Attempting to
  * mask all MSI interrupts by clearing the MSI enable bit does not work
@@ -455,7 +450,8 @@ static void __pci_restore_msi_state(struct pci_dev *dev)
 	arch_restore_msi_irqs(dev);
 
 	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
-	msi_mask_irq(entry, msi_capable_mask(control), entry->masked);
+	msi_mask_irq(entry, msi_mask(entry->msi_attrib.multi_cap),
+			entry->masked);
 	control &= ~PCI_MSI_FLAGS_QSIZE;
 	control |= (entry->msi_attrib.multiple << 4) | PCI_MSI_FLAGS_ENABLE;
 	pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);
@@ -618,6 +614,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
 	entry->msi_attrib.maskbit	= !!(control & PCI_MSI_FLAGS_MASKBIT);
 	entry->msi_attrib.default_irq	= dev->irq;	/* Save IOAPIC IRQ */
 	entry->msi_attrib.pos		= dev->msi_cap;
+	entry->msi_attrib.multi_cap = (control & PCI_MSI_FLAGS_QMASK) >> 1;
 
 	if (control & PCI_MSI_FLAGS_64BIT)
 		entry->mask_pos = dev->msi_cap + PCI_MSI_MASK_64;
@@ -626,7 +623,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
 	/* All MSIs are unmasked by default, Mask them all */
 	if (entry->msi_attrib.maskbit)
 		pci_read_config_dword(dev, entry->mask_pos, &entry->masked);
-	mask = msi_capable_mask(control);
+	mask = msi_mask(entry->msi_attrib.multi_cap);
 	msi_mask_irq(entry, mask, mask);
 
 	list_add_tail(&entry->list, &dev->msi_list);
@@ -871,7 +868,6 @@ void pci_msi_shutdown(struct pci_dev *dev)
 {
 	struct msi_desc *desc;
 	u32 mask;
-	u16 ctrl;
 
 	if (!pci_msi_enable || !dev || !dev->msi_enabled)
 		return;
@@ -884,8 +880,7 @@ void pci_msi_shutdown(struct pci_dev *dev)
 	dev->msi_enabled = 0;
 
 	/* Return the device with MSI unmasked as initial states */
-	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &ctrl);
-	mask = msi_capable_mask(ctrl);
+	mask = msi_mask(desc->msi_attrib.multi_cap);
 	/* Keep cached state to be restored */
 	arch_msi_mask_irq(desc, mask, ~mask);
 
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 92a2f99..a91156e 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -26,6 +26,7 @@ struct msi_desc {
 	struct {
 		__u8	is_msix	: 1;
 		__u8	multiple: 3;	/* log2 number of messages */
+		__u8	multi_cap : 3;	/* max log2 number of messages support */
 		__u8	maskbit	: 1;	/* mask-pending bit supported ? */
 		__u8	is_64	: 1;	/* Address size: 0=32bit 1=64bit */
 		__u8	pos;		/* Location of the msi capability */
-- 
1.7.1


