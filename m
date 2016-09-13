Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:43925 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758739AbcIMPFm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Sep 2016 11:05:42 -0400
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv3 1/2] pciehp: Let user control LED status
Date: Tue, 13 Sep 2016 09:05:39 -0600
Message-Id: <1473779140-4016-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds a new flag to the pci_dev structure instructing pciehp
to not interpret PCIe slot LED indicators. The pciehp driver will instead
allow all LED control from the user by setting the slot control indicators
as the user requested through sysfs. This is preparing for domain devices
that repurpose these control bits for non-standard use.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
v2 -> v3:

  Moved the slot op's attention status callback to pciehp_hpc.c

 drivers/pci/hotplug/pciehp.h      |  5 +++++
 drivers/pci/hotplug/pciehp_core.c |  3 +++
 drivers/pci/hotplug/pciehp_hpc.c  | 27 +++++++++++++++++++++++++++
 include/linux/pci.h               |  1 +
 4 files changed, 36 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index e764918..7f71ac1 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -152,6 +152,11 @@ bool pciehp_check_link_active(struct controller *ctrl);
 void pciehp_release_ctrl(struct controller *ctrl);
 int pciehp_reset_slot(struct slot *slot, int probe);
 
+int pciehp_set_raw_attention_status(struct hotplug_slot *hotplug_slot,
+								u8 status);
+int pciehp_get_raw_attention_status(struct hotplug_slot *hotplug_slot,
+								u8 *value);
+
 static inline const char *slot_name(struct slot *slot)
 {
 	return hotplug_slot_name(slot->hotplug_slot);
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index fb0f863..68b7aeb 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -113,6 +113,9 @@ static int init_slot(struct controller *ctrl)
 	if (ATTN_LED(ctrl)) {
 		ops->get_attention_status = get_attention_status;
 		ops->set_attention_status = set_attention_status;
+	} else if (ctrl->pcie->port->user_leds) {
+		ops->get_attention_status = pciehp_get_raw_attention_status;
+		ops->set_attention_status = pciehp_set_raw_attention_status;
 	}
 
 	/* register this slot with the hotplug pci core */
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 08e84d6..fccb63d 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -355,6 +355,18 @@ static int pciehp_link_enable(struct controller *ctrl)
 	return __pciehp_link_set(ctrl, true);
 }
 
+int pciehp_get_raw_attention_status(struct hotplug_slot *hotplug_slot,
+								u8 *value)
+{
+	struct slot *slot = hotplug_slot->private;
+	struct pci_dev *pdev = ctrl_dev(slot->ctrl);
+	u16 slot_ctrl;
+
+	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
+	*status = (slot_ctrl & (PCI_EXP_SLTCTL_AIC | PCI_EXP_SLTCTL_PIC)) >> 6;
+	return 0;
+}
+
 void pciehp_get_attention_status(struct slot *slot, u8 *status)
 {
 	struct controller *ctrl = slot->ctrl;
@@ -431,6 +443,17 @@ int pciehp_query_power_fault(struct slot *slot)
 	return !!(slot_status & PCI_EXP_SLTSTA_PFD);
 }
 
+int pciehp_set_raw_attention_status(struct hotplug_slot *hotplug_slot,
+								u8 status)
+{
+	struct slot *slot = hotplug_slot->private;
+	struct controller *ctrl = slot->ctrl;
+
+	pcie_write_cmd_nowait(ctrl, value << 6,
+			      PCI_EXP_SLTCTL_AIC | PCI_EXP_SLTCTL_PIC);
+	return 0;
+}
+
 void pciehp_set_attention_status(struct slot *slot, u8 value)
 {
 	struct controller *ctrl = slot->ctrl;
@@ -804,6 +827,10 @@ struct controller *pcie_init(struct pcie_device *dev)
 	}
 	ctrl->pcie = dev;
 	pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &slot_cap);
+
+	if (pdev->user_leds)
+		slot_cap &= ~(PCI_EXP_SLTCAP_AIP | PCI_EXP_SLTCAP_PIP);
+
 	ctrl->slot_cap = slot_cap;
 	mutex_init(&ctrl->ctrl_lock);
 	init_waitqueue_head(&ctrl->queue);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7256f33..f41bbca 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -308,6 +308,7 @@ struct pci_dev {
 						   powered on/off by the
 						   corresponding bridge */
 	unsigned int	ignore_hotplug:1;	/* Ignore hotplug events */
+	unsigned int	user_leds:1;		/* User excluse LED SlotCtl */
 	unsigned int	d3_delay;	/* D3->D0 transition time in ms */
 	unsigned int	d3cold_delay;	/* D3cold->D0 transition time in ms */
 
-- 
2.7.2

