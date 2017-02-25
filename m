Return-Path: <SRS0=gNPP=2G=gentoo.org=kumba@kernel.org>
Return-Path: <SRS0=gNPP=2G=gentoo.org=kumba@kernel.org>
Subject: Re: [PATCH 12/12] MIPS: PCI: Fix IP27 for the PCI_PROBE_ONLY case
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20170207061356.8270-1-kumba@gentoo.org>
 <20170207061356.8270-13-kumba@gentoo.org>
 <CAErSpo6yKAE1_c1eZJapnjD1g0pocyOxed3_Eumdp_026uhDuA@mail.gmail.com>
 <eafc94c6-1931-e2ce-7e03-d84d8e181e81@gentoo.org>
 <CAErSpo4LsrPCtdZwp6CyT0jKhXLt3j=fGSiFjpRRTPUjFoKHtQ@mail.gmail.com>
 <c7ed6a1d-f625-d294-8910-dd2d93d34292@gentoo.org>
 <20170213224512.GA8080@bhelgaas-glaptop.roam.corp.google.com>
 <8ec2a0bf-6bd7-1366-38bc-7f7ba9a29971@gentoo.org>
 <20170214145628.GA10418@bhelgaas-glaptop.roam.corp.google.com>
 <926cfb3a-085f-164b-4ec3-76dc9db3298b@gentoo.org>
 <20170224183803.GB15547@bhelgaas-glaptop.roam.corp.google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ralf Baechle <ralf@linux-mips.org>,
 James Hogan <james.hogan@imgtec.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Linux/MIPS <linux-mips@linux-mips.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Joshua Kinard <kumba@gentoo.org>
Message-ID: <eefac3de-c857-4bc9-72cb-dec4d2b3a756@gentoo.org>
Date: Sat, 25 Feb 2017 04:34:12 -0500
MIME-Version: 1.0
In-Reply-To: <20170224183803.GB15547@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 02/24/2017 13:38, Bjorn Helgaas wrote:
> On Fri, Feb 24, 2017 at 03:50:26AM -0500, Joshua Kinard wrote:
>> Quoting from the BRIDGE docs somewhat, from the point of view of generic
>> Crosstalk space and not specific to IP30 or IP27, there are several views into
>> PCI space.  Each address is 48-bits, the size of a Crosstalk address.
>>
>>     0000_0000_0000 to 0000_00ff_ffff is "Widget space".  It seems the BRIDGE
>>     docs use the term "widget" here to refer to the eight possible PCI devices
>>     addressable by a single BRIDGE ASIC.  This plus the small windows is how
>>     the code is currently getting things to work.  I think.
>>
>>     0000_4000_0000 to 0000_7fff_ffff is BRIDGE's view into PCI Memory Space
>>     for direct-mapped 32-bit devices.  It is 1GB in size.  My take is this is
>>     normally a 4GB space?  Can the Linux PCI core be taught that only 1GB
>>     is usable?
> 
> Bridges normally have a window that contains some 32-bit PCI memory
> space, because many PCI devices have 32-bit BARs that have to be
> located below 4GB.
> 
> This window is usually smaller than 4GB (1GB would be typical) because
> these devices likely can only generate 32-bit DMA as well, and the DMA
> has to use 32-bit PCI addresses that are outside the host bridge
> window.

Okay, this fits then.  I wasn't sure, because the verbiage in the BRIDGE docs
kinda-suggests that the 1GB window for 32/64-bit memory space isn't common.
Likely, what they're getting at is the fact the lower 1GB for 32-bit is aliased
in the next 1GB for use by 64-bit PCI devices.  It looks like the remaining 2GB
in memory space is available for DMA, and I'll have to try and wrap my head
around that at later date.


> The host bridge code, i.e., the pcibios_scanbus() path, tells the core
> how big the window is.  In this case, "hose->mem_resource" contains
> the CPU physical address range (and size), and "host->mem_offset"
> contains the offset between the CPU physical address and the PCI bus
> address.  So if "hose->mem_resource" is only 1GB, that's all the PCI
> core will use.

So basically, this bit of code from the proposed pci-bridge.c needs additional
work:

	bc->mem.name = "Bridge MEM";
	bc->mem.start = (NODE_SWIN_BASE(nasid, widget_id) + PCIBR_OFFSET_MEM);
	bc->mem.end = (NODE_SWIN_BASE(nasid, widget_id) + PCIBR_OFFSET_IO - 1);
	bc->mem.flags = IORESOURCE_MEM;

	bc->io.name = "Bridge IO";
	bc->io.start = (NODE_SWIN_BASE(nasid, widget_id) + PCIBR_OFFSET_IO);
	bc->io.end = (NODE_SWIN_BASE(nasid, widget_id) + PCIBR_OFFSET_END - 1);
	bc->io.flags = IORESOURCE_IO;

