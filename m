Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 13 Feb 2018 23:18:21 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
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
        yi.l.liu@intel.com, ashok.raj@intel.com, robdclark@gmail.com,
        christian.koenig@amd.com, bharatku@xilinx.com,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 07/37] iommu: Add a page fault handler
Message-ID: <20180213231821.5863ef99@jacob-builder>
In-Reply-To: <20180212183352.22730-8-jean-philippe.brucker@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
        <20180212183352.22730-8-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 12 Feb 2018 18:33:22 +0000
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> Some systems allow devices to handle IOMMU translation faults in the
> core mm. For example systems supporting the PCI PRI extension or Arm
> SMMU stall model. Infrastructure for reporting such recoverable page
> faults was recently added to the IOMMU core, for SVA virtualization.
> Extend iommu_report_device_fault() to handle host page faults as well.
> 
> * IOMMU drivers instantiate a fault workqueue, using
>   iommu_fault_queue_init() and iommu_fault_queue_destroy().
> 
> * When it receives a fault event, supposedly in an IRQ handler, the
> IOMMU driver reports the fault using iommu_report_device_fault()
> 
> * If the device driver registered a handler (e.g. VFIO), pass down the
>   fault event. Otherwise submit it to the fault queue, to be handled
> in a thread.
> 
> * When the fault corresponds to an io_mm, call the mm fault handler
> on it (in next patch).
> 
> * Once the fault is handled, the mm wrapper or the device driver
> reports success of failure with iommu_page_response(). The
> translation is either retried or aborted, depending on the response
> code.
> 
Hi Jean,
Seems a good approach to consolidate page fault. I will try to test
intel-svm code with this flow. more comments inline.
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  drivers/iommu/Kconfig      |  10 ++
>  drivers/iommu/Makefile     |   1 +
>  drivers/iommu/io-pgfault.c | 282
> +++++++++++++++++++++++++++++++++++++++++++++
> drivers/iommu/iommu-sva.c  |   3 - drivers/iommu/iommu.c      |  31
> ++--- include/linux/iommu.h      |  34 +++++-
>  6 files changed, 339 insertions(+), 22 deletions(-)
>  create mode 100644 drivers/iommu/io-pgfault.c
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 146eebe9a4bb..e751bb9958ba 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -85,6 +85,15 @@ config IOMMU_SVA
>  
>  	  If unsure, say N here.
>  
> +config IOMMU_FAULT
> +	bool "Fault handler for the IOMMU API"
> +	select IOMMU_API
> +	help
> +	  Enable the generic fault handler for the IOMMU API, that
> handles
> +	  recoverable page faults or inject them into guests.
> +
> +	  If unsure, say N here.
> +
>  config FSL_PAMU
>  	bool "Freescale IOMMU support"
>  	depends on PCI
> @@ -156,6 +165,7 @@ config INTEL_IOMMU
>  	select IOMMU_API
>  	select IOMMU_IOVA
>  	select DMAR_TABLE
> +	select IOMMU_FAULT
>  	help
>  	  DMA remapping (DMAR) devices support enables independent
> address translations for Direct Memory Access (DMA) from devices.
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 1dbcc89ebe4c..f4324e29035e 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_IOMMU_API) += iommu-traces.o
>  obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
>  obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
>  obj-$(CONFIG_IOMMU_SVA) += iommu-sva.o
> +obj-$(CONFIG_IOMMU_FAULT) += io-pgfault.o
>  obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
>  obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
>  obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
> diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
> new file mode 100644
> index 000000000000..33309ed316d2
> --- /dev/null
> +++ b/drivers/iommu/io-pgfault.c
> @@ -0,0 +1,282 @@
> +/*
> + * Handle device page faults
> + *
> + * Copyright (C) 2018 ARM Ltd.
> + * Author: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0
> + */
> +
> +#include <linux/iommu.h>
> +#include <linux/list.h>
> +#include <linux/slab.h>
> +#include <linux/workqueue.h>
> +
> +static struct workqueue_struct *iommu_fault_queue;
> +static DECLARE_RWSEM(iommu_fault_queue_sem);
> +static refcount_t iommu_fault_queue_refs = REFCOUNT_INIT(0);
> +static BLOCKING_NOTIFIER_HEAD(iommu_fault_queue_flush_notifiers);
> +
> +/* Used to store incomplete fault groups */
> +static LIST_HEAD(iommu_partial_faults);
> +static DEFINE_SPINLOCK(iommu_partial_faults_lock);
> +
should partial fault list be per iommu?
> +struct iommu_fault_context {
> +	struct device			*dev;
> +	struct iommu_fault_event	evt;
> +	struct list_head		head;
> +};
> +
> +struct iommu_fault_group {
> +	struct iommu_domain		*domain;
> +	struct iommu_fault_context	last_fault;
> +	struct list_head		faults;
> +	struct work_struct		work;
> +};
> +
> +/*
> + * iommu_fault_complete() - Finish handling a fault
> + *
> + * Send a response if necessary and pass on the sanitized status code
> + */
> +static int iommu_fault_complete(struct iommu_domain *domain, struct
> device *dev,
> +				struct iommu_fault_event *evt, int
> status) +{
> +	struct page_response_msg resp = {
> +		.addr		= evt->addr,
> +		.pasid		= evt->pasid,
> +		.pasid_present	= evt->pasid_valid,
> +		.page_req_group_id = evt->page_req_group_id,
> +		.type		= IOMMU_PAGE_GROUP_RESP,
> +		.private_data	= evt->iommu_private,
> +	};
> +
> +	/*
> +	 * There is no "handling" an unrecoverable fault, so the
> only valid
> +	 * return values are 0 or an error.
> +	 */
> +	if (evt->type == IOMMU_FAULT_DMA_UNRECOV)
> +		return status > 0 ? 0 : status;
> +
> +	/* Someone took ownership of the fault and will complete it
> later */
> +	if (status == IOMMU_PAGE_RESP_HANDLED)
> +		return 0;
> +
> +	/*
> +	 * There was an internal error with handling the recoverable
> fault. Try
> +	 * to complete the fault if possible.
> +	 */
> +	if (status < 0)
> +		status = IOMMU_PAGE_RESP_INVALID;
> +
> +	if (WARN_ON(!domain->ops->page_response))
> +		/*
> +		 * The IOMMU driver shouldn't have submitted
> recoverable faults
> +		 * if it cannot receive a response.
> +		 */
> +		return -EINVAL;
> +
> +	resp.resp_code = status;
> +	return domain->ops->page_response(domain, dev, &resp);
> +}
> +
> +static int iommu_fault_handle_single(struct iommu_fault_context
> *fault) +{
> +	/* TODO */
> +	return -ENODEV;
> +}
> +
> +static void iommu_fault_handle_group(struct work_struct *work)
> +{
> +	struct iommu_fault_group *group;
> +	struct iommu_fault_context *fault, *next;
> +	int status = IOMMU_PAGE_RESP_SUCCESS;
> +
> +	group = container_of(work, struct iommu_fault_group, work);
> +
> +	list_for_each_entry_safe(fault, next, &group->faults, head) {
> +		struct iommu_fault_event *evt = &fault->evt;
> +		/*
> +		 * Errors are sticky: don't handle subsequent faults
> in the
> +		 * group if there is an error.
> +		 */
> +		if (status == IOMMU_PAGE_RESP_SUCCESS)
> +			status = iommu_fault_handle_single(fault);
> +
> +		if (!evt->last_req)
> +			kfree(fault);
> +	}
> +
> +	iommu_fault_complete(group->domain, group->last_fault.dev,
> +			     &group->last_fault.evt, status);
> +	kfree(group);
> +}
> +
> +static int iommu_queue_fault(struct iommu_domain *domain, struct
> device *dev,
> +			     struct iommu_fault_event *evt)
> +{
> +	struct iommu_fault_group *group;
> +	struct iommu_fault_context *fault, *next;
> +
> +	if (!iommu_fault_queue)
> +		return -ENOSYS;
> +
> +	if (!evt->last_req) {
> +		fault = kzalloc(sizeof(*fault), GFP_KERNEL);
> +		if (!fault)
> +			return -ENOMEM;
> +
> +		fault->evt = *evt;
> +		fault->dev = dev;
> +
> +		/* Non-last request of a group. Postpone until the
> last one */
> +		spin_lock(&iommu_partial_faults_lock);
> +		list_add_tail(&fault->head, &iommu_partial_faults);
> +		spin_unlock(&iommu_partial_faults_lock);
> +
> +		return IOMMU_PAGE_RESP_HANDLED;
> +	}
> +
> +	group = kzalloc(sizeof(*group), GFP_KERNEL);
> +	if (!group)
> +		return -ENOMEM;
> +
> +	group->last_fault.evt = *evt;
> +	group->last_fault.dev = dev;
> +	group->domain = domain;
> +	INIT_LIST_HEAD(&group->faults);
> +	list_add(&group->last_fault.head, &group->faults);
> +	INIT_WORK(&group->work, iommu_fault_handle_group);
> +
> +	/* See if we have pending faults for this group */
> +	spin_lock(&iommu_partial_faults_lock);
> +	list_for_each_entry_safe(fault, next, &iommu_partial_faults,
> head) {
> +		if (fault->evt.page_req_group_id ==
> evt->page_req_group_id &&
> +		    fault->dev == dev) {
> +			list_del(&fault->head);
> +			/* Insert *before* the last fault */
> +			list_add(&fault->head, &group->faults);
> +		}
> +	}
> +	spin_unlock(&iommu_partial_faults_lock);
> +
> +	queue_work(iommu_fault_queue, &group->work);
> +
> +	/* Postpone the fault completion */
> +	return IOMMU_PAGE_RESP_HANDLED;
> +}
> +
> +/**
> + * iommu_report_device_fault() - Handle fault in device driver or mm
> + *
> + * If the device driver expressed interest in handling fault, report
> it through
> + * the callback. If the fault is recoverable, try to page in the
> address.
> + */
> +int iommu_report_device_fault(struct device *dev, struct
> iommu_fault_event *evt) +{
> +	int ret = -ENOSYS;
> +	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> +
> +	if (!domain)
> +		return -ENODEV;
> +
> +	/*
> +	 * if upper layers showed interest and installed a fault
> handler,
> +	 * invoke it.
> +	 */
> +	if (iommu_has_device_fault_handler(dev)) {
I think Alex pointed out this is racy, so adding a mutex to the
iommu_fault_param and acquire it would help. Do we really
atomic handler?
> +		struct iommu_fault_param *param =
> dev->iommu_param->fault_param; +
> +		return param->handler(evt, param->data);
Even upper layer (VFIO) registered handler to propagate PRQ to a guest
to fault in the pages, we may still need to keep track of the page
requests that need page response later, i.e. last page in group or
stream request in vt-d. This will allow us sanitize the page response
come back from the guest/VFIO.
In my next round, I am adding a per device list under iommu_fault_param
for pending page request. This will also address the situation where
guest failed to send response. We can enforce time or credit limit of
pending requests based on this list.

> +	}
> +
> +	/* If the handler is blocking, handle fault in the workqueue
> */
> +	if (evt->type == IOMMU_FAULT_PAGE_REQ)
> +		ret = iommu_queue_fault(domain, dev, evt);
> +
> +	return iommu_fault_complete(domain, dev, evt, ret);
> +}
> +EXPORT_SYMBOL_GPL(iommu_report_device_fault);
> +
> +/**
> + * iommu_fault_queue_register() - register an IOMMU driver to the
> fault queue
> + * @flush_notifier: a notifier block that is called before the fault
> queue is
> + * flushed. The IOMMU driver should commit all faults that are
> pending in its
> + * low-level queues at the time of the call, into the fault queue.
> The notifier
> + * takes a device pointer as argument, hinting what endpoint is
> causing the
> + * flush. When the device is NULL, all faults should be committed.
> + */
> +int iommu_fault_queue_register(struct notifier_block *flush_notifier)
> +{
> +	/*
> +	 * The WQ is unordered because the low-level handler
> enqueues faults by
> +	 * group. PRI requests within a group have to be ordered,
> but once
> +	 * that's dealt with, the high-level function can handle
> groups out of
> +	 * order.
> +	 */
> +	down_write(&iommu_fault_queue_sem);
> +	if (!iommu_fault_queue) {
> +		iommu_fault_queue =
> alloc_workqueue("iommu_fault_queue",
> +						    WQ_UNBOUND, 0);
> +		if (iommu_fault_queue)
> +			refcount_set(&iommu_fault_queue_refs, 1);
> +	} else {
> +		refcount_inc(&iommu_fault_queue_refs);
> +	}
> +	up_write(&iommu_fault_queue_sem);
> +
> +	if (!iommu_fault_queue)
> +		return -ENOMEM;
> +
> +	if (flush_notifier)
> +
> blocking_notifier_chain_register(&iommu_fault_queue_flush_notifiers,
> +						 flush_notifier);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(iommu_fault_queue_register);
> +
> +/**
> + * iommu_fault_queue_flush() - Ensure that all queued faults have
> been
> + * processed.
> + * @dev: the endpoint whose faults need to be flushed. If NULL,
> flush all
> + *       pending faults.
> + *
> + * Users must call this function when releasing a PASID, to ensure
> that all
> + * pending faults affecting this PASID have been handled, and won't
> affect the
> + * address space of a subsequent process that reuses this PASID.
> + */
> +void iommu_fault_queue_flush(struct device *dev)
> +{
> +
> blocking_notifier_call_chain(&iommu_fault_queue_flush_notifiers, 0,
> dev); +
> +	down_read(&iommu_fault_queue_sem);
> +	/*
> +	 * Don't flush the partial faults list. All PRGs with the
> PASID are
> +	 * complete and have been submitted to the queue.
> +	 */
> +	if (iommu_fault_queue)
> +		flush_workqueue(iommu_fault_queue);
> +	up_read(&iommu_fault_queue_sem);
> +}
> +EXPORT_SYMBOL_GPL(iommu_fault_queue_flush);
> +
> +/**
> + * iommu_fault_queue_unregister() - Unregister an IOMMU driver from
> the fault
> + * queue.
> + * @flush_notifier: same parameter as iommu_fault_queue_register
> + */
> +void iommu_fault_queue_unregister(struct notifier_block
> *flush_notifier) +{
> +	down_write(&iommu_fault_queue_sem);
> +	if (refcount_dec_and_test(&iommu_fault_queue_refs)) {
> +		destroy_workqueue(iommu_fault_queue);
> +		iommu_fault_queue = NULL;
> +	}
> +	up_write(&iommu_fault_queue_sem);
> +
> +	if (flush_notifier)
> +
> blocking_notifier_chain_unregister(&iommu_fault_queue_flush_notifiers,
> +						   flush_notifier);
> +}
> +EXPORT_SYMBOL_GPL(iommu_fault_queue_unregister);
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 4bc2a8c12465..d7b231cd7355 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -102,9 +102,6 @@
>   * the device table and PASID 0 would be available to the allocator.
>   */
>  
> -/* TODO: stub for the fault queue. Remove later. */
> -#define iommu_fault_queue_flush(...)
> -
>  struct iommu_bond {
>  	struct io_mm		*io_mm;
>  	struct device		*dev;
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 1d60b32a6744..c475893ec7dc 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -798,6 +798,17 @@ int iommu_group_unregister_notifier(struct
> iommu_group *group, }
>  EXPORT_SYMBOL_GPL(iommu_group_unregister_notifier);
>  
> +/**
> + * iommu_register_device_fault_handler() - Register a device fault
> handler
> + * @dev: the device
> + * @handler: the fault handler
> + * @data: private data passed as argument to the callback
> + *
> + * When an IOMMU fault event is received, call this handler with the
> fault event
> + * and data as argument.
> + *
> + * Return 0 if the fault handler was installed successfully, or an
> error.
> + */
>  int iommu_register_device_fault_handler(struct device *dev,
>  					iommu_dev_fault_handler_t
> handler, void *data)
> @@ -825,6 +836,13 @@ int iommu_register_device_fault_handler(struct
> device *dev, }
>  EXPORT_SYMBOL_GPL(iommu_register_device_fault_handler);
>  
> +/**
> + * iommu_unregister_device_fault_handler() - Unregister the device
> fault handler
> + * @dev: the device
> + *
> + * Remove the device fault handler installed with
> + * iommu_register_device_fault_handler().
> + */
>  int iommu_unregister_device_fault_handler(struct device *dev)
>  {
>  	struct iommu_param *idata = dev->iommu_param;
> @@ -840,19 +858,6 @@ int iommu_unregister_device_fault_handler(struct
> device *dev) }
>  EXPORT_SYMBOL_GPL(iommu_unregister_device_fault_handler);
>  
> -
> -int iommu_report_device_fault(struct device *dev, struct
> iommu_fault_event *evt) -{
> -	/* we only report device fault if there is a handler
> registered */
> -	if (!dev->iommu_param || !dev->iommu_param->fault_param ||
> -		!dev->iommu_param->fault_param->handler)
> -		return -ENOSYS;
> -
> -	return dev->iommu_param->fault_param->handler(evt,
> -
> dev->iommu_param->fault_param->data); -}
> -EXPORT_SYMBOL_GPL(iommu_report_device_fault);
> -
>  /**
>   * iommu_group_id - Return ID for a group
>   * @group: the group to ID
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 226ab4f3ae0e..65e56f28e0ce 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -205,6 +205,7 @@ struct page_response_msg {
>  	u32 resp_code:4;
>  #define IOMMU_PAGE_RESP_SUCCESS	0
>  #define IOMMU_PAGE_RESP_INVALID	1
> +#define IOMMU_PAGE_RESP_HANDLED	2
>  #define IOMMU_PAGE_RESP_FAILURE	0xF
>  
>  	u32 pasid_present:1;
> @@ -534,7 +535,6 @@ extern int
> iommu_register_device_fault_handler(struct device *dev, 
>  extern int iommu_unregister_device_fault_handler(struct device *dev);
>  
> -extern int iommu_report_device_fault(struct device *dev, struct
> iommu_fault_event *evt); extern int iommu_page_response(struct
> iommu_domain *domain, struct device *dev, struct page_response_msg
> *msg); 
> @@ -836,11 +836,6 @@ static inline bool
> iommu_has_device_fault_handler(struct device *dev) return false;
>  }
>  
> -static inline int iommu_report_device_fault(struct device *dev,
> struct iommu_fault_event *evt) -{
> -	return 0;
> -}
> -
>  static inline int iommu_page_response(struct iommu_domain *domain,
> struct device *dev, struct page_response_msg *msg)
>  {
> @@ -1005,4 +1000,31 @@ static inline struct mm_struct
> *iommu_sva_find(int pasid) }
>  #endif /* CONFIG_IOMMU_SVA */
>  
> +#ifdef CONFIG_IOMMU_FAULT
> +extern int iommu_fault_queue_register(struct notifier_block
> *flush_notifier); +extern void iommu_fault_queue_flush(struct device
> *dev); +extern void iommu_fault_queue_unregister(struct
> notifier_block *flush_notifier); +extern int
> iommu_report_device_fault(struct device *dev,
> +				     struct iommu_fault_event *evt);
> +#else /* CONFIG_IOMMU_FAULT */
> +static inline int iommu_fault_queue_register(struct notifier_block
> *flush_notifier) +{
> +	return -ENODEV;
> +}
> +
> +static inline void iommu_fault_queue_flush(struct device *dev)
> +{
> +}
> +
> +static inline void iommu_fault_queue_unregister(struct
> notifier_block *flush_notifier) +{
> +}
> +
> +static inline int iommu_report_device_fault(struct device *dev,
> +					    struct iommu_fault_event
> *evt) +{
> +	return 0;
> +}
> +#endif /* CONFIG_IOMMU_FAULT */
> +
>  #endif /* __LINUX_IOMMU_H */

[Jacob Pan]
