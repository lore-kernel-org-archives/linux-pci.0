Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:24211 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933466Ab3GWXWT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 23 Jul 2013 19:22:19 -0400
Message-ID: <1374621703.15429.98.camel@ul30vt.home>
Subject: Re: [RFC PATCH v2 1/2] pci: Create PCIe requester ID interface
From: Alex Williamson <alex.williamson@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, joro@8bytes.org,
	iommu@lists.linux-foundation.org, acooks@gmail.com,
	ddutile@redhat.com, dwmw2@infradead.org
Date: Tue, 23 Jul 2013 17:21:43 -0600
In-Reply-To: <20130723223533.GB19765@google.com>
References: <20130711204439.1701.90503.stgit@bling.home>
	 <20130711210326.1701.56478.stgit@bling.home>
	 <20130723223533.GB19765@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2013-07-23 at 16:35 -0600, Bjorn Helgaas wrote:
> On Thu, Jul 11, 2013 at 03:03:27PM -0600, Alex Williamson wrote:
> > This provides interfaces for drivers to discover the visible PCIe
> > requester ID for a device, for things like IOMMU setup, and iterate
> 
> IDs (plural)

How does a device can't have multiple requester IDs?  Reading below, I'm
not sure we're on the same page for the purpose of this patch.

> > over the device chain from requestee to requester, including DMA
> > quirks at each step.
> 
> "requestee" doesn't make sense to me.  The "-ee" suffix added to a verb
> normally makes a noun that refers to the object of the action.  So
> "requestee" sounds like it means something like "target" or "responder,"
> but that's not what you mean here.

Hmm, ok.  I figured a request-er makes a request on behalf of a
request-ee.  Suggestions?

> > Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> >  drivers/pci/search.c |  198 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/pci.h  |    7 ++
> >  2 files changed, 205 insertions(+)
> > 
> > diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> > index d0627fa..4759c02 100644
> > --- a/drivers/pci/search.c
> > +++ b/drivers/pci/search.c
> > @@ -18,6 +18,204 @@ DECLARE_RWSEM(pci_bus_sem);
> >  EXPORT_SYMBOL_GPL(pci_bus_sem);
> >  
> >  /*
> > + * pci_has_pcie_requester_id - Does @dev have a PCIe requester ID
> > + * @dev: device to test
> > + */
> > +static bool pci_has_pcie_requester_id(struct pci_dev *dev)
> > +{
> > +	/*
> > +	 * XXX There's no indicator of the bus type, conventional PCI vs
> > +	 * PCI-X vs PCI-e, but we assume that a caller looking for a PCIe
> > +	 * requester ID is a native PCIe based system (such as VT-d or
> > +	 * AMD-Vi).  It's common that PCIe root complex devices do not
> > +	 * include a PCIe capability, but we can assume they are PCIe
> > +	 * devices based on their topology.
> > +	 */
> > +	if (pci_is_pcie(dev) || pci_is_root_bus(dev->bus))
> > +		return true;
> > +
> > +	/*
> > +	 * PCI-X devices have a requester ID, but the bridge may still take
> > +	 * ownership of transactions and create a requester ID.  We therefore
> > +	 * assume that the PCI-X requester ID is not the same one used on PCIe.
> > +	 */
> > +
> > +#ifdef CONFIG_PCI_QUIRKS
> > +	/*
> > +	 * Quirk for PCIe-to-PCI bridges which do not expose a PCIe capability.
> > +	 * If the device is a bridge, look to the next device upstream of it.
> > +	 * If that device is PCIe and not a PCIe-to-PCI bridge, then by
> > +	 * deduction, the device must be PCIe and therefore has a requester ID.
> > +	 */
> > +	if (dev->subordinate) {
> > +		struct pci_dev *parent = dev->bus->self;
> > +
> > +		if (pci_is_pcie(parent) &&
> > +		    pci_pcie_type(parent) != PCI_EXP_TYPE_PCI_BRIDGE)
> > +			return true;
> > +	}
> > +#endif
> > +
> > +	return false;
> > +}
> > +
> > +/*
> > + * pci_has_visible_pcie_requester_id - Can @bridge see @dev's requester ID?
> > + * @dev: requester device
> > + * @bridge: upstream bridge (or NULL for root bus)
> > + */
> > +static bool pci_has_visible_pcie_requester_id(struct pci_dev *dev,
> > +					      struct pci_dev *bridge)
> > +{
> > +	/*
> > +	 * The entire path must be tested, if any step does not have a
> > +	 * requester ID, the chain is broken.  This allows us to support
> > +	 * topologies with PCIe requester ID gaps, ex: PCIe-PCI-PCIe
> > +	 */
> > +	while (dev != bridge) {
> > +		if (!pci_has_pcie_requester_id(dev))
> > +			return false;
> > +
> > +		if (pci_is_root_bus(dev->bus))
> > +			return !bridge; /* false if we don't hit @bridge */
> > +
> > +		dev = dev->bus->self;
> > +	}
> > +
> > +	return true;
> > +}
> > +
> > +/*
> > + * Legacy PCI bridges within a root complex (ex. Intel 82801) report
> > + * a different requester ID than a standard PCIe-to-PCI bridge.  Instead
> > + * of using (subordinate << 8 | 0) the use (bus << 8 | devfn), like a
> 
> s/the/they/
> 
> Did you learn about this empirically?  Intel spec?  I wonder if there's
> some way to derive this from the PCIe specs.

It's in the current intel-iommu logic, pretty much anywhere it uses
pci_find_upstream_pcie_bridge() it follows that up with a pci_is_pcie()
check.  If it's PCIe, it uses a traditional PCIe-to-PCI bridge ID.  If
it's a legacy PCI bridge it uses the bridge ID itself.

static int
domain_context_mapping(struct dmar_domain *domain, struct pci_dev *pdev,
                        int translation)
{
...
        /* dependent device mapping */
        tmp = pci_find_upstream_pcie_bridge(pdev);
        if (!tmp)
                return 0;
