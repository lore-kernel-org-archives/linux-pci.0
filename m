Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 2/2] PCI: mediatek: Using chained IRQ to setup IRQ handle
To: honghui.zhang@mediatek.com, lorenzo.pieralisi@arm.com,
 bhelgaas@google.com, matthias.bgg@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, yingjoe.chen@mediatek.com,
 eddie.huang@mediatek.com, ryder.lee@mediatek.com
References: <1524201910-22836-1-git-send-email-honghui.zhang@mediatek.com>
 <1524201910-22836-3-git-send-email-honghui.zhang@mediatek.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <a2f7e70a-fdef-d925-8838-be3051c2e96d@arm.com>
Date: Mon, 30 Apr 2018 12:03:07 +0100
MIME-Version: 1.0
In-Reply-To: <1524201910-22836-3-git-send-email-honghui.zhang@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: youlin.pei@mediatek.com, hongkun.cao@mediatek.com, sean.wang@mediatek.com,
 yong.wu@mediatek.com, yt.shen@mediatek.com, xinping.qian@mediatek.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Zhang,

On 20/04/18 06:25, honghui.zhang@mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> Using irq_chip solution to setup IRQs for the consistent with IRQ framework.
> 
> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> ---
>  drivers/pci/host/pcie-mediatek.c | 192 +++++++++++++++++++++------------------
>  1 file changed, 105 insertions(+), 87 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
> index c3dc549..1d9c6f1 100644
> --- a/drivers/pci/host/pcie-mediatek.c
> +++ b/drivers/pci/host/pcie-mediatek.c
> @@ -11,8 +11,10 @@
>  #include <linux/delay.h>
>  #include <linux/iopoll.h>
>  #include <linux/irq.h>
> +#include <linux/irqchip/chained_irq.h>
>  #include <linux/irqdomain.h>
>  #include <linux/kernel.h>
> +#include <linux/msi.h>
>  #include <linux/of_address.h>
>  #include <linux/of_pci.h>
>  #include <linux/of_platform.h>
> @@ -130,14 +132,12 @@ struct mtk_pcie_port;
>  /**
>   * struct mtk_pcie_soc - differentiate between host generations
>   * @need_fix_class_id: whether this host's class ID needed to be fixed or not
> - * @has_msi: whether this host supports MSI interrupts or not
>   * @ops: pointer to configuration access functions
>   * @startup: pointer to controller setting functions
>   * @setup_irq: pointer to initialize IRQ functions
>   */
>  struct mtk_pcie_soc {
>  	bool need_fix_class_id;
> -	bool has_msi;
>  	struct pci_ops *ops;
>  	int (*startup)(struct mtk_pcie_port *port);
>  	int (*setup_irq)(struct mtk_pcie_port *port, struct device_node *node);
> @@ -161,7 +161,9 @@ struct mtk_pcie_soc {
>   * @lane: lane count
>   * @slot: port slot
>   * @irq_domain: legacy INTx IRQ domain
> + * @inner_domain: inner IRQ domain
>   * @msi_domain: MSI IRQ domain
> + * @lock: protect the msi_irq_in_use bitmap
>   * @msi_irq_in_use: bit map for assigned MSI IRQ
>   */
>  struct mtk_pcie_port {
> @@ -179,7 +181,9 @@ struct mtk_pcie_port {
>  	u32 lane;
>  	u32 slot;
>  	struct irq_domain *irq_domain;
> +	struct irq_domain *inner_domain;
>  	struct irq_domain *msi_domain;
> +	struct mutex lock;
>  	DECLARE_BITMAP(msi_irq_in_use, MTK_MSI_IRQS_NUM);
>  };
>  
> @@ -446,103 +450,122 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
>  	return 0;
>  }
>  
> -static int mtk_pcie_msi_alloc(struct mtk_pcie_port *port)
> +static void mtk_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  {
> -	int msi;
> +	struct mtk_pcie_port *port = irq_data_get_irq_chip_data(data);
> +	phys_addr_t addr;
>  
> -	msi = find_first_zero_bit(port->msi_irq_in_use, MTK_MSI_IRQS_NUM);
> -	if (msi < MTK_MSI_IRQS_NUM)
> -		set_bit(msi, port->msi_irq_in_use);
> -	else
> -		return -ENOSPC;
> +	/* MT2712/MT7622 only support 32-bit MSI addresses */
> +	addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);
> +	msg->address_hi = 0;
> +	msg->address_lo = lower_32_bits(addr);
>  
> -	return msi;
> +	msg->data = data->hwirq;
> +
> +	dev_dbg(port->pcie->dev, "msi#%d address_hi %#x address_lo %#x\n",
> +		(int)data->hwirq, msg->address_hi, msg->address_lo);
>  }
>  
> -static void mtk_pcie_msi_free(struct mtk_pcie_port *port, unsigned long hwirq)
> +static int mtk_msi_set_affinity(struct irq_data *irq_data,
> +				   const struct cpumask *mask, bool force)
>  {
> -	clear_bit(hwirq, port->msi_irq_in_use);
> +	return -EINVAL;
>  }
>  
> -static int mtk_pcie_msi_setup_irq(struct msi_controller *chip,
> -				  struct pci_dev *pdev, struct msi_desc *desc)
> -{
> -	struct mtk_pcie_port *port;
> -	struct msi_msg msg;
> -	unsigned int irq;
> -	int hwirq;
> -	phys_addr_t msg_addr;
> +static struct irq_chip mtk_msi_bottom_irq_chip = {
> +	.name			= "MTK MSI",
> +	.irq_compose_msi_msg	= mtk_compose_msi_msg,
> +	.irq_set_affinity	= mtk_msi_set_affinity,
> +	.irq_mask		= pci_msi_mask_irq,
> +	.irq_unmask	= pci_msi_unmask_irq,
> +};
>  
> -	port = mtk_pcie_find_port(pdev->bus, pdev->devfn);
> -	if (!port)
> -		return -EINVAL;
> +static int mtk_pcie_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> +				     unsigned int nr_irqs, void *args)
> +{
> +	struct mtk_pcie_port *port = domain->host_data;
> +	unsigned long bit;
>  
> -	hwirq = mtk_pcie_msi_alloc(port);
> -	if (hwirq < 0)
> -		return hwirq;
> +	WARN_ON(nr_irqs != 1);
> +	mutex_lock(&port->lock);
>  
> -	irq = irq_create_mapping(port->msi_domain, hwirq);
> -	if (!irq) {
> -		mtk_pcie_msi_free(port, hwirq);
> -		return -EINVAL;
> +	bit = find_first_zero_bit(port->msi_irq_in_use, MTK_MSI_IRQS_NUM);
> +	if (bit >= MTK_MSI_IRQS_NUM) {
> +		mutex_unlock(&port->lock);
> +		return -ENOSPC;
>  	}
>  
> -	chip->dev = &pdev->dev;
> -
> -	irq_set_msi_desc(irq, desc);
> +	__set_bit(bit, port->msi_irq_in_use);
>  
> -	/* MT2712/MT7622 only support 32-bit MSI addresses */
> -	msg_addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);
> -	msg.address_hi = 0;
> -	msg.address_lo = lower_32_bits(msg_addr);
> -	msg.data = hwirq;
> +	mutex_unlock(&port->lock);
>  
> -	pci_write_msi_msg(irq, &msg);
> +	irq_domain_set_info(domain, virq, bit, &mtk_msi_bottom_irq_chip,
> +			    domain->host_data, handle_simple_irq,

Why don't you handle the interrupt as an edge interrupt
(handle_edge_irq)? That's what it really is, and the fact that you use
"handle_simple_irq" makes me think that wou're papering over some other
issue (see below).

> +			    NULL, NULL);
>  
>  	return 0;
>  }
>  
> -static void mtk_msi_teardown_irq(struct msi_controller *chip, unsigned int irq)
> +static void mtk_pcie_irq_domain_free(struct irq_domain *domain,
> +				     unsigned int virq, unsigned int nr_irqs)
>  {
> -	struct pci_dev *pdev = to_pci_dev(chip->dev);
> -	struct irq_data *d = irq_get_irq_data(irq);
> -	irq_hw_number_t hwirq = irqd_to_hwirq(d);
> -	struct mtk_pcie_port *port;
> +	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
> +	struct mtk_pcie_port *port = irq_data_get_irq_chip_data(d);
>  
> -	port = mtk_pcie_find_port(pdev->bus, pdev->devfn);
> -	if (!port)
> -		return;
> +	mutex_lock(&port->lock);
> +
> +	if (!test_bit(d->hwirq, port->msi_irq_in_use))
> +		dev_err(port->pcie->dev, "trying to free unused MSI#%lu\n",
> +			d->hwirq);
> +	else
> +		__clear_bit(d->hwirq, port->msi_irq_in_use);
>  
> -	irq_dispose_mapping(irq);
> -	mtk_pcie_msi_free(port, hwirq);
> +	mutex_unlock(&port->lock);
> +
> +	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
>  }
>  
> -static struct msi_controller mtk_pcie_msi_chip = {
> -	.setup_irq = mtk_pcie_msi_setup_irq,
> -	.teardown_irq = mtk_msi_teardown_irq,
> +static const struct irq_domain_ops msi_domain_ops = {
> +	.alloc	= mtk_pcie_irq_domain_alloc,
> +	.free	= mtk_pcie_irq_domain_free,
>  };
>  
>  static struct irq_chip mtk_msi_irq_chip = {
>  	.name = "MTK PCIe MSI",
> -	.irq_enable = pci_msi_unmask_irq,
> -	.irq_disable = pci_msi_mask_irq,
>  	.irq_mask = pci_msi_mask_irq,
>  	.irq_unmask = pci_msi_unmask_irq,
>  };
>  
> -static int mtk_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
> -			    irq_hw_number_t hwirq)
> +static struct msi_domain_info mtk_msi_domain_info = {
> +	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> +		   MSI_FLAG_PCI_MSIX),
> +	.chip	= &mtk_msi_irq_chip,
> +};
> +
> +static int mtk_pcie_allocate_msi_domains(struct mtk_pcie_port *port)
>  {
> -	irq_set_chip_and_handler(irq, &mtk_msi_irq_chip, handle_simple_irq);
> -	irq_set_chip_data(irq, domain->host_data);
> +	struct fwnode_handle *fwnode = of_node_to_fwnode(port->pcie->dev->of_node);
> +
> +	mutex_init(&port->lock);
> +
> +	port->inner_domain = irq_domain_create_linear(fwnode, MTK_MSI_IRQS_NUM,
> +						      &msi_domain_ops, port);
> +	if (!port->inner_domain) {
> +		dev_err(port->pcie->dev, "failed to create IRQ domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	port->msi_domain = pci_msi_create_irq_domain(fwnode, &mtk_msi_domain_info,
> +						     port->inner_domain);
> +	if (!port->msi_domain) {
> +		dev_err(port->pcie->dev, "failed to create MSI domain\n");
> +		irq_domain_remove(port->inner_domain);
> +		return -ENOMEM;
> +	}
>  
>  	return 0;
>  }
>  
> -static const struct irq_domain_ops msi_domain_ops = {
> -	.map = mtk_pcie_msi_map,
> -};
> -
>  static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
>  {
>  	u32 val;
> @@ -575,6 +598,7 @@ static int mtk_pcie_init_irq_domain(struct mtk_pcie_port *port,
>  {
>  	struct device *dev = port->pcie->dev;
>  	struct device_node *pcie_intc_node;
> +	int ret;
>  
>  	/* Setup INTx */
>  	pcie_intc_node = of_get_next_child(node, NULL);
> @@ -591,27 +615,28 @@ static int mtk_pcie_init_irq_domain(struct mtk_pcie_port *port,
>  	}
>  
>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -		port->msi_domain = irq_domain_add_linear(node, MTK_MSI_IRQS_NUM,
> -							 &msi_domain_ops,
> -							 &mtk_pcie_msi_chip);
> -		if (!port->msi_domain) {
> -			dev_err(dev, "failed to create MSI IRQ domain\n");
> -			return -ENODEV;
> -		}
> +		ret = mtk_pcie_allocate_msi_domains(port);
> +		if (ret)
> +			return ret;
> +
>  		mtk_pcie_enable_msi(port);
>  	}
>  
>  	return 0;
>  }
>  
> -static irqreturn_t mtk_pcie_intr_handler(int irq, void *data)
> +static void mtk_pcie_intr_handler(struct irq_desc *desc)
>  {
> -	struct mtk_pcie_port *port = (struct mtk_pcie_port *)data;
> +	struct mtk_pcie_port *port = irq_desc_get_handler_data(desc);
> +	struct irq_chip *irqchip = irq_desc_get_chip(desc);
>  	unsigned long status;
>  	u32 virq;
>  	u32 bit = INTX_SHIFT;
>  
> -	while ((status = readl(port->base + PCIE_INT_STATUS)) & INTX_MASK) {
> +	chained_irq_enter(irqchip, desc);
> +
> +	status = readl(port->base + PCIE_INT_STATUS);
> +	if (status & INTX_MASK) {
>  		for_each_set_bit_from(bit, &status, PCI_NUM_INTX + INTX_SHIFT) {
>  			/* Clear the INTx */
>  			writel(1 << bit, port->base + PCIE_INT_STATUS);
> @@ -622,14 +647,14 @@ static irqreturn_t mtk_pcie_intr_handler(int irq, void *data)
>  	}
>  
>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -		while ((status = readl(port->base + PCIE_INT_STATUS)) & MSI_STATUS) {
> +		if (status & MSI_STATUS) {
>  			unsigned long imsi_status;
>  
>  			while ((imsi_status = readl(port->base + PCIE_IMSI_STATUS))) {
>  				for_each_set_bit(bit, &imsi_status, MTK_MSI_IRQS_NUM) {
>  					/* Clear the MSI */
>  					writel(1 << bit, port->base + PCIE_IMSI_STATUS);

This write suspiciously looks like an "ack" operation on the controller.
Why isn't it part of the irqchip as a first class method?

> -					virq = irq_find_mapping(port->msi_domain, bit);
> +					virq = irq_find_mapping(port->inner_domain, bit);
>  					generic_handle_irq(virq);
>  				}
>  			}
> @@ -638,7 +663,9 @@ static irqreturn_t mtk_pcie_intr_handler(int irq, void *data)
>  		}
>  	}
>  
> -	return IRQ_HANDLED;
> +	chained_irq_exit(irqchip, desc);
> +
> +	return;
>  }
>  
>  static int mtk_pcie_setup_irq(struct mtk_pcie_port *port,
> @@ -649,20 +676,15 @@ static int mtk_pcie_setup_irq(struct mtk_pcie_port *port,
>  	struct platform_device *pdev = to_platform_device(dev);
>  	int err, irq;
>  
> -	irq = platform_get_irq(pdev, port->slot);
> -	err = devm_request_irq(dev, irq, mtk_pcie_intr_handler,
> -			       IRQF_SHARED, "mtk-pcie", port);
> -	if (err) {
> -		dev_err(dev, "unable to request IRQ %d\n", irq);
> -		return err;
> -	}
> -
>  	err = mtk_pcie_init_irq_domain(port, node);
>  	if (err) {
>  		dev_err(dev, "failed to init PCIe IRQ domain\n");
>  		return err;
>  	}
>  
> +	irq = platform_get_irq(pdev, port->slot);
> +	irq_set_chained_handler_and_data(irq, mtk_pcie_intr_handler, port);
> +
>  	return 0;
>  }
>  
> @@ -1096,8 +1118,6 @@ static int mtk_pcie_register_host(struct pci_host_bridge *host)
>  	host->map_irq = of_irq_parse_and_map_pci;
>  	host->swizzle_irq = pci_common_swizzle;
>  	host->sysdata = pcie;
> -	if (IS_ENABLED(CONFIG_PCI_MSI) && pcie->soc->has_msi)
> -		host->msi = &mtk_pcie_msi_chip;
>  
>  	err = pci_scan_root_bus_bridge(host);
>  	if (err < 0)
> @@ -1159,7 +1179,6 @@ static const struct mtk_pcie_soc mtk_pcie_soc_v1 = {
>  };
>  
>  static const struct mtk_pcie_soc mtk_pcie_soc_mt2712 = {
> -	.has_msi = true,
>  	.ops = &mtk_pcie_ops_v2,
>  	.startup = mtk_pcie_startup_port_v2,
>  	.setup_irq = mtk_pcie_setup_irq,
> @@ -1167,7 +1186,6 @@ static const struct mtk_pcie_soc mtk_pcie_soc_mt2712 = {
>  
>  static const struct mtk_pcie_soc mtk_pcie_soc_mt7622 = {
>  	.need_fix_class_id = true,
> -	.has_msi = true,
>  	.ops = &mtk_pcie_ops_v2,
>  	.startup = mtk_pcie_startup_port_v2,
>  	.setup_irq = mtk_pcie_setup_irq,
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
