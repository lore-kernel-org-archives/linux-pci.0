Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 4 May 2015 11:17:49 +0800
From: Baoquan He <bhe@redhat.com>
To: "Li, ZhenHua" <zhen-hual@hp.com>
Cc: alex.williamson@redhat.com, indou.takao@jp.fujitsu.com,
	tom.vaden@hp.com, rwright@hp.com, dwmw2@infradead.org,
	joro@8bytes.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, lisa.mitchell@hp.com,
	jerry.hoemann@hp.com, iommu@lists.linux-foundation.org,
	ddutile@redhat.com, doug.hatch@hp.com,
	ishii.hironobu@jp.fujitsu.com, linux-pci@vger.kernel.org,
	bhelgaas@google.com, billsumnerlinux@gmail.com, li.zhang6@hp.com,
	dyoung@redhat.com, vgoyal@redhat.com
Subject: Re: [PATCH v10 0/10] iommu/vt-d: Fix intel vt-d faults in kdump
 kernel
Message-ID: <20150504031749.GF5799@dhcp-16-116.nay.redhat.com>
References: <1428655333-19504-1-git-send-email-zhen-hual@hp.com>
 <20150429112024.GB5799@dhcp-16-116.nay.redhat.com>
 <20150503085530.GK15033@dhcp-16-116.nay.redhat.com>
 <5546E240.5090403@hp.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5I6of5zJg18YgZEa"
In-Reply-To: <5546E240.5090403@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 05/04/15 at 11:06am, Li, ZhenHua wrote:
> Hi baoquan,
> Could you paste the kernel log of the first kernel ?

Please check the attachment.

--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kdump_1st_kernel.log"

