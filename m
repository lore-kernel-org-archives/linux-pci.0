Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:54677 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616AbbJLQGY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Oct 2015 12:06:24 -0400
Message-ID: <1444665981.3364.21.camel@pengutronix.de>
Subject: Re: [PATCH v3 3/3] PCI: imx6: Use the common LTSSM state mask
From: Lucas Stach <l.stach@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: bhelgaas@google.com, pratyush.anand@gmail.com, m-karicheri2@ti.com,
	linux-pci@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Date: Mon, 12 Oct 2015 18:06:21 +0200
In-Reply-To: <1444664808-16445-3-git-send-email-festevam@gmail.com>
References: <1444664808-16445-1-git-send-email-festevam@gmail.com>
	 <1444664808-16445-3-git-send-email-festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Montag, den 12.10.2015, 12:46 -0300 schrieb Fabio Estevam:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Use the common LTSSM_STATE_MASK instead of a local definition.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
> Changes since v2:
> - Newly introduced in this version.
> 
>  drivers/pci/host/pci-imx6.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index 4e7b577..4c788d27 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -55,7 +55,6 @@ struct imx6_pcie {
>  #define PCIE_PL_PFLR_LINK_STATE_MASK		(0x3f << 16)
>  #define PCIE_PL_PFLR_FORCE_LINK			(1 << 15)
>  #define PCIE_PHY_DEBUG_R0 (PL_OFFSET + 0x28)
> -#define PCIE_PHY_DEBUG_R0_LTSSM_MASK		(0x3f << 0)
>  #define PCIE_PHY_DEBUG_R1 (PL_OFFSET + 0x2c)
>  #define PCIE_PHY_DEBUG_R1_XMLH_LINK_IN_TRAINING	(1 << 29)
>  #define PCIE_PHY_DEBUG_R1_XMLH_LINK_UP		(1 << 4)
> @@ -508,7 +507,7 @@ static int imx6_pcie_link_up(struct pcie_port *pp)
>  	if (rx_valid & PCIE_PHY_RX_ASIC_OUT_VALID)
>  		return 0;
>  
> -	if ((debug_r0 & PCIE_PHY_DEBUG_R0_LTSSM_MASK) != LTSSM_STATE_RCVRY_LOCK)
> +	if ((debug_r0 & LTSSM_STATE_MASK) != LTSSM_STATE_RCVRY_LOCK)
>  		return 0;
>  
>  	dev_err(pp->dev, "transition to gen2 is stuck, reset PHY!\n");

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

