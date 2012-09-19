Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:53377 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755259Ab2ISCmr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Sep 2012 22:42:47 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Huang Ying <ying.huang@intel.com>,
	Chen Gong <gong.chen@linux.intel.com>
CC: <jiang.liu@huawei.com>, Hanjun Guo <guohanjun@huawei.com>,
	<linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 4/6] PCI/AER: clean pci_bus_ops when related pci bus was removed
Date: Wed, 19 Sep 2012 10:40:40 +0800
Message-ID: <1348022442-7816-5-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1348022442-7816-1-git-send-email-wangyijing@huawei.com>
References: <1348022442-7816-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When Inject aer errors to the target pci device, a pci_bus_ops will
be allocated for the pci device's pci bus.When the pci bus was removed,
we should also release the pci_bus_ops.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Reviewed-by: Sven Dietrich <Sven.Dietrich@huawei.com>
---
 drivers/pci/pcie/aer/aer_inject.c |   48 ++++++++++++++++++++++++++++++++++++-
 1 files changed, 47 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/pcie/aer/aer_inject.c b/drivers/pci/pcie/aer/aer_inject.c
index e2400b5..0a12ac7 100644
--- a/drivers/pci/pcie/aer/aer_inject.c
+++ b/drivers/pci/pcie/aer/aer_inject.c
@@ -570,10 +570,55 @@ static struct miscdevice aer_inject_device = {
 	.fops = &aer_inject_fops,
 };
 
+static void aer_clean_pci_bus_ops(struct pci_dev *dev)
+{
+	unsigned long flags;
+	struct pci_bus_ops *bus_ops, *tmp_ops;
+	struct pci_bus *bus;
+	bus = dev->subordinate;
+	if (!bus)
+		return;
+
+	spin_lock_irqsave(&inject_lock, flags);
+	list_for_each_entry_safe(bus_ops, tmp_ops, &pci_bus_ops_list, list)
+		if (bus_ops->bus == bus) {
+			list_del(&bus_ops->list);
+			kfree(bus_ops);
+			break;
+		}
+	spin_unlock_irqrestore(&inject_lock, flags);
+}
+
+static int aer_hp_notify_fn(struct notifier_block *nb,
+		unsigned long event, void *data)
+{
+	switch (event) {
+	case BUS_NOTIFY_DEL_DEVICE:
+		aer_clean_pci_bus_ops(to_pci_dev(data));
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block aerinj_hp_notifier = {
+	.notifier_call = &aer_hp_notify_fn,
+};
 
 static int __init aer_inject_init(void)
 {
-	return misc_register(&aer_inject_device);
+	int ret;
+	ret = misc_register(&aer_inject_device);
+	if (ret)
+		goto out;
+
+	ret = bus_register_notifier(&pci_bus_type, &aerinj_hp_notifier);
+	if (ret)
+		misc_deregister(&aer_inject_device);
+out:
+	return ret;
 }
 
 static void __exit aer_inject_exit(void)
@@ -582,6 +627,7 @@ static void __exit aer_inject_exit(void)
 	unsigned long flags;
 	struct pci_bus_ops *bus_ops = NULL;
 
+	bus_unregister_notifier(&pci_bus_type, &aerinj_hp_notifier);
 	misc_deregister(&aer_inject_device);
 
 	/* clean pci_bus_ops tracked in pci_bus_ops_list */
-- 
1.7.1


