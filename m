Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:34527 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbbHJRCW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Aug 2015 13:02:22 -0400
Received: by igui7 with SMTP id i7so22980900igu.1
        for <linux-pci@vger.kernel.org>; Mon, 10 Aug 2015 10:02:21 -0700 (PDT)
Date: Mon, 10 Aug 2015 12:02:17 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Will Davis <wdavis@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Joerg Roedel <joro@8bytes.org>,
	iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
	Konrad Wilk <konrad.wilk@oracle.com>,
	Mark Hounschell <markh@compro.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Terence Ripperda <tripperda@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Jerome Glisse <jglisse@redhat.com>
Subject: Re: [PATCH v4 09/12] iommu/vt-d: implement (un)map_peer_resource
Message-ID: <20150810170217.GB32452@google.com>
References: <1437601197-6481-1-git-send-email-wdavis@nvidia.com>
 <1437601197-6481-10-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437601197-6481-10-git-send-email-wdavis@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 22, 2015 at 04:39:54PM -0500, Will Davis wrote:
> Implement 'map_peer_resource' for the Intel IOMMU driver. Simply translate
> the resource to a physical address and route it to the same handlers used
> by the 'map_page' API.
> 
> This allows a device to map another's resource, to enable peer-to-peer
> transactions.
> 
> These functions are guarded behind CONFIG_HAS_DMA_P2P, since the
> dma_map_ops members are as well.
> 
> Signed-off-by: Will Davis <wdavis@nvidia.com>
> Reviewed-by: Terence Ripperda <tripperda@nvidia.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  drivers/iommu/intel-iommu.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index a98a7b2..66b371c 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -3544,6 +3544,40 @@ static void intel_unmap_page(struct device *dev, dma_addr_t dev_addr,
>  	intel_unmap(dev, dev_addr);
>  }
>  
> +#ifdef CONFIG_HAS_DMA_P2P
> +static dma_peer_addr_t intel_map_peer_resource(struct device *dev,
> +					       struct device *peer,
> +					       struct resource *res,
> +					       unsigned long offset,
> +					       size_t size,
> +					       enum dma_data_direction dir,
> +					       struct dma_attrs *attrs)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct pci_dev *ppeer = to_pci_dev(peer);

You got "struct device" pointers, so they might not be PCI devices.  You
should probably return an error if one is not PCI.

> +	struct pci_host_bridge *hbdev = pci_find_host_bridge(pdev->bus);
> +	struct pci_host_bridge *hbpeer = pci_find_host_bridge(ppeer->bus);
> +
> +	/*
> +	 * Disallow the peer-to-peer mapping if the devices do not share a host
> +	 * bridge.
> +	 */
> +	if (hbdev != hbpeer)
> +		return 0;

I think the only thing guaranteed by the spec is peer-to-peer between
devices in the same hierarchy, where the hierarchy is rooted at a PCIe Root
Port or a conventional PCI host bridge.  I don't remember anything about
transactions between Root Ports or conventional PCI host bridges.

If there is some language in the spec about those transactions, a citation
here would be nice.

This decision might be better made by a PCI interface.  This same basic
logic is repeated here, in the AMD equivalent, and in the x86 code, and I
suspect it will end up being a little more complicated for the reasons
above.

> +
> +	return __intel_map_single(dev, res->start + offset, size,
> +				  dir, *dev->dma_mask);
> +}
> +
> +static void intel_unmap_peer_resource(struct device *dev,
> +				      dma_peer_addr_t dev_addr,
> +				      size_t size, enum dma_data_direction dir,
> +				      struct dma_attrs *attrs)
> +{
> +	intel_unmap(dev, dev_addr);
> +}
> +#endif
> +
>  static void *intel_alloc_coherent(struct device *dev, size_t size,
>  				  dma_addr_t *dma_handle, gfp_t flags,
>  				  struct dma_attrs *attrs)
> @@ -3700,6 +3734,10 @@ struct dma_map_ops intel_dma_ops = {
>  	.unmap_sg = intel_unmap_sg,
>  	.map_page = intel_map_page,
>  	.unmap_page = intel_unmap_page,
> +#ifdef CONFIG_HAS_DMA_P2P
> +	.map_peer_resource = intel_map_peer_resource,
> +	.unmap_peer_resource = intel_unmap_peer_resource,
> +#endif
>  	.mapping_error = intel_mapping_error,
>  };
>  
> -- 
> 2.4.6
> 
