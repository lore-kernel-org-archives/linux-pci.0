Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:59300 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751175AbcFVHEo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 22 Jun 2016 03:04:44 -0400
Message-ID: <1466579045.4089.22.camel@kernel.crashing.org>
Subject: PCI resource allocation not using pref 64-bit
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Date: Wed, 22 Jun 2016 17:04:05 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi folks !

So on my POWER9 simulator, I noticed that the PCI code isn't assigning
any BAR to my 64-bit prefetchable window.

This is the trimmed log. Focus on domain 0000, the devices on domain
0001 are 32-bit only. I've also appended an lspci output and a
/proc/iomem output.

I think all that is needed but feel free to ask me if you want more. 

You can see that I pass 2 windows for the root bridge, a 32-bit
one and a prefetchable 64-bit one. It's PCIe so anything 64-bit should
be able to hit the prefetchable 64-bit one but that isn't happening.

Note that PCI_REASSIGN_ALL_RSRC is set, the original setup of the
bridges (including the root complex) is to have base > limit, we
expect Linux to fix them up.

Do you have any idea what's going on ? Is that expected ?

Cheers,
Ben.

[    0.000000] Linux version 4.7.0-rc4-00029-gf55fbbe9-dirty (benh@pasglop) (gcc
 version 6.1.1 20160427 (Red Hat Cross 6.1.1-1) (GCC) ) #50 SMP Wed Jun 22 16:18
