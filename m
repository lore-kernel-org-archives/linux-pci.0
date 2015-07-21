Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jarod Wilson <jarod@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jarod Wilson <jarod@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH] pci/pciehp: bail on bogus pcie reads from removed devices
Date: Tue, 21 Jul 2015 12:25:30 -0400
Message-Id: <1437495930-7723-1-git-send-email-jarod@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=99841

Seems like a read of all 1's from a register of a device that has gone
away should be taken as a sign that the device has gone away.
Section 6.2.10 of the PCIE spec (v4.0, rev 0.3, Feb 19, 2014) suggests as
much with this snippet:

|IMPLEMENTATION NOTE
|Data Value of All 1’s
|Many platforms, including those supporting RP Extensions for DPC, can
|return a data value of all 1’s to software when an error is associated
|with a PCI Express Configuration, I/O, or Memory Read Request. During DPC,
|the Downstream Port discards Requests destined for the Link and completes
|them with an error (i.e., either with an Unsupported Request (UR) or
|Completer Abort (CA) Completion Status). By ending a series of MMIO or
|configuration space operations with a read to an address with a known
|data value not equal to all 1’s, software may determine if a Completer
|has been removed or DPC has been triggered.

I'm not sure the above is directly relevant to this case, but the same
principle (reading all 1's means the device is probably gone) seems to
hold.

This is based on part of a debugging patch Bjorn posted in the referenced
bugzilla, and its required to make the HP ZBook G2 I've got here not barf
when disconnecting a thunderbolt ethernet adapter and corrupt memory.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CC: linux-pci@vger.kernel.org
Signed-off-by: Jarod Wilson <jarod@redhat.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index bb1d0de..c397851 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -547,6 +547,11 @@ static irqreturn_t pcie_isr(int irq, void *dev_id)
 	do {
 		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &detected);
 
+		if (detected == (u16) ~0) {
+			ctrl_info(ctrl, "Device has gone away\n");
+			return IRQ_HANDLED;
+		}
+
 		detected &= (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
 			     PCI_EXP_SLTSTA_MRLSC | PCI_EXP_SLTSTA_PDC |
 			     PCI_EXP_SLTSTA_CC | PCI_EXP_SLTSTA_DLLSC);
-- 
1.8.3.1

