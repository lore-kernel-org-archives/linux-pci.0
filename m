Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:35022 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908Ab3LPBPS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 15 Dec 2013 20:15:18 -0500
Received: by mail-ie0-f177.google.com with SMTP id tp5so5419107ieb.8
        for <linux-pci@vger.kernel.org>; Sun, 15 Dec 2013 17:15:18 -0800 (PST)
Received: from localhost (173-8-252-97-Colorado.hfc.comcastbusiness.net. [173.8.252.97])
        by mx.google.com with ESMTPSA id t4sm13354052igm.10.2013.12.15.17.15.16
        for <linux-pci@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 15 Dec 2013 17:15:16 -0800 (PST)
Subject: [PATCH 3/8] PCI: pciehp: Make various functions void since they
 can't fail
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sun, 15 Dec 2013 18:15:15 -0700
Message-ID: <20131216011515.7275.44175.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20131216010946.7275.83547.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20131216010946.7275.83547.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These functions:

  pcie_enable_notification()
  pciehp_power_off_slot()
  pciehp_get_power_status()
  pciehp_get_attention_status()
  pciehp_set_attention_status()
  pciehp_get_latch_status()
  pciehp_get_adapter_status()
  pcie_write_cmd()

now always return success, so this patch makes them void and drops the
error-checking code in their callers.

No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp.h      |   14 +++++----
 drivers/pci/hotplug/pciehp_core.c |   15 +++++++---
 drivers/pci/hotplug/pciehp_ctrl.c |   52 +++++++++++++---------------------
 drivers/pci/hotplug/pciehp_hpc.c  |   56 +++++++++++--------------------------
 drivers/pci/hotplug/pciehp_pci.c  |    6 +---
 5 files changed, 54 insertions(+), 89 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 21e865ded1dc..ffe6a6b336cf 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -140,15 +140,15 @@ struct controller *pcie_init(struct pcie_device *dev);
 int pcie_init_notification(struct controller *ctrl);
 int pciehp_enable_slot(struct slot *p_slot);
 int pciehp_disable_slot(struct slot *p_slot);
-int pcie_enable_notification(struct controller *ctrl);
+void pcie_enable_notification(struct controller *ctrl);
 int pciehp_power_on_slot(struct slot *slot);
-int pciehp_power_off_slot(struct slot *slot);
-int pciehp_get_power_status(struct slot *slot, u8 *status);
-int pciehp_get_attention_status(struct slot *slot, u8 *status);
+void pciehp_power_off_slot(struct slot *slot);
+void pciehp_get_power_status(struct slot *slot, u8 *status);
+void pciehp_get_attention_status(struct slot *slot, u8 *status);
 
-int pciehp_set_attention_status(struct slot *slot, u8 status);
-int pciehp_get_latch_status(struct slot *slot, u8 *status);
-int pciehp_get_adapter_status(struct slot *slot, u8 *status);
+void pciehp_set_attention_status(struct slot *slot, u8 status);
+void pciehp_get_latch_status(struct slot *slot, u8 *status);
+void pciehp_get_adapter_status(struct slot *slot, u8 *status);
 int pciehp_query_power_fault(struct slot *slot);
 void pciehp_green_led_on(struct slot *slot);
 void pciehp_green_led_off(struct slot *slot);
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index bbd48bbe4e9b..143a389d81fa 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -160,7 +160,8 @@ static int set_attention_status(struct hotplug_slot *hotplug_slot, u8 status)
 	ctrl_dbg(slot->ctrl, "%s: physical_slot = %s\n",
 		  __func__, slot_name(slot));
 
-	return pciehp_set_attention_status(slot, status);
+	pciehp_set_attention_status(slot, status);
+	return 0;
 }
 
 
@@ -192,7 +193,8 @@ static int get_power_status(struct hotplug_slot *hotplug_slot, u8 *value)
 	ctrl_dbg(slot->ctrl, "%s: physical_slot = %s\n",
 		  __func__, slot_name(slot));
 
-	return pciehp_get_power_status(slot, value);
+	pciehp_get_power_status(slot, value);
+	return 0;
 }
 
 static int get_attention_status(struct hotplug_slot *hotplug_slot, u8 *value)
@@ -202,7 +204,8 @@ static int get_attention_status(struct hotplug_slot *hotplug_slot, u8 *value)
 	ctrl_dbg(slot->ctrl, "%s: physical_slot = %s\n",
 		  __func__, slot_name(slot));
 
-	return pciehp_get_attention_status(slot, value);
+	pciehp_get_attention_status(slot, value);
+	return 0;
 }
 
 static int get_latch_status(struct hotplug_slot *hotplug_slot, u8 *value)
