Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56594 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbaIWJTo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Sep 2014 05:19:44 -0400
Message-ID: <1411463981.3256.5.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/5] PCI: imx6: enable pcie on imx6qdl sabreauto
From: Lucas Stach <l.stach@pengutronix.de>
To: Richard Zhu <r65037@freescale.com>
Cc: linux-pci-owner@vger.kernel.org, linux-pci@vger.kernel.org,
	shawn.guo@freescale.com, festevam@gmail.com, tharvey@gateworks.com
Date: Tue, 23 Sep 2014 11:19:41 +0200
In-Reply-To: <1411445498-20250-2-git-send-email-r65037@freescale.com>
References: <1411445498-20250-1-git-send-email-r65037@freescale.com>
	 <1411445498-20250-2-git-send-email-r65037@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Dienstag, den 23.09.2014, 12:11 +0800 schrieb Richard Zhu:
> - enable pcie on imx6qdl sabreauto boards.
> 
> Signed-off-by: Richard Zhu <r65037@freescale.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
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

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