[    0.000000] microcode: CPU0 microcode updated early to revision 0x710, date = 2013-06-17
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.0.0+ (bhe@dhcp-128-28.nay.redhat.com) (gcc version 4.9.2 20150212 (Red Hat 4.9.2-6) (GCC) ) #6 SMP Wed Apr 29 16:53:34 CST 2015
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-4.0.0+ root=/dev/mapper/fedora_dhcp--128--28-root ro rd.lvm.lv=fedora_dhcp-128-28/swap rd.lvm.lv=fedora_dhcp-128-28/n
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x00000000000963ff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000096400-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000cb74ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cb750000-0x00000000cb7dafff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000cb7db000-0x00000000cbaacfff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000cbaad000-0x00000000cbaaefff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000cbaaf000-0x00000000cbabafff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000cbabb000-0x00000000cbacdfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000cbace000-0x00000000cbb55fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000cbb56000-0x00000000cbb5dfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000cbb5e000-0x00000000cbb70fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000cbb71000-0x00000000cbffffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000042fffffff] usable
[    0.000000] earlycon: no match for ttyS0,115200
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.7 present.
[    0.000000] e820: last_pfn = 0x430000 max_arch_pfn = 0x400000000
[    0.000000] PAT configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- UC  
[    0.000000] e820: last_pfn = 0xcb750 max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000f4bc0-0x000f4bcf] mapped at [ffff8800000f4bc0]
[    0.000000] Using GB pages for direct mapping
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000] init_memory_mapping: [mem 0x42fe00000-0x42fffffff]
[    0.000000] init_memory_mapping: [mem 0x420000000-0x42fdfffff]
[    0.000000] init_memory_mapping: [mem 0x400000000-0x41fffffff]
[    0.000000] init_memory_mapping: [mem 0x00100000-0xcb74ffff]
[    0.000000] init_memory_mapping: [mem 0x100000000-0x3ffffffff]
[    0.000000] RAMDISK: [mem 0x35a94000-0x36d41fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F9810 000024 (v02 HPQOEM)
[    0.000000] ACPI: XSDT 0x00000000CBA28078 00006C (v01 HPQOEM SLIC-WKS 01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x00000000CBA304C8 0000F4 (v04 HPQOEM SLIC-WKS 01072009 AMI  00010013)
[    0.000000] ACPI: DSDT 0x00000000CBA28170 008352 (v02 HPQOEM SLIC-WKS 00000102 INTL 20051117)
[    0.000000] ACPI: FACS 0x00000000CBB5BF80 000040
[    0.000000] ACPI: APIC 0x00000000CBA305C0 00007E (v03 HPQOEM SLIC-WKS 01072009 AMI  00010013)
[    0.000000] ACPI: MCFG 0x00000000CBA30640 00003C (v01 HPQOEM OEMMCFG. 01072009 MSFT 00000097)
[    0.000000] ACPI: HPET 0x00000000CBA30680 000038 (v01 HPQOEM SLIC-WKS 01072009 AMI. 00000004)
[    0.000000] ACPI: ASF! 0x00000000CBA306B8 0000A0 (v32 INTEL   HCG     00000001 TFSM 000F4240)
[    0.000000] ACPI: SSDT 0x00000000CBA30758 0058DA (v01 COMPAQ WMI      00000001 MSFT 03000001)
[    0.000000] ACPI: SLIC 0x00000000CBA36038 000176 (v01 HPQOEM SLIC-WKS 00000001      00000000)
[    0.000000] ACPI: SSDT 0x00000000CBA361B0 06E284 (v02 INTEL  CpuPm    00004000 INTL 20051117)
[    0.000000] ACPI: DMAR 0x00000000CBAA4438 0000A0 (v01 A M I  OEMDMAR  00000001 INTL 00000001)
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000042fffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x42ffea000-0x42fffdfff]
[    0.000000] Reserving 256MB of memory at 592MB for crashkernel (System RAM: 16310MB)
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000042fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x0000000000095fff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000cb74ffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000042fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000042fffffff]
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x04] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x06] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x00] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 0, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec01000] gsi_base[24])
[    0.000000] IOAPIC[1]: apic_id 2, version 32, address 0xfec01000, GSI 24-47
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] e820: [mem 0xcc000000-0xdfffffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Embedded 34 pages/cpu @ffff88042fc00000 s101720 r8192 d29352 u524288
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 4110322
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.0.0+ root=/dev/mapper/fedora_dhcp--128--28-root ro rd.lvm.lv=fedora_dhcp-128-28/swap rd.lvm.lv=fedora_dhcp-n
[    0.000000] Intel-IOMMU: enabled
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] xsave: enabled xstate_bv 0x7, cntxt size 0x340 using standard form
[    0.000000] Memory: 16075344K/16702356K available (7716K kernel code, 1276K rwdata, 3260K rodata, 1500K init, 1448K bss, 627012K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000]  RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=4.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS:4352 nr_irqs:864 16
[    0.000000]  Offload RCU callbacks from all CPUs
[    0.000000]  Offload RCU callbacks from CPUs: 0-3.
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [ttyS0] enabled
[    0.000000] clocksource hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2793.141 MHz processor
[    0.000031] Calibrating delay loop (skipped), value calculated using timer frequency.. 5586.28 BogoMIPS (lpj=2793141)
[    0.010648] pid_max: default: 32768 minimum: 301
[    0.015268] ACPI: Core revision 20150410
[    0.044335] ACPI: All ACPI Tables successfully acquired
[    0.051660] Security Framework initialized
[    0.055765] SELinux:  Initializing.
[    0.060304] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    0.070694] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.079198] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.086084] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.093626] Initializing cgroup subsys blkio
[    0.097901] Initializing cgroup subsys memory
[    0.102257] Initializing cgroup subsys devices
[    0.106702] Initializing cgroup subsys freezer
[    0.111142] Initializing cgroup subsys net_cls
[    0.115584] Initializing cgroup subsys perf_event
[    0.120284] Initializing cgroup subsys net_prio
[    0.124812] Initializing cgroup subsys hugetlb
[    0.129274] CPU: Physical Processor ID: 0
[    0.133287] CPU: Processor Core ID: 0
[    0.136953] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.142956] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.149996] mce: CPU supports 16 MCE banks
[    0.154110] CPU0: Thermal monitoring enabled (TM1)
[    0.158907] process: using mwait in idle threads
[    0.163525] Last level iTLB entries: 4KB 512, 2MB 8, 4MB 8
[    0.169004] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    0.175409] Freeing SMP alternatives memory: 28K (ffffffff81eb8000 - ffffffff81ebf000)
[    0.184411] ftrace: allocating 27958 entries in 110 pages
[    0.202553] dmar: Host address width 46
[    0.206386] dmar: DRHD base: 0x000000dfffc000 flags: 0x1
[    0.211698] dmar: IOMMU 0: reg_base_addr dfffc000 ver 1:0 cap d2078c106f0462 ecap f020fe
[    0.219776] dmar: RMRR base: 0x000000cba11000 end: 0x000000cba27fff
[    0.226032] dmar: ATSR flags: 0x0
[    0.229349] IOAPIC id 0 under DRHD base  0xdfffc000 IOMMU 0
[    0.234912] IOAPIC id 2 under DRHD base  0xdfffc000 IOMMU 0
[    0.240479] HPET id 0 under DRHD base 0xdfffc000
[    0.245298] Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.253118] Enabled IRQ remapping in x2apic mode
[    0.257727] x2apic enabled
[    0.260438] Switched APIC routing to cluster x2apic.
[    0.265915] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.281926] smpboot: CPU0: Intel(R) Xeon(R) CPU E5-1603 0 @ 2.80GHz (fam: 06, model: 2d, stepping: 07)
[    0.291283] Performance Events: PEBS fmt1+, 16-deep LBR, SandyBridge events, full-width counters, Intel PMU driver.
[    0.301794] ... version:                3
[    0.305795] ... bit width:              48
[    0.309890] ... generic registers:      8
[    0.313889] ... value mask:             0000ffffffffffff
[    0.319188] ... max period:             0000ffffffffffff
[    0.324494] ... fixed-purpose events:   3
[    0.328492] ... event mask:             00000007000000ff
[    0.334424] x86: Booting SMP configuration:
[    0.338609] .... node  #0, CPUs:      #1
[    0.353899] microcode: CPU1 microcode updated early to revision 0x710, date = 2013-06-17
[    0.364309] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.372389]  #2
[    0.385492] microcode: CPU2 microcode updated early to revision 0x710, date = 2013-06-17
[    0.396036]  #3
[    0.409139] microcode: CPU3 microcode updated early to revision 0x710, date = 2013-06-17
[    0.419597] x86: Booted up 1 node, 4 CPUs
[    0.423605] smpboot: Total of 4 processors activated (22345.12 BogoMIPS)
[    0.434451] devtmpfs: initialized
[    0.440819] PM: Registering ACPI NVS region [mem 0xcb750000-0xcb7dafff] (569344 bytes)
[    0.448724] PM: Registering ACPI NVS region [mem 0xcbaad000-0xcbaaefff] (8192 bytes)
[    0.456445] PM: Registering ACPI NVS region [mem 0xcbabb000-0xcbacdfff] (77824 bytes)
[    0.464255] PM: Registering ACPI NVS region [mem 0xcbb56000-0xcbb5dfff] (32768 bytes)
[    0.472070] PM: Registering ACPI NVS region [mem 0xcbb71000-0xcbffffff] (4780032 bytes)
[    0.480167] clocksource jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.489870] atomic64_test: passed for x86-64 platform with CX8 and with SSE
[    0.496823] pinctrl core: initialized pinctrl subsystem
[    0.502080] RTC time: 10:34:17, date: 04/29/15
[    0.506618] NET: Registered protocol family 16
[    0.514356] cpuidle: using governor menu
[    0.518327] ACPI: bus type PCI registered
[    0.522335] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.528833] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.538117] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    0.545204] PCI: Using configuration type 1 for base access
[    0.551103] perf_event_intel: PMU erratum BJ122, BV98, HSD29 workaround disabled, HT off
[    0.565709] ACPI: Added _OSI(Module Device)
[    0.569891] ACPI: Added _OSI(Processor Device)
[    0.574330] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.579033] ACPI: Added _OSI(Processor Aggregator Device)
[    0.591946] ACPI: Executed 1 blocks of module-level executable AML code
[    0.653410] ACPI: Interpreter enabled
[    0.657080] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_] (20150410/hwxface-580)
[    0.666313] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20150410/hwxface-580)
[    0.675552] ACPI: (supports S0 S3 S5)
[    0.679211] ACPI: Using IOAPIC for interrupt routing
[    0.684193] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.694028] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.707840] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7f])
[    0.714012] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.722276] acpi PNP0A08:00: _OSC: platform does not support [PCIeCapability]
[    0.729448] acpi PNP0A08:00: _OSC: not requesting control; platform does not support [PCIeCapability]
[    0.738644] acpi PNP0A08:00: _OSC: OS requested [PCIeHotplug PME AER PCIeCapability]
[    0.746372] acpi PNP0A08:00: _OSC: platform willing to grant [PCIeHotplug PME AER]
[    0.753929] acpi PNP0A08:00: _OSC failed (AE_SUPPORT); disabling ASPM
[    0.760634] PCI host bridge to bus 0000:00
[    0.764725] pci_bus 0000:00: root bus resource [bus 00-7f]
[    0.770203] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.776982] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.783760] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.790536] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.797305] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.804770] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
[    0.812240] pci_bus 0000:00: root bus resource [mem 0xd4000000-0xdfffffff window]
[    0.819709] pci_bus 0000:00: root bus resource [mem 0x3c0000000000-0x3c007fffffff window]
[    0.828109] pci 0000:00:01.0: System wakeup disabled by ACPI
[    0.833901] pci 0000:00:02.0: System wakeup disabled by ACPI
[    0.839684] pci 0000:00:03.0: System wakeup disabled by ACPI
[    0.846371] pci 0000:00:19.0: System wakeup disabled by ACPI
[    0.852172] pci 0000:00:1a.0: System wakeup disabled by ACPI
[    0.858072] pci 0000:00:1c.0: Disabling UPDCR peer decodes
[    0.863552] pci 0000:00:1c.0: Enabling MPC IRBNCE
[    0.868251] pci 0000:00:1c.0: Intel PCH root port ACS workaround enabled
[    0.874966] pci 0000:00:1c.0: System wakeup disabled by ACPI
[    0.880797] pci 0000:00:1c.5: Enabling MPC IRBNCE
[    0.885497] pci 0000:00:1c.5: Intel PCH root port ACS workaround enabled
[    0.892209] pci 0000:00:1c.5: System wakeup disabled by ACPI
[    0.897974] pci 0000:00:1c.6: Enabling MPC IRBNCE
[    0.902676] pci 0000:00:1c.6: Intel PCH root port ACS workaround enabled
[    0.909389] pci 0000:00:1c.6: System wakeup disabled by ACPI
[    0.915153] pci 0000:00:1c.7: Enabling MPC IRBNCE
[    0.919854] pci 0000:00:1c.7: Intel PCH root port ACS workaround enabled
[    0.926569] pci 0000:00:1c.7: System wakeup disabled by ACPI
[    0.932371] pci 0000:00:1d.0: System wakeup disabled by ACPI
[    0.938113] pci 0000:00:1e.0: System wakeup disabled by ACPI
[    0.944230] pci 0000:00:01.0: PCI bridge to [bus 03]
[    0.951223] pci 0000:00:02.0: PCI bridge to [bus 05]
[    0.956250] pci 0000:00:03.0: PCI bridge to [bus 04]
[    0.961416] pci 0000:02:00.0: VF(n) BAR0 space: [mem 0xde800000-0xde87bfff 64bit pref] (contains BAR0 for 31 VFs)
[    0.971828] pci 0000:00:11.0: PCI bridge to [bus 02]
[    0.976846] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.981876] pci 0000:00:1c.5: PCI bridge to [bus 06]
[    0.986894] pci 0000:00:1c.6: PCI bridge to [bus 07]
[    0.993882] pci 0000:00:1c.7: PCI bridge to [bus 08]
[    0.999171] pci 0000:00:1e.0: PCI bridge to [bus 09] (subtractive decode)
[    1.006408] ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 80-ff])
[    1.012581] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    1.020846] acpi PNP0A08:01: _OSC: platform does not support [PCIeCapability]
[    1.028022] acpi PNP0A08:01: _OSC: not requesting control; platform does not support [PCIeCapability]
[    1.037219] acpi PNP0A08:01: _OSC: OS requested [PCIeHotplug PME AER PCIeCapability]
[    1.044951] acpi PNP0A08:01: _OSC: platform willing to grant [PCIeHotplug PME AER]
[    1.052505] acpi PNP0A08:01: _OSC failed (AE_SUPPORT); disabling ASPM
[    1.059037] PCI host bridge to bus 0000:80
[    1.063130] pci_bus 0000:80: root bus resource [bus 80-ff]
[    1.068608] pci_bus 0000:80: root bus resource [io  0x0000-0x03af window]
[    1.075378] pci_bus 0000:80: root bus resource [io  0x03e0-0x0cf7 window]
[    1.082153] pci_bus 0000:80: root bus resource [mem 0x000c0000-0x000dffff window]
[    1.089699] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[    1.096980] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
[    1.104250] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 15)
[    1.111332] ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 10 11 12 14 15)
[    1.118415] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[    1.125686] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0
[    1.133159] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[    1.140435] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *10 11 12 14 15)
[    1.148218] ACPI: Enabled 2 GPEs in block 00 to 3F
[    1.153145] vgaarb: setting as boot device: PCI:0000:05:00.0
[    1.158796] vgaarb: device added: PCI:0000:05:00.0,decodes=io+mem,owns=io+mem,locks=none
[    1.166877] vgaarb: loaded
[    1.169583] vgaarb: bridge control possible 0000:05:00.0
[    1.174956] SCSI subsystem initialized
[    1.178772] ACPI: bus type USB registered
[    1.182798] usbcore: registered new interface driver usbfs
[    1.188284] usbcore: registered new interface driver hub
[    1.193595] usbcore: registered new device driver usb
[    1.198719] PCI: Using ACPI for IRQ routing
[    1.208769] PCI: Discovered peer bus ff
[    1.212627] ACPI: \: failed to evaluate _DSM (0x1001)
[    1.217674] PCI host bridge to bus 0000:ff
[    1.221768] pci_bus 0000:ff: root bus resource [io  0x0000-0xffff]
[    1.227934] pci_bus 0000:ff: root bus resource [mem 0x00000000-0x3fffffffffff]
[    1.235145] pci_bus 0000:ff: No busn resource found for root bus, will use [bus ff-ff]
[    1.245206] NetLabel: Initializing
[    1.248601] NetLabel:  domain hash size = 128
[    1.252957] NetLabel:  protocols = UNLABELED CIPSOv4
[    1.257928] NetLabel:  unlabeled traffic allowed by default
[    1.263548] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    1.269881] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    1.277734] Switched to clocksource hpet
[    1.287587] pnp: PnP ACPI init
[    1.290758] system 00:00: [mem 0xfc000000-0xfcffffff window] has been reserved
[    1.297976] system 00:00: [mem 0xfd000000-0xfdffffff window] has been reserved
[    1.305187] system 00:00: [mem 0xfe000000-0xfeafffff window] has been reserved
[    1.312400] system 00:00: [mem 0xfeb00000-0xfebfffff window] has been reserved
[    1.319613] system 00:00: [mem 0xfed00400-0xfed3ffff window] could not be reserved
[    1.327176] system 00:00: [mem 0xfed45000-0xfedfffff window] has been reserved
[    1.334387] system 00:00: [mem 0xdffff000-0xdfffffff window] has been reserved
[    1.341718] system 00:01: [io  0x0620-0x063f] has been reserved
[    1.347635] system 00:01: [io  0x0610-0x061f] has been reserved
[    1.353717] system 00:05: [io  0x04d0-0x04d1] has been reserved
[    1.359941] system 00:07: [io  0x0400-0x0453] could not be reserved
[    1.366198] system 00:07: [io  0x0458-0x047f] has been reserved
[    1.372108] system 00:07: [io  0x1180-0x119f] has been reserved
[    1.378023] system 00:07: [io  0x0500-0x057f] has been reserved
[    1.383934] system 00:07: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    1.390542] system 00:07: [mem 0xfec00000-0xfecfffff] could not be reserved
[    1.397494] system 00:07: [mem 0xfed08000-0xfed08fff] has been reserved
[    1.404099] system 00:07: [mem 0xff000000-0xffffffff] has been reserved
[    1.410766] system 00:08: [io  0x0454-0x0457] has been reserved
[    1.416981] system 00:09: [mem 0xfed40000-0xfed44fff] has been reserved
[    1.423593] pnp: PnP ACPI: found 10 devices
[    1.433918] clocksource acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    1.442755] pci 0000:00:01.0: PCI bridge to [bus 03]
[    1.447723] pci 0000:00:02.0: PCI bridge to [bus 05]
[    1.452686] pci 0000:00:02.0:   bridge window [io  0xd000-0xdfff]
[    1.458774] pci 0000:00:02.0:   bridge window [mem 0xd6000000-0xd70fffff]
[    1.465556] pci 0000:00:02.0:   bridge window [mem 0xd8000000-0xddffffff 64bit pref]
[    1.473284] pci 0000:00:03.0: PCI bridge to [bus 04]
[    1.478249] pci 0000:00:11.0: PCI bridge to [bus 02]
[    1.483211] pci 0000:00:11.0:   bridge window [io  0xe000-0xefff]
[    1.489300] pci 0000:00:11.0:   bridge window [mem 0xde400000-0xde8fffff 64bit pref]
[    1.497031] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    1.501993] pci 0000:00:1c.5: PCI bridge to [bus 06]
[    1.506969] pci 0000:00:1c.6: PCI bridge to [bus 07]
[    1.511939] pci 0000:00:1c.7: PCI bridge to [bus 08]
[    1.516901] pci 0000:00:1c.7:   bridge window [mem 0xd7200000-0xd72fffff]
[    1.523681] pci 0000:00:1e.0: PCI bridge to [bus 09]
[    1.528636] pci 0000:00:1e.0:   bridge window [io  0xc000-0xcfff]
[    1.534723] pci 0000:00:1e.0:   bridge window [mem 0xd7100000-0xd71fffff]
[    1.541579] NET: Registered protocol family 2
[    1.546151] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[    1.553757] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    1.560610] TCP: Hash tables configured (established 131072 bind 65536)
[    1.567270] UDP hash table entries: 8192 (order: 6, 262144 bytes)
[    1.573418] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes)
[    1.580031] NET: Registered protocol family 1
[    1.626445] Unpacking initramfs...
[    1.887979] Freeing initrd memory: 19128K (ffff880035a94000 - ffff880036d42000)
[    1.895511] IOMMU: dmar0 using Queued invalidation
[    1.900297] IOMMU: Setting RMRR:
[    1.903531] IOMMU: Setting identity map for device 0000:00:1a.0 [0xcba11000 - 0xcba27fff]
[    1.911725] IOMMU: Setting identity map for device 0000:00:1d.0 [0xcba11000 - 0xcba27fff]
[    1.919910] IOMMU: Prepare 0-16MiB unity mapping for LPC
[    1.925226] IOMMU: Setting identity map for device 0000:00:1f.0 [0x0 - 0xffffff]
[    1.932629] PCI-DMA: Intel(R) Virtualization Technology for Directed I/O
[    1.942707] RAPL PMU detected, API unit is 2^-32 Joules, 3 fixed counters 163840 ms ovfl timer
[    1.951314] hw unit of domain pp0-core 2^-16 Joules
[    1.956194] hw unit of domain package 2^-16 Joules
[    1.960978] hw unit of domain dram 2^-16 Joules
[    1.965679] microcode: CPU0 sig=0x206d7, pf=0x1, revision=0x710
[    1.971591] microcode: CPU1 sig=0x206d7, pf=0x1, revision=0x710
[    1.977502] microcode: CPU2 sig=0x206d7, pf=0x1, revision=0x710
[    1.983425] microcode: CPU3 sig=0x206d7, pf=0x1, revision=0x710
[    1.989388] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    1.998474] AVX version of gcm_enc/dec engaged.
[    2.003005] AES CTR mode by8 optimization enabled
[    2.009550] alg: No test for __gcm-aes-aesni (__driver-gcm-aes-aesni)
[    2.016307] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    2.022499] Initialise system trusted keyring
[    2.026870] audit: initializing netlink subsys (disabled)
[    2.032278] audit: type=2000 audit(1430303656.169:1): initialized
[    2.038867] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    2.046515] zpool: loaded
[    2.049285] VFS: Disk quotas dquot_6.6.0
[    2.053243] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    2.060466] Key type big_key registered
[    2.065040] alg: No test for stdrng (krng)
[    2.069144] NET: Registered protocol family 38
[    2.073586] Key type asymmetric registered
[    2.077680] Asymmetric key parser 'x509' registered
[    2.082581] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    2.089993] io scheduler noop registered
[    2.093918] io scheduler deadline registered
[    2.098211] io scheduler cfq registered (default)
[    2.103818] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    2.109401] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    2.116240] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    2.124584] ACPI: Power Button [PWRB]
[    2.128278] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    2.135664] ACPI: Power Button [PWRF]
[    2.143175] GHES: HEST is not enabled!
[    2.147065] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    2.173918] 00:06: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    2.202294] 0000:00:16.3: ttyS1 at I/O 0xf060 (irq = 17, base_baud = 115200) is a 16550A
[    2.210750] Non-volatile memory driver v1.3
[    2.214994] Linux agpgart interface v0.103
[    2.229807] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x5 impl RAID mode
[    2.237885] ahci 0000:00:1f.2: flags: 64bit ncq sntf led clo pio ems sxs apst 
[    2.247409] scsi host0: ahci
[    2.250578] scsi host1: ahci
[    2.253769] scsi host2: ahci
[    2.256909] scsi host3: ahci
[    2.260007] scsi host4: ahci
[    2.263068] scsi host5: ahci
[    2.265988] ata1: SATA max UDMA/133 abar m2048@0xd7348000 port 0xd7348100 irq 27
[    2.273370] ata2: DUMMY
[    2.275822] ata3: SATA max UDMA/133 abar m2048@0xd7348000 port 0xd7348200 irq 27
[    2.283208] ata4: DUMMY
[    2.285659] ata5: DUMMY
[    2.288108] ata6: DUMMY
[    2.290661] libphy: Fixed MDIO Bus: probed
[    2.294879] xhci_hcd 0000:08:00.0: xHCI Host Controller
[    2.300205] xhci_hcd 0000:08:00.0: new USB bus registered, assigned bus number 1
[    2.307794] xhci_hcd 0000:08:00.0: hcc params 0x0270f06d hci version 0x96 quirks 0x00004000
[    2.316287] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    2.323070] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.330283] usb usb1: Product: xHCI Host Controller
[    2.335157] usb usb1: Manufacturer: Linux 4.0.0+ xhci-hcd
[    2.340550] usb usb1: SerialNumber: 0000:08:00.0
[    2.345294] hub 1-0:1.0: USB hub found
[    2.349056] hub 1-0:1.0: 4 ports detected
[    2.353176] xhci_hcd 0000:08:00.0: xHCI Host Controller
[    2.358470] xhci_hcd 0000:08:00.0: new USB bus registered, assigned bus number 2
[    2.365883] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[    2.372656] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.379866] usb usb2: Product: xHCI Host Controller
[    2.384739] usb usb2: Manufacturer: Linux 4.0.0+ xhci-hcd
[    2.390134] usb usb2: SerialNumber: 0000:08:00.0
[    2.394865] hub 2-0:1.0: USB hub found
[    2.398622] hub 2-0:1.0: 4 ports detected
[    2.402745] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.409275] ehci-pci: EHCI PCI platform driver
[    2.413809] ehci-pci 0000:00:1a.0: EHCI Host Controller
[    2.419099] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 3
[    2.426495] ehci-pci 0000:00:1a.0: debug port 2
[    2.434950] ehci-pci 0000:00:1a.0: irq 16, io mem 0xd734b000
[    2.446032] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    2.451794] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[    2.458579] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.465792] usb usb3: Product: EHCI Host Controller
[    2.470664] usb usb3: Manufacturer: Linux 4.0.0+ ehci_hcd
[    2.476057] usb usb3: SerialNumber: 0000:00:1a.0
[    2.480868] hub 3-0:1.0: USB hub found
[    2.484628] hub 3-0:1.0: 3 ports detected
[    2.488835] ehci-pci 0000:00:1d.0: EHCI Host Controller
[    2.494111] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 4
[    2.501509] ehci-pci 0000:00:1d.0: debug port 2
[    2.509949] ehci-pci 0000:00:1d.0: irq 23, io mem 0xd734a000
[    2.521185] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    2.526967] usb usb4: New USB device found, idVendor=1d6b, idProduct=0002
[    2.533749] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.540958] usb usb4: Product: EHCI Host Controller
[    2.545834] usb usb4: Manufacturer: Linux 4.0.0+ ehci_hcd
[    2.551227] usb usb4: SerialNumber: 0000:00:1d.0
[    2.556004] hub 4-0:1.0: USB hub found
[    2.559763] hub 4-0:1.0: 3 ports detected
[    2.563883] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.570066] ohci-pci: OHCI PCI platform driver
[    2.574521] uhci_hcd: USB Universal Host Controller Interface driver
[    2.580917] usbcore: registered new interface driver usbserial
[    2.586750] usbcore: registered new interface driver usbserial_generic
[    2.593298] usbserial: USB Serial support registered for generic
[    2.596225] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.597227] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.598407] ata3.00: ATAPI: hp       CDDVDW SH-216ALN, HA5A, max UDMA/100
[    2.600244] ata1.00: ATA-8: WDC WD10EALX-609BA0, 18.01H18, max UDMA/100
[    2.600245] ata1.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    2.600869] ata3.00: configured for UDMA/100
[    2.603086] ata1.00: configured for UDMA/100
[    2.603260] scsi 0:0:0:0: Direct-Access     ATA      WDC WD10EALX-609 1H18 PQ: 0 ANSI: 5
[    2.603553] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    2.603613] sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 TB/931 GiB)
[    2.603866] sd 0:0:0:0: [sda] Write Protect is off
[    2.603965] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.604160] scsi 2:0:0:0: CD-ROM            hp       CDDVDW SH-216ALN HA5A PQ: 0 ANSI: 5
[    2.623012]  sda: sda1 sda2
[    2.623636] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.634993] sr 2:0:0:0: [sr0] scsi3-mmc drive: 40x/40x writer dvd-ram cd/rw xa/form2 cdda tray
[    2.634994] cdrom: Uniform CD-ROM driver Revision: 3.20
[    2.635253] sr 2:0:0:0: Attached scsi generic sg1 type 5
[    2.710337] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
[    2.721112] serio: i8042 KBD port at 0x60,0x64 irq 1
[    2.726074] serio: i8042 AUX port at 0x60,0x64 irq 12
[    2.731370] mousedev: PS/2 mouse device common for all mice
[    2.737362] rtc_cmos 00:04: RTC can wake from S4
[    2.742165] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
[    2.748293] rtc_cmos 00:04: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    2.755984] device-mapper: uevent: version 1.0.3
[    2.761146] device-mapper: ioctl: 4.31.0-ioctl (2015-3-12) initialised: dm-devel@redhat.com
[    2.769585] Intel P-state driver initializing.
[    2.775764] hidraw: raw HID events driver (C) Jiri Kosina
[    2.781403] usbcore: registered new interface driver usbhid
[    2.786981] usbhid: USB HID core driver
[    2.790972] drop_monitor: Initializing network drop monitor service
[    2.797385] ip_tables: (C) 2000-2006 Netfilter Core Team
[    2.802812] Initializing XFRM netlink socket
[    2.807301] NET: Registered protocol family 10
[    2.812085] mip6: Mobile IPv6
[    2.812474] usb 3-1: new high-speed USB device number 2 using ehci-pci
[    2.821600] NET: Registered protocol family 17
[    2.827295] Loading compiled-in X.509 certificates
[    2.833667] Loaded X.509 cert 'Magrathea: Glacier signing key: 8d99b9f6f028e78c7dfe07caad5fd2ff7cee9c74'
[    2.843170] registered taskstats version 1
[    2.848104]   Magic number: 11:256:579
[    2.851892] pci_bus 0000:00: hash matches
[    2.856043] rtc_cmos 00:04: setting system clock to 2015-04-29 10:34:19 UTC (1430303659)
[    2.864887] Freeing unused kernel memory: 1500K (ffffffff81d41000 - ffffffff81eb8000)
[    2.872721] Write protecting the kernel read-only data: 12288k
[    2.879017] Freeing unused kernel memory: 464K (ffff88000178c000 - ffff880001800000)
[    2.887086] Freeing unused kernel memory: 836K (ffff880001b2f000 - ffff880001c00000)
[    2.897887] random: systemd urandom read with 13 bits of entropy available
[    2.906032] systemd[1]: systemd 217 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -L)
[    2.924138] usb 4-1: new high-speed USB device number 2 using ehci-pci
[    2.930912] systemd[1]: Detected architecture 'x86-64'.
[    2.936158] systemd[1]: Running in initial RAM disk.

