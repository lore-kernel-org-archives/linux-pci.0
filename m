Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:53476 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754534AbaHVHpc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Aug 2014 03:45:32 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v2 2/5] PCI/MSI: Remove msi_attrib->pos in struct msi_desc
Date: Fri, 22 Aug 2014 16:07:57 +0800
Message-ID: <1408694880-8260-3-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1408694880-8260-1-git-send-email-wangyijing@huawei.com>
References: <1408694880-8260-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use pci_dev->msi_cap or pci_dev->msix_cap instead of
msi_desc->msi_attrib.pos, and remove pos member.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/mips/pci/msi-octeon.c         |    6 +++---
 drivers/pci/host/pcie-designware.c |    2 +-
 drivers/pci/msi.c                  |    2 --
 include/linux/msi.h                |    1 -
 4 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/mips/pci/msi-octeon.c b/arch/mips/pci/msi-octeon.c
index ab0c5d1..c8814be 100644
--- a/arch/mips/pci/msi-octeon.c
+++ b/arch/mips/pci/msi-octeon.c
@@ -73,8 +73,8 @@ int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
 	 * wants.  Most devices only want 1, which will give
 	 * configured_private_bits and request_private_bits equal 0.
 	 */
-	pci_read_config_word(dev, desc->msi_attrib.pos + PCI_MSI_FLAGS,
-			     &control);
+	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS,
+			&control);
 
 	/*
 	 * If the number of private bits has been configured then use
@@ -176,7 +176,7 @@ msi_irq_allocated:
 	/* Update the number of IRQs the device has available to it */
 	control &= ~PCI_MSI_FLAGS_QSIZE;
 	control |= request_private_bits << 4;
-	pci_write_config_word(dev, desc->msi_attrib.pos + PCI_MSI_FLAGS,
+	pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS,
 			      control);
 
 	irq_set_msi_desc(irq, desc);
diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 52bd3a1..c3706cb 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -355,7 +355,7 @@ static int dw_msi_setup_irq(struct msi_chip *chip, struct pci_dev *pdev,
 		return -EINVAL;
 	}
 
-	pci_read_config_word(pdev, desc->msi_attrib.pos+PCI_MSI_FLAGS,
+	pci_read_config_word(pdev, pdev->msi_cap + PCI_MSI_FLAGS,
 				&msg_ctr);
 	msgvec = (msg_ctr&PCI_MSI_FLAGS_QSIZE) >> 4;
 	if (msgvec == 0)
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index e2aa74e..0d0f163 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -584,7 +584,6 @@ static struct msi_desc *msi_setup_entry(struct pci_dev *dev)
 	entry->msi_attrib.entry_nr	= 0;
 	entry->msi_attrib.maskbit	= !!(control & PCI_MSI_FLAGS_MASKBIT);
 	entry->msi_attrib.default_irq	= dev->irq;	/* Save IOAPIC IRQ */
-	entry->msi_attrib.pos		= dev->msi_cap;
 	entry->msi_attrib.multi_cap	= (control & PCI_MSI_FLAGS_QMASK) >> 1;
 
 	if (control & PCI_MSI_FLAGS_64BIT)
@@ -688,7 +687,6 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
 		entry->msi_attrib.is_64		= 1;
 		entry->msi_attrib.entry_nr	= entries[i].entry;
 		entry->msi_attrib.default_irq	= dev->irq;
-		entry->msi_attrib.pos		= dev->msix_cap;
 		entry->mask_base		= base;
 
 		list_add_tail(&entry->list, &dev->msi_list);
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 8892d41..fff7201 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -29,7 +29,6 @@ struct msi_desc {
 		__u8	multi_cap : 3;	/* log2 num of messages supported */
 		__u8	maskbit	: 1;	/* mask-pending bit supported ? */
 		__u8	is_64	: 1;	/* Address size: 0=32bit 1=64bit */
-		__u8	pos;		/* Location of the msi capability */
 		__u16	entry_nr;	/* specific enabled entry */
 		unsigned default_irq;	/* default pre-assigned irq */
 	} msi_attrib;
-- 
1.7.1

