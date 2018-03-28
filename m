Return-Path: <SRS0=+Mg0=GS=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=+Mg0=GS=linux.intel.com=mika.westerberg@kernel.org>
Date: Wed, 28 Mar 2018 15:01:20 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <yehezkel.bernat@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 2/5] PCI: Take bridge window alignment into account
 when distributing resources
Message-ID: <20180328120120.GA2703@lahna.fi.intel.com>
References: <20180226132112.81447-1-mika.westerberg@linux.intel.com>
 <20180226132112.81447-3-mika.westerberg@linux.intel.com>
 <20180327192318.GC7759@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180327192318.GC7759@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 27, 2018 at 02:23:18PM -0500, Bjorn Helgaas wrote:
> On Mon, Feb 26, 2018 at 04:21:09PM +0300, Mika Westerberg wrote:
> > When connecting a Thunderbolt endpoint which itself has internal PCIe
> > switch (not the integrated one) the way we currently distribute
> 
> I don't understand this distinction between "internal PCIe switch" and
> "integrated one".

I tried to explain here that Thunderbolt endpoint itself has an internal
(integrated) PCIe switch.

> >From a PCI point of view, I assume you're adding a switch with 4 NIC
> endpoints below it.

Yes, exactly.

The PCIe device in question is Intel Gigabit ET2 Quad Port Server
adapter.

> > resources does not always work well because devices below non-hotplug
> > bridges might need to have their MMIO resources aligned to something
> > else than 1 MB boundary. As an example connecting a server grade 4-port
> > GbE add in card adds another PCIe switch leading to GbE devices that
> > want to have their MMIO resources aligned to 2 MB boundary instead.
> 
> Is there something unique about Thunderbolt here?  I assume from a PCI
> point of view, these NIC ports have BARs that are 2 MB or larger and
> hence need 2 MB or larger alignment?

No, this is not unique to Thunderbolt in any way.

> > Current resource distribution code does not take this alignment into
> > account and might try to add too much resources for the extension
> > hotplug bridges. The resulting bridge window is then too big which makes
> > Linux to re-allocate minimal amount of resources, making future
> > extension impossible.
> 
> Maybe a concrete example would make this clearer to me.

OK.

> > Make this work better by substracting properly aligned non-hotplug
> > downstream bridge window size from the remaining resources.
> > 
> > Fixes: 1a5767725cec ("PCI: Distribute available resources to hotplug-capable bridges")
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/pci/setup-bus.c | 41 ++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 40 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index 3cce29a069e6..f1e6172734f0 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -1882,6 +1882,7 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> >  	resource_size_t available_mmio, resource_size_t available_mmio_pref)
> >  {
> >  	resource_size_t remaining_io, remaining_mmio, remaining_mmio_pref;
> > +	resource_size_t io_start, mmio_start, mmio_pref_start;
> >  	unsigned int normal_bridges = 0, hotplug_bridges = 0;
> >  	struct resource *io_res, *mmio_res, *mmio_pref_res;
> >  	struct pci_dev *dev, *bridge = bus->self;
> > @@ -1946,11 +1947,16 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> >  			remaining_mmio_pref -= resource_size(res);
> >  	}
> >  
> > +	io_start = io_res->start;
> > +	mmio_start = mmio_res->start;
> > +	mmio_pref_start = mmio_pref_res->start;
> > +
> >  	/*
> >  	 * Go over devices on this bus and distribute the remaining
> >  	 * resource space between hotplug bridges.
> >  	 */
> >  	for_each_pci_bridge(dev, bus) {
> > +		resource_size_t align;
> >  		struct pci_bus *b;
> >  
> >  		b = dev->subordinate;
> > @@ -1968,7 +1974,7 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> >  				available_io, available_mmio,
> >  				available_mmio_pref);
> >  		} else if (dev->is_hotplug_bridge) {
> > -			resource_size_t align, io, mmio, mmio_pref;
> > +			resource_size_t io, mmio, mmio_pref;
> >  
> >  			/*
> >  			 * Distribute available extra resources equally
> > @@ -1981,11 +1987,13 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> >  			io = div64_ul(available_io, hotplug_bridges);
> >  			io = min(ALIGN(io, align), remaining_io);
> >  			remaining_io -= io;
> > +			io_start += io;
> >  
> >  			align = pci_resource_alignment(bridge, mmio_res);
> >  			mmio = div64_ul(available_mmio, hotplug_bridges);
> >  			mmio = min(ALIGN(mmio, align), remaining_mmio);
> >  			remaining_mmio -= mmio;
> > +			mmio_start += mmio;
> >  
> >  			align = pci_resource_alignment(bridge, mmio_pref_res);
> >  			mmio_pref = div64_ul(available_mmio_pref,
> > @@ -1993,9 +2001,40 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> >  			mmio_pref = min(ALIGN(mmio_pref, align),
> >  					remaining_mmio_pref);
> >  			remaining_mmio_pref -= mmio_pref;
> > +			mmio_pref_start += mmio_pref;
> >  
> >  			pci_bus_distribute_available_resources(b, add_list, io,
> >  							       mmio, mmio_pref);
> > +		} else {
> > +			/*
> > +			 * For normal bridges, track start of the parent
> > +			 * bridge window to make sure we align the
> > +			 * remaining space which is distributed to the
> > +			 * hotplug bridges properly.
> > +			 */
> > +			resource_size_t aligned;
> > +			struct resource *res;
> > +
> > +			res = &dev->resource[PCI_BRIDGE_RESOURCES + 0];
> > +			io_start += resource_size(res);
> > +			aligned = ALIGN(io_start,
> > +					pci_resource_alignment(dev, res));
> > +			if (aligned > io_start)
> > +				remaining_io -= aligned - io_start;
> > +
> > +			res = &dev->resource[PCI_BRIDGE_RESOURCES + 1];
> > +			mmio_start += resource_size(res);
> > +			aligned = ALIGN(mmio_start,
> > +					pci_resource_alignment(dev, res));
> > +			if (aligned > mmio_start)
> > +				remaining_mmio -= aligned - mmio_start;
> > +
> > +			res = &dev->resource[PCI_BRIDGE_RESOURCES + 2];
> > +			mmio_pref_start += resource_size(res);
> > +			aligned = ALIGN(mmio_pref_start,
> > +					pci_resource_alignment(dev, res));
> > +			if (aligned > mmio_pref_start)
> > +				remaining_mmio_pref -= aligned - mmio_pref_start;
> 
> I don't understand how this can work.  You have this:
> 
>   for_each_pci_bridge(dev, bus) {
>     if (!hotplug_bridges && normal_bridges == 1) {
>       pci_bus_distribute_available_resources(...);   # block 1
>     } else if (dev->is_hotplug_bridge) {
>       ...                                            # block 2
>       pci_bus_distribute_available_resources(...);
>     } else {
>       ...                                            # block 3
>     }
>   }
> 
> This patch adds block 3.  Block 3 doesn't do anything with side
> effects, i.e., it only updates local variables like io_start,
> remaining_io, mmio_start, remaining_mmio, etc.

It updates remaining_* so that the next bridge resource is aligned
properly (if there is going to be one).

> Those may be used in subsequent iterations, but it's only useful if
> there *are* subsequent iterations, so this is dependent on the order
> we iterate through the bridges.  It seems like we want the same
> results no matter what the order.

Here again we walk over the bridges using recursive calls so we need to
know upfront the alignment before we do next call to
pci_bus_distribute_available_resources() and that information is only
available when previous bridge is already handled. I suppose this can be
done in a better way but unfortunately I have no idea how :-( Can you
suggest something conrete I could do instead if this is not sufficient?
