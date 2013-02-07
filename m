Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:57050 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754325Ab3BGQA0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Feb 2013 11:00:26 -0500
Date: Thu, 7 Feb 2013 17:00:20 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thierry Reding <thierry.reding@avionic-design.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>, linux-pci@vger.kernel.org,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130207170020.289bac08@skate>
In-Reply-To: <CAErSpo7UOTGH7kjYBADymDdgmHwPxbXqczeXm1BH9C+XViQDRQ@mail.gmail.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
	<5106F9F9.3010905@wwwdotorg.org>
	<20130129094143.1aad9377@skate>
	<20130129092006.GA16377@avionic-0098.mockup.avionic-design.de>
	<20130207112459.5f382ad4@skate>
	<CAErSpo7UOTGH7kjYBADymDdgmHwPxbXqczeXm1BH9C+XViQDRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Bjorn Helgaas,

On Thu, 7 Feb 2013 08:46:06 -0700, Bjorn Helgaas wrote:

> Can you post the entire dmesg log, ideally with CONFIG_PCI_DEBUG=y?
> That should have more information about the enumeration process,
> including what we think the XHCI BARs are and the apertures leading to
> them.

Sure, see below.

> The PCI core assumes that we know the host bridge apertures up front,
> and I'm not sure that is true on your platform, so maybe we'll need
> some changes to accommodate that.

In this hardware, we need to set up the address decoding windows. So
there shouldn't be any access to a PCI device memory or I/O region
until the addresses have been assigned in the PCI-to-PCI bridge.

Note that I am know setting up the address decoding window as soon as
the address is written into the PCI-to-PCI bridge. I am no longer
waiting the end of enumeration process, and then go through the
PCI-to-PCI bridge registers to configure them.

The system tested below is an Armada 370, it has only two PCIe links.
One is connected to a XHCI USB controller, the other one to an Intel
Wireless NIC.

First the dmesg when module_init() is used, which shows the crash:

