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
Subject: [PATCH 05/37] iommu/sva: Track mm changes with an MMU notifier
Date: Mon, 12 Feb 2018 18:33:20 +0000
Message-Id: <20180212183352.22730-6-jean-philippe.brucker@arm.com>
In-Reply-To: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When creating an io_mm structure, register an MMU notifier that informs
us when the virtual address space changes and disappears.

Add one new operation to the IOMMU driver: mm_invalidate is called when
a range of addresses is unmapped, to let the IOMMU driver send ATC
invalidations.

Adding the notifier complicates io_mm release. In one case device
drivers free the io_mm explicitly by calling unbind (or detaching the
device from its domain). In the other case the process could crash
before unbind, in which case the release notifier has to do all the
work.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/Kconfig     |   1 +
 drivers/iommu/iommu-sva.c | 161 ++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/iommu.h     |  10 +++
 3 files changed, 165 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 555147a61f7c..146eebe9a4bb 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -77,6 +77,7 @@ config IOMMU_DMA
 config IOMMU_SVA
 	bool "Shared Virtual Addressing API for the IOMMU"
 	select IOMMU_API
+	select MMU_NOTIFIER
 	help
 	  Enable process address space management for the IOMMU API. In systems
 	  that support it, device drivers can bind process address spaces to
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 90b524c99d3d..9108adb54ec7 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -9,7 +9,9 @@
 
 #include <linux/idr.h>
 #include <linux/iommu.h>
+#include <linux/mmu_notifier.h>
 #include <linux/slab.h>
+#include <linux/sched/mm.h>
 #include <linux/spinlock.h>
 
 /**
@@ -131,6 +133,8 @@ static DEFINE_IDR(iommu_pasid_idr);
  */
 static DEFINE_SPINLOCK(iommu_sva_lock);
 
+static struct mmu_notifier_ops iommu_mmu_notifier;
+
 static struct io_mm *
 io_mm_alloc(struct iommu_domain *domain, struct device *dev,
 	    struct mm_struct *mm)
