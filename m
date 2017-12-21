Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60524 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751163AbdLUKAj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Dec 2017 05:00:39 -0500
Date: Thu, 21 Dec 2017 10:01:23 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vidya Saga <vidyas@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v4] PCI: tegra: Refactor configuration space mapping code
Message-ID: <20171221100123.GA23573@red-moon>
References: <20171220203607.18288-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171220203607.18288-1-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 20, 2017 at 09:36:07PM +0100, Thierry Reding wrote:
> From: Vidya Sagar <vidyas@nvidia.com>
> 
> Use only 4 KiB space from the available 1 GiB PCIe aperture to access
> endpoint configuration space by dynamically moving the AFI_FPCI_BAR base
> address. This frees more space for mapping endpoint device BARs on some
> Tegra platforms.
> 
> The ->add_bus() and ->remove_bus() callbacks are now no longer needed,
> so they can be removed.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> [treding@nvidia.com: various cleanups, update commit message]
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/pci/host/pci-tegra.c | 148 +++++++++----------------------------------

Applied to pci/tegra for v4.16.

Thanks,
Lorenzo

>  1 file changed, 30 insertions(+), 118 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index f2214ca1ad17..56434aa44b60 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -269,11 +269,10 @@ struct tegra_pcie {
>  
>  	void __iomem *pads;
>  	void __iomem *afi;
> +	void __iomem *cfg;
>  	int irq;
>  
> -	struct list_head buses;
> -	struct resource *cs;
> -
> +	struct resource cs;
>  	struct resource io;
>  	struct resource pio;
>  	struct resource mem;
> @@ -322,7 +321,6 @@ struct tegra_pcie_port {
>  };
>  
>  struct tegra_pcie_bus {
> -	struct vm_struct *area;
>  	struct list_head list;
>  	unsigned int nr;
>  };
> @@ -362,100 +360,19 @@ static inline u32 pads_readl(struct tegra_pcie *pcie, unsigned long offset)
>   *
>   * Mapping the whole extended configuration space would require 256 MiB of
>   * virtual address space, only a small part of which will actually be used.
> - * To work around this, a 1 MiB of virtual addresses are allocated per bus
> - * when the bus is first accessed. When the physical range is mapped, the
> - * the bus number bits are hidden so that the extended register number bits
> - * appear as bits [19:16]. Therefore the virtual mapping looks like this:
> - *
> - *    [19:16] extended register number
> - *    [15:11] device number
> - *    [10: 8] function number
> - *    [ 7: 0] register number
>   *
> - * This is achieved by stitching together 16 chunks of 64 KiB of physical
> - * address space via the MMU.
> + * To work around this, a 4 KiB region is used to generate the required
> + * configuration transaction with relevant B:D:F and register offset values.
> + * This is achieved by dynamically programming base address and size of
> + * AFI_AXI_BAR used for end point config space mapping to make sure that the
> + * address (access to which generates correct config transaction) falls in
> + * this 4 KiB region.
>   */
> -static unsigned long tegra_pcie_conf_offset(unsigned int devfn, int where)
> -{
> -	return ((where & 0xf00) << 8) | (PCI_SLOT(devfn) << 11) |
> -	       (PCI_FUNC(devfn) << 8) | (where & 0xfc);
> -}
> -
> -static struct tegra_pcie_bus *tegra_pcie_bus_alloc(struct tegra_pcie *pcie,
> -						   unsigned int busnr)
> +static unsigned int tegra_pcie_conf_offset(u8 bus, unsigned int devfn,
> +					   unsigned int where)
>  {
> -	struct device *dev = pcie->dev;
> -	pgprot_t prot = pgprot_noncached(PAGE_KERNEL);
> -	phys_addr_t cs = pcie->cs->start;
> -	struct tegra_pcie_bus *bus;
> -	unsigned int i;
> -	int err;
> -
> -	bus = kzalloc(sizeof(*bus), GFP_KERNEL);
> -	if (!bus)
> -		return ERR_PTR(-ENOMEM);
> -
> -	INIT_LIST_HEAD(&bus->list);
> -	bus->nr = busnr;
> -
> -	/* allocate 1 MiB of virtual addresses */
> -	bus->area = get_vm_area(SZ_1M, VM_IOREMAP);
> -	if (!bus->area) {
> -		err = -ENOMEM;
> -		goto free;
> -	}
> -
> -	/* map each of the 16 chunks of 64 KiB each */
> -	for (i = 0; i < 16; i++) {
> -		unsigned long virt = (unsigned long)bus->area->addr +
> -				     i * SZ_64K;
> -		phys_addr_t phys = cs + i * SZ_16M + busnr * SZ_64K;
> -
> -		err = ioremap_page_range(virt, virt + SZ_64K, phys, prot);
> -		if (err < 0) {
> -			dev_err(dev, "ioremap_page_range() failed: %d\n", err);
> -			goto unmap;
> -		}
> -	}
> -
> -	return bus;
> -
> -unmap:
> -	vunmap(bus->area->addr);
> -free:
> -	kfree(bus);
> -	return ERR_PTR(err);
> -}
> -
> -static int tegra_pcie_add_bus(struct pci_bus *bus)
> -{
> -	struct pci_host_bridge *host = pci_find_host_bridge(bus);
> -	struct tegra_pcie *pcie = pci_host_bridge_priv(host);
> -	struct tegra_pcie_bus *b;
> -
> -	b = tegra_pcie_bus_alloc(pcie, bus->number);
> -	if (IS_ERR(b))
> -		return PTR_ERR(b);
> -
> -	list_add_tail(&b->list, &pcie->buses);
> -
> -	return 0;
> -}
> -
> -static void tegra_pcie_remove_bus(struct pci_bus *child)
> -{
> -	struct pci_host_bridge *host = pci_find_host_bridge(child);
> -	struct tegra_pcie *pcie = pci_host_bridge_priv(host);
> -	struct tegra_pcie_bus *bus, *tmp;
> -
> -	list_for_each_entry_safe(bus, tmp, &pcie->buses, list) {
> -		if (bus->nr == child->number) {
> -			vunmap(bus->area->addr);
> -			list_del(&bus->list);
> -			kfree(bus);
> -			break;
> -		}
> -	}
> +	return ((where & 0xf00) << 16) | (bus << 16) | (PCI_SLOT(devfn) << 11) |
> +	       (PCI_FUNC(devfn) << 8) | (where & 0xff);
>  }
>  
>  static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
> @@ -464,7 +381,6 @@ static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
>  {
>  	struct pci_host_bridge *host = pci_find_host_bridge(bus);
>  	struct tegra_pcie *pcie = pci_host_bridge_priv(host);
> -	struct device *dev = pcie->dev;
>  	void __iomem *addr = NULL;
>  
>  	if (bus->number == 0) {
> @@ -478,19 +394,17 @@ static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
>  			}
>  		}
>  	} else {
> -		struct tegra_pcie_bus *b;
> +		unsigned int offset;
> +		u32 base;
>  
> -		list_for_each_entry(b, &pcie->buses, list)
> -			if (b->nr == bus->number)
> -				addr = (void __iomem *)b->area->addr;
> +		offset = tegra_pcie_conf_offset(bus->number, devfn, where);
>  
> -		if (!addr) {
> -			dev_err(dev, "failed to map cfg. space for bus %u\n",
> -				bus->number);
> -			return NULL;
> -		}
> +		/* move 4 KiB window to offset within the FPCI region */
> +		base = 0xfe100000 + ((offset & ~(SZ_4K - 1)) >> 8);
> +		afi_writel(pcie, base, AFI_FPCI_BAR0);
>  
> -		addr += tegra_pcie_conf_offset(devfn, where);
> +		/* move to correct offset within the 4 KiB page */
> +		addr = pcie->cfg + (offset & (SZ_4K - 1));
>  	}
>  
>  	return addr;
> @@ -517,8 +431,6 @@ static int tegra_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
>  }
>  
>  static struct pci_ops tegra_pcie_ops = {
> -	.add_bus = tegra_pcie_add_bus,
> -	.remove_bus = tegra_pcie_remove_bus,
>  	.map_bus = tegra_pcie_map_bus,
>  	.read = tegra_pcie_config_read,
>  	.write = tegra_pcie_config_write,
> @@ -743,12 +655,9 @@ static void tegra_pcie_setup_translations(struct tegra_pcie *pcie)
>  	u32 fpci_bar, size, axi_address;
>  
>  	/* Bar 0: type 1 extended configuration space */
> -	fpci_bar = 0xfe100000;
> -	size = resource_size(pcie->cs);
> -	axi_address = pcie->cs->start;
> -	afi_writel(pcie, axi_address, AFI_AXI_BAR0_START);
> +	size = resource_size(&pcie->cs);
> +	afi_writel(pcie, pcie->cs.start, AFI_AXI_BAR0_START);
>  	afi_writel(pcie, size >> 12, AFI_AXI_BAR0_SZ);
> -	afi_writel(pcie, fpci_bar, AFI_FPCI_BAR0);
>  
>  	/* Bar 1: downstream IO bar */
>  	fpci_bar = 0xfdfc0000;
> @@ -1353,10 +1262,14 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
>  		goto poweroff;
>  	}
>  
> -	pcie->cs = devm_request_mem_region(dev, res->start,
> -					   resource_size(res), res->name);
> -	if (!pcie->cs) {
> -		err = -EADDRNOTAVAIL;
> +	pcie->cs = *res;
> +
> +	/* constrain configuration space to 4 KiB */
> +	pcie->cs.end = pcie->cs.start + SZ_4K - 1;
> +
> +	pcie->cfg = devm_ioremap_resource(dev, &pcie->cs);
> +	if (IS_ERR(pcie->cfg)) {
> +		err = PTR_ERR(pcie->cfg);
>  		goto poweroff;
>  	}
>  
> @@ -2376,7 +2289,6 @@ static int tegra_pcie_probe(struct platform_device *pdev)
>  	pcie = pci_host_bridge_priv(host);
>  
>  	pcie->soc = of_device_get_match_data(dev);
> -	INIT_LIST_HEAD(&pcie->buses);
>  	INIT_LIST_HEAD(&pcie->ports);
>  	pcie->dev = dev;
>  
> -- 
> 2.15.1
> 
