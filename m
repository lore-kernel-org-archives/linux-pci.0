Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:35526 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbbHRX0Y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Aug 2015 19:26:24 -0400
MIME-Version: 1.0
Message-ID: <2dd0ce48-fb6e-4003-90ee-33827ebfc7c1@default>
Date: Tue, 18 Aug 2015 16:26:09 -0700 (PDT)
From: Konrad Wilk <konrad.wilk@oracle.com>
To: <wdavis@nvidia.com>
Cc: <tripperda@nvidia.com>, <linux-pci@vger.kernel.org>,
	<joro@8bytes.org>, <iommu@lists.linux-foundation.org>,
	<jhubbard@nvidia.com>, <bhelgaas@google.com>,
	<davem@davemloft.net>, <markh@compro.net>, <jglisse@redhat.com>,
	<corbet@lwn.net>, <alex.williamson@redhat.com>
Subject: Re: [PATCH v5 04/13] DMA-API: Introduce dma_(un)map_peer_resource
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


> +#ifdef CONFIG_HAS_DMA_P2P
> +static inline dma_peer_addr_t dma_map_peer_resource_attrs(struct
> device *dev,
> +							  struct device *peer,
> +							  struct resource *res,
> +							  size_t offset,
> +							  size_t size,
> +							  enum dma_data_direction dir,
> +							  struct dma_attrs *attrs)
> +{
> +	struct dma_map_ops *ops = get_dma_ops(dev);
> +	dma_peer_addr_t addr;
> +
> +	BUG_ON(!valid_dma_direction(dir));
> +	BUG_ON(ops->map_peer_resource == NULL);
> +	addr = ops->map_peer_resource(dev, peer, res, offset, size, dir,
> +				      attrs);
> +	debug_dma_map_peer_resource(dev, peer, res, offset, size, dir,
> addr);
> +
> +	return addr;
> +

With those 'BUG_ON' you need to make sure that every dma_map_ops has
this implemented. That means the calgary_dma_ops, gart_dma_ops, swiotlb_dma_ops,
and xen_swiotlb_dma_ops MUST have something implemented.

Please keep in mind that on one can do 'iommu=soft swiotbl=force' on the
command line which will force the IOMMUs to be ignored and only the
SWIOTLB code will be used.

