Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60608 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752021AbdC0KLC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Mar 2017 06:11:02 -0400
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC PATCH 29/30] vfio: Add support for Shared Virtual Memory
To: "Liu, Yi L" <yi.l.liu@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-30-jean-philippe.brucker@arm.com>
 <A2975661238FB949B60364EF0F2C2574390206F0@shsmsx102.ccr.corp.intel.com>
 <d12a4a91-1fae-2fee-6109-3e9a1b7f5abe@arm.com>
 <A2975661238FB949B60364EF0F2C257439021F4D@shsmsx102.ccr.corp.intel.com>
 <dfc76db2-0177-e67c-49cd-03f667b1589d@arm.com>
 <A2975661238FB949B60364EF0F2C257439030135@shsmsx102.ccr.corp.intel.com>
Cc: Shanker Donthineni <shankerd@qti.qualcomm.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sinan Kaya <okaya@qti.qualcomm.com>,
        Will Deacon <will.deacon@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Harv Abdulhamid <harba@qti.qualcomm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Nate Watterson <nwatters@qti.qualcomm.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Lan, Tianyu" <tianyu.lan@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>
Message-ID: <1a63cf88-840c-0b82-3951-a83364fa72fc@arm.com>
Date: Mon, 27 Mar 2017 11:13:40 +0100
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C257439030135@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 24/03/17 07:46, Liu, Yi L wrote:
[...]
>>>>
>>>> So we need some kind of high-level classification that the vIOMMU
>>>> must communicate to the physical one. Each IOMMU flavor would get a
>>>> unique, global identifier, simply to make sure that vIOMMU and pIOMMU speak
>> the same language.
>>>> For example:
>>>>
>>>> 0x65776886 "AMDV" AMD IOMMU
>>>> 0x73788476 "INTL" Intel IOMMU
>>>> 0x83515748 "S390" s390 IOMMU
>>>> 0x83777785 "SMMU" ARM SMMU
>>>> etc.
>>>>
>>>> It needs to be a global magic number that everyone can recognize.
>>>> Could be as simple as 32-bit numbers allocated from 0. Once we have a
>>>> global magic number, we can use it to differentiate architecture-specific details.
> 
> I prefer simple numbers to stand for each vendor.

Sure, I don't have any preference. Simple numbers could be easier to allocate.

