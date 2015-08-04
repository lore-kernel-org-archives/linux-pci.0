Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:32988 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbbHDX71 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Aug 2015 19:59:27 -0400
Received: by ioii16 with SMTP id i16so33583547ioi.0
        for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2015 16:59:27 -0700 (PDT)
Received: from localhost ([69.71.1.1])
        by smtp.gmail.com with ESMTPSA id 29sm780780iom.2.2015.08.04.16.59.25
        for <linux-pci@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 04 Aug 2015 16:59:25 -0700 (PDT)
Subject: [PATCH 2/2] PCI: pciehp: Remove ignored MRL sensor interrupt events
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 04 Aug 2015 18:59:24 -0500
Message-ID: <20150804235924.15421.63546.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150804235823.15421.71342.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150804235823.15421.71342.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We queued interrupt events for the MRL being opened or closed, but the code
in interrupt_event_handler() that handles these events ignored them.

Stop enabling MRL interrupts and remove the ignored events.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp.h     |   10 ++++------
 drivers/pci/hotplug/pciehp_hpc.c |   17 +++--------------
 2 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index aca84e1..62d6fe6 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -103,12 +103,10 @@ struct controller {
 
 #define INT_PRESENCE_ON			1
 #define INT_PRESENCE_OFF		2
-#define INT_SWITCH_CLOSE		3
-#define INT_SWITCH_OPEN			4
-#define INT_POWER_FAULT			5
-#define INT_BUTTON_PRESS		6
-#define INT_LINK_UP			7
-#define INT_LINK_DOWN			8
+#define INT_POWER_FAULT			3
+#define INT_BUTTON_PRESS		4
+#define INT_LINK_UP			5
+#define INT_LINK_DOWN			6
 
 #define STATIC_STATE			0
 #define BLINKINGON_STATE		1
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 8f3d3cf..5c24e93 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -543,7 +543,7 @@ static irqreturn_t pcie_isr(int irq, void *dev_id)
 	struct pci_dev *dev;
 	struct slot *slot = ctrl->slot;
 	u16 detected, intr_loc;
-	u8 open, present;
+	u8 present;
 	bool link;
 
 	/*
@@ -561,7 +561,7 @@ static irqreturn_t pcie_isr(int irq, void *dev_id)
 		}
 
 		detected &= (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
-			     PCI_EXP_SLTSTA_MRLSC | PCI_EXP_SLTSTA_PDC |
+			     PCI_EXP_SLTSTA_PDC |
 			     PCI_EXP_SLTSTA_CC | PCI_EXP_SLTSTA_DLLSC);
 		detected &= ~intr_loc;
 		intr_loc |= detected;
@@ -594,15 +594,6 @@ static irqreturn_t pcie_isr(int irq, void *dev_id)
 	if (!(intr_loc & ~PCI_EXP_SLTSTA_CC))
 		return IRQ_HANDLED;
 
-	/* Check MRL Sensor Changed */
-	if (intr_loc & PCI_EXP_SLTSTA_MRLSC) {
-		pciehp_get_latch_status(slot, &open);
-		ctrl_info(ctrl, "Latch %s on Slot(%s)\n",
-			  open ? "open" : "close", slot_name(slot));
-		pciehp_queue_interrupt_event(slot, open ? INT_SWITCH_OPEN :
-					     INT_SWITCH_CLOSE);
-	}
-
 	/* Check Attention Button Pressed */
 	if (intr_loc & PCI_EXP_SLTSTA_ABP) {
 		ctrl_info(ctrl, "Button pressed on Slot(%s)\n",
@@ -662,13 +653,11 @@ void pcie_enable_notification(struct controller *ctrl)
 		cmd |= PCI_EXP_SLTCTL_ABPE;
 	else
 		cmd |= PCI_EXP_SLTCTL_PDCE;
-	if (MRL_SENS(ctrl))
-		cmd |= PCI_EXP_SLTCTL_MRLSCE;
 	if (!pciehp_poll_mode)
 		cmd |= PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_CCIE;
 
 	mask = (PCI_EXP_SLTCTL_PDCE | PCI_EXP_SLTCTL_ABPE |
-		PCI_EXP_SLTCTL_MRLSCE | PCI_EXP_SLTCTL_PFDE |
+		PCI_EXP_SLTCTL_PFDE |
 		PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_CCIE |
 		PCI_EXP_SLTCTL_DLLSCE);
 

