Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753809AbeAJLKc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Jan 2018 06:10:32 -0500
Date: Wed, 10 Jan 2018 11:11:30 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, nsekhar@ti.com,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] PCI: endpoint: Use EPC's device in
 dma_alloc_coherent/dma_free_coherent
Message-ID: <20180110111130.GA27463@red-moon>
References: <20171219083627.7904-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171219083627.7904-1-kishon@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 19, 2017 at 02:06:27PM +0530, Kishon Vijay Abraham I wrote:
> After commit 723288836628bc1c08 ("of: restrict DMA configuration"),
> of_dma_configure doesn't configure the coherent_dma_mask/dma_mask
> of endpoint function device (since it doesn't have a dt node associated
> with and hence no dma-ranges property), resulting in dma_alloc_coherent
> (used in pci_epf_alloc_space) to fail.
> 
> Fix it by making dma_alloc_coherent use EPC's device for allocating
> memory address as per discussion in [1]
> 
> [1] https://lkml.org/lkml/2017/10/24/26

Hi Kishon,

small nit, mind embedding the link [1] above in a lkml redirector
format - as described in:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v4.15-rc7

put it in a Link: tag to be added below - I think that's important
for the commit log to have.

Either send me the formatted link or send a v3 with it, I will merge
then.

Thanks,
Lorenzo

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Tested-by: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
> ---
> No change in patch. Only added "Tested-by" of Cyrille Pitchen.
> 
>  drivers/pci/endpoint/pci-epc-core.c | 10 ----------
>  drivers/pci/endpoint/pci-epf-core.c |  4 ++--
>  2 files changed, 2 insertions(+), 12 deletions(-)
> 
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
