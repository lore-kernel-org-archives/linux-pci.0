Return-Path: <Liviu.Dudau@arm.com>
Return-Path: <Liviu.Dudau@arm.com>
Date: Tue, 3 May 2016 11:04:23 +0100
From: Liviu.Dudau@arm.com
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <helgaas@kernel.org>,
	catalin.marinas@arm.com, linux-pci@vger.kernel.org,
	will.deacon@arm.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>, ddaney@caviumnetworks.com,
	robert.richter@caviumnetworks.com, msalter@redhat.com,
	jchandra@broadcom.com, linux-kernel@vger.kernel.org,
	hanjun.guo@linaro.org, Suravee.Suthikulpanit@amd.com
Subject: Re: [PATCH 1/3] [RFC] pci: add new method for register PCI hosts
Message-ID: <20160503100422.GZ28464@e106497-lin.cambridge.arm.com>
References: <1461970899-4150603-1-git-send-email-arnd@arndb.de>
 <1461970899-4150603-2-git-send-email-arnd@arndb.de>
 <20160502070943.GB27465@ulmo.ba.sec>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20160502070943.GB27465@ulmo.ba.sec>
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 02, 2016 at 09:09:43AM +0200, Thierry Reding wrote:
> On Sat, Apr 30, 2016 at 01:01:37AM +0200, Arnd Bergmann wrote:
> > This patch makes the existing 'pci_host_bridge' structure a proper device
> > that is usable by PCI host drivers in a more standard way. In addition
> > to the existing pci_scan_bus, pci_scan_root_bus, pci_scan_root_bus_msi,
> > and pci_create_root_bus interfaces, this unfortunately means having to
> > add yet another interface doing basically the same thing, and add some
> > extra code in the initial step.
> > 
> > However, this time it's more likely to be extensible enough that we
> > won't have to do another one again in the future, and we should be
> > able to reduce code much more as a result.
> > 
> > The main idea is to pull the allocation of 'struct pci_host_bridge' out
> > of the registration, and let individual host drivers and architecture
> > code fill the members before calling the registration function.
> > 
> > There are a number of things we can do based on this:
> > 
> > * Use a single memory allocation for the driver-specific structure
> >   and the generic PCI host bridge
> > * consolidate the contents of driver specific structures by moving
> >   them into pci_host_bridge
> > * Add a consistent interface for removing a PCI host bridge again
> >   when unloading a host driver module
> > * Replace the architecture specific __weak pcibios_* functions with
> >   callbacks in a pci_host_bridge device
> > * Move common boilerplate code from host drivers into the generic
> >   function, based on contents of the structure
> > * Extend pci_host_bridge with additional members when needed without
> >   having to add arguments to pci_scan_*.
> > * Move members of struct pci_bus into pci_host_bridge to avoid
> >   having lots of identical copies.
> > 
> > As mentioned in a previous email, one open question is whether we want
> > to export a function for allocating a pci_host_bridge device in
> > combination with the per-device structure or let the driver itself
> > call kzalloc.
> 
> I think the most common pattern in other parts of the kernel is the
> latter. That gives drivers the most flexibility to do whatever they
> want or need.
> 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/pci/probe.c | 100 ++++++++++++++++++++++++++++++----------------------
> >  include/linux/pci.h |   7 +++-
> >  2 files changed, 63 insertions(+), 44 deletions(-)
> > 
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index ae7daeb83e21..fe9d9221b11e 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -520,19 +520,6 @@ static void pci_release_host_bridge_dev(struct device *dev)
> >  	kfree(bridge);
> >  }
> >  
> > -static struct pci_host_bridge *pci_alloc_host_bridge(struct pci_bus *b)
> > -{
> > -	struct pci_host_bridge *bridge;
> > -
> > -	bridge = kzalloc(sizeof(*bridge), GFP_KERNEL);
> > -	if (!bridge)
> > -		return NULL;
> > -
> > -	INIT_LIST_HEAD(&bridge->windows);
> > -	bridge->bus = b;
> > -	return bridge;
> > -}
> > -
> >  static const unsigned char pcix_bus_speed[] = {
> >  	PCI_SPEED_UNKNOWN,		/* 0 */
> >  	PCI_SPEED_66MHz_PCIX,		/* 1 */
> > @@ -2108,51 +2095,47 @@ void __weak pcibios_remove_bus(struct pci_bus *bus)
> >  {
> >  }
> >  
> > -struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
> > -		struct pci_ops *ops, void *sysdata, struct list_head *resources)
> > +int pci_register_host(struct pci_host_bridge *bridge)
> 
> Perhaps pci_register_host_bridge() to mirror the structure name in the
> registration function?
> 
> >  {
> >  	int error;
> > -	struct pci_host_bridge *bridge;
> >  	struct pci_bus *b, *b2;
> >  	struct resource_entry *window, *n;
> > +	LIST_HEAD(resources);
> >  	struct resource *res;
> >  	resource_size_t offset;
> >  	char bus_addr[64];
> >  	char *fmt;
> > +	struct device *parent = bridge->dev.parent;
> >  
> >  	b = pci_alloc_bus(NULL);
> >  	if (!b)
> > -		return NULL;
> > +		return -ENOMEM;
> > +	bridge->bus = b;
> >  
> > -	b->sysdata = sysdata;
> > -	b->ops = ops;
> > -	b->number = b->busn_res.start = bus;
> > +	/* temporarily move resources off the list */
> 
> Might be worth mentioning why we move the resources off the list.
> 
> > +	list_splice_init(&bridge->windows, &resources);
> > +	b->sysdata = bridge->sysdata;
> 
> Does the sysdata not become effectively obsolete after this series? My
> understanding is that it's primarily used to store driver-specific data
> along with a PCI bus, but if drivers can embed struct pci_host_bridge
> they can simply upcast bus->bridge. 

I second that. If we do this change (which is long overdue and I fully support),
let's kill sysdata now. Generic host bridge code doesn't use sysdata on purpose.

Best regards,
Liviu

> I do notice that bus->bridge is
> currently a struct device *, perhaps we can replace it by a back pointer
> to the parent struct pci_host_bridge, which would have to gain a struct
> device *parent to point at the device that instantiated the bridge. This
> is becoming somewhat complicated, but maybe that can be simplified at
> some point.
> 
> > +	b->msi = bridge->msi;
> > +	b->ops = bridge->ops;
> > +	b->number = b->busn_res.start = bridge->busnr;
> >  	pci_bus_assign_domain_nr(b, parent);
> > -	b2 = pci_find_bus(pci_domain_nr(b), bus);
> > +	b2 = pci_find_bus(pci_domain_nr(b), bridge->busnr);
> >  	if (b2) {
> >  		/* If we already got to this bus through a different bridge, ignore it */
> >  		dev_dbg(&b2->dev, "bus already known\n");
> > +		error = -EEXIST;
> >  		goto err_out;
> >  	}
> >  
> > -	bridge = pci_alloc_host_bridge(b);
> > -	if (!bridge)
> > -		goto err_out;
> > -
> > -	bridge->dev.parent = parent;
> > -	bridge->dev.release = pci_release_host_bridge_dev;
> > -	dev_set_name(&bridge->dev, "pci%04x:%02x", pci_domain_nr(b), bus);
> > +	dev_set_name(&bridge->dev, "pci%04x:%02x", pci_domain_nr(b), bridge->busnr);
> >  	error = pcibios_root_bridge_prepare(bridge);
> > -	if (error) {
> > -		kfree(bridge);
> > +	if (error)
> >  		goto err_out;
> > -	}
> >  
> >  	error = device_register(&bridge->dev);
> > -	if (error) {
> > +	if (error)
> >  		put_device(&bridge->dev);
> > -		goto err_out;
> > -	}
> > +
> >  	b->bridge = get_device(&bridge->dev);
> 
> I'm not sure I understand why we continue after failing to register the
> device. Is the usage model here that drivers set up bridge->dev with an
> initial set of values here, such as what the bridge->dev.parent is? One
> complication I can imagine with that is that drivers would need to have
> an implementation for the bridge device's ->release() callback. Perhaps
> this could be simplified by having a default release callback (maybe
> set up by pci_register_host() if none was specified by the driver) that
> calls a callback in struct pci_host_bridge which gets passed a struct
> pci_host_bridge. I think that would make usage more uniform from the
> driver perspective.
> 
> On a side-note, perhaps it would be worth adding a structure that
> carries host bridge operations (struct pci_host_bridge_ops)?
> 
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 81f070a47ee7..8bb5dff617a1 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -400,10 +400,14 @@ static inline int pci_channel_offline(struct pci_dev *pdev)
> >  
> >  struct pci_host_bridge {
> >  	struct device dev;
> > -	struct pci_bus *bus;		/* root bus */
> > +	struct pci_ops *ops;
> > +	void *sysdata;
> > +	int busnr;
> 
> While at it, is there any reason why this can't be made unsigned? I know
> this must sound pedantic, but whenever I see a signed integer variable I
> immediately ask myself what the meaning of negative values would be, and
> I can't think of any scenario where this one could possible be negative.
> But perhaps I'm missing something?
> 
> Thierry



-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
