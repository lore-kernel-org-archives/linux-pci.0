Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:26737 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757671AbaFSIaK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jun 2014 04:30:10 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Wuyun <wuyun.wu@huawei.com>,
	Xinwei Hu <huxinwei@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 1/5] PCI/MSI: Introduce msix_clear_and_set_ctrl() function
Date: Thu, 19 Jun 2014 16:29:53 +0800
Message-ID: <1403166593-3016-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Introudce msix_clear_and_set_ctrl() function to
clear and set msix control register for code simplification.
Clean up msix_set_enable().

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/msi.c |   40 +++++++++++++++++-----------------------
 1 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 27a7e67..7c9fb3a 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -149,15 +149,15 @@ static void msi_set_enable(struct pci_dev *dev, int enable)
 	pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);
 }
 
-static void msix_set_enable(struct pci_dev *dev, int enable)
+static void msix_clear_and_set_ctrl(struct pci_dev *dev,
+		u16 clear, u16 set)
 {
-	u16 control;
+	u16 ctrl;
 
-	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &control);
-	control &= ~PCI_MSIX_FLAGS_ENABLE;
-	if (enable)
-		control |= PCI_MSIX_FLAGS_ENABLE;
-	pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, control);
+	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
+	ctrl &= ~clear;
+	ctrl |= set;
+	pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, ctrl);
 }
 
 static inline __attribute_const__ u32 msi_mask(unsigned x)
@@ -469,26 +469,23 @@ static void __pci_restore_msi_state(struct pci_dev *dev)
 static void __pci_restore_msix_state(struct pci_dev *dev)
 {
 	struct msi_desc *entry;
-	u16 control;
 
 	if (!dev->msix_enabled)
 		return;
 	BUG_ON(list_empty(&dev->msi_list));
 	entry = list_first_entry(&dev->msi_list, struct msi_desc, list);
-	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &control);
 
 	/* route the table */
 	pci_intx_for_msi(dev, 0);
-	control |= PCI_MSIX_FLAGS_ENABLE | PCI_MSIX_FLAGS_MASKALL;
-	pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, control);
+	msix_clear_and_set_ctrl(dev, 0,
+			PCI_MSIX_FLAGS_ENABLE | PCI_MSIX_FLAGS_MASKALL);
 
 	arch_restore_msi_irqs(dev);
 	list_for_each_entry(entry, &dev->msi_list, list) {
 		msix_mask_irq(entry, entry->masked);
 	}
 
-	control &= ~PCI_MSIX_FLAGS_MASKALL;
-	pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, control);
+	msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
 }
 
 void pci_restore_msi_state(struct pci_dev *dev)
@@ -743,12 +740,10 @@ static int msix_capability_init(struct pci_dev *dev,
 	u16 control;
 	void __iomem *base;
 
-	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &control);
-
 	/* Ensure MSI-X is disabled while it is set up */
-	control &= ~PCI_MSIX_FLAGS_ENABLE;
-	pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, control);
+	msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
 
+	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &control);
 	/* Request & Map MSI-X table region */
 	base = msix_map_region(dev, msix_table_size(control));
 	if (!base)
@@ -767,8 +762,8 @@ static int msix_capability_init(struct pci_dev *dev,
 	 * MSI-X registers.  We need to mask all the vectors to prevent
 	 * interrupts coming in before they're fully set up.
 	 */
-	control |= PCI_MSIX_FLAGS_MASKALL | PCI_MSIX_FLAGS_ENABLE;
-	pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, control);
+	msix_clear_and_set_ctrl(dev, 0,
+			PCI_MSIX_FLAGS_MASKALL | PCI_MSIX_FLAGS_ENABLE);
 
 	msix_program_entries(dev, entries);
 
@@ -780,8 +775,7 @@ static int msix_capability_init(struct pci_dev *dev,
 	pci_intx_for_msi(dev, 0);
 	dev->msix_enabled = 1;
 
-	control &= ~PCI_MSIX_FLAGS_MASKALL;
-	pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, control);
+	msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
 
 	return 0;
 
@@ -1002,7 +996,7 @@ void pci_msix_shutdown(struct pci_dev *dev)
 		arch_msix_mask_irq(entry, 1);
 	}
 
-	msix_set_enable(dev, 0);
+	msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
 	pci_intx_for_msi(dev, 1);
 	dev->msix_enabled = 0;
 }
@@ -1066,7 +1060,7 @@ void pci_msi_init_pci_dev(struct pci_dev *dev)
 
 	dev->msix_cap = pci_find_capability(dev, PCI_CAP_ID_MSIX);
 	if (dev->msix_cap)
-		msix_set_enable(dev, 0);
+		msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
 }
 
 /**
-- 
1.7.1


