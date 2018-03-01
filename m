Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH 03/37] iommu/sva: Manage process address spaces
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-4-jean-philippe.brucker@arm.com>
Cc: mark.rutland@arm.com, ilias.apalodimas@linaro.org,
        catalin.marinas@arm.com, xuzaibo@huawei.com, will.deacon@arm.com,
        okaya@codeaurora.org, ashok.raj@intel.com, bharatku@xilinx.com,
        rfranz@cavium.com, lenb@kernel.org, robh+dt@kernel.org,
        bhelgaas@google.com, shunyong.yang@hxt-semitech.com,
        dwmw2@infradead.org, rjw@rjwysocki.net, sudeep.holla@arm.com,
        christian.koenig@amd.com
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5A97A324.9050605@linux.intel.com>
Date: Thu, 1 Mar 2018 14:52:20 +0800
MIME-Version: 1.0
In-Reply-To: <20180212183352.22730-4-jean-philippe.brucker@arm.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jean,

On 02/13/2018 02:33 AM, Jean-Philippe Brucker wrote:
> Introduce boilerplate code for allocating IOMMU mm structures and binding
> them to devices. Four operations are added to IOMMU drivers:
>
> * mm_alloc(): to create an io_mm structure and perform architecture-
>   specific operations required to grab the process (for instance on ARM,
>   pin down the CPU ASID so that the process doesn't get assigned a new
>   ASID on rollover).
>
>   There is a single valid io_mm structure per Linux mm. Future extensions
>   may also use io_mm for kernel-managed address spaces, populated with
>   map()/unmap() calls instead of bound to process address spaces. This
>   patch focuses on "shared" io_mm.
>
> * mm_attach(): attach an mm to a device. The IOMMU driver checks that the
>   device is capable of sharing an address space, and writes the PASID
>   table entry to install the pgd.
>
>   Some IOMMU drivers will have a single PASID table per domain, for
>   convenience. Other can implement it differently but to help these
>   drivers, mm_attach and mm_detach take 'attach_domain' and
>   'detach_domain' parameters, that tell whether they need to set and clear
>   the PASID entry or only send the required TLB invalidations.
>
> * mm_detach(): detach an mm from a device. The IOMMU driver removes the
>   PASID table entry and invalidates the IOTLBs.
>
> * mm_free(): free a structure allocated by mm_alloc(), and let arch
>   release the process.
>
> mm_attach and mm_detach operations are serialized with a spinlock. At the
> moment it is global, but if we try to optimize it, the core should at
> least prevent concurrent attach()/detach() on the same domain (so
> multi-level PASID table code can allocate tables lazily). mm_alloc() can
> sleep, but mm_free must not (because we'll have to call it from call_srcu
> later on.)
>
> At the moment we use an IDR for allocating PASIDs and retrieving contexts.
> We also use a single spinlock. These can be refined and optimized later (a
> custom allocator will be needed for top-down PASID allocation).
>
> Keeping track of address spaces requires the use of MMU notifiers.
> Handling process exit with regard to unbind() is tricky, so it is left for
> another patch and we explicitly fail mm_alloc() for the moment.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  drivers/iommu/iommu-sva.c | 382 +++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/iommu/iommu.c     |   2 +
>  include/linux/iommu.h     |  25 +++
>  3 files changed, 406 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 593685d891bf..f9af9d66b3ed 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -7,11 +7,321 @@
>   * SPDX-License-Identifier: GPL-2.0
>   */
>  
> +#include <linux/idr.h>
>  #include <linux/iommu.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +
> +/**
> + * DOC: io_mm model
> + *
> + * The io_mm keeps track of process address spaces shared between CPU and IOMMU.
> + * The following example illustrates the relation between structures
> + * iommu_domain, io_mm and iommu_bond. An iommu_bond is a link between io_mm and
> + * device. A device can have multiple io_mm and an io_mm may be bound to
> + * multiple devices.
> + *              ___________________________
> + *             |  IOMMU domain A           |
> + *             |  ________________         |
> + *             | |  IOMMU group   |        +------- io_pgtables
> + *             | |                |        |
> + *             | |   dev 00:00.0 ----+------- bond --- io_mm X
> + *             | |________________|   \    |
> + *             |                       '----- bond ---.
> + *             |___________________________|           \
> + *              ___________________________             \
> + *             |  IOMMU domain B           |           io_mm Y
> + *             |  ________________         |           / /
> + *             | |  IOMMU group   |        |          / /
> + *             | |                |        |         / /
> + *             | |   dev 00:01.0 ------------ bond -' /
> + *             | |   dev 00:01.1 ------------ bond --'
> + *             | |________________|        |
> + *             |                           +------- io_pgtables
> + *             |___________________________|
> + *
> + * In this example, device 00:00.0 is in domain A, devices 00:01.* are in domain
> + * B. All devices within the same domain access the same address spaces. Device
> + * 00:00.0 accesses address spaces X and Y, each corresponding to an mm_struct.
> + * Devices 00:01.* only access address space Y. In addition each
> + * IOMMU_DOMAIN_DMA domain has a private address space, io_pgtable, that is
> + * managed with iommu_map()/iommu_unmap(), and isn't shared with the CPU MMU.
> + *
> + * To obtain the above configuration, users would for instance issue the
> + * following calls:
> + *
> + *     iommu_sva_bind_device(dev 00:00.0, mm X, ...) -> PASID 1
> + *     iommu_sva_bind_device(dev 00:00.0, mm Y, ...) -> PASID 2
> + *     iommu_sva_bind_device(dev 00:01.0, mm Y, ...) -> PASID 2
> + *     iommu_sva_bind_device(dev 00:01.1, mm Y, ...) -> PASID 2
> + *
> + * A single Process Address Space ID (PASID) is allocated for each mm. In the
> + * example, devices use PASID 1 to read/write into address space X and PASID 2
> + * to read/write into address space Y.
> + *
> + * Hardware tables describing this configuration in the IOMMU would typically
> + * look like this:
> + *
> + *                                PASID tables
> + *                                 of domain A
> + *                              .->+--------+
> + *                             / 0 |        |-------> io_pgtable
> + *                            /    +--------+
> + *            Device tables  /   1 |        |-------> pgd X
> + *              +--------+  /      +--------+
> + *      00:00.0 |      A |-'     2 |        |--.
> + *              +--------+         +--------+   \
> + *              :        :       3 |        |    \
> + *              +--------+         +--------+     --> pgd Y
> + *      00:01.0 |      B |--.                    /
> + *              +--------+   \                  |
> + *      00:01.1 |      B |----+   PASID tables  |
> + *              +--------+     \   of domain B  |
> + *                              '->+--------+   |
> + *                               0 |        |-- | --> io_pgtable
> + *                                 +--------+   |
> + *                               1 |        |   |
> + *                                 +--------+   |
> + *                               2 |        |---'
> + *                                 +--------+
> + *                               3 |        |
> + *                                 +--------+
> + *
> + * With this model, a single call binds all devices in a given domain to an
> + * address space. Other devices in the domain will get the same bond implicitly.
> + * However, users must issue one bind() for each device, because IOMMUs may
> + * implement SVA differently. Furthermore, mandating one bind() per device
> + * allows the driver to perform sanity-checks on device capabilities.
> + *
> + * On Arm and AMD IOMMUs, entry 0 of the PASID table can be used to hold
> + * non-PASID translations. In this case PASID 0 is reserved and entry 0 points
> + * to the io_pgtable base. On Intel IOMMU, the io_pgtable base would be held in
> + * the device table and PASID 0 would be available to the allocator.
> + */
>  
>  /* TODO: stub for the fault queue. Remove later. */
>  #define iommu_fault_queue_flush(...)
>  
> +struct iommu_bond {
> +	struct io_mm		*io_mm;
> +	struct device		*dev;
> +	struct iommu_domain	*domain;
> +
> +	struct list_head	mm_head;
> +	struct list_head	dev_head;
> +	struct list_head	domain_head;
> +
> +	void			*drvdata;
> +
> +	/* Number of bind() calls */
> +	refcount_t		refs;
> +};
> +
> +/*
> + * Because we're using an IDR, PASIDs are limited to 31 bits (the sign bit is
> + * used for returning errors). In practice implementations will use at most 20
> + * bits, which is the PCI limit.
> + */
> +static DEFINE_IDR(iommu_pasid_idr);
> +
> +/*
> + * For the moment this is an all-purpose lock. It serializes
> + * access/modifications to bonds, access/modifications to the PASID IDR, and
> + * changes to io_mm refcount as well.
> + */
> +static DEFINE_SPINLOCK(iommu_sva_lock);
> +
> +static struct io_mm *
> +io_mm_alloc(struct iommu_domain *domain, struct device *dev,
> +	    struct mm_struct *mm)
> +{
> +	int ret;
> +	int pasid;
> +	struct io_mm *io_mm;
> +	struct iommu_param *dev_param = dev->iommu_param;
> +
> +	if (!dev_param || !domain->ops->mm_alloc || !domain->ops->mm_free)
> +		return ERR_PTR(-ENODEV);
> +
> +	io_mm = domain->ops->mm_alloc(domain, mm);
> +	if (IS_ERR(io_mm))
> +		return io_mm;
> +	if (!io_mm)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/*
> +	 * The mm must not be freed until after the driver frees the io_mm
> +	 * (which may involve unpinning the CPU ASID for instance, requiring a
> +	 * valid mm struct.)
> +	 */
> +	mmgrab(mm);
> +
> +	io_mm->mm		= mm;
> +	io_mm->release		= domain->ops->mm_free;
> +	INIT_LIST_HEAD(&io_mm->devices);
> +
> +	idr_preload(GFP_KERNEL);
> +	spin_lock(&iommu_sva_lock);
> +	pasid = idr_alloc_cyclic(&iommu_pasid_idr, io_mm, dev_param->min_pasid,
> +				 dev_param->max_pasid + 1, GFP_ATOMIC);

Can the pasid management code be moved into a common library?
PASID is not stick to SVA. An IOMMU model device could be designed
to use PASID for second level translation (classical DMA translation)
as well.

Best regards,
Lu Baolu
