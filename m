Return-Path: <SRS0=h9nn=2R=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=h9nn=2R=free.fr=slash.tmp@kernel.org>
Subject: Re: Implementing MSI support on my platform
From: Mason <slash.tmp@free.fr>
To: Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
 linux-usb <linux-usb@vger.kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <7c792694-f2ec-6aeb-440d-ae8ac27cb2d3@free.fr>
Message-ID: <324ff01b-e4df-c248-8c4a-041ba6f955bf@free.fr>
Date: Wed, 8 Mar 2017 14:11:59 +0100
MIME-Version: 1.0
In-Reply-To: <7c792694-f2ec-6aeb-440d-ae8ac27cb2d3@free.fr>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 07/03/2017 17:47, Mason wrote:

> As suggested by Marc, I'm trying to adapt
>   drivers/pci/host/pcie-altera-msi.c
> to my platform.

For my own reference, I have enabled verbose XHCI debug logs.
I have highlighted suspicious output with *****

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.9.7-1-rc2 (gcc version 5.3.1 20160113 (Linaro GCC 5.3-2016.02) ) #53 SMP PREEMPT Wed Mar 8 10:53:55 CET 2017
[    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] OF: fdt:Machine model: Sigma Designs SMP8758 Vantage-1172 Rev E1
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] On node 0 totalpages: 65536
[    0.000000] free_area_init_node: node 0, pgdat c1023980, node_mem_map cfdf9000
[    0.000000]   Normal zone: 512 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 65536 pages, LIFO batch:15
[    0.000000] percpu: Embedded 14 pages/cpu @cfdd7000 s24960 r8192 d24192 u57344
[    0.000000] pcpu-alloc: s24960 r8192 d24192 u57344 alloc=14*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
[    0.000000] Kernel command line: mem=256M ignore_loglevel console=ttyS0,115200 earlyprintk
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Memory: 243976K/262144K available (4096K kernel code, 147K rwdata, 900K rodata, 10240K init, 233K bss, 18168K reserved, 0K cma-reserved, 0K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xff800000   ( 752 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0500000   (5088 kB)
[    0.000000]       .init : 0xc0600000 - 0xc1000000   (10240 kB)
[    0.000000]       .data : 0xc1000000 - 0xc1024d20   ( 148 kB)
[    0.000000]        .bss : 0xc1024d20 - 0xc105f200   ( 234 kB)
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000]  Build-time adjustment of leaf fanout to 32.
[    0.000000]  RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=2
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310 ID prefetch enabled, offset 4 lines
[    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
[    0.000000] L2C-310 cache controller enabled, 8 ways, 512 kB
[    0.000000] L2C-310: CACHE_ID 0x410000c8, AUX_CTRL 0x72860401
[    0.000000] clocksource: tango-xtal: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 70787423951 ns
[    0.000004] sched_clock: 32 bits at 27MHz, resolution 37ns, wraps every 79536431085ns
[    0.007960] Switching to timer-based delay loop, resolution 37ns
[    0.014323] Console: colour dummy device 80x30
[    0.018896] Calibrating delay loop (skipped), value calculated using timer frequency.. 54.25 BogoMIPS (lpj=90000)
[    0.029314] pid_max: default: 32768 minimum: 301
[    0.034131] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.040871] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.048514] CPU: Testing write buffer coherency: ok
[    0.053725] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.059550] Setting up static identity map for 0x80100000 - 0x80100034
[    0.120459] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.120523] Brought up 2 CPUs
[    0.129374] SMP: Total of 2 processors activated (108.50 BogoMIPS).
[    0.135764] CPU: All CPU(s) started in SVC mode.
[    0.141062] devtmpfs: initialized
[    0.145449] VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
[    0.153552] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370867519511994 ns
[    0.163845] NET: Registered protocol family 16
[    0.169109] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.177113] tango_pcie_init
[    0.180010] [2e000] = ff000000
[    0.183187] [2e004] = ff000000
[    0.186346] [2e008] = ff000000
[    0.189515] [2e00c] = ff000000
[    0.192674] [2e010] = ff000000
[    0.195842] [2e014] = ff000000
[    0.199000] [2e018] = ff000000
[    0.202168] [2e01c] = ff000000
[    0.205326] [2e020] = 4ab099f2
[    0.208492] [2e024] = 88b09c82
[    0.211648] [2e028] = 2d529db1
[    0.214804] [2e02c] = 01b408c0
[    0.217964] [2e030] = 228d4863
[    0.221120] [2e034] = 84011011
[    0.224276] [2e038] = 83706004
[    0.227432] [2e03c] = 003ff8d1
[    0.230587] [2e040] = 00000000
[    0.233743] [2e044] = 00000000
[    0.236892] [2e048] = 00000000
[    0.240047] [2e04c] = 00000000
[    0.243202] [2e050] = 00000000
[    0.246358] [2e054] = 00000032
[    0.249513] [2e058] = 0024164d
[    0.252669] [2e05c] = 0915a401
[    0.255824] [2e060] = 00000034
[    0.258980] [2e064] = 00000050
[    0.262135] [2e068] = 00000100
[    0.265290] [2e06c] = 000ff636
[    0.268445] [2e070] = 0383fc7e
[    0.271601] [2e074] = 00010012
[    0.274756] [2e078] = 01010006
[    0.277912] [2e07c] = 00000000
[    0.281067] [2e080] = 00000000
[    0.284222] [2e084] = 00000000
[    0.287377] [2e088] = 00000000
[    0.290533] [2e08c] = 00000000
[    0.293688] [2e090] = 00000000
[    0.296837] [2e094] = 00000000
[    0.299992] [2e098] = 00000000
[    0.303147] [2e09c] = 00000000
[    0.306303] [2e0a0] = ffffffff
[    0.309458] [2e0a4] = ffffffff
[    0.312614] [2e0a8] = ffffffff
[    0.315769] [2e0ac] = ffffffff
[    0.318924] [2e0b0] = ffffffff
[    0.322080] [2e0b4] = ffffffff
[    0.325235] [2e0b8] = ffffffff
[    0.328391] [2e0bc] = ffffffff
[    0.331547] [2e0c0] = 00000000
[    0.334703] [2e0c4] = 00100001
[    0.337858] [2e0c8] = 00000000
[    0.341014] [2e0cc] = 00000040
[    0.344170] [2e0d0] = 000f0d02
[    0.347329] [2e0d4] = 000000a1
[    0.350486] [2e0d8] = 000000a1
[    0.353642] [2e0dc] = 000000a1
[    0.356791] [2e0e0] = 00000001
[    0.359946] [2e0e4] = 00000008
[    0.363102] [2e0e8] = ffffffff
[    0.366257] [2e0ec] = 00000400
[    0.369412] [2e0f0] = 00001f80
[    0.372568] [2e0f4] = 00000000
[    0.375723] [2e0f8] = 00006306
[    0.378878] [2e0fc] = 00000000
[    0.392183] altera_msi_probe: res=[mem 0x0002e080-0x0002e0bf flags 0x200] irq=22 ret=0
[    0.401041] SCSI subsystem initialized
[    0.405402] usbcore: registered new interface driver usbfs
[    0.411120] usbcore: registered new interface driver hub
[    0.416648] usbcore: registered new device driver usb
[    0.422997] clocksource: Switched to clocksource tango-xtal
[    0.438488] NET: Registered protocol family 2
[    0.443486] TCP established hash table entries: 2048 (order: 1, 8192 bytes)
[    0.450627] TCP bind hash table entries: 2048 (order: 2, 16384 bytes)
[    0.457230] TCP: Hash tables configured (established 2048 bind 2048)
[    0.463790] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    0.469782] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    0.476350] NET: Registered protocol family 1
[    0.481194] RPC: Registered named UNIX socket transport module.
[    0.487248] RPC: Registered udp transport module.
[    0.492068] RPC: Registered tcp transport module.
[    0.496886] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.503471] PCI: CLS 0 bytes, default 64
[    0.956028] futex hash table entries: 512 (order: 3, 32768 bytes)
[    0.962613] workingset: timestamp_bits=30 max_order=16 bucket_order=0
[    0.976391] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    0.983960] io scheduler noop registered
[    0.988012] io scheduler deadline registered
[    0.992432] io scheduler cfq registered (default)
[    0.997734] OF: PCI: host bridge /soc/pcie@50000000 ranges:
[    1.003459] OF: PCI: Parsing ranges property...
[    1.008118] OF: PCI:   MEM 0x58000000..0x5fffffff -> 0x08000000
[    1.015673] pci_tango 50000000.pcie: ECAM at [mem 0x50000000-0x57ffffff] for [bus 00-7f]
[    1.024093] pci_tango 50000000.pcie: PCI host bridge to bus 0000:00
[    1.030513] pci_bus 0000:00: root bus resource [bus 00-7f]
[    1.036124] pci_bus 0000:00: root bus resource [mem 0x58000000-0x5fffffff] (bus address [0x08000000-0x0fffffff])
[    1.046464] pci_bus 0000:00: scanning bus
[    1.050613] pci 0000:00:00.0: [1105:0024] type 01 class 0x048000
[    1.056775] pci 0000:00:00.0: calling tango_pcie_fixup_class+0x0/0x10
[    1.063363] tango_config_write: bus=0 where=16 size=4 val=0xffffffff
[    1.069846] tango_config_write: bus=0 where=16 size=4 val=0x4
[    1.075732] tango_config_write: bus=0 where=20 size=4 val=0xffffffff
[    1.082213] tango_config_write: bus=0 where=20 size=4 val=0x0
[    1.088086] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x00ffffff 64bit]
[    1.095004] tango_config_write: bus=0 where=56 size=4 val=0xfffff800
[    1.101483] tango_config_write: bus=0 where=56 size=4 val=0x0
[    1.107374] pci 0000:00:00.0: calling pci_fixup_ide_bases+0x0/0x40
[    1.113694] tango_config_write: bus=0 where=82 size=2 val=0x84
[    1.119696] pci 0000:00:00.0: supports D1 D2
[    1.124081] pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot
[    1.130213] tango_config_write: bus=0 where=124 size=2 val=0xe008
[    1.136431] pci 0000:00:00.0: PME# disabled
[    1.140732] tango_config_write: bus=0 where=2096 size=4 val=0x10000000
[    1.147387] tango_config_write: bus=0 where=2064 size=4 val=0x0
[    1.153430] tango_config_write: bus=0 where=2052 size=4 val=0x0
[    1.159612] pci_bus 0000:00: fixups for bus
[    1.163928] tango_config_write: bus=0 where=62 size=2 val=0x21
[    1.169898] tango_config_write: bus=0 where=4 size=2 val=0x140
[    1.175856] tango_config_write: bus=0 where=12 size=1 val=0x10
[    1.181823] PCI: bus0: Fast back to back transfers disabled
[    1.187533] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 0
[    1.194365] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    1.202516] tango_config_write: bus=0 where=62 size=2 val=0x1
[    1.208389] tango_config_write: bus=0 where=24 size=4 val=0x0
[    1.214258] tango_config_write: bus=0 where=62 size=2 val=0x1
[    1.220127] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
[    1.226956] tango_config_write: bus=0 where=62 size=2 val=0x1
[    1.232824] tango_config_write: bus=0 where=6 size=2 val=0xffff
[    1.238945] pci_bus 0000:01: busn_res: can not insert [bus 01-ff] under [bus 00-7f] (conflicts with (null) [bus 00-7f])

***** Is my "bus-range" spec invalid? Or is this an invalid warning?
http://lxr.free-electrons.com/source/drivers/pci/probe.c?v=4.9#L2284
int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int bus_max)

[    1.249893] tango_config_write: bus=0 where=24 size=4 val=0xff0100
[    1.256200] pci_bus 0000:01: scanning bus
[    1.260366] pci 0000:01:00.0: [1912:0014] type 00 class 0x0c0330
[    1.266520] tango_config_write: bus=1 where=16 size=4 val=0xffffffff
[    1.273006] tango_config_write: bus=1 where=16 size=4 val=0x4
[    1.278878] tango_config_write: bus=1 where=20 size=4 val=0xffffffff
[    1.285363] tango_config_write: bus=1 where=20 size=4 val=0x0
[    1.291236] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00001fff 64bit]
[    1.298161] tango_config_write: bus=1 where=24 size=4 val=0xffffffff
[    1.304645] tango_config_write: bus=1 where=24 size=4 val=0x0
[    1.310519] tango_config_write: bus=1 where=28 size=4 val=0xffffffff
[    1.317002] tango_config_write: bus=1 where=28 size=4 val=0x0
[    1.322876] tango_config_write: bus=1 where=32 size=4 val=0xffffffff
[    1.329358] tango_config_write: bus=1 where=32 size=4 val=0x0
[    1.335233] tango_config_write: bus=1 where=36 size=4 val=0xffffffff
[    1.341718] tango_config_write: bus=1 where=36 size=4 val=0x0
[    1.347593] tango_config_write: bus=1 where=48 size=4 val=0xfffff800
[    1.354075] tango_config_write: bus=1 where=48 size=4 val=0x0
[    1.359967] pci 0000:01:00.0: calling pci_fixup_ide_bases+0x0/0x40
[    1.366306] tango_config_write: bus=1 where=114 size=2 val=0x86
[    1.372366] tango_config_write: bus=1 where=146 size=2 val=0x7
[    1.378384] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    1.384605] tango_config_write: bus=1 where=84 size=2 val=0x8008
[    1.390736] pci 0000:01:00.0: PME# disabled
[    1.395054] tango_config_write: bus=1 where=272 size=4 val=0x0
[    1.401013] tango_config_write: bus=1 where=260 size=4 val=0x0
[    1.407084] tango_config_write: bus=1 where=176 size=2 val=0x0
[    1.413046] tango_config_write: bus=0 where=144 size=2 val=0x8
[    1.419004] tango_config_write: bus=0 where=144 size=2 val=0x28
[    1.433022] pci_bus 0000:01: fixups for bus
[    1.437325] tango_config_write: bus=1 where=4 size=2 val=0x140
[    1.443284] tango_config_write: bus=1 where=12 size=1 val=0x10
[    1.449239] PCI: bus1: Fast back to back transfers disabled
[    1.454934] pci_bus 0000:01: bus scan returning with max=01
[    1.460631] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01