Welcome to Fedora 21 (T[    2.943202] usb 3-1: New USB device found, idVendor=8087, idProduct=0024
[    2.950774] usb 3-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
wenty One) dracu[    2.958357] hub 3-1:1.0: USB hub found
t-038-30.git2014[    2.963313] hub 3-1:1.0: 6 ports detected
[    2.967652] tsc: Refined TSC clocksource calibration: 2793.266 MHz
[    2.967655] clocksource tsc: mask: 0xffffffffffffffff max_cycles: 0x2843679379e, max_idle_ns: 440795332872 ns
0903.fc21 (Initramfs)!

[    2.987898] systemd[1]: Set hostname to <dhcp-128-28.nay.redhat.com>.
[    3.039247] systemd[1]: Expecting device dev-mapper-fedora_dhcp\x2d\x2d128\x2d\x2d28\x2dswap.device...
[    3.048280] usb 4-1: New USB device found, idVendor=8087, idProduct=0024
[    3.048282] usb 4-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.048702] hub 4-1:1.0: USB hub found
[    3.048882] hub 4-1:1.0: 8 ports detected
         Expecting device dev-mapper-fedora_...d128\x2d\x2d28\x2dswap.device...
[    3.078842] systemd[1]: Expecting device dev-disk-by\x2duuid-689a8845\x2d7f32\x2d4fd7\x2d87fc\x2d615276a16f2f.device...
         Expecting device dev-disk-by\x2duui...2d87fc\x2d615276a16f2f.device...
