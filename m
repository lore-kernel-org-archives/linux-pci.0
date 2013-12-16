Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:41532 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908Ab3LPBPm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 15 Dec 2013 20:15:42 -0500
Received: by mail-ig0-f178.google.com with SMTP id ut6so2708230igb.5
        for <linux-pci@vger.kernel.org>; Sun, 15 Dec 2013 17:15:42 -0800 (PST)
Received: from localhost (173-8-252-97-Colorado.hfc.comcastbusiness.net. [173.8.252.97])
        by mx.google.com with ESMTPSA id da14sm13393042igc.1.2013.12.15.17.15.42
        for <linux-pci@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 15 Dec 2013 17:15:42 -0800 (PST)
Subject: [PATCH 7/8] PCI: pciehp: Use symbolic constants for Slot Control
 fields
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sun, 15 Dec 2013 18:15:41 -0700
Message-ID: <20131216011541.7275.52355.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20131216010946.7275.83547.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20131216010946.7275.83547.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add symbolic constants for the PCIe Slot Control indicator and power
control fields defined by spec and use them instead of open-coded hex
constants.

No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp_hpc.c |   86 ++++++++++++--------------------------
 include/uapi/linux/pci_regs.h    |    8 ++++
 2 files changed, 36 insertions(+), 58 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 915bb35f9180..05d421cf935e 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -46,10 +46,6 @@ static inline struct pci_dev *ctrl_dev(struct controller *ctrl)
 	return ctrl->pcie->port;
 }
 
-/* Power Control Command */
-#define POWER_ON	0
-#define POWER_OFF	PCI_EXP_SLTCTL_PCC
-
 static irqreturn_t pcie_isr(int irq, void *dev_id);
 static void start_int_poll_timer(struct controller *ctrl, int sec);
 
@@ -346,25 +342,19 @@ void pciehp_get_attention_status(struct slot *slot, u8 *status)
 	struct controller *ctrl = slot->ctrl;
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_ctrl;
-	u8 atten_led_state;
 
 	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x, value read %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_ctrl);
 
-	atten_led_state = (slot_ctrl & PCI_EXP_SLTCTL_AIC) >> 6;
-
-	switch (atten_led_state) {
-	case 0:
-		*status = 0xFF;	/* Reserved */
-		break;
-	case 1:
+	switch (slot_ctrl & PCI_EXP_SLTCTL_AIC) {
+	case PCI_EXP_SLTCTL_ATTN_IND_ON:
 		*status = 1;	/* On */
 		break;
-	case 2:
+	case PCI_EXP_SLTCTL_ATTN_IND_BLINK:
 		*status = 2;	/* Blink */
 		break;
-	case 3:
+	case PCI_EXP_SLTCTL_ATTN_IND_OFF:
 		*status = 0;	/* Off */
 		break;
 	default:
@@ -378,20 +368,17 @@ void pciehp_get_power_status(struct slot *slot, u8 *status)
 	struct controller *ctrl = slot->ctrl;
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_ctrl;
-	u8 pwr_state;
 
 	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x value read %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_ctrl);
 
-	pwr_state = (slot_ctrl & PCI_EXP_SLTCTL_PCC) >> 10;
-
-	switch (pwr_state) {
-	case 0:
-		*status = 1;
+	switch (slot_ctrl & PCI_EXP_SLTCTL_PCC) {
+	case PCI_EXP_SLTCTL_PWR_ON:
+		*status = 1;	/* On */
 		break;
-	case 1:
-		*status = 0;
+	case PCI_EXP_SLTCTL_PWR_OFF:
+		*status = 0;	/* Off */
 		break;
 	default:
 		*status = 0xFF;
@@ -430,72 +417,59 @@ void pciehp_set_attention_status(struct slot *slot, u8 value)
 {
 	struct controller *ctrl = slot->ctrl;
 	u16 slot_cmd;
-	u16 cmd_mask;
 
-	cmd_mask = PCI_EXP_SLTCTL_AIC;
 	switch (value) {
 	case 0 :	/* turn off */
-		slot_cmd = 0x00C0;
+		slot_cmd = PCI_EXP_SLTCTL_ATTN_IND_OFF;
 		break;
 	case 1:		/* turn on */
-		slot_cmd = 0x0040;
+		slot_cmd = PCI_EXP_SLTCTL_ATTN_IND_ON;
 		break;
 	case 2:		/* turn blink */
-		slot_cmd = 0x0080;
+		slot_cmd = PCI_EXP_SLTCTL_ATTN_IND_BLINK;
 		break;
 	default:
 		return;
 	}
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_cmd);
-	pcie_write_cmd(ctrl, slot_cmd, cmd_mask);
+	pcie_write_cmd(ctrl, slot_cmd, PCI_EXP_SLTCTL_AIC);
 }
 
 void pciehp_green_led_on(struct slot *slot)
 {
 	struct controller *ctrl = slot->ctrl;
-	u16 slot_cmd;
-	u16 cmd_mask;
 
-	slot_cmd = 0x0100;
-	cmd_mask = PCI_EXP_SLTCTL_PIC;
-	pcie_write_cmd(ctrl, slot_cmd, cmd_mask);
+	pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_PWR_IND_ON, PCI_EXP_SLTCTL_PIC);
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
-		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_cmd);
+		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
+		 PCI_EXP_SLTCTL_PWR_IND_ON);
 }
 
 void pciehp_green_led_off(struct slot *slot)
 {
 	struct controller *ctrl = slot->ctrl;
-	u16 slot_cmd;
-	u16 cmd_mask;
 
-	slot_cmd = 0x0300;
-	cmd_mask = PCI_EXP_SLTCTL_PIC;
-	pcie_write_cmd(ctrl, slot_cmd, cmd_mask);
+	pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF, PCI_EXP_SLTCTL_PIC);
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
-		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_cmd);
+		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
+		 PCI_EXP_SLTCTL_PWR_IND_OFF);
 }
 
 void pciehp_green_led_blink(struct slot *slot)
 {
 	struct controller *ctrl = slot->ctrl;
-	u16 slot_cmd;
-	u16 cmd_mask;
 
-	slot_cmd = 0x0200;
-	cmd_mask = PCI_EXP_SLTCTL_PIC;
-	pcie_write_cmd(ctrl, slot_cmd, cmd_mask);
+	pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_PWR_IND_BLINK, PCI_EXP_SLTCTL_PIC);
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
-		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_cmd);
+		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
+		 PCI_EXP_SLTCTL_PWR_IND_BLINK);
 }
 
 int pciehp_power_on_slot(struct slot * slot)
 {
 	struct controller *ctrl = slot->ctrl;
 	struct pci_dev *pdev = ctrl_dev(ctrl);
-	u16 slot_cmd;
-	u16 cmd_mask;
 	u16 slot_status;
 	int retval;
 
@@ -506,11 +480,10 @@ int pciehp_power_on_slot(struct slot * slot)
 					   PCI_EXP_SLTSTA_PFD);
 	ctrl->power_fault_detected = 0;
 
