Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:53712 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754165AbcJFCAV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Oct 2016 22:00:21 -0400
Subject: Re: [PATCH v3] PCI: rockchip: Support property to specify the link
 capability
To: Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>
References: <1475654717-15159-1-git-send-email-shawn.lin@rock-chips.com>
 <20161005224642.GA111810@google.com>
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rajat Jain <rajatja@google.com>,
        Wenrui Li <wenrui.li@rock-chips.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <d81bcc67-22cc-774c-d9f3-445633303278@rock-chips.com>
Date: Thu, 6 Oct 2016 10:00:04 +0800
MIME-Version: 1.0
In-Reply-To: <20161005224642.GA111810@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

在 2016/10/6 6:46, Brian Norris 写道:
> Hi,
>
> On Wed, Oct 05, 2016 at 04:05:17PM +0800, Shawn Lin wrote:
>> From: Brian Norris <briannorris@chromium.org>
>>
>> rk3399 supports PCIe 2.x link speeds marginally at best, and on some
>> boards, the link won't train at 5 GT/s at all. Rather than sacrifice 500
>> ms waiting for training that will never happen, let's add a property
>> from devicetree to specify link capability.
>>
>> Signed-off-by: Brian Norris <briannorris@chromium.org>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>
>> ---
>>
>> Changes in v3:
>> - Cast a warning for invalid max link speed and use gen1 for it.
>>   That looks better than v2. (Suggested by Brian)
>>
>> Changes in v2:
>> - rename the property to rockchip,max-link-speed according to
>>   Bjorn's recommendation and take some bits from imx6q-pcie to
>>   make this requirement more consisent.
>>
>>  .../devicetree/bindings/pci/rockchip-pcie.txt      |  2 +
>>  drivers/pci/host/pcie-rockchip.c                   | 62 ++++++++++++++--------
>>  2 files changed, 42 insertions(+), 22 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
>> index ba67b39..7bb730e 100644
>> --- a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
>> +++ b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
>> @@ -42,6 +42,8 @@ Required properties:
>>  Optional Property:
>>  - ep-gpios: contain the entry for pre-reset gpio
>>  - num-lanes: number of lanes to use
>> +- rockchip,max-link-speed: Specify PCI gen for link capability. Must
>> +	be '2' for gen2, and '1' for gen1, otherwise will default to gen1.
>
> I'm still not sure why we want incorrect DT entries to default to 1
> instead of just being rejected as incorrect (i.e., and error). But
> assuming people are OK with that behavior, I'll review the rest...

yep, personally I don't like to stop driver from running or to
trigger BUG_ON only if the incorrect DT value. If that happens, it
implies we should deploy proper error handling and cast a warning
should be enough for people to debug. If the max-link-speed is
incorrect, I assume the owner of this DT doesn't actually read
the doc at all. At least he/she doesn't know what this property means.
So we could use the *nature* capability for sure it could bring up
the boards, for instance 1 lanes, gen1... etc.

I was told to write code like this and have been insisting on this for
quite a long time. Does it sound sane to you? :)

