Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:34332 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763882Ab3DDRTr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Apr 2013 13:19:47 -0400
Received: by mail-ob0-f172.google.com with SMTP id tb18so2825974obb.31
        for <linux-pci@vger.kernel.org>; Thu, 04 Apr 2013 10:19:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1365075572-20763-5-git-send-email-shangw@linux.vnet.ibm.com>
References: <1365075572-20763-1-git-send-email-shangw@linux.vnet.ibm.com> <1365075572-20763-5-git-send-email-shangw@linux.vnet.ibm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 4 Apr 2013 11:19:25 -0600
Message-ID: <CAErSpo6c8PGPPpz+=oxDoPAnUhPA5DADZYEcn_QTJeOZwSj3gg@mail.gmail.com>
Subject: Re: [PATCH 4/5] PCI: Use cached MSI cap in pci_enable_msi_block_auto()
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 4, 2013 at 5:39 AM, Gavin Shan <shangw@linux.vnet.ibm.com> wrote:
> The patch intends to use cached MSI capability offset instead of
> polling that from config space in pci_enable_msi_block_auto().
>
> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> ---
>  drivers/pci/msi.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 182474d..0b6b254 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -848,14 +848,13 @@ EXPORT_SYMBOL(pci_enable_msi_block);
>
>  int pci_enable_msi_block_auto(struct pci_dev *dev, unsigned int *maxvec)
>  {
> -       int ret, pos, nvec;
> +       int ret, nvec;
>         u16 msgctl;
>
> -       pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
> -       if (!pos)
> +       if (!dev->msi_cap)
>                 return -EINVAL;
>
> -       pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
> +       pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &msgctl);

I don't understand why this is in a separate patch.  Just add and
populate the cache, then replace all the pci_find_capability() calls
with a dev->msi_cap reference at once.

>         ret = 1 << ((msgctl & PCI_MSI_FLAGS_QMASK) >> 1);
>
>         if (maxvec)
> --
> 1.7.5.4
>
