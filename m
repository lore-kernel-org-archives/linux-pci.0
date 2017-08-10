Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.130]:37489 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752159AbdHJJZh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2017 05:25:37 -0400
Message-ID: <598C267D.1060105@rock-chips.com>
Date: Thu, 10 Aug 2017 17:25:17 +0800
From: jeffy <jeffy.chen@rock-chips.com>
MIME-Version: 1.0
To: Shawn Lin <shawn.lin@rock-chips.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [RFC PATCH] PCI: rockchip: fix system hang up if activate CONFIG_DEBUG_SHIRQ
References: <1502353273-123788-1-git-send-email-shawn.lin@rock-chips.com> <598C1BDF.6010203@rock-chips.com> <d0499138-aa92-a0bb-1032-7112a025257e@rock-chips.com>
In-Reply-To: <d0499138-aa92-a0bb-1032-7112a025257e@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi shawn,

On 08/10/2017 05:14 PM, Shawn Lin wrote:
> Hi Jeffy
>
> On 2017/8/10 16:39, jeffy wrote:
>> Hi shawn,
>>
>> On 08/10/2017 04:21 PM, Shawn Lin wrote:
>>> With CONFIG_DEBUG_SHIRQ enabled, the irq tear down routine
>>> would still access the irq handler registed as a shard irq.
>>> Per the comment within the function of __free_irq, it says
>>> "It's a shared IRQ -- the driver ought to be prepared for
>>> an IRQ event to happen even now it's being freed". However
>>> when failing to probe the driver, it may disable the clock
>>> for accessing the register and the following check for shared
>>> irq state would call the irq handler which accesses the register
>>> w/o the clk enabled. That will hang the system forever.
>>
>> i think this extra irq call is to make sure it's safe to get a shared
>> irq when we are freeing it, and we would not get this irq after freed it.
>>
>> so maybe just call devm_free_irq before disable clks(and other
>> required resources for the irq handler)? and also do it in the
>> rockchip_pcie_remove.
>
> That works since we free it and the following devm_irq_release would
> bail out early. But I know sure if it is the real intention of  the
> devm_  irq stuff,  although devm_free_irq should be called to free the
> IRQ separately if we want. At least that is so explicit that folks will
> know that, as more from the top view, it seems only a little drivers
> there call devm_free_irq for this case by looking into some more
> drivers(Still no any PCIe drivers do that).
>
> Not sure if their systems are robust enough that could access the
> register w/o clk, even without power domain enabled.

maybe we can use request_irq & free_irq directly?
