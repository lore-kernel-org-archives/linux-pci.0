Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: iommu@lists.linux-foundation.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Tomasz Nowicki <tn@semihalf.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Jon Masters <jcm@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Nate Watterson <nwatters@codeaurora.org>,
        Prem Mallappa <prem.mallappa@broadcom.com>,
        Dennis Chen <dennis.chen@arm.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 13/16] drivers: iommu: arm-smmu: add IORT configuration
Date: Tue, 18 Oct 2016 17:04:11 +0100
Message-Id: <20161018160414.1228-14-lorenzo.pieralisi@arm.com>
In-Reply-To: <20161018160414.1228-1-lorenzo.pieralisi@arm.com>
References: <20161018160414.1228-1-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In ACPI bases systems, in order to be able to create platform
devices and initialize them for ARM SMMU components, the IORT
kernel implementation requires a set of static functions to be
used by the IORT kernel layer to configure platform devices for
ARM SMMU components.

Add static configuration functions to the IORT kernel layer for
the ARM SMMU components, so that the ARM SMMU driver can
initialize its respective platform device by relying on the IORT
kernel infrastructure and by adding a corresponding ACPI device
early probe section entry.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
---
 drivers/acpi/arm64/iort.c | 81 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/arm-smmu.c  | 84 ++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/acpi_iort.h |  3 ++
 3 files changed, 167 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index ea90bc8..04cc5f7 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -548,6 +548,78 @@ static bool __init arm_smmu_v3_is_coherent(struct acpi_iort_node *node)
 	return smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE;
 }
 
+static int __init arm_smmu_count_resources(struct acpi_iort_node *node)
+{
+	struct acpi_iort_smmu *smmu;
+	int num_irqs;
+	u64 *glb_irq;
+
+	/* Retrieve SMMU specific data */
+	smmu = (struct acpi_iort_smmu *)node->node_data;
+
+	glb_irq = ACPI_ADD_PTR(u64, node, smmu->global_interrupt_offset);
+	if (!IORT_IRQ_MASK(glb_irq[1]))	/* 0 means not implemented */
+		num_irqs = 1;
+	else
+		num_irqs = 2;
+
+	num_irqs += smmu->context_interrupt_count;
+
+	return num_irqs + 1;
+}
+
+static void __init arm_smmu_init_resources(struct resource *res,
+					   struct acpi_iort_node *node)
+{
+	struct acpi_iort_smmu *smmu;
+	int i, hw_irq, trigger, num_res = 0;
+	u64 *ctx_irq, *glb_irq;
+
+	/* Retrieve SMMU specific data */
+	smmu = (struct acpi_iort_smmu *)node->node_data;
+
+	res[num_res].start = smmu->base_address;
+	res[num_res].end = smmu->base_address + smmu->span - 1;
+	res[num_res].flags = IORESOURCE_MEM;
+	num_res++;
+
+	glb_irq = ACPI_ADD_PTR(u64, node, smmu->global_interrupt_offset);
+	/* Global IRQs */
+	hw_irq = IORT_IRQ_MASK(glb_irq[0]);
+	trigger = IORT_IRQ_TRIGGER_MASK(glb_irq[0]);
+
+	acpi_iort_register_irq(hw_irq, "arm-smmu-global", trigger,
+				     &res[num_res++]);
+
+	/* Global IRQs */
+	hw_irq = IORT_IRQ_MASK(glb_irq[1]);
+	if (hw_irq) {
+		trigger = IORT_IRQ_TRIGGER_MASK(glb_irq[1]);
+		acpi_iort_register_irq(hw_irq, "arm-smmu-global", trigger,
+					     &res[num_res++]);
+	}
+
+	/* Context IRQs */
+	ctx_irq = ACPI_ADD_PTR(u64, node, smmu->context_interrupt_offset);
+	for (i = 0; i < smmu->context_interrupt_count; i++) {
+		hw_irq = IORT_IRQ_MASK(ctx_irq[i]);
+		trigger = IORT_IRQ_TRIGGER_MASK(ctx_irq[i]);
+
+		acpi_iort_register_irq(hw_irq, "arm-smmu-context", trigger,
+				       &res[num_res++]);
+	}
+}
+
+static bool __init arm_smmu_is_coherent(struct acpi_iort_node *node)
+{
+	struct acpi_iort_smmu *smmu;
+
+	/* Retrieve SMMU specific data */
+	smmu = (struct acpi_iort_smmu *)node->node_data;
+
+	return smmu->flags & ACPI_IORT_SMMU_COHERENT_WALK;
+}
+
 struct iort_iommu_config {
 	const char *name;
 	int (*iommu_init)(struct acpi_iort_node *node);
@@ -564,12 +636,21 @@ static const struct iort_iommu_config iort_arm_smmu_v3_cfg __initconst = {
 	.iommu_init_resources = arm_smmu_v3_init_resources
 };
 
+static const struct iort_iommu_config iort_arm_smmu_cfg __initconst = {
+	.name = "arm-smmu",
+	.iommu_is_coherent = arm_smmu_is_coherent,
+	.iommu_count_resources = arm_smmu_count_resources,
+	.iommu_init_resources = arm_smmu_init_resources
+};
+
 static __init
 const struct iort_iommu_config *iort_get_iommu_cfg(struct acpi_iort_node *node)
 {
 	switch (node->type) {
 	case ACPI_IORT_NODE_SMMU_V3:
 		return &iort_arm_smmu_v3_cfg;
+	case ACPI_IORT_NODE_SMMU:
+		return &iort_arm_smmu_cfg;
 	default:
 		return NULL;
 	}
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 813dbf2..aa2d944 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -28,6 +28,8 @@
 
 #define pr_fmt(fmt) "arm-smmu: " fmt
 
+#include <linux/acpi.h>
+#include <linux/acpi_iort.h>
 #include <linux/atomic.h>
 #include <linux/delay.h>
 #include <linux/dma-iommu.h>
@@ -1892,6 +1894,71 @@ static const struct of_device_id arm_smmu_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
 
+#ifdef CONFIG_ACPI
+static int acpi_smmu_get_data(u32 model, u32 *version, u32 *impl)
+{
+	int ret = 0;
+
+	switch (model) {
+	case ACPI_IORT_SMMU_V1:
+	case ACPI_IORT_SMMU_CORELINK_MMU400:
+		*version = ARM_SMMU_V1;
+		*impl = GENERIC_SMMU;
+		break;
+	case ACPI_IORT_SMMU_V2:
+		*version = ARM_SMMU_V2;
+		*impl = GENERIC_SMMU;
+		break;
+	case ACPI_IORT_SMMU_CORELINK_MMU500:
+		*version = ARM_SMMU_V2;
+		*impl = ARM_MMU500;
+		break;
+	default:
+		ret = -ENODEV;
+	}
+
+	return ret;
+}
+
+static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
+				      struct arm_smmu_device *smmu)
+{
+	struct device *dev = smmu->dev;
+	struct acpi_iort_node *node =
+		*(struct acpi_iort_node **)dev_get_platdata(dev);
+	struct acpi_iort_smmu *iort_smmu;
+	u64 *glb_irq;
+	int ret;
+
+	/* Retrieve SMMU1/2 specific data */
+	iort_smmu = (struct acpi_iort_smmu *)node->node_data;
+
+	ret = acpi_smmu_get_data(iort_smmu->model, &smmu->version,
+						   &smmu->model);
+	if (ret < 0)
+		return ret;
+
+	glb_irq = ACPI_ADD_PTR(u64, iort_smmu,
+			iort_smmu->global_interrupt_offset);
+
+	if (!IORT_IRQ_MASK(glb_irq[1]))	/* 0 means not implemented */
+		smmu->num_global_irqs = 1;
+	else
+		smmu->num_global_irqs = 2;
+
+	if (iort_smmu->flags & ACPI_IORT_SMMU_COHERENT_WALK)
+		smmu->features |= ARM_SMMU_FEAT_COHERENT_WALK;
+
+	return 0;
+}
+#else
+static inline int arm_smmu_device_acpi_probe(struct platform_device *pdev,
+					     struct arm_smmu_device *smmu)
+{
+	return -ENODEV;
+}
+#endif
+
 static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 				    struct arm_smmu_device *smmu)
 {
@@ -1943,7 +2010,11 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	}
 	smmu->dev = dev;
 
