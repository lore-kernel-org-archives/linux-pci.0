Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yh0-f54.google.com ([209.85.213.54]:35153 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933127Ab3LIVn3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Dec 2013 16:43:29 -0500
Received: by mail-yh0-f54.google.com with SMTP id z12so3255438yhz.27
        for <linux-pci@vger.kernel.org>; Mon, 09 Dec 2013 13:43:28 -0800 (PST)
Date: Mon, 9 Dec 2013 14:43:24 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: marex@denx.de, linux-pci@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/2] PCI: imx6: Remove unneeded check of
 platform_get_resource()
Message-ID: <20131209214324.GB2135@google.com>
References: <1385955575-25270-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1385955575-25270-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Shawn]

On Mon, Dec 02, 2013 at 01:39:34AM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> When using devm_ioremap_resource(), we do not need to check the return value of
> platform_get_resource(), so just remove it.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

I applied this with Marek's ack to pci/host-imx6 for v3.14.

Shawn, let me know if you object.  It looks correct to me because
devm_ioremap_resource() checks for res being NULL.

> ---
>  drivers/pci/host/pci-imx6.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index bd70af8..5002e23 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -426,11 +426,6 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>  		"imprecise external abort");
>  
>  	dbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!dbi_base) {
> -		dev_err(&pdev->dev, "dbi_base memory resource not found\n");
> -		return -ENODEV;
> -	}
> -
>  	pp->dbi_base = devm_ioremap_resource(&pdev->dev, dbi_base);
>  	if (IS_ERR(pp->dbi_base)) {
>  		ret = PTR_ERR(pp->dbi_base);
> -- 
> 1.8.1.2
> 
