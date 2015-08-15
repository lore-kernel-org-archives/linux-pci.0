Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:36830 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799AbbHOQLl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 15 Aug 2015 12:11:41 -0400
Received: by oiev193 with SMTP id v193so58878826oie.3
        for <linux-pci@vger.kernel.org>; Sat, 15 Aug 2015 09:11:40 -0700 (PDT)
Date: Sat, 15 Aug 2015 11:11:34 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: linux-pci@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 1/4] PCI: imx6: Simplify a trivial if-return sequence
Message-ID: <20150815161134.GH26431@google.com>
References: <1439487436-26989-1-git-send-email-fabio.estevam@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1439487436-26989-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 13, 2015 at 02:37:13PM -0300, Fabio Estevam wrote:
> Simplify a trivial if-return sequence by combining it with a
> preceding function call.
> 
> The semantic patch that makes this change is available
> in scripts/coccinelle/misc/simple_return.cocci.
> 
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

I applied 1-3 to pci/misc for v4.3, thanks!

I dropped 4 ("PCI: ats: Use BUG_ON()") because I reworked
pci_restore_ats_state() so it no longer looks for the ATS capability:

https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=pci/iommu&id=a021f3019db7


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
> -- 
> 1.9.1
> 
