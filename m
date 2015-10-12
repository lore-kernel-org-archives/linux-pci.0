Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:46064 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbbJLK34 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Oct 2015 06:29:56 -0400
Message-ID: <1444645794.3364.10.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/2] PCI: imx6: Use define instead of hard coded value
From: Lucas Stach <l.stach@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: bhelgaas@google.com, pratyush.anand@gmail.com, m-karicheri2@ti.com,
	linux-pci@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Date: Mon, 12 Oct 2015 12:29:54 +0200
In-Reply-To: <1444355306-21486-2-git-send-email-festevam@gmail.com>
References: <1444355306-21486-1-git-send-email-festevam@gmail.com>
	 <1444355306-21486-2-git-send-email-festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Donnerstag, den 08.10.2015, 22:48 -0300 schrieb Fabio Estevam:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Use LTSSM_STATE_RCVRY_LOCK define instead of hard coded value in order
> to improve the code readability;
> 
Normally we end sentences to be parsed by humans with a full stop
instead of a semicolon. ;)

> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
> Changes since v1:
> - None
> 
>  drivers/pci/host/pci-imx6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index 6f43086..4e7b577 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivePCIE_PHY_DEBUG_R0_LTSSM_MASKrs/pci/host/pci-imx6.c
> @@ -508,7 +508,7 @@ static int imx6_pcie_link_up(struct pcie_port *pp)
>  	if (rx_valid & PCIE_PHY_RX_ASIC_OUT_VALID)
>  		return 0;
>  
> -	if ((debug_r0 & PCIE_PHY_DEBUG_R0_LTSSM_MASK) != 0x0d)
> +	if ((debug_r0 & PCIE_PHY_DEBUG_R0_LTSSM_MASK) != LTSSM_STATE_RCVRY_LOCK)
>  		return 0;
>  
>  	dev_err(pp->dev, "transition to gen2 is stuck, reset PHY!\n");

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

