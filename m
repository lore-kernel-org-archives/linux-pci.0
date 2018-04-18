Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:52401 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752414AbeDRU7f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Apr 2018 16:59:35 -0400
Date: Wed, 18 Apr 2018 22:59:30 +0200
From: Jesper Nilsson <jesper.nilsson@axis.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: bhelgaas@google.com, lorenzo.pieralisi@arm.com, jespern@axis.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: artpec6: Use devm_ioremap_resource instead of
 devm_ioremap_resource
Message-ID: <20180418205930.GY16746@axis.com>
References: <828d8a53d85be073672fec67ee6980818dc459ab.1524038460.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <828d8a53d85be073672fec67ee6980818dc459ab.1524038460.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 18, 2018 at 09:06:33AM +0100, Gustavo Pimentel wrote:
> This fix aims to replace the use of devm_ioremap() by
> devm_ioremap_resource() already discussed on [1].
> 
> [1] -> https://patchwork.kernel.org/patch/10173831/
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

Looks good:

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> ---
>  drivers/pci/dwc/pcie-artpec6.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pcie-artpec6.c b/drivers/pci/dwc/pcie-artpec6.c
> index e66cede..321b56c 100644
> --- a/drivers/pci/dwc/pcie-artpec6.c
> +++ b/drivers/pci/dwc/pcie-artpec6.c
> @@ -463,9 +463,9 @@ static int artpec6_add_pcie_ep(struct artpec6_pcie *artpec6_pcie,
>  	ep->ops = &pcie_ep_ops;
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi2");
> -	pci->dbi_base2 = devm_ioremap(dev, res->start, resource_size(res));
> -	if (!pci->dbi_base2)
> -		return -ENOMEM;
> +	pci->dbi_base2 = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(pci->dbi_base2))
> +		return PTR_ERR(pci->dbi_base2);
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
>  	if (!res)
> -- 
> 2.7.4
> 

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
