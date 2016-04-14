Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: iommu@lists.linux-foundation.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Jon Masters <jcm@redhat.com>,
	Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 11/11] drivers: irqchip: make struct irq_fwspec generic
Date: Thu, 14 Apr 2016 18:25:43 +0100
Message-Id: <1460654743-7896-12-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1460654743-7896-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1460654743-7896-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The struct irq_fwspec is used in IRQ domain core code to carry out
IRQ translations (on both DT and ACPI systems) but it has nothing
IRQ specific in it, hence it can be reused by other kernel subsystems
(ie IOMMU) to carry out translation mappings as they deem fit.

This patch mechanically converts the struct irq_fwspec to a generic
struct fwspec available to all kernel subsystems that envisage a use
for it, and generalizes the IRQ domain helper (that is not IRQ domain
specific) to translate struct of_phandle_args to a struct fwspec.

Since the struct fwspec is subsystem agnostic, the struct iommu_fwspec
can be converted to it too in all kernel components currently making
use of it.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/IRQ-domain.txt         |  2 +-
 arch/arm/mach-exynos/suspend.c       |  6 +++---
 arch/arm/mach-imx/gpc.c              |  6 +++---
 arch/arm/mach-omap2/omap-wakeupgen.c |  6 +++---
 drivers/acpi/gsi.c                   |  2 +-
 drivers/acpi/iort.c                  |  2 +-
 drivers/gpio/gpio-xgene-sb.c         |  8 ++++----
 drivers/iommu/arm-smmu.c             |  2 +-
 drivers/iommu/exynos-iommu.c         |  2 +-
 drivers/iommu/mtk_iommu.c            |  2 +-
 drivers/iommu/of_iommu.c             | 14 +-------------
 drivers/irqchip/irq-alpine-msi.c     |  2 +-
 drivers/irqchip/irq-crossbar.c       |  6 +++---
 drivers/irqchip/irq-gic-v2m.c        |  2 +-
 drivers/irqchip/irq-gic-v3-its.c     |  2 +-
 drivers/irqchip/irq-gic-v3.c         |  4 ++--
 drivers/irqchip/irq-gic.c            |  4 ++--
 drivers/irqchip/irq-imx-gpcv2.c      |  6 +++---
 drivers/irqchip/irq-mbigen.c         |  4 ++--
 drivers/irqchip/irq-mips-gic.c       |  2 +-
 drivers/irqchip/irq-mtk-sysirq.c     |  6 +++---
 drivers/irqchip/irq-mvebu-odmi.c     |  2 +-
 drivers/irqchip/irq-nvic.c           |  4 ++--
 drivers/irqchip/irq-tegra.c          |  6 +++---
 drivers/irqchip/irq-vf610-mscm-ir.c  |  6 +++---
 drivers/of/base.c                    | 24 ++++++++++++++++++++++++
 include/linux/fwnode.h               | 20 ++++++++++++++++++++
 include/linux/iommu.h                | 20 +-------------------
 include/linux/irqdomain.h            | 22 ++--------------------
 include/linux/of.h                   |  7 +++++++
 kernel/irq/irqdomain.c               | 17 +++--------------
 31 files changed, 105 insertions(+), 113 deletions(-)

diff --git a/Documentation/IRQ-domain.txt b/Documentation/IRQ-domain.txt
index 8d990bd..c9085e5 100644
--- a/Documentation/IRQ-domain.txt
+++ b/Documentation/IRQ-domain.txt
@@ -32,7 +32,7 @@ top of the irq_alloc_desc*() API.  An irq_domain to manage mapping is
 preferred over interrupt controller drivers open coding their own
 reverse mapping scheme.
 
-irq_domain also implements translation from an abstract irq_fwspec
+irq_domain also implements translation from an abstract fwspec
 structure to hwirq numbers (Device Tree and ACPI GSI so far), and can
 be easily extended to support other IRQ topology data sources.
 
diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index fee2b00..40a48c0 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -179,7 +179,7 @@ static struct irq_chip exynos_pmu_chip = {
 };
 
 static int exynos_pmu_domain_translate(struct irq_domain *d,
-				       struct irq_fwspec *fwspec,
+				       struct fwspec *fwspec,
 				       unsigned long *hwirq,
 				       unsigned int *type)
 {
@@ -203,8 +203,8 @@ static int exynos_pmu_domain_alloc(struct irq_domain *domain,
 				   unsigned int virq,
 				   unsigned int nr_irqs, void *data)
 {
-	struct irq_fwspec *fwspec = data;
-	struct irq_fwspec parent_fwspec;
+	struct fwspec *fwspec = data;
+	struct fwspec parent_fwspec;
 	irq_hw_number_t hwirq;
 	int i;
 
diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index fd87205..5e4aac6 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -184,7 +184,7 @@ static struct irq_chip imx_gpc_chip = {
 };
 
 static int imx_gpc_domain_translate(struct irq_domain *d,
-				    struct irq_fwspec *fwspec,
+				    struct fwspec *fwspec,
 				    unsigned long *hwirq,
 				    unsigned int *type)
 {
@@ -208,8 +208,8 @@ static int imx_gpc_domain_alloc(struct irq_domain *domain,
 				  unsigned int irq,
 				  unsigned int nr_irqs, void *data)
 {
-	struct irq_fwspec *fwspec = data;
-	struct irq_fwspec parent_fwspec;
+	struct fwspec *fwspec = data;
+	struct fwspec parent_fwspec;
 	irq_hw_number_t hwirq;
 	int i;
 
diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index f397bd6..b74ede2 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -401,7 +401,7 @@ static struct irq_chip wakeupgen_chip = {
 };
 
 static int wakeupgen_domain_translate(struct irq_domain *d,
-				      struct irq_fwspec *fwspec,
+				      struct fwspec *fwspec,
 				      unsigned long *hwirq,
 				      unsigned int *type)
 {
@@ -425,8 +425,8 @@ static int wakeupgen_domain_alloc(struct irq_domain *domain,
 				  unsigned int virq,
 				  unsigned int nr_irqs, void *data)
 {
-	struct irq_fwspec *fwspec = data;
-	struct irq_fwspec parent_fwspec;
+	struct fwspec *fwspec = data;
+	struct fwspec parent_fwspec;
 	irq_hw_number_t hwirq;
 	int i;
 
diff --git a/drivers/acpi/gsi.c b/drivers/acpi/gsi.c
index ee9e0f2..05e8b32 100644
--- a/drivers/acpi/gsi.c
+++ b/drivers/acpi/gsi.c
@@ -54,7 +54,7 @@ EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
 int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
 		      int polarity)
 {
-	struct irq_fwspec fwspec;
+	struct fwspec fwspec;
 
 	if (WARN_ON(!acpi_gsi_domain_id)) {
 		pr_warn("GSI: No registered irqchip, giving up\n");
diff --git a/drivers/acpi/iort.c b/drivers/acpi/iort.c
index b1bb8fb..5151d68 100644
--- a/drivers/acpi/iort.c
+++ b/drivers/acpi/iort.c
@@ -450,7 +450,7 @@ struct iommu_ops *iort_iommu_configure(struct device *dev)
 {
 	struct acpi_iort_node *node, *parent;
 	struct iommu_ops *ops = NULL;
-	struct iommu_fwspec fwspec;
+	struct fwspec fwspec;
 	struct iort_iommu_node *iommu_node;
 	u32 rid = 0, devid = 0;
 
diff --git a/drivers/gpio/gpio-xgene-sb.c b/drivers/gpio/gpio-xgene-sb.c
index 31cbcb8..0c5a2cb 100644
--- a/drivers/gpio/gpio-xgene-sb.c
+++ b/drivers/gpio/gpio-xgene-sb.c
@@ -124,7 +124,7 @@ static struct irq_chip xgene_gpio_sb_irq_chip = {
 static int xgene_gpio_sb_to_irq(struct gpio_chip *gc, u32 gpio)
 {
 	struct xgene_gpio_sb *priv = gpiochip_get_data(gc);
-	struct irq_fwspec fwspec;
+	struct fwspec fwspec;
 
 	if ((gpio < priv->irq_start) ||
 			(gpio > HWIRQ_TO_GPIO(priv, priv->nirq)))
@@ -169,7 +169,7 @@ static void xgene_gpio_sb_domain_deactivate(struct irq_domain *d,
 }
 
 static int xgene_gpio_sb_domain_translate(struct irq_domain *d,
-		struct irq_fwspec *fwspec,
+		struct fwspec *fwspec,
 		unsigned long *hwirq,
 		unsigned int *type)
 {
@@ -187,8 +187,8 @@ static int xgene_gpio_sb_domain_alloc(struct irq_domain *domain,
 					unsigned int virq,
 					unsigned int nr_irqs, void *data)
 {
-	struct irq_fwspec *fwspec = data;
-	struct irq_fwspec parent_fwspec;
+	struct fwspec *fwspec = data;
+	struct fwspec parent_fwspec;
 	struct xgene_gpio_sb *priv = domain->host_data;
 	irq_hw_number_t hwirq;
 	unsigned int i;
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 85ab4b7..643a8e3 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1456,7 +1456,7 @@ static struct platform_device *arm_smmu_get_dev(struct fwnode_handle *fwnode)
 	return dev ? to_platform_device(dev) : NULL;
 }
 
-static int arm_smmu_fw_xlate(struct device *dev, struct iommu_fwspec *args)
+static int arm_smmu_fw_xlate(struct device *dev, struct fwspec *args)
 {
 	struct arm_smmu_device *smmu;
 	struct platform_device *smmu_pdev = NULL;
diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 84ff5bb..b445378 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1251,7 +1251,7 @@ static void exynos_iommu_remove_device(struct device *dev)
 }
 
 static int exynos_iommu_fw_xlate(struct device *dev,
-				 struct iommu_fwspec *args)
+				 struct fwspec *args)
 {
 	struct exynos_iommu_owner *owner = dev->archdata.iommu;
 	struct platform_device *sysmmu = NULL;
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index e08dc0a..459c293 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -436,7 +436,7 @@ static struct iommu_group *mtk_iommu_device_group(struct device *dev)
 	return data->m4u_group;
 }
 
-static int mtk_iommu_fw_xlate(struct device *dev, struct iommu_fwspec *args)
+static int mtk_iommu_fw_xlate(struct device *dev, struct fwspec *args)
 {
 	struct mtk_iommu_client_priv *head, *priv, *next;
 	struct platform_device *m4updev;
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 331dd78..bf9757a 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -135,18 +135,6 @@ struct iommu_ops *of_iommu_get_ops(struct device_node *np)
 	return ops;
 }
 
-static void of_phandle_args_to_fwspec(struct of_phandle_args *iommu_data,
-				      struct iommu_fwspec *fwspec)
-{
-	int i;
-
-	fwspec->fwnode = iommu_data->np ? &iommu_data->np->fwnode : NULL;
-	fwspec->param_count = iommu_data->args_count;
-
-	for (i = 0; i < iommu_data->args_count; i++)
-		fwspec->param[i] = iommu_data->args[i];
-}
-
 static int __get_pci_rid(struct pci_dev *pdev, u16 alias, void *data)
 {
 	struct of_phandle_args *iommu_spec = data;
@@ -160,7 +148,7 @@ struct iommu_ops *of_iommu_configure(struct device *dev,
 				     struct device_node *master_np)
 {
 	struct of_phandle_args iommu_spec;
-	struct iommu_fwspec fwspec;
+	struct fwspec fwspec;
 	struct device_node *np = NULL;
 	struct iommu_ops *ops = NULL;
 	int idx = 0;
diff --git a/drivers/irqchip/irq-alpine-msi.c b/drivers/irqchip/irq-alpine-msi.c
index 2538425..1514155 100644
--- a/drivers/irqchip/irq-alpine-msi.c
+++ b/drivers/irqchip/irq-alpine-msi.c
@@ -119,7 +119,7 @@ static struct irq_chip middle_irq_chip = {
 static int alpine_msix_gic_domain_alloc(struct irq_domain *domain,
 					unsigned int virq, int sgi)
 {
-	struct irq_fwspec fwspec;
+	struct fwspec fwspec;
 	struct irq_data *d;
 	int ret;
 
diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
index 75573fa..377ad04 100644
--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -78,7 +78,7 @@ static struct irq_chip crossbar_chip = {
 static int allocate_gic_irq(struct irq_domain *domain, unsigned virq,
 			    irq_hw_number_t hwirq)
 {
-	struct irq_fwspec fwspec;
+	struct fwspec fwspec;
 	int i;
 	int err;
 
@@ -115,7 +115,7 @@ static int allocate_gic_irq(struct irq_domain *domain, unsigned virq,
 static int crossbar_domain_alloc(struct irq_domain *d, unsigned int virq,
 				 unsigned int nr_irqs, void *data)
 {
-	struct irq_fwspec *fwspec = data;
+	struct fwspec *fwspec = data;
 	irq_hw_number_t hwirq;
 	int i;
 
@@ -170,7 +170,7 @@ static void crossbar_domain_free(struct irq_domain *domain, unsigned int virq,
 }
 
 static int crossbar_domain_translate(struct irq_domain *d,
-				     struct irq_fwspec *fwspec,
+				     struct fwspec *fwspec,
 				     unsigned long *hwirq,
 				     unsigned int *type)
 {
diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 28f047c..bd202f7 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -118,7 +118,7 @@ static int gicv2m_irq_gic_domain_alloc(struct irq_domain *domain,
 				       unsigned int virq,
 				       irq_hw_number_t hwirq)
 {
-	struct irq_fwspec fwspec;
+	struct fwspec fwspec;
 	struct irq_data *d;
 	int err;
 
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index a277c9b..320cd4b 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1272,7 +1272,7 @@ static int its_irq_gic_domain_alloc(struct irq_domain *domain,
 				    unsigned int virq,
 				    irq_hw_number_t hwirq)
 {
-	struct irq_fwspec fwspec;
+	struct fwspec fwspec;
 
 	if (irq_domain_get_of_node(domain->parent)) {
 		fwspec.fwnode = domain->parent->fwnode;
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 7708941..1ed02d8 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -744,7 +744,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 }
 
 static int gic_irq_domain_translate(struct irq_domain *d,
-				    struct irq_fwspec *fwspec,
+				    struct fwspec *fwspec,
 				    unsigned long *hwirq,
 				    unsigned int *type)
 {
@@ -788,7 +788,7 @@ static int gic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	int i, ret;
 	irq_hw_number_t hwirq;
 	unsigned int type = IRQ_TYPE_NONE;
-	struct irq_fwspec *fwspec = arg;
+	struct fwspec *fwspec = arg;
 
 	ret = gic_irq_domain_translate(domain, fwspec, &hwirq, &type);
 	if (ret)
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 282344b..e59862f 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -929,7 +929,7 @@ static void gic_irq_domain_unmap(struct irq_domain *d, unsigned int irq)
 }
 
 static int gic_irq_domain_translate(struct irq_domain *d,
-				    struct irq_fwspec *fwspec,
+				    struct fwspec *fwspec,
 				    unsigned long *hwirq,
 				    unsigned int *type)
 {
@@ -988,7 +988,7 @@ static int gic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	int i, ret;
 	irq_hw_number_t hwirq;
 	unsigned int type = IRQ_TYPE_NONE;
-	struct irq_fwspec *fwspec = arg;
+	struct fwspec *fwspec = arg;
 
 	ret = gic_irq_domain_translate(domain, fwspec, &hwirq, &type);
 	if (ret)
diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index 15af9a9..cf080c2 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -151,7 +151,7 @@ static struct irq_chip gpcv2_irqchip_data_chip = {
 };
 
 static int imx_gpcv2_domain_translate(struct irq_domain *d,
-				      struct irq_fwspec *fwspec,
+				      struct fwspec *fwspec,
 				      unsigned long *hwirq,
 				      unsigned int *type)
 {
@@ -175,8 +175,8 @@ static int imx_gpcv2_domain_alloc(struct irq_domain *domain,
 				  unsigned int irq, unsigned int nr_irqs,
 				  void *data)
 {
-	struct irq_fwspec *fwspec = data;
-	struct irq_fwspec parent_fwspec;
+	struct fwspec *fwspec = data;
+	struct fwspec parent_fwspec;
 	irq_hw_number_t hwirq;
 	unsigned int type;
 	int err;
diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index d67baa2..4f7010d 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -176,7 +176,7 @@ static void mbigen_write_msg(struct msi_desc *desc, struct msi_msg *msg)
 }
 
 static int mbigen_domain_translate(struct irq_domain *d,
-				    struct irq_fwspec *fwspec,
+				    struct fwspec *fwspec,
 				    unsigned long *hwirq,
 				    unsigned int *type)
 {
@@ -207,7 +207,7 @@ static int mbigen_irq_domain_alloc(struct irq_domain *domain,
 					unsigned int nr_irqs,
 					void *args)
 {
-	struct irq_fwspec *fwspec = args;
+	struct fwspec *fwspec = args;
 	irq_hw_number_t hwirq;
 	unsigned int type;
 	struct mbigen_device *mgn_chip;
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 94a30da..a6990be 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -828,7 +828,7 @@ static int gic_dev_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
 static int gic_dev_domain_alloc(struct irq_domain *d, unsigned int virq,
 				unsigned int nr_irqs, void *arg)
 {
-	struct irq_fwspec *fwspec = arg;
+	struct fwspec *fwspec = arg;
 	struct gic_irq_spec spec = {
 		.type = GIC_DEVICE,
 		.hwirq = fwspec->param[1],
diff --git a/drivers/irqchip/irq-mtk-sysirq.c b/drivers/irqchip/irq-mtk-sysirq.c
index 63ac73b..affc5f6 100644
--- a/drivers/irqchip/irq-mtk-sysirq.c
+++ b/drivers/irqchip/irq-mtk-sysirq.c
@@ -68,7 +68,7 @@ static struct irq_chip mtk_sysirq_chip = {
 };
 
 static int mtk_sysirq_domain_translate(struct irq_domain *d,
-				       struct irq_fwspec *fwspec,
+				       struct fwspec *fwspec,
 				       unsigned long *hwirq,
 				       unsigned int *type)
 {
@@ -93,8 +93,8 @@ static int mtk_sysirq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 {
 	int i;
 	irq_hw_number_t hwirq;
-	struct irq_fwspec *fwspec = arg;
-	struct irq_fwspec gic_fwspec = *fwspec;
+	struct fwspec *fwspec = arg;
+	struct fwspec gic_fwspec = *fwspec;
 
 	if (fwspec->param_count != 3)
 		return -EINVAL;
diff --git a/drivers/irqchip/irq-mvebu-odmi.c b/drivers/irqchip/irq-mvebu-odmi.c
index b4d3678..e8ad004 100644
--- a/drivers/irqchip/irq-mvebu-odmi.c
+++ b/drivers/irqchip/irq-mvebu-odmi.c
@@ -79,7 +79,7 @@ static int odmi_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				 unsigned int nr_irqs, void *args)
 {
 	struct odmi_data *odmi = NULL;
-	struct irq_fwspec fwspec;
+	struct fwspec fwspec;
 	struct irq_data *d;
 	unsigned int hwirq, odmin;
 	int ret;
diff --git a/drivers/irqchip/irq-nvic.c b/drivers/irqchip/irq-nvic.c
index b177710..174b1ed 100644
--- a/drivers/irqchip/irq-nvic.c
+++ b/drivers/irqchip/irq-nvic.c
@@ -49,7 +49,7 @@ nvic_handle_irq(irq_hw_number_t hwirq, struct pt_regs *regs)
 }
 
 static int nvic_irq_domain_translate(struct irq_domain *d,
-				     struct irq_fwspec *fwspec,
+				     struct fwspec *fwspec,
 				     unsigned long *hwirq, unsigned int *type)
 {
 	if (WARN_ON(fwspec->param_count < 1))
@@ -65,7 +65,7 @@ static int nvic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	int i, ret;
 	irq_hw_number_t hwirq;
 	unsigned int type = IRQ_TYPE_NONE;
-	struct irq_fwspec *fwspec = arg;
+	struct fwspec *fwspec = arg;
 
 	ret = nvic_irq_domain_translate(domain, fwspec, &hwirq, &type);
 	if (ret)
diff --git a/drivers/irqchip/irq-tegra.c b/drivers/irqchip/irq-tegra.c
index 50be963..c231ca2 100644
--- a/drivers/irqchip/irq-tegra.c
+++ b/drivers/irqchip/irq-tegra.c
@@ -222,7 +222,7 @@ static struct irq_chip tegra_ictlr_chip = {
 };
 
 static int tegra_ictlr_domain_translate(struct irq_domain *d,
-					struct irq_fwspec *fwspec,
+					struct fwspec *fwspec,
 					unsigned long *hwirq,
 					unsigned int *type)
 {
@@ -246,8 +246,8 @@ static int tegra_ictlr_domain_alloc(struct irq_domain *domain,
 				    unsigned int virq,
 				    unsigned int nr_irqs, void *data)
 {
-	struct irq_fwspec *fwspec = data;
-	struct irq_fwspec parent_fwspec;
+	struct fwspec *fwspec = data;
+	struct fwspec parent_fwspec;
 	struct tegra_ictlr_info *info = domain->host_data;
 	irq_hw_number_t hwirq;
 	unsigned int i;
diff --git a/drivers/irqchip/irq-vf610-mscm-ir.c b/drivers/irqchip/irq-vf610-mscm-ir.c
index 56b5e3c..abdd406 100644
--- a/drivers/irqchip/irq-vf610-mscm-ir.c
+++ b/drivers/irqchip/irq-vf610-mscm-ir.c
@@ -130,8 +130,8 @@ static int vf610_mscm_ir_domain_alloc(struct irq_domain *domain, unsigned int vi
 {
 	int i;
 	irq_hw_number_t hwirq;
-	struct irq_fwspec *fwspec = arg;
-	struct irq_fwspec parent_fwspec;
+	struct fwspec *fwspec = arg;
+	struct fwspec parent_fwspec;
 
 	if (!irq_domain_get_of_node(domain->parent))
 		return -EINVAL;
@@ -162,7 +162,7 @@ static int vf610_mscm_ir_domain_alloc(struct irq_domain *domain, unsigned int vi
 }
 
 static int vf610_mscm_ir_domain_translate(struct irq_domain *d,
-					  struct irq_fwspec *fwspec,
+					  struct fwspec *fwspec,
 					  unsigned long *hwirq,
 					  unsigned int *type)
 {
diff --git a/drivers/of/base.c b/drivers/of/base.c
index b299de2..943dd6e 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1690,6 +1690,30 @@ int of_count_phandle_with_args(const struct device_node *np, const char *list_na
 EXPORT_SYMBOL(of_count_phandle_with_args);
 
 /**
+ * of_phandle_args_to_fwspec - Convert a struct of_phandle_args to struct
+ *			       fwspec
+ * @args: of_phandle_args source structure
+ * @fwspec: fwspec specifier destination structure
+ */
+void of_phandle_args_to_fwspec(struct of_phandle_args *args,
+			       struct fwspec *fwspec)
+{
+	int i;
+
+	if (args->args_count >= FWSPEC_PARAMS) {
+		pr_warn("phandle arguments count exceeding fwspec params\n");
+		return;
+	}
+
+	fwspec->fwnode = args->np ? &args->np->fwnode : NULL;
+	fwspec->param_count = args->args_count;
+
+	for (i = 0; i < args->args_count; i++)
+		fwspec->param[i] = args->args[i];
+}
+EXPORT_SYMBOL(of_phandle_args_to_fwspec);
+
+/**
  * __of_add_property - Add a property to a node without lock operations
  */
 int __of_add_property(struct device_node *np, struct property *prop)
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 6e10050..64621bd 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -12,6 +12,8 @@
 #ifndef _LINUX_FWNODE_H_
 #define _LINUX_FWNODE_H_
 
+#include <linux/types.h>
+
 enum fwnode_type {
 	FWNODE_INVALID = 0,
 	FWNODE_OF,
@@ -27,4 +29,22 @@ struct fwnode_handle {
 	struct fwnode_handle *secondary;
 };
 
+#define FWSPEC_PARAMS 16
+
+/**
+ * struct fwspec - generic FW node specifier structure
+ *
+ * @fwnode:		Pointer to a firmware-specific descriptor
+ * @param_count:	Number of device-specific parameters
+ * @param:		Device-specific parameters
+ *
+ * This structure, directly modeled after of_phandle_args, is used to
+ * pass a fwnode specific description of translation parameters.
+ */
+struct fwspec {
+	struct fwnode_handle *fwnode;
+	int param_count;
+	u32 param[FWSPEC_PARAMS];
+};
+
 #endif
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5184d81..8904ef8 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -85,24 +85,6 @@ struct iommu_domain {
 	void *iova_cookie;
 };
 
-#define IOMMU_MAP_SPEC_PARAMS 16
-
-/**
- * struct iommu_fwspec - generic IOMMU specifier structure
- *
- * @fwnode:		Pointer to a firmware-specific descriptor
- * @param_count:	Number of device-specific parameters
- * @param:		Device-specific parameters
- *
- * This structure, directly modeled after of_phandle_args, is used to
- * pass a device-specific description of an IOMMU mapping.
- */
-struct iommu_fwspec {
-	struct fwnode_handle *fwnode;
-	int param_count;
-	u32 param[IOMMU_MAP_SPEC_PARAMS];
-};
-
 enum iommu_cap {
 	IOMMU_CAP_CACHE_COHERENCY,	/* IOMMU can enforce cache coherent DMA
 					   transactions */
@@ -214,7 +196,7 @@ struct iommu_ops {
 	/* Get the number of windows per domain */
 	u32 (*domain_get_windows)(struct iommu_domain *domain);
 
-	int (*fw_xlate)(struct device *dev, struct iommu_fwspec *args);
+	int (*fw_xlate)(struct device *dev, struct fwspec *args);
 
 	unsigned long pgsize_bitmap;
 	void *priv;
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 2aed043..1f240b6 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -43,24 +43,6 @@ struct irq_data;
 /* Number of irqs reserved for a legacy isa controller */
 #define NUM_ISA_INTERRUPTS	16
 
-#define IRQ_DOMAIN_IRQ_SPEC_PARAMS 16
-
-/**
- * struct irq_fwspec - generic IRQ specifier structure
- *
- * @fwnode:		Pointer to a firmware-specific descriptor
- * @param_count:	Number of device-specific parameters
- * @param:		Device-specific parameters
- *
- * This structure, directly modeled after of_phandle_args, is used to
- * pass a device-specific description of an interrupt.
- */
-struct irq_fwspec {
-	struct fwnode_handle *fwnode;
-	int param_count;
-	u32 param[IRQ_DOMAIN_IRQ_SPEC_PARAMS];
-};
-
 /*
  * Should several domains have the same device node, but serve
  * different purposes (for example one domain is for PCI/MSI, and the
@@ -110,7 +92,7 @@ struct irq_domain_ops {
 		     unsigned int nr_irqs);
 	void (*activate)(struct irq_domain *d, struct irq_data *irq_data);
 	void (*deactivate)(struct irq_domain *d, struct irq_data *irq_data);
-	int (*translate)(struct irq_domain *d, struct irq_fwspec *fwspec,
+	int (*translate)(struct irq_domain *d, struct fwspec *fwspec,
 			 unsigned long *out_hwirq, unsigned int *out_type);
 #endif
 };
@@ -301,7 +283,7 @@ extern void irq_domain_disassociate(struct irq_domain *domain,
 
 extern unsigned int irq_create_mapping(struct irq_domain *host,
 				       irq_hw_number_t hwirq);
-extern unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec);
+extern unsigned int irq_create_fwspec_mapping(struct fwspec *fwspec);
 extern void irq_dispose_mapping(unsigned int virq);
 
 /**
diff --git a/include/linux/of.h b/include/linux/of.h
index 7fcb681..451f6e2 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -333,6 +333,8 @@ extern int of_parse_phandle_with_fixed_args(const struct device_node *np,
 	struct of_phandle_args *out_args);
 extern int of_count_phandle_with_args(const struct device_node *np,
 	const char *list_name, const char *cells_name);
+extern void of_phandle_args_to_fwspec(struct of_phandle_args *irq_data,
+				      struct fwspec *fwspec);
 
 extern void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align));
 extern int of_alias_get_id(struct device_node *np, const char *stem);
@@ -608,6 +610,11 @@ static inline int of_count_phandle_with_args(struct device_node *np,
 	return -ENOSYS;
 }
 
+static inline void of_phandle_args_to_fwspec(struct of_phandle_args *irq_data,
+					     struct fwspec *fwspec)
+{
+}
+
 static inline int of_alias_get_id(struct device_node *np, const char *stem)
 {
 	return -ENOSYS;
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 3a519a0..6e59384 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -537,7 +537,7 @@ int irq_create_strict_mappings(struct irq_domain *domain, unsigned int irq_base,
 EXPORT_SYMBOL_GPL(irq_create_strict_mappings);
 
 static int irq_domain_translate(struct irq_domain *d,
-				struct irq_fwspec *fwspec,
+				struct fwspec *fwspec,
 				irq_hw_number_t *hwirq, unsigned int *type)
 {
 #ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
@@ -554,19 +554,8 @@ static int irq_domain_translate(struct irq_domain *d,
 	return 0;
 }
 
-static void of_phandle_args_to_fwspec(struct of_phandle_args *irq_data,
-				      struct irq_fwspec *fwspec)
-{
-	int i;
-
-	fwspec->fwnode = irq_data->np ? &irq_data->np->fwnode : NULL;
-	fwspec->param_count = irq_data->args_count;
-
-	for (i = 0; i < irq_data->args_count; i++)
-		fwspec->param[i] = irq_data->args[i];
-}
 
-unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
+unsigned int irq_create_fwspec_mapping(struct fwspec *fwspec)
 {
 	struct irq_domain *domain;
 	irq_hw_number_t hwirq;
@@ -621,7 +610,7 @@ EXPORT_SYMBOL_GPL(irq_create_fwspec_mapping);
 
 unsigned int irq_create_of_mapping(struct of_phandle_args *irq_data)
 {
-	struct irq_fwspec fwspec;
+	struct fwspec fwspec;
 
 	of_phandle_args_to_fwspec(irq_data, &fwspec);
 	return irq_create_fwspec_mapping(&fwspec);
-- 
2.6.4

