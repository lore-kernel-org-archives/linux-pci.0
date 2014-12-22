Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12811 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754460AbaLVTHG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 22 Dec 2014 14:07:06 -0500
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Keith Busch <keith.busch@intel.com>
Subject: [PATCH] pci: Use hot-plug capable for testing presence on
Date: Mon, 22 Dec 2014 12:07:03 -0700
Message-Id: <1419275223-14602-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCI-e Base specifically says Hot-Plug Surprise capability is for
removal only, but pciehp checked this to determine if it should handle a
slot event on device add. Lots of platform's pcie slots don't advertise
support for surprise removal, but are perfectly capable of handling
hot-add, so checking surprise removal is not appropriate.

This patch checks the Hot-Plug Capable bit in the slot capabilities to
determine if the detected presence on is a reliable event instead of
Hot-Plug Surprise.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/hotplug/pciehp.h      |    1 +
 drivers/pci/hotplug/pciehp_ctrl.c |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index b115219..b91eefb 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -126,6 +126,7 @@ struct controller {
 #define ATTN_LED(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_AIP)
 #define PWR_LED(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_PIP)
 #define HP_SUPR_RM(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_HPS)
+#define HP_CAP(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_HPC)
 #define EMI(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_EIP)
 #define NO_CMD_CMPL(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_NCCS)
 #define PSN(ctrl)		(((ctrl)->slot_cap & PCI_EXP_SLTCAP_PSN) >> 19)
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index ff32e85..996c313 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -532,7 +532,7 @@ static void interrupt_event_handler(struct work_struct *work)
 		pciehp_green_led_off(p_slot);
 		break;
 	case INT_PRESENCE_ON:
-		if (!HP_SUPR_RM(ctrl))
+		if (!HP_CAP(ctrl))
 			break;
 		ctrl_dbg(ctrl, "Surprise Insertion\n");
 		handle_surprise_event(p_slot);
-- 
1.7.10.4

