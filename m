Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: 
Subject: [RFC PATCH 22/30] iommu: Bind/unbind tasks to/from devices
Date: Mon, 27 Feb 2017 19:54:33 +0000
Message-Id: <20170227195441.5170-23-jean-philippe.brucker@arm.com>
In-Reply-To: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Shanker Donthineni <shankerd@qti.qualcomm.com>, kvm@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Sinan Kaya <okaya@qti.qualcomm.com>, Will Deacon <will.deacon@arm.com>,
 iommu@lists.linux-foundation.org, Harv Abdulhamid <harba@qti.qualcomm.com>,
 Alex Williamson <alex.williamson@redhat.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 Nate Watterson <nwatters@qti.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Add three functions to the IOMMU API. iommu_bind_task takes a device and a
task as argument. If the IOMMU, the device and the bus support it, attach
task to device and create a Process Address Space ID (PASID) unique to the
device. DMA from the device can then use the PASID to read or write into
the address space. iommu_unbind_task removes a bond created with
iommu_bind_task. iommu_set_svm_ops allows a device driver to set some
callbacks for specific SVM-related operations.

Try to accommodate current implementations (AMD, Intel and ARM), by
letting the IOMMU driver do all the work, but attempt by the same occasion
to find intersections between implementations.

* amd_iommu_v2 expects the device to allocate a PASID and pass it to the
  IOMMU. The driver also provides separate functions to register callbacks
  that handles failed PRI requests and invalidate PASIDs.

  int amd_iommu_bind_pasid(struct pci_dev *pdev, int pasid,
			   struct task_struct *task)
  void amd_iommu_unbind_pasid(struct pci_dev *pdev, int pasid)
  int amd_iommu_set_invalid_ppr_cb(struct pci_dev *pdev,
				   amd_iommu_invalid_ppr_cb cb)
  int amd_iommu_set_invalidate_ctx_cb(struct pci_dev *pdev,
				      amd_iommu_invalidate_ctx cb)

* intel-svm allocates a PASID, and requires the driver to pass
  "svm_dev_ops", which currently contains a fault callback. It also
  doesn't take a task as argument, but uses 'current'.

  int intel_svm_bind_mm(struct device *dev, int *pasid, int flags,
			struct svm_dev_ops *ops)
  int intel_svm_unbind_mm(struct device *dev, int pasid)

* For arm-smmu-v3, PASID must be allocated by the SMMU driver since it
  indexes contexts in an array handled by the SMMU device.


  Bind and unbind
  ===============

The following could suit existing implementations:

int iommu_bind_task(struct device *dev, struct task_struct *task,
		    int *pasid, int flags, void *priv);

int iommu_unbind_task(struct device *dev, int pasid, int flags);

This is similar to existing functions.
* @dev is a SVM-capable device. If it is not, bind fails,
* @task is a userspace task. It doesn't have to be current, but
  implementations can reject the call if they only support current.
* @pasid is a handle for the bond. It would be nice to have the IOMMU
  driver handle PASID allocation, for consistency. Otherwise, the
  requirement for drivers to allocate PASIDs might be advertised in a
  capability.
* @flags represents parameters of bind/unbind. We might want to reserve a
  few bits, maybe the bottom half, for the API, and give the rest to the
  driver.
* @priv will be passed to SVM callbacks targeting this bond


  SVM device callbacks
  =====================

Making svm_dev_ops (here iommu_svm_ops) a first-class citizen of struct
device would be a useful next step. Device drivers could set this
structure when they want to participate in SVM. For the moment,
iommu_set_svm_ops must be called. I'm not sure what to do when assigning a
device via VFIO. Should we remove the SVM ops when detaching from a
domain, or have the device driver remove them when detaching itself from a
device?

  Fault handling
  --------------

The first callback allows a driver to be notified when the IOMMU driver
cannot handle a fault.

amd_iommu_v2 has:

int (*amd_iommu_invalid_ppr_cb)(struct pci_dev *pdev, int pasid,
				unsigned long address, u16 prot)

intel-svm has (called for all faults):

void (*fault_cb)(struct device *dev, int pasid, u64 address, u32 private,
		 int rwxp, int response)

We put the following in iommu_svm_ops:

int (*handle_fault)(struct device *dev, int pasid, u64 address, int prot,
		    int status, void *priv);

The IOMMU driver calls handle_mm_fault and sends the result back to the
device. If the fault cannot be handled, it gives a chance to the device
driver to record the fault and maybe even fix it up. @pasid, @address and
@prot are copied from the page request. @status is the return value of
handle_mm_fault. @prot could use the format defined in iommu.h
(IOMMU_READ, IOMMU_WRITE, etc.) @status could be a combination of
VM_FAULT_* as returned by handle_mm_fault, but this leaves out the case
where we don't even reach the fault handling part. We could instead define
new status flags: one for failure to locate the context associated to the
PASID, one for failure of mm to handle the fault. We cannot piggy-back on
existing IOMMU_FAULT_READ and WRITE in their current state, because
devices might request both read and write permissions at the same time.
They would need to be redefined as flags.

