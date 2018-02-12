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
Subject: [PATCH 03/37] iommu/sva: Manage process address spaces
Date: Mon, 12 Feb 2018 18:33:18 +0000
Message-Id: <20180212183352.22730-4-jean-philippe.brucker@arm.com>
In-Reply-To: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Introduce boilerplate code for allocating IOMMU mm structures and binding
them to devices. Four operations are added to IOMMU drivers:

* mm_alloc(): to create an io_mm structure and perform architecture-
  specific operations required to grab the process (for instance on ARM,
  pin down the CPU ASID so that the process doesn't get assigned a new
  ASID on rollover).

  There is a single valid io_mm structure per Linux mm. Future extensions
  may also use io_mm for kernel-managed address spaces, populated with
  map()/unmap() calls instead of bound to process address spaces. This
  patch focuses on "shared" io_mm.

* mm_attach(): attach an mm to a device. The IOMMU driver checks that the
  device is capable of sharing an address space, and writes the PASID
  table entry to install the pgd.

  Some IOMMU drivers will have a single PASID table per domain, for
  convenience. Other can implement it differently but to help these
  drivers, mm_attach and mm_detach take 'attach_domain' and
  'detach_domain' parameters, that tell whether they need to set and clear
  the PASID entry or only send the required TLB invalidations.

* mm_detach(): detach an mm from a device. The IOMMU driver removes the
  PASID table entry and invalidates the IOTLBs.

* mm_free(): free a structure allocated by mm_alloc(), and let arch
  release the process.

mm_attach and mm_detach operations are serialized with a spinlock. At the
moment it is global, but if we try to optimize it, the core should at
least prevent concurrent attach()/detach() on the same domain (so
multi-level PASID table code can allocate tables lazily). mm_alloc() can
sleep, but mm_free must not (because we'll have to call it from call_srcu
later on.)

At the moment we use an IDR for allocating PASIDs and retrieving contexts.
We also use a single spinlock. These can be refined and optimized later (a
custom allocator will be needed for top-down PASID allocation).

Keeping track of address spaces requires the use of MMU notifiers.
Handling process exit with regard to unbind() is tricky, so it is left for
another patch and we explicitly fail mm_alloc() for the moment.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/iommu-sva.c | 382 +++++++++++++++++++++++++++++++++++++++++++++-
 drivers/iommu/iommu.c     |   2 +
 include/linux/iommu.h     |  25 +++
 3 files changed, 406 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 593685d891bf..f9af9d66b3ed 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -7,11 +7,321 @@
  * SPDX-License-Identifier: GPL-2.0
  */
 
+#include <linux/idr.h>
 #include <linux/iommu.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+/**
