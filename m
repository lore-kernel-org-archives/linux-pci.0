Return-Path: <rjw@rjwysocki.net>
Return-Path: <rjw@rjwysocki.net>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH v2 03/13] PCI: Add Thunderbolt portdrv service type
Date: Wed, 20 Jul 2016 02:30:14 +0200
Message-ID: <1492431.vTkZItZy2q@vostro.rjw.lan>
In-Reply-To: <20160617225152.GD12254@localhost>
References: <cover.1463134231.git.lukas@wunner.de> <3e694101e5fa1551e07b5ecf92157087922e952f.1463134231.git.lukas@wunner.de> <20160617225152.GD12254@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-pci.vger.kernel.org>

On Friday, June 17, 2016 05:51:52 PM Bjorn Helgaas wrote:
> On Fri, May 13, 2016 at 01:15:31PM +0200, Lukas Wunner wrote:
> > A Thunderbolt controller is a PCIe switch which, as defined in the PCIe
> > spec, appears to the OS "as a collection of virtual PCI-to-PCI bridges".
> > 
> > We're about to add support for Apple's nonstandard ACPI methods to power
> > Thunderbolt controllers up and down.  To facilitate that, allocate a
> > port service for every PCI bridge belonging to a Thunderbolt controller.
> > 
> > This port service might come in handy for other use cases, e.g. device
> > initialization of Thunderbolt controllers.
> > 
> > To understand when and how this port service will be allocated, consider
> > the PCI devices exposed by a Thunderbolt host controller:
> > 
> >   (Root Port) ---- Upstream Bridge --+-- Downstream Bridge 0 ---- NHI
> >                                      +-- Downstream Bridge 1 --
> >                                      +-- Downstream Bridge 2 --
> >                                      ...
> > 
> > The upstream and downstream bridges represent the PCIe switch and a
> > Thunderbolt port service will be allocated for each of them.  Hotplugged
> > devices will appear behind the downstream bridges.  The NHI (Native Host
> > Interface) is a virtual PCI device to manage the switch fabric and is
> > not relevant here.  It uses class 0x88000, so it is not a PCIe port.
> > 
> > Next, consider the PCI devices exposed by Thunderbolt controllers built
> > into hotplugged devices:
> > 
> >   -- Upstream Bridge ---- Downstream Bridge ---- Hotplugged device
> > 
> > Again, Thunderbolt port services will be allocated for the upstream and
> > downstream bridge, but not for the hotplugged device, which might use
> > e.g. class 0x20000 if it's a Thunderbolt Ethernet adapter.
> 
> I don't really *like* the portdrv infrastructure, even though we're
> sort of stuck with it now.  It seems like all it really does is allow
> multiple sub-drivers to attach to a single device and share interrupts
> between them.  And we get some extra devices in sysfs that don't fit
> the regular PCI model.  We used to support loadable sub-drivers
> (pciehp, aer, etc.), but we decided that didn't really make sense
> (though I notice you do support thunderbolt as a module).
> 
> I think we would be better off if the PCIe services (hotplug, AER,
> etc.) were directly integrated into the PCI core without the portdrv
> abstraction in the middle.  But anyway, we do have portdrv, and the
> only question here is whether extending it for Thunderbolt is the
> right thing.
> 
> So the question for Thunderbolt is what benefit you get from being a
> portdrv sub-driver.  It seems like basically a way for you to hook on
> to PCI bridges that happen to be Thunderbolt controllers.  I don't
> think you really use any portdrv services (other than forwarding the
> PM ops down to you, which a regular PCI device driver would get for
> free).

Moreover, this approach creates sort of a priority inversion between
the Thunderbolt driver and the ports, because the driver, which really
is a superior entity (as it corresponds to the switch as a whole) is
caused to bind to children of the ports (ie. PCIe service devices).

That leads to ordering issues in probe and then suspend/resume etc.

> upstream.c does a lot of ACPI stuff; I can't tell whether it has more
> affinity with ACPI or with PCI.  I don't see any PNP IDs though, so I
> guess you just look for the magic method names in the ACPI device
> associated with some PCI device.  That seems a little bit "back-door"
> to me; from an ASL point of view, I would think you'd want to start
> from a _HID and interpret the device based on that.

Or from _ADR if the device object in question maps to a PCI device.

Thanks,
Rafael
