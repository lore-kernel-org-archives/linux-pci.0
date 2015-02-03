Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from resqmta-po-04v.sys.comcast.net ([96.114.154.163]:40662 "EHLO
	resqmta-po-04v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932702AbbBCX6s (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Feb 2015 18:58:48 -0500
Message-ID: <54D160B5.70006@nwtrail.com>
Date: Tue, 03 Feb 2015 15:58:45 -0800
From: Paul Johnson <pjay@nwtrail.com>
Reply-To: pjay@nwtrail.com
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [problem] mpt2sas load fails with LSISAS2008
References: <54C81B4E.7060900@nwtrail.com>	<CAErSpo6P-gm1xFjLrbKBU+P3zUHY-RGMkhaVpWsK7vDz_wK=YQ@mail.gmail.com>	<54CBB062.4040801@nwtrail.com>	<CAE9FiQUxD8g4KG9CYe1znb5Lw5skkq=9QSOgkmGUDbhsaDq2Qw@mail.gmail.com>	<54CFBC0E.4080102@nwtrail.com> <CAE9FiQUT5j1PDw5c0X-k_E+0TbwCdrX1nbqk8rKzxAKxRLqvEg@mail.gmail.com>
In-Reply-To: <CAE9FiQUT5j1PDw5c0X-k_E+0TbwCdrX1nbqk8rKzxAKxRLqvEg@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------040609080505020401020909"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------040609080505020401020909
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 02/02/2015 02:30 PM, Yinghai Lu wrote:
> On Mon, Feb 2, 2015 at 10:03 AM, Paul Johnson <pjay@nwtrail.com> wrote:
>> I applied the patch but, unfortunately, the problem is still there. dmesg is
>> attached.
>
> ok. please check attached patch that will disable auto realloc.
>
> Thanks
>
> Yinghai
>
This patch worked. In case you have a need, the dmesg is attached.
Thanks
Paul


--------------040609080505020401020909
Content-Type: text/plain; charset=UTF-8;
 name="dmesg-3.19.0-rc6-patch02"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg-3.19.0-rc6-patch02"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.19.0-rc6-patch02 (paulj@x1404ubu64) (gcc version 4.8.2 (Ubuntu 4.8.2-19ubuntu1) ) #5 SMP Mon Feb 2 15:57:50 PST 2015
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-3.19.0-rc6-patch02 root=UUID=f604b748-aeb8-4e3d-953f-b5a8b947c191 ro debug ignore_loglevel
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009c7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f800-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000ef7dffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000ef7e0000-0x00000000ef7e1fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000ef7e2000-0x00000000ef7effff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000ef7f0000-0x00000000ef7fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f4000000-0x00000000f7ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000040fffffff] usable
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.4 present.
[    0.000000] DMI: Gigabyte Technology Co., Ltd. P55-UD3L/P55-UD3L, BIOS F7 06/23/2010
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] AGP: No AGP bridge found
[    0.000000] e820: last_pfn = 0x410000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-C7FFF write-protect
[    0.000000]   C8000-EFFFF uncachable
[    0.000000]   F0000-FFFFF write-through
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask F00000000 write-back
[    0.000000]   1 base 0F0000000 mask FF0000000 uncachable
[    0.000000]   2 base 100000000 mask F00000000 write-back
[    0.000000]   3 base 200000000 mask E00000000 write-back
[    0.000000]   4 base 300000000 mask F00000000 write-back
[    0.000000]   5 base 400000000 mask FF0000000 write-back
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] PAT configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- UC  
[    0.000000] original variable MTRRs
[    0.000000] reg 0, base: 0GB, range: 4GB, type WB
[    0.000000] reg 1, base: 3840MB, range: 256MB, type UC
[    0.000000] reg 2, base: 4GB, range: 4GB, type WB
[    0.000000] reg 3, base: 8GB, range: 8GB, type WB
[    0.000000] reg 4, base: 12GB, range: 4GB, type WB
[    0.000000] reg 5, base: 16GB, range: 256MB, type WB
[    0.000000] total RAM covered: 16384M
[    0.000000] Found optimal setting for mtrr clean up
[    0.000000]  gran_size: 64K 	chunk_size: 512M 	num_reg: 6  	lose cover RAM: 0G
[    0.000000] New variable MTRRs
[    0.000000] reg 0, base: 0GB, range: 4GB, type WB
[    0.000000] reg 1, base: 3840MB, range: 256MB, type UC
[    0.000000] reg 2, base: 4GB, range: 4GB, type WB
[    0.000000] reg 3, base: 8GB, range: 8GB, type WB
[    0.000000] reg 4, base: 16GB, range: 512MB, type WB
[    0.000000] reg 5, base: 16640MB, range: 256MB, type UC
[    0.000000] e820: update [mem 0xf0000000-0xffffffff] usable ==> reserved
[    0.000000] e820: last_pfn = 0xef7e0 max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000f55c0-0x000f55cf] mapped at [ffff8800000f55c0]
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [ffff880000096000] 96000 size 24576
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] BRK [0x01f2b000, 0x01f2bfff] PGTABLE
[    0.000000] BRK [0x01f2c000, 0x01f2cfff] PGTABLE
[    0.000000] BRK [0x01f2d000, 0x01f2dfff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x40fe00000-0x40fffffff]
[    0.000000]  [mem 0x40fe00000-0x40fffffff] page 2M
[    0.000000] BRK [0x01f2e000, 0x01f2efff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x400000000-0x40fdfffff]
[    0.000000]  [mem 0x400000000-0x40fdfffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x3e0000000-0x3ffffffff]
[    0.000000]  [mem 0x3e0000000-0x3ffffffff] page 2M
[    0.000000] BRK [0x01f2f000, 0x01f2ffff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x00100000-0xef7dffff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0xef5fffff] page 2M
[    0.000000]  [mem 0xef600000-0xef7dffff] page 4k
[    0.000000] init_memory_mapping: [mem 0x100000000-0x3dfffffff]
[    0.000000]  [mem 0x100000000-0x3dfffffff] page 2M
[    0.000000] BRK [0x01f30000, 0x01f30fff] PGTABLE
[    0.000000] RAMDISK: [mem 0x36286000-0x3713afff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F6F80 000014 (v00 GBT   )
[    0.000000] ACPI: RSDT 0x00000000EF7E2040 000040 (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
[    0.000000] ACPI: FACP 0x00000000EF7E20C0 000074 (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
[    0.000000] ACPI: DSDT 0x00000000EF7E2180 00529E (v01 GBT    GBTUACPI 00001000 MSFT 0100000C)
[    0.000000] ACPI: FACS 0x00000000EF7E0000 000040
[    0.000000] ACPI: HPET 0x00000000EF7E7580 000038 (v01 GBT    GBTUACPI 42302E31 GBTU 00000098)
[    0.000000] ACPI: MCFG 0x00000000EF7E7600 00003C (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
[    0.000000] ACPI: EUDS 0x00000000EF7E7640 000560 (v01 GBT             00000000      00000000)
[    0.000000] ACPI: TAMG 0x00000000EF7E7BA0 000892 (v01 GBT    GBT   B0 5455312E BG?? 53450101)
[    0.000000] ACPI: APIC 0x00000000EF7E7480 0000BC (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
[    0.000000] ACPI: SSDT 0x00000000EF7E8440 0036C4 (v01 INTEL  PPM RCM  80000001 INTL 20061109)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000040fffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x40ffee000-0x40fff1fff]
[    0.000000]  [ffffea0000000000-ffffea00103fffff] PMD -> [ffff8803ff600000-ffff88040f5fffff] on node 0
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00001000-0x00ffffff]
[    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
[    0.000000]   Normal   [mem 0x100000000-0x40fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00001000-0x0009bfff]
[    0.000000]   node   0: [mem 0x00100000-0xef7dffff]
[    0.000000]   node   0: [mem 0x100000000-0x40fffffff]
[    0.000000] Initmem setup node 0 [mem 0x00001000-0x40fffffff]
[    0.000000] On node 0 totalpages: 4192123
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3995 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 15264 pages used for memmap
[    0.000000]   DMA32 zone: 976864 pages, LIFO batch:31
[    0.000000]   Normal zone: 50176 pages used for memmap
[    0.000000]   Normal zone: 3211264 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x04] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x06] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x05] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x07] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x05] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x06] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x07] dfl dfl lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009c000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.000000] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xef7e0000-0xef7e1fff]
[    0.000000] PM: Registered nosave memory: [mem 0xef7e2000-0xef7effff]
[    0.000000] PM: Registered nosave memory: [mem 0xef7f0000-0xef7fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xef800000-0xf3ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf4000000-0xf7ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf8000000-0xfebfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xffffffff]
[    0.000000] e820: [mem 0xf8000000-0xfebfffff] available for PCI devices
[    0.000000] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256 nr_cpu_ids:8 nr_node_ids:1
[    0.000000] PERCPU: Embedded 29 pages/cpu @ffff88040fc00000 s81280 r8192 d29312 u262144
[    0.000000] pcpu-alloc: s81280 r8192 d29312 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 4126598
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-3.19.0-rc6-patch02 root=UUID=f604b748-aeb8-4e3d-953f-b5a8b947c191 ro debug ignore_loglevel
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] AGP: Checking aperture...
[    0.000000] AGP: No AGP bridge found
[    0.000000] Memory: 16408348K/16768492K available (6803K kernel code, 1055K rwdata, 3272K rodata, 1212K init, 940K bss, 360144K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=8.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.000000] NR_IRQS:16640 nr_irqs:488 16
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2797.917 MHz processor
[    0.000025] Calibrating delay loop (skipped), value calculated using timer frequency.. 5595.83 BogoMIPS (lpj=11191668)
[    0.000030] pid_max: default: 32768 minimum: 301
[    0.000035] ACPI: Core revision 20141107
[    0.003962] ACPI: All ACPI Tables successfully acquired
[    0.007095] Security Framework initialized
[    0.007109] AppArmor: AppArmor initialized
[    0.007955] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    0.010962] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.012361] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.012380] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.012622] Initializing cgroup subsys devices
[    0.012627] Initializing cgroup subsys freezer
[    0.012630] Initializing cgroup subsys net_cls
[    0.012633] Initializing cgroup subsys blkio
[    0.012636] Initializing cgroup subsys perf_event
[    0.012652] CPU: Physical Processor ID: 0
[    0.012654] CPU: Processor Core ID: 0
[    0.012658] mce: CPU supports 9 MCE banks
[    0.012667] CPU0: Thermal monitoring enabled (TM1)
[    0.012676] Last level iTLB entries: 4KB 512, 2MB 7, 4MB 7
[    0.012676] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    0.012748] Freeing SMP alternatives memory: 24K (ffffffff81e38000 - ffffffff81e3e000)
[    0.012753] ftrace: allocating 26471 entries in 104 pages
[    0.023874] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.063561] smpboot: CPU0: Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz (fam: 06, model: 1e, stepping: 05)
[    0.169465] Performance Events: PEBS fmt1+, 16-deep LBR, Nehalem events, Intel PMU driver.
[    0.169481] perf_event_intel: CPU erratum AAJ80 worked around
[    0.169483] perf_event_intel: CPUID marked event: 'bus cycles' unavailable
[    0.169486] ... version:                3
[    0.169487] ... bit width:              48
[    0.169488] ... generic registers:      4
[    0.169490] ... value mask:             0000ffffffffffff
[    0.169492] ... max period:             000000007fffffff
[    0.169493] ... fixed-purpose events:   3
[    0.169495] ... event mask:             000000070000000f
[    0.169997] x86: Booting SMP configuration:
[    0.170000] .... node  #0, CPUs:      #1
[    0.183219] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.183292]  #2 #3 #4 #5 #6 #7
[    0.262291] x86: Booted up 1 node, 8 CPUs
[    0.262296] smpboot: Total of 8 processors activated (44766.67 BogoMIPS)
[    0.267107] devtmpfs: initialized
[    0.271353] evm: security.selinux
[    0.271356] evm: security.SMACK64
[    0.271357] evm: security.capability
[    0.271399] PM: Registering ACPI NVS region [mem 0xef7e0000-0xef7e1fff] (8192 bytes)
[    0.271599] RTC time: 19:15:37, date: 02/03/15
[    0.271685] NET: Registered protocol family 16
[    0.281459] cpuidle: using governor ladder
[    0.291138] cpuidle: using governor menu
[    0.291191] ACPI: bus type PCI registered
[    0.291194] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.291259] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf4000000-0xf7ffffff] (base 0xf4000000)
[    0.291263] PCI: MMCONFIG at [mem 0xf4000000-0xf7ffffff] reserved in E820
[    0.291319] PCI: Using configuration type 1 for base access
[    0.300741] ACPI: Added _OSI(Module Device)
[    0.300744] ACPI: Added _OSI(Processor Device)
[    0.300745] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.300747] ACPI: Added _OSI(Processor Aggregator Device)
[    0.304891] ACPI: Interpreter enabled
[    0.304897] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_] (20141107/hwxface-580)
[    0.304902] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20141107/hwxface-580)
[    0.304914] ACPI: (supports S0 S3 S4 S5)
[    0.304916] ACPI: Using IOAPIC for interrupt routing
[    0.304936] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.308340] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3f])
[    0.308347] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.308352] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.308532] PCI host bridge to bus 0000:00
[    0.308536] pci_bus 0000:00: root bus resource [bus 00-3f]
[    0.308538] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
[    0.308541] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
[    0.308543] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
[    0.308546] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff]
[    0.308548] pci_bus 0000:00: root bus resource [mem 0xef800000-0xfebfffff]
[    0.308557] pci 0000:00:00.0: [8086:d131] type 00 class 0x060000
[    0.308651] pci 0000:00:03.0: [8086:d138] type 01 class 0x060400
[    0.308701] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    0.308763] pci 0000:00:08.0: [8086:d155] type 00 class 0x088000
[    0.308848] pci 0000:00:08.1: [8086:d156] type 00 class 0x088000
[    0.308933] pci 0000:00:08.2: [8086:d157] type 00 class 0x088000
[    0.309016] pci 0000:00:08.3: [8086:d158] type 00 class 0x088000
[    0.309093] pci 0000:00:10.0: [8086:d150] type 00 class 0x088000
[    0.309166] pci 0000:00:10.1: [8086:d151] type 00 class 0x088000
[    0.309253] pci 0000:00:1a.0: [8086:3b3b] type 00 class 0x0c0300
[    0.309292] pci 0000:00:1a.0: reg 0x20: [io  0xff00-0xff1f]
[    0.309357] pci 0000:00:1a.0: System wakeup disabled by ACPI
[    0.309390] pci 0000:00:1a.1: [8086:3b3e] type 00 class 0x0c0300
[    0.309429] pci 0000:00:1a.1: reg 0x20: [io  0xfe00-0xfe1f]
[    0.309497] pci 0000:00:1a.1: System wakeup disabled by ACPI
[    0.309531] pci 0000:00:1a.2: [8086:3b3f] type 00 class 0x0c0300
[    0.309570] pci 0000:00:1a.2: reg 0x20: [io  0xfd00-0xfd1f]
[    0.309634] pci 0000:00:1a.2: System wakeup disabled by ACPI
[    0.309674] pci 0000:00:1a.7: [8086:3b3c] type 00 class 0x0c0320
[    0.309695] pci 0000:00:1a.7: reg 0x10: [mem 0xfbfff000-0xfbfff3ff]
[    0.309778] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.309814] pci 0000:00:1a.7: System wakeup disabled by ACPI
[    0.309852] pci 0000:00:1b.0: [8086:3b56] type 00 class 0x040300
[    0.309868] pci 0000:00:1b.0: reg 0x10: [mem 0xfbff8000-0xfbffbfff 64bit]
[    0.309936] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.309972] pci 0000:00:1b.0: System wakeup disabled by ACPI
[    0.310005] pci 0000:00:1c.0: [8086:3b42] type 01 class 0x060400
[    0.310072] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.310110] pci 0000:00:1c.0: System wakeup disabled by ACPI
[    0.310143] pci 0000:00:1c.1: [8086:3b44] type 01 class 0x060400
[    0.310210] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.310246] pci 0000:00:1c.1: System wakeup disabled by ACPI
[    0.310285] pci 0000:00:1d.0: [8086:3b36] type 00 class 0x0c0300
[    0.310324] pci 0000:00:1d.0: reg 0x20: [io  0xfc00-0xfc1f]
[    0.310387] pci 0000:00:1d.0: System wakeup disabled by ACPI
[    0.310421] pci 0000:00:1d.1: [8086:3b37] type 00 class 0x0c0300
[    0.310460] pci 0000:00:1d.1: reg 0x20: [io  0xfb00-0xfb1f]
[    0.310524] pci 0000:00:1d.1: System wakeup disabled by ACPI
[    0.310557] pci 0000:00:1d.2: [8086:3b38] type 00 class 0x0c0300
[    0.310596] pci 0000:00:1d.2: reg 0x20: [io  0xfa00-0xfa1f]
[    0.310659] pci 0000:00:1d.2: System wakeup disabled by ACPI
[    0.310692] pci 0000:00:1d.3: [8086:3b39] type 00 class 0x0c0300
[    0.310730] pci 0000:00:1d.3: reg 0x20: [io  0xf900-0xf91f]
[    0.310794] pci 0000:00:1d.3: System wakeup disabled by ACPI
[    0.310835] pci 0000:00:1d.7: [8086:3b34] type 00 class 0x0c0320
[    0.310856] pci 0000:00:1d.7: reg 0x10: [mem 0xfbffe000-0xfbffe3ff]
[    0.310940] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.310977] pci 0000:00:1d.7: System wakeup disabled by ACPI
[    0.311010] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
[    0.311082] pci 0000:00:1e.0: System wakeup disabled by ACPI
[    0.311118] pci 0000:00:1f.0: [8086:3b02] type 00 class 0x060100
[    0.311274] pci 0000:00:1f.2: [8086:3b22] type 00 class 0x010601
[    0.311292] pci 0000:00:1f.2: reg 0x10: [io  0xf800-0xf807]
[    0.311300] pci 0000:00:1f.2: reg 0x14: [io  0xf700-0xf703]
[    0.311307] pci 0000:00:1f.2: reg 0x18: [io  0xf600-0xf607]
[    0.311315] pci 0000:00:1f.2: reg 0x1c: [io  0xf500-0xf503]
[    0.311322] pci 0000:00:1f.2: reg 0x20: [io  0xf400-0xf41f]
[    0.311330] pci 0000:00:1f.2: reg 0x24: [mem 0xfbffd000-0xfbffd7ff]
[    0.311373] pci 0000:00:1f.2: PME# supported from D3hot
[    0.311436] pci 0000:00:1f.3: [8086:3b30] type 00 class 0x0c0500
[    0.311451] pci 0000:00:1f.3: reg 0x10: [mem 0xfbffc000-0xfbffc0ff 64bit]
[    0.311470] pci 0000:00:1f.3: reg 0x20: [io  0x0500-0x051f]
[    0.311578] pci 0000:01:00.0: [1000:0072] type 00 class 0x010700
[    0.311589] pci 0000:01:00.0: reg 0x10: [io  0xce00-0xceff]
[    0.311599] pci 0000:01:00.0: reg 0x14: [mem 0xfbdfc000-0xfbdfffff 64bit]
[    0.311609] pci 0000:01:00.0: reg 0x1c: [mem 0xfbd80000-0xfbdbffff 64bit]
[    0.311620] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[    0.311662] pci 0000:01:00.0: supports D1 D2
[    0.311684] pci 0000:01:00.0: reg 0x174: [mem 0x00000000-0x00003fff 64bit]
[    0.311693] pci 0000:01:00.0: reg 0x17c: [mem 0x00000000-0x0003ffff 64bit]
[    0.317465] pci 0000:00:03.0: PCI bridge to [bus 01]
[    0.317469] pci 0000:00:03.0:   bridge window [io  0xc000-0xcfff]
[    0.317472] pci 0000:00:03.0:   bridge window [mem 0xfbd00000-0xfbdfffff]
[    0.317552] pci 0000:02:00.0: [197b:2363] type 00 class 0x010601
[    0.317639] pci 0000:02:00.0: reg 0x24: [mem 0xfbcfe000-0xfbcfffff]
[    0.317707] pci 0000:02:00.0: PME# supported from D3hot
[    0.317767] pci 0000:02:00.1: [197b:2363] type 00 class 0x010185
[    0.317791] pci 0000:02:00.1: reg 0x10: [io  0xef00-0xef07]
[    0.317804] pci 0000:02:00.1: reg 0x14: [io  0xee00-0xee03]
[    0.317818] pci 0000:02:00.1: reg 0x18: [io  0xed00-0xed07]
[    0.317831] pci 0000:02:00.1: reg 0x1c: [io  0xec00-0xec03]
[    0.317844] pci 0000:02:00.1: reg 0x20: [io  0xeb00-0xeb0f]
[    0.317950] pci 0000:02:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.317960] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.317964] pci 0000:00:1c.0:   bridge window [io  0xe000-0xefff]
[    0.317968] pci 0000:00:1c.0:   bridge window [mem 0xfbc00000-0xfbcfffff]
[    0.318034] pci 0000:03:00.0: [10ec:8168] type 00 class 0x020000
[    0.318053] pci 0000:03:00.0: reg 0x10: [io  0xde00-0xdeff]
[    0.318080] pci 0000:03:00.0: reg 0x18: [mem 0xfbeff000-0xfbefffff 64bit pref]
[    0.318098] pci 0000:03:00.0: reg 0x20: [mem 0xfbef8000-0xfbefbfff 64bit pref]
[    0.318110] pci 0000:03:00.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    0.318188] pci 0000:03:00.0: supports D1 D2
[    0.318190] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.325469] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.325473] pci 0000:00:1c.1:   bridge window [io  0xd000-0xdfff]
[    0.325477] pci 0000:00:1c.1:   bridge window [mem 0xfbb00000-0xfbbfffff]
[    0.325483] pci 0000:00:1c.1:   bridge window [mem 0xfbe00000-0xfbefffff 64bit pref]
[    0.325524] pci 0000:04:04.0: [102b:051b] type 00 class 0x030000
[    0.325538] pci 0000:04:04.0: reg 0x10: [mem 0xf9000000-0xf9ffffff pref]
[    0.325547] pci 0000:04:04.0: reg 0x14: [mem 0xfb7fc000-0xfb7fffff]
[    0.325557] pci 0000:04:04.0: reg 0x18: [mem 0xfa800000-0xfaffffff]
[    0.325587] pci 0000:04:04.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    0.325653] pci 0000:00:1e.0: PCI bridge to [bus 04] (subtractive decode)
[    0.325659] pci 0000:00:1e.0:   bridge window [mem 0xfa800000-0xfb7fffff]
[    0.325665] pci 0000:00:1e.0:   bridge window [mem 0xf9000000-0xf9ffffff 64bit pref]
[    0.325668] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7] (subtractive decode)
[    0.325671] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff] (subtractive decode)
[    0.325674] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
[    0.325677] pci 0000:00:1e.0:   bridge window [mem 0x000c0000-0x000dffff] (subtractive decode)
[    0.325680] pci 0000:00:1e.0:   bridge window [mem 0xef800000-0xfebfffff] (subtractive decode)
[    0.326129] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
[    0.326173] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[    0.326214] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
[    0.326256] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 *12 14 15)
[    0.326298] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    0.326340] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 *6 7 9 10 11 12 14 15)
[    0.326382] ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
[    0.326424] ACPI: PCI Interrupt Link [LNK1] (IRQs *3 4 5 6 7 9 10 11 12 14 15)
[    0.326555] vgaarb: setting as boot device: PCI:0000:04:04.0
[    0.326559] vgaarb: device added: PCI:0000:04:04.0,decodes=io+mem,owns=io+mem,locks=none
[    0.326561] vgaarb: loaded
[    0.326563] vgaarb: bridge control possible 0000:04:04.0
[    0.326715] SCSI subsystem initialized
[    0.326748] libata version 3.00 loaded.
[    0.326770] ACPI: bus type USB registered
[    0.326785] usbcore: registered new interface driver usbfs
[    0.326794] usbcore: registered new interface driver hub
[    0.326813] usbcore: registered new device driver usb
[    0.326909] PCI: Using ACPI for IRQ routing
[    0.328202] PCI: Discovered peer bus 3f
[    0.328204] PCI: root bus 3f: using default resources
[    0.328206] PCI: Probing PCI hardware (bus 3f)
[    0.328228] PCI host bridge to bus 0000:3f
[    0.328231] pci_bus 0000:3f: root bus resource [io  0x0000-0xffff]
[    0.328234] pci_bus 0000:3f: root bus resource [mem 0x00000000-0xfffffffff]
[    0.328236] pci_bus 0000:3f: No busn resource found for root bus, will use [bus 3f-ff]
[    0.328240] pci_bus 0000:3f: busn_res: can not insert [bus 3f-ff] under domain [bus 00-ff] (conflicts with (null) [bus 00-3f])
[    0.328246] pci 0000:3f:00.0: [8086:2c51] type 00 class 0x060000
[    0.328283] pci 0000:3f:00.1: [8086:2c81] type 00 class 0x060000
[    0.328320] pci 0000:3f:02.0: [8086:2c90] type 00 class 0x060000
[    0.328354] pci 0000:3f:02.1: [8086:2c91] type 00 class 0x060000
[    0.328390] pci 0000:3f:03.0: [8086:2c98] type 00 class 0x060000
[    0.328424] pci 0000:3f:03.1: [8086:2c99] type 00 class 0x060000
[    0.328458] pci 0000:3f:03.4: [8086:2c9c] type 00 class 0x060000
[    0.328493] pci 0000:3f:04.0: [8086:2ca0] type 00 class 0x060000
[    0.328528] pci 0000:3f:04.1: [8086:2ca1] type 00 class 0x060000
[    0.328563] pci 0000:3f:04.2: [8086:2ca2] type 00 class 0x060000
[    0.328597] pci 0000:3f:04.3: [8086:2ca3] type 00 class 0x060000
[    0.328633] pci 0000:3f:05.0: [8086:2ca8] type 00 class 0x060000
[    0.328667] pci 0000:3f:05.1: [8086:2ca9] type 00 class 0x060000
[    0.328702] pci 0000:3f:05.2: [8086:2caa] type 00 class 0x060000
[    0.328736] pci 0000:3f:05.3: [8086:2cab] type 00 class 0x060000
[    0.328780] pci_bus 0000:3f: busn_res: [bus 3f-ff] end is updated to 3f
[    0.328784] pci_bus 0000:3f: busn_res: can not insert [bus 3f] under domain [bus 00-ff] (conflicts with (null) [bus 00-3f])
[    0.328788] PCI: pci_cache_line_size set to 64 bytes
[    0.328856] e820: reserve RAM buffer [mem 0x0009c800-0x0009ffff]
[    0.328858] e820: reserve RAM buffer [mem 0xef7e0000-0xefffffff]
[    0.328947] NetLabel: Initializing
[    0.328949] NetLabel:  domain hash size = 128
[    0.328950] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.328962] NetLabel:  unlabeled traffic allowed by default
[    0.329022] HPET: 8 timers in total, 5 timers will be used for per-cpu timer
[    0.329029] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 24, 25, 26, 27, 28, 0
[    0.329035] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.331072] hpet: hpet2 irq 24 for MSI
[    0.331107] hpet: hpet3 irq 25 for MSI
[    0.331146] hpet: hpet4 irq 26 for MSI
[    0.331185] hpet: hpet5 irq 27 for MSI
[    0.331221] hpet: hpet6 irq 28 for MSI
[    0.331313] Switched to clocksource hpet
[    0.335498] AppArmor: AppArmor Filesystem Enabled
[    0.335546] pnp: PnP ACPI init
[    0.335674] system 00:00: [io  0x04d0-0x04d1] has been reserved
[    0.335678] system 00:00: [io  0x0290-0x029f] has been reserved
[    0.335680] system 00:00: [io  0x0800-0x087f] has been reserved
[    0.335683] system 00:00: [io  0x0290-0x0294] has been reserved
[    0.335685] system 00:00: [io  0x0880-0x088f] has been reserved
[    0.335689] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.335741] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.335947] pnp 00:02: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.336110] pnp 00:03: Plug and Play ACPI device, IDs PNP0400 (active)
[    0.336190] pnp 00:04: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.336239] system 00:05: [io  0x0400-0x047f] could not be reserved
[    0.336243] system 00:05: [io  0x0580-0x05ff] has been reserved
[    0.336246] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.336390] system 00:06: [mem 0xf4000000-0xf7ffffff] has been reserved
[    0.336394] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.336501] pnp 00:07: disabling [mem 0x000f0000-0x000f3fff] because it overlaps 0000:01:00.0 BAR 9 [mem 0x00000000-0x003fffff 64bit]
[    0.336506] pnp 00:07: disabling [mem 0x000f4000-0x000f7fff] because it overlaps 0000:01:00.0 BAR 9 [mem 0x00000000-0x003fffff 64bit]
[    0.336509] pnp 00:07: disabling [mem 0x000f8000-0x000fbfff] because it overlaps 0000:01:00.0 BAR 9 [mem 0x00000000-0x003fffff 64bit]
[    0.336513] pnp 00:07: disabling [mem 0x000fc000-0x000fffff] because it overlaps 0000:01:00.0 BAR 9 [mem 0x00000000-0x003fffff 64bit]
[    0.336517] pnp 00:07: disabling [mem 0x00000000-0x0009ffff] because it overlaps 0000:01:00.0 BAR 9 [mem 0x00000000-0x003fffff 64bit]
[    0.336521] pnp 00:07: disabling [mem 0x00100000-0xef7dffff] because it overlaps 0000:01:00.0 BAR 9 [mem 0x00000000-0x003fffff 64bit]
[    0.336524] pnp 00:07: disabling [mem 0x000e0000-0x000effff] because it overlaps 0000:01:00.0 BAR 9 [mem 0x00000000-0x003fffff 64bit]
[    0.336548] system 00:07: [mem 0xef7e0000-0xef7effff] could not be reserved
[    0.336551] system 00:07: [mem 0xef7f0000-0xef7fffff] has been reserved
[    0.336554] system 00:07: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.336556] system 00:07: [mem 0xfed10000-0xfed1dfff] has been reserved
[    0.336559] system 00:07: [mem 0xfed20000-0xfed8ffff] has been reserved
[    0.336561] system 00:07: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.336564] system 00:07: [mem 0xffb00000-0xffb7ffff] has been reserved
[    0.336567] system 00:07: [mem 0xfff00000-0xffffffff] has been reserved
[    0.336570] system 00:07: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.336577] pnp: PnP ACPI: found 8 devices
[    0.343020] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 02] add_size 200000
[    0.343037] pci 0000:00:1c.0: res[15]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 200000
[    0.343044] pci 0000:00:1c.0: BAR 15: assigned [mem 0xef800000-0xef9fffff 64bit pref]
[    0.343055] pci 0000:01:00.0: reg 0x174: [mem 0x00000000-0x00003fff 64bit]
[    0.343064] pci 0000:01:00.0: reg 0x17c: [mem 0x00000000-0x0003ffff 64bit]
[    0.343072] pci 0000:01:00.0: reg 0x174: [mem 0x00000000-0x00003fff 64bit]
[    0.343075] pci 0000:01:00.0: BAR 6: assigned [mem 0xfbd00000-0xfbd7ffff pref]
[    0.343084] pci 0000:01:00.0: reg 0x17c: [mem 0x00000000-0x0003ffff 64bit]
[    0.343087] pci 0000:01:00.0: BAR 9: no space for [mem size 0x00400000 64bit]
[    0.343090] pci 0000:01:00.0: BAR 9: failed to assign [mem size 0x00400000 64bit]
[    0.343099] pci 0000:01:00.0: reg 0x174: [mem 0x00000000-0x00003fff 64bit]
[    0.343102] pci 0000:01:00.0: BAR 7: no space for [mem size 0x00040000 64bit]
[    0.343104] pci 0000:01:00.0: BAR 7: failed to assign [mem size 0x00040000 64bit]
[    0.343107] pci 0000:00:03.0: PCI bridge to [bus 01]
[    0.343111] pci 0000:00:03.0:   bridge window [io  0xc000-0xcfff]
[    0.343115] pci 0000:00:03.0:   bridge window [mem 0xfbd00000-0xfbdfffff]
[    0.343120] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.343123] pci 0000:00:1c.0:   bridge window [io  0xe000-0xefff]
[    0.343128] pci 0000:00:1c.0:   bridge window [mem 0xfbc00000-0xfbcfffff]
[    0.343132] pci 0000:00:1c.0:   bridge window [mem 0xef800000-0xef9fffff 64bit pref]
[    0.343139] pci 0000:03:00.0: BAR 6: assigned [mem 0xfbb00000-0xfbb1ffff pref]
[    0.343142] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.343145] pci 0000:00:1c.1:   bridge window [io  0xd000-0xdfff]
[    0.343149] pci 0000:00:1c.1:   bridge window [mem 0xfbb00000-0xfbbfffff]
[    0.343153] pci 0000:00:1c.1:   bridge window [mem 0xfbe00000-0xfbefffff 64bit pref]
[    0.343160] pci 0000:04:04.0: BAR 6: assigned [mem 0xfb000000-0xfb00ffff pref]
[    0.343163] pci 0000:00:1e.0: PCI bridge to [bus 04]
[    0.343167] pci 0000:00:1e.0:   bridge window [mem 0xfa800000-0xfb7fffff]
[    0.343171] pci 0000:00:1e.0:   bridge window [mem 0xf9000000-0xf9ffffff 64bit pref]
[    0.343177] pci_bus 0000:00: Some PCI device resources are unassigned, try booting with pci=realloc
[    0.343181] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    0.343183] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    0.343185] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    0.343187] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000dffff]
[    0.343190] pci_bus 0000:00: resource 8 [mem 0xef800000-0xfebfffff]
[    0.343192] pci_bus 0000:01: resource 0 [io  0xc000-0xcfff]
[    0.343195] pci_bus 0000:01: resource 1 [mem 0xfbd00000-0xfbdfffff]
[    0.343197] pci_bus 0000:02: resource 0 [io  0xe000-0xefff]
[    0.343200] pci_bus 0000:02: resource 1 [mem 0xfbc00000-0xfbcfffff]
[    0.343202] pci_bus 0000:02: resource 2 [mem 0xef800000-0xef9fffff 64bit pref]
[    0.343205] pci_bus 0000:03: resource 0 [io  0xd000-0xdfff]
[    0.343207] pci_bus 0000:03: resource 1 [mem 0xfbb00000-0xfbbfffff]
[    0.343209] pci_bus 0000:03: resource 2 [mem 0xfbe00000-0xfbefffff 64bit pref]
[    0.343212] pci_bus 0000:04: resource 1 [mem 0xfa800000-0xfb7fffff]
[    0.343215] pci_bus 0000:04: resource 2 [mem 0xf9000000-0xf9ffffff 64bit pref]
[    0.343217] pci_bus 0000:04: resource 4 [io  0x0000-0x0cf7]
[    0.343220] pci_bus 0000:04: resource 5 [io  0x0d00-0xffff]
[    0.343222] pci_bus 0000:04: resource 6 [mem 0x000a0000-0x000bffff]
[    0.343224] pci_bus 0000:04: resource 7 [mem 0x000c0000-0x000dffff]
[    0.343227] pci_bus 0000:04: resource 8 [mem 0xef800000-0xfebfffff]
[    0.343230] pci_bus 0000:3f: resource 4 [io  0x0000-0xffff]
[    0.343233] pci_bus 0000:3f: resource 5 [mem 0x00000000-0xfffffffff]
[    0.343256] NET: Registered protocol family 2
[    0.343439] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.343765] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.344021] TCP: Hash tables configured (established 131072 bind 65536)
[    0.344042] TCP: reno registered
[    0.344059] UDP hash table entries: 8192 (order: 6, 262144 bytes)
[    0.344165] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes)
[    0.344295] NET: Registered protocol family 1
[    0.375409] pci 0000:04:04.0: Video device with shadowed ROM
[    0.375427] PCI: CLS 64 bytes, default 64
[    0.375464] Trying to unpack rootfs image as initramfs...
[    0.599199] Freeing initrd memory: 15060K (ffff880036286000 - ffff88003713b000)
[    0.599212] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.599215] software IO TLB [mem 0xeb7e0000-0xef7e0000] (64MB) mapped at [ffff8800eb7e0000-ffff8800ef7dffff]
[    0.599542] microcode: CPU0 sig=0x106e5, pf=0x2, revision=0x4
[    0.599549] microcode: CPU1 sig=0x106e5, pf=0x2, revision=0x4
[    0.599556] microcode: CPU2 sig=0x106e5, pf=0x2, revision=0x4
[    0.599563] microcode: CPU3 sig=0x106e5, pf=0x2, revision=0x4
[    0.599570] microcode: CPU4 sig=0x106e5, pf=0x2, revision=0x4
[    0.599577] microcode: CPU5 sig=0x106e5, pf=0x2, revision=0x4
[    0.599583] microcode: CPU6 sig=0x106e5, pf=0x2, revision=0x4
[    0.599589] microcode: CPU7 sig=0x106e5, pf=0x2, revision=0x4
[    0.599644] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    0.599669] Scanning for low memory corruption every 60 seconds
[    0.599992] futex hash table entries: 2048 (order: 5, 131072 bytes)
[    0.600038] audit: initializing netlink subsys (disabled)
[    0.600051] audit: type=2000 audit(1422990936.496:1): initialized
[    0.600258] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.601544] VFS: Disk quotas dquot_6.5.2
[    0.601576] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.601851] fuse init (API version 7.23)
[    0.602390] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    0.602395] io scheduler noop registered
[    0.602398] io scheduler deadline registered (default)
[    0.602423] io scheduler cfq registered
[    0.602811] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.602825] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    0.602852] vesafb: mode is 1024x768x32, linelength=4096, pages=0
[    0.602855] vesafb: scrolling: redraw
[    0.602857] vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.602868] vesafb: framebuffer at 0xf9000000, mapped to 0xffffc90005b80000, using 3072k, total 3072k
[    0.721466] Console: switching to colour frame buffer device 128x48
[    0.841402] fb0: VESA VGA frame buffer device
[    0.842389] intel_idle: MWAIT substates: 0x1120
[    0.843406] intel_idle: v0.4 model 0x1E
[    0.844253] intel_idle: lapic_timer_reliable_states 0x2
[    0.845631] ipmi message handler version 39.2
[    0.846651] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.848507] ACPI: Power Button [PWRB]
[    0.849350] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.850987] ACPI: Power Button [PWRF]
[    0.852741] GHES: HEST is not enabled!
[    0.853615] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.875405] 00:02: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.878550] Linux agpgart interface v0.103
[    0.880626] brd: module loaded
[    0.881876] loop: module loaded
[    0.882882] libphy: Fixed MDIO Bus: probed
[    0.883861] tun: Universal TUN/TAP device driver, 1.6
[    0.884977] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    0.886381] PPP generic driver version 2.4.2
[    0.887365] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.888811] ehci-pci: EHCI PCI platform driver
[    0.889888] ehci-pci 0000:00:1a.7: EHCI Host Controller
[    0.891048] ehci-pci 0000:00:1a.7: new USB bus registered, assigned bus number 1
[    0.939946] ehci-pci 0000:00:1a.7: debug port 2
[    0.992889] ehci-pci 0000:00:1a.7: cache line size of 64 is not supported
[    1.042033] ehci-pci 0000:00:1a.7: irq 18, io mem 0xfbfff000
[    1.099376] ehci-pci 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    1.147055] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    1.195150] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.243091] usb usb1: Product: EHCI Host Controller
[    1.290741] usb usb1: Manufacturer: Linux 3.19.0-rc6-patch02 ehci_hcd
[    1.338604] usb usb1: SerialNumber: 0000:00:1a.7
[    1.386004] hub 1-0:1.0: USB hub found
[    1.432814] hub 1-0:1.0: 6 ports detected
[    1.479122] ehci-pci 0000:00:1d.7: EHCI Host Controller
[    1.525182] ehci-pci 0000:00:1d.7: new USB bus registered, assigned bus number 2
[    1.571265] ehci-pci 0000:00:1d.7: debug port 2
[    1.595435] tsc: Refined TSC clocksource calibration: 2798.007 MHz
[    1.667212] ehci-pci 0000:00:1d.7: cache line size of 64 is not supported
[    1.714451] ehci-pci 0000:00:1d.7: irq 23, io mem 0xfbffe000
[    1.771427] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    1.817774] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    1.864524] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.911390] usb usb2: Product: EHCI Host Controller
[    1.958168] usb usb2: Manufacturer: Linux 3.19.0-rc6-patch02 ehci_hcd
[    2.005162] usb usb2: SerialNumber: 0000:00:1d.7
[    2.051529] hub 2-0:1.0: USB hub found
[    2.096921] hub 2-0:1.0: 8 ports detected
[    2.141774] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.187368] ohci-pci: OHCI PCI platform driver
[    2.233046] uhci_hcd: USB Universal Host Controller Interface driver
[    2.279694] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    2.325929] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
[    2.371988] uhci_hcd 0000:00:1a.0: detected 2 ports
[    2.416775] uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000ff00
[    2.461000] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[    2.505285] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.550031] usb usb3: Product: UHCI Host Controller
[    2.594354] usb usb3: Manufacturer: Linux 3.19.0-rc6-patch02 uhci_hcd
[    2.638701] usb usb3: SerialNumber: 0000:00:1a.0
[    2.682292] Switched to clocksource tsc
[    2.682464] hub 3-0:1.0: USB hub found
[    2.682470] hub 3-0:1.0: 2 ports detected
[    2.682619] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    2.682623] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
[    2.682631] uhci_hcd 0000:00:1a.1: detected 2 ports
[    2.682670] uhci_hcd 0000:00:1a.1: irq 21, io base 0x0000fe00
[    2.682709] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    2.682710] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.682710] usb usb4: Product: UHCI Host Controller
[    2.682711] usb usb4: Manufacturer: Linux 3.19.0-rc6-patch02 uhci_hcd
[    2.682712] usb usb4: SerialNumber: 0000:00:1a.1
[    2.682925] hub 4-0:1.0: USB hub found
[    2.682931] hub 4-0:1.0: 2 ports detected
[    2.683079] uhci_hcd 0000:00:1a.2: UHCI Host Controller
[    2.683082] uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus number 5
[    2.683091] uhci_hcd 0000:00:1a.2: detected 2 ports
[    2.683119] uhci_hcd 0000:00:1a.2: irq 18, io base 0x0000fd00
[    2.683157] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[    2.683158] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.683159] usb usb5: Product: UHCI Host Controller
[    2.683160] usb usb5: Manufacturer: Linux 3.19.0-rc6-patch02 uhci_hcd
[    2.683161] usb usb5: SerialNumber: 0000:00:1a.2
[    2.683436] hub 5-0:1.0: USB hub found
[    2.683442] hub 5-0:1.0: 2 ports detected
[    2.683596] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    2.683600] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 6
[    2.683608] uhci_hcd 0000:00:1d.0: detected 2 ports
[    2.683636] uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000fc00
[    2.683675] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
[    2.683676] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.683677] usb usb6: Product: UHCI Host Controller
[    2.683678] usb usb6: Manufacturer: Linux 3.19.0-rc6-patch02 uhci_hcd
[    2.683678] usb usb6: SerialNumber: 0000:00:1d.0
[    2.683879] hub 6-0:1.0: USB hub found
[    2.683884] hub 6-0:1.0: 2 ports detected
[    2.684036] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    2.684040] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 7
[    2.684048] uhci_hcd 0000:00:1d.1: detected 2 ports
[    2.684086] uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000fb00
[    2.684126] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
[    2.684127] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.684128] usb usb7: Product: UHCI Host Controller
[    2.684128] usb usb7: Manufacturer: Linux 3.19.0-rc6-patch02 uhci_hcd
[    2.684129] usb usb7: SerialNumber: 0000:00:1d.1
[    2.684319] hub 7-0:1.0: USB hub found
[    2.684322] hub 7-0:1.0: 2 ports detected
[    2.684464] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    2.684467] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 8
[    2.684475] uhci_hcd 0000:00:1d.2: detected 2 ports
[    2.684503] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000fa00
[    2.684542] usb usb8: New USB device found, idVendor=1d6b, idProduct=0001
[    2.684543] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.684543] usb usb8: Product: UHCI Host Controller
[    2.684544] usb usb8: Manufacturer: Linux 3.19.0-rc6-patch02 uhci_hcd
[    2.684545] usb usb8: SerialNumber: 0000:00:1d.2
[    2.684816] hub 8-0:1.0: USB hub found
[    2.684821] hub 8-0:1.0: 2 ports detected
[    2.684965] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[    2.684969] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 9
[    2.684977] uhci_hcd 0000:00:1d.3: detected 2 ports
[    2.685005] uhci_hcd 0000:00:1d.3: irq 16, io base 0x0000f900
[    2.685043] usb usb9: New USB device found, idVendor=1d6b, idProduct=0001
[    2.685044] usb usb9: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.685045] usb usb9: Product: UHCI Host Controller
[    2.685046] usb usb9: Manufacturer: Linux 3.19.0-rc6-patch02 uhci_hcd
[    2.685046] usb usb9: SerialNumber: 0000:00:1d.3
[    2.685258] hub 9-0:1.0: USB hub found
[    2.685264] hub 9-0:1.0: 2 ports detected
[    2.685361] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    2.685361] i8042: PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
[    2.685525] serio: i8042 KBD port at 0x60,0x64 irq 1
[    2.685797] mousedev: PS/2 mouse device common for all mice
[    2.686097] rtc_cmos 00:01: RTC can wake from S4
[    2.686400] rtc_cmos 00:01: rtc core: registered rtc_cmos as rtc0
[    2.686450] rtc_cmos 00:01: alarms up to one month, 242 bytes nvram, hpet irqs
[    2.686500] device-mapper: uevent: version 1.0.3
[    2.686573] device-mapper: ioctl: 4.29.0-ioctl (2014-10-28) initialised: dm-devel@redhat.com
[    2.686637] TCP: cubic registered
[    2.686709] NET: Registered protocol family 10
[    2.686940] NET: Registered protocol family 17
[    2.686947] Key type dns_resolver registered
[    2.687455] registered taskstats version 1
[    2.706112] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input2
[    2.724945] Key type trusted registered
[    2.729251] Key type encrypted registered
[    2.729259] AppArmor: AppArmor sha1 policy hashing enabled
[    2.729262] ima: No TPM chip found, activating TPM-bypass!
[    2.729282] evm: HMAC attrs: 0x1
[    2.729849]   Magic number: 3:933:292
[    2.729864] tty tty25: hash matches
[    2.769810] rtc_cmos 00:01: setting system clock to 2015-02-03 19:15:39 UTC (1422990939)
[    2.901890] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    2.901890] EDD information not available.
[    2.901923] PM: Hibernation image not present or could not be loaded.
[    3.023520] usb 5-2: new low-speed USB device number 2 using uhci_hcd
[    3.716839] usb 5-2: New USB device found, idVendor=04b4, idProduct=0101
[    3.716841] usb 5-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.716842] usb 5-2: Product: Cypress PS/2 Keyboard - PS/2 Mouse
[    3.716843] usb 5-2: Manufacturer: Cypress
[    6.878271] sched: RT throttling activated
[    6.923276] Freeing unused kernel memory: 1212K (ffffffff81d09000 - ffffffff81e38000)
[    6.969292] Write protecting the kernel read-only data: 12288k
[    7.015971] Freeing unused kernel memory: 1376K (ffff8800016a8000 - ffff880001800000)
[    7.063645] Freeing unused kernel memory: 824K (ffff880001b32000 - ffff880001c00000)
[    7.169242] systemd-udevd[133]: starting version 204
[    7.221516] mpt2sas version 18.100.00.00 loaded
[    7.270262] mpt2sas0: 64 BIT PCI BUS DMA ADDRESSING SUPPORTED, total mem (16426844 kB)
[    7.270946] scsi host1: pata_jmicron
[    7.271101] scsi host2: pata_jmicron
[    7.271136] ata1: PATA max UDMA/100 cmd 0xef00 ctl 0xee00 bmdma 0xeb00 irq 17
[    7.271137] ata2: PATA max UDMA/100 cmd 0xed00 ctl 0xec00 bmdma 0xeb08 irq 17
[    7.416148] hidraw: raw HID events driver (C) Jiri Kosina
[    7.561568] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    7.587604] usbcore: registered new interface driver usbhid
[    7.587605] usbhid: USB HID core driver
[    7.706678] r8169 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM control
[    7.706710] ahci 0000:00:1f.2: version 3.0
[    7.706868] ahci 0000:00:1f.2: SSS flag set, parallel bus scan disabled
[    7.706963] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 3 Gbps 0x3f impl SATA mode
[    7.706964] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pmp pio slum part ems apst 
[    7.744413] scsi host3: ahci
[    7.744560] scsi host4: ahci
[    7.744678] scsi host5: ahci
[    7.744793] scsi host6: ahci
[    7.744912] scsi host7: ahci
[    7.745047] scsi host8: ahci
[    7.745089] ata3: SATA max UDMA/133 abar m2048@0xfbffd000 port 0xfbffd100 irq 29
[    7.745092] ata4: SATA max UDMA/133 abar m2048@0xfbffd000 port 0xfbffd180 irq 29
[    7.745094] ata5: SATA max UDMA/133 abar m2048@0xfbffd000 port 0xfbffd200 irq 29
[    7.745097] ata6: SATA max UDMA/133 abar m2048@0xfbffd000 port 0xfbffd280 irq 29
[    7.745099] ata7: SATA max UDMA/133 abar m2048@0xfbffd000 port 0xfbffd300 irq 29
[    7.745102] ata8: SATA max UDMA/133 abar m2048@0xfbffd000 port 0xfbffd380 irq 29
[    7.745242] ahci 0000:02:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
[    7.745244] ahci 0000:02:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
[    7.745546] scsi host9: ahci
[    7.745673] scsi host10: ahci
[    7.745715] ata9: SATA max UDMA/133 abar m8192@0xfbcfe000 port 0xfbcfe100 irq 16
[    7.745718] ata10: SATA max UDMA/133 abar m8192@0xfbcfe000 port 0xfbcfe180 irq 16
[    7.803181] input: Cypress Cypress PS/2 Keyboard - PS/2 Mouse as /devices/pci0000:00/0000:00:1a.2/usb5/5-2/5-2:1.0/0003:04B4:0101.0001/input/input3
[    7.847910] mpt2sas0: MSI-X vectors supported: 1, no of cores: 8, max_msix_vectors: 8
[    7.847940] mpt2sas0-msix0: PCI-MSI-X enabled: IRQ 30
[    7.847941] mpt2sas0: iomem(0x00000000fbdfc000), mapped(0xffffc90005b78000), size(16384)
[    7.847942] mpt2sas0: ioport(0x000000000000ce00), size(256)
[    7.856012] hid-generic 0003:04B4:0101.0001: input,hidraw0: USB HID v1.00 Keyboard [Cypress Cypress PS/2 Keyboard - PS/2 Mouse] on usb-0000:00:1a.2-2/input0
[    7.856115] input: Cypress Cypress PS/2 Keyboard - PS/2 Mouse as /devices/pci0000:00/0000:00:1a.2/usb5/5-2/5-2:1.1/0003:04B4:0101.0002/input/input4
[    7.856267] hid-generic 0003:04B4:0101.0002: input,hidraw1: USB HID v1.00 Mouse [Cypress Cypress PS/2 Keyboard - PS/2 Mouse] on usb-0000:00:1a.2-2/input1
[    8.063956] ata10: SATA link down (SStatus 0 SControl 300)
[    8.064013] ata9: SATA link down (SStatus 0 SControl 300)
[    8.135970] mpt2sas0: sending diag reset !!
[    8.235920] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    8.237002] ata3.00: ATA-8: WDC WD2000FYYZ-01UL1B2, 01.01K03, max UDMA/133
[    8.237003] ata3.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
[    8.238153] ata3.00: configured for UDMA/133
[    8.238333] scsi 3:0:0:0: Direct-Access     ATA      WDC WD2000FYYZ-0 1K03 PQ: 0 ANSI: 5
[    8.238617] sd 3:0:0:0: [sda] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
[    8.238625] sd 3:0:0:0: Attached scsi generic sg0 type 0
[    8.238740] sd 3:0:0:0: [sda] Write Protect is off
[    8.238741] sd 3:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    8.238842] sd 3:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    8.256229]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
[    8.257464] sd 3:0:0:0: [sda] Attached SCSI disk
[    8.728036] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    8.744262] ata4.00: ATA-8: Hitachi HDT721010SLA360, ST6OA31B, max UDMA/133
[    8.744263] ata4.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
[    8.745692] ata4.00: configured for UDMA/133
[    8.745843] scsi 4:0:0:0: Direct-Access     ATA      Hitachi HDT72101 A31B PQ: 0 ANSI: 5
[    8.746230] sd 4:0:0:0: Attached scsi generic sg1 type 0
[    8.746265] sd 4:0:0:0: [sdb] 1953525168 512-byte logical blocks: (1.00 TB/931 GiB)
[    8.746362] sd 4:0:0:0: [sdb] Write Protect is off
[    8.746364] sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    8.746463] sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    8.772532]  sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 >
[    8.773240] sd 4:0:0:0: [sdb] Attached SCSI disk
[    9.064012] ata5: SATA link down (SStatus 0 SControl 300)
[    9.283989] mpt2sas0: diag reset: SUCCESS
[    9.430110] mpt2sas0: Allocated physical memory: size(3392 kB)
[    9.430111] mpt2sas0: Current Controller Queue Depth(1483), Max Controller Queue Depth(1720)
[    9.430111] mpt2sas0: Scatter Gather Elements per IO(128)
[    9.556041] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    9.562504] ata6.00: ATA-8: WDC WD1200AAJS-00VTA0, 01.01B01, max UDMA/133
[    9.562505] ata6.00: 234441648 sectors, multi 0: LBA48 
[    9.570035] ata6.00: configured for UDMA/133
[    9.570180] scsi 6:0:0:0: Direct-Access     ATA      WDC WD1200AAJS-0 1B01 PQ: 0 ANSI: 5
[    9.570438] sd 6:0:0:0: [sdc] 234441648 512-byte logical blocks: (120 GB/111 GiB)
[    9.570440] sd 6:0:0:0: Attached scsi generic sg2 type 0
[    9.570554] sd 6:0:0:0: [sdc] Write Protect is off
[    9.570556] sd 6:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    9.570653] sd 6:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    9.596117]  sdc: sdc1 sdc2 sdc3 sdc4
[    9.597025] sd 6:0:0:0: [sdc] Attached SCSI disk
[    9.888068] ata7: SATA link down (SStatus 0 SControl 300)
[   10.208140] ata8: SATA link down (SStatus 0 SControl 300)
[   10.281099] random: nonblocking pool is initialized
[   10.292108] floppy0: no floppy controllers found
[   10.446948] mpt2sas0: LSISAS2008: FWVersion(17.00.01.00), ChipRevision(0x03), BiosVersion(07.33.00.00)
[   10.446951] mpt2sas0: Protocol=(Initiator), Capabilities=(Raid,TLR,EEDP,Snapshot Buffer,Diag Trace Buffer,Task Set Full,NCQ)
[   10.561078] scsi host0: Fusion MPT SAS Host
[   10.561323] mpt2sas0: sending port enable !!
[   12.175003] r8169 0000:03:00.0 eth0: RTL8168d/8111d at 0xffffc900018f8000, 00:24:1d:d9:29:dd, XID 083000c0 IRQ 31
[   12.176955] mpt2sas0: host_add: handle(0x0001), sas_addr(0x500605b001bdc971), phys(8)
[   12.284658] r8169 0000:03:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[   15.869212] EXT4-fs (sdc4): mounting ext2 file system using the ext4 subsystem
[   15.952769] EXT4-fs (sdc4): mounted filesystem without journal. Opts: (null)
[   17.312594] mpt2sas0: port enable: SUCCESS
[   17.369942] scsi 0:0:0:0: Direct-Access     ATA      ST3000DM001-1CH1 CC24 PQ: 0 ANSI: 6
[   17.426827] scsi 0:0:0:0: SATA: handle(0x0010), sas_addr(0x4433221107000000), phy(7), device_name(0x5000c500503ba50b)
[   17.484828] scsi 0:0:0:0: SATA: enclosure_logical_id(0x500605b001bdc971), slot(4)
[   17.542409] scsi 0:0:0:0: atapi(n), ncq(y), asyn_notify(n), smart(y), fua(y), sw_preserve(y)
[   17.602740] scsi 0:0:1:0: Direct-Access     ATA      ST4000VN000-1H41 SC43 PQ: 0 ANSI: 6
[   17.661136] scsi 0:0:1:0: SATA: handle(0x0009), sas_addr(0x4433221100000000), phy(0), device_name(0x5000c500652240ac)
[   17.720740] scsi 0:0:1:0: SATA: enclosure_logical_id(0x500605b001bdc971), slot(3)
[   17.780410] scsi 0:0:1:0: atapi(n), ncq(y), asyn_notify(n), smart(y), fua(y), sw_preserve(y)
[   17.843003] scsi 0:0:2:0: Direct-Access     ATA      ST3000DM001-1CH1 CC46 PQ: 0 ANSI: 6
[   17.903134] scsi 0:0:2:0: SATA: handle(0x000a), sas_addr(0x4433221101000000), phy(1), device_name(0x5000c5006133c626)
[   17.964296] scsi 0:0:2:0: SATA: enclosure_logical_id(0x500605b001bdc971), slot(2)
[   18.025563] scsi 0:0:2:0: atapi(n), ncq(y), asyn_notify(n), smart(y), fua(y), sw_preserve(y)
[   18.091862] scsi 0:0:3:0: Direct-Access     ATA      HGST HDN724040AL A5E0 PQ: 0 ANSI: 6
[   18.154416] scsi 0:0:3:0: SATA: handle(0x000b), sas_addr(0x4433221102000000), phy(2), device_name(0x5000cca23dd0c3ea)
[   18.218094] scsi 0:0:3:0: SATA: enclosure_logical_id(0x500605b001bdc971), slot(1)
[   18.281380] scsi 0:0:3:0: atapi(n), ncq(y), asyn_notify(n), smart(y), fua(y), sw_preserve(y)
[   18.351010] scsi 0:0:4:0: Direct-Access     ATA      ST4000VN000-1H41 SC44 PQ: 0 ANSI: 6
[   18.415231] scsi 0:0:4:0: SATA: handle(0x000c), sas_addr(0x4433221103000000), phy(3), device_name(0x5000c50066d0bd0b)
[   18.480892] scsi 0:0:4:0: SATA: enclosure_logical_id(0x500605b001bdc971), slot(0)
[   18.546911] scsi 0:0:4:0: atapi(n), ncq(y), asyn_notify(n), smart(y), fua(y), sw_preserve(y)
[   18.615650] scsi 0:0:5:0: Direct-Access     ATA      ST3000DM001-1CH1 CC43 PQ: 0 ANSI: 6
[   18.681905] scsi 0:0:5:0: SATA: handle(0x000d), sas_addr(0x4433221104000000), phy(4), device_name(0x5000c5004e1c44b6)
[   18.749399] scsi 0:0:5:0: SATA: enclosure_logical_id(0x500605b001bdc971), slot(7)
[   18.816959] scsi 0:0:5:0: atapi(n), ncq(y), asyn_notify(n), smart(y), fua(y), sw_preserve(y)
[   18.887075] scsi 0:0:6:0: Direct-Access     ATA      ST3000DM001-1CH1 CC43 PQ: 0 ANSI: 6
[   18.955660] scsi 0:0:6:0: SATA: handle(0x000e), sas_addr(0x4433221105000000), phy(5), device_name(0x5000c5004e222187)
[   19.025342] scsi 0:0:6:0: SATA: enclosure_logical_id(0x500605b001bdc971), slot(6)
[   19.094997] scsi 0:0:6:0: atapi(n), ncq(y), asyn_notify(n), smart(y), fua(y), sw_preserve(y)
[   19.168116] scsi 0:0:7:0: Direct-Access     ATA      ST3000DM001-1CH1 CC43 PQ: 0 ANSI: 6
[   19.238740] scsi 0:0:7:0: SATA: handle(0x000f), sas_addr(0x4433221106000000), phy(6), device_name(0x5000c5004dc8cb18)
[   19.311257] scsi 0:0:7:0: SATA: enclosure_logical_id(0x500605b001bdc971), slot(5)
[   19.383748] scsi 0:0:7:0: atapi(n), ncq(y), asyn_notify(n), smart(y), fua(y), sw_preserve(y)
[   19.457557] sd 0:0:0:0: Attached scsi generic sg3 type 0
[   19.530393] sd 0:0:0:0: [sdd] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
[   19.530499] sd 0:0:1:0: Attached scsi generic sg4 type 0
[   19.530886] sd 0:0:2:0: Attached scsi generic sg5 type 0
[   19.531287] sd 0:0:3:0: Attached scsi generic sg6 type 0
[   19.531658] sd 0:0:4:0: Attached scsi generic sg7 type 0
[   19.531849] sd 0:0:5:0: Attached scsi generic sg8 type 0
[   19.532087] sd 0:0:6:0: Attached scsi generic sg9 type 0
[   19.532249] sd 0:0:7:0: Attached scsi generic sg10 type 0
[   19.677258] sd 0:0:2:0: [sdf] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
[   19.677259] sd 0:0:6:0: [sdj] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
[   19.677259] sd 0:0:2:0: [sdf] 4096-byte physical blocks
[   19.677261] sd 0:0:6:0: [sdj] 4096-byte physical blocks
[   19.677344] sd 0:0:3:0: [sdg] 7814037168 512-byte logical blocks: (4.00 TB/3.63 TiB)
[   19.677347] sd 0:0:7:0: [sdk] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
[   19.677350] sd 0:0:3:0: [sdg] 4096-byte physical blocks
[   19.677355] sd 0:0:7:0: [sdk] 4096-byte physical blocks
[   19.677364] sd 0:0:5:0: [sdi] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
[   19.677366] sd 0:0:4:0: [sdh] 7814037168 512-byte logical blocks: (4.00 TB/3.63 TiB)
[   19.677367] sd 0:0:5:0: [sdi] 4096-byte physical blocks
[   19.677367] sd 0:0:4:0: [sdh] 4096-byte physical blocks
[   19.677379] sd 0:0:1:0: [sde] 7814037168 512-byte logical blocks: (4.00 TB/3.63 TiB)
[   19.677380] sd 0:0:1:0: [sde] 4096-byte physical blocks
[   20.223883] sd 0:0:5:0: [sdi] Write Protect is off
[   20.223886] sd 0:0:5:0: [sdi] Mode Sense: 7f 00 10 08
[   20.223887] sd 0:0:6:0: [sdj] Write Protect is off
[   20.223888] sd 0:0:2:0: [sdf] Write Protect is off
[   20.223889] sd 0:0:6:0: [sdj] Mode Sense: 7f 00 10 08
[   20.223890] sd 0:0:2:0: [sdf] Mode Sense: 7f 00 10 08
[   20.223891] sd 0:0:7:0: [sdk] Write Protect is off
[   20.223892] sd 0:0:1:0: [sde] Write Protect is off
[   20.223894] sd 0:0:7:0: [sdk] Mode Sense: 7f 00 10 08
[   20.223895] sd 0:0:1:0: [sde] Mode Sense: 7f 00 10 08
[   20.223906] sd 0:0:4:0: [sdh] Write Protect is off
[   20.223908] sd 0:0:4:0: [sdh] Mode Sense: 7f 00 10 08
[   20.348370] sd 0:0:3:0: [sdg] Write Protect is off
[   20.348372] sd 0:0:3:0: [sdg] Mode Sense: 7f 00 10 08
[   20.471539] sd 0:0:6:0: [sdj] Write cache: enabled, read cache: enabled, supports DPO and FUA
[   20.471544] sd 0:0:2:0: [sdf] Write cache: enabled, read cache: enabled, supports DPO and FUA
[   20.471546] sd 0:0:7:0: [sdk] Write cache: enabled, read cache: enabled, supports DPO and FUA
[   20.471548] sd 0:0:5:0: [sdi] Write cache: enabled, read cache: enabled, supports DPO and FUA
[   20.471549] sd 0:0:1:0: [sde] Write cache: enabled, read cache: enabled, supports DPO and FUA
[   20.471559] sd 0:0:4:0: [sdh] Write cache: enabled, read cache: enabled, supports DPO and FUA
[   20.590288] sd 0:0:3:0: [sdg] Write cache: enabled, read cache: enabled, supports DPO and FUA
[   21.778339] sd 0:0:0:0: [sdd] 4096-byte physical blocks
[   21.807626]  sde: sde1 sde9
[   21.834582]  sdk: sdk1 sdk9
[   21.859371]  sdh: sdh1 sdh9
[   21.859635]  sdj: sdj1 sdj9
[   21.859981]  sdi: sdi1 sdi9
[   21.860050]  sdf: sdf1 sdf2 sdf3
[   21.869247] sd 0:0:0:0: [sdd] Write Protect is off
[   21.869248] sd 0:0:0:0: [sdd] Mode Sense: 7f 00 10 08
[   21.869919] sd 0:0:0:0: [sdd] Write cache: enabled, read cache: enabled, supports DPO and FUA
[   21.891384]  sdg: sdg1 sdg9
[   21.929076] sd 0:0:2:0: [sdf] Attached SCSI disk
[   21.939059] sd 0:0:6:0: [sdj] Attached SCSI disk
[   21.939402] sd 0:0:7:0: [sdk] Attached SCSI disk
[   21.941157] sd 0:0:1:0: [sde] Attached SCSI disk
[   21.942493] sd 0:0:5:0: [sdi] Attached SCSI disk
[   21.983127]  sdd: sdd1 sdd2 sdd3
[   22.054109] sd 0:0:0:0: [sdd] Attached SCSI disk
[   22.124701] sd 0:0:3:0: [sdg] Attached SCSI disk
[   22.318149] sd 0:0:4:0: [sdh] Attached SCSI disk
[   35.547565] Adding 9798652k swap on /dev/sdc2.  Priority:-1 extents:1 across:9798652k FS
[   35.854462] systemd-udevd[342]: starting version 204
[   36.647856] audit: type=1400 audit(1422990973.410:2): apparmor="STATUS" operation="profile_load" name="/sbin/dhclient" pid=519 comm="apparmor_parser"
[   36.703680] audit: type=1400 audit(1422990973.466:3): apparmor="STATUS" operation="profile_load" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=519 comm="apparmor_parser"
[   36.766609] audit: type=1400 audit(1422990973.530:4): apparmor="STATUS" operation="profile_load" name="/usr/lib/connman/scripts/dhclient-script" pid=519 comm="apparmor_parser"
[   36.836294] audit: type=1400 audit(1422990973.598:5): apparmor="STATUS" operation="profile_replace" name="/sbin/dhclient" pid=538 comm="apparmor_parser"
[   36.836299] audit: type=1400 audit(1422990973.598:6): apparmor="STATUS" operation="profile_replace" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=538 comm="apparmor_parser"
[   36.836303] audit: type=1400 audit(1422990973.598:7): apparmor="STATUS" operation="profile_replace" name="/usr/lib/connman/scripts/dhclient-script" pid=538 comm="apparmor_parser"
[   36.836638] audit: type=1400 audit(1422990973.598:8): apparmor="STATUS" operation="profile_replace" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=519 comm="apparmor_parser"
[   36.836641] audit: type=1400 audit(1422990973.598:9): apparmor="STATUS" operation="profile_replace" name="/usr/lib/connman/scripts/dhclient-script" pid=519 comm="apparmor_parser"
[   36.836673] audit: type=1400 audit(1422990973.598:10): apparmor="STATUS" operation="profile_replace" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=538 comm="apparmor_parser"
[   36.836675] audit: type=1400 audit(1422990973.598:11): apparmor="STATUS" operation="profile_replace" name="/usr/lib/connman/scripts/dhclient-script" pid=538 comm="apparmor_parser"
[   37.428759] ACPI Warning: SystemIO range 0x0000000000000428-0x000000000000042f conflicts with OpRegion 0x000000000000042c-0x000000000000042d (\GP2C) (20141107/utaddress-258)
[   37.428760] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[   37.428859] lpc_ich: Resource conflict(s) found affecting gpio_ich
[   37.949645] EDAC MC: Ver: 3.0.0
[   38.022479] parport_pc 00:03: reported by Plug and Play ACPI
[   38.022528] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
[   38.023017] lp: driver loaded but no devices found
[   38.118022] lp0: using parport0 (interrupt-driven).
[   38.313379] gpio_ich: GPIO from 436 to 511 on gpio_ich
[   38.313483] ppdev: user-space parallel port driver
[   38.463425] EDAC MC0: Giving out device to module i7core_edac.c controller i7 core #0: DEV 0000:3f:03.0 (POLLED)
[   38.463465] EDAC PCI0: Giving out device to module i7core_edac controller EDAC PCI controller: DEV 0000:3f:03.0 (POLLED)
[   38.463467] EDAC i7core: Driver loaded, 1 memory controller(s) found.
[   38.819237] kvm: VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL does not work properly. Using workaround
[   38.989150] EXT4-fs (sdc4): re-mounted. Opts: errors=remount-ro
[   39.375941] init: failsafe main process (734) killed by TERM signal
[   39.457078] sound hdaudioC0D2: autoconfig: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
[   39.538999] sound hdaudioC0D2:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   39.621763] sound hdaudioC0D2:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[   39.704867] sound hdaudioC0D2:    mono: mono_out=0x0
[   39.788100] sound hdaudioC0D2:    dig-out=0x1e/0x0
[   39.871006] sound hdaudioC0D2:    inputs:
[   39.953435] sound hdaudioC0D2:      Rear Mic=0x18
[   40.036242] sound hdaudioC0D2:      Front Mic=0x19
[   40.119339] sound hdaudioC0D2:      Line=0x1a
[   40.201201] sound hdaudioC0D2:      CD=0x1c
[   40.281862] sound hdaudioC0D2:    dig-in=0x1f
[   40.370849] input: HDA Intel MID Rear Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input5
[   40.450060] input: HDA Intel MID Front Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input6
[   40.528118] input: HDA Intel MID Line as /devices/pci0000:00/0000:00:1b.0/sound/card0/input7
[   40.604946] input: HDA Intel MID Line Out as /devices/pci0000:00/0000:00:1b.0/sound/card0/input8
[   41.486414] floppy0: no floppy controllers found
[   41.551348] init: cups main process (832) killed by HUP signal
[   41.551354] init: cups main process ended, respawning
[   41.997066] Bluetooth: Core ver 2.20
[   42.065994] NET: Registered protocol family 31
[   42.133508] Bluetooth: HCI device and connection manager initialized
[   42.200062] Bluetooth: HCI socket layer initialized
[   42.264835] Bluetooth: L2CAP socket layer initialized
[   42.327760] Bluetooth: SCO socket layer initialized
[   42.512903] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   42.572401] Bluetooth: BNEP filters: protocol multicast
[   42.630146] Bluetooth: BNEP socket layer initialized
[   42.732455] Bluetooth: RFCOMM TTY layer initialized
[   42.786562] Bluetooth: RFCOMM socket layer initialized
[   42.838836] Bluetooth: RFCOMM ver 1.11
[   43.966277] snd_hda_intel 0000:00:1b.0: control 2:0:0:PCM Playback Volume:0 is already present
[   45.111899] r8169 0000:03:00.0 eth0: link down
[   45.111929] r8169 0000:03:00.0 eth0: link down
[   45.181972] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   47.521216] r8169 0000:03:00.0 eth0: link up
[   47.558430] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   48.541401] init: plymouth-upstart-bridge main process ended, respawning
[   70.961880] audit_printk_skb: 123 callbacks suppressed
[   70.961882] audit: type=1400 audit(1422991007.722:53): apparmor="STATUS" operation="profile_replace" name="/usr/lib/cups/backend/cups-pdf" pid=1691 comm="apparmor_parser"
[   70.961886] audit: type=1400 audit(1422991007.722:54): apparmor="STATUS" operation="profile_replace" name="/usr/sbin/cupsd" pid=1691 comm="apparmor_parser"
[   70.962164] audit: type=1400 audit(1422991007.722:55): apparmor="STATUS" operation="profile_replace" name="/usr/sbin/cupsd" pid=1691 comm="apparmor_parser"

--------------040609080505020401020909--
