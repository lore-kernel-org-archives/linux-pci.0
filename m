Return-Path: <rjones@gateworks.com>
Return-Path: <rjones@gateworks.com>
MIME-Version: 1.0
In-Reply-To: <20160919194122.GA21763@localhost>
References: <CALAE=UDqxjh1qt5OJexyonynj+uEyhiwdAtUF0_dD5ffRkUo=Q@mail.gmail.com>
 <20160919194122.GA21763@localhost>
From: Robert Jones <rjones@gateworks.com>
Date: Mon, 19 Sep 2016 13:59:37 -0700
Message-ID: <CALAE=UDjBSMJJZMiJsadfd242jHSfqt7UXYFbsXGC_bHsZ5tOg@mail.gmail.com>
Subject: Re: PCI Resource Allocation
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <Richard.Zhu@freescale.com>, Lucas Stach <l.stach@pengutronix.de>,
	Yinghai Lu <yinghai@kernel.org>, Tim Harvey <tharvey@gateworks.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 19, 2016 at 12:41 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> Hi Robert,
>
> On Mon, Sep 19, 2016 at 11:15:39AM -0700, Robert Jones wrote:
>> Greetings,
>>
>> I'm looking into a PCI resource limitation issue on an IMX6 based
>> board and I find that in the 3.14 kernel I am able to use 6 Ath10k
>> devices with the following resources:
>>
>> 03:00.0 Network controller: Qualcomm Atheros QCA986x/988x 802.11ac
>> Wireless Network Adapter
>>         Flags: fast devsel, IRQ 155
>>         Memory at 01200000 (64-bit, non-prefetchable) [disabled] [size=
=3D2M]
>>         [virtual] Expansion ROM at 01100000 [disabled] [size=3D64K]
>>         Capabilities: [40] Power Management version 2
>>         Capabilities: [50] MSI: Enable- Count=3D1/8 Maskable+ 64bit-
>>         Capabilities: [70] Express Endpoint, MSI 00
>>         Capabilities: [100] Advanced Error Reporting
>>         Capabilities: [140] Virtual Channel
>>         Capabilities: [160] Device Serial Number 00-00-00-00-00-00-00-00
>>
>> In the 3.15 kernel following commit
>> (5b28541552ef5eeffc41d6936105f38c2508e566), allocation has changed in
>> such a way that results in none of the 6 radios nor the pci based
>> ethernet interface being mapped.
>> I am very new to PCI but after fiddling with some of the changes in
>> the aforementioned commit I was able to come up with a 1 line patch
>> that allows all 6 radios to once again become mapped and usable on the
>> IMX6. The patch contents being:
>>
>> --- a/drivers/pci/setup-bus.c
>> +++ b/drivers/pci/setup-bus.c
>> @@ -807,6 +807,7 @@ static struct resource
>> *find_free_bus_resource(struct pci_bus *bus,
>>  {
>>         int i;
>>         struct resource *r;
>> +       type_mask =3D IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_PREFET=
CH;
>>
>>         pci_bus_for_each_resource(bus, r, i) {
>>                 if (r =3D=3D &ioport_resource || r =3D=3D &iomem_resourc=
e)
>>
>>
>> I understand that this blatantly ignores the type mask parameter and
>> would greatly appreciate any insight that you can provide as far as
>> the proper way to proceed.
>>
>> Note that the IMX6 has a limited memory window (16M) between the PCI
>> core and the memory controller. This is mapped as:
>>
>> 512KB config space
>> 64KB io space
>> 15MB mem space available for devices
>
> Can you test this with a current kernel?  v3.15 is over two years old,
> and there have been several fixes related to 5b28541552ef.

Hello Bjorn, thank you for the quick response.
I suppose I should have previously mentioned that I had also tested
this on a v4.4 kernel,
but I went ahead and tested on the v4.7-rc7 branch and experienced the
same behavior.

> If a current kernel, e.g., v4.7, still fails, can you post the
> complete dmesg log and contents of /proc/iomem?

dmesg log:

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.7.0-rc7 (rjones@rjones) (gcc version
4.8.3 (OpenWrt/Linaro GCC 4.8-2014.04 r42297) ) #52 SMP Mon Sep 19
13:16:27 PDT 2016
[    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=3D10=
c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] Machine model: Gateworks Ventana i.MX6 Dual/Quad GW54XX
[    0.000000] cma: Reserved 16 MiB at 0x4f000000
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] On node 0 totalpages: 262144
[    0.000000] free_area_init_node: node 0, pgdat c0e6bbc0,
node_mem_map ef7f8000
[    0.000000]   Normal zone: 1536 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 196608 pages, LIFO batch:31
[    0.000000]   HighMem zone: 65536 pages, LIFO batch:15
[    0.000000] percpu: Embedded 13 pages/cpu @ef795000 s24448 r8192
d20608 u53248
[    0.000000] pcpu-alloc: s24448 r8192 d20608 u53248 alloc=3D13*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 260608
[    0.000000] Kernel command line: console=3Dttymxc1,115200
root=3D/dev/mmcblk0p1 rootfstype=3Dext4 rootwait rw  coherent_pool=3D4M
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 by=
tes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 byte=
s)
[    0.000000] Memory: 1000756K/1048576K available (9220K kernel code,
436K rwdata, 2864K rodata, 1024K init, 8225K bss, 31436K reserved,
16384K cma-reserved, 245760K highmem)
[    0.000000] Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
    vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
    lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
    modules : 0xbf000000 - 0xbfe00000   (  14 MB)
      .text : 0xc0008000 - 0xc0ccd08c   (13077 kB)
      .init : 0xc0d00000 - 0xc0e00000   (1024 kB)
      .data : 0xc0e00000 - 0xc0e6d3e0   ( 437 kB)
       .bss : 0xc0e6f000 - 0xc16775fc   (8226 kB)
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, N=
odes=3D1
[    0.000000] Running RCU self tests
[    0.000000] Hierarchical RCU implementation.
[    0.000000]   RCU lockdep checking is enabled.
[    0.000000]   Build-time adjustment of leaf fanout to 32.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] L2C-310 erratum 769419 enabled
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
[    0.000000] L2C-310 ID prefetch enabled, offset 1 lines
[    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
[    0.000000] L2C-310 cache controller enabled, 16 ways, 1024 kB
[    0.000000] L2C-310: CACHE_ID 0x410000c7, AUX_CTRL 0x76070001
[    0.000000] Switching to timer-based delay loop, resolution 333ns
[    0.000007] sched_clock: 32 bits at 3000kHz, resolution 333ns,
wraps every 715827882841ns
[    0.000028] clocksource: mxc_timer1: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 637086815595 ns
[    0.001371] Console: colour dummy device 80x30
[    0.001400] Lock dependency validator: Copyright (c) 2006 Red Hat,
Inc., Ingo Molnar
[    0.001410] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.001419] ... MAX_LOCK_DEPTH:          48
[    0.001428] ... MAX_LOCKDEP_KEYS:        8191
[    0.001436] ... CLASSHASH_SIZE:          4096
[    0.001444] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.001452] ... MAX_LOCKDEP_CHAINS:      65536
[    0.001459] ... CHAINHASH_SIZE:          32768
[    0.001468]  memory used by lock dependency info: 5167 kB
[    0.001477]  per task-struct memory footprint: 1536 bytes
[    0.001515] Calibrating delay loop (skipped), value calculated
using timer frequency.. 6.00 BogoMIPS (lpj=3D30000)
[    0.001536] pid_max: default: 32768 minimum: 301
[    0.001822] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.001840] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 by=
tes)
[    0.003560] CPU: Testing write buffer coherency: ok
[    0.004501] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.004571] Setting up static identity map for 0x10100000 - 0x10100070
[    0.009217] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.011024] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.012419] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.012627] Brought up 4 CPUs
[    0.012660] SMP: Total of 4 processors activated (24.00 BogoMIPS).
[    0.012672] CPU: All CPU(s) started in SVC mode.
[    0.014868] devtmpfs: initialized
[    0.043911] VFP support v0.3: implementor 41 architecture 3 part 30
variant 9 rev 4
[    0.044781] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.045961] pinctrl core: initialized pinctrl subsystem
[    0.049124] NET: Registered protocol family 16
[    0.063428] DMA: preallocated 4096 KiB pool for atomic coherent allocati=
ons
[    0.089695] cpuidle: using governor menu
[    0.089826] CPU identified as i.MX6Q, silicon rev 1.2
[    0.141272] No ATAGs?
[    0.141324] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1
watchpoint registers.
[    0.141339] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.143969] imx6q-pinctrl 20e0000.iomuxc: initialized IMX pinctrl driver
[    0.206952] mxs-dma 110000.dma-apbh: initialized
[    0.212586] vgaarb: loaded
[    0.213386] SCSI subsystem initialized
[    0.213799] libata version 3.00 loaded.
[    0.214506] usbcore: registered new interface driver usbfs
[    0.214660] usbcore: registered new interface driver hub
[    0.214896] usbcore: registered new device driver usb
[    0.219763] i2c i2c-0: IMX I2C adapter registered
[    0.219795] i2c i2c-0: can't use DMA, using PIO instead.
[    0.221852] i2c i2c-1: IMX I2C adapter registered
[    0.221884] i2c i2c-1: can't use DMA, using PIO instead.
[    0.223671] i2c i2c-2: IMX I2C adapter registered
[    0.223700] i2c i2c-2: can't use DMA, using PIO instead.
[    0.223947] Linux video capture interface: v2.00
[    0.224170] pps_core: LinuxPPS API ver. 1 registered
[    0.224183] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    0.224228] PTP clock support registered
[    0.225012] Advanced Linux Sound Architecture Driver Initialized.
[    0.228126] Bluetooth: Core ver 2.21
[    0.228212] NET: Registered protocol family 31
[    0.228224] Bluetooth: HCI device and connection manager initialized
[    0.228284] Bluetooth: HCI socket layer initialized
[    0.228312] Bluetooth: L2CAP socket layer initialized
[    0.228430] Bluetooth: SCO socket layer initialized
[    0.231150] clocksource: Switched to clocksource mxc_timer1
[    0.231705] VFS: Disk quotas dquot_6.6.0
[    0.231828] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 byt=
es)
[    0.259877] NET: Registered protocol family 2
[    0.261500] TCP established hash table entries: 8192 (order: 3, 32768 by=
tes)
[    0.261660] TCP bind hash table entries: 8192 (order: 6, 294912 bytes)
[    0.264230] TCP: Hash tables configured (established 8192 bind 8192)
[    0.264422] UDP hash table entries: 512 (order: 3, 40960 bytes)
[    0.264780] UDP-Lite hash table entries: 512 (order: 3, 40960 bytes)
[    0.265820] NET: Registered protocol family 1
[    0.266861] RPC: Registered named UNIX socket transport module.
[    0.266878] RPC: Registered udp transport module.
[    0.266891] RPC: Registered tcp transport module.
[    0.266902] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.266920] PCI: CLS 0 bytes, default 64
[    0.268677] hw perfevents: enabled with armv7_cortex_a9 PMU driver,
7 counters available
[    0.272083] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.274693] workingset: timestamp_bits=3D28 max_order=3D18 bucket_order=
=3D0
[    0.296757] NFS: Registering the id_resolver key type
[    0.296957] Key type id_resolver registered
[    0.296972] Key type id_legacy registered
[    0.297092] jffs2: version 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.
[    0.298786] fuse init (API version 7.25)
[    0.307331] bounce: pool size: 64 pages
[    0.307414] io scheduler noop registered
[    0.307429] io scheduler deadline registered
[    0.307515] io scheduler cfq registered (default)
[    0.308363] imx-weim 21b8000.weim: Driver registered.
[    0.312076] PCI host bridge /soc/pcie@0x01000000 ranges:
[    0.312098]   No bus range found for /soc/pcie@0x01000000, using [bus 00=
-ff]
[    0.312147]   err 0x01f00000..0x01f7ffff -> 0x01f00000
[    0.312186]    IO 0x01f80000..0x01f8ffff -> 0x00000000
[    0.312275]   MEM 0x01000000..0x01efffff -> 0x01000000
[    0.521249] imx6q-pcie 1ffc000.pcie: link up
[    0.521268] imx6q-pcie 1ffc000.pcie: Link: Gen2 disabled
[    0.521283] imx6q-pcie 1ffc000.pcie: link up
[    0.521296] imx6q-pcie 1ffc000.pcie: Link up, Gen1
[    0.521901] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
[    0.521927] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.521946] pci_bus 0000:00: root bus resource [???
0x01f00000-0x01f7ffff flags 0x0]
[    0.521962] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.521978] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01effff=
f]
[    0.522119] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
[    0.522168] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
[    0.522207] pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
[    0.522401] pci 0000:00:00.0: supports D1
[    0.522418] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
[    0.523270] PCI: bus0: Fast back to back transfers disabled
[    0.523711] pci 0000:01:00.0: [10b5:8609] type 01 class 0x060400
[    0.631247] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x0001ffff]
[    0.631952] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    0.632764] pci 0000:01:00.1: [10b5:8609] type 00 class 0x088000
[    0.632875] pci 0000:01:00.1: reg 0x10: [mem 0x00000000-0x0001ffff]
[    0.651322] PCI: bus1: Fast back to back transfers disabled
[    0.651352] pci 0000:01:00.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    0.651894] pci_bus 0000:02: busn_res: can not insert [bus 02-ff]
under [bus 01] (conflicts with (null) [bus 01])
[    0.652033] pci 0000:02:01.0: [10b5:8609] type 01 class 0x060400
[    0.652799] pci 0000:02:01.0: PME# supported from D0 D3hot D3cold
[    0.653627] pci 0000:02:04.0: [10b5:8609] type 01 class 0x060400
[    0.654396] pci 0000:02:04.0: PME# supported from D0 D3hot D3cold
[    0.655221] pci 0000:02:05.0: [10b5:8609] type 01 class 0x060400
[    0.655990] pci 0000:02:05.0: PME# supported from D0 D3hot D3cold
[    0.656809] pci 0000:02:06.0: [10b5:8609] type 01 class 0x060400
[    0.657570] pci 0000:02:06.0: PME# supported from D0 D3hot D3cold
[    0.658400] pci 0000:02:07.0: [10b5:8609] type 01 class 0x060400
[    0.659162] pci 0000:02:07.0: PME# supported from D0 D3hot D3cold
[    0.660004] pci 0000:02:08.0: [10b5:8609] type 01 class 0x060400
[    0.660772] pci 0000:02:08.0: PME# supported from D0 D3hot D3cold
[    0.661686] pci 0000:02:09.0: [10b5:8609] type 01 class 0x060400
[    0.662453] pci 0000:02:09.0: PME# supported from D0 D3hot D3cold
[    0.663765] PCI: bus2: Fast back to back transfers disabled
[    0.663793] pci 0000:02:01.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    0.663852] pci 0000:02:04.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    0.663908] pci 0000:02:05.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    0.663965] pci 0000:02:06.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    0.664021] pci 0000:02:07.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    0.664077] pci 0000:02:08.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    0.664133] pci 0000:02:09.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    0.664778] pci 0000:03:00.0: [168c:003c] type 00 class 0x028000
[    0.664929] pci 0000:03:00.0: reg 0x10: [mem 0x00000000-0x001fffff 64bit=
]
[    0.665169] pci 0000:03:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    0.665634] pci 0000:03:00.0: supports D1 D2
[    0.666391] PCI: bus3: Fast back to back transfers disabled
[    0.666415] pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
[    0.666444] pci_bus 0000:03: [bus 03] partially hidden behind
bridge 0000:01 [bus 01]
[    0.667069] pci 0000:04:00.0: [168c:003c] type 00 class 0x028000
[    0.667217] pci 0000:04:00.0: reg 0x10: [mem 0x00000000-0x001fffff 64bit=
]
[    0.667457] pci 0000:04:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    0.667920] pci 0000:04:00.0: supports D1 D2
[    0.668674] PCI: bus4: Fast back to back transfers disabled
[    0.668696] pci_bus 0000:04: busn_res: [bus 04-ff] end is updated to 04
[    0.668723] pci_bus 0000:04: [bus 04] partially hidden behind
bridge 0000:01 [bus 01]
[    0.669341] pci 0000:05:00.0: [168c:003c] type 00 class 0x028000
[    0.669488] pci 0000:05:00.0: reg 0x10: [mem 0x00000000-0x001fffff 64bit=
]
[    0.669727] pci 0000:05:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    0.670193] pci 0000:05:00.0: supports D1 D2
[    0.670951] PCI: bus5: Fast back to back transfers disabled
[    0.670972] pci_bus 0000:05: busn_res: [bus 05-ff] end is updated to 05
[    0.670998] pci_bus 0000:05: [bus 05] partially hidden behind
bridge 0000:01 [bus 01]
[    0.671674] pci 0000:06:00.0: [168c:003c] type 00 class 0x028000
[    0.671822] pci 0000:06:00.0: reg 0x10: [mem 0x00000000-0x001fffff 64bit=
]
[    0.672062] pci 0000:06:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    0.672526] pci 0000:06:00.0: supports D1 D2
[    0.673296] PCI: bus6: Fast back to back transfers disabled
[    0.673318] pci_bus 0000:06: busn_res: [bus 06-ff] end is updated to 06
[    0.673346] pci_bus 0000:06: [bus 06] partially hidden behind
bridge 0000:01 [bus 01]
[    0.673954] pci 0000:07:00.0: [168c:003c] type 00 class 0x028000
[    0.674101] pci 0000:07:00.0: reg 0x10: [mem 0x00000000-0x001fffff 64bit=
]
[    0.674341] pci 0000:07:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    0.674804] pci 0000:07:00.0: supports D1 D2
[    0.675572] PCI: bus7: Fast back to back transfers disabled
[    0.675594] pci_bus 0000:07: busn_res: [bus 07-ff] end is updated to 07
[    0.675621] pci_bus 0000:07: [bus 07] partially hidden behind
bridge 0000:01 [bus 01]
[    0.676239] pci 0000:08:00.0: [11ab:4380] type 00 class 0x020000
[    0.676387] pci 0000:08:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit=
]
[    0.676450] pci 0000:08:00.0: reg 0x18: [io  0x0000-0x00ff]
[    0.677040] pci 0000:08:00.0: supports D1 D2
[    0.677056] pci 0000:08:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.677960] PCI: bus8: Fast back to back transfers disabled
[    0.677981] pci_bus 0000:08: busn_res: [bus 08-ff] end is updated to 08
[    0.678009] pci_bus 0000:08: [bus 08] partially hidden behind
bridge 0000:01 [bus 01]
[    0.678630] pci 0000:09:00.0: [168c:003c] type 00 class 0x028000
[    0.678779] pci 0000:09:00.0: reg 0x10: [mem 0x00000000-0x001fffff 64bit=
]
[    0.679018] pci 0000:09:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    0.679483] pci 0000:09:00.0: supports D1 D2
[    0.680255] PCI: bus9: Fast back to back transfers disabled
[    0.680277] pci_bus 0000:09: busn_res: [bus 09-ff] end is updated to 09
[    0.680305] pci_bus 0000:09: [bus 09] partially hidden behind
bridge 0000:01 [bus 01]
[    0.680332] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 09
[    0.680350] pci_bus 0000:02: busn_res: can not insert [bus 02-09]
under [bus 01] (conflicts with (null) [bus 01])
[    0.680377] pci_bus 0000:02: [bus 02-09] partially hidden behind
bridge 0000:01 [bus 01]
[    0.680402] pci 0000:00:00.0: bridge has subordinate 01 but max busn 09
[    0.682168] pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff=
]
[    0.682199] pci 0000:00:00.0: BAR 8: no space for [mem size 0x01400000]
[    0.682217] pci 0000:00:00.0: BAR 8: failed to assign [mem size 0x014000=
00]
[    0.682237] pci 0000:00:00.0: BAR 6: assigned [mem
0x01100000-0x0110ffff pref]
[    0.682257] pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]
[    0.682281] pci 0000:01:00.0: BAR 8: no space for [mem size 0x01300000]
[    0.682296] pci 0000:01:00.0: BAR 8: failed to assign [mem size 0x013000=
00]
[    0.682310] pci 0000:01:00.0: BAR 0: no space for [mem size 0x00020000]
[    0.682324] pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x000200=
00]
[    0.682339] pci 0000:01:00.1: BAR 0: no space for [mem size 0x00020000]
[    0.682352] pci 0000:01:00.1: BAR 0: failed to assign [mem size 0x000200=
00]
[    0.682369] pci 0000:01:00.0: BAR 7: assigned [io  0x1000-0x1fff]
[    0.682396] pci 0000:02:01.0: BAR 8: no space for [mem size 0x00300000]
[    0.682411] pci 0000:02:01.0: BAR 8: failed to assign [mem size 0x003000=
00]
[    0.682425] pci 0000:02:04.0: BAR 8: no space for [mem size 0x00300000]
[    0.682438] pci 0000:02:04.0: BAR 8: failed to assign [mem size 0x003000=
00]
[    0.682452] pci 0000:02:05.0: BAR 8: no space for [mem size 0x00300000]
[    0.682466] pci 0000:02:05.0: BAR 8: failed to assign [mem size 0x003000=
00]
[    0.682481] pci 0000:02:06.0: BAR 8: no space for [mem size 0x00300000]
[    0.682494] pci 0000:02:06.0: BAR 8: failed to assign [mem size 0x003000=
00]
[    0.682509] pci 0000:02:07.0: BAR 8: no space for [mem size 0x00300000]
[    0.682522] pci 0000:02:07.0: BAR 8: failed to assign [mem size 0x003000=
00]
[    0.682535] pci 0000:02:08.0: BAR 8: no space for [mem size 0x00100000]
[    0.682548] pci 0000:02:08.0: BAR 8: failed to assign [mem size 0x001000=
00]
[    0.682563] pci 0000:02:09.0: BAR 8: no space for [mem size 0x00300000]
[    0.682577] pci 0000:02:09.0: BAR 8: failed to assign [mem size 0x003000=
00]
[    0.682593] pci 0000:02:08.0: BAR 7: assigned [io  0x1000-0x1fff]
[    0.682616] pci 0000:03:00.0: BAR 0: no space for [mem size 0x00200000 6=
4bit]
[    0.682631] pci 0000:03:00.0: BAR 0: failed to assign [mem size
0x00200000 64bit]
[    0.682645] pci 0000:03:00.0: BAR 6: no space for [mem size 0x00010000 p=
ref]
[    0.682659] pci 0000:03:00.0: BAR 6: failed to assign [mem size
0x00010000 pref]
[    0.682675] pci 0000:02:01.0: PCI bridge to [bus 03]
[    0.682773] pci 0000:04:00.0: BAR 0: no space for [mem size 0x00200000 6=
4bit]
[    0.682788] pci 0000:04:00.0: BAR 0: failed to assign [mem size
0x00200000 64bit]
[    0.682802] pci 0000:04:00.0: BAR 6: no space for [mem size 0x00010000 p=
ref]
[    0.682817] pci 0000:04:00.0: BAR 6: failed to assign [mem size
0x00010000 pref]
[    0.682832] pci 0000:02:04.0: PCI bridge to [bus 04]
[    0.682926] pci 0000:05:00.0: BAR 0: no space for [mem size 0x00200000 6=
4bit]
[    0.682941] pci 0000:05:00.0: BAR 0: failed to assign [mem size
0x00200000 64bit]
[    0.682956] pci 0000:05:00.0: BAR 6: no space for [mem size 0x00010000 p=
ref]
[    0.682968] pci 0000:05:00.0: BAR 6: failed to assign [mem size
0x00010000 pref]
[    0.682982] pci 0000:02:05.0: PCI bridge to [bus 05]
[    0.683076] pci 0000:06:00.0: BAR 0: no space for [mem size 0x00200000 6=
4bit]
[    0.683091] pci 0000:06:00.0: BAR 0: failed to assign [mem size
0x00200000 64bit]
[    0.683106] pci 0000:06:00.0: BAR 6: no space for [mem size 0x00010000 p=
ref]
[    0.683120] pci 0000:06:00.0: BAR 6: failed to assign [mem size
0x00010000 pref]
[    0.683134] pci 0000:02:06.0: PCI bridge to [bus 06]
[    0.683228] pci 0000:07:00.0: BAR 0: no space for [mem size 0x00200000 6=
4bit]
[    0.683243] pci 0000:07:00.0: BAR 0: failed to assign [mem size
0x00200000 64bit]
[    0.683257] pci 0000:07:00.0: BAR 6: no space for [mem size 0x00010000 p=
ref]
[    0.683270] pci 0000:07:00.0: BAR 6: failed to assign [mem size
0x00010000 pref]
[    0.683285] pci 0000:02:07.0: PCI bridge to [bus 07]
[    0.683379] pci 0000:08:00.0: BAR 0: no space for [mem size 0x00004000 6=
4bit]
[    0.683394] pci 0000:08:00.0: BAR 0: failed to assign [mem size
0x00004000 64bit]
[    0.683413] pci 0000:08:00.0: BAR 2: assigned [io  0x1000-0x10ff]
[    0.683449] pci 0000:02:08.0: PCI bridge to [bus 08]
[    0.683473] pci 0000:02:08.0:   bridge window [io  0x1000-0x1fff]
[    0.683568] pci 0000:09:00.0: BAR 0: no space for [mem size 0x00200000 6=
4bit]
[    0.683583] pci 0000:09:00.0: BAR 0: failed to assign [mem size
0x00200000 64bit]
[    0.683597] pci 0000:09:00.0: BAR 6: no space for [mem size 0x00010000 p=
ref]
[    0.683611] pci 0000:09:00.0: BAR 6: failed to assign [mem size
0x00010000 pref]
[    0.683625] pci 0000:02:09.0: PCI bridge to [bus 09]
[    0.683715] pci 0000:01:00.0: PCI bridge to [bus 02-09]
[    0.683739] pci 0000:01:00.0:   bridge window [io  0x1000-0x1fff]
[    0.683829] pci 0000:00:00.0: PCI bridge to [bus 01]
[    0.683846] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
[    0.684621] pcieport 0000:00:00.0: Signaling PME through PCIe PME interr=
upt
[    0.684642] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
[    0.684656] pci 0000:02:01.0: Signaling PME through PCIe PME interrupt
[    0.684669] pci 0000:03:00.0: Signaling PME through PCIe PME interrupt
[    0.684682] pci 0000:02:04.0: Signaling PME through PCIe PME interrupt
[    0.684695] pci 0000:04:00.0: Signaling PME through PCIe PME interrupt
[    0.684708] pci 0000:02:05.0: Signaling PME through PCIe PME interrupt
[    0.684720] pci 0000:05:00.0: Signaling PME through PCIe PME interrupt
[    0.684732] pci 0000:02:06.0: Signaling PME through PCIe PME interrupt
[    0.684742] pci 0000:06:00.0: Signaling PME through PCIe PME interrupt
[    0.684754] pci 0000:02:07.0: Signaling PME through PCIe PME interrupt
[    0.684766] pci 0000:07:00.0: Signaling PME through PCIe PME interrupt
[    0.684778] pci 0000:02:08.0: Signaling PME through PCIe PME interrupt
[    0.684791] pci 0000:08:00.0: Signaling PME through PCIe PME interrupt
[    0.684804] pci 0000:02:09.0: Signaling PME through PCIe PME interrupt
[    0.684816] pci 0000:09:00.0: Signaling PME through PCIe PME interrupt
[    0.684829] pci 0000:01:00.1: Signaling PME through PCIe PME interrupt
[    0.684849] pcie_pme 0000:00:00.0:pcie001: service driver pcie_pme loade=
d
[    0.685560] aer 0000:00:00.0:pcie002: service driver aer loaded
[    0.686013] pcieport 0000:01:00.0: enabling device (0140 -> 0141)
[    0.693772] pcieport 0000:02:08.0: enabling device (0140 -> 0141)
[    0.698203] backlight supply power not found, using dummy regulator
[    0.705039] imx-sdma 20ec000.sdma: Direct firmware load for
imx/sdma/sdma-imx6q.bin failed with error -2
[    0.705068] imx-sdma 20ec000.sdma: external firmware not found,
using ROM firmware
[    0.715584] pfuze100-regulator 1-0008: Full layer: 1, Metal layer: 1
[    0.716416] pfuze100-regulator 1-0008: FAB: 0, FIN: 0
[    0.716435] pfuze100-regulator 1-0008: pfuze100 found.
[    0.745179] 2020000.serial: ttymxc0 at MMIO 0x2020000 (irq =3D 24,
base_baud =3D 5000000) is a IMX
[    0.747253] 21e8000.serial: ttymxc1 at MMIO 0x21e8000 (irq =3D 294,
base_baud =3D 5000000) is a IMX
[    2.363063] console [ttymxc1] enabled
[    2.368303] 21f4000.serial: ttymxc4 at MMIO 0x21f4000 (irq =3D 295,
base_baud =3D 5000000) is a IMX
[    2.379170] [drm] Initialized drm 1.1.0 20060810
[    2.391032] imx-ipuv3 2400000.ipu: IPUv3H probed
[    2.400749] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    2.407419] [drm] No driver support for vblank timestamp query.
[    2.414407] imx-drm display-subsystem: bound imx-ipuv3-crtc.2 (ops
ipu_crtc_ops)
[    2.422320] imx-drm display-subsystem: bound imx-ipuv3-crtc.3 (ops
ipu_crtc_ops)
[    2.430170] imx-drm display-subsystem: bound imx-ipuv3-crtc.6 (ops
ipu_crtc_ops)
[    2.438060] imx-drm display-subsystem: bound imx-ipuv3-crtc.7 (ops
ipu_crtc_ops)
[    2.446011] dwhdmi-imx 120000.hdmi: Detected HDMI controller
0x13:0xa:0xa0:0xc1
[    2.454946] imx-drm display-subsystem: bound 120000.hdmi (ops
dw_hdmi_imx_ops)
[    2.462959] imx-drm display-subsystem: bound
2000000.aips-bus:ldb@020e0008 (ops imx_ldb_ops)
[    2.488240] Console: switching to colour frame buffer device 128x48
[    2.499931] imx-drm display-subsystem: fb0:  frame buffer device
[    2.531166] [drm] Initialized imx-drm 1.0.0 20120507 on minor 0
[    2.537134] imx-ipuv3 2800000.ipu: IPUv3H probed
[    2.569296] brd: module loaded
[    2.590221] loop: module loaded
[    2.594172] at24 0-0050: 256 byte 24c02 EEPROM, writable, 16 bytes/write
[    2.601407] at24 0-0051: 256 byte 24c02 EEPROM, writable, 16 bytes/write
[    2.608602] at24 0-0052: 256 byte 24c02 EEPROM, writable, 16 bytes/write
[    2.615815] at24 0-0053: 256 byte 24c02 EEPROM, writable, 16 bytes/write
[    2.624255] ahci-imx 2200000.sata: fsl,transmit-level-mV not
specified, using 00000024
[    2.632221] ahci-imx 2200000.sata: fsl,transmit-boost-mdB not
specified, using 00000480
[    2.640240] ahci-imx 2200000.sata: fsl,transmit-atten-16ths not
specified, using 00002000
[    2.648455] ahci-imx 2200000.sata: fsl,receive-eq-mdB not
specified, using 05000000
[    2.659358] ahci-imx 2200000.sata: SSS flag set, parallel bus scan disab=
led
[    2.666392] ahci-imx 2200000.sata: AHCI 0001.0300 32 slots 1 ports
3 Gbps 0x1 impl platform mode
[    2.675234] ahci-imx 2200000.sata: flags: ncq sntf stag pm led clo
only pmp pio slum part ccc apst
[    2.687701] scsi host0: ahci-imx
[    2.692150] ata1: SATA max UDMA/133 mmio [mem
0x02200000-0x02203fff] port 0x100 irq 298
[    2.714621] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xda
[    2.720989] nand: Micron MT29F2G08ABAEAH4
[    2.725035] nand: 256 MiB, SLC, erase size: 128 KiB, page size:
2048, OOB size: 64
[    2.733478] gpmi-nand 112000.gpmi-nand: enable the asynchronous EDO mode=
 5
