Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <56B4D812.7080106@caviumnetworks.com>
Date: Fri, 5 Feb 2016 09:12:50 -0800
From: David Daney <ddaney@caviumnetworks.com>
MIME-Version: 1.0
To: Bjorn Helgaas <helgaas@kernel.org>
CC: David Daney <ddaney.cavm@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, Will Deacon <will.deacon@arm.com>,
	<linux-arm-kernel@lists.infradead.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v4 2/2] pci, pci-thunder-pem: Add PCIe host driver for
 ThunderX processors.
References: <1453844781-24380-1-git-send-email-ddaney.cavm@gmail.com> <1453844781-24380-3-git-send-email-ddaney.cavm@gmail.com> <20160205000452.GI7031@localhost> <56B3ECAD.4050605@caviumnetworks.com> <20160205031042.GA31722@localhost>
In-Reply-To: <20160205031042.GA31722@localhost>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/04/2016 07:10 PM, Bjorn Helgaas wrote:
> On Thu, Feb 04, 2016 at 04:28:29PM -0800, David Daney wrote:
>> On 02/04/2016 04:04 PM, Bjorn Helgaas wrote:
>>> On Tue, Jan 26, 2016 at 01:46:21PM -0800, David Daney wrote:
>>>> From: David Daney <david.daney@cavium.com>
>>>>
>>>> Some Cavium ThunderX processors require quirky access methods for the
>>>> config space of the PCIe bridge.  Add a driver to provide these config
>>>> space accessor functions.  The pci-host-common code is used to
>>>> configure the PCI machinery.
>>>>
>>>> Signed-off-by: David Daney <david.daney@cavium.com>
>>>> Acked-by: Rob Herring <robh@kernel.org>
>>>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>>>> ---
>>>>   .../devicetree/bindings/pci/pci-thunder-pem.txt    |  43 ++++
>>>>   MAINTAINERS                                        |   8 +
>>>>   drivers/pci/host/Kconfig                           |   7 +
>>>>   drivers/pci/host/Makefile                          |   1 +
>>>>   drivers/pci/host/pci-thunder-pem.c                 | 283 +++++++++++++++++++++
>>>
>>> What's the significance of the "pem" part of the name?  I'm wondering
>>> if we can shorten the filenames and function names by dropping it and
>>> referring to this simply as "thunder" or "thunderx".
>>
>> PEM == PCI Express MAC, Essentially the circuitry related to
>> off-chip PCI devices.  This differentiates it from the internal
>> on-chip devices which are connected to internal buses we refer to as
>> "ECAMs"
>
> That's an unusual and confusing usage of ECAM, since the PCIe spec
> uses ECAM for "Enhanced Configuration Access Mechanism", which is not
> a bus.
>
>> See also the follow on patch, from me, that adds the
>> pci-thunder-ecam.c driver.
>
> OK.  In PCIe spec terms, I guess your PEM and ECAM are two separate
> root complexes?

Correct.

> The spec defines a way to build a logical topology
> and doesn't really care whether the devices are on-chip or off-chip.
>

Yes, I know this.

The different names were chosen as a way to differentiate the two types 
of root complexes.  If we temporarily suspend our knowledge of the 
meaning of the term "ECAM" with respect to the PCI specifications, we 
can think of them as random names:

PEM: Root complex type for access to external PCIe connections.

ECAM: Root complex type for access to on-chip devices.


>> Since PEM and ECAM are terminology used in the hardware manuals that
>> have specific meanings relative to the Thunder SoC family, I think
>> it is not too inconvenient to carry them over into the file names.
>
> As long as PEM and ECAM are really two distinct root complexes that
> are unrelated, I guess this is OK.

They are, see above.

>
> I was imagining that PEM devices and ECAM devices would be in the same
> hierarchy, in the same domain, in the same bus number space, but with
> different ways of accessing their config space.  If that were the
> case, you could have a single driver with config accessors that were
> smart enough to figure out which method to use.  But if they're truly
> separate and unrelated, then I guess it makes sense to have two
> drivers.
>

The, somewhat unfortunate, fact is that due to the hardware design of 
the first generation of Thunder SoCs, There really are two separate 
types of config access methods for these things.  The result is two 
separate drivers.


> Maybe a concrete example would make this clearer to me.  Can you share
> a dmesg log and lspci output showing both PEM and ECAM devices?

As system with the maximum configuration would be a two node NUMA system 
with 4 "ECAM" and 6 "PEM" type root complexes per node for a total of 20 
root complexes in the system.

