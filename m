Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:58161 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753806AbaF3Rbj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jun 2014 13:31:39 -0400
Message-ID: <53B19EF2.7020801@gmail.com>
Date: Mon, 30 Jun 2014 19:31:30 +0200
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
CC: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
	Zhang Rui <rui.zhang@intel.com>, Bryan Wu <cooloney@gmail.com>,
	Richard Purdie <rpurdie@rpsys.net>, linux-leds@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com, Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 00/13] Remove mach-kirkwood and mach-dove
References: <1404075603-31838-1-git-send-email-andrew@lunn.ch> <20140629213510.GR32514@n2100.arm.linux.org.uk> <53B154FE.80804@gmail.com> <20140630124320.GZ32514@n2100.arm.linux.org.uk> <53B164B2.7090902@gmail.com> <20140630142516.GA32514@n2100.arm.linux.org.uk> <53B183D5.8020708@gmail.com> <20140630165615.GE32514@n2100.arm.linux.org.uk>
In-Reply-To: <20140630165615.GE32514@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/30/2014 06:56 PM, Russell King - ARM Linux wrote:
> On Mon, Jun 30, 2014 at 05:35:49PM +0200, Sebastian Hesselbarth wrote:
>> On 06/30/2014 04:25 PM, Russell King - ARM Linux wrote:
>>> Nothing has changed on the PMU patches since I posted them, because
>>> they're based on 3.15 and there's been no changes there.
>>
>> I offered to deal with mainlining them end of April, you never replied.
>> I know that if you dislike something you answer, but it is hard to tell
>> if silence means agreement.
>>
>> I am not going to waste any time preparing patches just to get a NAK.
> 
> That's because I am quite prepared to work on them _if_ there is a way
> forward.  You've already said that changing things like hwmon and rtc
> is a work in progress to convert them to regmap.  That's great, but
> in order to progress these myself, I need *visibility* of that work,
> and there is zero visibility of that.

So, we are on the same boat. For the HDMI issue, I also need visibility
to add any more ideas how to deal with it. Just provide me the binaries,
I see if I can at least reproduce the issue.

>>> As for the ASoC stuff which you avoided commenting on, let me repeat
>>> that _that_ stuff is now totally dead and can /never/ be merged into
>>> mainline without breaking the existing ASoC kirkwood support.  In
>>> that case, it's not like I wasn't sending the patches out, because
>>> I had been... so everyone was aware of what was going on there,
>>> but I guess converting stuff to DT in ways that totally fuck over
>>> other patches is what now happens in the kernel.
>>
>> If you are talking about "Kirkwood ASoC updates", you got a Tested-by
>> from Andrew even before I read your patches. And besides, just because
>> I am interested in Dove does not mean I just swallowed the whole Linux
>> API knowledge. I simply avoided commenting on it, because there is
>> /nothing/ I can add to it.
> 
> No I am not - and those are the patches which I referred to as having
> been already taken by Mark into his tree.  The patch I'm referring to
> which can never be merged now is the one which I replied to Jean
> Francois just now - and if you read through it, you'll understand
> why - that's because it /totally/ breaks the simple DT bindings that
> are now established - independently - for Kirkwood stuff.

And I stopped discussing the pros and cons of the simple DT binding
as soon as I realized that my comments had no impact on the way it
will be implemented. I am not responsible for the binding.

>>> What I think you're missing is that for those of us who want to have
>>> a platform fully supported, the choice has been non-DT until relatively
>>> recently.  We're now at the point where the DT support on Dove has
>>> matured to the point where it's relatively easy to end up with a fully
>>> functional (but not necessarily bug free) setup with DT.  It's at the
>>> sweet spot where you can switch between DT and non-DT and preserve
>>> that functionality... but as soon as we get there we want to rip out
>>> the old stuff.
>>
>> Oh, ok.. you think it is "me" and "us"? It is you who actually want to
>> use Dove and me just wanting a DT representation for it?
>>
>> It is not my fault that your patches are blocked by others. I can offer
>> help to track down the issue, but I am not going to be your scapegoat.
> 
> Right, and removing the non-DT support and screwing people like me
> who have out of tree patches is good for MVEBU development because...
> (complete the sentence with a damned good reason.)

...ranting at people not jumping into review and testing is.

