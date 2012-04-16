Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:35016 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016Ab2DPQdW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Apr 2012 12:33:22 -0400
Received: by mail-pz0-f52.google.com with SMTP id e40so7133149dak.11
        for <linux-pci@vger.kernel.org>; Mon, 16 Apr 2012 09:33:22 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Zink <dan.zink@compaq.com>,
	Greg Kroah-Hartman <greg@kroah.com>,
	Dely Sy <dely.l.sy@intel.com>
Cc: Jiang Liu <jiang.liu@huawei.com>, Jiang Liu <liuj97@gmail.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Subject: [PATCH RFC 10/17] PCI: serialize hotplug operaitons triggered by the shpchp driver
Date: Tue, 17 Apr 2012 00:29:04 +0800
Message-Id: <1334593751-5916-11-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1334593751-5916-1-git-send-email-jiang.liu@huawei.com>
References: <1334593751-5916-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use PCI hotplug lock to serialize hotplug operations triggered by the
shpchp driver.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 drivers/pci/hotplug/shpchp.h      |    2 ++
 drivers/pci/hotplug/shpchp_core.c |    3 ++-
 drivers/pci/hotplug/shpchp_ctrl.c |   32 ++++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/hotplug/shpchp.h b/drivers/pci/hotplug/shpchp.h
index 6691dc4..07f3b2d 100644
--- a/drivers/pci/hotplug/shpchp.h
+++ b/drivers/pci/hotplug/shpchp.h
@@ -157,6 +157,7 @@ struct controller {
 #define BLINKINGOFF_STATE		2
 #define POWERON_STATE			3
 #define POWEROFF_STATE			4
+#define SHUTDOWN_STATE			5
 
 /* Error messages */
 #define INTERLOCK_OPEN			0x00000002
@@ -179,6 +180,7 @@ extern u8 shpchp_handle_presence_change(u8 hp_slot, struct controller *ctrl);
 extern u8 shpchp_handle_power_fault(u8 hp_slot, struct controller *ctrl);
 extern int shpchp_configure_device(struct slot *p_slot);
 extern int shpchp_unconfigure_device(struct slot *p_slot);
+extern void shpchp_shutdown_slot(struct slot *slot);
 extern void cleanup_slots(struct controller *ctrl);
 extern void shpchp_queue_pushbutton_work(struct work_struct *work);
 extern int shpc_init( struct controller *ctrl, struct pci_dev *pdev);
diff --git a/drivers/pci/hotplug/shpchp_core.c b/drivers/pci/hotplug/shpchp_core.c
index 19762b3..71cc5f2 100644
--- a/drivers/pci/hotplug/shpchp_core.c
+++ b/drivers/pci/hotplug/shpchp_core.c
@@ -172,10 +172,11 @@ void cleanup_slots(struct controller *ctrl)
 
 	list_for_each_safe(tmp, next, &ctrl->slot_list) {
 		slot = list_entry(tmp, struct slot, slot_list);
-		list_del(&slot->slot_list);
 		flush_workqueue(shpchp_wq);
 		cancel_delayed_work_sync(&slot->work);
+		shpchp_shutdown_slot(slot);
 		flush_workqueue(shpchp_ordered_wq);
+		list_del(&slot->slot_list);
 		pci_hp_deregister(slot->hotplug_slot);
 	}
 }
diff --git a/drivers/pci/hotplug/shpchp_ctrl.c b/drivers/pci/hotplug/shpchp_ctrl.c
index b00b09b..7b8e3a6 100644
--- a/drivers/pci/hotplug/shpchp_ctrl.c
+++ b/drivers/pci/hotplug/shpchp_ctrl.c
@@ -31,6 +31,7 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/slab.h>
+#include <linux/delay.h>
 #include <linux/pci.h>
 #include "../pci.h"
 #include "shpchp.h"
@@ -406,6 +407,18 @@ static void shpchp_pushbutton_thread(struct work_struct *work)
 	struct pushbutton_work_info *info =
 		container_of(work, struct pushbutton_work_info, work);
 	struct slot *p_slot = info->p_slot;
+	bool shutdown;
+
+	/* Break possible deadlock by using pci_hotplug_try_enter() */
+	while (!pci_hotplug_try_enter()) {
+		mutex_lock(&p_slot->lock);
+		shutdown = p_slot->state == SHUTDOWN_STATE;
+		mutex_unlock(&p_slot->lock);
+		if (shutdown)
+			goto out;
+		else
+			mdelay(1);
+	}
 
 	mutex_lock(&p_slot->lock);
 	switch (p_slot->state) {
@@ -427,6 +440,9 @@ static void shpchp_pushbutton_thread(struct work_struct *work)
 	}
 	mutex_unlock(&p_slot->lock);
 
+	pci_hotplug_exit();
+
+out:
 	kfree(info);
 }
 
@@ -729,3 +745,19 @@ int shpchp_sysfs_disable_slot(struct slot *p_slot)
 
 	return retval;
 }
+
+void shpchp_shutdown_slot(struct slot *slot)
+{
+	u8 getstatus;
+
+	mutex_lock(&slot->lock);
+	slot->state = SHUTDOWN_STATE;
+	mutex_unlock(&slot->lock);
+
+	slot->hpc_ops->set_attention_status(slot, 0);
+	slot->hpc_ops->get_power_status(slot, &getstatus);
+	if (getstatus)
+		slot->hpc_ops->green_led_on(slot);
+	else
+		slot->hpc_ops->green_led_off(slot);
+}
-- 
1.7.5.4

