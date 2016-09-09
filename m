Return-Path: <linux-kernel-owner@vger.kernel.org>
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
        Eric Auger <eric.auger@redhat.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Nate Watterson <nwatters@codeaurora.org>,
        Prem Mallappa <prem.mallappa@broadcom.com>,
        Dennis Chen <dennis.chen@arm.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 14/14] drivers: acpi: iort: introduce iort_iommu_configure
Date: Fri,  9 Sep 2016 15:23:43 +0100
Message-Id: <20160909142343.13314-15-lorenzo.pieralisi@arm.com>
In-Reply-To: <20160909142343.13314-1-lorenzo.pieralisi@arm.com>
References: <20160909142343.13314-1-lorenzo.pieralisi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
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
 drivers/acpi/arm64/iort.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/scan.c       |  7 +++-
 include/linux/acpi_iort.h |  6 +++
 3 files changed, 108 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 7c68eb4..55a4ae9 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -19,6 +19,7 @@
 #define pr_fmt(fmt)	"ACPI: IORT: " fmt
 
 #include <linux/acpi_iort.h>
+#include <linux/iommu-fwspec.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/pci.h>
@@ -27,6 +28,8 @@
 
 #define IORT_TYPE_MASK(type)	(1 << (type))
 #define IORT_MSI_TYPE		(1 << ACPI_IORT_NODE_ITS_GROUP)
+#define IORT_IOMMU_TYPE		((1 << ACPI_IORT_NODE_SMMU) |	\
+				(1 << ACPI_IORT_NODE_SMMU_V3))
 
 struct iort_its_msi_chip {
 	struct list_head	list;
@@ -467,6 +470,99 @@ struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id)
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
+	return ret;
+}
+
+static const struct iommu_ops *iort_iommu_xlate(struct device *dev,
+					struct acpi_iort_node *node,
+					u32 streamid)
+{
+	struct fwnode_handle *iort_fwnode = NULL;
+	int ret;
+
+	if (node) {
+		iort_fwnode = iort_get_fwnode(node);
+		if (!iort_fwnode)
+			return NULL;
+
+		ret = arm_smmu_iort_xlate(dev, streamid,
+					  iort_fwnode);
+		if (!ret)
+			return fwspec_iommu_get_ops(iort_fwnode);
+	}
+
+	return NULL;
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
+	const struct iommu_ops *ops = NULL;
+	u32 streamid = 0;
+
+	if (dev_is_pci(dev)) {
+		struct pci_bus *bus = to_pci_dev(dev)->bus;
+		u32 rid;
+
+		pci_for_each_dma_alias(to_pci_dev(dev), __get_pci_rid,
+				       &rid);
+
+		node = iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
+				      iort_match_node_callback, &bus->dev);
+		if (!node)
+			return NULL;
+
+		parent = iort_node_map_rid(node, rid, &streamid,
+					   IORT_IOMMU_TYPE);
+
+		ops = iort_iommu_xlate(dev, parent, streamid);
+
+	} else {
+		int i = 0;
+
+		node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
+				      iort_match_node_callback, dev);
+		if (!node)
+			return NULL;
+
+		parent = iort_node_get_id(node, &streamid,
+					  IORT_IOMMU_TYPE, i++);
+
+		while (parent) {
+			ops = iort_iommu_xlate(dev, parent, streamid);
+
+			parent = iort_node_get_id(node, &streamid,
+						  IORT_IOMMU_TYPE, i++);
+		}
+	}
+
+	return ops;
+}
+
 static void __init acpi_iort_register_irq(int hwirq, const char *name,
 					  int trigger,
 					  struct resource *res)
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 9614232..7e56a85 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -7,6 +7,7 @@
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/acpi.h>
+#include <linux/acpi_iort.h>
 #include <linux/signal.h>
 #include <linux/kthread.h>
 #include <linux/dmi.h>
@@ -1377,11 +1378,15 @@ enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
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
 
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 1ed4f8f..167649a 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -36,6 +36,8 @@ struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id);
 int iort_set_fwnode(struct acpi_iort_node *iort_node,
 		    struct fwnode_handle *fwnode);
 struct fwnode_handle *iort_get_fwnode(struct acpi_iort_node *node);
+/* IOMMU interface */
+const struct iommu_ops *iort_iommu_configure(struct device *dev);
 #else
 static inline void acpi_iort_init(void) { }
 static inline u32 iort_msi_map_rid(struct device *dev, u32 req_id)
@@ -49,6 +51,10 @@ static inline int iort_set_fwnode(struct acpi_iort_node *iort_node,
 static inline
 struct fwnode_handle *iort_get_fwnode(struct acpi_iort_node *node)
 { return NULL; }
+/* IOMMU interface */
+static inline
+const struct iommu_ops *iort_iommu_configure(struct device *dev)
+{ return NULL; }
 #endif
 
 #define IORT_ACPI_DECLARE(name, table_id, fn)		\
-- 
2.10.0
