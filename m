Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:49852 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbcECJ6Q (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2016 05:58:16 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	bhelgaas@google.com
Subject: Re: [PATCH 2/2] pci: host: Add Broadcom STB PCIE RC controller
Date: Tue, 03 May 2016 11:57:43 +0200
Message-ID: <2339405.90vXV1p6zU@wuerfel>
In-Reply-To: <1462238749-19715-3-git-send-email-f.fainelli@gmail.com>
References: <1462238749-19715-1-git-send-email-f.fainelli@gmail.com> <1462238749-19715-3-git-send-email-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 02 May 2016 18:25:49 Florian Fainelli wrote:

> +/* Helper macros for reading registers varying from chip-to-chip */
> +#define IDX_ADDR(pcie)			((pcie->base) + \
> +					 pcie->reg_offsets[EXT_CFG_INDEX])
> +#define DATA_ADDR(pcie)			((pcie->base) + \
> +					 pcie->reg_offsets[EXT_CFG_DATA])
> +#define PCIE_RGR1_SW_INIT_1(pcie)	((pcie->base) + \
> +					 pcie->reg_offsets[RGR1_SW_INIT_1])
> +
> +static const int pcie_offset_bcm7425[] = {
> +	[RGR1_SW_INIT_1] = 0x8010,
> +	[EXT_CFG_INDEX]  = 0x8300,
> +	[EXT_CFG_DATA]   = 0x8304,
> +};
> +
> +static const struct pcie_cfg_data bcm7425_cfg = {
> +	.offsets	= pcie_offset_bcm7425,
> +	.type		= BCM7425,
> +};
> +
> +static const int pcie_offsets[] = {
> +	[RGR1_SW_INIT_1] = 0x9210,
> +	[EXT_CFG_INDEX]  = 0x9000,
> +	[EXT_CFG_DATA]   = 0x9004,
> +};
> +
> +static const struct pcie_cfg_data bcm7435_cfg = {
> +	.offsets	= pcie_offsets,
> +	.type		= BCM7435,
> +};
> +
> +static const struct pcie_cfg_data generic_cfg = {
> +	.offsets	= pcie_offsets,
> +	.type		= GENERIC,
> +};

The way you access the config space here seems very indirect. I'd
suggest instead writing two sets of pci_ops, with hardcoded registers
offsets in them, and a function pointer to access the RGR1_SW_INIT_1
register.

> +struct brcm_msi {
> +	struct irq_domain *domain;
> +	struct irq_chip irq_chip;
> +	struct msi_controller chip;
> +	struct mutex lock;
> +	int irq;
> +	/* intr_base is the base pointer for interrupt status/set/clr regs */
> +	void __iomem *intr_base;
> +	/* intr_legacy_mask indicates how many bits are MSI interrupts */
> +	u32 intr_legacy_mask;
> +	/* intr_legacy_offset indicates bit position of MSI_01 */
> +	u32 intr_legacy_offset;
> +	/* used indicates which MSI interrupts have been alloc'd */
> +	unsigned long used;
> +	/* working indicates that on boot we have brought up MSI */
> +	bool working;
> +};

I'd move the MSI controller stuff into a separate file, and add a way to
override it. It's likely that at some point the same PCIe implementation
will be used with a modern GICv3 or GICv2m, so you should be able to
look up the msi controller from a property.

> +struct brcm_window {
> +	u64 size;
> +	u64 cpu_addr;
> +	struct resource pcie_iomem_res;
> +};

This appears to duplicate things we already have. Try to get rid of
the structure and use what is already there.

> +struct brcm_dev_pwr_supply {
> +	struct list_head node;
> +	char name[32];
> +	struct regulator *regulator;
> +};

Same here: Just get all the regulators you know about by name
and put them into the main structure.

