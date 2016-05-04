Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35139 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbcEDUH3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 May 2016 16:07:29 -0400
Subject: Re: [PATCH 2/2] pci: host: Add Broadcom STB PCIE RC controller
To: Arnd Bergmann <arnd@arndb.de>
References: <1462238749-19715-1-git-send-email-f.fainelli@gmail.com>
 <2339405.90vXV1p6zU@wuerfel> <572A4F31.8010802@gmail.com>
 <4199321.vpfzMt0zhT@wuerfel>
Cc: jim2101024@gmail.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com, bhelgaas@google.com
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <572A5678.7020603@gmail.com>
Date: Wed, 4 May 2016 13:07:20 -0700
MIME-Version: 1.0
In-Reply-To: <4199321.vpfzMt0zhT@wuerfel>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/05/16 12:56, Arnd Bergmann wrote:
> On Wednesday 04 May 2016 12:36:17 Florian Fainelli wrote:
>> On 03/05/16 02:57, Arnd Bergmann wrote:
>>>> +static const struct pcie_cfg_data generic_cfg = {
>>>> +	.offsets	= pcie_offsets,
>>>> +	.type		= GENERIC,
>>>> +};
>>>
>>> The way you access the config space here seems very indirect. I'd
>>> suggest instead writing two sets of pci_ops, with hardcoded registers
>>> offsets in them, and a function pointer to access the RGR1_SW_INIT_1
>>> register.
>>
>> How about introducing helper functions but keeping the same set of
>> read/write pci_ops instead, would that seem more acceptable? I agree
>> that the macros are not the friendliest thing.
> 
> I can't think of how that would look right now. My impression was that
> the macros here are mainly used to implement pci_ops, so I suggested
> having two copies of those. Of course the two copies could call the
> same implementation and just pass in some constant that the compiler
> can then optimize again in any possible way.

Providing separate copies for read_config and write_config makes sense,
what I wanted to avoid was 3 sets of brcm_pcie_read_config and
brcm_pcie_write_config, because that would be duplicating quite some
code, working on that now.

> 
>>>> +struct brcm_msi {
>>>> +	struct irq_domain *domain;
>>>> +	struct irq_chip irq_chip;
>>>> +	struct msi_controller chip;
>>>> +	struct mutex lock;
>>>> +	int irq;
>>>> +	/* intr_base is the base pointer for interrupt status/set/clr regs */
>>>> +	void __iomem *intr_base;
>>>> +	/* intr_legacy_mask indicates how many bits are MSI interrupts */
>>>> +	u32 intr_legacy_mask;
>>>> +	/* intr_legacy_offset indicates bit position of MSI_01 */
>>>> +	u32 intr_legacy_offset;
>>>> +	/* used indicates which MSI interrupts have been alloc'd */
>>>> +	unsigned long used;
>>>> +	/* working indicates that on boot we have brought up MSI */
>>>> +	bool working;
>>>> +};
>>>
>>> I'd move the MSI controller stuff into a separate file, and add a way to
>>> override it. It's likely that at some point the same PCIe implementation
>>> will be used with a modern GICv3 or GICv2m, so you should be able to
>>> look up the msi controller from a property.
>>
>> Good point, let's do that, though all controllers actually do support
>> MSI, so I wonder.
> 
> The point is more that you might have more than one MSI implementation
> in a future SoC, if you have both a GICv3 and this PCIe block, you
> could use either one of them, but presumably using the GIC will be more
> efficient because it actually allows doing IRQ affinity and having
> low-latency interrupts when you don't need an expensive readl().

OK, I have actually stated doing just that.

> 
>>>> +
>>>> +	/* set up 4GB PCIE->SCB memory window on BAR2 */
>>>> +	bpcie_writel(0x00000011, base + PCIE_MISC_RC_BAR2_CONFIG_LO);
>>>> +	bpcie_writel(0x00000000, base + PCIE_MISC_RC_BAR2_CONFIG_HI);
>>>
>>> Where does this window come from? It's not in the DT as far as I can see.
>>
>> This is an architectural maximum value which is baked into the PCIE Root
>> Complex hardware, on all generations that this driver supports. We
>> configure the largest address match rang size here, just to be safe,
>> AFAICT there is no point in looking at the inbound or outbound window
>> sizes to re-program that differently.
> 
> Ok, makes sense. In theory you could limit this to isolate PCI
> bus masters from doing things you don't want them to (e.g. for
> a hypervisor that assigns the entire PCI host bridge to a VM),
> but I can't think of a use case for Linux here.

