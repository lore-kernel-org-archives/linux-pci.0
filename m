Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:52032 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085AbaI2ILc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Sep 2014 04:11:32 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v2 1/2] PCI/MSI: Simplify default_restore_msi_irq()
Date: Mon, 29 Sep 2014 16:35:33 +0800
Message-ID: <1411979733-28523-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Both MSI and MSI-X irq will be associated to msi_desc
in arch MSI code, e.g. in x86
arch_setup_msi_irqs()
	native_setup_msi_irqs()
		setup_msi_irq()
			irq_set_msi_desc_off()

Use irq_get_msi_desc() to get the MSI-X msi_desc for
simplification. Also use __write_msi_msg() instead
of write_msi_msg() to avoid the redundant calls.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/msi.c |   13 ++-----------
 1 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index d077749..e0916ad 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -109,18 +109,9 @@ static void default_restore_msi_irq(struct pci_dev *dev, int irq)
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

