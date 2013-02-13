Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:49117 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932120Ab3BMIYE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Feb 2013 03:24:04 -0500
Date: Wed, 13 Feb 2013 09:23:58 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	"Russell King - ARM Linux" <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	"Eran Ben-Avi" <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Tawfik Bayouk <tawfik@marvell.com>
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130213092358.4991ba43@skate>
In-Reply-To: <201302122259.54073.arnd@arndb.de>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<201302121830.11375.arnd@arndb.de>
	<20130212202252.3a9ee3d0@skate>
	<201302122259.54073.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Arnd Bergmann,

On Tue, 12 Feb 2013 22:59:53 +0000, Arnd Bergmann wrote:

> > <plat/pcie.h> is needed for a few PCIe functions shared with earlier
> > families of Marvell SoC. My plan is that once this PCI driver gets
> > accepted, I work on migrating the earlier Marvell SoC families to using
> > this PCI driver, and therefore those functions would ultimately move in
> > the driver in drivers/pci/host/, which would remove the <plat/pcie.h>.
> 
> Hmm, although it is a bit unusual, I would actually propose duplicating
> that code for now, and merging a copy into the new driver right away.
> This gets rid of the header file dependency and lets you just delete
> the old file when the other platforms are converted.

Hum, why not, but I would definitely prefer to wait for the conversion
of older platforms instead of duplicating this code. But if you feel
like it's the right solution, I'll do it.

> > The <mach/addr-map.h> is here to access the address decoding windows
> > allocation/free API. And for this, there is no other long term plan
> > than having an API provided by the platform code in arch/arm/, and used
> > by drivers. Some other drivers may have to use this API as well in the
> > future.
> 
> This is harder to do, but I'm sure we can find a solution. At least
> the addr-map.c code has no other dependencies than the plat/addr-map.h
> header, so we are fairly free to move it elsehwere.

The arch/arm/mach-mvebu/addr-map.c depends on
arch/arm/plat-orion/addr-map.c, so any change on this will affect
mach-kirkwood, mach-orion5x, mach-dove and mach-mv78xx0. As you can
see, we have to take into account the existing code, and I don't think
it's realistic to have a perfect solution immediately.

This address decoding code will continue to change for two reasons:

 *) We are going to work on NOR/NAND support for mach-mvebu, and that
    will also involve more interaction with the address decoding code.

 *) As we are moving the earlier Marvell SoC families (mach-kirkwood,
    mach-orion5x, mach-dove, mach-mv78xx0) to the Device Tree, this
    address decoding code will also evolve.

mach-mvebu is not a standalone new platform like mach-highbank for
example, it relies on a lot of existing code from ealier platforms. It
is nice to share existing code, but it also means that cleanups and
refactoring take a lot more time.

I think we need to leave time for all these platforms to gradually
converge and cleanup their infrastructure. It's not going to happen
overnight.

> I can think of several approaches that I'd prefer over your approach,
> although I have to admit that none of them makes me really happy:
> 
> a) arch/arm/common/mv-addr-map.c and arch/arm/include/asm/mach/mv-addr-map.h
> I assume that Russell will object to this one, but I let him speak for
> himself
> 
> b) drivers/bus/<something>
> This would make a lot more sense if we followed the scheme I explained
> in my discussion to Jason Gunthorpe, where we basically treat this
> bus as a parent node in the device tree for anything that can get remapped.
> Without that change, it feels a little misplaced
> 
> c) drivers/misc/
> I usually object to anything put in here and would certainly prefer the
> previous one over this.

All of those approaches require a huge amount of work to convert the
existing SoC families. Certainly, it will be done as time goes, and as
older SoC families are converted to the DT and gradually converge
inside mach-mvebu/, but if we have to wait for all of this to happen to
get the PCIe support merged, it's not going to happen before several
months (the PCIe stuff was originally posted on December, 7th,
initially with the hope of targeting 3.9, the review and rework has
taken a long time, so I'm now targeting 3.10 for the PCIe stuff, but
I'd prefer not to have to postpone this to 3.11 and even 3.12 due to
the heavy dependencies on address decoding rework).

> > > I don't understand this code with the masks and shifts. Could you
> > > add a comment here for readers like me?
> > 
> > Sure, will do.
> > 
> > It basically comes from the PCI-to-PCI bridge specification, which
> > explains how the I/O address and I/O limit is split into two 16 bits
> > registers, with those bizarre shifts and hardcoded values. I'll put a
> > reference to the relevant section of the PCI-to-PCI bridge
> > specification here.
> 
> Ok, I see. Thanks for the explanation.

I'll add a comment anyway, because it's true that it's a bit of magic
going on here.

> > > > +	/* Get the I/O and memory ranges from DT */
> > > > +	while ((range = of_pci_process_ranges(np, &res, range)) !=
> > > > NULL) {
> > > > +		if (resource_type(&res) == IORESOURCE_IO) {
> > > > +			memcpy(&pcie->io, &res, sizeof(res));
> > > > +			memcpy(&pcie->realio, &res, sizeof(res));
> > > > +			pcie->io.name = "I/O";
> > > > +			pcie->realio.start &= 0xFFFFF;
> > > > +			pcie->realio.end   &= 0xFFFFF;
> > > > +		}
> > > 
> > > The bit masking seems fishy here. What exactly are you doing,
> > > does this just assume you have a 1MB window at most?
> > 
> > Basically, I have two resources for the I/O:
> > 
> >  * One described in the DT, from 0xC0000000 to 0xC00FFFFF which will be
> >    used to create the address decoding windows for the I/O regions of
> >    the different PCIe interfaces. The PCI I/O virtual address 0xffe00000
> >    will be mapped to those physical addresses. Those address decoding
> >    windows are configured with the special "remap" mechanism that
> >    ensures that if an access is made at 0xC0000000 + offset, it will
> >    appear on the PCI bus as an I/O access at address "offset".
> 
> Right, I got this from reading the code. Unfortunately the of_pci_process_ranges
> functions from your earlier patch makes this a little confusing as it
> marks this resource as IORESOURCE_IO when in reality it is the IORESOURCE_MEM
> resource that describes where in MMIO space the I/O window is.

Indeed. So maybe I should mark this resource as being IORESOURCE_MEM
in the DT.

> >  * One covering the low addresses 0x0 -> 0xFFFFF (pcie->realio), which
> >    is used to tell the Linux PCI subsystem from which address range it
> >    should assign I/O addresses.
> > 
> > > Maybe something like
> > > 
> > > 	pcie->realio.start = 0;
> > > 	pcie->realio.end = pcie->io.end - pcie->io.start;
> > 
> > Indeed, that would result in the same values. If you find it clearer,
> > I'm fine with it.
> 
> Ideally we would read that from the ranges property as well, since it
> does not necessarily start at zero, although any other value would
> be a bit silly.
> 
> I definitely prefer the version I suggested over your version. On second
> thought I would make this
> 
> 	pcie->realio.start = PCIBIOS_MIN_IO;
> 	pcie->realio.end = min(pcie->io.end - pcie->io.start, IO_SPACE_LIMIT);
> 
> to ensure that we are inside of the limits.

Ok, thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
