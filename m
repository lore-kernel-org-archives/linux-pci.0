Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5497DC282C3
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 17:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 104AC218AF
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 17:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbfAXRrz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 12:47:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:51376 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727991AbfAXRrt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jan 2019 12:47:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 764C2B0DE;
        Thu, 24 Jan 2019 17:47:45 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 5/7] MIPS: SGI-IP27: rework HUB interrupts
Date:   Thu, 24 Jan 2019 18:47:26 +0100
Message-Id: <20190124174728.28812-6-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190124174728.28812-1-tbogendoerfer@suse.de>
References: <20190124174728.28812-1-tbogendoerfer@suse.de>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This commit rearranges the HUB interrupt code by using MIPS_IRQ_CPU
interrupt handling code and modern Linux IRQ framework features to get
rid of global and per cpu arrays. It also adds support for irq affinity
setting.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 arch/mips/Kconfig                        |   1 +
 arch/mips/include/asm/mach-ip27/irq.h    |  12 +-
 arch/mips/include/asm/mach-ip27/mmzone.h |   2 -
 arch/mips/include/asm/pci/bridge.h       |   4 +-
 arch/mips/pci/pci-ip27.c                 |  18 +-
 arch/mips/sgi-ip27/Makefile              |   3 +-
 arch/mips/sgi-ip27/ip27-init.c           |  26 +--
 arch/mips/sgi-ip27/ip27-irq-pci.c        | 264 -------------------------
 arch/mips/sgi-ip27/ip27-irq.c            | 326 ++++++++++++++++++++++---------
 arch/mips/sgi-ip27/ip27-irqno.c          |  48 -----
 arch/mips/sgi-ip27/ip27-timer.c          |  42 +---
 11 files changed, 250 insertions(+), 496 deletions(-)
 delete mode 100644 arch/mips/sgi-ip27/ip27-irq-pci.c
 delete mode 100644 arch/mips/sgi-ip27/ip27-irqno.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 0d14f51d0002..7d7f5d79af41 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -676,6 +676,7 @@ config SGI_IP27
 	select DEFAULT_SGI_PARTITION
 	select SYS_HAS_EARLY_PRINTK
 	select HAVE_PCI
+	select IRQ_MIPS_CPU
 	select NR_CPUS_DEFAULT_64
 	select SYS_HAS_CPU_R10000
 	select SYS_SUPPORTS_64BIT_KERNEL
diff --git a/arch/mips/include/asm/mach-ip27/irq.h b/arch/mips/include/asm/mach-ip27/irq.h
index b0b7261ff3ad..fd91c58aaf7d 100644
--- a/arch/mips/include/asm/mach-ip27/irq.h
+++ b/arch/mips/include/asm/mach-ip27/irq.h
@@ -10,13 +10,15 @@
 #ifndef __ASM_MACH_IP27_IRQ_H
 #define __ASM_MACH_IP27_IRQ_H
 
-/*
- * A hardwired interrupt number is completely stupid for this system - a
- * large configuration might have thousands if not tenthousands of
- * interrupts.
- */
 #define NR_IRQS 256
 
 #include_next <irq.h>
 
+#define IP27_HUB_PEND0_IRQ	(MIPS_CPU_IRQ_BASE + 2)
+#define IP27_HUB_PEND1_IRQ	(MIPS_CPU_IRQ_BASE + 3)
+#define IP27_RT_TIMER_IRQ	(MIPS_CPU_IRQ_BASE + 4)
+
+#define IP27_HUB_IRQ_BASE	(MIPS_CPU_IRQ_BASE + 8)
+#define IP27_HUB_IRQ_COUNT	128
+
 #endif /* __ASM_MACH_IP27_IRQ_H */
