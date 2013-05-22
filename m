Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42681 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756153Ab3EVPCk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 22 May 2013 11:02:40 -0400
Message-ID: <1369234922.2646.86.camel@ul30vt.home>
Subject: Re: [PATCH 1/3] pci: Add PCI walk function and PCIe bridge test
From: Alex Williamson <alex.williamson@redhat.com>
To: Sethi Varun-B16395 <B16395@freescale.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	"joro@8bytes.org" <joro@8bytes.org>
Date: Wed, 22 May 2013 09:02:02 -0600
In-Reply-To: <C5ECD7A89D1DC44195F34B25E172658D544C52@039-SN2MPN1-013.039d.mgd.msft.net>
References: <20130510210937.32592.21950.stgit@bling.home>
	 <20130510211845.32592.77464.stgit@bling.home>
	 <C5ECD7A89D1DC44195F34B25E172658D50609A@039-SN2MPN1-011.039d.mgd.msft.net>
	 <1368456548.5520.1.camel@ul30vt.home>
	 <C5ECD7A89D1DC44195F34B25E172658D544C52@039-SN2MPN1-013.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2013-05-22 at 14:34 +0000, Sethi Varun-B16395 wrote:
> Any idea when would this patch set be integrated? Freescale PAMU
> driver depends on this patch. Currently I am using the
> pci_find_pcie_upstream_bridge routine in the device group creation
> routine.

I don't know, Bjorn?  The bugzilla referenced in patch 0/3 has several
reports from users that this series solves the problem for them.
Thanks,

Alex

