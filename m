Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1lp0141.outbound.protection.outlook.com ([207.46.163.141]:18763
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756571AbaGIXF2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 9 Jul 2014 19:05:28 -0400
From: <suravee.suthikulpanit@amd.com>
To: <marc.zyngier@arm.com>, <mark.rutland@arm.com>,
	<jason@lakedaemon.net>
CC: <pawel.moll@arm.com>, <Catalin.Marinas@arm.com>,
	<Will.Deacon@arm.com>, <tglx@linutronix.de>,
	<Harish.Kasiviswanathan@amd.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Mark Rutland <Mark.Rutland@arm.com>,
	"Marc Zyngier" <Marc.Zyngier@arm.com>
Subject: [PATCH 2/4 V3] irqchip: gic: Restructuring ARM GIC code
Date: Wed, 9 Jul 2014 18:05:02 -0500
Message-ID: <1404947104-21345-3-git-send-email-suravee.suthikulpanit@amd.com>
In-Reply-To: <1404947104-21345-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1404947104-21345-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

This patch restructures the code to prepare for future MSI support.
It moves the declaration of structures and functions into the header file,
and omit the static prefix.

Since we are planing to have different irq_chip for GICv2m, the patch adds
irq_chip pointer in the gic_chip_data which is initialized during probing phase.

This should not have any functional changes.

Cc: Mark Rutland <Mark.Rutland@arm.com>
Cc: Marc Zyngier <Marc.Zyngier@arm.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>
Cc: Will Deacon <Will.Deacon@arm.com>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 drivers/irqchip/irq-gic.c | 65 +++++++++++++++++++++--------------------------
 drivers/irqchip/irq-gic.h | 52 +++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+), 36 deletions(-)
 create mode 100644 drivers/irqchip/irq-gic.h

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index ac8f7ea..966e1d5 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1,5 +1,5 @@
 /*
- *  linux/arch/arm/common/gic.c
+ *  driver/irqchip/irq-gic.c
  *
  *  Copyright (C) 2002 ARM Limited, All Rights Reserved.
  *
@@ -47,30 +47,9 @@
 #include <asm/smp_plat.h>
 
 #include "irq-gic-common.h"
+#include "irq-gic.h"
 #include "irqchip.h"
 
-union gic_base {
-	void __iomem *common_base;
-	void __percpu * __iomem *percpu_base;
-};
-
-struct gic_chip_data {
-	union gic_base dist_base;
-	union gic_base cpu_base;
-#ifdef CONFIG_CPU_PM
-	u32 saved_spi_enable[DIV_ROUND_UP(1020, 32)];
-	u32 saved_spi_conf[DIV_ROUND_UP(1020, 16)];
-	u32 saved_spi_target[DIV_ROUND_UP(1020, 4)];
-	u32 __percpu *saved_ppi_enable;
-	u32 __percpu *saved_ppi_conf;
-#endif
-	struct irq_domain *domain;
-	unsigned int gic_irqs;
-#ifdef CONFIG_GIC_NON_BANKED
-	void __iomem *(*get_base)(union gic_base *);
-#endif
-};
-
 static DEFINE_RAW_SPINLOCK(irq_controller_lock);
 
 /*
@@ -152,7 +131,7 @@ static inline unsigned int gic_irq(struct irq_data *d)
 /*
  * Routines to acknowledge, disable and enable interrupts
  */
-static void gic_mask_irq(struct irq_data *d)
+void gic_mask_irq(struct irq_data *d)
 {
 	u32 mask = 1 << (gic_irq(d) % 32);
 
@@ -163,7 +142,7 @@ static void gic_mask_irq(struct irq_data *d)
 	raw_spin_unlock(&irq_controller_lock);
 }
 
-static void gic_unmask_irq(struct irq_data *d)
+void gic_unmask_irq(struct irq_data *d)
 {
 	u32 mask = 1 << (gic_irq(d) % 32);
 
@@ -174,7 +153,7 @@ static void gic_unmask_irq(struct irq_data *d)
 	raw_spin_unlock(&irq_controller_lock);
 }
 
