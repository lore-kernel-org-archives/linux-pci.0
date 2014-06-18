Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:51157 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbaFRVvS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jun 2014 17:51:18 -0400
Received: by mail-lb0-f173.google.com with SMTP id s7so910061lbd.4
        for <linux-pci@vger.kernel.org>; Wed, 18 Jun 2014 14:51:16 -0700 (PDT)
Message-ID: <53A209DA.9000000@cogentembedded.com>
Date: Thu, 19 Jun 2014 01:51:22 +0400
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
To: Phil Edworthy <phil.edworthy@renesas.com>,
	linux-pci@vger.kernel.org
CC: linux-sh@vger.kernel.org,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v8 1/3] PCI: host: rcar: Add Renesas R-Car PCIe driver
References: <1399892270-25021-1-git-send-email-phil.edworthy@renesas.com> <1399892270-25021-2-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1399892270-25021-2-git-send-email-phil.edworthy@renesas.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello.

On 05/12/2014 02:57 PM, Phil Edworthy wrote:

    I'm investigating an imprecise external abort occurring once userland is 
started when I have NetMos PCIe serial card inserted and the '8250_pci' driver 
enabled and I have found some issues in this driver, while at it...

> This PCIe Host driver currently does not support MSI, so cards
> fall back to INTx interrupts.

> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

[...]

> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> new file mode 100644
> index 0000000..3c524b9
> --- /dev/null
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -0,0 +1,768 @@
[...]
> +#define PCI_MAX_RESOURCES 4

    As a side note, this risks collision with <linux/pci*.h>...

> +static void pci_write_reg(struct rcar_pcie *pcie, unsigned long val,
> +			  unsigned long reg)
> +{
> +	writel(val, pcie->base + reg);
> +}
> +
> +static unsigned long pci_read_reg(struct rcar_pcie *pcie, unsigned long reg)
> +{
> +	return readl(pcie->base + reg);
> +}

    As a side note, these functions are hardly needed, and risk collision too...

