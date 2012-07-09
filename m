Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Myron Stowe <myron.stowe@redhat.com>
Subject: [PATCH -v2 7/8] PCI: Move final fixup quirks from __init to __devinit
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, rth@twiddle.net,
	ink@jurassic.park.msu.ru, mattst88@gmail.com, ralf@linux-mips.org,
	tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
	yinghai@kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 09 Jul 2012 15:36:39 -0600
Message-ID: <20120709213639.8975.9566.stgit@amt.stowe>
In-Reply-To: <20120709213554.8975.60552.stgit@amt.stowe>
References: <20120709213554.8975.60552.stgit@amt.stowe>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCI subsystem's final fixups are executed once during boot, after the
pci-device is found.  As long as the system does not support hot-plug,
specifying __init is fine.

With hot-plug, either physically based hot-plug events or pseudo hot-plug
events such as "echo 1 > /sys/bus/pci/rescan", it is possible to remove a
PCI bus during run time and have it rediscovered which will require the
call of the fixups again in order for the device to function properly.

This patch prepares specific quirk(s) for use with hot-plug events.

Signed-off-by: Myron Stowe <myron.stowe@redhat.com>
---

 drivers/pci/quirks.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 8014091..d19e522 100644
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
@@ -2169,7 +2169,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_PLX, 0x8624, quirk_tile_plx_gen1);
  * aware of it.  Instead of setting the flag on all busses in the
  * machine, simply disable MSI globally.
  */
-static void __init quirk_disable_all_msi(struct pci_dev *dev)
+static void __devinit quirk_disable_all_msi(struct pci_dev *dev)
 {
 	pci_no_msi();
 	dev_warn(&dev->dev, "MSI quirk detected; MSI disabled\n");

