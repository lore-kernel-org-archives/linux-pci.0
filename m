Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54742 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751151AbeCIQbQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Mar 2018 11:31:16 -0500
Date: Fri, 9 Mar 2018 16:31:37 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, mingkai.hu@nxp.com,
        peter.newton@nxp.com, minghuan.lian@nxp.com, rajesh.raina@nxp.com,
        rajan.kapoor@nxp.com, prabhjot.singh@nxp.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/3] PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP
 driver DT bindings
Message-ID: <20180309163129.GA10137@red-moon>
References: <1519733991-32198-1-git-send-email-l.subrahmanya@mobiveil.co.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1519733991-32198-1-git-send-email-l.subrahmanya@mobiveil.co.in>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 27, 2018 at 07:19:51AM -0500, Subrahmanya Lingappa wrote:
> This patch adds the DT bindings for Mobiveil PCIe Host Bridge
> IP driver and updates the vendor prefixes file.
> 
> Signed-off-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> Acked-by: Rob Herring <robh@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: linux-pci@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> ---
>  .../devicetree/bindings/pci/mobiveil-pcie.txt      | 73 ++++++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.txt        |  1 +
>  MAINTAINERS                                        |  7 +++
>  3 files changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt b/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
> new file mode 100644
> index 0000000..e9dd1e8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
> @@ -0,0 +1,73 @@
> +* Mobiveil AXI PCIe Root Port Bridge DT description
> +
> +Mobiveil's GPEX 4.0 is a PCIe Gen4 root port bridge IP. This configurable IP
> +has up to 8 outbound and inbound windows for the address translation.
> +
> +Required properties:
> +- #address-cells: Address representation for root ports, set to <3>
> +- #size-cells: Size representation for root ports, set to <2>
> +- #interrupt-cells: specifies the number of cells needed to encode an
> +	interrupt source. The value must be 1.
> +- compatible: Should contain "mbvl,gpex40-pcie"
> +- reg: Should contain PCIe registers location and length
> +	"config_axi_slave": PCIe controller registers
> +	"csr_axi_slave"	  : Bridge config registers
> +	"gpio_slave"	  : GPIO registers to control slot power
> +	"apb_csr"	  : MSI registers
> +
> +- device_type: must be "pci"
> +- apio-wins : number of requested apio outbound windows
> +		default 2 outbound windows are configured -
> +		1. Config window
> +		2. Memory window
> +- ppio-wins : number of requested ppio inbound windows
> +		default 1 inbound memory window is configured.
> +- bus-range: PCI bus numbers covered
> +- interrupt-controller: identifies the node as an interrupt controller
> +- #interrupt-cells: specifies the number of cells needed to encode an
> +	interrupt source. The value must be 1.
> +- interrupt-parent : phandle to the interrupt controller that
> +		it is attached to, it should be set to gic to point to
> +		ARM's Generic Interrupt Controller node in system DT.
> +- interrupts: The interrupt line of the PCIe controller
> +		last cell of this field is set to 4 to
> +		denote it as IRQ_TYPE_LEVEL_HIGH type interrupt.
> +- interrupt-map-mask,
> +	interrupt-map: standard PCI properties to define the mapping of the
> +	PCI interface to interrupt numbers.
> +- ranges: ranges for the PCI memory regions (I/O space region is not
> +	supported by hardware)
> +	Please refer to the standard PCI bus binding document for a more
> +	detailed explanation
> +
> +
> +Example:
> +++++++++
> +	pcie0: pcie@a0000000 {
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		compatible = "mbvl,gpex40-pcie";
> +		reg =	<0xa0000000 0x00001000>,
> +			<0xb0000000 0x00010000>,
> +			<0xff000000 0x00200000>,
> +			<0xb0010000 0x00001000>;
> +		reg-names =	"config_axi_slave",
> +				"csr_axi_slave",
> +				"gpio_slave",
> +				"apb_csr";
> +		device_type = "pci";
> +		apio-wins = <2>;
> +		ppio-wins = <1>;
> +		bus-range = <0x00000000 0x000000ff>;
> +		interrupt-controller;
> +		interrupt-parent = <&gic>;
> +		#interrupt-cells = <1>;
> +		interrupts = < 0 89 4 >;
> +		interrupt-map-mask = <0 0 0 7>;
> +		interrupt-map = <0 0 0 1 &pci_express 1>,
> +				<0 0 0 2 &pci_express 2>,
> +				<0 0 0 3 &pci_express 3>,
> +				<0 0 0 4 &pci_express 4>;

This is wrong and it is the root cause of all the INTX mapping
shenanigans in the PCI host bridge legacy IRQ domain.

IIUC we are mapping INTx to input [0,1,2,3] in the host bridge
interrupt combiner, starting from 0 not 1.

This would remove all the bogus (INTX + 1) in kernel code that are there
to cope with this erroneous DT binding.

Yes - there are existing bindings that are wrong as well but we can't
change them since they would trigger regressions.

This one is new, let's get it done properly from the beginning.

Thanks,
Lorenzo

> +		ranges = < 0x83000000 0 0x00000000 0xa8000000 0 0x8000000>;
> +
> +	};
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 0994bdd..8263cc7 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -197,6 +197,7 @@ lwn	Liebherr-Werk Nenzing GmbH
>  macnica	Macnica Americas
>  marvell	Marvell Technology Group Ltd.
>  maxim	Maxim Integrated Products
> +mbvl	Mobiveil Inc.
>  mcube	mCube
>  meas	Measurement Specialties
>  mediatek	MediaTek Inc.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 44512c3..b295080 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9162,6 +9162,13 @@ Q:	http://patchwork.linuxtv.org/project/linux-media/list/
>  S:	Maintained
>  F:	drivers/media/dvb-frontends/mn88473*
>  
> +PCI DRIVER FOR MOBIVEIL PCIE IP
> +M:	Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> +L:	linux-pci@vger.kernel.org
> +S:	Supported
> +F:	Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
> +F:	drivers/pci/host/pcie-mobiveil.c
> +
>  MODULE SUPPORT
>  M:	Jessica Yu <jeyu@kernel.org>
>  M:	Rusty Russell <rusty@rustcorp.com.au>
> -- 
> 1.8.3.1
> 
