Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37211 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751279AbcGLMyQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Jul 2016 08:54:16 -0400
Date: Tue, 12 Jul 2016 14:59:13 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] pci: switch msix_program_entries to use
 pci_msix_desc_addr
Message-ID: <20160712125913.GE26969@agordeev.lab.eng.brq.redhat.com>
References: <1468315218-20490-1-git-send-email-hch@lst.de>
 <1468315218-20490-3-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1468315218-20490-3-git-send-email-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 12, 2016 at 06:20:15PM +0900, Christoph Hellwig wrote:
> Instead of relying on the msix_entry structure for the vector number read
> it from the msi_desc.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/pci/msi.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 0d94fbf..a385f39 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -713,11 +713,9 @@ static void msix_program_entries(struct pci_dev *dev,
>  	int i = 0;
>  
>  	for_each_pci_msi_entry(entry, dev) {
> -		int offset = entries[i].entry * PCI_MSIX_ENTRY_SIZE +
> -						PCI_MSIX_ENTRY_VECTOR_CTRL;
> -
>  		entries[i].vector = entry->irq;
> -		entry->masked = readl(entry->mask_base + offset);
> +		entry->masked = readl(pci_msix_desc_addr(entry) +
> +				PCI_MSIX_ENTRY_VECTOR_CTRL);
>  		msix_mask_irq(entry, 1);
>  		i++;
>  	}
> -- 
> 2.1.4
> 
Reviewed-by: Alexander Gordeev <agordeev@redhat.com>
