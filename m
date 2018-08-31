Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:14103 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727416AbeIABet (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Aug 2018 21:34:49 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 12/16] PCI/pciehp: Fix powerfault detection order
Date: Fri, 31 Aug 2018 15:26:35 -0600
Message-Id: <20180831212639.10196-13-keith.busch@intel.com>
In-Reply-To: <20180831212639.10196-1-keith.busch@intel.com>
References: <20180831212639.10196-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A device add in a power controller controlled slot will power on and
clear power fault slot events, but this was happening before the interrupt
handler attempted to set the sticky status and attention indicators. The
wrong status will be set if a hot-add and power fault are handled in
one interrupt. This patch fixes that by checking for power faults before
checking for new devices.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 7136e3430925..c6116e516e1e 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -646,6 +646,14 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 		pciehp_handle_button_press(slot);
 	}
 
+	/* Check Power Fault Detected */
+	if ((events & PCI_EXP_SLTSTA_PFD) && !ctrl->power_fault_detected) {
+		ctrl->power_fault_detected = 1;
+		ctrl_err(ctrl, "Slot(%s): Power fault\n", slot_name(slot));
+		pciehp_set_attention_status(slot, 1);
+		pciehp_green_led_off(slot);
+	}
+
 	/*
 	 * Disable requests have higher priority than Presence Detect Changed
 	 * or Data Link Layer State Changed events.
@@ -657,14 +665,6 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 		pciehp_handle_presence_or_link_change(slot, events);
 	up_read(&ctrl->reset_lock);
 
-	/* Check Power Fault Detected */
-	if ((events & PCI_EXP_SLTSTA_PFD) && !ctrl->power_fault_detected) {
-		ctrl->power_fault_detected = 1;
-		ctrl_err(ctrl, "Slot(%s): Power fault\n", slot_name(slot));
-		pciehp_set_attention_status(slot, 1);
-		pciehp_green_led_off(slot);
-	}
-
 	pci_config_pm_runtime_put(pdev);
 	wake_up(&ctrl->requester);
 	return IRQ_HANDLED;
-- 
2.14.4
