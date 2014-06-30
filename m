Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:46895 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754950AbaF3Itr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jun 2014 04:49:47 -0400
Date: Mon, 30 Jun 2014 09:49:18 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Andrew Lunn <andrew@lunn.ch>, linux-ide@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	alsa-devel@alsa-project.org, Bryan Wu <cooloney@gmail.com>,
	Jason Cooper <jason@lakedaemon.net>,
	rtc-linux@googlegroups.com, linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Tejun Heo <tj@kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
	Mark Brown <broonie@kernel.org>,
	Richard Purdie <rpurdie@rpsys.net>, linux-pci@vger.kernel.org,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-leds@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH 00/13] Remove mach-kirkwood and mach-dove
Message-ID: <20140630084918.GS32514@n2100.arm.linux.org.uk>
References: <1404075603-31838-1-git-send-email-andrew@lunn.ch> <20140629213510.GR32514@n2100.arm.linux.org.uk> <20140630091643.2df3b0fb@armhf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140630091643.2df3b0fb@armhf>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 30, 2014 at 09:16:43AM +0200, Jean-Francois Moine wrote:
> On Sun, 29 Jun 2014 22:35:11 +0100
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> > There is actually a cubox regression which has yet to be tracked down.
> > Running with my kernel (which is not-DT based) runs perfectly.  With
> > DT, HDMI output can be unstable.
> 
> Russell,
> 
> What is this HDMI problem with DT?
> 
> I am running a DT based kernel on my Cubox for more than 1 year and the
> only problem I have is a random black screen at startup time, and this
> black screen problem also exists with the old non-DT kernels from
> SolidRun.

The problem is that the picture appears for about a second, then goes black
for maybe a couple of seconds, then reappears for about a second and this
cycle repeats.  Rebooting into the DT kernel doesn't fix it.  Rebooting
back into the non-DT kernel does fix it.  Then if you boot back into the DT
kernel it's back again.  Boot back into the non-DT kernel and it's again
fixed.

I have compared register settings for the Si5351, LCD controllers and the
TDA998x between the non-DT and DT versions, and can find no differences
there.  Yet, DT kernels are the only kernels which exhibit this behaviour.
Non-DT kernels (which I've run continuously including many reboots) for
the last two years have *never* shown this problem.

I have also verified that the HDMI clock is correct.  The problem occurs
at both 1080p and 720p resolutions (which are the two that are used during
boot - I have the kernel using 720p, and Xorg uses 1080p.)

I should also point out that in both cases, it is the _same_ kernel binary
(3.15) that I'm running - the DT test case just has the DT blob attached
whereas the non-DT case boots without (and therefore falls back to the
old platform stuff.)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
