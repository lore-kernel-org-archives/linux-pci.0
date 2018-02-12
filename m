Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org
Cc: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com,
        alex.williamson@redhat.com, tn@semihalf.com, liubo95@huawei.com,
        thunder.leizhen@huawei.com, xieyisheng1@huawei.com,
        xuzaibo@huawei.com, ilias.apalodimas@linaro.org,
        jonathan.cameron@huawei.com, shunyong.yang@hxt-semitech.com,
        nwatters@codeaurora.org, okaya@codeaurora.org,
        jcrouse@codeaurora.org, rfranz@cavium.com, dwmw2@infradead.org,
        jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        ashok.raj@intel.com, robdclark@gmail.com, christian.koenig@amd.com,
        bharatku@xilinx.com
Subject: [PATCH 02/37] iommu/sva: Bind process address spaces to devices
Date: Mon, 12 Feb 2018 18:33:17 +0000
Message-Id: <20180212183352.22730-3-jean-philippe.brucker@arm.com>
In-Reply-To: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add bind() and unbind() operations to the IOMMU API. Device drivers can
use them to share process page tables with their devices. bind_group()
is provided for VFIO's convenience, as it needs to provide a coherent
interface on containers. Other device drivers will most likely want to
use bind_device(), which binds a single device in the group.

Regardless of the IOMMU group or domain a device is in, device drivers
should call bind() for each device that will use the PASID.

This patch only adds skeletons for the device driver API, most of the
implementation is still missing.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/iommu-sva.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c     |  63 ++++++++++++++++++++++++++++
 include/linux/iommu.h     |  36 ++++++++++++++++
 3 files changed, 204 insertions(+)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index cab5d723520f..593685d891bf 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -9,6 +9,9 @@
 
 #include <linux/iommu.h>
 
+/* TODO: stub for the fault queue. Remove later. */
+#define iommu_fault_queue_flush(...)
+
 /**
  * iommu_sva_device_init() - Initialize Shared Virtual Addressing for a device
  * @dev: the device
@@ -78,6 +81,8 @@ int iommu_sva_device_shutdown(struct device *dev)
 	if (!domain)
 		return -ENODEV;
 
+	__iommu_sva_unbind_dev_all(dev);
+
 	if (domain->ops->sva_device_shutdown)
 		domain->ops->sva_device_shutdown(dev);
 
@@ -88,3 +93,103 @@ int iommu_sva_device_shutdown(struct device *dev)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iommu_sva_device_shutdown);
+
+/**
+ * iommu_sva_bind_device() - Bind a process address space to a device
+ * @dev: the device
+ * @mm: the mm to bind, caller must hold a reference to it
+ * @pasid: valid address where the PASID will be stored
+ * @flags: bond properties (IOMMU_SVA_FEAT_*)
+ * @drvdata: private data passed to the mm exit handler
+ *
+ * Create a bond between device and task, allowing the device to access the mm
+ * using the returned PASID. A subsequent bind() for the same device and mm will
+ * reuse the bond (and return the same PASID), but users will have to call
+ * unbind() twice.
+ *
+ * Callers should have taken care of setting up SVA for this device with
+ * iommu_sva_device_init() beforehand. They may also be notified of the bond
+ * disappearing, for example when the last task that uses the mm dies, by
+ * registering a notifier with iommu_register_mm_exit_handler().
+ *
+ * If IOMMU_SVA_FEAT_PASID is requested, a PASID is allocated and returned.
+ * TODO: The alternative, binding the non-PASID context to an mm, isn't
+ * supported at the moment because existing IOMMU domain types initialize the
+ * non-PASID context for iommu_map()/unmap() or bypass. This requires a new
+ * domain type.
+ *
+ * If IOMMU_SVA_FEAT_IOPF is not requested, the caller must pin down all
+ * mappings shared with the device. mlock() isn't sufficient, as it doesn't
+ * prevent minor page faults (e.g. copy-on-write). TODO: !IOPF isn't allowed at
+ * the moment.
+ *
+ * On success, 0 is returned and @pasid contains a valid ID. Otherwise, an error
+ * is returned.
+ */
+int iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, int *pasid,
+			  unsigned long flags, void *drvdata)
+{
+	struct iommu_domain *domain;
+	struct iommu_param *dev_param = dev->iommu_param;
+
+	domain = iommu_get_domain_for_dev(dev);
+	if (!domain)
+		return -EINVAL;
+
+	if (!pasid)
+		return -EINVAL;
+
+	if (!dev_param || (flags & ~dev_param->sva_features))
+		return -EINVAL;
+
+	if (flags != (IOMMU_SVA_FEAT_PASID | IOMMU_SVA_FEAT_IOPF))
+		return -EINVAL;
+
+	return -ENOSYS; /* TODO */
+}
+EXPORT_SYMBOL_GPL(iommu_sva_bind_device);
+
+/**
+ * iommu_sva_unbind_device() - Remove a bond created with iommu_sva_bind_device
+ * @dev: the device
+ * @pasid: the pasid returned by bind()
+ *
+ * Remove bond between device and address space identified by @pasid. Users
+ * should not call unbind() if the corresponding mm exited (as the PASID might
+ * have been reallocated to another process.)
+ *
+ * The device must not be issuing any more transaction for this PASID. All
+ * outstanding page requests for this PASID must have been flushed to the IOMMU.
+ *
+ * Returns 0 on success, or an error value
+ */
+int iommu_sva_unbind_device(struct device *dev, int pasid)
+{
+	struct iommu_domain *domain;
+
+	domain = iommu_get_domain_for_dev(dev);
+	if (WARN_ON(!domain))
+		return -EINVAL;
+
+	/*
+	 * Caller stopped the device from issuing PASIDs, now make sure they are
+	 * out of the fault queue.
+	 */
+	iommu_fault_queue_flush(dev);
+
+	return -ENOSYS; /* TODO */
+}
+EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
+
+/**
+ * __iommu_sva_unbind_dev_all() - Detach all address spaces from this device
+ *
+ * When detaching @device from a domain, IOMMU drivers should use this helper.
+ */
+void __iommu_sva_unbind_dev_all(struct device *dev)
+{
+	iommu_fault_queue_flush(dev);
+
+	/* TODO */
+}
+EXPORT_SYMBOL_GPL(__iommu_sva_unbind_dev_all);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d4a4edaf2d8c..f977851c522b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1535,6 +1535,69 @@ void iommu_detach_group(struct iommu_domain *domain, struct iommu_group *group)
 }
 EXPORT_SYMBOL_GPL(iommu_detach_group);
 
