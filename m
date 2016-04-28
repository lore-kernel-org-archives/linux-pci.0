Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51734 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752135AbcD1S4z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 28 Apr 2016 14:56:55 -0400
Date: Thu, 28 Apr 2016 13:56:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/2] PCI: tegra: Support per-lane PHYs
Message-ID: <20160428185646.GC25125@localhost>
References: <1460991105-22861-1-git-send-email-thierry.reding@gmail.com>
 <1460991105-22861-2-git-send-email-thierry.reding@gmail.com>
 <20160428145008.GA15598@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160428145008.GA15598@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 28, 2016 at 09:50:08AM -0500, Bjorn Helgaas wrote:
> On Mon, Apr 18, 2016 at 04:51:45PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > The current XUSB pad controller bindings are insufficient to describe
> > PHY devices attached to USB controllers. New bindings have been created
> > to overcome these restrictions. As a side-effect each root port now is
> > assigned a set of PHY devices, one for each lane associated with the
> > root port. This has the benefit of allowing fine-grained control of the
> > power management for each lane.
> > 
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> How do you want to handle this?  I don't see any other pending tegra
> changes.  If you're going to merge this as part of a larger series,
> maybe there's no benefit in having me pull it into my tree as well.

Never mind, I see your previous mail about you merging them via the
Tegra tree.  So just do that, and if I need to merge any additional
Tegra patches, I can pull your branch first.

