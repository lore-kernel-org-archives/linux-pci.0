Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:43543 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322Ab3GHVvf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Jul 2013 17:51:35 -0400
Received: by mail-ie0-f173.google.com with SMTP id k13so11106672iea.18
        for <linux-pci@vger.kernel.org>; Mon, 08 Jul 2013 14:51:34 -0700 (PDT)
Date: Mon, 8 Jul 2013 15:51:31 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: iommu@lists.linux-foundation.org, dwmw2@infradead.org,
	joro@8bytes.org, stephen@networkplumber.org,
	linux-pci@vger.kernel.org, ddutile@redhat.com
Subject: Re: [PATCH v2 0/2] iommu/intel: Quirk non-compliant PCIe-to-PCI
 bridges
Message-ID: <20130708215131.GA1168@google.com>
References: <20130528183527.3318.5365.stgit@bling.home>
 <1373303240.2602.28.camel@ul30vt.home>
 <20130708193436.GA31985@google.com>
 <1373316556.2602.140.camel@ul30vt.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1373316556.2602.140.camel@ul30vt.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 08, 2013 at 02:49:16PM -0600, Alex Williamson wrote:
> On Mon, 2013-07-08 at 13:34 -0600, Bjorn Helgaas wrote:
> > On Mon, Jul 08, 2013 at 11:07:20AM -0600, Alex Williamson wrote:
> > > Joerg,
> > > 
> > > Where do we stand on this series?  You had a concern that the heuristic
> > > used in patch 1/ could be dangerous.  The suggestion for detecting the
> > > issue was actually from Bjorn who replied with his rationale.  Do you
> > > want to go in the direction of a fixed whitelist or do you agree that
> > > even if the heuristic breaks it provides better behavior than what we
> > > have now?  Thanks,
> > 
> > I'm trying to take a step back and look at the overall design, not
> > these specific patches.
> > 
> > IOMMUs translate addresses based on their source, i.e., a PCIe
> > requester ID.  This is made more complicated by the fact that some
> > bridges "take ownership" (change the requester ID as they forward
> > transactions upstream), as well as the fact that conventional PCI has
> > no requester ID at all.  And some broken devices apparently generate
> > DMA requests using the requester ID of another device.
> > 
> > We currently deal with this using the pci_find_upstream_pcie_bridge()
> > and pci_get_dma_source() interfaces, but I think there's too much
> > assembly required by their users.  pci_find_upstream_pcie_bridge()
> > callers normally loop through all the bridges between the "upstream
> > PCIe bridge" and the device, checking for bridges that might take
> > ownership.  They probably also ought to use pci_get_dma_source() to
> > account for the broken devices, but most callers don't.
> > 
> > Most of this is PCI-specific stuff that should be of interest to all
> > IOMMU drivers, and the overall structure of calls and looping should
> > be the same for all of them, so it would be nice to factor it out
> > somehow.
> > 
> > The attached patch is guaranteed not to even compile; it's just to
> > make this idea more concrete.  The basic idea is that since the IOMMU
> > driver wants to perform some action for each possible requester ID the
> > IOMMU might see, PCI could provide an iterator
> > ("pci_for_each_requester_id()") to do that.
> > 
> > Bjorn
> > 
> > 
> > commit afad51492c6672b96c2b0735600d5695e30f7180
> > Author: Bjorn Helgaas <bhelgaas@google.com>
> > Date:   Wed Jul 3 16:04:26 2013 -0600
> > 
> >     pci-add-for-each-requester-id
> > 
> > diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> > index d0627fa..380eb03 100644
> > --- a/drivers/pci/search.c
> > +++ b/drivers/pci/search.c
> > @@ -17,6 +17,89 @@
> >  DECLARE_RWSEM(pci_bus_sem);
> >  EXPORT_SYMBOL_GPL(pci_bus_sem);
> >  
> > +#define PCI_REQUESTER_ID(dev)	(((dev)->bus->number << 8) | (dev)->devfn)
> > +#define PCI_BRIDGE_REQUESTER_ID(bridge)	((bridge)->subordinate->number << 8)
> > +
> > +static inline bool pci_is_pcix(struct pci_dev *dev)
> > +{
> > +	return !!pci_pcix_cap(dev);	/* XXX not implemented */
> > +}
> > +
> > +static bool pci_bridge_may_take_ownership(struct pci_dev *bridge)
> > +{
> > +	/*
> > +	 * A PCIe to PCI/PCI-X bridge may take ownership per PCIe Bridge
> > +	 * Spec v1.0, sec 2.3.
> > +	 */
> > +	if (pci_is_pcie(bridge) &&
> > +	    pci_pcie_type(bridge) == PCI_EXP_TYPE_PCI_BRIDGE)
> > +		return true;
> 
> Assume we still need a quirk here, PCIe-to-PCI bridges without a PCIe
> capability are exactly what causes the current bug.

Likely so.  We might be able to identify that as "secondary bus is not
PCIe" or something.

> > +
> > +	/*
> > +	 * A PCI-X to PCI-X bridge need not take ownership because there
> > +	 * are requester IDs on the secondary PCI-X bus.  However, if a PCI
> > +	 * device is added on the secondary bus, the bridge must revert to
> > +	 * being a PCI-X to PCI bridge, and it then *would* take ownership.
> > +	 * Assuming a PCI-X to PCI-X bridge takes ownership means we can
> > +	 * tolerate a future hot-add without having to change existing
> > +	 * IOMMU mappings.
> > +	 */
> > +	if (pci_is_pcix(bridge))
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> > +static struct pci_dev *pci_bridge_to_dev(struct pci_bus *bus,
> > +					 struct pci_dev *dev)
> > +{
> > +	struct pci_dev *bridge;
> > +	struct pci_bus *child_bus;
> > +	u8 secondary, subordinate, busn = dev->bus->number;
> > +
> > +	if (dev->bus == bus)
> > +		return dev;
> > +
> > +	/*
> > +	 * There may be several devices on "bus".  Find the one that is a
> > +	 * bridge leading to "dev".
> > +	 */
> > +	list_for_each_entry(bridge, &bus->devices, bus_list) {
> > +		child_bus = bridge->subordinate;
> > +		if (child_bus) {
> > +			secondary = child_bus->busn_res.start;
> > +			subordinate = child_bus->busn_res.end;
> > +			if (secondary <= busn && busn <= subordinate)
> > +				return bridge;
> > +		}
> > +	}
> > +	return NULL;
> > +}
> > +
> > +int pci_for_each_requester_id(struct pci_dev *bridge, struct pci_dev *dev,
> > +			      int (*fn)(struct pci_dev *, void *),
> 
> u16 requester_id
> 
> > +			      void *data)
> > +{
> > +	int ret;
> > +
> > +	dev = pci_get_dma_source(dev);	/* XXX ref count screwup */
> 
> It's unfortunate that our dma quirk still seems to only get called for
> the end device where we could have bridges that need it too.

Sure, we can do that if necessary.

I'm not trying to present this as any kind of finished solution.  The
point is to figure out if we can make an interface that's a little
more abstract so we can pull the PCI topology issues out of the IOMMU
drivers, and I just thought something that looked like code would be
more concrete and easier to discuss.

> > +
> > +	while (bridge != dev) {
> 
> 
> I'm having a hard time understanding this function since bridge is never
> defined in any of the below sample code.  Would bridge be the root port
> above a device?  And what about devices connected to the RC?  Seems like
> we'd need to traverse up the bus first, so there's a bit of missing
> magic.

I was assuming that an IOMMU could be either at the root of a PCI
hierarchy or buried farther down.  If that's true, the IOMMU driver
might need to supply the top of the PCI hierarchy for which it
translates.  That's what I'm trying to get at with the "bridge"
argument.

If the IOMMU is buried, I assumed there was no point in iterating over
bridges upstream of the IOMMU because it wouldn't see requester IDs of
those upstream bridges.  PCI wouldn't have any way to figure out how
far up to go, hence the argument.

> > +		if (pci_bridge_may_take_ownership(bridge)) {
> > +			ret = fn(dev, PCI_BRIDGE_REQUESTER_ID(bridge), data);
> > +			if (ret)
> > +				return ret;
> > +		}
> > +		bridge = pci_bridge_to_dev(bridge->subordinate, dev);
> > +	}
> > +
> > +	if (pci_is_pcie(dev) || pci_is_pcix(dev))
> > +		return fn(dev, PCI_REQUESTER_ID(dev), data);
> > +
> > +	/* Conventional PCI has no requester ID */
> > +	return 0;
> > +}
> > +
> >  /*
> >   * find the upstream PCIe-to-PCI bridge of a PCI device
> >   * if the device is PCIE, return NULL
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 3a24e4f..cbcc82f 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -794,6 +794,8 @@ static inline struct pci_dev *pci_get_bus_and_slot(unsigned int bus,
> >  }
> >  struct pci_dev *pci_get_class(unsigned int class, struct pci_dev *from);
> >  int pci_dev_present(const struct pci_device_id *ids);
> > +void pci_for_each_requester_id(struct pci_dev *bridge, struct pci_dev *dev,
> > +			       int (*fn)(struct pci_dev *, void *), void *data);
> >  
> >  int pci_bus_read_config_byte(struct pci_bus *bus, unsigned int devfn,
> >  			     int where, u8 *val);
> > 
> > commit 6e770d7bf4ef95207df4ac4c42ef4406ff7bc54e
> > Author: Bjorn Helgaas <bhelgaas@google.com>
> > Date:   Wed Jul 3 12:02:15 2013 -0600
> > 
> >     intel-iommu-upstream-pcie
> 
> I assume this one would is also going to apply dma quirks to dma_ops,
> which I'm all for.
> 
> > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > index b91564d..bdb6e6a 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -1669,79 +1669,68 @@ static int domain_context_mapping_one(struct dmar_domain *domain, int segment,
> >  	return 0;
> >  }
> >  
> > +struct domain_context_info {
> > +	struct dmar_domain *domain;
> > +	struct pci_dev *dev;
> > +	int translation;
> > +	struct intel_iommu *iomumu;
> 
> s/iomumu/iommu/
> 
> > +	bool mapped;
> > +};
> > +
> > +static int context_mapping(struct pci_dev *dev, u16 requester_id, void *data)
> > +{
> > +	struct domain_context_info *dev_info = data;
> > +	int segment = pci_domain_nr(data->dev);
> 
> dev_info->dev
> 
> > +	u8 bus = data->requester_id >> 8;
> 
> s/data->//
> 
> > +	u8 devfn = data->requester_id & 0xff;
> 
> s/data->//

I told you it wouldn't even compile :)  I'm only trying to present a
possibility, not all the nitty-gritty details.

> > +
> > +	return domain_context_mapping_one(data->domain, segment,
> > +					  bus, devfn, data->translation);
> > +}
> > +
> >  static int domain_context_mapping(struct dmar_domain *domain,
> >  				  struct pci_dev *pdev, int translation)
> >  {
> > -	int ret;
> > -	struct pci_dev *tmp, *parent;
> > +	struct domain_context_info data;
> > +	struct pci_dev *bridge;
> >  
> > -	ret = domain_context_mapping_one(domain, pci_domain_nr(pdev->bus),
> > -					 pdev->bus->number, pdev->devfn,
> > -					 translation);
> > -	if (ret)
> > -		return ret;
> > +	data.domain = domain;
> > +	data.dev = pdev;
> > +	data.translation = translation;
> > +	bridge = xx;
> 
> Darn, I was hoping you were going to reveal where bridge comes from.
> 
> > +	return pci_for_each_requester_id(bridge, pdev, context_mapping, &data);
> > +}
> >  
> > -	/* dependent device mapping */
> > -	tmp = pci_find_upstream_pcie_bridge(pdev);
> > -	if (!tmp)
> > -		return 0;
> > -	/* Secondary interface's bus number and devfn 0 */
> > -	parent = pdev->bus->self;
> > -	while (parent != tmp) {
> > -		ret = domain_context_mapping_one(domain,
> > -						 pci_domain_nr(parent->bus),
> > -						 parent->bus->number,
> > -						 parent->devfn, translation);
> > -		if (ret)
> > -			return ret;
> > -		parent = parent->bus->self;
> > -	}
> > -	if (pci_is_pcie(tmp)) /* this is a PCIe-to-PCI bridge */
> > -		return domain_context_mapping_one(domain,
> > -					pci_domain_nr(tmp->subordinate),
> > -					tmp->subordinate->number, 0,
> > -					translation);
> > -	else /* this is a legacy PCI bridge */
> > -		return domain_context_mapping_one(domain,
> > -						  pci_domain_nr(tmp->bus),
> > -						  tmp->bus->number,
> > -						  tmp->devfn,
> > -						  translation);
> > +static int is_context_mapped(struct pci_dev *dev, u16 requester_id, void *data)
> > +{
> > +	struct domain_context_info *dev_info = data;
> > +	u8 bus = data->requester_id >> 8;
> > +	u8 devfn = data->requester_id & 0xff;
> > +	bool ret;
> > +
> > +	ret = device_context_mapped(dev_info->iommu, bus, devfn);
> > +	if (!ret)
> > +		dev_info->mapped = false;
> > +
> > +	return 0;
> >  }
> >  
> >  static bool domain_context_mapped(struct pci_dev *pdev)
> >  {
> > -	bool ret;
> > -	struct pci_dev *tmp, *parent;
> > +	struct domain_context_info data;
> >  	struct intel_iommu *iommu;
> > +	struct pci_dev *bridge;
> >  
> >  	iommu = device_to_iommu(pci_domain_nr(pdev->bus), pdev->bus->number,
> >  				pdev->devfn);
> >  	if (!iommu)
> >  		return false;
> >  
> > -	ret = device_context_mapped(iommu, pdev->bus->number, pdev->devfn);
> > -	if (!ret)
> > -		return false;
> > -	/* dependent device mapping */
> > -	tmp = pci_find_upstream_pcie_bridge(pdev);
> > -	if (!tmp)
> > -		return true;
> > -	/* Secondary interface's bus number and devfn 0 */
> > -	parent = pdev->bus->self;
> > -	while (parent != tmp) {
> > -		ret = device_context_mapped(iommu, parent->bus->number,
> > -					    parent->devfn);
> > -		if (!ret)
> > -			return false;
> > -		parent = parent->bus->self;
> > -	}
> > -	if (pci_is_pcie(tmp))
> > -		return device_context_mapped(iommu, tmp->subordinate->number,
> > -					     0);
> > -	else
> > -		return device_context_mapped(iommu, tmp->bus->number,
> > -					     tmp->devfn);
> > +	data.iommu = iommu;
> > +	data.mapped = true;
> > +	bridge = xx;
> > +	pci_for_each_requester_id(bridge, pdev, is_context_mapped, &data);
> > +	return data.mapped;
> >  }
> >  
> >  /* Returns a number of VTD pages, but aligned to MM page size */
> > @@ -1961,6 +1950,27 @@ static struct dmar_domain *find_domain(struct pci_dev *pdev)
> >  	return NULL;
> >  }
> >  
> > +static int find_domain2(struct pci_dev *dev, u16 requester_id, void *data)
> > +{
> > +	struct domain_context_info *dev_info = data;
> > +	int segment = pci_domain_nr(data->dev);
> > +	u8 bus = data->requester_id >> 8;
> > +	u8 devfn = data->requester_id & 0xff;
> > +	unsigned long flags;
> > +	struct device_domain_info *info;
> > +
> > +	spin_lock_irqsave(&device_domain_lock, flags);
> > +	list_for_each_entry(info, &device_domain_list, global) {
> > +		if (info->segment == segment &&
> > +		    info->bus == bus && info->devfn == devfn) {
> > +			data->domain = info->domain;
> > +			break;
> > +		}
> > +	}
> > +	spin_unlock_irqrestore(&device_domain_lock, flags);
> > +	return 0;
> > +}
> > +
> >  /* domain is initialized */
> >  static struct dmar_domain *get_domain_for_dev(struct pci_dev *pdev, int gaw)
> >  {
> > @@ -1968,11 +1978,11 @@ static struct dmar_domain *get_domain_for_dev(struct pci_dev *pdev, int gaw)
> >  	struct intel_iommu *iommu;
> >  	struct dmar_drhd_unit *drhd;
> >  	struct device_domain_info *info, *tmp;
> > -	struct pci_dev *dev_tmp;
> >  	unsigned long flags;
> >  	int bus = 0, devfn = 0;
> >  	int segment;
> >  	int ret;
> > +	struct domain_context_info data;
> >  
> >  	domain = find_domain(pdev);
> >  	if (domain)
> > @@ -1980,29 +1990,13 @@ static struct dmar_domain *get_domain_for_dev(struct pci_dev *pdev, int gaw)
> >  
> >  	segment = pci_domain_nr(pdev->bus);
> >  
> > -	dev_tmp = pci_find_upstream_pcie_bridge(pdev);
> > -	if (dev_tmp) {
> > -		if (pci_is_pcie(dev_tmp)) {
> > -			bus = dev_tmp->subordinate->number;
> > -			devfn = 0;
> > -		} else {
> > -			bus = dev_tmp->bus->number;
> > -			devfn = dev_tmp->devfn;
> > -		}
> > -		spin_lock_irqsave(&device_domain_lock, flags);
> > -		list_for_each_entry(info, &device_domain_list, global) {
> > -			if (info->segment == segment &&
> > -			    info->bus == bus && info->devfn == devfn) {
> > -				found = info->domain;
> > -				break;
> > -			}
> > -		}
> > -		spin_unlock_irqrestore(&device_domain_lock, flags);
> > -		/* pcie-pci bridge already has a domain, uses it */
> > -		if (found) {
> > -			domain = found;
> > -			goto found_domain;
> > -		}
> > +	data.domain = NULL;
> > +	data.dev = pdev;
> > +	bridge = xx;
> > +	pci_for_each_requester_id(bridge, pdev, find_domain2, &data);
> > +	if (data.domain) {
> > +		domain = data.domain;
> > +		goto found_domain;
> >  	}
> >  
> >  	domain = alloc_domain();
> > @@ -3734,31 +3728,29 @@ int __init intel_iommu_init(void)
> >  	return 0;
> >  }
> >  
> > +static int detach_requester(struct pci_dev *dev, u16 requester_id, void *data)
> > +{
> > +	struct domain_context_info *dev_info = data;
> > +	struct intel_iommu *iommu = data->iommu;
> > +	u8 bus = data->requester_id >> 8;
> > +	u8 devfn = data->requester_id & 0xff;
> > +
> > +	iommu_detach_dev(iommu, bus, devfn);
> > +	return 0;
> > +}
> > +
> >  static void iommu_detach_dependent_devices(struct intel_iommu *iommu,
> >  					   struct pci_dev *pdev)
> >  {
> > -	struct pci_dev *tmp, *parent;
> > +	struct domain_context_info data;
> >  
> >  	if (!iommu || !pdev)
> >  		return;
> >  
> >  	/* dependent device detach */
> > -	tmp = pci_find_upstream_pcie_bridge(pdev);
> > -	/* Secondary interface's bus number and devfn 0 */
> > -	if (tmp) {
> > -		parent = pdev->bus->self;
> > -		while (parent != tmp) {
> > -			iommu_detach_dev(iommu, parent->bus->number,
> > -					 parent->devfn);
> > -			parent = parent->bus->self;
> > -		}
> > -		if (pci_is_pcie(tmp)) /* this is a PCIe-to-PCI bridge */
> > -			iommu_detach_dev(iommu,
> > -				tmp->subordinate->number, 0);
> > -		else /* this is a legacy PCI bridge */
> > -			iommu_detach_dev(iommu, tmp->bus->number,
> > -					 tmp->devfn);
> > -	}
> > +	data.iommu = iommu;
> > +	bridge = xx;
> > +	pci_for_each_requester_id(bridge, pdev, detach_requester, &data);
> >  }
> >  
> >  static void domain_remove_one_dev_info(struct dmar_domain *domain,
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