@@ -212,7 +215,8 @@ static int get_latch_status(struct hotplug_slot *hotplug_slot, u8 *value)
 	ctrl_dbg(slot->ctrl, "%s: physical_slot = %s\n",
 		 __func__, slot_name(slot));
 
-	return pciehp_get_latch_status(slot, value);
+	pciehp_get_latch_status(slot, value);
+	return 0;
 }
 
 static int get_adapter_status(struct hotplug_slot *hotplug_slot, u8 *value)
@@ -222,7 +226,8 @@ static int get_adapter_status(struct hotplug_slot *hotplug_slot, u8 *value)
 	ctrl_dbg(slot->ctrl, "%s: physical_slot = %s\n",
 		 __func__, slot_name(slot));
 
-	return pciehp_get_adapter_status(slot, value);
+	pciehp_get_adapter_status(slot, value);
+	return 0;
 }
 
 static int reset_slot(struct hotplug_slot *hotplug_slot, int probe)
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 38f018679175..6c730b161b33 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -158,11 +158,8 @@ static void set_slot_off(struct controller *ctrl, struct slot * pslot)
 {
 	/* turn off slot, turn on Amber LED, turn off Green LED if supported*/
 	if (POWER_CTRL(ctrl)) {
-		if (pciehp_power_off_slot(pslot)) {
-			ctrl_err(ctrl,
-				 "Issue of Slot Power Off command failed\n");
-			return;
-		}
+		pciehp_power_off_slot(pslot);
+
 		/*
 		 * After turning power off, we must wait for at least 1 second
 		 * before taking any action that relies on power having been
@@ -174,13 +171,8 @@ static void set_slot_off(struct controller *ctrl, struct slot * pslot)
 	if (PWR_LED(ctrl))
 		pciehp_green_led_off(pslot);
 
-	if (ATTN_LED(ctrl)) {
-		if (pciehp_set_attention_status(pslot, 1)) {
-			ctrl_err(ctrl,
-				 "Issue of Set Attention Led command failed\n");
-			return;
-		}
-	}
+	if (ATTN_LED(ctrl))
+		pciehp_set_attention_status(pslot, 1);
 }
 
 /**
@@ -243,7 +235,7 @@ err_exit:
  */
 static int remove_board(struct slot *p_slot)
 {
-	int retval = 0;
+	int retval;
 	struct controller *ctrl = p_slot->ctrl;
 
 	retval = pciehp_unconfigure_device(p_slot);
@@ -251,13 +243,8 @@ static int remove_board(struct slot *p_slot)
 		return retval;
 
 	if (POWER_CTRL(ctrl)) {
-		/* power off slot */
-		retval = pciehp_power_off_slot(p_slot);
-		if (retval) {
-			ctrl_err(ctrl,
-				 "Issue of Slot Disable command failed\n");
-			return retval;
-		}
+		pciehp_power_off_slot(p_slot);
+
 		/*
 		 * After turning power off, we must wait for at least 1 second
 		 * before taking any action that relies on power having been
@@ -482,14 +469,14 @@ int pciehp_enable_slot(struct slot *p_slot)
 	int rc;
 	struct controller *ctrl = p_slot->ctrl;
 
-	rc = pciehp_get_adapter_status(p_slot, &getstatus);
-	if (rc || !getstatus) {
+	pciehp_get_adapter_status(p_slot, &getstatus);
+	if (!getstatus) {
 		ctrl_info(ctrl, "No adapter on slot(%s)\n", slot_name(p_slot));
 		return -ENODEV;
 	}
 	if (MRL_SENS(p_slot->ctrl)) {
-		rc = pciehp_get_latch_status(p_slot, &getstatus);
-		if (rc || getstatus) {
+		pciehp_get_latch_status(p_slot, &getstatus);
+		if (getstatus) {
 			ctrl_info(ctrl, "Latch open on slot(%s)\n",
 				  slot_name(p_slot));
 			return -ENODEV;
@@ -497,8 +484,8 @@ int pciehp_enable_slot(struct slot *p_slot)
 	}
 
 	if (POWER_CTRL(p_slot->ctrl)) {
-		rc = pciehp_get_power_status(p_slot, &getstatus);
-		if (rc || getstatus) {
+		pciehp_get_power_status(p_slot, &getstatus);
+		if (getstatus) {
 			ctrl_info(ctrl, "Already enabled on slot(%s)\n",
 				  slot_name(p_slot));
 			return -EINVAL;
@@ -518,15 +505,14 @@ int pciehp_enable_slot(struct slot *p_slot)
 int pciehp_disable_slot(struct slot *p_slot)
 {
 	u8 getstatus = 0;
-	int ret = 0;
 	struct controller *ctrl = p_slot->ctrl;
 
 	if (!p_slot->ctrl)
 		return 1;
 
 	if (!HP_SUPR_RM(p_slot->ctrl)) {
-		ret = pciehp_get_adapter_status(p_slot, &getstatus);
-		if (ret || !getstatus) {
+		pciehp_get_adapter_status(p_slot, &getstatus);
+		if (!getstatus) {
 			ctrl_info(ctrl, "No adapter on slot(%s)\n",
 				  slot_name(p_slot));
 			return -ENODEV;
@@ -534,8 +520,8 @@ int pciehp_disable_slot(struct slot *p_slot)
 	}
 
 	if (MRL_SENS(p_slot->ctrl)) {
-		ret = pciehp_get_latch_status(p_slot, &getstatus);
-		if (ret || getstatus) {
+		pciehp_get_latch_status(p_slot, &getstatus);
+		if (getstatus) {
 			ctrl_info(ctrl, "Latch open on slot(%s)\n",
 				  slot_name(p_slot));
 			return -ENODEV;
@@ -543,8 +529,8 @@ int pciehp_disable_slot(struct slot *p_slot)
 	}
 
 	if (POWER_CTRL(p_slot->ctrl)) {
-		ret = pciehp_get_power_status(p_slot, &getstatus);
-		if (ret || !getstatus) {
+		pciehp_get_power_status(p_slot, &getstatus);
+		if (!getstatus) {
 			ctrl_info(ctrl, "Already disabled on slot(%s)\n",
 				  slot_name(p_slot));
 			return -EINVAL;
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 6afdd2358227..83df74910f9a 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -153,7 +153,7 @@ static void pcie_wait_cmd(struct controller *ctrl, int poll)
  * @cmd:  command value written to slot control register
  * @mask: bitmask of slot control register to be modified
  */
-static int pcie_write_cmd(struct controller *ctrl, u16 cmd, u16 mask)
+static void pcie_write_cmd(struct controller *ctrl, u16 cmd, u16 mask)
 {
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_status;
@@ -208,7 +208,6 @@ static int pcie_write_cmd(struct controller *ctrl, u16 cmd, u16 mask)
                 pcie_wait_cmd(ctrl, poll);
 	}
 	mutex_unlock(&ctrl->ctrl_lock);
-	return 0;
 }
 
 static bool check_link_active(struct controller *ctrl)
@@ -342,7 +341,7 @@ static int pciehp_link_disable(struct controller *ctrl)
 	return __pciehp_link_set(ctrl, false);
 }
 
-int pciehp_get_attention_status(struct slot *slot, u8 *status)
+void pciehp_get_attention_status(struct slot *slot, u8 *status)
 {
 	struct controller *ctrl = slot->ctrl;
 	struct pci_dev *pdev = ctrl_dev(ctrl);
@@ -372,11 +371,9 @@ int pciehp_get_attention_status(struct slot *slot, u8 *status)
 		*status = 0xFF;
 		break;
 	}
-
-	return 0;
 }
 
-int pciehp_get_power_status(struct slot *slot, u8 *status)
+void pciehp_get_power_status(struct slot *slot, u8 *status)
 {
 	struct controller *ctrl = slot->ctrl;
 	struct pci_dev *pdev = ctrl_dev(ctrl);
@@ -400,28 +397,24 @@ int pciehp_get_power_status(struct slot *slot, u8 *status)
 		*status = 0xFF;
 		break;
 	}
-
-	return 0;
 }
 
