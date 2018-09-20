Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DD0ECE566
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 17:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3866B20673
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 17:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3866B20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbeITXJw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:09:52 -0400
Received: from foss.arm.com ([217.140.101.70]:50320 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbeITXJw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Sep 2018 19:09:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7B301596;
        Thu, 20 Sep 2018 10:25:21 -0700 (PDT)
Received: from ostrya.Emea.Arm.com (ostrya.emea.arm.com [10.4.12.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 692763F557;
        Thu, 20 Sep 2018 10:25:18 -0700 (PDT)
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
Subject: [PATCH v3 09/10] iommu/sva: Register page fault handler
Date:   Thu, 20 Sep 2018 18:00:45 +0100
Message-Id: <20180920170046.20154-10-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Let users call iommu_sva_init_device() with the IOMMU_SVA_FEAT_IOPF flag,
that enables the I/O Page Fault queue. The IOMMU driver checks is the
device supports a form of page fault, in which case they add the device to
a fault queue. If the device doesn't support page faults, the IOMMU driver
aborts iommu_sva_init_device().

The fault queue must be flushed before any io_mm is freed, to make sure
that its PASID isn't used in any fault queue, and can be reallocated.
Add iopf_queue_flush() calls in a few strategic locations.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/iommu-sva.c | 26 +++++++++++++++++++++++++-
 drivers/iommu/iommu.c     |  6 +++---
 include/linux/iommu.h     |  2 ++
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index ee86f00ee1b9..1588a523a214 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -443,6 +443,8 @@ static void iommu_notifier_release(struct mmu_notifier *mn, struct mm_struct *mm
 			dev_WARN(bond->dev, "possible leak of PASID %u",
 				 io_mm->pasid);
 
+		iopf_queue_flush_dev(bond->dev, io_mm->pasid);
+
 		spin_lock(&iommu_sva_lock);
 		next = list_next_entry(bond, mm_head);
 
@@ -590,6 +592,12 @@ int __iommu_sva_unbind_device(struct device *dev, int pasid)
 		goto out_unlock;
 	}
 
+	/*
+	 * Caller stopped the device from issuing PASIDs, now make sure they are
+	 * out of the fault queue.
+	 */
+	iopf_queue_flush_dev(dev, pasid);
+
 	/* spin_lock_irq matches the one in wait_event_lock_irq */
 	spin_lock_irq(&iommu_sva_lock);
 	list_for_each_entry(bond, &param->mm_list, dev_head) {
@@ -615,6 +623,8 @@ static void __iommu_sva_unbind_device_all(struct device *dev)
 	if (!param)
 		return;
 
+	iopf_queue_flush_dev(dev, IOMMU_PASID_INVALID);
+
 	spin_lock_irq(&iommu_sva_lock);
 	list_for_each_entry_safe(bond, next, &param->mm_list, dev_head)
 		io_mm_detach_locked(bond, true);
@@ -680,6 +690,9 @@ EXPORT_SYMBOL_GPL(iommu_sva_find);
  * overrides it. Similarly, @min_pasid overrides the lower PASID limit supported
  * by the IOMMU.
  *
+ * If the device should support recoverable I/O Page Faults (e.g. PCI PRI), the
+ * IOMMU_SVA_FEAT_IOPF feature must be requested.
+ *
  * @mm_exit is called when an address space bound to the device is about to be
  * torn down by exit_mmap. After @mm_exit returns, the device must not issue any
  * more transaction with the PASID given as argument. The handler gets an opaque
@@ -707,7 +720,7 @@ int iommu_sva_init_device(struct device *dev, unsigned long features,
 	if (!domain || !domain->ops->sva_init_device)
 		return -ENODEV;
 
-	if (features)
+	if (features & ~IOMMU_SVA_FEAT_IOPF)
 		return -EINVAL;
 
 	param = kzalloc(sizeof(*param), GFP_KERNEL);
@@ -734,10 +747,20 @@ int iommu_sva_init_device(struct device *dev, unsigned long features,
 	if (ret)
 		goto err_unlock;
 
+	if (features & IOMMU_SVA_FEAT_IOPF) {
+		ret = iommu_register_device_fault_handler(dev, iommu_queue_iopf,
+							  dev);
+		if (ret)
+			goto err_shutdown;
+	}
+
 	dev->iommu_param->sva_param = param;
 	mutex_unlock(&dev->iommu_param->sva_lock);
 	return 0;
 
+err_shutdown:
+	if (domain->ops->sva_shutdown_device)
+		domain->ops->sva_shutdown_device(dev);
 err_unlock:
 	mutex_unlock(&dev->iommu_param->sva_lock);
 	kfree(param);
@@ -766,6 +789,7 @@ void iommu_sva_shutdown_device(struct device *dev)
 		goto out_unlock;
 
 	__iommu_sva_unbind_device_all(dev);
+	iommu_unregister_device_fault_handler(dev);
 
 	if (domain->ops->sva_shutdown_device)
 		domain->ops->sva_shutdown_device(dev);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7113fe398b70..b493f5c4fe64 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2342,9 +2342,9 @@ EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
  * iommu_sva_init_device() must be called first, to initialize the required SVA
  * features. @flags must be a subset of these features.
  *
- * The caller must pin down using get_user_pages*() all mappings shared with the
- * device. mlock() isn't sufficient, as it doesn't prevent minor page faults
- * (e.g. copy-on-write).
+ * If IOMMU_SVA_FEAT_IOPF isn't requested, the caller must pin down using
+ * get_user_pages*() all mappings shared with the device. mlock() isn't
+ * sufficient, as it doesn't prevent minor page faults (e.g. copy-on-write).
  *
  * On success, 0 is returned and @pasid contains a valid ID. Otherwise, an error
  * is returned.
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b7cd00ae7358..ad2b18883ae2 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -65,6 +65,8 @@ typedef int (*iommu_mm_exit_handler_t)(struct device *dev, int pasid, void *);
 
 #define IOMMU_PASID_INVALID		(-1)
 
+#define IOMMU_SVA_FEAT_IOPF		(1 << 0)
+
 struct iommu_domain_geometry {
 	dma_addr_t aperture_start; /* First address that can be mapped    */
 	dma_addr_t aperture_end;   /* Last address that can be mapped     */
-- 
2.18.0

