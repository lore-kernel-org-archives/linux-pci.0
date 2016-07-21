Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52280 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754288AbcGUVGr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 21 Jul 2016 17:06:47 -0400
Date: Thu, 21 Jul 2016 16:06:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-pci@vger.kernel.org, agordeev@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: pci: automatic interrupt affinity for MSI/MSI-X capable devices
 V2
Message-ID: <20160721210642.GB11888@localhost>
References: <1468315218-20490-1-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1468315218-20490-1-git-send-email-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 12, 2016 at 06:20:13PM +0900, Christoph Hellwig wrote:
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
> Changes since V1
>  - change return values for the minmum vector check
>  - improve the documentation
> 
> Changes since automatic interrupt affinity for MSI/MSI-X capable devices V3:
>  - add PCI_IRQ_NOLEGACY flag
>  - various error code fixes
>  - reuse the pci_enable_msi(x)_range code instead of duplicating it
>  - don't allocate msix_entry structures for the MSI-X case

I merged the irq/for-block branch, applied this series, and added
Alexander's Reviewed-by to the patches that didn't have it already.

As far as the if/return/else construct:

  if (x)
    return y;
  else if (z)
    ...

I removed the "else" in the other occurrences so the style is
consistently:

  if (x)
    return y;
  if (z)
    ...

This is all on my pci/msi-affinity branch for v4.8.

Thanks for all the work; I think this is a very nice change, and it's
great that all the documentation is updated as well.

Bjorn
