Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C667DECE566
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 17:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900B320673
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 17:25:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 900B320673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbeITXJt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:09:49 -0400
Received: from foss.arm.com ([217.140.101.70]:50298 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbeITXJt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Sep 2018 19:09:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BB7115BE;
        Thu, 20 Sep 2018 10:25:18 -0700 (PDT)
Received: from ostrya.Emea.Arm.com (ostrya.emea.arm.com [10.4.12.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 844CC3F557;
        Thu, 20 Sep 2018 10:25:14 -0700 (PDT)
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
Subject: [PATCH v3 08/10] iommu/iopf: Handle mm faults
Date:   Thu, 20 Sep 2018 18:00:44 +0100
Message-Id: <20180920170046.20154-9-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When a recoverable page fault is handled by the fault workqueue, find the
associated mm and call handle_mm_fault.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/io-pgfault.c | 86 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index 29aa8c6ba459..f6d9f40b879b 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -7,6 +7,7 @@
 
 #include <linux/iommu.h>
 #include <linux/list.h>
+#include <linux/sched/mm.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 
@@ -65,8 +66,65 @@ static int iopf_complete(struct device *dev, struct iommu_fault_event *evt,
 static enum page_response_code
 iopf_handle_single(struct iopf_fault *fault)
 {
-	/* TODO */
-	return -ENODEV;
+	vm_fault_t ret;
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;
+	unsigned int access_flags = 0;
+	unsigned int fault_flags = FAULT_FLAG_REMOTE;
+	struct iommu_fault_event *evt = &fault->evt;
+	enum page_response_code status = IOMMU_PAGE_RESP_INVALID;
+
+	if (!evt->pasid_valid)
+		return status;
+
+	mm = iommu_sva_find(evt->pasid);
+	if (!mm)
+		return status;
+
+	down_read(&mm->mmap_sem);
+
+	vma = find_extend_vma(mm, evt->addr);
+	if (!vma)
+		/* Unmapped area */
+		goto out_put_mm;
+
+	if (evt->prot & IOMMU_FAULT_READ)
+		access_flags |= VM_READ;
+
+	if (evt->prot & IOMMU_FAULT_WRITE) {
+		access_flags |= VM_WRITE;
+		fault_flags |= FAULT_FLAG_WRITE;
+	}
+
+	if (evt->prot & IOMMU_FAULT_EXEC) {
+		access_flags |= VM_EXEC;
+		fault_flags |= FAULT_FLAG_INSTRUCTION;
+	}
+
+	if (!(evt->prot & IOMMU_FAULT_PRIV))
+		fault_flags |= FAULT_FLAG_USER;
+
+	if (access_flags & ~vma->vm_flags)
+		/* Access fault */
+		goto out_put_mm;
+
+	ret = handle_mm_fault(vma, evt->addr, fault_flags);
+	status = ret & VM_FAULT_ERROR ? IOMMU_PAGE_RESP_INVALID :
+		IOMMU_PAGE_RESP_SUCCESS;
+
+out_put_mm:
+	up_read(&mm->mmap_sem);
+
+	/*
+	 * If the process exits while we're handling the fault on its mm, we
+	 * can't do mmput(). exit_mmap() would release the MMU notifier, calling
+	 * iommu_notifier_release(), which has to flush the fault queue that
+	 * we're executing on... So mmput_async() moves the release of the mm to
+	 * another thread, if we're the last user.
+	 */
+	mmput_async(mm);
+
+	return status;
 }
 
 static void iopf_handle_group(struct work_struct *work)
@@ -100,6 +158,30 @@ static void iopf_handle_group(struct work_struct *work)
  * @cookie: struct device, passed to iommu_register_device_fault_handler.
  *
  * Add a fault to the device workqueue, to be handled by mm.
+ *
+ * This module doesn't handle PCI PASID Stop Marker; IOMMU drivers must discard
+ * them before reporting faults. A PASID Stop Marker (LRW = 0b100) doesn't
+ * expect a response. It may be generated when disabling a PASID (issuing a
+ * PASID stop request) by some PCI devices.
+ *
+ * The PASID stop request is triggered by the mm_exit() callback. When the
+ * callback returns from the device driver, no page request is generated for
+ * this PASID anymore and outstanding ones have been pushed to the IOMMU (as per
+ * PCIe 4.0r1.0 - 6.20.1 and 10.4.1.2 - Managing PASID TLP Prefix Usage). Some
+ * PCI devices will wait for all outstanding page requests to come back with a
+ * response before completing the PASID stop request. Others do not wait for
+ * page responses, and instead issue this Stop Marker that tells us when the
+ * PASID can be reallocated.
+ *
+ * It is safe to discard the Stop Marker because it is an optimization.
+ * a. Page requests, which are posted requests, have been flushed to the IOMMU
+ *    when mm_exit() returns,
+ * b. We flush all fault queues after mm_exit() returns and before freeing the
+ *    PASID.
+ *
+ * So even though the Stop Marker might be issued by the device *after* the stop
+ * request completes, outstanding faults will have been dealt with by the time
+ * we free the PASID.
  */
 int iommu_queue_iopf(struct iommu_fault_event *evt, void *cookie)
 {
-- 
2.18.0

