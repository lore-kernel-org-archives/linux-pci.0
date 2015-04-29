Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 29 Apr 2015 19:20:24 +0800
From: Baoquan He <bhe@redhat.com>
To: "Li, Zhen-Hua" <zhen-hual@hp.com>
Cc: dwmw2@infradead.org, indou.takao@jp.fujitsu.com, joro@8bytes.org,
	vgoyal@redhat.com, dyoung@redhat.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kexec@lists.infradead.org,
	alex.williamson@redhat.com, ddutile@redhat.com,
	ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com,
	doug.hatch@hp.com, jerry.hoemann@hp.com, tom.vaden@hp.com,
	li.zhang6@hp.com, lisa.mitchell@hp.com, billsumnerlinux@gmail.com,
	rwright@hp.com
Subject: Re: [PATCH v10 0/10] iommu/vt-d: Fix intel vt-d faults in kdump
 kernel
Message-ID: <20150429112024.GB5799@dhcp-16-116.nay.redhat.com>
References: <1428655333-19504-1-git-send-email-zhen-hual@hp.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="DocE+STaALJfprDB"
In-Reply-To: <1428655333-19504-1-git-send-email-zhen-hual@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Bad news, I rebuilt a kernel with your patchset on 4.0.0+ (this commit
f614c81). Now dmar fault is  seen again.

The lspci log and kdump log are attached, please check:

[ ~]$ cat /proc/cmdline 
BOOT_IMAGE=/vmlinuz-4.0.0+ root=/dev/mapper/fedora_dhcp--128--28-root ro
rd.lvm.lv=fedora_dhcp-128-28/swap rd.lvm.lv=fedora_dhcp-128-28/root
crashkernel=256M console=ttyS0,115200 intel_iommu=on



--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci.txt"


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kdump_iommu.log"

