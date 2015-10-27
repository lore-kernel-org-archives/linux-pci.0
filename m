Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45280 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754412AbbJ0Xkj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 27 Oct 2015 19:40:39 -0400
Date: Tue, 27 Oct 2015 18:40:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	michals@xilinx.com, sorenb@xilinx.com, bhelgaas@google.com,
	arnd@arndb.de, tinamdar@apm.com, treding@nvidia.com,
	rjui@broadcom.com, Minghuan.Lian@freescale.com,
	m-karicheri2@ti.com, hauke@hauke-m.de, marc.zyngier@arm.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Bharat Kumar Gogada <bharatku@xilinx.com>,
	Ravi Kiran Gummaluri <rgummal@xilinx.com>
Subject: Re: [PATCH v5] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
Message-ID: <20151027234032.GA7238@localhost>
References: <1445871386-2377-1-git-send-email-bharatku@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445871386-2377-1-git-send-email-bharatku@xilinx.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bharat,

On Mon, Oct 26, 2015 at 08:26:26PM +0530, Bharat Kumar Gogada wrote:
> Adding PCIe Root Port driver for Xilinx PCIe NWL bridge IP.
> 
> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
> ---
> Corrected device tree node name.
> Made tuples for interrupts, interrupt-map, reg properties.
> Added mutex lock in nwl_irq_domain_free function.
> Removed unneccessary casts.
> ---
>  .../devicetree/bindings/pci/xilinx-nwl-pcie.txt    |   68 ++
>  drivers/pci/host/Kconfig                           |    9 +
>  drivers/pci/host/Makefile                          |    1 +
>  drivers/pci/host/pcie-xilinx-nwl.c                 | 1057 ++++++++++++++++++++

Please update MAINTAINERS, too.

> +struct nwl_msi {			/* struct nwl_msi - MSI information */
> +	struct msi_controller msi_chip;	/* msi_chip: MSI domain */
> +	DECLARE_BITMAP(used, INT_PCI_MSI_NR);	/* used: Declare Bitmap
> +						for MSI	*/
> +	struct irq_domain *dev_domain;	/* domain: IRQ domain pointer */
> +	unsigned long pages;		/* pages: MSI pages */
> +	struct mutex lock;		/* lock: mutex lock */
> +	int irq_msi0;			/* irq_msi0: msi0 interrupt number */
> +	int irq_msi1;			/* irq_msi1: msi1 interrupt number */

You don't need to repeat the struct or member name in the comment.

> + * struct nwl_pcie - PCIe port information
> + *
> + * @dev: Device pointer
> + * @breg_base: IO Mapped Bridge Register Base
> + * @pcireg_base: IO Mapped PCIe controller attributes
> + * @ecam_base: IO Mapped configuration space
> + * @phys_breg_base: Physical Bridge Register Base
> + * @phys_pcie_reg_base: Physical PCIe Controller Attributes
> + * @phys_ecam_base: Physical Configuration Base
> + * @breg_size: Bridge Register space
> + * @pcie_reg_size: PCIe controller attributes space
> + * @ecam_size: PCIe Configuration space
> + * @irq_intx: Legacy interrupt number
> + * @irq_misc: Misc interrupt number
> + * @ecam_value: ECAM value
> + * @last_busno: Last Bus number configured
> + * @link_up: Link status flag
> + * @bus: PCI bus
> + * @msi: MSI domain
> + * @legacy_irq_domain: IRQ domain pointer
> + */
> +struct nwl_pcie {
> +	struct device *dev;
> +	void __iomem *breg_base;
> +	void __iomem *pcireg_base;
> +	void __iomem *ecam_base;
> +	u32 phys_breg_base;
> +	u32 phys_pcie_reg_base;
> +	u32 phys_ecam_base;
> +	u32 breg_size;
> +	u32 pcie_reg_size;
> +	u32 ecam_size;
> +	int irq_intx;
> +	int irq_misc;
> +	u32 ecam_value;
> +	u8 last_busno;
> +	u8 link_up;
> +	struct pci_bus *bus;
> +	struct nwl_msi msi;
> +	struct irq_domain *legacy_irq_domain;

Please put the comments on the same line as the member declaration.
You might not even need some of the comments, e.g., "Device pointer"
merely restates what we already know from the code without adding
anything useful.

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

This still seems confusing to me.  What about if you made a helper
function or two?  Having the main body of a function indented two tabs
is a good hint that something should be factored out of it.

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
> +		}
> +	}
> +
> +	chained_irq_exit(chip, desc);
> +

Unnecessary newline.

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
> +		}
> +	}
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +
> +static void nwl_pcie_msi_handler_low(unsigned int irq, struct irq_desc *desc)
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
> +	while ((status = nwl_bridge_readl(pcie, MSGF_MSI_STATUS_LO)) != 0) {
> +		for_each_set_bit(bit, &status, 32) {
> +			nwl_bridge_writel(pcie, 1 << bit, MSGF_MSI_STATUS_LO);
> +			virq = irq_find_mapping(msi->dev_domain, bit);
> +			if (virq)
> +				generic_handle_irq(virq);
> +		}
> +	}
> +
> +	chained_irq_exit(chip, desc);
> +}

These are basically identical.  Can you factor them out somehow to
avoid repeating the code?

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
> +static int nwl_pcie_enable_msi(struct nwl_pcie *pcie, struct pci_bus *bus)
> +{

It looks strange to have all the "#ifdef CONFIG_PCI_MSI" above, and
here we have this long MSI-related function without any ifdefs around
it.  Seems like this should be ifdef'ed also?  What about
nwl_pcie_msi_handler_high(), nwl_pcie_msi_handler_low(),
nwl_compose_msi_msg(), nwl_msi_set_affinity(), etc.?

> +	struct platform_device *pdev = to_platform_device(pcie->dev);
> +	struct nwl_msi *msi = &pcie->msi;
> +	unsigned long base;
> +	int ret;
> +
> +	mutex_init(&msi->lock);
> +
> +	msi->msi_chip.dev = pcie->dev;
> +	bus->msi = &msi->msi_chip;
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
> +	nwl_bridge_writel(pcie, base, I_MSII_BASE_LO);
> +	nwl_bridge_writel(pcie, 0x0, I_MSII_BASE_HI);
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

> ...
> +	bus = pci_create_root_bus(&pdev->dev, 0,
> +				  &nwl_pcie_ops, pcie, &res);
> +	if (!bus)
> +		return -ENOMEM;
> +
> +	/* Enable MSI */
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		err = nwl_pcie_enable_msi(pcie, bus);
> +		if (err < 0) {
> +			dev_err(&pdev->dev,
> +				"failed to enable MSI support: %d\n", err);
> +			return err;
> +		}
> +	}
> +	pci_scan_child_bus(bus);
> +	pci_assign_unassigned_bus_resources(bus);

You should call pcie_bus_configure_settings() here.  The fact that the
PCI core doesn't do that for you automatically is a deficiency in the
core, but we have to do it by hand for now.

> +	pci_bus_add_devices(bus);
> +	platform_set_drvdata(pdev, pcie);
> +
> +	return 0;
> +}

> +MODULE_LICENSE("GPL");

"GPL" is perfectly fine if that's what you want.  Most people use
"GPL v2" to specify that particular version.  Using "GPL" means people
can use this code under GPL v1, v2, v3, or possibly other versions.
I'm not a lawyer and not offering advice; I'm just checking to make
sure this is correct.

Bjorn
