Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55303 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759993AbcBYOip (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 25 Feb 2016 09:38:45 -0500
Date: Thu, 25 Feb 2016 08:38:41 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>,
	linux-pci@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>,
	Joerg Roedel <jroedel@suse.de>,
	David Woodhouse <dwmw2@infradead.org>,
	iommu@lists.linux-foundation.org
Subject: Re: [PATCH v4 3/6] PCI: Add support for multiple DMA aliases
Message-ID: <20160225143841.GA8726@localhost>
References: <20160224193926.7585.10833.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160224194406.7585.17447.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160224194406.7585.17447.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 24, 2016 at 01:44:06PM -0600, Bjorn Helgaas wrote:
> From: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
> 
> <Insert changelog here>

(Sorry, I should have copied this changelog in the patch; I copied
this manually from your v3 posting):

> This patch solves IOMMU support issues with PCIe non-transparent bridges
> that use Requester ID look-up tables (LUT), e.g. PEX8733. Before exiting
> the bridge, packet's RID is rewritten according to LUT programmed by
> a driver. Modified packets are then passed to a destination bus and
> processed upstream. The problem is that such packets seem to come from
> non-existent nodes that are hidden behind NTB and are not discoverable
> by a destination node, so IOMMU discards them. Adding DMA alias for a
> given LUT entry allows IOMMU to create a proper mapping that enables
> inter-node communication.

A specific example here would help me understand.  Here's how I
understand this (correct me if I'm wrong): We're talking about a DMA
packet being forwarded upstream from an NTB.  The NTB uses the LUT to
rewrite the RID in the DMA packet.  The new RID from the LUT is
unknown to the IOMMU, so it discards the DMA packet.

> The current DMA alias implementation supports only single alias, so it's
> not possible to connect more than two nodes when IOMMU is enabled. This
> implementation enables all possible aliases on a given bus (256) that
> are stored in a bitset. Alias devfn is directly translated to a bit
> number. The bitset is not allocated for devices that have no need for
> DMA aliases.

I think "two nodes" is referring to two PCIe devices on the other side
of the NTB.  You want DMA packets from those devices to have different
RIDs so the IOMMU can distinguish them.

The LUT entries basically create aliases of the NTB (one alias for
each device beyond the NTB).  Your quirk uses pci_add_dma_alias(), and
the aliases are all on the same bus as the NTB itself.

The quirk adds PCI_DEVFN(0x10, 0x0), PCI_DEVFN(0x11, 0x0), and
PCI_DEVFN(0x12, 0x0).  Shouldn't there be some connection between this
and the LUT programming?  I assume the LUT is programmed to correspond
to those aliases.  Does this mean you're limited to three devices
beyond the NTB?

> ---
>  drivers/iommu/iommu.c |   17 ++++++++++-------
>  drivers/pci/pci.c     |   11 +++++++++--
>  drivers/pci/probe.c   |    1 +
>  drivers/pci/search.c  |   14 +++++++++-----
>  include/linux/pci.h   |    4 +---
>  5 files changed, 30 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 0e3b009..a214e19 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -659,9 +659,15 @@ static struct iommu_group *get_pci_function_alias_group(struct pci_dev *pdev,
>  	return NULL;
>  }
>  
> +static bool dma_alias_is_enabled(struct pci_dev *dev, u8 devfn)
> +{
> +	return dev->dma_alias_mask &&
> +	       test_bit(devfn, dev->dma_alias_mask);
> +}
> +
>  /*
> - * Look for aliases to or from the given device for exisiting groups.  The
> - * dma_alias_devfn only supports aliases on the same bus, therefore the search
> + * Look for aliases to or from the given device for existing groups. DMA
> + * aliases are only supported on the same bus, therefore the search

I'm trying to reconcile this statement that "DMA aliases are only
supported on the same bus" (which was there even before this patch)
with the fact that pci_for_each_dma_alias() does not have that
limitation.

>   * space is quite small (especially since we're really only looking at pcie
>   * device, and therefore only expect multiple slots on the root complex or
>   * downstream switch ports).  It's conceivable though that a pair of
> @@ -686,11 +692,8 @@ static struct iommu_group *get_pci_alias_group(struct pci_dev *pdev,
>  			continue;
>  
>  		/* We alias them or they alias us */
> -		if (((pdev->dev_flags & PCI_DEV_FLAGS_DMA_ALIAS_DEVFN) &&
> -		     pdev->dma_alias_devfn == tmp->devfn) ||
> -		    ((tmp->dev_flags & PCI_DEV_FLAGS_DMA_ALIAS_DEVFN) &&
> -		     tmp->dma_alias_devfn == pdev->devfn)) {
> -
> +		if (dma_alias_is_enabled(pdev, tmp->devfn) ||
> +		    dma_alias_is_enabled(tmp, pdev->devfn)) {
>  			group = get_pci_alias_group(tmp, devfns);

We basically have this:

  for_each_pci_dev(tmp) {
    if (<pdev and tmp are DMA aliases>)
      group = get_pci_alias_group();
      ...
  }

The DMA alias stuff relies on PCI internals, so it doesn't doesn't
seem quite right to use things like PCI_DEV_FLAGS_DMA_ALIAS_DEVFN and
dma_alias_devfn here in the IOMMU code.  

I'm trying to figure out why we don't do something like the following
instead:

  callback(struct pci_dev *pdev, u16 alias, void *opaque)
  {
    struct iommu_group *group;

    group = get_pci_alias_group();
    if (group)
      return group;

    return 0;
  }

  pci_for_each_dma_alias(pdev, callback, ...);

Is the existing code some sort of optimization, e.g., checking
PCI_DEV_FLAGS_DMA_ALIAS_DEVFN is cheaper than using
pci_for_each_dma_alias()?

It seems like this won't work for some very unlikely but theoretically
possible topologies, e.g.,

  PCIe Root Complex/IOMMU
    PCIe switch A
      PCIe to conventional PCI bridge
        PCI to PCIe Root Complex
	  PCIe NTB

Here, I think the IOMMU will only see RIDs from PCIe switch A, but the
current code only looks at DMA aliases that are on the same bus as the
PCIe NTB.  Wouldn't using pci_for_each_dma_alias() handle this
correctly?

>  			if (group) {
>  				pci_dev_put(tmp);
