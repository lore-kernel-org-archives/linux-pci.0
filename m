Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com,
        alex.williamson@redhat.com, tn@semihalf.com, liubo95@huawei.com,
        thunder.leizhen@huawei.com, xieyisheng1@huawei.com,
        gabriele.paoloni@huawei.com, nwatters@codeaurora.org,
        okaya@codeaurora.org, rfranz@cavium.com, dwmw2@infradead.org,
        jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        ashok.raj@intel.com, robdclark@gmail.com
Subject: [RFCv2 PATCH 07/36] iommu: Add a fault handler
Date: Fri,  6 Oct 2017 14:31:34 +0100
Message-Id: <20171006133203.22803-8-jean-philippe.brucker@arm.com>
In-Reply-To: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some systems allow devices to do paging. For example systems supporting
PCI's PRI extension or ARM SMMU's stall model. As more IOMMU drivers are
adding support for page faults, we see a number of patterns that are
common to all implementations. Let's try to unify some of the generic
code.

Add boilerplate code to handle device page requests:

* An IOMMU drivers instantiate a fault workqueue if necessary, using
  iommu_fault_queue_init and iommu_fault_queue_destroy.

* When it receives a fault report, supposedly in an IRQ handler, the IOMMU
  driver reports the fault using handle_iommu_fault (as opposed to the
  current report_iommu_fault)

* Then depending on the domain configuration, we either immediately
  forward it to a device driver, or submit it to the fault queue, to be
  handled in a thread.

* When the fault corresponds to a process context, call the mm fault
  handler on it (in the next patch).

* Once the fault is handled, it is completed. This is either done
  automatically by the mm wrapper, or manually by a device driver (e.g.
  VFIO).

A new operation, fault_response, is added to IOMMU drivers. It takes the
same fault context passed to handle_iommu_fault and a status, allowing the
driver to complete the fault, for instance by sending a PRG Response in
PCI PRI.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/Kconfig         |   9 ++
 drivers/iommu/Makefile        |   1 +
 drivers/iommu/io-pgfault.c    | 330 ++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu-process.c |   3 -
 include/linux/iommu.h         | 102 ++++++++++++-
 5 files changed, 440 insertions(+), 5 deletions(-)
 create mode 100644 drivers/iommu/io-pgfault.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 1ea5c90e37be..a34d268d8ed3 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -84,6 +84,15 @@ config IOMMU_PROCESS
 
 	  If unsure, say N here.
 
+config IOMMU_FAULT
+	bool "Fault handler for the IOMMU API"
+	select IOMMU_API
+	help
+	  Enable the generic fault handler for the IOMMU API, that handles
+	  recoverable page faults or inject them into guests.
+
+	  If unsure, say N here.
+
 config FSL_PAMU
 	bool "Freescale IOMMU support"
 	depends on PCI
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index a2832edbfaa2..c34cbea482f0 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -2,6 +2,7 @@ obj-$(CONFIG_IOMMU_API) += iommu.o
 obj-$(CONFIG_IOMMU_API) += iommu-traces.o
 obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
 obj-$(CONFIG_IOMMU_PROCESS) += iommu-process.o
+obj-$(CONFIG_IOMMU_FAULT) += io-pgfault.o
 obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
