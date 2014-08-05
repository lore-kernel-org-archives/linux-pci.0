Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:52437 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752364AbaHEQMA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Aug 2014 12:12:00 -0400
Received: by mail-wi0-f176.google.com with SMTP id bs8so7254316wib.15
        for <linux-pci@vger.kernel.org>; Tue, 05 Aug 2014 09:11:58 -0700 (PDT)
From: matthew_minter@xyratex.com
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: matthew_minter <matthew_minter@xyratex.com>
Subject: [PATCH 02/22] Modified x86 initialisation to accomodate PCI irq changes
Date: Tue,  5 Aug 2014 17:11:03 +0100
Message-Id: <1407255083-9356-3-git-send-email-matthew_minter@xyratex.com>
In-Reply-To: <1407255083-9356-1-git-send-email-matthew_minter@xyratex.com>
References: <1407255083-9356-1-git-send-email-matthew_minter@xyratex.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: matthew_minter <matthew_minter@xyratex.com>

---
 arch/x86/include/asm/pci_x86.h |  5 ++-
 arch/x86/kernel/x86_init.c     |  1 -
 arch/x86/pci/acpi.c            |  5 ++-
 arch/x86/pci/common.c          |  2 -
 arch/x86/pci/irq.c             | 95 +++++++++++++++++++++++-------------------
 5 files changed, 58 insertions(+), 50 deletions(-)

diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index fa1195d..436b9e5 100644
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
 
@@ -200,7 +201,7 @@ static inline void mmio_config_writel(void __iomem *pos, u32 val)
 #  define x86_default_pci_init		pci_legacy_init
 # endif
 # define x86_default_pci_init_irq	pcibios_irq_init
-# define x86_default_pci_fixup_irqs	pcibios_fixup_irqs
+# define x86_default_pci_fixup_irq	pcibios_fixup_irq
 #else
 # define x86_default_pci_init		NULL
 # define x86_default_pci_init_irq	NULL
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
index 5075371..4ffad2f 100644
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
index 84112f5..0e2cfe8 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -593,9 +593,9 @@ static __init int intel_router_probe(struct irq_router *r, struct pci_dev *route
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
@@ -874,9 +874,8 @@ static struct irq_info *pirq_get_info(struct pci_dev *dev)
 	return NULL;
 }
 
-static int pcibios_lookup_irq(struct pci_dev *dev, int assign)
+static int pcibios_lookup_irq(struct pci_dev *dev, u8 pin, int assign)
 {
-	u8 pin;
 	struct irq_info *info;
 	int i, pirq, newirq;
 	int irq = 0;
@@ -886,7 +885,6 @@ static int pcibios_lookup_irq(struct pci_dev *dev, int assign)
 	char *msg = NULL;
 
 	/* Find IRQ pin */
-	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
 	if (!pin) {
 		dev_dbg(&dev->dev, "no interrupt pin\n");
 		return 0;
@@ -1016,50 +1014,45 @@ static int pcibios_lookup_irq(struct pci_dev *dev, int assign)
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
@@ -1160,6 +1153,13 @@ void __init pcibios_irq_init(void)
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
@@ -1184,12 +1184,19 @@ void pcibios_penalize_isa_irq(int irq, int active)
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
 	u8 pin;
-
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
-	if (pin && !pcibios_lookup_irq(dev, 1)) {
+	if (pin && !pcibios_lookup_irq(dev, pin, 1)) {
 		char *msg = "";
 
 		if (!io_apic_assign_pci_irqs && dev->irq)
-- 
2.0.4

