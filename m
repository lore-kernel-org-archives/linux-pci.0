Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:65335 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932982AbcKWRIb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2016 12:08:31 -0500
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
        T homas Petazzoni <thomas.petazzo.ni@free-electrons.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yuanzhichang <yuanzhichang@hisilicon.com>,
        "olof@lixom.net" <olof@lixom.net>
Subject: Re: [PATCH V5 3/3] ARM64 LPC: LPC driver implementation on Hip06
Date: Wed, 23 Nov 2016 18:07:11 +0100
Message-ID: <2168980.T3HadihU3R@wuerfel>
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1F931E08@lhreml507-mbx>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com> <2359248.XjnRfPbj1B@wuerfel> <EE11001F9E5DDD47B7634E2F8A612F2E1F931E08@lhreml507-mbx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, November 23, 2016 3:22:33 PM CET Gabriele Paoloni wrote:
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> > On Friday, November 18, 2016 5:03:11 PM CET Gabriele Paoloni wrote:

> > > I think this is effectively what we are doing so far with patch 2/3.
> > > The problem with this patch is that we are carving out a "forbidden"
> > > IO tokens range that goes from 0 to PCIBIOS_MIN_IO.
> > >
> > > I think that the proper solution would be to have the LPC driver to
> > > set the carveout threshold used in pci_register_io_range(),
> > > pci_pio_to_address(), pci_address_to_pio(), but this would impose
> > > a probe dependency on the LPC itself that should be probed before
> > > the PCI controller (or before any other devices calling these
> > > functions...)
> > 
> > Why do you think the order matters? My point was that we should
> > be able to register any region of logical port numbers for any
> > bus here.
> 
> Maybe I have not followed well so let's roll back to your previous
> comment...
> 
> "we need to associate a bus address with a logical Linux port number,
> both in of_address_to_resource and in inb()/outb()"
> 
> Actually of_address_to_resource() returns the port number to used
> in inb/outb(); inb() and outb() add the port number to PCI_IOBASE
> to rd/wr to the right virtual address.

Correct.

> Our LPC cannot operate on the virtual address and it operates on
> a bus address range that for LPC is also equal to the cpu address
> range and goes from 0 to 0x1000.

There is no "cpu address" here, otherwise this is correct.

> Now as I understand it is risky and not appropriate to reserve
> the logical port numbers from 0 to 0x1000 or to whatever other
> upper bound because existing systems may rely on these port numbers
> retrieved by __of_address_to_resource().

Right again.

> In this scenario I think the best thing to do would be
> in the probe function of the LPC driver:
> 1) call pci_register_io_range() passing [0, 0x1000] (that is the
>    range for LPC)

pci_register_io_range() takes a physical address, not a port number,
so that would not be appropriate as you say above. We can however
add a variant that reserves a range of port numbers in io_range_list
for an indirect access method.

> 2) retrieve the logical port numbers associated to the LPC range
>    by calling pci_address_to_pio() for 0 and 0x1000 and assign
>    them to extio_ops_node->start and extio_ops_node->end

Again, calling pci_address_to_pio() doesn't seem right here, because
we don't have a phys_addr_t address

> 3) implement the LPC accessors to operate on the logical ports
>    associated to the LPC range (in practice in the accessors
>    implementation we will call pci_pio_to_address to retrieve
>    the cpu address to operate on)

Please don't proliferate the use of
pci_pio_to_address/pci_address_to_pio here, computing the physical
address from the logical address is trivial, you just need to
subtract the start of the range that you already use when matching
the port number range.

The only thing we need here is to make of_address_to_resource()
return the correct logical port number that was registered for
a given host device when asked to translate an address that
does not have a CPU address associated with it.

	Arnd
