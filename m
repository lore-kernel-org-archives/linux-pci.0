Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:42967 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbaIERcV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 5 Sep 2014 13:32:21 -0400
Received: by mail-pa0-f45.google.com with SMTP id bj1so22451561pad.4
        for <linux-pci@vger.kernel.org>; Fri, 05 Sep 2014 10:32:21 -0700 (PDT)
Date: Fri, 5 Sep 2014 11:32:16 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: l.stach@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
	shawn.guo@freescale.com, marex@denx.de, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: imx6: fix occasional link failure
Message-ID: <20140905173216.GB8080@google.com>
References: <1407479800-6730-1-git-send-email-tharvey@gateworks.com>
 <1409717077-26662-1-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1409717077-26662-1-git-send-email-tharvey@gateworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 02, 2014 at 09:04:37PM -0700, Tim Harvey wrote:
> According to the IMX6 reference manuals, REF_SSP_EN (Reference clock enable
> for SS function) must remain deasserted until the reference clock is running
> at the appropriate frequency.
> 
> Without this patch we find a high link failure rate (>5%) on certain
> IMX6 boards at various temperatures.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Tested-by: Fabio Estevam <festevam@gmail.com>
> Acked-by: Marek Vasut <marex@denx.de>

I'm looking for the comment update requested by Richard, and an ack from
Richard and/or Lucas.  Also, please add the stable tag if you want it
(see Documentation/stable_kernel_rules.txt for details).

Bjorn

> ---
> 
> v2:
>  - added Tested-by Fabio Estevam
>  - added Acked-by Marek Vasut
> 
> ---
>  drivers/pci/host/pci-imx6.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index 1be6073..9b6bab9 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -256,11 +256,6 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
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
>  		dev_err(pp->dev, "unable to enable pcie_phy clock\n");
> @@ -282,6 +277,12 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
>  	/* allow the clocks to stabilize */
>  	usleep_range(200, 500);
>  
> +	/* power up core phy and enable ref clock */
> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +			IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +			IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
> +
>  	/* Some boards don't have PCIe reset GPIO. */
>  	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
>  		gpio_set_value(imx6_pcie->reset_gpio, 0);
> -- 
> 1.8.3.2
> 
