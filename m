Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:50845 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855AbaIXQNJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Sep 2014 12:13:09 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Robert Richter <rric@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	Liviu Dudau <liviu.dudau@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	linux-kernel@vger.kernel.org, Robert Richter <rrichter@cavium.com>,
	linux-pci@vger.kernel.org, Sunil Goutham <sgoutham@cavium.com>
Subject: Re: [PATCH 1/6] pci, thunder: Add support for Thunder PCIe host controller
Date: Wed, 24 Sep 2014 18:12:26 +0200
Message-ID: <27476217.5ToIFGoMDz@wuerfel>
In-Reply-To: <1411573068-12952-2-git-send-email-rric@kernel.org>
References: <1411573068-12952-1-git-send-email-rric@kernel.org> <1411573068-12952-2-git-send-email-rric@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 24 September 2014 17:37:43 Robert Richter wrote:
> From: Sunil Goutham <sgoutham@cavium.com>
> 
> This patch adds support for PCI host controller of Cavium Thunder
> SoCs.

I had expected this hardware to be SBSA compliant. Why do you need
a hardware specific driver, is this a workaround for buggy hardware
or just noncompliant?

> +/*
> + * All PCIe devices in Thunder have fixed resources, shouldn't be reassigned.
> + * Also claim the device's valid resources to set 'res->parent' hierarchy.
> + */
> +static void pci_dev_resource_fixup(struct pci_dev *dev)
> +{
> +	struct resource *res;
> +	int resno;
> +
> +	for (resno = 0; resno < PCI_NUM_RESOURCES; resno++)
> +		dev->resource[resno].flags |= IORESOURCE_PCI_FIXED;

You have listed these as relocatable in DT, why do you have to mark
them as nonrelocatable here?

> +static void __iomem *thunder_pcie_cfg_base(struct thunder_pcie *pcie,
> +				 unsigned int bus, unsigned int devfn)
> +{
> +	return  pcie->cfg_base + ((bus << THUNDER_PCIE_BUS_SHIFT)
> +		| (PCI_SLOT(devfn) << THUNDER_PCIE_DEV_SHIFT)
> +		| (PCI_FUNC(devfn) << THUNDER_PCIE_FUNC_SHIFT));
> +}
> +
> +static int thunder_pcie_read_config(struct pci_bus *bus, unsigned int devfn,
> +				  int reg, int size, u32 *val)
> +{
> +	struct thunder_pcie *pcie = bus->sysdata;
> +	void __iomem *addr;
> +	unsigned int busnr = bus->number;
> +
> +	if (busnr > 255 || devfn > 255 || reg > 4095)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +	addr = thunder_pcie_cfg_base(pcie, busnr, devfn) + reg;
> +
> +	switch (size) {
> +	case 1:
> +		*val = readb(addr);
> +		break;
> +	case 2:
> +		*val = readw(addr);
> +		break;
> +	case 4:
> +		*val = readl(addr);
> +		break;
> +	default:
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> +	}
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}

This looks roughly ECAM compliant, are you sure you need a
private implementation?

> +static int thunder_pcie_msi_enable(struct thunder_pcie *pcie,
> +					struct pci_bus *bus)
> +{
> +	struct device_node *msi_node;
> +
> +	msi_node = of_parse_phandle(pcie->node, "msi-parent", 0);
> +	if (!msi_node)
> +		return -ENODEV;
> +
> +	pcie->msi = of_pci_find_msi_chip_by_node(msi_node);
> +	if (!pcie->msi)
> +		return -ENODEV;
> +
> +	pcie->msi->dev = pcie->dev;
> +	bus->msi = pcie->msi;
> +
> +	return 0;
> +}

This is probably something we should add to the generic host driver as well,
so it can work with SBSA compliant implementations that come with an MSI
controller. Maybe move it into common code so it can be shared with that
driver.

	Arnd