>>> I may need to think more on this part.
>>>
>>>> struct pasid_table_info {
>>>> 	__u64 ptr;
>>>> 	__u64 size;		/* Is it number of entry or size in
>>>> 				   bytes? */
>>>
>>> For Intel platform, it's encoded. But I can make it in bytes. Here,
>>> I'd like to check with you if whole guest PASID info is also needed on ARM?
>>
>> It will be needed on ARM if someone ever emulates the SMMU with SVM.
>> Though I'm not planning on doing that myself, it is unavoidable. And it would be a
>> shame for the next SVM virtualization solution to have to introduce a new flag
>> "VFIO_SVM_BIND_PASIDPT_2" if they could reuse most of the BIND_PASIDPT
>> interface but simply needed to add one or two configuration fields specific to their
>> IOMMU.
> 
> So you are totally fine with putting PASID table ptr and size in the generic part? Maybe
> we have different usage for it. For me, it's a guest PASID table ptr. For you, it may be
> different.

It's the same for SMMU, with some added format specifiers that would go in
'opaque[]'. I think that table pointer and size (in bytes, or number of
entries) is generic enough for a "bind table" call and can be reused by
future implementations.

>>>>
>>>> 	__u32 model;		/* magic number */
>>>> 	__u32 variant;		/* version of the IOMMU architecture,
>>>> 				   maybe? IOMMU-specific. */
> 
> For variant, it will be combined with model to do sanity check. Am I right?
> Maybe it could be moved to opaque.

Yes I guess it could be moved to opaque. It would be a version of the
model used, so we wouldn't have to allocate a new model number whenever an
architecture updates the fields of its PASID descriptors, but we can let
IOMMU drivers decide if they need it and what to put in there.

>>>> 	__u8 opaque[];		/* IOMMU-specific details */
>>>> };
>>>>
[...]
>>
>> Yes, that seems sensible. I could add an explicit VFIO_BIND_PASID flags to make it
>> explicit that data[] is "u32 pasid" and avoid having any default.
> 
> Add it in the comment I suppose. The length is 4 byes, it could be deduced from argsz.
> 
>>
>>>>
>>>>> #define VFIO_SVM_PASSDOWN_INVALIDATE    (1 << 1)
>>>>
>>>> Using the vfio_device_svm structure for invalidate operations is a
>>>> bit odd, it might be nicer to add a new VFIO_SVM_INVALIDATE ioctl,
>>>> that takes the above iommu_svm_tlb_invalidate_info as argument (with
>>>> an added argsz.)
>>>
>>> Agree, would add a separate IOCTL for invalidation.
>>>
>>>>
>>>>> #define VFIO_SVM_PASID_RELEASE_FLUSHED	(1 << 2)
>>>>> #define VFIO_SVM_PASID_RELEASE_CLEAN	  (1 << 3)
>>>>>        __u32   flags;
>>>>>        __u32   length;
>>>>
>>>> If length is the size of data[], I guess we can already deduce this info from argsz.
>>>
>>> yes, it is size of data. Maybe remove argsz. How about your opinion?
>>
>> Argsz as first argument is standard across all VFIO ioctls, it allows the kernel to check
>> that the structure passed by the guest is consistent with the structure it knows (see
>> the comment at the beginning of
>> include/uapi/linux/vfio.h) So argsz would be the preferred way to communicate the
>> size of data[]
> 
> yes, it makes sense. BTW. I think it is still possible to leave the "length" since there is
> similar usage. e.g. struct vfio_irq_set, count tells the size of data[] in that structure.
> Anyhow, it's no big deal here.
> 
>>>>>        __u8    data[];
>>>>> };
>>>>
>>>> In general, I think that your proposal would work fine along mine.
>>>> Note that for my next version of this patch, I would like to move the
>>>> BIND/UNBIND SVM operations onto a VFIO container fd, instead of a VFIO device
>> fd, if possible.
>>>
>>> Attach the BIND/UNBIND operation onto VFIO container fd is practical.
>>>
>>> BTW. Before you send out your next version, we'd better have a
>>> consensus on the vfio_device_svm definition. So that we can continue to drive our
>> own work separately.
>>>
>>>> ---
>>>> As an aside, it also aligns with the one I'm working on at the
>>>> moment, for virtual SVM at a finer granularity, where the BIND call
>>>> is for a page table. I would add this flag to vfio_device_svm:
>>>>
>>>> #define VFIO_SVM_BIND_PGTABLE		(1 << x)
>>>
>>> Sure. I think it may also be a requirement from other vendors. I think
>>> you've mentioned it in the above statements.
>>>
>>>> Which would indicate the following data (just a draft, I'm
>>>> oscillating between this and a generic PASID table solution, which would instead
>> reuse your proposal):
>>>>
>>>> struct pgtable_info {
>>>> 	__u32 pasid;
>>>>
>>>> 	__u64 pgd;
>>>>
>>>> 	__u32 model;
>>>> 	__u32 variant;
>>>>
>>>> 	__u8 opaque[];
>>>> };
> 
> I think you would have this definition as an ARM specific one. Would be filled in
> the data[] of vfio_device_svm. Is it?

Yes it would be another kind of data[] for vfio_device_svm.

