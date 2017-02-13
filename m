Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751288AbdBMWpU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Feb 2017 17:45:20 -0500
Date: Mon, 13 Feb 2017 16:45:12 -0600
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
Message-ID: <20170213224512.GA8080@bhelgaas-glaptop.roam.corp.google.com>
References: <20170207061356.8270-1-kumba@gentoo.org>
 <20170207061356.8270-13-kumba@gentoo.org>
 <CAErSpo6yKAE1_c1eZJapnjD1g0pocyOxed3_Eumdp_026uhDuA@mail.gmail.com>
 <eafc94c6-1931-e2ce-7e03-d84d8e181e81@gentoo.org>
 <CAErSpo4LsrPCtdZwp6CyT0jKhXLt3j=fGSiFjpRRTPUjFoKHtQ@mail.gmail.com>
 <c7ed6a1d-f625-d294-8910-dd2d93d34292@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c7ed6a1d-f625-d294-8910-dd2d93d34292@gentoo.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It looks like IP30 is using some code that's not upstream yet, so I'll
just point out some things that don't look right.  I'm ignoring the
IP27 stuff here in case that has different issues.

Joshua wrote:
> On 02/07/2017 13:29, Bjorn Helgaas wrote:
>> Is there any chance you can collect complete dmesg logs and
>> /proc/iomem contents from IP27 and IP30?  Maybe "lspci -vv" output,
>> too?  I'm not sure where to look to understand the ioremap() behavior.
> 
> ...
> A note about IP30, since that's part of an external patch set, the
> dmesg output is a little different, as it is using the newer
> BRIDGE/Xtalk code I just sent in as patches.  ...
> 
> Also, IP30 doesn't use the PCI_PROBE_ONLY thing anymore.  This causes
> /proc/iomem to be far more detailed than it used to be.
> 
> IP30's /proc/iomem:
>     00000000-00003fff : reserved
>     1d200000-1d9fffff : Bridge MEM
>       d080000000-d080003fff : 0001:00:03.0
>       1d204000-1d204fff : 0001:00:02.0
>       1d205000-1d205fff : 0001:00:02.1
>       1d206000-1d206fff : 0001:00:02.2
>       1d207000-1d2070ff : 0001:00:02.3
>       1d207100-1d20717f : 0001:00:01.0
>     1f200000-1f9fffff : Bridge MEM
>       f080100000-f0801fffff : 0000:00:02.0
>       f080010000-f08001ffff : 0000:00:00.0
>       f080030000-f08003ffff : 0000:00:01.0
>       f080000000-f080000fff : 0000:00:00.0
>       f080020000-f080020fff : 0000:00:01.0
>     20004000-209b8fff : reserved
>       20004000-206acb13 : Kernel code
>       206acb14-208affff : Kernel data
>     209b9000-20efffff : System RAM
>     20f00000-20ffffff : System RAM
>     21000000-9fffffff : System RAM
>     f080100000-f0801fffff : ioc3

>From the dmesg you attached (ip30-dmesg-20170208.txt, PCI parts
appended below):

  pci_bus 0000:00: root bus resource [mem 0x1f200000-0x1f9fffff]
  pci_bus 0001:00: root bus resource [mem 0x1d200000-0x1d9fffff]

