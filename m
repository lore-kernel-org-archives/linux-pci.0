Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932930AbdCGSwl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Mar 2017 13:52:41 -0500
Date: Tue, 7 Mar 2017 12:52:37 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        jingoohan1@gmail.com
Subject: Re: [PATCH] PCI: exynos: fix the NULL pointer dereference about
 elbi_base
Message-ID: <20170307185237.GC21358@bhelgaas-glaptop.roam.corp.google.com>
References: <CGME20170307105407epcas5p3e77181793b26a5d2710bb6d7557033bb@epcas5p3.samsung.com>
 <20170307105405.7874-1-jh80.chung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170307105405.7874-1-jh80.chung@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 07, 2017 at 07:54:05PM +0900, Jaehoon Chung wrote:
> Even though using phy framework, it has to get the elbi_base.
> Before this patch, elbi_base should be NULL pointer.
> 
> Fixes: e7cd7ef58e1f ("PCI: exynos: Support the PHY generic framework")
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

Provisionally applied to for-linus for v4.11, pending Jingoo's ack.
Thanks, Jaehoon!

> ---
>  drivers/pci/dwc/pci-exynos.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pci-exynos.c b/drivers/pci/dwc/pci-exynos.c
> index 993b650..44f774c 100644
> --- a/drivers/pci/dwc/pci-exynos.c
> +++ b/drivers/pci/dwc/pci-exynos.c
> @@ -132,10 +132,6 @@ static int exynos5440_pcie_get_mem_resources(struct platform_device *pdev,
>  	struct device *dev = pci->dev;
>  	struct resource *res;
>  
> -	/* If using the PHY framework, doesn't need to get other resource */
> -	if (ep->using_phy)
> -		return 0;
> -
>  	ep->mem_res = devm_kzalloc(dev, sizeof(*ep->mem_res), GFP_KERNEL);
>  	if (!ep->mem_res)
>  		return -ENOMEM;
> @@ -145,6 +141,10 @@ static int exynos5440_pcie_get_mem_resources(struct platform_device *pdev,
>  	if (IS_ERR(ep->mem_res->elbi_base))
>  		return PTR_ERR(ep->mem_res->elbi_base);
>  
> +	/* If using the PHY framework, doesn't need to get other resource */
> +	if (ep->using_phy)
> +		return 0;
> +
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>  	ep->mem_res->phy_base = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(ep->mem_res->phy_base))
> -- 
> 2.10.2
> 
