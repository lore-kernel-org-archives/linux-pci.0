Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([69.164.217.139]:56339 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751236AbaJBEIA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 2 Oct 2014 00:08:00 -0400
From: matt@masarand.com
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, Matthew Minter <matt@masarand.com>
Subject: [PATCH 02/18] Delayed x86 setup of PCI IRQs to bus scan time
Date: Thu,  2 Oct 2014 05:07:30 +0100
Message-Id: <1412222866-21068-3-git-send-email-matt@masarand.com>
In-Reply-To: <1412222866-21068-1-git-send-email-matt@masarand.com>
References: <1412222866-21068-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Matthew Minter <matt@masarand.com>

The x86 architecture boot code currently traverses the PCI buses with
an extra pass in order to initialise the PCI device IRQs at boot, this
patch avoids this pass and defers the IRQ assignment untill device
enable time which also has the benefit that hot-plugged devices are
assigned IRQs without additional code.

Signed-off-by: Matthew Minter <matt@masarand.com>

---
 arch/x86/include/asm/pci_x86.h |  7 ++--
 arch/x86/kernel/x86_init.c     |  1 -
 arch/x86/pci/acpi.c            |  5 ++-
 arch/x86/pci/common.c          |  2 -
 arch/x86/pci/irq.c             | 94 +++++++++++++++++++++++-------------------
 5 files changed, 59 insertions(+), 50 deletions(-)

diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index fa1195d..16fd8e9 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -90,6 +90,7 @@ extern unsigned int pcibios_irq_mask;
 
 extern raw_spinlock_t pci_config_lock;
 
+extern int pci_map_irq(struct pci_dev *dev, u8 slot, u8 pin);
 extern int (*pcibios_enable_irq)(struct pci_dev *dev);
 extern void (*pcibios_disable_irq)(struct pci_dev *dev);
 
@@ -119,7 +120,7 @@ extern int __init pci_acpi_init(void);
 extern void __init pcibios_irq_init(void);
 extern int __init pcibios_init(void);
 extern int pci_legacy_init(void);
-extern void pcibios_fixup_irqs(void);
+extern int pcibios_fixup_irq(struct pci_dev *dev, u8 pin);
 
 /* pci-mmconfig.c */
 
@@ -200,9 +201,9 @@ static inline void mmio_config_writel(void __iomem *pos, u32 val)
 #  define x86_default_pci_init		pci_legacy_init
 # endif
 # define x86_default_pci_init_irq	pcibios_irq_init
-# define x86_default_pci_fixup_irqs	pcibios_fixup_irqs
+# define x86_default_pci_fixup_irq	pcibios_fixup_irq
 #else
 # define x86_default_pci_init		NULL
 # define x86_default_pci_init_irq	NULL
-# define x86_default_pci_fixup_irqs	NULL
+# define x86_default_pci_fixup_irq	NULL
 #endif
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index e48b674..064457f 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -81,7 +81,6 @@ struct x86_init_ops x86_init __initdata = {
 	.pci = {
 		.init			= x86_default_pci_init,
 		.init_irq		= x86_default_pci_init_irq,
-		.fixup_irqs		= x86_default_pci_fixup_irqs,
 	},
 };
 
diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index cfd1b13..2c433f4 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -311,7 +311,7 @@ static acpi_status setup_resource(struct acpi_resource *acpi_res, void *data)
 	} else if (orig_end != end) {
 		dev_info(&info->bridge->dev,
 			"host bridge window [%#llx-%#llx] "
-			"([%#llx-%#llx] ignored, not CPU addressable)\n", 
+			"([%#llx-%#llx] ignored, not CPU addressable)\n",
 			start, orig_end, end + 1, orig_end);
 	}
 
@@ -571,6 +571,9 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 	struct pci_sysdata *sd = bridge->bus->sysdata;
 
 	ACPI_COMPANION_SET(&bridge->dev, sd->companion);
+
+	bridge->swizzle_irq = NULL;
+	bridge->map_irq = pci_map_irq;
 	return 0;
 }
 
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 059a76c..d4ed0b0 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -662,8 +662,6 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 	if ((err = pci_enable_resources(dev, mask)) < 0)
 		return err;
 
-	if (!pci_dev_msi_enabled(dev))
-		return pcibios_enable_irq(dev);
 	return 0;
 }
 
diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index eb500c2..33d323d 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -594,9 +594,9 @@ static __init int intel_router_probe(struct irq_router *r, struct pci_dev *route
 		return 1;
 	}
 