[    2.740372] Scanning device for bad blocks
[    3.023241] ata1: SATA link down (SStatus 0 SControl 300)
[    3.028697] ahci-imx 2200000.sata: no device found, disabling link.
[    3.035015] ahci-imx 2200000.sata: pass ahci_imx..hotplug=3D1 to enable =
hotplug
[    3.094180] 3 ofpart partitions found on MTD device gpmi-nand
[    3.099939] Creating 3 MTD partitions on "gpmi-nand":
[    3.105050] 0x000000000000-0x000001000000 : "uboot"
[    3.122452] 0x000001000000-0x000001100000 : "env"
[    3.130569] 0x000001100000-0x000010000000 : "rootfs"
[    3.262868] gpmi-nand 112000.gpmi-nand: driver registered.
[    3.271639] CAN device driver interface
[    3.275970] 2090000.flexcan supply xceiver not found, using dummy regula=
tor
[    3.285067] flexcan 2090000.flexcan: device registered
(reg_base=3Df10e0000, irq=3D31)
[    3.294482] 2188000.ethernet supply phy not found, using dummy regulator
[    3.322596] pps pps0: new PPS source ptp0
[    3.334243] libphy: fec_enet_mii_bus: probed
[    3.339864] fec 2188000.ethernet eth0: registered PHC device 0
[    3.347025] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    3.353602] ehci-pci: EHCI PCI platform driver
[    3.358232] ehci-mxc: Freescale On-Chip EHCI Host driver
[    3.364355] usbcore: registered new interface driver usb-storage
[    3.387046] ci_hdrc ci_hdrc.1: EHCI Host Controller
[    3.392174] ci_hdrc ci_hdrc.1: new USB bus registered, assigned bus numb=
er 1
[    3.411188] ci_hdrc ci_hdrc.1: USB 2.0 started, EHCI 1.00
[    3.420061] hub 1-0:1.0: USB hub found
[    3.424055] hub 1-0:1.0: 1 port detected
[    3.432024] mousedev: PS/2 mouse device common for all mice
[    3.439774] egalax_ts 2-0004: Failed to read firmware version
[    3.450228] snvs_rtc 20cc000.snvs:snvs-rtc-lp: rtc core: registered
20cc000.snvs:snvs-r as rtc0
[    3.459209] i2c /dev entries driver
[    3.465238] IR NEC protocol handler initialized
[    3.469784] IR RC5(x/sz) protocol handler initialized
[    3.474939] IR RC6 protocol handler initialized
[    3.479482] IR JVC protocol handler initialized
[    3.484050] IR Sony protocol handler initialized
[    3.488679] IR SANYO protocol handler initialized
[    3.493412] IR Sharp protocol handler initialized
[    3.498127] IR MCE Keyboard/mouse protocol handler initialized
[    3.503991] IR XMP protocol handler initialized
[    3.511746] coda 2040000.vpu: Direct firmware load for
vpu_fw_imx6q.bin failed with error -2
[    3.520520] coda 2040000.vpu: Direct firmware load for
v4l-coda960-imx6q.bin failed with error -2
[    3.529452] coda 2040000.vpu: firmware request failed
[    3.533305] watchdog: Invalid min and max timeout values, resetting to 0=
!
[    3.535177] imx2-wdt 20c0000.wdog: timeout 60 sec (nowayout=3D0)
[    3.535442] Bluetooth: HCI UART driver ver 2.3
[    3.535452] Bluetooth: HCI UART protocol H4 registered
[    3.535457] Bluetooth: HCI UART protocol LL registered
[    3.536490] sdhci: Secure Digital Host Controller Interface driver
[    3.536493] sdhci: Copyright(c) Pierre Ossman
[    3.536497] sdhci-pltfm: SDHCI platform and OF driver helper
[    3.538837] sdhci-esdhc-imx 2198000.usdhc: Got CD GPIO
[    3.591503] mmc0: SDHCI controller on 2198000.usdhc [2198000.usdhc]
using ADMA
[    3.604053] caam 2100000.caam: Entropy delay =3D 3200
[    3.669726] caam 2100000.caam: Instantiated RNG4 SH0
[    3.730489] caam 2100000.caam: Instantiated RNG4 SH1
[    3.735629] caam 2100000.caam: device ID =3D 0x0a16010000000000 (Era 4)
[    3.742106] caam 2100000.caam: job rings =3D 2, qi =3D 0
[    3.764011] caam algorithms registered in /proc/crypto
[    3.774235] caam_jr 2101000.jr0: registering rng-caam
[    3.780522] usbcore: registered new interface driver usbhid
[    3.786143] usbhid: USB HID core driver
[    3.796288] sgtl5000 2-000a: sgtl5000 revision 0x11
[    3.800963] mmc0: host does not support reading read-only switch,
assuming write-enable
[    3.808935] mmc0: new high speed SDHC card at address aaaa
[    3.811191] usb 1-1: new high-speed USB device number 2 using ci_hdrc
[    3.811798] mmcblk0: mmc0:aaaa SS16G 14.8 GiB
[    3.815031]  mmcblk0: p1
[    3.866110] fsl-asoc-card sound: ASoC: CPU DAI (null) not registered
[    3.872534] fsl-asoc-card sound: snd_soc_register_card failed (-517)
[    3.879843] fsl-asrc 2034000.asrc: failed to get spba clock
[    3.886775] fsl-asrc 2034000.asrc: driver registered
[    3.892889] fsl-ssi-dai 2028000.ssi: No cache defaults, reading back fro=
m HW
[    3.901306] fsl-ssi-dai 202c000.ssi: No cache defaults, reading back fro=
m HW
[    3.913369] sgtl5000 2-000a: Using internal LDO instead of VDDD
[    3.940693] imx-sgtl5000 sound: sgtl5000 <-> 2028000.ssi mapping ok
[    3.956259] hub 1-1:1.0: USB hub found
[    3.957389] NET: Registered protocol family 10
[    3.960209] sit: IPv6 over IPv4 tunneling driver
[    3.962608] NET: Registered protocol family 17
[    3.962641] can: controller area network core (rev 20120528 abi 9)
[    3.962790] NET: Registered protocol family 29
[    3.962829] can: raw protocol (rev 20120528)
[    3.962909] can: broadcast manager protocol (rev 20120528 t)
[    3.962940] can: netlink gateway (rev 20130117) max_hops=3D1
[    3.963588] Key type dns_resolver registered
[    3.971024] Registering SWP/SWPB emulation handler
[    3.994928] imx_thermal 2000000.aips-bus:tempmon: Automotive CPU
temperature grade - max:125C critical:120C passive:115C
[    3.999845] snvs_rtc 20cc000.snvs:snvs-rtc-lp: setting system clock
to 1970-01-01 00:00:00 UTC (0)
[    4.029226] hub 1-1:1.0: 4 ports detected
[    4.031990] usb_otg_vbus: disabling
[    4.032036] VGEN1: disabling
[    4.039789] VGEN2: disabling
[    4.044066] ALSA device list:
[    4.047050]   #0: sgtl5000-audio
[    4.106534] EXT4-fs (mmcblk0p1): mounted filesystem with ordered
data mode. Opts: (null)
[    4.114788] VFS: Mounted root (ext4 filesystem) on device 179:1.
[    4.128737] devtmpfs: mounted
[    4.133573] Freeing unused kernel memory: 1024K (c0d00000 - c0e00000)
[    4.277541] init: Console is alive
[    4.281908] init: - watchdog -
[    5.287603] init: - preinit -
[    6.535997] random: procd urandom read with 119 bits of entropy availabl=
e
[    8.280527] random: nonblocking pool is initialized
[    8.613900] mount_root: mounting /dev/root
[    8.619613] EXT4-fs (mmcblk0p1): re-mounted. Opts: (null)
[    8.625798] mount_root: loading kmods from internal overlay
[    8.650458] mount_root: failed to launch kmodloader from internal overla=
y
[    8.690226] blk_update_request: I/O error, dev mtdblock0, sector 0
[    8.713668] blk_update_request: I/O error, dev mtdblock0, sector 0
[    8.719995] Buffer I/O error on dev mtdblock0, logical block 0,
async page read
[    8.813586] block: attempting to load /etc/config/fstab
[    8.820301] block: unable to load configuration (fstab: Entry not found)
[    8.827132] block: no usable configuration
[    8.840834] procd: - early -
[    8.843943] procd: - watchdog -
[    9.668279] procd: - ubus -
[   10.676040] procd: - init -

