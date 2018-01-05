Return-Path: <SRS0=r7nf=EA=ncentric.com=koen.vandeputte@kernel.org>
Return-Path: <SRS0=r7nf=EA=ncentric.com=koen.vandeputte@kernel.org>
Subject: Re: [PATCH] imx6: fix pcie enumeration
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 bhelgaas@google.com, Richard Zhu <hongxing.zhu@nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>, linux-arm-kernel@lists.infradead.org
References: <20180104202430.GC189897@bhelgaas-glaptop.roam.corp.google.com>
 <a2d7afee-7a41-6da6-e5a4-a36a6fcde55d@ncentric.com>
 <20180105123206.GA24511@e107981-ln.cambridge.arm.com>
From: Koen Vandeputte <koen.vandeputte@ncentric.com>
Message-ID: <ebf30c78-b772-6214-f441-c86ae7fdba7e@ncentric.com>
Date: Fri, 5 Jan 2018 14:39:57 +0100
MIME-Version: 1.0
In-Reply-To: <20180105123206.GA24511@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>



On 2018-01-05 13:32, Lorenzo Pieralisi wrote:
>
>> 	/* setup bus numbers */
>> 	val  =  dw_pcie_readl_dbi
>> 	val  &=  0xff000000;
>> 	val  |=  0x00010100; <---  hardcoded today
>> 	dw_pcie_writel_dbi

>> I *think* I understand what's going on - the kernel takes the primary,
>> secondary and subordinate values in the host bridge as valid in:
>>
>> pci_scan_bridge_extend()
>>
>> and given that pcibios_assign_all_busses() returns false (guess) it sets-up
>> the bus hierarchy with a bus resource with subordinate number as read from
>> PCI host bridge config space - which, given that it is 1 according to your
>> explanation - this triggers the issue you reported.
>>
>> After commit a20c7f36bd3d the root bus resource is propagated down the
>> hierarchy, hence the problem.
>>
>> So, in order to fix the issue I think the best way is to programme the
>> root bridge in:
>>
>> drivers/pci/dwc/pci-designware-host.c
>>
>> but with the value coming from the root bus IORESOURCE_BUS resource,
>> not hardcoding 0xff.
>>
>> I would kindly ask you to send logs with debug turned on in:
>>
>> drivers/pci/probe.c
>>
>> since I would like to check my understanding is correct.
>>
>> Please CC all dwc host maintainers since this has potential widespread
>> impact.
>>
>> Thanks,
>> Lorenzo
Hi Lorenzo,

This is exactly what I'm trying to explain:

The host starts of with a (hardcoded today) subord of 1. [bits 16:23]

Since commit a20c7f36bd3d, downstream devices cannot assign bus nr's 
higher than the subord of the upstream device.
So in this case, scanning stops after the bridge as soon as bus 1 is 
assigned .. :)


As other targets besides i.MX6 (layerscape, armada8k, ...) also use the 
same function to init PCIe, I believe those targets are also affected.

I've tested here setting the PCI_PRIMARY_BUS register to 0x 00 ff 01 00  
(ignored-subord-secbus-primbus), and the whole scanning works again.
I fully agree that hardcoding is not the final fix, as this param can be 
defined in a DT.


Fixing this, combined with the upstream commit exposing the error, fixes 
all following pci boot errors:

..
[    0.466405] pci_bus 0000:05: [bus 05] partially hidden behind bridge 
0000:01 [bus 01]
..
[    0.466435] pci_bus 0000:02: busn_res: can not insert [bus 02-05] 
under [bus 01] (conflicts with (null) [bus 01])
[    0.466454] pci_bus 0000:02: [bus 02-05] partially hidden behind 
bridge 0000:01 [bus 01]
..


Watching the tree using lspci also shows that all primaries, secondaries 
and subords are perfectly logical as expected.


Thanks,

Koen


Log showing the initial issue without any fixup:


[    0.116673] OF: PCI: host bridge /soc/pcie@0x01000000 ranges:
[    0.116692] OF: PCI:   No bus range found for /soc/pcie@0x01000000, 
using [bus 00-ff]
[    0.116719] OF: PCI:    IO 0x01f80000..0x01f8ffff -> 0x00000000
[    0.116739] OF: PCI:   MEM 0x01000000..0x01efffff -> 0x01000000
[    0.337752] imx6q-pcie 1ffc000.pcie: link up
[    0.337771] imx6q-pcie 1ffc000.pcie: Link: Gen2 disabled
[    0.337785] imx6q-pcie 1ffc000.pcie: link up
[    0.337796] imx6q-pcie 1ffc000.pcie: Link up, Gen1
[    0.338039] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
[    0.338055] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.338069] pci_bus 0000:00: root bus resource [io 0x0000-0xffff]
[    0.338082] pci_bus 0000:00: root bus resource [mem 
0x01000000-0x01efffff]
[    0.338094] pci_bus 0000:00: scanning bus
[    0.338127] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
[    0.338151] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
[    0.338168] pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
[    0.338204] pci 0000:00:00.0: calling pci_fixup_ide_bases+0x0/0x4c
[    0.338259] pci 0000:00:00.0: supports D1
[    0.338267] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
[    0.338276] pci 0000:00:00.0: PME# disabled
[    0.338512] pci_bus 0000:00: fixups for bus
[    0.338525] PCI: bus0: Fast back to back transfers disabled
[    0.338541] pci 0000:00:00.0: scanning [bus 01-01] behind bridge, pass 0
[    0.338673] pci_bus 0000:01: scanning bus
[    0.338773] pci 0000:01:00.0: [10b5:8604] type 01 class 0x060400
[    0.338816] pci 0000:01:00.0: calling ventana_pciesw_early_fixup+0x0/0xa4
[    0.467817] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x0001ffff]
[    0.467999] pci 0000:01:00.0: calling pci_fixup_ide_bases+0x0/0x4c
[    0.468467] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    0.468491] pci 0000:01:00.0: PME# disabled
[    0.468795] pci_bus 0000:01: fixups for bus
[    0.468854] PCI: bus1: Fast back to back transfers disabled
[    0.468877] pci 0000:01:00.0: scanning [bus 00-00] behind bridge, pass 0
[    0.468886] pci 0000:01:00.0: bridge configuration invalid ([bus 
00-00]), reconfiguring
[    0.468939] pci 0000:01:00.0: scanning [bus 00-00] behind bridge, pass 1
[    0.469265] pci_bus 0000:02: busn_res: can not insert [bus 02-01] 
under [bus 01] (conflicts with (null) [bus 01])
[    0.469282] pci_bus 0000:02: scanning bus
[    0.469554] pci_bus 0000:02: fixups for bus
[    0.469559] PCI: bus2: Fast back to back transfers enabled
[    0.469572] pci_bus 0000:02: bus scan returning with max=02
[    0.469582] pci_bus 0000:02: busn_res: [bus 02-01] end is updated to 02
[    0.469593] pci_bus 0000:02: busn_res: can not insert [bus 02] under 
[bus 01] (conflicts with (null) [bus 01])
[    0.469615] pci_bus 0000:02: [bus 02] partially hidden behind bridge 
0000:01 [bus 01]
[    0.469636] pci_bus 0000:01: bus scan returning with max=02
[    0.469643] pci 0000:00:00.0: bridge has subordinate 01 but max busn 02
[    0.469661] pci 0000:00:00.0: scanning [bus 01-01] behind bridge, pass 1
[    0.469671] pci_bus 0000:00: bus scan returning with max=01
[    0.469791] pci 0000:00:00.0: fixup irq: got 298
[    0.469800] pci 0000:00:00.0: assigning IRQ 298
[    0.469849] pci 0000:01:00.0: fixup irq: got 298
[    0.469856] pci 0000:01:00.0: assigning IRQ 298
[    0.469946] pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
[    0.469965] pci 0000:00:00.0: BAR 8: assigned [mem 0x01100000-0x011fffff]
[    0.469980] pci 0000:00:00.0: BAR 6: assigned [mem 
0x01200000-0x0120ffff pref]
[    0.469997] pci 0000:01:00.0: BAR 0: assigned [mem 0x01100000-0x0111ffff]
[    0.470026] pci 0000:01:00.0: PCI bridge to [bus 02]
[    0.470108] pci 0000:00:00.0: PCI bridge to [bus 01]
[    0.470121] pci 0000:00:00.0:   bridge window [mem 0x01100000-0x011fffff]
[    0.470381] pcieport 0000:00:00.0: Signaling PME through PCIe PME 
interrupt
[    0.470397] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
[    0.470412] pcie_pme 0000:00:00.0:pcie001: service driver pcie_pme loaded
[    0.470660] pcieport 0000:01:00.0: enabling device (0140 -> 0142)
[    0.470788] pcieport 0000:01:00.0: enabling bus mastering



[ Node 4 | node-4 ] lspci -tv
-[0000:00]---00.0-[01]----00.0-[02]--
[ Node 4 | node-4 ]



[ Node 4 | node-4 ] lspci -v
00:00.0 PCI bridge: Synopsys, Inc. Device abcd (rev 01) (prog-if 00 
[Normal decode])
     Flags: bus master, fast devsel, latency 0, IRQ 298
     Memory at 01000000 (32-bit, non-prefetchable) [size=1M]
     Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
     I/O behind bridge: None
     Memory behind bridge: 01100000-011fffff [size=1M]
     Prefetchable memory behind bridge: None
     [virtual] Expansion ROM at 01200000 [disabled] [size=64K]
     Capabilities: [40] Power Management version 3
     Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
     Capabilities: [70] Express Root Port (Slot-), MSI 00
     Capabilities: [100] Advanced Error Reporting
     Capabilities: [140] Virtual Channel
     Kernel driver in use: pcieport
lspci: Unable to load libkmod resources: error -12

01:00.0 PCI bridge: PLX Technology, Inc. PEX 8604 4-lane, 4-Port PCI 
Express Gen 2 (5.0 GT/s) Switch (rev ba) (prog-if 00 [Normal decode])
     Flags: bus master, fast devsel, latency 0, IRQ 298
     Memory at 01100000 (32-bit, non-prefetchable) [size=128K]
     Bus: primary=01, secondary=02, subordinate=02, sec-latency=0
     I/O behind bridge: None
     Memory behind bridge: None
     Prefetchable memory behind bridge: None
     Capabilities: [40] Power Management version 3
     Capabilities: [48] MSI: Enable- Count=1/4 Maskable+ 64bit+
     Capabilities: [68] Express Upstream Port, MSI 00
     Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8604 4-lane, 
4-Port PCI Express Gen 2 (5.0 GT/s) Switch
     Capabilities: [100] Device Serial Number ba-86-01-10-b5-df-0e-00
     Capabilities: [fb4] Advanced Error Reporting
     Capabilities: [138] Power Budgeting <?>
     Capabilities: [148] Virtual Channel
     Capabilities: [448] Vendor Specific Information: ID=0000 Rev=0 
Len=0cc <?>
     Capabilities: [950] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>
     Kernel driver in use: pcieport
[ Node 4 | node-4 ]