diff --git a/arch/mips/include/asm/mach-ip27/mmzone.h b/arch/mips/include/asm/mach-ip27/mmzone.h
index 2ed3094dee07..8114253f5976 100644
--- a/arch/mips/include/asm/mach-ip27/mmzone.h
+++ b/arch/mips/include/asm/mach-ip27/mmzone.h
@@ -12,7 +12,6 @@
 
 struct slice_data {
 	unsigned long irq_enable_mask[2];
-	int level_to_irq[LEVELS_PER_SLICE];
 };
 
 struct hub_data {
@@ -20,7 +19,6 @@ struct hub_data {
 	DECLARE_BITMAP(h_bigwin_used, HUB_NUM_BIG_WINDOW);
 	cpumask_t	h_cpus;
 	unsigned long slice_map;
-	unsigned long irq_alloc_mask[2];
 	struct slice_data slice[2];
 };
 
diff --git a/arch/mips/include/asm/pci/bridge.h b/arch/mips/include/asm/pci/bridge.h
index 6155618ce45b..1fc60b1ae349 100644
--- a/arch/mips/include/asm/pci/bridge.h
+++ b/arch/mips/include/asm/pci/bridge.h
@@ -823,7 +823,6 @@ struct bridge_controller {
 	struct bridge_regs	*base;
 	nasid_t			nasid;
 	unsigned int		widget_id;
-	unsigned int		irq_cpu;
 	u64			baddr;
 	unsigned int		pci_int[8];
 };
@@ -838,8 +837,7 @@ struct bridge_controller {
 #define bridge_clr(bc, reg, val)	\
 	__raw_writel(__raw_readl(&bc->base->reg) & ~(val), &bc->base->reg)
 
-extern void register_bridge_irq(unsigned int irq);
-extern int request_bridge_irq(struct bridge_controller *bc);
+extern int request_bridge_irq(struct bridge_controller *bc, int pin);
 
 extern struct pci_ops bridge_pci_ops;
 
diff --git a/arch/mips/pci/pci-ip27.c b/arch/mips/pci/pci-ip27.c
index 7cf50290a6d9..3c177b4d0609 100644
--- a/arch/mips/pci/pci-ip27.c
+++ b/arch/mips/pci/pci-ip27.c
@@ -24,22 +24,11 @@
 #define MAX_PCI_BUSSES		40
 
 /*
- * Max #PCI devices (like scsi controllers) we handle on a bus.
- */
-#define MAX_DEVICES_PER_PCIBUS	8
-
-/*
  * XXX: No kmalloc available when we do our crosstalk scan,
  *	we should try to move it later in the boot process.
  */
 static struct bridge_controller bridges[MAX_PCI_BUSSES];
 
-/*
- * Translate from irq to software PCI bus number and PCI slot.
- */
-struct bridge_controller *irq_to_bridge[MAX_PCI_BUSSES * MAX_DEVICES_PER_PCIBUS];
-int irq_to_slot[MAX_PCI_BUSSES * MAX_DEVICES_PER_PCIBUS];
-
 extern struct pci_ops bridge_pci_ops;
 
 int bridge_probe(nasid_t nasid, int widget_id, int masterwid)
@@ -77,7 +66,6 @@ int bridge_probe(nasid_t nasid, int widget_id, int masterwid)
 	bc->io.end		= ~0UL;
 	bc->io.flags		= IORESOURCE_IO;
 
-	bc->irq_cpu = smp_processor_id();
 	bc->widget_id = widget_id;
 	bc->nasid = nasid;
 
@@ -165,16 +153,12 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 
 	irq = bc->pci_int[slot];
 	if (irq == -1) {
-		irq = request_bridge_irq(bc);
+		irq = request_bridge_irq(bc, slot);
 		if (irq < 0)
 			return irq;
 
 		bc->pci_int[slot] = irq;
 	}
-
-	irq_to_bridge[irq] = bc;
-	irq_to_slot[irq] = slot;
-
 	dev->irq = irq;
 
 	return 0;
diff --git a/arch/mips/sgi-ip27/Makefile b/arch/mips/sgi-ip27/Makefile
index 73502fda13ee..27c14ede191e 100644
--- a/arch/mips/sgi-ip27/Makefile
+++ b/arch/mips/sgi-ip27/Makefile
@@ -3,10 +3,9 @@
 # Makefile for the IP27 specific kernel interface routines under Linux.
 #
 
-obj-y	:= ip27-berr.o ip27-irq.o ip27-irqno.o ip27-init.o ip27-klconfig.o \
+obj-y	:= ip27-berr.o ip27-irq.o ip27-init.o ip27-klconfig.o \
 	   ip27-klnuma.o ip27-memory.o ip27-nmi.o ip27-reset.o ip27-timer.o \
 	   ip27-hubio.o ip27-xtalk.o
 
 obj-$(CONFIG_EARLY_PRINTK)	+= ip27-console.o
-obj-$(CONFIG_PCI)		+= ip27-irq-pci.o
 obj-$(CONFIG_SMP)		+= ip27-smp.o
diff --git a/arch/mips/sgi-ip27/ip27-init.c b/arch/mips/sgi-ip27/ip27-init.c
index aba985cf07c0..395c4aff9493 100644
--- a/arch/mips/sgi-ip27/ip27-init.c
+++ b/arch/mips/sgi-ip27/ip27-init.c
@@ -56,7 +56,6 @@ static void per_hub_init(cnodeid_t cnode)
 {
 	struct hub_data *hub = hub_data(cnode);
 	nasid_t nasid = COMPACT_TO_NASID_NODEID(cnode);
-	int i;
 
 	cpumask_set_cpu(smp_processor_id(), &hub->h_cpus);
 
@@ -87,24 +86,6 @@ static void per_hub_init(cnodeid_t cnode)
 		__flush_cache_all();
 	}
 #endif
-
-	/*
-	 * Some interrupts are reserved by hardware or by software convention.
-	 * Mark these as reserved right away so they won't be used accidentally
-	 * later.
-	 */
-	for (i = 0; i <= BASE_PCI_IRQ; i++) {
-		__set_bit(i, hub->irq_alloc_mask);
-		LOCAL_HUB_CLR_INTR(INT_PEND0_BASELVL + i);
-	}
-
-	__set_bit(IP_PEND0_6_63, hub->irq_alloc_mask);
-	LOCAL_HUB_S(PI_INT_PEND_MOD, IP_PEND0_6_63);
-
-	for (i = NI_BRDCAST_ERR_A; i <= MSC_PANIC_INTR; i++) {
-		__set_bit(i, hub->irq_alloc_mask);
-		LOCAL_HUB_CLR_INTR(INT_PEND1_BASELVL + i);
-	}
 }
 
 void per_cpu_init(void)
@@ -114,7 +95,6 @@ void per_cpu_init(void)
 	cnodeid_t cnode = get_compact_nodeid();
 	struct hub_data *hub = hub_data(cnode);
 	struct slice_data *si = hub->slice + slice;
-	int i;
 
 	if (test_and_set_bit(slice, &hub->slice_map))
 		return;
@@ -123,9 +103,6 @@ void per_cpu_init(void)
 
 	per_hub_init(cnode);
 
-	for (i = 0; i < LEVELS_PER_SLICE; i++)
-		si->level_to_irq[i] = -1;
-
 	/*
 	 * We use this so we can find the local hub's data as fast as only
 	 * possible.
@@ -138,7 +115,8 @@ void per_cpu_init(void)
 	/* Install our NMI handler if symmon hasn't installed one. */
 	install_cpu_nmi_handler(cputoslice(cpu));
 
-	set_c0_status(SRB_DEV0 | SRB_DEV1);
+	enable_percpu_irq(IP27_HUB_PEND0_IRQ, IRQ_TYPE_NONE);
+	enable_percpu_irq(IP27_HUB_PEND1_IRQ, IRQ_TYPE_NONE);
 }
 
 /*
diff --git a/arch/mips/sgi-ip27/ip27-irq-pci.c b/arch/mips/sgi-ip27/ip27-irq-pci.c
deleted file mode 100644
index a00a23b32a2a..000000000000
--- a/arch/mips/sgi-ip27/ip27-irq-pci.c
+++ /dev/null
@@ -1,264 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * ip27-irq.c: Highlevel interrupt handling for IP27 architecture.
- *
- * Copyright (C) 1999, 2000 Ralf Baechle (ralf@gnu.org)
- * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
- * Copyright (C) 1999 - 2001 Kanoj Sarcar
- */
-
-#undef DEBUG
-
-#include <linux/irq.h>
-#include <linux/errno.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/timex.h>
-#include <linux/smp.h>
-#include <linux/random.h>
-#include <linux/kernel.h>
-#include <linux/kernel_stat.h>
-#include <linux/delay.h>
-#include <linux/bitops.h>
-
-#include <asm/bootinfo.h>
-#include <asm/io.h>
-#include <asm/mipsregs.h>
-
-#include <asm/processor.h>
-#include <asm/pci/bridge.h>
-#include <asm/sn/addrs.h>
-#include <asm/sn/agent.h>
-#include <asm/sn/arch.h>
-#include <asm/sn/hub.h>
-#include <asm/sn/intr.h>
-
-/*
- * Linux has a controller-independent x86 interrupt architecture.
- * every controller has a 'controller-template', that is used
- * by the main code to do the right thing. Each driver-visible
- * interrupt source is transparently wired to the appropriate
- * controller. Thus drivers need not be aware of the
- * interrupt-controller.
- *
- * Various interrupt controllers we handle: 8259 PIC, SMP IO-APIC,
- * PIIX4's internal 8259 PIC and SGI's Visual Workstation Cobalt (IO-)APIC.
- * (IO-APICs assumed to be messaging to Pentium local-APICs)
- *
- * the code is designed to be easily extended with new/different
- * interrupt controllers, without having to do assembly magic.
- */
-
-extern struct bridge_controller *irq_to_bridge[];
-extern int irq_to_slot[];
-
-/*
- * use these macros to get the encoded nasid and widget id
- * from the irq value
- */
-#define IRQ_TO_BRIDGE(i)		irq_to_bridge[(i)]
-#define SLOT_FROM_PCI_IRQ(i)		irq_to_slot[i]
-
-static inline int alloc_level(int cpu, int irq)
-{
-	struct hub_data *hub = hub_data(cpu_to_node(cpu));
-	struct slice_data *si = cpu_data[cpu].data;
-	int level;
-
-	level = find_first_zero_bit(hub->irq_alloc_mask, LEVELS_PER_SLICE);
-	if (level >= LEVELS_PER_SLICE)
-		panic("Cpu %d flooded with devices", cpu);
-
-	__set_bit(level, hub->irq_alloc_mask);
-	si->level_to_irq[level] = irq;
-
-	return level;
-}
-
-static inline int find_level(cpuid_t *cpunum, int irq)
-{
-	int cpu, i;
-
-	for_each_online_cpu(cpu) {
-		struct slice_data *si = cpu_data[cpu].data;
-
-		for (i = BASE_PCI_IRQ; i < LEVELS_PER_SLICE; i++)
-			if (si->level_to_irq[i] == irq) {
-				*cpunum = cpu;
-
-				return i;
-			}
-	}
-
-	panic("Could not identify cpu/level for irq %d", irq);
-}
-
-static int intr_connect_level(int cpu, int bit)
-{
-	nasid_t nasid = COMPACT_TO_NASID_NODEID(cpu_to_node(cpu));
-	struct slice_data *si = cpu_data[cpu].data;
-
-	set_bit(bit, si->irq_enable_mask);
-
-	if (!cputoslice(cpu)) {
-		REMOTE_HUB_S(nasid, PI_INT_MASK0_A, si->irq_enable_mask[0]);
-		REMOTE_HUB_S(nasid, PI_INT_MASK1_A, si->irq_enable_mask[1]);
-	} else {
-		REMOTE_HUB_S(nasid, PI_INT_MASK0_B, si->irq_enable_mask[0]);
-		REMOTE_HUB_S(nasid, PI_INT_MASK1_B, si->irq_enable_mask[1]);
-	}
-
-	return 0;
-}
-
-static int intr_disconnect_level(int cpu, int bit)
-{
-	nasid_t nasid = COMPACT_TO_NASID_NODEID(cpu_to_node(cpu));
-	struct slice_data *si = cpu_data[cpu].data;
-
-	clear_bit(bit, si->irq_enable_mask);
-
-	if (!cputoslice(cpu)) {
-		REMOTE_HUB_S(nasid, PI_INT_MASK0_A, si->irq_enable_mask[0]);
-		REMOTE_HUB_S(nasid, PI_INT_MASK1_A, si->irq_enable_mask[1]);
-	} else {
-		REMOTE_HUB_S(nasid, PI_INT_MASK0_B, si->irq_enable_mask[0]);
-		REMOTE_HUB_S(nasid, PI_INT_MASK1_B, si->irq_enable_mask[1]);
-	}
-
-	return 0;
-}
-
-/* Startup one of the (PCI ...) IRQs routes over a bridge.  */
-static unsigned int startup_bridge_irq(struct irq_data *d)
-{
-	struct bridge_controller *bc;
-	int pin, swlevel;
-	cpuid_t cpu;
-	u64 device;
-
-	pin = SLOT_FROM_PCI_IRQ(d->irq);
-	bc = IRQ_TO_BRIDGE(d->irq);
-
-	pr_debug("bridge_startup(): irq= 0x%x  pin=%d\n", d->irq, pin);
-	/*
-	 * "map" irq to a swlevel greater than 6 since the first 6 bits
-	 * of INT_PEND0 are taken
-	 */
-	swlevel = find_level(&cpu, d->irq);
-	bridge_write(bc, b_int_addr[pin].addr,
-		     (0x20000 | swlevel | (bc->nasid << 8)));
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
-	intr_connect_level(cpu, swlevel);
-
-	return 0;	/* Never anything pending.  */
-}
-
-/* Shutdown one of the (PCI ...) IRQs routes over a bridge.  */
-static void shutdown_bridge_irq(struct irq_data *d)
-{
-	struct bridge_controller *bc = IRQ_TO_BRIDGE(d->irq);
-	int pin, swlevel;
-	cpuid_t cpu;
-
-	pr_debug("bridge_shutdown: irq 0x%x\n", d->irq);
-	pin = SLOT_FROM_PCI_IRQ(d->irq);
-
-	/*
-	 * map irq to a swlevel greater than 6 since the first 6 bits
-	 * of INT_PEND0 are taken
-	 */
-	swlevel = find_level(&cpu, d->irq);
-	intr_disconnect_level(cpu, swlevel);
-
-	bridge_clr(bc, b_int_enable, (1 << pin));
-	bridge_read(bc, b_wid_tflush);
-}
-
-static inline void enable_bridge_irq(struct irq_data *d)
-{
-	cpuid_t cpu;
-	int swlevel;
-
-	swlevel = find_level(&cpu, d->irq);	/* Criminal offence */
-	intr_connect_level(cpu, swlevel);
-}
-
-static inline void disable_bridge_irq(struct irq_data *d)
-{
-	cpuid_t cpu;
-	int swlevel;
-
-	swlevel = find_level(&cpu, d->irq);	/* Criminal offence */
-	intr_disconnect_level(cpu, swlevel);
-}
-
-static struct irq_chip bridge_irq_type = {
-	.name		= "bridge",
-	.irq_startup	= startup_bridge_irq,
-	.irq_shutdown	= shutdown_bridge_irq,
-	.irq_mask	= disable_bridge_irq,
-	.irq_unmask	= enable_bridge_irq,
-};
-
-void register_bridge_irq(unsigned int irq)
-{
-	irq_set_chip_and_handler(irq, &bridge_irq_type, handle_level_irq);
-}
-
-int request_bridge_irq(struct bridge_controller *bc)
-{
-	int irq = allocate_irqno();
-	int swlevel, cpu;
-	nasid_t nasid;
-
-	if (irq < 0)
-		return irq;
-
-	/*
-	 * "map" irq to a swlevel greater than 6 since the first 6 bits
-	 * of INT_PEND0 are taken
-	 */
-	cpu = bc->irq_cpu;
-	swlevel = alloc_level(cpu, irq);
-	if (unlikely(swlevel < 0)) {
-		free_irqno(irq);
-
-		return -EAGAIN;
-	}
-
-	/* Make sure it's not already pending when we connect it. */
-	nasid = COMPACT_TO_NASID_NODEID(cpu_to_node(cpu));
-	REMOTE_HUB_CLR_INTR(nasid, swlevel);
-
-	intr_connect_level(cpu, swlevel);
-
-	register_bridge_irq(irq);
-
-	return irq;
-}
diff --git a/arch/mips/sgi-ip27/ip27-irq.c b/arch/mips/sgi-ip27/ip27-irq.c
index f37155ef7ed9..a9db2f28b609 100644
--- a/arch/mips/sgi-ip27/ip27-irq.c
+++ b/arch/mips/sgi-ip27/ip27-irq.c
@@ -7,67 +7,232 @@
  * Copyright (C) 1999 - 2001 Kanoj Sarcar
  */
 
