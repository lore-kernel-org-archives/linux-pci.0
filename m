Return-Path: <hch@lst.de>
Return-Path: <hch@lst.de>
Date: Wed, 11 May 2016 10:52:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, agordeev@redhat.com, pjw@netapp.com,
	axboe@fb.com, keith.busch@intel.com, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] PCI: Provide sensible irq vector alloc/free
	routines
Message-ID: <20160511085222.GA20357@lst.de>
References: <1462457096-19795-1-git-send-email-hch@lst.de> <1462457096-19795-2-git-send-email-hch@lst.de> <20160509224631.GB18501@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160509224631.GB18501@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 09, 2016 at 05:46:31PM -0500, Bjorn Helgaas wrote:
> Thanks, I applied this to pci/msi for v4.7.  I'd be happy to apply the
> nvme change, too, given the appropriate acks.

Given the merge conflict that Keith pointed out I suspect it'll be better
to defer it until the next merge window.
