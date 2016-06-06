Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:35538 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764AbcFFQE3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jun 2016 12:04:29 -0400
Received: by mail-vk0-f49.google.com with SMTP id d127so205696333vkh.2
        for <linux-pci@vger.kernel.org>; Mon, 06 Jun 2016 09:04:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <df81dd53-dc03-667e-4d53-3c67f90aab8f@cn.fujitsu.com>
References: <20151213212557.5410.48577.stgit@localhost.localdomain>
 <20160104204104.GB17427@char.us.oracle.com> <CAKgT0UenF-Cj2fvFPEmY0g7FOf=85HbFJ9iFUjs4KgsaXrckqA@mail.gmail.com>
 <20160105113317-mutt-send-email-mst@redhat.com> <CAKgT0UeY9+BJoGtM+Fqa4Zve36GBJQpYVyoo2CPJZdELH6cEbg@mail.gmail.com>
 <df81dd53-dc03-667e-4d53-3c67f90aab8f@cn.fujitsu.com>
From: Alex Duyck <aduyck@mirantis.com>
Date: Mon, 6 Jun 2016 09:04:27 -0700
Message-ID: <CAMt9YRpzAKt1KQW17VBzx0PT5BxiL_1+U1-AEK2A_Ao9KQjmGg@mail.gmail.com>
Subject: Re: Re: [Qemu-devel] [RFC PATCH 0/3] x86: Add support for guest DMA
 dirty page tracking
To: Zhou Jie <zhoujie2011@cn.fujitsu.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Lan Tianyu <tianyu.lan@intel.com>,
	Yang Zhang <yang.zhang.wz@gmail.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	kvm@vger.kernel.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	x86@kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 6, 2016 at 2:18 AM, Zhou Jie <zhoujie2011@cn.fujitsu.com> wrote:
> Hi Alex,
>
>
> On 2016/1/6 0:18, Alexander Duyck wrote:
>>
>> On Tue, Jan 5, 2016 at 1:40 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>
>>> On Mon, Jan 04, 2016 at 07:11:25PM -0800, Alexander Duyck wrote:
>>>>>>
>>>>>> The two mechanisms referenced above would likely require coordination
>>>>>> with
>>>>>> QEMU and as such are open to discussion.  I haven't attempted to
>>>>>> address
>>>>>> them as I am not sure there is a consensus as of yet.  My personal
>>>>>> preference would be to add a vendor-specific configuration block to
>>>>>> the
>>>>>> emulated pci-bridge interfaces created by QEMU that would allow us to
>>>>>> essentially extend shpc to support guest live migration with
>>>>>> pass-through
>>>>>> devices.
>>>>>
>>>>>
>>>>> shpc?
>>>>
>>>>
>>>> That is kind of what I was thinking.  We basically need some mechanism
>>>> to allow for the host to ask the device to quiesce.  It has been
>>>> proposed to possibly even look at something like an ACPI interface
>>>> since I know ACPI is used by QEMU to manage hot-plug in the standard
>>>> case.
>>>>
>>>> - Alex
>>>
>>>
>>>
>>> Start by using hot-unplug for this!
>>>
>>> Really use your patch guest side, and write host side
>>> to allow starting migration with the device, but
>>> defer completing it.
>>
>>
>> Yeah, I'm fully on board with this idea, though I'm not really working
>> on this right now since last I knew the folks on this thread from
>> Intel were working on it.  My patches were mostly meant to be a nudge
>> in this direction so that we could get away from the driver specific
>> code.
>
>
> I have seen your email about live migration.
>
> I conclude the idea you proposed as following.
> 1. Extend swiotlb to allow for a page dirtying functionality.
> 2. Use pci express capability to implement of a PCI bridge to act
>    as a bridge between direct assigned devices and the host bridge.
> 3. Using APCI event or extend shpc driver to support device pause.
> Is it right?
>
> Will you implement the patchs for live migration?

That is pretty much the heart of the proposal I had.  I submitted an
RFC as a proof-of-concept for item 1 in the hopes that someone else
might try tackling items 2 and 3 but I haven't seen any updates since
then.  The trick is to find a way to make it so that item 1 doesn't
slow down standard SWIOTLB when you are not migrating a VM. If nothing
else we would probably just need to add a static key that we could
default to false unless there is a PCI bridge indicating we are
starting a migration.

I haven't had time to really work on this though. In addition I am not
that familiar with QEMU and the internals of live migration so pieces
2 and 3 would take me some additional time to work on.

- Alex
