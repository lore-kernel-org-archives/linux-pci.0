Return-Path: <SRS0=Qjlt=72=gmail.com=dmitry.torokhov@kernel.org>
Return-Path: <SRS0=Qjlt=72=gmail.com=dmitry.torokhov@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170824202111.GS31858@bhelgaas-glaptop.roam.corp.google.com>
References: <1503471673-69478-1-git-send-email-shawn.lin@rock-chips.com>
 <1503471758-73904-1-git-send-email-shawn.lin@rock-chips.com> <20170824202111.GS31858@bhelgaas-glaptop.roam.corp.google.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Thu, 24 Aug 2017 14:10:52 -0700
Message-ID: <CAKdAkRRFxsAfJrzr=rjo_mtMzP0y9-cRz9Vz+M92AhbYd5B=ww@mail.gmail.com>
Subject: Re: [PATCH v5 04/10] PCI: rockchip: fix system hang up if activating CONFIG_DEBUG_SHIRQ
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	"open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
	Brian Norris <briannorris@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
	Tejun Heo <tj@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 24, 2017 at 1:21 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> [+cc Tejun, Dmitry, Michael, Stephen, linux-clk for devm/clk questions]
>
> On Wed, Aug 23, 2017 at 03:02:38PM +0800, Shawn Lin wrote:
>> With CONFIG_DEBUG_SHIRQ enabled, the irq tear down routine
>> would still access the irq handler registed as a shard irq.
>> Per the comment within the function of __free_irq, it says
>> "It's a shared IRQ -- the driver ought to be prepared for
>> an IRQ event to happen even now it's being freed". However
>> when failing to probe the driver, it may disable the clock
>> for accessing the register and the following check for shared
>> irq state would call the irq handler which accesses the register
>> w/o the clk enabled. That will hang the system forever.
>>
>> With adding some dump_stack we could see how that happened.
>>
>> calling  rockchip_pcie_driver_init+0x0/0x28 @ 1
>> rockchip-pcie f8000000.pcie: no vpcie3v3 regulator found
>> rockchip-pcie f8000000.pcie: no vpcie1v8 regulator found
>> rockchip-pcie f8000000.pcie: no vpcie0v9 regulator found
>> rockchip-pcie f8000000.pcie: PCIe link training gen1 timeout!
>> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.13.0-rc3-next-20170807-ARCH+ #189
>> Hardware name: Firefly-RK3399 Board (DT)
>> Call trace:
>> [<ffff000008089bf0>] dump_backtrace+0x0/0x250
>> [<ffff000008089eb0>] show_stack+0x20/0x28
>> [<ffff000008c3313c>] dump_stack+0x90/0xb0
>> [<ffff000008632ad4>] rockchip_pcie_read.isra.11+0x54/0x58
>> [<ffff0000086334fc>] rockchip_pcie_client_irq_handler+0x30/0x1a0
>> [<ffff00000813ce98>] __free_irq+0x1c8/0x2dc
>> [<ffff00000813d044>] free_irq+0x44/0x74
>> [<ffff0000081415fc>] devm_irq_release+0x24/0x2c
>> [<ffff00000877429c>] release_nodes+0x1d8/0x30c
>> [<ffff000008774838>] devres_release_all+0x3c/0x5c
>> [<ffff00000876f19c>] driver_probe_device+0x244/0x494
>> [<ffff00000876f50c>] __driver_attach+0x120/0x124
>> [<ffff00000876cb80>] bus_for_each_dev+0x6c/0xac
>> [<ffff00000876e984>] driver_attach+0x2c/0x34
>> [<ffff00000876e3a4>] bus_add_driver+0x244/0x2b0
>> [<ffff000008770264>] driver_register+0x70/0x110
>> [<ffff0000087718b4>] platform_driver_register+0x60/0x6c
>> [<ffff0000091eb108>] rockchip_pcie_driver_init+0x20/0x28
>> [<ffff000008083a2c>] do_one_initcall+0xc8/0x130
>> [<ffff0000091a0ea8>] kernel_init_freeable+0x1a0/0x238
>> [<ffff000008c461cc>] kernel_init+0x18/0x108
>> [<ffff0000080836c0>] ret_from_fork+0x10/0x50
>>
>> In order to fix this, we remove all the clock-disabling from
>> the error handle path and driver's remove function. And replying
>> on the devm_add_action_or_reset to fire the clock-disabling at
>> the appropriate time. Also split out rockchip_pcie_setup_irq
>> and move requesting irq after enabling clks to avoid this kind
>
> Thanks for splitting out the refactoring stuff.  That really makes
> this patch much simpler.
>
> IIUC, this really has nothing to do with CONFIG_DEBUG_SHIRQ.  It may
> be true that you've only *seen* the problem with CONFIG_DEBUG_SHIRQ
> enabled, but all that config option does is take a situation that
> could happen at any time (another device sharing the IRQ generating an
> interrupt), and force it to happen.  So it's just a way to expose an
> existing driver problem.
>
> The real problem is apparently that rockchip_pcie_subsys_irq_handler()
> relies on some clock being enabled, but we're leaving it registered at
> a time when the clock has already been disabled.
>
> You fixed that by using devm_add_action_or_reset() to tell devm to
> disable the clocks *after* releasing the IRQ.
>
> That sort of makes sense, but devm_add_action_or_reset() is a little
> obscure, and this feels like a hole in the devm framework.  Seems like
> it would be nice if there were some sort of devm wrapper for
> clk_prepare_enable() so this would happen automatically.
>
> This pattern:
>
>   clk = devm_clk_get(...);
>   if (IS_ERR(clk)) {
>     dev_warn("no clock for ...");
>     return PTR_ERR(clk);
>   }
>
>   ret = clk_prepare_enable(clk);
>   if (ret) {
>     dev_warn("failed to enable ...");
>     return err;
>   }
>
> is quite common ("git grep -A10 devm_clk_get | grep clk_prepare_enable
>  | wc -l" finds over 400 occurrences).  Should there be something to
> simplify this a little?
>
> I also wonder about other PCI host drivers that use both
> clk_prepare_enable() and devm_request_irq().  Maybe Rockchip is
> "special" in that it seems the driver must turn on a clock before it
> can even talk to the host controller, whereas maybe other drivers can
> always talk to the host controller, but need to turn on clocks
> downstream from the controller.  I didn't audit them, but I'm
> concerned that some of them might have this same problem.

I proposed devm_clk_prepare_enable() and friends (see
https://lkml.org/lkml/2017/2/14/544), but Stephen did not like it and
mentioned that he and Mike were working on a different solution where
clk_put() would drop all enables. I have not seen any updates on that
though. Maybe we should revisit devm approach?

Thanks.

-- 
Dmitry
