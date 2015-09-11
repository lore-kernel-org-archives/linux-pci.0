Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34488 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbbIKIlA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Sep 2015 04:41:00 -0400
Message-ID: <1441960857.3126.4.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] PCI: imx6: Add some defines for improving code
 readability
From: Lucas Stach <l.stach@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Date: Fri, 11 Sep 2015 10:40:57 +0200
In-Reply-To: <1441928609-21921-2-git-send-email-festevam@gmail.com>
References: <1441928609-21921-1-git-send-email-festevam@gmail.com>
	 <1441928609-21921-2-git-send-email-festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Donnerstag, den 10.09.2015, 20:43 -0300 schrieb Fabio Estevam:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Instead of having some hardcoded values, it is preferred to use
> defines when possible.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/pci/host/pci-imx6.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index 2d0d0fe..f7a3951 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -55,6 +55,7 @@ struct imx6_pcie {
>  #define PCIE_PL_PFLR_LINK_STATE_MASK		(0x3f << 16)
>  #define PCIE_PL_PFLR_FORCE_LINK			(1 << 15)
>  #define PCIE_PHY_DEBUG_R0 (PL_OFFSET + 0x28)
> +#define PCIE_PHY_DEBUG_R0_LTSSM_MASK		0x3f
>  #define PCIE_PHY_DEBUG_R1 (PL_OFFSET + 0x2c)
>  #define PCIE_PHY_DEBUG_R1_XMLH_LINK_IN_TRAINING	(1 << 29)
>  #define PCIE_PHY_DEBUG_R1_XMLH_LINK_UP		(1 << 4)
> @@ -74,6 +75,7 @@ struct imx6_pcie {
>  
>  /* PHY registers (not memory-mapped) */
>  #define PCIE_PHY_RX_ASIC_OUT 0x100D
> +#define PCIE_PHY_RX_ASIC_OUT_VALID	1

I know these defines are a bit inconsistent right now, but for new
defines I would like them in a way that they are clearly visible as a
bitfields. Please change this to (1 << 0).

For the LTSSM_MASK the same logic might also improve readability.

Regards,
Lucas

>  
>  #define PHY_RX_OVRD_IN_LO 0x1005
>  #define PHY_RX_OVRD_IN_LO_RX_DATA_EN (1 << 5)
> @@ -503,10 +505,10 @@ static int imx6_pcie_link_up(struct pcie_port *pp)
>  	pcie_phy_read(pp->dbi_base, PCIE_PHY_RX_ASIC_OUT, &rx_valid);
>  	debug_r0 = readl(pp->dbi_base + PCIE_PHY_DEBUG_R0);
>  
> -	if (rx_valid & 0x01)
> +	if (rx_valid & PCIE_PHY_RX_ASIC_OUT_VALID)
>  		return 0;
>  
> -	if ((debug_r0 & 0x3f) != 0x0d)
> +	if ((debug_r0 & PCIE_PHY_DEBUG_R0_LTSSM_MASK) != 0x0d)
>  		return 0;
>  
>  	dev_err(pp->dev, "transition to gen2 is stuck, reset PHY!\n");

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