-#undef DEBUG
-
-#include <linux/init.h>
-#include <linux/irq.h>
-#include <linux/errno.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/types.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/ioport.h>
-#include <linux/timex.h>
-#include <linux/smp.h>
-#include <linux/random.h>
 #include <linux/kernel.h>
-#include <linux/kernel_stat.h>
-#include <linux/delay.h>
 #include <linux/bitops.h>
 
-#include <asm/bootinfo.h>
 #include <asm/io.h>
-#include <asm/mipsregs.h>
-
-#include <asm/processor.h>
+#include <asm/irq_cpu.h>
+#include <asm/pci/bridge.h>
 #include <asm/sn/addrs.h>
 #include <asm/sn/agent.h>
 #include <asm/sn/arch.h>
 #include <asm/sn/hub.h>
 #include <asm/sn/intr.h>
 
-/*
- * Linux has a controller-independent x86 interrupt architecture.
- * every controller has a 'controller-template', that is used
- * by the main code to do the right thing. Each driver-visible
- * interrupt source is transparently wired to the appropriate
- * controller. Thus drivers need not be aware of the
- * interrupt-controller.
- *
- * Various interrupt controllers we handle: 8259 PIC, SMP IO-APIC,
- * PIIX4's internal 8259 PIC and SGI's Visual Workstation Cobalt (IO-)APIC.
- * (IO-APICs assumed to be messaging to Pentium local-APICs)
- *
- * the code is designed to be easily extended with new/different
- * interrupt controllers, without having to do assembly magic.
- */
+struct hub_irq_data {
+	struct bridge_controller *bc;
+	u64	irq_mask_addr[2];
+	cpuid_t	cpu;
+	int	bit;
+	int	pin;
+};
 
