Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750749AbdFOVsn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Jun 2017 17:48:43 -0400
Date: Thu, 15 Jun 2017 16:48:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: shawn.lin@rock-chips.com, wenrui.li@rock-chips.com,
        heiko@sntech.de, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: rockchip: Handle return value of clk_prepare_enable
Message-ID: <20170615214840.GI12735@bhelgaas-glaptop.roam.corp.google.com>
References: <4ebfc69644f9d6e9e5ff0cfc82e9efa5c476be0e.1496312348.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4ebfc69644f9d6e9e5ff0cfc82e9efa5c476be0e.1496312348.git.arvind.yadav.cs@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 01, 2017 at 03:51:45PM +0530, Arvind Yadav wrote:
> clk_prepare_enable() can fail here and we must check its return value.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Applied with ack/reviewed-by from Shawn and Heiko to pci/host-rockchip for
v4.13, thanks!

I had to apply it manually because of other changes in the same area, so it
would be good if you could check it over.

https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/host-rockchip&id=45f8ce937bc2e06e040f1118f64783b54ade7363

> ---
>  drivers/pci/host/pcie-rockchip.c | 34 ++++++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index 0e020b6..0a248cd 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -1259,24 +1259,46 @@ static int __maybe_unused rockchip_pcie_resume_noirq(struct device *dev)
>  	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
>  	int err;
>  
> -	clk_prepare_enable(rockchip->clk_pcie_pm);
> -	clk_prepare_enable(rockchip->hclk_pcie);
> -	clk_prepare_enable(rockchip->aclk_perf_pcie);
> -	clk_prepare_enable(rockchip->aclk_pcie);
> +	err = clk_prepare_enable(rockchip->clk_pcie_pm);
> +	if (err)
> +		goto err_pcie_pm;
> +
> +	err = clk_prepare_enable(rockchip->hclk_pcie);
> +	if (err)
> +		goto err_hclk_pcie;
> +
> +	err = clk_prepare_enable(rockchip->aclk_perf_pcie);
> +	if (err)
> +		goto err_aclk_perf_pcie;
> +
> +	err = clk_prepare_enable(rockchip->aclk_pcie);
> +	if (err)
> +		goto err_aclk_pcie;
>  
>  	err = rockchip_pcie_init_port(rockchip);
>  	if (err)
> -		return err;
> +		goto err_pcie_resume;
>  
>  	err = rockchip_cfg_atu(rockchip);
>  	if (err)
> -		return err;
> +		goto err_pcie_resume;
>  
>  	/* Need this to enter L1 again */
>  	rockchip_pcie_update_txcredit_mui(rockchip);
>  	rockchip_pcie_enable_interrupts(rockchip);
>  
>  	return 0;
> +
> +err_pcie_resume:
> +	clk_disable_unprepare(rockchip->aclk_pcie);
> +err_aclk_pcie:
> +	clk_disable_unprepare(rockchip->aclk_perf_pcie);
> +err_aclk_perf_pcie:
> +	clk_disable_unprepare(rockchip->hclk_pcie);
> +err_hclk_pcie:
> +	clk_disable_unprepare(rockchip->clk_pcie_pm);
> +err_pcie_pm:
> +	return err;
>  }
>  
>  static int rockchip_pcie_probe(struct platform_device *pdev)
> -- 
> 1.9.1
> 
