Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:46995 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753437AbaF3KBN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jun 2014 06:01:13 -0400
Date: Mon, 30 Jun 2014 11:00:49 +0100
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
Message-ID: <20140630100048.GU32514@n2100.arm.linux.org.uk>
References: <1404075603-31838-1-git-send-email-andrew@lunn.ch> <20140629213510.GR32514@n2100.arm.linux.org.uk> <20140630091643.2df3b0fb@armhf> <20140630084918.GS32514@n2100.arm.linux.org.uk> <20140630114701.1368d49e@armhf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140630114701.1368d49e@armhf>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 30, 2014 at 11:47:01AM +0200, Jean-Francois Moine wrote:
> Have you declared the LCD clock in dove.dtsi?
> 
>  	lcdclk: fixed-clock {
> 		compatible = "fixed-clock";
>  		#clock-cells = <0>;
>  		clock-frequency = <400000000>;
>  	};

And what difference would that make - this would not be used.

The clock used for the LCD controller somes from the Si5351.  The internal
clocks are not used as they are unsuitable for generating the resolutions
we require.  The other clocks used by the LCD controller (AXI clock and
PLL clock) are both fundamental clocks in the SoC, neither are 400MHz.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
