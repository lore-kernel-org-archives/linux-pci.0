Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: iommu@lists.linux-foundation.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>,
	Joerg Roedel <joro@8bytes.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Will Deacon <will.deacon@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Jon Masters <jcm@redhat.com>,
	Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 09/11] drivers: acpi: implement acpi_dma_configure
Date: Thu, 14 Apr 2016 18:25:41 +0100
Message-Id: <1460654743-7896-10-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1460654743-7896-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1460654743-7896-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On DT based systems, the of_dma_configure() API implements DMA configuration
for a given device. On ACPI systems an API equivalent to of_dma_configure()
is missing which implies that it is currently not possible to set-up DMA
operations for devices through the ACPI generic kernel layer.

This patch fills the gap by introducing acpi_dma_configure/deconfigure()
calls, that carry out IOMMU configuration through IORT (on systems where
it is present) and call arch_setup_dma_ops(...) with the retrieved
parameters.

The DMA range size passed to arch_setup_dma_ops() is sized according
to the device coherent_dma_mask (starting at address 0x0), mirroring the
DT probing path behaviour when a dma-ranges property is not provided
for the device being probed; this changes the current arch_setup_dma_ops()
call parameters in the ACPI probing case, but since arch_setup_dma_ops()
is a NOP on all architectures but ARM/ARM64 this patch does not change
the current kernel behaviour on them.

This patch updates ACPI and PCI core code to use the newly introduced
acpi_dma_configure function, providing the same functionality
as of_dma_configure on ARM systems and leaving behaviour unchanged
for all other arches.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Tomasz Nowicki <tn@semihalf.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 drivers/acpi/glue.c     |  4 +--
 drivers/acpi/iort.c     | 85 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/scan.c     | 29 +++++++++++++++++
 drivers/pci/probe.c     |  3 +-
 include/acpi/acpi_bus.h |  2 ++
 include/linux/acpi.h    |  5 +++
 include/linux/iort.h    |  9 ++++++
 7 files changed, 133 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 5ea5dc2..f8d6564 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -227,8 +227,7 @@ int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
 
 	attr = acpi_get_dma_attr(acpi_dev);
 	if (attr != DEV_DMA_NOT_SUPPORTED)
-		arch_setup_dma_ops(dev, 0, 0, NULL,
-				   attr == DEV_DMA_COHERENT);
+		acpi_dma_configure(dev, attr);
 
 	acpi_physnode_link_name(physical_node_name, node_id);
 	retval = sysfs_create_link(&acpi_dev->dev.kobj, &dev->kobj,
@@ -251,6 +250,7 @@ int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
 	return 0;
 
  err:
+	acpi_dma_deconfigure(dev);
 	ACPI_COMPANION_SET(dev, NULL);
 	put_device(dev);
 	put_device(&acpi_dev->dev);
diff --git a/drivers/acpi/iort.c b/drivers/acpi/iort.c
index 2b5ce65..b1bb8fb 100644
--- a/drivers/acpi/iort.c
+++ b/drivers/acpi/iort.c
@@ -72,6 +72,31 @@ int iort_iommu_set_node(struct iommu_ops *ops, struct acpi_iort_node *node,
 	return 0;
 }
 
+/**
+ * iort_iommu_get_node - Retrieve iort_iommu_node associated with an IORT node.
+ *
+ * @node: IORT table node to be looked-up
+ *
+ * Returns: iort_iommu_node pointer on success
+ *          NULL on failure
+ */
+static struct iort_iommu_node *iort_iommu_get_node(struct acpi_iort_node *node)
+{
+	struct iort_iommu_node *iommu_node;
+
+	spin_lock(&iort_iommu_lock);
+	list_for_each_entry(iommu_node, &iort_iommu_list, list) {
+		if (iommu_node->node == node)
+			goto found;
+	}
+
+	iommu_node = NULL;
+found:
+	spin_unlock(&iort_iommu_lock);
+
+	return iommu_node;
+}
+
 typedef acpi_status (*iort_find_node_callback)
 	(struct acpi_iort_node *node, void *context);
 
@@ -405,6 +430,66 @@ iort_pci_get_domain(struct pci_dev *pdev, u32 req_id)
 	return domain_handle;
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
+ * @dev: device that requires IOMMU set-up
+ *
+ * Returns: iommu_ops pointer on configuration success
+ *          NULL on configuration failure
+ */
+struct iommu_ops *iort_iommu_configure(struct device *dev)
+{
+	struct acpi_iort_node *node, *parent;
+	struct iommu_ops *ops = NULL;
+	struct iommu_fwspec fwspec;
+	struct iort_iommu_node *iommu_node;
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
+	} else
+		node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
+				      iort_find_dev_callback, dev);
+
+	if (!node)
+		return NULL;
+
+	iort_dev_map_rid(node, rid, &devid, ACPI_IORT_NODE_SMMU);
+
+	parent = iort_find_parent_node(node, ACPI_IORT_NODE_SMMU);
+
+	if (!parent)
+		return NULL;
+
+	iommu_node = iort_iommu_get_node(parent);
+	ops = iommu_node->ops;
+
+	fwspec.fwnode = iommu_node->fwnode;
+	fwspec.param_count = 1;
+	fwspec.param[0] = devid;
+
+	if (!ops || !ops->fw_xlate || ops->fw_xlate(dev, &fwspec))
+		return NULL;
+
+	return ops;
+}
+
+
 static int __init iort_table_detect(void)
 {
 	acpi_status status;
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 5f28cf7..e0fd5e3 100644
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
@@ -1358,6 +1359,34 @@ enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
 		return DEV_DMA_NON_COHERENT;
 }
 
