Return-Path: <agordeev@redhat.com>
Return-Path: <agordeev@redhat.com>
Date: Thu, 12 May 2016 11:44:33 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: helgaas@kernel.org, pjw@netapp.com, axboe@fb.com, keith.busch@intel.com,
        linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] PCI: Provide sensible irq vector alloc/free routines
Message-ID: <20160512094432.GA14671@agordeev.lab.eng.brq.redhat.com>
References: <1462457096-19795-1-git-send-email-hch@lst.de>
 <1462457096-19795-2-git-send-email-hch@lst.de>
 <20160511074527.GA31347@agordeev.lab.eng.brq.redhat.com>
 <20160511085049.GA20279@lst.de>
 <20160511094432.GB31347@agordeev.lab.eng.brq.redhat.com>
 <20160512073552.GA4027@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160512073552.GA4027@lst.de>
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 12, 2016 at 09:35:52AM +0200, Christoph Hellwig wrote:
> Hi Alex,
> 
> what do you think about the incremental patch below?  This should
> address the concerns about the strange PPC bridges, although I don't
> have a way to test one:
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index a510484..32ce65e 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1177,6 +1177,7 @@ int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int nr_vecs,
>  	if (WARN_ON_ONCE(dev->msi_enabled || dev->msix_enabled))
>  		return -EINVAL;
>  
> +retry:

A retry does not seem needs checking MSI support each time, nor reading
MSI header info like number of vectors (not visible in this patch).

>  	if (!pci_msi_supported(dev, 1))
>  		goto use_legacy_irq;
>  
> @@ -1191,17 +1192,26 @@ int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int nr_vecs,
>  	if (!dev->irqs)
>  		return -ENOMEM;
>  
> -	if (dev->msix_cap && !(flags & PCI_IRQ_NOMSIX))
> +	if (dev->msix_cap && !(flags & PCI_IRQ_NOMSIX)) {
>  		ret = __pci_enable_msix(dev, nr_vecs);
> -	else
> +		if (ret < 0)
> +			flags |= PCI_IRQ_NOMSIX;
> +	} else {
>  		ret = __pci_enable_msi(dev, nr_vecs);
> -	if (ret)
> -		goto out_free_irqs;
> +	}
>  
> -	return 0;
> +	/* if we succeeded getting all vectors return the number we got: */
> +	if (!ret)
> +		return nr_vecs;
>  
> -out_free_irqs:
>  	kfree(dev->irqs);
> +	/* if ret is positive it's the numbers of vectors we can use, retry: */
> +	if (ret > 0) {
> +		nr_vecs = ret;
> +		goto retry;
> +	}

Okay, now we have a subtlety here. You switch from MSI-X to MSI in case
MSI-X retries exhausted. At this point nr_vecs is lowest (likely 1). So
you start trying MSI from 1 rather from 32. I would suggest two subsequent
loops instead.

Another thing, pci_alloc_irq_vectors() tries to allocate vectors in a
range from 1 to nr_vecs now. So this function implicitly falls into
the other two range functions family and therefore:

  (a) pci_alloc_irq_vectors() name is not perfec;
  (b) why not introduce 'minvec' minimal number of interrupts then?
      We could have a handy pci_enable_irq_range() as result;
  (c) if you do (b) then PCI_IRQ_NOMSIX flag becomes redundant, since
      caller would invoke pci_enable_msi_range() instead;

> +
> +	/* no MSI or MSI-X vectors available, fall back to the legacy IRQ: */
>  use_legacy_irq:
>  	dev->irqs = &dev->irq;
>  	return 1;
