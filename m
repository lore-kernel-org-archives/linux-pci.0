Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:34527 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933471AbcJQUvr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Oct 2016 16:51:47 -0400
MIME-Version: 1.0
In-Reply-To: <20161017192858.GA25429@lst.de>
References: <CA+i8gKJ1BnOE8tOzxfbFJcG1qa9XchiDBQSGZUHUOch6byi+tQ@mail.gmail.com>
 <20161017080103.GA8732@lst.de> <CA+i8gK+dxqJgAcANzsHecE4dD4tGARuaNka-29nZWdrRUL=+Hw@mail.gmail.com>
 <20161017092621.GA11124@lst.de> <CA+i8gKK55YWL0SsB0UL89TL1XAgySvFwhmU=c+fTpkGo_s4XTA@mail.gmail.com>
 <20161017103442.GA12240@lst.de> <CA+i8gKJkhTjBAPbuceToHD3YJuPHkLhs-joso-vuJzuHRF5OLg@mail.gmail.com>
 <20161017120234.GA14105@lst.de> <CA+i8gK+UfUmKtYpXH1cObd3_5WWje397pgQqW5SmwFg8ms+aLw@mail.gmail.com>
 <20161017192858.GA25429@lst.de>
From: Emmanuel Benisty <benisty.e@gmail.com>
Date: Mon, 17 Oct 2016 22:51:44 +0200
Message-ID: <CA+i8gKJ6dyxHm-5_=Xdm=HusyxsHVbqTphGzMp1zBTMut=yygQ@mail.gmail.com>
Subject: Re: use pci_alloc_irq_vectors issues
To: Christoph Hellwig <hch@lst.de>
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Christoph,

On Mon, Oct 17, 2016 at 9:28 PM, Christoph Hellwig <hch@lst.de> wrote:
> I think I have an idea now - we are accidentally hitting the per-port
> MSI vector case because your SSD only has one AHCI "port".  Can you
> try the below patch:
>
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index ba5f11c..3c2f92b 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1413,6 +1413,7 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
>         if (hpriv->flags & AHCI_HFLAG_NO_MSI)
>                 return -ENODEV;
>
> +       if (n_ports > 1) {
>         /*
>          * If number of MSIs is less than number of ports then Sharing Last
>          * Message mode could be enforced. In this case assume that advantage
> @@ -1434,6 +1435,7 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
>                 printk(KERN_INFO "ahci: MRSM is on, fallback to single MSI\n");
>                 pci_free_irq_vectors(pdev);
>         }
> +       }
>
>         /*
>          * -ENOSPC indicated we don't have enough vectors.  Don't bother trying

This patch solved the issue, thanks a lot.

Cheers.
