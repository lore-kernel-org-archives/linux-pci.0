Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752153AbdFLXO0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Jun 2017 19:14:26 -0400
Date: Mon, 12 Jun 2017 18:14:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: rakesh@tuxera.com, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: ensure the PCI device is locked over
 ->reset_notify calls
Message-ID: <20170612231423.GB4379@bhelgaas-glaptop.roam.corp.google.com>
References: <20170601111039.8913-1-hch@lst.de>
 <20170601111039.8913-2-hch@lst.de>
 <20170606053142.GA25064@bhelgaas-glaptop.roam.corp.google.com>
 <20170606104836.GB24297@lst.de>
 <20170606211443.GB12672@bhelgaas-glaptop.roam.corp.google.com>
 <20170607182936.GA31815@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170607182936.GA31815@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 07, 2017 at 08:29:36PM +0200, Christoph Hellwig wrote:
> On Tue, Jun 06, 2017 at 04:14:43PM -0500, Bjorn Helgaas wrote:
> > So I guess the method here is
> > dev->driver->err_handler->reset_notify(), and the PCI core should be
> > holding device_lock() while calling it?  That makes sense to me;
> > thanks a lot for articulating that!
> 
> Yes.
> 
> > 1) The current patch protects the err_handler->reset_notify() uses by
> > adding or expanding device_lock regions in the paths that lead to
> > pci_reset_notify().  Could we simplify it by doing the locking
> > directly in pci_reset_notify()?  Then it would be easy to verify the
> > locking, and we would be less likely to add new callers without the
> > proper locking.
> 
> We could do that, except that I'd rather hold the lock over a longer
> period if we have many calls following each other.  

My main concern is being able to verify the locking.  I think that is
much easier if the locking is adjacent to the method invocation.  But
if you just add a comment at the method invocation about where the
locking is, that should be sufficient.

> I also have
> a patch to actually kill pci_reset_notify() later in the series as
> well, as the calling convention for it and ->reset_notify() are
> awkward - depending on prepare parameter they do two entirely
> different things.  That being said I could also add new
> pci_reset_prepare() and pci_reset_done() helpers.

I like your pci_reset_notify() changes; they make that much clearer.
I don't think new helpers are necessary.

> > 2) Stating the rule explicitly helps look for other problems, and I
> > think we have a similar problem in all the pcie_portdrv_err_handler
> > methods.
> 
> Yes, I mentioned this earlier, and I also vaguely remember we got
> bug reports from IBM on power for this a while ago.  I just don't
> feel confident enough to touch all these without a good test plan.

Hmmm.  I see your point, but I hate leaving a known bug unfixed.  I
wonder if some enterprising soul could tickle this bug by injecting
errors while removing and rescanning devices below the bridge?

Bjorn
