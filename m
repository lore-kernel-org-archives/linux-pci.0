Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:39465 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753256AbaF3Rsj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 30 Jun 2014 13:48:39 -0400
Date: Mon, 30 Jun 2014 19:43:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
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
Message-ID: <20140630174351.GI18520@lunn.ch>
References: <1404075603-31838-1-git-send-email-andrew@lunn.ch>
 <20140629213510.GR32514@n2100.arm.linux.org.uk>
 <53B154FE.80804@gmail.com>
 <20140630124320.GZ32514@n2100.arm.linux.org.uk>
 <53B164B2.7090902@gmail.com>
 <20140630142516.GA32514@n2100.arm.linux.org.uk>
 <53B183D5.8020708@gmail.com>
 <20140630165615.GE32514@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140630165615.GE32514@n2100.arm.linux.org.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> > If you are talking about "Kirkwood ASoC updates", you got a Tested-by
> > from Andrew even before I read your patches. And besides, just because
> > I am interested in Dove does not mean I just swallowed the whole Linux
> > API knowledge. I simply avoided commenting on it, because there is
> > /nothing/ I can add to it.
> 
> No I am not - and those are the patches which I referred to as having
> been already taken by Mark into his tree.  The patch I'm referring to
> which can never be merged now is the one which I replied to Jean
> Francois just now - and if you read through it, you'll understand
> why - that's because it /totally/ breaks the simple DT bindings that
> are now established - independently - for Kirkwood stuff.

Hi Russell

Are you referring to http://www.spinics.net/lists/arm-kernel/msg328068.html

    Andrew

