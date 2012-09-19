Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:28529 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755146Ab2ISClx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Sep 2012 22:41:53 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Huang Ying <ying.huang@intel.com>,
	Chen Gong <gong.chen@linux.intel.com>
CC: <jiang.liu@huawei.com>, Hanjun Guo <guohanjun@huawei.com>,
	<linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 6/6] PCI/AER: clean unused code pci_bus_ops_pop
Date: Wed, 19 Sep 2012 10:40:42 +0800
Message-ID: <1348022442-7816-7-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1348022442-7816-1-git-send-email-wangyijing@huawei.com>
References: <1348022442-7816-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/pcie/aer/aer_inject.c |   16 ----------------
 1 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/pcie/aer/aer_inject.c b/drivers/pci/pcie/aer/aer_inject.c
index 79b611d..9a24af4 100644
--- a/drivers/pci/pcie/aer/aer_inject.c
+++ b/drivers/pci/pcie/aer/aer_inject.c
@@ -145,22 +145,6 @@ static struct pci_ops *__find_pci_bus_ops(struct pci_bus *bus)
 	return __find_pci_bus_ops_parent(bus);
 }
 
-static struct pci_bus_ops *pci_bus_ops_pop(void)
-{
-	unsigned long flags;
-	struct pci_bus_ops *bus_ops = NULL;
-
-	spin_lock_irqsave(&inject_lock, flags);
-	if (list_empty(&pci_bus_ops_list))
-		bus_ops = NULL;
-	else {
-		struct list_head *lh = pci_bus_ops_list.next;
-		list_del(lh);
-		bus_ops = list_entry(lh, struct pci_bus_ops, list);
-	}
-	spin_unlock_irqrestore(&inject_lock, flags);
-	return bus_ops;
-}
 
 static void pci_bus_ops_free(void)
 {
-- 
1.7.1


