Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:33609 "EHLO theia.8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751763AbbE2IQV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 29 May 2015 04:16:21 -0400
Date: Fri, 29 May 2015 10:16:18 +0200
From: Joerg Roedel <joro@8bytes.org>
To: wdavis@nvidia.com
Cc: bhelgaas@google.com, iommu@lists.linux-foundation.org,
	linux-pci@vger.kernel.org, tripperda@nvidia.com,
	jhubbard@nvidia.com, jglisse@redhat.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v2 2/7] DMA-API: Introduce dma_(un)map_resource
Message-ID: <20150529081617.GA13130@8bytes.org>
References: <1431973504-5903-1-git-send-email-wdavis@nvidia.com>
 <1431973504-5903-3-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431973504-5903-3-git-send-email-wdavis@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 18, 2015 at 01:24:59PM -0500, wdavis@nvidia.com wrote:
> +static inline dma_addr_t dma_map_resource_attrs(struct device *dev,
> +						struct resource *res,
> +						size_t offset, size_t size,
> +						enum dma_data_direction dir,
> +						struct dma_attrs *attrs)
> +{
> +	const struct dma_map_ops *ops = get_dma_ops(dev);
> +	dma_addr_t addr = 0;
> +
> +	BUG_ON(!valid_dma_direction(dir));
> +	if (ops->map_resource)
> +		addr = ops->map_resource(dev, res, offset, size, dir,
		> atops->map_resourcetrs);
> +	debug_dma_map_resource(dev, res, offset, size, dir, addr);
> +
> +	return addr;
> +}

Please just do a BUG_ON(ops->map_resource == NULL) instead of checking the
pointer and returning 0 if it is NULL. The 0 could be a valid dma_addr
in some implementations, drivers are supposed to check the returned addr
with dma_mapping_error only (and no '== 0' checks).


	Joerg