Here is the output from a simpler system with *only*  4 "ECAM" and 2 
"PEM" configured:
.
.
.
[    4.557825] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    4.563423] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    4.570128] PCI host bridge /soc@0/pci@8480,00000000 ranges:
[    4.575808]   MEM 0x801000000000..0x807fffffffff -> 0x801000000000
[    4.581993]   MEM 0x838000000000..0x841fffffffff -> 0x838000000000
[    4.588179]   MEM 0x846000000000..0x847fffffffff -> 0x846000000000
[    4.594363]   MEM 0x868000000000..0x87e023ffffff -> 0x868000000000
[    4.600546]   MEM 0x87e026000000..0x87e0bfffffff -> 0x87e026000000
[    4.606728]   MEM 0x87e0c6000000..0x87ffffffffff -> 0x87e0c6000000
[    4.613198] pci-host-generic 848000000000.pci: PCI host bridge to bus 
0000:00
[    4.620340] pci_bus 0000:00: root bus resource [bus 00-1f]
[    4.625822] pci_bus 0000:00: root bus resource [mem 
0x801000000000-0x807fffffffff]
[    4.633388] pci_bus 0000:00: root bus resource [mem 
0x838000000000-0x841fffffffff]
[    4.640951] pci_bus 0000:00: root bus resource [mem 
0x846000000000-0x847fffffffff]
[    4.648514] pci_bus 0000:00: root bus resource [mem 
0x868000000000-0x87e023ffffff]
[    4.656077] pci_bus 0000:00: root bus resource [mem 
0x87e026000000-0x87e0bfffffff]
[    4.663639] pci_bus 0000:00: root bus resource [mem 
0x87e0c6000000-0x87ffffffffff]
[    4.671448] iommu: Adding device 0000:00:01.0 to group 6
[    4.677031] iommu: Adding device 0000:00:06.0 to group 7
[    5.683787] pci 0000:00:09.0: VF(n) BAR0 space: [mem 
0x840000800000-0x8400008fffff 64bit] (contains BAR0 for 1 VFs)
[    5.694395] iommu: Adding device 0000:00:09.0 to group 8
[    5.699986] iommu: Adding device 0000:00:10.0 to group 9
[    5.705564] iommu: Adding device 0000:00:11.0 to group 10
[    5.711199] iommu: Adding device 0000:00:14.0 to group 11
[    5.716834] iommu: Adding device 0000:00:15.0 to group 12
[    5.722470] iommu: Adding device 0000:00:16.0 to group 13
[    5.728279] iommu: Adding device 0000:01:00.0 to group 6
[    5.733844] iommu: Adding device 0000:01:00.1 to group 6
[    5.739411] iommu: Adding device 0000:01:00.5 to group 6
[    5.744978] iommu: Adding device 0000:01:01.3 to group 6
[    5.750547] iommu: Adding device 0000:01:06.0 to group 6
[    5.756115] iommu: Adding device 0000:01:06.1 to group 6
[    5.761680] iommu: Adding device 0000:01:06.2 to group 6
[    5.767243] iommu: Adding device 0000:01:06.3 to group 6
[    5.772808] iommu: Adding device 0000:01:06.4 to group 6
[    5.778373] iommu: Adding device 0000:01:06.5 to group 6
[    5.783947] iommu: Adding device 0000:01:06.6 to group 6
[    5.789511] iommu: Adding device 0000:01:06.7 to group 6
[    5.795076] iommu: Adding device 0000:01:07.0 to group 6
[    5.800640] iommu: Adding device 0000:01:07.1 to group 6
[    5.806206] iommu: Adding device 0000:01:07.2 to group 6
[    5.815374] pci 0000:01:00.0: disabling ASPM on pre-1.1 PCIe device. 
  You can enable it with 'pcie_aspm=force'
[    5.825766] iommu: Adding device 0000:02:00.0 to group 11
[    5.831182] pci 0000:02:00.0: disabling ASPM on pre-1.1 PCIe device. 
  You can enable it with 'pcie_aspm=force'
[    5.841533] iommu: Adding device 0000:03:00.0 to group 12
[    5.846949] pci 0000:03:00.0: disabling ASPM on pre-1.1 PCIe device. 
  You can enable it with 'pcie_aspm=force'
[    5.857297] iommu: Adding device 0000:04:00.0 to group 13
[    5.862712] pci 0000:04:00.0: disabling ASPM on pre-1.1 PCIe device. 
  You can enable it with 'pcie_aspm=force'
[    5.873315] pci 0000:00:01.0: PCI bridge to [bus 01]
[    5.878291] pci 0000:00:14.0: PCI bridge to [bus 02]
[    5.883257] pci 0000:00:15.0: PCI bridge to [bus 03]
[    5.888222] pci 0000:00:16.0: PCI bridge to [bus 04]
[    5.893758] PCI host bridge /soc@0/pci@8490,00000000 ranges:
[    5.899426]   MEM 0x810000000000..0x817fffffffff -> 0x810000000000
[    5.905882] pci-host-generic 849000000000.pci: PCI host bridge to bus 
0001:00
[    5.913017] pci_bus 0001:00: root bus resource [bus 00-1f]
[    5.918497] pci_bus 0001:00: root bus resource [mem 
0x810000000000-0x817fffffffff]
[    5.926371] iommu: Adding device 0001:00:04.0 to group 14
[    5.932094] iommu: Adding device 0001:00:05.0 to group 15
[    5.937811] iommu: Adding device 0001:00:06.0 to group 16
[    5.943540] iommu: Adding device 0001:00:07.0 to group 17
[    5.949582] PCI host bridge /soc@0/pci@84a0,00000000 ranges:
[    5.955249]   MEM 0x842000000000..0x843fffffffff -> 0x842000000000
[    5.961693] pci-host-generic 84a000000000.pci: PCI host bridge to bus 
0002:00
[    5.968828] pci_bus 0002:00: root bus resource [bus 00-1f]
[    5.974308] pci_bus 0002:00: root bus resource [mem 
0x842000000000-0x843fffffffff]
[    5.982150] iommu: Adding device 0002:00:02.0 to group 18
[    5.987890] iommu: Adding device 0002:00:03.0 to group 19
[    6.995785] pci 0002:01:00.0: VF(n) BAR0 space: [mem 
0x8430a0000000-0x8430afffffff 64bit] (contains BAR0 for 128 VFs)
[    7.006397] pci 0002:01:00.0: VF(n) BAR4 space: [mem 
0x8430e0000000-0x8430efffffff 64bit] (contains BAR4 for 128 VFs)
[    7.017331] iommu: Adding device 0002:01:00.0 to group 18
[    7.022746] pci 0002:01:00.0: disabling ASPM on pre-1.1 PCIe device. 
  You can enable it with 'pcie_aspm=force'
