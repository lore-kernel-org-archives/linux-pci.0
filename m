Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ashok Raj <ashok.raj@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 1/3] pciehp: Prioritize data-link event over presence detect
Date: Sat, 19 Nov 2016 00:32:45 -0800
Message-Id: <1479544367-7195-2-git-send-email-ashok.raj@intel.com>
In-Reply-To: <1479544367-7195-1-git-send-email-ashok.raj@intel.com>
References: <1479544367-7195-1-git-send-email-ashok.raj@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch places higher precedence on a Data Link Layer Status Change
event over the Presence Detect Change event in the case the slot status
contains both events in the same interrupt.

When both events are observed, the pciehp driver is currently relying on
the Slot Status Presence Detect State (PDS) agree with the Link Status
Data Link Layer Active status. The Presence Detect State, however, may
be set to 1 through out-of-band presence detect mechanism even though
the link is down, which creates conflicting events.

Since the Link Status accurately reflects the reachability of the down
stream bus, the link change event should take precedence over a present
detect event. This patch skips checking the PDC status we handled a link
event in the same handler.

Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index b57fc6d..e1ebd67 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -620,8 +620,18 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 		pciehp_queue_interrupt_event(slot, INT_BUTTON_PRESS);
 	}
 
-	/* Check Presence Detect Changed */
-	if (events & PCI_EXP_SLTSTA_PDC) {
+	/*
+	 * Check Link Status Changed at higher precedence than Presence Detect
+	 * Changed. The PDS value may be set to "card present" from out-of-band
+	 * detection, which may be in conflict with a Link Down and cause the
+	 * wrong event to queue.
+     */
+	if (events & PCI_EXP_SLTSTA_DLLSC) {
+		ctrl_info(ctrl, "Slot(%s): Link %s\n", slot_name(slot),
+			  link ? "Up" : "Down");
+		pciehp_queue_interrupt_event(slot, link ? INT_LINK_UP :
+					     INT_LINK_DOWN);
+	} else if (events & PCI_EXP_SLTSTA_PDC) {
 		present = !!(status & PCI_EXP_SLTSTA_PDS);
 		ctrl_info(ctrl, "Slot(%s): Card %spresent\n", slot_name(slot),
 			  present ? "" : "not ");
@@ -636,13 +646,6 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 		pciehp_queue_interrupt_event(slot, INT_POWER_FAULT);
 	}
 
-	if (events & PCI_EXP_SLTSTA_DLLSC) {
-		ctrl_info(ctrl, "Slot(%s): Link %s\n", slot_name(slot),
-			  link ? "Up" : "Down");
-		pciehp_queue_interrupt_event(slot, link ? INT_LINK_UP :
-					     INT_LINK_DOWN);
-	}
-
 	return IRQ_HANDLED;
 }
 
-- 
2.7.4
