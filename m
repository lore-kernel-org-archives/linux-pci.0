Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.24]:62637 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759943AbaCULE7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Mar 2014 07:04:59 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Phil Edworthy <phil.edworthy@renesas.com>,
	linux-pci@vger.kernel.org, linux-sh@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH v4 1/9] PCI: host: rcar: Add Renesas R-Car PCIe driver
Date: Fri, 21 Mar 2014 12:04:16 +0100
Message-ID: <27671657.LuGQtNBfqX@wuerfel>
In-Reply-To: <1395397968-6242-2-git-send-email-phil.edworthy@renesas.com>
References: <1395397968-6242-1-git-send-email-phil.edworthy@renesas.com> <1395397968-6242-2-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 21 March 2014 10:32:40 Phil Edworthy wrote:
> +static const struct of_device_id rcar_pcie_of_match[] = {
> +	{ .compatible = "renesas,r8a7779-pcie", .data = (void *)RCAR_H1 },
> +	{ .compatible = "renesas,r8a7790-pcie", .data = (void *)RCAR_GENERIC },
> +	{ .compatible = "renesas,r8a7791-pcie", .data = (void *)RCAR_GENERIC },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, rcar_pcie_of_match);

The only difference between RCAR_H1 and RCAR_GENERIC seems to be the
use of the rcar_pcie_phy_init_rcar_h1 vs rcar_pcie_hw_init
functions. I think this would be expressed in a nicer way doing

static const struct of_device_id rcar_pcie_of_match[] = {
	{ .compatible = "renesas,r8a7779-pcie", .data =  rcar_pcie_phy_init_rcar_h1},
	{ .compatible = "renesas,r8a7790-pcie", .data =  rcar_pcie_hw_init},
	{ .compatible = "renesas,r8a7791-pcie", .data =  rcar_pcie_hw_init},
	{},
};

If you need other differences in the future, you can extend this
to use a pointer to a struct containing the init function pointer.

> +static int rcar_pcie_setup_window(int win, struct resource *res,
> +					struct rcar_pcie *pcie)
> +{
> +	/* Setup PCIe address space mappings for each resource */
> +	resource_size_t size;
> +	u32 mask;
> +
> +	pci_write_reg(pcie, 0x00000000, PCIEPTCTLR(win));
> +
> +	/*
> +	 * The PAMR mask is calculated in units of 128Bytes, which
> +	 * keeps things pretty simple.
> +	 */
> +	size = resource_size(res);
> +	mask = (roundup_pow_of_two(size) / SZ_128) - 1;
> +	pci_write_reg(pcie, mask << 7, PCIEPAMR(win));
> +
> +	pci_write_reg(pcie, upper_32_bits(res->start), PCIEPARH(win));
> +	pci_write_reg(pcie, lower_32_bits(res->start), PCIEPARL(win));
> +
> +	/* First resource is for IO */
> +	mask = PAR_ENABLE;
> +	if (res->flags & IORESOURCE_IO)
> +		mask |= IO_SPACE;
> +
> +	pci_write_reg(pcie, mask, PCIEPTCTLR(win));
> +
> +	return 0;
> +}

Would it be possible to have this done in the boot loader so the kernel
doesn't need to be bothered with it?

> +
> +static int rcar_pcie_setup(int nr, struct pci_sys_data *sys)
> +{
> +	struct rcar_pcie *pcie = sys_to_pcie(sys);
> +	struct resource *res;
> +	int i, ret;
> +
> +	pcie->root_bus_nr = sys->busnr;
> +
> +	/* Setup PCI resources */
> +	for (i = 0; i < PCI_MAX_RESOURCES; i++) {
> +
> +		res = &pcie->res[i];
> +		if (!res->flags)
> +			continue;
> +
> +		if (res->flags & IORESOURCE_IO) {
> +			/* Setup IO mapped memory accesses */
> +			ret = pci_ioremap_io(0, res->start);
> +			if (ret)
> +				return 1;
> +
> +			/* Correct addresses for remapped IO */
> +			res->end = res->end - res->start;
> +			res->start = 0;
> +		}
> +
> +		rcar_pcie_setup_window(i, res, pcie);
> +		pci_add_resource(&sys->resources, res);
> +	}

This assumes that the start of the I/O window is always at
bus address 0, and that you have only one PCI host in the system.
Are both guaranteed through the hardware design?

> +static void __init rcar_pcie_enable(struct rcar_pcie *pcie)
> +{
> +	struct platform_device *pdev = to_platform_device(pcie->dev);
> +	struct hw_pci hw;
> +
> +	memset(&hw, 0, sizeof(hw));
> +
> +	hw.nr_controllers = 1;
> +	hw.private_data   = (void **)&pcie;
> +	hw.setup          = rcar_pcie_setup,
> +	hw.map_irq        = of_irq_parse_and_map_pci,
> +	hw.ops		  = &rcar_pcie_ops,

You can write this slightly nicer doing

	struct hw_pci hw = {
		.nr_controllers = 1,
		.private_data = (void **)&pcie,
		...
	};
> +static int __init rcar_pcie_phy_init_rcar_h1(struct rcar_pcie *pcie)
> +{
> +	unsigned int timeout = 10;
> +
> +	/* Initialize the phy */
> +	phy_write_reg(pcie, 0, 0x42, 0x1, 0x0EC34191);
> +	phy_write_reg(pcie, 1, 0x42, 0x1, 0x0EC34180);
> +	phy_write_reg(pcie, 0, 0x43, 0x1, 0x00210188);
> +	phy_write_reg(pcie, 1, 0x43, 0x1, 0x00210188);
> +	phy_write_reg(pcie, 0, 0x44, 0x1, 0x015C0014);
> +	phy_write_reg(pcie, 1, 0x44, 0x1, 0x015C0014);
> +	phy_write_reg(pcie, 1, 0x4C, 0x1, 0x786174A0);

Have you considered moving this into a separate PHY driver?
There are probably good reasons either way, so I'm not asking you
to do it, just to think about what would be best for this driver.

It seems that you already have two different implementations
that only vary in how they access the PHY, so moving that
into a separate driver would keep the knowledge out of the
host driver. OTOH, the PHY registers look like they are part of
the pci host itself.

> +	/*
> +	 * For target transfers, setup a single 64-bit 4GB mapping at address
> +	 * 0. The hardware can only map memory that starts on a power of two
> +	 * boundary, and size is power of 2, so best to ignore it.
> +	 */
> +	pci_write_reg(pcie, 0, PCIEPRAR(0));
> +	pci_write_reg(pcie, 0, PCIELAR(0));
> +	pci_write_reg(pcie, 0xfffffff0UL | LAM_PREFETCH |
> +		LAM_64BIT | LAR_ENABLE, PCIELAMR(0));
> +	pci_write_reg(pcie, 0, PCIELAR(1));
> +	pci_write_reg(pcie, 0, PCIEPRAR(1));
> +	pci_write_reg(pcie, 0, PCIELAMR(1));

Is this the only reasonable configuration? If not, you might want to
do the same thing as the x-gene PCI driver that is not yet merged,
and parse the 'dma-ranges' property to determine what the mapping
on a particular machine should be.

Most importantly, why don't you use a mapping that includes RAM beyond
the first 4GB?

> +static int __init pcie_init(void)
> +{
> +	return platform_driver_probe(&rcar_pcie_driver, rcar_pcie_probe);
> +}
> +subsys_initcall(pcie_init);

Why so early?

Overall, this driver looks pretty good.

	Arnd