[root@dhcp-128-28 ~]# echo c >/proc/sysrq-trigger 
[  163.160203] sysrq: SysRq : Trigger a crash
[  163.164362] BUG: unable to handle kernel NULL pointer dereference at           (null)
[  163.172220] IP: [<ffffffff81480696>] sysrq_handle_crash+0x16/0x20
[  163.178333] PGD 419aba067 PUD 419774067 PMD 0 
[  163.182838] Oops: 0002 [#1] SMP 
[  163.186114] Modules linked in: xt_CHECKSUM ipt_MASQUERADE nf_nat_masquerade_ipv4 nf_conntrack_netbios_ns nf_conntrack_broadcast ip6t_rpfilter ip6t_REJECT cfg80211i
[  163.287902] CPU: 0 PID: 1662 Comm: bash Not tainted 4.0.0+ #6
[  163.293648] Hardware name: Hewlett-Packard HP Z420 Workstation/1589, BIOS J61 v01.02 03/09/2012
[  163.302351] task: ffff8803fdefd580 ti: ffff880403744000 task.ti: ffff880403744000
[  163.309842] RIP: 0010:[<ffffffff81480696>]  [<ffffffff81480696>] sysrq_handle_crash+0x16/0x20
[  163.318383] RSP: 0018:ffff880403747da8  EFLAGS: 00010246
[  163.323696] RAX: 000000000000000f RBX: 0000000000000063 RCX: 000000000000000f
[  163.330817] RDX: 0000000000000000 RSI: ffff88042fc0ea08 RDI: 0000000000000063
[  163.337939] RBP: ffff880403747da8 R08: 0000000000000096 R09: 0000000000015098
[  163.345067] R10: 00000000000003f1 R11: 0000000000000002 R12: 0000000000000007
[  163.352203] R13: 0000000000000000 R14: ffffffff81cc33e0 R15: 0000000000000000
[  163.359346] FS:  00007ff6f6ca9700(0000) GS:ffff88042fc00000(0000) knlGS:0000000000000000
[  163.367443] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  163.373180] CR2: 0000000000000000 CR3: 00000004019d6000 CR4: 00000000000407f0
[  163.380305] Stack:
[  163.382321]  ffff880403747dd8 ffffffff81480ea6 0000000000000002 fffffffffffffffb
[  163.389771]  00007ff6f6cc5000 0000000000000002 ffff880403747df8 ffffffff81481353
[  163.397222]  ffff880403747ec8 ffff88041d167f00 ffff880403747e18 ffffffff81282408
[  163.404682] Call Trace:
[  163.407130]  [<ffffffff81480ea6>] __handle_sysrq+0x106/0x170
[  163.412784]  [<ffffffff81481353>] write_sysrq_trigger+0x33/0x40
[  163.418697]  [<ffffffff81282408>] proc_reg_write+0x48/0x70
[  163.424172]  [<ffffffff81215e77>] __vfs_write+0x37/0x110
[  163.429478]  [<ffffffff81218d48>] ? __sb_start_write+0x58/0x120
[  163.435391]  [<ffffffff8131dc03>] ? security_file_permission+0x23/0xa0
[  163.441902]  [<ffffffff812165e9>] vfs_write+0xa9/0x1b0
[  163.447035]  [<ffffffff812174a5>] SyS_write+0x55/0xd0
[  163.452085]  [<ffffffff81067f6f>] ? do_page_fault+0x2f/0x80
[  163.457651]  [<ffffffff8178416e>] system_call_fastpath+0x12/0x71
[  163.463648] Code: ef e8 bf f7 ff ff eb d8 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 66 66 66 66 90 55 c7 05 d4 6c a9 00 01 00 00 00 48 89 e5 0f ae f8 <c6> 04 25 00 0 
[  163.483597] RIP  [<ffffffff81480696>] sysrq_handle_crash+0x16/0x20
[  163.489777]  RSP <ffff880403747da8>
[  163.493257] CR2: 0000000000000000
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.0.0+ (bhe@dhcp-128-28.nay.redhat.com) (gcc version 4.9.2 20150212 (Red Hat 4.9.2-6) (GCC) ) #6 SMP Wed Apr 29 16:53:34 CST 2015
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-4.0.0+ root=/dev/mapper/fedora_dhcp--128--28-root ro rd.lvm.lv=fedora_dhcp-128-28/swap rd.lvm.lv=fedora_dhcp-128-28/K
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000000fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000001000-0x00000000000963ff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000096400-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000025000000-0x0000000034f65fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000034fff400-0x0000000034ffffff] usable
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
[    0.000000] earlycon: no match for ttyS0,115200
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.7 present.
[    0.000000] e820: last_pfn = 0x35000 max_arch_pfn = 0x400000000
[    0.000000] PAT configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- UC  
[    0.000000] x2apic: enabled by BIOS, switching to x2apic ops
[    0.000000] found SMP MP-table at [mem 0x000f4bc0-0x000f4bcf] mapped at [ffff8800000f4bc0]
[    0.000000] Using GB pages for direct mapping
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000] init_memory_mapping: [mem 0x34c00000-0x34dfffff]
[    0.000000] init_memory_mapping: [mem 0x25000000-0x34bfffff]
[    0.000000] init_memory_mapping: [mem 0x34e00000-0x34f65fff]
[    0.000000] RAMDISK: [mem 0x31cbe000-0x32ffffff]
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
[    0.000000] Setting APIC routing to cluster x2apic.
[    0.000000] NUMA turned off
[    0.000000] Faking a node at [mem 0x0000000000000000-0x0000000034ffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x34f52000-0x34f65fff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x0000000034ffffff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x0000000000095fff]
[    0.000000]   node   0: [mem 0x0000000025000000-0x0000000034f65fff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x0000000034f65fff]
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x02] enabled)
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 reached.  Processor 1/0x2 ignored.
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x04] enabled)
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 reached.  Processor 2/0x4 ignored.
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x06] enabled)
[    0.000000] ACPI: NR_CPUS/possible_cpus limit of 1 reached.  Processor 3/0x6 ignored.
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x00] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 0, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec01000] gsi_base[24])
[    0.000000] IOAPIC[1]: apic_id 2, version 32, address 0xfec01000, GSI 24-47
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] smpboot: 4 Processors exceeds NR_CPUS limit of 1
[    0.000000] smpboot: Allowing 1 CPUs, 0 hotplug CPUs
[    0.000000] e820: [mem 0x35000000-0xcb74ffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:1 nr_node_ids:1
[    0.000000] PERCPU: Embedded 34 pages/cpu @ffff880034c00000 s101720 r8192 d29352 u2097152
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 64485
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.0.0+ root=/dev/mapper/fedora_dhcp--128--28-root ro rd.lvm.lv=fedora_dhcp-128-28/swap rd.lvm.lv=fedora_dhcp-K
[    0.000000] Intel-IOMMU: enabled
[    0.000000] Misrouted IRQ fixup and polling support enabled
[    0.000000] This may significantly impact system performance
[    0.000000] Disabling memory control group subsystem
[    0.000000] PID hash table entries: 1024 (order: 1, 8192 bytes)
[    0.000000] xsave: enabled xstate_bv 0x7, cntxt size 0x340 using standard form
[    0.000000] Memory: 217108K/262124K available (7716K kernel code, 1276K rwdata, 3260K rodata, 1500K init, 1448K bss, 45016K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000]  RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
[    0.000000] NR_IRQS:4352 nr_irqs:256 16
[    0.000000]  Offload RCU callbacks from all CPUs
[    0.000000]  Offload RCU callbacks from CPUs: 0.
[    0.000000] Spurious LAPIC timer interrupt on cpu 0
[    0.000000] do_IRQ: 0.100 No irq handler for vector (irq -1)
[    0.000000] do_IRQ: 0.37 No irq handler for vector (irq -1)
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [ttyS0] enabled
[    0.000000] clocksource hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2793.236 MHz processor
[    0.000065] Calibrating delay loop (skipped), value calculated using timer frequency.. 5586.47 BogoMIPS (lpj=2793236)
[    0.010687] pid_max: default: 32768 minimum: 301
[    0.015320] ACPI: Core revision 20150410
[    0.076923] ACPI: All ACPI Tables successfully acquired
[    0.082243] Security Framework initialized
[    0.086345] SELinux:  Initializing.
[    0.089932] Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.097009] Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.103936] Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
[    0.110471] Mountpoint-cache hash table entries: 512 (order: 0, 4096 bytes)
[    0.117723] Initializing cgroup subsys blkio
[    0.121992] Initializing cgroup subsys memory
[    0.126346] Initializing cgroup subsys devices
[    0.130783] Initializing cgroup subsys freezer
[    0.135220] Initializing cgroup subsys net_cls
[    0.139663] Initializing cgroup subsys perf_event
[    0.144370] Initializing cgroup subsys net_prio
[    0.148906] Initializing cgroup subsys hugetlb
[    0.153399] CPU: Physical Processor ID: 0
[    0.157416] CPU: Processor Core ID: 0
[    0.161098] process: using mwait in idle threads
[    0.165727] Last level iTLB entries: 4KB 512, 2MB 8, 4MB 8
[    0.171215] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    0.189958] Freeing SMP alternatives memory: 28K (ffffffff81eb8000 - ffffffff81ebf000)
[    0.200232] ftrace: allocating 27958 entries in 110 pages
[    0.233887] dmar: Host address width 46
[    0.237730] dmar: DRHD base: 0x000000dfffc000 flags: 0x1
[    0.243057] dmar: IOMMU 0: reg_base_addr dfffc000 ver 1:0 cap d2078c106f0462 ecap f020fe
[    0.251150] dmar: RMRR base: 0x000000cba11000 end: 0x000000cba27fff
[    0.257428] dmar: ATSR flags: 0x0
[    0.260752] IOAPIC id 0 under DRHD base  0xdfffc000 IOMMU 0
[    0.266318] IOAPIC id 2 under DRHD base  0xdfffc000 IOMMU 0
[    0.271873] HPET id 0 under DRHD base 0xdfffc000
[    0.276787] IR is enabled prior to OS.
[    0.280543] Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.290569] Enabled IRQ remapping in x2apic mode
[    0.295793] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.311836] smpboot: CPU0: Intel(R) Xeon(R) CPU E5-1603 0 @ 2.80GHz (fam: 06, model: 2d, stepping: 07)
[    0.321233] Performance Events: PEBS fmt1+, 16-deep LBR, SandyBridge events, full-width counters, Intel PMU driver.
[    0.331798] ... version:                3
[    0.335798] ... bit width:              48
[    0.339899] ... generic registers:      8
[    0.343917] ... value mask:             0000ffffffffffff
[    0.349236] ... max period:             0000ffffffffffff
[    0.354555] ... fixed-purpose events:   3
[    0.358571] ... event mask:             00000007000000ff
[    0.365068] x86: Booted up 1 node, 1 CPUs
[    0.369089] smpboot: Total of 1 processors activated (5586.47 BogoMIPS)
[    0.375739] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.386838] devtmpfs: initialized
[    0.395976] PM: Registering ACPI NVS region [mem 0xcb750000-0xcb7dafff] (569344 bytes)
[    0.403925] PM: Registering ACPI NVS region [mem 0xcbaad000-0xcbaaefff] (8192 bytes)
[    0.411660] PM: Registering ACPI NVS region [mem 0xcbabb000-0xcbacdfff] (77824 bytes)
[    0.419482] PM: Registering ACPI NVS region [mem 0xcbb56000-0xcbb5dfff] (32768 bytes)
[    0.427317] PM: Registering ACPI NVS region [mem 0xcbb71000-0xcbffffff] (4780032 bytes)
[    0.435539] clocksource jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.445303] atomic64_test: passed for x86-64 platform with CX8 and with SSE
[    0.452262] pinctrl core: initialized pinctrl subsystem
[    0.457536] RTC time: 10:37:02, date: 04/29/15
[    0.462187] NET: Registered protocol family 16
[    0.467020] cpuidle: using governor menu
[    0.471152] ACPI: bus type PCI registered
[    0.475160] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.481718] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.491006] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    0.498450] PCI: Using configuration type 1 for base access
[    0.504311] perf_event_intel: PMU erratum BJ122, BV98, HSD29 workaround disabled, HT off
[    0.514793] ACPI: Added _OSI(Module Device)
[    0.518993] ACPI: Added _OSI(Processor Device)
[    0.523451] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.528161] ACPI: Added _OSI(Processor Aggregator Device)
[    0.547246] ACPI: Executed 1 blocks of module-level executable AML code
[    0.676932] ACPI: Interpreter enabled
[    0.680610] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_] (20150410/hwxface-580)
[    0.689859] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20150410/hwxface-580)
[    0.699122] ACPI: (supports S0 S3 S5)
[    0.702784] ACPI: Using IOAPIC for interrupt routing
[    0.707798] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.718463] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.741051] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7f])
[    0.747236] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.755636] acpi PNP0A08:00: _OSC: platform does not support [PCIeCapability]
[    0.762877] acpi PNP0A08:00: _OSC: not requesting control; platform does not support [PCIeCapability]
[    0.772090] acpi PNP0A08:00: _OSC: OS requested [PCIeHotplug PME AER PCIeCapability]
[    0.779818] acpi PNP0A08:00: _OSC: platform willing to grant [PCIeHotplug PME AER]
[    0.787373] acpi PNP0A08:00: _OSC failed (AE_SUPPORT); disabling ASPM
[    0.794389] PCI host bridge to bus 0000:00
[    0.798498] pci_bus 0000:00: root bus resource [bus 00-7f]
[    0.803986] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.810759] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.817538] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.824314] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.831093] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.838557] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
[    0.846026] pci_bus 0000:00: root bus resource [mem 0xd4000000-0xdfffffff window]
[    0.853494] pci_bus 0000:00: root bus resource [mem 0x3c0000000000-0x3c007fffffff window]
[    0.862049] pci 0000:00:01.0: System wakeup disabled by ACPI
[    0.867944] pci 0000:00:02.0: System wakeup disabled by ACPI
[    0.873839] pci 0000:00:03.0: System wakeup disabled by ACPI
[    0.881198] pci 0000:00:19.0: System wakeup disabled by ACPI
[    0.887113] pci 0000:00:1a.0: System wakeup disabled by ACPI
[    0.893180] pci 0000:00:1c.0: Enabling MPC IRBNCE
[    0.897884] pci 0000:00:1c.0: Intel PCH root port ACS workaround enabled
[    0.904617] pci 0000:00:1c.0: System wakeup disabled by ACPI
[    0.910497] pci 0000:00:1c.5: Enabling MPC IRBNCE
[    0.915201] pci 0000:00:1c.5: Intel PCH root port ACS workaround enabled
[    0.921946] pci 0000:00:1c.5: System wakeup disabled by ACPI
[    0.927775] pci 0000:00:1c.6: Enabling MPC IRBNCE
[    0.932477] pci 0000:00:1c.6: Intel PCH root port ACS workaround enabled
[    0.939210] pci 0000:00:1c.6: System wakeup disabled by ACPI
[    0.945045] pci 0000:00:1c.7: Enabling MPC IRBNCE
[    0.949762] pci 0000:00:1c.7: Intel PCH root port ACS workaround enabled
[    0.956513] pci 0000:00:1c.7: System wakeup disabled by ACPI
[    0.962422] pci 0000:00:1d.0: System wakeup disabled by ACPI
[    0.968247] pci 0000:00:1e.0: System wakeup disabled by ACPI
[    0.974687] pci 0000:00:01.0: PCI bridge to [bus 03]
[    0.981695] pci 0000:00:02.0: PCI bridge to [bus 05]
[    0.986766] pci 0000:00:03.0: PCI bridge to [bus 04]
[    0.992023] pci 0000:02:00.0: VF(n) BAR0 space: [mem 0xde800000-0xde87bfff 64bit pref] (contains BAR0 for 31 VFs)
[    1.002485] pci 0000:00:11.0: PCI bridge to [bus 02]
[    1.007553] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    1.012620] pci 0000:00:1c.5: PCI bridge to [bus 06]
[    1.017677] pci 0000:00:1c.6: PCI bridge to [bus 07]
[    1.024661] pci 0000:00:1c.7: PCI bridge to [bus 08]
[    1.030149] pci 0000:00:1e.0: PCI bridge to [bus 09] (subtractive decode)
[    1.037879] ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 80-ff])
[    1.044067] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    1.052491] acpi PNP0A08:01: _OSC: platform does not support [PCIeCapability]
[    1.059741] acpi PNP0A08:01: _OSC: not requesting control; platform does not support [PCIeCapability]
[    1.068944] acpi PNP0A08:01: _OSC: OS requested [PCIeHotplug PME AER PCIeCapability]
[    1.076670] acpi PNP0A08:01: _OSC: platform willing to grant [PCIeHotplug PME AER]
[    1.084224] acpi PNP0A08:01: _OSC failed (AE_SUPPORT); disabling ASPM
[    1.090899] PCI host bridge to bus 0000:80
[    1.095002] pci_bus 0000:80: root bus resource [bus 80-ff]
[    1.100484] pci_bus 0000:80: root bus resource [io  0x0000-0x03af window]
[    1.107260] pci_bus 0000:80: root bus resource [io  0x03e0-0x0cf7 window]
[    1.114039] pci_bus 0000:80: root bus resource [mem 0x000c0000-0x000dffff window]
[    1.121669] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15), disabled.
[    1.129988] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15), disabled.
[    1.138300] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 15), disabled.
[    1.146408] ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 10 11 12 14 15), disabled.
[    1.154518] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 10 11 12 14 15), disabled.
[    1.162825] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[    1.171326] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 10 11 12 14 15), disabled.
[    1.179644] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *10 11 12 14 15), disabled.
[    1.188199] ACPI: NR_CPUS/possible_cpus limit of 1 reached.  Processor 4/0x2 ignored.
[    1.196018] ACPI: Unable to map lapic to logical cpu number
[    1.201750] ACPI: NR_CPUS/possible_cpus limit of 1 reached.  Processor 5/0x4 ignored.
[    1.209582] ACPI: Unable to map lapic to logical cpu number
[    1.215318] ACPI: NR_CPUS/possible_cpus limit of 1 reached.  Processor 6/0x6 ignored.
[    1.223153] ACPI: Unable to map lapic to logical cpu number
[    1.229434] ACPI: Enabled 2 GPEs in block 00 to 3F
[    1.234470] vgaarb: setting as boot device: PCI:0000:05:00.0
[    1.240127] vgaarb: device added: PCI:0000:05:00.0,decodes=io+mem,owns=io+mem,locks=none
[    1.248211] vgaarb: loaded
[    1.250925] vgaarb: bridge control possible 0000:05:00.0
[    1.256375] SCSI subsystem initialized
[    1.260262] ACPI: bus type USB registered
[    1.264311] usbcore: registered new interface driver usbfs
[    1.269801] usbcore: registered new interface driver hub
[    1.275125] usbcore: registered new device driver usb
[    1.280345] PCI: Using ACPI for IRQ routing
[    1.292659] PCI: Discovered peer bus ff
[    1.296562] ACPI: \: failed to evaluate _DSM (0x1001)
[    1.301617] PCI host bridge to bus 0000:ff
[    1.305712] pci_bus 0000:ff: root bus resource [io  0x0000-0xffff]
[    1.311880] pci_bus 0000:ff: root bus resource [mem 0x00000000-0x3fffffffffff]
[    1.319092] pci_bus 0000:ff: No busn resource found for root bus, will use [bus ff-ff]
[    1.331425] NetLabel: Initializing
[    1.334831] NetLabel:  domain hash size = 128
[    1.339187] NetLabel:  protocols = UNLABELED CIPSOv4
[    1.344167] NetLabel:  unlabeled traffic allowed by default
[    1.349929] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    1.356272] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    1.364155] Switched to clocksource hpet
[    1.378628] pnp: PnP ACPI init
[    1.381916] system 00:00: [mem 0xfc000000-0xfcffffff window] has been reserved
[    1.389159] system 00:00: [mem 0xfd000000-0xfdffffff window] has been reserved
[    1.396381] system 00:00: [mem 0xfe000000-0xfeafffff window] has been reserved
[    1.403595] system 00:00: [mem 0xfeb00000-0xfebfffff window] has been reserved
[    1.410816] system 00:00: [mem 0xfed00400-0xfed3ffff window] could not be reserved
[    1.418371] system 00:00: [mem 0xfed45000-0xfedfffff window] has been reserved
[    1.425578] system 00:00: [mem 0xdffff000-0xdfffffff window] has been reserved
[    1.433036] system 00:01: [io  0x0620-0x063f] has been reserved
[    1.438955] system 00:01: [io  0x0610-0x061f] has been reserved
[    1.445255] system 00:05: [io  0x04d0-0x04d1] has been reserved
[    1.451860] system 00:07: [io  0x0400-0x0453] could not be reserved
[    1.458143] system 00:07: [io  0x0458-0x047f] has been reserved
[    1.464072] system 00:07: [io  0x1180-0x119f] has been reserved
[    1.469997] system 00:07: [io  0x0500-0x057f] has been reserved
[    1.475926] system 00:07: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    1.482549] system 00:07: [mem 0xfec00000-0xfecfffff] could not be reserved
[    1.489517] system 00:07: [mem 0xfed08000-0xfed08fff] has been reserved
[    1.496120] system 00:07: [mem 0xff000000-0xffffffff] has been reserved
[    1.502862] system 00:08: [io  0x0454-0x0457] has been reserved
[    1.509408] system 00:09: [mem 0xfed40000-0xfed44fff] has been reserved
[    1.516024] pnp: PnP ACPI: found 10 devices
[    1.527531] clocksource acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    1.536416] pci 0000:00:01.0: PCI bridge to [bus 03]
[    1.541392] pci 0000:00:02.0: PCI bridge to [bus 05]
[    1.546363] pci 0000:00:02.0:   bridge window [io  0xd000-0xdfff]
[    1.552460] pci 0000:00:02.0:   bridge window [mem 0xd6000000-0xd70fffff]
[    1.559247] pci 0000:00:02.0:   bridge window [mem 0xd8000000-0xddffffff 64bit pref]
[    1.566993] pci 0000:00:03.0: PCI bridge to [bus 04]
[    1.571969] pci 0000:00:11.0: PCI bridge to [bus 02]
[    1.576930] pci 0000:00:11.0:   bridge window [io  0xe000-0xefff]
[    1.583023] pci 0000:00:11.0:   bridge window [mem 0xde400000-0xde8fffff 64bit pref]
[    1.590773] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    1.595747] pci 0000:00:1c.5: PCI bridge to [bus 06]
[    1.600725] pci 0000:00:1c.6: PCI bridge to [bus 07]
[    1.605702] pci 0000:00:1c.7: PCI bridge to [bus 08]
[    1.610669] pci 0000:00:1c.7:   bridge window [mem 0xd7200000-0xd72fffff]
[    1.617457] pci 0000:00:1e.0: PCI bridge to [bus 09]
[    1.622418] pci 0000:00:1e.0:   bridge window [io  0xc000-0xcfff]
[    1.628523] pci 0000:00:1e.0:   bridge window [mem 0xd7100000-0xd71fffff]
[    1.635493] NET: Registered protocol family 2
[    1.640142] TCP established hash table entries: 2048 (order: 2, 16384 bytes)
[    1.647220] TCP bind hash table entries: 2048 (order: 3, 32768 bytes)
[    1.653666] TCP: Hash tables configured (established 2048 bind 2048)
[    1.660060] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    1.665892] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    1.672227] NET: Registered protocol family 1
[    1.682331] Unpacking initramfs...
[    2.307008] Freeing initrd memory: 19720K (ffff880031cbe000 - ffff880033000000)
[    2.314686] Translation is enabled prior to OS.
[    2.319221] IOMMU Copying translate tables from panicked kernel
[    2.325295] IOMMU: root_cache:0xffff88002ccbb000 phys:0x0000c6548000
[    2.331655] IOMMU: dmar0 using Queued invalidation
[    2.336450] PCI-DMA: Intel(R) Virtualization Technology for Directed I/O
[    2.345395] RAPL PMU detected, API unit is 2^-32 Joules, 3 fixed counters 163840 ms ovfl timer
[    2.353994] hw unit of domain pp0-core 2^-16 Joules
[    2.358868] hw unit of domain package 2^-16 Joules
[    2.363655] hw unit of domain dram 2^-16 Joules
[    2.368417] microcode: CPU0 sig=0x206d7, pf=0x1, revision=0x710
[    2.374442] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    2.383569] AVX version of gcm_enc/dec engaged.
[    2.388108] AES CTR mode by8 optimization enabled
[    2.396079] alg: No test for __gcm-aes-aesni (__driver-gcm-aes-aesni)
[    2.402980] futex hash table entries: 256 (order: 2, 16384 bytes)
[    2.409140] Initialise system trusted keyring
[    2.413542] audit: initializing netlink subsys (disabled)
[    2.418975] audit: type=2000 audit(1430303822.418:1): initialized
[    2.426139] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    2.435279] zpool: loaded
[    2.438216] VFS: Disk quotas dquot_6.6.0
[    2.442219] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    2.449839] Key type big_key registered
[    2.454761] alg: No test for stdrng (krng)
[    2.458884] NET: Registered protocol family 38
[    2.463360] Key type asymmetric registered
[    2.467472] Asymmetric key parser 'x509' registered
[    2.472438] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    2.479862] io scheduler noop registered
[    2.483800] io scheduler deadline registered
[    2.488144] io scheduler cfq registered (default)
[    2.494392] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    2.500020] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    2.506896] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    2.515253] ACPI: Power Button [PWRB]
[    2.518991] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    2.526378] ACPI: Power Button [PWRF]
[    2.531997] GHES: HEST is not enabled!
[    2.535871] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    2.562820] 00:06: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    2.591181] 0000:00:16.3: ttyS1 at I/O 0xf060 (irq = 17, base_baud = 115200) is a 16550A
[    2.599752] Non-volatile memory driver v1.3
[    2.604004] Linux agpgart interface v0.103
[    2.619575] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x5 impl RAID mode
[    2.627657] ahci 0000:00:1f.2: flags: 64bit ncq sntf led clo pio ems sxs apst 
[    2.637433] scsi host0: ahci
[    2.640467] scsi host1: ahci
[    2.643472] scsi host2: ahci
[    2.646470] scsi host3: ahci
[    2.649477] scsi host4: ahci
[    2.652482] scsi host5: ahci
[    2.655438] ata1: SATA max UDMA/133 abar m2048@0xd7348000 port 0xd7348100 irq 27
[    2.662824] ata2: DUMMY
[    2.665275] ata3: SATA max UDMA/133 abar m2048@0xd7348000 port 0xd7348200 irq 27
[    2.672666] ata4: DUMMY
[    2.675113] ata5: DUMMY
[    2.677562] ata6: DUMMY
[    2.680385] libphy: Fixed MDIO Bus: probed
[    2.684693] xhci_hcd 0000:08:00.0: xHCI Host Controller
[    2.689982] xhci_hcd 0000:08:00.0: new USB bus registered, assigned bus number 1
[    2.697664] xhci_hcd 0000:08:00.0: hcc params 0x0270f06d hci version 0x96 quirks 0x00004000
[    2.706170] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    2.712953] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.720172] usb usb1: Product: xHCI Host Controller
[    2.725050] usb usb1: Manufacturer: Linux 4.0.0+ xhci-hcd
[    2.730451] usb usb1: SerialNumber: 0000:08:00.0
[    2.735274] hub 1-0:1.0: USB hub found
[    2.739053] hub 1-0:1.0: 4 ports detected
[    2.743275] xhci_hcd 0000:08:00.0: xHCI Host Controller
[    2.748560] xhci_hcd 0000:08:00.0: new USB bus registered, assigned bus number 2
[    2.755999] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[    2.762778] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.769992] usb usb2: Product: xHCI Host Controller
[    2.774865] usb usb2: Manufacturer: Linux 4.0.0+ xhci-hcd
[    2.780256] usb usb2: SerialNumber: 0000:08:00.0
[    2.785049] hub 2-0:1.0: USB hub found
[    2.788829] hub 2-0:1.0: 4 ports detected
[    2.793070] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.799603] ehci-pci: EHCI PCI platform driver
[    2.804223] ehci-pci 0000:00:1a.0: EHCI Host Controller
[    2.809519] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 3
[    2.816918] ehci-pci 0000:00:1a.0: debug port 2
[    2.825476] ehci-pci 0000:00:1a.0: irq 16, io mem 0xd734b000
[    2.836792] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    2.842597] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[    2.849380] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.856592] usb usb3: Product: EHCI Host Controller
[    2.861469] usb usb3: Manufacturer: Linux 4.0.0+ ehci_hcd
[    2.866864] usb usb3: SerialNumber: 0000:00:1a.0
[    2.871736] hub 3-0:1.0: USB hub found
[    2.875523] hub 3-0:1.0: 3 ports detected
[    2.879920] ehci-pci 0000:00:1d.0: EHCI Host Controller
[    2.885234] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 4
[    2.892646] ehci-pci 0000:00:1d.0: debug port 2
[    2.901304] ehci-pci 0000:00:1d.0: irq 23, io mem 0xd734a000
[    2.912902] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    2.918730] usb usb4: New USB device found, idVendor=1d6b, idProduct=0002
[    2.925512] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.932747] usb usb4: Product: EHCI Host Controller
[    2.937639] usb usb4: Manufacturer: Linux 4.0.0+ ehci_hcd
[    2.943057] usb usb4: SerialNumber: 0000:00:1d.0
[    2.947909] hub 4-0:1.0: USB hub found
[    2.951684] hub 4-0:1.0: 3 ports detected
[    2.955934] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.962132] ohci-pci: OHCI PCI platform driver
[    2.966601] uhci_hcd: USB Universal Host Controller Interface driver
[    2.973066] usbcore: registered new interface driver usbserial
[    2.978909] usbcore: registered new interface driver usbserial_generic
[    2.985490] usbserial: USB Serial support registered for generic
[    2.991520] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.997725] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    3.003994] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
[    3.012319] ata3.00: ATAPI: hp       CDDVDW SH-216ALN, HA5A, max UDMA/100
[    3.019125] ata1.00: ATA-8: WDC WD10EALX-609BA0, 18.01H18, max UDMA/100
[    3.025752] ata1.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    3.035655] serio: i8042 KBD port at 0x60,0x64 irq 1
[    3.040666] ata3.00: configured for UDMA/100
[    3.044957] ata1.00: configured for UDMA/100
[    3.049378] scsi 0:0:0:0: Direct-Access     ATA      WDC WD10EALX-609 1H18 PQ: 0 ANSI: 5
[    3.057523] serio: i8042 AUX port at 0x60,0x64 irq 12
[    3.062805] mousedev: PS/2 mouse device common for all mice
[    3.068682] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    3.074058] sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 TB/931 GiB)
[    3.082100] sd 0:0:0:0: [sda] Write Protect is off
[    3.086998] rtc_cmos 00:04: RTC can wake from S4
[    3.091647] scsi 2:0:0:0: CD-ROM            hp       CDDVDW SH-216ALN HA5A PQ: 0 ANSI: 5
[    3.099973] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
[    3.106123] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.115613] rtc_cmos 00:04: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    3.123614] device-mapper: uevent: version 1.0.3
[    3.128405]  sda: sda1 sda2
[    3.131679] sd 0:0:0:0: [sda] Attached SCSI disk
[    3.136335] device-mapper: ioctl: 4.31.0-ioctl (2015-3-12) initialised: dm-devel@redhat.com
[    3.145429] Intel P-state driver initializing.
[    3.151685] hidraw: raw HID events driver (C) Jiri Kosina
[    3.157694] usbcore: registered new interface driver usbhid
[    3.163274] usbhid: USB HID core driver
[    3.167188] drop_monitor: Initializing network drop monitor service
[    3.173625] ip_tables: (C) 2000-2006 Netfilter Core Team
[    3.178975] sr 2:0:0:0: [sr0] scsi3-mmc drive: 40x/40x writer dvd-ram cd/rw xa/form2 cdda tray
[    3.187607] cdrom: Uniform CD-ROM driver Revision: 3.20
[    3.192862] Initializing XFRM netlink socket
[    3.197314] NET: Registered protocol family 10
[    3.201773] usb 3-1: new high-speed USB device number 2 using ehci-pci
[    3.208817] mip6: Mobile IPv6
[    3.211978] sr 2:0:0:0: Attached scsi generic sg1 type 5
[    3.217292] NET: Registered protocol family 17
[    3.221791] dmar: DRHD: handling fault status reg 2
[    3.226666] dmar: DMAR:[DMA Read] Request device [00:1f.2] fault addr fffc0000 
[    3.226666] DMAR:[fault reason 06] PTE Read access is not set
[    3.239704] ata3.00: exception Emask 0x60 SAct 0x0 SErr 0x800 action 0x6 frozen
[    3.247007] ata3.00: irq_stat 0x20000000, host bus error
[    3.252323] ata3: SError: { HostInt }
[    3.255995] ata3.00: cmd a0/00:00:00:08:00/00:00:00:00:00/a0 tag 5 pio 16392 in
[    3.255995]          Get event status notification 4a 01 00 00 10 00 00 00 08 00res 50/00:03:00:80:00/00:00:00:00:00/a0 Emask 0x60 (host bus error)
[    3.276455] ata3.00: status: { DRDY }
[    3.280121] ata3: hard resetting link
[    3.283806] usb 4-1: new high-speed USB device number 2 using ehci-pci
[    3.290350] mce: Unable to init device /dev/mcelog (rc: -5)
[    3.296192] Loading compiled-in X.509 certificates
[    3.302015] Loaded X.509 cert 'Magrathea: Glacier signing key: 8d99b9f6f028e78c7dfe07caad5fd2ff7cee9c74'
[    3.311548] registered taskstats version 1
[    3.316092]   Magic number: 11:806:629
[    3.319931] rtc_cmos 00:04: setting system clock to 2015-04-29 10:37:05 UTC (1430303825)
[    3.328504] Freeing unused kernel memory: 1500K (ffffffff81d41000 - ffffffff81eb8000)
[    3.336329] Write protecting the kernel read-only data: 12288k
[    3.342583] Freeing unused kernel memory: 464K (ffff88003378c000 - ffff880033800000)
[    3.350787] Freeing unused kernel memory: 836K (ffff880033b2f000 - ffff880033c00000)
[    3.358525] tsc: Refined TSC clocksource calibration: 2793.268 MHz
[    3.364699] clocksource tsc: mask: 0xffffffffffffffff max_cycles: 0x28436928c28, max_idle_ns: 440795267499 ns
[    3.375952] random: systemd urandom read with 13 bits of entropy available
[    3.383395] systemd[1]: systemd 217 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -L)
[    3.401586] systemd[1]: Detected architecture 'x86-64'.
[    3.406820] systemd[1]: Running in initial RAM disk.

