Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936602AbcKKVVs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Nov 2016 16:21:48 -0500
Date: Fri, 11 Nov 2016 15:21:43 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Ley Foon Tan <lftan@altera.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        rfi@lists.rocketboards.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH -next] PCI: altera: Remove redundant dev_err call in
 altera_pcie_parse_dt()
Message-ID: <20161111212143.GH9868@bhelgaas-glaptop.roam.corp.google.com>
References: <1476716173-31310-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1476716173-31310-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 17, 2016 at 02:56:13PM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Applied with Ley Foon Tan's ack to pci/host-altera for v4.10, thanks!

> ---
>  drivers/pci/host/pcie-altera.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
> index b0ac4df..8be45a8 100644
> --- a/drivers/pci/host/pcie-altera.c
> +++ b/drivers/pci/host/pcie-altera.c
> @@ -550,10 +550,8 @@ static int altera_pcie_parse_dt(struct altera_pcie *pcie)
>  
>  	cra = platform_get_resource_byname(pdev, IORESOURCE_MEM, "Cra");
>  	pcie->cra_base = devm_ioremap_resource(dev, cra);
> -	if (IS_ERR(pcie->cra_base)) {
> -		dev_err(dev, "failed to map cra memory\n");
> +	if (IS_ERR(pcie->cra_base))
>  		return PTR_ERR(pcie->cra_base);
> -	}
>  
>  	/* setup IRQ */
>  	pcie->irq = platform_get_irq(pdev, 0);
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
