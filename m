Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757876AbcILVJt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Sep 2016 17:09:49 -0400
Subject: [PATCH v2 7/8] PCI: pciehp: Clean up dmesg "Slot(%s)" messages
To: Mayurkumar Patel <mayurkumar.patel@intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rajat Jain <rajatja@google.com>, MikaWesterberg@linux.intel.com,
        linux-pci@vger.kernel.org,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Luis Antonio Tarazona-Duarte
        <luis.antonio.tarazona-duarte@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        mika.westerberg@linux.intel.com
Date: Mon, 12 Sep 2016 16:09:43 -0500
Message-ID: <20160912210943.22258.4748.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160912210507.22258.63097.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160912210507.22258.63097.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Print slot name consistently as "Slot(%s)".  I don't know whether that's
ideal, but we can at least do it the same way all the time.  No functional
change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp_ctrl.c |   56 ++++++++++++++++++-------------------
 drivers/pci/hotplug/pciehp_hpc.c  |   12 ++++----
 2 files changed, 33 insertions(+), 35 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index a787684..bf50f26 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -106,7 +106,7 @@ static int board_added(struct slot *p_slot)
 
 	/* Check for a power fault */
 	if (ctrl->power_fault_detected || pciehp_query_power_fault(p_slot)) {
-		ctrl_err(ctrl, "Power fault on slot %s\n", slot_name(p_slot));
+		ctrl_err(ctrl, "Slot(%s): Power fault\n", slot_name(p_slot));
 		retval = -EIO;
 		goto err_exit;
 	}
