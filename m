Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:8510 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427Ab3AKCTV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Jan 2013 21:19:21 -0500
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Daniel J Blueman <daniel@quora.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>, <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>, <stable@vger.kernel.org>
Subject: [Update][PATCH 1/2] PCI, pciehp: make every slot have its own workqueue to avoid deadlock
Date: Fri, 11 Jan 2013 10:15:54 +0800
Message-ID: <1357870554-12712-1-git-send-email-wangyijing@huawei.com>
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

+-07.0-[0000:46-4f]----00.0-[0000:47-4f]--+-04.0-[0000:48-49]----00.0-[0000:49]--
|(slot A)                                 +-08.0-[0000:4a]--
|                                         +-09.0-[0000:4b]--
|                                         +-10.0-[0000:4c]--
|                                         +-11.0-[0000:4d]--
|                                         +-14.0-[0000:4e]--
|                                         \-15.0-[0000:4f]--+-00.0  Intel Corporation 82576 Gigabit Network Connection
|                                         (slot B)          \-00.1  Intel Corporation 82576 Gigabit Network Connection

The syslog reported by Daniel J Blueman:

powering on due to button press.
pciehp 0000:09:00.0:pcie24: Link Training Error occurs
pciehp 0000:09:00.0:pcie24: Failed to check link status
INFO: task kworker/0:1:52 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/0:1   D ffff880265893090   0  52   2 0x00000000
 ffff8802655456f8 0000000000000046 ffffffff81a21a60 ffff880265545fd8
 0000000000004000 ffff880265545fd8 ffff880265892bb0 ffff880265adc8d0
 000000000000059e 0000000000000082 ffff880265545668 ffffffff810415aa
Call Trace:
 [<ffffffff810415aa>] ? console_unlock+0x1fa/0x4a0
 [<ffffffff8108d16d>] ? trace_hardirqs_off+0xd/0x10
 [<ffffffff81041b19>] ? vprintk_emit+0x1c9/0x510
 [<ffffffff81558db4>] schedule+0x24/0x70
 [<ffffffff8155653c>] schedule_timeout+0x19c/0x1e0
 [<ffffffff81558c43>] wait_for_common+0xe3/0x180
 [<ffffffff8105adc1>] ? flush_workqueue+0x111/0x4d0
 [<ffffffff81071140>] ? try_to_wake_up+0x2d0/0x2d0
 [<ffffffff81558d88>] wait_for_completion+0x18/0x20
 [<ffffffff8105ae86>] flush_workqueue+0x1d6/0x4d0
 [<ffffffff8105acb0>] ? flush_workqueue_prep_cwqs+0x200/0x200
 [<ffffffff8125e909>] pciehp_release_ctrl+0x39/0x90
 [<ffffffff8125b945>] pciehp_remove+0x25/0x30
 [<ffffffff81255bf2>] pcie_port_remove_service+0x52/0x70
 [<ffffffff81306a27>] __device_release_driver+0x77/0xe0
 [<ffffffff81306ab9>] device_release_driver+0x29/0x40
 [<ffffffff813064b1>] bus_remove_device+0xf1/0x140
 [<ffffffff81303fe7>] device_del+0x127/0x1c0
 [<ffffffff81255d70>] ? resume_iter+0x40/0x40
 [<ffffffff81304091>] device_unregister+0x11/0x20
 [<ffffffff81255da5>] remove_iter+0x35/0x40
 [<ffffffff81302eb6>] device_for_each_child+0x36/0x70
 [<ffffffff81256341>] pcie_port_device_remove+0x21/0x40
 [<ffffffff81256588>] pcie_portdrv_remove+0x28/0x50
 [<ffffffff8124a821>] pci_device_remove+0x41/0xc0
 [<ffffffff81306a27>] __device_release_driver+0x77/0xe0
 [<ffffffff81306ab9>] device_release_driver+0x29/0x40
 [<ffffffff813064b1>] bus_remove_device+0xf1/0x140
 [<ffffffff81303fe7>] device_del+0x127/0x1c0
 [<ffffffff81304091>] device_unregister+0x11/0x20
 [<ffffffff8124566c>] pci_stop_bus_device+0x8c/0xa0
 [<ffffffff81245615>] pci_stop_bus_device+0x35/0xa0
 [<ffffffff81245811>] pci_stop_and_remove_bus_device+0x11/0x20
 [<ffffffff8125cc91>] pciehp_unconfigure_device+0x91/0x190
 [<ffffffff8125c76d>] ? pciehp_power_thread+0x2d/0x110
 [<ffffffff8125c591>] pciehp_disable_slot+0x71/0x220
 [<ffffffff8125c826>] pciehp_power_thread+0xe6/0x110
 [<ffffffff8105d203>] process_one_work+0x193/0x550
 [<ffffffff8105d1a1>] ? process_one_work+0x131/0x550
 [<ffffffff8125c740>] ? pciehp_disable_slot+0x220/0x220
 [<ffffffff8105d96d>] worker_thread+0x15d/0x400
 [<ffffffff8109213d>] ? trace_hardirqs_on+0xd/0x10
 [<ffffffff8105d810>] ? rescuer_thread+0x210/0x210
 [<ffffffff81062bd6>] kthread+0xd6/0xe0
 [<ffffffff8155a18b>] ? _raw_spin_unlock_irq+0x2b/0x50
 [<ffffffff81062b00>] ? __init_kthread_worker+0x70/0x70
 [<ffffffff8155ae6c>] ret_from_fork+0x7c/0xb0
 [<ffffffff81062b00>] ? __init_kthread_worker+0x70/0x70


Reported-by: Daniel J Blueman <daniel@quora.org>
Reviewed-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Cc: stable@vger.kernel.org
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
index 916bf4f..939bd1d 100644
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
index 13b2eaf..5127f3f 100644
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
 
+	snprintf(name, sizeof(name), "pciehp-%u", PSN(ctrl));
+	slot->wq = alloc_workqueue(name, 0, 0);
+	if (!slot->wq)
+		goto abort;
+
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


