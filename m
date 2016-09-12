Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932160AbcILVJQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Sep 2016 17:09:16 -0400
Subject: [PATCH v2 3/8] PCI: pciehp: Process all hotplug events before
 looking for new ones
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
Date: Mon, 12 Sep 2016 16:09:12 -0500
Message-ID: <20160912210911.22258.70054.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160912210507.22258.63097.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160912210507.22258.63097.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Mayurkumar Patel <mayurkumar.patel@intel.com>

Previously we accumulated hotplug events, then processed them, essentially
like this:

  events = 0
  do {
    status = read(Slot Status)
    status &= EVENT_MASK              # only look at events
    events |= status                  # accumulate events
    write(Slot Status, events)        # clear events
  } while (status)
  process events

The problem is that as soon as we clear events in Slot Status, the hardware
may send notifications for new events, and we lose information about the
first events.  For example, we might see two Presence Detect Changed
events, but lose the fact that the slot was temporarily empty:

  read  PCI_EXP_SLTSTA_PDC set, PCI_EXP_SLTSTA_PDS clear  # slot empty
  write PCI_EXP_SLTSTA_PDC                                # clear PDC event
  read  PCI_EXP_SLTSTA_PDC set, PCI_EXP_SLTSTA_PDS set    # slot occupied

The current code does not process a removal; it only processes the
insertion, which fails because we didn't remove the original device.

To avoid this problem, read Slot Status once and process all the events
before reading it again, like this:

  do {
    read events
    clear events
    process events
  } while (events)

[bhelgaas: changelog, add external loop around pciehp_isr()]
Signed-off-by: Mayurkumar Patel <mayurkumar.patel@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp_hpc.c |   58 +++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index b8efe1b..625fa6a 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -535,7 +535,7 @@ void pciehp_power_off_slot(struct slot *slot)
 		 PCI_EXP_SLTCTL_PWR_OFF);
 }
 
-static irqreturn_t pcie_isr(int irq, void *dev_id)
+static irqreturn_t pciehp_isr(int irq, void *dev_id)
 {
 	struct controller *ctrl = (struct controller *)dev_id;
 	struct pci_dev *pdev = ctrl_dev(ctrl);
@@ -550,36 +550,23 @@ static irqreturn_t pcie_isr(int irq, void *dev_id)
 	if (pdev->current_state == PCI_D3cold)
 		return IRQ_NONE;
 
+	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status);
+	if (status == (u16) ~0) {
+		ctrl_info(ctrl, "%s: no response from device\n", __func__);
+		return IRQ_NONE;
+	}
+
 	/*
-	 * In order to guarantee that all interrupt events are
-	 * serviced, we need to re-inspect Slot Status register after
-	 * clearing what is presumed to be the last pending interrupt.
+	 * Slot Status contains plain status bits as well as event
+	 * notification bits; right now we only want the event bits.
 	 */
-	events = 0;
-	do {
-		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status);
-		if (status == (u16) ~0) {
-			ctrl_info(ctrl, "%s: no response from device\n",
-				  __func__);
-			return IRQ_NONE;
-		}
-
-		/*
-		 * Slot Status contains plain status bits as well as event
-		 * notification bits; right now we only want the event bits.
-		 */
-		status &= (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
+	events = status & (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
 			   PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_CC |
 			   PCI_EXP_SLTSTA_DLLSC);
-		status &= ~events;
-		events |= status;
-		if (!events)
-			return IRQ_NONE;
-		if (status)
-			pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
-						   events);
-	} while (status);
+	if (!events)
+		return IRQ_NONE;
 
+	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, events);
 	ctrl_dbg(ctrl, "pending interrupts %#06x from Slot Status\n", events);
 
 	/* Check Command Complete Interrupt Pending */
@@ -636,6 +623,25 @@ static irqreturn_t pcie_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t pcie_isr(int irq, void *dev_id)
+{
+	irqreturn_t rc, handled = IRQ_NONE;
+
+	/*
+	 * To guarantee that all interrupt events are serviced, we need to
+	 * re-inspect Slot Status register after clearing what is presumed
+	 * to be the last pending interrupt.
+	 */
+	do {
+		rc = pciehp_isr(irq, dev_id);
+		if (rc == IRQ_HANDLED)
+			handled = IRQ_HANDLED;
+	} while (rc == IRQ_HANDLED);
+
+	/* Return IRQ_HANDLED if we handled one or more events */
+	return handled;
+}
+
 void pcie_enable_notification(struct controller *ctrl)
 {
 	u16 cmd, mask;

