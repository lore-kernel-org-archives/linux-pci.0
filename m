Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <554FCE21.7060208@redhat.com>
Date: Sun, 10 May 2015 17:31:13 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Dave Young <dyoung@redhat.com>
CC: Baoquan He <bhe@redhat.com>, "Li, ZhenHua" <zhen-hual@hp.com>,
	dwmw2@infradead.org, indou.takao@jp.fujitsu.com, joro@8bytes.org,
	vgoyal@redhat.com, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	kexec@lists.infradead.org, alex.williamson@redhat.com,
	ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com,
	doug.hatch@hp.com, jerry.hoemann@hp.com, tom.vaden@hp.com,
	li.zhang6@hp.com, lisa.mitchell@hp.com, billsumnerlinux@gmail.com,
	rwright@hp.com
Subject: Re: [PATCH v9 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
References: <1426743388-26908-1-git-send-email-zhen-hual@hp.com> <20150403084031.GF22579@dhcp-128-53.nay.redhat.com> <551E56F6.60503@hp.com> <20150403092111.GG22579@dhcp-128-53.nay.redhat.com> <20150405015453.GB1562@dhcp-17-102.nay.redhat.com> <20150407034622.GB7213@localhost.localdomain> <5523E5DB.2090001@redhat.com> <20150507140029.GC4559@localhost.localdomain>
In-Reply-To: <20150507140029.GC4559@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/07/2015 10:00 AM, Dave Young wrote:
> On 04/07/15 at 10:12am, Don Dutile wrote:
>> On 04/06/2015 11:46 PM, Dave Young wrote:
>>> On 04/05/15 at 09:54am, Baoquan He wrote:
>>>> On 04/03/15 at 05:21pm, Dave Young wrote:
>>>>> On 04/03/15 at 05:01pm, Li, ZhenHua wrote:
>>>>>> Hi Dave,
>>>>>>
>>>>>> There may be some possibilities that the old iommu data is corrupted by
>>>>>> some other modules. Currently we do not have a better solution for the
>>>>>> dmar faults.
>>>>>>
>>>>>> But I think when this happens, we need to fix the module that corrupted
>>>>>> the old iommu data. I once met a similar problem in normal kernel, the
>>>>>> queue used by the qi_* functions was written again by another module.
>>>>>> The fix was in that module, not in iommu module.
>>>>>
>>>>> It is too late, there will be no chance to save vmcore then.
>>>>>
>>>>> Also if it is possible to continue corrupt other area of oldmem because
>>>>> of using old iommu tables then it will cause more problems.
>>>>>
>>>>> So I think the tables at least need some verifycation before being used.
>>>>>
>>>>
>>>> Yes, it's a good thinking anout this and verification is also an
>>>> interesting idea. kexec/kdump do a sha256 calculation on loaded kernel
>>>> and then verify this again when panic happens in purgatory. This checks
>>>> whether any code stomps into region reserved for kexec/kernel and corrupt
>>>> the loaded kernel.
>>>>
>>>> If this is decided to do it should be an enhancement to current
>>>> patchset but not a approach change. Since this patchset is going very
>>>> close to point as maintainers expected maybe this can be merged firstly,
>>>> then think about enhancement. After all without this patchset vt-d often
>>>> raised error message, hung.
>>>
>>> It does not convince me, we should do it right at the beginning instead of
>>> introduce something wrong.
>>>
>>> I wonder why the old dma can not be remap to a specific page in kdump kernel
>>> so that it will not corrupt more memory. But I may missed something, I will
>>> looking for old threads and catch up.
>>>
>>> Thanks
>>> Dave
>>>
>> The (only) issue is not corruption, but once the iommu is re-configured, the old,
>> not-stopped-yet, dma engines will use iova's that will generate dmar faults, which
>> will be enabled when the iommu is re-configured (even to a single/simple paging scheme)
>> in the kexec kernel.
>>
>
> Don, so if iommu is not reconfigured then these faults will not happen?
>
> Baoquan and me has a confusion below today about iommu=off/intel_iommu=off:
>
> intel_iommu_init()
> {
> ...
>
>         dmar_table_init();
>
>         disable active iommu translations;
>
>         if (no_iommu || dmar_disabled)
>                  goto out_free_dmar;
>
> ...
> }
>
> Any reason not move no_iommu check to the begining of intel_iommu_init function?
>
> Thanks
> Dave
Looks like you could.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

