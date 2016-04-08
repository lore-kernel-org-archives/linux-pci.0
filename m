Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51041 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758012AbcDHSFd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 8 Apr 2016 14:05:33 -0400
Date: Fri, 8 Apr 2016 13:05:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] PCI: tegra: Support per-lane PHYs
Message-ID: <20160408180528.GC15034@localhost>
References: <1460131994-24493-1-git-send-email-thierry.reding@gmail.com>
 <1460131994-24493-2-git-send-email-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1460131994-24493-2-git-send-email-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Thierry,

I think there are a couple typos (one in a message and one that
actually looks important), and one question below.

On Fri, Apr 08, 2016 at 06:13:14PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The current XUSB pad controller bindings are insufficient to describe
> PHY devices attached to USB controllers. New bindings have been created
> to overcome these restrictions. As a side-effect each root port now is
> assigned a set of PHY devices, one for each lane associated with the
> root port. This has the benefit of allowing fine-grained control of the
> power management for each lane.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v4:
> - propagate failure from PHY power on
> - refactor PHY power off sequence
> 
> Changes in v3:
> - cache result of check for new PHY bindings usage (Stephen Warren)
> 
> Changes in v2:
> - rework commit message to more accurately describe this change
> 
>  drivers/pci/host/pci-tegra.c | 243 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 226 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 68d1f41b3cbf..d50568bf93c5 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -295,6 +295,7 @@ struct tegra_pcie {
>  	struct reset_control *afi_rst;
>  	struct reset_control *pcie_xrst;
>  
> +	bool legacy_phy;
>  	struct phy *phy;
>  
>  	struct tegra_msi msi;
> @@ -311,11 +312,14 @@ struct tegra_pcie {
>  
>  struct tegra_pcie_port {
>  	struct tegra_pcie *pcie;
> +	struct device_node *np;
>  	struct list_head list;
>  	struct resource regs;
>  	void __iomem *base;
>  	unsigned int index;
>  	unsigned int lanes;
> +
> +	struct phy **phys;
>  };
>  
>  struct tegra_pcie_bus {
> @@ -860,6 +864,128 @@ static int tegra_pcie_phy_enable(struct tegra_pcie *pcie)
>  	return 0;
>  }
>  
> +static int tegra_pcie_phy_disable(struct tegra_pcie *pcie)
> +{
> +	const struct tegra_pcie_soc_data *soc = pcie->soc_data;
> +	u32 value;
> +
> +	/* disable TX/RX data */
> +	value = pads_readl(pcie, PADS_CTL);
> +	value &= ~(PADS_CTL_TX_DATA_EN_1L | PADS_CTL_RX_DATA_EN_1L);
> +	pads_writel(pcie, value, PADS_CTL);
> +
> +	/* override IDDQ */
> +	value = pads_readl(pcie, PADS_CTL);
> +	value |= PADS_CTL_IDDQ_1L;
> +	pads_writel(pcie, PADS_CTL, value);
> +
> +	/* reset PLL */
> +	value = pads_readl(pcie, soc->pads_pll_ctl);
> +	value &= ~PADS_PLL_CTL_RST_B4SM;
> +	pads_writel(pcie, value, soc->pads_pll_ctl);
> +
> +	usleep_range(20, 100);
> +
> +	return 0;
> +}
> +
> +static int tegra_pcie_port_phy_power_on(struct tegra_pcie_port *port)
> +{
> +	struct device *dev = port->pcie->dev;
> +	unsigned int i;
> +	int err;
> +
> +	for (i = 0; i < port->lanes; i++) {
> +		err = phy_power_on(port->phys[i]);
> +		if (err < 0) {
> +			dev_err(dev, "failed to power on PHY#%u: %d\n", i,
> +				err);
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int tegra_pcie_port_phy_power_off(struct tegra_pcie_port *port)
> +{
> +	struct device *dev = port->pcie->dev;
> +	unsigned int i;
> +	int err;
> +
> +	for (i = 0; i < port->lanes; i++) {
> +		err = phy_power_off(port->phys[i]);
> +		if (err < 0) {
> +			dev_err(dev, "failed to power off PHY#%u: %d\n", i,
> +				err);
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int tegra_pcie_phy_power_on(struct tegra_pcie *pcie)
> +{
> +	struct tegra_pcie_port *port;
> +	int err;
> +
> +	if (pcie->legacy_phy) {
> +		if (pcie->phy)
> +			err = phy_power_on(pcie->phy);
> +		else
> +			err = tegra_pcie_phy_enable(pcie);
> +
> +		if (err < 0)
> +			dev_err(pcie->dev, "failed to power on PHY: %d\n", err);
> +
> +		return err;
> +	}
> +
> +	list_for_each_entry(port, &pcie->ports, list) {
> +		err = tegra_pcie_port_phy_power_on(port);
> +		if (err < 0) {
> +			dev_err(pcie->dev,
> +				"failed to power on PCIe port %u PHY: %d\n",
> +				port->index, err);
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int tegra_pcie_phy_power_off(struct tegra_pcie *pcie)
> +{
> +	struct tegra_pcie_port *port;
> +	int err;
> +
> +	if (pcie->legacy_phy) {
> +		if (pcie->phy)
> +			err = phy_power_on(pcie->phy);

s/phy_power_on/phy_power_off/

> +		else
> +			err = tegra_pcie_phy_disable(pcie);
> +
> +		if (err < 0)
> +			dev_err(pcie->dev, "failed to power off PHY: %d\n",
> +				err);
> +
> +		return err;
> +	}
> +
> +	list_for_each_entry(port, &pcie->ports, list) {
> +		err = tegra_pcie_port_phy_power_off(port);
> +		if (err < 0) {
> +			dev_err(pcie->dev,
> +				"failed to power off PCIe port %u PHY: %d\n",
> +				port->index, err);
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
>  {
>  	const struct tegra_pcie_soc_data *soc = pcie->soc_data;
> @@ -899,13 +1025,9 @@ static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
>  		afi_writel(pcie, value, AFI_FUSE);
>  	}
>  
> -	if (!pcie->phy)
> -		err = tegra_pcie_phy_enable(pcie);
> -	else
> -		err = phy_power_on(pcie->phy);
> -
> +	err = tegra_pcie_phy_power_on(pcie);
>  	if (err < 0) {
> -		dev_err(pcie->dev, "failed to power on PHY: %d\n", err);
> +		dev_err(pcie->dev, "failed to power off PHY(s): %d\n", err);

s/off/on/

>  		return err;
>  	}
>  
> @@ -942,9 +1064,9 @@ static void tegra_pcie_power_off(struct tegra_pcie *pcie)
>  
>  	/* TODO: disable and unprepare clocks? */
>  
> -	err = phy_power_off(pcie->phy);
> +	err = tegra_pcie_phy_power_off(pcie);
>  	if (err < 0)
> -		dev_warn(pcie->dev, "failed to power off PHY: %d\n", err);
> +		dev_err(pcie->dev, "failed to power off PHY(s): %d\n", err);
>  
>  	reset_control_assert(pcie->pcie_xrst);
>  	reset_control_assert(pcie->afi_rst);
> @@ -1049,6 +1171,99 @@ static int tegra_pcie_resets_get(struct tegra_pcie *pcie)
>  	return 0;
>  }
>  
> +static int tegra_pcie_phys_get_legacy(struct tegra_pcie *pcie)
> +{
> +	int err;
> +
> +	pcie->phy = devm_phy_optional_get(pcie->dev, "pcie");
> +	if (IS_ERR(pcie->phy)) {
> +		err = PTR_ERR(pcie->phy);
> +		dev_err(pcie->dev, "failed to get PHY: %d\n", err);
> +		return err;
> +	}
> +
> +	err = phy_init(pcie->phy);
> +	if (err < 0) {
> +		dev_err(pcie->dev, "failed to initialize PHY: %d\n", err);
> +		return err;
> +	}
> +
> +	pcie->legacy_phy = true;
> +
> +	return 0;
> +}
> +
> +static struct phy *devm_of_phy_optional_get_index(struct device *dev,
> +						  struct device_node *np,
> +						  const char *consumer,
> +						  unsigned int index)
> +{
> +	struct phy *phy;
> +	char *name;
> +
> +	name = kasprintf(GFP_KERNEL, "%s-%u", consumer, index);
> +	if (!name)
> +		return ERR_PTR(-ENOMEM);
> +
> +	phy = devm_of_phy_get(dev, np, name);
> +	kfree(name);
> +
> +	if (IS_ERR(phy) && PTR_ERR(phy) == -ENODEV)
> +		phy = NULL;
> +
> +	return phy;
> +}
> +
> +static int tegra_pcie_port_get_phys(struct tegra_pcie_port *port)
> +{
> +	struct device *dev = port->pcie->dev;
> +	struct phy *phy;
> +	unsigned int i;
> +	int err;
> +
> +	port->phys = devm_kcalloc(dev, sizeof(phy), port->lanes, GFP_KERNEL);
> +	if (!port->phys)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < port->lanes; i++) {
> +		phy = devm_of_phy_optional_get_index(dev, port->np, "pcie", i);
> +		if (IS_ERR(phy)) {
> +			dev_err(dev, "failed to get PHY#%u: %ld\n", i,
> +				PTR_ERR(phy));
> +			return PTR_ERR(phy);
> +		}
> +
> +		err = phy_init(phy);
> +		if (err < 0) {
> +			dev_err(dev, "failed to initialize PHY#%u: %d\n", i,
> +				err);
> +			return err;
> +		}
> +
> +		port->phys[i] = phy;
> +	}
> +
> +	return 0;
> +}
> +
> +static int tegra_pcie_phys_get(struct tegra_pcie *pcie)
> +{
> +	struct tegra_pcie_port *port;
> +	int err;
> +
> +	if (of_get_property(pcie->dev->of_node, "phys", NULL) != NULL)
> +		return tegra_pcie_phys_get_legacy(pcie);
> +
> +	list_for_each_entry(port, &pcie->ports, list) {
> +		err = tegra_pcie_port_get_phys(port);
> +		if (err < 0) {
> +			return err;
> +		}
> +	}

This seems backwards: if I'm reading this right, you first check for
the legacy property ("phys") and use it if you find it.  If there is
no legacy property, you look for the new per-lane PHYs.

The usual pattern would be "look for the new stuff, and if you don't
find it, fall back to the old stuff." Is there a configuration that
could be described either way, e.g., something with only one lane and
only one PHY?

I'm not sure whether it matters, but if it *could* use the "new, fall
back to old" pattern, that would be nice and would keep people from
wondering whether it's safe to do it backwards.

> +
> +	return 0;
> +}
> +
>  static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
>  {
>  	struct platform_device *pdev = to_platform_device(pcie->dev);
> @@ -1067,16 +1282,9 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
>  		return err;
>  	}
>  
> -	pcie->phy = devm_phy_optional_get(pcie->dev, "pcie");
> -	if (IS_ERR(pcie->phy)) {
> -		err = PTR_ERR(pcie->phy);
> -		dev_err(&pdev->dev, "failed to get PHY: %d\n", err);
> -		return err;
> -	}
> -
> -	err = phy_init(pcie->phy);
> +	err = tegra_pcie_phys_get(pcie);
>  	if (err < 0) {
> -		dev_err(&pdev->dev, "failed to initialize PHY: %d\n", err);
> +		dev_err(&pdev->dev, "failed to get PHYs: %d\n", err);
>  		return err;
>  	}
>  
> @@ -1752,6 +1960,7 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
>  		rp->index = index;
>  		rp->lanes = value;
>  		rp->pcie = pcie;
> +		rp->np = port;
>  
>  		rp->base = devm_ioremap_resource(pcie->dev, &rp->regs);
>  		if (IS_ERR(rp->base))
> -- 
> 2.8.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
