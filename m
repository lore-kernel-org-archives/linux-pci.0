Return-Path: <SRS0=7vYb=5S=lst.de=hch@kernel.org>
Return-Path: <SRS0=7vYb=5S=lst.de=hch@kernel.org>
Date: Tue, 13 Jun 2017 09:08:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, rakesh@tuxera.com,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: ensure the PCI device is locked over
	->reset_notify calls
Message-ID: <20170613070810.GA31936@lst.de>
References: <20170601111039.8913-1-hch@lst.de> <20170601111039.8913-2-hch@lst.de> <20170606053142.GA25064@bhelgaas-glaptop.roam.corp.google.com> <20170606104836.GB24297@lst.de> <20170606211443.GB12672@bhelgaas-glaptop.roam.corp.google.com> <20170607182936.GA31815@lst.de> <20170612231423.GB4379@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170612231423.GB4379@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 12, 2017 at 06:14:23PM -0500, Bjorn Helgaas wrote:
> My main concern is being able to verify the locking.  I think that is
> much easier if the locking is adjacent to the method invocation.  But
> if you just add a comment at the method invocation about where the
> locking is, that should be sufficient.

Ok.  I can add comments for all the methods as a separate patch,
similar to Documentation/vfs/Locking

> > Yes, I mentioned this earlier, and I also vaguely remember we got
> > bug reports from IBM on power for this a while ago.  I just don't
> > feel confident enough to touch all these without a good test plan.
> 
> Hmmm.  I see your point, but I hate leaving a known bug unfixed.  I
> wonder if some enterprising soul could tickle this bug by injecting
> errors while removing and rescanning devices below the bridge?

I'm completely loaded up at the moment, but this sounds like a good
idea.

In the meantime how do you want to proceed with this patch?
