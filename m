Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:35318 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbbIOTko (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2015 15:40:44 -0400
Date: Tue, 15 Sep 2015 15:40:28 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Will Davis <wdavis@nvidia.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Joerg Roedel <joro@8bytes.org>,
	iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
	Mark Hounschell <markh@compro.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Terence Ripperda <tripperda@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Jerome Glisse <jglisse@redhat.com>
Subject: Re: [PATCH 11/22] swiotlb: Add map_peer_resource stub
Message-ID: <20150915194028.GA23813@l.oracle.com>
References: <1442337067-22964-1-git-send-email-wdavis@nvidia.com>
 <1442337067-22964-12-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1442337067-22964-12-git-send-email-wdavis@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 15, 2015 at 12:10:56PM -0500, Will Davis wrote:
> Add swiotlb stub of the 'map_peer_resource' DMA operation.
> 
> Signed-off-by: Will Davis <wdavis@nvidia.com>
> ---
>  include/linux/swiotlb.h |  8 ++++++++
>  lib/swiotlb.c           | 17 +++++++++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index e7a018e..872463a 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -87,6 +87,14 @@ swiotlb_unmap_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
>  		       int nelems, enum dma_data_direction dir,
>  		       struct dma_attrs *attrs);
>  
> +#ifdef CONFIG_HAS_DMA_P2P
> +extern dma_peer_addr_t
> +swiotlb_map_peer_resource(struct device *hwdev, struct device *hwpeer,
> +			  struct resource *res, unsigned long offset,
> +			  size_t size, enum dma_data_direction dir,
> +			  struct dma_attrs *attrs);
> +#endif
> +
>  extern void
>  swiotlb_sync_single_for_cpu(struct device *hwdev, dma_addr_t dev_addr,
>  			    size_t size, enum dma_data_direction dir);
> diff --git a/lib/swiotlb.c b/lib/swiotlb.c
> index 76f29ec..61522a7 100644
> --- a/lib/swiotlb.c
> +++ b/lib/swiotlb.c
> @@ -945,6 +945,23 @@ swiotlb_unmap_sg(struct device *hwdev, struct scatterlist *sgl, int nelems,
>  }
>  EXPORT_SYMBOL(swiotlb_unmap_sg);
>  
> +#ifdef CONFIG_HAS_DMA_P2P
> +/*
> + * Maps a single region from a peer device's resource for DMA streaming. This
> + * is currently unimplemented because there's no bounce buffer abstraction for
> + * peer mappings.
> + */
> +dma_peer_addr_t
> +swiotlb_map_peer_resource(struct device *hwdev, struct device *hwpeer,
> +			  struct resource *res, unsigned long offset,
> +			  size_t size, enum dma_data_direction dir,
> +			  struct dma_attrs *attrs)
> +{
> +	return phys_to_dma(hwdev, io_tlb_overflow_buffer);

That seems to be implemented :-)

Did you mean to return DMA_ERROR_CODE instead?
> +}
> +EXPORT_SYMBOL(swiotlb_map_peer_resource);
> +#endif
> +
>  /*
>   * Make physical memory consistent for a set of streaming mode DMA translations
>   * after a transfer.
> -- 
> 2.5.1
> 
