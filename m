Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57438 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905AbaIVJgU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Sep 2014 05:36:20 -0400
Message-ID: <1411378576.2599.3.camel@pengutronix.de>
Subject: Re: [PATCH RFC 1/2] PCI: imx6: enable pcie on imx6qdl sabresd and
 sabreauto
From: Lucas Stach <l.stach@pengutronix.de>
To: Richard Zhu <r65037@freescale.com>
Cc: linux-pci-owner@vger.kernel.org, stable@vger.kernel.org,
	linux-pci@vger.kernel.org
Date: Mon, 22 Sep 2014 11:36:16 +0200
In-Reply-To: <1411376498-14653-2-git-send-email-r65037@freescale.com>
References: <1411376498-14653-1-git-send-email-r65037@freescale.com>
	 <1411376498-14653-2-git-send-email-r65037@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Montag, den 22.09.2014, 17:01 +0800 schrieb Richard Zhu:
> - enable pcie support on imx6qdl sabresd and asbreauto boards.
> - sabresd board has the pcie power on and reset gpios, but
> sabreauto doesn't have these two gpios.
> 
> Signed-off-by: Richard Zhu <r65037@freescale.com>
> ---
>  arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 4 ++++
>  arch/arm/boot/dts/imx6qdl-sabresd.dtsi   | 2 ++
>  2 files changed, 6 insertions(+)
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
> diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> index ec43dde..c2d3224 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> @@ -396,6 +396,7 @@
>  
>  		pinctrl_pcie: pciegrp {
>  			fsl,pins = <
> +				MX6QDL_PAD_EIM_D19__GPIO3_IO19	0x80000000
>  				MX6QDL_PAD_GPIO_17__GPIO7_IO12	0x80000000
>  			>;
>  		};
> @@ -502,6 +503,7 @@
>  &pcie {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_pcie>;
> +	power-on-gpio = <&gpio3 19 0>;
>  	reset-gpio = <&gpio7 12 0>;
>  	status = "okay";
>  };

This hunk is wrong. There is no "power-on-gpio" in the binding anymore.
Also there is already a change in Shawns tree to model this as a
always-on regulator. If we really want to control pci bus power this
needs to be done through this regulator, not some arbitrary gpio hack.

Also I don't see why this would be stable material.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

