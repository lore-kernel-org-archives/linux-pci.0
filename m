Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:24638 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751391AbeA3Ila (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jan 2018 03:41:30 -0500
From: Stefan Roese <sr@denx.de>
To: linux-pci@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [RFC PATCH] PCI: pciehp: Add module parameter to enable debouncing of HP link events
Date: Tue, 30 Jan 2018 09:41:21 +0100
Message-Id: <20180130084121.18653-1-sr@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hotplugging of some PCIe devices on our platform sometimes leads to a
bounce of link-up and link-down events, resulting in problems in the
corresponding PCI drivers.

Here an example of such a hotplug event bounce for a AHCI PCIe card:
...
pciehp 0000:00:1c.1:pcie004: Slot(1): Card present
pciehp 0000:00:1c.1:pcie004: Slot(1): Link Up
pciehp 0000:00:1c.1:pcie004: Slot(1): Link Up event ignored; already powering on
pciehp 0000:00:1c.1:pcie004: Slot(1): Link Down
pciehp 0000:00:1c.1:pcie004: Slot(1): Card present
pciehp 0000:00:1c.1:pcie004: Slot(1): Link Up
pci 0000:02:00.0: [1b4b:9215] type 00 class 0x010601
pci 0000:02:00.0: reg 0x10: [io  0x8000-0x8007]
...
ata3: SATA max UDMA/133 abar m2048@0x80910000 port 0x80910100 irq 100
ata4: SATA max UDMA/133 abar m2048@0x80910000 port 0x80910180 irq 100
ata5: SATA max UDMA/133 abar m2048@0x80910000 port 0x80910200 irq 100
ata6: SATA max UDMA/133 abar m2048@0x80910000 port 0x80910280 irq 100
pciehp 0000:00:1c.1:pcie004: Slot(1): Link Up event ignored; already powering on
ahci 0000:02:00.0: PME# disabled
ata3: SATA link down (SStatus 0 SControl 300)
ata5: SATA link down (SStatus 0 SControl 300)
ata4: SATA link down (SStatus 0 SControl 300)
WARNING: CPU: 2 PID: 1162 at drivers/ata/libata-core.c:6620 ata_host_detach+0x125/0x130
ata6: SATA link down (SStatus 0 SControl 300)
Modules linked in:
CPU: 2 PID: 1162 Comm: kworker/u8:5 Not tainted 4.15.0+ #26
Hardware name: congatec conga-qeval20-qa3-e3845/conga-qeval20-qa3-e3845, BIOS 2018.01-00033-g0125f37185-dirty 01/18/2018
Workqueue: pciehp-1 pciehp_power_thread
...

This patch now adds the 'pciehp_debounce_time' module parameter, which
can be used to drop all events for the specified time (in milliseconds)
after a link-up event occurred. A value of ~100ms works fine in my tests
to debounce all the link-up / link-down events in my tests.

If this parameter is not set (default) then the current implementation
is unchanged and all events are handled.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp.h      |  3 +++
 drivers/pci/hotplug/pciehp_core.c |  4 ++++
 drivers/pci/hotplug/pciehp_ctrl.c | 38 ++++++++++++++++++++++++++++++++++----
 3 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 06109d40c4ac..a9ff87150e82 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -43,6 +43,7 @@
 extern bool pciehp_poll_mode;
 extern int pciehp_poll_time;
 extern bool pciehp_debug;
+extern int pciehp_debounce_time;
 
 #define dbg(format, arg...)						\
 do {									\
@@ -78,6 +79,8 @@ struct slot {
 	struct mutex lock;
 	struct mutex hotplug_lock;
 	struct workqueue_struct *wq;
+	unsigned long linkup_start;	/* jiffies */
+	int linkup_debounce_active;	/* linkup-debounce is active */
 };
 
 struct event_info {
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 35d84845d5af..5a97f2550cba 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -45,6 +45,7 @@ bool pciehp_debug;
 bool pciehp_poll_mode;
 int pciehp_poll_time;
 static bool pciehp_force;
+int pciehp_debounce_time;
 
 /*
  * not really modular, but the easiest way to keep compat with existing
@@ -54,10 +55,13 @@ module_param(pciehp_debug, bool, 0644);
 module_param(pciehp_poll_mode, bool, 0644);
 module_param(pciehp_poll_time, int, 0644);
 module_param(pciehp_force, bool, 0644);
+module_param(pciehp_debounce_time, int, 0644);
 MODULE_PARM_DESC(pciehp_debug, "Debugging mode enabled or not");
 MODULE_PARM_DESC(pciehp_poll_mode, "Using polling mechanism for hot-plug events or not");
 MODULE_PARM_DESC(pciehp_poll_time, "Polling mechanism frequency, in seconds");
 MODULE_PARM_DESC(pciehp_force, "Force pciehp, even if OSHP is missing");
+MODULE_PARM_DESC(pciehp_debounce_time,
+		 "PCIe hotplug debounce time in milliseconds");
 
 #define PCIE_MODULE_NAME "pciehp"
 
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 83f3d4af3677..03d966c21c41 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -40,6 +40,7 @@ static void interrupt_event_handler(struct work_struct *work);
 void pciehp_queue_interrupt_event(struct slot *p_slot, u32 event_type)
 {
 	struct event_info *info;
+	bool drop_event = false;
 
 	info = kmalloc(sizeof(*info), GFP_ATOMIC);
 	if (!info) {
@@ -47,10 +48,39 @@ void pciehp_queue_interrupt_event(struct slot *p_slot, u32 event_type)
 		return;
 	}
 
-	INIT_WORK(&info->work, interrupt_event_handler);
-	info->event_type = event_type;
-	info->p_slot = p_slot;
-	queue_work(p_slot->wq, &info->work);
+	/* Clear linkup-debounce flag if time exceeds linkup-debounce timeout */
+	if (time_after(jiffies, p_slot->linkup_start +
+		       msecs_to_jiffies(pciehp_debounce_time)))
+		p_slot->linkup_debounce_active = 0;
+
+	/* Check if this event starts a new linkup-debounce period */
+	if (pciehp_debounce_time && (event_type == INT_LINK_UP) &&
+	    !p_slot->linkup_debounce_active) {
+		p_slot->linkup_start = jiffies;
+		p_slot->linkup_debounce_active = 1;
+		ctrl_info(p_slot->ctrl,
+			  "Slot(%s): Linkup-debounce active for %dms\n",
+			  slot_name(p_slot), pciehp_debounce_time);
+	} else {
+		/*
+		 * Drop this event if it occurs inside the debounce period
+		 * after the linkup event
+		 */
+		if (p_slot->linkup_debounce_active)
+			drop_event = true;
+	}
+
+	if (drop_event) {
+		ctrl_info(p_slot->ctrl,
+			  "Slot(%s): Event %x dropped (dt=%dms)!\n",
+			  slot_name(p_slot), event_type,
+			  jiffies_to_msecs(jiffies - p_slot->linkup_start));
+	} else {
+		INIT_WORK(&info->work, interrupt_event_handler);
+		info->event_type = event_type;
+		info->p_slot = p_slot;
+		queue_work(p_slot->wq, &info->work);
+	}
 }
 
 /* The following routines constitute the bulk of the
-- 
2.16.1
