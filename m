Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:60015 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754218AbcETLUY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 20 May 2016 07:20:24 -0400
From: Heiko Stuebner <heiko@sntech.de>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Wenrui Li <wenrui.li@rock-chips.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Documentation: add binding description of Rockchip PCIe controller
Date: Fri, 20 May 2016 13:20:06 +0200
Message-ID: <3930626.4a3xBnzHhK@phil>
In-Reply-To: <1463740146-7106-1-git-send-email-shawn.lin@rock-chips.com>
References: <1463740105-7061-1-git-send-email-shawn.lin@rock-chips.com> <1463740146-7106-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Shawn,

Am Freitag, 20. Mai 2016, 18:29:06 schrieb Shawn Lin:
> This patch add some required and optional properties for Rockchip
> PCIe controller. Also we add a example for how to use it.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> 
>  .../devicetree/bindings/pci/rockchip-pcie.txt      | 93
> ++++++++++++++++++++++ 1 file changed, 93 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt new file mode
> 100644
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

clock names are always in the scope of the node/driver, so the names could 
easily be "aclk", "aclk-perf", "hclk", "phy".

Although from my cursory-glance at the phy-related code, it looks more like 
it shouldn't be in the pcie-driver itself, but in a an actual phy-driver 
(together with the phy reset and clock)?

> +- interrupts: Three interrupt entries must be specified.
> +- interrupt-names: Must include the following names
> +	- "pcie-sys"
> +	- "pcie-legacy"
> +	- "pcie-client"

Same as above, names could simply be "sys", "legacy", "client"


> +- resets: Must contain five entries for each entry in reset-names.
> +	   See ../reset/reset.txt for details.
> +- reset-names: Must include the following names
> +	- "phy-rst"
> +	- "core-rst"
> +	- "mgmt-rst"
> +	- "mgmt-sticky-rst"
> +	- "pipe-rst"

and again (= without the "-rst")


> +- rockchip,grf: phandle to the syscon managing the "general register
> files" 

> +- pcie-conf: offset of pcie client block for  configuration
> +- pcie-status: offset of pcie client block for status
> +- pcie-laneoff: offset of pcie client block for lane

These are GRF offsets (GRF_SOC_CON8, GRF_SOC_CON5_PCIE, GRF_SOC_STATUS1)
Those registers are generally prone to change (even their layout) for future 
socs and I'd suggest instead of declaring them in the devicetree, move them 
to the per-soc data in the rockchip_pcie_of_match struct.

But it looks as if they're pretty phy-specific, so see comment about possible 
separate phy driver above.


> +- msi-parent: Link to the hardware entity that serves as the Message
> +- pinctrl-names : The pin control state names
> +- pinctrl-0: The "default" pinctrl state

I'm not sure if pinctrl-properties need to be described when you don't need 
special handling in the form of additional pin states. The pcie part does 
not do any pin-handling of its own.


> +- interrupt-map-mask and interrupt-map: standard PCI properties
> +- interrupt-controller: identifies the node as an interrupt controller
> +
> +Optional Property:
> +- ep-gpios: contain the entry for pre-reset gpio
> +- num-lanes: number of lanes to use
> +- assigned-clocks, assigned-clock-parents and assigned-clock-rates:
> standard +		   clock bindings. See ../clock/clock-bindings.txt

Again that (assigned-clocks handling) is not actual part of the pci-
controllers actions, but other parts and also described already elsewhere.


Heiko
