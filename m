Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D75FECE566
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 17:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A7B21531
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 17:25:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5A7B21531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733097AbeITXJh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:09:37 -0400
Received: from foss.arm.com ([217.140.101.70]:50192 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730955AbeITXJh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Sep 2018 19:09:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 772A21596;
        Thu, 20 Sep 2018 10:25:06 -0700 (PDT)
Received: from ostrya.Emea.Arm.com (ostrya.emea.arm.com [10.4.12.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C42643F557;
        Thu, 20 Sep 2018 10:25:02 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, linux-pci@vger.kernel.org, jcrouse@codeaurora.org,
        alex.williamson@redhat.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        eric.auger@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
        andrew.murray@arm.com, will.deacon@arm.com, robin.murphy@arm.com,
        ashok.raj@intel.com, baolu.lu@linux.intel.com, xuzaibo@huawei.com,
        liguozhu@hisilicon.com, okaya@codeaurora.org, bharatku@xilinx.com,
        ilias.apalodimas@linaro.org, shunyong.yang@hxt-semitech.com
Subject: [PATCH v3 05/10] iommu/sva: Track mm changes with an MMU notifier
Date:   Thu, 20 Sep 2018 18:00:41 +0100
Message-Id: <20180920170046.20154-6-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When creating an io_mm structure, register an MMU notifier that informs
us when the virtual address space changes and disappears.

Add a new operation to the IOMMU driver, mm_invalidate, called when a
range of addresses is unmapped to let the IOMMU driver send ATC
invalidations. mm_invalidate cannot sleep.

Adding the notifier complicates io_mm release. In one case device
drivers free the io_mm explicitly by calling unbind (or detaching the
device from its domain). In the other case the process could crash
before unbind, in which case the release notifier has to do all the
work.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
v2->v3: Add MMU_INVALIDATE_DOES_NOT_BLOCK flag to MMU notifier

In v2 Christian pointed out that letting mm_exit() linger for too long
(some devices could need minutes to flush a PASID context) might force
the OOM killer to kill additional tasks, for example if the victim has
mlocked all its memory, which the reaper thread cannot clean up.

If this turns out to be problematic to users, we might need to add some
complexity in IOMMU drivers in order to disable PASIDs and return to
exit_mmap() while DMA is still running. While invasive on the IOMMU
side, such change might not require modification of device drivers or
the API, since iommu_notifier_release() could simply schedule a call to
their mm_exit() instead of calling it synchronously. So we can tune this
behavior in a later series.

Note that some steps cannot be skipped: the ATC invalidation, which may
take up to a minute according to the PCI spec, must be done from the MMU
notifier context. The PCI stop PASID mechanism is an implicit ATC
invalidation, but if we postpone it then we'll have to perform an
explicit one.
---
 drivers/iommu/Kconfig     |   1 +
 drivers/iommu/iommu-sva.c | 246 +++++++++++++++++++++++++++++++++++---
 include/linux/iommu.h     |  10 ++
 3 files changed, 240 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 884580401919..88d6c68284f3 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -98,6 +98,7 @@ config IOMMU_DMA
 config IOMMU_SVA
 	bool
 	select IOMMU_API
+	select MMU_NOTIFIER
 
 config FSL_PAMU
 	bool "Freescale IOMMU support"
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 08da479dad68..5ff8967cb213 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -7,6 +7,7 @@
 
 #include <linux/idr.h>
 #include <linux/iommu.h>
+#include <linux/mmu_notifier.h>
 #include <linux/sched/mm.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -107,6 +108,9 @@ struct iommu_bond {
 	struct list_head	mm_head;
 	struct list_head	dev_head;
 	struct list_head	domain_head;
+	refcount_t		refs;
+	struct wait_queue_head	mm_exit_wq;
+	bool			mm_exit_active;
 
 	void			*drvdata;
 };
@@ -125,6 +129,8 @@ static DEFINE_IDR(iommu_pasid_idr);
  */
 static DEFINE_SPINLOCK(iommu_sva_lock);
 
+static struct mmu_notifier_ops iommu_mmu_notifier;
+
 static struct io_mm *
 io_mm_alloc(struct iommu_domain *domain, struct device *dev,
 	    struct mm_struct *mm, unsigned long flags)
@@ -152,6 +158,7 @@ io_mm_alloc(struct iommu_domain *domain, struct device *dev,
 
 	io_mm->flags		= flags;
 	io_mm->mm		= mm;
+	io_mm->notifier.ops	= &iommu_mmu_notifier;
 	io_mm->release		= domain->ops->mm_free;
 	INIT_LIST_HEAD(&io_mm->devices);
 	/* Leave kref as zero until the io_mm is fully initialized */
@@ -169,8 +176,29 @@ io_mm_alloc(struct iommu_domain *domain, struct device *dev,
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
@@ -182,9 +210,13 @@ io_mm_alloc(struct iommu_domain *domain, struct device *dev,
 	return ERR_PTR(ret);
 }
 
-static void io_mm_free(struct io_mm *io_mm)
+static void io_mm_free(struct rcu_head *rcu)
 {
-	struct mm_struct *mm = io_mm->mm;
+	struct io_mm *io_mm;
+	struct mm_struct *mm;
+
+	io_mm = container_of(rcu, struct io_mm, rcu);
+	mm = io_mm->mm;
 
 	io_mm->release(io_mm);
 	mmdrop(mm);
@@ -197,10 +229,24 @@ static void io_mm_release(struct kref *kref)
 	io_mm = container_of(kref, struct io_mm, kref);
 	WARN_ON(!list_empty(&io_mm->devices));
 
-	/* The PASID can now be reallocated for another mm... */
 	idr_remove(&iommu_pasid_idr, io_mm->pasid);
-	/* ... but this mm is freed after a grace period (TODO) */
-	io_mm_free(io_mm);
+
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
@@ -209,8 +255,14 @@ static void io_mm_release(struct kref *kref)
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
@@ -236,7 +288,8 @@ static int io_mm_attach(struct iommu_domain *domain, struct device *dev,
 	struct iommu_bond *bond, *tmp;
 	struct iommu_sva_param *param = dev->iommu_param->sva_param;
 
-	if (!domain->ops->mm_attach || !domain->ops->mm_detach)
+	if (!domain->ops->mm_attach || !domain->ops->mm_detach ||
+	    !domain->ops->mm_invalidate)
 		return -ENODEV;
 
 	if (pasid > param->max_pasid || pasid < param->min_pasid)
@@ -250,6 +303,8 @@ static int io_mm_attach(struct iommu_domain *domain, struct device *dev,
 	bond->io_mm		= io_mm;
 	bond->dev		= dev;
 	bond->drvdata		= drvdata;
+	refcount_set(&bond->refs, 1);
+	init_waitqueue_head(&bond->mm_exit_wq);
 
 	spin_lock(&iommu_sva_lock);
 	/*
@@ -278,12 +333,37 @@ static int io_mm_attach(struct iommu_domain *domain, struct device *dev,
 	return ret;
 }
 
-static void io_mm_detach_locked(struct iommu_bond *bond)
+static void io_mm_detach_locked(struct iommu_bond *bond, bool wait)
 {
 	struct iommu_bond *tmp;
 	bool detach_domain = true;
 	struct iommu_domain *domain = bond->domain;
 
+	if (wait) {
+		bool do_detach = true;
+		/*
+		 * If we're unbind() then we're deleting the bond no matter
+		 * what. Tell the mm_exit thread that we're cleaning up, and
+		 * wait until it finishes using the bond.
+		 *
+		 * refs is guaranteed to be one or more, otherwise it would
+		 * already have been removed from the list. Check if someone is
+		 * already waiting, in which case we wait but do not free.
+		 */
+		if (refcount_read(&bond->refs) > 1)
+			do_detach = false;
+
+		refcount_inc(&bond->refs);
+		wait_event_lock_irq(bond->mm_exit_wq, !bond->mm_exit_active,
+				    iommu_sva_lock);
+		if (!do_detach)
+			return;
+
+	} else if (!refcount_dec_and_test(&bond->refs)) {
+		/* unbind() is waiting to free the bond */
+		return;
+	}
+
 	list_for_each_entry(tmp, &domain->mm_list, domain_head) {
 		if (tmp->io_mm == bond->io_mm && tmp->dev != bond->dev) {
 			detach_domain = false;
@@ -301,6 +381,130 @@ static void io_mm_detach_locked(struct iommu_bond *bond)
 	kfree(bond);
 }
 
+static int iommu_signal_mm_exit(struct iommu_bond *bond)
+{
+	struct device *dev = bond->dev;
+	struct io_mm *io_mm = bond->io_mm;
+	struct iommu_sva_param *param = dev->iommu_param->sva_param;
+
+	/*
+	 * We can't hold the device's sva_lock. If we did and the device driver
+	 * used a global lock around io_mm, we would risk getting the following
+	 * deadlock:
+	 *
+	 *   exit_mm()                 |  Shutdown SVA
+	 *    mutex_lock(sva_lock)     |   mutex_lock(glob lock)
+	 *     param->mm_exit()        |    sva_shutdown_device()
+	 *      mutex_lock(glob lock)  |     mutex_lock(sva_lock)
+	 *
+	 * Fortunately unbind() waits for us to finish, and sva_shutdown_device
+	 * requires that any bond is removed, so we can safely access mm_exit
+	 * and drvdata without taking the sva_lock.
+	 */
+	if (!param || !param->mm_exit)
+		return 0;
+
+	return param->mm_exit(dev, io_mm->pasid, bond->drvdata);
+}
+
+/* Called when the mm exits. Can race with unbind(). */
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
+		/*
+		 * Release the lock to let the handler sleep. We need to be
+		 * careful about concurrent modifications to the list and to the
+		 * bond. Tell unbind() not to free the bond until we're done.
+		 */
+		bond->mm_exit_active = true;
+		spin_unlock(&iommu_sva_lock);
+
+		if (iommu_signal_mm_exit(bond))
+			dev_WARN(bond->dev, "possible leak of PASID %u",
+				 io_mm->pasid);
+
+		spin_lock(&iommu_sva_lock);
+		next = list_next_entry(bond, mm_head);
+
+		/* If someone is waiting, let them delete the bond now */
+		bond->mm_exit_active = false;
+		wake_up_all(&bond->mm_exit_wq);
+
+		/* Otherwise, do it ourselves */
+		io_mm_detach_locked(bond, false);
+	}
+	spin_unlock(&iommu_sva_lock);
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
+	.flags			= MMU_INVALIDATE_DOES_NOT_BLOCK,
+	.release		= iommu_notifier_release,
+	.clear_flush_young	= iommu_notifier_clear_flush_young,
+	.change_pte		= iommu_notifier_change_pte,
+	.invalidate_range	= iommu_notifier_invalidate_range,
+};
+
 int __iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, int *pasid,
 			    unsigned long flags, void *drvdata)
 {
@@ -386,15 +590,16 @@ int __iommu_sva_unbind_device(struct device *dev, int pasid)
 		goto out_unlock;
 	}
 
-	spin_lock(&iommu_sva_lock);
+	/* spin_lock_irq matches the one in wait_event_lock_irq */
+	spin_lock_irq(&iommu_sva_lock);
 	list_for_each_entry(bond, &param->mm_list, dev_head) {
 		if (bond->io_mm->pasid == pasid) {
-			io_mm_detach_locked(bond);
+			io_mm_detach_locked(bond, true);
 			ret = 0;
 			break;
 		}
 	}
-	spin_unlock(&iommu_sva_lock);
+	spin_unlock_irq(&iommu_sva_lock);
 
 out_unlock:
 	mutex_unlock(&dev->iommu_param->sva_lock);
@@ -410,10 +615,10 @@ static void __iommu_sva_unbind_device_all(struct device *dev)
 	if (!param)
 		return;
 
-	spin_lock(&iommu_sva_lock);
+	spin_lock_irq(&iommu_sva_lock);
 	list_for_each_entry_safe(bond, next, &param->mm_list, dev_head)
-		io_mm_detach_locked(bond);
-	spin_unlock(&iommu_sva_lock);
+		io_mm_detach_locked(bond, true);
+	spin_unlock_irq(&iommu_sva_lock);
 }
 
 /**
@@ -421,6 +626,7 @@ static void __iommu_sva_unbind_device_all(struct device *dev)
  * @dev: the device
  *
  * When detaching @dev from a domain, IOMMU drivers should use this helper.
+ * This function may sleep while waiting for bonds to be released.
  */
 void iommu_sva_unbind_device_all(struct device *dev)
 {
@@ -453,6 +659,12 @@ EXPORT_SYMBOL_GPL(iommu_sva_unbind_device_all);
  * more transaction with the PASID given as argument. The handler gets an opaque
  * pointer corresponding to the drvdata passed as argument to bind().
  *
+ * The @mm_exit handler is allowed to sleep. Be careful about the locks taken in
+ * @mm_exit, because they might lead to deadlocks if they are also held when
+ * dropping references to the mm. Consider the following call chain:
+ *   mutex_lock(A); mmput(mm) -> exit_mm() -> @mm_exit() -> mutex_lock(A)
+ * Using mmput_async() prevents this scenario.
+ *
  * The device should not be performing any DMA while this function is running,
  * otherwise the behavior is undefined.
  *
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c95ff714ea66..429f3dc37a35 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -24,6 +24,7 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/err.h>
+#include <linux/mmu_notifier.h>
 #include <linux/of.h>
 #include <uapi/linux/iommu.h>
 
@@ -110,10 +111,15 @@ struct io_mm {
 	unsigned long		flags;
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
@@ -235,6 +241,7 @@ struct iommu_sva_param {
  *             not sleep.
  * @mm_detach: detach io_mm from a device. Remove PASID entry and
  *             flush associated TLB entries if necessary. Must not sleep.
+ * @mm_invalidate: Invalidate a range of mappings for an mm
  * @map: map a physically contiguous memory region to an iommu domain
  * @unmap: unmap a physically contiguous memory region from an iommu domain
  * @flush_tlb_all: Synchronously flush all hardware TLBs for this domain
@@ -280,6 +287,9 @@ struct iommu_ops {
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
2.18.0

