Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([104.200.29.153]:36218 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096AbbJWFFu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 23 Oct 2015 01:05:50 -0400
From: Matthew Minter <matt@masarand.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	lorenzo.pieralisi@arm.com
Cc: Matthew Minter <matt@masarand.com>
Subject: [PATCH V4 08/29] x86/pci: Defer IRQ assignment to device enable time
Date: Fri, 23 Oct 2015 06:03:41 +0100
Message-Id: <1445576642-29624-9-git-send-email-matt@masarand.com>
In-Reply-To: <1445576642-29624-1-git-send-email-matt@masarand.com>
References: <1445576642-29624-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The x86 architecture boot code currently traverses the PCI buses with
an extra pass in order to initialise the PCI device IRQs at boot, this
patch avoids this pass and defers the IRQ assignment untill device
enable time which also has the benefit that hot-plugged devices are
assigned IRQs without additional code.

Signed-off-by: Matthew Minter <matt@masarand.com>
---
 arch/x86/include/asm/pci_x86.h |  7 +++--
 arch/x86/kernel/x86_init.c     |  1 -
 arch/x86/pci/irq.c             | 70 +++++++++++++++++++++---------------------
 3 files changed, 39 insertions(+), 39 deletions(-)

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
index 3839628..810f1dd 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -80,7 +80,6 @@ struct x86_init_ops x86_init __initdata = {
 	.pci = {
 		.init			= x86_default_pci_init,
 		.init_irq		= x86_default_pci_init_irq,
-		.fixup_irqs		= x86_default_pci_fixup_irqs,
 	},
 };
 
diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index 350e785..15c507b 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -1021,47 +1021,38 @@ static int pcibios_lookup_irq(struct pci_dev *dev, int assign)
 	return 1;
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
+	if (!irq && pcibios_lookup_irq(dev, 0))
+		irq = dev->irq;
 
-		/*
-		 * Still no IRQ? Try to lookup one...
-		 */
-		if (!dev->irq)
-			pcibios_lookup_irq(dev, 0);
-	}
+	return irq;
 }
 
 /*
@@ -1174,6 +1165,7 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 		struct pci_sysdata *sd = bridge->bus->sysdata;
 		ACPI_COMPANION_SET(&bridge->dev, sd->companion);
 	}
+	bridge->map_irq = pci_map_irq;
 	return 0;
 }
 
@@ -1201,6 +1193,14 @@ void pcibios_penalize_isa_irq(int irq, int active)
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
-- 
2.6.2

