Return-Path: <agordeev@redhat.com>
Return-Path: <agordeev@redhat.com>
Date: Wed, 11 May 2016 11:44:32 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: helgaas@kernel.org, pjw@netapp.com, axboe@fb.com, keith.busch@intel.com,
        linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] PCI: Provide sensible irq vector alloc/free routines
Message-ID: <20160511094432.GB31347@agordeev.lab.eng.brq.redhat.com>
References: <1462457096-19795-1-git-send-email-hch@lst.de>
 <1462457096-19795-2-git-send-email-hch@lst.de>
 <20160511074527.GA31347@agordeev.lab.eng.brq.redhat.com>
 <20160511085049.GA20279@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160511085049.GA20279@lst.de>
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 11, 2016 at 10:50:49AM +0200, Christoph Hellwig wrote:
> Hi Alexander,
> 
> > Moreover, patch 2/2 not only removed pci_enable_msi[x]_range()
> > internal fallback logic (from desired number of interrupts to
> > available number of interrupts), but it also removed MSI-X to
> > MSI fallback.
> 
> That is done in the very begining of the function, see the quoted
> part of the patch just below:

Nope. This check verifies MSI info, but fail to call arch-specific
arch_setup_msi_irqs() function - that is where an arch actually
does MSI interrupt allocation. I.e. some PPC platforms are known
for its run-time quota which fails to allocate as many vectors as
device MSI header reports. Such conditions are circumvented with a
cycle in range family functions:

	do {
		/* pci_enable_msix() calls arch_setup_msi_irqs() */
		rc = pci_enable_msix(dev, entries, nvec);
		if (rc < 0) {
			return rc;
		} else if (rc > 0) {
			if (rc < minvec)
				return -ENOSPC;
			nvec = rc;
		}
	} while (rc);

> > > +	if (dev->msix_cap && !(flags & PCI_IRQ_NOMSIX))
> > > +		nr_vecs = min_t(unsigned int, nr_vecs, pci_msix_vec_count(dev));
> > > +	else if (dev->msi_cap)
> > > +		nr_vecs = min_t(unsigned int, nr_vecs, pci_msi_vec_count(dev));
> > > +	else
> > > +		goto use_legacy_irq;

So above and below you choose either MSI-X or MSI. That is not a fallback
from MSI-X to MSI, nor most possible number of whatever type of MSI vectors
obtained from the underlying architecture. By contrast, the current NVMe
driver implementation does it:

	vecs = pci_enable_msix_range(pdev, dev->entry, 1, nr_io_queues);
	if (vecs < 0) {
		vecs = pci_enable_msi_range(pdev, 1, min(nr_io_queues, 32));
		if (vecs < 0) {
			vecs = 1;
		} else {
			for (i = 0; i < vecs; i++)
				dev->entry[i].vector = i + pdev->irq;
		}
	}

Again, I do not know what change to NVMe driver is needed. I am just
pointing out that the changlog for pci_alloc_irq_vectors() function is
not entirely correct and the change to NVMe driver might be undesirable.

> > > +	if (dev->msix_cap && !(flags & PCI_IRQ_NOMSIX))
> > > +		ret = __pci_enable_msix(dev, nr_vecs);
> > > +	else
> > > +		ret = __pci_enable_msi(dev, nr_vecs);
> > 
> > 1. No fallbacks.
> 
> I read through the code in msi.c in detail and could not find a legitimate
> case where we have msix_cap but actually fail the MSI-X allocation.  If that
> is a valid case I can happily add the fallback here as well.
> 
