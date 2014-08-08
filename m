Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1blp0181.outbound.protection.outlook.com ([207.46.163.181]:5572
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753781AbaHHIEX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 8 Aug 2014 04:04:23 -0400
From: "Hong-Xing.Zhu@freescale.com" <Hong-Xing.Zhu@freescale.com>
To: Tim Harvey <tharvey@gateworks.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>
CC: Fabio Estevam <festevam@gmail.com>,
	Shawn Guo <Shawn.Guo@freescale.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"marex@denx.de" <marex@denx.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH] PCI: imx6: fix occasional link failure
Date: Fri, 8 Aug 2014 08:04:18 +0000
Message-ID: <b5b3f50464b641f89a8f7809ccbe6346@DM2PR0301MB0862.namprd03.prod.outlook.com>
References: <1407479800-6730-1-git-send-email-tharvey@gateworks.com>
In-Reply-To: <1407479800-6730-1-git-send-email-tharvey@gateworks.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Tim:

> -----Original Message-----
> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-owner@vger.kernel.org]
> On Behalf Of Tim Harvey
> Sent: Friday, August 08, 2014 2:37 PM
> To: l.stach@pengutronix.de
> Cc: Fabio Estevam; Guo Shawn-R65073; stable@vger.kernel.org; marex@denx.de;
> bhelgaas@google.com; linux-pci@vger.kernel.org
> Subject: [PATCH] PCI: imx6: fix occasional link failure
> 
> According to the IMX6 reference manuals, REF_SSP_EN (Reference clock enable
> for SS function) must remain deasserted until the reference clock is running
> at the appropriate frequency.
> 
> Without this patch we find a high link failure rate (>5%) on certain
> IMX6 boards at various temperatures.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  drivers/pci/host/pci-imx6.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c index
> 1be6073..9b6bab9 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -256,11 +256,6 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port
> *pp)
>  	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
>  	int ret;
> 
> -	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -			IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
> -	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -			IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
> -
>  	ret = clk_prepare_enable(imx6_pcie->pcie_phy);
>  	if (ret) {
>  		dev_err(pp->dev, "unable to enable pcie_phy clock\n"); @@ -282,6
> +277,12 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
>  	/* allow the clocks to stabilize */
>  	usleep_range(200, 500);
> 
> +	/* power up core phy and enable ref clock */
> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +			IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +			IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
> +

[Richard] It's better add some comments into the codes, why
Enable_pcie_clock should be placed before ssp_en is set.
For example:
    - enable_pcie_clock should be call before ssp_en is set,
      since that ssp_en control the phy_ref clk gate, turn on
      it after the source of the pcie clks are stable.

Best Regards
Richard Zhu

>  	/* Some boards don't have PCIe reset GPIO. */
>  	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
>  		gpio_set_value(imx6_pcie->reset_gpio, 0);
> --
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
