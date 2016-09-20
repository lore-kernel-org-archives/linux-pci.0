Return-Path: <jonathan.derrick@intel.com>
Return-Path: <jonathan.derrick@intel.com>
From: Jon Derrick <jonathan.derrick@intel.com>
To: helgaas@kernel.org
Cc: Jon Derrick <jonathan.derrick@intel.com>,
	keith.busch@intel.com,
	linux-pci@vger.kernel.org
Subject: [RFC] PCI/Hotplug: Clear power fault detected when servicing faults
Date: Tue, 20 Sep 2016 16:10:37 -0600
Message-Id: <1474409437-20464-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

A slot is allowed to implement power fault detection without having a
power controller present. Current code can set the controller's
power_fault_detected when seeing a power fault interrupt, but cannot
clear the flag without a power controller present. This patch clears the
flag when the power fault event is serviced by the interrupt event
handler.

This is mostly based on my interpretation of the spec for Slot Status's
PFD and Slot Cap's PCP. The relevant pieces are at [1] and [2].

[1]: PCIe r3.1a 7.8.11: Slot Status PFD description:
Note that, depending on hardware capability, it is possible that a power
fault can be detected at any time, independent of the Power Controller
Control setting or the occupancy of the slot.

[2]: PCIe r3.1a 6.7.2.4: Power Fault Detected description seems to imply
that the status bit is independent of the Power Controller Present and
Control bits.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/hotplug/pciehp_ctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index b413c3c..898a82a 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -381,6 +381,7 @@ static void interrupt_event_handler(struct work_struct *work)
 		handle_button_press_event(p_slot);
 		break;
 	case INT_POWER_FAULT:
+		ctrl->power_fault_detected = 0;
 		if (!POWER_CTRL(ctrl))
 			break;
 		pciehp_set_attention_status(p_slot, 1);
-- 
1.8.3.1
