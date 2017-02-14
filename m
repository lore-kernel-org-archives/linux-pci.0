Return-Path: <SRS0=jGV0=Z3=gentoo.org=kumba@kernel.org>
Return-Path: <SRS0=jGV0=Z3=gentoo.org=kumba@kernel.org>
Subject: Re: [PATCH 12/12] MIPS: PCI: Fix IP27 for the PCI_PROBE_ONLY case
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20170207061356.8270-1-kumba@gentoo.org>
 <20170207061356.8270-13-kumba@gentoo.org>
 <CAErSpo6yKAE1_c1eZJapnjD1g0pocyOxed3_Eumdp_026uhDuA@mail.gmail.com>
 <eafc94c6-1931-e2ce-7e03-d84d8e181e81@gentoo.org>
 <CAErSpo4LsrPCtdZwp6CyT0jKhXLt3j=fGSiFjpRRTPUjFoKHtQ@mail.gmail.com>
 <c7ed6a1d-f625-d294-8910-dd2d93d34292@gentoo.org>
 <20170213224512.GA8080@bhelgaas-glaptop.roam.corp.google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ralf Baechle <ralf@linux-mips.org>,
 James Hogan <james.hogan@imgtec.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Linux/MIPS <linux-mips@linux-mips.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Joshua Kinard <kumba@gentoo.org>
Message-ID: <8ec2a0bf-6bd7-1366-38bc-7f7ba9a29971@gentoo.org>
Date: Tue, 14 Feb 2017 02:39:45 -0500
MIME-Version: 1.0
In-Reply-To: <20170213224512.GA8080@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 02/13/2017 17:45, Bjorn Helgaas wrote:
> It looks like IP30 is using some code that's not upstream yet, so I'll
> just point out some things that don't look right.  I'm ignoring the
> IP27 stuff here in case that has different issues.

Sorry about that.  It's an external set of patches I've been maintaining for
the last decade (I'm not the original author).  Being that I do this for a
hobby, sometimes I get waylaid by other priorities.  I've spent some time
re-organizing my patch collection lately so that I can start sending these
things in.  This series and an earlier one to the Linux/MIPS list are the
beginnings of that, as time permits.  However, I've got a ways to go before
getting to the IP30 patches.  E.g., IP27 comes before IP30, so that's where my
focus has been lately.

I've put an 4.10-rc7 tree with all patches applied here (including the IOC3,
IP27, and IP30 patches):
http://dev.gentoo.org/~kumba/mips/ip30/linux-4.10_rc7-20170208.ip30/

The patchset itself, if interested:
http://dev.gentoo.org/~kumba/mips/ip30/mips-patches-4.10.0/

