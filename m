Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:35288 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755794AbbIXCrI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Sep 2015 22:47:08 -0400
MIME-Version: 1.0
Date: Wed, 23 Sep 2015 20:47:07 -0600
Message-ID: <CAL-B5D3FgF+o7BcLBe7O_gcxy2jf3w43bXeDJuRH2VS2ES0A7Q@mail.gmail.com>
Subject: [RFC] PCI: Unassigned Expansion ROM BARs
From: Myron Stowe <myron.stowe@gmail.com>
To: linux-pci <linux-pci@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I've encountered numerous bugzilla reports related to platform BIOS' not
programming valid values into a PCI device's Type 0 Configuration space
"Expansion ROM Base Address" field (a.k.a. Expansion ROM BAR).  The main
observed consequence being 'dmesg' entries like the following that get
customers excited enough to file reports against the kernel.

  pci 0000:01:00.0: can't claim BAR 6 [mem 0xfff00000-0xffffffff pref]:
    no compatible bridge window
  pci 0000:04:03.0: can't claim BAR 6 [mem 0xffff0000-0xffffffff pref]:
    no compatible bridge window

After I've provided an analysis similar to [1] the respective BIOS response
(teams from two of the major vendors) is typically:
   "The OS has no business touching the Expansion ROM BARs and it
    provides no value to the equation here.  The Expansion ROM BAR
    is only useful in pre-boot for the BIOS to get boot code from
    a device."

This scenario has occurred enough times now that I'd like to attempt to
"raise the bar" and invite a technically merit based discussion concerning
this topic - via a public forum that is archived and provides a source of
reference for use upon future occurrences - and see if a consensus can be
reached between the various vendor's BIOS engineers and kernel engineers.


A little more background context -

The kernel expects device Expansion ROM BARs to be programmed with valid
values - even if the respective Expansion ROM's Enable bit is 0 (i.e. the
device’s expansion ROM address space is disabled).  This seems to be the
main contention point with said BIOS engineers.  If an Expansion ROM BAR is
not programmed, the kernel will attempt to find available resources and, if
successful, program it.  As this occurs various 'dmesg' entries
related to kernel's actions are output.

Note that for devices that share decoders between the Expansion ROM BAR and
other BARs the firmware (probably) should not enable the Expansion ROM BAR
at hand-off to the operating system (see the last paragraph of the PCI
Firmware Specification, Rev 3.2, Section 3.5 "Device State at
Firmware/Operating System Handoff").

There is a kernel boot parameter, pci=norom, that is intended to disable the
kernel's resource assignment actions for Expansion ROMs that do not already
have BIOS assigned address ranges.  Note however, if I remember correctly,
that this only works if the Expansion ROM BAR is set to "0" by the BIOS
before hand-off.


I've opened https://bugzilla.kernel.org/show_bug.cgi?id=104931 and attached
the full 'dmesg' that exhibits a typical occurrence as an example.  I'd like
to use the bugzilla to archive any discussion that takes place.   I'll copy all
relevant discussion that takes place here into the bugzilla as "Additional
Comments".

Please continue with this thread, adding your views in these regards.  Citing's
from pertinent specifications that back up your position would be appreciated.

Thanks,
 Myron



[1]  Annotated 'dmesg' log concerning Expansion ROM BARs not setup by BIOS

The "can't claim" messages of interest are:
  pci 0000:01:00.0: can't claim BAR 6 [mem 0xfff00000-0xffffffff pref]:
  no compatible bridge window
  pci 0000:04:03.0: can't claim BAR 6 [mem 0xffff0000-0xffffffff pref]:
  no compatible bridge window

The PCI devices of interest are a device at PCI Bus 1, Device 0, Function
0 (01:00.0) and another device at PCI Bus 4, Device 3, Function 0 (04:03.0).

The "root bridge" that leads to PCI buses 1 and 4 - the buses of interest -
is "PCI0" and its I/O Port space and Memory Mapped I/O (MMIO) space are:

 ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
 PCI host bridge to bus 0000:00
 pci_bus 0000:00: root bus resource [bus 00-fe]
 pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
 pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
 pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
 pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfeafffff]

