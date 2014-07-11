Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:38835 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377AbaGKOwH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Jul 2014 10:52:07 -0400
Date: Fri, 11 Jul 2014 10:52:03 -0400
From: Tejun Heo <tj@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jason Cooper <jason@lakedaemon.net>,
	linux ARM <linux-arm-kernel@lists.infradead.org>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>,
	Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
	linux-ide@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
	Bryan Wu <cooloney@gmail.com>,
	Richard Purdie <rpurdie@rpsys.net>, linux-leds@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com, Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 00/12] Remove mach-kirkwood
Message-ID: <20140711145203.GD27706@htj.dyndns.org>
References: <1405028192-9623-1-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405028192-9623-1-git-send-email-andrew@lunn.ch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 10, 2014 at 11:36:20PM +0200, Andrew Lunn wrote:
> This patchset removes arch/arm/mach-kirkwood.  This SoCs is now
> supported in arch/arm/mach-mvebu using device tree.
> 
> V1 of this patchset also removed mach-dove. However it has been
> decided to leave it alone for a while to aid some developers get out
> of tree patches merged.
>                                                                          
> Change the dependencies for a number of drivers, either to use
> ARCH_MVEBU where the drivers are generic, or MACH_KIRKWOOD and where
> the drivers are specific to the SoC.
> 
> Once Jason Cooper has Acked these patches, we would prefer that
> individual subsystem maintainers take these patches through their own
> trees.

Please let me know when I can take the libata part.

Thanks.

-- 
tejun