[    3.098910] systemd[1]: Expecting device dev-mapper-fedora_dhcp\x2d\x2d128\x2d\x2d28\x2droot.device...
         Expecting device dev-mapper-fedora_...d128\x2d\x2d28\x2droot.device...
[    3.116925] systemd[1]: Starting Timers.
[  OK  ] Reached target Timers.
[    3.125921] systemd[1]: Reached target Timers.
[    3.130411] systemd[1]: Starting -.slice.
[  OK  ] Created slice -.slice.
[    3.148930] systemd[1]: Created slice -.slice.
[    3.153422] systemd[1]: Starting udev Control Socket.
[  OK  ] Listening on udev Control Socket.
[    3.163917] systemd[1]: Listening on udev Control Socket.
[    3.169345] systemd[1]: Starting udev Kernel Socket.
[  OK  ] Listening on udev Kernel Socket.
[    3.179934] systemd[1]: Listening on udev Kernel Socket.
[    3.185270] systemd[1]: Starting Journal Socket.
[  OK  ] Listening on Journal Socket.
[    3.194965] systemd[1]: Listening on Journal Socket.
[    3.199950] systemd[1]: Starting System Slice.
[  OK  ] Created slice System Slice.
[    3.208978] systemd[1]: Created slice System Slice.
[    3.213930] systemd[1]: Started dracut ask for additional cmdline parameters.
[    3.221180] systemd[1]: Starting dracut cmdline hook...
         Starting dracut cmdline hook...