All callbacks have a @priv field. This is an opaque pointer set by the
device driver when binding. This way the device driver gets both a PASID
and its metadata in the callback, and we avoid duplicating pasid state
lookups in both IOMMU driver and device driver.

Another question is the location of the callback. IOMMU driver could
notify device driver either:

* before handle_mm_fault, to do some custom fault handling and perhaps
  bypass the IOMMU handler entirely,
* after handle_mm_fault, to notify the driver of an error (AMD),
* after handle_mm_fault, to notify the driver of any page request (Intel),

We might want to let the driver decide when binding a PASID, or offer two
callbacks: handle_fault and report_fault. I don't have a proposal for this
yet.

handle_fault returns the response that the IOMMU driver should send to the
device. Either success, meaning that the page has been mapped (or it is
likely to succeed later), or failure, meaning that the device shouldn't
bother retrying.

It would be nice to reconcile with the iommu_fault_handler API, that isn't
widely used yet but is being considered for handling domain faults from
platform devices on the SMMUv2, using the stall model instead of ATS/PRI.
Yet another concern for ARM is that platform devices may issue traffic
over multiple stream IDs, for instance one stream ID per channel in a DMA
engine. handle_fault doesn't provide a way to pass those stream IDs back
to the driver.

  PASID invalidation
  ------------------

Next, we need to let the IOMMU driver notify the device driver before it
attempts to unbind a PASID. Subsequent patches discuss PASID invalidation
in more details, so we'll simply propose the following interface for now.

AMD has:

void (*amd_iommu_invalidate_ctx)(struct pci_dev *pdev, int pasid);

We put the following in iommu_svm_ops:

int (*invalidate_pasid)(struct device *dev, int pasid, void *priv);

  Capability detection
  ====================

I didn't add any public function for detecting SVM capability yet. In my
opinion, a nice way to do it is to have user query the state of the device
to know if they can call bind/unbind. If the IOMMU supports SVM, and the
IOMMU driver was able to enable it successfully in the device, then user
can call bind/unbind on the device.

In the VFIO patch later in this series, I implemented the PCIe detection
like this: if ATS, PRI and PASID are enabled (by the IOMMU driver), then
the device can do SVM. If for some reason the IOMMU is incompatible with
the device's SVM properties or is incompatible with the MMU page tables,
then it shouldn't enable PRI or PASID. For platform devices, the
requirements are very blurry at the moment. We'll probably add a device-
tree property saying that a device and its bus are SVM-capable. The
following interface could be added to the API:

int iommu_svm_capable(struct device *dev, int flags);

This tells the device driver whether the IOMMU driver is capable of
binding a task to the device. @flags may contain specific SVM capabilities
(paging/pinned, executable, etc) and the function could return a subset of
these flags. For PCI devices, everything is enabled when this call is
successful. For platform devices the device driver would have to enable
SVM itself.

  API naming
  ==========

I realize that "SVM" as a name isn't great because the svm namespace is
already taken by AMD-V (Secure Virtual Machine) in arch/x86. Also, the
name itself doesn't say much.

I personally prefer "Unified Virtual Addressing" (UVA), adopted by CUDA,
or rather Unified Virtual Address Space (UVAS). Another possibility is
Unified Virtual Memory (UVM). Acronym UAS for Unified Address Space is
already used by USB. Same for Shared Address Space (SAS), already in use
in the kernel, but SVAS would work (although it doesn't look good).

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/iommu.c | 108 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h |  41 +++++++++++++++++++
 2 files changed, 149 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8ea14f41a979..26c5f6528c69 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1438,6 +1438,114 @@ void iommu_detach_group(struct iommu_domain *domain, struct iommu_group *group)
 }
 EXPORT_SYMBOL_GPL(iommu_detach_group);
 
