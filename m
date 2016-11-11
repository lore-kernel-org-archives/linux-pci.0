Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:7773 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932511AbcKKKHa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2016 05:07:30 -0500
Subject: Re: [PATCH V5 1/3] ARM64 LPC: Indirect ISA port IO introduced
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <1478576829-112707-2-git-send-email-yuanzhichang@hisilicon.com>
 <20161108120323.GC15297@leverpostej>
 <1478647002.7430.69.camel@kernel.crashing.org>
 <20161110112224.GB4418@leverpostej>
 <1478806353.7430.137.camel@kernel.crashing.org>
CC: <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <robh+dt@kernel.org>, <bhelgaas@google.com>, <olof@lixom.net>,
        <arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>,
        <lorenzo.pieralisi@arm.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <minyard@acm.org>, <liviu.dudau@arm.com>, <zourongrong@gmail.com>,
        <john.garry@huawei.com>, <gabriele.paoloni@huawei.com>,
        <zhichang.yuan02@gmail.com>, <kantyzc@163.com>,
        <xuwei5@hisilicon.com>, <marc.zyngier@arm.com>
From: "zhichang.yuan" <yuanzhichang@hisilicon.com>
Message-ID: <5825984B.3030303@hisilicon.com>
Date: Fri, 11 Nov 2016 18:07:07 +0800
MIME-Version: 1.0
In-Reply-To: <1478806353.7430.137.camel@kernel.crashing.org>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi, Ben, Mark,

Thanks for your comments! These are helpful!


On 2016/11/11 3:32, Benjamin Herrenschmidt wrote:
> On Thu, 2016-11-10 at 11:22 +0000, Mark Rutland wrote:
>> On POWER8, our PCIe doesn't do IO at all, but we have an LPC bus behind
>>> firmware calls ;-) We use that infrastructure to plumb in the LPC bus.
>>
>> Just to check, do you hook that in your inb/outb/etc?
> 
> Yes.
> 
>> Generally, it would seem nicer if we could have higher-level
>> isa_{inb,outb,whatever} accessors that we could hook separately from
>> other IO.
> 
> Maybe but generally speaking, we don't discriminate accessors per bus,
> ie, readl etc... work on all memory mapped busses, inb... works on all
> busses with an "IO space", at least that's been the idea. It probably
> all comes from the fact that PCI IO and ISA are the same space on
> x86 and most other platforms (not all).
> 
>> We don't necessarily have to move all ISA drivers over to that if we had
>> a separate symbol for that interface.
> 
> What I do on ppc today is that I have a chunk of virtual address space
> that is reserved for "IO space". The first 64k are "reserved" in that
> they route to "the primary" ISA bus (for legacy crap that uses hard
> coded addresses, though I use that for my LPC bus too). I "allocate"
> space for the PCI IO spaces higher in that space. Was I to support more
> LPC busses I could allocate them up there too.
>

I have similar idea as your PPC MMIO.

We notice the prototype of {in/out()} is something like that:

static inline u8 inb(unsigned long addr)
static inline void outb(u8 value, unsigned long addr)

The type of parameter 'addr' is unsigned long. For I/O space, it is big enough.
So, could you divide this 'addr' into several bit segments? The top 8 bits is
defined as bus index. For normal direct IO, the bus index is 0. For those bus
device which need indirectIO or some special I/O accessors, when these devices
are initializing, can request to allocate an unique ID to them, and register
their own accessors to the entry which is corresponding to the ID.

In this way, we can support multiple domains, I think.
But I am not sure whether it is feasible, for example, are there some
architectures/platforms had populated the top 8 bits? Do we need to request IO
region from ioport_resource for those devices?  etc...


Thanks,
Zhichang


> The IO resource of a given device thus becomes the actual IO port plus
> the offset of the base of the segment it's in.
> 
> For memory mapped IO, inb/outb will just add the virtual address of
> the base of all IO space to that. The hooking mechanism will pickup
> the stuff that isn't memory mapped.
> 
> It's a bit messy but then IO space performance has never been a huge
> worry since IO cycles tend to be very slow to begin with.
> 
> Note: We also have the ISA memory and ISA FW spaces that we don't have
> good accessors for. They somewhat exist (I think the fbdev layer uses
> some for vga) but it's messy.
> 
> Cheers,
> Ben.
> 
> 
> .
> 

