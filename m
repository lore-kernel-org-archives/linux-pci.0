Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751923AbdHBSZD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Aug 2017 14:25:03 -0400
Date: Wed, 2 Aug 2017 13:24:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/MSI: don't try to apply MSI(-X) affinity for single
 vectors
Message-ID: <20170802182458.GC20308@bhelgaas-glaptop.roam.corp.google.com>
References: <20170726201741.4842-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170726201741.4842-1-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 26, 2017 at 10:17:41PM +0200, Christoph Hellwig wrote:
> We'll always get NULL back in that case, so skip the call and the
> resulting warning.

1. I'm not sure PCI_IRQ_AFFINITY was the right name.  IIUC, a
MSI/MSI-X vector is always basically bound to CPU, so we always have
affinity.  The only difference with PCI_IRQ_AFFINITY is that instead
of binding them all to the same CPU, we spread them around.  Maybe
PCI_IRQ_SPREAD would be more suggestive.  But whatever, it is what it
is, and I'll expand the changelog something like this:

  Calling pci_alloc_irq_vectors() with PCI_IRQ_AFFINITY indicates
  that we should spread the MSI vectors around the available CPUs.
  But if we're only allocating one vector, there's nothing to spread
  around.

2. The patch makes sense in that if we're only allocating a single
vector, there's nothing to spread around and there's no need to
allocate a cpumask.  But I haven't figured out why we get a warning.
I assume it's because we're getting NULL back when we call
irq_create_affinity_masks() with nvecs==1, but that only happens if
affv==0 or the zalloc fails, and I don't see why either would be the
case.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/pci/msi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 253d92409bb3..19653e5cb68f 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -538,7 +538,7 @@ msi_setup_entry(struct pci_dev *dev, int nvec, const struct irq_affinity *affd)
>  	struct msi_desc *entry;
>  	u16 control;
>  
> -	if (affd) {
> +	if (affd && nvec > 1) {
>  		masks = irq_create_affinity_masks(nvec, affd);
>  		if (!masks)
>  			dev_err(&dev->dev, "can't allocate MSI affinity masks for %d vectors\n",
> @@ -679,7 +679,7 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
>  	struct msi_desc *entry;
>  	int ret, i;
>  
> -	if (affd) {
> +	if (affd && nvec > 1) {
>  		masks = irq_create_affinity_masks(nvec, affd);
>  		if (!masks)
>  			dev_err(&dev->dev, "can't allocate MSI-X affinity masks for %d vectors\n",
> -- 
> 2.11.0
> 
