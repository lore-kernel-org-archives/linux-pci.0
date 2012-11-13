Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:49354 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753318Ab2KMKut (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 13 Nov 2012 05:50:49 -0500
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>, Rafael <rjw@sisk.pl>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Mauro Carvalho Chehab <mchehab@redhat.com>,
	Oliver Neukum <oneukum@suse.de>, <jiang.liu@huawei.com>
CC: <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH -v4] PCI, pciehp: make every slot have its own workqueue to avoid deadlock
Date: Tue, 13 Nov 2012 18:49:00 +0800
Message-ID: <1352803740-8076-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently, pciehp use global pciehp_wq to handle hotplug event from hardware.
Hot remove path will be blocked if a hotplug slot connected a IO-BOX(composed of PCIe
Switch and some slots which support hotplug). Because The hot removed work was queued
into pciehp_wq. But in the hot-remove path, pciehp driver would flush pciehp_wq when
the pcie port(support pciehp) was removed. In this case the hot-remove path blocked.
This patch remove the global pciehp_wq and create a new workqueue for every slot to
avoid above problem.
call path:
1. Hot-removal request comes to slot A(eg. 0000:40:07.0 as bellow)
2. Pciehp driver queue hot-remove work into global workqueue "pciehp_wq"
3. Hot-remove work call pci_stop_and_remove_bus_device() to remove child devices.
4. Unregister and remove Pcie port device slot B(eg. 0000:47:15.0).
5. To remove pcie port device, flush_workqueue(pciehp_wq) will be called.
6. Deaklock <== hot-removal work is in progress.

-+-[0000:40]-+-00.0-[0000:41]--
 |           +-01.0-[0000:42]--+-00.0  Intel Corporation 82576 Gigabit Network Connection
 |           |                 \-00.1  Intel Corporation 82576 Gigabit Network Connection
 |           +-03.0-[0000:43]----00.0  LSI Logic / Symbios Logic SAS1064ET PCI-Express Fusion-MPT SAS
 |           +-04.0-[0000:44]--
 |           +-05.0-[0000:45]--
 |           +-07.0-[0000:46-4f]----00.0-[0000:47-4f]--+-04.0-[0000:48-49]----00.0-[0000:49]--
 |           |(slot A)                                 +-08.0-[0000:4a]--
 |           |                                         +-09.0-[0000:4b]--
 |           |                                         +-10.0-[0000:4c]--
 |           |                                         +-11.0-[0000:4d]--
 |           |                                         +-14.0-[0000:4e]--
 |           |                                         \-15.0-[0000:4f]--+-00.0  Intel Corporation 82576 Gigabit Network Connection
 |           |                                         (slot B)          \-00.1  Intel Corporation 82576 Gigabit Network Connection


Reviewed-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/hotplug/pciehp.h      |    2 +-
 drivers/pci/hotplug/pciehp_core.c |   11 ++---------
 drivers/pci/hotplug/pciehp_ctrl.c |    8 ++++----
 drivers/pci/hotplug/pciehp_hpc.c  |   11 ++++++++++-
 4 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 26ffd3e..2c113de 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -44,7 +44,6 @@ extern bool pciehp_poll_mode;
 extern int pciehp_poll_time;
 extern bool pciehp_debug;
 extern bool pciehp_force;
