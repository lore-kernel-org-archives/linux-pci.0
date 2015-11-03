Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56706 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754274AbbKCQSs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 3 Nov 2015 11:18:48 -0500
Message-ID: <5638DE62.6050605@arm.com>
Date: Tue, 03 Nov 2015 16:18:42 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	michals@xilinx.com, sorenb@xilinx.com, bhelgaas@google.com,
	arnd@arndb.de, tinamdar@apm.com, treding@nvidia.com,
	rjui@broadcom.com, Minghuan.Lian@freescale.com,
	m-karicheri2@ti.com, hauke@hauke-m.de, dhdang@apm.com,
	sbranden@broadcom.com
CC: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Bharat Kumar Gogada <bharatku@xilinx.com>,
	Ravi Kiran Gummaluri <rgummal@xilinx.com>
Subject: Re: [PATCH v7] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
References: <1446564227-4704-1-git-send-email-bharatku@xilinx.com>
In-Reply-To: <1446564227-4704-1-git-send-email-bharatku@xilinx.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/11/15 15:23, Bharat Kumar Gogada wrote:
> Adding PCIe Root Port driver for Xilinx PCIe NWL bridge IP.
> 
> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
> ---
> Removed msi_controller and added irq_domian for MSI domain hierarchy.
> Modified code for filling MSI address in struct msg.
> Added check for hwirq before passing it to irq_domain_set_info.
> ---
>  .../devicetree/bindings/pci/xilinx-nwl-pcie.txt    |   68 ++
>  drivers/pci/host/Kconfig                           |   10 +
>  drivers/pci/host/Makefile                          |    1 +
>  drivers/pci/host/pcie-xilinx-nwl.c                 | 1053 ++++++++++++++++++++
>  4 files changed, 1132 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
>  create mode 100644 drivers/pci/host/pcie-xilinx-nwl.c

[...]

> +#ifdef CONFIG_PCI_MSI
> +static struct irq_chip nwl_msi_irq_chip = {
> +	.name = "nwl_pcie:msi",
> +	.irq_enable = unmask_msi_irq,
> +	.irq_disable = mask_msi_irq,
> +	.irq_mask = mask_msi_irq,
> +	.irq_unmask = unmask_msi_irq,
> +
> +};
> +
> +static struct msi_domain_info nwl_msi_domain_info = {
> +	.flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> +		  MSI_FLAG_MULTI_PCI_MSI),

If you're supporting multi-MSI, how do you ensure that all hwirqs are
contiguous as required by the spec? Clearly, your allocator doesn't
provide this guarantee.

Also, you still lack support for MSI-X (which would come for free...).

