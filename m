Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 8 May 2017 18:13:39 +0200
From: Peter Senna Tschudin <peter.senna@collabora.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: Regression: 442ec4c04d1: PCI: dwc: all: Split struct pcie_port
 into host-only and core structures
Message-ID: <20170508161339.GA12665@collabora.com>
References: <20170508150224.GA7458@collabora.com>
 <967686bf-5f1b-29aa-ee2f-b976addbe98f@ti.com>
MIME-Version: 1.0
In-Reply-To: <967686bf-5f1b-29aa-ee2f-b976addbe98f@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jesper Nilsson <jesper.nilsson@axis.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 Richard Zhu <hongxing.zhu@nxp.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Jingoo Han <jingoohan1@gmail.com>, Pratyush Anand <pratyush.anand@gmail.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Murali Karicheri <m-karicheri2@ti.com>,
 Niklas Cassel <niklas.cassel@axis.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Mingkai Hu <mingkai.hu@freescale.com>, Roy Zang <tie-fei.zang@freescale.com>,
 linux-arm-kernel@lists.infradead.org, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 08, 2017 at 09:09:32PM +0530, Kishon Vijay Abraham I wrote:
.
.
<snip>
.
.
> > [    0.501998] OF: PCI: host bridge /soc/pcie@1ffc000 ranges:
> > [    0.507275] OF: PCI:    IO 0x01f80000..0x01f8ffff -> 0x00000000
> > [    0.513202] OF: PCI:   MEM 0x01000000..0x01efffff -> 0x01000000
> > [    0.739697] imx6q-pcie 1ffc000.pcie: link up
> > [    0.741115] imx6q-pcie 1ffc000.pcie: Link: Gen2 disabled
> > [    0.746421] imx6q-pcie 1ffc000.pcie: Link up, Gen1
> > [    0.751343] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
> > [    0.757475] pci_bus 0000:00: root bus resource [bus 00-ff]
> > [    0.762974] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> > [    0.769128] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
> > [    0.776052] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
> > [    0.782044] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
> > [    0.788279] pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
> > [    0.795041] pci 0000:00:00.0: supports D1
> > [    0.798971] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
> > [    0.805503] PCI: bus0: Fast back to back transfers disabled
> > [    0.811079] pci 0000:01:00.0: [10b5:8605] type 01 class 0x060400
> 
> I could see a couple of device detected [16c3:abcd and [10b5:8605]. What other
> devices are connected?

$ lspci -v

00:00.0 PCI bridge: Synopsys, Inc. Device abcd (rev 01) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0, IRQ 301
	Memory at 01000000 (32-bit, non-prefetchable) [size=1M]
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00001000-00002fff
	Memory behind bridge: 01100000-014fffff
	Prefetchable memory behind bridge: 01500000-016fffff
	[virtual] Expansion ROM at 01700000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 3
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable+ 64bit+
	Capabilities: [70] Express Root Port (Slot-), MSI 00
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Virtual Channel
	Kernel driver in use: pcieport

01:00.0 PCI bridge: PLX Technology, Inc. PEX 8605 PCI Express 4-port Gen2 Switch (rev ab) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0, IRQ 302
	Memory at 01400000 (32-bit, non-prefetchable) [size=16K]
	Bus: primary=01, secondary=02, subordinate=05, sec-latency=0
	I/O behind bridge: 00001000-00002fff
	Memory behind bridge: 01100000-013fffff
	Prefetchable memory behind bridge: 0000000001500000-00000000016fffff
	Capabilities: [40] Power Management version 3
	Capabilities: [48] MSI: Enable+ Count=1/4 Maskable+ 64bit+
	Capabilities: [68] Express Upstream Port, MSI 00
	Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8605 PCI Express 4-port Gen2 Switch
	Capabilities: [100] Device Serial Number ab-86-02-10-b5-df-0e-00
	Capabilities: [fb4] Advanced Error Reporting
	Capabilities: [138] Power Budgeting <?>
	Capabilities: [148] Virtual Channel
	Capabilities: [950] Vendor Specific Information: ID=0001 Rev=0 Len=028 <?>
	Kernel driver in use: pcieport

02:01.0 PCI bridge: PLX Technology, Inc. PEX 8605 PCI Express 4-port Gen2 Switch (rev ab) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0, IRQ 303
	Bus: primary=02, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 00001000-00001fff
	Memory behind bridge: 01100000-012fffff
	Prefetchable memory behind bridge: 0000000001500000-00000000016fffff
	Capabilities: [40] Power Management version 3
	Capabilities: [48] MSI: Enable+ Count=1/4 Maskable+ 64bit+
	Capabilities: [68] Express Downstream Port (Slot+), MSI 00
	Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8605 PCI Express 4-port Gen2 Switch
	Capabilities: [100] Device Serial Number ab-86-02-10-b5-df-0e-00
	Capabilities: [fb4] Advanced Error Reporting
	Capabilities: [148] Virtual Channel
	Capabilities: [520] Access Control Services
	Capabilities: [950] Vendor Specific Information: ID=0001 Rev=0 Len=028 <?>
	Kernel driver in use: pcieport

02:02.0 PCI bridge: PLX Technology, Inc. PEX 8605 PCI Express 4-port Gen2 Switch (rev ab) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0, IRQ 304
	Bus: primary=02, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: 01300000-013fffff
	Capabilities: [40] Power Management version 3
	Capabilities: [48] MSI: Enable+ Count=1/4 Maskable+ 64bit+
	Capabilities: [68] Express Downstream Port (Slot+), MSI 00
	Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8605 PCI Express 4-port Gen2 Switch
	Capabilities: [100] Device Serial Number ab-86-02-10-b5-df-0e-00
	Capabilities: [fb4] Advanced Error Reporting
	Capabilities: [148] Virtual Channel
	Capabilities: [520] Access Control Services
	Capabilities: [950] Vendor Specific Information: ID=0001 Rev=0 Len=028 <?>
	Kernel driver in use: pcieport

02:03.0 PCI bridge: PLX Technology, Inc. PEX 8605 PCI Express 4-port Gen2 Switch (rev ab) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0, IRQ 305
	Bus: primary=02, secondary=05, subordinate=05, sec-latency=0
	Capabilities: [40] Power Management version 3
	Capabilities: [48] MSI: Enable+ Count=1/4 Maskable+ 64bit+
	Capabilities: [68] Express Downstream Port (Slot+), MSI 00
	Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8605 PCI Express 4-port Gen2 Switch
	Capabilities: [100] Device Serial Number ab-86-02-10-b5-df-0e-00
	Capabilities: [fb4] Advanced Error Reporting
	Capabilities: [148] Virtual Channel
	Capabilities: [520] Access Control Services
	Capabilities: [950] Vendor Specific Information: ID=0001 Rev=0 Len=028 <?>
	Kernel driver in use: pcieport

03:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network Connection (rev 03)
	Flags: bus master, fast devsel, latency 0, IRQ 306
	Memory at 01100000 (32-bit, non-prefetchable) [size=512K]
	I/O ports at 1000 [disabled] [size=32]
	Memory at 01180000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [40] Power Management version 3
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable+ 64bit+
	Capabilities: [70] MSI-X: Enable- Count=5 Masked-
	Capabilities: [a0] Express Endpoint, MSI 00
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Device Serial Number 00-a0-c9-ff-ff-00-00-00
	Capabilities: [1a0] Transaction Processing Hints
	Kernel driver in use: igb

04:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network Connection (rev 03)
	Flags: bus master, fast devsel, latency 0, IRQ 307
	Memory at 01300000 (32-bit, non-prefetchable) [size=512K]
	I/O ports at 2000 [disabled] [size=32]
	Memory at 01380000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [40] Power Management version 3
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable+ 64bit+
	Capabilities: [70] MSI-X: Enable- Count=5 Masked-
	Capabilities: [a0] Express Endpoint, MSI 00
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Device Serial Number 00-40-97-ff-ff-29-04-44
	Capabilities: [1a0] Transaction Processing Hints
	Kernel driver in use: igb



> > [    0.817034] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff]
> > [    0.823778] pci 0000:01:00.0: supports D1 D2
> > [    0.827418] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> > [    0.859773] PCI: bus1: Fast back to back transfers disabled
> > [    0.862502] pci 0000:01:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> > [    0.870810] pci_bus 0000:02: busn_res: can not insert [bus 02-ff] under [bus 01] (conflicts with (null) [bus 01])
> 
> Do you get the above message in the working scenario?

