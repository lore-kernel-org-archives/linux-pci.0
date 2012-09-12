Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:61024 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754776Ab2ILMfp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Sep 2012 08:35:45 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Huang Ying <ying.huang@intel.com>,
	Chen Gong <gong.chen@linux.intel.com>
CC: <jiang.liu@huawei.com>, Hanjun Guo <guohanjun@huawei.com>,
	<linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v2 4/4] PCI/AER: fix a small race condition window when rmmod aer_inject
Date: Wed, 12 Sep 2012 20:33:45 +0800
Message-ID: <1347453225-7704-4-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1347453225-7704-1-git-send-email-wangyijing@huawei.com>
References: <1347453225-7704-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Fix a small race condition window between pci_bus_ops_pop() and
pci_bus_set_ops() functions.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 drivers/pci/pcie/aer/aer_inject.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aer/aer_inject.c b/drivers/pci/pcie/aer/aer_inject.c
index bd043db..69c2d77 100644
--- a/drivers/pci/pcie/aer/aer_inject.c
+++ b/drivers/pci/pcie/aer/aer_inject.c
@@ -141,12 +141,11 @@ static struct pci_ops *__find_pci_bus_ops(struct pci_bus *bus)
 	return NULL;
 }
 
+/* inject_lock must be held before calling */
 static struct pci_bus_ops *pci_bus_ops_pop(void)
 {
-	unsigned long flags;
 	struct pci_bus_ops *bus_ops = NULL;
 
-	spin_lock_irqsave(&inject_lock, flags);
 	if (list_empty(&pci_bus_ops_list))
 		bus_ops = NULL;
 	else {
@@ -154,7 +153,6 @@ static struct pci_bus_ops *pci_bus_ops_pop(void)
 		list_del(lh);
 		bus_ops = list_entry(lh, struct pci_bus_ops, list);
 	}
-	spin_unlock_irqrestore(&inject_lock, flags);
 	return bus_ops;
 }
 
@@ -610,14 +608,12 @@ static void __exit aer_inject_exit(void)
 	bus_unregister_notifier(&pci_bus_type, &aerinj_hp_notifier);
 	misc_deregister(&aer_inject_device);
 
+	spin_lock_irqsave(&inject_lock, flags);
 	while ((bus_ops = pci_bus_ops_pop())) {
 		pci_bus_set_ops(bus_ops->bus, bus_ops->ops);
 		kfree(bus_ops);
 	}
 	
-	clean_untracked_pci_aer_ops();
-
-	spin_lock_irqsave(&inject_lock, flags);
 	list_for_each_entry_safe(err, err_next, &einjected, list) {
 		list_del(&err->list);
 		kfree(err);
-- 
1.7.1


