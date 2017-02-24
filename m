Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ashok Raj <ashok.raj@intel.com>,
        james puthukattukaran <james.puthukattukaran@oracle.com>,
        Yinghai Lu <yinghai.lu@oracle.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH] PCI,pciehp: Skip not changed command write
Date: Thu, 23 Feb 2017 22:54:49 -0800
Message-Id: <20170224065449.14997-1-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Notice two systems with different cpu hve different print out when power on
slots:
First one:
 pciehp 0000:60:03.2:pcie004: pciehp_green_led_on: SLOTCTRL a8 write cmd 100
 pciehp 0000:60:03.2:pcie004: pciehp_set_attention_status: SLOTCTRL a8 write cmd c0
 pciehp 0000:60:03.2:pcie004: pending interrupts 0x0010 from Slot Status

Second one:
 pciehp 0000:73:00.0:pcie004: pciehp_green_led_on: SLOTCTRL a8 write cmd 100
 pciehp 0000:73:00.0:pcie004: pciehp_set_attention_status: SLOTCTRL a8 write cmd c0
 pciehp 0000:73:00.0:pcie004: pending interrupts 0x0010 from Slot Status
 pciehp 0000:73:00.0:pcie004: pending interrupts 0x0010 from Slot Status

Actually attention is not changed on both.

First one will not generate CC if write not change cmd.
Second one will generate CC even if write not change cmd.

To avoid those difference interrupts, check if we are trying to
write same cmd, if so skip writing.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/hotplug/pciehp_hpc.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
===================================================================
--- linux-2.6.orig/drivers/pci/hotplug/pciehp_hpc.c
+++ linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
@@ -186,7 +186,7 @@ static void pcie_do_write_cmd(struct con
 			      u16 mask, bool wait)
 {
 	struct pci_dev *pdev = ctrl_dev(ctrl);
-	u16 slot_ctrl;
+	u16 slot_ctrl, old_slot_ctrl;
 
 	mutex_lock(&ctrl->ctrl_lock);
 
@@ -201,8 +201,14 @@ static void pcie_do_write_cmd(struct con
 		goto out;
 	}
 
+	old_slot_ctrl = slot_ctrl;
 	slot_ctrl &= ~mask;
 	slot_ctrl |= (cmd & mask);
+	if (slot_ctrl == old_slot_ctrl) {
+		ctrl_dbg(ctrl, "%s: mask/cmd %x/%x no change\n", __func__,
+			 mask, cmd & mask);
+		goto out;
+	}
 	ctrl->cmd_busy = 1;
 	smp_mb();
 	pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, slot_ctrl);
