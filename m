Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756757AbdHZAC0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Aug 2017 20:02:26 -0400
Date: Fri, 25 Aug 2017 19:02:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/MSI: don't try to apply MSI(-X) affinity for single
 vectors
Message-ID: <20170826000208.GD8154@bhelgaas-glaptop.roam.corp.google.com>
References: <20170726201741.4842-1-hch@lst.de>
 <20170802182458.GC20308@bhelgaas-glaptop.roam.corp.google.com>
 <20170821183905.GB23205@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170821183905.GB23205@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 21, 2017 at 08:39:05PM +0200, Christoph Hellwig wrote:
> On Wed, Aug 02, 2017 at 01:24:58PM -0500, Bjorn Helgaas wrote:
> > On Wed, Jul 26, 2017 at 10:17:41PM +0200, Christoph Hellwig wrote:
> > > We'll always get NULL back in that case, so skip the call and the
> > > resulting warning.
> > 
> > 1. I'm not sure PCI_IRQ_AFFINITY was the right name.  IIUC, a
> > MSI/MSI-X vector is always basically bound to CPU,
> 
> This will depend on your architecture.
> 
> > so we always have
> > affinity.  The only difference with PCI_IRQ_AFFINITY is that instead
> > of binding them all to the same CPU, we spread them around.  Maybe
> > PCI_IRQ_SPREAD would be more suggestive.  But whatever, it is what it
> > is, and I'll expand the changelog something like this:
> 
> Yes, that might be a better name.  We don't have that many callers
> yet, so we could probably still change it.
> 
> > 
> >   Calling pci_alloc_irq_vectors() with PCI_IRQ_AFFINITY indicates
> >   that we should spread the MSI vectors around the available CPUs.
> >   But if we're only allocating one vector, there's nothing to spread
> >   around.
> 
> Ok.
> 
> > 2. The patch makes sense in that if we're only allocating a single
> > vector, there's nothing to spread around and there's no need to
> > allocate a cpumask.  But I haven't figured out why we get a warning.
> > I assume it's because we're getting NULL back when we call
> > irq_create_affinity_masks() with nvecs==1, but that only happens if
> > affv==0 or the zalloc fails, and I don't see why either would be the
> > case.
> 
> It happens for the !CONFIG_SMP case.  It also happens for the case where
> we pre_vectors or post_vectors reduces the affinity vector count to 1
> inside irq_create_affinity_masks, so maybe this patch isn't the best and
> the warning should either move into irq_create_affinity_masks or just
> remove it entirely.

Oh, thanks, I totally missed the !CONFIG_SMP case, sorry about that.

I applied the follow-on patch, which I think obsoletes this one.
