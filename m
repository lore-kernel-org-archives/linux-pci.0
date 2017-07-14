Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:47736 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbdGNGdr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2017 02:33:47 -0400
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 3/6] phy: rockcip-pcie: reconstruct driver to support
 per-lane PHYs
To: Brian Norris <briannorris@chromium.org>
References: <1500004101-240296-1-git-send-email-shawn.lin@rock-chips.com>
 <1500004366-241633-1-git-send-email-shawn.lin@rock-chips.com>
 <1500004366-241633-2-git-send-email-shawn.lin@rock-chips.com>
 <20170714051030.GA59140@google.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <a0b188ea-71e2-8c8a-999d-754a35891ab9@rock-chips.com>
Date: Fri, 14 Jul 2017 14:33:26 +0800
MIME-Version: 1.0
In-Reply-To: <20170714051030.GA59140@google.com>
Content-Type: text/plain; charset=gbk; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Brian,

On 2017/7/14 13:10, Brian Norris wrote:
> On Fri, Jul 14, 2017 at 11:52:43AM +0800, Shawn Lin wrote:
>> This patch reconstructs the whole driver to support per-lane
>> PHYs. Note that we could also support the legacy PHY if you
>> don't provide argument to our of_xlate.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>>   drivers/phy/rockchip/phy-rockchip-pcie.c | 116 +++++++++++++++++++++++++++----
>>   1 file changed, 101 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockchip/phy-rockchip-pcie.c
>> index 6904633..da74b47 100644
>> --- a/drivers/phy/rockchip/phy-rockchip-pcie.c
>> +++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
>> @@ -73,10 +73,35 @@ struct rockchip_pcie_data {
>>   struct rockchip_pcie_phy {
>>   	struct rockchip_pcie_data *phy_data;
>>   	struct regmap *reg_base;
>> +	struct phy **phys;
>>   	struct reset_control *phy_rst;
>>   	struct clk *clk_pciephy_ref;
>> +	u32 pwr_cnt;
>> +	bool initialized;
>>   };
>>   
>> +static struct phy *rockchip_pcie_phy_of_xlate(struct device *dev,
>> +					      struct of_phandle_args *args)
>> +{
>> +	struct rockchip_pcie_phy *rk_phy = dev_get_drvdata(dev);
>> +
>> +	if (!rk_phy)
>> +		return ERR_PTR(-ENODEV);
> 
> Shouldn't you just check args->args_count to determine legacy vs. new
> style?
> 

args_count is 1 for legacy mode but could also means you just add one
phy with the new per-lane mode?

>> +
>> +	switch (args->args[0]) {
>> +	case 1:
>> +		return rk_phy->phys[1];
>> +	case 2:
>> +		return rk_phy->phys[2];
>> +	case 3:
>> +		return rk_phy->phys[3];
>> +	case 0:
>> +		/* keep backward compatibility to legacy phy */
>> +	default:
> 
> This also ends up accepting invalid indeces. You should probably
> bounds-check args->args[0].
> 
> Then this can just be:
> 
> 	if (legacy)
> 		return rk_phy->phys[0];
> 	else
> 		return rk_phy->phys[index];


However, checking args_count to see if it's legacy seems to simply
the code a lot. So I would fix that above.

> 
>> +		return rk_phy->phys[0];
>> +	}
>> +}
>> +
>>   static inline void phy_wr_cfg(struct rockchip_pcie_phy *rk_phy,
>>   			      u32 addr, u32 data)
>>   {
>> @@ -114,20 +139,55 @@ static inline u32 phy_rd_cfg(struct rockchip_pcie_phy *rk_phy,
>>   	return val;
>>   }
>>   
>> -static int rockchip_pcie_phy_power_off(struct phy *phy)
>> +static int rockchip_pcie_phy_common_power_off(struct phy *phy)
>>   {
>>   	struct rockchip_pcie_phy *rk_phy = phy_get_drvdata(phy);
>>   	int err = 0;
>>   
>> +	if (WARN_ON(!rk_phy->pwr_cnt))
>> +		return -EINVAL;
>> +
>> +	if (rk_phy->pwr_cnt > 0)
> 
> This should be:
> 
> 	if (--rk_phy->pwr_cnt)
> 
> Also, you technically might need locking, now that multiple phys (which
> each only have their own independent mutex) are accessing the same
> refcount. Or maybe just make this an atomic variable.

Good catch!

> 
>> +		return 0;
>> +
>>   	err = reset_control_assert(rk_phy->phy_rst);
>>   	if (err) {
>>   		dev_err(&phy->dev, "assert phy_rst err %d\n", err);
>>   		return err;
>>   	}
>>   
>> +	rk_phy->pwr_cnt--;
> 
> You've got things backwards... how do you expect to ever decrement this,
> if you return earlier in the function? The effect is that you never
> power off after you've powered on. (You should try instrumenting and
> testing this better.)

Right, I should notice this if I checked the power for S3 but
unfortunately I didn't..

> 
>> +
>>   	return 0;
>>   }
>>   
>> +#define DECLARE_PHY_POWER_OFF_PER_LANE(id) \
>> +static int rockchip_pcie_lane##id##_phy_power_off(struct phy *phy) \
> 
> What? All this macro magic (and duplicate generated functions) should
> not be necessary. You just need some per-phy data that keeps the index.

I can't quite follow yours here. The only argument passing on to
the PHY APIs is 'struct phy *phy', and how could you trace the index
from it? The caller should save phy instead of 'rockchip_pcie_phy', in 
which the per-phy data should be.

Or could you kindly show me some example here:)


