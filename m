Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:47766 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756249AbaF3SJS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jun 2014 14:09:18 -0400
Date: Mon, 30 Jun 2014 19:08:53 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Jason Cooper <jason@lakedaemon.net>,
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
Message-ID: <20140630180853.GF32514@n2100.arm.linux.org.uk>
References: <1404075603-31838-1-git-send-email-andrew@lunn.ch> <20140629213510.GR32514@n2100.arm.linux.org.uk> <53B154FE.80804@gmail.com> <20140630124320.GZ32514@n2100.arm.linux.org.uk> <53B164B2.7090902@gmail.com> <20140630142516.GA32514@n2100.arm.linux.org.uk> <53B183D5.8020708@gmail.com> <20140630165615.GE32514@n2100.arm.linux.org.uk> <20140630174351.GI18520@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140630174351.GI18520@lunn.ch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 30, 2014 at 07:43:51PM +0200, Andrew Lunn wrote:
> > > If you are talking about "Kirkwood ASoC updates", you got a Tested-by
> > > from Andrew even before I read your patches. And besides, just because
> > > I am interested in Dove does not mean I just swallowed the whole Linux
> > > API knowledge. I simply avoided commenting on it, because there is
> > > /nothing/ I can add to it.
> > 
> > No I am not - and those are the patches which I referred to as having
> > been already taken by Mark into his tree.  The patch I'm referring to
> > which can never be merged now is the one which I replied to Jean
> > Francois just now - and if you read through it, you'll understand
> > why - that's because it /totally/ breaks the simple DT bindings that
> > are now established - independently - for Kirkwood stuff.
> 
> Hi Russell
> 
> Are you referring to http://www.spinics.net/lists/arm-kernel/msg328068.html

I'm referring to the _entire_ addition of DT support for the sound stuff
on mvebu.

The timeline from my point of view started around March/April 2013, which
is where I was told that the kirkwood stuff should be converted to DPCM
in order to allow the SPDIF output to be used.  The documentation and
hints how to use it fell way short of what was required - and moreover,
the ASoC code to support this feature was missing several patches that
Liam had (and was freezing on to, eventually sending them after last
year's kernel summit.)

However, eventually it got sorted through face to face discussions with
Mark and Liam at kernel summit, but not before Jean-Francois patches
had been merged.  My solution was developed and tested without Jean's
patches in place.

While I was sorting out the fallout from that, the patches to convert
kirkwood to use the simple-card stuff were merged.  At this point, I
basically decided that was the end of nine months of effort to get SPDIF
with DPCM properly supported, and earlier this year I emailed Mark to
say that I regard that effort as being completely dead (even though I
still use it, because it's the only way to get SPDIF output properly
working with MPEG/AC3 compressed output.)

Jean is only interested in feeding I2S out to the HDMI port, he's not
interested in the SPDIF optical connector on the side, neither is he
interested in the compressed stream support.  Neither of these are now
possible without breaking the DT bindings for the ASoC implementation.

This is the problem - in the mad headlong rush for DT support as if
it's the most important thing on the planet, it seems that things
haven't been properly considered - and it's not like I haven't been
publishing these ASoC patches.  I've sent numerous rounds of patches
during 2013.

So, what do we do now with support for compressed audio streams via
SPDIF on kirkwood hardware?  As far as I can see, it's no longer
possible and mainline kernels will never support this.  Please tell
me I'm wrong...

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
