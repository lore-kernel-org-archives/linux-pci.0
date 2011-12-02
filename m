Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148]:48510 "EHLO
	e23smtp06.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074Ab1LBFHV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 Dec 2011 00:07:21 -0500
Received: from /spool/local
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <aik@au1.ibm.com>;
	Fri, 2 Dec 2011 05:05:14 +1000
Message-ID: <4ED85CE6.6070607@au1.ibm.com>
Date: Fri, 02 Dec 2011 16:06:46 +1100
From: Alexey Kardashevskiy <aik@au1.ibm.com>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>
CC: chrisw@sous-sol.org, pmac@au1.ibm.com, dwg@au1.ibm.com,
	joerg.roedel@amd.com, agraf@suse.de, benve@cisco.com,
	aafabbri@cisco.com, B08248@freescale.com, B07421@freescale.com,
	avi@redhat.com, konrad.wilk@oracle.com, kvm@vger.kernel.org,
	qemu-devel@nongnu.org, iommu@lists.linux-foundation.org,
	linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH] vfio: VFIO Driver core framework
References: <20111103195452.21259.93021.stgit@bling.home>   <4ED43AD9.5090509@au1.ibm.com> <1322538366.19120.122.camel@bling.home>  <4ED460BE.1070504@au1.ibm.com> <1322545697.19120.188.camel@bling.home>
In-Reply-To: <1322545697.19120.188.camel@bling.home>
Content-Type: text/plain; charset=KOI8-R
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 29/11/11 16:48, Alex Williamson wrote:
> On Tue, 2011-11-29 at 15:34 +1100, Alexey Kardashevskiy wrote:
>> Hi!
>>
>> On 29/11/11 14:46, Alex Williamson wrote:
>>> On Tue, 2011-11-29 at 12:52 +1100, Alexey Kardashevskiy wrote:
>>>> Hi!
>>>>
>>>> I tried (successfully) to run it on POWER and while doing that I found some issues. I'll try to
>>>> explain them in separate mails.
>>>
>>> Great!
>>>
>>>> IOMMU domain setup. On POWER, the linux drivers capable of DMA transfer want to know
>>>> a DMA window, i.e. its start and length in the PHB address space. This comes from
>>>> hardware. On X86 (correct if I am wrong), every device driver in the guest allocates
>>>> memory from the same pool.
>>>
>>> Yes, current VT-d/AMD-Vi provide independent IOVA spaces for each
>>> device.
>>>
>>>>  On POWER, device drivers get DMA window and allocate pages
>>>> for DMA within this window. In the case of VFIO, that means that QEMU has to
>>>> preallocate this DMA window before running a quest, pass it to a guest (via
>>>> device tree) and then a guest tells the host what pages are taken/released by
>>>> calling map/unmap callbacks of iommu_ops. Deallocation is made in a device detach
>>>> callback as I did not want to add more ioctls.
>>>> So, there are 2 patches:
>>>>
>>>> - new VFIO_IOMMU_SETUP ioctl introduced which allocates a DMA window via IOMMU API on
>>>> POWER.
>>>> btw do we need an additional capability bit for it?
>>>>
>>>> KERNEL PATCH:
>>>>
>>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>>> index 10615ad..a882e08 100644
>>>> --- a/drivers/iommu/iommu.c
>>>> +++ b/drivers/iommu/iommu.c
>>>> @@ -247,3 +247,12 @@ int iommu_device_group(struct device *dev, unsigned int *groupid)
>>>>  	return -ENODEV;
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(iommu_device_group);
>>>> +
>>>> +int iommu_setup(struct iommu_domain *domain,
>>>> +		size_t requested_size, size_t *allocated_size,
>>>> +		phys_addr_t *start_address)
>>>> +{
>>>> +	return domain->ops->setup(domain, requested_size, allocated_size,
>>>> +			start_address);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(iommu_setup);
>>>
>>> requested_size seems redundant both here and in struct vfio_setup.  We
>>> can just pre-load size/start with desired values.  I assume x86 IOMMUs
>>> would ignore requested values and return start = 0 and size = hardware
>>> decoder address bits.  The IOMMU API currently allows:
>>>
>>> iommu_domain_alloc
>>> [iommu_attach_device]
>>> [iommu_map]
>>> [iommu_unmap]
>>> [iommu_detach_device]
>>> iommu_domain_free
>>>
>>> where everything between alloc and free can be called in any order.  How
>>> does setup fit into that model?
>>
>> This is why I posted a QEMU patch :)
> 
> Right, but qemu/vfio is by no means the defacto standard of how one must
> use the IOMMU API.  KVM currently orders the map vs attach differently.
> When is it valid to call setup when factoring in hot attached/detached
> devices?
> 


