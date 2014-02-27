Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	linaro-kernel <linaro-kernel@lists.linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] pci: OF: Fix the conversion of IO ranges into IO resources.
Date: Thu, 27 Feb 2014 21:22:12 +0100
Message-ID: <11097076.0C13zaKdYD@wuerfel>
In-Reply-To: <20140227200729.GB7773@obsidianresearch.com>
References: <1393506402-11474-1-git-send-email-Liviu.Dudau@arm.com> <5379319.g8IPYmY2Zo@wuerfel> <20140227200729.GB7773@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 27 February 2014 13:07:29 Jason Gunthorpe wrote:
> On Thu, Feb 27, 2014 at 08:48:08PM +0100, Arnd Bergmann wrote:
> > > It also looks correct for architectures that use the CPU MMIO address
> > > as the IO address directly (where IO_SPACE_LIMIT would be 4G)
> > 
> > Are you aware of any that still do? I thought we had stopped doing
> > that.
> 
> I thought ia64 used to, but it has been a long time since I've touched
> one...

They have a different way of doing it now, no idea how it looked in
the past:

#define IO_SPACE_LIMIT          0xffffffffffffffffUL

#define MAX_IO_SPACES_BITS              8
#define MAX_IO_SPACES                   (1UL << MAX_IO_SPACES_BITS)
#define IO_SPACE_BITS                   24
#define IO_SPACE_SIZE                   (1UL << IO_SPACE_BITS)

#define IO_SPACE_NR(port)               ((port) >> IO_SPACE_BITS)
#define IO_SPACE_BASE(space)            ((space) << IO_SPACE_BITS)
#define IO_SPACE_PORT(port)             ((port) & (IO_SPACE_SIZE - 1))

#define IO_SPACE_SPARSE_ENCODING(p)     ((((p) >> 2) << 12) | ((p) & 0xfff))

So their port number is a logical token that contains the I/O space number
and a 16MB offset.

Apparently sparc64 uses physical memory addressing for I/O space, the
same way they do for memory space, and they just set IO_SPACE_LIMIT to
0xffffffffffffffffUL.

> > > Architectures that use the virtual IO window technique will always
> > > require a custom pci_address_to_pio implementation.
> > 
> > Hmm, at the moment we only call it from of_address_to_resource(),
> > which in turn does not get called on PCI devices, and does not
> > call pci_address_to_pio for 'simple' platform devices. The only
> > case I can think of where it actually matters is when we have
> > ISA devices in DT that use an I/O port address in the reg property,
> > and that case hopefully won't happen on ARM32 or ARM64.
> 
> Sure, I ment, after Liviu's patch it will become required since he is
> cleverly using it to figure out what the io mapping the bridge driver
> setup before calling the helper.

Ok. I was arguing more that we should add this dependency.

> > > I think the legacy reasons for having all those layers of translation
> > > are probably not applicable to ARM64, and it is much simpler without
> > > the extra translation step....
> > > 
> > > Arnd, what do you think?
> > 
> > Either I don't like it or I misunderstand you ;-)
> > 
> > Most PCI drivers normally don't call ioport_map or pci_iomap, so
> > we can't just do it there. If you are thinking of calling ioport_map
> 
> Okay, that was one of the 'legacy reasons'. Certainly lots of drivers
> do call pci_iomap, but if you think legacy drivers that don't are
> important to ARM64 then it makes sense to use the virtual IO window.

I think all uses of I/O space are legacy, but I don't think that
drivers doing inb/outb are more obsolete than those doing pci_iomap.
It's got more to do with the subsystem requirements, e.g. libata
requires the use of pci_iomap.

> > for every PCI device that has an I/O BAR and storing the virtual
> > address in the pci_dev resource, I don't see what that gains us
> 
> Mainly we get to drop the fancy dynamic allocation stuff for the fixed
> virtual window, and it gives the option to have a 1:1 relationship
> between CPU addresses and PCI BARs.

I don't think the allocation is much of a problem, as long as we
can localize it in one function that is shared by everyone.
The problems I saw were all about explaining to people how it
works, but they really shouldn't have to know.


	Arnd
