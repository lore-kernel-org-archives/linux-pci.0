Return-Path: <SRS0=2g0o=Q4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874BBC43381
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 16:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE5A2077B
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 16:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbfBUQYW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:24:22 -0500
Received: from foss.arm.com ([217.140.101.70]:47504 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbfBUQYW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Feb 2019 11:24:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48E7BA78;
        Thu, 21 Feb 2019 08:24:21 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A8BB3F690;
        Thu, 21 Feb 2019 08:24:19 -0800 (PST)
Date:   Thu, 21 Feb 2019 16:24:14 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>, marc.zyngier@arm.com
Cc:     Murali Karicheri <m-karicheri2@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/9] PCI: keystone: Convert to using hierarchy domain
 for legacy interrupts
Message-ID: <20190221162413.GA5815@e107981-ln.cambridge.arm.com>
References: <20190221101518.22604-1-kishon@ti.com>
 <20190221101518.22604-4-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221101518.22604-4-kishon@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 21, 2019 at 03:45:12PM +0530, Kishon Vijay Abraham I wrote:
> K2G provides separate IRQ lines for each of the four legacy interrupts.
> Model this using hierarchy domain instead of linear domain with chained
> IRQ handler.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/dwc/pci-keystone.c | 205 +++++++++++++---------
>  1 file changed, 118 insertions(+), 87 deletions(-)

Hi Kishon,

I CC'ed Marc because you are actually re-writing an interrupt controller
driver so I would be happier to merge this refactoring if Marc can have
a look and he is satisfied with it - more so because most of the code can
be reused by other host bridge drivers with similar behaviour.

