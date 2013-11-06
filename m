Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:54382 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042Ab3KFT4N (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Nov 2013 14:56:13 -0500
Received: by mail-ie0-f179.google.com with SMTP id aq17so17700971iec.24
        for <linux-pci@vger.kernel.org>; Wed, 06 Nov 2013 11:56:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20131106181558.GA14444@google.com>
References: <20131105232903.3790.8738.stgit@bhelgaas-glaptop.roam.corp.google.com>
	<CAE9FiQX74B32iD2LAaWxwOAH62YAFWkt2=hK9pVDCDUnfrEaNw@mail.gmail.com>
	<20131106181558.GA14444@google.com>
Date: Wed, 6 Nov 2013 11:56:13 -0800
Message-ID: <CAE9FiQU4V0waWNvMFgEjKv90KuCCQ2CYJU2UsnDP0+WDS9zb1Q@mail.gmail.com>
Subject: Re: [PATCH] PCI: Use pci_is_root_bus() to check for root bus
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	Nishank Trivedi <nistrive@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 6, 2013 at 10:15 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:

> commit dfb66fee4715c747a94abd45c20fbe302b10e49c
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Wed Nov 6 10:11:48 2013 -0700
>
>     PCI: Add pci_upstream_bridge()
>
>     This adds a pci_upstream_bridge() interface to find the PCI-to-PCI bridge
>     upstream from a device.  If the device is on a root bus, i.e., the upstream
>     bridge is a host bridge instead of a PCI bridge, this returns NULL.  If the
>     device is a VF, this returns the bridge upstream from the PF corresponding
>     to the VF.  This is important for VFs on virtual buses, where
>     "dev->bus->self == NULL".
>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d3a888a..e09d19a 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -480,6 +480,18 @@ static inline bool pci_is_root_bus(struct pci_bus *pbus)
>         return !(pbus->parent);
>  }
>
> +static inline struct pci_dev *pci_upstream_bridge(struct pci_dev *dev)
> +{
> +       if (pci_is_root_bus(dev->bus))
> +               return NULL;
> +
> +       dev = pci_physfn(dev);
> +       if (pci_is_root_bus(dev->bus))
> +               return NULL;

Maybe we can drop the first pci_is_root_bus() checking.
for physfn, pci_physfn will return it's self.

> +
> +       return dev->bus->self;
> +}
> +
>  #ifdef CONFIG_PCI_MSI
>  static inline bool pci_dev_msi_enabled(struct pci_dev *pci_dev)
>  {
> commit 4e5415f02e32c85e902cd9692eab18200e14b347
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
> index ac40f90..744dc26 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1150,10 +1150,8 @@ static void pci_enable_bridge(struct pci_dev *dev)
>  {
>         int retval;
>
> -       if (!dev)
> -               return;
> -
> -       pci_enable_bridge(dev->bus->self);
> +       if (!pci_is_root_bus(dev->bus))
> +               pci_enable_bridge(pci_upstream_bridge(dev));
>
>         if (pci_is_enabled(dev)) {
>                 if (!dev->is_busmaster)
> @@ -1188,7 +1186,8 @@ static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
>         if (atomic_inc_return(&dev->enable_cnt) > 1)
>                 return 0;               /* already enabled */
>
> -       pci_enable_bridge(dev->bus->self);
> +       if (!pci_is_root_bus(dev->bus))
> +               pci_enable_bridge(pci_upstream_bridge(dev));
>
>         /* only skip sriov related */
>         for (i = 0; i <= PCI_ROM_RESOURCE; i++)

still have problem.

pci_upstream_bridge() could return NULL. so later pci_enable_bridge()
referring dev->bus could panic, as you remove !dev checking.

Maybe you can cache return from pci_upstream_bridge and check that before
calling pci_enable_bridge.

Thanks

Yinghai
