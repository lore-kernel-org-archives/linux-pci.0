Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC557C169C4
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 09:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6FFF218AC
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 09:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbfAaJoy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:44:54 -0500
Received: from foss.arm.com ([217.140.101.70]:40514 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727523AbfAaJox (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Jan 2019 04:44:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10B0EA78;
        Thu, 31 Jan 2019 01:44:53 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6476A3F71E;
        Thu, 31 Jan 2019 01:44:50 -0800 (PST)
Subject: Re: [v1] PCI: mediatek: Remove MSI inner domain
To:     Honghui Zhang <honghui.zhang@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     ryder.lee@mediatek.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, matthias.bgg@gmail.com,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        youlin.pei@mediatek.com
References: <1548149855-3225-1-git-send-email-jianjun.wang@mediatek.com>
 <1548926367.4980.14.camel@mhfsdcap03>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <10e8e731-5749-f6fb-eb33-ab67aa0e2c3f@arm.com>
Date:   Thu, 31 Jan 2019 09:44:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548926367.4980.14.camel@mhfsdcap03>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 31/01/2019 09:19, Honghui Zhang wrote:
> On Tue, 2019-01-22 at 17:37 +0800, Jianjun Wang wrote:
>> There is no need to create the inner domain as a parent for MSI domian,
>> some feature has been implemented by MSI framework.
>>
>> Remove the inner domain and its irq chip, it will be more closer to
>> hardware implementation.

This is not about being closer to any HW implementation. This is about
having a uniform way to deal with MSI controllers, no matter how they
are implemented by the HW.

So maybe you could start by explaining what this is trying to achieve.

>>
> Hi, jianjun, I'm not quite familiar with the irq_chip framework, It was
> under Marc's great help with the first version of irq_chip solution
> code. I would like you to add him for the review.
> 
> Thanks.
> 
>> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
>> ---
>>  drivers/pci/controller/pcie-mediatek.c | 86 +++++++++++---------------
>>  1 file changed, 37 insertions(+), 49 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
>> index 8d05df56158b..f996a9a6331f 100644
>> --- a/drivers/pci/controller/pcie-mediatek.c
>> +++ b/drivers/pci/controller/pcie-mediatek.c
>> @@ -169,7 +169,6 @@ struct mtk_pcie_soc {
>>   * @slot: port slot
>>   * @irq: GIC irq
>>   * @irq_domain: legacy INTx IRQ domain
>> - * @inner_domain: inner IRQ domain
>>   * @msi_domain: MSI IRQ domain
>>   * @lock: protect the msi_irq_in_use bitmap
>>   * @msi_irq_in_use: bit map for assigned MSI IRQ
>> @@ -190,7 +189,6 @@ struct mtk_pcie_port {
>>  	u32 slot;
>>  	int irq;
>>  	struct irq_domain *irq_domain;
>> -	struct irq_domain *inner_domain;
>>  	struct irq_domain *msi_domain;
>>  	struct mutex lock;
>>  	DECLARE_BITMAP(msi_irq_in_use, MTK_MSI_IRQS_NUM);
>> @@ -418,22 +416,15 @@ static void mtk_msi_ack_irq(struct irq_data *data)
>>  	u32 hwirq = data->hwirq;
>>  
>>  	writel(1 << hwirq, port->base + PCIE_IMSI_STATUS);
>> +	writel(MSI_STATUS, port->base + PCIE_INT_STATUS);
>>  }
>>  
>> -static struct irq_chip mtk_msi_bottom_irq_chip = {
>> -	.name			= "MTK MSI",
>> -	.irq_compose_msi_msg	= mtk_compose_msi_msg,
>> -	.irq_set_affinity	= mtk_msi_set_affinity,
>> -	.irq_ack		= mtk_msi_ack_irq,
>> -};
>> -
>> -static int mtk_pcie_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>> -				     unsigned int nr_irqs, void *args)
>> +static irq_hw_number_t mtk_pcie_msi_get_hwirq(struct msi_domain_info *info,
>> +					      msi_alloc_info_t *arg)
>>  {
>> -	struct mtk_pcie_port *port = domain->host_data;
>> -	unsigned long bit;
>> +	struct mtk_pcie_port *port = info->chip_data;
>> +	irq_hw_number_t bit;
>>  
>> -	WARN_ON(nr_irqs != 1);
>>  	mutex_lock(&port->lock);
>>  
>>  	bit = find_first_zero_bit(port->msi_irq_in_use, MTK_MSI_IRQS_NUM);
>> @@ -446,18 +437,14 @@ static int mtk_pcie_irq_domain_alloc(struct irq_domain *domain, unsigned int vir
>>  
>>  	mutex_unlock(&port->lock);
>>  
>> -	irq_domain_set_info(domain, virq, bit, &mtk_msi_bottom_irq_chip,
>> -			    domain->host_data, handle_edge_irq,
>> -			    NULL, NULL);
>> -
>> -	return 0;
>> +	return bit;

Why do you need to override the get_hwirq method? Using the generic
PCI/MSI version has the advantage of giving you a universal encoding
which makes debugging much easier.

>>  }
>>  
>> -static void mtk_pcie_irq_domain_free(struct irq_domain *domain,
>> -				     unsigned int virq, unsigned int nr_irqs)
>> +static void mtk_pcie_msi_free(struct irq_domain *domain,
>> +			      struct msi_domain_info *info, unsigned int virq)
>>  {
>>  	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
>> -	struct mtk_pcie_port *port = irq_data_get_irq_chip_data(d);
>> +	struct mtk_pcie_port *port = info->chip_data;
>>  
>>  	mutex_lock(&port->lock);
>>  
>> @@ -468,46 +455,50 @@ static void mtk_pcie_irq_domain_free(struct irq_domain *domain,
>>  		__clear_bit(d->hwirq, port->msi_irq_in_use);
>>  
>>  	mutex_unlock(&port->lock);
>> -
>> -	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
>>  }
>>  
>> -static const struct irq_domain_ops msi_domain_ops = {
>> -	.alloc	= mtk_pcie_irq_domain_alloc,
>> -	.free	= mtk_pcie_irq_domain_free,
>> +static struct msi_domain_ops mtk_msi_domain_ops = {
>> +	.get_hwirq	= mtk_pcie_msi_get_hwirq,
>> +	.msi_free	= mtk_pcie_msi_free,
>>  };
>>  
>>  static struct irq_chip mtk_msi_irq_chip = {
>> -	.name		= "MTK PCIe MSI",
>> -	.irq_ack	= irq_chip_ack_parent,
>> -	.irq_mask	= pci_msi_mask_irq,
>> -	.irq_unmask	= pci_msi_unmask_irq,
>> +	.name			= "MTK PCIe",
>> +	.irq_compose_msi_msg	= mtk_compose_msi_msg,
>> +	.irq_write_msi_msg	= pci_msi_domain_write_msg,
>> +	.irq_set_affinity	= mtk_msi_set_affinity,
>> +	.irq_ack		= mtk_msi_ack_irq,
>> +	.irq_mask		= pci_msi_mask_irq,
>> +	.irq_unmask		= pci_msi_unmask_irq,
>>  };
>>  
>>  static struct msi_domain_info mtk_msi_domain_info = {
>> -	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
>> -		   MSI_FLAG_PCI_MSIX),
>> -	.chip	= &mtk_msi_irq_chip,
>> +	.flags		= (MSI_FLAG_USE_DEF_DOM_OPS |
>> +			   MSI_FLAG_USE_DEF_CHIP_OPS | MSI_FLAG_PCI_MSIX),
>> +	.ops		= &mtk_msi_domain_ops,
>> +	.chip		= &mtk_msi_irq_chip,
>> +	.handler	= handle_edge_irq,
>> +	.handler_name	= "MSI",
>>  };
>>  
>>  static int mtk_pcie_allocate_msi_domains(struct mtk_pcie_port *port)
>>  {
>> -	struct fwnode_handle *fwnode = of_node_to_fwnode(port->pcie->dev->of_node);
>> +	struct device *dev = port->pcie->dev;
>> +	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
>> +	struct msi_domain_info *info;
>>  
>>  	mutex_init(&port->lock);
>>  
>> -	port->inner_domain = irq_domain_create_linear(fwnode, MTK_MSI_IRQS_NUM,
>> -						      &msi_domain_ops, port);
>> -	if (!port->inner_domain) {
>> -		dev_err(port->pcie->dev, "failed to create IRQ domain\n");
>> +	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
>> +	if (!info)
>>  		return -ENOMEM;
>> -	}
>>  
>> -	port->msi_domain = pci_msi_create_irq_domain(fwnode, &mtk_msi_domain_info,
>> -						     port->inner_domain);
>> +	memcpy(info, &mtk_msi_domain_info, sizeof(*info));
>> +	info->chip_data = port;
>> +
> 
> I'm not really like this memcpy of msi_domain_info, but I do not have a
> better idea to prevent the mixed of mtk_pcie_port data.

So we're basically trading an indirection for another. What's the gain?

> 
>> +	port->msi_domain = pci_msi_create_irq_domain(fwnode, info, NULL);
>>  	if (!port->msi_domain) {
>> -		dev_err(port->pcie->dev, "failed to create MSI domain\n");
>> -		irq_domain_remove(port->inner_domain);
>> +		dev_err(dev, "failed to create MSI domain\n");
>>  		return -ENOMEM;
>>  	}
>>  
>> @@ -541,8 +532,6 @@ static void mtk_pcie_irq_teardown(struct mtk_pcie *pcie)
>>  		if (IS_ENABLED(CONFIG_PCI_MSI)) {
>>  			if (port->msi_domain)
>>  				irq_domain_remove(port->msi_domain);
>> -			if (port->inner_domain)
>> -				irq_domain_remove(port->inner_domain);
>>  		}
>>  
>>  		irq_dispose_mapping(port->irq);
>> @@ -619,12 +608,11 @@ static void mtk_pcie_intr_handler(struct irq_desc *desc)
>>  
>>  			while ((imsi_status = readl(port->base + PCIE_IMSI_STATUS))) {
>>  				for_each_set_bit(bit, &imsi_status, MTK_MSI_IRQS_NUM) {
>> -					virq = irq_find_mapping(port->inner_domain, bit);
>> +					virq = irq_find_mapping(
>> +							port->msi_domain, bit);
>>  					generic_handle_irq(virq);
>>  				}
>>  			}
>> -			/* Clear MSI interrupt status */
>> -			writel(MSI_STATUS, port->base + PCIE_INT_STATUS);
>>  		}
> 
> why change this irq status clear flow?

I think this is trying move everything to the irq_ack callback. But
that's a change of semantics, and I'd like it explained. It certainly
feels wrong.

Overall, this patch as it stands (without any real explanation) doesn't
feel me with confidence. It introduces significant differences in the
way we build PCI/MSI domains, and I'd like to understand why.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
