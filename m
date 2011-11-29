Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59449 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752455Ab1K2Dqb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 28 Nov 2011 22:46:31 -0500
Message-ID: <1322538366.19120.122.camel@bling.home>
Subject: Re: [RFC PATCH] vfio: VFIO Driver core framework
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@au1.ibm.com>
Cc: chrisw@sous-sol.org, pmac@au1.ibm.com, dwg@au1.ibm.com,
	joerg.roedel@amd.com, agraf@suse.de, benve@cisco.com,
	aafabbri@cisco.com, B08248@freescale.com, B07421@freescale.com,
	avi@redhat.com, konrad.wilk@oracle.com, kvm@vger.kernel.org,
	qemu-devel@nongnu.org, iommu@lists.linux-foundation.org,
	linux-pci@vger.kernel.org
Date: Mon, 28 Nov 2011 20:46:06 -0700
In-Reply-To: <4ED43AD9.5090509@au1.ibm.com>
References: <20111103195452.21259.93021.stgit@bling.home>
	 <4ED43AD9.5090509@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2011-11-29 at 12:52 +1100, Alexey Kardashevskiy wrote:
> Hi!
> 
> I tried (successfully) to run it on POWER and while doing that I found some issues. I'll try to
> explain them in separate mails.

Great!

> IOMMU domain setup. On POWER, the linux drivers capable of DMA transfer want to know
> a DMA window, i.e. its start and length in the PHB address space. This comes from
> hardware. On X86 (correct if I am wrong), every device driver in the guest allocates
> memory from the same pool.

Yes, current VT-d/AMD-Vi provide independent IOVA spaces for each
device.

>  On POWER, device drivers get DMA window and allocate pages
> for DMA within this window. In the case of VFIO, that means that QEMU has to
> preallocate this DMA window before running a quest, pass it to a guest (via
> device tree) and then a guest tells the host what pages are taken/released by
> calling map/unmap callbacks of iommu_ops. Deallocation is made in a device detach
> callback as I did not want to add more ioctls.
> So, there are 2 patches:
> 
> - new VFIO_IOMMU_SETUP ioctl introduced which allocates a DMA window via IOMMU API on
> POWER.
> btw do we need an additional capability bit for it?
> 
> KERNEL PATCH:
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 10615ad..a882e08 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -247,3 +247,12 @@ int iommu_device_group(struct device *dev, unsigned int *groupid)
>  	return -ENODEV;
>  }
>  EXPORT_SYMBOL_GPL(iommu_device_group);
> +
> +int iommu_setup(struct iommu_domain *domain,
> +		size_t requested_size, size_t *allocated_size,
> +		phys_addr_t *start_address)
> +{
> +	return domain->ops->setup(domain, requested_size, allocated_size,
> +			start_address);
> +}
> +EXPORT_SYMBOL_GPL(iommu_setup);

requested_size seems redundant both here and in struct vfio_setup.  We
can just pre-load size/start with desired values.  I assume x86 IOMMUs
would ignore requested values and return start = 0 and size = hardware
decoder address bits.  The IOMMU API currently allows:

iommu_domain_alloc
[iommu_attach_device]
[iommu_map]
[iommu_unmap]
[iommu_detach_device]
iommu_domain_free

where everything between alloc and free can be called in any order.  How
does setup fit into that model?  For this it seems like we'd almost want
to combine alloc, setup, and the first attach into a single call (ie.
create a domain with this initial device and these parameters), then
subsequent attaches would only allow compatible devices.

I'm a little confused though, is the window determined by hardware or is
it configurable via requested_size?  David had suggested that we could
implement a VFIO_IOMMU_GET_INFO ioctl that returns something like:

struct vfio_iommu_info {
        __u32   argsz;
        __u32   flags;
        __u64   iova_max;       /* Maximum IOVA address */
        __u64   iova_min;       /* Minimum IOVA address */
        __u64   pgsize_bitmap;  /* Bitmap of supported page sizes */
};

