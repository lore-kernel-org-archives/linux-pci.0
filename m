Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7A2ECE566
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 17:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 398D021531
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 17:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 398D021531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730955AbeITXJ5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:09:57 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50362 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbeITXJ4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Sep 2018 19:09:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFC427A9;
        Thu, 20 Sep 2018 10:25:25 -0700 (PDT)
Received: from ostrya.Emea.Arm.com (ostrya.emea.arm.com [10.4.12.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 310AF3F557;
        Thu, 20 Sep 2018 10:25:22 -0700 (PDT)
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
Subject: [RFC PATCH v3 10/10] iommu/sva: Add support for private PASIDs
Date:   Thu, 20 Sep 2018 18:00:46 +0100
Message-Id: <20180920170046.20154-11-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Provide an API for allocating PASIDs and populating them manually. To ease
cleanup and factor allocation code, reuse the io_mm structure for private
PASID. Private io_mm has a NULL mm_struct pointer, and cannot be bound to
multiple devices. The mm_alloc() IOMMU op must now check if the mm
argument is NULL, in which case it should allocate io_pgtables instead of
binding to an mm.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
Sadly this probably won't be the final thing. The API in this patch is
used like this:

        iommu_sva_alloc_pasid(dev, &io_mm) -> PASID
        iommu_sva_map(io_mm, ...)
        iommu_sva_unmap(io_mm, ...)
        iommu_sva_free_pasid(dev, io_mm)

The proposed API for auxiliary domains is in an early stage but might
replace this patch and could be used like this:

        iommu_enable_aux_domain(dev)
        d = iommu_domain_alloc()
        iommu_attach_aux(dev, d)
        iommu_aux_id(d) -> PASID
        iommu_map(d, ...)
        iommu_unmap(d, ...)
        iommu_detach_aux(dev, d)
        iommu_domain_free(d)

The advantage being that the driver doesn't have to use a special
version of map/unmap/etc.
---
 drivers/iommu/iommu-sva.c | 209 ++++++++++++++++++++++++++++++++++----
 drivers/iommu/iommu.c     |  51 ++++++----
 include/linux/iommu.h     | 112 +++++++++++++++++++-
 3 files changed, 331 insertions(+), 41 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 1588a523a214..029776f64e7d 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -15,11 +15,11 @@
 /**
  * DOC: io_mm model
  *
- * The io_mm keeps track of process address spaces shared between CPU and IOMMU.
- * The following example illustrates the relation between structures
- * iommu_domain, io_mm and iommu_bond. An iommu_bond is a link between io_mm and
- * device. A device can have multiple io_mm and an io_mm may be bound to
- * multiple devices.
+ * When used with the bind()/unbind() functions, the io_mm keeps track of
+ * process address spaces shared between CPU and IOMMU. The following example
+ * illustrates the relation between structures iommu_domain, io_mm and
+ * iommu_bond. An iommu_bond is a link between io_mm and device. A device can
+ * have multiple io_mm and an io_mm may be bound to multiple devices.
  *              ___________________________
  *             |  IOMMU domain A           |
  *             |  ________________         |
@@ -98,6 +98,12 @@
  * the first entry points to the io_pgtable pointer. In other IOMMUs the
  * io_pgtable pointer is held in the device table and PASID #0 is available to
  * the allocator.
+ *
+ * The io_mm can also represent a private IOMMU address space, which isn't
+ * shared with a process. The device driver calls iommu_sva_alloc_pasid which
+ * returns an io_mm that can be populated with the iommu_sva_map/unmap
+ * functions. The principle is the same as shared io_mm, except that a private
+ * io_mm cannot be bound to multiple devices.
  */
 
 struct iommu_bond {
@@ -131,6 +137,9 @@ static DEFINE_SPINLOCK(iommu_sva_lock);
 
 static struct mmu_notifier_ops iommu_mmu_notifier;
 
+#define io_mm_is_private(io_mm) ((io_mm) != NULL && (io_mm)->mm == NULL)
+#define io_mm_is_shared(io_mm) ((io_mm) != NULL && (io_mm)->mm != NULL)
+
 static struct io_mm *
 io_mm_alloc(struct iommu_domain *domain, struct device *dev,
 	    struct mm_struct *mm, unsigned long flags)
@@ -149,19 +158,10 @@ io_mm_alloc(struct iommu_domain *domain, struct device *dev,
 	if (!io_mm)
 		return ERR_PTR(-ENOMEM);
 
-	/*
-	 * The mm must not be freed until after the driver frees the io_mm
-	 * (which may involve unpinning the CPU ASID for instance, requiring a
-	 * valid mm struct.)
-	 */
-	mmgrab(mm);
-
 	io_mm->flags		= flags;
 	io_mm->mm		= mm;
-	io_mm->notifier.ops	= &iommu_mmu_notifier;
 	io_mm->release		= domain->ops->mm_free;
 	INIT_LIST_HEAD(&io_mm->devices);
-	/* Leave kref as zero until the io_mm is fully initialized */
 
 	idr_preload(GFP_KERNEL);
 	spin_lock(&iommu_sva_lock);
@@ -176,6 +176,32 @@ io_mm_alloc(struct iommu_domain *domain, struct device *dev,
 		goto err_free_mm;
 	}
 
+	return io_mm;
+
+err_free_mm:
+	io_mm->release(io_mm);
+	return ERR_PTR(ret);
+}
+
+static struct io_mm *
+io_mm_alloc_shared(struct iommu_domain *domain, struct device *dev,
+		   struct mm_struct *mm, unsigned long flags)
+{
+	int ret;
+	struct io_mm *io_mm;
+
+	io_mm = io_mm_alloc(domain, dev, mm, flags);
+	if (IS_ERR(io_mm))
+		return io_mm;
+
+	/*
+	 * The mm must not be freed until after the driver frees the io_mm
+	 * (which may involve unpinning the CPU ASID for instance, requiring a
+	 * valid mm struct.)
+	 */
+	mmgrab(mm);
+
+	io_mm->notifier.ops = &iommu_mmu_notifier;
 	ret = mmu_notifier_register(&io_mm->notifier, mm);
 	if (ret)
 		goto err_free_pasid;
@@ -203,7 +229,6 @@ io_mm_alloc(struct iommu_domain *domain, struct device *dev,
 	idr_remove(&iommu_pasid_idr, io_mm->pasid);
 	spin_unlock(&iommu_sva_lock);
 
-err_free_mm:
 	io_mm->release(io_mm);
 	mmdrop(mm);
 
@@ -231,6 +256,11 @@ static void io_mm_release(struct kref *kref)
 
 	idr_remove(&iommu_pasid_idr, io_mm->pasid);
 
+	if (io_mm_is_private(io_mm)) {
+		io_mm->release(io_mm);
+		return;
+	}
+
 	/*
 	 * If we're being released from mm exit, the notifier callback ->release
 	 * has already been called. Otherwise we don't need ->release, the io_mm
@@ -258,7 +288,7 @@ static int io_mm_get_locked(struct io_mm *io_mm)
 	if (io_mm && kref_get_unless_zero(&io_mm->kref)) {
 		/*
 		 * kref_get_unless_zero doesn't provide ordering for reads. This
-		 * barrier pairs with the one in io_mm_alloc.
+		 * barrier pairs with the one in io_mm_alloc_shared.
 		 */
 		smp_rmb();
 		return 1;
@@ -289,7 +319,7 @@ static int io_mm_attach(struct iommu_domain *domain, struct device *dev,
 	struct iommu_sva_param *param = dev->iommu_param->sva_param;
 
 	if (!domain->ops->mm_attach || !domain->ops->mm_detach ||
-	    !domain->ops->mm_invalidate)
+	    (io_mm_is_shared(io_mm) && !domain->ops->mm_invalidate))
 		return -ENODEV;
 
 	if (pasid > param->max_pasid || pasid < param->min_pasid)
@@ -555,7 +585,7 @@ int __iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, int *pasid
 	}
 
 	if (!io_mm) {
-		io_mm = io_mm_alloc(domain, dev, mm, flags);
+		io_mm = io_mm_alloc_shared(domain, dev, mm, flags);
 		if (IS_ERR(io_mm)) {
 			ret = PTR_ERR(io_mm);
 			goto out_unlock;
@@ -601,6 +631,9 @@ int __iommu_sva_unbind_device(struct device *dev, int pasid)
 	/* spin_lock_irq matches the one in wait_event_lock_irq */
 	spin_lock_irq(&iommu_sva_lock);
 	list_for_each_entry(bond, &param->mm_list, dev_head) {
+		if (io_mm_is_private(bond->io_mm))
+			continue;
+
 		if (bond->io_mm->pasid == pasid) {
 			io_mm_detach_locked(bond, true);
 			ret = 0;
@@ -672,6 +705,136 @@ struct mm_struct *iommu_sva_find(int pasid)
 }
 EXPORT_SYMBOL_GPL(iommu_sva_find);
 
+/*
+ * iommu_sva_alloc_pasid - Allocate a private PASID
+ *
+ * Allocate a PASID for private map/unmap operations. Create a new I/O address
+ * space for this device, that isn't bound to any process.
+ *
+ * iommu_sva_init_device must have been called first.
+ */
+int iommu_sva_alloc_pasid(struct device *dev, struct io_mm **out)
+{
+	int ret;
+	struct io_mm *io_mm;
+	struct iommu_domain *domain;
+	struct iommu_sva_param *param = dev->iommu_param->sva_param;
+
+	if (!out || !param)
+		return -EINVAL;
+
+	domain = iommu_get_domain_for_dev(dev);
+	if (!domain)
+		return -EINVAL;
+
+	io_mm = io_mm_alloc(domain, dev, NULL, 0);
+	if (IS_ERR(io_mm))
+		return PTR_ERR(io_mm);
+
+	kref_init(&io_mm->kref);
+
+	ret = io_mm_attach(domain, dev, io_mm, NULL);
+	if (ret) {
+		io_mm_put(io_mm);
+		return ret;
+	}
+
+	*out = io_mm;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);
+
+void iommu_sva_free_pasid(struct device *dev, struct io_mm *io_mm)
+{
+	struct iommu_bond *bond;
+
+	if (WARN_ON(io_mm_is_shared(io_mm)))
+		return;
+
+	spin_lock(&iommu_sva_lock);
+	list_for_each_entry(bond, &io_mm->devices, mm_head) {
+		if (bond->dev == dev) {
+			io_mm_detach_locked(bond, false);
+			break;
+		}
+	}
+	spin_unlock(&iommu_sva_lock);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_free_pasid);
+
+int iommu_sva_map(struct iommu_domain *domain, struct io_mm *io_mm,
+		  unsigned long iova, phys_addr_t paddr, size_t size, int prot)
+{
+	if (WARN_ON(io_mm_is_shared(io_mm)))
+		return -ENODEV;
+
+	return __iommu_map(domain, io_mm, iova, paddr, size, prot);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_map);
+
+size_t iommu_sva_map_sg(struct iommu_domain *domain, struct io_mm *io_mm,
+			unsigned long iova, struct scatterlist *sg,
+			unsigned int nents, int prot)
+{
+	if (WARN_ON(io_mm_is_shared(io_mm)))
+		return -ENODEV;
+
+	return __iommu_map_sg(domain, io_mm, iova, sg, nents, prot);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_map_sg);
+
+size_t iommu_sva_unmap(struct iommu_domain *domain, struct io_mm *io_mm,
+		       unsigned long iova, size_t size)
+{
+	if (WARN_ON(io_mm_is_shared(io_mm)))
+		return 0;
+
+	return __iommu_unmap(domain, io_mm, iova, size, true);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_unmap);
+
+size_t iommu_sva_unmap_fast(struct iommu_domain *domain, struct io_mm *io_mm,
+			    unsigned long iova, size_t size)
+{
+	if (WARN_ON(io_mm_is_shared(io_mm)))
+		return 0;
+
+	return __iommu_unmap(domain, io_mm, iova, size, false);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_unmap_fast);
+
+phys_addr_t iommu_sva_iova_to_phys(struct iommu_domain *domain,
+				   struct io_mm *io_mm, dma_addr_t iova)
+{
+	if (!io_mm)
+		return iommu_iova_to_phys(domain, iova);
+
+	if (WARN_ON(io_mm_is_shared(io_mm)))
+		return 0;
+
+	if (unlikely(domain->ops->sva_iova_to_phys == NULL))
+		return 0;
+
+	return domain->ops->sva_iova_to_phys(domain, io_mm, iova);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_iova_to_phys);
+
+void iommu_sva_tlb_range_add(struct iommu_domain *domain, struct io_mm *io_mm,
+			     unsigned long iova, size_t size)
+{
+	if (!io_mm) {
+		iommu_tlb_range_add(domain, iova, size);
+		return;
+	}
+
+	if (WARN_ON(io_mm_is_shared(io_mm)))
+		return;
+
+	if (domain->ops->sva_iotlb_range_add != NULL)
+		domain->ops->sva_iotlb_range_add(domain, io_mm, iova, size);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_tlb_range_add);
+
 /**
  * iommu_sva_init_device() - Initialize Shared Virtual Addressing for a device
  * @dev: the device
@@ -693,10 +856,12 @@ EXPORT_SYMBOL_GPL(iommu_sva_find);
  * If the device should support recoverable I/O Page Faults (e.g. PCI PRI), the
  * IOMMU_SVA_FEAT_IOPF feature must be requested.
  *
- * @mm_exit is called when an address space bound to the device is about to be
- * torn down by exit_mmap. After @mm_exit returns, the device must not issue any
- * more transaction with the PASID given as argument. The handler gets an opaque
- * pointer corresponding to the drvdata passed as argument to bind().
+ * If the driver intends to share process address spaces with the device, it
+ * should pass a valid @mm_exit handler. @mm_exit is called when an address
+ * space bound to the device is about to be torn down by exit_mmap. After
+ * @mm_exit returns, the device must not issue any more transaction with the
+ * PASID given as argument. The handler gets an opaque pointer corresponding to
+ * the drvdata passed as argument to bind().
  *
  * The @mm_exit handler is allowed to sleep. Be careful about the locks taken in
  * @mm_exit, because they might lead to deadlocks if they are also held when
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b493f5c4fe64..dd75c0a19c3a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1854,8 +1854,8 @@ static size_t iommu_pgsize(struct iommu_domain *domain,
 	return pgsize;
 }
 
-int iommu_map(struct iommu_domain *domain, unsigned long iova,
-	      phys_addr_t paddr, size_t size, int prot)
+int __iommu_map(struct iommu_domain *domain, struct io_mm *io_mm,
+		unsigned long iova, phys_addr_t paddr, size_t size, int prot)
 {
 	unsigned long orig_iova = iova;
 	unsigned int min_pagesz;
@@ -1863,7 +1863,8 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
 	phys_addr_t orig_paddr = paddr;
 	int ret = 0;
 
-	if (unlikely(domain->ops->map == NULL ||
+	if (unlikely((!io_mm && domain->ops->map == NULL) ||
+		     (io_mm && domain->ops->sva_map == NULL) ||
 		     domain->pgsize_bitmap == 0UL))
 		return -ENODEV;
 
@@ -1892,7 +1893,12 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		pr_debug("mapping: iova 0x%lx pa %pa pgsize 0x%zx\n",
 			 iova, &paddr, pgsize);
 
-		ret = domain->ops->map(domain, iova, paddr, pgsize, prot);
+		if (io_mm)
+			ret = domain->ops->sva_map(domain, io_mm, iova, paddr,
+						   pgsize, prot);
+		else
+			ret = domain->ops->map(domain, iova, paddr, pgsize,
+					       prot);
 		if (ret)
 			break;
 
@@ -1903,24 +1909,30 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
 
 	/* unroll mapping in case something went wrong */
 	if (ret)
-		iommu_unmap(domain, orig_iova, orig_size - size);
+		__iommu_unmap(domain, io_mm, orig_iova, orig_size - size, true);
 	else
 		trace_map(orig_iova, orig_paddr, orig_size);
 
 	return ret;
 }
+
+int iommu_map(struct iommu_domain *domain, unsigned long iova,
+	      phys_addr_t paddr, size_t size, int prot)
+{
+	return __iommu_map(domain, NULL, iova, paddr, size, prot);
+}
 EXPORT_SYMBOL_GPL(iommu_map);
 
-static size_t __iommu_unmap(struct iommu_domain *domain,
-			    unsigned long iova, size_t size,
-			    bool sync)
+size_t __iommu_unmap(struct iommu_domain *domain, struct io_mm *io_mm,
+		     unsigned long iova, size_t size, bool sync)
 {
 	const struct iommu_ops *ops = domain->ops;
 	size_t unmapped_page, unmapped = 0;
 	unsigned long orig_iova = iova;
 	unsigned int min_pagesz;
 
-	if (unlikely(ops->unmap == NULL ||
+	if (unlikely((!io_mm && ops->unmap == NULL) ||
+		     (io_mm && ops->sva_unmap == NULL) ||
 		     domain->pgsize_bitmap == 0UL))
 		return 0;
 
@@ -1950,7 +1962,11 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
 	while (unmapped < size) {
 		size_t pgsize = iommu_pgsize(domain, iova, size - unmapped);
 
-		unmapped_page = ops->unmap(domain, iova, pgsize);
+		if (io_mm)
+			unmapped_page = ops->sva_unmap(domain, io_mm, iova,
+						       pgsize);
+		else
+			unmapped_page = ops->unmap(domain, iova, pgsize);
 		if (!unmapped_page)
 			break;
 
@@ -1974,19 +1990,20 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
 size_t iommu_unmap(struct iommu_domain *domain,
 		   unsigned long iova, size_t size)
 {
-	return __iommu_unmap(domain, iova, size, true);
+	return __iommu_unmap(domain, NULL, iova, size, true);
 }
 EXPORT_SYMBOL_GPL(iommu_unmap);
 
 size_t iommu_unmap_fast(struct iommu_domain *domain,
 			unsigned long iova, size_t size)
 {
-	return __iommu_unmap(domain, iova, size, false);
+	return __iommu_unmap(domain, NULL, iova, size, false);
 }
 EXPORT_SYMBOL_GPL(iommu_unmap_fast);
 
-size_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
-		    struct scatterlist *sg, unsigned int nents, int prot)
+size_t __iommu_map_sg(struct iommu_domain *domain, struct io_mm *io_mm,
+		      unsigned long iova, struct scatterlist *sg,
+		      unsigned int nents, int prot)
 {
 	struct scatterlist *s;
 	size_t mapped = 0;
@@ -2010,7 +2027,7 @@ size_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 		if (!IS_ALIGNED(s->offset, min_pagesz))
 			goto out_err;
 
-		ret = iommu_map(domain, iova + mapped, phys, s->length, prot);
+		ret = __iommu_map(domain, io_mm, iova + mapped, phys, s->length, prot);
 		if (ret)
 			goto out_err;
 
@@ -2021,12 +2038,12 @@ size_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 
 out_err:
 	/* undo mappings already done */
-	iommu_unmap(domain, iova, mapped);
+	__iommu_unmap(domain, io_mm, iova, mapped, true);
 
 	return 0;
 
 }
-EXPORT_SYMBOL_GPL(iommu_map_sg);
+EXPORT_SYMBOL_GPL(__iommu_map_sg);
 
 int iommu_domain_window_enable(struct iommu_domain *domain, u32 wnd_nr,
 			       phys_addr_t paddr, u64 size, int prot)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ad2b18883ae2..0674fd983f81 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -248,11 +248,15 @@ struct iommu_sva_param {
  * @mm_invalidate: Invalidate a range of mappings for an mm
  * @map: map a physically contiguous memory region to an iommu domain
  * @unmap: unmap a physically contiguous memory region from an iommu domain
+ * @sva_map: map a physically contiguous memory region to an address space
+ * @sva_unmap: unmap a physically contiguous memory region from an address space
  * @flush_tlb_all: Synchronously flush all hardware TLBs for this domain
  * @tlb_range_add: Add a given iova range to the flush queue for this domain
+ * @sva_iotlb_range_add: Add a given iova range to the flush queue for this mm
  * @tlb_sync: Flush all queued ranges from the hardware TLBs and empty flush
  *            queue
  * @iova_to_phys: translate iova to physical address
+ * @sva_iova_to_phys: translate iova to physical address
  * @add_device: add device to iommu grouping
  * @remove_device: remove device from iommu grouping
  * @device_group: find iommu group for a particular device
@@ -298,11 +302,21 @@ struct iommu_ops {
 		   phys_addr_t paddr, size_t size, int prot);
 	size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
 		     size_t size);
+	int (*sva_map)(struct iommu_domain *domain, struct io_mm *io_mm,
+		       unsigned long iova, phys_addr_t paddr, size_t size,
+		       int prot);
+	size_t (*sva_unmap)(struct iommu_domain *domain, struct io_mm *io_mm,
+			    unsigned long iova, size_t size);
 	void (*flush_iotlb_all)(struct iommu_domain *domain);
 	void (*iotlb_range_add)(struct iommu_domain *domain,
 				unsigned long iova, size_t size);
+	void (*sva_iotlb_range_add)(struct iommu_domain *domain,
+				    struct io_mm *io_mm, unsigned long iova,
+				    size_t size);
 	void (*iotlb_sync)(struct iommu_domain *domain);
 	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, dma_addr_t iova);
+	phys_addr_t (*sva_iova_to_phys)(struct iommu_domain *domain,
+					struct io_mm *io_mm, dma_addr_t iova);
 	int (*add_device)(struct device *dev);
 	void (*remove_device)(struct device *dev);
 	struct iommu_group *(*device_group)(struct device *dev);
@@ -525,14 +539,27 @@ extern int iommu_sva_invalidate(struct iommu_domain *domain,
 		struct device *dev, struct tlb_invalidate_info *inv_info);
 
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
+extern int __iommu_map(struct iommu_domain *domain, struct io_mm *io_mm,
+		       unsigned long iova, phys_addr_t paddr, size_t size,
+		       int prot);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		     phys_addr_t paddr, size_t size, int prot);
+extern size_t __iommu_unmap(struct iommu_domain *domain, struct io_mm *io_mm,
+			    unsigned long iova, size_t size, bool sync);
 extern size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 			  size_t size);
 extern size_t iommu_unmap_fast(struct iommu_domain *domain,
 			       unsigned long iova, size_t size);
-extern size_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
-			   struct scatterlist *sg,unsigned int nents, int prot);
+extern size_t __iommu_map_sg(struct iommu_domain *domain, struct io_mm *io_mm,
+			     unsigned long iova, struct scatterlist *sg,
+			     unsigned int nents, int prot);
+static inline size_t iommu_map_sg(struct iommu_domain *domain,
+				  unsigned long iova,
+				  struct scatterlist *sg, unsigned int nents,
+				  int prot)
+{
+	return __iommu_map_sg(domain, NULL, iova, sg, nents, prot);
+}
 extern phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova);
 extern void iommu_set_fault_handler(struct iommu_domain *domain,
 			iommu_fault_handler_t handler, void *token);
@@ -693,12 +720,25 @@ static inline struct iommu_domain *iommu_get_domain_for_dev(struct device *dev)
 	return NULL;
 }
 
+static inline int __iommu_map(struct iommu_domain *domain, struct io_mm *io_mm,
+			      unsigned long iova, phys_addr_t paddr,
+			      size_t size, int prot)
+{
+	return -ENODEV;
+}
+
 static inline int iommu_map(struct iommu_domain *domain, unsigned long iova,
 			    phys_addr_t paddr, size_t size, int prot)
 {
 	return -ENODEV;
 }
 
+static inline size_t __iommu_unmap(struct iommu_domain *domain, struct io_mm *io_mm,
+				   unsigned long iova, size_t size, bool sync)
+{
+	return 0;
+}
+
 static inline size_t iommu_unmap(struct iommu_domain *domain,
 				 unsigned long iova, size_t size)
 {
@@ -1003,6 +1043,23 @@ extern int __iommu_sva_unbind_device(struct device *dev, int pasid);
 extern void iommu_sva_unbind_device_all(struct device *dev);
 extern struct mm_struct *iommu_sva_find(int pasid);
 
+int iommu_sva_alloc_pasid(struct device *dev, struct io_mm **io_mm);
+void iommu_sva_free_pasid(struct device *dev, struct io_mm *io_mm);
+
+int iommu_sva_map(struct iommu_domain *domain, struct io_mm *io_mm,
+		  unsigned long iova, phys_addr_t paddr, size_t size, int prot);
+size_t iommu_sva_map_sg(struct iommu_domain *domain, struct io_mm *io_mm,
+			unsigned long iova, struct scatterlist *sg,
+			unsigned int nents, int prot);
+size_t iommu_sva_unmap(struct iommu_domain *domain,
+		       struct io_mm *io_mm, unsigned long iova, size_t size);
+size_t iommu_sva_unmap_fast(struct iommu_domain *domain, struct io_mm *io_mm,
+			    unsigned long iova, size_t size);
+phys_addr_t iommu_sva_iova_to_phys(struct iommu_domain *domain,
+				   struct io_mm *io_mm, dma_addr_t iova);
+void iommu_sva_tlb_range_add(struct iommu_domain *domain, struct io_mm *io_mm,
+			     unsigned long iova, size_t size);
+
 #else /* CONFIG_IOMMU_SVA */
 static inline int iommu_sva_init_device(struct device *dev,
 					unsigned long features,
@@ -1037,6 +1094,57 @@ static inline struct mm_struct *iommu_sva_find(int pasid)
 {
 	return NULL;
 }
+
+static inline int iommu_sva_alloc_pasid(struct device *dev, struct io_mm **io_mm)
+{
+	return -ENODEV;
+}
+
+static inline void iommu_sva_free_pasid(struct io_mm *io_mm, struct device *dev)
+{
+}
+
+static inline int iommu_sva_map(struct iommu_domain *domain,
+				struct io_mm *io_mm, unsigned long iova,
+				phys_addr_t paddr, size_t size, int prot)
+{
+	return -EINVAL;
+}
+
+static inline size_t iommu_sva_map_sg(struct iommu_domain *domain,
+				      struct io_mm *io_mm, unsigned long iova,
+				      struct scatterlist *sg,
+				      unsigned int nents, int prot)
+{
+	return 0;
+}
+
+static inline size_t iommu_sva_unmap(struct iommu_domain *domain,
+				     struct io_mm *io_mm, unsigned long iova,
+				     size_t size)
+{
+	return 0;
+}
+
+static inline size_t iommu_sva_unmap_fast(struct iommu_domain *domain,
+					  struct io_mm *io_mm,
+					  unsigned long iova, size_t size)
+{
+	return 0;
+}
+
+static inline phys_addr_t iommu_sva_iova_to_phys(struct iommu_domain *domain,
+						 struct io_mm *io_mm,
+						 dma_addr_t iova)
+{
+	return 0;
+}
+
+static inline void iommu_sva_tlb_range_add(struct iommu_domain *domain,
+					   struct io_mm *io_mm,
+					   unsigned long iova, size_t size)
+{
+}
 #endif /* CONFIG_IOMMU_SVA */
 
 #ifdef CONFIG_IOMMU_PAGE_FAULT
-- 
2.18.0

