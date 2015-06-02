Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36647 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759402AbbFBRyT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 2 Jun 2015 13:54:19 -0400
Message-ID: <556DEDCA.1040808@redhat.com>
Date: Tue, 02 Jun 2015 13:54:18 -0400
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Linux PCI <linux-pci@vger.kernel.org>,
	Myron Stowe <mstowe@redhat.com>
Subject: Re: Initial APCI root bus discovery vs. rescan
References: <5563B21A.8080504@redhat.com> <20150526160716.GM32152@google.com>
In-Reply-To: <20150526160716.GM32152@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/26/2015 12:07 PM, Bjorn Helgaas wrote:
> Hi Prarit,

> 
> It might be quicker if you posted the complete dmesg log, along with
> pointers to the specific things that look wrong.

Look for "PRARIT" below....

[    0.000000] microcode: CPU0 microcode updated early to revision 0x1b, date =
2014-05-29
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.1.0-rc5+
(root@intel-brickland-04.khw.lab.eng.bos.redhat.com) (gcc version 4.8.3 20140911
(Red Hat 4.8.3-9) (GCC) ) #7 SMP Mon Jun 1 08:20:16 EDT 2015
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-4.1.0-rc5+
root=/dev/mapper/rhel_intel--chiefriver--04-root ro console=ttyS0,115200n81
crashkernel=auto rd.lvm.lv=rhel_intel-chiefriver-04/root
rd.lvm.lv=rhel_intel-chiefriver-04/swap LANG=en_US.UTF-8 systemd.debug
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009abff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009ac00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000ad2acfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000ad2ad000-0x00000000ad2effff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ad2f0000-0x00000000aedc3fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000aedc4000-0x00000000af569fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000af56a000-0x00000000af7e9fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000af7ea000-0x00000000af7fefff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000af7ff000-0x00000000af7fffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000af800000-0x00000000afffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed10000-0x00000000fed13fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed18000-0x00000000fed19fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff900000-0x00000000ffbfffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffd00000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000024dffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.6 present.
[    0.000000] DMI: Intel Corporation 2012 Client Platform/Emerald Lake 2, BIOS
ACRVMBY1.86C.0078.P00.1201161002 01/16/2012
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] AGP: No AGP bridge found
[    0.000000] e820: last_pfn = 0x24e000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-CFFFF write-protect
[    0.000000]   D0000-E7FFF uncachable
[    0.000000]   E8000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0FFC00000 mask FFFC00000 write-protect
[    0.000000]   1 base 000000000 mask F80000000 write-back
[    0.000000]   2 base 080000000 mask FE0000000 write-back
[    0.000000]   3 base 0A0000000 mask FF0000000 write-back
[    0.000000]   4 base 0AF800000 mask FFF800000 uncachable
[    0.000000]   5 base 100000000 mask F00000000 write-back
[    0.000000]   6 base 200000000 mask FC0000000 write-back
[    0.000000]   7 base 240000000 mask FF0000000 write-back
[    0.000000]   8 base 24E000000 mask FFE000000 uncachable
[    0.000000]   9 disabled
[    0.000000] PAT configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- UC
[    0.000000] e820: last_pfn = 0xaf800 max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000fca60-0x000fca6f] mapped at
[ffff8800000fca60]
[    0.000000] Base memory trampoline at [ffff880000094000] 94000 size 24576
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] BRK [0x02017000, 0x02017fff] PGTABLE
[    0.000000] BRK [0x02018000, 0x02018fff] PGTABLE
[    0.000000] BRK [0x02019000, 0x02019fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x24de00000-0x24dffffff]
[    0.000000]  [mem 0x24de00000-0x24dffffff] page 2M
[    0.000000] BRK [0x0201a000, 0x0201afff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x240000000-0x24ddfffff]
[    0.000000]  [mem 0x240000000-0x24ddfffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x220000000-0x23fffffff]
[    0.000000]  [mem 0x220000000-0x23fffffff] page 2M
[    0.000000] BRK [0x0201b000, 0x0201bfff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x00100000-0xad2acfff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0xad1fffff] page 2M
[    0.000000]  [mem 0xad200000-0xad2acfff] page 4k
[    0.000000] init_memory_mapping: [mem 0xad2f0000-0xaedc3fff]
[    0.000000]  [mem 0xad2f0000-0xad3fffff] page 4k
[    0.000000]  [mem 0xad400000-0xaebfffff] page 2M
[    0.000000]  [mem 0xaec00000-0xaedc3fff] page 4k
[    0.000000] BRK [0x0201c000, 0x0201cfff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0xaf7ff000-0xaf7fffff]
[    0.000000]  [mem 0xaf7ff000-0xaf7fffff] page 4k
[    0.000000] init_memory_mapping: [mem 0x100000000-0x21fffffff]
[    0.000000]  [mem 0x100000000-0x21fffffff] page 2M
[    0.000000] RAMDISK: [mem 0x348db000-0x36465fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F0410 000024 (v02 INTEL )
[    0.000000] ACPI: XSDT 0x00000000AF7FDE18 00007C (v01 INTEL  IVB-PPT
06222004 MSFT 00010013)
[    0.000000] ACPI: FACP 0x00000000AF7E3D98 0000F4 (v04 INTEL  IVB-PPT
06222004 MSFT 00010013)
[    0.000000] ACPI: DSDT 0x00000000AF7AE018 00FD25 (v02 INTEL  IVB-PPT
00000000 INTL 20110623)
[    0.000000] ACPI: FACS 0x00000000AF7E9E40 000040
[    0.000000] ACPI: APIC 0x00000000AF7FCF18 0000CC (v02 INTEL  IVB-PPT
06222004 MSFT 00010013)
[    0.000000] ACPI: HPET 0x00000000AF7E8F18 000038 (v01 A M I   PCHHPET
06222004 AMI. 00000003)
[    0.000000] ACPI: SSDT 0x00000000AF7E5018 0010A8 (v01 TrmRef PtidDevc
00001000 INTL 20110623)
[    0.000000] ACPI: SSDT 0x00000000AF7E4A18 000461 (v01 AMI    PerfTune
00001000 INTL 20110623)
[    0.000000] ACPI: TCPA 0x00000000AF7E8E98 000032 (v02
00000000      00000000)
[    0.000000] ACPI: MCFG 0x00000000AF7E8E18 00003C (v01 INTEL  SNDYBRDG
06222004 MSFT 00000097)
[    0.000000] ACPI: SSDT 0x00000000AF7C2018 0009AA (v01 PmRef  Cpu0Ist
00003000 INTL 20110623)
[    0.000000] ACPI: SSDT 0x00000000AF7C1018 000A92 (v01 PmRef  CpuPm
00003000 INTL 20110623)
[    0.000000] ACPI: DMAR 0x00000000AF7E4F18 000080 (v01 INTEL  SNB
00000001 INTL 00000001)
[    0.000000] ACPI: FPDT 0x00000000AF7F4018 000064 (v01 INTEL  IVB-CPT
00010000 INTL 20111107)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000024dffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x24dfd1000-0x24dff7fff]
[    0.000000] kexec: crashkernel: memory value expected
[    0.000000]  [ffffea0000000000-ffffea00093fffff] PMD ->
[ffff880245600000-ffff88024d5fffff] on node 0
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000024dffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x0000000000099fff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000ad2acfff]
[    0.000000]   node   0: [mem 0x00000000ad2f0000-0x00000000aedc3fff]
[    0.000000]   node   0: [mem 0x00000000af7ff000-0x00000000af7fffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000024dffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000024dffffff]
[    0.000000] On node 0 totalpages: 2084123
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3993 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 11127 pages used for memmap
[    0.000000]   DMA32 zone: 712066 pages, LIFO batch:31
[    0.000000]   Normal zone: 21376 pages used for memmap
[    0.000000]   Normal zone: 1368064 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] smpboot: Allowing 16 CPUs, 8 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009a000-0x0009afff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009b000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xad2ad000-0xad2effff]
[    0.000000] PM: Registered nosave memory: [mem 0xaedc4000-0xaf569fff]
[    0.000000] PM: Registered nosave memory: [mem 0xaf56a000-0xaf7e9fff]
[    0.000000] PM: Registered nosave memory: [mem 0xaf7ea000-0xaf7fefff]
[    0.000000] PM: Registered nosave memory: [mem 0xaf800000-0xafffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xb0000000-0xf7ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfc000000-0xfebfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec01000-0xfed0ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed10000-0xfed13fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed14000-0xfed17fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed18000-0xfed19fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed1a000-0xfed1bfff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed20000-0xfedfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee01000-0xff8fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xff900000-0xffbfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xffc00000-0xffcfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xffd00000-0xffffffff]
[    0.000000] e820: [mem 0xb0000000-0xf7ffffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource refined-jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:16 nr_cpu_ids:16
nr_node_ids:1
[    0.000000] PERCPU: Embedded 34 pages/cpu @ffff880245200000 s100440 r8192
d30632 u262144
[    0.000000] pcpu-alloc: s100440 r8192 d30632 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total
pages: 2051535
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.1.0-rc5+
root=/dev/mapper/rhel_intel--chiefriver--04-root ro console=ttyS0,115200n81
crashkernel=auto rd.lvm.lv=rhel_intel-chiefriver-04/root
rd.lvm.lv=rhel_intel-chiefriver-04/swap LANG=en_US.UTF-8 systemd.debug
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] xsave: enabled xstate_bv 0x7, cntxt size 0x340 using standard form
[    0.000000] AGP: Checking aperture...
[    0.000000] AGP: No AGP bridge found
[    0.000000] Memory: 8091964K/8336492K available (6847K kernel code, 1491K
rwdata, 3176K rodata, 1712K init, 3196K bss, 244528K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=16.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
[    0.000000] NR_IRQS:524544 nr_irqs:552 16
[    0.000000] 	Offload RCU callbacks from all CPUs
[    0.000000] 	Offload RCU callbacks from CPUs: 0-15.
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [ttyS0] enabled
[    0.000000] clocksource hpet: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 133484882848 ns
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2594.125 MHz processor
[    0.000033] Calibrating delay loop (skipped), value calculated using timer
frequency.. 5188.25 BogoMIPS (lpj=2594125)
[    0.010639] pid_max: default: 32768 minimum: 301
[    0.015252] ACPI: Core revision 20150410
[    0.026948] ACPI: All ACPI Tables successfully acquired
[    0.032386] Security Framework initialized
[    0.036484] SELinux:  Initializing.
[    0.039972] SELinux:  Starting in permissive mode
[    0.040505] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.049713] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.057673] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.064546] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.072035] Initializing cgroup subsys blkio
[    0.076302] Initializing cgroup subsys memory
[    0.080659] Initializing cgroup subsys devices
[    0.085098] Initializing cgroup subsys freezer
[    0.089537] Initializing cgroup subsys net_cls
[    0.093976] Initializing cgroup subsys perf_event
[    0.098675] Initializing cgroup subsys hugetlb
[    0.103134] CPU: Physical Processor ID: 0
[    0.107138] CPU: Processor Core ID: 0
[    0.110799] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.116794] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.124178] mce: CPU supports 9 MCE banks
[    0.128194] CPU0: Thermal monitoring enabled (TM1)
[    0.132990] process: using mwait in idle threads
[    0.137603] Last level iTLB entries: 4KB 512, 2MB 8, 4MB 8
[    0.143079] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    0.149464] Freeing SMP alternatives memory: 28K (ffffffff81cef000 -
ffffffff81cf6000)
[    0.158569] ftrace: allocating 25829 entries in 101 pages
[    0.175393] dmar: Host address width 36
[    0.179226] dmar: DRHD base: 0x000000fed90000 flags: 0x1
[    0.184533] dmar: IOMMU 0: reg_base_addr fed90000 ver 1:0 cap c9008020660262
ecap f010da
[    0.192607] dmar: RMRR base: 0x000000af495000 end: 0x000000af4b2fff
[    0.198865] IOAPIC id 2 under DRHD base  0xfed90000 IOMMU 0
[    0.204428] HPET id 0 under DRHD base 0xfed90000
[    0.209174] Queued invalidation will be enabled to support x2apic and
Intr-remapping.
[    0.216983] Enabled IRQ remapping in x2apic mode
[    0.221587] x2apic enabled
[    0.224295] Switched APIC routing to cluster x2apic.
[    0.229690] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.245690] TSC deadline timer enabled
[    0.245694] smpboot: CPU0: Intel(R) Core(TM) i7-3720QM CPU @ 2.60GHz (fam:
06, model: 3a, stepping: 09)
[    0.255120] Performance Events: PEBS fmt1+, 16-deep LBR, IvyBridge events,
full-width counters, Intel PMU driver.
[    0.265432] ... version:                3
[    0.269431] ... bit width:              48
[    0.273516] ... generic registers:      4
[    0.277513] ... value mask:             0000ffffffffffff
[    0.282809] ... max period:             0000ffffffffffff
[    0.288105] ... fixed-purpose events:   3
[    0.292101] ... event mask:             000000070000000f
[    0.298084] x86: Booting SMP configuration:
[    0.302259] .... node  #0, CPUs:        #1
[    0.319805] NMI watchdog: enabled on all CPUs, permanently consumes one
hw-PMU counter.
[    0.328066]   #2
[    0.341093] microcode: CPU2 microcode updated early to revision 0x1b, date =
2014-05-29
[    0.351781]   #3  #4
[    0.378698] microcode: CPU4 microcode updated early to revision 0x1b, date =
2014-05-29
[    0.389476]   #5  #6
[    0.416489] microcode: CPU6 microcode updated early to revision 0x1b, date =
2014-05-29
[    0.427271]   #7
[    0.442484] x86: Booted up 1 node, 8 CPUs
[    0.446670] smpboot: Total of 8 processors activated (41506.00 BogoMIPS)
[    0.460049] devtmpfs: initialized
[    0.465986] evm: security.selinux
[    0.469292] evm: security.ima
[    0.472252] evm: security.capability
[    0.475875] PM: Registering ACPI NVS region [mem 0xaf56a000-0xaf7e9fff]
(2621440 bytes)
[    0.483962] clocksource jiffies: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 1911260446275000 ns
[    0.493682] atomic64_test: passed for x86-64 platform with CX8 and with SSE
[    0.500626] pinctrl core: initialized pinctrl subsystem
[    0.505955] NET: Registered protocol family 16
[    0.513413] cpuidle: using governor menu
[    0.517379] ACPI FADT declares the system doesn't support PCIe ASPM, so
disable it
[    0.524928] ACPI: bus type PCI registered
[    0.528927] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.535418] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem
0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.544700] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.551541] PCI: Using configuration type 1 for base access
[    0.557371] perf_event_intel: PMU erratum BJ122, BV98, HSD29 worked around,
HT is on
[    0.568454] ACPI: Added _OSI(Module Device)
[    0.572627] ACPI: Added _OSI(Processor Device)
[    0.577058] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.581751] ACPI: Added _OSI(Processor Aggregator Device)
[    0.589981] ACPI: Executed 1 blocks of module-level executable AML code
[    0.599167] ACPI: Dynamic OEM Table Load:
[    0.603200] ACPI: SSDT 0xFFFF880243469000 000A4F (v01 PmRef  Cpu0Cst
00003001 INTL 20110623)
[    0.612265] ACPI: Dynamic OEM Table Load:
[    0.616294] ACPI: SSDT 0xFFFF88024342B000 000303 (v01 PmRef  ApIst
00003000 INTL 20110623)
[    0.625286] ACPI: Dynamic OEM Table Load:
[    0.629310] ACPI: SSDT 0xFFFF8802434A8A00 000119 (v01 PmRef  ApCst
00003000 INTL 20110623)
[    0.639199] ACPI : EC: EC started
[    1.454178] ACPI: Interpreter enabled
[    1.457841] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State
[\_S2_] (20150410/hwxface-580)
[    1.467069] ACPI: (supports S0 S1 S3 S4 S5)
[    1.471239] ACPI: Using IOAPIC for interrupt routing
[    1.476212] PCI: Using host bridge windows from ACPI; if necessary, use
"pci=nocrs" and report a bug
[    1.489590] acpi ABCDEFGH:00: ACPI dock station (docks/bays count: 1)
[    1.499273] ACPI: Power Resource [FN00] (off)
[    1.503685] ACPI: Power Resource [FN01] (off)
[    1.508094] ACPI: Power Resource [FN02] (off)
[    1.512503] ACPI: Power Resource [FN03] (off)
[    1.516911] ACPI: Power Resource [FN04] (off)
[    1.521778] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    1.527945] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM
Segments MSI]
[    1.536207] \_SB_.PCI0:_OSC invalid UUID
[    1.536208] _OSC request data:1 1f 0
[    1.536212] acpi PNP0A08:00: _OSC failed (AE_ERROR); disabling ASPM
[    1.542837] PCI host bridge to bus 0000:00
[    1.546925] pci_bus 0000:00: root bus resource [bus 00-3e]
[    1.552397] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    1.559165] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    1.565934] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    1.573398] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3fff window]
[    1.580861] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff window]
[    1.588322] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff window]
[    1.595784] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff window]
[    1.603246] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3fff window]
[    1.610707] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7fff window]
[    1.618170] pci_bus 0000:00: root bus resource [mem 0xb0000000-0xfeafffff window]
[    1.625636] pci 0000:00:00.0: [8086:0154] type 00 class 0x060000
[    1.625715] pci 0000:00:01.0: [8086:0151] type 01 class 0x060400
[    1.625743] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    1.625809] pci 0000:00:01.0: System wakeup disabled by ACPI
[    1.631509] pci 0000:00:14.0: [8086:1e31] type 00 class 0x0c0330
[    1.631530] pci 0000:00:14.0: reg 0x10: [mem 0xb15a0000-0xb15affff 64bit]
[    1.631597] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    1.631635] pci 0000:00:14.0: System wakeup disabled by ACPI
[    1.637311] pci 0000:00:16.0: [8086:1e3a] type 00 class 0x078000
[    1.637333] pci 0000:00:16.0: reg 0x10: [mem 0xb1590000-0xb159000f 64bit]
[    1.637403] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold

[    1.637470] pci 0000:00:16.3: [8086:1e3d] type 00 class 0x070002
[    1.637486] pci 0000:00:16.3: reg 0x10: [io  0x70a0-0x70a7]
[    1.637495] pci 0000:00:16.3: reg 0x14: [mem 0xb1580000-0xb1580fff]

^^^ PRARIT: ACPI PCI init of serial device

[    1.637622] pci 0000:00:19.0: [8086:1502] type 00 class 0x020000
[    1.637637] pci 0000:00:19.0: reg 0x10: [mem 0xb1500000-0xb151ffff]
[    1.637646] pci 0000:00:19.0: reg 0x14: [mem 0xb1570000-0xb1570fff]
[    1.637654] pci 0000:00:19.0: reg 0x18: [io  0x7040-0x705f]
[    1.637708] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    1.637748] pci 0000:00:19.0: System wakeup disabled by ACPI
[    1.643426] pci 0000:00:1a.0: [8086:1e2d] type 00 class 0x0c0320
[    1.643444] pci 0000:00:1a.0: reg 0x10: [mem 0xb1560000-0xb15603ff]
[    1.643522] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    1.643572] pci 0000:00:1a.0: System wakeup disabled by ACPI
[    1.649252] pci 0000:00:1c.0: [8086:1e10] type 01 class 0x060400
[    1.649322] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    1.649389] pci 0000:00:1c.0: System wakeup disabled by ACPI
[    1.655067] pci 0000:00:1c.2: [8086:1e14] type 01 class 0x060400
[    1.655137] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    1.655201] pci 0000:00:1c.2: System wakeup disabled by ACPI
[    1.660885] pci 0000:00:1c.6: [8086:1e1c] type 01 class 0x060400
[    1.661001] pci 0000:00:1c.6: PME# supported from D0 D3hot D3cold
[    1.661072] pci 0000:00:1c.6: System wakeup disabled by ACPI
[    1.666750] pci 0000:00:1d.0: [8086:1e26] type 00 class 0x0c0320
[    1.666768] pci 0000:00:1d.0: reg 0x10: [mem 0xb1550000-0xb15503ff]
[    1.666847] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    1.666896] pci 0000:00:1d.0: System wakeup disabled by ACPI
[    1.672573] pci 0000:00:1f.0: [8086:1e55] type 00 class 0x060100
[    1.672731] pci 0000:00:1f.2: [8086:1e03] type 00 class 0x010601
[    1.672745] pci 0000:00:1f.2: reg 0x10: [io  0x7090-0x7097]
[    1.672753] pci 0000:00:1f.2: reg 0x14: [io  0x7080-0x7083]
[    1.672761] pci 0000:00:1f.2: reg 0x18: [io  0x7070-0x7077]
[    1.672769] pci 0000:00:1f.2: reg 0x1c: [io  0x7060-0x7063]
[    1.672777] pci 0000:00:1f.2: reg 0x20: [io  0x7020-0x703f]
[    1.672785] pci 0000:00:1f.2: reg 0x24: [mem 0xb1540000-0xb15407ff]
[    1.672820] pci 0000:00:1f.2: PME# supported from D3hot
[    1.672882] pci 0000:00:1f.3: [8086:1e22] type 00 class 0x0c0500
[    1.672898] pci 0000:00:1f.3: reg 0x10: [mem 0xb1530000-0xb15300ff 64bit]
[    1.672919] pci 0000:00:1f.3: reg 0x20: [io  0x7000-0x701f]
[    1.673027] pci 0000:01:00.0: [5333:9043] type 00 class 0x030000
[    1.673036] pci 0000:01:00.0: reg 0x10: [mem 0xb1400000-0xb147ffff]
[    1.673042] pci 0000:01:00.0: reg 0x14: [mem 0xc0000000-0xcfffffff pref]
[    1.673065] pci 0000:01:00.0: reg 0x30: [mem 0xb1490000-0xb149ffff pref]
[    1.673088] pci 0000:01:00.0: supports D1 D2
[    1.673100] pci 0000:01:00.0: System wakeup disabled by ACPI
[    1.678772] pci 0000:01:00.1: [5333:903f] type 00 class 0x040300
[    1.678781] pci 0000:01:00.1: reg 0x10: [mem 0xb1480000-0xb1483fff]
[    1.678829] pci 0000:01:00.1: supports D1 D2
[    1.680767] pci 0000:00:01.0: PCI bridge to [bus 01]
[    1.685722] pci 0000:00:01.0:   bridge window [mem 0xb1400000-0xb14fffff]
[    1.685725] pci 0000:00:01.0:   bridge window [mem 0xc0000000-0xcfffffff
64bit pref]
[    1.685776] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    1.690800] pci 0000:03:00.0: [1415:9501] type 00 class 0x070002
[    1.690823] pci 0000:03:00.0: reg 0x10: [io  0x6000-0x6007]
[    1.690963] pci 0000:03:00.0: supports D1 D2
[    1.690965] pci 0000:03:00.0: PME# supported from D1 D2 D3hot D3cold
[    1.690991] pci 0000:03:00.0: System wakeup disabled by ACPI
[    1.696679] pci 0000:03:00.2: [1415:c126] type 00 class 0x088000
[    1.696702] pci 0000:03:00.2: reg 0x10: [mem 0xb0200000-0xb02003ff]
[    1.696717] pci 0000:03:00.2: reg 0x14: [mem 0xb0000000-0xb01fffff]
[    1.696839] pci 0000:03:00.2: supports D1 D2
[    1.696841] pci 0000:03:00.2: PME# supported from D1 D2 D3hot D3cold
[    1.698677] pci 0000:00:1c.2: PCI bridge to [bus 03]
[    1.703642] pci 0000:00:1c.2:   bridge window [io  0x6000-0x6fff]
[    1.703646] pci 0000:00:1c.2:   bridge window [mem 0xb0000000-0xb02fffff]
[    1.703718] pci 0000:00:1c.6: PCI bridge to [bus 04-0b]
[    1.708933] pci 0000:00:1c.6:   bridge window [io  0x2000-0x5fff]
[    1.708939] pci 0000:00:1c.6:   bridge window [mem 0xb0300000-0xb13fffff]
[    1.708947] pci 0000:00:1c.6:   bridge window [mem 0xd0000000-0xd10fffff
64bit pref]
[    1.709965] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 15)
[    1.716998] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12 14 15)
[    1.724023] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 *10 11 12 14 15)
[    1.731056] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 10 11 12 14 15)
[    1.738095] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 *11 12 14 15)
[    1.745125] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 11 12 14 15) *0,
disabled.
[    1.753302] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 11 12 14 15) *0,
disabled.
[    1.761489] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 10 11 12 14 15)
[    1.768739] ACPI: Enabled 5 GPEs in block 00 to 3F
[    1.773575] ACPI : EC: GPE = 0x17, I/O: command/status = 0x66, data = 0x62
[    1.780523] vgaarb: setting as boot device: PCI:0000:01:00.0
[    1.786166] vgaarb: device added:
PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    1.794235] vgaarb: loaded
[    1.796935] vgaarb: bridge control possible 0000:01:00.0
[    1.802287] SCSI subsystem initialized
[    1.806052] ACPI: bus type USB registered
[    1.810064] usbcore: registered new interface driver usbfs
[    1.815540] usbcore: registered new interface driver hub
[    1.820860] usbcore: registered new device driver usb
[    1.825986] PCI: Using ACPI for IRQ routing
[    1.831823] PCI: pci_cache_line_size set to 64 bytes
[    1.831875] e820: reserve RAM buffer [mem 0x0009ac00-0x0009ffff]
[    1.831877] e820: reserve RAM buffer [mem 0xad2ad000-0xafffffff]
[    1.831878] e820: reserve RAM buffer [mem 0xaedc4000-0xafffffff]
[    1.831879] e820: reserve RAM buffer [mem 0xaf800000-0xafffffff]
[    1.831881] e820: reserve RAM buffer [mem 0x24e000000-0x24fffffff]
[    1.831978] NetLabel: Initializing
[    1.835369] NetLabel:  domain hash size = 128
[    1.839713] NetLabel:  protocols = UNLABELED CIPSOv4
[    1.844674] NetLabel:  unlabeled traffic allowed by default
[    1.850270] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    1.856544] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    1.864387] Switched to clocksource hpet
[    1.873329] pnp: PnP ACPI init
[    1.876587] system 00:00: [io  0x06a4] has been reserved
[    1.881890] system 00:00: [io  0x06a0] has been reserved
[    1.887191] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.887247] system 00:01: [io  0x0680-0x069f] has been reserved
[    1.893156] system 00:01: [io  0x1004-0x1013] has been reserved
[    1.899064] system 00:01: [io  0xffff] has been reserved
[    1.904364] system 00:01: [io  0xffff] has been reserved
[    1.909665] system 00:01: [io  0x0400-0x0453] could not be reserved
[    1.915918] system 00:01: [io  0x0458-0x047f] has been reserved
[    1.921825] system 00:01: [io  0x0500-0x057f] has been reserved
[    1.927729] system 00:01: [io  0x164e-0x164f] has been reserved
[    1.933637] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.933664] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    1.933701] system 00:03: [io  0x0454-0x0457] has been reserved
[    1.939613] system 00:03: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
[    1.939798] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
[    1.939888] pnp 00:05: Plug and Play ACPI device, IDs PNP0303 (active)
[    1.939936] pnp 00:06: Plug and Play ACPI device, IDs PNP0c31 (active)
[    1.940062] system 00:07: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    1.946665] system 00:07: [mem 0xfed10000-0xfed17fff] could not be reserved
[    1.953611] system 00:07: [mem 0xfed18000-0xfed18fff] has been reserved
[    1.960209] system 00:07: [mem 0xfed19000-0xfed19fff] has been reserved
[    1.966809] system 00:07: [mem 0xf8000000-0xfbffffff] has been reserved
[    1.973411] system 00:07: [mem 0xfed20000-0xfed3ffff] has been reserved
[    1.980012] system 00:07: [mem 0xfed90000-0xfed93fff] could not be reserved
[    1.986956] system 00:07: [mem 0xfed45000-0xfed8ffff] has been reserved
[    1.993557] system 00:07: [mem 0xff000000-0xffffffff] could not be reserved
[    2.000503] system 00:07: [mem 0xfee00000-0xfeefffff] could not be reserved
[    2.007449] system 00:07: [mem 0xb15b0000-0xb15b0fff] has been reserved
[    2.014047] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.014291] system 00:08: [mem 0x00000000-0x0009cfff] could not be reserved
[    2.021240] system 00:08: Plug and Play ACPI device, IDs PNP0c01 (active)
[    2.021272] pnp: PnP ACPI: found 9 devices
[    2.031452] clocksource acpi_pm: mask: 0xffffff max_cycles: 0xffffff,
max_idle_ns: 2085701024 ns
[    2.040253] pci 0000:00:01.0: PCI bridge to [bus 01]
[    2.045211] pci 0000:00:01.0:   bridge window [mem 0xb1400000-0xb14fffff]
[    2.051983] pci 0000:00:01.0:   bridge window [mem 0xc0000000-0xcfffffff
64bit pref]
[    2.059711] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    2.064675] pci 0000:00:1c.2: PCI bridge to [bus 03]
[    2.069631] pci 0000:00:1c.2:   bridge window [io  0x6000-0x6fff]
[    2.075716] pci 0000:00:1c.2:   bridge window [mem 0xb0000000-0xb02fffff]
[    2.082496] pci 0000:00:1c.6: PCI bridge to [bus 04-0b]
[    2.087710] pci 0000:00:1c.6:   bridge window [io  0x2000-0x5fff]
[    2.093795] pci 0000:00:1c.6:   bridge window [mem 0xb0300000-0xb13fffff]
[    2.100573] pci 0000:00:1c.6:   bridge window [mem 0xd0000000-0xd10fffff
64bit pref]
[    2.108306] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    2.108308] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    2.108310] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    2.108311] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000d3fff window]
[    2.108313] pci_bus 0000:00: resource 8 [mem 0x000d4000-0x000d7fff window]
[    2.108314] pci_bus 0000:00: resource 9 [mem 0x000d8000-0x000dbfff window]
[    2.108316] pci_bus 0000:00: resource 10 [mem 0x000dc000-0x000dffff window]
[    2.108317] pci_bus 0000:00: resource 11 [mem 0x000e0000-0x000e3fff window]
[    2.108319] pci_bus 0000:00: resource 12 [mem 0x000e4000-0x000e7fff window]
[    2.108320] pci_bus 0000:00: resource 13 [mem 0xb0000000-0xfeafffff window]
[    2.108322] pci_bus 0000:01: resource 1 [mem 0xb1400000-0xb14fffff]
[    2.108323] pci_bus 0000:01: resource 2 [mem 0xc0000000-0xcfffffff 64bit pref]
[    2.108325] pci_bus 0000:03: resource 0 [io  0x6000-0x6fff]
[    2.108326] pci_bus 0000:03: resource 1 [mem 0xb0000000-0xb02fffff]
[    2.108328] pci_bus 0000:04: resource 0 [io  0x2000-0x5fff]
[    2.108329] pci_bus 0000:04: resource 1 [mem 0xb0300000-0xb13fffff]
[    2.108331] pci_bus 0000:04: resource 2 [mem 0xd0000000-0xd10fffff 64bit pref]
[    2.108358] NET: Registered protocol family 2
[    2.112887] TCP established hash table entries: 65536 (order: 7, 524288 bytes)
[    2.120243] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    2.127041] TCP: Hash tables configured (established 65536 bind 65536)
[    2.133590] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    2.139693] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    2.146268] NET: Registered protocol family 1
[    2.174699] pci 0000:01:00.0: Video device with shadowed ROM
[    2.174709] PCI: CLS 64 bytes, default 64
[    2.174749] Unpacking initramfs...
[    2.580026] Freeing initrd memory: 28204K (ffff8800348db000 - ffff880036466000)
[    2.587341] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    2.593768] software IO TLB [mem 0xa92ad000-0xad2ad000] (64MB) mapped at
[ffff8800a92ad000-ffff8800ad2acfff]
[    2.603639] RAPL PMU detected, API unit is 2^-32 Joules, 3 fixed counters
163840 ms ovfl timer
[    2.612232] hw unit of domain pp0-core 2^-16 Joules
[    2.617099] hw unit of domain package 2^-16 Joules
[    2.621884] hw unit of domain pp1-gpu 2^-16 Joules
[    2.626814] microcode: CPU0 sig=0x306a9, pf=0x10, revision=0x1b
[    2.632725] microcode: CPU1 sig=0x306a9, pf=0x10, revision=0x1b
[    2.638635] microcode: CPU2 sig=0x306a9, pf=0x10, revision=0x1b
[    2.644542] microcode: CPU3 sig=0x306a9, pf=0x10, revision=0x1b
[    2.650451] microcode: CPU4 sig=0x306a9, pf=0x10, revision=0x1b
[    2.656359] microcode: CPU5 sig=0x306a9, pf=0x10, revision=0x1b
[    2.662267] microcode: CPU6 sig=0x306a9, pf=0x10, revision=0x1b
[    2.668176] microcode: CPU7 sig=0x306a9, pf=0x10, revision=0x1b
[    2.674120] microcode: Microcode Update Driver: v2.00
<tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    2.683637] futex hash table entries: 4096 (order: 6, 262144 bytes)
[    2.689932] Initialise system trusted keyring
[    2.694298] audit: initializing netlink subsys (disabled)
[    2.699698] audit: type=2000 audit(1433266910.004:1): initialized
[    2.706118] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    2.713743] zpool: loaded
[    2.716361] zbud: loaded
[    2.719050] VFS: Disk quotas dquot_6.6.0
[    2.722998] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    2.730019] Key type big_key registered
[    2.733851] SELinux:  Registering netfilter hooks
[    2.734843] alg: No test for stdrng (krng)
[    2.738946] NET: Registered protocol family 38
[    2.743392] Key type asymmetric registered
[    2.747484] Asymmetric key parser 'x509' registered
[    2.752392] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    2.759821] io scheduler noop registered
[    2.763738] io scheduler deadline registered (default)
[    2.768893] io scheduler cfq registered
[    2.773274] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    2.778852] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    2.785479] intel_idle: MWAIT substates: 0x21120
[    2.785481] intel_idle: v0.4 model 0x3A
[    2.785482] intel_idle: lapic_timer_reliable_states 0xffffffff
[    2.785805] ACPI: AC Adapter [ADP1] (on-line)
[    2.790250] input: Lid Switch as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input0
[    2.798501] ACPI: Lid Switch [LID0]
[    2.802027] input: Power Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    2.810361] ACPI: Power Button [PWRB]
[    2.814045] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    2.821425] ACPI: Power Button [PWRF]
[    2.921630] thermal LNXTHERM:00: registered as thermal_zone0
[    2.927279] ACPI: Thermal Zone [TZ00] (32 C)
[    2.932192] thermal LNXTHERM:01: registered as thermal_zone1
[    2.937840] ACPI: Thermal Zone [TZ01] (32 C)
[    2.942131] GHES: HEST is not enabled!
[    2.942421] ACPI: Battery Slot [BAT0] (battery present)
[    2.942449] ACPI: Battery Slot [BAT1] (battery absent)
[    2.942503] ACPI: Battery Slot [BAT2] (battery absent)
[    2.961417] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    2.988543] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    3.016847] serial8250: ttyS2 at I/O 0x3e8 (irq = 4, base_baud = 115200) is a
16550A
[    3.045264] 0000:00:16.3: ttyS1 at I/O 0x70a0 (irq = 19, base_baud = 115200)
is a 16550A

