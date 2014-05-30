Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:30910 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755432AbaE3XHT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 30 May 2014 19:07:19 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v5] pciehp: only wait command complete for really hotplug control
Date: Fri, 30 May 2014 16:06:59 -0700
Message-Id: <1401491219-1496-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On system with 16 PCI express hotplug slots, customer complain every slot
will report "Command not completed in 1000 msec" during initialization.

Intel says that we should only wait command complete only for
           Electromechanical Interlock Control
           Power Controller Control
           Power Indicator Control
           Attention Indicator Control

For detail please check CF118 on
  http://www.intel.com/content/www/us/en/processors/xeon/xeon-e7-v2-spec-update.html

To address the problem:
change to only wait when (EIC, PCC, PIC, AIC) bits get changed.

With that we could save 16 seconds during booting, later with 32 sockets system
with 64 pcie hotplug slots we could save 64 seconds.

-v5: only add checking for intel chipset.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 drivers/pci/hotplug/pciehp.h     |    1 +
 drivers/pci/hotplug/pciehp_hpc.c |   25 ++++++++++++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

Index: linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
===================================================================
--- linux-2.6.orig/drivers/pci/hotplug/pciehp_hpc.c
+++ linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
@@ -143,6 +143,11 @@ static void pcie_wait_cmd(struct control
 		ctrl_dbg(ctrl, "Command not completed in 1000 msec\n");
 }
 
+/* Some vendors only set CC for real hotplug events */
+#define  PCI_EXP_SLTCTL_REAL_WAIT_MASK (PCI_EXP_SLTCTL_EIC | \
+					PCI_EXP_SLTCTL_PCC | \
+					PCI_EXP_SLTCTL_PIC | \
+					PCI_EXP_SLTCTL_AIC)
 /**
  * pcie_write_cmd - Issue controller command
  * @ctrl: controller to which the command is issued
@@ -152,8 +157,9 @@ static void pcie_wait_cmd(struct control
 static void pcie_write_cmd(struct controller *ctrl, u16 cmd, u16 mask)
 {
 	struct pci_dev *pdev = ctrl_dev(ctrl);
+	u16 slot_ctrl, old_slot_ctrl;
 	u16 slot_status;
-	u16 slot_ctrl;
+	int wait = 1;
 
 	mutex_lock(&ctrl->ctrl_lock);
 
@@ -181,9 +187,8 @@ static void pcie_write_cmd(struct contro
 		}
 	}
 
-	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
-	slot_ctrl &= ~mask;
-	slot_ctrl |= (cmd & mask);
+	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &old_slot_ctrl);
+	slot_ctrl = (old_slot_ctrl & ~mask) | (cmd & mask);
 	ctrl->cmd_busy = 1;
 	smp_mb();
 	pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, slot_ctrl);
@@ -191,7 +196,13 @@ static void pcie_write_cmd(struct contro
 	/*
 	 * Wait for command completion.
 	 */
-	if (!ctrl->no_cmd_complete) {
+	if (ctrl->no_cmd_complete)
+		wait = 0;
+	else if (ctrl->real_cmd_complete &&
+		 ((PCI_EXP_SLTCTL_REAL_WAIT_MASK & old_slot_ctrl) ==
+		  (PCI_EXP_SLTCTL_REAL_WAIT_MASK & slot_ctrl)))
+		wait = 0;
+	if (wait) {
 		int poll = 0;
 		/*
 		 * if hotplug interrupt is not enabled or command
@@ -783,6 +794,10 @@ struct controller *pcie_init(struct pcie
 	    !(POWER_CTRL(ctrl) | ATTN_LED(ctrl) | PWR_LED(ctrl) | EMI(ctrl)))
 	    ctrl->no_cmd_complete = 1;
 
+	/* Intel current only support "real" hotplug event with CC */
+	if (pdev->vendor == PCI_VENDOR_ID_INTEL)
+		ctrl->real_cmd_complete = 1;
+
         /* Check if Data Link Layer Link Active Reporting is implemented */
         pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &link_cap);
         if (link_cap & PCI_EXP_LNKCAP_DLLLARC) {
Index: linux-2.6/drivers/pci/hotplug/pciehp.h
===================================================================
--- linux-2.6.orig/drivers/pci/hotplug/pciehp.h
+++ linux-2.6/drivers/pci/hotplug/pciehp.h
@@ -97,6 +97,7 @@ struct controller {
 	unsigned int no_cmd_complete:1;
 	unsigned int link_active_reporting:1;
 	unsigned int notification_enabled:1;
+	unsigned int real_cmd_complete:1;
 	unsigned int power_fault_detected;
 };
 
