Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:34381 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753829AbaBSWCL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Feb 2014 17:02:11 -0500
Received: by mail-ig0-f175.google.com with SMTP id uq10so10437475igb.2
        for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2014 14:02:10 -0800 (PST)
Date: Wed, 19 Feb 2014 15:02:07 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: s.hauer@pengutronix.de, marex@denx.de, linux-pci@vger.kernel.org,
	kernel@pengutronix.de, r65037@freescale.com, shawn.guo@linaro.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] pci-imx6.c: wait for retraining
Message-ID: <20140219220207.GB19233@google.com>
References: <1392841338-13527-1-git-send-email-troy.kisky@boundarydevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392841338-13527-1-git-send-email-troy.kisky@boundarydevices.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 19, 2014 at 01:22:18PM -0700, Troy Kisky wrote:
> From: Marek Vasut <marex@denx.de>
> 
> This patch handles the case where the PCIe link is up and running, yet drops
> into the LTSSM training mode. The link spends short time in the LTSSM training
> mode, but the current code can misinterpret it as the link being stalled.
> Waiting for the LTSSM training to complete fixes the issue.
> 
> Quoting Sascha, "This is broken since
> commit e6daf4a5e1b813bc7f85507ec83b8c2452c121e6
> PCI: imx6: Report "link up" only after link training completes
> 
> The designware driver changes the PORT_LOGIC_SPEED_CHANGE bit in
> dw_pcie_host_init() which causes the link to be retrained. During the next call
> to dw_pcie_rd_conf() the link is then reported being down and the function
> returns PCIBIOS_DEVICE_NOT_FOUND resulting in nonfunctioning PCIe."
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Tested-by: Troy Kisky <troy.kisky@boundarydevices.com>
> Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

Applied to pci/host-imx6 for v3.15, thanks!

I changed the SHA1 in the changelog from
e6daf4a5e1b813bc7f85507ec83b8c2452c121e6 to 7f9f40c01cce, because I think
that's what's in the upstream tree.

Bjorn

> ---
>  drivers/pci/host/pci-imx6.c | 47 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 34 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index e8663a8..ee08250 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -424,20 +424,40 @@ static void imx6_pcie_reset_phy(struct pcie_port *pp)
>  
>  static int imx6_pcie_link_up(struct pcie_port *pp)
>  {
> -	u32 rc, ltssm, rx_valid;
> +	u32 rc, debug_r0, rx_valid;
> +	int count = 5;
>  
>  	/*
> -	 * Test if the PHY reports that the link is up and also that
> -	 * the link training finished.  It might happen that the PHY
> -	 * reports the link is already up, but the link training bit
> -	 * is still set, so make sure to check the training is done
> -	 * as well here.
> +	 * Test if the PHY reports that the link is up and also that the LTSSM
> +	 * training finished. There are three possible states of the link when
> +	 * this code is called:
> +	 * 1) The link is DOWN (unlikely)
> +	 *     The link didn't come up yet for some reason. This usually means
> +	 *     we have a real problem somewhere. Reset the PHY and exit. This
> +	 *     state calls for inspection of the DEBUG registers.
> +	 * 2) The link is UP, but still in LTSSM training
> +	 *     Wait for the training to finish, which should take a very short
> +	 *     time. If the training does not finish, we have a problem and we
> +	 *     need to inspect the DEBUG registers. If the training does finish,
> +	 *     the link is up and operating correctly.
> +	 * 3) The link is UP and no longer in LTSSM training
> +	 *     The link is up and operating correctly.
>  	 */
> -	rc = readl(pp->dbi_base + PCIE_PHY_DEBUG_R1);
> -	if ((rc & PCIE_PHY_DEBUG_R1_XMLH_LINK_UP) &&
> -	    !(rc & PCIE_PHY_DEBUG_R1_XMLH_LINK_IN_TRAINING))
> -		return 1;
> -
> +	while (1) {
> +		rc = readl(pp->dbi_base + PCIE_PHY_DEBUG_R1);
> +		if (!(rc & PCIE_PHY_DEBUG_R1_XMLH_LINK_UP))
> +			break;
> +		if (!(rc & PCIE_PHY_DEBUG_R1_XMLH_LINK_IN_TRAINING))
> +			return 1;
> +		if (!count--)
> +			break;
> +		dev_dbg(pp->dev, "Link is up, but still in training\n");
> +		/*
> +		 * Wait a little bit, then re-check if the link finished
> +		 * the training.
> +		 */
> +		usleep_range(1000, 2000);
> +	}
>  	/*
>  	 * From L0, initiate MAC entry to gen2 if EP/RC supports gen2.
>  	 * Wait 2ms (LTSSM timeout is 24ms, PHY lock is ~5us in gen2).
> @@ -446,15 +466,16 @@ static int imx6_pcie_link_up(struct pcie_port *pp)
>  	 * to gen2 is stuck
>  	 */
>  	pcie_phy_read(pp->dbi_base, PCIE_PHY_RX_ASIC_OUT, &rx_valid);
> -	ltssm = readl(pp->dbi_base + PCIE_PHY_DEBUG_R0) & 0x3F;
> +	debug_r0 = readl(pp->dbi_base + PCIE_PHY_DEBUG_R0);
>  
>  	if (rx_valid & 0x01)
>  		return 0;
>  
> -	if (ltssm != 0x0d)
> +	if ((debug_r0 & 0x3f) != 0x0d)
>  		return 0;
>  
>  	dev_err(pp->dev, "transition to gen2 is stuck, reset PHY!\n");
> +	dev_dbg(pp->dev, "debug_r0=%08x debug_r1=%08x\n", debug_r0, rc);
>  
>  	imx6_pcie_reset_phy(pp);
>  
> -- 
> 1.8.1.2
> 
