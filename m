Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:42161 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754726AbaFWVLM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jun 2014 17:11:12 -0400
Received: by mail-lb0-f170.google.com with SMTP id 10so5368213lbg.15
        for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2014 14:11:10 -0700 (PDT)
Message-ID: <53A897EF.2020804@cogentembedded.com>
Date: Tue, 24 Jun 2014 01:11:11 +0400
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
To: Phil Edworthy <phil.edworthy@renesas.com>,
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
Subject: Re: [PATCH v8 1/3] PCI: host: rcar: Add Renesas R-Car PCIe driver
References: <1399892270-25021-1-git-send-email-phil.edworthy@renesas.com> <1399892270-25021-2-git-send-email-phil.edworthy@renesas.com> <53A209DA.9000000@cogentembedded.com> <20a0a16226d54b0e8d6f68e41046bbf2@HKXPR06MB168.apcprd06.prod.outlook.com>
In-Reply-To: <20a0a16226d54b0e8d6f68e41046bbf2@HKXPR06MB168.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello.

On 06/23/2014 08:44 PM, Phil Edworthy wrote:

>>      I'm investigating an imprecise external abort occurring once userland is
>> started when I have NetMos

    Or is it MosChip now? Can't remember all their renames. :-)

>> PCIe serial card inserted and the '8250_pci'
>> driver
>> enabled and I have found some issues in this driver, while at it...

    I should mention that the serial PCI device has both I/O port and memory 
BARs; it's the driver's choice to use the I/O ports.

> Shame they didn't come before the driver was accepted,

    Sorry, I don't usually review large patches -- it's very time consuming 
(my review took 2+ hours and yet I haven't pointed out all issues).

> but still, I welcome the comments. See below.

    Thanks. :-)

>>> This PCIe Host driver currently does not support MSI, so cards
>>> fall back to INTx interrupts.

>>> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

[...]

>>> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
>>> new file mode 100644
>>> index 0000000..3c524b9
>>> --- /dev/null
>>> +++ b/drivers/pci/host/pcie-rcar.c
>>> @@ -0,0 +1,768 @@

[...]

>>> +static void pci_write_reg(struct rcar_pcie *pcie, unsigned long val,
>>> +			  unsigned long reg)
>>> +{
>>> +	writel(val, pcie->base + reg);
>>> +}
>>> +
>>> +static unsigned long pci_read_reg(struct rcar_pcie *pcie, unsigned long
>> reg)
>>> +{
>>> +	return readl(pcie->base + reg);
>>> +}

>>      As a side note, these functions are hardly needed, and risk collision too...

> Ben mentioned this in his review and as I said then, I found them useful during
> development, so we agreed to leave them. Since they are static, there shouldn't
> be a collision risk.

    You're risking clashes even at the source level, not even at object file 
level...

>>> +static void rcar_pcie_setup_window(int win, struct resource *res,
>>> +				   struct rcar_pcie *pcie)

>>      As a side note, 'res' parameter is hardly needed here, as the function
>> always gets
>> called with the resources contained within 'struct rcar_pcie'...

> Either I would have to pass an index to the resource in,

    But you already do pass it, 'win' is the index!

> or as I have done, a
> pointer to the individual resource. I found it cleaner to pass the pointer.

    You're actually pass excess parameters, both the index and the pointer.

[...]

>>> +
>>> +	/* First resource is for IO */
>>> +	mask = PAR_ENABLE;
>>> +	if (res->flags & IORESOURCE_IO)
>>> +		mask |= IO_SPACE;

>>      For the memory space this works OK as you're identity-mapping the
>> memory
>> ranges in your device trees. However, for the I/O space this means that it
>> won't work as the BARs in the PCIe devices get programmed with the PCI bus
>> addresses but the PCIe window translation register is programmed with a
>> CPU
>> address which don't at all match (given your device trees) and hence one
>> can't
>> access the card's I/O mapped registers at all...

> Hmm, I couldn't find any cards that supported I/O, so I wasn't able to test
> this. Clearly this is an issue that needs looking into.

    Will you look into it then, or should I?