-int pciehp_get_latch_status(struct slot *slot, u8 *status)
+void pciehp_get_latch_status(struct slot *slot, u8 *status)
 {
 	struct pci_dev *pdev = ctrl_dev(slot->ctrl);
 	u16 slot_status;
 
 	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
 	*status = !!(slot_status & PCI_EXP_SLTSTA_MRLSS);
-	return 0;
 }
 
-int pciehp_get_adapter_status(struct slot *slot, u8 *status)
+void pciehp_get_adapter_status(struct slot *slot, u8 *status)
 {
 	struct pci_dev *pdev = ctrl_dev(slot->ctrl);
 	u16 slot_status;
 
 	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
 	*status = !!(slot_status & PCI_EXP_SLTSTA_PDS);
-	return 0;
 }
 
 int pciehp_query_power_fault(struct slot *slot)
@@ -433,7 +426,7 @@ int pciehp_query_power_fault(struct slot *slot)
 	return !!(slot_status & PCI_EXP_SLTSTA_PFD);
 }
 
-int pciehp_set_attention_status(struct slot *slot, u8 value)
+void pciehp_set_attention_status(struct slot *slot, u8 value)
 {
 	struct controller *ctrl = slot->ctrl;
 	u16 slot_cmd;
@@ -451,11 +444,11 @@ int pciehp_set_attention_status(struct slot *slot, u8 value)
 		slot_cmd = 0x0080;
 		break;
 	default:
-		return -EINVAL;
+		return;
 	}
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_cmd);
-	return pcie_write_cmd(ctrl, slot_cmd, cmd_mask);
+	pcie_write_cmd(ctrl, slot_cmd, cmd_mask);
 }
 
 void pciehp_green_led_on(struct slot *slot)
