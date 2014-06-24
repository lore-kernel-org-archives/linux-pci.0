Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:44566 "EHLO
	relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752847AbaFXKBU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 24 Jun 2014 06:01:20 -0400
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Lucas Stach <l.stach@pengutronix.de>
Subject: RE: [PATCH v8 1/3] PCI: host: rcar: Add Renesas R-Car PCIe driver
Date: Tue, 24 Jun 2014 10:01:14 +0000
Message-ID: <666f39dbf0f149c6946d4c2665d3d85d@HKXPR06MB168.apcprd06.prod.outlook.com>
References: <1399892270-25021-1-git-send-email-phil.edworthy@renesas.com>
 <1399892270-25021-2-git-send-email-phil.edworthy@renesas.com>
 <53A209DA.9000000@cogentembedded.com>
 <20a0a16226d54b0e8d6f68e41046bbf2@HKXPR06MB168.apcprd06.prod.outlook.com>
 <53A897EF.2020804@cogentembedded.com>
In-Reply-To: <53A897EF.2020804@cogentembedded.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sergei,

On 23 June 2014 22:11, Sergei wrote:
> On 06/23/2014 08:44 PM, Phil Edworthy wrote:
> 
>>>      I'm investigating an imprecise external abort occurring once userland is
>>> started when I have NetMos
> 
>     Or is it MosChip now? Can't remember all their renames. :-)
Do you know of somewhere I can buy a card with this chipset in the EU? I had a
quick search but couldn't find anything.

[...]
>>>> +static void pci_write_reg(struct rcar_pcie *pcie, unsigned long val,
>>>> +			  unsigned long reg)
>>>> +{
>>>> +	writel(val, pcie->base + reg);
>>>> +}
>>>> +
>>>> +static unsigned long pci_read_reg(struct rcar_pcie *pcie, unsigned long
>>> reg)
>>>> +{
>>>> +	return readl(pcie->base + reg);
>>>> +}
> 
>>>      As a side note, these functions are hardly needed, and risk collision
> too...
> 
>> Ben mentioned this in his review and as I said then, I found them useful
> during
>> development, so we agreed to leave them. Since they are static, there
> shouldn't
>> be a collision risk.
> 
>     You're risking clashes even at the source level, not even at object file
> level...
Ah, yes you are correct. 


>>>> +static void rcar_pcie_setup_window(int win, struct resource *res,
>>>> +				   struct rcar_pcie *pcie)
> 
>>>      As a side note, 'res' parameter is hardly needed here, as the function
>>> always gets
>>> called with the resources contained within 'struct rcar_pcie'...
> 
>> Either I would have to pass an index to the resource in,
> 
>     But you already do pass it, 'win' is the index!
> 
>> or as I have done, a
>> pointer to the individual resource. I found it cleaner to pass the pointer.
> 
>     You're actually pass excess parameters, both the index and the pointer.
Ha, yes I didn't notice that :)

[...]
>>>> +
>>>> +	/* First resource is for IO */
>>>> +	mask = PAR_ENABLE;
>>>> +	if (res->flags & IORESOURCE_IO)
>>>> +		mask |= IO_SPACE;
> 
>>>      For the memory space this works OK as you're identity-mapping the
>>> memory
>>> ranges in your device trees. However, for the I/O space this means that it
>>> won't work as the BARs in the PCIe devices get programmed with the PCI
> bus
>>> addresses but the PCIe window translation register is programmed with a
>>> CPU
>>> address which don't at all match (given your device trees) and hence one
>>> can't
>>> access the card's I/O mapped registers at all...
> 
>> Hmm, I couldn't find any cards that supported I/O, so I wasn't able to test
>> this. Clearly this is an issue that needs looking into.
> 
>     Will you look into it then, or should I?
I'll look at it.

