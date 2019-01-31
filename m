Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F42C169C4
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 16:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8CB2085B
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 16:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733294AbfAaQV4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:21:56 -0500
Received: from foss.arm.com ([217.140.101.70]:47304 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388102AbfAaQVz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Jan 2019 11:21:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C45E80D;
        Thu, 31 Jan 2019 08:21:55 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FAB43F557;
        Thu, 31 Jan 2019 08:21:54 -0800 (PST)
Date:   Thu, 31 Jan 2019 16:21:48 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     linux-pci@vger.kernel.org, Joao Pinto <joao.pinto@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH 3/9] PCI: dwc: Replace variable name from data to d on
 dw_pci_bottom_mask/unmask()
Message-ID: <20190131162148.GA28941@e107981-ln.cambridge.arm.com>
References: <cover.1547631485.git.gustavo.pimentel@synopsys.com>
 <ab9e5de92e2c8c29ec1ee8b1303430c57fb937e5.1547631485.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab9e5de92e2c8c29ec1ee8b1303430c57fb937e5.1547631485.git.gustavo.pimentel@synopsys.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 16, 2019 at 11:14:16AM +0100, Gustavo Pimentel wrote:
> Replace variable from data to d to maintain coherency between similar

s/Replace/Rename
s/coherency/consistency

s/similar/driver

These comments are valid for other patches in this series too.

> functions, such as dw_msi_mask_irq() and dw_msi_unmask_irq().
> 
> No functional change is intended.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Joao Pinto <jpinto@synopsys.com>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 721d60a..36e284c 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -149,20 +149,20 @@ static int dw_pci_msi_set_affinity(struct irq_data *irq_data,
>  	return -EINVAL;
>  }
>  
> -static void dw_pci_bottom_mask(struct irq_data *data)
> +static void dw_pci_bottom_mask(struct irq_data *d)
>  {
> -	struct pcie_port *pp = irq_data_get_irq_chip_data(data);
> +	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
>  	unsigned int res, bit, ctrl;
>  	unsigned long flags;
>  
>  	raw_spin_lock_irqsave(&pp->lock, flags);
>  
>  	if (pp->ops->msi_clear_irq) {
> -		pp->ops->msi_clear_irq(pp, data->hwirq);
> +		pp->ops->msi_clear_irq(pp, d->hwirq);
>  	} else {
> -		ctrl = data->hwirq / MAX_MSI_IRQS_PER_CTRL;
> +		ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
>  		res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
> -		bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
> +		bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
>  
>  		pp->irq_status[ctrl] &= ~(1 << bit);
>  		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
> @@ -172,20 +172,20 @@ static void dw_pci_bottom_mask(struct irq_data *data)
>  	raw_spin_unlock_irqrestore(&pp->lock, flags);
>  }
>  
> -static void dw_pci_bottom_unmask(struct irq_data *data)
> +static void dw_pci_bottom_unmask(struct irq_data *d)
>  {
> -	struct pcie_port *pp = irq_data_get_irq_chip_data(data);
> +	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
>  	unsigned int res, bit, ctrl;
>  	unsigned long flags;
>  
>  	raw_spin_lock_irqsave(&pp->lock, flags);
>  
>  	if (pp->ops->msi_set_irq) {
> -		pp->ops->msi_set_irq(pp, data->hwirq);
> +		pp->ops->msi_set_irq(pp, d->hwirq);
>  	} else {
> -		ctrl = data->hwirq / MAX_MSI_IRQS_PER_CTRL;
> +		ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
>  		res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
> -		bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
> +		bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
>  
>  		pp->irq_status[ctrl] |= 1 << bit;
>  		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
> -- 
> 2.7.4
> 
