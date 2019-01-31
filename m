Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B94EC169C4
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 12:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022172086C
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 12:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfAaMuJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:50:09 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:55903 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732650AbfAaMuJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Jan 2019 07:50:09 -0500
X-UUID: de413b86cd6448fb85edc0e2b1001cfa-20190131
X-UUID: de413b86cd6448fb85edc0e2b1001cfa-20190131
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1536748433; Thu, 31 Jan 2019 20:49:59 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 31 Jan
 2019 20:49:58 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 31 Jan 2019 20:49:57 +0800
Message-ID: <1548938997.6292.52.camel@mhfsdcap03>
Subject: Re: [v1] PCI: mediatek: Remove MSI inner domain
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     Honghui Zhang <honghui.zhang@mediatek.com>,
        <ryder.lee@mediatek.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <youlin.pei@mediatek.com>
Date:   Thu, 31 Jan 2019 20:49:57 +0800
In-Reply-To: <10e8e731-5749-f6fb-eb33-ab67aa0e2c3f@arm.com>
References: <1548149855-3225-1-git-send-email-jianjun.wang@mediatek.com>
         <1548926367.4980.14.camel@mhfsdcap03>
         <10e8e731-5749-f6fb-eb33-ab67aa0e2c3f@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2019-01-31 at 09:44 +0000, Marc Zyngier wrote:
