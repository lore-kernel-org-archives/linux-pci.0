Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:57783 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932720Ab3AJDX4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Jan 2013 22:23:56 -0500
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>, <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 2/2] PCI,shpchp: make every slot have its own workqueue to avoid deadlock
Date: Thu, 10 Jan 2013 11:22:59 +0800
Message-ID: <1357788179-9764-2-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1357788179-9764-1-git-send-email-wangyijing@huawei.com>
References: <1357788179-9764-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

remove the global shpchp_wq,shpchp_ordered_wq and create a new workqueue
for every slot to avoid deadlock when hot remove a pci iobox(which is
slot--connected---slot).

call path:
 button press
   shpc_isr(interrupt handler)
      shpchp_handle_attention_button
         queue_interrupt_event
            queue_work "interrupt_event_handler" into "shpchp_wq"
                interrupt_event_handler
                   handle_button_press_event
                       queue_delayed_work "shpchp_queue_pushbutton_work" into "shpchp_wq"
                          queue_work "shpchp_pushbutton_thread" into "shpchp_ordered_wq"
                              shpchp_pushbutton_thread
                                  shpchp_disable_slot
                                     pci_stop_and_remove_bus_device
                                       ......
                                       shpc_remove()
                                         hpc_release_ctlr
                                           flush_workqueue(shpchp_wq);
                                           flush_workqueue(shpchp_ordered_wq);
In this call path, flush_workqueue task will hang, because shpchp_ordered_wq is running.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/hotplug/shpchp.h      |    3 +--
 drivers/pci/hotplug/shpchp_core.c |   34 +++++++++++++---------------------
 drivers/pci/hotplug/shpchp_ctrl.c |    6 +++---
 3 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/hotplug/shpchp.h b/drivers/pci/hotplug/shpchp.h
index ca64932..b849f99 100644
--- a/drivers/pci/hotplug/shpchp.h
+++ b/drivers/pci/hotplug/shpchp.h
@@ -46,8 +46,6 @@
 extern bool shpchp_poll_mode;
 extern int shpchp_poll_time;
 extern bool shpchp_debug;
-extern struct workqueue_struct *shpchp_wq;
-extern struct workqueue_struct *shpchp_ordered_wq;
 
 #define dbg(format, arg...)						\
 do {									\
@@ -91,6 +89,7 @@ struct slot {
 	struct list_head	slot_list;
 	struct delayed_work work;	/* work for button event */
 	struct mutex lock;
+	struct workqueue_struct *wq;
 	u8 hp_slot;
 };
 
diff --git a/drivers/pci/hotplug/shpchp_core.c b/drivers/pci/hotplug/shpchp_core.c
index b6de307..01d39cc 100644
--- a/drivers/pci/hotplug/shpchp_core.c
+++ b/drivers/pci/hotplug/shpchp_core.c
@@ -39,8 +39,6 @@
 bool shpchp_debug;
 bool shpchp_poll_mode;
 int shpchp_poll_time;
-struct workqueue_struct *shpchp_wq;
-struct workqueue_struct *shpchp_ordered_wq;
 
 #define DRIVER_VERSION	"0.4"
 #define DRIVER_AUTHOR	"Dan Zink <dan.zink@compaq.com>, Greg Kroah-Hartman <greg@kroah.com>, Dely Sy <dely.l.sy@intel.com>"
@@ -129,6 +127,14 @@ static int init_slots(struct controller *ctrl)
 		slot->device = ctrl->slot_device_offset + i;
 		slot->hpc_ops = ctrl->hpc_ops;
 		slot->number = ctrl->first_slot + (ctrl->slot_num_inc * i);
+
+		snprintf(name, sizeof(name), "shpchp-%d", slot->number);
+		slot->wq = alloc_workqueue(name, 0, 0);
+		if (!slot->wq) {
+			retval = -ENOMEM;
+			goto error_info;
+		}
+
 		mutex_init(&slot->lock);
 		INIT_DELAYED_WORK(&slot->work, shpchp_queue_pushbutton_work);
 
@@ -148,7 +154,7 @@ static int init_slots(struct controller *ctrl)
 		if (retval) {
 			ctrl_err(ctrl, "pci_hp_register failed with error %d\n",
 				 retval);
-			goto error_info;
+			goto error_slotwq;
 		}
 
 		get_power_status(hotplug_slot, &info->power_status);
@@ -160,6 +166,8 @@ static int init_slots(struct controller *ctrl)
 	}
 
 	return 0;
