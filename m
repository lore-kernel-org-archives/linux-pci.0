Return-Path: <mpatel6@imu.intel.com>
Return-Path: <mpatel6@imu.intel.com>
From: Mayurkumar Patel <mayurkumar.patel@intel.com>
To: helgaas@kernel.org, bhelgaas@google.com
Cc: rajatja@google.com, linux-pci@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com,
        rafael.j.wysocki@intel.com, luis.antonio.tarazona-duarte@intel.com,
        keith.busch@intel.com, mayurkumar.patel@intel.com
Subject: [PATCH v1 2/2] PCI: pciehp: Rework hotplug interrupt routine
Date: Thu, 18 Aug 2016 23:07:59 +0200
Message-Id: <1471554479-42083-2-git-send-email-mayurkumar.patel@intel.com>
In-Reply-To: <1471554479-42083-1-git-send-email-mayurkumar.patel@intel.com>
References: <92EBB4272BF81E4089A7126EC1E7B28466597350@IRSMSX101.ger.corp.intel.com>
 <1471554479-42083-1-git-send-email-mayurkumar.patel@intel.com>
List-ID: <linux-pci.vger.kernel.org>

First scenario, on any slot events, pcie_isr() does as following,
pcie_isr() -> do {...} while(detected) loop in which it
reads PCI_EXP_SLTSTA, stores it in the intr_loc, then
clears respective interrupts by writing to PCI_EXP_SLTSTA.
Again, due to loop, it reads PCI_EXP_SLTSTA, which might
have been changed already for the same type of interrupts
because in the previous iteration they already got cleared.
In this case, it will execute pciehp_queue_interrupt_event() only once
based on the last event happened. This can be problematic
for PCI_EXP_SLTSTA_PDC and PCI_EXP_SLTSTA_DLLSC types of
interrupts as if they miss to process previous events then PCIe device
enumeration can get effected.

Second scenario, pcie_isr() after clearing interrupts, it calls
pciehp_get_adapter_status() before processing PCI_EXP_SLTSTA_PDS
and pciehp_check_link_active() before processing PCI_EXP_SLTSTA_DLLSC
and takes decisions based on that to do pciehp_queue_interrupt_event()
which might also have already got changed due to the same
fact that the respective interrupts got cleared earlier.

The patch is just one proposal. It is just prototype and currently
I don't know it would work any HW.
It removes re-inspection to avoid first scenario happening
and just reads the events once and clears them as soon as possible.
To successfully execute right Slot events for PDC and DLLSC types which
triggered pcie_isr() it reads the PCI_EXP_SLTSTA_PDS and
PCI_EXP_LNKSTA_DLLLA earlier before clearing the respective interrupts
and executes pciehp_queue_interrupt_event() based on the stored
status of these two Slot events.

Signed-off-by: Mayurkumar Patel <mayurkumar.patel@intel.com>
---
 drivers/pci/hotplug/pciehp_hpc.c |   45 ++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 5c24e93..2d01b7d 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -542,36 +542,30 @@ static irqreturn_t pcie_isr(int irq, void *dev_id)
 	struct pci_bus *subordinate = pdev->subordinate;
 	struct pci_dev *dev;
 	struct slot *slot = ctrl->slot;
-	u16 detected, intr_loc;
+	u16 slot_status, intr_loc = 0;
 	u8 present;
 	bool link;

+	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
+	if (slot_status == (u16) ~0) {
+		ctrl_info(ctrl, "%s: no response from device\n",
+			  __func__);
+		return IRQ_HANDLED;
+	}
+	intr_loc = (slot_status & (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
+		     PCI_EXP_SLTSTA_PDC |
+		     PCI_EXP_SLTSTA_CC | PCI_EXP_SLTSTA_DLLSC));
+	if (!intr_loc)
+		return IRQ_NONE;
+
 	/*
-	 * In order to guarantee that all interrupt events are
-	 * serviced, we need to re-inspect Slot Status register after
-	 * clearing what is presumed to be the last pending interrupt.
+	 * update link status before clearing interrupts to process
+	 * it later
 	 */
-	intr_loc = 0;
-	do {
-		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &detected);
-		if (detected == (u16) ~0) {
-			ctrl_info(ctrl, "%s: no response from device\n",
-				  __func__);
-			return IRQ_HANDLED;
-		}
-
-		detected &= (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
-			     PCI_EXP_SLTSTA_PDC |
-			     PCI_EXP_SLTSTA_CC | PCI_EXP_SLTSTA_DLLSC);
-		detected &= ~intr_loc;
-		intr_loc |= detected;
-		if (!intr_loc)
-			return IRQ_NONE;
-		if (detected)
-			pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
-						   intr_loc);
-	} while (detected);
+	if (intr_loc & PCI_EXP_SLTSTA_DLLSC)
+		link = pciehp_check_link_active(ctrl);

+	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, intr_loc);
 	ctrl_dbg(ctrl, "pending interrupts %#06x from Slot Status\n", intr_loc);

 	/* Check Command Complete Interrupt Pending */
@@ -603,7 +597,7 @@ static irqreturn_t pcie_isr(int irq, void *dev_id)

 	/* Check Presence Detect Changed */
 	if (intr_loc & PCI_EXP_SLTSTA_PDC) {
-		pciehp_get_adapter_status(slot, &present);
+		present = !!(slot_status & PCI_EXP_SLTSTA_PDS);
 		ctrl_info(ctrl, "Card %spresent on Slot(%s)\n",
 			  present ? "" : "not ", slot_name(slot));
 		pciehp_queue_interrupt_event(slot, present ? INT_PRESENCE_ON :
@@ -618,7 +612,6 @@ static irqreturn_t pcie_isr(int irq, void *dev_id)
 	}

 	if (intr_loc & PCI_EXP_SLTSTA_DLLSC) {
-		link = pciehp_check_link_active(ctrl);
 		ctrl_info(ctrl, "slot(%s): Link %s event\n",
 			  slot_name(slot), link ? "Up" : "Down");
 		pciehp_queue_interrupt_event(slot, link ? INT_LINK_UP :
--
1.7.9.5
