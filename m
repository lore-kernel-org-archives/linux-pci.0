Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:59167 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073Ab2GIFjD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jul 2012 01:39:03 -0400
Received: by yenl2 with SMTP id l2so9726486yen.19
        for <linux-pci@vger.kernel.org>; Sun, 08 Jul 2012 22:39:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo5_srroOSahe3tdeD_UQVfbqe4ixZtKfVJqc7a9-j3SQg@mail.gmail.com>
References: <CAJkVMNoYYb3vpP1T5Sq3nmzpwLJUG7oRxUyX5=M9byQQjW1aew@mail.gmail.com>
	<CAErSpo6PVQdu+nRJs43TJ2fCTk4papaeVLMyHZ1KbnRDCVtd0A@mail.gmail.com>
	<CAJkVMNpZaMKm8tc+axdOBySpp68_j=EegEUOO+B=cYudsxNCgw@mail.gmail.com>
	<CAErSpo5_srroOSahe3tdeD_UQVfbqe4ixZtKfVJqc7a9-j3SQg@mail.gmail.com>
Date: Mon, 9 Jul 2012 11:09:01 +0530
Message-ID: <CAJkVMNo4MwCXY0iHwua3hR82D14dGnALGwXkujgONPQDzaRTdQ@mail.gmail.com>
Subject: Re: 64 bit address to a pcie card
From: sumit chaudhary <flyingbee.linux@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

 Hi Bjorn,

 Device is working as expected but problem is that I want to test this
 device  with real 64 bit addresses that lies above 4GB.
 is there a way to allocate addresses above 4GB range ?
 If I try to allocate BAR size more than 2GB i.e. to push allocated
 address above 4GB, I increase resource size asked from OS
 than host system stopped booting and hangs.
 I also tried enumerating PCI subsystem using kernel command line
 option pci_assign = buses, but same problem persist.
 I also tried  Increasing RAM of my system to 4 GB but still address
 allocation is in 32 bit range.

Regards,
Flyingbee.


