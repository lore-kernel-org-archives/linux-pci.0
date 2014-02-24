Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:23547 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900AbaBXX6E (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2014 18:58:04 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH] pciehp: only wait command complete for really hotplug control
Date: Mon, 24 Feb 2014 15:59:27 -0800
Message-Id: <1393286367-16482-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On system with 16 PCI express hotplug slots, customer complain every slot
will report "Command not completed in 1000 msec" during initialization.

Intel says that we should only wait command complete only for
           Electromechanical Interlock Control
           Power Controller Control
           Power Indicator Control
           Attention Indicator Control

System with AMD/Nvidia chipset have same problem.

So change to only wait when following bits get changed.
	PCI_EXP_SLTCTL_EIC
	PCI_EXP_SLTCTL_PCC
	PCI_EXP_SLTCTL_PIC
	PCI_EXP_SLTCTL_AIC

With that we could set 16 seconds during booting, later with 32 sockets system
with 64 pcie hotplug slots we could save 64 seconds.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 drivers/pci/hotplug/pciehp_hpc.c |   11 ++++++-----
 include/uapi/linux/pci_regs.h    |    5 +++++
 2 files changed, 11 insertions(+), 5 deletions(-)

Index: linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
===================================================================
--- linux-2.6.orig/drivers/pci/hotplug/pciehp_hpc.c
+++ linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
@@ -152,8 +152,8 @@ static void pcie_wait_cmd(struct control
 static void pcie_write_cmd(struct controller *ctrl, u16 cmd, u16 mask)
 {
 	struct pci_dev *pdev = ctrl_dev(ctrl);
+	u16 slot_ctrl, old_slot_ctrl;
 	u16 slot_status;
-	u16 slot_ctrl;
 
 	mutex_lock(&ctrl->ctrl_lock);
 
@@ -181,9 +181,8 @@ static void pcie_write_cmd(struct contro
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
@@ -191,7 +190,9 @@ static void pcie_write_cmd(struct contro
 	/*
 	 * Wait for command completion.
 	 */
-	if (!ctrl->no_cmd_complete) {
+	if (!ctrl->no_cmd_complete &&
+	    ((PCI_EXP_SLTCTL_WAIT_MASK & old_slot_ctrl) !=
+	     (PCI_EXP_SLTCTL_WAIT_MASK & slot_ctrl))) {
 		int poll = 0;
 		/*
 		 * if hotplug interrupt is not enabled or command
Index: linux-2.6/include/uapi/linux/pci_regs.h
===================================================================
--- linux-2.6.orig/include/uapi/linux/pci_regs.h
+++ linux-2.6/include/uapi/linux/pci_regs.h
@@ -535,6 +535,11 @@
 #define  PCI_EXP_SLTCTL_PWR_OFF        0x0400 /* Power Off */
 #define  PCI_EXP_SLTCTL_EIC	0x0800	/* Electromechanical Interlock Control */
 #define  PCI_EXP_SLTCTL_DLLSCE	0x1000	/* Data Link Layer State Changed Enable */
+/* only need to wait command complete for hpc related */
+#define  PCI_EXP_SLTCTL_WAIT_MASK (PCI_EXP_SLTCTL_EIC | \
+				   PCI_EXP_SLTCTL_PCC | \
+				   PCI_EXP_SLTCTL_PIC | \
+				   PCI_EXP_SLTCTL_AIC)
 #define PCI_EXP_SLTSTA		26	/* Slot Status */
 #define  PCI_EXP_SLTSTA_ABP	0x0001	/* Attention Button Pressed */
 #define  PCI_EXP_SLTSTA_PFD	0x0002	/* Power Fault Detected */
