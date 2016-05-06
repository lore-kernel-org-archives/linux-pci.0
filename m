Return-Path: <hch@lst.de>
Return-Path: <hch@lst.de>
Date: Fri, 6 May 2016 18:28:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, agordeev@redhat.com, pjw@netapp.com,
	axboe@fb.com, keith.busch@intel.com, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] PCI: Provide sensible irq vector alloc/free
	routines
Message-ID: <20160506162823.GB7999@lst.de>
References: <1462457096-19795-1-git-send-email-hch@lst.de> <1462457096-19795-2-git-send-email-hch@lst.de> <20160506160408.GB15666@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160506160408.GB15666@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 06, 2016 at 11:04:08AM -0500, Bjorn Helgaas wrote:
> I like this a lot.  One relatively minor comment below.

Do you want this addressed?  The problem is that I probably will also
need something like this flags argument for introducing the irq spreading
as we can't simply do it for all callers directly.  If you take
the patch as-is I'd be happy to do another pass later to remove it
and look into different no-MSI quirking once we're done with the
MSI-X spreading work.