>>>> +
>>>> +	pci_write_reg(pcie, mask, PCIEPTCTLR(win));
>>>> +}
>>>> +
>>>> +static int rcar_pcie_setup(int nr, struct pci_sys_data *sys)
>>>> +{
>>>> +	struct rcar_pcie *pcie = sys_to_pcie(sys);
>>>> +	struct resource *res;
>>>> +	int i;
>>>> +
>>>> +	pcie->root_bus_nr = -1;
>>>> +
>>>> +	/* Setup PCI resources */
>>>> +	for (i = 0; i < PCI_MAX_RESOURCES; i++) {
>>>> +
>>>> +		res = &pcie->res[i];
>>>> +		if (!res->flags)
>>>> +			continue;
>>>> +
>>>> +		rcar_pcie_setup_window(i, res, pcie);
>>>> +
>>>> +		if (res->flags & IORESOURCE_IO)
>>>> +			pci_ioremap_io(nr * SZ_64K, res->start);
> 
>>>     I'm not sure why are you not calling pci_add_resource() for I/O space...
> 
>     Sorry, did you reply to that?
I used the tegra driver to inform on what I should do for this. This doesn't
call pci_add_resource() for I/O space either. However, I also see that other
drivers do call this. I think the simplest thing is for me to get a card that
supports I/O space and properly test it.

>>> Also, this sets up only 64 KiB of I/O ports while your device tree describes
>>> I/O space 1 MiB is size.
> 
>> This driver should be able to cope with multiple host controllers, so each
>> allocated 64KiB for I/O. 64KiB is all you need for I/O, but the R-Car PCIe
>> hardware has a 1MiB region (the smallest one) that can only be used for
> one
>> type of PCIe access.
> 
[...]
>>>> +
>>>> +	/* Finish initialization - establish a PCI Express link */
>>>> +	pci_write_reg(pcie, CFINIT, PCIETCTLR);
>>>> +
>>>> +	/* This will timeout if we don't have a link. */
>>>> +	err = rcar_pcie_wait_for_dl(pcie);
>>>> +	if (err)
>>>> +		return err;
>>>> +
>>>> +	/* Enable INTx interrupts */
>>>> +	rcar_rmw32(pcie, PCIEINTXR, 0, 0xF << 8);
>>>> +
>>>> +	/* Enable slave Bus Mastering */
>>>> +	rcar_rmw32(pcie, RCONF(PCI_STATUS), PCI_STATUS_DEVSEL_MASK,
>>>> +		PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
>>> PCI_COMMAND_MASTER |
>>>> +		PCI_STATUS_CAP_LIST | PCI_STATUS_DEVSEL_FAST);
> 
>>>      Hmm, you're mixing up PCI control/status registers' bits here; they're
>>> two 16-bit registers! So you're writing to 3 reserved LSBs of the PCI status
>>> register...
> 
>     ... and therefore not writing these bits to the PCI command (not control,
> sorry) register. Perhaps because of that PCI-PCI bridge remains inactive...
> 
>> The mask arg should make sure that we don't write to reserved bits.
> However,
> 
>     Look at rcar_rmw32() again -- it doesn't really do that.
Yeah, that's why I said it should, not does. It only clears those bits in the
register's current value.

[...]
>>>> +static int rcar_pcie_probe(struct platform_device *pdev)
>>>> +{
>>>> +	struct rcar_pcie *pcie;
>>>> +	unsigned int data;
>>>> +	struct of_pci_range range;
>>>> +	struct of_pci_range_parser parser;
>>>> +	const struct of_device_id *of_id;
>>>> +	int err, win = 0;
>>>> +	int (*hw_init_fn)(struct rcar_pcie *);
>>>> +
>>>> +	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
>>>> +	if (!pcie)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	pcie->dev = &pdev->dev;
>>>> +	platform_set_drvdata(pdev, pcie);
>>>> +
>>>> +	/* Get the bus range */
>>>> +	if (of_pci_parse_bus_range(pdev->dev.of_node, &pcie->busn)) {
>>>> +		dev_err(&pdev->dev, "failed to parse bus-range
>>> property\n");
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	if (of_pci_range_parser_init(&parser, pdev->dev.of_node)) {
>>>> +		dev_err(&pdev->dev, "missing ranges property\n");
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	err = rcar_pcie_get_resources(pdev, pcie);
>>>> +	if (err < 0) {
>>>> +		dev_err(&pdev->dev, "failed to request resources: %d\n",
>>> err);
>>>> +		return err;
>>>> +	}
>>>> +
>>>> +	for_each_of_pci_range(&parser, &range) {
>>>> +		of_pci_range_to_resource(&range, pdev->dev.of_node,
>>>> +						&pcie->res[win++]);
> 
>>>      This function call is probably no good here as it fetches into the 'start'
>>> field of a 'struct resource' a CPU address instead of a PCI address...
> 
>> No, the ranges describe the CPU addresses of the PCI memory and I/O
> regions, so
>> this is correct.
> 
>     The problem actually is that you need to remember both CPU and PCI
> addresses, so 'struct of_pci_range' looks more fitting here...
Right, I see... this is rather a mess with all the host drivers!

>>>> +
>>>> +		if (win > PCI_MAX_RESOURCES)
>>>> +			break;
>>>> +	}
>>>> +
>>>> +	 err = rcar_pcie_parse_map_dma_ranges(pcie, pdev->dev.of_node);
>>>> +	 if (err)
>>>> +		return err;
>>>> +
>>>> +	of_id = of_match_device(rcar_pcie_of_match, pcie->dev);
>>>> +	if (!of_id || !of_id->data)
>>>> +		return -EINVAL;
>>>> +	hw_init_fn = of_id->data;
>>>> +
>>>> +	/* Failure to get a link might just be that no cards are inserted */
>>>> +	err = hw_init_fn(pcie);
>>>> +	if (err) {
>>>> +		dev_info(&pdev->dev, "PCIe link down\n");
>>>> +		return 0;
> 
>>>      Not quite sure why you exit normally here without enabling the
> hardware.
>>> I think the internal bridge should be visible regardless of whether link is
>>> detected or not...
> 
>> Why would you want to see the bridge when you can do nothing with it?
> Aren't
> 
>     Because it's the way PCI works. You have the built-in devices always
> present and seen on a PCI bus. :-)
> 
>> you are just wasting resources?
> 
>     I think it's rather you who are wasting resources. ;-) Why not just fail
> the probe when you have no link?
Ah, so we currently have a half-way house... not failing the probe, but not
enabling the HW. Either all or nothing would be preferable.

Thanks
Phil
