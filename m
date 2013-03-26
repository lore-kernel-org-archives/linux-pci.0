Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:54185 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081Ab3CZQwd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Mar 2013 12:52:33 -0400
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
Subject: [RFCv1 03/11] irqchip: armada-370-xp: move IRQ handler to avoid forward declaration
Date: Tue, 26 Mar 2013 17:52:18 +0100
Message-Id: <1364316746-8702-4-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If we move the IRQ handler function above the initialization function,
we avoid a forward declaration. This wasn't done as part of the
previous commit, in order to increase the readibility of the previous
commit, who was also moving the IRQ controller driver from arch/arm to
drivers/irqchip.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/irqchip/irq-armada-370-xp.c |   83 +++++++++++++++++------------------
 1 file changed, 40 insertions(+), 43 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index d20a832..1115bf8 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -206,49 +206,6 @@ static struct irq_domain_ops armada_370_xp_mpic_irq_ops = {
 };
 
 static asmlinkage void __exception_irq_entry
-armada_370_xp_handle_irq(struct pt_regs *regs);
-
-static int __init armada_370_xp_mpic_of_init(struct device_node *node,
-					     struct device_node *parent)
-{
-	u32 control;
-
-	main_int_base = of_iomap(node, 0);
-	per_cpu_int_base = of_iomap(node, 1);
-
-	BUG_ON(!main_int_base);
-	BUG_ON(!per_cpu_int_base);
-
-	control = readl(main_int_base + ARMADA_370_XP_INT_CONTROL);
-
-	armada_370_xp_mpic_domain =
-		irq_domain_add_linear(node, (control >> 2) & 0x3ff,
-				&armada_370_xp_mpic_irq_ops, NULL);
-
-	if (!armada_370_xp_mpic_domain)
-		panic("Unable to add Armada_370_Xp MPIC irq domain (DT)\n");
-
-	irq_set_default_host(armada_370_xp_mpic_domain);
-
-#ifdef CONFIG_SMP
-	armada_xp_mpic_smp_cpu_init();
-
-	/*
-	 * Set the default affinity from all CPUs to the boot cpu.
-	 * This is required since the MPIC doesn't limit several CPUs
-	 * from acknowledging the same interrupt.
-	 */
-	cpumask_clear(irq_default_affinity);
-	cpumask_set_cpu(smp_processor_id(), irq_default_affinity);
-
-#endif
-
-	set_handle_irq(armada_370_xp_handle_irq);
-
-	return 0;
-}
-
-static asmlinkage void __exception_irq_entry
 armada_370_xp_handle_irq(struct pt_regs *regs)
 {
 	u32 irqstat, irqnr;
@@ -291,4 +248,44 @@ armada_370_xp_handle_irq(struct pt_regs *regs)
 	} while (1);
 }
 
+static int __init armada_370_xp_mpic_of_init(struct device_node *node,
+					     struct device_node *parent)
+{
+	u32 control;
+
+	main_int_base = of_iomap(node, 0);
+	per_cpu_int_base = of_iomap(node, 1);
+
+	BUG_ON(!main_int_base);
+	BUG_ON(!per_cpu_int_base);
+
+	control = readl(main_int_base + ARMADA_370_XP_INT_CONTROL);
+
+	armada_370_xp_mpic_domain =
+		irq_domain_add_linear(node, (control >> 2) & 0x3ff,
+				&armada_370_xp_mpic_irq_ops, NULL);
+
+	if (!armada_370_xp_mpic_domain)
+		panic("Unable to add Armada_370_Xp MPIC irq domain (DT)\n");
+
+	irq_set_default_host(armada_370_xp_mpic_domain);
+
+#ifdef CONFIG_SMP
+	armada_xp_mpic_smp_cpu_init();
+
+	/*
+	 * Set the default affinity from all CPUs to the boot cpu.
+	 * This is required since the MPIC doesn't limit several CPUs
+	 * from acknowledging the same interrupt.
+	 */
+	cpumask_clear(irq_default_affinity);
+	cpumask_set_cpu(smp_processor_id(), irq_default_affinity);
+
+#endif
+
+	set_handle_irq(armada_370_xp_handle_irq);
+
+	return 0;
+}
+
 IRQCHIP_DECLARE(armada_370_xp_mpic, "marvell,mpic", armada_370_xp_mpic_of_init);
-- 
1.7.9.5

