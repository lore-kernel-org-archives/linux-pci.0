Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <lorenzo.pieralisi@arm.com>, <marc.zyngier@arm.com>,
        <sudeep.holla@arm.com>, <will.deacon@arm.com>,
        <robin.murphy@arm.com>, <joro@8bytes.org>, <bhelgaas@google.com>,
        <gabriele.paoloni@huawei.com>
CC: <john.garry@huawei.com>, <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devel@acpica.org>, <linuxarm@huawei.com>,
        <wangzhou1@hisilicon.com>, <guohanjun@huawei.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v9 1/4] ACPI/IORT: Add msi address regions reservation helper
Date: Fri, 6 Oct 2017 15:04:47 +0100
Message-ID: <20171006140450.89652-2-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20171006140450.89652-1-shameerali.kolothum.thodi@huawei.com>
References: <20171006140450.89652-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On some platforms msi parent address regions have to be excluded from
normal IOVA allocation in that they are detected and decoded in a HW
specific way by system components and so they cannot be considered normal
IOVA address space.

Add a helper function that retrieves ITS address regions - the msi
parent - through IORT device <-> ITS mappings and reserves it so that
these regions will not be translated by IOMMU and will be excluded from
IOVA allocations.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
[lorenzo.pieralisi@arm.com: updated commit log/added comments]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/acpi/arm64/iort.c        | 97 ++++++++++++++++++++++++++++++++++++++--
 drivers/irqchip/irq-gic-v3-its.c |  3 +-
 include/linux/acpi_iort.h        |  7 ++-
 3 files changed, 102 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 9565d57..876c0e1 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -39,6 +39,7 @@
 struct iort_its_msi_chip {
 	struct list_head	list;
 	struct fwnode_handle	*fw_node;
+	phys_addr_t		base_addr;
 	u32			translation_id;
 };
 
@@ -136,14 +137,16 @@ typedef acpi_status (*iort_find_node_callback)
 static DEFINE_SPINLOCK(iort_msi_chip_lock);
 
 /**
- * iort_register_domain_token() - register domain token and related ITS ID
- * to the list from where we can get it back later on.
+ * iort_register_domain_token() - register domain token along with related
+ * ITS ID and base address to the list from where we can get it back later on.
  * @trans_id: ITS ID.
+ * @base: ITS base address.
  * @fw_node: Domain token.
  *
  * Returns: 0 on success, -ENOMEM if no memory when allocating list element
  */
-int iort_register_domain_token(int trans_id, struct fwnode_handle *fw_node)
+int iort_register_domain_token(int trans_id, phys_addr_t base,
+			       struct fwnode_handle *fw_node)
 {
 	struct iort_its_msi_chip *its_msi_chip;
 
@@ -153,6 +156,7 @@ int iort_register_domain_token(int trans_id, struct fwnode_handle *fw_node)
 
 	its_msi_chip->fw_node = fw_node;
 	its_msi_chip->translation_id = trans_id;
+	its_msi_chip->base_addr = base;
 
 	spin_lock(&iort_msi_chip_lock);
 	list_add(&its_msi_chip->list, &iort_msi_chip_list);
@@ -481,6 +485,24 @@ int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
 	return -ENODEV;
 }
 
