Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([91.232.154.25]:41396 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751783AbdK2L7m (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Nov 2017 06:59:42 -0500
Subject: Re: [PATCH V2 6/9] PCI: tegra: free resources on probe failure
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        frowand.list@gmail.com, bhelgaas@google.com, rjw@rjwysocki.net,
        tglx@linutronix.de
References: <1511638333-22951-1-git-send-email-mmaddireddy@nvidia.com>
 <1511638333-22951-7-git-send-email-mmaddireddy@nvidia.com>
Cc: vidyas@nvidia.com, kthota@nvidia.com, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org
From: Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <2c8b33f4-1524-cd0f-05f5-15f87bf59e31@kapsi.fi>
Date: Wed, 29 Nov 2017 13:59:39 +0200
MIME-Version: 1.0
In-Reply-To: <1511638333-22951-7-git-send-email-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 25.11.2017 21:32, Manikanta Maddireddy wrote:
> tegra_pcie_probe() can fail in multiple instances, this patch takes care
> of freeing the resources which are allocated before probe fail.
>
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V2:
> * no change in this patch
>
>  drivers/pci/host/pci-tegra.c | 102 ++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 86 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index e9b3ff95e259..7f7b8c9c1e84 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -701,14 +701,25 @@ static int tegra_pcie_request_resources(struct tegra_pcie *pcie)
>  	pci_add_resource(windows, &pcie->busn);
>
>  	err = devm_request_pci_bus_resources(dev, windows);
> -	if (err < 0)
> +	if (err < 0) {
> +		pci_free_resource_list(windows);
>  		return err;
> +	}
>
>  	pci_remap_iospace(&pcie->pio, pcie->io.start);
>
>  	return 0;
>  }
>
> +static void tegra_pcie_free_resources(struct tegra_pcie *pcie)
> +{
> +	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
> +	struct list_head *windows = &host->windows;
> +
> +	pci_unmap_iospace(&pcie->pio);
> +	pci_free_resource_list(windows);
> +}
> +
>  static int tegra_pcie_map_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
>  {
>  	struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
> @@ -1109,29 +1120,40 @@ static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
>  	return 0;
>  }
>
> -static void tegra_pcie_power_off(struct tegra_pcie *pcie)
> +static void tegra_pcie_disable_controller(struct tegra_pcie *pcie)
>  {
>  	struct device *dev = pcie->dev;
>  	const struct tegra_pcie_soc *soc = pcie->soc;
>  	int err;
>
> -	/* TODO: disable and unprepare clocks? */
> -
>  	if (soc->program_uphy) {
>  		err = tegra_pcie_phy_power_off(pcie);
>  		if (err < 0)
>  			dev_err(dev, "failed to power off PHY(s): %d\n", err);
>  	}
> +}
> +
> +static void tegra_pcie_power_off(struct tegra_pcie *pcie)
> +{
> +	struct device *dev = pcie->dev;
> +	const struct tegra_pcie_soc *soc = pcie->soc;
> +	int err;
>
>  	reset_control_assert(pcie->afi_rst);
>  	reset_control_assert(pcie->pex_rst);
>
> -	if (!dev->pm_domain)
> -		tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
> +	clk_disable_unprepare(pcie->pll_e);
> +	if (soc->has_cml_clk)
> +		clk_disable_unprepare(pcie->cml_clk);
> +	clk_disable_unprepare(pcie->afi_clk);
> +	clk_disable_unprepare(pcie->pex_clk);
>
>  	err = regulator_bulk_disable(pcie->num_supplies, pcie->supplies);
>  	if (err < 0)
>  		dev_warn(dev, "failed to disable regulators: %d\n", err);
> +
> +	if (!dev->pm_domain)
> +		tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
>  }
>
>  static int tegra_pcie_power_on(struct tegra_pcie *pcie)
> @@ -1262,6 +1284,15 @@ static int tegra_pcie_phys_get_legacy(struct tegra_pcie *pcie)
>  	return 0;
>  }
>
> +static void tegra_pcie_phys_put_legacy(struct tegra_pcie *pcie)
> +{
> +	int err;
> +
> +	err = phy_exit(pcie->phy);
> +	if (err < 0)
> +		dev_err(pcie->dev, "failed to teardown PHY: %d\n", err);
> +}
> +
>  static struct phy *devm_of_phy_optional_get_index(struct device *dev,
>  						  struct device_node *np,
>  						  const char *consumer,
> @@ -1315,6 +1346,19 @@ static int tegra_pcie_port_get_phys(struct tegra_pcie_port *port)
>  	return 0;
>  }
>
> +static void tegra_pcie_port_put_phys(struct tegra_pcie_port *port)
> +{
> +	struct device *dev = port->pcie->dev;
> +	unsigned int i;
> +	int err;
> +
> +	for (i = 0; i < port->lanes; i++) {
> +		err = phy_exit(port->phys[i]);
> +		if (err < 0)
> +			dev_err(dev, "failed to teardown PHY#%u: %d\n", i, err);
> +	}
> +}
> +
>  static int tegra_pcie_phys_get(struct tegra_pcie *pcie)
>  {
>  	const struct tegra_pcie_soc *soc = pcie->soc;
> @@ -1334,6 +1378,19 @@ static int tegra_pcie_phys_get(struct tegra_pcie *pcie)
>  	return 0;
>  }
>
> +static void tegra_pcie_phys_put(struct tegra_pcie *pcie)
> +{
> +	const struct tegra_pcie_soc *soc = pcie->soc;
> +	struct device_node *np = pcie->dev->of_node;
> +	struct tegra_pcie_port *port;
> +
> +	if (!soc->has_gen2 || of_find_property(np, "phys", NULL) != NULL)
> +		tegra_pcie_phys_put_legacy(pcie);

I think it would be nicer to just check if legacy_phy is true, since 
tegra_pcie_phys_get_legacy sets it. That way we don't need to have the 
complicated check in two places.

Mikko

> +
> +	list_for_each_entry(port, &pcie->ports, list)
> +		tegra_pcie_port_put_phys(port);
> +}
> +
>  static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
>  {
>  	struct device *dev = pcie->dev;
> @@ -1366,7 +1423,7 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
>  	err = tegra_pcie_power_on(pcie);
>  	if (err) {
>  		dev_err(dev, "failed to power up: %d\n", err);
> -		return err;
> +		goto phys_put;
>  	}
>
>  	pads = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pads");
> @@ -1424,25 +1481,23 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
>
>  poweroff:
>  	tegra_pcie_power_off(pcie);
> +phys_put:
> +	if (soc->program_uphy)
> +		tegra_pcie_phys_put(pcie);
>  	return err;
>  }
>
>  static int tegra_pcie_put_resources(struct tegra_pcie *pcie)
>  {
> -	struct device *dev = pcie->dev;
>  	const struct tegra_pcie_soc *soc = pcie->soc;
> -	int err;
>
>  	if (pcie->irq > 0)
>  		free_irq(pcie->irq, pcie);
>
>  	tegra_pcie_power_off(pcie);
>
> -	if (soc->program_uphy) {
> -		err = phy_exit(pcie->phy);
> -		if (err < 0)
> -			dev_err(dev, "failed to teardown PHY: %d\n", err);
> -	}
> +	if (soc->program_uphy)
> +		tegra_pcie_phys_put(pcie);
>
>  	return 0;
>  }
> @@ -2371,6 +2426,16 @@ static void tegra_pcie_enable_ports(struct tegra_pcie *pcie)
>  	}
>  }
>
> +static void tegra_pcie_disable_ports(struct tegra_pcie *pcie)
> +{
> +	struct tegra_pcie_port *port, *tmp;
> +
> +	reset_control_assert(pcie->pcie_xrst);
> +
> +	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
> +		tegra_pcie_port_disable(port);
> +}
> +
>  static void tegra_pcie_change_link_speed(struct tegra_pcie *pcie,
>  					 struct pci_dev *pci_dev)
>  {
> @@ -2691,7 +2756,7 @@ static int tegra_pcie_probe(struct platform_device *pdev)
>
>  	err = tegra_pcie_request_resources(pcie);
>  	if (err)
> -		goto put_resources;
> +		goto disable_controller;
>
>  	/* setup the AFI address translations */
>  	tegra_pcie_setup_translations(pcie);
> @@ -2700,7 +2765,7 @@ static int tegra_pcie_probe(struct platform_device *pdev)
>  		err = tegra_pcie_enable_msi(pcie);
>  		if (err < 0) {
>  			dev_err(dev, "failed to enable MSI support: %d\n", err);
> -			goto put_resources;
> +			goto free_resources;
>  		}
>  	}
>
> @@ -2741,6 +2806,11 @@ static int tegra_pcie_probe(struct platform_device *pdev)
>  disable_msi:
>  	if (IS_ENABLED(CONFIG_PCI_MSI))
>  		tegra_pcie_disable_msi(pcie);
> +	tegra_pcie_disable_ports(pcie);
> +free_resources:
> +	tegra_pcie_free_resources(pcie);
> +disable_controller:
> +	tegra_pcie_disable_controller(pcie);
>  put_resources:
>  	tegra_pcie_put_resources(pcie);
>  	return err;
>
