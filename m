Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753752AbdFMOFM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Jun 2017 10:05:12 -0400
Date: Tue, 13 Jun 2017 09:05:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: rakesh@tuxera.com, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: ensure the PCI device is locked over
 ->reset_notify calls
Message-ID: <20170613140504.GB7128@bhelgaas-glaptop.roam.corp.google.com>
References: <20170601111039.8913-1-hch@lst.de>
 <20170601111039.8913-2-hch@lst.de>
 <20170606053142.GA25064@bhelgaas-glaptop.roam.corp.google.com>
 <20170606104836.GB24297@lst.de>
 <20170606211443.GB12672@bhelgaas-glaptop.roam.corp.google.com>
 <20170607182936.GA31815@lst.de>
 <20170612231423.GB4379@bhelgaas-glaptop.roam.corp.google.com>
 <20170613070810.GA31936@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170613070810.GA31936@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 13, 2017 at 09:08:10AM +0200, Christoph Hellwig wrote:
> On Mon, Jun 12, 2017 at 06:14:23PM -0500, Bjorn Helgaas wrote:
> > My main concern is being able to verify the locking.  I think that is
> > much easier if the locking is adjacent to the method invocation.  But
> > if you just add a comment at the method invocation about where the
> > locking is, that should be sufficient.
> 
> Ok.  I can add comments for all the methods as a separate patch,
> similar to Documentation/vfs/Locking
> 
> > > Yes, I mentioned this earlier, and I also vaguely remember we got
> > > bug reports from IBM on power for this a while ago.  I just don't
> > > feel confident enough to touch all these without a good test plan.
> > 
> > Hmmm.  I see your point, but I hate leaving a known bug unfixed.  I
> > wonder if some enterprising soul could tickle this bug by injecting
> > errors while removing and rescanning devices below the bridge?
> 
> I'm completely loaded up at the moment, but this sounds like a good
> idea.
> 
> In the meantime how do you want to proceed with this patch?

Can you just add comments about the locking?  I'd prefer that in the
same patch that adds the locking because that's what I had a hard time
reviewing.  I'm not thinking of anything fancy like
Documentation/filesystems/Locking; I'm just thinking of something
along the lines of "caller must hold pci_dev_lock() to protect
err_handler->reset_notify from racing ->remove()".  And the changelog
should contain the general principle about the locking strategy.

Bjorn