> +/* Internal Bus Controller Information.*/
> +struct brcm_pcie {
> +	struct list_head	list;
> +	void __iomem		*base;
> +	char			name[8];
> +	bool			suspended;
> +	struct clk		*clk;
> +	struct device_node	*dn;
> +	int			pcie_irq[4];
> +	int			irq;
> +	int			num_out_wins;
> +	bool			ssc;
> +	int			gen;
> +	int			scb_size_vals[BRCM_MAX_SCB];
> +	struct brcm_window	out_wins[BRCM_NUM_PCI_OUT_WINS];
> +	struct pci_bus		*bus;
> +	struct device		*dev;
> +	struct list_head	resource;
> +	struct list_head	pwr_supplies;
> +	struct brcm_msi		msi;
> +	unsigned int		rev;
> +	unsigned int		num;
> +	bool			bridge_setup_done;
> +	const int		*reg_offsets;
> +	enum pcie_type		type;
> +};
> +
> +static int brcm_num_pci_controllers;
> +static int num_memc;

Remove the globals.

> +
> +/*
> + * MIPS endianness is configured by boot strap, which also reverses all
> + * bus endianness (i.e., big-endian CPU + big endian bus ==> native
> + * endian I/O).
> + *
> + * Other architectures (e.g., ARM) either do not support big endian, or
> + * else leave I/O in little endian mode.
> + */
> +static inline u32 bpcie_readl(void __iomem *base)
> +{
> +	if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
> +		return __raw_readl(base);
> +	else
> +		return readl_relaxed(base);
> +}

I think it would make more sense to only make this depend on the
architecture, not on endianess: If the __raw_ version works on MIPS
in big-endian mode, you should be able to also use it in little-endian
mode.

For the default (ARM) version, please use the non-relaxed accessor
by default, unless you can show a difference in performance and prove
that you don't need the implied barriers.

> +/* negative return value indicates error */
> +static int mdio_read(void __iomem *base, u8 phyad, u8 regad)
> +{
> +	u32 data = ((phyad & 0xf) << 16)
> +		| (regad & 0x1f)
> +		| 0x100000;
> +
> +	bpcie_writel(data, base + PCIE_RC_DL_MDIO_ADDR);
> +	bpcie_readl(base + PCIE_RC_DL_MDIO_ADDR);
> +
> +	data = bpcie_readl(base + PCIE_RC_DL_MDIO_RD_DATA);
> +	if (!(data & 0x80000000)) {
> +		mdelay(1);

Try to restructure the code so this is never called with spinlocks
held and then replace the mdelay() with an msleep().

> +		data = bpcie_readl(base + PCIE_RC_DL_MDIO_RD_DATA);
> +	}
> +	return (data & 0x80000000) ? (data & 0xffff) : -EIO;
> +}
> +
> +/* negative return value indicates error */
> +static int mdio_write(void __iomem *base, u8 phyad, u8 regad, u16 wrdata)
> +{
> +	u32 data = ((phyad & 0xf) << 16) | (regad & 0x1f);
> +
> +	bpcie_writel(data, base + PCIE_RC_DL_MDIO_ADDR);
> +	bpcie_readl(base + PCIE_RC_DL_MDIO_ADDR);
> +
> +	bpcie_writel(0x80000000 | wrdata, base + PCIE_RC_DL_MDIO_WR_DATA);
> +	data = bpcie_readl(base + PCIE_RC_DL_MDIO_WR_DATA);
> +	if (!(data & 0x80000000)) {
> +		mdelay(1);
> +		data = bpcie_readl(base + PCIE_RC_DL_MDIO_WR_DATA);
> +	}
> +	return (data & 0x80000000) ? 0 : -EIO;
> +}

Same here.

> +
> +	/* set up 4GB PCIE->SCB memory window on BAR2 */
> +	bpcie_writel(0x00000011, base + PCIE_MISC_RC_BAR2_CONFIG_LO);
> +	bpcie_writel(0x00000000, base + PCIE_MISC_RC_BAR2_CONFIG_HI);

