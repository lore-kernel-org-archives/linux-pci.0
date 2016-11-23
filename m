Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Subject: Re: [PATCH V5 3/3] ARM64 LPC: LPC driver implementation on Hip06
Date: Wed, 23 Nov 2016 15:16:07 +0100
Message-ID: <2359248.XjnRfPbj1B@wuerfel>
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1F921A0F@lhreml507-mbx>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <2364530.A9QSbaqvfm@wuerfel>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F921A0F@lhreml507-mbx>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "liviu.dudau@arm.com" <liviu.dudau@arm.com>, Linuxarm <linuxarm@huawei.com>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "xuwei \(O\)" <xuwei5@hisilicon.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 T homas Petazzoni <thomas.petazzo.ni@free-electrons.com>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "minyard@acm.org" <minyard@acm.org>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 John Garry <john.garry@huawei.com>, "olof@lixom.net" <olof@lixom.net>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "bhelgaas@go og le.com" <bhelgaas@google.com>,
 "kantyzc@163.com" <kantyzc@163.com>,
 "zhichang.yuan02@gmail.com" <zhichang.yuan02@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Yuanzhichang <yuanzhichang@hisilicon.com>,
 "zourongrong@gmail.com" <zourongrong@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, November 18, 2016 5:03:11 PM CET Gabriele Paoloni wrote:
> > On Friday, November 18, 2016 4:18:07 PM CET Gabriele Paoloni wrote:
> > > From: Arnd Bergmann [mailto:arnd@arndb.de]
> > > > On Friday, November 18, 2016 12:53:08 PM CET Gabriele Paoloni
> > wrote:
> > > > For the ISA/LPC spaces there are only 4k of addresses, they
> > > > the bus addresses always overlap, but we can trivially
> > > > figure out the bus address from Linux I/O port number
> > > > by subtracting the start of the range.
> > >
> > > Are you saying that our LPC controller should specify a
> > > range property to map bus addresses into a cpu address range?
> > 
> > No. There is not CPU address associated with it, because it's
> > not memory mapped.
> > 
> > Instead, we need to associate a bus address with a logical
> > Linux port number, both in of_address_to_resource and
> > in inb()/outb().
> 
> I think this is effectively what we are doing so far with patch 2/3.
> The problem with this patch is that we are carving out a "forbidden"
> IO tokens range that goes from 0 to PCIBIOS_MIN_IO.
> 
> I think that the proper solution would be to have the LPC driver to
> set the carveout threshold used in pci_register_io_range(), 
> pci_pio_to_address(), pci_address_to_pio(), but this would impose
> a probe dependency on the LPC itself that should be probed before
> the PCI controller (or before any other devices calling these
> functions...)

Why do you think the order matters? My point was that we should
be able to register any region of logical port numbers for any
bus here.


> > > > > To be honest with you I would keep things simple for this
> > > > > LPC and introduce more complex reworks later if more devices
> > > > > need to be introduced.
> > > > >
> > > > > What if we stick on a single domain now where we introduce a
> > > > > reserved threshold for the IO space (say INDIRECT_MAX_IO).
> > > >
> > > > I said having a single domain is fine, but I still don't
> > > > like the idea of reserving low port numbers for this hack,
> > > > it would mean that the numbers change for everyone else.
> > >
> > > I don't get this much...I/O tokens that are passed to the I/O
> > > accessors are not fixed anyway and they vary depending on the order
> > > of adding ranges to io_range_list...so I don't see a big issue
> > > with this...
> > 
> > On machines with a legacy devices behind the PCI bridge,
> > there may still be a reason to have the low I/O port range
> > reserved for the primary bus, e.g. to get a VGA text console
> > to work.
> > 
> > On powerpc, this is called the "primary" PCI host, i.e. the
> > only one that is allowed to have an ISA bridge.
> 
> Yes but
> 1) isn't the PCI controller range property that defines how IO bus address
>    map into physical CPU addresses?

Correct, but the DT knows nothing about logical port numbers in Linux.

> 2) How can you guarantee that the cpu range associated with this
>    IO bus range is the first to be registered in pci_register_io_range()?
>    ( i.e. are you saying that they are just relying on the fact that it is the
>      only IO range in the system and by chance the IO tokens and corresponding
>      bus addresses are the same? )

To clarify: the special properties of having the first 0x1000 logical
port numbers go to a particular physical bus are very obscure. I think
it's more important to not change the behavior for existing systems
that might rely on it than for new systems that have no such legacy.

The ipmi and uart drivers in particular will get the port numbers filled
in their platform device from the DT bus scanning, so they don't care
at all about having the same numeric value for port numbers on the bus
and logical numbers, but other drivers might rely on particular ports
to be mapped on a specific PCI host, especially when those drivers
are  used only on systems that don't have more than one PCI domain.

	Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