> +
> +enum {
> +	PCI_ACCESS_READ,
> +	PCI_ACCESS_WRITE,

    These risk collision too...

> +static void rcar_pcie_setup_window(int win, struct resource *res,
> +				   struct rcar_pcie *pcie)

    As a side note, 'res' parameter is hardly needed here, as the function 
always gets
called with the resources contained within 'struct rcar_pcie'...

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

    My investigation showed and printk() here confirmed that instead of a PCI 
bus address here we have CPU address written to these registers:

rcar_pcie_setup_window: window 0, resource [io  0xfe100000-0xfe1fffff]
rcar_pcie_setup_window: window 1, resource [mem 0xfe200000-0xfe3fffff]
rcar_pcie_setup_window: window 2, resource [mem 0x30000000-0x37ffffff]
rcar_pcie_setup_window: window 3, resource [mem 0x38000000-0x3fffffff pref]
rcar-pcie fe000000.pcie: PCI host bridge to bus 0000:00

> +
> +	/* First resource is for IO */
> +	mask = PAR_ENABLE;
> +	if (res->flags & IORESOURCE_IO)
> +		mask |= IO_SPACE;

    For the memory space this works OK as you're identity-mapping the memory 
ranges in your device trees. However, for the I/O space this means that it 
won't work as the BARs in the PCIe devices get programmed with the PCI bus 
addresses but the PCIe window translation register is programmed with a CPU 
address which don't at all match (given your device trees) and hence one can't 
access the card's I/O mapped registers at all...

> +
> +	pci_write_reg(pcie, mask, PCIEPTCTLR(win));
> +}
> +
> +static int rcar_pcie_setup(int nr, struct pci_sys_data *sys)
> +{
> +	struct rcar_pcie *pcie = sys_to_pcie(sys);
> +	struct resource *res;
> +	int i;
> +
> +	pcie->root_bus_nr = -1;
> +
> +	/* Setup PCI resources */
> +	for (i = 0; i < PCI_MAX_RESOURCES; i++) {
> +
> +		res = &pcie->res[i];
> +		if (!res->flags)
> +			continue;
> +
> +		rcar_pcie_setup_window(i, res, pcie);
> +
> +		if (res->flags & IORESOURCE_IO)
> +			pci_ioremap_io(nr * SZ_64K, res->start);

   I'm not sure why are you not calling pci_add_resource() for I/O space... 
Also, this sets up only 64 KiB of I/O ports while your device tree describes 
I/O space 1 MiB is size.

> +		else
> +			pci_add_resource(&sys->resources, res);
> +	}
> +	pci_add_resource(&sys->resources, &pcie->busn);
> +
> +	return 1;
> +}
[...]
> +static int rcar_pcie_hw_init(struct rcar_pcie *pcie)
> +{
> +	int err;
> +
> +	/* Begin initialization */
> +	pci_write_reg(pcie, 0, PCIETCTLR);
> +
> +	/* Set mode */
> +	pci_write_reg(pcie, 1, PCIEMSR);
> +
> +	/*
> +	 * Initial header for port config space is type 1, set the device
> +	 * class to match. Hardware takes care of propagating the IDSETR
> +	 * settings, so there is no need to bother with a quirk.
> +	 */
> +	pci_write_reg(pcie, PCI_CLASS_BRIDGE_PCI << 16, IDSETR1);

    Hm, shouldn't this be a host bridge? I've noticed that the bridge's I/O 
and memory base/limit registers are left uninitialized even though the BARs of 
the PICe devices behind this bridge are assigned.

> +
> +	/*
> +	 * Setup Secondary Bus Number & Subordinate Bus Number, even though
> +	 * they aren't used, to avoid bridge being detected as broken.
> +	 */
> +	rcar_rmw32(pcie, RCONF(PCI_SECONDARY_BUS), 0xff, 1);
> +	rcar_rmw32(pcie, RCONF(PCI_SUBORDINATE_BUS), 0xff, 1);
> +
> +	/* Initialize default capabilities. */
> +	rcar_rmw32(pcie, REXPCAP(0), 0, PCI_CAP_ID_EXP);
> +	rcar_rmw32(pcie, REXPCAP(PCI_EXP_FLAGS),
> +		PCI_EXP_FLAGS_TYPE, PCI_EXP_TYPE_ROOT_PORT << 4);
> +	rcar_rmw32(pcie, RCONF(PCI_HEADER_TYPE), 0x7f,
> +		PCI_HEADER_TYPE_BRIDGE);
> +
> +	/* Enable data link layer active state reporting */
> +	rcar_rmw32(pcie, REXPCAP(PCI_EXP_LNKCAP), 0, PCI_EXP_LNKCAP_DLLLARC);
> +
> +	/* Write out the physical slot number = 0 */
> +	rcar_rmw32(pcie, REXPCAP(PCI_EXP_SLTCAP), PCI_EXP_SLTCAP_PSN, 0);
> +
> +	/* Set the completion timer timeout to the maximum 50ms. */
> +	rcar_rmw32(pcie, TLCTLR+1, 0x3f, 50);

    Missing spaces around '+'...

> +
> +	/* Terminate list of capabilities (Next Capability Offset=0) */
> +	rcar_rmw32(pcie, RVCCAP(0), 0xfff0, 0);
> +
> +	/* Enable MAC data scrambling. */
> +	rcar_rmw32(pcie, MACCTLR, SCRAMBLE_DISABLE, 0);

    Doesn't the comment contradict the code here?

> +
> +	/* Finish initialization - establish a PCI Express link */
> +	pci_write_reg(pcie, CFINIT, PCIETCTLR);
> +
> +	/* This will timeout if we don't have a link. */
> +	err = rcar_pcie_wait_for_dl(pcie);
> +	if (err)
> +		return err;
> +
> +	/* Enable INTx interrupts */
> +	rcar_rmw32(pcie, PCIEINTXR, 0, 0xF << 8);
> +
> +	/* Enable slave Bus Mastering */
> +	rcar_rmw32(pcie, RCONF(PCI_STATUS), PCI_STATUS_DEVSEL_MASK,
> +		PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER |
> +		PCI_STATUS_CAP_LIST | PCI_STATUS_DEVSEL_FAST);

    Hmm, you're mixing up PCI control/status registers' bits here; they're
two 16-bit registers! So you're writing to 3 reserved LSBs of the PCI status 
register...

> +static int rcar_pcie_get_resources(struct platform_device *pdev,
> +				   struct rcar_pcie *pcie)
> +{
> +	struct resource res;
> +	int err;
> +
> +	err = of_address_to_resource(pdev->dev.of_node, 0, &res);

    BTW, you could use platfrom_get_resource() and save on your local variable 
and the error check -- devm_ioremap_resource() does it.

> +	if (err)
> +		return err;
> +
> +	pcie->clk = devm_clk_get(&pdev->dev, "pcie");
> +	if (IS_ERR(pcie->clk)) {
> +		dev_err(pcie->dev, "cannot get platform clock\n");
> +		return PTR_ERR(pcie->clk);
> +	}
> +	err = clk_prepare_enable(pcie->clk);
> +	if (err)
> +		goto fail_clk;
> +
> +	pcie->bus_clk = devm_clk_get(&pdev->dev, "pcie_bus");
> +	if (IS_ERR(pcie->bus_clk)) {
> +		dev_err(pcie->dev, "cannot get pcie bus clock\n");
> +		err = PTR_ERR(pcie->bus_clk);
> +		goto fail_clk;
> +	}
> +	err = clk_prepare_enable(pcie->bus_clk);
> +	if (err)
> +		goto err_map_reg;
> +
> +	pcie->base = devm_ioremap_resource(&pdev->dev, &res);
> +	if (IS_ERR(pcie->base)) {
> +		err = PTR_ERR(pcie->base);
> +		goto err_map_reg;
> +	}
> +
> +	return 0;
> +
> +err_map_reg:
> +	clk_disable_unprepare(pcie->bus_clk);
> +fail_clk:
> +	clk_disable_unprepare(pcie->clk);
> +
> +	return err;
> +}
> +
> +static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
> +				    struct of_pci_range *range,
> +				    int *index)
> +{
> +	u64 restype = range->flags;
> +	u64 cpu_addr = range->cpu_addr;
> +	u64 cpu_end = range->cpu_addr + range->size;
> +	u64 pci_addr = range->pci_addr;
> +	u32 flags = LAM_64BIT | LAR_ENABLE;
> +	u64 mask;
> +	u64 size;
> +	int idx = *index;
> +
> +	if (restype & IORESOURCE_PREFETCH)
> +		flags |= LAM_PREFETCH;
> +
> +	/*
> +	 * If the size of the range is larger than the alignment of the start
> +	 * address, we have to use multiple entries to perform the mapping.
> +	 */
> +	if (cpu_addr > 0) {
> +		unsigned long nr_zeros = __ffs64(cpu_addr);
> +		u64 alignment = 1ULL << nr_zeros;

    Missing newline...

> +		size = min(range->size, alignment);
> +	} else {
> +		size = range->size;
> +	}
> +	/* Hardware supports max 4GiB inbound region */
> +	size = min(size, 1ULL << 32);
> +
> +	mask = roundup_pow_of_two(size) - 1;
> +	mask &= ~0xf;
> +
> +	while (cpu_addr < cpu_end) {
> +		/*
> +		 * Set up 64-bit inbound regions as the range parser doesn't
> +		 * distinguish between 32 and 64-bit types.
> +		 */
> +		pci_write_reg(pcie, lower_32_bits(pci_addr), PCIEPRAR(idx));
> +		pci_write_reg(pcie, lower_32_bits(cpu_addr), PCIELAR(idx));
> +		pci_write_reg(pcie, lower_32_bits(mask) | flags, PCIELAMR(idx));
> +
> +		pci_write_reg(pcie, upper_32_bits(pci_addr), PCIEPRAR(idx+1));
> +		pci_write_reg(pcie, upper_32_bits(cpu_addr), PCIELAR(idx+1));
> +		pci_write_reg(pcie, 0, PCIELAMR(idx+1));

    Missing spaces around '+'...

> +
> +		pci_addr += size;
> +		cpu_addr += size;
> +		idx += 2;
> +
> +		if (idx > MAX_NR_INBOUND_MAPS) {
> +			dev_err(pcie->dev, "Failed to map inbound regions!\n");
> +			return -EINVAL;
> +		}
> +	}
> +	*index = idx;
> +
> +	return 0;
> +}
> +
> +static int pci_dma_range_parser_init(struct of_pci_range_parser *parser,
> +				     struct device_node *node)
> +{
> +	const int na = 3, ns = 2;
> +	int rlen;
> +
> +	parser->node = node;
> +	parser->pna = of_n_addr_cells(node);
> +	parser->np = parser->pna + na + ns;
> +
> +	parser->range = of_get_property(node, "dma-ranges", &rlen);
> +	if (!parser->range)
> +		return -ENOENT;
> +
> +	parser->end = parser->range + rlen / sizeof(__be32);
> +	return 0;
> +}

    Erm, AFAIK "dma-ranges" is a standard property, shouldn't its parsing be 
