Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:51065 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932994AbaJ2QUI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Oct 2014 12:20:08 -0400
Received: by mail-ie0-f169.google.com with SMTP id tr6so3354431ieb.14
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2014 09:20:08 -0700 (PDT)
Date: Wed, 29 Oct 2014 10:20:05 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Richard Zhu <richard.zhu@freescale.com>
Cc: linux-pci@vger.kernel.org, shawn.guo@freescale.com,
	festevam@gmail.com, l.stach@pengutronix.de, tharvey@gateworks.com,
	m-karicheri2@ti.com, Richard Zhu <r65037@freescale.com>
Subject: Re: [PATCH V3] PCI: imx6: Wait the clocks to stabilize after ref_en
Message-ID: <20141029162005.GC12090@google.com>
References: <1414387052-3582-1-git-send-email-richard.zhu@freescale.com>
 <1414387052-3582-2-git-send-email-richard.zhu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1414387052-3582-2-git-send-email-richard.zhu@freescale.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 27, 2014 at 01:17:32PM +0800, Richard Zhu wrote:
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
> Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
> Acked-by: Lucas Stach <l.stach@pengutronix.de>

I added the regression info to the changelog and applied this to for-linus
for v3.18, thanks!

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
> -- 
> 1.9.1
> 
