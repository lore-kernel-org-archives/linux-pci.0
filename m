Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbeGSEFx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Jul 2018 00:05:53 -0400
Date: Thu, 19 Jul 2018 11:24:43 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Trent Piepho <tpiepho@impinj.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 1/2] ARM: dts: imx7d: Add node for PCIe PHY
Message-ID: <20180719032442.GU4576@dragon>
References: <20180718194424.8844-1-tpiepho@impinj.com>
 <20180718194424.8844-2-tpiepho@impinj.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180718194424.8844-2-tpiepho@impinj.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 18, 2018 at 12:44:23PM -0700, Trent Piepho wrote:
> There isn't yet any code in the kernel that uses this device's register,
> but there will be some for a PCIe PLL erratum wortkaround.
> 
> This adds the PHY as a new node.  The PCI-e controller node gains a
> phandle property that points to it.  There is no driver for the PHY at
> this point and all the existing code that relates to the PHY is part of
> the PCI-e controller driver (and does not need register access, yet).
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Trent Piepho <tpiepho@impinj.com>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 11 +++++++++++
>  arch/arm/boot/dts/imx7d.dtsi                             |  9 +++++++++
>  2 files changed, 20 insertions(+)

Please have separate patches for bindings and DTS.

Shawn

> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> index cb33421184a0..c7aeda6878ff 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> @@ -50,6 +50,7 @@ Additional required properties for imx7d-pcie:
>  - reset-names: Must contain the following entires:
>  	       - "pciephy"
>  	       - "apps"
> +- fsl,pcie-phy: A phandle to an fsl,imx-pcie-phy node.
>  
>  Example:
>  
> @@ -76,3 +77,13 @@ Example:
>  		clocks = <&clks 144>, <&clks 206>, <&clks 189>;
>  		clock-names = "pcie", "pcie_bus", "pcie_phy";
>  	};
> +
> +* Freescale i.MX7d PCIe PHY
> +
> +This is the PHY associated with the IMX7d PCIe controller.  It's used by the
> +PCI-e controller via the fsl,pcie-phy phandle.
> +
> +Required properties:
> +- compatible:
> +	- "fsl,imx-pcie-phy"
> +- reg: base address and length of the PCIe PHY controller
> diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
> index 200714e3feea..31f5c8576251 100644
> --- a/arch/arm/boot/dts/imx7d.dtsi
> +++ b/arch/arm/boot/dts/imx7d.dtsi
> @@ -94,6 +94,14 @@
>  	};
>  };
>  
> +&aips2 {
> +	pcie_phy: pcie-phy@306d0000 {
> +		  compatible = "fsl,imx-pcie-phy";
> +		  reg = <0x306d0000 0x10000>;
> +		  status = "disabled";
> +	};
> +};
> +
>  &aips3 {
>  	usbotg2: usb@30b20000 {
>  		compatible = "fsl,imx7d-usb", "fsl,imx27-usb";
> @@ -167,6 +175,7 @@
>  			 <&src IMX7_RESET_PCIE_CTRL_APPS_EN>;
>  		reset-names = "pciephy", "apps";
>  		status = "disabled";
> +		fsl,pcie-phy = <&pcie_phy>;
>  	};
>  };
>  
> -- 
> 2.14.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
