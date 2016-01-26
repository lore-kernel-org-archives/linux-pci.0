Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58202 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751102AbcAZXbG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 Jan 2016 18:31:06 -0500
Date: Tue, 26 Jan 2016 17:31:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	alex.williamson@redhat.com, dwmw2@infradead.org, jroedel@suse.de
Subject: Re: [PATCH v2 1/2] pci: Add support for multiple DMA aliases
Message-ID: <20160126233100.GC26726@localhost>
References: <1453825639.26652.45.camel@redhat.com>
 <1453828335-111522-1-git-send-email-jacek.lawrynowicz@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453828335-111522-1-git-send-email-jacek.lawrynowicz@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jacek,

When you post updated versions, please post the whole series with a
new version number.  I think there are three postings of [v2 1/2], and
I think they're different.  In any case, it's hard for me to keep them
straight.

On Tue, Jan 26, 2016 at 06:12:15PM +0100, Jacek Lawrynowicz wrote:
> This patch solves IOMMU support issues with PCIe non-transparent bridges
> that use Requester ID look-up tables (LUT), e.g. PEX8733. Before exiting
> the bridge, packet's RID is rewritten according to LUT programmed by
> a driver. Modified packets are then passed to a destination bus and
> processed upstream. The problem is that such packets seem to come from
> non-existent nodes that are hidden behind NTB and are not discoverable
> by a destination node, so IOMMU discards them. Adding DMA alias for a
> given LUT entry allows IOMMU to create a proper mapping that enables
> inter-node communication.
> 
> The current DMA alias implementation supports only single alias, so it's
> not possible to connect more than two nodes when IOMMU is enabled. This
> implementation enables all possible aliases on a given bus (256) that
> are stored in a bitset. Alias devfn is directly translated to a bit
> number. The bitset is not allocated for devices that have no need for
> DMA aliases.
> 
> More details can be found in following article:
> http://www.plxtech.com/files/pdf/technical/expresslane/RTC_Enabling%20MulitHostSystemDesigns.pdf
> 
> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
> Acked-By: David Woodhouse <David.Woodhouse@intel.com>
> ---
>  drivers/iommu/iommu.c | 11 ++++-------
>  drivers/pci/pci.c     | 27 +++++++++++++++++++++++++++
>  drivers/pci/pci.h     |  2 ++
>  drivers/pci/probe.c   |  1 +
>  drivers/pci/quirks.c  | 15 ++++++---------
>  drivers/pci/search.c  | 14 +++++++++-----
>  include/linux/pci.h   | 14 +++++++-------
>  7 files changed, 56 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 0e3b009..93a89ed 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -660,8 +660,8 @@ static struct iommu_group *get_pci_function_alias_group(struct pci_dev *pdev,
>  }
>  
>  /*
> - * Look for aliases to or from the given device for exisiting groups.  The
> - * dma_alias_devfn only supports aliases on the same bus, therefore the search
> + * Look for aliases to or from the given device for exisiting groups. DMA

s/exisiting/existing/  (Not your change, but might as well fix the
typo since you're touching the line anyway.)

> + * aliases are only supported on the same bus, therefore the search
>   * space is quite small (especially since we're really only looking at pcie
>   * device, and therefore only expect multiple slots on the root complex or
>   * downstream switch ports).  It's conceivable though that a pair of
> @@ -686,11 +686,8 @@ static struct iommu_group *get_pci_alias_group(struct pci_dev *pdev,
>  			continue;
>  
>  		/* We alias them or they alias us */
> -		if (((pdev->dev_flags & PCI_DEV_FLAGS_DMA_ALIAS_DEVFN) &&
> -		     pdev->dma_alias_devfn == tmp->devfn) ||
> -		    ((tmp->dev_flags & PCI_DEV_FLAGS_DMA_ALIAS_DEVFN) &&
> -		     tmp->dma_alias_devfn == pdev->devfn)) {
> -
> +		if (pci_dma_alias_is_enabled(pdev, tmp->devfn) ||
> +		    pci_dma_alias_is_enabled(tmp, pdev->devfn)) {

I was hoping for something that took two pci_dev pointers and returned
true if they were aliases of each other, e.g.,

  bool pci_dma_aliases(struct pci_dev *dev1, struct pci_dev *dev2);

>  			group = get_pci_alias_group(tmp, devfns);
>  			if (group) {
>  				pci_dev_put(tmp);
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 602eb42..cd38767 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4568,6 +4568,33 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
>  	return 0;
>  }
>  
> +/**
> + * pci_enable_dma_alias - Allows to set multiple devfn aliases for given device
> + * @dev: the PCI device for which alias is added
> + * @devfn: alias slot and function
> + *
> + * This helper encodes 8-bit devfn as bit number in dma_alias_mask.
> + * It should be called early, preferably as PCI fixup header quirk.
> + */
> +void pci_enable_dma_alias(struct pci_dev *dev, u8 devfn)

I kind of liked "pci_add_dma_alias()."  "Enable" suggests that we can
turn them on and off, which isn't really the case here.

> +{
> +	if (!dev->dma_alias_mask)
> +		dev->dma_alias_mask = kcalloc(BITS_TO_LONGS(U8_MAX),
> +					      sizeof(long), GFP_KERNEL);
> +	if (!dev->dma_alias_mask) {
> +		dev_warn(&dev->dev, "Unable to allocate DMA alias mask.\n");
> +		return;
> +	}
> +	if (dev->dma_alias_mask)
> +		set_bit(devfn, dev->dma_alias_mask);
> +}

Bjorn
