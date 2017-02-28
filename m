Return-Path: <SRS0=wjC8=2J=gentoo.org=kumba@kernel.org>
Return-Path: <SRS0=wjC8=2J=gentoo.org=kumba@kernel.org>
Subject: Re: [PATCH 12/12] MIPS: PCI: Fix IP27 for the PCI_PROBE_ONLY case
To: Bjorn Helgaas <helgaas@kernel.org>
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
 <20170227163609.GA11162@bhelgaas-glaptop.roam.corp.google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ralf Baechle <ralf@linux-mips.org>,
 James Hogan <james.hogan@imgtec.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Linux/MIPS <linux-mips@linux-mips.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Joshua Kinard <kumba@gentoo.org>
Message-ID: <8caa732f-cbfe-1c91-4b00-be8693c653ed@gentoo.org>
Date: Mon, 27 Feb 2017 19:25:58 -0500
MIME-Version: 1.0
In-Reply-To: <20170227163609.GA11162@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 02/27/2017 11:36, Bjorn Helgaas wrote:
> On Sat, Feb 25, 2017 at 04:34:12AM -0500, Joshua Kinard wrote:
>> On 02/24/2017 13:38, Bjorn Helgaas wrote:
>>> On Fri, Feb 24, 2017 at 03:50:26AM -0500, Joshua Kinard wrote:
> 
>>> The host bridge code, i.e., the pcibios_scanbus() path, tells the
>>> core how big the window is.  In this case, "hose->mem_resource"
>>> contains the CPU physical address range (and size), and
>>> "host->mem_offset" contains the offset between the CPU physical
>>> address and the PCI bus address.  So if "hose->mem_resource" is
>>> only 1GB, that's all the PCI core will use.
>>
>> So basically, this bit of code from the proposed pci-bridge.c needs
>> additional work:
>>
>> 	bc->mem.name = "Bridge MEM";
>> 	bc->mem.start = (NODE_SWIN_BASE(nasid, widget_id) + PCIBR_OFFSET_MEM);
>> 	bc->mem.end = (NODE_SWIN_BASE(nasid, widget_id) + PCIBR_OFFSET_IO - 1);
>> 	bc->mem.flags = IORESOURCE_MEM;
>>
>> 	bc->io.name = "Bridge IO";
>> 	bc->io.start = (NODE_SWIN_BASE(nasid, widget_id) + PCIBR_OFFSET_IO);
>> 	bc->io.end = (NODE_SWIN_BASE(nasid, widget_id) + PCIBR_OFFSET_END - 1);
>> 	bc->io.flags = IORESOURCE_IO;
>>
>> The values I've been using for PCIBR_OFFSET_MEM and PCIBR_OFFSET_IO
>> are obviously wrong.  For IP30, they ultimately direct "BRIDGE MEM"
>> to the first five device slots via small windows, and then "Bridge
>> IO" to the last two slots.  This is one of those "luck" moments that
>> happened to work on BaseIO, but is probably why devices in the
>> secondary PCI shoebox are hit-or-miss.
>>
>> Per your comment further down that I can tell the PCI core about
>> //multiple// windows, probably what I want to do is hardwire access
>> to the small window spaces in the main BRIDGE driver, with
>> machine-specific offsets passed via platform_data.  Small windows,
>> for both IP30 and IP27, are always guaranteed to be available
>> without any additional magic.  This window range can be used to do
>> the initial slot probes to query devices for their desired BAR
>> values.
>>
>> Then, in IP30-specific or IP27-specific code, we add in additional
>> memory windows as needed.  IP30 would simply pass along the
>> hardwired address ranges for BRIDGE MEM or BRIDGE IO via both medium
>> and big window addresses.
>>
>> IP27 is trickier -- we'll need some logic that attempts to use a
>> small window (16MB) mapping first, but if that is too small, we'll
>> have to setup an entry in the HUB's IOTTE buffer that maps a
>> specific block of physical memory to Crosstalk address space.  
> 
> pcibios_scanbus() builds the &resources list of host bridge windows,
> then calls pci_scan_root_bus().  If you're proposing to change the
> list of host bridge windows *after* calling pci_scan_root_bus(), that
> sounds a little problematic because we do not have a PCI core
> interface to do that.

