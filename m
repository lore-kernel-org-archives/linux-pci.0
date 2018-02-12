Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:57283 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752532AbeBLR7N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Feb 2018 12:59:13 -0500
Subject: Re: [PATCH v6 1/9] PCI: dwc: Add IRQ chained API support
To: Marc Zyngier <marc.zyngier@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "m-karicheri2@ti.com" <m-karicheri2@ti.com>,
        "thomas.petazzoni@free-electrons.com"
        <thomas.petazzoni@free-electrons.com>,
        "minghuan.Lian@freescale.com" <minghuan.Lian@freescale.com>,
        "mingkai.hu@freescale.com" <mingkai.hu@freescale.com>,
        "tie-fei.zang@freescale.com" <tie-fei.zang@freescale.com>,
        "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "niklas.cassel@axis.com" <niklas.cassel@axis.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
        "gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>,
        "svarbanov@mm-sol.com" <svarbanov@mm-sol.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <cover.1516984229.git.gustavo.pimentel@synopsys.com>
 <8bcba39f181deae0b799f9fcd436fb67fe3b0533.1516984229.git.gustavo.pimentel@synopsys.com>
 <04d3d5b6-9199-218d-476f-c77d04b8d2e7@arm.com>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <5b495bf6-4989-6a24-872c-638a2b078c9f@synopsys.com>
Date: Mon, 12 Feb 2018 17:58:57 +0000
MIME-Version: 1.0
In-Reply-To: <04d3d5b6-9199-218d-476f-c77d04b8d2e7@arm.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Marc,

On 09/02/2018 11:10, Marc Zyngier wrote:
> Hi Gustavo,
> 
> On 26/01/18 16:35, Gustavo Pimentel wrote:
>> Adds a IRQ chained API to pcie-designware, that aims to replace the current
>> IRQ domain hierarchy API implemented.
>>
>> Although the IRQ domain hierarchy API is still available, pcie-designware
>> will use now the IRQ chained API.
> 
> I'm a bit thrown by this comment, as I don't think it reflects the
> reality of the code.
> 
> What you have here is a domain hierarchy (generic PCI MSI layer and HW
> specific domain), *and* a multiplexer (chained interrupt) that funnels
> all your MSIs into a single parent interrupt. What you're moving away
> from is the msi_controller API.
> 
> This has no impact on the code, but it helps to use the correct terminology.
> 

Ok, I'll fix the terminology and descriptions.

>>
>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> Tested-by: Niklas Cassel <niklas.cassel@axis.com>
>> ---
>> Change v1->v2:
>> - num_vectors is now not configurable by the Device Tree. Now it is 32 by
>> default and can be overridden by any specific SoC driver.
>> Change v2->v3:
>> - Nothing changed, just to follow the patch set version.
>> Change v3->v4:
>> - Moved Kishon's fixes (PCI end point error and a dra7xx warning) from
>> v3-0007 patch file to here.
>> - Undo the change of the function signature to be more coherent with the
>> host mode specific functions (Thanks Kishon).
>> - Refactor the added functions in order to used host_data so that getting
>> pp again back from pci could be avoided. (Thanks Kishon)
>> - Changed summary line to match the drivers/PCI convention and changelog to
>> maintain the consistency (thanks Bjorn).
>> Change v4->v5:
>> - Implemented Kishon MSI multiple messages fix (thanks Kishon).
>> Change v5->v6:
>> - Fixed rebase problem detected by Niklas (thanks Niklas).
>>
>>  drivers/pci/dwc/pcie-designware-host.c | 296 +++++++++++++++++++++++++++++----
>>  drivers/pci/dwc/pcie-designware.h      |  18 ++
>>  2 files changed, 286 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
>> index bf558df..f7b2bce 100644
>> --- a/drivers/pci/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/dwc/pcie-designware-host.c
>> @@ -11,6 +11,7 @@
>>   * published by the Free Software Foundation.
>>   */
>>  
>> +#include <linux/irqchip/chained_irq.h>
>>  #include <linux/irqdomain.h>
>>  #include <linux/of_address.h>
>>  #include <linux/of_pci.h>
>> @@ -53,6 +54,36 @@ static struct irq_chip dw_msi_irq_chip = {
>>  	.irq_unmask = pci_msi_unmask_irq,
>>  };
>>  
>> +static void dw_msi_ack_irq(struct irq_data *d)
>> +{
>> +	irq_chip_ack_parent(d);
>> +}
>> +
>> +static void dw_msi_mask_irq(struct irq_data *d)
>> +{
>> +	pci_msi_mask_irq(d);
>> +	irq_chip_mask_parent(d);
>> +}
>> +
>> +static void dw_msi_unmask_irq(struct irq_data *d)
>> +{
>> +	pci_msi_unmask_irq(d);
>> +	irq_chip_unmask_parent(d);
>> +}
>> +
>> +static struct irq_chip dw_pcie_msi_irq_chip = {
>> +	.name = "PCI-MSI",
>> +	.irq_ack = dw_msi_ack_irq,
>> +	.irq_mask = dw_msi_mask_irq,
>> +	.irq_unmask = dw_msi_unmask_irq,
>> +};
>> +
>> +static struct msi_domain_info dw_pcie_msi_domain_info = {
>> +	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
>> +		   MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI),
>> +	.chip	= &dw_pcie_msi_irq_chip,
>> +};
>> +
>>  /* MSI int handler */
>>  irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>>  {
>> @@ -81,6 +112,196 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>>  	return ret;
>>  }
>>  
>> +/* Chained MSI interrupt service routine */
>> +static void dw_chained_msi_isr(struct irq_desc *desc)
>> +{
>> +	struct irq_chip *chip = irq_desc_get_chip(desc);
>> +	struct pcie_port *pp;
>> +
>> +	chained_irq_enter(chip, desc);
>> +
>> +	pp = irq_desc_get_handler_data(desc);
>> +	dw_handle_msi_irq(pp);
>> +
>> +	chained_irq_exit(chip, desc);
>> +}
> 
> Nit: once you're done with the msi_controller stuff (in patch #8), it'd
> be good to move dw_handle_msi_irq() inside this function, as the
> irqreturn_t return type doesn't make much sense any more.

