Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756240AbcHVTXy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Aug 2016 15:23:54 -0400
Date: Mon, 22 Aug 2016 14:23:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH -next] PCI: designware-plat: Remove redundant return
 value check of platform_get_resource()
Message-ID: <20160822192346.GI18628@localhost>
References: <1469722494-14701-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1469722494-14701-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 28, 2016 at 04:14:54PM +0000, Wei Yongjun wrote:
> Remove unneeded error handling on the result of a call
> to platform_get_resource() when the value is passed to
> devm_ioremap_resource().
> 
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>

Applied to pci/host-designware for v4.9, thanks!

I'll also post a similar patch for altera, and a sort-of-similar one
for rcar.

> ---
>  drivers/pci/host/pcie-designware-plat.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-designware-plat.c b/drivers/pci/host/pcie-designware-plat.c
> index c8079dc..17da005 100644
> --- a/drivers/pci/host/pcie-designware-plat.c
> +++ b/drivers/pci/host/pcie-designware-plat.c
> @@ -100,9 +100,6 @@ static int dw_plat_pcie_probe(struct platform_device *pdev)
>  	pp->dev = &pdev->dev;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res)
> -		return -ENODEV;
> -
>  	dw_plat_pcie->mem_base = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(dw_plat_pcie->mem_base))
>  		return PTR_ERR(dw_plat_pcie->mem_base);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
