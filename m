Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:38340 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908Ab3LPBPL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 15 Dec 2013 20:15:11 -0500
Received: by mail-ie0-f180.google.com with SMTP id tp5so5681475ieb.39
        for <linux-pci@vger.kernel.org>; Sun, 15 Dec 2013 17:15:10 -0800 (PST)
Received: from localhost (173-8-252-97-Colorado.hfc.comcastbusiness.net. [173.8.252.97])
        by mx.google.com with ESMTPSA id j3sm7045174igj.9.2013.12.15.17.15.09
        for <linux-pci@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 15 Dec 2013 17:15:10 -0800 (PST)
Subject: [PATCH 2/8] PCI: pciehp: Remove error checks when accessing PCIe
 Capability
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sun, 15 Dec 2013 18:15:09 -0700
Message-ID: <20131216011509.7275.61660.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20131216010946.7275.83547.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20131216010946.7275.83547.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There's not much point in checking the return value from every config space
access because the only likely errors are design-time things like unaligned
accesses or invalid register numbers.  The checking clutters the code
significantly, so this patch removes it.

No functional change.

Reference: http://lkml.kernel.org/r/CA+55aFzP4xEbcNmZ+MS0SQ3LrULzSq+dBiT_X9U-bPpR-Ukgrw@mail.gmail.com
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp_hpc.c |  177 +++++++++-----------------------------
 1 file changed, 41 insertions(+), 136 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 53bb5501d199..6afdd2358227 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -112,10 +112,10 @@ static int pcie_poll_cmd(struct controller *ctrl)
 {
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_status;
-	int err, timeout = 1000;
+	int timeout = 1000;
 
-	err = pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
-	if (!err && (slot_status & PCI_EXP_SLTSTA_CC)) {
+	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
+	if (slot_status & PCI_EXP_SLTSTA_CC) {
 		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
 					   PCI_EXP_SLTSTA_CC);
 		return 1;
@@ -123,9 +123,8 @@ static int pcie_poll_cmd(struct controller *ctrl)
 	while (timeout > 0) {
 		msleep(10);
 		timeout -= 10;
-		err = pcie_capability_read_word(pdev, PCI_EXP_SLTSTA,
-						&slot_status);
-		if (!err && (slot_status & PCI_EXP_SLTSTA_CC)) {
+		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
+		if (slot_status & PCI_EXP_SLTSTA_CC) {
 			pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
 						   PCI_EXP_SLTSTA_CC);
 			return 1;
@@ -157,19 +156,12 @@ static void pcie_wait_cmd(struct controller *ctrl, int poll)
 static int pcie_write_cmd(struct controller *ctrl, u16 cmd, u16 mask)
 {
 	struct pci_dev *pdev = ctrl_dev(ctrl);
-	int retval = 0;
 	u16 slot_status;
 	u16 slot_ctrl;
 
 	mutex_lock(&ctrl->ctrl_lock);
 
-	retval = pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
-	if (retval) {
-		ctrl_err(ctrl, "%s: Cannot read SLOTSTATUS register\n",
-			 __func__);
-		goto out;
-	}
-
+	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
 	if (slot_status & PCI_EXP_SLTSTA_CC) {
 		if (!ctrl->no_cmd_complete) {
 			/*
@@ -193,24 +185,17 @@ static int pcie_write_cmd(struct controller *ctrl, u16 cmd, u16 mask)
 		}
 	}
 
-	retval = pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
-	if (retval) {
-		ctrl_err(ctrl, "%s: Cannot read SLOTCTRL register\n", __func__);
-		goto out;
-	}
-
+	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
 	slot_ctrl &= ~mask;
 	slot_ctrl |= (cmd & mask);
 	ctrl->cmd_busy = 1;
 	smp_mb();
-	retval = pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, slot_ctrl);
-	if (retval)
-		ctrl_err(ctrl, "Cannot write to SLOTCTRL register\n");
+	pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, slot_ctrl);
 
 	/*
 	 * Wait for command completion.
 	 */
-	if (!retval && !ctrl->no_cmd_complete) {
+	if (!ctrl->no_cmd_complete) {
 		int poll = 0;
 		/*
 		 * if hotplug interrupt is not enabled or command
@@ -222,20 +207,17 @@ static int pcie_write_cmd(struct controller *ctrl, u16 cmd, u16 mask)
 			poll = 1;
                 pcie_wait_cmd(ctrl, poll);
 	}
- out:
 	mutex_unlock(&ctrl->ctrl_lock);
-	return retval;
+	return 0;
 }
 
 static bool check_link_active(struct controller *ctrl)
 {
 	struct pci_dev *pdev = ctrl_dev(ctrl);
-	bool ret = false;
 	u16 lnk_status;
+	bool ret;
 
-	if (pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status))
-		return ret;
-
+	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
 	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
 
 	if (ret)
@@ -299,9 +281,8 @@ static bool pci_bus_check_dev(struct pci_bus *bus, int devfn)
 int pciehp_check_link_status(struct controller *ctrl)
 {
 	struct pci_dev *pdev = ctrl_dev(ctrl);
+	bool found;
 	u16 lnk_status;
-	int retval = 0;
-	bool found = false;
 
         /*
          * Data Link Layer Link Active Reporting must be capable for
@@ -318,53 +299,37 @@ int pciehp_check_link_status(struct controller *ctrl)
 	found = pci_bus_check_dev(ctrl->pcie->port->subordinate,
 					PCI_DEVFN(0, 0));
 
-	retval = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
-	if (retval) {
-		ctrl_err(ctrl, "Cannot read LNKSTATUS register\n");
-		return retval;
-	}
-
+	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
 	ctrl_dbg(ctrl, "%s: lnk_status = %x\n", __func__, lnk_status);
 	if ((lnk_status & PCI_EXP_LNKSTA_LT) ||
 	    !(lnk_status & PCI_EXP_LNKSTA_NLW)) {
 		ctrl_err(ctrl, "Link Training Error occurs \n");
-		retval = -1;
-		return retval;
+		return -1;
 	}
 
 	pcie_update_link_speed(ctrl->pcie->port->subordinate, lnk_status);
 
-	if (!found && !retval)
-		retval = -1;
+	if (!found)
+		return -1;
 
-	return retval;
+	return 0;
 }
 
 static int __pciehp_link_set(struct controller *ctrl, bool enable)
 {
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 lnk_ctrl;
-	int retval = 0;
 
-	retval = pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &lnk_ctrl);
-	if (retval) {
-		ctrl_err(ctrl, "Cannot read LNKCTRL register\n");
-		return retval;
-	}
+	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &lnk_ctrl);
 
 	if (enable)
 		lnk_ctrl &= ~PCI_EXP_LNKCTL_LD;
 	else
 		lnk_ctrl |= PCI_EXP_LNKCTL_LD;
 
-	retval = pcie_capability_write_word(pdev, PCI_EXP_LNKCTL, lnk_ctrl);
-	if (retval) {
-		ctrl_err(ctrl, "Cannot write LNKCTRL register\n");
-		return retval;
-	}
+	pcie_capability_write_word(pdev, PCI_EXP_LNKCTL, lnk_ctrl);
 	ctrl_dbg(ctrl, "%s: lnk_ctrl = %x\n", __func__, lnk_ctrl);
-
-	return retval;
+	return 0;
 }
 
 static int pciehp_link_enable(struct controller *ctrl)
@@ -383,14 +348,8 @@ int pciehp_get_attention_status(struct slot *slot, u8 *status)
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_ctrl;
 	u8 atten_led_state;
-	int retval = 0;
-
-	retval = pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
-	if (retval) {
-		ctrl_err(ctrl, "%s: Cannot read SLOTCTRL register\n", __func__);
-		return retval;
-	}
 
+	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x, value read %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_ctrl);
 
@@ -423,13 +382,8 @@ int pciehp_get_power_status(struct slot *slot, u8 *status)
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_ctrl;
 	u8 pwr_state;
-	int	retval = 0;
 
-	retval = pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
-	if (retval) {
-		ctrl_err(ctrl, "%s: Cannot read SLOTCTRL register\n", __func__);
-		return retval;
-	}
+	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x value read %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_ctrl);
 
@@ -447,55 +401,35 @@ int pciehp_get_power_status(struct slot *slot, u8 *status)
 		break;
 	}
 
-	return retval;
+	return 0;
 }
 
 int pciehp_get_latch_status(struct slot *slot, u8 *status)
 {
-	struct controller *ctrl = slot->ctrl;
-	struct pci_dev *pdev = ctrl_dev(ctrl);
+	struct pci_dev *pdev = ctrl_dev(slot->ctrl);
 	u16 slot_status;
-	int retval;
 
-	retval = pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
-	if (retval) {
-		ctrl_err(ctrl, "%s: Cannot read SLOTSTATUS register\n",
-			 __func__);
-		return retval;
-	}
+	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
 	*status = !!(slot_status & PCI_EXP_SLTSTA_MRLSS);
 	return 0;
 }
 
 int pciehp_get_adapter_status(struct slot *slot, u8 *status)
 {
-	struct controller *ctrl = slot->ctrl;
-	struct pci_dev *pdev = ctrl_dev(ctrl);
+	struct pci_dev *pdev = ctrl_dev(slot->ctrl);
 	u16 slot_status;
-	int retval;
 
-	retval = pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
-	if (retval) {
-		ctrl_err(ctrl, "%s: Cannot read SLOTSTATUS register\n",
-			 __func__);
-		return retval;
-	}
+	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
 	*status = !!(slot_status & PCI_EXP_SLTSTA_PDS);
 	return 0;
 }
 
 int pciehp_query_power_fault(struct slot *slot)
 {
-	struct controller *ctrl = slot->ctrl;
-	struct pci_dev *pdev = ctrl_dev(ctrl);
+	struct pci_dev *pdev = ctrl_dev(slot->ctrl);
 	u16 slot_status;
-	int retval;
 
-	retval = pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
-	if (retval) {
-		ctrl_err(ctrl, "Cannot check for power fault\n");
-		return retval;
-	}
+	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
 	return !!(slot_status & PCI_EXP_SLTSTA_PFD);
 }
 
@@ -570,25 +504,13 @@ int pciehp_power_on_slot(struct slot * slot)
 	u16 slot_cmd;
 	u16 cmd_mask;
 	u16 slot_status;
-	int retval = 0;
+	int retval;
 
 	/* Clear sticky power-fault bit from previous power failures */
-	retval = pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
-	if (retval) {
-		ctrl_err(ctrl, "%s: Cannot read SLOTSTATUS register\n",
-			 __func__);
-		return retval;
-	}
+	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
 	slot_status &= PCI_EXP_SLTSTA_PFD;
-	if (slot_status) {
-		retval = pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, slot_status);
-		if (retval) {
-			ctrl_err(ctrl,
-				 "%s: Cannot write to SLOTSTATUS register\n",
-				 __func__);
-			return retval;
-		}
-	}
+	if (slot_status)
+		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, slot_status);
 	ctrl->power_fault_detected = 0;
 
 	slot_cmd = POWER_ON;
@@ -649,12 +571,7 @@ static irqreturn_t pcie_isr(int irq, void *dev_id)
 	 */
 	intr_loc = 0;
 	do {
-		if (pcie_capability_read_word(pdev, PCI_EXP_SLTSTA,
-					      &detected)) {
-			ctrl_err(ctrl, "%s: Cannot read SLOTSTATUS\n",
-				 __func__);
-			return IRQ_NONE;
-		}
+		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &detected);
 
 		detected &= (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
 			     PCI_EXP_SLTSTA_MRLSC | PCI_EXP_SLTSTA_PDC |
@@ -663,13 +580,9 @@ static irqreturn_t pcie_isr(int irq, void *dev_id)
 		intr_loc |= detected;
 		if (!intr_loc)
 			return IRQ_NONE;
-		if (detected &&
-		    pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
-					       intr_loc)) {
-			ctrl_err(ctrl, "%s: Cannot write to SLOTSTATUS\n",
-				 __func__);
-			return IRQ_NONE;
-		}
+		if (detected)
+			pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
+						   intr_loc);
 	} while (detected);
 
 	ctrl_dbg(ctrl, "%s: intr_loc %x\n", __func__, intr_loc);
@@ -894,11 +807,7 @@ struct controller *pcie_init(struct pcie_device *dev)
 		goto abort;
 	}
 	ctrl->pcie = dev;
-	if (pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &slot_cap)) {
-		ctrl_err(ctrl, "Cannot read SLOTCAP register\n");
-		goto abort_ctrl;
-	}
-
+	pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &slot_cap);
 	ctrl->slot_cap = slot_cap;
 	mutex_init(&ctrl->ctrl_lock);
 	init_waitqueue_head(&ctrl->queue);
@@ -914,18 +823,14 @@ struct controller *pcie_init(struct pcie_device *dev)
 	    ctrl->no_cmd_complete = 1;
 
         /* Check if Data Link Layer Link Active Reporting is implemented */
-        if (pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &link_cap)) {
-                ctrl_err(ctrl, "%s: Cannot read LNKCAP register\n", __func__);
-                goto abort_ctrl;
-        }
+        pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &link_cap);
         if (link_cap & PCI_EXP_LNKCAP_DLLLARC) {
                 ctrl_dbg(ctrl, "Link Active Reporting supported\n");
                 ctrl->link_active_reporting = 1;
         }
 
 	/* Clear all remaining event bits in Slot Status register */
-	if (pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, 0x1f))
-		goto abort_ctrl;
+	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, 0x1f);
 
 	/* Disable software notification */
 	pcie_disable_notification(ctrl);

