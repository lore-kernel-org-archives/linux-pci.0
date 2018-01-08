Return-Path: <SRS0=ZRB8=ED=ncentric.com=koen.vandeputte@kernel.org>
Return-Path: <SRS0=ZRB8=ED=ncentric.com=koen.vandeputte@kernel.org>
Subject: Re: [PATCH] imx6: fix pcie enumeration
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 bhelgaas@google.com, Richard Zhu <hongxing.zhu@nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>, linux-arm-kernel@lists.infradead.org
References: <20180104202430.GC189897@bhelgaas-glaptop.roam.corp.google.com>
 <a2d7afee-7a41-6da6-e5a4-a36a6fcde55d@ncentric.com>
 <20180105123206.GA24511@e107981-ln.cambridge.arm.com>
 <ebf30c78-b772-6214-f441-c86ae7fdba7e@ncentric.com>
 <20180105171828.GC24933@red-moon>
From: Koen Vandeputte <koen.vandeputte@ncentric.com>
Message-ID: <5bc70c34-45b2-5aed-eb06-f8ecfe859fd0@ncentric.com>
Date: Mon, 8 Jan 2018 09:51:37 +0100
MIME-Version: 1.0
In-Reply-To: <20180105171828.GC24933@red-moon>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>



On 2018-01-05 18:18, Lorenzo Pieralisi wrote:
>>
>> Hi Lorenzo,
>>
>> This is exactly what I'm trying to explain:
>>
>> The host starts of with a (hardcoded today) subord of 1. [bits 16:23]
>>
>> Since commit a20c7f36bd3d, downstream devices cannot assign bus nr's
>> higher than the subord of the upstream device.
>> So in this case, scanning stops after the bridge as soon as bus 1 is
>> assigned .. :)
> There is one thing that I need to understand though. Before the commit
> above, how would enumeration works given that the subordinate bus number
> was set to 1 and that the kernel, AFAICS, does not overwrite it ?
>
> Are you able to send me a log (enumeration with debugging enabled and
> lspci) with the commit above reverted please ?
>
> Thanks,
> Lorenzo
>


Info below as requested:



