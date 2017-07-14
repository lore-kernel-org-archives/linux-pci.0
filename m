Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.141]:34435 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750786AbdGNHTd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2017 03:19:33 -0400
Message-ID: <5968707F.4060700@rock-chips.com>
Date: Fri, 14 Jul 2017 15:19:27 +0800
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
>>>
>>> +static struct phy *rockchip_pcie_phy_of_xlate(struct device *dev,
>>> +                          struct of_phandle_args *args)
>>> +{
>>> +    struct rockchip_pcie_phy *rk_phy = dev_get_drvdata(dev);
>>> +
>>> +    if (!rk_phy)
>>> +        return ERR_PTR(-ENODEV);
>>
>> Shouldn't you just check args->args_count to determine legacy vs. new
>> style?
>>
>
> args_count is 1 for legacy mode but could also means you just add one
> phy with the new per-lane mode?

The new per-lane mode should follow by a lane number, so their 
args_count should be 1, while in the legacy mode it should be 0.