+int iommu_set_svm_ops(struct device *dev, const struct iommu_svm_ops *svm_ops)
+{
+	const struct iommu_ops *ops;
+	struct iommu_group *group;
+	int ret;
+
+	group = iommu_group_get_for_dev(dev);
+	if (IS_ERR(group))
+		return PTR_ERR(group);
+
+	ops = dev->bus->iommu_ops;
+	if (!ops->set_svm_ops) {
+		iommu_group_put(group);
+		return -ENODEV;
+	}
+
+	mutex_lock(&group->mutex);
+	ret = ops->set_svm_ops(dev, svm_ops);
+	mutex_unlock(&group->mutex);
+
+	iommu_group_put(group);
+	return ret;
+
+}
+EXPORT_SYMBOL_GPL(iommu_set_svm_ops);
+
+/*
+ * iommu_bind_task - Share task address space with device
+ *
+ * @dev: device to bind
+ * @task: task to bind
+ * @pasid: valid address where the PASID is stored
+ * @flags: driver-specific flags
+ * @priv: private data to associate with the bond
+ *
+ * Create a bond between device and task, allowing the device to access the task
+ * address space using @pasid. Intel and ARM SMMU drivers allocate and return
+ * the PASID, while AMD requires the caller to allocate a PASID beforehand.
+ *
+ * iommu_unbind_task must be called with this PASID before the task exits.
+ */
+int iommu_bind_task(struct device *dev, struct task_struct *task, int *pasid,
+		    int flags, void *priv)
+{
+	const struct iommu_ops *ops;
+	struct iommu_group *group;
+	int ret;
+
+	if (!pasid)
+		return -EINVAL;
+
+	group = iommu_group_get(dev);
+	if (!group)
+		return -ENODEV;
+
+	ops = dev->bus->iommu_ops;
+	if (!ops->bind_task) {
+		iommu_group_put(group);
+		return -ENODEV;
+	}
+
+	mutex_lock(&group->mutex);
+	if (!group->domain)
+		ret = -EINVAL;
+	else
+		ret = ops->bind_task(dev, task, pasid, flags, priv);
+	mutex_unlock(&group->mutex);
+
+	iommu_group_put(group);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_bind_task);
+
+/*
+ * iommu_unbind_task - Remove a bond created with iommu_bind_task
+ *
+ * @dev: device bound to the task
+ * @pasid: identifier of the bond
+ * @flags: state of the PASID and driver-specific flags
+ */
+int iommu_unbind_task(struct device *dev, int pasid, int flags)
+{
+	const struct iommu_ops *ops;
+	struct iommu_group *group;
+	int ret;
+
+	group = iommu_group_get(dev);
+	if (!group)
+		return -ENODEV;
+
+	ops = dev->bus->iommu_ops;
+	if (!ops->unbind_task) {
+		iommu_group_put(group);
+		return -ENODEV;
+	}
+
+	mutex_lock(&group->mutex);
+	if (!group->domain)
+		ret = -EINVAL;
+	else
+		ret = ops->unbind_task(dev, pasid, flags);
+	mutex_unlock(&group->mutex);
+
+	iommu_group_put(group);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_unbind_task);
+
 phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 {
 	if (unlikely(domain->ops->iova_to_phys == NULL))
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 6a6de187ddc0..9554f45d4305 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -145,6 +145,16 @@ struct iommu_resv_region {
 	int			type;
 };
 
+/*
+ * @handle_fault: report or handle a fault from the device (FIXME: imprecise)
+ * @invalidate_pasid: stop using a PASID.
+ */
+struct iommu_svm_ops {
+	int (*handle_fault)(struct device *dev, int pasid, u64 address,
+			    int prot, int status, void *priv);
+	int (*invalidate_pasid)(struct device *dev, int pasid, void *priv);
+};
+
 #ifdef CONFIG_IOMMU_API
 
 /**
@@ -154,6 +164,9 @@ struct iommu_resv_region {
  * @domain_free: free iommu domain
  * @attach_dev: attach device to an iommu domain
  * @detach_dev: detach device from an iommu domain
+ * @set_svm_ops: set SVM callbacks for device
+ * @bind_task: attach a task address space to a device
+ * @unbind_task: detach a task address space from a device
  * @map: map a physically contiguous memory region to an iommu domain
  * @unmap: unmap a physically contiguous memory region from an iommu domain
  * @map_sg: map a scatter-gather list of physically contiguous memory chunks
@@ -183,6 +196,10 @@ struct iommu_ops {
 
 	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
 	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
+	int (*set_svm_ops)(struct device *dev, const struct iommu_svm_ops *ops);
+	int (*bind_task)(struct device *dev, struct task_struct *task,
+			 int *pasid, int flags, void *priv);
+	int (*unbind_task)(struct device *dev, int pasid, int flags);
 	int (*map)(struct iommu_domain *domain, unsigned long iova,
 		   phys_addr_t paddr, size_t size, int prot);
 	size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
@@ -403,6 +420,13 @@ void iommu_fwspec_free(struct device *dev);
 int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
 const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode);
 
+extern int iommu_set_svm_ops(struct device *dev,
+			     const struct iommu_svm_ops *svm_ops);
+extern int iommu_bind_task(struct device *dev, struct task_struct *task,
+			   int *pasid, int flags, void *priv);
+
+extern int iommu_unbind_task(struct device *dev, int pasid, int flags);
+
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -663,6 +687,23 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 	return NULL;
 }
 
+static inline int iommu_set_svm_ops(struct device *dev,
+				    const struct iommu_svm_ops *svm_ops)
+{
+	return -ENODEV;
+}
+
+static inline int iommu_bind_task(struct device *dev, struct task_struct *task,
+				  int *pasid, int flags, void *priv)
+{
+	return -ENODEV;
+}
+
+static int iommu_unbind_task(struct device *dev, int pasid, int flags)
+{
+	return -ENODEV;
+}
+
 #endif /* CONFIG_IOMMU_API */
 
 #endif /* __LINUX_IOMMU_H */
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
