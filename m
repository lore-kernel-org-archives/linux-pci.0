Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E24C169C4
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 09:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64DAF20B1F
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 09:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbfAaJTf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:19:35 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:4007 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725895AbfAaJTf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Jan 2019 04:19:35 -0500
X-UUID: a1083f249c404514949335cb54cbccfa-20190131
X-UUID: a1083f249c404514949335cb54cbccfa-20190131
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1105451668; Thu, 31 Jan 2019 17:19:29 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 31 Jan
 2019 17:19:27 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 31 Jan 2019 17:19:27 +0800
Message-ID: <1548926367.4980.14.camel@mhfsdcap03>
Subject: Re: [v1] PCI: mediatek: Remove MSI inner domain
From:   Honghui Zhang <honghui.zhang@mediatek.com>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
CC:     <ryder.lee@mediatek.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <youlin.pei@mediatek.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Date:   Thu, 31 Jan 2019 17:19:27 +0800
In-Reply-To: <1548149855-3225-1-git-send-email-jianjun.wang@mediatek.com>
References: <1548149855-3225-1-git-send-email-jianjun.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2019-01-22 at 17:37 +0800, Jianjun Wang wrote:
> There is no need to create the inner domain as a parent for MSI domian,
> some feature has been implemented by MSI framework.
> 
> Remove the inner domain and its irq chip, it will be more closer to
> hardware implementation.
> 
Hi, jianjun, I'm not quite familiar with the irq_chip framework, It was
under Marc's great help with the first version of irq_chip solution
code. I would like you to add him for the review.

Thanks.

> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 86 +++++++++++---------------
>  1 file changed, 37 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 8d05df56158b..f996a9a6331f 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -169,7 +169,6 @@ struct mtk_pcie_soc {
>   * @slot: port slot
>   * @irq: GIC irq
>   * @irq_domain: legacy INTx IRQ domain
> - * @inner_domain: inner IRQ domain
>   * @msi_domain: MSI IRQ domain
>   * @lock: protect the msi_irq_in_use bitmap
>   * @msi_irq_in_use: bit map for assigned MSI IRQ
> @@ -190,7 +189,6 @@ struct mtk_pcie_port {
>  	u32 slot;
>  	int irq;
>  	struct irq_domain *irq_domain;
> -	struct irq_domain *inner_domain;
>  	struct irq_domain *msi_domain;
>  	struct mutex lock;
>  	DECLARE_BITMAP(msi_irq_in_use, MTK_MSI_IRQS_NUM);
> @@ -418,22 +416,15 @@ static void mtk_msi_ack_irq(struct irq_data *data)
>  	u32 hwirq = data->hwirq;
>  
>  	writel(1 << hwirq, port->base + PCIE_IMSI_STATUS);
> +	writel(MSI_STATUS, port->base + PCIE_INT_STATUS);
>  }
>  
> -static struct irq_chip mtk_msi_bottom_irq_chip = {
> -	.name			= "MTK MSI",
> -	.irq_compose_msi_msg	= mtk_compose_msi_msg,
> -	.irq_set_affinity	= mtk_msi_set_affinity,
> -	.irq_ack		= mtk_msi_ack_irq,
> -};
> -
> -static int mtk_pcie_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> -				     unsigned int nr_irqs, void *args)
> +static irq_hw_number_t mtk_pcie_msi_get_hwirq(struct msi_domain_info *info,
> +					      msi_alloc_info_t *arg)
>  {
> -	struct mtk_pcie_port *port = domain->host_data;
> -	unsigned long bit;
> +	struct mtk_pcie_port *port = info->chip_data;
> +	irq_hw_number_t bit;
>  
> -	WARN_ON(nr_irqs != 1);
>  	mutex_lock(&port->lock);
>  
>  	bit = find_first_zero_bit(port->msi_irq_in_use, MTK_MSI_IRQS_NUM);
> @@ -446,18 +437,14 @@ static int mtk_pcie_irq_domain_alloc(struct irq_domain *domain, unsigned int vir
>  
>  	mutex_unlock(&port->lock);
>  
> -	irq_domain_set_info(domain, virq, bit, &mtk_msi_bottom_irq_chip,
> -			    domain->host_data, handle_edge_irq,
> -			    NULL, NULL);
> -
> -	return 0;
> +	return bit;
>  }
>  
> -static void mtk_pcie_irq_domain_free(struct irq_domain *domain,
> -				     unsigned int virq, unsigned int nr_irqs)
> +static void mtk_pcie_msi_free(struct irq_domain *domain,
> +			      struct msi_domain_info *info, unsigned int virq)
>  {
>  	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
> -	struct mtk_pcie_port *port = irq_data_get_irq_chip_data(d);
> +	struct mtk_pcie_port *port = info->chip_data;
>  
>  	mutex_lock(&port->lock);
>  
> @@ -468,46 +455,50 @@ static void mtk_pcie_irq_domain_free(struct irq_domain *domain,
>  		__clear_bit(d->hwirq, port->msi_irq_in_use);
>  
>  	mutex_unlock(&port->lock);
> -
> -	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
>  }
>  
> -static const struct irq_domain_ops msi_domain_ops = {
> -	.alloc	= mtk_pcie_irq_domain_alloc,
> -	.free	= mtk_pcie_irq_domain_free,
> +static struct msi_domain_ops mtk_msi_domain_ops = {
> +	.get_hwirq	= mtk_pcie_msi_get_hwirq,
> +	.msi_free	= mtk_pcie_msi_free,
>  };
>  
>  static struct irq_chip mtk_msi_irq_chip = {
> -	.name		= "MTK PCIe MSI",
> -	.irq_ack	= irq_chip_ack_parent,
> -	.irq_mask	= pci_msi_mask_irq,
> -	.irq_unmask	= pci_msi_unmask_irq,
> +	.name			= "MTK PCIe",
> +	.irq_compose_msi_msg	= mtk_compose_msi_msg,
> +	.irq_write_msi_msg	= pci_msi_domain_write_msg,
> +	.irq_set_affinity	= mtk_msi_set_affinity,
> +	.irq_ack		= mtk_msi_ack_irq,
> +	.irq_mask		= pci_msi_mask_irq,
> +	.irq_unmask		= pci_msi_unmask_irq,
>  };
>  
>  static struct msi_domain_info mtk_msi_domain_info = {
> -	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> -		   MSI_FLAG_PCI_MSIX),
> -	.chip	= &mtk_msi_irq_chip,
> +	.flags		= (MSI_FLAG_USE_DEF_DOM_OPS |
> +			   MSI_FLAG_USE_DEF_CHIP_OPS | MSI_FLAG_PCI_MSIX),
> +	.ops		= &mtk_msi_domain_ops,
> +	.chip		= &mtk_msi_irq_chip,
> +	.handler	= handle_edge_irq,
> +	.handler_name	= "MSI",
>  };
>  
>  static int mtk_pcie_allocate_msi_domains(struct mtk_pcie_port *port)
>  {
> -	struct fwnode_handle *fwnode = of_node_to_fwnode(port->pcie->dev->of_node);
> +	struct device *dev = port->pcie->dev;
> +	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
> +	struct msi_domain_info *info;
>  
>  	mutex_init(&port->lock);
>  
> -	port->inner_domain = irq_domain_create_linear(fwnode, MTK_MSI_IRQS_NUM,
> -						      &msi_domain_ops, port);
> -	if (!port->inner_domain) {
> -		dev_err(port->pcie->dev, "failed to create IRQ domain\n");
> +	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
>  		return -ENOMEM;
> -	}
>  
> -	port->msi_domain = pci_msi_create_irq_domain(fwnode, &mtk_msi_domain_info,
> -						     port->inner_domain);
> +	memcpy(info, &mtk_msi_domain_info, sizeof(*info));
> +	info->chip_data = port;
> +

I'm not really like this memcpy of msi_domain_info, but I do not have a
better idea to prevent the mixed of mtk_pcie_port data.

> +	port->msi_domain = pci_msi_create_irq_domain(fwnode, info, NULL);
>  	if (!port->msi_domain) {
> -		dev_err(port->pcie->dev, "failed to create MSI domain\n");
> -		irq_domain_remove(port->inner_domain);
> +		dev_err(dev, "failed to create MSI domain\n");
>  		return -ENOMEM;
>  	}
>  
> @@ -541,8 +532,6 @@ static void mtk_pcie_irq_teardown(struct mtk_pcie *pcie)
>  		if (IS_ENABLED(CONFIG_PCI_MSI)) {
>  			if (port->msi_domain)
>  				irq_domain_remove(port->msi_domain);
> -			if (port->inner_domain)
> -				irq_domain_remove(port->inner_domain);
>  		}
>  
>  		irq_dispose_mapping(port->irq);
> @@ -619,12 +608,11 @@ static void mtk_pcie_intr_handler(struct irq_desc *desc)
>  
>  			while ((imsi_status = readl(port->base + PCIE_IMSI_STATUS))) {
>  				for_each_set_bit(bit, &imsi_status, MTK_MSI_IRQS_NUM) {
> -					virq = irq_find_mapping(port->inner_domain, bit);
> +					virq = irq_find_mapping(
> +							port->msi_domain, bit);
>  					generic_handle_irq(virq);
>  				}
>  			}
> -			/* Clear MSI interrupt status */
> -			writel(MSI_STATUS, port->base + PCIE_INT_STATUS);
>  		}

why change this irq status clear flow?

>  	}
>  


