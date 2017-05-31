Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751116AbdEaQvf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 31 May 2017 12:51:35 -0400
Date: Wed, 31 May 2017 11:51:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: rakesh@tuxera.com, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] PCI: ensure the PCI device is locked over ->reset_notify
 calls
Message-ID: <20170531165131.GA4496@bhelgaas-glaptop.roam.corp.google.com>
References: <20170523054202.7985-1-hch@lst.de>
 <20170523054202.7985-2-hch@lst.de>
 <20170530222844.GE14896@bhelgaas-glaptop.roam.corp.google.com>
 <20170531045848.GA4001@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170531045848.GA4001@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 31, 2017 at 06:58:48AM +0200, Christoph Hellwig wrote:
> On Tue, May 30, 2017 at 05:28:44PM -0500, Bjorn Helgaas wrote:
> > [+cc Alex]
> > 
> > On Tue, May 23, 2017 at 07:42:02AM +0200, Christoph Hellwig wrote:
> > > Without this ->notify_reset instance may race with ->remove calls,
> > 
> > Do you mean the .reset_notify() method in struct pci_error_handlers?
> > I don't see a "notify_reset" symbol.
> 
> Yes.
> 
> > Can you elaborate on exactly how this race happens?  I'm trying to
> > figure out whether this is also a problem or potential problem with
> > other reset paths like pci_try_reset_function(), pci_reset_bus(),
> > pci_try_reset_bus(), pci_reset_slot(), and pci_try_reset_slot().
> > 
> > What does the race look like when it happens?  Oops, panic, etc?
> > 
> > Can this also be triggered via the sysfs "reset" file?
> 
> Here is the original bug report:
> 
> http://lists.infradead.org/pipermail/linux-nvme/2017-May/010345.html
> 
> the issue is triggered through sysfs.

Thanks.

Do you have any thoughts on whether the paths I mentioned above are
also susceptible?

I don't want to apply a patch that fixes one issue while leaving
similar ones unfixed.

Bjorn
