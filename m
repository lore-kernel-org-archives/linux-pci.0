Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Kevin Cernekee <cernekee@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	James Hogan <james.hogan@imgtec.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-mips@linux-mips.org,
	linux-metag@vger.kernel.org
Subject: [RFT v2 46/48] genirq, irqchip: Kill the first parameter 'irq' of irq_flow_handler_t
Date: Thu,  4 Jun 2015 12:13:56 +0800
Message-Id: <1433391238-19471-47-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now most IRQ flow handlers make no use of the first parameter 'irq'.
And for those who do make use of 'irq', we could easily get the irq
number through irq_desc->irq_data->irq. So kill the first parameter
'irq' of irq_flow_handler_t.

To ease review, I have split the changes into several parts, though
they should be merge as one to support bisecting.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
Acked-by: Ralf Baechle <ralf@linux-mips.org>
---
 drivers/irqchip/exynos-combiner.c    |    4 ++--
 drivers/irqchip/irq-armada-370-xp.c  |    3 +--
 drivers/irqchip/irq-bcm7038-l1.c     |    2 +-
 drivers/irqchip/irq-bcm7120-l2.c     |    2 +-
 drivers/irqchip/irq-brcmstb-l2.c     |    4 ++--
 drivers/irqchip/irq-dw-apb-ictl.c    |    2 +-
 drivers/irqchip/irq-gic.c            |    2 +-
 drivers/irqchip/irq-imgpdc.c         |    4 ++--
 drivers/irqchip/irq-keystone.c       |    2 +-
 drivers/irqchip/irq-metag-ext.c      |    3 +--
 drivers/irqchip/irq-metag.c          |    3 +--
 drivers/irqchip/irq-mips-gic.c       |    2 +-
 drivers/irqchip/irq-mmp.c            |    2 +-
 drivers/irqchip/irq-orion.c          |    2 +-
 drivers/irqchip/irq-s3c24xx.c        |    2 +-
 drivers/irqchip/irq-sunxi-nmi.c      |    2 +-
 drivers/irqchip/irq-tb10x.c          |    2 +-
 drivers/irqchip/irq-versatile-fpga.c |    4 ++--
 drivers/irqchip/irq-vic.c            |    2 +-
 drivers/irqchip/spear-shirq.c        |    2 +-
 20 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/drivers/irqchip/exynos-combiner.c b/drivers/irqchip/exynos-combiner.c
index 039ceb46fcc0..2bf152307bac 100644
--- a/drivers/irqchip/exynos-combiner.c
+++ b/drivers/irqchip/exynos-combiner.c
@@ -60,7 +60,7 @@ static void combiner_unmask_irq(struct irq_data *data)
 	__raw_writel(mask, combiner_base(data) + COMBINER_ENABLE_SET);
 }
 
