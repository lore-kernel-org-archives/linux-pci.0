Return-Path: <hch@lst.de>
Return-Path: <hch@lst.de>
Date: Sun, 1 May 2016 20:01:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, tglx@linutronix.de,
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH 6/8] pci: provide sensible irq vector alloc/free
	routines
Message-ID: <20160501180149.GA11131@lst.de>
References: <1460770552-31260-1-git-send-email-hch@lst.de> <1460770552-31260-7-git-send-email-hch@lst.de> <20160429211638.GB28261@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160429211638.GB28261@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 29, 2016 at 04:16:39PM -0500, Bjorn Helgaas wrote:
> Sorry to be a pedant, but can you please edit the subject to be:
> 
>   PCI: Provide sensible IRQ vector alloc/free routines

sure.

> 
> so it matches the drivers/pci convention?
> 
> I like this idea a lot.  The MSI-X/MSI interfaces are much better than
> they used to be, and I think this would be another significant
> improvement.  What do you think, Alexander?  Here's the whole series
> in case you don't have it handy:
> http://lkml.kernel.org/r/1460770552-31260-1-git-send-email-hch@lst.de

FYI, I spent some time trying to convert more drivers to this, and
I think we'll need an additional flag to skip MSI or MSI-X as there
is plenty of hardware claiming support in the capabilities flag,
but not actually supporting one of them.

> > Hide all the MSI-X vs MSI vs legacy bullshit, and provide an array of
> > interrupt vectors in the pci_dev structure, and ensure we get proper
> > interrupt affinity by default.
> 
> This patch doesn't do anything for affinity by itself.

it used to in an earlier incarnation before I split that out.  But yes,
the changelog should be updated.

> > +	vecs = pci_enable_msix_range_wrapper(pdev, irqs, nr_vecs);
> > +	if (vecs <= 0) {
> > +		vecs = pci_enable_msi_range(pdev, 1, min(nr_vecs, 32));
> 
> I don't see one, but seems like we should have a #define for this
> "32".  I guess pci_enable_msi_range() already protects itself, so this
> min() is probably not strictly necessary anyway.

Ok, I'll take a look an will either remove it entirely or add an
define depending on the audit.
