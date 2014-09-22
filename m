Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53192 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753799AbaIVMGv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Sep 2014 08:06:51 -0400
Message-ID: <1411387607.2599.7.camel@pengutronix.de>
Subject: Re: [PATCH v1 1/4] PCI: imx6: enable pcie on imx6qdl sabreauto
From: Lucas Stach <l.stach@pengutronix.de>
To: Richard Zhu <r65037@freescale.com>
Cc: linux-pci-owner@vger.kernel.org, linux-pci@vger.kernel.org,
	shawn.guo@freescale.com, festevam@gmail.com
Date: Mon, 22 Sep 2014 14:06:47 +0200
In-Reply-To: <1411382705-15301-2-git-send-email-r65037@freescale.com>
References: <1411382705-15301-1-git-send-email-r65037@freescale.com>
	 <1411382705-15301-2-git-send-email-r65037@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Montag, den 22.09.2014, 18:45 +0800 schrieb Richard Zhu:
> - enable pcie on imx6qdl sabreauto boards.
> - wait the clocks to stabilize after the pcie_ref_en
> (IMX6Q_GPR1_PCIE_REF_CLK_EN) is set.
> 

Those are two completely independent changes, even if you enable/fix a
specific board with those. So please split into DT changes (to be merged
by Shawn) and PCI changes (to be merged by Bjorn).

> Signed-off-by: Richard Zhu <r65037@freescale.com>
> ---
>  arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 4 ++++
>  drivers/pci/host/pci-imx6.c              | 6 +++---
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> index 009abd6..d6040a5 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> @@ -410,6 +410,10 @@
>  	};
>  };
>  
> +&pcie {
> +	status = "okay";
> +};
> +
>  &pwm3 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_pwm3>;
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index 233fe8a..bc4222b 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -275,15 +275,15 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
>  		goto err_pcie;
>  	}
>  
> -	/* allow the clocks to stabilize */
> -	usleep_range(200, 500);
> -
>  	/* power up core phy and enable ref clock */
>  	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
>  			IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
>  	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
>  			IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
>  
> +	/* allow the clocks to stabilize */
> +	usleep_range(200, 500);
> +
>  	/* Some boards don't have PCIe reset GPIO. */
>  	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
>  		gpio_set_value(imx6_pcie->reset_gpio, 0);

Are you fixing a specific issue with this? Otherwise this change doesn't
look good to me. The reference manual states that the clock must be
stable before enabling the REF_CLK_EN bit in GPR1. So moving the delay
without proof that it doesn't have adverse effects and without a good
justification seems wrong.

If this fixes a specific issue please mention it in the commit message.
Also I would like at least a confirmation from Tim Harvey that this
doesn't regress his setup. So please take him on CC for the next version
of this patch.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

