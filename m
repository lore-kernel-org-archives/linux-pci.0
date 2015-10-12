Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 2/2] PCI: pciehp: Add support for delayed power-on
Date: Mon, 12 Oct 2015 12:10:13 -0700
Message-Id: <1444677013-3836-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1444677013-3836-1-git-send-email-linux@roeck-us.net>
References: <1444677013-3836-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some oddball devices may experience a PCIe link flap after power-on.
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
and re-instantiated. This can result in problems, for example if the device
in question provides gpio pins or interrupts which are used by other
drivers. For example, the removal can result in errors such as
the following.

fpc0 kernel: remove_proc_entry: removing non-empty directory 'irq/148',
	leaking at least 'pic0'
fpc0 kernel: ------------[ cut here ]------------
fpc0 kernel: WARNING: at /home/p2020/linux-freescale/fs/proc/generic.c:575

Add support for per-port power-on delay to avoid this situation. This can
be enabled globally with the pciehp_poweron_delay module parameter, or
per port (using a quirks function) with a new poweron_delay flag in
struct pci_dev.

With this patch, the link flap still occurs, but because of the delayed
insertion the driver is not immediately instantiated, and the above error
is no longer seen.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
We started seeing this problem after the recent rework of link status
change handling. I think the up/down/up sequence was previously just
ignored or folded into a single event (and sometimes resulted in a stuck
state machine).
I would like to see this patch upstream, but I am not sure if the problem
is seen anywhere but on the hardware I am dealing with, and I can
understand if others don't want to pollute the pcie hotplug code with
such workarounds. Also, maybe someone has a better idea on how to handle
the situation, so I marked the patch as RFC.

 drivers/pci/hotplug/pciehp.h      |  5 ++++-
 drivers/pci/hotplug/pciehp_core.c |  3 +++
 drivers/pci/hotplug/pciehp_ctrl.c | 44 +++++++++++++++++++++++++++------------
 drivers/pci/hotplug/pciehp_hpc.c  |  2 ++
 include/linux/pci.h               |  1 +
 5 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 62d6fe6c3714..5047bde7d51d 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -40,6 +40,7 @@
 
 #define MY_NAME	"pciehp"
 
+extern bool pciehp_poweron_delay;
 extern bool pciehp_poll_mode;
 extern int pciehp_poll_time;
 extern bool pciehp_debug;
@@ -98,6 +99,7 @@ struct controller {
 	unsigned int cmd_busy:1;
 	unsigned int link_active_reporting:1;
 	unsigned int notification_enabled:1;
+	unsigned int poweron_delay:1;	/* Delay poweron for this slot */
 	unsigned int power_fault_detected;
 };
 
@@ -112,7 +114,8 @@ struct controller {
 #define BLINKINGON_STATE		1
 #define BLINKINGOFF_STATE		2
 #define POWERON_STATE			3
-#define POWEROFF_STATE			4
+#define DELAYED_POWERON_STATE		4
+#define POWEROFF_STATE			5
 
 #define ATTN_BUTTN(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_ABP)
 #define POWER_CTRL(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_PCP)
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
index ef96a1d51fac..fd829c2b7418 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -204,11 +204,19 @@ static void pciehp_power_thread(struct work_struct *work)
 	kfree(info);
 }
 
