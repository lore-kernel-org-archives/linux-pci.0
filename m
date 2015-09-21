Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.14]:56662 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752312AbbIUS05 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 21 Sep 2015 14:26:57 -0400
MIME-Version: 1.0
Message-ID: <trinity-364bfb74-1aa5-4393-a4bd-0991f9d94d6b-1442860011291@3capp-webde-bs20>
From: "Roland Weber" <r-o-l@web.de>
To: linux-usb@vger.kernel.org
Cc: "Mathias Nyman" <mathias.nyman@intel.com>,
	"Bjorn Helgaas" <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: PROBLEM: lsusb -v freezes kernel on Acer ES1-111M
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Sep 2015 20:26:51 +0200
In-Reply-To: <Pine.LNX.4.44L0.1509151010160.1420-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1509151010160.1420-100000@iolanthe.rowland.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Alan,

> Assuming things work out as expected, try this: In core/hub.c, remove 
> the calls to usb_enable_autosuspend(hdev) in hub_probe() and leave 
> CONFIG_PM enabled.

This one does not freeze!

cheers,
  Roland

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.2.0-j (rweber@Nightwing) (gcc version 4.9.2 (Ubuntu 4.9.2-10ubuntu13) ) #39 SMP Sun Sep 20 22:21:01 CEST 2015
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.2.0-j root=UUID=b8872e03-7295-4cbd-ac86-06b9be2f112f ro debug systemd.log_target=null quiet splash crashkernel=384M-:128M vt.handoff=7
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000] x86/fpu: Legacy x87 FPU detected.
[    0.000000] x86/fpu: Using 'lazy' FPU context switches.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009e7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e800-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001effffff] usable
[    0.000000] BIOS-e820: [mem 0x000000001f000000-0x000000001f0fffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000001f100000-0x000000001fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000020000000-0x00000000200fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000020100000-0x00000000781acfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000781ad000-0x00000000787acfff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000787ad000-0x00000000788acfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000788ad000-0x00000000788ecfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000788ed000-0x00000000794c5fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000794c6000-0x0000000079dc5fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000079dc6000-0x0000000079ffffff] usable
[    0.000000] BIOS-e820: [mem 0x000000007a000000-0x000000007a7fffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007ae00000-0x000000007fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000e3ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed01000-0x00000000fed01fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed03000-0x00000000fed03fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed08000-0x00000000fed08fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed0c000-0x00000000fed0ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1cfff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fef00000-0x00000000feffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffc00000-0x00000000ffffffff] reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: Acer Aspire ES1-111M/R2, BIOS V1.08 08/20/2014
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x7a000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0FFC00000 mask FFFC00000 write-protect
[    0.000000]   1 base 000000000 mask F80000000 write-back
[    0.000000]   2 base 07C000000 mask FFC000000 uncachable
[    0.000000]   3 base 07B000000 mask FFF000000 uncachable
[    0.000000]   4 base 07AE00000 mask FFFE00000 uncachable
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT  
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 24576
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] BRK [0x13faa000, 0x13faafff] PGTABLE
[    0.000000] BRK [0x13fab000, 0x13fabfff] PGTABLE
[    0.000000] BRK [0x13fac000, 0x13facfff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x79e00000-0x79ffffff]
[    0.000000]  [mem 0x79e00000-0x79ffffff] page 2M
[    0.000000] BRK [0x13fad000, 0x13fadfff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x60000000-0x781acfff]
[    0.000000]  [mem 0x60000000-0x77ffffff] page 2M
[    0.000000]  [mem 0x78000000-0x781acfff] page 4k
[    0.000000] BRK [0x13fae000, 0x13faefff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x788ed000-0x794c5fff]
[    0.000000]  [mem 0x788ed000-0x789fffff] page 4k
[    0.000000]  [mem 0x78a00000-0x793fffff] page 2M
[    0.000000]  [mem 0x79400000-0x794c5fff] page 4k
[    0.000000] BRK [0x13faf000, 0x13faffff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x79dc6000-0x79dfffff]
[    0.000000]  [mem 0x79dc6000-0x79dfffff] page 4k
[    0.000000] init_memory_mapping: [mem 0x40000000-0x5fffffff]
[    0.000000]  [mem 0x40000000-0x5fffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x00100000-0x1effffff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0x1effffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x1f100000-0x1fffffff]
[    0.000000]  [mem 0x1f100000-0x1f1fffff] page 4k
[    0.000000]  [mem 0x1f200000-0x1fffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x20100000-0x3fffffff]
[    0.000000]  [mem 0x20100000-0x201fffff] page 4k
[    0.000000]  [mem 0x20200000-0x3fffffff] page 2M
[    0.000000] RAMDISK: [mem 0x360bc000-0x37055fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000FE020 000024 (v02 ACRSYS)
[    0.000000] ACPI: XSDT 0x00000000788EC120 0000AC (v01 ACRSYS ACRPRDCT 00000003      01000013)
[    0.000000] ACPI: FACP 0x00000000788E9000 00010C (v05 ACRSYS ACRPRDCT 00000003 1025 00040000)
[    0.000000] ACPI: DSDT 0x00000000788DC000 007DB8 (v02 ACRSYS ACRPRDCT 00000003 1025 00040000)
[    0.000000] ACPI: FACS 0x0000000078876000 000040
[    0.000000] ACPI: UEFI 0x00000000788EB000 000236 (v01 ACRSYS ACRPRDCT 00000001 1025 00040000)
[    0.000000] ACPI: MSDM 0x00000000788EA000 000055 (v03 ACRSYS ACRPRDCT 00000001 1025 00040000)
[    0.000000] ACPI: HPET 0x00000000788E8000 000038 (v01 ACRSYS ACRPRDCT 00000003 1025 00040000)
[    0.000000] ACPI: LPIT 0x00000000788E7000 000104 (v01 ACRSYS ACRPRDCT 00000003 1025 00040000)
[    0.000000] ACPI: APIC 0x00000000788E6000 000084 (v03 ACRSYS ACRPRDCT 00000003 1025 00040000)
[    0.000000] ACPI: MCFG 0x00000000788E5000 00003C (v01 ACRSYS ACRPRDCT 00000003 1025 00040000)
[    0.000000] ACPI: SSDT 0x00000000788E4000 000581 (v01 ACRSYS ACRPRDCT 00000003 1025 00040000)
[    0.000000] ACPI: SSDT 0x00000000788DA000 00138A (v01 ACRSYS ACRPRDCT 00000003 1025 00040000)
[    0.000000] ACPI: SSDT 0x00000000788D9000 000763 (v01 ACRSYS ACRPRDCT 00003000 1025 00040000)
[    0.000000] ACPI: SSDT 0x00000000788D8000 000290 (v01 ACRSYS ACRPRDCT 00003000 1025 00040000)
[    0.000000] ACPI: SSDT 0x00000000788D7000 00017A (v01 ACRSYS ACRPRDCT 00003000 1025 00040000)
[    0.000000] ACPI: UEFI 0x00000000788D6000 000042 (v01 ACRSYS ACRPRDCT 00000000 1025 00040000)
[    0.000000] ACPI: SSDT 0x00000000788D2000 003060 (v01 ACRSYS ACRPRDCT 00001000 1025 00040000)
[    0.000000] ACPI: CSRT 0x00000000788D1000 00014C (v00 ACRSYS ACRPRDCT 00000005 1025 00040000)
[    0.000000] ACPI: SSDT 0x00000000788D0000 0003E6 (v01 ACRSYS ACRPRDCT 00001000 1025 00040000)
[    0.000000] ACPI: FPDT 0x00000000788CF000 000044 (v01 ACRSYS ACRPRDCT 00000002 1025 00040000)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x0000000079ffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x79ff7000-0x79ffbfff]
[    0.000000] Reserving 128MB of memory at 736MB for crashkernel (System RAM: 1933MB)
[    0.000000]  [ffffea0000000000-ffffea0001ffffff] PMD -> [ffff880076000000-ffff880077ffffff] on node 0
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x0000000079ffffff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009dfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000001effffff]
[    0.000000]   node   0: [mem 0x000000001f100000-0x000000001fffffff]
[    0.000000]   node   0: [mem 0x0000000020100000-0x00000000781acfff]
[    0.000000]   node   0: [mem 0x00000000788ed000-0x00000000794c5fff]
[    0.000000]   node   0: [mem 0x0000000079dc6000-0x0000000079ffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x0000000079ffffff]
[    0.000000] On node 0 totalpages: 494941
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3997 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 7744 pages used for memmap
[    0.000000]   DMA32 zone: 490944 pages, LIFO batch:31
[    0.000000] x86/hpet: Will disable the HPET for this platform because it's not reliable
[    0.000000] Reserving Intel graphics stolen memory at 0x7b000000-0x7effffff
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] high level lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-86
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 4 CPUs, 2 hotplug CPUs
[    0.000000] e820: [mem 0x80000000-0xdfffffff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Embedded 32 pages/cpu @ffff880079200000 s91864 r8192 d31016 u524288
[    0.000000] pcpu-alloc: s91864 r8192 d31016 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 487112
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.2.0-j root=UUID=b8872e03-7295-4cbd-ac86-06b9be2f112f ro debug systemd.log_target=null quiet splash crashkernel=384M-:128M vt.handoff=7
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 1783000K/1979764K available (7014K kernel code, 1221K rwdata, 3496K rodata, 1240K init, 1256K bss, 196764K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=4.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=4
[    0.000000] NR_IRQS:16640 nr_irqs:1024 16
[    0.000000] 	Offload RCU callbacks from all CPUs
[    0.000000] 	Offload RCU callbacks from CPUs: 0-3.
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] Maximum core-clock to bus-clock ratio: 0x1a
[    0.000000] Resolved frequency ID: 0, frequency: 83200 KHz
[    0.000000] TSC runs at 2163200 KHz
[    0.000000] lapic_timer_frequency = 332800
[    0.000000] tsc: Detected 2163.200 MHz processor
[    0.000030] Calibrating delay loop (skipped), value calculated using timer frequency.. 4326.40 BogoMIPS (lpj=8652800)
[    0.000035] pid_max: default: 32768 minimum: 301
[    0.000047] ACPI: Core revision 20150619
[    0.017551] ACPI: All ACPI Tables successfully acquired
[    0.017591] Security Framework initialized
[    0.017602] AppArmor: AppArmor initialized
[    0.017604] Yama: becoming mindful.
[    0.017853] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.018720] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.019137] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
[    0.019147] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes)
[    0.019480] Initializing cgroup subsys blkio
[    0.019488] Initializing cgroup subsys memory
[    0.019504] Initializing cgroup subsys devices
[    0.019509] Initializing cgroup subsys freezer
[    0.019514] Initializing cgroup subsys net_cls
[    0.019519] Initializing cgroup subsys perf_event
[    0.019524] Initializing cgroup subsys net_prio
[    0.019529] Initializing cgroup subsys hugetlb
[    0.019555] CPU: Physical Processor ID: 0
[    0.019557] CPU: Processor Core ID: 0
[    0.019562] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.019564] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.024336] mce: CPU supports 6 MCE banks
[    0.024344] CPU0: Thermal monitoring handled by SMI
[    0.024349] process: using mwait in idle threads
[    0.024355] Last level iTLB entries: 4KB 48, 2MB 0, 4MB 0
[    0.024358] Last level dTLB entries: 4KB 128, 2MB 16, 4MB 16, 1GB 0
[    0.024497] Freeing SMP alternatives memory: 24K (ffffffff93e69000 - ffffffff93e6f000)
[    0.041039] ftrace: allocating 27348 entries in 107 pages
[    0.056000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.095676] TSC deadline timer enabled
[    0.095681] smpboot: CPU0: Intel(R) Celeron(R) CPU  N2840  @ 2.16GHz (fam: 06, model: 37, stepping: 08)
[    0.095715] Performance Events: PEBS fmt2+, 8-deep LBR, Silvermont events, full-width counters, Intel PMU driver.
[    0.095729] ... version:                3
[    0.095732] ... bit width:              40
[    0.095733] ... generic registers:      2
[    0.095736] ... value mask:             000000ffffffffff
[    0.095738] ... max period:             000000ffffffffff
[    0.095739] ... fixed-purpose events:   3
[    0.095741] ... event mask:             0000000700000003
[    0.096990] x86: Booting SMP configuration:
[    0.096996] .... node  #0, CPUs:      #1
[    0.102758] CPU1: Thermal monitoring handled by SMI
[    0.104840] x86: Booted up 1 node, 2 CPUs
[    0.104848] smpboot: Total of 2 processors activated (8652.80 BogoMIPS)
[    0.104978] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.105558] devtmpfs: initialized
[    0.111506] evm: security.selinux
[    0.111509] evm: security.SMACK64
[    0.111511] evm: security.SMACK64EXEC
[    0.111513] evm: security.SMACK64TRANSMUTE
[    0.111515] evm: security.SMACK64MMAP
[    0.111517] evm: security.ima
[    0.111518] evm: security.capability
[    0.111733] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.111868] pinctrl core: initialized pinctrl subsystem
[    0.112255] NET: Registered protocol family 16
[    0.116846] cpuidle: using governor ladder
[    0.120857] cpuidle: using governor menu
[    0.121002] ACPI: bus type PCI registered
[    0.121124] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xe0000000-0xe3ffffff] (base 0xe0000000)
[    0.121129] PCI: MMCONFIG at [mem 0xe0000000-0xe3ffffff] reserved in E820
[    0.121139] PCI: Using configuration type 1 for base access
[    0.129438] ACPI: Added _OSI(Module Device)
[    0.129443] ACPI: Added _OSI(Processor Device)
[    0.129446] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.129448] ACPI: Added _OSI(Processor Aggregator Device)
[    0.141360] ACPI: Dynamic OEM Table Load:
[    0.141376] ACPI: SSDT 0xFFFF880078C17800 000440 (v01 PmRef  Cpu0Ist  00003000 INTL 20130117)
[    0.142287] ACPI: Dynamic OEM Table Load:
[    0.142299] ACPI: SSDT 0xFFFF880075AC8000 000433 (v01 PmRef  Cpu0Cst  00003001 INTL 20130117)
[    0.143582] ACPI: Dynamic OEM Table Load:
[    0.143594] ACPI: SSDT 0xFFFF880075A79000 00015F (v01 PmRef  ApIst    00003000 INTL 20130117)
[    0.144471] ACPI: Dynamic OEM Table Load:
[    0.144482] ACPI: SSDT 0xFFFF880075AB2180 00008D (v01 PmRef  ApCst    00003000 INTL 20130117)
[    0.145580] ACPI : EC: EC started
[    0.145899] ACPI: Interpreter enabled
[    0.145912] ACPI: (supports S0 S5)
[    0.145915] ACPI: Using IOAPIC for interrupt routing
[    0.145971] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.554765] ACPI: Power Resource [USBC] (on)
[    0.563148] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.563159] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.563708] \_SB_.PCI0:_OSC invalid UUID
[    0.563711] _OSC request data:1 1f 0 
[    0.563718] acpi PNP0A08:00: _OSC failed (AE_ERROR); disabling ASPM
[    0.563955] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-3f] only partially covers this bridge
[    0.564093] PCI host bridge to bus 0000:00
[    0.564099] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.564104] pci_bus 0000:00: root bus resource [io  0x0070-0x0077]
[    0.564108] pci_bus 0000:00: root bus resource [io  0x0000-0x006f window]
[    0.564111] pci_bus 0000:00: root bus resource [io  0x0078-0x0cf7 window]
[    0.564115] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.564119] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.564122] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
[    0.564126] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000fffff window]
[    0.564130] pci_bus 0000:00: root bus resource [mem 0x80000000-0x909ffffe window]
[    0.564142] pci 0000:00:00.0: [8086:0f00] type 00 class 0x060000
[    0.564302] pci 0000:00:02.0: [8086:0f31] type 00 class 0x030000
[    0.564322] pci 0000:00:02.0: reg 0x10: [mem 0x90000000-0x903fffff]
[    0.564335] pci 0000:00:02.0: reg 0x18: [mem 0x80000000-0x8fffffff pref]
[    0.564346] pci 0000:00:02.0: reg 0x20: [io  0x2050-0x2057]
[    0.564502] pci 0000:00:12.0: [8086:0f16] type 00 class 0x080501
[    0.564527] pci 0000:00:12.0: reg 0x10: [mem 0x90921000-0x90921fff]
[    0.564539] pci 0000:00:12.0: reg 0x14: [mem 0x90920000-0x90920fff]
[    0.564600] pci 0000:00:12.0: PME# supported from D0 D3hot
[    0.564721] pci 0000:00:14.0: [8086:0f35] type 00 class 0x0c0330
[    0.564749] pci 0000:00:14.0: reg 0x10: [mem 0x90900000-0x9090ffff 64bit]
[    0.564810] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.564936] pci 0000:00:17.0: [8086:0f50] type 00 class 0x080501
[    0.564961] pci 0000:00:17.0: reg 0x10: [mem 0x9091e000-0x9091efff]
[    0.564973] pci 0000:00:17.0: reg 0x14: [mem 0x9091d000-0x9091dfff]
[    0.565034] pci 0000:00:17.0: PME# supported from D0 D3hot
[    0.565161] pci 0000:00:1a.0: [8086:0f18] type 00 class 0x108000
[    0.565202] pci 0000:00:1a.0: reg 0x10: [mem 0x90800000-0x908fffff]
[    0.565217] pci 0000:00:1a.0: reg 0x14: [mem 0x90700000-0x907fffff]
[    0.565304] pci 0000:00:1a.0: PME# supported from D0 D3hot
[    0.565431] pci 0000:00:1b.0: [8086:0f04] type 00 class 0x040300
[    0.565464] pci 0000:00:1b.0: reg 0x10: [mem 0x90910000-0x90913fff 64bit]
[    0.565525] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.565645] pci 0000:00:1c.0: [8086:0f48] type 01 class 0x060400
[    0.565704] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.565827] pci 0000:00:1c.1: [8086:0f4a] type 01 class 0x060400
[    0.565885] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.566006] pci 0000:00:1c.2: [8086:0f4c] type 01 class 0x060400
[    0.566064] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.566194] pci 0000:00:1d.0: [8086:0f34] type 00 class 0x0c0320
[    0.566234] pci 0000:00:1d.0: reg 0x10: [mem 0x90918000-0x909183ff]
[    0.566330] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.566454] pci 0000:00:1f.0: [8086:0f1c] type 00 class 0x060100
[    0.566648] pci 0000:00:1f.3: [8086:0f12] type 00 class 0x0c0500
[    0.566696] pci 0000:00:1f.3: reg 0x10: [mem 0x90919000-0x9091901f]
[    0.566769] pci 0000:00:1f.3: reg 0x20: [io  0x2000-0x201f]
[    0.567014] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.567101] pci 0000:02:00.0: [168c:0036] type 00 class 0x028000
[    0.567144] pci 0000:02:00.0: reg 0x10: [mem 0x90600000-0x9067ffff 64bit]
[    0.567196] pci 0000:02:00.0: reg 0x30: [mem 0xffff0000-0xffffffff pref]
[    0.567244] pci 0000:02:00.0: supports D1 D2
[    0.567248] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.572823] pci 0000:00:1c.1: PCI bridge to [bus 02]
[    0.572831] pci 0000:00:1c.1:   bridge window [mem 0x90600000-0x906fffff]
[    0.572912] pci 0000:03:00.0: [10ec:8168] type 00 class 0x020000
[    0.572954] pci 0000:03:00.0: reg 0x10: [io  0x1000-0x10ff]
[    0.572984] pci 0000:03:00.0: reg 0x18: [mem 0x90500000-0x90500fff 64bit]
[    0.573003] pci 0000:03:00.0: reg 0x20: [mem 0x90400000-0x90403fff 64bit pref]
[    0.573067] pci 0000:03:00.0: supports D1 D2
[    0.573070] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.580821] pci 0000:00:1c.2: PCI bridge to [bus 03]
[    0.580827] pci 0000:00:1c.2:   bridge window [io  0x1000-0x1fff]
[    0.580832] pci 0000:00:1c.2:   bridge window [mem 0x90500000-0x905fffff]
[    0.580839] pci 0000:00:1c.2:   bridge window [mem 0x90400000-0x904fffff 64bit pref]
[    0.785321] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 11 12 14 15) *7
[    0.785445] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12 14 15)
[    0.785560] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.785674] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 *10 11 12 14 15)
[    0.785789] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.785903] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 *10 11 12 14 15)
[    0.786017] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.786132] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 11 12 14 15) *7
[    0.786848] ACPI: Enabled 4 GPEs in block 00 to 3F
[    0.787061] ACPI : EC: GPE = 0x18, I/O: command/status = 0x66, data = 0x62
[    0.787227] vgaarb: setting as boot device: PCI:0000:00:02.0
[    0.787231] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.787237] vgaarb: loaded
[    0.787239] vgaarb: bridge control possible 0000:00:02.0
[    0.787617] SCSI subsystem initialized
[    0.787694] libata version 3.00 loaded.
[    0.787747] ACPI: bus type USB registered
[    0.787790] usbcore: registered new interface driver usbfs
[    0.787809] usbcore: registered new interface driver hub
[    0.787838] usbcore: registered new device driver usb
[    0.788040] PCI: Using ACPI for IRQ routing
[    0.789467] PCI: pci_cache_line_size set to 64 bytes
[    0.789522] e820: reserve RAM buffer [mem 0x0009e800-0x0009ffff]
[    0.789526] e820: reserve RAM buffer [mem 0x1f000000-0x1fffffff]
[    0.789529] e820: reserve RAM buffer [mem 0x781ad000-0x7bffffff]
[    0.789532] e820: reserve RAM buffer [mem 0x794c6000-0x7bffffff]
[    0.789535] e820: reserve RAM buffer [mem 0x7a000000-0x7bffffff]
[    0.789736] NetLabel: Initializing
[    0.789739] NetLabel:  domain hash size = 128
[    0.789741] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.789760] NetLabel:  unlabeled traffic allowed by default
[    0.789866] clocksource: Switched to clocksource refined-jiffies
[    0.800488] AppArmor: AppArmor Filesystem Enabled
[    0.800611] pnp: PnP ACPI init
[    0.800710] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.800868] system 00:01: [io  0x0680-0x069f] has been reserved
[    0.800873] system 00:01: [io  0x0400-0x047f] has been reserved
[    0.800878] system 00:01: [io  0x0500-0x05fe] has been reserved
[    0.800882] system 00:01: [io  0x0600-0x061f] has been reserved
[    0.800887] system 00:01: [mem 0xfed40000-0xfed44fff] has been reserved
[    0.800893] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.801013] pnp 00:02: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.801092] pnp 00:03: Plug and Play ACPI device, IDs SYN1b7d PNP0f13 (active)
[    1.008787] system 00:04: [mem 0xe0000000-0xefffffff] could not be reserved
[    1.008793] system 00:04: [mem 0xfed01000-0xfed01fff] has been reserved
[    1.008797] system 00:04: [mem 0xfed03000-0xfed03fff] has been reserved
[    1.008801] system 00:04: [mem 0xfed04000-0xfed04fff] has been reserved
[    1.008805] system 00:04: [mem 0xfed0c000-0xfed0ffff] has been reserved
[    1.008809] system 00:04: [mem 0xfed08000-0xfed08fff] has been reserved
[    1.008813] system 00:04: [mem 0xfed1c000-0xfed1cfff] has been reserved
[    1.008818] system 00:04: [mem 0xfee00000-0xfeefffff] could not be reserved
[    1.008822] system 00:04: [mem 0xfef00000-0xfeffffff] has been reserved
[    1.008827] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.009410] pnp: PnP ACPI: found 5 devices
[    1.017608] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    1.017631] clocksource: Switched to clocksource acpi_pm
[    1.017643] pci 0000:02:00.0: can't claim BAR 6 [mem 0xffff0000-0xffffffff pref]: no compatible bridge window
[    1.017660] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 01] add_size 1000
[    1.017666] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 01] add_size 200000 add_align 100000
[    1.017671] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff] to [bus 01] add_size 200000 add_align 100000
[    1.017680] pci 0000:00:1c.1: bridge window [io  0x1000-0x0fff] to [bus 02] add_size 1000
[    1.017685] pci 0000:00:1c.1: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 02] add_size 200000 add_align 100000
[    1.017700] pci 0000:00:1c.0: res[14]=[mem 0x00100000-0x000fffff] res_to_dev_res add_size 200000 min_align 100000
[    1.017705] pci 0000:00:1c.0: res[14]=[mem 0x00100000-0x002fffff] res_to_dev_res add_size 200000 min_align 100000
[    1.017709] pci 0000:00:1c.0: res[15]=[mem 0x00100000-0x000fffff 64bit pref] res_to_dev_res add_size 200000 min_align 100000
[    1.017713] pci 0000:00:1c.0: res[15]=[mem 0x00100000-0x002fffff 64bit pref] res_to_dev_res add_size 200000 min_align 100000
[    1.017718] pci 0000:00:1c.1: res[15]=[mem 0x00100000-0x000fffff 64bit pref] res_to_dev_res add_size 200000 min_align 100000
[    1.017722] pci 0000:00:1c.1: res[15]=[mem 0x00100000-0x002fffff 64bit pref] res_to_dev_res add_size 200000 min_align 100000
[    1.017726] pci 0000:00:1c.0: res[13]=[io  0x1000-0x0fff] res_to_dev_res add_size 1000 min_align 1000
[    1.017730] pci 0000:00:1c.0: res[13]=[io  0x1000-0x1fff] res_to_dev_res add_size 1000 min_align 1000
[    1.017734] pci 0000:00:1c.1: res[13]=[io  0x1000-0x0fff] res_to_dev_res add_size 1000 min_align 1000
[    1.017738] pci 0000:00:1c.1: res[13]=[io  0x1000-0x1fff] res_to_dev_res add_size 1000 min_align 1000
[    1.017748] pci 0000:00:1c.0: BAR 14: no space for [mem size 0x00200000]
[    1.017753] pci 0000:00:1c.0: BAR 14: failed to assign [mem size 0x00200000]
[    1.017763] pci 0000:00:1c.0: BAR 15: no space for [mem size 0x00200000 64bit pref]
[    1.017767] pci 0000:00:1c.0: BAR 15: failed to assign [mem size 0x00200000 64bit pref]
[    1.017776] pci 0000:00:1c.1: BAR 15: no space for [mem size 0x00200000 64bit pref]
[    1.017780] pci 0000:00:1c.1: BAR 15: failed to assign [mem size 0x00200000 64bit pref]
[    1.017787] pci 0000:00:1c.0: BAR 13: assigned [io  0x3000-0x3fff]
[    1.017792] pci 0000:00:1c.1: BAR 13: assigned [io  0x4000-0x4fff]
[    1.017803] pci 0000:00:1c.1: BAR 15: no space for [mem size 0x00200000 64bit pref]
[    1.017807] pci 0000:00:1c.1: BAR 15: failed to assign [mem size 0x00200000 64bit pref]
[    1.017813] pci 0000:00:1c.0: BAR 14: no space for [mem size 0x00200000]
[    1.017817] pci 0000:00:1c.0: BAR 14: failed to assign [mem size 0x00200000]
[    1.017827] pci 0000:00:1c.0: BAR 15: no space for [mem size 0x00200000 64bit pref]
[    1.017830] pci 0000:00:1c.0: BAR 15: failed to assign [mem size 0x00200000 64bit pref]
[    1.017834] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    1.017839] pci 0000:00:1c.0:   bridge window [io  0x3000-0x3fff]
[    1.017852] pci 0000:02:00.0: BAR 6: assigned [mem 0x90680000-0x9068ffff pref]
[    1.017856] pci 0000:00:1c.1: PCI bridge to [bus 02]
[    1.017861] pci 0000:00:1c.1:   bridge window [io  0x4000-0x4fff]
[    1.017867] pci 0000:00:1c.1:   bridge window [mem 0x90600000-0x906fffff]
[    1.017875] pci 0000:00:1c.2: PCI bridge to [bus 03]
[    1.017879] pci 0000:00:1c.2:   bridge window [io  0x1000-0x1fff]
[    1.017885] pci 0000:00:1c.2:   bridge window [mem 0x90500000-0x905fffff]
[    1.017890] pci 0000:00:1c.2:   bridge window [mem 0x90400000-0x904fffff 64bit pref]
[    1.017898] pci_bus 0000:00: resource 4 [io  0x0070-0x0077]
[    1.017902] pci_bus 0000:00: resource 5 [io  0x0000-0x006f window]
[    1.017905] pci_bus 0000:00: resource 6 [io  0x0078-0x0cf7 window]
[    1.017909] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    1.017912] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff window]
[    1.017916] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff window]
[    1.017920] pci_bus 0000:00: resource 10 [mem 0x000e0000-0x000fffff window]
[    1.017923] pci_bus 0000:00: resource 11 [mem 0x80000000-0x909ffffe window]
[    1.017927] pci_bus 0000:01: resource 0 [io  0x3000-0x3fff]
[    1.017931] pci_bus 0000:02: resource 0 [io  0x4000-0x4fff]
[    1.017934] pci_bus 0000:02: resource 1 [mem 0x90600000-0x906fffff]
[    1.017938] pci_bus 0000:03: resource 0 [io  0x1000-0x1fff]
[    1.017941] pci_bus 0000:03: resource 1 [mem 0x90500000-0x905fffff]
[    1.017945] pci_bus 0000:03: resource 2 [mem 0x90400000-0x904fffff 64bit pref]
[    1.018000] NET: Registered protocol family 2
[    1.018265] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
[    1.018337] TCP bind hash table entries: 16384 (order: 6, 262144 bytes)
[    1.018411] TCP: Hash tables configured (established 16384 bind 16384)
[    1.018462] UDP hash table entries: 1024 (order: 3, 32768 bytes)
[    1.018482] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes)
[    1.018576] NET: Registered protocol family 1
[    1.018606] pci 0000:00:02.0: Video device with shadowed ROM
[    1.019146] PCI: CLS 64 bytes, default 64
[    1.019265] Trying to unpack rootfs image as initramfs...
[    1.414198] Freeing initrd memory: 15976K (ffff8800360bc000 - ffff880037056000)
[    1.414444] microcode: CPU0 sig=0x30678, pf=0x8, revision=0x829
[    1.414460] microcode: CPU1 sig=0x30678, pf=0x8, revision=0x829
[    1.414585] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    1.414629] Scanning for low memory corruption every 60 seconds
[    1.415207] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    1.415238] Initialise system trusted keyring
[    1.415289] audit: initializing netlink subsys (disabled)
[    1.415314] audit: type=2000 audit(1442859105.400:1): initialized
[    1.415759] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    1.418887] zpool: loaded
[    1.418892] zbud: loaded
[    1.419220] VFS: Disk quotas dquot_6.6.0
[    1.419293] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.420333] fuse init (API version 7.23)
[    1.420619] Key type big_key registered
[    1.421631] Key type asymmetric registered
[    1.421637] Asymmetric key parser 'x509' registered
[    1.421665] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    1.421750] io scheduler noop registered
[    1.421755] io scheduler deadline registered (default)
[    1.421820] io scheduler cfq registered
[    1.422519] efifb: probing for efifb
[    1.422526] efifb: framebuffer at 0xa0000, mapped to 0xffff8800000a0000, using 64k, total 64k
[    1.422529] efifb: mode is 640x480x1, linelength=80, pages=1
[    1.422531] efifb: scrolling: redraw
[    1.422534] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    1.425072] Console: switching to colour frame buffer device 80x30
[    1.427470] fb0: EFI VGA frame buffer device
[    1.427487] intel_idle: MWAIT substates: 0x33000020
[    1.427490] intel_idle: v0.4 model 0x37
[    1.427492] intel_idle: lapic_timer_reliable_states 0xffffffff
[    1.427835] ACPI: AC Adapter [ACAD] (on-line)
[    1.427949] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    1.427956] ACPI: Power Button [PWRB]
[    1.428030] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1
[    1.428035] ACPI: Sleep Button [SLPB]
[    1.428111] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input2
[    1.428141] ACPI: Lid Switch [LID]
[    1.428216] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    1.428221] ACPI: Power Button [PWRF]
[    1.430891] thermal LNXTHERM:00: registered as thermal_zone0
[    1.430895] ACPI: Thermal Zone [TZ01] (34 C)
[    1.430952] GHES: HEST is not enabled!
[    1.432492] ACPI: Battery Slot [BAT1] (battery present)
[    1.432576] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    1.452725] serial8250: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    1.457694] hpet: number irqs doesn't agree with number of timers
[    1.457809] Linux agpgart interface v0.103
[    1.462684] brd: module loaded
[    1.464762] loop: module loaded
[    1.465112] libphy: Fixed MDIO Bus: probed
[    1.465118] PPP generic driver version 2.4.2
[    1.465455] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.465467] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    1.465861] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x00009810
[    1.465869] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    1.465873] xhci_hcd 0000:00:14.0: supports USB remote wakeup
[    1.466035] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    1.466040] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.466043] usb usb1: Product: xHCI Host Controller
[    1.466046] usb usb1: Manufacturer: Linux 4.2.0-j xhci-hcd
[    1.466049] usb usb1: SerialNumber: 0000:00:14.0
[    1.466293] skipping usb_enable_autosuspend for root hub
[    1.466298] hub 1-0:1.0: USB hub found
[    1.466315] hub 1-0:1.0: 6 ports detected
[    1.467061] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.467068] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    1.467074] xhci_hcd 0000:00:14.0: supports USB remote wakeup
[    1.467137] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[    1.467142] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.467145] usb usb2: Product: xHCI Host Controller
[    1.467148] usb usb2: Manufacturer: Linux 4.2.0-j xhci-hcd
[    1.467151] usb usb2: SerialNumber: 0000:00:14.0
[    1.467421] skipping usb_enable_autosuspend for root hub
[    1.467426] hub 2-0:1.0: USB hub found
[    1.467439] hub 2-0:1.0: 1 port detected
[    1.467661] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.467665] ehci_hcd: block sizes: qh 136 qtd 96 itd 192 sitd 96
[    1.467676] ehci-pci: EHCI PCI platform driver
[    1.467843] ehci-pci 0000:00:1d.0: EHCI Host Controller
[    1.467853] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 3
[    1.467870] ehci-pci 0000:00:1d.0: debug port 2
[    1.467877] ehci-pci 0000:00:1d.0: reset hcs_params 0x200008 dbg=2 cc=0 pcc=0 ordered !ppc ports=8
[    1.467882] ehci-pci 0000:00:1d.0: reset hcc_params 36881 caching frame 1024 64 bit addr
[    1.467899] ehci_halt: entry
[    1.467901] ehci_halt: about to readl prematurely
[    1.467904] ehci_halt: premature readl returned 80000
[    1.467906] ehci_halt: after first ehci_writel
[    1.467908] ehci_halt: before ehci_readl
[    1.467910] ehci_halt: after ehci_readl, before ehci_writel
[    1.467912] ehci_halt: after second ehci_writel
[    1.467915] ehci_halt: about to exit with ehci_handshake
[    1.467923] ehci-pci 0000:00:1d.0: reset command 0080002 (park)=0 ithresh=8 period=1024 Reset HALT
[    1.471809] ehci-pci 0000:00:1d.0: cache line size of 64 is not supported
[    1.471813] ehci-pci 0000:00:1d.0: supports USB remote wakeup
[    1.471832] ehci-pci 0000:00:1d.0: irq 23, io mem 0x90918000
[    1.471841] ehci-pci 0000:00:1d.0: init command 0010001 (park)=0 ithresh=1 period=1024 RUN
[    1.482025] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    1.482096] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[    1.482101] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.482104] usb usb3: Product: EHCI Host Controller
[    1.482107] usb usb3: Manufacturer: Linux 4.2.0-j ehci_hcd
[    1.482110] usb usb3: SerialNumber: 0000:00:1d.0
[    1.482415] skipping usb_enable_autosuspend for root hub
[    1.482419] hub 3-0:1.0: USB hub found
[    1.482432] hub 3-0:1.0: 8 ports detected
[    1.482807] ehci-platform: EHCI generic platform driver
[    1.482834] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.482843] ohci-pci: OHCI PCI platform driver
[    1.482869] ohci-platform: OHCI generic platform driver
[    1.482887] uhci_hcd: USB Universal Host Controller Interface driver
[    1.482983] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    1.484303] i8042: Detected active multiplexing controller, rev 1.1
[    1.485107] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.485116] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[    1.485167] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[    1.485212] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[    1.485259] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[    1.485708] mousedev: PS/2 mouse device common for all mice
[    1.486356] rtc_cmos 00:00: RTC can wake from S4
[    1.486624] rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
[    1.486652] rtc_cmos 00:00: alarms up to one month, y3k, 242 bytes nvram
[    1.486681] Intel P-state driver initializing.
[    1.486888] ledtrig-cpu: registered to indicate activity on CPUs
[    1.488159] NET: Registered protocol family 10
[    1.489388] NET: Registered protocol family 17
[    1.489470] Key type dns_resolver registered
[    1.492888] Loading compiled-in X.509 certificates
[    1.495554] Loaded X.509 cert 'Magrathea: Glacier signing key: c3d148db6cc2151f9499ebf6a612dab02abd13ed'
[    1.495578] registered taskstats version 1
[    1.495596] zswap: loading zswap
[    1.495599] zswap: using zbud pool
[    1.495607] zswap: using lzo compressor
[    1.500389] Key type trusted registered
[    1.505017] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input4
[    1.508014] Key type encrypted registered
[    1.508029] AppArmor: AppArmor sha1 policy hashing enabled
[    1.508035] ima: No TPM chip found, activating TPM-bypass!
[    1.508075] evm: HMAC attrs: 0x1
[    1.508583] rtc_cmos 00:00: setting system clock to 2015-09-21 18:11:46 UTC (1442859106)
[    1.508705] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    1.508707] EDD information not available.
[    1.509388] Freeing unused kernel memory: 1240K (ffffffff93d33000 - ffffffff93e69000)
[    1.509393] Write protecting the kernel read-only data: 12288k
[    1.510195] Freeing unused kernel memory: 1164K (ffff8800136dd000 - ffff880013800000)
[    1.510719] Freeing unused kernel memory: 600K (ffff880013b6a000 - ffff880013c00000)
[    1.530752] random: systemd-udevd urandom read with 2 bits of entropy available
[    1.557294] sdhci: module verification failed: signature and/or required key missing - tainting kernel
[    1.557611] sdhci: Secure Digital Host Controller Interface driver
[    1.557614] sdhci: Copyright(c) Pierre Ossman
[    1.557980] sdhci-pci 0000:00:12.0: SDHCI controller found [8086:0f16] (rev e)
[    1.558198] sdhci-pci 0000:00:12.0: failed to setup card detect gpio
[    1.559210] sdhci-pci 0000:00:12.0: No vmmc regulator found
[    1.559213] sdhci-pci 0000:00:12.0: No vqmmc regulator found
[    1.564542] mmc0: SDHCI controller on PCI [0000:00:12.0] using ADMA
[    1.568776] sdhci-pci 0000:00:17.0: SDHCI controller found [8086:0f50] (rev e)
[    1.569957] sdhci-pci 0000:00:17.0: No vmmc regulator found
[    1.569962] sdhci-pci 0000:00:17.0: No vqmmc regulator found
[    1.574027] mmc1: SDHCI controller on PCI [0000:00:17.0] using ADMA
[    1.582128] ehci-pci 0000:00:1d.0: GetStatus port:1 status 001803 0  ACK POWER sig=j CSC CONNECT
[    1.589253] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    1.589269] r8169 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM control
[    1.595152] r8169 0000:03:00.0 eth0: RTL8168g/8111g at 0xffffc90000420000, 2c:60:0c:1a:7b:19, XID 0c000800 IRQ 88
[    1.595158] r8169 0000:03:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[    1.738432] ehci-pci 0000:00:1d.0: port 1 reset complete, port enabled
[    1.738442] ehci-pci 0000:00:1d.0: GetStatus port:1 status 001005 0  ACK POWER sig=se0 PE CONNECT
[    1.759030] mmc1: MAN_BKOPS_EN bit is not set
[    1.773358] mmc1: new HS200 MMC card at address 0001
[    1.774632] mmcblk0: mmc1:0001 HBG4e 29.1 GiB 
[    1.774699] mmcblk0boot0: mmc1:0001 HBG4e partition 1 4.00 MiB
[    1.774827] mmcblk0boot1: mmc1:0001 HBG4e partition 2 4.00 MiB
[    1.774971] mmcblk0rpmb: mmc1:0001 HBG4e partition 3 4.00 MiB
[    1.778278] usb 1-2: new high-speed USB device number 2 using xhci_hcd
[    1.778401]  mmcblk0: p1 p2 p3
[    1.794807] usb 3-1: new high-speed USB device number 2 using ehci-pci
[    1.850649] ehci-pci 0000:00:1d.0: port 1 reset complete, port enabled
[    1.850658] ehci-pci 0000:00:1d.0: GetStatus port:1 status 001005 0  ACK POWER sig=se0 PE CONNECT
[    1.907674] usb 1-2: New USB device found, idVendor=05e3, idProduct=0608
[    1.907680] usb 1-2: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    1.907683] usb 1-2: Product: USB2.0 Hub
[    1.908277] skipping usb_enable_autosuspend for normal device
[    1.908283] hub 1-2:1.0: USB hub found
[    1.908532] hub 1-2:1.0: 4 ports detected
[    1.908972] usb: failed to peer 1-2-port1 and usb2-port1 by location (1-2-port1:none) (usb2-port1:usb1-port1)
[    1.908976] usb 1-2-port1: failed to peer to usb2-port1 (-16)
[    1.908978] usb: port power management may be unreliable
[    1.909069] usb: failed to peer 1-2-port2 and usb2-port1 by location (1-2-port2:none) (usb2-port1:usb1-port1)
[    1.909072] usb 1-2-port2: failed to peer to usb2-port1 (-16)
[    1.909155] usb: failed to peer 1-2-port3 and usb2-port1 by location (1-2-port3:none) (usb2-port1:usb1-port1)
[    1.909158] usb 1-2-port3: failed to peer to usb2-port1 (-16)
[    1.909244] usb: failed to peer 1-2-port4 and usb2-port1 by location (1-2-port4:none) (usb2-port1:usb1-port1)
[    1.909247] usb 1-2-port4: failed to peer to usb2-port1 (-16)
[    1.916061] EXT4-fs (mmcblk0p1): mounted filesystem with ordered data mode. Opts: (null)
[    1.926854] usb 3-1: New USB device found, idVendor=8087, idProduct=07e6
[    1.926859] usb 3-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.927265] skipping usb_enable_autosuspend for normal device
[    1.927270] hub 3-1:1.0: USB hub found
[    1.927344] hub 3-1:1.0: 4 ports detected
[    2.022485] usb 1-4: new high-speed USB device number 3 using xhci_hcd
[    2.027026] usb 3-1: ep 81: reserve intr @ 8+64 (1.0+256) [1/0 us] mask 0001
[    2.027032] usb 3-1: link qh256-0001/ffff880036955f00 start 1 [1/0 us]
[    2.059477] systemd[1]: Inserted module 'autofs4'
[    2.159567] usb 1-4: New USB device found, idVendor=04f2, idProduct=b469
[    2.159572] usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.159575] usb 1-4: Product: HD WebCam
[    2.159578] usb 1-4: Manufacturer: Chicony Electronics Co.,Ltd.
[    2.222647] usb 1-2.1: new full-speed USB device number 4 using xhci_hcd
[    2.311887] usb 1-2.1: New USB device found, idVendor=04ca, idProduct=300b
[    2.311892] usb 1-2.1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.382861] usb 1-2.2: new low-speed USB device number 5 using xhci_hcd
[    2.414802] tsc: Refined TSC clocksource calibration: 2166.671 MHz
[    2.414808] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1f3b36362f9, max_idle_ns: 440795277036 ns
[    2.473393] usb 1-2.2: New USB device found, idVendor=04b3, idProduct=3108
[    2.473399] usb 1-2.2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.473551] usb 1-2.2: ep 0x81 - rounding interval to 64 microframes, ep desc says 80 microframes
[    2.536766] psmouse serio2: synaptics: queried max coordinates: x [..5662], y [..4728]
[    2.563600] psmouse serio2: synaptics: queried min coordinates: x [1322..], y [1190..]
[    2.584001] wmi: Mapper loaded
[    2.594172] [drm] Initialized drm 1.1.0 20060810
[    2.614378] psmouse serio2: synaptics: Touchpad model: 1, fw: 8.1, id: 0x1e2b1, caps: 0xd40123/0x840300/0x126800/0x0, board id: 2991, fw id: 1626681
[    2.646079] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio2/input/input11
[    2.678291] [drm] Memory usable by graphics device = 2048M
[    2.678298] checking generic (a0000 10000) vs hw (80000000 10000000)
[    2.678301] fb: switching to inteldrmfb from EFI VGA
[    2.678336] Console: switching to colour dummy device 80x25
[    2.679916] [drm] Replacing VGA console driver
[    2.688618] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    2.688623] [drm] Driver supports precise vblank timestamp query.
[    2.728393] Adding 2621436k swap on /dev/mmcblk0p3.  Priority:-1 extents:1 across:2621436k SSFS
[    2.747293] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    2.754824] ath: phy0: WB335 2-ANT card detected
[    2.754829] ath: phy0: Set BT/WLAN RX diversity capability
[    2.763083] ath: phy0: Enable LNA combining
[    2.764268] ath: phy0: ASPM enabled: 0x42
[    2.764275] ath: EEPROM regdomain: 0x65
[    2.764277] ath: EEPROM indicates we should expect a direct regpair map
[    2.764281] ath: Country alpha2 being used: 00
[    2.764282] ath: Regpair used: 0x65
[    2.783414] fbcon: inteldrmfb (fb0) is primary device
[    2.787447] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    2.788485] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input14
[    2.789132] [drm] Initialized i915 1.6.0 20150522 for 0000:00:02.0 on minor 0
[    2.793568] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
[    2.794214] ieee80211 phy0: Atheros AR9565 Rev:1 mem=0xffffc90000600000, irq=17
[    2.825027] intel_soc_dts_thermal: request_threaded_irq ret -22
[    2.830449] intel_rapl: Found RAPL domain package
[    2.830451] intel_rapl: Found RAPL domain core
[    2.862308] acer_wmi: Acer Laptop ACPI-WMI Extras
[    2.862322] acer_wmi: Function bitmap for Communication Button: 0x801
[    2.864561] acer_wmi: Enabling Launch Manager failed: 0xe4 - 0x0
[    2.865502] input: Acer WMI hotkeys as /devices/virtual/input/input15
[    2.865964] input: Acer BMA150 accelerometer as /devices/virtual/input/input16
[    2.873643] hidraw: raw HID events driver (C) Jiri Kosina
[    2.880190] usbcore: registered new interface driver usbhid
[    2.880191] usbhid: USB HID core driver
[    2.909149] cfg80211: World regulatory domain updated:
[    2.909152] cfg80211:  DFS Master region: unset
[    2.909152] cfg80211:   (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp), (dfs_cac_time)
[    2.909155] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (N/A, 2000 mBm), (N/A)
[    2.909157] cfg80211:   (2457000 KHz - 2482000 KHz @ 40000 KHz), (N/A, 2000 mBm), (N/A)
[    2.909158] cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz), (N/A, 2000 mBm), (N/A)
[    2.909160] cfg80211:   (5170000 KHz - 5250000 KHz @ 80000 KHz, 160000 KHz AUTO), (N/A, 2000 mBm), (N/A)
[    2.909162] cfg80211:   (5250000 KHz - 5330000 KHz @ 80000 KHz, 160000 KHz AUTO), (N/A, 2000 mBm), (0 s)
[    2.909164] cfg80211:   (5490000 KHz - 5730000 KHz @ 160000 KHz), (N/A, 2000 mBm), (0 s)
[    2.909165] cfg80211:   (5735000 KHz - 5835000 KHz @ 80000 KHz), (N/A, 2000 mBm), (N/A)
[    2.909167] cfg80211:   (57240000 KHz - 63720000 KHz @ 2160000 KHz), (N/A, 0 mBm), (N/A)
[    2.912337] input: HID 04b3:3108 as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2.2/1-2.2:1.0/0003:04B3:3108.0001/input/input17
[    2.912787] hid-generic 0003:04B3:3108.0001: input,hidraw0: USB HID v1.00 Mouse [HID 04b3:3108] on usb-0000:00:14.0-2.2/input0
[    3.416236] clocksource: Switched to clocksource tsc
[    4.368866] Console: switching to colour frame buffer device 170x48
[    4.377141] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    4.377142] i915 0000:00:02.0: registered panic notifier
[    4.460458] EXT4-fs (mmcblk0p1): re-mounted. Opts: errors=remount-ro
[    4.528975] EXT4-fs (mmcblk0p2): mounted filesystem with ordered data mode. Opts: (null)
[    4.690521] audit: type=1400 audit(1442859109.674:2): apparmor="STATUS" operation="profile_load" name="/usr/lib/lightdm/lightdm-guest-session" pid=359 comm="apparmor_parser"
[    4.690532] audit: type=1400 audit(1442859109.674:3): apparmor="STATUS" operation="profile_load" name="chromium" pid=359 comm="apparmor_parser"
[    4.695693] audit: type=1400 audit(1442859109.678:4): apparmor="STATUS" operation="profile_load" name="/sbin/dhclient" pid=359 comm="apparmor_parser"
[    4.695706] audit: type=1400 audit(1442859109.678:5): apparmor="STATUS" operation="profile_load" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=359 comm="apparmor_parser"
[    4.695715] audit: type=1400 audit(1442859109.678:6): apparmor="STATUS" operation="profile_load" name="/usr/lib/NetworkManager/nm-dhcp-helper" pid=359 comm="apparmor_parser"
[    4.695723] audit: type=1400 audit(1442859109.678:7): apparmor="STATUS" operation="profile_load" name="/usr/lib/connman/scripts/dhclient-script" pid=359 comm="apparmor_parser"
[    4.728652] audit: type=1400 audit(1442859109.710:8): apparmor="STATUS" operation="profile_load" name="/usr/bin/evince" pid=359 comm="apparmor_parser"
[    4.728665] audit: type=1400 audit(1442859109.714:9): apparmor="STATUS" operation="profile_load" name="sanitized_helper" pid=359 comm="apparmor_parser"
[    4.728673] audit: type=1400 audit(1442859109.714:10): apparmor="STATUS" operation="profile_load" name="/usr/bin/evince-previewer" pid=359 comm="apparmor_parser"
[    6.040185] random: nonblocking pool is initialized
[    6.124495] r8169 0000:03:00.0 eth0: link down