These are shown correctly in /proc/iomem.  It would be nice if the
/proc/iomem string identified which bridge was which (x86 uses "PCI
Bus 0000:00", "PCI Bus 0001:00", etc.) but that's not essential.

  pci 0001:00:03.0: BAR 0: assigned [mem 0x1d200000-0x1d203fff]
  ip30-bridge: 0001:00:03.0 Bar 0 with size 0x00004000 at bus 0x00000000 vma 0x000000d080000000 is Direct 64-bit.

This is funky.  We read 0x1d200000 from the BAR (PCI bus addresses are
apparently identical to CPU physical addresses).  We claimed that
space from the host bridge window, so /proc/iomem would have looked
like this at that point:

  1d200000-1d9fffff : Bridge MEM
    1d200000-1d203fff : 0001:00:03.0

But it looks like whatever this ip30-bridge thing is overwrote the
0001:00:03.0 resource, which makes /proc/iomem wrong.

All the resources under the bridge to 0000:00 are wrong, too:

  1f200000-1f9fffff : Bridge MEM
    f080100000-f0801fffff : 0000:00:02.0
    f080010000-f08001ffff : 0000:00:00.0
    f080030000-f08003ffff : 0000:00:01.0
    f080000000-f080000fff : 0000:00:00.0
    f080020000-f080020fff : 0000:00:01.0

We read values from the BARs:

  pci_bus 0000:00: root bus resource [mem 0x1f200000-0x1f9fffff]
  pci 0000:00:00.0: reg 0x14: [mem 0x00200000-0x00200fff]
  pci 0000:00:00.0: reg 0x30: [mem 0x00210000-0x0021ffff pref]
  pci 0000:00:01.0: reg 0x14: [mem 0x00400000-0x00400fff]
  pci 0000:00:01.0: reg 0x30: [mem 0x00410000-0x0041ffff pref]
  pci 0000:00:02.0: reg 0x10: [mem 0x00500000-0x005fffff]
  pci 0000:00:03.0: reg 0x10: [mem 0x00600000-0x00601fff]

These aren't zero, so somebody apparently has assigned them, but they
aren't inside the host bridge window.  Therefore the PCI core assumes
they will not work, and it reassigns space from the window:

  pci 0000:00:02.0: BAR 0: assigned [mem 0x1f200000-0x1f2fffff]
  pci 0000:00:00.0: BAR 6: assigned [mem 0x1f300000-0x1f30ffff pref]
  pci 0000:00:01.0: BAR 6: assigned [mem 0x1f310000-0x1f31ffff pref]
  pci 0000:00:00.0: BAR 1: assigned [mem 0x1f320000-0x1f320fff]
  pci 0000:00:01.0: BAR 1: assigned [mem 0x1f321000-0x1f321fff]

I don't know why we didn't assign space to 0000:00:03.0 BAR 1.

Anyway, it looks like they got inserted in /proc/iomem, then
overwritten by the ip30-bridge stuff again.

>From /proc/iomem, I would expect that only the USB devices (0001:00:02
functions 0, 1, 2, 3) would work.  But apparently your system does
actually work, so there must be corresponding funkiness somewhere else
that compensates for these resources.

I'm attaching the PCI parts of your ip30-dmesg-20170208.txt and the
complete ip30-lspci-20170208.txt below for context.

  pci_bus 0000:00: root bus resource [mem 0x1f200000-0x1f9fffff]
  pci_bus 0000:00: root bus resource [io  0x1fa00000-0x1fbfffff]
  pci_bus 0000:00: root bus resource [bus 00-ff]
  pci 0000:00:00.0: [1077:1020] type 00 class 0x010000
  pci 0000:00:00.0: reg 0x10: [io  0x200000-0x2000ff]
  pci 0000:00:00.0: reg 0x14: [mem 0x00200000-0x00200fff]
  pci 0000:00:00.0: reg 0x30: [mem 0x00210000-0x0021ffff pref]
  pci 0000:00:01.0: [1077:1020] type 00 class 0x010000
  pci 0000:00:01.0: reg 0x10: [io  0x400000-0x4000ff]
  pci 0000:00:01.0: reg 0x14: [mem 0x00400000-0x00400fff]
  pci 0000:00:01.0: reg 0x30: [mem 0x00410000-0x0041ffff pref]
  pci 0000:00:02.0: [10a9:0003] type 00 class 0xff0000
  pci 0000:00:02.0: reg 0x10: [mem 0x00500000-0x005fffff]
  pci 0000:00:03.0: [10a9:0005] type 00 class 0x000000
  pci 0000:00:03.0: reg 0x10: [mem 0x00600000-0x00601fff]
  pci 0000:00:02.0: BAR 0: assigned [mem 0x1f200000-0x1f2fffff]
  pci 0000:00:00.0: BAR 6: assigned [mem 0x1f300000-0x1f30ffff pref]
  pci 0000:00:01.0: BAR 6: assigned [mem 0x1f310000-0x1f31ffff pref]
  pci 0000:00:00.0: BAR 1: assigned [mem 0x1f320000-0x1f320fff]
  pci 0000:00:01.0: BAR 1: assigned [mem 0x1f321000-0x1f321fff]
  pci 0000:00:00.0: BAR 0: assigned [io  0x1fa00000-0x1fa000ff]
  pci 0000:00:01.0: BAR 0: assigned [io  0x1fa00400-0x1fa004ff]

  ip30-bridge: 0000:00:00.0 Bar 0 with size 0x00000100 at bus 0x00000000 vma 0x000000f100000000 is Direct I/O.
  ip30-bridge: 0000:00:00.0 Bar 1 with size 0x00001000 at bus 0x00000000 vma 0x000000f080000000 is Direct 64-bit.
  ip30-bridge: 0000:00:00.0 Bar 6 with size 0x00010000 at bus 0x00010000 vma 0x000000f080010000 is Direct 64-bit.

  ip30-bridge: 0000:00:01.0 Bar 0 with size 0x00000100 at bus 0x00000100 vma 0x000000f100000100 is Direct I/O.
  ip30-bridge: 0000:00:01.0 Bar 1 with size 0x00001000 at bus 0x00020000 vma 0x000000f080020000 is Direct 64-bit.
  ip30-bridge: 0000:00:01.0 Bar 6 with size 0x00010000 at bus 0x00030000 vma 0x000000f080030000 is Direct 64-bit.

  ip30-bridge: 0000:00:02.0 Bar 0 with size 0x00100000 at bus 0x00100000 vma 0x000000f080100000 is Direct 64-bit.

  PCI host bridge to bus 0001:00
  pci_bus 0001:00: root bus resource [mem 0x1d200000-0x1d9fffff]
  pci_bus 0001:00: root bus resource [io  0x1da00000-0x1dbfffff]
  pci_bus 0001:00: root bus resource [bus 01-ff]
  pci 0001:00:01.0: [11fe:080e] type 00 class 0x078000
  pci 0001:00:01.0: reg 0x10: [mem 0x00200000-0x0020007f]
  pci 0001:00:01.0: reg 0x14: [io  0x200000-0x20007f]
  pci 0001:00:01.0: reg 0x18: [io  0x204000-0x2040ff]
  pci 0001:00:02.0: [10b9:5237] type 00 class 0x0c0310
  pci 0001:00:02.0: reg 0x10: [mem 0x00300000-0x00300fff]
  pci 0001:00:02.0: PME# supported from D0 D1 D3hot D3cold
  pci 0001:00:02.1: [10b9:5237] type 00 class 0x0c0310
  pci 0001:00:02.1: reg 0x10: [mem 0x00000000-0x00000fff]
  pci 0001:00:02.1: PME# supported from D0 D1 D3hot D3cold
  pci 0001:00:02.2: [10b9:5237] type 00 class 0x0c0310
  pci 0001:00:02.2: reg 0x10: [mem 0x00000000-0x00000fff]
  pci 0001:00:02.2: PME# supported from D0 D1 D3hot D3cold
  pci 0001:00:02.3: [10b9:5239] type 00 class 0x0c0320
  pci 0001:00:02.3: reg 0x10: [mem 0x00000000-0x000000ff]
  pci 0001:00:02.3: PME# supported from D0 D3hot D3cold
  pci 0001:00:03.0: [10a9:0009] type 00 class 0x020000
  pci 0001:00:03.0: reg 0x10: [mem 0x00400000-0x00403fff]
  pci 0001:00:03.0: BAR 0: assigned [mem 0x1d200000-0x1d203fff]
  pci 0001:00:02.0: BAR 0: assigned [mem 0x1d204000-0x1d204fff]
  pci 0001:00:02.1: BAR 0: assigned [mem 0x1d205000-0x1d205fff]
  pci 0001:00:02.2: BAR 0: assigned [mem 0x1d206000-0x1d206fff]
  pci 0001:00:01.0: BAR 2: assigned [io  0x1da00000-0x1da000ff]
  pci 0001:00:02.3: BAR 0: assigned [mem 0x1d207000-0x1d2070ff]
  pci 0001:00:01.0: BAR 0: assigned [mem 0x1d207100-0x1d20717f]
  pci 0001:00:01.0: BAR 1: assigned [io  0x1da00400-0x1da0047f]

  ip30-bridge: 0001:00:03.0 Bar 0 with size 0x00004000 at bus 0x00000000 vma 0x000000d080000000 is Direct 64-bit.


Here's the ip30-lspci-20170208.txt attachment from your mail:


0000:00:00.0 SCSI storage controller: QLogic Corp. ISP1020 Fast-wide SCSI (rev 05)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64, Cache Line Size: 256 bytes
        Interrupt: pin A routed to IRQ 0
        Region 0: I/O ports at f100000000 [size=257]
        Region 1: [virtual] Memory at f080000000 (32-bit, non-prefetchable) [size=4097]
        Region 2: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
        Region 3: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
        Region 4: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
        Region 5: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
        Expansion ROM at f080010000 [disabled] [size=65537]
        Kernel driver in use: qla1280
lspci: Unable to load libkmod resources: error -12

0000:00:01.0 SCSI storage controller: QLogic Corp. ISP1020 Fast-wide SCSI (rev 05)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64, Cache Line Size: 256 bytes
        Interrupt: pin A routed to IRQ 1
        Region 0: I/O ports at f100000100 [size=257]
        Region 1: Memory at f080020000 (32-bit, non-prefetchable) [size=4097]
        Region 2: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
        Region 3: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
        Region 4: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
        Region 5: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
        Expansion ROM at f080030000 [disabled] [size=65537]
        Kernel driver in use: qla1280

0000:00:02.0 Unassigned class [ff00]: Silicon Graphics Intl. Corp. IOC3 I/O controller (rev 01)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64
        Interrupt: pin A routed to IRQ 2
        Region 0: Memory at f080100000 (32-bit, non-prefetchable) [size=1048577]
        Region 1: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
        Region 2: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
        Region 3: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
        Region 4: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
        Region 5: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
        Expansion ROM at <unassigned> [disabled] [size=2]
        Kernel driver in use: IOC3

0000:00:03.0 Non-VGA unclassified device: Silicon Graphics Intl. Corp. RAD Audio (rev c0)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort+ <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 255
        Region 0: Memory at 00600000 (32-bit, non-prefetchable) [size=8193]
        Region 1: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
        Region 2: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
        Region 3: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
        Region 4: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
        Region 5: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
        Expansion ROM at <unassigned> [disabled] [size=2]

0001:00:01.0 Communication controller: Comtrol Corporation Device 080e (rev 01)
        Subsystem: Comtrol Corporation Device 080e
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at 1d207100 (32-bit, non-prefetchable) [size=129]
        Region 1: I/O ports at 1da00400 [size=129]
        Region 2: I/O ports at 1da00000 [size=257]
        Region 3: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
        Region 4: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
        Region 5: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
        Expansion ROM at <unassigned> [disabled] [size=2]

0001:00:02.0 USB controller: ULi Electronics Inc. USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
        Subsystem: ULi Electronics Inc. ASRock 939Dual-SATA2 Motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 16 (20000ns max)
        Interrupt: pin B routed to IRQ 0
        Region 0: Memory at 1d204000 (32-bit, non-prefetchable) [size=4097]
        Region 1: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
        Region 2: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
        Region 3: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
        Region 4: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
        Region 5: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
        Expansion ROM at <unassigned> [disabled] [size=2]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

0001:00:02.1 USB controller: ULi Electronics Inc. USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
        Subsystem: ULi Electronics Inc. ASRock 939Dual-SATA2 Motherboard
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin C routed to IRQ 0
        Region 0: Memory at 1d205000 (32-bit, non-prefetchable) [disabled] [size=4097]
        Region 1: Memory at <unassigned> (32-bit, non-prefetchable) [disabled] [size=2]
        Region 2: Memory at <unassigned> (32-bit, non-prefetchable) [disabled] [size=2]
        Region 3: Memory at <unassigned> (32-bit, non-prefetchable) [disabled] [size=2]
        Region 4: Memory at <unassigned> (32-bit, non-prefetchable) [disabled] [size=2]
        Region 5: Memory at <unassigned> (32-bit, non-prefetchable) [disabled] [size=2]
        Expansion ROM at <unassigned> [disabled] [size=2]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

0001:00:02.2 USB controller: ULi Electronics Inc. USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
        Subsystem: ULi Electronics Inc. ASRock 939Dual-SATA2 Motherboard
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin D routed to IRQ 0
        Region 0: Memory at 1d206000 (32-bit, non-prefetchable) [disabled] [size=4097]
        Region 1: Memory at <unassigned> (32-bit, non-prefetchable) [disabled] [size=2]
        Region 2: Memory at <unassigned> (32-bit, non-prefetchable) [disabled] [size=2]
        Region 3: Memory at <unassigned> (32-bit, non-prefetchable) [disabled] [size=2]
        Region 4: Memory at <unassigned> (32-bit, non-prefetchable) [disabled] [size=2]
        Region 5: Memory at <unassigned> (32-bit, non-prefetchable) [disabled] [size=2]
        Expansion ROM at <unassigned> [disabled] [size=2]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

0001:00:02.3 USB controller: ULi Electronics Inc. USB 2.0 Controller (rev 01) (prog-if 20 [EHCI])
        Subsystem: ULi Electronics Inc. ASRock 939Dual-SATA2 Motherboard
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at 1d207000 (32-bit, non-prefetchable) [disabled] [size=257]
        Region 1: Memory at <unassigned> (32-bit, non-prefetchable) [disabled] [size=2]
        Region 2: Memory at <unassigned> (32-bit, non-prefetchable) [disabled] [size=2]
        Region 3: Memory at <unassigned> (32-bit, non-prefetchable) [disabled] [size=2]
        Region 4: Memory at <unassigned> (32-bit, non-prefetchable) [disabled] [size=2]
        Region 5: Memory at <unassigned> (32-bit, non-prefetchable) [disabled] [size=2]
        Expansion ROM at <unassigned> [disabled] [size=2]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Debug port: BAR=1 offset=0090

0001:00:03.0 Ethernet controller: Silicon Graphics Intl. Corp. AceNIC Gigabit Ethernet (rev 01)
        Subsystem: Silicon Graphics Intl. Corp. AceNIC Gigabit Ethernet
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64 (16000ns min), Cache Line Size: 128 bytes
        Interrupt: pin A routed to IRQ 4
        Region 0: [virtual] Memory at d080000000 (32-bit, non-prefetchable) [size=16385]
        Region 1: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
        Region 2: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
        Region 3: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
        Region 4: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
        Region 5: Memory at <unassigned> (32-bit, non-prefetchable) [size=2]
        Expansion ROM at <unassigned> [disabled] [size=2]
        Kernel driver in use: acenic
