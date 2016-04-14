Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: iommu@lists.linux-foundation.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Jon Masters <jcm@redhat.com>,
	Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 10/11] drivers: iommu: arm-smmu: implement ACPI probing
Date: Thu, 14 Apr 2016 18:25:42 +0100
Message-Id: <1460654743-7896-11-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1460654743-7896-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1460654743-7896-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In ACPI world ARM SMMU components are described through IORT table
entries, that contain SMMU parameters and provide the kernel with
data to create the corresponding kernel abstractions and allow
SMMU probing and initialization.

Currently, the arm-smmu driver probe routines are DT based, hence,
to enable the driver to probe through ACPI they should be augmented
so that the DT and ACPI probing paths can actually share the common
code that probes and initializes the ARM SMMU allowing them to co-exist
seamlessly.

This patch refactors the ARM SMMU probing path to introduce ACPI
probing effectively enabling the ARM SMMU on ACPI based systems.

To create the required platform devices representing ARM SMMU components
and initialize them with the required data, this patch also implements
ARM SMMU ACPI probing by adding a hook into the ACPI IORT linker section,
that is executed automatically by the kernel on boot and allows
to detect and configure the ARM SMMU devices present in the system.

Based on prior work by Hanjun Guo <hanjun.guo@linaro.org>.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/iommu/arm-smmu.c | 240 +++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/iort.h     |   3 +
 2 files changed, 233 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 0f1e784..85ab4b7 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -28,6 +28,7 @@
 
 #define pr_fmt(fmt) "arm-smmu: " fmt
 
+#include <linux/acpi.h>
 #include <linux/delay.h>
 #include <linux/dma-iommu.h>
 #include <linux/dma-mapping.h>
@@ -36,6 +37,7 @@
 #include <linux/io.h>
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
+#include <linux/iort.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -1729,6 +1731,103 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
+static int __init acpi_smmu_version(u32 model, u32 *version)
+{
+	switch (model) {
+	case ACPI_IORT_SMMU_V1:
+	case ACPI_IORT_SMMU_CORELINK_MMU400:
+		*version = ARM_SMMU_V1;
+		return 0;
+	case ACPI_IORT_SMMU_V2:
+	case ACPI_IORT_SMMU_CORELINK_MMU500:
+		*version = ARM_SMMU_V2;
+		return 0;
+	default:
+		break;
+	}
+
+	return -ENODEV;
+}
+
+static int __init arm_smmu_acpi_probe(struct platform_device *pdev,
+				      struct arm_smmu_device *smmu)
+{
+	struct device *dev = smmu->dev;
+	struct acpi_iort_node *node =
+		*(struct acpi_iort_node **)dev_get_platdata(dev);
+	struct acpi_iort_smmu *iort_smmu;
+	int num_irqs, i, err, trigger, ret, irq_idx;
+	u64 *ctx_irq, *glb_irq;
+
+	/* Retrieve SMMU1/2 specific data */
+	iort_smmu = (struct acpi_iort_smmu *)node->node_data;
+
+	ret = acpi_smmu_version(iort_smmu->model, &smmu->version);
+	if (ret < 0)
+		return ret;
+
+	glb_irq = ACPI_ADD_PTR(u64, node, iort_smmu->global_interrupt_offset);
+	if (!IORT_IRQ_MASK(glb_irq[1]))	/* 0 means not implemented */
+		smmu->num_global_irqs = 1;
+	else
+		smmu->num_global_irqs = 2;
+
+	smmu->num_context_irqs = iort_smmu->context_interrupt_count;
+	num_irqs = smmu->num_context_irqs + smmu->num_global_irqs;
+
+	if (!smmu->num_context_irqs) {
+		dev_err(dev, "found %d interrupts but expected at least %d\n",
+			num_irqs, smmu->num_global_irqs + 1);
+		return -ENODEV;
+	}
+
+	smmu->irqs = devm_kzalloc(dev, sizeof(*smmu->irqs) * num_irqs,
+				  GFP_KERNEL);
+	if (!smmu->irqs) {
+		dev_err(dev, "failed to allocate %d irqs\n", num_irqs);
+		return -ENOMEM;
+	}
+
+	/* Global IRQs */
+	for (i = irq_idx = 0; i < smmu->num_global_irqs; i++, irq_idx++) {
+		int hw_irq = IORT_IRQ_MASK(glb_irq[i]);
+
+		trigger = IORT_IRQ_TRIGGER_MASK(glb_irq[i]);
+		smmu->irqs[irq_idx] = acpi_register_gsi(NULL, hw_irq, trigger,
+							ACPI_ACTIVE_HIGH);
+	}
+
+	/* Context IRQs */
+	ctx_irq = ACPI_ADD_PTR(u64, node, iort_smmu->context_interrupt_offset);
+	for (i = 0; i < smmu->num_context_irqs; i++, irq_idx++) {
+		int hw_irq = IORT_IRQ_MASK(ctx_irq[i]);
+
+		trigger = IORT_IRQ_TRIGGER_MASK(ctx_irq[i]);
+		smmu->irqs[irq_idx] = acpi_register_gsi(NULL, hw_irq, trigger,
+							ACPI_ACTIVE_HIGH);
+	}
+
+	if (iort_smmu->flags & ACPI_IORT_SMMU_COHERENT_WALK)
+		smmu->features |= ARM_SMMU_FEAT_COHERENT_WALK;
+
+	err = arm_smmu_device_cfg_probe(smmu);
+	if (err)
+		return err;
+
+	iort_iommu_set_node(&arm_smmu_ops, node, pdev->dev.fwnode);
+
+	return 0;
+}
+
+#else
+static inline int arm_smmu_acpi_probe(struct platform_device *pdev,
+				      struct arm_smmu_device *smmu)
+{
+	return -ENODEV;
+}
+#endif
+
 static const struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,smmu-v1", .data = (void *)ARM_SMMU_V1 },
 	{ .compatible = "arm,smmu-v2", .data = (void *)ARM_SMMU_V2 },
