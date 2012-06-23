Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:30781 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520Ab2FWHmH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 23 Jun 2012 03:42:07 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 2/5] pciehp: Don't enable presence notification while surprise removal is not supported.
Date: Sat, 23 Jun 2012 00:42:02 -0700
Message-Id: <1340437325-29282-3-git-send-email-yinghai@kernel.org>
In-Reply-To: <1340437325-29282-1-git-send-email-yinghai@kernel.org>
References: <1340437325-29282-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If surprise removal is not supported, that event get dropped later.
So there is no point to enable that.

Also some sick chipset have those bit flip around when the card is not present.
and make log full of useless warning.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/hotplug/pciehp_hpc.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index a960fae..d4fa705 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -808,7 +808,7 @@ int pciehp_get_cur_lnk_width(struct slot *slot,
 
 int pcie_enable_notification(struct controller *ctrl)
 {
-	u16 cmd, mask;
+	u16 cmd = 0, mask;
 
 	/*
 	 * TBD: Power fault detected software notification support.
@@ -820,7 +820,8 @@ int pcie_enable_notification(struct controller *ctrl)
 	 * when it is cleared in the interrupt service routine, and
 	 * next power fault detected interrupt was notified again.
 	 */
-	cmd = PCI_EXP_SLTCTL_PDCE;
+	if (HP_SUPR_RM(ctrl))
+		cmd |= PCI_EXP_SLTCTL_PDCE;
 	if (ATTN_BUTTN(ctrl))
 		cmd |= PCI_EXP_SLTCTL_ABPE;
 	if (MRL_SENS(ctrl))
-- 
1.7.7

