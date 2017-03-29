Return-Path: <SRS0=q2b8=3G=arm.com=robin.murphy@kernel.org>
Return-Path: <SRS0=q2b8=3G=arm.com=robin.murphy@kernel.org>
Subject: Re: [PATCH v3 2/2] PCI: Add tango PCIe host bridge support
To: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>
References: <5309e718-5813-5b79-db57-9d702b50d0f9@sigmadesigns.com>
 <65114e62-7458-b6f7-327c-f07a5096a452@sigmadesigns.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 LKML <linux-kernel@vger.kernel.org>, DT <devicetree@vger.kernel.org>,
 Mason <slash.tmp@free.fr>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <01516ad9-e187-4bac-7c65-a7a90c576ce2@arm.com>
Date: Wed, 29 Mar 2017 13:19:42 +0100
MIME-Version: 1.0
In-Reply-To: <65114e62-7458-b6f7-327c-f07a5096a452@sigmadesigns.com>
Content-Type: text/plain; charset=iso-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 29/03/17 12:34, Marc Gonzalez wrote:
> This driver is used to work around HW bugs in the controller.
> 
> Note: the controller does NOT support the following features.
> 
>   Legacy PCI interrupts
>   IO space
> 
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
>  Documentation/devicetree/bindings/pci/tango-pcie.txt |  33 +++++++++
>  drivers/pci/host/Kconfig                             |   7 ++
>  drivers/pci/host/Makefile                            |   1 +
>  drivers/pci/host/pcie-tango.c                        | 150 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 191 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/tango-pcie.txt b/Documentation/devicetree/bindings/pci/tango-pcie.txt
> new file mode 100644
> index 000000000000..f8e150ec41d8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/tango-pcie.txt
> @@ -0,0 +1,33 @@
> +Sigma Designs Tango PCIe controller
> +
> +Required properties:
> +
> +- compatible: "sigma,smp8759-pcie"
> +- reg: address/size of PCI configuration space, and pcie_reg
> +- bus-range: defined by size of PCI configuration space
> +- device_type: "pci"
> +- #size-cells: <2>
> +- #address-cells: <3>
> +- #interrupt-cells: <1>
> +- ranges: translation from system to bus addresses
> +- interrupts: spec for misc interrupts and MSI
> +- msi-controller
> +
> +Example:
> +
> +	pcie@2e000 {
> +		compatible = "sigma,smp8759-pcie";
> +		reg = <0x50000000 SZ_64M>, <0x2e000 0x100>;
> +		bus-range = <0 63>;
> +		device_type = "pci";
> +		#size-cells = <2>;
> +		#address-cells = <3>;
> +		#interrupt-cells = <1>;
> +		/* http://elinux.org/Device_Tree_Usage#PCI_Address_Translation */
> +			/* BUS_ADDRESS(3)  CPU_PHYSICAL(1)  SIZE(2) */
> +		ranges = <0x02000000 0x0 0x04000000  0x54000000  0x0 SZ_192M>;
> +		interrupts =
> +			<54 IRQ_TYPE_LEVEL_HIGH>, /* misc interrupts */
> +			<55 IRQ_TYPE_LEVEL_HIGH>; /* MSI */
> +		msi-controller;
> +	};
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index d7e7c0a827c3..8a622578a760 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -285,6 +285,13 @@ config PCIE_ROCKCHIP
>  	  There is 1 internal PCIe port available to support GEN2 with
>  	  4 slots.
>  
> +config PCIE_TANGO
> +	tristate "Tango PCIe controller"
> +	depends on ARCH_TANGO && PCI_MSI && OF
> +	select PCI_HOST_COMMON
> +	help
> +	  Say Y here to enable PCIe controller support on Tango SoC.

Nit: in line with the other help texts, that could probably benefit from
a wee bit more context (i.e. "Sigma Designs Tango SoCs")