[    7.033334] pci 0002:00:02.0: PCI bridge to [bus 01]
[    7.038398] PCI host bridge /soc@0/pci@84b0,00000000 ranges:
[    7.044066]   MEM 0x818000000000..0x81ffffffffff -> 0x818000000000
[    7.050512] pci-host-generic 84b000000000.pci: PCI host bridge to bus 
0003:00
[    7.057647] pci_bus 0003:00: root bus resource [bus 00-1f]
[    7.063127] pci_bus 0003:00: root bus resource [mem 
0x818000000000-0x81ffffffffff]
[    7.071425] PCI host bridge /soc@0/pci@87e0,c2000000 ranges:
[    7.077095]    IO 0x88b000020000..0x88b00002ffff -> 0x00020000
[    7.082933]   MEM 0x889010000000..0x889fffffffff -> 0x10000000
[    7.088769]   MEM 0x88a000000000..0x88afffffffff -> 0x1000000000
[    7.094774]   MEM 0x87e0c2000000..0x87e0c2ffffff -> 0x87e0c2000000
[    7.101906] pci_thunder_pem 88808f000000.pci: PCI host bridge to bus 
0004:8f
[    7.108954] pci_bus 0004:8f: root bus resource [bus 8f-c7]
[    7.114435] pci_bus 0004:8f: root bus resource [io  0x0000-0xffff] 
(bus address [0x20000-0x2ffff])
[    7.123387] pci_bus 0004:8f: root bus resource [mem 
0x889010000000-0x889fffffffff] (bus address [0x10000000-0xfffffffff])
[    7.134335] pci_bus 0004:8f: root bus resource [mem 
0x88a000000000-0x88afffffffff pref] (bus address 
[0x1000000000-0x1fffffffff])
[    7.146009] pci_bus 0004:8f: root bus resource [mem 
0x87e0c2000000-0x87e0c2ffffff]
[    7.153949] iommu: Adding device 0004:8f:00.0 to group 20
[    7.159396] pci 0004:8f:00.0: Primary bus is hard wired to 0
[    7.165241] pci 0004:90:00.0: Max Payload Size set to 256 (was 128, 
max 2048)
[    7.172713] iommu: Adding device 0004:90:00.0 to group 20
[    7.183967] pci 0004:91:00.0: Max Payload Size set to 256 (was 128, 
max 2048)
[    7.191391] iommu: Adding device 0004:91:00.0 to group 20
[    7.196864] pci 0004:91:08.0: Max Payload Size set to 256 (was 128, 
max 2048)
[    7.204283] iommu: Adding device 0004:91:08.0 to group 20
[    7.209747] pci 0004:91:09.0: Max Payload Size set to 256 (was 128, 
max 2048)
[    7.217184] iommu: Adding device 0004:91:09.0 to group 20
[    7.222649] pci 0004:91:08.0: bridge configuration invalid ([bus 
00-00]), reconfiguring
[    7.230656] pci 0004:91:09.0: bridge configuration invalid ([bus 
00-00]), reconfiguring
[    7.238796] pci 0004:92:00.0: reg 0x10: initial BAR value 0x00000000 
invalid
[    7.245855] pci 0004:92:00.0: reg 0x14: initial BAR value 
0x889010100000 invalid
[    7.253277] pci 0004:92:00.0: Max Payload Size set to 256 (was 128, 
max 4096)
[    7.260535] pci 0004:92:00.0: VF(n) BAR0 space: [mem 
0x00000000-0x000fffff 64bit] (contains BAR0 for 16 VFs)
[    7.270592] iommu: Adding device 0004:92:00.0 to group 20
[    7.284074] pci 0004:94:00.0: reg 0x10: initial BAR value 0x00000000 
invalid
[    7.291168] pci 0004:94:00.0: Max Payload Size set to 256 (was 128, 
max 4096)
[    7.298426] pci 0004:94:00.0: VF(n) BAR0 space: [mem 
0x00000000-0x000fffff 64bit] (contains BAR0 for 16 VFs)
[    7.308498] iommu: Adding device 0004:94:00.0 to group 20
[    7.320615] pci 0004:8f:00.0: BAR 14: assigned [mem 
0x889010000000-0x8890106fffff]
[    7.328183] pci 0004:8f:00.0: BAR 15: assigned [mem 
0x88a000000000-0x88a0003fffff 64bit pref]
[    7.336702] pci 0004:8f:00.0: BAR 6: assigned [mem 
0x889010700000-0x88901070ffff pref]
[    7.344612] pci 0004:8f:00.0: BAR 13: assigned [io  0x1000-0x2fff]
[    7.350793] pci 0004:90:00.0: BAR 14: assigned [mem 
0x889010000000-0x8890105fffff]
[    7.358357] pci 0004:90:00.0: BAR 15: assigned [mem 
0x88a000000000-0x88a0003fffff 64bit pref]
[    7.366875] pci 0004:90:00.0: BAR 0: assigned [mem 
0x889010600000-0x88901063ffff]
[    7.374354] pci 0004:90:00.0: BAR 13: assigned [io  0x1000-0x2fff]
[    7.380536] pci 0004:91:00.0: BAR 14: assigned [mem 
0x889010000000-0x8890102fffff]
[    7.388100] pci 0004:91:00.0: BAR 15: assigned [mem 
0x88a000000000-0x88a0001fffff 64bit pref]
[    7.396618] pci 0004:91:09.0: BAR 14: assigned [mem 
0x889010300000-0x8890105fffff]
[    7.404181] pci 0004:91:09.0: BAR 15: assigned [mem 
0x88a000200000-0x88a0003fffff 64bit pref]
[    7.412698] pci 0004:91:00.0: BAR 13: assigned [io  0x1000-0x1fff]
[    7.418872] pci 0004:91:09.0: BAR 13: assigned [io  0x2000-0x2fff]
[    7.425053] pci 0004:92:00.0: BAR 6: assigned [mem 
0x889010000000-0x8890100fffff pref]
[    7.432964] pci 0004:92:00.0: BAR 1: assigned [mem 
0x889010100000-0x88901010ffff 64bit]
[    7.440967] pci 0004:92:00.0: BAR 7: assigned [mem 
0x889010110000-0x88901020ffff 64bit]
[    7.448968] pci 0004:92:00.0: BAR 0: assigned [io  0x1000-0x10ff]
[    7.455058] pci 0004:91:00.0: PCI bridge to [bus 92]
[    7.460018] pci 0004:91:00.0:   bridge window [io  0x1000-0x1fff]
[    7.466106] pci 0004:91:00.0:   bridge window [mem 
0x889010000000-0x8890102fffff]
[    7.473582] pci 0004:91:00.0:   bridge window [mem 
0x88a000000000-0x88a0001fffff 64bit pref]
[    7.482013] pci 0004:91:08.0: PCI bridge to [bus 93]
[    7.486981] pci 0004:94:00.0: BAR 6: assigned [mem 
0x889010300000-0x8890103fffff pref]
[    7.494892] pci 0004:94:00.0: BAR 1: assigned [mem 
0x889010400000-0x88901040ffff 64bit]
[    7.502895] pci 0004:94:00.0: BAR 7: assigned [mem 
0x889010410000-0x88901050ffff 64bit]
[    7.510896] pci 0004:94:00.0: BAR 0: assigned [io  0x2000-0x20ff]
[    7.516987] pci 0004:91:09.0: PCI bridge to [bus 94]
[    7.521946] pci 0004:91:09.0:   bridge window [io  0x2000-0x2fff]
[    7.528033] pci 0004:91:09.0:   bridge window [mem 
0x889010300000-0x8890105fffff]
[    7.535509] pci 0004:91:09.0:   bridge window [mem 
0x88a000200000-0x88a0003fffff 64bit pref]
[    7.543940] pci 0004:90:00.0: PCI bridge to [bus 91-94]
[    7.549160] pci 0004:90:00.0:   bridge window [io  0x1000-0x2fff]
[    7.555247] pci 0004:90:00.0:   bridge window [mem 
0x889010000000-0x8890105fffff]
[    7.562724] pci 0004:90:00.0:   bridge window [mem 
0x88a000000000-0x88a0003fffff 64bit pref]
[    7.571155] pci 0004:8f:00.0: PCI bridge to [bus 90-94]
[    7.576374] pci 0004:8f:00.0:   bridge window [io  0x1000-0x2fff]
[    7.582462] pci 0004:8f:00.0:   bridge window [mem 
0x889010000000-0x8890106fffff]
[    7.589938] pci 0004:8f:00.0:   bridge window [mem 
0x88a000000000-0x88a0003fffff 64bit pref]
[    7.598403] pcieport 0004:8f:00.0: enabling device (0506 -> 0507)
[    7.604893] pcieport 0004:8f:00.0: Signaling PME through PCIe PME 
interrupt
[    7.611862] pci 0004:90:00.0: Signaling PME through PCIe PME interrupt
[    7.618384] pci 0004:91:00.0: Signaling PME through PCIe PME interrupt
[    7.624908] pci 0004:92:00.0: Signaling PME through PCIe PME interrupt
[    7.631438] pci 0004:91:08.0: Signaling PME through PCIe PME interrupt
[    7.637958] pci 0004:91:09.0: Signaling PME through PCIe PME interrupt
[    7.644478] pci 0004:94:00.0: Signaling PME through PCIe PME interrupt
[    7.651672] pciehp 0004:91:00.0:pcie24: Slot #64 AttnBtn+ PwrCtrl+ 
MRL+ AttnInd+ PwrInd+ HotPlug+ Surprise- Interlock- NoCompl- LLActRep+
[    7.664702] pcieport 0004:91:09.0: enabling device (0000 -> 0003)
[    7.670996] pciehp 0004:91:09.0:pcie24: Slot #73 AttnBtn+ PwrCtrl+ 
MRL+ AttnInd+ PwrInd+ HotPlug+ Surprise- Interlock- NoCompl- LLActRep+
[    7.683786] PCI host bridge /soc@0/pci@87e0,c5000000 ranges:
[    7.689454]    IO 0x89b000050000..0x89b00005ffff -> 0x00050000
[    7.695292]   MEM 0x899010000000..0x899fffffffff -> 0x10000000
[    7.701129]   MEM 0x89a000000000..0x89afffffffff -> 0x1000000000
[    7.707134]   MEM 0x87e0c5000000..0x87e0c5ffffff -> 0x87e0c5000000
[    7.714262] pci_thunder_pem 89808f000000.pci: PCI host bridge to bus 
0005:8f
[    7.721311] pci_bus 0005:8f: root bus resource [bus 8f-c7]
[    7.726792] pci_bus 0005:8f: root bus resource [io  0x10000-0x1ffff] 
(bus address [0x50000-0x5ffff])
[    7.735917] pci_bus 0005:8f: root bus resource [mem 
0x899010000000-0x899fffffffff] (bus address [0x10000000-0xfffffffff])
[    7.746866] pci_bus 0005:8f: root bus resource [mem 
0x89a000000000-0x89afffffffff pref] (bus address 
[0x1000000000-0x1fffffffff])
[    7.758508] pci_bus 0005:8f: root bus resource [mem 
0x87e0c5000000-0x87e0c5ffffff]
[    7.766445] iommu: Adding device 0005:8f:00.0 to group 21
[    7.771891] pci 0005:8f:00.0: Primary bus is hard wired to 0
[    7.777715] pci 0005:90:00.0: reg 0x14: initial BAR value 
0x899020000000 invalid
[    7.785123] pci 0005:90:00.0: reg 0x1c: initial BAR value 
0x899030000000 invalid
[    7.792543] pci 0005:90:00.0: can't set Max Payload Size to 256; if 
necessary, use "pci=pcie_bus_safe" and report a bug
[    7.803569] iommu: Adding device 0005:90:00.0 to group 21
[    7.808970] vgaarb: device added: 
PCI:0005:90:00.0,decodes=io+mem,owns=none,locks=none
[    7.816973] pci 0005:90:00.1: can't set Max Payload Size to 256; if 
necessary, use "pci=pcie_bus_safe" and report a bug
[    7.827992] iommu: Adding device 0005:90:00.1 to group 21
[    7.840658] pci 0005:8f:00.0: BAR 15: assigned [mem 
0x89a000000000-0x89a017ffffff 64bit pref]
[    7.849181] pci 0005:8f:00.0: BAR 14: assigned [mem 
0x899010000000-0x8990117fffff]
[    7.856745] pci 0005:8f:00.0: BAR 6: assigned [mem 
0x899011800000-0x89901180ffff pref]
[    7.864655] pci 0005:8f:00.0: BAR 13: assigned [io  0x10000-0x10fff]
[    7.871012] pci 0005:90:00.0: BAR 1: assigned [mem 
0x89a000000000-0x89a00fffffff 64bit pref]
[    7.879450] pci 0005:90:00.0: BAR 3: assigned [mem 
0x89a010000000-0x89a011ffffff 64bit pref]
[    7.887886] pci 0005:90:00.0: BAR 0: assigned [mem 
0x899010000000-0x899010ffffff]
[    7.895364] pci 0005:90:00.0: BAR 6: assigned [mem 
0x899011000000-0x89901107ffff pref]
[    7.903275] pci 0005:90:00.1: BAR 0: assigned [mem 
0x899011080000-0x899011083fff]
[    7.910752] pci 0005:90:00.0: BAR 5: assigned [io  0x10000-0x1007f]
[    7.917018] pci 0005:8f:00.0: PCI bridge to [bus 90]
[    7.921977] pci 0005:8f:00.0:   bridge window [io  0x10000-0x10fff]
[    7.928238] pci 0005:8f:00.0:   bridge window [mem 
0x899010000000-0x8990117fffff]
[    7.935714] pci 0005:8f:00.0:   bridge window [mem 
0x89a000000000-0x89a017ffffff 64bit pref]
[    7.944179] pcieport 0005:8f:00.0: enabling device (0506 -> 0507)
[    7.950649] pcieport 0005:8f:00.0: Signaling PME through PCIe PME 
interrupt
[    7.957618] pci 0005:90:00.0: Signaling PME through PCIe PME interrupt
[    7.964140] pci 0005:90:00.1: Signaling PME through PCIe PME interrupt
.
.
.
# lspci -t
-+-[0005:8f]---00.0-[90]--+-00.0
  |                        \-00.1
  +-[0004:8f]---00.0-[90-94]----00.0-[91-94]--+-00.0-[92]----00.0
  |                                           +-08.0-[93]--
  |                                           \-09.0-[94]----00.0
  +-[0002:00]-+-02.0-[01]--+-00.0
  |           |            +-00.1
  |           |            +-00.2
  |           |            +-00.3
  |           |            +-00.4
  |           |            +-00.5
  |           |            +-00.6
  |           |            +-00.7
  |           |            +-01.0
  |           |            +-01.1
  |           |            +-01.2
  |           |            +-01.3
  |           |            +-01.4
  |           |            +-01.5
  |           |            +-01.6
  |           |            +-01.7
  |           |            +-02.0
  |           |            +-02.1
  |           |            +-02.2
  |           |            +-02.3
  |           |            +-02.4
  |           |            +-02.5
  |           |            +-02.6
  |           |            +-02.7
  |           |            \-03.0
  |           \-03.0
  +-[0001:00]-+-04.0
  |           +-05.0
  |           +-06.0
  |           \-07.0
  \-[0000:00]-+-01.0-[01]--+-00.0
              |            +-00.1
              |            +-00.5
              |            +-01.3
              |            +-06.0
              |            +-06.1
              |            +-06.2
              |            +-06.3
              |            +-06.4
              |            +-06.5
              |            +-06.6
              |            +-06.7
              |            +-07.0
              |            +-07.1
              |            +-07.2
              |            +-07.3
              |            +-07.4
              |            +-07.5
              |            +-07.6
              |            +-07.7
              |            +-09.0
              |            +-09.1
              |            +-09.2
              |            +-09.3
              |            +-09.4
              |            +-09.5
              |            +-0a.0
              |            +-0a.1
              |            +-0a.2
              |            +-0a.3
              |            \-10.0
              +-06.0
              +-09.0
              +-10.0
              +-11.0
              +-14.0-[02]----00.0
              +-15.0-[03]----00.0
              \-16.0-[04]----00.0


