Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:63780 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753322AbaGHMNV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jul 2014 08:13:21 -0400
Date: Tue, 8 Jul 2014 08:13:01 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	rmk+kernel@arm.linux.org.uk, Mark Brown <broonie@kernel.org>,
	alsa-devel@alsa-project.org,
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
Message-ID: <20140708121301.GU23978@titan.lakedaemon.net>
References: <1404075603-31838-1-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404075603-31838-1-git-send-email-andrew@lunn.ch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Andrew,

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
>   sound: ASoC: kirkwood: Remove unused drivers
>   sound: ASoC: kirkwood: Remove ARCH_KIRKWOOD and ARCH_DOVE dependency
>   cpuidle: kirkwood: Replace ARCH_KIRKWOOD dependency
>   ata: Remove ARCH_KIRKWOOD and ARCH_DOVE dependency
>   thermal: Replace ARCH_KIRKWOOD and ARCH_DOVE dependency
>   leds: Replace ARCH_KIRKWOOD dependency
>   PCI: Remove ARCH_KIRKWOOD and ARCH_DOVE dependency
>   phy: Replace ARCH_KIRKWOOD and ARCH_DOVE dependency
>   rtc: Remove ARCH_KIRKWOOD and ARCH_DOVE dependency
>   watchdog: Remove ARCH_KIRKWOOD and ARCH_DOVE dependency
>   Remove ARCH_DOVE dependency

Let's just do mach-kirkwood/ removal this time around and we'll
re-address mach-dove next window.

thx,

Jason.
