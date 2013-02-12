Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:47152 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933153Ab3BLTXH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Feb 2013 14:23:07 -0500
Date: Tue, 12 Feb 2013 20:22:52 +0100
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
Message-ID: <20130212202252.3a9ee3d0@skate>
In-Reply-To: <201302121830.11375.arnd@arndb.de>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1360686546-24277-25-git-send-email-thomas.petazzoni@free-electrons.com>
	<201302121830.11375.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Arnd Bergmann,

On Tue, 12 Feb 2013 18:30:11 +0000, Arnd Bergmann wrote:
> On Tuesday 12 February 2013, Thomas Petazzoni wrote:
> > diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> > new file mode 100644
> > index 0000000..3ad563f
> > --- /dev/null
> > +++ b/drivers/pci/host/Makefile
> > @@ -0,0 +1,4 @@
> > +obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
> > +CFLAGS_pci-mvebu.o += \
> > +	-I$(srctree)/arch/arm/plat-orion/include \
> > +	-I$(srctree)/arch/arm/mach-mvebu/include
> 
> This does not seem like a good idea to me. We should not include
> architecture specific directories from a driver directory.
> 
> What are the header files you need here? 

>From the patch itself:

+#include <plat/pcie.h>
+#include <mach/addr-map.h>

<plat/pcie.h> is needed for a few PCIe functions shared with earlier
families of Marvell SoC. My plan is that once this PCI driver gets
accepted, I work on migrating the earlier Marvell SoC families to using
this PCI driver, and therefore those functions would ultimately move in
the driver in drivers/pci/host/, which would remove the <plat/pcie.h>.

The <mach/addr-map.h> is here to access the address decoding windows
allocation/free API. And for this, there is no other long term plan
than having an API provided by the platform code in arch/arm/, and used
by drivers. Some other drivers may have to use this API as well in the
future.

I think that completely preventing <mach/> and <plat/> includes from
drivers is not possible. Some sub-architectures will also have some
bizarre mechanism to handle (in our case the address decoding windows),
for which there is no kernel-wide API and kernel-wide subsystem to
handle it. In such cases, a sub-architecture specific solution is
really the only reasonable way, and in this case, we have to include
the sub-architecture headers.

Note that I have been careful to use CFLAGS_pci-mvebu.o, so that those
include paths only apply to *this* driver. I added a separate dummy
driver in drivers/pci/host/, and verified that those include paths are
not used when building this other driver. So those special CFLAGS are
still compatible with the multiplatform kernel.

> > +/*
> > + * This product ID is registered by Marvell, and used when the
> > Marvell
> > + * SoC is not the root complex, but an endpoint on the PCIe bus.
> > It is
> > + * therefore safe to re-use this PCI ID for our emulated PCI-to-PCI
> > + * bridge.
> > + */
> > +#define MARVELL_EMULATED_PCI_PCI_BRIDGE_ID 0x7846
> 
> Just a side note: What happens if you have two of these systems and
> connect them over PCIe, putting one of them into host mode and the
> other into endpoint mode?

I am not a PCI expert, but I don't think it would cause issues. Maybe
Jason Gunthorpe can comment on this, as he originally suggested to
re-use this PCI ID.

