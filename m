Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:45699 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908Ab3LPBPF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 15 Dec 2013 20:15:05 -0500
Received: by mail-ie0-f173.google.com with SMTP id to1so5681198ieb.18
        for <linux-pci@vger.kernel.org>; Sun, 15 Dec 2013 17:15:04 -0800 (PST)
Received: from localhost (173-8-252-97-Colorado.hfc.comcastbusiness.net. [173.8.252.97])
        by mx.google.com with ESMTPSA id nh7sm3571152igb.7.2013.12.15.17.15.03
        for <linux-pci@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 15 Dec 2013 17:15:03 -0800 (PST)
Subject: [PATCH 1/8] PCI: pciehp: Drop pciehp_readw()/pciehp_writew()
 wrappers
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sun, 15 Dec 2013 18:15:02 -0700
Message-ID: <20131216011502.7275.50086.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20131216010946.7275.83547.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20131216010946.7275.83547.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The pciehp_readw() and pciehp_writew() wrappers only look up the pci_dev
and call the PCIe Capability accessors, so we can make things a little
more straightforward by just using the PCIe Capability accessors directly.

No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp_hpc.c |   95 +++++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 47 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 3eea3fdd4b0b..53bb5501d199 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -41,28 +41,9 @@
 #include "../pci.h"
 #include "pciehp.h"
 
-static inline int pciehp_readw(struct controller *ctrl, int reg, u16 *value)
+static inline struct pci_dev *ctrl_dev(struct controller *ctrl)
 {
-	struct pci_dev *dev = ctrl->pcie->port;
-	return pcie_capability_read_word(dev, reg, value);
-}
-
-static inline int pciehp_readl(struct controller *ctrl, int reg, u32 *value)
-{
-	struct pci_dev *dev = ctrl->pcie->port;
-	return pcie_capability_read_dword(dev, reg, value);
-}
-
-static inline int pciehp_writew(struct controller *ctrl, int reg, u16 value)
-{
-	struct pci_dev *dev = ctrl->pcie->port;
-	return pcie_capability_write_word(dev, reg, value);
-}
-
-static inline int pciehp_writel(struct controller *ctrl, int reg, u32 value)
-{
-	struct pci_dev *dev = ctrl->pcie->port;
-	return pcie_capability_write_dword(dev, reg, value);
+	return ctrl->pcie->port;
 }
 
 /* Power Control Command */
@@ -129,20 +110,24 @@ static inline void pciehp_free_irq(struct controller *ctrl)
 
 static int pcie_poll_cmd(struct controller *ctrl)
 {
+	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_status;
 	int err, timeout = 1000;
 
-	err = pciehp_readw(ctrl, PCI_EXP_SLTSTA, &slot_status);
+	err = pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
 	if (!err && (slot_status & PCI_EXP_SLTSTA_CC)) {
-		pciehp_writew(ctrl, PCI_EXP_SLTSTA, PCI_EXP_SLTSTA_CC);
+		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
+					   PCI_EXP_SLTSTA_CC);
 		return 1;
 	}
 	while (timeout > 0) {
 		msleep(10);
 		timeout -= 10;
-		err = pciehp_readw(ctrl, PCI_EXP_SLTSTA, &slot_status);
+		err = pcie_capability_read_word(pdev, PCI_EXP_SLTSTA,
+						&slot_status);
 		if (!err && (slot_status & PCI_EXP_SLTSTA_CC)) {
-			pciehp_writew(ctrl, PCI_EXP_SLTSTA, PCI_EXP_SLTSTA_CC);
+			pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
+						   PCI_EXP_SLTSTA_CC);
 			return 1;
 		}
 	}