new file mode 100644
index 000000000000..f31bc24534b0
--- /dev/null
+++ b/drivers/iommu/io-pgfault.c
@@ -0,0 +1,330 @@
+/*
+ * Handle device page faults
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ * Copyright (C) 2017 ARM Ltd.
+ *
+ * Author: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
+ */
+
+#include <linux/iommu.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
+
+static struct workqueue_struct *iommu_fault_queue;
+static DECLARE_RWSEM(iommu_fault_queue_sem);
+static refcount_t iommu_fault_queue_refs = REFCOUNT_INIT(0);
+static BLOCKING_NOTIFIER_HEAD(iommu_fault_queue_flush_notifiers);
+
+/* Used to store incomplete fault groups */
+static LIST_HEAD(iommu_partial_faults);
+static DEFINE_SPINLOCK(iommu_partial_faults_lock);
+
+struct iommu_fault_context {
+	struct iommu_domain	*domain;
+	struct device		*dev;
+	struct iommu_fault	params;
+	struct list_head	head;
+};
+
+struct iommu_fault_group {
+	struct list_head	faults;
+	struct work_struct	work;
+};
+
+/*
+ * iommu_fault_finish - Finish handling a fault
+ *
+ * Send a response if necessary and pass on the sanitized status code
+ */
+static int iommu_fault_finish(struct iommu_domain *domain, struct device *dev,
+			      struct iommu_fault *fault, int status)
+{
+	/*
+	 * There is no "handling" an unrecoverable fault, so the only valid
+	 * return values are 0 or an error.
+	 */
+	if (!(fault->flags & IOMMU_FAULT_RECOVERABLE))
+		return status > 0 ? 0 : status;
+
+	/* Device driver took ownership of the fault and will complete it later */
+	if (status == IOMMU_FAULT_STATUS_IGNORE)
+		return 0;
+
+	/*
+	 * There was an internal error with handling the recoverable fault (e.g.
+	 * OOM or no handler). Try to complete the fault if possible.
+	 */
+	if (status <= 0)
+		status = IOMMU_FAULT_STATUS_INVALID;
+
+	if (WARN_ON(!domain->ops->fault_response))
+		/*
+		 * The IOMMU driver shouldn't have submitted recoverable faults
+		 * if it cannot receive a response.
+		 */
+		return -EINVAL;
+
+	return domain->ops->fault_response(domain, dev, fault, status);
+}
+
+static int iommu_fault_handle_single(struct iommu_fault_context *fault)
+{
+	/* TODO */
+	return -ENODEV;
+}
+
+static void iommu_fault_handle_group(struct work_struct *work)
+{
+	struct iommu_fault_group *group;
+	struct iommu_fault_context *fault, *next;
+	int status = IOMMU_FAULT_STATUS_HANDLED;
+
+	group = container_of(work, struct iommu_fault_group, work);
+
+	list_for_each_entry_safe(fault, next, &group->faults, head) {
+		struct iommu_fault *params = &fault->params;
+		/*
+		 * Errors are sticky: don't handle subsequent faults in the
+		 * group if there is an error.
+		 */
+		if (status == IOMMU_FAULT_STATUS_HANDLED)
+			status = iommu_fault_handle_single(fault);
+
+		if (params->flags & IOMMU_FAULT_LAST ||
+		    !(params->flags & IOMMU_FAULT_GROUP)) {
+			iommu_fault_finish(fault->domain, fault->dev,
+					   &fault->params, status);
+		}
+
+		kfree(fault);
+	}
+
+	kfree(group);
+}
+
+static int iommu_queue_fault(struct iommu_domain *domain, struct device *dev,
+			     struct iommu_fault *params)
+{
+	struct iommu_fault_group *group;
+	struct iommu_fault_context *fault = kzalloc(sizeof(*fault), GFP_KERNEL);
+
+	/*
+	 * FIXME There is a race here, with queue_register. The last IOMMU
+	 * driver has to ensure no fault is reported anymore before
+	 * unregistering, so that doesn't matter. But you could have an IOMMU
+	 * device that didn't register to the fault queue and is still reporting
+	 * faults while the last queue user disappears. It really shouldn't get
+	 * here, but it currently does if there is a blocking handler.
+	 */
+	if (!iommu_fault_queue)
+		return -ENOSYS;
+
+	if (!fault)
+		return -ENOMEM;
+
+	fault->dev = dev;
+	fault->domain = domain;
+	fault->params = *params;
+
+	if ((params->flags & IOMMU_FAULT_LAST) || !(params->flags & IOMMU_FAULT_GROUP)) {
+		group = kzalloc(sizeof(*group), GFP_KERNEL);
+		if (!group) {
+			kfree(fault);
+			return -ENOMEM;
+		}
+
+		INIT_LIST_HEAD(&group->faults);
+		list_add(&fault->head, &group->faults);
+		INIT_WORK(&group->work, iommu_fault_handle_group);
+	} else {
+		/* Non-last request of a group. Postpone until the last one */
+		spin_lock(&iommu_partial_faults_lock);
+		list_add(&fault->head, &iommu_partial_faults);
+		spin_unlock(&iommu_partial_faults_lock);
+
+		return IOMMU_FAULT_STATUS_IGNORE;
+	}
+
+	if (params->flags & IOMMU_FAULT_GROUP) {
+		struct iommu_fault_context *cur, *next;
+
+		/* See if we have pending faults for this group */
+		spin_lock(&iommu_partial_faults_lock);
+		list_for_each_entry_safe(cur, next, &iommu_partial_faults, head) {
+			if (cur->params.id == params->id && cur->dev == dev) {
+				list_del(&cur->head);
+				/* Insert *before* the last fault */
+				list_add(&cur->head, &group->faults);
+			}
+		}
+		spin_unlock(&iommu_partial_faults_lock);
+	}
+
+	queue_work(iommu_fault_queue, &group->work);
+
+	/* Postpone the fault completion */
+	return IOMMU_FAULT_STATUS_IGNORE;
+}
+
+/**
+ * handle_iommu_fault - Handle fault in device driver or mm
+ *
+ * If the device driver expressed interest in handling fault, report it throught
+ * the domain handler. If the fault is recoverable, try to page in the address.
+ */
+int handle_iommu_fault(struct iommu_domain *domain, struct device *dev,
+		       struct iommu_fault *fault)
+{
+	int ret = -ENOSYS;
+
+	/*
+	 * if upper layers showed interest and installed a fault handler,
+	 * invoke it.
+	 */
+	if (domain->ext_handler) {
+		ret = domain->ext_handler(domain, dev, fault,
+					  domain->handler_token);
+
+		if (ret != IOMMU_FAULT_STATUS_NONE)
+			return iommu_fault_finish(domain, dev, fault, ret);
+	} else if (domain->handler && !(fault->flags &
+		   (IOMMU_FAULT_RECOVERABLE | IOMMU_FAULT_PASID))) {
+		/* Fall back to the old method if possible */
+		ret = domain->handler(domain, dev, fault->address,
+				      fault->flags, domain->handler_token);
+		if (ret)
+			return ret;
+	}
+
+	/* If the handler is blocking, handle fault in the workqueue */
+	if (fault->flags & IOMMU_FAULT_RECOVERABLE)
+		ret = iommu_queue_fault(domain, dev, fault);
+
+	return iommu_fault_finish(domain, dev, fault, ret);
+}
+EXPORT_SYMBOL_GPL(handle_iommu_fault);
+
+/**
+ * iommu_fault_response - Complete a recoverable fault
+ * @domain: iommu domain passed to the handler
+ * @dev: device passed to the handler
+ * @fault: fault passed to the handler
+ * @status: action to perform
+ *
+ * An atomic handler that took ownership of the fault (by returning
+ * IOMMU_FAULT_STATUS_IGNORE) must complete the fault by calling this function.
+ */
+int iommu_fault_response(struct iommu_domain *domain, struct device *dev,
+			 struct iommu_fault *fault, enum iommu_fault_status status)
+{
+	/* No response is need for unrecoverable faults... */
+	if (!(fault->flags & IOMMU_FAULT_RECOVERABLE))
+		return -EINVAL;
+
+	/* Ignore is certainly the wrong thing to do at this point */
+	if (WARN_ON(status == IOMMU_FAULT_STATUS_IGNORE ||
+		    status == IOMMU_FAULT_STATUS_NONE))
+		status = IOMMU_FAULT_STATUS_INVALID;
+
+	return iommu_fault_finish(domain, dev, fault, status);
+}
+EXPORT_SYMBOL_GPL(iommu_fault_response);
+
+/**
+ * iommu_fault_queue_register - register an IOMMU driver to the global fault
+ * queue
+ *
+ * @flush_notifier: a notifier block that is called before the fault queue is
+ * flushed. The IOMMU driver should commit all faults that are pending in its
+ * low-level queues at the time of the call, into the fault queue. The notifier
+ * takes a device pointer as argument, hinting what endpoint is causing the
+ * flush. When the device is NULL, all faults should be committed.
+ */
+int iommu_fault_queue_register(struct notifier_block *flush_notifier)
+{
+	/*
+	 * The WQ is unordered because the low-level handler enqueues faults by
+	 * group. PRI requests within a group have to be ordered, but once
+	 * that's dealt with, the high-level function can handle groups out of
+	 * order.
+	 */
+	down_write(&iommu_fault_queue_sem);
+	if (!iommu_fault_queue) {
+		iommu_fault_queue = alloc_workqueue("iommu_fault_queue",
+						    WQ_UNBOUND, 0);
+		if (iommu_fault_queue)
+			refcount_set(&iommu_fault_queue_refs, 1);
+	} else {
+		refcount_inc(&iommu_fault_queue_refs);
+	}
+	up_write(&iommu_fault_queue_sem);
+
+	if (!iommu_fault_queue)
+		return -ENOMEM;
+
+	if (flush_notifier)
+		blocking_notifier_chain_register(&iommu_fault_queue_flush_notifiers,
+						 flush_notifier);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iommu_fault_queue_register);
+
+/**
+ * iommu_fault_queue_flush - Ensure that all queued faults have been processed.
+ * @dev: the endpoint whose faults need to be flushed. If NULL, flush all
+ *       pending faults.
+ *
+ * Users must call this function when releasing a PASID, to ensure that all
+ * pending faults affecting this PASID have been handled, and won't affect the
+ * address space of a subsequent process that reuses this PASID.
+ */
+void iommu_fault_queue_flush(struct device *dev)
+{
+	blocking_notifier_call_chain(&iommu_fault_queue_flush_notifiers, 0, dev);
+
+	down_read(&iommu_fault_queue_sem);
+	/*
+	 * Don't flush the partial faults list. All PRGs with the PASID are
+	 * complete and have been submitted to the queue.
+	 */
+	if (iommu_fault_queue)
+		flush_workqueue(iommu_fault_queue);
+	up_read(&iommu_fault_queue_sem);
+}
+EXPORT_SYMBOL_GPL(iommu_fault_queue_flush);
+
+/**
+ * iommu_fault_queue_unregister - Unregister an IOMMU driver from the global
+ * fault queue.
+ *
+ * @flush_notifier: same parameter as iommu_fault_queue_register
+ */
+void iommu_fault_queue_unregister(struct notifier_block *flush_notifier)
+{
+	down_write(&iommu_fault_queue_sem);
+	if (refcount_dec_and_test(&iommu_fault_queue_refs)) {
+		destroy_workqueue(iommu_fault_queue);
+		iommu_fault_queue = NULL;
+	}
+	up_write(&iommu_fault_queue_sem);
+
+	if (flush_notifier)
+		blocking_notifier_chain_unregister(&iommu_fault_queue_flush_notifiers,
+						   flush_notifier);
+}
+EXPORT_SYMBOL_GPL(iommu_fault_queue_unregister);
diff --git a/drivers/iommu/iommu-process.c b/drivers/iommu/iommu-process.c
index dee7691e3791..092240708b78 100644
--- a/drivers/iommu/iommu-process.c
+++ b/drivers/iommu/iommu-process.c
@@ -26,9 +26,6 @@
 #include <linux/sched/mm.h>
 #include <linux/spinlock.h>
 
