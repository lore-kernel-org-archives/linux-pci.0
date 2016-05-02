Return-Path: <hch@lst.de>
Return-Path: <hch@lst.de>
Date: Mon, 2 May 2016 16:42:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, tglx@linutronix.de,
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH 6/8] pci: provide sensible irq vector alloc/free
	routines
Message-ID: <20160502144203.GA32221@lst.de>
References: <1460770552-31260-1-git-send-email-hch@lst.de> <1460770552-31260-7-git-send-email-hch@lst.de> <20160429211638.GB28261@localhost> <20160501180149.GA11131@lst.de> <20160502131124.GA18527@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160502131124.GA18527@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 02, 2016 at 08:11:24AM -0500, Bjorn Helgaas wrote:
> On Sun, May 01, 2016 at 08:01:49PM +0200, Christoph Hellwig wrote:
> > FYI, I spent some time trying to convert more drivers to this, and
> > I think we'll need an additional flag to skip MSI or MSI-X as there
> > is plenty of hardware claiming support in the capabilities flag,
> > but not actually supporting one of them.
> 
> Or maybe add a "pdev->msix_broken" bit and quirks to set it?  Or if
> pci_fixup_final quirks merely cleared pdev->msix_cap, I think the PCI
> core would never try to enable MSI-X.

Can't say I'm excited about quirks - now we'd have to patch core
code for something that previously was entirely in the driver.