# lspci
0000:00:01.0 PCI bridge: Cavium, Inc. THUNDERX PCC Bridge (rev 08)
0000:00:06.0 System peripheral: Cavium, Inc. THUNDERX GPIO Controller 
(rev 08)
0000:00:09.0 Processing accelerators: Cavium, Inc. THUNDERX Random 
Number Generator (rev 08)
0000:00:10.0 USB controller: Cavium, Inc. THUNDERX xHCI USB Controller 
(rev 08)
0000:00:11.0 USB controller: Cavium, Inc. THUNDERX xHCI USB Controller 
(rev 08)
0000:00:14.0 PCI bridge: Cavium, Inc. THUNDERX PCC Bridge (rev 08)
0000:00:15.0 PCI bridge: Cavium, Inc. THUNDERX PCC Bridge (rev 08)
0000:00:16.0 PCI bridge: Cavium, Inc. THUNDERX PCC Bridge (rev 08)
0000:01:00.0 System peripheral: Cavium, Inc. THUNDERX MRML Bridge (rev 08)
0000:01:00.1 System peripheral: Cavium, Inc. THUNDERX Reset Controller 
(rev 08)
0000:01:00.5 System peripheral: Cavium, Inc. THUNDERX CCPI (Multi-node 
connect) (rev 08)
0000:01:01.3 Serial bus controller [0c80]: Cavium, Inc. THUNDERX SMI / 
MDIO Controller (rev 08)
0000:01:06.0 Memory controller: Cavium, Inc. THUNDERX L2C-TAD (rev 08)
0000:01:06.1 Memory controller: Cavium, Inc. THUNDERX L2C-TAD (rev 08)
0000:01:06.2 Memory controller: Cavium, Inc. THUNDERX L2C-TAD (rev 08)
0000:01:06.3 Memory controller: Cavium, Inc. THUNDERX L2C-TAD (rev 08)
0000:01:06.4 Memory controller: Cavium, Inc. THUNDERX L2C-TAD (rev 08)
0000:01:06.5 Memory controller: Cavium, Inc. THUNDERX L2C-TAD (rev 08)
0000:01:06.6 Memory controller: Cavium, Inc. THUNDERX L2C-TAD (rev 08)
0000:01:06.7 Memory controller: Cavium, Inc. THUNDERX L2C-TAD (rev 08)
0000:01:07.0 Memory controller: Cavium, Inc. THUNDERX L2C-CBC (rev 08)
0000:01:07.1 Memory controller: Cavium, Inc. THUNDERX L2C-CBC (rev 08)
0000:01:07.2 Memory controller: Cavium, Inc. THUNDERX L2C-CBC (rev 08)
0000:01:07.3 Memory controller: Cavium, Inc. THUNDERX L2C-CBC (rev 08)
0000:01:07.4 Memory controller: Cavium, Inc. THUNDERX L2C-MCI (rev 08)
0000:01:07.5 Memory controller: Cavium, Inc. THUNDERX L2C-MCI (rev 08)
0000:01:07.6 Memory controller: Cavium, Inc. THUNDERX L2C-MCI (rev 08)
0000:01:07.7 Memory controller: Cavium, Inc. THUNDERX L2C-MCI (rev 08)
0000:01:09.0 Serial bus controller [0c80]: Cavium, Inc. THUNDERX TWSI / 
I2C Controller (rev 08)
0000:01:09.1 Serial bus controller [0c80]: Cavium, Inc. THUNDERX TWSI / 
I2C Controller (rev 08)
0000:01:09.2 Serial bus controller [0c80]: Cavium, Inc. THUNDERX TWSI / 
I2C Controller (rev 08)
0000:01:09.3 Serial bus controller [0c80]: Cavium, Inc. THUNDERX TWSI / 
I2C Controller (rev 08)
0000:01:09.4 Serial bus controller [0c80]: Cavium, Inc. THUNDERX TWSI / 
I2C Controller (rev 08)
0000:01:09.5 Serial bus controller [0c80]: Cavium, Inc. THUNDERX TWSI / 
I2C Controller (rev 08)
0000:01:0a.0 Memory controller: Cavium, Inc. THUNDERX LMC (DRAM 
Controller) (rev 08)
0000:01:0a.1 Memory controller: Cavium, Inc. THUNDERX LMC (DRAM 
Controller) (rev 08)
0000:01:0a.2 Memory controller: Cavium, Inc. THUNDERX LMC (DRAM 
Controller) (rev 08)
0000:01:0a.3 Memory controller: Cavium, Inc. THUNDERX LMC (DRAM 
Controller) (rev 08)
0000:01:10.0 Network controller: Cavium, Inc. THUNDERX BGX (Common 
Ethernet Interface) (rev 08)
0000:02:00.0 RAID bus controller: Cavium, Inc. THUNDERX RAID Coprocessor 
(rev 08)
0000:03:00.0 Processing accelerators: Cavium, Inc. THUNDERX Zip 
Coprocessor (rev 08)
0000:04:00.0 Processing accelerators: Cavium, Inc. THUNDERX DFA (rev 08)
0001:00:04.0 SATA controller: Cavium, Inc. THUNDERX AHCI SATA Controller 
(rev 08)
0001:00:05.0 SATA controller: Cavium, Inc. THUNDERX AHCI SATA Controller 
(rev 08)
0001:00:06.0 SATA controller: Cavium, Inc. THUNDERX AHCI SATA Controller 
(rev 08)
0001:00:07.0 SATA controller: Cavium, Inc. THUNDERX AHCI SATA Controller 
(rev 08)
0002:00:02.0 PCI bridge: Cavium, Inc. THUNDERX PCC Bridge (rev 08)
0002:00:03.0 Network controller: Cavium, Inc. THUNDERX Traffic Network 
Switch (rev 08)
0002:01:00.0 Ethernet controller: Cavium, Inc. THUNDERX Network 
Interface Controller (rev 08)
0002:01:00.1 Ethernet controller: Cavium, Inc. Device a034 (rev 08)
0002:01:00.2 Ethernet controller: Cavium, Inc. Device a034 (rev 08)
0002:01:00.3 Ethernet controller: Cavium, Inc. Device a034 (rev 08)
0002:01:00.4 Ethernet controller: Cavium, Inc. Device a034 (rev 08)
0002:01:00.5 Ethernet controller: Cavium, Inc. Device a034 (rev 08)
0002:01:00.6 Ethernet controller: Cavium, Inc. Device a034 (rev 08)
0002:01:00.7 Ethernet controller: Cavium, Inc. Device a034 (rev 08)
0002:01:01.0 Ethernet controller: Cavium, Inc. Device a034 (rev 08)
0002:01:01.1 Ethernet controller: Cavium, Inc. Device a034 (rev 08)
0002:01:01.2 Ethernet controller: Cavium, Inc. Device a034 (rev 08)
0002:01:01.3 Ethernet controller: Cavium, Inc. Device a034 (rev 08)
0002:01:01.4 Ethernet controller: Cavium, Inc. Device a034 (rev 08)
0002:01:01.5 Ethernet controller: Cavium, Inc. Device a034 (rev 08)
0002:01:01.6 Ethernet controller: Cavium, Inc. Device a034 (rev 08)
0002:01:01.7 Ethernet controller: Cavium, Inc. Device a034 (rev 08)
0002:01:02.0 Ethernet controller: Cavium, Inc. Device a034 (rev 08)
0002:01:02.1 Ethernet controller: Cavium, Inc. Device a034 (rev 08)
0002:01:02.2 Ethernet controller: Cavium, Inc. Device a034 (rev 08)
0002:01:02.3 Ethernet controller: Cavium, Inc. Device a034 (rev 08)
0002:01:02.4 Ethernet controller: Cavium, Inc. Device a034 (rev 08)
0002:01:02.5 Ethernet controller: Cavium, Inc. Device a034 (rev 08)
0002:01:02.6 Ethernet controller: Cavium, Inc. Device a034 (rev 08)
0002:01:02.7 Ethernet controller: Cavium, Inc. Device a034 (rev 08)
0002:01:03.0 Ethernet controller: Cavium, Inc. Device a034 (rev 08)
0004:8f:00.0 PCI bridge: Cavium, Inc. Device a100 (rev 08)
0004:90:00.0 PCI bridge: PLX Technology, Inc. Device 8724 (rev ca)
0004:91:00.0 PCI bridge: PLX Technology, Inc. Device 8724 (rev ca)
0004:91:08.0 PCI bridge: PLX Technology, Inc. Device 8724 (rev ca)
0004:91:09.0 PCI bridge: PLX Technology, Inc. Device 8724 (rev ca)
0004:92:00.0 Serial Attached SCSI controller: LSI Logic / Symbios Logic 
SAS3008 PCI-Express Fusion-MPT SAS-3 (rev 02)
0004:94:00.0 Serial Attached SCSI controller: LSI Logic / Symbios Logic 
SAS3008 PCI-Express Fusion-MPT SAS-3 (rev 02)
0005:8f:00.0 PCI bridge: Cavium, Inc. Device a100 (rev 08)
0005:90:00.0 VGA compatible controller: NVIDIA Corporation GT218 
[GeForce 210] (rev a2)
0005:90:00.1 Audio device: NVIDIA Corporation High Definition Audio 
Controller (rev a1)

