Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:35938 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbaCXWMN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 24 Mar 2014 18:12:13 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rajat Jain <rajatxjain@gmail.com>, linux-pci@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v2] pciehp: only wait command complete for real hotplug control
Date: Mon, 24 Mar 2014 15:13:52 -0700
Message-Id: <1395699232-28727-1-git-send-email-yinghai@kernel.org>
In-Reply-To: <CAA93t1rPE3yUh8nAGJDiqeGhixznZdhdyFwRoX_c1VWT3WEtvw@mail.gmail.com>
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

Two ways to address the problem:
1. change to only wait when (EIC, PCC, PIC, AIC) bits get changed.
2. or check CMD_COMPLETE and wait before write command. Only wait
   when CC is set and cmd_busy is true. For chipset from intel
   will only have CC set for real hotplug control, so we could
   skip the wait for others.

This patch is using second way.

With that we could save 16 seconds during booting, later with 32 sockets system
with 64 pcie hotplug slots we could save 64 seconds.

-v2: use second way that is suggested by Bjorn.
     It also solve the problem on Rajat's sytem that have wrong inital CC

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Tested-by: Rajat Jain <rajatxjain@gmail.com>

---
 drivers/pci/hotplug/pciehp_hpc.c |   26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

Index: linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
===================================================================
--- linux-2.6.orig/drivers/pci/hotplug/pciehp_hpc.c
+++ linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
@@ -158,15 +158,8 @@ static void pcie_write_cmd(struct contro
 	mutex_lock(&ctrl->ctrl_lock);
 
 	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
-	if (slot_status & PCI_EXP_SLTSTA_CC) {
-		if (!ctrl->no_cmd_complete) {
-			/*
-			 * After 1 sec and CMD_COMPLETED still not set, just
-			 * proceed forward to issue the next command according
-			 * to spec. Just print out the error message.
-			 */
-			ctrl_dbg(ctrl, "CMD_COMPLETED not clear after 1 sec\n");
-		} else if (!NO_CMD_CMPL(ctrl)) {
+	if (ctrl->no_cmd_complete && slot_status & PCI_EXP_SLTSTA_CC) {
+		if (!NO_CMD_CMPL(ctrl)) {
 			/*
 			 * This controller seems to notify of command completed
 			 * event even though it supports none of power
@@ -182,16 +175,11 @@ static void pcie_write_cmd(struct contro
 	}
 
 	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
-	slot_ctrl &= ~mask;
-	slot_ctrl |= (cmd & mask);
-	ctrl->cmd_busy = 1;
-	smp_mb();
-	pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, slot_ctrl);
-
 	/*
 	 * Wait for command completion.
 	 */
-	if (!ctrl->no_cmd_complete) {
+	if (!ctrl->no_cmd_complete && (slot_status & PCI_EXP_SLTSTA_CC) &&
+	    ctrl->cmd_busy) {
 		int poll = 0;
 		/*
 		 * if hotplug interrupt is not enabled or command
@@ -203,6 +191,12 @@ static void pcie_write_cmd(struct contro
 			poll = 1;
                 pcie_wait_cmd(ctrl, poll);
 	}
+
+	slot_ctrl &= ~mask;
+	slot_ctrl |= (cmd & mask);
+	ctrl->cmd_busy = 1;
+	smp_mb();
+	pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, slot_ctrl);
 	mutex_unlock(&ctrl->ctrl_lock);
 }
 
