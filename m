Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:37430 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877AbaCYTWR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Mar 2014 15:22:17 -0400
Received: by mail-lb0-f181.google.com with SMTP id c11so723210lbj.26
        for <linux-pci@vger.kernel.org>; Tue, 25 Mar 2014 12:22:15 -0700 (PDT)
Message-ID: <5331E576.2000202@cogentembedded.com>
Date: Tue, 25 Mar 2014 23:22:14 +0300
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
To: Phil Edworthy <phil.edworthy@renesas.com>,
	linux-pci@vger.kernel.org
CC: linux-sh@vger.kernel.org,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5 5/9] dt-bindings: pci: rcar pcie device tree bindings
References: <1395766604-30926-1-git-send-email-phil.edworthy@renesas.com> <1395766604-30926-6-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1395766604-30926-6-git-send-email-phil.edworthy@renesas.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello.

On 03/25/2014 07:56 PM, Phil Edworthy wrote:

> This patch adds the bindings for the R-Car PCIe driver. The driver
> resides under drivers/pci/host/pcie-rcar.c

> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
> v5:
>   - Add PCIe bus clock reference
>   - Add additional interrupt bindings
>   - Use dma-ranges property to specify inbound memory regions
> ---
>   Documentation/devicetree/bindings/pci/rcar-pci.txt | 44 ++++++++++++++++++++++
>   1 file changed, 44 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci.txt
>
> diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> new file mode 100644
> index 0000000..61bf5ef
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> @@ -0,0 +1,44 @@
> +* Renesas RCar PCIe interface
> +
> +Required properties:
> +- compatible: should contain one of the following
> +	"renesas,pcie-r8a7779", "renesas,pcie-r8a7790", "renesas,pcie-r8a7791"
> +- reg: base addresses and lengths of the pcie controller.

    Hmm, need "registers" at end. And why plural?

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
> +- clocks: from common clock binding: handle to pci clock.

    s/handle/phandle/, s/pci/PCI/.
    Actually, it's a clock specifier consisting not only of phandle but also 
of clock #. Looking at your example, it's even a pair of clock specifiers.

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

    Hmm, this prop looks board-dependent...

> +		interrupts = <0 116 4 0 117 4 0 118 4>;
> +		#interrupt-cells = <1>;
> +		interrupt-map-mask = <0 0 0 0>;
> +		interrupt-map = <0 0 0 0 &gic 0 116 4>;
> +		clocks = <&mstp3_clks R8A7791_CLK_PCIE>, <&pcie_bus_clk>;
> +		clock-names = "pcie", "pcie_bus";
> +		status = "disabled";
> +	};

WBR, Sergei