-extern asmlinkage void ip27_irq(void);
+static DECLARE_BITMAP(hub_irq_map, IP27_HUB_IRQ_COUNT);
 
-/*
- * Find first bit set
- */
-static int ms1bit(unsigned long x)
+static inline int alloc_level(void)
+{
+	int level;
+
+again:
+	level = find_first_zero_bit(hub_irq_map, LEVELS_PER_SLICE);
+	if (level >= LEVELS_PER_SLICE)
+		return -ENOSPC;
+
+	if (test_and_set_bit(level, hub_irq_map))
+		goto again;
+
+	return level;
+}
+
+static void enable_hub_irq(struct irq_data *d)
+{
+	struct hub_irq_data *hd = irq_data_get_irq_chip_data(d);
+	struct slice_data *si = cpu_data[hd->cpu].data;
+
+	set_bit(hd->bit, si->irq_enable_mask);
+	HUB_S(hd->irq_mask_addr[0], si->irq_enable_mask[0]);
+	HUB_S(hd->irq_mask_addr[1], si->irq_enable_mask[1]);
+}
+
+static void disable_hub_irq(struct irq_data *d)
+{
+	struct hub_irq_data *hd = irq_data_get_irq_chip_data(d);
+	struct slice_data *si = cpu_data[hd->cpu].data;
+
+	clear_bit(hd->bit, si->irq_enable_mask);
+	HUB_S(hd->irq_mask_addr[0], si->irq_enable_mask[0]);
+	HUB_S(hd->irq_mask_addr[1], si->irq_enable_mask[1]);
+}
+
+static unsigned int startup_bridge_irq(struct irq_data *d)
 {
-	int b = 0, s;
+	struct hub_irq_data *hd = irq_data_get_irq_chip_data(d);
+	struct bridge_controller *bc;
+	nasid_t nasid;
+	u32 device;
+	int pin;
+
+	if (!hd)
+		return -EINVAL;
+
+	pin = hd->pin;
+	bc = hd->bc;
+
+	nasid = COMPACT_TO_NASID_NODEID(cpu_to_node(hd->cpu));
+	bridge_write(bc, b_int_addr[pin].addr,
+		     (0x20000 | hd->bit | (nasid << 8)));
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
 
-	s = 16; if (x >> 16 == 0) s = 0; b += s; x >>= s;
-	s =  8; if (x >>  8 == 0) s = 0; b += s; x >>= s;
-	s =  4; if (x >>  4 == 0) s = 0; b += s; x >>= s;
-	s =  2; if (x >>  2 == 0) s = 0; b += s; x >>= s;
-	s =  1; if (x >>  1 == 0) s = 0; b += s;
+	bridge_read(bc, b_wid_tflush);
 
-	return b;
+	enable_hub_irq(d);
+
+	return 0;	/* Never anything pending.  */
+}
+
+static void shutdown_bridge_irq(struct irq_data *d)
+{
+	struct hub_irq_data *hd = irq_data_get_irq_chip_data(d);
+	struct bridge_controller *bc;
+	int pin = hd->pin;
+
+	if (!hd)
+		return;
+
+	disable_hub_irq(d);
+
+	bc = hd->bc;
+	bridge_clr(bc, b_int_enable, (1 << pin));
+	bridge_read(bc, b_wid_tflush);
+}
+
+static void setup_hub_mask(struct hub_irq_data *hd, const struct cpumask *mask)
+{
+	nasid_t nasid;
+	int cpu;
+
+	cpu = cpumask_first_and(mask, cpu_online_mask);
+	nasid = COMPACT_TO_NASID_NODEID(cpu_to_node(cpu));
+	hd->cpu = cpu;
+	if (!cputoslice(cpu)) {
+		hd->irq_mask_addr[0] = REMOTE_HUB_ADDR(nasid, PI_INT_MASK0_A);
+		hd->irq_mask_addr[1] = REMOTE_HUB_ADDR(nasid, PI_INT_MASK1_A);
+	} else {
+		hd->irq_mask_addr[0] = REMOTE_HUB_ADDR(nasid, PI_INT_MASK0_B);
+		hd->irq_mask_addr[1] = REMOTE_HUB_ADDR(nasid, PI_INT_MASK1_B);
+	}
+
+	/* Make sure it's not already pending when we connect it. */
+	REMOTE_HUB_CLR_INTR(nasid, hd->bit);
+}
+
+static int set_affinity_hub_irq(struct irq_data *d, const struct cpumask *mask,
+				bool force)
+{
+	struct hub_irq_data *hd = irq_data_get_irq_chip_data(d);
+
+	if (!hd)
+		return -EINVAL;
+
+	if (irqd_is_started(d))
+		disable_hub_irq(d);
+
+	setup_hub_mask(hd, mask);
+
+	if (irqd_is_started(d))
+		startup_bridge_irq(d);
+
+	irq_data_update_effective_affinity(d, cpumask_of(hd->cpu));
+
+	return 0;
+}
+
+static struct irq_chip hub_irq_type = {
+	.name		  = "HUB",
+	.irq_startup	  = startup_bridge_irq,
+	.irq_shutdown	  = shutdown_bridge_irq,
+	.irq_mask	  = disable_hub_irq,
+	.irq_unmask	  = enable_hub_irq,
+	.irq_set_affinity = set_affinity_hub_irq,
+};
+
+int request_bridge_irq(struct bridge_controller *bc, int pin)
+{
+	struct hub_irq_data *hd;
+	struct hub_data *hub;
+	struct irq_desc *desc;
+	int swlevel;
+	int irq;
+
+	hd = kzalloc(sizeof(*hd), GFP_KERNEL);
+	if (!hd)
+		return -ENOMEM;
+
+	swlevel = alloc_level();
+	if (unlikely(swlevel < 0)) {
+		kfree(hd);
+		return -EAGAIN;
+	}
+	irq = swlevel + IP27_HUB_IRQ_BASE;
+
+	hd->bc = bc;
+	hd->bit = swlevel;
+	hd->pin = pin;
+	irq_set_chip_data(irq, hd);
+
+	/* use CPU connected to nearest hub */
+	hub = hub_data(NASID_TO_COMPACT_NODEID(bc->nasid));
+	setup_hub_mask(hd, &hub->h_cpus);
+
+	desc = irq_to_desc(irq);
+	desc->irq_common_data.node = bc->nasid;
+	cpumask_copy(desc->irq_common_data.affinity, &hub->h_cpus);
+
+	return irq;
+}
+
+void ip27_hub_irq_init(void)
+{
+	int i;
+
+	for (i = IP27_HUB_IRQ_BASE;
+	     i < (IP27_HUB_IRQ_BASE + IP27_HUB_IRQ_COUNT); i++)
+		irq_set_chip_and_handler(i, &hub_irq_type, handle_level_irq);
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
 }
 
 /*
@@ -82,9 +247,9 @@ static int ms1bit(unsigned long x)
  * Kanoj 05.13.00
  */
 
