Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from [119.145.14.66] ([119.145.14.66]:31425 "EHLO
	szxga03-in.huawei.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbaIKBHE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 10 Sep 2014 21:07:04 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH] PCI/MSI: Simplify default_restore_msi_irq()
Date: Thu, 11 Sep 2014 09:30:55 +0800
Message-ID: <1410399055-27562-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Both MSI and MSI-X irq will be associate to msi_desc,
Use irq_get_msi_desc() to get the msi_desc for MSI-X
to simplify code. Also use __write_msi_msg() instead
of write_msi_msg() to avoid the redundant calls.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/msi.c |   13 ++-----------
 1 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 5a40516..9ad920a 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -119,18 +119,9 @@ static void default_restore_msi_irq(struct pci_dev *dev, int irq)
 {
 	struct msi_desc *entry;
 
-	entry = NULL;
-	if (dev->msix_enabled) {
-		list_for_each_entry(entry, &dev->msi_list, list) {
-			if (irq == entry->irq)
-				break;
-		}
-	} else if (dev->msi_enabled)  {
-		entry = irq_get_msi_desc(irq);
-	}
-
+	entry = irq_get_msi_desc(irq);
 	if (entry)
-		write_msi_msg(irq, &entry->msg);
+		__write_msi_msg(entry, &entry->msg);
 }
 
 void __weak arch_restore_msi_irqs(struct pci_dev *dev)
-- 
1.7.1

