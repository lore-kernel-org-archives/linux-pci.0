Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57215 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750811AbbKYRet (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 25 Nov 2015 12:34:49 -0500
Date: Wed, 25 Nov 2015 11:34:45 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: bhelgaas@google.com, l.stach@pengutronix.de,
	linux-pci@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH] PCI: imx6: Use gpio_set_value_cansleep()
Message-ID: <20151125173445.GF1380@localhost>
References: <1445989318-26461-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445989318-26461-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 27, 2015 at 09:41:58PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> We are in a context where we can sleep, and the PCIe reset gpio may be
> on an I2C expander.  Use the cansleep() variant when setting the GPIO
> value.
> 
> Based on a patch from Russell King for pci-mvebu.c.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied with Lucas' Reviewed-by to pci/host-imx6 for v4.5, thanks!

> ---
>  drivers/pci/host/pci-imx6.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index 6f43086..e73b7f2 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -289,9 +289,9 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
>  
>  	/* Some boards don't have PCIe reset GPIO. */
>  	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> -		gpio_set_value(imx6_pcie->reset_gpio, 0);
> +		gpio_set_value_cansleep(imx6_pcie->reset_gpio, 0);
>  		msleep(100);
> -		gpio_set_value(imx6_pcie->reset_gpio, 1);
> +		gpio_set_value_cansleep(imx6_pcie->reset_gpio, 1);
>  	}
>  	return 0;
>  
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
