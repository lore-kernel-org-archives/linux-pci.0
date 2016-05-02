Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50586 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752957AbcEBNLd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 2 May 2016 09:11:33 -0400
Date: Mon, 2 May 2016 08:11:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: tglx@linutronix.de, linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH 6/8] pci: provide sensible irq vector alloc/free routines
Message-ID: <20160502131124.GA18527@localhost>
References: <1460770552-31260-1-git-send-email-hch@lst.de>
 <1460770552-31260-7-git-send-email-hch@lst.de>
 <20160429211638.GB28261@localhost>
 <20160501180149.GA11131@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160501180149.GA11131@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, May 01, 2016 at 08:01:49PM +0200, Christoph Hellwig wrote:
> FYI, I spent some time trying to convert more drivers to this, and
> I think we'll need an additional flag to skip MSI or MSI-X as there
> is plenty of hardware claiming support in the capabilities flag,
> but not actually supporting one of them.

Or maybe add a "pdev->msix_broken" bit and quirks to set it?  Or if
pci_fixup_final quirks merely cleared pdev->msix_cap, I think the PCI
core would never try to enable MSI-X.
