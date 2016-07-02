Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42035 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750815AbcGBJUc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 2 Jul 2016 05:20:32 -0400
Date: Sat, 2 Jul 2016 10:20:22 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Heiko Stuebner <heiko@sntech.de>,
	Doug Anderson <dianders@chromium.org>,
	Wenrui Li <wenrui.li@rock-chips.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] Documentation: bindings: add dt doc for Rockchip
 PCIe controller
Message-ID: <20160702102022.144313fb@arm.com>
In-Reply-To: <20160702022537.GA29641@google.com>
References: <1467336290-11282-1-git-send-email-shawn.lin@rock-chips.com>
	<57766995.9070302@arm.com>
	<20160702022537.GA29641@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 1 Jul 2016 19:25:38 -0700
Brian Norris <briannorris@chromium.org> wrote:

> Hi,
> 
> On Fri, Jul 01, 2016 at 02:01:09PM +0100, Marc Zyngier wrote:
> > On 01/07/16 02:24, Shawn Lin wrote:
> > > This patch adds a binding that describes the Rockchip PCIe controller
> > > found on Rockchip SoCs PCIe interface.
> > > 
> > > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > > 
> > > ---
> > > 
> > > Changes in v4:
> > > - fix example of adding intermediate interrupt controller for pcie
> > >   legacy interrrupt
> > > 
> > > Changes in v3:
> > > - fix example dts code suggested by Rob and Marc
> > > - remove driver's behaviour of regulator
> > > 
> > > Changes in v2:
> > > - fix lots clk/reset stuff suggested by Heiko
> > > - remove msi-parent and add msi-map suggested by Marc
> > > - drop phy related stuff
> > > - some others minor fixes
> > > 
> > >  .../devicetree/bindings/pci/rockchip-pcie.txt      | 91 ++++++++++++++++++++++
> > >  1 file changed, 91 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> > > new file mode 100644
> > > index 0000000..8092fc5
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> > > @@ -0,0 +1,91 @@
> > > +* Rockchip AXI PCIe Root Port Bridge DT description
> > > +
> > > +Required properties:
> > > +- #address-cells: Address representation for root ports, set to <3>
> > > +- #size-cells: Size representation for root ports, set to <2>
> > > +- #interrupt-cells: specifies the number of cells needed to encode an
> > > +		interrupt source. The value must be 1.
> 
> I think this propoerty should be in a separate section, since it's going
> under a sub-node (not the main node). Right?
> 
> > > +- compatible: Should contain "rockchip,rk3399-pcie"
> > > +- reg: Two register ranges as listed in the reg-names property
> > > +- reg-names: Must include the following names
> > > +	- "axi-base"
> > > +	- "apb-base"
> > > +- clocks: Must contain an entry for each entry in clock-names.
> > > +		See ../clocks/clock-bindings.txt for details.
> > > +- clock-names: Must include the following entries:
> > > +	- "aclk"
> > > +	- "aclk-perf"
> > > +	- "hclk"
> > > +	- "pm"
> > > +- msi-map: Maps a Requester ID to an MSI controller and associated.
> > > +		See ./pci-msi.txt
> > > +- phys: From PHY bindings: Phandle for the Generic PHY for PCIe.
> > > +- phy-names:  MUST be "pcie-phy".
> > > +- interrupts: Three interrupt entries must be specified.
> > > +- interrupt-names: Must include the following names
> > > +	- "sys"
> > > +	- "legacy"
> > > +	- "client"
> > > +- resets: Must contain five entries for each entry in reset-names.
> > > +	   See ../reset/reset.txt for details.
> > > +- reset-names: Must include the following names
> > > +	- "core"
> > > +	- "mgmt"
> > > +	- "mgmt-sticky"
> > > +	- "pipe"
> > > +- pinctrl-names : The pin control state names
> > > +- pinctrl-0: The "default" pinctrl state
> > > +- interrupt-map-mask and interrupt-map: standard PCI properties
> > > +- interrupt-controller: identifies the node as an interrupt controller
> 
> Same with this property.
> 
> > > +
> > > +Optional Property:
> > > +- ep-gpios: contain the entry for pre-reset gpio
> > > +- num-lanes: number of lanes to use
> > > +- vpcie3v3-supply: The phandle to the 3.3v regulator to use for pcie.
> > > +- vpcie1v8-supply: The phandle to the 1.8v regulator to use for pcie.
> > > +- vpcie0v9-supply: The phandle to the 0.9v regulator to use for pcie.
> 
> e.g., you might start a new section here describing how this controller
> acts as an intermediate IRQ controller, and that the
> interrupt-controller-related properties should be placed under a subnode.
> (Did you also need an interrupt-parent property? I'm a little fuzzy on
> the details myself, actually...)
> 
> > > +
> > > +Example:
> > > +
> > > +pcie0: pcie@f8000000 {
> > > +	compatible = "rockchip,rk3399-pcie";
> > > +	#address-cells = <3>;
> > > +	#size-cells = <2>;
> > > +	clocks = <&cru ACLK_PCIE>, <&cru ACLK_PERF_PCIE>,
> > > +		 <&cru PCLK_PCIE>, <&cru SCLK_PCIE_PM>;
> > > +	clock-names = "aclk", "aclk-perf",
> > > +		      "hclk", "pm";
> > > +	bus-range = <0x0 0x1>;
> > > +	interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>,
> > > +		     <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
> > > +	interrupt-names = "sys", "legacy", "client";
> > > +	assigned-clocks = <&cru SCLK_PCIEPHY_REF>;
> > > +	assigned-clock-parents = <&cru SCLK_PCIEPHY_REF100M>;
> > > +	assigned-clock-rates = <100000000>;
> > > +	ep-gpios = <&gpio3 13 GPIO_ACTIVE_HIGH>;
> > > +	ranges = <0x83000000 0x0 0xfa000000 0x0 0xfa000000 0x0 0x600000
> > > +		  0x81000000 0x0 0xfa600000 0x0 0xfa600000 0x0 0x100000>;
> > > +	num-lanes = <4>;
> > > +	msi-map = <0x0 &its 0x0 0x1000>;
> > > +	reg = < 0x0 0xf8000000 0x0 0x2000000 >, < 0x0 0xfd000000 0x0 0x1000000 >;
> > > +	reg-names = "axi-base", "apb-base";
> > > +	resets = <&cru SRST_PCIE_CORE>, <&cru SRST_PCIE_MGMT>,
> > > +		 <&cru SRST_PCIE_MGMT_STICKY>, <&cru SRST_PCIE_PIPE>;
> > > +	reset-names = "core", "mgmt", "mgmt-sticky", "pipe";
> > > +	phys = <&pcie_phy>;
> > > +	phy-names = "pcie-phy";
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&pcie_clkreq>;
> > > +	#interrupt-cells = <1>;
> > > +	interrupt-controller;
> > 
> > So the pcie node itself is an interrupt controller...
> > 
> > > +	interrupt-map-mask = <0 0 0 7>;
> > > +	interrupt-map = <0 0 0 1 &pcie0_intc 1>,
> > > +			<0 0 0 2 &pcie0_intc 2>,
> > > +			<0 0 0 3 &pcie0_intc 3>,
> > > +			<0 0 0 4 &pcie0_intc 4>;
> > > +	pcie0_intc: interrupt-controller {
> > > +		interrupt-controller;
> > > +		#address-cells = <0>;
> > > +		#interrupt-cells = <1>;
> > > +	};
> > 
> > But there's also another here. I just don't understand how it works.
> 
> I believe the repeat of #interrupt-cells and interrupt-controller in the
> pcie@ node is a mistake. They should only be in the 'interrupt-controller'
> subnode. And in case this is what you're asking about... the subnode was
> present in v1 but was removed at your request:
> 
> From Marc, in https://patchwork.kernel.org/patch/9129183/:
> > > +static int rockchip_pcie_init_irq_domain(struct rockchip_pcie_port *pp)
> > > +{
> > > +	struct device *dev = pp->dev;
> > > +	struct device_node *node = dev->of_node;
> > > +	struct device_node *pcie_intc_node =  of_get_next_child(node, NULL);
> > 
> > That's really ugly, as it depends on the layout of your DT.
> > 
> > > +
> > > +	if (!pcie_intc_node) {
> > > +		dev_err(dev, "No PCIe Intc node found\n");
> > > +		return PTR_ERR(pcie_intc_node);
> > > +	}
> > > +	pp->irq_domain = irq_domain_add_linear(pcie_intc_node, 4,
> > > +					       &intx_domain_ops, pp);
> > 
> > Why can't you just register your host controller as the interrupt
> > controller? You don't need an intermediate node for that.
> 
> But then in v3, Arnd concluded it actually *should* be used:
> 
> From Arnd, in https://patchwork.kernel.org/patch/9179763/:
> > On Thursday, June 16, 2016 4:01:12 PM CEST Wenrui Li wrote:
> > > 在 2016/6/16 15:00, Arnd Bergmann 写道:
> > > > On Thursday, June 16, 2016 9:50:21 AM CEST Shawn Lin wrote:
> > > >
> > > >> +    reset-names = "core", "mgmt", "mgmt-sticky", "pipe";
> > > >> +    phys = <&pcie_phy>;
> > > >> +    phy-names = "pcie-phy";
> > > >> +    pinctrl-names = "default";
> > > >> +    pinctrl-0 = <&pcie_clkreq>;
> > > >> +    #interrupt-cells = <1>;
> > > >> +    interrupt-controller;
> > > >> +    interrupt-map-mask = <0 0 0 7>;
> > > >> +    interrupt-map = <0 0 0 1 &pcie0 1>,
> > > >> +                    <0 0 0 2 &pcie0 2>,
> > > >> +                    <0 0 0 3 &pcie0 3>,
> > > >> +                    <0 0 0 4 &pcie0 4>;
> > > >> +};
> > > >>
> > > >
> > > > One thing that came up in the review of the new Marvell PCIe driver is that it's
> > > > most likely invalid for a device node to have both "interrupt-controller"
> > > > and "interrupt-map" properties. I originally thought this was a nice way to
> > > > handle embedded irqchips within the PCIe host, but it only really works
> > > > by coincidence with the current kernel, and only as long as the hwirq number
> > > > of the irqchip matches the integer representation of the irq line in the root
> > > > bridge (which it does in the example above).
> > > >
> > > > For that driver we concluded that it would be less of a hack to have the
> > > > irqchip as a child node of the PCIe host after all (just not with
> > > > device_type="pci" of course), and that makes the translation work as
> > > > expected.
> > > >
> > > >       Arnd
> > > >
> > > 
> > > Original driver have an irqchip as child node. But Marc suggested don't 
> > > need an intermediate node here.
> > > Now the conclusion is to retain the child node?
> > 
> > That is at least my view of the situation, sorry for the mixed messages
> > you have been getting. Marc, Rob, do you agree with my finding?
> 
> Rob and others agreed with the subnode. So, I hope you don't disagree in
> principle, and are only confused by the duplicate properties?

Indeed. What I object to is the messed-up example, which in turns makes
the kernel code harder to review.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
