Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43146 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755432AbdGKKgd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Jul 2017 06:36:33 -0400
Date: Tue, 11 Jul 2017 11:38:11 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH] PCI: rockchip: fix wrong check of
 pci_scan_root_bus_bridge
Message-ID: <20170711103811.GA30681@red-moon>
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
> ---
> 
>  drivers/pci/host/pcie-rockchip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Apologies, it is obviously a typo - before the check was

if (!bus)

which was prone to this mistake, I checked all other host bridges and
they should be ok.

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

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
