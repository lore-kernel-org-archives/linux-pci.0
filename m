Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A5FC169C4
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 16:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB592085B
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 16:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388440AbfAaQXE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:23:04 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47396 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388155AbfAaQXE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Jan 2019 11:23:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A64BD80D;
        Thu, 31 Jan 2019 08:23:03 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 655D33F557;
        Thu, 31 Jan 2019 08:23:02 -0800 (PST)
Date:   Thu, 31 Jan 2019 16:22:59 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     linux-pci@vger.kernel.org, Joao Pinto <joao.pinto@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH 7/9] PCI: dwc: Improve code readability and simplifies
 mask/unmask operations
Message-ID: <20190131162259.GB28941@e107981-ln.cambridge.arm.com>
References: <cover.1547631485.git.gustavo.pimentel@synopsys.com>
 <eba21fed997cdf148bc03cb459c12d1a32a77a8f.1547631485.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eba21fed997cdf148bc03cb459c12d1a32a77a8f.1547631485.git.gustavo.pimentel@synopsys.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 16, 2019 at 11:14:20AM +0100, Gustavo Pimentel wrote:
> Improve code readability and simplifies mask/unmask operations by
> inverting the applied logic (no functional change is intended).
> 
> Replace variable name from irq_status to irq_mask, since its goal is to
> keep track of which interuptions are mask or not.
> 
> Replace bit rotation operation (1 << bit) by BIT(bit), which simplifies
> code reading.

Two changes, two patches, I know it is tempting to squash trivial
changes in one patch but logically that's not correct.

Lorenzo

> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Joao Pinto <jpinto@synopsys.com>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 12 ++++++------
>  drivers/pci/controller/dwc/pcie-designware.h      |  2 +-
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 768e16a..d53e6f7 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -164,9 +164,9 @@ static void dw_pci_bottom_mask(struct irq_data *d)
>  		res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
>  		bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
>  
> -		pp->irq_status[ctrl] &= ~(1 << bit);
> +		pp->irq_mask[ctrl] |= BIT(bit);
>  		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
> -				    ~pp->irq_status[ctrl]);
> +				    pp->irq_mask[ctrl]);
>  	}
>  
>  	raw_spin_unlock_irqrestore(&pp->lock, flags);
> @@ -187,9 +187,9 @@ static void dw_pci_bottom_unmask(struct irq_data *d)
>  		res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
>  		bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
>  
> -		pp->irq_status[ctrl] |= 1 << bit;
> +		pp->irq_mask[ctrl] &= ~BIT(bit);
>  		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
> -				    ~pp->irq_status[ctrl]);
> +				    pp->irq_mask[ctrl]);
>  	}
>  
>  	raw_spin_unlock_irqrestore(&pp->lock, flags);
> @@ -665,13 +665,13 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  
>  	/* Initialize IRQ Status array */
>  	for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
> +		pp->irq_mask[ctrl] = ~0;
>  		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK +
>  					(ctrl * MSI_REG_CTRL_BLOCK_SIZE),
> -				    4, ~0);
> +				    4, pp->irq_mask[ctrl]);
>  		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE +
>  					(ctrl * MSI_REG_CTRL_BLOCK_SIZE),
>  				    4, ~0);
> -		pp->irq_status[ctrl] = 0;
>  	}
>  
>  	/* Setup RC BARs */
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 9943d8c..2790002 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -177,7 +177,7 @@ struct pcie_port {
>  	struct irq_domain	*msi_domain;
>  	dma_addr_t		msi_data;
>  	u32			num_vectors;
> -	u32			irq_status[MAX_MSI_CTRLS];
> +	u32			irq_mask[MAX_MSI_CTRLS];
>  	raw_spinlock_t		lock;
>  	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
>  };
> -- 
> 2.7.4
> 