> +
>  config VMD
>  	depends on PCI_MSI && X86_64
>  	tristate "Intel Volume Management Device Driver"
> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> index 084cb4983645..fc7ea90196f3 100644
> --- a/drivers/pci/host/Makefile
> +++ b/drivers/pci/host/Makefile
> @@ -32,4 +32,5 @@ obj-$(CONFIG_PCI_HOST_THUNDER_PEM) += pci-thunder-pem.o
>  obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
>  obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
>  obj-$(CONFIG_PCIE_ROCKCHIP) += pcie-rockchip.o
> +obj-$(CONFIG_PCIE_TANGO) += pcie-tango.o
>  obj-$(CONFIG_VMD) += vmd.o
> diff --git a/drivers/pci/host/pcie-tango.c b/drivers/pci/host/pcie-tango.c
> index e88850983a1d..dbc2663486b5 100644
> --- a/drivers/pci/host/pcie-tango.c
> +++ b/drivers/pci/host/pcie-tango.c
> @@ -192,3 +192,153 @@ static int tango_msi_probe(struct platform_device *pdev, struct tango_pcie *pcie
>  
>  	return 0;
>  }
> +
> +/*** HOST BRIDGE SUPPORT ***/
> +
> +static int smp8759_config_read(struct pci_bus *bus,
> +		unsigned int devfn, int where, int size, u32 *val)
> +{
> +	int ret;
> +	struct pci_config_window *cfg = bus->sysdata;
> +	struct tango_pcie *pcie = dev_get_drvdata(cfg->parent);
> +
> +	/*
> +	 * QUIRK #1
> +	 * Reads in configuration space outside devfn 0 return garbage.
> +	 */
> +	if (devfn != 0) {
> +		*val = ~0; /* Is this required even if we return an error? */
> +		return PCIBIOS_FUNC_NOT_SUPPORTED; /* Error seems appropriate */
> +	}
> +
> +	/*
> +	 * QUIRK #2
> +	 * The root complex advertizes a fake BAR, which is used to filter
> +	 * bus-to-system requests. Hide it from Linux.
> +	 */
> +	if (where == PCI_BASE_ADDRESS_0 && bus->number == 0) {
> +		*val = 0; /* 0 or ~0 to hide the BAR from Linux? */
> +		return PCIBIOS_SUCCESSFUL; /* Should we return error or success? */
> +	}
> +
> +	/*
> +	 * QUIRK #3
> +	 * Unfortunately, config and mem spaces are muxed.
> +	 * Linux does not support such a setting, since drivers are free
> +	 * to access mem space directly, at any time.
> +	 * Therefore, we can only PRAY that config and mem space accesses
> +	 * NEVER occur concurrently.
> +	 */

What about David's suggestion of using an IPI for safe mutual exclusion?

> +	writel_relaxed(1, pcie->mux);
> +	ret = pci_generic_config_read(bus, devfn, where, size, val);
> +	writel_relaxed(0, pcie->mux);
> +
> +	return ret;
> +}
> +
> +static int smp8759_config_write(struct pci_bus *bus,
> +		unsigned int devfn, int where, int size, u32 val)
> +{
> +	int ret;
> +	struct pci_config_window *cfg = bus->sysdata;
> +	struct tango_pcie *pcie = dev_get_drvdata(cfg->parent);
> +
> +	writel_relaxed(1, pcie->mux);
> +	ret = pci_generic_config_write(bus, devfn, where, size, val);
> +	writel_relaxed(0, pcie->mux);
> +
> +	return ret;
> +}
> +
> +static struct pci_ecam_ops smp8759_ecam_ops = {
> +	.bus_shift	= 20,
> +	.pci_ops	= {
> +		.map_bus	= pci_ecam_map_bus,
> +		.read		= smp8759_config_read,
> +		.write		= smp8759_config_write,
> +	}
> +};
> +
> +static const struct of_device_id tango_pcie_ids[] = {
> +	{ .compatible = "sigma,smp8759-pcie" },

General tip: use your .data member here...

> +	{ /* sentinel */ },
> +};
> +
> +static void smp8759_init(struct tango_pcie *pcie, void __iomem *base)
> +{
> +	pcie->mux		= base + 0x48;
> +	pcie->msi_status	= base + 0x80;
> +	pcie->msi_mask		= base + 0xa0;
> +	pcie->msi_doorbell	= 0xa0000000 + 0x2e07c;
> +}
> +
> +static int tango_pcie_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	void __iomem *base;
> +	struct resource *res;
> +	struct tango_pcie *pcie;
> +	struct device *dev = &pdev->dev;
> +
> +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, pcie);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	if (of_device_is_compatible(dev->of_node, "sigma,smp8759-pcie"))
> +		smp8759_init(pcie, base);

...then retrieve it with of_device_get_match_data() here. No need to
reinvent the wheel (or have to worry about the ordering of multiple
compatibles once rev. n+1 comes around).

> +
> +	ret = tango_msi_probe(pdev, pcie);
> +	if (ret)
> +		return ret;
> +
> +	return pci_host_common_probe(pdev, &smp8759_ecam_ops);
> +}
> +
> +static int tango_pcie_remove(struct platform_device *pdev)
> +{
> +	return tango_msi_remove(pdev);
> +}
> +
> +static struct platform_driver tango_pcie_driver = {
> +	.probe	= tango_pcie_probe,
> +	.remove	= tango_pcie_remove,
> +	.driver	= {
> +		.name = KBUILD_MODNAME,
> +		.of_match_table = tango_pcie_ids,
> +	},
> +};
> +
> +module_platform_driver(tango_pcie_driver);
> +
> +#define VENDOR_SIGMA	0x1105

Should this not be in include/linux/pci_ids.h?

Robin.

> +
> +/*
> + * QUIRK #4
> + * The root complex advertizes the wrong device class.
> + * Header Type 1 is for PCI-to-PCI bridges.
> + */
> +static void tango_fixup_class(struct pci_dev *dev)
> +{
> +	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
> +}
> +DECLARE_PCI_FIXUP_EARLY(VENDOR_SIGMA, PCI_ANY_ID, tango_fixup_class);
> +
> +/*
> + * QUIRK #5
> + * Only transfers within the root complex BAR are forwarded to the host.
> + * By default, the DMA framework expects that
> + * PCI address 0x8000_0000 maps to system address 0x8000_0000
> + * which is where DRAM0 is mapped.
> + */
> +static void tango_fixup_bar(struct pci_dev *dev)
> +{
> +        pci_write_config_dword(dev, PCI_BASE_ADDRESS_0, 0x80000000);
> +}
> +DECLARE_PCI_FIXUP_FINAL(VENDOR_SIGMA, PCI_ANY_ID, tango_fixup_bar);
> 
