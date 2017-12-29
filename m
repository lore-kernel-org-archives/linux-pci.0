Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:22588 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755489AbdL2JxQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Dec 2017 04:53:16 -0500
Subject: Re: [PATCH v3 1/9] pci: adding new irq api to pci-designware
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <marc.zyngier@arm.com>, <Joao.Pinto@synopsys.com>,
        <bhelgaas@google.com>, <jingoohan1@gmail.com>
References: <cover.1514455857.git.gustavo.pimentel@synopsys.com>
 <a89026e05ea55cf82b9b6d82240a275556bbe08f.1514455857.git.gustavo.pimentel@synopsys.com>
CC: <linux-pci@vger.kernel.org>, <m-karicheri2@ti.com>,
        <thomas.petazzoni@free-electrons.com>,
        <minghuan.Lian@freescale.com>, <mingkai.hu@freescale.com>,
        <tie-fei.zang@freescale.com>, <hongxing.zhu@nxp.com>,
        <l.stach@pengutronix.de>, <niklas.cassel@axis.com>,
        <jesper.nilsson@axis.com>, <wangzhou1@hisilicon.com>,
        <gabriele.paoloni@huawei.com>, <svarbanov@mm-sol.com>,
        <nsekhar@ti.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <eda2b307-fd77-e558-2025-2ad7ab17f5af@ti.com>
Date: Fri, 29 Dec 2017 15:22:37 +0530
MIME-Version: 1.0
In-Reply-To: <a89026e05ea55cf82b9b6d82240a275556bbe08f.1514455857.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Gustavo,