> > -----Original Message-----
> > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > Sent: Monday, May 13, 2013 8:19 PM
> > To: Sethi Varun-B16395
> > Cc: bhelgaas@google.com; stephen@networkplumber.org; linux-
> > pci@vger.kernel.org; iommu@lists.linux-foundation.org;
> > dwmw2@infradead.org
> > Subject: Re: [PATCH 1/3] pci: Add PCI walk function and PCIe bridge test
> > 
> > On Mon, 2013-05-13 at 13:51 +0000, Sethi Varun-B16395 wrote:
> > > Would these functions be used outside drivers/iommu? We recently added
> > pci.h under drivers/iommu, maybe we can add a new file for these
> > functions as well.
> > 
> > The intention is to make them generic enough for pci-core, unlike
> > pci_find_upstream_pcie_bridge, which was rather specific to iommu usage.
> > Thanks,
> > 
> > Alex
> > 
> > > > -----Original Message-----
> > > > From: iommu-bounces@lists.linux-foundation.org [mailto:iommu-
> > > > bounces@lists.linux-foundation.org] On Behalf Of Alex Williamson
> > > > Sent: Saturday, May 11, 2013 2:49 AM
> > > > To: bhelgaas@google.com; stephen@networkplumber.org
> > > > Cc: linux-pci@vger.kernel.org; iommu@lists.linux-foundation.org;
> > > > dwmw2@infradead.org
> > > > Subject: [PATCH 1/3] pci: Add PCI walk function and PCIe bridge test
> > > >
> > > > These will replace pci_find_upstream_pcie_bridge, which is difficult
> > > > to use and rather specific to intel-iommu usage.  A quirked
> > > > pci_is_pcie_bridge function is provided to work around non-compliant
> > > > PCIe-to-PCI bridges such as those found in
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=44881
> > > >
> > > > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > > > ---
> > > >  drivers/pci/search.c |   57
> > > > ++++++++++++++++++++++++++++++++++++++++++++++++++
> > > >  include/linux/pci.h  |   23 ++++++++++++++++++++
> > > >  2 files changed, 80 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/search.c b/drivers/pci/search.c index
> > > > d0627fa..0357f74 100644
> > > > --- a/drivers/pci/search.c
> > > > +++ b/drivers/pci/search.c
> > > > @@ -17,6 +17,63 @@
> > > >  DECLARE_RWSEM(pci_bus_sem);
> > > >  EXPORT_SYMBOL_GPL(pci_bus_sem);
> > > >
> > > > +/* Test for PCIe bridges. */
> > > > +bool pci_is_pcie_bridge(struct pci_dev *pdev) {
> > > > +	if (!pci_is_bridge(pdev))
> > > > +		return false;
> > > > +
> > > > +	if (pci_is_pcie(pdev))
> > > > +		return true;
> > > > +
> > > > +#ifdef CONFIG_PCI_QUIRKS
> > > > +	/*
> > > > +	 * If we're not on the root bus, look one device upstream of the
> > > > +	 * current device.  If that device is PCIe and is not a PCIe-to-PCI
> > > > +	 * bridge, then the current device is effectively PCIe as it must
> > > > +	 * be the PCIe-to-PCI bridge.  This handles several bridges that
> > > > +	 * violate the PCIe spec by not exposing a PCIe capability:
> > > > +	 * https://bugzilla.kernel.org/show_bug.cgi?id=44881
> > > > +	 */
> > > > +	if (!pci_is_root_bus(pdev->bus)) {
> > > > +		struct pci_dev *parent = pdev->bus->self;
> > > > +
> > > > +		if (pci_is_pcie(parent) &&
> > > > +		    pci_pcie_type(parent) != PCI_EXP_TYPE_PCI_BRIDGE)
> > > > +
> > > > +			return true;
> > > > +	}
> > > > +#endif
> > > > +	return false;
> > > > +}
> > > > +
> > > > +/*
> > > > + * Walk upstream from the given pdev for the first device returning
> > > > + * true for the provided match function.  If no match is found,
> > > > +return
> > > > + * NULL.  *last records the previous step in the walk.
> > > > + */
> > > > +struct pci_dev *pci_walk_up_to_first_match(struct pci_dev *pdev,
> > > > +					   bool (*match)(struct pci_dev *),
> > > > +					   struct pci_dev **last)
> > > > +{
> > > > +	*last = NULL;
> > > > +
> > > > +	if (match(pdev))
> > > > +		return pdev;
> > > > +
> > > > +	*last = pdev;
> > > > +
> > > > +	while (!pci_is_root_bus(pdev->bus)) {
> > > > +		*last = pdev;
> > > > +		pdev = pdev->bus->self;
> > > > +
> > > > +		if (match(pdev))
> > > > +			return pdev;
> > > > +	}
> > > > +
> > > > +	return NULL;
> > > > +}
> > > > +
> > > >  /*
> > > >   * find the upstream PCIe-to-PCI bridge of a PCI device
> > > >   * if the device is PCIE, return NULL diff --git
> > > > a/include/linux/pci.h b/include/linux/pci.h index bd8ec30..e87423a
> > > > 100644
> > > > --- a/include/linux/pci.h
> > > > +++ b/include/linux/pci.h
> > > > @@ -1855,6 +1855,29 @@ static inline struct eeh_dev
> > > > *pci_dev_to_eeh_dev(struct pci_dev *pdev)  #endif
> > > >
> > > >  /**
> > > > + * pci_walk_up_to_first_match - Generic upstream search function
> > > > + * @pdev: starting PCI device to search
> > > > + * @match: match function to call on each device (true = match)
> > > > + * @last: last device examined prior to returned device
> > > > + *
> > > > + * Walk upstream from the given device, calling match() at each
> > device.
> > > > + * Returns the first device matching match().  If the root bus is
> > > > +reached
> > > > + * without finding a match, return NULL.  last returns the N-1 step
> > > > +in
> > > > + * the search path.
> > > > + */
> > > > +struct pci_dev *pci_walk_up_to_first_match(struct pci_dev *pdev,
> > > > +					   bool (*match)(struct pci_dev *),
> > > > +					   struct pci_dev **last);
> > > > +
> > > > +/**
> > > > + * pci_is_pcie_bridge - Match a PCIe bridge device
> > > > + * @pdev: device to test
> > > > + *
> > > > + * Return true if the given device is a PCIe bridge, false
> > otherwise.
> > > > + */
> > > > +bool pci_is_pcie_bridge(struct pci_dev *pdev);
> > > > +
> > > > +/**
> > > >   * pci_find_upstream_pcie_bridge - find upstream PCIe-to-PCI bridge
> > > > of a device
> > > >   * @pdev: the PCI device
> > > >   *
> > > >
> > > > _______________________________________________
> > > > iommu mailing list
> > > > iommu@lists.linux-foundation.org
> > > > https://lists.linuxfoundation.org/mailman/listinfo/iommu
> > >
> > >
> > 
> > 
> > 
> 