-/* FIXME: stub for the fault queue. Remove later. */
-#define iommu_fault_queue_flush(...)
-
 /* Link between a domain and a process */
 struct iommu_context {
 	struct iommu_process	*process;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ea4eaf585eb4..37fafaf07ee2 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -51,15 +51,69 @@ struct iommu_domain;
 struct notifier_block;
 
 /* iommu fault flags */
-#define IOMMU_FAULT_READ	0x0
-#define IOMMU_FAULT_WRITE	0x1
+#define IOMMU_FAULT_READ		(1 << 0)
+#define IOMMU_FAULT_WRITE		(1 << 1)
+#define IOMMU_FAULT_EXEC		(1 << 2)
+#define IOMMU_FAULT_PRIV		(1 << 3)
+/*
+ * If a fault is recoverable, then it *must* be completed, once handled, with
+ * iommu_fault_response.
+ */
+#define IOMMU_FAULT_RECOVERABLE		(1 << 4)
+/* The PASID field is valid */
+#define IOMMU_FAULT_PASID		(1 << 5)
+/* Fault is part of a group (PCI PRG) */
+#define IOMMU_FAULT_GROUP		(1 << 6)
+/* Fault is last of its group */
+#define IOMMU_FAULT_LAST		(1 << 7)
+
+/**
+ * enum iommu_fault_status - Return status of fault handlers, telling the IOMMU
+ *	driver how to proceed with the fault.
+ *
+ * @IOMMU_FAULT_STATUS_NONE: Fault was not handled. Call the next handler, or
+ *	terminate.
+ * @IOMMU_FAULT_STATUS_FAILURE: General error. Drop all subsequent faults from
+ *	this device if possible. This is "Response Failure" in PCI PRI.
+ * @IOMMU_FAULT_STATUS_INVALID: Could not handle this fault, don't retry the
+ *	access. This is "Invalid Request" in PCI PRI.
+ * @IOMMU_FAULT_STATUS_HANDLED: Fault has been handled and the page tables
+ *	populated, retry the access.
+ * @IOMMU_FAULT_STATUS_IGNORE: Stop processing the fault, and do not send a
+ *	reply to the device.
+ *
+ * For unrecoverable faults, the only valid status is IOMMU_FAULT_STATUS_NONE
+ * For a recoverable fault, if no one handled the fault, treat as
+ * IOMMU_FAULT_STATUS_INVALID.
+ */
+enum iommu_fault_status {
+	IOMMU_FAULT_STATUS_NONE = 0,
+	IOMMU_FAULT_STATUS_FAILURE,
+	IOMMU_FAULT_STATUS_INVALID,
+	IOMMU_FAULT_STATUS_HANDLED,
+	IOMMU_FAULT_STATUS_IGNORE,
+};
 
 typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
 			struct device *, unsigned long, int, void *);
 
 struct iommu_fault {
+	/* Faulting address */
 	unsigned long		address;
+	/* Fault flags */
 	unsigned int		flags;
+	/* Process address space ID (if IOMMU_FAULT_PASID is present) */
+	u32			pasid;
+	/*
+	 * For PCI PRI, 'id' is the PRG. For others, it's a tag identifying a
+	 * single fault.
+	 */
+	unsigned int		id;
+	/*
+	 * IOMMU vendor-specific things. This cannot be a private pointer
+	 * because the fault report might leave the kernel and into a guest.
+	 */
+	u64			iommu_data;
 };
 
 typedef int (*iommu_ext_fault_handler_t)(struct iommu_domain *, struct device *,
@@ -228,6 +282,7 @@ struct iommu_resv_region {
  * @domain_set_windows: Set the number of windows for a domain
  * @domain_get_windows: Return the number of windows for a domain
  * @of_xlate: add OF master IDs to iommu grouping
+ * @fault_reponse: complete a recoverable fault
  * @pgsize_bitmap: bitmap of all possible supported page sizes
  */
 struct iommu_ops {
@@ -287,6 +342,10 @@ struct iommu_ops {
 	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
 	bool (*is_attach_deferred)(struct iommu_domain *domain, struct device *dev);
 
+	int (*fault_response)(struct iommu_domain *domain, struct device *dev,
+			      struct iommu_fault *fault,
+			      enum iommu_fault_status status);
+
 	unsigned long pgsize_bitmap;
 };
 
@@ -824,4 +883,43 @@ static inline void __iommu_process_unbind_dev_all(struct iommu_domain *domain,
 
 #endif /* CONFIG_IOMMU_PROCESS */
 
+#ifdef CONFIG_IOMMU_FAULT
+extern int handle_iommu_fault(struct iommu_domain *domain, struct device *dev,
+			      struct iommu_fault *fault);
+extern int iommu_fault_response(struct iommu_domain *domain, struct device *dev,
+				struct iommu_fault *fault,
+				enum iommu_fault_status status);
+extern int iommu_fault_queue_register(struct notifier_block *flush_notifier);
+extern void iommu_fault_queue_flush(struct device *dev);
+extern void iommu_fault_queue_unregister(struct notifier_block *flush_notifier);
+#else /* CONFIG_IOMMU_FAULT */
+static inline int handle_iommu_fault(struct iommu_domain *domain,
+				     struct device *dev,
+				     struct iommu_fault *fault)
+{
+	return -ENODEV;
+}
+
+static inline int iommu_fault_response(struct iommu_domain *domain,
+				       struct device *dev,
+				       struct iommu_fault *fault,
+				       enum iommu_fault_status status)
+{
+	return -ENODEV;
+}
+
+static inline int iommu_fault_queue_register(struct notifier_block *flush_notifier)
+{
+	return -ENODEV;
+}
+
+static inline void iommu_fault_queue_flush(struct device *dev)
+{
+}
+
+static inline void iommu_fault_queue_unregister(struct notifier_block *flush_notifier)
+{
+}
+#endif /* CONFIG_IOMMU_FAULT */
+
 #endif /* __LINUX_IOMMU_H */
-- 
2.13.3

