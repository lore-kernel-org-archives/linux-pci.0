Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727052AbeIRAnr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Sep 2018 20:43:47 -0400
Date: Mon, 17 Sep 2018 14:15:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Cc: linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: kernel panic becase pci register more than once
Message-ID: <20180917191503.GA54859@bhelgaas-glaptop.roam.corp.google.com>
References: <CAMDZJNV6D_NCn5_n2DAnPH25DONAKRcc-GWwGbCXX098E+EJ1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMDZJNV6D_NCn5_n2DAnPH25DONAKRcc-GWwGbCXX098E+EJ1Q@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Christoph]

On Sun, Sep 09, 2018 at 04:26:37PM +0800, Tonghao Zhang wrote:
> Hi all,
> When I enable pci msi or msix more than once, the kernel will panic.
> Now we just use the WARN_ON, should we add check for that has been
> enabled.
> 

This needs a signed-off-by before I can apply it.  See
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n416

A WARN_ON() shouldn't cause the kernel to panic.  Do you mean that it
causes a backtrace?  I think that's the intended behavior, because
calling this twice would be a driver bug, and we want to find and fix
those bugs.

> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index f2ef896..324840f 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -958,7 +958,9 @@ static int __pci_enable_msix(struct pci_dev *dev,
> struct msix_entry *entries,
>                         }
>                 }
>         }
> -       WARN_ON(!!dev->msix_enabled);
> +
> +       if (dev->msix_enabled)
> +               return -EINVAL;
> 
>         /* Check whether driver already requested for MSI irq */
>         if (dev->msi_enabled) {
> @@ -1028,7 +1030,8 @@ static int __pci_enable_msi_range(struct pci_dev
> *dev, int minvec, int maxvec,
>         if (!pci_msi_supported(dev, minvec))
>                 return -EINVAL;
> 
> -       WARN_ON(!!dev->msi_enabled);
> +       if (dev->msi_enabled)
> +               return -EINVAL;
> 
>         /* Check whether driver already requested MSI-X irqs */
>         if (dev->msix_enabled) {
