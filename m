Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44802 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752363AbcIIOX6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Sep 2016 10:23:58 -0400
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
Subject: [PATCH v5 09/14] drivers: iommu: arm-smmu-v3: add IORT configuration
Date: Fri,  9 Sep 2016 15:23:38 +0100
Message-Id: <20160909142343.13314-10-lorenzo.pieralisi@arm.com>
In-Reply-To: <20160909142343.13314-1-lorenzo.pieralisi@arm.com>
References: <20160909142343.13314-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In ACPI bases systems, in order to be able to create platform
devices and initialize them for ARM SMMU v3 components, the IORT
kernel implementation requires a set of static functions to be
used by the IORT kernel layer to configure platform devices for
ARM SMMU v3 components.

Add static configuration functions to the IORT kernel layer for
the ARM SMMU v3 components, so that the ARM SMMU v3 driver can
initialize its respective platform device by relying on the IORT
kernel infrastructure and by adding a corresponding ACPI device
early probe section entry.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
---
 drivers/acpi/arm64/iort.c   | 103 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/iommu/arm-smmu-v3.c |  95 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 195 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index e0a9b16..a2ad102 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -425,6 +425,95 @@ struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id)
 	return irq_find_matching_fwnode(handle, DOMAIN_BUS_PCI_MSI);
 }
 
+static void __init acpi_iort_register_irq(int hwirq, const char *name,
+					  int trigger,
+					  struct resource *res)
+{
+	int irq = acpi_register_gsi(NULL, hwirq, trigger,
+				    ACPI_ACTIVE_HIGH);
+
+	if (irq < 0) {
+		pr_err("could not register gsi hwirq %d name [%s]\n", hwirq,
+								      name);
+		return;
+	}
+
+	res->start = irq;
+	res->end = irq;
+	res->flags = IORESOURCE_IRQ;
+	res->name = name;
+}
+
+static int __init arm_smmu_v3_count_resources(struct acpi_iort_node *node)
+{
+	struct acpi_iort_smmu_v3 *smmu;
+	/* Always present mem resource */
+	int num_res = 1;
+
+	/* Retrieve SMMUv3 specific data */
+	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
+
+	if (smmu->event_gsiv)
+		num_res++;
+
+	if (smmu->pri_gsiv)
+		num_res++;
+
+	if (smmu->gerr_gsiv)
+		num_res++;
+
+	if (smmu->sync_gsiv)
+		num_res++;
+
+	return num_res;
+}
+
+static void __init arm_smmu_v3_init_resources(struct resource *res,
+					      struct acpi_iort_node *node)
+{
+	struct acpi_iort_smmu_v3 *smmu;
+	int num_res = 0;
+
+	/* Retrieve SMMUv3 specific data */
+	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
+
+	res[num_res].start = smmu->base_address;
+	res[num_res].end = smmu->base_address + SZ_128K - 1;
+	res[num_res].flags = IORESOURCE_MEM;
+
+	num_res++;
+
+	if (smmu->event_gsiv)
+		acpi_iort_register_irq(smmu->event_gsiv, "eventq",
+				       ACPI_EDGE_SENSITIVE,
+				       &res[num_res++]);
+
+	if (smmu->pri_gsiv)
+		acpi_iort_register_irq(smmu->pri_gsiv, "priq",
+				       ACPI_EDGE_SENSITIVE,
+				       &res[num_res++]);
+
+	if (smmu->gerr_gsiv)
+		acpi_iort_register_irq(smmu->gerr_gsiv, "gerror",
+				       ACPI_EDGE_SENSITIVE,
+				       &res[num_res++]);
+
+	if (smmu->sync_gsiv)
+		acpi_iort_register_irq(smmu->sync_gsiv, "cmdq-sync",
+				       ACPI_EDGE_SENSITIVE,
+				       &res[num_res++]);
+}
+
+static bool __init arm_smmu_v3_is_coherent(struct acpi_iort_node *node)
+{
+	struct acpi_iort_smmu_v3 *smmu;
+
+	/* Retrieve SMMUv3 specific data */
+	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
+
+	return smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE;
+}
+
 struct iort_iommu_config {
 	const char *name;
 	int (*iommu_init)(struct acpi_iort_node *node);
@@ -434,10 +523,22 @@ struct iort_iommu_config {
 				     struct acpi_iort_node *node);
 };
 
