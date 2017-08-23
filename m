Return-Path: <SRS0=RHy1=7Z=linux.ee=mroos@kernel.org>
Return-Path: <SRS0=RHy1=7Z=linux.ee=mroos@kernel.org>
Date: Wed, 23 Aug 2017 17:24:54 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
Sender: mroos@math.ut.ee
To: Christoph Hellwig <hch@lst.de>
cc: helgaas@kernel.org, davem@davemloft.net, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/msi: don't warn on irq_create_affinity_masks NULL
 return
In-Reply-To: <20170823115459.2058-1-hch@lst.de>
Message-ID: <alpine.LRH.2.20.1708231724340.9040@math.ut.ee>
References: <20170823115459.2058-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

> irq_create_affinity_masks can easily return NULL when there are not
> enough "free" vectors available to spread, while the memory allocation
> failure for the CPU masks not only is unlikely, but also relatively
> harmless as the system will work just fine except for non-optimally
> spread vectors.  Thus remove the warnings.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Yes, this makes the warning go away but driver still loads.


> ---
>  drivers/pci/msi.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 253d92409bb3..2225afc1cbbb 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -538,12 +538,9 @@ msi_setup_entry(struct pci_dev *dev, int nvec, const struct irq_affinity *affd)
>  	struct msi_desc *entry;
>  	u16 control;
>  
> -	if (affd) {
> +	if (affd)
>  		masks = irq_create_affinity_masks(nvec, affd);
> -		if (!masks)
> -			dev_err(&dev->dev, "can't allocate MSI affinity masks for %d vectors\n",
> -				nvec);
> -	}
> +
>  
>  	/* MSI Entry Initialization */
>  	entry = alloc_msi_entry(&dev->dev, nvec, masks);
> @@ -679,12 +676,8 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
>  	struct msi_desc *entry;
>  	int ret, i;
>  
> -	if (affd) {
> +	if (affd)
>  		masks = irq_create_affinity_masks(nvec, affd);
> -		if (!masks)
> -			dev_err(&dev->dev, "can't allocate MSI-X affinity masks for %d vectors\n",
> -				nvec);
> -	}
>  
>  	for (i = 0, curmsk = masks; i < nvec; i++) {
>  		entry = alloc_msi_entry(&dev->dev, 1, curmsk);
> 

-- 
Meelis Roos (mroos@linux.ee)