> On 31/01/2019 09:19, Honghui Zhang wrote:
> > On Tue, 2019-01-22 at 17:37 +0800, Jianjun Wang wrote:
> >> There is no need to create the inner domain as a parent for MSI domian,
> >> some feature has been implemented by MSI framework.
> >>
> >> Remove the inner domain and its irq chip, it will be more closer to
> >> hardware implementation.
> 
> This is not about being closer to any HW implementation. This is about
> having a uniform way to deal with MSI controllers, no matter how they
> are implemented by the HW.
> 
> So maybe you could start by explaining what this is trying to achieve.
> 
> >>
> > Hi, jianjun, I'm not quite familiar with the irq_chip framework, It was
> > under Marc's great help with the first version of irq_chip solution
> > code. I would like you to add him for the review.
> > 
> > Thanks.
> > 
> >> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> >> ---
> >>  drivers/pci/controller/pcie-mediatek.c | 86 +++++++++++---------------
> >>  1 file changed, 37 insertions(+), 49 deletions(-)
> >>
> >> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> >> index 8d05df56158b..f996a9a6331f 100644
> >> --- a/drivers/pci/controller/pcie-mediatek.c
> >> +++ b/drivers/pci/controller/pcie-mediatek.c
> >> @@ -169,7 +169,6 @@ struct mtk_pcie_soc {
> >>   * @slot: port slot
> >>   * @irq: GIC irq
> >>   * @irq_domain: legacy INTx IRQ domain
> >> - * @inner_domain: inner IRQ domain
> >>   * @msi_domain: MSI IRQ domain
> >>   * @lock: protect the msi_irq_in_use bitmap
> >>   * @msi_irq_in_use: bit map for assigned MSI IRQ
> >> @@ -190,7 +189,6 @@ struct mtk_pcie_port {
> >>  	u32 slot;
> >>  	int irq;
> >>  	struct irq_domain *irq_domain;
> >> -	struct irq_domain *inner_domain;
> >>  	struct irq_domain *msi_domain;
> >>  	struct mutex lock;
> >>  	DECLARE_BITMAP(msi_irq_in_use, MTK_MSI_IRQS_NUM);
> >> @@ -418,22 +416,15 @@ static void mtk_msi_ack_irq(struct irq_data *data)
> >>  	u32 hwirq = data->hwirq;
> >>  
> >>  	writel(1 << hwirq, port->base + PCIE_IMSI_STATUS);
> >> +	writel(MSI_STATUS, port->base + PCIE_INT_STATUS);
> >>  }
> >>  
> >> -static struct irq_chip mtk_msi_bottom_irq_chip = {
> >> -	.name			= "MTK MSI",
> >> -	.irq_compose_msi_msg	= mtk_compose_msi_msg,
> >> -	.irq_set_affinity	= mtk_msi_set_affinity,
> >> -	.irq_ack		= mtk_msi_ack_irq,
> >> -};
> >> -
> >> -static int mtk_pcie_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> >> -				     unsigned int nr_irqs, void *args)
> >> +static irq_hw_number_t mtk_pcie_msi_get_hwirq(struct msi_domain_info *info,
> >> +					      msi_alloc_info_t *arg)
> >>  {
> >> -	struct mtk_pcie_port *port = domain->host_data;
> >> -	unsigned long bit;
> >> +	struct mtk_pcie_port *port = info->chip_data;
> >> +	irq_hw_number_t bit;
> >>  
> >> -	WARN_ON(nr_irqs != 1);
> >>  	mutex_lock(&port->lock);
> >>  
> >>  	bit = find_first_zero_bit(port->msi_irq_in_use, MTK_MSI_IRQS_NUM);
> >> @@ -446,18 +437,14 @@ static int mtk_pcie_irq_domain_alloc(struct irq_domain *domain, unsigned int vir
> >>  
> >>  	mutex_unlock(&port->lock);
> >>  
> >> -	irq_domain_set_info(domain, virq, bit, &mtk_msi_bottom_irq_chip,
> >> -			    domain->host_data, handle_edge_irq,
> >> -			    NULL, NULL);
> >> -
> >> -	return 0;
> >> +	return bit;
> 
> Why do you need to override the get_hwirq method? Using the generic
> PCI/MSI version has the advantage of giving you a universal encoding
> which makes debugging much easier.

Hi Marc,

In previous patch, we create a inner_domain as a parent for msi_domain,
when we allocate a irq for MSI, the work flow of each domain will be the
following:

inner_domain:
1. Allocated a irq bit from bitmap as this domain's hwirq;
2. Mapping with system virtual irq number;
3. Set irq chip and irq handler;
4. Send MSI message to EP.

msi_domain:
1. Calculate a hwirq;
2. Mapping with system virtual irq number;
3. Set irq chip which from info->chip and irq handler if defined in
info.
4. Send MSI message to EP or trigger parent domain to send the message.

The last three steps looks similar, if we override the get_hwirq method
and set irq chip and handler to info structure, MSI framework will do
the rest of thing. I think it will be more simple and easy to understand
the driver's work flow.

Further more, if we try to enhance the interrupt performance, such as
connect the MSI interrupt line to GIC directly in hardware, we will need
to set gic domain as the parent, in that case, there will be a lot of
work to do to replace the inner domain.

Thanks.
> 
> >>  }
> >>  
> >> -static void mtk_pcie_irq_domain_free(struct irq_domain *domain,
> >> -				     unsigned int virq, unsigned int nr_irqs)
> >> +static void mtk_pcie_msi_free(struct irq_domain *domain,
> >> +			      struct msi_domain_info *info, unsigned int virq)
> >>  {
> >>  	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
> >> -	struct mtk_pcie_port *port = irq_data_get_irq_chip_data(d);
> >> +	struct mtk_pcie_port *port = info->chip_data;
> >>  
> >>  	mutex_lock(&port->lock);
> >>  
> >> @@ -468,46 +455,50 @@ static void mtk_pcie_irq_domain_free(struct irq_domain *domain,
> >>  		__clear_bit(d->hwirq, port->msi_irq_in_use);
> >>  
> >>  	mutex_unlock(&port->lock);
> >> -
> >> -	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
> >>  }
> >>  
> >> -static const struct irq_domain_ops msi_domain_ops = {
> >> -	.alloc	= mtk_pcie_irq_domain_alloc,
> >> -	.free	= mtk_pcie_irq_domain_free,
> >> +static struct msi_domain_ops mtk_msi_domain_ops = {
> >> +	.get_hwirq	= mtk_pcie_msi_get_hwirq,
> >> +	.msi_free	= mtk_pcie_msi_free,
> >>  };
> >>  
> >>  static struct irq_chip mtk_msi_irq_chip = {
> >> -	.name		= "MTK PCIe MSI",
> >> -	.irq_ack	= irq_chip_ack_parent,
> >> -	.irq_mask	= pci_msi_mask_irq,
> >> -	.irq_unmask	= pci_msi_unmask_irq,
> >> +	.name			= "MTK PCIe",
> >> +	.irq_compose_msi_msg	= mtk_compose_msi_msg,
> >> +	.irq_write_msi_msg	= pci_msi_domain_write_msg,
> >> +	.irq_set_affinity	= mtk_msi_set_affinity,
> >> +	.irq_ack		= mtk_msi_ack_irq,
> >> +	.irq_mask		= pci_msi_mask_irq,
> >> +	.irq_unmask		= pci_msi_unmask_irq,
> >>  };
> >>  
> >>  static struct msi_domain_info mtk_msi_domain_info = {
> >> -	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> >> -		   MSI_FLAG_PCI_MSIX),
> >> -	.chip	= &mtk_msi_irq_chip,
> >> +	.flags		= (MSI_FLAG_USE_DEF_DOM_OPS |
> >> +			   MSI_FLAG_USE_DEF_CHIP_OPS | MSI_FLAG_PCI_MSIX),
> >> +	.ops		= &mtk_msi_domain_ops,
> >> +	.chip		= &mtk_msi_irq_chip,
> >> +	.handler	= handle_edge_irq,
> >> +	.handler_name	= "MSI",
> >>  };
> >>  
> >>  static int mtk_pcie_allocate_msi_domains(struct mtk_pcie_port *port)
> >>  {
> >> -	struct fwnode_handle *fwnode = of_node_to_fwnode(port->pcie->dev->of_node);
> >> +	struct device *dev = port->pcie->dev;
> >> +	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
> >> +	struct msi_domain_info *info;
> >>  
> >>  	mutex_init(&port->lock);
> >>  
> >> -	port->inner_domain = irq_domain_create_linear(fwnode, MTK_MSI_IRQS_NUM,
> >> -						      &msi_domain_ops, port);
> >> -	if (!port->inner_domain) {
> >> -		dev_err(port->pcie->dev, "failed to create IRQ domain\n");
> >> +	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> >> +	if (!info)
> >>  		return -ENOMEM;
> >> -	}
> >>  
> >> -	port->msi_domain = pci_msi_create_irq_domain(fwnode, &mtk_msi_domain_info,
> >> -						     port->inner_domain);
> >> +	memcpy(info, &mtk_msi_domain_info, sizeof(*info));
> >> +	info->chip_data = port;
> >> +
> > 
> > I'm not really like this memcpy of msi_domain_info, but I do not have a
> > better idea to prevent the mixed of mtk_pcie_port data.
> 
> So we're basically trading an indirection for another. What's the gain?

There is usually more than one PCIe port in each SoC, we use
mtk_pcie_port data to describe it, in previous version, we pass the port
data as inner domain's host_data. When remove the inner domain, we also
need to pass the port data and should prevent to mix with another port,
so I thank maybe we can make a copy for each port and set port data as
it's chip_data.
> 
> > 
> >> +	port->msi_domain = pci_msi_create_irq_domain(fwnode, info, NULL);
> >>  	if (!port->msi_domain) {
> >> -		dev_err(port->pcie->dev, "failed to create MSI domain\n");
> >> -		irq_domain_remove(port->inner_domain);
> >> +		dev_err(dev, "failed to create MSI domain\n");
> >>  		return -ENOMEM;
> >>  	}
> >>  
> >> @@ -541,8 +532,6 @@ static void mtk_pcie_irq_teardown(struct mtk_pcie *pcie)
> >>  		if (IS_ENABLED(CONFIG_PCI_MSI)) {
> >>  			if (port->msi_domain)
> >>  				irq_domain_remove(port->msi_domain);
> >> -			if (port->inner_domain)
> >> -				irq_domain_remove(port->inner_domain);
> >>  		}
> >>  
> >>  		irq_dispose_mapping(port->irq);
> >> @@ -619,12 +608,11 @@ static void mtk_pcie_intr_handler(struct irq_desc *desc)
> >>  
> >>  			while ((imsi_status = readl(port->base + PCIE_IMSI_STATUS))) {
> >>  				for_each_set_bit(bit, &imsi_status, MTK_MSI_IRQS_NUM) {
> >> -					virq = irq_find_mapping(port->inner_domain, bit);
> >> +					virq = irq_find_mapping(
> >> +							port->msi_domain, bit);
> >>  					generic_handle_irq(virq);
> >>  				}
> >>  			}
> >> -			/* Clear MSI interrupt status */
> >> -			writel(MSI_STATUS, port->base + PCIE_INT_STATUS);
> >>  		}
> > 
> > why change this irq status clear flow?
> 
> I think this is trying move everything to the irq_ack callback. But
> that's a change of semantics, and I'd like it explained. It certainly
> feels wrong.
Yes, I confused with each irq's ack callback, it doesn't need to be
changed.

Thanks.
> 
> Overall, this patch as it stands (without any real explanation) doesn't
> feel me with confidence. It introduces significant differences in the
> way we build PCI/MSI domains, and I'd like to understand why.
> 
> Thanks,
> 
> 	M.