I believe I can determine the size of the windows on BRIDGE before hitting the
generic PCI code.  The bridge_probe() function calls register_pci_controller()
at the very bottom, even in the current mainline file (pci-ip27.c), after it's
twiddled a number of BRIDGE register bits.  I'll first have to try and
understand the 'pre_enable' code from the IP30 patch that changes the window
mappings in ip30-bridge.c, then find a way to move that code to execute earlier
before any of the generic PCI code, since it contains some of the logic to size
out the window mappings.

I'll see about getting it to work on IP30 (Octane) first, because all three
window spaces are available without any special magic.  That way, I'll know
what can be done in the generic BRIDGE driver and what needs to happen in
platform-specific files.  That'll make figuring out the IP27 logic a lot
easier....I hope.


>> This is what IP27 calls "big windows", of which there are seven
>> entries maximum, on 512MB boundaries, per HUB chip.  However, only
>> six entries are available because one IOTTE is used to handle a
>> known hardware bug on early HUB revisions, leaving only six left.
>>
>> As such, the additional window information will go into the
>> machine-specific BRIDGE glue drivers (ip30-bridge.c or
>> ip27-bridge.c).
>>
>> Sound sane?
> 
> Do you need to allocate the big windows based on what PCI devices you
> find?  If so, that is going to be a hard problem.

I believe so.  The IOTTE stuff in the HUB ASIC on IP27 appears to behave like
an extremely simplified TLB, and once you work out how much space a given PCI
device needs, then you can calculate out the matching Crosstalk address, and
you write that to an unused IOTTE slot.  It doesn't have to be accurate -- each
IOTTE entry needs to be aligned on a 512MB boundary, so once you've set up a
mapping, if another PCI device (or BAR?) needs a Crosstalk address within an
already-mapped boundary, you just point it to the existing IOTTE entry that
matches.

That's my understanding anyways after looking at really old IA64 code in 2.5.70
that used virtually the same hardware when SGI was bringing up the Altix
platform.  Specifically, hub_piomap_alloc() on Line 117 in
Linux-2.5.70/arch/ia64/sn/io/io.c:
https://git.linux-mips.org/cgit/ralf/linux.git/tree/arch/ia64/sn/io/io.c?h=linux-2.5.70

So I just need to make sure all of this happens during the initial
bridge_probe() function, so that everything is ready before calling
register_pci_controller().  We'll find out!


>>> PCIe functions have 4K of config space each, so a 0x1000 offset
>>> makes sense.  Whether a platform can access all of it is a
>>> separate question.
>>
>> No need to worry about PCIe on this platform.  You're talking about
>> 15+-year old hardware that was built to last.  I believe SGI only
>> implemented up to PCI 2.1 in the BRIDGE and XBRIDGE ASICs.  It's
>> possible the PIC ASIC might do 2.2 or 3.0.  But I don't have to
>> worry about PIC for a good while, as that's only found in the
>> IP35-class of hardware (Origin 300/350/3000, Fuel, Tezro, Onyx4,
>> etc).  We need fully-working IP27 and IP30 first, because much of
>> the working logic can then be re-purposed for bringing up IP35
>> hardware.  Especially since IA64 did a lot of the work already for
>> the Altix systems, which is just IP35 with an IA64 CPU, but I
>> digress...
> 
> OK.  If you only plug in PCI devices, there should be no problem.  If
> you did plug in PCIe devices (via a PCI-to-PCIe bridge, for example),
> the core should still enumerate them correctly and they should be
> functional, though some PCIe-only features like AER won't work.

There might be physical limitations on using any kind of PCIe bridge device.
Getting a PCI device into an SGI Octane (IP30) or Origin 2000/Onyx2 (IP27) that
isn't either the BaseIO on IP30 or IO6 on IP27 requires an XIO Shoehorn or PCI
Shoebox.  There's a little bit of leeway on how wide of a PCI card you can
stuff into either one, but it's not much.  I'll have to measure a shoehorn if I
can find one of my spares in a bin someplace.  The Origin 200 tower machine
might let you get away with it...but that's a corner case in my book and not
really worth worrying about it.  It's hard to find one of those completely
intact these days, let alone with a working power supply that doesn't double as
a fireworks display.


