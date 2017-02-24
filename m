Return-Path: <SRS0=Klm8=2F=gentoo.org=kumba@kernel.org>
Return-Path: <SRS0=Klm8=2F=gentoo.org=kumba@kernel.org>
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
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ralf Baechle <ralf@linux-mips.org>,
 James Hogan <james.hogan@imgtec.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Linux/MIPS <linux-mips@linux-mips.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Joshua Kinard <kumba@gentoo.org>
Message-ID: <926cfb3a-085f-164b-4ec3-76dc9db3298b@gentoo.org>
Date: Fri, 24 Feb 2017 03:50:26 -0500
MIME-Version: 1.0
In-Reply-To: <20170214145628.GA10418@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 02/14/2017 09:56, Bjorn Helgaas wrote:
> On Tue, Feb 14, 2017 at 02:39:45AM -0500, Joshua Kinard wrote:
>> On 02/13/2017 17:45, Bjorn Helgaas wrote:
>>> It looks like IP30 is using some code that's not upstream yet, so I'll
>>> just point out some things that don't look right.  I'm ignoring the
>>> IP27 stuff here in case that has different issues.
>>
>> Sorry about that.  It's an external set of patches I've been maintaining for
>> the last decade (I'm not the original author).  Being that I do this for a
>> hobby, sometimes I get waylaid by other priorities.  I've spent some time
>> re-organizing my patch collection lately so that I can start sending these
>> things in.  This series and an earlier one to the Linux/MIPS list are the
>> beginnings of that, as time permits.  However, I've got a ways to go before
>> getting to the IP30 patches.  E.g., IP27 comes before IP30, so that's where my
>> focus has been lately.
>>
>> I've put an 4.10-rc7 tree with all patches applied here (including the IOC3,
>> IP27, and IP30 patches):
>> http://dev.gentoo.org/~kumba/mips/ip30/linux-4.10_rc7-20170208.ip30/
>>
>> The patchset itself, if interested:
>> http://dev.gentoo.org/~kumba/mips/ip30/mips-patches-4.10.0/
> 
> Thanks for the pointers.
> 
>>> All the resources under the bridge to 0000:00 are wrong, too:
>>>
>>>   1f200000-1f9fffff : Bridge MEM
>>>     f080100000-f0801fffff : 0000:00:02.0
>>>     f080010000-f08001ffff : 0000:00:00.0
>>>     f080030000-f08003ffff : 0000:00:01.0
>>>     f080000000-f080000fff : 0000:00:00.0
>>>     f080020000-f080020fff : 0000:00:01.0
>>
>> Actually, that's not wrong.  It took me a long time to figure this out, too,
>> but once I stumbled upon the BRIDGE ASIC specification on an anonymous FTP
>> site, via Google, by complete accident (hint), it finally made sense.
>>
>> BRIDGE is what SGI calls the chip that interfaces the Crosstalk (Xtalk) bus to
>> a PCI bus.  Most known "XIO" (Xtalk I/O) boards contain a BRIDGE chip under a
>> heatsink at the edge of the board, next to a "compression connector".  Octane
>> can hold up to four XIO boards, with a fifth slot dedicated to an optional "PCI
>> Shoebox" (literally a metal box that can hold up to three PCI or PCI-X cards).
>> One exception to this are the two graphics boards, Impact/MGRAS and
>> Odyssey/VPro, which are "pure" XIO devices, as far as anyone's figured out.
>>
>> Each BRIDGE chip can address up to eight different PCI devices.
>>
>> Crosstalk on IP30 is managed by the Crossbow (XBOW) ASIC.  It implements a
>> crossbar switch that's not totally unlike a networking switch.  A single XBOW
>> supports up to 16 XIO widgets, numbered 0x0 to 0xf.  Widgets 0x1 to 0x7 are for
>> internal use or unused.  XBOW itself is widget 0x0.  HEART, Octane's system
>> controller, is widget 0x8.  The four standard XIO slots are numbered (I think)
>> as 0x9 to 0xc.  I think widget 0xe is unused.
>>
>> The system board has a BRIDGE chip on it to provide the "BaseIO" devices, such
>> as two SCSI (QL1040B), IOC3 Ethernet, KB/Mouse, Serial/Parallel, Audio, and an
>> RTC.  This BaseIO BRIDGE is widget 0xf, which is what you're seeing with the
>> first set of addresses starting with 0x1fxxx.  The second BRIDGE that you're
>> seeing is the PCI Shoebox I have installed.  It's widget 0xd, and has addresses
>> starting with 0x1dxxx (second nibble from left is the widget), with three
>> random PCI cards I found in a storage bin plugged into it.  The Xtalk scan
>> happens in reverse order, starting at widget 0xf down to 0x0.
>>
>> Both 0x1fxxx and 0x1dxxx addresses are "small window" addresses.  The HEART
>> system controller gives you three "windows" into Xtalk space, which uses 48-bit
>> addressing:
>>
>> 0x0000_1000_0000 - 0x0000_1fff_ffff - Small windows, x16 @ 16MB each
>> 0x0008_0000_0000 - 0x000f_ffff_ffff - Medium windows, x16 @ 2GB each
>> 0x0010_0000_0000 - 0x00ff_ffff_ffff - Big windows, x15 @ 64GB each
>>
>> So a device on widget 0xf mapped into a small window at 0x0000_1fxx_xxxx could
>> also be referred to by a big window at address 0x00f0_8xxx_xxxx.  The only
>> difference is the big window gives you a larger address space to play around
>> with.  Medium windows are not currently used on the IP30 platform in Linux.
>> Widget 0x0 (XBOW) is only accessible via small or medium windows.
>>
>> As such, this layout in /proc/iomem is oddly correct:
>>
>>>   1f200000-1f9fffff : Bridge MEM
>>>     f080100000-f0801fffff : 0000:00:02.0
>>>     f080010000-f08001ffff : 0000:00:00.0
>>>     f080030000-f08003ffff : 0000:00:01.0
>>>     f080000000-f080000fff : 0000:00:00.0
>>>     f080020000-f080020fff : 0000:00:01.0
>>
>> My bug is probably that I do the initial BRIDGE scan with small windows in the
>> main BRIDGE driver (arch/mips/pci/pci-bridge.c), and then IP30's BRIDGE glue
>> driver (arch/mips/sgi-ip30/ip30-bridge.c) is switching to big windows to probe
>> each device.  So, yes, different address ranges, but still looking at the same
>> device.  I'll look into fixing that.  It's partially tied to how I was kludging
>> the IP27 to also start doing PCI correctly within its own BRIDGE glue driver
>> (ip27-bridge.c), but I just learned over the weekend that there's missing
>> functionality I have to port over from old 2.5.x-era IA64 code.  In IP30, big
>> windows are available by default, but on IP27, what it calls "big windows" need
>> to go through some kind of translation table, and I'm trying to figure out how
>> to set that up.
> 
> I agree, it sounds like the problem is the switch from small windows
> to big ones.  In order for the PCI core to work correctly, the host
> bridge window ("1f200000-1f9fffff : Bridge MEM") must enclose the BARs
> of the devices below the bridge.
> 
> If you use the big windows for the device BARs, you should use big
> windows for the host bridge windows.  I think we're talking about
> widget 0xf here, so the 0xf big window would be 0xf0_0000_0000 -
> 0xff_ffff_ffff.  This should all be set up *before* calling
> pci_scan_root_bus() instead of after, as it seems to be today.

