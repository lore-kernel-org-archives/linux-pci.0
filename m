Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:32872 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088AbcEDTgW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 May 2016 15:36:22 -0400
Subject: Re: [PATCH 2/2] pci: host: Add Broadcom STB PCIE RC controller
To: Arnd Bergmann <arnd@arndb.de>, jim2101024@gmail.com
References: <1462238749-19715-1-git-send-email-f.fainelli@gmail.com>
 <1462238749-19715-3-git-send-email-f.fainelli@gmail.com>
 <2339405.90vXV1p6zU@wuerfel>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com, bhelgaas@google.com
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <572A4F31.8010802@gmail.com>
Date: Wed, 4 May 2016 12:36:17 -0700
MIME-Version: 1.0
In-Reply-To: <2339405.90vXV1p6zU@wuerfel>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/05/16 02:57, Arnd Bergmann wrote:
>> +static const struct pcie_cfg_data generic_cfg = {
>> +	.offsets	= pcie_offsets,
>> +	.type		= GENERIC,
>> +};
> 
> The way you access the config space here seems very indirect. I'd
> suggest instead writing two sets of pci_ops, with hardcoded registers
> offsets in them, and a function pointer to access the RGR1_SW_INIT_1
> register.

How about introducing helper functions but keeping the same set of
read/write pci_ops instead, would that seem more acceptable? I agree
that the macros are not the friendliest thing.

> 
>> +struct brcm_msi {
>> +	struct irq_domain *domain;
>> +	struct irq_chip irq_chip;
>> +	struct msi_controller chip;
>> +	struct mutex lock;
>> +	int irq;
>> +	/* intr_base is the base pointer for interrupt status/set/clr regs */
>> +	void __iomem *intr_base;
>> +	/* intr_legacy_mask indicates how many bits are MSI interrupts */
>> +	u32 intr_legacy_mask;
>> +	/* intr_legacy_offset indicates bit position of MSI_01 */
>> +	u32 intr_legacy_offset;
>> +	/* used indicates which MSI interrupts have been alloc'd */
>> +	unsigned long used;
>> +	/* working indicates that on boot we have brought up MSI */
>> +	bool working;
>> +};
> 
> I'd move the MSI controller stuff into a separate file, and add a way to
> override it. It's likely that at some point the same PCIe implementation
> will be used with a modern GICv3 or GICv2m, so you should be able to
> look up the msi controller from a property.

Good point, let's do that, though all controllers actually do support
MSI, so I wonder.

> 
>> +struct brcm_window {
>> +	u64 size;
>> +	u64 cpu_addr;
>> +	struct resource pcie_iomem_res;
>> +};
> 
> This appears to duplicate things we already have. Try to get rid of
> the structure and use what is already there.

OK, the resource is probably good enough here.

> 
>> +struct brcm_dev_pwr_supply {
>> +	struct list_head node;
>> +	char name[32];
>> +	struct regulator *regulator;
>> +};
> 
> Same here: Just get all the regulators you know about by name
> and put them into the main structure.

OK, I will drop the regulator support for now, see below for a more
elaborate answer.

> 
>> +/* Internal Bus Controller Information.*/
>> +struct brcm_pcie {
>> +	struct list_head	list;
>> +	void __iomem		*base;
>> +	char			name[8];
>> +	bool			suspended;
>> +	struct clk		*clk;
>> +	struct device_node	*dn;
>> +	int			pcie_irq[4];
>> +	int			irq;
>> +	int			num_out_wins;
>> +	bool			ssc;
>> +	int			gen;
>> +	int			scb_size_vals[BRCM_MAX_SCB];
>> +	struct brcm_window	out_wins[BRCM_NUM_PCI_OUT_WINS];
>> +	struct pci_bus		*bus;
>> +	struct device		*dev;
>> +	struct list_head	resource;
>> +	struct list_head	pwr_supplies;
>> +	struct brcm_msi		msi;
>> +	unsigned int		rev;
>> +	unsigned int		num;
>> +	bool			bridge_setup_done;
>> +	const int		*reg_offsets;
>> +	enum pcie_type		type;
>> +};
>> +
>> +static int brcm_num_pci_controllers;
>> +static int num_memc;
> 
> Remove the globals.

OK.

> 
>> +
>> +/*
>> + * MIPS endianness is configured by boot strap, which also reverses all
>> + * bus endianness (i.e., big-endian CPU + big endian bus ==> native
>> + * endian I/O).
>> + *
>> + * Other architectures (e.g., ARM) either do not support big endian, or
>> + * else leave I/O in little endian mode.
>> + */
>> +static inline u32 bpcie_readl(void __iomem *base)
>> +{
>> +	if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
>> +		return __raw_readl(base);
>> +	else
>> +		return readl_relaxed(base);
>> +}
> 
> I think it would make more sense to only make this depend on the
> architecture, not on endianess: If the __raw_ version works on MIPS
> in big-endian mode, you should be able to also use it in little-endian
> mode.
> 
> For the default (ARM) version, please use the non-relaxed accessor
> by default, unless you can show a difference in performance and prove
> that you don't need the implied barriers.

