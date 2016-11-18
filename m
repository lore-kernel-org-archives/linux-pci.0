Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Subject: Re: [PATCH V5 3/3] ARM64 LPC: LPC driver implementation on Hip06
Date: Fri, 18 Nov 2016 13:24:28 +0100
Message-ID: <2822893.F0LqNAm9bT@wuerfel>
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1F921146@lhreml507-mbx>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <2281986.miqFuFkAbO@wuerfel>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F921146@lhreml507-mbx>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "liviu.dudau@arm.com" <liviu.dudau@arm.com>, Linuxarm <linuxarm@huawei.com>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "xuwei \(O\)" <xuwei5@hisilicon.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "minyard@acm.org" <minyard@acm.org>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 John Garry <john.garry@huawei.com>,
 "zourongrong@gmail.com" <zourongrong@gmail.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "bhelgaas@go ogle.com" <bhelgaas@google.com>,
 "kantyzc@163.com" <kantyzc@163.com>,
 "zhichang.yuan02@gmail.com" <zhichang.yuan02@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Yuanzhichang <yuanzhichang@hisilicon.com>, "olof@lixom.net" <olof@lixom.net>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, November 18, 2016 12:07:28 PM CET Gabriele Paoloni wrote:
> > From: Arnd Bergmann [mailto:arnd@arndb.de]
> > On Monday, November 14, 2016 11:26:25 AM CET liviu.dudau@arm.com wrote:
> > > On Mon, Nov 14, 2016 at 08:26:42AM +0000, Gabriele Paoloni wrote:
> > > > > Nope, that is not what it means. It means that PCI devices can
> > see I/O
> > > > > addresses
> > > > > on the bus that start from 0. There never was any usage for non-
> > PCI
> > > > > controllers
> > > >
> > > > So I am a bit confused...
> > > > From http://www.firmware.org/1275/bindings/isa/isa0_4d.ps
> > > > It seems that ISA buses operate on cpu I/O address range [0,
> > 0xFFF].
> > > > I thought that was the reason why for most architectures we have
> > > > PCIBIOS_MIN_IO equal to 0x1000 (so I thought that ISA controllers
> > > > usually use [0, PCIBIOS_MIN_IO - 1] )
> > >
> > > First of all, cpu I/O addresses is an x86-ism. ARM architectures and
> > others
> > >  have no separate address space for I/O, it is all merged into one
> > unified
> > > address space. So, on arm/arm64 for example, PCIBIOS_MIN_IO = 0 could
> > mean
> > > that we don't care about ISA I/O because the platform does not
> > support having
> > > an ISA bus (e.g.).
> > 
> > I think to be more specific, PCIBIOS_MIN_IO=0 would indicate that you
> > cannot
> > have a PCI-to-ISA or PCI-to-LPC bridge in any PCI domain. This is
> > different
> > from having an LPC master outside of PCI, as that lives in its own
> > domain
> > and has a separately addressable I/O space.
> 
> Yes correct so if we go for the single domain solution arch that
> have PCIBIOS_MIN_IO=0 cannot support special devices such as LPC
> unless we also redefine PCIBIOS_MIN_IO, right?

This is what I was referring to below as the difference between
a) and b): Setting PCIBIOS_MIN_IO=0 means you cannot have LPC
behind PCI, but it shouldn't stop you from having a separate
LPC bridge.

> > The PCIBIOS_MIN_DIRECT_IO name still suggests having something related
> > to
> > PCIBIOS_MIN_IO, but it really isn't. We are talking about multiple
> > concepts here that are not the same but that are somewhat related:
> > 
> > a) keeping PCI devices from allocating low I/O ports on the PCI bus
> >    that would conflict with ISA devices behind a bridge of the
> >    same bus.
> > 
> > b) reserving the low 0x0-0xfff range of the Linux-internal I/O
> >    space abstraction to a particular LPC or PCI domain to make
> >    legacy device drivers work that hardcode a particular port
> >    number.
> > 
> > c) Redirecting inb/outb to call a domain-specific accessor function
> >    rather than doing the normal MMIO window for an LPC master or
> >    more generally any arbitrary LPC or PCI domain that has a
> >    nonstandard I/O space.
> >    [side note: actually if we generalized this, we could avoid
> >     assigning an MMIO range for the I/O space on the pci-mvebu
> >     driver, and that would help free up some other remapping
> >     windows]
> > 
> > I think there is no need to change a) here, we have PCIBIOS_MIN_IO
> > today and even if we don't need it, there is no obvious downside.
> > I would also argue that we can ignore b) for the discussion of
> > the HiSilicon LPC driver, we just need to assign some range
> > of logical addresses to each domain.
> > 
> > That means solving c) is the important problem here, and it
> > shouldn't be so hard.  We can do this either with a single
> > special domain as in the v5 patch series, or by generalizing it
> > so that any I/O space mapping gets looked up through the device
> > pointer of the bus master.
> 
> I am not very on the "generalized" multi-domain solution...
> Currently the IO accessors prototypes have an unsigned long addr
> as input parameter. If we live in a multi-domain IO system
> how can we distinguish inside the accessor which domain addr
> belongs to?

The easiest change compared to the v5 code would be to walk
a linked list of 'struct extio_ops' structures rather than
assuming there is only ever one of them. I think one of the
earlier versions actually did this.

Another option the IA64 approach mentioned in another subthread
today, looking up the operations based on an index from the
upper bits of the port number. If we do this, we probably
want to do that for all PIO access and replace the entire
virtual address remapping logic with that. I think Bjorn
in the past argued in favor of such an approach, while I
advocated the current scheme for simplicity based on how
every I/O space these days is just memory mapped (which now
turned out to be false, both on powerpc and arm64).

	Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