[    3.231387] systemd[1]: Starting system-systemd\x2dfsck.slice.
[  OK  ] Created slice system-systemd\x2dfsck.slice.
[    3.245004] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[    3.251364] systemd[1]: Starting Create list of required static device nodes for the current kernel...
         Starting Create list of required st... nodes for the current kernel...
[    3.269339] systemd[1]: Starting Journal Socket (/dev/log).
[    3.275206] systemd[1]: Starting Slices.
[  OK  ] Reached target Slices.
[    3.284011] systemd[1]: Reached target Slices.
[    3.288485] systemd[1]: Starting Setup Virtual Console...
         Starting Setup Virtual Console...
[    3.298419] systemd[1]: Started Load Kernel Modules.
[    3.303414] systemd[1]: Starting Apply Kernel Variables...
         Starting Apply Kernel Variables...
[    3.315354] systemd[1]: Starting Swap.
[  OK  ] Reached target Swap.
[    3.324044] systemd[1]: Reached target Swap.
[    3.328329] systemd[1]: Starting Local File Systems.
[  OK  ] Reached target Local File Systems.
[    3.339064] systemd[1]: Reached target Local File Systems.
[    3.344561] usb 4-1.1: new high-speed USB device number 3 using ehci-pci
[  OK  ] Started dracut cmdline hook.
[    3.356081] systemd[1]: Started dracut cmdline hook.
[  OK  ] Started Create list of required sta...ce nodes for the current kernel.
[    3.370129] systemd[1]: Started Create list of required static device nodes for the current kernel.
[  OK  ] Listening on Journal Socket (/dev/log).
[    3.385175] systemd[1]: Listening on Journal Socket (/dev/log).
[  OK  ] Started Setup Virtual Console.
[    3.397192] systemd[1]: Started Setup Virtual Console.
[  OK  ] Started Apply Kernel Variables.
[    3.408204] systemd[1]: Started Apply Kernel Variables.
[    3.418680] systemd[1]: Starting Sockets.
[  OK  ] Reached target Sockets.
[    3.427222] systemd[1]: Reached target Sockets.
[    3.431772] systemd[1]: Starting Journal Service...
         Starting Journal Service...
[    3.441626] systemd[1]: Starting Create Static Device Nodes in /dev...
         Startin[    3.448533] usb 4-1.1: New USB device found, idVendor=0424, idProduct=2412
[    3.456515] usb 4-1.1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.458510] systemd-journald[257]: File /var/log/journal/95212bce02f14a269471981f705ca21f/system.journal corrupted or uncleanly shut down, renaming and replacing.
g Create Static [    3.478590] hub 4-1.1:1.0: USB hub found
Device Nodes in [    3.483699] hub 4-1.1:1.0: 2 ports detected
/dev...
[    3.491723] systemd[1]: Starting dracut pre-udev hook...
         Starting dracut pre-udev hook...
[  OK  ] Started Journal Service.
[    3.506253] systemd[1]: Started Journal Service.
[  OK  ] Started Create Static Device Nodes in /dev.
[  OK  ] Started dracut pre-udev hook.
         Starting udev Kernel Device Manager...
[  OK  ] Started udev Kernel Device Manager.
         Starting udev Coldplug all Devices...
         Mounting Configuration File System...
[  OK  ] Mounted Configuration File System.
[  OK  [    3.575972] wmi: Mapper loaded
] Started udev Coldplug all Devi[    3.580956] [drm] Initialized drm 1.1.0 20060810
ces.
[    3.586654] pps_core: LinuxPPS API ver. 1 registered
[    3.592057] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
         Startin[    3.607042] tulip: Linux Tulip driver version 1.1.15 (Feb 27, 2007)
g dracut initque[    3.614038] isci: Intel(R) C600 SAS Controller Driver - version 1.2.0
[    3.614443] tulip: tulip_init_one: Enabled WOL support for AN983B
[    3.615168] tulip0:  MII transceiver #1 config 1000 status 786d advertising 05e1
ue hook...
[    3.622693] net eth0: ADMtek Comet rev 17 at MMIO 0xd7121000, 00:b0:c0:06:70:90, IRQ 20
[    3.643999] isci 0000:02:00.0: driver configured for rev: 5 silicon
[    3.650290] scsi host6: ata_generic
[    3.650292] isci 0000:02:00.0: OEM SAS parameters (version: 1.3) loaded (firmware)
[    3.650828] isci 0000:02:00.0: SCU controller 0: phy 3-0 cables: {short, short, short, short}
[    3.653193] scsi host7: isci
[    3.662347] tulip 0000:09:04.0 enp9s4: renamed from eth0
[    3.678271] PTP clock support registered
[    3.682501] scsi host8: ata_genic
         Startin[    3.686051] ata7: PATA max UDMA/100 cmd 0xf0b0 ctl 0xf0a0 bmdma 0xf070 irq 18
