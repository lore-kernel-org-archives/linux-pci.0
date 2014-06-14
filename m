Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:61983 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753034AbaFNVVV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 14 Jun 2014 17:21:21 -0400
Received: by mail-ie0-f170.google.com with SMTP id tr6so3688188ieb.29
        for <linux-pci@vger.kernel.org>; Sat, 14 Jun 2014 14:21:20 -0700 (PDT)
Subject: [PATCH RFC 1/4] PCI: pciehp: Make pcie_wait_cmd() self-contained
To: Yinghai Lu <yinghai@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Jan C. Nordholz" <jckn@gmx.net>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Rajat Jain <rajatxjain@gmail.com>, linux-pci@vger.kernel.org
Date: Sat, 14 Jun 2014 15:21:20 -0600
Message-ID: <20140614212120.15202.61424.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140614210740.15202.84719.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140614210740.15202.84719.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pcie_wait_cmd() waits for the controller to finish a hotplug command.  Move
the associated logic (to determine whether waiting is required and whether
we're using interrupts or polling) from pcie_write_cmd() to
pcie_wait_cmd().

No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp.h     |    1 +
 drivers/pci/hotplug/pciehp_hpc.c |   30 ++++++++++++++----------------
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 8e9012dca450..f7bc886c20be 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -92,6 +92,7 @@ struct controller {
 	struct slot *slot;
 	wait_queue_head_t queue;	/* sleep & wake process */
 	u32 slot_cap;
+	u32 slot_ctrl;
 	struct timer_list poll_timer;
 	unsigned int cmd_busy:1;
 	unsigned int no_cmd_complete:1;
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 056841651a80..0e76e9d9d134 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -129,16 +129,24 @@ static int pcie_poll_cmd(struct controller *ctrl)
 	return 0;	/* timeout */
 }
 
-static void pcie_wait_cmd(struct controller *ctrl, int poll)
+static void pcie_wait_cmd(struct controller *ctrl)
 {
 	unsigned int msecs = pciehp_poll_mode ? 2500 : 1000;
 	unsigned long timeout = msecs_to_jiffies(msecs);
 	int rc;
 
-	if (poll)
-		rc = pcie_poll_cmd(ctrl);
-	else
+	/*
+	 * If the controller does not generate notifications for command
+	 * completions, we never need to wait between writes.
+	 */
+	if (ctrl->no_cmd_complete)
+		return;
+
+	if (ctrl->slot_ctrl & PCI_EXP_SLTCTL_HPIE &&
+	    ctrl->slot_ctrl & PCI_EXP_SLTCTL_CCIE)
 		rc = wait_event_timeout(ctrl->queue, !ctrl->cmd_busy, timeout);
+	else
+		rc = pcie_poll_cmd(ctrl);
 	if (!rc)
 		ctrl_dbg(ctrl, "Command not completed in 1000 msec\n");
 }
@@ -187,22 +195,12 @@ static void pcie_write_cmd(struct controller *ctrl, u16 cmd, u16 mask)
 	ctrl->cmd_busy = 1;
 	smp_mb();
 	pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, slot_ctrl);
+	ctrl->slot_ctrl = slot_ctrl;
 
 	/*
 	 * Wait for command completion.
 	 */
-	if (!ctrl->no_cmd_complete) {
-		int poll = 0;
-		/*
-		 * if hotplug interrupt is not enabled or command
-		 * completed interrupt is not enabled, we need to poll
-		 * command completed event.
-		 */
-		if (!(slot_ctrl & PCI_EXP_SLTCTL_HPIE) ||
-		    !(slot_ctrl & PCI_EXP_SLTCTL_CCIE))
-			poll = 1;
-		pcie_wait_cmd(ctrl, poll);
-	}
+	pcie_wait_cmd(ctrl);
 	mutex_unlock(&ctrl->ctrl_lock);
 }
 

