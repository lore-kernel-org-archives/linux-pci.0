Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751972AbdBNO4e (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Feb 2017 09:56:34 -0500
Date: Tue, 14 Feb 2017 08:56:28 -0600
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
Message-ID: <20170214145628.GA10418@bhelgaas-glaptop.roam.corp.google.com>
References: <20170207061356.8270-1-kumba@gentoo.org>
 <20170207061356.8270-13-kumba@gentoo.org>
 <CAErSpo6yKAE1_c1eZJapnjD1g0pocyOxed3_Eumdp_026uhDuA@mail.gmail.com>
 <eafc94c6-1931-e2ce-7e03-d84d8e181e81@gentoo.org>
 <CAErSpo4LsrPCtdZwp6CyT0jKhXLt3j=fGSiFjpRRTPUjFoKHtQ@mail.gmail.com>
 <c7ed6a1d-f625-d294-8910-dd2d93d34292@gentoo.org>
 <20170213224512.GA8080@bhelgaas-glaptop.roam.corp.google.com>
 <8ec2a0bf-6bd7-1366-38bc-7f7ba9a29971@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8ec2a0bf-6bd7-1366-38bc-7f7ba9a29971@gentoo.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 14, 2017 at 02:39:45AM -0500, Joshua Kinard wrote:
> On 02/13/2017 17:45, Bjorn Helgaas wrote:
> > It looks like IP30 is using some code that's not upstream yet, so I'll
> > just point out some things that don't look right.  I'm ignoring the
> > IP27 stuff here in case that has different issues.
> 
> Sorry about that.  It's an external set of patches I've been maintaining for
> the last decade (I'm not the original author).  Being that I do this for a
> hobby, sometimes I get waylaid by other priorities.  I've spent some time
> re-organizing my patch collection lately so that I can start sending these
> things in.  This series and an earlier one to the Linux/MIPS list are the
> beginnings of that, as time permits.  However, I've got a ways to go before
> getting to the IP30 patches.  E.g., IP27 comes before IP30, so that's where my
> focus has been lately.
> 
> I've put an 4.10-rc7 tree with all patches applied here (including the IOC3,
> IP27, and IP30 patches):
> http://dev.gentoo.org/~kumba/mips/ip30/linux-4.10_rc7-20170208.ip30/
> 
> The patchset itself, if interested:
> http://dev.gentoo.org/~kumba/mips/ip30/mips-patches-4.10.0/

Thanks for the pointers.

> > All the resources under the bridge to 0000:00 are wrong, too:
> > 
> >   1f200000-1f9fffff : Bridge MEM
> >     f080100000-f0801fffff : 0000:00:02.0
> >     f080010000-f08001ffff : 0000:00:00.0
> >     f080030000-f08003ffff : 0000:00:01.0
> >     f080000000-f080000fff : 0000:00:00.0
> >     f080020000-f080020fff : 0000:00:01.0
> 
> Actually, that's not wrong.  It took me a long time to figure this out, too,
> but once I stumbled upon the BRIDGE ASIC specification on an anonymous FTP
> site, via Google, by complete accident (hint), it finally made sense.
> 
> BRIDGE is what SGI calls the chip that interfaces the Crosstalk (Xtalk) bus to
> a PCI bus.  Most known "XIO" (Xtalk I/O) boards contain a BRIDGE chip under a
> heatsink at the edge of the board, next to a "compression connector".  Octane
> can hold up to four XIO boards, with a fifth slot dedicated to an optional "PCI
> Shoebox" (literally a metal box that can hold up to three PCI or PCI-X cards).
> One exception to this are the two graphics boards, Impact/MGRAS and
> Odyssey/VPro, which are "pure" XIO devices, as far as anyone's figured out.
> 
> Each BRIDGE chip can address up to eight different PCI devices.
> 
> Crosstalk on IP30 is managed by the Crossbow (XBOW) ASIC.  It implements a
> crossbar switch that's not totally unlike a networking switch.  A single XBOW
> supports up to 16 XIO widgets, numbered 0x0 to 0xf.  Widgets 0x1 to 0x7 are for
> internal use or unused.  XBOW itself is widget 0x0.  HEART, Octane's system
> controller, is widget 0x8.  The four standard XIO slots are numbered (I think)
> as 0x9 to 0xc.  I think widget 0xe is unused.
> 
> The system board has a BRIDGE chip on it to provide the "BaseIO" devices, such
> as two SCSI (QL1040B), IOC3 Ethernet, KB/Mouse, Serial/Parallel, Audio, and an
> RTC.  This BaseIO BRIDGE is widget 0xf, which is what you're seeing with the
> first set of addresses starting with 0x1fxxx.  The second BRIDGE that you're
> seeing is the PCI Shoebox I have installed.  It's widget 0xd, and has addresses
> starting with 0x1dxxx (second nibble from left is the widget), with three
> random PCI cards I found in a storage bin plugged into it.  The Xtalk scan
> happens in reverse order, starting at widget 0xf down to 0x0.
> 
> Both 0x1fxxx and 0x1dxxx addresses are "small window" addresses.  The HEART
> system controller gives you three "windows" into Xtalk space, which uses 48-bit
> addressing:
> 
> 0x0000_1000_0000 - 0x0000_1fff_ffff - Small windows, x16 @ 16MB each
> 0x0008_0000_0000 - 0x000f_ffff_ffff - Medium windows, x16 @ 2GB each
> 0x0010_0000_0000 - 0x00ff_ffff_ffff - Big windows, x15 @ 64GB each
> 
> So a device on widget 0xf mapped into a small window at 0x0000_1fxx_xxxx could
> also be referred to by a big window at address 0x00f0_8xxx_xxxx.  The only
> difference is the big window gives you a larger address space to play around
> with.  Medium windows are not currently used on the IP30 platform in Linux.
> Widget 0x0 (XBOW) is only accessible via small or medium windows.
> 
> As such, this layout in /proc/iomem is oddly correct:
> 
> >   1f200000-1f9fffff : Bridge MEM
> >     f080100000-f0801fffff : 0000:00:02.0
> >     f080010000-f08001ffff : 0000:00:00.0
> >     f080030000-f08003ffff : 0000:00:01.0
> >     f080000000-f080000fff : 0000:00:00.0
> >     f080020000-f080020fff : 0000:00:01.0
> 
> My bug is probably that I do the initial BRIDGE scan with small windows in the
> main BRIDGE driver (arch/mips/pci/pci-bridge.c), and then IP30's BRIDGE glue
> driver (arch/mips/sgi-ip30/ip30-bridge.c) is switching to big windows to probe
> each device.  So, yes, different address ranges, but still looking at the same
> device.  I'll look into fixing that.  It's partially tied to how I was kludging
> the IP27 to also start doing PCI correctly within its own BRIDGE glue driver
> (ip27-bridge.c), but I just learned over the weekend that there's missing
> functionality I have to port over from old 2.5.x-era IA64 code.  In IP30, big
> windows are available by default, but on IP27, what it calls "big windows" need
> to go through some kind of translation table, and I'm trying to figure out how
> to set that up.

I agree, it sounds like the problem is the switch from small windows
to big ones.  In order for the PCI core to work correctly, the host
bridge window ("1f200000-1f9fffff : Bridge MEM") must enclose the BARs
of the devices below the bridge.

If you use the big windows for the device BARs, you should use big
windows for the host bridge windows.  I think we're talking about
widget 0xf here, so the 0xf big window would be 0xf0_0000_0000 -
0xff_ffff_ffff.  This should all be set up *before* calling
pci_scan_root_bus() instead of after, as it seems to be today.

The scan would look like this:

  pci_bus 0000:00: root bus resource [mem 0xf000000000-0xffffffffff] (bus addresses [0x00000000-0xfffffffff])
  pci 0000:00:00.0: reg 0x14: [mem 0xf000200000-0xf000200fff]
  pci 0000:00:00.0: reg 0x30: [mem 0xf000210000-0xf00021ffff pref]
  pci 0000:00:01.0: reg 0x14: [mem 0xf000400000-0xf000400fff]
  pci 0000:00:01.0: reg 0x30: [mem 0xf000410000-0xf00041ffff pref]
  pci 0000:00:02.0: reg 0x10: [mem 0xf000500000-0xf0005fffff]
  pci 0000:00:03.0: reg 0x10: [mem 0xf000600000-0xf000601fff]

This would make /proc/iomem look like this:

  f000000000-ffffffffff : Bridge MEM
    f000500000-f0005fffff : 0000:00:02.0
    f000210000-f00021ffff : 0000:00:00.0
    f000410000-f00041ffff : 0000:00:01.0
    f000200000-f000200fff : 0000:00:00.0
    f000400000-f000400fff : 0000:00:01.0

This doesn't match the device BARs in your /proc/iomem, so there must
be some other transformation going on as well.

As long as you tell the PCI core about the host bridge windows you're
going to use, along with offsets that include *all* these
transformations, the core should just work, and /proc/iomem should
also make sense.  The details of small/medium/big windows, widgets,
etc., are immaterial to the core.

Bjorn