@@ -171,13 +156,14 @@ static void pcie_wait_cmd(struct controller *ctrl, int poll)
  */
 static int pcie_write_cmd(struct controller *ctrl, u16 cmd, u16 mask)
 {
+	struct pci_dev *pdev = ctrl_dev(ctrl);
 	int retval = 0;
 	u16 slot_status;
 	u16 slot_ctrl;
 
 	mutex_lock(&ctrl->ctrl_lock);
 
-	retval = pciehp_readw(ctrl, PCI_EXP_SLTSTA, &slot_status);
+	retval = pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
 	if (retval) {
 		ctrl_err(ctrl, "%s: Cannot read SLOTSTATUS register\n",
 			 __func__);
@@ -207,7 +193,7 @@ static int pcie_write_cmd(struct controller *ctrl, u16 cmd, u16 mask)
 		}
 	}
 
-	retval = pciehp_readw(ctrl, PCI_EXP_SLTCTL, &slot_ctrl);
+	retval = pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
 	if (retval) {
 		ctrl_err(ctrl, "%s: Cannot read SLOTCTRL register\n", __func__);
 		goto out;
@@ -217,7 +203,7 @@ static int pcie_write_cmd(struct controller *ctrl, u16 cmd, u16 mask)
 	slot_ctrl |= (cmd & mask);
 	ctrl->cmd_busy = 1;
 	smp_mb();
-	retval = pciehp_writew(ctrl, PCI_EXP_SLTCTL, slot_ctrl);
+	retval = pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, slot_ctrl);
 	if (retval)
 		ctrl_err(ctrl, "Cannot write to SLOTCTRL register\n");
 
@@ -243,10 +229,11 @@ static int pcie_write_cmd(struct controller *ctrl, u16 cmd, u16 mask)
 
 static bool check_link_active(struct controller *ctrl)
 {
+	struct pci_dev *pdev = ctrl_dev(ctrl);
 	bool ret = false;
 	u16 lnk_status;
 
-	if (pciehp_readw(ctrl, PCI_EXP_LNKSTA, &lnk_status))
+	if (pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status))
 		return ret;
 
 	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