placed in some generic place like drivers/of/address.c?

[...]
> +static int rcar_pcie_probe(struct platform_device *pdev)
> +{
> +	struct rcar_pcie *pcie;
> +	unsigned int data;
> +	struct of_pci_range range;
> +	struct of_pci_range_parser parser;
> +	const struct of_device_id *of_id;
> +	int err, win = 0;
> +	int (*hw_init_fn)(struct rcar_pcie *);
> +
> +	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	pcie->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, pcie);
> +
> +	/* Get the bus range */
> +	if (of_pci_parse_bus_range(pdev->dev.of_node, &pcie->busn)) {
> +		dev_err(&pdev->dev, "failed to parse bus-range property\n");
> +		return -EINVAL;
> +	}
> +
> +	if (of_pci_range_parser_init(&parser, pdev->dev.of_node)) {
> +		dev_err(&pdev->dev, "missing ranges property\n");
> +		return -EINVAL;
> +	}
> +
> +	err = rcar_pcie_get_resources(pdev, pcie);
> +	if (err < 0) {
> +		dev_err(&pdev->dev, "failed to request resources: %d\n", err);
> +		return err;
> +	}
> +
> +	for_each_of_pci_range(&parser, &range) {
> +		of_pci_range_to_resource(&range, pdev->dev.of_node,
> +						&pcie->res[win++]);

    This function call is probably no good here as it fetches into the 'start' 
field of a 'struct resource' a CPU address instead of a PCI address...

> +
> +		if (win > PCI_MAX_RESOURCES)
> +			break;
> +	}
> +
> +	 err = rcar_pcie_parse_map_dma_ranges(pcie, pdev->dev.of_node);
> +	 if (err)
> +		return err;
> +
> +	of_id = of_match_device(rcar_pcie_of_match, pcie->dev);
> +	if (!of_id || !of_id->data)
> +		return -EINVAL;
> +	hw_init_fn = of_id->data;
> +
> +	/* Failure to get a link might just be that no cards are inserted */
> +	err = hw_init_fn(pcie);
> +	if (err) {
> +		dev_info(&pdev->dev, "PCIe link down\n");
> +		return 0;

    Not quite sure why you exit normally here without enabling the hardware.
I think the internal bridge should be visible regardless of whether link is
detected or not...

> +	}
> +
> +	data = pci_read_reg(pcie, MACSR);
> +	dev_info(&pdev->dev, "PCIe x%d: link up\n", (data >> 20) & 0x3f);
> +
> +	rcar_pcie_enable(pcie);
> +
> +	return 0;
> +}
[...]

WBR, Sergei

