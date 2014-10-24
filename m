Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42310 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbaJXI4V (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 Oct 2014 04:56:21 -0400
Message-ID: <1414140977.6267.1.camel@pengutronix.de>
Subject: Re: [PATCH V2] PCI: imx6: Wait the clocks to stabilize after ref_en
From: Lucas Stach <l.stach@pengutronix.de>
To: Richard Zhu <richard.zhu@freescale.com>
Cc: linux-pci@vger.kernel.org, shawn.guo@freescale.com,
	festevam@gmail.com, tharvey@gateworks.com, m-karicheri2@ti.com,
	Richard Zhu <r65037@freescale.com>
Date: Fri, 24 Oct 2014 10:56:17 +0200
In-Reply-To: <1414118200-2018-2-git-send-email-richard.zhu@freescale.com>
References: <1414118200-2018-1-git-send-email-richard.zhu@freescale.com>
	 <1414118200-2018-2-git-send-email-richard.zhu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Freitag, den 24.10.2014, 10:36 +0800 schrieb Richard Zhu:
> From: Richard Zhu <r65037@freescale.com>
> 
> For boards without a reset GPIO we skip the delay between enabling the
> pcie_ref_clk and touching the RC registers for configuration.
> This hangs the system if there isn't a proper delay to ensure the clocks
> are settled in the DW PCIe core.
> 
> Also iMX6Q always needs an additional 10us delay to make sure the reset
> is propagated through the core, as we don't have an explicitly
> controlled reset input on this SoC.
> 
> Signed-off-by: Richard Zhu <richard.zhu@freescale.com>
> Tested-by: Tim Harvey <tharvey@gateworks.com>
> Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Acked-by: Lucas Stach <l.stach@pengutronix.de>

Bjorn, please pick this up as a fix for 3.18.

> ---
>  drivers/pci/host/pci-imx6.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index 233fe8a..eac96fb 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -275,15 +275,22 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
>  		goto err_pcie;
>  	}
>  
> -	/* allow the clocks to stabilize */
> -	usleep_range(200, 500);
> -
>  	/* power up core phy and enable ref clock */
>  	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
>  			IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
> +	/*
> +	 * the async reset input need ref clock to sync internally,
> +	 * when the ref clock comes after reset, internal synced
> +	 * reset time is too short , cannot meet the requirement.
> +	 * add one ~10us delay here.
> +	 */
> +	udelay(10);
>  	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
>  			IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
>  
> +	/* allow the clocks to stabilize */
> +	usleep_range(200, 500);
> +
>  	/* Some boards don't have PCIe reset GPIO. */
>  	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
>  		gpio_set_value(imx6_pcie->reset_gpio, 0);

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