+ * DOC: io_mm model
+ *
+ * The io_mm keeps track of process address spaces shared between CPU and IOMMU.
+ * The following example illustrates the relation between structures
+ * iommu_domain, io_mm and iommu_bond. An iommu_bond is a link between io_mm and
+ * device. A device can have multiple io_mm and an io_mm may be bound to
+ * multiple devices.
+ *              ___________________________
+ *             |  IOMMU domain A           |
+ *             |  ________________         |
+ *             | |  IOMMU group   |        +------- io_pgtables
+ *             | |                |        |
+ *             | |   dev 00:00.0 ----+------- bond --- io_mm X
+ *             | |________________|   \    |
+ *             |                       '----- bond ---.
+ *             |___________________________|           \
+ *              ___________________________             \
+ *             |  IOMMU domain B           |           io_mm Y
+ *             |  ________________         |           / /
+ *             | |  IOMMU group   |        |          / /
+ *             | |                |        |         / /
+ *             | |   dev 00:01.0 ------------ bond -' /
+ *             | |   dev 00:01.1 ------------ bond --'
+ *             | |________________|        |
+ *             |                           +------- io_pgtables
+ *             |___________________________|
+ *
+ * In this example, device 00:00.0 is in domain A, devices 00:01.* are in domain
+ * B. All devices within the same domain access the same address spaces. Device
+ * 00:00.0 accesses address spaces X and Y, each corresponding to an mm_struct.
+ * Devices 00:01.* only access address space Y. In addition each
+ * IOMMU_DOMAIN_DMA domain has a private address space, io_pgtable, that is
+ * managed with iommu_map()/iommu_unmap(), and isn't shared with the CPU MMU.
+ *
+ * To obtain the above configuration, users would for instance issue the
+ * following calls:
+ *
+ *     iommu_sva_bind_device(dev 00:00.0, mm X, ...) -> PASID 1
+ *     iommu_sva_bind_device(dev 00:00.0, mm Y, ...) -> PASID 2
+ *     iommu_sva_bind_device(dev 00:01.0, mm Y, ...) -> PASID 2
+ *     iommu_sva_bind_device(dev 00:01.1, mm Y, ...) -> PASID 2
+ *
+ * A single Process Address Space ID (PASID) is allocated for each mm. In the
+ * example, devices use PASID 1 to read/write into address space X and PASID 2
+ * to read/write into address space Y.
+ *
+ * Hardware tables describing this configuration in the IOMMU would typically
+ * look like this:
+ *
+ *                                PASID tables
+ *                                 of domain A
+ *                              .->+--------+
+ *                             / 0 |        |-------> io_pgtable
+ *                            /    +--------+
+ *            Device tables  /   1 |        |-------> pgd X
+ *              +--------+  /      +--------+
+ *      00:00.0 |      A |-'     2 |        |--.
+ *              +--------+         +--------+   \
+ *              :        :       3 |        |    \
+ *              +--------+         +--------+     --> pgd Y
+ *      00:01.0 |      B |--.                    /
+ *              +--------+   \                  |
+ *      00:01.1 |      B |----+   PASID tables  |
+ *              +--------+     \   of domain B  |
+ *                              '->+--------+   |
+ *                               0 |        |-- | --> io_pgtable
+ *                                 +--------+   |
+ *                               1 |        |   |
+ *                                 +--------+   |
+ *                               2 |        |---'
+ *                                 +--------+
+ *                               3 |        |
+ *                                 +--------+
+ *
+ * With this model, a single call binds all devices in a given domain to an
+ * address space. Other devices in the domain will get the same bond implicitly.
+ * However, users must issue one bind() for each device, because IOMMUs may
+ * implement SVA differently. Furthermore, mandating one bind() per device
+ * allows the driver to perform sanity-checks on device capabilities.
+ *
+ * On Arm and AMD IOMMUs, entry 0 of the PASID table can be used to hold
+ * non-PASID translations. In this case PASID 0 is reserved and entry 0 points
+ * to the io_pgtable base. On Intel IOMMU, the io_pgtable base would be held in
+ * the device table and PASID 0 would be available to the allocator.
+ */
 
 /* TODO: stub for the fault queue. Remove later. */
 #define iommu_fault_queue_flush(...)
 