Okay, so after a week of downtime due to hardware failure on another machine, I
started looking at this again, and it looks like it's more than just getting
the windows wrong.  The existing BRIDGE code (pci-bridge.c) is limiting the PCI
window to the first five devices on BaseIO in the small window (my fault), and
the IP30 glue code (ip30-bridge.c) is re-writing the PCI BARs to access the
BRIDGE PCI Memory and PCI I/O spaces via big windows, without updating the
original mapping.  We're not teaching the Linux PCI core at all, I think, about
how to generically access PCI Memory Space and PCI I/O Space on the BRIDGE.
The fact this actually works appears to be pure luck.

Quoting from the BRIDGE docs somewhat, from the point of view of generic
Crosstalk space and not specific to IP30 or IP27, there are several views into
PCI space.  Each address is 48-bits, the size of a Crosstalk address.

    0000_0000_0000 to 0000_00ff_ffff is "Widget space".  It seems the BRIDGE
    docs use the term "widget" here to refer to the eight possible PCI devices
    addressable by a single BRIDGE ASIC.  This plus the small windows is how
    the code is currently getting things to work.  I think.

    0000_4000_0000 to 0000_7fff_ffff is BRIDGE's view into PCI Memory Space
    for direct-mapped 32-bit devices.  It is 1GB in size.  My take is this is
    normally a 4GB space?  Can the Linux PCI core be taught that only 1GB
    is usable?

    0000_8000_0000 to 0000_bfff_ffff is an alias view by BRIDGE into PCI
    Memory space for 64-bit PCI devices, immediately after the 32-bit space.
    It is also 1GB in size.

    0000_c000_0000 to 0000_ffff_ffff is 2GB adjacent to PCI Memory space, but
    is either unused or used for Crosstalk/BRIDGE DMA operations
    (the docs aren't very clear on this point or I am simply not
    understanding).

    0001_0000_0000 to 0001_ffff_ffff is BRIDGE's view into PCI I/O Space.
    It has the entire 4GB range available to use.


