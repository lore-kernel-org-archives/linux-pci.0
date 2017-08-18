Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:57141 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750808AbdHRLni (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2017 07:43:38 -0400
Subject: Re: [PATCH] pci: dwc: Clear MSI interrupt status after it is handled
To: Faiz Abbas <faiz_abbas@ti.com>, <jingoohan1@gmail.com>,
        <Joao.Pinto@synopsys.com>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1502364295-3786-1-git-send-email-faiz_abbas@ti.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <d2cc42c1-21eb-56b3-8253-6ce37ed55f05@synopsys.com>
Date: Fri, 18 Aug 2017 12:43:05 +0100
MIME-Version: 1.0
In-Reply-To: <1502364295-3786-1-git-send-email-faiz_abbas@ti.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

Às 12:24 PM de 8/10/2017, Faiz Abbas escreveu:
> If the interrupt status is cleared before it is handled, it is possible
> that another interrupt will trigger while servicing the previous one.
> This is causing timeouts in some wireless lan cards which use pcie.
> Therefore, clear MSI interrupt status after it gets serviced instead
> of before calling generic_handler.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  drivers/pci/dwc/pcie-designware-host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
> index 28ed32b..78b2584 100644
> --- a/drivers/pci/dwc/pcie-designware-host.c
> +++ b/drivers/pci/dwc/pcie-designware-host.c
> @@ -71,9 +71,9 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>  		while ((pos = find_next_bit((unsigned long *) &val, 32,
>  					    pos)) != 32) {
>  			irq = irq_find_mapping(pp->irq_domain, i * 32 + pos);
> +			generic_handle_irq(irq);
>  			dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + i * 12,
>  					    4, 1 << pos);
> -			generic_handle_irq(irq);
>  			pos++;
>  		}
>  	}
> 

It makes sense.

Acked-By: Joao Pinto <jpinto@synopsys.com>
