Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752617AbdGLRz2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jul 2017 13:55:28 -0400
Date: Wed, 12 Jul 2017 12:55:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] PCI: rockchip: fix wrong check of
 pci_scan_root_bus_bridge
Message-ID: <20170712175525.GC14614@bhelgaas-glaptop.roam.corp.google.com>
References: <1499768108-48891-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1499768108-48891-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 11, 2017 at 06:15:08PM +0800, Shawn Lin wrote:
> It's wrong to check the return value of pci_scan_root_bus_bridge
> here by using (!err) as 0 means it successfully scans the root
> bridge. So the probe process will be terminated mistakenly.
> 
> Fixes: ae13cb9b ("PCI: rockchip: Convert PCI scan API to ...")
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied with Lorenzo's ack to for-linus for v4.13, thanks!

> ---
> 
>  drivers/pci/host/pcie-rockchip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index 5acf869..7bb9870 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -1483,7 +1483,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  	bridge->swizzle_irq = pci_common_swizzle;
>  
>  	err = pci_scan_root_bus_bridge(bridge);
> -	if (!err)
> +	if (err < 0)
>  		goto err_free_res;
>  
>  	bus = bridge->bus;
> -- 
> 1.9.1
> 
> 