> 
>> +{ \
>> +	struct rockchip_pcie_phy *rk_phy = phy_get_drvdata(phy); \
>> +\
>> +	regmap_write(rk_phy->reg_base, \
>> +		     rk_phy->phy_data->pcie_laneoff, \
>> +		     HIWORD_UPDATE(PHY_LANE_IDLE_OFF, \
>> +				   PHY_LANE_IDLE_MASK, \
>> +				   PHY_LANE_IDLE_A_SHIFT + id)); \
>> +	return rockchip_pcie_phy_common_power_off(phy); \
>> +}
>> +
>> +DECLARE_PHY_POWER_OFF_PER_LANE(0);
>> +DECLARE_PHY_POWER_OFF_PER_LANE(1);
>> +DECLARE_PHY_POWER_OFF_PER_LANE(2);
>> +DECLARE_PHY_POWER_OFF_PER_LANE(3);
>> +
>> +#define PROVIDE_PHY_OPS(id) \
>> +	{ \
>> +		.init = rockchip_pcie_phy_init, \
>> +		.exit = rockchip_pcie_phy_exit, \
>> +		.power_on = rockchip_pcie_phy_power_on, \
>> +		.power_off = rockchip_pcie_lane##id##_phy_power_off, \
>> +		.owner  = THIS_MODULE, \
>> +}
>> +
>>   static int rockchip_pcie_phy_power_on(struct phy *phy)
>>   {
>>   	struct rockchip_pcie_phy *rk_phy = phy_get_drvdata(phy);
>> @@ -135,6 +195,12 @@ static int rockchip_pcie_phy_power_on(struct phy *phy)
>>   	u32 status;
>>   	unsigned long timeout;
>>   
>> +	if (WARN_ON(rk_phy->pwr_cnt > PHY_MAX_LANE_NUM))
>> +		return -EINVAL;
>> +
>> +	if (rk_phy->pwr_cnt)
> 
> This could just be:
> 
> 	if (rk_phy->pwr_cnt++)
> 
>> +		return 0;
>> +
>>   	err = reset_control_deassert(rk_phy->phy_rst);
>>   	if (err) {
>>   		dev_err(&phy->dev, "deassert phy_rst err %d\n", err);
>> @@ -214,6 +280,7 @@ static int rockchip_pcie_phy_power_on(struct phy *phy)
>>   		goto err_pll_lock;
>>   	}
>>   
>> +	rk_phy->pwr_cnt++;
> 
> Similar problem to what you're doing in power_off(); you're not doing
> the refcount right.

Will fix as well.

> 
> Brian
> 
>>   	return 0;
>>   
>>   err_pll_lock:
>> @@ -226,6 +293,9 @@ static int rockchip_pcie_phy_init(struct phy *phy)
>>   	struct rockchip_pcie_phy *rk_phy = phy_get_drvdata(phy);
>>   	int err = 0;
>>   
>> +	if (rk_phy->initialized)
>> +		return 0;
>> +
>>   	err = clk_prepare_enable(rk_phy->clk_pciephy_ref);
>>   	if (err) {
>>   		dev_err(&phy->dev, "Fail to enable pcie ref clock.\n");
>> @@ -238,7 +308,9 @@ static int rockchip_pcie_phy_init(struct phy *phy)
>>   		goto err_reset;
>>   	}
>>   
>> -	return err;
>> +	rk_phy->initialized = true;
>> +
>> +	return 0;
>>   
>>   err_reset:
>>   	clk_disable_unprepare(rk_phy->clk_pciephy_ref);
>> @@ -250,17 +322,21 @@ static int rockchip_pcie_phy_exit(struct phy *phy)
>>   {
>>   	struct rockchip_pcie_phy *rk_phy = phy_get_drvdata(phy);
>>   
>> +	if (!rk_phy->initialized)
>> +		return 0;
>> +
>>   	clk_disable_unprepare(rk_phy->clk_pciephy_ref);
>>   
>> +	rk_phy->initialized = false;
>> +
>>   	return 0;
>>   }
>>   
>> -static const struct phy_ops ops = {
>> -	.init		= rockchip_pcie_phy_init,
>> -	.exit		= rockchip_pcie_phy_exit,
>> -	.power_on	= rockchip_pcie_phy_power_on,
>> -	.power_off	= rockchip_pcie_phy_power_off,
>> -	.owner		= THIS_MODULE,
>> +static const struct phy_ops ops[PHY_MAX_LANE_NUM] = {
>> +	PROVIDE_PHY_OPS(0),
>> +	PROVIDE_PHY_OPS(1),
>> +	PROVIDE_PHY_OPS(2),
>> +	PROVIDE_PHY_OPS(3),
>>   };
>>   
>>   static const struct rockchip_pcie_data rk3399_pcie_data = {
>> @@ -283,10 +359,10 @@ static int rockchip_pcie_phy_probe(struct platform_device *pdev)
>>   {
>>   	struct device *dev = &pdev->dev;
>>   	struct rockchip_pcie_phy *rk_phy;
>> -	struct phy *generic_phy;
>>   	struct phy_provider *phy_provider;
>>   	struct regmap *grf;
>>   	const struct of_device_id *of_id;
>> +	int i;
>>   
>>   	grf = syscon_node_to_regmap(dev->parent->of_node);
>>   	if (IS_ERR(grf)) {
>> @@ -319,14 +395,24 @@ static int rockchip_pcie_phy_probe(struct platform_device *pdev)
>>   		return PTR_ERR(rk_phy->clk_pciephy_ref);
>>   	}
>>   
>> -	generic_phy = devm_phy_create(dev, dev->of_node, &ops);
>> -	if (IS_ERR(generic_phy)) {
>> -		dev_err(dev, "failed to create PHY\n");
>> -		return PTR_ERR(generic_phy);
>> +	rk_phy->phys = devm_kcalloc(dev, sizeof(struct phy),
>> +				    PHY_MAX_LANE_NUM, GFP_KERNEL);
>> +	if (!rk_phy->phys)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < PHY_MAX_LANE_NUM; i++) {
>> +		rk_phy->phys[i] = devm_phy_create(dev, dev->of_node, &ops[i]);
>> +		if (IS_ERR(rk_phy->phys[i])) {
>> +			dev_err(dev, "failed to create PHY%d\n", i);
>> +			return PTR_ERR(rk_phy->phys[i]);
>> +		}
>> +
>> +		phy_set_drvdata(rk_phy->phys[i], rk_phy);
>>   	}
>>   
>> -	phy_set_drvdata(generic_phy, rk_phy);
>> -	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
>> +	platform_set_drvdata(pdev, rk_phy);
>> +	phy_provider = devm_of_phy_provider_register(dev,
>> +					rockchip_pcie_phy_of_xlate);
>>   
>>   	return PTR_ERR_OR_ZERO(phy_provider);
>>   }
>> -- 
>> 1.9.1
>>
>>
> 
> 
> 
