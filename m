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
	Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v3 11/13] drivers: iommu: arm-smmu-v3: add IORT platform device creation
Date: Wed, 20 Jul 2016 12:23:33 +0100
Message-Id: <1469013815-24380-12-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1469013815-24380-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1469013815-24380-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
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
 drivers/acpi/iort.c         | 98 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/iommu/arm-smmu-v3.c | 58 +++++++++++++++++++++++++++
 2 files changed, 155 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/iort.c b/drivers/acpi/iort.c
index 23c80c7..c91e45d 100644
--- a/drivers/acpi/iort.c
+++ b/drivers/acpi/iort.c
@@ -455,6 +455,90 @@ iort_get_device_domain(struct device *dev, u32 req_id)
 	return irq_find_matching_fwnode(handle, DOMAIN_BUS_PCI_MSI);
 }
 
+static void acpi_smmu_v3_register_irq(int hwirq, const char *name,
+				      struct resource *res)
+{
+	int irq = acpi_register_gsi(NULL, hwirq, ACPI_EDGE_SENSITIVE,
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
+static int arm_smmu_v3_count_resources(struct acpi_iort_node *node)
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
+static void arm_smmu_v3_init_resources(struct resource *res,
+				       struct acpi_iort_node *node)
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
+		acpi_smmu_v3_register_irq(smmu->event_gsiv, "eventq",
+					  &res[num_res++]);
+
+	if (smmu->pri_gsiv)
+		acpi_smmu_v3_register_irq(smmu->pri_gsiv, "priq",
+				       &res[num_res++]);
+
+	if (smmu->gerr_gsiv)
+		acpi_smmu_v3_register_irq(smmu->gerr_gsiv, "gerror",
+					  &res[num_res++]);
+
+	if (smmu->sync_gsiv)
+		acpi_smmu_v3_register_irq(smmu->sync_gsiv, "cmdq-sync",
+					  &res[num_res++]);
+}
+
+static bool arm_smmu_v3_is_coherent(struct acpi_iort_node *node)
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
@@ -464,10 +548,22 @@ struct iort_iommu_config {
 				     struct acpi_iort_node *node);
 };
 
+const struct iort_iommu_config iort_arm_smmu_v3_cfg = {
+	.name = "arm-smmu-v3",
+	.iommu_is_coherent = arm_smmu_v3_is_coherent,
+	.iommu_count_resources = arm_smmu_v3_count_resources,
+	.iommu_init_resources = arm_smmu_v3_init_resources
+};
+
 static inline const struct iort_iommu_config *
 iort_get_iommu_config(struct acpi_iort_node *node)
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
index 1a4e9ce..294ed5e 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1749,6 +1749,8 @@ arm_smmu_get_by_fwnode(struct fwnode_handle *handle)
 
 	if (is_of_node(handle))
 		smmu_pdev = of_find_device_by_node(to_of_node(handle));
+	else if (is_fwnode_iommu(handle))
+		smmu_pdev = platform_find_device_by_fwnode(handle);
 
 	if (!smmu_pdev)
 		return NULL;
@@ -1771,6 +1773,7 @@ static struct iommu_ops arm_smmu_ops;
 static int arm_smmu_add_device(struct device *dev)
 {
 	int i, ret;
+
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_master_data *master;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec(dev);
@@ -2741,6 +2744,61 @@ static int __init arm_smmu_of_init(struct device_node *np)
 }
 IOMMU_OF_DECLARE(arm_smmuv3, "arm,smmu-v3", arm_smmu_of_init);
 
+#ifdef CONFIG_ACPI
+static int acpi_smmu_v3_init(struct acpi_table_header *table)
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
+			fwnode = iommu_alloc_fwnode();
+
+			if (!fwnode)
+				return -ENOMEM;
+
+			ret = iort_add_smmu_platform_device(fwnode,
+							    iort_node);
+			if (ret)
+				goto free;
+
+			fwspec_iommu_set_ops(fwnode, &arm_smmu_ops);
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
+
+#endif
+
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
 MODULE_AUTHOR("Will Deacon <will.deacon@arm.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.6.4

