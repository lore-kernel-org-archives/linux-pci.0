Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1443816007.7936.24.camel@oracle.com>
Subject: Re: [PATCH v6 01/53] sparc/PCI: Add mem64 resource parsing for root
 bus
From: Khalid Aziz <khalid.aziz@oracle.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Fri, 02 Oct 2015 14:00:07 -0600
In-Reply-To: <1443678807-786-2-git-send-email-yinghai@kernel.org>
References: <1443678807-786-1-git-send-email-yinghai@kernel.org>
	 <1443678807-786-2-git-send-email-yinghai@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2015-09-30 at 22:52 -0700, Yinghai Lu wrote:
> Found "no compatible bridge window" warning in boot log from T5-8.
> 
> pci 0000:00:01.0: can't claim BAR 15 [mem 0x100000000-0x4afffffff pref]: no compatible bridge window
> 
> That resource is above 4G, but does not get offset correctly as
> root bus only report io and mem32.
> 
> pci_sun4v f02dbcfc: PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [io  0x804000000000-0x80400fffffff] (bus address [0x0000-0xfffffff])
> pci_bus 0000:00: root bus resource [mem 0x800000000000-0x80007effffff] (bus address [0x00000000-0x7effffff])
> pci_bus 0000:00: root bus resource [bus 00-77]
> 
> Add mem64 handling in pci_common for sparc, so we can have 64bit resource
> registered for root bus at first.
> 
> After patch, will have:
> pci_sun4v f02dbcfc: PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [io  0x804000000000-0x80400fffffff] (bus address [0x0000-0xfffffff])
> pci_bus 0000:00: root bus resource [mem 0x800000000000-0x80007effffff] (bus address [0x00000000-0x7effffff])
> pci_bus 0000:00: root bus resource [mem 0x800100000000-0x8007ffffffff] (bus address [0x100000000-0x7ffffffff])
> pci_bus 0000:00: root bus resource [bus 00-77]
> 
> -v2: mem64_space should use mem_space.start as offset.
> -v3: add IORESOURCE_MEM_64 flag
> 
> Fixes: commit d63e2e1f3df9 ("sparc/PCI: Clip bridge windows to fit in upstream windows")
> Link: http://lkml.kernel.org/r/CAE9FiQU1gJY1LYrxs+ma5LCTEEe4xmtjRG0aXJ9K_Tsu+m9Wuw@mail.gmail.com
> Reported-by: David Ahern <david.ahern@oracle.com>
> Tested-by: David Ahern <david.ahern@oracle.com>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>

I am still seeing a large number of "can't claim BAR" and "no compatible
bridge window" messages on sparc after applying the entire patch series
to 4.3-rc3:

# dmesg | grep "n't claim"
pci 0000:71:00.0: can't claim BAR 0 [mem 0x2000480000000-0x20004800fffff
64bit]: no compatible bridge window
pci 0004:01:00.0: can't claim BAR 1 [mem
0x2004000100000-0x2004000103fff]: no compatible bridge window
pci 0004:01:00.0: can't claim BAR 6 [mem
0x2004000110000-0x200400011ffff]: no compatible bridge window
pci 0006:01:00.0: can't claim BAR 1 [mem 0x2021100000000-0x202110000ffff
64bit]: no compatible bridge window
pci 0006:01:00.0: can't claim BAR 3 [mem 0x2021100040000-0x202110007ffff
64bit]: no compatible bridge window
pci 0006:01:00.0: can't claim BAR 6 [mem
0x2021000100000-0x20210001fffff]: no compatible bridge window
pci 0009:01:00.0: can't claim BAR 0 [mem 0x2024100000000-0x20241001fffff
64bit pref]: no compatible bridge window
pci 0009:01:00.0: can't claim BAR 7 [mem 0x2024100304000-0x2024100403fff
64bit]: no compatible bridge window
pci 0009:01:00.0: can't claim BAR 10 [mem
0x2024100404000-0x2024100503fff 64bit]: no compatible bridge window
pci 0009:01:00.1: can't claim BAR 7 [mem 0x2024100508000-0x2024100607fff
64bit]: no compatible bridge window
pci 0009:01:00.1: can't claim BAR 10 [mem
0x2024100900000-0x20241009fffff 64bit]: no compatible bridge window
pci 000b:01:00.0: can't claim BAR 0 [mem 0x2041100000000-0x20411001fffff
64bit pref]: no compatible bridge window
pci 000b:01:00.0: can't claim BAR 7 [mem 0x2041100304000-0x2041100403fff
64bit]: no compatible bridge window
pci 000b:01:00.0: can't claim BAR 10 [mem
0x2041100404000-0x2041100503fff 64bit]: no compatible bridge window
pci 000b:01:00.1: can't claim BAR 7 [mem 0x2041100508000-0x2041100607fff
64bit]: no compatible bridge window
pci 000b:01:00.1: can't claim BAR 10 [mem
0x2041100900000-0x20411009fffff 64bit]: no compatible bridge window
pci 000b:02:00.0: can't claim BAR 1 [mem 0x2041110000000-0x204111000ffff
64bit]: no compatible bridge window
pci 000b:02:00.0: can't claim BAR 3 [mem 0x2041110040000-0x204111007ffff
64bit]: no compatible bridge window
pci 000b:02:00.0: can't claim BAR 6 [mem
0x2041000100000-0x20410001fffff]: no compatible bridge window
pci 000e:01:00.0: can't claim BAR 0 [mem 0x2044100000000-0x204410000ffff
64bit]: no compatible bridge window
pci 000e:01:00.0: can't claim BAR 2 [mem 0x2044100010000-0x2044100011fff
64bit]: no compatible bridge window
pci 0013:01:00.0: can't claim BAR 0 [mem 0x2064100000000-0x206410000ffff
64bit]: no compatible bridge window
pci 0013:01:00.0: can't claim BAR 2 [mem 0x2064100010000-0x2064100011fff
64bit]: no compatible bridge window
pci 0006:01:00.0: can't claim BAR 1 [mem size 0x00010000 64bit]: no
address assigned
pci 0006:01:00.0: can't claim BAR 3 [mem size 0x00040000 64bit]: no
address assigned
pci 000b:02:00.0: can't claim BAR 1 [mem size 0x00010000 64bit]: no
address assigned
pci 000b:02:00.0: can't claim BAR 3 [mem size 0x00040000 64bit]: no
address assigned

