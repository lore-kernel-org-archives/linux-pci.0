Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:52334 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709Ab3KGA2t (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Nov 2013 19:28:49 -0500
Received: by mail-ie0-f170.google.com with SMTP id at1so483727iec.29
        for <linux-pci@vger.kernel.org>; Wed, 06 Nov 2013 16:28:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20131106204603.GA17046@google.com>
References: <20131105232903.3790.8738.stgit@bhelgaas-glaptop.roam.corp.google.com>
	<CAE9FiQX74B32iD2LAaWxwOAH62YAFWkt2=hK9pVDCDUnfrEaNw@mail.gmail.com>
	<20131106181558.GA14444@google.com>
	<CAE9FiQU4V0waWNvMFgEjKv90KuCCQ2CYJU2UsnDP0+WDS9zb1Q@mail.gmail.com>
	<20131106201239.GA8971@google.com>
	<CAE9FiQWxGdiRjZSt8OhVkJAGJ3p4zZ+Tza9HFiKtZZSa01kztA@mail.gmail.com>
	<20131106204603.GA17046@google.com>
Date: Wed, 6 Nov 2013 16:28:48 -0800
Message-ID: <CAE9FiQX8Let2TzMwq1qmDhV65RZ68triZZAhGEuAVzL2suzy1g@mail.gmail.com>
Subject: Re: [PATCH] PCI: Use pci_is_root_bus() to check for root bus
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	Nishank Trivedi <nistrive@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 6, 2013 at 12:46 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:

> Oh, I see.  The problem is when VF is on a virtual bus and the
> corresponding PF is on a root bus.  Then we have:
>
>   pci_is_root_bus(VF) == false
>   pci_upstream_bridge(VF) == pci_upstream_bridge(PF)
>   pci_uptream_bridge(PF) == NULL
>
> I guess that's what your suggestion about "caching the return from
> pci_upstream_bridge()" was about.  Like this:

Yes.

For the two patches,

Acked-by: Yinghai Lu <yinghai@kernel.org>

>
>
> commit 21ea57bf1311f7a8d1b755d355322a1f077fccb7
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Wed Nov 6 10:11:48 2013 -0700
>
>     PCI: Add pci_upstream_bridge()
>
>     This adds a pci_upstream_bridge() interface to find the PCI-to-PCI bridge
>     upstream from a device.  This is typically just "dev->bus->self", but in
>     the case of a VF on a virtual bus, we have to start from the corresponding
>     PF.  Returns NULL if there is no upstream PCI bridge, i.e., if the device
>     is on a root bus.
>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d3a888a..835ec7b 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -480,6 +480,15 @@ static inline bool pci_is_root_bus(struct pci_bus *pbus)
>         return !(pbus->parent);
>  }
>
> +static inline struct pci_dev *pci_upstream_bridge(struct pci_dev *dev)
> +{
> +       dev = pci_physfn(dev);
> +       if (pci_is_root_bus(dev->bus))
> +               return NULL;
> +
> +       return dev->bus->self;
> +}
> +
>  #ifdef CONFIG_PCI_MSI
>  static inline bool pci_dev_msi_enabled(struct pci_dev *pci_dev)
>  {
> commit bca690ab580d5c0c4a0c7201f3c42057288add8b
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Wed Nov 6 10:00:51 2013 -0700
>
>     PCI: Enable upstream bridges even for VFs on virtual buses
>
>     Previously we enabled the upstream PCI-to-PCI bridge only when
>     "dev->bus->self != NULL".  In the case of a VF on a virtual bus, where
>     "bus->self == NULL", we didn't enable the upstream bridge.
>
>     This fixes that by enabling the upstream bridge of the PF corresponding to
>     the VF.
>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ac40f90..d3ed931 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1148,12 +1148,12 @@ int pci_reenable_device(struct pci_dev *dev)
>
>  static void pci_enable_bridge(struct pci_dev *dev)
>  {
> +       struct pci_dev *bridge;
>         int retval;
>
> -       if (!dev)
> -               return;
> -
> -       pci_enable_bridge(dev->bus->self);
> +       bridge = pci_upstream_bridge(dev);
> +       if (bridge)
> +               pci_enable_bridge(bridge);
>
>         if (pci_is_enabled(dev)) {
>                 if (!dev->is_busmaster)
> @@ -1170,6 +1170,7 @@ static void pci_enable_bridge(struct pci_dev *dev)
>
>  static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
>  {
> +       struct pci_dev *bridge;
>         int err;
>         int i, bars = 0;
>
> @@ -1188,7 +1189,9 @@ static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
>         if (atomic_inc_return(&dev->enable_cnt) > 1)
>                 return 0;               /* already enabled */
>
> -       pci_enable_bridge(dev->bus->self);
> +       bridge = pci_upstream_bridge(dev);
> +       if (bridge)
> +               pci_enable_bridge(bridge);
>
>         /* only skip sriov related */
>         for (i = 0; i <= PCI_ROM_RESOURCE; i++)
