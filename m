Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:59130 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758134Ab3BLXAf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Feb 2013 18:00:35 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
Date: Tue, 12 Feb 2013 22:59:53 +0000
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
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com> <201302121830.11375.arnd@arndb.de> <20130212202252.3a9ee3d0@skate>
In-Reply-To: <20130212202252.3a9ee3d0@skate>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201302122259.54073.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 12 February 2013, Thomas Petazzoni wrote:
> On Tue, 12 Feb 2013 18:30:11 +0000, Arnd Bergmann wrote:
> > On Tuesday 12 February 2013, Thomas Petazzoni wrote:
> > > diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> > > new file mode 100644
> > > index 0000000..3ad563f
> > > --- /dev/null
> > > +++ b/drivers/pci/host/Makefile
> > > @@ -0,0 +1,4 @@
> > > +obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
> > > +CFLAGS_pci-mvebu.o += \
> > > +	-I$(srctree)/arch/arm/plat-orion/include \
> > > +	-I$(srctree)/arch/arm/mach-mvebu/include
> > 
> > This does not seem like a good idea to me. We should not include
> > architecture specific directories from a driver directory.
> > 
> > What are the header files you need here? 
> 
> From the patch itself:
> 
> +#include <plat/pcie.h>
> +#include <mach/addr-map.h>
> 
> <plat/pcie.h> is needed for a few PCIe functions shared with earlier
> families of Marvell SoC. My plan is that once this PCI driver gets
> accepted, I work on migrating the earlier Marvell SoC families to using
> this PCI driver, and therefore those functions would ultimately move in
> the driver in drivers/pci/host/, which would remove the <plat/pcie.h>.

Hmm, although it is a bit unusual, I would actually propose duplicating
that code for now, and merging a copy into the new driver right away.
This gets rid of the header file dependency and lets you just delete
the old file when the other platforms are converted.

> The <mach/addr-map.h> is here to access the address decoding windows
> allocation/free API. And for this, there is no other long term plan
> than having an API provided by the platform code in arch/arm/, and used
> by drivers. Some other drivers may have to use this API as well in the
> future.

This is harder to do, but I'm sure we can find a solution. At least
the addr-map.c code has no other dependencies than the plat/addr-map.h
header, so we are fairly free to move it elsehwere.

I can think of several approaches that I'd prefer over your approach,
although I have to admit that none of them makes me really happy:

a) arch/arm/common/mv-addr-map.c and arch/arm/include/asm/mach/mv-addr-map.h
I assume that Russell will object to this one, but I let him speak for
himself

b) drivers/bus/<something>
This would make a lot more sense if we followed the scheme I explained
in my discussion to Jason Gunthorpe, where we basically treat this
bus as a parent node in the device tree for anything that can get remapped.
Without that change, it feels a little misplaced

c) drivers/misc/
I usually object to anything put in here and would certainly prefer the
previous one over this.

> Note that I have been careful to use CFLAGS_pci-mvebu.o, so that those
> include paths only apply to *this* driver. I added a separate dummy
> driver in drivers/pci/host/, and verified that those include paths are
> not used when building this other driver. So those special CFLAGS are
> still compatible with the multiplatform kernel.

I understand this, but I think it would be better not to set a precedent
for doing this.

> 
> > > +static void mvebu_pcie_setup_io_window(struct mvebu_pcie_port
> > > *port,
> > > +				       int enable)
> > > +{
> > > +	unsigned long iobase, iolimit;
> > > +
> > > +	if (port->bridge.iolimit < port->bridge.iobase)
> > > +		return;
> > > +
> > > +	iolimit = 0xFFF | ((port->bridge.iolimit & 0xF0) << 8) |
> > > +		(port->bridge.iolimitupper << 16);
> > > +	iobase = ((port->bridge.iobase & 0xF0) << 8) |
> > > +		(port->bridge.iobaseupper << 16);
> > 
> > I don't understand this code with the masks and shifts. Could you
> > add a comment here for readers like me?
> 
> Sure, will do.
> 
> It basically comes from the PCI-to-PCI bridge specification, which
> explains how the I/O address and I/O limit is split into two 16 bits
> registers, with those bizarre shifts and hardcoded values. I'll put a
> reference to the relevant section of the PCI-to-PCI bridge
> specification here.

Ok, I see. Thanks for the explanation.
 
> > > +	/* Get the I/O and memory ranges from DT */
> > > +	while ((range = of_pci_process_ranges(np, &res, range)) !=
> > > NULL) {
> > > +		if (resource_type(&res) == IORESOURCE_IO) {
> > > +			memcpy(&pcie->io, &res, sizeof(res));
> > > +			memcpy(&pcie->realio, &res, sizeof(res));
> > > +			pcie->io.name = "I/O";
> > > +			pcie->realio.start &= 0xFFFFF;
> > > +			pcie->realio.end   &= 0xFFFFF;
> > > +		}
> > 
> > The bit masking seems fishy here. What exactly are you doing,
> > does this just assume you have a 1MB window at most?
> 
> Basically, I have two resources for the I/O:
> 
>  * One described in the DT, from 0xC0000000 to 0xC00FFFFF which will be
>    used to create the address decoding windows for the I/O regions of
>    the different PCIe interfaces. The PCI I/O virtual address 0xffe00000
>    will be mapped to those physical addresses. Those address decoding
>    windows are configured with the special "remap" mechanism that
>    ensures that if an access is made at 0xC0000000 + offset, it will
>    appear on the PCI bus as an I/O access at address "offset".

Right, I got this from reading the code. Unfortunately the of_pci_process_ranges
functions from your earlier patch makes this a little confusing as it
marks this resource as IORESOURCE_IO when in reality it is the IORESOURCE_MEM
resource that describes where in MMIO space the I/O window is.

>  * One covering the low addresses 0x0 -> 0xFFFFF (pcie->realio), which
>    is used to tell the Linux PCI subsystem from which address range it
>    should assign I/O addresses.
> 
> > Maybe something like
> > 
> > 	pcie->realio.start = 0;
> > 	pcie->realio.end = pcie->io.end - pcie->io.start;
> 
> Indeed, that would result in the same values. If you find it clearer,
> I'm fine with it.

Ideally we would read that from the ranges property as well, since it
does not necessarily start at zero, although any other value would
be a bit silly.

I definitely prefer the version I suggested over your version. On second
thought I would make this

	pcie->realio.start = PCIBIOS_MIN_IO;
	pcie->realio.end = min(pcie->io.end - pcie->io.start, IO_SPACE_LIMIT);

to ensure that we are inside of the limits.

> 
> > > +static int mvebu_pcie_init(void)
> > > +{
> > > +	return platform_driver_probe(&mvebu_pcie_driver,
> > > +				     mvebu_pcie_probe);
> > > +}
> > > +
> > > +subsys_initcall(mvebu_pcie_init);
> > 
> > You don't have to do it, but I wonder if this could be a module
> > with unload support instead.
> 
> This has already been discussed in the review of PATCHv2. Please see
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/145580.html.

Ok.

	Arnd
