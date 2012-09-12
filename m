Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:7866 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755256Ab2ILMfp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Sep 2012 08:35:45 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Huang Ying <ying.huang@intel.com>,
	Chen Gong <gong.chen@linux.intel.com>
CC: <jiang.liu@huawei.com>, Hanjun Guo <guohanjun@huawei.com>,
	<linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v2 3/4] PCI/AER: Clean pci_bus_ops when related pci bus was removed
Date: Wed, 12 Sep 2012 20:33:44 +0800
Message-ID: <1347453225-7704-3-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1347453225-7704-1-git-send-email-wangyijing@huawei.com>
References: <1347453225-7704-1-git-send-email-wangyijing@huawei.com>
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
index 9d195ae..bd043db 100644
--- a/drivers/pci/pcie/aer/aer_inject.c
+++ b/drivers/pci/pcie/aer/aer_inject.c
@@ -550,10 +550,55 @@ static struct miscdevice aer_inject_device = {
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
@@ -562,6 +607,7 @@ static void __exit aer_inject_exit(void)
 	unsigned long flags;
 	struct pci_bus_ops *bus_ops;
 
+	bus_unregister_notifier(&pci_bus_type, &aerinj_hp_notifier);
 	misc_deregister(&aer_inject_device);
 
 	while ((bus_ops = pci_bus_ops_pop())) {
-- 
1.7.1


