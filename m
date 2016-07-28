Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:50075 "EHLO
	mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755830AbcG1P2O (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jul 2016 11:28:14 -0400
Date: Thu, 28 Jul 2016 17:28:31 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
	linux-samsung-soc@vger.kernel.org,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Joerg Roedel <joro@8bytes.org>,
	Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 02/10] driver core: Functional dependencies tracking
 support
Message-ID: <20160728152831.GA1929@wunner.de>
References: <1466144820-6286-1-git-send-email-m.szyprowski@samsung.com>
 <4258432.JNKr9zJtMp@vostro.rjw.lan>
 <20160724224832.GB9516@wunner.de>
 <2841548.NIYVpJFBcH@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2841548.NIYVpJFBcH@vostro.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 28, 2016 at 02:30:31AM +0200, Rafael J. Wysocki wrote:
> On Monday, July 25, 2016 12:48:32 AM Lukas Wunner wrote:
> > On Thu, Jul 21, 2016 at 02:25:15AM +0200, Rafael J. Wysocki wrote:
> > > On Thursday, July 21, 2016 01:25:53 AM Lukas Wunner wrote:
> > > > I guess I could amend portdrv to return -EPROBE_DEFER on Macs if
> > > > no driver is bound to the NHI. Doesn't feel pretty to me though.
> > > > 
> > > > Ultimately this seems to be the same issue as with calling
> > > > dev_pm_domain_set() for a bound device. Perhaps device_link_add()
> > > > can likewise be allowed if a runtime PM ref is held for the devices
> > > > and the call happens under lock_system_sleep()?
> > > 
> > > No, the whole synchronization scheme in the links code would have had to be
> > > changed for that to really work.
> > > 
> > > And it really is about what is needed (at least in principle) to run your
> > > device.  If you think you need device X with a driver to handle device Y
> > > correctly, then either you need it all the time, from probe to remove, or
> > > you just don't really need it at all.
> > 
> > Real life isn't as simple as that.
> > 
> > In this case, we have consumers (hotplug ports) which are doing fine
> > if the driver for the supplier (NHI) is not loaded. But once it loads,
> > the links must be in place.
> 
> Hmm.
> 
> What if it is not loaded and the system suspends.  Will everything work
> as expected after the subsequent resume?

The short answer is yes.

Long answer:

With Thunderbolt, the switch fabric is told to set up PCI tunnels
through the NHI (Native Host Interface). Once set up, the tunnels
stay as they are and attached devices are reachable. However after
a power cycle of the controller (suspend/resume), the tunnels are
gone and need to be re-established.

On Macs, there are two software components communicating with the
NHI: The first one is an EFI driver which sets up tunnels to all
devices present on boot and lights up all attached DP-over-Thunderbolt
displays. Once ExitBootServices is called, the EFI driver is shut
down but the configured tunnels stay as they are. The kernel is thus
able to enumerate attached PCI devices.

The second component is the OS driver, thunderbolt.ko. It is needed
to set up tunnels to hot-plugged devices (i.e., not present at boot).
It is also needed to re-establish tunnels after suspend/resume.

The necessity of quirk_apple_wait_for_thunderbolt() arises because
we walk the entire PCI hierarchy during ->resume_noirq and call
pci_power_up() and pci_restore_state() for each device. Now remember,
the PCI tunnels are gone after a power cycle, so the attached devices
aren't reachable. Waking them and restoring their state will fail
unless the thunderbolt driver reconfigures the switch fabric first.

=> So if there are no devices attached and thunderbolt.ko isn't loaded,
   everything is fine. No device link needed.

=> If devices are attached and thunderbolt.ko is loaded, then the hotplug
   ports need to wait for re-establishment of the PCI tunnels.
   Device link is needed.

=> If devices were attached on boot and thunderbolt.ko isn't loaded, they
   will be unreachable after resume. Nothing we can do about that.
   No device link needed.

So this is a case of a "weak" device link, "weak" referring to the fact
that it's only needed if the supplier is bound.

All that said, I don't know if this case exists often enough that it's
worth making allowances for it in the driver core.

Sorry for the wall of text, just want to make sure we're on the same page
and all possible use cases of device links are discussed and considered.

Thanks,

Lukas
