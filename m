Return-Path: <SRS0=Zo3Z=LW=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=Zo3Z=LW=wunner.de=lukas@kernel.org>
Message-Id: <c6163261eeb114417672ecf60ad3b14b23f3128b.1536341821.git.lukas@wunner.de>
In-Reply-To: <cover.1536341821.git.lukas@wunner.de>
References: <cover.1536341821.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 8 Sep 2018 09:59:01 +0200
Subject: [PATCH v2 4/8] PCI: pciehp: Reshuffle controller struct for clarity
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Sinan Kaya <okaya@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Keith Busch <keith.busch@intel.com>
List-ID: <linux-pci.vger.kernel.org>

The members in pciehp's controller struct are arranged in a seemingly
arbitrary order and have grown to an amount that I no longer consider
easily graspable by contributors.

Sort the members into 5 rubrics:
* Slot Capabilities register and quirks
* Slot Control register access
* Slot Status register event handling
* state machine
* hotplug core interface

Obviously, this is just my personal bikeshed color and if anyone has a
better idea, please come forward.  Any ordering will do as long as the
information is presented in a manageable manner.

No functional change intended.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp.h | 57 ++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 39b97e2384c3..3cc88f3e4368 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -60,38 +60,38 @@ do {									\
 
 /**
  * struct controller - PCIe hotplug controller
- * @ctrl_lock: serializes writes to the Slot Control register
  * @pcie: pointer to the controller's PCIe port service device
- * @reset_lock: prevents access to the Data Link Layer Link Active bit in the
- *	Link Status register and to the Presence Detect State bit in the Slot
- *	Status register during a slot reset which may cause them to flap
- * @queue: wait queue to wake up on reception of a Command Completed event,
- *	used for synchronous writes to the Slot Control register
  * @slot_cap: cached copy of the Slot Capabilities register
+ * @link_active_reporting: cached copy of Data Link Layer Link Active Reporting
+ *	Capable bit in Link Capabilities register; if this bit is zero, the
+ *	Data Link Layer Link Active bit in the Link Status register will never
+ *	be set and the driver is thus confined to wait 1 second before assuming
+ *	the link to a hotplugged device is up and accessing it
  * @slot_ctrl: cached copy of the Slot Control register
- * @poll_thread: thread to poll for slot events if no IRQ is available,
- *	enabled with pciehp_poll_mode module parameter
+ * @ctrl_lock: serializes writes to the Slot Control register
  * @cmd_started: jiffies when the Slot Control register was last written;
  *	the next write is allowed 1 second later, absent a Command Completed
  *	interrupt (PCIe r4.0, sec 6.7.3.2)
  * @cmd_busy: flag set on Slot Control register write, cleared by IRQ handler
  *	on reception of a Command Completed event
- * @link_active_reporting: cached copy of Data Link Layer Link Active Reporting
- *	Capable bit in Link Capabilities register; if this bit is zero, the
- *	Data Link Layer Link Active bit in the Link Status register will never
- *	be set and the driver is thus confined to wait 1 second before assuming
- *	the link to a hotplugged device is up and accessing it
+ * @queue: wait queue to wake up on reception of a Command Completed event,
+ *	used for synchronous writes to the Slot Control register
+ * @pending_events: used by the IRQ handler to save events retrieved from the
+ *	Slot Status register for later consumption by the IRQ thread
  * @notification_enabled: whether the IRQ was requested successfully
  * @power_fault_detected: whether a power fault was detected by the hardware
  *	that has not yet been cleared by the user
- * @pending_events: used by the IRQ handler to save events retrieved from the
- *	Slot Status register for later consumption by the IRQ thread
+ * @poll_thread: thread to poll for slot events if no IRQ is available,
+ *	enabled with pciehp_poll_mode module parameter
  * @state: current state machine position
  * @state_lock: protects reads and writes of @state;
  *	protects scheduling, execution and cancellation of @button_work
  * @button_work: work item to turn the slot on or off after 5 seconds
  *	in response to an Attention Button press
  * @hotplug_slot: pointer to the structure registered with the PCI hotplug core
+ * @reset_lock: prevents access to the Data Link Layer Link Active bit in the
+ *	Link Status register and to the Presence Detect State bit in the Slot
+ *	Status register during a slot reset which may cause them to flap
  * @request_result: result of last user request submitted to the IRQ thread
  * @requester: wait queue to wake up on completion of user request,
  *	used for synchronous slot enable/disable request via sysfs
@@ -100,23 +100,28 @@ do {									\
  * unlike other drivers, the two aren't represented by separate structures.
  */
 struct controller {
-	struct mutex ctrl_lock;
 	struct pcie_device *pcie;
-	struct rw_semaphore reset_lock;
-	wait_queue_head_t queue;
-	u32 slot_cap;
-	u16 slot_ctrl;
-	struct task_struct *poll_thread;
-	unsigned long cmd_started;	/* jiffies */
-	unsigned int cmd_busy:1;
+
+	u32 slot_cap;				/* capabilities and quirks */
 	unsigned int link_active_reporting:1;
+
+	u16 slot_ctrl;				/* control register access */
+	struct mutex ctrl_lock;
+	unsigned long cmd_started;
+	unsigned int cmd_busy:1;
+	wait_queue_head_t queue;
+
+	atomic_t pending_events;		/* event handling */
 	unsigned int notification_enabled:1;
 	unsigned int power_fault_detected;
-	atomic_t pending_events;
-	u8 state;
+	struct task_struct *poll_thread;
+
+	u8 state;				/* state machine */
 	struct mutex state_lock;
 	struct delayed_work button_work;
-	struct hotplug_slot *hotplug_slot;
+
+	struct hotplug_slot *hotplug_slot;	/* hotplug core interface */
+	struct rw_semaphore reset_lock;
 	int request_result;
 	wait_queue_head_t requester;
 };
-- 
2.18.0
