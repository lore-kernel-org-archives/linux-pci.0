Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:57425 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752980AbbAWWeh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jan 2015 17:34:37 -0500
Received: by mail-ob0-f170.google.com with SMTP id wp4so72218obc.1
        for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2015 14:34:36 -0800 (PST)
Date: Fri, 23 Jan 2015 16:34:24 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/2] PCI: add helper function to find root port for
 device
Message-ID: <20150123223424.GN29776@google.com>
References: <1421179048-25370-1-git-send-email-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421179048-25370-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 13, 2015 at 08:57:27PM +0100, Lucas Stach wrote:
> This adds a simple way to get the root port a given device
> is connected to.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
> v2: new patch in v2
> v3: rename to pci_find_rootport to fit better with other API
> ---
>  drivers/pci/search.c | 20 ++++++++++++++++++++
>  include/linux/pci.h  |  1 +
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> index a20ce7d5e2a7..7254f126096d 100644
> --- a/drivers/pci/search.c
> +++ b/drivers/pci/search.c
> @@ -384,3 +384,23 @@ int pci_dev_present(const struct pci_device_id *ids)
>  	return 0;
>  }
>  EXPORT_SYMBOL(pci_dev_present);
> +
> +/**
> + * pci_find_root_port - Returns the root port the given device is connected to.
> + * @dev: PCI device for which the root port should be found.
> + */
> +struct pci_dev *pci_find_root_port(struct pci_dev *dev)

This seems a little too generic.  There are still PCI (non-PCIe) systems,
and on those this will return some non-Root Port device, the meaning of
which is unclear.  I'm happy to put something like this in pci-tegra.c, but
until there are other potential users and we sort out the PCI/PCIe-ness of
the interface, I don't really want to make it global and exported.

> +{
> +	struct pci_bus *bus = dev->bus;
> +
> +	/* If there is no bridge on the bus the passed device is a root port. */

This assumption is false -- see the comment at pci_is_root_bus().

> +	if (!bus->self)
> +		return dev;
> +
> +	/* Walk up the PCI hierarchy to the first level below the root. */
> +	while (bus->parent && bus->parent->self)
> +		bus = bus->parent;
> +
> +	return bus->self;
> +}
> +EXPORT_SYMBOL(pci_find_root_port);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 360a966a97a5..f4321c5ba653 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -844,6 +844,7 @@ static inline struct pci_dev *pci_get_bus_and_slot(unsigned int bus,
>  }
>  struct pci_dev *pci_get_class(unsigned int class, struct pci_dev *from);
>  int pci_dev_present(const struct pci_device_id *ids);
> +struct pci_dev *pci_find_root_port(struct pci_dev *dev);
>  
>  int pci_bus_read_config_byte(struct pci_bus *bus, unsigned int devfn,
>  			     int where, u8 *val);
> -- 
> 2.1.4
> 
