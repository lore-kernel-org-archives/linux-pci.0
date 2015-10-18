Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 18 Oct 2015 11:21:40 -0500
From: Josh Cartwright <joshc@eso.teric.us>
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	michal.simek@xilinx.com, soren.brinkmann@xilinx.com,
	bhelgaas@google.com, arnd@arndb.de, tinamdar@apm.com,
	treding@nvidia.com, rjui@broadcom.com, Minghuan.Lian@freescale.com,
	m-karicheri2@ti.com, hauke@hauke-m.de, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bharat Kumar Gogada <bharatku@xilinx.com>,
	Ravi Kiran Gummaluri <rgummal@xilinx.com>
Subject: Re: [PATCH v4] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
Message-ID: <20151018162140.GA1279@kryptos>
References: <1445066538-24638-1-git-send-email-bharatku@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445066538-24638-1-git-send-email-bharatku@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

I've got a few comments below.

On Sat, Oct 17, 2015 at 12:52:18PM +0530, Bharat Kumar Gogada wrote:
> Adding PCIe Root Port driver for Xilinx PCIe NWL bridge IP.
> 
> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
> ---
> Added MSI domain implementation for handling MSI interrupts
> Added implementation for chained irq handlers
> Added legacy domain for handling legacy interrupts
> Added child node for handling legacy interrupt
[..]
> +++ b/drivers/pci/host/pcie-xilinx-nwl.c
[..]
> +static inline bool nwl_pcie_link_up(struct nwl_pcie *pcie, u32 check_link_up)
> +{
> +	unsigned int status = -EINVAL;
> +
> +	if (check_link_up == PCIE_USER_LINKUP)
> +		status = (readl(pcie->pcireg_base + PS_LINKUP_OFFSET) &
> +			  PCIE_PHY_LINKUP_BIT) ? 1 : 0;
> +	else if (check_link_up == PHY_RDY_LINKUP)
> +		status = (readl(pcie->pcireg_base + PS_LINKUP_OFFSET) &
> +			  PHY_RDY_LINKUP_BIT) ? 1 : 0;
> +	return status;

It would seem marginally simpler if the the bit to check was passed as
the argument, instead of a check_link_up -> bit mapping.

> +}
> +
> +/**
> + * nwl_pcie_get_config_base - Get configuration base
> + *
> + * @bus: Bus structure of current bus
> + * @devfn: Device/function
> + * @where: Offset from base
> + *
> + * Return: Base address of the configuration space needed to be
> + *	   accessed.
> + */
> +static void __iomem *nwl_pcie_get_config_base(struct pci_bus *bus,
> +						 unsigned int devfn,
> +						 int where)
> +{
> +	struct nwl_pcie *pcie = bus->sysdata;
> +	int relbus;
> +
> +	relbus = (bus->number << ECAM_BUS_LOC_SHIFT) |
> +			(devfn << ECAM_DEV_LOC_SHIFT);
> +
> +	return pcie->ecam_base + relbus + where;
> +}

It would seem you could simplify if you provide this as your map_bus
implementation of pci_ops.  Then you could use the
pci_generic_config_read/_write callbacks.

> +/**
> + * nwl_setup_sspl - Set Slot Power limit
> + *
> + * @pcie: PCIe port information
> + */
> +static int nwl_setup_sspl(struct nwl_pcie *pcie)
> +{
> +	unsigned int status;
> +	int retval = 0;
> +
> +	do {
> +		status = nwl_bridge_readl(pcie, TX_PCIE_MSG) & MSG_BUSY_BIT;
> +		if (!status) {
> +			/*
> +			 * Generate the TLP message for a single EP
> +			 * [TODO] Add a multi-endpoint code
> +			 */
> +			nwl_bridge_writel(pcie, 0x0,
> +					  TX_PCIE_MSG + TX_PCIE_MSG_CNTL);
> +			nwl_bridge_writel(pcie, 0x0,
> +					  TX_PCIE_MSG + TX_PCIE_MSG_SPEC_LO);
> +			nwl_bridge_writel(pcie, 0x0,
> +					  TX_PCIE_MSG + TX_PCIE_MSG_SPEC_HI);
> +			nwl_bridge_writel(pcie, 0x0,
> +					  TX_PCIE_MSG + TX_PCIE_MSG_DATA);
> +			/* Pattern to generate SSLP TLP */
> +			nwl_bridge_writel(pcie, PATTRN_SSLP_TLP,
> +					  TX_PCIE_MSG + TX_PCIE_MSG_CNTL);
> +			nwl_bridge_writel(pcie, RANDOM_DIGIT,
> +					  TX_PCIE_MSG + TX_PCIE_MSG_DATA);
> +			nwl_bridge_writel(pcie, nwl_bridge_readl(pcie,
> +					  TX_PCIE_MSG) | 0x1, TX_PCIE_MSG);
> +			status = 0;

This assignment looks useless?

> +			mdelay(2);
> +			status = nwl_bridge_readl(pcie, TX_PCIE_MSG)
> +						  & MSG_DONE_BIT;
> +			if (status) {
> +				status = nwl_bridge_readl(pcie, TX_PCIE_MSG)
> +						  & MSG_DONE_STATUS_BIT;
> +				if (status == SLVERR) {
> +					dev_err(pcie->dev, "AXI slave error");
> +					retval = SLVERR;
> +				} else if (status == DECERR) {
> +					dev_err(pcie->dev, "AXI Decode error");
> +					retval = DECERR;
> +				}
> +			} else {
> +				retval = 1;
> +			}
> +		}
> +	} while (status);
> +
> +	return retval;
> +}
> +
[..]
> +static int nwl_nwl_writel_config(struct pci_bus *bus,
> +				unsigned int devfn,
> +				int where,
> +				int size,
> +				u32 val)
> +{
> +	void __iomem *addr;
> +	int retval;
> +	struct nwl_pcie *pcie = bus->sysdata;
> +
> +	if (!bus->number && devfn > 0)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +	addr = nwl_pcie_get_config_base(bus, devfn, where);
> +
> +	switch (size) {
> +	case 1:
> +		writeb(val, addr);
> +		break;
> +	case 2:
> +		writew(val, addr);
> +		break;
> +	default:
> +		writel(val, addr);
> +		break;
> +	}

Considering you can handle config space accesses smaller than a word,
the name of this function seems wrong :).

