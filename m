Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57608 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750744AbcEaKJr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 31 May 2016 06:09:47 -0400
Subject: Re: [PATCH 1/2] Documentation: add binding description of Rockchip
 PCIe controller
To: Shawn Lin <shawn.lin@kernel-upstream.org>,
	Shawn Lin <shawn.lin@rock-chips.com>
References: <1463740105-7061-1-git-send-email-shawn.lin@rock-chips.com>
 <1463740146-7106-1-git-send-email-shawn.lin@rock-chips.com>
 <20160530120836.290f0d16@arm.com>
 <c6fa65a1-58bd-520a-42a1-d6edf576840a@kernel-upstream.org>
Cc: devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org, Wenrui Li <wenrui.li@rock-chips.com>,
	Doug Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <574D62E7.50404@arm.com>
Date: Tue, 31 May 2016 11:09:43 +0100
MIME-Version: 1.0
In-Reply-To: <c6fa65a1-58bd-520a-42a1-d6edf576840a@kernel-upstream.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 31/05/16 10:48, Shawn Lin wrote:
> Hi Marc,
> 
> 在 2016/5/30 19:08, Marc Zyngier 写道:
>> On Fri, 20 May 2016 18:29:06 +0800
>> Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>
>>> This patch add some required and optional properties for Rockchip
>>> PCIe controller. Also we add a example for how to use it.
>>>
>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>>
>>> ---
>>>
>>>  .../devicetree/bindings/pci/rockchip-pcie.txt      | 93 ++++++++++++++++++++++
>>>  1 file changed, 93 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/pci/rockchip-pcie.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
>>> new file mode 100644
>>> index 0000000..69a0804
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
>>> @@ -0,0 +1,93 @@
>>> +* Rockchip AXI PCIe Root Port Bridge DT description
>>> +
>>> +Required properties:
>>> +- #address-cells: Address representation for root ports, set to <3>
>>> +- #size-cells: Size representation for root ports, set to <2>
>>> +- #interrupt-cells: specifies the number of cells needed to encode an
>>> +		interrupt source. The value must be 1.
>>> +- compatible: Should contain "rockchip,rk3399-pcie"
>>> +- reg: Two register ranges as listed in the reg-names property
>>> +- reg-names: The first entry must be "axi-base" for the core registers
>>> +	The second entry must be "apb-base" for the client pcie registers
>>> +- clocks: Must contain an entry for each entry in clock-names.
>>> +		See ../clocks/clock-bindings.txt for details.
>>> +- clock-names: Must include the following entries:
>>> +	- "aclk_pcie"
>>> +	- "aclk_perf_pcie"
>>> +	- "hclk_pcie"
>>> +	- "clk_pciephy_ref"
>>> +- interrupts: Three interrupt entries must be specified.
>>> +- interrupt-names: Must include the following names
>>> +	- "pcie-sys"
>>> +	- "pcie-legacy"
>>> +	- "pcie-client"
>>> +- resets: Must contain five entries for each entry in reset-names.
>>> +	   See ../reset/reset.txt for details.
>>> +- reset-names: Must include the following names
>>> +	- "phy-rst"
>>> +	- "core-rst"
>>> +	- "mgmt-rst"
>>> +	- "mgmt-sticky-rst"
>>> +	- "pipe-rst"
>>> +- rockchip,grf: phandle to the syscon managing the "general register files"
>>> +- pcie-conf: offset of pcie client block for  configuration
>>> +- pcie-status: offset of pcie client block for status
>>> +- pcie-laneoff: offset of pcie client block for lane
>>> +- msi-parent: Link to the hardware entity that serves as the Message
>>> +- pinctrl-names : The pin control state names
>>> +- pinctrl-0: The "default" pinctrl state
>>> +- interrupt-map-mask and interrupt-map: standard PCI properties
>>> +- interrupt-controller: identifies the node as an interrupt controller
>>> +
>>> +Optional Property:
>>> +- ep-gpios: contain the entry for pre-reset gpio
>>> +- num-lanes: number of lanes to use
>>> +- assigned-clocks, assigned-clock-parents and assigned-clock-rates: standard
>>> +		   clock bindings. See ../clock/clock-bindings.txt
>>> +
>>> +Example:
>>> +
>>> +pci_express: axi-pcie@f8000000 {
>>> +	#address-cells = <3>;
>>> +	#size-cells = <2>;
>>> +	compatible = "rockchip,rk3399-pcie";
>>> +	clocks = <&cru ACLK_PCIE>, <&cru ACLK_PERF_PCIE>,
>>> +		 <&cru PCLK_PCIE>, <&cru SCLK_PCIEPHY_REF>;
>>> +	clock-names = "aclk_pcie", "aclk_perf_pcie",
>>> +		      "hclk_pcie", "clk_pciephy_ref";
>>> +	bus-range = <0x0 0x1>;
>>> +	interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>,
>>> +		     <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
>>> +	interrupt-names: "pcie-sys", "pcie-legacy", "pcie-client";
>>> +	assigned-clocks = <&cru SCLK_PCIEPHY_REF>;
>>> +	assigned-clock-parents = <&cru SCLK_PCIEPHY_REF100M>;
>>> +	assigned-clock-rates = <100000000>;
>>> +	ep-gpios = <&gpio3 13 GPIO_ACTIVE_HIGH>;
>>> +	ranges = < 0x82000000 0 0xfa000000 0x0 0xfa000000 0 0x600000
>>> +		   0x81000000 0 0xfa600000 0x0 0xfa600000 0 0x100000 >;
>>> +	num-lanes = <4>;
>>> +	reg = < 0x0 0xf8000000 0x0 0x2000000 >, < 0x0 0xfd000000 0x0 0x1000000 >;
>>> +	reg-name = "axi-base", "apb-base";
>>> +	resets = <&cru SRST_PCIEPHY>, <&cru SRST_PCIE_CORE>, <&cru SRST_PCIE_MGMT>,
>>> +		 <&cru SRST_PCIE_MGMT_STICKY>, <&cru SRST_PCIE_PIPE>;
>>> +	reset-names = "phy-rst", "core-rst", "mgmt-rst", "mgmt-sticky-rst", "pipe-rst";
>>> +	rockchip,grf = <&grf>;
>>> +	pcie-conf = <0xe220>;
>>> +	pcie-status = <0xe2a4>;
>>> +	pcie-laneoff = <0xe214>;
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&pcie_clkreq>;
>>> +	msi-parent = <&its>;
>>
>> We've moved away from bare msi-parent for the ITS (notice that the
>> binding mandates #msi-cells = <1>). So what you need here is an msi-map
>> (as described in Documentation/devicetree/bindings/pci/pci-msi.txt).
>>
>> Do you have an IOMMU (or some other remapping HW) between the RC and the
>> GIC ITS? If so, yo may have to describe the mappings between the PCIe
>> RID and the ITS DevID in this msi-map.
>>
> 
> yes, we don't need msi-parent here. And we don't need msi-map as well,
> since we don't have a IOMMU block between RC and ITS which need to be
> described in msi-map.

Well, if have neither msi-parent nor msi-map, you won't get MSI at all.

Maybe that's good enough for you, but in that case, make sure you drop
all the MSI code from your patches! ;-) More seriously, you do need an
msi-map, even if that's with a single entry.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
