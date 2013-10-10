Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:53866 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752197Ab3JJIdE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Oct 2013 04:33:04 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Ben Hutchings <ben@decadent.org.uk>,
	"Yijing Wang" <wangyijing@huawei.com>,
	Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH] PCI: Avoid initialize MSI/MSIX if device power state != PCI_D0
Date: Thu, 10 Oct 2013 16:31:56 +0800
Message-ID: <1381393916-12268-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently, if device power state != PCI_D0, we still initialize
device MSI/MSIX, but we won't write the MSI message to device
MSI/MSIX registers. It's weird, we don't configure MSI/MSIX
registers properly, but pci_enable_msi() or pci_enable_msix()
return success, and even these registers will never be updated later.
So I think it should return error if device power state != PCI_D0.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/msi.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index d5f90d6..eb502f6 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -308,9 +308,7 @@ void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg)
 
 void __write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 {
-	if (entry->dev->current_state != PCI_D0) {
-		/* Don't touch the hardware now */
-	} else if (entry->msi_attrib.is_msix) {
+	if (entry->msi_attrib.is_msix) {
 		void __iomem *base;
 		base = entry->mask_base +
 			entry->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE;
@@ -831,7 +829,7 @@ int pci_enable_msi_block(struct pci_dev *dev, unsigned int nvec)
 	int status, maxvec;
 	u16 msgctl;
 
-	if (!dev->msi_cap)
+	if (!dev->msi_cap || dev->current_state != PCI_D0)
 		return -EINVAL;
 
 	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &msgctl);
@@ -862,7 +860,7 @@ int pci_enable_msi_block_auto(struct pci_dev *dev, unsigned int *maxvec)
 	int ret, nvec;
 	u16 msgctl;
 
-	if (!dev->msi_cap)
+	if (!dev->msi_cap || dev->current_state != PCI_D0)
 		return -EINVAL;
 
 	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &msgctl);
@@ -955,7 +953,7 @@ int pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries, int nvec)
 	int status, nr_entries;
 	int i, j;
 
-	if (!entries || !dev->msix_cap)
+	if (!entries || !dev->msix_cap || dev->current_state != PCI_D0)
 		return -EINVAL;
 
 	status = pci_msi_check_device(dev, nvec, PCI_CAP_ID_MSIX);
-- 
1.7.1


