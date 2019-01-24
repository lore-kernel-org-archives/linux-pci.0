Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8736DC282C3
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 12:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603F720855
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 12:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbfAXMpb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 07:45:31 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56222 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfAXMpb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jan 2019 07:45:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 765A4EBD;
        Thu, 24 Jan 2019 04:45:31 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC0143F237;
        Thu, 24 Jan 2019 04:45:29 -0800 (PST)
Date:   Thu, 24 Jan 2019 12:45:27 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>, marc.zyngier@arm.com
Cc:     Murali Karicheri <m-karicheri2@ti.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] PCI: keystone: Use "dummy_irq_chip" instead of new
 irqchip for legacy interrupt handling
Message-ID: <20190124124526.GC23362@e107981-ln.cambridge.arm.com>
References: <20181219124207.13479-1-kishon@ti.com>
 <20181219124207.13479-3-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219124207.13479-3-kishon@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 19, 2018 at 06:11:59PM +0530, Kishon Vijay Abraham I wrote:
> Instead of creating a new irqchip with empty callback functions, use
> dummy_irq_chip. Since there is nothing to do in the irqchip callback
> functions, use handle_simple_irq instead of handle_level_irq.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/dwc/pci-keystone.c | 24 ++---------------------
>  1 file changed, 2 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 5286a480f76b..1ef443009da5 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -266,31 +266,12 @@ static irqreturn_t ks_pcie_handle_error_irq(struct keystone_pcie *ks_pcie)
>  	return IRQ_HANDLED;
>  }
>  
> -static void ks_pcie_ack_legacy_irq(struct irq_data *d)
> -{
> -}
> -
> -static void ks_pcie_mask_legacy_irq(struct irq_data *d)
> -{
> -}
> -
> -static void ks_pcie_unmask_legacy_irq(struct irq_data *d)
> -{
> -}
> -
> -static struct irq_chip ks_pcie_legacy_irq_chip = {
> -	.name = "Keystone-PCI-Legacy-IRQ",
> -	.irq_ack = ks_pcie_ack_legacy_irq,
> -	.irq_mask = ks_pcie_mask_legacy_irq,
> -	.irq_unmask = ks_pcie_unmask_legacy_irq,
> -};
> -
>  static int ks_pcie_init_legacy_irq_map(struct irq_domain *d,
>  				       unsigned int irq,
>  				       irq_hw_number_t hw_irq)
>  {
> -	irq_set_chip_and_handler(irq, &ks_pcie_legacy_irq_chip,
> -				 handle_level_irq);
> +	irq_set_chip_and_handler(irq, &dummy_irq_chip,
> +				 handle_simple_irq);

Hi Kishon,

thanks for putting it together. I think I'd rather move some of
the logic for acking the interrupt in ks_pcie_handle_legacy_irq()
into proper irq_chip methods than using a dummy_irq_chip (that
Marc wants to deprecate).

Also, the flow handler should be handle_level_irq() since that's
what legacy IRQs are.

I hope Marc can chime in when he has a minute to help you finalize this.

Overall you are doing the right thing and I would like to get this
series merged for v5.1.

Thanks,
Lorenzo

>  	irq_set_chip_data(irq, d->host_data);
>  
>  	return 0;
> @@ -298,7 +279,6 @@ static int ks_pcie_init_legacy_irq_map(struct irq_domain *d,
>  
>  static const struct irq_domain_ops ks_pcie_legacy_irq_domain_ops = {
>  	.map = ks_pcie_init_legacy_irq_map,
> -	.xlate = irq_domain_xlate_onetwocell,
>  };
>  
>  /**
> -- 
> 2.17.1
> 
