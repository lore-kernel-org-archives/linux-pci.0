Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60417 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000AbaI2J45 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Sep 2014 05:56:57 -0400
Message-ID: <1411984613.2625.9.camel@pengutronix.de>
Subject: Re: [PATCH v3 2/9] PCI: imx6: enable pcie on imx6qdl sabreauto
From: Lucas Stach <l.stach@pengutronix.de>
To: Richard Zhu <r65037@freescale.com>
Cc: linux-pci-owner@vger.kernel.org, linux-pci@vger.kernel.org,
	shawn.guo@freescale.com, festevam@gmail.com, tharvey@gateworks.com
Date: Mon, 29 Sep 2014 11:56:53 +0200
In-Reply-To: <1411966997-27118-3-git-send-email-r65037@freescale.com>
References: <1411966997-27118-1-git-send-email-r65037@freescale.com>
	 <1411966997-27118-3-git-send-email-r65037@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Montag, den 29.09.2014, 13:03 +0800 schrieb Richard Zhu:
> - enable pcie on imx6qdl sabreauto boards.
> 
> Signed-off-by: Richard Zhu <r65037@freescale.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
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

The dts changes have a wrong prefix. They are not PCI subsystem patches,
but arch patches for i.MX and should be applied by Shawn. So prefix
needs to be ARM: imx6XX: ...

Also I would recommend that you sort them to the end of the series so
make it easy for Bjorn and Shawn to see where the slit between the two
is. Don't intermix those changes in the series, it certainly isn't
needed here.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