-static void ip27_do_irq_mask0(void)
+static void ip27_do_irq_mask0(struct irq_desc *desc)
 {
-	int irq, swlevel;
+	int swlevel;
 	u64 pend0, mask0;
 	cpuid_t cpu = smp_processor_id();
 	int pi_int_mask0 =
@@ -98,7 +263,7 @@ static void ip27_do_irq_mask0(void)
 	if (!pend0)
 		return;
 
-	swlevel = ms1bit(pend0);
+	swlevel = __ffs(pend0);
 #ifdef CONFIG_SMP
 	if (pend0 & (1UL << CPU_RESCHED_A_IRQ)) {
 		LOCAL_HUB_CLR_INTR(CPU_RESCHED_A_IRQ);
@@ -119,23 +284,18 @@ static void ip27_do_irq_mask0(void)
 	} else
 #endif
 	{
-		/* "map" swlevel to irq */
-		struct slice_data *si = cpu_data[cpu].data;
-
-		irq = si->level_to_irq[swlevel];
-		do_IRQ(irq);
+		do_IRQ(swlevel + IP27_HUB_IRQ_BASE);
 	}
 
 	LOCAL_HUB_L(PI_INT_PEND0);
 }
 
-static void ip27_do_irq_mask1(void)
+static void ip27_do_irq_mask1(struct irq_desc *desc)
 {
-	int irq, swlevel;
+	int swlevel;
 	u64 pend1, mask1;
 	cpuid_t cpu = smp_processor_id();
 	int pi_int_mask1 = (cputoslice(cpu) == 0) ?  PI_INT_MASK1_A : PI_INT_MASK1_B;
-	struct slice_data *si = cpu_data[cpu].data;
 
 	/* copied from Irix intpend0() */
 	pend1 = LOCAL_HUB_L(PI_INT_PEND1);
@@ -145,62 +305,25 @@ static void ip27_do_irq_mask1(void)
 	if (!pend1)
 		return;
 
-	swlevel = ms1bit(pend1);
-	/* "map" swlevel to irq */
-	irq = si->level_to_irq[swlevel];
-	LOCAL_HUB_CLR_INTR(swlevel);
-	do_IRQ(irq);
+	swlevel = __ffs(pend1);
+	do_IRQ(swlevel + IP27_HUB_IRQ_BASE + 64);
 
 	LOCAL_HUB_L(PI_INT_PEND1);
 }
 
