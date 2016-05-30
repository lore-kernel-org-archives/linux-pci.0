Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52214 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754411AbcE3LIp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 30 May 2016 07:08:45 -0400
Date: Mon, 30 May 2016 12:08:36 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Wenrui Li <wenrui.li@rock-chips.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Documentation: add binding description of Rockchip
 PCIe controller
Message-ID: <20160530120836.290f0d16@arm.com>
In-Reply-To: <1463740146-7106-1-git-send-email-shawn.lin@rock-chips.com>
References: <1463740105-7061-1-git-send-email-shawn.lin@rock-chips.com>
	<1463740146-7106-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 20 May 2016 18:29:06 +0800
Shawn Lin <shawn.lin@rock-chips.com> wrote:

> This patch add some required and optional properties for Rockchip
> PCIe controller. Also we add a example for how to use it.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> 
>  .../devicetree/bindings/pci/rockchip-pcie.txt      | 93 ++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> new file mode 100644
> index 0000000..69a0804
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> @@ -0,0 +1,93 @@
> +* Rockchip AXI PCIe Root Port Bridge DT description
> +
> +Required properties:
> +- #address-cells: Address representation for root ports, set to <3>
> +- #size-cells: Size representation for root ports, set to <2>
> +- #interrupt-cells: specifies the number of cells needed to encode an
> +		interrupt source. The value must be 1.
> +- compatible: Should contain "rockchip,rk3399-pcie"
> +- reg: Two register ranges as listed in the reg-names property
> +- reg-names: The first entry must be "axi-base" for the core registers
> +	The second entry must be "apb-base" for the client pcie registers
> +- clocks: Must contain an entry for each entry in clock-names.
> +		See ../clocks/clock-bindings.txt for details.
> +- clock-names: Must include the following entries:
> +	- "aclk_pcie"
> +	- "aclk_perf_pcie"
> +	- "hclk_pcie"
> +	- "clk_pciephy_ref"
> +- interrupts: Three interrupt entries must be specified.
> +- interrupt-names: Must include the following names
> +	- "pcie-sys"
> +	- "pcie-legacy"
> +	- "pcie-client"
> +- resets: Must contain five entries for each entry in reset-names.
> +	   See ../reset/reset.txt for details.
> +- reset-names: Must include the following names
> +	- "phy-rst"
> +	- "core-rst"
> +	- "mgmt-rst"
> +	- "mgmt-sticky-rst"
> +	- "pipe-rst"
> +- rockchip,grf: phandle to the syscon managing the "general register files"
> +- pcie-conf: offset of pcie client block for  configuration
> +- pcie-status: offset of pcie client block for status
> +- pcie-laneoff: offset of pcie client block for lane
> +- msi-parent: Link to the hardware entity that serves as the Message
> +- pinctrl-names : The pin control state names
> +- pinctrl-0: The "default" pinctrl state
> +- interrupt-map-mask and interrupt-map: standard PCI properties
> +- interrupt-controller: identifies the node as an interrupt controller
> +
> +Optional Property:
> +- ep-gpios: contain the entry for pre-reset gpio
> +- num-lanes: number of lanes to use
> +- assigned-clocks, assigned-clock-parents and assigned-clock-rates: standard
> +		   clock bindings. See ../clock/clock-bindings.txt
> +
> +Example:
> +
> +pci_express: axi-pcie@f8000000 {
> +	#address-cells = <3>;
> +	#size-cells = <2>;
> +	compatible = "rockchip,rk3399-pcie";
> +	clocks = <&cru ACLK_PCIE>, <&cru ACLK_PERF_PCIE>,
> +		 <&cru PCLK_PCIE>, <&cru SCLK_PCIEPHY_REF>;
> +	clock-names = "aclk_pcie", "aclk_perf_pcie",
> +		      "hclk_pcie", "clk_pciephy_ref";
> +	bus-range = <0x0 0x1>;
> +	interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
> +	interrupt-names: "pcie-sys", "pcie-legacy", "pcie-client";
> +	assigned-clocks = <&cru SCLK_PCIEPHY_REF>;
> +	assigned-clock-parents = <&cru SCLK_PCIEPHY_REF100M>;
> +	assigned-clock-rates = <100000000>;
> +	ep-gpios = <&gpio3 13 GPIO_ACTIVE_HIGH>;
> +	ranges = < 0x82000000 0 0xfa000000 0x0 0xfa000000 0 0x600000
> +		   0x81000000 0 0xfa600000 0x0 0xfa600000 0 0x100000 >;
> +	num-lanes = <4>;
> +	reg = < 0x0 0xf8000000 0x0 0x2000000 >, < 0x0 0xfd000000 0x0 0x1000000 >;
> +	reg-name = "axi-base", "apb-base";
> +	resets = <&cru SRST_PCIEPHY>, <&cru SRST_PCIE_CORE>, <&cru SRST_PCIE_MGMT>,
> +		 <&cru SRST_PCIE_MGMT_STICKY>, <&cru SRST_PCIE_PIPE>;
> +	reset-names = "phy-rst", "core-rst", "mgmt-rst", "mgmt-sticky-rst", "pipe-rst";
> +	rockchip,grf = <&grf>;
> +	pcie-conf = <0xe220>;
> +	pcie-status = <0xe2a4>;
> +	pcie-laneoff = <0xe214>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie_clkreq>;
> +	msi-parent = <&its>;

We've moved away from bare msi-parent for the ITS (notice that the
binding mandates #msi-cells = <1>). So what you need here is an msi-map
(as described in Documentation/devicetree/bindings/pci/pci-msi.txt).

Do you have an IOMMU (or some other remapping HW) between the RC and the
GIC ITS? If so, yo may have to describe the mappings between the PCIe
RID and the ITS DevID in this msi-map.

> +	#interrupt-cells = <1>;
> +	interrupt-map-mask = <0 0 0 7>;
> +	interrupt-map = <0 0 0 1 &pcie_0 1>,
> +			<0 0 0 2 &pcie_0 2>,
> +			<0 0 0 3 &pcie_0 3>,
> +			<0 0 0 4 &pcie_0 4>;
> +	pcie_0: interrupt-controller {
> +		interrupt-controller;
> +		#address-cells = <0>;
> +		#interrupt-cells = <1>;
> +	};
> +
> +};

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
