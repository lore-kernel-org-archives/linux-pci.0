Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:53540 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751022AbdIAGoS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Sep 2017 02:44:18 -0400
Subject: Re: [PATCH 02/10] PCI: dra7xx: Fix platform_get_irq() error handling
To: Fabio Estevam <fabio.estevam@nxp.com>, <bhelgaas@google.com>
References: <1504201930-3617-1-git-send-email-fabio.estevam@nxp.com>
 <1504201930-3617-2-git-send-email-fabio.estevam@nxp.com>
CC: <linux-pci@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <640d0339-0263-4026-e16f-e4fbc68f1e7e@ti.com>
Date: Fri, 1 Sep 2017 12:13:34 +0530
MIME-Version: 1.0
In-Reply-To: <1504201930-3617-2-git-send-email-fabio.estevam@nxp.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Thursday 31 August 2017 11:22 PM, Fabio Estevam wrote:
> When platform_get_irq() fails we should propagate the real error
> value instead of always returning -EINVAL.
> 
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/dwc/pci-dra7xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
> index e0dd98d..1e2aaed 100644
> --- a/drivers/pci/dwc/pci-dra7xx.c
> +++ b/drivers/pci/dwc/pci-dra7xx.c
> @@ -450,7 +450,7 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
>  	pp->irq = platform_get_irq(pdev, 1);
>  	if (pp->irq < 0) {
>  		dev_err(dev, "missing IRQ resource\n");
> -		return -EINVAL;
> +		return pp->irq;
>  	}
>  
>  	ret = devm_request_irq(dev, pp->irq, dra7xx_pcie_msi_irq_handler,
> 
