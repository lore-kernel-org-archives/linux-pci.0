Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:44610 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781AbaF3NXG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jun 2014 09:23:06 -0400
Message-ID: <53B164B2.7090902@gmail.com>
Date: Mon, 30 Jun 2014 15:22:58 +0200
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
References: <1404075603-31838-1-git-send-email-andrew@lunn.ch> <20140629213510.GR32514@n2100.arm.linux.org.uk> <53B154FE.80804@gmail.com> <20140630124320.GZ32514@n2100.arm.linux.org.uk>
In-Reply-To: <20140630124320.GZ32514@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/30/2014 02:43 PM, Russell King - ARM Linux wrote:
> On Mon, Jun 30, 2014 at 02:15:58PM +0200, Sebastian Hesselbarth wrote:
>> Can you give a /rough/ schedule for your plans to sort out your private
>> branches? If we can all investigate the issue with the same code basis,
>> I am sure we can make DT dove behave the same way non-DT dove seems to
>> be.
>
> As you will be aware, that is an unreasonable question.  I have no
> idea what so ever how long it will take to sort out my private
> branches, because it doesn't depend all that much on me.

Russell,

we all know about the pain to get things into mainline especially when
it touches different sub-systems. That is why I was asking for /your/
plans, so we can think of ways to deal with mach-dove removal and your
pending patches.

> For example, I've had fully working audio on the Cubox for 18+ months,
> but there's a big problem getting it into mainline.  First it was the
> lack of co-operation from the ASoC maintainers.  Then it was the ASoC
> maintainers accepting Jean-Francois patches (which really torpedoed
> my efforts.)  And the final problem which makes it totally impossible
> is that pushing the DPCM stuff will completely break the DT based
> kirkwood ASoC stuff which got pushed in.
>
> I suspect that the PMU work I did has also been torpedoed because of
> no one in the mvebu circles has really thought about how to deal
> properly with the overlapping registers for the PMU, hwmon and RTC.

Of course we thought about it. But as you are dealing with different
SoCs at a time, we also have to care about some more SoCs than just
Dove. And, of course, we also run out of spare time to prepare proper
patches over and over again. I really /know/ that if you send patches,
they are well thought and well tested, so I basically postpone work
on that if I know you are working on it.

My current idea of PMU register space is to have a DT provided regmap
but again, there are patches floating around but currently that regmap
helpers are still WIP. FWIW, if you look at dove pinctrl, we did a
last-minute patch for the PMU regs - just because you mentioned a
concern, so we really care about your opinion. The fact that it is not
solved is pure lack of time.

> Right now, I have 250 patches in my Cubox tree against a base of
> 3.15 plus the original set of changes.  And no, I'm *not* going
> to be stupid enough to publish the tree because of the non-GPL
> license header(s) on various files in the Vivante code base.

Exactly that increasing amount of (valuable) patches makes it more
and more difficult for you and us to reproduce any issues. All I am
asking for is: if you don't push that branch for good reason, try to
split off at least some patches. Hunting issues like the HDMI thing
with 250 patches off, really isn't going to work well.

> I'm actually on the point of just giving up with mainlike on the Cubox
> because of this kind of crap, and the extreme difficulty to get any
> kind of progress on this stuff - and I'm seeing a growing number of
> patches on the Cubox-i side of things, the mainline churn on mach-dove
> is becoming a /big/ problem.
>
> So... if you want to remove mach-dove, then I'll just add to my
> cubox tree an entire revert of it.  Especially as DT does not work
> properly here and non-DT does.

Nobody wants you to revert any cubox patches! Honestly, I repeatedly
said that /although/ I cannot reproduce the issue on my (mainline)
branch, I still /agree/ that there may be issues. But as long as I
cannot reproduce it, I cannot dig into it.

To put it another way: "Especially for me DT does work properly here
and non-DT does not". Let's just try to reduce the gap between mainline
and your branch incrementally.

> And I really don't buy your "it's down to the timing" explanation -
> because (a) switching from 720p to 1080p reprograms the clock chain
> right from the Si5351, which is no different to what happens on
> initial bring up, and (b) I've measured the HDMI clock which is
> derived from this chain and it is correct and unmodulated.

I didn't say I *know* it is 'timing', but neither I do buy "it's because
of DT". I said it may be related with init order and ignoring clock
stable requirements. I've written Si5351 driver from an Application
Note that is not very noisy about dynamic configuration, there are no
checks for stable clocks at all.

Anyway, I still offer my time to hunt the HDMI issue: If we agree on
some way to share your code or you provide some binaries I can reproduce
the issue with, it will be a small step forward.

Sebastian