Welcome to Fedora 21 (Twenty One) dracut-038-30.git20140903.fc21 (Initramfs)!

[    3.420591] systemd[1]: Set hostname to <dhcp-128-28.nay.redhat.com>.
[    3.427453] usb 3-1: New USB device found, idVendor=8087, idProduct=0024
[    3.434150] usb 3-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.441287] usb 4-1: New USB device found, idVendor=8087, idProduct=0024
[    3.447985] usb 4-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.467331] hub 3-1:1.0: USB hub found
[    3.471115] hub 4-1:1.0: USB hub found
[    3.478192] hub 4-1:1.0: 8 ports detected
[    3.482208] hub 3-1:1.0: 6 ports detected
[    3.494103] systemd[1]: Expecting device dev-mapper-fedora_dhcp\x2d\x2d128\x2d\x2d28\x2dswap.device...
         Expecting device dev-mapper-fedora_...d128\x2d\x2d28\x2dswap.device...
[    3.511619] systemd[1]: Expecting device dev-disk-by\x2duuid-689a8845\x2d7f32\x2d4fd7\x2d87fc\x2d615276a16f2f.device...
         Expecting device dev-disk-by\x2duui...2d87fc\x2d615276a16f2f.device...
[    3.530640] systemd[1]: Expecting device dev-mapper-fedora_dhcp\x2d\x2d128\x2d\x2d28\x2droot.device...
         Expecting device dev-mapper-fedora_...d128\x2d\x2d28\x2droot.device...
