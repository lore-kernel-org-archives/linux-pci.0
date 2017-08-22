Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752644AbdHVUhw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Aug 2017 16:37:52 -0400
Date: Tue, 22 Aug 2017 15:37:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: dra7xx: fix error return code in
 dra7xx_pcie_probe()
Message-ID: <20170822203750.GF6948@bhelgaas-glaptop.roam.corp.google.com>
References: <20170809161603.GA31297@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170809161603.GA31297@embeddedgus>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 09, 2017 at 11:16:03AM -0500, Gustavo A. R. Silva wrote:
> platform_get_irq() returns an error code, but the pci-dra7xx driver
> ignores it and always returns -EINVAL. This is not correct and,
> prevents -EPROBE_DEFER from being propagated properly.
> 
> Print and propagate the return value of platform_get_irq on failure.
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied with Kishon's ack to pci/host-dra7xx for v4.14, thanks!

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
> -- 
> 2.5.0
> 
