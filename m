Return-Path: <hch@lst.de>
Return-Path: <hch@lst.de>
Date: Wed, 17 Aug 2016 02:48:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-pci@vger.kernel.org,
	agordeev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: two pci_alloc_irq_vectors improvements
Message-ID: <20160817004850.GB21992@lst.de>
References: <1470924665-25860-1-git-send-email-hch@lst.de> <20160816193418.GA10555@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160816193418.GA10555@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 16, 2016 at 02:34:18PM -0500, Bjorn Helgaas wrote:
> Speaking of affinity, the original documentation said "By default this
> function will spread the interrupts around the available CPUs".  After
> these patches, you have to pass PCI_IRQ_AFFINITY to get that behavior.
> Are you planning to have drivers use
> 
>   pci_alloc_irq_vectors(dev, 1, nvec, PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY)
> 
> to explicitly ask for affinity?

Yes, at least for now.  During my mass conversion attempts I found
enough drivers that don't use MSI-X for spreading queues over CPUs
but instead for different kinds of interrupts.  I'd been to much in
my NVMe and RDMA world earlier to assume everyone else would do something
that sensible..

> I applied these to for-linus with the intent of merging them for v4.8.
> I fixed a couple typos in the first one as shown below.

Thanks.
