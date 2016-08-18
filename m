Return-Path: <hch@lst.de>
Return-Path: <hch@lst.de>
Date: Thu, 18 Aug 2016 17:26:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-pci@vger.kernel.org,
	helgaas@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pci: call pci_intx when using legacy interrupts in
	pci_alloc_irq_vectors
Message-ID: <20160818152649.GA12340@lst.de>
References: <1470924665-25860-1-git-send-email-hch@lst.de> <1470924665-25860-3-git-send-email-hch@lst.de> <20160818092007.GD27949@agordeev.lab.eng.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160818092007.GD27949@agordeev.lab.eng.brq.redhat.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 18, 2016 at 11:20:07AM +0200, Alexander Gordeev wrote:
> On Thu, Aug 11, 2016 at 07:11:05AM -0700, Christoph Hellwig wrote:
> > ahci currently insists on an explicit call to pci_intx before falling back
> > from MSI or MSI-X to legacy irqs.  As pci_intx is a no-op if the command
> > register already contains the right value is seems safe and useful to add
> > this call to pci_alloc_irq_vectors so that ahci can just use
> > pci_alloc_irq_vectors.
> 
> Looking at ahci_init_interrupts() (and probably at commit d684a90d
> ("ahci: per-port msix support")) it looks like pci_alloc_irq_vectors()
> is able to preserve the current AHCI logic?

Not quite.  For the currentl logic we need 3 calls to
pci_alloc_irq_vectors, and I have a patch to implement that.  From
looking at the changelogs and intentions I think we can consolidate
that down to two calls (per-port vectors and single vectors) and I
will propose that as an RFC on top of the base which, which already
is a huge simplification of the driver.

> > @@ -1200,8 +1200,11 @@ int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
> >  	}
> >  
> >  	/* use legacy irq if allowed */
> > -	if ((flags & PCI_IRQ_LEGACY) && min_vecs == 1)
> > +	if ((flags & PCI_IRQ_LEGACY) && min_vecs == 1) {
> > +		pci_intx(dev, 1);
> 
> It would rather called pci_intx_for_msi() here. But because it is
> a generic code I am not sure what implications it has for all
> drivers out there.

It probably should be pci_intx_for_msi.  For now I'm not touching
drivers that need the quirk, so how about getting the intx in
now so that the conversion can start, and I'll send a follow on
to convert to pci_intx_for_msi with Cc to all the relevant parties
for the quirk as a follow on?
