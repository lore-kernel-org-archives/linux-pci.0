Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44525 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932955AbcFGNbb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 7 Jun 2016 09:31:31 -0400
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
Subject: [RFC PATCH v2 13/15] drivers: acpi: iort: introduce iort_iommu_configure
Date: Tue,  7 Jun 2016 14:31:08 +0100
Message-Id: <1465306270-27076-14-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

DT based systems have a generic kernel API to configure IOMMUs
for devices (ie of_iommu_configure()).

On ARM based ACPI systems, the of_iommu_configure() equivalent can
be implemented atop ACPI IORT kernel API, with the corresponding
functions to map device identifiers to IOMMUs and retrieve the
corresponding IOMMU operations necessary for DMA operations set-up.

The iort_iommu_configure() implementation requires an IORT API
to retrieve the parent node for any given IORT node, so this
patch adds a function to the IORT kernel layer that serves that
specific purpose.

This patch implements the iort based IOMMU configuration for
ARM ACPI systems and hook it up in the ACPI kernel layer that
implements DMA configuration for a device.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Tomasz Nowicki <tn@semihalf.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 drivers/acpi/iort.c  | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/scan.c  |  7 ++++-
 include/linux/iort.h |  7 +++++
 3 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/iort.c b/drivers/acpi/iort.c
index 2ef08d9..56258ac 100644
--- a/drivers/acpi/iort.c
+++ b/drivers/acpi/iort.c
@@ -213,6 +213,29 @@ iort_scan_node(enum acpi_iort_node_type type,
 	return NULL;
 }
 
+static struct acpi_iort_node *
+iort_find_parent_node(struct acpi_iort_node *node)
+{
+	struct acpi_iort_id_mapping *id;
+
+	if (!node || !node->mapping_offset || !node->mapping_count)
+		return NULL;
+
+	id = ACPI_ADD_PTR(struct acpi_iort_id_mapping, node,
+			  node->mapping_offset);
+
+	if (!id->output_reference) {
+		pr_err(FW_BUG "[node %p type %d] ID map has NULL parent reference\n",
+		       node, node->type);
+		return NULL;
+	}
+
+	node = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
+			    id->output_reference);
+
+	return node;
+}
+
 static acpi_status
 iort_match_callback(struct acpi_iort_node *node, void *context)
 {
@@ -437,6 +460,60 @@ iort_pci_get_domain(struct pci_dev *pdev, u32 req_id)
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
+	const struct iort_ops_node *iort_ops;
+	u32 rid = 0, devid = 0;
+
+	if (dev_is_pci(dev)) {
+		struct pci_bus *bus = to_pci_dev(dev)->bus;
+
+		pci_for_each_dma_alias(to_pci_dev(dev), __get_pci_rid,
+				       &rid);
+
+		node = iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
+				      iort_find_dev_callback, &bus->dev);
+	} else {
+		node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
+				      iort_find_dev_callback, dev);
+	}
+
+	if (!node)
+		return NULL;
+
+	parent = iort_find_parent_node(node);
+
+	if (!parent)
+		return NULL;
+
+	iort_ops = iort_smmu_get_ops_node(parent);
+
+	if (iort_ops && iort_ops->iommu_xlate) {
+		iort_dev_map_rid(node, rid, &devid, parent->type);
+		iort_ops->iommu_xlate(dev, devid, parent);
+		return iort_ops->ops;
+	}
+
+	return NULL;
+}
+
 static int __init
 add_smmu_platform_device(const struct iort_iommu_config *iort_cfg,
 			 struct acpi_iort_node *node)
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
index 5dcfa09..bb29647 100644
--- a/include/linux/iort.h
+++ b/include/linux/iort.h
@@ -30,12 +30,19 @@ struct fwnode_handle *iort_its_find_domain_token(int trans_id);
 bool iort_node_match(u8 type);
 u32 iort_pci_get_msi_rid(struct pci_dev *pdev, u32 req_id);
 struct irq_domain *iort_pci_get_domain(struct pci_dev *pdev, u32 req_id);
+
+/* IOMMU interface */
+const struct iommu_ops *iort_iommu_configure(struct device *dev);
 #else
 static inline bool iort_node_match(u8 type) { return false; }
 static inline u32 iort_pci_get_msi_rid(struct pci_dev *pdev, u32 req_id)
 { return req_id; }
 static inline struct irq_domain *
 iort_pci_get_domain(struct pci_dev *pdev, u32 req_id) { return NULL; }
+
+/* IOMMU interface */
+static inline const struct iommu_ops *
+iort_iommu_configure(struct device *dev) { return NULL; }
 #endif
 int iort_smmu_set_ops(struct acpi_iort_node *node,
 		      const struct iommu_ops *ops,
-- 
2.6.4

