Return-Path: <hch@lst.de>
Return-Path: <hch@lst.de>
Date: Wed, 11 May 2016 10:50:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, helgaas@kernel.org, pjw@netapp.com,
	axboe@fb.com, keith.busch@intel.com, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] PCI: Provide sensible irq vector alloc/free
	routines
Message-ID: <20160511085049.GA20279@lst.de>
References: <1462457096-19795-1-git-send-email-hch@lst.de> <1462457096-19795-2-git-send-email-hch@lst.de> <20160511074527.GA31347@agordeev.lab.eng.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160511074527.GA31347@agordeev.lab.eng.brq.redhat.com>
List-ID: <linux-pci.vger.kernel.org>

Hi Alexander,

> Moreover, patch 2/2 not only removed pci_enable_msi[x]_range()
> internal fallback logic (from desired number of interrupts to
> available number of interrupts), but it also removed MSI-X to
> MSI fallback.

That is done in the very begining of the function, see the quoted
part of the patch just below:

> > +	if (dev->msix_cap && !(flags & PCI_IRQ_NOMSIX))
> > +		nr_vecs = min_t(unsigned int, nr_vecs, pci_msix_vec_count(dev));
> > +	else if (dev->msi_cap)
> > +		nr_vecs = min_t(unsigned int, nr_vecs, pci_msi_vec_count(dev));
> > +	else
> > +		goto use_legacy_irq;

> > +	if (dev->msix_cap && !(flags & PCI_IRQ_NOMSIX))
> > +		ret = __pci_enable_msix(dev, nr_vecs);
> > +	else
> > +		ret = __pci_enable_msi(dev, nr_vecs);
> 
> 1. No fallbacks.

I read through the code in msi.c in detail and could not find a legitimate
case where we have msix_cap but actually fail the MSI-X allocation.  If that
is a valid case I can happily add the fallback here as well.