+/*
+ * iommu_sva_bind_group() - Share address space with all devices in the group.
+ * @group: the iommu group
+ * @mm: the mm to bind
+ * @pasid: valid address where the PASID will be stored
+ * @flags: bond properties (IOMMU_PROCESS_BIND_*)
+ * @drvdata: private data passed to the mm exit handler
+ *
+ * Create a bond between group and process, allowing devices in the group to
+ * access the process address space using @pasid.
+ *
+ * Refer to iommu_sva_bind_device() for more details.
+ *
+ * On success, 0 is returned and @pasid contains a valid ID. Otherwise, an error
+ * is returned.
+ */
+int iommu_sva_bind_group(struct iommu_group *group, struct mm_struct *mm,
+			 int *pasid, unsigned long flags, void *drvdata)
+{
+	struct group_device *device;
+	int ret = -ENODEV;
+
+	if (!group->domain)
+		return -EINVAL;
+
+	mutex_lock(&group->mutex);
+	list_for_each_entry(device, &group->devices, list) {
+		ret = iommu_sva_bind_device(device->dev, mm, pasid, flags,
+					    drvdata);
+		if (ret)
+			break;
+	}
+
+	if (ret) {
+		list_for_each_entry_continue_reverse(device, &group->devices, list)
+			iommu_sva_unbind_device(device->dev, *pasid);
+	}
+	mutex_unlock(&group->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_sva_bind_group);
+
+/**
+ * iommu_sva_unbind_group() - Remove a bond created with iommu_sva_bind_group()
+ * @group: the group
+ * @pasid: the pasid returned by bind
+ *
+ * Refer to iommu_sva_unbind_device() for more details.
+ */
+int iommu_sva_unbind_group(struct iommu_group *group, int pasid)
+{
+	struct group_device *device;
+
+	mutex_lock(&group->mutex);
+	list_for_each_entry(device, &group->devices, list)
+		iommu_sva_unbind_device(device->dev, pasid);
+	mutex_unlock(&group->mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iommu_sva_unbind_group);
+
 phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 {
 	if (unlikely(domain->ops->iova_to_phys == NULL))
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e9e09eecdece..1fb10d64b9e5 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -576,6 +576,10 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 void iommu_fwspec_free(struct device *dev);
 int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
 const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode);
+extern int iommu_sva_bind_group(struct iommu_group *group,
+				struct mm_struct *mm, int *pasid,
+				unsigned long flags, void *drvdata);
+extern int iommu_sva_unbind_group(struct iommu_group *group, int pasid);
 
 #else /* CONFIG_IOMMU_API */
 
@@ -890,12 +894,28 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 	return NULL;
 }
 
+static inline int iommu_sva_bind_group(struct iommu_group *group,
+				       struct mm_struct *mm, int *pasid,
+				       unsigned long flags, void *drvdata)
+{
+	return -ENODEV;
+}
+
+static inline int iommu_sva_unbind_group(struct iommu_group *group, int pasid)
+{
+	return -ENODEV;
+}
+
 #endif /* CONFIG_IOMMU_API */
 
 #ifdef CONFIG_IOMMU_SVA
 extern int iommu_sva_device_init(struct device *dev, unsigned long features,
 				 unsigned int max_pasid);
 extern int iommu_sva_device_shutdown(struct device *dev);
+extern int iommu_sva_bind_device(struct device *dev, struct mm_struct *mm,
+				int *pasid, unsigned long flags, void *drvdata);
+extern int iommu_sva_unbind_device(struct device *dev, int pasid);
+extern void __iommu_sva_unbind_dev_all(struct device *dev);
 #else /* CONFIG_IOMMU_SVA */
 static inline int iommu_sva_device_init(struct device *dev,
 					unsigned long features,
@@ -908,6 +928,22 @@ static inline int iommu_sva_device_shutdown(struct device *dev)
 {
 	return -ENODEV;
 }
+
+static inline int iommu_sva_bind_device(struct device *dev,
+					struct mm_struct *mm, int *pasid,
+					unsigned long flags, void *drvdata)
+{
+	return -ENODEV;
+}
+
+static inline int iommu_sva_unbind_device(struct device *dev, int pasid)
+{
+	return -ENODEV;
+}
+
+static inline void __iommu_sva_unbind_dev_all(struct device *dev)
+{
+}
 #endif /* CONFIG_IOMMU_SVA */
 
 #endif /* __LINUX_IOMMU_H */
-- 
2.15.1