-void pciehp_queue_power_work(struct slot *p_slot, int req)
+void pciehp_queue_power_work(struct slot *p_slot, int req, bool delay)
 {
 	struct power_work_info *info;
 
-	p_slot->state = req == ENABLE_REQ ? POWERON_STATE : POWEROFF_STATE;
+	if (req == ENABLE_REQ) {
+		p_slot->state = delay ? DELAYED_POWERON_STATE : POWERON_STATE;
+		if (delay) {
+			mod_delayed_work(p_slot->wq, &p_slot->work, HZ);
+			return;
+		}
+	} else {
+		p_slot->state = POWEROFF_STATE;
+	}
 
 	info = kmalloc(sizeof(*info), GFP_KERNEL);
 	if (!info) {
@@ -229,10 +237,11 @@ void pciehp_queue_pushbutton_work(struct work_struct *work)
 	mutex_lock(&p_slot->lock);
 	switch (p_slot->state) {
 	case BLINKINGOFF_STATE:
-		pciehp_queue_power_work(p_slot, DISABLE_REQ);
+		pciehp_queue_power_work(p_slot, DISABLE_REQ, false);
 		break;
 	case BLINKINGON_STATE:
-		pciehp_queue_power_work(p_slot, ENABLE_REQ);
+	case DELAYED_POWERON_STATE:
+		pciehp_queue_power_work(p_slot, ENABLE_REQ, false);
 		break;
 	default:
 		break;
@@ -263,7 +272,7 @@ static void handle_button_press_event(struct slot *p_slot)
 		/* blink green LED and turn off amber */
 		pciehp_green_led_blink(p_slot);
 		pciehp_set_attention_status(p_slot, 0);
-		queue_delayed_work(p_slot->wq, &p_slot->work, 5*HZ);
+		mod_delayed_work(p_slot->wq, &p_slot->work, 5 * HZ);
 		break;
 	case BLINKINGOFF_STATE:
 	case BLINKINGON_STATE:
@@ -285,6 +294,7 @@ static void handle_button_press_event(struct slot *p_slot)
 		break;
 	case POWEROFF_STATE:
 	case POWERON_STATE:
+	case DELAYED_POWERON_STATE:
 		/*
 		 * Ignore if the slot is on power-on or power-off state;
 		 * this means that the previous attention button action
@@ -305,12 +315,12 @@ static void handle_surprise_event(struct slot *p_slot)
 {
 	u8 getstatus;
 
+	if (p_slot->state == DELAYED_POWERON_STATE)
+		cancel_delayed_work(&p_slot->work);
+
 	pciehp_get_adapter_status(p_slot, &getstatus);
-	if (!getstatus) {
-		pciehp_queue_power_work(p_slot, DISABLE_REQ);
-	} else {
-		pciehp_queue_power_work(p_slot, ENABLE_REQ);
-	}
+	pciehp_queue_power_work(p_slot, getstatus ? ENABLE_REQ : DISABLE_REQ,
+				p_slot->ctrl->poweron_delay);
 }
 
 /*
@@ -327,8 +337,13 @@ static void handle_link_event(struct slot *p_slot, u32 event)
 		/* Fall through */
 	case STATIC_STATE:
 		pciehp_queue_power_work(p_slot, event == INT_LINK_UP ?
-					ENABLE_REQ : DISABLE_REQ);
+					ENABLE_REQ : DISABLE_REQ,
+					ctrl->poweron_delay);
 		break;
+	case DELAYED_POWERON_STATE:
+		if (event != INT_LINK_UP)
+			cancel_delayed_work(&p_slot->work);
+		/* Fall through */
 	case POWERON_STATE:
 		if (event == INT_LINK_UP) {
 			ctrl_info(ctrl,
@@ -338,7 +353,7 @@ static void handle_link_event(struct slot *p_slot, u32 event)
 			ctrl_info(ctrl,
 				  "Link Down event queued on slot(%s): currently getting powered on\n",
 				  slot_name(p_slot));
-			pciehp_queue_power_work(p_slot, DISABLE_REQ);
+			pciehp_queue_power_work(p_slot, DISABLE_REQ, false);
 		}
 		break;
 	case POWEROFF_STATE:
@@ -346,7 +361,8 @@ static void handle_link_event(struct slot *p_slot, u32 event)
 			ctrl_info(ctrl,
 				  "Link Up event queued on slot(%s): currently getting powered off\n",
 				  slot_name(p_slot));
-			pciehp_queue_power_work(p_slot, ENABLE_REQ);
+			pciehp_queue_power_work(p_slot, ENABLE_REQ,
+						ctrl->poweron_delay);
 		} else {
 			ctrl_info(ctrl,
 				  "Link Down event ignored on slot(%s): already powering off\n",
@@ -482,6 +498,7 @@ int pciehp_sysfs_enable_slot(struct slot *p_slot)
 		p_slot->state = STATIC_STATE;
 		break;
 	case POWERON_STATE:
+	case DELAYED_POWERON_STATE:
 		ctrl_info(ctrl, "Slot %s is already in powering on state\n",
 			  slot_name(p_slot));
 		break;
@@ -522,6 +539,7 @@ int pciehp_sysfs_disable_slot(struct slot *p_slot)
 		break;
 	case BLINKINGON_STATE:
 	case POWERON_STATE:
+	case DELAYED_POWERON_STATE:
 		ctrl_info(ctrl, "Already disabled on slot %s\n",
 			  slot_name(p_slot));
 		break;
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 5c24e938042f..7c7a598eec9f 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -809,6 +809,8 @@ struct controller *pcie_init(struct pcie_device *dev)
 	pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &link_cap);
 	if (link_cap & PCI_EXP_LNKCAP_DLLLARC)
 		ctrl->link_active_reporting = 1;
+	if (pciehp_poweron_delay || dev->port->poweron_delay)
+		ctrl->poweron_delay = 1;
 
 	/* Clear all remaining event bits in Slot Status register */
 	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e90eb22de628..9cb0fe3037b9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -359,6 +359,7 @@ struct pci_dev {
 	unsigned int	io_window_1k:1;	/* Intel P2P bridge 1K I/O windows */
 	unsigned int	irq_managed:1;
 	unsigned int	has_secondary_link:1;
+	unsigned int    poweron_delay:1;	/* Port needs poweron delay */
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
 
-- 
2.1.4

