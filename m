Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750972AbdH3QkX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Aug 2017 12:40:23 -0400
Date: Wed, 30 Aug 2017 11:40:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] vmd: Remove IRQ affinity
Message-ID: <20170830164020.GC18250@bhelgaas-glaptop.roam.corp.google.com>
References: <1504109704-17033-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1504109704-17033-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Christoph]

On Wed, Aug 30, 2017 at 12:15:04PM -0400, Keith Busch wrote:
> VMD hardware has to share its vectors among child devices in its PCI
> domain so we should allocate as many as possible rather than just ones
> that can be affinitized.

I don't understand this changelog.  It suggests that
pci_alloc_irq_vectors() will allocate more vectors than
pci_alloc_irq_vectors_affinity() would.

But my understanding was that pci_alloc_irq_vectors_affinity() does have
anything to do with the number of vectors allocated, but that it only
provided more fine-grained control of affinity.

  commit 402723ad5c62
  Author: Christoph Hellwig <hch@lst.de>
  Date:   Tue Nov 8 17:15:05 2016 -0800

    PCI/MSI: Provide pci_alloc_irq_vectors_affinity()
    
    This is a variant of pci_alloc_irq_vectors() that allows passing a struct
    irq_affinity to provide fine-grained IRQ affinity control.
    
    For now this means being able to exclude vectors at the beginning or end of
    the MSI vector space, but it could also be used for any other quirks needed
    in the future (e.g. more vectors than CPUs, or excluding CPUs from the
    spreading).

So IIUC, this patch does not change the number of vectors allocated.  It
does remove PCI_IRQ_AFFINITY, which I suppose means all the vectors target
the same CPU instead of being spread across CPUs.

> Reported-by: Brad Goodman <Bradley.Goodman@dell.com>
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/pci/host/vmd.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/host/vmd.c b/drivers/pci/host/vmd.c
> index 4fe1756..509893b 100644
> --- a/drivers/pci/host/vmd.c
> +++ b/drivers/pci/host/vmd.c
> @@ -671,14 +671,6 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	struct vmd_dev *vmd;
>  	int i, err;
>  
> -	/*
> -	 * The first vector is reserved for special use, so start affinity at
> -	 * the second vector
> -	 */
> -	struct irq_affinity affd = {
> -		.pre_vectors = 1,
> -	};
> -
>  	if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20))
>  		return -ENOMEM;
>  
> @@ -704,8 +696,8 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	if (vmd->msix_count < 0)
>  		return -ENODEV;
>  
> -	vmd->msix_count = pci_alloc_irq_vectors_affinity(dev, 1, vmd->msix_count,
> -					PCI_IRQ_MSIX | PCI_IRQ_AFFINITY, &affd);
> +	vmd->msix_count = pci_alloc_irq_vectors(dev, 1, vmd->msix_count,
> +					PCI_IRQ_MSIX);
>  	if (vmd->msix_count < 0)
>  		return vmd->msix_count;
>  
> -- 
> 2.5.5
> 