Hum, I like your suggestion, however there's two drivers (HiSilicon STB and ST
Microelectronics SPEAr13xx) that uses directly the dw_handle_msi_irq function. I
would suggested to this "cleanup" in another patch series, just for keep this
patch simple, if you don't mind.

> 
>> +
>> +static void dw_pci_setup_msi_msg(struct irq_data *data, struct msi_msg *msg)
>> +{
>> +	struct pcie_port *pp = irq_data_get_irq_chip_data(data);
>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +	u64 msi_target;
>> +
>> +	if (pp->ops->get_msi_addr)
>> +		msi_target = pp->ops->get_msi_addr(pp);
>> +	else
>> +		msi_target = (u64)pp->msi_data;
>> +
>> +	msg->address_lo = lower_32_bits(msi_target);
>> +	msg->address_hi = upper_32_bits(msi_target);
>> +
>> +	if (pp->ops->get_msi_data)
>> +		msg->data = pp->ops->get_msi_data(pp, data->hwirq);
>> +	else
>> +		msg->data = data->hwirq;
>> +
>> +	dev_dbg(pci->dev, "msi#%d address_hi %#x address_lo %#x\n",
>> +		(int)data->hwirq, msg->address_hi, msg->address_lo);
>> +}
>> +
>> +static int dw_pci_msi_set_affinity(struct irq_data *irq_data,
>> +				   const struct cpumask *mask, bool force)
>> +{
>> +	return -EINVAL;
>> +}
>> +
>> +static void dw_pci_bottom_mask(struct irq_data *data)
>> +{
>> +	struct pcie_port *pp = irq_data_get_irq_chip_data(data);
>> +	unsigned int res, bit, ctrl;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&pp->lock, flags);
> 
> Consider turning this lock (and the corresponding locking primitives) to
> a raw spin_lock. This won't have any additional effect for the mainline
> kernel, but will make it work correctly if you use the RT patches.

Ok, I'll do it.

