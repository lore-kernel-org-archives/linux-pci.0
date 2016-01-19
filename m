Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44792 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932252AbcASVEc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 19 Jan 2016 16:04:32 -0500
Message-ID: <1453237471.32741.267.camel@redhat.com>
Subject: Re: [PATCH] pci: Add support for multiple DMA aliases
From: Alex Williamson <alex.williamson@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
	Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	dwmw2@infradead.org, jroedel@suse.de
Date: Tue, 19 Jan 2016 14:04:31 -0700
In-Reply-To: <20160119201254.GB6510@localhost>
References: <1453118346-76897-1-git-send-email-jacek.lawrynowicz@intel.com>
	 <1453133267-79756-1-git-send-email-jacek.lawrynowicz@intel.com>
	 <20160119033315.GA6510@localhost> <20160119201254.GB6510@localhost>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2016-01-19 at 14:12 -0600, Bjorn Helgaas wrote:
> [+cc Alex]
> 
> On Mon, Jan 18, 2016 at 09:33:15PM -0600, Bjorn Helgaas wrote:
> > On Mon, Jan 18, 2016 at 05:07:47PM +0100, Jacek Lawrynowicz wrote:
> > > This patch solves IOMMU support issues with PCIe non-transparent bridges
> > > that use Requester ID look-up tables (LUT), e.g. PEX8733. Before exiting
> > > the bridge, packet's RID is rewritten according to LUT programmed by
> > > a driver. Modified packets are then passed to a destination bus and
> > > processed upstream. The problem is that such packets seem to come from
> > > non-existent nodes that are hidden behind NTB and are not discoverable
> > > by a destination node, so IOMMU discards them. Adding DMA alias for a
> > > given LUT entry allows IOMMU to create a proper mapping that enables
> > > inter-node communication.
> > > 
> > > The current DMA alias implementation supports only single alias, so it's
> > > not possible to connect more than two nodes when IOMMU is enabled. This
> > > implementation enables all possible aliases on a given bus (256) that
> > > are stored in a bitset. Alias devfn is directly translated to a bit
> > > number. The bitset is not allocated for devices that have no need for
> > > DMA aliases.

My only concern here is that pci_add_dma_alias() makes aliases seem
more dynamic than they really are.  For instance, when we add a device
to an IOMMU domain, we evaluate the aliases at that point, if an NTB
later adds a new lookup entry and specifies a new alias, it's still not
going to work.  Similarly, IOMMU groups are evaluated as the device is
added, so if an alias is to a physical device and we need the cross
reference to bind them together into a single group, calling
pci_add_dma_alias() from a driver isn't going to work.

The existing code had this problem too, it's just more obvious now that
we have a helper function and that the helper is exported for use
outside of the PCI core.  Thanks,

Alex

