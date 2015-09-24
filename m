Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33745 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751468AbbIXT6v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 24 Sep 2015 15:58:51 -0400
Date: Thu, 24 Sep 2015 14:58:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	michal.simek@xilinx.com, soren.brinkmann@xilinx.com, arnd@arndb.de,
	tinamdar@apm.com, treding@nvidia.com, rjui@broadcom.com,
	Minghuan.Lian@freescale.com, m-karicheri2@ti.com, hauke@hauke-m.de,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Bharat Kumar Gogada <bharatku@xilinx.com>,
	Ravi Kiran Gummaluri <rgummal@xilinx.com>
Subject: Re: [PATCH] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL PCIe
 Host Controller
Message-ID: <20150924195846.GC10481@localhost>
References: <1440675860-21491-1-git-send-email-bharatku@xilinx.com>
 <20150918203736.GK25767@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150918203736.GK25767@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bharat,

I'm resending this since you sent a ping three days after I responded,
so I don't know whether you got this the first time around.

DMARC got turned on for mail coming from @google.com, which apparently
caused some email providers to drop it.  I switched to sending from
helgaas@kernel.org to avoid that problem.

Bjorn

On Fri, Sep 18, 2015 at 03:37:36PM -0500, Bjorn Helgaas wrote:
> Hi Bharat,
> 
> On Thu, Aug 27, 2015 at 05:14:20PM +0530, Bharat Kumar Gogada wrote:
> > Adding PCIe Root Port driver for Xilinx PCIe NWL bridge IP.
> 
> > diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> > index 140d66f..0f3a789 100644
> > --- a/drivers/pci/host/Makefile
> > +++ b/drivers/pci/host/Makefile
> > @@ -10,6 +10,7 @@ obj-$(CONFIG_PCI_HOST_GENERIC) += pci-host-generic.o
> >  obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
> >  obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone-dw.o pci-keystone.o
> >  obj-$(CONFIG_PCIE_XILINX) += pcie-xilinx.o
> > +obj-$(CONFIG_PCI_XILINX_NWL) += pci-xilinx-nwl.o
> 
> The other Xilinx driver uses "CONFIG_PCIE_*" and "pcie-xilinx.o".  Please
> use "pcie" similarly for this driver.
> 
> > +/**
> > + * struct nwl_msi - MSI information
> > + *
> > + * @chip: MSI controller
> > + * @used: Declare Bitmap for MSI
> > + * @domain: IRQ domain pointer
> > + * @pages: MSI pages
> > + * @lock: mutex lock
> > + * @irq_msi0: msi0 interrupt number
> > + * @irq_msi1: msi1 interrupt number
> 
> Please put these short comments inside the struct definition, on the same
> line as the element they describe.  It's needlessly repetitive to do it
> separately.
> 
> > + */
> > +struct nwl_msi {
> > +	struct msi_controller chip;
> > +	DECLARE_BITMAP(used, INT_PCI_MSI_NR);
> > +	struct irq_domain *domain;
> > +	unsigned long pages;
> > +	struct mutex lock;
> > +	int irq_msi0;
> > +	int irq_msi1;
> > +};
> 
> > +static inline bool nwl_pcie_is_link_up(struct nwl_pcie *pcie, u32 check_bit)
> 
> Please name this "nwl_pcie_link_up" so it's consistent with most others
> (xilinx_pcie_link_is_up() is an exception).  I'm not sure the "check_bit"
> argument is really an improvement, since it makes the code a bit ugly and
> more different from other drivers than it would otherwise be.
> 
> > +{
> > +	unsigned int status = -EINVAL;
> > +
> > +	if (check_bit == PCIE_USER_LINKUP)
> > +		status = (readl(pcie->pcireg_base + PS_LINKUP_OFFSET) &
> > +			  PCIE_PHY_LINKUP_BIT) ? 1 : 0;
> > +	else if (check_bit == PHY_RDY_LINKUP)
> > +		status = (readl(pcie->pcireg_base + PS_LINKUP_OFFSET) &
> > +			  PHY_RDY_LINKUP_BIT) ? 1 : 0;
> > +	return status;
> > +}
> 
> > +static int nwl_setup_sspl(struct nwl_pcie *pcie)
> > +{
> > +	unsigned int status;
> > +	int check = 0;
> > +
> > +	do {
> > +		status = nwl_bridge_readl(pcie, TX_PCIE_MSG) & MSG_BUSY_BIT;
> > +		if (!status) {
> > +			/*
> > +			 * Generate the TLP message for a single EP
> > +			 * [TODO] Add a multi-endpoint code
> > +			 */
> > +			nwl_bridge_writel(pcie, 0x0,
> > +					  TX_PCIE_MSG + TX_PCIE_MSG_CNTL);
> > +			nwl_bridge_writel(pcie, 0x0,
> > +					  TX_PCIE_MSG + TX_PCIE_MSG_SPEC_LO);
> > +			nwl_bridge_writel(pcie, 0x0,
> > +					  TX_PCIE_MSG + TX_PCIE_MSG_SPEC_HI);
> > +			nwl_bridge_writel(pcie, 0x0,
> > +					  TX_PCIE_MSG + TX_PCIE_MSG_DATA);
> > +			/* Pattern to generate SSLP TLP */
> > +			nwl_bridge_writel(pcie, PATTRN_SSLP_TLP,
> > +					  TX_PCIE_MSG + TX_PCIE_MSG_CNTL);
> > +			nwl_bridge_writel(pcie, RANDOM_DIGIT,
> > +					  TX_PCIE_MSG + TX_PCIE_MSG_DATA);
> > +			nwl_bridge_writel(pcie, nwl_bridge_readl(pcie,
> > +					  TX_PCIE_MSG) | 0x1, TX_PCIE_MSG);
> > +			status = 0;
> > +			do {
> > +				status = nwl_bridge_readl(pcie, TX_PCIE_MSG) &
> > +							  MSG_DONE_BIT;
> > +				if (!status && (check < 1)) {
> > +					mdelay(1);
> > +					check++;
> > +				} else {
> > +					return false;
> > +				}
> > +
> > +			} while (!status);
> > +			status = nwl_bridge_readl(pcie, TX_PCIE_MSG)
> > +						  & MSG_DONE_STATUS_BIT;
> > +		}
> > +	} while (status);
> > +
> > +	return true;
> 
> This function is defined to return "int."  It should not return "true" or
> "false."
> 
> I'm really confused about what this function does.  I can see it does
> at least:
> 
>   - wait until MSG_BUSY_BIT is clear
>   - write a bunch of registers
>   - some magic handshake involving MSG_DONE_BIT and
>     MSG_DONE_STATUS_BIT (I really don't understand this)
>   - possibly repeat if MSG_DONE_STATUS_BIT is set?
> 
> Can you clean this up and straighten it out somehow?  My head hurts
> from trying to understand it.
> 
> > +static int nwl_nwl_writel_config(struct pci_bus *bus,
> > +				unsigned int devfn,
> > +				int where,
> > +				int size,
> > +				u32 val)
> > +{
> > +	void __iomem *addr;
> > +	int err = 0;
> > +	struct nwl_pcie *pcie = bus->sysdata;
> > +
> > +	if (!bus->number && devfn > 0)
> > +		return PCIBIOS_DEVICE_NOT_FOUND;
> > +
> > +	addr = nwl_pcie_get_config_base(bus, devfn, where);
> > +
> > +	switch (size) {
> > +	case 1:
> > +		writeb(val, addr);
> > +		break;
> > +	case 2:
> > +		writew(val, addr);
> > +		break;
> > +	default:
> > +		writel(val, addr);
> > +		break;
> > +	}
> > +	if (addr == (pcie->ecam_base + PCI_EXP_SLTCAP)) {
> 
> This only intercepts writes to bus 0.  I assume that's what you want, and
> that's fine, but using pcie->ecam_base here is totally non-obvious.  If you
> want to check for bus 0, use "bus->number == 0".
> 
> I think offset PCI_EXP_SLTCAP is wrong.  That's the offset of SLTCAP from
> the beginning of the PCIe capability, not the address in the device's
> config space.  You're intercepting writes 20 (0x14), which is BAR1.
> 
> > +		err = nwl_setup_sspl(pcie);
> > +		if (!err)
> > +			return PCIBIOS_SET_FAILED;
> 
> This doesn't make sense to me.  First, "err" doesn't need to be
> initialized above.  Second, this basically reads "if no error, return
> failure."
> 
> > +static void __nwl_pcie_msi_handler(struct nwl_pcie *pcie,
> > +					unsigned long reg, u32 val)
> > +{
> > +	struct nwl_msi *msi = &pcie->msi;
> > +	unsigned int offset, index;
> > +	int irq_msi;
> > +
> > +	offset = find_first_bit(&reg, 32);
> > +	index = offset;
> > +
> > +	/* Clear the interrupt */
> > +	nwl_bridge_writel(pcie, 1 << offset, val);
> > +
> > +	/* Handle the msi virtual interrupt */
> > +	irq_msi = irq_find_mapping(msi->domain, index);
> > +	if (irq_msi) {
> > +		if (test_bit(index, msi->used))
> > +			generic_handle_irq(irq_msi);
> > +		else
> > +			dev_info(pcie->dev, "unhandled MSI\n");
> > +	} else {
> > +		/* that's weird who triggered this? just clear it */
> > +		dev_info(pcie->dev, "unexpected MSI\n");
> 
> The comment says "just clear it," but there's nothing in this block
> that actually clears it.  Maybe you meant "we cleared it above; just
> note it"?
> 
> > +static int nwl_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
> > +			       struct msi_desc *desc)
> > +{
> > +	struct nwl_msi *msi = to_nwl_msi(chip);
> > +	struct msi_msg msg;
> > +	unsigned int irq;
> > +	int hwirq;
> > +
> > +	if (desc->msi_attrib.is_msix) {
> > +		/* currently we are not supporting MSIx */
> > +		return -ENOSPC;
> > +	}
> 
> Remove the braces here so it's the same style as below
> (single-statement blocks don't need braces).  You can move the comment
> above the "if" to make it more obvious that it's a single-statement
> block.
> 
> > +
> > +	hwirq = nwl_msi_alloc(msi);
> > +	if (hwirq < 0)
> > +		return hwirq;
> > +
> > +	irq = irq_create_mapping(msi->domain, hwirq);
> > +	if (!irq)
> > +		return -EINVAL;
> 
> > +static int nwl_pcie_enable_msi(struct nwl_pcie *pcie, struct pci_bus *bus)
> > +{
> > +	struct platform_device *pdev = to_platform_device(pcie->dev);
> > +	struct nwl_msi *msi = &pcie->msi;
> > +	unsigned long base;
> > +	int ret;
> > +
> > +	mutex_init(&msi->lock);
> > +
> > +	/* Assign msi chip hooks */
> > +	msi->chip.dev = pcie->dev;
> > +	msi->chip.setup_irq = nwl_msi_setup_irq;
> > +	msi->chip.teardown_irq = nwl_msi_teardown_irq;
> > +
> > +	bus->msi = &msi->chip;
> > +	/* Allocate linear irq domain */
> > +	msi->domain = irq_domain_add_linear(pcie->dev->of_node, INT_PCI_MSI_NR,
> > +					    &msi_domain_ops, &msi->chip);
> > +	if (!msi->domain) {
> > +		dev_err(&pdev->dev, "failed to create IRQ domain\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	/* Check for msii_present bit */
> > +	ret = nwl_bridge_readl(pcie, I_MSII_CAPABILITIES) & MSII_PRESENT;
> > +	if (!ret) {
> > +		dev_err(pcie->dev, "MSI not present\n");
> > +		ret = -EIO;
> > +		goto err;
> > +	}
> > +
> > +	/* Enable MSII */
> > +	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, I_MSII_CONTROL) |
> > +			  MSII_ENABLE, I_MSII_CONTROL);
> > +	if (!pcie->enable_msi_fifo)
> > +		/* Enable MSII status */
> > +		nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, I_MSII_CONTROL) |
> > +				  MSII_STATUS_ENABLE, I_MSII_CONTROL);
> > +
> > +	/* setup AFI/FPCI range */
> > +	msi->pages = __get_free_pages(GFP_KERNEL, 0);
> > +	base = virt_to_phys((void *)msi->pages);
> > +	/* Write base to MSII_BASE_LO */
> > +	nwl_bridge_writel(pcie, base, I_MSII_BASE_LO);
> > +
> > +	/* Write 0x0 to MSII_BASE_HI */
> 
> These comments ("Allocate linear irq domain," "write xx to yy," etc.)
> are really just repetitive and you might as well remove them because
> the code says the same thing.  Sometimes it's not obvious what the
> code is doing, and then a comment is worthwhile.
> 
> > +static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
> > +{
> > +	struct platform_device *pdev = to_platform_device(pcie->dev);
> > +	u32 breg_val, ecam_val, first_busno = 0;
> > +	int err;
> > +	int check_link_up = 0;
> > +
> > +	/* Check for BREG present bit */
> > +	breg_val = nwl_bridge_readl(pcie, E_BREG_CAPABILITIES) & BREG_PRESENT;
> > +	if (!breg_val) {
> > +		dev_err(pcie->dev, "BREG is not present\n");
> > +		return breg_val;
> > +	}
> > +	/* Write bridge_off to breg base */
> > +	nwl_bridge_writel(pcie, (u32)(pcie->phys_breg_base),
> > +			  E_BREG_BASE_LO);
> > +
> > +	/* Enable BREG */
> > +	nwl_bridge_writel(pcie, ~BREG_ENABLE_FORCE & BREG_ENABLE,
> > +			  E_BREG_CONTROL);
> > +
> > +	/* Disable DMA channel registers */
> > +	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, BRCFG_PCIE_RX0) |
> > +			  CFG_DMA_REG_BAR, BRCFG_PCIE_RX0);
> > +
> > +	/* Enable the bridge config interrupt */
> > +	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, BRCFG_INTERRUPT) |
> > +			  BRCFG_INTERRUPT_MASK, BRCFG_INTERRUPT);
> > +	/* Enable Ingress subtractive decode translation */
> > +	nwl_bridge_writel(pcie, SET_ISUB_CONTROL, I_ISUB_CONTROL);
> > +
> > +	/* Enable msg filtering details */
> > +	nwl_bridge_writel(pcie, CFG_ENABLE_MSG_FILTER_MASK,
> > +			  BRCFG_PCIE_RX_MSG_FILTER);
> > +	do {
> > +		err = nwl_pcie_is_link_up(pcie, PHY_RDY_LINKUP);
> > +		if (err != 1) {
> > +			check_link_up++;
> > +			if (check_link_up > LINKUP_ITER_CHECK)
> > +				return -ENODEV;
> > +		}
> > +	} while (!err);
> 
> Most drivers use usleep_range() or mdelay() in this kind of loop.  This one
> seems like it's hardly worth looping -- only 5 iterations with no delay at
> all?  Maybe you could even look at the similar loops in other drivers
> and copy the style of the loop.
> 
> > +static int nwl_pcie_probe(struct platform_device *pdev)
> > +{
> > +	struct device_node *node = pdev->dev.of_node;
> > +	struct nwl_pcie *pcie;
> > +	struct pci_bus *bus;
> > +	int err;
> > +
> > +	resource_size_t iobase = 0;
> > +	LIST_HEAD(res);
> > +
> > +	/* Allocate private nwl_pcie struct */
> 
> More comments that really aren't necessary.  "Allocate," "set ecam
> value," "parse device tree," these are all just what the function
> names already tell us.
> 
> > +	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
> > +	if (!pcie)
> > +		return -ENOMEM;
> > +
> > +	/* Set ecam value */
> > +	pcie->ecam_value = NWL_ECAM_VALUE_DEFAULT;
> > +
> > +	pcie->dev = &pdev->dev;
> > +
> > +	/* Parse the device tree */
> > +	err = nwl_pcie_parse_dt(pcie, pdev);
> > +	if (err) {
> > +		dev_err(pcie->dev, "Parsing DT failed\n");
> > +		return err;
> > +	}
> > +	/* Bridge initialization */
> > +	err = nwl_pcie_bridge_init(pcie);
> > +	if (err) {
> > +		dev_err(pcie->dev, "HW Initalization failed\n");
> > +		return err;
> > +	}
> > +
> > +	err = of_pci_get_host_bridge_resources(node, 0, 0xff, &res, &iobase);
> > +	if (err) {
> > +		pr_err("Getting bridge resources failed\n");
> > +		return err;
> > +	}
> > +	bus = pci_create_root_bus(&pdev->dev, 0,
> > +				  &nwl_pcie_ops, pcie, &res);
> > +	if (!bus)
> > +		return -ENOMEM;
> > +
> > +	/* Enable MSI */
> > +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> > +		err = nwl_pcie_enable_msi(pcie, bus);
> > +		if (err < 0) {
> > +			dev_err(&pdev->dev,
> > +				"failed to enable MSI support: %d\n",
> > +				err);
> > +			return err;
> > +		}
> > +	}
> > +	pci_scan_child_bus(bus);
> > +	pci_assign_unassigned_bus_resources(bus);
> > +	pci_bus_add_devices(bus);
> > +	platform_set_drvdata(pdev, pcie);
> > +
> > +	return 0;
> > +}
> 
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
