Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37818 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755470AbcHSRM7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Aug 2016 13:12:59 -0400
Date: Fri, 19 Aug 2016 18:13:00 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Tomasz Nowicki <tn@semihalf.com>,
        Liviu Dudau <liviu.dudau@arm.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 4/4] PCI: tegra: Use new pci_register_host_bridge()
 interface
Message-ID: <20160819171300.GB11823@red-moon>
References: <20160815153647.1075-1-thierry.reding@gmail.com>
 <20160815153647.1075-4-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160815153647.1075-4-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 15, 2016 at 05:36:47PM +0200, Thierry Reding wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Tegra is one of the remaining platforms that still use the traditional
> pci_common_init_dev() interface for probing PCI host bridges.
> 
> This demonstrates how to convert it to the pci_register_host interface
> I just added in a previous patch. This leads to a more linear probe
> sequence that can handle errors better because we avoid callbacks into
> the driver, and it makes the driver architecture independent.
> 
> As a side note, I should mention that I noticed this driver does not
> register any IORESOURCE_IO resource with the bus, but instead registers
> the I/O port window as a memory resource, which is surely a bug.

I do not think that's true (and these comments do not belong in
a commit log anyway). It registers both; granted the way
the resources are named is a bit misleading, but by looking
at the code it seems correct to me (struct tegra_pcie.{io/pio}).

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/pci/host/pci-tegra.c | 99 +++++++++++++++++++++++---------------------
>  1 file changed, 52 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 2d520755b1d7..6737d1be9798 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -260,6 +260,7 @@ static inline struct tegra_msi *to_tegra_msi(struct msi_controller *chip)
>  }
>  
>  struct tegra_pcie {
> +	struct pci_host_bridge *bridge;

If we go for the zero length array approach we would remove this
pointer too, since it would be superfluos, a container_of would
just do, right ?

Lorenzo

>  	struct device *dev;
>  
>  	void __iomem *pads;
> @@ -322,11 +323,6 @@ struct tegra_pcie_bus {
>  	unsigned int nr;
>  };
>  
> -static inline struct tegra_pcie *sys_to_pcie(struct pci_sys_data *sys)
> -{
> -	return sys->private_data;
> -}
> -
>  static inline void afi_writel(struct tegra_pcie *pcie, u32 value,
>  			      unsigned long offset)
>  {
> @@ -430,7 +426,8 @@ free:
>  
>  static int tegra_pcie_add_bus(struct pci_bus *bus)
>  {
> -	struct tegra_pcie *pcie = sys_to_pcie(bus->sysdata);
> +	struct pci_host_bridge *host = pci_find_host_bridge(bus);
> +	struct tegra_pcie *pcie = host->private;
>  	struct tegra_pcie_bus *b;
>  
>  	b = tegra_pcie_bus_alloc(pcie, bus->number);
> @@ -444,7 +441,8 @@ static int tegra_pcie_add_bus(struct pci_bus *bus)
>  
>  static void tegra_pcie_remove_bus(struct pci_bus *child)
>  {
> -	struct tegra_pcie *pcie = sys_to_pcie(child->sysdata);
> +	struct pci_host_bridge *host = pci_find_host_bridge(child);
> +	struct tegra_pcie *pcie = host->private;
>  	struct tegra_pcie_bus *bus, *tmp;
>  
>  	list_for_each_entry_safe(bus, tmp, &pcie->buses, list) {
> @@ -461,7 +459,8 @@ static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
>  					unsigned int devfn,
>  					int where)
>  {
> -	struct tegra_pcie *pcie = sys_to_pcie(bus->sysdata);
> +	struct pci_host_bridge *host = pci_find_host_bridge(bus);
> +	struct tegra_pcie *pcie = host->private;
>  	void __iomem *addr = NULL;
>  
>  	if (bus->number == 0) {
> @@ -609,35 +608,29 @@ static void tegra_pcie_relax_enable(struct pci_dev *dev)
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, tegra_pcie_relax_enable);
>  
> -static int tegra_pcie_setup(int nr, struct pci_sys_data *sys)
> +static int tegra_pcie_request_resources(struct tegra_pcie *pcie)
>  {
> -	struct tegra_pcie *pcie = sys_to_pcie(sys);
> +	struct list_head *windows = &pcie->bridge->windows;
>  	int err;
>  
> -	sys->mem_offset = pcie->offset.mem;
> -	sys->io_offset = pcie->offset.io;
> -
> -	err = devm_request_resource(pcie->dev, &iomem_resource, &pcie->io);
> -	if (err < 0)
> -		return err;
> -
> -	pci_add_resource_offset(&sys->resources, &pcie->pio, sys->io_offset);
> -	pci_add_resource_offset(&sys->resources, &pcie->mem, sys->mem_offset);
> -	pci_add_resource_offset(&sys->resources, &pcie->prefetch,
> -				sys->mem_offset);
> -	pci_add_resource(&sys->resources, &pcie->busn);
> +	pci_add_resource_offset(windows, &pcie->pio, pcie->offset.io);
> +	pci_add_resource_offset(windows, &pcie->mem, pcie->offset.mem);
> +	pci_add_resource_offset(windows, &pcie->prefetch, pcie->offset.mem);
> +	pci_add_resource(windows, &pcie->busn);
>  
> -	err = devm_request_pci_bus_resources(pcie->dev, &sys->resources);
> +	err = devm_request_pci_bus_resources(pcie->dev, windows);
>  	if (err < 0)
>  		return err;
>  
>  	pci_remap_iospace(&pcie->pio, pcie->io.start);
> -	return 1;
> +
> +	return 0;
>  }
>  
>  static int tegra_pcie_map_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
>  {
> -	struct tegra_pcie *pcie = sys_to_pcie(pdev->bus->sysdata);
> +	struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
> +	struct tegra_pcie *pcie = host->private;
>  	int irq;
>  
>  	tegra_cpuidle_pcie_irqs_in_use();
> @@ -1544,6 +1537,8 @@ static int tegra_pcie_enable_msi(struct tegra_pcie *pcie)
>  	reg |= AFI_INTR_MASK_MSI_MASK;
>  	afi_writel(pcie, reg, AFI_INTR_MASK);
>  
> +	pcie->bridge->msi = &msi->chip;
> +
>  	return 0;
>  
>  err:
> @@ -2006,10 +2001,9 @@ retry:
>  	return false;
>  }
>  
> -static int tegra_pcie_enable(struct tegra_pcie *pcie)
> +static void tegra_pcie_enable_ports(struct tegra_pcie *pcie)
>  {
>  	struct tegra_pcie_port *port, *tmp;
> -	struct hw_pci hw;
>  
>  	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
>  		dev_info(pcie->dev, "probing port %u, using %u lanes\n",
> @@ -2025,22 +2019,6 @@ static int tegra_pcie_enable(struct tegra_pcie *pcie)
>  		tegra_pcie_port_disable(port);
>  		tegra_pcie_port_free(port);
>  	}
> -
> -	memset(&hw, 0, sizeof(hw));
> -
> -#ifdef CONFIG_PCI_MSI
> -	hw.msi_ctrl = &pcie->msi.chip;
> -#endif
> -
> -	hw.nr_controllers = 1;
> -	hw.private_data = (void **)&pcie;
> -	hw.setup = tegra_pcie_setup;
> -	hw.map_irq = tegra_pcie_map_irq;
> -	hw.ops = &tegra_pcie_ops;
> -
> -	pci_common_init_dev(pcie->dev, &hw);
> -
> -	return 0;
>  }
>  
>  static const struct tegra_pcie_soc tegra20_pcie = {
> @@ -2201,13 +2179,18 @@ remove:
>  
>  static int tegra_pcie_probe(struct platform_device *pdev)
>  {
> +	struct pci_host_bridge *bridge;
>  	struct tegra_pcie *pcie;
> +	struct pci_bus *child;
>  	int err;
>  
> -	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
> -	if (!pcie)
> +	bridge = pci_alloc_host_bridge(sizeof(*pcie));
> +	if (!bridge)
>  		return -ENOMEM;
>  
> +	pcie = bridge->private;
> +	pcie->bridge = bridge;
> +
>  	pcie->soc = of_device_get_match_data(&pdev->dev);
>  	INIT_LIST_HEAD(&pcie->buses);
>  	INIT_LIST_HEAD(&pcie->ports);
> @@ -2227,6 +2210,10 @@ static int tegra_pcie_probe(struct platform_device *pdev)
>  	if (err)
>  		goto put_resources;
>  
> +	err = tegra_pcie_request_resources(pcie);
> +	if (err)
> +		goto put_resources;
> +
>  	/* setup the AFI address translations */
>  	tegra_pcie_setup_translations(pcie);
>  
> @@ -2240,12 +2227,30 @@ static int tegra_pcie_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	err = tegra_pcie_enable(pcie);
> +	tegra_pcie_enable_ports(pcie);
> +
> +	pci_add_flags(PCI_REASSIGN_ALL_RSRC | PCI_REASSIGN_ALL_BUS);
> +	bridge->busnr = pcie->busn.start;
> +	bridge->dev.parent = &pdev->dev;
> +	bridge->ops = &tegra_pcie_ops;
> +
> +	err = pci_register_host_bridge(bridge);
>  	if (err < 0) {
> -		dev_err(&pdev->dev, "failed to enable PCIe ports: %d\n", err);
> +		dev_err(&pdev->dev, "failed to register host: %d\n", err);
>  		goto disable_msi;
>  	}
>  
> +	pci_scan_child_bus(bridge->bus);
> +
> +	pci_fixup_irqs(pci_common_swizzle, tegra_pcie_map_irq);
> +	pci_bus_size_bridges(bridge->bus);
> +	pci_bus_assign_resources(bridge->bus);
> +
> +	list_for_each_entry(child, &bridge->bus->children, node)
> +		pcie_bus_configure_settings(child);
> +
> +	pci_bus_add_devices(bridge->bus);
> +
>  	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
>  		err = tegra_pcie_debugfs_init(pcie);
>  		if (err < 0)
> -- 
> 2.9.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