+struct iommu_bond {
+	struct io_mm		*io_mm;
+	struct device		*dev;
+	struct iommu_domain	*domain;
+
+	struct list_head	mm_head;
+	struct list_head	dev_head;
+	struct list_head	domain_head;
+
+	void			*drvdata;
+
+	/* Number of bind() calls */
+	refcount_t		refs;
+};
+
+/*
+ * Because we're using an IDR, PASIDs are limited to 31 bits (the sign bit is
+ * used for returning errors). In practice implementations will use at most 20
+ * bits, which is the PCI limit.
+ */
+static DEFINE_IDR(iommu_pasid_idr);
+
+/*
+ * For the moment this is an all-purpose lock. It serializes
+ * access/modifications to bonds, access/modifications to the PASID IDR, and
+ * changes to io_mm refcount as well.
+ */
+static DEFINE_SPINLOCK(iommu_sva_lock);
+
+static struct io_mm *
+io_mm_alloc(struct iommu_domain *domain, struct device *dev,
+	    struct mm_struct *mm)
+{
+	int ret;
+	int pasid;
+	struct io_mm *io_mm;
+	struct iommu_param *dev_param = dev->iommu_param;
+
+	if (!dev_param || !domain->ops->mm_alloc || !domain->ops->mm_free)
+		return ERR_PTR(-ENODEV);
+
+	io_mm = domain->ops->mm_alloc(domain, mm);
+	if (IS_ERR(io_mm))
+		return io_mm;
+	if (!io_mm)
+		return ERR_PTR(-ENOMEM);
+
+	/*
+	 * The mm must not be freed until after the driver frees the io_mm
+	 * (which may involve unpinning the CPU ASID for instance, requiring a
+	 * valid mm struct.)
+	 */
+	mmgrab(mm);
+
+	io_mm->mm		= mm;
+	io_mm->release		= domain->ops->mm_free;
+	INIT_LIST_HEAD(&io_mm->devices);
+
+	idr_preload(GFP_KERNEL);
+	spin_lock(&iommu_sva_lock);
+	pasid = idr_alloc_cyclic(&iommu_pasid_idr, io_mm, dev_param->min_pasid,
+				 dev_param->max_pasid + 1, GFP_ATOMIC);
+	io_mm->pasid = pasid;
+	spin_unlock(&iommu_sva_lock);
+	idr_preload_end();
+
+	if (pasid < 0) {
+		ret = pasid;
+		goto err_free_mm;
+	}
+
+	/* TODO: keep track of mm. For the moment, abort. */
+	ret = -ENOSYS;
+	spin_lock(&iommu_sva_lock);
+	idr_remove(&iommu_pasid_idr, io_mm->pasid);
+	spin_unlock(&iommu_sva_lock);
+
+err_free_mm:
+	domain->ops->mm_free(io_mm);
+	mmdrop(mm);
+
+	return ERR_PTR(ret);
+}
+
+static void io_mm_free(struct io_mm *io_mm)
+{
+	struct mm_struct *mm;
+	void (*release)(struct io_mm *);
+
+	release = io_mm->release;
+	mm = io_mm->mm;
+
+	release(io_mm);
+	mmdrop(mm);
+}
+
+static void io_mm_release(struct kref *kref)
+{
+	struct io_mm *io_mm;
+
+	io_mm = container_of(kref, struct io_mm, kref);
+	WARN_ON(!list_empty(&io_mm->devices));
+
+	idr_remove(&iommu_pasid_idr, io_mm->pasid);
+
+	io_mm_free(io_mm);
+}
+
+/*
+ * Returns non-zero if a reference to the io_mm was successfully taken.
+ * Returns zero if the io_mm is being freed and should not be used.
+ */
+static int io_mm_get_locked(struct io_mm *io_mm)
+{
+	if (io_mm)
+		return kref_get_unless_zero(&io_mm->kref);
+
+	return 0;
+}
+
+static void io_mm_put_locked(struct io_mm *io_mm)
+{
+	kref_put(&io_mm->kref, io_mm_release);
+}
+
+static void io_mm_put(struct io_mm *io_mm)
+{
+	spin_lock(&iommu_sva_lock);
+	io_mm_put_locked(io_mm);
+	spin_unlock(&iommu_sva_lock);
+}
+
+static int io_mm_attach(struct iommu_domain *domain, struct device *dev,
+			struct io_mm *io_mm, void *drvdata)
+{
+	int ret;
+	bool attach_domain = true;
+	int pasid = io_mm->pasid;
+	struct iommu_bond *bond, *tmp;
+	struct iommu_param *dev_param = dev->iommu_param;
+
+	if (!dev_param)
+		return -EINVAL;
+
+	if (!domain->ops->mm_attach || !domain->ops->mm_detach)
+		return -ENODEV;
+
+	if (pasid > dev_param->max_pasid || pasid < dev_param->min_pasid)
+		return -ERANGE;
+
+	bond = kzalloc(sizeof(*bond), GFP_KERNEL);
+	if (!bond)
+		return -ENOMEM;
+
+	bond->domain		= domain;
+	bond->io_mm		= io_mm;
+	bond->dev		= dev;
+	bond->drvdata		= drvdata;
+	refcount_set(&bond->refs, 1);
+
+	spin_lock(&iommu_sva_lock);
+	/*
+	 * Check if this io_mm is already bound to the domain. In which case the
+	 * IOMMU driver doesn't have to install the PASID table entry.
+	 */
+	list_for_each_entry(tmp, &domain->mm_list, domain_head) {
+		if (tmp->io_mm == io_mm) {
+			attach_domain = false;
+			break;
+		}
+	}
+
+	ret = domain->ops->mm_attach(domain, dev, io_mm, attach_domain);
+	if (ret) {
+		kfree(bond);
+		spin_unlock(&iommu_sva_lock);
+		return ret;
+	}
+
+	list_add(&bond->mm_head, &io_mm->devices);
+	list_add(&bond->domain_head, &domain->mm_list);
+	list_add(&bond->dev_head, &dev_param->mm_list);
+	spin_unlock(&iommu_sva_lock);
+
+	return 0;
+}
+
+static bool io_mm_detach_locked(struct iommu_bond *bond)
+{
+	struct iommu_bond *tmp;
+	bool detach_domain = true;
+	struct iommu_domain *domain = bond->domain;
+
+	if (!refcount_dec_and_test(&bond->refs))
+		return false;
+
+	list_for_each_entry(tmp, &domain->mm_list, domain_head) {
+		if (tmp->io_mm == bond->io_mm && tmp->dev != bond->dev) {
+			detach_domain = false;
+			break;
+		}
+	}
+
+	domain->ops->mm_detach(domain, bond->dev, bond->io_mm, detach_domain);
+
+	list_del(&bond->mm_head);
+	list_del(&bond->domain_head);
+	list_del(&bond->dev_head);
+	io_mm_put_locked(bond->io_mm);
+
+	kfree(bond);
+
+	return true;
+}
+
+static void io_mm_detach_all_locked(struct iommu_bond *bond)
+{
+	while (!io_mm_detach_locked(bond));
+}
+
 /**
  * iommu_sva_device_init() - Initialize Shared Virtual Addressing for a device
  * @dev: the device
@@ -129,7 +439,10 @@ EXPORT_SYMBOL_GPL(iommu_sva_device_shutdown);
 int iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, int *pasid,
 			  unsigned long flags, void *drvdata)
 {
+	int i, ret;
+	struct io_mm *io_mm = NULL;
 	struct iommu_domain *domain;
+	struct iommu_bond *bond = NULL, *tmp;
 	struct iommu_param *dev_param = dev->iommu_param;
 
 	domain = iommu_get_domain_for_dev(dev);
@@ -145,7 +458,42 @@ int iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, int *pasid,
 	if (flags != (IOMMU_SVA_FEAT_PASID | IOMMU_SVA_FEAT_IOPF))
 		return -EINVAL;
 
-	return -ENOSYS; /* TODO */
+	/* If an io_mm already exists, use it */
+	spin_lock(&iommu_sva_lock);
+	idr_for_each_entry(&iommu_pasid_idr, io_mm, i) {
+		if (io_mm->mm != mm || !io_mm_get_locked(io_mm))
+			continue;
+
+		/* Is it already bound to this device? */
+		list_for_each_entry(tmp, &io_mm->devices, mm_head) {
+			if (tmp->dev != dev)
+				continue;
+
+			bond = tmp;
+			refcount_inc(&bond->refs);
+			io_mm_put_locked(io_mm);
+			break;
+		}
+		break;
+	}
+	spin_unlock(&iommu_sva_lock);
+
+	if (bond)
+		return 0;
+
+	if (!io_mm) {
+		io_mm = io_mm_alloc(domain, dev, mm);
+		if (IS_ERR(io_mm))
+			return PTR_ERR(io_mm);
+	}
+
+	ret = io_mm_attach(domain, dev, io_mm, drvdata);
+	if (ret)
+		io_mm_put(io_mm);
+	else
+		*pasid = io_mm->pasid;
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_sva_bind_device);
 