>
>>>>   5 files changed, 342 insertions(+)
>>>>   create mode 100644 Documentation/devicetree/bindings/pci/pci-thunder-pem.txt
>>>>   create mode 100644 drivers/pci/host/pci-thunder-pem.c
>>>>
>>
>>>> +
>>>> +static int thunder_pem_config_write(struct pci_bus *bus, unsigned int devfn,
>>>> +				    int where, int size, u32 val)
>>>> +{
>>>> +	struct gen_pci *pci = bus->sysdata;
>>>> +	struct thunder_pem_pci *pem_pci;
>>>> +
>>>> +	pem_pci = container_of(pci, struct thunder_pem_pci, gen_pci);
>>>> +
>>>> +	/*
>>>> +	 * The first device on the bus in the PEM PCIe bridge.
>>>> +	 * Special case its config access.
>>>> +	 */
>>>> +	if (bus->number == pci->cfg.bus_range->start) {
>>>> +		u64 write_val, read_val;
>>>> +
>>>> +		if (devfn != 0 || where >= 2048)
>>>> +			return PCIBIOS_DEVICE_NOT_FOUND;
>>>> +
>>>> +		/*
>>>> +		 * 32-bit accesses only.  If the write is for a size
>>>> +		 * smaller than 32-bits, we must first read the 32-bit
>>>> +		 * value and merge in the desired bits and then write
>>>> +		 * the whole 32-bits back out.
>>>> +		 */
>>>
>>> Ugh.  Another device that only supports 32-bit writes.  I guess this
>>> only affects this single device, and maybe you "know" that it has no
>>> registers where RW1C bits may be corrupted.  Although I suppose this
>>> device has the standard status registers (Status at 0x06, Secondary
>>> Status at 0x1e, Device Status in PCIe capability, etc.), which do
>>> contain RW1C bits.
>>
>> This device is exactly the specific PCIe host bridge implementation,
>> present on these SoCs.  The only sane way to access its config space
>> is via 32-bit operations.  We know that it presents the appropriate
>> Class and other registers to be recognized as, and operate as, a
>> standard PCIe bridge.
>
> The only sane way to manage spec-conformant 16-bit Command and Status
> Registers is to use 16-bit accesses.  Using a 32-bit read/modify/write
> cycle to emulate a 16-bit write to the Command register means that we
> inadvertently clear any RW1C bits that happened to be set in the
> adjacent Status register.
>
> Note that these are generic PCI-defined registers, and the code doing
> 16-bit accesses to them may be in the PCI core or possibly in a
> driver.  They're not ThunderX-specific registers, and it's not
> ThunderX-specific code.
>
>>> We need to print a warning at probe-time so we know to consider the
>>> possibility of corruption when debugging.
>>
>> If you really want it, I suppose I can add that, but I am somewhat hesitant.
>
> I think this is a serious quality of implementation issue, and I do
> not want to debug status bits that mysteriously get cleared when
> nothing in the PCI core code even touches them.  I at least want a
> hint.
>
> We have a warning in pcie-hisi.c already, and I intend to do something
> similar in tegra, xgene, and iproc, which use
> pci_generic_config_write32().  There are probably others that roll
> their own.  I'm thinking something along the lines of
> dev_warn("sub-32-bit writes may corrupt adjacent RW1C bits").
>
> I don't really like this either, so I'm open to better ideas.  I
> considered a one-time warning in pci_generic_config_write32(), but
> that would associate the message with the PCI device when the problem
> is in the host bridge, and obviously it wouldn't help for ThunderX
> anyway.
>

I will add a WARN_ONCE or similar. and send a new patch set.

FWIW, I think I have been able to get the message through to the 
hardware architects that building root complexes that are not exposed as 
PCI standard ECAMs makes things very difficult.  This was the original 
intention, but turned out not to be possible when we looked more closely 
at the hardware implementation.  I am optimistic that subsequent 
generations of Thunder will be much improved in this area.

Thanks for taking the time to look at the patches,
David Daney
