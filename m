Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:27393 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689Ab3HHL4e (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Aug 2013 07:56:34 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
	<jiang.liu@huawei.com>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH] PCI: use msi/x_set_enable() to simplify pci_msi_off()
Date: Thu, 8 Aug 2013 19:56:09 +0800
Message-ID: <1375962969-34824-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Move pci_msi_off() to driver/pci/msi.c and use msi_set_enable()
and msix_set_enable() to simplify pci_msi_off() function code.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/msi.c |   17 +++++++++++++++++
 drivers/pci/pci.c |   28 ----------------------------
 2 files changed, 17 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index aca7578..080d14f 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1002,6 +1002,23 @@ void pci_disable_msix(struct pci_dev *dev)
 EXPORT_SYMBOL(pci_disable_msix);
 
 /**
+ * pci_msi_off - disables any msi or msix capabilities
+ * @dev: the PCI device to operate on
+ *
+ * If you want to use msi see pci_enable_msi and friends.
+ * This is a lower level primitive that allows us to disable
+ * msi operation at the device level.
+ */
+void pci_msi_off(struct pci_dev *dev)
+{
+	if (dev->msi_cap)
+		msi_set_enable(dev, 0);
+	if (dev->msix_cap)
+		msix_set_enable(dev, 0);
+}
+EXPORT_SYMBOL_GPL(pci_msi_off);
+
+/**
  * msi_remove_pci_irq_vectors - reclaim MSI(X) irqs to unused state
  * @dev: pointer to the pci_dev data structure of MSI(X) device function
  *
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e37fea6..6975f2a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3058,34 +3058,6 @@ bool pci_check_and_unmask_intx(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_check_and_unmask_intx);
 
-/**
- * pci_msi_off - disables any msi or msix capabilities
- * @dev: the PCI device to operate on
- *
- * If you want to use msi see pci_enable_msi and friends.
- * This is a lower level primitive that allows us to disable
- * msi operation at the device level.
- */
-void pci_msi_off(struct pci_dev *dev)
-{
-	int pos;
-	u16 control;
-
-	pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
-	if (pos) {
-		pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &control);
-		control &= ~PCI_MSI_FLAGS_ENABLE;
-		pci_write_config_word(dev, pos + PCI_MSI_FLAGS, control);
-	}
-	pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
-	if (pos) {
-		pci_read_config_word(dev, pos + PCI_MSIX_FLAGS, &control);
-		control &= ~PCI_MSIX_FLAGS_ENABLE;
-		pci_write_config_word(dev, pos + PCI_MSIX_FLAGS, control);
-	}
-}
-EXPORT_SYMBOL_GPL(pci_msi_off);
-
 int pci_set_dma_max_seg_size(struct pci_dev *dev, unsigned int size)
 {
 	return dma_set_max_seg_size(&dev->dev, size);
-- 
1.7.1


