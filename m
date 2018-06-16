Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:56021 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932594AbeFPTfA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jun 2018 15:35:00 -0400
Message-Id: <6a47a05eb9740c4781f3bcea65e54ba208f547be.1529173804.git.lukas@wunner.de>
In-Reply-To: <cover.1529173804.git.lukas@wunner.de>
References: <cover.1529173804.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 16 Jun 2018 21:25:00 +0200
Subject: [PATCH 29/32] PCI: pciehp: Resume parent to D0 on config space access
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Ensure accessibility of a hotplug port's config space when accessed via
sysfs by resuming its parent to D0.

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Yinghai Lu <yinghai@kernel.org>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp_core.c | 14 ++++++++++++++
 drivers/pci/hotplug/pciehp_hpc.c  |  7 +++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 3e73b12ed656..01fcf1fa0f66 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -26,6 +26,8 @@
 #include <linux/interrupt.h>
 #include <linux/time.h>
 
+#include "../pci.h"
+
 /* Global variables */
 bool pciehp_debug;
 bool pciehp_poll_mode;
@@ -126,8 +128,11 @@ static void cleanup_slot(struct controller *ctrl)
 static int set_attention_status(struct hotplug_slot *hotplug_slot, u8 status)
 {
 	struct slot *slot = hotplug_slot->private;
+	struct pci_dev *pdev = slot->ctrl->pcie->port;
 
+	pci_config_pm_runtime_get(pdev);
 	pciehp_set_attention_status(slot, status);
+	pci_config_pm_runtime_put(pdev);
 	return 0;
 }
 
@@ -150,8 +155,11 @@ static int disable_slot(struct hotplug_slot *hotplug_slot)
 static int get_power_status(struct hotplug_slot *hotplug_slot, u8 *value)
 {
 	struct slot *slot = hotplug_slot->private;
+	struct pci_dev *pdev = slot->ctrl->pcie->port;
 
+	pci_config_pm_runtime_get(pdev);
 	pciehp_get_power_status(slot, value);
+	pci_config_pm_runtime_put(pdev);
 	return 0;
 }
 
@@ -166,16 +174,22 @@ static int get_attention_status(struct hotplug_slot *hotplug_slot, u8 *value)
 static int get_latch_status(struct hotplug_slot *hotplug_slot, u8 *value)
 {
 	struct slot *slot = hotplug_slot->private;
+	struct pci_dev *pdev = slot->ctrl->pcie->port;
 
+	pci_config_pm_runtime_get(pdev);
 	pciehp_get_latch_status(slot, value);
+	pci_config_pm_runtime_put(pdev);
 	return 0;
 }
 
 static int get_adapter_status(struct hotplug_slot *hotplug_slot, u8 *value)
 {
 	struct slot *slot = hotplug_slot->private;
+	struct pci_dev *pdev = slot->ctrl->pcie->port;
 
+	pci_config_pm_runtime_get(pdev);
 	pciehp_get_adapter_status(slot, value);
+	pci_config_pm_runtime_put(pdev);
 	return 0;
 }
 
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 4bf7dda433b3..73b1d02a36d0 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -322,7 +322,9 @@ int pciehp_get_raw_indicator_status(struct hotplug_slot *hotplug_slot,
 	struct pci_dev *pdev = ctrl_dev(slot->ctrl);
 	u16 slot_ctrl;
 
+	pci_config_pm_runtime_get(pdev);
 	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
+	pci_config_pm_runtime_put(pdev);
 	*status = (slot_ctrl & (PCI_EXP_SLTCTL_AIC | PCI_EXP_SLTCTL_PIC)) >> 6;
 	return 0;
 }
@@ -333,7 +335,9 @@ void pciehp_get_attention_status(struct slot *slot, u8 *status)
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_ctrl;
 
+	pci_config_pm_runtime_get(pdev);
 	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
+	pci_config_pm_runtime_put(pdev);
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x, value read %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_ctrl);
 
@@ -408,9 +412,12 @@ int pciehp_set_raw_indicator_status(struct hotplug_slot *hotplug_slot,
 {
 	struct slot *slot = hotplug_slot->private;
 	struct controller *ctrl = slot->ctrl;
+	struct pci_dev *pdev = ctrl_dev(ctrl);
 
+	pci_config_pm_runtime_get(pdev);
 	pcie_write_cmd_nowait(ctrl, status << 6,
 			      PCI_EXP_SLTCTL_AIC | PCI_EXP_SLTCTL_PIC);
+	pci_config_pm_runtime_put(pdev);
 	return 0;
 }
 
-- 
2.17.1