[    0.116729] OF: PCI: host bridge /soc/pcie@0x01000000 ranges:
[    0.116748] OF: PCI:   No bus range found for /soc/pcie@0x01000000, 
using [bus 00-ff]
[    0.116777] OF: PCI:    IO 0x01f80000..0x01f8ffff -> 0x00000000
[    0.116796] OF: PCI:   MEM 0x01000000..0x01efffff -> 0x01000000
[    0.337917] imx6q-pcie 1ffc000.pcie: link up
[    0.337934] imx6q-pcie 1ffc000.pcie: Link: Gen2 disabled
[    0.337947] imx6q-pcie 1ffc000.pcie: link up
[    0.337958] imx6q-pcie 1ffc000.pcie: Link up, Gen1
[    0.338197] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
[    0.338215] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.338230] pci_bus 0000:00: root bus resource [io 0x0000-0xffff]
[    0.338243] pci_bus 0000:00: root bus resource [mem 
0x01000000-0x01efffff]
[    0.338255] pci_bus 0000:00: scanning bus
[    0.338286] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
[    0.338311] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
[    0.338328] pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
[    0.338362] pci 0000:00:00.0: calling pci_fixup_ide_bases+0x0/0x4c
[    0.338416] pci 0000:00:00.0: supports D1
[    0.338425] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
[    0.338436] pci 0000:00:00.0: PME# disabled
[    0.338664] pci_bus 0000:00: fixups for bus
[    0.338676] PCI: bus0: Fast back to back transfers disabled
[    0.338692] pci 0000:00:00.0: scanning [bus 01-01] behind bridge, pass 0
[    0.338822] pci_bus 0000:01: scanning bus
[    0.338926] pci 0000:01:00.0: [10b5:8604] type 01 class 0x060400
[    0.338969] pci 0000:01:00.0: calling ventana_pciesw_early_fixup+0x0/0xa4
[    0.457984] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x0001ffff]
[    0.458167] pci 0000:01:00.0: calling pci_fixup_ide_bases+0x0/0x4c
[    0.458635] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    0.458660] pci 0000:01:00.0: PME# disabled
[    0.458970] pci_bus 0000:01: fixups for bus
[    0.459027] PCI: bus1: Fast back to back transfers disabled
[    0.459052] pci 0000:01:00.0: scanning [bus 00-00] behind bridge, pass 0
[    0.459060] pci 0000:01:00.0: bridge configuration invalid ([bus 
00-00]), reconfiguring
[    0.459115] pci 0000:01:00.0: scanning [bus 00-00] behind bridge, pass 1
[    0.459443] pci_bus 0000:02: busn_res: can not insert [bus 02-ff] 
under [bus 01] (conflicts with (null) [bus 01])
[    0.459461] pci_bus 0000:02: scanning bus
[    0.459573] pci 0000:02:01.0: [10b5:8604] type 01 class 0x060400
[    0.459617] pci 0000:02:01.0: calling ventana_pciesw_early_fixup+0x0/0xa4
[    0.459865] pci 0000:02:01.0: calling pci_fixup_ide_bases+0x0/0x4c
[    0.460298] pci 0000:02:01.0: PME# supported from D0 D3hot D3cold
[    0.460321] pci 0000:02:01.0: PME# disabled
[    0.460719] pci 0000:02:04.0: [10b5:8604] type 01 class 0x060400
[    0.460760] pci 0000:02:04.0: calling ventana_pciesw_early_fixup+0x0/0xa4
[    0.461009] pci 0000:02:04.0: calling pci_fixup_ide_bases+0x0/0x4c
[    0.461436] pci 0000:02:04.0: PME# supported from D0 D3hot D3cold
[    0.461460] pci 0000:02:04.0: PME# disabled
[    0.461841] pci 0000:02:05.0: [10b5:8604] type 01 class 0x060400
[    0.461883] pci 0000:02:05.0: calling ventana_pciesw_early_fixup+0x0/0xa4
[    0.462128] pci 0000:02:05.0: calling pci_fixup_ide_bases+0x0/0x4c
[    0.462553] pci 0000:02:05.0: PME# supported from D0 D3hot D3cold
[    0.462578] pci 0000:02:05.0: PME# disabled
[    0.463084] pci_bus 0000:02: fixups for bus
[    0.463231] PCI: bus2: Fast back to back transfers disabled
[    0.463255] pci 0000:02:01.0: scanning [bus 00-00] behind bridge, pass 0
[    0.463264] pci 0000:02:01.0: bridge configuration invalid ([bus 
00-00]), reconfiguring
[    0.463319] pci 0000:02:04.0: scanning [bus 00-00] behind bridge, pass 0
[    0.463328] pci 0000:02:04.0: bridge configuration invalid ([bus 
00-00]), reconfiguring
[    0.463378] pci 0000:02:05.0: scanning [bus 00-00] behind bridge, pass 0
[    0.463385] pci 0000:02:05.0: bridge configuration invalid ([bus 
00-00]), reconfiguring
[    0.463435] pci 0000:02:01.0: scanning [bus 00-00] behind bridge, pass 1
[    0.463764] pci_bus 0000:03: scanning bus
[    0.463785] pci_bus 0000:03: fixups for bus
[    0.463791] PCI: bus3: Fast back to back transfers enabled
[    0.463803] pci_bus 0000:03: bus scan returning with max=03
[    0.463814] pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
[    0.463833] pci_bus 0000:03: [bus 03] partially hidden behind bridge 
0000:01 [bus 01]
[    0.463862] pci 0000:02:04.0: scanning [bus 00-00] behind bridge, pass 1
[    0.464178] pci_bus 0000:04: scanning bus
[    0.464197] pci_bus 0000:04: fixups for bus
[    0.464202] PCI: bus4: Fast back to back transfers enabled
[    0.464214] pci_bus 0000:04: bus scan returning with max=04
[    0.464223] pci_bus 0000:04: busn_res: [bus 04-ff] end is updated to 04
[    0.464242] pci_bus 0000:04: [bus 04] partially hidden behind bridge 
0000:01 [bus 01]
[    0.464271] pci 0000:02:05.0: scanning [bus 00-00] behind bridge, pass 1
[    0.464586] pci_bus 0000:05: scanning bus
[    0.464691] pci 0000:05:00.0: [168c:0033] type 00 class 0x028000
[    0.464825] pci 0000:05:00.0: reg 0x10: [mem 0x00000000-0x0001ffff 64bit]
[    0.465036] pci 0000:05:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    0.465095] pci 0000:05:00.0: calling pci_fixup_ide_bases+0x0/0x4c
[    0.465117] pci 0000:05:00.0: calling quirk_no_bus_reset+0x0/0x20
[    0.465489] pci 0000:05:00.0: supports D1
[    0.465498] pci 0000:05:00.0: PME# supported from D0 D1 D3hot
[    0.465524] pci 0000:05:00.0: PME# disabled
[    0.465859] pci_bus 0000:05: fixups for bus
[    0.465903] PCI: bus5: Fast back to back transfers disabled
[    0.465916] pci_bus 0000:05: bus scan returning with max=05
[    0.465926] pci_bus 0000:05: busn_res: [bus 05-ff] end is updated to 05
[    0.465946] pci_bus 0000:05: [bus 05] partially hidden behind bridge 
0000:01 [bus 01]
[    0.465965] pci_bus 0000:02: bus scan returning with max=05
[    0.465974] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 05
[    0.465984] pci_bus 0000:02: busn_res: can not insert [bus 02-05] 
under [bus 01] (conflicts with (null) [bus 01])
[    0.466005] pci_bus 0000:02: [bus 02-05] partially hidden behind 
bridge 0000:01 [bus 01]
[    0.466026] pci_bus 0000:01: bus scan returning with max=05
[    0.466033] pci 0000:00:00.0: bridge has subordinate 01 but max busn 05
[    0.466049] pci 0000:00:00.0: scanning [bus 01-01] behind bridge, pass 1
[    0.466059] pci_bus 0000:00: bus scan returning with max=01
[    0.466186] pci 0000:00:00.0: fixup irq: got 298
[    0.466196] pci 0000:00:00.0: assigning IRQ 298
[    0.466247] pci 0000:01:00.0: fixup irq: got 298
[    0.466254] pci 0000:01:00.0: assigning IRQ 298
[    0.466374] pci 0000:02:01.0: fixup irq: got 299
[    0.466382] pci 0000:02:01.0: assigning IRQ 299
[    0.466436] pci 0000:02:04.0: fixup irq: got 298
[    0.466442] pci 0000:02:04.0: assigning IRQ 298
[    0.466501] pci 0000:02:05.0: fixup irq: got 299
[    0.466509] pci 0000:02:05.0: assigning IRQ 299
[    0.466562] pci 0000:05:00.0: fixup irq: got 299
[    0.466569] pci 0000:05:00.0: assigning IRQ 299
[    0.466807] pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
[    0.466825] pci 0000:00:00.0: BAR 8: assigned [mem 0x01100000-0x012fffff]
[    0.466843] pci 0000:00:00.0: BAR 6: assigned [mem 
0x01300000-0x0130ffff pref]
[    0.466862] pci 0000:01:00.0: BAR 8: assigned [mem 0x01100000-0x011fffff]
[    0.466875] pci 0000:01:00.0: BAR 0: assigned [mem 0x01200000-0x0121ffff]
[    0.466908] pci 0000:02:05.0: BAR 8: assigned [mem 0x01100000-0x011fffff]
[    0.466919] pci 0000:02:01.0: PCI bridge to [bus 03]
[    0.467001] pci 0000:02:04.0: PCI bridge to [bus 04]
[    0.467086] pci 0000:05:00.0: BAR 0: assigned [mem 
0x01100000-0x0111ffff 64bit]
[    0.467160] pci 0000:05:00.0: BAR 6: assigned [mem 
0x01120000-0x0112ffff pref]
[    0.467171] pci 0000:02:05.0: PCI bridge to [bus 05]
[    0.467206] pci 0000:02:05.0:   bridge window [mem 0x01100000-0x011fffff]
[    0.467262] pci 0000:01:00.0: PCI bridge to [bus 02-05]
[    0.467297] pci 0000:01:00.0:   bridge window [mem 0x01100000-0x011fffff]
[    0.467352] pci 0000:00:00.0: PCI bridge to [bus 01]
[    0.467364] pci 0000:00:00.0:   bridge window [mem 0x01100000-0x012fffff]
[    0.467627] pcieport 0000:00:00.0: Signaling PME through PCIe PME 
interrupt
[    0.467643] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
[    0.467653] pci 0000:02:01.0: Signaling PME through PCIe PME interrupt
[    0.467662] pci 0000:02:04.0: Signaling PME through PCIe PME interrupt
[    0.467671] pci 0000:02:05.0: Signaling PME through PCIe PME interrupt
[    0.467680] pci 0000:05:00.0: Signaling PME through PCIe PME interrupt
[    0.467694] pcie_pme 0000:00:00.0:pcie001: service driver pcie_pme loaded
[    0.468019] pcieport 0000:01:00.0: enabling device (0140 -> 0142)
[    0.468147] pcieport 0000:01:00.0: enabling bus mastering
[    0.468886] pcieport 0000:02:01.0: enabling bus mastering
[    0.469576] pcieport 0000:02:04.0: enabling bus mastering
[    0.470165] pcieport 0000:02:05.0: enabling device (0140 -> 0142)
[    0.470275] pcieport 0000:02:05.0: enabling bus mastering


