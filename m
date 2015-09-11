Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51607 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbbIKIZd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Sep 2015 04:25:33 -0400
Message-ID: <1441959930.3126.0.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] PCI: imx6: Return the real error code
From: Lucas Stach <l.stach@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Date: Fri, 11 Sep 2015 10:25:30 +0200
In-Reply-To: <1441928609-21921-1-git-send-email-festevam@gmail.com>
References: <1441928609-21921-1-git-send-email-festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Donnerstag, den 10.09.2015, 20:43 -0300 schrieb Fabio Estevam:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> When devm_request_irq() fails we should better return the real
> error code instead of returning a 'fake' one.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/pci/host/pci-imx6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index 8f3a981..2d0d0fe 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -539,7 +539,7 @@ static int __init imx6_add_pcie_port(struct pcie_port *pp,
>  				       IRQF_SHARED, "mx6-pcie-msi", pp);
>  		if (ret) {
>  			dev_err(&pdev->dev, "failed to request MSI irq\n");
> -			return -ENODEV;
> +			return ret;
>  		}
>  	}
>  

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