^^^ PRARIT: 16.3 is ttyS1, note that the serial console is ttyS0, so 16.3 is
NOT active.

[    3.053677] ttyS3: detected caps 00000700 should be 00000500
[    3.059329] 0000:03:00.0: ttyS3 at I/O 0x6000 (irq = 18, base_baud = 115200)
is a 16C950/954
[    3.067823] serial 0000:03:00.0: Couldn't register serial port 6008, irq 18,
type 0, error -28
[    3.076697] Non-volatile memory driver v1.3
[    3.080930] Linux agpgart interface v0.103
[    3.120337] tpm_tis 00:06: 1.2 TPM (device-id 0xB, rev-id 16)
[    3.264301] rdac: device handler registered
[    3.268633] hp_sw: device handler registered
[    3.272916] emc: device handler registered
[    3.277006] alua: device handler registered
[    3.281224] libphy: Fixed MDIO Bus: probed
[    3.285545] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    3.290858] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    3.298339] xhci_hcd 0000:00:14.0: hcc params 0x20007181 hci version 0x100
quirks 0x0000b930
[    3.306763] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    3.306854] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    3.313630] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.320836] usb usb1: Product: xHCI Host Controller
[    3.325704] usb usb1: Manufacturer: Linux 4.1.0-rc5+ xhci-hcd
[    3.331437] usb usb1: SerialNumber: 0000:00:14.0
[    3.336212] hub 1-0:1.0: USB hub found
[    3.339969] hub 1-0:1.0: 4 ports detected
[    3.344370] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    3.349674] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    3.357088] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[    3.363862] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.371068] usb usb2: Product: xHCI Host Controller
[    3.375936] usb usb2: Manufacturer: Linux 4.1.0-rc5+ xhci-hcd
[    3.381670] usb usb2: SerialNumber: 0000:00:14.0
[    3.386409] hub 2-0:1.0: USB hub found
[    3.390160] hub 2-0:1.0: 4 ports detected
[    3.394493] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    3.401011] ehci-pci: EHCI PCI platform driver
[    3.405533] ehci-pci 0000:00:1a.0: EHCI Host Controller
[    3.410811] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 3
[    3.418201] ehci-pci 0000:00:1a.0: debug port 2
[    3.426613] ehci-pci 0000:00:1a.0: cache line size of 64 is not supported
[    3.426630] ehci-pci 0000:00:1a.0: irq 16, io mem 0xb1560000
[    3.437431] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    3.443199] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[    3.449976] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.457181] usb usb3: Product: EHCI Host Controller
[    3.462050] usb usb3: Manufacturer: Linux 4.1.0-rc5+ ehci_hcd
[    3.467786] usb usb3: SerialNumber: 0000:00:1a.0
[    3.472601] hub 3-0:1.0: USB hub found
[    3.476359] hub 3-0:1.0: 3 ports detected
[    3.480586] ehci-pci 0000:00:1d.0: EHCI Host Controller
[    3.485901] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 4
[    3.493299] ehci-pci 0000:00:1d.0: debug port 2
[    3.501739] ehci-pci 0000:00:1d.0: cache line size of 64 is not supported
[    3.501753] ehci-pci 0000:00:1d.0: irq 23, io mem 0xb1550000
[    3.512518] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    3.518288] usb usb4: New USB device found, idVendor=1d6b, idProduct=0002
[    3.525063] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.532268] usb usb4: Product: EHCI Host Controller
[    3.537136] usb usb4: Manufacturer: Linux 4.1.0-rc5+ ehci_hcd
[    3.542871] usb usb4: SerialNumber: 0000:00:1d.0
[    3.547651] hub 4-0:1.0: USB hub found
[    3.551403] hub 4-0:1.0: 3 ports detected
[    3.555550] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    3.561722] ohci-pci: OHCI PCI platform driver
[    3.566166] uhci_hcd: USB Universal Host Controller Interface driver
[    3.572546] usbcore: registered new interface driver usbserial
[    3.578372] usbcore: registered new interface driver usbserial_generic
[    3.584916] usbserial: USB Serial support registered for generic
[    3.590936] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    3.597708] i8042: PNP: PS/2 appears to have AUX port disabled, if this is
incorrect please boot with i8042.nopnp
[    3.605550] tsc: Refined TSC clocksource calibration: 2594.107 MHz
[    3.605552] clocksource tsc: mask: 0xffffffffffffffff max_cycles:
0x25647d583cf, max_idle_ns: 440795304232 ns
[    3.624465] serio: i8042 KBD port at 0x60,0x64 irq 1
[    3.629523] mousedev: PS/2 mouse device common for all mice
[    3.635391] rtc_cmos 00:02: RTC can wake from S4
[    3.640156] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
[    3.646275] rtc_cmos 00:02: alarms up to one month, y3k, 242 bytes nvram,
hpet irqs
[    3.653938] Intel P-state driver initializing.
[    3.659532] hidraw: raw HID events driver (C) Jiri Kosina
[    3.665143] usbcore: registered new interface driver usbhid
[    3.670714] usbhid: USB HID core driver
[    3.674693] drop_monitor: Initializing network drop monitor service
[    3.681118] Initializing XFRM netlink socket
[    3.685598] NET: Registered protocol family 10
[    3.690097] input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input3
[    3.699200] NET: Registered protocol family 17
[    3.704806] Loading compiled-in X.509 certificates
[    3.711281] Loaded X.509 cert 'Build time autogenerated kernel key:
6a2b307b2f1c54d027feeb667b8425db27e9a8f7'
[    3.721224] registered taskstats version 1
[    3.729077] Key type trusted registered
[    3.740649] Key type encrypted registered
[    3.786771] usb 3-1: new high-speed USB device number 2 using ehci-pci
[    3.859814] usb 4-1: new high-speed USB device number 2 using ehci-pci
[    3.907508] usb 3-1: New USB device found, idVendor=8087, idProduct=0024
[    3.914211] usb 3-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.922171] hub 3-1:1.0: USB hub found
[    3.926106] hub 3-1:1.0: 6 ports detected
[    3.984684] usb 4-1: New USB device found, idVendor=8087, idProduct=0024
[    3.991387] usb 4-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.998959] hub 4-1:1.0: USB hub found
[    4.002868] hub 4-1:1.0: 8 ports detected
[    4.069049] evm: HMAC attrs: 0x1
[    4.073298] rtc_cmos 00:02: setting system clock to 2015-06-02 17:41:53 UTC
(1433266913)
[    4.082175] Freeing unused kernel memory: 1712K (ffffffff81b43000 -
ffffffff81cef000)
[    4.093912] systemd[1]: Unknown kernel switch systemd.debug. Ignoring.
[    4.100441] systemd[1]: Supported kernel switches:
[    4.105235] systemd[1]: systemd.unit=UNIT                        Default unit
to start
[    4.113153] systemd[1]: rd.systemd.unit=UNIT                     Default unit
to start when run in initrd
[    4.122710] systemd[1]: systemd.dump_core=0|1                    Dump core on
crash
[    4.130355] systemd[1]: systemd.crash_shell=0|1                  Run shell on
crash
[    4.138003] systemd[1]: systemd.crash_chvt=N                     Change to VT
#N on crash
[    4.146168] systemd[1]: systemd.confirm_spawn=0|1                Confirm
every process spawn
[    4.154598] systemd[1]: systemd.show_status=0|1                  Show status
updates on the console during bootup
[    4.164843] systemd[1]:
systemd.log_target=console|kmsg|journal|journal-or-kmsg|syslog|syslog-or-kmsg|null
[    4.174480] systemd[1]:                                          Log target
[    4.181429] systemd[1]: systemd.log_level=LEVEL                  Log level
[    4.188294] systemd[1]: systemd.log_color=0|1                    Highlight
important log messages
[    4.197149] systemd[1]: systemd.log_location=0|1                 Include code
location in log messages
[    4.206442] systemd[1]:
systemd.default_standard_output=null|tty|syslog|syslog+console|kmsg|kmsg+console|journal|journal+console
[    4.217985] systemd[1]:                                          Set default
log output for services
[    4.227102] systemd[1]:
systemd.default_standard_error=null|tty|syslog|syslog+console|kmsg|kmsg+console|journal|journal+console
[    4.238556] systemd[1]:                                          Set default
log error output for services
[    4.248191] systemd[1]: systemd.setenv=ASSIGNMENT                Set an
environment variable for all spawned processes
[    4.259583] systemd[1]: systemd 208 running in system mode. (+PAM +LIBWRAP
+AUDIT +SELINUX +IMA +SYSVINIT +LIBCRYPTSETUP +GCRYPT +ACL +XZ)
[    4.272226] systemd[1]: Running in initial RAM disk.
[    4.287409] systemd[1]: Set hostname to
<intel-chiefriver-04.khw.lab.eng.bos.redhat.com>.
[    4.296890] random: systemd urandom read with 57 bits of entropy available
[    4.343224] systemd[1]: Expecting device
dev-mapper-rhel_intel\x2d\x2dchiefriver\x2d\x2d04\x2droot.device...
[    4.362258] systemd[1]: Starting -.slice.
[    4.371232] systemd[1]: Created slice -.slice.
[    4.375825] systemd[1]: Starting System Slice.
[    4.385252] systemd[1]: Created slice System Slice.
[    4.390281] systemd[1]: Starting Slices.
[    4.399256] systemd[1]: Reached target Slices.
[    4.403877] systemd[1]: Starting Timers.
[    4.412236] systemd[1]: Reached target Timers.
[    4.416822] systemd[1]: Starting Journal Socket.
[    4.426257] systemd[1]: Listening on Journal Socket.
[    4.431407] systemd[1]: Started dracut ask for additional cmdline parameters.
[    4.438716] systemd[1]: Starting dracut cmdline hook...
[    4.448991] systemd[1]: Started Load Kernel Modules.
[    4.453986] systemd[1]: Starting Setup Virtual Console...
[    4.464589] systemd[1]: Starting Journal Service...
[    4.479192] systemd[1]: Started Journal Service.
[    4.602721] device-mapper: uevent: version 1.0.3
[    4.607451] device-mapper: ioctl: 4.31.0-ioctl (2015-3-12) initialised:
dm-devel@redhat.com
[    4.615804] Switched to clocksource tsc
[    4.663680] systemd-udevd[298]: starting version 208
[    4.706020] pps_core: LinuxPPS API ver. 1 registered
[    4.711726] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo
Giometti <giometti@linux.it>
[    4.723961] libata version 3.00 loaded.
[    4.725552] PTP clock support registered
[    4.733106] ahci 0000:00:1f.2: version 3.0
[    4.733248] ahci 0000:00:1f.2: SSS flag set, parallel bus scan disabled
[    4.740817] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x1b
impl SATA mode
[    4.749702] ahci 0000:00:1f.2: flags: 64bit ncq stag pm led clo pio slum part
ems sxs apst
[    4.758244] e1000e: Intel(R) PRO/1000 Network Driver - 2.3.2-k
[    4.763757] scsi host0: ahci
[    4.763834] scsi host1: ahci
[    4.763898] scsi host2: ahci
[    4.763960] scsi host3: ahci
[    4.764021] scsi host4: ahci
[    4.764086] scsi host5: ahci
[    4.764133] ata1: SATA max UDMA/133 abar m2048@0xb1540000 port 0xb1540100 irq 27
[    4.764136] ata2: SATA max UDMA/133 abar m2048@0xb1540000 port 0xb1540180 irq 27
[    4.764137] ata3: DUMMY
[    4.764139] ata4: SATA max UDMA/133 abar m2048@0xb1540000 port 0xb1540280 irq 27
[    4.764143] ata5: SATA max UDMA/133 abar m2048@0xb1540000 port 0xb1540300 irq 27
[    4.764143] ata6: DUMMY
[    4.819270] e1000e: Copyright(c) 1999 - 2014 Intel Corporation.
[    4.825337] e1000e 0000:00:19.0: Interrupt Throttling Rate (ints/sec) set to
dynamic conservative mode
[    5.030209] e1000e 0000:00:19.0 eth0: registered PHC clock
[    5.035710] e1000e 0000:00:19.0 eth0: (PCI Express:2.5GT/s:Width x1)
00:13:20:fb:9d:52
[    5.043626] e1000e 0000:00:19.0 eth0: Intel(R) PRO/1000 Network Connection
[    5.050521] e1000e 0000:00:19.0 eth0: MAC: 10, PHY: 11, PBA No: FFFFFF-0FF
[    5.058307] e1000e 0000:00:19.0 eno1: renamed from eth0
[    5.069600] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    5.076111] ata1.00: ATA-7: INTEL SSDSA2M160G2GC, 2CV102M3, max UDMA/133
[    5.082809] ata1.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    5.089991] ata1.00: configured for UDMA/133
[    5.094502] scsi 0:0:0:0: Direct-Access     ATA      INTEL SSDSA2M160 02M3
PQ: 0 ANSI: 5
[    5.096791] systemd-udevd[300]: renamed network interface eth0 to eno1
[    5.413822] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    5.421880] ata2.00: ATAPI: Optiarc BD ROM BC-5500H, 1.00, max UDMA/100
[    5.430435] ata2.00: configured for UDMA/100
[    5.437722] scsi 1:0:0:0: CD-ROM            Optiarc  BD ROM BC-5500H  1.00
PQ: 0 ANSI: 5
[    5.762048] ata4: SATA link down (SStatus 0 SControl 300)
[    6.072203] ata5: SATA link down (SStatus 0 SControl 300)
[    6.092320] ata1.00: Enabling discard_zeroes_data
[    6.097058] sd 0:0:0:0: [sda] 312581808 512-byte logical blocks: (160 GB/149 GiB)
[    6.104612] sd 0:0:0:0: [sda] Write Protect is off
[    6.109398] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    6.109416] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,
doesn't support DPO or FUA
[    6.118587] ata1.00: Enabling discard_zeroes_data
[    6.123561]  sda: sda1 sda2
[    6.124337] sr 1:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw
xa/form2 cdda tray
[    6.124338] cdrom: Uniform CD-ROM driver Revision: 3.20
[    6.124507] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    6.140528] ata1.00: Enabling discard_zeroes_data
[    6.145291] sd 0:0:0:0: [sda] Attached SCSI disk
[    6.480302] SGI XFS with ACLs, security attributes, no debug enabled
[    6.488298] XFS (dm-0): Mounting V4 Filesystem
[    6.525394] XFS (dm-0): Ending clean mount
[    6.763264] systemd-journald[166]: Received SIGTERM
[    6.811667] audit: type=1404 audit(1433266916.236:2): enforcing=1
old_enforcing=0 auid=4294967295 ses=4294967295
[    6.850180] SELinux: 32768 avtab hash slots, 111514 rules.
[    6.875009] SELinux: 32768 avtab hash slots, 111514 rules.
[    6.905256] SELinux:  8 users, 102 roles, 4977 types, 295 bools, 1 sens, 1024
cats
[    6.905260] SELinux:  83 classes, 111514 rules
[    6.909960] SELinux:  Permission audit_read in class capability2 not defined
in policy.
[    6.917953] SELinux:  Class binder not defined in policy.
[    6.923343] SELinux: the above unknown classes and permissions will be allowed
[    6.930552] SELinux:  Completing initialization.
[    6.930553] SELinux:  Setting up existing superblocks.
[    6.936197] audit: type=1403 audit(1433266916.360:3): policy loaded
auid=4294967295 ses=4294967295
[    6.950032] systemd[1]: Successfully loaded SELinux policy in 140.123ms.
[    7.017645] systemd[1]: Relabelled /dev and /run in 30.345ms.
[    7.025635] systemd[1]: Unknown kernel switch systemd.debug. Ignoring.
[    7.032158] systemd[1]: Supported kernel switches:
[    7.036944] systemd[1]: systemd.unit=UNIT                        Default unit
to start
[    7.044844] systemd[1]: rd.systemd.unit=UNIT                     Default unit
to start when run in initrd
[    7.054388] systemd[1]: systemd.dump_core=0|1                    Dump core on
crash
[    7.062028] systemd[1]: systemd.crash_shell=0|1                  Run shell on
crash
[    7.069670] systemd[1]: systemd.crash_chvt=N                     Change to VT
#N on crash
[    7.077832] systemd[1]: systemd.confirm_spawn=0|1                Confirm
every process spawn
[    7.086252] systemd[1]: systemd.show_status=0|1                  Show status
updates on the console during bootup
[    7.096491] systemd[1]:
systemd.log_target=console|kmsg|journal|journal-or-kmsg|syslog|syslog-or-kmsg|null
[    7.106123] systemd[1]:                                          Log target
[    7.113069] systemd[1]: systemd.log_level=LEVEL                  Log level
[    7.119927] systemd[1]: systemd.log_color=0|1                    Highlight
important log messages
[    7.128774] systemd[1]: systemd.log_location=0|1                 Include code
location in log messages
[    7.138057] systemd[1]:
systemd.default_standard_output=null|tty|syslog|syslog+console|kmsg|kmsg+console|journal|journal+console
[    7.149594] systemd[1]:                                          Set default
log output for services
[    7.158702] systemd[1]:
systemd.default_standard_error=null|tty|syslog|syslog+console|kmsg|kmsg+console|journal|journal+console
[    7.170150] systemd[1]:                                          Set default
log error output for services
[    7.179778] systemd[1]: systemd.setenv=ASSIGNMENT                Set an
environment variable for all spawned processes
[    7.365849] systemd-udevd[557]: starting version 208
[    7.441304] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    7.448550] ACPI Warning: SystemIO range
0x0000000000000428-0x000000000000042F conflicts with OpRegion
0x0000000000000400-0x000000000000047F (\PMIO) (20150410/utaddress-254)
[    7.467979] ACPI: If an ACPI driver is available for this device, you should
use it instead of the native driver
[    7.482960] ACPI Warning: SystemIO range
0x0000000000000540-0x000000000000054F conflicts with OpRegion
0x0000000000000500-0x0000000000000563 (\GPIO) (20150410/utaddress-254)
[    7.486199] ACPI: If an ACPI driver is available for this device, you should
use it instead of the native driver
[    7.486728] ACPI Warning:
[    7.486729] SystemIO range 0x0000000000000530-0x000000000000053F conflicts
with OpRegion 0x0000000000000500-0x0000000000000563 (\GPIO)
[    7.486730]  (20150410/utaddress-254)
[    7.486730] ACPI: If an ACPI driver is available for this device, you should
use it instead of the native driver
[    7.486731] ACPI Warning:
[    7.486732] SystemIO range 0x0000000000000500-0x000000000000052F conflicts
with OpRegion 0x0000000000000500-0x0000000000000563 (\GPIO)
[    7.486732]  (20150410/utaddress-254)
[    7.486733] ACPI: If an ACPI driver is available for this device, you should
use it instead of the native driver
[    7.486733] lpc_ich: Resource conflict(s) found affecting gpio_ich
[    7.513276] random: nonblocking pool is initialized
[    7.585772] XFS (sda1): Mounting V4 Filesystem
[    7.594068] Adding 8126460k swap on
/dev/mapper/rhel_intel--chiefriver--04-swap.  Priority:-1 extents:1
across:8126460k SSFS
[    7.612994] input: PC Speaker as /devices/platform/pcspkr/input/input4
[    7.620169] iTCO_vendor_support: vendor-support=0
[    7.620362] ACPI Warning: SystemIO range
0x0000000000007000-0x000000000000701F conflicts with OpRegion
0x0000000000007000-0x000000000000700F (\_SB_.PCI0.SBUS.SMBI)
(20150410/utaddress-254)
[    7.620363] ACPI: If an ACPI driver is available for this device, you should
use it instead of the native driver
[    7.657147] ppdev: user-space parallel port driver
[    7.663372] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[    7.670251] iTCO_wdt: Found a Panther Point TCO device (Version=2,
TCOBASE=0x0460)
[    7.679249] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    7.715565] XFS (dm-2): Mounting V4 Filesystem
[    7.730324] AVX version of gcm_enc/dec engaged.
[    7.735647] AES CTR mode by8 optimization enabled
[    7.743485] alg: No test for __gcm-aes-aesni (__driver-gcm-aes-aesni)
[    7.764627] XFS (dm-2): Ending clean mount
[    7.781305] alg: No test for crc32 (crc32-pclmul)
[    8.004776] XFS (sda1): Ending clean mount
[    8.080300] audit: type=1305 audit(1433266917.503:4): audit_pid=680 old=0
auid=4294967295 ses=4294967295 subj=system_u:system_r:auditd_t:s0 res=1
[    8.197594] IPv6: ADDRCONF(NETDEV_UP): eno1: link is not ready
[    8.426940] IPv6: ADDRCONF(NETDEV_UP): eno1: link is not ready
[    8.435568] IPv6: ADDRCONF(NETDEV_UP): eno1: link is not ready
[   10.456192] floppy0: no floppy controllers found
[   11.430860] e1000e: eno1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
[   11.438358] IPv6: ADDRCONF(NETDEV_CHANGE): eno1: link becomes ready
[   13.498199] floppy0: no floppy controllers found
[   17.058200] FS-Cache: Loaded
[   17.144740] RPC: Registered named UNIX socket transport module.
[   17.150656] RPC: Registered udp transport module.
[   17.155352] RPC: Registered tcp transport module.
[   17.160056] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   17.286247] FS-Cache: Netfs 'nfs' registered for caching
[   17.296504] Key type dns_resolver registered
[   17.391116] NFS: Registering the id_resolver key type
[   17.396162] Key type id_resolver registered
[   17.400346] Key type id_legacy registered
[   79.611315] systemd-journald[544]: Received request to flush runtime journal
from PID 1

