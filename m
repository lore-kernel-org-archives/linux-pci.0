Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:36623 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751314AbdGQSj0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2017 14:39:26 -0400
Received: by mail-pg0-f54.google.com with SMTP id u5so21620239pgq.3
        for <linux-pci@vger.kernel.org>; Mon, 17 Jul 2017 11:39:25 -0700 (PDT)
Date: Mon, 17 Jul 2017 11:39:22 -0700
From: Brian Norris <briannorris@chromium.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/7] phy: rockcip-pcie: reconstruct driver to support
 per-lane PHYs
Message-ID: <20170717183920.GA6856@google.com>
References: <1500276982-208439-1-git-send-email-shawn.lin@rock-chips.com>
 <1500276982-208439-4-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1500276982-208439-4-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Shawn,

On Mon, Jul 17, 2017 at 03:36:18PM +0800, Shawn Lin wrote:
> This patch reconstructs the whole driver to support per-lane
> PHYs. Note that we could also support the legacy PHY if you
> don't provide argument to our of_xlate.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  drivers/phy/rockchip/phy-rockchip-pcie.c | 126 +++++++++++++++++++++++++++----
>  1 file changed, 112 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockchip/phy-rockchip-pcie.c
> index 6904633..f48b188 100644
> --- a/drivers/phy/rockchip/phy-rockchip-pcie.c
> +++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
> @@ -70,13 +70,46 @@ struct rockchip_pcie_data {
>  	unsigned int pcie_laneoff;
>  };
>  
> +struct phy_pcie_instance;

Is this forward declaration actually needed? You have it defined just a
few lines below.

> +
> +/* internal lock for multiple phys */
> +DEFINE_MUTEX(pcie_mutex);

Put this inside struct rockchip_pcie_phy. It shouldn't be a global lock;
it's just for coordinating the 4 lanes within a single
"rockchip_pcie_phy".

> +
>  struct rockchip_pcie_phy {
>  	struct rockchip_pcie_data *phy_data;
>  	struct regmap *reg_base;
> +	struct phy_pcie_instance {
> +		struct phy *phy;
> +		u32 index;
> +	} phys[PHY_MAX_LANE_NUM];
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
> +	if (WARN_ON(args->args[0] > PHY_MAX_LANE_NUM))

This should be ">=", not ">" (an index of PHY_MAX_LANE_NUM would be out
of bounds).

> +		return ERR_PTR(-ENODEV);
> +
> +	return rk_phy->phys[args->args[0]].phy;
> +}
> +
> +
>  static inline void phy_wr_cfg(struct rockchip_pcie_phy *rk_phy,
>  			      u32 addr, u32 data)
>  {
> @@ -116,29 +149,65 @@ static inline u32 phy_rd_cfg(struct rockchip_pcie_phy *rk_phy,
>  
>  static int rockchip_pcie_phy_power_off(struct phy *phy)
>  {
> -	struct rockchip_pcie_phy *rk_phy = phy_get_drvdata(phy);
> +	struct phy_pcie_instance *inst = phy_get_drvdata(phy);
> +	struct rockchip_pcie_phy *rk_phy = to_pcie_phy(inst);
>  	int err = 0;
>  
> +	mutex_lock(&pcie_mutex);
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
> +	mutex_unlock(&pcie_mutex);
>  	return 0;
> +
> +err_restore:
> +	++rk_phy->pwr_cnt;
> +	regmap_write(rk_phy->reg_base,
> +		     rk_phy->phy_data->pcie_laneoff,
> +		     HIWORD_UPDATE(!PHY_LANE_IDLE_OFF,
> +				   PHY_LANE_IDLE_MASK,
> +				   PHY_LANE_IDLE_A_SHIFT + inst->index));
> +	mutex_unlock(&pcie_mutex);
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
> +	mutex_lock(&pcie_mutex);
> +
> +	regmap_write(rk_phy->reg_base,
> +		     rk_phy->phy_data->pcie_laneoff,
> +		     HIWORD_UPDATE(!PHY_LANE_IDLE_OFF,
> +				   PHY_LANE_IDLE_MASK,
> +				   PHY_LANE_IDLE_A_SHIFT + inst->index));

It seems a little weird to do this before deasserting the reset, but
only on the first lane to powered on. Should this actually be the last
step in this function? Or does it really not matter?

Brian

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
> @@ -214,18 +283,29 @@ static int rockchip_pcie_phy_power_on(struct phy *phy)
>  		goto err_pll_lock;
>  	}
>  
> +err_out:
> +	mutex_unlock(&pcie_mutex);
>  	return 0;
>  
>  err_pll_lock:
>  	reset_control_assert(rk_phy->phy_rst);
> +err_pwr_cnt:
> +	--rk_phy->pwr_cnt;
> +	mutex_unlock(&pcie_mutex);
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
> +	mutex_lock(&pcie_mutex);
> +
> +	if (rk_phy->init_cnt++)
> +		goto err_out;
> +
>  	err = clk_prepare_enable(rk_phy->clk_pciephy_ref);
>  	if (err) {
>  		dev_err(&phy->dev, "Fail to enable pcie ref clock.\n");
> @@ -238,20 +318,33 @@ static int rockchip_pcie_phy_init(struct phy *phy)
>  		goto err_reset;
>  	}
>  
> -	return err;
> +err_out:
> +	mutex_unlock(&pcie_mutex);
> +	return 0;
>  
>  err_reset:
> +
>  	clk_disable_unprepare(rk_phy->clk_pciephy_ref);
>  err_refclk:
> +	--rk_phy->init_cnt;
> +	mutex_unlock(&pcie_mutex);
>  	return err;
>  }
>  
>  static int rockchip_pcie_phy_exit(struct phy *phy)
>  {
> -	struct rockchip_pcie_phy *rk_phy = phy_get_drvdata(phy);
> +	struct phy_pcie_instance *inst = phy_get_drvdata(phy);
> +	struct rockchip_pcie_phy *rk_phy = to_pcie_phy(inst);
> +
> +	mutex_lock(&pcie_mutex);
> +
> +	if (--rk_phy->init_cnt)
> +		goto err_init_cnt;
>  
>  	clk_disable_unprepare(rk_phy->clk_pciephy_ref);
>  
> +err_init_cnt:
> +	mutex_unlock(&pcie_mutex);
>  	return 0;
>  }
>  
> @@ -283,10 +376,10 @@ static int rockchip_pcie_phy_probe(struct platform_device *pdev)
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
> @@ -319,14 +412,19 @@ static int rockchip_pcie_phy_probe(struct platform_device *pdev)
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
> +		phy_set_drvdata(rk_phy->phys[i].phy, &rk_phy->phys[i]);
>  	}
>  
> -	phy_set_drvdata(generic_phy, rk_phy);
> -	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +	platform_set_drvdata(pdev, rk_phy);
> +	phy_provider = devm_of_phy_provider_register(dev,
> +					rockchip_pcie_phy_of_xlate);
>  
>  	return PTR_ERR_OR_ZERO(phy_provider);
>  }
> -- 
> 1.9.1
> 
> 
