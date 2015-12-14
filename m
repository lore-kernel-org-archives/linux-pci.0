Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35221 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbbLNFWp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Dec 2015 00:22:45 -0500
Subject: Re: [RFC PATCH 0/3] x86: Add support for guest DMA dirty page
 tracking
To: Alexander Duyck <alexander.duyck@gmail.com>
References: <20151213212557.5410.48577.stgit@localhost.localdomain>
 <566E2917.7050705@gmail.com>
 <CAKgT0Uf6ZFRkKFfWzDJPhKqPYD9mXEWR6jpXgVR9DpZYugDOCg@mail.gmail.com>
Cc: Alexander Duyck <aduyck@mirantis.com>, kvm@vger.kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	x86@kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	qemu-devel@nongnu.org, Lan Tianyu <tianyu.lan@intel.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, konrad.wilk@oracle.com,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Alexander Graf <agraf@suse.de>,
	Alex Williamson <alex.williamson@redhat.com>
From: Yang Zhang <yang.zhang.wz@gmail.com>
Message-ID: <566E521F.5090103@gmail.com>
Date: Mon, 14 Dec 2015 13:22:39 +0800
MIME-Version: 1.0
In-Reply-To: <CAKgT0Uf6ZFRkKFfWzDJPhKqPYD9mXEWR6jpXgVR9DpZYugDOCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/12/14 12:54, Alexander Duyck wrote:
> On Sun, Dec 13, 2015 at 6:27 PM, Yang Zhang <yang.zhang.wz@gmail.com> wrote:
>> On 2015/12/14 5:28, Alexander Duyck wrote:
>>>
>>> This patch set is meant to be the guest side code for a proof of concept
>>> involving leaving pass-through devices in the guest during the warm-up
>>> phase of guest live migration.  In order to accomplish this I have added a
>>> new function called dma_mark_dirty that will mark the pages associated
>>> with
>>> the DMA transaction as dirty in the case of either an unmap or a
>>> sync_.*_for_cpu where the DMA direction is either DMA_FROM_DEVICE or
>>> DMA_BIDIRECTIONAL.  The pass-through device must still be removed before
>>> the stop-and-copy phase, however allowing the device to be present should
>>> significantly improve the performance of the guest during the warm-up
>>> period.
>>>
>>> This current implementation is very preliminary and there are number of
>>> items still missing.  Specifically in order to make this a more complete
>>> solution we need to support:
>>> 1.  Notifying hypervisor that drivers are dirtying DMA pages received
>>> 2.  Bypassing page dirtying when it is not needed.
>>>
>>
>> Shouldn't current log dirty mechanism already cover them?
>
> The guest has no way of currently knowing that the hypervisor is doing
> dirty page logging, and the log dirty mechanism currently has no way
> of tracking device DMA accesses.  This change is meant to bridge the
> two so that the guest device driver will force the SWIOTLB DMA API to
> mark pages written to by the device as dirty.

OK. This is what we called "dummy write mechanism". Actually, this is 
just a workaround before iommu dirty bit ready. Eventually, we need to 
change to use the hardware dirty bit. Besides, we may still lost the 
data if dma happens during/just before stop and copy phase.

>
>>> The two mechanisms referenced above would likely require coordination with
>>> QEMU and as such are open to discussion.  I haven't attempted to address
>>> them as I am not sure there is a consensus as of yet.  My personal
>>> preference would be to add a vendor-specific configuration block to the
>>> emulated pci-bridge interfaces created by QEMU that would allow us to
>>> essentially extend shpc to support guest live migration with pass-through
>>> devices.
>>>
>>> The functionality in this patch set is currently disabled by default.  To
>>> enable it you can select "SWIOTLB page dirtying" from the "Processor type
>>> and features" menu.
>>
>>
>> Only SWIOTLB is supported?
>
> Yes.  For right now this only supports SWIOTLB.  The assumption here
> is that SWIOTLB is in use for most cases where an IOMMU is not
> present.  If an IOMMU is present in a virtualized guest then most
> likely the IOMMU might be able to provide a separate mechanism for
> dirty page tracking.
>
> - Alex
>


-- 
best regards
yang