>>> For this it seems like we'd almost want
>>> to combine alloc, setup, and the first attach into a single call (ie.
>>> create a domain with this initial device and these parameters), then
>>> subsequent attaches would only allow compatible devices.
>>
>>
>> Not exactly. This setup is more likely to get combined with domain alloc only.
> 
> At domain_alloc we don't have any association to actual hardware other
> than a bus_type, how would you know which iommu is being setup?


Yes. This is exact problem. We do have preallocated PEs (aka groups) on POWER but cannot
use this information during setup until the first device is attached.

Generally speaking, we should not be adding devices to an IOMMU domain, we should be adding groups
instead as it is the smallest entity which IOMMU can handle. At least in API, it is better to have
as simple as the idea it is implementing.

For example, we could implement a tool to put devices into a group (at the moment on POWER it would
check that a domain has no more than just a single group in it). We could pass this group ID to QEMU
instead of passing "-device vfio-pci ..." (as we still must pass _all_ devices of a group to QEMU).

Sure, we'll have change VFIO to tell QEMU what devices are included in what group, quite easy to do.

It is a tree: domain -> group -> device. Lets reflect it in the API.




>> On POWER, we have iommu_table per DMA window which can be or can be not shared
>> between devices. At the moment there is one window per PCIe _device_ (so multiple
>> functions of multiport network adapter share one DMA window) and one window for
>> all the devices behind PCIe-to-PCI bridge. It is more or less so.
>>
>>
>>> I'm a little confused though, is the window determined by hardware or is
>>> it configurable via requested_size?
>>
>>
>> The window parameters are calculated by software and then written to hardware so
>> hardware does filtering and prevents bad devices from memory corruption.
>>
>>
>>> David had suggested that we could
>>> implement a VFIO_IOMMU_GET_INFO ioctl that returns something like:
>>>
>>> struct vfio_iommu_info {
>>>         __u32   argsz;
>>>         __u32   flags;
>>>         __u64   iova_max;       /* Maximum IOVA address */
>>>         __u64   iova_min;       /* Minimum IOVA address */
>>>         __u64   pgsize_bitmap;  /* Bitmap of supported page sizes */
>>> };
>>>
>>> The thought being a TBD IOMMU API interface reports the hardware
>>> determined IOVA range and we could fudge it on x86 for now reporting
>>> 0/~0.  Maybe we should replace iova_max/iova_min with
>>> iova_base/iova_size and allow the caller to request a size by setting
>>> iova_size and matching bit in the flags.
>>
>>
>> No, we need some sort of SET_INFO, not GET as we want QEMU to decide on a DMA
>> window size.
> 
> Right, GET_INFO is no longer the right name if we're really passing in
> requests.  Maybe it becomes VFIO_IOMMU_SETUP as you suggest and it
> really is a bidirectional ioctl.



Actually these are a group properties, not of device or iommu, at least now for POWER it is so. And
they are predefined for every group. We would need "GET_INFO" for them if we had a group-based API
but we do not have it.



>> Or simply add these parameters to domain allocation callback.
> 
> Except alloc only specifies a bus_type, not a specific iommu, which is
> why we might need to think about combining {alloc, attach, setup}...
> 
> struct iommu_domain *iommu_create_domain(int nr_devs,
> 					 struct device **devs,
> 					 dma_addr_t *iova_start,
> 					 size_t *iova_size)
> 
> But then we have trouble when vfio needs to prevent device access until
> the iommu domain is setup which means that our only opportunity to
> specify iommu parameters might be to add a struct to GROUP_GET_IOMMU_FD,
> but without device access, how does qemu know how large of a window to
> request?