+error_slotwq:
+	destroy_workqueue(slot->wq);
 error_info:
 	kfree(info);
 error_hpslot:
@@ -180,8 +188,7 @@ void cleanup_slots(struct controller *ctrl)
 		slot = list_entry(tmp, struct slot, slot_list);
 		list_del(&slot->slot_list);
 		cancel_delayed_work(&slot->work);
-		flush_workqueue(shpchp_wq);
-		flush_workqueue(shpchp_ordered_wq);
+		destroy_workqueue(slot->wq);
 		pci_hp_deregister(slot->hotplug_slot);
 	}
 }
@@ -366,23 +373,10 @@ static int __init shpcd_init(void)
 {
 	int retval = 0;
 
-	shpchp_wq = alloc_ordered_workqueue("shpchp", 0);
-	if (!shpchp_wq)
-		return -ENOMEM;
-
-	shpchp_ordered_wq = alloc_ordered_workqueue("shpchp_ordered", 0);
-	if (!shpchp_ordered_wq) {
-		destroy_workqueue(shpchp_wq);
-		return -ENOMEM;
-	}
-
 	retval = pci_register_driver(&shpc_driver);
 	dbg("%s: pci_register_driver = %d\n", __func__, retval);
 	info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
-	if (retval) {
-		destroy_workqueue(shpchp_ordered_wq);
-		destroy_workqueue(shpchp_wq);
-	}
+
 	return retval;
 }
 
@@ -390,8 +384,6 @@ static void __exit shpcd_cleanup(void)
 {
 	dbg("unload_shpchpd()\n");
 	pci_unregister_driver(&shpc_driver);
-	destroy_workqueue(shpchp_ordered_wq);
-	destroy_workqueue(shpchp_wq);
 	info(DRIVER_DESC " version: " DRIVER_VERSION " unloaded\n");
 }
 
diff --git a/drivers/pci/hotplug/shpchp_ctrl.c b/drivers/pci/hotplug/shpchp_ctrl.c
index f9b5a52..5849927 100644
--- a/drivers/pci/hotplug/shpchp_ctrl.c
+++ b/drivers/pci/hotplug/shpchp_ctrl.c
@@ -51,7 +51,7 @@ static int queue_interrupt_event(struct slot *p_slot, u32 event_type)
 	info->p_slot = p_slot;
 	INIT_WORK(&info->work, interrupt_event_handler);
 
-	queue_work(shpchp_wq, &info->work);
+	queue_work(p_slot->wq, &info->work);
 
 	return 0;
 }
@@ -453,7 +453,7 @@ void shpchp_queue_pushbutton_work(struct work_struct *work)
 		kfree(info);
 		goto out;
 	}
-	queue_work(shpchp_ordered_wq, &info->work);
+	queue_work(p_slot->wq, &info->work);
  out:
 	mutex_unlock(&p_slot->lock);
 }
@@ -501,7 +501,7 @@ static void handle_button_press_event(struct slot *p_slot)
 		p_slot->hpc_ops->green_led_blink(p_slot);
 		p_slot->hpc_ops->set_attention_status(p_slot, 0);
 
-		queue_delayed_work(shpchp_wq, &p_slot->work, 5*HZ);
+		queue_delayed_work(p_slot->wq, &p_slot->work, 5*HZ);
 		break;
 	case BLINKINGOFF_STATE:
 	case BLINKINGON_STATE:
-- 
1.7.1


