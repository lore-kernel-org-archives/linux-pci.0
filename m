Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:41114 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbaE0W7q (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 May 2014 18:59:46 -0400
Received: by mail-ie0-f182.google.com with SMTP id x19so2202908ier.27
        for <linux-pci@vger.kernel.org>; Tue, 27 May 2014 15:59:45 -0700 (PDT)
Date: Tue, 27 May 2014 16:59:41 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: exynos: Remove unnecessary OOM messages
Message-ID: <20140527225941.GF11907@google.com>
References: <000301cf6b47$eb8de9f0$c2a9bdd0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000301cf6b47$eb8de9f0$c2a9bdd0$%han@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 09, 2014 at 02:31:25PM +0900, Jingoo Han wrote:
> The site-specific OOM messages are unnecessary, because they
> duplicate the MM subsystem generic OOM message.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied to pci/host-exynos for v3.16, thanks!

> ---
>  drivers/pci/host/pci-exynos.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
> index 3de6bfb..81aa700 100644
> --- a/drivers/pci/host/pci-exynos.c
> +++ b/drivers/pci/host/pci-exynos.c
> @@ -568,10 +568,8 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
>  
>  	exynos_pcie = devm_kzalloc(&pdev->dev, sizeof(*exynos_pcie),
>  				GFP_KERNEL);
> -	if (!exynos_pcie) {
> -		dev_err(&pdev->dev, "no memory for exynos pcie\n");
> +	if (!exynos_pcie)
>  		return -ENOMEM;
> -	}
>  
>  	pp = &exynos_pcie->pp;
>  
> -- 
> 1.7.10.4
> 
> 