-static void combiner_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
+static void combiner_handle_cascade_irq(struct irq_desc *desc)
 {
 	struct combiner_chip_data *chip_data = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
@@ -81,7 +81,7 @@ static void combiner_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
 	cascade_irq = irq_find_mapping(combiner_irq_domain, combiner_irq);
 
 	if (unlikely(!cascade_irq))
-		handle_bad_irq(irq, desc);
+		handle_bad_irq(desc);
 	else
 		generic_handle_irq(cascade_irq);
 
diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 40b5fe99a1d5..fa26eb1b4f17 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -448,8 +448,7 @@ static void armada_370_xp_handle_msi_irq(struct pt_regs *regs, bool is_chained)
 static void armada_370_xp_handle_msi_irq(struct pt_regs *r, bool b) {}
 #endif
 
-static void armada_370_xp_mpic_handle_cascade_irq(unsigned int irq,
-						  struct irq_desc *desc)
+static void armada_370_xp_mpic_handle_cascade_irq(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned long irqmap, irqn, irqsrc, cpuid;
diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
index d3b8c8be15f6..9ad6540bd57e 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -116,7 +116,7 @@ static inline void l1_writel(u32 val, void __iomem *reg)
 		writel(val, reg);
 }
 
-static void bcm7038_l1_irq_handle(unsigned int irq, struct irq_desc *desc)
+static void bcm7038_l1_irq_handle(struct irq_desc *desc)
 {
 	struct bcm7038_l1_chip *intc = irq_desc_get_handler_data(desc);
 	struct bcm7038_l1_cpu *cpu;
diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index 3ba5cc780fcb..4ee0d839009e 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -52,7 +52,7 @@ struct bcm7120_l2_intc_data {
 	const __be32 *map_mask_prop;
 };
 
-static void bcm7120_l2_intc_irq_handle(unsigned int irq, struct irq_desc *desc)
+static void bcm7120_l2_intc_irq_handle(struct irq_desc *desc)
 {
 	struct bcm7120_l2_intc_data *b = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index 994c01fdb4b5..ab3d0c52ea5a 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -51,7 +51,7 @@ struct brcmstb_l2_intc_data {
 	u32 saved_mask; /* for suspend/resume */
 };
 
-static void brcmstb_l2_intc_irq_handle(unsigned int __irq, struct irq_desc *desc)
+static void brcmstb_l2_intc_irq_handle(struct irq_desc *desc)
 {
 	struct brcmstb_l2_intc_data *b = irq_desc_get_handler_data(desc);
 	struct irq_chip_generic *gc = irq_get_domain_generic_chip(b->domain, 0);
@@ -65,7 +65,7 @@ static void brcmstb_l2_intc_irq_handle(unsigned int __irq, struct irq_desc *desc
 
 	if (status == 0) {
 		raw_spin_lock(&desc->lock);
-		handle_bad_irq(__irq, desc);
+		handle_bad_irq(desc);
 		raw_spin_unlock(&desc->lock);
 		goto out;
 	}
diff --git a/drivers/irqchip/irq-dw-apb-ictl.c b/drivers/irqchip/irq-dw-apb-ictl.c
index cddcd3b75f00..7a00d7822228 100644
--- a/drivers/irqchip/irq-dw-apb-ictl.c
+++ b/drivers/irqchip/irq-dw-apb-ictl.c
@@ -26,7 +26,7 @@
 #define APB_INT_FINALSTATUS_L	0x30
 #define APB_INT_FINALSTATUS_H	0x34
 
-static void dw_apb_ictl_handler(unsigned int irq, struct irq_desc *desc)
+static void dw_apb_ictl_handler(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct irq_chip_generic *gc = irq_desc_get_handler_data(desc);
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 6c8a5a7fb4a0..e24d240a8fe8 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -286,7 +286,7 @@ static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 	} while (1);
 }
 
-static void gic_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
+static void gic_handle_cascade_irq(struct irq_desc *desc)
 {
 	struct gic_chip_data *chip_data = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
diff --git a/drivers/irqchip/irq-imgpdc.c b/drivers/irqchip/irq-imgpdc.c
index d94eb43f252a..5d8a482100f7 100644
--- a/drivers/irqchip/irq-imgpdc.c
+++ b/drivers/irqchip/irq-imgpdc.c
@@ -218,7 +218,7 @@ static int pdc_irq_set_wake(struct irq_data *data, unsigned int on)
 	return 0;
 }
 
-static void pdc_intc_perip_isr(unsigned int __irq, struct irq_desc *desc)
+static void pdc_intc_perip_isr(struct irq_desc *desc)
 {
 	unsigned int irq = irq_desc_get_irq(desc);
 	struct pdc_intc_priv *priv;
@@ -240,7 +240,7 @@ found:
 	generic_handle_irq(irq_no);
 }
 
-static void pdc_intc_syswake_isr(unsigned int irq, struct irq_desc *desc)
+static void pdc_intc_syswake_isr(struct irq_desc *desc)
 {
 	struct pdc_intc_priv *priv;
 	unsigned int syswake, irq_no;
diff --git a/drivers/irqchip/irq-keystone.c b/drivers/irqchip/irq-keystone.c
index 8b05603d3be0..820e346ccae6 100644
--- a/drivers/irqchip/irq-keystone.c
+++ b/drivers/irqchip/irq-keystone.c
@@ -84,7 +84,7 @@ static void keystone_irq_ack(struct irq_data *d)
 	/* nothing to do here */
 }
 
-static void keystone_irq_handler(unsigned irq, struct irq_desc *desc)
+static void keystone_irq_handler(struct irq_desc *desc)
 {
 	struct keystone_irq_device *kirq = irq_desc_get_handler_data(desc);
 	unsigned long pending;
diff --git a/drivers/irqchip/irq-metag-ext.c b/drivers/irqchip/irq-metag-ext.c
index 52e501d8c8f0..f4b46643f2d2 100644
--- a/drivers/irqchip/irq-metag-ext.c
+++ b/drivers/irqchip/irq-metag-ext.c
@@ -436,7 +436,6 @@ static int meta_intc_irq_set_type(struct irq_data *data, unsigned int flow_type)
 
 /**
  * meta_intc_irq_demux() - external irq de-multiplexer
- * @irq:	the virtual interrupt number
  * @desc:	the interrupt description structure for this irq
  *
  * The cpu receives an interrupt on TR2 when a SoC interrupt has occurred. It is
@@ -446,7 +445,7 @@ static int meta_intc_irq_set_type(struct irq_data *data, unsigned int flow_type)
  * Whilst using TR2 to detect external interrupts is a software convention it is
  * (hopefully) unlikely to change.
  */
-static void meta_intc_irq_demux(unsigned int irq, struct irq_desc *desc)
+static void meta_intc_irq_demux(struct irq_desc *desc)
 {
 	struct meta_intc_priv *priv = &meta_intc_priv;
 	irq_hw_number_t hw;
diff --git a/drivers/irqchip/irq-metag.c b/drivers/irqchip/irq-metag.c
index c16c186d97d3..f806a61d6660 100644
--- a/drivers/irqchip/irq-metag.c
+++ b/drivers/irqchip/irq-metag.c
@@ -213,14 +213,13 @@ static int metag_internal_irq_set_affinity(struct irq_data *data,
 
 /*
  *	metag_internal_irq_demux - irq de-multiplexer
- *	@irq:	the interrupt number
  *	@desc:	the interrupt description structure for this irq
  *
  *	The cpu receives an interrupt on TR1 when an interrupt has
  *	occurred. It is this function's job to demux this irq and
  *	figure out exactly which trigger needs servicing.
  */
-static void metag_internal_irq_demux(unsigned int irq, struct irq_desc *desc)
+static void metag_internal_irq_demux(struct irq_desc *desc)
 {
 	struct metag_internal_irq_priv *priv = irq_desc_get_handler_data(desc);
 	irq_hw_number_t hw;
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index fb2e64b1f414..36d6b457e8e9 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -510,7 +510,7 @@ static void __gic_irq_dispatch(void)
 	gic_handle_shared_int();
 }
 
-static void gic_irq_dispatch(unsigned int irq, struct irq_desc *desc)
+static void gic_irq_dispatch(struct irq_desc *desc)
 {
 	__gic_irq_dispatch();
 }
diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
index 44febf10be2f..bde3bbd245a4 100644
--- a/drivers/irqchip/irq-mmp.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -130,7 +130,7 @@ struct irq_chip icu_irq_chip = {
 	.irq_unmask	= icu_unmask_irq,
 };
 
-static void icu_mux_irq_demux(unsigned int __irq, struct irq_desc *desc)
+static void icu_mux_irq_demux(struct irq_desc *desc)
 {
 	unsigned int irq = irq_desc_get_irq(desc);
 	struct irq_domain *domain;
diff --git a/drivers/irqchip/irq-orion.c b/drivers/irqchip/irq-orion.c
index 58e034db0e7c..9e5a36cd1b8f 100644
--- a/drivers/irqchip/irq-orion.c
+++ b/drivers/irqchip/irq-orion.c
@@ -107,7 +107,7 @@ IRQCHIP_DECLARE(orion_intc, "marvell,orion-intc", orion_irq_init);
 #define ORION_BRIDGE_IRQ_CAUSE	0x00
 #define ORION_BRIDGE_IRQ_MASK	0x04
 
-static void orion_bridge_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void orion_bridge_irq_handler(struct irq_desc *desc)
 {
 	struct irq_domain *d = irq_desc_get_handler_data(desc);
 
diff --git a/drivers/irqchip/irq-s3c24xx.c b/drivers/irqchip/irq-s3c24xx.c
index efca6390aa87..e8d88f6ffe73 100644
--- a/drivers/irqchip/irq-s3c24xx.c
+++ b/drivers/irqchip/irq-s3c24xx.c
@@ -299,7 +299,7 @@ static struct irq_chip s3c_irq_eint0t4 = {
 	.irq_set_type	= s3c_irqext0_type,
 };
 
-static void s3c_irq_demux(unsigned int irq, struct irq_desc *desc)
+static void s3c_irq_demux(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct s3c_irq_data *irq_data = irq_desc_get_chip_data(desc);
diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunxi-nmi.c
index 2eaa9d9df241..4e16ccd398f8 100644
--- a/drivers/irqchip/irq-sunxi-nmi.c
+++ b/drivers/irqchip/irq-sunxi-nmi.c
@@ -58,7 +58,7 @@ static inline u32 sunxi_sc_nmi_read(struct irq_chip_generic *gc, u32 off)
 	return irq_reg_readl(gc, off);
 }
 
-static void sunxi_sc_nmi_handle_irq(unsigned int irq, struct irq_desc *desc)
+static void sunxi_sc_nmi_handle_irq(struct irq_desc *desc)
 {
 	struct irq_domain *domain = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
diff --git a/drivers/irqchip/irq-tb10x.c b/drivers/irqchip/irq-tb10x.c
index 117cf25c6cfe..bdcc39218d46 100644
--- a/drivers/irqchip/irq-tb10x.c
+++ b/drivers/irqchip/irq-tb10x.c
@@ -97,7 +97,7 @@ static int tb10x_irq_set_type(struct irq_data *data, unsigned int flow_type)
 	return IRQ_SET_MASK_OK;
 }
 
-static void tb10x_irq_cascade(unsigned int irq, struct irq_desc *desc)
+static void tb10x_irq_cascade(struct irq_desc *desc)
 {
 	struct irq_domain *domain = irq_desc_get_handler_data(desc);
 
diff --git a/drivers/irqchip/irq-versatile-fpga.c b/drivers/irqchip/irq-versatile-fpga.c
index efbfd425d2e0..6ce21c1e9fff 100644
--- a/drivers/irqchip/irq-versatile-fpga.c
+++ b/drivers/irqchip/irq-versatile-fpga.c
@@ -66,13 +66,13 @@ static void fpga_irq_unmask(struct irq_data *d)
 	writel(mask, f->base + IRQ_ENABLE_SET);
 }
 
-static void fpga_irq_handle(unsigned int __irq, struct irq_desc *desc)
+static void fpga_irq_handle(struct irq_desc *desc)
 {
 	struct fpga_irq_data *f = irq_desc_get_handler_data(desc);
 	u32 status = readl(f->base + IRQ_STATUS);
 
 	if (status == 0) {
-		do_bad_IRQ(__irq, desc);
+		do_bad_IRQ(desc);
 		return;
 	}
 
diff --git a/drivers/irqchip/irq-vic.c b/drivers/irqchip/irq-vic.c
index 54089debf2dc..9f090e4284e4 100644
--- a/drivers/irqchip/irq-vic.c
+++ b/drivers/irqchip/irq-vic.c
@@ -226,7 +226,7 @@ static int handle_one_vic(struct vic_device *vic, struct pt_regs *regs)
 	return handled;
 }
 
-static void vic_handle_irq_cascaded(unsigned int irq, struct irq_desc *desc)
+static void vic_handle_irq_cascaded(struct irq_desc *desc)
 {
 	u32 stat, hwirq;
 	struct irq_chip *host_chip = irq_desc_get_chip(desc);
diff --git a/drivers/irqchip/spear-shirq.c b/drivers/irqchip/spear-shirq.c
index fb68ee9c0424..1396f0fad479 100644
--- a/drivers/irqchip/spear-shirq.c
+++ b/drivers/irqchip/spear-shirq.c
@@ -183,7 +183,7 @@ static struct spear_shirq *spear320_shirq_blocks[] = {
 	&spear320_shirq_intrcomm_ras,
 };
 
-static void shirq_handler(unsigned irq, struct irq_desc *desc)
+static void shirq_handler(struct irq_desc *desc)
 {
 	struct spear_shirq *shirq = irq_desc_get_handler_data(desc);
 	u32 pend;
-- 
1.7.10.4