On Thursday 28 December 2017 05:26 PM, Gustavo Pimentel wrote:
> This patch adds the new interrupt api to pcie-designware, keeping the old
> one. Although the old API is still available, pcie-designware initiates
> with the new one.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
> Change v1->v2:
> - num_vectors is now not configurable by DT. Now it is 32 by default and
> can be overridden by any specific SoC driver.
> Change v2->v3:
> - Nothing changed, just to follow the patch set version.
> 
>  drivers/pci/dwc/pcie-designware-host.c | 282 +++++++++++++++++++++++++++++----
>  drivers/pci/dwc/pcie-designware.h      |  17 ++
>  2 files changed, 272 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
> index 81e2157..289d476 100644
> --- a/drivers/pci/dwc/pcie-designware-host.c
> +++ b/drivers/pci/dwc/pcie-designware-host.c
> @@ -11,6 +11,7 @@
>   * published by the Free Software Foundation.
>   */
>  
> +#include <linux/irqchip/chained_irq.h>
>  #include <linux/irqdomain.h>
>  #include <linux/of_address.h>
>  #include <linux/of_pci.h>
> @@ -53,6 +54,30 @@ static struct irq_chip dw_msi_irq_chip = {
>  	.irq_unmask = pci_msi_unmask_irq,
>  };
>  
> +static void dw_msi_mask_irq(struct irq_data *d)
> +{
> +	pci_msi_mask_irq(d);
> +	irq_chip_mask_parent(d);
> +}
> +
> +static void dw_msi_unmask_irq(struct irq_data *d)
> +{
> +	pci_msi_unmask_irq(d);
> +	irq_chip_unmask_parent(d);
> +}
> +
> +static struct irq_chip dw_pcie_msi_irq_chip = {
> +	.name = "PCI-MSI",
> +	.irq_mask = dw_msi_mask_irq,
> +	.irq_unmask = dw_msi_unmask_irq,
> +};
> +
> +static struct msi_domain_info dw_pcie_msi_domain_info = {
> +	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> +		     MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI),
> +	.chip	= &dw_pcie_msi_irq_chip,
> +};
> +
>  /* MSI int handler */
>  irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>  {
> @@ -81,6 +106,191 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>  	return ret;
>  }
>  
> +/* Chained MSI interrupt service routine */
> +static void dw_chained_msi_isr(struct irq_desc *desc)
> +{
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	struct pcie_port *pp;
> +	struct dw_pcie *pci;
> +
> +	chained_irq_enter(chip, desc);
> +	pci = irq_desc_get_handler_data(desc);
> +	pp = &pci->pp;
> +
> +	dw_handle_msi_irq(pp);
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static void dw_pci_setup_msi_msg(struct irq_data *data, struct msi_msg *msg)
> +{
> +	struct dw_pcie *pci = irq_data_get_irq_chip_data(data);
> +	struct pcie_port *pp = &pci->pp;
> +	u64 msi_target;
> +
> +	if (pp->ops->get_msi_addr)
> +		msi_target = pp->ops->get_msi_addr(pp);
> +	else
> +		msi_target = virt_to_phys((void *)pp->msi_data);
> +
> +	msg->address_lo = lower_32_bits(msi_target);
> +	msg->address_hi = upper_32_bits(msi_target);
> +
> +	if (pp->ops->get_msi_data)
> +		msg->data = pp->ops->get_msi_data(pp, data->hwirq);
> +	else
> +		msg->data = data->hwirq;
> +
> +	dev_dbg(pci->dev, "msi#%d address_hi %#x address_lo %#x\n",
> +		(int)data->hwirq, msg->address_hi, msg->address_lo);
> +}
> +
> +static int dw_pci_msi_set_affinity(struct irq_data *irq_data,
> +				   const struct cpumask *mask, bool force)
> +{
> +	return -EINVAL;
> +}
> +
> +static void dw_pci_bottom_mask(struct irq_data *data)
> +{
> +	struct dw_pcie *pci = irq_data_get_irq_chip_data(data);
> +	struct pcie_port *pp = &pci->pp;
> +	unsigned int res, bit, ctrl;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&pp->lock, flags);
> +
> +	if (pp->ops->msi_clear_irq)
> +		pp->ops->msi_clear_irq(pp, data->hwirq);
> +	else {
> +		ctrl = data->hwirq / 32;
> +		res = ctrl * 12;
> +		bit = data->hwirq % 32;
> +
> +		pp->irq_status[ctrl] &= ~(1 << bit);
> +		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4,
> +				    pp->irq_status[ctrl]);
> +	}
> +
> +	spin_unlock_irqrestore(&pp->lock, flags);
> +}
> +
> +static void dw_pci_bottom_unmask(struct irq_data *data)
> +{
> +	struct dw_pcie *pci = irq_data_get_irq_chip_data(data);
> +	struct pcie_port *pp = &pci->pp;
> +	unsigned int res, bit, ctrl;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&pp->lock, flags);
> +
> +	if (pp->ops->msi_set_irq)
> +		pp->ops->msi_set_irq(pp, data->hwirq);
> +	else {
> +		ctrl = data->hwirq / 32;
> +		res = ctrl * 12;
> +		bit = data->hwirq % 32;
> +
> +		pp->irq_status[ctrl] |= 1 << bit;
> +		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4,
> +				    pp->irq_status[ctrl]);
> +	}
> +
> +	spin_unlock_irqrestore(&pp->lock, flags);
> +}
> +
> +static struct irq_chip dw_pci_msi_bottom_irq_chip = {
> +	.name = "DWPCI-MSI",
> +	.irq_compose_msi_msg = dw_pci_setup_msi_msg,
> +	.irq_set_affinity = dw_pci_msi_set_affinity,
> +	.irq_mask = dw_pci_bottom_mask,
> +	.irq_unmask = dw_pci_bottom_unmask,
> +};
> +
> +static int dw_pcie_irq_domain_alloc(struct irq_domain *domain,
> +				    unsigned int virq, unsigned int nr_irqs,
> +				    void *args)
> +{
> +	struct dw_pcie *pci = domain->host_data;
> +	struct pcie_port *pp = &pci->pp;
> +	unsigned long flags;
> +	unsigned long bit;
> +	u32 i;
> +
> +	spin_lock_irqsave(&pp->lock, flags);
> +
> +	bit = bitmap_find_next_zero_area(pp->msi_irq_in_use, pp->num_vectors, 0,
> +					 nr_irqs, 0);
> +
> +	if (bit >= pp->num_vectors) {
> +		spin_unlock_irqrestore(&pp->lock, flags);
> +		return -ENOSPC;
> +	}
> +
> +	bitmap_set(pp->msi_irq_in_use, bit, nr_irqs);
> +
> +	spin_unlock_irqrestore(&pp->lock, flags);
> +
> +	for (i = 0; i < nr_irqs; i++)
> +		irq_domain_set_info(domain, virq + i, bit + i,
> +				    &dw_pci_msi_bottom_irq_chip,
> +				    domain->host_data, handle_simple_irq,
> +				    NULL, NULL);
> +
> +	return 0;
> +}
> +
> +static void dw_pcie_irq_domain_free(struct irq_domain *domain,
> +				    unsigned int virq, unsigned int nr_irqs)
> +{
> +	struct irq_data *data = irq_domain_get_irq_data(domain, virq);
> +	struct dw_pcie *pci = irq_data_get_irq_chip_data(data);
> +	struct pcie_port *pp = &pci->pp;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&pp->lock, flags);
> +	bitmap_clear(pp->msi_irq_in_use, data->hwirq, nr_irqs);
> +	spin_unlock_irqrestore(&pp->lock, flags);
> +}
> +
> +static const struct irq_domain_ops dw_pcie_msi_domain_ops = {
> +	.alloc	= dw_pcie_irq_domain_alloc,
> +	.free	= dw_pcie_irq_domain_free,
> +};
> +
> +int dw_pcie_allocate_domains(struct dw_pcie *pci)
> +{

Since this function is specific to host mode, the preferred argument should be
struct pcie_port *pp.

> +	struct pcie_port *pp = &pci->pp;
> +	struct fwnode_handle *fwnode = of_node_to_fwnode(pci->dev->of_node);
> +
> +	pp->irq_domain = irq_domain_create_linear(fwnode, pp->num_vectors,
> +					       &dw_pcie_msi_domain_ops, pci);

pp can be directly passed as host_data so that getting pp again back from pci
can be avoided in all the above functions.

Thanks
Kishon