> 
> > ---
> > Changes in v5:
> > - fix power off sequence
> > 
> > Changes in v4:
> > - propagate failure from PHY power on
> > - refactor PHY power off sequence
> > 
> > Changes in v3:
> > - cache result of check for new PHY bindings usage (Stephen Warren)
> > 
> > Changes in v2:
> > - rework commit message to more accurately describe this change
> > 
> >  drivers/pci/host/pci-tegra.c | 243 ++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 226 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> > index 68d1f41b3cbf..12d581130645 100644
> > --- a/drivers/pci/host/pci-tegra.c
> > +++ b/drivers/pci/host/pci-tegra.c
> > @@ -295,6 +295,7 @@ struct tegra_pcie {
> >  	struct reset_control *afi_rst;
> >  	struct reset_control *pcie_xrst;
> >  
> > +	bool legacy_phy;
> >  	struct phy *phy;
> >  
> >  	struct tegra_msi msi;
> > @@ -311,11 +312,14 @@ struct tegra_pcie {
> >  
> >  struct tegra_pcie_port {
> >  	struct tegra_pcie *pcie;
> > +	struct device_node *np;
> >  	struct list_head list;
> >  	struct resource regs;
> >  	void __iomem *base;
> >  	unsigned int index;
> >  	unsigned int lanes;
> > +
> > +	struct phy **phys;
> >  };
> >  
> >  struct tegra_pcie_bus {
> > @@ -860,6 +864,128 @@ static int tegra_pcie_phy_enable(struct tegra_pcie *pcie)
> >  	return 0;
> >  }
> >  
> > +static int tegra_pcie_phy_disable(struct tegra_pcie *pcie)
> > +{
> > +	const struct tegra_pcie_soc_data *soc = pcie->soc_data;
> > +	u32 value;
> > +
> > +	/* disable TX/RX data */
> > +	value = pads_readl(pcie, PADS_CTL);
> > +	value &= ~(PADS_CTL_TX_DATA_EN_1L | PADS_CTL_RX_DATA_EN_1L);
> > +	pads_writel(pcie, value, PADS_CTL);
> > +
> > +	/* override IDDQ */
> > +	value = pads_readl(pcie, PADS_CTL);
> > +	value |= PADS_CTL_IDDQ_1L;
> > +	pads_writel(pcie, PADS_CTL, value);
> > +
> > +	/* reset PLL */
> > +	value = pads_readl(pcie, soc->pads_pll_ctl);
> > +	value &= ~PADS_PLL_CTL_RST_B4SM;
> > +	pads_writel(pcie, value, soc->pads_pll_ctl);
> > +
> > +	usleep_range(20, 100);
> > +
> > +	return 0;
> > +}
> > +
> > +static int tegra_pcie_port_phy_power_on(struct tegra_pcie_port *port)
> > +{
> > +	struct device *dev = port->pcie->dev;
> > +	unsigned int i;
> > +	int err;
> > +
> > +	for (i = 0; i < port->lanes; i++) {
> > +		err = phy_power_on(port->phys[i]);
> > +		if (err < 0) {
> > +			dev_err(dev, "failed to power on PHY#%u: %d\n", i,
> > +				err);
> > +			return err;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int tegra_pcie_port_phy_power_off(struct tegra_pcie_port *port)
> > +{
> > +	struct device *dev = port->pcie->dev;
> > +	unsigned int i;
> > +	int err;
> > +
> > +	for (i = 0; i < port->lanes; i++) {
> > +		err = phy_power_off(port->phys[i]);
> > +		if (err < 0) {
> > +			dev_err(dev, "failed to power off PHY#%u: %d\n", i,
> > +				err);
> > +			return err;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int tegra_pcie_phy_power_on(struct tegra_pcie *pcie)
> > +{
> > +	struct tegra_pcie_port *port;
> > +	int err;
> > +
> > +	if (pcie->legacy_phy) {
> > +		if (pcie->phy)
> > +			err = phy_power_on(pcie->phy);
> > +		else
> > +			err = tegra_pcie_phy_enable(pcie);
> > +
> > +		if (err < 0)
> > +			dev_err(pcie->dev, "failed to power on PHY: %d\n", err);
> > +
> > +		return err;
> > +	}
> > +
> > +	list_for_each_entry(port, &pcie->ports, list) {
> > +		err = tegra_pcie_port_phy_power_on(port);
> > +		if (err < 0) {
> > +			dev_err(pcie->dev,
> > +				"failed to power on PCIe port %u PHY: %d\n",
> > +				port->index, err);
> > +			return err;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int tegra_pcie_phy_power_off(struct tegra_pcie *pcie)
> > +{
> > +	struct tegra_pcie_port *port;
> > +	int err;
> > +
> > +	if (pcie->legacy_phy) {
> > +		if (pcie->phy)
> > +			err = phy_power_off(pcie->phy);
> > +		else
> > +			err = tegra_pcie_phy_disable(pcie);
> > +
> > +		if (err < 0)
> > +			dev_err(pcie->dev, "failed to power off PHY: %d\n",
> > +				err);
> > +
> > +		return err;
> > +	}
> > +
> > +	list_for_each_entry(port, &pcie->ports, list) {
> > +		err = tegra_pcie_port_phy_power_off(port);
> > +		if (err < 0) {
> > +			dev_err(pcie->dev,
> > +				"failed to power off PCIe port %u PHY: %d\n",
> > +				port->index, err);
> > +			return err;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
> >  {
> >  	const struct tegra_pcie_soc_data *soc = pcie->soc_data;
> > @@ -899,13 +1025,9 @@ static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
> >  		afi_writel(pcie, value, AFI_FUSE);
> >  	}
> >  
> > -	if (!pcie->phy)
> > -		err = tegra_pcie_phy_enable(pcie);
> > -	else
> > -		err = phy_power_on(pcie->phy);
> > -
> > +	err = tegra_pcie_phy_power_on(pcie);
> >  	if (err < 0) {
> > -		dev_err(pcie->dev, "failed to power on PHY: %d\n", err);
> > +		dev_err(pcie->dev, "failed to power on PHY(s): %d\n", err);
> >  		return err;
> >  	}
> >  
> > @@ -942,9 +1064,9 @@ static void tegra_pcie_power_off(struct tegra_pcie *pcie)
> >  
> >  	/* TODO: disable and unprepare clocks? */
> >  
> > -	err = phy_power_off(pcie->phy);
> > +	err = tegra_pcie_phy_power_off(pcie);
> >  	if (err < 0)
> > -		dev_warn(pcie->dev, "failed to power off PHY: %d\n", err);
> > +		dev_err(pcie->dev, "failed to power off PHY(s): %d\n", err);
> >  
> >  	reset_control_assert(pcie->pcie_xrst);
> >  	reset_control_assert(pcie->afi_rst);
> > @@ -1049,6 +1171,99 @@ static int tegra_pcie_resets_get(struct tegra_pcie *pcie)
> >  	return 0;
> >  }
> >  
> > +static int tegra_pcie_phys_get_legacy(struct tegra_pcie *pcie)
> > +{
> > +	int err;
> > +
> > +	pcie->phy = devm_phy_optional_get(pcie->dev, "pcie");
> > +	if (IS_ERR(pcie->phy)) {
> > +		err = PTR_ERR(pcie->phy);
> > +		dev_err(pcie->dev, "failed to get PHY: %d\n", err);
> > +		return err;
> > +	}
> > +
> > +	err = phy_init(pcie->phy);
> > +	if (err < 0) {
> > +		dev_err(pcie->dev, "failed to initialize PHY: %d\n", err);
> > +		return err;
> > +	}
> > +
> > +	pcie->legacy_phy = true;
> > +
> > +	return 0;
> > +}
> > +
> > +static struct phy *devm_of_phy_optional_get_index(struct device *dev,
> > +						  struct device_node *np,
> > +						  const char *consumer,
> > +						  unsigned int index)
> > +{
> > +	struct phy *phy;
> > +	char *name;
> > +
> > +	name = kasprintf(GFP_KERNEL, "%s-%u", consumer, index);
> > +	if (!name)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	phy = devm_of_phy_get(dev, np, name);
> > +	kfree(name);
> > +
> > +	if (IS_ERR(phy) && PTR_ERR(phy) == -ENODEV)
> > +		phy = NULL;
> > +
> > +	return phy;
> > +}
> > +
> > +static int tegra_pcie_port_get_phys(struct tegra_pcie_port *port)
> > +{
> > +	struct device *dev = port->pcie->dev;
> > +	struct phy *phy;
> > +	unsigned int i;
> > +	int err;
> > +
> > +	port->phys = devm_kcalloc(dev, sizeof(phy), port->lanes, GFP_KERNEL);
> > +	if (!port->phys)
> > +		return -ENOMEM;
> > +
> > +	for (i = 0; i < port->lanes; i++) {
> > +		phy = devm_of_phy_optional_get_index(dev, port->np, "pcie", i);
> > +		if (IS_ERR(phy)) {
> > +			dev_err(dev, "failed to get PHY#%u: %ld\n", i,
> > +				PTR_ERR(phy));
> > +			return PTR_ERR(phy);
> > +		}
> > +
> > +		err = phy_init(phy);
> > +		if (err < 0) {
> > +			dev_err(dev, "failed to initialize PHY#%u: %d\n", i,
> > +				err);
> > +			return err;
> > +		}
> > +
> > +		port->phys[i] = phy;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int tegra_pcie_phys_get(struct tegra_pcie *pcie)
> > +{
> > +	struct tegra_pcie_port *port;
> > +	int err;
> > +
> > +	if (of_get_property(pcie->dev->of_node, "phys", NULL) != NULL)
> > +		return tegra_pcie_phys_get_legacy(pcie);
> > +
> > +	list_for_each_entry(port, &pcie->ports, list) {
> > +		err = tegra_pcie_port_get_phys(port);
> > +		if (err < 0) {
> > +			return err;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
> >  {
> >  	struct platform_device *pdev = to_platform_device(pcie->dev);
> > @@ -1067,16 +1282,9 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
> >  		return err;
> >  	}
> >  
> > -	pcie->phy = devm_phy_optional_get(pcie->dev, "pcie");
> > -	if (IS_ERR(pcie->phy)) {
> > -		err = PTR_ERR(pcie->phy);
> > -		dev_err(&pdev->dev, "failed to get PHY: %d\n", err);
> > -		return err;
> > -	}
> > -
> > -	err = phy_init(pcie->phy);
> > +	err = tegra_pcie_phys_get(pcie);
> >  	if (err < 0) {
> > -		dev_err(&pdev->dev, "failed to initialize PHY: %d\n", err);
> > +		dev_err(&pdev->dev, "failed to get PHYs: %d\n", err);
> >  		return err;
> >  	}
> >  
> > @@ -1752,6 +1960,7 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
> >  		rp->index = index;
> >  		rp->lanes = value;
> >  		rp->pcie = pcie;
> > +		rp->np = port;
> >  
> >  		rp->base = devm_ioremap_resource(pcie->dev, &rp->regs);
> >  		if (IS_ERR(rp->base))
> > -- 
> > 2.8.0
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
