Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wj0-f179.google.com ([209.85.210.179]:36616 "EHLO
        mail-wj0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932247AbcLIKL6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2016 05:11:58 -0500
Received: by mail-wj0-f179.google.com with SMTP id tk12so10526121wjb.3
        for <linux-pci@vger.kernel.org>; Fri, 09 Dec 2016 02:11:57 -0800 (PST)
Subject: Re: [PATCH v4 04/10] PCI: tegra: Use new pci_register_host_bridge()
 interface
To: Thierry Reding <thierry.reding@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20161125105718.3866-1-thierry.reding@gmail.com>
 <20161125105718.3866-4-thierry.reding@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <ba98b4cc-9e58-a86a-c0cc-579800138d60@semihalf.com>
Date: Fri, 9 Dec 2016 11:11:54 +0100
MIME-Version: 1.0
In-Reply-To: <20161125105718.3866-4-thierry.reding@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 25.11.2016 11:57, Thierry Reding wrote:
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
> Changes in v4 (Thierry Reding):
> - update for changes in core to deal with driver-private data
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/pci/host/pci-tegra.c | 105 ++++++++++++++++++++++---------------------
>  1 file changed, 54 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 8dfccf733241..d5206fa53353 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -322,11 +322,6 @@ struct tegra_pcie_bus {
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
> @@ -430,7 +425,8 @@ static struct tegra_pcie_bus *tegra_pcie_bus_alloc(struct tegra_pcie *pcie,
>
>  static int tegra_pcie_add_bus(struct pci_bus *bus)
>  {
> -	struct tegra_pcie *pcie = sys_to_pcie(bus->sysdata);
> +	struct pci_host_bridge *host = pci_find_host_bridge(bus);
> +	struct tegra_pcie *pcie = pci_host_bridge_priv(host);
>  	struct tegra_pcie_bus *b;
>
>  	b = tegra_pcie_bus_alloc(pcie, bus->number);
> @@ -444,7 +440,8 @@ static int tegra_pcie_add_bus(struct pci_bus *bus)
>
>  static void tegra_pcie_remove_bus(struct pci_bus *child)
>  {
> -	struct tegra_pcie *pcie = sys_to_pcie(child->sysdata);
> +	struct pci_host_bridge *host = pci_find_host_bridge(child);
> +	struct tegra_pcie *pcie = pci_host_bridge_priv(host);
>  	struct tegra_pcie_bus *bus, *tmp;
>
>  	list_for_each_entry_safe(bus, tmp, &pcie->buses, list) {
> @@ -461,7 +458,8 @@ static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
>  					unsigned int devfn,
>  					int where)
>  {
> -	struct tegra_pcie *pcie = sys_to_pcie(bus->sysdata);
> +	struct pci_host_bridge *host = pci_find_host_bridge(bus);
> +	struct tegra_pcie *pcie = pci_host_bridge_priv(host);
>  	struct device *dev = pcie->dev;
>  	void __iomem *addr = NULL;
>
> @@ -610,39 +608,31 @@ static void tegra_pcie_relax_enable(struct pci_dev *dev)
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, tegra_pcie_relax_enable);
>
> -static int tegra_pcie_setup(int nr, struct pci_sys_data *sys)
> +static int tegra_pcie_request_resources(struct tegra_pcie *pcie)
>  {
> -	struct tegra_pcie *pcie = sys_to_pcie(sys);
> +	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
> +	struct list_head *windows = &host->windows;
>  	struct device *dev = pcie->dev;
>  	int err;
>
> -	sys->mem_offset = pcie->offset.mem;
> -	sys->io_offset = pcie->offset.io;
> +	pci_add_resource_offset(windows, &pcie->pio, pcie->offset.io);
> +	pci_add_resource_offset(windows, &pcie->mem, pcie->offset.mem);
> +	pci_add_resource_offset(windows, &pcie->prefetch, pcie->offset.mem);
> +	pci_add_resource(windows, &pcie->busn);
>
> -	err = devm_request_resource(dev, &iomem_resource, &pcie->io);
> +	err = devm_request_pci_bus_resources(dev, windows);
>  	if (err < 0)
>  		return err;
>
> -	err = pci_remap_iospace(&pcie->pio, pcie->io.start);
> -	if (!err)
> -		pci_add_resource_offset(&sys->resources, &pcie->pio,
> -					sys->io_offset);
> -
> -	pci_add_resource_offset(&sys->resources, &pcie->mem, sys->mem_offset);
> -	pci_add_resource_offset(&sys->resources, &pcie->prefetch,
> -				sys->mem_offset);
> -	pci_add_resource(&sys->resources, &pcie->busn);
> -
> -	err = devm_request_pci_bus_resources(dev, &sys->resources);
> -	if (err < 0)
> -		return err;
> +	pci_remap_iospace(&pcie->pio, pcie->io.start);
>
> -	return 1;
> +	return 0;
>  }
>
>  static int tegra_pcie_map_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
>  {
> -	struct tegra_pcie *pcie = sys_to_pcie(pdev->bus->sysdata);
> +	struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
> +	struct tegra_pcie *pcie = pci_host_bridge_priv(host);
>  	int irq;
>
>  	tegra_cpuidle_pcie_irqs_in_use();
> @@ -1499,10 +1489,11 @@ static const struct irq_domain_ops msi_domain_ops = {
>
>  static int tegra_pcie_enable_msi(struct tegra_pcie *pcie)
>  {
> -	struct device *dev = pcie->dev;
> -	struct platform_device *pdev = to_platform_device(dev);
> +	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
> +	struct platform_device *pdev = to_platform_device(pcie->dev);
>  	const struct tegra_pcie_soc *soc = pcie->soc;
>  	struct tegra_msi *msi = &pcie->msi;
> +	struct device *dev = pcie->dev;
>  	unsigned long base;
>  	int err;
>  	u32 reg;
> @@ -1559,6 +1550,8 @@ static int tegra_pcie_enable_msi(struct tegra_pcie *pcie)
>  	reg |= AFI_INTR_MASK_MSI_MASK;
>  	afi_writel(pcie, reg, AFI_INTR_MASK);
>
> +	host->msi = &msi->chip;
> +
>  	return 0;
>
>  err:
> @@ -2021,11 +2014,10 @@ static bool tegra_pcie_port_check_link(struct tegra_pcie_port *port)
>  	return false;
>  }
>
> -static int tegra_pcie_enable(struct tegra_pcie *pcie)
> +static void tegra_pcie_enable_ports(struct tegra_pcie *pcie)
>  {
>  	struct device *dev = pcie->dev;
>  	struct tegra_pcie_port *port, *tmp;
> -	struct hw_pci hw;
>
>  	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
>  		dev_info(dev, "probing port %u, using %u lanes\n",
> @@ -2041,21 +2033,6 @@ static int tegra_pcie_enable(struct tegra_pcie *pcie)
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
> -	pci_common_init_dev(dev, &hw);
> -	return 0;
>  }
>
>  static const struct tegra_pcie_soc tegra20_pcie = {
> @@ -2217,13 +2194,17 @@ static int tegra_pcie_debugfs_init(struct tegra_pcie *pcie)
>  static int tegra_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> +	struct pci_host_bridge *host;
>  	struct tegra_pcie *pcie;
> +	struct pci_bus *child;
>  	int err;
>
> -	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> -	if (!pcie)
> +	host = pci_alloc_host_bridge(sizeof(*pcie));
> +	if (!host)
>  		return -ENOMEM;
>
> +	pcie = pci_host_bridge_priv(host);
> +
>  	pcie->soc = of_device_get_match_data(dev);
>  	INIT_LIST_HEAD(&pcie->buses);
>  	INIT_LIST_HEAD(&pcie->ports);
> @@ -2243,6 +2224,10 @@ static int tegra_pcie_probe(struct platform_device *pdev)
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
> @@ -2254,12 +2239,30 @@ static int tegra_pcie_probe(struct platform_device *pdev)
>  		}
>  	}
>
> -	err = tegra_pcie_enable(pcie);
> +	tegra_pcie_enable_ports(pcie);
> +
> +	pci_add_flags(PCI_REASSIGN_ALL_RSRC | PCI_REASSIGN_ALL_BUS);
> +	host->busnr = pcie->busn.start;
> +	host->dev.parent = &pdev->dev;
> +	host->ops = &tegra_pcie_ops;

What about:
host->dev.release = pci_release_host_bridge_dev;
which was used in previous approach (pci_common_init_dev())

Tomasz
