Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:32879 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754647Ab3A2Il7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jan 2013 03:41:59 -0500
Date: Tue, 29 Jan 2013 09:41:43 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>, linux-pci@vger.kernel.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130129094143.1aad9377@skate>
In-Reply-To: <5106F9F9.3010905@wwwdotorg.org>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
	<5106F9F9.3010905@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Stephen Warren,

On Mon, 28 Jan 2013 15:21:45 -0700, Stephen Warren wrote:

> > +Mandatory properties:
> > +- compatible: must be "marvell,armada-370-xp-pcie"
> > +- status: either "disabled" or "okay"
> 
> status is a standard DT property; I certainly wouldn't expect its
> presence to be mandatory (there's a defined default), nor would I expect
> each device's binding to redefine this property.

Ok.

> > +- marvell,pcie-port: the physical PCIe port number
> 
> Should the standardized cell-index property be used here instead? Or,
> perhaps that property is deprecated/discouraged...

The problem is that I need two identifiers, the pcie-port and
pcie-lane, and it would be strange to have one referenced as
cell-index, and the other one as marvell,pcie-lane, no? Unless of
course we can put two numbers in the cell-index property, but a quick
grep in Documentation/devicetree/bindings/ seems to indicate that all
users of cell-index use it with a single identifier.

Just tell me what to do here, I don't have a strong opinion on this.

> > diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> 
> > +obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
> > +ccflags-$(CONFIG_PCI_MVEBU) += \
> > +	-I$(srctree)/arch/arm/plat-orion/include \
> > +	-I$(srctree)/arch/arm/mach-mvebu/include
> 
> That seems a little dangerous w.r.t. multi-platform zImage. Can the
> required headers be moved out to somewhere more public to avoid this?

Why is this dangerous for multi-platform zImage? For this specific
driver only, some SoC-specific headers are used. I don't think it
prevents another PCI driver (such as the Tegra one) from being built
into the same kernel image, no?

Also, this is kind of a temporary solution, because I can't fix all the
problems in just the PCI patch series without making it horribly large.
The reason why we need those include paths at the moment are:

 * For plat-orion/include, because of pcie.h that provides functions
   common to all Marvell SoCs regarding PCI. Ultimately, all the
   Marvell SoCs that use this common code should be migrated over to
   the DT-capable PCI driver that is submitted through this patch
   series. This will take a bit of time, and is too complex to do in
   one shot, together with the introduction of the driver itself. So
   ultimately, all the code in plat-orion/pcie.c will migrate into
   drivers/pci/host/pci-mvebu.c, and this
   plat-orion/include/plat/pcie.h file should disappear, removing the
   need for this special header path.

 * For mach-mvebu/include, because of the addr-map.h header that
   provides functions related to address decoding windows. This is also
   likely to evolve quite significantly when we'll make the PCI driver
   being used by the other Marvell SoC families (Kirkwood, Dove,
   Orion5x), and when this work is done, we can think of having a
   public header in include/linux that exposes the address decoding
   APIs, once it has stabilized a bit across the different Marvell SoC
   families.

So, the bottom line is: yes I know those include paths are not nice,
but I don't think they prevent multiplatform builds, and they are a
temporary solution until we convert more Marvell SoC families to this
new PCI driver.

> > +/*
> > + * Those are the product IDs used for the emulated PCI Host bridge and
> > + * emulated PCI-to-PCI bridges. They are temporary until we get
> > + * official IDs assigned.
> > + */
> > +#define MARVELL_EMULATED_HOST_BRIDGE_ID    4141
> > +#define MARVELL_EMULATED_PCI_PCI_BRIDGE_ID 4242
> 
> I assume that means we can't merge this driver yet. The cover letter
> mentioned a desire to merge this for 3.9; there's not much time to get
> official IDs assigned, then.

I am working on getting real IDs assigned. For now, I'd like to work on
getting all other issues fixed, and have this only problem remaining.

> 
> > +static int mvebu_pcie_init(void)
> > +{
> > +	return platform_driver_probe(&mvebu_pcie_driver,
> > +				     mvebu_pcie_probe);
> > +}
> > +
> > +subsys_initcall(mvebu_pcie_init);
> 
> Why isn't that just platform_driver_register()?

I didn't test recently, but with my first version of the patch set,
having an initialization as late as module_init() was too late. Some
PCI fixup code was being executed *before* we get the opportunity of
initializing the PCI driver, and it was crashing the kernel. I can
provide more details if you want.

> > +MODULE_LICENSE("GPL");
> 
> "GPL v2".

Sure.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
