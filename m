Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:62085 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753387AbaGHCJ0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jul 2014 22:09:26 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Wuyun <wuyun.wu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v3 5/6] PCI/MSI: Clean up the useless code
Date: Tue, 8 Jul 2014 10:09:08 +0800
Message-ID: <1404785348-2036-1-git-send-email-wangyijing@huawei.com>
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