>>> The type 1 config accessors (pci_conf1_read_config(),
>>> pci_conf1_write_config()) are for devices below a PCI-to-PCI
>>> bridge.  It looks like there's a single 4K memory-mapped window,
>>> and you point it at a specific bus & device with
>>> bridge->b_pci_cfg.
>>
>> Yeah, PCI-to-PCI bridges are a known-broken item right now.  Since
>> there appears to only be a single Type 1 config space, if I have a
>> PCI Shoebox with three PCI-X slots, and I stick three USB 2.0 boards
>> in them, I have to pick which one can handle PCI-to-PCI bridges,
>> like USB hubs, and program that into this Type 1 register, right?
> 
> I don't think USB hubs are relevant here because they are completely
> in the USB domain.  The USB 2.0 board is a USB host controller with a
> PCI interface on it.  The USB hub is on the USB side and is invisible
> to the PCI core.
> 
> The way I read the BSD code, it looks like you should be able to use
> the Type 1 config interface to generate accesses to any PCI bus, as
> long as you serialize them, e.g., with a lock around the use of
> b_type1_cfg.

Huh, well, I've never actually tried a USB Hub device on my Octane.  If I can
fix PCI up properly and get a 2.0 card to actually work, I'll try it out before
looking too deeply into the Type 1 stuff.


>>> The Linux type 0 accessors look like they support 4K config space
>>> per function, while the type 1 accessors put the function number
>>> in bits 8-10, so it looks like they only support 256 bytes per
>>> function.
>>>
>>> The OpenBSD accessors (xbridge_conf_read() and
>>> xbridge_conf_write()) look like they only support 256 bytes per
>>> function regardless of whether it's type 0 or type 1.
>>
>> I'll have to pass this question to the OpenBSD dev who maintains the
>> xbridge driver.  He understands this hardware far better than I do,
>> and there might be a reason why they do it that way.
> 
> If you only support PCI devices, 256 bytes of config space is enough.
> The 4K config space is only supported for PCI-X Mode 2 and PCIe
> devices.  Even those PCI-X Mode 2 and PCIe devices should be
> functional with only 256 bytes.

It's unknown why SGI left that much space between the registers on the BRIDGE.
Could've been future-proofing, or maybe there really is a PCI or PCI-X device
out there that currently only works under IRIX that needed it all.  If I can
get things to work better than they are now, I've got a bit of a collection of
PCI devices to test things out with.  Might expose any wrong assumptions.


>>> Supporting 4K of space for type 0 seems like a potential Linux
>>> problem.  Also, pci_conf1_write_config() uses b_type0_cfg_dev in
>>> one place where it looks like it should be using b_type1_cfg.
> 
> I didn't word this well.  I was trying to point out things that look
> like bugs in pci_conf1_write_config() (the use of b_type0_cfg_dev) and
> maybe pci_conf0_read_config() (the fact that it allows 4K config space
> but the hardware probably only supports 256 bytes).

If you're referring to those uses in ops-bridge.c, that file probably needs
some additional TLC.  The patchset I've got fixed it up a little, but looking
at it made my head hurt (and not just because of the IOC3 voodoo in it), so I
kinda passed on spending too much time on it.  I'll probably have to double
back on it in the future after fixing the other areas, so I'll keep this in mind.


>>> If the hardware only supports 256 bytes of config space on
>>> non-root bus devices, that's not a disaster.  We should still be
>>> able to enumerate them and use all the conventional PCI features
>>> and even basic PCIe features.  But the extended config space
>>> (offsets 0x100-0xfff) would be inaccessible, and we wouldn't see
>>> any PCIe extended capabilities (AER, VC, SR-IOV, etc., see
>>> PCI_EXT_CAP_ID_ERR and subsequent definitions) because they live
>>> in that space.
>>
>> I do not think that the BRIDGE supports AER, VC, or SR-IOV at all,
>> primarily due to age of the hardware.  Even if a PCI device that
>> does support those is plugged into a BRIDGE, I am not 100% certain
>> those features would even be usable if the BRIDGE doesn't know about
>> them.  Or is this a case of where the BRIDGE wouldn't care and once
>> it programs the BARs correctly, these features would be available to
>> the Linux drivers?
> 
> These are mostly PCIe features and I don't think you should worry
> about them, at least for now.

