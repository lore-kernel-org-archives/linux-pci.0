Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from [207.46.163.244] ([207.46.163.244]:11441 "EHLO
	na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757679AbaHHXUb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 8 Aug 2014 19:20:31 -0400
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
Subject: [PATCH 3/4] irqchip: gic: Revert the static declaration of irq-gic functions
Date: Fri, 8 Aug 2014 18:17:15 -0500
Message-ID: <1407539836-9768-4-git-send-email-suravee.suthikulpanit@amd.com>
In-Reply-To: <1407539836-9768-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1407539836-9768-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

This patch reverts the static declaration of various irq-gic
functions introduced in the fe7ac63fe5393b205b94247239f3d0686a65ee0a

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>
Cc: Marc Zyngier <Marc.Zyngier@arm.com>
Cc: Jason Cooper <jason@lakedaemon.net>
---
 drivers/irqchip/irq-gic.c | 10 +++++-----
 drivers/irqchip/irq-gic.h | 13 -------------
 2 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 29ee97a..cedaeb4 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -172,7 +172,7 @@ void gic_unmask_irq(struct irq_data *d)
 	raw_spin_unlock(&irq_controller_lock);
 }
 
-void gic_eoi_irq(struct irq_data *d)
+static void gic_eoi_irq(struct irq_data *d)
 {
 	if (gic_arch_extn.irq_eoi) {
 		raw_spin_lock(&irq_controller_lock);
@@ -183,7 +183,7 @@ void gic_eoi_irq(struct irq_data *d)
 	writel_relaxed(gic_irq(d), gic_cpu_base(d) + GIC_CPU_EOI);
 }
 
-int gic_set_type(struct irq_data *d, unsigned int type)
+static int gic_set_type(struct irq_data *d, unsigned int type)
 {
 	void __iomem *base = gic_dist_base(d);
 	unsigned int gicirq = gic_irq(d);
@@ -207,7 +207,7 @@ int gic_set_type(struct irq_data *d, unsigned int type)
 	return 0;
 }
 
-int gic_retrigger(struct irq_data *d)
+static int gic_retrigger(struct irq_data *d)
 {
 	if (gic_arch_extn.irq_retrigger)
 		return gic_arch_extn.irq_retrigger(d);
@@ -217,7 +217,7 @@ int gic_retrigger(struct irq_data *d)
 }
 
 #ifdef CONFIG_SMP
-int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
+static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 		     bool force)
 {
 	void __iomem *reg = gic_dist_base(d) + GIC_DIST_TARGET + (gic_irq(d) & ~3);
@@ -244,7 +244,7 @@ int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 #endif
 
 #ifdef CONFIG_PM
-int gic_set_wake(struct irq_data *d, unsigned int on)
+static int gic_set_wake(struct irq_data *d, unsigned int on)
 {
 	int ret = -ENXIO;
 
diff --git a/drivers/irqchip/irq-gic.h b/drivers/irqchip/irq-gic.h
index 1c6547d..83aa772 100644
--- a/drivers/irqchip/irq-gic.h
+++ b/drivers/irqchip/irq-gic.h
@@ -50,18 +50,5 @@ int _gic_of_init(struct device_node *node,
 
 void gic_mask_irq(struct irq_data *d);
 void gic_unmask_irq(struct irq_data *d);
-void gic_eoi_irq(struct irq_data *d);
-int gic_set_type(struct irq_data *d, unsigned int type);
-int gic_retrigger(struct irq_data *d);
-
-#ifdef CONFIG_SMP
-int gic_set_affinity(struct irq_data *d,
-			    const struct cpumask *mask_val,
-			    bool force);
-#endif
-
-#ifdef CONFIG_PM
-int gic_set_wake(struct irq_data *d, unsigned int on);
-#endif
 
 #endif /* _IRQ_GIC_H_ */
-- 
1.9.0