-static void gic_eoi_irq(struct irq_data *d)
+void gic_eoi_irq(struct irq_data *d)
 {
 	if (gic_arch_extn.irq_eoi) {
 		raw_spin_lock(&irq_controller_lock);
@@ -185,7 +164,7 @@ static void gic_eoi_irq(struct irq_data *d)
 	writel_relaxed(gic_irq(d), gic_cpu_base(d) + GIC_CPU_EOI);
 }
 
-static int gic_set_type(struct irq_data *d, unsigned int type)
+int gic_set_type(struct irq_data *d, unsigned int type)
 {
 	void __iomem *base = gic_dist_base(d);
 	unsigned int gicirq = gic_irq(d);
@@ -209,7 +188,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 	return 0;
 }
 
-static int gic_retrigger(struct irq_data *d)
+int gic_retrigger(struct irq_data *d)
 {
 	if (gic_arch_extn.irq_retrigger)
 		return gic_arch_extn.irq_retrigger(d);
@@ -219,8 +198,8 @@ static int gic_retrigger(struct irq_data *d)
 }
 
 #ifdef CONFIG_SMP
-static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
-			    bool force)
+int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
+		     bool force)
 {
 	void __iomem *reg = gic_dist_base(d) + GIC_DIST_TARGET + (gic_irq(d) & ~3);
 	unsigned int cpu, shift = (gic_irq(d) % 4) * 8;
@@ -246,7 +225,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 #endif
 
 #ifdef CONFIG_PM
-static int gic_set_wake(struct irq_data *d, unsigned int on)
+int gic_set_wake(struct irq_data *d, unsigned int on)
 {
 	int ret = -ENXIO;
 
@@ -768,19 +747,21 @@ void __init gic_init_physaddr(struct device_node *node)
 static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 				irq_hw_number_t hw)
 {
+	struct gic_chip_data *gic = d->host_data;
+
 	if (hw < 32) {
 		irq_set_percpu_devid(irq);
-		irq_set_chip_and_handler(irq, &gic_chip,
+		irq_set_chip_and_handler(irq, gic->irq_chip,
 					 handle_percpu_devid_irq);
 		set_irq_flags(irq, IRQF_VALID | IRQF_NOAUTOEN);
 	} else {
-		irq_set_chip_and_handler(irq, &gic_chip,
+		irq_set_chip_and_handler(irq, gic->irq_chip,
 					 handle_fasteoi_irq);
 		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
 
 		gic_routable_irq_domain_ops->map(d, irq, hw);
 	}
-	irq_set_chip_data(irq, d->host_data);
+	irq_set_chip_data(irq, gic);
 	return 0;
 }
 
@@ -989,8 +970,9 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 #ifdef CONFIG_OF
 static int gic_cnt __initdata;
 
-static int __init
-gic_of_init(struct device_node *node, struct device_node *parent)
+int __init
+_gic_of_init(struct device_node *node, struct device_node *parent,
+	     struct irq_chip *chip, struct gic_chip_data **gic)
 {
 	void __iomem *cpu_base;
 	void __iomem *dist_base;
@@ -1009,6 +991,8 @@ gic_of_init(struct device_node *node, struct device_node *parent)
 	if (of_property_read_u32(node, "cpu-offset", &percpu_offset))
 		percpu_offset = 0;
 
+	gic_data[gic_cnt].irq_chip = chip;
+
 	gic_init_bases(gic_cnt, -1, dist_base, cpu_base, percpu_offset, node);
 	if (!gic_cnt)
 		gic_init_physaddr(node);
@@ -1017,10 +1001,19 @@ gic_of_init(struct device_node *node, struct device_node *parent)
 		irq = irq_of_parse_and_map(node, 0);
 		gic_cascade_irq(gic_cnt, irq);
 	}
+
+	if (gic)
+		*gic = &gic_data[gic_cnt];
 	gic_cnt++;
 	return 0;
 }
 
+static int __init
+gic_of_init(struct device_node *node, struct device_node *parent)
+{
+	return _gic_of_init(node, parent, &gic_chip, NULL);
+}
+
 IRQCHIP_DECLARE(arm_gic_400, "arm,gic-400", gic_of_init);
 IRQCHIP_DECLARE(cortex_a15_gic, "arm,cortex-a15-gic", gic_of_init);
 IRQCHIP_DECLARE(cortex_a9_gic, "arm,cortex-a9-gic", gic_of_init);
diff --git a/drivers/irqchip/irq-gic.h b/drivers/irqchip/irq-gic.h
new file mode 100644
index 0000000..a4beb4a
--- /dev/null
+++ b/drivers/irqchip/irq-gic.h
@@ -0,0 +1,52 @@
+#ifndef _IRQ_GIC_H_
+#define _IRQ_GIC_H_
+
+#include <linux/msi.h>
+
+union gic_base {
+	void __iomem *common_base;
+	void __percpu * __iomem *percpu_base;
+};
+
+struct gic_chip_data {
+	union gic_base dist_base;
+	union gic_base cpu_base;
+#ifdef CONFIG_CPU_PM
+	u32 saved_spi_enable[DIV_ROUND_UP(1020, 32)];
+	u32 saved_spi_conf[DIV_ROUND_UP(1020, 16)];
+	u32 saved_spi_target[DIV_ROUND_UP(1020, 4)];
+	u32 __percpu *saved_ppi_enable;
+	u32 __percpu *saved_ppi_conf;
+#endif
+	struct irq_domain *domain;
+	unsigned int gic_irqs;
+	struct irq_chip *irq_chip;
+#ifdef CONFIG_GIC_NON_BANKED
+	void __iomem *(*get_base)(union gic_base *);
+#endif
+};
+
+void gic_mask_irq(struct irq_data *d);
+void gic_unmask_irq(struct irq_data *d);
+void gic_eoi_irq(struct irq_data *d);
+int gic_set_type(struct irq_data *d, unsigned int type);
+int gic_retrigger(struct irq_data *d);
+
+#ifdef CONFIG_SMP
+int gic_set_affinity(struct irq_data *d,
+			    const struct cpumask *mask_val,
+			    bool force);
+#endif
+
+#ifdef CONFIG_PM
+int gic_set_wake(struct irq_data *d, unsigned int on);
+#endif
+
+#ifdef CONFIG_OF
+int _gic_of_init(struct device_node *node,
+		 struct device_node *parent,
+		 struct irq_chip *chip,
+		 struct gic_chip_data **gic) __init;
+#endif
+
+#endif /* _IRQ_GIC_H_ */
-- 
1.9.0

