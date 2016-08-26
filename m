Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 1/2] pciehp: Let user control LED status
Date: Fri, 26 Aug 2016 11:23:01 -0600
Message-Id: <1472232182-1448-2-git-send-email-keith.busch@intel.com>
In-Reply-To: <1472232182-1448-1-git-send-email-keith.busch@intel.com>
References: <1472232182-1448-1-git-send-email-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds a new flag to the pci_dev structure instructing pciehp to
ignore PCIe slot LED indicators. The pciehp driver will instead provide
exclusive attention control to the user by setting the slot control
exactly as the user requested with out interpreting the input. This is
preparing for domain devices that repurpose these for non-standard use.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/hotplug/pciehp.h      |  1 +
 drivers/pci/hotplug/pciehp_core.c | 26 ++++++++++++++++++++++++++
 drivers/pci/hotplug/pciehp_hpc.c  |  6 +++++-
 include/linux/pci.h               |  1 +
 4 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index e764918..ed62645 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -151,6 +151,7 @@ int pciehp_check_link_status(struct controller *ctrl);
 bool pciehp_check_link_active(struct controller *ctrl);
 void pciehp_release_ctrl(struct controller *ctrl);
 int pciehp_reset_slot(struct slot *slot, int probe);
+void pcie_write_cmd_nowait(struct controller *ctrl, u16 cmd, u16 mask);
 
 static inline const char *slot_name(struct slot *slot)
 {
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index ac531e6..ad19b33 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -70,6 +70,8 @@ static int get_attention_status(struct hotplug_slot *slot, u8 *value);
 static int get_latch_status(struct hotplug_slot *slot, u8 *value);
 static int get_adapter_status(struct hotplug_slot *slot, u8 *value);
 static int reset_slot(struct hotplug_slot *slot, int probe);
+static int set_user_led_status(struct hotplug_slot *slot, u8 value);
+static int get_user_led_status(struct hotplug_slot *slot, u8 *value);
 
 /**
  * release_slot - free up the memory used by a slot
@@ -114,6 +116,9 @@ static int init_slot(struct controller *ctrl)
 	if (ATTN_LED(ctrl)) {
 		ops->get_attention_status = get_attention_status;
 		ops->set_attention_status = set_attention_status;
+	} else if (ctrl->pcie->port->user_leds) {
+		ops->get_attention_status = get_user_led_status;
+		ops->set_attention_status = set_user_led_status;
 	}
 
 	/* register this slot with the hotplug pci core */
@@ -142,6 +147,27 @@ static void cleanup_slot(struct controller *ctrl)
 	pci_hp_deregister(ctrl->slot->hotplug_slot);
 }
 
+static int get_user_led_status(struct hotplug_slot *hotplug_slot, u8 *value)
+{
+	u16 slot_ctrl;
+	struct slot *slot = hotplug_slot->private;
+	struct pci_dev *pdev = slot->ctrl->pcie->port;
+
+	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
+	*value = (slot_ctrl & (PCI_EXP_SLTCTL_AIC | PCI_EXP_SLTCTL_PIC)) >> 6;
+
+	return 0;
+}
+
+static int set_user_led_status(struct hotplug_slot *hotplug_slot, u8 status)
+{
+	struct slot *slot = hotplug_slot->private;
+
+	pcie_write_cmd_nowait(slot->ctrl, status << 6,
+			      PCI_EXP_SLTCTL_AIC | PCI_EXP_SLTCTL_PIC);
+	return 0;
+}
+
 /*
  * set_attention_status - Turns the Amber LED for a slot on, off or blink
  */
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 08e84d6..51cfc96 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -228,7 +228,7 @@ static void pcie_write_cmd(struct controller *ctrl, u16 cmd, u16 mask)
 }
 
 /* Same as above without waiting for the hardware to latch */
-static void pcie_write_cmd_nowait(struct controller *ctrl, u16 cmd, u16 mask)
+void pcie_write_cmd_nowait(struct controller *ctrl, u16 cmd, u16 mask)
 {
 	pcie_do_write_cmd(ctrl, cmd, mask, false);
 }
@@ -804,6 +804,10 @@ struct controller *pcie_init(struct pcie_device *dev)
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
index bbca681..a8ba7d7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -309,6 +309,7 @@ struct pci_dev {
 						   powered on/off by the
 						   corresponding bridge */
 	unsigned int	ignore_hotplug:1;	/* Ignore hotplug events */
+	unsigned int	user_leds:1;		/* User excluse LED SlotCtl */
 	unsigned int	d3_delay;	/* D3->D0 transition time in ms */
 	unsigned int	d3cold_delay;	/* D3cold->D0 transition time in ms */
 
-- 
2.7.2
