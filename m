Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:60817 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1165096AbdEAMJ6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 May 2017 08:09:58 -0400
Message-Id: <60882c9eb29a5eb0197efd11dd94a2c7cdc43ffa.1493631639.git.lukas@wunner.de>
In-Reply-To: <cover.1493631639.git.lukas@wunner.de>
References: <cover.1493631639.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Mon, 1 May 2017 14:06:39 +0200
Subject: [PATCH 3/5] PCI: pciehp: Resume to D0 on sysfs read access
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ashok Raj <ashok.raj@intel.com>,
        Yinghai Lu <yinghai@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Erik Veijola <erik.veijola@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Krishna Dhulipala <krishnad@fb.com>, Wei Zhang <wzhang@fb.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Ensure accessibility of config space when it is read via sysfs.

Accessibility on write is already covered by the runtime resume in
pcie_do_write_cmd().

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Erik Veijola <erik.veijola@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Krishna Dhulipala <krishnad@fb.com>
Cc: Wei Zhang <wzhang@fb.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp_hpc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 143e2143d62e..70dd9ae4c097 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -369,7 +369,9 @@ int pciehp_get_raw_indicator_status(struct hotplug_slot *hotplug_slot,
 	struct pci_dev *pdev = ctrl_dev(slot->ctrl);
 	u16 slot_ctrl;
 
+	pm_runtime_get_sync(&pdev->dev);
 	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
+	pm_runtime_put(&pdev->dev);
 	*status = (slot_ctrl & (PCI_EXP_SLTCTL_AIC | PCI_EXP_SLTCTL_PIC)) >> 6;
 	return 0;
 }
@@ -380,7 +382,9 @@ void pciehp_get_attention_status(struct slot *slot, u8 *status)
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_ctrl;
 
+	pm_runtime_get_sync(&pdev->dev);
 	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
+	pm_runtime_put(&pdev->dev);
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x, value read %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_ctrl);
 
@@ -406,7 +410,9 @@ void pciehp_get_power_status(struct slot *slot, u8 *status)
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_ctrl;
 
+	pm_runtime_get_sync(&pdev->dev);
 	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
+	pm_runtime_put(&pdev->dev);
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x value read %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_ctrl);
 
@@ -428,7 +434,9 @@ void pciehp_get_latch_status(struct slot *slot, u8 *status)
 	struct pci_dev *pdev = ctrl_dev(slot->ctrl);
 	u16 slot_status;
 
+	pm_runtime_get_sync(&pdev->dev);
 	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
+	pm_runtime_put(&pdev->dev);
 	*status = !!(slot_status & PCI_EXP_SLTSTA_MRLSS);
 }
 
@@ -437,7 +445,9 @@ void pciehp_get_adapter_status(struct slot *slot, u8 *status)
 	struct pci_dev *pdev = ctrl_dev(slot->ctrl);
 	u16 slot_status;
 
+	pm_runtime_get_sync(&pdev->dev);
 	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
+	pm_runtime_put(&pdev->dev);
 	*status = !!(slot_status & PCI_EXP_SLTSTA_PDS);
 }
 
-- 
2.11.0
