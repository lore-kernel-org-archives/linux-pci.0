Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:55621 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbaEILwp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 May 2014 07:52:45 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 00/22] Random ARM randconfig fixes in drivers
Date: Fri, 9 May 2014 13:48:49 +0200
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, dwmw2@infradead.org,
	dmitry.torokhov@gmail.com, balbi@ti.com,
	gregkh@linuxfoundation.org, plagnioj@jcrosoft.com,
	jic23@kernel.org, josh.wu@atmel.com, kishon@ti.com,
	linus.walleij@linaro.org, broonie@kernel.org,
	mturquette@linaro.org, nicolas.ferre@atmel.com, ohad@wizery.com,
	linux@arm.linux.org.uk, tony@atomide.com, vinod.koul@intel.com,
	wim@iguana.be, wsa@the-dreams.de, dmaengine@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-watchdog@vger.kernel.org, netdev@vger.kernel.org
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de> <20140508164157.GA22224@roeck-us.net>
In-Reply-To: <20140508164157.GA22224@roeck-us.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201405091348.49713.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 08 May 2014, Guenter Roeck wrote:
> On Thu, May 08, 2014 at 04:46:51PM +0200, Arnd Bergmann wrote:
> > These are a bunch of fixes I had to do to get all randconfig
> > configurations on ARM working. Most of these are really old
> > bugs, but there are also some new ones. I don't think any of
> > them require a backport to linux-stable.
> > 
> > I have checked that they are all still required on yesterday's
> > linux-next kernel. Please apply on the appropriate trees unless
> > there are objections.
> > 
> Is this series of patches also going to fix arm:allmodconfig ?

Possibly, I haven't checked in a while. I'm unfortunately sitting on
about 200 other patches in the same branch, which together fix all
build errors in any configuration I encountered.

I should really do some allmodconfig/allnoconfig/allyesconfig
builds without my series again, and prioritize sending out the
ones required for that.

	Arnd
