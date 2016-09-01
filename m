Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:35906 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753086AbcIAVOX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Sep 2016 17:14:23 -0400
MIME-Version: 1.0
In-Reply-To: <CAL-B5D2N_DQCEtJtbq6DtV+6FsrB_4=sb2mO64xv2z4HsrOPhw@mail.gmail.com>
References: <CAL-B5D3FgF+o7BcLBe7O_gcxy2jf3w43bXeDJuRH2VS2ES0A7Q@mail.gmail.com>
 <CAL-B5D2N_DQCEtJtbq6DtV+6FsrB_4=sb2mO64xv2z4HsrOPhw@mail.gmail.com>
From: Myron Stowe <myron.stowe@gmail.com>
Date: Thu, 1 Sep 2016 13:16:53 -0600
Message-ID: <CAL-B5D26mTpfCDD_uPPk6hCZz39HyF5xBDRt9Q4hu9Yn7p1Vvw@mail.gmail.com>
Subject: Re: [RFC] PCI: Unassigned Expansion ROM BARs
To: linux-pci <linux-pci@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Here it is a year later and there has basically been no progress on
this ongoing situation.  I still often encounter bugs raised against
the kernel w.r.t. unmet resource allocations - here is the most recent
example, I'll attach the 'dmesg' log from the platform at
https://bugzilla.kernel.org/show_bug.cgi?id=104931.


Researching device 0000:04:00.3 as it's the device with the issue (and all
other devices/functions under PCI bus 04 due to possible competing resource
needs).


Analysis from v4.7.0 kernel run 'dmesg' log with comments interspersed ...

This platform has two PCI Root Bridges.  Limiting analysis to the first
Root Bridge handling PCI buses 0x00 through 0x7e as it contains the
PCI bus in question - bus 04.

  ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7e])
  PCI host bridge to bus 0000:00
  pci_bus 0000:00: root bus resource [io  0x0000-0x03bb window]
  pci_bus 0000:00: root bus resource [io  0x03bc-0x03df window]
  pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
  pci_bus 0000:00: root bus resource [io  0x1000-0x7fff window]
  pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
  pci_bus 0000:00: root bus resource [mem 0x90000000-0xc7ffbfff window]
  pci_bus 0000:00: root bus resource [mem 0x30000000000-0x33fffffffff window]

CPU addresses falling into the above resource ranges will get intercepted
by the host controller and converted into PCI bus transactions.  Looking
further into the log we find the set of resource ranges (PCI-to-PCI bridge
apertures) corresponding to PCI bus 04.

  pci 0000:00:02.0: PCI bridge to [bus 04]
  pci 0000:00:02.0:   bridge window [io  0x2000-0x2fff]
  pci 0000:00:02.0:   bridge window [mem 0x92000000-0x940fffff]          33M

The following shows what the platforms BIOS programmed into the BARs of
device(s) under PCI bus 04.

  pci 0000:04:00.0: [1924:0923] type 00 class 0x020000
  pci 0000:04:00.0: reg 0x10: [io  0x2300-0x23ff]
  pci 0000:04:00.0: reg 0x18: [mem 0x93800000-0x93ffffff 64bit]         BAR2
  pci 0000:04:00.0: reg 0x20: [mem 0x9400c000-0x9400ffff 64bit]         BAR4
  pci 0000:04:00.0: reg 0x30: [mem 0xfffc0000-0xffffffff pref]          E ROM
  pci 0000:04:00.1: [1924:0923] type 00 class 0x020000
  pci 0000:04:00.1: reg 0x10: [io  0x2200-0x22ff]
  pci 0000:04:00.1: reg 0x18: [mem 0x93000000-0x937fffff 64bit]
  pci 0000:04:00.1: reg 0x20: [mem 0x94008000-0x9400bfff 64bit]
  pci 0000:04:00.1: reg 0x30: [mem 0xfffc0000-0xffffffff pref]
  pci 0000:04:00.2: [1924:0923] type 00 class 0x020000
  pci 0000:04:00.2: reg 0x10: [io  0x2100-0x21ff]
  pci 0000:04:00.2: reg 0x18: [mem 0x92800000-0x92ffffff 64bit]
  pci 0000:04:00.2: reg 0x20: [mem 0x94004000-0x94007fff 64bit]
  pci 0000:04:00.2: reg 0x30: [mem 0xfffc0000-0xffffffff pref]
  pci 0000:04:00.3: [1924:0923] type 00 class 0x020000
  pci 0000:04:00.3: reg 0x10: [io  0x2000-0x20ff]
  pci 0000:04:00.3: reg 0x18: [mem 0x92000000-0x927fffff 64bit]           8M
  pci 0000:04:00.3: reg 0x20: [mem 0x94000000-0x94003fff 64bit]          16K
  pci 0000:04:00.3: reg 0x30: [mem 0xfffc0000-0xffffffff pref]          256K

