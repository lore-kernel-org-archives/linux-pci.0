Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:35094 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752916Ab3KFDjN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Nov 2013 22:39:13 -0500
Received: by mail-ie0-f177.google.com with SMTP id e14so16042061iej.8
        for <linux-pci@vger.kernel.org>; Tue, 05 Nov 2013 19:39:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20131105232903.3790.8738.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20131105232903.3790.8738.stgit@bhelgaas-glaptop.roam.corp.google.com>
Date: Tue, 5 Nov 2013 19:39:10 -0800
Message-ID: <CAE9FiQX74B32iD2LAaWxwOAH62YAFWkt2=hK9pVDCDUnfrEaNw@mail.gmail.com>
Subject: Re: [PATCH] PCI: Use pci_is_root_bus() to check for root bus
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 5, 2013 at 3:29 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> pci_enable_device_flags() and pci_enable_bridge() assume that
> "bus->self == NULL" means that "bus" is a root bus.  That assumption is
> false; see 2ba29e270e97 ("PCI: Use pci_is_root_bus() to check for root
> bus") for details.
>
> This patch changes them to use pci_is_root_bus() instead.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pci.c |    9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ac40f90..de65bf7 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1150,10 +1150,8 @@ static void pci_enable_bridge(struct pci_dev *dev)
>  {
>         int retval;
>
> -       if (!dev)
> -               return;
> -

May need to keep this checking.

virtual bus (for sriov virtual function) could have bus->self == NULL.

> -       pci_enable_bridge(dev->bus->self);
> +       if (!pci_is_root_bus(dev->bus))
> +               pci_enable_bridge(dev->bus->self);
>
>         if (pci_is_enabled(dev)) {
>                 if (!dev->is_busmaster)
> @@ -1188,7 +1186,8 @@ static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
>         if (atomic_inc_return(&dev->enable_cnt) > 1)
>                 return 0;               /* already enabled */
>
> -       pci_enable_bridge(dev->bus->self);
> +       if (!pci_is_root_bus(dev->bus))
> +               pci_enable_bridge(dev->bus->self);
>
>         /* only skip sriov related */
>         for (i = 0; i <= PCI_ROM_RESOURCE; i++)
>