>>> What I'm trying to get you to understand is that leaving the old stuff
>>> behind for a little while longer is beneficial - while those who have
>>> been running crippled DT based setups for the last year don't care
>>> about having full support, there are those who do.
>>
>> Ok, let's have mach-dove for a little longer, fine with me.
> 
> Great, that's all I ask.  I'm trying as fast as I can to push stuff
> out - I'm not being anywhere close to idle about it - but it takes time
> to deal with the updates from each merge window and such like, work out
> what has been accepted, which patches need to be revised, and do all the
> testing that's necessary before trying to get some more out.  Oh, and
> port some more of the patches over to be mainline-based.

> I would've preferred to be clear of the ASoC stuff 12 months ago, and
> we all know why that was a big problem.

>> What I really want is to stop that blackmailing with giving up on
>> sending patches. It will be a huge loss if you do and many have said
>> that in the past.
> 
> It's not blackmail.  It's reality.  If the kernel becomes too much
> hassle to deal with, then volunteers will walk away from it - that's
> almost a fact of life.

Right. And since I am one of those volunteers, I can tell you that
some specific attitude in dealing with people is definitely reducing
the willingness to stick with it.

I constantly offered to spend my spare time for hunting the issue
but only received ranting.

> Even with DT support, I'm nowhere near being "DT clean" on the Cubox -
> I need this as a minimum to do "special" stuff there:

Sure, nobody said that DT is feature complete. But you'd have to do
the same on mainline non-DT dove as there has never been support for
the cubox.

If it helps us tracking down the HDMI issue, we can have below setup
for DT dove and get rid of it incrementally.

I am sure, Andrew can drop removing mach-dove removal from the patches
and we can continue improving Dove mainline.

Sebastian

> #include <linux/of_platform.h>
> #include <asm/hardware/cache-tauros2.h>
> #include "clock.h"
> 
> static struct resource armada_drm_resources[] = {
>         DEFINE_RES_MEM(0, 0),
> };
> 
> static const char *armada_drm_devices[4];
> 
> static const struct platform_device_info armada_drm_dev_info __initconst = {
>         .name = "armada-drm",
>         .id = -1,
>         .res = armada_drm_resources,
>         .num_res = ARRAY_SIZE(armada_drm_resources),
>         .data = armada_drm_devices,
>         .size_data = sizeof(armada_drm_devices),
> };
> 
> static struct platform_device cubox_spdif = {
>         .name   = "kirkwood-spdif-audio",
>         .id     = 1,
> };
> 
> static const struct platform_device_info cubox_spdif_dit __initconst = {
>         .name = "spdif-dit",
>         .id = -1,
> };
> 
> static void __init cubox_reserve(void)
> {
>         phys_addr_t phys;
> 
>         dove_reserve();
> 
>         /* Steal 32MB for the drm framebuffers */
>         phys = arm_memblock_steal(SZ_32M, SZ_2M);
>         armada_drm_resources[0].start = phys;
>         armada_drm_resources[0].end = phys + SZ_32M - 1;
> }
> 
> static void __init cubox_dt_init(void)
> {
>         struct device_node *node;
>         struct platform_device *pdev;
>         int i;
> 
>         pr_info("Dove 88AP510 SoC\n");
> 
> #ifdef CONFIG_CACHE_TAUROS2
>         tauros2_init(0);
> #endif
>         dove_init_pmu();
> 
>         BUG_ON(mvebu_mbus_dt_init());
>         of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> 
>         dove_devclks_init();
>         dove_gpu_init();
>         dove_bmm_init();
> 
>         for (i = 0, node = NULL; (node = of_find_compatible_node(node, NULL, "marvell,dove-lcd")) != NULL; ) {
>                 if (!of_device_is_available(node))
>                         continue;
>                 pdev = of_find_device_by_node(node);
>                 if (pdev)
>                         armada_drm_devices[i++] = dev_name(&pdev->dev);
>         }
>         armada_drm_devices[i++] = NULL;
>         platform_device_register_full(&armada_drm_dev_info);
> 
>         platform_device_register_full(&cubox_spdif_dit);
>         platform_device_register(&cubox_spdif);
> }
> 
> static const char * const cubox_dt_compat[] = {
>         "solidrun,cubox",
>         NULL
> };
> 
> DT_MACHINE_START(DOVE_DT, "Marvell Dove (Cubox)")
>         .dt_compat      = cubox_dt_compat,
>         .reserve        = cubox_reserve,
>         .map_io         = dove_map_io,
>         .init_machine   = cubox_dt_init,
>         .restart        = dove_restart,
> };
> 
> 

