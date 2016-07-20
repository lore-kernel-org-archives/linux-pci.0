Return-Path: <lukas@wunner.de>
Return-Path: <lukas@wunner.de>
Date: Wed, 20 Jul 2016 08:59:19 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 03/13] PCI: Add Thunderbolt portdrv service type
Message-ID: <20160720065919.GB8066@wunner.de>
References: <cover.1463134231.git.lukas@wunner.de>
 <3e694101e5fa1551e07b5ecf92157087922e952f.1463134231.git.lukas@wunner.de>
 <20160617225152.GD12254@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160617225152.GD12254@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 17, 2016 at 05:51:52PM -0500, Bjorn Helgaas wrote:
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

The assessment above is entirely correct, I'm sort of abusing the
portdrv infrastructure as a way to bind to the upstream bridge.

For comparison, Optimus GPUs are also suspended to D3cold with a
non-standard method (i.e., not by the ACPI platform). The way we
handle that is to assign a dev_pm_domain to the device using
dev_pm_domain_set(). You can just think of "dev_pm_domain" as a
fancy name for overriding the callbacks in pci_dev_pm_ops:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/vga/vga_switcheroo.c#n1014

I cannot use that method with Thunderbolt because dev_pm_domain_set()
can only be called for unbound devices. And the upstream bridge will
already have been bound (to portdrv) when thunderbolt.ko loads.

I'm waiting for Rafael to weigh in if the dev_pm_domain_set() method
is the right thing to do for devices which are suspended to D3cold
in a non-standard way, and whether the "device not bound" restriction
on dev_pm_domain_set() can be lifted. If so, I could rework this
series to use that instead of binding to portdrv.


> upstream.c does a lot of ACPI stuff; I can't tell whether it has more
> affinity with ACPI or with PCI.  I don't see any PNP IDs though, so I
> guess you just look for the magic method names in the ACPI device
> associated with some PCI device.  That seems a little bit "back-door"
> to me; from an ASL point of view, I would think you'd want to start
> from a _HID and interpret the device based on that.

Apple's ACPI methods to power the controller up/down are located
below the NHI device in the namespace. I just use the ACPI_HANDLE()
macro to get from the NHI's PCI device to its ACPI companion's
handle, then find the methods below that. This avoids the need to
search the namespace for a _HID or _ADR:
https://github.com/l1k/linux/commit/65f56e6c8446#diff-66575f0946b607aa866a23518687f8b1R281

Best regards,

Lukas