@@ -165,7 +513,10 @@ EXPORT_SYMBOL_GPL(iommu_sva_bind_device);
  */
 int iommu_sva_unbind_device(struct device *dev, int pasid)
 {
+	int ret = -ESRCH;
+	struct io_mm *io_mm;
 	struct iommu_domain *domain;
+	struct iommu_bond *bond = NULL;
 
 	domain = iommu_get_domain_for_dev(dev);
 	if (WARN_ON(!domain))
@@ -177,7 +528,23 @@ int iommu_sva_unbind_device(struct device *dev, int pasid)
 	 */
 	iommu_fault_queue_flush(dev);
 
-	return -ENOSYS; /* TODO */
+	spin_lock(&iommu_sva_lock);
+	io_mm = idr_find(&iommu_pasid_idr, pasid);
+	if (!io_mm) {
+		spin_unlock(&iommu_sva_lock);
+		return -ESRCH;
+	}
+
+	list_for_each_entry(bond, &io_mm->devices, mm_head) {
+		if (bond->dev == dev) {
+			io_mm_detach_locked(bond);
+			ret = 0;
+			break;
+		}
+	}
+	spin_unlock(&iommu_sva_lock);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
 
@@ -188,8 +555,17 @@ EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
  */
 void __iommu_sva_unbind_dev_all(struct device *dev)
 {
+	struct iommu_bond *bond, *next;
+	struct iommu_param *dev_param = dev->iommu_param;
+
+	if (!dev_param)
+		return;
+
 	iommu_fault_queue_flush(dev);
 
-	/* TODO */
+	spin_lock(&iommu_sva_lock);
+	list_for_each_entry_safe(bond, next, &dev_param->mm_list, dev_head)
+		io_mm_detach_all_locked(bond);
+	spin_unlock(&iommu_sva_lock);
 }
 EXPORT_SYMBOL_GPL(__iommu_sva_unbind_dev_all);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f977851c522b..1d60b32a6744 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -586,6 +586,7 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 		ret = -ENOMEM;
 		goto err_free_name;
 	}