-static void ip27_prof_timer(void)
-{
-	panic("CPU %d got a profiling interrupt", smp_processor_id());
-}
-
-static void ip27_hub_error(void)
-{
-	panic("CPU %d got a hub error interrupt", smp_processor_id());
-}
-
-asmlinkage void plat_irq_dispatch(void)
-{
-	unsigned long pending = read_c0_cause() & read_c0_status();
-	extern unsigned int rt_timer_irq;
-
-	if (pending & CAUSEF_IP4)
-		do_IRQ(rt_timer_irq);
-	else if (pending & CAUSEF_IP2)	/* PI_INT_PEND_0 or CC_PEND_{A|B} */
-		ip27_do_irq_mask0();
-	else if (pending & CAUSEF_IP3)	/* PI_INT_PEND_1 */
-		ip27_do_irq_mask1();
-	else if (pending & CAUSEF_IP5)
-		ip27_prof_timer();
-	else if (pending & CAUSEF_IP6)
-		ip27_hub_error();
-}
-
-void __init arch_init_irq(void)
-{
-}
-
 void install_ipi(void)
 {
 	int slice = LOCAL_HUB_L(PI_CPU_NUM);
 	int cpu = smp_processor_id();
 	struct slice_data *si = cpu_data[cpu].data;
-	struct hub_data *hub = hub_data(cpu_to_node(cpu));
 	int resched, call;
 
 	resched = CPU_RESCHED_A_IRQ + slice;
-	__set_bit(resched, hub->irq_alloc_mask);
-	__set_bit(resched, si->irq_enable_mask);
+	set_bit(resched, si->irq_enable_mask);
 	LOCAL_HUB_CLR_INTR(resched);
 
 	call = CPU_CALL_A_IRQ + slice;
-	__set_bit(call, hub->irq_alloc_mask);
-	__set_bit(call, si->irq_enable_mask);
+	set_bit(call, si->irq_enable_mask);
 	LOCAL_HUB_CLR_INTR(call);
 
 	if (slice == 0) {
@@ -211,3 +334,14 @@ void install_ipi(void)
 		LOCAL_HUB_S(PI_INT_MASK1_B, si->irq_enable_mask[1]);
 	}
 }
