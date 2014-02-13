Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:36043 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753256AbaBMMBS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Feb 2014 07:01:18 -0500
Date: Thu, 13 Feb 2014 12:00:42 +0000
From: Will Deacon <will.deacon@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"jgunthorpe@obsidianresearch.com" <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v2 3/3] PCI: ARM: add support for generic PCI host
 controller
Message-ID: <20140213120042.GE13576@mudshark.cambridge.arm.com>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com>
 <1645474.vdytZl6znf@wuerfel>
 <20140213110401.GB13576@mudshark.cambridge.arm.com>
 <348076699.SKFqCqFVHd@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <348076699.SKFqCqFVHd@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 13, 2014 at 11:47:46AM +0000, Arnd Bergmann wrote:
> On Thursday 13 February 2014 11:04:02 Will Deacon wrote:
> > On Wed, Feb 12, 2014 at 08:59:46PM +0000, Arnd Bergmann wrote:
> > > On Wednesday 12 February 2014 20:16:11 Will Deacon wrote:
> > > > +struct gen_pci_resource {
> > > > +	struct list_head			list;
> > > > +	struct resource				cpu_res;
> > > > +	resource_size_t				offset;
> > > > +};
> > > 
> > > Your gen_pci_resource is actually identical to struct pci_host_bridge_window,
> > > which I guess is coincidence, but it would be nice to actually use
> > > the standard structure to make it easier to integrate with common
> > > infrastructure later.
> > 
> > Ha, at least I managed to come up with the same struct! I'll move to the
> > generic version.
> 
> Hmm, I fear I was speaking too quickly, the pci_host_bridge_window actually
> contains a pointer to the resource rather than the resource itself :(

I can allocate the resources dynamically as I parse them, not a problem at
all.

> There is probably a way to do this better, at least once we unify the
> probe() and setup() functions.

Yes, I fully expect this to be iterative.

> > > > +	spin_lock(&pci->cfg.lock);
> > > > +	if (pci->cfg.bus != busn) {
> > > > +		resource_size_t offset;
> > > > +
> > > > +		devm_iounmap(pci->dev, pci->cfg.base);
> > > > +		offset = pci->cfg.cpu_phys + (busn << 20);
> > > > +		pci->cfg.base = devm_ioremap(pci->dev, offset, SZ_1M);
> > > > +		pci->cfg.bus = busn;
> > > > +	}
> > > 
> > > Nice idea, but unfortunately broken: we need config space access from
> > > atomic context, since there are drivers doing that.
> > 
> > That aside, I just took a spin_lock so this needs fixing regardless. The
> > only solution I can think of then is to map all of the buses at setup time
> > (making bus_ranges pretty important) and hope that I don't chew through all
> > of vmalloc.
> 
> It's possible we have to go further and only map the buses that are
> actually used, rather than the ones that are defined for the bus,
> but just mapping the entire range is a reasonable start I think.

Okey doke.

> > > > +	hw = (struct hw_pci) {
> > > > +		.nr_controllers	= 1,
> > > > +		.private_data	= (void **)&pci,
> > > > +		.setup		= gen_pci_setup,
> > > > +		.map_irq	= of_irq_parse_and_map_pci,
> > > > +		.ops		= &gen_pci_ops,
> > > > +	};
> > > > +
> > > > +	pci_common_init_dev(dev, &hw);
> > > > +	return 0;
> > > > +}
> > > 
> > > A missing part here seems to be a way to propagate errors from
> > > the pci_common_init_dev or gen_pci_setup back to the caller.
> > > 
> > > This seems to be a result of the arm pcibios implementation not
> > > being meant for loadable modules, but I suspect it can be fixed.
> > > The nr_controllers>1 logic gets a bit in the way there, but it's
> > > also a model that seems to be getting out of fashion:
> > > kirkwood/dove/orion5x/mv78xx0 use it at the moment, but are
> > > migrating over to the new pci-mvebu code that doesn't as they
> > > get rid of the non-DT probing. pci-rcar-gen2.c uses it, but it
> > > seems they already ran into problems with that and are changing
> > > it. That pretty much leaves iop13xx as the only user, but at
> > > that point we can probably move the loop into iop13xx specific
> > > code.
> > 
> > Makes sense once there are no users of the field.
> 
> With the patch I just suggested, we can simply keep
> pci_common_init_dev() for older (non-multiplatform) controllers 
> and not change them at all but move on to something else for
> the interesting ones, i.e. those we want to share with arm64.

Yes, that looks sensible. An alternative is to create an hw_pci in
pci_host_bridge_register with nr_controllers = 1 then call
pci_common_init_dev. It would remove slightly more code, but obviously ties
the thing to arm.

Will
