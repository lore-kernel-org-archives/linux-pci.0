Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FDDC282C6
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 17:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1CD5218AF
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 17:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfAXRrz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 12:47:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:51374 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729005AbfAXRrt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jan 2019 12:47:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7C20EB0E2;
        Thu, 24 Jan 2019 17:47:45 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 7/7] MIPS: SGI-IP27: abstract chipset irq from bridge
Date:   Thu, 24 Jan 2019 18:47:28 +0100
Message-Id: <20190124174728.28812-8-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190124174728.28812-1-tbogendoerfer@suse.de>
References: <20190124174728.28812-1-tbogendoerfer@suse.de>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bridge ASIC is widely used in different SGI systems, but the connected
chipset is either HUB, HEART or BEDROCK. This commit abstracts chipset
irq setup and moves the bridge related irq setup to bridge code.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 arch/mips/include/asm/pci/bridge.h        |  2 -
 arch/mips/include/asm/sn/intr.h           |  7 ++++
 arch/mips/sgi-ip27/ip27-irq.c             | 67 ++++++++-----------------------
 drivers/pci/controller/pci-xtalk-bridge.c | 64 ++++++++++++++++++++++++++++-
 4 files changed, 87 insertions(+), 53 deletions(-)

diff --git a/arch/mips/include/asm/pci/bridge.h b/arch/mips/include/asm/pci/bridge.h
index af2da166815e..9b13bda5c3f6 100644
--- a/arch/mips/include/asm/pci/bridge.h
+++ b/arch/mips/include/asm/pci/bridge.h
@@ -835,6 +835,4 @@ struct bridge_controller {
 #define bridge_clr(bc, reg, val)	\
 	__raw_writel(__raw_readl(&bc->base->reg) & ~(val), &bc->base->reg)
 
-extern int request_bridge_irq(struct bridge_controller *bc, int pin);
-
 #endif /* _ASM_PCI_BRIDGE_H */
diff --git a/arch/mips/include/asm/sn/intr.h b/arch/mips/include/asm/sn/intr.h
index fc1348193957..9c9f2e883a71 100644
--- a/arch/mips/include/asm/sn/intr.h
+++ b/arch/mips/include/asm/sn/intr.h
@@ -126,4 +126,11 @@ do {								\
 #define NI_ERROR_INTR		62
 #define MSC_PANIC_INTR		63
 
+struct irq_source_ops {
+	void (*start_irq_source)(cpuid_t cpu, int bit, void *d);
+	void (*stop_irq_source)(cpuid_t cpu, int bit, void *d);
+};
+
+extern int request_chipset_irq(struct irq_source_ops *o, void *d, nasid_t n);
+
 #endif /* __ASM_SN_INTR_H */
diff --git a/arch/mips/sgi-ip27/ip27-irq.c b/arch/mips/sgi-ip27/ip27-irq.c
index a9db2f28b609..cac5f6956048 100644
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
@@ -23,11 +23,11 @@
 #include <asm/sn/intr.h>
 
 struct hub_irq_data {
-	struct bridge_controller *bc;
+	struct irq_source_ops *isrc_ops;
+	void    *isrc_data;
 	u64	irq_mask_addr[2];
 	cpuid_t	cpu;
 	int	bit;
-	int	pin;
 };
 
 static DECLARE_BITMAP(hub_irq_map, IP27_HUB_IRQ_COUNT);
@@ -67,65 +67,32 @@ static void disable_hub_irq(struct irq_data *d)
 	HUB_S(hd->irq_mask_addr[1], si->irq_enable_mask[1]);
 }
 
-static unsigned int startup_bridge_irq(struct irq_data *d)
+static unsigned int startup_hub_irq(struct irq_data *d)
 {
 	struct hub_irq_data *hd = irq_data_get_irq_chip_data(d);
-	struct bridge_controller *bc;
-	nasid_t nasid;
-	u32 device;
-	int pin;
 
 	if (!hd)
 		return -EINVAL;
 
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
+	if (hd->isrc_ops && hd->isrc_ops->start_irq_source)
+		hd->isrc_ops->start_irq_source(hd->cpu, hd->bit, hd->isrc_data);
 
 	enable_hub_irq(d);
 
 	return 0;	/* Never anything pending.  */
 }
 
-static void shutdown_bridge_irq(struct irq_data *d)
+static void shutdown_hub_irq(struct irq_data *d)
 {
 	struct hub_irq_data *hd = irq_data_get_irq_chip_data(d);
-	struct bridge_controller *bc;
-	int pin = hd->pin;
 
 	if (!hd)
 		return;
 
 	disable_hub_irq(d);
 
-	bc = hd->bc;
-	bridge_clr(bc, b_int_enable, (1 << pin));
-	bridge_read(bc, b_wid_tflush);
+	if (hd->isrc_ops && hd->isrc_ops->stop_irq_source)
+		hd->isrc_ops->stop_irq_source(hd->cpu, hd->bit, hd->isrc_data);
 }
 
 static void setup_hub_mask(struct hub_irq_data *hd, const struct cpumask *mask)
@@ -162,7 +129,7 @@ static int set_affinity_hub_irq(struct irq_data *d, const struct cpumask *mask,
 	setup_hub_mask(hd, mask);
 
 	if (irqd_is_started(d))
-		startup_bridge_irq(d);
+		startup_hub_irq(d);
 
 	irq_data_update_effective_affinity(d, cpumask_of(hd->cpu));
 
@@ -171,14 +138,14 @@ static int set_affinity_hub_irq(struct irq_data *d, const struct cpumask *mask,
 
 static struct irq_chip hub_irq_type = {
 	.name		  = "HUB",
-	.irq_startup	  = startup_bridge_irq,
-	.irq_shutdown	  = shutdown_bridge_irq,
+	.irq_startup	  = startup_hub_irq,
+	.irq_shutdown	  = shutdown_hub_irq,
 	.irq_mask	  = disable_hub_irq,
 	.irq_unmask	  = enable_hub_irq,
 	.irq_set_affinity = set_affinity_hub_irq,
 };
 
-int request_bridge_irq(struct bridge_controller *bc, int pin)
+int request_chipset_irq(struct irq_source_ops *ops, void *d, nasid_t nasid)
 {
 	struct hub_irq_data *hd;
 	struct hub_data *hub;
@@ -197,17 +164,17 @@ int request_bridge_irq(struct bridge_controller *bc, int pin)
 	}
 	irq = swlevel + IP27_HUB_IRQ_BASE;
 
-	hd->bc = bc;
+	hd->isrc_ops = ops;
+	hd->isrc_data = d;
 	hd->bit = swlevel;
-	hd->pin = pin;
 	irq_set_chip_data(irq, hd);
 
 	/* use CPU connected to nearest hub */
-	hub = hub_data(NASID_TO_COMPACT_NODEID(bc->nasid));
+	hub = hub_data(NASID_TO_COMPACT_NODEID(nasid));
 	setup_hub_mask(hd, &hub->h_cpus);
 
 	desc = irq_to_desc(irq);
-	desc->irq_common_data.node = bc->nasid;
+	desc->irq_common_data.node = nasid;
 	cpumask_copy(desc->irq_common_data.affinity, &hub->h_cpus);
 
 	return irq;
diff --git a/drivers/pci/controller/pci-xtalk-bridge.c b/drivers/pci/controller/pci-xtalk-bridge.c
index b90fbec8f891..1dfa78b4f514 100644
--- a/drivers/pci/controller/pci-xtalk-bridge.c
+++ b/drivers/pci/controller/pci-xtalk-bridge.c
@@ -325,6 +325,60 @@ int pcibus_to_node(struct pci_bus *bus)
 EXPORT_SYMBOL(pcibus_to_node);
 #endif /* CONFIG_NUMA */
 
+struct bridge_irq_src_data {
+	struct bridge_controller *bc;
+	int pin;
+};
+
+static void bridge_start_irq_source(cpuid_t cpu, int bit, void *d)
+{
+	struct bridge_irq_src_data *data = d;
+	struct bridge_controller *bc = data->bc;
+	nasid_t nasid;
+	u32 device;
+	int pin = data->pin;
+
+	nasid = COMPACT_TO_NASID_NODEID(cpu_to_node(cpu));
+	bridge_write(bc, b_int_addr[pin].addr,
+		     (0x20000 | bit | (nasid << 8)));
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
+}
+
+static void bridge_stop_irq_source(cpuid_t cpi, int bit, void *d)
+{
+	struct bridge_irq_src_data *data = d;
+
+	bridge_clr(data->bc, b_int_enable, (1 << data->pin));
+	bridge_read(data->bc, b_wid_tflush);
+}
+
+static struct irq_source_ops bridge_irq_src_ops = {
+	.start_irq_source = bridge_start_irq_source,
+	.stop_irq_source  = bridge_stop_irq_source
+};
+
+
 /*
  * All observed requests have pin == 1. We could have a global here, that
  * gets incremented and returned every time - unfortunately, pci_map_irq
@@ -337,11 +391,19 @@ EXPORT_SYMBOL(pcibus_to_node);
 static int bridge_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	struct bridge_controller *bc = BRIDGE_CONTROLLER(dev->bus);
+	struct bridge_irq_src_data *data;
 	int irq;
 
 	irq = bc->pci_int[slot];
 	if (irq == -1) {
-		irq = request_bridge_irq(bc, slot);
+		data = kmalloc(sizeof(*data), GFP_KERNEL);
+		if (!data)
+			return -ENOMEM;
+
+		data->bc = bc;
+		data->pin = slot;
+
+		irq = request_chipset_irq(&bridge_irq_src_ops, data, bc->nasid);
 		if (irq < 0)
 			return irq;
 
-- 
2.13.7

