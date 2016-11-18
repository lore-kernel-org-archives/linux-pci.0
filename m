Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:63570 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751665AbcKRNnw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2016 08:43:52 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "liviu.dudau@arm.com" <liviu.dudau@arm.com>,
        Linuxarm <linuxarm@huawei.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "xuwei (O)" <xuwei5@hisilicon.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "minyard@acm.org" <minyard@acm.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        John Garry <john.garry@huawei.com>,
        "zourongrong@gmail.com" <zourongrong@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bhelgaas@go og le.com" <bhelgaas@google.com>,
        "kantyzc@163.com" <kantyzc@163.com>,
        "zhichang.yuan02@gmail.com" <zhichang.yuan02@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yuanzhichang <yuanzhichang@hisilicon.com>,
        "olof@lixom.net" <olof@lixom.net>
Subject: Re: [PATCH V5 3/3] ARM64 LPC: LPC driver implementation on Hip06
Date: Fri, 18 Nov 2016 14:42:38 +0100
Message-ID: <2271602.GoSoby0zHK@wuerfel>
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1F921283@lhreml507-mbx>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com> <2822893.F0LqNAm9bT@wuerfel> <EE11001F9E5DDD47B7634E2F8A612F2E1F921283@lhreml507-mbx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, November 18, 2016 12:53:08 PM CET Gabriele Paoloni wrote:
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> > On Friday, November 18, 2016 12:07:28 PM CET Gabriele Paoloni wrote:
> > > > I think there is no need to change a) here, we have PCIBIOS_MIN_IO
> > > > today and even if we don't need it, there is no obvious downside.
> > > > I would also argue that we can ignore b) for the discussion of
> > > > the HiSilicon LPC driver, we just need to assign some range
> > > > of logical addresses to each domain.
> > > >
> > > > That means solving c) is the important problem here, and it
> > > > shouldn't be so hard.  We can do this either with a single
> > > > special domain as in the v5 patch series, or by generalizing it
> > > > so that any I/O space mapping gets looked up through the device
> > > > pointer of the bus master.
> > >
> > > I am not very on the "generalized" multi-domain solution...
> > > Currently the IO accessors prototypes have an unsigned long addr
> > > as input parameter. If we live in a multi-domain IO system
> > > how can we distinguish inside the accessor which domain addr
> > > belongs to?
> > 
> > The easiest change compared to the v5 code would be to walk
> > a linked list of 'struct extio_ops' structures rather than
> > assuming there is only ever one of them. I think one of the
> > earlier versions actually did this.
> 
> Right but if my understanding is correct if we live in a multi-
> domain I/O space world when you have an input addr in the I/O
> accessors this addr can be duplicated (for example for the standard
> PCI IO domain and for our special LPC domain).
> So effectively even if you walk a linked list there is a problem
> of disambiguation...am I right? 

No, unlike the PCI memory space, the PIO addresses are not
usually distinct, i.e. every PCI bus has its own 64K I/O
addresses starting at zero. We linearize them into the
Linux I/O space using the per-domain io_offset value.

For the ISA/LPC spaces there are only 4k of addresses, they
the bus addresses always overlap, but we can trivially
figure out the bus address from Linux I/O port number
by subtracting the start of the range.

> > Another option the IA64 approach mentioned in another subthread
> > today, looking up the operations based on an index from the
> > upper bits of the port number. If we do this, we probably
> > want to do that for all PIO access and replace the entire
> > virtual address remapping logic with that. I think Bjorn
> > in the past argued in favor of such an approach, while I
> > advocated the current scheme for simplicity based on how
> > every I/O space these days is just memory mapped (which now
> > turned out to be false, both on powerpc and arm64).
> 
> This seems really complex...I am a bit worried that possibly
> we end up in having the maintainers saying that it is not worth
> to re-invent the world just for this special LPC device...

It would clearly be a rather invasive change, but the
end-result isn't necessarily more complex than what we
have today, as we'd kill off the crazy pci_pio_to_address()
and pci_address_to_pio() hacks in address translation.

> To be honest with you I would keep things simple for this
> LPC and introduce more complex reworks later if more devices
> need to be introduced.
> 
> What if we stick on a single domain now where we introduce a
> reserved threshold for the IO space (say INDIRECT_MAX_IO).

I said having a single domain is fine, but I still don't
like the idea of reserving low port numbers for this hack,
it would mean that the numbers change for everyone else.

> We define INDIRECT_MAX_IO as 0 in "include/linux/extio.h" and
> we define INDIRECT_MAX_IO as 0x1000 in "arch/arm64/include/asm/io.h"
> 
> So effectively this threshold can change according to the
> architecture and so far we only define it for ARM64 as we need
> it for ARM64...

I liked the idea of having it done in asm-generic/io.h (in an ifdef)
and lib/*.c under an as someone suggested earlier. There is nothing
ARM64 specific in the implementation.

	Arnd