g Show Plymouth [    3.694460] ata8: PATA max UDMA/100 cmd 0xf090 ctl 0xf080 bmdma 0xf078 irq 18
Boot Screen...
[    3.694501] e1000e: Intel(R) PRO/1000 Network Driver - 2.3.2-k
[    3.694501] e1000e: Copyright(c) 1999 - 2014 Intel Corporation.
[    3.716340] e1000e 0000:00:19.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    3.716542] nouveau  [  DEVICE][0000:05:00.0] BOOT0  : 0x0a8c00b1
[    3.716543] nouveau  [  DEVICE][0000:05:00.0] Chipset: GT218 (NVA8)
[    3.716544] nouveau  [  DEVICE][0000:05:00.0] Family : NV50
[    3.736505] firewire_ohci 0000:09:05.0: added OHCI v1.0 device as card 0, 8 IR + 8 IT contexts, quirks 0x0
[  OK  ] Reached target System Initialization.
[    3.794638] usb 4-1.1.1: new low-speed USB device number 4 using ehci-pci
[    3.830599] nouveau  [   VBIOS][0000:05:00.0] using image from PRAMIN
[    3.837113] nouveau  [   VBIOS][0000:05:00.0] BIT signature found
[    3.843203] nouveau  [   VBIOS][0000:05:00.0] version 70.18.89.00.02
[    3.849872] nouveau  [     PMC][0000:05:00.0] MSI interrupts enabled
[    3.856246] nouveau  [     PFB][0000:05:00.0] RAM type: DDR3
[    3.861900] nouveau  [     PFB][0000:05:00.0] RAM size: 512 MiB
[    3.867815] nouveau  [     PFB][0000:05:00.0]    ZCOMP: 960 tags
[    3.875570] nouveau  [    VOLT][0000:05:00.0] GPU voltage: 900000uv
[    3.897662] usb 4-1.1.1: New USB device found, idVendor=03f0, idProduct=0324
[    3.904706] usb 4-1.1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.909468] nouveau  [  PTHERM][0000:05:00.0] FAN control: none / external
[    3.909475] nouveau  [  PTHERM][0000:05:00.0] fan management: automatic
[    3.909478] nouveau  [  PTHERM][0000:05:00.0] internal sensor: yes
[    3.929522] nouveau  [     CLK][0000:05:00.0] 03: core 135 MHz shader 270 MHz memory 135 MHz
[    3.929524] nouveau  [     CLK][0000:05:00.0] 07: core 405 MHz shader 810 MHz memory 405 MHz
[    3.929526] nouveau  [     CLK][0000:05:00.0] 0f: core 520 MHz shader 1230 MHz memory 790 MHz
[    3.929544] nouveau  [     CLK][0000:05:00.0] --: core 405 MHz shader 810 MHz memory 405 MHz
[    3.929700] [TTM] Zone  kernel: Available graphics memory: 8081626 kiB
[    3.929700] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[    3.929701] [TTM] Initializing pool allocator
[    3.929705] [TTM] Initializing DMA pool allocator
[    3.929713] nouveau  [     DRM] VRAM: 512 MiB
[    3.929714] nouveau  [     DRM] GART: 1048576 MiB
[    3.929717] nouveau  [     DRM] TMDS table version 2.0
[    3.929719] nouveau  [     DRM] DCB version 4.0
[    3.929720] nouveau  [     DRM] DCB outp 00: 02000360 00000000
[    3.929721] nouveau  [     DRM] DCB outp 01: 02000362 00020010
[    3.929722] nouveau  [     DRM] DCB outp 02: 028003a6 0f220010
[    3.929723] nouveau  [     DRM] DCB outp 03: 01011380 00000000
[    3.929724] nouveau  [     DRM] DCB outp 04: 08011382 00020010
[    3.929724] nouveau  [     DRM] DCB outp 05: 088113c6 0f220010
[    3.929726] nouveau  [     DRM] DCB conn 00: 00101064
[    3.929727] nouveau  [     DRM] DCB conn 01: 00202165
[    3.950057] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    3.950057] [drm] Driver supports precise vblank timestamp query.
[    3.951504] e1000e 0000:00:19.0 eth0: registered PHC clock
[    3.951505] e1000e 0000:00:19.0 eth0: (PCI Express:2.5GT/s:Width x1) 80:c1:6e:f8:9f:92
[    3.951506] e1000e 0000:00:19.0 eth0: Intel(R) PRO/1000 Network Connection
[    3.951541] e1000e 0000:00:19.0 eth0: MAC: 10, PHY: 11, PBA No: 0100FF-0FF
[    3.966252] e1000e 0000:00:19.0 eno1: renamed from eth0
[    4.096467] usb 4-1.1.1: Product: HP Basic USB Keyboard
[    4.101686] usb 4-1.1.1: Manufacturer: Lite-On Technology Corp.
[    4.107605] Switched to clocksource tsc
[    4.110127] nouveau  [     DRM] MM: using COPY for buffer copies
[    4.120618] input: Lite-On Technology Corp. HP Basic USB Keyboard as /devices/pci0000:00/0000:00:1d.0/usb4/4-1/4-1.1/4-1.1.1/4-1.1.1:1.0/0003:03F0:0324.0001/input5
[    4.183452] nouveau  [     DRM] allocated 1920x1080 fb: 0x70000, bo ffff88041952d000
[    4.186159] hid-generic 0003:03F0:0324.0001: input,hidraw0: USB HID v1.10 Keyboard [Lite-On Technology Corp. HP Basic USB Keyboard] on usb-0000:00:1d.0-1.1.1/inpu0
[    4.205922] fbcon: nouveaufb (fb0) is primary device
[    4.245078] firewire_core 0000:09:05.0: created device fw0: GUID 0060b000008cec98, S400
[    4.270044] usb 4-1.1.2: new low-speed USB device number 5 using ehci-pci
[    4.327492] Console: switching to colour frame buffer device 240x67
[    4.356643] nouveau 0000:05:00.0: fb0: nouveaufb frame buffer device
[    4.362986] nouveau 0000:05:00.0: registered panic notifier
[    4.365191] usb 4-1.1.2: New USB device found, idVendor=03f0, idProduct=0b4a
[    4.365192] usb 4-1.1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.365193] usb 4-1.1.2: Product: USB Optical Mouse
[    4.365194] usb 4-1.1.2: Manufacturer: Logitech
[    4.367354] input: Logitech USB Optical Mouse as /devices/pci0000:00/0000:00:1d.0/usb4/4-1/4-1.1/4-1.1.2/4-1.1.2:1.0/0003:03F0:0B4A.0002/input/input6
[    4.367615] hid-generic 0003:03F0:0B4A.0002: input,hidraw1: USB HID v1.11 Mouse [Logitech USB Optical Mouse] on usb-0000:00:1d.0-1.1.2/input0
[    4.425278] [drm] Initialized nouveau 1.2.2 20120801 for 0000:05:00.0 on minor 0
[  OK  ] Found device WDC_WD10EALX-609BA0 1.
[  OK  ] Started Show Plymouth Boot Screen.
[  OK  ] Reached target Paths.
[  OK  ] Reached target Basic System.
[  OK  ] Found device /dev/mapper/fedora_dhcp--128--28-root.
         Starting File System Check on /dev/mapper/fedora_dhcp--128--28-root...
[    4.664397] random: nonblocking pool is initialized
[    3.824740] systemd-fsck[412]: /dev/mapper/fedora_dhcp--128--28-root: clean, 162320/19660800 files, 9596705/78643200 blocks
[  OK  ] Started File System Check on /dev/mapper/fedora_dhcp--128--28-root.
[  OK  ] Found device /dev/mapper/fedora_dhcp--128--28-swap.
[  OK  ] Started dracut initqueue hook.
         Starting dracut pre-mount hook...