I suspect the existing BRIDGE driver is mapping through "widget space" first to
probe the PCI device slots, then the ip30-bridge.c code is re-writing the PCI
BARs to go through the big window on IP30, but it never updates the original
BRIDGE setup (if that's even possible).  As such, as you pointed out, there's
some kind of logic in the generic PCI core that's re-assigning space from the
window and we're just getting lucky and everything still works.

I dug up some old debugging code given to me by the original author of the IP30
port and built up a set of macros that get me to the PCI Configuration Space on
Widget 0xf (BaseIO Bridge), Device #0 (the first QLA1040B SCSI controller).
All three addresses access the same PCI device and return the same config space
info.

    Small window:  0x900000001f02xxxx
    Medium window: 0x9000000f8002xxxx
    Big window:    0x900000f00002xxxx


Each additional device's configuration space is offset 0x1000, which gives me
the following addresses (dev's 4 to 7 are special-cased for IRQ trickery, so
can't probe them):

    - Dev #0: scsi0/qla1040b: 0x90xxxxxxxxx20000
    - Dev #1: scsi1/qla1040b: 0x90xxxxxxxxx21000
    - Dev #2: io/ioc3       : 0x90xxxxxxxxx22000
    - Dev #3: audio/rad1    : 0x90xxxxxxxxx23000


If I probe and dump the config space data for each, I get the following:

    PCI slot 0 information:
        vendor ID :              0x1077
        device ID :              0x1020
        command :                0x0006
        status :                 0x0200
        revision :               0x05
        prog if :                0x00
        class :                  0x0100
        cache line :             0x40
        latency :                0x40
        hdr type :               0x00
        BIST :                   0x00
        region 0 :               0x00200001
        region 1 :               0x00200000
        region 2 :               0x00000000
        region 3 :               0x00000000
        region 4 :               0x00000000
        region 5 :               0x00000000
        IRQ line :               0x00
        IRQ pin :                0x01

    PCI slot 1 information:
        vendor ID :              0x1077
        device ID :              0x1020
        command :                0x0006
        status :                 0x0200
        revision :               0x05
        prog if :                0x00
        class :                  0x0100
        cache line :             0x40
        latency :                0x40
        hdr type :               0x00
        BIST :                   0x00
        region 0 :               0x00400001
        region 1 :               0x00400000
        region 2 :               0x00000000
        region 3 :               0x00000000
        region 4 :               0x00000000
        region 5 :               0x00000000
        IRQ line :               0x00
        IRQ pin :                0x01

    PCI slot 2 information:
        vendor ID :              0x10a9
        device ID :              0x0003
        command :                0x0146
        status :                 0x0280
        revision :               0x01
        prog if :                0x00
        class :                  0xff00
        cache line :             0x00
        latency :                0x28
        hdr type :               0x00
        BIST :                   0x00
        region 0 :               0x00500000
        region 1 :               0x00000000
        region 2 :               0x00000000
        region 3 :               0x00500000
        region 4 :               0x000310a9
        region 5 :               0x02800146
        IRQ line :               0x00
        IRQ pin :                0x00

    PCI slot 3 information:
        vendor ID :              0x10a9
        device ID :              0x0005
        command :                0x0006
        status :                 0x0480
        revision :               0xc0
        prog if :                0x00
        class :                  0x0000
        cache line :             0x00
        latency :                0xff
        hdr type :               0x00
        BIST :                   0x00
        region 0 :               0x00600000
        region 1 :               0x00000000
        region 2 :               0x00000000
        region 3 :               0x00000000
        region 4 :               0x00000000
        region 5 :               0x00000000
        IRQ line :               0x00
        IRQ pin :                0x00

This is where my knowledge runs short -- I'm not fluent in PCI device
programming, so I'm not sure what is really supposed to be going on with these
different BAR regions.  I dug up a copy of the PCI Spec 2.2, but it's 322 pages
and I'm not sure where I should start reading from.  Are these regions
device-specific?  E.g., do I need the QLA1040B programming manual to understand
why region 0 is 0x00200001 and region 1 is 0x00200000?

I am also not yet considering how PCI views Crosstalk space for DMA operations
-- BRIDGE has several mechanisms for that, depending on if the PCI device is a
32-bit device or a 64-bit device.  It can do direct-mapping for 32-bit or
64-bit, or built-in page-mapping hardware is available (but apparently to be
avoided due to numerous hardware quirks/bugs that would make the driver
overly-complicated).

There's a good write-up in the OpenBSD "xbridge" driver, which handles BRIDGE
(IP27/IP30), XBRIDGE (IP35), and PIC (IP35/IA64 Altix):

http://bxr.su/OpenBSD/sys/arch/sgi/xbow/xbridge.c

It's starting to make some sense to me, but I am still uncertain how to work
with the 32-bit and 64-bit 1GB PCI memory spaces on BRIDGE as well as the 4GB
PCI I/O space from a Linux point of view.  Do they only matter when dealing
with DMA?

--J



> The scan would look like this:
> 
>   pci_bus 0000:00: root bus resource [mem 0xf000000000-0xffffffffff] (bus addresses [0x00000000-0xfffffffff])
>   pci 0000:00:00.0: reg 0x14: [mem 0xf000200000-0xf000200fff]
>   pci 0000:00:00.0: reg 0x30: [mem 0xf000210000-0xf00021ffff pref]
>   pci 0000:00:01.0: reg 0x14: [mem 0xf000400000-0xf000400fff]
>   pci 0000:00:01.0: reg 0x30: [mem 0xf000410000-0xf00041ffff pref]
>   pci 0000:00:02.0: reg 0x10: [mem 0xf000500000-0xf0005fffff]
>   pci 0000:00:03.0: reg 0x10: [mem 0xf000600000-0xf000601fff]
> 
> This would make /proc/iomem look like this:
> 
>   f000000000-ffffffffff : Bridge MEM
>     f000500000-f0005fffff : 0000:00:02.0
>     f000210000-f00021ffff : 0000:00:00.0
>     f000410000-f00041ffff : 0000:00:01.0
>     f000200000-f000200fff : 0000:00:00.0
>     f000400000-f000400fff : 0000:00:01.0
> 
> This doesn't match the device BARs in your /proc/iomem, so there must
> be some other transformation going on as well.
> 
> As long as you tell the PCI core about the host bridge windows you're
> going to use, along with offsets that include *all* these
> transformations, the core should just work, and /proc/iomem should
> also make sense.  The details of small/medium/big windows, widgets,
> etc., are immaterial to the core.
> 
> Bjorn
> 