@@ -1933,7 +2032,10 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		return PTR_ERR(smmu->base);
 	smmu->size = resource_size(res);
 
-	err = arm_smmu_dt_probe(pdev, smmu);
+	if (acpi_disabled)
+		err = arm_smmu_dt_probe(pdev, smmu);
+	else
+		err = arm_smmu_acpi_probe(pdev, smmu);
 
 	if (err)
 		return err;
@@ -2007,16 +2109,20 @@ static int __init arm_smmu_init(void)
 
 	if (done)
 		return 0;
-	/*
-	 * Play nice with systems that don't have an ARM SMMU by checking that
-	 * an ARM SMMU exists in the system before proceeding with the driver
-	 * and IOMMU bus operation registration.
-	 */
-	np = of_find_matching_node(NULL, arm_smmu_of_match);
-	if (!np)
-		return 0;
 
-	of_node_put(np);
+	if (acpi_disabled) {
+		/*
+		 * Play nice with systems that don't have an ARM SMMU by
+		 * checking that an ARM SMMU exists in the system before
+		 * proceeding with the driver and IOMMU bus operation
+		 * registration.
+		 */
+		np = of_find_matching_node(NULL, arm_smmu_of_match);
+		if (!np)
+			return 0;
+
+		of_node_put(np);
+	}
 
 	ret = platform_driver_register(&arm_smmu_driver);
 	if (ret)
@@ -2048,6 +2154,120 @@ static void __exit arm_smmu_exit(void)
 subsys_initcall(arm_smmu_init);
 module_exit(arm_smmu_exit);
 
