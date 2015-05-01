Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37552 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750843AbbEAIkR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 1 May 2015 04:40:17 -0400
Date: Fri, 1 May 2015 09:40:14 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: "Jayachandran C." <jchandra@broadcom.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Will Deacon <Will.Deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [RFC PATCH 1/2] PCI: generic: remove dependency on hw_pci
Message-ID: <20150501084014.GA6174@red-moon>
References: <1430307599-20536-1-git-send-email-jchandra@broadcom.com>
 <6662179.AoBfCMOsxD@wuerfel>
 <20150429174356.GA20947@red-moon>
 <20150430095949.GJ2992@jayachandranc.netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150430095949.GJ2992@jayachandranc.netlogicmicro.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 30, 2015 at 10:59:50AM +0100, Jayachandran C. wrote:
> On Wed, Apr 29, 2015 at 06:43:57PM +0100, Lorenzo Pieralisi wrote:
> > On Wed, Apr 29, 2015 at 01:34:20PM +0100, Arnd Bergmann wrote:
> > > On Wednesday 29 April 2015 17:09:58 Jayachandran C wrote:
> > > > The current code in pci-host-generic.c uses pci_common_init_dev()
> > > > from the arch/arm/ to do a part of the PCI initialization, and this
> > > > prevents it from being used on arm64.
> > > > 
> > > > The initialization done by pci_common_init_dev() that is really
> > > > needed by pci-host-generic.c can be done in the same file without
> > > > using the hw_pci API of ARM.
> > > > 
> > > > The ARM platform requires a pci_sys_data as sysdata for the PCI bus,
> > > > this is be handled by setting up 'struct gen_pci' to embed a
> > > > pci_sys_data variable as the first element on the ARM platform.
> > > > 
> > > > Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> > > 
> > > This seems very useful
> > 
> > Yes, it is getting less awful, waiting for pci_sys_data to disappear.
> > 
> > > > -static int gen_pci_setup(int nr, struct pci_sys_data *sys)
> > > > +static int gen_pci_init(struct device *dev, struct gen_pci *pci)
> > > >  {
> > > > -	struct gen_pci *pci = sys->private_data;
> > > > -	list_splice_init(&pci->resources, &sys->resources);
> > > > -	return 1;
> > > > +	struct pci_bus *bus;
> > > > +
> > > > +	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
> > > 
> > > Do we want to set that flag unconditionally? At least for servers,
> > > the resources should get assigned by firmware, and things might
> > > go wrong if Linux tries to reassign them. This is probably the
> > > case on kvmtool as well.
> 
> I can skip setting this flag if PCI_PROBE_ONLY is set. Adding another
> device tree parameter for this may not be needed.

I think that's reasonable for the time being.

> > I will give it a go on kvmtool, but at first glance concern is
> > shared.
> > 
> > > > +	bus = pci_scan_root_bus(dev, 0, &gen_pci_ops, pci, &pci->resources);
> > > > +	if (!bus) {
> > > > +		dev_err(dev, "Scanning rootbus failed");
> > > > +		return -ENODEV;
> > > > +	}
> > > > +	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> > > 
> > > I thought this was done by default now. If it is not, can
> > > we make the of_irq swizzling the default?
> > 
> > Possibly yes.
> 
> I am not sure I understand this, I thought pci_fixup_irqs needs to be
> called at this point.

What we meant is that passing of_irq_parse_and_map_pci as a mapping
function is the most common option, but I do not think there is much
you can do at the moment apart from adding a pci_of_fixup_irqs function
to the generic PCI layer and calling that instead, I do not see where
the improvement is, so I think you can leave it as it is.

> > > > +	if (!pci_has_flag(PCI_PROBE_ONLY)) {
> > > > +		pci_bus_size_bridges(bus);
> > > > +		pci_bus_assign_resources(bus);
> > > > +	}
> > > > +	pci_bus_add_devices(bus);
> > > > +
> > > > +	/* Configure PCI Express settings */
> > > > +	if (pci_has_flag(PCI_PROBE_ONLY)) {
> > > > +		struct pci_bus *child;
> > > > +
> > > > +		list_for_each_entry(child, &bus->children, node)
> > > > +			pcie_bus_configure_settings(child);
> > > > +	}
> > > > +	return 0;
> > > >  }
> > > 
> > > We should also try to come up wtih a way to make that
> > > pcie_bus_configure_settings() automatic if it's required here.
> > > 
> > > >  static int gen_pci_probe(struct platform_device *pdev)
> > > > @@ -214,13 +237,6 @@ static int gen_pci_probe(struct platform_device *pdev)
> > > >  	struct device *dev = &pdev->dev;
> > > >  	struct device_node *np = dev->of_node;
> > > >  	struct gen_pci *pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
> > > > -	struct hw_pci hw = {
> > > > -		.nr_controllers	= 1,
> > > > -		.private_data	= (void **)&pci,
> > > > -		.setup		= gen_pci_setup,
> > > > -		.map_irq	= of_irq_parse_and_map_pci,
> > > > -		.ops		= &gen_pci_ops,
> > > > -	};
> > > >  
> > > >  	if (!pci)
> > > >  		return -ENOMEM;
> > > > @@ -258,8 +274,7 @@ static int gen_pci_probe(struct platform_device *pdev)
> > > >  		return err;
> > > >  	}
> > > >  
> > > > -	pci_common_init_dev(dev, &hw);
> > > > -	return 0;
> > > > +	return gen_pci_init(dev, pci);
> > > 
> > > How about moving the new code right into the probe() function?
> > 
> > +1.
> 
> I will add this to patch v2.
>  
> > I suspect the PCI_PROBE_ONLY case was not tested on arm64, since we
> > still need a patch to prevent resources enablement there (in the
> > pcibios_enable_device call - actually the check for PCI_PROBE_ONLY
> > should be moved to the default pcibios_enable_device function in
> > drivers/pci/pci.c).
> > 
> > The other bit missing is MSI handling, that should still be implemented.
> 
> I think we should parse msi-parent and set ->msi on the root bus in
> pci-host-generic.c. The implementation of pcibios_msi_controller() for
> arm/arm64 can go up the bus hierarchy and return the first msi
> controller it finds. This would be trivial to add to arm/arm64.
> I can post a follow up patch for this if you are interested.

I do not want to see a pcibios_msi_controller implementation on arm64,
or put it differently what you are proposing has nothing in it arm64
specific, we need to find a solution that goes into generic code, there
is already, pending further discussion:

http://lwn.net/Articles/628872/

Thanks,
Lorenzo
