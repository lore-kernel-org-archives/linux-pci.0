Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 054/102] PCI: rockchip: explicitly request exclusive reset
 control
To: Philipp Zabel <p.zabel@pengutronix.de>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
 <20170719152646.25903-55-p.zabel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <f4a8b573-7a5f-ff8a-65c3-f6b907e6a10a@rock-chips.com>
Date: Sat, 22 Jul 2017 21:12:27 +0800
MIME-Version: 1.0
In-Reply-To: <20170719152646.25903-55-p.zabel@pengutronix.de>
Content-Type: text/plain; charset=gbk; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Philipp,

On 2017/7/19 23:25, Philipp Zabel wrote:
> Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
> reset lines") started to transition the reset control request API calls
> to explicitly state whether the driver needs exclusive or shared reset
> control behavior. Convert all drivers requesting exclusive resets to the
> explicit API call so the temporary transition helpers can be removed.
>
> No functional changes.
>
> Cc: Shawn Lin <shawn.lin@rock-chips.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-rockchip@lists.infradead.org
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/pci/host/pcie-rockchip.c | 15 ++++++++-------

As mentioned in the thread of conversion for phy-rockchip-pcie,
I would prefer add your patches after the reconstruction work got
merged.


>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index 7bb9870f6d8ce..e50d6f5a81f4b 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -903,49 +903,50 @@ static int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
>  	if (rockchip->link_gen < 0 || rockchip->link_gen > 2)
>  		rockchip->link_gen = 2;
>
> -	rockchip->core_rst = devm_reset_control_get(dev, "core");
> +	rockchip->core_rst = devm_reset_control_get_exclusive(dev, "core");
>  	if (IS_ERR(rockchip->core_rst)) {
>  		if (PTR_ERR(rockchip->core_rst) != -EPROBE_DEFER)
>  			dev_err(dev, "missing core reset property in node\n");
>  		return PTR_ERR(rockchip->core_rst);
>  	}
>
> -	rockchip->mgmt_rst = devm_reset_control_get(dev, "mgmt");
> +	rockchip->mgmt_rst = devm_reset_control_get_exclusive(dev, "mgmt");
>  	if (IS_ERR(rockchip->mgmt_rst)) {
>  		if (PTR_ERR(rockchip->mgmt_rst) != -EPROBE_DEFER)
>  			dev_err(dev, "missing mgmt reset property in node\n");
>  		return PTR_ERR(rockchip->mgmt_rst);
>  	}
>
> -	rockchip->mgmt_sticky_rst = devm_reset_control_get(dev, "mgmt-sticky");
> +	rockchip->mgmt_sticky_rst = devm_reset_control_get_exclusive(dev,
> +								     "mgmt-sticky");
>  	if (IS_ERR(rockchip->mgmt_sticky_rst)) {
>  		if (PTR_ERR(rockchip->mgmt_sticky_rst) != -EPROBE_DEFER)
>  			dev_err(dev, "missing mgmt-sticky reset property in node\n");
>  		return PTR_ERR(rockchip->mgmt_sticky_rst);
>  	}
>
> -	rockchip->pipe_rst = devm_reset_control_get(dev, "pipe");
> +	rockchip->pipe_rst = devm_reset_control_get_exclusive(dev, "pipe");
>  	if (IS_ERR(rockchip->pipe_rst)) {
>  		if (PTR_ERR(rockchip->pipe_rst) != -EPROBE_DEFER)
>  			dev_err(dev, "missing pipe reset property in node\n");
>  		return PTR_ERR(rockchip->pipe_rst);
>  	}
>
> -	rockchip->pm_rst = devm_reset_control_get(dev, "pm");
> +	rockchip->pm_rst = devm_reset_control_get_exclusive(dev, "pm");
>  	if (IS_ERR(rockchip->pm_rst)) {
>  		if (PTR_ERR(rockchip->pm_rst) != -EPROBE_DEFER)
>  			dev_err(dev, "missing pm reset property in node\n");
>  		return PTR_ERR(rockchip->pm_rst);
>  	}
>
> -	rockchip->pclk_rst = devm_reset_control_get(dev, "pclk");
> +	rockchip->pclk_rst = devm_reset_control_get_exclusive(dev, "pclk");
>  	if (IS_ERR(rockchip->pclk_rst)) {
>  		if (PTR_ERR(rockchip->pclk_rst) != -EPROBE_DEFER)
>  			dev_err(dev, "missing pclk reset property in node\n");
>  		return PTR_ERR(rockchip->pclk_rst);
>  	}
>
> -	rockchip->aclk_rst = devm_reset_control_get(dev, "aclk");
> +	rockchip->aclk_rst = devm_reset_control_get_exclusive(dev, "aclk");
>  	if (IS_ERR(rockchip->aclk_rst)) {
>  		if (PTR_ERR(rockchip->aclk_rst) != -EPROBE_DEFER)
>  			dev_err(dev, "missing aclk reset property in node\n");
>


-- 
Best Regards
Shawn Lin
