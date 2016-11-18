Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:56441 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751965AbcKRQgO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2016 11:36:14 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
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
        Thomas Petazzoni <thomas.petazzo.ni@free-electrons.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yuanzhichang <yuanzhichang@hisilicon.com>,
        "olof@lixom.net" <olof@lixom.net>
Subject: Re: [PATCH V5 3/3] ARM64 LPC: LPC driver implementation on Hip06
Date: Fri, 18 Nov 2016 17:34:45 +0100
Message-ID: <2364530.A9QSbaqvfm@wuerfel>
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1F921858@lhreml507-mbx>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com> <2271602.GoSoby0zHK@wuerfel> <EE11001F9E5DDD47B7634E2F8A612F2E1F921858@lhreml507-mbx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, November 18, 2016 4:18:07 PM CET Gabriele Paoloni wrote:
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> > On Friday, November 18, 2016 12:53:08 PM CET Gabriele Paoloni wrote:
> > > From: Arnd Bergmann [mailto:arnd@arndb.de]
> > > > On Friday, November 18, 2016 12:07:28 PM CET Gabriele Paoloni
> > > > The easiest change compared to the v5 code would be to walk
> > > > a linked list of 'struct extio_ops' structures rather than
> > > > assuming there is only ever one of them. I think one of the
> > > > earlier versions actually did this.
> > >
> > > Right but if my understanding is correct if we live in a multi-
> > > domain I/O space world when you have an input addr in the I/O
> > > accessors this addr can be duplicated (for example for the standard
> > > PCI IO domain and for our special LPC domain).
> > > So effectively even if you walk a linked list there is a problem
> > > of disambiguation...am I right?
> > 
> > No, unlike the PCI memory space, the PIO addresses are not
> > usually distinct, i.e. every PCI bus has its own 64K I/O
> > addresses starting at zero. We linearize them into the
> > Linux I/O space using the per-domain io_offset value.
> 
> I am going to summarize my understanding here below:
> 
> It seems to me that what is linearized is the virtual address
> space associated to the IO address space. This address space
> goes from PCI_IOBASE to (PCI_IOBASE + IO_SPACE_LIMIT).
> 
> The I/O accessors perform rd/wr operation on this address
> space using a port IO token.
> 
> Each token map into a cpu physical address range
> Each cpu physical address range maps to a bus address range
> if the bus controller specifies a range property.
> 
> Devices under a bus controller specify the bus addresses that
> they operate on in their reg property.
> 
> So each device can use the same bus addresses under two
> separate bus controllers as long as the bus controller
> use the range properties to map the same bus range to different
> cpu address range. 

Sounds all correct to me so far, yes.

> > For the ISA/LPC spaces there are only 4k of addresses, they
> > the bus addresses always overlap, but we can trivially
> > figure out the bus address from Linux I/O port number
> > by subtracting the start of the range.
> 
> Are you saying that our LPC controller should specify a
> range property to map bus addresses into a cpu address range? 

No. There is not CPU address associated with it, because it's
not memory mapped.

Instead, we need to associate a bus address with a logical
Linux port number, both in of_address_to_resource and
in inb()/outb().

> > > > Another option the IA64 approach mentioned in another subthread
> > > > today, looking up the operations based on an index from the
> > > > upper bits of the port number. If we do this, we probably
> > > > want to do that for all PIO access and replace the entire
> > > > virtual address remapping logic with that. I think Bjorn
> > > > in the past argued in favor of such an approach, while I
> > > > advocated the current scheme for simplicity based on how
> > > > every I/O space these days is just memory mapped (which now
> > > > turned out to be false, both on powerpc and arm64).
> > >
> > > This seems really complex...I am a bit worried that possibly
> > > we end up in having the maintainers saying that it is not worth
> > > to re-invent the world just for this special LPC device...
> > 
> > It would clearly be a rather invasive change, but the
> > end-result isn't necessarily more complex than what we
> > have today, as we'd kill off the crazy pci_pio_to_address()
> > and pci_address_to_pio() hacks in address translation.
> 
> I have to look better into this...can you provide me a reference
> to the Bjorn argument in favor of this approach?

The thread seems to have been pci: Introduce pci_register_io_range()
helper function, e.g. in https://lkml.org/lkml/2014/7/8/969

> > > To be honest with you I would keep things simple for this
> > > LPC and introduce more complex reworks later if more devices
> > > need to be introduced.
> > >
> > > What if we stick on a single domain now where we introduce a
> > > reserved threshold for the IO space (say INDIRECT_MAX_IO).
> > 
> > I said having a single domain is fine, but I still don't
> > like the idea of reserving low port numbers for this hack,
> > it would mean that the numbers change for everyone else.
> 
> I don't get this much...I/O tokens that are passed to the I/O
> accessors are not fixed anyway and they vary depending on the order
> of adding ranges to io_range_list...so I don't see a big issue
> with this...

On machines with a legacy devices behind the PCI bridge,
there may still be a reason to have the low I/O port range
reserved for the primary bus, e.g. to get a VGA text console
to work.

On powerpc, this is called the "primary" PCI host, i.e. the
only one that is allowed to have an ISA bridge.

	Arnd