After applying this patch series, ixgbe driver failed to attach to two
of the NICs (PCI devices 0009:01:00.0 and 000b:01:00.0) on my sparc
machine. I tracked down the failure for 0009:01:00.0 and it looks like
BAR 0 could not be mapped by the driver. BAR 0 for this device wants to
be mapped at 0x2024100000000-0x20241001fffff:

PCI: Claiming 0009:01:00.0: Resource 0: 0002024100000000..00020241001fffff [10220c]

but 0002024100100000..00020241100fffff was allocated to the bridge above
this device which overlaps this address range:

PCI: Claiming 0009:00:01.0: Resource 14: 0002024100100000..00020241100fffff [10220c]

It seems when the bridge 0009:00:01.0 is scanned by
of_scan_pci_bridge(), it asks for range
0000000100000000-000000010fffffff:

    RAW Range[c3000000:00000001:00000000:c3000000:00000001:00000000:00000000:100
00000]
      Using flags[0010220c] start[0000000100000000] size[0000000010000000]

which pcibios_bus_to_resource() maps to
0002024100100000..00020241100fffff without considering this range might
overlap address range required by a device underneath the bridge later
when devices are scanned. This causes BAR0 mapping for the device under
the bridge to fail and driver fails to attach to the device.

Bus 9 on this machine looks like:

 +-[0009:00]---01.0-[01]--+-00.0  Intel Corporation Ethernet Controller 10-Gigabit X540-AT2
 |                        \-00.1  Intel Corporation Ethernet Controller 10-Gigabit X540-AT2


dmesg output with "debug ignore_loglevel ofpci_debug=1" for scan of bus
9 is below:

/pci@301: SUN4V PCI Bus Module
/pci@301: On NUMA node -1
/pci@301: PCI IO[2027e40000000] MEM[2024000100000] MEM64[2024100000000]
/pci@301: Unable to request IOMMU resource.
/pci@301: MSI Queue first[0] num[56] count[128] devino[0x6]
/pci@301: MSI first[0] num[1024] mask[0x3ff] width[32]
/pci@301: MSI addr32[0x7f000000:0x800000] addr64[0xe00000003f000000:0x800000]
/pci@301: MSI queues at RA [0000401f85a80000]
PCI: Scanning PBM /pci@301
pci_sun4v f0339c2c: PCI host bridge to bus 0009:00
pci_bus 0009:00: root bus resource [io  0x2027e40000000-0x2027e4fffffff] (bus address [0x0000-0xfffffff])
pci_bus 0009:00: root bus resource [mem 0x2024000100000-0x202407effffff] (bus address [0x00000000-0x7eefffff])
pci_bus 0009:00: root bus resource [mem 0x2024100000000-0x2024dffffffff] (bus address [0xfff00000-0xdffefffff])
pci_bus 0009:00: root bus resource [bus 00-01]
PCI: scan_bus[/pci@301] bus no 0
  * /pci@301/pci@1
    create device, devfn: 8, type: pciex
    class: 0x60400 device name: 0009:00:01.0
    adding to system ...
