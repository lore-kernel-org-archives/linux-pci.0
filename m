Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:19700 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755570AbdBQGNQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Feb 2017 01:13:16 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Mayurkumar Patel <mayurkumar.patel@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH] PCI,pciehp: Don't handle PDC for cards with attention button
Date: Thu, 16 Feb 2017 22:12:47 -0800
Message-Id: <20170217061247.5591-1-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On one system during power off slot, find card get power on right away.
 # echo 0 > /sys/bus/pci/slots/1/power
 pci_hotplug: power_write_file: power = 0
 pciehp 0000:16:00.0:pcie004: pciehp_get_power_status: SLOTCTRL a8 value read 11f1
 pciehp 0000:16:00.0:pcie004: pciehp_unconfigure_device: domain:bus:dev = 0000:17:00
 pci 0000:17:00.0: PME# disabled
 pci 0000:17:00.0: freeing pci_dev info
 pciehp 0000:16:00.0:pcie004: pending interrupts 0x0010 from Slot Status
 pciehp 0000:16:00.0:pcie004: pciehp_power_off_slot: SLOTCTRL a8 write cmd 400
 pciehp 0000:16:00.0:pcie004: pending interrupts 0x0108 from Slot Status
 pciehp 0000:16:00.0:pcie004: Slot(1): Link Down
 pciehp 0000:16:00.0:pcie004: Slot(1): Link Down event ignored; already powering off
 pciehp 0000:16:00.0:pcie004: pciehp_green_led_off: SLOTCTRL a8 write cmd 300
 pciehp 0000:16:00.0:pcie004: pending interrupts 0x0018 from Slot Status  <======
 pciehp 0000:16:00.0:pcie004: Slot(1): Card present
 pciehp 0000:16:00.0:pcie004: pciehp_get_power_status: SLOTCTRL a8 value read 17f1
 pciehp 0000:16:00.0:pcie004: pending interrupts 0x0010 from Slot Status
 pciehp 0000:16:00.0:pcie004: pciehp_power_on_slot: SLOTCTRL a8 write cmd 0
 pciehp 0000:16:00.0:pcie004: pciehp_green_led_blink: SLOTCTRL a8 write cmd 200
 pciehp 0000:16:00.0:pcie004: pending interrupts 0x0010 from Slot Status
 pciehp 0000:16:00.0:pcie004: pciehp_check_link_active: lnk_status = f103
 pciehp 0000:16:00.0:pcie004: pending interrupts 0x0108 from Slot Status
 pciehp 0000:16:00.0:pcie004: Slot(1): Link Up
...

Somehow PDC bit get set, and during handling interrupt that is caused by
CC, that PDC also get handled, and the card get powered on again.

In pcie_enable_notification(), we already only enable notification
for PDC when attention button is not there.
So we can safely add checking in pciehp_isr() to skip that PDC handling.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 drivers/pci/hotplug/pciehp_hpc.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
===================================================================
--- linux-2.6.orig/drivers/pci/hotplug/pciehp_hpc.c
+++ linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
@@ -618,8 +618,9 @@ static irqreturn_t pciehp_isr(int irq, v
 		present = !!(status & PCI_EXP_SLTSTA_PDS);
 		ctrl_info(ctrl, "Slot(%s): Card %spresent\n", slot_name(slot),
 			  present ? "" : "not ");
-		pciehp_queue_interrupt_event(slot, present ? INT_PRESENCE_ON :
-					     INT_PRESENCE_OFF);
+		if (!ATTN_BUTTN(ctrl))
+			pciehp_queue_interrupt_event(slot, present ?
+					INT_PRESENCE_ON : INT_PRESENCE_OFF);
 	}
 
 	/* Check Power Fault Detected */
