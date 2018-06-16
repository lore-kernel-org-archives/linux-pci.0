Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:48961 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932542AbeFPT10 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jun 2018 15:27:26 -0400
Message-Id: <96b1a71f1aece3acf21614e822b46ece9731e8ba.1529173804.git.lukas@wunner.de>
In-Reply-To: <cover.1529173804.git.lukas@wunner.de>
References: <cover.1529173804.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 16 Jun 2018 21:25:00 +0200
Subject: [PATCH 07/32] PCI: pciehp: Document struct slot and struct controller
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Document the driver's data structures to lower the barrier to entry for
contributors.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp.h | 48 +++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index acdeb08cbcba..c3d63e5b650f 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -57,11 +57,26 @@ do {									\
 	dev_warn(&ctrl->pcie->device, format, ## arg)
 
 #define SLOT_NAME_SIZE 10
+
+/**
+ * struct slot - PCIe hotplug slot
+ * @state: current state machine position
+ * @ctrl: pointer to the slot's controller structure
+ * @hotplug_slot: pointer to the structure registered with the PCI hotplug core
+ * @work: work item to turn the slot on or off after 5 seconds in response to
+ *	an Attention Button press
+ * @lock: protects reads and writes of @state;
+ *	protects scheduling, execution and cancellation of @work
+ * @hotplug_lock: serializes calls to pciehp_enable_slot() and
+ *	pciehp_disable_slot()
+ * @wq: work queue on which @work is scheduled;
+ *	also used to queue interrupt events and slot enablement and disablement
+ */
 struct slot {
 	u8 state;
 	struct controller *ctrl;
 	struct hotplug_slot *hotplug_slot;
-	struct delayed_work work;	/* work for button event */
+	struct delayed_work work;
 	struct mutex lock;
 	struct mutex hotplug_lock;
 	struct workqueue_struct *wq;
@@ -73,11 +88,36 @@ struct event_info {
 	struct work_struct work;
 };
 
+/**
+ * struct controller - PCIe hotplug controller
+ * @ctrl_lock: serializes writes to the Slot Control register
+ * @pcie: pointer to the controller's PCIe port service device
+ * @slot: pointer to the controller's slot structure
+ * @queue: wait queue to wake up on reception of a Command Completed event,
+ *	used for synchronous writes to the Slot Control register
+ * @slot_cap: cached copy of the Slot Capabilities register
+ * @slot_ctrl: cached copy of the Slot Control register
+ * @poll_timer: timer to poll for slot events if no IRQ is available,
+ *	enabled with pciehp_poll_mode module parameter
+ * @cmd_started: jiffies when the Slot Control register was last written;
+ *	the next write is allowed 1 second later, absent a Command Completed
+ *	interrupt (PCIe r4.0, sec 6.7.3.2)
+ * @cmd_busy: flag set on Slot Control register write, cleared by IRQ handler
+ *	on reception of a Command Completed event
+ * @link_active_reporting: cached copy of Data Link Layer Link Active Reporting
+ *	Capable bit in Link Capabilities register; if this bit is zero, the
+ *	Data Link Layer Link Active bit in the Link Status register will never
+ *	be set and the driver is thus confined to wait 1 second before assuming
+ *	the link to a hotplugged device is up and accessing it
+ * @notification_enabled: whether the IRQ was requested successfully
+ * @power_fault_detected: whether a power fault was detected by the hardware
+ *	that has not yet been cleared by the user
+ */
 struct controller {
-	struct mutex ctrl_lock;		/* controller lock */
-	struct pcie_device *pcie;	/* PCI Express port service */
+	struct mutex ctrl_lock;
+	struct pcie_device *pcie;
 	struct slot *slot;
-	wait_queue_head_t queue;	/* sleep & wake process */
+	wait_queue_head_t queue;
 	u32 slot_cap;
 	u16 slot_ctrl;
 	struct timer_list poll_timer;
-- 
2.17.1