[  OK  ] Reached target Remote File Systems (Pre).
[  OK  ] Reached target Remote File Systems.
[    4.014014] dracut-pre-mount[436]: //lib/dracut/hooks/pre-mount/10-resume.sh: line 22: /sys/power/resume: Permission denied
[  OK  ] Started dracut pre-mount hook.
         Mounting /sys[    4.899848] EXT4-fs (dm-0): mounted filesystem with ordered data mode. Opts: (null)
root...
[  OK  ] Mounted /sysroot.
[  OK  ] Reached target Initrd Root File System.
         Starting Reload Configuration from the Real Root...
[  OK  ] Started Reload Configuration from the Real Root.
[  OK  ] Reached target Initrd File Systems.
[  OK  ] Reached target Initrd Default Target.
         Starting dracut pre-pivot and cleanup hook...
[  OK  ] Started dracut pre-pivot and cleanup hook.
         Starting Cleaning Up and Shutting Down Daemons...
         Stopping Cleaning Up and Shutting Down Daemons...
[  OK  ] Stopped target Timers.
         Starting Plymouth switch root service...
[  OK  ] Stopped Cleaning Up and Shutting Down Daemons.
         Stopping dracut pre-pivot and cleanup hook...
[  OK  ] Stopped dracut pre-pivot and cleanup hook.
[  OK  ] Stopped target Remote File Systems.
[  OK  ] Stopped target Remote File Systems (Pre).
         Stopping dracut pre-mount hook...
[  OK  ] Stopped dracut pre-mount hook.
         Stopping dracut initqueue hook...
[  OK  ] Stopped dracut initqueue hook.
[  OK  ] Stopped target Initrd Default Target.
[  OK  ] Stopped target Basic System.
[  OK  ] Stopped target Slices.
[  OK  ][    5.252051] systemd-journald[257]: Received SIGTERM from PID 1 (systemd).
 Stopped target Paths.
[  OK  ] Stopped target Sockets.
[  OK  ] Stopped target System Initialization.
         Stopping udev Coldplug all Devices...
[  OK  ] Stopped udev Coldplug all Devices.
         Stopping Apply Kernel Variables...
[  OK  ] Stopped Apply Kernel Variables.
[  OK  ] Stopped target Swap.
[  OK  ] Stopped target Local File Systems.
         Stopping udev Kernel Device Manager...
[  OK  ] Stopped udev Kernel Device Manager.
         Stopping dracut pre-udev hook...
[  OK  ] Stopped dracut pre-udev hook.
         Stopping dracut cmdline hook...
[  OK  ] Stopped dracut cmdline hook.
         Stopping Create Static Device Nodes in /dev...
[  OK  ] Stopped Create Static Device Nodes in /dev.
         Stopping Create list of required st... nodes for the current kernel...
[  OK  ] Stopped Create list of required sta...ce nodes for the current kernel.
[  OK  ] Closed udev Control Socket.
[  OK  ] Closed udev Kernel Socket.
         Starting Cleanup udevd DB...
[  OK  ] Started Cleanup udevd DB.
[  OK  ] Reached target Switch Root.
[  OK  ] Started Plymouth switch root service.
         Starting Switch Root...
[    5.717985] audit: type=1404 audit(1430303662.358:2): enforcing=1 old_enforcing=0 auid=4294967295 ses=4294967295
[    5.850166] SELinux:  Permission audit_read in class capability2 not defined in policy.
[    5.858159] SELinux:  Class binder not defined in policy.
[    5.863553] SELinux: the above unknown classes and permissions will be allowed
[    5.877470] audit: type=1403 audit(1430303662.517:3): policy loaded auid=4294967295 ses=4294967295
[    5.891730] systemd[1]: Successfully loaded SELinux policy in 198.682ms.
[    5.957807] systemd[1]: Relabelled /dev and /run in 20.878ms.

Welcome to Fedora 21 (Twenty One)!

[  OK  ] Stopped Switch Root.
[  OK  ] Stopped target Switch Root.
[  OK  ] Stopped target Initrd File Systems.
         Stopping File System Check on /dev/mapper/fedora_dhcp--128--28-root...
[  OK  ] Stopped File System Check on /dev/mapper/fedora_dhcp--128--28-root.
[  OK  ] Stopped target Initrd Root File System.
[  OK  ] Reached target User and Group Name Lookups.
         Starting Collect Read-Ahead Data...
         Starting Replay Read-Ahead Data...
[  OK  ] Created slice system-serial\x2dgetty.slice.
         Expecting device dev-ttyS0.device...
[  OK  ] Created slice system-getty.slice.
[  OK  ] Created slice User and Session Slice.
[  OK  ] Reached target Slices.
[  OK  ] Listening on Delayed Shutdown Socket.
[  OK  ] Listening on /dev/initctl Compatibility Named Pipe.
         Mounting Huge Pages File System...
         Starting Create list of required st... nodes for the current kernel...
         Mounting POSIX Message Queue File System...
[  OK  ] Stopped Flush Journal to Persistent Storage.
         Stopping Journal Service...
[  OK  ] Stopped Journal Service.
         Starting Journal Service...
         Mounting Debug File System...
[  OK  ] Set up automount Arbitrary Executab...ats File System Automount Point.
[  OK  ] Listening on udev Kernel Socket.
[  OK  ] Listening on udev Control Socket.
         Starting udev Coldplug all Devices...
[  OK  ] Listening on Device-mapper event daemon FIFOs.
[  OK  ] Listening on LVM2 metadata daemon socket.
         Starting Monitoring of LVM2 mirrors... dmeventd or progress polling...
         Expecting device dev-mapper-fedora_...d128\x2d\x2d28\x2dswap.device...
         Mounting Temporary Directory...
         Expecting device dev-disk-by\x2duui...2d87fc\x2d615276a16f2f.device...
         Expecting device dev-mapper-fedora_...d128\x2d\x2d28\x2dhome.device...
[  OK  ] Started Collect Read-Ahead Data.
[  OK  ] Started Create list of required sta...ce nodes for the current kernel.
[  OK  ] Started udev Coldplug all Devices.
         Starting udev Wait for Complete Device Initialization...
[  OK  ] Started Replay Read-Ahead Data.
         Starting File System Check on Root Device...
         Starting Load legacy module configuration...
         Starting Apply Kernel Variables...
         Starting Set Up Additional Binary Formats...
[  OK  ] Mounted Huge Pages File System.
[  OK  ] Mounted POSIX Message Queue File System.
[  OK  ] Mounted Debug File System.
[  OK  ] Mounted Temporary Directory.
[  OK  ] Started Load legacy module configuration.
[  OK  ] Started Apply Kernel Variables.
         Mounting Arbitrary Executable File Formats File System...
         Starting LVM2 metadata daemon...
[  OK  ] Started LVM2 metadata daemon.
[  OK  ] Started Journal Service.
[    6.898898] systemd-fsck[535]: /dev/mapper/fedora_dhcp--128--28-root: clean, 162320/19660800 files, 9596705/78643200 blocks
[  OK  ] Started File System Check on Root Device.
         Starting Remount Root and Kernel File Systems...
[  OK  ] Mounted Arbitrary Executable File Formats File System.
[  OK  ] Started Set Up Additional Binary Formats.
[    8.134046] EXT4-fs (dm-0): re-mounted. Opts: (null)
[  OK  ] Started Remount Root and Kernel File Systems.
         Starting Configure read-only root support...
         Starting Import network configuration from initramfs...
         Starting Load/Save Random Seed...
         Starting Flush Journal to Persistent Storage...
         Starting Create Static Device Nodes in /dev...
[  OK  ] Started Load/Save Random Seed.
[    8.364638] systemd-journald[526]: Received request to flush runtime journal from PID 1
[  OK  ] Started Create Static Device Nodes in /dev.
         Starting udev Kernel Device Manager...
[  OK  ] Reached target Local File Systems (Pre).
[  OK  ] Started Configure read-only root support.
[  OK  ] Started Monitoring of LVM2 mirrors,...ng dmeventd or progress polling.
[  OK  ] Started Import network configuration from initramfs.
[  OK  ] Started udev Kernel Device Manager.
[  OK  ] Started udev Wait for Complete Device Initialization.
         Starting Activation of DM RAID sets...
