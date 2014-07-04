Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:36293 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424AbaGDIRN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jul 2014 04:17:13 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Wuyun <wuyun.wu@huawei.com>,
	Xinwei Hu <huxinwei@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 4/5] PCI/MSI: Retrieve first MSI irq from msi_desc rather than pci_dev
Date: Fri, 4 Jul 2014 16:16:54 +0800
Message-ID: <1404461814-9936-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Retrieve the first MSi irq to compute the MSI index from
struct msi_desc rather than the pci device, avoid a additional
memory access.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/msi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 86578bb..7f803e9 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -235,7 +235,7 @@ static void msi_set_mask_bit(struct irq_data *data, u32 flag)
 		msix_mask_irq(desc, flag);
 		readl(desc->mask_base);		/* Flush write to device */
 	} else {
-		unsigned offset = data->irq - desc->dev->irq;
+		unsigned offset = data->irq - desc->irq;
 		msi_mask_irq(desc, 1 << offset, flag << offset);
 	}
 }
-- 
1.7.1


