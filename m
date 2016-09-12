Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755285AbcILVJI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Sep 2016 17:09:08 -0400
Subject: [PATCH v2 1/8] PCI: pciehp: Rename pcie_isr() locals for clarity
To: Mayurkumar Patel <mayurkumar.patel@intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rajat Jain <rajatja@google.com>, MikaWesterberg@linux.intel.com,
        linux-pci@vger.kernel.org,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Luis Antonio Tarazona-Duarte
        <luis.antonio.tarazona-duarte@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        mika.westerberg@linux.intel.com
Date: Mon, 12 Sep 2016 16:08:56 -0500
Message-ID: <20160912210855.22258.32643.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160912210507.22258.63097.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160912210507.22258.63097.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rename "detected" and "intr_loc" to "status" and "events" for clarity.
"status" is the value we read from the Slot Status register; "events" is
the set of hot-plug events we need to process.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp_hpc.c |   46 +++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 08e84d6..264df36 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -542,7 +542,7 @@ static irqreturn_t pcie_isr(int irq, void *dev_id)
 	struct pci_bus *subordinate = pdev->subordinate;
 	struct pci_dev *dev;
 	struct slot *slot = ctrl->slot;
-	u16 detected, intr_loc;
+	u16 status, events;
 	u8 present;
 	bool link;
 
@@ -555,31 +555,35 @@ static irqreturn_t pcie_isr(int irq, void *dev_id)
 	 * serviced, we need to re-inspect Slot Status register after
 	 * clearing what is presumed to be the last pending interrupt.
 	 */
-	intr_loc = 0;
+	events = 0;
 	do {
-		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &detected);
-		if (detected == (u16) ~0) {
+		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status);
+		if (status == (u16) ~0) {
 			ctrl_info(ctrl, "%s: no response from device\n",
 				  __func__);
 			return IRQ_HANDLED;
 		}
 
-		detected &= (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
-			     PCI_EXP_SLTSTA_PDC |
-			     PCI_EXP_SLTSTA_CC | PCI_EXP_SLTSTA_DLLSC);
-		detected &= ~intr_loc;
-		intr_loc |= detected;
-		if (!intr_loc)
+		/*
+		 * Slot Status contains plain status bits as well as event
+		 * notification bits; right now we only want the event bits.
+		 */
+		status &= (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
+			   PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_CC |
+			   PCI_EXP_SLTSTA_DLLSC);
+		status &= ~events;
+		events |= status;
+		if (!events)
 			return IRQ_NONE;
-		if (detected)
+		if (status)
 			pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
-						   intr_loc);
-	} while (detected);
+						   events);
+	} while (status);
 
-	ctrl_dbg(ctrl, "pending interrupts %#06x from Slot Status\n", intr_loc);
+	ctrl_dbg(ctrl, "pending interrupts %#06x from Slot Status\n", events);
 
 	/* Check Command Complete Interrupt Pending */
-	if (intr_loc & PCI_EXP_SLTSTA_CC) {
+	if (events & PCI_EXP_SLTSTA_CC) {
 		ctrl->cmd_busy = 0;
 		smp_mb();
 		wake_up(&ctrl->queue);
@@ -589,24 +593,24 @@ static irqreturn_t pcie_isr(int irq, void *dev_id)
 		list_for_each_entry(dev, &subordinate->devices, bus_list) {
 			if (dev->ignore_hotplug) {
 				ctrl_dbg(ctrl, "ignoring hotplug event %#06x (%s requested no hotplug)\n",
-					 intr_loc, pci_name(dev));
+					 events, pci_name(dev));
 				return IRQ_HANDLED;
 			}
 		}
 	}
 
-	if (!(intr_loc & ~PCI_EXP_SLTSTA_CC))
+	if (!(events & ~PCI_EXP_SLTSTA_CC))
 		return IRQ_HANDLED;
 
 	/* Check Attention Button Pressed */
-	if (intr_loc & PCI_EXP_SLTSTA_ABP) {
+	if (events & PCI_EXP_SLTSTA_ABP) {
 		ctrl_info(ctrl, "Button pressed on Slot(%s)\n",
 			  slot_name(slot));
 		pciehp_queue_interrupt_event(slot, INT_BUTTON_PRESS);
 	}
 
 	/* Check Presence Detect Changed */
-	if (intr_loc & PCI_EXP_SLTSTA_PDC) {
+	if (events & PCI_EXP_SLTSTA_PDC) {
 		pciehp_get_adapter_status(slot, &present);
 		ctrl_info(ctrl, "Card %spresent on Slot(%s)\n",
 			  present ? "" : "not ", slot_name(slot));
@@ -615,13 +619,13 @@ static irqreturn_t pcie_isr(int irq, void *dev_id)
 	}
 
 	/* Check Power Fault Detected */
-	if ((intr_loc & PCI_EXP_SLTSTA_PFD) && !ctrl->power_fault_detected) {
+	if ((events & PCI_EXP_SLTSTA_PFD) && !ctrl->power_fault_detected) {
 		ctrl->power_fault_detected = 1;
 		ctrl_err(ctrl, "Power fault on slot %s\n", slot_name(slot));
 		pciehp_queue_interrupt_event(slot, INT_POWER_FAULT);
 	}
 
-	if (intr_loc & PCI_EXP_SLTSTA_DLLSC) {
+	if (events & PCI_EXP_SLTSTA_DLLSC) {
 		link = pciehp_check_link_active(ctrl);
 		ctrl_info(ctrl, "slot(%s): Link %s event\n",
 			  slot_name(slot), link ? "Up" : "Down");