The thought being a TBD IOMMU API interface reports the hardware
determined IOVA range and we could fudge it on x86 for now reporting
0/~0.  Maybe we should replace iova_max/iova_min with
iova_base/iova_size and allow the caller to request a size by setting
iova_size and matching bit in the flags.

> diff --git a/drivers/vfio/vfio_iommu.c b/drivers/vfio/vfio_iommu.c
> index 029dae3..57fb70d 100644
> --- a/drivers/vfio/vfio_iommu.c
> +++ b/drivers/vfio/vfio_iommu.c
> @@ -507,6 +507,23 @@ static long vfio_iommu_unl_ioctl(struct file *filep,
> 
>  		if (!ret && copy_to_user((void __user *)arg, &dm, sizeof dm))
>  			ret = -EFAULT;
> +
> +	} else if (cmd == VFIO_IOMMU_SETUP) {
> +		struct vfio_setup setup;
> +		size_t allocated_size = 0;
> +		phys_addr_t start_address = 0;
> +
> +		if (copy_from_user(&setup, (void __user *)arg, sizeof setup))
> +			return -EFAULT;
> +
> +		printk("udomain %p, priv=%p\n", iommu->domain, iommu->domain->priv);
> +		ret = iommu_setup(iommu->domain, setup.requested_size,
> +				&allocated_size, &start_address);
> +		setup.allocated_size = allocated_size;
> +		setup.start_address = start_address;
> +
> +		if (!ret && copy_to_user((void __user *)arg, &setup, sizeof setup))
> +			ret = -EFAULT;
>  	}
>  	return ret;
>  }
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 93617e7..355cf8b 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -45,6 +45,7 @@ struct iommu_domain {
> 
>  #define IOMMU_CAP_CACHE_COHERENCY	0x1
>  #define IOMMU_CAP_INTR_REMAP		0x2	/* isolates device intrs */
> +#define IOMMU_CAP_SETUP_REQUIRED	0x3	/* requires setup to be called */
> 
>  #ifdef CONFIG_IOMMU_API
> 
> @@ -62,6 +63,9 @@ struct iommu_ops {
>  	int (*domain_has_cap)(struct iommu_domain *domain,
>  			      unsigned long cap);
>  	int (*device_group)(struct device *dev, unsigned int *groupid);
> +	int (*setup)(struct iommu_domain *domain,
> +		     size_t requested_size, size_t *allocated_size,
> +		     phys_addr_t *start_address);
>  };
> 
>  extern int bus_set_iommu(struct bus_type *bus, struct iommu_ops *ops);
> @@ -80,6 +84,9 @@ extern phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain,
>  				      unsigned long iova);
>  extern int iommu_domain_has_cap(struct iommu_domain *domain,
>  				unsigned long cap);
> +extern int iommu_setup(struct iommu_domain *domain,
> +		       size_t requested_size, size_t *allocated_size,
> +		       phys_addr_t *start_address);
>  extern void iommu_set_fault_handler(struct iommu_domain *domain,
>  					iommu_fault_handler_t handler);
>  extern int iommu_device_group(struct device *dev, unsigned int *groupid);
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index 971e3b1..5e0ee75 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -26,6 +26,7 @@
>   * Author: Michael S. Tsirkin <mst@redhat.com>
>   */
>  #include <linux/types.h>
> +#include <linux/ioctl.h>
> 
>  #ifndef VFIO_H
>  #define VFIO_H
> @@ -172,4 +173,13 @@ enum {
>  	VFIO_PCI_NUM_IRQS
>  };
> 
> +/* Setup domain */
> +#define VFIO_IOMMU_SETUP		_IOWR(';', 150, struct vfio_setup)
> +
> +struct vfio_setup {
> +	__u64	requested_size;
> +	__u64	allocated_size;
> +	__u64	start_address;
> +};
> +
>   #endif /* VFIO_H */
> 
> === end ===
> 
> 
> QEMU PATCH:
> 
> diff --git a/hw/linux-vfio.h b/hw/linux-vfio.h
> index ac48d85..a2c719f 100644
> --- a/hw/linux-vfio.h
> +++ b/hw/linux-vfio.h
> @@ -172,4 +172,13 @@ enum {
>  	VFIO_PCI_NUM_IRQS
>  };
> 
> +/* Setup domain */
> +#define VFIO_IOMMU_SETUP                _IOWR(';', 150, struct vfio_setup)
> +
> +struct vfio_setup {
> +	__u64   requested_size;
> +	__u64   allocated_size;
> +	__u64   start_address;
> +};
> +
>  #endif /* VFIO_H */
> diff --git a/hw/vfio_pci.c b/hw/vfio_pci.c
> index 1c97c35..b438bbe 100644
> --- a/hw/vfio_pci.c
> +++ b/hw/vfio_pci.c
> @@ -1501,6 +1503,17 @@ static int vfio_initfn(struct PCIDevice *pdev)
>      if (vfio_map_resources(vdev))
>          goto out_disable_msi;
> 
> +    struct vfio_setup setup = { 1 << 26, 0, 0 };

