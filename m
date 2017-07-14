Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.141]:34991 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750786AbdGNHDq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2017 03:03:46 -0400
Message-ID: <59686CCA.60804@rock-chips.com>
Date: Fri, 14 Jul 2017 15:03:38 +0800
From: jeffy <jeffy.chen@rock-chips.com>
MIME-Version: 1.0
To: Shawn Lin <shawn.lin@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 3/6] phy: rockcip-pcie: reconstruct driver to support
 per-lane PHYs
References: <1500004101-240296-1-git-send-email-shawn.lin@rock-chips.com> <1500004366-241633-1-git-send-email-shawn.lin@rock-chips.com> <1500004366-241633-2-git-send-email-shawn.lin@rock-chips.com> <20170714051030.GA59140@google.com> <a0b188ea-71e2-8c8a-999d-754a35891ab9@rock-chips.com>
In-Reply-To: <a0b188ea-71e2-8c8a-999d-754a35891ab9@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Shawn,

On 07/14/2017 02:33 PM, Shawn Lin wrote:
>>
>>> +        return rk_phy->phys[0];
>>> +    }
>>> +}
>>> +
>>>   static inline void phy_wr_cfg(struct rockchip_pcie_phy *rk_phy,
>>>                     u32 addr, u32 data)
>>>   {
>>> @@ -114,20 +139,55 @@ static inline u32 phy_rd_cfg(struct
>>> rockchip_pcie_phy *rk_phy,
>>>       return val;
>>>   }
>>> -static int rockchip_pcie_phy_power_off(struct phy *phy)
>>> +static int rockchip_pcie_phy_common_power_off(struct phy *phy)
>>>   {
>>>       struct rockchip_pcie_phy *rk_phy = phy_get_drvdata(phy);
>>>       int err = 0;
>>> +    if (WARN_ON(!rk_phy->pwr_cnt))
>>> +        return -EINVAL;
>>> +
>>> +    if (rk_phy->pwr_cnt > 0)
>>
>> This should be:
>>
>>     if (--rk_phy->pwr_cnt)
>>
>> Also, you technically might need locking, now that multiple phys (which
>> each only have their own independent mutex) are accessing the same
>> refcount. Or maybe just make this an atomic variable.
>
> Good catch!
Sounds like we need something similar to phy-core.c's power_count and 
init_count.

>>> +
>>>       return 0;
>>>   }
>>> +#define DECLARE_PHY_POWER_OFF_PER_LANE(id) \
>>> +static int rockchip_pcie_lane##id##_phy_power_off(struct phy *phy) \
>>
>> What? All this macro magic (and duplicate generated functions) should
>> not be necessary. You just need some per-phy data that keeps the index.
>
> I can't quite follow yours here. The only argument passing on to
> the PHY APIs is 'struct phy *phy', and how could you trace the index
> from it? The caller should save phy instead of 'rockchip_pcie_phy', in
> which the per-phy data should be.
>
> Or could you kindly show me some example here:)
>
Maybe add a struct rockchip_pcie_phy_data for each phy, contains their 
index and a pointer to the common struct rockchip_pcie_phy?
