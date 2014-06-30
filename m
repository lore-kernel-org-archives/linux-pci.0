Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:47900 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752634AbaF3TgG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jun 2014 15:36:06 -0400
Date: Mon, 30 Jun 2014 20:35:40 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
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
Message-ID: <20140630193540.GG32514@n2100.arm.linux.org.uk>
References: <1404075603-31838-1-git-send-email-andrew@lunn.ch> <20140629213510.GR32514@n2100.arm.linux.org.uk> <53B154FE.80804@gmail.com> <20140630124320.GZ32514@n2100.arm.linux.org.uk> <53B164B2.7090902@gmail.com> <20140630142516.GA32514@n2100.arm.linux.org.uk> <53B183D5.8020708@gmail.com> <20140630165615.GE32514@n2100.arm.linux.org.uk> <53B19EF2.7020801@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53B19EF2.7020801@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 30, 2014 at 07:31:30PM +0200, Sebastian Hesselbarth wrote:
> On 06/30/2014 06:56 PM, Russell King - ARM Linux wrote:
> > On Mon, Jun 30, 2014 at 05:35:49PM +0200, Sebastian Hesselbarth wrote:
> >> On 06/30/2014 04:25 PM, Russell King - ARM Linux wrote:
> >>> Nothing has changed on the PMU patches since I posted them, because
> >>> they're based on 3.15 and there's been no changes there.
> >>
> >> I offered to deal with mainlining them end of April, you never replied.
> >> I know that if you dislike something you answer, but it is hard to tell
> >> if silence means agreement.
> >>
> >> I am not going to waste any time preparing patches just to get a NAK.
> > 
> > That's because I am quite prepared to work on them _if_ there is a way
> > forward.  You've already said that changing things like hwmon and rtc
> > is a work in progress to convert them to regmap.  That's great, but
> > in order to progress these myself, I need *visibility* of that work,
> > and there is zero visibility of that.
> 
> So, we are on the same boat. For the HDMI issue, I also need visibility
> to add any more ideas how to deal with it. Just provide me the binaries,
> I see if I can at least reproduce the issue.

What I can do is provide a branch of all the current stuff which is
relatively clean for mainline:

http://ftp.arm.linux.org.uk/cgit/linux-cubox.git/log/?h=cubox-ml-3.15

there's lots missing from it, and it probably doesn't even build
properly, but that's one of the side effects of trying to keep
everything working and juggling between mainline and something that
works.

> Right. And since I am one of those volunteers, I can tell you that
> some specific attitude in dealing with people is definitely reducing
> the willingness to stick with it.
> 
> I constantly offered to spend my spare time for hunting the issue
> but only received ranting.

All that I'm /complaining/ about is the very quick removal of the
non-DT support.

> Sure, nobody said that DT is feature complete. But you'd have to do
> the same on mainline non-DT dove as there has never been support for
> the cubox.

Indeed, but successively merging mainline into Rabeeh's tree is rather
trivial for the most part (apart from a few nasty conflicts, such as the
completely different si5531 driver).  Where that happens, I take
mainline's version, and if necessary augment it to make non-DT work
again.

That has pros and cons - the pro is that I get to keep a feature complete
kernel on the hardware.  The con is that I still need to use bits of
mach-dove to make everything work, even with DT.

> If it helps us tracking down the HDMI issue, we can have below setup
> for DT dove and get rid of it incrementally.

Right, and you'll also need stuff such as the component updates I've
been trying to push recently, updates to Armada DRM so that it can be
used in a DT environment (included in the above git tree), and probably
a few other things.

The timeline for DRM stuff looks something like this:

- get the component updates reviewed and acceptable
- get those merged by Greg
- chase up what's happening with the DRM bug fix
- get the DRM of_graph helper reviewed and merged
- get the Armada DRM component helper conversion reviewed and merged
  (which depends on sorting out how to deal with the component helper
   dependency and need for those changes to be with these changes.)
- same for the tda998x driver, which will also need the DRM of_graph
  helpers.

I /suspect/ what's going to happen there is that the component updates
will make the 3.17 merge window, and maybe the initial DRM stuff.
The remainder will be for the 3.18 merge window when everyone has
the dependencies in their trees to cope with those changes.

So that's probably something like 4 to 6 months just for that (assuming
a kernel cycle is three months.)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