>>> +
>>> +	pci_write_reg(pcie, mask, PCIEPTCTLR(win));
>>> +}
>>> +
>>> +static int rcar_pcie_setup(int nr, struct pci_sys_data *sys)
>>> +{
>>> +	struct rcar_pcie *pcie = sys_to_pcie(sys);
>>> +	struct resource *res;
>>> +	int i;
>>> +
>>> +	pcie->root_bus_nr = -1;
>>> +
>>> +	/* Setup PCI resources */
>>> +	for (i = 0; i < PCI_MAX_RESOURCES; i++) {
>>> +
>>> +		res = &pcie->res[i];
>>> +		if (!res->flags)
>>> +			continue;
>>> +
>>> +		rcar_pcie_setup_window(i, res, pcie);
>>> +
>>> +		if (res->flags & IORESOURCE_IO)
>>> +			pci_ioremap_io(nr * SZ_64K, res->start);

>>     I'm not sure why are you not calling pci_add_resource() for I/O space...

    Sorry, did you reply to that?

>> Also, this sets up only 64 KiB of I/O ports while your device tree describes
>> I/O space 1 MiB is size.

> This driver should be able to cope with multiple host controllers, so each
> allocated 64KiB for I/O. 64KiB is all you need for I/O, but the R-Car PCIe
> hardware has a 1MiB region (the smallest one) that can only be used for one
> type of PCIe access.

[...]

>>> +static int rcar_pcie_hw_init(struct rcar_pcie *pcie)
>>> +{
>>> +	int err;
>>> +
>>> +	/* Begin initialization */
>>> +	pci_write_reg(pcie, 0, PCIETCTLR);
>>> +
>>> +	/* Set mode */
>>> +	pci_write_reg(pcie, 1, PCIEMSR);
>>> +
>>> +	/*
>>> +	 * Initial header for port config space is type 1, set the device
>>> +	 * class to match. Hardware takes care of propagating the IDSETR
>>> +	 * settings, so there is no need to bother with a quirk.
>>> +	 */
>>> +	pci_write_reg(pcie, PCI_CLASS_BRIDGE_PCI << 16, IDSETR1);

>>      Hm, shouldn't this be a host bridge? I've noticed that the bridge's I/O
>> and memory base/limit registers are left uninitialized even though the BARs
>> of the PICe devices behind this bridge are assigned.

> No, I am pretty sure this is correct.

    It just looks strange. What you actually have is clearly a host-to-PCI 
bridge. Instead you have one "virtual" PCI bus consisting of only PCI-PCI 
bridge device, and the real PCIe bus hanging from the PCI-PCI bridge. Weird...

[...]

>>> +
>>> +	/* Terminate list of capabilities (Next Capability Offset=0) */
>>> +	rcar_rmw32(pcie, RVCCAP(0), 0xfff0, 0);
>>> +
>>> +	/* Enable MAC data scrambling. */

    I wonder what does MAC mean in the PCIe context...

>>> +	rcar_rmw32(pcie, MACCTLR, SCRAMBLE_DISABLE, 0);

>>      Doesn't the comment contradict the code here?

> No, the rmw32 function is read, modify, write and the SCRAMBLE_DISABLE shown
> here is the mask, not the value. If the last arg was 1, the call would set the
> scramble disable bit to 1.

    Ah, missed that, sorry.

> Anyway, scrambling is enabled by default in the HW, so I'll remove this.

    OK.

>>> +
>>> +	/* Finish initialization - establish a PCI Express link */
>>> +	pci_write_reg(pcie, CFINIT, PCIETCTLR);
>>> +
>>> +	/* This will timeout if we don't have a link. */
>>> +	err = rcar_pcie_wait_for_dl(pcie);
>>> +	if (err)
>>> +		return err;
>>> +
>>> +	/* Enable INTx interrupts */
>>> +	rcar_rmw32(pcie, PCIEINTXR, 0, 0xF << 8);
>>> +
>>> +	/* Enable slave Bus Mastering */
>>> +	rcar_rmw32(pcie, RCONF(PCI_STATUS), PCI_STATUS_DEVSEL_MASK,
>>> +		PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
>> PCI_COMMAND_MASTER |
>>> +		PCI_STATUS_CAP_LIST | PCI_STATUS_DEVSEL_FAST);

>>      Hmm, you're mixing up PCI control/status registers' bits here; they're
>> two 16-bit registers! So you're writing to 3 reserved LSBs of the PCI status
>> register...

    ... and therefore not writing these bits to the PCI command (not control, 
sorry) register. Perhaps because of that PCI-PCI bridge remains inactive...

> The mask arg should make sure that we don't write to reserved bits. However,

    Look at rcar_rmw32() again -- it doesn't really do that.

> the bits & mask combination is clearly wrong & I'll look at this.
> Somewhere along the line, the use of the mask arg to the rcar_rmw32 function
> has clearly gone astray. I checked all the rmw calls and found another couple
> that are wrong.

    OK, please fix those.

[...]

>>> +static int rcar_pcie_probe(struct platform_device *pdev)
>>> +{
>>> +	struct rcar_pcie *pcie;
>>> +	unsigned int data;
>>> +	struct of_pci_range range;
>>> +	struct of_pci_range_parser parser;
>>> +	const struct of_device_id *of_id;
>>> +	int err, win = 0;
>>> +	int (*hw_init_fn)(struct rcar_pcie *);
>>> +
>>> +	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
>>> +	if (!pcie)
>>> +		return -ENOMEM;
>>> +
>>> +	pcie->dev = &pdev->dev;
>>> +	platform_set_drvdata(pdev, pcie);
>>> +
>>> +	/* Get the bus range */
>>> +	if (of_pci_parse_bus_range(pdev->dev.of_node, &pcie->busn)) {
>>> +		dev_err(&pdev->dev, "failed to parse bus-range
>> property\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	if (of_pci_range_parser_init(&parser, pdev->dev.of_node)) {
>>> +		dev_err(&pdev->dev, "missing ranges property\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	err = rcar_pcie_get_resources(pdev, pcie);
>>> +	if (err < 0) {
>>> +		dev_err(&pdev->dev, "failed to request resources: %d\n",
>> err);
>>> +		return err;
>>> +	}
>>> +
>>> +	for_each_of_pci_range(&parser, &range) {
>>> +		of_pci_range_to_resource(&range, pdev->dev.of_node,
>>> +						&pcie->res[win++]);

>>      This function call is probably no good here as it fetches into the 'start'
>> field of a 'struct resource' a CPU address instead of a PCI address...

> No, the ranges describe the CPU addresses of the PCI memory and I/O regions, so
> this is correct.

    The problem actually is that you need to remember both CPU and PCI 
addresses, so 'struct of_pci_range' looks more fitting here...

>>> +
>>> +		if (win > PCI_MAX_RESOURCES)
>>> +			break;
>>> +	}
>>> +
>>> +	 err = rcar_pcie_parse_map_dma_ranges(pcie, pdev->dev.of_node);
>>> +	 if (err)
>>> +		return err;
>>> +
>>> +	of_id = of_match_device(rcar_pcie_of_match, pcie->dev);
>>> +	if (!of_id || !of_id->data)
>>> +		return -EINVAL;
>>> +	hw_init_fn = of_id->data;
>>> +
>>> +	/* Failure to get a link might just be that no cards are inserted */
>>> +	err = hw_init_fn(pcie);
>>> +	if (err) {
>>> +		dev_info(&pdev->dev, "PCIe link down\n");
>>> +		return 0;

>>      Not quite sure why you exit normally here without enabling the hardware.
>> I think the internal bridge should be visible regardless of whether link is
>> detected or not...

> Why would you want to see the bridge when you can do nothing with it? Aren't

    Because it's the way PCI works. You have the built-in devices always 
present and seen on a PCI bus. :-)

> you are just wasting resources?

    I think it's rather you who are wasting resources. ;-) Why not just fail 
the probe when you have no link?

WBR, Sergei

