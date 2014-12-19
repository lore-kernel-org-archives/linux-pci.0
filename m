Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49395 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052AbaLSKdM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Dec 2014 05:33:12 -0500
Message-ID: <1418985179.2558.3.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] ARM: dts: imx6q: add Novena board
From: Lucas Stach <l.stach@pengutronix.de>
To: Sean Cross <xobs@kosagi.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Shawn Guo <shawn.guo@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	devicetree@vger.kernel.org, Richard Zhu <r65037@freescale.com>,
	Grant Likely <grant.likely@linaro.org>,
	linux-pci@vger.kernel.org, bunnie@kosagi.com
Date: Fri, 19 Dec 2014 11:32:59 +0100
In-Reply-To: <1418976617-833-3-git-send-email-xobs@kosagi.com>
References: <1418976617-833-1-git-send-email-xobs@kosagi.com>
	 <1418976617-833-3-git-send-email-xobs@kosagi.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Freitag, den 19.12.2014, 16:10 +0800 schrieb Sean Cross:
> Novena is an open-hardware laptop/desktop/bare board.
> 
> See http://www.kosagi.com/w/index.php?title=Novena_Main_Page
> 
> This device tree contains additional nodes for FPGA support.
> 

I only skimmed the DT for now.

There are lots of occurrences of the "kosagi" vendor prefix, which is is
not documented right now. Please add it to
Documentation/devicetree/bindings/vendor-prefixes.txt first.

> Signed-off-by: Sean Cross <xobs@kosagi.com>
> ---
>  arch/arm/boot/dts/Makefile         |   1 +
>  arch/arm/boot/dts/imx6q-novena.dts | 893 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 894 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6q-novena.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 38c89ca..b2b4770 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -234,6 +234,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
>  	imx6q-gw552x.dtb \
>  	imx6q-hummingboard.dtb \
>  	imx6q-nitrogen6x.dtb \
> +	imx6q-novena.dtb \
>  	imx6q-phytec-pbab01.dtb \
>  	imx6q-rex-pro.dtb \
>  	imx6q-sabreauto.dtb \
> diff --git a/arch/arm/boot/dts/imx6q-novena.dts b/arch/arm/boot/dts/imx6q-novena.dts
> new file mode 100644
> index 0000000..143b3bd
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-novena.dts
> @@ -0,0 +1,893 @@

[...]

> +	fpga@1 {
> +		compatible = "kosagi,novena-fpga";

This is missing a proper binding documentation.
> +
> +		spi-max-frequency = <30000000>;
> +		reg = <1>;
> +
> +		pinctrl-names = "default", "state-eim", "state-gpio";
> +		pinctrl-0 = <&pinctrl_fpga_gpio>;
> +		pinctrl-1 = <&pinctrl_fpga_eim>;
> +		pinctrl-2 = <&pinctrl_fpga_gpio>;
> +		clocks = <&clks IMX6QDL_CLK_LVDS2_SEL>, <&clks IMX6QDL_CLK_LVDS2_GATE>, <&clks IMX6QDL_CLK_ENET_REF>, <&clks IMX6QDL_CLK_EIM_SLOW>;
> +		clock-names = "lvds", "lvds-switch", "lvds-parent", "eim-slow";
> +		reset-switch = <&gpio1 17 GPIO_ACTIVE_HIGH>;
> +		power-switch = <&gpio5 7 GPIO_ACTIVE_HIGH>;

Custom property names without vendor namespacing. Also I don't know what
they should do without the binding.

> +
> +		kosagi,weim-cs0-timing = <0x31910BBF 0x00001000 0x09014000
> +					  0x00000000 0x09080800 0x00000000>;
> +		kosagi,weim-cs1-timing = <0x81910CBF 0x00001000 0x07001000
> +					  0x00000200 0x02040400 0x00000000>;
> +		kosagi,weim-cs-mapping = <2>;
> +	};
> +};
> +

[...]

> +&ldb {
> +	fsl,dual-channel;
> +	status = "okay";
> +	lvds-channel@0 {
> +		fsl,data-mapping = "jeida";
> +		fsl,data-width = <24>;
> +		status = "okay";
> +		display-timings {
> +			1920x1080p60 {
> +				clock-frequency = <148500000>;
> +				hactive = <1920>;
> +				vactive = <1080>;
> +				hback-porch = <148>;
> +				hfront-porch = <88>;
> +				hsync-len = <44>;
> +				vback-porch = <36>;
> +				vfront-porch = <4>;
> +				vsync-len = <5>;
> +				hsync-active = <1>;
> +				vsync-active = <1>;
> +			};
> +		};

Please don't use this for new devicetrees. Add a proper panel driver
instead. Looks like this panel can be represented with the simple-panel
driver.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

