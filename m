Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:56407 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756083Ab3GOLxA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jul 2013 07:53:00 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCHv5 07/11] irqchip: armada-370-xp: implement MSI support
Date: Mon, 15 Jul 2013 13:52:43 +0200
Message-Id: <1373889167-27878-8-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This commit introduces the support for the MSI interrupts in the
armada-370-xp interrupt controller driver. It registers an MSI chip to
the MSI chip registry, which will be used by the Marvell PCIe host
controller driver.

The MSI interrupts use the 16 high doorbells, and are therefore
notified using IRQ1 of the main interrupt controller.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../devicetree/bindings/arm/armada-370-xp-mpic.txt |   3 +
 drivers/irqchip/irq-armada-370-xp.c                | 141 ++++++++++++++++++++-
 2 files changed, 143 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/armada-370-xp-mpic.txt b/Documentation/devicetree/bindings/arm/armada-370-xp-mpic.txt
index 61df564..d74091a 100644
--- a/Documentation/devicetree/bindings/arm/armada-370-xp-mpic.txt
+++ b/Documentation/devicetree/bindings/arm/armada-370-xp-mpic.txt
@@ -4,6 +4,8 @@ Marvell Armada 370 and Armada XP Interrupt Controller
 Required properties:
 - compatible: Should be "marvell,mpic"
 - interrupt-controller: Identifies the node as an interrupt controller.
+- msi-controller: Identifies the node as an PCI Message Signaled
+  Interrupt controller.
 - #interrupt-cells: The number of cells to define the interrupts. Should be 1.
   The cell is the IRQ number
 
@@ -24,6 +26,7 @@ Example:
               #address-cells = <1>;
               #size-cells = <1>;
               interrupt-controller;
+              msi-controller;
               reg = <0xd0020a00 0x1d0>,
                     <0xd0021070 0x58>;
         };
diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 26adc74..ca1f5e2 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -21,7 +21,10 @@
 #include <linux/io.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/of_pci.h>
 #include <linux/irqdomain.h>
+#include <linux/slab.h>
+#include <linux/msi.h>
 #include <asm/mach/arch.h>
 #include <asm/exception.h>
 #include <asm/smp_plat.h>
@@ -51,12 +54,20 @@
 #define IPI_DOORBELL_START                      (0)
 #define IPI_DOORBELL_END                        (8)
 #define IPI_DOORBELL_MASK                       0xFF
+#define PCI_MSI_DOORBELL_START                  (16)
+#define PCI_MSI_DOORBELL_NR                     (16)
+#define PCI_MSI_DOORBELL_END                    (32)
+#define PCI_MSI_DOORBELL_MASK                   0xFFFF0000
 
 static DEFINE_RAW_SPINLOCK(irq_controller_lock);
 
 static void __iomem *per_cpu_int_base;
 static void __iomem *main_int_base;
 static struct irq_domain *armada_370_xp_mpic_domain;
