Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51391 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423355AbcFHJYE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 8 Jun 2016 05:24:04 -0400
Subject: Re: [PATCH v2 1/2] Documentation: bindings: add dt doc for Rockchip
 PCIe controller
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>
References: <1465373117-823-1-git-send-email-shawn.lin@rock-chips.com>
Cc: linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
	Heiko Stuebner <heiko@sntech.de>,
	Doug Anderson <dianders@chromium.org>,
	Wenrui Li <wenrui.li@rock-chips.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <5757E430.7020804@arm.com>
Date: Wed, 8 Jun 2016 10:24:00 +0100
MIME-Version: 1.0
In-Reply-To: <1465373117-823-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/06/16 09:05, Shawn Lin wrote:
> This patch adds a binding that describes the Rockchip PCIe controller
> found on Rockchip SoCs PCIe interface.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> 
> Changes in v2:
> - fix lots clk/reset stuff suggested by Heiko
> - remove msi-parent and add msi-map suggested by Marc
> - drop phy related stuff
> - some others minor fixes
> 
>  .../devicetree/bindings/pci/rockchip-pcie.txt      | 86 ++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> new file mode 100644
> index 0000000..eb92e29
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> @@ -0,0 +1,86 @@
> +* Rockchip AXI PCIe Root Port Bridge DT description
> +
> +Required properties:
> +- #address-cells: Address representation for root ports, set to <3>
> +- #size-cells: Size representation for root ports, set to <2>
> +- #interrupt-cells: specifies the number of cells needed to encode an
> +		interrupt source. The value must be 1.
> +- compatible: Should contain "rockchip,rk3399-pcie"
> +- reg: Two register ranges as listed in the reg-names property
> +- reg-names: Must include the following names
> +	- "axi-base"
> +	- "apb-base"
> +- clocks: Must contain an entry for each entry in clock-names.
> +		See ../clocks/clock-bindings.txt for details.
> +- clock-names: Must include the following entries:
> +	- "aclk"
> +	- "aclk-perf"
> +	- "hclk"
> +	- "pm"
> +- phys: From PHY bindings: Phandle for the Generic PHY for PCIe.
> +- phy-names:  MUST be "pcie-phy".
> +- interrupts: Three interrupt entries must be specified.
> +- interrupt-names: Must include the following names
> +	- "sys"
> +	- "legacy"
> +	- "client"
> +- resets: Must contain five entries for each entry in reset-names.
> +	   See ../reset/reset.txt for details.
> +- reset-names: Must include the following names
> +	- "core"
> +	- "mgmt"
> +	- "mgmt-sticky"
> +	- "pipe"
> +- pinctrl-names : The pin control state names
> +- pinctrl-0: The "default" pinctrl state
> +- interrupt-map-mask and interrupt-map: standard PCI properties
> +- interrupt-controller: identifies the node as an interrupt controller
> +
> +Optional Property:
> +- ep-gpios: contain the entry for pre-reset gpio
> +- num-lanes: number of lanes to use
> +- vpcie3v3-supply: The phandle to the 3.3v regulator to use for pcie. If this
> +  is specified we'll defer probe until we can find this regulator.
> +- vpcie1v8-supply: The phandle to the 1.8v regulator to use for pcie. If this
> +  is specified we'll defer probe until we can find this regulator.
> +- vpcie0v9-supply: The phandle to the 0.9v regulator to use for pcie. If this
> +  is specified we'll defer probe until we can find this regulator.

Please do not describe the behaviour of the driver here.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