[ Node 4 | node-4 ] lspci -v
00:00.0 PCI bridge: Synopsys, Inc. Device abcd (rev 01) (prog-if 00 
[Normal decode])
     Flags: bus master, fast devsel, latency 0, IRQ 298
     Memory at 01000000 (32-bit, non-prefetchable) [size=1M]
     Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
     I/O behind bridge: None
     Memory behind bridge: 01100000-012fffff [size=2M]
     Prefetchable memory behind bridge: None
     [virtual] Expansion ROM at 01300000 [disabled] [size=64K]
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
     Memory at 01200000 (32-bit, non-prefetchable) [size=128K]
     Bus: primary=01, secondary=02, subordinate=05, sec-latency=0
     I/O behind bridge: None
     Memory behind bridge: 01100000-011fffff [size=1M]
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

02:01.0 PCI bridge: PLX Technology, Inc. PEX 8604 4-lane, 4-Port PCI 
Express Gen 2 (5.0 GT/s) Switch (rev ba) (prog-if 00 [Normal decode])
     Flags: bus master, fast devsel, latency 0, IRQ 299
     Bus: primary=02, secondary=03, subordinate=03, sec-latency=0
     I/O behind bridge: None
     Memory behind bridge: None
     Prefetchable memory behind bridge: None
     Capabilities: [40] Power Management version 3
     Capabilities: [48] MSI: Enable- Count=1/4 Maskable+ 64bit+
     Capabilities: [68] Express Downstream Port (Slot+), MSI 00
     Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8604 4-lane, 
