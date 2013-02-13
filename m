Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:56210 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932438Ab3BMJaN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Feb 2013 04:30:13 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
Date: Wed, 13 Feb 2013 09:29:21 +0000
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
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com> <201302122259.54073.arnd@arndb.de> <20130213092358.4991ba43@skate>
In-Reply-To: <20130213092358.4991ba43@skate>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201302130929.21326.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 13 February 2013, Thomas Petazzoni wrote:
> Dear Arnd Bergmann,
> 
> On Tue, 12 Feb 2013 22:59:53 +0000, Arnd Bergmann wrote:
> 
> > > <plat/pcie.h> is needed for a few PCIe functions shared with earlier
> > > families of Marvell SoC. My plan is that once this PCI driver gets
> > > accepted, I work on migrating the earlier Marvell SoC families to using
> > > this PCI driver, and therefore those functions would ultimately move in
> > > the driver in drivers/pci/host/, which would remove the <plat/pcie.h>.
> > 
> > Hmm, although it is a bit unusual, I would actually propose duplicating
> > that code for now, and merging a copy into the new driver right away.
> > This gets rid of the header file dependency and lets you just delete
> > the old file when the other platforms are converted.
> 
> Hum, why not, but I would definitely prefer to wait for the conversion
> of older platforms instead of duplicating this code. But if you feel
> like it's the right solution, I'll do it.

It's not something we do a lot, but in this case, I think it's better
if it lets us avoid adding the platform specific include path, which I
really want to avoid here.

> > > The <mach/addr-map.h> is here to access the address decoding windows
> > > allocation/free API. And for this, there is no other long term plan
> > > than having an API provided by the platform code in arch/arm/, and used
> > > by drivers. Some other drivers may have to use this API as well in the
> > > future.
> > 
> > This is harder to do, but I'm sure we can find a solution. At least
> > the addr-map.c code has no other dependencies than the plat/addr-map.h
> > header, so we are fairly free to move it elsehwere.
> 
> The arch/arm/mach-mvebu/addr-map.c depends on
> arch/arm/plat-orion/addr-map.c, so any change on this will affect
> mach-kirkwood, mach-orion5x, mach-dove and mach-mv78xx0. As you can
> see, we have to take into account the existing code, and I don't think
> it's realistic to have a perfect solution immediately.

Yes, I realize this. I was thinking we would move all at least the
file from plat-orion, and the header file. I don't care much whether
we also move the platform specific setup from mach-*/addr-map.c,
it works either way.
 
> This address decoding code will continue to change for two reasons:
> 
>  *) We are going to work on NOR/NAND support for mach-mvebu, and that
>     will also involve more interaction with the address decoding code.
> 
>  *) As we are moving the earlier Marvell SoC families (mach-kirkwood,
>     mach-orion5x, mach-dove, mach-mv78xx0) to the Device Tree, this
>     address decoding code will also evolve.
> 
> mach-mvebu is not a standalone new platform like mach-highbank for
> example, it relies on a lot of existing code from ealier platforms. It
> is nice to share existing code, but it also means that cleanups and
> refactoring take a lot more time.
> 
> I think we need to leave time for all these platforms to gradually
> converge and cleanup their infrastructure. It's not going to happen
> overnight.

We don't need to do a complete overhaul of that code right now, but
if we agree on a place where it can go, then I think we should
move it now as just one extra patch to get rid of the header
dependency. In the worst case, moving just the header file to
include/linux would work, too.

> > > 
> > >  * One described in the DT, from 0xC0000000 to 0xC00FFFFF which will be
> > >    used to create the address decoding windows for the I/O regions of
> > >    the different PCIe interfaces. The PCI I/O virtual address 0xffe00000
> > >    will be mapped to those physical addresses. Those address decoding
> > >    windows are configured with the special "remap" mechanism that
> > >    ensures that if an access is made at 0xC0000000 + offset, it will
> > >    appear on the PCI bus as an I/O access at address "offset".
> > 
> > Right, I got this from reading the code. Unfortunately the of_pci_process_ranges
> > functions from your earlier patch makes this a little confusing as it
> > marks this resource as IORESOURCE_IO when in reality it is the IORESOURCE_MEM
> > resource that describes where in MMIO space the I/O window is.
> 
> Indeed. So maybe I should mark this resource as being IORESOURCE_MEM
> in the DT.

The DT seems fine here, just the code that interprets it is a little
unusual. Maybe you can change the calling convention of that function
to pass the type of resource you want as an argument?


	Arnd
