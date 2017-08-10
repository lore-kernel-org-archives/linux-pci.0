Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:34293 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751391AbdHJFkj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2017 01:40:39 -0400
Subject: Re: [PATCH] PCI: dwc: dra7xx: fix error return code in
 dra7xx_pcie_probe()
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20170809161603.GA31297@embeddedgus>
CC: <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <6aedb314-9765-92f0-c3e2-a1fc6e6c4b95@ti.com>
Date: Thu, 10 Aug 2017 11:10:24 +0530
MIME-Version: 1.0
In-Reply-To: <20170809161603.GA31297@embeddedgus>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Wednesday 09 August 2017 09:46 PM, Gustavo A. R. Silva wrote:
> platform_get_irq() returns an error code, but the pci-dra7xx driver
> ignores it and always returns -EINVAL. This is not correct and,
> prevents -EPROBE_DEFER from being propagated properly.
> 
> Print and propagate the return value of platform_get_irq on failure.
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/dwc/pci-dra7xx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
> index f2fc5f4..f58e1b4 100644
> --- a/drivers/pci/dwc/pci-dra7xx.c
> +++ b/drivers/pci/dwc/pci-dra7xx.c
> @@ -616,8 +616,8 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
> -		dev_err(dev, "missing IRQ resource\n");
> -		return -EINVAL;
> +		dev_err(dev, "missing IRQ resource: %d\n", irq);
> +		return irq;
>  	}
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ti_conf");
> 
