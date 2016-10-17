Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:33224 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755088AbcJQMsL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Oct 2016 08:48:11 -0400
MIME-Version: 1.0
In-Reply-To: <20161017120234.GA14105@lst.de>
References: <CA+i8gKJ1BnOE8tOzxfbFJcG1qa9XchiDBQSGZUHUOch6byi+tQ@mail.gmail.com>
 <20161017080103.GA8732@lst.de> <CA+i8gK+dxqJgAcANzsHecE4dD4tGARuaNka-29nZWdrRUL=+Hw@mail.gmail.com>
 <20161017092621.GA11124@lst.de> <CA+i8gKK55YWL0SsB0UL89TL1XAgySvFwhmU=c+fTpkGo_s4XTA@mail.gmail.com>
 <20161017103442.GA12240@lst.de> <CA+i8gKJkhTjBAPbuceToHD3YJuPHkLhs-joso-vuJzuHRF5OLg@mail.gmail.com>
 <20161017120234.GA14105@lst.de>
From: Emmanuel Benisty <benisty.e@gmail.com>
Date: Mon, 17 Oct 2016 14:48:08 +0200
Message-ID: <CA+i8gK+UfUmKtYpXH1cObd3_5WWje397pgQqW5SmwFg8ms+aLw@mail.gmail.com>
Subject: Re: use pci_alloc_irq_vectors issues
To: Christoph Hellwig <hch@lst.de>
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 17, 2016 at 2:02 PM, Christoph Hellwig <hch@lst.de> wrote:
> Thanks a lot!  I think the current check on when to fall back from
> the multi-MSI to the single-MSI case is too narrow and we should
> just always fall back.
>
> Can you see if the patch below fixes your issue (revert the debug patch
> first, please)?
>
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index ba5f11c..b4b8004 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1436,13 +1436,6 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
>         }
>
>         /*
> -        * -ENOSPC indicated we don't have enough vectors.  Don't bother trying
> -        * a single vectors for any other error:
> -        */
> -       if (nvec < 0 && nvec != -ENOSPC)
> -               return nvec;
> -
> -       /*
>          * If the host is not capable of supporting per-port vectors, fall
>          * back to single MSI before finally attempting single MSI-X.
>          */

Sorry Christoph, issue is still there:

http://i.imgur.com/smDjT0y.jpg
http://i.imgur.com/VV4FGI1.jpg
http://i.imgur.com/Xqdayvj.jpg

Thanks
