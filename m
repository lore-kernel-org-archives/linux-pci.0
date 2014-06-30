Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:47219 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751414AbaF3Mnx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jun 2014 08:43:53 -0400
Date: Mon, 30 Jun 2014 13:43:20 +0100
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
Message-ID: <20140630124320.GZ32514@n2100.arm.linux.org.uk>
References: <1404075603-31838-1-git-send-email-andrew@lunn.ch> <20140629213510.GR32514@n2100.arm.linux.org.uk> <53B154FE.80804@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53B154FE.80804@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 30, 2014 at 02:15:58PM +0200, Sebastian Hesselbarth wrote:
> Can you give a /rough/ schedule for your plans to sort out your private
> branches? If we can all investigate the issue with the same code basis,
> I am sure we can make DT dove behave the same way non-DT dove seems to
> be.

As you will be aware, that is an unreasonable question.  I have no
idea what so ever how long it will take to sort out my private
branches, because it doesn't depend all that much on me.

For example, I've had fully working audio on the Cubox for 18+ months,
but there's a big problem getting it into mainline.  First it was the
lack of co-operation from the ASoC maintainers.  Then it was the ASoC
maintainers accepting Jean-Francois patches (which really torpedoed
my efforts.)  And the final problem which makes it totally impossible
is that pushing the DPCM stuff will completely break the DT based
kirkwood ASoC stuff which got pushed in.

I suspect that the PMU work I did has also been torpedoed because of
no one in the mvebu circles has really thought about how to deal
properly with the overlapping registers for the PMU, hwmon and RTC.

Right now, I have 250 patches in my Cubox tree against a base of
3.15 plus the original set of changes.  And no, I'm *not* going
to be stupid enough to publish the tree because of the non-GPL
license header(s) on various files in the Vivante code base.

I'm actually on the point of just giving up with mainlike on the Cubox
because of this kind of crap, and the extreme difficulty to get any
kind of progress on this stuff - and I'm seeing a growing number of
patches on the Cubox-i side of things, the mainline churn on mach-dove
is becoming a /big/ problem.

So... if you want to remove mach-dove, then I'll just add to my
cubox tree an entire revert of it.  Especially as DT does not work
properly here and non-DT does.

And I really don't buy your "it's down to the timing" explanation -
because (a) switching from 720p to 1080p reprograms the clock chain
right from the Si5351, which is no different to what happens on
initial bring up, and (b) I've measured the HDMI clock which is
derived from this chain and it is correct and unmodulated.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