+/**
+ * acpi_dma_configure - Set-up DMA configuration for the device.
+ * @dev: The pointer to the device
+ * @attr: device dma attributes
+ */
+void acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
+{
+	struct iommu_ops *iommu;
+
+	iommu = iort_iommu_configure(dev);
+
+	/*
+	 * Assume dma valid range starts at 0 and covers the whole
+	 * coherent_dma_mask.
+	 */
+	arch_setup_dma_ops(dev, 0, dev->coherent_dma_mask + 1, iommu,
+			   attr == DEV_DMA_COHERENT);
+}
+
+/**
+ * acpi_dma_deconfigure - Tear-down DMA configuration for the device.
+ * @dev: The pointer to the device
+ */
+void acpi_dma_deconfigure(struct device *dev)
+{
+	arch_teardown_dma_ops(dev);
+}
+
 static void acpi_init_coherency(struct acpi_device *adev)
 {
 	unsigned long long cca = 0;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ef569e8..9cf90b8 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1725,8 +1725,7 @@ static void pci_dma_configure(struct pci_dev *dev)
 		if (attr == DEV_DMA_NOT_SUPPORTED)
 			dev_warn(&dev->dev, "DMA not supported.\n");
 		else
-			arch_setup_dma_ops(&dev->dev, 0, 0, NULL,
-					   attr == DEV_DMA_COHERENT);
+			acpi_dma_configure(&dev->dev, attr);
 	}
 
 	pci_put_host_bridge_device(bridge);
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 14362a8..212eff2 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -566,6 +566,8 @@ struct acpi_pci_root {
 
 bool acpi_dma_supported(struct acpi_device *adev);
 enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev);
+void acpi_dma_configure(struct device *dev, enum dev_dma_attr attr);
+void acpi_dma_deconfigure(struct device *dev);
 
 struct acpi_device *acpi_find_child_device(struct acpi_device *parent,
 					   u64 address, bool check_children);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 06ed7e5..69b9041 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -683,6 +683,11 @@ static inline enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
 	return DEV_DMA_NOT_SUPPORTED;
 }
 
+static inline void acpi_dma_configure(struct device *dev,
+				      enum dev_dma_attr attr) { }
+
+static inline void acpi_dma_deconfigure(struct device *dev) { }
+
 #define ACPI_PTR(_ptr)	(NULL)
 
 #endif	/* !CONFIG_ACPI */
diff --git a/include/linux/iort.h b/include/linux/iort.h
index 766adda..7a7af40 100644
--- a/include/linux/iort.h
+++ b/include/linux/iort.h
@@ -31,6 +31,15 @@ struct fwnode_handle *iort_pci_get_domain(struct pci_dev *pdev, u32 req_id);
 int iort_iommu_set_node(struct iommu_ops *ops, struct acpi_iort_node *node,
 			struct fwnode_handle *fwnode);
 
+#ifdef CONFIG_IORT_TABLE
+struct iommu_ops *iort_iommu_configure(struct device *dev);
+#else
+static inline struct iommu_ops *iort_iommu_configure(struct device *dev)
+{
+	return NULL;
+}
+#endif
+
 #define IORT_ACPI_DECLARE(name, table_id, fn)		\
 	ACPI_DECLARE_PROBE_ENTRY(iort, name, table_id, 0, NULL, 0, fn)
 
-- 
2.6.4