Good to know then.  Hopefully never :)


>> I remember from the OpenBSD xbridge driver, it states that it
>> currently uses the BAR mappings setup by the ARCS firmware, but the
>> plan is to eventually move away from those mappings and calculate
>> its own.  I didn't quite get that, but after reading that site, now
>> I do.  ARCS is writing ~0 to the BARs to query the device to figure
>> out how much memory each BAR wants, then programs in some ranges for
>> us.
>>
>> By tallying up the total requested size of all BAR mappings on a
>> given device, we can then make a determination on whether we can use
>> a small, medium, or large window and then program the BAR with the
>> correct address.  Right?
> 
> This is the problem I alluded to above: Linux does not currently
> support anything like this.  We assume the Linux host bridge driver
> knows the window sizes at the beginning of time (it may learn them
> from firmware or it may have hard-coded knowledge of the address map).
> 
> Linux does enumerate the devices and tally up all the BAR sizes (see
> pci_bus_assign_resources()), but it does not have a way to change the
> host bridge windows based on how much BAR space we need.
> 
> The common thing is to use whatever host bridge windows and device BAR
> values were set up by firmware.  If those are all sensible, Linux
> won't change anything.

Well, as I stated earlier above, it looks like the bridge_probe() function in
the new driver will have to do some probing of its own.  One of the patches I
have in a different series does a minimal probe to read each device slot on
BRIDGE to get the vendor ID and device ID to see if the slot is actually
populated.  This is because not all slots are "populated"; e.g., Octane wires
one of the PCI interrupt pins on slot 6 on BaseIO to its power button, for example.

So the logic used to read the vendor/dev IDs can probably be extended to poke
the BARs via the ~0 trick OR read out the pre-defined mappings from ARCS
firmware, then use that info to size out the BRIDGE windows into Crosstalk
space and then set up our IORESOURCE_MEM and IORESOURCE_IO structs with the
right information to pass into register_pci_controller().

I dunno, I'll probably try reading the ARCS mappings idea first, as that seems
easier.  I won't have a lot of time to play with things in March, so getting
something to work, even if it is sub-optimal, is better than nothing working at
all.


>>> The host bridge windows (the "root bus resource" lines in dmesg)
>>> are only for PIO, i.e., a driver running on the CPU reading or
>>> writing registers on the PCI device (it could be actual registers,
>>> or a frame buffer, etc., but it resides on the device and its PCI
>>> bus address is determined by a BAR).  The driver uses ioremap(),
>>> pci_iomap(), pcim_iomap_regions(), etc. to map these into the
>>> kernel virtual space.
>>
>> So for the MIPS case, knowing that ioremap() and friends is not
>> guaranteed to return a workable virtual address, I need to be
>> careful of what addresses I program into each BAR.  E.g., given that
>> on IP30, if a physical address starts with 0x9000000f800xxxxx, it is
>> using medium windows to talk to a device on the BaseIO BRIDGE (Xtalk
>> widget 0xf).  As such, knowing MIPS' ioremap() returns, for the
>> R10000 CPU case, the requested address OR'ed with IO_BASE
>> (0x9000000000000000), I want to tell the PCI core to use
>> 0x0000000f800xxxxx so that ioremap() will return back
>> 0x9000000f800xxxxx?
> 
> If ioremap() doesn't return a virtual address, or at least something
> that can be used like a virtual address, I think that's fundamentally
> broken.  All drivers assume they should ioremap() a BAR resource,
> i.e., the CPU physical address that maps to a PCI BAR value, and use
> the result as a virtual address.

This is an issue that the core Linux/MIPS people will have to work out.  Ralf
probably knows the precise history on why ioremap*() and related functions
aren't guaranteed to be usable as virtual addresses.  I suspect it's tied to
the other issues with IP27, as that was one of the first MIPS platforms that
Linux ran on in the early 2000's.


>> And since I can apparently specify multiple window ranges for memory
>> space and I/O space, I probably want to, as stated earlier, specify
>> all three of IP30's known window ranges for each BRIDGE so that the
>> Linux PCI core can walk each resource struct and find a matching
>> window?
> 
> If all three windows are disjoint, you can specify them all.  If a
> range in the small window is aliased and can also be reached via a
> medium or large window, you should not specify both.

