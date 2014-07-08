Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:10202 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753486AbaGHCI5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jul 2014 22:08:57 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Wuyun <wuyun.wu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v3 3/6] PCI/MSI: Remove unused function msi_remove_pci_irq_vectors()
Date: Tue, 8 Jul 2014 10:08:36 +0800
Message-ID: <1404785316-6392-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

No one use msi_remove_pci_irq_vectors() function,
clean up it.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/msi.c   |   18 ------------------
 include/linux/pci.h |    2 --
 2 files changed, 0 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index c306883..86578bb 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1014,24 +1014,6 @@ void pci_disable_msix(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pci_disable_msix);
 
-/**
- * msi_remove_pci_irq_vectors - reclaim MSI(X) irqs to unused state
- * @dev: pointer to the pci_dev data structure of MSI(X) device function
- *
- * Being called during hotplug remove, from which the device function
- * is hot-removed. All previous assigned MSI/MSI-X irqs, if
- * allocated for this device function, are reclaimed to unused state,
- * which may be used later on.
- **/
-void msi_remove_pci_irq_vectors(struct pci_dev *dev)
-{
-	if (!pci_msi_enable || !dev)
-		return;
-
-	if (dev->msi_enabled || dev->msix_enabled)
-		free_msi_irqs(dev);
-}
-
 void pci_no_msi(void)
 {
 	pci_msi_enable = 0;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 466bcd1..66bd22f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1186,7 +1186,6 @@ int pci_msix_vec_count(struct pci_dev *dev);
 int pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries, int nvec);
 void pci_msix_shutdown(struct pci_dev *dev);
 void pci_disable_msix(struct pci_dev *dev);
-void msi_remove_pci_irq_vectors(struct pci_dev *dev);
 void pci_restore_msi_state(struct pci_dev *dev);
 int pci_msi_enabled(void);
 int pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec);
@@ -1217,7 +1216,6 @@ static inline int pci_enable_msix(struct pci_dev *dev,
 { return -ENOSYS; }
 static inline void pci_msix_shutdown(struct pci_dev *dev) { }
 static inline void pci_disable_msix(struct pci_dev *dev) { }
-static inline void msi_remove_pci_irq_vectors(struct pci_dev *dev) { }
 static inline void pci_restore_msi_state(struct pci_dev *dev) { }
 static inline int pci_msi_enabled(void) { return 0; }
 static inline int pci_enable_msi_range(struct pci_dev *dev, int minvec,
-- 
1.7.1