I will have a look too, unfortunately it is becoming a bit tight for
v5.1 but let's see how it goes.

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 47f0dcf638f2..7f1648453f54 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -61,6 +61,7 @@
>  
>  #define IRQ_STATUS(n)			(0x184 + ((n) << 4))
>  #define IRQ_ENABLE_SET(n)		(0x188 + ((n) << 4))
> +#define IRQ_ENABLE_CLR(n)		(0x18C + ((n) << 4))
>  #define INTx_EN				BIT(0)
>  
>  #define ERR_IRQ_STATUS			0x1c4
> @@ -87,7 +88,6 @@ struct keystone_pcie {
>  	struct dw_pcie		*pci;
>  	/* PCI Device ID */
>  	u32			device_id;
> -	int			legacy_host_irqs[PCI_NUM_INTX];
>  	struct			device_node *legacy_intc_np;
>  
>  	int			msi_host_irqs[MAX_MSI_HOST_IRQS];
> @@ -96,7 +96,6 @@ struct keystone_pcie {
>  	struct phy		**phy;
>  	struct device_link	**link;
>  	struct			device_node *msi_intc_np;
> -	struct irq_domain	*legacy_irq_domain;
>  	struct device_node	*np;
>  
>  	int error_irq;
> @@ -199,26 +198,6 @@ static int ks_pcie_msi_host_init(struct pcie_port *pp)
>  	return dw_pcie_allocate_domains(pp);
>  }
>  
> -static void ks_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie,
> -				      int offset)
> -{
> -	struct dw_pcie *pci = ks_pcie->pci;
> -	struct device *dev = pci->dev;
> -	u32 pending;
> -	int virq;
> -
> -	pending = ks_pcie_app_readl(ks_pcie, IRQ_STATUS(offset));
> -
> -	if (BIT(0) & pending) {
> -		virq = irq_linear_revmap(ks_pcie->legacy_irq_domain, offset);
> -		dev_dbg(dev, ": irq: irq_offset %d, virq %d\n", offset, virq);
> -		generic_handle_irq(virq);
> -	}
> -
> -	/* EOI the INTx interrupt */
> -	ks_pcie_app_writel(ks_pcie, IRQ_EOI, offset);
> -}
> -
>  static void ks_pcie_enable_error_irq(struct keystone_pcie *ks_pcie)
>  {
>  	ks_pcie_app_writel(ks_pcie, ERR_IRQ_ENABLE_SET, ERR_IRQ_ALL);
> @@ -256,39 +235,117 @@ static irqreturn_t ks_pcie_handle_error_irq(struct keystone_pcie *ks_pcie)
>  	return IRQ_HANDLED;
>  }
>  
> -static void ks_pcie_ack_legacy_irq(struct irq_data *d)
> +void ks_pcie_irq_eoi(struct irq_data *data)
>  {
> +	struct keystone_pcie *ks_pcie = irq_data_get_irq_chip_data(data);
> +	irq_hw_number_t hwirq = data->hwirq;
> +
> +	ks_pcie_app_writel(ks_pcie, IRQ_EOI, hwirq);
> +	irq_chip_eoi_parent(data);
>  }
>  
> -static void ks_pcie_mask_legacy_irq(struct irq_data *d)
> +void ks_pcie_irq_enable(struct irq_data *data)
>  {
> +	struct keystone_pcie *ks_pcie = irq_data_get_irq_chip_data(data);
> +	irq_hw_number_t hwirq = data->hwirq;
> +
> +	ks_pcie_app_writel(ks_pcie, IRQ_ENABLE_SET(hwirq), INTx_EN);
> +	irq_chip_enable_parent(data);
>  }
>  
> -static void ks_pcie_unmask_legacy_irq(struct irq_data *d)
> +void ks_pcie_irq_disable(struct irq_data *data)
>  {
> +	struct keystone_pcie *ks_pcie = irq_data_get_irq_chip_data(data);
> +	irq_hw_number_t hwirq = data->hwirq;
> +
> +	ks_pcie_app_writel(ks_pcie, IRQ_ENABLE_CLR(hwirq), INTx_EN);
> +	irq_chip_disable_parent(data);
>  }
>  
>  static struct irq_chip ks_pcie_legacy_irq_chip = {
> -	.name = "Keystone-PCI-Legacy-IRQ",
> -	.irq_ack = ks_pcie_ack_legacy_irq,
> -	.irq_mask = ks_pcie_mask_legacy_irq,
> -	.irq_unmask = ks_pcie_unmask_legacy_irq,
> +	.name			= "Keystone-PCI-Legacy-IRQ",
> +	.irq_enable		= ks_pcie_irq_enable,
> +	.irq_disable		= ks_pcie_irq_disable,
> +	.irq_eoi		= ks_pcie_irq_eoi,
> +	.irq_mask		= irq_chip_mask_parent,
> +	.irq_unmask		= irq_chip_unmask_parent,
> +	.irq_retrigger		= irq_chip_retrigger_hierarchy,
> +	.irq_set_type		= irq_chip_set_type_parent,
> +	.irq_set_affinity	= irq_chip_set_affinity_parent,
>  };
>  
> -static int ks_pcie_init_legacy_irq_map(struct irq_domain *d,
> -				       unsigned int irq,
> -				       irq_hw_number_t hw_irq)
> +static int ks_pcie_legacy_irq_domain_alloc(struct irq_domain *domain,
> +					   unsigned int virq,
> +					   unsigned int nr_irqs, void *data)
>  {
> -	irq_set_chip_and_handler(irq, &ks_pcie_legacy_irq_chip,
> -				 handle_level_irq);
> -	irq_set_chip_data(irq, d->host_data);
> +	struct keystone_pcie *ks_pcie = domain->host_data;
> +	struct device_node *np = ks_pcie->legacy_intc_np;
> +	struct irq_fwspec parent_fwspec, *fwspec = data;
> +	struct of_phandle_args out_irq;
> +	int ret, i;
> +
> +	if (nr_irqs != 1)
> +		return -EINVAL;
> +
> +	ret = of_irq_parse_one(np, fwspec->param[0], &out_irq);
> +	if (ret < 0) {
> +		pr_err("Failed to parse interrupt node\n");
> +		return ret;
> +	}
> +
> +	parent_fwspec.fwnode = &out_irq.np->fwnode;
> +	parent_fwspec.param_count = out_irq.args_count;
> +
> +	for (i = 0; i < out_irq.args_count; i++)
> +		parent_fwspec.param[i] = out_irq.args[i];
> +
> +	ret = irq_domain_alloc_irqs_parent(domain, virq, 1, &parent_fwspec);
> +	if (ret < 0) {
> +		pr_err("Failed to allocate parent irq %u: %d\n",
> +		       parent_fwspec.param[0], ret);
> +		return ret;
> +	}
> +
> +	ret = irq_domain_set_hwirq_and_chip(domain, virq, fwspec->param[0],
> +					    &ks_pcie_legacy_irq_chip, ks_pcie);
> +	if (ret < 0) {
> +		pr_err("Failed to set hwirq and chip\n");
> +		goto err_set_hwirq_and_chip;
> +	}
>  
>  	return 0;
> +
> +err_set_hwirq_and_chip:
> +	irq_domain_free_irqs_parent(domain, virq, 1);
> +
> +	return ret;
> +}
> +
> +static int ks_pcie_irq_domain_translate(struct irq_domain *domain,
> +					struct irq_fwspec *fwspec,
> +					unsigned long *hwirq,
> +					unsigned int *type)
> +{
> +	if (is_of_node(fwspec->fwnode)) {
> +		if (fwspec->param_count != 2)
> +			return -EINVAL;
> +
> +		if (fwspec->param[0] >= PCI_NUM_INTX)
> +			return -EINVAL;
> +
> +		*hwirq = fwspec->param[0];
> +		*type = fwspec->param[1];
> +
> +		return 0;
> +	}
> +
> +	return -EINVAL;
>  }
>  
>  static const struct irq_domain_ops ks_pcie_legacy_irq_domain_ops = {
> -	.map = ks_pcie_init_legacy_irq_map,
> -	.xlate = irq_domain_xlate_onetwocell,
> +	.alloc		= ks_pcie_legacy_irq_domain_alloc,
> +	.free		= irq_domain_free_irqs_common,
> +	.translate	= ks_pcie_irq_domain_translate,
>  };
>  
>  /**
> @@ -572,35 +629,6 @@ static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
>  	chained_irq_exit(chip, desc);
>  }
>  
> -/**
> - * ks_pcie_legacy_irq_handler() - Handle legacy interrupt
> - * @irq: IRQ line for legacy interrupts
> - * @desc: Pointer to irq descriptor
> - *
> - * Traverse through pending legacy interrupts and invoke handler for each. Also
> - * takes care of interrupt controller level mask/ack operation.
> - */
> -static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
> -{
> -	unsigned int irq = irq_desc_get_irq(desc);
> -	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
> -	struct dw_pcie *pci = ks_pcie->pci;
> -	struct device *dev = pci->dev;
> -	u32 irq_offset = irq - ks_pcie->legacy_host_irqs[0];
> -	struct irq_chip *chip = irq_desc_get_chip(desc);
> -
> -	dev_dbg(dev, ": Handling legacy irq %d\n", irq);
> -
> -	/*
> -	 * The chained irq handler installation would have replaced normal
> -	 * interrupt driver handler so we need to take care of mask/unmask and
> -	 * ack operation.
> -	 */
> -	chained_irq_enter(chip, desc);
> -	ks_pcie_handle_legacy_irq(ks_pcie, irq_offset);
> -	chained_irq_exit(chip, desc);
> -}
> -
>  static int ks_pcie_config_msi_irq(struct keystone_pcie *ks_pcie)
>  {
>  	struct device *dev = ks_pcie->pci->dev;
> @@ -655,14 +683,33 @@ static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
>  	struct device *dev = ks_pcie->pci->dev;
>  	struct irq_domain *legacy_irq_domain;
>  	struct device_node *np = ks_pcie->np;
> +	struct irq_domain *parent_domain;
> +	struct device_node *parent_node;
>  	struct device_node *intc_np;
> -	int irq_count, irq, ret = 0, i;
> +	int irq_count, ret = 0;
>  
>  	intc_np = of_get_child_by_name(np, "legacy-interrupt-controller");
>  	if (!intc_np) {
>  		dev_warn(dev, "legacy-interrupt-controller node is absent\n");
>  		return -EINVAL;
>  	}
> +	ks_pcie->legacy_intc_np = intc_np;
> +
> +	parent_node = of_irq_find_parent(intc_np);
> +	if (!parent_node) {
> +		dev_err(dev, "unable to obtain parent node\n");
> +		ret = -ENXIO;
> +		goto err;
> +	}
> +
> +	parent_domain = irq_find_host(parent_node);
> +	if (!parent_domain) {
> +		dev_err(dev, "unable to obtain parent domain\n");
> +		ret = -ENXIO;
> +		goto err;
> +	}
> +
> +	of_node_put(parent_node);
>  
>  	irq_count = of_irq_count(intc_np);
>  	if (!irq_count) {
> @@ -671,31 +718,15 @@ static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
>  		goto err;
>  	}
>  
> -	for (i = 0; i < irq_count; i++) {
> -		irq = irq_of_parse_and_map(intc_np, i);
> -		if (!irq) {
> -			ret = -EINVAL;
> -			goto err;
> -		}
> -		ks_pcie->legacy_host_irqs[i] = irq;
> -
> -		irq_set_chained_handler_and_data(irq,
> -						 ks_pcie_legacy_irq_handler,
> -						 ks_pcie);
> -	}
> -
>  	legacy_irq_domain =
> -		irq_domain_add_linear(intc_np, PCI_NUM_INTX,
> -				      &ks_pcie_legacy_irq_domain_ops, NULL);
> +		irq_domain_add_hierarchy(parent_domain, 0, PCI_NUM_INTX,
> +					 intc_np,
> +					 &ks_pcie_legacy_irq_domain_ops,
> +					 ks_pcie);
>  	if (!legacy_irq_domain) {
>  		dev_err(dev, "Failed to add irq domain for legacy irqs\n");
>  		ret = -EINVAL;
> -		goto err;
>  	}
> -	ks_pcie->legacy_irq_domain = legacy_irq_domain;
> -
> -	for (i = 0; i < PCI_NUM_INTX; i++)
> -		ks_pcie_app_writel(ks_pcie, IRQ_ENABLE_SET(i), INTx_EN);
>  
>  err:
>  	of_node_put(intc_np);
> -- 
> 2.17.1
> 