-extern struct workqueue_struct *pciehp_wq;
 
 #define dbg(format, arg...)						\
 do {									\
@@ -78,6 +77,7 @@ struct slot {
 	struct hotplug_slot *hotplug_slot;
 	struct delayed_work work;	/* work for button event */
 	struct mutex lock;
+	struct workqueue_struct *wq;
 };
 
 struct event_info {
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 916bf4f..0914211 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -42,7 +42,6 @@ bool pciehp_debug;
 bool pciehp_poll_mode;
 int pciehp_poll_time;
 bool pciehp_force;
-struct workqueue_struct *pciehp_wq;
 
 #define DRIVER_VERSION	"0.4"
 #define DRIVER_AUTHOR	"Dan Zink <dan.zink@compaq.com>, Greg Kroah-Hartman <greg@kroah.com>, Dely Sy <dely.l.sy@intel.com>"
@@ -340,18 +339,13 @@ static int __init pcied_init(void)
 {
 	int retval = 0;
 
-	pciehp_wq = alloc_workqueue("pciehp", 0, 0);
-	if (!pciehp_wq)
-		return -ENOMEM;
-
 	pciehp_firmware_init();
 	retval = pcie_port_service_register(&hpdriver_portdrv);
  	dbg("pcie_port_service_register = %d\n", retval);
   	info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
- 	if (retval) {
-		destroy_workqueue(pciehp_wq);
+	if (retval)
 		dbg("Failure to register service\n");
-	}
+
 	return retval;
 }
 
@@ -359,7 +353,6 @@ static void __exit pcied_cleanup(void)
 {
 	dbg("unload_pciehpd()\n");
 	pcie_port_service_unregister(&hpdriver_portdrv);
-	destroy_workqueue(pciehp_wq);
 	info(DRIVER_DESC " version: " DRIVER_VERSION " unloaded\n");
 }
 
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 27f4429..38f0186 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -49,7 +49,7 @@ static int queue_interrupt_event(struct slot *p_slot, u32 event_type)
 	info->p_slot = p_slot;
 	INIT_WORK(&info->work, interrupt_event_handler);
 
-	queue_work(pciehp_wq, &info->work);
+	queue_work(p_slot->wq, &info->work);
 
 	return 0;
 }
@@ -344,7 +344,7 @@ void pciehp_queue_pushbutton_work(struct work_struct *work)
 		kfree(info);
 		goto out;
 	}
-	queue_work(pciehp_wq, &info->work);
+	queue_work(p_slot->wq, &info->work);
  out:
 	mutex_unlock(&p_slot->lock);
 }
@@ -377,7 +377,7 @@ static void handle_button_press_event(struct slot *p_slot)
 		if (ATTN_LED(ctrl))
 			pciehp_set_attention_status(p_slot, 0);
 
-		queue_delayed_work(pciehp_wq, &p_slot->work, 5*HZ);
+		queue_delayed_work(p_slot->wq, &p_slot->work, 5*HZ);
 		break;
 	case BLINKINGOFF_STATE:
 	case BLINKINGON_STATE:
@@ -439,7 +439,7 @@ static void handle_surprise_event(struct slot *p_slot)
 	else
 		p_slot->state = POWERON_STATE;
 
-	queue_work(pciehp_wq, &info->work);
+	queue_work(p_slot->wq, &info->work);
 }
 
 static void interrupt_event_handler(struct work_struct *work)
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 13b2eaf..371ec79 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -773,23 +773,32 @@ static void pcie_shutdown_notification(struct controller *ctrl)
 static int pcie_init_slot(struct controller *ctrl)
 {
 	struct slot *slot;
+	char name[32];
 
 	slot = kzalloc(sizeof(*slot), GFP_KERNEL);
 	if (!slot)
 		return -ENOMEM;
+
+	snprintf(name, sizeof(name), "pciehp-%u", PSN(ctrl));
+	slot->wq = alloc_workqueue(name, 0, 0);
+	if (!slot->wq)
+		goto abort;
 
 	slot->ctrl = ctrl;
 	mutex_init(&slot->lock);
 	INIT_DELAYED_WORK(&slot->work, pciehp_queue_pushbutton_work);
 	ctrl->slot = slot;
 	return 0;
+abort:
+	kfree(slot);
+	return -ENOMEM;
 }
 
 static void pcie_cleanup_slot(struct controller *ctrl)
 {
 	struct slot *slot = ctrl->slot;
 	cancel_delayed_work(&slot->work);
-	flush_workqueue(pciehp_wq);
+	destroy_workqueue(slot->wq);
 	kfree(slot);
 }
 
-- 
1.7.1