It's already obvious that the 33M of MMIO space that the PCI-to-PCI bridge
leading to PCI bus 04 provides (0x92000000-0x940fffff) is not enough space
to fully satisfy the MMIO specific addressing needs of all device's BARs
below it - the 4 combined ports - totaling (8M + 16K + 256K) *4) = 33M + 64K.
This is _without_ taking into account any alignment constraints that likely
would increase the buses needed aperture range even further.

Note that the values programmed into the device's Expansion ROM BARs do not
fit within any of its immediately upstream bridge's MMIO related apertures.

  pci 0000:04:00.0: can't claim BAR 6 [mem 0xfffc0000-0xffffffff pref]: no
  compatible bridge window
  pci 0000:04:00.1: can't claim BAR 6 [mem 0xfffc0000-0xffffffff pref]: no
  compatible bridge window
  pci 0000:04:00.2: can't claim BAR 6 [mem 0xfffc0000-0xffffffff pref]: no
  compatible bridge window
  pci 0000:04:00.3: can't claim BAR 6 [mem 0xfffc0000-0xffffffff pref]: no
  compatible bridge window

The kernel notices this and attempts to allocate appropriate space for them
from any remaining, available, MMIO space that meets all the alignment
constraints and such.

  pci 0000:04:00.0: BAR 6: assigned [mem 0x94040000-0x9407ffff pref]
  pci 0000:04:00.1: BAR 6: assigned [mem 0x94080000-0x940bffff pref]
  pci 0000:04:00.2: BAR 6: assigned [mem 0x940c0000-0x940fffff pref]
  pci 0000:04:00.3: BAR 6: no space for [mem size 0x00040000 pref]
  pci 0000:04:00.3: BAR 6: failed to assign [mem size 0x00040000 pref]

The kernel was able to satisfy the first three ports MMIO needs but was
_not_ able to for the last port - there is no remaining available
addressing space within the range to satisfy its needs!

At this point the 0000:04:00.3 device just happens to work by luck due to
the fact that the unmet resource needs correspond to its Expansion ROM
BAR [1].


Next a "user" initiates a PCIe hot-unplug of the device, the bus
is re-scanned and as a result, BAR4 of all 4 of the device's functions fail
getting their appropriate resources allocated.

  pci 0000:00:02.0: PCI bridge to [bus 04]
  pci 0000:00:02.0:   bridge window [io  0x2000-0x2fff]
  pci 0000:00:02.0:   bridge window [mem 0x92000000-0x940fffff]          33M

  pci 0000:04:00.0: BAR 2: assigned [mem 0x92000000-0x927fffff 64bit]
  pci 0000:04:00.1: BAR 2: assigned [mem 0x92800000-0x92ffffff 64bit]
  pci 0000:04:00.2: BAR 2: assigned [mem 0x93000000-0x937fffff 64bit]
  pci 0000:04:00.3: BAR 2: assigned [mem 0x93800000-0x93ffffff 64bit]
  pci 0000:04:00.0: BAR 6: assigned [mem 0x94000000-0x9403ffff pref]
  pci 0000:04:00.1: BAR 6: assigned [mem 0x94040000-0x9407ffff pref]
  pci 0000:04:00.2: BAR 6: assigned [mem 0x94080000-0x940bffff pref]
  pci 0000:04:00.3: BAR 6: assigned [mem 0x940c0000-0x940fffff pref]

