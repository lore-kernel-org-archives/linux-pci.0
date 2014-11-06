Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53516 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750782AbaKFFHE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 6 Nov 2014 00:07:04 -0500
Message-ID: <545B01F1.7070009@ti.com>
Date: Thu, 6 Nov 2014 10:36:57 +0530
From: Kishon Vijay Abraham I <kishon@ti.com>
MIME-Version: 1.0
To: Jingoo Han <jg1.han@samsung.com>,
	"'Bjorn Helgaas'" <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: dra7xx: Add dra7xx prefix before add_pcie_port
References: <001301cff95e$a124f6b0$e36ee410$%han@samsung.com>
In-Reply-To: <001301cff95e$a124f6b0$e36ee410$%han@samsung.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Thursday 06 November 2014 06:41 AM, Jingoo Han wrote:
> The add_pcie_port function is dra7xx-specific. Add exynos prefix
> to avoid collision in global name space.

%s/exynos/dra7xx

After fixing this you can add
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/pci/host/pci-dra7xx.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
> index 52b34fe..5b4a644 100644
> --- a/drivers/pci/host/pci-dra7xx.c
> +++ b/drivers/pci/host/pci-dra7xx.c
> @@ -270,8 +270,8 @@ static irqreturn_t dra7xx_pcie_irq_handler(int irq, void *arg)
>  	return IRQ_HANDLED;
>  }
>  
> -static int add_pcie_port(struct dra7xx_pcie *dra7xx,
> -			  struct platform_device *pdev)
> +static int dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
> +				struct platform_device *pdev)
>  {
>  	int ret;
>  	struct pcie_port *pp;
> @@ -398,7 +398,7 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, dra7xx);
>  
> -	ret = add_pcie_port(dra7xx, pdev);
> +	ret = dra7xx_add_pcie_port(dra7xx, pdev);
>  	if (ret < 0)
>  		goto err_add_port;
>  
> 
