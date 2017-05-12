Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:26087 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932942AbdELQUu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 May 2017 12:20:50 -0400
Subject: Re: [RFC] pci: adding new interrupt api to pcie-designware
To: Joao Pinto <Joao.Pinto@synopsys.com>, <kishon@ti.com>,
        <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <marc.zyngier@arm.com>
References: <5593732728f7c7f5e8c58ac49f394e688bcc192d.1494332566.git.jpinto@synopsys.com>
CC: <linux-pci@vger.kernel.org>
From: Murali Karicheri <m-karicheri2@ti.com>
Message-ID: <5915E0F2.2070109@ti.com>
Date: Fri, 12 May 2017 12:21:06 -0400
MIME-Version: 1.0
In-Reply-To: <5593732728f7c7f5e8c58ac49f394e688bcc192d.1494332566.git.jpinto@synopsys.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/09/2017 08:33 AM, Joao Pinto wrote:
> This is a proposal for the update of the interrupt API in pcie-designware.
> 
> *SoC specific drivers*
> All SoC specific drivers that use the common infrastructure (pci-qcom,
> pci-artpec6, pci-exynos, pci-imx6) were updated to be compatible.
> Other SoC specific drivers like pci-dra7, pci-armada8k, pci-hisi, pci-spear13xx
> and pci-layerscape will also work fine.
> 
> *Work still to be done - need some inputs*
> The pci-keystone driver is the one that I would appreciate some opinions, since
> it uses the "old" dw_pcie_msi_chip. I think we have 3 options:
> 
> a) Keep the old API + new API in pcie-designware just for pci-keystone to use
> the dw_pcie_msi_chip structure
> b) Move the old API from pcie-designware to pci-keystone for it to use the
> dw_pcie_msi_chip structure
> c) Adapt pci-keystone to use the new API also
> 
> *Tests*
> I made tests with a PCI 4.80 Core IP, using pcie-designware-plat driver.
> I used an MSI-only Endpoint and a MSI/MSIX Endpoint and the APi adapted very
> well to the situation.
> 
> Signed-off-by: Joao Pinto <jpinto@synopsys.com>
> ---
>  drivers/pci/dwc/pci-exynos.c           |  18 --
>  drivers/pci/dwc/pci-imx6.c             |  18 --
>  drivers/pci/dwc/pcie-artpec6.c         |  18 --
>  drivers/pci/dwc/pcie-designware-host.c | 342 +++++++++++++++++----------------
>  drivers/pci/dwc/pcie-designware-plat.c |  15 --
>  drivers/pci/dwc/pcie-designware.h      |   6 +-
>  drivers/pci/dwc/pcie-qcom.c            |  15 --
>  7 files changed, 179 insertions(+), 253 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pci-exynos.c b/drivers/pci/dwc/pci-exynos.c
> index 546082a..e49c39a 100644
> --- a/drivers/pci/dwc/pci-exynos.c
> +++ b/drivers/pci/dwc/pci-exynos.c
> @@ -490,15 +490,6 @@ static irqreturn_t exynos_pcie_irq_handler(int irq, void *arg)
>  	return IRQ_HANDLED;
>  }
>  
> -static irqreturn_t exynos_pcie_msi_irq_handler(int irq, void *arg)
> -{
> -	struct exynos_pcie *ep = arg;
> -	struct dw_pcie *pci = ep->pci;
> -	struct pcie_port *pp = &pci->pp;
> -
> -	return dw_handle_msi_irq(pp);
> -}
> -
>  static void exynos_pcie_msi_init(struct exynos_pcie *ep)
>  {
>  	struct dw_pcie *pci = ep->pci;
> @@ -622,15 +613,6 @@ static int __init exynos_add_pcie_port(struct exynos_pcie *ep,
>  			dev_err(dev, "failed to get msi irq\n");
>  			return -ENODEV;
>  		}
> -
> -		ret = devm_request_irq(dev, pp->msi_irq,
> -					exynos_pcie_msi_irq_handler,
> -					IRQF_SHARED | IRQF_NO_THREAD,
> -					"exynos-pcie", ep);
> -		if (ret) {
> -			dev_err(dev, "failed to request msi irq\n");
> -			return ret;
> -		}
>  	}
>  
>  	pp->root_bus_nr = -1;
> diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
> index a98cba5..f22ce1f 100644
> --- a/drivers/pci/dwc/pci-imx6.c
> +++ b/drivers/pci/dwc/pci-imx6.c
> @@ -490,15 +490,6 @@ static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
>  	return -EINVAL;
>  }
>  
> -static irqreturn_t imx6_pcie_msi_handler(int irq, void *arg)
> -{
> -	struct imx6_pcie *imx6_pcie = arg;
> -	struct dw_pcie *pci = imx6_pcie->pci;
> -	struct pcie_port *pp = &pci->pp;
> -
> -	return dw_handle_msi_irq(pp);
> -}
> -
>  static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
>  {
>  	struct dw_pcie *pci = imx6_pcie->pci;
> @@ -620,15 +611,6 @@ static int imx6_add_pcie_port(struct imx6_pcie *imx6_pcie,
>  			dev_err(dev, "failed to get MSI irq\n");
>  			return -ENODEV;
>  		}
> -
> -		ret = devm_request_irq(dev, pp->msi_irq,
> -				       imx6_pcie_msi_handler,
> -				       IRQF_SHARED | IRQF_NO_THREAD,
> -				       "mx6-pcie-msi", imx6_pcie);
> -		if (ret) {
> -			dev_err(dev, "failed to request MSI irq\n");
> -			return ret;
> -		}
>  	}
>  
>  	pp->root_bus_nr = -1;
> diff --git a/drivers/pci/dwc/pcie-artpec6.c b/drivers/pci/dwc/pcie-artpec6.c
> index 82a04ac..d81789b 100644
> --- a/drivers/pci/dwc/pcie-artpec6.c
> +++ b/drivers/pci/dwc/pcie-artpec6.c
> @@ -188,15 +188,6 @@ static struct dw_pcie_host_ops artpec6_pcie_host_ops = {
>  	.host_init = artpec6_pcie_host_init,
>  };
>  
> -static irqreturn_t artpec6_pcie_msi_handler(int irq, void *arg)
> -{
> -	struct artpec6_pcie *artpec6_pcie = arg;
> -	struct dw_pcie *pci = artpec6_pcie->pci;
> -	struct pcie_port *pp = &pci->pp;
> -
> -	return dw_handle_msi_irq(pp);
> -}
> -
>  static int artpec6_add_pcie_port(struct artpec6_pcie *artpec6_pcie,
>  				 struct platform_device *pdev)
>  {
> @@ -211,15 +202,6 @@ static int artpec6_add_pcie_port(struct artpec6_pcie *artpec6_pcie,
>  			dev_err(dev, "failed to get MSI irq\n");
>  			return -ENODEV;
>  		}
> -
> -		ret = devm_request_irq(dev, pp->msi_irq,
> -				       artpec6_pcie_msi_handler,
> -				       IRQF_SHARED | IRQF_NO_THREAD,
> -				       "artpec6-pcie-msi", artpec6_pcie);
> -		if (ret) {
> -			dev_err(dev, "failed to request MSI irq\n");
> -			return ret;
> -		}
>  	}
>  
>  	pp->root_bus_nr = -1;
> diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
> index 28ed32b..4b62315 100644
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
> @@ -45,40 +46,65 @@ static int dw_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
>  	return dw_pcie_write(pci->dbi_base + where, size, val);
>  }
>  
> +static void dw_msi_mask_irq(struct irq_data *d) {
> +	pci_msi_mask_irq(d);
> +	irq_chip_mask_parent(d);
> +}
> +
> +static void dw_msi_unmask_irq(struct irq_data *d) {
> +	pci_msi_unmask_irq(d);
> +	irq_chip_unmask_parent(d);
> +}
> +
>  static struct irq_chip dw_msi_irq_chip = {
>  	.name = "PCI-MSI",
> -	.irq_enable = pci_msi_unmask_irq,
> -	.irq_disable = pci_msi_mask_irq,
> -	.irq_mask = pci_msi_mask_irq,
> -	.irq_unmask = pci_msi_unmask_irq,
> +	.irq_mask = dw_msi_mask_irq,
> +	.irq_unmask = dw_msi_unmask_irq,
> +};
> +
> +static struct msi_domain_info dw_pcie_msi_domain_info = {
> +	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> +		     MSI_FLAG_PCI_MSIX),
> +	.chip	= &dw_msi_irq_chip,
>  };
>  
> -/* MSI int handler */
> -irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
> +void dw_handle_msi_irq(struct pcie_port *pp)
>  {
> -	u32 val;
> -	int i, pos, irq;
> -	irqreturn_t ret = IRQ_NONE;
> +	int i, pos, virq;
> +	u32 status;
>  
>  	for (i = 0; i < MAX_MSI_CTRLS; i++) {
>  		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_STATUS + i * 12, 4,
> -				    &val);
> -		if (!val)
> +				    &status);
> +		if (!status)
>  			continue;
>  
> -		ret = IRQ_HANDLED;
>  		pos = 0;
> -		while ((pos = find_next_bit((unsigned long *) &val, 32,
> +		while ((pos = find_next_bit((unsigned long *) &status, 32,
>  					    pos)) != 32) {
> -			irq = irq_find_mapping(pp->irq_domain, i * 32 + pos);
> +			virq = irq_find_mapping(pp->irq_domain, i * 32 + pos);
>  			dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + i * 12,
>  					    4, 1 << pos);
> -			generic_handle_irq(irq);
> +			generic_handle_irq(virq);
>  			pos++;
>  		}
>  	}
> +}
>  
> -	return ret;
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
>  }
>  
>  void dw_pcie_msi_init(struct pcie_port *pp)
> @@ -95,183 +121,163 @@ void dw_pcie_msi_init(struct pcie_port *pp)
>  			    (u32)(msi_target >> 32 & 0xffffffff));
>  }
>  
> -static void dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
> +static void dw_pci_setup_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  {
> -	unsigned int res, bit, val;
> +	struct dw_pcie *pci = irq_data_get_irq_chip_data(data);
> +	struct pcie_port *pp = &pci->pp;
> +	u64 msi_target;
>  
> -	res = (irq / 32) * 12;
> -	bit = irq % 32;
> -	dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, &val);
> -	val &= ~(1 << bit);
> -	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, val);
> -}
> +	if (pp->ops->get_msi_addr)
> +		msi_target = pp->ops->get_msi_addr(pp);
> +	else
> +		msi_target = virt_to_phys((void *)pp->msi_data);
>  
> -static void clear_irq_range(struct pcie_port *pp, unsigned int irq_base,
> -			    unsigned int nvec, unsigned int pos)
> -{
> -	unsigned int i;
> -
> -	for (i = 0; i < nvec; i++) {
> -		irq_set_msi_desc_off(irq_base, i, NULL);
> -		/* Disable corresponding interrupt on MSI controller */
> -		if (pp->ops->msi_clear_irq)
> -			pp->ops->msi_clear_irq(pp, pos + i);
> -		else
> -			dw_pcie_msi_clear_irq(pp, pos + i);
> -	}
> +	msg->address_lo = (u32)(msi_target & 0xffffffff);
> +	msg->address_hi = (u32)(msi_target >> 32 & 0xffffffff);
>  
> -	bitmap_release_region(pp->msi_irq_in_use, pos, order_base_2(nvec));
> +	if (pp->ops->get_msi_data)
> +		msg->data = pp->ops->get_msi_data(pp, data->hwirq);
> +	else
> +		msg->data = data->hwirq;
> +
> +	dev_err(pci->dev, "msi#%d address_hi %#x address_lo %#x\n",
> +		(int)data->hwirq, msg->address_hi, msg->address_lo);
>  }
>  
> -static void dw_pcie_msi_set_irq(struct pcie_port *pp, int irq)
> +static int dw_pci_msi_set_affinity(struct irq_data *irq_data,
> +				   const struct cpumask *mask, bool force)
>  {
> -	unsigned int res, bit, val;
> -
> -	res = (irq / 32) * 12;
> -	bit = irq % 32;
> -	dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, &val);
> -	val |= 1 << bit;
> -	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, val);
> +	return -EINVAL;
>  }
>  
> -static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
> +static void dw_pci_bottom_mask(struct irq_data *data)
>  {
> -	int irq, pos0, i;
> -	struct pcie_port *pp;
> -
> -	pp = (struct pcie_port *)msi_desc_to_pci_sysdata(desc);
> -	pos0 = bitmap_find_free_region(pp->msi_irq_in_use, MAX_MSI_IRQS,
> -				       order_base_2(no_irqs));
> -	if (pos0 < 0)
> -		goto no_valid_irq;
> -
> -	irq = irq_find_mapping(pp->irq_domain, pos0);
> -	if (!irq)
> -		goto no_valid_irq;
> -
> -	/*
> -	 * irq_create_mapping (called from dw_pcie_host_init) pre-allocates
> -	 * descs so there is no need to allocate descs here. We can therefore
> -	 * assume that if irq_find_mapping above returns non-zero, then the
> -	 * descs are also successfully allocated.
> -	 */
> +	struct dw_pcie *pci = irq_data_get_irq_chip_data(data);
> +	struct pcie_port *pp = &pci->pp;
> +	unsigned int res, bit, val;
>  
> -	for (i = 0; i < no_irqs; i++) {
> -		if (irq_set_msi_desc_off(irq, i, desc) != 0) {
> -			clear_irq_range(pp, irq, i, pos0);
> -			goto no_valid_irq;
> -		}
> -		/*Enable corresponding interrupt in MSI interrupt controller */
> -		if (pp->ops->msi_set_irq)
> -			pp->ops->msi_set_irq(pp, pos0 + i);
> -		else
> -			dw_pcie_msi_set_irq(pp, pos0 + i);
> -	}
> +	mutex_lock(&pp->lock);
>  
> -	*pos = pos0;
> -	desc->nvec_used = no_irqs;
> -	desc->msi_attrib.multiple = order_base_2(no_irqs);
> +	res = (data->hwirq / 32) * 12;
> +	bit = data->hwirq % 32;
>  
> -	return irq;
> +	dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, &val);
> +	val &= ~(1 << bit);
> +	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, val);
>  
> -no_valid_irq:
> -	*pos = pos0;
> -	return -ENOSPC;
> +	mutex_unlock(&pp->lock);
>  }
>  
> -static void dw_msi_setup_msg(struct pcie_port *pp, unsigned int irq, u32 pos)
> +static void dw_pci_bottom_unmask(struct irq_data *data)
>  {
> -	struct msi_msg msg;
> -	u64 msi_target;
> +	struct dw_pcie *pci = irq_data_get_irq_chip_data(data);
> +	struct pcie_port *pp = &pci->pp;
> +	unsigned int res, bit, val;
>  
> -	if (pp->ops->get_msi_addr)
> -		msi_target = pp->ops->get_msi_addr(pp);
> -	else
> -		msi_target = virt_to_phys((void *)pp->msi_data);
> +	mutex_lock(&pp->lock);
>  
> -	msg.address_lo = (u32)(msi_target & 0xffffffff);
> -	msg.address_hi = (u32)(msi_target >> 32 & 0xffffffff);
> +	res = (data->hwirq / 32) * 12;
> +	bit = data->hwirq % 32;
>  
> -	if (pp->ops->get_msi_data)
> -		msg.data = pp->ops->get_msi_data(pp, pos);
> -	else
> -		msg.data = pos;
> +	dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, &val);
> +	val |= 1 << bit;
> +	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, val);
>  
> -	pci_write_msi_msg(irq, &msg);
> +	mutex_unlock(&pp->lock);
>  }
>  
> -static int dw_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
> -			    struct msi_desc *desc)
> -{
> -	int irq, pos;
> -	struct pcie_port *pp = pdev->bus->sysdata;
> -
> -	if (desc->msi_attrib.is_msix)
> -		return -EINVAL;
> -
> -	irq = assign_irq(1, desc, &pos);
> -	if (irq < 0)
> -		return irq;
> +static struct irq_chip dw_pci_msi_bottom_irq_chip = {
> +	.name			= "DW MSI",
> +	.irq_compose_msi_msg	= dw_pci_setup_msi_msg,
> +	.irq_set_affinity	= dw_pci_msi_set_affinity,
> +	.irq_mask		= dw_pci_bottom_mask,
> +	.irq_unmask		= dw_pci_bottom_unmask,
> +};
>  
> -	dw_msi_setup_msg(pp, irq, pos);
> +static int dw_pcie_irq_domain_alloc(struct irq_domain *domain,
> +				    unsigned int virq, unsigned int nr_irqs,
> +				    void *args)
> +{
> +	struct dw_pcie *pci = domain->host_data;
> +	struct pcie_port *pp = &pci->pp;
> +	unsigned long bit;
>  
> -	return 0;
> -}
> +	mutex_lock(&pp->lock);
>  
> -static int dw_msi_setup_irqs(struct msi_controller *chip, struct pci_dev *pdev,
> -			     int nvec, int type)
> -{
> -#ifdef CONFIG_PCI_MSI
> -	int irq, pos;
> -	struct msi_desc *desc;
> -	struct pcie_port *pp = pdev->bus->sysdata;
> +	WARN_ON(nr_irqs != 1);
>  
> -	/* MSI-X interrupts are not supported */
> -	if (type == PCI_CAP_ID_MSIX)
> -		return -EINVAL;
> +	bit = find_first_zero_bit(pp->msi_irq_in_use, pp->num_vectors);
> +	if (bit >= pp->num_vectors) {
> +		mutex_unlock(&pp->lock);
> +		return -ENOSPC;
> +	}
>  
> -	WARN_ON(!list_is_singular(&pdev->dev.msi_list));
> -	desc = list_entry(pdev->dev.msi_list.next, struct msi_desc, list);
> +	set_bit(bit, pp->msi_irq_in_use);
>  
> -	irq = assign_irq(nvec, desc, &pos);
> -	if (irq < 0)
> -		return irq;
> +	mutex_unlock(&pp->lock);
>  
> -	dw_msi_setup_msg(pp, irq, pos);
> +	irq_domain_set_info(domain, virq, bit, &dw_pci_msi_bottom_irq_chip,
> +			    domain->host_data, handle_simple_irq,
> +			    NULL, NULL);
>  
>  	return 0;
> -#else
> -	return -EINVAL;
> -#endif
>  }
>  
> -static void dw_msi_teardown_irq(struct msi_controller *chip, unsigned int irq)
> +static void dw_pcie_irq_domain_free(struct irq_domain *domain,
> +				    unsigned int virq, unsigned int nr_irqs)
>  {
> -	struct irq_data *data = irq_get_irq_data(irq);
> -	struct msi_desc *msi = irq_data_get_msi_desc(data);
> -	struct pcie_port *pp = (struct pcie_port *)msi_desc_to_pci_sysdata(msi);
> +	struct irq_data *data = irq_domain_get_irq_data(domain, virq);
> +	struct dw_pcie *pci = irq_data_get_irq_chip_data(data);
> +	struct pcie_port *pp = &pci->pp;
> +
> +	mutex_lock(&pp->lock);
>  
> -	clear_irq_range(pp, irq, 1, data->hwirq);
> +	if (!test_bit(data->hwirq, pp->msi_irq_in_use))
> +		dev_err(pci->dev, "trying to free unused MSI#%lu\n",
> +			data->hwirq);
> +	else
> +		__clear_bit(data->hwirq, pp->msi_irq_in_use);
> +
> +	mutex_unlock(&pp->lock);
>  }
>  
> -static struct msi_controller dw_pcie_msi_chip = {
> -	.setup_irq = dw_msi_setup_irq,
> -	.setup_irqs = dw_msi_setup_irqs,
> -	.teardown_irq = dw_msi_teardown_irq,
> +static const struct irq_domain_ops dw_pcie_msi_domain_ops = {
> +	.alloc	= dw_pcie_irq_domain_alloc,
> +	.free	= dw_pcie_irq_domain_free,
>  };
>  
> -static int dw_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
> -			   irq_hw_number_t hwirq)
> +static int dw_pcie_allocate_domains(struct dw_pcie *pci)
>  {
> -	irq_set_chip_and_handler(irq, &dw_msi_irq_chip, handle_simple_irq);
> -	irq_set_chip_data(irq, domain->host_data);
> +	struct pcie_port *pp = &pci->pp;
> +	struct fwnode_handle *fwnode = of_node_to_fwnode(pci->dev->of_node);
> +
> +	pp->irq_domain = irq_domain_add_linear(NULL, pp->num_vectors,
> +					       &dw_pcie_msi_domain_ops, pci);
> +	if (!pp->irq_domain) {
> +		dev_err(pci->dev, "failed to create IRQ domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	pp->msi_domain = pci_msi_create_irq_domain(fwnode,
> +						   &dw_pcie_msi_domain_info,
> +						   pp->irq_domain);
> +	if (!pp->msi_domain) {
> +		dev_err(pci->dev, "failed to create MSI domain\n");
> +		irq_domain_remove(pp->irq_domain);
> +		return -ENOMEM;
> +	}
>  
>  	return 0;
>  }
>  
> -static const struct irq_domain_ops msi_domain_ops = {
> -	.map = dw_pcie_msi_map,
> -};
> +void dw_pcie_free_msi(struct pcie_port *pp)
> +{
> +	irq_set_chained_handler(pp->msi_irq, NULL);
> +	irq_set_handler_data(pp->msi_irq, NULL);
> +
> +	irq_domain_remove(pp->msi_domain);
> +	irq_domain_remove(pp->irq_domain);
> +}
>  
>  int dw_pcie_host_init(struct pcie_port *pp)
>  {
> @@ -279,11 +285,13 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	struct device *dev = pci->dev;
>  	struct device_node *np = dev->of_node;
>  	struct platform_device *pdev = to_platform_device(dev);
> +	struct resource_entry *win, *tmp;
>  	struct pci_bus *bus, *child;
>  	struct resource *cfg_res;
> -	int i, ret;
> +	int ret;
>  	LIST_HEAD(res);
> -	struct resource_entry *win, *tmp;
> +
> +	mutex_init(&pci->pp.lock);
>  
>  	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
>  	if (cfg_res) {
> @@ -377,20 +385,22 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  		pci->num_viewport = 2;
>  
>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		ret = of_property_read_u32(np, "num-vectors",
> +					   &pp->num_vectors);
> +		if (ret)
> +			pp->num_vectors = 1;
> +
>  		if (!pp->ops->msi_host_init) {
> -			pp->irq_domain = irq_domain_add_linear(dev->of_node,
> -						MAX_MSI_IRQS, &msi_domain_ops,
> -						&dw_pcie_msi_chip);
> -			if (!pp->irq_domain) {
> -				dev_err(dev, "irq domain init failed\n");
> -				ret = -ENXIO;
> +			ret = dw_pcie_allocate_domains(pci);
> +			if (ret)
>  				goto error;
> -			}
>  
> -			for (i = 0; i < MAX_MSI_IRQS; i++)
> -				irq_create_mapping(pp->irq_domain, i);
> +			irq_set_chained_handler_and_data(pci->pp.msi_irq,
> +							 dw_chained_msi_isr,
> +							 pci);
>  		} else {
> -			ret = pp->ops->msi_host_init(pp, &dw_pcie_msi_chip);
> +			//TODO
> +			ret = 0;//pp->ops->msi_host_init(pp, &dw_pcie_msi_chip);
>  			if (ret < 0)
>  				goto error;
>  		}
> @@ -400,14 +410,10 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  		pp->ops->host_init(pp);
>  
>  	pp->root_bus_nr = pp->busn->start;
> -	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -		bus = pci_scan_root_bus_msi(dev, pp->root_bus_nr,
> -					    &dw_pcie_ops, pp, &res,
> -					    &dw_pcie_msi_chip);
> -		dw_pcie_msi_chip.dev = dev;
> -	} else
> -		bus = pci_scan_root_bus(dev, pp->root_bus_nr, &dw_pcie_ops,
> -					pp, &res);
> +
> +	bus = pci_scan_root_bus(dev, pp->root_bus_nr, &dw_pcie_ops,
> +				pp, &res);
> +
>  	if (!bus) {
>  		ret = -ENOMEM;
>  		goto error;
> diff --git a/drivers/pci/dwc/pcie-designware-plat.c b/drivers/pci/dwc/pcie-designware-plat.c
> index 32091b3..3b9717b 100644
> --- a/drivers/pci/dwc/pcie-designware-plat.c
> +++ b/drivers/pci/dwc/pcie-designware-plat.c
> @@ -28,13 +28,6 @@ struct dw_plat_pcie {
>  	struct dw_pcie		*pci;
>  };
>  
> -static irqreturn_t dw_plat_pcie_msi_irq_handler(int irq, void *arg)
> -{
> -	struct pcie_port *pp = arg;
> -
> -	return dw_handle_msi_irq(pp);
> -}
> -
>  static void dw_plat_pcie_host_init(struct pcie_port *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -64,14 +57,6 @@ static int dw_plat_add_pcie_port(struct pcie_port *pp,
>  		pp->msi_irq = platform_get_irq(pdev, 0);
>  		if (pp->msi_irq < 0)
>  			return pp->msi_irq;
> -
> -		ret = devm_request_irq(dev, pp->msi_irq,
> -					dw_plat_pcie_msi_irq_handler,
> -					IRQF_SHARED, "dw-plat-pcie-msi", pp);
> -		if (ret) {
> -			dev_err(dev, "failed to request MSI IRQ\n");
> -			return ret;
> -		}
>  	}
>  
>  	pp->root_bus_nr = -1;
> diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
> index c6a8405..3abd229 100644
> --- a/drivers/pci/dwc/pcie-designware.h
> +++ b/drivers/pci/dwc/pcie-designware.h
> @@ -165,7 +165,10 @@ struct pcie_port {
>  	struct dw_pcie_host_ops	*ops;
>  	int			msi_irq;
>  	struct irq_domain	*irq_domain;
> +	struct irq_domain	*msi_domain;
>  	unsigned long		msi_data;
> +	u32			num_vectors;
> +	struct mutex		lock;
>  	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
>  };
>  
> @@ -280,7 +283,8 @@ static inline u32 dw_pcie_readl_dbi2(struct dw_pcie *pci, u32 reg)
>  }
>  
>  #ifdef CONFIG_PCIE_DW_HOST
> -irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);
> +void dw_handle_msi_irq(struct pcie_port *pp);
> +void dw_pcie_free_msi(struct pcie_port *pp);
>  void dw_pcie_msi_init(struct pcie_port *pp);
>  void dw_pcie_setup_rc(struct pcie_port *pp);
>  int dw_pcie_host_init(struct pcie_port *pp);
> diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
> index 5bf23d4..4e1cc02 100644
> --- a/drivers/pci/dwc/pcie-qcom.c
> +++ b/drivers/pci/dwc/pcie-qcom.c
> @@ -126,13 +126,6 @@ static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
>  	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
>  }
>  
> -static irqreturn_t qcom_pcie_msi_irq_handler(int irq, void *arg)
> -{
> -	struct pcie_port *pp = arg;
> -
> -	return dw_handle_msi_irq(pp);
> -}
> -
>  static void qcom_pcie_v0_v1_ltssm_enable(struct qcom_pcie *pcie)
>  {
>  	u32 val;
> @@ -724,14 +717,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
>  		if (pp->msi_irq < 0)
>  			return pp->msi_irq;
> -
> -		ret = devm_request_irq(dev, pp->msi_irq,
> -				       qcom_pcie_msi_irq_handler,
> -				       IRQF_SHARED, "qcom-pcie-msi", pp);
> -		if (ret) {
> -			dev_err(dev, "cannot request msi irq\n");
> -			return ret;
> -		}
>  	}
>  
>  	ret = phy_init(pcie->phy);
> 
Joao,

What do you see the challenge in porting the PCI-Keystone driver to the new
interrupt API (option c)? I haven't had a chance to review your patches and recent
changes in Linux kernel for PCI as we are currently using v4.9 kernel for
our platforms. One key difference in the PCI Core used in Keystone SoC is that
the MSI is not implemented using standard registers as in newer PCI Designware
core. It uses application register space for MSI interrupts. Given that
is the case, do you see any issue in porting the driver to the new API?

I should be able to test your patch on Keystone.

-- 
Murali Karicheri
Linux Kernel, Keystone
