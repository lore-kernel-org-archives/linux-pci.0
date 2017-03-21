Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [RFC PATCH 29/30] vfio: Add support for Shared Virtual Memory
To: "Liu, Yi L" <yi.l.liu@intel.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-30-jean-philippe.brucker@arm.com>
 <A2975661238FB949B60364EF0F2C2574390206F0@shsmsx102.ccr.corp.intel.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <d12a4a91-1fae-2fee-6109-3e9a1b7f5abe@arm.com>
Date: Tue, 21 Mar 2017 19:37:56 +0000
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C2574390206F0@shsmsx102.ccr.corp.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "Lan, Tianyu" <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Shanker Donthineni <shankerd@qti.qualcomm.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Sinan Kaya <okaya@qti.qualcomm.com>, Will Deacon <will.deacon@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Harv Abdulhamid <harba@qti.qualcomm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Nate Watterson <nwatters@qti.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 21/03/17 07:04, Liu, Yi L wrote:
> Hi Jean,
> 
> I'm working on virtual SVM, and have some comments on the VFIO channel
> definition.

Thanks a lot for the comments, this is quite interesting to me. I just
have some concerns about portability so I'm proposing a way to be slightly
more generic below.

>> -----Original Message-----
>> From: iommu-bounces@lists.linux-foundation.org [mailto:iommu-
>> bounces@lists.linux-foundation.org] On Behalf Of Jean-Philippe Brucker
>> Sent: Tuesday, February 28, 2017 3:55 AM
>> Cc: Shanker Donthineni <shankerd@qti.qualcomm.com>; kvm@vger.kernel.org;
>> Catalin Marinas <catalin.marinas@arm.com>; Sinan Kaya
>> <okaya@qti.qualcomm.com>; Will Deacon <will.deacon@arm.com>;
>> iommu@lists.linux-foundation.org; Harv Abdulhamid <harba@qti.qualcomm.com>;
>> linux-pci@vger.kernel.org; Bjorn Helgaas <bhelgaas@google.com>; David
>> Woodhouse <dwmw2@infradead.org>; linux-arm-kernel@lists.infradead.org; Nate
>> Watterson <nwatters@qti.qualcomm.com>
>> Subject: [RFC PATCH 29/30] vfio: Add support for Shared Virtual Memory
>>
>> Add two new ioctl for VFIO devices. VFIO_DEVICE_BIND_TASK creates a bond
>> between a device and a process address space, identified by a device-specific ID
>> named PASID. This allows the device to target DMA transactions at the process
>> virtual addresses without a need for mapping and unmapping buffers explicitly in the
>> IOMMU. The process page tables are shared with the IOMMU, and mechanisms such
>> as PCI ATS/PRI may be used to handle faults. VFIO_DEVICE_UNBIND_TASK removed
>> a bond identified by a PASID.
>>
>> Also add a capability flag in device info to detect whether the system and the device
>> support SVM.
>>
>> Users need to specify the state of a PASID when unbinding, with flags
>> VFIO_PASID_RELEASE_FLUSHED and VFIO_PASID_RELEASE_CLEAN. Even for PCI,
>> PASID invalidation is specific to each device and only partially covered by the
>> specification:
>>
>> * Device must have an implementation-defined mechanism for stopping the
>>   use of a PASID. When this mechanism finishes, the device has stopped
>>   issuing transactions for this PASID and all transactions for this PASID
>>   have been flushed to the IOMMU.
>>
>> * Device may either wait for all outstanding PRI requests for this PASID
>>   to finish, or issue a Stop Marker message, a barrier that separates PRI
>>   requests affecting this instance of the PASID from PRI requests
>>   affecting the next instance. In the first case, we say that the PASID is
>>   "clean", in the second case it is "flushed" (and the IOMMU has to wait
>>   for the Stop Marker before reassigning the PASID.)
>>
>> We expect similar distinctions for platform devices. Ideally there should be a callback
>> for each PCI device, allowing the IOMMU to ask the device to stop using a PASID.
>> When the callback returns, the PASID is either flushed or clean and the return value
>> tells which.
>>
>> For the moment I don't know how to implement this callback for PCI, so if the user
>> forgets to call unbind with either "clean" or "flushed", the PASID is never reused. For
>> platform devices, it might be simpler to implement since we could associate an
>> invalidate_pasid callback to a DT compatible string, as is currently done for reset.
>>
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> 
> [...]
> 
>>  drivers/vfio/pci/vfio_pci.c |  24 ++++++++++
>>  drivers/vfio/vfio.c         | 104 ++++++++++++++++++++++++++++++++++++++++++++
>>  include/uapi/linux/vfio.h   |  55 +++++++++++++++++++++++
>>  3 files changed, 183 insertions(+)
>>
> ...
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h index
>> 519eff362c1c..3fe4197a5ea0 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -198,6 +198,7 @@ struct vfio_device_info {
>>  #define VFIO_DEVICE_FLAGS_PCI	(1 << 1)	/* vfio-pci device */
>>  #define VFIO_DEVICE_FLAGS_PLATFORM (1 << 2)	/* vfio-platform device */
>>  #define VFIO_DEVICE_FLAGS_AMBA  (1 << 3)	/* vfio-amba device */
>> +#define VFIO_DEVICE_FLAGS_SVM	(1 << 4)	/* Device supports bind/unbind */
>>  	__u32	num_regions;	/* Max region index + 1 */
>>  	__u32	num_irqs;	/* Max IRQ index + 1 */
>>  };
>> @@ -409,6 +410,60 @@ struct vfio_irq_set {
>>   */
>>  #define VFIO_DEVICE_RESET		_IO(VFIO_TYPE, VFIO_BASE + 11)
>>
>> +struct vfio_device_svm {
>> +	__u32	argsz;
>> +	__u32	flags;
>> +#define VFIO_SVM_PASID_RELEASE_FLUSHED	(1 << 0)
>> +#define VFIO_SVM_PASID_RELEASE_CLEAN	(1 << 1)
>> +	__u32	pasid;
>> +};
> 
> For virtual SVM work, the VFIO channel would be used to passdown guest
> PASID tale PTR and invalidation information. And may have further usage
> except the above.
> 
> Here is the virtual SVM design doc which illustrates the VFIO usage.
> https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg05311.html
> 
> For the guest PASID table ptr passdown, I've following message in pseudo code.
> struct pasid_table_info {
>         __u64 ptr;
>         __u32 size;
>  };

There should probably be a way to specify the table format, so that the
pIOMMU driver can check that it recognizes the format used by the vIOMMU
before attaching it. This would allow to reuse the structure for other
IOMMU architectures. If, for instance, the host has an intel IOMMU and
someone decides to emulate an ARM SMMU with Qemu (their loss :), it can
certainly use VFIO for passing-through devices with MAP/UNMAP. But if Qemu
then attempts to passdown a PASID table in SMMU format, the Intel driver
should have a way to reject it, as the SMMU format isn't compatible.

I'm tackling a similar problem at the moment, but for passing a single
page directory instead of full PASID table to the IOMMU.

So we need some kind of high-level classification that the vIOMMU must
communicate to the physical one. Each IOMMU flavor would get a unique,
global identifier, simply to make sure that vIOMMU and pIOMMU speak the
same language. For example:

0x65776886 "AMDV" AMD IOMMU
0x73788476 "INTL" Intel IOMMU
0x83515748 "S390" s390 IOMMU
0x83777785 "SMMU" ARM SMMU
etc.

It needs to be a global magic number that everyone can recognize. Could be
as simple as 32-bit numbers allocated from 0. Once we have a global magic
number, we can use it to differentiate architecture-specific details.

struct pasid_table_info {
	__u64 ptr;
	__u64 size;		/* Is it number of entry or size in
				   bytes? */

	__u32 model;		/* magic number */
	__u32 variant;		/* version of the IOMMU architecture,
				   maybe? IOMMU-specific. */
	__u8 opaque[];		/* IOMMU-specific details */
};

And then each IOMMU or page-table code can do low-level validation of the
format, by reading the details in 'opaque'. I assume that for Intel this
would be empty. But for instance on ARM SMMUv3, PASID table can have
either one or two levels, and vIOMMU would specify which one of the three
available formats it is using.

struct pasid_table_info_smmu {
	/*
	 * In 'opaque', architecture details only the IOMMU driver should
	 * be caring about.
	 */
	__u8 s1fmt;
	__u8 s1dss;
}

If the physical SMMU doesn't implement the particular PASID table format,
it should reject the bind.

This would allow to keep architecture details outside of VFIO core (as
well as virtio in my case), and only have vIOMMU and pIOMMU understand
those details.

> 
> For invalidation, I've following info in in pseudo code.
> struct iommu_svm_tlb_invalidate_info
> {
>        __u32 inv_type;
> #define IOTLB_INV			(1 << 0)
> #define EXTENDED_IOTLB_INV		(1 << 1)
> #define DEVICE_IOTLB_INV		(1 << 2)
> #define EXTENDED_DEVICE_IOTLB_INV	(1 << 3)
> #define PASID_CACHE_INV		(1 << 4)
>        __u32 pasid;
>        __u64 addr;
>        __u64 size;
>        __u8 granularity;
> #define DEFAULT_INV_GRN        0
> #define PAGE_SELECTIVE_INV     (1 << 0)
> #define PASID_SELECVIVE_INV    (1 << 1)
>        __u64 flags;
> #define INVALIDATE_HINT_BIT    (1 << 0)
> #define GLOBAL_HINT_BIT        (1 << 1)
> #define DRAIN_READ_BIT         (1 << 2)
> #define DRAIN_WRITE_BIT        (1 << 3)
> #define DEVICE_TLB_GLOBAL_BIT  (1 << 4)
>        __u8 mip;
>        __u16 pfsid;
> };

This would also benefit from being split into generic and architectural
parts. Former would be defined in VFIO, latter would be in the IOMMU driver.

struct tlb_invalidate_info
{
	__u8 granularity
#define DEFAULT_INV_GRN		0	/* What is default? */
#define PAGE_SELECTIVE_INV	(1 << 0)
#define PASID_SELECTIVE_INV	(1 << 1)
	__u32 pasid;
	__u64 addr;
	__u64 size;

	/* Since IOMMU format has already been validated for this table,
	   the IOMMU driver knows that the following structure is in a
	   format it knows */
	__u8 opaque[];
};

struct tlb_invalidate_info_intel
{
	__u32 inv_type;
	...
	__u64 flags;
	...
	__u8 mip;
	__u16 pfsid;
};

> Although your proposal is for userspace driver SVM usage while mine is
> for  SVM usage in virtual machine, there should be a chance to make the
> channel meet our request. And I think it would be more acceptable. So I'd
> like to see your comments if we define the channel as following definition.
> If any better solution, pls feel free let me know.
> 
> struct vfio_device_svm {
>        __u32   argsz;
> #define VFIO_SVM_BIND_PASIDTP           (1 << 0)

To check we're on the same page: the absence of BIND_PASIDTP flag would
mean "bind a single PASID" and in that case, data[] would be a "u32 pasid"?

> #define VFIO_SVM_PASSDOWN_INVALIDATE    (1 << 1)

Using the vfio_device_svm structure for invalidate operations is a bit
odd, it might be nicer to add a new VFIO_SVM_INVALIDATE ioctl, that takes
the above iommu_svm_tlb_invalidate_info as argument (with an added argsz.)

> #define VFIO_SVM_PASID_RELEASE_FLUSHED	(1 << 2)
> #define VFIO_SVM_PASID_RELEASE_CLEAN	  (1 << 3)
>        __u32   flags;
>        __u32   length;

If length is the size of data[], I guess we can already deduce this info
from argsz.

>        __u8    data[];
> };

In general, I think that your proposal would work fine along mine. Note
that for my next version of this patch, I would like to move the
BIND/UNBIND SVM operations onto a VFIO container fd, instead of a VFIO
device fd, if possible.

---
As an aside, it also aligns with the one I'm working on at the moment, for
virtual SVM at a finer granularity, where the BIND call is for a page
table. I would add this flag to vfio_device_svm:

#define VFIO_SVM_BIND_PGTABLE		(1 << x)

Which would indicate the following data (just a draft, I'm oscillating
between this and a generic PASID table solution, which would instead reuse
your proposal):

struct pgtable_info {
	__u32 pasid;

	__u64 pgd;

	__u32 model;
	__u32 variant;

	__u8 opaque[];
};

On ARM SMMU we would need to specify an io-pgtable variant and the opaque
structure would be bits of io_pgtable_cfg (tcr, mair, etc.)

The problem of portability is slightly different here, because while PASID
table format is specific to an IOMMU, page table format might be the same
across multiple flavors of IOMMUs. For instance, the PASID table format I
use in this series can only be found in the ARM SMMUv3 architecture, but
the page table format is the same as ARM SMMUv2, and other MMUs. I'd like
to implement an IOMMU independent of any page-table formats, that could
use whatever the host offers (not necessarily MMU PT). The model numbers
described above wouldn't be suitable, so we'd need another set of magic
numbers for page table formats.
---

Thanks,
Jean-Philippe

>> + * VFIO_DEVICE_BIND_TASK - _IOWR(VFIO_TYPE, VFIO_BASE + 22,
>> + *                               struct vfio_device_svm)
>> + *
>> + * Share a process' virtual address space with the device.
>> + *
>> + * This feature creates a new address space for the device, which is
>> +not
>> + * affected by VFIO_IOMMU_MAP/UNMAP_DMA. Instead, the device can tag
>> +its DMA
>> + * traffic with the given @pasid to perform transactions on the
>> +associated
>> + * virtual address space. Mapping and unmapping of buffers is performed
>> +by
>> + * standard functions such as mmap and malloc.
>> + *
>> + * On success, VFIO writes a Process Address Space ID (PASID) into
>> +@pasid. This
>> + * ID is unique to a device.
>> + *
>> + * The bond between device and process must be removed with
>> + * VFIO_DEVICE_UNBIND_TASK before exiting.
>> + *
>> + * On fork, the child inherits the device fd and can use the bonds
>> +setup by its
>> + * parent. Consequently, the child has R/W access on the address spaces
>> +bound by
>> + * its parent. After an execv, the device fd is closed and the child
>> +doesn't
>> + * have access to the address space anymore.
>> + *
>> + * Availability of this feature depends on the device, its bus, the
>> +underlying
>> + * IOMMU and the CPU architecture. All of these are guaranteed when the
>> +device
>> + * has VFIO_DEVICE_FLAGS_SVM flag set.
>> + *
>> + * returns: 0 on success, -errno on failure.
>> + */
>> +#define VFIO_DEVICE_BIND_TASK	_IO(VFIO_TYPE, VFIO_BASE + 22)
>> +
>> +/*
>> + * VFIO_DEVICE_UNBIND_TASK - _IOWR(VFIO_TYPE, VFIO_BASE + 23,
>> + *                                 struct vfio_device_svm)
>> + *
>> + * Unbind address space identified by @pasid from device. Device must
>> +have
>> + * stopped issuing any DMA transaction for the PASID and flushed any
>> +reference
>> + * to this PASID upstream. Some IOMMUs need to know when a PASID is
>> +safe to
>> + * reuse, in which case one of the following must be present in @flags
>> + *
>> + * VFIO_PASID_RELEASE_FLUSHED: the PASID is safe to reassign after the IOMMU
>> + *       receives an invalidation message from the device.
>> + *
>> + * VFIO_PASID_RELEASE_CLEAN: the PASID is safe to reassign immediately.
>> + */
>> +#define VFIO_DEVICE_UNBIND_TASK	_IO(VFIO_TYPE, VFIO_BASE + 23)
>> +
>>  /*
>>   * The VFIO-PCI bus driver makes use of the following fixed region and
>>   * IRQ index mapping.  Unimplemented regions return a size of zero.
>> --
>> 2.11.0
>>
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
