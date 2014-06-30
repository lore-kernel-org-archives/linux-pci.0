Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:46603 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754630AbaF3MQG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jun 2014 08:16:06 -0400
Message-ID: <53B154FE.80804@gmail.com>
Date: Mon, 30 Jun 2014 14:15:58 +0200
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>
CC: Jason Cooper <jason@lakedaemon.net>,
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
References: <1404075603-31838-1-git-send-email-andrew@lunn.ch> <20140629213510.GR32514@n2100.arm.linux.org.uk>
In-Reply-To: <20140629213510.GR32514@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/29/2014 11:35 PM, Russell King - ARM Linux wrote:
> On Sun, Jun 29, 2014 at 10:59:47PM +0200, Andrew Lunn wrote:
>> This patchset removes arch/arm/mach-kirkwood and arch/arm/mach-dove.
>> These SoCs are now supported in arch/arm/mach-mvebu using device tree.
>>
>> Change the dependencies for a number of drivers, either to use
>> ARCH_MVEBU where the drivers are generic, or MACH_KIRKWOOD and
>> MACH_DOVE where the drivers are specific to a SoC.
>>
>>
>> Andrew Lunn (13):
>>    ARM: Kirkwood: Remove mach-kirkwood
>>    ARM: Dove: Remove mach-dove
>
> There is actually a cubox regression which has yet to be tracked down.
> Running with my kernel (which is not-DT based) runs perfectly.  With
> DT, HDMI output can be unstable.
>
> One of the problems is that it's /very/ difficult to reproduce, but it
> is reproducable.  I've seen it on two days over many reboots, and I've
> proved it by switching back and forth.  DT sometimes suffers from the
> problem, whereas non-DT /never/ does.
>
> Sebastian is aware of this, and as yet we haven't found a solution,
> nor have we found a way to reliably reproduce it.

I am aware of the issue but have not been able to reproduce it. Also,
we have no /official/ non-DT CuBox support in mainline Linux at all.
I understand that removing non-DT mach-dove currently is not your
most preferred patch but from a mainline POV, mach-dove isn't actively
used. The three officially supported boards have been converted to DT
months ago and haven't received any TLC since then, so I doubt they are
used by anyone.

My current impression of the issue is that it is more related with
driver load order/missing delays for clocks/ignoring IP behavior on
clock rate change or something like it.

Can you give a /rough/ schedule for your plans to sort out your private
branches? If we can all investigate the issue with the same code basis,
I am sure we can make DT dove behave the same way non-DT dove seems to
be.

Sebastian

