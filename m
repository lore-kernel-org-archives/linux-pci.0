Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:38190 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754647AbbFRQMk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jun 2015 12:12:40 -0400
Received: by igblz2 with SMTP id lz2so63163228igb.1
        for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2015 09:12:40 -0700 (PDT)
Subject: [PATCH 1/4] PCI: pciehp: Clean up debug logging
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rajat Jain <rajatja@google.com>, Yinghai Lu <yinghai@kernel.org>,
	linux-kernel@vger.kernel.org
Date: Thu, 18 Jun 2015 11:12:38 -0500
Message-ID: <20150618161238.32739.42666.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150618161207.32739.62577.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150618161207.32739.62577.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The pciehp debug logging is overly verbose and often redundant.  Almost all
of the information printed by dbg_ctrl() is also printed by the normal PCI
core enumeration code and by pcie_init().

Remove the redundant debug info.

When claiming a pciehp bridge, we print the slot characteristics, e.g.,

  Slot #6 AttnBtn- AttnInd- PwrInd- PwrCtrl- MRL- Interlock- NoCompl+ LLActRep+

Add the Hot-Plug Capable and Hot-Plug Surprise bits to this information,
and print it all in the same order as lspci does.

No functional change except the message text changes.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp_core.c |   39 ++-------------------------
 drivers/pci/hotplug/pciehp_ctrl.c |   38 +++++---------------------
 drivers/pci/hotplug/pciehp_hpc.c  |   54 +++++++------------------------------
 3 files changed, 20 insertions(+), 111 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 4597f6b..612b21a 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -77,11 +77,6 @@ static int reset_slot		(struct hotplug_slot *slot, int probe);
  */
 static void release_slot(struct hotplug_slot *hotplug_slot)
 {
-	struct slot *slot = hotplug_slot->private;
-
-	ctrl_dbg(slot->ctrl, "%s: physical_slot = %s\n",
-		 __func__, hotplug_slot_name(hotplug_slot));
-
 	kfree(hotplug_slot->ops);
 	kfree(hotplug_slot->info);
 	kfree(hotplug_slot);
@@ -129,14 +124,10 @@ static int init_slot(struct controller *ctrl)
 	slot->hotplug_slot = hotplug;
 	snprintf(name, SLOT_NAME_SIZE, "%u", PSN(ctrl));
 
-	ctrl_dbg(ctrl, "Registering domain:bus:dev=%04x:%02x:00 sun=%x\n",
-		 pci_domain_nr(ctrl->pcie->port->subordinate),
-		 ctrl->pcie->port->subordinate->number, PSN(ctrl));
 	retval = pci_hp_register(hotplug,
 				 ctrl->pcie->port->subordinate, 0, name);
 	if (retval)
-		ctrl_err(ctrl,
-			 "pci_hp_register failed with error %d\n", retval);
+		ctrl_err(ctrl, "pci_hp_register failed: error %d\n", retval);
 out:
 	if (retval) {
 		kfree(ops);
@@ -158,9 +149,6 @@ static int set_attention_status(struct hotplug_slot *hotplug_slot, u8 status)
 {
 	struct slot *slot = hotplug_slot->private;
 
-	ctrl_dbg(slot->ctrl, "%s: physical_slot = %s\n",
-		  __func__, slot_name(slot));
-
 	pciehp_set_attention_status(slot, status);
 	return 0;
 }
@@ -170,9 +158,6 @@ static int enable_slot(struct hotplug_slot *hotplug_slot)
 {
 	struct slot *slot = hotplug_slot->private;
 
-	ctrl_dbg(slot->ctrl, "%s: physical_slot = %s\n",
-		 __func__, slot_name(slot));
-
 	return pciehp_sysfs_enable_slot(slot);
 }
 
@@ -181,9 +166,6 @@ static int disable_slot(struct hotplug_slot *hotplug_slot)
 {
 	struct slot *slot = hotplug_slot->private;
 
-	ctrl_dbg(slot->ctrl, "%s: physical_slot = %s\n",
-		  __func__, slot_name(slot));
-
 	return pciehp_sysfs_disable_slot(slot);
 }
 
@@ -191,9 +173,6 @@ static int get_power_status(struct hotplug_slot *hotplug_slot, u8 *value)
 {
 	struct slot *slot = hotplug_slot->private;
 
-	ctrl_dbg(slot->ctrl, "%s: physical_slot = %s\n",
-		  __func__, slot_name(slot));
-
 	pciehp_get_power_status(slot, value);
 	return 0;
 }
@@ -202,9 +181,6 @@ static int get_attention_status(struct hotplug_slot *hotplug_slot, u8 *value)
 {
 	struct slot *slot = hotplug_slot->private;
 
-	ctrl_dbg(slot->ctrl, "%s: physical_slot = %s\n",
-		  __func__, slot_name(slot));
-
 	pciehp_get_attention_status(slot, value);
 	return 0;
 }
@@ -213,9 +189,6 @@ static int get_latch_status(struct hotplug_slot *hotplug_slot, u8 *value)
 {
 	struct slot *slot = hotplug_slot->private;
 
-	ctrl_dbg(slot->ctrl, "%s: physical_slot = %s\n",
-		 __func__, slot_name(slot));
-
 	pciehp_get_latch_status(slot, value);
 	return 0;
 }
@@ -224,9 +197,6 @@ static int get_adapter_status(struct hotplug_slot *hotplug_slot, u8 *value)
 {
 	struct slot *slot = hotplug_slot->private;
 
-	ctrl_dbg(slot->ctrl, "%s: physical_slot = %s\n",
-		 __func__, slot_name(slot));
-
 	pciehp_get_adapter_status(slot, value);
 	return 0;
 }
@@ -235,9 +205,6 @@ static int reset_slot(struct hotplug_slot *hotplug_slot, int probe)
 {
 	struct slot *slot = hotplug_slot->private;
 
-	ctrl_dbg(slot->ctrl, "%s: physical_slot = %s\n",
-		 __func__, slot_name(slot));
-
 	return pciehp_reset_slot(slot, probe);
 }
 
@@ -272,14 +239,14 @@ static int pciehp_probe(struct pcie_device *dev)
 		if (rc == -EBUSY)
 			ctrl_warn(ctrl, "Slot already registered by another hotplug driver\n");
 		else
-			ctrl_err(ctrl, "Slot initialization failed\n");
+			ctrl_err(ctrl, "Slot initialization failed (%d)\n", rc);
 		goto err_out_release_ctlr;
 	}
 
 	/* Enable events after we have setup the data structures */
 	rc = pcie_init_notification(ctrl);
 	if (rc) {
-		ctrl_err(ctrl, "Notification initialization failed\n");
+		ctrl_err(ctrl, "Notification initialization failed (%d)\n", rc);
 		goto err_out_free_ctrl_slot;
 	}
 
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index f052e95..4bdaf62 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -59,9 +59,6 @@ u8 pciehp_handle_attention_button(struct slot *p_slot)
 	u32 event_type;
 	struct controller *ctrl = p_slot->ctrl;
 
-	/* Attention Button Change */
-	ctrl_dbg(ctrl, "Attention button interrupt received\n");
-
 	/*
 	 *  Button pressed - See if need to TAKE ACTION!!!
 	 */
@@ -79,9 +76,6 @@ u8 pciehp_handle_switch_change(struct slot *p_slot)
 	u32 event_type;
 	struct controller *ctrl = p_slot->ctrl;
 
-	/* Switch Change */
-	ctrl_dbg(ctrl, "Switch interrupt received\n");
-
 	pciehp_get_latch_status(p_slot, &getstatus);
 	if (getstatus) {
 		/*
@@ -108,9 +102,6 @@ u8 pciehp_handle_presence_change(struct slot *p_slot)
 	u8 presence_save;
 	struct controller *ctrl = p_slot->ctrl;
 
-	/* Presence Change */
-	ctrl_dbg(ctrl, "Presence/Notify input change\n");
-
 	/* Switch is open, assume a presence change
 	 * Save the presence state
 	 */
@@ -140,8 +131,6 @@ u8 pciehp_handle_power_fault(struct slot *p_slot)
 	u32 event_type;
 	struct controller *ctrl = p_slot->ctrl;
 
-	/* power fault */
-	ctrl_dbg(ctrl, "Power fault interrupt received\n");
 	ctrl_err(ctrl, "Power fault on slot %s\n", slot_name(p_slot));
 	event_type = INT_POWER_FAULT;
 	ctrl_info(ctrl, "Power fault bit %x set\n", 0);
@@ -155,9 +144,6 @@ void pciehp_handle_linkstate_change(struct slot *p_slot)
 	u32 event_type;
 	struct controller *ctrl = p_slot->ctrl;
 
-	/* Link Status Change */
-	ctrl_dbg(ctrl, "Data Link Layer State change\n");
-
 	if (pciehp_check_link_active(ctrl)) {
 		ctrl_info(ctrl, "slot(%s): Link Up event\n",
 			  slot_name(p_slot));
@@ -298,10 +284,6 @@ static void pciehp_power_thread(struct work_struct *work)
 
 	switch (info->req) {
 	case DISABLE_REQ:
-		ctrl_dbg(p_slot->ctrl,
-			 "Disabling domain:bus:device=%04x:%02x:00\n",
-			 pci_domain_nr(p_slot->ctrl->pcie->port->subordinate),
-			 p_slot->ctrl->pcie->port->subordinate->number);
 		mutex_lock(&p_slot->hotplug_lock);
 		pciehp_disable_slot(p_slot);
 		mutex_unlock(&p_slot->hotplug_lock);
@@ -310,10 +292,6 @@ static void pciehp_power_thread(struct work_struct *work)
 		mutex_unlock(&p_slot->lock);
 		break;
 	case ENABLE_REQ:
-		ctrl_dbg(p_slot->ctrl,
-			 "Enabling domain:bus:device=%04x:%02x:00\n",
-			 pci_domain_nr(p_slot->ctrl->pcie->port->subordinate),
-			 p_slot->ctrl->pcie->port->subordinate->number);
 		mutex_lock(&p_slot->hotplug_lock);
 		ret = pciehp_enable_slot(p_slot);
 		mutex_unlock(&p_slot->hotplug_lock);
@@ -416,7 +394,7 @@ static void handle_button_press_event(struct slot *p_slot)
 		ctrl_info(ctrl, "Button ignore on Slot(%s)\n", slot_name(p_slot));
 		break;
 	default:
-		ctrl_warn(ctrl, "Not a valid state\n");
+		ctrl_warn(ctrl, "ignoring invalid state %#x\n", p_slot->state);
 		break;
 	}
 }
@@ -507,8 +485,8 @@ static void handle_link_event(struct slot *p_slot, u32 event)
 		}
 		break;
 	default:
-		ctrl_err(ctrl, "Not a valid state on slot(%s)\n",
-			 slot_name(p_slot));
+		ctrl_err(ctrl, "ignoring invalid state %#x on slot(%s)\n",
+			 p_slot->state, slot_name(p_slot));
 		kfree(info);
 		break;
 	}