On Thu, Jul 5, 2012 at 8:46 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [Added back cc: linux-pci so others can help, too]
>
> What exactly is the problem?  Is there a device that isn't working as expected?
>
> The device at 07:00.0 does indeed have 64-bit BARs, and they happen to
> be assigned addresses below 4GB:
>
> pci 0000:07:00.0: reg 10: [mem 0xfddff000-0xfddfffff 64bit]
> pci 0000:07:00.0: reg 18: [mem 0xbf000000-0xbfffffff 64bit pref]
> pci 0000:07:00.0: reg 20: [mem 0x40000000-0x7fffffff 64bit pref]
>
> This is perfectly normal.  The fact that the BAR supports a full
> 64-bit address doesn't mean it has to be assigned space above 4GB.
> The BIOS assigned these addresses, and Linux found no reason to change
> them, so we just left them alone.
>
> On Thu, Jul 5, 2012 at 5:29 AM, sumit chaudhary
> <flyingbee.linux@gmail.com> wrote:
>> Hi Bjorn,
>>
>> Thanks for your quick response.
>> Here are dmesg logs and lspci output on my ubuntu system(3.0.0).
>> Let me know if this information is good enough to point out issue.
>> Mean while I will try with recent kernel.
>>
>> Dmesg logs:
>>
>> [    0.000000] Initializing cgroup subsys cpuset
>> [    0.000000] Initializing cgroup subsys cpu
>> [    0.000000] Linux version 3.0.0-12-generic (buildd@crested) (gcc
>> version 4.6.1 (Ubuntu/Linaro 4.6.1-9ubuntu3) ) #20-Ubuntu SMP Fri Oct
>> 7 14:56:25 UTC 2011 (Ubuntu 3.0.0-12.20-generic 3.0.4)
>> [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-3.0.0-12-generic
>> root=UUID=4ffbaf90-4493-453d-ae3e-008a7176bfc5 ro pci=assign-busses
>> quiet splash pci=assign-busses vt.handoff=7
>> [    0.000000] KERNEL supported cpus:
>> [    0.000000]   Intel GenuineIntel
>> [    0.000000]   AMD AuthenticAMD
>> [    0.000000]   Centaur CentaurHauls
>> [    0.000000] BIOS-provided physical RAM map:
>> [    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
>> [    0.000000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
>> [    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>> [    0.000000]  BIOS-e820: 0000000000100000 - 000000003fee0000 (usable)
>> [    0.000000]  BIOS-e820: 000000003fee0000 - 000000003fee3000 (ACPI NVS)
>> [    0.000000]  BIOS-e820: 000000003fee3000 - 000000003fef0000 (ACPI data)
>> [    0.000000]  BIOS-e820: 000000003fef0000 - 000000003ff00000 (reserved)
>> [    0.000000]  BIOS-e820: 00000000f0000000 - 00000000f4000000 (reserved)
>> [    0.000000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
>> [    0.000000] NX (Execute Disable) protection: active
>> [    0.000000] DMI 2.3 present.
>> [    0.000000] DMI: System manufacturer System Product Name/M2N32-SLI
>> DELUXE, BIOS ASUS M2N32-SLI DELUXE ACPI BIOS Revision 0706 08/21/2006
>> [    0.000000] e820 update range: 0000000000000000 - 0000000000010000
>> (usable) ==> (reserved)
>> [    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
>> [    0.000000] No AGP bridge found
>> [    0.000000] last_pfn = 0x3fee0 max_arch_pfn = 0x400000000
>> [    0.000000] MTRR default type: uncachable
>> [    0.000000] MTRR fixed ranges enabled:
>> [    0.000000]   00000-9FFFF write-back
>> [    0.000000]   A0000-BFFFF uncachable
>> [    0.000000]   C0000-C7FFF write-protect
>> [    0.000000]   C8000-FFFFF uncachable
>> [    0.000000] MTRR variable ranges enabled:
>> [    0.000000]   0 base 0000000000 mask FFC0000000 write-back
>> [    0.000000]   1 base 003FF00000 mask FFFFF00000 uncachable
>> [    0.000000]   2 disabled
>> [    0.000000]   3 disabled
>> [    0.000000]   4 disabled
>> [    0.000000]   5 disabled
>> [    0.000000]   6 disabled
>> [    0.000000]   7 disabled
>> [    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
>> [    0.000000] original variable MTRRs
>> [    0.000000] reg 0, base: 0GB, range: 1GB, type WB
>> [    0.000000] reg 1, base: 1023MB, range: 1MB, type UC
>> [    0.000000] total RAM covered: 1023M
>> [    0.000000] Found optimal setting for mtrr clean up
>> [    0.000000]  gran_size: 64K  chunk_size: 2M  num_reg: 2      lose cover RAM: 0G
>> [    0.000000] New variable MTRRs
>> [    0.000000] reg 0, base: 0GB, range: 1GB, type WB
>> [    0.000000] reg 1, base: 1023MB, range: 1MB, type UC
>> [    0.000000] found SMP MP-table at [ffff8800000f5fa0] f5fa0
>> [    0.000000] initial memory mapped : 0 - 20000000
>> [    0.000000] Base memory trampoline at [ffff88000009a000] 9a000 size 20480
>> [    0.000000] init_memory_mapping: 0000000000000000-000000003fee0000
>> [    0.000000]  0000000000 - 003fe00000 page 2M
>> [    0.000000]  003fe00000 - 003fee0000 page 4k
>> [    0.000000] kernel direct mapping tables up to 3fee0000 @ 3fedd000-3fee0000
>> [    0.000000] RAMDISK: 365bc000 - 372d6000
>> [    0.000000] ACPI: RSDP 00000000000f7c70 00014 (v00 Nvidia)
>> [    0.000000] ACPI: RSDT 000000003fee3040 00030 (v01 Nvidia AWRDACPI
>> 42302E31 AWRD 00000000)
>> [    0.000000] ACPI: FACP 000000003fee30c0 00074 (v01 Nvidia AWRDACPI
>> 42302E31 AWRD 00000000)
>> [    0.000000] ACPI: DSDT 000000003fee3180 09348 (v01 NVIDIA AWRDACPI
>> 00001000 MSFT 0100000E)
>> [    0.000000] ACPI: FACS 000000003fee0000 00040
>> [    0.000000] ACPI: MCFG 000000003feec600 0003C (v01 Nvidia AWRDACPI
>> 42302E31 AWRD 00000000)
>> [    0.000000] ACPI: APIC 000000003feec540 00072 (v01 Nvidia AWRDACPI
>> 42302E31 AWRD 00000000)
>> [    0.000000] ACPI: Local APIC address 0xfee00000
>> [    0.000000] Scanning NUMA topology in Northbridge 24
>> [    0.000000] No NUMA configuration found
>> [    0.000000] Faking a node at 0000000000000000-000000003fee0000
>> [    0.000000] Initmem setup node 0 0000000000000000-000000003fee0000
>> [    0.000000]   NODE_DATA [000000003fed8000 - 000000003fedcfff]
>> [    0.000000]  [ffffea0000000000-ffffea0000dfffff] PMD ->
>> [ffff88003e600000-ffff88003f3fffff] on node 0
>> [    0.000000] Zone PFN ranges:
>> [    0.000000]   DMA      0x00000010 -> 0x00001000
>> [    0.000000]   DMA32    0x00001000 -> 0x00100000
>> [    0.000000]   Normal   empty
>> [    0.000000] Movable zone start PFN for each node
>> [    0.000000] early_node_map[2] active PFN ranges
>> [    0.000000]     0: 0x00000010 -> 0x0000009f
>> [    0.000000]     0: 0x00000100 -> 0x0003fee0
>> [    0.000000] On node 0 totalpages: 261743
>> [    0.000000]   DMA zone: 56 pages used for memmap
>> [    0.000000]   DMA zone: 5 pages reserved
>> [    0.000000]   DMA zone: 3922 pages, LIFO batch:0
>> [    0.000000]   DMA32 zone: 3525 pages used for memmap
>> [    0.000000]   DMA32 zone: 254235 pages, LIFO batch:31
>> [    0.000000] Nvidia board detected. Ignoring ACPI timer override.
>> [    0.000000] If you got timer trouble try acpi_use_timer_override
>> [    0.000000] ACPI: PM-Timer IO Port: 0x1008
>> [    0.000000] ACPI: Local APIC address 0xfee00000
>> [    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
>> [    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
>> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
>> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
>> [    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
>> [    0.000000] IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
>> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
>> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
>> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
>> [    0.000000] ACPI: IRQ9 used by override.
>> [    0.000000] ACPI: IRQ14 used by override.
>> [    0.000000] ACPI: IRQ15 used by override.
>> [    0.000000] Using ACPI (MADT) for SMP configuration information
>> [    0.000000] SMP: Allowing 2 CPUs, 1 hotplug CPUs
>> [    0.000000] nr_irqs_gsi: 40
>> [    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
>> [    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000f0000
>> [    0.000000] PM: Registered nosave memory: 00000000000f0000 - 0000000000100000
>> [    0.000000] Allocating PCI resources starting at 3ff00000 (gap:
>> 3ff00000:b0100000)
>> [    0.000000] Booting paravirtualized kernel on bare hardware
>> [    0.000000] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256
>> nr_cpu_ids:2 nr_node_ids:1
>> [    0.000000] PERCPU: Embedded 27 pages/cpu @ffff88003fc00000 s79616
>> r8192 d22784 u1048576
>> [    0.000000] pcpu-alloc: s79616 r8192 d22784 u1048576 alloc=1*2097152
>> [    0.000000] pcpu-alloc: [0] 0 1
>> [    0.000000] Built 1 zonelists in Node order, mobility grouping on.
>> Total pages: 258157
>> [    0.000000] Policy zone: DMA32
>> [    0.000000] Kernel command line:
>> BOOT_IMAGE=/boot/vmlinuz-3.0.0-12-generic
>> root=UUID=4ffbaf90-4493-453d-ae3e-008a7176bfc5 ro pci=assign-busses
>> quiet splash pci=assign-busses vt.handoff=7
>> [    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
>> [    0.000000] Checking aperture...
>> [    0.000000] No AGP bridge found
>> [    0.000000] Node 0: aperture @ f1c000000 size 32 MB
>> [    0.000000] Aperture beyond 4GB. Ignoring.
>> [    0.000000] Memory: 1005520k/1047424k available (6104k kernel code,
>> 452k absent, 41452k reserved, 4880k data, 984k init)
>> [    0.000000] SLUB: Genslabs=15, HWalign=64, Order=0-3, MinObjects=0,
>> CPUs=2, Nodes=1
>> [    0.000000] Hierarchical RCU implementation.
>> [    0.000000]  RCU dyntick-idle grace-period acceleration is enabled.
>> [    0.000000] NR_IRQS:16640 nr_irqs:512 16
>> [    0.000000] spurious 8259A interrupt: IRQ7.
>> [    0.000000] vt handoff: transparent VT on vt#7
>> [    0.000000] Console: colour dummy device 80x25
>> [    0.000000] console [tty0] enabled
>> [    0.000000] allocated 8388608 bytes of page_cgroup
>> [    0.000000] please try 'cgroup_disable=memory' option if you don't
>> want memory cgroups
>> [    0.000000] Fast TSC calibration using PIT
>> [    0.000000] Detected 2009.142 MHz processor.
>> [    0.000000] Marking TSC unstable due to TSCs unsynchronized
>> [    0.008007] Calibrating delay loop (skipped), value calculated
>> using timer frequency.. 4018.28 BogoMIPS (lpj=8036568)
>> [    0.008012] pid_max: default: 32768 minimum: 301
>> [    0.008049] Security Framework initialized
>> [    0.008074] AppArmor: AppArmor initialized
>> [    0.008075] Yama: becoming mindful.
>> [    0.008268] Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
>> [    0.012494] Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
>> [    0.012882] Mount-cache hash table entries: 256
>> [    0.013068] Initializing cgroup subsys cpuacct
>> [    0.013075] Initializing cgroup subsys memory
>> [    0.013086] Initializing cgroup subsys devices
>> [    0.013089] Initializing cgroup subsys freezer
>> [    0.013091] Initializing cgroup subsys net_cls
>> [    0.013094] Initializing cgroup subsys blkio
>> [    0.013102] Initializing cgroup subsys perf_event
>> [    0.013141] tseg: 003ff00000
>> [    0.013144] mce: CPU supports 5 MCE banks
>> [    0.013159] using AMD E400 aware idle routine
>> [    0.013197] SMP alternatives: switching to UP code
>> [    0.021136] ACPI: Core revision 20110413
>> [    0.028014] ftrace: allocating 25651 entries in 101 pages
>> [    0.032637] ..TIMER: vector=0x30 apic1=0 pin1=0 apic2=-1 pin2=-1
>> [    0.073689] CPU0: AMD Athlon(tm) 64 Processor 3200+ stepping 02
>> [    0.076004] Performance Events: AMD PMU driver.
>> [    0.076004] ... version:                0
>> [    0.076004] ... bit width:              48
>> [    0.076004] ... generic registers:      4
>> [    0.076004] ... value mask:             0000ffffffffffff
>> [    0.076004] ... max period:             00007fffffffffff
>> [    0.076004] ... fixed-purpose events:   0
>> [    0.076004] ... event mask:             000000000000000f
>> [    0.076004] Brought up 1 CPUs
>> [    0.076004] Total of 1 processors activated (4018.28 BogoMIPS).
>> [    0.076004] devtmpfs: initialized
>> [    0.076004] PM: Registering ACPI NVS region at 3fee0000 (12288 bytes)
>> [    0.076004] print_constraints: dummy:
>> [    0.076004] Time: 10:15:27  Date: 07/05/12
>> [    0.076004] NET: Registered protocol family 16
>> [    0.076004] node 0 link 0: io port [8000, ffff]
>> [    0.076004] TOM: 0000000040000000 aka 1024M
>> [    0.076004] node 0 link 0: mmio [a0000, bffff]
>> [    0.076004] node 0 link 0: mmio [40000000, efffffff]
>> [    0.076004] node 0 link 0: mmio [f4000000, fe02ffff]
>> [    0.076004] node 0 link 0: mmio [f0000000, f07fffff]
>> [    0.076004] bus: [00, 07] on node 0 link 0
>> [    0.076004] bus: 00 index 0 [io  0x0000-0xffff]
>> [    0.076004] bus: 00 index 1 [mem 0x000a0000-0x000bffff]
>> [    0.076004] bus: 00 index 2 [mem 0x40000000-0xf3ffffff]
>> [    0.076004] bus: 00 index 3 [mem 0xf4000000-0xfcffffffff]
>> [    0.076004] ACPI: bus type pci registered
>> [    0.076004] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem
>> 0xf0000000-0xf3ffffff] (base 0xf0000000)
>> [    0.076004] PCI: MMCONFIG at [mem 0xf0000000-0xf3ffffff] reserved in E820
>> [    0.080216] PCI: Using configuration type 1 for base access
>> [    0.081104] bio: create slab <bio-0> at 0
>> [    0.083134] ACPI: EC: Look up EC in DSDT
>> [    0.091179] ACPI: Interpreter enabled
>> [    0.091185] ACPI: (supports S0 S1 S3 S4 S5)
>> [    0.091211] ACPI: Using IOAPIC for interrupt routing
>> [    0.099460] ACPI: No dock devices found.
>> [    0.099465] HEST: Table not found.
>> [    0.099470] PCI: Ignoring host bridge windows from ACPI; if
>> necessary, use "pci=use_crs" and report a bug
>> [    0.100096] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-07])
>> [    0.101293] pci_root PNP0A08:00: host bridge window [io
>> 0x0000-0x03af] (ignored)
>> [    0.101297] pci_root PNP0A08:00: host bridge window [io
>> 0x03e0-0x0cf7] (ignored)
>> [    0.101300] pci_root PNP0A08:00: host bridge window [io
>> 0x1c00-0x1c7f] (ignored)
>> [    0.101303] pci_root PNP0A08:00: host bridge window [io
>> 0x8000-0xffff] (ignored)
>> [    0.101306] pci_root PNP0A08:00: host bridge window [io
>> 0x03b0-0x03df] (ignored)
>> [    0.101309] pci_root PNP0A08:00: host bridge window [mem
>> 0x000a0000-0x000bffff] (ignored)
>> [    0.101312] pci_root PNP0A08:00: host bridge window [mem
>> 0x40000000-0xefffffff] (ignored)
>> [    0.101315] pci_root PNP0A08:00: host bridge window [mem
>> 0xf4000000-0xfe02ffff] (ignored)
>> [    0.101318] pci_root PNP0A08:00: host bridge window [mem
>> 0xfec80000-0xfecbffff] (ignored)
>> [    0.101331] pci 0000:00:00.0: [10de:02f4] type 0 class 0x000500
>> [    0.101378] pci 0000:00:00.1: [10de:02fa] type 0 class 0x000500
>> [    0.101408] pci 0000:00:00.2: [10de:02fe] type 0 class 0x000500
>> [    0.101447] pci 0000:00:00.3: [10de:02f8] type 0 class 0x000500
>> [    0.101484] pci 0000:00:00.4: [10de:02f9] type 0 class 0x000500
>> [    0.101523] pci 0000:00:00.5: [10de:02ff] type 0 class 0x000500
>> [    0.101557] pci 0000:00:00.6: [10de:027f] type 0 class 0x000500
>> [    0.101590] pci 0000:00:00.7: [10de:027e] type 0 class 0x000500
>> [    0.101633] pci 0000:00:03.0: [10de:02fd] type 1 class 0x000604
>> [    0.101658] pci 0000:00:03.0: PME# supported from D0 D1 D2 D3hot D3cold
>> [    0.101661] pci 0000:00:03.0: PME# disabled
>> [    0.101677] pci 0000:00:04.0: [10de:02fb] type 1 class 0x000604
>> [    0.101699] pci 0000:00:04.0: PME# supported from D0 D1 D2 D3hot D3cold
>> [    0.101702] pci 0000:00:04.0: PME# disabled
>> [    0.101734] pci 0000:00:08.0: [10de:0369] type 0 class 0x000500
>> [    0.101904] pci 0000:00:09.0: [10de:0360] type 0 class 0x000601
>> [    0.101939] HPET not enabled in BIOS. You might try hpet=force boot option
>> [    0.101957] pci 0000:00:09.1: [10de:0368] type 0 class 0x000c05
>> [    0.101973] pci 0000:00:09.1: reg 10: [io  0xfc00-0xfc3f]
>> [    0.101996] pci 0000:00:09.1: reg 20: [io  0x1c00-0x1c3f]
>> [    0.102003] pci 0000:00:09.1: reg 24: [io  0x1c40-0x1c7f]
>> [    0.102029] pci 0000:00:09.1: PME# supported from D3hot D3cold
>> [    0.102035] pci 0000:00:09.1: PME# disabled
>> [    0.102050] pci 0000:00:09.2: [10de:036a] type 0 class 0x000500
>> [    0.102109] pci 0000:00:0a.0: [10de:036c] type 0 class 0x000c03
>> [    0.102121] pci 0000:00:0a.0: reg 10: [mem 0xfe02f000-0xfe02ffff]
>> [    0.102159] pci 0000:00:0a.0: supports D1 D2
>> [    0.102162] pci 0000:00:0a.0: PME# supported from D0 D1 D2 D3hot D3cold
>> [    0.102166] pci 0000:00:0a.0: PME# disabled
>> [    0.102183] pci 0000:00:0a.1: [10de:036d] type 0 class 0x000c03
>> [    0.102195] pci 0000:00:0a.1: reg 10: [mem 0xfe02e000-0xfe02e0ff]
>> [    0.102234] pci 0000:00:0a.1: supports D1 D2
>> [    0.102236] pci 0000:00:0a.1: PME# supported from D0 D1 D2 D3hot D3cold
>> [    0.102240] pci 0000:00:0a.1: PME# disabled
>> [    0.102262] pci 0000:00:0c.0: [10de:036e] type 0 class 0x000101
>> [    0.102287] pci 0000:00:0c.0: reg 20: [io  0xf000-0xf00f]
>> [    0.102320] pci 0000:00:0d.0: [10de:037f] type 0 class 0x000101
>> [    0.102333] pci 0000:00:0d.0: reg 10: [io  0x09f0-0x09f7]
>> [    0.102339] pci 0000:00:0d.0: reg 14: [io  0x0bf0-0x0bf3]
>> [    0.102345] pci 0000:00:0d.0: reg 18: [io  0x0970-0x0977]
>> [    0.102352] pci 0000:00:0d.0: reg 1c: [io  0x0b70-0x0b73]
>> [    0.102358] pci 0000:00:0d.0: reg 20: [io  0xdc00-0xdc0f]
>> [    0.102365] pci 0000:00:0d.0: reg 24: [mem 0xfe02d000-0xfe02dfff]
>> [    0.102401] pci 0000:00:0d.1: [10de:037f] type 0 class 0x000101
>> [    0.102414] pci 0000:00:0d.1: reg 10: [io  0x09e0-0x09e7]
>> [    0.102420] pci 0000:00:0d.1: reg 14: [io  0x0be0-0x0be3]
>> [    0.102427] pci 0000:00:0d.1: reg 18: [io  0x0960-0x0967]
>> [    0.102433] pci 0000:00:0d.1: reg 1c: [io  0x0b60-0x0b63]
>> [    0.102440] pci 0000:00:0d.1: reg 20: [io  0xc800-0xc80f]
>> [    0.102446] pci 0000:00:0d.1: reg 24: [mem 0xfe02c000-0xfe02cfff]
>> [    0.102482] pci 0000:00:0d.2: [10de:037f] type 0 class 0x000101
>> [    0.102495] pci 0000:00:0d.2: reg 10: [io  0xc400-0xc407]
>> [    0.102501] pci 0000:00:0d.2: reg 14: [io  0xc000-0xc003]
>> [    0.102508] pci 0000:00:0d.2: reg 18: [io  0xbc00-0xbc07]
>> [    0.102514] pci 0000:00:0d.2: reg 1c: [io  0xb800-0xb803]
>> [    0.102521] pci 0000:00:0d.2: reg 20: [io  0xb400-0xb40f]
>> [    0.102527] pci 0000:00:0d.2: reg 24: [mem 0xfe02b000-0xfe02bfff]
>> [    0.102567] pci 0000:00:0e.0: [10de:0370] type 1 class 0x000604
>> [    0.102611] pci 0000:00:0e.1: [10de:0371] type 0 class 0x000403
>> [    0.102625] pci 0000:00:0e.1: reg 10: [mem 0xfe020000-0xfe023fff]
>> [    0.102668] pci 0000:00:0e.1: PME# supported from D3hot D3cold
>> [    0.102672] pci 0000:00:0e.1: PME# disabled
>> [    0.102701] pci 0000:00:10.0: [10de:0373] type 0 class 0x000680
>> [    0.102717] pci 0000:00:10.0: reg 10: [mem 0xfe02a000-0xfe02afff]
>> [    0.102724] pci 0000:00:10.0: reg 14: [io  0xb000-0xb007]
>> [    0.102730] pci 0000:00:10.0: reg 18: [mem 0xfe029000-0xfe0290ff]
>> [    0.102737] pci 0000:00:10.0: reg 1c: [mem 0xfe028000-0xfe02800f]
>> [    0.102771] pci 0000:00:10.0: supports D1 D2
>> [    0.102773] pci 0000:00:10.0: PME# supported from D0 D1 D2 D3hot D3cold
>> [    0.102778] pci 0000:00:10.0: PME# disabled
>> [    0.102803] pci 0000:00:11.0: [10de:0373] type 0 class 0x000680
>> [    0.102818] pci 0000:00:11.0: reg 10: [mem 0xfe027000-0xfe027fff]
>> [    0.102825] pci 0000:00:11.0: reg 14: [io  0xac00-0xac07]
>> [    0.102831] pci 0000:00:11.0: reg 18: [mem 0xfe026000-0xfe0260ff]
>> [    0.102838] pci 0000:00:11.0: reg 1c: [mem 0xfe025000-0xfe02500f]
>> [    0.102872] pci 0000:00:11.0: supports D1 D2
>> [    0.102874] pci 0000:00:11.0: PME# supported from D0 D1 D2 D3hot D3cold
>> [    0.102879] pci 0000:00:11.0: PME# disabled
>> [    0.102900] pci 0000:00:12.0: [10de:0376] type 1 class 0x000604
>> [    0.102934] pci 0000:00:12.0: PME# supported from D0 D1 D2 D3hot D3cold
>> [    0.102937] pci 0000:00:12.0: PME# disabled
>> [    0.102959] pci 0000:00:14.0: [10de:0374] type 1 class 0x000604
>> [    0.102992] pci 0000:00:14.0: PME# supported from D0 D1 D2 D3hot D3cold
>> [    0.102996] pci 0000:00:14.0: PME# disabled
>> [    0.103017] pci 0000:00:16.0: [10de:0375] type 1 class 0x000604
>> [    0.103051] pci 0000:00:16.0: PME# supported from D0 D1 D2 D3hot D3cold
>> [    0.103054] pci 0000:00:16.0: PME# disabled
>> [    0.103075] pci 0000:00:17.0: [10de:0377] type 1 class 0x000604
>> [    0.103108] pci 0000:00:17.0: PME# supported from D0 D1 D2 D3hot D3cold
>> [    0.103111] pci 0000:00:17.0: PME# disabled
>> [    0.103126] pci 0000:00:18.0: [1022:1100] type 0 class 0x000600
>> [    0.103146] pci 0000:00:18.1: [1022:1101] type 0 class 0x000600
>> [    0.103164] pci 0000:00:18.2: [1022:1102] type 0 class 0x000600
>> [    0.103183] pci 0000:00:18.3: [1022:1103] type 0 class 0x000600
>> [    0.103211] PCI: peer root bus 00 res updated from pci conf
>> [    0.103255] pci 0000:00:03.0: PCI bridge to [bus 01-ff]
>> [    0.103259] pci 0000:00:03.0:   bridge window [io  0xf000-0x0000] (disabled)
>> [    0.103263] pci 0000:00:03.0:   bridge window [mem
>> 0xfff00000-0x000fffff] (disabled)
>> [    0.103267] pci 0000:00:03.0:   bridge window [mem
>> 0xfff00000-0x000fffff pref] (disabled)
>> [    0.103300] pci 0000:02:00.0: [10de:0161] type 0 class 0x000300
>> [    0.103308] pci 0000:02:00.0: reg 10: [mem 0xfa000000-0xfaffffff]
>> [    0.103318] pci 0000:02:00.0: reg 14: [mem 0xe0000000-0xefffffff 64bit pref]
>> [    0.103327] pci 0000:02:00.0: reg 1c: [mem 0xfb000000-0xfbffffff 64bit]
>> [    0.103337] pci 0000:02:00.0: reg 30: [mem 0xfcfe0000-0xfcffffff pref]
>> [    0.103360] pci 0000:02:00.0: disabling ASPM on pre-1.1 PCIe
>> device.  You can enable it with 'pcie_aspm=force'
>> [    0.103368] pci 0000:00:04.0: PCI bridge to [bus 02-ff]
>> [    0.103372] pci 0000:00:04.0:   bridge window [io  0xf000-0x0000] (disabled)
>> [    0.103375] pci 0000:00:04.0:   bridge window [mem 0xfa000000-0xfcffffff]
>> [    0.103380] pci 0000:00:04.0:   bridge window [mem
>> 0xe0000000-0xefffffff 64bit pref]
>> [    0.103416] pci 0000:03:07.0: [10ec:8139] type 0 class 0x000200
>> [    0.103430] pci 0000:03:07.0: reg 10: [io  0x9c00-0x9cff]
>> [    0.103439] pci 0000:03:07.0: reg 14: [mem 0xfdfff000-0xfdfff0ff]
>> [    0.103471] pci 0000:03:07.0: reg 30: [mem 0xfdfe0000-0xfdfeffff pref]
>> [    0.103486] pci 0000:03:07.0: supports D1 D2
>> [    0.103489] pci 0000:03:07.0: PME# supported from D1 D2 D3hot D3cold
>> [    0.103493] pci 0000:03:07.0: PME# disabled
>> [    0.103512] pci 0000:03:0b.0: [104c:8023] type 0 class 0x000c00
>> [    0.103526] pci 0000:03:0b.0: reg 10: [mem 0xfdffe000-0xfdffe7ff]
>> [    0.103535] pci 0000:03:0b.0: reg 14: [mem 0xfdff8000-0xfdffbfff]
>> [    0.103581] pci 0000:03:0b.0: supports D1 D2
>> [    0.103583] pci 0000:03:0b.0: PME# supported from D0 D1 D2 D3hot
>> [    0.103588] pci 0000:03:0b.0: PME# disabled
>> [    0.103613] pci 0000:00:0e.0: PCI bridge to [bus 03-ff] (subtractive decode)
>> [    0.103617] pci 0000:00:0e.0:   bridge window [io  0x9000-0x9fff]
>> [    0.103621] pci 0000:00:0e.0:   bridge window [mem 0xfdf00000-0xfdffffff]
>> [    0.103625] pci 0000:00:0e.0:   bridge window [mem
>> 0xfff00000-0x000fffff pref] (disabled)
>> [    0.103628] pci 0000:00:0e.0:   bridge window [io  0x0000-0xffff]
>> (subtractive decode)
>> [    0.103631] pci 0000:00:0e.0:   bridge window [mem
>> 0x000a0000-0x000bffff] (subtractive decode)
>> [    0.103634] pci 0000:00:0e.0:   bridge window [mem
>> 0x40000000-0xf3ffffff] (subtractive decode)
>> [    0.103637] pci 0000:00:0e.0:   bridge window [mem
>> 0xf4000000-0xfcffffffff] (subtractive decode)
>> [    0.103672] pci 0000:00:12.0: PCI bridge to [bus 04-ff]
>> [    0.103677] pci 0000:00:12.0:   bridge window [io  0xf000-0x0000] (disabled)
>> [    0.103680] pci 0000:00:12.0:   bridge window [mem
>> 0xfff00000-0x000fffff] (disabled)
>> [    0.103685] pci 0000:00:12.0:   bridge window [mem
>> 0xfff00000-0x000fffff pref] (disabled)
>> [    0.103720] pci 0000:00:14.0: PCI bridge to [bus 05-ff]
>> [    0.103725] pci 0000:00:14.0:   bridge window [io  0xf000-0x0000] (disabled)
>> [    0.103728] pci 0000:00:14.0:   bridge window [mem
>> 0xfff00000-0x000fffff] (disabled)
>> [    0.103733] pci 0000:00:14.0:   bridge window [mem
>> 0xfff00000-0x000fffff pref] (disabled)
>> [    0.103786] pci 0000:06:00.0: [1095:3132] type 0 class 0x000180
>> [    0.103809] pci 0000:06:00.0: reg 10: [mem 0xfdeff000-0xfdeff07f 64bit]
>> [    0.103827] pci 0000:06:00.0: reg 18: [mem 0xfdef8000-0xfdefbfff 64bit]
>> [    0.103840] pci 0000:06:00.0: reg 20: [io  0x8c00-0x8c7f]
>> [    0.103862] pci 0000:06:00.0: reg 30: [mem 0xfde00000-0xfde7ffff pref]
>> [    0.103896] pci 0000:06:00.0: supports D1 D2
>> [    0.103914] pci 0000:06:00.0: disabling ASPM on pre-1.1 PCIe
>> device.  You can enable it with 'pcie_aspm=force'
>> [    0.103926] pci 0000:00:16.0: PCI bridge to [bus 06-ff]
>> [    0.103930] pci 0000:00:16.0:   bridge window [io  0x8000-0x8fff]
>> [    0.103934] pci 0000:00:16.0:   bridge window [mem 0xfde00000-0xfdefffff]
>> [    0.103939] pci 0000:00:16.0:   bridge window [mem
>> 0xfff00000-0x000fffff pref] (disabled)
>> [    0.103986] pci 0000:07:00.0: [104c:b800] type 0 class 0x000400
>> [    0.104014] pci 0000:07:00.0: reg 10: [mem 0xfddff000-0xfddfffff 64bit]
>> [    0.104028] pci 0000:07:00.0: reg 18: [mem 0xbf000000-0xbfffffff 64bit pref]
>> [    0.104041] pci 0000:07:00.0: reg 20: [mem 0x40000000-0x7fffffff 64bit pref]
>> [    0.112023] pci 0000:00:17.0: PCI bridge to [bus 07-ff]
>> [    0.112028] pci 0000:00:17.0:   bridge window [io  0xf000-0x0000] (disabled)
>> [    0.112032] pci 0000:00:17.0:   bridge window [mem 0xfdd00000-0xfddfffff]
>> [    0.112037] pci 0000:00:17.0:   bridge window [mem
>> 0x40000000-0xbfffffff 64bit pref]
>> [    0.112044] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
>> [    0.112317] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
>> [    0.112519]  pci0000:00: Requesting ACPI _OSC control (0x1d)
>> [    0.112524]  pci0000:00: ACPI _OSC request failed (AE_NOT_FOUND),
>> returned control mask: 0x1d
>> [    0.112526] ACPI _OSC control for PCIe not granted, disabling ASPM
>> [    0.186782] ACPI: PCI Interrupt Link [LNK1] (IRQs 5 7 9 *10 11 14 15)
>> [    0.186841] ACPI: PCI Interrupt Link [LNK2] (IRQs 5 7 9 *10 11 14 15)
>> [    0.186895] ACPI: PCI Interrupt Link [LNK3] (IRQs 5 7 9 10 11 14
>> 15) *0, disabled.
>> [    0.186949] ACPI: PCI Interrupt Link [LNK4] (IRQs 5 7 9 10 11 14
>> 15) *0, disabled.
>> [    0.187005] ACPI: PCI Interrupt Link [LNK5] (IRQs *5 7 9 10 11 14 15)
>> [    0.187060] ACPI: PCI Interrupt Link [LNK6] (IRQs 5 7 9 10 *11 14 15)
>> [    0.187115] ACPI: PCI Interrupt Link [LNK7] (IRQs 5 7 9 10 *11 14 15)
>> [    0.187174] ACPI: PCI Interrupt Link [LNK8] (IRQs 5 7 9 10 11 14
>> 15) *0, disabled.
>> [    0.187229] ACPI: PCI Interrupt Link [LP2P] (IRQs 5 7 9 10 11 14
>> 15) *0, disabled.
>> [    0.187286] ACPI: PCI Interrupt Link [LUBA] (IRQs 5 *7 9 10 11 14 15)
>> [    0.187345] ACPI: PCI Interrupt Link [LMAC] (IRQs 5 7 9 10 *11 14 15)
>> [    0.187409] ACPI: PCI Interrupt Link [LMC1] (IRQs *5 7 9 10 11 14 15)
>> [    0.187464] ACPI: PCI Interrupt Link [LAZA] (IRQs 5 7 9 *10 11 14 15)
>> [    0.187519] ACPI: PCI Interrupt Link [LPMU] (IRQs 5 7 9 10 11 14
>> 15) *0, disabled.
>> [    0.187575] ACPI: PCI Interrupt Link [LSMB] (IRQs 5 7 9 *10 11 14 15)
>> [    0.187636] ACPI: PCI Interrupt Link [LUB2] (IRQs *5 7 9 10 11 14 15)
>> [    0.187691] ACPI: PCI Interrupt Link [LIDE] (IRQs 5 7 9 10 11 14
>> 15) *0, disabled.
>> [    0.187747] ACPI: PCI Interrupt Link [LSID] (IRQs *5 7 9 10 11 14 15)
>> [    0.187802] ACPI: PCI Interrupt Link [LFID] (IRQs *5 7 9 10 11 14 15)
>> [    0.187858] ACPI: PCI Interrupt Link [LSA2] (IRQs *5 7 9 10 11 14 15)
>> [    0.187955] ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0
>> [    0.188048] ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0
>> [    0.188131] ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
>> [    0.188213] ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
>> [    0.188296] ACPI: PCI Interrupt Link [APC5] (IRQs 16) *0
>> [    0.188379] ACPI: PCI Interrupt Link [APC6] (IRQs 16) *0
>> [    0.188461] ACPI: PCI Interrupt Link [APC7] (IRQs 16) *0
>> [    0.188543] ACPI: PCI Interrupt Link [APC8] (IRQs 16) *0, disabled.
>> [    0.188627] ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0
>> [    0.188711] ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0
>> [    0.188795] ACPI: PCI Interrupt Link [AMC1] (IRQs 20 21 22 23) *0
>> [    0.188880] ACPI: PCI Interrupt Link [APMU] (IRQs 20 21 22 23) *0, disabled.
>> [    0.188965] ACPI: PCI Interrupt Link [AAZA] (IRQs 20 21 22 23) *0
>> [    0.189050] ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0
>> [    0.189135] ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0
>> [    0.189223] ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22 23) *0, disabled.
>> [    0.189313] ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
>> [    0.189398] ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0
>> [    0.189483] ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0
>> [    0.189567] ACPI: PCI Interrupt Link [ASA2] (IRQs 20 21 22 23) *0
>> [    0.189712] vgaarb: device added:
>> PCI:0000:02:00.0,decodes=io+mem,owns=io+mem,locks=none
>> [    0.189717] vgaarb: loaded
>> [    0.189718] vgaarb: bridge control possible 0000:02:00.0
>> [    0.189943] SCSI subsystem initialized
>> [    0.190030] libata version 3.00 loaded.
>> [    0.190085] usbcore: registered new interface driver usbfs
>> [    0.190096] usbcore: registered new interface driver hub
>> [    0.190125] usbcore: registered new device driver usb
>> [    0.190225] PCI: Using ACPI for IRQ routing
>> [    0.191684] PCI: pci_cache_line_size set to 64 bytes
>> [    0.191786] reserve RAM buffer: 000000000009f800 - 000000000009ffff
>> [    0.191789] reserve RAM buffer: 000000003fee0000 - 000000003fffffff
>> [    0.191909] NetLabel: Initializing
>> [    0.191911] NetLabel:  domain hash size = 128
>> [    0.191913] NetLabel:  protocols = UNLABELED CIPSOv4
>> [    0.191927] NetLabel:  unlabeled traffic allowed by default
>> [    0.200075] AppArmor: AppArmor Filesystem Enabled
>> [    0.200122] pnp: PnP ACPI init
>> [    0.200142] ACPI: bus type pnp registered
>> [    0.200844] pnp 00:00: [bus 00-07]
>> [    0.200847] pnp 00:00: [io  0x0cf8-0x0cff]
>> [    0.200850] pnp 00:00: [io  0x0000-0x03af window]
>> [    0.200857] pnp 00:00: [io  0x03e0-0x0cf7 window]
>> [    0.200859] pnp 00:00: [io  0x1c00-0x1c7f window]
>> [    0.200862] pnp 00:00: [io  0x8000-0xffff window]
>> [    0.200865] pnp 00:00: [io  0x03b0-0x03df window]
>> [    0.200867] pnp 00:00: [mem 0x000a0000-0x000bffff window]
>> [    0.200870] pnp 00:00: [mem 0x40000000-0xefffffff window]
>> [    0.200873] pnp 00:00: [mem 0xf4000000-0xfe02ffff window]
>> [    0.200876] pnp 00:00: [mem 0xfec80000-0xfecbffff window]
>> [    0.200970] pnp 00:00: Plug and Play ACPI device, IDs PNP0a08
>> PNP0a03 (active)
>> [    0.200994] pnp 00:01: [io  0x1000-0x107f]
>> [    0.200997] pnp 00:01: [io  0x1080-0x10ff]
>> [    0.200999] pnp 00:01: [io  0x1400-0x147f]
>> [    0.201002] pnp 00:01: [io  0x1480-0x14ff]
>> [    0.201004] pnp 00:01: [io  0x1800-0x187f]
>> [    0.201006] pnp 00:01: [io  0x1880-0x18ff]
>> [    0.201088] system 00:01: [io  0x1000-0x107f] has been reserved
>> [    0.201091] system 00:01: [io  0x1080-0x10ff] has been reserved
>> [    0.201094] system 00:01: [io  0x1400-0x147f] has been reserved
>> [    0.201097] system 00:01: [io  0x1480-0x14ff] has been reserved
>> [    0.201101] system 00:01: [io  0x1800-0x187f] has been reserved
>> [    0.201104] system 00:01: [io  0x1880-0x18ff] has been reserved
>> [    0.201108] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
>> [    0.202001] pnp 00:02: [io  0x0010-0x001f]
>> [    0.202004] pnp 00:02: [io  0x0022-0x003f]
>> [    0.202006] pnp 00:02: [io  0x0044-0x005f]
>> [    0.202008] pnp 00:02: [io  0x0062-0x0063]
>> [    0.202011] pnp 00:02: [io  0x0065-0x006f]
>> [    0.202013] pnp 00:02: [io  0x0074-0x007f]
>> [    0.202015] pnp 00:02: [io  0x0091-0x0093]
>> [    0.202018] pnp 00:02: [io  0x00a2-0x00bf]
>> [    0.202020] pnp 00:02: [io  0x00e0-0x00ef]
>> [    0.202022] pnp 00:02: [io  0x04d0-0x04d1]
>> [    0.202025] pnp 00:02: [io  0x0800-0x087f]
>> [    0.202027] pnp 00:02: [io  0x0290-0x0297]
>> [    0.202121] system 00:02: [io  0x04d0-0x04d1] has been reserved
>> [    0.202127] system 00:02: [io  0x0800-0x087f] has been reserved
>> [    0.202130] system 00:02: [io  0x0290-0x0297] has been reserved
>> [    0.202134] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
>> [    0.202149] pnp 00:03: [dma 4]
>> [    0.202151] pnp 00:03: [io  0x0000-0x000f]
>> [    0.202154] pnp 00:03: [io  0x0080-0x0090]
>> [    0.202156] pnp 00:03: [io  0x0094-0x009f]
>> [    0.202158] pnp 00:03: [io  0x00c0-0x00df]
>> [    0.202212] pnp 00:03: Plug and Play ACPI device, IDs PNP0200 (active)
>> [    0.202225] pnp 00:04: [io  0x0070-0x0073]
>> [    0.202243] pnp 00:04: [irq 8]
>> [    0.202297] pnp 00:04: Plug and Play ACPI device, IDs PNP0b00 (active)
>> [    0.202308] pnp 00:05: [io  0x0061]
>> [    0.202365] pnp 00:05: Plug and Play ACPI device, IDs PNP0800 (active)
>> [    0.202376] pnp 00:06: [io  0x00f0-0x00ff]
>> [    0.202385] pnp 00:06: [irq 13]
>> [    0.202440] pnp 00:06: Plug and Play ACPI device, IDs PNP0c04 (active)
>> [    0.202629] pnp 00:07: [io  0x03f0-0x03f5]
>> [    0.202632] pnp 00:07: [io  0x03f7]
>> [    0.202641] pnp 00:07: [irq 6]
>> [    0.202643] pnp 00:07: [dma 2]
>> [    0.202709] pnp 00:07: Plug and Play ACPI device, IDs PNP0700 (active)
>> [    0.202970] pnp 00:08: [io  0x03f8-0x03ff]
>> [    0.202979] pnp 00:08: [irq 4]
>> [    0.203065] pnp 00:08: Plug and Play ACPI device, IDs PNP0501 (active)
>> [    0.203461] pnp 00:09: [io  0x0378-0x037f]
>> [    0.203471] pnp 00:09: [irq 7]
>> [    0.203547] pnp 00:09: Plug and Play ACPI device, IDs PNP0400 (active)
>> [    0.203688] pnp 00:0a: [io  0x0060]
>> [    0.203691] pnp 00:0a: [io  0x0064]
>> [    0.203699] pnp 00:0a: [irq 1]
>> [    0.203762] pnp 00:0a: Plug and Play ACPI device, IDs PNP0303
>> PNP030b (active)
>> [    0.203800] pnp 00:0b: [mem 0x00000000-0xffffffffffffffff disabled]
>> [    0.203884] system 00:0b: Plug and Play ACPI device, IDs PNP0c02 (active)
>> [    0.204052] pnp 00:0c: [mem 0x000cec00-0x000cffff]
>> [    0.204055] pnp 00:0c: [mem 0x000f0000-0x000f7fff]
>> [    0.204057] pnp 00:0c: [mem 0x000f8000-0x000fbfff]
>> [    0.204060] pnp 00:0c: [mem 0x000fc000-0x000fffff]
>> [    0.204062] pnp 00:0c: [mem 0x3fee0000-0x3fefffff]
>> [    0.204065] pnp 00:0c: [mem 0xffff0000-0xffffffff]
>> [    0.204067] pnp 00:0c: [mem 0x00000000-0x0009ffff]
>> [    0.204069] pnp 00:0c: [mem 0x00100000-0x3fedffff]
>> [    0.204072] pnp 00:0c: [mem 0xfec00000-0xfec00fff]
>> [    0.204074] pnp 00:0c: [mem 0xfee00000-0xfeefffff]
>> [    0.204077] pnp 00:0c: [mem 0xfefff000-0xfeffffff]
>> [    0.204079] pnp 00:0c: [mem 0xfff80000-0xfff80fff]
>> [    0.204082] pnp 00:0c: [mem 0xfff90000-0xfffbffff]
>> [    0.204084] pnp 00:0c: [mem 0xfffed000-0xfffeffff]
>> [    0.204190] system 00:0c: [mem 0x000cec00-0x000cffff] has been reserved
>> [    0.204194] system 00:0c: [mem 0x000f0000-0x000f7fff] could not be reserved
>> [    0.204197] system 00:0c: [mem 0x000f8000-0x000fbfff] could not be reserved
>> [    0.204201] system 00:0c: [mem 0x000fc000-0x000fffff] could not be reserved
>> [    0.204204] system 00:0c: [mem 0x3fee0000-0x3fefffff] could not be reserved
>> [    0.204208] system 00:0c: [mem 0xffff0000-0xffffffff] has been reserved
>> [    0.204212] system 00:0c: [mem 0x00000000-0x0009ffff] could not be reserved
>> [    0.204215] system 00:0c: [mem 0x00100000-0x3fedffff] could not be reserved
>> [    0.204219] system 00:0c: [mem 0xfec00000-0xfec00fff] could not be reserved
>> [    0.204222] system 00:0c: [mem 0xfee00000-0xfeefffff] has been reserved
>> [    0.204226] system 00:0c: [mem 0xfefff000-0xfeffffff] has been reserved
>> [    0.204229] system 00:0c: [mem 0xfff80000-0xfff80fff] has been reserved
>> [    0.204232] system 00:0c: [mem 0xfff90000-0xfffbffff] has been reserved
>> [    0.204236] system 00:0c: [mem 0xfffed000-0xfffeffff] has been reserved
>> [    0.204239] system 00:0c: Plug and Play ACPI device, IDs PNP0c01 (active)
>> [    0.204268] pnp: PnP ACPI: found 13 devices
>> [    0.204270] ACPI: ACPI bus type pnp unregistered
>> [    0.210548] Switching to clocksource acpi_pm
>> [    0.210594] PCI: max bus depth: 1 pci_try_num: 2
>> [    0.210640] pci 0000:00:03.0: PCI bridge to [bus 01-01]
>> [    0.210643] pci 0000:00:03.0:   bridge window [io  disabled]
>> [    0.210646] pci 0000:00:03.0:   bridge window [mem disabled]
>> [    0.210649] pci 0000:00:03.0:   bridge window [mem pref disabled]
>> [    0.210653] pci 0000:00:04.0: PCI bridge to [bus 02-02]
>> [    0.210655] pci 0000:00:04.0:   bridge window [io  disabled]
>> [    0.210659] pci 0000:00:04.0:   bridge window [mem 0xfa000000-0xfcffffff]
>> [    0.210663] pci 0000:00:04.0:   bridge window [mem
>> 0xe0000000-0xefffffff 64bit pref]
>> [    0.210668] pci 0000:00:0e.0: PCI bridge to [bus 03-03]
>> [    0.210671] pci 0000:00:0e.0:   bridge window [io  0x9000-0x9fff]
>> [    0.210675] pci 0000:00:0e.0:   bridge window [mem 0xfdf00000-0xfdffffff]
>> [    0.210678] pci 0000:00:0e.0:   bridge window [mem pref disabled]
>> [    0.210682] pci 0000:00:12.0: PCI bridge to [bus 04-04]
>> [    0.210685] pci 0000:00:12.0:   bridge window [io  disabled]
>> [    0.210688] pci 0000:00:12.0:   bridge window [mem disabled]
>> [    0.210691] pci 0000:00:12.0:   bridge window [mem pref disabled]
>> [    0.210696] pci 0000:00:14.0: PCI bridge to [bus 05-05]
>> [    0.210698] pci 0000:00:14.0:   bridge window [io  disabled]
>> [    0.210702] pci 0000:00:14.0:   bridge window [mem disabled]
>> [    0.210705] pci 0000:00:14.0:   bridge window [mem pref disabled]
>> [    0.210710] pci 0000:00:16.0: PCI bridge to [bus 06-06]
>> [    0.210713] pci 0000:00:16.0:   bridge window [io  0x8000-0x8fff]
>> [    0.210717] pci 0000:00:16.0:   bridge window [mem 0xfde00000-0xfdefffff]
>> [    0.210720] pci 0000:00:16.0:   bridge window [mem pref disabled]
>> [    0.210725] pci 0000:00:17.0: PCI bridge to [bus 07-07]
>> [    0.210727] pci 0000:00:17.0:   bridge window [io  disabled]
>> [    0.210731] pci 0000:00:17.0:   bridge window [mem 0xfdd00000-0xfddfffff]
>> [    0.210735] pci 0000:00:17.0:   bridge window [mem
>> 0x40000000-0xbfffffff 64bit pref]
>> [    0.210748] pci 0000:00:03.0: setting latency timer to 64
>> [    0.210753] pci 0000:00:04.0: setting latency timer to 64
>> [    0.210758] pci 0000:00:0e.0: setting latency timer to 64
>> [    0.210765] pci 0000:00:12.0: setting latency timer to 64
>> [    0.210771] pci 0000:00:14.0: setting latency timer to 64
>> [    0.210777] pci 0000:00:16.0: setting latency timer to 64
>> [    0.210783] pci 0000:00:17.0: setting latency timer to 64
>> [    0.210787] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
>> [    0.210790] pci_bus 0000:00: resource 5 [mem 0x000a0000-0x000bffff]
>> [    0.210793] pci_bus 0000:00: resource 6 [mem 0x40000000-0xf3ffffff]
>> [    0.210796] pci_bus 0000:00: resource 7 [mem 0xf4000000-0xfcffffffff]
>> [    0.210799] pci_bus 0000:02: resource 1 [mem 0xfa000000-0xfcffffff]
>> [    0.210802] pci_bus 0000:02: resource 2 [mem 0xe0000000-0xefffffff
>> 64bit pref]
>> [    0.210805] pci_bus 0000:03: resource 0 [io  0x9000-0x9fff]
>> [    0.210808] pci_bus 0000:03: resource 1 [mem 0xfdf00000-0xfdffffff]
>> [    0.210811] pci_bus 0000:03: resource 4 [io  0x0000-0xffff]
>> [    0.210814] pci_bus 0000:03: resource 5 [mem 0x000a0000-0x000bffff]
>> [    0.210817] pci_bus 0000:03: resource 6 [mem 0x40000000-0xf3ffffff]
>> [    0.210819] pci_bus 0000:03: resource 7 [mem 0xf4000000-0xfcffffffff]
>> [    0.210823] pci_bus 0000:06: resource 0 [io  0x8000-0x8fff]
>> [    0.210825] pci_bus 0000:06: resource 1 [mem 0xfde00000-0xfdefffff]
>> [    0.210829] pci_bus 0000:07: resource 1 [mem 0xfdd00000-0xfddfffff]
>> [    0.210832] pci_bus 0000:07: resource 2 [mem 0x40000000-0xbfffffff
>> 64bit pref]
>> [    0.210889] NET: Registered protocol family 2
>> [    0.210997] IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
>> [    0.211618] TCP established hash table entries: 131072 (order: 9,
>> 2097152 bytes)
>> [    0.211618] Switched to NOHz mode on CPU #0
>> [    0.211618] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
>> [    0.211618] TCP: Hash tables configured (established 131072 bind 65536)
>> [    0.211618] TCP reno registered
>> [    0.211618] UDP hash table entries: 512 (order: 2, 16384 bytes)
>> [    0.211618] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
>> [    0.211618] NET: Registered protocol family 1
>> [    0.211618] pci 0000:00:00.0: Found enabled HT MSI Mapping
>> [    0.211618] pci 0000:00:00.0: Found enabled HT MSI Mapping
>> [    0.284092] pci 0000:00:0d.0: Enabling HT MSI Mapping
>> [    0.284144] pci 0000:00:0d.1: Enabling HT MSI Mapping
>> [    0.284195] pci 0000:00:0d.2: Enabling HT MSI Mapping
>> [    0.284246] pci 0000:00:0e.0: Enabling HT MSI Mapping
>> [    0.284302] pci 0000:00:0e.1: Enabling HT MSI Mapping
>> [    0.284369] pci 0000:00:10.0: Enabling HT MSI Mapping
>> [    0.284444] pci 0000:00:11.0: Enabling HT MSI Mapping
>> [    0.284522] pci 0000:00:12.0: Enabling HT MSI Mapping
>> [    0.284607] pci 0000:00:14.0: Enabling HT MSI Mapping
>> [    0.284700] pci 0000:00:16.0: Enabling HT MSI Mapping
>> [    0.284799] pci 0000:00:17.0: Enabling HT MSI Mapping
>> [    0.284819] pci 0000:02:00.0: Boot video device
>> [    0.284831] PCI: CLS 32 bytes, default 64
>> [    0.285098] Trying to unpack rootfs image as initramfs...
>> [    0.344652] audit: initializing netlink socket (disabled)
>> [    0.344669] type=2000 audit(1341483327.344:1): initialized
>> [    0.404317] HugeTLB registered 2 MB page size, pre-allocated 0 pages
>> [    0.424439] VFS: Disk quotas dquot_6.5.2
>> [    0.424513] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
>> [    0.425308] fuse init (API version 7.16)
>> [    0.425414] msgmni has been set to 1963
>> [    0.440402] Block layer SCSI generic (bsg) driver version 0.4
>> loaded (major 253)
>> [    0.440477] io scheduler noop registered
>> [    0.440480] io scheduler deadline registered
>> [    0.440534] io scheduler cfq registered (default)
>> [    0.440728] pcieport 0000:00:03.0: setting latency timer to 64
>> [    0.440760] pcieport 0000:00:03.0: irq 40 for MSI/MSI-X
>> [    0.444244] pcieport 0000:00:04.0: setting latency timer to 64
>> [    0.444282] pcieport 0000:00:04.0: irq 41 for MSI/MSI-X
>> [    0.444432] pcieport 0000:00:12.0: setting latency timer to 64
>> [    0.444466] pcieport 0000:00:12.0: irq 42 for MSI/MSI-X
>> [    0.448208] pcieport 0000:00:14.0: setting latency timer to 64
>> [    0.448254] pcieport 0000:00:14.0: irq 43 for MSI/MSI-X
>> [    0.448412] pcieport 0000:00:16.0: setting latency timer to 64
>> [    0.448442] pcieport 0000:00:16.0: irq 44 for MSI/MSI-X
>> [    0.452176] pcieport 0000:00:17.0: setting latency timer to 64
>> [    0.452222] pcieport 0000:00:17.0: irq 45 for MSI/MSI-X
>> [    0.452360] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
>> [    0.452392] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
>> [    0.452556] input: Power Button as
>> /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input0
>> [    0.452563] ACPI: Power Button [PWRB]
>> [    0.452629] input: Power Button as
>> /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
>> [    0.452632] ACPI: Power Button [PWRF]
>> [    0.452690] ACPI: Fan [FAN] (on)
>> [    0.452701] ACPI: acpi_idle registered with cpuidle
>> [    0.456108] thermal LNXTHERM:00: registered as thermal_zone0
>> [    0.456111] ACPI: Thermal Zone [THRM] (40 C)
>> [    0.456141] ERST: Table is not found!
>> [    0.456253] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
>> [    0.476673] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
>> [    0.517837] 00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
>> [    0.540414] Linux agpgart interface v0.103
>> [    0.541735] brd: module loaded
>> [    0.542323] loop: module loaded
>> [    0.548199] pata_acpi 0000:00:0c.0: setting latency timer to 64
>> [    0.548563] ACPI: PCI Interrupt Link [APSI] enabled at IRQ 23
>> [    0.548588] pata_acpi 0000:00:0d.0: PCI INT A -> Link[APSI] -> GSI
>> 23 (level, low) -> IRQ 23
>> [    0.548612] pata_acpi 0000:00:0d.0: setting latency timer to 64
>> [    0.548621] pata_acpi 0000:00:0d.0: PCI INT A disabled
>> [    0.548822] ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 22
>> [    0.548834] pata_acpi 0000:00:0d.1: PCI INT B -> Link[APSJ] -> GSI
>> 22 (level, low) -> IRQ 22
>> [    0.548852] pata_acpi 0000:00:0d.1: setting latency timer to 64
>> [    0.548860] pata_acpi 0000:00:0d.1: PCI INT B disabled
>> [    0.552361] ACPI: PCI Interrupt Link [ASA2] enabled at IRQ 21
>> [    0.552388] pata_acpi 0000:00:0d.2: PCI INT C -> Link[ASA2] -> GSI
>> 21 (level, low) -> IRQ 21
>> [    0.552432] pata_acpi 0000:00:0d.2: setting latency timer to 64
>> [    0.552447] pata_acpi 0000:00:0d.2: PCI INT C disabled
>> [    0.560554] Fixed MDIO Bus: probed
>> [    0.560588] PPP generic driver version 2.4.2
>> [    0.560665] tun: Universal TUN/TAP device driver, 1.6
>> [    0.560667] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
>> [    0.560794] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
>> [    0.561141] ACPI: PCI Interrupt Link [APCL] enabled at IRQ 20
>> [    0.561166] ehci_hcd 0000:00:0a.1: PCI INT B -> Link[APCL] -> GSI
>> 20 (level, low) -> IRQ 20
>> [    0.561191] ehci_hcd 0000:00:0a.1: setting latency timer to 64
>> [    0.561195] ehci_hcd 0000:00:0a.1: EHCI Host Controller
>> [    0.561250] ehci_hcd 0000:00:0a.1: new USB bus registered, assigned
>> bus number 1
>> [    0.561282] ehci_hcd 0000:00:0a.1: debug port 1
>> [    0.561291] ehci_hcd 0000:00:0a.1: cache line size of 32 is not supported
>> [    0.561321] ehci_hcd 0000:00:0a.1: irq 20, io mem 0xfe02e000
>> [    0.572237] ehci_hcd 0000:00:0a.1: USB 2.0 started, EHCI 1.00
>> [    0.572474] hub 1-0:1.0: USB hub found
>> [    0.572480] hub 1-0:1.0: 10 ports detected
>> [    0.572634] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
>> [    0.576406] ACPI: PCI Interrupt Link [APCF] enabled at IRQ 23
>> [    0.576417] ohci_hcd 0000:00:0a.0: PCI INT A -> Link[APCF] -> GSI
>> 23 (level, low) -> IRQ 23
>> [    0.576445] ohci_hcd 0000:00:0a.0: setting latency timer to 64
>> [    0.576449] ohci_hcd 0000:00:0a.0: OHCI Host Controller
>> [    0.576545] ohci_hcd 0000:00:0a.0: new USB bus registered, assigned
>> bus number 2
>> [    0.576597] ohci_hcd 0000:00:0a.0: irq 23, io mem 0xfe02f000
>> [    0.634403] hub 2-0:1.0: USB hub found
>> [    0.634413] hub 2-0:1.0: 10 ports detected
>> [    0.634541] uhci_hcd: USB Universal Host Controller Interface driver
>> [    0.634647] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
>> [    0.634649] i8042: PNP: PS/2 appears to have AUX port disabled, if
>> this is incorrect please boot with i8042.nopnp
>> [    0.634812] serio: i8042 KBD port at 0x60,0x64 irq 1
>> [    0.634905] mousedev: PS/2 mouse device common for all mice
>> [    0.635028] rtc_cmos 00:04: RTC can wake from S4
>> [    0.635158] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
>> [    0.635192] rtc0: alarms up to one year, y3k, 242 bytes nvram
>> [    0.635323] device-mapper: uevent: version 1.0.3
>> [    0.635409] device-mapper: ioctl: 4.20.0-ioctl (2011-02-02)
>> initialised: dm-devel@redhat.com
>> [    0.635422] cpuidle: using governor ladder
>> [    0.635424] cpuidle: using governor menu
>> [    0.635426] EFI Variables Facility v0.08 2004-May-17
>> [    0.635689] TCP cubic registered
>> [    0.635836] NET: Registered protocol family 10
>> [    0.636519] NET: Registered protocol family 17
>> [    0.636542] Registering the dns_resolver key type
>> [    0.636666] PM: Hibernation image not present or could not be loaded.
>> [    0.636680] registered taskstats version 1
>> [    0.658231] input: AT Translated Set 2 keyboard as
>> /devices/platform/i8042/serio0/input/input2
>> [    0.719135] Freeing initrd memory: 13416k freed
>> [    0.736443]   Magic number: 4:160:274
>> [    0.736494] tty tty11: hash matches
>> [    0.736575] rtc_cmos 00:04: setting system clock to 2012-07-05
>> 10:15:28 UTC (1341483328)
>> [    0.736581] powernow-k8: Found 1 AMD Athlon(tm) 64 Processor 3200+
>> (1 cpu cores) (version 2.20.00)
>> [    0.742743] [Firmware Bug]: powernow-k8: No PSB or ACPI _PSS objects
>> [    0.742745] powernow-k8: Make sure that your BIOS is up to date and
>> Cool'N'Quiet support is enabled in BIOS setup
>> [    0.742785] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
>> [    0.742787] EDD information not available.
>> [    0.745106] Freeing unused kernel memory: 984k freed
>> [    0.745639] Write protecting the kernel read-only data: 10240k
>> [    0.745920] Freeing unused kernel memory: 20k freed
>> [    0.751792] Freeing unused kernel memory: 1400k freed
>> [    0.781490] udevd[128]: starting version 173
>> [    0.936395] Floppy drive(s): fd0 is 1.44M
>> [    0.940091] usb 1-9: new high speed USB device number 3 using ehci_hcd
>> [    0.955957] FDC 0 is a post-1991 82077
>> [    1.072155] sata_nv 0000:00:0d.0: version 3.5
>> [    1.072178] sata_nv 0000:00:0d.0: PCI INT A -> Link[APSI] -> GSI 23
>> (level, low) -> IRQ 23
>> [    1.072182] sata_nv 0000:00:0d.0: Using SWNCQ mode
>> [    1.072254] sata_nv 0000:00:0d.0: setting latency timer to 64
>> [    1.075515] scsi0 : sata_nv
>> [    1.078274] scsi1 : sata_nv
>> [    1.078464] ata1: SATA max UDMA/133 cmd 0x9f0 ctl 0xbf0 bmdma 0xdc00 irq 23
>> [    1.078468] ata2: SATA max UDMA/133 cmd 0x970 ctl 0xb70 bmdma 0xdc08 irq 23
>> [    1.082123] sata_nv 0000:00:0d.1: PCI INT B -> Link[APSJ] -> GSI 22
>> (level, low) -> IRQ 22
>> [    1.082128] sata_nv 0000:00:0d.1: Using SWNCQ mode
>> [    1.082190] sata_nv 0000:00:0d.1: setting latency timer to 64
>> [    1.083654] 8139cp: 8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
>> [    1.085284] scsi2 : sata_nv
>> [    1.085422] scsi3 : sata_nv
>> [    1.085569] ata3: SATA max UDMA/133 cmd 0x9e0 ctl 0xbe0 bmdma 0xc800 irq 22
>> [    1.085573] ata4: SATA max UDMA/133 cmd 0x960 ctl 0xb60 bmdma 0xc808 irq 22
>> [    1.088699] sata_nv 0000:00:0d.2: PCI INT C -> Link[ASA2] -> GSI 21
>> (level, low) -> IRQ 21
>> [    1.088705] sata_nv 0000:00:0d.2: Using SWNCQ mode
>> [    1.088766] sata_nv 0000:00:0d.2: setting latency timer to 64
>> [    1.091302] scsi4 : sata_nv
>> [    1.092468] 8139cp 0000:03:07.0: This (id 10ec:8139 rev 10) is not
>> an 8139C+ compatible chip, use 8139too
>> [    1.092511] scsi5 : sata_nv
>> [    1.092691] ata5: SATA max UDMA/133 cmd 0xc400 ctl 0xc000 bmdma 0xb400 irq 21
>> [    1.092695] ata6: SATA max UDMA/133 cmd 0xbc00 ctl 0xb800 bmdma 0xb408 irq 21
>> [    1.096098] forcedeth: Reverse Engineered nForce ethernet driver.
>> Version 0.64.
>> [    1.096346] ACPI: PCI Interrupt Link [APCH] enabled at IRQ 22
>> [    1.096354] forcedeth 0000:00:10.0: PCI INT A -> Link[APCH] -> GSI
>> 22 (level, low) -> IRQ 22
>> [    1.096360] forcedeth 0000:00:10.0: setting latency timer to 64
>> [    1.105488] sata_sil24 0000:06:00.0: version 1.1
>> [    1.105719] ACPI: PCI Interrupt Link [APC7] enabled at IRQ 16
>> [    1.105742] sata_sil24 0000:06:00.0: PCI INT A -> Link[APC7] -> GSI
>> 16 (level, low) -> IRQ 16
>> [    1.105817] sata_sil24 0000:06:00.0: setting latency timer to 64
>> [    1.108129] scsi6 : sata_sil24
>> [    1.110239] scsi7 : sata_sil24
>> [    1.110314] ata7: SATA max UDMA/100 host m128@0xfdeff000 port
>> 0xfdef8000 irq 16
>> [    1.110319] ata8: SATA max UDMA/100 host m128@0xfdeff000 port
>> 0xfdefa000 irq 16
>> [    1.384023] usb 2-4: new low speed USB device number 2 using ohci_hcd
>> [    1.388026] ata1: SATA link down (SStatus 0 SControl 300)
>> [    1.400025] ata3: SATA link down (SStatus 0 SControl 300)
>> [    1.404022] ata5: SATA link down (SStatus 0 SControl 300)
>> [    1.620740] forcedeth 0000:00:10.0: ifname eth0, PHY OUI 0x5043 @
>> 1, addr 00:18:f3:91:04:61
>> [    1.620746] forcedeth 0000:00:10.0: highdma csum vlan pwrctl mgmt
>> gbit lnktim msi desc-v3
>> [    1.621174] ACPI: PCI Interrupt Link [AMC1] enabled at IRQ 21
>> [    1.621182] forcedeth 0000:00:11.0: PCI INT A -> Link[AMC1] -> GSI
>> 21 (level, low) -> IRQ 21
>> [    1.621188] forcedeth 0000:00:11.0: setting latency timer to 64
>> [    1.856034] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> [    1.864394] ata2.00: ATA-8: ST3500413AS, JC45, max UDMA/133
>> [    1.864397] ata2.00: 976773168 sectors, multi 1: LBA48 NCQ (depth 31/32)
>> [    1.880387] ata2.00: configured for UDMA/133
>> [    1.880521] scsi 1:0:0:0: Direct-Access     ATA      ST3500413AS
>>   JC45 PQ: 0 ANSI: 5
>> [    1.880726] sd 1:0:0:0: Attached scsi generic sg0 type 0
>> [    1.880864] sd 1:0:0:0: [sda] 976773168 512-byte logical blocks:
>> (500 GB/465 GiB)
>> [    1.880919] sd 1:0:0:0: [sda] Write Protect is off
>> [    1.880923] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
>> [    1.880947] sd 1:0:0:0: [sda] Write cache: enabled, read cache:
>> enabled, doesn't support DPO or FUA
>> [    1.927481]  sda: sda1 < sda5 sda6 > sda2 sda3 sda4
>> [    1.928075] sd 1:0:0:0: [sda] Attached SCSI disk
>> [    2.144831] forcedeth 0000:00:11.0: ifname eth1, PHY OUI 0x5043 @
>> 1, addr 00:18:f3:91:0e:29
>> [    2.144837] forcedeth 0000:00:11.0: highdma csum vlan pwrctl mgmt
>> gbit lnktim msi desc-v3
>> [    2.145185] pata_amd 0000:00:0c.0: version 0.4.1
>> [    2.145239] pata_amd 0000:00:0c.0: setting latency timer to 64
>> [    2.145780] scsi8 : pata_amd
>> [    2.145904] scsi9 : pata_amd
>> [    2.146407] ata9: PATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0xf000 irq 14
>> [    2.146410] ata10: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xf008 irq 15
>> [    2.192030] ata4: SATA link down (SStatus 0 SControl 300)
>> [    2.340297] ata9.01: ATAPI: TSSTcorp CD-ROM SH-C522C, TS03, max UDMA/33
>> [    2.340307] ata9: nv_mode_filter: 0x739f&0x739f->0x739f,
>> BIOS=0x7000 (0xc00000) ACPI=0x701f (600:60:0x1c)
>> [    2.380226] ata9.01: configured for UDMA/33
>> [    2.504023] ata6: SATA link down (SStatus 0 SControl 300)
>> [    3.192034] ata7: SATA link down (SStatus 0 SControl 0)
>> [    5.272040] ata8: SATA link down (SStatus 0 SControl 0)
>> [    5.272939] scsi 8:0:1:0: CD-ROM            TSSTcorp CD-ROM
>> SH-C522C TS03 PQ: 0 ANSI: 5
>> [    5.274823] sr0: scsi3-mmc drive: 52x/52x cd/rw xa/form2 cdda tray
>> [    5.274827] cdrom: Uniform CD-ROM driver Revision: 3.20
>> [    5.274977] sr 8:0:1:0: Attached scsi CD-ROM sr0
>> [    5.275052] sr 8:0:1:0: Attached scsi generic sg1 type 5
>> [    5.275125] ata10: port disabled. ignoring.
>> [    5.276568] 8139too: 8139too Fast Ethernet driver 0.9.28
>> [    5.281197] ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
>> [    5.281223] 8139too 0000:03:07.0: PCI INT A -> Link[APC2] -> GSI 17
>> (level, low) -> IRQ 17
>> [    5.282164] 8139too 0000:03:07.0: eth2: RealTek RTL8139 at 0x9c00,
>> 00:80:48:5c:e6:a2, IRQ 17
>> [    5.286270] ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
>> [    5.286280] firewire_ohci 0000:03:0b.0: PCI INT A -> Link[APC1] ->
>> GSI 16 (level, low) -> IRQ 16
>> [    5.293641] input: Logitech USB Optical Mouse as
>> /devices/pci0000:00/0000:00:0a.0/usb2/2-4/2-4:1.0/input/input3
>> [    5.293879] generic-usb 0003:046D:C05A.0001: input,hidraw0: USB HID
>> v1.11 Mouse [Logitech USB Optical Mouse] on usb-0000:00:0a.0-4/input0
>> [    5.293902] usbcore: registered new interface driver usbhid
>> [    5.293905] usbhid: USB HID core driver
>> [    5.340080] firewire_ohci: Added fw-ohci device 0000:03:0b.0, OHCI
>> v1.10, 4 IR + 8 IT contexts, quirks 0x2
>> [    5.728585] EXT4-fs (sda2): INFO: recovery required on readonly filesystem
>> [    5.728590] EXT4-fs (sda2): write access will be enabled during recovery
>> [    5.840621] firewire_core: created device fw0: GUID 0011d80000ec6fc1, S400
>> [    7.195079] EXT4-fs (sda2): orphan cleanup on readonly fs
>> [    7.195094] EXT4-fs (sda2): ext4_orphan_cleanup: deleting
>> unreferenced inode 4857639
>> [    7.195135] EXT4-fs (sda2): ext4_orphan_cleanup: deleting
>> unreferenced inode 4857637
>> [    7.195203] EXT4-fs (sda2): ext4_orphan_cleanup: deleting
>> unreferenced inode 4857631
>> [    7.195218] EXT4-fs (sda2): ext4_orphan_cleanup: deleting
>> unreferenced inode 4857627
>> [    7.195232] EXT4-fs (sda2): ext4_orphan_cleanup: deleting
>> unreferenced inode 4857597
>> [    7.195246] EXT4-fs (sda2): ext4_orphan_cleanup: deleting
>> unreferenced inode 4850628
>> [    7.195260] EXT4-fs (sda2): ext4_orphan_cleanup: deleting
>> unreferenced inode 4857592
>> [    7.195274] EXT4-fs (sda2): ext4_orphan_cleanup: deleting
>> unreferenced inode 4857583
>> [    7.195290] EXT4-fs (sda2): ext4_orphan_cleanup: deleting
>> unreferenced inode 13893783
>> [    7.195304] EXT4-fs (sda2): ext4_orphan_cleanup: deleting
>> unreferenced inode 13893706
>> [    7.195318] EXT4-fs (sda2): ext4_orphan_cleanup: deleting
>> unreferenced inode 4857595
>> [    7.195331] EXT4-fs (sda2): ext4_orphan_cleanup: deleting
>> unreferenced inode 4857585
>> [    7.195344] EXT4-fs (sda2): ext4_orphan_cleanup: deleting
>> unreferenced inode 4857579
>> [    7.195358] EXT4-fs (sda2): ext4_orphan_cleanup: deleting
>> unreferenced inode 4857416
>> [    7.195382] EXT4-fs (sda2): ext4_orphan_cleanup: deleting
>> unreferenced inode 4850568
>> [    7.195396] EXT4-fs (sda2): ext4_orphan_cleanup: deleting
>> unreferenced inode 4857636
>> [    7.195408] EXT4-fs (sda2): ext4_orphan_cleanup: deleting
>> unreferenced inode 4857607
>> [    7.195420] EXT4-fs (sda2): 17 orphan inodes deleted
>> [    7.195423] EXT4-fs (sda2): recovery complete
>> [    7.390720] EXT4-fs (sda2): mounted filesystem with ordered data
>> mode. Opts: (null)
>> [   17.609843] udevd[430]: starting version 173
>> [   17.678138] Adding 1046524k swap on /dev/sda4.  Priority:-1
>> extents:1 across:1046524k
>> [   17.685130] lp: driver loaded but no devices found
>> [   17.717282] Adding 3905532k swap on /dev/sda6.  Priority:-2
>> extents:1 across:3905532k
>> [   17.944071] EXT4-fs (sda2): re-mounted. Opts: errors=remount-ro
>> [   18.120312] parport_pc 00:09: reported by Plug and Play ACPI
>> [   18.120344] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE,EPP]
>> [   18.257270] type=1400 audit(1341463546.017:2): apparmor="STATUS"
>> operation="profile_load" name="/sbin/dhclient" pid=597
>> comm="apparmor_parser"
>> [   18.258326] type=1400 audit(1341463546.017:3): apparmor="STATUS"
>> operation="profile_load"
>> name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=597
>> comm="apparmor_parser"
>> [   18.258670] type=1400 audit(1341463546.017:4): apparmor="STATUS"
>> operation="profile_load"
>> name="/usr/lib/connman/scripts/dhclient-script" pid=597
>> comm="apparmor_parser"
>> [   18.292885] lp0: using parport0 (interrupt-driven).
>> [   18.631761] 8139too 0000:03:07.0: eth2: link down
>> [   18.632622] ADDRCONF(NETDEV_UP): eth2: link is not ready
>> [   18.649923] forcedeth 0000:00:10.0: irq 46 for MSI/MSI-X
>> [   18.650131] forcedeth 0000:00:10.0: eth0: no link during initialization
>> [   18.652588] ADDRCONF(NETDEV_UP): eth0: link is not ready
>> [   18.671024] forcedeth 0000:00:11.0: irq 47 for MSI/MSI-X
>> [   18.671233] forcedeth 0000:00:11.0: eth1: no link during initialization
>> [   18.675447] ADDRCONF(NETDEV_UP): eth1: link is not ready
>> [   18.788941] wmi: Mapper loaded
>> [   18.797503] i2c i2c-0: nForce2 SMBus adapter at 0x1c00
>> [   18.797554] i2c i2c-1: nForce2 SMBus adapter at 0x1c40
>> [   18.799984] NV_TCO: NV TCO WatchDog Timer Driver v0.01
>> [   18.800497] NV_TCO: Watchdog reboot not detected.
>> [   18.801744] NV_TCO: initialized (0x1440). heartbeat=30 sec (nowayout=0)
>> [   18.931558] [drm] Initialized drm 1.1.0 20060810
>> [   19.053511] MCE: In-kernel MCE decoding enabled.
>> [   19.072466] EDAC MC: Ver: 2.1.0
>> [   19.075335] cfg80211: Calling CRDA to update world regulatory domain
>> [   19.086226] k8temp 0000:00:18.3: Temperature readouts might be
>> wrong - check erratum #141
>> [   19.107406] AMD64 EDAC driver v3.4.0
>> [   19.115078] EDAC amd64: DRAM ECC disabled.
>> [   19.115086] EDAC amd64: ECC disabled in the BIOS or no ECC
>> capability, module will not load.
>> [   19.115088]  Either enable ECC checking or force module loading by
>> setting 'ecc_enable_override'.
>> [   19.115090]  (Note that use of the override may cause unknown side effects.)
>> [   19.136313] ACPI: PCI Interrupt Link [APC5] enabled at IRQ 16
>> [   19.136324] nouveau 0000:02:00.0: PCI INT A -> Link[APC5] -> GSI 16
>> (level, low) -> IRQ 16
>> [   19.136330] nouveau 0000:02:00.0: setting latency timer to 64
>> [   19.137724] [drm] nouveau 0000:02:00.0: Detected an NV40 generation
>> card (0x044100a2)
>> [   19.139271] [drm] nouveau 0000:02:00.0: Attempting to load BIOS
>> image from PRAMIN
>> [   19.219623] [drm] nouveau 0000:02:00.0: ... appears to be valid
>> [   19.219627] [drm] nouveau 0000:02:00.0: BIT BIOS found
>> [   19.219631] [drm] nouveau 0000:02:00.0: Bios version 05.44.02.14
>> [   19.219635] [drm] nouveau 0000:02:00.0: TMDS table version 1.1
>> [   19.219638] [drm] nouveau 0000:02:00.0: BIT table 'd' not found
>> [   19.219641] [drm] nouveau 0000:02:00.0: Found Display Configuration
>> Block version 3.0
>> [   19.219645] [drm] nouveau 0000:02:00.0: Raw DCB entry 0: 01000300 00000028
>> [   19.219649] [drm] nouveau 0000:02:00.0: Raw DCB entry 1: 02011310 00000028
>> [   19.219652] [drm] nouveau 0000:02:00.0: Raw DCB entry 2: 01011312 00000000
>> [   19.219654] [drm] nouveau 0000:02:00.0: Raw DCB entry 3: 020203f1 0080c033
>> [   19.219658] [drm] nouveau 0000:02:00.0: DCB connector table: VHER 0x30 5 7 2
>> [   19.219667] [drm] nouveau 0000:02:00.0: Parsing VBIOS init table 0
>> at offset 0xEC14
>> [   19.219846] [drm] nouveau 0000:02:00.0: Parsing VBIOS init table 1
>> at offset 0xEEE9
>> [   19.232970] [drm] nouveau 0000:02:00.0: Parsing VBIOS init table 2
>> at offset 0xF321
>> [   19.232994] [drm] nouveau 0000:02:00.0: Parsing VBIOS init table 3
>> at offset 0xF47E
>> [   19.234105] [drm] nouveau 0000:02:00.0: Parsing VBIOS init table 4
>> at offset 0xF52C
>> [   19.234109] [drm] nouveau 0000:02:00.0: mem timing table length unknown: 14
>> [   19.234116] [drm] nouveau 0000:02:00.0: timingset 255 does not exist
>> [   19.283633] [drm] nouveau 0000:02:00.0: 1 available performance level(s)
>> [   19.283641] [drm] nouveau 0000:02:00.0: 0: memory 400MHz core
>> 350MHz fanspeed 100%
>> [   19.283652] [drm] nouveau 0000:02:00.0: c: memory 399MHz core 199MHz
>> [   19.285459] [TTM] Zone  kernel: Available graphics memory: 510670 kiB.
>> [   19.285463] [TTM] Initializing pool allocator.
>> [   19.285485] [drm] nouveau 0000:02:00.0: Detected 128MiB VRAM
>> [   19.291005] [drm] nouveau 0000:02:00.0: 512 MiB GART (aperture)
>> [   19.302265] [drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
>> [   19.302269] [drm] No driver support for vblank timestamp query.
>> [   19.302751] [drm] nouveau 0000:02:00.0: Setting dpms mode 3 on vga
>> encoder (output 0)
>> [   19.302755] [drm] nouveau 0000:02:00.0: Setting dpms mode 3 on vga
>> encoder (output 1)
>> [   19.302759] [drm] nouveau 0000:02:00.0: Setting dpms mode 3 on tmds
>> encoder (output 2)
>> [   19.302762] [drm] nouveau 0000:02:00.0: Setting dpms mode 3 on TV
>> encoder (output 3)
>> [   19.476604] [drm:drm_edid_block_valid] *ERROR* EDID checksum is
>> invalid, remainder is 65
>> [   19.476609] Raw EDID:
>> [   19.476613] <3>ff ff ff ff ff 00 4c 2d 17 01 37 31 52 41 02 12
>> ......L-..71RA..
>> [   19.476616] <3>01 03 68 1f 17 78 2e ee 91 a3 54 4c 99 26 0f 50
>> ..h..x....TL.&.P
>> [   19.476619] <3>54 bf ee 80 61 59 45 59 31 59 81 80 71 4f 01 01
>> T...aYEY1Y..qO..
>> [   19.476621] <3>01 01 01 01 ea 24 00 60 41 00 28 30 30 60 13 00
>> .....$.`A.(00`..
>> [   19.476624] <3>38 ea 10 00 00 1e 00 00 00 fd 00 32 a0 1e 47 0b
>> 8..........2..G.
>> [   19.476626] <3>00 0a 20 20 20 20 20 20 00 00 00 fc 00 53 79 6e  ..
>>     .....Syn
>> [   19.476629] <3>63 4d 61 73 74 65 72 0a 20 20 00 00 00 ff 00 48
>> cMaster.  .....H
>> [   19.476632] <3>48 41 51 31 30 39 32 33 36 0a 20 20 00 22 40 00
>> HAQ109236.  ."@.
>> [   19.476634]
>> [   20.004439] [drm] nouveau 0000:02:00.0: allocated 1024x768 fb:
>> 0x49000, bo ffff88003c2e1c00
>> [   20.004561] fbcon: nouveaufb (fb0) is primary device
>> [   20.004647] Console: switching to colour frame buffer device 128x48
>> [   20.004672] fb0: nouveaufb frame buffer device
>> [   20.004674] drm: registered panic notifier
>> [   20.004684] [drm] Initialized nouveau 0.0.16 20090420 for
>> 0000:02:00.0 on minor 0
>> [   20.018971] cfg80211: Updating information on frequency 2412 MHz
>> for a 20 MHz width channel with regulatory rule:
>> [   20.018976] cfg80211: 2402000 KHz - 2472000 KHz @  KHz), (600 mBi, 2000 mBm)
>> [   20.018979] cfg80211: Updating information on frequency 2417 MHz
>> for a 20 MHz width channel with regulatory rule:
>> [   20.018982] cfg80211: 2402000 KHz - 2472000 KHz @  KHz), (600 mBi, 2000 mBm)
>> [   20.018985] cfg80211: Updating information on frequency 2422 MHz
>> for a 20 MHz width channel with regulatory rule:
>> [   20.018988] cfg80211: 2402000 KHz - 2472000 KHz @  KHz), (600 mBi, 2000 mBm)
>> [   20.018990] cfg80211: Updating information on frequency 2427 MHz
>> for a 20 MHz width channel with regulatory rule:
>> [   20.018993] cfg80211: 2402000 KHz - 2472000 KHz @  KHz), (600 mBi, 2000 mBm)
>> [   20.018996] cfg80211: Updating information on frequency 2432 MHz
>> for a 20 MHz width channel with regulatory rule:
>> [   20.018999] cfg80211: 2402000 KHz - 2472000 KHz @  KHz), (600 mBi, 2000 mBm)
>> [   20.019001] cfg80211: Updating information on frequency 2437 MHz
>> for a 20 MHz width channel with regulatory rule:
>> [   20.019004] cfg80211: 2402000 KHz - 2472000 KHz @  KHz), (600 mBi, 2000 mBm)
>> [   20.019007] cfg80211: Updating information on frequency 2442 MHz
>> for a 20 MHz width channel with regulatory rule:
>> [   20.019010] cfg80211: 2402000 KHz - 2472000 KHz @  KHz), (600 mBi, 2000 mBm)
>> [   20.019012] cfg80211: Updating information on frequency 2447 MHz
>> for a 20 MHz width channel with regulatory rule:
>> [   20.019015] cfg80211: 2402000 KHz - 2472000 KHz @  KHz), (600 mBi, 2000 mBm)
>> [   20.019018] cfg80211: Updating information on frequency 2452 MHz
>> for a 20 MHz width channel with regulatory rule:
>> [   20.019021] cfg80211: 2402000 KHz - 2472000 KHz @  KHz), (600 mBi, 2000 mBm)
>> [   20.019023] cfg80211: Updating information on frequency 2457 MHz
>> for a 20 MHz width channel with regulatory rule:
>> [   20.019026] cfg80211: 2402000 KHz - 2472000 KHz @  KHz), (600 mBi, 2000 mBm)
>> [   20.019029] cfg80211: Updating information on frequency 2462 MHz
>> for a 20 MHz width channel with regulatory rule:
>> [   20.019032] cfg80211: 2402000 KHz - 2472000 KHz @  KHz), (600 mBi, 2000 mBm)
>> [   20.019034] cfg80211: Updating information on frequency 2467 MHz
>> for a 20 MHz width channel with regulatory rule:
>> [   20.019038] cfg80211: 2457000 KHz - 2482000 KHz @  KHz), (600 mBi, 2000 mBm)
>> [   20.019040] cfg80211: Updating information on frequency 2472 MHz
>> for a 20 MHz width channel with regulatory rule:
>> [   20.019043] cfg80211: 2457000 KHz - 2482000 KHz @  KHz), (600 mBi, 2000 mBm)
>> [   20.019046] cfg80211: Updating information on frequency 2484 MHz
>> for a 20 MHz width channel with regulatory rule:
>> [   20.019049] cfg80211: 2474000 KHz - 2494000 KHz @  KHz), (600 mBi, 2000 mBm)
>> [   20.062553] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
>> [   20.068259] ieee80211 phy0: hwaddr 00:15:af:09:cf:bc, RTL8187vB
>> (default) V1 + rtl8225z2, rfkill mask 2
>> [   20.090376] rtl8187: Customer ID is 0x00
>> [   20.090502] Registered led device: rtl8187-phy0::radio
>> [   20.090546] Registered led device: rtl8187-phy0::tx
>> [   20.090597] Registered led device: rtl8187-phy0::rx
>> [   20.091480] rtl8187: wireless switch is on
>> [   20.091606] usbcore: registered new interface driver rtl8187
>> [   20.204900] ACPI: PCI Interrupt Link [AAZA] enabled at IRQ 20
>> [   20.204911] HDA Intel 0000:00:0e.1: PCI INT B -> Link[AAZA] -> GSI
>> 20 (level, low) -> IRQ 20
>> [   20.204915] hda_intel: msi for device 1043:81f6 set to 0
>> [   20.204955] HDA Intel 0000:00:0e.1: setting latency timer to 64
>> [   20.273135] type=1400 audit(1341463548.033:5): apparmor="STATUS"
>> operation="profile_load"
>> name="/usr/lib/lightdm/lightdm-guest-session-wrapper" pid=960
>> comm="apparmor_parser"
>> [   20.278014] type=1400 audit(1341463548.037:6): apparmor="STATUS"
>> operation="profile_replace" name="/sbin/dhclient" pid=968
>> comm="apparmor_parser"
>> [   20.280796] type=1400 audit(1341463548.041:7): apparmor="STATUS"
>> operation="profile_replace"
>> name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=968
>> comm="apparmor_parser"
>> [   20.281144] type=1400 audit(1341463548.041:8): apparmor="STATUS"
>> operation="profile_replace"
>> name="/usr/lib/connman/scripts/dhclient-script" pid=968
>> comm="apparmor_parser"
>> [   20.356095] ppdev: user-space parallel port driver
>> [   20.398789] type=1400 audit(1341463548.157:9): apparmor="STATUS"
>> operation="profile_load" name="/usr/bin/evince" pid=969
>> comm="apparmor_parser"
>> [   20.439742] type=1400 audit(1341463548.197:10): apparmor="STATUS"
>> operation="profile_load" name="/usr/bin/evince-previewer" pid=969
>> comm="apparmor_parser"
>> [   20.462781] type=1400 audit(1341463548.221:11): apparmor="STATUS"
>> operation="profile_load" name="/usr/bin/evince-thumbnailer" pid=969
>> comm="apparmor_parser"
>> [   20.577367] cfg80211: Updating information on frequency 2412 MHz
>> for a 20 MHz width channel with regulatory rule:
>> [   20.577373] cfg80211: 2402000 KHz - 2472000 KHz @  KHz), (300 mBi, 2000 mBm)
>> [   20.577376] cfg80211: Updating information on frequency 2417 MHz
>> for a 20 MHz width channel with regulatory rule:
>> [   20.577380] cfg80211: 2402000 KHz - 2472000 KHz @  KHz), (300 mBi, 2000 mBm)
>> [   20.577382] cfg80211: Updating information on frequency 2422 MHz
>> for a 20 MHz width channel with regulatory rule:
>> [   20.577385] cfg80211: 2402000 KHz - 2472000 KHz @  KHz), (300 mBi, 2000 mBm)
>> [   20.577388] cfg80211: Updating information on frequency 2427 MHz
>> for a 20 MHz width channel with regulatory rule:
>> [   20.577391] cfg80211: 2402000 KHz - 2472000 KHz @  KHz), (300 mBi, 2000 mBm)
>> [   20.577393] cfg80211: Updating information on frequency 2432 MHz
>> for a 20 MHz width channel with regulatory rule:
>> [   20.577396] cfg80211: 2402000 KHz - 2472000 KHz @  KHz), (300 mBi, 2000 mBm)
>> [   20.577399] cfg80211: Updating information on frequency 2437 MHz
>> for a 20 MHz width channel with regulatory rule:
>> [   20.577402] cfg80211: 2402000 KHz - 2472000 KHz @  KHz), (300 mBi, 2000 mBm)
>> [   20.577404] cfg80211: Updating information on frequency 2442 MHz
>> for a 20 MHz width channel with regulatory rule:
>> [   20.577407] cfg80211: 2402000 KHz - 2472000 KHz @  KHz), (300 mBi, 2000 mBm)
>> [   20.577410] cfg80211: Updating information on frequency 2447 MHz
>> for a 20 MHz width channel with regulatory rule:
>> [   20.577413] cfg80211: 2402000 KHz - 2472000 KHz @  KHz), (300 mBi, 2000 mBm)
>> [   20.577415] cfg80211: Updating information on frequency 2452 MHz
>> for a 20 MHz width channel with regulatory rule:
>> [   20.577418] cfg80211: 2402000 KHz - 2472000 KHz @  KHz), (300 mBi, 2000 mBm)
>> [   20.577421] cfg80211: Updating information on frequency 2457 MHz
>> for a 20 MHz width channel with regulatory rule:
>> [   20.577424] cfg80211: 2402000 KHz - 2472000 KHz @  KHz), (300 mBi, 2000 mBm)
>> [   20.577426] cfg80211: Updating information on frequency 2462 MHz
>> for a 20 MHz width channel with regulatory rule:
>> [   20.577429] cfg80211: 2402000 KHz - 2472000 KHz @  KHz), (300 mBi, 2000 mBm)
>> [   20.577432] cfg80211: Updating information on frequency 2467 MHz
>> for a 20 MHz width channel with regulatory rule:
>> [   20.577435] cfg80211: 2457000 KHz - 2482000 KHz @  KHz), (300 mBi, 2000 mBm)
>> [   20.577437] cfg80211: Updating information on frequency 2472 MHz
>> for a 20 MHz width channel with regulatory rule:
>> [   20.577440] cfg80211: 2457000 KHz - 2482000 KHz @  KHz), (300 mBi, 2000 mBm)
>> [   20.577443] cfg80211: Updating information on frequency 2484 MHz
>> for a 20 MHz width channel with regulatory rule:
>> [   20.577445] cfg80211: 2474000 KHz - 2494000 KHz @  KHz), (300 mBi, 2000 mBm)
>> [   20.577449] cfg80211: World regulatory domain updated:
>> [   20.577451] cfg80211:     (start_freq - end_freq @ bandwidth),
>> (max_antenna_gain, max_eirp)
>> [   20.577454] cfg80211:     (2402000 KHz - 2472000 KHz @ 40000 KHz),
>> (300 mBi, 2000 mBm)
>> [   20.577457] cfg80211:     (2457000 KHz - 2482000 KHz @ 20000 KHz),
>> (300 mBi, 2000 mBm)
>> [   20.577460] cfg80211:     (2474000 KHz - 2494000 KHz @ 20000 KHz),
>> (300 mBi, 2000 mBm)
>> [   20.577463] cfg80211:     (5170000 KHz - 5250000 KHz @ 40000 KHz),
>> (300 mBi, 2000 mBm)
>> [   20.577465] cfg80211:     (5735000 KHz - 5835000 KHz @ 40000 KHz),
>> (300 mBi, 2000 mBm)
>> [   20.865411] init: failsafe main process (874) killed by TERM signal
>> [   20.874553] init: apport pre-start process (1035) terminated with status 1
>> [   20.875814] init: alsa-restore main process (1039) terminated with status 19
>> [   20.940981] init: apport post-stop process (1061) terminated with status 1
>> [   21.186367] [drm:drm_edid_block_valid] *ERROR* EDID checksum is
>> invalid, remainder is 65
>> [   21.186372] Raw EDID:
>> [   21.186375] <3>ff ff ff ff ff 00 4c 2d 17 01 37 31 52 41 02 12
>> ......L-..71RA..
>> [   21.186378] <3>01 03 68 1f 17 78 2e ee 91 a3 54 4c 99 26 0f 50
>> ..h..x....TL.&.P
>> [   21.186380] <3>54 bf ee 80 61 59 45 59 31 59 81 80 71 4f 01 01
>> T...aYEY1Y..qO..
>> [   21.186383] <3>01 01 01 01 ea 24 00 60 41 00 28 30 30 60 13 00
>> .....$.`A.(00`..
>> [   21.186386] <3>38 ea 10 00 00 1e 00 00 00 fd 00 32 a0 1e 47 0b
>> 8..........2..G.
>> [   21.186388] <3>00 0a 20 20 20 20 20 20 00 00 00 fc 00 53 79 6e  ..
>>     .....Syn
>> [   21.186391] <3>63 4d 61 73 74 65 72 0a 20 20 00 00 00 ff 00 48
>> cMaster.  .....H
>> [   21.186393] <3>48 41 51 31 30 39 32 33 36 0a 20 20 00 22 40 00
>> HAQ109236.  ."@.
>> [   21.186395]
>> [   21.546958] [drm:drm_edid_block_valid] *ERROR* EDID checksum is
>> invalid, remainder is 65
>> [   21.546963] Raw EDID:
>> [   21.546966] <3>ff ff ff ff ff 00 4c 2d 17 01 37 31 52 41 02 12
>> ......L-..71RA..
>> [   21.546969] <3>01 03 68 1f 17 78 2e ee 91 a3 54 4c 99 26 0f 50
>> ..h..x....TL.&.P
>> [   21.546972] <3>54 bf ee 80 61 59 45 59 31 59 81 80 71 4f 01 01
>> T...aYEY1Y..qO..
>> [   21.546975] <3>01 01 01 01 ea 24 00 60 41 00 28 30 30 60 13 00
>> .....$.`A.(00`..
>> [   21.546977] <3>38 ea 10 00 00 1e 00 00 00 fd 00 32 a0 1e 47 0b
>> 8..........2..G.
>> [   21.546980] <3>00 0a 20 20 20 20 20 20 00 00 00 fc 00 53 79 6e  ..
>>     .....Syn
>> [   21.546983] <3>63 4d 61 73 74 65 72 0a 20 20 00 00 00 ff 00 48
>> cMaster.  .....H
>> [   21.546985] <3>48 41 51 31 30 39 32 33 36 0a 20 20 00 22 40 00
>> HAQ109236.  ."@.
>> [   21.546987]
>> [   21.716233] Bluetooth: Core ver 2.16
>> [   21.716360] NET: Registered protocol family 31
>> [   21.716362] Bluetooth: HCI device and connection manager initialized
>> [   21.716366] Bluetooth: HCI socket layer initialized
>> [   21.716368] Bluetooth: L2CAP socket layer initialized
>> [   21.717277] Bluetooth: SCO socket layer initialized
>> [   21.768895] Bluetooth: RFCOMM TTY layer initialized
>> [   21.768903] Bluetooth: RFCOMM socket layer initialized
>> [   21.768905] Bluetooth: RFCOMM ver 1.11
>> [   21.829060] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
>> [   21.829066] Bluetooth: BNEP filters: protocol multicast
>> [   21.885383] [drm] nouveau 0000:02:00.0: Setting dpms mode 0 on vga
>> encoder (output 0)
>> [   21.885390] [drm] nouveau 0000:02:00.0: Output VGA-1 is running on
>> CRTC 0 using output A
>> [   23.243710] [drm:drm_edid_block_valid] *ERROR* EDID checksum is
>> invalid, remainder is 65
>> [   23.243716] Raw EDID:
>> [   23.243719] <3>ff ff ff ff ff 00 4c 2d 17 01 37 31 52 41 02 12
>> ......L-..71RA..
>> [   23.243722] <3>01 03 68 1f 17 78 2e ee 91 a3 54 4c 99 26 0f 50
>> ..h..x....TL.&.P
>> [   23.243725] <3>54 bf ee 80 61 59 45 59 31 59 81 80 71 4f 01 01
>> T...aYEY1Y..qO..
>> [   23.243727] <3>01 01 01 01 ea 24 00 60 41 00 28 30 30 60 13 00
>> .....$.`A.(00`..
>> [   23.243730] <3>38 ea 10 00 00 1e 00 00 00 fd 00 32 a0 1e 47 0b
>> 8..........2..G.
>> [   23.243732] <3>00 0a 20 20 20 20 20 20 00 00 00 fc 00 53 79 6e  ..
>>     .....Syn
>> [   23.243735] <3>63 4d 61 73 74 65 72 0a 20 20 00 00 00 ff 00 48
>> cMaster.  .....H
>> [   23.243738] <3>48 41 51 31 30 39 32 33 36 0a 20 20 00 22 40 00
>> HAQ109236.  ."@.
>> [   23.243739]
>> [   23.558169] [drm:drm_edid_block_valid] *ERROR* EDID checksum is
>> invalid, remainder is 170
>> [   23.558174] Raw EDID:
>> [   23.558178] <3>ff ff ff ff ff 00 4c 2d 17 01 37 31 52 41 02 12
>> ......L-..71RA..
>> [   23.558180] <3>01 03 68 1f 17 78 2e ee 91 a3 54 4c 99 26 0f 50
>> ..h..x....TL.&.P
>> [   23.558183] <3>54 bf ee 80 61 59 45 59 31 59 81 80 71 4f 01 01
>> T...aYEY1Y..qO..
>> [   23.558186] <3>01 01 01 01 ea 24 00 60 41 00 28 30 30 60 13 00
>> .....$.`A.(00`..
>> [   23.558188] <3>38 ea 10 00 00 1e 00 00 00 fd 00 32 a0 1e 47 0b
>> 8..........2..G.
>> [   23.558191] <3>00 0a 20 20 20 20 20 20 00 00 00 fc 00 53 79 6e  ..
>>     .....Syn
>> [   23.558193] <3>63 4d 61 73 74 65 72 0a 20 20 00 00 00 ff 00 48
>> cMaster.  .....H
>> [   23.558196] <3>48 41 51 31 30 39 32 33 36 0a 20 20 00 22 a9 00
>> HAQ109236.  ."..
>> [   23.558198]
>> [   23.668561] ADDRCONF(NETDEV_UP): wlan0: link is not ready
>> [   23.906269] [drm:drm_edid_block_valid] *ERROR* EDID checksum is
>> invalid, remainder is 170
>> [   23.906274] Raw EDID:
>> [   23.906277] <3>ff ff ff ff ff 00 4c 2d 17 01 37 31 52 41 02 12
>> ......L-..71RA..
>> [   23.906280] <3>01 03 68 1f 17 78 2e ee 91 a3 54 4c 99 26 0f 50
>> ..h..x....TL.&.P
>> [   23.906283] <3>54 bf ee 80 61 59 45 59 31 59 81 80 71 4f 01 01
>> T...aYEY1Y..qO..
>> [   23.906285] <3>01 01 01 01 ea 24 00 60 41 00 28 30 30 60 13 00
>> .....$.`A.(00`..
>> [   23.906288] <3>38 ea 10 00 00 1e 00 00 00 fd 00 32 a0 1e 47 0b
>> 8..........2..G.
>> [   23.906291] <3>00 0a 20 20 20 20 20 20 00 00 00 fc 00 53 79 6e  ..
>>     .....Syn
>> [   23.906293] <3>63 4d 61 73 74 65 72 0a 20 20 00 00 00 ff 00 48
>> cMaster.  .....H
>> [   23.906296] <3>48 41 51 31 30 39 32 33 36 0a 20 20 00 22 a9 00
>> HAQ109236.  ."..
>> [   23.906298]
>> [   24.391130] [drm:drm_edid_block_valid] *ERROR* EDID checksum is
>> invalid, remainder is 170
>> [   24.391135] Raw EDID:
>> [   24.391139] <3>ff ff ff ff ff 00 4c 2d 17 01 37 31 52 41 02 12
>> ......L-..71RA..
>> [   24.391142] <3>01 03 68 1f 17 78 2e ee 91 a3 54 4c 99 26 0f 50
>> ..h..x....TL.&.P
>> [   24.391145] <3>54 bf ee 80 61 59 45 59 31 59 81 80 71 4f 01 01
>> T...aYEY1Y..qO..
>> [   24.391147] <3>01 01 01 01 ea 24 00 60 41 00 28 30 30 60 13 00
>> .....$.`A.(00`..
>> [   24.391150] <3>38 ea 10 00 00 1e 00 00 00 fd 00 32 a0 1e 47 0b
>> 8..........2..G.
>> [   24.391152] <3>00 0a 20 20 20 20 20 20 00 00 00 fc 00 53 79 6e  ..
>>     .....Syn
>> [   24.391155] <3>63 4d 61 73 74 65 72 0a 20 20 00 00 00 ff 00 48
>> cMaster.  .....H
>> [   24.391158] <3>48 41 51 31 30 39 32 33 36 0a 20 20 00 22 a9 00
>> HAQ109236.  ."..
>> [   24.391160]
>> [   24.794986] [drm:drm_edid_block_valid] *ERROR* EDID checksum is
>> invalid, remainder is 170
>> [   24.794991] Raw EDID:
>> [   24.794995] <3>ff ff ff ff ff 00 4c 2d 17 01 37 31 52 41 02 12
>> ......L-..71RA..
>> [   24.794998] <3>01 03 68 1f 17 78 2e ee 91 a3 54 4c 99 26 0f 50
>> ..h..x....TL.&.P
>> [   24.795000] <3>54 bf ee 80 61 59 45 59 31 59 81 80 71 4f 01 01
>> T...aYEY1Y..qO..
>> [   24.795003] <3>01 01 01 01 ea 24 00 60 41 00 28 30 30 60 13 00
>> .....$.`A.(00`..
>> [   24.795006] <3>38 ea 10 00 00 1e 00 00 00 fd 00 32 a0 1e 47 0b
>> 8..........2..G.
>> [   24.795008] <3>00 0a 20 20 20 20 20 20 00 00 00 fc 00 53 79 6e  ..
>>     .....Syn
>> [   24.795011] <3>63 4d 61 73 74 65 72 0a 20 20 00 00 00 ff 00 48
>> cMaster.  .....H
>> [   24.795013] <3>48 41 51 31 30 39 32 33 36 0a 20 20 00 22 a9 00
>> HAQ109236.  ."..
>> [   24.795015]
>> [   25.060335] EXT4-fs (sda2): re-mounted. Opts: errors=remount-ro,commit=0
>> [   25.449511] init: plymouth-stop pre-start process (1448) terminated
>> with status 1
>> [   26.967958] [drm:drm_edid_block_valid] *ERROR* EDID checksum is
>> invalid, remainder is 170
>> [   26.967963] Raw EDID:
>> [   26.967967] <3>ff ff ff ff ff 00 4c 2d 17 01 37 31 52 41 02 12
>> ......L-..71RA..
>> [   26.967970] <3>01 03 68 1f 17 78 2e ee 91 a3 54 4c 99 26 0f 50
>> ..h..x....TL.&.P
>> [   26.967972] <3>54 bf ee 80 61 59 45 59 31 59 81 80 71 4f 01 01
>> T...aYEY1Y..qO..
>> [   26.967975] <3>01 01 01 01 ea 24 00 60 41 00 28 30 30 60 13 00
>> .....$.`A.(00`..
>> [   26.967978] <3>38 ea 10 00 00 1e 00 00 00 fd 00 32 a0 1e 47 0b
>> 8..........2..G.
>> [   26.967980] <3>00 0a 20 20 20 20 20 20 00 00 00 fc 00 53 79 6e  ..
>>     .....Syn
>> [   26.967983] <3>63 4d 61 73 74 65 72 0a 20 20 00 00 00 ff 00 48
>> cMaster.  .....H
>> [   26.967985] <3>48 41 51 31 30 39 32 33 36 0a 20 20 00 22 a9 00
>> HAQ109236.  ."..
>> [   26.967987]
>> [   27.295395] [drm:drm_edid_block_valid] *ERROR* EDID checksum is
>> invalid, remainder is 170
>> [   27.295401] Raw EDID:
>> [   27.295404] <3>ff ff ff ff ff 00 4c 2d 17 01 37 31 52 41 02 12
>> ......L-..71RA..
>> [   27.295407] <3>01 03 68 1f 17 78 2e ee 91 a3 54 4c 99 26 0f 50
>> ..h..x....TL.&.P
>> [   27.295409] <3>54 bf ee 80 61 59 45 59 31 59 81 80 71 4f 01 01
>> T...aYEY1Y..qO..
>> [   27.295412] <3>01 01 01 01 ea 24 00 60 41 00 28 30 30 60 13 00
>> .....$.`A.(00`..
>> [   27.295414] <3>38 ea 10 00 00 1e 00 00 00 fd 00 32 a0 1e 47 0b
>> 8..........2..G.
>> [   27.295417] <3>00 0a 20 20 20 20 20 20 00 00 00 fc 00 53 79 6e  ..
>>     .....Syn
>> [   27.295420] <3>63 4d 61 73 74 65 72 0a 20 20 00 00 00 ff 00 48
>> cMaster.  .....H
>> [   27.295422] <3>48 41 51 31 30 39 32 33 36 0a 20 20 00 22 a9 00
>> HAQ109236.  ."..
>> [   27.295424]
>> [   30.189439] [drm:drm_edid_block_valid] *ERROR* EDID checksum is
>> invalid, remainder is 41
>> [   30.189445] Raw EDID:
>> [   30.189448] <3>ff ff ff ff ff 00 4c 2d 17 01 37 31 52 41 02 12
>> ......L-..71RA..
>> [   30.189451] <3>01 03 68 1f 17 78 2e ee 91 a3 54 4c 99 26 0f 50
>> ..h..x....TL.&.P
>> [   30.189454] <3>54 bf ee 80 61 59 45 59 31 59 81 80 71 4f 01 01
>> T...aYEY1Y..qO..
>> [   30.189456] <3>01 01 01 01 ea 24 00 60 41 00 28 30 30 60 13 00
>> .....$.`A.(00`..
>> [   30.189459] <3>38 ea 10 00 00 1e 00 00 00 fd 00 32 a0 1e 47 0b
>> 8..........2..G.
>> [   30.189461] <3>00 0a 20 20 20 20 20 20 00 00 00 fc 00 53 79 6e  ..
>>     .....Syn
>> [   30.189464] <3>63 4d 61 73 74 65 72 0a 20 20 00 00 00 ff 00 48
>> cMaster.  .....H
>> [   30.189466] <3>48 41 51 31 30 39 32 33 36 0a 20 20 00 22 28 00
>> HAQ109236.  ."(.
>> [   30.189468]
>> [   30.518309] [drm:drm_edid_block_valid] *ERROR* EDID checksum is
>> invalid, remainder is 41
>> [   30.518314] Raw EDID:
>> [   30.518317] <3>ff ff ff ff ff 00 4c 2d 17 01 37 31 52 41 02 12
>> ......L-..71RA..
>> [   30.518320] <3>01 03 68 1f 17 78 2e ee 91 a3 54 4c 99 26 0f 50
>> ..h..x....TL.&.P
>> [   30.518323] <3>54 bf ee 80 61 59 45 59 31 59 81 80 71 4f 01 01
>> T...aYEY1Y..qO..
>> [   30.518326] <3>01 01 01 01 ea 24 00 60 41 00 28 30 30 60 13 00
>> .....$.`A.(00`..
>> [   30.518328] <3>38 ea 10 00 00 1e 00 00 00 fd 00 32 a0 1e 47 0b
>> 8..........2..G.
>> [   30.518331] <3>00 0a 20 20 20 20 20 20 00 00 00 fc 00 53 79 6e  ..
>>     .....Syn
>> [   30.518333] <3>63 4d 61 73 74 65 72 0a 20 20 00 00 00 ff 00 48
>> cMaster.  .....H
>> [   30.518336] <3>48 41 51 31 30 39 32 33 36 0a 20 20 00 22 28 00
>> HAQ109236.  ."(.
>> [   30.518338]
>> [   31.052805] [drm:drm_edid_block_valid] *ERROR* EDID checksum is
>> invalid, remainder is 41
>> [   31.052811] Raw EDID:
>> [   31.052814] <3>ff ff ff ff ff 00 4c 2d 17 01 37 31 52 41 02 12
>> ......L-..71RA..
>> [   31.052817] <3>01 03 68 1f 17 78 2e ee 91 a3 54 4c 99 26 0f 50
>> ..h..x....TL.&.P
>> [   31.052819] <3>54 bf ee 80 61 59 45 59 31 59 81 80 71 4f 01 01
>> T...aYEY1Y..qO..
>> [   31.052822] <3>01 01 01 01 ea 24 00 60 41 00 28 30 30 60 13 00
>> .....$.`A.(00`..
>> [   31.052824] <3>38 ea 10 00 00 1e 00 00 00 fd 00 32 a0 1e 47 0b
>> 8..........2..G.
>> [   31.052827] <3>00 0a 20 20 20 20 20 20 00 00 00 fc 00 53 79 6e  ..
>>     .....Syn
>> [   31.052830] <3>63 4d 61 73 74 65 72 0a 20 20 00 00 00 ff 00 48
>> cMaster.  .....H
>> [   31.052832] <3>48 41 51 31 30 39 32 33 36 0a 20 20 00 22 28 00
>> HAQ109236.  ."(.
>> [   31.052834]
>> [   31.394156] [drm:drm_edid_block_valid] *ERROR* EDID checksum is
>> invalid, remainder is 41
>> [   31.394161] Raw EDID:
>> [   31.394164] <3>ff ff ff ff ff 00 4c 2d 17 01 37 31 52 41 02 12
>> ......L-..71RA..
>> [   31.394167] <3>01 03 68 1f 17 78 2e ee 91 a3 54 4c 99 26 0f 50
>> ..h..x....TL.&.P
>> [   31.394169] <3>54 bf ee 80 61 59 45 59 31 59 81 80 71 4f 01 01
>> T...aYEY1Y..qO..
>> [   31.394172] <3>01 01 01 01 ea 24 00 60 41 00 28 30 30 60 13 00
>> .....$.`A.(00`..
>> [   31.394175] <3>38 ea 10 00 00 1e 00 00 00 fd 00 32 a0 1e 47 0b
>> 8..........2..G.
>> [   31.394177] <3>00 0a 20 20 20 20 20 20 00 00 00 fc 00 53 79 6e  ..
>>     .....Syn
>> [   31.394180] <3>63 4d 61 73 74 65 72 0a 20 20 00 00 00 ff 00 48
>> cMaster.  .....H
>> [   31.394182] <3>48 41 51 31 30 39 32 33 36 0a 20 20 00 22 28 00
>> HAQ109236.  ."(.
>> [   31.394184]
>> [   31.727736] [drm:drm_edid_block_valid] *ERROR* EDID checksum is
>> invalid, remainder is 41
>> [   31.727741] Raw EDID:
>> [   31.727745] <3>ff ff ff ff ff 00 4c 2d 17 01 37 31 52 41 02 12
>> ......L-..71RA..
>> [   31.727748] <3>01 03 68 1f 17 78 2e ee 91 a3 54 4c 99 26 0f 50
>> ..h..x....TL.&.P
>> [   31.727750] <3>54 bf ee 80 61 59 45 59 31 59 81 80 71 4f 01 01
>> T...aYEY1Y..qO..
>> [   31.727753] <3>01 01 01 01 ea 24 00 60 41 00 28 30 30 60 13 00
>> .....$.`A.(00`..
>> [   31.727756] <3>38 ea 10 00 00 1e 00 00 00 fd 00 32 a0 1e 47 0b
>> 8..........2..G.
>> [   31.727758] <3>00 0a 20 20 20 20 20 20 00 00 00 fc 00 53 79 6e  ..
>>     .....Syn
>> [   31.727761] <3>63 4d 61 73 74 65 72 0a 20 20 00 00 00 ff 00 48
>> cMaster.  .....H
>> [   31.727763] <3>48 41 51 31 30 39 32 33 36 0a 20 20 00 22 28 00
>> HAQ109236.  ."(.
>> [   31.727765]
>> [   32.111167] [drm:drm_edid_block_valid] *ERROR* EDID checksum is
>> invalid, remainder is 41
>> [   32.111172] Raw EDID:
>> [   32.111176] <3>ff ff ff ff ff 00 4c 2d 17 01 37 31 52 41 02 12
>> ......L-..71RA..
>> [   32.111179] <3>01 03 68 1f 17 78 2e ee 91 a3 54 4c 99 26 0f 50
>> ..h..x....TL.&.P
>> [   32.111181] <3>54 bf ee 80 61 59 45 59 31 59 81 80 71 4f 01 01
>> T...aYEY1Y..qO..
>> [   32.111184] <3>01 01 01 01 ea 24 00 60 41 00 28 30 30 60 13 00
>> .....$.`A.(00`..
>> [   32.111187] <3>38 ea 10 00 00 1e 00 00 00 fd 00 32 a0 1e 47 0b
>> 8..........2..G.
>> [   32.111189] <3>00 0a 20 20 20 20 20 20 00 00 00 fc 00 53 79 6e  ..
>>     .....Syn
>> [   32.111192] <3>63 4d 61 73 74 65 72 0a 20 20 00 00 00 ff 00 48
>> cMaster.  .....H
>> [   32.111194] <3>48 41 51 31 30 39 32 33 36 0a 20 20 00 22 28 00
>> HAQ109236.  ."(.
>> [   32.111196]
>> [   32.619148] [drm:drm_edid_block_valid] *ERROR* EDID checksum is
>> invalid, remainder is 41
>> [   32.619153] Raw EDID:
>> [   32.619157] <3>ff ff ff ff ff 00 4c 2d 17 01 37 31 52 41 02 12
>> ......L-..71RA..
>> [   32.619160] <3>01 03 68 1f 17 78 2e ee 91 a3 54 4c 99 26 0f 50
>> ..h..x....TL.&.P
>> [   32.619162] <3>54 bf ee 80 61 59 45 59 31 59 81 80 71 4f 01 01
>> T...aYEY1Y..qO..
>> [   32.619165] <3>01 01 01 01 ea 24 00 60 41 00 28 30 30 60 13 00
>> .....$.`A.(00`..
>> [   32.619168] <3>38 ea 10 00 00 1e 00 00 00 fd 00 32 a0 1e 47 0b
>> 8..........2..G.
>> [   32.619170] <3>00 0a 20 20 20 20 20 20 00 00 00 fc 00 53 79 6e  ..
>>     .....Syn
>> [   32.619173] <3>63 4d 61 73 74 65 72 0a 20 20 00 00 00 ff 00 48
>> cMaster.  .....H
>> [   32.619175] <3>48 41 51 31 30 39 32 33 36 0a 20 20 00 22 28 00
>> HAQ109236.  ."(.
>> [   32.619177]
>>
>>
>> lspci output:
>>
>> 07:00.0 Multimedia video controller: Texas Instruments Device b800 (rev 01)
>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx-
>>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>         Latency: 0, Cache Line Size: 32 bytes
>>         Interrupt: pin A routed to IRQ 11
>>         Region 0: Memory at fddff000 (64-bit, non-prefetchable) [size=4K]
>>         Region 2: Memory at bf000000 (64-bit, prefetchable) [size=16M]
>>         Region 4: Memory at 40000000 (64-bit, prefetchable) [size=1G]
>>         Capabilities: [40] Power Management version 3
>>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>         Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>>                 Address: 0000000000000000  Data: 0000
>>         Capabilities: [70] Express (v2) Endpoint, MSI 00
>>                 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <1us, L1 <8us
>>                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>>                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>>                         MaxPayload 128 bytes, MaxReadReq 512 bytes
>>                 DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
>>                 LnkCap: Port #0, Speed 5GT/s, Width x2, ASPM L0s, Latency L0 <512ns, L1 <64us
>>                         ClockPM- Surprise- LLActRep- BwNot-
>>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
>>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>                 LnkSta: Speed 2.5GT/s, Width x2, TrErr- Train- SlotClk+ DLActive-
>> BWMgmt- ABWMgmt-
>>                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
>>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
>>                 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
>> Selectable De-emphasis: -6dB
>>                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
>> ComplianceSOS-
>>                          Compliance De-emphasis: -6dB
>>                 LnkSta2: Current De-emphasis Level: -3.5dB
>>         Capabilities: [100 v1] Advanced Error Reporting
>>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
>> MalfTLP- ECRC- UnsupReq- ACSViol-
>>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
>> MalfTLP- ECRC- UnsupReq- ACSViol-
>>                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
>> MalfTLP+ ECRC- UnsupReq- ACSViol-
>>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>>                 AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
>> 00: 4c 10 00 b8 07 00 10 00 01 00 00 04 08 00 00 00
>> 10: 04 f0 df fd 00 00 00 00 0c 00 00 bf 00 00 00 00
>> 20: 0c 00 00 40 00 00 00 00 00 00 00 00 00 00 01 00
>> 30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 00 00
>> 40: 01 50 03 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 50: 05 70 80 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 70: 10 00 02 00 01 87 00 00 10 28 09 00 22 34 03 00
>> 80: 40 00 21 10 00 00 00 00 00 00 00 00 00 00 00 00
>> 90: 00 00 00 00 1f 00 00 00 00 00 00 00 00 00 00 00
>> a0: 02 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
>> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>
>> Regards,
>> Flyingbee.
>>
>>
>> On Wed, Jul 4, 2012 at 7:29 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>> On Wed, Jul 4, 2012 at 12:33 AM, sumit chaudhary
>>> <flyingbee.linux@gmail.com> wrote:
>>>> Hi,
>>>> I have a 64 bit PCIe card that is connected to 64 bit PC running
>>>> ubuntu (Linux ubuntu 3.0.0-12-generic #20-Ubuntu SMP Fri Oct 7
>>>> 14:56:25 UTC 2011 x86_64 x86_64 x86_64 GNU/Linux). Linux enumerate
>>>> this PCIe card and assign 64 bit addresses to 64 bit BARS.
>>>>
>>>> Problem is that higher 4 bytes of these addresses are zero, even if
>>>> they are 64 bit address
>>>> they lies in 32 bit range.
>>>>
>>>> Is it somehow possible to assign real 64 bit addresses ?
>>>>
>>>> This is lspci output on my ubuntu PC.
>>>>
>>>> Region 0: Memory at fddff000 (64-bit, non-prefetchable) [size=4K]
>>>> Region 2: Memory at fd000000 (64-bit, prefetchable) [size=8M]
>>>> Region 4: Memory at fc800000 (64-bit, prefetchable) [size=8M]
>>>
>>> Thanks for this report.  64-bit addresses should work, so there must
>>> be a problem here.  Can you collect the complete dmesg log?  That will
>>> contain more details about exactly what's going on.  A dmesg log from
>>> a more recent kernel, e.g., 3.4, would also be useful, just in case
>>> this problem has already been fixed.
>>>
>>> Bjorn
