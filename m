Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: iommu@lists.linux-foundation.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Tomasz Nowicki <tn@semihalf.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Will Deacon <will.deacon@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Jon Masters <jcm@redhat.com>,
	Sinan Kaya <okaya@codeaurora.org>,
	Nate Watterson <nwatters@codeaurora.org>,
	Dennis Chen <dennis.chen@arm.com>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 09/15] drivers: acpi: iort: add support for ARM SMMU platform devices creation
Date: Mon, 15 Aug 2016 16:23:34 +0100
Message-Id: <1471274620-20754-10-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1471274620-20754-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1471274620-20754-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In ARM ACPI systems, IOMMU components are specified through static
IORT table entries. In order to create platform devices for the
corresponding ARM SMMU components, IORT kernel code should be made
able to parse IORT table entries and create platform devices
dynamically.

This patch adds the generic IORT infrastructure required to create
platform devices for ARM SMMUs.

ARM SMMU versions have different resources requirement therefore this
patch also introduces an IORT specific structure (ie iort_iommu_config)
that contains hooks (to be defined when the corresponding ARM SMMU
driver support is added to the kernel) to be used to define the
platform devices names, init the IOMMUs, count their resources and
finally initialize them.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Tomasz Nowicki <tn@semihalf.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 drivers/acpi/arm64/iort.c | 153 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index f6db3d8..4043071 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -22,6 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/pci.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 
 struct iort_its_msi_chip {
@@ -454,6 +455,157 @@ iort_get_device_domain(struct device *dev, u32 req_id)
 	return irq_find_matching_fwnode(handle, DOMAIN_BUS_PCI_MSI);
 }
 
+struct iort_iommu_config {
+	const char *name;
+	int (*iommu_init)(struct acpi_iort_node *node);
+	bool (*iommu_is_coherent)(struct acpi_iort_node *node);
+	int (*iommu_count_resources)(struct acpi_iort_node *node);
+	void (*iommu_init_resources)(struct resource *res,
+				     struct acpi_iort_node *node);
+};
+
+static const struct iort_iommu_config * __init
+iort_get_iommu_config(struct acpi_iort_node *node)
+{
+	return NULL;
+}
+
+/**
+ * iort_add_smmu_platform_device() - Allocate a platform device for SMMU
+ * @fwnode: IORT node associated fwnode handle
+ * @node: Pointer to SMMU ACPI IORT node
+ *
+ * Returns: 0 on success, <0 failure
+ */
+static int __init
+iort_add_smmu_platform_device(struct fwnode_handle *fwnode,
+			      struct acpi_iort_node *node)
+{
+	struct platform_device *pdev;
+	struct resource *r;
+	enum dev_dma_attr attr;
+	int ret, count;
+	const struct iort_iommu_config *ops =
+				iort_get_iommu_config(node);
+
+	if (!ops)
+		return -ENODEV;
+
+	pdev = platform_device_alloc(ops->name, PLATFORM_DEVID_AUTO);
+	if (!pdev)
+		return PTR_ERR(pdev);
+
+	count = ops->iommu_count_resources(node);
+
+	r = kcalloc(count, sizeof(*r), GFP_KERNEL);
+	if (!r) {
+		ret = -ENOMEM;
+		goto dev_put;
+	}
+
+	ops->iommu_init_resources(r, node);
+
+	ret = platform_device_add_resources(pdev, r, count);
+	/*
+	 * Resources are duplicated in platform_device_add_resources,
+	 * free their allocated memory
+	 */
+	kfree(r);
+
+	if (ret)
+		goto dev_put;
+
+	/*
+	 * Add a copy of IORT node pointer to platform_data to
+	 * be used to retrieve IORT data information.
+	 */
+	ret = platform_device_add_data(pdev, &node, sizeof(node));
+	if (ret)
+		goto dev_put;
+
+	pdev->dev.dma_mask = kmalloc(sizeof(*pdev->dev.dma_mask), GFP_KERNEL);
+	if (!pdev->dev.dma_mask) {
+		ret = -ENOMEM;
+		goto dev_put;
+	}
+
+	pdev->dev.fwnode = fwnode;
+
+	/*
+	 * Set default dma mask value for the table walker,
+	 * to be overridden on probing with correct value.
+	 */
+	*pdev->dev.dma_mask = DMA_BIT_MASK(32);
+	pdev->dev.coherent_dma_mask = *pdev->dev.dma_mask;
+
+	attr = ops->iommu_is_coherent(node) ?
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
+
+dev_put:
+	platform_device_put(pdev);
+
+	return ret;
+}
+
+static void __init iort_smmu_init(void)
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
+	iort = (struct acpi_table_iort *)iort_table;
+
+	/* Get the first IORT node */
+	iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
+				 iort->node_offset);
+	iort_end = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
+				iort_table->length);
+
+	for (i = 0; i < iort->node_count; i++) {
+
+		if (iort_node >= iort_end) {
+			pr_err("iort node pointer overflows, bad table\n");
+			return;
+		}
+
+		if (iort_node->type == ACPI_IORT_NODE_SMMU ||
+		    iort_node->type == ACPI_IORT_NODE_SMMU_V3) {
+			fwnode = iort_get_fwnode(iort_node);
+
+			if (!fwnode)
+				continue;
+
+			ret = iort_add_smmu_platform_device(fwnode,
+							    iort_node);
+			if (ret) {
+				pr_err("Error in platform device creation\n");
+				return;
+			}
+		}
+
+		iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort_node,
+					 iort_node->length);
+	}
+}
+
 void __init iort_table_detect(void)
 {
 	acpi_status status;
@@ -465,4 +617,5 @@ void __init iort_table_detect(void)
 	}
 
 	acpi_probe_device_table(iort);
+	iort_smmu_init();
 }
-- 
2.6.4