>
>>  - vpcie3v3-supply: The phandle to the 3.3v regulator to use for PCIe.
>>  - vpcie1v8-supply: The phandle to the 1.8v regulator to use for PCIe.
>>  - vpcie0v9-supply: The phandle to the 0.9v regulator to use for PCIe.
>> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
>> index 35591b1..66476ea 100644
>> --- a/drivers/pci/host/pcie-rockchip.c
>> +++ b/drivers/pci/host/pcie-rockchip.c
>> @@ -53,6 +53,7 @@
>>  #define   PCIE_CLIENT_ARI_ENABLE	  HIWORD_UPDATE_BIT(0x0008)
>>  #define   PCIE_CLIENT_CONF_LANE_NUM(x)	  HIWORD_UPDATE(0x0030, ENCODE_LANES(x))
>>  #define   PCIE_CLIENT_MODE_RC		  HIWORD_UPDATE_BIT(0x0040)
>> +#define   PCIE_CLIENT_GEN_SEL_1		  HIWORD_UPDATE(0x0080, 0)
>>  #define   PCIE_CLIENT_GEN_SEL_2		  HIWORD_UPDATE_BIT(0x0080)
>>  #define PCIE_CLIENT_BASIC_STATUS1	(PCIE_CLIENT_BASE + 0x48)
>>  #define   PCIE_CLIENT_LINK_STATUS_UP		0x00300000
>> @@ -205,6 +206,7 @@ struct rockchip_pcie {
>>  	struct	gpio_desc *ep_gpio;
>>  	u32	lanes;
>>  	u8	root_bus_nr;
>> +	int	link_gen;
>>  	struct	device *dev;
>>  	struct	irq_domain *irq_domain;
>>  };
>> @@ -443,13 +445,19 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>>  		return err;
>>  	}
>>
>> +	if (rockchip->link_gen == 2)
>> +		rockchip_pcie_write(rockchip, PCIE_CLIENT_GEN_SEL_2,
>> +				    PCIE_CLIENT_CONFIG);
>> +	else
>> +		rockchip_pcie_write(rockchip, PCIE_CLIENT_GEN_SEL_1,
>> +				    PCIE_CLIENT_CONFIG);
>> +
>>  	rockchip_pcie_write(rockchip,
>>  			    PCIE_CLIENT_CONF_ENABLE |
>>  			    PCIE_CLIENT_LINK_TRAIN_ENABLE |
>>  			    PCIE_CLIENT_ARI_ENABLE |
>>  			    PCIE_CLIENT_CONF_LANE_NUM(rockchip->lanes) |
>> -			    PCIE_CLIENT_MODE_RC |
>> -			    PCIE_CLIENT_GEN_SEL_2,
>> +			    PCIE_CLIENT_MODE_RC,
>>  				PCIE_CLIENT_CONFIG);
>>
>>  	err = phy_power_on(rockchip->phy);
>> @@ -550,29 +558,31 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>>  		msleep(20);
>>  	}
>>
>> -	/*
>> -	 * Enable retrain for gen2. This should be configured only after
>> -	 * gen1 finished.
>> -	 */
>> -	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
>> -	status |= PCIE_RC_CONFIG_LCS_RETRAIN_LINK;
>> -	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
>> +	if (rockchip->link_gen == 2) {
>> +		/*
>> +		 * Enable retrain for gen2. This should be configured only after
>> +		 * gen1 finished.
>> +		 */
>> +		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
>> +		status |= PCIE_RC_CONFIG_LCS_RETRAIN_LINK;
>> +		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
>> +
>> +		timeout = jiffies + msecs_to_jiffies(500);
>> +		for (;;) {
>> +			status = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL);
>> +			if ((status & PCIE_CORE_PL_CONF_SPEED_MASK) ==
>> +					PCIE_CORE_PL_CONF_SPEED_5G) {
>> +				dev_dbg(dev, "PCIe link training gen2 pass!\n");
>> +				break;
>> +			}
>>
>> -	timeout = jiffies + msecs_to_jiffies(500);
>> -	for (;;) {
>> -		status = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL);
>> -		if ((status & PCIE_CORE_PL_CONF_SPEED_MASK) ==
>> -		    PCIE_CORE_PL_CONF_SPEED_5G) {
>> -			dev_dbg(dev, "PCIe link training gen2 pass!\n");
>> -			break;
>> -		}
>> +			if (time_after(jiffies, timeout)) {
>> +				dev_dbg(dev, "PCIe link training gen2 timeout, fall back to gen1!\n");
>> +				break;
>> +			}
>>
>> -		if (time_after(jiffies, timeout)) {
>> -			dev_dbg(dev, "PCIe link training gen2 timeout, fall back to gen1!\n");
>> -			break;
>> +			msleep(20);
>>  		}
>> -
>> -		msleep(20);
>>  	}
>>
>>  	/* Check the final link width from negotiated lane counter from MGMT */
>> @@ -781,6 +791,14 @@ static int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
>>  		rockchip->lanes = 1;
>>  	}
>>
>> +	rockchip->link_gen = 2;
>
> Isn't the above assignment violating the binding doc? Setting to 2 means
> that if the property isn't found, we default to gen2. That's OK with me,
> but you should make the binding doc match it.

It should be backward compatible with the old DTBs without this
propery. Otherwise, they did use gen2 but they cannot achieve it now
without adding the new propery.

But I agreee I should commet the doc more clearly.

>
>> +	err = of_property_read_u32(node, "rockchip,max-link-speed",
>> +				   &rockchip->link_gen);
>
> ^^ you can get sign errors here, since link_gen is 'int', but this
> function reads 'u32'. Maybe use a temporary u32.
>

Good catch.

> Brian
>
>> +	if (!err && rockchip->link_gen != 1 && rockchip->link_gen != 2) {
>> +		dev_warn(dev, "invalid max-link-speed, default to use gen1\n");
>> +		rockchip->link_gen = 1;
>> +	}
>> +
>>  	rockchip->core_rst = devm_reset_control_get(dev, "core");
>>  	if (IS_ERR(rockchip->core_rst)) {
>>  		if (PTR_ERR(rockchip->core_rst) != -EPROBE_DEFER)
>> --
>> 2.3.7
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Best Regards
Shawn Lin

