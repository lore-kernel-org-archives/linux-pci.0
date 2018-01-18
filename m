Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:33246 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932321AbeAROyh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jan 2018 09:54:37 -0500
Date: Thu, 18 Jan 2018 15:54:20 +0100
From: Ladislav Michl <ladis@linux-mips.org>
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] PCI: dra7xx: Fix potential NULL dereference
Message-ID: <20180118145420.GA21163@lenoch>
References: <1516284037-81537-1-git-send-email-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1516284037-81537-1-git-send-email-weiyongjun1@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 18, 2018 at 02:00:37PM +0000, Wei Yongjun wrote:
> platform_get_resource_byname() may fail and return NULL, so we should
> better check it's return value to avoid a NULL pointer dereference a
> bit later in the code.
> 
> This is detected by Coccinelle semantic patch.
> 
> @@
> expression pdev, res, n, t, e, e1, e2;
> @@
> 
> res = platform_get_resource_byname(pdev, t, n);
> + if (!res)
> +   return -EINVAL;
> ... when != res == NULL
> e = devm_ioremap(e1, res->start, e2);

Well, then it should be replaced with devm_ioremap_resource()
which already checks for NULL and the right resource type
(IORESOURCE_MEM).

	ladis

> Fixes: 608793e27b33 ("PCI: dwc: dra7xx: Add EP mode support")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/pci/dwc/pci-dra7xx.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
> index 8bf7c27..aafded8 100644
> --- a/drivers/pci/dwc/pci-dra7xx.c
> +++ b/drivers/pci/dwc/pci-dra7xx.c
> @@ -409,11 +409,15 @@ static int __init dra7xx_add_pcie_ep(struct dra7xx_pcie *dra7xx,
>  	ep->ops = &pcie_ep_ops;
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ep_dbics");
> +	if (!res)
> +		return -EINVAL;
>  	pci->dbi_base = devm_ioremap(dev, res->start, resource_size(res));
>  	if (!pci->dbi_base)
>  		return -ENOMEM;
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ep_dbics2");
> +	if (!res)
> +		return -EINVAL;
>  	pci->dbi_base2 = devm_ioremap(dev, res->start, resource_size(res));
>  	if (!pci->dbi_base2)
>  		return -ENOMEM;
> @@ -462,6 +466,8 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
>  		return ret;
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rc_dbics");
> +	if (!res)
> +		return -EINVAL;
>  	pci->dbi_base = devm_ioremap(dev, res->start, resource_size(res));
>  	if (!pci->dbi_base)
>  		return -ENOMEM;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
