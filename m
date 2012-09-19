Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:52728 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755259Ab2ISCmH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Sep 2012 22:42:07 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Huang Ying <ying.huang@intel.com>,
	Chen Gong <gong.chen@linux.intel.com>
CC: <jiang.liu@huawei.com>, Hanjun Guo <guohanjun@huawei.com>,
	<linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 2/6] PCI/AER: introduce pci_bus_ops_get() function to avoid a small race condition window
Date: Wed, 19 Sep 2012 10:40:38 +0800
Message-ID: <1348022442-7816-3-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1348022442-7816-1-git-send-email-wangyijing@huawei.com>
References: <1348022442-7816-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When we rmmod aer_inject module, there is a race condition window between pci_bus_ops_pop()
and pci_bus_set_ops() in aer_inject_exit, eg. pci_read_aer/pci_write_aer was called between
them. So introduce pci_bus_ops_get() to avoid this.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/pcie/aer/aer_inject.c |   21 ++++++++++++++++++---
 1 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/aer/aer_inject.c b/drivers/pci/pcie/aer/aer_inject.c
index 0f00a27..442147b 100644
--- a/drivers/pci/pcie/aer/aer_inject.c
+++ b/drivers/pci/pcie/aer/aer_inject.c
@@ -67,6 +67,8 @@ struct pci_bus_ops {
 	struct pci_ops *ops;
 };
 
+#define to_pci_bus_ops(n) container_of(n, struct pci_bus_ops, list)
+
 static LIST_HEAD(einjected);
 
 static LIST_HEAD(pci_bus_ops_list);
@@ -160,6 +162,18 @@ static struct pci_bus_ops *pci_bus_ops_pop(void)
 	return bus_ops;
 }
 
+static struct pci_bus_ops *pci_bus_ops_get(struct pci_bus_ops *from)
+{
+	struct pci_bus_ops *bus_ops = NULL;
+	struct list_head *n;
+
+	n = from ? from->list.next : pci_bus_ops_list.next;
+	if (n != &pci_bus_ops_list)
+		bus_ops = to_pci_bus_ops(n);
+
+	return bus_ops;
+}
+
 static u32 *find_pci_config_dword(struct aer_error *err, int where,
 				  int *prw1cs)
 {
@@ -540,14 +554,15 @@ static void __exit aer_inject_exit(void)
 {
 	struct aer_error *err, *err_next;
 	unsigned long flags;
-	struct pci_bus_ops *bus_ops;
+	struct pci_bus_ops *bus_ops = NULL;
 
 	misc_deregister(&aer_inject_device);
 
-	while ((bus_ops = pci_bus_ops_pop())) {
+	while ((bus_ops = pci_bus_ops_get(bus_ops)))
 		pci_bus_set_ops(bus_ops->bus, bus_ops->ops);
+
+	while ((bus_ops = pci_bus_ops_pop()))
 		kfree(bus_ops);
-	}
 
 	spin_lock_irqsave(&inject_lock, flags);
 	list_for_each_entry_safe(err, err_next, &einjected, list) {
-- 
1.7.1


