Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06B6C433F4
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 13:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B97C2154E
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 13:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KF15LKb9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B97C2154E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbeIUTEn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:04:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728384AbeIUTEn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Sep 2018 15:04:43 -0400
Received: from localhost (252.sub-174-234-146.myvzw.com [174.234.146.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC14A21523;
        Fri, 21 Sep 2018 13:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537535752;
        bh=vxNz/xPtDKNHX2rmVttBcWKSaFTNhqfaSjbc0/3Dc48=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KF15LKb962uDg+WACf9NSXfH1WMgax9eWYdgAMM0Zcsep8FQrb2XsEfCEA8xWBPk8
         NprJ3VQ8r2eeb+axrO2aQKLROCL7g1qDcy301wI9oNfCqmspyC7TfNP3k7mf8hG0qS
         yfk6XZ7sCpMHjnHrvHr1jvm9BdzcropIKcamcwiM=
Date:   Fri, 21 Sep 2018 08:15:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v6 03/13] PCI/P2PDMA: Add PCI p2pmem DMA mappings to
 adjust the bus offset
Message-ID: <20180921131550.GG224714@bhelgaas-glaptop.roam.corp.google.com>
References: <20180913001156.4115-1-logang@deltatee.com>
 <20180913001156.4115-4-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913001156.4115-4-logang@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 12, 2018 at 06:11:46PM -0600, Logan Gunthorpe wrote:
> The DMA address used when mapping PCI P2P memory must be the PCI bus
> address. Thus, introduce pci_p2pmem_map_sg() to map the correct
> addresses when using P2P memory. Memory mapped in this way does not
> need to be unmapped.

I think the use of "map" in this context is slightly confusing because the
general expectation is that map/unmap must be balanced.

I assume it's because the "mapping" consumes no resources, e.g., requires
no page table entries.  Possibly there's a better verb than "map", e.g.,
"convert", "convert_to_p2pdma", etc?

If you keep "map", maybe add a sentence or two about why there's no
corresponding unmap?

> For this, we assume that an SGL passed to these functions contain all
> P2P memory or no P2P memory.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/p2pdma.c       | 43 ++++++++++++++++++++++++++++++++++++++
>  include/linux/memremap.h   |  1 +
>  include/linux/pci-p2pdma.h |  7 +++++++
>  3 files changed, 51 insertions(+)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 67c1daf1189e..29bd40a87768 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -191,6 +191,8 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
>  	pgmap->res.flags = pci_resource_flags(pdev, bar);
>  	pgmap->ref = &pdev->p2pdma->devmap_ref;
>  	pgmap->type = MEMORY_DEVICE_PCI_P2PDMA;
> +	pgmap->pci_p2pdma_bus_offset = pci_bus_address(pdev, bar) -
> +		pci_resource_start(pdev, bar);
>  
>  	addr = devm_memremap_pages(&pdev->dev, pgmap);
>  	if (IS_ERR(addr)) {
> @@ -813,3 +815,44 @@ void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
>  	pdev->p2pdma->p2pmem_published = publish;
>  }
>  EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
> +
> +/**
> + * pci_p2pdma_map_sg - map a PCI peer-to-peer scatterlist for DMA
> + * @dev: device doing the DMA request
> + * @sg: scatter list to map
> + * @nents: elements in the scatterlist
> + * @dir: DMA direction
> + *
> + * Scatterlists mapped with this function should not be unmapped in any way.
> + *
> + * Returns the number of SG entries mapped or 0 on error.
> + */
> +int pci_p2pdma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
> +		      enum dma_data_direction dir)
> +{
> +	struct dev_pagemap *pgmap;
> +	struct scatterlist *s;
> +	phys_addr_t paddr;
> +	int i;
> +
> +	/*
> +	 * p2pdma mappings are not compatible with devices that use
> +	 * dma_virt_ops. If the upper layers do the right thing
> +	 * this should never happen because it will be prevented
> +	 * by the check in pci_p2pdma_add_client()
> +	 */
> +	if (WARN_ON_ONCE(IS_ENABLED(CONFIG_DMA_VIRT_OPS) &&
> +			 dev->dma_ops == &dma_virt_ops))
> +		return 0;
> +
> +	for_each_sg(sg, s, nents, i) {
> +		pgmap = sg_page(s)->pgmap;
> +		paddr = sg_phys(s);
> +
> +		s->dma_address = paddr - pgmap->pci_p2pdma_bus_offset;
> +		sg_dma_len(s) = s->length;
> +	}
> +
> +	return nents;
> +}
> +EXPORT_SYMBOL_GPL(pci_p2pdma_map_sg);
> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> index 9553370ebdad..0ac69ddf5fc4 100644
> --- a/include/linux/memremap.h
> +++ b/include/linux/memremap.h
> @@ -125,6 +125,7 @@ struct dev_pagemap {
>  	struct device *dev;
>  	void *data;
>  	enum memory_type type;
> +	u64 pci_p2pdma_bus_offset;
>  };
>  
>  #ifdef CONFIG_ZONE_DEVICE
> diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
> index 7b2b0f547528..2f03dbbf5af6 100644
> --- a/include/linux/pci-p2pdma.h
> +++ b/include/linux/pci-p2pdma.h
> @@ -36,6 +36,8 @@ struct scatterlist *pci_p2pmem_alloc_sgl(struct pci_dev *pdev,
>  					 unsigned int *nents, u32 length);
>  void pci_p2pmem_free_sgl(struct pci_dev *pdev, struct scatterlist *sgl);
>  void pci_p2pmem_publish(struct pci_dev *pdev, bool publish);
> +int pci_p2pdma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
> +		      enum dma_data_direction dir);
>  #else /* CONFIG_PCI_P2PDMA */
>  static inline int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar,
>  		size_t size, u64 offset)
> @@ -98,5 +100,10 @@ static inline void pci_p2pmem_free_sgl(struct pci_dev *pdev,
>  static inline void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
>  {
>  }
> +static inline int pci_p2pdma_map_sg(struct device *dev,
> +		struct scatterlist *sg, int nents, enum dma_data_direction dir)
> +{
> +	return 0;
> +}
>  #endif /* CONFIG_PCI_P2PDMA */
>  #endif /* _LINUX_PCI_P2P_H */
> -- 
> 2.19.0
> 
