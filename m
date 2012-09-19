Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:53077 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755259Ab2ISCmZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Sep 2012 22:42:25 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Huang Ying <ying.huang@intel.com>,
	Chen Gong <gong.chen@linux.intel.com>
CC: <jiang.liu@huawei.com>, Hanjun Guo <guohanjun@huawei.com>,
	<linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 5/6] PCI/AER: introduce pci_bus_ops_free to free pci_bus_ops
Date: Wed, 19 Sep 2012 10:40:41 +0800
Message-ID: <1348022442-7816-6-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1348022442-7816-1-git-send-email-wangyijing@huawei.com>
References: <1348022442-7816-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/pcie/aer/aer_inject.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/aer/aer_inject.c b/drivers/pci/pcie/aer/aer_inject.c
index 0a12ac7..79b611d 100644
--- a/drivers/pci/pcie/aer/aer_inject.c
+++ b/drivers/pci/pcie/aer/aer_inject.c
@@ -162,6 +162,16 @@ static struct pci_bus_ops *pci_bus_ops_pop(void)
 	return bus_ops;
 }
 
+static void pci_bus_ops_free(void)
+{
+	struct pci_bus_ops *bus_ops, *tmp_ops;
+
+	list_for_each_entry_safe(bus_ops, tmp_ops, &pci_bus_ops_list, list) {
+		list_del(&bus_ops->list);
+		kfree(bus_ops);
+	}
+}
+
 static struct pci_bus_ops *pci_bus_ops_get(struct pci_bus_ops *from)
 {
 	struct pci_bus_ops *bus_ops = NULL;
@@ -641,9 +651,7 @@ static void __exit aer_inject_exit(void)
 	 * module exit
 	 */
 	clean_untracked_pci_ops_aer();
-
-	while ((bus_ops = pci_bus_ops_pop()))
-		kfree(bus_ops);
+	pci_bus_ops_free();
 
 	spin_lock_irqsave(&inject_lock, flags);
 	list_for_each_entry_safe(err, err_next, &einjected, list) {
-- 
1.7.1


