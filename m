Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from resqmta-po-08v.sys.comcast.net ([96.114.154.167]:59932 "EHLO
	resqmta-po-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751611AbbBHCPl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 7 Feb 2015 21:15:41 -0500
Message-ID: <54D6C6CB.6060904@nwtrail.com>
Date: Sat, 07 Feb 2015 18:15:39 -0800
From: Paul Johnson <pjay@nwtrail.com>
Reply-To: pjay@nwtrail.com
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [problem] mpt2sas load fails with LSISAS2008
References: <54C81B4E.7060900@nwtrail.com>	<CAErSpo6P-gm1xFjLrbKBU+P3zUHY-RGMkhaVpWsK7vDz_wK=YQ@mail.gmail.com>	<54CBB062.4040801@nwtrail.com>	<CAE9FiQUxD8g4KG9CYe1znb5Lw5skkq=9QSOgkmGUDbhsaDq2Qw@mail.gmail.com>	<54CFBC0E.4080102@nwtrail.com>	<CAE9FiQUT5j1PDw5c0X-k_E+0TbwCdrX1nbqk8rKzxAKxRLqvEg@mail.gmail.com>	<54D160B5.70006@nwtrail.com> <CAE9FiQVjiCSj21eqevBOYz42o=aiPPMLM_g+65v8CJWgcdq=pg@mail.gmail.com>
In-Reply-To: <CAE9FiQVjiCSj21eqevBOYz42o=aiPPMLM_g+65v8CJWgcdq=pg@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------030805080809080404030206"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------030805080809080404030206
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 02/07/2015 03:34 PM, Yinghai Lu wrote:
> On Tue, Feb 3, 2015 at 3:58 PM, Paul Johnson <pjay@nwtrail.com> wrote:
>> On 02/02/2015 02:30 PM, Yinghai Lu wrote:
>>>
>> This patch worked. In case you have a need, the dmesg is attached.
>
> Please check two patches instead. You need to apply those two at the same time
> on current linus tree.
>
> Thanks
>
> Yinghai
>
The patches did not work. dmesg attached.

Interesting discussion about LSI cards. I have wondered what other 
people are running into with this card/chip. It has been around awhile.

Thanks for your efforts.
Paul


--------------030805080809080404030206
Content-Type: text/plain; charset=UTF-8;
 name="dmesg-3.19.0-rc7-patch03"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg-3.19.0-rc7-patch03"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.19.0-rc7-patch03 (paulj@x1404ubu64) (gcc version 4.8.2 (Ubuntu 4.8.2-19ubuntu1) ) #6 SMP Sat Feb 7 16:40:57 PST 2015
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-3.19.0-rc7-patch03 root=UUID=f604b748-aeb8-4e3d-953f-b5a8b947c191 ro debug ignore_loglevel
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
[    0.000000] RAMDISK: [mem 0x36284000-0x37139fff]
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
[    0.000000] PERCPU: Embedded 29 pages/cpu @ffff88040fc00000 s80448 r8192 d30144 u262144
[    0.000000] pcpu-alloc: s80448 r8192 d30144 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 4126598
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-3.19.0-rc7-patch03 root=UUID=f604b748-aeb8-4e3d-953f-b5a8b947c191 ro debug ignore_loglevel
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] AGP: Checking aperture...
[    0.000000] AGP: No AGP bridge found
[    0.000000] Memory: 16408344K/16768492K available (6805K kernel code, 1055K rwdata, 3272K rodata, 1212K init, 940K bss, 360148K reserved, 0K cma-reserved)
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
[    0.000000] tsc: Detected 2797.854 MHz processor
[    0.000025] Calibrating delay loop (skipped), value calculated using timer frequency.. 5595.70 BogoMIPS (lpj=11191416)
[    0.000030] pid_max: default: 32768 minimum: 301
[    0.000035] ACPI: Core revision 20141107
[    0.003966] ACPI: All ACPI Tables successfully acquired
[    0.007329] Security Framework initialized
[    0.007342] AppArmor: AppArmor initialized
[    0.008188] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    0.011176] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.012582] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.012601] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.012843] Initializing cgroup subsys devices
[    0.012848] Initializing cgroup subsys freezer
[    0.012851] Initializing cgroup subsys net_cls
[    0.012854] Initializing cgroup subsys blkio
[    0.012857] Initializing cgroup subsys perf_event
[    0.012873] CPU: Physical Processor ID: 0
[    0.012875] CPU: Processor Core ID: 0
[    0.012880] mce: CPU supports 9 MCE banks
[    0.012888] CPU0: Thermal monitoring enabled (TM1)
[    0.012897] Last level iTLB entries: 4KB 512, 2MB 7, 4MB 7
[    0.012897] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    0.012970] Freeing SMP alternatives memory: 24K (ffffffff81e38000 - ffffffff81e3e000)
[    0.012974] ftrace: allocating 26468 entries in 104 pages
[    0.024081] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.063767] smpboot: CPU0: Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz (fam: 06, model: 1e, stepping: 05)
[    0.169464] Performance Events: PEBS fmt1+, 16-deep LBR, Nehalem events, Intel PMU driver.
[    0.169479] perf_event_intel: CPU erratum AAJ80 worked around
[    0.169481] perf_event_intel: CPUID marked event: 'bus cycles' unavailable
[    0.169484] ... version:                3
[    0.169485] ... bit width:              48
[    0.169487] ... generic registers:      4
[    0.169488] ... value mask:             0000ffffffffffff
[    0.169490] ... max period:             000000007fffffff
[    0.169492] ... fixed-purpose events:   3
[    0.169493] ... event mask:             000000070000000f
[    0.169995] x86: Booting SMP configuration:
[    0.169998] .... node  #0, CPUs:      #1
[    0.183216] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.183291]  #2 #3 #4 #5 #6 #7
[    0.262494] x86: Booted up 1 node, 8 CPUs
[    0.262501] smpboot: Total of 8 processors activated (44765.66 BogoMIPS)
[    0.267328] devtmpfs: initialized
[    0.271571] evm: security.selinux
[    0.271573] evm: security.SMACK64
[    0.271575] evm: security.capability
[    0.271618] PM: Registering ACPI NVS region [mem 0xef7e0000-0xef7e1fff] (8192 bytes)
[    0.271819] RTC time:  1:53:19, date: 02/08/15
[    0.271904] NET: Registered protocol family 16
[    0.281458] cpuidle: using governor ladder
[    0.291135] cpuidle: using governor menu
[    0.291188] ACPI: bus type PCI registered
[    0.291191] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.291254] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf4000000-0xf7ffffff] (base 0xf4000000)
[    0.291259] PCI: MMCONFIG at [mem 0xf4000000-0xf7ffffff] reserved in E820
[    0.291315] PCI: Using configuration type 1 for base access
[    0.300740] ACPI: Added _OSI(Module Device)
[    0.300743] ACPI: Added _OSI(Processor Device)
[    0.300745] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.300746] ACPI: Added _OSI(Processor Aggregator Device)
[    0.304919] ACPI: Interpreter enabled
[    0.304926] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_] (20141107/hwxface-580)
[    0.304931] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20141107/hwxface-580)
[    0.304943] ACPI: (supports S0 S3 S4 S5)
[    0.304945] ACPI: Using IOAPIC for interrupt routing
[    0.304964] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.308368] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3f])
[    0.308374] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.308379] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.308559] PCI host bridge to bus 0000:00
[    0.308563] pci_bus 0000:00: root bus resource [bus 00-3f]
[    0.308566] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
[    0.308568] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
[    0.308570] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
[    0.308573] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff]
[    0.308575] pci_bus 0000:00: root bus resource [mem 0xef800000-0xfebfffff]
[    0.308584] pci 0000:00:00.0: [8086:d131] type 00 class 0x060000
[    0.308678] pci 0000:00:03.0: [8086:d138] type 01 class 0x060400
[    0.308728] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    0.308790] pci 0000:00:08.0: [8086:d155] type 00 class 0x088000
[    0.308875] pci 0000:00:08.1: [8086:d156] type 00 class 0x088000
[    0.308960] pci 0000:00:08.2: [8086:d157] type 00 class 0x088000
[    0.309042] pci 0000:00:08.3: [8086:d158] type 00 class 0x088000
[    0.309120] pci 0000:00:10.0: [8086:d150] type 00 class 0x088000
[    0.309191] pci 0000:00:10.1: [8086:d151] type 00 class 0x088000
[    0.309278] pci 0000:00:1a.0: [8086:3b3b] type 00 class 0x0c0300
[    0.309317] pci 0000:00:1a.0: reg 0x20: [io  0xff00-0xff1f]
[    0.309381] pci 0000:00:1a.0: System wakeup disabled by ACPI
[    0.309415] pci 0000:00:1a.1: [8086:3b3e] type 00 class 0x0c0300
[    0.309453] pci 0000:00:1a.1: reg 0x20: [io  0xfe00-0xfe1f]
[    0.309521] pci 0000:00:1a.1: System wakeup disabled by ACPI
[    0.309555] pci 0000:00:1a.2: [8086:3b3f] type 00 class 0x0c0300
[    0.309593] pci 0000:00:1a.2: reg 0x20: [io  0xfd00-0xfd1f]
[    0.309656] pci 0000:00:1a.2: System wakeup disabled by ACPI
[    0.309697] pci 0000:00:1a.7: [8086:3b3c] type 00 class 0x0c0320
[    0.309717] pci 0000:00:1a.7: reg 0x10: [mem 0xfbfff000-0xfbfff3ff]
[    0.309800] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.309837] pci 0000:00:1a.7: System wakeup disabled by ACPI
[    0.309874] pci 0000:00:1b.0: [8086:3b56] type 00 class 0x040300
[    0.309890] pci 0000:00:1b.0: reg 0x10: [mem 0xfbff8000-0xfbffbfff 64bit]
[    0.309958] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.309994] pci 0000:00:1b.0: System wakeup disabled by ACPI
[    0.310027] pci 0000:00:1c.0: [8086:3b42] type 01 class 0x060400
[    0.310095] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.310133] pci 0000:00:1c.0: System wakeup disabled by ACPI
[    0.310166] pci 0000:00:1c.1: [8086:3b44] type 01 class 0x060400
[    0.310233] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.310269] pci 0000:00:1c.1: System wakeup disabled by ACPI
[    0.310308] pci 0000:00:1d.0: [8086:3b36] type 00 class 0x0c0300
[    0.310347] pci 0000:00:1d.0: reg 0x20: [io  0xfc00-0xfc1f]
[    0.310411] pci 0000:00:1d.0: System wakeup disabled by ACPI
[    0.310444] pci 0000:00:1d.1: [8086:3b37] type 00 class 0x0c0300
[    0.310483] pci 0000:00:1d.1: reg 0x20: [io  0xfb00-0xfb1f]
[    0.310546] pci 0000:00:1d.1: System wakeup disabled by ACPI
[    0.310578] pci 0000:00:1d.2: [8086:3b38] type 00 class 0x0c0300
[    0.310617] pci 0000:00:1d.2: reg 0x20: [io  0xfa00-0xfa1f]
[    0.310680] pci 0000:00:1d.2: System wakeup disabled by ACPI
[    0.310713] pci 0000:00:1d.3: [8086:3b39] type 00 class 0x0c0300
[    0.310751] pci 0000:00:1d.3: reg 0x20: [io  0xf900-0xf91f]
[    0.310815] pci 0000:00:1d.3: System wakeup disabled by ACPI
[    0.310857] pci 0000:00:1d.7: [8086:3b34] type 00 class 0x0c0320
[    0.310877] pci 0000:00:1d.7: reg 0x10: [mem 0xfbffe000-0xfbffe3ff]
[    0.310961] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.310998] pci 0000:00:1d.7: System wakeup disabled by ACPI
[    0.311030] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
[    0.311102] pci 0000:00:1e.0: System wakeup disabled by ACPI
[    0.311138] pci 0000:00:1f.0: [8086:3b02] type 00 class 0x060100
[    0.311294] pci 0000:00:1f.2: [8086:3b22] type 00 class 0x010601
[    0.311311] pci 0000:00:1f.2: reg 0x10: [io  0xf800-0xf807]
[    0.311319] pci 0000:00:1f.2: reg 0x14: [io  0xf700-0xf703]
[    0.311326] pci 0000:00:1f.2: reg 0x18: [io  0xf600-0xf607]
[    0.311334] pci 0000:00:1f.2: reg 0x1c: [io  0xf500-0xf503]
[    0.311341] pci 0000:00:1f.2: reg 0x20: [io  0xf400-0xf41f]
[    0.311349] pci 0000:00:1f.2: reg 0x24: [mem 0xfbffd000-0xfbffd7ff]
[    0.311392] pci 0000:00:1f.2: PME# supported from D3hot
[    0.311455] pci 0000:00:1f.3: [8086:3b30] type 00 class 0x0c0500
[    0.311469] pci 0000:00:1f.3: reg 0x10: [mem 0xfbffc000-0xfbffc0ff 64bit]
[    0.311488] pci 0000:00:1f.3: reg 0x20: [io  0x0500-0x051f]
[    0.311596] pci 0000:01:00.0: [1000:0072] type 00 class 0x010700
[    0.311607] pci 0000:01:00.0: reg 0x10: [io  0xce00-0xceff]
[    0.311617] pci 0000:01:00.0: reg 0x14: [mem 0xfbdfc000-0xfbdfffff 64bit]
[    0.311627] pci 0000:01:00.0: reg 0x1c: [mem 0xfbd80000-0xfbdbffff 64bit]
[    0.311639] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[    0.311680] pci 0000:01:00.0: supports D1 D2
[    0.311702] pci 0000:01:00.0: reg 0x174: [mem 0x00000000-0x00003fff 64bit]
[    0.311711] pci 0000:01:00.0: reg 0x17c: [mem 0x00000000-0x0003ffff 64bit]
[    0.317464] pci 0000:00:03.0: PCI bridge to [bus 01]
[    0.317468] pci 0000:00:03.0:   bridge window [io  0xc000-0xcfff]
[    0.317471] pci 0000:00:03.0:   bridge window [mem 0xfbd00000-0xfbdfffff]
[    0.317551] pci 0000:02:00.0: [197b:2363] type 00 class 0x010601
[    0.317638] pci 0000:02:00.0: reg 0x24: [mem 0xfbcfe000-0xfbcfffff]
[    0.317706] pci 0000:02:00.0: PME# supported from D3hot
[    0.317765] pci 0000:02:00.1: [197b:2363] type 00 class 0x010185
[    0.317789] pci 0000:02:00.1: reg 0x10: [io  0xef00-0xef07]
[    0.317803] pci 0000:02:00.1: reg 0x14: [io  0xee00-0xee03]
[    0.317816] pci 0000:02:00.1: reg 0x18: [io  0xed00-0xed07]
[    0.317829] pci 0000:02:00.1: reg 0x1c: [io  0xec00-0xec03]
[    0.317843] pci 0000:02:00.1: reg 0x20: [io  0xeb00-0xeb0f]
[    0.317949] pci 0000:02:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.317960] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.317964] pci 0000:00:1c.0:   bridge window [io  0xe000-0xefff]
[    0.317968] pci 0000:00:1c.0:   bridge window [mem 0xfbc00000-0xfbcfffff]
[    0.318034] pci 0000:03:00.0: [10ec:8168] type 00 class 0x020000
[    0.318053] pci 0000:03:00.0: reg 0x10: [io  0xde00-0xdeff]
[    0.318080] pci 0000:03:00.0: reg 0x18: [mem 0xfbeff000-0xfbefffff 64bit pref]
[    0.318098] pci 0000:03:00.0: reg 0x20: [mem 0xfbef8000-0xfbefbfff 64bit pref]
[    0.318110] pci 0000:03:00.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    0.318189] pci 0000:03:00.0: supports D1 D2
[    0.318191] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.325468] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.325473] pci 0000:00:1c.1:   bridge window [io  0xd000-0xdfff]
[    0.325477] pci 0000:00:1c.1:   bridge window [mem 0xfbb00000-0xfbbfffff]
[    0.325482] pci 0000:00:1c.1:   bridge window [mem 0xfbe00000-0xfbefffff 64bit pref]
[    0.325524] pci 0000:04:04.0: [102b:051b] type 00 class 0x030000
[    0.325537] pci 0000:04:04.0: reg 0x10: [mem 0xf9000000-0xf9ffffff pref]
[    0.325546] pci 0000:04:04.0: reg 0x14: [mem 0xfb7fc000-0xfb7fffff]
[    0.325556] pci 0000:04:04.0: reg 0x18: [mem 0xfa800000-0xfaffffff]
[    0.325586] pci 0000:04:04.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    0.325652] pci 0000:00:1e.0: PCI bridge to [bus 04] (subtractive decode)
[    0.325658] pci 0000:00:1e.0:   bridge window [mem 0xfa800000-0xfb7fffff]
[    0.325663] pci 0000:00:1e.0:   bridge window [mem 0xf9000000-0xf9ffffff 64bit pref]
[    0.325666] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7] (subtractive decode)
[    0.325669] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff] (subtractive decode)
[    0.325672] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
[    0.325675] pci 0000:00:1e.0:   bridge window [mem 0x000c0000-0x000dffff] (subtractive decode)
[    0.325678] pci 0000:00:1e.0:   bridge window [mem 0xef800000-0xfebfffff] (subtractive decode)
[    0.326128] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
[    0.326171] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[    0.326213] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
[    0.326255] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 *12 14 15)
[    0.326296] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    0.326338] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 *6 7 9 10 11 12 14 15)
[    0.326380] ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
[    0.326421] ACPI: PCI Interrupt Link [LNK1] (IRQs *3 4 5 6 7 9 10 11 12 14 15)
[    0.326553] vgaarb: setting as boot device: PCI:0000:04:04.0
[    0.326556] vgaarb: device added: PCI:0000:04:04.0,decodes=io+mem,owns=io+mem,locks=none
[    0.326559] vgaarb: loaded
[    0.326560] vgaarb: bridge control possible 0000:04:04.0
[    0.326710] SCSI subsystem initialized
[    0.326744] libata version 3.00 loaded.
[    0.326765] ACPI: bus type USB registered
[    0.326780] usbcore: registered new interface driver usbfs
[    0.326789] usbcore: registered new interface driver hub
[    0.326807] usbcore: registered new device driver usb
[    0.326903] PCI: Using ACPI for IRQ routing
[    0.328200] PCI: Discovered peer bus 3f
[    0.328202] PCI: root bus 3f: using default resources
[    0.328204] PCI: Probing PCI hardware (bus 3f)
[    0.328227] PCI host bridge to bus 0000:3f
[    0.328230] pci_bus 0000:3f: root bus resource [io  0x0000-0xffff]
[    0.328232] pci_bus 0000:3f: root bus resource [mem 0x00000000-0xfffffffff]
[    0.328235] pci_bus 0000:3f: No busn resource found for root bus, will use [bus 3f-ff]
[    0.328238] pci_bus 0000:3f: busn_res: can not insert [bus 3f-ff] under domain [bus 00-ff] (conflicts with (null) [bus 00-3f])
[    0.328244] pci 0000:3f:00.0: [8086:2c51] type 00 class 0x060000
[    0.328281] pci 0000:3f:00.1: [8086:2c81] type 00 class 0x060000
[    0.328318] pci 0000:3f:02.0: [8086:2c90] type 00 class 0x060000
[    0.328352] pci 0000:3f:02.1: [8086:2c91] type 00 class 0x060000
[    0.328388] pci 0000:3f:03.0: [8086:2c98] type 00 class 0x060000
[    0.328422] pci 0000:3f:03.1: [8086:2c99] type 00 class 0x060000
[    0.328457] pci 0000:3f:03.4: [8086:2c9c] type 00 class 0x060000
[    0.328492] pci 0000:3f:04.0: [8086:2ca0] type 00 class 0x060000
[    0.328526] pci 0000:3f:04.1: [8086:2ca1] type 00 class 0x060000
[    0.328561] pci 0000:3f:04.2: [8086:2ca2] type 00 class 0x060000
[    0.328595] pci 0000:3f:04.3: [8086:2ca3] type 00 class 0x060000
[    0.328631] pci 0000:3f:05.0: [8086:2ca8] type 00 class 0x060000
[    0.328665] pci 0000:3f:05.1: [8086:2ca9] type 00 class 0x060000
[    0.328699] pci 0000:3f:05.2: [8086:2caa] type 00 class 0x060000
[    0.328733] pci 0000:3f:05.3: [8086:2cab] type 00 class 0x060000
[    0.328778] pci_bus 0000:3f: busn_res: [bus 3f-ff] end is updated to 3f
[    0.328781] pci_bus 0000:3f: busn_res: can not insert [bus 3f] under domain [bus 00-ff] (conflicts with (null) [bus 00-3f])
[    0.328786] PCI: pci_cache_line_size set to 64 bytes
[    0.328854] e820: reserve RAM buffer [mem 0x0009c800-0x0009ffff]
[    0.328856] e820: reserve RAM buffer [mem 0xef7e0000-0xefffffff]
[    0.328944] NetLabel: Initializing
[    0.328946] NetLabel:  domain hash size = 128
[    0.328947] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.328959] NetLabel:  unlabeled traffic allowed by default
[    0.329019] HPET: 8 timers in total, 5 timers will be used for per-cpu timer
[    0.329026] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 24, 25, 26, 27, 28, 0
[    0.329032] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.331069] hpet: hpet2 irq 24 for MSI
[    0.331104] hpet: hpet3 irq 25 for MSI
[    0.331143] hpet: hpet4 irq 26 for MSI
[    0.331178] hpet: hpet5 irq 27 for MSI
[    0.331215] hpet: hpet6 irq 28 for MSI
[    0.331303] Switched to clocksource hpet
[    0.335557] AppArmor: AppArmor Filesystem Enabled
[    0.335607] pnp: PnP ACPI init
[    0.335735] system 00:00: [io  0x04d0-0x04d1] has been reserved
[    0.335739] system 00:00: [io  0x0290-0x029f] has been reserved
[    0.335741] system 00:00: [io  0x0800-0x087f] has been reserved
[    0.335744] system 00:00: [io  0x0290-0x0294] has been reserved
[    0.335746] system 00:00: [io  0x0880-0x088f] has been reserved
[    0.335750] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.335802] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.336011] pnp 00:02: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.336175] pnp 00:03: Plug and Play ACPI device, IDs PNP0400 (active)
[    0.336255] pnp 00:04: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.336305] system 00:05: [io  0x0400-0x047f] could not be reserved
[    0.336308] system 00:05: [io  0x0580-0x05ff] has been reserved
[    0.336311] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.336457] system 00:06: [mem 0xf4000000-0xf7ffffff] has been reserved
[    0.336461] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.336568] pnp 00:07: disabling [mem 0x000f0000-0x000f3fff] because it overlaps 0000:01:00.0 BAR 9 [mem 0x00000000-0x003fffff 64bit]
[    0.336572] pnp 00:07: disabling [mem 0x000f4000-0x000f7fff] because it overlaps 0000:01:00.0 BAR 9 [mem 0x00000000-0x003fffff 64bit]
[    0.336576] pnp 00:07: disabling [mem 0x000f8000-0x000fbfff] because it overlaps 0000:01:00.0 BAR 9 [mem 0x00000000-0x003fffff 64bit]
[    0.336580] pnp 00:07: disabling [mem 0x000fc000-0x000fffff] because it overlaps 0000:01:00.0 BAR 9 [mem 0x00000000-0x003fffff 64bit]
[    0.336584] pnp 00:07: disabling [mem 0x00000000-0x0009ffff] because it overlaps 0000:01:00.0 BAR 9 [mem 0x00000000-0x003fffff 64bit]
[    0.336587] pnp 00:07: disabling [mem 0x00100000-0xef7dffff] because it overlaps 0000:01:00.0 BAR 9 [mem 0x00000000-0x003fffff 64bit]
[    0.336591] pnp 00:07: disabling [mem 0x000e0000-0x000effff] because it overlaps 0000:01:00.0 BAR 9 [mem 0x00000000-0x003fffff 64bit]
[    0.336615] system 00:07: [mem 0xef7e0000-0xef7effff] could not be reserved
[    0.336618] system 00:07: [mem 0xef7f0000-0xef7fffff] has been reserved
[    0.336621] system 00:07: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.336623] system 00:07: [mem 0xfed10000-0xfed1dfff] has been reserved
[    0.336626] system 00:07: [mem 0xfed20000-0xfed8ffff] has been reserved
[    0.336628] system 00:07: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.336631] system 00:07: [mem 0xffb00000-0xffb7ffff] has been reserved
[    0.336633] system 00:07: [mem 0xfff00000-0xffffffff] has been reserved
[    0.336637] system 00:07: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.336644] pnp: PnP ACPI: found 8 devices
[    0.343101] pci_bus 0000:00: max bus depth: 1 pci_try_num: 2
[    0.343132] pci 0000:00:1c.0: BAR 15: assigned [mem 0xef800000-0xef9fffff 64bit pref]
[    0.343142] pci 0000:01:00.0: reg 0x174: [mem 0x00000000-0x00003fff 64bit]
[    0.343151] pci 0000:01:00.0: reg 0x17c: [mem 0x00000000-0x0003ffff 64bit]
[    0.343159] pci 0000:01:00.0: reg 0x174: [mem 0x00000000-0x00003fff 64bit]
[    0.343162] pci 0000:01:00.0: BAR 6: assigned [mem 0xfbd00000-0xfbd7ffff pref]
[    0.343171] pci 0000:01:00.0: reg 0x17c: [mem 0x00000000-0x0003ffff 64bit]
[    0.343174] pci 0000:01:00.0: BAR 9: no space for [mem size 0x00400000 64bit]
[    0.343177] pci 0000:01:00.0: BAR 9: failed to assign [mem size 0x00400000 64bit]
[    0.343186] pci 0000:01:00.0: reg 0x174: [mem 0x00000000-0x00003fff 64bit]
[    0.343189] pci 0000:01:00.0: BAR 7: no space for [mem size 0x00040000 64bit]
[    0.343191] pci 0000:01:00.0: BAR 7: failed to assign [mem size 0x00040000 64bit]
[    0.343194] pci 0000:00:03.0: PCI bridge to [bus 01]
[    0.343197] pci 0000:00:03.0:   bridge window [io  0xc000-0xcfff]
[    0.343201] pci 0000:00:03.0:   bridge window [mem 0xfbd00000-0xfbdfffff]
[    0.343207] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.343210] pci 0000:00:1c.0:   bridge window [io  0xe000-0xefff]
[    0.343215] pci 0000:00:1c.0:   bridge window [mem 0xfbc00000-0xfbcfffff]
[    0.343219] pci 0000:00:1c.0:   bridge window [mem 0xef800000-0xef9fffff 64bit pref]
[    0.343225] pci 0000:03:00.0: BAR 6: assigned [mem 0xfbb00000-0xfbb1ffff pref]
[    0.343228] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.343231] pci 0000:00:1c.1:   bridge window [io  0xd000-0xdfff]
[    0.343236] pci 0000:00:1c.1:   bridge window [mem 0xfbb00000-0xfbbfffff]
[    0.343240] pci 0000:00:1c.1:   bridge window [mem 0xfbe00000-0xfbefffff 64bit pref]
[    0.343246] pci 0000:04:04.0: BAR 6: assigned [mem 0xfb000000-0xfb00ffff pref]
[    0.343249] pci 0000:00:1e.0: PCI bridge to [bus 04]
[    0.343254] pci 0000:00:1e.0:   bridge window [mem 0xfa800000-0xfb7fffff]
[    0.343258] pci 0000:00:1e.0:   bridge window [mem 0xf9000000-0xf9ffffff 64bit pref]
[    0.343264] pci_bus 0000:00: No. 2 try to assign unassigned res
[    0.343266] release child resource [mem 0xfbd00000-0xfbd7ffff pref]
[    0.343268] release child resource [mem 0xfbd80000-0xfbdbffff 64bit]
[    0.343270] release child resource [mem 0xfbdfc000-0xfbdfffff 64bit]
[    0.343272] pci 0000:00:03.0: resource 14 [mem 0xfbd00000-0xfbdfffff] released
[    0.343275] pci 0000:00:03.0: PCI bridge to [bus 01]
[    0.343283] pci 0000:00:03.0: bridge window [mem 0x00100000-0x001fffff] to [bus 01] add_size 500000
[    0.343302] pci 0000:00:03.0: res[14]=[mem 0x00100000-0x001fffff] get_res_add_size add_size 500000
[    0.343312] pci 0000:00:03.0: BAR 14: assigned [mem 0xefa00000-0xefffffff]
[    0.343321] pci 0000:01:00.0: reg 0x174: [mem 0x00000000-0x00003fff 64bit]
[    0.343330] pci 0000:01:00.0: reg 0x17c: [mem 0x00000000-0x0003ffff 64bit]
[    0.343338] pci 0000:01:00.0: reg 0x174: [mem 0x00000000-0x00003fff 64bit]
[    0.343341] pci 0000:01:00.0: res[9]=[mem size 0x00000000 64bit] get_res_add_size add_size 400000
[    0.343344] pci 0000:01:00.0: res[7]=[mem size 0x00000000 64bit] get_res_add_size add_size 40000
[    0.343348] pci 0000:01:00.0: BAR 6: assigned [mem 0xefa00000-0xefa7ffff pref]
[    0.343356] pci 0000:01:00.0: reg 0x17c: [mem 0x00000000-0x0003ffff 64bit]
[    0.343359] pci 0000:01:00.0: BAR 9: assigned [mem 0xefa80000-0xefe7ffff 64bit]
[    0.343372] pci 0000:01:00.0: reg 0x174: [mem 0x00000000-0x00003fff 64bit]
[    0.343375] pci 0000:01:00.0: BAR 7: assigned [mem 0xefe80000-0xefebffff 64bit]
[    0.343381] pci 0000:00:03.0: PCI bridge to [bus 01]
[    0.343384] pci 0000:00:03.0:   bridge window [io  0xc000-0xcfff]
[    0.343388] pci 0000:00:03.0:   bridge window [mem 0xefa00000-0xefffffff]
[    0.343394] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.343397] pci 0000:00:1c.0:   bridge window [io  0xe000-0xefff]
[    0.343402] pci 0000:00:1c.0:   bridge window [mem 0xfbc00000-0xfbcfffff]
[    0.343406] pci 0000:00:1c.0:   bridge window [mem 0xef800000-0xef9fffff 64bit pref]
[    0.343412] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.343415] pci 0000:00:1c.1:   bridge window [io  0xd000-0xdfff]
[    0.343420] pci 0000:00:1c.1:   bridge window [mem 0xfbb00000-0xfbbfffff]
[    0.343424] pci 0000:00:1c.1:   bridge window [mem 0xfbe00000-0xfbefffff 64bit pref]
[    0.343429] pci 0000:00:1e.0: PCI bridge to [bus 04]
[    0.343434] pci 0000:00:1e.0:   bridge window [mem 0xfa800000-0xfb7fffff]
[    0.343438] pci 0000:00:1e.0:   bridge window [mem 0xf9000000-0xf9ffffff 64bit pref]
[    0.343444] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    0.343446] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    0.343449] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    0.343451] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000dffff]
[    0.343453] pci_bus 0000:00: resource 8 [mem 0xef800000-0xfebfffff]
[    0.343456] pci_bus 0000:01: resource 0 [io  0xc000-0xcfff]
[    0.343458] pci_bus 0000:01: resource 1 [mem 0xefa00000-0xefffffff]
[    0.343460] pci_bus 0000:02: resource 0 [io  0xe000-0xefff]
[    0.343463] pci_bus 0000:02: resource 1 [mem 0xfbc00000-0xfbcfffff]
[    0.343465] pci_bus 0000:02: resource 2 [mem 0xef800000-0xef9fffff 64bit pref]
[    0.343468] pci_bus 0000:03: resource 0 [io  0xd000-0xdfff]
[    0.343470] pci_bus 0000:03: resource 1 [mem 0xfbb00000-0xfbbfffff]
[    0.343472] pci_bus 0000:03: resource 2 [mem 0xfbe00000-0xfbefffff 64bit pref]
[    0.343475] pci_bus 0000:04: resource 1 [mem 0xfa800000-0xfb7fffff]
[    0.343478] pci_bus 0000:04: resource 2 [mem 0xf9000000-0xf9ffffff 64bit pref]
[    0.343480] pci_bus 0000:04: resource 4 [io  0x0000-0x0cf7]
[    0.343482] pci_bus 0000:04: resource 5 [io  0x0d00-0xffff]
[    0.343485] pci_bus 0000:04: resource 6 [mem 0x000a0000-0x000bffff]
[    0.343487] pci_bus 0000:04: resource 7 [mem 0x000c0000-0x000dffff]
[    0.343489] pci_bus 0000:04: resource 8 [mem 0xef800000-0xfebfffff]
[    0.343493] pci_bus 0000:3f: resource 4 [io  0x0000-0xffff]
[    0.343495] pci_bus 0000:3f: resource 5 [mem 0x00000000-0xfffffffff]
[    0.343518] NET: Registered protocol family 2
[    0.343699] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.344025] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.344281] TCP: Hash tables configured (established 131072 bind 65536)
[    0.344302] TCP: reno registered
[    0.344318] UDP hash table entries: 8192 (order: 6, 262144 bytes)
[    0.344424] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes)
[    0.344551] NET: Registered protocol family 1
[    0.375400] pci 0000:04:04.0: Video device with shadowed ROM
[    0.375418] PCI: CLS 64 bytes, default 64
[    0.375455] Trying to unpack rootfs image as initramfs...
[    0.597226] Freeing initrd memory: 15064K (ffff880036284000 - ffff88003713a000)
[    0.597253] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.597256] software IO TLB [mem 0xeb7e0000-0xef7e0000] (64MB) mapped at [ffff8800eb7e0000-ffff8800ef7dffff]
[    0.597562] microcode: CPU0 sig=0x106e5, pf=0x2, revision=0x4
[    0.597569] microcode: CPU1 sig=0x106e5, pf=0x2, revision=0x4
[    0.597576] microcode: CPU2 sig=0x106e5, pf=0x2, revision=0x4
[    0.597583] microcode: CPU3 sig=0x106e5, pf=0x2, revision=0x4
[    0.597590] microcode: CPU4 sig=0x106e5, pf=0x2, revision=0x4
[    0.597597] microcode: CPU5 sig=0x106e5, pf=0x2, revision=0x4
[    0.597603] microcode: CPU6 sig=0x106e5, pf=0x2, revision=0x4
[    0.597609] microcode: CPU7 sig=0x106e5, pf=0x2, revision=0x4
[    0.597667] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    0.597692] Scanning for low memory corruption every 60 seconds
[    0.598017] futex hash table entries: 2048 (order: 5, 131072 bytes)
[    0.598061] audit: initializing netlink subsys (disabled)
[    0.598073] audit: type=2000 audit(1423360399.492:1): initialized
[    0.598282] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.599599] VFS: Disk quotas dquot_6.5.2
[    0.599634] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.599905] fuse init (API version 7.23)
[    0.600399] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    0.600404] io scheduler noop registered
[    0.600406] io scheduler deadline registered (default)
[    0.600432] io scheduler cfq registered
[    0.600824] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.600838] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    0.600863] vesafb: mode is 1024x768x32, linelength=4096, pages=0
[    0.600865] vesafb: scrolling: redraw
[    0.600867] vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.600879] vesafb: framebuffer at 0xf9000000, mapped to 0xffffc90005b80000, using 3072k, total 3072k
[    0.719438] Console: switching to colour frame buffer device 128x48
[    0.839335] fb0: VESA VGA frame buffer device
[    0.840339] intel_idle: MWAIT substates: 0x1120
[    0.841349] intel_idle: v0.4 model 0x1E
[    0.842196] intel_idle: lapic_timer_reliable_states 0x2
[    0.843587] ipmi message handler version 39.2
[    0.844605] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.846456] ACPI: Power Button [PWRB]
[    0.847298] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.848940] ACPI: Power Button [PWRF]
[    0.850667] GHES: HEST is not enabled!
[    0.851546] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.873333] 00:02: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.876328] Linux agpgart interface v0.103
[    0.878313] brd: module loaded
[    0.879526] loop: module loaded
[    0.880539] libphy: Fixed MDIO Bus: probed
[    0.881511] tun: Universal TUN/TAP device driver, 1.6
[    0.882626] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    0.884034] PPP generic driver version 2.4.2
[    0.885017] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.886463] ehci-pci: EHCI PCI platform driver
[    0.887546] ehci-pci 0000:00:1a.7: EHCI Host Controller
[    0.888706] ehci-pci 0000:00:1a.7: new USB bus registered, assigned bus number 1
[    0.937542] ehci-pci 0000:00:1a.7: debug port 2
[    0.990477] ehci-pci 0000:00:1a.7: cache line size of 64 is not supported
[    1.039642] ehci-pci 0000:00:1a.7: irq 18, io mem 0xfbfff000
[    1.099367] ehci-pci 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    1.147067] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    1.195124] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.243122] usb usb1: Product: EHCI Host Controller
[    1.290793] usb usb1: Manufacturer: Linux 3.19.0-rc7-patch03 ehci_hcd
[    1.338674] usb usb1: SerialNumber: 0000:00:1a.7
[    1.386091] hub 1-0:1.0: USB hub found
[    1.432940] hub 1-0:1.0: 6 ports detected
[    1.479307] ehci-pci 0000:00:1d.7: EHCI Host Controller
[    1.525386] ehci-pci 0000:00:1d.7: new USB bus registered, assigned bus number 2
[    1.571507] ehci-pci 0000:00:1d.7: debug port 2
[    1.595428] tsc: Refined TSC clocksource calibration: 2798.007 MHz
[    1.667549] ehci-pci 0000:00:1d.7: cache line size of 64 is not supported
[    1.714848] ehci-pci 0000:00:1d.7: irq 23, io mem 0xfbffe000
[    1.771485] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    1.817915] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    1.864733] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.911678] usb usb2: Product: EHCI Host Controller
[    1.958537] usb usb2: Manufacturer: Linux 3.19.0-rc7-patch03 ehci_hcd
[    2.005595] usb usb2: SerialNumber: 0000:00:1d.7
[    2.052004] hub 2-0:1.0: USB hub found
[    2.097478] hub 2-0:1.0: 8 ports detected
[    2.142436] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.188132] ohci-pci: OHCI PCI platform driver
[    2.233925] uhci_hcd: USB Universal Host Controller Interface driver
[    2.280550] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    2.326900] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
[    2.373016] uhci_hcd 0000:00:1a.0: detected 2 ports
[    2.417885] uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000ff00
[    2.462180] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[    2.506542] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.551345] usb usb3: Product: UHCI Host Controller
[    2.595709] usb usb3: Manufacturer: Linux 3.19.0-rc7-patch03 uhci_hcd
[    2.640065] usb usb3: SerialNumber: 0000:00:1a.0
[    2.683695] Switched to clocksource tsc
[    2.683876] hub 3-0:1.0: USB hub found
[    2.683882] hub 3-0:1.0: 2 ports detected
[    2.684031] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    2.684035] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
[    2.684043] uhci_hcd 0000:00:1a.1: detected 2 ports
[    2.684082] uhci_hcd 0000:00:1a.1: irq 21, io base 0x0000fe00
[    2.684121] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    2.684122] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.684123] usb usb4: Product: UHCI Host Controller
[    2.684124] usb usb4: Manufacturer: Linux 3.19.0-rc7-patch03 uhci_hcd
[    2.684124] usb usb4: SerialNumber: 0000:00:1a.1
[    2.684339] hub 4-0:1.0: USB hub found
[    2.684345] hub 4-0:1.0: 2 ports detected
[    2.684489] uhci_hcd 0000:00:1a.2: UHCI Host Controller
[    2.684492] uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus number 5
[    2.684501] uhci_hcd 0000:00:1a.2: detected 2 ports
[    2.684529] uhci_hcd 0000:00:1a.2: irq 18, io base 0x0000fd00
[    2.684568] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[    2.684569] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.684570] usb usb5: Product: UHCI Host Controller
[    2.684571] usb usb5: Manufacturer: Linux 3.19.0-rc7-patch03 uhci_hcd
[    2.684571] usb usb5: SerialNumber: 0000:00:1a.2
[    2.684783] hub 5-0:1.0: USB hub found
[    2.684789] hub 5-0:1.0: 2 ports detected
[    2.684938] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    2.684941] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 6
[    2.684950] uhci_hcd 0000:00:1d.0: detected 2 ports
[    2.684978] uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000fc00
[    2.685018] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
[    2.685019] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.685020] usb usb6: Product: UHCI Host Controller
[    2.685020] usb usb6: Manufacturer: Linux 3.19.0-rc7-patch03 uhci_hcd
[    2.685021] usb usb6: SerialNumber: 0000:00:1d.0
[    2.685218] hub 6-0:1.0: USB hub found
[    2.685223] hub 6-0:1.0: 2 ports detected
[    2.685373] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    2.685376] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 7
[    2.685385] uhci_hcd 0000:00:1d.1: detected 2 ports
[    2.685423] uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000fb00
[    2.685463] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
[    2.685464] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.685464] usb usb7: Product: UHCI Host Controller
[    2.685465] usb usb7: Manufacturer: Linux 3.19.0-rc7-patch03 uhci_hcd
[    2.685466] usb usb7: SerialNumber: 0000:00:1d.1
[    2.685653] hub 7-0:1.0: USB hub found
[    2.685657] hub 7-0:1.0: 2 ports detected
[    2.685802] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    2.685805] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 8
[    2.685814] uhci_hcd 0000:00:1d.2: detected 2 ports
[    2.685841] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000fa00
[    2.685880] usb usb8: New USB device found, idVendor=1d6b, idProduct=0001
[    2.685881] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.685882] usb usb8: Product: UHCI Host Controller
[    2.685882] usb usb8: Manufacturer: Linux 3.19.0-rc7-patch03 uhci_hcd
[    2.685883] usb usb8: SerialNumber: 0000:00:1d.2
[    2.686043] hub 8-0:1.0: USB hub found
[    2.686047] hub 8-0:1.0: 2 ports detected
[    2.686186] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[    2.686189] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 9
[    2.686198] uhci_hcd 0000:00:1d.3: detected 2 ports
[    2.686226] uhci_hcd 0000:00:1d.3: irq 16, io base 0x0000f900
[    2.686264] usb usb9: New USB device found, idVendor=1d6b, idProduct=0001
[    2.686265] usb usb9: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.686266] usb usb9: Product: UHCI Host Controller
[    2.686267] usb usb9: Manufacturer: Linux 3.19.0-rc7-patch03 uhci_hcd
[    2.686267] usb usb9: SerialNumber: 0000:00:1d.3
[    2.686452] hub 9-0:1.0: USB hub found
[    2.686455] hub 9-0:1.0: 2 ports detected
[    2.686552] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    2.686552] i8042: PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
[    2.686714] serio: i8042 KBD port at 0x60,0x64 irq 1
[    2.686980] mousedev: PS/2 mouse device common for all mice
[    2.687532] rtc_cmos 00:01: RTC can wake from S4
[    2.687824] rtc_cmos 00:01: rtc core: registered rtc_cmos as rtc0
[    2.687880] rtc_cmos 00:01: alarms up to one month, 242 bytes nvram, hpet irqs
[    2.687924] device-mapper: uevent: version 1.0.3
[    2.688101] device-mapper: ioctl: 4.29.0-ioctl (2014-10-28) initialised: dm-devel@redhat.com
[    2.688163] TCP: cubic registered
[    2.688232] NET: Registered protocol family 10
[    2.708028] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input2
[    2.727717] NET: Registered protocol family 17
[    2.727724] Key type dns_resolver registered
[    2.728442] registered taskstats version 1
[    2.730334] Key type trusted registered
[    2.734075] Key type encrypted registered
[    2.734078] AppArmor: AppArmor sha1 policy hashing enabled
[    2.734080] ima: No TPM chip found, activating TPM-bypass!
[    2.734093] evm: HMAC attrs: 0x1
[    2.734664]   Magic number: 3:18:862
[    2.771336] rtc_cmos 00:01: setting system clock to 2015-02-08 01:53:21 UTC (1423360401)
[    2.859284] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    2.859285] EDD information not available.
[    2.859317] PM: Hibernation image not present or could not be loaded.
[    3.023515] usb 5-2: new low-speed USB device number 2 using uhci_hcd
[    3.222662] usb 5-2: New USB device found, idVendor=04b4, idProduct=0101
[    3.222664] usb 5-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.222665] usb 5-2: Product: Cypress PS/2 Keyboard - PS/2 Mouse
[    3.222666] usb 5-2: Manufacturer: Cypress
[    6.849676] sched: RT throttling activated
[    6.896052] Freeing unused kernel memory: 1212K (ffffffff81d09000 - ffffffff81e38000)
[    6.943217] Write protecting the kernel read-only data: 12288k
[    6.991157] Freeing unused kernel memory: 1376K (ffff8800016a8000 - ffff880001800000)
[    7.039844] Freeing unused kernel memory: 824K (ffff880001b32000 - ffff880001c00000)
[    7.149372] systemd-udevd[132]: starting version 204
[    7.202500] mpt2sas version 18.100.00.00 loaded
[    7.251712] mpt2sas 0000:01:00.0: can't enable device: BAR 1 [mem 0x00000000-0x00003fff 64bit] not claimed
[    7.252441] scsi host1: pata_jmicron
[    7.252578] scsi host2: pata_jmicron
[    7.252624] ata1: PATA max UDMA/100 cmd 0xef00 ctl 0xee00 bmdma 0xeb00 irq 17
[    7.252625] ata2: PATA max UDMA/100 cmd 0xed00 ctl 0xec00 bmdma 0xeb08 irq 17
[    7.503607] mpt2sas0: pci_enable_device_mem: failed
[    7.553284] mpt2sas0: failure at drivers/scsi/mpt2sas/mpt2sas_scsih.c:8192/_scsih_probe()!
[    7.604370] hidraw: raw HID events driver (C) Jiri Kosina
[    7.656303] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    7.656329] ahci 0000:00:1f.2: version 3.0
[    7.656504] ahci 0000:00:1f.2: SSS flag set, parallel bus scan disabled
[    7.656607] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 3 Gbps 0x3f impl SATA mode
[    7.656610] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pmp pio slum part ems apst 
[    7.683011] usbcore: registered new interface driver usbhid
[    7.683012] usbhid: USB HID core driver
[    7.696401] scsi host3: ahci
[    7.696511] scsi host4: ahci
[    7.696616] scsi host5: ahci
[    7.696713] scsi host6: ahci
[    7.696807] scsi host7: ahci
[    7.696904] scsi host8: ahci
[    7.696945] ata3: SATA max UDMA/133 abar m2048@0xfbffd000 port 0xfbffd100 irq 29
[    7.696948] ata4: SATA max UDMA/133 abar m2048@0xfbffd000 port 0xfbffd180 irq 29
[    7.696950] ata5: SATA max UDMA/133 abar m2048@0xfbffd000 port 0xfbffd200 irq 29
[    7.696953] ata6: SATA max UDMA/133 abar m2048@0xfbffd000 port 0xfbffd280 irq 29
[    7.696955] ata7: SATA max UDMA/133 abar m2048@0xfbffd000 port 0xfbffd300 irq 29
[    7.696958] ata8: SATA max UDMA/133 abar m2048@0xfbffd000 port 0xfbffd380 irq 29
[    7.697114] ahci 0000:02:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
[    7.697116] ahci 0000:02:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
[    7.697386] scsi host9: ahci
[    7.697481] scsi host10: ahci
[    7.697524] ata9: SATA max UDMA/133 abar m8192@0xfbcfe000 port 0xfbcfe100 irq 16
[    7.697527] ata10: SATA max UDMA/133 abar m8192@0xfbcfe000 port 0xfbcfe180 irq 16
[    7.861320] input: Cypress Cypress PS/2 Keyboard - PS/2 Mouse as /devices/pci0000:00/0000:00:1a.2/usb5/5-2/5-2:1.0/0003:04B4:0101.0001/input/input3
[    7.916181] hid-generic 0003:04B4:0101.0001: input,hidraw0: USB HID v1.00 Keyboard [Cypress Cypress PS/2 Keyboard - PS/2 Mouse] on usb-0000:00:1a.2-2/input0
[    7.916291] input: Cypress Cypress PS/2 Keyboard - PS/2 Mouse as /devices/pci0000:00/0000:00:1a.2/usb5/5-2/5-2:1.1/0003:04B4:0101.0002/input/input4
[    7.916634] hid-generic 0003:04B4:0101.0002: input,hidraw1: USB HID v1.00 Mouse [Cypress Cypress PS/2 Keyboard - PS/2 Mouse] on usb-0000:00:1a.2-2/input1
[    8.015993] ata9: SATA link down (SStatus 0 SControl 300)
[    8.016051] ata10: SATA link down (SStatus 0 SControl 300)
[    8.187884] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    8.189647] ata3.00: ATA-8: WDC WD2000FYYZ-01UL1B2, 01.01K03, max UDMA/133
[    8.189648] ata3.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
[    8.190775] ata3.00: configured for UDMA/133
[    8.190987] scsi 3:0:0:0: Direct-Access     ATA      WDC WD2000FYYZ-0 1K03 PQ: 0 ANSI: 5
[    8.191346] sd 3:0:0:0: [sda] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
[    8.191348] sd 3:0:0:0: Attached scsi generic sg0 type 0
[    8.191377] sd 3:0:0:0: [sda] Write Protect is off
[    8.191378] sd 3:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    8.191388] sd 3:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    8.212300]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
[    8.212808] sd 3:0:0:0: [sda] Attached SCSI disk
[    8.679968] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    8.698742] ata4.00: ATA-8: Hitachi HDT721010SLA360, ST6OA31B, max UDMA/133
[    8.698743] ata4.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
[    8.700011] ata4.00: configured for UDMA/133
[    8.700106] scsi 4:0:0:0: Direct-Access     ATA      Hitachi HDT72101 A31B PQ: 0 ANSI: 5
[    8.700488] sd 4:0:0:0: [sdb] 1953525168 512-byte logical blocks: (1.00 TB/931 GiB)
[    8.700521] sd 4:0:0:0: [sdb] Write Protect is off
[    8.700522] sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    8.700529] sd 4:0:0:0: Attached scsi generic sg1 type 0
[    8.700532] sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    8.727138]  sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 >
[    8.727484] sd 4:0:0:0: [sdb] Attached SCSI disk
[    9.019951] ata5: SATA link down (SStatus 0 SControl 300)
[    9.511966] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    9.518666] ata6.00: ATA-8: WDC WD1200AAJS-00VTA0, 01.01B01, max UDMA/133
[    9.518667] ata6.00: 234441648 sectors, multi 0: LBA48 
[    9.526151] ata6.00: configured for UDMA/133
[    9.526315] scsi 6:0:0:0: Direct-Access     ATA      WDC WD1200AAJS-0 1B01 PQ: 0 ANSI: 5
[    9.526700] sd 6:0:0:0: Attached scsi generic sg2 type 0
[    9.526746] sd 6:0:0:0: [sdc] 234441648 512-byte logical blocks: (120 GB/111 GiB)
[    9.527070] sd 6:0:0:0: [sdc] Write Protect is off
[    9.527071] sd 6:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    9.527166] sd 6:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    9.552542]  sdc: sdc1 sdc2 sdc3 sdc4
[    9.553868] sd 6:0:0:0: [sdc] Attached SCSI disk
[    9.844115] ata7: SATA link down (SStatus 0 SControl 300)
[   10.164071] ata8: SATA link down (SStatus 0 SControl 300)
[   10.228314] random: nonblocking pool is initialized
[   10.276055] floppy0: no floppy controllers found
[   10.276066] work still pending
[   11.596100] r8169 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM control
[   11.648944] r8169 0000:03:00.0 eth0: RTL8168d/8111d at 0xffffc900018fe000, 00:24:1d:d9:29:dd, XID 083000c0 IRQ 30
[   11.701492] r8169 0000:03:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[   15.774057] EXT4-fs (sdc4): mounting ext2 file system using the ext4 subsystem
[   15.850785] EXT4-fs (sdc4): mounted filesystem without journal. Opts: (null)
[   17.713610] init: plymouth-upstart-bridge main process (226) terminated with status 1
[   17.765888] init: plymouth-upstart-bridge main process ended, respawning
[   28.993668] Adding 9798652k swap on /dev/sdc2.  Priority:-1 extents:1 across:9798652k FS
[   29.269962] systemd-udevd[340]: starting version 204
[   30.201341] ACPI Warning: SystemIO range 0x0000000000000428-0x000000000000042f conflicts with OpRegion 0x000000000000042c-0x000000000000042d (\GP2C) (20141107/utaddress-258)
[   30.309620] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[   30.365655] lpc_ich: Resource conflict(s) found affecting gpio_ich
[   30.365712] parport_pc 00:03: reported by Plug and Play ACPI
[   30.365802] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
[   30.535295] lp0: using parport0 (interrupt-driven).
[   30.545204] audit: type=1400 audit(1423360429.302:2): apparmor="STATUS" operation="profile_load" name="/sbin/dhclient" pid=463 comm="apparmor_parser"
[   30.545291] audit: type=1400 audit(1423360429.302:3): apparmor="STATUS" operation="profile_load" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=463 comm="apparmor_parser"
[   30.545370] audit: type=1400 audit(1423360429.302:4): apparmor="STATUS" operation="profile_load" name="/usr/lib/connman/scripts/dhclient-script" pid=463 comm="apparmor_parser"
[   30.551813] audit: type=1400 audit(1423360429.310:5): apparmor="STATUS" operation="profile_replace" name="/sbin/dhclient" pid=462 comm="apparmor_parser"
[   30.551894] audit: type=1400 audit(1423360429.310:6): apparmor="STATUS" operation="profile_replace" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=462 comm="apparmor_parser"
[   30.551965] audit: type=1400 audit(1423360429.310:7): apparmor="STATUS" operation="profile_replace" name="/usr/lib/connman/scripts/dhclient-script" pid=462 comm="apparmor_parser"
[   31.227351] gpio_ich: GPIO from 436 to 511 on gpio_ich
[   31.443193] EDAC MC: Ver: 3.0.0
[   31.516599] ppdev: user-space parallel port driver
[   31.589205] EDAC MC0: Giving out device to module i7core_edac.c controller i7 core #0: DEV 0000:3f:03.0 (POLLED)
[   31.662929] EDAC PCI0: Giving out device to module i7core_edac controller EDAC PCI controller: DEV 0000:3f:03.0 (POLLED)
[   31.737813] EDAC i7core: Driver loaded, 1 memory controller(s) found.
[   31.813275] kvm: VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL does not work properly. Using workaround
[   32.213731] sound hdaudioC0D2: autoconfig: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
[   32.289830] sound hdaudioC0D2:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   32.365719] sound hdaudioC0D2:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[   32.440958] sound hdaudioC0D2:    mono: mono_out=0x0
[   32.516197] sound hdaudioC0D2:    dig-out=0x1e/0x0
[   32.590587] sound hdaudioC0D2:    inputs:
[   32.663607] sound hdaudioC0D2:      Rear Mic=0x18
[   32.736459] sound hdaudioC0D2:      Front Mic=0x19
[   32.808794] sound hdaudioC0D2:      Line=0x1a
[   32.881283] sound hdaudioC0D2:      CD=0x1c
[   32.953051] sound hdaudioC0D2:    dig-in=0x1f
[   33.034632] input: HDA Intel MID Rear Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input5
[   33.108084] input: HDA Intel MID Front Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input6
[   33.181379] input: HDA Intel MID Line as /devices/pci0000:00/0000:00:1b.0/sound/card0/input7
[   33.254187] input: HDA Intel MID Line Out as /devices/pci0000:00/0000:00:1b.0/sound/card0/input8
[   33.962944] EXT4-fs (sdc4): re-mounted. Opts: errors=remount-ro
[   34.389853] init: failsafe main process (653) killed by TERM signal
[   34.533828] floppy0: no floppy controllers found
[   34.986701] audit: type=1400 audit(1423360433.746:8): apparmor="STATUS" operation="profile_load" name="/usr/sbin/cups-browsed" pid=778 comm="apparmor_parser"
[   35.134692] audit: type=1400 audit(1423360433.894:9): apparmor="STATUS" operation="profile_load" name="/usr/sbin/tcpdump" pid=781 comm="apparmor_parser"
[   35.285268] audit: type=1400 audit(1423360434.042:10): apparmor="STATUS" operation="profile_replace" name="/sbin/dhclient" pid=775 comm="apparmor_parser"
[   35.436508] audit: type=1400 audit(1423360434.194:11): apparmor="STATUS" operation="profile_load" name="/usr/lib/cups/backend/cups-pdf" pid=822 comm="apparmor_parser"
[   35.591126] audit: type=1400 audit(1423360434.350:12): apparmor="STATUS" operation="profile_load" name="/usr/lib/lightdm/lightdm-guest-session" pid=774 comm="apparmor_parser"
[   35.753172] audit: type=1400 audit(1423360434.510:13): apparmor="STATUS" operation="profile_replace" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=775 comm="apparmor_parser"
[   35.915825] audit: type=1400 audit(1423360434.674:14): apparmor="STATUS" operation="profile_replace" name="/usr/lib/cups/backend/cups-pdf" pid=779 comm="apparmor_parser"
[   36.078523] audit: type=1400 audit(1423360434.838:15): apparmor="STATUS" operation="profile_load" name="/usr/sbin/cupsd" pid=779 comm="apparmor_parser"
[   36.078731] audit: type=1400 audit(1423360434.838:16): apparmor="STATUS" operation="profile_replace" name="/usr/sbin/cupsd" pid=822 comm="apparmor_parser"
[   36.078794] audit: type=1400 audit(1423360434.838:17): apparmor="STATUS" operation="profile_load" name="chromium" pid=774 comm="apparmor_parser"
[   36.078818] audit: type=1400 audit(1423360434.838:18): apparmor="STATUS" operation="profile_replace" name="/usr/lib/connman/scripts/dhclient-script" pid=775 comm="apparmor_parser"
[   36.174592] Bluetooth: Core ver 2.20
[   36.174604] NET: Registered protocol family 31
[   36.174605] Bluetooth: HCI device and connection manager initialized
[   36.174608] Bluetooth: HCI socket layer initialized
[   36.174610] Bluetooth: L2CAP socket layer initialized
[   36.174614] Bluetooth: SCO socket layer initialized
[   36.225930] init: cups main process (845) killed by HUP signal
[   36.225938] init: cups main process ended, respawning
[   36.250159] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   36.250160] Bluetooth: BNEP filters: protocol multicast
[   36.250163] Bluetooth: BNEP socket layer initialized
[   36.383062] Bluetooth: RFCOMM TTY layer initialized
[   36.383065] Bluetooth: RFCOMM socket layer initialized
[   36.383068] Bluetooth: RFCOMM ver 1.11
[   37.219293] r8169 0000:03:00.0 eth0: link down
[   37.219313] r8169 0000:03:00.0 eth0: link down
[   37.219337] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   37.946547] audit: type=1400 audit(1423360436.706:19): apparmor="STATUS" operation="profile_load" name="/usr/bin/evince" pid=776 comm="apparmor_parser"
[   37.946858] audit: type=1400 audit(1423360436.706:20): apparmor="STATUS" operation="profile_load" name="sanitized_helper" pid=776 comm="apparmor_parser"
[   37.968380] audit: type=1400 audit(1423360436.726:21): apparmor="STATUS" operation="profile_load" name="/usr/bin/evince-previewer" pid=776 comm="apparmor_parser"
[   39.978426] r8169 0000:03:00.0 eth0: link up
[   39.978432] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   42.079590] init: alsa-restore main process (973) terminated with status 99
[   42.170239] audit_printk_skb: 9 callbacks suppressed
[   42.170240] audit: type=1400 audit(1423360440.930:25): apparmor="STATUS" operation="profile_replace" name="/usr/sbin/cups-browsed" pid=1023 comm="apparmor_parser"
[   46.897623] init: plymouth-upstart-bridge main process ended, respawning
[   66.300368] audit: type=1400 audit(1423360465.058:26): apparmor="STATUS" operation="profile_replace" name="/usr/lib/cups/backend/cups-pdf" pid=2215 comm="apparmor_parser"
[   66.300374] audit: type=1400 audit(1423360465.058:27): apparmor="STATUS" operation="profile_replace" name="/usr/sbin/cupsd" pid=2215 comm="apparmor_parser"
[   66.300662] audit: type=1400 audit(1423360465.058:28): apparmor="STATUS" operation="profile_replace" name="/usr/sbin/cupsd" pid=2215 comm="apparmor_parser"

--------------030805080809080404030206--
