Return-Path: <SRS0=sVnv=Q2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB355C4360F
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 15:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9641A2146E
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 15:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbfBSP5n (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Feb 2019 10:57:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:51930 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728893AbfBSP5n (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Feb 2019 10:57:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9201CAFB5;
        Tue, 19 Feb 2019 15:57:41 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 10/10] MIPS: SGI-IP27: abstract chipset irq from bridge
Date:   Tue, 19 Feb 2019 16:57:24 +0100
Message-Id: <20190219155728.19163-11-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190219155728.19163-1-tbogendoerfer@suse.de>
References: <20190219155728.19163-1-tbogendoerfer@suse.de>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bridge ASIC is widely used in different SGI systems, but the connected
chipset is either HUB, HEART or BEDROCK. This commit switches to
irq domain hierarchy for hub and bridge interrupts to get bridge
setup out of hub interrupt code.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 arch/mips/Kconfig                         |   1 +
 arch/mips/include/asm/pci/bridge.h        |   3 +-
 arch/mips/include/asm/sn/intr.h           |   6 +
 arch/mips/sgi-ip27/ip27-irq.c             | 178 +++++++++++++-----------------
 drivers/pci/controller/pci-xtalk-bridge.c | 145 +++++++++++++++++++++++-
 5 files changed, 229 insertions(+), 104 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 57a424e82a18..ba55c4af8798 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -677,6 +677,7 @@ config SGI_IP27
 	select SYS_HAS_EARLY_PRINTK
 	select HAVE_PCI
 	select IRQ_MIPS_CPU
+	select IRQ_DOMAIN_HIERARCHY
 	select NR_CPUS_DEFAULT_64
 	select PCI_DRIVERS_GENERIC
 	select PCI_XTALK_BRIDGE
diff --git a/arch/mips/include/asm/pci/bridge.h b/arch/mips/include/asm/pci/bridge.h
index 457ff868a027..4b8570e4fb48 100644
--- a/arch/mips/include/asm/pci/bridge.h
+++ b/arch/mips/include/asm/pci/bridge.h
@@ -806,6 +806,7 @@ struct bridge_controller {
 	struct resource		busn;
 	struct bridge_regs	*base;
 	u64			baddr;
+	struct irq_domain	*domain;
 	unsigned int		pci_int[8];
 	nasid_t			nasid;
 };
@@ -820,6 +821,4 @@ struct bridge_controller {
 #define bridge_clr(bc, reg, val)	\
 	__raw_writel(__raw_readl(&bc->base->reg) & ~(val), &bc->base->reg)
 
-extern int request_bridge_irq(struct bridge_controller *bc, int pin);
-
 #endif /* _ASM_PCI_BRIDGE_H */
diff --git a/arch/mips/include/asm/sn/intr.h b/arch/mips/include/asm/sn/intr.h
index fc1348193957..bdb8ca95183a 100644
--- a/arch/mips/include/asm/sn/intr.h
+++ b/arch/mips/include/asm/sn/intr.h
@@ -126,4 +126,10 @@ do {								\
 #define NI_ERROR_INTR		62
 #define MSC_PANIC_INTR		63
 
+struct irq_alloc_info {
+	void *ctrl;
+	nasid_t nasid;
+	int pin;
+};
+
 #endif /* __ASM_SN_INTR_H */
diff --git a/arch/mips/sgi-ip27/ip27-irq.c b/arch/mips/sgi-ip27/ip27-irq.c
index 710a59764b01..b992c2b08e3b 100644
--- a/arch/mips/sgi-ip27/ip27-irq.c
+++ b/arch/mips/sgi-ip27/ip27-irq.c
@@ -12,10 +12,10 @@
 #include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/bitops.h>
+#include <linux/sched.h>
 
 #include <asm/io.h>
 #include <asm/irq_cpu.h>
-#include <asm/pci/bridge.h>
 #include <asm/sn/addrs.h>
 #include <asm/sn/agent.h>
 #include <asm/sn/arch.h>
@@ -23,11 +23,9 @@
 #include <asm/sn/intr.h>
 
 struct hub_irq_data {
-	struct bridge_controller *bc;
 	u64	*irq_mask[2];
 	cpuid_t	cpu;
 	int	bit;
-	int	pin;
 };
 
 static DECLARE_BITMAP(hub_irq_map, IP27_HUB_IRQ_COUNT);
@@ -69,67 +67,6 @@ static void disable_hub_irq(struct irq_data *d)
 	__raw_writeq(mask[1], hd->irq_mask[1]);
 }
 
-static unsigned int startup_bridge_irq(struct irq_data *d)
-{
-	struct hub_irq_data *hd = irq_data_get_irq_chip_data(d);
-	struct bridge_controller *bc;
-	nasid_t nasid;
-	u32 device;
-	int pin;
-
-	if (!hd)
-		return -EINVAL;
-
-	pin = hd->pin;
-	bc = hd->bc;
-
-	nasid = COMPACT_TO_NASID_NODEID(cpu_to_node(hd->cpu));
-	bridge_write(bc, b_int_addr[pin].addr,
-		     (0x20000 | hd->bit | (nasid << 8)));
-	bridge_set(bc, b_int_enable, (1 << pin));
-	bridge_set(bc, b_int_enable, 0x7ffffe00); /* more stuff in int_enable */
-
-	/*
-	 * Enable sending of an interrupt clear packt to the hub on a high to
-	 * low transition of the interrupt pin.
-	 *
-	 * IRIX sets additional bits in the address which are documented as
-	 * reserved in the bridge docs.
-	 */
-	bridge_set(bc, b_int_mode, (1UL << pin));
-
-	/*
-	 * We assume the bridge to have a 1:1 mapping between devices
-	 * (slots) and intr pins.
-	 */
-	device = bridge_read(bc, b_int_device);
-	device &= ~(7 << (pin*3));
-	device |= (pin << (pin*3));
-	bridge_write(bc, b_int_device, device);
-
-	bridge_read(bc, b_wid_tflush);
-
-	enable_hub_irq(d);
-
-	return 0;	/* Never anything pending.  */
-}
-
-static void shutdown_bridge_irq(struct irq_data *d)
-{
-	struct hub_irq_data *hd = irq_data_get_irq_chip_data(d);
-	struct bridge_controller *bc;
-	int pin = hd->pin;
-
-	if (!hd)
-		return;
-
-	disable_hub_irq(d);
-
-	bc = hd->bc;
-	bridge_clr(bc, b_int_enable, (1 << pin));
-	bridge_read(bc, b_wid_tflush);
-}
-
 static void setup_hub_mask(struct hub_irq_data *hd, const struct cpumask *mask)
 {
 	nasid_t nasid;
@@ -164,7 +101,7 @@ static int set_affinity_hub_irq(struct irq_data *d, const struct cpumask *mask,
 	setup_hub_mask(hd, mask);
 
 	if (irqd_is_started(d))
-		startup_bridge_irq(d);
+		enable_hub_irq(d);
 
 	irq_data_update_effective_affinity(d, cpumask_of(hd->cpu));
 
@@ -173,20 +110,22 @@ static int set_affinity_hub_irq(struct irq_data *d, const struct cpumask *mask,
 
 static struct irq_chip hub_irq_type = {
 	.name		  = "HUB",
-	.irq_startup	  = startup_bridge_irq,
-	.irq_shutdown	  = shutdown_bridge_irq,
 	.irq_mask	  = disable_hub_irq,
 	.irq_unmask	  = enable_hub_irq,
 	.irq_set_affinity = set_affinity_hub_irq,
 };
 
-int request_bridge_irq(struct bridge_controller *bc, int pin)
+static int hub_domain_alloc(struct irq_domain *domain, unsigned int virq,
+			    unsigned int nr_irqs, void *arg)
 {
+	struct irq_alloc_info *info = arg;
 	struct hub_irq_data *hd;
 	struct hub_data *hub;
 	struct irq_desc *desc;
 	int swlevel;
-	int irq;
+
+	if (nr_irqs > 1 || !info)
+		return -EINVAL;
 
 	hd = kzalloc(sizeof(*hd), GFP_KERNEL);
 	if (!hd)
@@ -197,46 +136,39 @@ int request_bridge_irq(struct bridge_controller *bc, int pin)
 		kfree(hd);
 		return -EAGAIN;
 	}
-	irq = swlevel + IP27_HUB_IRQ_BASE;
-
-	hd->bc = bc;
 	hd->bit = swlevel;
-	hd->pin = pin;
-	irq_set_chip_data(irq, hd);
+	irq_domain_set_info(domain, virq, swlevel, &hub_irq_type, hd,
+			    handle_level_irq, NULL, NULL);
 
 	/* use CPU connected to nearest hub */
-	hub = hub_data(NASID_TO_COMPACT_NODEID(bc->nasid));
+	hub = hub_data(NASID_TO_COMPACT_NODEID(info->nasid));
 	setup_hub_mask(hd, &hub->h_cpus);
 
-	desc = irq_to_desc(irq);
-	desc->irq_common_data.node = bc->nasid;
+	desc = irq_to_desc(virq);
+	desc->irq_common_data.node = info->nasid;
 	cpumask_copy(desc->irq_common_data.affinity, &hub->h_cpus);
 
-	return irq;
+	return 0;
 }
 
-void ip27_hub_irq_init(void)
+static void hub_domain_free(struct irq_domain *domain,
+			    unsigned int virq, unsigned int nr_irqs)
 {
-	int i;
+	struct irq_data *irqd;
 
-	for (i = IP27_HUB_IRQ_BASE;
-	     i < (IP27_HUB_IRQ_BASE + IP27_HUB_IRQ_COUNT); i++)
-		irq_set_chip_and_handler(i, &hub_irq_type, handle_level_irq);
-
-	/*
-	 * Some interrupts are reserved by hardware or by software convention.
-	 * Mark these as reserved right away so they won't be used accidentally
-	 * later.
-	 */
-	for (i = 0; i <= BASE_PCI_IRQ; i++)
-		set_bit(i, hub_irq_map);
-
-	set_bit(IP_PEND0_6_63, hub_irq_map);
+	if (nr_irqs > 1)
+		return;
 
-	for (i = NI_BRDCAST_ERR_A; i <= MSC_PANIC_INTR; i++)
-		set_bit(i, hub_irq_map);
+	irqd = irq_domain_get_irq_data(domain, virq);
+	if (irqd && irqd->chip_data)
+		kfree(irqd->chip_data);
 }
 
+static const struct irq_domain_ops hub_domain_ops = {
+	.alloc = hub_domain_alloc,
+	.free  = hub_domain_free,
+};
+
 /*
  * This code is unnecessarily complex, because we do
  * intr enabling. Basically, once we grab the set of intrs we need
@@ -253,7 +185,9 @@ static void ip27_do_irq_mask0(struct irq_desc *desc)
 {
 	cpuid_t cpu = smp_processor_id();
 	unsigned long *mask = per_cpu(irq_enable_mask, cpu);
+	struct irq_domain *domain;
 	u64 pend0;
+	int irq;
 
 	/* copied from Irix intpend0() */
 	pend0 = LOCAL_HUB_L(PI_INT_PEND0);
@@ -277,7 +211,14 @@ static void ip27_do_irq_mask0(struct irq_desc *desc)
 		generic_smp_call_function_interrupt();
 	} else
 #endif
-		generic_handle_irq(__ffs(pend0) + IP27_HUB_IRQ_BASE);
+	{
+		domain = irq_desc_get_handler_data(desc);
+		irq = irq_linear_revmap(domain, __ffs(pend0));
+		if (irq)
+			generic_handle_irq(irq);
+		else
+			spurious_interrupt();
+	}
 
 	LOCAL_HUB_L(PI_INT_PEND0);
 }
@@ -286,7 +227,9 @@ static void ip27_do_irq_mask1(struct irq_desc *desc)
 {
 	cpuid_t cpu = smp_processor_id();
 	unsigned long *mask = per_cpu(irq_enable_mask, cpu);
+	struct irq_domain *domain;
 	u64 pend1;
+	int irq;
 
 	/* copied from Irix intpend0() */
 	pend1 = LOCAL_HUB_L(PI_INT_PEND1);
@@ -295,7 +238,12 @@ static void ip27_do_irq_mask1(struct irq_desc *desc)
 	if (!pend1)
 		return;
 
-	generic_handle_irq(__ffs(pend1) + IP27_HUB_IRQ_BASE + 64);
+	domain = irq_desc_get_handler_data(desc);
+	irq = irq_linear_revmap(domain, __ffs(pend1) + 64);
+	if (irq)
+		generic_handle_irq(irq);
+	else
+		spurious_interrupt();
 
 	LOCAL_HUB_L(PI_INT_PEND1);
 }
@@ -326,11 +274,41 @@ void install_ipi(void)
 
 void __init arch_init_irq(void)
 {
+	struct irq_domain *domain;
+	struct fwnode_handle *fn;
+	int i;
+
 	mips_cpu_irq_init();
-	ip27_hub_irq_init();
+
+	/*
+	 * Some interrupts are reserved by hardware or by software convention.
+	 * Mark these as reserved right away so they won't be used accidentally
+	 * later.
+	 */
+	for (i = 0; i <= BASE_PCI_IRQ; i++)
+		set_bit(i, hub_irq_map);
+
+	set_bit(IP_PEND0_6_63, hub_irq_map);
+
+	for (i = NI_BRDCAST_ERR_A; i <= MSC_PANIC_INTR; i++)
+		set_bit(i, hub_irq_map);
+
+	fn = irq_domain_alloc_named_fwnode("HUB");
+	WARN_ON(fn == NULL);
+	if (!fn)
+		return;
+	domain = irq_domain_create_linear(fn, IP27_HUB_IRQ_COUNT,
+					  &hub_domain_ops, NULL);
+	WARN_ON(domain == NULL);
+	if (!domain)
+		return;
+
+	irq_set_default_host(domain);
 
 	irq_set_percpu_devid(IP27_HUB_PEND0_IRQ);
-	irq_set_chained_handler(IP27_HUB_PEND0_IRQ, ip27_do_irq_mask0);
+	irq_set_chained_handler_and_data(IP27_HUB_PEND0_IRQ, ip27_do_irq_mask0,
+					 domain);
 	irq_set_percpu_devid(IP27_HUB_PEND1_IRQ);
-	irq_set_chained_handler(IP27_HUB_PEND1_IRQ, ip27_do_irq_mask1);
+	irq_set_chained_handler_and_data(IP27_HUB_PEND1_IRQ, ip27_do_irq_mask1,
+					 domain);
 }
diff --git a/drivers/pci/controller/pci-xtalk-bridge.c b/drivers/pci/controller/pci-xtalk-bridge.c
index 77e42c46937b..0e3a4bd9484d 100644
--- a/drivers/pci/controller/pci-xtalk-bridge.c
+++ b/drivers/pci/controller/pci-xtalk-bridge.c
@@ -324,6 +324,129 @@ static struct pci_ops bridge_pci_ops = {
 	.write	 = pci_write_config,
 };
 
+struct bridge_irq_chip_data {
+	struct bridge_controller *bc;
+	nasid_t nasid;
+};
+
+static int bridge_set_affinity(struct irq_data *d, const struct cpumask *mask,
+			       bool force)
+{
+	struct bridge_irq_chip_data *data = d->chip_data;
+	int bit = d->parent_data->hwirq;
+	int pin = d->hwirq;
+	nasid_t nasid;
+	int ret, cpu;
+
+	ret = irq_chip_set_affinity_parent(d, mask, force);
+	if (ret >= 0) {
+		cpu = cpumask_first_and(mask, cpu_online_mask);
+		nasid = COMPACT_TO_NASID_NODEID(cpu_to_node(cpu));
+		bridge_write(data->bc, b_int_addr[pin].addr,
+			     (0x20000 | bit | (nasid << 8)));
+		bridge_read(data->bc, b_wid_tflush);
+	}
+	return ret;
+}
+
+struct irq_chip bridge_irq_chip = {
+	.name             = "BRIDGE",
+	.irq_mask         = irq_chip_mask_parent,
+	.irq_unmask       = irq_chip_unmask_parent,
+	.irq_set_affinity = bridge_set_affinity
+};
+
+static int bridge_domain_alloc(struct irq_domain *domain, unsigned int virq,
+			       unsigned int nr_irqs, void *arg)
+{
+	struct bridge_irq_chip_data *data;
+	struct irq_alloc_info *info = arg;
+	int ret;
+
+	if (nr_irqs > 1 || !info)
+		return -EINVAL;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
+	if (ret >= 0) {
+		data->bc = info->ctrl;
+		data->nasid = info->nasid;
+		irq_domain_set_info(domain, virq, info->pin, &bridge_irq_chip,
+				    data, handle_level_irq, NULL, NULL);
+	} else {
+		kfree(data);
+	}
+
+	return ret;
+}
+
+static void bridge_domain_free(struct irq_domain *domain, unsigned int virq,
+			       unsigned int nr_irqs)
+{
+	struct irq_data *irqd = irq_domain_get_irq_data(domain, virq);
+
+	if (nr_irqs)
+		return;
+
+	kfree(irqd->chip_data);
+	irq_domain_free_irqs_top(domain, virq, nr_irqs);
+}
+
+static int bridge_domain_activate(struct irq_domain *domain,
+				  struct irq_data *irqd, bool reserve)
+{
+	struct bridge_irq_chip_data *data = irqd->chip_data;
+	struct bridge_controller *bc = data->bc;
+	int bit = irqd->parent_data->hwirq;
+	int pin = irqd->hwirq;
+	u32 device;
+
+	bridge_write(bc, b_int_addr[pin].addr,
+		     (0x20000 | bit | (data->nasid << 8)));
+	bridge_set(bc, b_int_enable, (1 << pin));
+	bridge_set(bc, b_int_enable, 0x7ffffe00); /* more stuff in int_enable */
+
+	/*
+	 * Enable sending of an interrupt clear packt to the hub on a high to
+	 * low transition of the interrupt pin.
+	 *
+	 * IRIX sets additional bits in the address which are documented as
+	 * reserved in the bridge docs.
+	 */
+	bridge_set(bc, b_int_mode, (1UL << pin));
+
+	/*
+	 * We assume the bridge to have a 1:1 mapping between devices
+	 * (slots) and intr pins.
+	 */
+	device = bridge_read(bc, b_int_device);
+	device &= ~(7 << (pin*3));
+	device |= (pin << (pin*3));
+	bridge_write(bc, b_int_device, device);
+
+	bridge_read(bc, b_wid_tflush);
+	return 0;
+}
+
+static void bridge_domain_deactivate(struct irq_domain *domain,
+				     struct irq_data *irqd)
+{
+	struct bridge_irq_chip_data *data = irqd->chip_data;
+
+	bridge_clr(data->bc, b_int_enable, (1 << irqd->hwirq));
+	bridge_read(data->bc, b_wid_tflush);
+}
+
+static const struct irq_domain_ops bridge_domain_ops = {
+	.alloc      = bridge_domain_alloc,
+	.free       = bridge_domain_free,
+	.activate   = bridge_domain_activate,
+	.deactivate = bridge_domain_deactivate
+};
+
 /*
  * All observed requests have pin == 1. We could have a global here, that
  * gets incremented and returned every time - unfortunately, pci_map_irq
@@ -336,11 +459,16 @@ static struct pci_ops bridge_pci_ops = {
 static int bridge_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	struct bridge_controller *bc = BRIDGE_CONTROLLER(dev->bus);
+	struct irq_alloc_info info;
 	int irq;
 
 	irq = bc->pci_int[slot];
 	if (irq == -1) {
-		irq = request_bridge_irq(bc, slot);
+		info.ctrl = bc;
+		info.nasid = bc->nasid;
+		info.pin = slot;
+
+		irq = irq_domain_alloc_irqs(bc->domain, 1, bc->nasid, &info);
 		if (irq < 0)
 			return irq;
 
@@ -351,13 +479,22 @@ static int bridge_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 static int bridge_probe(struct platform_device *pdev)
 {
+	struct xtalk_bridge_platform_data *bd = dev_get_platdata(&pdev->dev);
 	struct device *dev = &pdev->dev;
 	struct bridge_controller *bc;
 	struct pci_host_bridge *host;
+	struct irq_domain *domain;
+	struct fwnode_handle *fn;
 	unsigned long offset;
 	int slot;
 	int err;
-	struct xtalk_bridge_platform_data *bd = dev_get_platdata(&pdev->dev);
+
+	fn = irq_domain_alloc_named_fwnode("BRIDGE");
+	domain = irq_domain_create_hierarchy(NULL, 0, 8, fn,
+					     &bridge_domain_ops, NULL);
+	irq_domain_free_fwnode(fn);
+	if (!domain)
+		return -ENOMEM;
 
 	offset = NODE_OFFSET(bd->nasid);
 
@@ -384,6 +521,8 @@ static int bridge_probe(struct platform_device *pdev)
 	bc->busn.end		= 0xff;
 	bc->busn.flags		= IORESOURCE_BUS;
 
+	bc->domain		= domain;
+
 	pci_add_resource_offset(&host->windows, &bc->mem, offset);
 	pci_add_resource_offset(&host->windows, &bc->io, offset);
 	pci_add_resource(&host->windows, &bc->busn);
@@ -462,7 +601,9 @@ static int bridge_probe(struct platform_device *pdev)
 static int bridge_remove(struct platform_device *pdev)
 {
 	struct pci_bus *bus = platform_get_drvdata(pdev);
+	struct bridge_controller *bc = BRIDGE_CONTROLLER(bus);
 
+	irq_domain_remove(bc->domain);
 	pci_lock_rescan_remove();
 	pci_stop_root_bus(bus);
 	pci_remove_root_bus(bus);
-- 
2.13.7

