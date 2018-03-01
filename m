Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:33879 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030485AbeCAMuq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Mar 2018 07:50:46 -0500
Subject: Re: [PATCH v9 1/3] PCI: dwc: Add new IRQ API
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
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
        "nsekhar@ti.com" <nsekhar@ti.com>
References: <cover.1519834018.git.gustavo.pimentel@synopsys.com>
 <92c84aeb09c0dd52da6879239ee9cf57cc982e13.1519834018.git.gustavo.pimentel@synopsys.com>
 <20180301113336.GA30460@e107981-ln.cambridge.arm.com>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <25eafe3e-4fc9-59bd-25aa-4e2bb1c19d96@synopsys.com>
Date: Thu, 1 Mar 2018 12:50:20 +0000
MIME-Version: 1.0
In-Reply-To: <20180301113336.GA30460@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

On 01/03/2018 11:33, Lorenzo Pieralisi wrote:
> On Wed, Feb 28, 2018 at 04:10:23PM +0000, Gustavo Pimentel wrote:
> 
> [...]
> 
>> diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
>> index 8de2d5c..b252673 100644
>> --- a/drivers/pci/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/dwc/pcie-designware-host.c
> 
> [...]
> 
>> +static int dw_pcie_irq_domain_alloc(struct irq_domain *domain,
>> +				    unsigned int virq, unsigned int nr_irqs,
>> +				    void *args)
>> +{
>> +	struct pcie_port *pp = domain->host_data;
>> +	unsigned long flags;
>> +	unsigned long bit;
>> +	u32 i;
>> +
>> +	raw_spin_lock_irqsave(&pp->lock, flags);
>> +
>> +	bit = bitmap_find_free_region(pp->msi_irq_in_use, pp->num_vectors,
>> +				      order_base_2(nr_irqs));
>> +
>> +	if (bit < 0) {
>> +		raw_spin_unlock_irqrestore(&pp->lock, flags);
>> +		return -ENOSPC;
>> +	}
>> +
>> +	raw_spin_unlock_irqrestore(&pp->lock, flags);
> 
> I've rewritten this as:
> 
> raw_spin_unlock_irqrestore(&pp->lock, flags);
> 
> if (bit < 0)
> 	return -ENOSPC;
> 
> Since the unlock path is ugly and there is no need to protect the bit
> variable, we should just protect the bitmap.

Agree. Very well spotted!

> 
> Have a look at my pci/dwc-msi branch to check if that's what
> you expect.
> 
> Everything else is OK to me, patches queued in my pci/dwc-msi
> branch for v4.17, please have a look.

All seems to be OK to me. Once again thanks.

> 
> Thanks !
> Lorenzo
> 
>> +
>> +	for (i = 0; i < nr_irqs; i++)
>> +		irq_domain_set_info(domain, virq + i, bit + i,
>> +				    &dw_pci_msi_bottom_irq_chip,
>> +				    pp, handle_edge_irq,
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
>> +	raw_spin_lock_irqsave(&pp->lock, flags);
>> +	bitmap_release_region(pp->msi_irq_in_use, data->hwirq,
>> +			      order_base_2(nr_irqs));
>> +	raw_spin_unlock_irqrestore(&pp->lock, flags);
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
>> @@ -96,20 +317,21 @@ void dw_pcie_msi_init(struct pcie_port *pp)
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
>> @@ -131,13 +353,14 @@ static void clear_irq_range(struct pcie_port *pp, unsigned int irq_base,
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
>> @@ -285,11 +508,13 @@ int dw_pcie_host_init(struct pcie_port *pp)
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
>> @@ -388,18 +613,33 @@ int dw_pcie_host_init(struct pcie_port *pp)
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
>> @@ -421,10 +661,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
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
>> @@ -593,11 +829,15 @@ static u8 dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
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
>> diff --git a/drivers/pci/dwc/pcie-designware-plat.c b/drivers/pci/dwc/pcie-designware-plat.c
>> index ebdf28b..5416aa8 100644
>> --- a/drivers/pci/dwc/pcie-designware-plat.c
>> +++ b/drivers/pci/dwc/pcie-designware-plat.c
>> @@ -25,13 +25,6 @@ struct dw_plat_pcie {
>>  	struct dw_pcie		*pci;
>>  };
>>  
>> -static irqreturn_t dw_plat_pcie_msi_irq_handler(int irq, void *arg)
>> -{
>> -	struct pcie_port *pp = arg;
>> -
>> -	return dw_handle_msi_irq(pp);
>> -}
>> -
>>  static int dw_plat_pcie_host_init(struct pcie_port *pp)
>>  {
>>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> @@ -63,15 +56,6 @@ static int dw_plat_add_pcie_port(struct pcie_port *pp,
>>  		pp->msi_irq = platform_get_irq(pdev, 0);
>>  		if (pp->msi_irq < 0)
>>  			return pp->msi_irq;
>> -
>> -		ret = devm_request_irq(dev, pp->msi_irq,
>> -					dw_plat_pcie_msi_irq_handler,
>> -					IRQF_SHARED | IRQF_NO_THREAD,
>> -					"dw-plat-pcie-msi", pp);
>> -		if (ret) {
>> -			dev_err(dev, "failed to request MSI IRQ\n");
>> -			return ret;
>> -		}
>>  	}
>>  
>>  	pp->root_bus_nr = -1;
>> diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
>> index 11b1386..de383c0 100644
>> --- a/drivers/pci/dwc/pcie-designware.h
>> +++ b/drivers/pci/dwc/pcie-designware.h
>> @@ -114,6 +114,7 @@
>>   */
>>  #define MAX_MSI_IRQS			32
>>  #define MAX_MSI_CTRLS			(MAX_MSI_IRQS / 32)
>> +#define MSI_DEF_NUM_VECTORS		32
>>  
>>  /* Maximum number of inbound/outbound iATUs */
>>  #define MAX_IATU_IN			256
>> @@ -149,7 +150,9 @@ struct dw_pcie_host_ops {
>>  	phys_addr_t (*get_msi_addr)(struct pcie_port *pp);
>>  	u32 (*get_msi_data)(struct pcie_port *pp, int pos);
>>  	void (*scan_bus)(struct pcie_port *pp);
>> +	void (*set_num_vectors)(struct pcie_port *pp);
>>  	int (*msi_host_init)(struct pcie_port *pp, struct msi_controller *chip);
>> +	void (*msi_irq_ack)(int irq, struct pcie_port *pp);
>>  };
>>  
>>  struct pcie_port {
>> @@ -174,7 +177,11 @@ struct pcie_port {
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
>> @@ -316,8 +323,10 @@ static inline void dw_pcie_dbi_ro_wr_dis(struct dw_pcie *pci)
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
>> @@ -328,6 +337,10 @@ static inline void dw_pcie_msi_init(struct pcie_port *pp)
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
>> @@ -336,6 +349,11 @@ static inline int dw_pcie_host_init(struct pcie_port *pp)
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
>> diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
>> index 6310c66..89e5cc5 100644
>> --- a/drivers/pci/dwc/pcie-qcom.c
>> +++ b/drivers/pci/dwc/pcie-qcom.c
>> @@ -180,13 +180,6 @@ static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
>>  	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
>>  }
>>  
>> -static irqreturn_t qcom_pcie_msi_irq_handler(int irq, void *arg)
>> -{
>> -	struct pcie_port *pp = arg;
>> -
>> -	return dw_handle_msi_irq(pp);
>> -}
>> -
>>  static int qcom_pcie_establish_link(struct qcom_pcie *pcie)
>>  {
>>  	struct dw_pcie *pci = pcie->pci;
>> @@ -1262,15 +1255,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>>  		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
>>  		if (pp->msi_irq < 0)
>>  			return pp->msi_irq;
>> -
>> -		ret = devm_request_irq(dev, pp->msi_irq,
>> -				       qcom_pcie_msi_irq_handler,
>> -				       IRQF_SHARED | IRQF_NO_THREAD,
>> -				       "qcom-pcie-msi", pp);
>> -		if (ret) {
>> -			dev_err(dev, "cannot request msi irq\n");
>> -			return ret;
>> -		}
>>  	}
>>  
>>  	ret = phy_init(pcie->phy);
>> -- 
>> 2.7.4
>>
>>

Regards,
Gustavo