***** [bus 00-7f] spec was ignored?

[    1.467373] tango_config_write: bus=0 where=26 size=1 val=0x1
[    1.473241] tango_config_write: bus=0 where=62 size=2 val=0x1
[    1.479109] pci_bus 0000:00: bus scan returning with max=01
[    1.484807] pci 0000:00:00.0: fixup irq: got 0
[    1.489364] pci 0000:00:00.0: assigning IRQ 00
[    1.493921] tango_config_write: bus=0 where=60 size=1 val=0x0

***** Offset 60 is "Interrupt Line".
Is this for legacy INTx interrupts?

[    1.499813] pci 0000:01:00.0: fixup irq: got 20
[    1.504459] pci 0000:01:00.0: assigning IRQ 20
[    1.509016] tango_config_write: bus=1 where=60 size=1 val=0x14

***** Same issue as above.

[    1.514976] tango_config_write: bus=0 where=28 size=2 val=0xe0f0
[    1.521106] tango_config_write: bus=0 where=28 size=2 val=0x0
[    1.526974] tango_config_write: bus=0 where=36 size=4 val=0xffe0fff0
[    1.533453] tango_config_write: bus=0 where=36 size=4 val=0x0
[    1.539338] pci 0000:00:00.0: BAR 0: assigned [mem 0x58000000-0x58ffffff 64bit]
[    1.546781] tango_config_write: bus=0 where=4 size=2 val=0x140
[    1.552737] tango_config_write: bus=0 where=16 size=4 val=0x8000004
[    1.559128] tango_config_write: bus=0 where=20 size=4 val=0x0
[    1.565000] tango_config_write: bus=0 where=4 size=2 val=0x140
[    1.570958] pci 0000:00:00.0: BAR 8: assigned [mem 0x59000000-0x590fffff]
[    1.577880] pci 0000:01:00.0: BAR 0: assigned [mem 0x59000000-0x59001fff 64bit]
[    1.585323] tango_config_write: bus=1 where=4 size=2 val=0x140
[    1.591279] tango_config_write: bus=1 where=16 size=4 val=0x9000004
[    1.597672] tango_config_write: bus=1 where=20 size=4 val=0x0
[    1.603542] tango_config_write: bus=1 where=4 size=2 val=0x140
[    1.609499] pci 0000:00:00.0: PCI bridge to [bus 01]
[    1.614581] tango_config_write: bus=0 where=48 size=4 val=0xffff
[    1.620710] tango_config_write: bus=0 where=28 size=2 val=0xf0
[    1.626665] tango_config_write: bus=0 where=48 size=4 val=0x0
[    1.632533] pci 0000:00:00.0:   bridge window [mem 0x59000000-0x590fffff]
[    1.639449] tango_config_write: bus=0 where=32 size=4 val=0x9000900
[    1.645841] tango_config_write: bus=0 where=44 size=4 val=0x0
[    1.651708] tango_config_write: bus=0 where=36 size=4 val=0xfff0
[    1.657837] tango_config_write: bus=0 where=40 size=4 val=0x0
[    1.663703] tango_config_write: bus=0 where=44 size=4 val=0x0
[    1.669569] tango_config_write: bus=0 where=62 size=2 val=0x1
[    1.675489] pcieport 0000:00:00.0: enabling device (0140 -> 0142)
[    1.681709] tango_config_write: bus=0 where=4 size=2 val=0x142
[    1.687669] tango_config_write: bus=0 where=136 size=2 val=0x2810
[    1.693893] pcieport 0000:00:00.0: enabling bus mastering
[    1.699412] tango_config_write: bus=0 where=4 size=2 val=0x146
[    1.705372] tango_config_write: bus=0 where=82 size=2 val=0x84
[    1.711387] msi_readl: reg=32 val=0xffffffff
[    1.715772] msi_writel: reg=32 val=0xffffffff
[    1.720250] altera-msi 2e080.msi: msi#0 address_hi 0x0 address_lo 0x802e07c
[    1.727343] tango_config_write: bus=0 where=82 size=2 val=0x84
[    1.733298] tango_config_write: bus=0 where=84 size=4 val=0x802e07c
[    1.739689] tango_config_write: bus=0 where=88 size=4 val=0x0
[    1.745556] tango_config_write: bus=0 where=92 size=2 val=0x0
[    1.751436] tango_config_write: bus=0 where=4 size=2 val=0x546
[    1.757392] tango_config_write: bus=0 where=82 size=2 val=0x85
[    1.763465] altera-msi 2e080.msi: msi#0 address_hi 0x0 address_lo 0x802e07c
[    1.770550] tango_config_write: bus=0 where=82 size=2 val=0x85
[    1.776496] tango_config_write: bus=0 where=84 size=4 val=0x802e07c
[    1.782878] tango_config_write: bus=0 where=88 size=4 val=0x0
[    1.788735] tango_config_write: bus=0 where=92 size=2 val=0x0
[    1.794637] tango_config_write: bus=0 where=138 size=2 val=0x20
[    1.800685] tango_config_write: bus=0 where=156 size=2 val=0x0
[    1.806642] tango_config_write: bus=0 where=2096 size=4 val=0x10000000
[    1.813299] tango_config_write: bus=0 where=2064 size=4 val=0x0
[    1.819342] tango_config_write: bus=0 where=2052 size=4 val=0x0
[    1.825392] tango_config_write: bus=0 where=136 size=2 val=0x281f
[    1.831611] tango_config_write: bus=0 where=2092 size=4 val=0x7
[    1.837657] aer 0000:00:00.0:pcie002: service driver aer loaded
[    1.843812] pci 0000:01:00.0: calling quirk_usb_early_handoff+0x0/0x7e0
[    1.850569] pci 0000:01:00.0: enabling device (0140 -> 0142)
[    1.856354] tango_config_write: bus=1 where=4 size=2 val=0x142
[    1.862318] quirk_usb_handoff_xhci: ioremap(0x59000000, 8192)
[    1.868201] xhci_find_next_ext_cap: offset=0x500
[    1.872935] val = 0x401

***** Weird, that val was 0x1000401 in a previous run...
According to the spec, xHCI Extended Capabilities
ID #1 = USB Legacy Support
Bit 24 = HC OS Owned Semaphore -- RW. Default = '0'. System software sets this bit to request
ownership of the xHC. Ownership is obtained when this bit reads as '1' and the HC BIOS Owned
Semaphore bit reads as '0'.
Maybe the card's memory is not reset on a warm system reset?

