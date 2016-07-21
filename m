Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51462 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753954AbcGUVC1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 21 Jul 2016 17:02:27 -0400
Date: Thu, 21 Jul 2016 16:02:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-pci@vger.kernel.org, agordeev@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: resend: pci: automatic interrupt affinity for MSI/MSI-X capable
 devices V2
Message-ID: <20160721210223.GA11888@localhost>
References: <1469111423-16222-1-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1469111423-16222-1-git-send-email-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Christoph,

This thread looks like it might be a typo.  It doesn't use any of the
new PCI MSI stuff.  Looks like the cover letter from the PCI MSI
patches, but the actual patches are from a different series?

On Thu, Jul 21, 2016 at 04:30:20PM +0200, Christoph Hellwig wrote:
> This series adds a new set of functions that transparently use the right
> type of interrupt (MSI-X, MSI, legacy interrupt line) for a PCI device,
> and if multiple vectors are supported automatically spreads the irq
> routing to different CPUs.  This will allow the block layer (and hopefully
> other consumers in the future) to use this information for mapping
> queues to fit the interrupt affinity.
> 
> For the last patche to work you need to merge the irq/for-block branch of
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> 
> first.
> 
> There also is a git tree available at:
> 
>    git://git.infradead.org/users/hch/block.git pci-irq-spreading
> 
> Gitweb:
> 
>    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/pci-irq-spreading
> 
> Since the previous post of V2 I've only added the Reviewed-by: tags from
> Alexander.
> 
> Changes since V1
>  - change return values for the minmum vector check
>  - improve the documentation
> 
> Changes since automatic interrupt affinity for MSI/MSI-X capable devices V3:
>  - add PCI_IRQ_NOLEGACY flag
>  - various error code fixes
>  - reuse the pci_enable_msi(x)_range code instead of duplicating it
>  - don't allocate msix_entry structures for the MSI-X case
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
