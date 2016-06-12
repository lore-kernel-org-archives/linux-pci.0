Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:39394 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216AbcFLBmb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 11 Jun 2016 21:42:31 -0400
Subject: Re: [PATCH v2 1/2] Documentation: bindings: add dt doc for Rockchip
 PCIe controller
To: Rob Herring <robh@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>
References: <1465373117-823-1-git-send-email-shawn.lin@rock-chips.com>
 <20160608204448.GA26861@rob-hp-laptop>
Cc: devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	Wenrui Li <wenrui.li@rock-chips.com>,
	linux-kernel@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	linux-rockchip@lists.infradead.org,
	Bjorn Helgaas <bhelgaas@google.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <af7b8d26-e88d-97df-9cce-30a6aaba0e1c@rock-chips.com>
Date: Sun, 12 Jun 2016 09:42:12 +0800
MIME-Version: 1.0
In-Reply-To: <20160608204448.GA26861@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2016/6/9 4:44, Rob Herring wrote:
> On Wed, Jun 08, 2016 at 04:05:17PM +0800, Shawn Lin wrote:
>> This patch adds a binding that describes the Rockchip PCIe controller
>> found on Rockchip SoCs PCIe interface.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>
>> ---
>>
>> Changes in v2:
>> - fix lots clk/reset stuff suggested by Heiko
>> - remove msi-parent and add msi-map suggested by Marc
>> - drop phy related stuff
>> - some others minor fixes
>>
>>  .../devicetree/bindings/pci/rockchip-pcie.txt      | 86 ++++++++++++++++++++++
>>  1 file changed, 86 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pci/rockchip-pcie.txt
>>
>> diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
>> new file mode 100644
>> index 0000000..eb92e29
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
>> @@ -0,0 +1,86 @@
>> +* Rockchip AXI PCIe Root Port Bridge DT description
>> +
>> +Required properties:
>> +- #address-cells: Address representation for root ports, set to <3>
>> +- #size-cells: Size representation for root ports, set to <2>
>> +- #interrupt-cells: specifies the number of cells needed to encode an
>> +		interrupt source. The value must be 1.
>> +- compatible: Should contain "rockchip,rk3399-pcie"
>> +- reg: Two register ranges as listed in the reg-names property
>> +- reg-names: Must include the following names
>> +	- "axi-base"
>> +	- "apb-base"
>> +- clocks: Must contain an entry for each entry in clock-names.
>> +		See ../clocks/clock-bindings.txt for details.
>> +- clock-names: Must include the following entries:
>> +	- "aclk"
>> +	- "aclk-perf"
>> +	- "hclk"
>> +	- "pm"
>> +- phys: From PHY bindings: Phandle for the Generic PHY for PCIe.
>> +- phy-names:  MUST be "pcie-phy".
>
> phy-names is kind of pointless for 1 phy.

ok, I will remove it.

>
>> +- interrupts: Three interrupt entries must be specified.
>> +- interrupt-names: Must include the following names
>> +	- "sys"
>> +	- "legacy"
>> +	- "client"
>> +- resets: Must contain five entries for each entry in reset-names.
>> +	   See ../reset/reset.txt for details.
>> +- reset-names: Must include the following names
>> +	- "core"
>> +	- "mgmt"
>> +	- "mgmt-sticky"
>> +	- "pipe"
>> +- pinctrl-names : The pin control state names
>> +- pinctrl-0: The "default" pinctrl state
>> +- interrupt-map-mask and interrupt-map: standard PCI properties
>> +- interrupt-controller: identifies the node as an interrupt controller
>> +
>> +Optional Property:
>> +- ep-gpios: contain the entry for pre-reset gpio
>> +- num-lanes: number of lanes to use
>> +- vpcie3v3-supply: The phandle to the 3.3v regulator to use for pcie. If this
>> +  is specified we'll defer probe until we can find this regulator.
>> +- vpcie1v8-supply: The phandle to the 1.8v regulator to use for pcie. If this
>> +  is specified we'll defer probe until we can find this regulator.
>> +- vpcie0v9-supply: The phandle to the 0.9v regulator to use for pcie. If this
>> +  is specified we'll defer probe until we can find this regulator.
>> +
>> +Example:
>> +
>> +pcie0: pcie@f8000000 {
>> +	compatible = "rockchip,rk3399-pcie";
>> +	#address-cells = <3>;
>> +	#size-cells = <2>;
>> +	clocks = <&cru ACLK_PCIE>, <&cru ACLK_PERF_PCIE>,
>> +		 <&cru PCLK_PCIE>;
>> +	clock-names = "aclk", "aclk-perf",
>> +		      "hclk";
>> +	bus-range = <0x0 0x1>;
>> +	interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>,
>> +		     <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
>> +	interrupt-names: "sys", "legacy", "client";
>> +	assigned-clocks = <&cru SCLK_PCIEPHY_REF>;
>> +	assigned-clock-parents = <&cru SCLK_PCIEPHY_REF100M>;
>> +	assigned-clock-rates = <100000000>;
>> +	ep-gpios = <&gpio3 13 GPIO_ACTIVE_HIGH>;
>> +	ranges = < 0x82000000 0 0xfa000000 0x0 0xfa000000 0 0x600000
>> +		   0x81000000 0 0xfa600000 0x0 0xfa600000 0 0x100000 >;
>
> No 64-bit memory space?

Will fix this example. Thanks for catching this:)

>
>> +	num-lanes = <4>;
>> +	reg = < 0x0 0xf8000000 0x0 0x2000000 >, < 0x0 0xfd000000 0x0 0x1000000 >;
>> +	reg-name = "axi-base", "apb-base";
>> +	resets = <&cru SRST_PCIEPHY>, <&cru SRST_PCIE_CORE>, <&cru SRST_PCIE_MGMT>,
>> +		 <&cru SRST_PCIE_MGMT_STICKY>, <&cru SRST_PCIE_PIPE>;
>> +	reset-names = "core", "mgmt", "mgmt-sticky", "pipe";
>> +	phys = <&pcie_phy>;
>> +	phy-names = "pcie-phy";
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pcie_clkreq>;
>> +	#interrupt-cells = <1>;
>> +	interrupt-controller;
>> +	interrupt-map-mask = <0 0 0 7>;
>> +	interrupt-map = <0 0 0 1 &pcie0 1>,
>> +			<0 0 0 2 &pcie0 2>,
>> +			<0 0 0 3 &pcie0 3>,
>> +			<0 0 0 4 &pcie0 4>;
>> +};
>> --
>> 2.3.7
>>
>>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>


-- 
Best Regards
Shawn Lin