[    3.548656] systemd[1]: Starting Timers.
[  OK  ] Reached target Timers.
[    3.556651] systemd[1]: Reached target Timers.
[    3.561115] systemd[1]: Starting Dispatch Password Requests to Console Directory Watch.
[    3.569147] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    3.577064] systemd[1]: Starting Paths.
[  OK  ] Reached target Paths.
[    3.585700] systemd[1]: Reached target Paths.
[    3.590077] systemd[1]: Starting -.slice.
[  OK  ] Created slice -.slice.
[    3.601708] systemd[1]: Created slice -.slice.
[    3.606181] systemd[1]: Starting udev Control Socket.
[  OK  ] Listening on udev Control Socket.
[    3.617731] systemd[1]: Listening on udev Control Socket.
[    3.623154] systemd[1]: Starting udev Kernel Socket.
[  OK  ] Listening on udev Kernel Socket.
[    3.633749] systemd[1]: Listening on udev Kernel Socket.
[    3.639080] systemd[1]: Starting Journal Socket.
[  OK  [    3.644687] dmar: DRHD: handling fault status reg 102
[    3.650280] dmar: DMAR:[DMA Write] Request device [00:1f.2] fault addr fffc0000 
[    3.650280] DMAR:[fault reason 05] PTE Write access is not set
] Listening on J[    3.663523] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ournal Socket.
[    3.671072] dmar: DRHD: handling fault status reg 202
[    3.677461] dmar: DMAR:[DMA Read] Request device [00:1f.2] fault addr fffc0000 
[    3.677461] DMAR:[fault reason 06] PTE Read access is not set
[    3.690485] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x100)
[    3.696742] ata3.00: revalidation failed (errno=-5)
[    3.701702] systemd[1]: Listening on Journal Socket.
[    3.706683] systemd[1]: Starting System Slice.
[  OK  ] Created slice System Slice.
[    3.715837] systemd[1]: Created slice System Slice.
[    3.720795] systemd[1]: Started dracut ask for additional cmdline parameters.
[    3.728016] systemd[1]: Starting dracut cmdline hook...
         Starting dracut cmdline hook...