[    1.920552] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    1.928524] console [ttyS0] disabled
[    1.932775] 10700.serial: ttyS0 at MMIO 0x10700 (irq = 20, base_baud = 460800) is a Palmchip BK-3103
[    1.942121] console [ttyS0] enabled
[    1.942121] console [ttyS0] enabled
[    1.949222] bootconsole [earlycon0] disabled
[    1.949222] bootconsole [earlycon0] disabled
[    1.963350] loop: module loaded
[    1.967145] libphy: Fixed MDIO Bus: probed
[    1.979750] libphy: nb8800-mii: probed
[    1.987150] nb8800 26000.ethernet eth0: MAC address 00:16:e8:07:33:5a
[    1.993732] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.000306] ehci-pci: EHCI PCI platform driver
[    2.004955] xhci_hcd 0000:01:00.0: enabling bus mastering
[    2.010398] tango_config_write: bus=1 where=4 size=2 val=0x146
[    2.016274] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    2.021555] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 1
[    2.029028] xhci_hcd 0000:01:00.0: xHCI capability registers at d0852000:
[    2.035863] xhci_hcd 0000:01:00.0: CAPLENGTH AND HCIVERSION 0x1000020:
[    2.042431] xhci_hcd 0000:01:00.0: CAPLENGTH: 0x20
[    2.047253] xhci_hcd 0000:01:00.0: HCIVERSION: 0x100
[    2.052250] xhci_hcd 0000:01:00.0: HCSPARAMS 1: 0x8000820
[    2.057684] xhci_hcd 0000:01:00.0:   Max device slots: 32
[    2.063118] xhci_hcd 0000:01:00.0:   Max interrupters: 8
[    2.068463] xhci_hcd 0000:01:00.0:   Max ports: 8
[    2.073198] xhci_hcd 0000:01:00.0: HCSPARAMS 2: 0x24000011
[    2.078718] xhci_hcd 0000:01:00.0:   Isoc scheduling threshold: 1
[    2.084849] xhci_hcd 0000:01:00.0:   Maximum allowed segments in event ring: 1
[    2.092117] xhci_hcd 0000:01:00.0: HCSPARAMS 3 0x0:
[    2.097025] xhci_hcd 0000:01:00.0:   Worst case U1 device exit latency: 0
[    2.103855] xhci_hcd 0000:01:00.0:   Worst case U2 device exit latency: 0
[    2.110690] xhci_hcd 0000:01:00.0: HCC PARAMS 0x14051cf:
[    2.116035] xhci_hcd 0000:01:00.0:   HC generates 64 bit addresses
[    2.122254] xhci_hcd 0000:01:00.0:   HC hasn't Contiguous Frame ID Capability
[    2.129433] xhci_hcd 0000:01:00.0:   HC can't generate Stopped - Short Package event
[    2.137225] xhci_hcd 0000:01:00.0:   FIXME: more HCCPARAMS debugging
[    2.143619] xhci_hcd 0000:01:00.0: RTSOFF 0x600:
[    2.148267] xhci_hcd 0000:01:00.0: HCC PARAMS2 0x0:
[    2.153174] xhci_hcd 0000:01:00.0:   HC doesn't support Force save context capability
[    2.161052] xhci_hcd 0000:01:00.0:   HC doesn't support Large ESIT Payload Capability
[    2.168930] xhci_hcd 0000:01:00.0:   HC doesn't support Extended TBC capability
[    2.176283] xhci_hcd 0000:01:00.0: xHCI operational registers at d0852020:
[    2.183203] xhci_hcd 0000:01:00.0: USBCMD 0x0:
[    2.187673] xhci_hcd 0000:01:00.0:   HC is being stopped
[    2.193018] xhci_hcd 0000:01:00.0:   HC has finished hard reset
[    2.198974] xhci_hcd 0000:01:00.0:   Event Interrupts disabled
[    2.204843] xhci_hcd 0000:01:00.0:   Host System Error Interrupts disabled
[    2.211760] xhci_hcd 0000:01:00.0:   HC has finished light reset
[    2.217805] xhci_hcd 0000:01:00.0: USBSTS 0x1:
[    2.222276] xhci_hcd 0000:01:00.0:   Event ring is empty
[    2.227620] xhci_hcd 0000:01:00.0:   No Host System Error
[    2.233051] xhci_hcd 0000:01:00.0:   HC is halted
[    2.237788] xhci_hcd 0000:01:00.0: d0852420 port status reg = 0x80
[    2.244012] xhci_hcd 0000:01:00.0: d0852424 port power reg = 0x0
[    2.250059] xhci_hcd 0000:01:00.0: d0852428 port link reg = 0x0
[    2.256019] xhci_hcd 0000:01:00.0: d085242c port reserved reg = 0x0
[    2.262327] xhci_hcd 0000:01:00.0: d0852430 port status reg = 0x80
[    2.268548] xhci_hcd 0000:01:00.0: d0852434 port power reg = 0x0
[    2.274594] xhci_hcd 0000:01:00.0: d0852438 port link reg = 0x0
[    2.280553] xhci_hcd 0000:01:00.0: d085243c port reserved reg = 0x0
[    2.286861] xhci_hcd 0000:01:00.0: d0852440 port status reg = 0x80
[    2.293082] xhci_hcd 0000:01:00.0: d0852444 port power reg = 0x0
[    2.299128] xhci_hcd 0000:01:00.0: d0852448 port link reg = 0x0
[    2.305086] xhci_hcd 0000:01:00.0: d085244c port reserved reg = 0x0
[    2.311394] xhci_hcd 0000:01:00.0: d0852450 port status reg = 0x80
[    2.317615] xhci_hcd 0000:01:00.0: d0852454 port power reg = 0x0
[    2.323661] xhci_hcd 0000:01:00.0: d0852458 port link reg = 0x0
[    2.329619] xhci_hcd 0000:01:00.0: d085245c port reserved reg = 0x0
[    2.335927] xhci_hcd 0000:01:00.0: d0852460 port status reg = 0x80
[    2.342147] xhci_hcd 0000:01:00.0: d0852464 port power reg = 0x0
[    2.348193] xhci_hcd 0000:01:00.0: d0852468 port link reg = 0x0
[    2.354151] xhci_hcd 0000:01:00.0: d085246c port reserved reg = 0x0
[    2.360459] xhci_hcd 0000:01:00.0: d0852470 port status reg = 0x80
[    2.366680] xhci_hcd 0000:01:00.0: d0852474 port power reg = 0x0
[    2.372725] xhci_hcd 0000:01:00.0: d0852478 port link reg = 0x0
[    2.378687] xhci_hcd 0000:01:00.0: d085247c port reserved reg = 0x0
[    2.384996] xhci_hcd 0000:01:00.0: d0852480 port status reg = 0x80
[    2.391216] xhci_hcd 0000:01:00.0: d0852484 port power reg = 0x0
[    2.397262] xhci_hcd 0000:01:00.0: d0852488 port link reg = 0x0
[    2.403220] xhci_hcd 0000:01:00.0: d085248c port reserved reg = 0x0
[    2.409529] xhci_hcd 0000:01:00.0: d0852490 port status reg = 0x80
[    2.415749] xhci_hcd 0000:01:00.0: d0852494 port power reg = 0x0
[    2.421795] xhci_hcd 0000:01:00.0: d0852498 port link reg = 0x0
[    2.427832] xhci_hcd 0000:01:00.0: d085249c port reserved reg = 0x0
[    2.434146] xhci_hcd 0000:01:00.0: // Halt the HC
[    2.438892] xhci_hcd 0000:01:00.0: // Reset the HC
[    2.449004] xhci_hcd 0000:01:00.0: Wait for controller to be ready for doorbell rings
[    2.456888] xhci_hcd 0000:01:00.0: xhci_init
[    2.461185] xhci_hcd 0000:01:00.0: xHCI doesn't need link TRB QUIRK
[    2.467494] xhci_hcd 0000:01:00.0: Supported page size register = 0x1
[    2.473975] xhci_hcd 0000:01:00.0: Supported page size of 4K
[    2.479670] xhci_hcd 0000:01:00.0: HCD page size set to 4K
[    2.485192] xhci_hcd 0000:01:00.0: // xHC can handle at most 32 device slots.
[    2.492373] xhci_hcd 0000:01:00.0: // Setting Max device slots reg = 0x20.
[    2.499320] xhci_hcd 0000:01:00.0: // Device context base array address = 0x8e07e000 (DMA), d0855000 (virt)
[    2.509156] xhci_hcd 0000:01:00.0: Allocated command ring at cfb04200
[    2.515640] xhci_hcd 0000:01:00.0: First segment DMA is 0x8e07f000
[    2.521863] xhci_hcd 0000:01:00.0: // Setting command ring address to 0x20
[    2.528786] xhci_hcd 0000:01:00.0: // xHC command ring deq ptr low bits + flags = @00000000
[    2.537188] xhci_hcd 0000:01:00.0: // xHC command ring deq ptr high bits = @00000000
[    2.545002] xhci_hcd 0000:01:00.0: // Doorbell array is located at offset 0x800 from cap regs base addr
[    2.554455] xhci_hcd 0000:01:00.0: // xHCI capability registers at d0852000:
[    2.561550] xhci_hcd 0000:01:00.0: // @d0852000 = 0x1000020 (CAPLENGTH AND HCIVERSION)
[    2.569516] xhci_hcd 0000:01:00.0: //   CAPLENGTH: 0x20
[    2.574774] xhci_hcd 0000:01:00.0: // xHCI operational registers at d0852020:
[    2.581955] xhci_hcd 0000:01:00.0: // @d0852018 = 0x600 RTSOFF
[    2.587823] xhci_hcd 0000:01:00.0: // xHCI runtime registers at d0852600:
[    2.594655] xhci_hcd 0000:01:00.0: // @d0852014 = 0x800 DBOFF
[    2.600436] xhci_hcd 0000:01:00.0: // Doorbell array at d0852800:
[    2.606568] xhci_hcd 0000:01:00.0: xHCI runtime registers at d0852600:
[    2.613137] xhci_hcd 0000:01:00.0:   d0852600: Microframe index = 0x0
[    2.619630] xhci_hcd 0000:01:00.0: // Allocating event ring
[    2.625277] xhci_hcd 0000:01:00.0: // Allocated event ring segment table at 0x8fb99000
[    2.633246] xhci_hcd 0000:01:00.0: Set ERST to 0; private num segs = 1, virt addr = d085d000, dma addr = 0x8fb99000
[    2.643752] xhci_hcd 0000:01:00.0: // Write ERST size = 1 to ir_set 0 (some bits preserved)
[    2.652154] xhci_hcd 0000:01:00.0: // Set ERST entries to point to event ring.
[    2.659422] xhci_hcd 0000:01:00.0: // Set ERST base address for ir_set 0 = 0x8fb99000
[    2.667310] xhci_hcd 0000:01:00.0: // Write event ring dequeue pointer, preserving EHB bit
[    2.675626] xhci_hcd 0000:01:00.0: Wrote ERST address to ir_set 0.
[    2.681850] xhci_hcd 0000:01:00.0: Allocating 4 scratchpad buffers
[    2.688141] xhci_find_next_ext_cap: offset=0x500
[    2.692788] val = 0x1000401
[    2.695598] xhci_find_next_ext_cap: offset=0x510
[    2.700243] val = 0x3000502
[    2.703053] xhci_find_next_ext_cap: offset=0x510
[    2.707699] val = 0x3000502
[    2.710508] xhci_find_next_ext_cap: offset=0x524
[    2.715154] val = 0x2000702
[    2.717963] xhci_find_next_ext_cap: offset=0x524
[    2.722608] val = 0x2000702
[    2.725417] xhci_find_next_ext_cap: offset=0x540
[    2.730063] val = 0x4c0
[    2.732514] xhci_find_next_ext_cap: offset=0x550
[    2.737160] val = 0xa
[    2.739446] xhci_hcd 0000:01:00.0: Ext Cap d0852510, port offset = 1, count = 4, revision = 0x3
[    2.748197] xhci_find_next_ext_cap: offset=0x510
[    2.752842] val = 0x3000502
[    2.755651] xhci_find_next_ext_cap: offset=0x524
[    2.760296] val = 0x2000702
[    2.763112] xhci_hcd 0000:01:00.0: Ext Cap d0852524, port offset = 5, count = 4, revision = 0x2
[    2.771864] xhci_hcd 0000:01:00.0: xHCI 1.0: support USB2 software lpm
[    2.778437] xhci_hcd 0000:01:00.0: Found 4 USB 2.0 ports and 4 USB 3.0 ports.
[    2.785619] xhci_hcd 0000:01:00.0: USB 2.0 port at index 4, addr = d0852460
[    2.792625] xhci_hcd 0000:01:00.0: USB 2.0 port at index 5, addr = d0852470
[    2.799630] xhci_hcd 0000:01:00.0: USB 2.0 port at index 6, addr = d0852480
[    2.806636] xhci_hcd 0000:01:00.0: USB 2.0 port at index 7, addr = d0852490
[    2.813641] xhci_hcd 0000:01:00.0: USB 3.0 port at index 0, addr = d0852420
[    2.820645] xhci_hcd 0000:01:00.0: USB 3.0 port at index 1, addr = d0852430
[    2.827651] xhci_hcd 0000:01:00.0: USB 3.0 port at index 2, addr = d0852440
[    2.834657] xhci_hcd 0000:01:00.0: USB 3.0 port at index 3, addr = d0852450
[    2.841663] xhci_hcd 0000:01:00.0: Finished xhci_init
[    2.846747] xhci_hcd 0000:01:00.0: hcc params 0x014051cf hci version 0x100 quirks 0x00000010
[    2.855243] xhci_hcd 0000:01:00.0: enabling Mem-Wr-Inval
[    2.860589] tango_config_write: bus=1 where=4 size=2 val=0x156
[    2.866459] xhci_hcd 0000:01:00.0: xhci_run
[    2.870678] tango_config_write: bus=1 where=146 size=2 val=0x7
[    2.876618] msi_readl: reg=32 val=0xffffffff
[    2.880918] msi_writel: reg=32 val=0xffffffff
[    2.885346] msi_readl: reg=32 val=0xffffffff
[    2.889644] msi_writel: reg=32 val=0xffffffff
[    2.894056] msi_readl: reg=32 val=0xffffffff
[    2.898353] msi_writel: reg=32 val=0xffffffff
[    2.902743] altera-msi 2e080.msi: msi#1 address_hi 0x0 address_lo 0x802e07c
[    2.909756] altera-msi 2e080.msi: msi#2 address_hi 0x0 address_lo 0x802e07c
[    2.916765] altera-msi 2e080.msi: msi#3 address_hi 0x0 address_lo 0x802e07c
[    2.923773] tango_config_write: bus=1 where=146 size=2 val=0xc007
[    2.929939] tango_config_write: bus=1 where=4 size=2 val=0x546
[    2.935812] tango_config_write: bus=1 where=146 size=2 val=0x8007
[    2.941951] altera-msi 2e080.msi: msi#1 address_hi 0x0 address_lo 0x802e07c
[    2.948991] altera-msi 2e080.msi: msi#2 address_hi 0x0 address_lo 0x802e07c
[    2.956023] altera-msi 2e080.msi: msi#3 address_hi 0x0 address_lo 0x802e07c
[    2.963054] xhci_hcd 0000:01:00.0: @000000008e07f000 00000000 00000000 00000000 00000000
[    2.971197] xhci_hcd 0000:01:00.0: @000000008e07f010 00000000 00000000 00000000 00000000
[    2.979338] xhci_hcd 0000:01:00.0: @000000008e07f020 00000000 00000000 00000000 00000000
[    2.987480] xhci_hcd 0000:01:00.0: @000000008e07f030 00000000 00000000 00000000 00000000
[    2.995621] xhci_hcd 0000:01:00.0: @000000008e07f040 00000000 00000000 00000000 00000000
[    3.003763] xhci_hcd 0000:01:00.0: @000000008e07f050 00000000 00000000 00000000 00000000
[    3.011904] xhci_hcd 0000:01:00.0: @000000008e07f060 00000000 00000000 00000000 00000000
[    3.020045] xhci_hcd 0000:01:00.0: @000000008e07f070 00000000 00000000 00000000 00000000
[    3.028186] xhci_hcd 0000:01:00.0: @000000008e07f080 00000000 00000000 00000000 00000000
[    3.036328] xhci_hcd 0000:01:00.0: @000000008e07f090 00000000 00000000 00000000 00000000
[    3.044472] xhci_hcd 0000:01:00.0: @000000008e07f0a0 00000000 00000000 00000000 00000000
[    3.052614] xhci_hcd 0000:01:00.0: @000000008e07f0b0 00000000 00000000 00000000 00000000
[    3.060756] xhci_hcd 0000:01:00.0: @000000008e07f0c0 00000000 00000000 00000000 00000000
[    3.068898] xhci_hcd 0000:01:00.0: @000000008e07f0d0 00000000 00000000 00000000 00000000
[    3.077039] xhci_hcd 0000:01:00.0: @000000008e07f0e0 00000000 00000000 00000000 00000000
[    3.085180] xhci_hcd 0000:01:00.0: @000000008e07f0f0 00000000 00000000 00000000 00000000
[    3.093322] xhci_hcd 0000:01:00.0: @000000008e07f100 00000000 00000000 00000000 00000000
[    3.101463] xhci_hcd 0000:01:00.0: @000000008e07f110 00000000 00000000 00000000 00000000
[    3.109604] xhci_hcd 0000:01:00.0: @000000008e07f120 00000000 00000000 00000000 00000000
[    3.117745] xhci_hcd 0000:01:00.0: @000000008e07f130 00000000 00000000 00000000 00000000
[    3.125887] xhci_hcd 0000:01:00.0: @000000008e07f140 00000000 00000000 00000000 00000000
[    3.134028] xhci_hcd 0000:01:00.0: @000000008e07f150 00000000 00000000 00000000 00000000
[    3.142170] xhci_hcd 0000:01:00.0: @000000008e07f160 00000000 00000000 00000000 00000000
[    3.150312] xhci_hcd 0000:01:00.0: @000000008e07f170 00000000 00000000 00000000 00000000
[    3.158453] xhci_hcd 0000:01:00.0: @000000008e07f180 00000000 00000000 00000000 00000000
[    3.166594] xhci_hcd 0000:01:00.0: @000000008e07f190 00000000 00000000 00000000 00000000
[    3.174738] xhci_hcd 0000:01:00.0: @000000008e07f1a0 00000000 00000000 00000000 00000000
[    3.182880] xhci_hcd 0000:01:00.0: @000000008e07f1b0 00000000 00000000 00000000 00000000
[    3.191021] xhci_hcd 0000:01:00.0: @000000008e07f1c0 00000000 00000000 00000000 00000000
[    3.199163] xhci_hcd 0000:01:00.0: @000000008e07f1d0 00000000 00000000 00000000 00000000
[    3.207304] xhci_hcd 0000:01:00.0: @000000008e07f1e0 00000000 00000000 00000000 00000000
[    3.215445] xhci_hcd 0000:01:00.0: @000000008e07f1f0 00000000 00000000 00000000 00000000
[    3.223587] xhci_hcd 0000:01:00.0: @000000008e07f200 00000000 00000000 00000000 00000000
[    3.231728] xhci_hcd 0000:01:00.0: @000000008e07f210 00000000 00000000 00000000 00000000
[    3.239869] xhci_hcd 0000:01:00.0: @000000008e07f220 00000000 00000000 00000000 00000000
[    3.248009] xhci_hcd 0000:01:00.0: @000000008e07f230 00000000 00000000 00000000 00000000
[    3.256150] xhci_hcd 0000:01:00.0: @000000008e07f240 00000000 00000000 00000000 00000000
[    3.264291] xhci_hcd 0000:01:00.0: @000000008e07f250 00000000 00000000 00000000 00000000
[    3.272433] xhci_hcd 0000:01:00.0: @000000008e07f260 00000000 00000000 00000000 00000000
[    3.280574] xhci_hcd 0000:01:00.0: @000000008e07f270 00000000 00000000 00000000 00000000
[    3.288715] xhci_hcd 0000:01:00.0: @000000008e07f280 00000000 00000000 00000000 00000000
[    3.296856] xhci_hcd 0000:01:00.0: @000000008e07f290 00000000 00000000 00000000 00000000
[    3.305000] xhci_hcd 0000:01:00.0: @000000008e07f2a0 00000000 00000000 00000000 00000000
[    3.313142] xhci_hcd 0000:01:00.0: @000000008e07f2b0 00000000 00000000 00000000 00000000
[    3.321283] xhci_hcd 0000:01:00.0: @000000008e07f2c0 00000000 00000000 00000000 00000000
[    3.329425] xhci_hcd 0000:01:00.0: @000000008e07f2d0 00000000 00000000 00000000 00000000
[    3.337566] xhci_hcd 0000:01:00.0: @000000008e07f2e0 00000000 00000000 00000000 00000000
[    3.345707] xhci_hcd 0000:01:00.0: @000000008e07f2f0 00000000 00000000 00000000 00000000
[    3.353849] xhci_hcd 0000:01:00.0: @000000008e07f300 00000000 00000000 00000000 00000000
[    3.361990] xhci_hcd 0000:01:00.0: @000000008e07f310 00000000 00000000 00000000 00000000
[    3.370131] xhci_hcd 0000:01:00.0: @000000008e07f320 00000000 00000000 00000000 00000000
[    3.378271] xhci_hcd 0000:01:00.0: @000000008e07f330 00000000 00000000 00000000 00000000
[    3.386413] xhci_hcd 0000:01:00.0: @000000008e07f340 00000000 00000000 00000000 00000000
[    3.394555] xhci_hcd 0000:01:00.0: @000000008e07f350 00000000 00000000 00000000 00000000
[    3.402695] xhci_hcd 0000:01:00.0: @000000008e07f360 00000000 00000000 00000000 00000000
[    3.410836] xhci_hcd 0000:01:00.0: @000000008e07f370 00000000 00000000 00000000 00000000
[    3.419005] xhci_hcd 0000:01:00.0: @000000008e07f380 00000000 00000000 00000000 00000000
[    3.427149] xhci_hcd 0000:01:00.0: @000000008e07f390 00000000 00000000 00000000 00000000
[    3.435295] xhci_hcd 0000:01:00.0: @000000008e07f3a0 00000000 00000000 00000000 00000000
[    3.443437] xhci_hcd 0000:01:00.0: @000000008e07f3b0 00000000 00000000 00000000 00000000
[    3.451579] xhci_hcd 0000:01:00.0: @000000008e07f3c0 00000000 00000000 00000000 00000000
[    3.459721] xhci_hcd 0000:01:00.0: @000000008e07f3d0 00000000 00000000 00000000 00000000
[    3.467861] xhci_hcd 0000:01:00.0: @000000008e07f3e0 00000000 00000000 00000000 00000000
[    3.476002] xhci_hcd 0000:01:00.0: @000000008e07f3f0 00000000 00000000 00000000 00000000
[    3.484143] xhci_hcd 0000:01:00.0: @000000008e07f400 00000000 00000000 00000000 00000000
[    3.492283] xhci_hcd 0000:01:00.0: @000000008e07f410 00000000 00000000 00000000 00000000
[    3.500424] xhci_hcd 0000:01:00.0: @000000008e07f420 00000000 00000000 00000000 00000000
[    3.508565] xhci_hcd 0000:01:00.0: @000000008e07f430 00000000 00000000 00000000 00000000
[    3.516706] xhci_hcd 0000:01:00.0: @000000008e07f440 00000000 00000000 00000000 00000000
[    3.524847] xhci_hcd 0000:01:00.0: @000000008e07f450 00000000 00000000 00000000 00000000
[    3.532993] xhci_hcd 0000:01:00.0: @000000008e07f460 00000000 00000000 00000000 00000000
[    3.541134] xhci_hcd 0000:01:00.0: @000000008e07f470 00000000 00000000 00000000 00000000
[    3.549275] xhci_hcd 0000:01:00.0: @000000008e07f480 00000000 00000000 00000000 00000000
[    3.557416] xhci_hcd 0000:01:00.0: @000000008e07f490 00000000 00000000 00000000 00000000
[    3.565560] xhci_hcd 0000:01:00.0: @000000008e07f4a0 00000000 00000000 00000000 00000000
[    3.573702] xhci_hcd 0000:01:00.0: @000000008e07f4b0 00000000 00000000 00000000 00000000
[    3.581843] xhci_hcd 0000:01:00.0: @000000008e07f4c0 00000000 00000000 00000000 00000000
[    3.589984] xhci_hcd 0000:01:00.0: @000000008e07f4d0 00000000 00000000 00000000 00000000
[    3.598126] xhci_hcd 0000:01:00.0: @000000008e07f4e0 00000000 00000000 00000000 00000000
[    3.606266] xhci_hcd 0000:01:00.0: @000000008e07f4f0 00000000 00000000 00000000 00000000
[    3.614408] xhci_hcd 0000:01:00.0: @000000008e07f500 00000000 00000000 00000000 00000000
[    3.622548] xhci_hcd 0000:01:00.0: @000000008e07f510 00000000 00000000 00000000 00000000
[    3.630689] xhci_hcd 0000:01:00.0: @000000008e07f520 00000000 00000000 00000000 00000000
[    3.638830] xhci_hcd 0000:01:00.0: @000000008e07f530 00000000 00000000 00000000 00000000
[    3.646971] xhci_hcd 0000:01:00.0: @000000008e07f540 00000000 00000000 00000000 00000000
[    3.655112] xhci_hcd 0000:01:00.0: @000000008e07f550 00000000 00000000 00000000 00000000
[    3.663253] xhci_hcd 0000:01:00.0: @000000008e07f560 00000000 00000000 00000000 00000000
[    3.671393] xhci_hcd 0000:01:00.0: @000000008e07f570 00000000 00000000 00000000 00000000
[    3.679534] xhci_hcd 0000:01:00.0: @000000008e07f580 00000000 00000000 00000000 00000000
[    3.687676] xhci_hcd 0000:01:00.0: @000000008e07f590 00000000 00000000 00000000 00000000
[    3.695820] xhci_hcd 0000:01:00.0: @000000008e07f5a0 00000000 00000000 00000000 00000000
[    3.703962] xhci_hcd 0000:01:00.0: @000000008e07f5b0 00000000 00000000 00000000 00000000
[    3.712103] xhci_hcd 0000:01:00.0: @000000008e07f5c0 00000000 00000000 00000000 00000000
[    3.720244] xhci_hcd 0000:01:00.0: @000000008e07f5d0 00000000 00000000 00000000 00000000
[    3.728384] xhci_hcd 0000:01:00.0: @000000008e07f5e0 00000000 00000000 00000000 00000000
[    3.736526] xhci_hcd 0000:01:00.0: @000000008e07f5f0 00000000 00000000 00000000 00000000
[    3.744666] xhci_hcd 0000:01:00.0: @000000008e07f600 00000000 00000000 00000000 00000000
[    3.752807] xhci_hcd 0000:01:00.0: @000000008e07f610 00000000 00000000 00000000 00000000
[    3.760948] xhci_hcd 0000:01:00.0: @000000008e07f620 00000000 00000000 00000000 00000000
[    3.769089] xhci_hcd 0000:01:00.0: @000000008e07f630 00000000 00000000 00000000 00000000
[    3.777230] xhci_hcd 0000:01:00.0: @000000008e07f640 00000000 00000000 00000000 00000000
[    3.785372] xhci_hcd 0000:01:00.0: @000000008e07f650 00000000 00000000 00000000 00000000
[    3.793514] xhci_hcd 0000:01:00.0: @000000008e07f660 00000000 00000000 00000000 00000000
[    3.801654] xhci_hcd 0000:01:00.0: @000000008e07f670 00000000 00000000 00000000 00000000
[    3.809795] xhci_hcd 0000:01:00.0: @000000008e07f680 00000000 00000000 00000000 00000000
[    3.817936] xhci_hcd 0000:01:00.0: @000000008e07f690 00000000 00000000 00000000 00000000
[    3.826080] xhci_hcd 0000:01:00.0: @000000008e07f6a0 00000000 00000000 00000000 00000000
[    3.834222] xhci_hcd 0000:01:00.0: @000000008e07f6b0 00000000 00000000 00000000 00000000
[    3.842363] xhci_hcd 0000:01:00.0: @000000008e07f6c0 00000000 00000000 00000000 00000000
[    3.850504] xhci_hcd 0000:01:00.0: @000000008e07f6d0 00000000 00000000 00000000 00000000
[    3.858646] xhci_hcd 0000:01:00.0: @000000008e07f6e0 00000000 00000000 00000000 00000000
[    3.866787] xhci_hcd 0000:01:00.0: @000000008e07f6f0 00000000 00000000 00000000 00000000
[    3.874928] xhci_hcd 0000:01:00.0: @000000008e07f700 00000000 00000000 00000000 00000000
[    3.883069] xhci_hcd 0000:01:00.0: @000000008e07f710 00000000 00000000 00000000 00000000
[    3.891209] xhci_hcd 0000:01:00.0: @000000008e07f720 00000000 00000000 00000000 00000000
[    3.899351] xhci_hcd 0000:01:00.0: @000000008e07f730 00000000 00000000 00000000 00000000
[    3.907492] xhci_hcd 0000:01:00.0: @000000008e07f740 00000000 00000000 00000000 00000000
[    3.915633] xhci_hcd 0000:01:00.0: @000000008e07f750 00000000 00000000 00000000 00000000
[    3.923775] xhci_hcd 0000:01:00.0: @000000008e07f760 00000000 00000000 00000000 00000000
[    3.931916] xhci_hcd 0000:01:00.0: @000000008e07f770 00000000 00000000 00000000 00000000
[    3.940057] xhci_hcd 0000:01:00.0: @000000008e07f780 00000000 00000000 00000000 00000000
[    3.948199] xhci_hcd 0000:01:00.0: @000000008e07f790 00000000 00000000 00000000 00000000
[    3.956343] xhci_hcd 0000:01:00.0: @000000008e07f7a0 00000000 00000000 00000000 00000000
[    3.964485] xhci_hcd 0000:01:00.0: @000000008e07f7b0 00000000 00000000 00000000 00000000
[    3.972626] xhci_hcd 0000:01:00.0: @000000008e07f7c0 00000000 00000000 00000000 00000000
[    3.980768] xhci_hcd 0000:01:00.0: @000000008e07f7d0 00000000 00000000 00000000 00000000
[    3.988908] xhci_hcd 0000:01:00.0: @000000008e07f7e0 00000000 00000000 00000000 00000000
[    3.997049] xhci_hcd 0000:01:00.0: @000000008e07f7f0 00000000 00000000 00000000 00000000
[    4.005190] xhci_hcd 0000:01:00.0: @000000008e07f800 00000000 00000000 00000000 00000000
[    4.013332] xhci_hcd 0000:01:00.0: @000000008e07f810 00000000 00000000 00000000 00000000
[    4.021473] xhci_hcd 0000:01:00.0: @000000008e07f820 00000000 00000000 00000000 00000000
[    4.029613] xhci_hcd 0000:01:00.0: @000000008e07f830 00000000 00000000 00000000 00000000
[    4.037754] xhci_hcd 0000:01:00.0: @000000008e07f840 00000000 00000000 00000000 00000000
[    4.045894] xhci_hcd 0000:01:00.0: @000000008e07f850 00000000 00000000 00000000 00000000
[    4.054036] xhci_hcd 0000:01:00.0: @000000008e07f860 00000000 00000000 00000000 00000000
[    4.062176] xhci_hcd 0000:01:00.0: @000000008e07f870 00000000 00000000 00000000 00000000
[    4.070318] xhci_hcd 0000:01:00.0: @000000008e07f880 00000000 00000000 00000000 00000000
[    4.078460] xhci_hcd 0000:01:00.0: @000000008e07f890 00000000 00000000 00000000 00000000
[    4.086604] xhci_hcd 0000:01:00.0: @000000008e07f8a0 00000000 00000000 00000000 00000000
[    4.094745] xhci_hcd 0000:01:00.0: @000000008e07f8b0 00000000 00000000 00000000 00000000
[    4.102886] xhci_hcd 0000:01:00.0: @000000008e07f8c0 00000000 00000000 00000000 00000000
[    4.111027] xhci_hcd 0000:01:00.0: @000000008e07f8d0 00000000 00000000 00000000 00000000
[    4.119168] xhci_hcd 0000:01:00.0: @000000008e07f8e0 00000000 00000000 00000000 00000000
[    4.127309] xhci_hcd 0000:01:00.0: @000000008e07f8f0 00000000 00000000 00000000 00000000
[    4.135451] xhci_hcd 0000:01:00.0: @000000008e07f900 00000000 00000000 00000000 00000000
[    4.143591] xhci_hcd 0000:01:00.0: @000000008e07f910 00000000 00000000 00000000 00000000
[    4.151732] xhci_hcd 0000:01:00.0: @000000008e07f920 00000000 00000000 00000000 00000000
[    4.159873] xhci_hcd 0000:01:00.0: @000000008e07f930 00000000 00000000 00000000 00000000
[    4.168014] xhci_hcd 0000:01:00.0: @000000008e07f940 00000000 00000000 00000000 00000000
[    4.176155] xhci_hcd 0000:01:00.0: @000000008e07f950 00000000 00000000 00000000 00000000
[    4.184296] xhci_hcd 0000:01:00.0: @000000008e07f960 00000000 00000000 00000000 00000000
[    4.192437] xhci_hcd 0000:01:00.0: @000000008e07f970 00000000 00000000 00000000 00000000
[    4.200578] xhci_hcd 0000:01:00.0: @000000008e07f980 00000000 00000000 00000000 00000000
[    4.208719] xhci_hcd 0000:01:00.0: @000000008e07f990 00000000 00000000 00000000 00000000
[    4.216863] xhci_hcd 0000:01:00.0: @000000008e07f9a0 00000000 00000000 00000000 00000000
[    4.225004] xhci_hcd 0000:01:00.0: @000000008e07f9b0 00000000 00000000 00000000 00000000
[    4.233146] xhci_hcd 0000:01:00.0: @000000008e07f9c0 00000000 00000000 00000000 00000000
[    4.241287] xhci_hcd 0000:01:00.0: @000000008e07f9d0 00000000 00000000 00000000 00000000
[    4.249428] xhci_hcd 0000:01:00.0: @000000008e07f9e0 00000000 00000000 00000000 00000000
[    4.257569] xhci_hcd 0000:01:00.0: @000000008e07f9f0 00000000 00000000 00000000 00000000
[    4.265711] xhci_hcd 0000:01:00.0: @000000008e07fa00 00000000 00000000 00000000 00000000
[    4.273853] xhci_hcd 0000:01:00.0: @000000008e07fa10 00000000 00000000 00000000 00000000
[    4.281994] xhci_hcd 0000:01:00.0: @000000008e07fa20 00000000 00000000 00000000 00000000
[    4.290135] xhci_hcd 0000:01:00.0: @000000008e07fa30 00000000 00000000 00000000 00000000
[    4.298275] xhci_hcd 0000:01:00.0: @000000008e07fa40 00000000 00000000 00000000 00000000
[    4.306416] xhci_hcd 0000:01:00.0: @000000008e07fa50 00000000 00000000 00000000 00000000
[    4.314557] xhci_hcd 0000:01:00.0: @000000008e07fa60 00000000 00000000 00000000 00000000
[    4.322698] xhci_hcd 0000:01:00.0: @000000008e07fa70 00000000 00000000 00000000 00000000
[    4.330839] xhci_hcd 0000:01:00.0: @000000008e07fa80 00000000 00000000 00000000 00000000
[    4.338980] xhci_hcd 0000:01:00.0: @000000008e07fa90 00000000 00000000 00000000 00000000
[    4.347124] xhci_hcd 0000:01:00.0: @000000008e07faa0 00000000 00000000 00000000 00000000
[    4.355266] xhci_hcd 0000:01:00.0: @000000008e07fab0 00000000 00000000 00000000 00000000
[    4.363408] xhci_hcd 0000:01:00.0: @000000008e07fac0 00000000 00000000 00000000 00000000
[    4.371548] xhci_hcd 0000:01:00.0: @000000008e07fad0 00000000 00000000 00000000 00000000
[    4.379690] xhci_hcd 0000:01:00.0: @000000008e07fae0 00000000 00000000 00000000 00000000
[    4.387831] xhci_hcd 0000:01:00.0: @000000008e07faf0 00000000 00000000 00000000 00000000
[    4.395971] xhci_hcd 0000:01:00.0: @000000008e07fb00 00000000 00000000 00000000 00000000
[    4.404112] xhci_hcd 0000:01:00.0: @000000008e07fb10 00000000 00000000 00000000 00000000
[    4.412253] xhci_hcd 0000:01:00.0: @000000008e07fb20 00000000 00000000 00000000 00000000
[    4.420395] xhci_hcd 0000:01:00.0: @000000008e07fb30 00000000 00000000 00000000 00000000
[    4.428554] xhci_hcd 0000:01:00.0: @000000008e07fb40 00000000 00000000 00000000 00000000
[    4.436697] xhci_hcd 0000:01:00.0: @000000008e07fb50 00000000 00000000 00000000 00000000
[    4.444838] xhci_hcd 0000:01:00.0: @000000008e07fb60 00000000 00000000 00000000 00000000
[    4.452980] xhci_hcd 0000:01:00.0: @000000008e07fb70 00000000 00000000 00000000 00000000
[    4.461129] xhci_hcd 0000:01:00.0: @000000008e07fb80 00000000 00000000 00000000 00000000
[    4.469270] xhci_hcd 0000:01:00.0: @000000008e07fb90 00000000 00000000 00000000 00000000
[    4.477414] xhci_hcd 0000:01:00.0: @000000008e07fba0 00000000 00000000 00000000 00000000
[    4.485555] xhci_hcd 0000:01:00.0: @000000008e07fbb0 00000000 00000000 00000000 00000000
[    4.493697] xhci_hcd 0000:01:00.0: @000000008e07fbc0 00000000 00000000 00000000 00000000
[    4.501838] xhci_hcd 0000:01:00.0: @000000008e07fbd0 00000000 00000000 00000000 00000000
[    4.509979] xhci_hcd 0000:01:00.0: @000000008e07fbe0 00000000 00000000 00000000 00000000
[    4.518120] xhci_hcd 0000:01:00.0: @000000008e07fbf0 00000000 00000000 00000000 00000000
[    4.526261] xhci_hcd 0000:01:00.0: @000000008e07fc00 00000000 00000000 00000000 00000000
[    4.534402] xhci_hcd 0000:01:00.0: @000000008e07fc10 00000000 00000000 00000000 00000000
[    4.542543] xhci_hcd 0000:01:00.0: @000000008e07fc20 00000000 00000000 00000000 00000000
[    4.550684] xhci_hcd 0000:01:00.0: @000000008e07fc30 00000000 00000000 00000000 00000000
[    4.558824] xhci_hcd 0000:01:00.0: @000000008e07fc40 00000000 00000000 00000000 00000000
[    4.566965] xhci_hcd 0000:01:00.0: @000000008e07fc50 00000000 00000000 00000000 00000000
[    4.575105] xhci_hcd 0000:01:00.0: @000000008e07fc60 00000000 00000000 00000000 00000000
[    4.583246] xhci_hcd 0000:01:00.0: @000000008e07fc70 00000000 00000000 00000000 00000000
[    4.591462] xhci_hcd 0000:01:00.0: @000000008e07fc80 00000000 00000000 00000000 00000000
[    4.599608] xhci_hcd 0000:01:00.0: @000000008e07fc90 00000000 00000000 00000000 00000000
[    4.607754] xhci_hcd 0000:01:00.0: @000000008e07fca0 00000000 00000000 00000000 00000000
[    4.615897] xhci_hcd 0000:01:00.0: @000000008e07fcb0 00000000 00000000 00000000 00000000
[    4.624038] xhci_hcd 0000:01:00.0: @000000008e07fcc0 00000000 00000000 00000000 00000000
[    4.632180] xhci_hcd 0000:01:00.0: @000000008e07fcd0 00000000 00000000 00000000 00000000
[    4.640322] xhci_hcd 0000:01:00.0: @000000008e07fce0 00000000 00000000 00000000 00000000
[    4.648462] xhci_hcd 0000:01:00.0: @000000008e07fcf0 00000000 00000000 00000000 00000000
[    4.656603] xhci_hcd 0000:01:00.0: @000000008e07fd00 00000000 00000000 00000000 00000000
[    4.664744] xhci_hcd 0000:01:00.0: @000000008e07fd10 00000000 00000000 00000000 00000000
[    4.672886] xhci_hcd 0000:01:00.0: @000000008e07fd20 00000000 00000000 00000000 00000000
[    4.681027] xhci_hcd 0000:01:00.0: @000000008e07fd30 00000000 00000000 00000000 00000000
[    4.689169] xhci_hcd 0000:01:00.0: @000000008e07fd40 00000000 00000000 00000000 00000000
[    4.697311] xhci_hcd 0000:01:00.0: @000000008e07fd50 00000000 00000000 00000000 00000000
[    4.705452] xhci_hcd 0000:01:00.0: @000000008e07fd60 00000000 00000000 00000000 00000000
[    4.713593] xhci_hcd 0000:01:00.0: @000000008e07fd70 00000000 00000000 00000000 00000000
[    4.721734] xhci_hcd 0000:01:00.0: @000000008e07fd80 00000000 00000000 00000000 00000000
[    4.729876] xhci_hcd 0000:01:00.0: @000000008e07fd90 00000000 00000000 00000000 00000000
[    4.738020] xhci_hcd 0000:01:00.0: @000000008e07fda0 00000000 00000000 00000000 00000000
[    4.746163] xhci_hcd 0000:01:00.0: @000000008e07fdb0 00000000 00000000 00000000 00000000
[    4.754305] xhci_hcd 0000:01:00.0: @000000008e07fdc0 00000000 00000000 00000000 00000000
[    4.762445] xhci_hcd 0000:01:00.0: @000000008e07fdd0 00000000 00000000 00000000 00000000
[    4.770586] xhci_hcd 0000:01:00.0: @000000008e07fde0 00000000 00000000 00000000 00000000
[    4.778728] xhci_hcd 0000:01:00.0: @000000008e07fdf0 00000000 00000000 00000000 00000000
[    4.786869] xhci_hcd 0000:01:00.0: @000000008e07fe00 00000000 00000000 00000000 00000000
[    4.795010] xhci_hcd 0000:01:00.0: @000000008e07fe10 00000000 00000000 00000000 00000000
[    4.803151] xhci_hcd 0000:01:00.0: @000000008e07fe20 00000000 00000000 00000000 00000000
[    4.811292] xhci_hcd 0000:01:00.0: @000000008e07fe30 00000000 00000000 00000000 00000000
[    4.819433] xhci_hcd 0000:01:00.0: @000000008e07fe40 00000000 00000000 00000000 00000000
[    4.827574] xhci_hcd 0000:01:00.0: @000000008e07fe50 00000000 00000000 00000000 00000000
[    4.835714] xhci_hcd 0000:01:00.0: @000000008e07fe60 00000000 00000000 00000000 00000000
[    4.843856] xhci_hcd 0000:01:00.0: @000000008e07fe70 00000000 00000000 00000000 00000000
[    4.851997] xhci_hcd 0000:01:00.0: @000000008e07fe80 00000000 00000000 00000000 00000000
[    4.860138] xhci_hcd 0000:01:00.0: @000000008e07fe90 00000000 00000000 00000000 00000000
[    4.868282] xhci_hcd 0000:01:00.0: @000000008e07fea0 00000000 00000000 00000000 00000000
[    4.876424] xhci_hcd 0000:01:00.0: @000000008e07feb0 00000000 00000000 00000000 00000000
[    4.884565] xhci_hcd 0000:01:00.0: @000000008e07fec0 00000000 00000000 00000000 00000000
[    4.892707] xhci_hcd 0000:01:00.0: @000000008e07fed0 00000000 00000000 00000000 00000000
[    4.900847] xhci_hcd 0000:01:00.0: @000000008e07fee0 00000000 00000000 00000000 00000000
[    4.908989] xhci_hcd 0000:01:00.0: @000000008e07fef0 00000000 00000000 00000000 00000000
[    4.917130] xhci_hcd 0000:01:00.0: @000000008e07ff00 00000000 00000000 00000000 00000000
[    4.925272] xhci_hcd 0000:01:00.0: @000000008e07ff10 00000000 00000000 00000000 00000000
[    4.933413] xhci_hcd 0000:01:00.0: @000000008e07ff20 00000000 00000000 00000000 00000000
[    4.941553] xhci_hcd 0000:01:00.0: @000000008e07ff30 00000000 00000000 00000000 00000000
[    4.949694] xhci_hcd 0000:01:00.0: @000000008e07ff40 00000000 00000000 00000000 00000000
[    4.957835] xhci_hcd 0000:01:00.0: @000000008e07ff50 00000000 00000000 00000000 00000000
[    4.965975] xhci_hcd 0000:01:00.0: @000000008e07ff60 00000000 00000000 00000000 00000000
[    4.974116] xhci_hcd 0000:01:00.0: @000000008e07ff70 00000000 00000000 00000000 00000000
[    4.982257] xhci_hcd 0000:01:00.0: @000000008e07ff80 00000000 00000000 00000000 00000000
[    4.990398] xhci_hcd 0000:01:00.0: @000000008e07ff90 00000000 00000000 00000000 00000000
[    4.998541] xhci_hcd 0000:01:00.0: @000000008e07ffa0 00000000 00000000 00000000 00000000
[    5.006683] xhci_hcd 0000:01:00.0: @000000008e07ffb0 00000000 00000000 00000000 00000000
[    5.014824] xhci_hcd 0000:01:00.0: @000000008e07ffc0 00000000 00000000 00000000 00000000
[    5.022966] xhci_hcd 0000:01:00.0: @000000008e07ffd0 00000000 00000000 00000000 00000000
[    5.031106] xhci_hcd 0000:01:00.0: @000000008e07ffe0 00000000 00000000 00000000 00000000
[    5.039247] xhci_hcd 0000:01:00.0: @000000008e07fff0 8e07f000 00000000 00000000 00001802
[    5.047387] xhci_hcd 0000:01:00.0:   Ring has not been updated
[    5.053258] xhci_hcd 0000:01:00.0: Ring deq = d0857000 (virt), 0x8e07f000 (dma)
[    5.060613] xhci_hcd 0000:01:00.0: Ring deq updated 0 times
[    5.066220] xhci_hcd 0000:01:00.0: Ring enq = d0857000 (virt), 0x8e07f000 (dma)
[    5.073575] xhci_hcd 0000:01:00.0: Ring enq updated 0 times
[    5.079185] xhci_hcd 0000:01:00.0: // xHC command ring deq ptr low bits + flags = @00000000
[    5.087588] xhci_hcd 0000:01:00.0: // xHC command ring deq ptr high bits = @00000000
[    5.095380] xhci_hcd 0000:01:00.0: @000000008fb99000 8fb98000 00000000 00000100 00000000
[    5.103523] xhci_hcd 0000:01:00.0: @000000008fb98000 00000000 00000000 00000000 00000000
[    5.111664] xhci_hcd 0000:01:00.0: @000000008fb98010 00000000 00000000 00000000 00000000
[    5.119806] xhci_hcd 0000:01:00.0: @000000008fb98020 00000000 00000000 00000000 00000000
[    5.127950] xhci_hcd 0000:01:00.0: @000000008fb98030 00000000 00000000 00000000 00000000
[    5.136091] xhci_hcd 0000:01:00.0: @000000008fb98040 00000000 00000000 00000000 00000000
[    5.144232] xhci_hcd 0000:01:00.0: @000000008fb98050 00000000 00000000 00000000 00000000
[    5.152373] xhci_hcd 0000:01:00.0: @000000008fb98060 00000000 00000000 00000000 00000000
[    5.160514] xhci_hcd 0000:01:00.0: @000000008fb98070 00000000 00000000 00000000 00000000
[    5.168654] xhci_hcd 0000:01:00.0: @000000008fb98080 00000000 00000000 00000000 00000000
[    5.176795] xhci_hcd 0000:01:00.0: @000000008fb98090 00000000 00000000 00000000 00000000
[    5.184935] xhci_hcd 0000:01:00.0: @000000008fb980a0 00000000 00000000 00000000 00000000
[    5.193075] xhci_hcd 0000:01:00.0: @000000008fb980b0 00000000 00000000 00000000 00000000
[    5.201216] xhci_hcd 0000:01:00.0: @000000008fb980c0 00000000 00000000 00000000 00000000
[    5.209357] xhci_hcd 0000:01:00.0: @000000008fb980d0 00000000 00000000 00000000 00000000
[    5.217498] xhci_hcd 0000:01:00.0: @000000008fb980e0 00000000 00000000 00000000 00000000
[    5.225638] xhci_hcd 0000:01:00.0: @000000008fb980f0 00000000 00000000 00000000 00000000
[    5.233779] xhci_hcd 0000:01:00.0: @000000008fb98100 00000000 00000000 00000000 00000000
[    5.241920] xhci_hcd 0000:01:00.0: @000000008fb98110 00000000 00000000 00000000 00000000
[    5.250061] xhci_hcd 0000:01:00.0: @000000008fb98120 00000000 00000000 00000000 00000000
[    5.258206] xhci_hcd 0000:01:00.0: @000000008fb98130 00000000 00000000 00000000 00000000
[    5.266348] xhci_hcd 0000:01:00.0: @000000008fb98140 00000000 00000000 00000000 00000000
[    5.274489] xhci_hcd 0000:01:00.0: @000000008fb98150 00000000 00000000 00000000 00000000
[    5.282631] xhci_hcd 0000:01:00.0: @000000008fb98160 00000000 00000000 00000000 00000000
[    5.290772] xhci_hcd 0000:01:00.0: @000000008fb98170 00000000 00000000 00000000 00000000
[    5.298913] xhci_hcd 0000:01:00.0: @000000008fb98180 00000000 00000000 00000000 00000000
[    5.307054] xhci_hcd 0000:01:00.0: @000000008fb98190 00000000 00000000 00000000 00000000
[    5.315194] xhci_hcd 0000:01:00.0: @000000008fb981a0 00000000 00000000 00000000 00000000
[    5.323336] xhci_hcd 0000:01:00.0: @000000008fb981b0 00000000 00000000 00000000 00000000
[    5.331476] xhci_hcd 0000:01:00.0: @000000008fb981c0 00000000 00000000 00000000 00000000
[    5.339616] xhci_hcd 0000:01:00.0: @000000008fb981d0 00000000 00000000 00000000 00000000
[    5.347758] xhci_hcd 0000:01:00.0: @000000008fb981e0 00000000 00000000 00000000 00000000
[    5.355898] xhci_hcd 0000:01:00.0: @000000008fb981f0 00000000 00000000 00000000 00000000
[    5.364039] xhci_hcd 0000:01:00.0: @000000008fb98200 00000000 00000000 00000000 00000000
[    5.372181] xhci_hcd 0000:01:00.0: @000000008fb98210 00000000 00000000 00000000 00000000
[    5.380322] xhci_hcd 0000:01:00.0: @000000008fb98220 00000000 00000000 00000000 00000000
[    5.388466] xhci_hcd 0000:01:00.0: @000000008fb98230 00000000 00000000 00000000 00000000
[    5.396608] xhci_hcd 0000:01:00.0: @000000008fb98240 00000000 00000000 00000000 00000000
[    5.404749] xhci_hcd 0000:01:00.0: @000000008fb98250 00000000 00000000 00000000 00000000
[    5.412891] xhci_hcd 0000:01:00.0: @000000008fb98260 00000000 00000000 00000000 00000000
[    5.421050] xhci_hcd 0000:01:00.0: @000000008fb98270 00000000 00000000 00000000 00000000
[    5.429195] xhci_hcd 0000:01:00.0: @000000008fb98280 00000000 00000000 00000000 00000000
[    5.437336] xhci_hcd 0000:01:00.0: @000000008fb98290 00000000 00000000 00000000 00000000
[    5.445477] xhci_hcd 0000:01:00.0: @000000008fb982a0 00000000 00000000 00000000 00000000
[    5.453619] xhci_hcd 0000:01:00.0: @000000008fb982b0 00000000 00000000 00000000 00000000
[    5.461760] xhci_hcd 0000:01:00.0: @000000008fb982c0 00000000 00000000 00000000 00000000
[    5.469902] xhci_hcd 0000:01:00.0: @000000008fb982d0 00000000 00000000 00000000 00000000
[    5.478043] xhci_hcd 0000:01:00.0: @000000008fb982e0 00000000 00000000 00000000 00000000
[    5.486184] xhci_hcd 0000:01:00.0: @000000008fb982f0 00000000 00000000 00000000 00000000
[    5.494325] xhci_hcd 0000:01:00.0: @000000008fb98300 00000000 00000000 00000000 00000000
[    5.502465] xhci_hcd 0000:01:00.0: @000000008fb98310 00000000 00000000 00000000 00000000
[    5.510606] xhci_hcd 0000:01:00.0: @000000008fb98320 00000000 00000000 00000000 00000000
[    5.518750] xhci_hcd 0000:01:00.0: @000000008fb98330 00000000 00000000 00000000 00000000
[    5.526893] xhci_hcd 0000:01:00.0: @000000008fb98340 00000000 00000000 00000000 00000000
[    5.535034] xhci_hcd 0000:01:00.0: @000000008fb98350 00000000 00000000 00000000 00000000
[    5.543176] xhci_hcd 0000:01:00.0: @000000008fb98360 00000000 00000000 00000000 00000000
[    5.551317] xhci_hcd 0000:01:00.0: @000000008fb98370 00000000 00000000 00000000 00000000
[    5.559458] xhci_hcd 0000:01:00.0: @000000008fb98380 00000000 00000000 00000000 00000000
[    5.567599] xhci_hcd 0000:01:00.0: @000000008fb98390 00000000 00000000 00000000 00000000
[    5.575741] xhci_hcd 0000:01:00.0: @000000008fb983a0 00000000 00000000 00000000 00000000
[    5.583882] xhci_hcd 0000:01:00.0: @000000008fb983b0 00000000 00000000 00000000 00000000
[    5.592023] xhci_hcd 0000:01:00.0: @000000008fb983c0 00000000 00000000 00000000 00000000
[    5.600165] xhci_hcd 0000:01:00.0: @000000008fb983d0 00000000 00000000 00000000 00000000
[    5.608306] xhci_hcd 0000:01:00.0: @000000008fb983e0 00000000 00000000 00000000 00000000
[    5.616447] xhci_hcd 0000:01:00.0: @000000008fb983f0 00000000 00000000 00000000 00000000
[    5.624588] xhci_hcd 0000:01:00.0: @000000008fb98400 00000000 00000000 00000000 00000000
[    5.632729] xhci_hcd 0000:01:00.0: @000000008fb98410 00000000 00000000 00000000 00000000
[    5.640870] xhci_hcd 0000:01:00.0: @000000008fb98420 00000000 00000000 00000000 00000000
[    5.649014] xhci_hcd 0000:01:00.0: @000000008fb98430 00000000 00000000 00000000 00000000
[    5.657156] xhci_hcd 0000:01:00.0: @000000008fb98440 00000000 00000000 00000000 00000000
[    5.665298] xhci_hcd 0000:01:00.0: @000000008fb98450 00000000 00000000 00000000 00000000
[    5.673440] xhci_hcd 0000:01:00.0: @000000008fb98460 00000000 00000000 00000000 00000000
[    5.681581] xhci_hcd 0000:01:00.0: @000000008fb98470 00000000 00000000 00000000 00000000
[    5.689722] xhci_hcd 0000:01:00.0: @000000008fb98480 00000000 00000000 00000000 00000000
[    5.697862] xhci_hcd 0000:01:00.0: @000000008fb98490 00000000 00000000 00000000 00000000
[    5.706003] xhci_hcd 0000:01:00.0: @000000008fb984a0 00000000 00000000 00000000 00000000
[    5.714144] xhci_hcd 0000:01:00.0: @000000008fb984b0 00000000 00000000 00000000 00000000
[    5.722284] xhci_hcd 0000:01:00.0: @000000008fb984c0 00000000 00000000 00000000 00000000
[    5.730425] xhci_hcd 0000:01:00.0: @000000008fb984d0 00000000 00000000 00000000 00000000
[    5.738566] xhci_hcd 0000:01:00.0: @000000008fb984e0 00000000 00000000 00000000 00000000
[    5.746707] xhci_hcd 0000:01:00.0: @000000008fb984f0 00000000 00000000 00000000 00000000
[    5.754848] xhci_hcd 0000:01:00.0: @000000008fb98500 00000000 00000000 00000000 00000000
[    5.762994] xhci_hcd 0000:01:00.0: @000000008fb98510 00000000 00000000 00000000 00000000
[    5.771134] xhci_hcd 0000:01:00.0: @000000008fb98520 00000000 00000000 00000000 00000000
[    5.779278] xhci_hcd 0000:01:00.0: @000000008fb98530 00000000 00000000 00000000 00000000
[    5.787419] xhci_hcd 0000:01:00.0: @000000008fb98540 00000000 00000000 00000000 00000000
[    5.795561] xhci_hcd 0000:01:00.0: @000000008fb98550 00000000 00000000 00000000 00000000
[    5.803701] xhci_hcd 0000:01:00.0: @000000008fb98560 00000000 00000000 00000000 00000000
[    5.811843] xhci_hcd 0000:01:00.0: @000000008fb98570 00000000 00000000 00000000 00000000
[    5.819984] xhci_hcd 0000:01:00.0: @000000008fb98580 00000000 00000000 00000000 00000000
[    5.828125] xhci_hcd 0000:01:00.0: @000000008fb98590 00000000 00000000 00000000 00000000
[    5.836266] xhci_hcd 0000:01:00.0: @000000008fb985a0 00000000 00000000 00000000 00000000
[    5.844407] xhci_hcd 0000:01:00.0: @000000008fb985b0 00000000 00000000 00000000 00000000
[    5.852548] xhci_hcd 0000:01:00.0: @000000008fb985c0 00000000 00000000 00000000 00000000
[    5.860689] xhci_hcd 0000:01:00.0: @000000008fb985d0 00000000 00000000 00000000 00000000
[    5.868830] xhci_hcd 0000:01:00.0: @000000008fb985e0 00000000 00000000 00000000 00000000
[    5.876971] xhci_hcd 0000:01:00.0: @000000008fb985f0 00000000 00000000 00000000 00000000
[    5.885112] xhci_hcd 0000:01:00.0: @000000008fb98600 00000000 00000000 00000000 00000000
[    5.893253] xhci_hcd 0000:01:00.0: @000000008fb98610 00000000 00000000 00000000 00000000
[    5.901394] xhci_hcd 0000:01:00.0: @000000008fb98620 00000000 00000000 00000000 00000000
[    5.909538] xhci_hcd 0000:01:00.0: @000000008fb98630 00000000 00000000 00000000 00000000
[    5.917681] xhci_hcd 0000:01:00.0: @000000008fb98640 00000000 00000000 00000000 00000000
[    5.925823] xhci_hcd 0000:01:00.0: @000000008fb98650 00000000 00000000 00000000 00000000
[    5.933964] xhci_hcd 0000:01:00.0: @000000008fb98660 00000000 00000000 00000000 00000000
[    5.942105] xhci_hcd 0000:01:00.0: @000000008fb98670 00000000 00000000 00000000 00000000
[    5.950246] xhci_hcd 0000:01:00.0: @000000008fb98680 00000000 00000000 00000000 00000000
[    5.958388] xhci_hcd 0000:01:00.0: @000000008fb98690 00000000 00000000 00000000 00000000
[    5.966529] xhci_hcd 0000:01:00.0: @000000008fb986a0 00000000 00000000 00000000 00000000
[    5.974671] xhci_hcd 0000:01:00.0: @000000008fb986b0 00000000 00000000 00000000 00000000
[    5.982812] xhci_hcd 0000:01:00.0: @000000008fb986c0 00000000 00000000 00000000 00000000
[    5.990953] xhci_hcd 0000:01:00.0: @000000008fb986d0 00000000 00000000 00000000 00000000
[    5.999094] xhci_hcd 0000:01:00.0: @000000008fb986e0 00000000 00000000 00000000 00000000
[    6.007235] xhci_hcd 0000:01:00.0: @000000008fb986f0 00000000 00000000 00000000 00000000
[    6.015376] xhci_hcd 0000:01:00.0: @000000008fb98700 00000000 00000000 00000000 00000000
[    6.023518] xhci_hcd 0000:01:00.0: @000000008fb98710 00000000 00000000 00000000 00000000
[    6.031658] xhci_hcd 0000:01:00.0: @000000008fb98720 00000000 00000000 00000000 00000000
[    6.039802] xhci_hcd 0000:01:00.0: @000000008fb98730 00000000 00000000 00000000 00000000
[    6.047945] xhci_hcd 0000:01:00.0: @000000008fb98740 00000000 00000000 00000000 00000000
[    6.056086] xhci_hcd 0000:01:00.0: @000000008fb98750 00000000 00000000 00000000 00000000
[    6.064228] xhci_hcd 0000:01:00.0: @000000008fb98760 00000000 00000000 00000000 00000000
[    6.072368] xhci_hcd 0000:01:00.0: @000000008fb98770 00000000 00000000 00000000 00000000
[    6.080509] xhci_hcd 0000:01:00.0: @000000008fb98780 00000000 00000000 00000000 00000000
[    6.088650] xhci_hcd 0000:01:00.0: @000000008fb98790 00000000 00000000 00000000 00000000
[    6.096791] xhci_hcd 0000:01:00.0: @000000008fb987a0 00000000 00000000 00000000 00000000
[    6.104931] xhci_hcd 0000:01:00.0: @000000008fb987b0 00000000 00000000 00000000 00000000
[    6.113072] xhci_hcd 0000:01:00.0: @000000008fb987c0 00000000 00000000 00000000 00000000
[    6.121213] xhci_hcd 0000:01:00.0: @000000008fb987d0 00000000 00000000 00000000 00000000
[    6.129354] xhci_hcd 0000:01:00.0: @000000008fb987e0 00000000 00000000 00000000 00000000
[    6.137496] xhci_hcd 0000:01:00.0: @000000008fb987f0 00000000 00000000 00000000 00000000
[    6.145636] xhci_hcd 0000:01:00.0: @000000008fb98800 00000000 00000000 00000000 00000000
[    6.153778] xhci_hcd 0000:01:00.0: @000000008fb98810 00000000 00000000 00000000 00000000
[    6.161919] xhci_hcd 0000:01:00.0: @000000008fb98820 00000000 00000000 00000000 00000000
[    6.170062] xhci_hcd 0000:01:00.0: @000000008fb98830 00000000 00000000 00000000 00000000
[    6.178203] xhci_hcd 0000:01:00.0: @000000008fb98840 00000000 00000000 00000000 00000000
[    6.186344] xhci_hcd 0000:01:00.0: @000000008fb98850 00000000 00000000 00000000 00000000
[    6.194485] xhci_hcd 0000:01:00.0: @000000008fb98860 00000000 00000000 00000000 00000000
[    6.202626] xhci_hcd 0000:01:00.0: @000000008fb98870 00000000 00000000 00000000 00000000
[    6.210767] xhci_hcd 0000:01:00.0: @000000008fb98880 00000000 00000000 00000000 00000000
[    6.218908] xhci_hcd 0000:01:00.0: @000000008fb98890 00000000 00000000 00000000 00000000
[    6.227049] xhci_hcd 0000:01:00.0: @000000008fb988a0 00000000 00000000 00000000 00000000
[    6.235190] xhci_hcd 0000:01:00.0: @000000008fb988b0 00000000 00000000 00000000 00000000
[    6.243332] xhci_hcd 0000:01:00.0: @000000008fb988c0 00000000 00000000 00000000 00000000
[    6.251473] xhci_hcd 0000:01:00.0: @000000008fb988d0 00000000 00000000 00000000 00000000
[    6.259614] xhci_hcd 0000:01:00.0: @000000008fb988e0 00000000 00000000 00000000 00000000
[    6.267755] xhci_hcd 0000:01:00.0: @000000008fb988f0 00000000 00000000 00000000 00000000
[    6.275895] xhci_hcd 0000:01:00.0: @000000008fb98900 00000000 00000000 00000000 00000000
[    6.284037] xhci_hcd 0000:01:00.0: @000000008fb98910 00000000 00000000 00000000 00000000
[    6.292178] xhci_hcd 0000:01:00.0: @000000008fb98920 00000000 00000000 00000000 00000000
[    6.300322] xhci_hcd 0000:01:00.0: @000000008fb98930 00000000 00000000 00000000 00000000
[    6.308464] xhci_hcd 0000:01:00.0: @000000008fb98940 00000000 00000000 00000000 00000000
[    6.316606] xhci_hcd 0000:01:00.0: @000000008fb98950 00000000 00000000 00000000 00000000
[    6.324747] xhci_hcd 0000:01:00.0: @000000008fb98960 00000000 00000000 00000000 00000000
[    6.332888] xhci_hcd 0000:01:00.0: @000000008fb98970 00000000 00000000 00000000 00000000
[    6.341029] xhci_hcd 0000:01:00.0: @000000008fb98980 00000000 00000000 00000000 00000000
[    6.349169] xhci_hcd 0000:01:00.0: @000000008fb98990 00000000 00000000 00000000 00000000
[    6.357310] xhci_hcd 0000:01:00.0: @000000008fb989a0 00000000 00000000 00000000 00000000
[    6.365451] xhci_hcd 0000:01:00.0: @000000008fb989b0 00000000 00000000 00000000 00000000
[    6.373593] xhci_hcd 0000:01:00.0: @000000008fb989c0 00000000 00000000 00000000 00000000
[    6.381733] xhci_hcd 0000:01:00.0: @000000008fb989d0 00000000 00000000 00000000 00000000
[    6.389875] xhci_hcd 0000:01:00.0: @000000008fb989e0 00000000 00000000 00000000 00000000
[    6.398016] xhci_hcd 0000:01:00.0: @000000008fb989f0 00000000 00000000 00000000 00000000
[    6.406157] xhci_hcd 0000:01:00.0: @000000008fb98a00 00000000 00000000 00000000 00000000
[    6.414298] xhci_hcd 0000:01:00.0: @000000008fb98a10 00000000 00000000 00000000 00000000
[    6.422439] xhci_hcd 0000:01:00.0: @000000008fb98a20 00000000 00000000 00000000 00000000
[    6.430600] xhci_hcd 0000:01:00.0: @000000008fb98a30 00000000 00000000 00000000 00000000
[    6.438744] xhci_hcd 0000:01:00.0: @000000008fb98a40 00000000 00000000 00000000 00000000
[    6.446886] xhci_hcd 0000:01:00.0: @000000008fb98a50 00000000 00000000 00000000 00000000
[    6.455028] xhci_hcd 0000:01:00.0: @000000008fb98a60 00000000 00000000 00000000 00000000
[    6.463170] xhci_hcd 0000:01:00.0: @000000008fb98a70 00000000 00000000 00000000 00000000
[    6.471310] xhci_hcd 0000:01:00.0: @000000008fb98a80 00000000 00000000 00000000 00000000
[    6.479452] xhci_hcd 0000:01:00.0: @000000008fb98a90 00000000 00000000 00000000 00000000
[    6.487593] xhci_hcd 0000:01:00.0: @000000008fb98aa0 00000000 00000000 00000000 00000000
[    6.495733] xhci_hcd 0000:01:00.0: @000000008fb98ab0 00000000 00000000 00000000 00000000
[    6.503875] xhci_hcd 0000:01:00.0: @000000008fb98ac0 00000000 00000000 00000000 00000000
[    6.512085] xhci_hcd 0000:01:00.0: @000000008fb98ad0 00000000 00000000 00000000 00000000
[    6.520239] xhci_hcd 0000:01:00.0: @000000008fb98ae0 00000000 00000000 00000000 00000000
[    6.528385] xhci_hcd 0000:01:00.0: @000000008fb98af0 00000000 00000000 00000000 00000000
[    6.536527] xhci_hcd 0000:01:00.0: @000000008fb98b00 00000000 00000000 00000000 00000000
[    6.544669] xhci_hcd 0000:01:00.0: @000000008fb98b10 00000000 00000000 00000000 00000000
[    6.552810] xhci_hcd 0000:01:00.0: @000000008fb98b20 00000000 00000000 00000000 00000000
[    6.560955] xhci_hcd 0000:01:00.0: @000000008fb98b30 00000000 00000000 00000000 00000000
[    6.569097] xhci_hcd 0000:01:00.0: @000000008fb98b40 00000000 00000000 00000000 00000000
[    6.577240] xhci_hcd 0000:01:00.0: @000000008fb98b50 00000000 00000000 00000000 00000000
[    6.585381] xhci_hcd 0000:01:00.0: @000000008fb98b60 00000000 00000000 00000000 00000000
[    6.593523] xhci_hcd 0000:01:00.0: @000000008fb98b70 00000000 00000000 00000000 00000000
[    6.601664] xhci_hcd 0000:01:00.0: @000000008fb98b80 00000000 00000000 00000000 00000000
[    6.609805] xhci_hcd 0000:01:00.0: @000000008fb98b90 00000000 00000000 00000000 00000000
[    6.617946] xhci_hcd 0000:01:00.0: @000000008fb98ba0 00000000 00000000 00000000 00000000
[    6.626088] xhci_hcd 0000:01:00.0: @000000008fb98bb0 00000000 00000000 00000000 00000000
[    6.634228] xhci_hcd 0000:01:00.0: @000000008fb98bc0 00000000 00000000 00000000 00000000
[    6.642370] xhci_hcd 0000:01:00.0: @000000008fb98bd0 00000000 00000000 00000000 00000000
[    6.650511] xhci_hcd 0000:01:00.0: @000000008fb98be0 00000000 00000000 00000000 00000000
[    6.658652] xhci_hcd 0000:01:00.0: @000000008fb98bf0 00000000 00000000 00000000 00000000
[    6.666793] xhci_hcd 0000:01:00.0: @000000008fb98c00 00000000 00000000 00000000 00000000
[    6.674934] xhci_hcd 0000:01:00.0: @000000008fb98c10 00000000 00000000 00000000 00000000
[    6.683075] xhci_hcd 0000:01:00.0: @000000008fb98c20 00000000 00000000 00000000 00000000
[    6.691219] xhci_hcd 0000:01:00.0: @000000008fb98c30 00000000 00000000 00000000 00000000
[    6.699360] xhci_hcd 0000:01:00.0: @000000008fb98c40 00000000 00000000 00000000 00000000
[    6.707502] xhci_hcd 0000:01:00.0: @000000008fb98c50 00000000 00000000 00000000 00000000
[    6.715643] xhci_hcd 0000:01:00.0: @000000008fb98c60 00000000 00000000 00000000 00000000
[    6.723788] xhci_hcd 0000:01:00.0: @000000008fb98c70 00000000 00000000 00000000 00000000
[    6.731931] xhci_hcd 0000:01:00.0: @000000008fb98c80 00000000 00000000 00000000 00000000
[    6.740074] xhci_hcd 0000:01:00.0: @000000008fb98c90 00000000 00000000 00000000 00000000
[    6.748215] xhci_hcd 0000:01:00.0: @000000008fb98ca0 00000000 00000000 00000000 00000000
[    6.756356] xhci_hcd 0000:01:00.0: @000000008fb98cb0 00000000 00000000 00000000 00000000
[    6.764497] xhci_hcd 0000:01:00.0: @000000008fb98cc0 00000000 00000000 00000000 00000000
[    6.772639] xhci_hcd 0000:01:00.0: @000000008fb98cd0 00000000 00000000 00000000 00000000
[    6.780780] xhci_hcd 0000:01:00.0: @000000008fb98ce0 00000000 00000000 00000000 00000000
[    6.788922] xhci_hcd 0000:01:00.0: @000000008fb98cf0 00000000 00000000 00000000 00000000
[    6.797063] xhci_hcd 0000:01:00.0: @000000008fb98d00 00000000 00000000 00000000 00000000
[    6.805204] xhci_hcd 0000:01:00.0: @000000008fb98d10 00000000 00000000 00000000 00000000
[    6.813346] xhci_hcd 0000:01:00.0: @000000008fb98d20 00000000 00000000 00000000 00000000
[    6.821489] xhci_hcd 0000:01:00.0: @000000008fb98d30 00000000 00000000 00000000 00000000
[    6.829631] xhci_hcd 0000:01:00.0: @000000008fb98d40 00000000 00000000 00000000 00000000
[    6.837773] xhci_hcd 0000:01:00.0: @000000008fb98d50 00000000 00000000 00000000 00000000
[    6.845914] xhci_hcd 0000:01:00.0: @000000008fb98d60 00000000 00000000 00000000 00000000
[    6.854054] xhci_hcd 0000:01:00.0: @000000008fb98d70 00000000 00000000 00000000 00000000
[    6.862196] xhci_hcd 0000:01:00.0: @000000008fb98d80 00000000 00000000 00000000 00000000
[    6.870336] xhci_hcd 0000:01:00.0: @000000008fb98d90 00000000 00000000 00000000 00000000
[    6.878477] xhci_hcd 0000:01:00.0: @000000008fb98da0 00000000 00000000 00000000 00000000
[    6.886618] xhci_hcd 0000:01:00.0: @000000008fb98db0 00000000 00000000 00000000 00000000
[    6.894758] xhci_hcd 0000:01:00.0: @000000008fb98dc0 00000000 00000000 00000000 00000000
[    6.902899] xhci_hcd 0000:01:00.0: @000000008fb98dd0 00000000 00000000 00000000 00000000
[    6.911040] xhci_hcd 0000:01:00.0: @000000008fb98de0 00000000 00000000 00000000 00000000
[    6.919180] xhci_hcd 0000:01:00.0: @000000008fb98df0 00000000 00000000 00000000 00000000
[    6.927321] xhci_hcd 0000:01:00.0: @000000008fb98e00 00000000 00000000 00000000 00000000
[    6.935462] xhci_hcd 0000:01:00.0: @000000008fb98e10 00000000 00000000 00000000 00000000
[    6.943603] xhci_hcd 0000:01:00.0: @000000008fb98e20 00000000 00000000 00000000 00000000
[    6.951746] xhci_hcd 0000:01:00.0: @000000008fb98e30 00000000 00000000 00000000 00000000
[    6.959888] xhci_hcd 0000:01:00.0: @000000008fb98e40 00000000 00000000 00000000 00000000
[    6.968028] xhci_hcd 0000:01:00.0: @000000008fb98e50 00000000 00000000 00000000 00000000
[    6.976169] xhci_hcd 0000:01:00.0: @000000008fb98e60 00000000 00000000 00000000 00000000
[    6.984310] xhci_hcd 0000:01:00.0: @000000008fb98e70 00000000 00000000 00000000 00000000
[    6.992450] xhci_hcd 0000:01:00.0: @000000008fb98e80 00000000 00000000 00000000 00000000
[    7.000592] xhci_hcd 0000:01:00.0: @000000008fb98e90 00000000 00000000 00000000 00000000
[    7.008733] xhci_hcd 0000:01:00.0: @000000008fb98ea0 00000000 00000000 00000000 00000000
[    7.016874] xhci_hcd 0000:01:00.0: @000000008fb98eb0 00000000 00000000 00000000 00000000
[    7.025015] xhci_hcd 0000:01:00.0: @000000008fb98ec0 00000000 00000000 00000000 00000000
[    7.033157] xhci_hcd 0000:01:00.0: @000000008fb98ed0 00000000 00000000 00000000 00000000
[    7.041297] xhci_hcd 0000:01:00.0: @000000008fb98ee0 00000000 00000000 00000000 00000000
[    7.049438] xhci_hcd 0000:01:00.0: @000000008fb98ef0 00000000 00000000 00000000 00000000
[    7.057579] xhci_hcd 0000:01:00.0: @000000008fb98f00 00000000 00000000 00000000 00000000
[    7.065720] xhci_hcd 0000:01:00.0: @000000008fb98f10 00000000 00000000 00000000 00000000
[    7.073862] xhci_hcd 0000:01:00.0: @000000008fb98f20 00000000 00000000 00000000 00000000
[    7.082006] xhci_hcd 0000:01:00.0: @000000008fb98f30 00000000 00000000 00000000 00000000
[    7.090148] xhci_hcd 0000:01:00.0: @000000008fb98f40 00000000 00000000 00000000 00000000
[    7.098289] xhci_hcd 0000:01:00.0: @000000008fb98f50 00000000 00000000 00000000 00000000
[    7.106430] xhci_hcd 0000:01:00.0: @000000008fb98f60 00000000 00000000 00000000 00000000
[    7.114571] xhci_hcd 0000:01:00.0: @000000008fb98f70 00000000 00000000 00000000 00000000
[    7.122712] xhci_hcd 0000:01:00.0: @000000008fb98f80 00000000 00000000 00000000 00000000
[    7.130852] xhci_hcd 0000:01:00.0: @000000008fb98f90 00000000 00000000 00000000 00000000
[    7.138993] xhci_hcd 0000:01:00.0: @000000008fb98fa0 00000000 00000000 00000000 00000000
[    7.147134] xhci_hcd 0000:01:00.0: @000000008fb98fb0 00000000 00000000 00000000 00000000
[    7.155276] xhci_hcd 0000:01:00.0: @000000008fb98fc0 00000000 00000000 00000000 00000000
[    7.163417] xhci_hcd 0000:01:00.0: @000000008fb98fd0 00000000 00000000 00000000 00000000
[    7.171558] xhci_hcd 0000:01:00.0: @000000008fb98fe0 00000000 00000000 00000000 00000000
[    7.179700] xhci_hcd 0000:01:00.0: @000000008fb98ff0 00000000 00000000 00000000 00000000
[    7.187839] xhci_hcd 0000:01:00.0:   Ring has not been updated
[    7.193709] xhci_hcd 0000:01:00.0: Ring deq = d085b000 (virt), 0x8fb98000 (dma)
[    7.201063] xhci_hcd 0000:01:00.0: Ring deq updated 0 times
[    7.206671] xhci_hcd 0000:01:00.0: Ring enq = d085b000 (virt), 0x8fb98000 (dma)
[    7.214028] xhci_hcd 0000:01:00.0: Ring enq updated 0 times
[    7.219640] xhci_hcd 0000:01:00.0: ERST deq = 64'h8fb98000
[    7.225160] xhci_hcd 0000:01:00.0: // Set the interrupt modulation register
[    7.232172] xhci_hcd 0000:01:00.0: // Enable interrupts, cmd = 0x4.
[    7.238482] xhci_hcd 0000:01:00.0: // Enabling event ring interrupter d0852620 by writing 0x2 to irq_pending
[    7.248373] xhci_hcd 0000:01:00.0:   d0852620: ir_set[0]
[    7.253720] xhci_hcd 0000:01:00.0:   d0852620: ir_set.pending = 0x2
[    7.260028] xhci_hcd 0000:01:00.0:   d0852624: ir_set.control = 0xa0
[    7.266424] xhci_hcd 0000:01:00.0:   d0852628: ir_set.erst_size = 0x1
[    7.272911] xhci_hcd 0000:01:00.0:   d0852630: ir_set.erst_base = @8fb99000
[    7.279921] xhci_hcd 0000:01:00.0:   d0852638: ir_set.erst_dequeue = @8fb98000
[    7.287188] xhci_hcd 0000:01:00.0: Finished xhci_run for USB2 roothub
[    7.293805] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    7.300642] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    7.307910] usb usb1: Product: xHCI Host Controller
[    7.312818] usb usb1: Manufacturer: Linux 4.9.7-1-rc2 xhci-hcd
[    7.318687] usb usb1: SerialNumber: 0000:01:00.0
[    7.323868] hub 1-0:1.0: USB hub found
[    7.327690] hub 1-0:1.0: 4 ports detected
[    7.331835] xhci_hcd 0000:01:00.0: set port power, actual port 0 status  = 0x2a0
[    7.339302] xhci_hcd 0000:01:00.0: set port power, actual port 1 status  = 0x2a0
[    7.346771] xhci_hcd 0000:01:00.0: set port power, actual port 2 status  = 0x2a0
[    7.354233] xhci_hcd 0000:01:00.0: set port power, actual port 3 status  = 0x2a0
[    7.361803] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    7.367078] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 2
[    7.374538] xhci_hcd 0000:01:00.0: // Turn on HC, cmd = 0x5.
[    7.427017] xhci_hcd 0000:01:00.0: Host took too long to start, waited 16000 microseconds.