contents of /proc/iomem:

00110000-00111fff : /soc/dma-apbh@00110000
00112000-00113fff : gpmi-nand
00114000-00115fff : bch
00120000-00128fff : /soc/hdmi@0120000
00900000-0093ffff : 900000.sram
01ffc000-01ffffff : dbi
02020000-02023fff : /soc/aips-bus@02000000/spba-bus@02000000/serial@0202000=
0
02028000-0202bfff : /soc/aips-bus@02000000/spba-bus@02000000/ssi@02028000
0202c000-0202ffff : /soc/aips-bus@02000000/spba-bus@02000000/ssi@0202c000
02034000-02037fff : /soc/aips-bus@02000000/spba-bus@02000000/asrc@02034000
02040000-0207bfff : /soc/aips-bus@02000000/vpu@02040000
0208c000-0208ffff : /soc/aips-bus@02000000/pwm@0208c000
02090000-02093fff : /soc/aips-bus@02000000/flexcan@02090000
0209c000-0209ffff : /soc/aips-bus@02000000/gpio@0209c000
020a0000-020a3fff : /soc/aips-bus@02000000/gpio@020a0000
020a4000-020a7fff : /soc/aips-bus@02000000/gpio@020a4000
020a8000-020abfff : /soc/aips-bus@02000000/gpio@020a8000
020ac000-020affff : /soc/aips-bus@02000000/gpio@020ac000
020b0000-020b3fff : /soc/aips-bus@02000000/gpio@020b0000
020b4000-020b7fff : /soc/aips-bus@02000000/gpio@020b4000
020c0000-020c3fff : /soc/aips-bus@02000000/wdog@020c0000
020c9000-020c9fff : /soc/aips-bus@02000000/usbphy@020c9000
020ca000-020cafff : /soc/aips-bus@02000000/usbphy@020ca000
020e0000-020e3fff : /soc/aips-bus@02000000/iomuxc@020e0000
020ec000-020effff : /soc/aips-bus@02000000/sdma@020ec000
02184000-021841ff : /soc/aips-bus@02100000/usb@02184000
  02184000-021841ff : /soc/aips-bus@02100000/usb@02184000