@@ -157,6 +161,7 @@ io_mm_alloc(struct iommu_domain *domain, struct device *dev,
 	mmgrab(mm);
 
 	io_mm->mm		= mm;
+	io_mm->notifier.ops	= &iommu_mmu_notifier;
 	io_mm->release		= domain->ops->mm_free;
 	INIT_LIST_HEAD(&io_mm->devices);
 
@@ -173,8 +178,29 @@ io_mm_alloc(struct iommu_domain *domain, struct device *dev,
 		goto err_free_mm;
 	}
 
-	/* TODO: keep track of mm. For the moment, abort. */
-	ret = -ENOSYS;
+	ret = mmu_notifier_register(&io_mm->notifier, mm);
+	if (ret)
+		goto err_free_pasid;
+
+	/*
+	 * Now that the MMU notifier is valid, we can allow users to grab this
+	 * io_mm by setting a valid refcount. Before that it was accessible in
+	 * the IDR but invalid.
+	 *
+	 * The following barrier ensures that users, who obtain the io_mm with
+	 * kref_get_unless_zero, don't read uninitialized fields in the
+	 * structure.
+	 */
+	smp_wmb();
+	kref_init(&io_mm->kref);
+
+	return io_mm;
+
+err_free_pasid:
+	/*
+	 * Even if the io_mm is accessible from the IDR at this point, kref is
+	 * 0 so no user could get a reference to it. Free it manually.
+	 */
 	spin_lock(&iommu_sva_lock);
 	idr_remove(&iommu_pasid_idr, io_mm->pasid);
 	spin_unlock(&iommu_sva_lock);
@@ -186,11 +212,13 @@ io_mm_alloc(struct iommu_domain *domain, struct device *dev,
 	return ERR_PTR(ret);
 }
 
-static void io_mm_free(struct io_mm *io_mm)
+static void io_mm_free(struct rcu_head *rcu)
 {
+	struct io_mm *io_mm;
 	struct mm_struct *mm;
 	void (*release)(struct io_mm *);
 
+	io_mm = container_of(rcu, struct io_mm, rcu);
 	release = io_mm->release;
 	mm = io_mm->mm;
 
@@ -207,7 +235,22 @@ static void io_mm_release(struct kref *kref)
 
 	idr_remove(&iommu_pasid_idr, io_mm->pasid);
 
-	io_mm_free(io_mm);
+	/*
+	 * If we're being released from mm exit, the notifier callback ->release
+	 * has already been called. Otherwise we don't need ->release, the io_mm
+	 * isn't attached to anything anymore. Hence no_release.
+	 */
+	mmu_notifier_unregister_no_release(&io_mm->notifier, io_mm->mm);
+
+	/*
+	 * We can't free the structure here, because if mm exits during
+	 * unbind(), then ->release might be attempting to grab the io_mm
+	 * concurrently. And in the other case, if ->release is calling
+	 * io_mm_release, then __mmu_notifier_release expects to still have a
+	 * valid mn when returning. So free the structure when it's safe, after
+	 * the RCU grace period elapsed.
+	 */
+	mmu_notifier_call_srcu(&io_mm->rcu, io_mm_free);
 }
 
 /*
@@ -216,8 +259,14 @@ static void io_mm_release(struct kref *kref)
  */
 static int io_mm_get_locked(struct io_mm *io_mm)
 {
-	if (io_mm)
-		return kref_get_unless_zero(&io_mm->kref);
+	if (io_mm && kref_get_unless_zero(&io_mm->kref)) {
+		/*
+		 * kref_get_unless_zero doesn't provide ordering for reads. This
+		 * barrier pairs with the one in io_mm_alloc.
+		 */
+		smp_rmb();
+		return 1;
+	}
 
 	return 0;
 }
@@ -246,7 +295,8 @@ static int io_mm_attach(struct iommu_domain *domain, struct device *dev,
 	if (!dev_param)
 		return -EINVAL;
 
-	if (!domain->ops->mm_attach || !domain->ops->mm_detach)
+	if (!domain->ops->mm_attach || !domain->ops->mm_detach ||
+	    !domain->ops->mm_invalidate)
 		return -ENODEV;
 
 	if (pasid > dev_param->max_pasid || pasid < dev_param->min_pasid)
@@ -322,6 +372,103 @@ static void io_mm_detach_all_locked(struct iommu_bond *bond)
 	while (!io_mm_detach_locked(bond));
 }
 
+static int iommu_signal_mm_exit(struct iommu_bond *bond)
+{
+	struct device *dev = bond->dev;
+	struct io_mm *io_mm = bond->io_mm;
+
+	if (!dev->iommu_param || !dev->iommu_param->mm_exit)
+		return 0;
+
+	return dev->iommu_param->mm_exit(dev, io_mm->pasid, bond->drvdata);
+}
+
+/*
+ * Called when the mm exits. Might race with unbind() or any other function
+ * dropping the last reference to the mm.
+ */
+static void iommu_notifier_release(struct mmu_notifier *mn, struct mm_struct *mm)
+{
+	struct iommu_bond *bond, *next;
+	struct io_mm *io_mm = container_of(mn, struct io_mm, notifier);
+
+	/*
+	 * If the mm is exiting then devices are still bound to the io_mm.
+	 * A few things need to be done before it is safe to release:
+	 *
+	 * - As the mmu notifier doesn't hold any reference to the io_mm when
+	 *   calling ->release(), try to take a reference.
+	 * - Tell the device driver to stop using this PASID.
+	 * - Clear the PASID table and invalidate TLBs.
+	 * - Drop all references to this io_mm by freeing the bonds.
+	 */
+	spin_lock(&iommu_sva_lock);
+	if (!io_mm_get_locked(io_mm)) {
+		/* Someone's already taking care of it. */
+		spin_unlock(&iommu_sva_lock);
+		return;
+	}
+
+	list_for_each_entry_safe(bond, next, &io_mm->devices, mm_head) {
+		if (iommu_signal_mm_exit(bond))
+			dev_WARN(bond->dev, "possible leak of PASID %u",
+				 io_mm->pasid);
+
+		io_mm_detach_all_locked(bond);
+	}
+	spin_unlock(&iommu_sva_lock);
+
+	iommu_fault_queue_flush(NULL);
+
+	/*
+	 * We're now reasonably certain that no more fault is being handled for
+	 * this io_mm, since we just flushed them all out of the fault queue.
+	 * Release the last reference to free the io_mm.
+	 */
+	io_mm_put(io_mm);
+}
+
+static void iommu_notifier_invalidate_range(struct mmu_notifier *mn,
+					    struct mm_struct *mm,
+					    unsigned long start,
+					    unsigned long end)
+{
+	struct iommu_bond *bond;
+	struct io_mm *io_mm = container_of(mn, struct io_mm, notifier);
+
+	spin_lock(&iommu_sva_lock);
+	list_for_each_entry(bond, &io_mm->devices, mm_head) {
+		struct iommu_domain *domain = bond->domain;
+
+		domain->ops->mm_invalidate(domain, bond->dev, io_mm, start,
+					   end - start);
+	}
+	spin_unlock(&iommu_sva_lock);
+}
+
+static int iommu_notifier_clear_flush_young(struct mmu_notifier *mn,
+					    struct mm_struct *mm,
+					    unsigned long start,
+					    unsigned long end)
+{
+	iommu_notifier_invalidate_range(mn, mm, start, end);
+	return 0;
+}
+
+static void iommu_notifier_change_pte(struct mmu_notifier *mn,
+				      struct mm_struct *mm,
+				      unsigned long address, pte_t pte)
+{
+	iommu_notifier_invalidate_range(mn, mm, address, address + PAGE_SIZE);
+}
+
+static struct mmu_notifier_ops iommu_mmu_notifier = {
+	.release		= iommu_notifier_release,
+	.clear_flush_young	= iommu_notifier_clear_flush_young,
+	.change_pte		= iommu_notifier_change_pte,
+	.invalidate_range	= iommu_notifier_invalidate_range,
+};
+
 /**
  * iommu_sva_device_init() - Initialize Shared Virtual Addressing for a device
  * @dev: the device
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 1b1a16892ac1..afec7b1d3301 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -25,6 +25,7 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/of.h>
+#include <linux/mmu_notifier.h>
 
 #define IOMMU_READ	(1 << 0)
 #define IOMMU_WRITE	(1 << 1)
@@ -113,10 +114,15 @@ struct io_mm {
 	int			pasid;
 	struct list_head	devices;
 	struct kref		kref;
+#if defined(CONFIG_MMU_NOTIFIER)
+	struct mmu_notifier	notifier;
+#endif
 	struct mm_struct	*mm;
 
 	/* Release callback for this mm */
 	void (*release)(struct io_mm *io_mm);
+	/* For postponed release */
+	struct rcu_head		rcu;
 };
 
 enum iommu_cap {
@@ -223,6 +229,7 @@ struct page_response_msg {
  * @mm_attach: attach io_mm to a device. Install PASID entry if necessary
  * @mm_detach: detach io_mm from a device. Remove PASID entry and
  *             flush associated TLB entries.
+ * @mm_invalidate: Invalidate a range of mappings for an mm
  * @map: map a physically contiguous memory region to an iommu domain
  * @unmap: unmap a physically contiguous memory region from an iommu domain
  * @map_sg: map a scatter-gather list of physically contiguous memory chunks
@@ -267,6 +274,9 @@ struct iommu_ops {
 			 struct io_mm *io_mm, bool attach_domain);
 	void (*mm_detach)(struct iommu_domain *domain, struct device *dev,
 			  struct io_mm *io_mm, bool detach_domain);
+	void (*mm_invalidate)(struct iommu_domain *domain, struct device *dev,
+			      struct io_mm *io_mm, unsigned long vaddr,
+			      size_t size);
 	int (*map)(struct iommu_domain *domain, unsigned long iova,
 		   phys_addr_t paddr, size_t size, int prot);
 	size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
-- 
2.15.1

