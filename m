Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41049 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754407AbbIXWPT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 24 Sep 2015 18:15:19 -0400
Date: Thu, 24 Sep 2015 17:15:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: bhelgaas@google.com, l.stach@pengutronix.de,
	linux-pci@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH v2 1/2] PCI: imx6: Return the real error code
Message-ID: <20150924221515.GI10481@localhost>
References: <1441973333-3346-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1441973333-3346-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 11, 2015 at 09:08:52AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> When devm_request_irq() fails we should better return the real
> error code instead of returning a 'fake' one.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Applied both of these to pci/host-imx6 for v4.4 with changelogs:

  commit 89b2d4f14b147bcb499f5e7b1c6e6ce082a58e8f
  Author: Fabio Estevam <fabio.estevam@freescale.com>
  Date:   Fri Sep 11 09:08:52 2015 -0300

    PCI: imx6: Return real error code from imx6_add_pcie_port()
    
    When devm_request_irq() fails, imx6_add_pcie_port() should return the real
    error code instead of always returning -ENODEV.
    
    Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
    Signed-off-by: Bjorn Helgaas <helgaas@kernel.org>
    Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

  commit 80ec3f14471dfb2536bfc4de36980fb42361b6e4
  Author: Fabio Estevam <fabio.estevam@freescale.com>
  Date:   Fri Sep 11 09:08:53 2015 -0300

    PCI: imx6: Add #defines to improve code readability
    
    Add #defines and use them instead of hardcoded values.
    
    Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
    Signed-off-by: Bjorn Helgaas <helgaas@kernel.org>
    Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Thanks!

> ---
> Changes since v1:
> - None
> 
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
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
