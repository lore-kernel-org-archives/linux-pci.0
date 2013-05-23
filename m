Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:44087 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758979Ab3EWUpT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 May 2013 16:45:19 -0400
Received: by mail-ob0-f181.google.com with SMTP id dn14so4555672obc.26
        for <linux-pci@vger.kernel.org>; Thu, 23 May 2013 13:45:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130510211845.32592.77464.stgit@bling.home>
References: <20130510210937.32592.21950.stgit@bling.home> <20130510211845.32592.77464.stgit@bling.home>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 23 May 2013 14:44:58 -0600
Message-ID: <CAErSpo5Z_GefXUD+Ts=beVurU9ZnLghN=Qkj7V0ZSjn-=zNsag@mail.gmail.com>
Subject: Re: [PATCH 1/3] pci: Add PCI walk function and PCIe bridge test
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Don Dutile <ddutile@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 10, 2013 at 3:18 PM, Alex Williamson
<alex.williamson@redhat.com> wrote:
> These will replace pci_find_upstream_pcie_bridge, which is difficult
> to use and rather specific to intel-iommu usage.  A quirked
> pci_is_pcie_bridge function is provided to work around non-compliant
> PCIe-to-PCI bridges such as those found in
> https://bugzilla.kernel.org/show_bug.cgi?id=44881
>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  drivers/pci/search.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h  |   23 ++++++++++++++++++++
>  2 files changed, 80 insertions(+)
>
> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> index d0627fa..0357f74 100644
> --- a/drivers/pci/search.c
> +++ b/drivers/pci/search.c
> @@ -17,6 +17,63 @@
>  DECLARE_RWSEM(pci_bus_sem);
>  EXPORT_SYMBOL_GPL(pci_bus_sem);
>
> +/* Test for PCIe bridges. */
> +bool pci_is_pcie_bridge(struct pci_dev *pdev)
> +{
> +       if (!pci_is_bridge(pdev))
> +               return false;
> +
> +       if (pci_is_pcie(pdev))
> +               return true;
> +
> +#ifdef CONFIG_PCI_QUIRKS
> +       /*
> +        * If we're not on the root bus, look one device upstream of the
> +        * current device.  If that device is PCIe and is not a PCIe-to-PCI
> +        * bridge, then the current device is effectively PCIe as it must
> +        * be the PCIe-to-PCI bridge.  This handles several bridges that
> +        * violate the PCIe spec by not exposing a PCIe capability:
> +        * https://bugzilla.kernel.org/show_bug.cgi?id=44881
> +        */
> +       if (!pci_is_root_bus(pdev->bus)) {
> +               struct pci_dev *parent = pdev->bus->self;
> +
> +               if (pci_is_pcie(parent) &&
> +                   pci_pcie_type(parent) != PCI_EXP_TYPE_PCI_BRIDGE)
> +
> +                       return true;
> +       }
> +#endif
> +       return false;
> +}

I like this strategy.  But I'd rather it not be a general-purpose PCI
interface, because if pci_is_pcie_bridge() is true, people will assume
they can perform PCIe operations on the device, and they can't.  The
only use for this is to figure out the source ID the IOMMU will see,
so I think this should just go in the IOMMU code.

> +/*
> + * Walk upstream from the given pdev for the first device returning
> + * true for the provided match function.  If no match is found, return
> + * NULL.  *last records the previous step in the walk.
> + */
> +struct pci_dev *pci_walk_up_to_first_match(struct pci_dev *pdev,
> +                                          bool (*match)(struct pci_dev *),
> +                                          struct pci_dev **last)
> +{
> +       *last = NULL;
> +
> +       if (match(pdev))
> +               return pdev;
> +
> +       *last = pdev;
> +
> +       while (!pci_is_root_bus(pdev->bus)) {
> +               *last = pdev;
> +               pdev = pdev->bus->self;
> +
> +               if (match(pdev))
> +                       return pdev;
> +       }
> +
> +       return NULL;
> +}

Same here.  I don't really see much potential for other uses of this,
so it seems like you might as well just put this in the IOMMU code and
make it call pci_is_pcie_bridge() directly.

The "source ID == upstream PCIe bridge" mapping is deeply ingrained in
your skull, but I think it would make the intent of the code clearer
if the function names mentioned the source ID somehow.  Otherwise new
readers like me have to come up with that association on our own.  But
since I'm proposing putting all this in the IOMMU code, it's totally
up to you :)

Bjorn

> +
>  /*
>   * find the upstream PCIe-to-PCI bridge of a PCI device
>   * if the device is PCIE, return NULL
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index bd8ec30..e87423a 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1855,6 +1855,29 @@ static inline struct eeh_dev *pci_dev_to_eeh_dev(struct pci_dev *pdev)
>  #endif
>
>  /**
> + * pci_walk_up_to_first_match - Generic upstream search function
> + * @pdev: starting PCI device to search
> + * @match: match function to call on each device (true = match)
> + * @last: last device examined prior to returned device
> + *
> + * Walk upstream from the given device, calling match() at each device.
> + * Returns the first device matching match().  If the root bus is reached
> + * without finding a match, return NULL.  last returns the N-1 step in
> + * the search path.
> + */
> +struct pci_dev *pci_walk_up_to_first_match(struct pci_dev *pdev,
> +                                          bool (*match)(struct pci_dev *),
> +                                          struct pci_dev **last);
> +
> +/**
> + * pci_is_pcie_bridge - Match a PCIe bridge device
> + * @pdev: device to test
> + *
> + * Return true if the given device is a PCIe bridge, false otherwise.
> + */
> +bool pci_is_pcie_bridge(struct pci_dev *pdev);
> +
> +/**
>   * pci_find_upstream_pcie_bridge - find upstream PCIe-to-PCI bridge of a device
>   * @pdev: the PCI device
>   *
>