:18 AEST 2016
[    0.000000] Initializing IODA3 OPAL PHB /pciex@600c3c0000000
[    0.000000] PCI host bridge /pciex@600c3c0000000 (primary) ranges:
[    0.000000]  MEM 0x000600c000000000..0x000600c07ffeffff -> 0x0000000080000000
[    0.000000]  MEM 0x0006000000000000..0x0006001fffffffff -> 0x0006000000000000 (M64 #1..31)
[    0.000000]  Using M64 #31 as default window
[    0.000000]   256 (255) PE's M32: 0x80000000 [segment=0x800000]
[    0.000000]                  M64: 0x2000000000 [segment=0x20000000]
[    0.000000]   Allocated bitmap for 4088 MSIs (base IRQ 0xfe000)
[    0.000000] Initializing IODA3 OPAL PHB /pciex@600c3c0100000
[    0.000000] PCI host bridge /pciex@600c3c0100000  ranges:
[    0.000000]  MEM 0x000600c080000000..0x000600c0fffeffff -> 0x0000000080000000
[    0.000000]  MEM 0x0006002000000000..0x0006003fffffffff -> 0x0006002000000000 (M64 #1..15)
[    0.000000]  Using M64 #15 as default window
[    0.000000]   128 (127) PE's M32: 0x80000000 [segment=0x1000000]
[    0.000000]                  M64: 0x2000000000 [segment=0x40000000]
[    0.000000]   Allocated bitmap for 2040 MSIs (base IRQ 0xfd800)
[    0.000000] Top of RAM: 0x80000000, Total RAM: 0x80000000
  .../...
[    0.030521] PCI: Probing PCI hardware
[    0.030632] PCI: I/O resource not set for host bridge /pciex@600c3c0000000 (domain 0)
[    0.031040] PCI host bridge to bus 0000:00
[    0.031181] pci_bus 0000:00: root bus resource [mem 0x600c000000000-0x600c07ffeffff] (bus address [0x80000000-0xfffeffff])
[    0.031407] pci_bus 0000:00: root bus resource [mem 0x6000000000000-0x6001fdfffffff 64bit pref]
[    0.031657] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.031760] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to ff
[    0.032028] pci 0000:00:00.0: [1014:04c1] type 01 class 0x060400
[    0.032455] pci 0000:00:00.0: PME# supported from D0 D3hot
[    0.033466] pci 0000:01:00.0: [1014:033d] type 00 class 0x010400
[    0.033708] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x0003ffff 64bit]
[    0.033965] pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x00ffffff 64bit pref]
[    0.034227] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x007fffff pref]
[    0.035008] pci 0000:00:00.0: PCI bridge to [bus 01]
[    0.035263] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 01
[    0.035424] PCI: I/O resource not set for host bridge /pciex@600c3c0100000 (domain 1)
[    0.035887] PCI host bridge to bus 0001:00
[    0.035980] pci_bus 0001:00: root bus resource [mem 0x600c080000000-0x600c0fffeffff] (bus address [0x80000000-0xfffeffff])
[    0.036229] pci_bus 0001:00: root bus resource [mem 0x6002000000000-0x6003fbfffffff 64bit pref]
[    0.036431] pci_bus 0001:00: root bus resource [bus 00-ff]
[    0.036582] pci_bus 0001:00: busn_res: [bus 00-ff] end is updated to ff
[    0.036803] pci 0001:00:00.0: [1014:04c1] type 01 class 0x060400
[    0.037277] pci 0001:00:00.0: PME# supported from D0 D3hot
[    0.038243] pci 0001:01:00.0: [8086:105e] type 00 class 0x020000
[    0.038446] pci 0001:01:00.0: reg 0x10: [mem 0x00000000-0x0001ffff]
[    0.038687] pci 0001:01:00.0: reg 0x14: [mem 0x00000000-0x0003ffff]
[    0.038880] pci 0001:01:00.0: reg 0x18: [mem 0x00000000-0x0000ffff]
[    0.039150] pci 0001:01:00.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    0.039987] pci 0001:01:00.1: [8086:105e] type 00 class 0x020000
[    0.040192] pci 0001:01:00.1: reg 0x10: [mem 0x00000000-0x0001ffff]
[    0.040385] pci 0001:01:00.1: reg 0x14: [mem 0x00000000-0x0003ffff]
[    0.040626] pci 0001:01:00.1: reg 0x18: [mem 0x00000000-0x0000ffff]
[    0.040899] pci 0001:01:00.1: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    0.041697] pci 0001:00:00.0: PCI bridge to [bus 01]
[    0.041984] pci_bus 0001:00: busn_res: [bus 00-ff] end is updated to 01
[    0.042230] pci 0000:00:00.0: BAR 8: assigned [mem 0x600c000000000-0x600c0007fffff]
[    0.042421] pci 0000:00:00.0: BAR 9: assigned [mem 0x600c000800000-0x600c001ffffff pref]
[    0.042620] pci 0000:01:00.0: BAR 2: assigned [mem 0x600c001000000-0x600c001ffffff 64bit pref]
[    0.042900] pci 0000:01:00.0: BAR 6: assigned [mem 0x600c000800000-0x600c000ffffff pref]
[    0.043095] pci 0000:01:00.0: BAR 0: assigned [mem 0x600c000000000-0x600c00003ffff 64bit]
[    0.043304] pci 0000:00:00.0: PCI bridge to [bus 01]
[    0.043465] pci 0000:00:00.0:   bridge window [mem 0x600c000000000-0x600c0007fffff]
[    0.043675] pci 0000:00:00.0:   bridge window [mem 0x600c000800000-0x600c001ffffff pref]
[    0.043925] pci_bus 0000:00: resource 4 [mem 0x600c000000000-0x600c07ffeffff]
[    0.044112] pci_bus 0000:00: resource 5 [mem 0x6000000000000-0x6001fdfffffff 64bit pref]
[    0.044300] pci_bus 0000:01: resource 1 [mem 0x600c000000000-0x600c0007fffff]
[    0.044487] pci_bus 0000:01: resource 2 [mem 0x600c000800000-0x600c001ffffff pref]
[    0.044698] pci 0001:00:00.0: BAR 8: assigned [mem 0x600c080000000-0x600c080ffffff]
[    0.044889] pci 0001:00:00.0: BAR 9: assigned [mem 0x600c081000000-0x600c081ffffff pref]
[    0.045137] pci 0001:01:00.0: BAR 1: assigned [mem 0x600c080000000-0x600c08003ffff]
[    0.045334] pci 0001:01:00.1: BAR 1: assigned [mem 0x600c080040000-0x600c08007ffff]
[    0.045531] pci 0001:01:00.0: BAR 0: assigned [mem 0x600c080080000-0x600c08009ffff]
[    0.045729] pci 0001:01:00.0: BAR 6: assigned [mem 0x600c081000000-0x600c08101ffff pref]
[    0.045921] pci 0001:01:00.1: BAR 0: assigned [mem 0x600c0800a0000-0x600c0800bffff]
[    0.046166] pci 0001:01:00.1: BAR 6: assigned [mem 0x600c081020000-0x600c08103ffff pref]
[    0.046357] pci 0001:01:00.0: BAR 2: assigned [mem 0x600c0800c0000-0x600c0800cffff]
[    0.046555] pci 0001:01:00.1: BAR 2: assigned [mem 0x600c0800d0000-0x600c0800dffff]
[    0.046748] pci 0001:00:00.0: PCI bridge to [bus 01]
[    0.046909] pci 0001:00:00.0:   bridge window [mem 0x600c080000000-0x600c080ffffff]
[    0.047103] pci 0001:00:00.0:   bridge window [mem 0x600c081000000-0x600c081ffffff pref]
[    0.047352] pci_bus 0001:00: resource 4 [mem 0x600c080000000-0x600c0fffeffff]
[    0.047540] pci_bus 0001:00: resource 5 [mem 0x6002000000000-0x6003fbfffffff 64bit pref]
[    0.047728] pci_bus 0001:01: resource 1 [mem 0x600c080000000-0x600c080ffffff]
[    0.047915] pci_bus 0001:01: resource 2 [mem 0x600c081000000-0x600c081ffffff pref]
[    0.048091] pnv_ioda_reserve_pe: Invalid PE 1536 on PHB#0
[    0.048240] pci 0000:00     : [PE# 000] Secondary bus 0 associated with PE#0
[    0.050026] pci 0000:01     : [PE# 001] Secondary bus 1 associated with PE#1
[    0.051814] pci 0001:00     : [PE# 000] Secondary bus 0 associated with PE#0
[    0.053600] pci 0001:01     : [PE# 001] Secondary bus 1 associated with PE#1
[    0.055408] PCI: Domain 0000 has 8 available 32-bit DMA segments
[    0.055570] pci 0000:01     : [PE# 001] Assign DMA32 space
[    0.055781] pci 0000:01     : [PE# 001] Setting up 32-bit TCE table at 0..80000000
[    0.123541] IOMMU table initialized, virtual merging enabled
[    0.123715] pci 0000:01     : [PE# 001] Setting up window#0 0..7fffffff pg=1000
[    0.124494] pci 0000:01     : [PE# 001] Enabling 64-bit DMA bypass
[    0.125467] iommu: Adding device 0000:01:00.0 to group 0
[    0.125606] PCI: Domain 0001 has 8 available 32-bit DMA segments
[    0.125720] pci 0001:01     : [PE# 001] Assign DMA32 space
[    0.125960] pci 0001:01     : [PE# 001] Setting up 32-bit TCE table at 0..80000000
[    0.183171] pci 0001:01     : [PE# 001] Setting up window#0 0..7fffffff pg=1000
[    0.183921] pci 0001:01     : [PE# 001] Enabling 64-bit DMA bypass
[    0.184920] iommu: Adding device 1001:01:00.0 to group 1
[    0.185079] iommu: Adding device 0001:01:00.1 to group 1
[    0.188083] EEH: PCI Enhanced I/O Error Handling Enabled
[    0.188425] PCI: Probing PCI hardware done

# lspci -v
0000:00:00.0 PCI bridge: IBM Device 04c1 (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: 80000000-807fffff
        Prefetchable memory behind bridge: 80800000-81ffffff
        Capabilities: [40] Power Management version 1
        Capabilities: [48] Express Root Port (Slot-), MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [148] #19

0000:01:00.0 RAID bus controller: IBM PCI-E IPR SAS Adapter (FPGA)
        Subsystem: IBM PCIe2 1.8GB Cache 6Gb SAS RAID Adapter Tri-port (57B5)
        Flags: bus master, fast devsel, latency 74, IRQ 128
        Memory at 600c000000000 (64-bit, non-prefetchable) [size=256K]
        Memory at 600c001000000 (64-bit, prefetchable) [size=16M]
        [virtual] Expansion ROM at 600c000800000 [disabled] [size=8M]
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
        Capabilities: [78] Power Management version 2
        Capabilities: [a0] Express Legacy Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting

0001:00:00.0 PCI bridge: IBM Device 04c1 (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: 80000000-80ffffff
        Prefetchable memory behind bridge: 81000000-81ffffff
        Capabilities: [40] Power Management version 1
        Capabilities: [48] Express Root Port (Slot-), MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [148] #19

0001:01:00.0 Ethernet controller: Intel Corporation 82571EB Gigabit Ethernet Con
troller (rev 06)
        Subsystem: IBM Device 0340
        Flags: bus master, 66MHz, medium devsel, latency 8, IRQ 26
        Memory at 600c080080000 (32-bit, non-prefetchable) [size=128K]
        Memory at 600c080000000 (32-bit, non-prefetchable) [size=256K]
        Memory at 600c0800c0000 (32-bit, non-prefetchable) [size=64K]
        [virtual] Expansion ROM at 600c081000000 [disabled] [size=128K]
        Capabilities: [c8] Power Management version 0
        Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Capabilities: [e0] Express Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Kernel driver in use: e1000e

0001:01:00.1 Ethernet controller: Intel Corporation 82571EB Gigabit Ethernet Con
troller (rev 06)
        Subsystem: IBM Device 0340
        Flags: bus master, 66MHz, medium devsel, latency 8, IRQ 27
        Memory at 600c0800a0000 (32-bit, non-prefetchable) [size=128K]
        Memory at 600c080040000 (32-bit, non-prefetchable) [size=256K]
        Memory at 600c0800d0000 (32-bit, non-prefetchable) [size=64K]
        [virtual] Expansion ROM at 600c081020000 [disabled] [size=128K]
        Capabilities: [c8] Power Management version 0
        Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Capabilities: [e0] Express Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Kernel driver in use: e1000e

# cat /proc/iomem 
00000000-7fffffff : System RAM
6000000000000-6001fdfffffff : /pciex@600c3c0000000
6002000000000-6003fbfffffff : /pciex@600c3c0100000
600c000000000-600c07ffeffff : /pciex@600c3c0000000
  600c000000000-600c0007fffff : PCI Bus 0000:01
    600c000000000-600c00003ffff : 0000:01:00.0
  600c000800000-600c001ffffff : PCI Bus 0000:01
    600c000800000-600c000ffffff : 0000:01:00.0
    600c001000000-600c001ffffff : 0000:01:00.0
600c080000000-600c0fffeffff : /pciex@600c3c0100000
  600c080000000-600c080ffffff : PCI Bus 0001:01
    600c080000000-600c08003ffff : 1001:01:00.0
      600c080000000-600c08003ffff : e1000e
    600c080040000-600c08007ffff : 0001:01:00.1
      600c080040000-600c08007ffff : e1000e
    600c080080000-600c08009ffff : 1001:01:00.0
      600c080080000-600c08009ffff : e1000e
    600c0800a0000-600c0800bffff : 0001:01:00.1
      600c0800a0000-600c0800bffff : e1000e
    600c0800c0000-600c0800cffff : 1001:01:00.0
      600c0800c0000-600c0800cffff : e1000e
    600c0800d0000-600c0800dffff : 0001:01:00.1
      600c0800d0000-600c0800dffff : e1000e
  600c081000000-600c081ffffff : PCI Bus 0001:01
    600c081000000-600c08101ffff : 1001:01:00.0
    600c081020000-600c08103ffff : 0001:01:00.1