+#ifdef CONFIG_PCI_MSI
+static struct irq_domain *armada_370_xp_msi_domain;
+static phys_addr_t msi_doorbell_addr;
+#endif
 
 /*
  * In SMP mode:
@@ -87,6 +98,102 @@ static void armada_370_xp_irq_unmask(struct irq_data *d)
 				ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
 }
 
+#ifdef CONFIG_PCI_MSI
+
+static int armada_370_xp_setup_msi_irq(struct msi_chip *chip,
+				       struct pci_dev *pdev,
+				       struct msi_desc *desc)
+{
+	struct msi_msg msg;
+	irq_hw_number_t hwirq;
+	int virq;
+
+	virq = irq_alloc_mapping(armada_370_xp_msi_domain, &hwirq);
+	if (!virq)
+		return -EINVAL;
+
+	irq_set_msi_desc(virq, desc);
+
+	msg.address_lo = msi_doorbell_addr;
+	msg.address_hi = 0;
+	msg.data = 0xf00 | (hwirq + 16);
+
+	write_msi_msg(virq, &msg);
+	return 0;
+}
+
+static void armada_370_xp_teardown_msi_irq(struct msi_chip *chip,
+					   unsigned int irq)
+{
+	irq_dispose_mapping(irq);
+}
+
+static struct irq_chip armada_370_xp_msi_irq_chip = {
+	.name = "armada_370_xp_msi_irq",
+	.irq_enable = unmask_msi_irq,
+	.irq_disable = mask_msi_irq,
+	.irq_mask = mask_msi_irq,
+	.irq_unmask = unmask_msi_irq,
+};
+
+static int armada_370_xp_msi_map(struct irq_domain *domain, unsigned int virq,
+				 irq_hw_number_t hw)
+{
+	irq_set_chip_and_handler(virq, &armada_370_xp_msi_irq_chip,
+				 handle_simple_irq);
+	set_irq_flags(virq, IRQF_VALID);
+
+	return 0;
+}
+
+static const struct irq_domain_ops armada_370_xp_msi_irq_ops = {
+	.map = armada_370_xp_msi_map,
+};
+
+static int armada_370_xp_msi_init(struct device_node *node)
+{
+	struct msi_chip *msi_chip;
+	int ret;
+	u32 reg;
+
+	msi_chip = kzalloc(sizeof(*msi_chip), GFP_KERNEL);
+	if (!msi_chip)
+		return -ENOMEM;
+
+	armada_370_xp_msi_domain =
+		irq_domain_add_linear(NULL, PCI_MSI_DOORBELL_NR,
+				      &armada_370_xp_msi_irq_ops, NULL);
+	if (!armada_370_xp_msi_domain) {
+		kfree(msi_chip);
+		return -ENOMEM;
+	}
+
+	msi_chip->of_node = node;
+	msi_chip->setup_irq = armada_370_xp_setup_msi_irq;
+	msi_chip->teardown_irq = armada_370_xp_teardown_msi_irq;
+
+	ret = of_pci_msi_chip_add(msi_chip);
+	if (ret < 0) {
+		irq_domain_remove(armada_370_xp_msi_domain);
+		kfree(msi_chip);
+		return ret;
+	}
+
+	reg = readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS)
+		| PCI_MSI_DOORBELL_MASK;
+
+	writel(reg, per_cpu_int_base +
+	       ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+
+	/* Unmask IPI interrupt */
+	writel(1, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
+
+	return 0;
+}
+#else
+static inline int armada_370_xp_msi_init(struct device_node *node) { return 0; }
+#endif
+
 #ifdef CONFIG_SMP
 static int armada_xp_set_affinity(struct irq_data *d,
 				  const struct cpumask *mask_val, bool force)
@@ -214,12 +321,39 @@ armada_370_xp_handle_irq(struct pt_regs *regs)
 		if (irqnr > 1022)
 			break;
 
-		if (irqnr > 0) {
+		if (irqnr > 1) {
 			irqnr =	irq_find_mapping(armada_370_xp_mpic_domain,
 					irqnr);
 			handle_IRQ(irqnr, regs);
 			continue;
 		}
+
+#ifdef CONFIG_PCI_MSI
+		/* MSI handling */
+		if (irqnr == 1) {
+			u32 msimask, msinr;
+
+			msimask = readl_relaxed(per_cpu_int_base +
+						ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS)
+				& PCI_MSI_DOORBELL_MASK;
+
+			writel(~PCI_MSI_DOORBELL_MASK, per_cpu_int_base +
+			       ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS);
+
+			for (msinr = PCI_MSI_DOORBELL_START;
+			     msinr < PCI_MSI_DOORBELL_END; msinr++) {
+				int irq;
+
+				if (!(msimask & BIT(msinr)))
+					continue;
+
+				irq = irq_find_mapping(armada_370_xp_msi_domain,
+						       msinr - 16);
+				handle_IRQ(irq, regs);
+			}
+		}
+#endif
+
 #ifdef CONFIG_SMP
 		/* IPI Handling */
 		if (irqnr == 0) {
@@ -269,6 +403,9 @@ static int __init armada_370_xp_mpic_of_init(struct device_node *node,
 				   resource_size(&per_cpu_int_res));
 	BUG_ON(!per_cpu_int_base);
 
+	msi_doorbell_addr = main_int_res.start +
+		ARMADA_370_XP_SW_TRIG_INT_OFFS;
+
 	control = readl(main_int_base + ARMADA_370_XP_INT_CONTROL);
 
 	armada_370_xp_mpic_domain =
@@ -292,6 +429,8 @@ static int __init armada_370_xp_mpic_of_init(struct device_node *node,
 
 #endif
 
+	armada_370_xp_msi_init(node);
+
 	set_handle_irq(armada_370_xp_handle_irq);
 
 	return 0;
-- 
1.8.1.2

