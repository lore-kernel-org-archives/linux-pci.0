Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36015 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966479AbdEWOQo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 May 2017 10:16:44 -0400
Date: Tue, 23 May 2017 09:16:41 -0500
From: Rob Herring <robh@kernel.org>
To: Song Xiaowei <songxiaowei@hisilicon.com>
Cc: wangzhou1@hisilicon.com, gabriele.paoloni@huawei.com,
        bhelgaas@google.com, mark.rutland@arm.com, xuwei5@hisilicon.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, puck.chen@hisilicon.com,
        guodong.xu@linaro.org, wangbinghui@hisilicon.com,
        suzhuangluan@hisilicon.com
Subject: Re: [Patch v3 1/3] arm64: dts: hi3660: add pcie node
Message-ID: <20170523141641.kbb4falhs574dfpu@rob-hp-laptop>
References: <20170518074946.21362-1-songxiaowei@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170518074946.21362-1-songxiaowei@hisilicon.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 18, 2017 at 03:49:46PM +0800, Song Xiaowei wrote:
> Add PCIe node for hi3660, and add binding documentation.
> 
> Cc: Guodong Xu <guodong.xu@linaro.org>
> Signed-off-by: Song Xiaowei <songxiaowei@hisilicon.com>
> ---
>  .../devicetree/bindings/pci/hisilicon-pcie.txt     | 52 ++++++++++++++++++++++
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi          | 31 +++++++++++++

These should be separate patches.

>  2 files changed, 83 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> index a339dbb15493..71491178c86c 100644
> --- a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> @@ -85,3 +85,55 @@ Example:
>  				 0x0 0 0 4 &mbigen_pcie0 650 4>;
>  		status = "ok";
>  	};
> +
> +
> +

Why is this in the same document? If there's nothing shared, then just 
do a separate doc for each SoC.

> +HiSilicon Kirin SoC PCIe host DT description

Isn't Kirin the 6220? 

> +
> +Kirin PCIe host controller is also based on Designware PCI core.
> +It shares common functions with PCIe Designware core driver and inherits
> +common properties defined in
> +Documentation/devicetree/bindings/pci/designware-pci.txt.
> +
> +Additional properties are described here:
> +
> +Required properties
> +- compatible: Should contain "hisilicon,kirin-pcie".

Use the part number rather than the code name.

> +- reg: Should contain rc_dbi, apb, phy, config registers location and length.
> +- reg-names: Must include the following entries:
> +  "dbi": controller configuration registers;
> +  "apb": apb Ctrl register;
> +  "phy": apb PHY register;

Perhaps the phy should be a separate node and use the phy binding?

> +  "config": PCIe configuration space registers.
> +- reset-gpio: perst assert/deassert gpio

reset-gpios

> +
> +Optional properties:
> +- status: Either "ok" or "disabled".

Don't need to document this.

> +
> +Kirin960 Example:
> +        kirin_pcie@f4000000 {

pcie@...

Build the dts with W=1 or W=2. dtc will warn for this now.

> +                        compatible = "hisilicon,kirin-pcie";
> +                        reg =  <0x0 0xf4000000 0x0 0x1000>, <0x0 0xff3fe000 0x0 0x1000>,
> +                                 <0x0 0xf3f20000 0x0 0x40000>, <0x0 0xF5000000 0 0x2000>;
> +                        reg-names = "dbi","apb","phy", "config";
> +                        bus-range = <0x0  0x1>;
> +                        #address-cells = <3>;
> +                        #size-cells = <2>;
> +                        device_type = "pci";
> +                        ranges = <0x02000000 0x0 0x00000000 0x0 0xf6000000 0x0 0x2000000>;
> +                        num-lanes = <1>;
> +                        #interrupt-cells = <1>;
> +                        interrupt-map-mask = <0xf800 0 0 7>;
> +			interrupt-map = <0x0 0 0 2 &gic 0 0 0  283 4>,
> +                                        <0x0 0 0 3 &gic 0 0 0  284 4>,
> +                                        <0x0 0 0 4 &gic 0 0 0  285 4>;
> +                        clocks = <&crg_ctrl HI3660_PCIEPHY_REF>,
> +                                <&crg_ctrl HI3660_CLK_GATE_PCIEAUX>,
> +                                <&crg_ctrl HI3660_PCLK_GATE_PCIE_PHY>,
> +                                <&crg_ctrl HI3660_PCLK_GATE_PCIE_SYS>,
> +                                <&crg_ctrl HI3660_ACLK_GATE_PCIE>;
> +                        clock-names = "pcie_phy_ref", "pcie_aux",
> +                                "pcie_apb_phy", "pcie_apb_sys", "pcie_aclk";
> +                        reset-gpio = <&gpio11 1 0 >;
> +                        status = "ok";

Don't show status in examples.

> +        };
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index 3983086bd67b..2406a54947df 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -156,5 +156,36 @@
>  			clock-names = "uartclk", "apb_pclk";
>  			status = "disabled";
>  		};
> +
> +		kirin_pcie@f4000000 {
> +			compatible = "hisilicon,kirin-pcie";
> +			reg =  <0x0 0xf4000000 0x0 0x1000>,
> +				<0x0 0xff3fe000 0x0 0x1000>,
> +				<0x0 0xf3f20000 0x0 0x40000>,
> +				<0x0 0xF5000000 0x0 0x2000>;
> +			reg-names = "dbi", "apb", "phy", "config";
> +			bus-range = <0x0  0x1>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			device_type = "pci";
> +			ranges = <0x02000000 0x0 0x00000000 0x0
> +				0xf6000000 0x0 0x2000000>;
> +			num-lanes = <1>;
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0xf800 0 0 7>;
> +			interrupt-map = <0x0 0 0 1 &gic 0 0 0 282 4>,
> +				<0x0 0 0 2 &gic 0 0 0  283 4>,
> +				<0x0 0 0 3 &gic 0 0 0  284 4>,
> +				<0x0 0 0 4 &gic 0 0 0  285 4>;
> +			clocks = <&crg_ctrl HI3660_PCIEPHY_REF>,
> +				<&crg_ctrl HI3660_CLK_GATE_PCIEAUX>,
> +				<&crg_ctrl HI3660_PCLK_GATE_PCIE_PHY>,
> +				<&crg_ctrl HI3660_PCLK_GATE_PCIE_SYS>,
> +				<&crg_ctrl HI3660_ACLK_GATE_PCIE>;
> +			clock-names = "pcie_phy_ref", "pcie_aux",
> +				"pcie_apb_phy", "pcie_apb_sys", "pcie_aclk";
> +			reset-gpio = <&gpio11 1 0 >;
> +			status = "ok";
> +		};
>  	};
>  };
> -- 
> 2.11.GIT
> 
