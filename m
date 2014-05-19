Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:50368 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbaESTKK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 19 May 2014 15:10:10 -0400
Received: by mail-ig0-f181.google.com with SMTP id h3so3954424igd.8
        for <linux-pci@vger.kernel.org>; Mon, 19 May 2014 12:10:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1400468806-14884-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1400468806-14884-1-git-send-email-gwshan@linux.vnet.ibm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 19 May 2014 13:09:49 -0600
Message-ID: <CAErSpo6ORiJzEnwN+rmCsEZCzAMtqmh5YwT47JgfL88GUvr=fA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Wrong register used to check pending traffic
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 19, 2014 at 01:06:46PM +1000, Gavin Shan wrote:
> The incorrect register offset is passed to pci_wait_for_pending(),
> which is caused by commit 157e876ffe ("PCI: Add pci_wait_for_pending()
> (refactor pci_wait_for_pending_transaction())").
>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied with Alex's ack and stable cc to my for-linux branch for v3.15,
thanks!

> ---
>  drivers/pci/pci.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7325d43..759475e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3067,7 +3067,8 @@ int pci_wait_for_pending_transaction(struct pci_dev *dev)
>   if (!pci_is_pcie(dev))
>   return 1;
>
> - return pci_wait_for_pending(dev, PCI_EXP_DEVSTA, PCI_EXP_DEVSTA_TRPND);
> + return pci_wait_for_pending(dev, pci_pcie_cap(dev) + PCI_EXP_DEVSTA,
> +    PCI_EXP_DEVSTA_TRPND);
>  }
>  EXPORT_SYMBOL(pci_wait_for_pending_transaction);
>
> @@ -3109,7 +3110,7 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
>   return 0;
>
>   /* Wait for Transaction Pending bit clean */
> - if (pci_wait_for_pending(dev, PCI_AF_STATUS, PCI_AF_STATUS_TP))
> + if (pci_wait_for_pending(dev, pos + PCI_AF_STATUS, PCI_AF_STATUS_TP))
>   goto clear;
>
>   dev_err(&dev->dev, "transaction is not cleared; "
> --
> 1.8.3.2
>