> > > 
> > > More details can be found in following article:
> > > http://www.plxtech.com/files/pdf/technical/expresslane/RTC_Enabling%20MulitHostSystemDesigns.pdf
> > > 
> > > Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
> > > Acked-by: David Woodhouse <David.Woodhouse@intel.com>
> > > Acked-by: Joerg Roedel <jroedel@suse.de>
> > 
> > I applied this to pci/iommu and intend to merge it for v4.5.
> > 
> > I made the following change because the kcalloc() failure warning in
> > your patch looks wrong:
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index b0d6a0a..29cfe1a 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -4577,13 +4577,15 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
> >   */
> >  void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
> >  {
> > -	if (!dev->dma_alias_mask) {
> > +	if (!dev->dma_alias_mask)
> >  		dev->dma_alias_mask = kcalloc(BITS_TO_LONGS(U8_MAX),
> >  					      sizeof(long), GFP_KERNEL);
> > -		dev_warn(&dev->dev, "Unable to allocate DMA alias mask.\n");
> > +	if (!dev->dma_alias_mask) {
> > +		dev_warn(&dev->dev, "Unable to allocate DMA alias mask\n");
> > +		return;
> >  	}
> > -	if (dev->dma_alias_mask)
> > -		set_bit(devfn, dev->dma_alias_mask);
> > +
> > +	set_bit(devfn, dev->dma_alias_mask);
> >  }
> >  EXPORT_SYMBOL_GPL(pci_add_dma_alias);
> >  
> > 
> > > ---
> > >  drivers/iommu/iommu.c |  8 ++++----
> > >  drivers/pci/pci.c     | 19 +++++++++++++++++++
> > >  drivers/pci/probe.c   |  1 +
> > >  drivers/pci/quirks.c  | 15 ++++++---------
> > >  drivers/pci/search.c  | 14 +++++++++-----
> > >  include/linux/pci.h   | 15 ++++++++-------
> > >  6 files changed, 47 insertions(+), 25 deletions(-)
> > > 
> > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > index abae363..98ae7ff 100644
> > > --- a/drivers/iommu/iommu.c
> > > +++ b/drivers/iommu/iommu.c
> > > @@ -686,10 +686,10 @@ static struct iommu_group *get_pci_alias_group(struct pci_dev *pdev,
> > >  			continue;
> > >  
> > >  		/* We alias them or they alias us */
> > > -		if (((pdev->dev_flags & PCI_DEV_FLAGS_DMA_ALIAS_DEVFN) &&
> > > -		     pdev->dma_alias_devfn == tmp->devfn) ||
> > > -		    ((tmp->dev_flags & PCI_DEV_FLAGS_DMA_ALIAS_DEVFN) &&
> > > -		     tmp->dma_alias_devfn == pdev->devfn)) {
> > > +		if ((pdev->dma_alias_mask &&
> > > +		     test_bit(tmp->devfn, pdev->dma_alias_mask)) ||
> > > +		    ((tmp->dma_alias_mask &&
> > > +		     test_bit(pdev->devfn, tmp->dma_alias_mask)))) {
> > >  
> > >  			group = get_pci_alias_group(tmp, devfns);
> > >  			if (group) {
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 49e3715..5b27d65 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -4568,6 +4568,25 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
> > >  	return 0;
> > >  }
> > >  
> > > +/**
> > > + * pci_add_dma_alias - Allows to add multiple devfn aliases for given device
> > > + * @dev: the PCI device for which alias is added
> > > + * @devfn: alias slot and function
> > > + *
> > > + * This helper encodes 8-bit devfn as bit number in dma_alias_mask
> > > + */
> > > +void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
> > > +{
> > > +	if (!dev->dma_alias_mask) {
> > > +		dev->dma_alias_mask = kcalloc(BITS_TO_LONGS(U8_MAX),
> > > +					      sizeof(long), GFP_KERNEL);
> > > +		dev_warn(&dev->dev, "Unable to allocate DMA alias mask.\n");
> > > +	}
> > > +	if (dev->dma_alias_mask)
> > > +		set_bit(devfn, dev->dma_alias_mask);
> > > +}
> > > +EXPORT_SYMBOL_GPL(pci_add_dma_alias);
> > > +
> > >  bool pci_device_is_present(struct pci_dev *pdev)
> > >  {
> > >  	u32 v;
> > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > > index 32b9f1b..5da4dd3 100644
> > > --- a/drivers/pci/probe.c
> > > +++ b/drivers/pci/probe.c
> > > @@ -1501,6 +1501,7 @@ static void pci_release_dev(struct device *dev)
> > >  	pcibios_release_device(pci_dev);
> > >  	pci_bus_put(pci_dev->bus);
> > >  	kfree(pci_dev->driver_override);
> > > +	kfree(pci_dev->dma_alias_mask);
> > >  	kfree(pci_dev);
> > >  }
> > >  
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > index 83e93d7..3ed1f9a 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -3579,8 +3579,7 @@ int pci_dev_specific_reset(struct pci_dev *dev, int probe)
> > >  static void quirk_dma_func0_alias(struct pci_dev *dev)
> > >  {
> > >  	if (PCI_FUNC(dev->devfn) != 0) {
> > > -		dev->dma_alias_devfn = PCI_DEVFN(PCI_SLOT(dev->devfn), 0);
> > > -		dev->dev_flags |= PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
> > > +		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
> > >  	}
> > >  }
> > >  
> > > @@ -3595,8 +3594,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_RICOH, 0xe476, quirk_dma_func0_alias);
> > >  static void quirk_dma_func1_alias(struct pci_dev *dev)
> > >  {
> > >  	if (PCI_FUNC(dev->devfn) != 1) {
> > > -		dev->dma_alias_devfn = PCI_DEVFN(PCI_SLOT(dev->devfn), 1);
> > > -		dev->dev_flags |= PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
> > > +		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), 1));
> > >  	}
> > >  }
> > >  
> > > @@ -3660,11 +3658,10 @@ static void quirk_fixed_dma_alias(struct pci_dev *dev)
> > >  
> > >  	id = pci_match_id(fixed_dma_alias_tbl, dev);
> > >  	if (id) {
> > > -		dev->dma_alias_devfn = id->driver_data;
> > > -		dev->dev_flags |= PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
> > > -		dev_info(&dev->dev, "Enabling fixed DMA alias to %02x.%d\n",
> > > -			 PCI_SLOT(dev->dma_alias_devfn),
> > > -			 PCI_FUNC(dev->dma_alias_devfn));
> > > +		pci_add_dma_alias(dev, id->driver_data);
> > > +		dev_info(&dev->dev, "Enabling fixed DMA alias to %02lx.%ld\n",
> > > +			 PCI_SLOT(id->driver_data),
> > > +			 PCI_FUNC(id->driver_data));
> > >  	}
> > >  }
> > >  
> > > diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> > > index a20ce7d..33e0f03 100644
> > > --- a/drivers/pci/search.c
> > > +++ b/drivers/pci/search.c
> > > @@ -40,11 +40,15 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
> > >  	 * If the device is broken and uses an alias requester ID for
> > >  	 * DMA, iterate over that too.
> > >  	 */
> > > -	if (unlikely(pdev->dev_flags & PCI_DEV_FLAGS_DMA_ALIAS_DEVFN)) {
> > > -		ret = fn(pdev, PCI_DEVID(pdev->bus->number,
> > > -					 pdev->dma_alias_devfn), data);
> > > -		if (ret)
> > > -			return ret;
> > > +	if (unlikely(pdev->dma_alias_mask)) {
> > > +		u8 devfn;
> > > +
> > > +		for_each_set_bit(devfn, pdev->dma_alias_mask, U8_MAX) {
> > > +			ret = fn(pdev, PCI_DEVID(pdev->bus->number, devfn),
> > > +				 data);
> > > +			if (ret)
> > > +				return ret;
> > > +		}
> > >  	}
> > >  
> > >  	for (bus = pdev->bus; !pci_is_root_bus(bus); bus = bus->parent) {
> > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > index f9f79ad..6200175 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -172,16 +172,14 @@ enum pci_dev_flags {
> > >  	PCI_DEV_FLAGS_ASSIGNED = (__force pci_dev_flags_t) (1 << 2),
> > >  	/* Flag for quirk use to store if quirk-specific ACS is enabled */
> > >  	PCI_DEV_FLAGS_ACS_ENABLED_QUIRK = (__force pci_dev_flags_t) (1 << 3),
> > > -	/* Flag to indicate the device uses dma_alias_devfn */
> > > -	PCI_DEV_FLAGS_DMA_ALIAS_DEVFN = (__force pci_dev_flags_t) (1 << 4),
> > >  	/* Use a PCIe-to-PCI bridge alias even if !pci_is_pcie */
> > > -	PCI_DEV_FLAG_PCIE_BRIDGE_ALIAS = (__force pci_dev_flags_t) (1 << 5),
> > > +	PCI_DEV_FLAG_PCIE_BRIDGE_ALIAS = (__force pci_dev_flags_t) (1 << 4),
> > >  	/* Do not use bus resets for device */
> > > -	PCI_DEV_FLAGS_NO_BUS_RESET = (__force pci_dev_flags_t) (1 << 6),
> > > +	PCI_DEV_FLAGS_NO_BUS_RESET = (__force pci_dev_flags_t) (1 << 5),
> > >  	/* Do not use PM reset even if device advertises NoSoftRst- */
> > > -	PCI_DEV_FLAGS_NO_PM_RESET = (__force pci_dev_flags_t) (1 << 7),
> > > +	PCI_DEV_FLAGS_NO_PM_RESET = (__force pci_dev_flags_t) (1 << 6),
> > >  	/* Get VPD from function 0 VPD */
> > > -	PCI_DEV_FLAGS_VPD_REF_F0 = (__force pci_dev_flags_t) (1 << 8),
> > > +	PCI_DEV_FLAGS_VPD_REF_F0 = (__force pci_dev_flags_t) (1 << 7),
> > >  };
> > >  
> > >  enum pci_irq_reroute_variant {
> > > @@ -279,7 +277,7 @@ struct pci_dev {
> > >  	u8		rom_base_reg;	/* which config register controls the ROM */
> > >  	u8		pin;		/* which interrupt pin this device uses */
> > >  	u16		pcie_flags_reg;	/* cached PCIe Capabilities Register */
> > > -	u8		dma_alias_devfn;/* devfn of DMA alias, if any */
> > > +	unsigned long	*dma_alias_mask;/* mask of enabled devfn aliases */
> > >  
> > >  	struct pci_driver *driver;	/* which driver has allocated this device */
> > >  	u64		dma_mask;	/* Mask of the bits of bus address this
> > > @@ -1229,6 +1227,9 @@ resource_size_t pcibios_iov_resource_alignment(struct pci_dev *dev, int resno);
> > >  
> > >  int pci_set_vga_state(struct pci_dev *pdev, bool decode,
> > >  		      unsigned int command_bits, u32 flags);
> > > +
> > > +void pci_add_dma_alias(struct pci_dev *dev, u8 devfn);
> > > +
> > >  /* kmem_cache style wrapper around pci_alloc_consistent() */
> > >  
> > >  #include 

