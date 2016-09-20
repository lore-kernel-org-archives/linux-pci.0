Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751124AbcITTqT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Sep 2016 15:46:19 -0400
Date: Tue, 20 Sep 2016 14:46:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: agordeev@redhat.com, linux-pci@vger.kernel.org,
        davem@davemloft.net, shane.huang@amd.com
Subject: Re: [PATCH, RFC] PCI: use pci_intx_for_msi in pci_alloc_irq_vectors
Message-ID: <20160920194614.GE4941@localhost>
References: <1473577767-9888-1-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473577767-9888-1-git-send-email-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Christoph,

On Sun, Sep 11, 2016 at 09:09:27AM +0200, Christoph Hellwig wrote:
> Alex pointed out that we might want to use pci_intx_for_msi in
> pci_alloc_irq_vectors for the case where allocating MSI or MSI-X vectors
> fails completely.  I tried to read up the history behind pci_intx_for_msi,
> but the changelogs seem a bit confusing, e.g. the comment in the tg3
> around that code that was replaced by this quirk only talk about
> _disabling_ INT-X.  Maybe someone can help me to shed some light about
> this workaround, and help answering the question wether we need it
> in this case.

If we want to do this, I'd like to have a changelog that explains
*why*, so I'm ignoring it for now.  I'm not nacking it; I just don't
understand why we should do it yet, and I'm too lazy to do all the
research myself.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Cc: David Miller <davem@davemloft.net>
> Cc: Shane Huang <shane.huang@amd.com>
> ---
>  drivers/pci/msi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 9da5ecb..a4b443f 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1215,7 +1215,7 @@ int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
>  
>  	/* use legacy irq if allowed */
>  	if ((flags & PCI_IRQ_LEGACY) && min_vecs == 1) {
> -		pci_intx(dev, 1);
> +		pci_intx_for_msi(dev, 1);
>  		return 1;
>  	}
>  
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
