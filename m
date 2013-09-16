Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52922 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300Ab3IPHks (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Sep 2013 03:40:48 -0400
Date: Mon, 16 Sep 2013 09:40:45 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Sean Cross <xobs@kosagi.com>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Zhu Richard-R65037 <r65037@freescale.com>,
	Shawn Guo <shawn.guo@linaro.org>, tharvey@gateworks.com,
	bhelgaas@google.com
Subject: Re: [PATCH v5 3/3] PCI: imx6: Add support for i.MX6 PCIe controller
Message-ID: <20130916074045.GT30088@pengutronix.de>
References: <1379310497-12362-1-git-send-email-xobs@kosagi.com>
 <1379310497-12362-4-git-send-email-xobs@kosagi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1379310497-12362-4-git-send-email-xobs@kosagi.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 16, 2013 at 05:48:17AM +0000, Sean Cross wrote:
> Add support for the PCIe port present on the i.MX6 family of controllers.
> These use the Synopsis Designware core tied to their own PHY.
> 
> diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> index 971356b..d30ff63 100644
> --- a/arch/arm/mach-imx/clk-imx6q.c
> +++ b/arch/arm/mach-imx/clk-imx6q.c
> @@ -623,6 +623,18 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
>  	if (ret)
>  		pr_warn("failed to set up CLKO: %d\n", ret);
>  
> +	/*
> +	 * All existing boards with PCIe use LVDS1
> +	 */
> +	if (IS_ENABLED(CONFIG_PCI_IMX6)) {
> +		clk_set_parent(clk[lvds1_sel], clk[sata_ref]);

This is fine,

> +		clk_prepare_enable(clk[lvds1_gate]);
> +		clk_prepare_enable(clk[pcie_ref_125m]);
> +		clk_prepare_enable(clk[sata_ref_100m]);
> +		clk_prepare_enable(clk[pcie_axi]);

but the clocks should be really enabled in the driver that needs them.

> +static int pcie_phy_poll_ack(void __iomem *dbi_base, int exp_val)
> +{
> +	u32 val;
> +	u32 max_iterations = 10;
> +	u32 wait_counter = 0;
> +
> +	do {
> +		val = readl(dbi_base + PCIE_PHY_STAT);
> +		val = (val >> PCIE_PHY_STAT_ACK_LOC) & 0x1;
> +		wait_counter++;

		if (val == exp_val)
			return 0;

> +		udelay(1);

Avoids the udelay when the value is correct during the first iteration.

> +	} while ((wait_counter < max_iterations) && (val != exp_val));
> +
> +	if (val != exp_val)
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +

...

> +/* Read from the 16-bit PCIe PHY control registers (not memory-mapped) */
> +static int pcie_phy_read(void __iomem *dbi_base, int addr , int *data)
> +{
> +	u32 val, phy_ctl;
> +	int ret;
> +
> +	ret = pcie_phy_wait_ack(dbi_base, addr);
> +	if (ret)
> +		return ret;
> +
> +	/* assert Read signal */
> +	phy_ctl = 0x1 << PCIE_PHY_CTRL_RD_LOC;
> +	writel(phy_ctl, dbi_base + PCIE_PHY_CTRL);
> +
> +	ret = pcie_phy_poll_ack(dbi_base, 1);
> +	if (ret)
> +		return ret;
> +
> +	val = readl(dbi_base + PCIE_PHY_STAT);
> +	*data = (val & (0xffff << PCIE_PHY_STAT_DATA_LOC));

This works because PCIE_PHY_STAT_DATA_LOC is 0. Otherwise you would have
to do:

	*data = (val >> PCIE_PHY_STAT_DATA_LOC) & 0xfff;

I suggest to simply drop the bogus zero bit shift.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
