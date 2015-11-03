Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58357 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752914AbbKCDsW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Nov 2015 22:48:22 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 2/2] PCI: pciehp: Implement support for delayed poweron
Date: Mon,  2 Nov 2015 19:48:16 -0800
Message-Id: <1446522496-21628-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1446522496-21628-1-git-send-email-linux@roeck-us.net>
References: <1446522496-21628-1-git-send-email-linux@roeck-us.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some oddball devices may experience PCIe link flaps after power-on.
This may result in the following sequence of events.

fpc0 kernel: pciehp 0000:02:08.0:pcie24: Card present on Slot(0)
fpc0 kernel: pciehp 0000:02:08.0:pcie24: slot(0): Link Up event
fpc0 kernel: pciehp 0000:02:08.0:pcie24:
	Link Up event ignored on slot(0): already powering on
fpc0 kernel: pciehp 0000:02:08.0:pcie24: slot(0): Link Down event
fpc0 kernel: pciehp 0000:02:08.0:pcie24:
	Link Down event queued on slot(0): currently getting powered on
fpc0 kernel: pciehp 0000:02:08.0:pcie24: slot(0): Link Up event
fpc0 kernel: pciehp 0000:02:08.0:pcie24:
	Link Up event queued on slot(0): currently getting powered off

This causes the driver for affected devices to be instantiated, removed,
and re-instantiated. While commit 'PCI: pciehp: Implement hotplug event
folding' reduces the scope of the problem, it can still occur. In some
cases, device insertion followed by immediate removal can result errors
such as the following.

fpc0 kernel: remove_proc_entry: removing non-empty directory 'irq/148',
	leaking at least 'pic0'
fpc0 kernel: ------------[ cut here ]------------
fpc0 kernel: WARNING: at fs/proc/generic.c:575

This can for example happen if the removed device provides gpio pins
and/or interrupts used by other drivers, if those other drivers are still
instantiated.

Add support for per-port power-on delay to avoid this situation. This can
be enabled globally with the pciehp_poweron_delay module parameter, or
per port (using a quirks function) with a new poweron_delay flag in
struct pci_dev.

With this patch, the link flap still occurs, but because of the delayed
insertion the driver is not immediately instantiated, and the above error
is no longer seen.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/pci/hotplug/pciehp.h      |  4 +++-
 drivers/pci/hotplug/pciehp_core.c |  3 +++
 drivers/pci/hotplug/pciehp_ctrl.c | 30 +++++++++++++++++++-----------
 drivers/pci/hotplug/pciehp_hpc.c  |  5 ++++-
 include/linux/pci.h               |  1 +
 5 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 364b6fa32978..0d44b1691431 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -40,6 +40,7 @@
 
 #define MY_NAME	"pciehp"
 
+extern bool pciehp_poweron_delay;
 extern bool pciehp_poll_mode;
 extern int pciehp_poll_time;
 extern bool pciehp_debug;
@@ -78,7 +79,7 @@ struct slot {
 	struct mutex lock;
 	struct mutex hotplug_lock;
 	struct workqueue_struct *wq;
-	struct work_struct hotplug_work;
+	struct delayed_work hotplug_work;
 	u32 hotplug_req;
 	bool disable;			/* true to disable before enable */
 };
@@ -101,6 +102,7 @@ struct controller {
 	unsigned int cmd_busy:1;
 	unsigned int link_active_reporting:1;
 	unsigned int notification_enabled:1;
+	unsigned int poweron_delay:1;
 	unsigned int power_fault_detected;
 };
 
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 612b21a14df5..cc69fd10d884 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -38,6 +38,7 @@
 #include <linux/time.h>
 
 /* Global variables */
+bool pciehp_poweron_delay;
 bool pciehp_debug;
 bool pciehp_poll_mode;
 int pciehp_poll_time;
@@ -51,10 +52,12 @@ MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
+module_param(pciehp_poweron_delay, bool, 0644);
 module_param(pciehp_debug, bool, 0644);
 module_param(pciehp_poll_mode, bool, 0644);
 module_param(pciehp_poll_time, int, 0644);
 module_param(pciehp_force, bool, 0644);
+MODULE_PARM_DESC(pciehp_poweron_delay, "Delay port power-on");
 MODULE_PARM_DESC(pciehp_debug, "Debugging mode enabled or not");
 MODULE_PARM_DESC(pciehp_poll_mode, "Using polling mechanism for hot-plug events or not");
 MODULE_PARM_DESC(pciehp_poll_time, "Polling mechanism frequency, in seconds");
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index ad1321e91546..0c5b2e5965ce 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -169,7 +169,8 @@ static int remove_board(struct slot *p_slot)
  */
 void pciehp_power_thread(struct work_struct *work)
 {
-	struct slot *p_slot = container_of(work, struct slot, hotplug_work);
+	struct slot *p_slot = container_of(work, struct slot,
+					   hotplug_work.work);
 	int ret, req;
 	bool disable;
 
@@ -205,17 +206,21 @@ void pciehp_power_thread(struct work_struct *work)
 	}
 }
 
