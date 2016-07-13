Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:58595 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbcGMBLZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jul 2016 21:11:25 -0400
Subject: Re: [PATCH v6 1/2] Documentation: bindings: add dt doc for Rockchip
 PCIe controller
To: Brian Norris <briannorris@chromium.org>,
	Shawn Lin <shawn.lin@rock-chips.com>
References: <1467789398-13501-1-git-send-email-shawn.lin@rock-chips.com>
 <20160707003912.GB100467@google.com>
Cc: shawn.lin@rock-chips.com, devicetree@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	Wenrui Li <wenrui.li@rock-chips.com>,
	linux-kernel@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	linux-rockchip@lists.infradead.org,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <59b328c9-3a21-36fa-7f28-4ba24d77fef0@rock-chips.com>
Date: Wed, 13 Jul 2016 09:10:15 +0800
MIME-Version: 1.0
In-Reply-To: <20160707003912.GB100467@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

在 2016/7/7 8:39, Brian Norris 写道:
> Hi Shawn,
>
> On Wed, Jul 06, 2016 at 03:16:37PM +0800, Shawn Lin wrote:
>> This patch adds a binding that describes the Rockchip PCIe controller
>> found on Rockchip SoCs PCIe interface.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>
>> Acked-by: Rob Herring <robh@kernel.org>
>> ---
>>
>> Changes in v6:
>> - add ack tag from Rob
>>
>> Changes in v5:
>> - fix wrong example reported by Marc
>> - add seperate section to describe the interrupt controller child
>>   node
>>
>> Changes in v4:
>> - fix example of adding intermediate interrupt controller for pcie
>>   legacy interrrupt
>>
>> Changes in v3:
>> - fix example dts code suggested by Rob and Marc
>> - remove driver's behaviour of regulator
>>
>> Changes in v2:
>> - fix lots clk/reset stuff suggested by Heiko
>> - remove msi-parent and add msi-map suggested by Marc
>> - drop phy related stuff
>> - some others minor fixes
>>
>>  .../devicetree/bindings/pci/rockchip-pcie.txt      | 104 +++++++++++++++++++++
>>  1 file changed, 104 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pci/rockchip-pcie.txt
>>
>> diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
>> new file mode 100644
>> index 0000000..7616ecc
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
>> @@ -0,0 +1,104 @@
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
>> +- msi-map: Maps a Requester ID to an MSI controller and associated.
>> +		See ./pci-msi.txt
>> +- phys: From PHY bindings: Phandle for the Generic PHY for PCIe.
>> +- phy-names:  MUST be "pcie-phy".
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
>> +- #interrupt-cells: specifies the number of cells needed to encode an
>> +	interrupt source. The value must be 1.
>> +- interrupt-map-mask and interrupt-map: standard PCI properties
>> +
>> +*Interrupt controller child node*
>> +The core controller provides a single interrupt for legacy INTx. So,
>> +pcie node should create a interrupt controller node to support 'interrupt-map'
>> +DT functionality. The driver will create an IRQ domain for this map, decode
>> +the four INTx interrupts in ISR and route them to this domain.
>
> Where in your driver do you actually handle this child node? I don't see
> anything, but perhaps I'm missing something. I see how your earlier
> revisions of this driver used of_get_next_child() to acquire the child
> node, for use with irq_domain_add_linear(). But that's not in this
> version...
>
>> +
>> +Required properties for Interrupt controller child node:
>> +- interrupt-controller: identifies the node as an interrupt controller
>> +- #address-cells: specifies the number of cells needed to encode an
>> +	address. The value must be 0.
>> +- #interrupt-cells: specifies the number of cells needed to encode an
>> +	interrupt source. The value must be 1.
>> +
>> +Optional Property:
>
> These optional properties apply to the pcie node, not the interrupt
> controller child, right? Seems like the subnode and its properties
> should be last (i.e., the 'Optional Property' section should be above
> 'Interrupt controller child node').

okay, i will move it ahead.

