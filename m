Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:51731 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965952AbcJ0Opr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2016 10:45:47 -0400
Message-ID: <1477561868.2274.27.camel@pengutronix.de>
Subject: Re: [PATCH 1/3] PCI: imx6: Improve binding example
From: Lucas Stach <l.stach@pengutronix.de>
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: bhelgaas@google.com, hongxing.zhu@nxp.com,
        linux-pci@vger.kernel.org
Date: Thu, 27 Oct 2016 11:51:08 +0200
In-Reply-To: <1477499244-10640-1-git-send-email-fabio.estevam@nxp.com>
References: <1477499244-10640-1-git-send-email-fabio.estevam@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Mittwoch, den 26.10.2016, 14:27 -0200 schrieb Fabio Estevam:
> Make the binding example to match what is really used in imx6qdl.dtsi.
> 
This seems like needless churn to me. After all this is an example and a
valid one, even if some of the references have changed. The fields
itself are in line with the documentation above.

> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt        | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> index 83aeb1f..1cc8b74 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> @@ -36,7 +36,7 @@ Additional required properties for imx6sx-pcie:
>  
>  Example:
>  
> -	pcie@0x01000000 {
> +	pcie: pcie@0x01000000 {
>  		compatible = "fsl,imx6q-pcie", "snps,dw-pcie";
>  		reg = <0x01ffc000 0x04000>,
>  		      <0x01f00000 0x80000>;
> @@ -44,18 +44,19 @@ Example:
>  		#address-cells = <3>;
>  		#size-cells = <2>;
>  		device_type = "pci";
> -		ranges = <0x00000800 0 0x01f00000 0x01f00000 0 0x00080000
> -			  0x81000000 0 0          0x01f80000 0 0x00010000
> -			  0x82000000 0 0x01000000 0x01000000 0 0x00f00000>;
> +		ranges = <0x81000000 0 0          0x01f80000 0 0x00010000 /* downstream I/O */
> +			  0x82000000 0 0x01000000 0x01000000 0 0x00f00000>; /* non-prefetchable memory */
>  		num-lanes = <1>;
>  		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
>  		interrupt-names = "msi";
>  		#interrupt-cells = <1>;
>  		interrupt-map-mask = <0 0 0 0x7>;
> -		interrupt-map = <0 0 0 1 &intc GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> -		                <0 0 0 2 &intc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
> -		                <0 0 0 3 &intc GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
> -		                <0 0 0 4 &intc GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&clks 144>, <&clks 206>, <&clks 189>;
> +		interrupt-map = <0 0 0 1 &gpc GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> +				<0 0 0 2 &gpc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
> +				<0 0 0 3 &gpc GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
> +				<0 0 0 4 &gpc GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&clks IMX6QDL_CLK_PCIE_AXI>,
> +			 <&clks IMX6QDL_CLK_LVDS1_GATE>,
> +			 <&clks IMX6QDL_CLK_PCIE_REF_125M>;
>  		clock-names = "pcie", "pcie_bus", "pcie_phy";
>  	};


