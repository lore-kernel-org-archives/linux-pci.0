Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:39504 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753256AbaF3SVX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 30 Jun 2014 14:21:23 -0400
Date: Mon, 30 Jun 2014 20:16:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
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
Message-ID: <20140630181640.GL18520@lunn.ch>
References: <1404075603-31838-1-git-send-email-andrew@lunn.ch>
 <20140629213510.GR32514@n2100.arm.linux.org.uk>
 <53B154FE.80804@gmail.com>
 <20140630124320.GZ32514@n2100.arm.linux.org.uk>
 <53B164B2.7090902@gmail.com>
 <20140630142516.GA32514@n2100.arm.linux.org.uk>
 <53B183D5.8020708@gmail.com>
 <20140630165615.GE32514@n2100.arm.linux.org.uk>
 <20140630174351.GI18520@lunn.ch>
 <20140630180853.GF32514@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140630180853.GF32514@n2100.arm.linux.org.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> So, what do we do now with support for compressed audio streams via
> SPDIF on kirkwood hardware?  As far as I can see, it's no longer
> possible and mainline kernels will never support this.  Please tell
> me I'm wrong...

Well, it would of been nice if you had made a comment to either v1 or
v2 of my patchset saying this is going to cause problems for some
devices.

So i will go look at your patch to add frontend and backend and see
what it means for the current DT binding. The nice thing about
kirkwood (and Dove) is, there is no uboot with DT support. Hence
nobody is flashing there DT blob. They are always using appended DT.
So i'm not against changing the binding. And it has only been in the
kernel for one cycle, so i doubt there are too many users at the
moment.

	Andrew



