Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ashok Raj <ashok.raj@intel.com>,
        james puthukattukaran <james.puthukattukaran@oracle.com>,
        Yinghai Lu <yinghai.lu@oracle.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH] PCI,pciehp: Move printout before write_cmd
Date: Thu, 23 Feb 2017 12:28:51 -0800
Message-Id: <20170223202851.1912-1-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn complained some strange print out for pending interrupts.

Actually that is caused that have cmd print out after write_cmd.

Adjust the sequence to get right order for debug print out.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 026830a..94df18f99 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -475,9 +475,9 @@ void pciehp_set_attention_status(struct slot *slot, u8 value)
 	default:
 		return;
 	}
-	pcie_write_cmd_nowait(ctrl, slot_cmd, PCI_EXP_SLTCTL_AIC);
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_cmd);
+	pcie_write_cmd_nowait(ctrl, slot_cmd, PCI_EXP_SLTCTL_AIC);
 }
 
 void pciehp_green_led_on(struct slot *slot)
@@ -487,11 +487,11 @@ void pciehp_green_led_on(struct slot *slot)
 	if (!PWR_LED(ctrl))
 		return;
 
-	pcie_write_cmd_nowait(ctrl, PCI_EXP_SLTCTL_PWR_IND_ON,
-			      PCI_EXP_SLTCTL_PIC);
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
 		 PCI_EXP_SLTCTL_PWR_IND_ON);
+	pcie_write_cmd_nowait(ctrl, PCI_EXP_SLTCTL_PWR_IND_ON,
+			      PCI_EXP_SLTCTL_PIC);
 }
 
 void pciehp_green_led_off(struct slot *slot)
@@ -501,11 +501,11 @@ void pciehp_green_led_off(struct slot *slot)
 	if (!PWR_LED(ctrl))
 		return;
 
-	pcie_write_cmd_nowait(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
-			      PCI_EXP_SLTCTL_PIC);
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
 		 PCI_EXP_SLTCTL_PWR_IND_OFF);
+	pcie_write_cmd_nowait(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
+			      PCI_EXP_SLTCTL_PIC);
 }
 
 void pciehp_green_led_blink(struct slot *slot)
@@ -515,11 +515,11 @@ void pciehp_green_led_blink(struct slot *slot)
 	if (!PWR_LED(ctrl))
 		return;
 
-	pcie_write_cmd_nowait(ctrl, PCI_EXP_SLTCTL_PWR_IND_BLINK,
-			      PCI_EXP_SLTCTL_PIC);
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
 		 PCI_EXP_SLTCTL_PWR_IND_BLINK);
+	pcie_write_cmd_nowait(ctrl, PCI_EXP_SLTCTL_PWR_IND_BLINK,
+			      PCI_EXP_SLTCTL_PIC);
 }
 
 int pciehp_power_on_slot(struct slot *slot)
@@ -536,10 +536,10 @@ int pciehp_power_on_slot(struct slot *slot)
 					   PCI_EXP_SLTSTA_PFD);
 	ctrl->power_fault_detected = 0;
 
-	pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_PWR_ON, PCI_EXP_SLTCTL_PCC);
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
 		 PCI_EXP_SLTCTL_PWR_ON);
+	pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_PWR_ON, PCI_EXP_SLTCTL_PCC);
 
 	retval = pciehp_link_enable(ctrl);
 	if (retval)
@@ -552,10 +552,10 @@ void pciehp_power_off_slot(struct slot *slot)
 {
 	struct controller *ctrl = slot->ctrl;
 
-	pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_PWR_OFF, PCI_EXP_SLTCTL_PCC);
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
 		 PCI_EXP_SLTCTL_PWR_OFF);
+	pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_PWR_OFF, PCI_EXP_SLTCTL_PCC);
 }
 
 static irqreturn_t pciehp_isr(int irq, void *dev_id)
@@ -701,9 +701,9 @@ void pcie_enable_notification(struct controller *ctrl)
 		PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_CCIE |
 		PCI_EXP_SLTCTL_DLLSCE);
 
-	pcie_write_cmd_nowait(ctrl, cmd, mask);
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, cmd);
+	pcie_write_cmd_nowait(ctrl, cmd, mask);
 }
 
 static void pcie_disable_notification(struct controller *ctrl)
@@ -714,9 +714,9 @@ static void pcie_disable_notification(struct controller *ctrl)
 		PCI_EXP_SLTCTL_MRLSCE | PCI_EXP_SLTCTL_PFDE |
 		PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_CCIE |
 		PCI_EXP_SLTCTL_DLLSCE);
-	pcie_write_cmd(ctrl, 0, mask);
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, 0);
+	pcie_write_cmd(ctrl, 0, mask);
 }
 
 /*
@@ -743,18 +743,18 @@ int pciehp_reset_slot(struct slot *slot, int probe)
 	ctrl_mask |= PCI_EXP_SLTCTL_DLLSCE;
 	stat_mask |= PCI_EXP_SLTSTA_DLLSC;
 
-	pcie_write_cmd(ctrl, 0, ctrl_mask);
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, 0);
+	pcie_write_cmd(ctrl, 0, ctrl_mask);
 	if (pciehp_poll_mode)
 		del_timer_sync(&ctrl->poll_timer);
 
 	pci_reset_bridge_secondary_bus(ctrl->pcie->port);
 
 	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, stat_mask);
-	pcie_write_cmd_nowait(ctrl, ctrl_mask, ctrl_mask);
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, ctrl_mask);
+	pcie_write_cmd_nowait(ctrl, ctrl_mask, ctrl_mask);
 	if (pciehp_poll_mode)
 		int_poll_timeout(ctrl->poll_timer.data);
 