How will qemu decide how much to ask for?

> +    if ((ret =  ioctl(vdev->group->iommu->fd, VFIO_IOMMU_SETUP, &setup))) {
> +        return ret;
> +    }
> +    printf("SETUP: requested %lluMB, allocated %lluMB at %llx\n",
> +        (unsigned long long)setup.requested_size,
> +        (unsigned long long)setup.allocated_size,
> +        (unsigned long long)setup.start_address);
> +    vdev->start_address = setup.start_address;
> +    vdev->window_size = setup.allocated_size;
> +
>      if (vfio_enable_intx(vdev))
>          goto out_unmap_resources;
> 
> diff --git a/hw/vfio_pci.h b/hw/vfio_pci.h
> index 96b09bb..6b7ab6f 100644
> --- a/hw/vfio_pci.h
> +++ b/hw/vfio_pci.h
> @@ -79,6 +79,10 @@ typedef struct VFIODevice {
>      bool msix;
>      uint8_t msix_bar;
>      uint16_t msix_entries;
> +#ifdef TARGET_PPC
> +    uint64_t start_address;
> +    uint32_t window_size;
> +#endif
>  } VFIODevice;
> 
>  typedef struct VFIOGroup {
> 
> === end ===
> 
> 
> 
> - changed __vfio_close_iommu function to do unmapall first and detach devices then
> as actual deallocation happens on device detach callback of IOMMU ops.
> 
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 6169356..f78f411 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -28,6 +28,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/vfio.h>
>  #include <linux/wait.h>
> +#include <linux/pci.h>
> 
>  #include "vfio_private.h"
> 
> @@ -242,6 +243,13 @@ static void __vfio_close_iommu(struct vfio_iommu *iommu)
>  	if (!iommu->domain)
>  		return;
> 
> +	/*
> +	 * On POWER, device detaching (which is done by __vfio_iommu_detach_group)
> +	 * should happen after all pages unmapped because
> +	 * the only way to do actual iommu_unmap_page a device detach callback
> +	 */
> +	vfio_iommu_unmapall(iommu);
> +

The unmapall/detach vs detach/unmapall shouldn't matter for x86.  Though
I wonder if we should be proactively resetting devices before either to
avoid spurious IOVA faults.

>  	list_for_each(pos, &iommu->group_list) {
>  		struct vfio_group *group;
>  		group = list_entry(pos, struct vfio_group, iommu_next);
> @@ -249,7 +257,7 @@ static void __vfio_close_iommu(struct vfio_iommu *iommu)
>  		__vfio_iommu_detach_group(iommu, group);
>  	}
> 
> -	vfio_iommu_unmapall(iommu);
> +	/* vfio_iommu_unmapall(iommu); */
> 
>  	iommu_domain_free(iommu->domain);
>  	iommu->domain = NULL;

Thanks,

Alex