[    3.738143] systemd[1]: Starting system-systemd\x2dfsck.slice.
[  OK  ] Created slice system-systemd\x2dfsck.slice.
[    3.754853] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[    3.764945] systemd[1]: Starting Create list of required static device nodes for the current kernel...
         Startin[    3.783966] usb 4-1.1: new high-speed USB device number 3 using ehci-pci
g Create list of required st... nodes for the current kernel...
[    3.799162] systemd[1]: Starting Journal Socket (/dev/log).
[    3.807691] systemd[1]: Starting Slices.
[  OK  ] Reached target Slices.
[    3.820928] systemd[1]: Reached target Slices.
[    3.827320] systemd[1]: Started Load Kernel Modules.
[    3.837299] systemd[1]: Starting Apply Kernel Variables...
         Starting Apply Kernel Variables...
[    3.853225] systemd[1]: Starting Swap.
[  OK  ] Reached target Swap.
[    3.863972] systemd[1]: Reached target Swap.
[    3.870307] systemd[1]: Starting Local File Systems.
[  OK  [    3.880322] usb 4-1.1: New USB device found, idVendor=0424, idProduct=2412
] Reached target[    3.888186] usb 4-1.1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
 Local File Systems.
[    3.900011] systemd[1]: Reached target Local File Systems.
[  OK  ] Started Create[    3.910759] hub 4-1.1:1.0: USB hub found
 list of require[    3.915877] hub 4-1.1:1.0: 2 ports detected