...
        if (pci_is_pcie(tmp)) /* this is a PCIe-to-PCI bridge */
                return domain_context_mapping_one(domain,
                                        pci_domain_nr(tmp->subordinate),
                                        tmp->subordinate->number, 0,
                                        translation);
        else /* this is a legacy PCI bridge */
                return domain_context_mapping_one(domain,
                                                  pci_domain_nr(tmp->bus),
                                                  tmp->bus->number,
                                                  tmp->devfn,
                                                  translation);

The 82801 reference is from looking at when this would actually happen
on one of my own systems.


> > + * standard PCIe endpoint.  This function detects them.
> > + *
> > + * XXX Is this Intel vendor ID specific?
> > + */
> > +static bool pci_bridge_uses_endpoint_requester(struct pci_dev *bridge)
> > +{
> > +	if (!pci_is_pcie(bridge) && pci_is_root_bus(bridge->bus))
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> > +#define PCI_REQUESTER_ID(dev)	(((dev)->bus->number << 8) | (dev)->devfn)
> > +#define PCI_BRIDGE_REQUESTER_ID(dev)	((dev)->subordinate->number << 8)
> > +
> > +/*
> > + * pci_get_visible_pcie_requester - Get requester and requester ID for
> > + *                                  @requestee below @bridge
> > + * @requestee: requester device
> > + * @bridge: upstream bridge (or NULL for root bus)
> > + * @requester_id: location to store requester ID or NULL
> > + */
> > +struct pci_dev *pci_get_visible_pcie_requester(struct pci_dev *requestee,
> > +					       struct pci_dev *bridge,
> > +					       u16 *requester_id)
> 
> I'm not sure it makes sense to return a struct pci_dev here because
> there's no requirement that a requester ID correspond to an actual
> pci_dev.

That's why this function is named get_.._requester instead of requester
ID.  I believe there still has to be a struct pci_dev that does the
request, but the requester ID for that device may not actually match.
So I return both.  In a PCIe-to-PCI bridge case, the pci_dev is the
bridge, but the requester ID is either the bridge bus|devfn or
subordinate|0 depending on the topology.  If we want to support "ghost
functions", we can return the real pci_dev and a ghost requester ID.

I think if we used just a requester ID, it ends up being extremely
difficult to pass that into anything else since we then have to search
again for where that requester ID is rooted.

> > +{
> > +	struct pci_dev *requester = requestee;
> > +
> > +	while (requester != bridge) {
> > +		requester = pci_get_dma_source(requester);
> > +		pci_dev_put(requester); /* XXX skip ref cnt */
> > +
> > +		if (pci_has_visible_pcie_requester_id(requester, bridge))
> 
> If we acquire the "requester" pointer via a ref-counting interface,
> it's illegal to use the pointer after dropping the reference, isn't it?
> Maybe that's what you mean by the "XXX" comment.


Yes, I was just following your RFC lead and didn't want to deal with
reference counting until this approach had enough traction.


> > +			break;
> > +
> > +		if (pci_is_root_bus(requester->bus))
> > +			return NULL; /* @bridge not parent to @requestee */
> > +
> > +		requester = requester->bus->self;
> > +	}
> > +
> > +	if (requester_id) {
> > +		if (requester->bus != requestee->bus &&
> > +		    !pci_bridge_uses_endpoint_requester(requester))
> > +			*requester_id = PCI_BRIDGE_REQUESTER_ID(requester);
> > +		else
> > +			*requester_id = PCI_REQUESTER_ID(requester);
> > +	}
> > +
> > +	return requester;
> > +}
> > +
> > +static int pci_do_requester_callback(struct pci_dev **dev,
> > +				     int (*fn)(struct pci_dev *,
> > +					       u16 id, void *),
> > +				     void *data)
> > +{
> > +	struct pci_dev *dma_dev;
> > +	int ret;
> > +
> > +	ret = fn(*dev, PCI_REQUESTER_ID(*dev), data);
> > +	if (ret)
> > +		return ret;
> > +
> > +	dma_dev = pci_get_dma_source(*dev);
> > +	pci_dev_put(dma_dev); /* XXX skip ref cnt */
> > +	if (dma_dev == *dev)
> 
> Same ref count question as above.
> 
> > +		return 0;
> > +
> > +	ret = fn(dma_dev, PCI_REQUESTER_ID(dma_dev), data);
> > +	if (ret)
> > +		return ret;
> > +
> > +	*dev = dma_dev;
> > +	return 0;
> > +}
> > +
> > +/*
> > + * pcie_for_each_requester - Call callback @fn on each devices and DMA source
> > + *                           from @requestee to the PCIe requester ID visible
> > + *                           to @bridge.
> 
> Transactions from a device may appear with one of several requester IDs,
> but there's not necessarily an actual pci_dev for each ID, so I think the
> caller reads better if it's "...for_each_requester_id()"

Wouldn't you expect to pass a requester ID into a function with that
name?  I'm pretty sure I had it named that at one point but thought the
parameters made more sense this way.  I'll see if I can think of a
better name.

> The "Call X on each devices and DMA source from Y to the requester ID"
> part doesn't quite make a sentence.


Ok

> > + * @requestee: Starting device
> > + * @bridge: upstream bridge (or NULL for root bus)
> 
> You should say something about the significance of @bridge.  I think the
> point is to call @fn for every possible requester ID @bridge could see for
> transactions from @requestee.  This is a way to learn the requester IDs an
> IOMMU at @bridge needs to be prepared for.

I can add something.  @bridge is supposed to be for bridge-based IOMMUs.
Essentially it's just a stopping point.  There might be PCI topology
upstream of @bridge, but if you only want the requester ID seen by the
bridge, you don't care.

> > + * @fn: callback function
> > + * @data: data to pass to callback
> > + */
> > +int pcie_for_each_requester(struct pci_dev *requestee, struct pci_dev *bridge,
> > +			    int (*fn)(struct pci_dev *, u16 id, void *),
> > +			    void *data)
> > +{
> > +	struct pci_dev *requester;
> > +	struct pci_dev *dev = requestee;
> > +	int ret = 0;
> > +
> > +	requester = pci_get_visible_pcie_requester(requestee, bridge, NULL);
> > +	if (!requester)
> > +		return -EINVAL;
> > +
> > +	do {
> > +		ret = pci_do_requester_callback(&dev, fn, data);
> > +		if (ret)
> > +			return ret;
> > +
> > +		if (dev == requester)
> > +			return 0;
> > +
> > +		/*
> > +		 * We always consider root bus devices to have a visible
> > +		 * requester ID, therefore this should never be true.
> > +		 */
> > +		BUG_ON(pci_is_root_bus(dev->bus));
> 
> What are we going to do if somebody hits this BUG_ON()?  If it's impossible
> to hit, we should just remove it.  If it's possible to hit it in some weird
> topology you didn't consider, we should see IOMMU faults for any requester
> ID we neglected to map, and that fault would be a better debugging hint
> than a BUG_ON() here.

It's mostly for readability.  I've learned that we never what to look at
dev->bus->self without first testing pci_is_root_bus(dev->bus), so if I
was reading this code I'd stumble when I got here and spend too long
looking around for the assumption that makes it not needed.  I suppose I
could just make it a comment, but I thought why not make it official w/
a BUG.

> > +
> > +		dev = dev->bus->self;
> > +
> > +	} while (dev != requester);
> > +
> > +	/*
> > +	 * If we've made it here, @requester is a bridge upstream from
> > +	 * @requestee.
> > +	 */
> > +	if (pci_bridge_uses_endpoint_requester(requester))
> > +		return pci_do_requester_callback(&requester, fn, data);
> > +
> > +	return fn(requester, PCI_BRIDGE_REQUESTER_ID(requester), data);
> > +}
> > +
> > +/*
> >   * find the upstream PCIe-to-PCI bridge of a PCI device
> >   * if the device is PCIE, return NULL
> >   * if the device isn't connected to a PCIe bridge (that is its parent is a
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 3a24e4f..94e81d1 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -1873,6 +1873,13 @@ static inline struct eeh_dev *pci_dev_to_eeh_dev(struct pci_dev *pdev)
> >  }
> >  #endif
> >  
> > +struct pci_dev *pci_get_visible_pcie_requester(struct pci_dev *requestee,
> > +					       struct pci_dev *bridge,
> > +					       u16 *requester_id);
> 
> The structure of this interface implies that there is only one visible
> requester ID, but the whole point of this patch is that a transaction from
> @requestee may appear with one of several requester IDs.  So which one will
> this return?

I thought the point of this patch was to have an integrated interface
for finding the requester ID and doing something across all devices with
that requester ID and thereby remove pci_find_upstream_pcie_bridge(),
provide a way to quirk broken PCIe-to-PCI bridge and quirk dma_ops for
devices that use the wrong requester ID.  In what case does a device
appear to have multiple requester IDs?  We have cases where devices use
the wrong requester ID, but AFAIK they only use a single wrong requester
ID.  Thanks,

Alex

> > +int pcie_for_each_requester(struct pci_dev *requestee, struct pci_dev *bridge,
> > +			    int (*fn)(struct pci_dev *, u16 id, void *),
> > +			    void *data);
> > +
> >  /**
> >   * pci_find_upstream_pcie_bridge - find upstream PCIe-to-PCI bridge of a device
> >   * @pdev: the PCI device
> > 



