Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:50387 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751532AbcKWCdZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2016 21:33:25 -0500
Subject: Re: [PATCH 1/3] PCI: rockchip: split out rockchip_cfg_atu
To: Brian Norris <briannorris@chromium.org>
References: <1479863953-123874-1-git-send-email-shawn.lin@rock-chips.com>
 <20161123015914.GA119441@google.com>
 <30d37e0c-73df-5bae-f489-3d9b56cc7b02@rock-chips.com>
 <20161123022905.GA122654@google.com>
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <b2e2c1f4-7127-6684-cf56-c6eb1de3564d@rock-chips.com>
Date: Wed, 23 Nov 2016 10:33:02 +0800
MIME-Version: 1.0
In-Reply-To: <20161123022905.GA122654@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

在 2016/11/23 10:29, Brian Norris 写道:
> On Wed, Nov 23, 2016 at 10:15:16AM +0800, Shawn Lin wrote:
>> 在 2016/11/23 9:59, Brian Norris 写道:
>>> On Wed, Nov 23, 2016 at 09:19:11AM +0800, Shawn Lin wrote:
>>>> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
>>>> index b55037a..19399fc 100644
>>>> --- a/drivers/pci/host/pcie-rockchip.c
>>>> +++ b/drivers/pci/host/pcie-rockchip.c
>
> ...
>
>>>> +	rockchip->msg_region = ioremap(rockchip->mem_bus_addr +
>>>> +				       ((reg_no - 1) << 20), SZ_1M);
>>>
>>> (And here.)
>>>
>>> ioremap() can fail; check for NULL.
>>>
>>
>> Sure.
>>
>>> Also, when you start reusing rockchip_cfg_atu() in patch 3, you'll be
>>> leaking virtual address space, as you'll keep remapping this every time.
>>
>> How about just check if rockchip->msg_region was already mapped?
>> Otherwise we don't remap it again when calling rockchip_cfg_atu.
>
> That'd work, even if it's a little awkward. That's basically one of my
> suggestions below.
>
>>> You should straighten that out. Either some kind of check for
>>> 'if (!rockchip->msg_region)', or just do the map/unmap where it's
>>> actually used (in patch 3).
>>
>> Should we really need to unmap it? As this driver won't be a module and
>> I think it's okay to keep the rockchip->msg_region always.
>
> No, I guess we don't really need to unmap it. I just meant, you could
> map/unmap every time you use it, or make sure you just map it once (and
> only once).
>

Got it.

> Also (if it helps), you could use devm_ioremap(), in case you ever do
> make it removable.

That sounds good. :)

>
> Brian
>
>
>


-- 
Best Regards
Shawn Lin

