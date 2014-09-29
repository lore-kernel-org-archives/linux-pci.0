Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:8997 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085AbaI2ILm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Sep 2014 04:11:42 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v2 2/2] PCI/MSI: Remove the redundant irq_set_msi_desc()
Date: Mon, 29 Sep 2014 16:35:45 +0800
Message-ID: <1411979745-28568-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Irq and msi_desc will be associated in arch MSI
setup code regardless of MSI or MSI-X type.
The irq_set_msi_desc() in msix_program_entries()
is redundant.

The typical MSI setup flow:
pci_enable_msix()
	msix_capability_init()
		arch_setup_msi_irqs()
			native_setup_msi_irqs()	e.g in x86
				setup_msi_irq()
					irq_set_msi_desc_off() <---

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/msi.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index e0916ad..48eae97 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -673,7 +673,6 @@ static void msix_program_entries(struct pci_dev *dev,
 						PCI_MSIX_ENTRY_VECTOR_CTRL;
 
 		entries[i].vector = entry->irq;
-		irq_set_msi_desc(entry->irq, entry);
 		entry->masked = readl(entry->mask_base + offset);
 		msix_mask_irq(entry, 1);
 		i++;
-- 
1.7.1

