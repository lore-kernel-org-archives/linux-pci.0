Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750971AbdB0RBN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Feb 2017 12:01:13 -0500
Date: Mon, 27 Feb 2017 10:36:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joshua Kinard <kumba@gentoo.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Linux/MIPS <linux-mips@linux-mips.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 12/12] MIPS: PCI: Fix IP27 for the PCI_PROBE_ONLY case
Message-ID: <20170227163609.GA11162@bhelgaas-glaptop.roam.corp.google.com>
References: <CAErSpo6yKAE1_c1eZJapnjD1g0pocyOxed3_Eumdp_026uhDuA@mail.gmail.com>
 <eafc94c6-1931-e2ce-7e03-d84d8e181e81@gentoo.org>
 <CAErSpo4LsrPCtdZwp6CyT0jKhXLt3j=fGSiFjpRRTPUjFoKHtQ@mail.gmail.com>
 <c7ed6a1d-f625-d294-8910-dd2d93d34292@gentoo.org>
 <20170213224512.GA8080@bhelgaas-glaptop.roam.corp.google.com>
 <8ec2a0bf-6bd7-1366-38bc-7f7ba9a29971@gentoo.org>
 <20170214145628.GA10418@bhelgaas-glaptop.roam.corp.google.com>
 <926cfb3a-085f-164b-4ec3-76dc9db3298b@gentoo.org>
 <20170224183803.GB15547@bhelgaas-glaptop.roam.corp.google.com>
 <eefac3de-c857-4bc9-72cb-dec4d2b3a756@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <eefac3de-c857-4bc9-72cb-dec4d2b3a756@gentoo.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Feb 25, 2017 at 04:34:12AM -0500, Joshua Kinard wrote:
> On 02/24/2017 13:38, Bjorn Helgaas wrote:
> > On Fri, Feb 24, 2017 at 03:50:26AM -0500, Joshua Kinard wrote:

> > The host bridge code, i.e., the pcibios_scanbus() path, tells the
> > core how big the window is.  In this case, "hose->mem_resource"
> > contains the CPU physical address range (and size), and
> > "host->mem_offset" contains the offset between the CPU physical
> > address and the PCI bus address.  So if "hose->mem_resource" is
> > only 1GB, that's all the PCI core will use.
> 
> So basically, this bit of code from the proposed pci-bridge.c needs
> additional work:
> 
> 	bc->mem.name = "Bridge MEM";
> 	bc->mem.start = (NODE_SWIN_BASE(nasid, widget_id) + PCIBR_OFFSET_MEM);
> 	bc->mem.end = (NODE_SWIN_BASE(nasid, widget_id) + PCIBR_OFFSET_IO - 1);
> 	bc->mem.flags = IORESOURCE_MEM;
> 
> 	bc->io.name = "Bridge IO";
> 	bc->io.start = (NODE_SWIN_BASE(nasid, widget_id) + PCIBR_OFFSET_IO);
> 	bc->io.end = (NODE_SWIN_BASE(nasid, widget_id) + PCIBR_OFFSET_END - 1);
> 	bc->io.flags = IORESOURCE_IO;
> 
> The values I've been using for PCIBR_OFFSET_MEM and PCIBR_OFFSET_IO
> are obviously wrong.  For IP30, they ultimately direct "BRIDGE MEM"
> to the first five device slots via small windows, and then "Bridge
> IO" to the last two slots.  This is one of those "luck" moments that
> happened to work on BaseIO, but is probably why devices in the
> secondary PCI shoebox are hit-or-miss.
> 
> Per your comment further down that I can tell the PCI core about
> //multiple// windows, probably what I want to do is hardwire access
> to the small window spaces in the main BRIDGE driver, with
> machine-specific offsets passed via platform_data.  Small windows,
> for both IP30 and IP27, are always guaranteed to be available
> without any additional magic.  This window range can be used to do
> the initial slot probes to query devices for their desired BAR
> values.
> 
> Then, in IP30-specific or IP27-specific code, we add in additional
> memory windows as needed.  IP30 would simply pass along the
> hardwired address ranges for BRIDGE MEM or BRIDGE IO via both medium
> and big window addresses.
> 
> IP27 is trickier -- we'll need some logic that attempts to use a
> small window (16MB) mapping first, but if that is too small, we'll
> have to setup an entry in the HUB's IOTTE buffer that maps a
> specific block of physical memory to Crosstalk address space.  