+static const struct iort_iommu_config iort_arm_smmu_v3_cfg __initconst = {
+	.name = "arm-smmu-v3",
+	.iommu_is_coherent = arm_smmu_v3_is_coherent,
+	.iommu_count_resources = arm_smmu_v3_count_resources,
+	.iommu_init_resources = arm_smmu_v3_init_resources
+};
+
 static __init
 const struct iort_iommu_config *iort_get_iommu_cfg(struct acpi_iort_node *node)
 {
-	return NULL;
+	switch (node->type) {
+	case ACPI_IORT_NODE_SMMU_V3:
+		return &iort_arm_smmu_v3_cfg;
+	default:
+		return NULL;
+	}
 }
 
 /**
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index dbc21e3..9463f3f 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -20,6 +20,8 @@
  * This driver is powered by bad coffee and bombay mix.
  */
 
+#include <linux/acpi.h>
+#include <linux/acpi_iort.h>
 #include <linux/delay.h>
 #include <linux/dma-iommu.h>
 #include <linux/err.h>
@@ -2539,6 +2541,32 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
+static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
+				      struct arm_smmu_device *smmu)
+{
+	struct acpi_iort_smmu_v3 *iort_smmu;
+	struct device *dev = smmu->dev;
+	struct acpi_iort_node *node;
+
+	node = *(struct acpi_iort_node **)dev_get_platdata(dev);
+
+	/* Retrieve SMMUv3 specific data */
+	iort_smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
+
+	if (iort_smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE)
+		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
+
+	return 0;
+}
+#else
+static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
+				      struct arm_smmu_device *smmu)
+{
+	return -ENODEV;
+}
+#endif
+
 static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 				    struct arm_smmu_device *smmu)
 {
@@ -2556,6 +2584,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct arm_smmu_device *smmu;
 	struct device *dev = &pdev->dev;
+	struct fwnode_handle *fwnode;
 
 	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
 	if (!smmu) {
@@ -2592,7 +2621,10 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	if (irq > 0)
 		smmu->gerr_irq = irq;
 
-	ret = arm_smmu_device_dt_probe(pdev, smmu);
+	if (dev->of_node)
+		ret = arm_smmu_device_dt_probe(pdev, smmu);
+	else
+		ret = arm_smmu_device_acpi_probe(pdev, smmu);
 
 	if (ret)
 		return ret;
@@ -2615,8 +2647,12 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/* FIXME: DT code path does not set up dev->fwnode pointer */
+	fwnode = dev->of_node ? &dev->of_node->fwnode : dev->fwnode;
+
 	/* And we're up. Go go go! */
-	fwspec_iommu_set_ops(&dev->of_node->fwnode, &arm_smmu_ops);
+	fwspec_iommu_set_ops(fwnode, &arm_smmu_ops);
+
 #ifdef CONFIG_PCI
 	pci_request_acs();
 	ret = bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
@@ -2688,6 +2724,61 @@ static int __init arm_smmu_of_init(struct device_node *np)
 }
 IOMMU_OF_DECLARE(arm_smmuv3, "arm,smmu-v3", arm_smmu_of_init);
 
+#ifdef CONFIG_ACPI
+static int __init acpi_smmu_v3_init(struct acpi_table_header *table)
+{
+	struct acpi_iort_node *iort_node, *iort_end;
+	struct acpi_table_iort *iort;
+	struct fwnode_handle *fwnode;
+	int i, ret;
+
+	/*
+	 * table and iort will both point to the start of IORT table, but
+	 * have different struct types
+	 */
+	iort = (struct acpi_table_iort *)table;
+
+	/* Get the first IORT node */
+	iort_node = ACPI_ADD_PTR(struct acpi_iort_node, table,
+				 iort->node_offset);
+	iort_end = ACPI_ADD_PTR(struct acpi_iort_node, table,
+				table->length);
+
+	for (i = 0; i < iort->node_count; i++) {
+
+		if (iort_node >= iort_end) {
+			pr_err("iort node pointer overflows, bad table\n");
+			return -EINVAL;
+		}
+
+		if (iort_node->type == ACPI_IORT_NODE_SMMU_V3) {
+			ret = arm_smmu_init();
+			if (ret)
+				return ret;
+
+			fwnode = iommu_alloc_fwnode();
+
+			if (!fwnode)
+				return -ENOMEM;
+
+			ret = iort_set_fwnode(iort_node, fwnode);
+			if (ret)
+				goto free;
+		}
+
+		iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort_node,
+					 iort_node->length);
+	}
+
+	return 0;
+free:
+	iommu_free_fwnode(fwnode);
+	return ret;
+
+}
+IORT_ACPI_DECLARE(arm_smmu_v3, ACPI_SIG_IORT, acpi_smmu_v3_init);
+#endif
+
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
 MODULE_AUTHOR("Will Deacon <will.deacon@arm.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.10.0