> +	.chip = &nwl_msi_irq_chip,
> +};
> +#endif
> +
> +static void nwl_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
> +{
> +	struct nwl_pcie *pcie = irq_data_get_irq_chip_data(data);
> +	struct nwl_msi *msi = &pcie->msi;
> +	phys_addr_t msi_addr = virt_to_phys((void *)msi->pages);
> +
> +	msg->address_lo = lower_32_bits(msi_addr);
> +	msg->address_hi = upper_32_bits(msi_addr);
> +	msg->data = data->hwirq;
> +}
> +
> +static int nwl_msi_set_affinity(struct irq_data *irq_data,
> +				const struct cpumask *mask, bool force)
> +{
> +	return -EINVAL;
> +}
> +
> +static struct irq_chip nwl_irq_chip = {
> +	.name = "Xilinx MSI",
> +	.irq_compose_msi_msg = nwl_compose_msi_msg,
> +	.irq_set_affinity = nwl_msi_set_affinity,
> +};
> +
> +static int nwl_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> +				unsigned int nr_irqs, void *args)
> +{
> +	struct nwl_pcie *pcie = domain->host_data;
> +	struct nwl_msi *msi = &pcie->msi;
> +	unsigned long bit;
> +
> +	mutex_lock(&msi->lock);
> +	bit = find_first_zero_bit(msi->used, INT_PCI_MSI_NR);
> +	if (bit < INT_PCI_MSI_NR)
> +		set_bit(bit, msi->used);
> +	else
> +		bit = -ENOSPC;
> +
> +	mutex_unlock(&msi->lock);
> +
> +	if (bit < 0)
> +		return bit;
> +
> +	irq_domain_set_info(domain, virq, bit, &nwl_irq_chip,
> +			domain->host_data, handle_simple_irq,
> +			NULL, NULL);
> +	return 0;
> +}
> +
> +static void nwl_irq_domain_free(struct irq_domain *domain, unsigned int virq,
> +					unsigned int nr_irqs)
> +{
> +	struct irq_data *data = irq_domain_get_irq_data(domain, virq);
> +	struct nwl_pcie *pcie = irq_data_get_irq_chip_data(data);
> +	struct nwl_msi *msi = &pcie->msi;
> +
> +	mutex_lock(&msi->lock);
> +	if (!test_bit(data->hwirq, msi->used))
> +		dev_err(pcie->dev, "freeing unused MSI %lu\n", data->hwirq);
> +	else
> +		clear_bit(data->hwirq, msi->used);
> +
> +	mutex_unlock(&msi->lock);
> +}
> +
> +static const struct irq_domain_ops dev_msi_domain_ops = {
> +	.alloc  = nwl_irq_domain_alloc,
> +	.free   = nwl_irq_domain_free,
> +};
> +
> +static void nwl_pcie_free_irq_domain(struct nwl_pcie *pcie)
> +{
> +	int i;
> +	u32 irq;
> +
> +#ifdef CONFIG_PCI_MSI
> +	struct nwl_msi *msi = &pcie->msi;
> +#endif
> +
> +	for (i = 0; i < 4; i++) {
> +		irq = irq_find_mapping(pcie->legacy_irq_domain, i + 1);
> +		if (irq > 0)
> +			irq_dispose_mapping(irq);
> +	}
> +
> +	irq_domain_remove(pcie->legacy_irq_domain);
> +
> +#ifdef CONFIG_PCI_MSI
> +	irq_set_chained_handler_and_data(msi->irq_msi0, NULL, NULL);
> +	irq_set_chained_handler_and_data(msi->irq_msi1, NULL, NULL);
> +
> +	irq_domain_remove(msi->msi_domain);
> +	irq_domain_remove(msi->dev_domain);
> +#endif
> +
> +}

Remove these #ifdefs. You can test the validity of these fields before
calling the various functions. You can also move this to a separate
function.

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
> +	msi->msi_domain = pci_msi_create_irq_domain(node,
> +							&nwl_msi_domain_info,
> +							msi->dev_domain);
> +	if (!msi->msi_domain) {
> +		dev_err(pcie->dev, "failed to create msi IRQ domain\n");
> +		irq_domain_remove(msi->dev_domain);
> +		return -ENOMEM;
> +	}
> +#endif

Similar treatment here: move anything that's MSI-dependent to another
function, and provide a dummy implementation for the !PCI_MSI case.

> +	return 0;
> +}
> +
> +static int nwl_pcie_enable_msi(struct nwl_pcie *pcie, struct pci_bus *bus)
> +{
> +	struct platform_device *pdev = to_platform_device(pcie->dev);
> +	struct nwl_msi *msi = &pcie->msi;
> +	unsigned long base;
> +	int ret;
> +
> +	mutex_init(&msi->lock);
> +
> +	/* Check for msii_present bit */
> +	ret = nwl_bridge_readl(pcie, I_MSII_CAPABILITIES) & MSII_PRESENT;
> +	if (!ret) {
> +		dev_err(pcie->dev, "MSI not present\n");
> +		ret = -EIO;
> +		goto err;
> +	}
> +
> +	/* Enable MSII */
> +	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, I_MSII_CONTROL) |
> +			  MSII_ENABLE, I_MSII_CONTROL);
> +
> +	/* Enable MSII status */
> +	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, I_MSII_CONTROL) |
> +			  MSII_STATUS_ENABLE, I_MSII_CONTROL);
> +
> +	/* setup AFI/FPCI range */
> +	msi->pages = __get_free_pages(GFP_KERNEL, 0);
> +	base = virt_to_phys((void *)msi->pages);
> +	nwl_bridge_writel(pcie, lower_32_bits(base), I_MSII_BASE_LO);
> +	nwl_bridge_writel(pcie, upper_32_bits(base), I_MSII_BASE_HI);

I just read this, and I'm puzzled. Actually, puzzled is an
understatement. Why on Earth do you need to give RAM to your MSI HW?
This should be a device, not RAM. By the look of it, this could be
absolutely anything. Are you sure you have to supply RAM here?

