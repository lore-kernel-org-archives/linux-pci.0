Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:10791 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756701Ab2IUIoa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Sep 2012 04:44:30 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Huang Ying <ying.huang@intel.com>,
	Chen Gong <gong.chen@linux.intel.com>
CC: <jiang.liu@huawei.com>, Hanjun Guo <guohanjun@huawei.com>,
	<linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v5 5/5] PCI/AER: free pci_bus_ops_list and remove pci_bus_ops_pop
Date: Fri, 21 Sep 2012 16:43:13 +0800
Message-ID: <1348216993-6948-6-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1348216993-6948-1-git-send-email-wangyijing@huawei.com>
References: <1348216993-6948-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rewrite pci_bus_ops_list release code for simplification, and clean
no used function pci_bus_ops_pop().

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Reviewed-by: Huang Ying <ying.huang@intel.com>
---
 drivers/pci/pcie/aer/aer_inject.c |   25 ++++++-------------------
 1 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/pcie/aer/aer_inject.c b/drivers/pci/pcie/aer/aer_inject.c
index c5372dd..14d2c92 100644
--- a/drivers/pci/pcie/aer/aer_inject.c
+++ b/drivers/pci/pcie/aer/aer_inject.c
@@ -143,23 +143,6 @@ static struct pci_ops *__find_pci_bus_ops(struct pci_bus *bus)
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
-
 static u32 *find_pci_config_dword(struct aer_error *err, int where,
 				  int *prw1cs)
 {
@@ -608,7 +591,7 @@ static void __exit aer_inject_exit(void)
 {
 	struct aer_error *err, *err_next;
 	unsigned long flags;
-	struct pci_bus_ops *bus_ops;
+	struct pci_bus_ops *bus_ops, *tmp_ops;
 
 	bus_unregister_notifier(&pci_bus_type, &aerinj_hp_notifier);
 	misc_deregister(&aer_inject_device);
@@ -617,8 +600,12 @@ static void __exit aer_inject_exit(void)
 		pci_bus_set_ops(bus_ops->bus, bus_ops->ops);
 
 	clean_untracked_pci_ops_aer();
-	while ((bus_ops = pci_bus_ops_pop()))
+
+	/* free pci_bus_ops_list */
+	list_for_each_entry_safe(bus_ops, tmp_ops, &pci_bus_ops_list, list) {
+		list_del(&bus_ops->list);
 		kfree(bus_ops);
+	}
 
 	spin_lock_irqsave(&inject_lock, flags);
 	list_for_each_entry_safe(err, err_next, &einjected, list) {
-- 
1.7.1