> 
>> +
>> +	if (pp->ops->msi_clear_irq)
>> +		pp->ops->msi_clear_irq(pp, data->hwirq);
>> +	else {
> 
> Please use { } on both sides of the else.

Done.

> 
>> +		ctrl = data->hwirq / 32;
>> +		res = ctrl * 12;
>> +		bit = data->hwirq % 32;
>> +
>> +		pp->irq_status[ctrl] &= ~(1 << bit);
>> +		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4,
>> +				    pp->irq_status[ctrl]);
>> +	}
>> +
>> +	spin_unlock_irqrestore(&pp->lock, flags);
>> +}
>> +
>> +static void dw_pci_bottom_unmask(struct irq_data *data)
>> +{
>> +	struct pcie_port *pp = irq_data_get_irq_chip_data(data);
>> +	unsigned int res, bit, ctrl;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&pp->lock, flags);
>> +
>> +	if (pp->ops->msi_set_irq)
>> +		pp->ops->msi_set_irq(pp, data->hwirq);
>> +	else {
>> +		ctrl = data->hwirq / 32;
>> +		res = ctrl * 12;
>> +		bit = data->hwirq % 32;
>> +
>> +		pp->irq_status[ctrl] |= 1 << bit;
>> +		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4,
>> +				    pp->irq_status[ctrl]);
>> +	}
>> +
>> +	spin_unlock_irqrestore(&pp->lock, flags);
>> +}
>> +
>> +static void dw_pci_bottom_ack(struct irq_data *d)
>> +{
>> +	struct msi_desc *msi = irq_data_get_msi_desc(d);
>> +	struct pcie_port *pp;
>> +
>> +	pp = (struct pcie_port *) msi_desc_to_pci_sysdata(msi);
> 
> msi_desc_to_pci_sysdata returns a void*, so you can remove this cast.

Done.

> 
>> +
>> +	if (pp->ops->msi_irq_ack)
>> +		pp->ops->msi_irq_ack(d->hwirq, pp);
>> +}
>> +
>> +static struct irq_chip dw_pci_msi_bottom_irq_chip = {
>> +	.name = "DWPCI-MSI",
>> +	.irq_ack = dw_pci_bottom_ack,
>> +	.irq_compose_msi_msg = dw_pci_setup_msi_msg,
>> +	.irq_set_affinity = dw_pci_msi_set_affinity,
>> +	.irq_mask = dw_pci_bottom_mask,
>> +	.irq_unmask = dw_pci_bottom_unmask,
>> +};
>> +
>> +static int dw_pcie_irq_domain_alloc(struct irq_domain *domain,
>> +				    unsigned int virq, unsigned int nr_irqs,
>> +				    void *args)
>> +{
>> +	struct pcie_port *pp = domain->host_data;
>> +	unsigned long flags;
>> +	unsigned long bit;
>> +	u32 i;
>> +
>> +	spin_lock_irqsave(&pp->lock, flags);
>> +
>> +	bit = bitmap_find_free_region(pp->msi_irq_in_use, pp->num_vectors,
>> +				      order_base_2(nr_irqs));
>> +
>> +	if (bit < 0) {
>> +		spin_unlock_irqrestore(&pp->lock, flags);
>> +		return -ENOSPC;
>> +	}
>> +
>> +	spin_unlock_irqrestore(&pp->lock, flags);
>> +
>> +	for (i = 0; i < nr_irqs; i++)
>> +		irq_domain_set_info(domain, virq + i, bit + i,
>> +				    &dw_pci_msi_bottom_irq_chip,
>> +				    pp, handle_level_irq,
> 
> Are you sure about this "handle_level_irq"? MSIs are definitely edge
> triggered, not level.

Done.

> 
>> +				    NULL, NULL);
>> +
>> +	return 0;
>> +}
>> +
>> +static void dw_pcie_irq_domain_free(struct irq_domain *domain,
>> +				    unsigned int virq, unsigned int nr_irqs)
>> +{
>> +	struct irq_data *data = irq_domain_get_irq_data(domain, virq);
>> +	struct pcie_port *pp = irq_data_get_irq_chip_data(data);
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&pp->lock, flags);
>> +	bitmap_release_region(pp->msi_irq_in_use, data->hwirq,
>> +			      order_base_2(nr_irqs));
>> +	spin_unlock_irqrestore(&pp->lock, flags);
>> +}
>> +
>> +static const struct irq_domain_ops dw_pcie_msi_domain_ops = {
>> +	.alloc	= dw_pcie_irq_domain_alloc,
>> +	.free	= dw_pcie_irq_domain_free,
>> +};
>> +
>> +int dw_pcie_allocate_domains(struct pcie_port *pp)
>> +{
>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +	struct fwnode_handle *fwnode = of_node_to_fwnode(pci->dev->of_node);
>> +
>> +	pp->irq_domain = irq_domain_create_linear(fwnode, pp->num_vectors,
>> +					       &dw_pcie_msi_domain_ops, pp);
>> +	if (!pp->irq_domain) {
>> +		dev_err(pci->dev, "failed to create IRQ domain\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	pp->msi_domain = pci_msi_create_irq_domain(fwnode,
>> +						   &dw_pcie_msi_domain_info,
>> +						   pp->irq_domain);
>> +	if (!pp->msi_domain) {
>> +		dev_err(pci->dev, "failed to create MSI domain\n");
>> +		irq_domain_remove(pp->irq_domain);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +void dw_pcie_free_msi(struct pcie_port *pp)
>> +{
>> +	irq_set_chained_handler(pp->msi_irq, NULL);
>> +	irq_set_handler_data(pp->msi_irq, NULL);
>> +
>> +	irq_domain_remove(pp->msi_domain);
>> +	irq_domain_remove(pp->irq_domain);
>> +}
>> +
>>  void dw_pcie_msi_init(struct pcie_port *pp)
>>  {
>>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> @@ -99,20 +320,21 @@ void dw_pcie_msi_init(struct pcie_port *pp)
>>  
>>  	/* program the msi_data */
>>  	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4,
>> -			    (u32)(msi_target & 0xffffffff));
>> +			    lower_32_bits(msi_target));
>>  	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4,
>> -			    (u32)(msi_target >> 32 & 0xffffffff));
>> +			    upper_32_bits(msi_target));
>>  }
>>  
>>  static void dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
>>  {
>> -	unsigned int res, bit, val;
>> +	unsigned int res, bit, ctrl;
>>  
>> -	res = (irq / 32) * 12;
>> +	ctrl = irq / 32;
>> +	res = ctrl * 12;
>>  	bit = irq % 32;
>> -	dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, &val);
>> -	val &= ~(1 << bit);
>> -	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, val);
>> +	pp->irq_status[ctrl] &= ~(1 << bit);
>> +	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4,
>> +			    pp->irq_status[ctrl]);
>>  }
>>  
>>  static void clear_irq_range(struct pcie_port *pp, unsigned int irq_base,
>> @@ -134,13 +356,14 @@ static void clear_irq_range(struct pcie_port *pp, unsigned int irq_base,
>>  
>>  static void dw_pcie_msi_set_irq(struct pcie_port *pp, int irq)
>>  {
>> -	unsigned int res, bit, val;
>> +	unsigned int res, bit, ctrl;
>>  
>> -	res = (irq / 32) * 12;
>> +	ctrl = irq / 32;
>> +	res = ctrl * 12;
>>  	bit = irq % 32;
>> -	dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, &val);
>> -	val |= 1 << bit;
>> -	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, val);
>> +	pp->irq_status[ctrl] |= 1 << bit;
>> +	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4,
>> +			    pp->irq_status[ctrl]);
>>  }
>>  
>>  static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
>> @@ -288,11 +511,13 @@ int dw_pcie_host_init(struct pcie_port *pp)
>>  	struct device *dev = pci->dev;
>>  	struct device_node *np = dev->of_node;
>>  	struct platform_device *pdev = to_platform_device(dev);
>> +	struct resource_entry *win, *tmp;
>>  	struct pci_bus *bus, *child;
>>  	struct pci_host_bridge *bridge;
>>  	struct resource *cfg_res;
>> -	int i, ret;
>> -	struct resource_entry *win, *tmp;
>> +	int ret;
>> +
>> +	spin_lock_init(&pci->pp.lock);
>>  
>>  	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
>>  	if (cfg_res) {
>> @@ -391,18 +616,33 @@ int dw_pcie_host_init(struct pcie_port *pp)
>>  		pci->num_viewport = 2;
>>  
>>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>> -		if (!pp->ops->msi_host_init) {
>> -			pp->irq_domain = irq_domain_add_linear(dev->of_node,
>> -						MAX_MSI_IRQS, &msi_domain_ops,
>> -						&dw_pcie_msi_chip);
>> -			if (!pp->irq_domain) {
>> -				dev_err(dev, "irq domain init failed\n");
>> -				ret = -ENXIO;
>> +		/*
>> +		 * If a specific SoC driver needs to change the
>> +		 * default number of vectors, it needs to implement
>> +		 * the set_num_vectors callback.
>> +		 */
>> +		if (!pp->ops->set_num_vectors) {
>> +			pp->num_vectors = MSI_DEF_NUM_VECTORS;
>> +		} else {
>> +			pp->ops->set_num_vectors(pp);
>> +
>> +			if (pp->num_vectors > MAX_MSI_IRQS ||
>> +			    pp->num_vectors == 0) {
>> +				dev_err(dev,
>> +					"Invalid number of vectors\n");
>>  				goto error;
>>  			}
>> +		}
>>  
>> -			for (i = 0; i < MAX_MSI_IRQS; i++)
>> -				irq_create_mapping(pp->irq_domain, i);
>> +		if (!pp->ops->msi_host_init) {
>> +			ret = dw_pcie_allocate_domains(pp);
>> +			if (ret)
>> +				goto error;
>> +
>> +			if (pp->msi_irq)
>> +				irq_set_chained_handler_and_data(pp->msi_irq,
>> +							    dw_chained_msi_isr,
>> +							    pp);
>>  		} else {
>>  			ret = pp->ops->msi_host_init(pp, &dw_pcie_msi_chip);
>>  			if (ret < 0)
>> @@ -424,10 +664,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
>>  	bridge->ops = &dw_pcie_ops;
>>  	bridge->map_irq = of_irq_parse_and_map_pci;
>>  	bridge->swizzle_irq = pci_common_swizzle;
>> -	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>> -		bridge->msi = &dw_pcie_msi_chip;
>> -		dw_pcie_msi_chip.dev = dev;
>> -	}
>>  
>>  	ret = pci_scan_root_bus_bridge(bridge);
>>  	if (ret)
>> @@ -596,11 +832,15 @@ static u8 dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
>>  
>>  void dw_pcie_setup_rc(struct pcie_port *pp)
>>  {
>> -	u32 val;
>> +	u32 val, ctrl;
>>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>  
>>  	dw_pcie_setup(pci);
>>  
>> +	/* Initialize IRQ Status array */
>> +	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++)
>> +		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE + (ctrl * 12), 4,
>> +				    &pp->irq_status[ctrl]);
>>  	/* setup RC BARs */
>>  	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0x00000004);
>>  	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0x00000000);
>> diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
>> index 8190465..b603e88 100644
>> --- a/drivers/pci/dwc/pcie-designware.h
>> +++ b/drivers/pci/dwc/pcie-designware.h
>> @@ -117,6 +117,7 @@
>>   */
>>  #define MAX_MSI_IRQS			32
>>  #define MAX_MSI_CTRLS			(MAX_MSI_IRQS / 32)
>> +#define MSI_DEF_NUM_VECTORS		32
>>  
>>  /* Maximum number of inbound/outbound iATUs */
>>  #define MAX_IATU_IN			256
>> @@ -152,7 +153,9 @@ struct dw_pcie_host_ops {
>>  	phys_addr_t (*get_msi_addr)(struct pcie_port *pp);
>>  	u32 (*get_msi_data)(struct pcie_port *pp, int pos);
>>  	void (*scan_bus)(struct pcie_port *pp);
>> +	void (*set_num_vectors)(struct pcie_port *pp);
>>  	int (*msi_host_init)(struct pcie_port *pp, struct msi_controller *chip);
>> +	void (*msi_irq_ack)(int irq, struct pcie_port *pp);
>>  };
>>  
>>  struct pcie_port {
>> @@ -177,7 +180,11 @@ struct pcie_port {
>>  	const struct dw_pcie_host_ops *ops;
>>  	int			msi_irq;
>>  	struct irq_domain	*irq_domain;
>> +	struct irq_domain	*msi_domain;
>>  	dma_addr_t		msi_data;
>> +	u32			num_vectors;
>> +	u32			irq_status[MAX_MSI_CTRLS];
>> +	spinlock_t		lock;
>>  	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
>>  };
>>  
>> @@ -319,8 +326,10 @@ static inline void dw_pcie_dbi_ro_wr_dis(struct dw_pcie *pci)
>>  #ifdef CONFIG_PCIE_DW_HOST
>>  irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);
>>  void dw_pcie_msi_init(struct pcie_port *pp);
>> +void dw_pcie_free_msi(struct pcie_port *pp);
>>  void dw_pcie_setup_rc(struct pcie_port *pp);
>>  int dw_pcie_host_init(struct pcie_port *pp);
>> +int dw_pcie_allocate_domains(struct pcie_port *pp);
>>  #else
>>  static inline irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>>  {
>> @@ -331,6 +340,10 @@ static inline void dw_pcie_msi_init(struct pcie_port *pp)
>>  {
>>  }
>>  
>> +static inline void dw_pcie_free_msi(struct pcie_port *pp)
>> +{
>> +}
>> +
>>  static inline void dw_pcie_setup_rc(struct pcie_port *pp)
>>  {
>>  }
>> @@ -339,6 +352,11 @@ static inline int dw_pcie_host_init(struct pcie_port *pp)
>>  {
>>  	return 0;
>>  }
>> +
>> +static inline int dw_pcie_allocate_domains(struct pcie_port *pp)
>> +{
>> +	return 0;
>> +}
>>  #endif
>>  
>>  #ifdef CONFIG_PCIE_DW_EP
>>
> 
> Thanks,
> 
> 	M.
> 

Thanks,
Gustavo