> +	if (addr == (pcie->ecam_base + EXP_CAP_BASE + PCI_EXP_SLTCAP)) {
> +		retval = nwl_setup_sspl(pcie);
> +		if (retval)
> +			return PCIBIOS_SET_FAILED;
> +	}

Ah, I see you need to do something special in this case.  Regardless,
you could still use pci_generic_config_write() from this function.

> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +/* PCIe operations */
> +static struct pci_ops nwl_pcie_ops = {

I wonder if there is a compelling reason why pci_ops hasn't been
constified yet.

> +	.read  = nwl_nwl_readl_config,
> +	.write = nwl_nwl_writel_config,
> +};
> +
> +static irqreturn_t nwl_pcie_misc_handler(int irq, void *data)
> +{
> +	struct nwl_pcie *pcie = (struct nwl_pcie *)data;

Nit: Don't need the cast.

> +	u32 misc_stat;
> +
[..]
> +static void nwl_pcie_leg_handler(int irq, struct irq_desc *desc)
> +{
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	struct nwl_pcie *pcie;
> +	unsigned long status;
> +	u32 bit;
> +	u32 virq;
> +
> +	chained_irq_enter(chip, desc);
> +	pcie = irq_desc_get_handler_data(desc);
> +
> +	while ((status = nwl_bridge_readl(pcie, MSGF_LEG_STATUS) &
> +				MSGF_LEG_SR_MASKALL) != 0) {
> +		for_each_set_bit(bit, &status, 4) {
> +
> +			virq = irq_find_mapping(pcie->legacy_irq_domain,
> +						bit + 1);
> +			if (virq)
> +				generic_handle_irq(virq);
> +			else
> +				dev_err(pcie->dev, "unexpected IRQ\n");

The irq core will already handle this case for you, and better, as it
makes record of the spurious interrupt.

> +		}
> +	}
> +
> +	chained_irq_exit(chip, desc);
> +
> +}
> +
> +static void nwl_pcie_msi_handler_high(unsigned int irq, struct irq_desc *desc)
> +{
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	struct nwl_pcie *pcie;
> +	struct nwl_msi *msi;
> +	unsigned long status;
> +	u32 bit;
> +	u32 virq;
> +
> +	chained_irq_enter(chip, desc);
> +	pcie = irq_desc_get_handler_data(desc);
> +	msi = &pcie->msi;
> +
> +	while ((status = nwl_bridge_readl(pcie, MSGF_MSI_STATUS_HI)) != 0) {
> +		for_each_set_bit(bit, &status, 32) {
> +			nwl_bridge_writel(pcie, 1 << bit, MSGF_MSI_STATUS_HI);
> +			virq = irq_find_mapping(msi->dev_domain, bit);
> +			if (virq)
> +				generic_handle_irq(virq);
> +			else
> +				dev_err(pcie->dev, "unexpected MSI\n");

Same here.

[..]
> +static void nwl_pcie_msi_handler_low(unsigned int irq, struct irq_desc *desc)
> +{
[..]
> +	while ((status = nwl_bridge_readl(pcie, MSGF_MSI_STATUS_LO)) != 0) {
> +		for_each_set_bit(bit, &status, 32) {
> +			nwl_bridge_writel(pcie, 1 << bit, MSGF_MSI_STATUS_LO);
> +			virq = irq_find_mapping(msi->dev_domain, bit);
> +			if (virq)
> +				generic_handle_irq(virq);
> +			else
> +				dev_err(pcie->dev, "unexpected MSI\n");

And here.

> +		}
> +	}
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static int nwl_legacy_map(struct irq_domain *domain, unsigned int irq,
> +				irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
> +	irq_set_chip_data(irq, domain->host_data);
> +	set_irq_flags(irq, IRQF_VALID);

There is an ongoing effort to kill more usages of the ARM-specific
set_irq_flags().  I don't actually think you need this at all, as the
IRQ domain takes care of the relevant pieces for you.

> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops legacy_domain_ops = {
> +	.map = nwl_legacy_map,
> +};
> +
[..]
> +static int nwl_msi_set_affinity(struct irq_data *irq_data,
> +				const struct cpumask *mask, bool force)
> +{
> +	return -EINVAL;
> +}

This seems wrong.  Why even implement a irq_set_affinity() callback even
though you clearly cannot support it?

[..]
> +static void nwl_irq_domain_free(struct irq_domain *domain, unsigned int virq,
> +					unsigned int nr_irqs)
> +{
> +	struct irq_data *data = irq_domain_get_irq_data(domain, virq);
> +	struct nwl_pcie *pcie = irq_data_get_irq_chip_data(data);
> +	struct nwl_msi *msi = &pcie->msi;
> +
> +	if (!test_bit(data->hwirq, msi->used))
> +		dev_err(pcie->dev, "freeing unused MSI %lu\n", data->hwirq);
> +	else
> +		clear_bit(data->hwirq, msi->used);

Is this racy, as you're not under &msi->lock?
> +
> +}
> +
[..]
> +static void nwl_pcie_free_irq_domain(struct nwl_pcie *pcie)
> +{
> +	int i;
> +	u32 irq;
> +
[..]
> +#ifdef CONFIG_PCI_MSI
> +	irq_set_chained_handler(msi->irq_msi0, NULL);
> +	irq_set_handler_data(msi->irq_msi0, NULL);

irq_set_chained_handler_and_data()?

> +	irq_set_chained_handler(msi->irq_msi1, NULL);
> +	irq_set_handler_data(msi->irq_msi1, NULL);
> +
> +	irq_domain_remove(msi->msi_chip.domain);
> +	irq_domain_remove(msi->dev_domain);
> +#endif
> +
> +}
> +
> +static int nwl_pcie_init_irq_domain(struct nwl_pcie *pcie)
> +{
> +	struct device_node *node = pcie->dev->of_node;
> +	struct device_node *legacy_intc_node;
> +
> +#ifdef CONFIG_PCI_MSI
> +	struct nwl_msi *msi = &pcie->msi;
> +#endif
> +
> +	legacy_intc_node = of_get_next_child(node, NULL);
> +	if (!legacy_intc_node) {
> +		dev_err(pcie->dev, "No legacy intc node found\n");
> +		return PTR_ERR(legacy_intc_node);

PTR_ERR() looks wrong here.

> +	}
> +
> +	pcie->legacy_irq_domain = irq_domain_add_linear(legacy_intc_node, 4,
> +							&legacy_domain_ops,
> +							pcie);
> +
> +	if (!pcie->legacy_irq_domain) {
> +		dev_err(pcie->dev, "failed to create IRQ domain\n");
> +		return -ENOMEM;
> +	}
> +
> +#ifdef CONFIG_PCI_MSI
> +	msi->dev_domain = irq_domain_add_linear(NULL, INT_PCI_MSI_NR,
> +					&dev_msi_domain_ops, pcie);
> +	if (!msi->dev_domain) {
> +		dev_err(pcie->dev, "failed to create dev IRQ domain\n");
> +		return -ENOMEM;
> +	}
> +	msi->msi_chip.domain = pci_msi_create_irq_domain(node,
> +							&nwl_msi_domain_info,
> +							msi->dev_domain);
> +	if (!msi->msi_chip.domain) {
> +		dev_err(pcie->dev, "failed to create msi IRQ domain\n");
> +		irq_domain_remove(msi->dev_domain);
> +		return -ENOMEM;
> +	}
> +#endif
> +	return 0;
> +}
> +
[..]
> +static const struct of_device_id nwl_pcie_of_match[] = {
> +	{ .compatible = "xlnx,nwl-pcie-2.11", },
> +	{}
> +};

You may want a MODULE_DEVICE_TABLE(of, niwl_pcie_of_match) here, too.
(Although, I guess it doesn't matter as you are not building modularly).

  Josh
