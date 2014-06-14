Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:61655 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753034AbaFNVVe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 14 Jun 2014 17:21:34 -0400
Received: by mail-ig0-f182.google.com with SMTP id a13so1661970igq.15
        for <linux-pci@vger.kernel.org>; Sat, 14 Jun 2014 14:21:33 -0700 (PDT)
Subject: [PATCH RFC 3/4] PCI: pciehp: Compute timeout from hotplug command
 start time
To: Yinghai Lu <yinghai@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Jan C. Nordholz" <jckn@gmx.net>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Rajat Jain <rajatxjain@gmail.com>, linux-pci@vger.kernel.org
Date: Sat, 14 Jun 2014 15:21:32 -0600
Message-ID: <20140614212132.15202.29174.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140614210740.15202.84719.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140614210740.15202.84719.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If we issue a hotplug command, go do something else, then come back and
wait for the command to complete, we don't have to wait the whole timeout
period, because some of it elapsed while we were doing something else.

Keep track of the time we issued the command, and wait only until the
timeout period from that point has elapsed.

For controllers with errata like Intel CF118, we previously timed out
before issuing the second hotplug command:

  At time T1 (during boot):
    - Write DLLSCE, ABPE, PDCE, etc. to Slot Control
  At time T2 (hotplug event):
    - Wait for command completion (CC) in Slot Status
    - Timeout because CC is never set in Slot Status
    - Write PCC, PIC, etc. to Slot Control

With this change, we wait until T1 + 1 second instead of T2 + 1 second.
If the hotplug event is more than 1 second after the boot-time
initialization, we won't wait for the timeout at all.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp.h     |    1 +
 drivers/pci/hotplug/pciehp_hpc.c |   23 +++++++++++++++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index f7bc886c20be..c496258cd9a7 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -94,6 +94,7 @@ struct controller {
 	u32 slot_cap;
 	u32 slot_ctrl;
 	struct timer_list poll_timer;
+	unsigned long cmd_started;	/* jiffies */
 	unsigned int cmd_busy:1;
 	unsigned int no_cmd_complete:1;
 	unsigned int link_active_reporting:1;
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index f44fdb5b0b08..18ac24d84f9b 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -104,11 +104,10 @@ static inline void pciehp_free_irq(struct controller *ctrl)
 		free_irq(ctrl->pcie->irq, ctrl);
 }
 
-static int pcie_poll_cmd(struct controller *ctrl)
+static int pcie_poll_cmd(struct controller *ctrl, int timeout)
 {
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_status;
-	int timeout = 1000;
 
 	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
 	if (slot_status & PCI_EXP_SLTSTA_CC) {
@@ -132,7 +131,9 @@ static int pcie_poll_cmd(struct controller *ctrl)
 static void pcie_wait_cmd(struct controller *ctrl)
 {
 	unsigned int msecs = pciehp_poll_mode ? 2500 : 1000;
-	unsigned long timeout = msecs_to_jiffies(msecs);
+	unsigned long duration = msecs_to_jiffies(msecs);
+	unsigned long cmd_timeout = ctrl->cmd_started + duration;
+	unsigned long now, timeout;
 	int rc;
 
 	/*
@@ -142,11 +143,24 @@ static void pcie_wait_cmd(struct controller *ctrl)
 	if (ctrl->no_cmd_complete)
 		return;
 
+	if (!ctrl->cmd_busy)
+		return;
+
+	/*
+	 * Even if the command has already timed out, we want to call
+	 * pcie_poll_cmd() so it can clear PCI_EXP_SLTSTA_CC.
+	 */
+	now = jiffies;
+	if (time_before_eq(cmd_timeout, now))
+		timeout = 1;
+	else
+		timeout = cmd_timeout - now;
+
 	if (ctrl->slot_ctrl & PCI_EXP_SLTCTL_HPIE &&
 	    ctrl->slot_ctrl & PCI_EXP_SLTCTL_CCIE)
 		rc = wait_event_timeout(ctrl->queue, !ctrl->cmd_busy, timeout);
 	else
-		rc = pcie_poll_cmd(ctrl);
+		rc = pcie_poll_cmd(ctrl, timeout);
 	if (!rc)
 		ctrl_dbg(ctrl, "Command not completed in 1000 msec\n");
 }
@@ -198,6 +212,7 @@ static void pcie_write_cmd(struct controller *ctrl, u16 cmd, u16 mask)
 	ctrl->cmd_busy = 1;
 	smp_mb();
 	pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, slot_ctrl);
+	ctrl->cmd_started = jiffies;
 	ctrl->slot_ctrl = slot_ctrl;
 
 	mutex_unlock(&ctrl->ctrl_lock);