+#ifdef CONFIG_ACPI
+static int __init add_smmu_platform_device(struct acpi_iort_node *node)
+{
+	struct acpi_iort_smmu *smmu;
+	struct platform_device *pdev = NULL;
+	struct resource resources;
+	enum dev_dma_attr attr;
+	int ret;
+
+	/* Retrieve SMMU1/2 specific data */
+	smmu = (struct acpi_iort_smmu *)node->node_data;
+
+	memset(&resources, 0, sizeof(resources));
+	resources.start = smmu->base_address;
+	resources.end = smmu->base_address + smmu->span - 1;
+	resources.flags = IORESOURCE_MEM;
+
+	pdev = platform_device_alloc("arm-smmu", PLATFORM_DEVID_AUTO);
+	if (!pdev)
+		return PTR_ERR(pdev);
+
+	pdev->dev.fwnode = iommu_alloc_fwnode();
+
+	if (!pdev->dev.fwnode) {
+		ret = -ENOMEM;
+		goto dev_put;
+	}
+
+	ret = platform_device_add_resources(pdev, &resources, 1);
+	if (ret)
+		goto free_node;
+
+	ret = platform_device_add_data(pdev, &node, sizeof(node));
+	if (ret)
+		goto free_node;
+
+	pdev->dev.dma_mask = kmalloc(sizeof(*pdev->dev.dma_mask), GFP_KERNEL);
+	if (!pdev->dev.dma_mask) {
+		ret = -ENOMEM;
+		goto free_node;
+	}
+
+	/*
+	 * Set default dma mask value for the table walker,
+	 * to be overridden on probing with correct value.
+	 */
+	*pdev->dev.dma_mask = DMA_BIT_MASK(32);
+	pdev->dev.coherent_dma_mask = *pdev->dev.dma_mask;
+
+	attr = smmu->flags & ACPI_IORT_SMMU_COHERENT_WALK ?
+			     DEV_DMA_COHERENT : DEV_DMA_NON_COHERENT;
+
+	/* Configure DMA for the page table walker */
+	acpi_dma_configure(&pdev->dev, attr);
+
+	ret = platform_device_add(pdev);
+	if (ret)
+		goto dma_deconfigure;
+
+	return 0;
+
+dma_deconfigure:
+	acpi_dma_deconfigure(&pdev->dev);
+	kfree(pdev->dev.dma_mask);
+free_node:
+	iommu_free_fwnode(pdev->dev.fwnode);
+dev_put:
+	platform_device_put(pdev);
+
+	return ret;
+}
+
+static int __init arm_smmu_acpi_init(struct acpi_table_header *table)
+{
+	struct acpi_iort_node *iort_node, *iort_end;
+	struct acpi_table_iort *iort;
+	int i, ret = arm_smmu_init();
+
+	if (ret)
+		return ret;
+	/*
+	 * iort_table and iort both point to the start of IORT table, but
+	 * have different struct types
+	 */
+	iort = (struct acpi_table_iort *)table;
+
+	/* Get the first IORT node */
+	iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort,
+				 iort->node_offset);
+	iort_end = ACPI_ADD_PTR(struct acpi_iort_node, iort,
+				table->length);
+
+	for (i = 0; i < iort->node_count; i++) {
+		if (iort_node >= iort_end) {
+			pr_err("iort node pointer overflows, bad table\n");
+			return -EINVAL;
+		}
+
+		if (iort_node->type == ACPI_IORT_NODE_SMMU) {
+			ret = add_smmu_platform_device(iort_node);
+			if (ret)
+				return ret;
+		}
+
+		iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort_node,
+					 iort_node->length);
+	}
+
+	return 0;
+}
+
+IORT_ACPI_DECLARE(arm_smmu, ACPI_SIG_IORT, arm_smmu_acpi_init);
+#endif
+
 static int __init arm_smmu_of_init(struct device_node *np)
 {
 	struct arm_smmu_device *smmu;
diff --git a/include/linux/iort.h b/include/linux/iort.h
index 7a7af40..958b236 100644
--- a/include/linux/iort.h
+++ b/include/linux/iort.h
@@ -21,6 +21,9 @@
 
 #include <linux/acpi.h>
 
+#define IORT_IRQ_MASK(irq)		(irq & 0xffffffffULL)
+#define IORT_IRQ_TRIGGER_MASK(irq)	((irq >> 32) & 0xffffffffULL)
+
 struct pci_dev;
 struct fwnode_handle;
 int iort_register_domain_token(int trans_id, struct fwnode_handle *fw_node);
-- 
2.6.4

