Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:12585 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S966336Ab3DQOIq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 17 Apr 2013 10:08:46 -0400
Date: Wed, 17 Apr 2013 10:08:17 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Russell King <linux@arm.linux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Maen Suleiman <maen@marvell.com>, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Grant Likely <grant.likely@secretlab.ca>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Andrew Murray <andrew.murray@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Mitch Bradley <wmb@firmworks.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCHv8 07/19] arm: pci: add a align_resource hook
Message-ID: <20130417140817.GE28693@titan.lakedaemon.net>
References: <1365541601-14095-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1365541601-14095-8-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130415163609.GJ28693@titan.lakedaemon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130415163609.GJ28693@titan.lakedaemon.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Russell,

I saw you were back online this morning, could you please consider the
following request?

On Mon, Apr 15, 2013 at 12:36:09PM -0400, Jason Cooper wrote:
> Russell,
> 
> Thanks for applying this patch (7683/1) to your tree.  I see it's in
> your for-next, which I understand *isn't* stable.
> 
>   029baf1 ARM: 7683/1: pci: add a align_resource hook
> 
> Is there a stable branch I could depend on for the rest of this series
> (particularly, patch 10)?  It looks like you applied it to your misc
> branch, but that's not currently available.

I'd really like to get this in for v3.10.  As Thomas has mentioned
before, the series has had plenty of review on the list.

thx,

Jason.

> On Tue, Apr 09, 2013 at 11:06:28PM +0200, Thomas Petazzoni wrote:
> > The PCI specifications says that an I/O region must be aligned on a 4
> > KB boundary, and a memory region aligned on a 1 MB boundary.
> > 
> > However, the Marvell PCIe interfaces rely on address decoding windows
> > (which allow to associate a range of physical addresses with a given
> > device). For PCIe memory windows, those windows are defined with a 1
> > MB granularity (which matches the PCI specs), but PCIe I/O windows can
> > only be defined with a 64 KB granularity, so they have to be 64 KB
> > aligned. We therefore need to tell the PCI core about this special
> > alignement requirement.
> > 
> > The PCI core already calls pcibios_align_resource() in the ARM PCI
> > core, specifically for such purposes. So this patch extends the ARM
> > PCI core so that it calls a ->align_resource() hook registered by the
> > PCI driver, exactly like the existing ->map_irq() and ->swizzle()
> > hooks.
> > 
> > A particular PCI driver can register a align_resource() hook, and do
> > its own specific alignement, depending on the specific constraints of
> > the underlying hardware.
> > 
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > ---
> >  arch/arm/include/asm/mach/pci.h |   11 +++++++++++
> >  arch/arm/kernel/bios32.c        |    6 ++++++
> >  2 files changed, 17 insertions(+)
> > 
> > diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
> > index 5cf2e97..7d2c3c8 100644
> > --- a/arch/arm/include/asm/mach/pci.h
> > +++ b/arch/arm/include/asm/mach/pci.h
> > @@ -30,6 +30,11 @@ struct hw_pci {
> >  	void		(*postinit)(void);
> >  	u8		(*swizzle)(struct pci_dev *dev, u8 *pin);
> >  	int		(*map_irq)(const struct pci_dev *dev, u8 slot, u8 pin);
> > +	resource_size_t (*align_resource)(struct pci_dev *dev,
> > +					  const struct resource *res,
> > +					  resource_size_t start,
> > +					  resource_size_t size,
> > +					  resource_size_t align);
> >  };
> >  
> >  /*
> > @@ -51,6 +56,12 @@ struct pci_sys_data {
> >  	u8		(*swizzle)(struct pci_dev *, u8 *);
> >  					/* IRQ mapping				*/
> >  	int		(*map_irq)(const struct pci_dev *, u8, u8);
> > +					/* Resource alignement requirements	*/
> > +	resource_size_t (*align_resource)(struct pci_dev *dev,
> > +					  const struct resource *res,
> > +					  resource_size_t start,
> > +					  resource_size_t size,
> > +					  resource_size_t align);
> >  	void		*private_data;	/* platform controller private data	*/
> >  };
> >  
> > diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> > index a1f73b5..b2ed73c 100644
> > --- a/arch/arm/kernel/bios32.c
> > +++ b/arch/arm/kernel/bios32.c
> > @@ -462,6 +462,7 @@ static void pcibios_init_hw(struct hw_pci *hw, struct list_head *head)
> >  		sys->busnr   = busnr;
> >  		sys->swizzle = hw->swizzle;
> >  		sys->map_irq = hw->map_irq;
> > +		sys->align_resource = hw->align_resource;
> >  		INIT_LIST_HEAD(&sys->resources);
> >  
> >  		if (hw->private_data)
> > @@ -574,6 +575,8 @@ char * __init pcibios_setup(char *str)
> >  resource_size_t pcibios_align_resource(void *data, const struct resource *res,
> >  				resource_size_t size, resource_size_t align)
> >  {
> > +	struct pci_dev *dev = data;
> > +	struct pci_sys_data *sys = dev->sysdata;
> >  	resource_size_t start = res->start;
> >  
> >  	if (res->flags & IORESOURCE_IO && start & 0x300)
> > @@ -581,6 +584,9 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
> >  
> >  	start = (start + align - 1) & ~(align - 1);
> >  
> > +	if (sys->align_resource)
> > +		return sys->align_resource(dev, res, start, size, align);
> > +
> >  	return start;
> >  }
> >  
> > -- 
> > 1.7.9.5
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
