Return-Path: <SRS0=Q7Os=C3=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=Q7Os=C3=arm.com=lorenzo.pieralisi@kernel.org>
Date: Wed, 29 Nov 2017 14:14:30 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
	bhelgaas@google.com, kishon@ti.com, linux-pci@vger.kernel.org,
	adouglas@cadence.com, stelford@cadence.com, dgary@cadence.com,
	kgopi@cadence.com, eandrews@cadence.com,
	thomas.petazzoni@free-electrons.com, sureshp@cadence.com,
	nsekhar@ti.com, linux-kernel@vger.kernel.org, robh@kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 3/5] PCI: cadence: Add host driver for Cadence PCIe
 controller
Message-ID: <20171129141430.GA30617@red-moon>
References: <cover.1511439189.git.cyrille.pitchen@free-electrons.com>
 <2670f7ddf59e708beb9d32bef1353e15bd4e1ecf.1511439189.git.cyrille.pitchen@free-electrons.com>
 <20171128204114.GE11228@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171128204114.GE11228@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 28, 2017 at 02:41:14PM -0600, Bjorn Helgaas wrote:

[...]

> > +static int cdns_pcie_parse_request_of_pci_ranges(struct device *dev,
> > +						 struct list_head *resources,
> > +						 struct resource **bus_range)
> > +{
> > +	int err, res_valid = 0;
> > +	struct device_node *np = dev->of_node;
> > +	resource_size_t iobase;
> > +	struct resource_entry *win, *tmp;
> > +
> > +	err = of_pci_get_host_bridge_resources(np, 0, 0xff, resources, &iobase);
> > +	if (err)
> > +		return err;
> > +
> > +	err = devm_request_pci_bus_resources(dev, resources);
> > +	if (err)
> > +		return err;
> > +
> > +	resource_list_for_each_entry_safe(win, tmp, resources) {
> > +		struct resource *res = win->res;
> > +
> > +		switch (resource_type(res)) {
> > +		case IORESOURCE_IO:
> > +			err = pci_remap_iospace(res, iobase);
> > +			if (err) {
> > +				dev_warn(dev, "error %d: failed to map resource %pR\n",
> > +					 err, res);
> > +				resource_list_destroy_entry(win);
> > +			}
> > +			break;
> > +		case IORESOURCE_MEM:
> > +			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
> > +			break;
> > +		case IORESOURCE_BUS:
> > +			*bus_range = res;
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (res_valid)
> > +		return 0;
> > +
> > +	dev_err(dev, "non-prefetchable memory resource required\n");
> > +	return -EINVAL;
> > +}
> 
> The code above is starting to look awfully familiar.  I wonder if it's
> time to think about some PCI-internal interface that can encapsulate
> this.  In this case, there's really nothing Cadence-specific here.
> There are other callers where there *is* vendor-specific code, but
> possibly that could be handled by returning pointers to bus number,
> I/O port, and MMIO resources so the caller could do the
> vendor-specific stuff?

Yes and that's not the only one, pattern below is duplicated
(with some minor differences across host bridges that I think
can be managed through function parameters), it is probably worth
moving them both into a core code helper.

list_splice_init(&resources, &bridge->windows);
bridge->dev.parent = dev;
bridge->busnr = bus;
bridge->ops = &pci_ops;
bridge->map_irq = of_irq_parse_and_map_pci;
bridge->swizzle_irq = pci_common_swizzle;

ret = pci_scan_root_bus_bridge(bridge);
if (ret < 0) {
	dev_err(dev, "Scanning root bridge failed");
	goto err_init;
}

bus = bridge->bus;
pci_bus_size_bridges(bus);
pci_bus_assign_resources(bus);

list_for_each_entry(child, &bus->children, node)
	pcie_bus_configure_settings(child);

pci_bus_add_devices(bus);
