Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:31888 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365AbaHWBPX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Aug 2014 21:15:23 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH] PCI: fix pcie_wait_cmd with poll mode timeout
Date: Fri, 22 Aug 2014 18:15:08 -0700
Message-Id: <1408756512-16885-2-git-send-email-yinghai@kernel.org>
In-Reply-To: <1408756512-16885-1-git-send-email-yinghai@kernel.org>
References: <1408756512-16885-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pcie_poll_cmd() take msecs instead of jiffies, need to convert
timeout to msecs.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 drivers/pci/hotplug/pciehp_hpc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
===================================================================
--- linux-2.6.orig/drivers/pci/hotplug/pciehp_hpc.c
+++ linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
@@ -160,7 +160,7 @@ static void pcie_wait_cmd(struct control
 	    ctrl->slot_ctrl & PCI_EXP_SLTCTL_CCIE)
 		rc = wait_event_timeout(ctrl->queue, !ctrl->cmd_busy, timeout);
 	else
-		rc = pcie_poll_cmd(ctrl, timeout);
+		rc = pcie_poll_cmd(ctrl, jiffies_to_msecs(timeout));
 
 	/*
 	 * Controllers with errata like Intel CF118 don't generate
