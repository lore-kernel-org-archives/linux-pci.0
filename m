Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:54838 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933429AbaKMRuQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Nov 2014 12:50:16 -0500
Received: by mail-pd0-f178.google.com with SMTP id fp1so14818767pdb.23
        for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2014 09:50:16 -0800 (PST)
Date: Thu, 13 Nov 2014 10:50:12 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-pci@vger.kernel.org, 'Richard Zhu' <r65037@freescale.com>,
	'Lucas Stach' <l.stach@pengutronix.de>
Subject: Re: [PATCH] PCI: imx6: Use tabs for indentation
Message-ID: <20141113175012.GM5064@google.com>
References: <002801cffe28$43176f70$c9464e50$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <002801cffe28$43176f70$c9464e50$%han@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 12, 2014 at 12:25:09PM +0900, Jingoo Han wrote:
> This patch fixes the following checkpatch error.
> 
>   ERROR: code indent should use tabs where possible
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied to pci/host-imx6 for v3.19, thanks!

Richard and Lucas, let me know if you have any objection.

> ---
>  drivers/pci/host/pci-imx6.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index 233fe8a..8a7530b 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -526,8 +526,8 @@ static int __init imx6_add_pcie_port(struct pcie_port *pp,
>  		}
>  
>  		ret = devm_request_irq(&pdev->dev, pp->msi_irq,
> -		                       imx6_pcie_msi_handler,
> -		                       IRQF_SHARED, "mx6-pcie-msi", pp);
> +				       imx6_pcie_msi_handler,
> +				       IRQF_SHARED, "mx6-pcie-msi", pp);
>  		if (ret) {
>  			dev_err(&pdev->dev, "failed to request MSI irq\n");
>  			return -ENODEV;
> -- 
> 1.7.9.5
> 
> 