> 
> In this scenario, I assume the serial port device remains powered all the
> time, even while it is logically removed from the system, so when we
> re-enumerate and find the device, I would think its BARs would still
> contain whatever they had before, and since they are still valid, we should
> still use them.

Nope.  The device should go down as ttyS1 is not active.

> 
> So I think my expectation is the same as yours, and I don't know why it
> doesn't work that way.  I assume the device actually *works* with the new
> resources, so it's not really broken in that sense, but it does bother me
> if we're changing something when we don't need to change it.

Yep ... I think it's broken.  Here's what I'm doing to down then rescan
the device.

[root@intel-chiefriver-04 ~]# cd /sys/devices/pci0000\:00/0000\:00\:16.3
[root@intel-chiefriver-04 0000:00:16.3]# echo 1 > remove
[root@intel-chiefriver-04 0000:00:16.3]# lspci | grep 16.3
[root@intel-chiefriver-04 0000:00:16.3]# cd ../pci_bus/0000\:00/
[root@intel-chiefriver-04 0000:00]# echo 1 > rescan

and the console contains

[  353.212980] pci 0000:00:16.3: [8086:1e3d] type 00 class 0x070002
[  353.231163] pci 0000:00:16.3: BAR 1: assigned [mem 0xb1520000-0xb1520fff]
[  353.237937] pci 0000:00:16.3: BAR 0: assigned [io  0x1018-0x101f]

and the system is hung.  The addresses are clearly different here and I'll
debug further.  The one odd thing is that the ttyS1 device is not removed from
/sys/ during the remove.  It's almost as if it is left around as a place holder
for 16.3 if it should be reinserted, and I have a feeling that may lead to the
system hang.

P.


> 
> Bjorn
> 
> 

