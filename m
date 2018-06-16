Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:46473 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932554AbeFPTcP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jun 2018 15:32:15 -0400
Message-Id: <b35dea070133ed17e1026235c34b9c7d98423720.1529173804.git.lukas@wunner.de>
In-Reply-To: <cover.1529173804.git.lukas@wunner.de>
References: <cover.1529173804.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 16 Jun 2018 21:25:00 +0200
Subject: [PATCH 21/32] PCI: pciehp: Become resilient to missed events
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org, Stefan Roese <sr@denx.de>,
        Mayurkumar Patel <mayurkumar.patel@intel.com>,
        Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A hotplug port's Slot Status register does not count how often each type
of event occurred, it only records the fact *that* an event has occurred.

Previously pciehp queued a work item for each event.  But if it missed
an event, e.g. removal of a card in-between two back-to-back insertions,
it queued up the wrong work item or no work item at all.  Commit
fad214b0aa72 ("PCI: pciehp: Process all hotplug events before looking
for new ones") sought to improve the situation by shrinking the window
during which events may be missed.

But Stefan Roese reports unbalanced Card present and Link Up events,
suggesting that we're still missing events if they occur very rapidly.
Bjorn Helgaas responds that he considers pciehp's event handling
"baroque" and calls for its simplification and rationalization:
https://patchwork.ozlabs.org/patch/867418/

It gets worse once a hotplug port is runtime suspended:  The port can
signal an interrupt while it and its parents are in D3hot, i.e. while
it is inaccessible.  By the time we've runtime resumed all parents to D0
and read the port's Slot Status register, we may have missed an arbitrary
number of events.  Event handling therefore needs to be reworked to
become resilient to missed events.

Assume that a Presence Detect Changed event has occurred.
Consider the following truth table:
- Slot is in OFF_STATE and is currently empty.    => Do nothing.
  (The event is trailing a Link Down or we've
  missed an insertion and subsequent removal.)
- Slot is in OFF_STATE and is currently occupied. => Turn the slot on.
- Slot is in ON_STATE  and is currently empty.    => Turn the slot off.
- Slot is in ON_STATE  and is currently occupied. => Turn the slot off,
  (Be cautious and assume the card in                then back on.
  the slot isn't the same as before.)

This leads to the following simple algorithm:
1 If the slot is in ON_STATE, turn it off unconditionally.
2 If the slot is currently occupied, turn it on.

Because those actions are now carried out synchronously, rather than by
scheduled work items, pciehp reacts to the *current* situation and
missed events no longer matter.

Data Link Layer State Changed events can be handled identically to
Presence Detect Changed events.  Note that in the above truth table,
a Link Up trailing a Card present event didn't have to be accounted for:
It is filtered out by pciehp_check_link_status().

As for Attention Button Pressed events, PCIe r4.0, sec 6.7.1.5 says:
"Once the Power Indicator begins blinking, a 5-second abort interval
exists during which a second depression of the Attention Button cancels
the operation."  In other words, the user can only expect the system to
react to a button press after it starts blinking.  Missed button presses
that occur in-between are irrelevant.

Cc: Stefan Roese <sr@denx.de>
Cc: Mayurkumar Patel <mayurkumar.patel@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp.h      |  3 +-
 drivers/pci/hotplug/pciehp_ctrl.c | 80 ++++++++++++++-----------------
 drivers/pci/hotplug/pciehp_hpc.c  | 10 +---
 3 files changed, 40 insertions(+), 53 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 9c75acd291fb..47cd9af5caf3 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -169,8 +169,7 @@ int pciehp_sysfs_disable_slot(struct slot *slot);
 void pciehp_request(struct controller *ctrl, int action);
 void pciehp_handle_button_press(struct slot *slot);
 void pciehp_handle_disable_request(struct slot *slot);
-void pciehp_handle_link_change(struct slot *slot);
-void pciehp_handle_presence_change(struct slot *slot);
+void pciehp_handle_presence_or_link_change(struct slot *slot, u32 events);
 int pciehp_configure_device(struct slot *p_slot);
 void pciehp_unconfigure_device(struct slot *p_slot);
 void pciehp_queue_pushbutton_work(struct work_struct *work);
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 4a12e70aacd0..811019902ada 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -217,66 +217,60 @@ void pciehp_handle_disable_request(struct slot *slot)
 	ctrl->request_result = pciehp_disable_slot(slot);
 }
 
-void pciehp_handle_link_change(struct slot *p_slot)
+void pciehp_handle_presence_or_link_change(struct slot *slot, u32 events)
 {
-	struct controller *ctrl = p_slot->ctrl;
+	struct controller *ctrl = slot->ctrl;
 	bool link_active;
+	u8 present;
 
-	mutex_lock(&p_slot->lock);
-	link_active = pciehp_check_link_active(ctrl);
-
-	switch (p_slot->state) {
-	case BLINKINGON_STATE:
+	/*
+	 * If the slot is on and presence or link has changed, turn it off.
+	 * Even if it's occupied again, we cannot assume the card is the same.
+	 */
+	mutex_lock(&slot->lock);
+	switch (slot->state) {
 	case BLINKINGOFF_STATE:
-		cancel_delayed_work(&p_slot->work);
-		/* Fall through */
+		cancel_delayed_work(&slot->work);
 	case ON_STATE:
-	case OFF_STATE:
-		if (link_active) {
-			p_slot->state = POWERON_STATE;
-			mutex_unlock(&p_slot->lock);
-			ctrl_info(ctrl, "Slot(%s): Link Up\n", slot_name(p_slot));
-			pciehp_enable_slot(p_slot);
-		} else {
-			p_slot->state = POWEROFF_STATE;
-			mutex_unlock(&p_slot->lock);
-			ctrl_info(ctrl, "Slot(%s): Link Down\n", slot_name(p_slot));
-			pciehp_disable_slot(p_slot);
-		}
-		return;
+		slot->state = POWEROFF_STATE;
+		mutex_unlock(&slot->lock);
+		if (events & PCI_EXP_SLTSTA_DLLSC)
+			ctrl_info(ctrl, "Slot(%s): Link Down\n",
+				  slot_name(slot));
+		if (events & PCI_EXP_SLTSTA_PDC)
+			ctrl_info(ctrl, "Slot(%s): Card not present\n",
+				  slot_name(slot));
+		pciehp_disable_slot(slot);
 		break;
 	default:
-		ctrl_err(ctrl, "Slot(%s): Ignoring invalid state %#x\n",
-			 slot_name(p_slot), p_slot->state);
-		break;
+		mutex_unlock(&slot->lock);
 	}
-	mutex_unlock(&p_slot->lock);
-}
-
-void pciehp_handle_presence_change(struct slot *slot)
-{
-	struct controller *ctrl = slot->ctrl;
-	u8 present;
 
+	/* Turn the slot on if it's occupied or link is up */
 	mutex_lock(&slot->lock);
+	pciehp_get_adapter_status(slot, &present);
+	link_active = pciehp_check_link_active(ctrl);
+	if (!present && !link_active) {
+		mutex_unlock(&slot->lock);
+		return;
+	}
+
 	switch (slot->state) {
 	case BLINKINGON_STATE:
-	case BLINKINGOFF_STATE:
 		cancel_delayed_work(&slot->work);
-	}
-
-	pciehp_get_adapter_status(slot, &present);
-	ctrl_info(ctrl, "Slot(%s): Card %spresent\n", slot_name(slot),
-		  present ? "" : "not ");
-
-	if (present) {
+	case OFF_STATE:
 		slot->state = POWERON_STATE;
 		mutex_unlock(&slot->lock);
+		if (present)
+			ctrl_info(ctrl, "Slot(%s): Card present\n",
+				  slot_name(slot));
+		if (link_active)
+			ctrl_info(ctrl, "Slot(%s): Link Up\n",
+				  slot_name(slot));
 		ctrl->request_result = pciehp_enable_slot(slot);
-	} else {
-		slot->state = POWEROFF_STATE;
+		break;
+	default:
 		mutex_unlock(&slot->lock);
-		pciehp_disable_slot(slot);
 	}
 }
 
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index adc6a89a3b5d..b746c3b52719 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -602,17 +602,11 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 	/*
 	 * Disable requests have higher priority than Presence Detect Changed
 	 * or Data Link Layer State Changed events.
-	 *
-	 * Check Link Status Changed at higher precedence than Presence
-	 * Detect Changed.  The PDS value may be set to "card present" from
-	 * out-of-band detection, which may be in conflict with a Link Down.
 	 */
 	if (events & DISABLE_SLOT)
 		pciehp_handle_disable_request(slot);
-	else if (events & PCI_EXP_SLTSTA_DLLSC)
-		pciehp_handle_link_change(slot);
-	else if (events & PCI_EXP_SLTSTA_PDC)
-		pciehp_handle_presence_change(slot);
+	else if (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC))
+		pciehp_handle_presence_or_link_change(slot, events);
 
 	/* Check Power Fault Detected */
 	if ((events & PCI_EXP_SLTSTA_PFD) && !ctrl->power_fault_detected) {
-- 
2.17.1
