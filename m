Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756757AbdHZAA5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Aug 2017 20:00:57 -0400
Date: Fri, 25 Aug 2017 19:00:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: davem@davemloft.net, mroos@linux.ee, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/msi: don't warn on irq_create_affinity_masks NULL
 return
Message-ID: <20170826000055.GC8154@bhelgaas-glaptop.roam.corp.google.com>
References: <20170823115459.2058-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170823115459.2058-1-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 23, 2017 at 01:54:59PM +0200, Christoph Hellwig wrote:
> irq_create_affinity_masks can easily return NULL when there are not
> enough "free" vectors available to spread, while the memory allocation
> failure for the CPU masks not only is unlikely, but also relatively
> harmless as the system will work just fine except for non-optimally
> spread vectors.  Thus remove the warnings.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I applied this with David's ack to for-linus for v4.13.  It's not
strictly speaking a bug fix, but I think the warnings would cause
needless alarm for v4.13 users.

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
> -- 
> 2.11.0
> 