Our busing makes it so that the __raw_readl() (or _relaxed) I/O access
is going to have the same guarantees as if we were adding a barrier,
that is, writes are not going to be re-ordered with each other by the
bus, nor the CPU (since it maps the space as device memory), and on
MIPS, well, it's all through unmapped, uncached space, but I can
definitively switch that for readl(), should not make a huge performance
difference, if noticeable.

> 
>> +/* negative return value indicates error */
>> +static int mdio_read(void __iomem *base, u8 phyad, u8 regad)
>> +{
>> +	u32 data = ((phyad & 0xf) << 16)
>> +		| (regad & 0x1f)
>> +		| 0x100000;
>> +
>> +	bpcie_writel(data, base + PCIE_RC_DL_MDIO_ADDR);
>> +	bpcie_readl(base + PCIE_RC_DL_MDIO_ADDR);
>> +
>> +	data = bpcie_readl(base + PCIE_RC_DL_MDIO_RD_DATA);
>> +	if (!(data & 0x80000000)) {
>> +		mdelay(1);
> 
> Try to restructure the code so this is never called with spinlocks
> held and then replace the mdelay() with an msleep().

I cannot really think of a reason why we did not use msleep() all along,
so thanks for spotting that.

>> +
>> +	/* set up 4GB PCIE->SCB memory window on BAR2 */
>> +	bpcie_writel(0x00000011, base + PCIE_MISC_RC_BAR2_CONFIG_LO);
>> +	bpcie_writel(0x00000000, base + PCIE_MISC_RC_BAR2_CONFIG_HI);
> 
> Where does this window come from? It's not in the DT as far as I can see.

This is an architectural maximum value which is baked into the PCIE Root
Complex hardware, on all generations that this driver supports. We
configure the largest address match rang size here, just to be safe,
AFAICT there is no point in looking at the inbound or outbound window
sizes to re-program that differently.


>> +	INIT_LIST_HEAD(&pcie->pwr_supplies);
>> +	INIT_LIST_HEAD(&pcie->resource);
>> +
>> +	supplies = of_property_count_strings(dn, "supply-names");
>> +	if (supplies <= 0)
>> +		supplies = 0;
>> +
>> +	for (i = 0; i < supplies; i++) {
>> +		if (of_property_read_string_index(dn, "supply-names", i,
>> +						  &name))
>> +			continue;
>> +		supply = devm_kzalloc(&pdev->dev, sizeof(*supply), GFP_KERNEL);
>> +		if (!supply)
>> +			return -ENOMEM;
>> +
>> +		strncpy(supply->name, name, sizeof(supply->name));
>> +		supply->name[sizeof(supply->name) - 1] = '\0';
>> +		supply->regulator = devm_regulator_get(&pdev->dev, name);
>> +		if (IS_ERR(supply->regulator)) {
>> +			dev_err(&pdev->dev, "Unable to get %s supply, err=%d\n",
>> +				name, (int)PTR_ERR(supply->regulator));
>> +			continue;
>> +		}
>> +
>> +		if (regulator_enable(supply->regulator))
>> +			dev_err(&pdev->dev, "Unable to enable %s supply.\n",
>> +				name);
>> +		list_add_tail(&supply->node, &pcie->pwr_supplies);
>> +	}
> 
> Don't parse the regulator properties yourself here, use the proper APIs.

I will probably drop this for now, and  add it later, there are only a
handful of boards which requires this, and ultimately, I think we should
be seaking for a more generic solutions, we can't be the only ones doing
that.

> 
>> +	/* 'num_memc' will be set only by the first controller, and all
>> +	 * other controllers will use the value set by the first.
>> +	 */
>> +	if (num_memc == 0)
>> +		for_each_compatible_node(mdn, NULL, "brcm,brcmstb-memc")
>> +			if (of_device_is_available(mdn))
>> +				num_memc++;
> 
> Why is this?

This is so we do not end-up programming the PCIe RC which is agnostic of
the number of

> 
>> +	resource_list_for_each_entry(win, &res) {
>> +		struct brcm_window *w = &pcie->out_wins[i];
>> +
>> +		r = win->res;
>> +
>> +		if (!r->flags)
>> +			continue;
>> +
>> +		switch (resource_type(r)) {
>> +		case IORESOURCE_MEM:
>> +			w->cpu_addr = r->start;
>> +			w->size = resource_size(r);
>> +			w->pcie_iomem_res.name  = "External PCIe MEM";
>> +			w->pcie_iomem_res.flags = r->flags;
>> +			w->pcie_iomem_res.start = r->start;
>> +			w->pcie_iomem_res.end   = r->end;
>> +			pcie->num_out_wins++;
>> +			i++;
>> +			/* Request memory region resources. */
>> +			ret = devm_request_resource(&pdev->dev,
>> +						    &iomem_resource,
>> +						    &w->pcie_iomem_res);
>> +			if (ret) {
>> +				dev_err(&pdev->dev,
>> +					"request PCIe memory resource failed\n");
>> +				goto out_err_clk;
>> +			}
>> +			break;
>> +
>> +		default:
>> +			continue;
>> +		}
>> +	}
> 
> What about IORESOURCE_IO?

We do not support I/O space on this controller AFAIR. Our downstream
driver does insert a fake bogus I/O range, but I cannot really remember
why that was needed now, Jim do you remember?
-- 
Florian