pcibios_scanbus() builds the &resources list of host bridge windows,
then calls pci_scan_root_bus().  If you're proposing to change the
list of host bridge windows *after* calling pci_scan_root_bus(), that
sounds a little problematic because we do not have a PCI core
interface to do that.

> This is what IP27 calls "big windows", of which there are seven
> entries maximum, on 512MB boundaries, per HUB chip.  However, only
> six entries are available because one IOTTE is used to handle a
> known hardware bug on early HUB revisions, leaving only six left.
> 
> As such, the additional window information will go into the
> machine-specific BRIDGE glue drivers (ip30-bridge.c or
> ip27-bridge.c).
> 
> Sound sane?

Do you need to allocate the big windows based on what PCI devices you
find?  If so, that is going to be a hard problem.

> > PCIe functions have 4K of config space each, so a 0x1000 offset
> > makes sense.  Whether a platform can access all of it is a
> > separate question.
> 
> No need to worry about PCIe on this platform.  You're talking about
> 15+-year old hardware that was built to last.  I believe SGI only
> implemented up to PCI 2.1 in the BRIDGE and XBRIDGE ASICs.  It's
> possible the PIC ASIC might do 2.2 or 3.0.  But I don't have to
> worry about PIC for a good while, as that's only found in the
> IP35-class of hardware (Origin 300/350/3000, Fuel, Tezro, Onyx4,
> etc).  We need fully-working IP27 and IP30 first, because much of
> the working logic can then be re-purposed for bringing up IP35
> hardware.  Especially since IA64 did a lot of the work already for
> the Altix systems, which is just IP35 with an IA64 CPU, but I
> digress...

OK.  If you only plug in PCI devices, there should be no problem.  If
you did plug in PCIe devices (via a PCI-to-PCIe bridge, for example),
the core should still enumerate them correctly and they should be
functional, though some PCIe-only features like AER won't work.

> > The type 1 config accessors (pci_conf1_read_config(),
> > pci_conf1_write_config()) are for devices below a PCI-to-PCI
> > bridge.  It looks like there's a single 4K memory-mapped window,
> > and you point it at a specific bus & device with
> > bridge->b_pci_cfg.
> 
> Yeah, PCI-to-PCI bridges are a known-broken item right now.  Since
> there appears to only be a single Type 1 config space, if I have a
> PCI Shoebox with three PCI-X slots, and I stick three USB 2.0 boards
> in them, I have to pick which one can handle PCI-to-PCI bridges,
> like USB hubs, and program that into this Type 1 register, right?

I don't think USB hubs are relevant here because they are completely
in the USB domain.  The USB 2.0 board is a USB host controller with a
PCI interface on it.  The USB hub is on the USB side and is invisible
to the PCI core.

The way I read the BSD code, it looks like you should be able to use
the Type 1 config interface to generate accesses to any PCI bus, as
long as you serialize them, e.g., with a lock around the use of
b_type1_cfg.

> > The Linux type 0 accessors look like they support 4K config space
> > per function, while the type 1 accessors put the function number
> > in bits 8-10, so it looks like they only support 256 bytes per
> > function.
> > 
> > The OpenBSD accessors (xbridge_conf_read() and
> > xbridge_conf_write()) look like they only support 256 bytes per
> > function regardless of whether it's type 0 or type 1.
> 
> I'll have to pass this question to the OpenBSD dev who maintains the
> xbridge driver.  He understands this hardware far better than I do,
> and there might be a reason why they do it that way.

If you only support PCI devices, 256 bytes of config space is enough.
The 4K config space is only supported for PCI-X Mode 2 and PCIe
devices.  Even those PCI-X Mode 2 and PCIe devices should be
functional with only 256 bytes.

