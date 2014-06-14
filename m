Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:35783 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754064AbaFNVVl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 14 Jun 2014 17:21:41 -0400
Received: by mail-ig0-f177.google.com with SMTP id l13so1659048iga.10
        for <linux-pci@vger.kernel.org>; Sat, 14 Jun 2014 14:21:40 -0700 (PDT)
Subject: [PATCH RFC 4/4] PCI: pciehp: Remove assumptions about which
 commands cause completion events
To: Yinghai Lu <yinghai@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Jan C. Nordholz" <jckn@gmx.net>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Rajat Jain <rajatxjain@gmail.com>, linux-pci@vger.kernel.org
Date: Sat, 14 Jun 2014 15:21:39 -0600
Message-ID: <20140614212139.15202.93232.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140614210740.15202.84719.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140614210740.15202.84719.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We use incorrect logic to decide whether a PCIe hotplug controller
generates command completion events.

5808639bfa98 ("pciehp: fix slow probing") assumed that the Slot Status
"Command Completed" bit was set only for commands affecting slot power,
indicators, or electromechanical interlock.  That assumption is false: per
sec. 6.7.3.2 of PCIe spec r3.0, a write targeting any portion of the Slot
Control register is a command, and (if command completed events are
supported) software must wait for a command to complete before issuing the
next command.

5808639bfa98 was to fix boot-time timeouts (see bugzilla below) on a Lenovo
Thinkpad R61 with an Intel hotplug controller.  The controller probably has
the Intel CF118 erratum, which means it doesn't report Command Completed
unless the Slot Control power, indicator, or interlock bits are changed.
This causes a timeout because pciehp always waits for Command Complete (if
supported), regardless of which bits are changed.

Remove the incorrect logic because the timeouts have been addressed
differently by these changes:

  PCI: pciehp: Wait for hotplug command completion lazily
  PCI: pciehp: Compute timeout from hotplug command start time

Link: https://bugzilla.kernel.org/show_bug.cgi?id=10751
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp_hpc.c |   39 ++++++++------------------------------
 1 file changed, 8 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 18ac24d84f9b..1f70de5359fb 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -161,8 +161,10 @@ static void pcie_wait_cmd(struct controller *ctrl)
 		rc = wait_event_timeout(ctrl->queue, !ctrl->cmd_busy, timeout);
 	else
 		rc = pcie_poll_cmd(ctrl, timeout);
+
 	if (!rc)
-		ctrl_dbg(ctrl, "Command not completed in 1000 msec\n");
+		ctrl_info(ctrl, "Timeout on hotplug command %#010x\n",
+			  ctrl->slot_ctrl);
 }
 
 /**
@@ -174,7 +176,6 @@ static void pcie_wait_cmd(struct controller *ctrl)
 static void pcie_write_cmd(struct controller *ctrl, u16 cmd, u16 mask)
 {
 	struct pci_dev *pdev = ctrl_dev(ctrl);
-	u16 slot_status;
 	u16 slot_ctrl;
 
 	mutex_lock(&ctrl->ctrl_lock);
@@ -182,30 +183,6 @@ static void pcie_write_cmd(struct controller *ctrl, u16 cmd, u16 mask)
 	/* Wait for any previous command that might still be in progress */
 	pcie_wait_cmd(ctrl);
 
-	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
-	if (slot_status & PCI_EXP_SLTSTA_CC) {
-		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
-					   PCI_EXP_SLTSTA_CC);
-		if (!ctrl->no_cmd_complete) {
-			/*
-			 * After 1 sec and CMD_COMPLETED still not set, just
-			 * proceed forward to issue the next command according
-			 * to spec. Just print out the error message.
-			 */
-			ctrl_dbg(ctrl, "CMD_COMPLETED not clear after 1 sec\n");
-		} else if (!NO_CMD_CMPL(ctrl)) {
-			/*
-			 * This controller seems to notify of command completed
-			 * event even though it supports none of power
-			 * controller, attention led, power led and EMI.
-			 */
-			ctrl_dbg(ctrl, "Unexpected CMD_COMPLETED. Need to wait for command completed event\n");
-			ctrl->no_cmd_complete = 0;
-		} else {
-			ctrl_dbg(ctrl, "Unexpected CMD_COMPLETED. Maybe the controller is broken\n");
-		}
-	}
-
 	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
 	slot_ctrl &= ~mask;
 	slot_ctrl |= (cmd & mask);
@@ -785,14 +762,14 @@ struct controller *pcie_init(struct pcie_device *dev)
 	mutex_init(&ctrl->ctrl_lock);
 	init_waitqueue_head(&ctrl->queue);
 	dbg_ctrl(ctrl);
+
 	/*
 	 * Controller doesn't notify of command completion if the "No
-	 * Command Completed Support" bit is set in Slot Capability
-	 * register or the controller supports none of power
-	 * controller, attention led, power led and EMI.
+	 * Command Completed Support" bit is set in Slot Capabilities.
+	 * If set, it means the controller can accept hotplug commands
+	 * with no delay between them.
 	 */
-	if (NO_CMD_CMPL(ctrl) ||
-	    !(POWER_CTRL(ctrl) | ATTN_LED(ctrl) | PWR_LED(ctrl) | EMI(ctrl)))
+	if (NO_CMD_CMPL(ctrl))
 		ctrl->no_cmd_complete = 1;
 
 	/* Check if Data Link Layer Link Active Reporting is implemented */

