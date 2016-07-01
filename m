Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39852 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752000AbcGAQJg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 1 Jul 2016 12:09:36 -0400
Date: Fri, 1 Jul 2016 17:09:23 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tomasz Nowicki <tn@semihalf.com>, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Add new method for registering PCI hosts
Message-ID: <20160701160923.GF8609@e106497-lin.cambridge.arm.com>
References: <20160630151931.29216-1-thierry.reding@gmail.com>
 <20160701144648.GC8609@e106497-lin.cambridge.arm.com>
 <4061641.rLdO1g8OBR@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4061641.rLdO1g8OBR@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 01, 2016 at 05:44:09PM +0200, Arnd Bergmann wrote:
> On Friday, July 1, 2016 3:46:48 PM CEST Liviu Dudau wrote:
> > On Thu, Jun 30, 2016 at 05:19:30PM +0200, Thierry Reding wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > > 
> > > This patch makes the existing pci_host_bridge structure a proper device
> > > that is usable by PCI host drivers in a more standard way. In addition
> > > to the existing pci_scan_bus, pci_scan_root_bus, pci_scan_root_bus_msi,
> > > and pci_create_root_bus interfaces, this unfortunately means having to
> > > add yet another interface doing basically the same thing, and add some
> > > extra code in the initial step.
> > > 
> > > However, this time it's more likely to be extensible enough that we
> > > won't have to do another one again in the future, and we should be
> > > able to reduce code much more as a result.
> > 
> > I am really disapointed by the direction in which the whole pci_host_bridge
> > structure and associated functions is going. When I started to get involved
> > in this mess that is the creation of a root PCI bus I was hoping that we
> > are moving towards one or few functions that create the root bus by using
> > the details provided in the host bridge without having so many variants for
> > the functionality.
> 
> That is the plan, we just never made a lot of progress here.
> 
> > One reason for this holy mess is the duplication of information. Both root
> > bus and the pci_host_bridge hold pointers to useful information (msi_controller,
> > pci_ops) and coherency should be guaranteed when one or the other gets created.
> > Hence the ridiculous dance being done to find if root bus hasn't already been
> > created and if not reusing the scrap bus we have created at the top of
> > pci_create_root_bus() to actually set the data, then create the pci_host_bridge,
> > oops we need more information, and so on. (apologies for the incoherent style,
> > I'm trying to duplicate the spirit of the probe.c code :) )
> 
> Agreed.
> 
> > I think this patchset has the right intention but it is not doing it in
> > the right way. To me, the right way is to separate the whole allocation
> > of the pci_host_bridge structure from the scanning or the root bus (keeping the
> > INIT_LIST_HEAD(&bridge->windows) call inside), not add the sysdata pointer
> > *at all* to pci_host_bridge, move the information from pci_bus into pci_host_bridge
> > and make pci_scan_root_bus take a pci_host_bridge pointer once that has been
> > done.
> 
> Again, this is what I'm doing here, unfortunately we cannot remove the
> sysdata pointer altogether as we still have over a hundred existing PCI
> host bridge implementations that all use sysdata.
> 
> > Think of the code structure as a reflection of how the system is structured: the
> > PCI-to-host bridge is a structure that holds the information required to connect
> > the functionality of the host code (msi_controller, host-to-bus resource windows)
> > to the PCI(e) bus. The root pci_bus should only have PCI(e) bus information if
> > possible.
> 
> Exactly.
> 
> > > 
> > > The main idea is to pull the allocation of 'struct pci_host_bridge' out
> > > of the registration, and let individual host drivers and architecture
> > > code fill the members before calling the registration function.
> > 
> > That's how we got into the arch/arm mess that we currently have. The host driver
> > should not drive the instantiation of the pci_host_bridge structure because it
> > will prevent you from having two drivers running at the same time.
> 
> Can you clarify that? I don't see what prevents two drivers from each
> creating a pci_host_bridge structure and passing it into
> pci_host_bridge_register().

Maybe I'm exagerating a bit, but I always disliked the pci_common_init() function and
the way it is creating a pci_host_bridge while relying on hw_pci hooks to get
things ready. I'm pretty sure there are still issues around the fact that a lot of
platform drivers have a subsys_initcall() function that calls pci_common_init(). I
don't want us to go down that path again.

Don't get me wrong, clearly someone needs to create an instance of pci_host_bridge.
What I want people to accept is that in the PCI(e) architecture there is nothing that
stops a piece of HW that used to be the bridge between host and underlying bus into
becoming the bridge between a higher PCI(e) bus and the bus underneath. If the writes
to the configuration registers happens somehow, the Host Bridge doesn't even know if
it is talking to the actual host. Can the driver in that case make sure it did not made
assumptions that were tied to a specific SoC implementation?

> 
> > > -static struct pci_host_bridge *pci_alloc_host_bridge(struct pci_bus *b)
> > > -{
> > > -	struct pci_host_bridge *bridge;
> > > -
> > > -	bridge = kzalloc(sizeof(*bridge), GFP_KERNEL);
> > > -	if (!bridge)
> > > -		return NULL;
> > > -
> > > -	INIT_LIST_HEAD(&bridge->windows);
> > > -	bridge->bus = b;
> > > -	return bridge;
> > > -}
> > > -
> > 
> > You might have strong arguments for removing this function but they are not properly
> > explained here and I feel that they should. Specially as ....
> 
> In my initial version, it simply became unnecessary because all callers
> of pci_host_bridge_register() would have to allocate it anyway, and with
> the pci_bus assignment gone, it didn't do much at all.
> 
> > >  static const unsigned char pcix_bus_speed[] = {
> > >  	PCI_SPEED_UNKNOWN,		/* 0 */
> > >  	PCI_SPEED_66MHz_PCIX,		/* 1 */
> > > @@ -2117,53 +2104,56 @@ void __weak pcibios_remove_bus(struct pci_bus *bus)
> > >  {
> > >  }
> > >  
> > > -struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
> > > -		struct pci_ops *ops, void *sysdata, struct list_head *resources)
> > > +void pci_host_bridge_init(struct pci_host_bridge *bridge)
> > > +{
> > > +	INIT_LIST_HEAD(&bridge->windows);
> > > +}
> > > +EXPORT_SYMBOL_GPL(pci_host_bridge_init);
> > 
> > I have no idea why it is useful to re-initialise the bridge->windows list at any
> > time other than allocation time.
> 
> That's why I suggested doing this in the allocation function now.

Understood. Thanks for the explanations, I did not manage to keep track of all the old
discussions around PCIe, specially if they were prefixed with ACPI ;)

