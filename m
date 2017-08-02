Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:9732 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751069AbdHBFIn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Aug 2017 01:08:43 -0400
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Keith Busch <keith.busch@intel.com>
Subject: [PATCH] pciehp: Enable hot plug capable detection
Date: Wed,  2 Aug 2017 01:15:07 -0400
Message-Id: <1501650907-10969-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCIe specification ties presence detect change enabling to the hot plug
capable bit in Slot Capabilities. This capability is not mutally exclusive
with attention buttons, so enabing detection should not be tied it.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/hotplug/pciehp.h     | 1 +
 drivers/pci/hotplug/pciehp_hpc.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 06109d4..610e295 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -120,6 +120,7 @@ struct controller {
 #define ATTN_LED(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_AIP)
 #define PWR_LED(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_PIP)
 #define HP_SUPR_RM(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_HPS)
+#define HP_CAP(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_HPC)
 #define EMI(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_EIP)
 #define NO_CMD_CMPL(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_NCCS)
 #define PSN(ctrl)		(((ctrl)->slot_cap & PCI_EXP_SLTCAP_PSN) >> 19)
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 026830a..43a86ed 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -691,7 +691,7 @@ void pcie_enable_notification(struct controller *ctrl)
 	cmd = PCI_EXP_SLTCTL_DLLSCE;
 	if (ATTN_BUTTN(ctrl))
 		cmd |= PCI_EXP_SLTCTL_ABPE;
-	else
+	if (HP_CAP(ctrl))
 		cmd |= PCI_EXP_SLTCTL_PDCE;
 	if (!pciehp_poll_mode)
 		cmd |= PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_CCIE;
-- 
2.5.5
