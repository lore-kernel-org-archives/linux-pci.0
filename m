Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.130]:49233 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751914AbdHJJkr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2017 05:40:47 -0400
Message-ID: <598C2A13.8060504@rock-chips.com>
Date: Thu, 10 Aug 2017 17:40:35 +0800
From: jeffy <jeffy.chen@rock-chips.com>
MIME-Version: 1.0
To: Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [RFC PATCH] PCI: rockchip: fix system hang up if activate CONFIG_DEBUG_SHIRQ
References: <1502353273-123788-1-git-send-email-shawn.lin@rock-chips.com> <5781211.7fcSyQo7bC@phil>
In-Reply-To: <5781211.7fcSyQo7bC@phil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Heiko,

On 08/10/2017 05:27 PM, Heiko Stuebner wrote:
> Hi Shawn,
>
> Am Donnerstag, 10. August 2017, 16:21:13 CEST schrieb Shawn Lin:
>> >With CONFIG_DEBUG_SHIRQ enabled, the irq tear down routine
>> >would still access the irq handler registed as a shard irq.
>> >Per the comment within the function of __free_irq, it says
>> >"It's a shared IRQ -- the driver ought to be prepared for
>> >an IRQ event to happen even now it's being freed". However
>> >when failing to probe the driver, it may disable the clock
>> >for accessing the register and the following check for shared
>> >irq state would call the irq handler which accesses the register
>> >w/o the clk enabled. That will hang the system forever.
> The key point would be to fix the ordering. So you could also just use
> devm_add_action to move the clock-disabling into a callback that
> gets run at the appropriate time, as devm does the shutdown in the
> exact opposite order this should fix your problem.
>
> So until all clocks could be enabled, you would disable them manually
> and after that rely on the devm_action to fire at the appropriate time.
>
> ret = clk_prepare_enable(clk1);
> if (ret < 0 )
> 	return ret;
>
> ret = clk_prepare_enable(clk2);
> if (ret < 0) {
> 	clk_disable_unprepare(clk1);
> 	return ret;
> }
>
> devm_add_action_or_reset(dev, rk_pcie_disable_clocks);

right, and we should also move request irq after this, so the devres 
core can release them in reverse.

and we should double check would those clks be the only thing that irq 
handler required...
>
> The rockchip crypto driver [0] shows how this could be done.
>
>
> Heiko
>
> [0]http://elixir.free-electrons.com/linux/latest/source/drivers/crypto/rockchip/rk3288_crypto.c#L307
>