> > +static void mvebu_pcie_setup_io_window(struct mvebu_pcie_port
> > *port,
> > +				       int enable)
> > +{
> > +	unsigned long iobase, iolimit;
> > +
> > +	if (port->bridge.iolimit < port->bridge.iobase)
> > +		return;
> > +
> > +	iolimit = 0xFFF | ((port->bridge.iolimit & 0xF0) << 8) |
> > +		(port->bridge.iolimitupper << 16);
> > +	iobase = ((port->bridge.iobase & 0xF0) << 8) |
> > +		(port->bridge.iobaseupper << 16);
> 
> I don't understand this code with the masks and shifts. Could you
> add a comment here for readers like me?

Sure, will do.

It basically comes from the PCI-to-PCI bridge specification, which
explains how the I/O address and I/O limit is split into two 16 bits
registers, with those bizarre shifts and hardcoded values. I'll put a
reference to the relevant section of the PCI-to-PCI bridge
specification here.

> > +
> > +/*
> > + * Initialize the configuration space of the PCI-to-PCI bridge
> > + * associated with the given PCIe interface.
> > + */
> > +static void mvebu_sw_pci_bridge_init(struct mvebu_pcie_port *port)
> > +{
> 
> As mentioned, I'm still skeptical of the sw_pci_bridge approach,
> so I'm not commenting on the details of your implementations
> (they seem fine on a first look though)

Yes, I understood your were still skeptical. But as I've mentioned in
other e-mails, I still haven't seen any other serious alternate
proposal that takes into account the need for dynamic assignment of
addresses.

> > +	/* Get the I/O and memory ranges from DT */
> > +	while ((range = of_pci_process_ranges(np, &res, range)) !=
> > NULL) {
> > +		if (resource_type(&res) == IORESOURCE_IO) {
> > +			memcpy(&pcie->io, &res, sizeof(res));
> > +			memcpy(&pcie->realio, &res, sizeof(res));
> > +			pcie->io.name = "I/O";
> > +			pcie->realio.start &= 0xFFFFF;
> > +			pcie->realio.end   &= 0xFFFFF;
> > +		}
> 
> The bit masking seems fishy here. What exactly are you doing,
> does this just assume you have a 1MB window at most?

Basically, I have two resources for the I/O:

 * One described in the DT, from 0xC0000000 to 0xC00FFFFF which will be
   used to create the address decoding windows for the I/O regions of
   the different PCIe interfaces. The PCI I/O virtual address 0xffe00000
   will be mapped to those physical addresses. Those address decoding
   windows are configured with the special "remap" mechanism that
   ensures that if an access is made at 0xC0000000 + offset, it will
   appear on the PCI bus as an I/O access at address "offset".

 * One covering the low addresses 0x0 -> 0xFFFFF (pcie->realio), which
   is used to tell the Linux PCI subsystem from which address range it
   should assign I/O addresses.

> Maybe something like
> 
> 	pcie->realio.start = 0;
> 	pcie->realio.end = pcie->io.end - pcie->io.start;

Indeed, that would result in the same values. If you find it clearer,
I'm fine with it.

> I suppose you also need to fix up pcie->io to be in IORESOURCE_MEM
> space instead of IORESOURCE_IO, or fix the of_pci_process_ranges
> function to return it in a different way.

Ok.

> > +static int mvebu_pcie_init(void)
> > +{
> > +	return platform_driver_probe(&mvebu_pcie_driver,
> > +				     mvebu_pcie_probe);
> > +}
> > +
> > +subsys_initcall(mvebu_pcie_init);
> 
> You don't have to do it, but I wonder if this could be a module
> with unload support instead.

This has already been discussed in the review of PATCHv2. Please see
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/145580.html.

Basically, doing a module_init() initialization fails, because the XHCI
USB quirks are executed before we have the chance to create the address
decoding windows, which crashes the kernel at boot time (and we have
one platform where an USB 3.0 XHCI controller sits on the PCIe bus).
Bjorn Helgaas has acknowledged the problem in
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-February/148292.html:

"""
This is not really a problem in your code; it's a generic PCI core
problem.  pci_scan_root_bus() does everything including creating the
root bus, scanning it, and adding the devices we find.  At the point
where we add a device (pci_bus_add_device()), it should be ready for a
driver to claim it -- all resource assignment should already be done.

I don't think it's completely trivial to fix this in the PCI core yet
(but we're moving in that direction) because we have some boot-time
ordering issues, e.g., x86 scans the root buses before we know about
the address space consumed by ACPI devices, so we can't just assign
the resources when we scan the bus.
"""

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
