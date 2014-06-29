Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:46654 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753376AbaF2Vfk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 29 Jun 2014 17:35:40 -0400
Date: Sun, 29 Jun 2014 22:35:11 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jason Cooper <jason@lakedaemon.net>,
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
Message-ID: <20140629213510.GR32514@n2100.arm.linux.org.uk>
References: <1404075603-31838-1-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404075603-31838-1-git-send-email-andrew@lunn.ch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jun 29, 2014 at 10:59:47PM +0200, Andrew Lunn wrote:
> This patchset removes arch/arm/mach-kirkwood and arch/arm/mach-dove.
> These SoCs are now supported in arch/arm/mach-mvebu using device tree.
> 
> Change the dependencies for a number of drivers, either to use
> ARCH_MVEBU where the drivers are generic, or MACH_KIRKWOOD and
> MACH_DOVE where the drivers are specific to a SoC.
> 
> 
> Andrew Lunn (13):
>   ARM: Kirkwood: Remove mach-kirkwood
>   ARM: Dove: Remove mach-dove

There is actually a cubox regression which has yet to be tracked down.
Running with my kernel (which is not-DT based) runs perfectly.  With
DT, HDMI output can be unstable.

One of the problems is that it's /very/ difficult to reproduce, but it
is reproducable.  I've seen it on two days over many reboots, and I've
proved it by switching back and forth.  DT sometimes suffers from the
problem, whereas non-DT /never/ does.

Sebastian is aware of this, and as yet we haven't found a solution,
nor have we found a way to reliably reproduce it.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