d sta...ce nodes for the current kernel.
[    3.925064] systemd[1]: Started Create list of required static device nodes for the current kernel.
[  OK  ] Started dracut cmdline hook.
[    3.939083] systemd[1]: Started dracut cmdline hook.
[  OK  ] Listening on Journal Socket (/dev/log).
[    3.950118] systemd[1]: Listening on Journal Socket (/dev/log).
[  OK  ] Started Apply Kernel Variables.
[    3.962129] systemd[1]: Started Apply Kernel Variables.
[    3.971875] systemd[1]: Starting Sockets.
[  OK  ] Reached target Sockets.
[    3.980130] systemd[1]: Reached target Sockets.
[    3.984675] systemd[1]: Starting Journal Service...
         Starting Journal Service...
[    3.994543] systemd[1]: Starting dracut pre-udev hook...
[    4.001744] systemd-journald[218]: File /var/log/journal/95212bce02f14a269471981f705ca21f/system.journal corrupted or uncleanly shut down, renaming and replacing.
         Starting dracut pre-udev hook...
[    4.021459] systemd[1]: Starting Create Static Device Nodes in /dev...
         Starting Create Static Device Nodes in /dev...
[  OK  ] Started Create Static Device Nodes in /dev.
[    4.053182] systemd[1]: Started Create Static Device Nodes in /dev.
[  OK  ] Started dracut pre-udev hook.
[    4.091249] systemd[1]: Started dracut pre-udev hook.
[  OK  ] Started Journal Service.
[    4.101278] systemd[1]: Started Journal Service.
         Starting udev Kernel Device Manager...
[  OK  ] Started udev Kernel Device Manager.
         Starting udev Coldplug all Devices...
