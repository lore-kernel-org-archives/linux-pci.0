Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57701 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbaDDJJC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Apr 2014 05:09:02 -0400
Message-ID: <1396602492.5625.4.camel@weser.hi.pengutronix.de>
Subject: Re: [PATCH v7 05/10] dt-bindings: pci: rcar pcie device tree
 bindings
From: Lucas Stach <l.stach@pengutronix.de>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	LAKML <linux-arm-kernel@lists.infradead.org>
Date: Fri, 04 Apr 2014 11:08:12 +0200
In-Reply-To: <1396261856-22465-6-git-send-email-phil.edworthy@renesas.com>
References: <1396261856-22465-1-git-send-email-phil.edworthy@renesas.com>
	 <1396261856-22465-6-git-send-email-phil.edworthy@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Montag, den 31.03.2014, 11:30 +0100 schrieb Phil Edworthy:
> This patch adds the bindings for the R-Car PCIe driver. The driver
> resides under drivers/pci/host/pcie-rcar.c
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

Another nitpick below, otherwise:
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

If you decide to roll another version with just this changed, feel free
to carry over the my tag.
> 
> v7:
>  - Change binding description of clocks to 'clock specifiers'
> 
> v6:
>  - Correct DT bindings description for reg and clocks
> 
> v5:
>  - Add PCIe bus clock reference
>  - Add additional interrupt bindings
>  - Use dma-ranges property to specify inbound memory regions
> ---
>  Documentation/devicetree/bindings/pci/rcar-pci.txt | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> new file mode 100644
> index 0000000..789bd46
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> @@ -0,0 +1,45 @@
> +* Renesas RCar PCIe interface
> +
> +Required properties:
> +- compatible: should contain one of the following
> +	"renesas,pcie-r8a7779", "renesas,pcie-r8a7790", "renesas,pcie-r8a7791"
> +- reg: base address and length of the pcie controller registers.
> +- #address-cells: set to <3>
> +- #size-cells: set to <2>
> +- device_type: set to "pci"
> +- ranges: ranges for the PCI memory and I/O regions.
> +- dma-ranges: ranges for the inbound memory regions.
> +- interrupts: two interrupt sources for MSI interrupts, followed by interrupt
> +	source for hardware related interrupts (e.g. link speed change).
> +- #interrupt-cells: set to <1>
> +- interrupt-map-mask and interrupt-map: standard PCI properties
> +	to define the mapping of the PCIe interface to interrupt
> +	numbers.
> +- clocks: from common clock binding: clock specifiers for the PCIe controller
> +	and PCIe bus clocks.
> +- clock-names: from common clock binding: should be "pcie" and "pcie_bus".
> +
> +Example:
> +
> +SoC specific DT Entry:
> +
> +	pcie: pcie@fe000000 {
> +		compatible = "renesas,pcie-r8a7791";
> +		reg = <0 0xfe000000 0 0x80000>;
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		device_type = "pci";
> +		ranges = <0x01000000 0 0x00000000 0 0xfe100000 0 0x00100000
> +			  0x02000000 0 0xfe200000 0 0xfe200000 0 0x00200000
> +			  0x02000000 0 0x30000000 0 0x30000000 0 0x08000000
> +			  0x42000000 0 0x38000000 0 0x38000000 0 0x08000000>;
> +		dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x40000000
> +			      0x42000000 2 0x00000000 2 0x00000000 0 0x40000000>;
> +		interrupts = <0 116 4 0 117 4 0 118 4>;

I think this is confusing, I would rather like to see them in separate
cells, like
	interrupts = <0 116 4>, <0 117 4>, <0 118 4>;

Same would be true for the ranges properties, but there it isn't as
confusing, so I don't really care.

> +		#interrupt-cells = <1>;
> +		interrupt-map-mask = <0 0 0 0>;
> +		interrupt-map = <0 0 0 0 &gic 0 116 4>;
> +		clocks = <&mstp3_clks R8A7791_CLK_PCIE>, <&pcie_bus_clk>;
> +		clock-names = "pcie", "pcie_bus";
> +		status = "disabled";
> +	};

-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

