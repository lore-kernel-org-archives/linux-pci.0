Return-Path: <SRS0=843H=47=arm.com=marc.zyngier@kernel.org>
Return-Path: <SRS0=843H=47=arm.com=marc.zyngier@kernel.org>
Subject: Re: [PATCH v4 2/2] PCI: Add tango PCIe host bridge support
To: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-pci <linux-pci@vger.kernel.org>
References: <d054300a-5891-0a25-8726-2be6b1beff6c@sigmadesigns.com>
 <4a354b33-d59c-4ebb-4b31-0388ac8090d4@sigmadesigns.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Robin Murphy
 <robin.murphy@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 LKML <linux-kernel@vger.kernel.org>, Mason <slash.tmp@free.fr>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <62bb805a-abd6-9aca-3641-8037f42a3b95@arm.com>
Date: Thu, 25 May 2017 09:48:30 +0100
MIME-Version: 1.0
In-Reply-To: <4a354b33-d59c-4ebb-4b31-0388ac8090d4@sigmadesigns.com>
Content-Type: text/plain; charset=iso-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 20/04/17 15:31, Marc Gonzalez wrote:
> This driver is required to work around several hardware bugs in the
> PCIe controller.
> 
> NB: Revision 1 does not support legacy interrupts, or IO space.
> 
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
>  Documentation/devicetree/bindings/pci/tango-pcie.txt |  32 ++++++++
>  drivers/pci/host/Kconfig                             |   8 ++
>  drivers/pci/host/Makefile                            |   1 +
>  drivers/pci/host/pcie-tango.c                        | 161 +++++++++++++++++++++++++++++++++++++++
>  include/linux/pci_ids.h                              |   2 +
>  5 files changed, 204 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/tango-pcie.txt b/Documentation/devicetree/bindings/pci/tango-pcie.txt
> new file mode 100644
> index 000000000000..3353b4e77309
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/tango-pcie.txt
> @@ -0,0 +1,32 @@
> +Sigma Designs Tango PCIe controller
> +
> +Required properties:
> +
> +- compatible: "sigma,smp8759-pcie"
> +- reg: address/size of PCI configuration space, address/size of register area
> +- device_type: "pci"
> +- #size-cells: <2>
> +- #address-cells: <3>
> +- #interrupt-cells: <1>

What is the point of having an #interrupt-cells when this is *not* an
interrupt controller (as it doesn't support legacy interrupts)?

> +- ranges: translation from system to bus addresses
> +- interrupts: spec for misc interrupts, spec for MSI
> +- msi-controller
> +
> +http://elinux.org/Device_Tree_Usage#PCI_Address_Translation
> +http://elinux.org/Device_Tree_Usage#Advanced_Interrupt_Mapping
> +
> +Example:
> +
> +	pcie@2e000 {
> +		compatible = "sigma,smp8759-pcie";
> +		reg = <0x50000000 SZ_4M>, <0x2e000 0x100>;
> +		device_type = "pci";
> +		#size-cells = <2>;
> +		#address-cells = <3>;
> +		#interrupt-cells = <1>;
> +		ranges = <0x02000000 0x0 0x00400000  0x50400000  0x0 SZ_60M>;
> +		msi-controller;
> +		interrupts =
> +			<54 IRQ_TYPE_LEVEL_HIGH>, /* misc interrupts */
> +			<55 IRQ_TYPE_LEVEL_HIGH>; /* MSI */
> +	};

As mentioned earlier, this needs to be a separate patch to be reviewed
by the Keepers of the Faith (aka the DT maintainers).

[...]

> +static int smp8759_init(struct tango_pcie *pcie, void __iomem *base)
> +{
> +	pcie->mux		= base + 0x48;
> +	pcie->msi_status	= base + 0x80;
> +	pcie->msi_enable	= base + 0xa0;
> +	pcie->msi_doorbell	= 0xa0000000 + 0x2e07c;
> +
> +	return tango_check_pcie_link(base + 0x74);

Please have some defines for these magic values.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
