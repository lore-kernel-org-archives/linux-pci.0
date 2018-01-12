Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50308 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964846AbeALSHg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Jan 2018 13:07:36 -0500
Date: Fri, 12 Jan 2018 18:08:38 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, nsekhar@ti.com,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3] PCI: endpoint: Use EPC's device in
 dma_alloc_coherent/dma_free_coherent
Message-ID: <20180112180838.GD26438@red-moon>
References: <20180111083057.1134-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180111083057.1134-1-kishon@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 11, 2018 at 02:00:57PM +0530, Kishon Vijay Abraham I wrote:
> After commit 723288836628bc1c08 ("of: restrict DMA configuration"),
> of_dma_configure doesn't configure the coherent_dma_mask/dma_mask
> of endpoint function device (since it doesn't have a dt node associated
> with and hence no dma-ranges property), resulting in dma_alloc_coherent
> (used in pci_epf_alloc_space) to fail.
> 
> Fix it by making dma_alloc_coherent use EPC's device for allocating
> memory address.
> 
> Link: http://lkml.kernel.org/r/64d63468-d28f-8fcd-a6f3-cf2a6401c8cb@ti.com
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Tested-by: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
> Tested-by: Niklas Cassel <niklas.cassel@axis.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> ---
> Changes from v2:
> No change in patch. Added "Link", "Reviewed-by" and "Tested-by" tags
> 
> Changes from v1:
> No change in patch. Only added "Tested-by" of Cyrille Pitchen.
> 
>  drivers/pci/endpoint/pci-epc-core.c | 10 ----------
>  drivers/pci/endpoint/pci-epf-core.c |  4 ++--
>  2 files changed, 2 insertions(+), 12 deletions(-)

Applied to pci/endpoint for v4.16, thanks.

Lorenzo

> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 42c2a1156325..cd7d4788b94d 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -18,7 +18,6 @@
>   */
>  
>  #include <linux/device.h>
> -#include <linux/dma-mapping.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> @@ -371,7 +370,6 @@ EXPORT_SYMBOL_GPL(pci_epc_write_header);
>  int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf)
>  {
>  	unsigned long flags;
> -	struct device *dev = epc->dev.parent;
>  
>  	if (epf->epc)
>  		return -EBUSY;
> @@ -383,12 +381,6 @@ int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf)
>  		return -EINVAL;
>  
>  	epf->epc = epc;
> -	if (dev->of_node) {
> -		of_dma_configure(&epf->dev, dev->of_node);
> -	} else {
> -		dma_set_coherent_mask(&epf->dev, epc->dev.coherent_dma_mask);
> -		epf->dev.dma_mask = epc->dev.dma_mask;
> -	}
>  
>  	spin_lock_irqsave(&epc->lock, flags);
>  	list_add_tail(&epf->list, &epc->pci_epf);
> @@ -503,9 +495,7 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
>  	INIT_LIST_HEAD(&epc->pci_epf);
>  
>  	device_initialize(&epc->dev);
> -	dma_set_coherent_mask(&epc->dev, dev->coherent_dma_mask);
>  	epc->dev.class = pci_epc_class;
> -	epc->dev.dma_mask = dev->dma_mask;
>  	epc->dev.parent = dev;
>  	epc->ops = ops;
>  
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index ae1611a62808..95ccc4b8a0a2 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -99,7 +99,7 @@ EXPORT_SYMBOL_GPL(pci_epf_bind);
>   */
>  void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar)
>  {
> -	struct device *dev = &epf->dev;
> +	struct device *dev = epf->epc->dev.parent;
>  
>  	if (!addr)
>  		return;
> @@ -122,7 +122,7 @@ EXPORT_SYMBOL_GPL(pci_epf_free_space);
>  void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar)
>  {
>  	void *space;
> -	struct device *dev = &epf->dev;
> +	struct device *dev = epf->epc->dev.parent;
>  	dma_addr_t phys_addr;
>  
>  	if (size < 128)
> -- 
> 2.11.0
> 
