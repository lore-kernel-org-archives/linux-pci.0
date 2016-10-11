Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:19510 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751939AbcJKT3H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Oct 2016 15:29:07 -0400
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Jon Derrick <jonathan.derrick@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH] pci: Don't set power fault if controller not present
Date: Tue, 11 Oct 2016 15:39:07 -0400
Message-Id: <1476214747-10428-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The pciehp control only clears the saved power fault detected if power
controller control is present, but there is no requirement that the
capability exist in order to observe power faults. This means a hot-added
device in a slot that had experienced a power fault at some point would
never be able to add a new device since the power fault detected would
be on permanently.

This patch sets the sticky field only if there is a chance it can
be cleared later.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index b57fc6d..b083e1c 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -631,7 +631,8 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 
 	/* Check Power Fault Detected */
 	if ((events & PCI_EXP_SLTSTA_PFD) && !ctrl->power_fault_detected) {
-		ctrl->power_fault_detected = 1;
+		if (POWER_CTRL(ctrl))
+			ctrl->power_fault_detected = 1;
 		ctrl_err(ctrl, "Slot(%s): Power fault\n", slot_name(slot));
 		pciehp_queue_interrupt_event(slot, INT_POWER_FAULT);
 	}
-- 
2.7.2

