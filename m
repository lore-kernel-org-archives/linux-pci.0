Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 14 Jun 2016 11:37:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andreas Noever <andreas.noever@gmail.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Huang Ying <ying.huang@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/13] Runtime PM for Thunderbolt on Macs
Message-ID: <20160614163703.GA31488@localhost>
References: <cover.1463134231.git.lukas@wunner.de>
 <CAMxnaaU_3z6BSmSnYfi4ee=aTKm3aPyUaXds=G29wdp8O0m5Cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMxnaaU_3z6BSmSnYfi4ee=aTKm3aPyUaXds=G29wdp8O0m5Cw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-kernel]

On Sat, May 21, 2016 at 11:48:42AM +0200, Andreas Noever wrote:
> 
> Signed-off-by: Andreas Noever <andreas.noever@gmail.com>
>
> Tested on MacBookPro10,1
> 
> On Fri, May 13, 2016 at 1:15 PM, Lukas Wunner <lukas@wunner.de> wrote:
> > This series powers Thunderbolt controllers on Macs down when nothing is
> > plugged in, saving 1.7 W on machines with a Light Ridge controller and
> > reportedly 4 W on Cactus Ridge 4C and Falcon Ridge 4C.
> >
> > Briefly, a custom ACPI method provided by Apple is used to cut power to
> > the controller.  A GPE is enabled while the controller is powered down
> > which side-band signals a plug event, whereupon power is reinstated using
> > the ACPI method.  Note that even though this mechanism is ACPI-based,
> > it does not use _PSx methods and is thus entirely nonstandard.

I think the current arrangement was that Andreas would ack Thunderbolt
patches and I would merge them via the PCI tree.  That makes some sense
because Thunderbolt and PCIe are related, but the more I think about
it, the less I'm happy with it.

This series is a good example.  I'm sure it's good work and
worthwhile.  But I can't really say anything about the content of it
because most of it is Thunderbolt-specific and there's no public spec.
It seems like this is basically a collection of reverse-engineered
quirks that happen to work with the current state of Linux PM on
certain Macs.  We don't know what might change on future Macs.  We
don't know what might break when we make changes to Linux PM.

I can't test this series, nor do I want to.  I can't test most of the
patches I merge, but I can at least read the spec and see whether the
patches make sense.  What I would *like* is to have public Thunderbolt
specs and a kernel developer's guide so we know what to expect from
the hardware and the firmware and we can write code that should work
not just on current Macs, but also on non-Macs and future Macs.

I don't think the current situation is really maintainable, and I'm
not comfortable merging code that I can't maintain.

I know I don't understand the whole situation, so somebody please tell
me why I'm being unreasonable here.