-	slot_cmd = POWER_ON;
-	cmd_mask = PCI_EXP_SLTCTL_PCC;
-	pcie_write_cmd(ctrl, slot_cmd, cmd_mask);
+	pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_PWR_ON, PCI_EXP_SLTCTL_PCC);
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
-		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_cmd);
+		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
+		 PCI_EXP_SLTCTL_PWR_ON);
 
 	retval = pciehp_link_enable(ctrl);
 	if (retval)
@@ -522,8 +495,6 @@ int pciehp_power_on_slot(struct slot * slot)
 void pciehp_power_off_slot(struct slot * slot)
 {
 	struct controller *ctrl = slot->ctrl;
-	u16 slot_cmd;
-	u16 cmd_mask;
 
 	/* Disable the link at first */
 	pciehp_link_disable(ctrl);
@@ -533,11 +504,10 @@ void pciehp_power_off_slot(struct slot * slot)
 	else
 		msleep(1000);
 
-	slot_cmd = POWER_OFF;
-	cmd_mask = PCI_EXP_SLTCTL_PCC;
-	pcie_write_cmd(ctrl, slot_cmd, cmd_mask);
+	pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_PWR_OFF, PCI_EXP_SLTCTL_PCC);
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
-		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_cmd);
+		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
+		 PCI_EXP_SLTCTL_PWR_OFF);
 }
 
 static irqreturn_t pcie_isr(int irq, void *dev_id)
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 4a98e85438a7..6d03ba42ab23 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -518,8 +518,16 @@
 #define  PCI_EXP_SLTCTL_CCIE	0x0010	/* Command Completed Interrupt Enable */
 #define  PCI_EXP_SLTCTL_HPIE	0x0020	/* Hot-Plug Interrupt Enable */
 #define  PCI_EXP_SLTCTL_AIC	0x00c0	/* Attention Indicator Control */
+#define  PCI_EXP_SLTCTL_ATTN_IND_ON    0x0040 /* Attention Indicator on */
+#define  PCI_EXP_SLTCTL_ATTN_IND_BLINK 0x0080 /* Attention Indicator blinking */
+#define  PCI_EXP_SLTCTL_ATTN_IND_OFF   0x00c0 /* Attention Indicator off */
 #define  PCI_EXP_SLTCTL_PIC	0x0300	/* Power Indicator Control */
+#define  PCI_EXP_SLTCTL_PWR_IND_ON     0x0100 /* Power Indicator on */
+#define  PCI_EXP_SLTCTL_PWR_IND_BLINK  0x0200 /* Power Indicator blinking */
+#define  PCI_EXP_SLTCTL_PWR_IND_OFF    0x0300 /* Power Indicator off */
 #define  PCI_EXP_SLTCTL_PCC	0x0400	/* Power Controller Control */
+#define  PCI_EXP_SLTCTL_PWR_ON         0x0000 /* Power On */
+#define  PCI_EXP_SLTCTL_PWR_OFF        0x0400 /* Power Off */
 #define  PCI_EXP_SLTCTL_EIC	0x0800	/* Electromechanical Interlock Control */
 #define  PCI_EXP_SLTCTL_DLLSCE	0x1000	/* Data Link Layer State Changed Enable */
 #define PCI_EXP_SLTSTA		26	/* Slot Status */

