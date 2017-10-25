Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34988 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932277AbdJYJV7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Oct 2017 05:21:59 -0400
Date: Wed, 25 Oct 2017 10:21:59 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Meelis Roos <mroos@ut.ee>
Cc: linux-alpha@vger.kernel.org,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: alpha boot hang - 4.14-rc* regression
Message-ID: <20171025092159.GA14222@red-moon>
References: <alpine.LRH.2.21.1710251043170.7098@math.ut.ee>
 <alpine.LRH.2.21.1710251109150.7098@math.ut.ee>
 <alpine.LRH.2.21.1710251129520.7098@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LRH.2.21.1710251129520.7098@math.ut.ee>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 25, 2017 at 11:43:22AM +0300, Meelis Roos wrote:
> (Added linux-pci to CC)
> 
> > > I run Gentoo Linux on my alphas, with latest git kernels for test. 
> > > 4.13.0 worked well on 3 alphas but 4.13.0-09217-g5969d1bb3082 hangs on 
> > > boot on all 3 of them. Tried bisecting on PC164, got into unrelated 
> > > stuff, so probably it does not trigger always. Retried bisecting on 
> > > DS10L. On the first try I got that the same keel where I first saw bad 
> > > was the culprit, another bisect led me to 
> > > 0e4c2eeb758a91e68b9eaf7a4bee9bd5ed97ff2b which looks more related.
> > > 
> > > This is how the crash looks on console:
> > > 
> > >  * Starting udev ...
> > > starting version 225
> > >  [ ok ]
> > >  * Generating a rule to create a /dev/root symlink ...
> > >  [ ok ]
> > >  * Populating /dev with existing devices through uevents ...
> > >  [ ok ]
> > > 
> > > halted CPU 0
> > > 
> > > halt code = 5
> > > HALT instruction executed
> > > PC = fffffc00009bf914
> > > boot failure
> > > >>>
> > > 
> > > What else can I do to debug this?
> > 
> > Booting with debug ignore_loglevel I get also this:
> [...]
> > So maybe it is related pcspkr loading, or the just loaded libata or 
> > floppy...
> 
> removing libata modules and rebooting fixes it - so it seems to be 
> loading of libata.

Can you please cherry-pick:

commit b1f9e5e355e9 ("ide: fix IRQ assignment for PCI bus order probing")

from mainline and let us know if that solves the issue ?

Thanks,
Lorenzo

