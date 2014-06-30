Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:52494 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175AbaF3Pf4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jun 2014 11:35:56 -0400
Message-ID: <53B183D5.8020708@gmail.com>
Date: Mon, 30 Jun 2014 17:35:49 +0200
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
References: <1404075603-31838-1-git-send-email-andrew@lunn.ch> <20140629213510.GR32514@n2100.arm.linux.org.uk> <53B154FE.80804@gmail.com> <20140630124320.GZ32514@n2100.arm.linux.org.uk> <53B164B2.7090902@gmail.com> <20140630142516.GA32514@n2100.arm.linux.org.uk>
In-Reply-To: <20140630142516.GA32514@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/30/2014 04:25 PM, Russell King - ARM Linux wrote:
> On Mon, Jun 30, 2014 at 03:22:58PM +0200, Sebastian Hesselbarth wrote:
>> Of course we thought about it. But as you are dealing with different
>> SoCs at a time, we also have to care about some more SoCs than just
>> Dove. And, of course, we also run out of spare time to prepare proper
>> patches over and over again. I really /know/ that if you send patches,
>> they are well thought and well tested, so I basically postpone work
>> on that if I know you are working on it.
>>
>> My current idea of PMU register space is to have a DT provided regmap
>> but again, there are patches floating around but currently that regmap
>> helpers are still WIP. FWIW, if you look at dove pinctrl, we did a
>> last-minute patch for the PMU regs - just because you mentioned a
>> concern, so we really care about your opinion. The fact that it is not
>> solved is pure lack of time.
>
> Nothing has changed on the PMU patches since I posted them, because
> they're based on 3.15 and there's been no changes there.

I offered to deal with mainlining them end of April, you never replied.
I know that if you dislike something you answer, but it is hard to tell
if silence means agreement.

I am not going to waste any time preparing patches just to get a NAK.

>> Exactly that increasing amount of (valuable) patches makes it more
>> and more difficult for you and us to reproduce any issues. All I am
>> asking for is: if you don't push that branch for good reason, try to
>> split off at least some patches. Hunting issues like the HDMI thing
>> with 250 patches off, really isn't going to work well.
>
> Right, so what I have against mainline right now in my tree is:
>
> * two SPI patches, which have been taken by Mark
> * one long term core ARM patch adding optimised memset/memcpy IO operations
> * the PMU stuff
> * BMM (already published in git form)
> * Vmeta (already published in git form)
> * ASoC cleanup patches, which Mark took last week.
>
> What isn't visible is the stuff which converts Armada DRM to component
> support, along with the TDA998x driver (and it sounds like the TI LCDC
> people may end up blocking that effort).  This is necessary to convert
> it to DT support.  However, this depends on the component helper, and
> that's where there's a blocking problem.
>
> I sent out a bunch of patches last week, with a request for help from
> the Exynos people.  So far, that has only attracted one relatively minor
> comment from the iMX people.  I can't move forwards with the Armada
> DRM until this is sorted.  Neither can I move forward with the TDA998x
> driver.
>
> As for the ASoC stuff which you avoided commenting on, let me repeat
> that _that_ stuff is now totally dead and can /never/ be merged into
> mainline without breaking the existing ASoC kirkwood support.  In
> that case, it's not like I wasn't sending the patches out, because
> I had been... so everyone was aware of what was going on there,
> but I guess converting stuff to DT in ways that totally fuck over
> other patches is what now happens in the kernel.

If you are talking about "Kirkwood ASoC updates", you got a Tested-by
from Andrew even before I read your patches. And besides, just because
I am interested in Dove does not mean I just swallowed the whole Linux
API knowledge. I simply avoided commenting on it, because there is
/nothing/ I can add to it.

Really, I know you do dig down to the bottom of every subsystem you
are working with but I simply cannot. Just because I don't have the
time for it.

> What I think you're missing is that for those of us who want to have
> a platform fully supported, the choice has been non-DT until relatively
> recently.  We're now at the point where the DT support on Dove has
> matured to the point where it's relatively easy to end up with a fully
> functional (but not necessarily bug free) setup with DT.  It's at the
> sweet spot where you can switch between DT and non-DT and preserve
> that functionality... but as soon as we get there we want to rip out
> the old stuff.

Oh, ok.. you think it is "me" and "us"? It is you who actually want to
use Dove and me just wanting a DT representation for it?

It is not my fault that your patches are blocked by others. I can offer
help to track down the issue, but I am not going to be your scapegoat.

> Let me put that another way: it's at the point where those of us who
> have been using non-DT support can start moving the remaining drivers
> over to a DT environment without any functional loss.
>
> What I'm trying to get you to understand is that leaving the old stuff
> behind for a little while longer is beneficial - while those who have
> been running crippled DT based setups for the last year don't care
> about having full support, there are those who do.

Ok, let's have mach-dove for a little longer, fine with me.

> Of course, there's another solution to this.  I stay with my present
> 3.15 kernel for ever.  That basically bars me from sending any further
> patches.  It also means that I stop maintaining TDA998x and Armada DRM,
> and you will have to take those over, which means you get the additional
> workload from those.  Is that what you really want?

What I really want is to stop that blackmailing with giving up on
sending patches. It will be a huge loss if you do and many have said
that in the past.

If it is really me who upsets you because you feel I am blocking your
patches, just ignore my comments. Jason will happily pick them up
just because you signed them off.

Sebastian

> The Cubox is the /only/ ARM platform I have which is a capable media
> player, and I'm trying not to have it screwed by this kind of crap.
>

