Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:34775 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753910AbaBMLEh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Feb 2014 06:04:37 -0500
Date: Thu, 13 Feb 2014 11:04:02 +0000
From: Will Deacon <will.deacon@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"jgunthorpe@obsidianresearch.com" <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v2 3/3] PCI: ARM: add support for generic PCI host
 controller
Message-ID: <20140213110401.GB13576@mudshark.cambridge.arm.com>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com>
 <1392236171-10512-4-git-send-email-will.deacon@arm.com>
 <1645474.vdytZl6znf@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1645474.vdytZl6znf@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,

Thanks again for the comments.

On Wed, Feb 12, 2014 at 08:59:46PM +0000, Arnd Bergmann wrote:
> On Wednesday 12 February 2014 20:16:11 Will Deacon wrote:
> > +- ranges         : As described in IEEE Std 1275-1994, but must provide
> > +                   at least a definition of one or both of IO and Memory
> > +                   Space.
> 
> I'd say *must* provide at least non-prefetchable memory. *may* provide
> prefetchable memory and/or I/O space.

Can do. Should I enforce this in the driver too? (i.e. complain if
non-prefetchable memory is absent).

> > +Interrupt mapping is exactly as described in `Open Firmware Recommended
> > +Practice: Interrupt Mapping' and requires the following properties:
> > +
> > +- #interrupt-cells   : Must be 1
> > +
> > +- interrupt-map      : <see aforementioned specification>
> > +
> > +- interrupt-map-mask : <see aforementioned specification>
> 
> We probably want to add an optional 'bus-range' property (the default being
> <0 255> if absent), so we don't have to map all the config space.

Yes, and that will be important given your comments later on.

> > diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> > index 47d46c6d8468..491d74c36f6a 100644
> > --- a/drivers/pci/host/Kconfig
> > +++ b/drivers/pci/host/Kconfig
> > @@ -33,4 +33,11 @@ config PCI_RCAR_GEN2
> >  	  There are 3 internal PCI controllers available with a single
> >  	  built-in EHCI/OHCI host controller present on each one.
> >  
> > +config PCI_ARM_GENERIC
> > +	bool "ARM generic PCI host controller"
> > +	depends on ARM && OF
> > +	help
> > +	  Say Y here if you want to support a simple generic PCI host
> > +	  controller, such as the one emulated by kvmtool.
> > +
> >  endmenu
> 
> Looks good for now. In the long run, I'd hope to get rid of the 'ARM'
> part here and make it work on any architecture, but that requires
> significant work that we should not depend on here.

Agreed. arm64 is the obvious next target (once Liviu's series is sorted out
-- I'm currently using a simplified port of bios32.c for testing).

> > +struct gen_pci_cfg_window {
> > +	u64					cpu_phys;
> > +	void __iomem				*base;
> > +	u8					bus;
> > +	spinlock_t				lock;
> > +	const struct gen_pci_cfg_accessors	*accessors;
> > +};
> > +
> > +struct gen_pci_resource {
> > +	struct list_head			list;
> > +	struct resource				cpu_res;
> > +	resource_size_t				offset;
> > +};
> 
> Your gen_pci_resource is actually identical to struct pci_host_bridge_window,
> which I guess is coincidence, but it would be nice to actually use
> the standard structure to make it easier to integrate with common
> infrastructure later.

Ha, at least I managed to come up with the same struct! I'll move to the
generic version.

> > +
> > +struct gen_pci {
> > +	struct device				*dev;
> > +	struct resource				*io_res;
> > +	struct list_head			mem_res;
> > +	struct gen_pci_cfg_window		cfg;
> > +};
> 
> How about making this structure derived from pci_host_bridge?
> That would already contain a lot of the members, and gets two things
> right: 
> 
> * it's useful to have an embedded 'struct device' here, and use dev->parent
>   to point to the device from DT
> * for I/O, we actually want a pci_host_bridge_window, not just a resource,
>   since we should keep track of the offset

Sure. Also, if we kill nr_controllers, then we can have a simple I/O space
allocator to populate the offset.

> > +static void __iomem *gen_pci_map_cfg_bus_ecam(struct pci_bus *bus,
> > +					      unsigned int devfn,
> > +					      int where)
> > +{
> > +	struct pci_sys_data *sys = bus->sysdata;
> > +	struct gen_pci *pci = sys->private_data;
> > +	u32 busn = bus->number;
> > +
> > +	spin_lock(&pci->cfg.lock);
> > +	if (pci->cfg.bus != busn) {
> > +		resource_size_t offset;
> > +
> > +		devm_iounmap(pci->dev, pci->cfg.base);
> > +		offset = pci->cfg.cpu_phys + (busn << 20);
> > +		pci->cfg.base = devm_ioremap(pci->dev, offset, SZ_1M);
> > +		pci->cfg.bus = busn;
> > +	}
> > +
> > +	return pci->cfg.base + ((devfn << 12) | where);
> > +}
> 
> Nice idea, but unfortunately broken: we need config space access from
> atomic context, since there are drivers doing that.

That aside, I just took a spin_lock so this needs fixing regardless. The
only solution I can think of then is to map all of the buses at setup time
(making bus_ranges pretty important) and hope that I don't chew through all
of vmalloc.

> > +static int gen_pci_probe(struct platform_device *pdev)
> > +{
> > +	struct hw_pci hw;
> > +	struct of_pci_range range;
> > +	struct of_pci_range_parser parser;
> > +	struct gen_pci *pci;
> > +	const __be32 *reg;
> > +	const struct of_device_id *of_id;
> > +	struct device *dev = &pdev->dev;
> > +	struct device_node *np = dev->of_node;
> 
> Could you try to move almost all of this function into gen_pci_setup()?
> I suspect this will make it easier later to share this driver with other
> architectures.

I'll take a look. If we get rid of nr_controllers, as suggested later on,
the line between probe and setup is somewhat blurred.

> > +
> > +	hw = (struct hw_pci) {
> > +		.nr_controllers	= 1,
> > +		.private_data	= (void **)&pci,
> > +		.setup		= gen_pci_setup,
> > +		.map_irq	= of_irq_parse_and_map_pci,
> > +		.ops		= &gen_pci_ops,
> > +	};
> > +
> > +	pci_common_init_dev(dev, &hw);
> > +	return 0;
> > +}
> 
> A missing part here seems to be a way to propagate errors from
> the pci_common_init_dev or gen_pci_setup back to the caller.
> 
> This seems to be a result of the arm pcibios implementation not
> being meant for loadable modules, but I suspect it can be fixed.
> The nr_controllers>1 logic gets a bit in the way there, but it's
> also a model that seems to be getting out of fashion:
> kirkwood/dove/orion5x/mv78xx0 use it at the moment, but are
> migrating over to the new pci-mvebu code that doesn't as they
> get rid of the non-DT probing. pci-rcar-gen2.c uses it, but it
> seems they already ran into problems with that and are changing
> it. That pretty much leaves iop13xx as the only user, but at
> that point we can probably move the loop into iop13xx specific
> code.

Makes sense once there are no users of the field.

Will