At this point -all- available MMIO resource space has been consumed.

  For the more visually inclined (if it's not already obvious).  There's
  probably an easier way to visualize the exhaustion but here is my lame
  attempt:

  PCI Bridge 04's MMIO aperture resource range totals 33M
  ( 0x92000000-0x940fffff ).  The first line below denotes the 33M in
  1M increments (chunks).  The second line denotes the addressing range;
  specifically bytes 7 and 6 withing the resource's range ( 0x9--xxxxx ).
  The last line denotes the port (0 through 3) consuming that portion
  of the resource's range.

   1 2 3 4 5 6 7 8 9101112131415161718192021222324252627282930313233    33M
  202122232425262728292a2b2c2d232f303132333435363738393a3b3c3d3e3f40    [76]
   0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 3 3 3 3 3 3 3 3--

  The last 1M is consumed by a smaller granularity so expanding the
  above conceptualization to a finer level.

  1M of resource range ( 94000000-940fffff ) visualized in 32K increments
  ( bytes 5 and 4; 0x940--xxx ).
   1 2 3 4 5 6 7 8 91011121314151617181920212223242526272829303132       1M
  0008101820283038404850586068707880889098a0a8b0b8c0c8d0d8e0e8f0f8      [54]
   0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 3 3 3 3 3 3 3 3

and the remaining needed resource allocation attempts are going to
fail.

  pci 0000:04:00.0: BAR 4: no space for [mem size 0x00004000 64bit]
  pci 0000:04:00.0: BAR 4: failed to assign [mem size 0x00004000 64bit]
  pci 0000:04:00.1: BAR 4: no space for [mem size 0x00004000 64bit]
  pci 0000:04:00.1: BAR 4: failed to assign [mem size 0x00004000 64bit]
  pci 0000:04:00.2: BAR 4: no space for [mem size 0x00004000 64bit]
  pci 0000:04:00.2: BAR 4: failed to assign [mem size 0x00004000 64bit]
  pci 0000:04:00.3: BAR 4: no space for [mem size 0x00004000 64bit]
  pci 0000:04:00.3: BAR 4: failed to assign [mem size 0x00004000 64bit]
  pci 0000:04:00.0: BAR 0: assigned [io  0x2000-0x20ff]
  pci 0000:04:00.1: BAR 0: assigned [io  0x2400-0x24ff]
  pci 0000:04:00.2: BAR 0: assigned [io  0x2800-0x28ff]
  pci 0000:04:00.3: BAR 0: assigned [io  0x2c00-0x2cff]

At this point none of the four functions (ports) - 0000:04:00.{0..3} were
able to get their necessary resource needs met and thus the device's functions
(NIC ports) do not work.  In fact, I would expect the driver's call into
the kernel's PCI core 'pci_enable_device()' routine to fail [1].


Conclusion ...

The root cause of the issue(s) [2] is the platform's BIOS not providing
enough, and setting up properly, resource needs that the device requires -
specifically MMIO addressing space related resources.  Most notably
conspicuous is the device's Expansion ROM BAR(s) as they are improperly
programmed - the initial BIOS programmed values do not fall within any
valid resource ranges of the immediately upstream PCI-to-PCI Bridge's MMIO
apertures.


As for "symptomatic" solutions (just a band-aid to treat the symptom and
not addressing the root cause) ...

Short of getting the platform's BIOS updated to appropriately account for
the device's total needs, a "compromized" solution has been to get them to
program device's Expansion ROM BAR values with '0'.  This has been
done in the past so why this platform's BIOS engineers have chosen not
to do that
again in this instance is "out of character" and concerning.  If, and only
if, a device's Expansion ROM BAR is programmed with '0', then adding the
"norom" kernel boot parameter will cause the kernel to ignore, and not
attempt to assign resources to, such.

Short of that, drivers can use, and check the return value of,
pci_enable_rom().  That should fail if it's unassigned.  Looking at it, it
only fails if 'flags == 0' so I'm not sure that catches all cases of it
being unassigned.


[1] For a device's normal BARs - the BARs corresponding to the PCI
    specification's "Base Address 0 through 5" Type 0 configuration header
    space entries - that are initially ill programmed and the kernel can
    not subsequently assign appropriate resources for such, then the
    kernel's PCI core subsystem's 'pci_enable_device()' routine should
    fail.

[2] While the analysis only covers one specific device, the 'dmesg' log
    shows that the same base root cause occurs in at least two additional
    instances.
