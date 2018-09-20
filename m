Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5727C433F4
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 17:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8178820673
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 17:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8178820673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbeITXJq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:09:46 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50260 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbeITXJp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Sep 2018 19:09:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 462F71596;
        Thu, 20 Sep 2018 10:25:14 -0700 (PDT)
Received: from ostrya.Emea.Arm.com (ostrya.emea.arm.com [10.4.12.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A08443F557;
        Thu, 20 Sep 2018 10:25:10 -0700 (PDT)
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
Subject: [PATCH v3 07/10] iommu: Add a page fault handler
Date:   Thu, 20 Sep 2018 18:00:43 +0100
Message-Id: <20180920170046.20154-8-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some systems allow devices to handle I/O Page Faults in the core mm. For
example systems implementing the PCI PRI extension or Arm SMMU stall
model. Infrastructure for reporting these recoverable page faults was
recently added to the IOMMU core for SVA virtualisation. Add a page fault
handler for host SVA.

IOMMU driver can now instantiate several fault workqueues and link them to
IOPF-capable devices. Drivers can choose between a single global
workqueue, one per IOMMU device, one per low-level fault queue, one per
domain, etc.

When it receives a fault event, supposedly in an IRQ handler, the IOMMU
driver reports the fault using iommu_report_device_fault(), which calls
the registered handler. The page fault handler then calls the mm fault
handler, and reports either success or failure with iommu_page_response().
When the handler succeeded, the IOMMU retries the access.

The iopf_param pointer could be embedded into iommu_fault_param. But
putting iopf_param into the iommu_param structure allows us not to care
about ordering between calls to iopf_queue_add_device() and
iommu_register_device_fault_handler().

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
v2->v3:
* queue_flush now removes pending partial faults
* queue_flush now takes an optional PASID argument, allowing IOMMU
  drivers to selectively flush faults if possible
* remove PAGE_RESP_HANDLED/PAGE_RESP_CONTINUE
* rename iopf_context -> iopf_fault
---
 drivers/iommu/Kconfig      |   4 +
 drivers/iommu/Makefile     |   1 +
 drivers/iommu/io-pgfault.c | 382 +++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h      |  56 +++++-
 4 files changed, 442 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/io-pgfault.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 88d6c68284f3..27e9999ad980 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -100,6 +100,10 @@ config IOMMU_SVA
 	select IOMMU_API
 	select MMU_NOTIFIER
 
+config IOMMU_PAGE_FAULT
+	bool
+	select IOMMU_API
+
 config FSL_PAMU
 	bool "Freescale IOMMU support"
 	depends on PCI
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 7d6332be5f0e..1c4b0be5d44b 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
 obj-$(CONFIG_IOMMU_DEBUGFS) += iommu-debugfs.o
 obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
 obj-$(CONFIG_IOMMU_SVA) += iommu-sva.o
+obj-$(CONFIG_IOMMU_PAGE_FAULT) += io-pgfault.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
new file mode 100644
index 000000000000..29aa8c6ba459
--- /dev/null
+++ b/drivers/iommu/io-pgfault.c
@@ -0,0 +1,382 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Handle device page faults
+ *
+ * Copyright (C) 2018 ARM Ltd.
+ */
+
+#include <linux/iommu.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
+
+/**
+ * struct iopf_queue - IO Page Fault queue
+ * @wq: the fault workqueue
+ * @flush: low-level flush callback
+ * @flush_arg: flush() argument
+ * @refs: references to this structure taken by producers
+ */
+struct iopf_queue {
+	struct workqueue_struct		*wq;
+	iopf_queue_flush_t		flush;
+	void				*flush_arg;
+	refcount_t			refs;
+};
+
+/**
+ * struct iopf_device_param - IO Page Fault data attached to a device
+ * @queue: IOPF queue
+ * @partial: faults that are part of a Page Request Group for which the last
+ *           request hasn't been submitted yet.
+ */
+struct iopf_device_param {
+	struct iopf_queue		*queue;
+	struct list_head		partial;
+};
+
+struct iopf_fault {
+	struct iommu_fault_event	evt;
+	struct list_head		head;
+};
+
+struct iopf_group {
+	struct iopf_fault		last_fault;
+	struct list_head		faults;
+	struct work_struct		work;
+	struct device			*dev;
+};
+
+static int iopf_complete(struct device *dev, struct iommu_fault_event *evt,
+			 enum page_response_code status)
+{
+	struct page_response_msg resp = {
+		.addr			= evt->addr,
+		.pasid			= evt->pasid,
+		.pasid_present		= evt->pasid_valid,
+		.page_req_group_id	= evt->page_req_group_id,
+		.private_data		= evt->iommu_private,
+		.resp_code		= status,
+	};
+
+	return iommu_page_response(dev, &resp);
+}
+
+static enum page_response_code
+iopf_handle_single(struct iopf_fault *fault)
+{
+	/* TODO */
+	return -ENODEV;
+}
+
+static void iopf_handle_group(struct work_struct *work)
+{
+	struct iopf_group *group;
+	struct iopf_fault *fault, *next;
+	enum page_response_code status = IOMMU_PAGE_RESP_SUCCESS;
+
+	group = container_of(work, struct iopf_group, work);
+
+	list_for_each_entry_safe(fault, next, &group->faults, head) {
+		struct iommu_fault_event *evt = &fault->evt;
+		/*
+		 * For the moment, errors are sticky: don't handle subsequent
+		 * faults in the group if there is an error.
+		 */
+		if (status == IOMMU_PAGE_RESP_SUCCESS)
+			status = iopf_handle_single(fault);
+
+		if (!evt->last_req)
+			kfree(fault);
+	}
+
+	iopf_complete(group->dev, &group->last_fault.evt, status);
+	kfree(group);
+}
+
+/**
+ * iommu_queue_iopf - IO Page Fault handler
+ * @evt: fault event
+ * @cookie: struct device, passed to iommu_register_device_fault_handler.
+ *
+ * Add a fault to the device workqueue, to be handled by mm.
+ */
+int iommu_queue_iopf(struct iommu_fault_event *evt, void *cookie)
+{
+	struct iopf_group *group;
+	struct iopf_fault *fault, *next;
+	struct iopf_device_param *iopf_param;
+
+	struct device *dev = cookie;
+	struct iommu_param *param = dev->iommu_param;
+
+	if (WARN_ON(!mutex_is_locked(&param->lock)))
+		return -EINVAL;
+
+	if (evt->type != IOMMU_FAULT_PAGE_REQ)
+		/* Not a recoverable page fault */
+		return 0;
+
+	/*
+	 * As long as we're holding param->lock, the queue can't be unlinked
+	 * from the device and therefore cannot disappear.
+	 */
+	iopf_param = param->iopf_param;
+	if (!iopf_param)
+		return -ENODEV;
+
+	if (!evt->last_req) {
+		fault = kzalloc(sizeof(*fault), GFP_KERNEL);
+		if (!fault)
+			return -ENOMEM;
+
+		fault->evt = *evt;
+
+		/* Non-last request of a group. Postpone until the last one */
+		list_add(&fault->head, &iopf_param->partial);
+
+		return 0;
+	}
+
+	group = kzalloc(sizeof(*group), GFP_KERNEL);
+	if (!group)
+		return -ENOMEM;
+
+	group->dev = dev;
+	group->last_fault.evt = *evt;
+	INIT_LIST_HEAD(&group->faults);
+	list_add(&group->last_fault.head, &group->faults);
+	INIT_WORK(&group->work, iopf_handle_group);
+
+	/* See if we have partial faults for this group */
+	list_for_each_entry_safe(fault, next, &iopf_param->partial, head) {
+		if (fault->evt.page_req_group_id == evt->page_req_group_id)
+			/* Insert *before* the last fault */
+			list_move(&fault->head, &group->faults);
+	}
+
+	queue_work(iopf_param->queue->wq, &group->work);
+
+	/* Postpone the fault completion */
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iommu_queue_iopf);
+
+/**
+ * iopf_queue_flush_dev - Ensure that all queued faults have been processed
+ * @dev: the endpoint whose faults need to be flushed.
+ * @pasid: the PASID affected by this flush
+ *
+ * Users must call this function when releasing a PASID, to ensure that all
+ * pending faults for this PASID have been handled, and won't hit the address
+ * space of the next process that uses this PASID.
+ *
+ * This function can also be called before shutting down the device, in which
+ * case @pasid should be IOMMU_PASID_INVALID.
+ *
+ * Return 0 on success.
+ */
+int iopf_queue_flush_dev(struct device *dev, int pasid)
+{
+	int ret = 0;
+	struct iopf_queue *queue;
+	struct iopf_fault *fault, *next;
+	struct iommu_param *param = dev->iommu_param;
+
+	if (!param)
+		return -ENODEV;
+
+	/*
+	 * It is incredibly easy to find ourselves in a deadlock situation if
+	 * we're not careful, because we're taking the opposite path as
+	 * iommu_queue_iopf:
+	 *
+	 *   iopf_queue_flush_dev()   |  PRI queue handler
+	 *    lock(mutex)             |   iommu_queue_iopf()
+	 *     queue->flush()         |    lock(mutex)
+	 *      wait PRI queue empty  |
+	 *
+	 * So we can't hold the device param lock while flushing. We don't have
+	 * to, because the queue or the device won't disappear until all flush
+	 * are finished.
+	 */
+	mutex_lock(&param->lock);
+	if (param->iopf_param)
+		queue = param->iopf_param->queue;
+	else
+		ret = -ENODEV;
+	mutex_unlock(&param->lock);
+	if (ret)
+		return ret;
+
+	/*
+	 * When removing a PASID, the device driver tells the device to stop
+	 * using it, and flush any pending fault to the IOMMU. In this flush
+	 * callback, the IOMMU driver makes sure that there are no such faults
+	 * left in the low-level queue.
+	 */
+	queue->flush(queue->flush_arg, dev, pasid);
+
+	/*
+	 * If at some point the low-level fault queue overflowed and the IOMMU
+	 * device had to auto-respond to a 'last' page fault, other faults from
+	 * the same Page Request Group may still be stuck in the partial list.
+	 * We need to make sure that the next address space using the PASID
+	 * doesn't receive them.
+	 */
+	mutex_lock(&param->lock);
+	list_for_each_entry_safe(fault, next, &param->iopf_param->partial, head) {
+		if (fault->evt.pasid == pasid || pasid == IOMMU_PASID_INVALID) {
+			list_del(&fault->head);
+			kfree(fault);
+		}
+	}
+	mutex_unlock(&param->lock);
+
+	flush_workqueue(queue->wq);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iopf_queue_flush_dev);
+
+/**
+ * iopf_queue_add_device - Add producer to the fault queue
+ * @queue: IOPF queue
+ * @dev: device to add
+ */
+int iopf_queue_add_device(struct iopf_queue *queue, struct device *dev)
+{
+	int ret = -EINVAL;
+	struct iopf_device_param *iopf_param;
+	struct iommu_param *param = dev->iommu_param;
+
+	if (!param)
+		return -ENODEV;
+
+	iopf_param = kzalloc(sizeof(*iopf_param), GFP_KERNEL);
+	if (!iopf_param)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&iopf_param->partial);
+	iopf_param->queue = queue;
+
+	mutex_lock(&param->lock);
+	if (!param->iopf_param) {
+		refcount_inc(&queue->refs);
+		param->iopf_param = iopf_param;
+		ret = 0;
+	}
+	mutex_unlock(&param->lock);
+
+	if (ret)
+		kfree(iopf_param);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iopf_queue_add_device);
+
+/**
+ * iopf_queue_remove_device - Remove producer from fault queue
+ * @dev: device to remove
+ *
+ * Caller makes sure that no more fault is reported for this device, and no more
+ * flush is scheduled for this device.
+ *
+ * Note: safe to call unconditionally on a cleanup path, even if the device
+ * isn't registered to any IOPF queue.
+ *
+ * Return 0 if the device was attached to the IOPF queue
+ */
+int iopf_queue_remove_device(struct device *dev)
+{
+	struct iopf_fault *fault, *next;
+	struct iopf_device_param *iopf_param;
+	struct iommu_param *param = dev->iommu_param;
+
+	if (!param)
+		return -EINVAL;
+
+	mutex_lock(&param->lock);
+	iopf_param = param->iopf_param;
+	if (iopf_param) {
+		refcount_dec(&iopf_param->queue->refs);
+		param->iopf_param = NULL;
+	}
+	mutex_unlock(&param->lock);
+	if (!iopf_param)
+		return -EINVAL;
+
+	/* Just in case flush_dev() wasn't called */
+	list_for_each_entry_safe(fault, next, &iopf_param->partial, head)
+		kfree(fault);
+
+	/*
+	 * No more flush is scheduled, and the caller removed all bonds from
+	 * this device. unbind() waited until any concurrent mm_exit() finished,
+	 * therefore there is no flush() running anymore and we can free the
+	 * param.
+	 */
+	kfree(iopf_param);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iopf_queue_remove_device);
+
+/**
+ * iopf_queue_alloc - Allocate and initialize a fault queue
+ * @name: a unique string identifying the queue (for workqueue)
+ * @flush: a callback that flushes the low-level queue
+ * @cookie: driver-private data passed to the flush callback
+ *
+ * The callback is called before the workqueue is flushed. The IOMMU driver must
+ * commit all faults that are pending in its low-level queues at the time of the
+ * call, into the IOPF queue (with iommu_report_device_fault). The callback
+ * takes a device pointer as argument, hinting what endpoint is causing the
+ * flush. When the device is NULL, all faults should be committed.
+ */
+struct iopf_queue *
+iopf_queue_alloc(const char *name, iopf_queue_flush_t flush, void *cookie)
+{
+	struct iopf_queue *queue;
+
+	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
+	if (!queue)
+		return NULL;
+
+	/*
+	 * The WQ is unordered because the low-level handler enqueues faults by
+	 * group. PRI requests within a group have to be ordered, but once
+	 * that's dealt with, the high-level function can handle groups out of
+	 * order.
+	 */
+	queue->wq = alloc_workqueue("iopf_queue/%s", WQ_UNBOUND, 0, name);
+	if (!queue->wq) {
+		kfree(queue);
+		return NULL;
+	}
+
+	queue->flush = flush;
+	queue->flush_arg = cookie;
+	refcount_set(&queue->refs, 1);
+
+	return queue;
+}
+EXPORT_SYMBOL_GPL(iopf_queue_alloc);
+
+/**
+ * iopf_queue_free - Free IOPF queue
+ * @queue: queue to free
+ *
+ * Counterpart to iopf_queue_alloc(). Caller must make sure that all producers
+ * have been removed.
+ */
+void iopf_queue_free(struct iopf_queue *queue)
+{
+	/* Caller should have removed all producers first */
+	if (WARN_ON(!refcount_dec_and_test(&queue->refs)))
+		return;
+
+	destroy_workqueue(queue->wq);
+	kfree(queue);
+}
+EXPORT_SYMBOL_GPL(iopf_queue_free);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a457650b80de..b7cd00ae7358 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -63,6 +63,8 @@ typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
 typedef int (*iommu_dev_fault_handler_t)(struct iommu_fault_event *, void *);
 typedef int (*iommu_mm_exit_handler_t)(struct device *dev, int pasid, void *);
 
+#define IOMMU_PASID_INVALID		(-1)
+
 struct iommu_domain_geometry {
 	dma_addr_t aperture_start; /* First address that can be mapped    */
 	dma_addr_t aperture_end;   /* Last address that can be mapped     */
@@ -440,11 +442,20 @@ struct iommu_fault_param {
 	void *data;
 };
 
+/**
+ * iopf_queue_flush_t - Flush low-level page fault queue
+ *
+ * Report all faults currently pending in the low-level page fault queue
+ */
+struct iopf_queue;
+typedef int (*iopf_queue_flush_t)(void *cookie, struct device *dev, int pasid);
+
 /**
  * struct iommu_param - collection of per-device IOMMU data
  *
  * @fault_param: IOMMU detected device fault reporting data
- * @lock: serializes accesses to fault_param
+ * @iopf_param: I/O Page Fault queue and data
+ * @lock: serializes accesses to fault_param and iopf_param
  * @sva_param: SVA parameters
  * @sva_lock: serializes accesses to sva_param
  *
@@ -455,6 +466,7 @@ struct iommu_fault_param {
 struct iommu_param {
 	struct mutex lock;
 	struct iommu_fault_param *fault_param;
+	struct iopf_device_param *iopf_param;
 	struct mutex sva_lock;
 	struct iommu_sva_param *sva_param;
 };
@@ -1025,4 +1037,46 @@ static inline struct mm_struct *iommu_sva_find(int pasid)
 }
 #endif /* CONFIG_IOMMU_SVA */
 
+#ifdef CONFIG_IOMMU_PAGE_FAULT
+extern int iommu_queue_iopf(struct iommu_fault_event *evt, void *cookie);
+
+extern int iopf_queue_add_device(struct iopf_queue *queue, struct device *dev);
+extern int iopf_queue_remove_device(struct device *dev);
+extern int iopf_queue_flush_dev(struct device *dev, int pasid);
+extern struct iopf_queue *
+iopf_queue_alloc(const char *name, iopf_queue_flush_t flush, void *cookie);
+extern void iopf_queue_free(struct iopf_queue *queue);
+#else /* CONFIG_IOMMU_PAGE_FAULT */
+static inline int iommu_queue_iopf(struct iommu_fault_event *evt, void *cookie)
+{
+	return -ENODEV;
+}
+
+static inline int iopf_queue_add_device(struct iopf_queue *queue,
+					struct device *dev)
+{
+	return -ENODEV;
+}
+
+static inline int iopf_queue_remove_device(struct device *dev)
+{
+	return -ENODEV;
+}
+
+static inline int iopf_queue_flush_dev(struct device *dev, int pasid)
+{
+	return -ENODEV;
+}
+
+static inline struct iopf_queue *
+iopf_queue_alloc(const char *name, iopf_queue_flush_t flush, void *cookie)
+{
+	return NULL;
+}
+
+static inline void iopf_queue_free(struct iopf_queue *queue)
+{
+}
+#endif /* CONFIG_IOMMU_PAGE_FAULT */
+
 #endif /* __LINUX_IOMMU_H */
-- 
2.18.0

