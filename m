Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:4183 "EHLO
        lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752804AbcKRMIV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2016 07:08:21 -0500
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Arnd Bergmann <arnd@arndb.de>,
        "liviu.dudau@arm.com" <liviu.dudau@arm.com>
CC: "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Yuanzhichang <yuanzhichang@hisilicon.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "minyard@acm.org" <minyard@acm.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        John Garry <john.garry@huawei.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xuwei (O)" <xuwei5@hisilicon.com>, Linuxarm <linuxarm@huawei.com>,
        "zourongrong@gmail.com" <zourongrong@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kantyzc@163.com" <kantyzc@163.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "bhelgaas@go ogle.com" <bhelgaas@google.com>,
        "zhichang.yuan02@gmail.com" <zhichang.yuan02@gmail.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: RE: [PATCH V5 3/3] ARM64 LPC: LPC driver implementation on Hip06
Date: Fri, 18 Nov 2016 12:07:28 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F921146@lhreml507-mbx>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F90EA45@lhreml507-mbx>
 <20161114112625.GO10219@e106497-lin.cambridge.arm.com>
 <2281986.miqFuFkAbO@wuerfel>
In-Reply-To: <2281986.miqFuFkAbO@wuerfel>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd many thanks for your help here

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: 18 November 2016 10:18
> To: liviu.dudau@arm.com
> Cc: Gabriele Paoloni; linux-arm-kernel@lists.infradead.org;
> Yuanzhichang; mark.rutland@arm.com; devicetree@vger.kernel.org;
> lorenzo.pieralisi@arm.com; minyard@acm.org; linux-pci@vger.kernel.org;
> benh@kernel.crashing.org; John Garry; will.deacon@arm.com; linux-
> kernel@vger.kernel.org; xuwei (O); Linuxarm; zourongrong@gmail.com;
> robh+dt@kernel.org; kantyzc@163.com; linux-serial@vger.kernel.org;
> catalin.marinas@arm.com; olof@lixom.net; bhelgaas@go ogle.com;
> zhichang.yuan02@gmail.com; Jason Gunthorpe; Thomas Petazzoni
> Subject: Re: [PATCH V5 3/3] ARM64 LPC: LPC driver implementation on
> Hip06
> 
> On Monday, November 14, 2016 11:26:25 AM CET liviu.dudau@arm.com wrote:
> > On Mon, Nov 14, 2016 at 08:26:42AM +0000, Gabriele Paoloni wrote:
> > > > Nope, that is not what it means. It means that PCI devices can
> see I/O
> > > > addresses
> > > > on the bus that start from 0. There never was any usage for non-
> PCI
> > > > controllers
> > >
> > > So I am a bit confused...
> > > From http://www.firmware.org/1275/bindings/isa/isa0_4d.ps
> > > It seems that ISA buses operate on cpu I/O address range [0,
> 0xFFF].
> > > I thought that was the reason why for most architectures we have
> > > PCIBIOS_MIN_IO equal to 0x1000 (so I thought that ISA controllers
> > > usually use [0, PCIBIOS_MIN_IO - 1] )
> >
> > First of all, cpu I/O addresses is an x86-ism. ARM architectures and
> others
> >  have no separate address space for I/O, it is all merged into one
> unified
> > address space. So, on arm/arm64 for example, PCIBIOS_MIN_IO = 0 could
> mean
> > that we don't care about ISA I/O because the platform does not
> support having
> > an ISA bus (e.g.).
> 
> I think to be more specific, PCIBIOS_MIN_IO=0 would indicate that you
> cannot
> have a PCI-to-ISA or PCI-to-LPC bridge in any PCI domain. This is
> different
> from having an LPC master outside of PCI, as that lives in its own
> domain
> and has a separately addressable I/O space.

Yes correct so if we go for the single domain solution arch that
have PCIBIOS_MIN_IO=0 cannot support special devices such as LPC
unless we also redefine PCIBIOS_MIN_IO, right?

> 
> > > As said before this series forbid IO tokens to be in [0,
> PCIBIOS_MIN_IO)
> > > to allow special ISA controllers to use that range with special
> > > accessors.
> > > Having a variable threshold would make life much more difficult
> > > as there would be a probe dependency between the PCI controller and
> > > the special ISA one (PCI to wait for the special ISA device to be
> > > probed and set the right threshold value from DT or ACPI table).
> > >
> > > Instead using PCIBIOS_MIN_IO is easier and should not impose much
> > > constraint as [PCIBIOS_MIN_IO, IO_SPACE_LIMIT] is available to
> > > the PCI controller for I/O tokens...
> >
> > What I am suggesting is to leave PCIBIOS_MIN_IO alone which still
> reserves
> > space for ISA controller and add a PCIBIOS_MIN_DIRECT_IO that will
> reserve
> > space for your direct address I/O on top of PCIBIOS_MIN_IO.
> 
> The PCIBIOS_MIN_DIRECT_IO name still suggests having something related
> to
> PCIBIOS_MIN_IO, but it really isn't. We are talking about multiple
> concepts here that are not the same but that are somewhat related:
> 
> a) keeping PCI devices from allocating low I/O ports on the PCI bus
>    that would conflict with ISA devices behind a bridge of the
>    same bus.
> 
> b) reserving the low 0x0-0xfff range of the Linux-internal I/O
>    space abstraction to a particular LPC or PCI domain to make
>    legacy device drivers work that hardcode a particular port
>    number.
> 
> c) Redirecting inb/outb to call a domain-specific accessor function
>    rather than doing the normal MMIO window for an LPC master or
>    more generally any arbitrary LPC or PCI domain that has a
>    nonstandard I/O space.
>    [side note: actually if we generalized this, we could avoid
>     assigning an MMIO range for the I/O space on the pci-mvebu
>     driver, and that would help free up some other remapping
>     windows]
> 
> I think there is no need to change a) here, we have PCIBIOS_MIN_IO
> today and even if we don't need it, there is no obvious downside.
> I would also argue that we can ignore b) for the discussion of
> the HiSilicon LPC driver, we just need to assign some range
> of logical addresses to each domain.
> 
> That means solving c) is the important problem here, and it
> shouldn't be so hard.  We can do this either with a single
> special domain as in the v5 patch series, or by generalizing it
> so that any I/O space mapping gets looked up through the device
> pointer of the bus master.

I am not very on the "generalized" multi-domain solution...
Currently the IO accessors prototypes have an unsigned long addr
as input parameter. If we live in a multi-domain IO system
how can we distinguish inside the accessor which domain addr
belongs to?

Thanks

Gab

> 
> 	Arnd
