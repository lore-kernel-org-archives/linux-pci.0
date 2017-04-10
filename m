Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 10 Apr 2017 23:21:22 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: 4.11-rc*: PCI IRQ allocation broken
Message-ID: <alpine.LRH.2.20.1704102317110.14071@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This happens on my HP Compaq 8100 Elite SFF PC. While 4.10 works fine, 
4.11.-rc5 and at least back to 4.10.0-10770-g2d6be4abf514 fail to assign 
PCI IRQ to multiple devices (no GSI messages in the dmesg). This results 
in mouse in one USB port working and keyboard in another USB port not 
working, reproducibly.

Will bisect.

[    0.000000] Linux version 4.11.0-rc5-00033-g308ac7563944 (mroos@prometheus) (gcc version 6.3.0 20170321 (Debian 6.3.0-11) ) #64 SMP Wed Apr 5 12:29:53 EEST 2017
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.11.0-rc5-00033-g308ac7563944 root=/dev/sda1 ro
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009f7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f800-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e8000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000db7ac43f] usable
[    0.000000] BIOS-e820: [mem 0x00000000db7ac440-0x00000000db7ae49f] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000db7ae4a0-0x00000000dfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f4000000-0x00000000f7ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fed3ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed45000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x0000000117ffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.6 present.
[    0.000000] DMI: Hewlett-Packard HP Compaq 8100 Elite SFF PC/304Ah, BIOS 786H1 v01.13 07/14/2011
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x118000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-E3FFF write-protect
[    0.000000]   E4000-EFFFF write-back
[    0.000000]   F0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask E00000000 write-back
[    0.000000]   1 base 0DB800000 mask FFF800000 uncachable
[    0.000000]   2 base 0DC000000 mask FFC000000 uncachable
[    0.000000]   3 base 0E0000000 mask FE0000000 uncachable
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT  
[    0.000000] e820: update [mem 0xdb800000-0xffffffff] usable ==> reserved
[    0.000000] e820: last_pfn = 0xdb7ac max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000f9bf0-0x000f9bff] mapped at [ffff8800000f9bf0]
[    0.000000] Base memory trampoline at [ffff880000099000] 99000 size 24576
[    0.000000] BRK [0x019cf000, 0x019cffff] PGTABLE
[    0.000000] BRK [0x019d0000, 0x019d0fff] PGTABLE
[    0.000000] BRK [0x019d1000, 0x019d1fff] PGTABLE
[    0.000000] BRK [0x019d2000, 0x019d2fff] PGTABLE
[    0.000000] BRK [0x019d3000, 0x019d3fff] PGTABLE
[    0.000000] BRK [0x019d4000, 0x019d4fff] PGTABLE
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000E5210 000014 (v00 COMPAQ)
[    0.000000] ACPI: RSDT 0x00000000DB7D0540 000044 (v01 HPQOEM SLIC-BPC 20110714      00000000)
[    0.000000] ACPI: FACP 0x00000000DB7D05E8 000074 (v01 COMPAQ IBEXPEAK 00000001      00000000)
[    0.000000] ACPI BIOS Warning (bug): Optional FADT field Pm2ControlBlock has valid Address but zero Length: 0x0000000000000050/0x0 (20170119/tbfadt-658)
[    0.000000] ACPI BIOS Warning (bug): Invalid length for FADT/Pm2ControlBlock: 0, using default 8 (20170119/tbfadt-708)
[    0.000000] ACPI: DSDT 0x00000000DB7D0A4F 00A144 (v01 COMPAQ DSDT_PRJ 00000001 MSFT 0100000E)
[    0.000000] ACPI: FACS 0x00000000DB7D0500 000040
[    0.000000] ACPI: APIC 0x00000000DB7D065C 0000BC (v01 COMPAQ IBEXPEAK 00000001      00000000)
[    0.000000] ACPI: ASF! 0x00000000DB7D0718 000063 (v32 COMPAQ IBEXPEAK 00000001      00000000)
[    0.000000] ACPI: MCFG 0x00000000DB7D077B 00003C (v01 COMPAQ IBEXPEAK 00000001      00000000)
[    0.000000] ACPI: TCPA 0x00000000DB7D07B7 000032 (v01 COMPAQ IBEXPEAK 00000001      00000000)
[    0.000000] ACPI: SLIC 0x00000000DB7D07E9 000176 (v01 HPQOEM SLIC-BPC 00000001      00000000)
[    0.000000] ACPI: HPET 0x00000000DB7D095F 000038 (v01 COMPAQ IBEXPEAK 00000001      00000000)
[    0.000000] ACPI: DMAR 0x00000000DB7D0997 0000B8 (v01 COMPAQ IBEXPEAK 00000001      00000000)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x0000000117ffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000db7abfff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x0000000117ffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x0000000117ffffff]
[    0.000000] On node 0 totalpages: 997194
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 13983 pages used for memmap
[    0.000000]   DMA32 zone: 894892 pages, LIFO batch:31
[    0.000000]   Normal zone: 1536 pages used for memmap
[    0.000000]   Normal zone: 98304 pages, LIFO batch:31
[    0.000000] Reserving Intel graphics memory at 0x00000000de000000-0x00000000dfffffff
[    0.000000] ACPI: PM-Timer IO Port: 0xf808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 8 CPUs, 4 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000e7fff]
[    0.000000] PM: Registered nosave memory: [mem 0x000e8000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xdb7ac000-0xdb7acfff]
[    0.000000] PM: Registered nosave memory: [mem 0xdb7ad000-0xdb7adfff]
[    0.000000] PM: Registered nosave memory: [mem 0xdb7ae000-0xdb7aefff]
[    0.000000] PM: Registered nosave memory: [mem 0xdb7af000-0xdfffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xe0000000-0xf3ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf4000000-0xf7ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf8000000-0xfdffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfe000000-0xfed3ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed40000-0xfed44fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed45000-0xffffffff]
[    0.000000] e820: [mem 0xe0000000-0xf3ffffff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
[    0.000000] percpu: Embedded 35 pages/cpu @ffff880117c00000 s105432 r8192 d29736 u262144
[    0.000000] pcpu-alloc: s105432 r8192 d29736 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 981590
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.11.0-rc5-00033-g308ac7563944 root=/dev/sda1 ro
[    0.000000] log_buf_len individual max cpu contribution: 16384 bytes
[    0.000000] log_buf_len total cpu_extra contributions: 114688 bytes
[    0.000000] log_buf_len min size: 131072 bytes
[    0.000000] log_buf_len: 262144 bytes
[    0.000000] early log buf free: 122320(93%)
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.000000] Memory: 3841596K/3988776K available (6118K kernel code, 490K rwdata, 1760K rodata, 876K init, 448K bss, 147180K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] NR_IRQS:4352 nr_irqs:488 16
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.008000] tsc: Detected 3325.212 MHz processor
[    0.008000] Calibrating delay loop (skipped), value calculated using timer frequency.. 6650.42 BogoMIPS (lpj=13300848)
[    0.008000] pid_max: default: 32768 minimum: 301
[    0.008000] ACPI: Core revision 20170119
[    0.008000] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.008000] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
[    0.008000] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes)
[    0.008000] CPU: Physical Processor ID: 0
[    0.008000] CPU: Processor Core ID: 0
[    0.008000] mce: CPU supports 9 MCE banks
[    0.008000] CPU0: Thermal monitoring enabled (TM1)
[    0.008000] process: using mwait in idle threads
[    0.008000] Last level iTLB entries: 4KB 512, 2MB 7, 4MB 7
[    0.008000] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    0.008000] Freeing SMP alternatives memory: 24K
[    0.012060] smpboot: Max logical packages: 4
[    0.012097] DMAR: Host address width 36
[    0.012129] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.012168] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap c9008020e30272 ecap 1000
[    0.012228] DMAR: DRHD base: 0x000000fed91000 flags: 0x0
[    0.012265] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap c0000020230272 ecap 1000
[    0.012325] DMAR: DRHD base: 0x000000fed93000 flags: 0x1
[    0.012361] DMAR: dmar2: reg_base_addr fed93000 ver 1:0 cap c9008020630272 ecap 1000
[    0.012421] DMAR: RMRR base: 0x000000db7de000 end: 0x000000db7e7fff
[    0.012459] DMAR: RMRR base: 0x000000ddc00000 end: 0x000000dfffffff
[    0.012861] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.056000] smpboot: CPU0: Intel(R) Core(TM) i5 CPU         660  @ 3.33GHz (family: 0x6, model: 0x25, stepping: 0x5)
[    0.056000] Performance Events: PEBS fmt1+, Westmere events, 16-deep LBR, Intel PMU driver.
[    0.056000] core: CPUID marked event: 'bus cycles' unavailable
[    0.056000] ... version:                3
[    0.056000] ... bit width:              48
[    0.056000] ... generic registers:      4
[    0.056000] ... value mask:             0000ffffffffffff
[    0.056000] ... max period:             000000007fffffff
[    0.056000] ... fixed-purpose events:   3
[    0.056000] ... event mask:             000000070000000f
[    0.056000] smp: Bringing up secondary CPUs ...
[    0.056000] x86: Booting SMP configuration:
[    0.056000] .... node  #0, CPUs:      #1
[    0.134024] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.134024]  #2 #3
[    0.294020] smp: Brought up 1 node, 4 CPUs
[    0.294020] smpboot: Total of 4 processors activated (26602.27 BogoMIPS)
[    0.294020] sched_clock: Marking stable (292000000, 0)->(394047493, -102047493)
[    0.293991] devtmpfs: initialized
[    0.294148] PM: Registering ACPI NVS region [mem 0xdb7ac440-0xdb7ae49f] (8288 bytes)
[    0.294214] reboot: HP Compaq Laptop series board detected. Selecting BIOS-method for reboots.
[    0.294311] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.294379] futex hash table entries: 2048 (order: 5, 131072 bytes)
[    0.294530] NET: Registered protocol family 16
[    0.294677] cpuidle: using governor ladder
[    0.294727] cpuidle: using governor menu
[    0.294761] PCCT header not found.
[    0.294808] ACPI: bus type PCI registered
[    0.294869] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf4000000-0xf7ffffff] (base 0xf4000000)
[    0.294934] PCI: MMCONFIG at [mem 0xf4000000-0xf7ffffff] reserved in E820
[    0.294978] pmd_set_huge: Cannot satisfy [mem 0xf4000000-0xf4200000] with a huge-page mapping due to MTRR override.
[    0.296091] PCI: Using configuration type 1 for base access
[    0.297019] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.297197] ACPI: Added _OSI(Module Device)
[    0.297230] ACPI: Added _OSI(Processor Device)
[    0.297264] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.297297] ACPI: Added _OSI(Processor Aggregator Device)
[    0.298521] ACPI: Dynamic OEM Table Load:
[    0.298558] ACPI: SSDT 0xFFFF880113383000 0003BA (v01 COMPAQ CPU_TM2  00000001 MSFT 0100000E)
[    0.298760] ACPI: Dynamic OEM Table Load:
[    0.298795] ACPI: SSDT 0xFFFF880113383400 0003D8 (v01 COMPAQ CST      00000001 MSFT 0100000E)
[    0.299259] ACPI: Interpreter enabled
[    0.299304] ACPI: (supports S0 S3 S4 S5)
[    0.299337] ACPI: Using IOAPIC for interrupt routing
[    0.299385] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.302013] acpi LNXCPU:00: Invalid PBLK length [7]
[    0.302052] acpi LNXCPU:01: Invalid PBLK length [7]
[    0.302090] acpi LNXCPU:02: Invalid PBLK length [7]
[    0.302127] acpi LNXCPU:03: Invalid PBLK length [7]
[    0.302276] acpi PNP0A08:00: [Firmware Bug]: no secondary bus range in _CRS
[    0.302317] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.302356] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.302419] ACPI BIOS Error (bug): \_SB.PCI0._OSC: Excess arguments - ASL declared 5, ACPI requires 4 (20170119/nsarguments-189)
[    0.302515] ACPI Error: [CAPD] Namespace lookup failure, AE_ALREADY_EXISTS (20170119/dsfield-211)
[    0.302579] ACPI Error: Method parse/execution failed [\_SB.PCI0._OSC] (Node ffff880113031668), AE_ALREADY_EXISTS (20170119/psparse-543)
[    0.302654] acpi PNP0A08:00: _OSC failed (AE_ALREADY_EXISTS); disabling ASPM
[    0.302696] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-3f] only partially covers this bridge
[    0.302850] acpi PNP0A08:00: failed to parse _CRS method, error code -5
[    0.302889] acpi PNP0A08:00: Bus 0000:00 not present in PCI namespace
[    0.302974] ACPI: Enabled 1 GPEs in block 00 to 3F
[    0.303055] vgaarb: loaded
[    0.303118] SCSI subsystem initialized
[    0.303172] libata version 3.00 loaded.
[    0.303187] PCI: Using ACPI for IRQ routing
[    0.303220] PCI: Discovered peer bus 00
[    0.303252] PCI: root bus 00: using default resources
[    0.303253] PCI: Probing PCI hardware (bus 00)
[    0.303270] ACPI: \: failed to evaluate _DSM (0x1001)
[    0.303304] PCI host bridge to bus 0000:00
[    0.303338] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.303375] pci_bus 0000:00: root bus resource [mem 0x00000000-0xfffffffff]
[    0.303415] pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
[    0.303481] pci 0000:00:00.0: [8086:0040] type 00 class 0x060000
[    0.303495] DMAR: Disabling batched IOTLB flush on Ironlake
[    0.303561] pci 0000:00:02.0: [8086:0042] type 00 class 0x030000
[    0.303568] pci 0000:00:02.0: reg 0x10: [mem 0xf0000000-0xf03fffff 64bit]
[    0.303572] pci 0000:00:02.0: reg 0x18: [mem 0xe0000000-0xefffffff 64bit pref]
[    0.303575] pci 0000:00:02.0: reg 0x20: [io  0x1170-0x1177]
[    0.303602] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.303640] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.303726] pci 0000:00:16.0: [8086:3b64] type 00 class 0x078000
[    0.303749] pci 0000:00:16.0: reg 0x10: [mem 0xf042a000-0xf042a00f 64bit]
[    0.303832] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.303864] pci 0000:00:16.3: [8086:3b67] type 00 class 0x070002
[    0.303875] pci 0000:00:16.3: reg 0x10: [io  0x1188-0x118f]
[    0.303882] pci 0000:00:16.3: reg 0x14: [mem 0xf0424000-0xf0424fff]
[    0.303977] pci 0000:00:19.0: [8086:10ef] type 00 class 0x020000
[    0.303988] pci 0000:00:19.0: reg 0x10: [mem 0xf0400000-0xf041ffff]
[    0.303994] pci 0000:00:19.0: reg 0x14: [mem 0xf0425000-0xf0425fff]
[    0.304000] pci 0000:00:19.0: reg 0x18: [io  0x1100-0x111f]
[    0.304044] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    0.304072] pci 0000:00:1a.0: [8086:3b3c] type 00 class 0x0c0320
[    0.304085] pci 0000:00:1a.0: reg 0x10: [mem 0xf0427000-0xf04273ff]
[    0.304152] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    0.304183] pci 0000:00:1b.0: [8086:3b56] type 00 class 0x040300
[    0.304195] pci 0000:00:1b.0: reg 0x10: [mem 0xf0420000-0xf0423fff 64bit]
[    0.304251] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.304284] pci 0000:00:1c.0: [8086:3b42] type 01 class 0x060400
[    0.304334] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.304347] pci 0000:00:1c.0: Enabling MPC IRBNCE
[    0.304382] pci 0000:00:1c.0: Intel PCH root port ACS workaround enabled
[    0.304446] pci 0000:00:1c.4: [8086:3b4a] type 01 class 0x060400
[    0.304496] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.304507] pci 0000:00:1c.4: Enabling MPC IRBNCE
[    0.304541] pci 0000:00:1c.4: Intel PCH root port ACS workaround enabled
[    0.304604] pci 0000:00:1c.6: [8086:3b4e] type 01 class 0x060400
[    0.304653] pci 0000:00:1c.6: PME# supported from D0 D3hot D3cold
[    0.304664] pci 0000:00:1c.6: Enabling MPC IRBNCE
[    0.304699] pci 0000:00:1c.6: Intel PCH root port ACS workaround enabled
[    0.304765] pci 0000:00:1d.0: [8086:3b34] type 00 class 0x0c0320
[    0.304779] pci 0000:00:1d.0: reg 0x10: [mem 0xf0428000-0xf04283ff]
[    0.304844] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.304872] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
[    0.304929] pci 0000:00:1f.0: [8086:3b0a] type 00 class 0x060100
[    0.305036] pci 0000:00:1f.2: [8086:3b22] type 00 class 0x010601
[    0.305046] pci 0000:00:1f.2: reg 0x10: [io  0x1190-0x1197]
[    0.305052] pci 0000:00:1f.2: reg 0x14: [io  0x11a8-0x11ab]
[    0.305057] pci 0000:00:1f.2: reg 0x18: [io  0x1198-0x119f]
[    0.305062] pci 0000:00:1f.2: reg 0x1c: [io  0x11ac-0x11af]
[    0.305068] pci 0000:00:1f.2: reg 0x20: [io  0x1120-0x113f]
[    0.305073] pci 0000:00:1f.2: reg 0x24: [mem 0xf0426000-0xf04267ff]
[    0.305102] pci 0000:00:1f.2: PME# supported from D3hot
[    0.305153] pci 0000:00:1c.0: PCI bridge to [bus 18]
[    0.305220] pci 0000:00:1c.4: PCI bridge to [bus 24]
[    0.305284] pci 0000:00:1c.6: PCI bridge to [bus 30]
[    0.305371] pci 0000:00:1e.0: PCI bridge to [bus 0d] (subtractive decode)
[    0.305415] pci 0000:00:1e.0:   bridge window [io  0x0000-0xffff] (subtractive decode)
[    0.305416] pci 0000:00:1e.0:   bridge window [mem 0x00000000-0xfffffffff] (subtractive decode)
[    0.305431] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 30
[    0.306525] PCI: Discovered peer bus 3f
[    0.306557] PCI: root bus 3f: using default resources
[    0.306557] PCI: Probing PCI hardware (bus 3f)
[    0.306570] ACPI: \: failed to evaluate _DSM (0x1001)
[    0.306605] PCI host bridge to bus 0000:3f
[    0.306637] pci_bus 0000:3f: root bus resource [io  0x0000-0xffff]
[    0.306675] pci_bus 0000:3f: root bus resource [mem 0x00000000-0xfffffffff]
[    0.306714] pci_bus 0000:3f: No busn resource found for root bus, will use [bus 3f-ff]
[    0.306776] pci 0000:3f:00.0: [8086:2c61] type 00 class 0x060000
[    0.306802] pci 0000:3f:00.1: [8086:2d01] type 00 class 0x060000
[    0.306828] pci 0000:3f:02.0: [8086:2d10] type 00 class 0x060000
[    0.306852] pci 0000:3f:02.1: [8086:2d11] type 00 class 0x060000
[    0.306876] pci 0000:3f:02.2: [8086:2d12] type 00 class 0x060000
[    0.306899] pci 0000:3f:02.3: [8086:2d13] type 00 class 0x060000
[    0.306931] pci_bus 0000:3f: busn_res: [bus 3f-ff] end is updated to 3f
[    0.306932] PCI: pci_cache_line_size set to 64 bytes
[    0.306961] e820: reserve RAM buffer [mem 0x0009f800-0x0009ffff]
[    0.306962] e820: reserve RAM buffer [mem 0xdb7ac440-0xdbffffff]
[    0.307055] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.307096] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.309148] clocksource: Switched to clocksource hpet
[    0.309240] pnp: PnP ACPI init
[    0.309301] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.309650] pnp 00:01: can't evaluate _CRS: 12316
[    0.309702] system 00:01: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.309708] pnp: PnP ACPI: found 2 devices
[    0.315182] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.315254] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 18] add_size 1000
[    0.315256] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 18] add_size 200000 add_align 100000
[    0.315258] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff] to [bus 18] add_size 200000 add_align 100000
[    0.315263] pci 0000:00:1c.4: bridge window [io  0x1000-0x0fff] to [bus 24] add_size 1000
[    0.315264] pci 0000:00:1c.4: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 24] add_size 200000 add_align 100000
[    0.315265] pci 0000:00:1c.4: bridge window [mem 0x00100000-0x000fffff] to [bus 24] add_size 200000 add_align 100000
[    0.315270] pci 0000:00:1c.6: bridge window [io  0x1000-0x0fff] to [bus 30] add_size 1000
[    0.315271] pci 0000:00:1c.6: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 30] add_size 200000 add_align 100000
[    0.315272] pci 0000:00:1c.6: bridge window [mem 0x00100000-0x000fffff] to [bus 30] add_size 200000 add_align 100000
[    0.315282] pci 0000:00:1c.0: BAR 14: assigned [mem 0xf0500000-0xf06fffff]
[    0.315323] pci 0000:00:1c.0: BAR 15: assigned [mem 0x118000000-0x1181fffff 64bit pref]
[    0.315384] pci 0000:00:1c.4: BAR 14: assigned [mem 0xf0700000-0xf08fffff]
[    0.315424] pci 0000:00:1c.4: BAR 15: assigned [mem 0x118200000-0x1183fffff 64bit pref]
[    0.315485] pci 0000:00:1c.6: BAR 14: assigned [mem 0xf0900000-0xf0afffff]
[    0.315525] pci 0000:00:1c.6: BAR 15: assigned [mem 0x118400000-0x1185fffff 64bit pref]
[    0.315586] pci 0000:00:1c.0: BAR 13: assigned [io  0x2000-0x2fff]
[    0.315624] pci 0000:00:1c.4: BAR 13: assigned [io  0x3000-0x3fff]
[    0.315662] pci 0000:00:1c.6: BAR 13: assigned [io  0x4000-0x4fff]
[    0.315701] pci 0000:00:1c.0: PCI bridge to [bus 18]
[    0.315736] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
[    0.315776] pci 0000:00:1c.0:   bridge window [mem 0xf0500000-0xf06fffff]
[    0.315816] pci 0000:00:1c.0:   bridge window [mem 0x118000000-0x1181fffff 64bit pref]
[    0.315880] pci 0000:00:1c.4: PCI bridge to [bus 24]
[    0.315915] pci 0000:00:1c.4:   bridge window [io  0x3000-0x3fff]
[    0.315954] pci 0000:00:1c.4:   bridge window [mem 0xf0700000-0xf08fffff]
[    0.315994] pci 0000:00:1c.4:   bridge window [mem 0x118200000-0x1183fffff 64bit pref]
[    0.316058] pci 0000:00:1c.6: PCI bridge to [bus 30]
[    0.316093] pci 0000:00:1c.6:   bridge window [io  0x4000-0x4fff]
[    0.316132] pci 0000:00:1c.6:   bridge window [mem 0xf0900000-0xf0afffff]
[    0.316172] pci 0000:00:1c.6:   bridge window [mem 0x118400000-0x1185fffff 64bit pref]
[    0.316235] pci 0000:00:1e.0: PCI bridge to [bus 0d]
[    0.316277] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
[    0.316278] pci_bus 0000:00: resource 5 [mem 0x00000000-0xfffffffff]
[    0.316278] pci_bus 0000:18: resource 0 [io  0x2000-0x2fff]
[    0.316279] pci_bus 0000:18: resource 1 [mem 0xf0500000-0xf06fffff]
[    0.316280] pci_bus 0000:18: resource 2 [mem 0x118000000-0x1181fffff 64bit pref]
[    0.316281] pci_bus 0000:24: resource 0 [io  0x3000-0x3fff]
[    0.316282] pci_bus 0000:24: resource 1 [mem 0xf0700000-0xf08fffff]
[    0.316283] pci_bus 0000:24: resource 2 [mem 0x118200000-0x1183fffff 64bit pref]
[    0.316283] pci_bus 0000:30: resource 0 [io  0x4000-0x4fff]
[    0.316284] pci_bus 0000:30: resource 1 [mem 0xf0900000-0xf0afffff]
[    0.316285] pci_bus 0000:30: resource 2 [mem 0x118400000-0x1185fffff 64bit pref]
[    0.316286] pci_bus 0000:0d: resource 4 [io  0x0000-0xffff]
[    0.316287] pci_bus 0000:0d: resource 5 [mem 0x00000000-0xfffffffff]
[    0.316288] pci_bus 0000:3f: resource 4 [io  0x0000-0xffff]
[    0.316289] pci_bus 0000:3f: resource 5 [mem 0x00000000-0xfffffffff]
[    0.316308] NET: Registered protocol family 2
[    0.316443] TCP established hash table entries: 32768 (order: 6, 262144 bytes)
[    0.316546] TCP bind hash table entries: 32768 (order: 7, 524288 bytes)
[    0.316654] TCP: Hash tables configured (established 32768 bind 32768)
[    0.316724] UDP hash table entries: 2048 (order: 4, 65536 bytes)
[    0.316771] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes)
[    0.316850] NET: Registered protocol family 1
[    0.316893] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.316966] pci 0000:00:1a.0: can't derive routing for PCI INT A
[    0.317003] pci 0000:00:1a.0: PCI INT A: no GSI
[    0.317061] pci 0000:00:1d.0: can't derive routing for PCI INT A
[    0.317098] pci 0000:00:1d.0: PCI INT A: no GSI
[    0.317164] PCI: CLS 64 bytes, default 64
[    0.317185] DMAR: No ATSR found
[    0.318437] DMAR: dmar1: Using Register based invalidation
[    0.318491] DMAR: dmar0: Using Register based invalidation
[    0.318537] DMAR: dmar2: Using Register based invalidation
[    0.318593] DMAR: Setting RMRR:
[    0.318696] DMAR: Setting identity map for device 0000:00:02.0 [0xddc00000 - 0xdfffffff]
[    0.319232] DMAR: Setting identity map for device 0000:00:1a.0 [0xdb7de000 - 0xdb7e7fff]
[    0.319364] DMAR: Setting identity map for device 0000:00:1d.0 [0xdb7de000 - 0xdb7e7fff]
[    0.319447] DMAR: Prepare 0-16MiB unity mapping for LPC
[    0.319535] DMAR: Setting identity map for device 0000:00:1f.0 [0x0 - 0xffffff]
[    0.327545] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    0.327635] iommu: Adding device 0000:00:00.0 to group 0
[    0.327675] iommu: Adding device 0000:00:02.0 to group 1
[    0.327721] iommu: Adding device 0000:00:16.0 to group 2
[    0.327761] iommu: Adding device 0000:00:16.3 to group 2
[    0.327801] iommu: Adding device 0000:00:19.0 to group 3
[    0.327841] iommu: Adding device 0000:00:1a.0 to group 4
[    0.327881] iommu: Adding device 0000:00:1b.0 to group 5
[    0.327921] iommu: Adding device 0000:00:1c.0 to group 6
[    0.327964] iommu: Adding device 0000:00:1c.4 to group 7
[    0.328005] iommu: Adding device 0000:00:1c.6 to group 8
[    0.328045] iommu: Adding device 0000:00:1d.0 to group 9
[    0.328085] iommu: Adding device 0000:00:1e.0 to group 10
[    0.328129] iommu: Adding device 0000:00:1f.0 to group 11
[    0.328170] iommu: Adding device 0000:00:1f.2 to group 11
[    0.328216] iommu: Adding device 0000:3f:00.0 to group 12
[    0.328257] iommu: Adding device 0000:3f:00.1 to group 12
[    0.328304] iommu: Adding device 0000:3f:02.0 to group 13
[    0.328345] iommu: Adding device 0000:3f:02.1 to group 13
[    0.328386] iommu: Adding device 0000:3f:02.2 to group 13
[    0.328426] iommu: Adding device 0000:3f:02.3 to group 13
[    0.330077] workingset: timestamp_bits=46 max_order=20 bucket_order=0
[    0.331611] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    0.331672] io scheduler noop registered
[    0.331705] io scheduler deadline registered
[    0.331763] io scheduler cfq registered (default)
[    0.331798] io scheduler mq-deadline registered
[    0.331885] pcieport 0000:00:1c.0: can't derive routing for PCI INT A
[    0.331924] pcieport 0000:00:1c.0: PCI INT A: no GSI
[    0.332032] pcieport 0000:00:1c.4: can't derive routing for PCI INT A
[    0.332071] pcieport 0000:00:1c.4: PCI INT A: no GSI
[    0.332165] pcieport 0000:00:1c.6: can't derive routing for PCI INT C
[    0.332203] pcieport 0000:00:1c.6: PCI INT C: no GSI
[    0.332313] pcieport 0000:00:1c.0: Signaling PME with IRQ 27
[    0.332361] pcieport 0000:00:1c.4: Signaling PME with IRQ 28
[    0.332407] pcieport 0000:00:1c.6: Signaling PME with IRQ 29
[    0.332450] intel_idle: MWAIT substates: 0x1120
[    0.332451] intel_idle: v0.4.1 model 0x25
[    0.332534] intel_idle: lapic_timer_reliable_states 0xffffffff
[    0.332574] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.332638] ACPI: Power Button [PBTN]
[    0.332694] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.332754] ACPI: Power Button [PWRF]
[    0.332887] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.353305] serial8250: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.353710] serial 0000:00:16.3: can't derive routing for PCI INT B
[    0.354753] serial 0000:00:16.3: PCI INT B: no GSI
[    0.375186] 0000:00:16.3: ttyS1 at I/O 0x1188 (irq = 11, base_baud = 115200) is a 16550A
[    0.375636] Linux agpgart interface v0.103
[    0.375786] i915 0000:00:02.0: can't derive routing for PCI INT A
[    0.375824] i915 0000:00:02.0: PCI INT A: no GSI
[    0.375983] pci 0000:00:00.0: Intel HD Graphics Chipset
[    0.376030] pci 0000:00:00.0: detected gtt size: 2097152K total, 262144K mappable
[    0.376663] pci 0000:00:00.0: detected 32768K stolen memory
[    0.376793] [drm] Memory usable by graphics device = 2048M
[    0.376829] [drm] VT-d active for gfx access
[    0.376863] [drm] Replacing VGA console driver
[    0.377528] Console: switching to colour dummy device 80x25
[    0.377717] [drm] DMAR active, disabling use of stolen memory
[    0.377729] [drm] ACPI BIOS requests an excessive sleep of 4294705151 ms, using 1500 ms instead
[    0.377784] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    0.377787] [drm] Driver supports precise vblank timestamp query.
[    0.377925] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    0.439877] [drm] RC6 disabled, disabling runtime PM support
[    0.440065] [drm] Initialized i915 1.6.0 20170123 for 0000:00:02.0 on minor 0
[    0.440131] [drm] Initialized i915 1.6.0 20170123 for 0000:00:02.0 on minor 0
[    0.440568] mei_me 0000:00:16.0: can't derive routing for PCI INT A
[    0.440579] mei_me 0000:00:16.0: PCI INT A: no GSI
[    0.444216] ahci 0000:00:1f.2: version 3.0
[    0.444219] ahci 0000:00:1f.2: can't derive routing for PCI INT B
[    0.444223] ahci 0000:00:1f.2: PCI INT B: no GSI
[    0.444293] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 3 Gbps 0x17 impl SATA mode
[    0.444299] ahci 0000:00:1f.2: flags: 64bit ncq sntf pm led clo pio slum part sxs apst 
[    0.444943] scsi host0: ahci
[    0.445242] scsi host1: ahci
[    0.445428] scsi host2: ahci
[    0.445517] scsi host3: ahci
[    0.445600] scsi host4: ahci
[    0.445680] scsi host5: ahci
[    0.445732] ata1: SATA max UDMA/133 abar m2048@0xf0426000 port 0xf0426100 irq 32
[    0.445737] ata2: SATA max UDMA/133 abar m2048@0xf0426000 port 0xf0426180 irq 32
[    0.445742] ata3: SATA max UDMA/133 abar m2048@0xf0426000 port 0xf0426200 irq 32
[    0.445746] ata4: DUMMY
[    0.445749] ata5: SATA max UDMA/133 abar m2048@0xf0426000 port 0xf0426300 irq 32
[    0.445753] ata6: DUMMY
[    0.445796] i8042: PNP: No PS/2 controller found.
[    0.445800] i8042: Probing ports directly.
[    0.448633] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.448648] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.448828] mousedev: PS/2 mouse device common for all mice
[    0.448910] rtc_cmos 00:00: RTC can wake from S4
[    0.449048] rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
[    0.449072] rtc_cmos 00:00: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    0.449217] NET: Registered protocol family 10
[    0.449968] Segment Routing with IPv6
[    0.449983] mip6: Mobile IPv6
[    0.449986] NET: Registered protocol family 17
[    0.449995] Key type dns_resolver registered
[    0.450164] microcode: sig=0x20655, pf=0x2, revision=0x2
[    0.450201] microcode: Microcode Update Driver: v2.2.
[    0.450286] registered taskstats version 1
[    0.458254] Key type big_key registered
[    0.458368] Key type encrypted registered
[    0.458498] console [netcon0] enabled
[    0.458501] netconsole: network logging started
[    0.458532] rtc_cmos 00:00: setting system clock to 2017-04-05 10:52:05 UTC (1491389525)
[    0.458554] PM: Hibernation image not present or could not be loaded.
[    0.491369] fbcon: inteldrmfb (fb0) is primary device
[    0.577629] Console: switching to colour frame buffer device 240x67
[    0.594344] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    0.760883] ata3: SATA link down (SStatus 0 SControl 300)
[    0.760970] ata5: SATA link down (SStatus 0 SControl 300)
[    0.761024] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    0.761078] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    0.762119] ata1.00: ATA-8: Hitachi HDS721025CLA682, JP1OA41A, max UDMA/133
[    0.762183] ata1.00: 488397168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    0.763285] ata2.00: ATAPI: hp       CDDVDW TS-H653T, H6D1, max UDMA/100
[    0.763458] ata1.00: configured for UDMA/133
[    0.764043] scsi 0:0:0:0: Direct-Access     ATA      Hitachi HDS72102 A41A PQ: 0 ANSI: 5
[    0.764525] sd 0:0:0:0: [sda] 488397168 512-byte logical blocks: (250 GB/233 GiB)
[    0.764545] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    0.764593] sd 0:0:0:0: [sda] Write Protect is off
[    0.764614] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.764625] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    0.765844] ata2.00: configured for UDMA/100
[    0.767111] scsi 1:0:0:0: CD-ROM            hp       CDDVDW TS-H653T  H6D1 PQ: 0 ANSI: 5
[    0.792440] sr 1:0:0:0: [sr0] scsi3-mmc drive: 40x/40x writer dvd-ram cd/rw xa/form2 cdda tray
[    0.792502] cdrom: Uniform CD-ROM driver Revision: 3.20
[    0.792664] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    0.792826] sr 1:0:0:0: Attached scsi generic sg1 type 5
[    0.810842]  sda: sda1 sda2 < sda5 >
[    0.811352] sd 0:0:0:0: [sda] Attached SCSI disk
[    0.843935] EXT4-fs (sda1): couldn't mount as ext3 due to feature incompatibilities
[    0.844195] EXT4-fs (sda1): couldn't mount as ext2 due to feature incompatibilities
[    0.882501] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[    0.882537] VFS: Mounted root (ext4 filesystem) readonly on device 8:1.
[    0.928800] devtmpfs: mounted
[    0.929591] Freeing unused kernel memory: 876K
[    0.929609] Write protecting the kernel read-only data: 8192k
[    0.929780] Freeing unused kernel memory: 4K
[    0.930321] Freeing unused kernel memory: 288K
[    0.931904] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.998854] random: fast init done
[    1.345303] tsc: Refined TSC clocksource calibration: 3325.374 MHz
[    1.345353] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2feeee04428, max_idle_ns: 440795258727 ns
[    2.369306] clocksource: Switched to clocksource tsc
[    2.403753] ip_tables: (C) 2000-2006 Netfilter Core Team
[    2.516040] systemd[1]: systemd 232 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
[    2.516190] systemd[1]: Detected architecture x86-64.
[    2.564061] systemd[1]: Set hostname to <prometheus>.
[    5.198157] systemd[1]: Configuration file /etc/systemd/system/postfix.service.d/override.conf is marked world-inaccessible. This has no effect as configuration data is accessible via APIs without restrictions. Proceeding anyway.
[    5.427338] systemd[1]: Listening on Journal Socket.
[    5.430663] systemd[1]: Listening on Syslog Socket.
[    5.434013] systemd[1]: Created slice System Slice.
[    5.437544] systemd[1]: Starting Set the console keyboard layout...
[    5.440786] systemd[1]: Created slice system-postfix.slice.
[    5.444047] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
[    6.223534] lp: driver loaded but no devices found
[    6.258423] parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
[    6.260583] parport0: irq 7 detected
[    6.357667] lp0: using parport0 (polling).
[    6.459024] loop: module loaded
[   28.201244] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
[   28.263823] systemd-journald[152]: Received request to flush runtime journal from PID 1
[   28.610868] pps_core: LinuxPPS API ver. 1 registered
[   28.612593] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[   28.643274] ACPI: bus type USB registered
[   28.644410] usbcore: registered new interface driver usbfs
[   28.645513] usbcore: registered new interface driver hub
[   28.646713] usbcore: registered new device driver usb
[   28.651884] PTP clock support registered
[   28.674493] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   28.695302] input: PC Speaker as /devices/platform/pcspkr/input/input4
[   28.733201] ehci-pci: EHCI PCI platform driver
[   28.734346] ehci-pci 0000:00:1a.0: can't derive routing for PCI INT A
[   28.735450] ehci-pci 0000:00:1a.0: PCI INT A: no GSI
[   28.736585] ehci-pci 0000:00:1a.0: EHCI Host Controller
[   28.737672] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 1
[   28.738854] ehci-pci 0000:00:1a.0: debug port 2
[   28.743866] ehci-pci 0000:00:1a.0: cache line size of 64 is not supported
[   28.743879] ehci-pci 0000:00:1a.0: irq 10, io mem 0xf0427000
[   28.762551] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[   28.763753] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[   28.764998] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   28.766104] usb usb1: Product: EHCI Host Controller
[   28.767277] usb usb1: Manufacturer: Linux 4.11.0-rc5-00033-g308ac7563944 ehci_hcd
[   28.768354] usb usb1: SerialNumber: 0000:00:1a.0
[   28.769544] hub 1-0:1.0: USB hub found
[   28.770629] hub 1-0:1.0: 3 ports detected
[   28.771972] ehci-pci 0000:00:1d.0: can't derive routing for PCI INT A
[   28.773050] ehci-pci 0000:00:1d.0: PCI INT A: no GSI
[   28.774138] ehci-pci 0000:00:1d.0: EHCI Host Controller
[   28.775244] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 2
[   28.776334] ehci-pci 0000:00:1d.0: debug port 2
[   28.781410] ehci-pci 0000:00:1d.0: cache line size of 64 is not supported
[   28.781423] ehci-pci 0000:00:1d.0: irq 10, io mem 0xf0428000
[   28.789289] iTCO_vendor_support: vendor-support=0
[   28.794544] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[   28.795682] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[   28.796803] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   28.797854] usb usb2: Product: EHCI Host Controller
[   28.798968] usb usb2: Manufacturer: Linux 4.11.0-rc5-00033-g308ac7563944 ehci_hcd
[   28.800168] usb usb2: SerialNumber: 0000:00:1d.0
[   28.801348] hub 2-0:1.0: USB hub found
[   28.802437] hub 2-0:1.0: 3 ports detected
[   28.818076] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[   28.819323] iTCO_wdt: Found a Q57 TCO device (Version=2, TCOBASE=0xf860)
[   28.820894] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[   28.831284] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[   28.832377] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[   28.833478] e1000e 0000:00:19.0: can't derive routing for PCI INT B
[   28.834572] e1000e 0000:00:19.0: PCI INT B: no GSI
[   28.835813] e1000e 0000:00:19.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[   28.854147] random: crng init done
[   29.037038] e1000e 0000:00:19.0 eth0: (PCI Express:2.5GT/s:Width x1) 78:e3:b5:a0:e5:e4
[   29.038202] e1000e 0000:00:19.0 eth0: Intel(R) PRO/1000 Network Connection
[   29.039413] e1000e 0000:00:19.0 eth0: MAC: 9, PHY: 9, PBA No: A002FF-0FF
[   29.098608] usb 1-1: new high-speed USB device number 2 using ehci-pci
[   29.134623] usb 2-1: new high-speed USB device number 2 using ehci-pci
[   29.417886] Error: Driver 'pcspkr' is already registered, aborting...
[   29.556124] snd_hda_intel 0000:00:1b.0: can't derive routing for PCI INT A
[   29.557337] snd_hda_intel 0000:00:1b.0: PCI INT A: no GSI
[   29.674980] input: ImPS/2 Logitech Wheel Mouse as /devices/platform/i8042/serio1/input/input5
[   29.724786] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC662 rev1: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
[   29.725911] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=1 (0x15/0x0/0x0/0x0/0x0)
[   29.727026] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[   29.728130] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[   29.729212] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[   29.730296] snd_hda_codec_realtek hdaudioC0D0:      Mic=0x19
[   29.731368] snd_hda_codec_realtek hdaudioC0D0:      Line=0x18
[   29.781137] snd_hda_intel 0000:00:1b.0: bound 0000:00:02.0 (ops 0xffffffff816641e0)
[   29.784095] input: HDA Intel MID Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input6
[   29.785457] input: HDA Intel MID Line as /devices/pci0000:00/0000:00:1b.0/sound/card0/input7
[   29.786726] input: HDA Intel MID Line Out as /devices/pci0000:00/0000:00:1b.0/sound/card0/input8
[   29.787866] input: HDA Intel MID Front Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input9
[   29.789009] input: HDA Intel MID HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1b.0/sound/card0/input10
[   29.828273] SSE version of gcm_enc/dec engaged.
[   30.176298] kvm: VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL does not work properly. Using workaround
[   30.338863] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   30.934379] Adding 7532540k swap on /dev/sda5.  Priority:-1 extents:1 across:7532540k 
[   33.443959] e1000e: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
[   33.445022] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   45.254790] usb 2-1: device not accepting address 2, error -110
[   45.254793] usb 1-1: device not accepting address 2, error -110
[   45.374774] usb 2-1: new high-speed USB device number 3 using ehci-pci
[   45.374781] usb 1-1: new high-speed USB device number 3 using ehci-pci
[   61.374853] usb 1-1: device not accepting address 3, error -110
[   61.374863] usb 2-1: device not accepting address 3, error -110
[   61.494750] usb 2-1: new high-speed USB device number 4 using ehci-pci
[   61.494756] usb 1-1: new high-speed USB device number 4 using ehci-pci
[   72.121190] usb 1-1: device not accepting address 4, error -110
[   72.121210] usb 2-1: device not accepting address 4, error -110
[   72.241123] usb 2-1: new high-speed USB device number 5 using ehci-pci
[   72.241132] usb 1-1: new high-speed USB device number 5 using ehci-pci
[   82.867624] usb 1-1: device not accepting address 5, error -110
[   82.867634] usb 2-1: device not accepting address 5, error -110
[   82.867652] usb usb1-port1: unable to enumerate USB device
[   82.867658] usb usb2-port1: unable to enumerate USB device
[ 6799.493954] perf: interrupt took too long (2514 > 2500), lowering kernel.perf_event_max_sample_rate to 79500
[11280.005162] perf: interrupt took too long (3147 > 3142), lowering kernel.perf_event_max_sample_rate to 63500
[20388.091400] perf: interrupt took too long (3975 > 3933), lowering kernel.perf_event_max_sample_rate to 50250
[45404.205981] perf: interrupt took too long (4975 > 4968), lowering kernel.perf_event_max_sample_rate to 40000
[261183.534799] perf: interrupt took too long (6241 > 6218), lowering kernel.perf_event_max_sample_rate to 32000

-- 
Meelis Roos (mroos@linux.ee)
