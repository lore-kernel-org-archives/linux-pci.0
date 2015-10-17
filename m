Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	michal.simek@xilinx.com, soren.brinkmann@xilinx.com,
	bhelgaas@google.com, tinamdar@apm.com, treding@nvidia.com,
	rjui@broadcom.com, Minghuan.Lian@freescale.com,
	m-karicheri2@ti.com, hauke@hauke-m.de, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bharat Kumar Gogada <bharatku@xilinx.com>,
	Ravi Kiran Gummaluri <rgummal@xilinx.com>
Subject: Re: [PATCH v4] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL PCIe Host Controller
Date: Sat, 17 Oct 2015 13:49:25 +0200
Message-ID: <5705956.6YyKSO4LdH@wuerfel>
In-Reply-To: <1445066538-24638-1-git-send-email-bharatku@xilinx.com>
References: <1445066538-24638-1-git-send-email-bharatku@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Saturday 17 October 2015 12:52:18 Bharat Kumar Gogada wrote:
> +       "msi_1, msi_0": interrupt asserted when msi is recieved

Better avoid underscores in DT, use "msi0" instead of "msi_0".

> +- interrupt-map-mask and interrupt-map: standard PCI properties to define the
> +       mapping of the PCI interface to interrupt numbers.
> +- ranges: ranges for the PCI memory regions (I/O space region is not
> +       supported by hardware)
> +       Please refer to the standard PCI bus binding document for a more
> +       detailed explanation
> +- msi-controller: indicates that this is MSI controller node
> +- msi-parent:  MSI parent of the root complex itself
> +- pcie_intc: Interrupt controller device node for Legacy interrupts
> +       - interrupt-controller: identifies the node as an interrupt controller
> +       - #interrupt-cells: should be set to 1
> +       - #address-cells: specifies the number of cells needed to encode an
> +               address. The value must be 0.

The name doesn't match: below, the name is "legacy-interrupt-controller",
not "pcie_intc". I suppose it should really be "interrupt-controller"
anyway.

> +
> +Example:
> +++++++++
> +
> +nwl_pcie: pcie@fd0e0000 {
> +       #address-cells = >;
> +       #size-cells = <2>;
> +       compatible = "xlnx,nwl-pcie-2.11";
> +       #interrupt-cells = <1>;
> +       msi-controller;
> +       device_type = "pci";
> +       interrupt-parent = <&gic>;
> +       interrupts = < 0 118 4
> +                      0 116 4
> +                      0 115 4          // MSI_1 [63...32]
> +                      0 114 4 >;       // MSI_0 [31...0]

Better write these as tuples:

	interrupts = <0 118 4>, <0 116 4>, <0 115 4>, <0 114 4>;

And maybe reverse the order? It looks that might be what the
soc integration person had in mind.

Also, what is interrupt <0 117 4>? Is that connected here as well?
Better list it as well then, even if you don't use it.

> +       interrupt-map-mask = <0x0 0x0 0x0 0x7>;
> +       interrupt-map = <0x0 0x0 0x0 0x1 &pcie_intc 0x1
> +                        0x0 0x0 0x0 0x2 &pcie_intc 0x2
> +                        0x0 0x0 0x0 0x3 &pcie_intc 0x3
> +                        0x0 0x0 0x0 0x4 &pcie_intc 0x4>;

> +       msi-parent = <&nwl_pcie>;
> +       reg = <0x0 0xfd0e0000 0x1000
> +              0x0 0xfd480000 0x1000
> +              0x0 0xE0000000 0x1000000>;

Same grouping for reg and interrupt-map as above for interrupts.

> +       reg-names = "breg", "pcireg", "cfg";
> +       ranges = <0x02000000 0x00000000 0xE1000000 0x00000000 0xE1000000 0 0x0F000000>;

No I/O space or prefetcheable memory?

	Arnd
