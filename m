Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37362 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756015AbaCULYc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Mar 2014 07:24:32 -0400
Message-ID: <1395401031.4554.9.camel@weser.hi.pengutronix.de>
Subject: Re: [PATCH v4 5/9] dt-bindings: pci: rcar pcie device tree bindings
From: Lucas Stach <l.stach@pengutronix.de>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	LAKML <linux-arm-kernel@lists.infradead.org>
Date: Fri, 21 Mar 2014 12:23:51 +0100
In-Reply-To: <1395397968-6242-6-git-send-email-phil.edworthy@renesas.com>
References: <1395397968-6242-1-git-send-email-phil.edworthy@renesas.com>
	 <1395397968-6242-6-git-send-email-phil.edworthy@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Freitag, den 21.03.2014, 10:32 +0000 schrieb Phil Edworthy:
> This patch adds the bindings for the rcar PCIE driver. The driver
> resides under drivers/pci/host/pcie-rcar.c
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

I have one question below. If you can answer this with yes after
thinking again about it, this is:

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/pci/rcar-pci.txt | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> new file mode 100644
> index 0000000..0e219b0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> @@ -0,0 +1,40 @@
> +* Renesas RCar PCIe interface
> +
> +Required properties:
> +- compatible: should contain one of the following
> +	"renesas,r8a7779-pcie", "renesas,r8a7790-pcie", "renesas,r8a7791-pcie"
> +- reg: base addresses and lengths of the pcie controller.
> +- #address-cells: set to <3>
> +- #size-cells: set to <2>
> +- device_type: set to "pci"
> +- ranges: ranges for the PCI memory and I/O regions
> +- interrupts: interrupt values for MSI interrupt
> +- #interrupt-cells: set to <1>
> +- interrupt-map-mask and interrupt-map: standard PCI properties
> +	to define the mapping of the PCIe interface to interrupt
> +	numbers.
> +- clocks: from common clock binding: handle to pci clock.
> +- clock-names: from common clock binding: should be "pcie"

You really only have one PCIe clock? So the controller is generating the
PCIe bus clock from it's register clock? No need to enable any other
clock for PCIe to work?

> +
> +Example:
> +
> +SoC specific DT Entry:
> +
> +	pcie: pcie@0x01000000 {
> +		compatible = "renesas,r8a7790-pcie";
> +		reg = <0 0xfe000000 0 0x80000>;
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		device_type = "pci";
> +		ranges = <0x01000000 0 0x00000000 0 0xfe100000 0 0x00100000
> +			  0x02000000 0 0xfe200000 0 0xfe200000 0 0x00200000
> +			  0x02000000 0 0x30000000 0 0x30000000 0 0x08000000
> +			  0x42000000 0 0x38000000 0 0x38000000 0 0x08000000>;
> +		interrupts = <0 116 4>;
> +		#interrupt-cells = <1>;
> +		interrupt-map-mask = <0 0 0 0>;
> +		interrupt-map = <0 0 0 0 &gic 0 116 4>;
> +		clocks = <&mstp3_clks R8A7790_CLK_PCIE>;
> +		clock-names = "pcie";
> +		status = "disabled";
> +	};

-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