@@ -515,11 +508,7 @@ int pciehp_power_on_slot(struct slot * slot)
 
 	slot_cmd = POWER_ON;
 	cmd_mask = PCI_EXP_SLTCTL_PCC;
-	retval = pcie_write_cmd(ctrl, slot_cmd, cmd_mask);
-	if (retval) {
-		ctrl_err(ctrl, "Write %x command failed!\n", slot_cmd);
-		return retval;
-	}
+	pcie_write_cmd(ctrl, slot_cmd, cmd_mask);
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_cmd);
 
@@ -530,12 +519,11 @@ int pciehp_power_on_slot(struct slot * slot)
 	return retval;
 }
 
-int pciehp_power_off_slot(struct slot * slot)
+void pciehp_power_off_slot(struct slot * slot)
 {
 	struct controller *ctrl = slot->ctrl;
 	u16 slot_cmd;
 	u16 cmd_mask;
-	int retval;
 
 	/* Disable the link at first */
 	pciehp_link_disable(ctrl);
@@ -547,14 +535,9 @@ int pciehp_power_off_slot(struct slot * slot)
 
 	slot_cmd = POWER_OFF;
 	cmd_mask = PCI_EXP_SLTCTL_PCC;
-	retval = pcie_write_cmd(ctrl, slot_cmd, cmd_mask);
-	if (retval) {
-		ctrl_err(ctrl, "Write command failed!\n");
-		return retval;
-	}
+	pcie_write_cmd(ctrl, slot_cmd, cmd_mask);
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_cmd);
-	return 0;
 }
 
 static irqreturn_t pcie_isr(int irq, void *dev_id)
@@ -617,7 +600,7 @@ static irqreturn_t pcie_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-int pcie_enable_notification(struct controller *ctrl)
+void pcie_enable_notification(struct controller *ctrl)
 {
 	u16 cmd, mask;
 
@@ -643,22 +626,18 @@ int pcie_enable_notification(struct controller *ctrl)
 		PCI_EXP_SLTCTL_MRLSCE | PCI_EXP_SLTCTL_PFDE |
 		PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_CCIE);
 
-	if (pcie_write_cmd(ctrl, cmd, mask)) {
-		ctrl_err(ctrl, "Cannot enable software notification\n");
-		return -1;
-	}
-	return 0;
+	pcie_write_cmd(ctrl, cmd, mask);
 }
 
 static void pcie_disable_notification(struct controller *ctrl)
 {
 	u16 mask;
+
 	mask = (PCI_EXP_SLTCTL_PDCE | PCI_EXP_SLTCTL_ABPE |
 		PCI_EXP_SLTCTL_MRLSCE | PCI_EXP_SLTCTL_PFDE |
 		PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_CCIE |
 		PCI_EXP_SLTCTL_DLLSCE);
-	if (pcie_write_cmd(ctrl, 0, mask))
-		ctrl_warn(ctrl, "Cannot disable software notification\n");
+	pcie_write_cmd(ctrl, 0, mask);
 }
 
 /*
@@ -698,10 +677,7 @@ int pcie_init_notification(struct controller *ctrl)
 {
 	if (pciehp_request_irq(ctrl))
 		return -1;
-	if (pcie_enable_notification(ctrl)) {
-		pciehp_free_irq(ctrl);
-		return -1;
-	}
+	pcie_enable_notification(ctrl);
 	ctrl->notification_enabled = 1;
 	return 0;
 }
diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index 0e0d0f7f63fd..198355112ee7 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -78,7 +78,7 @@ int pciehp_configure_device(struct slot *p_slot)
 
 int pciehp_unconfigure_device(struct slot *p_slot)
 {
-	int ret, rc = 0;
+	int rc = 0;
 	u8 bctl = 0;
 	u8 presence = 0;
 	struct pci_dev *dev, *temp;
@@ -88,9 +88,7 @@ int pciehp_unconfigure_device(struct slot *p_slot)
 
 	ctrl_dbg(ctrl, "%s: domain:bus:dev = %04x:%02x:00\n",
 		 __func__, pci_domain_nr(parent), parent->number);
-	ret = pciehp_get_adapter_status(p_slot, &presence);
-	if (ret)
-		presence = 0;
+	pciehp_get_adapter_status(p_slot, &presence);
 
 	/*
 	 * Stopping an SR-IOV PF device removes all the associated VFs,