@@ -532,7 +510,6 @@ static void interrupt_event_handler(struct work_struct *work)
 		pciehp_green_led_off(p_slot);
 		break;
 	case INT_PRESENCE_ON:
-		ctrl_dbg(ctrl, "Surprise Insertion\n");
 		handle_surprise_event(p_slot);
 		break;
 	case INT_PRESENCE_OFF:
@@ -540,7 +517,6 @@ static void interrupt_event_handler(struct work_struct *work)
 		 * Regardless of surprise capability, we need to
 		 * definitely remove a card that has been pulled out!
 		 */
-		ctrl_dbg(ctrl, "Surprise Removal\n");
 		handle_surprise_event(p_slot);
 		break;
 	case INT_LINK_UP:
@@ -647,8 +623,8 @@ int pciehp_sysfs_enable_slot(struct slot *p_slot)
 			  slot_name(p_slot));
 		break;
 	default:
-		ctrl_err(ctrl, "Not a valid state on slot %s\n",
-			 slot_name(p_slot));
+		ctrl_err(ctrl, "invalid state %#x on slot %s\n",
+			 p_slot->state, slot_name(p_slot));
 		break;
 	}
 	mutex_unlock(&p_slot->lock);
@@ -682,8 +658,8 @@ int pciehp_sysfs_disable_slot(struct slot *p_slot)
 			  slot_name(p_slot));
 		break;
 	default:
-		ctrl_err(ctrl, "Not a valid state on slot %s\n",
-			 slot_name(p_slot));
+		ctrl_err(ctrl, "invalid state %#x on slot %s\n",
+			 p_slot->state, slot_name(p_slot));
 		break;
 	}
 	mutex_unlock(&p_slot->lock);
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 6d68688..e9daaa3 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -312,7 +312,8 @@ int pciehp_check_link_status(struct controller *ctrl)
 	ctrl_dbg(ctrl, "%s: lnk_status = %x\n", __func__, lnk_status);
 	if ((lnk_status & PCI_EXP_LNKSTA_LT) ||
 	    !(lnk_status & PCI_EXP_LNKSTA_NLW)) {
-		ctrl_err(ctrl, "Link Training Error occurs\n");
+		ctrl_err(ctrl, "link training error: status %#06x\n",
+			 lnk_status);
 		return -1;
 	}
 
@@ -556,7 +557,7 @@ static irqreturn_t pcie_isr(int irq, void *dev_id)
 						   intr_loc);
 	} while (detected);
 
-	ctrl_dbg(ctrl, "%s: intr_loc %x\n", __func__, intr_loc);
+	ctrl_dbg(ctrl, "pending interrupts %#06x from Slot Status\n", intr_loc);
 
 	/* Check Command Complete Interrupt Pending */
 	if (intr_loc & PCI_EXP_SLTSTA_CC) {
@@ -748,48 +749,13 @@ static void pcie_cleanup_slot(struct controller *ctrl)
 
 static inline void dbg_ctrl(struct controller *ctrl)
 {
-	int i;
-	u16 reg16;
 	struct pci_dev *pdev = ctrl->pcie->port;
+	u16 reg16;
 
 	if (!pciehp_debug)
 		return;
 
-	ctrl_info(ctrl, "Hotplug Controller:\n");
-	ctrl_info(ctrl, "  Seg/Bus/Dev/Func/IRQ : %s IRQ %d\n",
-		  pci_name(pdev), pdev->irq);
-	ctrl_info(ctrl, "  Vendor ID            : 0x%04x\n", pdev->vendor);
-	ctrl_info(ctrl, "  Device ID            : 0x%04x\n", pdev->device);
-	ctrl_info(ctrl, "  Subsystem ID         : 0x%04x\n",
-		  pdev->subsystem_device);
-	ctrl_info(ctrl, "  Subsystem Vendor ID  : 0x%04x\n",
-		  pdev->subsystem_vendor);
-	ctrl_info(ctrl, "  PCIe Cap offset      : 0x%02x\n",
-		  pci_pcie_cap(pdev));
-	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
-		if (!pci_resource_len(pdev, i))
-			continue;
-		ctrl_info(ctrl, "  PCI resource [%d]     : %pR\n",
-			  i, &pdev->resource[i]);
-	}
 	ctrl_info(ctrl, "Slot Capabilities      : 0x%08x\n", ctrl->slot_cap);
-	ctrl_info(ctrl, "  Physical Slot Number : %d\n", PSN(ctrl));
-	ctrl_info(ctrl, "  Attention Button     : %3s\n",
-		  ATTN_BUTTN(ctrl) ? "yes" : "no");
-	ctrl_info(ctrl, "  Power Controller     : %3s\n",
-		  POWER_CTRL(ctrl) ? "yes" : "no");
-	ctrl_info(ctrl, "  MRL Sensor           : %3s\n",
-		  MRL_SENS(ctrl)   ? "yes" : "no");
-	ctrl_info(ctrl, "  Attention Indicator  : %3s\n",
-		  ATTN_LED(ctrl)   ? "yes" : "no");
-	ctrl_info(ctrl, "  Power Indicator      : %3s\n",
-		  PWR_LED(ctrl)    ? "yes" : "no");
-	ctrl_info(ctrl, "  Hot-Plug Surprise    : %3s\n",
-		  HP_SUPR_RM(ctrl) ? "yes" : "no");
-	ctrl_info(ctrl, "  EMI Present          : %3s\n",
-		  EMI(ctrl)        ? "yes" : "no");
-	ctrl_info(ctrl, "  Command Completed    : %3s\n",
-		  NO_CMD_CMPL(ctrl) ? "no" : "yes");
 	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &reg16);
 	ctrl_info(ctrl, "Slot Status            : 0x%04x\n", reg16);
 	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &reg16);
