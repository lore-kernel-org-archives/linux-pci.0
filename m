Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:56491 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771AbaCYVAU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Mar 2014 17:00:20 -0400
Date: Tue, 25 Mar 2014 14:00:16 -0700
From: Simon Horman <horms@verge.net.au>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: linux-pci@vger.kernel.org, linux-sh@vger.kernel.org,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH v5 7/9] ARM: shmobile: Add PCIe device tree nodes for
 R8A7791 Koelsch board
Message-ID: <20140325210016.GC27673@verge.net.au>
References: <1395766604-30926-1-git-send-email-phil.edworthy@renesas.com>
 <1395766604-30926-8-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1395766604-30926-8-git-send-email-phil.edworthy@renesas.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 25, 2014 at 04:56:42PM +0000, Phil Edworthy wrote:
> This patch adds the device tree nodes for the R8A7791 Koelsch board

Please split this patch into two patches.

1. A patch that updates arch/arm/boot/dts/r8a7791.dtsi

   I suggest calling that patch
   "ARM: shmobile: r8a7791: Add PCI device nodes"

2. A patch that updates arch/arm/boot/dts/r8a7791-koelsch.dts

   I suggest calling that patch
   "ARM: shmobile: koelsch: Add PCI device nodes"

> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
> v5:
>  - Renesas SoCs compatible string has peripheral before device name
>  - Add PCIe bus clock reference
>  - Add additional interrupt bindings
>  - Use dma-ranges property to specify inbound memory regions
> ---
>  arch/arm/boot/dts/r8a7791-koelsch.dts | 14 ++++++++++++++
>  arch/arm/boot/dts/r8a7791.dtsi        | 24 ++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
> index ee23b7b..3130a0c 100644
> --- a/arch/arm/boot/dts/r8a7791-koelsch.dts
> +++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
> @@ -204,6 +204,16 @@
>  		states = <3300000 1
>  			  1800000 0>;
>  	};
> +
> +	clocks {
> +		/* External PCIe bus clock */
> +		pcie_bus_clk: pcie_bus_clk {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <100000000>;
> +			clock-output-names = "pcie_bus";
> +		};
> +	};
>  };
>  
>  &extal_clk {
> @@ -382,3 +392,7 @@
>  		spi-cpha;
>  	};
>  };
> +
> +&pcie {
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
> index ccfba57..7a4be4c 100644
> --- a/arch/arm/boot/dts/r8a7791.dtsi
> +++ b/arch/arm/boot/dts/r8a7791.dtsi
> @@ -836,4 +836,28 @@
>  		#size-cells = <0>;
>  		status = "disabled";
>  	};
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
> +		/* Map all possible DDR as inbound ranges */
> +		dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x80000000
> +			      0x43000000 2 0x00000000 2 0x00000000 1 0x00000000>;
> +		interrupts = <0 116 IRQ_TYPE_LEVEL_HIGH
> +			      0 117 IRQ_TYPE_LEVEL_HIGH
> +			      0 118 IRQ_TYPE_LEVEL_HIGH>;
> +		#interrupt-cells = <1>;
> +		interrupt-map-mask = <0 0 0 0>;
> +		interrupt-map = <0 0 0 0 &gic 0 116 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp3_clks R8A7791_CLK_PCIE>, <&pcie_bus_clk>;
> +		clock-names = "pcie", "pcie_bus";
> +		status = "disabled";
> +	};
>  };
> -- 
> 1.9.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