Best regards,
Liviu

> 
> > > +int pci_host_bridge_register(struct pci_host_bridge *bridge)
> > >  {
> > >  	int error;
> > > -	struct pci_host_bridge *bridge;
> > >  	struct pci_bus *b, *b2;
> > >  	struct resource_entry *window, *n;
> > > +	LIST_HEAD(resources);
> > >  	struct resource *res;
> > >  	resource_size_t offset;
> > >  	char bus_addr[64];
> > >  	char *fmt;
> > > +	struct device *parent = bridge->dev.parent;
> > >  
> > >  	b = pci_alloc_bus(NULL);
> > >  	if (!b)
> > > -		return NULL;
> > > +		return -ENOMEM;
> > > +	bridge->bus = b;
> > >  
> > > -	b->sysdata = sysdata;
> > > -	b->ops = ops;
> > > -	b->number = b->busn_res.start = bus;
> > > +	/* temporarily move resources off the list */
> > > +	list_splice_init(&bridge->windows, &resources);
> > 
> > What are you trying to accomplish here with the moving around of the bridge->windows list
> > elements? This also leaves the bridge->windows list empty afterwards, is that intended?
> 
> I was trying to preserve the existing behavior, this can probably
> be simplified, but as my initial version was completely untested
> I decided not to touch it.
> 
> Later in the function, the list is filled one entry at a time from
> the local 'resources' list that we traditionally passed as a function
> argument before.
> 
> Ideally we'd just walk the list instead of doing the
> split/list_del/list_add dance, and this would be a logical
> cleanup on top of this patch.
> 
> > > @@ -817,6 +821,8 @@ struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops, void *sysdata);
> > >  struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
> > >  				    struct pci_ops *ops, void *sysdata,
> > >  				    struct list_head *resources);
> > > +void pci_host_bridge_init(struct pci_host_bridge *bridge);
> > > +int pci_host_bridge_register(struct pci_host_bridge *bridge);
> > >  int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int busmax);
> > >  int pci_bus_update_busn_res_end(struct pci_bus *b, int busmax);
> > >  void pci_bus_release_busn_res(struct pci_bus *b);
> > 
> > There is too much stuff moving around. I know it is needed and the temptation is to get it
> > done as quickly as possible, but it makes the reviewing and the commenting on this series hard.
> 
> This is why I left the list handling you mentioned above unchanged
> in my original patch instead of rewriting it.
> 
> > Can you split the patch into one that adds the new members
> > into pci_host_bridge, then do the renaming/re-organisation in
> > another patch?
> 
> That should be possible, I guess Thierry can deal with that when respinning
> the series.
> 
> 	Arnd
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