> > Supporting 4K of space for type 0 seems like a potential Linux
> > problem.  Also, pci_conf1_write_config() uses b_type0_cfg_dev in
> > one place where it looks like it should be using b_type1_cfg.

I didn't word this well.  I was trying to point out things that look
like bugs in pci_conf1_write_config() (the use of b_type0_cfg_dev) and
maybe pci_conf0_read_config() (the fact that it allows 4K config space
but the hardware probably only supports 256 bytes).

> > If the hardware only supports 256 bytes of config space on
> > non-root bus devices, that's not a disaster.  We should still be
> > able to enumerate them and use all the conventional PCI features
> > and even basic PCIe features.  But the extended config space
> > (offsets 0x100-0xfff) would be inaccessible, and we wouldn't see
> > any PCIe extended capabilities (AER, VC, SR-IOV, etc., see
> > PCI_EXT_CAP_ID_ERR and subsequent definitions) because they live
> > in that space.
> 
> I do not think that the BRIDGE supports AER, VC, or SR-IOV at all,
> primarily due to age of the hardware.  Even if a PCI device that
> does support those is plugged into a BRIDGE, I am not 100% certain
> those features would even be usable if the BRIDGE doesn't know about
> them.  Or is this a case of where the BRIDGE wouldn't care and once
> it programs the BARs correctly, these features would be available to
> the Linux drivers?

These are mostly PCIe features and I don't think you should worry
about them, at least for now.

> I remember from the OpenBSD xbridge driver, it states that it
> currently uses the BAR mappings setup by the ARCS firmware, but the
> plan is to eventually move away from those mappings and calculate
> its own.  I didn't quite get that, but after reading that site, now
> I do.  ARCS is writing ~0 to the BARs to query the device to figure
> out how much memory each BAR wants, then programs in some ranges for
> us.
> 
> By tallying up the total requested size of all BAR mappings on a
> given device, we can then make a determination on whether we can use
> a small, medium, or large window and then program the BAR with the
> correct address.  Right?

This is the problem I alluded to above: Linux does not currently
support anything like this.  We assume the Linux host bridge driver
knows the window sizes at the beginning of time (it may learn them
from firmware or it may have hard-coded knowledge of the address map).

Linux does enumerate the devices and tally up all the BAR sizes (see
pci_bus_assign_resources()), but it does not have a way to change the
host bridge windows based on how much BAR space we need.

The common thing is to use whatever host bridge windows and device BAR
values were set up by firmware.  If those are all sensible, Linux
won't change anything.

> > The host bridge windows (the "root bus resource" lines in dmesg)
> > are only for PIO, i.e., a driver running on the CPU reading or
> > writing registers on the PCI device (it could be actual registers,
> > or a frame buffer, etc., but it resides on the device and its PCI
> > bus address is determined by a BAR).  The driver uses ioremap(),
> > pci_iomap(), pcim_iomap_regions(), etc. to map these into the
> > kernel virtual space.
> 
> So for the MIPS case, knowing that ioremap() and friends is not
> guaranteed to return a workable virtual address, I need to be
> careful of what addresses I program into each BAR.  E.g., given that
> on IP30, if a physical address starts with 0x9000000f800xxxxx, it is
> using medium windows to talk to a device on the BaseIO BRIDGE (Xtalk
> widget 0xf).  As such, knowing MIPS' ioremap() returns, for the
> R10000 CPU case, the requested address OR'ed with IO_BASE
> (0x9000000000000000), I want to tell the PCI core to use
> 0x0000000f800xxxxx so that ioremap() will return back
> 0x9000000f800xxxxx?

If ioremap() doesn't return a virtual address, or at least something
that can be used like a virtual address, I think that's fundamentally
broken.  All drivers assume they should ioremap() a BAR resource,
i.e., the CPU physical address that maps to a PCI BAR value, and use
the result as a virtual address.

Documentation/DMA-API-HOWTO.txt has a picture that may help clarify
the different address spaces.