/sys/bus/pci/devices/0000:00:1d.0/power/control: on
/sys/bus/pci/devices/0000:00:1d.0/power/runtime_status: active

/sys/kernel/debug/usb/ehci/0000:00:1d.0/registers:
bus pci, device 0000:00:1d.0
EHCI Host Controller
EHCI 1.00, rh state running
ownership 00000001
SMI sts/enable 0xc0000000
structural params 0x00200008
capability params 0x00036881
status 6000 Periodic Recl
command 0010011 (park)=0 ithresh=1 Periodic period=1024 RUN
intrenable 37 IAA FATAL PCD ERR INT
uframe 33db
port:1 status 001005 0  ACK POWER sig=se0 PE CONNECT
port:2 status 001000 0  ACK POWER sig=se0
port:3 status 001000 0  ACK POWER sig=se0
port:4 status 001000 0  ACK POWER sig=se0
port:5 status 001000 0  ACK POWER sig=se0
port:6 status 001000 0  ACK POWER sig=se0
port:7 status 001000 0  ACK POWER sig=se0
port:8 status 001000 0  ACK POWER sig=se0
irq normal 17 err 0 iaa 8 (lost 0)
complete 17 unlink 0

[  208.333980] ehci-pci 0000:00:1d.0: remove, state 1
[  208.336879] ehci-pci 0000:00:1d.0: roothub graceful disconnect
[  208.340767] usb usb3: USB disconnect, device number 1
[  208.344049] usb 3-1: USB disconnect, device number 2
[  208.345943] usb 3-1: unlink qh256-0001/ffff880036955f00 start 1 [1/0 us]
[  208.347808] ehci-pci 0000:00:1d.0: shutdown urb ffff880036a30780 ep1in-intr
[  208.350837] usb 3-1: ep 81: release intr @ 8+64 (1.0+256) [1/0 us] mask 0001
[  208.353033] ehci-pci 0000:00:1d.0: shutdown urb ffff880036885180 ep1in-intr
[  208.355288] usb_remove_hcd: calling stop
[  208.356733] ehci-pci 0000:00:1d.0: stop
[  208.359064] ehci_silence_controller: entry
[  208.360469] ehci_halt: entry
[  208.361876] ehci_halt: about to readl prematurely
[  208.363307] ehci_halt: premature readl returned 10001
[  208.364718] ehci_halt: after first ehci_writel
[  208.366116] ehci_halt: before ehci_readl
[  208.367520] ehci_halt: after ehci_readl, before ehci_writel
[  208.368918] ehci_halt: after second ehci_writel
[  208.370295] ehci_halt: about to exit with ehci_handshake
[  208.371495] ehci_silence_controller: exit
[  208.372603] ehci_stop: after ehci_silence_controller
[  208.373732] ehci-pci 0000:00:1d.0: reset command 0010002 (park)=0 ithresh=1 period=1024 Reset HALT
[  208.378855] ehci-pci 0000:00:1d.0: ehci_stop completed status 1000 Halt
[  208.380052] usb_remove_hcd: returned from stop
[  208.381259] ehci-pci 0000:00:1d.0: USB bus 3 deregistered
