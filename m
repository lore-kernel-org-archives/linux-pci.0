Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:58769 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412AbaGDIR1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jul 2014 04:17:27 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Wuyun <wuyun.wu@huawei.com>,
	Xinwei Hu <huxinwei@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 5/5] PCI/MSI: Clean up the useless code
Date: Fri, 4 Jul 2014 16:17:14 +0800
Message-ID: <1404461834-9964-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Clean up the useless code in __pci_restore_msix_state().

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/msi.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 7f803e9..3bee1ba 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -463,7 +463,6 @@ static void __pci_restore_msix_state(struct pci_dev *dev)
 	if (!dev->msix_enabled)
 		return;
 	BUG_ON(list_empty(&dev->msi_list));
-	entry = list_first_entry(&dev->msi_list, struct msi_desc, list);
 
 	/* route the table */
 	pci_intx_for_msi(dev, 0);
-- 
1.7.1