Where does this window come from? It's not in the DT as far as I can see.

> +static int brcm_setup_pcie_bridge(struct brcm_pcie *pcie)
> +{
> +	static const char *link_speed[4] = { "???", "2.5", "5.0", "8.0" };
> +	void __iomem *base = pcie->base;
> +	const int limit = pcie->suspended ? 1000 : 100;
> +	struct clk *clk;
> +	unsigned int status;
> +	int i, j, ret;
> +	bool ssc_good = false;
> +
> +	/* Give the RC/EP time to wake up, before trying to configure RC.
> +	 * Intermittently check status for link-up, up to a total of 100ms
> +	 * when we don't know if the device is there, and up to 1000ms if
> +	 * we do know the device is there.
> +	 */
> +	for (i = 1, j = 0; j < limit && !is_pcie_link_up(pcie); j += i, i = i*2)
> +		mdelay(i + j > limit ? limit - j : i);

Again, try to use msleep() instead of mdelay(). Blocking the CPU for 1 second
seems highly suspicious.

> +	INIT_LIST_HEAD(&pcie->pwr_supplies);
> +	INIT_LIST_HEAD(&pcie->resource);
> +
> +	supplies = of_property_count_strings(dn, "supply-names");
> +	if (supplies <= 0)
> +		supplies = 0;
> +
> +	for (i = 0; i < supplies; i++) {
> +		if (of_property_read_string_index(dn, "supply-names", i,
> +						  &name))
> +			continue;
> +		supply = devm_kzalloc(&pdev->dev, sizeof(*supply), GFP_KERNEL);
> +		if (!supply)
> +			return -ENOMEM;
> +
> +		strncpy(supply->name, name, sizeof(supply->name));
> +		supply->name[sizeof(supply->name) - 1] = '\0';
> +		supply->regulator = devm_regulator_get(&pdev->dev, name);
> +		if (IS_ERR(supply->regulator)) {
> +			dev_err(&pdev->dev, "Unable to get %s supply, err=%d\n",
> +				name, (int)PTR_ERR(supply->regulator));
> +			continue;
> +		}
> +
> +		if (regulator_enable(supply->regulator))
> +			dev_err(&pdev->dev, "Unable to enable %s supply.\n",
> +				name);
> +		list_add_tail(&supply->node, &pcie->pwr_supplies);
> +	}

Don't parse the regulator properties yourself here, use the proper APIs.

> +	/* 'num_memc' will be set only by the first controller, and all
> +	 * other controllers will use the value set by the first.
> +	 */
> +	if (num_memc == 0)
> +		for_each_compatible_node(mdn, NULL, "brcm,brcmstb-memc")
> +			if (of_device_is_available(mdn))
> +				num_memc++;

Why is this?

> +	resource_list_for_each_entry(win, &res) {
> +		struct brcm_window *w = &pcie->out_wins[i];
> +
> +		r = win->res;
> +
> +		if (!r->flags)
> +			continue;
> +
> +		switch (resource_type(r)) {
> +		case IORESOURCE_MEM:
> +			w->cpu_addr = r->start;
> +			w->size = resource_size(r);
> +			w->pcie_iomem_res.name  = "External PCIe MEM";
> +			w->pcie_iomem_res.flags = r->flags;
> +			w->pcie_iomem_res.start = r->start;
> +			w->pcie_iomem_res.end   = r->end;
> +			pcie->num_out_wins++;
> +			i++;
> +			/* Request memory region resources. */
> +			ret = devm_request_resource(&pdev->dev,
> +						    &iomem_resource,
> +						    &w->pcie_iomem_res);
> +			if (ret) {
> +				dev_err(&pdev->dev,
> +					"request PCIe memory resource failed\n");
> +				goto out_err_clk;
> +			}
> +			break;
> +
> +		default:
> +			continue;
> +		}
> +	}

What about IORESOURCE_IO?

	Arnd
