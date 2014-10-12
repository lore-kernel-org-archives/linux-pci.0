Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43526 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbaJLOfV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 12 Oct 2014 10:35:21 -0400
Message-ID: <1413124507.2459.16.camel@antimon.intern.lynxeye.de>
Subject: Re: [PATCH v5 6/9] ARM: imx6: update dts and binding for imx6sx pcie
From: Lucas Stach <l.stach@pengutronix.de>
To: Richard Zhu <richard.zhu@freescale.com>
Cc: linux-pci@vger.kernel.org, shawn.guo@freescale.com,
	festevam@gmail.com, tharvey@gateworks.com,
	Richard Zhu <r65037@freescale.com>
Date: Sun, 12 Oct 2014 16:35:07 +0200
In-Reply-To: <1412919676-25344-7-git-send-email-richard.zhu@freescale.com>
References: <1412919676-25344-1-git-send-email-richard.zhu@freescale.com>
	 <1412919676-25344-7-git-send-email-richard.zhu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Freitag, den 10.10.2014, 13:41 +0800 schrieb Richard Zhu:
> From: Richard Zhu <r65037@freescale.com>
> 
> - imx6sx pcie phy has its own power regulator. Add the
> pcie phy power suppy into im6sx pcie dts and binding.
> - in order to align with imx6qdl's pcie dts, re-format
> imx6sx pcie dts.
> - in order to align with imx6qdl pcie dts format and
> keep clean of imx6 pcie driver, keep the pcie phy clock
> in imx6sx pcie dts, although it's the parent clk of the
> pcie bus clock now, and would be enabled automatically
> when pcie bus clock is enabled. secondly, it's
> possible that the external osc maybe used as source
> of the pcie_bus clk in board design in future.
> - disp_axi clock is required by pcie inbound axi port.
> Add one more clock named pcie_inbound_axi for imx6sx pcie.
> 
> Signed-off-by: Richard Zhu <richard.zhu@freescale.com>

One nit below, otherwise this looks fine now.

> ---
>  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |  8 +++++-
>  arch/arm/boot/dts/imx6sx.dtsi                      | 32 ++++++++++++----------
>  2 files changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> index 9455fd0..ad81179 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> @@ -4,7 +4,7 @@ This PCIe host controller is based on the Synopsis Designware PCIe IP
>  and thus inherits all the common properties defined in designware-pcie.txt.
>  
>  Required properties:
> -- compatible: "fsl,imx6q-pcie"
> +- compatible: "fsl,imx6q-pcie", "fsl,imx6sx-pcie"
>  - reg: base addresse and length of the pcie controller
>  - interrupts: A list of interrupt outputs of the controller. Must contain an
>    entry for each entry in the interrupt-names property.
> @@ -13,6 +13,12 @@ Required properties:
>  - clock-names: Must include the following additional entries:
>  	- "pcie_phy"
>  
> +Additional required properties for imx6sx-pcie:
> +- clock names: Must include the following additional entries:
> +	- "pcie_inbound_axi"
> +- power supplies:
> +	- pcie-phy-supply: regulator used to power the PCIe PHY
> +
>  Example:
>  
>  	pcie@0x01000000 {
> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
> index f4b9da6..eefedba 100644
> --- a/arch/arm/boot/dts/imx6sx.dtsi
> +++ b/arch/arm/boot/dts/imx6sx.dtsi
> @@ -599,9 +599,9 @@
>  					anatop-max-voltage = <1450000>;
>  				};
>  
> -				reg_pcie: regulator-vddpcie@140 {
> +				reg_pcie_phy: regulator-vddpcie-phy@140 {
>  					compatible = "fsl,anatop-regulator";
> -					regulator-name = "vddpcie";
> +					regulator-name = "vddpcie-phy";
>  					regulator-min-microvolt = <725000>;
>  					regulator-max-microvolt = <1450000>;
>  					anatop-reg-offset = <0x140>;
> @@ -1184,24 +1184,28 @@
>  
>  		pcie: pcie@0x08000000 {
>  			compatible = "fsl,imx6sx-pcie", "snps,dw-pcie";
> -			reg = <0x08ffc000 0x4000>; /* DBI */
> +			reg = <0x08ffc000 0x4000>, <0x08f00000 0x80000>;
> +			reg-names = "rc_dbi", "config";

While it doesn't make a fucntional change, I would like to see this
aligned to imx6q, which means the first reg name is just "dbi".
 
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			device_type = "pci";
> -				  /* configuration space */
> -			ranges = <0x00000800 0 0x08f00000 0x08f00000 0 0x00080000
> -				  /* downstream I/O */
> -				  0x81000000 0 0          0x08f80000 0 0x00010000
> -				  /* non-prefetchable memory */
> -				  0x82000000 0 0x08000000 0x08000000 0 0x00f00000>;
> +			ranges = <0x81000000 0 0          0x08f80000 0 0x00010000 /* downstream I/O */
> +				  0x82000000 0 0x08000000 0x08000000 0 0x00f00000>; /* non-prefetchable memory */
>  			num-lanes = <1>;
> -			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&clks IMX6SX_CLK_PCIE_REF_125M>,
> -				 <&clks IMX6SX_CLK_PCIE_AXI>,
> +			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi";
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> +			                <0 0 0 2 &intc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
> +			                <0 0 0 3 &intc GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
> +			                <0 0 0 4 &intc GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks IMX6SX_CLK_PCIE_AXI>,
>  				 <&clks IMX6SX_CLK_LVDS1_OUT>,
> +				 <&clks IMX6SX_CLK_PCIE_REF_125M>,
>  				 <&clks IMX6SX_CLK_DISPLAY_AXI>;
> -			clock-names = "pcie_ref_125m", "pcie_axi",
> -				      "lvds_gate", "display_axi";
> +			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_inbound_axi";
> +			pcie-phy-supply = <&reg_pcie_phy>;
>  			status = "disabled";
>  		};
>  	};


