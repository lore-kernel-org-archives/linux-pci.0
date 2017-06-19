Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([45.249.212.187]:8752 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753724AbdFSKsr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jun 2017 06:48:47 -0400
Subject: Re: [PATCH v11 1/3] PCI: hisi: Add DT binding for PCIe of Kirin SoC
 series
To: Xiaowei Song <songxiaowei@hisilicon.com>, <guodong.xu@linaro.org>,
        <bhelgaas@google.com>, <robh+dt@kernel.org>
References: <20170619102349.50652-1-songxiaowei@hisilicon.com>
 <20170619102349.50652-2-songxiaowei@hisilicon.com>
CC: <suzhuangluan@hisilicon.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5947AB23.20402@hisilicon.com>
Date: Mon, 19 Jun 2017 11:44:51 +0100
MIME-Version: 1.0
In-Reply-To: <20170619102349.50652-2-songxiaowei@hisilicon.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Xiaowei,

On 2017/6/19 11:23, Xiaowei Song wrote:

Please add some commit message.

> Cc: Guodong Xu <guodong.xu@linaro.org>
> Signed-off-by: Xiaowei Song <songxiaowei@hisilicon.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

I have picked up the patch from [1] and
the pull request has been merged into ARM SoC tree.
Please do not resend the same patch.
Thanks!

[1]:https://lkml.org/lkml/2017/6/14/1055

Best Regards,
Wei

>  .../devicetree/bindings/pci/kirin-pcie.txt         | 55 ++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/kirin-pcie.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/kirin-pcie.txt b/Documentation/devicetree/bindings/pci/kirin-pcie.txt
> new file mode 100644
> index 000000000000..c2be01270ec5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/kirin-pcie.txt
> @@ -0,0 +1,55 @@
> +HiSilicon Kirin SoCs PCIe host DT description
> +
> +Kirin PCIe host controller is based on Designware PCI core.
> +It shares common functions with PCIe Designware core driver
> +and inherits common properties defined in
> +Documentation/devicetree/bindings/pci/designware-pci.txt.
> +
> +Additional properties are described here:
> +
> +Required properties
> +- compatible:
> +	"hisilicon,kirin960-pcie" for PCIe of Kirin960 SoC
> +- reg: Should contain rc_dbi, apb, phy, config registers location and length.
> +- reg-names: Must include the following entries:
> +  "dbi": controller configuration registers;
> +  "apb": apb Ctrl register defined by Kirin;
> +  "phy": apb PHY register defined by Kirin;
> +  "config": PCIe configuration space registers.
> +- reset-gpios: The gpio to generate PCIe perst assert and deassert signal.
> +
> +Optional properties:
> +
> +Example based on kirin960:
> +
> +	pcie@f4000000 {
> +		compatible = "hisilicon,kirin960-pcie";
> +		reg = <0x0 0xf4000000 0x0 0x1000>,
> +		      <0x0 0xff3fe000 0x0 0x1000>,
> +		      <0x0 0xf3f20000 0x0 0x40000>,
> +		      <0x0 0xf4000000 0x0  0x2000>;
> +		reg-names = "dbi","apb","phy", "config";
> +		bus-range = <0x0  0x1>;
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		device_type = "pci";
> +		ranges = <0x02000000 0x0 0x0
> +			  0x0 0xf5000000
> +			  0x0 0x2000000>;
> +		num-lanes = <1>;
> +		#interrupt-cells = <1>;
> +		interrupt-map-mask = <0xf800 0 0 7>;
> +		interrupt-map = <0x0 0 0 1 &gic 0 282 4>,
> +				<0x0 0 0 2 &gic 0 283 4>,
> +				<0x0 0 0 3 &gic 0 284 4>,
> +				<0x0 0 0 4 &gic 0 285 4>;
> +		clocks = <&crg_ctrl HI3660_PCIEPHY_REF>,
> +			 <&crg_ctrl HI3660_CLK_GATE_PCIEAUX>,
> +			 <&crg_ctrl HI3660_PCLK_GATE_PCIE_PHY>,
> +			 <&crg_ctrl HI3660_PCLK_GATE_PCIE_SYS>,
> +			 <&crg_ctrl HI3660_ACLK_GATE_PCIE>;
> +		clock-names = "pcie_phy_ref", "pcie_aux",
> +			      "pcie_apb_phy", "pcie_apb_sys",
> +			      "pcie_aclk";
> +		reset-gpios = <&gpio11 1 0>;
> +	};
> 
