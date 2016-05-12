Return-Path: <hch@lst.de>
Return-Path: <hch@lst.de>
Date: Thu, 12 May 2016 14:19:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, helgaas@kernel.org, pjw@netapp.com,
	axboe@fb.com, keith.busch@intel.com, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] PCI: Provide sensible irq vector alloc/free
	routines
Message-ID: <20160512121933.GA11084@lst.de>
References: <1462457096-19795-1-git-send-email-hch@lst.de> <1462457096-19795-2-git-send-email-hch@lst.de> <20160511074527.GA31347@agordeev.lab.eng.brq.redhat.com> <20160511085049.GA20279@lst.de> <20160511094432.GB31347@agordeev.lab.eng.brq.redhat.com> <20160512073552.GA4027@lst.de> <20160512094432.GA14671@agordeev.lab.eng.brq.redhat.com> <20160512110318.GA9192@lst.de> <20160512121155.GB8681@agordeev.lab.eng.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160512121155.GB8681@agordeev.lab.eng.brq.redhat.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 12, 2016 at 02:11:57PM +0200, Alexander Gordeev wrote:
> Not this way. MSI vectors could be a scarce resource in a platform. So
> even though devices could support more MSI-Xs than MSIs the underlying
> platform might fail to fulfil a device request. 

I can go back to just calling the existing exported functions like
the first version did for now, that'll handle it for now.

> > > Another thing, pci_alloc_irq_vectors() tries to allocate vectors in a
> > > range from 1 to nr_vecs now. So this function implicitly falls into
> > > the other two range functions family and therefore:
> > > 
> > >   (a) pci_alloc_irq_vectors() name is not perfec;
> > 
> > What would you call it instead?
> 
> I do not know, really :( I would expect "range" within the name since
> a range requested indeed, but I am just hinting here.

We're requesting multiple vectors, so I think the naming should be fine.

> > >   (b) why not introduce 'minvec' minimal number of interrupts then?
> > >       We could have a handy pci_enable_irq_range() as result;
> > 
> > That seems pretty pointless, when the caller can simply treat a too
> > small number as failure and use the existing failure path for that.
> 
> There was a huge discussion on this few years ago, when the range
> functions were introduced. Actually, the prototypes of these two is
> the outcome of that discussion. I almost sure your point was expressed
> by many at the time ;)

A quick audit shows that there are indeed a few users of this
interface.  I can add pci_alloc_irq_vectors_range that allows passing
a minvec, and the old pci_alloc_irq_vectors interface for everyone
who wants to keep it simple.

> > pci_enable_msi_range still has a horrible API that forces the caller
> > to deal with the irq numbers differently than the MSI-X case, so it
> > should also go away in the long run.
> 
> Well, if we introduce pci_enable_irq_range() (or something) and
> pci_get_dev_irq(int vector) (or something) that covers MSI-X, MSI and
> legacy IRQs then we can get it done now. Your pci_alloc_irq_vectors()
> is just few steps from there, huh?

Or we can just look at pdev->irqs as in my patch.  That'll work without
much overhead for the single IRQ case as it can just point to ->irq,
and gives a neat interface for MSI-X and the rare multi-MSI case.
