Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751339AbdGaXFi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Jul 2017 19:05:38 -0400
Date: Mon, 31 Jul 2017 18:05:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: bhelgaas@google.com, marc.zyngier@arm.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] PCI/MSI: Improve MSI alias detection
Message-ID: <20170731230535.GC19800@bhelgaas-glaptop.roam.corp.google.com>
References: <20170531175230.16529-2-robin.murphy@arm.com>
 <20170619215214.GB554@bhelgaas-glaptop.roam.corp.google.com>
 <a9f7292e-1bce-fd38-b146-b530dfce38d1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a9f7292e-1bce-fd38-b146-b530dfce38d1@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Robin,

Can you post a new patch with the updates below, e.g., the fact that
MSI writes don't use phantom RIDs, the set_msi_sid() reference, a
comment about why it's safe for get_msi_id_cb() to ignore all but the
last alias, etc?

These are subtle things that other readers will likely wonder about
(and other platforms may trip over) so I'd like to leave a few
breadcrumbs in the changelog and code comments to help them out.

On Tue, Jun 20, 2017 at 12:03:25PM +0100, Robin Murphy wrote:
> On 19/06/17 22:52, Bjorn Helgaas wrote:
> > [+cc David, Alex]
> > 
> > On Wed, May 31, 2017 at 06:52:28PM +0100, Robin Murphy wrote:
> >> Currently, we consider all DMA aliases when calculating MSI requester
> >> IDs. This turns out to be the wrong thing to do in the face of pure DMA
> >> quirks like those of Marvell SATA cards, where we can end up configuring
> >> the MSI doorbell to expect the phantom function alias, such that it then
> >> goes on to happily ignore actual MSI writes coming from the card on the
> >> real RID.
> > 
> > I guess you're making the assumption that DMA might use phantom
> > function aliases (aliases on the same bus as the actual device), but
> > MSI writes will not?
> 
> Indeed - that's certainly the case for the Marvell 88SE9128 that I have
> here (and it was a report involving a similar Marvell SATA card that
> first brought this to our attention). I appreciate that there's not
> necessarily a general right answer, but the generic MSI infrastructure
> is rather built around the notion of a device having a single ID, so
> this is really a case of picking the most likely compromise to cover the
> greatest number of cases.
> 
> >> Improve the alias walk to only account for the topological aliases that
> >> matter, based on the logic from the Intel IRQ remapping code.
> > 
> > Can you include a specific function reference here?  It sounds like
> > it'd be useful to compare this with the Intel IRQ remapping code.
> 
> set_msi_sid() in drivers/iommu/intel_irq_remapping.c - one small
> difference from VT-d is that here we don't have an equivalent of the
> "verify bus" option, only of considering the full ID.
> 
> >> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> >> ---
> >>  drivers/pci/msi.c | 18 +++++++++++++-----
> >>  1 file changed, 13 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> >> index ba44fdfda66b..7b34c434970e 100644
> >> --- a/drivers/pci/msi.c
> >> +++ b/drivers/pci/msi.c
> >> @@ -1468,13 +1468,21 @@ struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
> >>  }
> >>  EXPORT_SYMBOL_GPL(pci_msi_create_irq_domain);
> >>  
> >> +/*
> >> + * If the alias device/RID is on a different bus, it's a topological alias
> >> + * we should care about; otherwise, it's a DMA quirk and we don't.
> >> + */
> >>  static int get_msi_id_cb(struct pci_dev *pdev, u16 alias, void *data)
> >>  {
> >>  	u32 *pa = data;
> >> +	u8 bus = PCI_BUS_NUM(*pa);
> >> +
> >> +	if (pdev->bus->number != bus || PCI_BUS_NUM(alias) != bus)
> >> +		*pa = alias;
> >>  
> >> -	*pa = alias;
> > 
> > Aliases can arise both because of device defects, e.g., the phantom
> > function quirks, and because of bridges, e.g., all the stuff in
> > pci_for_each_dma_alias().
> > 
> > Why is it that the users of get_msi_id_cb() can get away with
> > collapsing any of these bridge aliases into the last one that
> > pci_for_each_dma_alias() finds?  I guess this is another question
> > about exactly why DMA and MSI are different here.
> 
> As before, it's mostly just a case of trying to pick the least-worst
> option to fit the constraints of the generic MSI layer (assuming a
> bridge in the PCI->PCIe direction that is always going to introduce an
> alias) - based on the assumption that the VT-d code has presumably
> worked well enough in practice doing a similar thing - even if that
> doesn't quite seem to match my reading of the bridge spec (AFAICS it may
> be true for reads, but writes are somewhat murkier).
> 
> From the DMA angle[1], we do have the ability to simply consider every
> alias for translation at the IOMMU, since the IOMMU layer already has
> provisions for devices having multiple IDs. Indeed in the Marvell case
> it is certainly necessary to consider both the real and phantom
> functions so that both DMA and MSIs even get through in the first place.
> 
> Robin.
> 
> [1]:https://www.mail-archive.com/iommu@lists.linux-foundation.org/msg17979.html
> 
> >>  	return 0;
> >>  }
> >> +
> >>  /**
> >>   * pci_msi_domain_get_msi_rid - Get the MSI requester id (RID)
> >>   * @domain:	The interrupt domain
> >> @@ -1488,7 +1496,7 @@ static int get_msi_id_cb(struct pci_dev *pdev, u16 alias, void *data)
> >>  u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
> >>  {
> >>  	struct device_node *of_node;
> >> -	u32 rid = 0;
> >> +	u32 rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
> >>  
> >>  	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
> >>  
> >> @@ -1504,14 +1512,14 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
> >>   * @pdev:	The PCI device
> >>   *
> >>   * Use the firmware data to find a device-specific MSI domain
> >> - * (i.e. not one that is ste as a default).
> >> + * (i.e. not one that is set as a default).
> >>   *
> >> - * Returns: The coresponding MSI domain or NULL if none has been found.
> >> + * Returns: The corresponding MSI domain or NULL if none has been found.
> >>   */
> >>  struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
> >>  {
> >>  	struct irq_domain *dom;
> >> -	u32 rid = 0;
> >> +	u32 rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
> >>  
> >>  	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
> >>  	dom = of_msi_map_get_device_domain(&pdev->dev, rid);
> >> -- 
> >> 2.12.2.dirty
> >>
> 