Exactly.

> 
>>>> +	INIT_LIST_HEAD(&pcie->pwr_supplies);
>>>> +	INIT_LIST_HEAD(&pcie->resource);
>>>> +
>>>> +	supplies = of_property_count_strings(dn, "supply-names");
>>>> +	if (supplies <= 0)
>>>> +		supplies = 0;
>>>> +
>>>> +	for (i = 0; i < supplies; i++) {
>>>> +		if (of_property_read_string_index(dn, "supply-names", i,
>>>> +						  &name))
>>>> +			continue;
>>>> +		supply = devm_kzalloc(&pdev->dev, sizeof(*supply), GFP_KERNEL);
>>>> +		if (!supply)
>>>> +			return -ENOMEM;
>>>> +
>>>> +		strncpy(supply->name, name, sizeof(supply->name));
>>>> +		supply->name[sizeof(supply->name) - 1] = '\0';
>>>> +		supply->regulator = devm_regulator_get(&pdev->dev, name);
>>>> +		if (IS_ERR(supply->regulator)) {
>>>> +			dev_err(&pdev->dev, "Unable to get %s supply, err=%d\n",
>>>> +				name, (int)PTR_ERR(supply->regulator));
>>>> +			continue;
>>>> +		}
>>>> +
>>>> +		if (regulator_enable(supply->regulator))
>>>> +			dev_err(&pdev->dev, "Unable to enable %s supply.\n",
>>>> +				name);
>>>> +		list_add_tail(&supply->node, &pcie->pwr_supplies);
>>>> +	}
>>>
>>> Don't parse the regulator properties yourself here, use the proper APIs.
>>
>> I will probably drop this for now, and  add it later, there are only a
>> handful of boards which requires this, and ultimately, I think we should
>> be seaking for a more generic solutions, we can't be the only ones doing
>> that.
> 
> So is this the supply for the slots attached to the PCI host rather than
> the host bridge itself?

Technically yes, there are for the attached PCI slots, not the hsost
bridge, so their are misplaced, we need to rework that, and I would
prefer if there was a way to make it pre-scan type of operation offered
by the core PCI code itself, but then there is a chicken and egg
problem: you cannot get regulators for device_nodes that have not been
created yet, and you can't create pci_device and their corresponding
device_nodes until you have turned them on...

> 
>>>
>>>> +	/* 'num_memc' will be set only by the first controller, and all
>>>> +	 * other controllers will use the value set by the first.
>>>> +	 */
>>>> +	if (num_memc == 0)
>>>> +		for_each_compatible_node(mdn, NULL, "brcm,brcmstb-memc")
>>>> +			if (of_device_is_available(mdn))
>>>> +				num_memc++;
>>>
>>> Why is this?
>>
>> This is so we do not end-up programming the PCIe RC which is agnostic of
>> the number of
> 
> You didn't complete this sentence, but I think I've gotten a better
> idea of what is going on from the code now. It looks like this
> is used to program a set of default DMA ranges into the host
> bridge, so there are now three ways of finding out what it
> should be:
> 
> a) count the memory controllers, assume that each one has 1GB of
>    address space
> b) read the "brcm,log2-scb-sizes" property to find out the
>    actual sizes
> c) interpret the dma-ranges property
> 
> The first two seem to things in a rather nonstandard way (the binding
> mentions neither of them), while the third is not implemented yet.
> I think we have to improve this.

What I meant to say is that we want to avoid programming a SCB window
(SCB equals memory controller for the sake of making things simple here)
which does not have a baking memory controller, because, well, guess
what happens, the PCIe RC could be trying to access non existent memory,
and just stall doing so because no error reporting, I can't remember
which chips had this problem exactly, but there were definitively some,
so the concern is real.

The "brcm,log2-scb-sizes" should be correctly populated all the time in
our Device Tree blobs, but we are not quite making a use of them here.

"dma-ranges" seems like an appropriate solution, but sorts of forces us
to reinforce the same information that is available somewhere in the
Device Tree within the memory controllers nodes themselves.

Let me think about this some more.
-- 
Florian
