Return-Path: <SRS0=j+1X=73=rock-chips.com=jeffy.chen@kernel.org>
Return-Path: <SRS0=j+1X=73=rock-chips.com=jeffy.chen@kernel.org>
Message-ID: <599F77E7.4040604@rock-chips.com>
Date: Fri, 25 Aug 2017 09:05:43 +0800
From: jeffy <jeffy.chen@rock-chips.com>
MIME-Version: 1.0
To: Bjorn Helgaas <helgaas@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-rockchip@lists.infradead.org,
 Brian Norris <briannorris@chromium.org>,
 Tejun Heo <tj@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 04/10] PCI: rockchip: fix system hang up if activating
 CONFIG_DEBUG_SHIRQ
References: <1503471673-69478-1-git-send-email-shawn.lin@rock-chips.com> <1503471758-73904-1-git-send-email-shawn.lin@rock-chips.com> <20170824202111.GS31858@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170824202111.GS31858@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 08/25/2017 04:21 AM, Bjorn Helgaas wrote:
>> >In order to fix this, we remove all the clock-disabling from
>> >the error handle path and driver's remove function. And replying
>> >on the devm_add_action_or_reset to fire the clock-disabling at
>> >the appropriate time. Also split out rockchip_pcie_setup_irq
>> >and move requesting irq after enabling clks to avoid this kind
> Thanks for splitting out the refactoring stuff.  That really makes
> this patch much simpler.
>
> IIUC, this really has nothing to do with CONFIG_DEBUG_SHIRQ.  It may
> be true that you've only*seen*  the problem with CONFIG_DEBUG_SHIRQ
> enabled, but all that config option does is take a situation that
> could happen at any time (another device sharing the IRQ generating an
> interrupt), and force it to happen.  So it's just a way to expose an
> existing driver problem.
yes, and i'm wondering would it make more sense to somehow ignore those 
irqs(triggered by other devices, and we don't really need to care since 
we already unregistered) than trying to hold all needed resources(clks & 
power domains & some other resources maybe) for that?

maybe we can just make sure the irq handler unregistered when we stop 
caring about the irqs? or maybe add a flag to tell the irq handler to 
stop processing them?

>
> The real problem is apparently that rockchip_pcie_subsys_irq_handler()
> relies on some clock being enabled, but we're leaving it registered at
> a time when the clock has already been disabled.
>
> You fixed that by using devm_add_action_or_reset() to tell devm to
> disable the clocks*after*  releasing the IRQ.
>
> That sort of makes sense, but devm_add_action_or_reset() is a little
> obscure, and this feels like a hole in the devm framework.  Seems like
> it would be nice if there were some sort of devm wrapper for
> clk_prepare_enable() so this would happen automatically.
>
> This pattern:
>
>    clk = devm_clk_get(...);
>    if (IS_ERR(clk)) {
>      dev_warn("no clock for ...");
>      return PTR_ERR(clk);
>    }
>
>    ret = clk_prepare_enable(clk);
>    if (ret) {
>      dev_warn("failed to enable ...");
>      return err;
>    }
>
> is quite common ("git grep -A10 devm_clk_get | grep clk_prepare_enable
>   | wc -l" finds over 400 occurrences).  Should there be something to
> simplify this a little?
>
> I also wonder about other PCI host drivers that use both
> clk_prepare_enable() and devm_request_irq().  Maybe Rockchip is
> "special" in that it seems the driver must turn on a clock before it
> can even talk to the host controller, whereas maybe other drivers can
> always talk to the host controller, but need to turn on clocks
> downstream from the controller.  I didn't audit them, but I'm
> concerned that some of them might have this same problem.
>
