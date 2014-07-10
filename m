Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52380 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417AbaGJNS2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Jul 2014 09:18:28 -0400
Message-ID: <53BE926A.2070005@ti.com>
Date: Thu, 10 Jul 2014 18:47:30 +0530
From: Kishon Vijay Abraham I <kishon@ti.com>
MIME-Version: 1.0
To: Viresh Kumar <viresh.kumar@linaro.org>, <arnd@linaro.org>,
	<olof@lixom.net>
CC: <linux-arm-kernel@lists.infradead.org>, <spear-devel@list.st.com>,
	<b.zolnierkie@samsung.com>, <bhelgaas@google.com>,
	<mark@nicholnet.com>, <linux-pci@vger.kernel.org>,
	Pratyush Anand <pratyush.anand@st.com>
Subject: Re: [PATCH V9 2/7] phy: Add drivers for PCIe and SATA phy on SPEAr13xx
References: <cover.1404976058.git.viresh.kumar@linaro.org> <d1ef8db8704d09ba4f276c954dc22b555998f957.1404976058.git.viresh.kumar@linaro.org>
In-Reply-To: <d1ef8db8704d09ba4f276c954dc22b555998f957.1404976058.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Thursday 10 July 2014 12:56 PM, Viresh Kumar wrote:
> From: Pratyush Anand <pratyush.anand@st.com>
> 
> ARM based ST Microelectronics's SPEAr1310/40 platforms uses ST's phy (known as
> 'miphy') for PCIe and SATA. This patch adds drivers for these miphys.
> 
> This also adds proper bindings for miphys.
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
> Tested-by: Mohit Kumar <mohit.kumar@st.com>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> [viresh: fixed logs/cclist/checkpatch warnings, broken into smaller patches]
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  .../devicetree/bindings/phy/st-spear1310-miphy.txt |  12 +
>  .../devicetree/bindings/phy/st-spear1340-miphy.txt |  11 +
>  drivers/phy/Kconfig                                |  12 +
>  drivers/phy/Makefile                               |   2 +
>  drivers/phy/phy-spear1310-miphy.c                  | 274 +++++++++++++++++++
>  drivers/phy/phy-spear1340-miphy.c                  | 302 +++++++++++++++++++++

Please send separate patche for each driver.
>  6 files changed, 613 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/st-spear1310-miphy.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/st-spear1340-miphy.txt
>  create mode 100644 drivers/phy/phy-spear1310-miphy.c
>  create mode 100644 drivers/phy/phy-spear1340-miphy.c
> 
> diff --git a/Documentation/devicetree/bindings/phy/st-spear1310-miphy.txt b/Documentation/devicetree/bindings/phy/st-spear1310-miphy.txt
> new file mode 100644
> index 0000000..b9b281a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/st-spear1310-miphy.txt

We generally create a single document for a SoC vendor. So just use st-phy.txt.
> @@ -0,0 +1,12 @@
> +ST SPEAr1310-miphy DT detail
> +===================================
> +
> +SPEAr1310-miphy is a phy controller supporting PCIe and SATA.
> +
> +Required properties:
> +- compatible : should be "st,spear1310-miphy"
> +- reg : offset and length of the PHY register set.
> +- misc: phandle for the syscon node to access misc registers
> +- phy-id: Instance id of the phy.
> +- #phy-cells : from the generic PHY bindings, must be 1.
> +	- cell[1]: 0 if phy used for SATA, 1 for PCIe.
> diff --git a/Documentation/devicetree/bindings/phy/st-spear1340-miphy.txt b/Documentation/devicetree/bindings/phy/st-spear1340-miphy.txt
> new file mode 100644
> index 0000000..7eb5335
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/st-spear1340-miphy.txt

use st-phy.txt for this.
> @@ -0,0 +1,11 @@
> +ST SPEAr1340-miphy DT detail
> +===================================
> +
> +SPEAr1340-miphy is a phy controller supporting PCIe and SATA.
> +
> +Required properties:
> +- compatible : should be "st,spear1340-miphy"
> +- reg : offset and length of the PHY register set.
> +- misc: phandle for the syscon node to access misc registers
> +- #phy-cells : from the generic PHY bindings, must be 1.
> +	- cell[1]: 0 if phy used for SATA, 1 for PCIe.
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 16a2f06..e8f8a2d 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -178,4 +178,16 @@ config PHY_XGENE
>  	help
>  	  This option enables support for APM X-Gene SoC multi-purpose PHY.
>  
..
<snip>
.
.

