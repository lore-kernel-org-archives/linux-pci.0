Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:51785 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365AbaHWBP1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Aug 2014 21:15:27 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH] PCI: print out exact timeout in pciehp for wait_cmd
Date: Fri, 22 Aug 2014 18:15:09 -0700
Message-Id: <1408756512-16885-3-git-send-email-yinghai@kernel.org>
In-Reply-To: <1408756512-16885-1-git-send-email-yinghai@kernel.org>
References: <1408756512-16885-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

debug print out should add back timeout that pass during wait event or
polling.

That now is cached vaule before wait.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 drivers/pci/hotplug/pciehp_hpc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
===================================================================
--- linux-2.6.orig/drivers/pci/hotplug/pciehp_hpc.c
+++ linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
@@ -173,7 +173,7 @@ static void pcie_wait_cmd(struct control
 	if (!rc)
 		ctrl_info(ctrl, "Timeout on hotplug command %#010x (issued %u msec ago)\n",
 			  ctrl->slot_ctrl,
-			  jiffies_to_msecs(now - ctrl->cmd_started));
+			  jiffies_to_msecs(now - ctrl->cmd_started + timeout));
 }
 
 /**
