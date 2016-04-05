Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35443 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753172AbcDERHM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 5 Apr 2016 13:07:12 -0400
Date: Tue, 5 Apr 2016 12:07:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 2/2] PCI: tegra: Support per-lane PHYs
Message-ID: <20160405170707.GA12135@localhost>
References: <1457452094-5409-1-git-send-email-thierry.reding@gmail.com>
 <1457452094-5409-2-git-send-email-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1457452094-5409-2-git-send-email-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Thierry,

On Tue, Mar 08, 2016 at 04:48:14PM +0100, Thierry Reding wrote:
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

There are two open questions here (mine and Stephen's).  I'll drop
this and look for a v4.

> ---
> Changes in v3:
> - cache result of check for new PHY bindings usage (Stephen Warren)
> 
> Changes in v2:
> - rework commit message to more accurately describe this change
> 
>  drivers/pci/host/pci-tegra.c | 151 ++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 135 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 75c55265ca73..3b59e3162dfa 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -290,6 +290,7 @@ struct tegra_pcie {
>  	struct reset_control *afi_rst;
>  	struct reset_control *pcie_xrst;
>  
> +	bool legacy_phy;
>  	struct phy *phy;
>  
>  	struct tegra_msi msi;
> @@ -307,11 +308,14 @@ struct tegra_pcie {
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
> @@ -844,6 +848,24 @@ static int tegra_pcie_phy_enable(struct tegra_pcie *pcie)
>  	return 0;
>  }
>  
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
>  static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
>  {
>  	const struct tegra_pcie_soc_data *soc = pcie->soc_data;
> @@ -883,14 +905,24 @@ static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
>  		afi_writel(pcie, value, AFI_FUSE);
>  	}
>  
> -	if (!pcie->phy)
> -		err = tegra_pcie_phy_enable(pcie);
> -	else
> -		err = phy_power_on(pcie->phy);
> +	if (!pcie->legacy_phy) {
> +		list_for_each_entry(port, &pcie->ports, list) {
> +			err = tegra_pcie_port_phy_power_on(port);
> +			if (err < 0) {
> +				dev_err(pcie->dev,
> +					"failed to power on PCIe port: %d\n",
> +					err);
> +				return err;
> +			}
> +		}
> +	} else {
> +		if (!pcie->phy)
> +			err = tegra_pcie_phy_enable(pcie);
> +		else
> +			err = phy_power_on(pcie->phy);
>  
> -	if (err < 0) {
> -		dev_err(pcie->dev, "failed to power on PHY: %d\n", err);
> -		return err;
> +		if (err < 0)
> +			dev_err(pcie->dev, "failed to power on PHY: %d\n", err);
>  	}
>  
>  	/* take the PCIe interface module out of reset */
> @@ -1033,6 +1065,99 @@ static int tegra_pcie_resets_get(struct tegra_pcie *pcie)
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
> +
> +	return 0;
> +}
> +
>  static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
>  {
>  	struct platform_device *pdev = to_platform_device(pcie->dev);
> @@ -1051,16 +1176,9 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
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
> @@ -1725,6 +1843,7 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
>  		rp->index = index;
>  		rp->lanes = value;
>  		rp->pcie = pcie;
> +		rp->np = port;
>  
>  		rp->base = devm_ioremap_resource(pcie->dev, &rp->regs);
>  		if (IS_ERR(rp->base))
> -- 
> 2.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
