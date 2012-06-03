Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([80.244.247.6]:47046 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754019Ab2FCT0r (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 3 Jun 2012 15:26:47 -0400
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: linux-pci@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Michal Marek <mmarek@suse.cz>,
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: [PATCH 3/9] pci/quirks: move PCI fixup hooks from __init to __devinit
Date: Sun,  3 Jun 2012 20:48:19 +0200
Message-Id: <1338749305-22558-4-git-send-email-sebastian@breakpoint.cc>
In-Reply-To: <1338749305-22558-1-git-send-email-sebastian@breakpoint.cc>
References: <1338749305-22558-1-git-send-email-sebastian@breakpoint.cc>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The fixups are executed once the pci-device is found which is during
boot process so __init seems fine as long as the platform does not
support hotplug.
However it is possible to remove the PCI bus at run time and have it
rediscovered again via "echo 1 > /sys/bus/pci/rescan" and this will call
the fixups again.

Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
 drivers/pci/quirks.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 2a75216..993cec8 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -253,7 +253,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C576,	quirk_vsfx)
  *	workaround applied too
  *	[Info kindly provided by ALi]
  */	
-static void __init quirk_alimagik(struct pci_dev *dev)
+static void __devinit quirk_alimagik(struct pci_dev *dev)
 {
 	if ((pci_pci_problems&PCIPCI_ALIMAGIK)==0) {
 		dev_info(&dev->dev, "Limiting direct PCI/PCI transfers\n");
@@ -789,7 +789,7 @@ static void __devinit quirk_amd_ioapic(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_VIPER_7410,	quirk_amd_ioapic);
 
-static void __init quirk_ioapic_rmw(struct pci_dev *dev)
+static void __devinit quirk_ioapic_rmw(struct pci_dev *dev)
 {
 	if (dev->devfn == 0 && dev->bus->number == 0)
 		sis_apic_bug = 1;
@@ -801,7 +801,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI,	PCI_ANY_ID,			quirk_ioapic_rmw);
  * Some settings of MMRBC can lead to data corruption so block changes.
  * See AMD 8131 HyperTransport PCI-X Tunnel Revision Guide
  */
-static void __init quirk_amd_8131_mmrbc(struct pci_dev *dev)
+static void __devinit quirk_amd_8131_mmrbc(struct pci_dev *dev)
 {
 	if (dev->subordinate && dev->revision <= 0x12) {
 		dev_info(&dev->dev, "AMD8131 rev %x detected; "
@@ -1082,7 +1082,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB
 /*
  *	Intel 82801CAM ICH3-M datasheet says IDE modes must be the same
  */
-static void __init quirk_ide_samemode(struct pci_dev *pdev)
+static void __devinit quirk_ide_samemode(struct pci_dev *pdev)
 {
 	u8 prog;
 
@@ -1121,7 +1121,7 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_VIA, PCI_ANY_ID,
 /* This was originally an Alpha specific thing, but it really fits here.
  * The i82375 PCI/EISA bridge appears as non-classified. Fix that.
  */
-static void __init quirk_eisa_bridge(struct pci_dev *dev)
+static void __devinit quirk_eisa_bridge(struct pci_dev *dev)
 {
 	dev->class = PCI_CLASS_BRIDGE_EISA << 8;
 }
@@ -1155,7 +1155,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82375,	quirk_e
  */
 static int asus_hides_smbus;
 
-static void __init asus_hides_smbus_hostbridge(struct pci_dev *dev)
+static void __devinit asus_hides_smbus_hostbridge(struct pci_dev *dev)
 {
 	if (unlikely(dev->subsystem_vendor == PCI_VENDOR_ID_ASUSTEK)) {
 		if (dev->device == PCI_DEVICE_ID_INTEL_82845_HB)
@@ -1538,7 +1538,7 @@ DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB3
 #endif
 
 #ifdef CONFIG_X86_IO_APIC
-static void __init quirk_alder_ioapic(struct pci_dev *pdev)
+static void __devinit quirk_alder_ioapic(struct pci_dev *pdev)
 {
 	int i;
 
@@ -1777,7 +1777,7 @@ DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD,   PCI_DEVICE_ID_AMD_8111_SMBUS, 	qui
  * but the PIO transfers won't work if BAR0 falls at the odd 8 bytes.
  * Re-allocate the region if needed...
  */
-static void __init quirk_tc86c001_ide(struct pci_dev *dev)
+static void __devinit quirk_tc86c001_ide(struct pci_dev *dev)
 {
 	struct resource *r = &dev->resource[0];
 
@@ -2169,7 +2169,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_PLX, 0x8624, quirk_tile_plx_gen1);
  * aware of it.  Instead of setting the flag on all busses in the
  * machine, simply disable MSI globally.
  */
-static void __init quirk_disable_all_msi(struct pci_dev *dev)
+static void __devinit quirk_disable_all_msi(struct pci_dev *dev)
 {
 	pci_no_msi();
 	dev_warn(&dev->dev, "MSI quirk detected; MSI disabled\n");
-- 
1.7.10