The values I've been using for PCIBR_OFFSET_MEM and PCIBR_OFFSET_IO are
obviously wrong.  For IP30, they ultimately direct "BRIDGE MEM" to the first
five device slots via small windows, and then "Bridge IO" to the last two
slots.  This is one of those "luck" moments that happened to work on BaseIO,
but is probably why devices in the secondary PCI shoebox are hit-or-miss.

Per your comment further down that I can tell the PCI core about //multiple//
windows, probably what I want to do is hardwire access to the small window
spaces in the main BRIDGE driver, with machine-specific offsets passed via
platform_data.  Small windows, for both IP30 and IP27, are always guaranteed to
be available without any additional magic.  This window range can be used to do
the initial slot probes to query devices for their desired BAR values.

Then, in IP30-specific or IP27-specific code, we add in additional memory
windows as needed.  IP30 would simply pass along the hardwired address ranges
for BRIDGE MEM or BRIDGE IO via both medium and big window addresses.

IP27 is trickier -- we'll need some logic that attempts to use a small window
(16MB) mapping first, but if that is too small, we'll have to setup an entry in
the HUB's IOTTE buffer that maps a specific block of physical memory to
Crosstalk address space.  This is what IP27 calls "big windows", of which there
are seven entries maximum, on 512MB boundaries, per HUB chip.  However, only
six entries are available because one IOTTE is used to handle a known hardware
bug on early HUB revisions, leaving only six left.

As such, the additional window information will go into the machine-specific
BRIDGE glue drivers (ip30-bridge.c or ip27-bridge.c).

Sound sane?


