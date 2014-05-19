Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:25403 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932395AbaESRFz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 19 May 2014 13:05:55 -0400
Message-ID: <1400519151.3289.279.camel@ul30vt.home>
Subject: Re: [PATCH] PCI: Wrong register used to check pending traffic
From: Alex Williamson <alex.williamson@redhat.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com
Date: Mon, 19 May 2014 11:05:51 -0600
In-Reply-To: <1400468806-14884-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1400468806-14884-1-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2014-05-19 at 13:06 +1000, Gavin Shan wrote:
> The incorrect register offset is passed to pci_wait_for_pending(),
> which is caused by commit 157e876ffe ("PCI: Add pci_wait_for_pending()
> (refactor pci_wait_for_pending_transaction())").
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  drivers/pci/pci.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7325d43..759475e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3067,7 +3067,8 @@ int pci_wait_for_pending_transaction(struct pci_dev *dev)
>  	if (!pci_is_pcie(dev))
>  		return 1;
>  
> -	return pci_wait_for_pending(dev, PCI_EXP_DEVSTA, PCI_EXP_DEVSTA_TRPND);
> +	return pci_wait_for_pending(dev, pci_pcie_cap(dev) + PCI_EXP_DEVSTA,
> +				    PCI_EXP_DEVSTA_TRPND);
>  }
>  EXPORT_SYMBOL(pci_wait_for_pending_transaction);
>  
> @@ -3109,7 +3110,7 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
>  		return 0;
>  
>  	/* Wait for Transaction Pending bit clean */
> -	if (pci_wait_for_pending(dev, PCI_AF_STATUS, PCI_AF_STATUS_TP))
> +	if (pci_wait_for_pending(dev, pos + PCI_AF_STATUS, PCI_AF_STATUS_TP))
>  		goto clear;
>  
>  	dev_err(&dev->dev, "transaction is not cleared; "

Acked-by: Alex Williamson <alex.williamson@gmail.com>
Cc: <stable@vger.kernel.org> # v3.14+

