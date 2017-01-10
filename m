Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:55649 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752056AbdAJLFL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2017 06:05:11 -0500
Message-ID: <1484046308.2888.5.camel@pengutronix.de>
Subject: Re: [PATCH] PCI: imx6: Remove redundant message
From: Lucas Stach <l.stach@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: bhelgaas@google.com, hongxing.zhu@nxp.com,
        linux-pci@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
Date: Tue, 10 Jan 2017 12:05:08 +0100
In-Reply-To: <1482849643-1861-1-git-send-email-festevam@gmail.com>
References: <1482849643-1861-1-git-send-email-festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Dienstag, den 27.12.2016, 12:40 -0200 schrieb Fabio Estevam:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> When a PCI card is not connected, the following messages are seen on mx6:
> 
> imx6q-pcie 1ffc000.pcie: phy link never came up
> imx6q-pcie 1ffc000.pcie: Link never came up
> 
> The first one comes from the pcie-designware.c core file, so remove
> the redundant one from the imx6 driver.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/pci/host/pci-imx6.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index c8cefb0..66c3b84 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -502,10 +502,8 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
>  			IMX6Q_GPR12_PCIE_CTL_2, 1 << 10);
>  
>  	ret = imx6_pcie_wait_for_link(imx6_pcie);
> -	if (ret) {
> -		dev_info(dev, "Link never came up\n");
> +	if (ret)
>  		goto err_reset_phy;
> -	}
>  
>  	if (imx6_pcie->link_gen == 2) {
>  		/* Allow Gen2 mode after the link is up. */


