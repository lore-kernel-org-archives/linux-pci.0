Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481A6C433F4
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 17:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F059D21523
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 17:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F059D21523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733144AbeITXJ3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:09:29 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50110 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732761AbeITXJ3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Sep 2018 19:09:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8094F15AD;
        Thu, 20 Sep 2018 10:24:58 -0700 (PDT)
Received: from ostrya.Emea.Arm.com (ostrya.emea.arm.com [10.4.12.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9B6BA3F73B;
        Thu, 20 Sep 2018 10:24:54 -0700 (PDT)
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
Subject: [PATCH v3 03/10] iommu/sva: Manage process address spaces
Date:   Thu, 20 Sep 2018 18:00:39 +0100
Message-Id: <20180920170046.20154-4-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Allocate IOMMU mm structures and bind them to devices. Four operations are
added to IOMMU drivers:

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

mm_attach and mm_detach operations are serialized with a spinlock. When
trying to optimize this code, we should at least prevent concurrent
attach()/detach() on the same domain (so multi-level PASID table code can
allocate tables lazily). mm_alloc() can sleep, but mm_free must not
(because we'll have to call it from call_srcu later on).

At the moment we use an IDR for allocating PASIDs and retrieving contexts.
We also use a single spinlock. These can be refined and optimized later (a
custom allocator will be needed for top-down PASID allocation).

Keeping track of address spaces requires the use of MMU notifiers.
Handling process exit with regard to unbind() is tricky, so it is left for
another patch and we explicitly fail mm_alloc() for the moment.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
v2->v3: use sva_lock, comment updates
---
 drivers/iommu/iommu-sva.c | 397 +++++++++++++++++++++++++++++++++++++-
 drivers/iommu/iommu.c     |   1 +
 include/linux/iommu.h     |  29 +++
 3 files changed, 424 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index d60d4f0bb89e..a486bc947335 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -5,25 +5,415 @@
  * Copyright (C) 2018 ARM Ltd.
  */
 
+#include <linux/idr.h>
 #include <linux/iommu.h>
+#include <linux/sched/mm.h>
 #include <linux/slab.h>
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
+ * In some IOMMUs, one entry (typically the first one) of the PASID table can be
+ * used to hold non-PASID translations. In this case PASID #0 is reserved and
+ * the first entry points to the io_pgtable pointer. In other IOMMUs the
+ * io_pgtable pointer is held in the device table and PASID #0 is available to
+ * the allocator.
+ */
+
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
+	    struct mm_struct *mm, unsigned long flags)
+{
+	int ret;
+	int pasid;
+	struct io_mm *io_mm;
+	struct iommu_sva_param *param = dev->iommu_param->sva_param;
+
+	if (!domain->ops->mm_alloc || !domain->ops->mm_free)
+		return ERR_PTR(-ENODEV);
+
+	io_mm = domain->ops->mm_alloc(domain, mm, flags);
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
+	io_mm->flags		= flags;
+	io_mm->mm		= mm;
+	io_mm->release		= domain->ops->mm_free;
+	INIT_LIST_HEAD(&io_mm->devices);
+	/* Leave kref as zero until the io_mm is fully initialized */
+
+	idr_preload(GFP_KERNEL);
+	spin_lock(&iommu_sva_lock);
+	pasid = idr_alloc(&iommu_pasid_idr, io_mm, param->min_pasid,
+			  param->max_pasid + 1, GFP_ATOMIC);
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
+	io_mm->release(io_mm);
+	mmdrop(mm);
+
+	return ERR_PTR(ret);
+}
+
+static void io_mm_free(struct io_mm *io_mm)
+{
+	struct mm_struct *mm = io_mm->mm;
+
+	io_mm->release(io_mm);
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
+	/* The PASID can now be reallocated for another mm... */
+	idr_remove(&iommu_pasid_idr, io_mm->pasid);
+	/* ... but this mm is freed after a grace period (TODO) */
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
+	struct iommu_sva_param *param = dev->iommu_param->sva_param;
+
+	if (!domain->ops->mm_attach || !domain->ops->mm_detach)
+		return -ENODEV;
+
+	if (pasid > param->max_pasid || pasid < param->min_pasid)
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
+		goto out_unlock;
+	}
+
+	list_add(&bond->mm_head, &io_mm->devices);
+	list_add(&bond->domain_head, &domain->mm_list);
+	list_add(&bond->dev_head, &param->mm_list);
+
+out_unlock:
+	spin_unlock(&iommu_sva_lock);
+	return ret;
+}
+
+static void io_mm_detach_locked(struct iommu_bond *bond)
+{
+	struct iommu_bond *tmp;
+	bool detach_domain = true;
+	struct iommu_domain *domain = bond->domain;
+
+	list_for_each_entry(tmp, &domain->mm_list, domain_head) {
+		if (tmp->io_mm == bond->io_mm && tmp->dev != bond->dev) {
+			detach_domain = false;
+			break;
+		}
+	}
+
+	list_del(&bond->mm_head);
+	list_del(&bond->domain_head);
+	list_del(&bond->dev_head);
+
+	domain->ops->mm_detach(domain, bond->dev, bond->io_mm, detach_domain);
+
+	io_mm_put_locked(bond->io_mm);
+	kfree(bond);
+}
 
 int __iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, int *pasid,
 			    unsigned long flags, void *drvdata)
 {
-	return -ENOSYS; /* TODO */
+	int i;
+	int ret = 0;
+	struct iommu_bond *bond;
+	struct io_mm *io_mm = NULL;
+	struct iommu_domain *domain;
+	struct iommu_sva_param *param;
+
+	domain = iommu_get_domain_for_dev(dev);
+	if (!domain)
+		return -EINVAL;
+
+	mutex_lock(&dev->iommu_param->sva_lock);
+	param = dev->iommu_param->sva_param;
+	if (!param || (flags & ~param->features)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	/* If an io_mm already exists, use it */
+	spin_lock(&iommu_sva_lock);
+	idr_for_each_entry(&iommu_pasid_idr, io_mm, i) {
+		if (io_mm->mm == mm && io_mm_get_locked(io_mm)) {
+			/* ... Unless it's already bound to this device */
+			list_for_each_entry(bond, &io_mm->devices, mm_head) {
+				if (bond->dev == dev) {
+					ret = -EEXIST;
+					io_mm_put_locked(io_mm);
+					break;
+				}
+			}
+			break;
+		}
+	}
+	spin_unlock(&iommu_sva_lock);
+	if (ret)
+		goto out_unlock;
+
+	/* Require identical features within an io_mm for now */
+	if (io_mm && (flags != io_mm->flags)) {
+		io_mm_put(io_mm);
+		ret = -EDOM;
+		goto out_unlock;
+	}
+
+	if (!io_mm) {
+		io_mm = io_mm_alloc(domain, dev, mm, flags);
+		if (IS_ERR(io_mm)) {
+			ret = PTR_ERR(io_mm);
+			goto out_unlock;
+		}
+	}
+
+	ret = io_mm_attach(domain, dev, io_mm, drvdata);
+	if (ret)
+		io_mm_put(io_mm);
+	else
+		*pasid = io_mm->pasid;
+
+out_unlock:
+	mutex_unlock(&dev->iommu_param->sva_lock);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(__iommu_sva_bind_device);
 
 int __iommu_sva_unbind_device(struct device *dev, int pasid)
 {
-	return -ENOSYS; /* TODO */
+	int ret = -ESRCH;
+	struct iommu_domain *domain;
+	struct iommu_bond *bond = NULL;
+	struct iommu_sva_param *param;
+
+	domain = iommu_get_domain_for_dev(dev);
+	if (!domain)
+		return -EINVAL;
+
+	mutex_lock(&dev->iommu_param->sva_lock);
+	param = dev->iommu_param->sva_param;
+	if (!param) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	spin_lock(&iommu_sva_lock);
+	list_for_each_entry(bond, &param->mm_list, dev_head) {
+		if (bond->io_mm->pasid == pasid) {
+			io_mm_detach_locked(bond);
+			ret = 0;
+			break;
+		}
+	}
+	spin_unlock(&iommu_sva_lock);
+
+out_unlock:
+	mutex_unlock(&dev->iommu_param->sva_lock);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(__iommu_sva_unbind_device);
 
 static void __iommu_sva_unbind_device_all(struct device *dev)
 {
-	/* TODO */
+	struct iommu_sva_param *param = dev->iommu_param->sva_param;
+	struct iommu_bond *bond, *next;
+
+	if (!param)
+		return;
+
+	spin_lock(&iommu_sva_lock);
+	list_for_each_entry_safe(bond, next, &param->mm_list, dev_head)
+		io_mm_detach_locked(bond);
+	spin_unlock(&iommu_sva_lock);
 }
 
 /**
@@ -82,6 +472,7 @@ int iommu_sva_init_device(struct device *dev, unsigned long features,
 	param->features		= features;
 	param->min_pasid	= min_pasid;
 	param->max_pasid	= max_pasid;
+	INIT_LIST_HEAD(&param->mm_list);
 
 	mutex_lock(&dev->iommu_param->sva_lock);
 	if (dev->iommu_param->sva_param) {
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index aba3bf15d46c..7113fe398b70 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1525,6 +1525,7 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
 	domain->type = type;
 	/* Assume all sizes by default; the driver may override this later */
 	domain->pgsize_bitmap  = bus->iommu_ops->pgsize_bitmap;
+	INIT_LIST_HEAD(&domain->mm_list);
 
 	return domain;
 }
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 9c49877e37a5..6a3ced6a5aa1 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -99,6 +99,20 @@ struct iommu_domain {
 	void *handler_token;
 	struct iommu_domain_geometry geometry;
 	void *iova_cookie;
+
+	struct list_head mm_list;
+};
+
+struct io_mm {
+	int			pasid;
+	/* IOMMU_SVA_FEAT_* */
+	unsigned long		flags;
+	struct list_head	devices;
+	struct kref		kref;
+	struct mm_struct	*mm;
+
+	/* Release callback for this mm */
+	void (*release)(struct io_mm *io_mm);
 };
 
 enum iommu_cap {
@@ -201,6 +215,7 @@ struct iommu_sva_param {
 	unsigned long features;
 	unsigned int min_pasid;
 	unsigned int max_pasid;
+	struct list_head mm_list;
 };
 
 /**
@@ -212,6 +227,12 @@ struct iommu_sva_param {
  * @detach_dev: detach device from an iommu domain
  * @sva_init_device: initialize Shared Virtual Addressing for a device
  * @sva_shutdown_device: shutdown Shared Virtual Addressing for a device
+ * @mm_alloc: allocate io_mm
+ * @mm_free: free io_mm
+ * @mm_attach: attach io_mm to a device. Install PASID entry if necessary. Must
+ *             not sleep.
+ * @mm_detach: detach io_mm from a device. Remove PASID entry and
+ *             flush associated TLB entries if necessary. Must not sleep.
  * @map: map a physically contiguous memory region to an iommu domain
  * @unmap: unmap a physically contiguous memory region from an iommu domain
  * @flush_tlb_all: Synchronously flush all hardware TLBs for this domain
@@ -249,6 +270,14 @@ struct iommu_ops {
 	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
 	int (*sva_init_device)(struct device *dev, struct iommu_sva_param *param);
 	void (*sva_shutdown_device)(struct device *dev);
+	struct io_mm *(*mm_alloc)(struct iommu_domain *domain,
+				  struct mm_struct *mm,
+				  unsigned long flags);
+	void (*mm_free)(struct io_mm *io_mm);
+	int (*mm_attach)(struct iommu_domain *domain, struct device *dev,
+			 struct io_mm *io_mm, bool attach_domain);
+	void (*mm_detach)(struct iommu_domain *domain, struct device *dev,
+			  struct io_mm *io_mm, bool detach_domain);
 	int (*map)(struct iommu_domain *domain, unsigned long iova,
 		   phys_addr_t paddr, size_t size, int prot);
 	size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
-- 
2.18.0

