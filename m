Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:35016 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016Ab2DPQc7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Apr 2012 12:32:59 -0400
Received: by dake40 with SMTP id e40so7133149dak.11
        for <linux-pci@vger.kernel.org>; Mon, 16 Apr 2012 09:32:59 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Zink <dan.zink@compaq.com>,
	Greg Kroah-Hartman <greg@kroah.com>,
	Dely Sy <dely.l.sy@intel.com>
Cc: Jiang Liu <jiang.liu@huawei.com>, Jiang Liu <liuj97@gmail.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Subject: [PATCH RFC 07/17] PCI: serialize hotplug operaitons triggered by the pciehp driver
Date: Tue, 17 Apr 2012 00:29:01 +0800
Message-Id: <1334593751-5916-8-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1334593751-5916-1-git-send-email-jiang.liu@huawei.com>
References: <1334593751-5916-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use PCI hotplug lock to serialize hotplug operations triggered by the
pciehp driver.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 drivers/pci/hotplug/pciehp.h      |    2 +
 drivers/pci/hotplug/pciehp_core.c |    7 ++++-
 drivers/pci/hotplug/pciehp_ctrl.c |   48 +++++++++++++++++++++++++++++++++++++
 drivers/pci/hotplug/pciehp_hpc.c  |    1 +
 4 files changed, 57 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index c8a1a27..6078eea 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -117,6 +117,7 @@ struct controller {
 #define BLINKINGOFF_STATE		2
 #define POWERON_STATE			3
 #define POWEROFF_STATE			4
+#define SHUTDOWN_STATE			5
 
 #define ATTN_BUTTN(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_ABP)
 #define POWER_CTRL(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_PCP)
@@ -160,6 +161,7 @@ void pciehp_green_led_off(struct slot *slot);
 void pciehp_green_led_blink(struct slot *slot);
 int pciehp_check_link_status(struct controller *ctrl);
 void pciehp_release_ctrl(struct controller *ctrl);
+void pciehp_shutdown_slot(struct slot *slot);
 
 static inline const char *slot_name(struct slot *slot)
 {
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 4ceefe3..2195f67 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -268,8 +268,11 @@ static int pciehp_probe(struct pcie_device *dev)
 	slot = ctrl->slot;
 	pciehp_get_adapter_status(slot, &occupied);
 	pciehp_get_power_status(slot, &poweron);
-	if (occupied && pciehp_force)
+	if (occupied && pciehp_force) {
+		pci_hotplug_enter();
 		pciehp_enable_slot(slot);
+		pci_hotplug_exit();
+	}
 	/* If empty slot's power status is on, turn power off */
 	if (!occupied && poweron && POWER_CTRL(ctrl))
 		pciehp_power_off_slot(slot);
@@ -313,11 +316,13 @@ static int pciehp_resume (struct pcie_device *dev)
 		slot = ctrl->slot;
 
 		/* Check if slot is occupied */
+		pci_hotplug_enter();
 		pciehp_get_adapter_status(slot, &status);
 		if (status)
 			pciehp_enable_slot(slot);
 		else
 			pciehp_disable_slot(slot);
+		pci_hotplug_exit();
 	}
 	return 0;
 }
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 8f4d261..e859100 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -31,6 +31,7 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/slab.h>
+#include <linux/delay.h>
 #include <linux/pci.h>
 #include "../pci.h"
 #include "pciehp.h"
@@ -290,6 +291,30 @@ static void pciehp_power_thread(struct work_struct *work)
 	struct power_work_info *info =
 		container_of(work, struct power_work_info, work);
 	struct slot *p_slot = info->p_slot;
+	bool shutdown;
+
+	/*
+	 * Break out deadlock issues caused by following scenario:
+	 * Thread A:
+	 *	1) acquire the PCI hotplug lock
+	 *	2) remove the PCI device associated with this PCIe HPC
+	 *	3) call pciehp_remove() for this PCIe HPC
+	 *	4) call flush_workqueue(pciehp_wq_power) to flush queued works
+	 *      5) wait until all queued works have done
+	 * Thread B is a workqueue worker thread:
+	 *	1) call pciehp_power_thread() to handle hotplug requests
+	 *	2) try to acquire the PCI hotplug lock
+	 * Please refer to pciehp_shutdown_slot() for the counterpart.
+	 */
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
@@ -315,6 +340,9 @@ static void pciehp_power_thread(struct work_struct *work)
 	}
 	mutex_unlock(&p_slot->lock);
 
+	pci_hotplug_exit();
+
+out:
 	kfree(info);
 }
 
@@ -623,3 +651,23 @@ int pciehp_sysfs_disable_slot(struct slot *p_slot)
 
 	return retval;
 }
+
+void pciehp_shutdown_slot(struct slot *slot)
+{
+	u8 getstatus;
+	struct controller *ctrl = slot->ctrl;
+
+	mutex_lock(&slot->lock);
+	slot->state = SHUTDOWN_STATE;
+	mutex_unlock(&slot->lock);
+
+	if (ATTN_LED(ctrl))
+		pciehp_set_attention_status(slot, 0);
+	if (PWR_LED(ctrl)) {
+		pciehp_get_power_status(slot, &getstatus);
+		if (getstatus)
+			pciehp_green_led_on(slot);
+		else
+			pciehp_green_led_off(slot);
+	}
+}
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index d5c826d..c492b2c 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -902,6 +902,7 @@ static void pcie_cleanup_slot(struct controller *ctrl)
 	 */
 	flush_workqueue(pciehp_wq_event);
 	cancel_delayed_work_sync(&slot->work);
+	pciehp_shutdown_slot(slot);
 	flush_workqueue(pciehp_wq_power);
 
 	kfree(slot);
-- 
1.7.5.4

