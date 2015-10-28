Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:35733 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964855AbbJ1Iro (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 Oct 2015 04:47:44 -0400
Message-ID: <1446022061.3138.4.camel@pengutronix.de>
Subject: Re: [PATCH] PCI: imx6: Use gpio_set_value_cansleep()
From: Lucas Stach <l.stach@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Date: Wed, 28 Oct 2015 09:47:41 +0100
In-Reply-To: <1445989318-26461-1-git-send-email-festevam@gmail.com>
References: <1445989318-26461-1-git-send-email-festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Dienstag, den 27.10.2015, 21:41 -0200 schrieb Fabio Estevam:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> We are in a context where we can sleep, and the PCIe reset gpio may be
> on an I2C expander.  Use the cansleep() variant when setting the GPIO
> value.
> 
> Based on a patch from Russell King for pci-mvebu.c.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Simple enough,

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

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

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

