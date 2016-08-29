Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756203AbcH2X5t (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Aug 2016 19:57:49 -0400
Date: Mon, 29 Aug 2016 18:57:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        Brian Norris <computersforpeace@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: rockchip: Correct the register value for clearing
 client interrupts
Message-ID: <20160829235742.GB14177@localhost>
References: <1472505251-122204-1-git-send-email-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1472505251-122204-1-git-send-email-briannorris@chromium.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 29, 2016 at 02:14:11PM -0700, Brian Norris wrote:
> I'm pretty sure the bitwise 'or' was meant for the value parameter, not
> the register parameter.
> 
> This resolves an interrupt storm, where if we receive any client IRQs
> (e.g., correctable errors), we fail to ever clear them properly, so they
> reoccur indefinitely.
> 
> Fixes: 199410f6270e ("PCI: rockchip: Add Rockchip PCIe controller support")
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Cc: Shawn Lin <shawn.lin@rock-chips.com>

Shawn, please confirm.  If this patch is correct, I'll fold it into
the initial commit that adds the driver.

> ---
> Patched against git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/host-rockchip
> 
>  drivers/pci/host/pcie-rockchip.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index 8fb47ee9eaee..e77aec3cc869 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -689,9 +689,10 @@ static irqreturn_t rockchip_pcie_client_irq_handler(int irq, void *arg)
>  			      PCIE_CLIENT_INT_MSG | PCIE_CLIENT_INT_HOT_RST |
>  			      PCIE_CLIENT_INT_DPA | PCIE_CLIENT_INT_FATAL_ERR |
>  			      PCIE_CLIENT_INT_NFATAL_ERR |
> -			      PCIE_CLIENT_INT_CORR_ERR),
> -			      PCIE_CLIENT_INT_STATUS |
> -			      PCIE_CLIENT_INT_PHY);
> +			      PCIE_CLIENT_INT_CORR_ERR |
> +			      PCIE_CLIENT_INT_PHY),
> +		   PCIE_CLIENT_INT_STATUS);
> +
>  	return IRQ_HANDLED;
>  }
>  
> -- 
> 2.8.0.rc3.226.g39d4020
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
