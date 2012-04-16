Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52165 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474Ab2DPQeJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Apr 2012 12:34:09 -0400
Received: by mail-pb0-f46.google.com with SMTP id un15so6539626pbc.19
        for <linux-pci@vger.kernel.org>; Mon, 16 Apr 2012 09:34:09 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Jiang Liu <jiang.liu@huawei.com>, Jiang Liu <liuj97@gmail.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Subject: [PATCH RFC 17/17] PCI: serialize PCI hotplug operations triggered by fakephp drivers
Date: Tue, 17 Apr 2012 00:29:11 +0800
Message-Id: <1334593751-5916-18-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1334593751-5916-1-git-send-email-jiang.liu@huawei.com>
References: <1334593751-5916-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use PCI hotplug lock to globally serialize hotplug operations triggered
by fakephp driver.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 drivers/pci/hotplug/fakephp.c |   38 ++++++++++++++++++++++++++++++++------
 1 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/hotplug/fakephp.c b/drivers/pci/hotplug/fakephp.c
index a019c9a..ee6c79e 100644
--- a/drivers/pci/hotplug/fakephp.c
+++ b/drivers/pci/hotplug/fakephp.c
@@ -38,9 +38,24 @@ static ssize_t legacy_show(struct kobject *kobj, struct attribute *attr,
 	return 2;
 }
 
+static void rescan_callback(void *data)
+{
+	struct legacy_slot *slot = data;
+
+	pci_hotplug_enter();
+	if (!list_empty(&slot->list))
+		pci_rescan_bus(slot->dev->bus);
+	pci_hotplug_exit();
+}
+
 static void remove_callback(void *data)
 {
-	pci_stop_and_remove_bus_device((struct pci_dev *)data);
+	struct legacy_slot *slot = data;
+
+	pci_hotplug_enter();
+	if (!list_empty(&slot->list))
+		pci_stop_and_remove_bus_device(slot->dev);
+	pci_hotplug_exit();
 }
 
 static ssize_t legacy_store(struct kobject *kobj, struct attribute *attr,
@@ -53,10 +68,11 @@ static ssize_t legacy_store(struct kobject *kobj, struct attribute *attr,
 		return -EINVAL;
 
 	if (val)
-		pci_rescan_bus(slot->dev->bus);
+		sysfs_schedule_callback(&slot->kobj, rescan_callback,
+					slot, THIS_MODULE);
 	else
-		sysfs_schedule_callback(&slot->dev->dev.kobj, remove_callback,
-					slot->dev, THIS_MODULE);
+		sysfs_schedule_callback(&slot->kobj, remove_callback,
+					slot, THIS_MODULE);
 	return len;
 }
 
@@ -107,20 +123,25 @@ static int legacy_notify(struct notifier_block *nb,
 	struct pci_dev *pdev = to_pci_dev(data);
 
 	if (action == BUS_NOTIFY_ADD_DEVICE) {
+		pci_hotplug_enter();
 		legacy_add_slot(pdev);
+		pci_hotplug_exit();
 	} else if (action == BUS_NOTIFY_DEL_DEVICE) {
 		struct legacy_slot *slot;
 
+		pci_hotplug_enter();
 		list_for_each_entry(slot, &legacy_list, list)
 			if (slot->dev == pdev)
 				goto found;
 
+		pci_hotplug_exit();
 		dev_warn(&pdev->dev, "Missing legacy fake slot?");
 		return -ENODEV;
 found:
 		kobject_del(&slot->kobj);
-		list_del(&slot->list);
+		list_del_init(&slot->list);
 		kobject_put(&slot->kobj);
+		pci_hotplug_exit();
 	}
 
 	return 0;
@@ -135,11 +156,14 @@ static int __init init_legacy(void)
 	struct pci_dev *pdev = NULL;
 
 	/* Add existing devices */
+	pci_hotplug_disable();
 	for_each_pci_dev(pdev)
 		legacy_add_slot(pdev);
 
 	/* Be alerted of any new ones */
 	bus_register_notifier(&pci_bus_type, &legacy_notifier);
+	pci_hotplug_enable();
+
 	return 0;
 }
 module_init(init_legacy);
@@ -150,11 +174,13 @@ static void __exit remove_legacy(void)
 
 	bus_unregister_notifier(&pci_bus_type, &legacy_notifier);
 
+	pci_hotplug_disable();
 	list_for_each_entry_safe(slot, tmp, &legacy_list, list) {
-		list_del(&slot->list);
+		list_del_init(&slot->list);
 		kobject_del(&slot->kobj);
 		kobject_put(&slot->kobj);
 	}
+	pci_hotplug_enable();
 }
 module_exit(remove_legacy);
 
-- 
1.7.5.4

