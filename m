Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:47338 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908Ab3LPBPt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 15 Dec 2013 20:15:49 -0500
Received: by mail-ie0-f172.google.com with SMTP id qd12so5751782ieb.3
        for <linux-pci@vger.kernel.org>; Sun, 15 Dec 2013 17:15:49 -0800 (PST)
Received: from localhost (173-8-252-97-Colorado.hfc.comcastbusiness.net. [173.8.252.97])
        by mx.google.com with ESMTPSA id o1sm13362309igh.9.2013.12.15.17.15.48
        for <linux-pci@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 15 Dec 2013 17:15:48 -0800 (PST)
Subject: [PATCH 8/8] PCI: pciehp: Move Attention & Power Indicator support
 tests to accessors
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sun, 15 Dec 2013 18:15:47 -0700
Message-ID: <20131216011547.7275.98312.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20131216010946.7275.83547.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20131216010946.7275.83547.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Previously, the caller checked ATTN_LED() or PWR_LED() to see whether the
slot has indicators before setting the indicator state.  That clutters the
caller unnecessarily, so this moves the test inside the callees.  The test
may not even be necessary; per spec it should be harmless to try to turn on
a non-existent LED.  But checking first does avoid unnecessary hotplug
commands.

No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp_ctrl.c |   42 +++++++++++--------------------------
 drivers/pci/hotplug/pciehp_hpc.c  |   12 +++++++++++
 2 files changed, 25 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 6c730b161b33..50628487597d 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -168,11 +168,8 @@ static void set_slot_off(struct controller *ctrl, struct slot * pslot)
 		msleep(1000);
 	}
 
-	if (PWR_LED(ctrl))
-		pciehp_green_led_off(pslot);
-
-	if (ATTN_LED(ctrl))
-		pciehp_set_attention_status(pslot, 1);
+	pciehp_green_led_off(pslot);
+	pciehp_set_attention_status(pslot, 1);
 }
 
 /**
@@ -195,8 +192,7 @@ static int board_added(struct slot *p_slot)
 			return retval;
 	}
 
-	if (PWR_LED(ctrl))
-		pciehp_green_led_blink(p_slot);
+	pciehp_green_led_blink(p_slot);
 
 	/* Check link training status */
 	retval = pciehp_check_link_status(ctrl);
@@ -219,9 +215,7 @@ static int board_added(struct slot *p_slot)
 		goto err_exit;
 	}
 
-	if (PWR_LED(ctrl))
-		pciehp_green_led_on(p_slot);
-
+	pciehp_green_led_on(p_slot);
 	return 0;
 
 err_exit:
@@ -254,9 +248,7 @@ static int remove_board(struct slot *p_slot)
 	}
 
 	/* turn off Green LED */
-	if (PWR_LED(ctrl))
-		pciehp_green_led_off(p_slot);
-
+	pciehp_green_led_off(p_slot);
 	return 0;
 }
 
@@ -292,7 +284,7 @@ static void pciehp_power_thread(struct work_struct *work)
 		break;
 	case POWERON_STATE:
 		mutex_unlock(&p_slot->lock);
-		if (pciehp_enable_slot(p_slot) && PWR_LED(p_slot->ctrl))
+		if (pciehp_enable_slot(p_slot))
 			pciehp_green_led_off(p_slot);
 		mutex_lock(&p_slot->lock);
 		p_slot->state = STATIC_STATE;
@@ -359,11 +351,8 @@ static void handle_button_press_event(struct slot *p_slot)
 				  "press.\n", slot_name(p_slot));
 		}
 		/* blink green LED and turn off amber */
-		if (PWR_LED(ctrl))
-			pciehp_green_led_blink(p_slot);
-		if (ATTN_LED(ctrl))
-			pciehp_set_attention_status(p_slot, 0);
-
+		pciehp_green_led_blink(p_slot);
+		pciehp_set_attention_status(p_slot, 0);
 		queue_delayed_work(p_slot->wq, &p_slot->work, 5*HZ);
 		break;
 	case BLINKINGOFF_STATE:
@@ -376,14 +365,11 @@ static void handle_button_press_event(struct slot *p_slot)
 		ctrl_info(ctrl, "Button cancel on Slot(%s)\n", slot_name(p_slot));
 		cancel_delayed_work(&p_slot->work);
 		if (p_slot->state == BLINKINGOFF_STATE) {
-			if (PWR_LED(ctrl))
-				pciehp_green_led_on(p_slot);
+			pciehp_green_led_on(p_slot);
 		} else {
-			if (PWR_LED(ctrl))
-				pciehp_green_led_off(p_slot);
+			pciehp_green_led_off(p_slot);
 		}
-		if (ATTN_LED(ctrl))
-			pciehp_set_attention_status(p_slot, 0);
+		pciehp_set_attention_status(p_slot, 0);
 		ctrl_info(ctrl, "PCI slot #%s - action canceled "
 			  "due to button press\n", slot_name(p_slot));
 		p_slot->state = STATIC_STATE;
@@ -443,10 +429,8 @@ static void interrupt_event_handler(struct work_struct *work)
 	case INT_POWER_FAULT:
 		if (!POWER_CTRL(ctrl))
 			break;
-		if (ATTN_LED(ctrl))
-			pciehp_set_attention_status(p_slot, 1);
-		if (PWR_LED(ctrl))
-			pciehp_green_led_off(p_slot);
+		pciehp_set_attention_status(p_slot, 1);
+		pciehp_green_led_off(p_slot);
 		break;
 	case INT_PRESENCE_ON:
 	case INT_PRESENCE_OFF:
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 05d421cf935e..14acfccb7670 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -418,6 +418,9 @@ void pciehp_set_attention_status(struct slot *slot, u8 value)
 	struct controller *ctrl = slot->ctrl;
 	u16 slot_cmd;
 
+	if (!ATTN_LED(ctrl))
+		return;
+
 	switch (value) {
 	case 0 :	/* turn off */
 		slot_cmd = PCI_EXP_SLTCTL_ATTN_IND_OFF;
@@ -440,6 +443,9 @@ void pciehp_green_led_on(struct slot *slot)
 {
 	struct controller *ctrl = slot->ctrl;
 
+	if (!PWR_LED(ctrl))
+		return;
+
 	pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_PWR_IND_ON, PCI_EXP_SLTCTL_PIC);
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
@@ -450,6 +456,9 @@ void pciehp_green_led_off(struct slot *slot)
 {
 	struct controller *ctrl = slot->ctrl;
 
+	if (!PWR_LED(ctrl))
+		return;
+
 	pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF, PCI_EXP_SLTCTL_PIC);
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
@@ -460,6 +469,9 @@ void pciehp_green_led_blink(struct slot *slot)
 {
 	struct controller *ctrl = slot->ctrl;
 
+	if (!PWR_LED(ctrl))
+		return;
+
 	pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_PWR_IND_BLINK, PCI_EXP_SLTCTL_PIC);
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,