+	INIT_LIST_HEAD(&dev->iommu_param->mm_list);
 
 	kobject_get(group->devices_kobj);
 
@@ -1325,6 +1326,7 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
 	domain->type = type;
 	/* Assume all sizes by default; the driver may override this later */
 	domain->pgsize_bitmap  = bus->iommu_ops->pgsize_bitmap;
+	INIT_LIST_HEAD(&domain->mm_list);
 
 	return domain;
 }
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 1fb10d64b9e5..09d85f44142a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -103,6 +103,18 @@ struct iommu_domain {
 	void *handler_token;
 	struct iommu_domain_geometry geometry;
 	void *iova_cookie;
+
+	struct list_head mm_list;
+};
+
+struct io_mm {
+	int			pasid;
+	struct list_head	devices;
+	struct kref		kref;
+	struct mm_struct	*mm;
+
+	/* Release callback for this mm */
+	void (*release)(struct io_mm *io_mm);
 };
 
 enum iommu_cap {
@@ -204,6 +216,11 @@ struct page_response_msg {
  * @detach_dev: detach device from an iommu domain
  * @sva_device_init: initialize Shared Virtual Adressing for a device
  * @sva_device_shutdown: shutdown Shared Virtual Adressing for a device
+ * @mm_alloc: allocate io_mm
+ * @mm_free: free io_mm
+ * @mm_attach: attach io_mm to a device. Install PASID entry if necessary
+ * @mm_detach: detach io_mm from a device. Remove PASID entry and
+ *             flush associated TLB entries.
  * @map: map a physically contiguous memory region to an iommu domain
  * @unmap: unmap a physically contiguous memory region from an iommu domain
  * @map_sg: map a scatter-gather list of physically contiguous memory chunks
@@ -241,6 +258,13 @@ struct iommu_ops {
 			       unsigned int *min_pasid,
 			       unsigned int *max_pasid);
 	void (*sva_device_shutdown)(struct device *dev);
+	struct io_mm *(*mm_alloc)(struct iommu_domain *domain,
+				  struct mm_struct *mm);
+	void (*mm_free)(struct io_mm *io_mm);
+	int (*mm_attach)(struct iommu_domain *domain, struct device *dev,
+			 struct io_mm *io_mm, bool attach_domain);
+	void (*mm_detach)(struct iommu_domain *domain, struct device *dev,
+			  struct io_mm *io_mm, bool detach_domain);
 	int (*map)(struct iommu_domain *domain, unsigned long iova,
 		   phys_addr_t paddr, size_t size, int prot);
 	size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
@@ -399,6 +423,7 @@ struct iommu_param {
 	unsigned long sva_features;
 	unsigned int min_pasid;
 	unsigned int max_pasid;
+	struct list_head mm_list;
 };
 
 int  iommu_device_register(struct iommu_device *iommu);
-- 
2.15.1

