Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC: "joro@8bytes.org" <joro@8bytes.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "tn@semihalf.com" <tn@semihalf.com>,
        "liubo95@huawei.com" <liubo95@huawei.com>,
        "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
        "xieyisheng1@huawei.com" <xieyisheng1@huawei.com>,
        "gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>,
        "nwatters@codeaurora.org" <nwatters@codeaurora.org>,
        "okaya@codeaurora.org" <okaya@codeaurora.org>,
        "rfranz@cavium.com" <rfranz@cavium.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "robdclark@gmail.com" <robdclark@gmail.com>
Subject: RE: [RFCv2 PATCH 01/36] iommu: Keep track of processes and PASIDs
Date: Mon, 23 Oct 2017 11:04:15 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439AFD88A@SHSMSX104.ccr.corp.intel.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-2-jean-philippe.brucker@arm.com>
In-Reply-To: <20171006133203.22803-2-jean-philippe.brucker@arm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jean,

> -----Original Message-----
> From: Jean-Philippe Brucker [mailto:jean-philippe.brucker@arm.com]
> Sent: Friday, October 6, 2017 9:31 PM
> To: linux-arm-kernel@lists.infradead.org; linux-pci@vger.kernel.org; linux-
> acpi@vger.kernel.org; devicetree@vger.kernel.org; iommu@lists.linux-
> foundation.org
> Cc: joro@8bytes.org; robh+dt@kernel.org; mark.rutland@arm.com;
> catalin.marinas@arm.com; will.deacon@arm.com; lorenzo.pieralisi@arm.com;
> hanjun.guo@linaro.org; sudeep.holla@arm.com; rjw@rjwysocki.net;
> lenb@kernel.org; robin.murphy@arm.com; bhelgaas@google.com;
> alex.williamson@redhat.com; tn@semihalf.com; liubo95@huawei.com;
> thunder.leizhen@huawei.com; xieyisheng1@huawei.com;
> gabriele.paoloni@huawei.com; nwatters@codeaurora.org; okaya@codeaurora.org;
> rfranz@cavium.com; dwmw2@infradead.org; jacob.jun.pan@linux.intel.com; Liu, Yi
> L <yi.l.liu@intel.com>; Raj, Ashok <ashok.raj@intel.com>; robdclark@gmail.com
> Subject: [RFCv2 PATCH 01/36] iommu: Keep track of processes and PASIDs
> 
> IOMMU drivers need a way to bind Linux processes to devices. This is used for
> Shared Virtual Memory (SVM), where devices support paging. In that mode, DMA can
> directly target virtual addresses of a process.
> 
> Introduce boilerplate code for allocating process structures and binding them to
> devices. Four operations are added to IOMMU drivers:
> 
> * process_alloc, process_free: to create an iommu_process structure and
>   perform architecture-specific operations required to grab the process
>   (for instance on ARM SMMU, pin down the CPU ASID). There is a single
>   iommu_process structure per Linux process.
> 
> * process_attach: attach a process to a device. The IOMMU driver checks
>   that the device is capable of sharing an address space with this
>   process, and writes the PASID table entry to install the process page
>   directory.
> 
>   Some IOMMU drivers (e.g. ARM SMMU and virtio-iommu) will have a single
>   PASID table per domain, for convenience. Other can implement it
>   differently but to help these drivers, process_attach and process_detach
>   take a 'first' or 'last' parameter telling whether they need to
>   install/remove the PASID entry or only send the required TLB
>   invalidations.
> 
> * process_detach: detach a process from a device. The IOMMU driver removes
>   the PASID table entry and invalidates the IOTLBs.
> 
> process_attach and process_detach operations are serialized with a spinlock. At the
> moment it is global, but if we try to optimize it, the core should at least prevent
> concurrent attach/detach on the same domain.
> (so multi-level PASID table code can allocate tables lazily without having to go
> through the io-pgtable concurrency nightmare). process_alloc can sleep, but
> process_free must not (because we'll have to call it from
> call_srcu.)
> 
> At the moment we use an IDR for allocating PASIDs and retrieving contexts.
> We also use a single spinlock. These can be refined and optimized later (a custom
> allocator will be needed for top-down PASID allocation).
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  drivers/iommu/Kconfig         |  10 ++
>  drivers/iommu/Makefile        |   1 +
>  drivers/iommu/iommu-process.c | 225
> ++++++++++++++++++++++++++++++++++++++++++
>  drivers/iommu/iommu.c         |   1 +
>  include/linux/iommu.h         |  24 +++++
>  5 files changed, 261 insertions(+)
>  create mode 100644 drivers/iommu/iommu-process.c
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig index
> f3a21343e636..1ea5c90e37be 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -74,6 +74,16 @@ config IOMMU_DMA
>  	select IOMMU_IOVA
>  	select NEED_SG_DMA_LENGTH
> 
> +config IOMMU_PROCESS
> +	bool "Process management API for the IOMMU"
> +	select IOMMU_API
> +	help
> +	  Enable process management for the IOMMU API. In systems that support
> +	  it, device drivers can bind processes to devices and share their page
> +	  tables using this API.
> +
> +	  If unsure, say N here.
> +
>  config FSL_PAMU
>  	bool "Freescale IOMMU support"
>  	depends on PCI
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile index
> b910aea813a1..a2832edbfaa2 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -1,6 +1,7 @@
>  obj-$(CONFIG_IOMMU_API) += iommu.o
>  obj-$(CONFIG_IOMMU_API) += iommu-traces.o
>  obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
> +obj-$(CONFIG_IOMMU_PROCESS) += iommu-process.o
>  obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
>  obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
>  obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o diff --git
> a/drivers/iommu/iommu-process.c b/drivers/iommu/iommu-process.c new file
> mode 100644 index 000000000000..a7e5a1c94305
> --- /dev/null
> +++ b/drivers/iommu/iommu-process.c
> @@ -0,0 +1,225 @@
> +/*
> + * Track processes bound to devices
> + *
> + * This program is free software; you can redistribute it and/or modify
> +it
> + * under the terms of the GNU General Public License version 2 as
> +published
> + * by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
> +USA
> + *
> + * Copyright (C) 2017 ARM Ltd.
> + *
> + * Author: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>  */
> +
> +#include <linux/idr.h>
> +#include <linux/iommu.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +
> +/* Link between a domain and a process */ struct iommu_context {
> +	struct iommu_process	*process;
> +	struct iommu_domain	*domain;
> +
> +	struct list_head	process_head;
> +	struct list_head	domain_head;
> +
> +	/* Number of devices that use this context */
> +	refcount_t		ref;
> +};
> +
> +/*
> + * Because we're using an IDR, PASIDs are limited to 31 bits (the sign
> +bit is
> + * used for returning errors). In practice implementations will use at
> +most 20
> + * bits, which is the PCI limit.
> + */
> +static DEFINE_IDR(iommu_process_idr);
> +
> +/*
> + * For the moment this is an all-purpose lock. It serializes
> + * access/modifications to contexts (process-domain links),
> +access/modifications
> + * to the PASID IDR, and changes to process refcount as well.
> + */
> +static DEFINE_SPINLOCK(iommu_process_lock);
> +
> +/*
> + * Allocate a iommu_process structure for the given task.
> + *
> + * Ideally we shouldn't need the domain parameter, since iommu_process
> +is
> + * system-wide, but we use it to retrieve the driver's allocation ops
> +and a
> + * PASID range.
> + */
> +static struct iommu_process *
> +iommu_process_alloc(struct iommu_domain *domain, struct task_struct
> +*task) {
> +	int err;
> +	int pasid;
> +	struct iommu_process *process;
> +
> +	if (WARN_ON(!domain->ops->process_alloc || !domain->ops-
> >process_free))
> +		return ERR_PTR(-ENODEV);
> +
> +	process = domain->ops->process_alloc(task);
> +	if (IS_ERR(process))
> +		return process;
> +	if (!process)
> +		return ERR_PTR(-ENOMEM);
> +
> +	process->pid		= get_task_pid(task, PIDTYPE_PID);
> +	process->release	= domain->ops->process_free;
> +	INIT_LIST_HEAD(&process->domains);
> +	kref_init(&process->kref);
> +
> +	if (!process->pid) {
> +		err = -EINVAL;
> +		goto err_free_process;
> +	}
> +
> +	idr_preload(GFP_KERNEL);
> +	spin_lock(&iommu_process_lock);
> +	pasid = idr_alloc_cyclic(&iommu_process_idr, process, domain->min_pasid,
> +				 domain->max_pasid + 1, GFP_ATOMIC);
> +	process->pasid = pasid;

[Liu, Yi L] If I'm understanding well, here is managing the pasid allocation in iommu
layer instead of vendor iommu driver? Is there strong reason here? I think pasid
management may be better within vendor iommu driver as pasid management
could differ from vendor to vendor.

Regards,
Yi L