> > A Thunderbolt controller appears to the OS as a set of PCI devices:  One
> > NHI (Native Host Interface) and multiple bridges.  Power is cut to the
> > entire set of devices:
> >
> >   (Root Port) ---- Upstream Bridge --+-- Downstream Bridge 0 ---- NHI
> >                                      +-- Downstream Bridge 1 --
> >                                      +-- Downstream Bridge 2 --
> >                                      ...
> >
> > v1 of this series shoehorned power control into the NHI driver.  This
> > violated the Linux pm model which assumes that a child cannot resume
> > before its parent. As seen above, the NHI is a child, so the child cut
> > power to the bridges above it.
> >
> > v2 resolves this by positioning power control on the controller's
> > topmost device, which is the upstream bridge.  That is achieved by
> > binding to it as a Thunderbolt port service driver.  portdrv already
> > calls down to each service driver on ->suspend and ->resume and I
> > extended that scheme to further PM callbacks.  E.g. when the upstream
> > bridge is runtime suspended, portdrv invokes the ->runtime_suspend
> > callback of each attached service driver, and the Thunderbolt service
> > driver's callback in turn invokes the ACPI method to cut power to the
> > controller.
> >
> >
> > For such a nonstandard ACPI-based PM mechanism one would normally assign
> > a dev_pm_domain to the upstream bridge which overrides the PCI subsystem
> > PM callbacks.  But that's not an option here because dev_pm_domain_set()
> > can only be called during driver probe.  The driver is portdrv and
> > obviously loads earlier than the thunderbolt port service driver.
> > So one has to make do with the PCI subsystem PM callbacks.
> >
> > The PCI core currently assumes that devices can only be put into D3cold
> > by the platform, i.e. using the standard ACPI _PSx methods.  I extended
> > the PCI core so that it can deal with devices which are put into D3cold
> > by the driver callbacks.  It turns out only two changes are needed to
> > make this work, and they are in patches [09/13] and [10/13].  Runtime
> > suspend works out of the box, but runtime resume tries to set the device
> > power state *before* invoking the driver callback, and this goes awry
> > since the device is still in D3cold.  I solved this by returning an error
> > in pci_raw_set_power_state() if the device's current_state is D3cold
> > (patch [09/13]).
> >
> > Theoretically it would also be possible to patch the missing _PSx methods
> > into the ACPI namespace at runtime but I suspect it wouldn't be pretty:
> > I think I'd have to include pre-compiled AML methods in the kernel and
> > modify those blobs at runtime (adjust GPE number etc) before patching
> > them into the namespace.
> >
> >
> > To make direct-complete work for such non-platform-power-managed devices,
> > I also had to modify pci_target_state() (patch [10/13]).
> >
> > Finally, I wanted to avoid the mandatory runtime resume after direct-
> > complete which was introduced by Rafael with 58a1fbbb2ee8 ("PM / PCI /
> > ACPI: Kick devices that might have been reset by firmware"), so I added
> > the possibility to opt out of it (patch [11/13]).
> >
> >
> > I've pushed these patches to GitHub where they can be reviewed more
> > comfortably with green/red highlighting:
> > https://github.com/l1k/linux/commits/thunderbolt_runpm_v2
> >
> > For reference, here's a link to v1:
> > http://thread.gmane.org/gmane.linux.power-management.general/73197
> >
> > Thanks in advance for your comments.
> >
> > Lukas
> >
> >
> > Lukas Wunner (13):
> >   PCI: Recognize Thunderbolt devices
> >   PCI: Allow D3 for Thunderbolt ports
> >   PCI: Add Thunderbolt portdrv service type
> >   PCI: Generalize portdrv pm iterator
> >   PCI: Use portdrv pm iterator on further callbacks
> >   PCI: pciehp: Support runtime pm
> >   PCI: pciehp: Ignore interrupts during D3cold
> >   PCI: Allow runtime PM for Thunderbolt hotplug ports on Macs
> >   PCI: Do not write to PM control register while in D3cold
> >   PCI: Avoid going from D3cold to D3hot for system sleep
> >   PM / sleep: Allow opt-out from runtime resume after direct-complete
> >   thunderbolt: Support runtime pm on upstream bridge
> >   thunderbolt: Support runtime pm on NHI
> >
> >  drivers/base/power/generic_ops.c  |   3 +-
> >  drivers/pci/hotplug/pciehp_ctrl.c |   9 +-
> >  drivers/pci/hotplug/pciehp_hpc.c  |   4 +
> >  drivers/pci/pci.c                 |  50 ++----
> >  drivers/pci/pci.h                 |   2 +
> >  drivers/pci/pcie/portdrv.h        |   6 +-
> >  drivers/pci/pcie/portdrv_core.c   |  47 +-----
> >  drivers/pci/pcie/portdrv_pci.c    |  88 ++++++++--
> >  drivers/pci/probe.c               |  17 ++
> >  drivers/thunderbolt/Kconfig       |   4 +-
> >  drivers/thunderbolt/Makefile      |   4 +-
> >  drivers/thunderbolt/nhi.c         |  32 +++-
> >  drivers/thunderbolt/switch.c      |   9 +
> >  drivers/thunderbolt/tb.c          |  13 ++
> >  drivers/thunderbolt/upstream.c    | 345 ++++++++++++++++++++++++++++++++++++++
> >  include/linux/pci.h               |   1 +
> >  include/linux/pcieport_if.h       |   7 +
> >  include/linux/pm.h                |   1 +
> >  18 files changed, 539 insertions(+), 103 deletions(-)
> >  create mode 100644 drivers/thunderbolt/upstream.c
> >
> > --
> > 2.8.1
> >
