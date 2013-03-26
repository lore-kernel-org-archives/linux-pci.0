Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:54237 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419Ab3CZQwi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Mar 2013 12:52:38 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>
Subject: [RFCv1 07/11] irqchip: armada-370-xp: add MSI support to interrupt controller driver
Date: Tue, 26 Mar 2013 17:52:22 +0100
Message-Id: <1364316746-8702-8-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This commit introduces the support for the MSI interrupts in the
armada-370-xp interrupt controller driver. It registers an IRQ domain
associated with the 'msi' node in the Device Tree, which the PCI
controller will refer to in a followup commit.

The MSI interrupts use the 16 high doorbells, and are therefore
notified using IRQ1 of the main interrupt controller.

The Device Tree binding documentation for the armada-370-xp driver is
also updated in the process.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../devicetree/bindings/arm/armada-370-xp-mpic.txt |   39 +++++++--
 arch/arm/boot/dts/armada-370-xp.dtsi               |    6 ++
 arch/arm/mach-mvebu/Kconfig                        |    1 +
 drivers/irqchip/irq-armada-370-xp.c                |   91 +++++++++++++++++++-
 4 files changed, 130 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/armada-370-xp-mpic.txt b/Documentation/devicetree/bindings/arm/armada-370-xp-mpic.txt
index 61df564..2233d20 100644
--- a/Documentation/devicetree/bindings/arm/armada-370-xp-mpic.txt
+++ b/Documentation/devicetree/bindings/arm/armada-370-xp-mpic.txt
@@ -4,8 +4,6 @@ Marvell Armada 370 and Armada XP Interrupt Controller
 Required properties:
 - compatible: Should be "marvell,mpic"
 - interrupt-controller: Identifies the node as an interrupt controller.
-- #interrupt-cells: The number of cells to define the interrupts. Should be 1.
-  The cell is the IRQ number
 
 - reg: Should contain PMIC registers location and length. First pair
   for the main interrupt registers, second pair for the per-CPU
@@ -14,16 +12,45 @@ Required properties:
   automatically map to the interrupt controller registers of the
   current CPU)
 
+The node should have two sub-nodes, each describing one aspect of the
+interrupt controller:
 
+ * A first node named main-intc that describes the main interrupt
+   controller itself, receiving interrupts from all devices.
+
+   This sub-node should have the following properties:
+   - interrupt-controller: identifies the code as an interrupt
+     controller.
+   - #interrupt-cells: The number of cells to define the
+     interrupts. Should be 1.  The cell is the IRQ number
+
+ * A second node named msi-intc that is used for Message Signaled
+   Interrupts of the PCIe bus.
+
+   This sub-node should have the following properties:
+   - interrupt-controller: identifies the code as an interrupt
+     controller.
+   - #interrupt-cells: The number of cells to define the
+     interrupts. Should be 1.  The cell is the IRQ number
+   - marvell,doorbell: Gives the physical address at which PCIe
+     devices should write to signal an MSI interrupt.
 
 Example:
 
-        mpic: interrupt-controller@d0020000 {
+        interrupt-controller@d0020000 {
               compatible = "marvell,mpic";
-              #interrupt-cells = <1>;
-              #address-cells = <1>;
-              #size-cells = <1>;
               interrupt-controller;
               reg = <0xd0020a00 0x1d0>,
                     <0xd0021070 0x58>;
+
+              mpic: main-intc@d0020000 {
+                    #interrupt-cells = <1>;
+                    interrupt-controller;
+              };
+
+              msi: msi-intc@d0020000 {
+                    #interrupt-cells = <1>;
+                    interrupt-controller;
+                    marvell,doorbell = <0xd0020a04>;
+              };
         };
diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index de054ed..de6569cd 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -36,6 +36,12 @@
 		    #interrupt-cells = <1>;
 		    interrupt-controller;
 	      };
+
+	      msi: msi-intc@d0020000 {
+		    #interrupt-cells = <1>;
+		    interrupt-controller;
+		    marvell,doorbell = <0xd0020a04>;
+	      };
 	};
 
 	coherency-fabric@d0020200 {
diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index d353249..3254b77 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -16,6 +16,7 @@ config ARCH_MVEBU
 	select MVEBU_MBUS
 	select MIGHT_HAVE_PCI
 	select PCI_QUIRKS if PCI
+	select ARCH_SUPPORTS_MSI if PCI
 
 if ARCH_MVEBU
 
diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 4b2a6d7..3180797 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -22,6 +22,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/irqdomain.h>
+#include <linux/msi.h>
 #include <asm/mach/arch.h>
 #include <asm/exception.h>
 #include <asm/smp_plat.h>
@@ -51,6 +52,10 @@
 #define IPI_DOORBELL_START                      (0)
 #define IPI_DOORBELL_END                        (8)
 #define IPI_DOORBELL_MASK                       0xFF
+#define PCI_MSI_DOORBELL_START                  (16)
+#define PCI_MSI_DOORBELL_NR                     (16)
+#define PCI_MSI_DOORBELL_END                    (32)
+#define PCI_MSI_DOORBELL_MASK                   0xFFFF0000
 
 static DEFINE_RAW_SPINLOCK(irq_controller_lock);
 
@@ -58,6 +63,10 @@ static void __iomem *per_cpu_int_base;
 static void __iomem *main_int_base;
 static struct irq_domain *armada_370_xp_mpic_domain;
 
+#ifdef CONFIG_PCI_MSI
+static struct irq_domain *armada_370_xp_msi_domain;
+#endif
+
 /*
  * In SMP mode:
  * For shared global interrupts, mask/unmask global enable bit
@@ -167,6 +176,57 @@ static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
 	return 0;
 }
 
+#ifdef CONFIG_PCI_MSI
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
+void armada_370_xp_msi_init(struct device_node *node)
+{
+	struct device_node *msi_node;
+	u32 reg;
+
+	msi_node = of_get_child_by_name(node, "msi-intc");
+	if (!msi_node)
+		return;
+
+	armada_370_xp_msi_domain =
+		irq_domain_add_linear(msi_node, PCI_MSI_DOORBELL_NR,
+				      &armada_370_xp_msi_irq_ops, NULL);
+	if (!armada_370_xp_msi_domain)
+		panic("Unable to add Armada 370/XP MSI irq domain\n");
+
+	reg = readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS)
+		| PCI_MSI_DOORBELL_MASK;
+
+	writel(reg, per_cpu_int_base +
+	       ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+
+	/* Unmask IPI interrupt */
+	writel(1, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
+}
+#else
+static void armada_370_xp_msi_init(struct device_node *node) { }
+#endif  /* CONFIG_PCI_MSI */
+
 #ifdef CONFIG_SMP
 void armada_mpic_send_doorbell(const struct cpumask *mask, unsigned int irq)
 {
@@ -220,12 +280,39 @@ armada_370_xp_handle_irq(struct pt_regs *regs)
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
+					ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS)
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
@@ -291,6 +378,8 @@ static int __init armada_370_xp_mpic_of_init(struct device_node *node,
 
 #endif
 
+	armada_370_xp_msi_init(node);
+
 	set_handle_irq(armada_370_xp_handle_irq);
 
 	return 0;
-- 
1.7.9.5

