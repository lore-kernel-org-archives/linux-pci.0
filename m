Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:53447 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173AbaIWFDU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Sep 2014 01:03:20 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v3 9/9] PCI/MSI: Rename __read_msi_msg() to read_msi_msg()
Date: Tue, 23 Sep 2014 13:27:30 +0800
Message-ID: <1411450050-1510-10-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1411450050-1510-1-git-send-email-wangyijing@huawei.com>
References: <1411450050-1510-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rename __read_msi_msg() to read_msi_msg().

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/x86/pci/xen.c  |    2 +-
 drivers/pci/msi.c   |    2 +-
 include/linux/msi.h |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 093f5f4..ad03739 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -229,7 +229,7 @@ static int xen_hvm_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 		return 1;
 
 	list_for_each_entry(msidesc, &dev->msi_list, list) {
-		__read_msi_msg(msidesc, &msg);
+		read_msi_msg(msidesc, &msg);
 		pirq = MSI_ADDR_EXT_DEST_ID(msg.address_hi) |
 			((msg.address_lo >> MSI_ADDR_DEST_ID_SHIFT) & 0xff);
 		if (msg.data != XEN_PIRQ_MSI_DATA ||
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 45da095..aff384a 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -259,7 +259,7 @@ void default_restore_msi_irqs(struct pci_dev *dev)
 	}
 }
 
-void __read_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
+void read_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 {
 	BUG_ON(entry->dev->current_state != PCI_D0);
 
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 9ec258e..6be66f4 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -15,7 +15,7 @@ struct irq_data;
 struct msi_desc;
 void mask_msi_irq(struct irq_data *data);
 void unmask_msi_irq(struct irq_data *data);
-void __read_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
+void read_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void __write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void write_msi_msg(unsigned int irq, struct msi_msg *msg);
-- 
1.7.1

