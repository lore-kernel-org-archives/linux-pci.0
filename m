Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59082 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124Ab3A3PTy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Jan 2013 10:19:54 -0500
Date: Wed, 30 Jan 2013 15:19:34 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>, linux-pci@vger.kernel.org,
	Stephen Warren <swarren@wwwdotorg.org>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
	systems
Message-ID: <20130130151934.GK23505@n2100.arm.linux.org.uk>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com> <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com> <20130130113245.GH23505@n2100.arm.linux.org.uk> <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de> <20130130150856.GJ23505@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130130150856.GJ23505@n2100.arm.linux.org.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 30, 2013 at 03:08:56PM +0000, Russell King - ARM Linux wrote:
> On Wed, Jan 30, 2013 at 01:03:44PM +0100, Thierry Reding wrote:
> > On Wed, Jan 30, 2013 at 11:32:46AM +0000, Russell King - ARM Linux wrote:
> > > On Mon, Jan 28, 2013 at 07:56:28PM +0100, Thomas Petazzoni wrote:
> > > > +static resource_size_t mvebu_pcie_align_resource(struct pci_dev *dev,
> > > > +						 const struct resource *res,
> > > > +						 resource_size_t start,
> > > > +						 resource_size_t size,
> > > > +						 resource_size_t align)
> > > > +{
> > > > +	if (!(res->flags & IORESOURCE_IO))
> > > > +		return start;
> > > > +
> > > > +	/*
> > > > +	 * The I/O regions must be 64K aligned, because the
> > > > +	 * granularity of PCIe I/O address decoding windows is 64 K
> > > > +	 */
> > > > +	return round_up(start, SZ_64K);
> > > > +}
> > > 
> > > You do realise that this will result in all PCI I/O BARs being rounded
> > > up to 64K.
> > > 
> > > I've just been digging through the PCI code and have come across a
> > > function - pcibios_window_alignment() - which the PCI code allows to be
> > > overriden which allows you to increase the alignment requirement of
> > > bridge windows.  It takes the PCI bus and window type as arguments.
> > > 
> > > I'd suggest using that, and checking whether the bus which is passed
> > > corresponds with a bus which gives you problems, so that you don't
> > > impose the 64K requirement on downstream bridges.
> > 
> > That approach isn't going to work very well with multi-platform, though,
> > since the function can only be overridden on a per-architecture basis.
> 
> The same can be said of all the various other functions which the PCI
> stuff expects the arch to provide, yet we seem to cope just fine...

And this (untested) is how it's done:

 arch/arm/include/asm/mach/pci.h |    1 +
 arch/arm/kernel/bios32.c        |    8 ++++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index db9fedb..bba0cf3 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -29,6 +29,7 @@ struct hw_pci {
 	void		(*postinit)(void);
 	u8		(*swizzle)(struct pci_dev *dev, u8 *pin);
 	int		(*map_irq)(const struct pci_dev *dev, u8 slot, u8 pin);
+	resource_size_t	(*window_align)(struct pci_bus *, unsigned long);
 };
 
 /*
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 379cf32..32c3bd9 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -581,6 +581,14 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 	return start;
 }
 
+resource_size_t pcibios_window_alignment(struct pci_bus *bus,
+					 unsigned long type)
+{
+	struct pci_sys_data *sys = bus->sysdata;
+
+	return sys->window_alignment ? sys->window_alignment(bus, type) : 1;
+}
+
 /**
  * pcibios_enable_device - Enable I/O and memory.
  * @dev: PCI device to be enabled