>>>>
>>>> On ARM SMMU we would need to specify an io-pgtable variant and the
>>>> opaque structure would be bits of io_pgtable_cfg (tcr, mair, etc.)
>>>>
>>>> The problem of portability is slightly different here, because while
>>>> PASID table format is specific to an IOMMU, page table format might
>>>> be the same across multiple flavors of IOMMUs. For instance, the
>>>> PASID table format I use in this series can only be found in the ARM
>>>> SMMUv3 architecture, but the page table format is the same as ARM
>>>> SMMUv2, and other MMUs. I'd like to implement an IOMMU independent of
>>>> any page-table formats, that could use whatever the host offers (not
>>>> necessarily MMU PT). The model numbers described above wouldn't be suitable,
>> so we'd need another set of magic numbers for page table formats.
>>>
>>> Not sure if I totally got your points. We may assume PASID table
>>> format differs from vendor to vendor. For the page table format, I
>>> assume you mean the page table of process. Or in other words MMU page table.
>>>
>>> I'm a little bit confused about the following statements. Could you speak a little bit
>> more?
>>> Is it for virtual SVM or user-space driver SVM usage?
>>> " I'd like to implement an IOMMU independent of any page-table
>>> formats, that could use whatever the host offers (not necessarily MMU PT)."
>>
>> The IOMMU might be using a different page table format than the MMU. I'm
>> currently toying with the idea of having a portable paravirtualized IOMMU that can
>> query the page table format used by pIOMMU, and adopt it if the page table
>> handling code is available in the guest. This would be for non-SVM nested translation,
>> using VFIO to bind page tables private to the IOMMU. I'll send a separate RFC to
>> discuss this.
> 
> sounds interesting. Look forward to your further work.
> 
>>
>>> I's nice to have such discussion. Let's co-work and have a well-defined API.
>>
>> I agree. I don't plan to send a new version immediately since it will take some time
>> rework, but we can sync-up here or in private to avoid conflicting proposals.
> 
> yes, let's keep in touch. For "struct vfio_device_svm", how about define it in such way:
> 
> struct vfio_device_svm {
>        __u32   argsz;
>      /* data length would be sizeof(pasid_table_info) */
> #define VFIO_SVM_BIND_PASIDTP                            (1 << 0) 
>      /* data length would be 4 byte */
> #define VFIO_BIND_PASID                                           (1 << 1) 
>      /* data length would be sizeof(x) */
> #define VFIO_SVM_PASID_RELEASE_FLUSHED	 (1 << 2) 
>      /* data length would be sizeof(y) */
> #define VFIO_SVM_PASID_RELEASE_CLEAN	 (1 << 3) 

(Note that I'll probably drop these two flags in next version.)

>     /* data length would be sizeof(pgtable_info) */
> #define VFIO_SVM_BIND_PGTABLE		 (1 << 4) 
>        __u32   flags;
>        __u32   length;  /*can remove it if you think it's better */
>        __u8    data[];   /* payload data for different bind/unbind request*/
> };
> 
> struct pasid_table_info {
>                __u16 sid;             /* It's BDF of device. */
> 	__u64 ptr;            /* PASID table ptr */
> 	__u64 size;	/* PASID table size in bytes */
> 	__u32 model;	/* magic number */
> 	__u32 variant;	/* YiL: maybe move it to opaque? */

Yes, I think it could be in opaque, not all formats would need that. ptr,
size, model and opaque seem sufficient.

> 	__u8 opaque[];	/* IOMMU-specific details */
> };
> 
> I added a new field as "sid". The reason is as below:
> Since the IOCTL is going to be on container fd, then needs to tell where does
> the bind request come from. SID could be used to filter the target core IOMMU.
> Also, it's needed to find the corresponding context entry with the SID on Intel
> platform. I assume you also need an equivalent on your work. Pls let me know
> if you prefer different definition.

Actually moving the ioctl to the container changes the BIND model: the
PASID table would be attached to all devices in the container, so there
shouldn't be any device selector in the ioctl. I think it is more in line
with the existing MAP/UNMAP API, where a container represents an address
space, and all devices in the container access the same virtual addresses.
It adds complexity on the driver side, but seems more clear from the user
point of view.

Thanks,
Jean-Philippe
