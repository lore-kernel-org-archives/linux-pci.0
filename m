Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43197 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751343AbcCKX3Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 11 Mar 2016 18:29:25 -0500
Date: Fri, 11 Mar 2016 17:29:20 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Tony Luck <tony.luck@intel.com>,
	DRI <dri-devel@lists.freedesktop.org>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>,
	Daniel Stone <daniel@fooishbar.org>,
	Alex Deucher <alexdeucher@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?=
	<ville.syrjala@linux.intel.com>
Subject: Re: [PATCH v1 00/12] PCI: Rework shadow ROM handling
Message-ID: <20160311232920.GA27552@localhost>
References: <20160303164533.3025.82439.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160308174558.GC19869@localhost>
 <CALCETrUHEmFoO9dYY0xbjLiLfCJQCxG7h60dkOuCMMOKonytpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CALCETrUHEmFoO9dYY0xbjLiLfCJQCxG7h60dkOuCMMOKonytpw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 11, 2016 at 01:16:09PM -0800, Andy Lutomirski wrote:
> On Tue, Mar 8, 2016 at 9:45 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Thu, Mar 03, 2016 at 10:53:50AM -0600, Bjorn Helgaas wrote:
> >> The purpose of this series is to:
> >>
> >>   - Fix the "BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment"
> >>     messages reported by Linus [1], Andy [2], and others.
> >>
> >>   - Move arch-specific shadow ROM location knowledge, e.g.,
> >>     0xC0000-0xDFFFF, from PCI core to arch code.
> >>
> >>   - Fix the ia64 and MIPS Loongson 3 oddity of keeping virtual
> >>     addresses in shadow ROM struct resource (resources should always
> >>     contain *physical* addresses).
> >>
> >>   - Remove now-unused IORESOURCE_ROM_COPY and IORESOURCE_ROM_BIOS_COPY
> >>     flags.
> >>
> >> This series is based on v4.5-rc1, and it's available on my
> >> pci/resource git branch (along with a couple tiny unrelated patches)
> >> at [3].
> >>
> >> Bjorn
> >>
> >>
> >> [1] http://lkml.kernel.org/r/CA+55aFyVMfTBB0oz_yx8+eQOEJnzGtCsYSj9QuhEpdZ9BHdq5A@mail.gmail.com
> >> [2] http://lkml.kernel.org/r/CALCETrV+RwNPzxyL8UVNsrAGu-6cCzD_Cc9PFJT2NCTJPLZZiw@mail.gmail.com
> >> [3] https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/resource
> >>
> >>
> >> ---
> >>
> >> Bjorn Helgaas (12):
> >>       PCI: Mark shadow copy of VGA ROM as IORESOURCE_PCI_FIXED
> >>       PCI: Don't assign or reassign immutable resources
> >>       PCI: Don't enable/disable ROM BAR if we're using a RAM shadow copy
> >>       PCI: Set ROM shadow location in arch code, not in PCI core
> >>       PCI: Clean up pci_map_rom() whitespace
> >>       ia64/PCI: Use temporary struct resource * to avoid repetition
> >>       ia64/PCI: Use ioremap() instead of open-coded equivalent
> >>       ia64/PCI: Keep CPU physical (not virtual) addresses in shadow ROM resource
> >>       MIPS: Loongson 3: Use temporary struct resource * to avoid repetition
> >>       MIPS: Loongson 3: Keep CPU physical (not virtual) addresses in shadow ROM resource
> >>       PCI: Remove unused IORESOURCE_ROM_COPY and IORESOURCE_ROM_BIOS_COPY
> >>       PCI: Simplify sysfs ROM cleanup
> >>
> >>
> >>  arch/ia64/pci/fixup.c              |   21 +++++++--
> >>  arch/ia64/sn/kernel/io_acpi_init.c |   22 ++++++----
> >>  arch/ia64/sn/kernel/io_init.c      |   51 ++++++++--------------
> >>  arch/mips/pci/fixup-loongson3.c    |   19 +++++---
> >>  arch/x86/pci/fixup.c               |   21 +++++++--
> >>  drivers/pci/pci-sysfs.c            |   13 +-----
> >>  drivers/pci/remove.c               |    1
> >>  drivers/pci/rom.c                  |   83 +++++++++++-------------------------
> >>  drivers/pci/setup-res.c            |    6 +++
> >>  include/linux/ioport.h             |    4 --
> >>  10 files changed, 111 insertions(+), 130 deletions(-)
> >
> > I applied this series to pci/resource for v4.6.
> 
> This gets rid of all the warnings for me until I try to read my i915
> device's rom using sysfs.  Then I get:
> 
> i915 0000:00:02.0: Invalid PCI ROM header signature: expecting 0xaa55,
> got 0xffff
> 
> So I suspect that something is still subtly wrong -- I'd imagine that
> this should either work or the intialization code should detect that
> there is no usable ROM and not expose it.
> 
> (To be clear, there's no regression here.)

Hmmm.  Thanks for testing this.  As you say, I think this is the way
it's always been, but it does seem non-intuitive.

That "Invalid PCI ROM header signature" warning comes from
pci_get_rom_size().  We don't call that at enumeration-time; we only
call it later when somebody tries to read the ROM via sysfs:

  pci_bus_add_device
    pci_fixup_device(pci_fixup_final)
      pci_fixup_video                 # final fixup
	res->flags = MEM | SHADOW | PCI_FIXED
    pci_create_sysfs_dev_files
      if (SHADOW)
	rom_size = 0x20000            # oops, I should have fixed this too
      if (rom_size)
	attr->read = pci_read_rom
	sysfs_create_bin_file         # sysfs "rom" file
	
  pci_read_rom                        # sysfs "rom" read function
    pci_map_rom
      ioremap
      pci_get_rom_size
	dev_err("Invalid PCI ROM header signature")
    memcpy_fromio
    pci_unmap_rom

I think this is the same for regular ROMs on the device as it is for
the magic VGA shadow ROM.  In both cases, we create the sysfs "rom"
file regardless of what the ROM contains.

I guess we could try to read the ROM at enumeration time and look for
a valid signature.  I've considered doing that anyway so we could
cache the ROM contents and avoid permanently allocating MMIO space for
it, since many BIOSes don't allocate space, and Linux isn't really smart
enough to do a good job of it itself.

I don't know why the PCI core cares about the ROM signature anyway,
since it doesn't use the content.  Maybe we should get rid of
pci_get_rom_size() and allow you to read whatever is there, like
we do for other BARs.  I suppose there's some history behind limiting
the size, but I don't know what it is.

Bjorn
