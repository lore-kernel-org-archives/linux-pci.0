Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54]:36419 "EHLO
	g4t3426.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932417AbbD1JB0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 Apr 2015 05:01:26 -0400
Message-ID: <553F4C2C.30707@hp.com>
Date: Tue, 28 Apr 2015 17:00:28 +0800
From: "Li, ZhenHua" <zhen-hual@hp.com>
MIME-Version: 1.0
To: Baoquan He <bhe@redhat.com>
CC: Dave Young <dyoung@redhat.com>, dwmw2@infradead.org,
	indou.takao@jp.fujitsu.com, joro@8bytes.org, vgoyal@redhat.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kexec@lists.infradead.org,
	alex.williamson@redhat.com, ddutile@redhat.com,
	ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com,
	doug.hatch@hp.com, jerry.hoemann@hp.com, tom.vaden@hp.com,
	li.zhang6@hp.com, lisa.mitchell@hp.com, billsumnerlinux@gmail.com,
	rwright@hp.com, "Li, ZhenHua" <zhen-hual@hp.com>
Subject: Re: [PATCH v10 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
References: <1428655333-19504-1-git-send-email-zhen-hual@hp.com> <20150415005731.GC19051@localhost.localdomain> <552DFB56.1070600@hp.com> <20150415064803.GF19051@localhost.localdomain> <20150424080147.GC4458@dhcp-16-116.nay.redhat.com> <20150424082528.GA23912@dhcp-128-91.nay.redhat.com> <20150424083530.GD4458@dhcp-16-116.nay.redhat.com> <20150424084957.GC23912@dhcp-128-91.nay.redhat.com> <20150428085441.GI15033@dhcp-16-116.nay.redhat.com>
In-Reply-To: <20150428085441.GI15033@dhcp-16-116.nay.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Baoquan,

If old tables are corrupted, we will see the DMAR faults or INTR faults
(which we have seen), or some other error messages. Most of these
messages are from hardware. This means, hardware will do some check when 
running. But I don't think hardware will completely check the
tables.

Till now, I do not have a good idea to do the check in kdump kernel.


Thanks
Zhenhua


On 04/28/2015 04:54 PM, Baoquan He wrote:
> On 04/24/15 at 04:49pm, Dave Young wrote:
>> On 04/24/15 at 04:35pm, Baoquan He wrote:
>>> On 04/24/15 at 04:25pm, Dave Young wrote:
>>>> Hi, Baoquan
>>>>
>>>>> I support this patchset.
>>>>>
>>>>> We should not fear oldmem since reserved crashkernel region is similar.
>>>>> No one can guarantee that any crazy code won't step into crashkernel
>>>>> region just because 1st kernel says it's reversed for kdump kernel. Here
>>>>> the root table and context tables are also not built to allow legal code
>>>>> to danamge. Both of them has the risk to be corrupted, for trying our
>>>>> best to get a dumped vmcore the risk is worth being taken.
>>>>
>>>> old mem is mapped in 1st kernel so compare with the reserved crashkernel
>>>> they are more likely to be corrupted. they are totally different.
>>>
>>> Could you tell how and why they are different? Wrong code will choose
>>> root tables and context tables to danamge when they totally lose
>>> control?
>>
>> iommu will map io address to system ram, right? not to reserved ram, but
>> yes I'm assuming the page table is right, but I was worrying they are corrupted
>> while kernel panic is happening.
>
> OK, I think we may need to think more about the old context tables
> reuse. Currently dmar faults will cause error or warning message,
> occasionally will cause system with iommu hang in kdump kernel. I don't
> know what will happen if old root tables or context tables are corrupted
> by evil code. For kdump kernel which use the similar mechanism there's a
> verification. When load kdump kernel into reserved crashkernel region a
> sha256 sum is calculated, then verify it when jump into kdump kernel
> after panic. If corrupted context tables will bring worse result, then
> we need consider giving it up and change back to the old way and try
> to dump though there's error message.
>
> Hi Zhenhua,
>
> I don't know what's your plan about verification whether old root tables
> or old context tables are corrupted. Or have you experimented that what
> will happen if old tables are corrupted on purpose.
>
> I am fine if you just put this in a TODO list since that's truly in a
> rare case. But it maybe necessary to tell it in patch log.
>
> Thanks
> Baoquan
>