@@ -254,11 +254,11 @@ static void handle_button_press_event(struct slot *p_slot)
 		pciehp_get_power_status(p_slot, &getstatus);
 		if (getstatus) {
 			p_slot->state = BLINKINGOFF_STATE;
-			ctrl_info(ctrl, "PCI slot #%s - powering off due to button press\n",
+			ctrl_info(ctrl, "Slot(%s): Powering off due to button press\n",
 				  slot_name(p_slot));
 		} else {
 			p_slot->state = BLINKINGON_STATE;
-			ctrl_info(ctrl, "PCI slot #%s - powering on due to button press\n",
+			ctrl_info(ctrl, "Slot(%s) Powering on due to button press\n",
 				  slot_name(p_slot));
 		}
 		/* blink green LED and turn off amber */
@@ -273,14 +273,14 @@ static void handle_button_press_event(struct slot *p_slot)
 		 * press the attention again before the 5 sec. limit
 		 * expires to cancel hot-add or hot-remove
 		 */
-		ctrl_info(ctrl, "Button cancel on Slot(%s)\n", slot_name(p_slot));
+		ctrl_info(ctrl, "Slot(%s): Button cancel\n", slot_name(p_slot));
 		cancel_delayed_work(&p_slot->work);
 		if (p_slot->state == BLINKINGOFF_STATE)
 			pciehp_green_led_on(p_slot);
 		else
 			pciehp_green_led_off(p_slot);
 		pciehp_set_attention_status(p_slot, 0);
-		ctrl_info(ctrl, "PCI slot #%s - action canceled due to button press\n",
+		ctrl_info(ctrl, "Slot(%s): Action canceled due to button press\n",
 			  slot_name(p_slot));
 		p_slot->state = STATIC_STATE;
 		break;
@@ -291,10 +291,12 @@ static void handle_button_press_event(struct slot *p_slot)
 		 * this means that the previous attention button action
 		 * to hot-add or hot-remove is undergoing
 		 */
-		ctrl_info(ctrl, "Button ignore on Slot(%s)\n", slot_name(p_slot));
+		ctrl_info(ctrl, "Slot(%s): Button ignored\n",
+			  slot_name(p_slot));
 		break;
 	default:
-		ctrl_warn(ctrl, "ignoring invalid state %#x\n", p_slot->state);
+		ctrl_err(ctrl, "Slot(%s): Ignoring invalid state %#x\n",
+			 slot_name(p_slot), p_slot->state);
 		break;
 	}
 }
@@ -317,31 +319,27 @@ static void handle_link_event(struct slot *p_slot, u32 event)
 		break;
 	case POWERON_STATE:
 		if (event == INT_LINK_UP) {
-			ctrl_info(ctrl,
-				  "Link Up event ignored on slot(%s): already powering on\n",
+			ctrl_info(ctrl, "Slot(%s): Link Up event ignored; already powering on\n",
 				  slot_name(p_slot));
 		} else {
-			ctrl_info(ctrl,
-				  "Link Down event queued on slot(%s): currently getting powered on\n",
+			ctrl_info(ctrl, "Slot(%s): Link Down event queued; currently getting powered on\n",
 				  slot_name(p_slot));
 			pciehp_queue_power_work(p_slot, DISABLE_REQ);
 		}
 		break;
 	case POWEROFF_STATE:
 		if (event == INT_LINK_UP) {
-			ctrl_info(ctrl,
-				  "Link Up event queued on slot(%s): currently getting powered off\n",
+			ctrl_info(ctrl, "Slot(%s): Link Up event queued; currently getting powered off\n",
 				  slot_name(p_slot));
 			pciehp_queue_power_work(p_slot, ENABLE_REQ);
 		} else {
-			ctrl_info(ctrl,
-				  "Link Down event ignored on slot(%s): already powering off\n",
+			ctrl_info(ctrl, "Slot(%s): Link Down event ignored; already powering off\n",
 				  slot_name(p_slot));
 		}
 		break;
 	default:
-		ctrl_err(ctrl, "ignoring invalid state %#x on slot(%s)\n",
-			 p_slot->state, slot_name(p_slot));
+		ctrl_err(ctrl, "Slot(%s): Ignoring invalid state %#x\n",
+			 slot_name(p_slot), p_slot->state);
 		break;
 	}
 }
@@ -396,13 +394,13 @@ int pciehp_enable_slot(struct slot *p_slot)
 
 	pciehp_get_adapter_status(p_slot, &getstatus);
 	if (!getstatus) {
-		ctrl_info(ctrl, "No adapter on slot(%s)\n", slot_name(p_slot));
+		ctrl_info(ctrl, "Slot(%s): No adapter\n", slot_name(p_slot));
 		return -ENODEV;
 	}
 	if (MRL_SENS(p_slot->ctrl)) {
 		pciehp_get_latch_status(p_slot, &getstatus);
 		if (getstatus) {
-			ctrl_info(ctrl, "Latch open on slot(%s)\n",
+			ctrl_info(ctrl, "Slot(%s): Latch open\n",
 				  slot_name(p_slot));
 			return -ENODEV;
 		}
@@ -411,7 +409,7 @@ int pciehp_enable_slot(struct slot *p_slot)
 	if (POWER_CTRL(p_slot->ctrl)) {
 		pciehp_get_power_status(p_slot, &getstatus);
 		if (getstatus) {
-			ctrl_info(ctrl, "Already enabled on slot(%s)\n",
+			ctrl_info(ctrl, "Slot(%s): Already enabled\n",
 				  slot_name(p_slot));
 			return -EINVAL;
 		}
@@ -440,7 +438,7 @@ int pciehp_disable_slot(struct slot *p_slot)
 	if (POWER_CTRL(p_slot->ctrl)) {
 		pciehp_get_power_status(p_slot, &getstatus);
 		if (!getstatus) {
-			ctrl_info(ctrl, "Already disabled on slot(%s)\n",
+			ctrl_info(ctrl, "Slot(%s): Already disabled\n",
 				  slot_name(p_slot));
 			return -EINVAL;
 		}
@@ -468,17 +466,17 @@ int pciehp_sysfs_enable_slot(struct slot *p_slot)
 		p_slot->state = STATIC_STATE;
 		break;
 	case POWERON_STATE:
-		ctrl_info(ctrl, "Slot %s is already in powering on state\n",
+		ctrl_info(ctrl, "Slot(%s): Already in powering on state\n",
 			  slot_name(p_slot));
 		break;
 	case BLINKINGOFF_STATE:
 	case POWEROFF_STATE:
-		ctrl_info(ctrl, "Already enabled on slot %s\n",
+		ctrl_info(ctrl, "Slot(%s): Already enabled\n",
 			  slot_name(p_slot));
 		break;
 	default:
-		ctrl_err(ctrl, "invalid state %#x on slot %s\n",
-			 p_slot->state, slot_name(p_slot));
+		ctrl_err(ctrl, "Slot(%s): Invalid state %#x\n",
+			 slot_name(p_slot), p_slot->state);
 		break;
 	}
 	mutex_unlock(&p_slot->lock);
@@ -505,17 +503,17 @@ int pciehp_sysfs_disable_slot(struct slot *p_slot)
 		p_slot->state = STATIC_STATE;
 		break;
 	case POWEROFF_STATE:
-		ctrl_info(ctrl, "Slot %s is already in powering off state\n",
+		ctrl_info(ctrl, "Slot(%s): Already in powering off state\n",
 			  slot_name(p_slot));
 		break;
 	case BLINKINGON_STATE:
 	case POWERON_STATE:
-		ctrl_info(ctrl, "Already disabled on slot %s\n",
+		ctrl_info(ctrl, "Slot(%s): Already disabled\n",
 			  slot_name(p_slot));
 		break;
 	default:
-		ctrl_err(ctrl, "invalid state %#x on slot %s\n",
-			 p_slot->state, slot_name(p_slot));
+		ctrl_err(ctrl, "Slot(%s): Invalid state %#x\n",
+			 slot_name(p_slot), p_slot->state);
 		break;
 	}
 	mutex_unlock(&p_slot->lock);
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 60e1d55..4582fdf 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -592,7 +592,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 
 	/* Check Attention Button Pressed */
 	if (events & PCI_EXP_SLTSTA_ABP) {
-		ctrl_info(ctrl, "Button pressed on Slot(%s)\n",
+		ctrl_info(ctrl, "Slot(%s): Attention button pressed\n",
 			  slot_name(slot));
 		pciehp_queue_interrupt_event(slot, INT_BUTTON_PRESS);
 	}
@@ -600,8 +600,8 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 	/* Check Presence Detect Changed */
 	if (events & PCI_EXP_SLTSTA_PDC) {
 		present = !!(status & PCI_EXP_SLTSTA_PDS);
-		ctrl_info(ctrl, "Card %spresent on Slot(%s)\n",
-			  present ? "" : "not ", slot_name(slot));
+		ctrl_info(ctrl, "Slot(%s): Card %spresent\n", slot_name(slot),
+			  present ? "" : "not ");
 		pciehp_queue_interrupt_event(slot, present ? INT_PRESENCE_ON :
 					     INT_PRESENCE_OFF);
 	}
@@ -609,13 +609,13 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 	/* Check Power Fault Detected */
 	if ((events & PCI_EXP_SLTSTA_PFD) && !ctrl->power_fault_detected) {
 		ctrl->power_fault_detected = 1;
-		ctrl_err(ctrl, "Power fault on slot %s\n", slot_name(slot));
+		ctrl_err(ctrl, "Slot(%s): Power fault\n", slot_name(slot));
 		pciehp_queue_interrupt_event(slot, INT_POWER_FAULT);
 	}
 
 	if (events & PCI_EXP_SLTSTA_DLLSC) {
-		ctrl_info(ctrl, "slot(%s): Link %s event\n",
-			  slot_name(slot), link ? "Up" : "Down");
+		ctrl_info(ctrl, "Slot(%s): Link %s\n", slot_name(slot),
+			  link ? "Up" : "Down");
 		pciehp_queue_interrupt_event(slot, link ? INT_LINK_UP :
 					     INT_LINK_DOWN);
 	}

