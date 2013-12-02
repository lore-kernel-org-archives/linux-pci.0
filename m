Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:38426 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522Ab3LBIEq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Dec 2013 03:04:46 -0500
From: Marek Vasut <marex@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/2] PCI: imx6: Remove unneeded check of platform_get_resource()
Date: Mon, 2 Dec 2013 09:04:45 +0100
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
References: <1385955575-25270-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1385955575-25270-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201312020904.45124.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Fabio Estevam,

> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> When using devm_ioremap_resource(), we do not need to check the return
> value of platform_get_resource(), so just remove it.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Marek Vasut <marex@denx.de>

> ---
>  drivers/pci/host/pci-imx6.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index bd70af8..5002e23 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -426,11 +426,6 @@ static int __init imx6_pcie_probe(struct
> platform_device *pdev) "imprecise external abort");
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

Best regards,
Marek Vasut