pci 0009:00:01.0: PME# supported from D0 D3hot D3cold
PCI: dev header type: 1
of_scan_pci_bridge(/pci@301/pci@1)
    Bridge bus range [1 --> 1]
    Bridge ranges[fff8401fdfca5180] simba[0]
    RAW Range[81000000:00000000:00000000:81000000:00000000:00000000:00000000:00001000]
      Using flags[00000101] start[0000000000000000] size[0000000000001000]
    RAW Range[c3000000:00000001:00000000:c3000000:00000001:00000000:00000000:10000000]
      Using flags[0010220c] start[0000000100000000] size[0000000010000000]
    bus name: PCI Bus 0009:01
PCI: scan_bus[/pci@301/pci@1] bus no 1
  * /pci@301/pci@1/network@0
    create device, devfn: 0, type: network
    class: 0x20000 device name: 0009:01:00.0
    parse addresses (60 bytes) @ fff8401fdfca3cc0
  start: 2024100000000, end: 20241001fffff, i: 10
  start: 2027e40000000, end: 2027e4000001f, i: 18
  start: 2024100200000, end: 2024100203fff, i: 20
    adding to system ...
pci 0009:01:00.0: PME# supported from D0 D3hot D3cold
pci 0009:01:00.0: reg 0x184: [mem 0x2024100304000-0x2024100307fff 64bit]
pci 0009:01:00.0: VF(n) BAR0 space: [mem 0x2024100304000-0x2024100403fff 64bit] (contains BAR0 for 64 VFs)
pci 0009:01:00.0: reg 0x190: [mem 0x2024100404000-0x2024100407fff 64bit]
pci 0009:01:00.0: VF(n) BAR3 space: [mem 0x2024100404000-0x2024100503fff 64bit] (contains BAR3 for 64 VFs)
PCI: dev header type: 0
  * /pci@301/pci@1/network@0,1
    create device, devfn: 1, type: network
    class: 0x20000 device name: 0009:01:00.1
    parse addresses (60 bytes) @ fff8401fdfca2080
  start: 2024100600000, end: 20241007fffff, i: 10
  start: 2027e40000020, end: 2027e4000003f, i: 18
  start: 2024100404000, end: 2024100407fff, i: 20
    adding to system ...
pci 0009:01:00.1: PME# supported from D0 D3hot D3cold
pci 0009:01:00.1: reg 0x184: [mem 0x2024100508000-0x202410050bfff 64bit]
pci 0009:01:00.1: VF(n) BAR0 space: [mem 0x2024100508000-0x2024100607fff 64bit] (contains BAR0 for 64 VFs)
pci 0009:01:00.1: reg 0x190: [mem 0x2024100900000-0x2024100903fff 64bit]
pci 0009:01:00.1: VF(n) BAR3 space: [mem 0x2024100900000-0x20241009fffff 64bit] (contains BAR3 for 64 VFs)
PCI: dev header type: 0
PCI: Claiming 0009:00:01.0: Resource 13: 0002027e40000000..0002027e40000fff [101]
PCI: Claiming 0009:00:01.0: Resource 14: 0002024100100000..00020241100fffff [10220c]
PCI: Claiming 0009:01:00.0: Resource 0: 0002024100000000..00020241001fffff [10220c]
pci 0009:01:00.0: can't claim BAR 0 [mem 0x2024100000000-0x20241001fffff 64bit pref]: no compatible bridge window
PCI: Claiming 0009:01:00.0: Resource 2: 0002027e40000000..0002027e4000001f [101]
PCI: Claiming 0009:01:00.0: Resource 4: 0002024100200000..0002024100203fff [10220c]
PCI: Claiming 0009:01:00.0: Resource 7: 0002024100304000..0002024100403fff [140204]
pci 0009:01:00.0: can't claim BAR 7 [mem 0x2024100304000-0x2024100403fff 64bit]: no compatible bridge window
PCI: Claiming 0009:01:00.0: Resource 10: 0002024100404000..0002024100503fff [140204]
pci 0009:01:00.0: can't claim BAR 10 [mem 0x2024100404000-0x2024100503fff 64bit]: no compatible bridge window
PCI: Claiming 0009:01:00.1: Resource 0: 0002024100600000..00020241007fffff [10220c]
PCI: Claiming 0009:01:00.1: Resource 2: 0002027e40000020..0002027e4000003f [101]
PCI: Claiming 0009:01:00.1: Resource 4: 0002024100404000..0002024100407fff [10220c]
PCI: Claiming 0009:01:00.1: Resource 7: 0002024100508000..0002024100607fff [140204]
pci 0009:01:00.1: can't claim BAR 7 [mem 0x2024100508000-0x2024100607fff 64bit]: no compatible bridge window
PCI: Claiming 0009:01:00.1: Resource 10: 0002024100900000..00020241009fffff [140204]
pci 0009:01:00.1: can't claim BAR 10 [mem 0x2024100900000-0x20241009fffff 64bit]: no compatible bridge window


--
Khalid