> lspci -vvv from broken kernel with no libata loaded:
> 
> 00:07.0 ISA bridge: ULi Electronics Inc. M1533/M1535/M1543 PCI to ISA Bridge [Aladdin IV/V/V+] (rev c3)
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort+ <MAbort+ >SERR- <PERR- INTx-
>         Latency: 0
> 
> 00:09.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
>         Subsystem: Digital Equipment Corporation DE500B Fast Ethernet
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 255 (5000ns min, 10000ns max), Cache Line Size: 64 bytes
>         Interrupt: pin A routed to IRQ 29
>         Region 0: I/O ports at 8400 [size=128]
>         Region 1: Memory at 09091000 (32-bit, non-prefetchable) [size=1K]
>         Expansion ROM at 09000000 [disabled] [size=256K]
>         Kernel driver in use: tulip
> 
> 00:0b.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
>         Subsystem: Digital Equipment Corporation DE500B Fast Ethernet
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 255 (5000ns min, 10000ns max), Cache Line Size: 64 bytes
>         Interrupt: pin A routed to IRQ 30
>         Region 0: I/O ports at 8480 [size=128]
>         Region 1: Memory at 09092000 (32-bit, non-prefetchable) [size=1K]
>         Expansion ROM at 09040000 [disabled] [size=256K]
>         Kernel driver in use: tulip
> 
> 00:0d.0 IDE interface: ULi Electronics Inc. M5229 IDE (rev c1) (prog-if f0)
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 255 (500ns min, 1000ns max)
>         Interrupt: pin A routed to IRQ 238
>         Region 0: I/O ports at 01f0 [size=8]
>         Region 1: I/O ports at 03f4
>         Region 2: I/O ports at 0170 [size=8]
>         Region 3: I/O ports at 0374
>         Region 4: I/O ports at 8800 [size=16]
> 
> 00:11.0 SCSI storage controller: QLogic Corp. ISP1020 Fast-wide SCSI (rev 05)
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 248, Cache Line Size: 64 bytes
>         Interrupt: pin A routed to IRQ 47
>         Region 0: I/O ports at 8000 [size=256]
>         Region 1: Memory at 09090000 (32-bit, non-prefetchable) [size=4K]
>         Expansion ROM at 09080000 [disabled] [size=64K]
>         Kernel driver in use: qla1280
> 
> 
> /proc/interrupts from the same kernel:
>            CPU0       
>   1:          3    XT-PIC      i8042
>   2:          0    XT-PIC      cascade
>   4:        319    XT-PIC      ttyS0
>   6:          3    XT-PIC      floppy
>   8:     688138     dummy    -RTC       timer
>  12:          5    XT-PIC      i8042
>  29:        975     DP264      enp0s9
>  47:      18229     DP264      qla1280
> PMI:          0           Performance Monitoring
> ERR:          0
> 
> lspci -vvvv from working 4.13.0:
> 
> 00:07.0 ISA bridge: ULi Electronics Inc. M1533/M1535/M1543 PCI to ISA Bridge [Aladdin IV/V/V+] (rev c3)
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort+ <MAbort+ >SERR- <PERR- INTx-
>         Latency: 0
> 
> 00:09.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
>         Subsystem: Digital Equipment Corporation DE500B Fast Ethernet
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 255 (5000ns min, 10000ns max), Cache Line Size: 64 bytes
>         Interrupt: pin A routed to IRQ 29
>         Region 0: I/O ports at 8400 [size=128]
>         Region 1: Memory at 09091000 (32-bit, non-prefetchable) [size=1K]
>         Expansion ROM at 09000000 [disabled] [size=256K]
>         Kernel driver in use: tulip
> 
> 00:0b.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
>         Subsystem: Digital Equipment Corporation DE500B Fast Ethernet
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 255 (5000ns min, 10000ns max), Cache Line Size: 64 bytes
>         Interrupt: pin A routed to IRQ 30
>         Region 0: I/O ports at 8480 [size=128]
>         Region 1: Memory at 09092000 (32-bit, non-prefetchable) [size=1K]
>         Expansion ROM at 09040000 [disabled] [size=256K]
>         Kernel driver in use: tulip
> 
> 00:0d.0 IDE interface: ULi Electronics Inc. M5229 IDE (rev c1) (prog-if f0)
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 255 (500ns min, 1000ns max)
>         Interrupt: pin A routed to IRQ 14
>         Region 0: I/O ports at 01f0 [size=8]
>         Region 1: I/O ports at 03f4
>         Region 2: I/O ports at 0170 [size=8]
>         Region 3: I/O ports at 0374
>         Region 4: I/O ports at 8800 [size=16]
>         Kernel driver in use: pata_ali
>         Kernel modules: pata_ali, ata_generic
> 
> 00:11.0 SCSI storage controller: QLogic Corp. ISP1020 Fast-wide SCSI (rev 05)
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 248, Cache Line Size: 64 bytes
>         Interrupt: pin A routed to IRQ 47
>         Region 0: I/O ports at 8000 [size=256]
>         Region 1: Memory at 09090000 (32-bit, non-prefetchable) [size=4K]
>         Expansion ROM at 09080000 [disabled] [size=64K]
>         Kernel driver in use: qla1280
> 
>            CPU0       
>   1:          3    XT-PIC      i8042
>   2:          0    XT-PIC      cascade
>   4:        320    XT-PIC      ttyS0
>   6:          3    XT-PIC      floppy
>   8:     165722     dummy    -RTC       timer
>  12:          5    XT-PIC      i8042
>  14:          0    XT-PIC      pata_ali
>  15:          0    XT-PIC      pata_ali
>  29:        535     DP264      enp0s9
>  47:      21742     DP264      qla1280
> PMI:          0           Performance Monitoring
> ERR:          0
> 
> 
> dmesg from broken kernel with no libata loaded:
> [    0.000000] Linux version 4.13.0-rc3-00004-g0e4c2eeb758a (mroos@ds10l) (gcc version 5.4.0 (Gentoo 5.4.0-r3 p1.3, pie-0.6.5)) #101 Wed Oct 25 09:49:26 EEST 2017
> [    0.000000] Booting GENERIC on Tsunami variation Webbrick using machine vector Webbrick from SRM
> [    0.000000] Major Options: LEGACY_START VERBOSE_MCHECK MAGIC_SYSRQ 
> [    0.000000] Command line: root=/dev/sda2 console=ttyS0
> [    0.000000] memcluster 0, usage 1, start        0, end      256
> [    0.000000] memcluster 1, usage 0, start      256, end    65429
> [    0.000000] memcluster 2, usage 1, start    65429, end    65536
> [    0.000000] freeing pages 256:384
> [    0.000000] freeing pages 1358:65429
> [    0.000000] reserving pages 1358:1359
> [    0.000000] 2048K Bcache detected; load hit latency 18 cycles, load miss latency 112 cycles
> [    0.000000] On node 0 totalpages: 65429
> [    0.000000] free_area_init_node: node 0, pgdat fffffc0000a4b550, node_mem_map fffffc0000a9e000
> [    0.000000]   DMA zone: 448 pages used for memmap
> [    0.000000]   DMA zone: 0 pages reserved
> [    0.000000]   DMA zone: 65429 pages, LIFO batch:15
> [    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
> [    0.000000] pcpu-alloc: [0] 0 
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 64981
> [    0.000000] Kernel command line: root=/dev/sda2 console=ttyS0
> [    0.000000] PID hash table entries: 2048 (order: 1, 16384 bytes)
> [    0.000000] Dentry cache hash table entries: 65536 (order: 6, 524288 bytes)
> [    0.000000] Inode-cache hash table entries: 32768 (order: 5, 262144 bytes)
> [    0.000000] Sorting __ex_table...
> [    0.000000] Memory: 508632K/523432K available (5297K kernel code, 422K rwdata, 1504K rodata, 256K init, 212K bss, 14800K reserved, 0K cma-reserved)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> [    0.000000] NR_IRQS: 128
> [    0.000000] HWRPB cycle frequency bogus.  Estimated 616560540 Hz
> [    0.000000] clocksource: rpcc: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 3099874744 ns
> [    0.000976] Console: colour dummy device 80x25
> [    0.024414] console [ttyS0] enabled
> [    0.026367] Calibrating delay loop... 1221.92 BogoMIPS (lpj=595968)
> [    0.036132] pid_max: default: 32768 minimum: 301
> [    0.037109] Mount-cache hash table entries: 1024 (order: 0, 8192 bytes)
> [    0.038085] Mountpoint-cache hash table entries: 1024 (order: 0, 8192 bytes)
> [    0.041015] devtmpfs: initialized
> [    0.042968] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1866466235866741 ns
> [    0.043945] futex hash table entries: 256 (order: -1, 6144 bytes)
> [    0.044921] random: get_random_u32 called from bucket_table_alloc+0x12c/0x300 with crng_init=0
> [    0.045898] NET: Registered protocol family 16
> [    0.046874] EISA bus registered
> [    0.047851] PCI host bridge to bus 0000:00
> [    0.048828] pci_bus 0000:00: root bus resource [io  0x0000-0x1ffffff]
> [    0.049804] pci_bus 0000:00: root bus resource [mem 0x00000000-0x3fffffff]
> [    0.050781] pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
> [    0.051757] pci 0000:00:07.0: [10b9:1533] type 00 class 0x060100
> [    0.052734] pci 0000:00:09.0: [1011:0019] type 00 class 0x020000
> [    0.052734] pci 0000:00:09.0: reg 0x10: [io  0x10000-0x1007f]
> [    0.052734] pci 0000:00:09.0: reg 0x14: [mem 0x01091000-0x010913ff]
> [    0.052734] pci 0000:00:09.0: reg 0x30: [mem 0x01000000-0x0103ffff pref]
> [    0.052734] pci 0000:00:0b.0: [1011:0019] type 00 class 0x020000
> [    0.052734] pci 0000:00:0b.0: reg 0x10: [io  0x10080-0x100ff]
> [    0.052734] pci 0000:00:0b.0: reg 0x14: [mem 0x01091400-0x010917ff]
> [    0.052734] pci 0000:00:0b.0: reg 0x30: [mem 0x01040000-0x0107ffff pref]
> [    0.052734] pci 0000:00:0d.0: [10b9:5229] type 00 class 0x0101f0
> [    0.052734] pci 0000:00:0d.0: [Firmware Bug]: reg 0x10: invalid BAR (can't size)
> [    0.053710] pci 0000:00:0d.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
> [    0.054687] pci 0000:00:0d.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
> [    0.055664] pci 0000:00:0d.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
> [    0.056640] pci 0000:00:0d.0: reg 0x20: [io  0x10110-0x1011f]
> [    0.056640] pci 0000:00:0d.0: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
> [    0.057617] pci 0000:00:0d.0: legacy IDE quirk: reg 0x14: [io  0x03f6]
> [    0.058593] pci 0000:00:0d.0: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
> [    0.059570] pci 0000:00:0d.0: legacy IDE quirk: reg 0x1c: [io  0x0376]
> [    0.060546] pci 0000:00:11.0: [1077:1020] type 00 class 0x010000
> [    0.060546] pci 0000:00:11.0: reg 0x10: [io  0x1000-0x10ff]
> [    0.060546] pci 0000:00:11.0: reg 0x14: [mem 0x01090000-0x01090fff]
> [    0.060546] pci 0000:00:11.0: reg 0x30: [mem 0x01080000-0x0108ffff pref]
> [    0.060546] pci: enabling save/restore of SRM state
> [    0.061523] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
> [    0.061523] pci 0000:00:09.0: BAR 6: assigned [mem 0x09000000-0x0903ffff pref]
> [    0.062499] pci 0000:00:0b.0: BAR 6: assigned [mem 0x09040000-0x0907ffff pref]
> [    0.063476] pci 0000:00:11.0: BAR 6: assigned [mem 0x09080000-0x0908ffff pref]
> [    0.064453] pci 0000:00:11.0: BAR 1: assigned [mem 0x09090000-0x09090fff]
> [    0.065429] pci 0000:00:09.0: BAR 1: assigned [mem 0x09091000-0x090913ff]
> [    0.066406] pci 0000:00:0b.0: BAR 1: assigned [mem 0x09092000-0x090923ff]
> [    0.067382] pci 0000:00:11.0: BAR 0: assigned [io  0x8000-0x80ff]
> [    0.068359] pci 0000:00:09.0: BAR 0: assigned [io  0x8400-0x847f]
> [    0.069335] pci 0000:00:0b.0: BAR 0: assigned [io  0x8480-0x84ff]
> [    0.070312] pci 0000:00:0d.0: BAR 4: assigned [io  0x8800-0x880f]
> [    0.071289] pci_bus 0000:00: resource 4 [io  0x0000-0x1ffffff]
> [    0.071289] pci_bus 0000:00: resource 5 [mem 0x00000000-0x3fffffff]
> [    0.075195] vgaarb: loaded
> [    0.076171] SCSI subsystem initialized
> [    0.078124] clocksource: Switched to clocksource rpcc
> [    0.086914] NET: Registered protocol family 2
> [    0.087890] random: get_random_u32 called from neigh_hash_alloc+0xdc/0x160 with crng_init=0
> [    0.088867] random: get_random_u32 called from rt_genid_init+0x2c/0x50 with crng_init=0
> [    0.089843] TCP established hash table entries: 4096 (order: 2, 32768 bytes)
> [    0.090820] TCP bind hash table entries: 4096 (order: 2, 32768 bytes)
> [    0.091796] TCP: Hash tables configured (established 4096 bind 4096)
> [    0.092773] UDP hash table entries: 256 (order: 0, 8192 bytes)
> [    0.094726] UDP-Lite hash table entries: 256 (order: 0, 8192 bytes)
> [    0.096679] NET: Registered protocol family 1
> [    0.097656] pci 0000:00:07.0: Activating ISA DMA hang workarounds
> [    0.098632] PCI: CLS 64 bytes, default 64
> [    0.099609] srm_env: version 0.0.6 loaded successfully
> [    0.100585] Using epoch 2000 for rtc year 17
> [    0.102539] platform rtc-alpha: rtc core: registered rtc-alpha as rtc0
> [    0.103515] workingset: timestamp_bits=62 max_order=16 bucket_order=0
> [    0.113281] random: fast init done
> [    0.115234] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
> [    0.116210] io scheduler noop registered
> [    0.118164] io scheduler cfq registered (default)
> [    0.119140] isapnp: Scanning for PnP cards...
> [    0.473632] isapnp: No Plug & Play device found
> [    0.475585] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> [    0.477538] serial8250: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> [    0.480468] serial8250: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
> [    0.482421] qla1280: QLA1040 found on PCI bus 0, dev 17
> [    0.484374] Floppy drive(s): fd0 is 2.88M
> [    0.824218] random: crng init done
> [    0.946288] FDC 0 is a post-1991 82077
> [    0.960937] scsi(0:0): Resetting SCSI BUS
> [    3.999997] scsi host0: QLogic QLA1040 PCI to SCSI Host Adapter
>                       Firmware version:  7.65.06, Driver version 3.27.1
> [    4.006833] Linux Tulip driver version 1.1.15 (Feb 27, 2007)
> [    4.013669] tulip0: EEPROM default media type Autosense
> [    4.014646] tulip0: Index #0 - Media 10baseT (#0) described by a 21142 Serial PHY (2) block
> [    4.015622] tulip0: Index #1 - Media 10baseT-FDX (#4) described by a 21142 Serial PHY (2) block
> [    4.016599] tulip0: Index #2 - Media 100baseTx (#3) described by a 21143 SYM PHY (4) block
> [    4.017576] tulip0: Index #3 - Media 100baseTx-FDX (#5) described by a 21143 SYM PHY (4) block
> [    4.025388] net eth0: Digital DS21142/43 Tulip rev 65 at MMIO 0x9091000, 00:10:64:30:19:8e, IRQ 29
> [    4.032224] tulip1: EEPROM default media type Autosense
> [    4.033201] tulip1: Index #0 - Media 10baseT (#0) described by a 21142 Serial PHY (2) block
> [    4.034177] tulip1: Index #1 - Media 10baseT-FDX (#4) described by a 21142 Serial PHY (2) block
> [    4.035154] tulip1: Index #2 - Media 100baseTx (#3) described by a 21143 SYM PHY (4) block
> [    4.036130] tulip1: Index #3 - Media 100baseTx-FDX (#5) described by a 21143 SYM PHY (4) block
> [    4.043943] net eth1: Digital DS21142/43 Tulip rev 65 at MMIO 0x9092000, 00:10:64:30:19:8d, IRQ 30
> [    4.049802] serio: i8042 KBD port at 0x60,0x64 irq 1
> [    4.050779] serio: i8042 AUX port at 0x60,0x64 irq 12
> [    4.051755] scsi 0:0:0:0: Direct-Access     COMPAQ   BF0369A4BC       HPB7 PQ: 0 ANSI: 3
> [    4.053708] mousedev: PS/2 mouse device common for all mice
> [    4.055661] NET: Registered protocol family 10
> [    4.058591] scsi(0:0:0:0):
> [    4.058591]  Sync: period 10, offset 12
> [    4.058591] , Wide
> [    4.058591] , Tagged queuing: depth 31
> 
> [    4.060544] atkbd serio0: keyboard reset failed on isa0060/serio0
> [    4.062497] Segment Routing with IPv6
> [    4.063474] NET: Registered protocol family 17
> [    4.065427] platform rtc-alpha: setting system clock to 2017-10-25 08:33:31 UTC (1508920411)
> [    4.083005] atkbd serio1: keyboard reset failed on isa0060/serio1
> [    6.167965] sd 0:0:0:0: Attached scsi generic sg0 type 0
> [    6.168942] sd 0:0:0:0: [sda] 71132000 512-byte logical blocks: (36.4 GB/33.9 GiB)
> [    6.170895] sd 0:0:0:0: [sda] Write Protect is off
> [    6.171871] sd 0:0:0:0: [sda] Mode Sense: cf 00 10 08
> [    6.172848] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, supports DPO and FUA
> [    6.186520]  sda: sda1 sda2 sda4
> [    6.191403] sd 0:0:0:0: [sda] Attached SCSI disk
> [    6.195309] EXT4-fs (sda2): couldn't mount as ext3 due to feature incompatibilities
> [    6.197262] EXT4-fs (sda2): couldn't mount as ext2 due to feature incompatibilities
> [    6.211910] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
> [    6.212887] VFS: Mounted root (ext4 filesystem) readonly on device 8:2.
> [    6.234371] devtmpfs: mounted
> [    6.235348] Freeing unused kernel memory: 256K
> [    6.236324] This architecture does not have kernel memory protection.
> [   13.266594] tulip 0000:00:0b.0 enp0s11: renamed from eth1
> [   13.267571] tulip 0000:00:09.0 enp0s9: renamed from eth0
> [   15.346671] EXT4-fs (sda2): re-mounted. Opts: (null)
> [   16.040030] EXT4-fs (sda1): mounting ext2 file system using the ext4 subsystem
> [   16.050773] EXT4-fs (sda1): mounted filesystem without journal. Opts: (null)
> 
> -- 
> Meelis Roos (mroos@ut.ee)      http://www.cs.ut.ee/~mroos/