>
>> +- ep-gpios: contain the entry for pre-reset gpio
>> +- num-lanes: number of lanes to use
>> +- vpcie3v3-supply: The phandle to the 3.3v regulator to use for pcie.
>> +- vpcie1v8-supply: The phandle to the 1.8v regulator to use for pcie.
>> +- vpcie0v9-supply: The phandle to the 0.9v regulator to use for pcie.
>> +
>> +Example:
>> +
>> +pcie0: pcie@f8000000 {
>> +	compatible = "rockchip,rk3399-pcie";
>> +	#address-cells = <3>;
>> +	#size-cells = <2>;
>> +	clocks = <&cru ACLK_PCIE>, <&cru ACLK_PERF_PCIE>,
>> +		 <&cru PCLK_PCIE>, <&cru SCLK_PCIE_PM>;
>> +	clock-names = "aclk", "aclk-perf",
>> +		      "hclk", "pm";
>> +	bus-range = <0x0 0x1>;
>> +	interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>,
>> +		     <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
>> +	interrupt-names = "sys", "legacy", "client";
>> +	assigned-clocks = <&cru SCLK_PCIEPHY_REF>;
>> +	assigned-clock-parents = <&cru SCLK_PCIEPHY_REF100M>;
>> +	assigned-clock-rates = <100000000>;
>> +	ep-gpios = <&gpio3 13 GPIO_ACTIVE_HIGH>;
>> +	ranges = <0x83000000 0x0 0xfa000000 0x0 0xfa000000 0x0 0x600000
>> +		  0x81000000 0x0 0xfa600000 0x0 0xfa600000 0x0 0x100000>;
>> +	num-lanes = <4>;
>> +	msi-map = <0x0 &its 0x0 0x1000>;
>> +	reg = < 0x0 0xf8000000 0x0 0x2000000 >, < 0x0 0xfd000000 0x0 0x1000000 >;
>> +	reg-names = "axi-base", "apb-base";
>> +	resets = <&cru SRST_PCIE_CORE>, <&cru SRST_PCIE_MGMT>,
>> +		 <&cru SRST_PCIE_MGMT_STICKY>, <&cru SRST_PCIE_PIPE>;
>> +	reset-names = "core", "mgmt", "mgmt-sticky", "pipe";
>> +	phys = <&pcie_phy>;
>> +	phy-names = "pcie-phy";
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pcie_clkreq>;
>> +	#interrupt-cells = <1>;
>> +	interrupt-map-mask = <0 0 0 7>;
>> +	interrupt-map = <0 0 0 1 &pcie0_intc 1>,
>> +			<0 0 0 2 &pcie0_intc 2>,
>> +			<0 0 0 3 &pcie0_intc 3>,
>> +			<0 0 0 4 &pcie0_intc 4>;
>
> I'm a little lost on this one, so forgive my ignorance; how did you
> determine the last value in each entry (i.e., the 1, 2, 3, and 4 IRQ
> numbers for pcie0_intc)? IIUC, those are supposed to represent indeces
> into the IRQ status register found in the PCIe interrupt status
> register, and so they should be 0-based (i.e., 0, 1, 2, 3). And then
> you'd have:
>
> 	interrupt-map = <0 0 0 1 &pcie0_intc 0>,
> 			<0 0 0 2 &pcie0_intc 1>,
> 			<0 0 0 3 &pcie0_intc 2>,
> 			<0 0 0 4 &pcie0_intc 3>;
>
> But then, I never got this sub-node binding to work quite right, so I
> may be missing something.
>
> EDIT: ooh, I see what's going on! I'll comment on the driver as well,
> but it looks like you're translating the register status to a HW IRQ
> number with 'ffs(reg)', which yields a 1-based index. I think it is most
> sensible to use a 0-based index (i.e., 'ffs(reg) - 1'). Now, that only
> will work if you get the whole interrupt-map + interrupt-controller
> thing right (i.e., using a subnode for the interrupt controller) --
> otherwise, IRQ mapping might not work right. I suspect that's one reason
> the original driver writer might have used 1-based indexing in the first
> place.

yes, I got it but.....what's the difference?
You still need to get the whole interrupt-map + interrupt-controller
things right and the code(ffs(reg) - 1)if applied your suggestion.

Look at most of the docs for pcie bindings, I saw they also take 0-base 
index, how about?

>
> Brian
>
>> +	pcie0_intc: interrupt-controller {
>> +		interrupt-controller;
>> +		#address-cells = <0>;
>> +		#interrupt-cells = <1>;
>> +	};
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

