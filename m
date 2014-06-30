Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp1-g21.free.fr ([212.27.42.1]:64891 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752497AbaF3HPQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jun 2014 03:15:16 -0400
Date: Mon, 30 Jun 2014 09:16:43 +0200
From: Jean-Francois Moine <moinejf@free.fr>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
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
Message-ID: <20140630091643.2df3b0fb@armhf>
In-Reply-To: <20140629213510.GR32514@n2100.arm.linux.org.uk>
References: <1404075603-31838-1-git-send-email-andrew@lunn.ch>
	<20140629213510.GR32514@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 29 Jun 2014 22:35:11 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> There is actually a cubox regression which has yet to be tracked down.
> Running with my kernel (which is not-DT based) runs perfectly.  With
> DT, HDMI output can be unstable.

Russell,

What is this HDMI problem with DT?

I am running a DT based kernel on my Cubox for more than 1 year and the
only problem I have is a random black screen at startup time, and this
black screen problem also exists with the old non-DT kernels from
SolidRun.

-- 
Ken ar c'hentañ	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