Somehow. Everyone gets 64mb in the simplest case or somehow more tricky.

There is a difference. On x86 you really create a new domain. On POWER (again, currently) we create
a domain which corresponds to an existing group, one group per domain, domains cannot consist of 2
or more groups (will be fixed in hardware later though).



> BTW, domain_has_cap() might be a way to advertise if the domain
> supports/requires a setup callback.


>>>> diff --git a/drivers/vfio/vfio_iommu.c b/drivers/vfio/vfio_iommu.c
>>>> index 029dae3..57fb70d 100644
>>>> --- a/drivers/vfio/vfio_iommu.c
>>>> +++ b/drivers/vfio/vfio_iommu.c
>>>> @@ -507,6 +507,23 @@ static long vfio_iommu_unl_ioctl(struct file *filep,
>>>>
>>>>  		if (!ret && copy_to_user((void __user *)arg, &dm, sizeof dm))
>>>>  			ret = -EFAULT;
>>>> +
>>>> +	} else if (cmd == VFIO_IOMMU_SETUP) {
>>>> +		struct vfio_setup setup;
>>>> +		size_t allocated_size = 0;
>>>> +		phys_addr_t start_address = 0;
>>>> +
>>>> +		if (copy_from_user(&setup, (void __user *)arg, sizeof setup))
>>>> +			return -EFAULT;
>>>> +
>>>> +		printk("udomain %p, priv=%p\n", iommu->domain, iommu->domain->priv);
>>>> +		ret = iommu_setup(iommu->domain, setup.requested_size,
>>>> +				&allocated_size, &start_address);
>>>> +		setup.allocated_size = allocated_size;
>>>> +		setup.start_address = start_address;
>>>> +
>>>> +		if (!ret && copy_to_user((void __user *)arg, &setup, sizeof setup))
>>>> +			ret = -EFAULT;
>>>>  	}
>>>>  	return ret;
>>>>  }
>>>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>>>> index 93617e7..355cf8b 100644
>>>> --- a/include/linux/iommu.h
>>>> +++ b/include/linux/iommu.h
>>>> @@ -45,6 +45,7 @@ struct iommu_domain {
>>>>
>>>>  #define IOMMU_CAP_CACHE_COHERENCY	0x1
>>>>  #define IOMMU_CAP_INTR_REMAP		0x2	/* isolates device intrs */
>>>> +#define IOMMU_CAP_SETUP_REQUIRED	0x3	/* requires setup to be called */
>>>>
>>>>  #ifdef CONFIG_IOMMU_API
>>>>
>>>> @@ -62,6 +63,9 @@ struct iommu_ops {
>>>>  	int (*domain_has_cap)(struct iommu_domain *domain,
>>>>  			      unsigned long cap);
>>>>  	int (*device_group)(struct device *dev, unsigned int *groupid);
>>>> +	int (*setup)(struct iommu_domain *domain,
>>>> +		     size_t requested_size, size_t *allocated_size,
>>>> +		     phys_addr_t *start_address);
>>>>  };
>>>>
>>>>  extern int bus_set_iommu(struct bus_type *bus, struct iommu_ops *ops);
>>>> @@ -80,6 +84,9 @@ extern phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain,
>>>>  				      unsigned long iova);
>>>>  extern int iommu_domain_has_cap(struct iommu_domain *domain,
>>>>  				unsigned long cap);
>>>> +extern int iommu_setup(struct iommu_domain *domain,
>>>> +		       size_t requested_size, size_t *allocated_size,
>>>> +		       phys_addr_t *start_address);
>>>>  extern void iommu_set_fault_handler(struct iommu_domain *domain,
>>>>  					iommu_fault_handler_t handler);
>>>>  extern int iommu_device_group(struct device *dev, unsigned int *groupid);
>>>> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
>>>> index 971e3b1..5e0ee75 100644
>>>> --- a/include/linux/vfio.h
>>>> +++ b/include/linux/vfio.h
>>>> @@ -26,6 +26,7 @@
>>>>   * Author: Michael S. Tsirkin <mst@redhat.com>
>>>>   */
>>>>  #include <linux/types.h>
>>>> +#include <linux/ioctl.h>
>>>>
>>>>  #ifndef VFIO_H
>>>>  #define VFIO_H
>>>> @@ -172,4 +173,13 @@ enum {
>>>>  	VFIO_PCI_NUM_IRQS
>>>>  };
>>>>
>>>> +/* Setup domain */
>>>> +#define VFIO_IOMMU_SETUP		_IOWR(';', 150, struct vfio_setup)
>>>> +
>>>> +struct vfio_setup {
>>>> +	__u64	requested_size;
>>>> +	__u64	allocated_size;
>>>> +	__u64	start_address;
>>>> +};
>>>> +
>>>>   #endif /* VFIO_H */
>>>>
>>>> === end ===
>>>>
>>>>
>>>> QEMU PATCH:
>>>>
>>>> diff --git a/hw/linux-vfio.h b/hw/linux-vfio.h
>>>> index ac48d85..a2c719f 100644
>>>> --- a/hw/linux-vfio.h
>>>> +++ b/hw/linux-vfio.h
>>>> @@ -172,4 +172,13 @@ enum {
>>>>  	VFIO_PCI_NUM_IRQS
>>>>  };
>>>>
>>>> +/* Setup domain */
>>>> +#define VFIO_IOMMU_SETUP                _IOWR(';', 150, struct vfio_setup)
>>>> +
>>>> +struct vfio_setup {
>>>> +	__u64   requested_size;
>>>> +	__u64   allocated_size;
>>>> +	__u64   start_address;
>>>> +};
>>>> +
>>>>  #endif /* VFIO_H */
>>>> diff --git a/hw/vfio_pci.c b/hw/vfio_pci.c
>>>> index 1c97c35..b438bbe 100644
>>>> --- a/hw/vfio_pci.c
>>>> +++ b/hw/vfio_pci.c
>>>> @@ -1501,6 +1503,17 @@ static int vfio_initfn(struct PCIDevice *pdev)
>>>>      if (vfio_map_resources(vdev))
>>>>          goto out_disable_msi;
>>>>
>>>> +    struct vfio_setup setup = { 1 << 26, 0, 0 };
>>>
>>> How will qemu decide how much to ask for?
>>
>>
>> It is done by some heuristic. Like "usb controller needs 16mb" and "10Gb card
>> needs more than 100mbit". I'd think that POWER-specific code in QEMU would decide.
>> As POWER supports multiple PCI domains, it can afford spending addresses :)
>>
>>
>>
>>>> +    if ((ret =  ioctl(vdev->group->iommu->fd, VFIO_IOMMU_SETUP, &setup))) {
>>>> +        return ret;
>>>> +    }
>>>> +    printf("SETUP: requested %lluMB, allocated %lluMB at %llx\n",
>>>> +        (unsigned long long)setup.requested_size,
>>>> +        (unsigned long long)setup.allocated_size,
>>>> +        (unsigned long long)setup.start_address);
>>>> +    vdev->start_address = setup.start_address;
>>>> +    vdev->window_size = setup.allocated_size;
>>>> +
>>>>      if (vfio_enable_intx(vdev))
>>>>          goto out_unmap_resources;
>>>>
>>>> diff --git a/hw/vfio_pci.h b/hw/vfio_pci.h
>>>> index 96b09bb..6b7ab6f 100644
>>>> --- a/hw/vfio_pci.h
>>>> +++ b/hw/vfio_pci.h
>>>> @@ -79,6 +79,10 @@ typedef struct VFIODevice {
>>>>      bool msix;
>>>>      uint8_t msix_bar;
>>>>      uint16_t msix_entries;
>>>> +#ifdef TARGET_PPC
>>>> +    uint64_t start_address;
>>>> +    uint32_t window_size;
>>>> +#endif
>>>>  } VFIODevice;
>>>>
>>>>  typedef struct VFIOGroup {
>>>>
>>>> === end ===
>>>>
>>>>
>>>>
>>>> - changed __vfio_close_iommu function to do unmapall first and detach devices then
>>>> as actual deallocation happens on device detach callback of IOMMU ops.
>>>>
>>>> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
>>>> index 6169356..f78f411 100644
>>>> --- a/drivers/vfio/vfio_main.c
>>>> +++ b/drivers/vfio/vfio_main.c
>>>> @@ -28,6 +28,7 @@
>>>>  #include <linux/uaccess.h>
>>>>  #include <linux/vfio.h>
>>>>  #include <linux/wait.h>
>>>> +#include <linux/pci.h>
>>>>
>>>>  #include "vfio_private.h"
>>>>
>>>> @@ -242,6 +243,13 @@ static void __vfio_close_iommu(struct vfio_iommu *iommu)
>>>>  	if (!iommu->domain)
>>>>  		return;
>>>>
>>>> +	/*
>>>> +	 * On POWER, device detaching (which is done by __vfio_iommu_detach_group)
>>>> +	 * should happen after all pages unmapped because
>>>> +	 * the only way to do actual iommu_unmap_page a device detach callback
>>>> +	 */
>>>> +	vfio_iommu_unmapall(iommu);
>>>> +
>>>
>>> The unmapall/detach vs detach/unmapall shouldn't matter for x86.  Though
>>> I wonder if we should be proactively resetting devices before either to
>>> avoid spurious IOVA faults.
>>
>>
>> Then we need some to "shutdown" a device.
> 
> VFIO Devices expose the DEVICE_RESET ioctl, which could be exposed to
> the group via vfio_device_ops.  pci_reset_function() does a pretty good
> job of quiescing devices when it works.  I've also been wondering if we
> need a VFIO_GROUP_RESET which can call reset on each device, but also
> allow things like PCI secondary bus resets when all the devices behind a
> bridge are in a group.  For now I've deferred it as a possible future
> extension.

Right, we do not need it right now.

>> I am not sure about x86, but on POWER a host allocates DMA window (SETUP does iommu_alloc
>> so the _whole_ DMA window gets allocated), and then a guest allocates pages within this
>> window itself but it only updates the host's IOMMU table with pairs of addresses, a host
>> does not do any no actual map/unmap while guest is running.
> 
> What's the difference between "updates the host's IOMMU table with pairs
> of addresses" and map/unmap?  Your DMA window is static, but what each
> IOVA within the window points to is not, correct?

DMA window is configured in system firmware and is static in the host kernel - it has all DMA
windows (at least 32-bit windows) defined for all PEs.

64-bit windows are dynamic (a guest may ask a kernel to allocate some) and this also needs to be
taken care of (arch-specific ioctls?) but later.



> I would have assumed
> you do unmap/map to update each of those (at least David seemed to care
> about map/unmap latency).


> x86 maps the entire guest, so the only runtime map/unmaps would be when
> the memory map changes.  Typically this only happens for MMIO regions
> and odd chipset specific regions that switch between being memory backed
> or ROM backed (which we really don't care about for DMA), and
> theoretically for future memory hotplug.  At some point we're supposed
> to have devices and IOMMUs that support IO page faults, so a device can
> request an IOVA and we'd probably register a page fault handler for the
> domain to dynamically pin and map pages.
> 
>> Oooor, we could release the whole window in the domain close callback of iommu_ops...
> 
> AIUI, the iommu driver will destroy all the mappings in a domain when we
> call iommu_domain_free, but the real need for unmapall is to unpin all
> the memory.  David was suggesting maybe the pinning should happen in the
> iommu driver, which could then handle unpinning on release.  I kinda
> doubt iommu drivers want to get into the business of pinning memory
> though.  I'd actually like VFIO to get out of this business as well and
> was thinking about requiring mapped pages to be mlocked by the user, but
> it appears we have no way to later prevent or detect that the user
> munlocked the pages and might then have access to random host memory.


aaa, I had some discussion here, my implementation was a hack so this problem has gone for now.


-- 
Alexey Kardashevskiy
IBM OzLabs, LTC Team

e-mail: aik@au1.ibm.com
notes: Alexey Kardashevskiy/Australia/IBM

