Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:36485 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbbEGPII (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2015 11:08:08 -0400
Received: by igbpi8 with SMTP id pi8so25360361igb.1
        for <linux-pci@vger.kernel.org>; Thu, 07 May 2015 08:08:07 -0700 (PDT)
Date: Thu, 7 May 2015 10:08:04 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: wdavis@nvidia.com
Cc: joro@8bytes.org, iommu@lists.linux-foundation.org,
	linux-pci@vger.kernel.org, tripperda@nvidia.com,
	jhubbard@nvidia.com, jglisse@redhat.com
Subject: Re: [PATCH 6/6] x86: add pci-nommu implementation of map_resource
Message-ID: <20150507150804.GJ24643@google.com>
References: <1430505138-2877-1-git-send-email-wdavis@nvidia.com>
 <1430505138-2877-7-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1430505138-2877-7-git-send-email-wdavis@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 01, 2015 at 01:32:18PM -0500, wdavis@nvidia.com wrote:
> From: Will Davis <wdavis@nvidia.com>
> 
> Simply pass through the physical address as the DMA address.
> 
> Signed-off-by: Will Davis <wdavis@nvidia.com>
> Reviewed-by: Terence Ripperda <tripperda@nvidia.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  arch/x86/kernel/pci-nommu.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/x86/kernel/pci-nommu.c b/arch/x86/kernel/pci-nommu.c
> index da15918..6e9e66d 100644
> --- a/arch/x86/kernel/pci-nommu.c
> +++ b/arch/x86/kernel/pci-nommu.c
> @@ -38,6 +38,22 @@ static dma_addr_t nommu_map_page(struct device *dev, struct page *page,
>  	return bus;
>  }
>  
> +static dma_addr_t nommu_map_resource(struct device *dev, struct resource *res,
> +				     unsigned long offset, size_t size,
> +				     enum dma_data_direction dir,
> +				     struct dma_attrs *attrs)
> +{
> +	dma_addr_t bus = res->start + offset;

"res->start" is the CPU physical address, not the bus address.  There is a
pci_bus_address() interface to get the bus address.

On many, but not all, x86 platforms the CPU physical address is identical
to the PCI bus address.

> +
> +	WARN_ON(size == 0);
> +
> +	if (!check_addr("map_resource", dev, bus, size))
> +		return DMA_ERROR_CODE;
> +	flush_write_buffers();
> +	return bus;
> +}
> +
> +
>  /* Map a set of buffers described by scatterlist in streaming
>   * mode for DMA.  This is the scatter-gather version of the
>   * above pci_map_single interface.  Here the scatter gather list
> @@ -93,6 +109,7 @@ struct dma_map_ops nommu_dma_ops = {
>  	.free			= dma_generic_free_coherent,
>  	.map_sg			= nommu_map_sg,
>  	.map_page		= nommu_map_page,
> +	.map_resource		= nommu_map_resource,
>  	.sync_single_for_device = nommu_sync_single_for_device,
>  	.sync_sg_for_device	= nommu_sync_sg_for_device,
>  	.is_phys		= 1,
> -- 
> 2.3.7
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
