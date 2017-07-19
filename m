Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:34546 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753050AbdGSIJe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2017 04:09:34 -0400
Subject: Re: [RFC PATCH v4 3/7] phy: rockcip-pcie: reconstruct driver to
 support per-lane PHYs
To: Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <1500448979-93067-1-git-send-email-shawn.lin@rock-chips.com>
 <1500448979-93067-4-git-send-email-shawn.lin@rock-chips.com>
CC: Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        <linux-pci@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <81b03327-e720-ed51-87d1-9ac0c7a9dc0a@ti.com>
Date: Wed, 19 Jul 2017 13:38:45 +0530
MIME-Version: 1.0
In-Reply-To: <1500448979-93067-4-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Shawn,

On Wednesday 19 July 2017 12:52 PM, Shawn Lin wrote:
> This patch reconstructs the whole driver to support per-lane
> PHYs. Note that we could also support the legacy PHY if you
> don't provide argument to our of_xlate.

one comment below which I failed to notice before..
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> Tested-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v4: None
> Changes in v3:
> - remove unnecessary forward declaration
> - keep mutex inside struct rockchip_pcie_phy
> - fix wrong check of args number
> - move de-idle lanes after deasserting the reset
> 
> Changes in v2:
> - deprecate legacy PHY model
> - improve rockchip_pcie_phy_of_xlate
> - fix wrong calculation of pwr_cnt and add new init_cnt
> - add internal locking
> - introduce per-lane data to simply the code
> 
>  drivers/phy/rockchip/phy-rockchip-pcie.c | 124 +++++++++++++++++++++++++++----
>  1 file changed, 110 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockchip/phy-rockchip-pcie.c
> index 6904633..b5005a5 100644
> --- a/drivers/phy/rockchip/phy-rockchip-pcie.c
> +++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
> @@ -73,10 +73,39 @@ struct rockchip_pcie_data {
>  struct rockchip_pcie_phy {
>  	struct rockchip_pcie_data *phy_data;
>  	struct regmap *reg_base;
> +	struct phy_pcie_instance {
> +		struct phy *phy;
> +		u32 index;
> +	} phys[PHY_MAX_LANE_NUM];
> +	struct mutex pcie_mutex;
>  	struct reset_control *phy_rst;
>  	struct clk *clk_pciephy_ref;
> +	int pwr_cnt;
> +	int init_cnt;
>  };
>  
> +static inline
> +struct rockchip_pcie_phy *to_pcie_phy(struct phy_pcie_instance *inst)
> +{
> +	return container_of(inst, struct rockchip_pcie_phy,
> +					phys[inst->index]);
> +}
> +
> +static struct phy *rockchip_pcie_phy_of_xlate(struct device *dev,
> +					      struct of_phandle_args *args)
> +{
> +	struct rockchip_pcie_phy *rk_phy = dev_get_drvdata(dev);
> +
> +	if (args->args_count == 0)
> +		return rk_phy->phys[0].phy;
> +
> +	if (WARN_ON(args->args[0] >= PHY_MAX_LANE_NUM))
> +		return ERR_PTR(-ENODEV);
> +
> +	return rk_phy->phys[args->args[0]].phy;
> +}
> +
> +
>  static inline void phy_wr_cfg(struct rockchip_pcie_phy *rk_phy,
>  			      u32 addr, u32 data)
>  {
> @@ -116,29 +145,59 @@ static inline u32 phy_rd_cfg(struct rockchip_pcie_phy *rk_phy,
>  
>  static int rockchip_pcie_phy_power_off(struct phy *phy)
>  {
> -	struct rockchip_pcie_phy *rk_phy = phy_get_drvdata(phy);
> +	struct phy_pcie_instance *inst = phy_get_drvdata(phy);
> +	struct rockchip_pcie_phy *rk_phy = to_pcie_phy(inst);
>  	int err = 0;
>  
> +	mutex_lock(&rk_phy->pcie_mutex);
> +
> +	regmap_write(rk_phy->reg_base,
> +		     rk_phy->phy_data->pcie_laneoff,
> +		     HIWORD_UPDATE(PHY_LANE_IDLE_OFF,
> +				   PHY_LANE_IDLE_MASK,
> +				   PHY_LANE_IDLE_A_SHIFT + inst->index));
> +
> +	if (--rk_phy->pwr_cnt)
> +		goto err_out;
> +
>  	err = reset_control_assert(rk_phy->phy_rst);
>  	if (err) {
>  		dev_err(&phy->dev, "assert phy_rst err %d\n", err);
> -		return err;
> +		goto err_restore;
>  	}
>  
> +err_out:
> +	mutex_unlock(&rk_phy->pcie_mutex);
>  	return 0;
> +
> +err_restore:
> +	++rk_phy->pwr_cnt;
> +	regmap_write(rk_phy->reg_base,
> +		     rk_phy->phy_data->pcie_laneoff,
> +		     HIWORD_UPDATE(!PHY_LANE_IDLE_OFF,
> +				   PHY_LANE_IDLE_MASK,
> +				   PHY_LANE_IDLE_A_SHIFT + inst->index));
> +	mutex_unlock(&rk_phy->pcie_mutex);
> +	return err;
>  }
>  
>  static int rockchip_pcie_phy_power_on(struct phy *phy)
>  {
> -	struct rockchip_pcie_phy *rk_phy = phy_get_drvdata(phy);
> +	struct phy_pcie_instance *inst = phy_get_drvdata(phy);
> +	struct rockchip_pcie_phy *rk_phy = to_pcie_phy(inst);
>  	int err = 0;
>  	u32 status;
>  	unsigned long timeout;
>  
> +	mutex_lock(&rk_phy->pcie_mutex);
> +
> +	if (rk_phy->pwr_cnt++)
> +		goto err_out;
> +
>  	err = reset_control_deassert(rk_phy->phy_rst);
>  	if (err) {
>  		dev_err(&phy->dev, "deassert phy_rst err %d\n", err);
> -		return err;
> +		goto err_pwr_cnt;
>  	}
>  
>  	regmap_write(rk_phy->reg_base, rk_phy->phy_data->pcie_conf,
> @@ -146,6 +205,12 @@ static int rockchip_pcie_phy_power_on(struct phy *phy)
>  				   PHY_CFG_ADDR_MASK,
>  				   PHY_CFG_ADDR_SHIFT));
>  
> +	regmap_write(rk_phy->reg_base,
> +		     rk_phy->phy_data->pcie_laneoff,
> +		     HIWORD_UPDATE(!PHY_LANE_IDLE_OFF,
> +				   PHY_LANE_IDLE_MASK,
> +				   PHY_LANE_IDLE_A_SHIFT + inst->index));
> +
>  	/*
>  	 * No documented timeout value for phy operation below,
>  	 * so we make it large enough here. And we use loop-break
> @@ -214,18 +279,29 @@ static int rockchip_pcie_phy_power_on(struct phy *phy)
>  		goto err_pll_lock;
>  	}
>  
> +err_out:
> +	mutex_unlock(&rk_phy->pcie_mutex);
>  	return 0;
>  
>  err_pll_lock:
>  	reset_control_assert(rk_phy->phy_rst);
> +err_pwr_cnt:
> +	--rk_phy->pwr_cnt;
> +	mutex_unlock(&rk_phy->pcie_mutex);
>  	return err;
>  }
>  
>  static int rockchip_pcie_phy_init(struct phy *phy)
>  {
> -	struct rockchip_pcie_phy *rk_phy = phy_get_drvdata(phy);
> +	struct phy_pcie_instance *inst = phy_get_drvdata(phy);
> +	struct rockchip_pcie_phy *rk_phy = to_pcie_phy(inst);
>  	int err = 0;
>  
> +	mutex_lock(&rk_phy->pcie_mutex);
> +
> +	if (rk_phy->init_cnt++)
> +		goto err_out;
> +
>  	err = clk_prepare_enable(rk_phy->clk_pciephy_ref);
>  	if (err) {
>  		dev_err(&phy->dev, "Fail to enable pcie ref clock.\n");
> @@ -238,20 +314,33 @@ static int rockchip_pcie_phy_init(struct phy *phy)
>  		goto err_reset;
>  	}
>  
> -	return err;
> +err_out:
> +	mutex_unlock(&rk_phy->pcie_mutex);
> +	return 0;
>  
>  err_reset:
> +
>  	clk_disable_unprepare(rk_phy->clk_pciephy_ref);
>  err_refclk:
> +	--rk_phy->init_cnt;
> +	mutex_unlock(&rk_phy->pcie_mutex);
>  	return err;
>  }
>  
>  static int rockchip_pcie_phy_exit(struct phy *phy)
>  {
> -	struct rockchip_pcie_phy *rk_phy = phy_get_drvdata(phy);
> +	struct phy_pcie_instance *inst = phy_get_drvdata(phy);
> +	struct rockchip_pcie_phy *rk_phy = to_pcie_phy(inst);
> +
> +	mutex_lock(&rk_phy->pcie_mutex);
> +
> +	if (--rk_phy->init_cnt)
> +		goto err_init_cnt;
>  
>  	clk_disable_unprepare(rk_phy->clk_pciephy_ref);
>  
> +err_init_cnt:
> +	mutex_unlock(&rk_phy->pcie_mutex);
>  	return 0;
>  }
>  
> @@ -283,10 +372,10 @@ static int rockchip_pcie_phy_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct rockchip_pcie_phy *rk_phy;
> -	struct phy *generic_phy;
>  	struct phy_provider *phy_provider;
>  	struct regmap *grf;
>  	const struct of_device_id *of_id;
> +	int i;
>  
>  	grf = syscon_node_to_regmap(dev->parent->of_node);
>  	if (IS_ERR(grf)) {
> @@ -305,6 +394,8 @@ static int rockchip_pcie_phy_probe(struct platform_device *pdev)
>  	rk_phy->phy_data = (struct rockchip_pcie_data *)of_id->data;
>  	rk_phy->reg_base = grf;
>  
> +	mutex_init(&rk_phy->pcie_mutex);
> +
>  	rk_phy->phy_rst = devm_reset_control_get(dev, "phy");
>  	if (IS_ERR(rk_phy->phy_rst)) {
>  		if (PTR_ERR(rk_phy->phy_rst) != -EPROBE_DEFER)
> @@ -319,14 +410,19 @@ static int rockchip_pcie_phy_probe(struct platform_device *pdev)
>  		return PTR_ERR(rk_phy->clk_pciephy_ref);
>  	}
>  
> -	generic_phy = devm_phy_create(dev, dev->of_node, &ops);
> -	if (IS_ERR(generic_phy)) {
> -		dev_err(dev, "failed to create PHY\n");
> -		return PTR_ERR(generic_phy);
> +	for (i = 0; i < PHY_MAX_LANE_NUM; i++) {
> +		rk_phy->phys[i].phy = devm_phy_create(dev, dev->of_node, &ops);
> +		if (IS_ERR(rk_phy->phys[i].phy)) {
> +			dev_err(dev, "failed to create PHY%d\n", i);
> +			return PTR_ERR(rk_phy->phys[i].phy);
> +		}
> +		rk_phy->phys[i].index = i;


For legacy dt, it would create more number of phys than required right? it
would be nice to fix that.

Thanks
Kishon
