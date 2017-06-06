Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751465AbdFFVOp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Jun 2017 17:14:45 -0400
Date: Tue, 6 Jun 2017 16:14:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: rakesh@tuxera.com, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: ensure the PCI device is locked over
 ->reset_notify calls
Message-ID: <20170606211443.GB12672@bhelgaas-glaptop.roam.corp.google.com>
References: <20170601111039.8913-1-hch@lst.de>
 <20170601111039.8913-2-hch@lst.de>
 <20170606053142.GA25064@bhelgaas-glaptop.roam.corp.google.com>
 <20170606104836.GB24297@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170606104836.GB24297@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 06, 2017 at 12:48:36PM +0200, Christoph Hellwig wrote:
> On Tue, Jun 06, 2017 at 12:31:42AM -0500, Bjorn Helgaas wrote:
> > OK, sorry to be dense; it's taking me a long time to work out the
> > details here.  It feels like there should be a general principle to
> > help figure out where we need locking, and it would be really awesome
> > if we could include that in the changelog.  But it's not obvious to me
> > what that principle would be.
> 
> The principle is very simple: every method in struct device_driver
> or structures derived from it like struct pci_driver MUST provide
> exclusion vs ->remove.  Usuaull by using device_lock().
> 
> If we don't provide such an exclusion the method call can race with
> a removal in one form or another.

So I guess the method here is
dev->driver->err_handler->reset_notify(), and the PCI core should be
holding device_lock() while calling it?  That makes sense to me;
thanks a lot for articulating that!

1) The current patch protects the err_handler->reset_notify() uses by
adding or expanding device_lock regions in the paths that lead to
pci_reset_notify().  Could we simplify it by doing the locking
directly in pci_reset_notify()?  Then it would be easy to verify the
locking, and we would be less likely to add new callers without the
proper locking.

2) Stating the rule explicitly helps look for other problems, and I
think we have a similar problem in all the pcie_portdrv_err_handler
methods.  These are all called in the AER do_recovery() path, and the
functions there, e.g., report_error_detected() do hold device_lock().
But pcie_portdrv_error_detected() propagates this to all the children,
and we *don't* hold the lock for the children.

Bjorn
