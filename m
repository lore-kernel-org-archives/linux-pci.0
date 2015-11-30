Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 30 Nov 2015 11:19:49 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Keith Busch <keith.busch@intel.com>,
	Hans de Bruin <jmdebruin@xmsnet.nl>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Arthur Marsh <arthur.marsh@internode.on.net>
Subject: Re: [PATCH] x86/PCI: Fix regression caused by commit 4d6b4e69a245
Message-ID: <20151130171949.GA29242@localhost>
References: <5655B392.7070701@intel.com>
 <8206751.4eTpiUuo7l@vostro.rjw.lan>
 <565BA446.7080003@linux.intel.com>
 <2099144.E7yRfeyfk4@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2099144.E7yRfeyfk4@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 30, 2015 at 03:11:14AM +0100, Rafael J. Wysocki wrote:
> On Monday, November 30, 2015 09:20:06 AM Jiang Liu wrote:
> > On 2015/11/28 0:06, Rafael J. Wysocki wrote:
> > > On Friday, November 27, 2015 11:12:33 AM Jiang Liu wrote:
> > >> From: Liu Jiang <jiang.liu@linux.intel.com>
> > >>
> > >> Commit 4d6b4e69a245 ("x86/PCI/ACPI: Use common interface to support
> > >> PCI host bridge") converted x86 to use the common interface
> > >> acpi_pci_root_create, but the conversion missed on code piece in
> > >> arch/x86/pci/bus_numa.c, which causes regression on some legacy
> > >> AMD platforms as reported by Arthur Marsh <arthur.marsh@internode.on.net>.
> > >> The root causes is that acpi_pci_root_create() fails to insert
> > >> host bridge resources into iomem_resource/ioport_resource because
> > >> x86_pci_root_bus_resources() has already inserted those resources.
> > >> So change x86_pci_root_bus_resources() to not insert resources into
> > >> iomem_resource/ioport_resource.
> > >>
> > >> Fixes: 4d6b4e69a245 ("x86/PCI/ACPI: Use common interface to support PCI host bridge")
> > >> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> > >> Reported-and-tested-by: Arthur Marsh <arthur.marsh@internode.on.net>
> > >> Cc: Keith Busch <keith.busch@intel.com>
> > >> Cc: Arthur Marsh <arthur.marsh@internode.on.net>
> > >> Cc: Hans de Bruin <jmdebruin@xmsnet.nl>
> > > 
> > > What exactly has changed between this version and the previous one?
> > Hi Rafael,
> > 	I have removed following changes against the original patch
> > posted at Nov 16.
> >  	       bus);
> > 
> >  	/* already added by acpi ? */
> > -	resource_list_for_each_entry(window, resources)
> > +	resource_list_for_each_entry(window, &info->resources)
> >  		if (window->res->flags & IORESOURCE_BUS) {
> >  			found = true;
> >  			break;
> >  		}
> > -
> >  	if (!found)
> >  		pci_add_resource(resources, &info->busn);
> > 
> > And I only refined the commit message based on the test patch
> > I sent to Authur as an attachment at Nov 25.
> 
> OK, thanks.
> 
> Keith, Hans, can you test this version too please?
> 
> Bjorn, any more comments from you on this one?

I haven't reviewed it in detail, but I don't have any objections to it.

Bjorn