+static int __maybe_unused iort_find_its_base(u32 its_id, phys_addr_t *base)
+{
+	struct iort_its_msi_chip *its_msi_chip;
+	bool match = false;
+
+	spin_lock(&iort_msi_chip_lock);
+	list_for_each_entry(its_msi_chip, &iort_msi_chip_list, list) {
+		if (its_msi_chip->translation_id == its_id) {
+			*base = its_msi_chip->base_addr;
+			match = true;
+			break;
+		}
+	}
+	spin_unlock(&iort_msi_chip_lock);
+
+	return match ? 0 : -ENODEV;
+}
+
 /**
  * iort_dev_find_its_id() - Find the ITS identifier for a device
  * @dev: The device.
@@ -639,6 +661,73 @@ int iort_add_device_replay(const struct iommu_ops *ops, struct device *dev)
 
 	return err;
 }
+
+/**
+ * iort_iommu_msi_get_resv_regions - Reserved region driver helper
+ * @dev: Device from iommu_get_resv_regions()
+ * @head: Reserved region list from iommu_get_resv_regions()
+ *
+ * Returns: Number of reserved regions on success (0 if no associated msi
+ *          regions), appropriate error value otherwise. The ITS interrupt
+ *          translation space(ITS_base + 0x010000) associated with the device
+ *          are the msi reserved regions.
+ */
+int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
+{
+	struct acpi_iort_its_group *its;
+	struct acpi_iort_node *node, *its_node = NULL;
+	int i, resv = 0;
+
+	node = iort_find_dev_node(dev);
+	if (!node)
+		return -ENODEV;
+
+	/*
+	 * Current logic to reserve ITS regions relies on HW topologies
+	 * where a given PCI or named component maps its IDs to only one
+	 * ITS group; if a PCI or named component can map its IDs to
+	 * different ITS groups through IORT mappings this function has
+	 * to be reworked to ensure we reserve regions for all ITS groups
+	 * a given PCI or named component may map IDs to.
+	 */
+	if (dev_is_pci(dev)) {
+		u32 rid;
+
+		pci_for_each_dma_alias(to_pci_dev(dev), __get_pci_rid, &rid);
+		its_node = iort_node_map_id(node, rid, NULL, IORT_MSI_TYPE);
+	} else {
+		for (i = 0; i < node->mapping_count; i++) {
+			its_node = iort_node_map_platform_id(node, NULL,
+							 IORT_MSI_TYPE, i);
+			if (its_node)
+				break;
+		}
+	}
+
+	if (!its_node)
+		return 0;
+
+	/* Move to ITS specific data */
+	its = (struct acpi_iort_its_group *)its_node->node_data;
+
+	for (i = 0; i < its->its_count; i++) {
+		phys_addr_t base;
+
+		if (!iort_find_its_base(its->identifiers[i], &base)) {
+			int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
+			struct iommu_resv_region *region;
+
+			region = iommu_alloc_resv_region(base + SZ_64K, SZ_64K,
+							 prot, IOMMU_RESV_MSI);
+			if (region) {
+				list_add_tail(&region->list, head);
+				resv++;
+			}
+		}
+	}
+
+	return (resv == its->its_count) ? resv : -ENODEV;
+}
 #else
 static inline
 const struct iommu_ops *iort_fwspec_iommu_ops(struct iommu_fwspec *fwspec)
@@ -646,6 +735,8 @@ const struct iommu_ops *iort_fwspec_iommu_ops(struct iommu_fwspec *fwspec)
 static inline
 int iort_add_device_replay(const struct iommu_ops *ops, struct device *dev)
 { return 0; }
+int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
+{ return -ENODEV; }
 #endif
 
 static int iort_iommu_xlate(struct device *dev, struct acpi_iort_node *node,
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index e8d8934..19d1ff6 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3197,7 +3197,8 @@ static int __init gic_acpi_parse_madt_its(struct acpi_subtable_header *header,
 		return -ENOMEM;
 	}
 
-	err = iort_register_domain_token(its_entry->translation_id, dom_handle);
+	err = iort_register_domain_token(its_entry->translation_id, res.start,
+					 dom_handle);
 	if (err) {
 		pr_err("ITS@%pa: Unable to register GICv3 ITS domain token (ITS ID %d) to IORT\n",
 		       &res.start, its_entry->translation_id);
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 8d3f0bf..182a577 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -26,7 +26,8 @@
 #define IORT_IRQ_MASK(irq)		(irq & 0xffffffffULL)
 #define IORT_IRQ_TRIGGER_MASK(irq)	((irq >> 32) & 0xffffffffULL)
 
-int iort_register_domain_token(int trans_id, struct fwnode_handle *fw_node);
+int iort_register_domain_token(int trans_id, phys_addr_t base,
+			       struct fwnode_handle *fw_node);
 void iort_deregister_domain_token(int trans_id);
 struct fwnode_handle *iort_find_domain_token(int trans_id);
 #ifdef CONFIG_ACPI_IORT
@@ -38,6 +39,7 @@
 /* IOMMU interface */
 void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *size);
 const struct iommu_ops *iort_iommu_configure(struct device *dev);
+int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
 #else
 static inline void acpi_iort_init(void) { }
 static inline u32 iort_msi_map_rid(struct device *dev, u32 req_id)
@@ -52,6 +54,9 @@ static inline void iort_dma_setup(struct device *dev, u64 *dma_addr,
 static inline
 const struct iommu_ops *iort_iommu_configure(struct device *dev)
 { return NULL; }
+static inline
+int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
+{ return -ENODEV; }
 #endif
 
 #endif /* __ACPI_IORT_H__ */
-- 
1.9.1


