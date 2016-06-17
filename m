Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:41992 "EHLO
	mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038AbcFQODk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jun 2016 10:03:40 -0400
Date: Fri, 17 Jun 2016 16:07:38 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
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
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 02/10] driver core: Functional dependencies tracking
 support
Message-ID: <20160617140738.GA1809@wunner.de>
References: <1466144820-6286-1-git-send-email-m.szyprowski@samsung.com>
 <1466144820-6286-3-git-send-email-m.szyprowski@samsung.com>
 <20160617103620.GA1626@wunner.de>
 <CAJZ5v0h71xxvzex2D6s9W8Qvq3+BqOQnTJRKy32gMu=tuQLxDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJZ5v0h71xxvzex2D6s9W8Qvq3+BqOQnTJRKy32gMu=tuQLxDA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 17, 2016 at 02:54:56PM +0200, Rafael J. Wysocki wrote:
> On Fri, Jun 17, 2016 at 12:36 PM, Lukas Wunner <lukas@wunner.de> wrote:
> > On Fri, Jun 17, 2016 at 08:26:52AM +0200, Marek Szyprowski wrote:
> > > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > We also have such a functional dependency for Thunderbolt on Macs:
> > On resume from system sleep, the PCIe hotplug ports may not resume
> > before the thunderbolt driver has reestablished the PCI tunnels.
> > Currently this is enforced by quirk_apple_wait_for_thunderbolt()
> > in drivers/pci/quirks.c. It would be good if we could represent
> > this dependency using something like Rafael's approach instead of
> > open coding it, however one detail in Rafael's patches is problematic:
> >
> > > New links are added by calling device_link_add() which may happen
> > > either before the consumer device is probed or when probing it, in
> > > which case the caller needs to ensure that the driver of the
> > > supplier device is present and functional and the DEVICE_LINK_PROBE_TIME
> > > flag should be passed to device_link_add() to reflect that.
> >
> > The thunderbolt driver cannot call device_link_add() before the
> > PCIe hotplug ports are bound to a driver unless we amend portdrv
> > to return -EPROBE_DEFER for Thunderbolt hotplug ports on Macs
> > if the thunderbolt driver isn't loaded.
> >
> > It would therefore be beneficial if device_link_add() can be
> > called even *after* the consumer is bound.
> 
> I don't quite follow.
> 
> Who's the provider and who's the consumer here?

thunderbolt.ko is the supplier. The PCIe hotplug ports of Thunderbolt
host controllers are the consumers.

If thunderbolt.ko is not loaded, no special precautions are needed for
the hotplug ports.

However *if* it is loaded and the system is suspended and there are
Thunderbolt devices plugged in, then on resume the hotplug ports must
wait for thunderbolt.ko to reestablish the PCI tunnels. If they do not
wait, things will go south because when pci_pm_resume_noirq() is called
for the devices *below* the hotplug port, we will try to put them into D0
(via pci_pm_default_resume_early()) and call pci_restore_state() even
though those hotplugged devices are not yet reachable.

So what I'd like to do is call device_link_add() when thunderbolt.ko
is loaded to shove a dependency onto the hotplug ports. But the hotplug
ports will long since have been bound at that point (to portdrv).
So it should be allowed to call device_link_add() ex post facto, after
the consumer has been bound.

Let me know if I still failed to convey the problem in an intelligible
way.

I had a similar problem with the Runtime PM for Thunderbolt series
(which BTW is still awaiting reviews):
http://www.spinics.net/lists/linux-pci/msg51158.html

The PM core allows calls to dev_pm_domain_set() only during ->probe or
if the device is unbound. Same constraint as with device_link_add().
This constraint was a major obstacle for me and I had to jump through
numerous additional hoops to work around it:

Thunderbolt controllers on Macs can be put into D3cold, but not with
standard ACPI methods, so platform_pci_power_manageable() is false for
these devices. Now this nothing unusual, the same applies to dual GPU
laptops (custom ACPI DSMs for Nvidia Optimus and AMD PowerXpress).

For such discrete GPUs, a struct dev_pm_domain is set during ->probe
(drivers/gpu/vga/vga_switcheroo.c: vga_switcheroo_init_domain_pm_ops()).
But I can't do that for Thunderbolt because the device in question is
a PCIe upstream port. Ideally I would shove a dev_pm_domain on the
upstream port when thunderbolt.ko loads, but again at that point
the port has long since been bound (to portdrv) so I can't call
dev_pm_domain_set().

The workaround I settled on is to attach to the upstream port as a
service driver, call down to the service driver's ->runtime_suspend
hooks when the port runtime suspends and power the controller down.
In addition, I had to make sure that saved_state isn't clobbered on
resume (patch [09/13]).

It would be good if someone who has a bird's eye view of the PM core
(i.e., you) could make a decision
(1) if it's possible and worthwhile to allow dev_pm_domain_set() for
    already bound devices, and
(2) if the PCI core should be be able to deal with devices which are
    runtime suspended to D3cold but not by the platform (because that's
    what patch [09/13] does).

If the answer to (2) is yes then there's some more stuff to fix:
Discrete GPUs on dual GPU laptops can be manually suspended to D3cold
behind the PM core's back by loading nouveau / radeon / amdgpu with
runpm=0 and writing OFF to the vga_switcheroo debugfs interface.
This is currently broken in conjunction with system sleep (the GPU
is no longer accessible after resume) because pci_pm_resume_noirq()
calls pci_restore_state() even though the device is in D3cold and not
power-manageable by the platform.

Thanks,

Lukas