>>     0000_8000_0000 to 0000_bfff_ffff is an alias view by BRIDGE into PCI
>>     Memory space for 64-bit PCI devices, immediately after the 32-bit space.
>>     It is also 1GB in size.
>>
>>     0000_c000_0000 to 0000_ffff_ffff is 2GB adjacent to PCI Memory space, but
>>     is either unused or used for Crosstalk/BRIDGE DMA operations
>>     (the docs aren't very clear on this point or I am simply not
>>     understanding).
>>
>>     0001_0000_0000 to 0001_ffff_ffff is BRIDGE's view into PCI I/O Space.
>>     It has the entire 4GB range available to use.
>>
>>
>> I suspect the existing BRIDGE driver is mapping through "widget space" first to
>> probe the PCI device slots, then the ip30-bridge.c code is re-writing the PCI
>> BARs to go through the big window on IP30, but it never updates the original
>> BRIDGE setup (if that's even possible).  As such, as you pointed out, there's
>> some kind of logic in the generic PCI core that's re-assigning space from the
>> window and we're just getting lucky and everything still works.
>>
>> I dug up some old debugging code given to me by the original author of the IP30
>> port and built up a set of macros that get me to the PCI Configuration Space on
>> Widget 0xf (BaseIO Bridge), Device #0 (the first QLA1040B SCSI controller).
>> All three addresses access the same PCI device and return the same config space
>> info.
>>
>>     Small window:  0x900000001f02xxxx
>>     Medium window: 0x9000000f8002xxxx
>>     Big window:    0x900000f00002xxxx
>>
>>
>> Each additional device's configuration space is offset 0x1000, which gives me
>> the following addresses (dev's 4 to 7 are special-cased for IRQ trickery, so
>> can't probe them):
>>
>>     - Dev #0: scsi0/qla1040b: 0x90xxxxxxxxx20000
>>     - Dev #1: scsi1/qla1040b: 0x90xxxxxxxxx21000
>>     - Dev #2: io/ioc3       : 0x90xxxxxxxxx22000
>>     - Dev #3: audio/rad1    : 0x90xxxxxxxxx23000
> 
> PCIe functions have 4K of config space each, so a 0x1000 offset makes
> sense.  Whether a platform can access all of it is a separate
> question.

No need to worry about PCIe on this platform.  You're talking about 15+-year
old hardware that was built to last.  I believe SGI only implemented up to PCI
2.1 in the BRIDGE and XBRIDGE ASICs.  It's possible the PIC ASIC might do 2.2
or 3.0.  But I don't have to worry about PIC for a good while, as that's only
found in the IP35-class of hardware (Origin 300/350/3000, Fuel, Tezro, Onyx4,
etc).  We need fully-working IP27 and IP30 first, because much of the working
logic can then be re-purposed for bringing up IP35 hardware.  Especially since
IA64 did a lot of the work already for the Altix systems, which is just IP35
with an IA64 CPU, but I digress...


> It looks like the type 0 config accessors (pci_conf0_read_config(),
> pci_conf0_write_config()) are basically like ECAM, where config space
> is memory-mapped.
> 
> Per spec, the ECAM window for a bridge that could have buses 00-ff
> below it would be 256MB (256 buses * 32 devices/bus * 8
> functions/device * 4096 bytes config space/function).
> 
> But based on b_type0_cfg_dev[], it looks like SGI only made space for
> 8 devices on the root bus, each with 8 functions.  I think that's OK,
> because they can control how many devices can be on the root bus.

Not sure what ECAM is, but yes, SGI wired each BRIDGE ASIC for a maximum of 8
PCI devices (or slots).  There can be multiple BRIDGEs in an SGI system,
though, and for several of their XIO add-in boards, you have one PCI device
hardwired into a BRIDGE ASIC, so whatever logic I cook up is going to need to
handle BRIDGE's with one device or eight.  So much for this being easy...


> The type 1 config accessors (pci_conf1_read_config(),
> pci_conf1_write_config()) are for devices below a PCI-to-PCI bridge.
> It looks like there's a single 4K memory-mapped window, and you point
> it at a specific bus & device with bridge->b_pci_cfg.

Yeah, PCI-to-PCI bridges are a known-broken item right now.  Since there
appears to only be a single Type 1 config space, if I have a PCI Shoebox with
three PCI-X slots, and I stick three USB 2.0 boards in them, I have to pick
which one can handle PCI-to-PCI bridges, like USB hubs, and program that into
this Type 1 register, right?


> The Linux type 0 accessors look like they support 4K config space per
> function, while the type 1 accessors put the function number in bits
> 8-10, so it looks like they only support 256 bytes per function.
> 
> The OpenBSD accessors (xbridge_conf_read() and xbridge_conf_write())
> look like they only support 256 bytes per function regardless of
> whether it's type 0 or type 1.

I'll have to pass this question to the OpenBSD dev who maintains the xbridge
driver.  He understands this hardware far better than I do, and there might be
a reason why they do it that way.


> Supporting 4K of space for type 0 seems like a potential Linux
> problem.  Also, pci_conf1_write_config() uses b_type0_cfg_dev in one
> place where it looks like it should be using b_type1_cfg.  But that's
> in the IOC3 path, and I don't know if that even makes sense for
> non-root bus devices -- I doubt you can put an IOC3 behind a
> PCI-to-PCI bridge.

IOC3 is....special.  You'll never see one of those beind a PCI-to-PCI bridge,
thankfully.  That device is evil enough just sitting exposed on the main PCI
bus.  Just look at the comments in mainline arch/mips/pci/ops-bridge.c for some
rather flavourful language regarding IOC3.  Basically, IOC3:

  - Claims it's a single-function device but is really multi-function.
  - Implements only half of the PCI configuration space.
  - Read/write ops to the unimplemented PCI config registers are undefined.

Living "behind" the IOC3 device is your ethernet, serial ports (RS232 and
RS422), parallel port, keyboard/mouse PS/2 ports, and the RTC chip.  The IA64
people have an IOC3 "metadriver" in drivers/sn/ioc3.c that takes care of
dealing with that monster, and one of the later patches I've yet to send in
moves that driver to drivers/misc/ioc3.c (next to ioc4.c) for use by the SGI
MIPS platforms.  But that is a ways off, as we need working Xtalk code and
working BRIDGE code before the IOC3 metadriver can be worked on.


> If the hardware only supports 256 bytes of config space on non-root
> bus devices, that's not a disaster.  We should still be able to
> enumerate them and use all the conventional PCI features and even
> basic PCIe features.  But the extended config space (offsets
> 0x100-0xfff) would be inaccessible, and we wouldn't see any PCIe
> extended capabilities (AER, VC, SR-IOV, etc., see PCI_EXT_CAP_ID_ERR
> and subsequent definitions) because they live in that space.

I do not think that the BRIDGE supports AER, VC, or SR-IOV at all, primarily
due to age of the hardware.  Even if a PCI device that does support those is
plugged into a BRIDGE, I am not 100% certain those features would even be
usable if the BRIDGE doesn't know about them.  Or is this a case of where the
BRIDGE wouldn't care and once it programs the BARs correctly, these features
would be available to the Linux drivers?


>> If I probe and dump the config space data for each, I get the following:
>>
>>     PCI slot 0 information:
>>         vendor ID :              0x1077
>>         device ID :              0x1020
>>         command :                0x0006
>>         status :                 0x0200
>>         revision :               0x05
>>         prog if :                0x00
>>         class :                  0x0100
>>         cache line :             0x40
>>         latency :                0x40
>>         hdr type :               0x00
>>         BIST :                   0x00
>>         region 0 :               0x00200001
>>         region 1 :               0x00200000
>>         region 2 :               0x00000000
>>         region 3 :               0x00000000
>>         region 4 :               0x00000000
>>         region 5 :               0x00000000
>>         IRQ line :               0x00
>>         IRQ pin :                0x01
>>
>>     PCI slot 1 information:
>>         vendor ID :              0x1077
>>         device ID :              0x1020
>>         command :                0x0006
>>         status :                 0x0200
>>         revision :               0x05
>>         prog if :                0x00
>>         class :                  0x0100
>>         cache line :             0x40
>>         latency :                0x40
>>         hdr type :               0x00
>>         BIST :                   0x00
>>         region 0 :               0x00400001
>>         region 1 :               0x00400000
>>         region 2 :               0x00000000
>>         region 3 :               0x00000000
>>         region 4 :               0x00000000
>>         region 5 :               0x00000000
>>         IRQ line :               0x00
>>         IRQ pin :                0x01
>>
>>     PCI slot 2 information:
>>         vendor ID :              0x10a9
>>         device ID :              0x0003
>>         command :                0x0146
>>         status :                 0x0280
>>         revision :               0x01
>>         prog if :                0x00
>>         class :                  0xff00
>>         cache line :             0x00
>>         latency :                0x28
>>         hdr type :               0x00
>>         BIST :                   0x00
>>         region 0 :               0x00500000
>>         region 1 :               0x00000000
>>         region 2 :               0x00000000
>>         region 3 :               0x00500000
>>         region 4 :               0x000310a9
>>         region 5 :               0x02800146
>>         IRQ line :               0x00
>>         IRQ pin :                0x00
>>
>>     PCI slot 3 information:
>>         vendor ID :              0x10a9
>>         device ID :              0x0005
>>         command :                0x0006
>>         status :                 0x0480
>>         revision :               0xc0
>>         prog if :                0x00
>>         class :                  0x0000
>>         cache line :             0x00
>>         latency :                0xff
>>         hdr type :               0x00
>>         BIST :                   0x00
>>         region 0 :               0x00600000
>>         region 1 :               0x00000000
>>         region 2 :               0x00000000
>>         region 3 :               0x00000000
>>         region 4 :               0x00000000
>>         region 5 :               0x00000000
>>         IRQ line :               0x00
>>         IRQ pin :                0x00
>>
>> This is where my knowledge runs short -- I'm not fluent in PCI device
>> programming, so I'm not sure what is really supposed to be going on with these
>> different BAR regions.  I dug up a copy of the PCI Spec 2.2, but it's 322 pages
>> and I'm not sure where I should start reading from.  Are these regions
>> device-specific?  E.g., do I need the QLA1040B programming manual to understand
>> why region 0 is 0x00200001 and region 1 is 0x00200000?
> 
> The regions (BARs) are definitely device-specific.  The low order bit
> in some of them indicates an I/O BAR.  In the PCI r3.0 spec, sec 6.2.5
> covers "Base Addresses" and tells you how to interpret the low bits.
> For most of the BARs above, they're either 0b01, indicating an I/O
> BAR, or 0b00000, indicating a non-prefetchable 32-bit memory BAR.

Okay, I stumbled across this URL:
http://moi.vonos.net/linux/the-pci-bus/

Which gives a good, plain-english breakdown of BARs and whatnot.

I remember from the OpenBSD xbridge driver, it states that it currently uses
the BAR mappings setup by the ARCS firmware, but the plan is to eventually move
away from those mappings and calculate its own.  I didn't quite get that, but
after reading that site, now I do.  ARCS is writing ~0 to the BARs to query the
device to figure out how much memory each BAR wants, then programs in some
ranges for us.

By tallying up the total requested size of all BAR mappings on a given device,
we can then make a determination on whether we can use a small, medium, or
large window and then program the BAR with the correct address.  Right?

Could also do my own probes (or maybe Linux already does this?), but for the
short-term, using what ARCS has already setup might not be a bad idea to get
things working again.


>> I am also not yet considering how PCI views Crosstalk space for DMA operations
>> -- BRIDGE has several mechanisms for that, depending on if the PCI device is a
>> 32-bit device or a 64-bit device.  It can do direct-mapping for 32-bit or
>> 64-bit, or built-in page-mapping hardware is available (but apparently to be
>> avoided due to numerous hardware quirks/bugs that would make the driver
>> overly-complicated).
>>
>> There's a good write-up in the OpenBSD "xbridge" driver, which handles BRIDGE
>> (IP27/IP30), XBRIDGE (IP35), and PIC (IP35/IA64 Altix):
>>
>> http://bxr.su/OpenBSD/sys/arch/sgi/xbow/xbridge.c
>>
>> It's starting to make some sense to me, but I am still uncertain how to work
>> with the 32-bit and 64-bit 1GB PCI memory spaces on BRIDGE as well as the 4GB
>> PCI I/O space from a Linux point of view.  Do they only matter when dealing
>> with DMA?
> 
> The host bridge windows (the "root bus resource" lines in dmesg) are
> only for PIO, i.e., a driver running on the CPU reading or writing
> registers on the PCI device (it could be actual registers, or a frame
> buffer, etc., but it resides on the device and its PCI bus address is
> determined by a BAR).  The driver uses ioremap(), pci_iomap(),
> pcim_iomap_regions(), etc. to map these into the kernel virtual space.

So for the MIPS case, knowing that ioremap() and friends is not guaranteed to
return a workable virtual address, I need to be careful of what addresses I
program into each BAR.  E.g., given that on IP30, if a physical address starts
with 0x9000000f800xxxxx, it is using medium windows to talk to a device on the
BaseIO BRIDGE (Xtalk widget 0xf).  As such, knowing MIPS' ioremap() returns,
for the R10000 CPU case, the requested address OR'ed with IO_BASE
(0x9000000000000000), I want to tell the PCI core to use 0x0000000f800xxxxx so
that ioremap() will return back 0x9000000f800xxxxx?

And since I can apparently specify multiple window ranges for memory space and
I/O space, I probably want to, as stated earlier, specify all three of IP30's
known window ranges for each BRIDGE so that the Linux PCI core can walk each
resource struct and find a matching window?

If that thinking is correct, then I have some idea of how to set that up and
then see if things start working again on IP30 and then eventually, IP27.


> DMA is coming the other direction and the windows are irrelevant
> except that the target PCI bus address must be outside all the windows
> (if the DMA target address were *inside* a host bridge window, the
> bridge would assume it is intended for a PCI device, e.g., for
> peer-to-peer DMA).

DMA is the tricky one.  OpenBSD's xbridge driver implies that BRIDGE's IOMMU
has a bug of some kind in it that restricts our DMA-able address ranges to 31
bits, or 0x00000000 to 0x7fffffff.  IP27 doesn't seem to be bothered by this in
the current code, and as such, I can use all 8GB of RAM on that platform.

But IP30 has its physical memory offset 512MB, so physical memory maps begin at
0x20000000 and run to 0x9fffffff.  This means someone playing with Linux on an
IP30 platform can only install up to 2GB of RAM right now, if they want the
machine to be stable.  Though, there are other issues going on that imply that
"stable" is a very subjective term...

In either event, how do I teach the Linux PCI core that the BRIDGE itself is
limited to 31bits of DMA-able address space?  There seems to be plenty of
documentation on having an individual PCI device set this up by setting its DMA
mask, but I can't seem to find any wording on how to do this for an entire PCI bus.

Or is this an architecture-specific thing?  MIPS has the dma-coherence.h header
for defining system-specific DMA quirks, but that code seems heavily biased
towards PCI devices, and on IP30 at least, the Impact and Odyssey video cards
are NOT PCI devices at all, instead being native XIO devices that support DMA
operations.


> I think the biggest problem is that you need to set up the BRIDGE
> *before* calling pcibios_scan_bus().  That way the windows
> ("hose->mem_resource", "hose->io_resource", etc.) will be correct when
> the PCI core enumerates the devices.  Note that you can have as many
> windows in the "&resources" list as you need -- the current code there
> only has one memory and one I/O window, but you can add more.

Agreed, however, I think this is actually being done to some extent already.
We're configuring BRIDGE-specific properties and writing some values to BRIDGE
registers and the per-slot registers in bridge_probe() in the generic
pci-bridge.c driver, then, at the very end, calling register_pci_controller(),
which I believe is what kicks off the PCI bus scan.

The IP30 BRIDGE glue code adds a new function hook called "pre_enable" where it
does, in ip30-bridge.c, some additional PCI device tweaking, but this code will
run after the PCI bus scan has happened.  My guess is that I want to reverse
this and have the IP30 glue code twiddle the PCI devices on a given BRIDGE
before the PCI bus scan, right?  That code uses pci_read_config_dword() and
pci_write_config_dword() -- are these functions safe to use if we haven't
already done a PCI bus scan?

Thanks!

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