4-Port PCI Express Gen 2 (5.0 GT/s) Switch
     Capabilities: [100] Device Serial Number ba-86-01-10-b5-df-0e-00
     Capabilities: [fb4] Advanced Error Reporting
     Capabilities: [148] Virtual Channel
     Capabilities: [520] Access Control Services
     Capabilities: [950] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>
     Kernel driver in use: pcieport

02:04.0 PCI bridge: PLX Technology, Inc. PEX 8604 4-lane, 4-Port PCI 
Express Gen 2 (5.0 GT/s) Switch (rev ba) (prog-if 00 [Normal decode])
     Flags: bus master, fast devsel, latency 0, IRQ 298
     Bus: primary=02, secondary=04, subordinate=04, sec-latency=0
     I/O behind bridge: None
     Memory behind bridge: None
     Prefetchable memory behind bridge: None
     Capabilities: [40] Power Management version 3
     Capabilities: [48] MSI: Enable- Count=1/4 Maskable+ 64bit+
     Capabilities: [68] Express Downstream Port (Slot+), MSI 00
     Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8604 4-lane, 
4-Port PCI Express Gen 2 (5.0 GT/s) Switch
     Capabilities: [100] Device Serial Number ba-86-01-10-b5-df-0e-00
     Capabilities: [fb4] Advanced Error Reporting
     Capabilities: [148] Virtual Channel
     Capabilities: [520] Access Control Services
     Capabilities: [950] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>
     Kernel driver in use: pcieport

02:05.0 PCI bridge: PLX Technology, Inc. PEX 8604 4-lane, 4-Port PCI 
Express Gen 2 (5.0 GT/s) Switch (rev ba) (prog-if 00 [Normal decode])
     Flags: bus master, fast devsel, latency 0, IRQ 299
     Bus: primary=02, secondary=05, subordinate=05, sec-latency=0
     I/O behind bridge: None
     Memory behind bridge: 01100000-011fffff [size=1M]
     Prefetchable memory behind bridge: None
     Capabilities: [40] Power Management version 3
     Capabilities: [48] MSI: Enable- Count=1/4 Maskable+ 64bit+
     Capabilities: [68] Express Downstream Port (Slot+), MSI 00
     Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8604 4-lane, 
4-Port PCI Express Gen 2 (5.0 GT/s) Switch
     Capabilities: [100] Device Serial Number ba-86-01-10-b5-df-0e-00
     Capabilities: [fb4] Advanced Error Reporting
     Capabilities: [148] Virtual Channel
     Capabilities: [520] Access Control Services
     Capabilities: [950] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>
     Kernel driver in use: pcieport

05:00.0 Network controller: Qualcomm Atheros AR958x 802.11abgn Wireless 
Network Adapter (rev 01)
     Subsystem: Device 19b6:d016
     Flags: bus master, fast devsel, latency 0, IRQ 299
     Memory at 01100000 (64-bit, non-prefetchable) [size=128K]
     [virtual] Expansion ROM at 01120000 [disabled] [size=64K]
     Capabilities: [40] Power Management version 3
     Capabilities: [50] MSI: Enable- Count=1/4 Maskable+ 64bit+
     Capabilities: [70] Express Endpoint, MSI 00
     Capabilities: [100] Advanced Error Reporting
     Capabilities: [140] Virtual Channel
     Capabilities: [300] Device Serial Number 00-00-00-00-00-00-00-00
     Kernel driver in use: ath9k