> +
> +static int spear1340_miphy_sata_init(struct spear1340_miphy_priv *priv)
> +{
> +	regmap_update_bits(priv->misc, SPEAR1340_PCIE_SATA_CFG,
> +			   SPEAR1340_PCIE_SATA_CFG_MASK,
> +			   SPEAR1340_SATA_CFG_VAL);
> +	regmap_update_bits(priv->misc, SPEAR1340_PCIE_MIPHY_CFG,
> +			   SPEAR1340_PCIE_MIPHY_CFG_MASK,
> +			   SPEAR1340_PCIE_SATA_MIPHY_CFG_SATA_25M_CRYSTAL_CLK);
> +	/* Switch on sata power domain */
> +	regmap_update_bits(priv->misc, SPEAR1340_PCM_CFG,
> +			   SPEAR1340_PCM_CFG_SATA_POWER_EN,
> +			   SPEAR1340_PCM_CFG_SATA_POWER_EN);
> +	msleep(20);
> +	/* Disable PCIE SATA Controller reset */
> +	regmap_update_bits(priv->misc, SPEAR1340_PERIP1_SW_RST,
> +			   SPEAR1340_PERIP1_SW_RSATA, 0);
> +	msleep(20);

Please add a comment for all delays added.
> +
> +	return 0;
> +}
> +
> +static int spear1340_miphy_sata_exit(struct spear1340_miphy_priv *priv)
> +{
> +	regmap_update_bits(priv->misc, SPEAR1340_PCIE_SATA_CFG,
> +			   SPEAR1340_PCIE_SATA_CFG_MASK, 0);
> +	regmap_update_bits(priv->misc, SPEAR1340_PCIE_MIPHY_CFG,
> +			   SPEAR1340_PCIE_MIPHY_CFG_MASK, 0);
> +
> +	/* Enable PCIE SATA Controller reset */
> +	regmap_update_bits(priv->misc, SPEAR1340_PERIP1_SW_RST,
> +			   SPEAR1340_PERIP1_SW_RSATA,
> +			   SPEAR1340_PERIP1_SW_RSATA);
> +	msleep(20);
> +	/* Switch off sata power domain */
> +	regmap_update_bits(priv->misc, SPEAR1340_PCM_CFG,
> +			   SPEAR1340_PCM_CFG_SATA_POWER_EN, 0);
> +	msleep(20);
ditto.
> +
> +	return 0;
> +}
> +
> +static int spear1340_miphy_pcie_init(struct spear1340_miphy_priv *priv)
> +{
> +	regmap_update_bits(priv->misc, SPEAR1340_PCIE_MIPHY_CFG,
> +			   SPEAR1340_PCIE_MIPHY_CFG_MASK,
> +			   SPEAR1340_PCIE_SATA_MIPHY_CFG_PCIE);
> +	regmap_update_bits(priv->misc, SPEAR1340_PCIE_SATA_CFG,
> +			   SPEAR1340_PCIE_SATA_CFG_MASK,
> +			   SPEAR1340_PCIE_CFG_VAL);
> +
> +	return 0;
> +}
> +
> +static int spear1340_miphy_pcie_exit(struct spear1340_miphy_priv *priv)
> +{
> +	regmap_update_bits(priv->misc, SPEAR1340_PCIE_MIPHY_CFG,
> +			   SPEAR1340_PCIE_MIPHY_CFG_MASK, 0);
> +	regmap_update_bits(priv->misc, SPEAR1340_PCIE_SATA_CFG,
> +			   SPEAR1340_PCIE_SATA_CFG_MASK, 0);
> +
> +	return 0;
> +}
> +
> +static int spear1340_miphy_init(struct phy *phy)
> +{
> +	struct spear1340_miphy_priv *priv = phy_get_drvdata(phy);
> +	int ret = 0;
> +
> +	if (priv->mode == SATA)
> +		ret = spear1340_miphy_sata_init(priv);
> +	else if (priv->mode == PCIE)
> +		ret = spear1340_miphy_pcie_init(priv);
> +
> +	return ret;
> +}
> +
> +static int spear1340_miphy_exit(struct phy *phy)
> +{
> +	struct spear1340_miphy_priv *priv = phy_get_drvdata(phy);
> +	int ret = 0;
> +
> +	if (priv->mode == SATA)
> +		ret = spear1340_miphy_sata_exit(priv);
> +	else if (priv->mode == PCIE)
> +		ret = spear1340_miphy_pcie_exit(priv);
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id spear1340_miphy_of_match[] = {
> +	{ .compatible = "st,spear1340-miphy" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, spear1340_miphy_of_match);
> +
> +static struct phy_ops spear1340_miphy_ops = {
> +	.init = spear1340_miphy_init,
> +	.exit = spear1340_miphy_exit,
> +	.owner = THIS_MODULE,
> +};
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int spear1340_miphy_suspend(struct device *dev)
> +{
> +	struct spear1340_miphy_priv *priv = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	if (priv->mode == SATA)
> +		ret = spear1340_miphy_sata_exit(priv);

Shouldn't this be spear1340_miphy_init()?
> +
> +	return ret;
> +}
> +
> +static int spear1340_miphy_resume(struct device *dev)
> +{
> +	struct spear1340_miphy_priv *priv = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	if (priv->mode == SATA)
> +		ret = spear1340_miphy_sata_init(priv);

And here spear1340_miphy_exit()? Why only for sata phys?
> +
> +	return ret;
> +}

Thanks
Kishon
