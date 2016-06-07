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
	Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v2 08/15] drivers: acpi: iort: add support for ARM SMMU platform devices creation
Date: Tue,  7 Jun 2016 14:31:03 +0100
Message-Id: <1465306270-27076-9-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
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
that contains hooks (to be defined by specific ARM SMMU drivers) to be
used to define the platform devices names, init the IOMMUs, count their
resources and finally initialize them.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Tomasz Nowicki <tn@semihalf.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 drivers/acpi/iort.c  | 125 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/iort.h |  15 +++++++
 2 files changed, 140 insertions(+)

diff --git a/drivers/acpi/iort.c b/drivers/acpi/iort.c
index 875edde..2ef08d9 100644
--- a/drivers/acpi/iort.c
+++ b/drivers/acpi/iort.c
@@ -25,6 +25,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/pci.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 
 struct iort_its_msi_chip {
@@ -436,6 +437,128 @@ iort_pci_get_domain(struct pci_dev *pdev, u32 req_id)
 	return irq_find_matching_fwnode(handle, DOMAIN_BUS_PCI_MSI);
 }
 
+static int __init
+add_smmu_platform_device(const struct iort_iommu_config *iort_cfg,
+			 struct acpi_iort_node *node)
+{
+	struct platform_device *pdev;
+	struct resource *r;
+	enum dev_dma_attr attr;
+	int ret, count;
+
+	pdev = platform_device_alloc(iort_cfg->name, PLATFORM_DEVID_AUTO);
+	if (!pdev)
+		return PTR_ERR(pdev);
+
+	count = iort_cfg->iommu_count_resources(node);
+
+	r = kcalloc(count, sizeof(*r), GFP_KERNEL);
+	if (!r) {
+		ret = -ENOMEM;
+		goto dev_put;
+	}
+
+	iort_cfg->iommu_init_resources(r, node);
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
+	/*
+	 * Set default dma mask value for the table walker,
+	 * to be overridden on probing with correct value.
+	 */
+	*pdev->dev.dma_mask = DMA_BIT_MASK(32);
+	pdev->dev.coherent_dma_mask = *pdev->dev.dma_mask;
+
+	attr = iort_cfg->iommu_is_coherent(node) ?
+			     DEV_DMA_COHERENT : DEV_DMA_NON_COHERENT;
+
+	/* Configure DMA for the page table walker */
+	arch_setup_dma_ops(&pdev->dev, 0, 0, NULL,
+					 attr == DEV_DMA_COHERENT);
+
+	ret = platform_device_add(pdev);
+	if (ret)
+		goto dma_deconfigure;
+
+	ret = iort_cfg->iommu_init(node);
+	if (ret)
+		goto dma_deconfigure;
+
+	return 0;
+
+dma_deconfigure:
+	arch_teardown_dma_ops(&pdev->dev);
+	kfree(pdev->dev.dma_mask);
+
+dev_put:
+	platform_device_put(pdev);
+
+	return ret;
+}
+
+static int __init iort_smmu_init(void)
+{
+	struct acpi_iort_node *iort_node, *iort_end;
+	struct acpi_table_iort *iort;
+	int i, ret;
+
+	/*
+	 * iort_table and iort both point to the start of IORT table, but
+	 * have different struct types
+	 */
+	iort = (struct acpi_table_iort *)iort_table;
+
+	/* Get the first IORT node */
+	iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort,
+				 iort->node_offset);
+	iort_end = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
+				iort_table->length);
+
+	for (i = 0; i < iort->node_count; i++) {
+		const struct iort_iommu_config *ops;
+
+		if (iort_node >= iort_end) {
+			pr_err("iort node pointer overflows, bad table\n");
+			return -EINVAL;
+		}
+
+		ops = iort_get_iommu_config(iort_node);
+		if (!ops)
+			goto next;
+
+		ret = add_smmu_platform_device(ops, iort_node);
+		if (ret)
+			return ret;
+next:
+		iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort_node,
+					 iort_node->length);
+	}
+
+	return 0;
+}
+
 static int __init iort_table_detect(void)
 {
 	acpi_status status;
@@ -450,6 +573,8 @@ static int __init iort_table_detect(void)
 		return -EINVAL;
 	}
 
+	iort_smmu_init();
+
 	return 0;
 }
 arch_initcall(iort_table_detect);
diff --git a/include/linux/iort.h b/include/linux/iort.h
index 5ebe7e5..ced3054 100644
--- a/include/linux/iort.h
+++ b/include/linux/iort.h
@@ -43,4 +43,19 @@ int iort_smmu_set_ops(struct acpi_iort_node *node,
 					 u32 streamid,
 					 struct acpi_iort_node *node));
 
+struct iort_iommu_config {
+	const char *name;
+	int (*iommu_init)(struct acpi_iort_node *node);
+	bool (*iommu_is_coherent)(struct acpi_iort_node *node);
+	int (*iommu_count_resources)(struct acpi_iort_node *node);
+	void (*iommu_init_resources)(struct resource *res,
+				     struct acpi_iort_node *node);
+};
+
+static inline const struct iort_iommu_config *
+iort_get_iommu_config(struct acpi_iort_node *node)
+{
+	return NULL;
+}
+
 #endif /* __IORT_H__ */
-- 
2.6.4