02184200-021843ff : /soc/aips-bus@02100000/usb@02184200
  02184200-021843ff : /soc/aips-bus@02100000/usb@02184200
02184800-021849ff : /soc/aips-bus@02100000/usbmisc@02184800
02188000-0218bfff : /soc/aips-bus@02100000/ethernet@02188000
02198000-0219bfff : /soc/aips-bus@02100000/usdhc@02198000
021a0000-021a3fff : /soc/aips-bus@02100000/i2c@021a0000
021a4000-021a7fff : /soc/aips-bus@02100000/i2c@021a4000
021a8000-021abfff : /soc/aips-bus@02100000/i2c@021a8000
021b8000-021bbfff : /soc/aips-bus@02100000/weim@021b8000
021bc000-021bffff : /soc/aips-bus@02100000/ocotp@021bc000
021d8000-021dbfff : /soc/aips-bus@02100000/audmux@021d8000
021e8000-021ebfff : /soc/aips-bus@02100000/serial@021e8000
021f4000-021f7fff : /soc/aips-bus@02100000/serial@021f4000
02200000-02203fff : /soc/sata@02200000
10000000-4fffffff : System RAM
  10008000-10ccd08b : Kernel code
  10e00000-116775fb : Kernel data

On a side note, feel free to correct me on formatting issues in these email=
s
as I'm still learning the proper etiquette.
-Robert

> Bjorn
