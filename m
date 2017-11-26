Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34476 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751510AbdKZTca (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 26 Nov 2017 14:32:30 -0500
Date: Sun, 26 Nov 2017 13:32:26 -0600
From: Rob Herring <robh@kernel.org>
To: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Cc: bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, adouglas@cadence.com,
        stelford@cadence.com, dgary@cadence.com, kgopi@cadence.com,
        eandrews@cadence.com, thomas.petazzoni@free-electrons.com,
        sureshp@cadence.com, nsekhar@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: PCI: cadence: Add DT bindings for
 Cadence PCIe host controller
Message-ID: <20171126193226.7574sd3ftlr3j2fq@rob-hp-laptop>
References: <cover.1511439189.git.cyrille.pitchen@free-electrons.com>
 <895cbb8f862c712b78f780a53e05d5429d24cc35.1511439189.git.cyrille.pitchen@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <895cbb8f862c712b78f780a53e05d5429d24cc35.1511439189.git.cyrille.pitchen@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 23, 2017 at 04:01:47PM +0100, Cyrille Pitchen wrote:
> From: Scott Telford <stelford@cadence.com>
> 
> This patch adds documentation for the DT bindings of the Cadence PCIe
> controller when configured in host (Root Complex) mode.
> 
> Signed-off-by: Scott Telford <stelford@cadence.com>
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
> 
> dt-bindings: PCI: cadence: host fixup
> ---
>  .../bindings/pci/cdns,cdns-pcie-host.txt           | 54 ++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt

A few nits, otherwise:

Acked-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
> new file mode 100644
> index 000000000000..4b3df8ffd5e1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
> @@ -0,0 +1,54 @@
> +* Cadence PCIe host controller
> +
> +This PCIe controller inherits the base properties defined in
> +host-generic-pci.txt.
> +
> +Required properties:
> +- compatible: should contain "cdns,cdns-pcie-host" to identify the IP used.
> +- reg: Should contain the PCIe configuration window base address, controller
> +  register base address, and AXI interface region base address respectively.
> +- reg-names: Must be "cfg", "reg" and "mem" respectively.
> +- #address-cells: set to <3>
> +- #size-cells: set to <2>
> +- device_type: set to "pci"
> +- ranges: ranges for the PCI memory and I/O regions
> +- #interrupt-cells: set to <1>
> +- interrupt-map-mask and interrupt-map: standard PCI
> +	properties to define the mapping of the PCIe interface to interrupt
> +	numbers.
> +
> +Example:
> +
> +	pci@fb000000 {

pcie@...

Usually the first address is the unit-address, so either change the 
order in reg or change this.

> +		compatible = "cdns,cdns-pcie-host";
> +		device_type = "pci";
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		bus-range = <0x0 0xff>;
> +		linux,pci-domain = <0>;
> +
> +		// CPU_PHYSICAL(2)  SIZE(2)

Drop the comment. If you know what 'reg' is then it is obvious. Also, 
don't use C++ style comments.

> +		reg = <0x0 0x41000000  0x0 0x00001000>, /* Config space */
> +		      <0x0 0xfb000000  0x0 0x01000000>, /* Base Address */
> +		      <0x0 0x40000000  0x0 0x04000000>; /* AXI region */
> +		reg-names = "cfg", "reg", "mem";
> +
> +		// BUS_ADDRESS(3)  CPU_PHYSICAL(1)  SIZE(2)

ditto

> +		ranges =
> +			<0x02000000 0x0 0x42000000  0x0 0x42000000  0x0 0x1000000>,
> +			<0x01000000 0x0 0x43000000  0x0 0x43000000  0x0 0x0010000>;
> +
> +
> +		#interrupt-cells = <0x1>;
> +
> +		// PCI_DEVICE(3)  INT#(1)  CONTROLLER(PHANDLE)  CONTROLLER_DATA(5)
> +		interrupt-map = <0x0 0x0 0x0  0x1  &gic  0x0 0x0 0x0 14 0x1
> +				 0x0 0x0 0x0  0x2  &gic  0x0 0x0 0x0 15 0x1
> +				 0x0 0x0 0x0  0x3  &gic  0x0 0x0 0x0 16 0x1
> +				 0x0 0x0 0x0  0x4  &gic  0x0 0x0 0x0 17 0x1>;
> +
> +		// PCI_DEVICE(3)  INT#(1)
> +		interrupt-map-mask = <0x0000 0x0 0x0  0x7>;
> +
> +		msi-parent = <&its_pci>;
> +	};
> -- 
> 2.11.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
