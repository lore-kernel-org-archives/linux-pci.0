Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Cc: Keith Busch <keith.busch@intel.com>, <stable@vger.kernel.org>,
        Mayurkumar Patel <mayurkumar.patel@intel.com>
Subject: [PATCH] pciehp: Fix infinite interupt handler loop
Date: Tue,  1 Aug 2017 03:11:52 -0400
Message-Id: <1501571512-8362-1-git-send-email-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We've encountered a particular platform that under some circumstances
always has the power fault detected status raised. The pciehp irq handler
would loop forever because it thinks it is handling new events when in
fact the power fault is not new. This patch fixes that by masking off
the power fault status from new events if the driver hasn't seen the
power fault clear from the previous handling attempt.

Fixes: fad214b0aa72 ("PCI: pciehp: Process all hotplug events before looking for new ones")

Cc: <stable@vger.kernel.org> # 4.9+
Cc: Mayurkumar Patel <mayurkumar.patel@intel.com>
Signed-off-by: Keith Busch <keith.busch@intel.com>
---
Resending due to send-email setup error; this patch may appear twice
for some.

 drivers/pci/hotplug/pciehp_hpc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 026830a..8ecbc13 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -583,7 +583,9 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 	 * Slot Status contains plain status bits as well as event
 	 * notification bits; right now we only want the event bits.
 	 */
-	events = status & (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
+	events = status & (PCI_EXP_SLTSTA_ABP |
+			  (ctrl->power_fault_detected ?
+				0 : PCI_EXP_SLTSTA_PFD) |
 			   PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_CC |
 			   PCI_EXP_SLTSTA_DLLSC);
 	if (!events)
-- 
2.5.5
