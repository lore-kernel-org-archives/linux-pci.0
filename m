Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:53333 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755259Ab2ISCoq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Sep 2012 22:44:46 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Huang Ying <ying.huang@intel.com>,
	Chen Gong <gong.chen@linux.intel.com>
CC: <jiang.liu@huawei.com>, Hanjun Guo <guohanjun@huawei.com>,
	<linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 3/6] PCI/AER: clean all untracked pci_ops_aer when rmmod aer_inject
Date: Wed, 19 Sep 2012 10:40:39 +0800
Message-ID: <1348022442-7816-4-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1348022442-7816-1-git-send-email-wangyijing@huawei.com>
References: <1348022442-7816-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Since hot plug for pci devices while doing aer inject, some newly created child buses'
pci_ops will be assigned to pci_ops_aer. Aer_inject does not track these pci_ops_aer(not
list in pci_bus_ops_list),we should clean all of these when rmmod aer_inject module.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/pcie/aer/aer_inject.c |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/pcie/aer/aer_inject.c b/drivers/pci/pcie/aer/aer_inject.c
index 442147b..e2400b5 100644
--- a/drivers/pci/pcie/aer/aer_inject.c
+++ b/drivers/pci/pcie/aer/aer_inject.c
@@ -299,6 +299,32 @@ static void pci_bus_ops_init(struct pci_bus_ops *bus_ops,
 	bus_ops->ops = ops;
 }
 
+static void pci_clean_child_aer_ops(struct pci_bus *bus)
+{
+	struct pci_bus *child;
+
+	list_for_each_entry(child, &bus->children, node) {
+		if (child->ops == &pci_ops_aer)
+			pci_bus_set_ops(child, bus->ops);
+		pci_clean_child_aer_ops(child);
+	}
+}
+
+/* find pci_ops_aer from root bus, and replace it by parent bus's pci_ops.
+ * pci_ops of root bus won't be pci_ops_aer here*/
+static void clean_untracked_pci_ops_aer(void)
+{
+	struct pci_bus_ops *bus_ops;
+
+	list_for_each_entry(bus_ops, &pci_bus_ops_list, list) {
+		/* the bus with untracked pci_ops_aer always the
+		 * child bus of root bus tracked in pci_bus_ops_list
+		 */
+		if (pci_is_root_bus(bus_ops->bus))
+			pci_clean_child_aer_ops(bus_ops->bus);
+	}
+}
+
 static int pci_bus_set_aer_ops(struct pci_bus *bus)
 {
 	struct pci_ops *ops;
@@ -558,9 +584,18 @@ static void __exit aer_inject_exit(void)
 
 	misc_deregister(&aer_inject_device);
 
+	/* clean pci_bus_ops tracked in pci_bus_ops_list */
 	while ((bus_ops = pci_bus_ops_get(bus_ops)))
 		pci_bus_set_ops(bus_ops->bus, bus_ops->ops);
 
+	/* Inject aer errors and hotplug the same pcie device
+	 * maybe assign some newly created buses' pci_ops pci_ops_aer.
+	 * Since these pci_ops_aer are not tracked in pci_bus_ops_list,
+	 * we need to find and clean untracked pci_ops_aer before aer_inject
+	 * module exit
+	 */
+	clean_untracked_pci_ops_aer();
+
 	while ((bus_ops = pci_bus_ops_pop()))
 		kfree(bus_ops);
 
-- 
1.7.1


