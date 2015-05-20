Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [RFC v1 07/25] irqchip: Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc
Date: Wed, 20 May 2015 17:59:55 +0800
Message-Id: <1432116013-25902-8-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc while we
already have a pointer to corresponding irq_desc.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/irqchip/exynos-combiner.c   |    4 ++--
 drivers/irqchip/irq-armada-370-xp.c |    2 +-
 drivers/irqchip/irq-dw-apb-ictl.c   |    4 ++--
 drivers/irqchip/irq-gic.c           |    4 ++--
 drivers/irqchip/irq-orion.c         |    2 +-
 drivers/irqchip/irq-sunxi-nmi.c     |    2 +-
 drivers/irqchip/spear-shirq.c       |    2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/exynos-combiner.c b/drivers/irqchip/exynos-combiner.c
index 5945223b73fa..039ceb46fcc0 100644
--- a/drivers/irqchip/exynos-combiner.c
+++ b/drivers/irqchip/exynos-combiner.c
@@ -62,8 +62,8 @@ static void combiner_unmask_irq(struct irq_data *data)
 
 static void combiner_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
 {
-	struct combiner_chip_data *chip_data = irq_get_handler_data(irq);
-	struct irq_chip *chip = irq_get_chip(irq);
+	struct combiner_chip_data *chip_data = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int cascade_irq, combiner_irq;
 	unsigned long status;
 
diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index daccc8bdbb42..40b5fe99a1d5 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -451,7 +451,7 @@ static void armada_370_xp_handle_msi_irq(struct pt_regs *r, bool b) {}
 static void armada_370_xp_mpic_handle_cascade_irq(unsigned int irq,
 						  struct irq_desc *desc)
 {
-	struct irq_chip *chip = irq_get_chip(irq);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned long irqmap, irqn, irqsrc, cpuid;
 	unsigned int cascade_irq;
 
diff --git a/drivers/irqchip/irq-dw-apb-ictl.c b/drivers/irqchip/irq-dw-apb-ictl.c
index 53bb7326a60a..cddcd3b75f00 100644
--- a/drivers/irqchip/irq-dw-apb-ictl.c
+++ b/drivers/irqchip/irq-dw-apb-ictl.c
@@ -28,8 +28,8 @@
 
 static void dw_apb_ictl_handler(unsigned int irq, struct irq_desc *desc)
 {
-	struct irq_chip *chip = irq_get_chip(irq);
-	struct irq_chip_generic *gc = irq_get_handler_data(irq);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct irq_chip_generic *gc = irq_desc_get_handler_data(desc);
 	struct irq_domain *d = gc->private;
 	u32 stat;
 	int n;
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 01999d74bd3a..6c8a5a7fb4a0 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -288,8 +288,8 @@ static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 
 static void gic_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
 {
-	struct gic_chip_data *chip_data = irq_get_handler_data(irq);
-	struct irq_chip *chip = irq_get_chip(irq);
+	struct gic_chip_data *chip_data = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int cascade_irq, gic_irq;
 	unsigned long status;
 
diff --git a/drivers/irqchip/irq-orion.c b/drivers/irqchip/irq-orion.c
index ad0c0f6f1d65..58e034db0e7c 100644
--- a/drivers/irqchip/irq-orion.c
+++ b/drivers/irqchip/irq-orion.c
@@ -109,7 +109,7 @@ IRQCHIP_DECLARE(orion_intc, "marvell,orion-intc", orion_irq_init);
 
 static void orion_bridge_irq_handler(unsigned int irq, struct irq_desc *desc)
 {
-	struct irq_domain *d = irq_get_handler_data(irq);
+	struct irq_domain *d = irq_desc_get_handler_data(desc);
 
 	struct irq_chip_generic *gc = irq_get_domain_generic_chip(d, 0);
 	u32 stat = readl_relaxed(gc->reg_base + ORION_BRIDGE_IRQ_CAUSE) &
diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunxi-nmi.c
index 4a9ce5b50c5b..2eaa9d9df241 100644
--- a/drivers/irqchip/irq-sunxi-nmi.c
+++ b/drivers/irqchip/irq-sunxi-nmi.c
@@ -61,7 +61,7 @@ static inline u32 sunxi_sc_nmi_read(struct irq_chip_generic *gc, u32 off)
 static void sunxi_sc_nmi_handle_irq(unsigned int irq, struct irq_desc *desc)
 {
 	struct irq_domain *domain = irq_desc_get_handler_data(desc);
-	struct irq_chip *chip = irq_get_chip(irq);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int virq = irq_find_mapping(domain, 0);
 
 	chained_irq_enter(chip, desc);
diff --git a/drivers/irqchip/spear-shirq.c b/drivers/irqchip/spear-shirq.c
index 9c145a7cb056..fb68ee9c0424 100644
--- a/drivers/irqchip/spear-shirq.c
+++ b/drivers/irqchip/spear-shirq.c
@@ -185,7 +185,7 @@ static struct spear_shirq *spear320_shirq_blocks[] = {
 
 static void shirq_handler(unsigned irq, struct irq_desc *desc)
 {
-	struct spear_shirq *shirq = irq_get_handler_data(irq);
+	struct spear_shirq *shirq = irq_desc_get_handler_data(desc);
 	u32 pend;
 
 	pend = readl(shirq->base + shirq->status_reg) & shirq->mask;
-- 
1.7.10.4

