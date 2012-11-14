Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:54742 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161191Ab2KNM2X (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 14 Nov 2012 07:28:23 -0500
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Huang Ying <ying.huang@intel.com>, <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v5 3/5][RESEND] PCI/AER: clean all untracked pci_ops_aer when rmmod aer_inject
Date: Wed, 14 Nov 2012 20:27:20 +0800
Message-ID: <1352896042-11832-4-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1352896042-11832-1-git-send-email-wangyijing@huawei.com>
References: <1352896042-11832-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When we do hot plug for pci devices that were injected aer errors, some newly created child buses'
pci_ops will be assigned to pci_ops_aer. Aer_inject module will not track these pci_ops_aer(not
list in pci_bus_ops_list),so we should clean all of these when rmmod aer_inject module.

Reviewed-by: Huang Ying <ying.huang@intel.com>
Signed-off-by: Yijing Wang <wangyijing@huawei.com>

---
 drivers/pci/pcie/aer/aer_inject.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/pcie/aer/aer_inject.c b/drivers/pci/pcie/aer/aer_inject.c
index f499f01..4777c44 100644
--- a/drivers/pci/pcie/aer/aer_inject.c
+++ b/drivers/pci/pcie/aer/aer_inject.c
@@ -285,6 +285,29 @@ static void pci_bus_ops_init(struct pci_bus_ops *bus_ops,
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
+		if (pci_is_root_bus(bus_ops->bus))
+			pci_clean_child_aer_ops(bus_ops->bus);
+	}
+}
+
 static int pci_bus_set_aer_ops(struct pci_bus *bus)
 {
 	struct pci_ops *ops;
@@ -546,6 +569,7 @@ static void __exit aer_inject_exit(void)
 	list_for_each_entry(bus_ops, &pci_bus_ops_list, list)
 		pci_bus_set_ops(bus_ops->bus, bus_ops->ops);
 
+	clean_untracked_pci_ops_aer();
 	while ((bus_ops = pci_bus_ops_pop()))
 		kfree(bus_ops);
 
-- 
1.7.1


