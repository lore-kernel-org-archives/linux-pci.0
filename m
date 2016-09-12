Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v2 4/8] PCI: pciehp: Don't re-read Slot Status when queuing
 hotplug event
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
Date: Mon, 12 Sep 2016 16:09:20 -0500
Message-ID: <20160912210920.22258.26185.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160912210507.22258.63097.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160912210507.22258.63097.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Mayurkumar Patel <mayurkumar.patel@intel.com>

Previously we read Slot Status to learn about hotplug events, then cleared
the events, then re-read Slot Status to find out what happened.  But Slot
Status might have changed before the second read.

Capture the Slot Status once before clearing the events.  Also capture the
Link Status if we had a link status change.

[bhelgaas: changelog, split to separate patch]
Signed-off-by: Mayurkumar Patel <mayurkumar.patel@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp_hpc.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 625fa6a..fe99b45 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -566,6 +566,10 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 	if (!events)
 		return IRQ_NONE;
 
+	/* Capture link status before clearing interrupts */
+	if (events & PCI_EXP_SLTSTA_DLLSC)
+		link = pciehp_check_link_active(ctrl);
+
 	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, events);
 	ctrl_dbg(ctrl, "pending interrupts %#06x from Slot Status\n", events);
 
@@ -598,7 +602,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 
 	/* Check Presence Detect Changed */
 	if (events & PCI_EXP_SLTSTA_PDC) {
-		pciehp_get_adapter_status(slot, &present);
+		present = !!(status & PCI_EXP_SLTSTA_PDS);
 		ctrl_info(ctrl, "Card %spresent on Slot(%s)\n",
 			  present ? "" : "not ", slot_name(slot));
 		pciehp_queue_interrupt_event(slot, present ? INT_PRESENCE_ON :
@@ -613,7 +617,6 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 	}
 
 	if (events & PCI_EXP_SLTSTA_DLLSC) {
-		link = pciehp_check_link_active(ctrl);
 		ctrl_info(ctrl, "slot(%s): Link %s event\n",
 			  slot_name(slot), link ? "Up" : "Down");
 		pciehp_queue_interrupt_event(slot, link ? INT_LINK_UP :
