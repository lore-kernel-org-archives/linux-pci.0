Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:35906 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbbGAQGM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jul 2015 12:06:12 -0400
Received: by iecvh10 with SMTP id vh10so37950605iec.3
        for <linux-pci@vger.kernel.org>; Wed, 01 Jul 2015 09:06:11 -0700 (PDT)
Date: Wed, 1 Jul 2015 11:06:06 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: wdavis@nvidia.com
Cc: Joerg Roedel <joro@8bytes.org>,
	Terence Ripperda <tripperda@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Jerome Glisse <jglisse@redhat.com>,
	Mark Hounschell <markh@compro.net>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	Yijing Wang <wangyijing@huawei.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>,
	iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 3/7] dma-mapping: pci: add pci_(un)map_resource
Message-ID: <20150701160606.GA13409@google.com>
References: <1432919686-32306-1-git-send-email-wdavis@nvidia.com>
 <1432919686-32306-4-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432919686-32306-4-git-send-email-wdavis@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 29, 2015 at 12:14:42PM -0500, wdavis@nvidia.com wrote:
> From: Will Davis <wdavis@nvidia.com>
> 
> Simply route these through to the new dma_(un)map_resource APIs.
> 
> Signed-off-by: Will Davis <wdavis@nvidia.com>
> Reviewed-by: Terence Ripperda <tripperda@nvidia.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  include/asm-generic/pci-dma-compat.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/asm-generic/pci-dma-compat.h b/include/asm-generic/pci-dma-compat.h
> index c110843..ac4a4ad 100644
> --- a/include/asm-generic/pci-dma-compat.h
> +++ b/include/asm-generic/pci-dma-compat.h
> @@ -61,6 +61,20 @@ pci_unmap_page(struct pci_dev *hwdev, dma_addr_t dma_address,
>  	dma_unmap_page(hwdev == NULL ? NULL : &hwdev->dev, dma_address, size, (enum dma_data_direction)direction);
>  }
>  
> +static inline dma_addr_t
> +pci_map_resource(struct pci_dev *hwdev, struct resource *resource,
> +		 unsigned long offset, size_t size, int direction)

After 3a9ad0b4fdcd ("PCI: Add pci_bus_addr_t"), which will appear in
v4.2-rc1, there is a pci_bus_addr_t, and I think you need that instead
of dma_addr_t.

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=3a9ad0b4fdcd

> +{
> +	return dma_map_resource(hwdev == NULL ? NULL : &hwdev->dev, resource, offset, size, (enum dma_data_direction)direction);
> +}
> +
> +static inline void
> +pci_unmap_resource(struct pci_dev *hwdev, dma_addr_t dma_address, size_t size,
> +		   int direction)
> +{
> +	dma_unmap_resource(hwdev == NULL ? NULL : &hwdev->dev, dma_address, size, (enum dma_data_direction)direction);
> +}
> +
>  static inline int
>  pci_map_sg(struct pci_dev *hwdev, struct scatterlist *sg,
>  	   int nents, int direction)
> -- 
> 2.4.0
> 
