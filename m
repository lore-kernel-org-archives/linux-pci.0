Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:45791 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753621AbcFAH57 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jun 2016 03:57:59 -0400
Date: Wed, 1 Jun 2016 00:57:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] PCI: Add helpers to request/release memory and I/O
 regions
Message-ID: <20160601075757.GA11923@infradead.org>
References: <cover.1464694724.git.jthumshirn@suse.de>
 <a068e858f5e115ebb3a841e4564aec8523a154f6.1464694724.git.jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a068e858f5e115ebb3a841e4564aec8523a154f6.1464694724.git.jthumshirn@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 31, 2016 at 02:05:09PM +0200, Johannes Thumshirn wrote:
> Add helpers to request and release a device's memory or I/O regions.
> 
> With these helpers in place, one does not need to select a device's memory or
> I/O regions with pci_select_bars() prior to requesting or releasing them.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  include/linux/pci.h | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 932ec74..846f4cf 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2007,6 +2007,35 @@ static inline bool pci_is_dev_assigned(struct pci_dev *pdev)
>  	return (pdev->dev_flags & PCI_DEV_FLAGS_ASSIGNED) == PCI_DEV_FLAGS_ASSIGNED;
>  }
>  
> +static inline int
> +pci_request_io_regions(struct pci_dev *pdev, const char *name)
> +{
> +	return pci_request_selected_regions(pdev,
> +					    pci_select_bars(pdev, IORESOURCE_IO), name);

Needs a little indentation tweak to not spill over 80 characters.  Two
tabs should be plenty indentation for the continuation of function
arguments.  Ditto for the other functions,

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
