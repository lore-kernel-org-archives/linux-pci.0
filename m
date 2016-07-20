Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41401 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753749AbcGTLYR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 20 Jul 2016 07:24:17 -0400
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
Subject: [RFC PATCH v3 13/13] drivers: acpi: iort: introduce iort_iommu_configure
Date: Wed, 20 Jul 2016 12:23:35 +0100
Message-Id: <1469013815-24380-14-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1469013815-24380-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1469013815-24380-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

DT based systems have a generic kernel API to configure IOMMUs
for devices (ie of_iommu_configure()).

On ARM based ACPI systems, the of_iommu_configure() equivalent can
be implemented atop ACPI IORT kernel API, with the corresponding
functions to map device identifiers to IOMMUs and retrieve the
corresponding IOMMU operations necessary for DMA operations set-up.

By relying on the iommu_fwspec generic kernel infrastructure,
implement the IORT based IOMMU configuration for ARM ACPI systems
and hook it up in the ACPI kernel layer that implements DMA
configuration for a device.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Tomasz Nowicki <tn@semihalf.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 drivers/acpi/iort.c  | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/scan.c  |  7 +++++-
 include/linux/iort.h |  4 ++++
 3 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/iort.c b/drivers/acpi/iort.c
index c116b68..a12a4ff 100644
--- a/drivers/acpi/iort.c
+++ b/drivers/acpi/iort.c
@@ -18,6 +18,7 @@
 
 #define pr_fmt(fmt)	"ACPI: IORT: " fmt
 
+#include <linux/iommu-fwspec.h>
 #include <linux/iort.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -27,6 +28,8 @@
 
 #define IORT_TYPE_MASK(type)	(1 << (type))
 #define IORT_MSI_TYPE		(1 << ACPI_IORT_NODE_ITS_GROUP)
+#define IORT_IOMMU_TYPE		((1 << ACPI_IORT_NODE_SMMU) |	\
+				(1 << ACPI_IORT_NODE_SMMU_V3))
 
 struct iort_its_msi_chip {
 	struct list_head	list;
@@ -458,6 +461,67 @@ iort_get_device_domain(struct device *dev, u32 req_id)
 	return irq_find_matching_fwnode(handle, DOMAIN_BUS_PCI_MSI);
 }
 
+static int __get_pci_rid(struct pci_dev *pdev, u16 alias, void *data)
+{
+	u32 *rid = data;
+
+	*rid = alias;
+	return 0;
+}
+
+static int arm_smmu_iort_xlate(struct device *dev, u32 streamid,
+			       struct fwnode_handle *fwnode)
+{
+	int ret = iommu_fwspec_init(dev, fwnode);
+
+	if (!ret)
+		ret = iommu_fwspec_add_ids(dev, &streamid, 1);
+
+	return 0;
+}
+
+/**
+ * iort_iommu_configure - Set-up IOMMU configuration for a device.
+ *
+ * @dev: device to configure
+ *
+ * Returns: iommu_ops pointer on configuration success
+ *          NULL on configuration failure
+ */
+const struct iommu_ops *iort_iommu_configure(struct device *dev)
+{
+	struct acpi_iort_node *node, *parent;
+	struct fwnode_handle *iort_fwnode;
+	u32 rid = 0, devid = 0;
+
+	if (dev_is_pci(dev)) {
+		struct pci_bus *bus = to_pci_dev(dev)->bus;
+
+		pci_for_each_dma_alias(to_pci_dev(dev), __get_pci_rid,
+				       &rid);
+
+		node = iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
+				      iort_match_node_callback, &bus->dev);
+	} else {
+		node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
+				      iort_match_node_callback, dev);
+	}
+
+	if (!node)
+		return NULL;
+
+	parent = iort_node_map_rid(node, rid, &devid, IORT_IOMMU_TYPE);
+	if (parent) {
+		iort_fwnode = iort_get_fwnode(parent);
+		if (iort_fwnode) {
+			arm_smmu_iort_xlate(dev, devid, iort_fwnode);
+			return fwspec_iommu_get_ops(iort_fwnode);
+		}
+	}
+
+	return NULL;
+}
+
 static void acpi_smmu_v3_register_irq(int hwirq, const char *name,
 				      struct resource *res)
 {
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index b4b9064..de28825 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -7,6 +7,7 @@
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/acpi.h>
+#include <linux/iort.h>
 #include <linux/signal.h>
 #include <linux/kthread.h>
 #include <linux/dmi.h>
@@ -1365,11 +1366,15 @@ enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
  */
 void acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
 {
+	const struct iommu_ops *iommu;
+
+	iommu = iort_iommu_configure(dev);
+
 	/*
 	 * Assume dma valid range starts at 0 and covers the whole
 	 * coherent_dma_mask.
 	 */
-	arch_setup_dma_ops(dev, 0, dev->coherent_dma_mask + 1, NULL,
+	arch_setup_dma_ops(dev, 0, dev->coherent_dma_mask + 1, iommu,
 			   attr == DEV_DMA_COHERENT);
 }
 
diff --git a/include/linux/iort.h b/include/linux/iort.h
index 18e6836..bbe08ef 100644
--- a/include/linux/iort.h
+++ b/include/linux/iort.h
@@ -34,6 +34,8 @@ struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id);
 /* IOMMU interface */
 int iort_add_smmu_platform_device(struct fwnode_handle *fwnode,
 				  struct acpi_iort_node *node);
+
+const struct iommu_ops *iort_iommu_configure(struct device *dev);
 #else
 static inline bool iort_node_match(u8 type) { return false; }
 static inline void iort_table_detect(void) { }
@@ -48,6 +50,8 @@ iort_add_smmu_platform_device(struct fwnode_handle *fwnode,
 {
 	return -ENODEV;
 }
+static inline const struct iommu_ops *
+iort_iommu_configure(struct device *dev) { return NULL; }
 #endif
 
 #define IORT_ACPI_DECLARE(name, table_id, fn)		\
-- 
2.6.4

