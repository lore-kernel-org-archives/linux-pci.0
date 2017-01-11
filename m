Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750793AbdAKVDG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Jan 2017 16:03:06 -0500
Date: Wed, 11 Jan 2017 15:03:02 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: bhelgaas@google.com, hongxing.zhu@nxp.com, l.stach@pengutronix.de,
        linux-pci@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH] PCI: imx6: Remove redundant message
Message-ID: <20170111210302.GK14532@bhelgaas-glaptop.roam.corp.google.com>
References: <1482849643-1861-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1482849643-1861-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 27, 2016 at 12:40:43PM -0200, Fabio Estevam wrote:
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

Applied to pci/host-imx6 for v4.11 with Lucas' Reviewed-by and the
following changelog:

    PCI: imx6: Remove redundant "Link never came up" message
    
    When a PCI card is not connected, the following messages are seen on mx6:
    
      imx6q-pcie 1ffc000.pcie: phy link never came up
      imx6q-pcie 1ffc000.pcie: Link never came up
    
    The first one comes from the pcie-designware.c core file, so remove
    the redundant one from the imx6 driver.
    
    Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
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
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
