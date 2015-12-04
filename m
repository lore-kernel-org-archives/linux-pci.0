Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45613 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753241AbbLDUBO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 4 Dec 2015 15:01:14 -0500
Date: Fri, 4 Dec 2015 14:01:10 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: tegra: Implement ->add_bus() callback
Message-ID: <20151204200110.GF20125@localhost>
References: <1448282426-2642-1-git-send-email-thierry.reding@gmail.com>
 <1448282426-2642-2-git-send-email-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1448282426-2642-2-git-send-email-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 23, 2015 at 01:40:26PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The configuration space mapping on Tegra is somewhat special, and in

It'd be nice to have a tiny hint about specifically what is special
about Tegra config space mapping.

> order to avoid wasting virtual address space the configuration space
> for each bus needs to be stitched together from several blocks which
> form a single continuous virtual address range for accessors.
> 
> Currently the configuration space is mapped upon the first access to
> one of its registers. However, the mapping operation may sleep under
> certain circumstances, so doing it from the configuration space
> accessors (they are protected by a spin lock) will trigger a warning.

Can you include the exact warning?  Does it happen always?  Always on
the first config access to a bus?

> To avoid the warning, use the ->add_bus() callback to perform the
> mapping at enumeration time when the operation is allowed to sleep.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/pci/host/pci-tegra.c | 40 +++++++++++++++++++---------------------
>  1 file changed, 19 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 3018ae52e092..c3666f9d7ef1 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -426,31 +426,23 @@ free:
>  	return ERR_PTR(err);
>  }
>  
> -/*
> - * Look up a virtual address mapping for the specified bus number. If no such
> - * mapping exists, try to create one.
> - */
> -static void __iomem *tegra_pcie_bus_map(struct tegra_pcie *pcie,
> -					unsigned int busnr)
> +static int tegra_pcie_add_bus(struct pci_bus *bus)
>  {
> -	struct tegra_pcie_bus *bus;
> +	struct tegra_pcie *pcie = sys_to_pcie(bus->sysdata);
> +	struct tegra_pcie_bus *b;
>  
> -	list_for_each_entry(bus, &pcie->buses, list)
> -		if (bus->nr == busnr)
> -			return (void __iomem *)bus->area->addr;
> +	b = tegra_pcie_bus_alloc(pcie, bus->number);
> +	if (IS_ERR(b))
> +		return PTR_ERR(b);
>  
> -	bus = tegra_pcie_bus_alloc(pcie, busnr);
> -	if (IS_ERR(bus))
> -		return NULL;
> +	list_add_tail(&b->list, &pcie->buses);
>  
> -	list_add_tail(&bus->list, &pcie->buses);
> -
> -	return (void __iomem *)bus->area->addr;
> +	return 0;
>  }
>  
> -static void __iomem *tegra_pcie_conf_address(struct pci_bus *bus,
> -					     unsigned int devfn,
> -					     int where)
> +static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
> +					unsigned int devfn,
> +					int where)
>  {
>  	struct tegra_pcie *pcie = sys_to_pcie(bus->sysdata);
>  	void __iomem *addr = NULL;
> @@ -466,7 +458,12 @@ static void __iomem *tegra_pcie_conf_address(struct pci_bus *bus,
>  			}
>  		}
>  	} else {
> -		addr = tegra_pcie_bus_map(pcie, bus->number);
> +		struct tegra_pcie_bus *b;
> +
> +		list_for_each_entry(b, &pcie->buses, list)
> +			if (b->nr == bus->number)
> +				addr = (void __iomem *)b->area->addr;
> +
>  		if (!addr) {
>  			dev_err(pcie->dev,
>  				"failed to map cfg. space for bus %u\n",
> @@ -481,7 +478,8 @@ static void __iomem *tegra_pcie_conf_address(struct pci_bus *bus,
>  }
>  
>  static struct pci_ops tegra_pcie_ops = {
> -	.map_bus = tegra_pcie_conf_address,
> +	.add_bus = tegra_pcie_add_bus,
> +	.map_bus = tegra_pcie_map_bus,
>  	.read = pci_generic_config_read32,
>  	.write = pci_generic_config_write32,
>  };
> -- 
> 2.5.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
