Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751889AbdGBVad (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 2 Jul 2017 17:30:33 -0400
Date: Sun, 2 Jul 2017 16:30:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 3/3] PCI: rockchip: use local variable dev consistently
Message-ID: <20170702213030.GE18324@bhelgaas-glaptop.roam.corp.google.com>
References: <1498699288-63944-1-git-send-email-shawn.lin@rock-chips.com>
 <1498699369-65515-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1498699369-65515-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 29, 2017 at 09:22:49AM +0800, Shawn Lin wrote:
> We have "struct device *dev" in rockchip_pcie_probe but
> still fetch it from pdev and rockchip->dev somewhere.
> This patch tries to improve and no functional change intended.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied to pci/host-rockchip for v4.13, thanks!

I don't object to patches 1 & 2, but haven't applied them yet in case Rob
has any comments.

> ---
> 
>  drivers/pci/host/pcie-rockchip.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index c545213..eb0a170 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -1482,15 +1482,14 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  	if (err)
>  		goto err_free_res;
>  
> -	rockchip->msg_region = devm_ioremap(rockchip->dev,
> -					    rockchip->msg_bus_addr, SZ_1M);
> +	rockchip->msg_region = devm_ioremap(dev, rockchip->msg_bus_addr, SZ_1M);
>  	if (!rockchip->msg_region) {
>  		err = -ENOMEM;
>  		goto err_free_res;
>  	}
>  
>  	list_splice_init(&res, &bridge->windows);
> -	bridge->dev.parent = &pdev->dev;
> +	bridge->dev.parent = dev;
>  	bridge->sysdata = rockchip;
>  	bridge->busnr = 0;
>  	bridge->ops = &rockchip_pcie_ops;
> -- 
> 1.9.1
> 
> 
