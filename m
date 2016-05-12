Return-Path: <hch@lst.de>
Return-Path: <hch@lst.de>
Date: Thu, 12 May 2016 13:03:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, helgaas@kernel.org, pjw@netapp.com,
	axboe@fb.com, keith.busch@intel.com, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] PCI: Provide sensible irq vector alloc/free
	routines
Message-ID: <20160512110318.GA9192@lst.de>
References: <1462457096-19795-1-git-send-email-hch@lst.de> <1462457096-19795-2-git-send-email-hch@lst.de> <20160511074527.GA31347@agordeev.lab.eng.brq.redhat.com> <20160511085049.GA20279@lst.de> <20160511094432.GB31347@agordeev.lab.eng.brq.redhat.com> <20160512073552.GA4027@lst.de> <20160512094432.GA14671@agordeev.lab.eng.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160512094432.GA14671@agordeev.lab.eng.brq.redhat.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 12, 2016 at 11:44:33AM +0200, Alexander Gordeev wrote:
> On Thu, May 12, 2016 at 09:35:52AM +0200, Christoph Hellwig wrote:
> > Hi Alex,
> > 
> > what do you think about the incremental patch below?  This should
> > address the concerns about the strange PPC bridges, although I don't
> > have a way to test one:
> > 
> > diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> > index a510484..32ce65e 100644
> > --- a/drivers/pci/msi.c
> > +++ b/drivers/pci/msi.c
> > @@ -1177,6 +1177,7 @@ int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int nr_vecs,
> >  	if (WARN_ON_ONCE(dev->msi_enabled || dev->msix_enabled))
> >  		return -EINVAL;
> >  
> > +retry:
> 
> A retry does not seem needs checking MSI support each time, nor reading
> MSI header info like number of vectors (not visible in this patch).

I can easily skip the pci_msi_supported check, but we either need
to re-read the number of vectors, as that is done differently for
MSI vs MSIX, or totally restructure the code, which doesn't seem worth it,
especially as the existing code also re-reads it every time.

> > -out_free_irqs:
> >  	kfree(dev->irqs);
> > +	/* if ret is positive it's the numbers of vectors we can use, retry: */
> > +	if (ret > 0) {
> > +		nr_vecs = ret;
> > +		goto retry;
> > +	}
> 
> Okay, now we have a subtlety here. You switch from MSI-X to MSI in case
> MSI-X retries exhausted. At this point nr_vecs is lowest (likely 1). So
> you start trying MSI from 1 rather from 32. I would suggest two subsequent
> loops instead.

So bridges could support less MSI-X entries than MSI ones?  Yikes.

> Another thing, pci_alloc_irq_vectors() tries to allocate vectors in a
> range from 1 to nr_vecs now. So this function implicitly falls into
> the other two range functions family and therefore:
> 
>   (a) pci_alloc_irq_vectors() name is not perfec;

What would you call it instead?

>   (b) why not introduce 'minvec' minimal number of interrupts then?
>       We could have a handy pci_enable_irq_range() as result;

That seems pretty pointless, when the caller can simply treat a too
small number as failure and use the existing failure path for that.

>   (c) if you do (b) then PCI_IRQ_NOMSIX flag becomes redundant, since
>       caller would invoke pci_enable_msi_range() instead;

pci_enable_msi_range still has a horrible API that forces the caller
to deal with the irq numbers differently than the MSI-X case, so it
should also go away in the long run.