***** This is likely the most pressing issue.

[    7.435334] xhci_hcd 0000:01:00.0: // Halt the HC
[    7.440075] xhci_hcd 0000:01:00.0: startup error -19
[    7.445075] xhci_hcd 0000:01:00.0: USB bus 2 deregistered
[    7.450519] xhci_hcd 0000:01:00.0: remove, state 1
[    7.455351] usb usb1: USB disconnect, device number 1
[    7.460830] tango_config_write: bus=1 where=146 size=2 val=0x7
[    7.466733] tango_config_write: bus=1 where=4 size=2 val=0x146
[    7.472623] msi_readl: reg=32 val=0xffffffff
[    7.476925] msi_writel: reg=32 val=0xfffffffd
[    7.481343] msi_readl: reg=32 val=0xfffffffd
[    7.485641] msi_writel: reg=32 val=0xfffffff9
[    7.490052] msi_readl: reg=32 val=0xfffffff9
[    7.494351] msi_writel: reg=32 val=0xfffffff1
[    7.498778] xhci_hcd 0000:01:00.0: // Disabling event ring interrupts
[    7.505277] xhci_hcd 0000:01:00.0: cleaning up memory
[    7.510379] xhci_hcd 0000:01:00.0: Freed ERST
[    7.514773] xhci_hcd 0000:01:00.0: Freed event ring
[    7.519687] xhci_hcd 0000:01:00.0: Freed command ring
[    7.524790] xhci_hcd 0000:01:00.0: Freed segment pool
[    7.529879] xhci_hcd 0000:01:00.0: Freed device context pool
[    7.535574] xhci_hcd 0000:01:00.0: Freed small stream array pool
[    7.541618] xhci_hcd 0000:01:00.0: Freed medium stream array pool
[    7.547770] xhci_hcd 0000:01:00.0: xhci_stop completed - status = 1
[    7.554078] xhci_hcd 0000:01:00.0: USB bus 1 deregistered
[    7.559533] tango_config_write: bus=1 where=4 size=2 val=0x142
[    7.565658] usbcore: registered new interface driver usb-storage
                                                                                         

I'm still investigating.

Regards.
