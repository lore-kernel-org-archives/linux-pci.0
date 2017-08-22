Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751069AbdHVUvg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Aug 2017 16:51:36 -0400
Date: Tue, 22 Aug 2017 15:51:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: jingoohan1@gmail.com, Joao.Pinto@synopsys.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: dwc: Clear MSI interrupt status after it is handled
Message-ID: <20170822205134.GH6948@bhelgaas-glaptop.roam.corp.google.com>
References: <1502364295-3786-1-git-send-email-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1502364295-3786-1-git-send-email-faiz_abbas@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 10, 2017 at 04:54:55PM +0530, Faiz Abbas wrote:
> If the interrupt status is cleared before it is handled, it is possible
> that another interrupt will trigger while servicing the previous one.
> This is causing timeouts in some wireless lan cards which use pcie.
> Therefore, clear MSI interrupt status after it gets serviced instead
> of before calling generic_handler.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Applied with Joao's ack to pci/host-designware for v4.14, thanks!

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
> -- 
> 2.7.4
> 
