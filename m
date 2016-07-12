Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:49041 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779AbcGLJR4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Jul 2016 05:17:56 -0400
Date: Tue, 12 Jul 2016 11:17:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 5/5] pci: spread interrupt vectors in
	pci_alloc_irq_vectors
Message-ID: <20160712091754.GC4845@lst.de>
References: <1468151866-7776-1-git-send-email-hch@lst.de> <1468151866-7776-6-git-send-email-hch@lst.de> <20160711205110.GA23915@dhcp-27-118.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160711205110.GA23915@dhcp-27-118.brq.redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 11, 2016 at 10:51:11PM +0200, Alexander Gordeev wrote:
> > +			dev->irq_affinity = irq_create_affinity_mask(&nvec);
> > +			if (nvec < minvec)
> > +				return -ERANGE;
> 
> 				return -ENOSPC;

Ok, fixed.

> > +		dev->irq_affinity = NULL;
> > +
> > +		if (rc < 0)
> >  			return rc;
> > +		if (rc < minvec)
> 
> 		else if (rc < minvec)

No need for the else - the previous line is a return (I've dropped
the removed lines above so that it's clearly visible).  And we already
handle the rc == 0 case a few lines above.

> > +int pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec)
> > +{
> > +	return __pci_enable_msi_range(dev, minvec, maxvec, PCI_IRQ_NOAFFINITY);
> >  }
> >  EXPORT_SYMBOL(pci_enable_msi_range);
> 
> As a one-liner pci_enable_msi_range() appears rather as a static inline
> in linux/pci.h, but we do not want __pci_enable_msi*_range() to show up
> in a public header, right?

Exactly.

> > +		if (!(flags & PCI_IRQ_NOAFFINITY)) {
> > +			dev->irq_affinity = irq_create_affinity_mask(&nvec);
> > +			if (nvec < minvec)
> > +				return -ERANGE;
> 
> 				return -ENOSPC;

Fixed.

