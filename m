Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v6 0/7] PCI: Change assign unassigned resources per root bus bassis
Date: Thu, 25 Jul 2013 01:12:49 +0200
Message-ID: <1511167.6cyW9CZQyO@vostro.rjw.lan>
In-Reply-To: <CAErSpo6aXm8_GCSHJcceaimODxpkX4syh4Gd15N-THZ97SGF4A@mail.gmail.com>
References: <1374529038-14311-1-git-send-email-yinghai@kernel.org> <CAErSpo6aXm8_GCSHJcceaimODxpkX4syh4Gd15N-THZ97SGF4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, July 24, 2013 04:03:48 PM Bjorn Helgaas wrote:
> [+cc Rafael, linux-acpi]
> 
> On Mon, Jul 22, 2013 at 3:37 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> > BenH reported that there is some assign unassigned resource problem
> > in powerpc.
> >
> > It turns out after
> > | commit 0c5be0cb0edfe3b5c4b62eac68aa2aa15ec681af
> > | Date:   Thu Feb 23 19:23:29 2012 -0800
> > |
> > |    PCI: Retry on IORESOURCE_IO type allocations
> >
> > even the root bus does not have io port range, it will keep retrying
> > to realloc with mmio.
> >
> > After checking the code, found that we bound io port and mmio fail
> > path together.
> > First patch fix the problem, that will not make mmio fall back to must-only
> > when only have io port fail with must+optional.
> 
> Can you point out again which patch actually fixes Ben's problem?  I
> don't see it mentioned in the changelogs, and I'd like to mention it
> there.
> 
> I applied these to my pci/yinghai-assign-unassigned-v6 branch for
> v3.12.  I expect to update these (at least the changelog), so this
> branch will be rebased before being merged to -next.
> 
> Rafael, there are a couple changes to drivers/acpi/pci_root.c and
> drivers/pci/hotplug/acpiphp_glue.c here, and I want to make sure
> you're OK with them before going farther.
> 
> Here's the branch:
> http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/yinghai-assign-unassigned-v6

I'm generally OK with them, as long as doing pci_bus_add_devices(bus) without
pci_enable_bridges() for that bus before is going to work.

Thanks,
Rafael


> > That is first patch.
> >
> > During we found the fix for that problem, found that we can separate assign
> > unassigned resources to per root bus.
> > that will make the code simple, also could reuse it for hotadd path.
> >
> > Besides that, "PCI: Enable pci bridge when it is needed" will delay pci
> > bridge enabling, that will kill another difference between booting path
> > and hotadd path.
> >
> > -v4: split first patch into 4 patches per Bjorn.
> > -v5: drop two patches that will pass root bus resource mask after we found
> >      simple and less intrusive way to fix the problem.
> > -v6: refreshed on top of v3.11-rc2
> >
> > could get from
> >         git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-assign-unassigned
> >
> > Thanks
> >
> > Yinghai
> >
> > Yinghai Lu (7):
> >   PCI: Don't use temp bus for pci_bus_release_bridge_resources
> >   PCI: Use pci_walk_bus to detect unassigned resources
> >   PCI: Check pci bus address for unassigned res
> >   PCI: Introduce enable_local to prepare per root bus handling
> >   PCI: Split pci_assign_unassigned_resources to per root bus
> >   PCI: Enable pci bridge when it is needed
> >   PCI: Retry assign unassigned resources for hotadd root bus
> >
> >  arch/arm/kernel/bios32.c           |   5 --
> >  arch/m68k/platform/coldfire/pci.c  |   1 -
> >  arch/mips/pci/pci.c                |   1 -
> >  arch/sh/drivers/pci/pci.c          |   1 -
> >  drivers/acpi/pci_root.c            |   5 +-
> >  drivers/parisc/lba_pci.c           |   1 -
> >  drivers/pci/bus.c                  |  19 -----
> >  drivers/pci/hotplug/acpiphp_glue.c |   1 -
> >  drivers/pci/pci.c                  |  20 ++++++
> >  drivers/pci/probe.c                |   1 -
> >  drivers/pci/setup-bus.c            | 141 +++++++++++++++++++------------------
> >  drivers/pcmcia/cardbus.c           |   1 -
> >  include/linux/pci.h                |   2 +-
> >  13 files changed, 95 insertions(+), 104 deletions(-)
> >
> > --
> > 1.8.1.4
> >
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
