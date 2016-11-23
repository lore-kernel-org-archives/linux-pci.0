Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:4405 "EHLO
        lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938854AbcKWPYG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2016 10:24:06 -0500
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "liviu.dudau@arm.com" <liviu.dudau@arm.com>,
        Linuxarm <linuxarm@huawei.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "xuwei (O)" <xuwei5@hisilicon.com>,
        "Jason Gunthorpe" <jgunthorpe@obsidianresearch.com>,
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
        T homas Petazzoni <thomas.petazzo.ni@free-electrons.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yuanzhichang <yuanzhichang@hisilicon.com>,
        "olof@lixom.net" <olof@lixom.net>
Subject: RE: [PATCH V5 3/3] ARM64 LPC: LPC driver implementation on Hip06
Date: Wed, 23 Nov 2016 15:22:33 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F931E08@lhreml507-mbx>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <2364530.A9QSbaqvfm@wuerfel>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F921A0F@lhreml507-mbx>
 <2359248.XjnRfPbj1B@wuerfel>
In-Reply-To: <2359248.XjnRfPbj1B@wuerfel>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: 23 November 2016 14:16
> To: Gabriele Paoloni
> Cc: linux-arm-kernel@lists.infradead.org; mark.rutland@arm.com;
> benh@kernel.crashing.org; catalin.marinas@arm.com; liviu.dudau@arm.com;
> Linuxarm; lorenzo.pieralisi@arm.com; xuwei (O); Jason Gunthorpe; linux-
> serial@vger.kernel.org; linux-pci@vger.kernel.org;
> devicetree@vger.kernel.org; minyard@acm.org; will.deacon@arm.com; John
> Garry; zourongrong@gmail.com; robh+dt@kernel.org; bhelgaas@go og
> le.com; kantyzc@163.com; zhichang.yuan02@gmail.com; T homas Petazzoni;
> linux-kernel@vger.kernel.org; Yuanzhichang; olof@lixom.net
> Subject: Re: [PATCH V5 3/3] ARM64 LPC: LPC driver implementation on
> Hip06
> 
> On Friday, November 18, 2016 5:03:11 PM CET Gabriele Paoloni wrote:
> > > On Friday, November 18, 2016 4:18:07 PM CET Gabriele Paoloni wrote:
> > > > From: Arnd Bergmann [mailto:arnd@arndb.de]
> > > > > On Friday, November 18, 2016 12:53:08 PM CET Gabriele Paoloni
> > > wrote:
> > > > > For the ISA/LPC spaces there are only 4k of addresses, they
> > > > > the bus addresses always overlap, but we can trivially
> > > > > figure out the bus address from Linux I/O port number
> > > > > by subtracting the start of the range.
> > > >
> > > > Are you saying that our LPC controller should specify a
> > > > range property to map bus addresses into a cpu address range?
> > >
> > > No. There is not CPU address associated with it, because it's
> > > not memory mapped.
> > >
> > > Instead, we need to associate a bus address with a logical
> > > Linux port number, both in of_address_to_resource and
> > > in inb()/outb().
> >
> > I think this is effectively what we are doing so far with patch 2/3.
> > The problem with this patch is that we are carving out a "forbidden"
> > IO tokens range that goes from 0 to PCIBIOS_MIN_IO.
> >
> > I think that the proper solution would be to have the LPC driver to
> > set the carveout threshold used in pci_register_io_range(),
> > pci_pio_to_address(), pci_address_to_pio(), but this would impose
> > a probe dependency on the LPC itself that should be probed before
> > the PCI controller (or before any other devices calling these
> > functions...)
> 
> Why do you think the order matters? My point was that we should
> be able to register any region of logical port numbers for any
> bus here.

Maybe I have not followed well so let's roll back to your previous
comment...

"we need to associate a bus address with a logical Linux port number,
both in of_address_to_resource and in inb()/outb()"

Actually of_address_to_resource() returns the port number to used
in inb/outb(); inb() and outb() add the port number to PCI_IOBASE
to rd/wr to the right virtual address.

Our LPC cannot operate on the virtual address and it operates on
a bus address range that for LPC is also equal to the cpu address
range and goes from 0 to 0x1000.

Now as I understand it is risky and not appropriate to reserve
the logical port numbers from 0 to 0x1000 or to whatever other
upper bound because existing systems may rely on these port numbers
retrieved by __of_address_to_resource().

In this scenario I think the best thing to do would be
in the probe function of the LPC driver:
1) call pci_register_io_range() passing [0, 0x1000] (that is the
   range for LPC)
2) retrieve the logical port numbers associated to the LPC range
   by calling pci_address_to_pio() for 0 and 0x1000 and assign
   them to extio_ops_node->start and extio_ops_node->end
3) implement the LPC accessors to operate on the logical ports
   associated to the LPC range (in practice in the accessors
   implementation we will call pci_pio_to_address to retrieve
   the cpu address to operate on)

What do you think?

Thanks

Gab


> 
>
> > > > > > To be honest with you I would keep things simple for this
> > > > > > LPC and introduce more complex reworks later if more devices
> > > > > > need to be introduced.
> > > > > >
> > > > > > What if we stick on a single domain now where we introduce a
> > > > > > reserved threshold for the IO space (say INDIRECT_MAX_IO).
> > > > >
> > > > > I said having a single domain is fine, but I still don't
> > > > > like the idea of reserving low port numbers for this hack,
> > > > > it would mean that the numbers change for everyone else.
> > > >
> > > > I don't get this much...I/O tokens that are passed to the I/O
> > > > accessors are not fixed anyway and they vary depending on the
> order
> > > > of adding ranges to io_range_list...so I don't see a big issue
> > > > with this...
> > >
> > > On machines with a legacy devices behind the PCI bridge,
> > > there may still be a reason to have the low I/O port range
> > > reserved for the primary bus, e.g. to get a VGA text console
> > > to work.
> > >
> > > On powerpc, this is called the "primary" PCI host, i.e. the
> > > only one that is allowed to have an ISA bridge.
> >
> > Yes but
> > 1) isn't the PCI controller range property that defines how IO bus
> address
> >    map into physical CPU addresses?
> 
> Correct, but the DT knows nothing about logical port numbers in Linux.
> 
> > 2) How can you guarantee that the cpu range associated with this
> >    IO bus range is the first to be registered in
> pci_register_io_range()?
> >    ( i.e. are you saying that they are just relying on the fact that
> it is the
> >      only IO range in the system and by chance the IO tokens and
> corresponding
> >      bus addresses are the same? )
> 
> To clarify: the special properties of having the first 0x1000 logical
> port numbers go to a particular physical bus are very obscure. I think
> it's more important to not change the behavior for existing systems
> that might rely on it than for new systems that have no such legacy.
> 
> The ipmi and uart drivers in particular will get the port numbers
> filled
> in their platform device from the DT bus scanning, so they don't care
> at all about having the same numeric value for port numbers on the bus
> and logical numbers, but other drivers might rely on particular ports
> to be mapped on a specific PCI host, especially when those drivers
> are  used only on systems that don't have more than one PCI domain.
> 
> 	Arnd
