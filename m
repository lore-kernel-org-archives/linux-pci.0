Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] PCI: endpoint: Use EPC's device in
 dma_alloc_coherent/dma_free_coherent
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: nsekhar@ti.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaowei Bao <xiaowei.bao@nxp.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20171122085412.12024-1-kishon@ti.com>
From: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Message-ID: <99cd8cec-10c3-8fd4-2bd1-a94ad94e1d3e@free-electrons.com>
Date: Thu, 23 Nov 2017 14:04:26 +0100
MIME-Version: 1.0
In-Reply-To: <20171122085412.12024-1-kishon@ti.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

Le 22/11/2017 à 09:54, Kishon Vijay Abraham I a écrit :
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
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Tested-by: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>

I tested this patch with some Cadence PCIe controller configured in
endpoint mode (I'm about to publish both host and EPC drivers for this
controller) on some ARM64 platform using the pci-epf-test.c driver and the
pcitest userspace program.

My tests were done with both linux-next (next-20171123) and the next branch
of the pci tree.

commit 723288836628bc1c08 ("of: restrict DMA configuration") has already
been merged in linux-next but not in pci-next yet. Hence without Kishon's
patch dma_alloc_coherent() fails when called by pci_epf_alloc_space() on
linux-next.

Best regards,

Cyrille


> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> ---
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
> 


-- 
Cyrille Pitchen, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
