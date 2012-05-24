Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:51429 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933458Ab2EXS0y (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 May 2012 14:26:54 -0400
Date: Thu, 24 May 2012 20:26:10 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Rob Allen <ra-kernel@hotmail.co.uk>,
	Yinghai Lu <yinghai@kernel.org>, Ram Pai <linuxram@us.ibm.com>,
	linux1394-devel@lists.sourceforge.net, linux-pci@vger.kernel.org
Subject: Re: [Bug 43244] New: firewire_ohci prevents boot
Message-ID: <20120524202610.5c561d99@stein>
In-Reply-To: <4FBAA3A5.4070200@ladisch.de>
References: <bug-43244-4803@https.bugzilla.kernel.org/>
	<20120513221357.7574ae79@stein>
	<4FB0A6F6.9050504@ladisch.de>
	<CAE9FiQXA4C8hACXChokL4CZVBDhdh17Qs7tngn5q-pS0U5=bPQ@mail.gmail.com>
	<BLU0-SMTP12B809D527F768CCC42B18B7180@phx.gbl>
	<4FB3B159.2090401@ladisch.de>
	<BLU0-SMTP47479D78AA811CB0B224ADFB71D0@phx.gbl>
	<4FBAA3A5.4070200@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On May 24 bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=43244
> 
> --- Comment #3 from Rob Allen <ra-kernel@hotmail.co.uk>  2012-05-24 17:30:12 ---
> Created an attachment (id=73381)
>  --> (https://bugzilla.kernel.org/attachment.cgi?id=73381)
> dmesg from v3.4 with CONFIG_PCI_DEBUG

(I am including the file here without comment.)

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.4.0-custom+ (root@toaster) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #2 SMP Wed May 23 20:40:40 BST 2012
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   NSC Geode by NSC
[    0.000000]   Cyrix CyrixInstead
[    0.000000]   Centaur CentaurHauls
[    0.000000]   Transmeta GenuineTMx86
[    0.000000]   Transmeta TransmetaCPU
[    0.000000]   UMC UMC UMC UMC
[    0.000000] Disabled fast string operations
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009e000 (usable)
[    0.000000]  BIOS-e820: 000000000009e000 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007fe80000 (usable)
[    0.000000]  BIOS-e820: 000000007fe80000 - 000000007fe97000 (ACPI data)
[    0.000000]  BIOS-e820: 000000007fe97000 - 000000007ff00000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000007ff00000 - 0000000080000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
[    0.000000]  BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed1c000 - 00000000fed90000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
[    0.000000] Notice: NX (Execute Disable) protection cannot be enabled: non-PAE kernel!
[    0.000000] DMI present.
[    0.000000] DMI: Acer, inc. TravelMate 8200 /Como            , BIOS v1.3521 02/08/07
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> (reserved)
[    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
[    0.000000] last_pfn = 0x7fe80 max_arch_pfn = 0x100000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-CFFFF write-protect
[    0.000000]   D0000-DFFFF uncachable
[    0.000000]   E0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask F80000000 write-back
[    0.000000]   1 base 07FF00000 mask FFFF00000 uncachable
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] PAT not supported by CPU.
[    0.000000] original variable MTRRs
[    0.000000] reg 0, base: 0GB, range: 2GB, type WB
[    0.000000] reg 1, base: 2047MB, range: 1MB, type UC
[    0.000000] total RAM covered: 2047M
[    0.000000] Found optimal setting for mtrr clean up
[    0.000000]  gran_size: 64K 	chunk_size: 2M 	num_reg: 2  	lose cover RAM: 0G
[    0.000000] New variable MTRRs
[    0.000000] reg 0, base: 0GB, range: 2GB, type WB
[    0.000000] reg 1, base: 2047MB, range: 1MB, type UC
[    0.000000] found SMP MP-table at [c00f6640] f6640
[    0.000000] initial memory mapped : 0 - 01c00000
[    0.000000] Base memory trampoline at [c009a000] 9a000 size 16384
[    0.000000] init_memory_mapping: 0000000000000000-00000000377fe000
[    0.000000]  0000000000 - 0000400000 page 4k
[    0.000000]  0000400000 - 0037400000 page 2M
[    0.000000]  0037400000 - 00377fe000 page 4k
[    0.000000] kernel direct mapping tables up to 377fe000 @ 1bfb000-1c00000
[    0.000000] RAMDISK: 35988000 - 36cbc000
[    0.000000] ACPI: RSDP 000f6570 00014 (v00 PTLTD )
[    0.000000] ACPI: RSDT 7fe8c849 00048 (v01 ACRSYS ACRPRDCT 06040000  LTP 00000000)
[    0.000000] ACPI: FACP 7fe96c47 00074 (v01 INTEL  CALISTGA 06040000 LOHR 0000005A)
[    0.000000] ACPI: DSDT 7fe8d24f 099F8 (v01 INTEL  CALISTGA 06040000 MSFT 03000000)
[    0.000000] ACPI: FACS 7fe97fc0 00040
[    0.000000] ACPI: APIC 7fe96cbb 00068 (v01 INTEL  CALISTGA 06040000 LOHR 0000005A)
[    0.000000] ACPI: HPET 7fe96d23 00038 (v01 INTEL  CALISTGA 06040000 LOHR 0000005A)
[    0.000000] ACPI: MCFG 7fe96d5b 0003C (v01 INTEL  CALISTGA 06040000 LOHR 0000005A)
[    0.000000] ACPI: APIC 7fe96d97 00068 (v01 PTLTD  ? APIC   06040000  LTP 00000000)
[    0.000000] ACPI: BOOT 7fe96dff 00028 (v01 PTLTD  $SBFTBL$ 06040000  LTP 00000001)
[    0.000000] ACPI: ASF! 7fe96e27 00063 (v16   CETP     CETP 06040000 PTL  00000001)
[    0.000000] ACPI: SLIC 7fe96e8a 00176 (v01 ACRSYS ACRPRDCT 06040000 acer 00000000)
[    0.000000] ACPI: SSDT 7fe8c891 004F6 (v01  PmRef    CpuPm 00003000 INTL 20050624)
[    0.000000] ACPI: BIOS bug: multiple APIC/MADT found, using 0
[    0.000000] ACPI: If "acpi_apic_instance=2" works better, notify linux-acpi@vger.kernel.org
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] 1158MB HIGHMEM available.
[    0.000000] 887MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 377fe000
[    0.000000]   low ram: 0 - 377fe000
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   Normal   0x00001000 -> 0x000377fe
[    0.000000]   HighMem  0x000377fe -> 0x0007fe80
[    0.000000] Movable zone start PFN for each node
[    0.000000] Early memory PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009e
[    0.000000]     0: 0x00000100 -> 0x0007fe80
[    0.000000] On node 0 totalpages: 523790
[    0.000000] free_area_init_node: node 0, pgdat c17f04c0, node_mem_map f4988200
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3950 pages, LIFO batch:0
[    0.000000]   Normal zone: 1744 pages used for memmap
[    0.000000]   Normal zone: 221486 pages, LIFO batch:31
[    0.000000]   HighMem zone: 2318 pages used for memmap
[    0.000000]   HighMem zone: 294260 pages, LIFO batch:31
[    0.000000] Using APIC driver default
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 40
[    0.000000] PM: Registered nosave memory: 000000000009e000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e4000
[    0.000000] PM: Registered nosave memory: 00000000000e4000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at 80000000 (gap: 80000000:60000000)
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:2 nr_node_ids:1
[    0.000000] PERCPU: Embedded 13 pages/cpu @f77d7000 s31360 r0 d21888 u53248
[    0.000000] pcpu-alloc: s31360 r0 d21888 u53248 alloc=13*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 519696
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-3.4.0-custom+ root=UUID=2d3481ff-0905-4fbf-aa55-0c536c638597 ro blacklist=firewire_ohci nomodeset
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Initializing CPU#0
[    0.000000] allocated 4191104 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
[    0.000000] Initializing HighMem for node 0 (000377fe:0007fe80)
[    0.000000] Memory: 2044268k/2095616k available (5481k kernel code, 50892k reserved, 2697k data, 692k init, 1186312k highmem)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xfff16000 - 0xfffff000   ( 932 kB)
[    0.000000]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[    0.000000]     vmalloc : 0xf7ffe000 - 0xff7fe000   ( 120 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf77fe000   ( 887 MB)
[    0.000000]       .init : 0xc17fd000 - 0xc18aa000   ( 692 kB)
[    0.000000]       .data : 0xc155a7de - 0xc17fce80   (2697 kB)
[    0.000000]       .text : 0xc1000000 - 0xc155a7de   (5481 kB)
[    0.000000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.000000] SLUB: Genslabs=15, HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] NR_IRQS:2304 nr_irqs:512 16
[    0.000000] CPU 0 irqstacks, hard=f4408000 soft=f440a000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] hpet clockevent registered
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 2000.176 MHz processor.
[    0.004002] Calibrating delay loop (skipped), value calculated using timer frequency.. 4000.35 BogoMIPS (lpj=8000704)
[    0.004116] pid_max: default: 32768 minimum: 301
[    0.004195] Security Framework initialized
[    0.004265] AppArmor: AppArmor initialized
[    0.004370] Mount-cache hash table entries: 512
[    0.004677] Initializing cgroup subsys cpuacct
[    0.004733] Initializing cgroup subsys memory
[    0.004795] Initializing cgroup subsys devices
[    0.004851] Initializing cgroup subsys freezer
[    0.004906] Initializing cgroup subsys net_cls
[    0.004962] Initializing cgroup subsys blkio
[    0.005024] Initializing cgroup subsys perf_event
[    0.005106] Disabled fast string operations
[    0.005164] CPU: Physical Processor ID: 0
[    0.005218] CPU: Processor Core ID: 0
[    0.005273] mce: CPU supports 6 MCE banks
[    0.005336] CPU0: Thermal monitoring enabled (TM2)
[    0.005393] using mwait in idle threads.
[    0.009130] ACPI: Core revision 20120320
[    0.016010] ftrace: allocating 22770 entries in 45 pages
[    0.028078] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.028597] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.071730] CPU0: Genuine Intel(R) CPU           T2500  @ 2.00GHz stepping 08
[    0.072003] Performance Events: Core events, core PMU driver.
[    0.072003] ... version:                1
[    0.072003] ... bit width:              40
[    0.072003] ... generic registers:      2
[    0.072003] ... value mask:             000000ffffffffff
[    0.072003] ... max period:             000000007fffffff
[    0.072003] ... fixed-purpose events:   0
[    0.072003] ... event mask:             0000000000000003
[    0.072003] CPU 1 irqstacks, hard=f44b6000 soft=f44c0000
[    0.072003] Booting Node   0, Processors  #1 Ok.
[    0.008000] Initializing CPU#1
[    0.008000] Disabled fast string operations
[    0.080025] Brought up 2 CPUs
[    0.080188] Total of 2 processors activated (8000.70 BogoMIPS).
[    0.081624] devtmpfs: initialized
[    0.084072] PM: Registering ACPI NVS region [mem 0x7fe97000-0x7fefffff] (430080 bytes)
[    0.085344] dummy: 
[    0.085434] RTC time: 17:02:53, date: 05/24/12
[    0.085536] NET: Registered protocol family 16
[    0.085762] EISA bus registered
[    0.085882] ACPI: bus type pci registered
[    0.086008] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.086076] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    0.086134] PCI: Using MMCONFIG for extended config space
[    0.086190] PCI: Using configuration type 1 for base access
[    0.087377] bio: create slab <bio-0> at 0
[    0.087377] ACPI: Added _OSI(Module Device)
[    0.087377] ACPI: Added _OSI(Processor Device)
[    0.087377] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.087377] ACPI: Added _OSI(Processor Aggregator Device)
[    0.089848] ACPI: EC: Look up EC in DSDT
[    0.093222] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.692601] ACPI: SSDT 7fe8cfdc 001EA (v01  PmRef  Cpu0Ist 00003000 INTL 20050624)
[    0.693201] ACPI: Dynamic OEM Table Load:
[    0.693344] ACPI: SSDT   (null) 001EA (v01  PmRef  Cpu0Ist 00003000 INTL 20050624)
[    0.693610] ACPI: SSDT 7fe8cd87 001D0 (v01  PmRef  Cpu0Cst 00003001 INTL 20050624)
[    0.694190] ACPI: Dynamic OEM Table Load:
[    0.694334] ACPI: SSDT   (null) 001D0 (v01  PmRef  Cpu0Cst 00003001 INTL 20050624)
[    0.694725] ACPI: SSDT 7fe8d1c6 00089 (v01  PmRef  Cpu1Ist 00003000 INTL 20050624)
[    0.695313] ACPI: Dynamic OEM Table Load:
[    0.695456] ACPI: SSDT   (null) 00089 (v01  PmRef  Cpu1Ist 00003000 INTL 20050624)
[    0.696187] ACPI: SSDT 7fe8cf57 00085 (v01  PmRef  Cpu1Cst 00003000 INTL 20050624)
[    0.696769] ACPI: Dynamic OEM Table Load:
[    0.696912] ACPI: SSDT   (null) 00085 (v01  PmRef  Cpu1Cst 00003000 INTL 20050624)
[    0.697376] ACPI: EC: GPE storm detected, transactions will use polling mode
[    0.828126] ACPI: Interpreter enabled
[    0.828190] ACPI: (supports S0 S3 S4 S5)
[    0.828436] ACPI: Using IOAPIC for interrupt routing
[    0.833201] ACPI: EC: GPE = 0x17, I/O: command/status = 0x66, data = 0x62
[    0.834524] ACPI: ACPI Dock Station Driver: 4 docks/bays found
[    0.834586] PCI: Ignoring host bridge windows from ACPI; if necessary, use "pci=use_crs" and report a bug
[    0.834952] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.835577] pci_root PNP0A08:00: host bridge window [io  0x0000-0x0cf7] (ignored)
[    0.835581] pci_root PNP0A08:00: host bridge window [io  0x0d00-0xffff] (ignored)
[    0.835585] pci_root PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff] (ignored)
[    0.835589] pci_root PNP0A08:00: host bridge window [mem 0x000d4000-0x000d7fff] (ignored)
[    0.835592] pci_root PNP0A08:00: host bridge window [mem 0x000d8000-0x000dbfff] (ignored)
[    0.835596] pci_root PNP0A08:00: host bridge window [mem 0x000dc000-0x000dffff] (ignored)
[    0.835599] pci_root PNP0A08:00: host bridge window [mem 0x000e0000-0x000e3fff] (ignored)
[    0.835603] pci_root PNP0A08:00: host bridge window [mem 0x80000000-0xfebfffff] (ignored)
[    0.835606] PCI: root bus 00: using default resources
[    0.835651] PCI host bridge to bus 0000:00
[    0.835708] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.835765] pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffff]
[    0.835824] pci_bus 0000:00: scanning bus
[    0.835836] pci 0000:00:00.0: [8086:27a0] type 00 class 0x060000
[    0.835847] pci 0000:00:00.0: calling quirk_mmio_always_on+0x0/0x9
[    0.835898] pci 0000:00:01.0: [8086:27a1] type 01 class 0x060400
[    0.835923] pci 0000:00:01.0: calling pci_fixup_transparent_bridge+0x0/0x1e
[    0.835953] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.835958] pci 0000:00:01.0: PME# disabled
[    0.836023] pci 0000:00:1b.0: [8086:27d8] type 00 class 0x040300
[    0.836059] pci 0000:00:1b.0: reg 10: [mem 0xd0700000-0xd0703fff 64bit]
[    0.836164] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.836169] pci 0000:00:1b.0: PME# disabled
[    0.836200] pci 0000:00:1c.0: [8086:27d0] type 01 class 0x060400
[    0.836254] pci 0000:00:1c.0: calling pci_fixup_transparent_bridge+0x0/0x1e
[    0.836314] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.836320] pci 0000:00:1c.0: PME# disabled
[    0.836353] pci 0000:00:1c.1: [8086:27d2] type 01 class 0x060400
[    0.836407] pci 0000:00:1c.1: calling pci_fixup_transparent_bridge+0x0/0x1e
[    0.836466] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.836472] pci 0000:00:1c.1: PME# disabled
[    0.836505] pci 0000:00:1c.2: [8086:27d4] type 01 class 0x060400
[    0.836559] pci 0000:00:1c.2: calling pci_fixup_transparent_bridge+0x0/0x1e
[    0.836618] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.836624] pci 0000:00:1c.2: PME# disabled
[    0.836657] pci 0000:00:1c.3: [8086:27d6] type 01 class 0x060400
[    0.836711] pci 0000:00:1c.3: calling pci_fixup_transparent_bridge+0x0/0x1e
[    0.836771] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    0.836776] pci 0000:00:1c.3: PME# disabled
[    0.836809] pci 0000:00:1c.4: [8086:27e0] type 01 class 0x060400
[    0.836863] pci 0000:00:1c.4: calling pci_fixup_transparent_bridge+0x0/0x1e
[    0.836922] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.836928] pci 0000:00:1c.4: PME# disabled
[    0.836960] pci 0000:00:1c.5: [8086:27e2] type 01 class 0x060400
[    0.837015] pci 0000:00:1c.5: calling pci_fixup_transparent_bridge+0x0/0x1e
[    0.837075] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    0.837080] pci 0000:00:1c.5: PME# disabled
[    0.837110] pci 0000:00:1d.0: [8086:27c8] type 00 class 0x0c0300
[    0.837167] pci 0000:00:1d.0: reg 20: [io  0x1800-0x181f]
[    0.837210] pci 0000:00:1d.1: [8086:27c9] type 00 class 0x0c0300
[    0.837267] pci 0000:00:1d.1: reg 20: [io  0x1820-0x183f]
[    0.837311] pci 0000:00:1d.2: [8086:27ca] type 00 class 0x0c0300
[    0.837367] pci 0000:00:1d.2: reg 20: [io  0x1840-0x185f]
[    0.837410] pci 0000:00:1d.3: [8086:27cb] type 00 class 0x0c0300
[    0.837467] pci 0000:00:1d.3: reg 20: [io  0x1860-0x187f]
[    0.837524] pci 0000:00:1d.7: [8086:27cc] type 00 class 0x0c0320
[    0.837549] pci 0000:00:1d.7: reg 10: [mem 0xd0704000-0xd07043ff]
[    0.837657] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.837663] pci 0000:00:1d.7: PME# disabled
[    0.837687] pci 0000:00:1e.0: [8086:2448] type 01 class 0x060401
[    0.837736] pci 0000:00:1e.0: calling pci_fixup_transparent_bridge+0x0/0x1e
[    0.837789] pci 0000:00:1f.0: [8086:27bd] type 00 class 0x060100
[    0.837898] pci 0000:00:1f.0: calling ich_force_enable_hpet+0x0/0x190
[    0.837904] pci 0000:00:1f.0: calling quirk_ich7_lpc+0x0/0x52
[    0.837912] pci 0000:00:1f.0: quirk: [io  0x1000-0x107f] claimed by ICH6 ACPI/GPIO/TCO
[    0.837983] pci 0000:00:1f.0: quirk: [io  0x1180-0x11bf] claimed by ICH6 GPIO
[    0.838044] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0680 (mask 007f)
[    0.838112] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 2 PIO at 1600 (mask 007f)
[    0.838182] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 4 PIO at 0068 (mask 0007)
[    0.838308] pci 0000:00:1f.2: [8086:27c4] type 00 class 0x010180
[    0.838330] pci 0000:00:1f.2: reg 10: [io  0x0000-0x0007]
[    0.838343] pci 0000:00:1f.2: reg 14: [io  0x0000-0x0003]
[    0.838356] pci 0000:00:1f.2: reg 18: [io  0x0000-0x0007]
[    0.838368] pci 0000:00:1f.2: reg 1c: [io  0x0000-0x0003]
[    0.838381] pci 0000:00:1f.2: reg 20: [io  0x18b0-0x18bf]
[    0.838438] pci 0000:00:1f.2: PME# supported from D3hot
[    0.838443] pci 0000:00:1f.2: PME# disabled
[    0.838462] pci 0000:00:1f.3: [8086:27da] type 00 class 0x0c0500
[    0.838536] pci 0000:00:1f.3: reg 20: [io  0x18c0-0x18df]
[    0.838588] pci_bus 0000:00: fixups for bus
[    0.838592] pci 0000:00:01.0: scanning [bus 01-01] behind bridge, pass 0
[    0.838622] pci_bus 0000:01: scanning bus
[    0.838640] pci 0000:01:00.0: [1002:71c5] type 00 class 0x030000
[    0.838657] pci 0000:01:00.0: reg 10: [mem 0xc0000000-0xcfffffff pref]
[    0.838669] pci 0000:01:00.0: reg 14: [io  0x2000-0x20ff]
[    0.838681] pci 0000:01:00.0: reg 18: [mem 0xd0200000-0xd020ffff]
[    0.838721] pci 0000:01:00.0: reg 30: [mem 0x00000000-0x0001ffff pref]
[    0.838771] pci 0000:01:00.0: supports D1 D2
[    0.838788] pci 0000:01:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.838862] pci_bus 0000:01: fixups for bus
[    0.838865] pci 0000:00:01.0: PCI bridge to [bus 01-01]
[    0.838914] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.838918] pci 0000:00:01.0:   bridge window [mem 0xd0200000-0xd02fffff]
[    0.838924] pci 0000:00:01.0:   bridge window [mem 0xc0000000-0xcfffffff 64bit pref]
[    0.838927] pci_bus 0000:01: bus scan returning with max=01
[    0.838933] pci 0000:00:1c.0: scanning [bus 02-02] behind bridge, pass 0
[    0.838989] pci_bus 0000:02: scanning bus
[    0.838993] pci_bus 0000:02: fixups for bus
[    0.838995] pci 0000:00:1c.0: PCI bridge to [bus 02-02]
[    0.839054] pci_bus 0000:02: bus scan returning with max=02
[    0.839060] pci 0000:00:1c.1: scanning [bus 03-03] behind bridge, pass 0
[    0.839116] pci_bus 0000:03: scanning bus
[    0.839154] pci 0000:03:00.0: [8086:108c] type 00 class 0x020000
[    0.839186] pci 0000:03:00.0: reg 10: [mem 0x00000000-0x0001ffff]
[    0.839209] pci 0000:03:00.0: reg 14: [mem 0x00000000-0x000fffff]
[    0.839231] pci 0000:03:00.0: reg 18: [io  0x0000-0x001f]
[    0.839416] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    0.839424] pci 0000:03:00.0: PME# disabled
[    0.839462] pci 0000:03:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.839531] pci_bus 0000:03: fixups for bus
[    0.839534] pci 0000:00:1c.1: PCI bridge to [bus 03-03]
[    0.839593] pci_bus 0000:03: bus scan returning with max=03
[    0.839599] pci 0000:00:1c.2: scanning [bus 04-04] behind bridge, pass 0
[    0.839655] pci_bus 0000:04: scanning bus
[    0.839659] pci_bus 0000:04: fixups for bus
[    0.839662] pci 0000:00:1c.2: PCI bridge to [bus 04-04]
[    0.839720] pci_bus 0000:04: bus scan returning with max=04
[    0.839726] pci 0000:00:1c.3: scanning [bus 05-05] behind bridge, pass 0
[    0.839782] pci_bus 0000:05: scanning bus
[    0.839851] pci 0000:05:00.0: [8086:4222] type 00 class 0x028000
[    0.839907] pci 0000:05:00.0: reg 10: [mem 0x00000000-0x00000fff]
[    0.840337] pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
[    0.840351] pci 0000:05:00.0: PME# disabled
[    0.840421] pci 0000:05:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.840504] pci_bus 0000:05: fixups for bus
[    0.840507] pci 0000:00:1c.3: PCI bridge to [bus 05-05]
[    0.840565] pci_bus 0000:05: bus scan returning with max=05
[    0.840571] pci 0000:00:1c.4: scanning [bus 06-06] behind bridge, pass 0
[    0.840627] pci_bus 0000:06: scanning bus
[    0.840631] pci_bus 0000:06: fixups for bus
[    0.840634] pci 0000:00:1c.4: PCI bridge to [bus 06-06]
[    0.840692] pci_bus 0000:06: bus scan returning with max=06
[    0.840698] pci 0000:00:1c.5: scanning [bus 07-09] behind bridge, pass 0
[    0.840756] pci_bus 0000:07: scanning bus
[    0.840760] pci_bus 0000:07: fixups for bus
[    0.840763] pci 0000:00:1c.5: PCI bridge to [bus 07-09]
[    0.840821] pci_bus 0000:07: bus scan returning with max=07
[    0.840827] pci 0000:00:1e.0: scanning [bus 0a-0b] behind bridge, pass 0
[    0.840856] pci_bus 0000:0a: scanning bus
[    0.840890] pci 0000:0a:09.0: [1217:7134] type 02 class 0x060700
[    0.840917] pci 0000:0a:09.0: reg 10: [mem 0xd0400000-0xd0400fff]
[    0.840962] pci 0000:0a:09.0: supports D1 D2
[    0.840964] pci 0000:0a:09.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.840971] pci 0000:0a:09.0: PME# disabled
[    0.840996] pci 0000:0a:09.1: [1217:7134] type 02 class 0x060700
[    0.841022] pci 0000:0a:09.1: reg 10: [mem 0x00000000-0x00000fff]
[    0.841066] pci 0000:0a:09.1: supports D1 D2
[    0.841069] pci 0000:0a:09.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.841075] pci 0000:0a:09.1: PME# disabled
[    0.841102] pci 0000:0a:09.4: [1217:00f7] type 00 class 0x0c0010
[    0.841123] pci 0000:0a:09.4: reg 10: [mem 0x00000000-0x00000fff]
[    0.841136] pci 0000:0a:09.4: reg 14: [mem 0xd0403000-0xd04037ff]
[    0.841221] pci 0000:0a:09.4: supports D1 D2
[    0.841224] pci 0000:0a:09.4: PME# supported from D0 D1 D2 D3hot
[    0.841230] pci 0000:0a:09.4: PME# disabled
[    0.841282] pci_bus 0000:0a: fixups for bus
[    0.841285] pci 0000:00:1e.0: PCI bridge to [bus 0a-0b] (subtractive decode)
[    0.841340] pci 0000:00:1e.0:   bridge window [mem 0xd0400000-0xd04fffff]
[    0.841349] pci 0000:00:1e.0:   bridge window [io  0x0000-0xffff] (subtractive decode)
[    0.841352] pci 0000:00:1e.0:   bridge window [mem 0x00000000-0xffffffff] (subtractive decode)
[    0.841358] pci 0000:0a:09.0: scanning [bus 0b-0b] behind bridge, pass 0
[    0.841368] pci 0000:0a:09.1: scanning [bus 00-00] behind bridge, pass 0
[    0.841371] pci 0000:0a:09.1: bus configuration invalid, reconfiguring
[    0.841383] pci 0000:0a:09.0: scanning [bus 0b-0b] behind bridge, pass 1
[    0.841428] pci_bus 0000:0b: [bus 0b-0e] partially hidden behind transparent bridge 0000:0a [bus 0a-0b]
[    0.841490] pci 0000:0a:09.1: scanning [bus 00-00] behind bridge, pass 1
[    0.841534] pci_bus 0000:0f: [bus 0f-12] partially hidden behind transparent bridge 0000:0a [bus 0a-0b]
[    0.841593] pci_bus 0000:0a: bus scan returning with max=12
[    0.841599] pci 0000:00:01.0: scanning [bus 01-01] behind bridge, pass 1
[    0.841605] pci 0000:00:1c.0: scanning [bus 02-02] behind bridge, pass 1
[    0.841614] pci 0000:00:1c.1: scanning [bus 03-03] behind bridge, pass 1
[    0.841623] pci 0000:00:1c.2: scanning [bus 04-04] behind bridge, pass 1
[    0.841631] pci 0000:00:1c.3: scanning [bus 05-05] behind bridge, pass 1
[    0.841640] pci 0000:00:1c.4: scanning [bus 06-06] behind bridge, pass 1
[    0.841649] pci 0000:00:1c.5: scanning [bus 07-09] behind bridge, pass 1
[    0.841657] pci 0000:00:1e.0: scanning [bus 0a-0b] behind bridge, pass 1
[    0.841664] pci_bus 0000:00: bus scan returning with max=12
[    0.841667] pci_bus 0000:00: on NUMA node 0
[    0.841671] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.841829] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEGP._PRT]
[    0.841889] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
[    0.841942] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
[    0.841996] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
[    0.842044] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04._PRT]
[    0.842097] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP05._PRT]
[    0.842175] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
[    0.842241]  pci0000:00: Requesting ACPI _OSC control (0x1d)
[    0.842291]  pci0000:00: ACPI _OSC request failed (AE_NOT_FOUND), returned control mask: 0x1d
[    0.842346] ACPI _OSC control for PCIe not granted, disabling ASPM
[    0.847627] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
[    0.848185] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 *11 12 14 15)
[    0.848700] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 12 14 15)
[    0.849215] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
[    0.849769] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 *10 12 14 15)
[    0.850283] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
[    0.850875] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 *10 12 14 15)
[    0.851392] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 *11 12 14 15)
[    0.851925] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.852058] vgaarb: loaded
[    0.852102] vgaarb: bridge control possible 0000:01:00.0
[    0.852335] SCSI subsystem initialized
[    0.852395] libata version 3.00 loaded.
[    0.852395] usbcore: registered new interface driver usbfs
[    0.852395] usbcore: registered new interface driver hub
[    0.852395] usbcore: registered new device driver usb
[    0.852395] PCI: Using ACPI for IRQ routing
[    0.861431] PCI: pci_cache_line_size set to 64 bytes
[    0.861444] pci 0000:00:1b.0: BAR 0: reserving [mem 0xd0700000-0xd0703fff flags 0x140204] (d=0, p=0)
[    0.861464] pci 0000:00:1d.0: BAR 4: reserving [io  0x1800-0x181f flags 0x40101] (d=0, p=0)
[    0.861470] pci 0000:00:1d.1: BAR 4: reserving [io  0x1820-0x183f flags 0x40101] (d=0, p=0)
[    0.861476] pci 0000:00:1d.2: BAR 4: reserving [io  0x1840-0x185f flags 0x40101] (d=0, p=0)
[    0.861483] pci 0000:00:1d.3: BAR 4: reserving [io  0x1860-0x187f flags 0x40101] (d=0, p=0)
[    0.861489] pci 0000:00:1d.7: BAR 0: reserving [mem 0xd0704000-0xd07043ff flags 0x40200] (d=0, p=0)
[    0.861500] pci 0000:00:1f.2: BAR 0: reserving [io  0x01f0-0x01f7 flags 0x110] (d=0, p=0)
[    0.861504] pci 0000:00:1f.2: BAR 1: reserving [io  0x03f6 flags 0x110] (d=0, p=0)
[    0.861508] pci 0000:00:1f.2: BAR 2: reserving [io  0x0170-0x0177 flags 0x110] (d=0, p=0)
[    0.861512] pci 0000:00:1f.2: BAR 3: reserving [io  0x0376 flags 0x110] (d=0, p=0)
[    0.861516] pci 0000:00:1f.2: BAR 4: reserving [io  0x18b0-0x18bf flags 0x40101] (d=0, p=0)
[    0.861522] pci 0000:00:1f.3: BAR 4: reserving [io  0x18c0-0x18df flags 0x40101] (d=0, p=0)
[    0.861528] pci 0000:01:00.0: BAR 0: reserving [mem 0xc0000000-0xcfffffff flags 0x42208] (d=0, p=0)
[    0.861532] pci 0000:01:00.0: BAR 1: reserving [io  0x2000-0x20ff flags 0x40101] (d=0, p=0)
[    0.861536] pci 0000:01:00.0: BAR 2: reserving [mem 0xd0200000-0xd020ffff flags 0x40200] (d=0, p=0)
[    0.861552] pci 0000:0a:09.0: BAR 0: reserving [mem 0xd0400000-0xd0400fff flags 0x40200] (d=0, p=0)
[    0.861617] pci 0000:0a:09.4: BAR 1: reserving [mem 0xd0403000-0xd04037ff flags 0x40200] (d=1, p=1)
[    0.861623] reserve RAM buffer: 000000000009e000 - 000000000009ffff 
[    0.861627] reserve RAM buffer: 000000007fe80000 - 000000007fffffff 
[    0.861747] NetLabel: Initializing
[    0.861792] NetLabel:  domain hash size = 128
[    0.861838] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.861896] NetLabel:  unlabeled traffic allowed by default
[    0.861957] HPET: 3 timers in total, 0 timers will be used for per-cpu timer
[    0.861957] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.861957] hpet0: 3 comparators, 64-bit 14.318180 MHz counter
[    0.868073] Switching to clocksource hpet
[    0.877988] AppArmor: AppArmor Filesystem Enabled
[    0.878074] pnp: PnP ACPI init
[    0.878138] ACPI: bus type pnp registered
[    0.878535] pnp 00:00: [bus 00-ff]
[    0.878539] pnp 00:00: [io  0x0000-0x0cf7 window]
[    0.878542] pnp 00:00: [io  0x0cf8-0x0cff]
[    0.878544] pnp 00:00: [io  0x0d00-0xffff window]
[    0.878548] pnp 00:00: [mem 0x000a0000-0x000bffff window]
[    0.878551] pnp 00:00: [mem 0x000c0000-0x000c3fff window]
[    0.878554] pnp 00:00: [mem 0x000c4000-0x000c7fff window]
[    0.878557] pnp 00:00: [mem 0x000c8000-0x000cbfff window]
[    0.878560] pnp 00:00: [mem 0x000cc000-0x000cffff window]
[    0.878563] pnp 00:00: [mem 0x000d0000-0x000d3fff window]
[    0.878566] pnp 00:00: [mem 0x000d4000-0x000d7fff window]
[    0.878569] pnp 00:00: [mem 0x000d8000-0x000dbfff window]
[    0.878572] pnp 00:00: [mem 0x000dc000-0x000dffff window]
[    0.878575] pnp 00:00: [mem 0x000e0000-0x000e3fff window]
[    0.878578] pnp 00:00: [mem 0x000e4000-0x000e7fff window]
[    0.878581] pnp 00:00: [mem 0x000e8000-0x000ebfff window]
[    0.878584] pnp 00:00: [mem 0x000ec000-0x000effff window]
[    0.878587] pnp 00:00: [mem 0x000f0000-0x000fffff window]
[    0.878590] pnp 00:00: [mem 0x80000000-0xfebfffff window]
[    0.878593] pnp 00:00: [mem 0xfed40000-0xfed44fff window]
[    0.878676] pnp 00:00: Plug and Play ACPI device, IDs PNP0a08 PNP0a03 (active)
[    0.878698] pnp 00:01: [mem 0xe0000000-0xefffffff]
[    0.878702] pnp 00:01: [mem 0xfed14000-0xfed17fff]
[    0.878704] pnp 00:01: [mem 0xfed18000-0xfed18fff]
[    0.878707] pnp 00:01: [mem 0xfed19000-0xfed19fff]
[    0.878710] pnp 00:01: [mem 0xfed1c000-0xfed1ffff]
[    0.878713] pnp 00:01: [mem 0xfed20000-0xfed3ffff]
[    0.878716] pnp 00:01: [mem 0xfed45000-0xfed8ffff]
[    0.878718] pnp 00:01: [mem 0xb0501000-0xb0502fff]
[    0.878721] pnp 00:01: [mem 0xf2bfe100-0xf2bfe7ff]
[    0.878785] system 00:01: [mem 0xe0000000-0xefffffff] has been reserved
[    0.878835] system 00:01: [mem 0xfed14000-0xfed17fff] has been reserved
[    0.878885] system 00:01: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.878935] system 00:01: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.878985] system 00:01: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.879034] system 00:01: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.879084] system 00:01: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.879133] system 00:01: [mem 0xb0501000-0xb0502fff] has been reserved
[    0.879182] system 00:01: [mem 0xf2bfe100-0xf2bfe7ff] has been reserved
[    0.879233] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.879458] pnp 00:02: [io  0x0000-0x001f]
[    0.879461] pnp 00:02: [io  0x0081-0x0091]
[    0.879464] pnp 00:02: [io  0x0093-0x009f]
[    0.879466] pnp 00:02: [io  0x00c0-0x00df]
[    0.879470] pnp 00:02: [dma 4]
[    0.879516] pnp 00:02: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.879594] pnp 00:03: [irq 0 disabled]
[    0.879608] pnp 00:03: [irq 8]
[    0.879611] pnp 00:03: [mem 0xfed00000-0xfed003ff]
[    0.879675] system 00:03: [mem 0xfed00000-0xfed003ff] has been reserved
[    0.879726] system 00:03: Plug and Play ACPI device, IDs PNP0103 PNP0c01 (active)
[    0.879740] pnp 00:04: [io  0x00f0]
[    0.879747] pnp 00:04: [irq 13]
[    0.879791] pnp 00:04: Plug and Play ACPI device, IDs PNP0c04 (active)
[    0.879805] pnp 00:05: [io  0x002e-0x002f]
[    0.879808] pnp 00:05: [io  0x0061]
[    0.879810] pnp 00:05: [io  0x0063]
[    0.879813] pnp 00:05: [io  0x0065]
[    0.879815] pnp 00:05: [io  0x0067]
[    0.879818] pnp 00:05: [io  0x0068-0x006f]
[    0.879820] pnp 00:05: [io  0x0080]
[    0.879823] pnp 00:05: [io  0x0092]
[    0.879825] pnp 00:05: [io  0x00b2-0x00b3]
[    0.879828] pnp 00:05: [io  0x0800-0x080f]
[    0.879831] pnp 00:05: [io  0x1000-0x107f]
[    0.879833] pnp 00:05: [io  0x1180-0x11bf]
[    0.879836] pnp 00:05: [io  0x1600-0x166f]
[    0.879841] pnp 00:05: [io  0xfe10-0xfe11]
[    0.879844] pnp 00:05: [io  0xfe00]
[    0.879917] system 00:05: [io  0x0800-0x080f] has been reserved
[    0.879967] system 00:05: [io  0x1000-0x107f] has been reserved
[    0.880040] system 00:05: [io  0x1180-0x11bf] has been reserved
[    0.880088] system 00:05: [io  0x1600-0x166f] has been reserved
[    0.880137] system 00:05: [io  0xfe10-0xfe11] has been reserved
[    0.880186] system 00:05: [io  0xfe00] has been reserved
[    0.880235] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.880261] pnp 00:06: [io  0x0070-0x0077]
[    0.880306] pnp 00:06: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.880514] pnp 00:07: [io  0x02f8-0x02ff]
[    0.880521] pnp 00:07: [irq 3]
[    0.880524] pnp 00:07: [dma 1]
[    0.880650] pnp 00:07: Plug and Play ACPI device, IDs NSC6001 (active)
[    0.880816] pnp 00:08: [io  0x03f8-0x03ff]
[    0.880823] pnp 00:08: [irq 4]
[    0.880912] pnp 00:08: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.881151] pnp 00:09: [io  0x0378-0x037f]
[    0.881154] pnp 00:09: [io  0x0778-0x077f]
[    0.881161] pnp 00:09: [irq 7]
[    0.881163] pnp 00:09: [dma 3]
[    0.881277] pnp 00:09: Plug and Play ACPI device, IDs PNP0401 (active)
[    0.881487] pnp 00:0a: [io  0x0060]
[    0.881489] pnp 00:0a: [io  0x0064]
[    0.881496] pnp 00:0a: [irq 1]
[    0.881544] pnp 00:0a: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.881559] pnp 00:0b: [irq 12]
[    0.881608] pnp 00:0b: Plug and Play ACPI device, IDs SYN1003 SYN1000 SYN0002 PNP0f13 (active)
[    0.881812] pnp: PnP ACPI: found 12 devices
[    0.881858] ACPI: ACPI bus type pnp unregistered
[    0.881906] PnPBIOS: Disabled by ACPI PNP
[    0.919589] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 02-02] add_size 1000
[    0.919595] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 02-02] add_size 200000
[    0.919600] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff] to [bus 02-02] add_size 200000
[    0.919618] pci 0000:00:1c.1: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 03-03] add_size 200000
[    0.919622] pci 0000:00:1c.1: bridge window [mem 0x00100000-0x002fffff] to [bus 03-03] add_size 200000
[    0.919639] pci 0000:00:1c.2: bridge window [io  0x1000-0x0fff] to [bus 04-04] add_size 1000
[    0.919644] pci 0000:00:1c.2: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 04-04] add_size 200000
[    0.919648] pci 0000:00:1c.2: bridge window [mem 0x00100000-0x000fffff] to [bus 04-04] add_size 200000
[    0.919665] pci 0000:00:1c.3: bridge window [io  0x1000-0x0fff] to [bus 05-05] add_size 1000
[    0.919669] pci 0000:00:1c.3: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 05-05] add_size 200000
[    0.919674] pci 0000:00:1c.3: bridge window [mem 0x00100000-0x001fffff] to [bus 05-05] add_size 200000
[    0.919691] pci 0000:00:1c.4: bridge window [io  0x1000-0x0fff] to [bus 06-06] add_size 1000
[    0.919695] pci 0000:00:1c.4: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 06-06] add_size 200000
[    0.919699] pci 0000:00:1c.4: bridge window [mem 0x00100000-0x000fffff] to [bus 06-06] add_size 200000
[    0.919716] pci 0000:00:1c.5: bridge window [io  0x1000-0x0fff] to [bus 07-09] add_size 1000
[    0.919720] pci 0000:00:1c.5: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 07-09] add_size 200000
[    0.919725] pci 0000:00:1c.5: bridge window [mem 0x00100000-0x000fffff] to [bus 07-09] add_size 200000
[    0.919756] pci 0000:0a:09.0: res[13]=[io  0x0100-0x00ff] get_res_add_size add_size 100
[    0.919760] pci 0000:0a:09.0: res[14]=[io  0x0100-0x00ff] get_res_add_size add_size 100
[    0.919764] pci 0000:0a:09.1: res[13]=[io  0x0100-0x00ff] get_res_add_size add_size 100
[    0.919767] pci 0000:0a:09.1: res[14]=[io  0x0100-0x00ff] get_res_add_size add_size 100
[    0.919771] pci 0000:00:1e.0: bridge window [io  0x1000-0x0fff] to [bus 0a-0b] add_size 1000
[    0.919775] pci 0000:0a:09.0: res[15]=[mem 0x04000000-0x03ffffff pref] get_res_add_size add_size 4000000
[    0.919780] pci 0000:0a:09.1: res[15]=[mem 0x04000000-0x03ffffff pref] get_res_add_size add_size 4000000
[    0.919784] pci 0000:00:1e.0: bridge window [mem 0x04000000-0x03ffffff pref] to [bus 0a-0b] add_size 8000000
[    0.919798] pci 0000:00:1e.0: res[15]=[mem 0x04000000-0x03ffffff pref] get_res_add_size add_size 8000000
[    0.919802] pci 0000:00:1c.0: res[14]=[mem 0x00100000-0x000fffff] get_res_add_size add_size 200000
[    0.919806] pci 0000:00:1c.0: res[15]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 200000
[    0.919810] pci 0000:00:1c.1: res[14]=[mem 0x00100000-0x002fffff] get_res_add_size add_size 200000
[    0.919814] pci 0000:00:1c.1: res[15]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 200000
[    0.919818] pci 0000:00:1c.2: res[14]=[mem 0x00100000-0x000fffff] get_res_add_size add_size 200000
[    0.919822] pci 0000:00:1c.2: res[15]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 200000
[    0.919826] pci 0000:00:1c.3: res[14]=[mem 0x00100000-0x001fffff] get_res_add_size add_size 200000
[    0.919830] pci 0000:00:1c.3: res[15]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 200000
[    0.919834] pci 0000:00:1c.4: res[14]=[mem 0x00100000-0x000fffff] get_res_add_size add_size 200000
[    0.919838] pci 0000:00:1c.4: res[15]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 200000
[    0.919842] pci 0000:00:1c.5: res[14]=[mem 0x00100000-0x000fffff] get_res_add_size add_size 200000
[    0.919846] pci 0000:00:1c.5: res[15]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 200000
[    0.919850] pci 0000:00:1c.0: res[13]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
[    0.919854] pci 0000:00:1c.2: res[13]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
[    0.919857] pci 0000:00:1c.3: res[13]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
[    0.919861] pci 0000:00:1c.4: res[13]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
[    0.919864] pci 0000:00:1c.5: res[13]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
[    0.919868] pci 0000:00:1e.0: res[13]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
[    0.919875] pci 0000:00:1e.0: BAR 15: assigned [mem 0x80000000-0x87ffffff pref]
[    0.919932] pci 0000:00:1c.0: BAR 14: assigned [mem 0x88000000-0x881fffff]
[    0.919982] pci 0000:00:1c.0: BAR 15: assigned [mem 0x88200000-0x883fffff 64bit pref]
[    0.920055] pci 0000:00:1c.1: BAR 14: assigned [mem 0x88400000-0x887fffff]
[    0.920105] pci 0000:00:1c.1: BAR 15: assigned [mem 0x88800000-0x889fffff 64bit pref]
[    0.920162] pci 0000:00:1c.2: BAR 14: assigned [mem 0x88a00000-0x88bfffff]
[    0.920212] pci 0000:00:1c.2: BAR 15: assigned [mem 0x88c00000-0x88dfffff 64bit pref]
[    0.920268] pci 0000:00:1c.3: BAR 14: assigned [mem 0x88e00000-0x890fffff]
[    0.920318] pci 0000:00:1c.3: BAR 15: assigned [mem 0x89100000-0x892fffff 64bit pref]
[    0.920375] pci 0000:00:1c.4: BAR 14: assigned [mem 0x89300000-0x894fffff]
[    0.920425] pci 0000:00:1c.4: BAR 15: assigned [mem 0x89500000-0x896fffff 64bit pref]
[    0.920481] pci 0000:00:1c.5: BAR 14: assigned [mem 0x89700000-0x898fffff]
[    0.920532] pci 0000:00:1c.5: BAR 15: assigned [mem 0x89900000-0x89afffff 64bit pref]
[    0.920589] pci 0000:00:1c.0: BAR 13: assigned [io  0x3000-0x3fff]
[    0.920639] pci 0000:00:1c.1: BAR 13: assigned [io  0x4000-0x4fff]
[    0.920688] pci 0000:00:1c.2: BAR 13: assigned [io  0x5000-0x5fff]
[    0.920737] pci 0000:00:1c.3: BAR 13: assigned [io  0x6000-0x6fff]
[    0.920787] pci 0000:00:1c.4: BAR 13: assigned [io  0x7000-0x7fff]
[    0.920836] pci 0000:00:1c.5: BAR 13: assigned [io  0x8000-0x8fff]
[    0.920886] pci 0000:00:1e.0: BAR 13: assigned [io  0x9000-0x9fff]
[    0.920939] pci 0000:01:00.0: BAR 6: assigned [mem 0xd0220000-0xd023ffff pref]
[    0.920994] pci 0000:00:01.0: PCI bridge to [bus 01-01]
[    0.921042] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    0.921092] pci 0000:00:01.0:   bridge window [mem 0xd0200000-0xd02fffff]
[    0.921143] pci 0000:00:01.0:   bridge window [mem 0xc0000000-0xcfffffff 64bit pref]
[    0.921202] pci 0000:00:1c.0: PCI bridge to [bus 02-02]
[    0.921250] pci 0000:00:1c.0:   bridge window [io  0x3000-0x3fff]
[    0.921303] pci 0000:00:1c.0:   bridge window [mem 0x88000000-0x881fffff]
[    0.921355] pci 0000:00:1c.0:   bridge window [mem 0x88200000-0x883fffff 64bit pref]
[    0.921418] pci 0000:03:00.0: BAR 1: assigned [mem 0x88400000-0x884fffff]
[    0.921473] pci 0000:03:00.0: BAR 1: set to [mem 0x88400000-0x884fffff] (PCI address [0x88400000-0x884fffff])
[    0.921477] pci 0000:03:00.0: BAR 0: assigned [mem 0x88500000-0x8851ffff]
[    0.921532] pci 0000:03:00.0: BAR 0: set to [mem 0x88500000-0x8851ffff] (PCI address [0x88500000-0x8851ffff])
[    0.921536] pci 0000:03:00.0: BAR 2: assigned [io  0x4000-0x401f]
[    0.921590] pci 0000:03:00.0: BAR 2: set to [io  0x4000-0x401f] (PCI address [0x4000-0x401f])
[    0.921594] pci 0000:00:1c.1: PCI bridge to [bus 03-03]
[    0.921643] pci 0000:00:1c.1:   bridge window [io  0x4000-0x4fff]
[    0.921695] pci 0000:00:1c.1:   bridge window [mem 0x88400000-0x887fffff]
[    0.921747] pci 0000:00:1c.1:   bridge window [mem 0x88800000-0x889fffff 64bit pref]
[    0.921809] pci 0000:00:1c.2: PCI bridge to [bus 04-04]
[    0.921858] pci 0000:00:1c.2:   bridge window [io  0x5000-0x5fff]
[    0.921910] pci 0000:00:1c.2:   bridge window [mem 0x88a00000-0x88bfffff]
[    0.921962] pci 0000:00:1c.2:   bridge window [mem 0x88c00000-0x88dfffff 64bit pref]
[    0.922024] pci 0000:05:00.0: BAR 0: assigned [mem 0x88e00000-0x88e00fff]
[    0.922085] pci 0000:05:00.0: BAR 0: set to [mem 0x88e00000-0x88e00fff] (PCI address [0x88e00000-0x88e00fff])
[    0.922089] pci 0000:00:1c.3: PCI bridge to [bus 05-05]
[    0.922138] pci 0000:00:1c.3:   bridge window [io  0x6000-0x6fff]
[    0.922191] pci 0000:00:1c.3:   bridge window [mem 0x88e00000-0x890fffff]
[    0.922242] pci 0000:00:1c.3:   bridge window [mem 0x89100000-0x892fffff 64bit pref]
[    0.922303] pci 0000:00:1c.4: PCI bridge to [bus 06-06]
[    0.922352] pci 0000:00:1c.4:   bridge window [io  0x7000-0x7fff]
[    0.922404] pci 0000:00:1c.4:   bridge window [mem 0x89300000-0x894fffff]
[    0.922456] pci 0000:00:1c.4:   bridge window [mem 0x89500000-0x896fffff 64bit pref]
[    0.922517] pci 0000:00:1c.5: PCI bridge to [bus 07-09]
[    0.922566] pci 0000:00:1c.5:   bridge window [io  0x8000-0x8fff]
[    0.922618] pci 0000:00:1c.5:   bridge window [mem 0x89700000-0x898fffff]
[    0.922670] pci 0000:00:1c.5:   bridge window [mem 0x89900000-0x89afffff 64bit pref]
[    0.922735] pci 0000:0a:09.0: res[15]=[mem 0x04000000-0x03ffffff pref] get_res_add_size add_size 4000000
[    0.922740] pci 0000:0a:09.0: res[16]=[mem 0x04000000-0x03ffffff] get_res_add_size add_size 4000000
[    0.922743] pci 0000:0a:09.1: res[15]=[mem 0x04000000-0x03ffffff pref] get_res_add_size add_size 4000000
[    0.922747] pci 0000:0a:09.1: res[16]=[mem 0x04000000-0x03ffffff] get_res_add_size add_size 4000000
[    0.922751] pci 0000:0a:09.0: res[13]=[io  0x0100-0x00ff] get_res_add_size add_size 100
[    0.922755] pci 0000:0a:09.0: res[14]=[io  0x0100-0x00ff] get_res_add_size add_size 100
[    0.922758] pci 0000:0a:09.1: res[13]=[io  0x0100-0x00ff] get_res_add_size add_size 100
[    0.922762] pci 0000:0a:09.1: res[14]=[io  0x0100-0x00ff] get_res_add_size add_size 100
[    0.922766] pci 0000:0a:09.0: BAR 15: assigned [mem 0x80000000-0x83ffffff pref]
[    0.922822] pci 0000:0a:09.0: BAR 16: assigned [mem 0x8c000000-0x8fffffff]
[    0.922872] pci 0000:0a:09.1: BAR 0: assigned [mem 0x90000000-0x90000fff]
[    0.922926] pci 0000:0a:09.1: BAR 0: set to [mem 0x90000000-0x90000fff] (PCI address [0x90000000-0x90000fff])
[    0.922930] pci 0000:0a:09.1: BAR 15: assigned [mem 0x84000000-0x87ffffff pref]
[    0.922986] pci 0000:0a:09.1: BAR 16: assigned [mem 0x94000000-0x97ffffff]
[    0.923036] pci 0000:0a:09.4: BAR 0: assigned [mem 0xd0401000-0xd0401fff]
[    0.923088] pci 0000:0a:09.4: BAR 0: set to [mem 0xd0401000-0xd0401fff] (PCI address [0xd0401000-0xd0401fff])
[    0.923092] pci 0000:0a:09.0: BAR 13: assigned [io  0x9000-0x90ff]
[    0.923141] pci 0000:0a:09.0: BAR 14: assigned [io  0x9400-0x94ff]
[    0.923189] pci 0000:0a:09.1: BAR 13: assigned [io  0x9800-0x98ff]
[    0.923237] pci 0000:0a:09.1: BAR 14: assigned [io  0x9c00-0x9cff]
[    0.923287] pci 0000:0a:09.0: CardBus bridge to [bus 0b-0e]
[    0.924088] pci 0000:0a:09.0:   bridge window [io  0x9000-0x90ff]
[    0.924140] pci 0000:0a:09.0:   bridge window [io  0x9400-0x94ff]
[    0.924191] pci 0000:0a:09.0:   bridge window [mem 0x80000000-0x83ffffff pref]
[    0.924250] pci 0000:0a:09.0:   bridge window [mem 0x8c000000-0x8fffffff]
[    0.924302] pci 0000:0a:09.1: CardBus bridge to [bus 0f-12]
[    0.924350] pci 0000:0a:09.1:   bridge window [io  0x9800-0x98ff]
[    0.924401] pci 0000:0a:09.1:   bridge window [io  0x9c00-0x9cff]
[    0.924452] pci 0000:0a:09.1:   bridge window [mem 0x84000000-0x87ffffff pref]
[    0.924511] pci 0000:0a:09.1:   bridge window [mem 0x94000000-0x97ffffff]
[    0.924562] pci 0000:00:1e.0: PCI bridge to [bus 0a-0b]
[    0.924611] pci 0000:00:1e.0:   bridge window [io  0x9000-0x9fff]
[    0.924663] pci 0000:00:1e.0:   bridge window [mem 0xd0400000-0xd04fffff]
[    0.924715] pci 0000:00:1e.0:   bridge window [mem 0x80000000-0x87ffffff pref]
[    0.924794] pci 0000:00:1c.0: enabling device (0000 -> 0003)
[    0.924850] pci 0000:00:1c.0: enabling bus mastering
[    0.924858] pci 0000:00:1c.1: enabling device (0000 -> 0003)
[    0.924908] pci 0000:00:1c.1: enabling bus mastering
[    0.924916] pci 0000:00:1c.2: enabling device (0000 -> 0003)
[    0.924969] pci 0000:00:1c.2: enabling bus mastering
[    0.924977] pci 0000:00:1c.3: enabling device (0000 -> 0003)
[    0.925030] pci 0000:00:1c.3: enabling bus mastering
[    0.925037] pci 0000:00:1c.4: enabling device (0000 -> 0003)
[    0.925087] pci 0000:00:1c.4: enabling bus mastering
[    0.925095] pci 0000:00:1c.5: enabling device (0000 -> 0003)
[    0.925145] pci 0000:00:1c.5: enabling bus mastering
[    0.925152] pci 0000:00:1e.0: enabling device (0004 -> 0007)
[    0.925203] pci 0000:00:1e.0: setting latency timer to 64
[    0.925223] pci 0000:0a:09.1: enabling device (0080 -> 0083)
[    0.925275] pci 0000:0a:09.1: enabling bus mastering
[    0.925282] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
[    0.925285] pci_bus 0000:00: resource 5 [mem 0x00000000-0xffffffff]
[    0.925289] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
[    0.925292] pci_bus 0000:01: resource 1 [mem 0xd0200000-0xd02fffff]
[    0.925295] pci_bus 0000:01: resource 2 [mem 0xc0000000-0xcfffffff 64bit pref]
[    0.925299] pci_bus 0000:02: resource 0 [io  0x3000-0x3fff]
[    0.925302] pci_bus 0000:02: resource 1 [mem 0x88000000-0x881fffff]
[    0.925305] pci_bus 0000:02: resource 2 [mem 0x88200000-0x883fffff 64bit pref]
[    0.925308] pci_bus 0000:03: resource 0 [io  0x4000-0x4fff]
[    0.925311] pci_bus 0000:03: resource 1 [mem 0x88400000-0x887fffff]
[    0.925315] pci_bus 0000:03: resource 2 [mem 0x88800000-0x889fffff 64bit pref]
[    0.925318] pci_bus 0000:04: resource 0 [io  0x5000-0x5fff]
[    0.925321] pci_bus 0000:04: resource 1 [mem 0x88a00000-0x88bfffff]
[    0.925325] pci_bus 0000:04: resource 2 [mem 0x88c00000-0x88dfffff 64bit pref]
[    0.925328] pci_bus 0000:05: resource 0 [io  0x6000-0x6fff]
[    0.925331] pci_bus 0000:05: resource 1 [mem 0x88e00000-0x890fffff]
[    0.925335] pci_bus 0000:05: resource 2 [mem 0x89100000-0x892fffff 64bit pref]
[    0.925338] pci_bus 0000:06: resource 0 [io  0x7000-0x7fff]
[    0.925341] pci_bus 0000:06: resource 1 [mem 0x89300000-0x894fffff]
[    0.925344] pci_bus 0000:06: resource 2 [mem 0x89500000-0x896fffff 64bit pref]
[    0.925348] pci_bus 0000:07: resource 0 [io  0x8000-0x8fff]
[    0.925351] pci_bus 0000:07: resource 1 [mem 0x89700000-0x898fffff]
[    0.925354] pci_bus 0000:07: resource 2 [mem 0x89900000-0x89afffff 64bit pref]
[    0.925358] pci_bus 0000:0a: resource 0 [io  0x9000-0x9fff]
[    0.925361] pci_bus 0000:0a: resource 1 [mem 0xd0400000-0xd04fffff]
[    0.925364] pci_bus 0000:0a: resource 2 [mem 0x80000000-0x87ffffff pref]
[    0.925367] pci_bus 0000:0a: resource 4 [io  0x0000-0xffff]
[    0.925370] pci_bus 0000:0a: resource 5 [mem 0x00000000-0xffffffff]
[    0.925374] pci_bus 0000:0b: resource 0 [io  0x9000-0x90ff]
[    0.925377] pci_bus 0000:0b: resource 1 [io  0x9400-0x94ff]
[    0.925380] pci_bus 0000:0b: resource 2 [mem 0x80000000-0x83ffffff pref]
[    0.925383] pci_bus 0000:0b: resource 3 [mem 0x8c000000-0x8fffffff]
[    0.925386] pci_bus 0000:0f: resource 0 [io  0x9800-0x98ff]
[    0.925389] pci_bus 0000:0f: resource 1 [io  0x9c00-0x9cff]
[    0.925393] pci_bus 0000:0f: resource 2 [mem 0x84000000-0x87ffffff pref]
[    0.925396] pci_bus 0000:0f: resource 3 [mem 0x94000000-0x97ffffff]
[    0.925450] NET: Registered protocol family 2
[    0.925571] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.925797] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.926495] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[    0.926859] TCP: Hash tables configured (established 131072 bind 65536)
[    0.926908] TCP: reno registered
[    0.926954] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.927012] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.927159] NET: Registered protocol family 1
[    0.927255] pci 0000:00:1d.0: calling quirk_usb_early_handoff+0x0/0x5fb
[    0.927302] pci 0000:00:1d.1: calling quirk_usb_early_handoff+0x0/0x5fb
[    0.927330] pci 0000:00:1d.2: calling quirk_usb_early_handoff+0x0/0x5fb
[    0.927358] pci 0000:00:1d.3: calling quirk_usb_early_handoff+0x0/0x5fb
[    0.927387] pci 0000:00:1d.7: calling quirk_usb_early_handoff+0x0/0x5fb
[    0.927438] pci 0000:01:00.0: calling pci_fixup_video+0x0/0x89
[    0.927442] pci 0000:01:00.0: Boot video device
[    0.927450] pci 0000:03:00.0: calling quirk_e100_interrupt+0x0/0x159
[    0.927468] pci 0000:0a:09.0: calling quirk_cardbus_legacy+0x0/0x30
[    0.927477] pci 0000:0a:09.1: calling quirk_cardbus_legacy+0x0/0x30
[    0.927486] PCI: CLS 64 bytes, default 64
[    0.927547] Trying to unpack rootfs image as initramfs...
[    1.431669] Freeing initrd memory: 19664k freed
[    1.443190] Simple Boot Flag at 0x36 set to 0x1
[    1.443773] audit: initializing netlink socket (disabled)
[    1.443835] type=2000 audit(1337878973.436:1): initialized
[    1.466712] highmem bounce pool size: 64 pages
[    1.466763] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[    1.468954] VFS: Disk quotas dquot_6.5.2
[    1.469063] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    1.469778] fuse init (API version 7.18)
[    1.469930] msgmni has been set to 1714
[    1.470434] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    1.470529] io scheduler noop registered
[    1.470577] io scheduler deadline registered
[    1.470628] io scheduler cfq registered (default)
[    1.470848] pcieport 0000:00:01.0: irq 40 for MSI/MSI-X
[    1.470954] pcieport 0000:00:1c.0: irq 41 for MSI/MSI-X
[    1.471084] pcieport 0000:00:1c.1: irq 42 for MSI/MSI-X
[    1.471217] pcieport 0000:00:1c.2: irq 43 for MSI/MSI-X
[    1.471346] pcieport 0000:00:1c.3: irq 44 for MSI/MSI-X
[    1.471476] pcieport 0000:00:1c.4: irq 45 for MSI/MSI-X
[    1.471609] pcieport 0000:00:1c.5: irq 46 for MSI/MSI-X
[    1.471714] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    1.471786] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    1.471895] intel_idle: does not run on family 6 model 14
[    1.488050] ACPI: Deprecated procfs I/F for AC is loaded, please retry with CONFIG_ACPI_PROCFS_POWER cleared
[    1.504048] ACPI: AC Adapter [ACAD] (off-line)
[    1.504207] input: Lid Switch as /devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input0
[    1.504297] ACPI: Lid Switch [LID]
[    1.504390] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input1
[    1.504448] ACPI: Power Button [PWRB]
[    1.504541] input: Sleep Button as /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input2
[    1.504599] ACPI: Sleep Button [SLPB]
[    1.504691] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    1.504748] ACPI: Power Button [PWRF]
[    1.504876] ACPI: Requesting acpi_cpufreq
[    1.506405] Marking TSC unstable due to TSC halts in idle
[    1.506464] ACPI: acpi_idle registered with cpuidle
[    1.568046] thermal LNXTHERM:00: registered as thermal_zone0
[    1.568094] ACPI: Thermal Zone [THRM] (71 C)
[    1.568170] isapnp: Scanning for PnP cards...
[    1.568194] ACPI: Deprecated procfs I/F for battery is loaded, please retry with CONFIG_ACPI_PROCFS_POWER cleared
[    1.568202] ACPI: Battery Slot [BAT1] (battery absent)
[    1.568225] ACPI: Deprecated procfs I/F for battery is loaded, please retry with CONFIG_ACPI_PROCFS_POWER cleared
[    1.568232] ACPI: Battery Slot [BAT2] (battery absent)
[    1.922267] isapnp: No Plug & Play device found
[    1.922377] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    1.942981] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    1.943163] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
[    1.965333] 00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    1.965706] Linux agpgart interface v0.103
[    1.967779] brd: module loaded
[    1.968786] loop: module loaded
[    1.968943] ata_piix 0000:00:1f.2: version 2.13
[    1.968962] ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
[    2.124028] ata_piix 0000:00:1f.2: setting latency timer to 64
[    2.124395] scsi0 : ata_piix
[    2.124540] scsi1 : ata_piix
[    2.124969] ata1: SATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0x18b0 irq 14
[    2.125019] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x18b8 irq 15
[    2.125475] Fixed MDIO Bus: probed
[    2.125538] tun: Universal TUN/TAP device driver, 1.6
[    2.125585] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    2.125683] PPP generic driver version 2.4.2
[    2.125843] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.125915] ehci_hcd 0000:00:1d.7: enabling bus mastering
[    2.125921] ehci_hcd 0000:00:1d.7: setting latency timer to 64
[    2.125925] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    2.126025] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
[    2.126100] ehci_hcd 0000:00:1d.7: using broken periodic workaround
[    2.126159] ehci_hcd 0000:00:1d.7: debug port 1
[    2.130072] ehci_hcd 0000:00:1d.7: cache line size of 64 is not supported
[    2.130092] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xd0704000
[    2.140020] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    2.140235] hub 1-0:1.0: USB hub found
[    2.140284] hub 1-0:1.0: 8 ports detected
[    2.140428] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.140488] uhci_hcd: USB Universal Host Controller Interface driver
[    2.140553] uhci_hcd 0000:00:1d.0: enabling bus mastering
[    2.140559] uhci_hcd 0000:00:1d.0: setting latency timer to 64
[    2.140563] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    2.140664] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    2.140747] uhci_hcd 0000:00:1d.0: irq 23, io base 0x00001800
[    2.140940] hub 2-0:1.0: USB hub found
[    2.140988] hub 2-0:1.0: 2 ports detected
[    2.141109] uhci_hcd 0000:00:1d.1: enabling bus mastering
[    2.141115] uhci_hcd 0000:00:1d.1: setting latency timer to 64
[    2.141119] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    2.141215] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
[    2.141308] uhci_hcd 0000:00:1d.1: irq 19, io base 0x00001820
[    2.141495] hub 3-0:1.0: USB hub found
[    2.141544] hub 3-0:1.0: 2 ports detected
[    2.141666] uhci_hcd 0000:00:1d.2: enabling bus mastering
[    2.141672] uhci_hcd 0000:00:1d.2: setting latency timer to 64
[    2.141676] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    2.141770] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
[    2.141863] uhci_hcd 0000:00:1d.2: irq 18, io base 0x00001840
[    2.142048] hub 4-0:1.0: USB hub found
[    2.142096] hub 4-0:1.0: 2 ports detected
[    2.142220] uhci_hcd 0000:00:1d.3: enabling bus mastering
[    2.142226] uhci_hcd 0000:00:1d.3: setting latency timer to 64
[    2.142231] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[    2.142324] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
[    2.142418] uhci_hcd 0000:00:1d.3: irq 16, io base 0x00001860
[    2.142602] hub 5-0:1.0: USB hub found
[    2.142651] hub 5-0:1.0: 2 ports detected
[    2.142835] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    2.146943] i8042: Detected active multiplexing controller, rev 1.1
[    2.147951] serio: i8042 KBD port at 0x60,0x64 irq 1
[    2.148016] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[    2.148091] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[    2.148163] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[    2.148237] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[    2.148422] mousedev: PS/2 mouse device common for all mice
[    2.148718] rtc_cmos 00:06: RTC can wake from S4
[    2.148917] rtc_cmos 00:06: rtc core: registered rtc_cmos as rtc0
[    2.148995] rtc0: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[    2.149114] device-mapper: uevent: version 1.0.3
[    2.149237] device-mapper: ioctl: 4.22.0-ioctl (2011-10-19) initialised: dm-devel@redhat.com
[    2.149325] EISA: Probing bus 0 at eisa.0
[    2.149376] Cannot allocate resource for EISA slot 1
[    2.149423] Cannot allocate resource for EISA slot 2
[    2.149470] Cannot allocate resource for EISA slot 3
[    2.149517] Cannot allocate resource for EISA slot 4
[    2.149564] Cannot allocate resource for EISA slot 5
[    2.149610] Cannot allocate resource for EISA slot 6
[    2.149656] Cannot allocate resource for EISA slot 7
[    2.149703] Cannot allocate resource for EISA slot 8
[    2.149749] EISA: Detected 0 cards.
[    2.149820] cpufreq-nforce2: No nForce2 chipset.
[    2.149914] cpuidle: using governor ladder
[    2.150027] cpuidle: using governor menu
[    2.150073] EFI Variables Facility v0.08 2004-May-17
[    2.150257] TCP: cubic registered
[    2.150426] NET: Registered protocol family 10
[    2.150706] NET: Registered protocol family 17
[    2.150767] Registering the dns_resolver key type
[    2.150899] Using IPI No-Shortcut mode
[    2.151129] PM: Hibernation image not present or could not be loaded.
[    2.151144] registered taskstats version 1
[    2.159131]   Magic number: 12:561:37
[    2.159204] bdi 7:2: hash matches
[    2.159362] rtc_cmos 00:06: setting system clock to 2012-05-24 17:02:55 UTC (1337878975)
[    2.159711] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    2.159759] EDD information not available.
[    2.180462] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input4
[    2.289263] ata1.00: ATA-7: ST9120821AS, 3.06, max UDMA/133
[    2.289600] ata1.00: 234441648 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    2.289770] ata2.00: ATAPI: MATSHITADVD-RAM UJ-850S, 1.50, max UDMA/33
[    2.304620] ata2.00: configured for UDMA/33
[    2.305816] ata1.00: configured for UDMA/133
[    2.306173] scsi 0:0:0:0: Direct-Access     ATA      ST9120821AS      3.06 PQ: 0 ANSI: 5
[    2.307129] sd 0:0:0:0: [sda] 234441648 512-byte logical blocks: (120 GB/111 GiB)
[    2.307145] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    2.307352] sd 0:0:0:0: [sda] Write Protect is off
[    2.307413] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.307485] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.309166] scsi 1:0:0:0: CD-ROM            MATSHITA DVD-RAM UJ-850S  1.50 PQ: 0 ANSI: 5
[    2.313195] sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
[    2.313252] cdrom: Uniform CD-ROM driver Revision: 3.20
[    2.313434] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    2.313557] sr 1:0:0:0: Attached scsi generic sg1 type 5
[    2.417434]  sda: sda1 sda2 < sda5 >
[    2.418042] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.418167] Freeing unused kernel memory: 692k freed
[    2.418525] Write protecting the kernel text: 5484k
[    2.418642] Write protecting the kernel read-only data: 2236k
[    2.437740] udevd[91]: starting version 175
[    2.452047] usb 1-8: new high-speed USB device number 2 using ehci_hcd
[    2.511227] wmi: Mapper loaded
[    2.523524] [drm] Initialized drm 1.1.0 20060810
[    2.524786] e1000e: Intel(R) PRO/1000 Network Driver - 1.9.5-k
[    2.524855] e1000e: Copyright(c) 1999 - 2012 Intel Corporation.
[    2.525172] e1000e 0000:03:00.0: Disabling ASPM L0s L1
[    2.525262] e1000e 0000:03:00.0: enabling device (0000 -> 0002)
[    2.525645] e1000e 0000:03:00.0: enabling bus mastering
[    2.526096] e1000e 0000:03:00.0: (unregistered net_device): Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    2.526266] e1000e 0000:03:00.0: irq 47 for MSI/MSI-X
[    2.531248] [drm] VGACON disable radeon kernel modesetting.
[    2.533226] [drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
[    2.533281] [drm] No driver support for vblank timestamp query.
[    2.533332] [drm] Initialized radeon 1.33.0 20080528 for 0000:01:00.0 on minor 0
[    2.635349] e1000e 0000:03:00.0: eth0: (PCI Express:2.5GT/s:Width x1) 00:16:36:35:70:1a
[    2.635411] e1000e 0000:03:00.0: eth0: Intel(R) PRO/1000 Network Connection
[    2.635475] e1000e 0000:03:00.0: eth0: MAC: 2, PHY: 2, PBA No: FFFFFF-0FF
[    3.902678] EXT3-fs (sda1): recovery required on readonly filesystem
[    3.902691] EXT3-fs (sda1): write access will be enabled during recovery
[    4.491814] kjournald starting.  Commit interval 5 seconds
[    4.508326] EXT3-fs (sda1): recovery complete
[    4.508341] EXT3-fs (sda1): mounted filesystem with ordered data mode
[   29.330609] Adding 4803396k swap on /dev/sda5.  Priority:-1 extents:1 across:4803396k 
[   29.370759] udevd[352]: starting version 175
[   29.742209] type=1400 audit(1337879003.079:2): apparmor="STATUS" operation="profile_load" name="/sbin/dhclient" pid=413 comm="apparmor_parser"
[   29.742756] type=1400 audit(1337879003.079:3): apparmor="STATUS" operation="profile_load" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=413 comm="apparmor_parser"
[   29.743074] type=1400 audit(1337879003.079:4): apparmor="STATUS" operation="profile_load" name="/usr/lib/connman/scripts/dhclient-script" pid=413 comm="apparmor_parser"
[   29.894521] type=1400 audit(1337879003.231:5): apparmor="STATUS" operation="profile_replace" name="/sbin/dhclient" pid=510 comm="apparmor_parser"
[   29.895068] type=1400 audit(1337879003.231:6): apparmor="STATUS" operation="profile_replace" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=510 comm="apparmor_parser"
[   29.895380] type=1400 audit(1337879003.231:7): apparmor="STATUS" operation="profile_replace" name="/usr/lib/connman/scripts/dhclient-script" pid=510 comm="apparmor_parser"
[   30.054508] lp: driver loaded but no devices found
[   30.087662] type=1400 audit(1337879003.423:8): apparmor="STATUS" operation="profile_load" name="/usr/sbin/ntpd" pid=467 comm="apparmor_parser"
[   30.273044] type=1400 audit(1337879003.611:9): apparmor="STATUS" operation="profile_replace" name="/usr/sbin/ntpd" pid=512 comm="apparmor_parser"
[   30.369158] parport_pc 00:09: reported by Plug and Play ACPI
[   30.369318] parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
[   30.464417] lp0: using parport0 (interrupt-driven).
[   30.802390] microcode: CPU0 sig=0x6e8, pf=0x20, revision=0x39
[   30.924041] microcode: CPU1 sig=0x6e8, pf=0x20, revision=0x39
[   30.926333] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[   30.987268] irda_init()
[   30.987282] NET: Registered protocol family 23
[   31.158574] nsc_ircc_pnp_probe() : From PnP, found firbase 0x2F8 ; irq 3 ; dma 1.
[   31.158612] nsc-ircc, chip->init
[   31.158626] nsc-ircc, Found chip at base=0x164e
[   31.158668] nsc-ircc, driver loaded (Dag Brattli)
[   31.159068] nsc_ircc_open(), can't get iobase of 0x2f8
[   31.159115] nsc-ircc, Found chip at base=0x164e
[   31.159155] nsc-ircc, driver loaded (Dag Brattli)
[   31.159162] nsc_ircc_open(), can't get iobase of 0x2f8
[   31.159346] nsc-ircc 00:07: disabled
[   31.393708] Linux video capture interface: v2.00
[   31.411184] psmouse serio4: synaptics: Touchpad model: 1, fw: 6.2, id: 0x12a0b1, caps: 0xa04713/0x204000/0x0
[   31.461018] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio4/input/input5
[   31.567052] ppdev: user-space parallel port driver
[   31.667197] cfg80211: Calling CRDA to update world regulatory domain
[   31.673857] cfg80211: World regulatory domain updated:
[   31.673861] cfg80211:   (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
[   31.673865] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
[   31.673869] cfg80211:   (2457000 KHz - 2482000 KHz @ 20000 KHz), (300 mBi, 2000 mBm)
[   31.673872] cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz), (300 mBi, 2000 mBm)
[   31.673875] cfg80211:   (5170000 KHz - 5250000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
[   31.673879] cfg80211:   (5735000 KHz - 5835000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
[   31.854346] EXT3-fs (sda1): warning: maximal mount count reached, running e2fsck is recommended
[   31.868833] gspca_main: v2.14.0 registered
[   31.875884] EXT3-fs (sda1): using internal journal
[   31.891819] acer_wmi: Acer Laptop ACPI-WMI Extras
[   31.892288] acer_wmi: Function bitmap for Communication Device: 0x37
[   31.911811] gspca_main: vc032x-2.14.0 probing 046d:0892
[   31.920269] usbcore: registered new interface driver vc032x
[   31.921937] intel_rng: FWH not detected
[   31.946178] yenta_cardbus 0000:0a:09.0: CardBus bridge found [1025:0092]
[   31.946207] yenta_cardbus 0000:0a:09.0: O2: enabling read prefetch/write burst. If you experience problems or performance issues, use the yenta_socket parameter 'o2_speedup=off'
[   31.985070] init: failsafe main process (782) killed by TERM signal
[   32.072884] yenta_cardbus 0000:0a:09.0: ISA IRQ mask 0x0c38, PCI irq 20
[   32.072890] yenta_cardbus 0000:0a:09.0: Socket status: 30000006
[   32.072895] pci_bus 0000:0a: Raising subordinate bus# of parent bus (#0a) from #0b to #0e
[   32.072906] yenta_cardbus 0000:0a:09.0: pcmcia: parent PCI bridge window: [io  0x9000-0x9fff]
[   32.072910] pcmcia_socket pcmcia_socket0: cs: IO port probe 0x9000-0x9fff: excluding 0x9000-0x90ff 0x9400-0x94ff 0x9800-0x98ff 0x9c00-0x9cff
[   32.080477] yenta_cardbus 0000:0a:09.0: pcmcia: parent PCI bridge window: [mem 0xd0400000-0xd04fffff]
[   32.080483] pcmcia_socket pcmcia_socket0: cs: memory probe 0xd0400000-0xd04fffff: excluding 0xd0400000-0xd040ffff
[   32.080498] yenta_cardbus 0000:0a:09.0: pcmcia: parent PCI bridge window: [mem 0x80000000-0x87ffffff pref]
[   32.080501] pcmcia_socket pcmcia_socket0: cs: memory probe 0x80000000-0x87ffffff: excluding 0x80000000-0x87ffffff
[   32.082417] yenta_cardbus 0000:0a:09.1: CardBus bridge found [1025:0092]
[   32.210185] yenta_cardbus 0000:0a:09.1: ISA IRQ mask 0x0c38, PCI irq 20
[   32.210191] yenta_cardbus 0000:0a:09.1: Socket status: 30000410
[   32.210197] pci_bus 0000:0a: Raising subordinate bus# of parent bus (#0a) from #0e to #12
[   32.210208] yenta_cardbus 0000:0a:09.1: pcmcia: parent PCI bridge window: [io  0x9000-0x9fff]
[   32.210212] pcmcia_socket pcmcia_socket1: cs: IO port probe 0x9000-0x9fff: excluding 0x9000-0x90ff 0x9400-0x94ff 0x9800-0x98ff 0x9c00-0x9cff
[   32.220255] yenta_cardbus 0000:0a:09.1: pcmcia: parent PCI bridge window: [mem 0xd0400000-0xd04fffff]
[   32.220261] pcmcia_socket pcmcia_socket1: cs: memory probe 0xd0400000-0xd04fffff: excluding 0xd0400000-0xd040ffff
[   32.220276] yenta_cardbus 0000:0a:09.1: pcmcia: parent PCI bridge window: [mem 0x80000000-0x87ffffff pref]
[   32.220280] pcmcia_socket pcmcia_socket1: cs: memory probe 0x80000000-0x87ffffff: excluding 0x80000000-0x87ffffff
[   32.471339] type=1400 audit(1337879005.807:10): apparmor="STATUS" operation="profile_load" name="/usr/lib/cups/backend/cups-pdf" pid=876 comm="apparmor_parser"
[   32.476092] type=1400 audit(1337879005.815:11): apparmor="STATUS" operation="profile_load" name="/usr/sbin/cupsd" pid=876 comm="apparmor_parser"
[   32.500531] pcmcia_socket pcmcia_socket1: cs: IO port probe 0x100-0x3af: excluding 0x170-0x177 0x1f0-0x1f7 0x2f8-0x2ff 0x370-0x37f
[   32.503191] pcmcia_socket pcmcia_socket1: cs: IO port probe 0x3e0-0x4ff: excluding 0x3f0-0x3ff
[   32.504100] pcmcia_socket pcmcia_socket0: cs: IO port probe 0x100-0x3af: excluding 0x170-0x177 0x1f0-0x1f7 0x2f8-0x2ff 0x370-0x37f
[   32.506052] pcmcia_socket pcmcia_socket0: cs: IO port probe 0x3e0-0x4ff: excluding 0x3f0-0x3ff 0x4d0-0x4d7
[   32.506852] pcmcia_socket pcmcia_socket0: cs: IO port probe 0x820-0x8ff: clean.
[   32.507527] pcmcia_socket pcmcia_socket0: cs: IO port probe 0xc00-0xcf7: 0x4d0-0x4d7
[   32.509583]  clean.
[   32.509612] pcmcia_socket pcmcia_socket0: cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xd3fff 0xe4000-0xfffff
[   32.509644] pcmcia_socket pcmcia_socket0: cs: memory probe 0xa0000000-0xa0ffffff: clean.
[   32.509678] pcmcia_socket pcmcia_socket0: cs: memory probe 0x60000000-0x60ffffff: excluding 0x60000000-0x60ffffff
[   32.509707] pcmcia_socket pcmcia_socket0: cs: IO port probe 0xa00-0xaff: clean.
[   32.962149] Bluetooth: Core ver 2.16
[   32.962176] NET: Registered protocol family 31
[   32.962179] Bluetooth: HCI device and connection manager initialized
[   32.962182] Bluetooth: HCI socket layer initialized
[   32.962184] Bluetooth: L2CAP socket layer initialized
[   32.962191] Bluetooth: SCO socket layer initialized
[   32.976600] e1000e 0000:03:00.0: irq 47 for MSI/MSI-X
[   33.047658] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   33.047662] Bluetooth: BNEP filters: protocol multicast
[   33.080169] e1000e 0000:03:00.0: irq 47 for MSI/MSI-X
[   33.080966] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   33.120038] pcmcia_socket pcmcia_socket1: pccard: PCMCIA card inserted into slot 1
[   33.120050] pcmcia_socket pcmcia_socket1: cs: memory probe 0xd0410000-0xd04fffff:
[   33.125581] pcmcia_socket pcmcia_socket1: cs: IO port probe 0x820-0x8ff: clean.
[   33.126296] pcmcia_socket pcmcia_socket1: cs: IO port probe 0xc00-0xcf7: clean.
[   33.127070] pcmcia_socket pcmcia_socket1: cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xd3fff 0xe4000-0xfffff
[   33.127103] pcmcia_socket pcmcia_socket1: cs: memory probe 0xa0000000-0xa0ffffff: clean.
[   33.127137] pcmcia_socket pcmcia_socket1: cs: memory probe 0x60000000-0x60ffffff: excluding 0x60000000-0x60ffffff
[   33.127166] pcmcia_socket pcmcia_socket1: cs: IO port probe 0xa00-0xaff: clean.
[   33.157001]  excluding 0xd04fe000-0xd050bfff
[   33.157661] pcmcia 1.0: pcmcia: registering new device pcmcia1.0 (IRQ: 3)
[   33.164031] Bluetooth: RFCOMM TTY layer initialized
[   33.164037] Bluetooth: RFCOMM socket layer initialized
[   33.164040] Bluetooth: RFCOMM ver 1.11
[   33.184594] iwl3945: Intel(R) PRO/Wireless 3945ABG/BG Network Connection driver for Linux, in-tree:s
[   33.184598] iwl3945: Copyright(c) 2003-2011 Intel Corporation
[   33.184663] iwl3945 0000:05:00.0: enabling device (0000 -> 0002)
[   33.184682] iwl3945 0000:05:00.0: enabling bus mastering
[   33.238856] iwl3945 0000:05:00.0: Tunable channels: 13 802.11bg, 23 802.11a channels
[   33.238861] iwl3945 0000:05:00.0: Detected Intel Wireless WiFi Link 3945ABG
[   33.239056] iwl3945 0000:05:00.0: irq 48 for MSI/MSI-X
[   33.239693] Registered led device: phy0-led
[   33.239728] cfg80211: Ignoring regulatory request Set by core since the driver uses its own custom regulatory domain
[   33.291362] ieee80211 phy0: Selected rate control algorithm 'iwl-3945-rs'
[   33.325160] iwl3945 0000:05:00.0: loaded firmware version 15.32.2.9
[   33.394260] ADDRCONF(NETDEV_UP): wlan0: link is not ready
[   33.476899] snd_hda_intel 0000:00:1b.0: irq 49 for MSI/MSI-X
[   33.494587] apm: BIOS not found.
[   33.573399] hda_codec: ALC883: SKU not ready 0x411111f0
[   33.599097] init: alsa-restore main process (998) terminated with status 19
[   33.648464] input: HDA Intel Line as /devices/pci0000:00/0000:00:1b.0/sound/card0/input6
[   33.648711] input: HDA Intel Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input7
[   33.648934] input: HDA Intel Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input8
[   33.779664] init: udev-fallback-graphics main process (1144) terminated with status 1
[   33.832322] init: gdm main process (1171) killed by TERM signal
[   33.854950] init: anacron main process (1042) killed by TERM signal
[   34.877984] [drm] Setting GART location based on new memory map
[   34.879920] [drm] Loading R500 Microcode
[   34.947597] [drm] Num pipes: 1
[   34.947606] [drm] writeback test succeeded in 1 usecs
[   34.981677] e1000e 0000:03:00.0: PME# enabled
[   35.248964] cfg80211: Found new beacon on frequency: 5180 MHz (Ch 36) on phy0
[   36.996076] e1000e 0000:03:00.0: BAR 0: set to [mem 0x88500000-0x8851ffff] (PCI address [0x88500000-0x8851ffff])
[   36.996095] e1000e 0000:03:00.0: BAR 1: set to [mem 0x88400000-0x884fffff] (PCI address [0x88400000-0x884fffff])
[   36.996110] e1000e 0000:03:00.0: BAR 2: set to [io  0x4000-0x401f] (PCI address [0x4000-0x401f])
[   36.996156] e1000e 0000:03:00.0: restoring config space at offset 0x3c (was 0x100, writing 0x10b)
[   36.996211] e1000e 0000:03:00.0: restoring config space at offset 0x4 (was 0x100000, writing 0x100006)
[   36.996327] e1000e 0000:03:00.0: PME# disabled
[   36.996336] e1000e 0000:03:00.0: Disabling ASPM L0s L1
[   36.996519] e1000e 0000:03:00.0: irq 47 for MSI/MSI-X
[   37.004264] e1000e 0000:03:00.0: eth0: MAC Wakeup cause - Link Status Change
[   39.461039] e1000e: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
[   39.461296] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   41.336622] wlan0: authenticate with 00:1e:e5:5b:a2:71
[   41.339678] wlan0: send auth to 00:1e:e5:5b:a2:71 (try 1/3)
[   41.341486] wlan0: authenticated
[   41.344060] wlan0: associate with 00:1e:e5:5b:a2:71 (try 1/3)
[   41.346655] wlan0: RX AssocResp from 00:1e:e5:5b:a2:71 (capab=0x431 status=0 aid=3)
[   41.346663] wlan0: associated
[   41.348157] ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
[   45.483302] [drm] Num pipes: 1
[   49.592020] eth0: no IPv6 routers present
[   52.160128] wlan0: no IPv6 routers present
[  126.327222] firewire_ohci 0000:0a:09.4: enabling device (0015 -> 0017)
[  126.500078] firewire_ohci 0000:0a:09.4: failed to set Link Power Status




-- 
Stefan Richter
-=====-===-- -=-= ==---
http://arcgraph.de/sr/
