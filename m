Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:46341 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750899AbdGRCgu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2017 22:36:50 -0400
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/7] PCI: rockchip: introduce per-lanes PHYs support
To: Brian Norris <briannorris@chromium.org>
References: <1500276982-208439-1-git-send-email-shawn.lin@rock-chips.com>
 <1500276982-208439-3-git-send-email-shawn.lin@rock-chips.com>
 <20170717201415.GB6856@google.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <6eb842b5-4603-0c9b-2cee-9f8399f457df@rock-chips.com>
Date: Tue, 18 Jul 2017 10:36:40 +0800
MIME-Version: 1.0
In-Reply-To: <20170717201415.GB6856@google.com>
Content-Type: text/plain; charset=gbk; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Brian,

On 2017/7/18 4:14, Brian Norris wrote:
> On Mon, Jul 17, 2017 at 03:36:17PM +0800, Shawn Lin wrote:
>> We distinguish the legacy PHY with the newer per-lane
>> PHYs by adding legacy_phy flag and consolidate all
>> the phy operations into a single function to simply the
>> code. Note that the legacy phy is still the first option
>> to be searched in order not to break the backward compatibility
>> of DT blob, althoug we use devm_phy_optional_get instead which
>> seams to violate the original statement of pcie-rockchip's DT
>> document.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>>   drivers/pci/host/pcie-rockchip.c | 144 ++++++++++++++++++++++++++++++++-------
>>   1 file changed, 118 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
>> index 6632a51..f755df5 100644
>> --- a/drivers/pci/host/pcie-rockchip.c
>> +++ b/drivers/pci/host/pcie-rockchip.c
>> @@ -47,6 +47,7 @@
>>   #define HIWORD_UPDATE_BIT(val)		HIWORD_UPDATE(val, val)
>>   
>>   #define ENCODE_LANES(x)			((((x) >> 1) & 3) << 4)
>> +#define MAX_LANE_NUM			4
>>   
>>   #define PCIE_CLIENT_BASE		0x0
>>   #define PCIE_CLIENT_CONFIG		(PCIE_CLIENT_BASE + 0x00)
>> @@ -210,7 +211,9 @@
>>   struct rockchip_pcie {
>>   	void	__iomem *reg_base;		/* DT axi-base */
>>   	void	__iomem *apb_base;		/* DT apb-base */
>> +	bool	legacy_phy;
>>   	struct	phy *phy;
>> +	struct  phy **phys;
> 
> Would this be simpler as just an array?
> 
> 	struct phy *phys[MAX_LANE_NUM};
> 
> You can probably also combine it with the 'phy' field, and just treat it
> differently based on the 'legacy_phy' switch.

Make sense.

> 
>>   	struct	reset_control *core_rst;
>>   	struct	reset_control *mgmt_rst;
>>   	struct	reset_control *mgmt_sticky_rst;
>> @@ -242,6 +245,15 @@ struct rockchip_pcie {
>>   	phys_addr_t mem_bus_addr;
>>   };
>>   
>> +enum phy_ops_type {
>> +	PHY_INIT,
>> +	PHY_PWR_ON,
>> +	PHY_PWR_OFF,
>> +	PHY_EXIT,
>> +};
>> +
>> +const char *phy_ops_name[] = {"init", "power on", "power off", "exit"};
> 
> This could be 'static'. But if it's only for printing error
> messages...do you really even need this? Somebody could easily refer
> back to the driver if they need to convert an int/enum to something
> meaningful.

ok, I will kill all these above including the following ugly
rockchip_pcie_manipulate_phys.

> 
>> +
>>   static u32 rockchip_pcie_read(struct rockchip_pcie *rockchip, u32 reg)
>>   {
>>   	return readl(rockchip->apb_base + reg);
>> @@ -507,6 +519,104 @@ static void rockchip_pcie_set_power_limit(struct rockchip_pcie *rockchip)
>>   	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_DCR);
>>   }
>>   
>> +static int rockchip_pcie_get_phys(struct rockchip_pcie *rockchip)
>> +{
>> +	struct device *dev = rockchip->dev;
>> +	struct phy *phy;
>> +	char *name;
>> +	u32 i;
>> +
>> +	rockchip->phy = devm_phy_get(dev, "pcie-phy");
>> +	if (IS_ERR(rockchip->phy)) {
>> +		if (PTR_ERR(rockchip->phy) == -EPROBE_DEFER)
>> +			return PTR_ERR(rockchip->phy);
>> +		dev_dbg(dev, "missing legacy phy, and search for per-lane PHY\n");
>> +	} else {
>> +		rockchip->legacy_phy = true;
>> +		dev_warn(dev, "legacy phy model is deprecated!\n");
>> +		return 0;
>> +	}
>> +
>> +	/* per-lane PHYs */
>> +	rockchip->phys = devm_kcalloc(dev, sizeof(phy), MAX_LANE_NUM,
>> +				      GFP_KERNEL);
>> +	if (!rockchip->phys)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < MAX_LANE_NUM; i++) {
>> +		name = kasprintf(GFP_KERNEL, "%s-%u", "pcie-phy", i);
> 
> Since the string is constant, this could just be:
> 
> 		kasprintf(..., "pcie-phy-%u", i);
> 

Looks good, and will improve it.

>> +		if (!name)
>> +			return -ENOMEM;
>> +
>> +		phy = devm_of_phy_get(rockchip->dev,
>> +				      rockchip->dev->of_node, name);
>> +		kfree(name);
>> +
>> +		if (IS_ERR(phy)) {
>> +			if (PTR_ERR(phy) != -EPROBE_DEFER)
>> +				dev_err(dev, "missing phy for lane %d: %ld\n",
>> +					i, PTR_ERR(phy));
>> +			return PTR_ERR(phy);
>> +		}
>> +
>> +		rockchip->phys[i] = phy;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int rockchip_pcie_manipulate_phys(struct rockchip_pcie *rockchip,
>> +					 enum phy_ops_type type)
>> +{
>> +	int i, phy_num, err;
>> +	struct device *dev = rockchip->dev;
>> +	struct phy *phy;
>> +
>> +	phy_num = rockchip->legacy_phy ? 1 : MAX_LANE_NUM;
>> +
>> +	for (i = 0; i < phy_num; i++) {
>> +		phy = rockchip->legacy_phy ? rockchip->phy :
>> +					     rockchip->phys[i];
>> +		switch (type) {
>> +		case PHY_INIT:
>> +			if (phy->init_count > phy_num)
> 
> This looks illegal and badly designed. Illegal, because this looks to be
> a count that should only be touched by the PHY core (and protected by
> its mutex). Badly designed, because this is *not* the right way to
> handle overflow/underflow. You should make sure that this driver does
> init/exit and power on/off in a properly-balanced fashion. And that
> doesn't mean just "skip" it when the count is too high; it means this
> driver should know on its own when is the right time to power on/off the
> phy/lane.

right,  init_cout/power_count should be kept inside the phy core but
we didn't want to duplicate it for consumer. I will try to kill all
of these.

> 
> And this logic doesn't even make sense. Why should I be allowed to init
> lane 0 only once, but I can init lane 3 up to 4 time >
>> +				continue;
>> +			err = phy_init(phy);
>> +			break;
>> +		case PHY_PWR_ON:
>> +			if (phy->power_count > phy_num)
> 
> Same goes here.
> 
>> +				continue;
>> +			err = phy_power_on(phy);
>> +			break;
>> +		case PHY_PWR_OFF:
>> +			if (!phy->power_count)
> 
> And here.
> 
>> +				continue;
>> +			err = phy_power_off(phy);
>> +			break;
>> +		case PHY_EXIT:
>> +			if (!phy->init_count)
> 
> And here.
> 
>> +				continue;
>> +			err = phy_exit(phy);
>> +			break;
>> +		default:
>> +			dev_err(dev, "unsupported phy_ops_type\n");
>> +			return -EOPNOTSUPP;
>> +		}
>> +
>> +		if (err < 0) {
>> +			if (rockchip->legacy_phy)
>> +				dev_err(dev, "fail to %s legacy PHY, err %d\n",
>> +					phy_ops_name[type], err);
>> +			else
>> +				dev_err(dev, "fail to %s per-lane PHY#%u, err %d\n",
>> +					phy_ops_name[type], i, err);
>> +			return err;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
> 
> Really, I think you should kill this whole function, and code the loop
> elsewhere.
> 
>> +
>>   /**
>>    * rockchip_pcie_init_port - Initialize hardware
>>    * @rockchip: PCIe port information
>> @@ -537,11 +647,9 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>>   		return err;
>>   	}
>>   
>> -	err = phy_init(rockchip->phy);
>> -	if (err < 0) {
>> -		dev_err(dev, "fail to init phy, err %d\n", err);
>> +	err = rockchip_pcie_manipulate_phys(rockchip, PHY_INIT);
>> +	if (err < 0)
>>   		return err;
>> -	}
>>   
>>   	err = reset_control_assert(rockchip->core_rst);
>>   	if (err) {
>> @@ -602,11 +710,9 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>>   			    PCIE_CLIENT_MODE_RC,
>>   			    PCIE_CLIENT_CONFIG);
>>   
>> -	err = phy_power_on(rockchip->phy);
>> -	if (err) {
>> -		dev_err(dev, "fail to power on phy, err %d\n", err);
>> +	err = rockchip_pcie_manipulate_phys(rockchip, PHY_PWR_ON);
>> +	if (err)
>>   		return err;
>> -	}
>>   
>>   	/*
>>   	 * Please don't reorder the deassert sequence of the following
>> @@ -853,20 +959,6 @@ static void rockchip_pcie_legacy_int_handler(struct irq_desc *desc)
>>   	chained_irq_exit(chip, desc);
>>   }
>>   
>> -static int rockchip_pcie_get_phys(struct rockchip_pcie *rockchip)
>> -{
>> -	struct device *dev = rockchip->dev;
>> -
>> -	rockchip->phy = devm_phy_get(dev, "pcie-phy");
>> -	if (IS_ERR(rockchip->phy)) {
>> -		if (PTR_ERR(rockchip->phy) != -EPROBE_DEFER)
>> -			dev_err(dev, "missing phy\n");
>> -		return PTR_ERR(rockchip->phy);
>> -	}
>> -
>> -	return 0;
>> -}
>> -
>>   /**
>>    * rockchip_pcie_parse_dt - Parse Device Tree
>>    * @rockchip: PCIe port information
>> @@ -1295,8 +1387,8 @@ static int __maybe_unused rockchip_pcie_suspend_noirq(struct device *dev)
>>   		return ret;
>>   	}
>>   
>> -	phy_power_off(rockchip->phy);
>> -	phy_exit(rockchip->phy);
>> +	rockchip_pcie_manipulate_phys(rockchip, PHY_PWR_OFF);
>> +	rockchip_pcie_manipulate_phys(rockchip, PHY_EXIT);
> 
> What's wrong with this (once you unify the 'phys' array)?
> 
> 	for (i = 0; i < MAX_LANE_NUM; i++) {
> 		if (rockchip->phys[i]) { // Not necessarily required;
> 					 // phy APIs handle NULL
> 			phy_power_off(rockchip->phys[i]);
> 			phy_exit(rockchip->phys[i]);
> 		}
> 	}
> 
> Similar for all other uses, AFAICT.
> 
> Once you actually need to prevent multiple power-offs (when you power
> down some lanes, but not others), you can avoid the illegal access to
> PHY-internal counters by just keeping your own mask of on/off PHYs.

I would like to see if I could reconstruct the phy consumer/provider
to avoid all these counters and fix all corner cases . :)


> 
>>   
>>   	clk_disable_unprepare(rockchip->clk_pcie_pm);
>>   	clk_disable_unprepare(rockchip->hclk_pcie);
>> @@ -1538,8 +1630,8 @@ static int rockchip_pcie_remove(struct platform_device *pdev)
>>   	pci_unmap_iospace(rockchip->io);
>>   	irq_domain_remove(rockchip->irq_domain);
>>   
>> -	phy_power_off(rockchip->phy);
>> -	phy_exit(rockchip->phy);
>> +	rockchip_pcie_manipulate_phys(rockchip, PHY_PWR_OFF);
>> +	rockchip_pcie_manipulate_phys(rockchip, PHY_EXIT);
> 
> Same here.
> 
> Brian
> 
>>   
>>   	clk_disable_unprepare(rockchip->clk_pcie_pm);
>>   	clk_disable_unprepare(rockchip->hclk_pcie);
>> -- 
>> 1.9.1
>>
>>
> 
> 
> 
