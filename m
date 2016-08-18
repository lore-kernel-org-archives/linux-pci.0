Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754391AbcHSClO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Aug 2016 22:41:14 -0400
Date: Thu, 18 Aug 2016 15:44:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: tegra: Remove redundant _data suffix
Message-ID: <20160818204431.GM27353@localhost>
References: <20160815153132.520-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160815153132.520-1-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 15, 2016 at 05:31:31PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The struct tegra_pcie_soc_data represents SoC-specific data. The shorter
> name tegra_pcie_soc already describes that accurately enough, so the
> extra five characters are redundant. Also remove the suffix from various
> variable names to shorten the code a little.
> 
> This also makes this driver more consistent with the naming used in
> other drivers that use a similar mechanism to differentiate between
> various SoC generations.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Applied to pci/host-tegra for v4.9, thanks!

> ---
>  drivers/pci/host/pci-tegra.c | 42 +++++++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 6de0757b11e4..7756a792600c 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -240,7 +240,7 @@ struct tegra_msi {
>  };
>  
>  /* used to differentiate between Tegra SoC generations */
> -struct tegra_pcie_soc_data {
> +struct tegra_pcie_soc {
>  	unsigned int num_ports;
>  	unsigned int msi_base_shift;
>  	u32 pads_pll_ctl;
> @@ -300,7 +300,7 @@ struct tegra_pcie {
>  	struct regulator_bulk_data *supplies;
>  	unsigned int num_supplies;
>  
> -	const struct tegra_pcie_soc_data *soc_data;
> +	const struct tegra_pcie_soc *soc;
>  	struct dentry *debugfs;
>  };
>  
> @@ -542,8 +542,8 @@ static void tegra_pcie_port_reset(struct tegra_pcie_port *port)
>  
>  static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
>  {
> -	const struct tegra_pcie_soc_data *soc = port->pcie->soc_data;
>  	unsigned long ctrl = tegra_pcie_port_get_pex_ctrl(port);
> +	const struct tegra_pcie_soc *soc = port->pcie->soc;
>  	unsigned long value;
>  
>  	/* enable reference clock */
> @@ -562,8 +562,8 @@ static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
>  
>  static void tegra_pcie_port_disable(struct tegra_pcie_port *port)
>  {
> -	const struct tegra_pcie_soc_data *soc = port->pcie->soc_data;
>  	unsigned long ctrl = tegra_pcie_port_get_pex_ctrl(port);
> +	const struct tegra_pcie_soc *soc = port->pcie->soc;
>  	unsigned long value;
>  
>  	/* assert port reset */
> @@ -774,7 +774,7 @@ static void tegra_pcie_setup_translations(struct tegra_pcie *pcie)
>  
>  static int tegra_pcie_pll_wait(struct tegra_pcie *pcie, unsigned long timeout)
>  {
> -	const struct tegra_pcie_soc_data *soc = pcie->soc_data;
> +	const struct tegra_pcie_soc *soc = pcie->soc;
>  	u32 value;
>  
>  	timeout = jiffies + msecs_to_jiffies(timeout);
> @@ -790,7 +790,7 @@ static int tegra_pcie_pll_wait(struct tegra_pcie *pcie, unsigned long timeout)
>  
>  static int tegra_pcie_phy_enable(struct tegra_pcie *pcie)
>  {
> -	const struct tegra_pcie_soc_data *soc = pcie->soc_data;
> +	const struct tegra_pcie_soc *soc = pcie->soc;
>  	u32 value;
>  	int err;
>  
> @@ -845,7 +845,7 @@ static int tegra_pcie_phy_enable(struct tegra_pcie *pcie)
>  
>  static int tegra_pcie_phy_disable(struct tegra_pcie *pcie)
>  {
> -	const struct tegra_pcie_soc_data *soc = pcie->soc_data;
> +	const struct tegra_pcie_soc *soc = pcie->soc;
>  	u32 value;
>  
>  	/* disable TX/RX data */
> @@ -906,7 +906,7 @@ static int tegra_pcie_port_phy_power_off(struct tegra_pcie_port *port)
>  
>  static int tegra_pcie_phy_power_on(struct tegra_pcie *pcie)
>  {
> -	const struct tegra_pcie_soc_data *soc = pcie->soc_data;
> +	const struct tegra_pcie_soc *soc = pcie->soc;
>  	struct tegra_pcie_port *port;
>  	int err;
>  
> @@ -974,7 +974,7 @@ static int tegra_pcie_phy_power_off(struct tegra_pcie *pcie)
>  
>  static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
>  {
> -	const struct tegra_pcie_soc_data *soc = pcie->soc_data;
> +	const struct tegra_pcie_soc *soc = pcie->soc;
>  	struct tegra_pcie_port *port;
>  	unsigned long value;
>  	int err;
> @@ -1067,7 +1067,7 @@ static void tegra_pcie_power_off(struct tegra_pcie *pcie)
>  
>  static int tegra_pcie_power_on(struct tegra_pcie *pcie)
>  {
> -	const struct tegra_pcie_soc_data *soc = pcie->soc_data;
> +	const struct tegra_pcie_soc *soc = pcie->soc;
>  	int err;
>  
>  	reset_control_assert(pcie->pcie_xrst);
> @@ -1117,7 +1117,7 @@ static int tegra_pcie_power_on(struct tegra_pcie *pcie)
>  
>  static int tegra_pcie_clocks_get(struct tegra_pcie *pcie)
>  {
> -	const struct tegra_pcie_soc_data *soc = pcie->soc_data;
> +	const struct tegra_pcie_soc *soc = pcie->soc;
>  
>  	pcie->pex_clk = devm_clk_get(pcie->dev, "pex");
>  	if (IS_ERR(pcie->pex_clk))
> @@ -1234,7 +1234,7 @@ static int tegra_pcie_port_get_phys(struct tegra_pcie_port *port)
>  
>  static int tegra_pcie_phys_get(struct tegra_pcie *pcie)
>  {
> -	const struct tegra_pcie_soc_data *soc = pcie->soc_data;
> +	const struct tegra_pcie_soc *soc = pcie->soc;
>  	struct device_node *np = pcie->dev->of_node;
>  	struct tegra_pcie_port *port;
>  	int err;
> @@ -1486,7 +1486,7 @@ static const struct irq_domain_ops msi_domain_ops = {
>  static int tegra_pcie_enable_msi(struct tegra_pcie *pcie)
>  {
>  	struct platform_device *pdev = to_platform_device(pcie->dev);
> -	const struct tegra_pcie_soc_data *soc = pcie->soc_data;
> +	const struct tegra_pcie_soc *soc = pcie->soc;
>  	struct tegra_msi *msi = &pcie->msi;
>  	unsigned long base;
>  	int err;
> @@ -1799,8 +1799,8 @@ static int tegra_pcie_get_regulators(struct tegra_pcie *pcie, u32 lane_mask)
>  
>  static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
>  {
> -	const struct tegra_pcie_soc_data *soc = pcie->soc_data;
>  	struct device_node *np = pcie->dev->of_node, *port;
> +	const struct tegra_pcie_soc *soc = pcie->soc;
>  	struct of_pci_range_parser parser;
>  	struct of_pci_range range;
>  	u32 lanes = 0, mask = 0;
> @@ -2043,7 +2043,7 @@ static int tegra_pcie_enable(struct tegra_pcie *pcie)
>  	return 0;
>  }
>  
> -static const struct tegra_pcie_soc_data tegra20_pcie_data = {
> +static const struct tegra_pcie_soc tegra20_pcie = {
>  	.num_ports = 2,
>  	.msi_base_shift = 0,
>  	.pads_pll_ctl = PADS_PLL_CTL_TEGRA20,
> @@ -2056,7 +2056,7 @@ static const struct tegra_pcie_soc_data tegra20_pcie_data = {
>  	.has_gen2 = false,
>  };
>  
> -static const struct tegra_pcie_soc_data tegra30_pcie_data = {
> +static const struct tegra_pcie_soc tegra30_pcie = {
>  	.num_ports = 3,
>  	.msi_base_shift = 8,
>  	.pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
> @@ -2070,7 +2070,7 @@ static const struct tegra_pcie_soc_data tegra30_pcie_data = {
>  	.has_gen2 = false,
>  };
>  
> -static const struct tegra_pcie_soc_data tegra124_pcie_data = {
> +static const struct tegra_pcie_soc tegra124_pcie = {
>  	.num_ports = 2,
>  	.msi_base_shift = 8,
>  	.pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
> @@ -2084,9 +2084,9 @@ static const struct tegra_pcie_soc_data tegra124_pcie_data = {
>  };
>  
>  static const struct of_device_id tegra_pcie_of_match[] = {
> -	{ .compatible = "nvidia,tegra124-pcie", .data = &tegra124_pcie_data },
> -	{ .compatible = "nvidia,tegra30-pcie", .data = &tegra30_pcie_data },
> -	{ .compatible = "nvidia,tegra20-pcie", .data = &tegra20_pcie_data },
> +	{ .compatible = "nvidia,tegra124-pcie", .data = &tegra124_pcie },
> +	{ .compatible = "nvidia,tegra30-pcie", .data = &tegra30_pcie },
> +	{ .compatible = "nvidia,tegra20-pcie", .data = &tegra20_pcie },
>  	{ },
>  };
>  
> @@ -2215,7 +2215,7 @@ static int tegra_pcie_probe(struct platform_device *pdev)
>  
>  	INIT_LIST_HEAD(&pcie->buses);
>  	INIT_LIST_HEAD(&pcie->ports);
> -	pcie->soc_data = match->data;
> +	pcie->soc = match->data;
>  	pcie->dev = &pdev->dev;
>  
>  	err = tegra_pcie_parse_dt(pcie);
> -- 
> 2.9.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