[  OK  ] Started udev Coldplug all Devices.
         Starting dracut initqueue hook...
[  OK  ] Reached target System Initialization.
[  OK  ] Reached target Basic System.
         Mounting Configuration File System...
[  OK  ] Mounted Configuration File System.
[    4.200477] wmi: Mapper loaded
[    4.203681] usb 4-1.1.1: new low-speed USB device number 4 using ehci-pci
[    4.222406] [drm] Initialized drm 1.1.0 20060810
[    4.240547] isci: Intel(R) C600 SAS Controller Driver - version 1.2.0
[    4.258375] isci 0000:02:00.0: driver configured for rev: 5 silicon
[    4.291419] isci 0000:02:00.0: OEM SAS parameters (version: 1.3) loaded (firmware)
[    4.313180] isci 0000:02:00.0: SCU controller 0: phy 3-0 cables: {short, short, short, short}
[    4.328315] usb 4-1.1.1: New USB device found, idVendor=03f0, idProduct=0324
[    4.335360] usb 4-1.1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.342835] usb 4-1.1.1: Product: HP Basic USB Keyboard
[    4.348057] usb 4-1.1.1: Manufacturer: Lite-On Technology Corp.
[    4.359190] nouveau  [  DEVICE][0000:05:00.0] BOOT0  : 0x0a8c00b1
[    4.365325] nouveau  [  DEVICE][0000:05:00.0] Chipset: GT218 (NVA8)
[    4.371618] nouveau  [  DEVICE][0000:05:00.0] Family : NV50
[    4.384935] input: Lite-On Technology Corp. HP Basic USB Keyboard as /devices/pci0000:00/0000:00:1d.0/usb4/4-1/4-1.1/4-1.1.1/4-1.1.1:1.0/0003:03F0:0324.0001/input5
[    4.404579] scsi host6: isci
[    4.409301] random: nonblocking pool is initialized
[    4.416905] Switched to clocksource tsc
[    4.530384] hid-generic 0003:03F0:0324.0001: input,hidraw0: USB HID v1.10 Keyboard [Lite-On Technology Corp. HP Basic USB Keyboard] on usb-0000:00:1d.0-1.1.1/inpu0
[    4.617826] usb 4-1.1.2: new low-speed USB device number 5 using ehci-pci
[    4.988061] usb 4-1.1.2: New USB device found, idVendor=03f0, idProduct=0b4a
[    4.995136] usb 4-1.1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    5.002619] usb 4-1.1.2: Product: USB Optical Mouse
[    5.007555] usb 4-1.1.2: Manufacturer: Logitech
[    5.040561] input: Logitech USB Optical Mouse as /devices/pci0000:00/0000:00:1d.0/usb4/4-1/4-1.1/4-1.1.2/4-1.1.2:1.0/0003:03F0:0B4A.0002/input/input6
[    5.068488] hid-generic 0003:03F0:0B4A.0002: input,hidraw1: USB HID v1.11 Mouse [Logitech USB Optical Mouse] on usb-0000:00:1d.0-1.1.2/input0
[    5.087326] scsi host7: ata_generic
[    5.098343] scsi host8: ata_generic
[    5.105436] ata7: PATA max UDMA/100 cmd 0xf0b0 ctl 0xf0a0 bmdma 0xf070 irq 18
[    5.112603] ata8: PATA max UDMA/100 cmd 0xf090 ctl 0xf080 bmdma 0xf078 irq 18
[    5.411708] nouveau  [   VBIOS][0000:05:00.0] using image from PRAMIN
[    5.418722] nouveau  [   VBIOS][0000:05:00.0] BIT signature found
[    5.424818] nouveau  [   VBIOS][0000:05:00.0] version 70.18.89.00.02
[    5.469015] nouveau  [     PMC][0000:05:00.0] MSI interrupts enabled
[    5.476719] pps_core: LinuxPPS API ver. 1 registered
[    5.481675] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    5.499853] nouveau  [     PFB][0000:05:00.0] RAM type: DDR3
[    5.505527] nouveau  [     PFB][0000:05:00.0] RAM size: 512 MiB
[    5.511451] nouveau  [     PFB][0000:05:00.0]    ZCOMP: 960 tags
[    5.542850] PTP clock support registered
[    5.596306] nouveau  [    VOLT][0000:05:00.0] GPU voltage: 900000uv
[    5.655578] e1000e: Intel(R) PRO/1000 Network Driver - 2.3.2-k
[    5.661411] e1000e: Copyright(c) 1999 - 2014 Intel Corporation.
[    5.692267] e1000e 0000:00:19.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    5.708902] nouveau  [  PTHERM][0000:05:00.0] FAN control: none / external
[    5.715826] nouveau  [  PTHERM][0000:05:00.0] fan management: automatic
[    5.722450] nouveau  [  PTHERM][0000:05:00.0] internal sensor: yes
[    5.801093] nouveau  [     CLK][0000:05:00.0] 03: core 135 MHz shader 270 MHz memory 135 MHz
[    5.828131] nouveau  [     CLK][0000:05:00.0] 07: core 405 MHz shader 810 MHz memory 405 MHz
[    5.846134] nouveau  [     CLK][0000:05:00.0] 0f: core 520 MHz shader 1230 MHz memory 790 MHz
[    5.854747] nouveau  [     CLK][0000:05:00.0] --: core 405 MHz shader 810 MHz memory 405 MHz
[    5.901174] [TTM] Zone  kernel: Available graphics memory: 119828 kiB
[    5.907609] [TTM] Initializing pool allocator
[    5.921188] [TTM] Initializing DMA pool allocator
[    5.928128] nouveau  [     DRM] VRAM: 512 MiB
[    5.932490] nouveau  [     DRM] GART: 1048576 MiB
[    5.937198] nouveau  [     DRM] TMDS table version 2.0
[    5.942326] nouveau  [     DRM] DCB version 4.0
[    5.946860] nouveau  [     DRM] DCB outp 00: 02000360 00000000
[    5.952683] nouveau  [     DRM] DCB outp 01: 02000362 00020010
[    5.958511] nouveau  [     DRM] DCB outp 02: 028003a6 0f220010
[    5.964349] nouveau  [     DRM] DCB outp 03: 01011380 00000000
[    5.970169] nouveau  [     DRM] DCB outp 04: 08011382 00020010
[    5.975991] nouveau  [     DRM] DCB outp 05: 088113c6 0f220010
[    5.981821] nouveau  [     DRM] DCB conn 00: 00101064
[    5.986897] nouveau  [     DRM] DCB conn 01: 00202165
[    6.012149] nouveau E[   PDISP][0000:05:00.0] UNK01 [UNK02] chid 0 mthd 0x0000 data 0x00000400
[    6.020748] nouveau E[   PDISP][0000:05:00.0] UNK01 [UNK02] chid 1 mthd 0x0000 data 0x00000400
[    6.042493] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    6.049104] [drm] Driver supports precise vblank timestamp query.
[    6.085985] nouveau  [     DRM] MM: using COPY for buffer copies
[    6.122810] e1000e 0000:00:19.0 eth0: registered PHC clock
[    6.128296] e1000e 0000:00:19.0 eth0: (PCI Express:2.5GT/s:Width x1) 80:c1:6e:f8:9f:92
[    6.136193] e1000e 0000:00:19.0 eth0: Intel(R) PRO/1000 Network Connection
[    6.145426] e1000e 0000:00:19.0 eth0: MAC: 10, PHY: 11, PBA No: 0100FF-0FF
[    6.242421] tulip: Linux Tulip driver version 1.1.15 (Feb 27, 2007)
[    6.253721] tulip: tulip_init_one: Enabled WOL support for AN983B
[    6.261665] tulip0:  MII transceiver #1 config 1000 status 786d advertising 05e1
[    6.278694] net eth1: ADMtek Comet rev 17 at MMIO 0xd7121000, 00:b0:c0:06:70:90, IRQ 20
[    6.349682] firewire_ohci 0000:09:05.0: added OHCI v1.0 device as card 0, 8 IR + 8 IT contexts, quirks 0x0
[  OK  ] Found device WDC_WD10EALX-609BA0 1.
[    6.860267] firewire_core 0000:09:05.0: created device fw0: GUID 0060b000008cec98, S400
[    8.676219] ata3: hard resetting link
[    8.984562] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    8.995356] ata3.00: configured for UDMA/100
[    8.999897] ata3: EH complete
[    9.352568] e1000e 0000:00:19.0 eno1: renamed from eth0
[    9.363102] tulip 0000:09:04.0 enp9s4: renamed from eth1
[    9.374412] iTCO_vendor_support: vendor-support=0
[    9.380595] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[    9.386231] iTCO_wdt: unable to reset NO_REBOOT flag, device disabled by hardware/BIOS
[   10.153286] nouveau  [     DRM] allocated 1920x1080 fb: 0x70000, bo ffff880032afd400
[   10.161103] fbcon: nouveaufb (fb0) is primary device
[   18.218368] Console: switching to colour frame buffer device 240x67
[   18.232823] nouveau 0000:05:00.0: fb0: nouveaufb frame buffer device
[   18.239186] nouveau 0000:05:00.0: registered panic notifier
[   18.244950] [drm] Initialized nouveau 1.2.2 20120801 for 0000:05:00.0 on minor 0
[  OK  ] Found device /dev/mapper/fedora_dhcp--128--28-swap.
[  OK  ] Found device /dev/mapper/fedora_dhcp--128--28-root.
         Starting File System Check on /dev/mapper/fedora_dhcp--128--28-root...