-static void pciehp_queue_power_work(struct slot *p_slot, int req)
+static void pciehp_queue_power_work(struct slot *p_slot, int req, bool delay)
 {
+	int delay_hz = 0;
+
 	if (req == ENABLE_REQ) {
 		p_slot->state = POWERON_STATE;
+		if (delay)
+			delay_hz = HZ;
 	} else {
 		p_slot->state = POWEROFF_STATE;
 		p_slot->disable = true;
 	}
 	p_slot->hotplug_req = req;
 
-	queue_work(p_slot->wq, &p_slot->hotplug_work);
+	mod_delayed_work(p_slot->wq, &p_slot->hotplug_work, delay_hz);
 }
 
 void pciehp_queue_pushbutton_work(struct work_struct *work)
@@ -225,10 +230,10 @@ void pciehp_queue_pushbutton_work(struct work_struct *work)
 	mutex_lock(&p_slot->lock);
 	switch (p_slot->state) {
 	case BLINKINGOFF_STATE:
-		pciehp_queue_power_work(p_slot, DISABLE_REQ);
+		pciehp_queue_power_work(p_slot, DISABLE_REQ, false);
 		break;
 	case BLINKINGON_STATE:
-		pciehp_queue_power_work(p_slot, ENABLE_REQ);
+		pciehp_queue_power_work(p_slot, ENABLE_REQ, false);
 		break;
 	default:
 		break;
@@ -259,7 +264,7 @@ static void handle_button_press_event(struct slot *p_slot)
 		/* blink green LED and turn off amber */
 		pciehp_green_led_blink(p_slot);
 		pciehp_set_attention_status(p_slot, 0);
-		queue_delayed_work(p_slot->wq, &p_slot->work, 5*HZ);
+		mod_delayed_work(p_slot->wq, &p_slot->work, 5*HZ);
 		break;
 	case BLINKINGOFF_STATE:
 	case BLINKINGON_STATE:
@@ -303,9 +308,10 @@ static void handle_surprise_event(struct slot *p_slot)
 
 	pciehp_get_adapter_status(p_slot, &getstatus);
 	if (!getstatus)
-		pciehp_queue_power_work(p_slot, DISABLE_REQ);
+		pciehp_queue_power_work(p_slot, DISABLE_REQ, false);
 	else
-		pciehp_queue_power_work(p_slot, ENABLE_REQ);
+		pciehp_queue_power_work(p_slot, ENABLE_REQ,
+					p_slot->ctrl->poweron_delay);
 }
 
 /*
@@ -322,7 +328,8 @@ static void handle_link_event(struct slot *p_slot, u32 event)
 		/* Fall through */
 	case STATIC_STATE:
 		pciehp_queue_power_work(p_slot, event == INT_LINK_UP ?
-					ENABLE_REQ : DISABLE_REQ);
+					ENABLE_REQ : DISABLE_REQ,
+					ctrl->poweron_delay);
 		break;
 	case POWERON_STATE:
 		if (event == INT_LINK_UP) {
@@ -333,7 +340,7 @@ static void handle_link_event(struct slot *p_slot, u32 event)
 			ctrl_info(ctrl,
 				  "Link Down event queued on slot(%s): currently getting powered on\n",
 				  slot_name(p_slot));
-			pciehp_queue_power_work(p_slot, DISABLE_REQ);
+			pciehp_queue_power_work(p_slot, DISABLE_REQ, false);
 		}
 		break;
 	case POWEROFF_STATE:
@@ -341,7 +348,8 @@ static void handle_link_event(struct slot *p_slot, u32 event)
 			ctrl_info(ctrl,
 				  "Link Up event queued on slot(%s): currently getting powered off\n",
 				  slot_name(p_slot));
-			pciehp_queue_power_work(p_slot, ENABLE_REQ);
+			pciehp_queue_power_work(p_slot, ENABLE_REQ,
+						ctrl->poweron_delay);
 		} else {
 			ctrl_info(ctrl,
 				  "Link Down event ignored on slot(%s): already powering off\n",
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index e4e6fcbe1e20..11e1a34bd57b 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -755,7 +755,7 @@ static int pcie_init_slot(struct controller *ctrl)
 	mutex_init(&slot->lock);
 	mutex_init(&slot->hotplug_lock);
 	INIT_DELAYED_WORK(&slot->work, pciehp_queue_pushbutton_work);
-	INIT_WORK(&slot->hotplug_work, pciehp_power_thread);
+	INIT_DELAYED_WORK(&slot->hotplug_work, pciehp_power_thread);
 	ctrl->slot = slot;
 	return 0;
 abort:
@@ -767,6 +767,7 @@ static void pcie_cleanup_slot(struct controller *ctrl)
 {
 	struct slot *slot = ctrl->slot;
 	cancel_delayed_work(&slot->work);
+	cancel_delayed_work(&slot->hotplug_work);
 	destroy_workqueue(slot->wq);
 	kfree(slot);
 }
@@ -810,6 +811,8 @@ struct controller *pcie_init(struct pcie_device *dev)
 	pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &link_cap);
 	if (link_cap & PCI_EXP_LNKCAP_DLLLARC)
 		ctrl->link_active_reporting = 1;
+	if (pciehp_poweron_delay || dev->port->poweron_delay)
+		ctrl->poweron_delay = 1;
 
 	/* Clear all remaining event bits in Slot Status register */
 	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e90eb22de628..e93c3d4e5b70 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -359,6 +359,7 @@ struct pci_dev {
 	unsigned int	io_window_1k:1;	/* Intel P2P bridge 1K I/O windows */
 	unsigned int	irq_managed:1;
 	unsigned int	has_secondary_link:1;
+	unsigned int	poweron_delay:1; /* Port needs poweron delay */
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
 
-- 
2.1.4