> And since I can apparently specify multiple window ranges for memory
> space and I/O space, I probably want to, as stated earlier, specify
> all three of IP30's known window ranges for each BRIDGE so that the
> Linux PCI core can walk each resource struct and find a matching
> window?

If all three windows are disjoint, you can specify them all.  If a
range in the small window is aliased and can also be reached via a
medium or large window, you should not specify both.

> > DMA is coming the other direction and the windows are irrelevant
> > except that the target PCI bus address must be outside all the
> > windows (if the DMA target address were *inside* a host bridge
> > window, the bridge would assume it is intended for a PCI device,
> > e.g., for peer-to-peer DMA).
> 
> DMA is the tricky one.  OpenBSD's xbridge driver implies that
> BRIDGE's IOMMU has a bug of some kind in it that restricts our
> DMA-able address ranges to 31 bits, or 0x00000000 to 0x7fffffff.
> IP27 doesn't seem to be bothered by this in the current code, and as
> such, I can use all 8GB of RAM on that platform.
> 
> But IP30 has its physical memory offset 512MB, so physical memory
> maps begin at 0x20000000 and run to 0x9fffffff.  This means someone
> playing with Linux on an IP30 platform can only install up to 2GB of
> RAM right now, if they want the machine to be stable.  Though, there
> are other issues going on that imply that "stable" is a very
> subjective term...
> 
> In either event, how do I teach the Linux PCI core that the BRIDGE
> itself is limited to 31bits of DMA-able address space?  There seems
> to be plenty of documentation on having an individual PCI device set
> this up by setting its DMA mask, but I can't seem to find any
> wording on how to do this for an entire PCI bus.
> 
> Or is this an architecture-specific thing?  MIPS has the
> dma-coherence.h header for defining system-specific DMA quirks, but
> that code seems heavily biased towards PCI devices, and on IP30 at
> least, the Impact and Odyssey video cards are NOT PCI devices at
> all, instead being native XIO devices that support DMA operations.

The PCI core isn't involved much with DMA, so I don't know this off
the top of my head.

> > I think the biggest problem is that you need to set up the BRIDGE
> > *before* calling pcibios_scan_bus().  That way the windows
> > ("hose->mem_resource", "hose->io_resource", etc.) will be correct
> > when the PCI core enumerates the devices.  Note that you can have
> > as many windows in the "&resources" list as you need -- the
> > current code there only has one memory and one I/O window, but you
> > can add more.
> 
> Agreed, however, I think this is actually being done to some extent
> already.  We're configuring BRIDGE-specific properties and writing
> some values to BRIDGE registers and the per-slot registers in
> bridge_probe() in the generic pci-bridge.c driver, then, at the very
> end, calling register_pci_controller(), which I believe is what
> kicks off the PCI bus scan.
> 
> The IP30 BRIDGE glue code adds a new function hook called
> "pre_enable" where it does, in ip30-bridge.c, some additional PCI
> device tweaking, but this code will run after the PCI bus scan has
> happened.  My guess is that I want to reverse this and have the IP30
> glue code twiddle the PCI devices on a given BRIDGE before the PCI
> bus scan, right?  

Theoretically you should not need to do any PCI device tweaking: PCI
devices are basically arch-independent and shouldn't need
arch-specific tweaks.  All the arch stuff should be encapsulated in
the host bridge driver, i.e., the code that sets up the window list
and calls pci_scan_root_bus().  In the MIPS case, this code is kind of
spread out and doesn't really look like a single "driver".

The ideal thing would be if you can set up the bridge to always use
large windows.  Then the PCI core will enumerate the devices and set
up their resources automatically.

I assume the small/medium windows exist because there's not enough
address space to always use the large windows.  I don't have any good
suggestions for that -- we don't have support for adjusting the window
sizes based on what devices we find.

> That code uses pci_read_config_dword() and
> pci_write_config_dword() -- are these functions safe to use if we
> haven't already done a PCI bus scan?

You can't use pci_read_config_dword() before we scan the bus because
it requires a "struct pci_dev *", and those are created during the bus
scan.

Bjorn
