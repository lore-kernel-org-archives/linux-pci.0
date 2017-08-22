Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.141]:55642 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754190AbdHVCbz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2017 22:31:55 -0400
Message-ID: <599B975C.20807@rock-chips.com>
Date: Tue, 22 Aug 2017 10:30:52 +0800
From: jeffy <jeffy.chen@rock-chips.com>
MIME-Version: 1.0
To: Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v2] PCI: rockchip: fix system hang up if activating CONFIG_DEBUG_SHIRQ
References: <1502363923-19946-1-git-send-email-shawn.lin@rock-chips.com> <3312094.6zR5NuJAgK@phil>
In-Reply-To: <3312094.6zR5NuJAgK@phil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Heiko,

On 08/10/2017 08:22 PM, Heiko Stuebner wrote:
>>
>> >+	devm_add_action_or_reset(dev,
>> >+				 rockchip_pcie_disable_clocks, rockchip);
>> >+
> err = devm_add_action_or_reset(...)
> if (err) {
> ...
> }
>
> devm_add_action_or_reset can fail. When it fails, it will call the
> action already, so your error handling does not need to disable
> clocks on its own.
>
>
> Also, as a more general comment, right now you do devm_request_irq
> from rockchip_pcie_parse_dt, which gets called_before_  clocks are
> enabled.
>
> This will likely bite you at some point as well, as the irq can fire at
> any point after it got requested ... including before you enable the
> clocks.
>
> So the order should probably be
>
> - enable clocks
> - register devm_action to shutdown clocks
> - parse_dt including requesting the irq.
>
>
> Heiko

it turns out this irq handler not only depends on clks, but also pm 
domain :(

so handling it with devm_* functions would be a little 
complicated(https://lkml.org/lkml/2017/8/15/146).

would it make sense to use request_irq/free_irq directly?

or maybe add a flag(for example probed), and check it in the irq handler 
before read registers? then we would just need to make sure the priv 
struct be freed later than the irq.

>
>