-	err = arm_smmu_device_dt_probe(pdev, smmu);
+	if (dev->of_node)
+		err = arm_smmu_device_dt_probe(pdev, smmu);
+	else
+		err = arm_smmu_device_acpi_probe(pdev, smmu);
+
 	if (err)
 		return err;
 
@@ -2091,6 +2162,17 @@ IOMMU_OF_DECLARE(arm_mmu401, "arm,mmu-401", arm_smmu_of_init);
 IOMMU_OF_DECLARE(arm_mmu500, "arm,mmu-500", arm_smmu_of_init);
 IOMMU_OF_DECLARE(cavium_smmuv2, "cavium,smmu-v2", arm_smmu_of_init);
 
+#ifdef CONFIG_ACPI
+static int __init arm_smmu_acpi_init(struct acpi_table_header *table)
+{
+	if (iort_node_match(ACPI_IORT_NODE_SMMU))
+		return arm_smmu_init();
+
+	return 0;
+}
+IORT_ACPI_DECLARE(arm_smmu, ACPI_SIG_IORT, arm_smmu_acpi_init);
+#endif
+
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMU implementations");
 MODULE_AUTHOR("Will Deacon <will.deacon@arm.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 17bb078..79ba1bb 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -23,6 +23,9 @@
 #include <linux/fwnode.h>
 #include <linux/irqdomain.h>
 
+#define IORT_IRQ_MASK(irq)		(irq & 0xffffffffULL)
+#define IORT_IRQ_TRIGGER_MASK(irq)	((irq >> 32) & 0xffffffffULL)
+
 int iort_register_domain_token(int trans_id, struct fwnode_handle *fw_node);
 void iort_deregister_domain_token(int trans_id);
 struct fwnode_handle *iort_find_domain_token(int trans_id);
-- 
2.10.0