You can find the IP30 code in:
  arch/mips/sgi-ip30/*
  arch/mips/include/asm/mach-ip30/*

IP27's code is in these folders:
  arch/mips/sgi-ip27/*
  arch/mips/include/asm/mach-ip27/*
  arch/mips/include/asm/sn/*

PCI code:
  arch/mips/pci/pci-bridge.c
  arch/mips/pci/ops-bridge.c
  arch/mips/include/asm/pci/bridge.h


> Joshua wrote:
>> On 02/07/2017 13:29, Bjorn Helgaas wrote:
>>> Is there any chance you can collect complete dmesg logs and
>>> /proc/iomem contents from IP27 and IP30?  Maybe "lspci -vv" output,
>>> too?  I'm not sure where to look to understand the ioremap() behavior.
>>
>> ...
>> A note about IP30, since that's part of an external patch set, the
>> dmesg output is a little different, as it is using the newer
>> BRIDGE/Xtalk code I just sent in as patches.  ...
>>
>> Also, IP30 doesn't use the PCI_PROBE_ONLY thing anymore.  This causes
>> /proc/iomem to be far more detailed than it used to be.
>>
>> IP30's /proc/iomem:
>>     00000000-00003fff : reserved
>>     1d200000-1d9fffff : Bridge MEM
>>       d080000000-d080003fff : 0001:00:03.0
>>       1d204000-1d204fff : 0001:00:02.0
>>       1d205000-1d205fff : 0001:00:02.1
>>       1d206000-1d206fff : 0001:00:02.2
>>       1d207000-1d2070ff : 0001:00:02.3
>>       1d207100-1d20717f : 0001:00:01.0
>>     1f200000-1f9fffff : Bridge MEM
>>       f080100000-f0801fffff : 0000:00:02.0
>>       f080010000-f08001ffff : 0000:00:00.0
>>       f080030000-f08003ffff : 0000:00:01.0
>>       f080000000-f080000fff : 0000:00:00.0
>>       f080020000-f080020fff : 0000:00:01.0
>>     20004000-209b8fff : reserved
>>       20004000-206acb13 : Kernel code
>>       206acb14-208affff : Kernel data
>>     209b9000-20efffff : System RAM
>>     20f00000-20ffffff : System RAM
>>     21000000-9fffffff : System RAM
>>     f080100000-f0801fffff : ioc3
> 
>>From the dmesg you attached (ip30-dmesg-20170208.txt, PCI parts
> appended below):
> 
>   pci_bus 0000:00: root bus resource [mem 0x1f200000-0x1f9fffff]
>   pci_bus 0001:00: root bus resource [mem 0x1d200000-0x1d9fffff]
> 
> These are shown correctly in /proc/iomem.  It would be nice if the
> /proc/iomem string identified which bridge was which (x86 uses "PCI
> Bus 0000:00", "PCI Bus 0001:00", etc.) but that's not essential.
> 
>   pci 0001:00:03.0: BAR 0: assigned [mem 0x1d200000-0x1d203fff]
>   ip30-bridge: 0001:00:03.0 Bar 0 with size 0x00004000 at bus 0x00000000 vma 0x000000d080000000 is Direct 64-bit.
> 
> This is funky.  We read 0x1d200000 from the BAR (PCI bus addresses are
> apparently identical to CPU physical addresses).  We claimed that
> space from the host bridge window, so /proc/iomem would have looked
> like this at that point:
> 
>   1d200000-1d9fffff : Bridge MEM
>     1d200000-1d203fff : 0001:00:03.0
> 
> But it looks like whatever this ip30-bridge thing is overwrote the
> 0001:00:03.0 resource, which makes /proc/iomem wrong.
> 
> All the resources under the bridge to 0000:00 are wrong, too:
> 
>   1f200000-1f9fffff : Bridge MEM
>     f080100000-f0801fffff : 0000:00:02.0
>     f080010000-f08001ffff : 0000:00:00.0
>     f080030000-f08003ffff : 0000:00:01.0
>     f080000000-f080000fff : 0000:00:00.0
>     f080020000-f080020fff : 0000:00:01.0

Actually, that's not wrong.  It took me a long time to figure this out, too,
but once I stumbled upon the BRIDGE ASIC specification on an anonymous FTP
site, via Google, by complete accident (hint), it finally made sense.

BRIDGE is what SGI calls the chip that interfaces the Crosstalk (Xtalk) bus to
a PCI bus.  Most known "XIO" (Xtalk I/O) boards contain a BRIDGE chip under a
heatsink at the edge of the board, next to a "compression connector".  Octane
can hold up to four XIO boards, with a fifth slot dedicated to an optional "PCI
Shoebox" (literally a metal box that can hold up to three PCI or PCI-X cards).
One exception to this are the two graphics boards, Impact/MGRAS and
Odyssey/VPro, which are "pure" XIO devices, as far as anyone's figured out.

Each BRIDGE chip can address up to eight different PCI devices.

Crosstalk on IP30 is managed by the Crossbow (XBOW) ASIC.  It implements a
crossbar switch that's not totally unlike a networking switch.  A single XBOW
supports up to 16 XIO widgets, numbered 0x0 to 0xf.  Widgets 0x1 to 0x7 are for
internal use or unused.  XBOW itself is widget 0x0.  HEART, Octane's system
controller, is widget 0x8.  The four standard XIO slots are numbered (I think)
as 0x9 to 0xc.  I think widget 0xe is unused.

The system board has a BRIDGE chip on it to provide the "BaseIO" devices, such
as two SCSI (QL1040B), IOC3 Ethernet, KB/Mouse, Serial/Parallel, Audio, and an
RTC.  This BaseIO BRIDGE is widget 0xf, which is what you're seeing with the
first set of addresses starting with 0x1fxxx.  The second BRIDGE that you're
seeing is the PCI Shoebox I have installed.  It's widget 0xd, and has addresses
starting with 0x1dxxx (second nibble from left is the widget), with three
random PCI cards I found in a storage bin plugged into it.  The Xtalk scan
happens in reverse order, starting at widget 0xf down to 0x0.

Both 0x1fxxx and 0x1dxxx addresses are "small window" addresses.  The HEART
system controller gives you three "windows" into Xtalk space, which uses 48-bit
addressing:

0x0000_1000_0000 - 0x0000_1fff_ffff - Small windows, x16 @ 16MB each
0x0008_0000_0000 - 0x000f_ffff_ffff - Medium windows, x16 @ 2GB each
0x0010_0000_0000 - 0x00ff_ffff_ffff - Big windows, x15 @ 64GB each

So a device on widget 0xf mapped into a small window at 0x0000_1fxx_xxxx could
also be referred to by a big window at address 0x00f0_8xxx_xxxx.  The only
difference is the big window gives you a larger address space to play around
with.  Medium windows are not currently used on the IP30 platform in Linux.
Widget 0x0 (XBOW) is only accessible via small or medium windows.

As such, this layout in /proc/iomem is oddly correct:

>   1f200000-1f9fffff : Bridge MEM
>     f080100000-f0801fffff : 0000:00:02.0
>     f080010000-f08001ffff : 0000:00:00.0
>     f080030000-f08003ffff : 0000:00:01.0
>     f080000000-f080000fff : 0000:00:00.0
>     f080020000-f080020fff : 0000:00:01.0

My bug is probably that I do the initial BRIDGE scan with small windows in the
main BRIDGE driver (arch/mips/pci/pci-bridge.c), and then IP30's BRIDGE glue
driver (arch/mips/sgi-ip30/ip30-bridge.c) is switching to big windows to probe
each device.  So, yes, different address ranges, but still looking at the same
device.  I'll look into fixing that.  It's partially tied to how I was kludging
the IP27 to also start doing PCI correctly within its own BRIDGE glue driver
(ip27-bridge.c), but I just learned over the weekend that there's missing
functionality I have to port over from old 2.5.x-era IA64 code.  In IP30, big
windows are available by default, but on IP27, what it calls "big windows" need
to go through some kind of translation table, and I'm trying to figure out how
to set that up.

There's also an issue with DMA on BRIDGE on IP30 that limits the system's
memory to 2GB to avoid kernel panics.  OpenBSD's figured it out -- BRIDGE's
IOMMU is busted so it can only do 31-bit DMA max.  I just haven't figured out
how to set that limit in Linux for the entire BRIDGE, not just for individual
devices.


> We read values from the BARs:
> 
>   pci_bus 0000:00: root bus resource [mem 0x1f200000-0x1f9fffff]
>   pci 0000:00:00.0: reg 0x14: [mem 0x00200000-0x00200fff]
>   pci 0000:00:00.0: reg 0x30: [mem 0x00210000-0x0021ffff pref]
>   pci 0000:00:01.0: reg 0x14: [mem 0x00400000-0x00400fff]
>   pci 0000:00:01.0: reg 0x30: [mem 0x00410000-0x0041ffff pref]
>   pci 0000:00:02.0: reg 0x10: [mem 0x00500000-0x005fffff]
>   pci 0000:00:03.0: reg 0x10: [mem 0x00600000-0x00601fff]
> 
> These aren't zero, so somebody apparently has assigned them, but they
> aren't inside the host bridge window.  Therefore the PCI core assumes
> they will not work, and it reassigns space from the window:
> 
>   pci 0000:00:02.0: BAR 0: assigned [mem 0x1f200000-0x1f2fffff]
>   pci 0000:00:00.0: BAR 6: assigned [mem 0x1f300000-0x1f30ffff pref]
>   pci 0000:00:01.0: BAR 6: assigned [mem 0x1f310000-0x1f31ffff pref]
>   pci 0000:00:00.0: BAR 1: assigned [mem 0x1f320000-0x1f320fff]
>   pci 0000:00:01.0: BAR 1: assigned [mem 0x1f321000-0x1f321fff]

Hmm, from the PCI device's point of view, 0x00200000-0x00200fff would be
correct.  The same address beginning with 0x1fxxx is the Crosstalk view of the
device.  Odds are likely I am not masking something off somewhere, but somehow,
it all still finds a way to work.


> I don't know why we didn't assign space to 0000:00:03.0 BAR 1.

The PCI device sitting at 0000:00:03.0 is the "RAD Audio" chip.  There's an
issue with the driver that I keep forgetting to try and fix, so I've left it
out of my recent kernel builds.  That's probably why no space is being assigned
to it.


>>From /proc/iomem, I would expect that only the USB devices (0001:00:02
> functions 0, 1, 2, 3) would work.  But apparently your system does
> actually work, so there must be corresponding funkiness somewhere else
> that compensates for these resources.

USB is...interesting on this platform.  Some USB devices will work, but not
many have been tested.  If my memory recalls, I think UHCI was known to play
nice, but OHCI had issues -- might be the other way around.  EHCI is dependent
on what you plug in and the position of several planets in the sky.  xHCI has
endianess issues with one card that I tried.  It's hard to find PCI or PCI-X
xHCI cards, though.  Most everything now is PCIe.  And due to chassis space
restrictions, using PCIe-to-PCI-X adapters is a no-go.

PCI-to-PCI bridges and USB hubs are totally busted, because BRIDGE's PCI Type 1
configuration space isn't very well understood.  The BRIDGE Specification I
think finally cleared that up, but I have not tried to learn how to actually
set the space up and find a spare USB Hub to play with.

All-in-all, the entire machine is as much a work of art in its inner workings
as how it looks on the outside.  As with all art, it's up to the eye of the
beholder on whether that's a good thing or not </smirk>

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
