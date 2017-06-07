Return-Path: <SRS0=zXS0=5M=gmail.com=robherring2@kernel.org>
Return-Path: <SRS0=zXS0=5M=gmail.com=robherring2@kernel.org>
Date: Wed, 7 Jun 2017 16:29:07 -0500
From: Rob Herring <robh@kernel.org>
To: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	David Laight <david.laight@aculab.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
	Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
	LKML <linux-kernel@vger.kernel.org>,
	DT <devicetree@vger.kernel.org>, Mason <slash.tmp@free.fr>
Subject: Re: [PATCH v5 1/3] PCI: Add DT binding for tango PCIe controller
Message-ID: <20170607212907.2wr3hqbokjb74kj3@rob-hp-laptop>
References: <741766e5-cff2-db5f-d40b-6866e08fd966@sigmadesigns.com>
 <69f3ffe7-3c39-fa94-71f8-91744a869cc9@sigmadesigns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <69f3ffe7-3c39-fa94-71f8-91744a869cc9@sigmadesigns.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 31, 2017 at 03:30:26PM +0200, Marc Gonzalez wrote:
> Binding for the Sigma Designs SMP8759 SoC.
> 
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
>  Documentation/devicetree/bindings/pci/tango-pcie.txt | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/tango-pcie.txt b/Documentation/devicetree/bindings/pci/tango-pcie.txt
> new file mode 100644
> index 000000000000..35ef2c811a27
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/tango-pcie.txt
> @@ -0,0 +1,30 @@
> +Sigma Designs Tango PCIe controller
> +
> +Required properties:
> +
> +- compatible: "sigma,smp8759-pcie"
> +- reg: address/size of PCI configuration space, address/size of register area
> +- device_type: "pci"
> +- #size-cells: <2>
> +- #address-cells: <3>
> +- msi-controller
> +- ranges: translation from system to bus addresses
> +- interrupts: spec for misc interrupts, spec for MSI
> +
> +http://elinux.org/Device_Tree_Usage#PCI_Address_Translation
> +http://elinux.org/Device_Tree_Usage#Advanced_Interrupt_Mapping

Why are these here?

There's several standard properties you are missing like bus-range. 
Build your dts with "W=2". dtc recently gained some checks for PCI 
bindings.

> +
> +Example:
> +
> +	pcie@2e000 {
> +		compatible = "sigma,smp8759-pcie";
> +		reg = <0x50000000 SZ_4M>, <0x2e000 0x100>;
> +		device_type = "pci";
> +		#size-cells = <2>;
> +		#address-cells = <3>;
> +		msi-controller;
> +		ranges = <0x02000000 0x0 0x00400000  0x50400000  0x0 SZ_60M>;

I don't think SZ_60M exists or is available to dts files. Just put the 
number in.

> +		interrupts =
> +			<54 IRQ_TYPE_LEVEL_HIGH>, /* misc interrupts */
> +			<55 IRQ_TYPE_LEVEL_HIGH>; /* MSI */
> +	};
> -- 
> 2.11.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
