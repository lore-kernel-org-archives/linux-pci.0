Return-Path: <BATV+ebca6d033c7666f223e0+4638+infradead.org+hch@bombadil.srs.infradead.org>
Return-Path: <BATV+ebca6d033c7666f223e0+4638+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: helgaas@kernel.org
Cc: agordeev@redhat.com,
	pjw@netapp.com,
	axboe@fb.com,
	keith.busch@intel.com,
	linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: PCI: Provide sensible irq vector alloc/free routines
Date: Thu,  5 May 2016 16:04:54 +0200
Message-Id: <1462457096-19795-1-git-send-email-hch@lst.de>
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

find my revisted patch for the MSI-X allocator API.  There has been
some rework to use lower level APIs now that it has been moved to
msi.c.  The second patch converts nvme over to it.  If Keith and Jens
are fine with merging it through the PCI tree I'd be all for it,
if not we'll either need a common branch for it, or just defer it
until the next merge window.