@@ -311,6 +298,7 @@ static bool pci_bus_check_dev(struct pci_bus *bus, int devfn)
 
 int pciehp_check_link_status(struct controller *ctrl)
 {
+	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 lnk_status;
 	int retval = 0;
 	bool found = false;
@@ -330,7 +318,7 @@ int pciehp_check_link_status(struct controller *ctrl)
 	found = pci_bus_check_dev(ctrl->pcie->port->subordinate,
 					PCI_DEVFN(0, 0));
 
-	retval = pciehp_readw(ctrl, PCI_EXP_LNKSTA, &lnk_status);
+	retval = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
 	if (retval) {
 		ctrl_err(ctrl, "Cannot read LNKSTATUS register\n");
 		return retval;
@@ -354,10 +342,11 @@ int pciehp_check_link_status(struct controller *ctrl)
 
 static int __pciehp_link_set(struct controller *ctrl, bool enable)
 {
+	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 lnk_ctrl;
 	int retval = 0;
 
-	retval = pciehp_readw(ctrl, PCI_EXP_LNKCTL, &lnk_ctrl);
+	retval = pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &lnk_ctrl);
 	if (retval) {
 		ctrl_err(ctrl, "Cannot read LNKCTRL register\n");
 		return retval;
@@ -368,7 +357,7 @@ static int __pciehp_link_set(struct controller *ctrl, bool enable)
 	else
 		lnk_ctrl |= PCI_EXP_LNKCTL_LD;
 
-	retval = pciehp_writew(ctrl, PCI_EXP_LNKCTL, lnk_ctrl);
+	retval = pcie_capability_write_word(pdev, PCI_EXP_LNKCTL, lnk_ctrl);
 	if (retval) {
 		ctrl_err(ctrl, "Cannot write LNKCTRL register\n");
 		return retval;
@@ -391,11 +380,12 @@ static int pciehp_link_disable(struct controller *ctrl)
 int pciehp_get_attention_status(struct slot *slot, u8 *status)
 {
 	struct controller *ctrl = slot->ctrl;
+	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_ctrl;
 	u8 atten_led_state;
 	int retval = 0;
 
-	retval = pciehp_readw(ctrl, PCI_EXP_SLTCTL, &slot_ctrl);
+	retval = pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
 	if (retval) {
 		ctrl_err(ctrl, "%s: Cannot read SLOTCTRL register\n", __func__);
 		return retval;
@@ -430,11 +420,12 @@ int pciehp_get_attention_status(struct slot *slot, u8 *status)
 int pciehp_get_power_status(struct slot *slot, u8 *status)
 {
 	struct controller *ctrl = slot->ctrl;
+	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_ctrl;
 	u8 pwr_state;
 	int	retval = 0;
 
-	retval = pciehp_readw(ctrl, PCI_EXP_SLTCTL, &slot_ctrl);
+	retval = pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
 	if (retval) {
 		ctrl_err(ctrl, "%s: Cannot read SLOTCTRL register\n", __func__);
 		return retval;
@@ -462,10 +453,11 @@ int pciehp_get_power_status(struct slot *slot, u8 *status)
 int pciehp_get_latch_status(struct slot *slot, u8 *status)
 {
 	struct controller *ctrl = slot->ctrl;
+	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_status;
 	int retval;
 
-	retval = pciehp_readw(ctrl, PCI_EXP_SLTSTA, &slot_status);
+	retval = pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
 	if (retval) {
 		ctrl_err(ctrl, "%s: Cannot read SLOTSTATUS register\n",
 			 __func__);
@@ -478,10 +470,11 @@ int pciehp_get_latch_status(struct slot *slot, u8 *status)
 int pciehp_get_adapter_status(struct slot *slot, u8 *status)
 {
 	struct controller *ctrl = slot->ctrl;
+	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_status;
 	int retval;
 
-	retval = pciehp_readw(ctrl, PCI_EXP_SLTSTA, &slot_status);
+	retval = pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
 	if (retval) {
 		ctrl_err(ctrl, "%s: Cannot read SLOTSTATUS register\n",
 			 __func__);
@@ -494,10 +487,11 @@ int pciehp_get_adapter_status(struct slot *slot, u8 *status)
 int pciehp_query_power_fault(struct slot *slot)
 {
 	struct controller *ctrl = slot->ctrl;
+	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_status;
 	int retval;
 
-	retval = pciehp_readw(ctrl, PCI_EXP_SLTSTA, &slot_status);
+	retval = pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
 	if (retval) {
 		ctrl_err(ctrl, "Cannot check for power fault\n");
 		return retval;
@@ -572,13 +566,14 @@ void pciehp_green_led_blink(struct slot *slot)
 int pciehp_power_on_slot(struct slot * slot)
 {
 	struct controller *ctrl = slot->ctrl;
+	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_cmd;
 	u16 cmd_mask;
 	u16 slot_status;
 	int retval = 0;
 
 	/* Clear sticky power-fault bit from previous power failures */
-	retval = pciehp_readw(ctrl, PCI_EXP_SLTSTA, &slot_status);
+	retval = pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
 	if (retval) {
 		ctrl_err(ctrl, "%s: Cannot read SLOTSTATUS register\n",
 			 __func__);
@@ -586,7 +581,7 @@ int pciehp_power_on_slot(struct slot * slot)
 	}
 	slot_status &= PCI_EXP_SLTSTA_PFD;
 	if (slot_status) {
-		retval = pciehp_writew(ctrl, PCI_EXP_SLTSTA, slot_status);
+		retval = pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, slot_status);
 		if (retval) {
 			ctrl_err(ctrl,
 				 "%s: Cannot write to SLOTSTATUS register\n",
@@ -643,6 +638,7 @@ int pciehp_power_off_slot(struct slot * slot)
 static irqreturn_t pcie_isr(int irq, void *dev_id)
 {
 	struct controller *ctrl = (struct controller *)dev_id;
+	struct pci_dev *pdev = ctrl_dev(ctrl);
 	struct slot *slot = ctrl->slot;
 	u16 detected, intr_loc;
 
@@ -653,7 +649,8 @@ static irqreturn_t pcie_isr(int irq, void *dev_id)
 	 */
 	intr_loc = 0;
 	do {
-		if (pciehp_readw(ctrl, PCI_EXP_SLTSTA, &detected)) {
+		if (pcie_capability_read_word(pdev, PCI_EXP_SLTSTA,
+					      &detected)) {
 			ctrl_err(ctrl, "%s: Cannot read SLOTSTATUS\n",
 				 __func__);
 			return IRQ_NONE;
@@ -666,7 +663,9 @@ static irqreturn_t pcie_isr(int irq, void *dev_id)
 		intr_loc |= detected;
 		if (!intr_loc)
 			return IRQ_NONE;
-		if (detected && pciehp_writew(ctrl, PCI_EXP_SLTSTA, intr_loc)) {
+		if (detected &&
+		    pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
+					       intr_loc)) {
 			ctrl_err(ctrl, "%s: Cannot write to SLOTSTATUS\n",
 				 __func__);
 			return IRQ_NONE;
@@ -758,6 +757,7 @@ static void pcie_disable_notification(struct controller *ctrl)
 int pciehp_reset_slot(struct slot *slot, int probe)
 {
 	struct controller *ctrl = slot->ctrl;
+	struct pci_dev *pdev = ctrl_dev(ctrl);
 
 	if (probe)
 		return 0;
@@ -771,7 +771,8 @@ int pciehp_reset_slot(struct slot *slot, int probe)
 	pci_reset_bridge_secondary_bus(ctrl->pcie->port);
 
 	if (HP_SUPR_RM(ctrl)) {
-		pciehp_writew(ctrl, PCI_EXP_SLTSTA, PCI_EXP_SLTSTA_PDC);
+		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
+					   PCI_EXP_SLTSTA_PDC);
 		pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_PDCE, PCI_EXP_SLTCTL_PDCE);
 		if (pciehp_poll_mode)
 			int_poll_timeout(ctrl->poll_timer.data);
@@ -875,9 +876,9 @@ static inline void dbg_ctrl(struct controller *ctrl)
 		  EMI(ctrl)        ? "yes" : "no");
 	ctrl_info(ctrl, "  Command Completed    : %3s\n",
 		  NO_CMD_CMPL(ctrl) ? "no" : "yes");
-	pciehp_readw(ctrl, PCI_EXP_SLTSTA, &reg16);
+	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &reg16);
 	ctrl_info(ctrl, "Slot Status            : 0x%04x\n", reg16);
-	pciehp_readw(ctrl, PCI_EXP_SLTCTL, &reg16);
+	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &reg16);
 	ctrl_info(ctrl, "Slot Control           : 0x%04x\n", reg16);
 }
 
@@ -893,7 +894,7 @@ struct controller *pcie_init(struct pcie_device *dev)
 		goto abort;
 	}
 	ctrl->pcie = dev;
-	if (pciehp_readl(ctrl, PCI_EXP_SLTCAP, &slot_cap)) {
+	if (pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &slot_cap)) {
 		ctrl_err(ctrl, "Cannot read SLOTCAP register\n");
 		goto abort_ctrl;
 	}
@@ -913,7 +914,7 @@ struct controller *pcie_init(struct pcie_device *dev)
 	    ctrl->no_cmd_complete = 1;
 
         /* Check if Data Link Layer Link Active Reporting is implemented */
-        if (pciehp_readl(ctrl, PCI_EXP_LNKCAP, &link_cap)) {
+        if (pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &link_cap)) {
                 ctrl_err(ctrl, "%s: Cannot read LNKCAP register\n", __func__);
                 goto abort_ctrl;
         }
@@ -923,7 +924,7 @@ struct controller *pcie_init(struct pcie_device *dev)
         }
 
 	/* Clear all remaining event bits in Slot Status register */
-	if (pciehp_writew(ctrl, PCI_EXP_SLTSTA, 0x1f))
+	if (pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, 0x1f))
 		goto abort_ctrl;
 
 	/* Disable software notification */

