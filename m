Return-Path: <arnd@arndb.de>
Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: catalin.marinas@arm.com, linux-pci@vger.kernel.org, will.deacon@arm.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Tomasz Nowicki <tn@semihalf.com>, ddaney@caviumnetworks.com, robert.richter@caviumnetworks.com, msalter@redhat.com, Liviu.Dudau@arm.com, jchandra@broadcom.com, linux-kernel@vger.kernel.org, hanjun.guo@linaro.org, Suravee.Suthikulpanit@amd.com, Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/3] [RFC] pci: host-common: use new pci_register_host interface
Date: Thu, 05 May 2016 01:35:32 +0200
Message-ID: <6392987.nMH0fFXVaW@wuerfel>
In-Reply-To: <20160504231418.GE3117@localhost>
References: <1461970899-4150603-1-git-send-email-arnd@arndb.de> <1461970899-4150603-3-git-send-email-arnd@arndb.de> <20160504231418.GE3117@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 04 May 2016 18:14:18 Bjorn Helgaas wrote:
> On Sat, Apr 30, 2016 at 01:01:38AM +0200, Arnd Bergmann wrote:

> >  
> > +static void gen_pci_release(struct device *dev)
> > +{
> > +	struct gen_pci *pci = container_of(dev, struct gen_pci, host.dev);
> > +
> > +	gen_pci_release_of_pci_ranges(pci);
> > +	kfree(pci);
> > +}
> 
> I don't really like the fact that the alloc of struct gen_pci is so
> far away from the free.  I haven't looked hard enough to figure out if
> it's reasonable to put them closer.

It should be easy enough to move the release function next to the
one that does the allocation. If we go the other route of having
a generic pci_host_alloc() function that every host driver has to
call instead of kzalloc(), we can probably drop the need to specify
a release function in each driver.

> > +	err = pci_register_host(&pci->host);
> > +	if (!err) {
> > +		dev_err(dev, "registering host failed");
> > +		return err;
> >  	}
> 
> Where do we actually scan the bus here?  I don't see it in
> pci_register_host().

Ah, you are right, that was a mistake. As I said, I have not
tried running the code. I left this out of pci_register_host()
for compatibility with pci_create_root_bus(), which also doesn't
scan the bus, but then I didn't notice that I effectively remove
the scan during the conversion of this driver.

> >  	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> >  
> >  	if (!pci_has_flag(PCI_PROBE_ONLY)) {
> > -		pci_bus_size_bridges(bus);
> > -		pci_bus_assign_resources(bus);
> > +		pci_bus_size_bridges(pci->host.bus);
> > +		pci_bus_assign_resources(pci->host.bus);
> >  
> > -		list_for_each_entry(child, &bus->children, node)
> > +		list_for_each_entry(child, &pci->host.bus->children, node)
> >  			pcie_bus_configure_settings(child);
> >  	}
> >  
> > -	pci_bus_add_devices(bus);
> > +	pci_bus_add_devices(pci->host.bus);
> >  	return 0;

I was actually thinking we could move both the scan and all the code
above into pci_register_host(), based on some flags or other struct members
we assign in the pci_host_bridge structure, with the most common combination
being the default.

I'm still unsure why we need to do the pci_fixup_irqs() instead of
having the normal irq setting do the right thing, but if necessary,
the host driver can set a flag to ask the core to do it, or we could
add an optional function pointer to the of_irq_parse_and_map_pci
function (or a host specific one if needed) to struct pci_ops and
the call pci_common_swizzle with that.

For all the other stuff (size_bridges, assign_resources, configure_settings,
add_devices), I'd say a host driver should not really have to worry about
this unless it needs to do something special inbetween. Of course
we can't do it for the existing pci_scan_root_bus() etc, because the
callers expect it not to be done.

	Arnd