Yes, same message in the working scenario. Sending full log of working
scenario compiling with head at 40f67fb, which is the last good commit
according to bisect. dmesg of working scenario compiled with head at
40f67fb:

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.10.0-rc1-00012-g40f67fb-dirty (peter@lenovo-peter.home) (gcc version 6.1.1 20160621 (Red Hat Cross 6.1.1-2) (7
[    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] OF: fdt:Machine model: General Electric B850v3
[    0.000000] earlycon: ec_imx21 at MMIO 0x021ec000 (options '')
[    0.000000] bootconsole [ec_imx21] enabled
[    0.000000] cma: Reserved 128 MiB at 0x88000000
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] On node 0 totalpages: 524288
[    0.000000] free_area_init_node: node 0, pgdat 80d6ea00, node_mem_map eeff7000
[    0.000000]   Normal zone: 3584 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 458752 pages, LIFO batch:31
[    0.000000]   HighMem zone: 65536 pages, LIFO batch:15
[    0.000000] percpu: Embedded 15 pages/cpu @eefb7000 s28876 r8192 d24372 u61440
[    0.000000] pcpu-alloc: s28876 r8192 d24372 u61440 alloc=15*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 520704
[    0.000000] Kernel command line: root=/dev/mmcblk0p2 ro rootwait cma=128M video=DP-1:1024x768@60 video=HDMI-A-1:1024x768@60 earlycon logl0
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes)
[    0.000000] Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Memory: 1934728K/2097152K available (8192K kernel code, 475K rwdata, 2160K rodata, 1024K init, 302K bss, 31352K reserved, 131)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
[    0.000000]     lowmem  : 0x80000000 - 0xf0000000   (1792 MB)
[    0.000000]     pkmap   : 0x7fe00000 - 0x80000000   (   2 MB)
[    0.000000]     modules : 0x7f000000 - 0x7fe00000   (  14 MB)
[    0.000000]       .text : 0x80008000 - 0x80900000   (9184 kB)
[    0.000000]       .init : 0x80c00000 - 0x80d00000   (1024 kB)
[    0.000000]       .data : 0x80d00000 - 0x80d76e24   ( 476 kB)
[    0.000000]        .bss : 0x80d78000 - 0x80dc3b28   ( 303 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  Build-time adjustment of leaf fanout to 32.
[    0.000000]  RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=2
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] L2C-310 errata 752271 769419 enabled
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
[    0.000000] L2C-310 ID prefetch enabled, offset 16 lines
[    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
[    0.000000] L2C-310 cache controller enabled, 16 ways, 1024 kB
[    0.000000] L2C-310: CACHE_ID 0x410000c7, AUX_CTRL 0x76470001
[    0.000000] Switching to timer-based delay loop, resolution 333ns
[    0.000009] sched_clock: 32 bits at 3000kHz, resolution 333ns, wraps every 715827882841ns
[    0.008182] clocksource: mxc_timer1: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 637086815595 ns
[    0.019522] Console: colour dummy device 80x30
[    0.022280] Calibrating delay loop (skipped), value calculated using timer frequency.. 6.00 BogoMIPS (lpj=30000)
[    0.032462] pid_max: default: 32768 minimum: 301
[    0.037155] Mount-cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.043759] Mountpoint-cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.051553] CPU: Testing write buffer coherency: ok
[    0.055765] ftrace: allocating 26241 entries in 77 pages
[    0.109701] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.112820] Setting up static identity map for 0x10100000 - 0x1010004c
[    0.119822] smp: Bringing up secondary CPUs ...
[    0.124245] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.124335] smp: Brought up 1 node, 2 CPUs
[    0.133305] SMP: Total of 2 processors activated (12.00 BogoMIPS).
[    0.139491] CPU: All CPU(s) started in SVC mode.
[    0.145077] devtmpfs: initialized
[    0.158299] VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
[    0.163258] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.178699] pinctrl core: initialized pinctrl subsystem
[    0.182057] NET: Registered protocol family 16
[    0.187232] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.193622] CPU identified as i.MX6Q, silicon rev 1.5
[    0.213537] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint registers.
[    0.218727] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.225735] imx6q-pinctrl 20e0000.iomuxc: initialized IMX pinctrl driver
[    0.251527] mxs-dma 110000.dma-apbh: initialized
[    0.256010] vgaarb: loaded
[    0.256456] SCSI subsystem initialized
[    0.259917] libata version 3.00 loaded.
[    0.263807] usbcore: registered new interface driver usbfs
[    0.269118] usbcore: registered new interface driver hub
[    0.274418] usbcore: registered new device driver usb
[    0.280477] i2c i2c-0: IMX I2C adapter registered
[    0.284100] i2c i2c-0: can't use DMA, using PIO instead.
[    0.289821] i2c i2c-1: IMX I2C adapter registered
[    0.294101] i2c i2c-1: can't use DMA, using PIO instead.
[    0.299904] i2c i2c-2: IMX I2C adapter registered
[    0.304107] i2c i2c-2: can't use DMA, using PIO instead.
[    0.309531] pps_core: LinuxPPS API ver. 1 registered
[    0.314376] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.323516] PTP clock support registered
[    0.327704] Advanced Linux Sound Architecture Driver Initialized.
[    0.335376] clocksource: Switched to clocksource mxc_timer1
[    0.378644] NET: Registered protocol family 2
[    0.380733] TCP established hash table entries: 16384 (order: 4, 65536 bytes)
[    0.387454] TCP bind hash table entries: 16384 (order: 5, 131072 bytes)
[    0.394126] TCP: Hash tables configured (established 16384 bind 16384)
[    0.400537] UDP hash table entries: 1024 (order: 3, 32768 bytes)
[    0.406518] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes)
[    0.413060] NET: Registered protocol family 1
[    0.417269] PCI: CLS 0 bytes, default 64
[    0.421839] hw perfevents: enabled with armv7_cortex_a9 PMU driver, 7 counters available
[    0.430197] futex hash table entries: 512 (order: 3, 32768 bytes)
[    0.435393] audit: initializing netlink subsys (disabled)
[    0.440986] audit: type=2000 audit(0.400:1): initialized
[    0.446121] workingset: timestamp_bits=30 max_order=19 bucket_order=0
[    0.463381] bounce: pool size: 64 pages
[    0.464363] io scheduler noop registered
[    0.468301] io scheduler deadline registered
[    0.472676] io scheduler cfq registered (default)
[    0.477737] imx-weim 21b8000.weim: Invalid 'ranges' configuration
[    0.483352] imx-weim: probe of 21b8000.weim failed with error -22
[    0.490619] OF: PCI: host bridge /soc/pcie@0x01000000 ranges:
[    0.495163] OF: PCI:   No bus range found for /soc/pcie@0x01000000, using [bus 00-ff]
[    0.503027] OF: PCI:    IO 0x01f80000..0x01f8ffff -> 0x00000000
[    0.508927] OF: PCI:   MEM 0x01000000..0x01efffff -> 0x01000000
[    0.735447] imx6q-pcie 1ffc000.pcie: link up
[    0.736863] imx6q-pcie 1ffc000.pcie: Link: Gen2 disabled
[    0.742169] imx6q-pcie 1ffc000.pcie: link up
[    0.746459] imx6q-pcie 1ffc000.pcie: Link up, Gen1
[    0.751360] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
[    0.757506] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.762966] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.769164] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
[    0.776055] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
[    0.782036] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
[    0.788308] pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
[    0.795043] pci 0000:00:00.0: supports D1
[    0.799000] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
[    0.805539] PCI: bus0: Fast back to back transfers disabled
[    0.811085] pci 0000:01:00.0: [10b5:8605] type 01 class 0x060400
[    0.817010] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff]
[    0.823755] pci 0000:01:00.0: supports D1 D2
[    0.827453] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.855481] PCI: bus1: Fast back to back transfers disabled
[    0.858210] pci 0000:01:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    0.866522] pci_bus 0000:02: busn_res: can not insert [bus 02-ff] under [bus 01] (conflicts with (null) [bus 01])
[    0.876603] pci 0000:02:01.0: [10b5:8605] type 01 class 0x060400
[    0.883143] pci 0000:02:01.0: supports D1 D2
[    0.886755] pci 0000:02:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.893703] pci 0000:02:02.0: [10b5:8605] type 01 class 0x060400
[    0.900037] pci 0000:02:02.0: supports D1 D2
[    0.903613] pci 0000:02:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.910593] pci 0000:02:03.0: [10b5:8605] type 01 class 0x060400
[    0.916909] pci 0000:02:03.0: supports D1 D2
[    0.920491] pci 0000:02:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.927774] PCI: bus2: Fast back to back transfers disabled
[    0.932681] pci 0000:02:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    0.940737] pci 0000:02:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    0.948737] pci 0000:02:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    0.957113] pci 0000:03:00.0: [8086:1533] type 00 class 0x020000
[    0.962785] pci 0000:03:00.0: reg 0x10: [mem 0x00000000-0x0007ffff]
[    0.969062] pci 0000:03:00.0: reg 0x18: [io  0x0000-0x001f]
[    0.974565] pci 0000:03:00.0: reg 0x1c: [mem 0x00000000-0x00003fff]
[    0.981383] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    0.987402] PCI: bus3: Fast back to back transfers disabled
[    0.992446] pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
[    0.999085] pci_bus 0000:03: [bus 03] partially hidden behind bridge 0000:01 [bus 01]
[    1.007287] pci 0000:04:00.0: [8086:1533] type 00 class 0x020000
[    1.012979] pci 0000:04:00.0: reg 0x10: [mem 0x00000000-0x0007ffff]
[    1.019261] pci 0000:04:00.0: reg 0x18: [io  0x0000-0x001f]
[    1.024764] pci 0000:04:00.0: reg 0x1c: [mem 0x00000000-0x00003fff]
[    1.031574] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
[    1.037601] PCI: bus4: Fast back to back transfers disabled
[    1.042643] pci_bus 0000:04: busn_res: [bus 04-ff] end is updated to 04
[    1.049285] pci_bus 0000:04: [bus 04] partially hidden behind bridge 0000:01 [bus 01]
[    1.057388] PCI: bus5: Fast back to back transfers enabled
[    1.062567] pci_bus 0000:05: busn_res: [bus 05-ff] end is updated to 05
[    1.069206] pci_bus 0000:05: [bus 05] partially hidden behind bridge 0000:01 [bus 01]
[    1.077032] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 05
[    1.083621] pci_bus 0000:02: busn_res: can not insert [bus 02-05] under [bus 01] (conflicts with (null) [bus 01])
[    1.093910] pci_bus 0000:02: [bus 02-05] partially hidden behind bridge 0000:01 [bus 01]
[    1.102000] pci 0000:00:00.0: bridge has subordinate 01 but max busn 05
[    1.109331] pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
[    1.115409] pci 0000:00:00.0: BAR 8: assigned [mem 0x01100000-0x014fffff]
[    1.122163] pci 0000:00:00.0: BAR 9: assigned [mem 0x01500000-0x016fffff pref]
[    1.129401] pci 0000:00:00.0: BAR 6: assigned [mem 0x01700000-0x0170ffff pref]
[    1.136618] pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x2fff]
[    1.142701] pci 0000:01:00.0: BAR 8: assigned [mem 0x01100000-0x013fffff]
[    1.149496] pci 0000:01:00.0: BAR 9: assigned [mem 0x01500000-0x016fffff 64bit pref]
[    1.157238] pci 0000:01:00.0: BAR 0: assigned [mem 0x01400000-0x01403fff]
[    1.164024] pci 0000:01:00.0: BAR 7: assigned [io  0x1000-0x2fff]
[    1.170118] pci 0000:02:01.0: BAR 8: assigned [mem 0x01100000-0x012fffff]
[    1.176898] pci 0000:02:01.0: BAR 9: assigned [mem 0x01500000-0x016fffff 64bit pref]
[    1.184626] pci 0000:02:02.0: BAR 8: assigned [mem 0x01300000-0x013fffff]
[    1.191426] pci 0000:02:01.0: BAR 7: assigned [io  0x1000-0x1fff]
[    1.197515] pci 0000:02:02.0: BAR 7: assigned [io  0x2000-0x2fff]
[    1.203596] pci 0000:03:00.0: BAR 0: assigned [mem 0x01100000-0x0117ffff]
[    1.210415] pci 0000:03:00.0: BAR 3: assigned [mem 0x01180000-0x01183fff]
[    1.217198] pci 0000:03:00.0: BAR 2: assigned [io  0x1000-0x101f]
[    1.223272] pci 0000:02:01.0: PCI bridge to [bus 03]
[    1.228237] pci 0000:02:01.0:   bridge window [io  0x1000-0x1fff]
[    1.234326] pci 0000:02:01.0:   bridge window [mem 0x01100000-0x012fffff]
[    1.241119] pci 0000:02:01.0:   bridge window [mem 0x01500000-0x016fffff 64bit pref]
[    1.248887] pci 0000:04:00.0: BAR 0: assigned [mem 0x01300000-0x0137ffff]
[    1.255653] pci 0000:04:00.0: BAR 3: assigned [mem 0x01380000-0x01383fff]
[    1.262422] pci 0000:04:00.0: BAR 2: assigned [io  0x2000-0x201f]
[    1.268528] pci 0000:02:02.0: PCI bridge to [bus 04]
[    1.273459] pci 0000:02:02.0:   bridge window [io  0x2000-0x2fff]
[    1.279581] pci 0000:02:02.0:   bridge window [mem 0x01300000-0x013fffff]
[    1.286388] pci 0000:02:03.0: PCI bridge to [bus 05]
[    1.291356] pci 0000:01:00.0: PCI bridge to [bus 02-05]
[    1.296528] pci 0000:01:00.0:   bridge window [io  0x1000-0x2fff]
[    1.302619] pci 0000:01:00.0:   bridge window [mem 0x01100000-0x013fffff]
[    1.309413] pci 0000:01:00.0:   bridge window [mem 0x01500000-0x016fffff 64bit pref]
[    1.317170] pci 0000:00:00.0: PCI bridge to [bus 01]
[    1.322085] pci 0000:00:00.0:   bridge window [io  0x1000-0x2fff]
[    1.328190] pci 0000:00:00.0:   bridge window [mem 0x01100000-0x014fffff]
[    1.334962] pci 0000:00:00.0:   bridge window [mem 0x01500000-0x016fffff pref]
[    1.342527] pcieport 0000:00:00.0: AER enabled with IRQ 301
[    1.347920] pcieport 0000:01:00.0: enabling device (0140 -> 0143)
[    1.354637] pcieport 0000:02:01.0: enabling device (0140 -> 0143)
[    1.360799] pcieport 0000:02:02.0: enabling device (0140 -> 0143)
...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
