Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nat28.tlf.novell.com ([130.57.49.28]:63865 "EHLO
	nat28.tlf.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932947Ab1LFHsv convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-pci@vger.kernel.org:4:1>);
	Tue, 6 Dec 2011 02:48:51 -0500
Message-Id: <4EDDD71A02000078000659F1@nat28.tlf.novell.com>
Date: Tue, 06 Dec 2011 07:49:30 +0000
From: "Jan Beulich" <JBeulich@suse.com>
To: <mingo@elte.hu>, <tglx@linutronix.de>, <hpa@zytor.com>
Cc: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	"Jesse Barnes" <jbarnes@virtuousgeek.org>
Subject: [PATCH] PCI/IO-APIC: allow PCI_IOAPIC to be user configurable
 on x86
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Jesse asked for this to go through the x86 tree, so I'm re-sending it
this way. Also correcting Bjorn's email address.

******************************************************

This adjusts PCI_IOAPIC to be user configurable (possibly as a module)
on x86, since the base architecture code for adding IO-APICs
dynamically isn't there yet (and hence having the code present
everywhere is pretty pointless).

To make this consistent, a MODULE_DEVICE_TABLE() declaration gets
added, the class specifications get corrected (by properly using
PCI_DEVICE_CLASS() intended for purposes like this), and the probe and
remove functions get their sections adjusted.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>

---
 drivers/pci/Kconfig  |    4 ++--
 drivers/pci/ioapic.c |   15 +++++++--------
 2 files changed, 9 insertions(+), 10 deletions(-)

--- 3.2-rc3/drivers/pci/Kconfig
+++ 3.2-rc3-pci-ioapic/drivers/pci/Kconfig
@@ -98,11 +98,11 @@ config PCI_PASID
 	  If unsure, say N.
 
 config PCI_IOAPIC
-	bool
+	tristate "PCI IO-APIC hotplug support" if X86
 	depends on PCI
 	depends on ACPI
 	depends on HOTPLUG
-	default y
+	default !X86
 
 config PCI_LABEL
 	def_bool y if (DMI || ACPI)
--- 3.2-rc3/drivers/pci/ioapic.c
+++ 3.2-rc3-pci-ioapic/drivers/pci/ioapic.c
@@ -17,7 +17,7 @@
  */
 
 #include <linux/pci.h>
-#include <linux/export.h>
+#include <linux/module.h>
 #include <linux/acpi.h>
 #include <linux/slab.h>
 #include <acpi/acpi_bus.h>
@@ -27,7 +27,7 @@ struct ioapic {
 	u32		gsi_base;
 };
 
-static int ioapic_probe(struct pci_dev *dev, const struct pci_device_id *ent)
+static int __devinit ioapic_probe(struct pci_dev *dev, const struct pci_device_id *ent)
 {
 	acpi_handle handle;
 	acpi_status status;
@@ -88,7 +88,7 @@ exit_free:
 	return -ENODEV;
 }
 
-static void ioapic_remove(struct pci_dev *dev)
+static void __devexit ioapic_remove(struct pci_dev *dev)
 {
 	struct ioapic *ioapic = pci_get_drvdata(dev);
 
@@ -99,13 +99,12 @@ static void ioapic_remove(struct pci_dev
 }
 
 
-static struct pci_device_id ioapic_devices[] = {
-	{ PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
-	  PCI_CLASS_SYSTEM_PIC_IOAPIC << 8, 0xffff00, },
-	{ PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
-	  PCI_CLASS_SYSTEM_PIC_IOXAPIC << 8, 0xffff00, },
+static DEFINE_PCI_DEVICE_TABLE(ioapic_devices) = {
+	{ PCI_DEVICE_CLASS(PCI_CLASS_SYSTEM_PIC_IOAPIC, ~0) },
+	{ PCI_DEVICE_CLASS(PCI_CLASS_SYSTEM_PIC_IOXAPIC, ~0) },
 	{ }
 };
+MODULE_DEVICE_TABLE(pci, ioapic_devices);
 
 static struct pci_driver ioapic_driver = {
 	.name		= "ioapic",



