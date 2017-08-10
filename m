Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:36664 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752558AbdHJMWq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Aug 2017 08:22:46 -0400
From: Heiko Stuebner <heiko@sntech.de>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH v2] PCI: rockchip: fix system hang up if activating CONFIG_DEBUG_SHIRQ
Date: Thu, 10 Aug 2017 14:22:39 +0200
Message-ID: <3312094.6zR5NuJAgK@phil>
In-Reply-To: <1502363923-19946-1-git-send-email-shawn.lin@rock-chips.com>
References: <1502363923-19946-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Shawn,

Am Donnerstag, 10. August 2017, 19:18:43 CEST schrieb Shawn Lin:
> With CONFIG_DEBUG_SHIRQ enabled, the irq tear down routine
> would still access the irq handler registed as a shard irq.
> Per the comment within the function of __free_irq, it says
> "It's a shared IRQ -- the driver ought to be prepared for
> an IRQ event to happen even now it's being freed". However
> when failing to probe the driver, it may disable the clock
> for accessing the register and the following check for shared
> irq state would call the irq handler which accesses the register
> w/o the clk enabled. That will hang the system forever.
> 
> With adding some dump_stack we could see how that happened.
> 
> calling  rockchip_pcie_driver_init+0x0/0x28 @ 1
> rockchip-pcie f8000000.pcie: no vpcie3v3 regulator found
> rockchip-pcie f8000000.pcie: no vpcie1v8 regulator found
> rockchip-pcie f8000000.pcie: no vpcie0v9 regulator found
> rockchip-pcie f8000000.pcie: PCIe link training gen1 timeout!
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> 4.13.0-rc3-next-20170807-ARCH+ #189
> Hardware name: Firefly-RK3399 Board (DT)
> Call trace:
> [<ffff000008089bf0>] dump_backtrace+0x0/0x250
> [<ffff000008089eb0>] show_stack+0x20/0x28
> [<ffff000008c3313c>] dump_stack+0x90/0xb0
> [<ffff000008632ad4>] rockchip_pcie_read.isra.11+0x54/0x58
> [<ffff0000086334fc>] rockchip_pcie_client_irq_handler+0x30/0x1a0
> [<ffff00000813ce98>] __free_irq+0x1c8/0x2dc
> [<ffff00000813d044>] free_irq+0x44/0x74
> [<ffff0000081415fc>] devm_irq_release+0x24/0x2c
> [<ffff00000877429c>] release_nodes+0x1d8/0x30c
> [<ffff000008774838>] devres_release_all+0x3c/0x5c
> [<ffff00000876f19c>] driver_probe_device+0x244/0x494
> [<ffff00000876f50c>] __driver_attach+0x120/0x124
> [<ffff00000876cb80>] bus_for_each_dev+0x6c/0xac
> [<ffff00000876e984>] driver_attach+0x2c/0x34
> [<ffff00000876e3a4>] bus_add_driver+0x244/0x2b0
> [<ffff000008770264>] driver_register+0x70/0x110
> [<ffff0000087718b4>] platform_driver_register+0x60/0x6c
> [<ffff0000091eb108>] rockchip_pcie_driver_init+0x20/0x28
> [<ffff000008083a2c>] do_one_initcall+0xc8/0x130
> [<ffff0000091a0ea8>] kernel_init_freeable+0x1a0/0x238
> [<ffff000008c461cc>] kernel_init+0x18/0x108
> [<ffff0000080836c0>] ret_from_fork+0x10/0x50
> 
> In order to fix this, we remove all the clock-disabling from
> the error handle path and driver's remove function. And replying
> on the devm_add_action_or_reset to fire the clock-disabling at
> the appropriate time.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> 
> Changes in v2:
> - use devm_add_action_or_reset to fix this ordering suggested by
>   Heiko and Jeffy. Thanks!
> 
>  drivers/pci/host/pcie-rockchip.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index 39aafe2..7713561 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -939,6 +939,16 @@ static int rockchip_pcie_get_phys(struct rockchip_pcie *rockchip)
>  	return 0;
>  }
>  
> +static void rockchip_pcie_disable_clocks(void *data)
> +{
> +	struct rockchip_pcie *rockchip = data;
> +
> +	clk_disable_unprepare(rockchip->clk_pcie_pm);
> +	clk_disable_unprepare(rockchip->hclk_pcie);
> +	clk_disable_unprepare(rockchip->aclk_perf_pcie);
> +	clk_disable_unprepare(rockchip->aclk_pcie);
> +}
> +
>  /**
>   * rockchip_pcie_parse_dt - Parse Device Tree
>   * @rockchip: PCIe port information
> @@ -1071,6 +1081,9 @@ static int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
>  		return -EINVAL;
>  	}
>  
> +	devm_add_action_or_reset(dev,
> +				 rockchip_pcie_disable_clocks, rockchip);
> +

err = devm_add_action_or_reset(...)
if (err) {
...
}

devm_add_action_or_reset can fail. When it fails, it will call the
action already, so your error handling does not need to disable
clocks on its own.


Also, as a more general comment, right now you do devm_request_irq
from rockchip_pcie_parse_dt, which gets called _before_ clocks are
enabled.

This will likely bite you at some point as well, as the irq can fire at
any point after it got requested ... including before you enable the
clocks.

So the order should probably be

- enable clocks
- register devm_action to shutdown clocks
- parse_dt including requesting the irq.


Heiko


>  	err = devm_request_irq(dev, irq, rockchip_pcie_subsys_irq_handler,
>  			       IRQF_SHARED, "pcie-sys", rockchip);
>  	if (err) {
> @@ -1493,25 +1506,25 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  	err = clk_prepare_enable(rockchip->aclk_pcie);
>  	if (err) {
>  		dev_err(dev, "unable to enable aclk_pcie clock\n");
> -		goto err_aclk_pcie;
> +		return err;
>  	}
>  
>  	err = clk_prepare_enable(rockchip->aclk_perf_pcie);
>  	if (err) {
>  		dev_err(dev, "unable to enable aclk_perf_pcie clock\n");
> -		goto err_aclk_perf_pcie;
> +		return err;
>  	}
>  
>  	err = clk_prepare_enable(rockchip->hclk_pcie);
>  	if (err) {
>  		dev_err(dev, "unable to enable hclk_pcie clock\n");
> -		goto err_hclk_pcie;
> +		return err;
>  	}
>  
>  	err = clk_prepare_enable(rockchip->clk_pcie_pm);
>  	if (err) {
>  		dev_err(dev, "unable to enable hclk_pcie clock\n");
> -		goto err_pcie_pm;
> +		return err;
>  	}
>  
>  	err = rockchip_pcie_set_vpcie(rockchip);
> @@ -1615,14 +1628,6 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  	if (!IS_ERR(rockchip->vpcie0v9))
>  		regulator_disable(rockchip->vpcie0v9);
>  err_set_vpcie:
> -	clk_disable_unprepare(rockchip->clk_pcie_pm);
> -err_pcie_pm:
> -	clk_disable_unprepare(rockchip->hclk_pcie);
> -err_hclk_pcie:
> -	clk_disable_unprepare(rockchip->aclk_perf_pcie);
> -err_aclk_perf_pcie:
> -	clk_disable_unprepare(rockchip->aclk_pcie);
> -err_aclk_pcie:
>  	return err;
>  }
>  
> @@ -1644,10 +1649,6 @@ static int rockchip_pcie_remove(struct platform_device *pdev)
>  		phy_exit(rockchip->phys[i]);
>  	}
>  
> -	clk_disable_unprepare(rockchip->clk_pcie_pm);
> -	clk_disable_unprepare(rockchip->hclk_pcie);
> -	clk_disable_unprepare(rockchip->aclk_perf_pcie);
> -	clk_disable_unprepare(rockchip->aclk_pcie);
>  
>  	if (!IS_ERR(rockchip->vpcie12v))
>  		regulator_disable(rockchip->vpcie12v);
> 
