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
Subject: [RFC PATCH v2 15/15] drivers: iommu: arm-smmu-v3: allow ACPI based streamid translation
Date: Tue,  7 Jun 2016 14:31:10 +0100
Message-Id: <1465306270-27076-16-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The ACPI IORT table provides data to ARM SMMU drivers to carry out
streamid mappings and the kernel has the infrastructure to implement
it through the iommu_xlate() IORT SMMU operation hook.

By reusing the infrastructure implemented for of_xlate(), this patch
adds the ARM SMMU v3 iommu_xlate() hook to carry out streamid
translation for ARM SMMU v3 on ACPI based systems.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
---
 drivers/iommu/arm-smmu-v3.c | 60 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 7acb6b5..96d0504 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -634,8 +634,23 @@ struct arm_smmu_domain {
 	struct iommu_domain		domain;
 };
 
+enum arm_smmu_fw_type {
+	ARM_SMMU_FW_INVALID = 0,
+	ARM_SMMU_FW_OF,
+	ARM_SMMU_FW_IORT,
+};
+
+struct arm_smmu_fw_handle {
+	enum arm_smmu_fw_type type;
+	union {
+		struct device_node *np;
+		struct acpi_iort_node *iort_node;
+	};
+};
+
 /* SMMU private data for each master */
 struct arm_smmu_master_data {
+	struct arm_smmu_fw_handle	handle;
 	struct arm_smmu_device		*smmu;
 
 	struct arm_smmu_strtab_ent	ste;
@@ -1721,9 +1736,17 @@ arm_smmu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 	return ret;
 }
 
-static struct arm_smmu_device *arm_smmu_get_by_node(struct device_node *np)
+static struct arm_smmu_device *
+arm_smmu_get_dev(struct arm_smmu_fw_handle *handle)
 {
-	struct platform_device *smmu_pdev = of_find_device_by_node(np);
+	struct platform_device *smmu_pdev = NULL;
+
+	if (handle->type == ARM_SMMU_FW_OF) {
+		smmu_pdev = of_find_device_by_node(handle->np);
+		of_node_put(handle->np);
+	} else if (handle->type == ARM_SMMU_FW_IORT) {
+		smmu_pdev = iort_find_iommu_device(handle->iort_node);
+	}
 
 	if (!smmu_pdev)
 		return NULL;
@@ -1743,16 +1766,14 @@ static bool arm_smmu_sid_in_range(struct arm_smmu_device *smmu, u32 sid)
 
 static int arm_smmu_add_device(struct device *dev)
 {
-	struct device_node *np;
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_master_data *data = dev->archdata.iommu;
 
 	if (!data)
 		return -ENODEV;
 
-	np = (struct device_node *)data->smmu;
-	smmu = data->smmu = arm_smmu_get_by_node(np);
-	of_node_put(np);
+	smmu = data->smmu = arm_smmu_get_dev(&data->handle);
+
 	if (!smmu)
 		return -ENODEV;
 
@@ -1854,7 +1875,8 @@ static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
 	 * By the time we see this again in an add_device callback, we'll
 	 * be in a position to fix it up with the real thing.
 	 */
-	data->smmu = (struct arm_smmu_device *)args->np;
+	data->handle.type = ARM_SMMU_FW_OF;
+	data->handle.np = args->np;
 	data->sid = args->args[0];
 	dev->archdata.iommu = data;
 
@@ -2688,9 +2710,31 @@ static int __init arm_smmu_of_init(struct device_node *np)
 IOMMU_OF_DECLARE(arm_smmuv3, "arm,smmu-v3", arm_smmu_of_init);
 
 #ifdef CONFIG_ACPI
+static int arm_smmu_iort_xlate(struct device *dev, u32 streamid,
+			       struct acpi_iort_node *node)
+{
+	struct arm_smmu_master_data *data;
+
+	if (!node || (node->type != ACPI_IORT_NODE_SMMU_V3))
+		return -ENODEV;
+
+	if (dev->archdata.iommu)
+		return -EEXIST;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->handle.type = ARM_SMMU_FW_IORT;
+	data->handle.iort_node = node;
+	data->sid = streamid;
+	dev->archdata.iommu = data;
+	return 0;
+}
+
 static int acpi_smmu_init(struct acpi_iort_node *node)
 {
-	iort_smmu_set_ops(node, &arm_smmu_ops, NULL);
+	iort_smmu_set_ops(node, &arm_smmu_ops, arm_smmu_iort_xlate);
 
 	return 0;
 }
-- 
2.6.4

