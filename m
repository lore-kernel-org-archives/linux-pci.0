Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34470 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753510AbbHNIuA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 14 Aug 2015 04:50:00 -0400
Message-ID: <1439542197.13210.37.camel@pengutronix.de>
Subject: Re: [PATCH 1/4] PCI: imx6: Simplify a trivial if-return sequence
From: Lucas Stach <l.stach@pengutronix.de>
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org
Date: Fri, 14 Aug 2015 10:49:57 +0200
In-Reply-To: <1439487436-26989-1-git-send-email-fabio.estevam@freescale.com>
References: <1439487436-26989-1-git-send-email-fabio.estevam@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Donnerstag, den 13.08.2015, 14:37 -0300 schrieb Fabio Estevam:
> Simplify a trivial if-return sequence by combining it with a
> preceding function call.
> 
> The semantic patch that makes this change is available
> in scripts/coccinelle/misc/simple_return.cocci.
> 
I don't really see that this helps code clarity/readability, but it
certainly also doesn't make things harder to follow.

So if Bjorn wants to take the series I'm okay with this going in.

Regards,
Lucas

> Cc: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/pci/host/pci-imx6.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index 233a196..8f3a981 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -117,11 +117,7 @@ static int pcie_phy_wait_ack(void __iomem *dbi_base, int addr)
>  	val = addr << PCIE_PHY_CTRL_DATA_LOC;
>  	writel(val, dbi_base + PCIE_PHY_CTRL);
>  
> -	ret = pcie_phy_poll_ack(dbi_base, 0);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return pcie_phy_poll_ack(dbi_base, 0);
>  }
>  
>  /* Read from the 16-bit PCIe PHY control registers (not memory-mapped) */
> @@ -148,11 +144,7 @@ static int pcie_phy_read(void __iomem *dbi_base, int addr , int *data)
>  	/* deassert Read signal */
>  	writel(0x00, dbi_base + PCIE_PHY_CTRL);
>  
> -	ret = pcie_phy_poll_ack(dbi_base, 0);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return pcie_phy_poll_ack(dbi_base, 0);
>  }
>  
>  static int pcie_phy_write(void __iomem *dbi_base, int addr, int data)

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