+
+void __init arch_init_irq(void)
+{
+	mips_cpu_irq_init();
+	ip27_hub_irq_init();
+
+	irq_set_percpu_devid(IP27_HUB_PEND0_IRQ);
+	irq_set_chained_handler(IP27_HUB_PEND0_IRQ, ip27_do_irq_mask0);
+	irq_set_percpu_devid(IP27_HUB_PEND1_IRQ);
+	irq_set_chained_handler(IP27_HUB_PEND1_IRQ, ip27_do_irq_mask1);
+}
diff --git a/arch/mips/sgi-ip27/ip27-irqno.c b/arch/mips/sgi-ip27/ip27-irqno.c
deleted file mode 100644
index 957ab58e1c00..000000000000
--- a/arch/mips/sgi-ip27/ip27-irqno.c
+++ /dev/null
@@ -1,48 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-#include <linux/init.h>
-#include <linux/irq.h>
-#include <linux/types.h>
-
-#include <asm/barrier.h>
-
-static DECLARE_BITMAP(irq_map, NR_IRQS);
-
-int allocate_irqno(void)
-{
-	int irq;
-
-again:
-	irq = find_first_zero_bit(irq_map, NR_IRQS);
-
-	if (irq >= NR_IRQS)
-		return -ENOSPC;
-
-	if (test_and_set_bit(irq, irq_map))
-		goto again;
-
-	return irq;
-}
-
-/*
- * Allocate the 16 legacy interrupts for i8259 devices.	 This happens early
- * in the kernel initialization so treating allocation failure as BUG() is
- * ok.
- */
-void __init alloc_legacy_irqno(void)
-{
-	int i;
-
-	for (i = 0; i <= 16; i++)
-		BUG_ON(test_and_set_bit(i, irq_map));
-}
-
-void free_irqno(unsigned int irq)
-{
-	smp_mb__before_atomic();
-	clear_bit(irq, irq_map);
-	smp_mb__after_atomic();
-}
diff --git a/arch/mips/sgi-ip27/ip27-timer.c b/arch/mips/sgi-ip27/ip27-timer.c
index 9d55247533a5..9b4b9ac621a3 100644
--- a/arch/mips/sgi-ip27/ip27-timer.c
+++ b/arch/mips/sgi-ip27/ip27-timer.c
@@ -38,20 +38,6 @@
 #include <asm/sn/sn0/hubio.h>
 #include <asm/pci/bridge.h>
 
