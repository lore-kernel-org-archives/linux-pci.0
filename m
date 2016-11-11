Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934770AbcKKWaK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Nov 2016 17:30:10 -0500
Date: Fri, 11 Nov 2016 16:30:07 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        Brian Norris <computersforpeace@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH] PCI: rockchip: correct the use of FTS mask
Message-ID: <20161111223007.GT9868@bhelgaas-glaptop.roam.corp.google.com>
References: <1476832384-10215-1-git-send-email-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1476832384-10215-1-git-send-email-briannorris@chromium.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 18, 2016 at 04:13:04PM -0700, Brian Norris wrote:
> We're trying to mask out bits[23:8] while retaining [32:24, 7:0], but
> we're doing the inverse. That doesn't have too much effect, since we're
> setting all the [23:8] bits to 1, and the other bits are only relevant
> for modes we're currently not using. But we should get this right.
> 
> Fixes: ca1989084054 ("PCI: rockchip: Fix wrong transmitted FTS count")
> Signed-off-by: Brian Norris <briannorris@chromium.org>

I assume this is correct, but I'm waiting for an ack from Shawn.

> ---
>  drivers/pci/host/pcie-rockchip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index e0b22dab9b7a..5c2e3297a3ff 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -492,7 +492,7 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  
>  	/* Fix the transmitted FTS count desired to exit from L0s. */
>  	status = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL_PLC1);
> -	status = (status & PCIE_CORE_CTRL_PLC1_FTS_MASK) |
> +	status = (status & ~PCIE_CORE_CTRL_PLC1_FTS_MASK) |
>  		 (PCIE_CORE_CTRL_PLC1_FTS_CNT << PCIE_CORE_CTRL_PLC1_FTS_SHIFT);
>  	rockchip_pcie_write(rockchip, status, PCIE_CORE_CTRL_PLC1);
>  
> -- 
> 2.8.0.rc3.226.g39d4020
> 
