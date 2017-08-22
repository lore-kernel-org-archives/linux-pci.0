Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753041AbdHVUrv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Aug 2017 16:47:51 -0400
Date: Tue, 22 Aug 2017 15:47:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH] PCI: rockchip: manipulate phy properly if failing to
 probe the driver
Message-ID: <20170822204750.GG6948@bhelgaas-glaptop.roam.corp.google.com>
References: <1502277263-187898-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1502277263-187898-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 09, 2017 at 07:14:23PM +0800, Shawn Lin wrote:
> We observed that the clk_pciephy_ref is still enabled when we actually
> fail to probe the driver.
> 
> root@linaro-alip:~# cat /sys/kernel/debug/clk/clk_summary | grep pcie
> clk_pciephy_ref			  1	1	 24000000	0 0
> clk_pcie_pm			  0	0	 24000000	0 0
>       clk_pcie_core_cru           0	0	125000000	0 0
>       clk_pciephy_ref100m         0	0	100000000	0 0
> 		aclk_pcie         0	0	148500000	0 0
> 		aclk_perf_pcie    0	0	148500000	0 0
> 			pclk_pcie 0	0	 37125000	0 0
> clk_pcie_core                     0	0		0	0 0
> 
> clk_pciephy_ref is used by phy driver and we need to properly disable
> it for this case. So this patch add error handle for the function of
> rockchip_pcie_init_port to fix this issue.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied to pci/host-rockchip for v4.14, thanks!

> ---
> 
>  drivers/pci/host/pcie-rockchip.c | 38 ++++++++++++++++++++++++--------------
>  1 file changed, 24 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index 2eccd53..ce6371b 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -561,32 +561,32 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  		err = phy_init(rockchip->phys[i]);
>  		if (err) {
>  			dev_err(dev, "init phy%d err %d\n", i, err);
> -			return err;
> +			goto err_phy_exit;
>  		}
>  	}
>  
>  	err = reset_control_assert(rockchip->core_rst);
>  	if (err) {
>  		dev_err(dev, "assert core_rst err %d\n", err);
> -		return err;
> +		goto err_phy_exit;
>  	}
>  
>  	err = reset_control_assert(rockchip->mgmt_rst);
>  	if (err) {
>  		dev_err(dev, "assert mgmt_rst err %d\n", err);
> -		return err;
> +		goto err_phy_exit;
>  	}
>  
>  	err = reset_control_assert(rockchip->mgmt_sticky_rst);
>  	if (err) {
>  		dev_err(dev, "assert mgmt_sticky_rst err %d\n", err);
> -		return err;
> +		goto err_phy_exit;
>  	}
>  
>  	err = reset_control_assert(rockchip->pipe_rst);
>  	if (err) {
>  		dev_err(dev, "assert pipe_rst err %d\n", err);
> -		return err;
> +		goto err_phy_exit;
>  	}
>  
>  	udelay(10);
> @@ -594,19 +594,19 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  	err = reset_control_deassert(rockchip->pm_rst);
>  	if (err) {
>  		dev_err(dev, "deassert pm_rst err %d\n", err);
> -		return err;
> +		goto err_phy_exit;
>  	}
>  
>  	err = reset_control_deassert(rockchip->aclk_rst);
>  	if (err) {
>  		dev_err(dev, "deassert aclk_rst err %d\n", err);
> -		return err;
> +		goto err_phy_exit;
>  	}
>  
>  	err = reset_control_deassert(rockchip->pclk_rst);
>  	if (err) {
>  		dev_err(dev, "deassert pclk_rst err %d\n", err);
> -		return err;
> +		goto err_phy_exit;
>  	}
>  
>  	if (rockchip->link_gen == 2)
> @@ -628,7 +628,7 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  		err = phy_power_on(rockchip->phys[i]);
>  		if (err) {
>  			dev_err(dev, "power on phy%d err %d\n", i, err);
> -			return err;
> +			goto err_phy_power_off;
>  		}
>  	}
>  
> @@ -639,25 +639,25 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  	err = reset_control_deassert(rockchip->mgmt_sticky_rst);
>  	if (err) {
>  		dev_err(dev, "deassert mgmt_sticky_rst err %d\n", err);
> -		return err;
> +		goto err_phy_power_off;
>  	}
>  
>  	err = reset_control_deassert(rockchip->core_rst);
>  	if (err) {
>  		dev_err(dev, "deassert core_rst err %d\n", err);
> -		return err;
> +		goto err_phy_power_off;
>  	}
>  
>  	err = reset_control_deassert(rockchip->mgmt_rst);
>  	if (err) {
>  		dev_err(dev, "deassert mgmt_rst err %d\n", err);
> -		return err;
> +		goto err_phy_power_off;
>  	}
>  
>  	err = reset_control_deassert(rockchip->pipe_rst);
>  	if (err) {
>  		dev_err(dev, "deassert pipe_rst err %d\n", err);
> -		return err;
> +		goto err_phy_power_off;
>  	}
>  
>  	/* Fix the transmitted FTS count desired to exit from L0s. */
> @@ -690,7 +690,8 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  				 500 * USEC_PER_MSEC);
>  	if (err) {
>  		dev_err(dev, "PCIe link training gen1 timeout!\n");
> -		return -ETIMEDOUT;
> +		err = -ETIMEDOUT;
> +		goto err_phy_power_off;
>  	}
>  
>  	if (rockchip->link_gen == 2) {
> @@ -751,6 +752,15 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_DCSR);
>  
>  	return 0;
> +
> +err_phy_exit:
> +	for (; i >= 0; --i)
> +		phy_exit(rockchip->phys[i]);
> +err_phy_power_off:
> +	for (; i >= 0; --i)
> +		phy_power_off(rockchip->phys[i]);
> +
> +	return err;
>  }
>  
>  static irqreturn_t rockchip_pcie_subsys_irq_handler(int irq, void *arg)
> -- 
> 1.9.1
> 
> 
