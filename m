Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:53720 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763285Ab3DDQd5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Apr 2013 12:33:57 -0400
Received: by mail-ob0-f176.google.com with SMTP id er7so2737754obc.35
        for <linux-pci@vger.kernel.org>; Thu, 04 Apr 2013 09:33:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1365075572-20763-3-git-send-email-shangw@linux.vnet.ibm.com>
References: <1365075572-20763-1-git-send-email-shangw@linux.vnet.ibm.com> <1365075572-20763-3-git-send-email-shangw@linux.vnet.ibm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 4 Apr 2013 10:33:36 -0600
Message-ID: <CAErSpo43ZT05aO-H14AN6DTg3-Qw21fHv37Qb-KTZFPO4Q3bMQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] PCI: Use MSI/MSI-X cap cache in pci_msi_check_device()
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 4, 2013 at 5:39 AM, Gavin Shan <shangw@linux.vnet.ibm.com> wrote:
> The function pci_msi_check_device() is called while enabling MSI
> or MSI-X interrupts to make sure the PCI device can support MSI
> or MSI-X capability. The patch changes the function for a bit to
> use the cached MSI or MSI-X capability in pci_dev instead of polling
> them from config space.
>
> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> ---
>  drivers/pci/msi.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 3459bdf..5f51e10 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -772,6 +772,11 @@ static int pci_msi_check_device(struct pci_dev *dev, int nvec, int type)
>         if (!pci_msi_enable || !dev || dev->no_msi)
>                 return -EINVAL;
>
> +       /* Check if the PCI device has MSI or MSI-X capability */
> +       if ((type == PCI_CAP_ID_MSI && !dev->msi_cap) ||
> +           (type == PCI_CAP_ID_MSIX && !dev->msix_cap))
> +               return -EINVAL;

The whole point of this is simplification, so just add "if
(!dev->msi_cap) return -EINVAL" (or "if (!dev->msix_cap)") to the
callers and drop the checking here in pci_msi_check_device().

> +
>         /*
>          * You can't ask to have 0 or less MSIs configured.
>          *  a) it's stupid ..
> @@ -795,9 +800,6 @@ static int pci_msi_check_device(struct pci_dev *dev, int nvec, int type)
>         if (ret)
>                 return ret;
>
> -       if (!pci_find_capability(dev, type))
> -               return -EINVAL;
> -
>         return 0;
>  }
>
> --
> 1.7.5.4
>