@@ -818,10 +784,8 @@ struct controller *pcie_init(struct pcie_device *dev)
 
 	/* Check if Data Link Layer Link Active Reporting is implemented */
 	pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &link_cap);
-	if (link_cap & PCI_EXP_LNKCAP_DLLLARC) {
-		ctrl_dbg(ctrl, "Link Active Reporting supported\n");
+	if (link_cap & PCI_EXP_LNKCAP_DLLLARC)
 		ctrl->link_active_reporting = 1;
-	}
 
 	/* Clear all remaining event bits in Slot Status register */
 	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
@@ -829,13 +793,15 @@ struct controller *pcie_init(struct pcie_device *dev)
 		PCI_EXP_SLTSTA_MRLSC | PCI_EXP_SLTSTA_PDC |
 		PCI_EXP_SLTSTA_CC | PCI_EXP_SLTSTA_DLLSC);
 
-	ctrl_info(ctrl, "Slot #%d AttnBtn%c AttnInd%c PwrInd%c PwrCtrl%c MRL%c Interlock%c NoCompl%c LLActRep%c\n",
+	ctrl_info(ctrl, "Slot #%d AttnBtn%c PwrCtrl%c MRL%c AttnInd%c PwrInd%c HotPlug%c Surprise%c Interlock%c NoCompl%c LLActRep%c\n",
 		(slot_cap & PCI_EXP_SLTCAP_PSN) >> 19,
 		FLAG(slot_cap, PCI_EXP_SLTCAP_ABP),
-		FLAG(slot_cap, PCI_EXP_SLTCAP_AIP),
-		FLAG(slot_cap, PCI_EXP_SLTCAP_PIP),
 		FLAG(slot_cap, PCI_EXP_SLTCAP_PCP),
 		FLAG(slot_cap, PCI_EXP_SLTCAP_MRLSP),
+		FLAG(slot_cap, PCI_EXP_SLTCAP_AIP),
+		FLAG(slot_cap, PCI_EXP_SLTCAP_PIP),
+		FLAG(slot_cap, PCI_EXP_SLTCAP_HPC),
+		FLAG(slot_cap, PCI_EXP_SLTCAP_HPS),
 		FLAG(slot_cap, PCI_EXP_SLTCAP_EIP),
 		FLAG(slot_cap, PCI_EXP_SLTCAP_NCCS),
 		FLAG(link_cap, PCI_EXP_LNKCAP_DLLLARC));

