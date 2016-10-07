Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46267 "EHLO comal.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935076AbcJGQxm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:53:42 -0400
Subject: Re: [PATCH 1/6] PCI: keystone: Name private struct pointer "keystone"
 consistently
To: Bjorn Helgaas <bhelgaas@google.com>
References: <20161007164026.26090.42844.stgit@bhelgaas-glaptop2.roam.corp.google.com>
CC: <linux-pci@vger.kernel.org>
From: Murali Karicheri <m-karicheri2@ti.com>
Message-ID: <57F7D319.2070909@ti.com>
Date: Fri, 7 Oct 2016 12:53:45 -0400
MIME-Version: 1.0
In-Reply-To: <20161007164026.26090.42844.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/07/2016 12:40 PM, Bjorn Helgaas wrote:
> Use a device-specific name, "keystone", for struct keystone_pcie pointers
referring to keystone pcie as keystone is not right. keystone_pcie make sense.
To use a short name ks_pcie was used. So what is wrong with the naming?
I believe this patch is unnecessary.

Murali
> to hint that this is device-specific information.  No functional change
> intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/host/pci-keystone-dw.c |  122 ++++++++++++++++++-----------------
>  drivers/pci/host/pci-keystone.c    |  125 ++++++++++++++++++------------------
>  drivers/pci/host/pci-keystone.h    |   12 ++-
>  3 files changed, 129 insertions(+), 130 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-keystone-dw.c
> index 4151509..d09e3c6 100644
> --- a/drivers/pci/host/pci-keystone-dw.c
> +++ b/drivers/pci/host/pci-keystone-dw.c
> @@ -83,18 +83,18 @@ static inline void update_reg_offset_bit_pos(u32 offset, u32 *reg_offset,
>  
>  phys_addr_t ks_dw_pcie_get_msi_addr(struct pcie_port *pp)
>  {
> -	struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
> +	struct keystone_pcie *keystone = to_keystone_pcie(pp);
>  
> -	return ks_pcie->app.start + MSI_IRQ;
> +	return keystone->app.start + MSI_IRQ;
>  }
>  
> -void ks_dw_pcie_handle_msi_irq(struct keystone_pcie *ks_pcie, int offset)
> +void ks_dw_pcie_handle_msi_irq(struct keystone_pcie *keystone, int offset)
>  {
> -	struct pcie_port *pp = &ks_pcie->pp;
> +	struct pcie_port *pp = &keystone->pp;
>  	u32 pending, vector;
>  	int src, virq;
>  
> -	pending = readl(ks_pcie->va_app_base + MSI0_IRQ_STATUS + (offset << 4));
> +	pending = readl(keystone->va_app_base + MSI0_IRQ_STATUS + (offset << 4));
>  
>  	/*
>  	 * MSI0 status bit 0-3 shows vectors 0, 8, 16, 24, MSI1 status bit
> @@ -114,51 +114,51 @@ void ks_dw_pcie_handle_msi_irq(struct keystone_pcie *ks_pcie, int offset)
>  static void ks_dw_pcie_msi_irq_ack(struct irq_data *d)
>  {
>  	u32 offset, reg_offset, bit_pos;
> -	struct keystone_pcie *ks_pcie;
> +	struct keystone_pcie *keystone;
>  	struct msi_desc *msi;
>  	struct pcie_port *pp;
>  
>  	msi = irq_data_get_msi_desc(d);
>  	pp = (struct pcie_port *) msi_desc_to_pci_sysdata(msi);
> -	ks_pcie = to_keystone_pcie(pp);
> +	keystone = to_keystone_pcie(pp);
>  	offset = d->irq - irq_linear_revmap(pp->irq_domain, 0);
>  	update_reg_offset_bit_pos(offset, &reg_offset, &bit_pos);
>  
>  	writel(BIT(bit_pos),
> -	       ks_pcie->va_app_base + MSI0_IRQ_STATUS + (reg_offset << 4));
> -	writel(reg_offset + MSI_IRQ_OFFSET, ks_pcie->va_app_base + IRQ_EOI);
> +	       keystone->va_app_base + MSI0_IRQ_STATUS + (reg_offset << 4));
> +	writel(reg_offset + MSI_IRQ_OFFSET, keystone->va_app_base + IRQ_EOI);
>  }
>  
>  void ks_dw_pcie_msi_set_irq(struct pcie_port *pp, int irq)
>  {
>  	u32 reg_offset, bit_pos;
> -	struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
> +	struct keystone_pcie *keystone = to_keystone_pcie(pp);
>  
>  	update_reg_offset_bit_pos(irq, &reg_offset, &bit_pos);
>  	writel(BIT(bit_pos),
> -	       ks_pcie->va_app_base + MSI0_IRQ_ENABLE_SET + (reg_offset << 4));
> +	       keystone->va_app_base + MSI0_IRQ_ENABLE_SET + (reg_offset << 4));
>  }
>  
>  void ks_dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
>  {
>  	u32 reg_offset, bit_pos;
> -	struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
> +	struct keystone_pcie *keystone = to_keystone_pcie(pp);
>  
>  	update_reg_offset_bit_pos(irq, &reg_offset, &bit_pos);
>  	writel(BIT(bit_pos),
> -	       ks_pcie->va_app_base + MSI0_IRQ_ENABLE_CLR + (reg_offset << 4));
> +	       keystone->va_app_base + MSI0_IRQ_ENABLE_CLR + (reg_offset << 4));
>  }
>  
>  static void ks_dw_pcie_msi_irq_mask(struct irq_data *d)
>  {
> -	struct keystone_pcie *ks_pcie;
> +	struct keystone_pcie *keystone;
>  	struct msi_desc *msi;
>  	struct pcie_port *pp;
>  	u32 offset;
>  
>  	msi = irq_data_get_msi_desc(d);
>  	pp = (struct pcie_port *) msi_desc_to_pci_sysdata(msi);
> -	ks_pcie = to_keystone_pcie(pp);
> +	keystone = to_keystone_pcie(pp);
>  	offset = d->irq - irq_linear_revmap(pp->irq_domain, 0);
>  
>  	/* Mask the end point if PVM implemented */
> @@ -172,14 +172,14 @@ static void ks_dw_pcie_msi_irq_mask(struct irq_data *d)
>  
>  static void ks_dw_pcie_msi_irq_unmask(struct irq_data *d)
>  {
> -	struct keystone_pcie *ks_pcie;
> +	struct keystone_pcie *keystone;
>  	struct msi_desc *msi;
>  	struct pcie_port *pp;
>  	u32 offset;
>  
>  	msi = irq_data_get_msi_desc(d);
>  	pp = (struct pcie_port *) msi_desc_to_pci_sysdata(msi);
> -	ks_pcie = to_keystone_pcie(pp);
> +	keystone = to_keystone_pcie(pp);
>  	offset = d->irq - irq_linear_revmap(pp->irq_domain, 0);
>  
>  	/* Mask the end point if PVM implemented */
> @@ -214,10 +214,10 @@ static const struct irq_domain_ops ks_dw_pcie_msi_domain_ops = {
>  
>  int ks_dw_pcie_msi_host_init(struct pcie_port *pp, struct msi_controller *chip)
>  {
> -	struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
> +	struct keystone_pcie *keystone = to_keystone_pcie(pp);
>  	int i;
>  
> -	pp->irq_domain = irq_domain_add_linear(ks_pcie->msi_intc_np,
> +	pp->irq_domain = irq_domain_add_linear(keystone->msi_intc_np,
>  					MAX_MSI_IRQS,
>  					&ks_dw_pcie_msi_domain_ops,
>  					chip);
> @@ -232,31 +232,31 @@ int ks_dw_pcie_msi_host_init(struct pcie_port *pp, struct msi_controller *chip)
>  	return 0;
>  }
>  
> -void ks_dw_pcie_enable_legacy_irqs(struct keystone_pcie *ks_pcie)
> +void ks_dw_pcie_enable_legacy_irqs(struct keystone_pcie *keystone)
>  {
>  	int i;
>  
>  	for (i = 0; i < MAX_LEGACY_IRQS; i++)
> -		writel(0x1, ks_pcie->va_app_base + IRQ_ENABLE_SET + (i << 4));
> +		writel(0x1, keystone->va_app_base + IRQ_ENABLE_SET + (i << 4));
>  }
>  
> -void ks_dw_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie, int offset)
> +void ks_dw_pcie_handle_legacy_irq(struct keystone_pcie *keystone, int offset)
>  {
> -	struct pcie_port *pp = &ks_pcie->pp;
> +	struct pcie_port *pp = &keystone->pp;
>  	u32 pending;
>  	int virq;
>  
> -	pending = readl(ks_pcie->va_app_base + IRQ_STATUS + (offset << 4));
> +	pending = readl(keystone->va_app_base + IRQ_STATUS + (offset << 4));
>  
>  	if (BIT(0) & pending) {
> -		virq = irq_linear_revmap(ks_pcie->legacy_irq_domain, offset);
> +		virq = irq_linear_revmap(keystone->legacy_irq_domain, offset);
>  		dev_dbg(pp->dev, ": irq: irq_offset %d, virq %d\n", offset,
>  			virq);
>  		generic_handle_irq(virq);
>  	}
>  
>  	/* EOI the INTx interrupt */
> -	writel(offset, ks_pcie->va_app_base + IRQ_EOI);
> +	writel(offset, keystone->va_app_base + IRQ_EOI);
>  }
>  
>  void ks_dw_pcie_enable_error_irq(void __iomem *reg_base)
> @@ -352,39 +352,39 @@ static void ks_dw_pcie_clear_dbi_mode(void __iomem *reg_virt)
>  	} while (val & DBI_CS2_EN_VAL);
>  }
>  
> -void ks_dw_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
> +void ks_dw_pcie_setup_rc_app_regs(struct keystone_pcie *keystone)
>  {
> -	struct pcie_port *pp = &ks_pcie->pp;
> +	struct pcie_port *pp = &keystone->pp;
>  	u32 start = pp->mem->start, end = pp->mem->end;
>  	int i, tr_size;
>  
>  	/* Disable BARs for inbound access */
> -	ks_dw_pcie_set_dbi_mode(ks_pcie->va_app_base);
> +	ks_dw_pcie_set_dbi_mode(keystone->va_app_base);
>  	writel(0, pp->dbi_base + PCI_BASE_ADDRESS_0);
>  	writel(0, pp->dbi_base + PCI_BASE_ADDRESS_1);
> -	ks_dw_pcie_clear_dbi_mode(ks_pcie->va_app_base);
> +	ks_dw_pcie_clear_dbi_mode(keystone->va_app_base);
>  
>  	/* Set outbound translation size per window division */
> -	writel(CFG_PCIM_WIN_SZ_IDX & 0x7, ks_pcie->va_app_base + OB_SIZE);
> +	writel(CFG_PCIM_WIN_SZ_IDX & 0x7, keystone->va_app_base + OB_SIZE);
>  
>  	tr_size = (1 << (CFG_PCIM_WIN_SZ_IDX & 0x7)) * SZ_1M;
>  
>  	/* Using Direct 1:1 mapping of RC <-> PCI memory space */
>  	for (i = 0; (i < CFG_PCIM_WIN_CNT) && (start < end); i++) {
> -		writel(start | 1, ks_pcie->va_app_base + OB_OFFSET_INDEX(i));
> -		writel(0, ks_pcie->va_app_base + OB_OFFSET_HI(i));
> +		writel(start | 1, keystone->va_app_base + OB_OFFSET_INDEX(i));
> +		writel(0, keystone->va_app_base + OB_OFFSET_HI(i));
>  		start += tr_size;
>  	}
>  
>  	/* Enable OB translation */
> -	writel(OB_XLAT_EN_VAL | readl(ks_pcie->va_app_base + CMD_STATUS),
> -	       ks_pcie->va_app_base + CMD_STATUS);
> +	writel(OB_XLAT_EN_VAL | readl(keystone->va_app_base + CMD_STATUS),
> +	       keystone->va_app_base + CMD_STATUS);
>  }
>  
>  /**
>   * ks_pcie_cfg_setup() - Set up configuration space address for a device
>   *
> - * @ks_pcie: ptr to keystone_pcie structure
> + * @keystone: ptr to keystone_pcie structure
>   * @bus: Bus number the device is residing on
>   * @devfn: device, function number info
>   *
> @@ -398,11 +398,11 @@ void ks_dw_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
>   * we will do TYPE 0 access as it will be on our secondary bus (logical).
>   * CFG_SETUP is needed only for remote configuration access.
>   */
> -static void __iomem *ks_pcie_cfg_setup(struct keystone_pcie *ks_pcie, u8 bus,
> +static void __iomem *ks_pcie_cfg_setup(struct keystone_pcie *keystone, u8 bus,
>  				       unsigned int devfn)
>  {
>  	u8 device = PCI_SLOT(devfn), function = PCI_FUNC(devfn);
> -	struct pcie_port *pp = &ks_pcie->pp;
> +	struct pcie_port *pp = &keystone->pp;
>  	u32 regval;
>  
>  	if (bus == 0)
> @@ -418,18 +418,18 @@ static void __iomem *ks_pcie_cfg_setup(struct keystone_pcie *ks_pcie, u8 bus,
>  	if (bus != 1)
>  		regval |= BIT(24);
>  
> -	writel(regval, ks_pcie->va_app_base + CFG_SETUP);
> +	writel(regval, keystone->va_app_base + CFG_SETUP);
>  	return pp->va_cfg0_base;
>  }
>  
>  int ks_dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>  			     unsigned int devfn, int where, int size, u32 *val)
>  {
> -	struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
> +	struct keystone_pcie *keystone = to_keystone_pcie(pp);
>  	u8 bus_num = bus->number;
>  	void __iomem *addr;
>  
> -	addr = ks_pcie_cfg_setup(ks_pcie, bus_num, devfn);
> +	addr = ks_pcie_cfg_setup(keystone, bus_num, devfn);
>  
>  	return dw_pcie_cfg_read(addr + where, size, val);
>  }
> @@ -437,11 +437,11 @@ int ks_dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>  int ks_dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>  			     unsigned int devfn, int where, int size, u32 val)
>  {
> -	struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
> +	struct keystone_pcie *keystone = to_keystone_pcie(pp);
>  	u8 bus_num = bus->number;
>  	void __iomem *addr;
>  
> -	addr = ks_pcie_cfg_setup(ks_pcie, bus_num, devfn);
> +	addr = ks_pcie_cfg_setup(keystone, bus_num, devfn);
>  
>  	return dw_pcie_cfg_write(addr + where, size, val);
>  }
> @@ -453,22 +453,22 @@ int ks_dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>   */
>  void ks_dw_pcie_v3_65_scan_bus(struct pcie_port *pp)
>  {
> -	struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
> +	struct keystone_pcie *keystone = to_keystone_pcie(pp);
>  
>  	/* Configure and set up BAR0 */
> -	ks_dw_pcie_set_dbi_mode(ks_pcie->va_app_base);
> +	ks_dw_pcie_set_dbi_mode(keystone->va_app_base);
>  
>  	/* Enable BAR0 */
>  	writel(1, pp->dbi_base + PCI_BASE_ADDRESS_0);
>  	writel(SZ_4K - 1, pp->dbi_base + PCI_BASE_ADDRESS_0);
>  
> -	ks_dw_pcie_clear_dbi_mode(ks_pcie->va_app_base);
> +	ks_dw_pcie_clear_dbi_mode(keystone->va_app_base);
>  
>  	 /*
>  	  * For BAR0, just setting bus address for inbound writes (MSI) should
>  	  * be sufficient.  Use physical address to avoid any conflicts.
>  	  */
> -	writel(ks_pcie->app.start, pp->dbi_base + PCI_BASE_ADDRESS_0);
> +	writel(keystone->app.start, pp->dbi_base + PCI_BASE_ADDRESS_0);
>  }
>  
>  /**
> @@ -481,18 +481,18 @@ int ks_dw_pcie_link_up(struct pcie_port *pp)
>  	return (val & LTSSM_STATE_MASK) == LTSSM_STATE_L0;
>  }
>  
> -void ks_dw_pcie_initiate_link_train(struct keystone_pcie *ks_pcie)
> +void ks_dw_pcie_initiate_link_train(struct keystone_pcie *keystone)
>  {
>  	u32 val;
>  
>  	/* Disable Link training */
> -	val = readl(ks_pcie->va_app_base + CMD_STATUS);
> +	val = readl(keystone->va_app_base + CMD_STATUS);
>  	val &= ~LTSSM_EN_VAL;
> -	writel(LTSSM_EN_VAL | val,  ks_pcie->va_app_base + CMD_STATUS);
> +	writel(LTSSM_EN_VAL | val,  keystone->va_app_base + CMD_STATUS);
>  
>  	/* Initiate Link Training */
> -	val = readl(ks_pcie->va_app_base + CMD_STATUS);
> -	writel(LTSSM_EN_VAL | val,  ks_pcie->va_app_base + CMD_STATUS);
> +	val = readl(keystone->va_app_base + CMD_STATUS);
> +	writel(LTSSM_EN_VAL | val,  keystone->va_app_base + CMD_STATUS);
>  }
>  
>  /**
> @@ -502,10 +502,10 @@ void ks_dw_pcie_initiate_link_train(struct keystone_pcie *ks_pcie)
>   * and call dw_pcie_v3_65_host_init() API to initialize the Keystone
>   * PCI host controller.
>   */
> -int __init ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie,
> +int __init ks_dw_pcie_host_init(struct keystone_pcie *keystone,
>  				struct device_node *msi_intc_np)
>  {
> -	struct pcie_port *pp = &ks_pcie->pp;
> +	struct pcie_port *pp = &keystone->pp;
>  	struct platform_device *pdev = to_platform_device(pp->dev);
>  	struct resource *res;
>  
> @@ -524,19 +524,19 @@ int __init ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie,
>  
>  	/* Index 1 is the application reg. space address */
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	ks_pcie->va_app_base = devm_ioremap_resource(pp->dev, res);
> -	if (IS_ERR(ks_pcie->va_app_base))
> -		return PTR_ERR(ks_pcie->va_app_base);
> +	keystone->va_app_base = devm_ioremap_resource(pp->dev, res);
> +	if (IS_ERR(keystone->va_app_base))
> +		return PTR_ERR(keystone->va_app_base);
>  
> -	ks_pcie->app = *res;
> +	keystone->app = *res;
>  
>  	/* Create legacy IRQ domain */
> -	ks_pcie->legacy_irq_domain =
> -			irq_domain_add_linear(ks_pcie->legacy_intc_np,
> +	keystone->legacy_irq_domain =
> +			irq_domain_add_linear(keystone->legacy_intc_np,
>  					MAX_LEGACY_IRQS,
>  					&ks_dw_pcie_legacy_irq_domain_ops,
>  					NULL);
> -	if (!ks_pcie->legacy_irq_domain) {
> +	if (!keystone->legacy_irq_domain) {
>  		dev_err(pp->dev, "Failed to add irq domain for legacy irqs\n");
>  		return -EINVAL;
>  	}
> diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-keystone.c
> index 82b461b..55b2be7 100644
> --- a/drivers/pci/host/pci-keystone.c
> +++ b/drivers/pci/host/pci-keystone.c
> @@ -86,9 +86,9 @@ static void quirk_limit_mrrs(struct pci_dev *dev)
>  }
>  DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, quirk_limit_mrrs);
>  
> -static int ks_pcie_establish_link(struct keystone_pcie *ks_pcie)
> +static int ks_pcie_establish_link(struct keystone_pcie *keystone)
>  {
> -	struct pcie_port *pp = &ks_pcie->pp;
> +	struct pcie_port *pp = &keystone->pp;
>  	unsigned int retries;
>  
>  	dw_pcie_setup_rc(pp);
> @@ -100,7 +100,7 @@ static int ks_pcie_establish_link(struct keystone_pcie *ks_pcie)
>  
>  	/* check if the link is up or not */
>  	for (retries = 0; retries < 5; retries++) {
> -		ks_dw_pcie_initiate_link_train(ks_pcie);
> +		ks_dw_pcie_initiate_link_train(keystone);
>  		if (!dw_pcie_wait_for_link(pp))
>  			return 0;
>  	}
> @@ -112,9 +112,9 @@ static int ks_pcie_establish_link(struct keystone_pcie *ks_pcie)
>  static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
>  {
>  	unsigned int irq = irq_desc_get_irq(desc);
> -	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
> -	u32 offset = irq - ks_pcie->msi_host_irqs[0];
> -	struct pcie_port *pp = &ks_pcie->pp;
> +	struct keystone_pcie *keystone = irq_desc_get_handler_data(desc);
> +	u32 offset = irq - keystone->msi_host_irqs[0];
> +	struct pcie_port *pp = &keystone->pp;
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
>  
>  	dev_dbg(pp->dev, "%s, irq %d\n", __func__, irq);
> @@ -125,7 +125,7 @@ static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
>  	 * ack operation.
>  	 */
>  	chained_irq_enter(chip, desc);
> -	ks_dw_pcie_handle_msi_irq(ks_pcie, offset);
> +	ks_dw_pcie_handle_msi_irq(keystone, offset);
>  	chained_irq_exit(chip, desc);
>  }
>  
> @@ -140,9 +140,9 @@ static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
>  static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
>  {
>  	unsigned int irq = irq_desc_get_irq(desc);
> -	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
> -	struct pcie_port *pp = &ks_pcie->pp;
> -	u32 irq_offset = irq - ks_pcie->legacy_host_irqs[0];
> +	struct keystone_pcie *keystone = irq_desc_get_handler_data(desc);
> +	struct pcie_port *pp = &keystone->pp;
> +	u32 irq_offset = irq - keystone->legacy_host_irqs[0];
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
>  
>  	dev_dbg(pp->dev, ": Handling legacy irq %d\n", irq);
> @@ -153,28 +153,28 @@ static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
>  	 * ack operation.
>  	 */
>  	chained_irq_enter(chip, desc);
> -	ks_dw_pcie_handle_legacy_irq(ks_pcie, irq_offset);
> +	ks_dw_pcie_handle_legacy_irq(keystone, irq_offset);
>  	chained_irq_exit(chip, desc);
>  }
>  
> -static int ks_pcie_get_irq_controller_info(struct keystone_pcie *ks_pcie,
> +static int ks_pcie_get_irq_controller_info(struct keystone_pcie *keystone,
>  					   char *controller, int *num_irqs)
>  {
>  	int temp, max_host_irqs, legacy = 1, *host_irqs;
> -	struct device *dev = ks_pcie->pp.dev;
> +	struct device *dev = keystone->pp.dev;
>  	struct device_node *np_pcie = dev->of_node, **np_temp;
>  
>  	if (!strcmp(controller, "msi-interrupt-controller"))
>  		legacy = 0;
>  
>  	if (legacy) {
> -		np_temp = &ks_pcie->legacy_intc_np;
> +		np_temp = &keystone->legacy_intc_np;
>  		max_host_irqs = MAX_LEGACY_HOST_IRQS;
> -		host_irqs = &ks_pcie->legacy_host_irqs[0];
> +		host_irqs = &keystone->legacy_host_irqs[0];
>  	} else {
> -		np_temp = &ks_pcie->msi_intc_np;
> +		np_temp = &keystone->msi_intc_np;
>  		max_host_irqs = MAX_MSI_HOST_IRQS;
> -		host_irqs =  &ks_pcie->msi_host_irqs[0];
> +		host_irqs =  &keystone->msi_host_irqs[0];
>  	}
>  
>  	/* interrupt controller is in a child node */
> @@ -212,29 +212,29 @@ static int ks_pcie_get_irq_controller_info(struct keystone_pcie *ks_pcie,
>  	return -EINVAL;
>  }
>  
> -static void ks_pcie_setup_interrupts(struct keystone_pcie *ks_pcie)
> +static void ks_pcie_setup_interrupts(struct keystone_pcie *keystone)
>  {
>  	int i;
>  
>  	/* Legacy IRQ */
> -	for (i = 0; i < ks_pcie->num_legacy_host_irqs; i++) {
> -		irq_set_chained_handler_and_data(ks_pcie->legacy_host_irqs[i],
> +	for (i = 0; i < keystone->num_legacy_host_irqs; i++) {
> +		irq_set_chained_handler_and_data(keystone->legacy_host_irqs[i],
>  						 ks_pcie_legacy_irq_handler,
> -						 ks_pcie);
> +						 keystone);
>  	}
> -	ks_dw_pcie_enable_legacy_irqs(ks_pcie);
> +	ks_dw_pcie_enable_legacy_irqs(keystone);
>  
>  	/* MSI IRQ */
>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -		for (i = 0; i < ks_pcie->num_msi_host_irqs; i++) {
> -			irq_set_chained_handler_and_data(ks_pcie->msi_host_irqs[i],
> +		for (i = 0; i < keystone->num_msi_host_irqs; i++) {
> +			irq_set_chained_handler_and_data(keystone->msi_host_irqs[i],
>  							 ks_pcie_msi_irq_handler,
> -							 ks_pcie);
> +							 keystone);
>  		}
>  	}
>  
> -	if (ks_pcie->error_irq > 0)
> -		ks_dw_pcie_enable_error_irq(ks_pcie->va_app_base);
> +	if (keystone->error_irq > 0)
> +		ks_dw_pcie_enable_error_irq(keystone->va_app_base);
>  }
>  
>  /*
> @@ -259,17 +259,17 @@ static int keystone_pcie_fault(unsigned long addr, unsigned int fsr,
>  
>  static void __init ks_pcie_host_init(struct pcie_port *pp)
>  {
> -	struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
> +	struct keystone_pcie *keystone = to_keystone_pcie(pp);
>  	u32 val;
>  
> -	ks_pcie_establish_link(ks_pcie);
> -	ks_dw_pcie_setup_rc_app_regs(ks_pcie);
> -	ks_pcie_setup_interrupts(ks_pcie);
> +	ks_pcie_establish_link(keystone);
> +	ks_dw_pcie_setup_rc_app_regs(keystone);
> +	ks_pcie_setup_interrupts(keystone);
>  	writew(PCI_IO_RANGE_TYPE_32 | (PCI_IO_RANGE_TYPE_32 << 8),
>  			pp->dbi_base + PCI_IO_BASE);
>  
>  	/* update the Vendor ID */
> -	writew(ks_pcie->device_id, pp->dbi_base + PCI_DEVICE_ID);
> +	writew(keystone->device_id, pp->dbi_base + PCI_DEVICE_ID);
>  
>  	/* update the DEV_STAT_CTRL to publish right mrrs */
>  	val = readl(pp->dbi_base + PCIE_CAP_BASE + PCI_EXP_DEVCTL);
> @@ -300,28 +300,28 @@ static struct pcie_host_ops keystone_pcie_host_ops = {
>  
>  static irqreturn_t pcie_err_irq_handler(int irq, void *priv)
>  {
> -	struct keystone_pcie *ks_pcie = priv;
> +	struct keystone_pcie *keystone = priv;
>  
> -	return ks_dw_pcie_handle_error_irq(ks_pcie->pp.dev,
> -					   ks_pcie->va_app_base);
> +	return ks_dw_pcie_handle_error_irq(keystone->pp.dev,
> +					   keystone->va_app_base);
>  }
>  
> -static int __init ks_add_pcie_port(struct keystone_pcie *ks_pcie,
> +static int __init ks_add_pcie_port(struct keystone_pcie *keystone,
>  			 struct platform_device *pdev)
>  {
> -	struct pcie_port *pp = &ks_pcie->pp;
> +	struct pcie_port *pp = &keystone->pp;
>  	int ret;
>  
> -	ret = ks_pcie_get_irq_controller_info(ks_pcie,
> +	ret = ks_pcie_get_irq_controller_info(keystone,
>  					"legacy-interrupt-controller",
> -					&ks_pcie->num_legacy_host_irqs);
> +					&keystone->num_legacy_host_irqs);
>  	if (ret)
>  		return ret;
>  
>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -		ret = ks_pcie_get_irq_controller_info(ks_pcie,
> +		ret = ks_pcie_get_irq_controller_info(keystone,
>  						"msi-interrupt-controller",
> -						&ks_pcie->num_msi_host_irqs);
> +						&keystone->num_msi_host_irqs);
>  		if (ret)
>  			return ret;
>  	}
> @@ -330,22 +330,22 @@ static int __init ks_add_pcie_port(struct keystone_pcie *ks_pcie,
>  	 * Index 0 is the platform interrupt for error interrupt
>  	 * from RC.  This is optional.
>  	 */
> -	ks_pcie->error_irq = irq_of_parse_and_map(ks_pcie->np, 0);
> -	if (ks_pcie->error_irq <= 0)
> +	keystone->error_irq = irq_of_parse_and_map(keystone->np, 0);
> +	if (keystone->error_irq <= 0)
>  		dev_info(&pdev->dev, "no error IRQ defined\n");
>  	else {
> -		ret = request_irq(ks_pcie->error_irq, pcie_err_irq_handler,
> -				  IRQF_SHARED, "pcie-error-irq", ks_pcie);
> +		ret = request_irq(keystone->error_irq, pcie_err_irq_handler,
> +				  IRQF_SHARED, "pcie-error-irq", keystone);
>  		if (ret < 0) {
>  			dev_err(&pdev->dev, "failed to request error IRQ %d\n",
> -				ks_pcie->error_irq);
> +				keystone->error_irq);
>  			return ret;
>  		}
>  	}
>  
>  	pp->root_bus_nr = -1;
>  	pp->ops = &keystone_pcie_host_ops;
> -	ret = ks_dw_pcie_host_init(ks_pcie, ks_pcie->msi_intc_np);
> +	ret = ks_dw_pcie_host_init(keystone, keystone->msi_intc_np);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to initialize host\n");
>  		return ret;
> @@ -364,9 +364,9 @@ static const struct of_device_id ks_pcie_of_match[] = {
>  
>  static int __exit ks_pcie_remove(struct platform_device *pdev)
>  {
> -	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
> +	struct keystone_pcie *keystone = platform_get_drvdata(pdev);
>  
> -	clk_disable_unprepare(ks_pcie->clk);
> +	clk_disable_unprepare(keystone->clk);
>  
>  	return 0;
>  }
> @@ -374,19 +374,18 @@ static int __exit ks_pcie_remove(struct platform_device *pdev)
>  static int __init ks_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct keystone_pcie *ks_pcie;
> +	struct keystone_pcie *keystone;
>  	struct pcie_port *pp;
>  	struct resource *res;
>  	void __iomem *reg_p;
>  	struct phy *phy;
>  	int ret;
>  
> -	ks_pcie = devm_kzalloc(&pdev->dev, sizeof(*ks_pcie),
> -				GFP_KERNEL);
> -	if (!ks_pcie)
> +	keystone = devm_kzalloc(&pdev->dev, sizeof(*keystone), GFP_KERNEL);
> +	if (!keystone)
>  		return -ENOMEM;
>  
> -	pp = &ks_pcie->pp;
> +	pp = &keystone->pp;
>  
>  	/* initialize SerDes Phy if present */
>  	phy = devm_phy_get(dev, "pcie-phy");
> @@ -404,29 +403,29 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>  	reg_p = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(reg_p))
>  		return PTR_ERR(reg_p);
> -	ks_pcie->device_id = readl(reg_p) >> 16;
> +	keystone->device_id = readl(reg_p) >> 16;
>  	devm_iounmap(dev, reg_p);
>  	devm_release_mem_region(dev, res->start, resource_size(res));
>  
>  	pp->dev = dev;
> -	ks_pcie->np = dev->of_node;
> -	platform_set_drvdata(pdev, ks_pcie);
> -	ks_pcie->clk = devm_clk_get(dev, "pcie");
> -	if (IS_ERR(ks_pcie->clk)) {
> +	keystone->np = dev->of_node;
> +	platform_set_drvdata(pdev, keystone);
> +	keystone->clk = devm_clk_get(dev, "pcie");
> +	if (IS_ERR(keystone->clk)) {
>  		dev_err(dev, "Failed to get pcie rc clock\n");
> -		return PTR_ERR(ks_pcie->clk);
> +		return PTR_ERR(keystone->clk);
>  	}
> -	ret = clk_prepare_enable(ks_pcie->clk);
> +	ret = clk_prepare_enable(keystone->clk);
>  	if (ret)
>  		return ret;
>  
> -	ret = ks_add_pcie_port(ks_pcie, pdev);
> +	ret = ks_add_pcie_port(keystone, pdev);
>  	if (ret < 0)
>  		goto fail_clk;
>  
>  	return 0;
>  fail_clk:
> -	clk_disable_unprepare(ks_pcie->clk);
> +	clk_disable_unprepare(keystone->clk);
>  
>  	return ret;
>  }
> diff --git a/drivers/pci/host/pci-keystone.h b/drivers/pci/host/pci-keystone.h
> index a5b0cb2..379213c 100644
> --- a/drivers/pci/host/pci-keystone.h
> +++ b/drivers/pci/host/pci-keystone.h
> @@ -39,24 +39,24 @@ struct keystone_pcie {
>  };
>  
>  /* Keystone DW specific MSI controller APIs/definitions */
> -void ks_dw_pcie_handle_msi_irq(struct keystone_pcie *ks_pcie, int offset);
> +void ks_dw_pcie_handle_msi_irq(struct keystone_pcie *keystone, int offset);
>  phys_addr_t ks_dw_pcie_get_msi_addr(struct pcie_port *pp);
>  
>  /* Keystone specific PCI controller APIs */
> -void ks_dw_pcie_enable_legacy_irqs(struct keystone_pcie *ks_pcie);
> -void ks_dw_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie, int offset);
> +void ks_dw_pcie_enable_legacy_irqs(struct keystone_pcie *keystone);
> +void ks_dw_pcie_handle_legacy_irq(struct keystone_pcie *keystone, int offset);
>  void ks_dw_pcie_enable_error_irq(void __iomem *reg_base);
>  irqreturn_t ks_dw_pcie_handle_error_irq(struct device *dev,
>  					void __iomem *reg_base);
> -int  ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie,
> +int  ks_dw_pcie_host_init(struct keystone_pcie *keystone,
>  			struct device_node *msi_intc_np);
>  int ks_dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>  		unsigned int devfn, int where, int size, u32 val);
>  int ks_dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>  		unsigned int devfn, int where, int size, u32 *val);
> -void ks_dw_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie);
> +void ks_dw_pcie_setup_rc_app_regs(struct keystone_pcie *keystone);
>  int ks_dw_pcie_link_up(struct pcie_port *pp);
> -void ks_dw_pcie_initiate_link_train(struct keystone_pcie *ks_pcie);
> +void ks_dw_pcie_initiate_link_train(struct keystone_pcie *keystone);
>  void ks_dw_pcie_msi_set_irq(struct pcie_port *pp, int irq);
>  void ks_dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq);
>  void ks_dw_pcie_v3_65_scan_bus(struct pcie_port *pp);
> 


-- 
Murali Karicheri
Linux Kernel, Keystone
