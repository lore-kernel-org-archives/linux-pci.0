Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:22580 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268Ab2HKLyj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 11 Aug 2012 07:54:39 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: <yijingwang21@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
CC: Hanjun Guo <guohanjun@huawei.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Huang Ying <ying.huang@intel.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 2/3] PCI/AER: Clean pci_bus_ops when related pci bus was removed
Date: Sat, 11 Aug 2012 19:52:25 +0800
Message-ID: <1344685946-8172-2-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1344685946-8172-1-git-send-email-wangyijing@huawei.com>
References: <1344685946-8172-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When Inject aer errors to the target pci device, a pci_bus_ops will
be allocated for the pci device's pci bus.When the pci bus was removed,
we should also release the pci_bus_ops.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/pcie/aer/aer_inject.c |   43 ++++++++++++++++++++++++++++++++++++-
 1 files changed, 42 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/pcie/aer/aer_inject.c b/drivers/pci/pcie/aer/aer_inject.c
index fc28785..8ca744f 100644
--- a/drivers/pci/pcie/aer/aer_inject.c
+++ b/drivers/pci/pcie/aer/aer_inject.c
@@ -526,10 +526,50 @@ static struct miscdevice aer_inject_device = {
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
+	if (!ret)
+		bus_register_notifier(&pci_bus_type, &aerinj_hp_notifier);
+	return ret;
 }
 
 static void __exit aer_inject_exit(void)
@@ -538,6 +578,7 @@ static void __exit aer_inject_exit(void)
 	unsigned long flags;
 	struct pci_bus_ops *bus_ops;
 
+	bus_unregister_notifier(&pci_bus_type, &aerinj_hp_notifier);
 	misc_deregister(&aer_inject_device);
 
 	while ((bus_ops = pci_bus_ops_pop())) {
-- 
1.7.1