-static void enable_rt_irq(struct irq_data *d)
-{
-}
-
-static void disable_rt_irq(struct irq_data *d)
-{
-}
-
-static struct irq_chip rt_irq_type = {
-	.name		= "SN HUB RT timer",
-	.irq_mask	= disable_rt_irq,
-	.irq_unmask	= enable_rt_irq,
-};
-
 static int rt_next_event(unsigned long delta, struct clock_event_device *evt)
 {
 	unsigned int cpu = smp_processor_id();
@@ -65,8 +51,6 @@ static int rt_next_event(unsigned long delta, struct clock_event_device *evt)
 	return LOCAL_HUB_L(PI_RT_COUNT) >= cnt ? -ETIME : 0;
 }
 
-unsigned int rt_timer_irq;
-
 static DEFINE_PER_CPU(struct clock_event_device, hub_rt_clockevent);
 static DEFINE_PER_CPU(char [11], hub_rt_name);
 
@@ -87,6 +71,7 @@ static irqreturn_t hub_rt_counter_handler(int irq, void *dev_id)
 
 struct irqaction hub_rt_irqaction = {
 	.handler	= hub_rt_counter_handler,
+	.percpu_dev_id	= &hub_rt_clockevent,
 	.flags		= IRQF_PERCPU | IRQF_TIMER,
 	.name		= "hub-rt",
 };
@@ -107,7 +92,6 @@ void hub_rt_clock_event_init(void)
 	unsigned int cpu = smp_processor_id();
 	struct clock_event_device *cd = &per_cpu(hub_rt_clockevent, cpu);
 	unsigned char *name = per_cpu(hub_rt_name, cpu);
-	int irq = rt_timer_irq;
 
 	sprintf(name, "hub-rt %d", cpu);
 	cd->name		= name;
@@ -118,29 +102,19 @@ void hub_rt_clock_event_init(void)
 	cd->min_delta_ns	= clockevent_delta2ns(0x300, cd);
 	cd->min_delta_ticks	= 0x300;
 	cd->rating		= 200;
-	cd->irq			= irq;
+	cd->irq			= IP27_RT_TIMER_IRQ;
 	cd->cpumask		= cpumask_of(cpu);
 	cd->set_next_event	= rt_next_event;
 	clockevents_register_device(cd);
+
+	enable_percpu_irq(IP27_RT_TIMER_IRQ, IRQ_TYPE_NONE);
 }
 
 static void __init hub_rt_clock_event_global_init(void)
 {
-	int irq;
-
-	do {
-		smp_wmb();
-		irq = rt_timer_irq;
-		if (irq)
-			break;
-
-		irq = allocate_irqno();
-		if (irq < 0)
-			panic("Allocation of irq number for timer failed");
-	} while (xchg(&rt_timer_irq, irq));
-
-	irq_set_chip_and_handler(irq, &rt_irq_type, handle_percpu_irq);
-	setup_irq(irq, &hub_rt_irqaction);
+	irq_set_handler(IP27_RT_TIMER_IRQ, handle_percpu_devid_irq);
+	irq_set_percpu_devid(IP27_RT_TIMER_IRQ);
+	setup_percpu_irq(IP27_RT_TIMER_IRQ, &hub_rt_irqaction);
 }
 
 static u64 hub_rt_read(struct clocksource *cs)
@@ -194,8 +168,6 @@ void cpu_time_init(void)
 		panic("No information about myself?");
 
 	printk("CPU %d clock is %dMHz.\n", smp_processor_id(), cpu->cpu_speed);
-
-	set_c0_status(SRB_TIMOCLK);
 }
 
 void hub_rtc_init(cnodeid_t cnode)
-- 
2.13.7