===================================================================
Booting Linux on physical CPU 0x0
Linux version 3.8.0-rc5-00029-g80e55fd-dirty (thomas@skate) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #1313 SMP Thu Feb 7 16:53:32 CET 2013
CPU: ARMv7 Processor [561f5811] revision 1 (ARMv7), cr=10c53c7d
CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
Machine: Marvell Armada 370/XP (Device Tree), model: Globalscale Mirabox
bootconsole [earlycon0] enabled
Memory policy: ECC disabled, Data cache writeback
PERCPU: Embedded 7 pages/cpu @c128b000 s6464 r8192 d14016 u32768
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
Kernel command line: console=ttyS0,115200 earlyprintk
PID hash table entries: 2048 (order: 1, 8192 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
__ex_table already sorted, skipping sort
Memory: 512MB = 512MB total
Memory: 504860k/504860k available, 19428k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xe0800000 - 0xff000000   ( 488 MB)
    lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
    modules : 0xbf000000 - 0xbfe00000   (  14 MB)
      .text : 0xc0008000 - 0xc0467700   (4478 kB)
      .init : 0xc0468000 - 0xc0e30940   (10019 kB)
      .data : 0xc0e32000 - 0xc0e5f9c0   ( 183 kB)
       .bss : 0xc0e5f9c0 - 0xc0e84fdc   ( 150 kB)
Hierarchical RCU implementation.
	RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=1.
NR_IRQS:16 nr_irqs:16 16
Aurora cache controller enabled
l2x0: 4 ways, CACHE_ID 0x00000100, AUX_CTRL 0x1a086302, Cache size: 262144 B
sched_clock: 32 bits at 18MHz, resolution 53ns, wraps every 229064ms
Console: colour dummy device 80x30
Calibrating delay loop... 1196.85 BogoMIPS (lpj=5984256)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
CPU0: thread -1, cpu 0, socket -1, mpidr 0
Setting up static identity map for 0x351a28 - 0x351a80
Brought up 1 CPUs
SMP: Total of 1 processors activated (1196.85 BogoMIPS).
devtmpfs: initialized
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
DMA: preallocated 1024 KiB pool for atomic coherent allocations
irq: Cannot allocate irq_descs @ IRQ27, assuming pre-allocated
irq: Cannot allocate irq_descs @ IRQ63, assuming pre-allocated
irq: Cannot allocate irq_descs @ IRQ96, assuming pre-allocated
Initializing Coherency fabric
bio: create slab <bio-0> at 0
vgaarb: loaded
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
cfg80211: Calling CRDA to update world regulatory domain
Switching to clocksource armada_370_xp_clocksource
NET: Registered protocol family 2
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP: reno registered
UDP hash table entries: 256 (order: 1, 8192 bytes)
UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
msgmni has been set to 986
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
armada-370-pinctrl d0018000.pinctrl: registered pinctrl driver
mvebu-pcie pcie-controller.1: PCIe0.0: link up
mvebu-pcie pcie-controller.1: PCIe1.0: link up
mvebu-pcie pcie-controller.1: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0xc0000000-0xc000ffff]
pci_bus 0000:00: root bus resource [mem 0xc1000000-0xc8ffffff]
pci_bus 0000:00: root bus resource [bus 00-ff]
PCI: bus0: Fast back to back transfers disabled
pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:00:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
PCI: bus1: Fast back to back transfers disabled
PCI: bus2: Fast back to back transfers disabled
Unhandled fault: external abort on non-linefetch (0x1008) at 0xe0910010
Internal error: : 1008 [#1] SMP ARM
Modules linked in:
CPU: 0    Not tainted  (3.8.0-rc5-00029-g80e55fd-dirty #1313)
PC is at quirk_usb_handoff_xhci+0x5c/0x284
LR is at ioremap_pte_range+0x84/0xdc
pc : [<c023ba8c>]    lr : [<c0150944>]    psr: a0000013
sp : df82bce8  ip : df81c000  fp : c0e43dac
r10: 00008000  r9 : 00000000  r8 : de933000
r7 : e0910000  r6 : c04267a0  r5 : de933000  r4 : de933000
r3 : 01c801c8  r2 : 00000000  r1 : 42007e13  r0 : e0910000
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 1e960019  DAC: 00000015
Process swapper/0 (pid: 1, stack limit = 0xdf82a238)
Stack: (0xdf82bce8 to 0xdf82c000)
bce0:                   de933060 c01702f4 de933000 de933000 de933000 c04267a0
bd00: c0e5f9dc c023c108 de933060 c023c0e4 c04267a0 c023c168 c04267a0 c0178d98
bd20: c01a855c c033cab4 00000000 00000000 de935f6c c033cbb4 c0e497cc de933000
bd40: de935c14 de935c00 df82bde8 00000001 de919368 c016a958 00000000 de933000
bd60: de935c14 c016ab5c de933800 de918014 de935c00 c016abcc 00000000 00000001
bd80: de918000 c016d234 de919368 de9193d0 de919340 00000000 df82be14 c017a93c
bda0: de919368 df82be14 df82bde8 c0012ef8 f3cec23f c027b974 c0019da0 df805340
bdc0: f3cec23f df82bde8 c0e7ffe8 df82be14 df802b00 de917890 00000060 df89e400
bde0: 00000002 c00131dc df82bde8 df82bde8 c0e83318 00000000 de9193d0 de9178f0
be00: df802b00 c047a010 df89e410 00000000 00000000 c0e49cac 00000001 df82be54
be20: c047a0b4 c017a90c 00000000 00000000 00000000 c047a054 c1000000 c8ffffff
be40: c12885f0 00000200 00000000 00000000 00000000 de9193d0 df89e410 c0e81748
be60: c0e49c6c df89e410 00000000 c0e49c6c c048e9b8 c017a7c4 00000000 c01a8c24
be80: c01a8c0c c01a78e8 df89e410 c0e49c6c df89e444 00000000 c046823c c01a7bd8
bea0: c0e49c6c 00000000 c01a7b4c c01a632c df8067d8 df85a474 c0e49c6c c0e510c8
bec0: de919440 c01a7228 c0402548 c0e49c6c c0e49c6c df82a000 c0e5f9c0 00000000
bee0: c046823c c01a80d8 00000000 c0e49c58 df82a000 c0e5f9c0 00000000 c046823c
bf00: c017a7c4 c01a8e1c c0488260 df82a000 c0e5f9c0 c00086d4 c0444b18 00000006
bf20: 0000008b c017a7c4 0000008b 00000006 00000006 c046823c c1288b15 00000000
bf40: c0e42194 c0488260 00000006 c0488240 c0e5f9c0 c046823c c048e9b8 0000008b
bf60: 00000000 c04688b0 00000006 00000006 c046823c 00000000 c048e708 c048e708
bf80: 00000000 00000000 00000000 00000000 00000000 c0468958 00000000 00000000
bfa0: c033f3ac c033f3b4 00000000 c000dfd8 00000000 00000000 00000000 00000000
bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
bfe0: 00000000 00000000 00000000 00000000 00000013 00000000 2254c9ef c6885425
[<c023ba8c>] (quirk_usb_handoff_xhci+0x5c/0x284) from [<c023c0e4>] (quirk_usb_early_handoff.part.1+0xc0/0xe4)
[<c023c0e4>] (quirk_usb_early_handoff.part.1+0xc0/0xe4) from [<c0178d98>] (pci_do_fixups+0xc4/0x17c)
[<c0178d98>] (pci_do_fixups+0xc4/0x17c) from [<c016a958>] (pci_bus_add_device+0x14/0x60)
[<c016a958>] (pci_bus_add_device+0x14/0x60) from [<c016ab5c>] (pci_bus_add_devices+0x44/0x128)
[<c016ab5c>] (pci_bus_add_devices+0x44/0x128) from [<c016abcc>] (pci_bus_add_devices+0xb4/0x128)
[<c016abcc>] (pci_bus_add_devices+0xb4/0x128) from [<c016d234>] (pci_scan_root_bus+0x7c/0xcc)
[<c016d234>] (pci_scan_root_bus+0x7c/0xcc) from [<c017a93c>] (mvebu_pcie_scan_bus+0x30/0x3c)
[<c017a93c>] (mvebu_pcie_scan_bus+0x30/0x3c) from [<c0012ef8>] (pcibios_init_hw+0x5c/0x15c)
[<c0012ef8>] (pcibios_init_hw+0x5c/0x15c) from [<c00131dc>] (pci_common_init+0x44/0xc4)
[<c00131dc>] (pci_common_init+0x44/0xc4) from [<c047a010>] (mvebu_pcie_probe+0x360/0x3a4)
[<c047a010>] (mvebu_pcie_probe+0x360/0x3a4) from [<c01a8c24>] (platform_drv_probe+0x18/0x1c)
[<c01a8c24>] (platform_drv_probe+0x18/0x1c) from [<c01a78e8>] (really_probe+0x60/0x1e0)
[<c01a78e8>] (really_probe+0x60/0x1e0) from [<c01a7bd8>] (__driver_attach+0x8c/0x90)
[<c01a7bd8>] (__driver_attach+0x8c/0x90) from [<c01a632c>] (bus_for_each_dev+0x50/0x7c)
[<c01a632c>] (bus_for_each_dev+0x50/0x7c) from [<c01a7228>] (bus_add_driver+0x168/0x22c)
[<c01a7228>] (bus_add_driver+0x168/0x22c) from [<c01a80d8>] (driver_register+0x78/0x144)
[<c01a80d8>] (driver_register+0x78/0x144) from [<c01a8e1c>] (platform_driver_probe+0x18/0xac)
[<c01a8e1c>] (platform_driver_probe+0x18/0xac) from [<c00086d4>] (do_one_initcall+0x34/0x174)
[<c00086d4>] (do_one_initcall+0x34/0x174) from [<c04688b0>] (do_basic_setup+0x90/0xc4)
[<c04688b0>] (do_basic_setup+0x90/0xc4) from [<c0468958>] (kernel_init_freeable+0x74/0x10c)
[<c0468958>] (kernel_init_freeable+0x74/0x10c) from [<c033f3b4>] (kernel_init+0x8/0xe4)
[<c033f3b4>] (kernel_init+0x8/0xe4) from [<c000dfd8>] (ret_from_fork+0x14/0x3c)
Code: e3a02000 ebf76e4e e2507000 0afffff7 (e5973010) 
---[ end trace 7097ba2281051df7 ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
===================================================================

And now, the dmesg when the PCIe driver is initialized at the
subsys_initcall() level, no crash happens, and everything works fine.

===================================================================
Booting Linux on physical CPU 0x0
Linux version 3.8.0-rc5-00029-g80e55fd-dirty (thomas@skate) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #1314 SMP Thu Feb 7 16:57:39 CET 2013
CPU: ARMv7 Processor [561f5811] revision 1 (ARMv7), cr=10c53c7d
CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
Machine: Marvell Armada 370/XP (Device Tree), model: Globalscale Mirabox
bootconsole [earlycon0] enabled
Memory policy: ECC disabled, Data cache writeback
PERCPU: Embedded 7 pages/cpu @c128b000 s6464 r8192 d14016 u32768
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
Kernel command line: console=ttyS0,115200 earlyprintk
PID hash table entries: 2048 (order: 1, 8192 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
__ex_table already sorted, skipping sort
Memory: 512MB = 512MB total
Memory: 504860k/504860k available, 19428k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xe0800000 - 0xff000000   ( 488 MB)
    lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
    modules : 0xbf000000 - 0xbfe00000   (  14 MB)
      .text : 0xc0008000 - 0xc0467700   (4478 kB)
      .init : 0xc0468000 - 0xc0e30940   (10019 kB)
      .data : 0xc0e32000 - 0xc0e5f9c0   ( 183 kB)
       .bss : 0xc0e5f9c0 - 0xc0e84fdc   ( 150 kB)
Hierarchical RCU implementation.
	RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=1.
NR_IRQS:16 nr_irqs:16 16
Aurora cache controller enabled
l2x0: 4 ways, CACHE_ID 0x00000100, AUX_CTRL 0x1a086302, Cache size: 262144 B
sched_clock: 32 bits at 18MHz, resolution 53ns, wraps every 229064ms
Console: colour dummy device 80x30
Calibrating delay loop... 1196.85 BogoMIPS (lpj=5984256)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
CPU0: thread -1, cpu 0, socket -1, mpidr 0
Setting up static identity map for 0x351a28 - 0x351a80
Brought up 1 CPUs
SMP: Total of 1 processors activated (1196.85 BogoMIPS).
devtmpfs: initialized
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
DMA: preallocated 1024 KiB pool for atomic coherent allocations
irq: Cannot allocate irq_descs @ IRQ27, assuming pre-allocated
irq: Cannot allocate irq_descs @ IRQ63, assuming pre-allocated
irq: Cannot allocate irq_descs @ IRQ96, assuming pre-allocated
Initializing Coherency fabric
bio: create slab <bio-0> at 0
mvebu-pcie pcie-controller.1: PCIe0.0: link up
mvebu-pcie pcie-controller.1: PCIe1.0: link up
mvebu-pcie pcie-controller.1: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0xc0000000-0xc000ffff]
pci_bus 0000:00: root bus resource [mem 0xc1000000-0xc8ffffff]
pci_bus 0000:00: root bus resource [bus 00-ff]
PCI: bus0: Fast back to back transfers disabled
pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:00:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
PCI: bus1: Fast back to back transfers disabled
PCI: bus2: Fast back to back transfers disabled
Getting IRQ slot 1, pin 1...
Cannot get irq... 135
Getting IRQ slot 2, pin 1...
Cannot get irq... 135
Getting IRQ slot 1, pin 1...
Getting IRQ slot 2, pin 1...
pci 0000:00:01.0: BAR 8: assigned [mem 0xc1000000-0xc10fffff]
pci 0000:00:02.0: BAR 8: assigned [mem 0xc1100000-0xc11fffff]
pci 0000:01:00.0: BAR 0: assigned [mem 0xc1000000-0xc1001fff 64bit]
pci 0000:00:01.0: PCI bridge to [bus 01]
pci 0000:00:01.0:   bridge window [mem 0xc1000000-0xc10fffff]
pci 0000:02:00.0: BAR 0: assigned [mem 0xc1100000-0xc1107fff 64bit]
pci 0000:00:02.0: PCI bridge to [bus 02]
pci 0000:00:02.0:   bridge window [mem 0xc1100000-0xc11fffff]
PCI: enabling device 0000:00:01.0 (0140 -> 0143)
PCI: enabling device 0000:00:02.0 (0140 -> 0143)
vgaarb: loaded
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
cfg80211: Calling CRDA to update world regulatory domain
Switching to clocksource armada_370_xp_clocksource
NET: Registered protocol family 2
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP: reno registered
UDP hash table entries: 256 (order: 1, 8192 bytes)
UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
msgmni has been set to 986
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
armada-370-pinctrl d0018000.pinctrl: registered pinctrl driver
mv_xor d0060800.xor: Marvell XOR driver
mv_xor d0060800.xor: Marvell XOR: ( xor cpy )
mv_xor d0060800.xor: Marvell XOR: ( xor fill cpy )
mv_xor d0060900.xor: Marvell XOR driver
mv_xor d0060900.xor: Marvell XOR: ( xor cpy )
mv_xor d0060900.xor: Marvell XOR: ( xor fill cpy )
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
d0012000.serial: ttyS0 at MMIO 0xd0012000 (irq = 17) is a 8250
console [ttyS0] enabled, bootconsole disabled
console [ttyS0] enabled, bootconsole disabled
e1000e: Intel(R) PRO/1000 Network Driver - 2.1.4-k
e1000e: Copyright(c) 1999 - 2012 Intel Corporation.
libphy: orion_mdio_bus: probed
mvneta d0070000.ethernet eth0: mac: fe:4b:b2:e2:64:ca
mvneta d0074000.ethernet eth1: mac: 56:dd:1a:9e:e0:aa
Intel(R) Wireless WiFi driver for Linux, in-tree:
Copyright(c) 2003-2012 Intel Corporation
iwlwifi 0000:01:00.0: pci_enable_msi failed(0Xffffffff)
iwlwifi 0000:01:00.0: loaded firmware version 8.83.5.1 build 33692
iwlwifi 0000:01:00.0: CONFIG_IWLWIFI_DEBUG disabled
iwlwifi 0000:01:00.0: CONFIG_IWLWIFI_DEBUGFS disabled
iwlwifi 0000:01:00.0: CONFIG_IWLWIFI_DEVICE_TRACING disabled
iwlwifi 0000:01:00.0: CONFIG_IWLWIFI_DEVICE_TESTMODE disabled
iwlwifi 0000:01:00.0: CONFIG_IWLWIFI_P2P enabled
iwlwifi 0000:01:00.0: Detected Intel(R) Ultimate N WiFi Link 5300 AGN, REV=0x24
iwlwifi 0000:01:00.0: L1 Disabled; Enabling L0S
xhci_hcd 0000:02:00.0: xHCI Host Controller
xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 1
xhci_hcd 0000:02:00.0: irq 99, io mem 0xc1100000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
xhci_hcd 0000:02:00.0: xHCI Host Controller
xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
mousedev: PS/2 mouse device common for all mice
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
TCP: cubic registered
VFP support v0.3: implementor 56 architecture 2 part 20 variant 9 rev 6
/home/thomas/projets/linux-2.6/drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
Freeing init memory: 10016K
Starting logging: OK
Starting mdev...
usb 1-1: new high-speed USB device number 2 using xhci_hcd
scsi0 : usb-storage 1-1:1.0
Initializing random number generator... done.
Starting network...

Welcome to Buildroot
buildroot login:
===================================================================

Do not hesitate to ask if you need more details about this.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
