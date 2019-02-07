Return-Path: <SRS0=HpDZ=QO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE9BC282C2
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 16:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A533820863
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 16:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfBGQPI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:15:08 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39592 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbfBGQPI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Feb 2019 11:15:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77532A78;
        Thu,  7 Feb 2019 08:15:07 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F15133F675;
        Thu,  7 Feb 2019 08:15:05 -0800 (PST)
Date:   Thu, 7 Feb 2019 16:15:02 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Murali Karicheri <m-karicheri2@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/9] PCI: keystone: Modify legacy_irq_handler to check
 the IRQ_STATUS of INTA/B/C/D
Message-ID: <20190207161502.GC21111@e107981-ln.cambridge.arm.com>
References: <20190207110924.30716-1-kishon@ti.com>
 <20190207110924.30716-3-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207110924.30716-3-kishon@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 07, 2019 at 04:39:17PM +0530, Kishon Vijay Abraham I wrote:
> The legacy interrupt handler directly checks the IRQ_STATUS register
> corresponding to a interrupt line inorder to invoke generic_handle_irq.
> 
> While this is okay for K2G platform which has separate interrupt line for
> each of the 4 legacy interrupts, AM654 which uses the same PCIe wrapper
> has a single interrupt line for all the legacy interrupts. So for AM654
> the interrupt handler won't be able to directly check the IRQ_STATUS
> register corresponding to the interrupt line.
> 
> Also the legacy interrupt handler uses 'virq' obtained from
> irq_of_parse_and_map to find the correct interrupt line which raised the
> interrupt. There is no guarantee that virq assigned for contiguous hardware
> irq will be contiguous and the interrupt handler might end up checking
> the wrong IRQ_STATUS register.
> 
> In order to overcome the above issues, read the IRQ_STATUS register of
> all the 4 legacy interrupts to determine which interrupt was raised.
> 
> Link: https://lkml.kernel.org/r/bb081d21-7c03-0357-4294-7e92d95d838c@arm.com
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/dwc/pci-keystone.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 5286a480f76b..4cf9849d5a1d 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -214,16 +214,11 @@ static void ks_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie,
>  {
>  	struct dw_pcie *pci = ks_pcie->pci;
>  	struct device *dev = pci->dev;
> -	u32 pending;
>  	int virq;
>  
> -	pending = ks_pcie_app_readl(ks_pcie, IRQ_STATUS(offset));
> -
> -	if (BIT(0) & pending) {
> -		virq = irq_linear_revmap(ks_pcie->legacy_irq_domain, offset);
> -		dev_dbg(dev, ": irq: irq_offset %d, virq %d\n", offset, virq);
> -		generic_handle_irq(virq);
> -	}
> +	virq = irq_linear_revmap(ks_pcie->legacy_irq_domain, offset);
> +	dev_dbg(dev, ": irq: irq_offset %d, virq %d\n", offset, virq);
> +	generic_handle_irq(virq);
>  
>  	/* EOI the INTx interrupt */
>  	ks_pcie_app_writel(ks_pcie, IRQ_EOI, offset);
> @@ -607,8 +602,9 @@ static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
>  	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
>  	struct dw_pcie *pci = ks_pcie->pci;
>  	struct device *dev = pci->dev;
> -	u32 irq_offset = irq - ks_pcie->legacy_host_irqs[0];
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	unsigned int irq_no;
> +	u32 reg;
>  
>  	dev_dbg(dev, ": Handling legacy irq %d\n", irq);
>  
> @@ -618,7 +614,13 @@ static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
>  	 * ack operation.
>  	 */
>  	chained_irq_enter(chip, desc);
> -	ks_pcie_handle_legacy_irq(ks_pcie, irq_offset);
> +	for (irq_no = 0; irq_no < PCI_NUM_INTX; irq_no++) {

I understand the aim of this code but now on platforms where there
is a 1:1 relationship between Linux IRQ and INTX this loop has
steps carried out for nothing.

If I understand the code correctly what this code does is force
looping over INTX status regs regardless of what linux IRQ number was
actually active.

You could do something faster by creating a matrix LinuxIRQ x INTx to
detect what INTx status register should actually be checked.

This seems overkill to me but it is not that complicated to implement
and may clarify the code (and avoid reading up to three registers for
nothing on the IRQ code path, which can make things faster too).

Lorenzo

> +		reg = ks_pcie_app_readl(ks_pcie, IRQ_STATUS(irq_no));
> +		if (!(reg & INTx_EN))
> +			continue;
> +		ks_pcie_handle_legacy_irq(ks_pcie, irq_no);
> +	}
> +
>  	chained_irq_exit(chip, desc);
>  }
>  
> -- 
> 2.17.1
> 