It's helpful to gather up all the resource related information pertaining to
the devices of interest in one place.  Concentrating on the PCI-to-PCI
bridges and individual PCI devices that lead to 01:00.0, the first device
exhibiting the "can't claim" message (everything that is consuming resources
on PCI bus 0 and PCI bus 1):

    pci 0000:00:1a.0: [8086:1c2d] type 00 class 0x0c0320
    pci 0000:00:1a.0: reg 0x10: [mem 0xc1305000-0xc13053ff]

    pci 0000:00:1d.0: [8086:1c26] type 00 class 0x0c0320
    pci 0000:00:1d.0: reg 0x10: [mem 0xc1304000-0xc13043ff]

    pci 0000:00:1f.2: [8086:1c00] type 00 class 0x01018f
    pci 0000:00:1f.2: reg 0x10: [io  0x3078-0x307f]
    pci 0000:00:1f.2: reg 0x14: [io  0x308c-0x308f]
    pci 0000:00:1f.2: reg 0x18: [io  0x3070-0x3077]
    pci 0000:00:1f.2: reg 0x1c: [io  0x3088-0x308b]
    pci 0000:00:1f.2: reg 0x20: [io  0x3050-0x305f]
    pci 0000:00:1f.2: reg 0x24: [io  0x3040-0x304f]

    pci 0000:00:1f.3: [8086:1c22] type 00 class 0x0c0500
    pci 0000:00:1f.3: reg 0x10: [mem 0xc1302000-0xc13020ff 64bit]
    pci 0000:00:1f.3: reg 0x20: [io  0x3000-0x301f]

    pci 0000:00:1f.5: [8086:1c08] type 00 class 0x010185
    pci 0000:00:1f.5: reg 0x10: [io  0x3068-0x306f]
    pci 0000:00:1f.5: reg 0x14: [io  0x3084-0x3087]
    pci 0000:00:1f.5: reg 0x18: [io  0x3060-0x3067]
    pci 0000:00:1f.5: reg 0x1c: [io  0x3080-0x3083]
    pci 0000:00:1f.5: reg 0x20: [io  0x3030-0x303f]
    pci 0000:00:1f.5: reg 0x24: [io  0x3020-0x302f]

  pci 0000:00:01.0: PCI bridge to [bus 01]
  pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
  pci 0000:00:01.0:   bridge window [mem 0xc1200000-0xc12fffff]

    pci 0000:01:00.0: [1000:0072] type 00 class 0x010700
      [1000:0072] - LSI (Symbios) Logic : SAS2008 PCIe Fusion-MPT SAS-2
    pci 0000:01:00.0: reg 0x10: [io  0x2000-0x20ff]
    pci 0000:01:00.0: reg 0x14: [mem 0xc1240000-0xc124ffff 64bit]
    pci 0000:01:00.0: reg 0x1c: [mem 0xc1200000-0xc123ffff 64bit]
x   pci 0000:01:00.0: reg 0x30: [mem 0xfff00000-0xffffffff pref]


The PCI-to-PCI bridge device for Bus 0 to Bus 1 only has one memory space
apeture ("bridge window") active - [mem 0xc1200000-0xc12fffff].  This must
be a subset of one of the "root bus" memory resources and looking at those,
it is.

The target device - 01:00.0; an 'mpt2sas' device - consumes three memory
ranges.  These correspond to the device's BAR 1 and 2 (64 bit addresses
consume two BAR registers), BAR 3 and 4, and the "Expansion ROM Base Address
(a.k.a. BAR 6).  These also must be a subset of both the corresponding root
bus resources and all PCI-to-PCI bridge devices in the PCI hiearchy leading
to the device itself.  Looking at them we see that the first two satisfy the
requirement but the third - [mem 0xfff00000-0xffffffff pref] - does not!
It's because the "Expansion ROM Base Address" register (a.k.a. BAR 6) does
not adhear to the subset requirement(s) that the kernel later outputs:

 pci 0000:01:00.0: can't claim BAR 6 [mem 0xfff00000-0xffffffff pref]:
 no compatible bridge window
 pci 0000:01:00.0: BAR 6: no space for [mem size 0x00100000 pref]
 pci 0000:01:00.0: BAR 6: failed to assign [mem size 0x00100000 pref]

The "can't claim" message is the kernel alerting us that the BIOS has not
correctly set up resources that fulfill all the requirements (subset,
alignment, type, ...).

The kernel then "sizes" the BAR to see how much address space that BAR
requires - in this case we see BAR 6 of 01:00.0 needs 1 MB of contiguous
space - and subsequently tries to work around the BIOS' failure, attempting
to find available, currently unused, resource space that meets all the
requirements which is where the "no space for" message comes from.

There is no contiguous space that meets all the requirements (subset,
alignment, type, ...) available which is fairly easy to see here; there was
only a 1 MB memory aperture provided by the PCI-to-PCI bridge device to
begin with and the 01:00.0 device consumed subsets of that for BARs 1 and 3
so there is no way 1 MB remains free to satisfy BAR 6's needs.  And so the
kernel outputs the "failed to assign" message.


In a very similar scenario, the 04:03.0 device also has not been properly
set up by BIOS ([mem 0xffff0000-0xffffffff pref]).  The difference in this
case is that there were enough available resources left to satisfy all the
subset, alignment, type, ..., requirements and thus the kernel was able to
allocate from such and re-program the device's BAR 6 ([mem
0xc1010000-0xc101ffff pref]) so that the device can function correctly.

  pci 0000:00:1e.0: PCI bridge to [bus 04] (subtractive decode)
  pci 0000:00:1e.0:   bridge window [mem 0xc0800000-0xc10fffff]
  pci 0000:00:1e.0:   bridge window [mem 0xc0000000-0xc07fffff 64bit pref]
  pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7] (subtractive decode)
  pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff] (subtractive decode)
  pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff] (subtract d)
  pci 0000:00:1e.0:   bridge window [mem 0xc0000000-0xfeafffff] (subtract d)

    pci 0000:04:03.0: [102b:0532] type 00 class 0x030000
      [102b:0532] - Matrox : MGS G200eW WPCM450 (Graphics)
    pci 0000:04:03.0: reg 0x10: [mem 0xc0000000-0xc07fffff pref]
    pci 0000:04:03.0: reg 0x14: [mem 0xc1000000-0xc1003fff]
    pci 0000:04:03.0: reg 0x18: [mem 0xc0800000-0xc0ffffff]
x   pci 0000:04:03.0: reg 0x30: [mem 0xffff0000-0xffffffff pref]

 pci 0000:04:03.0: can't claim BAR 6 [mem 0xffff0000-0xffffffff pref]:
 no compatible bridge window
 pci 0000:04:03.0: BAR 6: assigned [mem 0xc1010000-0xc101ffff pref]