Each window, at least on Octane, lives at distinct addresses in Crosstalk
space.  A specific address within each window can point to the same device on a
subordinate PCI bus, but I think that will be transparent to the Linux PCI
core.  My thinking is, if I setup IORESOURCE_MEM structs for each window for
each BRIDGE widget, then the PCI code will check each struct to see which one
contains the address range that the PCI device's BAR wants.

E.g., Using widget 0xd as an example for readability, if I know my three
windows in Crosstalk space are:
    Small:  0x0000_1d00_0000 - 0x0000_1dff_ffff
    Medium: 0x000e_8000_0000 - 0x000e_ffff_ffff
    Large:  0x00d0_0000_0000 - 0x00df_ffff_ffff

And for that specific BRIDGE, if I pass those three ranges as IORESOURCE_MEM
structs, then shouldn't the PCI core, if it is told that a specific devices BAR
wants range 1d200000 to 1d203fff, select the small window mapping?  E,g., is it
going to try to find the smallest possible window to fit first?  Or will it
instead try to match using the large window?

I guess I'll find out when I can get some time to actually test the idea out...


[snip]

>>> I think the biggest problem is that you need to set up the BRIDGE
>>> *before* calling pcibios_scan_bus().  That way the windows
>>> ("hose->mem_resource", "hose->io_resource", etc.) will be correct
>>> when the PCI core enumerates the devices.  Note that you can have
>>> as many windows in the "&resources" list as you need -- the
>>> current code there only has one memory and one I/O window, but you
>>> can add more.
>>
>> Agreed, however, I think this is actually being done to some extent
>> already.  We're configuring BRIDGE-specific properties and writing
>> some values to BRIDGE registers and the per-slot registers in
>> bridge_probe() in the generic pci-bridge.c driver, then, at the very
>> end, calling register_pci_controller(), which I believe is what
>> kicks off the PCI bus scan.
>>
>> The IP30 BRIDGE glue code adds a new function hook called
>> "pre_enable" where it does, in ip30-bridge.c, some additional PCI
>> device tweaking, but this code will run after the PCI bus scan has
>> happened.  My guess is that I want to reverse this and have the IP30
>> glue code twiddle the PCI devices on a given BRIDGE before the PCI
>> bus scan, right?  
> 
> Theoretically you should not need to do any PCI device tweaking: PCI
> devices are basically arch-independent and shouldn't need
> arch-specific tweaks.  All the arch stuff should be encapsulated in
> the host bridge driver, i.e., the code that sets up the window list
> and calls pci_scan_root_bus().  In the MIPS case, this code is kind of
> spread out and doesn't really look like a single "driver".

In an ideal world, this would be correct.  However, owning SGI equipment must
have an effect on the curvature of local spacetime, and things seem to operate
a bit differently.  The IOC3 device is a perfect example of this phenomenon.


> The ideal thing would be if you can set up the bridge to always use
> large windows.  Then the PCI core will enumerate the devices and set
> up their resources automatically.

I'll keep this in mind when I can start testing.  I'll initially try feeding
three IORESOURCE_MEM structs to the PCI core to describe the three windows in
order from smallest to largest and see what it does.  Then try reversing the
order and see if it still finds the right window or not.  And whether that
actually leads to correct probing of the PCI devices or not.


> I assume the small/medium windows exist because there's not enough
> address space to always use the large windows.  I don't have any good
> suggestions for that -- we don't have support for adjusting the window
> sizes based on what devices we find.

IMHO, "Use a bigger hammer" seems most appropriate when it comes to this hardware.


>> That code uses pci_read_config_dword() and
>> pci_write_config_dword() -- are these functions safe to use if we
>> haven't already done a PCI bus scan?
> 
> You can't use pci_read_config_dword() before we scan the bus because
> it requires a "struct pci_dev *", and those are created during the bus
> scan.

Okay, that's good to know then.  There's other accessors that are MIPS-specific
that I think I can use.  I don't think I specifically need a 'struct pci_dev *'
at that point anyways.


-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