[  OK  ] Started dracut initqueue hook.
[  OK  ] Reached target Remote File Systems (Pre).
[  OK  ] Reached target Remote File Systems.
[   17.574332] systemd-fsck[361]: /dev/mapper/fedora_dhcp--128--28-root: recovering journal
[   19.639716] systemd-fsck[361]: /dev/mapper/fedora_dhcp--128--28-root: Clearing orphaned inode 1705150 (uid=42, gid=42, mode=0100644, size=451)
[   19.648774] systemd-fsck[361]: /dev/mapper/fedora_dhcp--128--28-root: clean, 162324/19660800 files, 9598778/78643200 blocks
[  OK  ] Started File System Check on /dev/mapper/fedora_dhcp--128--28-root.
         Mounting /sysroot...
[   22.093146] EXT4-fs (dm-1): mounted filesystem with ordered data mode. Opts: (null)
[  OK  ] Mounted /sysroot.
[  OK  ] Reached target Initrd Root File System.
         Starting Reload Configuration from the Real Root...
[  OK  ] Started Reload Configuration from the Real Root.
[  OK  ] Reached target Initrd File Systems.
[  OK  ] Reached target Initrd Default Target.
         Starting dracut pre-pivot and cleanup hook...
[  OK  ] Started dracut pre-pivot and cleanup hook.
         Starting Kdump Vmcore Save Service...
kdump: dump target is /dev/mapper/fedora_dhcp--128--28-root
kdu[   22.464100] EXT4-fs (dm-1): re-mounted. Opts: data=ordered
mp: saving to /sysroot//var/crash/127.0.0.1-2015.04.29-18:37:24/
kdump: saving vmcore-dmesg.txt
kdump: saving vmcore-dmesg.txt complete
kdump: saving vmcore
Copying data                       : [100.0 %] |
kdump: saving vmcore complete
[  OK  ] Stopped target Timers.
[  OK  ] Removed slice system-systemd\x2dfsck.slice.
         Stopping Kdump Vmcore Save Service...
[  OK  ] Stopped Kdump Vmcore Save Service.
         Stopping dracut pre-pivot and cleanup hook...
[  OK  ] Stopped dracut pre-pivot and cleanup hook.
[  OK  ] Stopped target Remote File Systems.
[  OK  ] Stopped target Remote File Systems (Pre).
[  OK  ] Stopped target Initrd Default Target.
[  OK  ] Stopped target Basic System.
[  OK  ] Stopped targ[   24.137096] systemd-shutdown[1]: Sending SIGTERM to remaining processes...
et Slices.
[  OK  ] Removed slice -.slice.
[  OK[   24.148896] systemd-journald[218]: Received SIGTERM from PID 1 (systemd-shutdow).
  ] Stopped target Paths.
[[   24.159738] systemd-shutdown[1]: Sending SIGKILL to remaining processes...
  OK  ] Stopped target Sockets.
[[   24.170398] systemd-shutdown[1]: Unmounting file systems.
  OK  ] Stopped target System Initialization.
         Stopping Apply Kernel Variables...
[  OK  ] Stopped Apply Kernel Variables.
         Stopping Create Static Device Nodes in /dev...
[  OK  ] Stopped Create Static Device Nodes in /dev.
[  OK  ] Reached target Shutdown.
[  OK  ] Stopped target Swap.
[[   24.206037] EXT4-fs (dm-1): re-mounted. Opts: (null)
  OK  ][   24.212563] systemd-shutdown[1]: Unmounting /sysroot.
 Stopped target Local File Systems.
[  OK  ] Stopped target Initrd File Systems.
[  OK  ] Stopped target Initrd Root File System.
         Starting Cleaning Up and Shuttin[   24.234371] systemd-shutdown[1]: Unmounting /sys/kernel/config.
g Down Daemons..[   24.241384] systemd-shutdown[1]: All filesystems unmounted.
.
         Unmo[   24.248331] systemd-shutdown[1]: Deactivating swaps.
unting /sysroot.[   24.254699] systemd-shutdown[1]: All swaps deactivated.
..
[  OK  [   24.261243] systemd-shutdown[1]: Detaching loop devices.
] Failed unm[   24.268025] systemd-shutdown[1]: All loop devices detached.
ounting /sysroot[   24.274885] systemd-shutdown[1]: Detaching DM devices.
.
[FAILE[   24.281552] systemd-shutdown[1]: Detaching DM 253:1.
D] Failed to[   24.287950] systemd-shutdown[1]: Detaching DM 253:0.
 start Cleaning [   24.294232] systemd-shutdown[1]: All DM devices detached.
Up and Shutting [   24.301110] systemd-shutdown[1]: Rebooting.
Down Daemons.
S[   24.306513] sd 0:0:0:0: [sda] Synchronizing SCSI cache
ee "systemctl status initrd-cleanup.service" for[   24.316241] e1000e: EEE TX LPI TIMER: 00000011
 details.
[  OK  ] Reached target Unmount All Filesystems.
[  OK  ] Reached target Final Step.
         Starting Reboot...
[   24.376843] reboot: Restarting system
[   24.380516] reboot: machine restart

--DocE+STaALJfprDB--
