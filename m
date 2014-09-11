Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bon0132.outbound.protection.outlook.com ([157.56.111.132]:32416
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751044AbaIKV6y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 11 Sep 2014 17:58:54 -0400
Message-ID: <1410470694.24184.390.camel@snotra.buserror.net>
Subject: Re: [PATCH v2 3/3] PCI: Layerscape: Add Layerscape PCIe driver
From: Scott Wood <scottwood@freescale.com>
To: Minghuan Lian <Minghuan.Lian@freescale.com>
CC: <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	"Zang Roy-R61911" <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 11 Sep 2014 16:24:54 -0500
In-Reply-To: <1410469741-11634-3-git-send-email-Minghuan.Lian@freescale.com>
References: <1410469741-11634-1-git-send-email-Minghuan.Lian@freescale.com>
	 <1410469741-11634-3-git-send-email-Minghuan.Lian@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2014-09-11 at 21:09 +0000, Minghuan Lian wrote:
> Add support for Freescale Layerscape PCIe controller. This driver
> re-uses the designware core code.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> ---
> Change log:
> v2:
> 1. Add pcie-scfg to link scfg device node and remove "fsl, ls-pcie" compatible
> 2. Use regmap API to access scfg.
> 3. remove ls1021 PCI device ID.
> 4. remove unused irq pme_irq and ls_pcie_list.
> 5. Do not set scfg bit reverse mode
> 
>  .../devicetree/bindings/pci/layerscape-pci.txt     |  45 ++++
>  drivers/pci/host/Kconfig                           |   8 +
>  drivers/pci/host/Makefile                          |   1 +
>  drivers/pci/host/pci-layerscape.c                  | 278 +++++++++++++++++++++
>  4 files changed, 332 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/layerscape-pci.txt
>  create mode 100644 drivers/pci/host/pci-layerscape.c
> 
> diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> new file mode 100644
> index 0000000..1a5dbd8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> @@ -0,0 +1,45 @@
> +Freescale Layerscape PCIe controller
> +
> +This PCIe host controller is based on the Synopsis Designware PCIe IP
> +and thus inherits all the common properties defined in designware-pcie.txt.
> +
> +Required properties:
> +- compatible: should contain the platform identifier such as "fsl,ls1021a-pcie"
> +- reg: base addresses and lengths of the PCIe controller
> +- interrupts: A list of interrupt outputs of the controller. Must contain an
> +  entry for each entry in the interrupt-names property.
> +- interrupt-names: Must include the following entries:
> +  "intr": The interrupt that is asserted for controller interrupts
> +  "msi": The interrupt that is asserted when an MSI is received
> +  "pme": The interrupt that is asserted when PME state changes
> +- pcie-scfg: Must include two entries.

fsl,pcie-scfg

> +  The first entry must be a link to the SCFG device node
> +  The second entry must be '0' or '1' based on physical PCIe controller index.
> +  used to get SCFG PEXN registers
> +
> +Example:
> +
> +	pcie@3400000 {
> +		compatible = "fsl,ls1021a-pcie", "snps,dw-pcie";

Can we rely on the config space vendor/device ID instead of hardcoding
the SoC here?

> +		reg = <0x00 0x03400000 0x0 0x00010000   /* controller registers */
> +		       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
> +		reg-names = "regs", "config";
> +		interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
> +			     <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>, /* MSI interrupt */
> +			     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
> +		interrupt-names = "intr", "msi", "pme";
> +		pcie-scfg = <&scfg 0>;
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		device_type = "pci";
> +		num-lanes = <4>;
> +		bus-range = <0x00 0xff>;
> +		ranges = <0x81000000 0x0 0x00000000 0x40 0x10000000 0x0 0x00010000   /* downstream I/O */
> +			  0x82000000 0x0 0x00000000 0x41 0x00000000 0x1 0x00000000>; /* non-prefetchable memory */

Are these ranges hardcoded in the SoC, or are they the result of iATU
settings?  If the latter, who configures it and why no prefetchable
region?

> +		#interrupt-cells = <1>;
> +		interrupt-map-mask = <0 0 0 7>;
> +		interrupt-map = <0000 0 0 1 &gic GIC_SPI 91  IRQ_TYPE_LEVEL_HIGH>,
> +				<0000 0 0 2 &gic GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
> +				<0000 0 0 3 &gic GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
> +				<0000 0 0 4 &gic GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 34134d6..c826949 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -82,4 +82,12 @@ config PCIE_XILINX
>  	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
>  	  Host Bridge driver.
>  
> +config PCI_LAYERSCAPE
> +	bool "Freescale Layerscape PCIe controller"
> +	depends on SOC_LS1021A
> +	select PCIE_DW
> +	select MFD_SYSCON
> +	help
> +	  Say Y here if you want PCIe controller support on Layerscape SoCs.

Why does it depend on this particular SoC?  Is the same PCIe controller
going to be used on other Layerscape chips?

> +static irqreturn_t ls_pcie_msi_irq_handler(int irq, void *data)
> +{
> +	struct pcie_port *pp = data;
> +	struct ls_pcie *pcie = to_ls_pcie(pp);
> +	unsigned int msi_irq;
> +
> +	/* clear the interrupt */
> +	regmap_write(pcie->scfg, SCFG_SPIMSICLRCR,
> +		     MSI_LS1021A_DATA(pcie->index));
> +
> +	msi_irq = irq_find_mapping(pp->irq_domain, 0);
> +	if (msi_irq)
> +		generic_handle_irq(msi_irq);
> +	else
> +		/*
> +		 * that's weird who triggered this?
> +		 * just clear it
> +		 */
> +		dev_info(pcie->dev, "unexpected MSI\n");
> +
> +	return IRQ_HANDLED;
> +}
> +

Why are you returning IRQ_HANDLED in the "unexpected MSI" case?

-Scott