> +
> +	/* Disable high range msi interrupts */
> +	nwl_bridge_writel(pcie, (u32)~MSGF_MSI_SR_HI_MASK, MSGF_MSI_MASK_HI);
> +
> +	/* Clear pending high range msi interrupts */
> +	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie,  MSGF_MSI_STATUS_HI) &
> +			  MSGF_MSI_SR_HI_MASK, MSGF_MSI_STATUS_HI);
> +	/* Get msi_1 IRQ number */
> +	msi->irq_msi1 = platform_get_irq_byname(pdev, "msi1");
> +	if (msi->irq_msi1 < 0) {
> +		dev_err(&pdev->dev, "failed to get IRQ#%d\n", msi->irq_msi1);
> +		goto err;
> +	}
> +	/* Register msi handler */
> +	irq_set_chained_handler_and_data(msi->irq_msi1,
> +					 nwl_pcie_msi_handler_high, pcie);
> +
> +	/* Enable all high range msi interrupts */
> +	nwl_bridge_writel(pcie, MSGF_MSI_SR_HI_MASK, MSGF_MSI_MASK_HI);
> +
> +	/* Disable low range msi interrupts */
> +	nwl_bridge_writel(pcie, (u32)~MSGF_MSI_SR_LO_MASK, MSGF_MSI_MASK_LO);
> +
> +	/* Clear pending low range msi interrupts */
> +	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, MSGF_MSI_STATUS_LO) &
> +			  MSGF_MSI_SR_LO_MASK, MSGF_MSI_STATUS_LO);
> +	/* Get msi_0 IRQ number */
> +	msi->irq_msi0 = platform_get_irq_byname(pdev, "msi0");
> +	if (msi->irq_msi0 < 0) {
> +		dev_err(&pdev->dev, "failed to get IRQ#%d\n", msi->irq_msi0);
> +		goto err;
> +	}
> +
> +	/* Register msi handler */
> +	irq_set_chained_handler_and_data(msi->irq_msi0,
> +					 nwl_pcie_msi_handler_low, pcie);
> +
> +	/* Enable all low range msi interrupts */
> +	nwl_bridge_writel(pcie, MSGF_MSI_SR_LO_MASK, MSGF_MSI_MASK_LO);
> +
> +	return 0;
> +err:
> +	return ret;
> +}
> +
> +static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
> +{
> +	struct platform_device *pdev = to_platform_device(pcie->dev);
> +	u32 breg_val, ecam_val, first_busno = 0;
> +	int err;
> +	int check_link_up = 0;
> +
> +	/* Check for BREG present bit */
> +	breg_val = nwl_bridge_readl(pcie, E_BREG_CAPABILITIES) & BREG_PRESENT;
> +	if (!breg_val) {
> +		dev_err(pcie->dev, "BREG is not present\n");
> +		return breg_val;
> +	}
> +	/* Write bridge_off to breg base */
> +	nwl_bridge_writel(pcie, (u32)(pcie->phys_breg_base),
> +			  E_BREG_BASE_LO);
> +
> +	/* Enable BREG */
> +	nwl_bridge_writel(pcie, ~BREG_ENABLE_FORCE & BREG_ENABLE,
> +			  E_BREG_CONTROL);
> +
> +	/* Disable DMA channel registers */
> +	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, BRCFG_PCIE_RX0) |
> +			  CFG_DMA_REG_BAR, BRCFG_PCIE_RX0);
> +
> +	/* Enable the bridge config interrupt */
> +	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, BRCFG_INTERRUPT) |
> +			  BRCFG_INTERRUPT_MASK, BRCFG_INTERRUPT);
> +	/* Enable Ingress subtractive decode translation */
> +	nwl_bridge_writel(pcie, SET_ISUB_CONTROL, I_ISUB_CONTROL);
> +
> +	/* Enable msg filtering details */
> +	nwl_bridge_writel(pcie, CFG_ENABLE_MSG_FILTER_MASK,
> +			  BRCFG_PCIE_RX_MSG_FILTER);
> +	do {
> +		err = nwl_pcie_link_up(pcie, PHY_RDY_LINKUP);
> +		if (err != 1) {
> +			check_link_up++;
> +			if (check_link_up > LINKUP_ITER_CHECK)
> +				return -ENODEV;
> +			mdelay(1000);
> +		}
> +	} while (!err);
> +
> +	/* Check for ECAM present bit */
> +	ecam_val = nwl_bridge_readl(pcie, E_ECAM_CAPABILITIES) & E_ECAM_PRESENT;
> +	if (!ecam_val) {
> +		dev_err(pcie->dev, "ECAM is not present\n");
> +		return ecam_val;
> +	}
> +
> +	/* Enable ECAM */
> +	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, E_ECAM_CONTROL) |
> +			  E_ECAM_CR_ENABLE, E_ECAM_CONTROL);
> +	/* Write ecam_value on ecam_control */
> +	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, E_ECAM_CONTROL) |
> +			  (pcie->ecam_value << E_ECAM_SIZE_SHIFT),
> +			  E_ECAM_CONTROL);
> +	/* Write phy_reg_base to ecam base */
> +	nwl_bridge_writel(pcie, (u32)pcie->phys_ecam_base, E_ECAM_BASE_LO);
> +
> +	/* Get bus range */
> +	ecam_val = nwl_bridge_readl(pcie, E_ECAM_CONTROL);
> +	pcie->last_busno = (ecam_val & E_ECAM_SIZE_LOC) >> E_ECAM_SIZE_SHIFT;
> +	/* Write primary, secondary and subordinate bus numbers */
> +	ecam_val = first_busno;
> +	ecam_val |= (first_busno + 1) << 8;
> +	ecam_val |= (pcie->last_busno << E_ECAM_SIZE_SHIFT);
> +	writel(ecam_val, (pcie->ecam_base + PCI_PRIMARY_BUS));
> +
> +	/* Check if PCIe link is up? */
> +	pcie->link_up = nwl_pcie_link_up(pcie, PCIE_USER_LINKUP);
> +	if (!pcie->link_up)
> +		dev_info(pcie->dev, "Link is DOWN\n");
> +	else
> +		dev_info(pcie->dev, "Link is UP\n");
> +
> +	/* Disable all misc interrupts */
> +	nwl_bridge_writel(pcie, (u32)~MSGF_MISC_SR_MASKALL, MSGF_MISC_MASK);
> +
> +	/* Clear pending misc interrupts */
> +	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, MSGF_MISC_STATUS) &
> +			  MSGF_MISC_SR_MASKALL, MSGF_MISC_STATUS);
> +
> +	/* Get misc IRQ number */
> +	pcie->irq_misc = platform_get_irq_byname(pdev, "misc");
> +	if (pcie->irq_misc < 0) {
> +		dev_err(&pdev->dev, "failed to get misc IRQ#%d\n",

That's going to be a pretty funky interrupt number.

> +			pcie->irq_misc);
> +		return pcie->irq_misc;

Don't you need to turn the thing down when you abort the probing?

> +	}
> +	/* Register misc handler */
> +	err = devm_request_irq(pcie->dev, pcie->irq_misc,
> +			       nwl_pcie_misc_handler, IRQF_SHARED,
> +			       "nwl_pcie:misc", pcie);
> +	if (err) {
> +		dev_err(pcie->dev, "fail to register misc IRQ#%d\n",
> +			pcie->irq_misc);
> +		return err;
> +	}
> +	/* Enable all misc interrupts */
> +	nwl_bridge_writel(pcie, MSGF_MISC_SR_MASKALL, MSGF_MISC_MASK);
> +
> +	/* Disable all legacy interrupts */
> +	nwl_bridge_writel(pcie, (u32)~MSGF_LEG_SR_MASKALL, MSGF_LEG_MASK);
> +
> +	/* Clear pending legacy interrupts */
> +	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, MSGF_LEG_STATUS) &
> +			  MSGF_LEG_SR_MASKALL, MSGF_LEG_STATUS);
> +	/* Get intx IRQ number */
> +	pcie->irq_intx = platform_get_irq_byname(pdev, "intx");
> +	if (pcie->irq_intx < 0) {
> +		dev_err(&pdev->dev, "failed to get intx IRQ#%d\n",

Same here.

> +			pcie->irq_intx);
> +		return pcie->irq_intx;
> +	}
> +
> +	/* Enable all legacy interrupts */
> +	nwl_bridge_writel(pcie, MSGF_LEG_SR_MASKALL, MSGF_LEG_MASK);
> +
> +	return 0;
> +}

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