[   10.723147] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   11.122184] WARNING! power/level is deprecated; use power/control instead
[   11.209078] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[   11.255241] EDAC MC: Ver: 3.0.0
[  OK  ] Found device /dev/ttyS0.
[   11.381455] EDAC MC0: Giving out device to module sbridge_edac.c controller Sandy Bridge Socket#0: DEV 0000:ff:0e.0 (POLLED)
[   11.392668] EDAC sbridge:  Ver: 1.1.0 
[   11.567379] input: PC Speaker as /devices/platform/pcspkr/input/input7
[   11.832043] iTCO_vendor_support: vendor-support=0
[   11.883099] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[   11.888740] iTCO_wdt: unable to reset NO_REBOOT flag, device disabled by hardware/BIOS
[  OK  ] Started Flush Journal to Persistent Storage.
G[   12.436924] snd_hda_intel 0000:05:00.1: Disabling MSI
[   12.441999] snd_hda_intel 0000:05:00.1: Handle VGA-switcheroo audio client
[   12.568500] alg: No test for crc32 (crc32-pclmul)
[   12.598319] input: HP WMI hotkeys as /devices/virtual/input/input8
[   12.622796] snd_hda_codec_realtek hdaudioC0D0: ALC262: SKU not ready 0x411111f0
[   12.630530] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC262: line_outs=1 (0x15/0x0/0x0/0x0/0x0) type:line
[   12.640910] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=1 (0x16/0x0/0x0/0x0/0x0)
[   12.648914] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[   12.656503] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[   12.662859] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[   12.668266] snd_hda_codec_realtek hdaudioC0D0:      Front Mic=0x19
[   12.674469] snd_hda_codec_realtek hdaudioC0D0:      Rear Mic=0x18
[   12.680568] snd_hda_codec_realtek hdaudioC0D0:      Line=0x1a
[   12.698813] input: HDA Intel PCH Front Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input9
[  OK  [   12.707972] input: HDA Intel PCH Rear Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input10
] Reached target[   12.718102] input: HDA Intel PCH Line as /devices/pci0000:00/0000:00:1b.0/sound/card0/input11
 Sound Card.
[   12.728003] input: HDA Intel PCH Line Out as /devices/pci0000:00/0000:00:1b.0/sound/card0/input12
[   12.738189] input: HDA Intel PCH Front Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input13
[   12.832233] input: HDA NVidia HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:02.0/0000:05:00.1/sound/card1/input14
[   12.842581] input: HDA NVidia HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:02.0/0000:05:00.1/sound/card1/input15
[   12.852881] input: HDA NVidia HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:02.0/0000:05:00.1/sound/card1/input16
[   12.863157] input: HDA NVidia HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:02.0/0000:05:00.1/sound/card1/input17
[  OK  ] Found device /dev/mapper/fedora_dhcp--128--28-swap.
         Activating swap /dev/mapper/fedora_dhcp--128--28-swap...
[   14.690904] Adding 11534332k swap on /dev/mapper/fedora_dhcp--128--28-swap.  Priority:-1 extents:1 across:11534332k FS
[  OK  ] Activated swap /dev/mapper/fedora_dhcp--128--28-swap.
[  OK  ] Reached target Swap.
[  OK  ] Started Activation of DM RAID sets.
[  OK  ] Reached target Encrypted Volumes.
[  OK  ] Created slice system-lvm2\x2dpvscan.slice.
         Starting LVM2 PV scan on device 8:2...
[  OK  ] Found device /dev/mapper/fedora_dhcp--128--28-home.
[  OK  ] Started LVM2 PV scan on device 8:2.
         Starting File System Check on /dev/mapper/fedora_dhcp--128--28-home...
[  OK  ] Found device WDC_WD10EALX-609BA0 1.
         Starting File System Check on /dev/...5-7f32-4fd7-87fc-615276a16f2f...
[   15.849500] systemd-fsck[672]: /dev/sda1: clean, 436/1310720 files, 185051/5242880 blocks
[   15.924728] systemd-fsck[669]: /dev/mapper/fedora_dhcp--128--28-home: clean, 256817/39321600 files, 7501587/157286400 blocks
[  OK  ] Started File System Check on /dev/d...845-7f32-4fd7-87fc-615276a16f2f.
[  OK  ] Started File System Check on /dev/mapper/fedora_dhcp--128--28-home.
         Mounting /home...
         Mounting /boot...
[   17.549292] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[  OK  ] Mounted /boot.
[   18.049074] EXT4-fs (dm-2): mounted filesystem with ordered data mode. Opts: (null)
[  OK  ] Mounted /home.
[  OK  ] Reached target Local File Systems.
         Starting Create Volatile Files and Directories...
         Starting Tell Plymouth To Write Out Runtime Data...
[  OK  ] Started Create Volatile Files and Directories.
         Starting Security Auditing Service...
[  OK  ] Started Tell Plymouth To Write Out Runtime Data.
[  OK  ] Started Security Auditing Service.
         Starting Update UTMP about System Boot/Shutdown...
[   18.575869] audit: type=1305 audit(1430303675.202:4): audit_pid=690 old=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:auditd_t:s0 res=1
[  OK  ] Started Update UTMP about System Boot/Shutdown.
[  OK  ] Reached target System Initialization.
[  OK  ] Reached target Paths.
[  OK  ] Listening on Open-iSCSI iscsiuio Socket.
[  OK  ] Listening on RPCbind Server Activation Socket.
[  OK  ] Listening on Open-iSCSI iscsid Socket.
[  OK  ] Listening on Avahi mDNS/DNS-SD Stack Activation Socket.
[  OK  ] Listening on CUPS Printing Service Sockets.
[  OK  ] Listening on D-Bus System Message Bus Socket.
[  OK  ] Reached target Sockets.
[  OK  ] Reached target Timers.
         Starting Manage Sound Card State (restore and store)...
[  OK  ] Started Manage Sound Card State (restore and store).
[  OK  ] Reached target Basic System.
         Starting RealtimeKit Scheduling Policy Service...
         Starting Accounts Service...
         Starting Modem Manager...
         Starting NTP client/server...
         Starting Hardware RNG Entropy Gatherer Daemon...
[  OK  ] Started Hardware RNG Entropy Gatherer Daemon.
         Starting Machine Check Exception Logging Daemon...
         Starting Login Service...
         Starting LSB: Init script for live image....
         Starting Avahi mDNS/DNS-SD Stack...
         Starting D-Bus System Message Bus...
[  OK  ] Started D-Bus System Message Bus.
[  OK  ] Started Avahi mDNS/DNS-SD Stack.
[  OK  ] Started RealtimeKit Scheduling Policy Service.
         Starting firewalld - dynamic firewall daemon...
[  OK  ] Started LSB: Init script for live image..
         Starting ABRT Automated Bug Reporting Tool...
[  OK  ] Started ABRT Automated Bug Reporting Tool.
         Starting Harvest vmcores for ABRT...
         Starting Install ABRT coredump hook...
         Starting ABRT kernel log watcher...
[  OK  ] Started ABRT kernel log watcher.
         Starting SYSV: Late init script for live image....
[  OK  ] Started Login Service.
[  OK  ] Started SYSV: Late init script for live image..
         Starting Authorization Manager...
[  OK  ] Started Machine Check Exception Logging Daemon.
[  OK  ] Started Install ABRT coredump hook.
[  OK  ] Started NTP client/server.
[  OK  ] Started Authorization Manager.
[  OK  ] Started Accounts Service.
[  OK  ] Started Modem Manager.
[   20.371933] tty_warn_deprecated_flags: 'ModemManager' is using deprecated serial flags (with no effect): 00008000
[   22.012159] nf_conntrack version 0.5.0 (65536 buckets, 262144 max)
[  OK  ] Started Harvest vmcores for ABRT.
[   23.305909] ip6_tables: (C) 2000-2006 Netfilter Core Team
[   25.004969] Ebtables v2.0 registered
[   25.086780] bridge: automatic filtering via arp/ip/ip6tables has been deprecated. Update your scripts to load br_netfilter if you need this.
[  OK  ] Started firewalld - dynamic firewall daemon.
         Starting Network Manager...
[   26.002526] cfg80211: Calling CRDA to update world regulatory domain
[  OK  ] Started Network Manager.
[  OK  ] Reached target Network.
[  OK  ] Reached target Remote File Systems (Pre).


--5I6of5zJg18YgZEa--