-	if ((device >= PCI_DEVICE_ID_INTEL_5_3400_SERIES_LPC_MIN && 
-	     device <= PCI_DEVICE_ID_INTEL_5_3400_SERIES_LPC_MAX) 
-	||  (device >= PCI_DEVICE_ID_INTEL_COUGARPOINT_LPC_MIN && 
+	if ((device >= PCI_DEVICE_ID_INTEL_5_3400_SERIES_LPC_MIN &&
+	     device <= PCI_DEVICE_ID_INTEL_5_3400_SERIES_LPC_MAX)
+	||  (device >= PCI_DEVICE_ID_INTEL_COUGARPOINT_LPC_MIN &&
 	     device <= PCI_DEVICE_ID_INTEL_COUGARPOINT_LPC_MAX)
 	||  (device >= PCI_DEVICE_ID_INTEL_DH89XXCC_LPC_MIN &&
 	     device <= PCI_DEVICE_ID_INTEL_DH89XXCC_LPC_MAX)
@@ -875,9 +875,8 @@ static struct irq_info *pirq_get_info(struct pci_dev *dev)
 	return NULL;
 }
 
-static int pcibios_lookup_irq(struct pci_dev *dev, int assign)
+static int pcibios_lookup_irq(struct pci_dev *dev, u8 pin, int assign)
 {
-	u8 pin;
 	struct irq_info *info;
 	int i, pirq, newirq;
 	int irq = 0;
@@ -887,7 +886,6 @@ static int pcibios_lookup_irq(struct pci_dev *dev, int assign)
 	char *msg = NULL;
 
 	/* Find IRQ pin */
-	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
 	if (!pin) {
 		dev_dbg(&dev->dev, "no interrupt pin\n");
 		return 0;
@@ -1017,50 +1015,45 @@ static int pcibios_lookup_irq(struct pci_dev *dev, int assign)
 					 irq, pci_name(dev2));
 		}
 	}
-	return 1;
+	/*
+	 * Due to the complicated platform specific behvaiour we cannot defer
+	 * assigning dev->irq to the caller but will return it anyway
+	 */
+	return dev->irq;
 }
 
-void __init pcibios_fixup_irqs(void)
+int pcibios_fixup_irq(struct pci_dev *dev, u8 pin)
 {
-	struct pci_dev *dev = NULL;
-	u8 pin;
-
+	int irq = dev->irq;
 	DBG(KERN_DEBUG "PCI: IRQ fixup\n");
-	for_each_pci_dev(dev) {
-		/*
-		 * If the BIOS has set an out of range IRQ number, just
-		 * ignore it.  Also keep track of which IRQ's are
-		 * already in use.
-		 */
-		if (dev->irq >= 16) {
-			dev_dbg(&dev->dev, "ignoring bogus IRQ %d\n", dev->irq);
-			dev->irq = 0;
-		}
-		/*
-		 * If the IRQ is already assigned to a PCI device,
-		 * ignore its ISA use penalty
-		 */
-		if (pirq_penalty[dev->irq] >= 100 &&
-				pirq_penalty[dev->irq] < 100000)
-			pirq_penalty[dev->irq] = 0;
-		pirq_penalty[dev->irq]++;
+	/*
+	 * If the BIOS has set an out of range IRQ number, just
+	 * ignore it.  Also keep track of which IRQ's are
+	 * already in use.
+	 */
+	if (irq >= 16) {
+		dev_dbg(&dev->dev, "ignoring bogus IRQ %d\n", irq);
+		irq = 0;
 	}
+	/*
+	 * If the IRQ is already assigned to a PCI device,
+	 * ignore its ISA use penalty
+	 */
+	if (pirq_penalty[irq] >= 100 &&
+			pirq_penalty[irq] < 100000)
+		pirq_penalty[irq] = 0;
+	pirq_penalty[irq]++;
 
-	if (io_apic_assign_pci_irqs)
-		return;
+	if (io_apic_assign_pci_irqs || !pin)
+		return irq;
 
-	dev = NULL;
-	for_each_pci_dev(dev) {
-		pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
-		if (!pin)
-			continue;
+	/*
+	 * Still no IRQ? Try to lookup one...
+	 */
+	if (!irq)
+		irq = pcibios_lookup_irq(dev, pin, 0);
 
-		/*
-		 * Still no IRQ? Try to lookup one...
-		 */
-		if (!dev->irq)
-			pcibios_lookup_irq(dev, 0);
-	}
+	return irq;
 }
 
 /*
@@ -1161,6 +1154,13 @@ void __init pcibios_irq_init(void)
 	}
 }
 
+int __weak pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	bridge->swizzle_irq = NULL;
+	bridge->map_irq = pci_map_irq;
+	return 0;
+}
+
 static void pirq_penalize_isa_irq(int irq, int active)
 {
 	/*
@@ -1185,12 +1185,20 @@ void pcibios_penalize_isa_irq(int irq, int active)
 		pirq_penalize_isa_irq(irq, active);
 }
 
+int pci_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
+{
+	dev->irq = pcibios_fixup_irq(dev, pin);
+	if (pcibios_enable_irq(dev))
+		return -1;
+	return dev->irq;
+}
+
 static int pirq_enable_irq(struct pci_dev *dev)
 {
 	u8 pin = 0;
 
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
-	if (pin && !pcibios_lookup_irq(dev, 1)) {
+	if (pin && !pcibios_lookup_irq(dev, pin, 1)) {
 		char *msg = "";
 
 		if (!io_apic_assign_pci_irqs && dev->irq)
-- 
2.1.0

