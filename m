Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from resqmta-po-10v.sys.comcast.net ([96.114.154.169]:60114 "EHLO
	resqmta-po-10v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932146AbbBBSEA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Feb 2015 13:04:00 -0500
Message-ID: <54CFBC0E.4080102@nwtrail.com>
Date: Mon, 02 Feb 2015 10:03:58 -0800
From: Paul Johnson <pjay@nwtrail.com>
Reply-To: pjay@nwtrail.com
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [problem] mpt2sas load fails with LSISAS2008
References: <54C81B4E.7060900@nwtrail.com>	<CAErSpo6P-gm1xFjLrbKBU+P3zUHY-RGMkhaVpWsK7vDz_wK=YQ@mail.gmail.com>	<54CBB062.4040801@nwtrail.com> <CAE9FiQUxD8g4KG9CYe1znb5Lw5skkq=9QSOgkmGUDbhsaDq2Qw@mail.gmail.com>
In-Reply-To: <CAE9FiQUxD8g4KG9CYe1znb5Lw5skkq=9QSOgkmGUDbhsaDq2Qw@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------070501030909050107030307"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------070501030909050107030307
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 01/30/2015 01:37 PM, Yinghai Lu wrote:
> On Fri, Jan 30, 2015 at 8:25 AM, Paul Johnson <pjay@nwtrail.com> wrote:
>> There is a bug report here https://bugzilla.kernel.org/show_bug.cgi?id=92351
>>
>> I found mpt2sas is loaded successfully up through 3.4.0 and fails in 3.4.1;
>> in 3.4.1 it will load
>> if pci=realloc=off is added to the command line.
>>
>> A file with dmesg output for 3.4.0 3.4.1 and 3.4.1 with pci=realloc=off is
>> attached to the bug report.
>
> ok, when pci realloc is enabled, we do assign the new correct resource
> to the all BAR
> including IOV bars.
>
> [    0.337471] pci 0000:00:03.0: resource 14 [mem
> 0xfbd00000-0xfbdfffff] released
> [    0.337474] pci 0000:00:03.0: PCI bridge to [bus 01-01]
> [    0.337482] pci 0000:00:03.0: bridge window [mem
> 0x00100000-0x001fffff] to [bus 01-01] add_size 500000
> [    0.337503] pci 0000:00:03.0: res[14]=[mem 0x00100000-0x001fffff]
> get_res_add_size add_size 500000
> [    0.337507] pci 0000:00:03.0: BAR 14: assigned [mem 0xefb00000-0xf00fffff]
> [    0.337517] pci 0000:01:00.0: reg 174: [mem 0xfbd00000-0xfbd03fff 64bit]
> [    0.337525] pci 0000:01:00.0: reg 17c: [mem 0x00000000-0x0003ffff 64bit]
> [    0.337529] pci 0000:01:00.0: res[9]=[mem
> 0x00000000-0xffffffffffffffff 64bit] get_res_add_size add_size 400000
> [    0.337533] pci 0000:01:00.0: res[7]=[mem
> 0x00000000-0xffffffffffffffff 64bit] get_res_add_size add_size 40000
> [    0.337538] pci 0000:01:00.0: BAR 3: assigned [mem
> 0xefb00000-0xefb3ffff 64bit]
> [    0.337550] pci 0000:01:00.0: reg 17c: [mem 0x00000000-0x0003ffff 64bit]
> [    0.337553] pci 0000:01:00.0: BAR 9: assigned [mem
> 0xefb40000-0xeff3ffff 64bit]
> [    0.337558] pci 0000:01:00.0: BAR 1: assigned [mem
> 0xeff40000-0xeff43fff 64bit]
> [    0.337570] pci 0000:01:00.0: reg 174: [mem 0xfbd00000-0xfbd03fff 64bit]
> [    0.337573] pci 0000:01:00.0: BAR 7: assigned [mem
> 0xeff44000-0xeff83fff 64bit]
>
> but looks like the mpt2 firmware does not like us to change the bar.
>
> [    3.197114] mpt2sas version 12.100.00.00 loaded
> [    3.197206] scsi8 : Fusion MPT SAS Host
> [    3.197517] mpt2sas0: 64 BIT PCI BUS DMA ADDRESSING SUPPORTED,
> total mem (16426944 kB)
> [    3.197584] mpt2sas 0000:01:00.0: irq 46 for MSI/MSI-X
> [    3.197619] mpt2sas0-msix0: PCI-MSI-X enabled: IRQ 46
> [    3.197624] mpt2sas0: iomem(0x00000000eff40000),
> mapped(0xffffc900065c8000), size(16384)
> [    3.197629] mpt2sas0: ioport(0x000000000000ce00), size(256)
> [    3.197659] mpt2sas0: doorbell is in use  (line=3015)
> [    3.197664] mpt2sas0: _base_get_ioc_facts: handshake failed (r=-14)
> [    3.197667] mpt2sas0: sending diag reset !!
> [    3.357230] mpt2sas0: diag reset: FAILED
> [    3.357298] mpt2sas0: failure at
> /home/apw/COD/linux/drivers/scsi/mpt2sas/mpt2sas_scsih.c:8038/_scsih_probe()!
>
> Please try if attached patch could avoid the problem.
>
> Thanks
>
> Yinghai
>
I applied the patch but, unfortunately, the problem is still there. 
dmesg is attached.
Thanks,
Paul


--------------070501030909050107030307
Content-Type: text/plain; charset=UTF-8;
 name="dmesg-3.19.0-rc6-patch01"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg-3.19.0-rc6-patch01"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.19.0-rc6-patch01 (paulj@x1404ubu64) (gcc version 4.8.2 (Ubuntu 4.8.2-19ubuntu1) ) #4 SMP Sun Feb 1 11:11:32 PST 2015
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-3.19.0-rc6-patch01 root=UUID=f604b748-aeb8-4e3d-953f-b5a8b947c191 ro debug ignore_loglevel
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
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-3.19.0-rc6-patch01 root=UUID=f604b748-aeb8-4e3d-953f-b5a8b947c191 ro debug ignore_loglevel
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
[    0.000000] tsc: Fast TSC calibration failed
[    0.000000] tsc: PIT calibration matches HPET. 1 loops
[    0.000000] tsc: Detected 2797.995 MHz processor
[    0.000024] Calibrating delay loop (skipped), value calculated using timer frequency.. 5595.99 BogoMIPS (lpj=11191980)
[    0.000029] pid_max: default: 32768 minimum: 301
[    0.000035] ACPI: Core revision 20141107
[    0.003981] ACPI: All ACPI Tables successfully acquired
[    0.007288] Security Framework initialized
[    0.007300] AppArmor: AppArmor initialized
[    0.008156] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    0.011119] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.012559] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.012578] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.012820] Initializing cgroup subsys devices
[    0.012824] Initializing cgroup subsys freezer
[    0.012827] Initializing cgroup subsys net_cls
[    0.012831] Initializing cgroup subsys blkio
[    0.012833] Initializing cgroup subsys perf_event
[    0.012850] CPU: Physical Processor ID: 0
[    0.012852] CPU: Processor Core ID: 0
[    0.012856] mce: CPU supports 9 MCE banks
[    0.012865] CPU0: Thermal monitoring enabled (TM1)
[    0.012874] Last level iTLB entries: 4KB 512, 2MB 7, 4MB 7
[    0.012874] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    0.012946] Freeing SMP alternatives memory: 24K (ffffffff81e38000 - ffffffff81e3e000)
[    0.012951] ftrace: allocating 26470 entries in 104 pages
[    0.024070] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.063758] smpboot: CPU0: Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz (fam: 06, model: 1e, stepping: 05)
[    0.171605] Performance Events: PEBS fmt1+, 16-deep LBR, Nehalem events, Intel PMU driver.
[    0.171620] perf_event_intel: CPU erratum AAJ80 worked around
[    0.171622] perf_event_intel: CPUID marked event: 'bus cycles' unavailable
[    0.171624] ... version:                3
[    0.171626] ... bit width:              48
[    0.171627] ... generic registers:      4
[    0.171629] ... value mask:             0000ffffffffffff
[    0.171631] ... max period:             000000007fffffff
[    0.171632] ... fixed-purpose events:   3
[    0.171634] ... event mask:             000000070000000f
[    0.172133] x86: Booting SMP configuration:
[    0.172135] .... node  #0, CPUs:      #1
[    0.185356] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.185430]  #2 #3 #4 #5 #6 #7
[    0.264427] x86: Booted up 1 node, 8 CPUs
[    0.264434] smpboot: Total of 8 processors activated (44767.92 BogoMIPS)
[    0.269246] devtmpfs: initialized
[    0.273492] evm: security.selinux
[    0.273494] evm: security.SMACK64
[    0.273496] evm: security.capability
[    0.273538] PM: Registering ACPI NVS region [mem 0xef7e0000-0xef7e1fff] (8192 bytes)
[    0.273738] RTC time: 17:44:53, date: 02/02/15
[    0.273825] NET: Registered protocol family 16
[    0.283598] cpuidle: using governor ladder
[    0.293274] cpuidle: using governor menu
[    0.293328] ACPI: bus type PCI registered
[    0.293331] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.293395] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf4000000-0xf7ffffff] (base 0xf4000000)
[    0.293399] PCI: MMCONFIG at [mem 0xf4000000-0xf7ffffff] reserved in E820
[    0.293455] PCI: Using configuration type 1 for base access
[    0.306762] ACPI: Added _OSI(Module Device)
[    0.306766] ACPI: Added _OSI(Processor Device)
[    0.306767] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.306769] ACPI: Added _OSI(Processor Aggregator Device)
[    0.310921] ACPI: Interpreter enabled
[    0.310927] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_] (20141107/hwxface-580)
[    0.310932] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20141107/hwxface-580)
[    0.310944] ACPI: (supports S0 S3 S4 S5)
[    0.310946] ACPI: Using IOAPIC for interrupt routing
[    0.310963] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.314357] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3f])
[    0.314363] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.314368] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.314549] PCI host bridge to bus 0000:00
[    0.314553] pci_bus 0000:00: root bus resource [bus 00-3f]
[    0.314555] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
[    0.314558] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
[    0.314560] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
[    0.314563] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff]
[    0.314565] pci_bus 0000:00: root bus resource [mem 0xef800000-0xfebfffff]
[    0.314574] pci 0000:00:00.0: [8086:d131] type 00 class 0x060000
[    0.314667] pci 0000:00:03.0: [8086:d138] type 01 class 0x060400
[    0.314717] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    0.314779] pci 0000:00:08.0: [8086:d155] type 00 class 0x088000
[    0.314864] pci 0000:00:08.1: [8086:d156] type 00 class 0x088000
[    0.314949] pci 0000:00:08.2: [8086:d157] type 00 class 0x088000
[    0.315031] pci 0000:00:08.3: [8086:d158] type 00 class 0x088000
[    0.315109] pci 0000:00:10.0: [8086:d150] type 00 class 0x088000
[    0.315180] pci 0000:00:10.1: [8086:d151] type 00 class 0x088000
[    0.315267] pci 0000:00:1a.0: [8086:3b3b] type 00 class 0x0c0300
[    0.315306] pci 0000:00:1a.0: reg 0x20: [io  0xff00-0xff1f]
[    0.315370] pci 0000:00:1a.0: System wakeup disabled by ACPI
[    0.315403] pci 0000:00:1a.1: [8086:3b3e] type 00 class 0x0c0300
[    0.315442] pci 0000:00:1a.1: reg 0x20: [io  0xfe00-0xfe1f]
[    0.315505] pci 0000:00:1a.1: System wakeup disabled by ACPI
[    0.315540] pci 0000:00:1a.2: [8086:3b3f] type 00 class 0x0c0300
[    0.315578] pci 0000:00:1a.2: reg 0x20: [io  0xfd00-0xfd1f]
[    0.315646] pci 0000:00:1a.2: System wakeup disabled by ACPI
[    0.315687] pci 0000:00:1a.7: [8086:3b3c] type 00 class 0x0c0320
[    0.315707] pci 0000:00:1a.7: reg 0x10: [mem 0xfbfff000-0xfbfff3ff]
[    0.315790] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.315826] pci 0000:00:1a.7: System wakeup disabled by ACPI
[    0.315862] pci 0000:00:1b.0: [8086:3b56] type 00 class 0x040300
[    0.315878] pci 0000:00:1b.0: reg 0x10: [mem 0xfbff8000-0xfbffbfff 64bit]
[    0.315945] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.315981] pci 0000:00:1b.0: System wakeup disabled by ACPI
[    0.316014] pci 0000:00:1c.0: [8086:3b42] type 01 class 0x060400
[    0.316080] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.316118] pci 0000:00:1c.0: System wakeup disabled by ACPI
[    0.316151] pci 0000:00:1c.1: [8086:3b44] type 01 class 0x060400
[    0.316217] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.316253] pci 0000:00:1c.1: System wakeup disabled by ACPI
[    0.316291] pci 0000:00:1d.0: [8086:3b36] type 00 class 0x0c0300
[    0.316330] pci 0000:00:1d.0: reg 0x20: [io  0xfc00-0xfc1f]
[    0.316393] pci 0000:00:1d.0: System wakeup disabled by ACPI
[    0.316426] pci 0000:00:1d.1: [8086:3b37] type 00 class 0x0c0300
[    0.316464] pci 0000:00:1d.1: reg 0x20: [io  0xfb00-0xfb1f]
[    0.316528] pci 0000:00:1d.1: System wakeup disabled by ACPI
[    0.316560] pci 0000:00:1d.2: [8086:3b38] type 00 class 0x0c0300
[    0.316599] pci 0000:00:1d.2: reg 0x20: [io  0xfa00-0xfa1f]
[    0.316661] pci 0000:00:1d.2: System wakeup disabled by ACPI
[    0.316694] pci 0000:00:1d.3: [8086:3b39] type 00 class 0x0c0300
[    0.316732] pci 0000:00:1d.3: reg 0x20: [io  0xf900-0xf91f]
[    0.316795] pci 0000:00:1d.3: System wakeup disabled by ACPI
[    0.316835] pci 0000:00:1d.7: [8086:3b34] type 00 class 0x0c0320
[    0.316855] pci 0000:00:1d.7: reg 0x10: [mem 0xfbffe000-0xfbffe3ff]
[    0.316938] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.316975] pci 0000:00:1d.7: System wakeup disabled by ACPI
[    0.317008] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
[    0.317080] pci 0000:00:1e.0: System wakeup disabled by ACPI
[    0.317115] pci 0000:00:1f.0: [8086:3b02] type 00 class 0x060100
[    0.317271] pci 0000:00:1f.2: [8086:3b22] type 00 class 0x010601
[    0.317289] pci 0000:00:1f.2: reg 0x10: [io  0xf800-0xf807]
[    0.317296] pci 0000:00:1f.2: reg 0x14: [io  0xf700-0xf703]
[    0.317303] pci 0000:00:1f.2: reg 0x18: [io  0xf600-0xf607]
[    0.317311] pci 0000:00:1f.2: reg 0x1c: [io  0xf500-0xf503]
[    0.317318] pci 0000:00:1f.2: reg 0x20: [io  0xf400-0xf41f]
[    0.317326] pci 0000:00:1f.2: reg 0x24: [mem 0xfbffd000-0xfbffd7ff]
[    0.317368] pci 0000:00:1f.2: PME# supported from D3hot
[    0.317431] pci 0000:00:1f.3: [8086:3b30] type 00 class 0x0c0500
[    0.317446] pci 0000:00:1f.3: reg 0x10: [mem 0xfbffc000-0xfbffc0ff 64bit]
[    0.317465] pci 0000:00:1f.3: reg 0x20: [io  0x0500-0x051f]
[    0.317574] pci 0000:01:00.0: [1000:0072] type 00 class 0x010700
[    0.317585] pci 0000:01:00.0: reg 0x10: [io  0xce00-0xceff]
[    0.317595] pci 0000:01:00.0: reg 0x14: [mem 0xfbdfc000-0xfbdfffff 64bit]
[    0.317604] pci 0000:01:00.0: reg 0x1c: [mem 0xfbd80000-0xfbdbffff 64bit]
[    0.317616] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[    0.317657] pci 0000:01:00.0: supports D1 D2
[    0.317679] pci 0000:01:00.0: reg 0x174: [mem 0x00000000-0x00003fff 64bit]
[    0.317688] pci 0000:01:00.0: reg 0x17c: [mem 0x00000000-0x0003ffff 64bit]
[    0.323604] pci 0000:00:03.0: PCI bridge to [bus 01]
[    0.323608] pci 0000:00:03.0:   bridge window [io  0xc000-0xcfff]
[    0.323612] pci 0000:00:03.0:   bridge window [mem 0xfbd00000-0xfbdfffff]
[    0.323690] pci 0000:02:00.0: [197b:2363] type 00 class 0x010601
[    0.323777] pci 0000:02:00.0: reg 0x24: [mem 0xfbcfe000-0xfbcfffff]
[    0.323845] pci 0000:02:00.0: PME# supported from D3hot
[    0.323905] pci 0000:02:00.1: [197b:2363] type 00 class 0x010185
[    0.323929] pci 0000:02:00.1: reg 0x10: [io  0xef00-0xef07]
[    0.323943] pci 0000:02:00.1: reg 0x14: [io  0xee00-0xee03]
[    0.323956] pci 0000:02:00.1: reg 0x18: [io  0xed00-0xed07]
[    0.323969] pci 0000:02:00.1: reg 0x1c: [io  0xec00-0xec03]
[    0.323983] pci 0000:02:00.1: reg 0x20: [io  0xeb00-0xeb0f]
[    0.324089] pci 0000:02:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.324100] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.324104] pci 0000:00:1c.0:   bridge window [io  0xe000-0xefff]
[    0.324107] pci 0000:00:1c.0:   bridge window [mem 0xfbc00000-0xfbcfffff]
[    0.324173] pci 0000:03:00.0: [10ec:8168] type 00 class 0x020000
[    0.324192] pci 0000:03:00.0: reg 0x10: [io  0xde00-0xdeff]
[    0.324219] pci 0000:03:00.0: reg 0x18: [mem 0xfbeff000-0xfbefffff 64bit pref]
[    0.324237] pci 0000:03:00.0: reg 0x20: [mem 0xfbef8000-0xfbefbfff 64bit pref]
[    0.324249] pci 0000:03:00.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    0.324327] pci 0000:03:00.0: supports D1 D2
[    0.324330] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.331608] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.331613] pci 0000:00:1c.1:   bridge window [io  0xd000-0xdfff]
[    0.331617] pci 0000:00:1c.1:   bridge window [mem 0xfbb00000-0xfbbfffff]
[    0.331623] pci 0000:00:1c.1:   bridge window [mem 0xfbe00000-0xfbefffff 64bit pref]
[    0.331662] pci 0000:04:04.0: [102b:051b] type 00 class 0x030000
[    0.331675] pci 0000:04:04.0: reg 0x10: [mem 0xf9000000-0xf9ffffff pref]
[    0.331685] pci 0000:04:04.0: reg 0x14: [mem 0xfb7fc000-0xfb7fffff]
[    0.331694] pci 0000:04:04.0: reg 0x18: [mem 0xfa800000-0xfaffffff]
[    0.331724] pci 0000:04:04.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    0.331789] pci 0000:00:1e.0: PCI bridge to [bus 04] (subtractive decode)
[    0.331795] pci 0000:00:1e.0:   bridge window [mem 0xfa800000-0xfb7fffff]
[    0.331801] pci 0000:00:1e.0:   bridge window [mem 0xf9000000-0xf9ffffff 64bit pref]
[    0.331804] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7] (subtractive decode)
[    0.331807] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff] (subtractive decode)
[    0.331809] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
[    0.331812] pci 0000:00:1e.0:   bridge window [mem 0x000c0000-0x000dffff] (subtractive decode)
[    0.331815] pci 0000:00:1e.0:   bridge window [mem 0xef800000-0xfebfffff] (subtractive decode)
[    0.332267] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
[    0.332311] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[    0.332353] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
[    0.332395] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 *12 14 15)
[    0.332436] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    0.332479] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 *6 7 9 10 11 12 14 15)
[    0.332521] ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
[    0.332562] ACPI: PCI Interrupt Link [LNK1] (IRQs *3 4 5 6 7 9 10 11 12 14 15)
[    0.332693] vgaarb: setting as boot device: PCI:0000:04:04.0
[    0.332696] vgaarb: device added: PCI:0000:04:04.0,decodes=io+mem,owns=io+mem,locks=none
[    0.332699] vgaarb: loaded
[    0.332700] vgaarb: bridge control possible 0000:04:04.0
[    0.332852] SCSI subsystem initialized
[    0.332887] libata version 3.00 loaded.
[    0.332909] ACPI: bus type USB registered
[    0.332925] usbcore: registered new interface driver usbfs
[    0.332933] usbcore: registered new interface driver hub
[    0.332952] usbcore: registered new device driver usb
[    0.333047] PCI: Using ACPI for IRQ routing
[    0.334335] PCI: Discovered peer bus 3f
[    0.334336] PCI: root bus 3f: using default resources
[    0.334338] PCI: Probing PCI hardware (bus 3f)
[    0.334361] PCI host bridge to bus 0000:3f
[    0.334364] pci_bus 0000:3f: root bus resource [io  0x0000-0xffff]
[    0.334367] pci_bus 0000:3f: root bus resource [mem 0x00000000-0xfffffffff]
[    0.334369] pci_bus 0000:3f: No busn resource found for root bus, will use [bus 3f-ff]
[    0.334373] pci_bus 0000:3f: busn_res: can not insert [bus 3f-ff] under domain [bus 00-ff] (conflicts with (null) [bus 00-3f])
[    0.334379] pci 0000:3f:00.0: [8086:2c51] type 00 class 0x060000
[    0.334415] pci 0000:3f:00.1: [8086:2c81] type 00 class 0x060000
[    0.334452] pci 0000:3f:02.0: [8086:2c90] type 00 class 0x060000
[    0.334486] pci 0000:3f:02.1: [8086:2c91] type 00 class 0x060000
[    0.334522] pci 0000:3f:03.0: [8086:2c98] type 00 class 0x060000
[    0.334556] pci 0000:3f:03.1: [8086:2c99] type 00 class 0x060000
[    0.334591] pci 0000:3f:03.4: [8086:2c9c] type 00 class 0x060000
[    0.334626] pci 0000:3f:04.0: [8086:2ca0] type 00 class 0x060000
[    0.334661] pci 0000:3f:04.1: [8086:2ca1] type 00 class 0x060000
[    0.334696] pci 0000:3f:04.2: [8086:2ca2] type 00 class 0x060000
[    0.334730] pci 0000:3f:04.3: [8086:2ca3] type 00 class 0x060000
[    0.334765] pci 0000:3f:05.0: [8086:2ca8] type 00 class 0x060000
[    0.334800] pci 0000:3f:05.1: [8086:2ca9] type 00 class 0x060000
[    0.334835] pci 0000:3f:05.2: [8086:2caa] type 00 class 0x060000
[    0.334869] pci 0000:3f:05.3: [8086:2cab] type 00 class 0x060000
[    0.334913] pci_bus 0000:3f: busn_res: [bus 3f-ff] end is updated to 3f
[    0.334916] pci_bus 0000:3f: busn_res: can not insert [bus 3f] under domain [bus 00-ff] (conflicts with (null) [bus 00-3f])
[    0.334920] PCI: pci_cache_line_size set to 64 bytes
[    0.334987] e820: reserve RAM buffer [mem 0x0009c800-0x0009ffff]
[    0.334990] e820: reserve RAM buffer [mem 0xef7e0000-0xefffffff]
[    0.335079] NetLabel: Initializing
[    0.335081] NetLabel:  domain hash size = 128
[    0.335082] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.335094] NetLabel:  unlabeled traffic allowed by default
[    0.335155] HPET: 8 timers in total, 5 timers will be used for per-cpu timer
[    0.335162] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 24, 25, 26, 27, 28, 0
[    0.335168] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.337206] hpet: hpet2 irq 24 for MSI
[    0.337241] hpet: hpet3 irq 25 for MSI
[    0.337280] hpet: hpet4 irq 26 for MSI
[    0.337316] hpet: hpet5 irq 27 for MSI
[    0.337352] hpet: hpet6 irq 28 for MSI
[    0.337440] Switched to clocksource hpet
[    0.341625] AppArmor: AppArmor Filesystem Enabled
[    0.341673] pnp: PnP ACPI init
[    0.341800] system 00:00: [io  0x04d0-0x04d1] has been reserved
[    0.341804] system 00:00: [io  0x0290-0x029f] has been reserved
[    0.341806] system 00:00: [io  0x0800-0x087f] has been reserved
[    0.341809] system 00:00: [io  0x0290-0x0294] has been reserved
[    0.341811] system 00:00: [io  0x0880-0x088f] has been reserved
[    0.341815] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.341867] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.342073] pnp 00:02: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.342235] pnp 00:03: Plug and Play ACPI device, IDs PNP0400 (active)
[    0.342317] pnp 00:04: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.342367] system 00:05: [io  0x0400-0x047f] could not be reserved
[    0.342370] system 00:05: [io  0x0580-0x05ff] has been reserved
[    0.342373] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.342517] system 00:06: [mem 0xf4000000-0xf7ffffff] has been reserved
[    0.342520] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.342626] pnp 00:07: disabling [mem 0x000f0000-0x000f3fff] because it overlaps 0000:01:00.0 BAR 9 [mem 0x00000000-0x003fffff 64bit]
[    0.342630] pnp 00:07: disabling [mem 0x000f4000-0x000f7fff] because it overlaps 0000:01:00.0 BAR 9 [mem 0x00000000-0x003fffff 64bit]
[    0.342634] pnp 00:07: disabling [mem 0x000f8000-0x000fbfff] because it overlaps 0000:01:00.0 BAR 9 [mem 0x00000000-0x003fffff 64bit]
[    0.342638] pnp 00:07: disabling [mem 0x000fc000-0x000fffff] because it overlaps 0000:01:00.0 BAR 9 [mem 0x00000000-0x003fffff 64bit]
[    0.342641] pnp 00:07: disabling [mem 0x00000000-0x0009ffff] because it overlaps 0000:01:00.0 BAR 9 [mem 0x00000000-0x003fffff 64bit]
[    0.342645] pnp 00:07: disabling [mem 0x00100000-0xef7dffff] because it overlaps 0000:01:00.0 BAR 9 [mem 0x00000000-0x003fffff 64bit]
[    0.342649] pnp 00:07: disabling [mem 0x000e0000-0x000effff] because it overlaps 0000:01:00.0 BAR 9 [mem 0x00000000-0x003fffff 64bit]
[    0.342673] system 00:07: [mem 0xef7e0000-0xef7effff] could not be reserved
[    0.342677] system 00:07: [mem 0xef7f0000-0xef7fffff] has been reserved
[    0.342679] system 00:07: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.342682] system 00:07: [mem 0xfed10000-0xfed1dfff] has been reserved
[    0.342684] system 00:07: [mem 0xfed20000-0xfed8ffff] has been reserved
[    0.342687] system 00:07: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.342690] system 00:07: [mem 0xffb00000-0xffb7ffff] has been reserved
[    0.342692] system 00:07: [mem 0xfff00000-0xffffffff] has been reserved
[    0.342695] system 00:07: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.342703] pnp: PnP ACPI: found 8 devices
[    0.349173] pci_bus 0000:00: max bus depth: 1 pci_try_num: 2
[    0.349203] pci 0000:00:1c.0: BAR 15: assigned [mem 0xef800000-0xef9fffff 64bit pref]
[    0.349214] pci 0000:01:00.0: reg 0x174: [mem 0x00000000-0x00003fff 64bit]
[    0.349222] pci 0000:01:00.0: reg 0x17c: [mem 0x00000000-0x0003ffff 64bit]
[    0.349231] pci 0000:01:00.0: reg 0x174: [mem 0x00000000-0x00003fff 64bit]
[    0.349234] pci 0000:01:00.0: BAR 6: assigned [mem 0xfbd00000-0xfbd7ffff pref]
[    0.349243] pci 0000:01:00.0: reg 0x17c: [mem 0x00000000-0x0003ffff 64bit]
[    0.349246] pci 0000:01:00.0: BAR 9: no space for [mem size 0x00400000 64bit]
[    0.349249] pci 0000:01:00.0: BAR 9: failed to assign [mem size 0x00400000 64bit]
[    0.349258] pci 0000:01:00.0: reg 0x174: [mem 0x00000000-0x00003fff 64bit]
[    0.349260] pci 0000:01:00.0: BAR 7: no space for [mem size 0x00040000 64bit]
[    0.349263] pci 0000:01:00.0: BAR 7: failed to assign [mem size 0x00040000 64bit]
[    0.349266] pci 0000:00:03.0: PCI bridge to [bus 01]
[    0.349269] pci 0000:00:03.0:   bridge window [io  0xc000-0xcfff]
[    0.349273] pci 0000:00:03.0:   bridge window [mem 0xfbd00000-0xfbdfffff]
[    0.349279] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.349282] pci 0000:00:1c.0:   bridge window [io  0xe000-0xefff]
[    0.349287] pci 0000:00:1c.0:   bridge window [mem 0xfbc00000-0xfbcfffff]
[    0.349291] pci 0000:00:1c.0:   bridge window [mem 0xef800000-0xef9fffff 64bit pref]
[    0.349297] pci 0000:03:00.0: BAR 6: assigned [mem 0xfbb00000-0xfbb1ffff pref]
[    0.349300] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.349303] pci 0000:00:1c.1:   bridge window [io  0xd000-0xdfff]
[    0.349308] pci 0000:00:1c.1:   bridge window [mem 0xfbb00000-0xfbbfffff]
[    0.349311] pci 0000:00:1c.1:   bridge window [mem 0xfbe00000-0xfbefffff 64bit pref]
[    0.349318] pci 0000:04:04.0: BAR 6: assigned [mem 0xfb000000-0xfb00ffff pref]
[    0.349321] pci 0000:00:1e.0: PCI bridge to [bus 04]
[    0.349325] pci 0000:00:1e.0:   bridge window [mem 0xfa800000-0xfb7fffff]
[    0.349329] pci 0000:00:1e.0:   bridge window [mem 0xf9000000-0xf9ffffff 64bit pref]
[    0.349335] pci_bus 0000:00: No. 2 try to assign unassigned res
[    0.349337] release child resource [mem 0xfbd00000-0xfbd7ffff pref]
[    0.349339] release child resource [mem 0xfbd80000-0xfbdbffff 64bit]
[    0.349341] release child resource [mem 0xfbdfc000-0xfbdfffff 64bit]
[    0.349344] pci 0000:00:03.0: resource 14 [mem 0xfbd00000-0xfbdfffff] released
[    0.349346] pci 0000:00:03.0: PCI bridge to [bus 01]
[    2.369599] pci 0000:00:03.0: bridge window [mem 0x00100000-0x001fffff] to [bus 01] add_size 500000
[    2.369620] pci 0000:00:03.0: res[14]=[mem 0x00100000-0x001fffff] get_res_add_size add_size 500000
[    2.369624] pci 0000:00:03.0: BAR 14: assigned [mem 0xefa00000-0xefffffff]
[    2.385444] pci 0000:01:00.0: reg 0x174: [mem 0x00000000-0x00003fff 64bit]
[    2.385452] pci 0000:01:00.0: reg 0x17c: [mem 0x00000000-0x0003ffff 64bit]
[    2.385455] pci 0000:01:00.0: res[9]=[mem size 0x00000000 64bit] get_res_add_size add_size 400000
[    2.385458] pci 0000:01:00.0: res[7]=[mem size 0x00000000 64bit] get_res_add_size add_size 40000
[    2.385461] pci 0000:01:00.0: BAR 6: assigned [mem 0xefa00000-0xefa7ffff pref]
[    2.385465] pci 0000:01:00.0: BAR 3: assigned [mem 0xefa80000-0xefabffff 64bit]
[    2.385477] pci 0000:01:00.0: reg 0x17c: [mem 0x00000000-0x0003ffff 64bit]
[    2.385480] pci 0000:01:00.0: BAR 9: assigned [mem 0xefac0000-0xefebffff 64bit]
[    2.385487] pci 0000:01:00.0: BAR 1: assigned [mem 0xefec0000-0xefec3fff 64bit]
[    2.385499] pci 0000:01:00.0: reg 0x174: [mem 0x00000000-0x00003fff 64bit]
[    2.385502] pci 0000:01:00.0: BAR 7: assigned [mem 0xefec4000-0xeff03fff 64bit]
[    2.385509] pci 0000:00:03.0: PCI bridge to [bus 01]
[    2.385511] pci 0000:00:03.0:   bridge window [io  0xc000-0xcfff]
[    2.385515] pci 0000:00:03.0:   bridge window [mem 0xefa00000-0xefffffff]
[    2.385521] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    2.385524] pci 0000:00:1c.0:   bridge window [io  0xe000-0xefff]
[    2.385529] pci 0000:00:1c.0:   bridge window [mem 0xfbc00000-0xfbcfffff]
[    2.385533] pci 0000:00:1c.0:   bridge window [mem 0xef800000-0xef9fffff 64bit pref]
[    2.385538] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    2.385541] pci 0000:00:1c.1:   bridge window [io  0xd000-0xdfff]
[    2.385546] pci 0000:00:1c.1:   bridge window [mem 0xfbb00000-0xfbbfffff]
[    2.385550] pci 0000:00:1c.1:   bridge window [mem 0xfbe00000-0xfbefffff 64bit pref]
[    2.385556] pci 0000:00:1e.0: PCI bridge to [bus 04]
[    2.385560] pci 0000:00:1e.0:   bridge window [mem 0xfa800000-0xfb7fffff]
[    2.385564] pci 0000:00:1e.0:   bridge window [mem 0xf9000000-0xf9ffffff 64bit pref]
[    2.385570] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    2.385572] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    2.385575] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    2.385577] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000dffff]
[    2.385579] pci_bus 0000:00: resource 8 [mem 0xef800000-0xfebfffff]
[    2.385582] pci_bus 0000:01: resource 0 [io  0xc000-0xcfff]
[    2.385589] pci_bus 0000:01: resource 1 [mem 0xefa00000-0xefffffff]
[    2.385592] pci_bus 0000:02: resource 0 [io  0xe000-0xefff]
[    2.385594] pci_bus 0000:02: resource 1 [mem 0xfbc00000-0xfbcfffff]
[    2.385597] pci_bus 0000:02: resource 2 [mem 0xef800000-0xef9fffff 64bit pref]
[    2.385599] pci_bus 0000:03: resource 0 [io  0xd000-0xdfff]
[    2.385602] pci_bus 0000:03: resource 1 [mem 0xfbb00000-0xfbbfffff]
[    2.385604] pci_bus 0000:03: resource 2 [mem 0xfbe00000-0xfbefffff 64bit pref]
[    2.385607] pci_bus 0000:04: resource 1 [mem 0xfa800000-0xfb7fffff]
[    2.385609] pci_bus 0000:04: resource 2 [mem 0xf9000000-0xf9ffffff 64bit pref]
[    2.385612] pci_bus 0000:04: resource 4 [io  0x0000-0x0cf7]
[    2.385614] pci_bus 0000:04: resource 5 [io  0x0d00-0xffff]
[    2.385617] pci_bus 0000:04: resource 6 [mem 0x000a0000-0x000bffff]
[    2.385619] pci_bus 0000:04: resource 7 [mem 0x000c0000-0x000dffff]
[    2.385621] pci_bus 0000:04: resource 8 [mem 0xef800000-0xfebfffff]
[    2.385625] pci_bus 0000:3f: resource 4 [io  0x0000-0xffff]
[    2.385627] pci_bus 0000:3f: resource 5 [mem 0x00000000-0xfffffffff]
[    2.385649] NET: Registered protocol family 2
[    2.385822] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[    2.386149] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    2.386405] TCP: Hash tables configured (established 131072 bind 65536)
[    2.386426] TCP: reno registered
[    2.386442] UDP hash table entries: 8192 (order: 6, 262144 bytes)
[    2.386549] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes)
[    2.386679] NET: Registered protocol family 1
[    2.417679] pci 0000:04:04.0: Video device with shadowed ROM
[    2.417697] PCI: CLS 64 bytes, default 64
[    2.417737] Trying to unpack rootfs image as initramfs...
[    2.641458] Freeing initrd memory: 15060K (ffff880036286000 - ffff88003713b000)
[    2.641471] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    2.641474] software IO TLB [mem 0xeb7e0000-0xef7e0000] (64MB) mapped at [ffff8800eb7e0000-ffff8800ef7dffff]
[    2.641801] microcode: CPU0 sig=0x106e5, pf=0x2, revision=0x4
[    2.641808] microcode: CPU1 sig=0x106e5, pf=0x2, revision=0x4
[    2.641815] microcode: CPU2 sig=0x106e5, pf=0x2, revision=0x4
[    2.641821] microcode: CPU3 sig=0x106e5, pf=0x2, revision=0x4
[    2.641828] microcode: CPU4 sig=0x106e5, pf=0x2, revision=0x4
[    2.641836] microcode: CPU5 sig=0x106e5, pf=0x2, revision=0x4
[    2.641842] microcode: CPU6 sig=0x106e5, pf=0x2, revision=0x4
[    2.641848] microcode: CPU7 sig=0x106e5, pf=0x2, revision=0x4
[    2.641896] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    2.641922] Scanning for low memory corruption every 60 seconds
[    2.642244] futex hash table entries: 2048 (order: 5, 131072 bytes)
[    2.642285] audit: initializing netlink subsys (disabled)
[    2.642298] audit: type=2000 audit(1422899095.532:1): initialized
[    2.642507] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    2.643801] VFS: Disk quotas dquot_6.5.2
[    2.643833] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    2.644105] fuse init (API version 7.23)
[    2.644693] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    2.644698] io scheduler noop registered
[    2.644700] io scheduler deadline registered (default)
[    2.644726] io scheduler cfq registered
[    2.645111] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    2.645126] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    2.645153] vesafb: mode is 1024x768x32, linelength=4096, pages=0
[    2.645155] vesafb: scrolling: redraw
[    2.645157] vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    2.645169] vesafb: framebuffer at 0xf9000000, mapped to 0xffffc90005b80000, using 3072k, total 3072k
[    2.763775] Console: switching to colour frame buffer device 128x48
[    2.883722] fb0: VESA VGA frame buffer device
[    2.884722] intel_idle: MWAIT substates: 0x1120
[    2.885744] intel_idle: v0.4 model 0x1E
[    2.886593] intel_idle: lapic_timer_reliable_states 0x2
[    2.887975] ipmi message handler version 39.2
[    2.888994] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    2.890851] ACPI: Power Button [PWRB]
[    2.891694] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    2.893331] ACPI: Power Button [PWRF]
[    2.895073] GHES: HEST is not enabled!
[    2.895939] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    2.917731] 00:02: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    2.920675] Linux agpgart interface v0.103
[    2.922656] brd: module loaded
[    2.923847] loop: module loaded
[    2.924856] libphy: Fixed MDIO Bus: probed
[    2.925836] tun: Universal TUN/TAP device driver, 1.6
[    2.926952] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    2.928350] PPP generic driver version 2.4.2
[    2.929325] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.930777] ehci-pci: EHCI PCI platform driver
[    2.931856] ehci-pci 0000:00:1a.7: EHCI Host Controller
[    2.933015] ehci-pci 0000:00:1a.7: new USB bus registered, assigned bus number 1
[    2.981903] ehci-pci 0000:00:1a.7: debug port 2
[    3.034775] ehci-pci 0000:00:1a.7: cache line size of 64 is not supported
[    3.083901] ehci-pci 0000:00:1a.7: irq 18, io mem 0xfbfff000
[    3.141646] ehci-pci 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    3.189306] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    3.237324] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.285285] usb usb1: Product: EHCI Host Controller
[    3.332936] usb usb1: Manufacturer: Linux 3.19.0-rc6-patch01 ehci_hcd
[    3.380817] usb usb1: SerialNumber: 0000:00:1a.7
[    3.428233] hub 1-0:1.0: USB hub found
[    3.475121] hub 1-0:1.0: 6 ports detected
[    3.521487] ehci-pci 0000:00:1d.7: EHCI Host Controller
[    3.567643] ehci-pci 0000:00:1d.7: new USB bus registered, assigned bus number 2
[    3.613842] ehci-pci 0000:00:1d.7: debug port 2
[    3.637705] tsc: Refined TSC clocksource calibration: 2798.007 MHz
[    3.710021] ehci-pci 0000:00:1d.7: cache line size of 64 is not supported
[    3.757358] ehci-pci 0000:00:1d.7: irq 23, io mem 0xfbffe000
[    3.813698] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    3.860154] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    3.906991] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.953981] usb usb2: Product: EHCI Host Controller
[    4.000817] usb usb2: Manufacturer: Linux 3.19.0-rc6-patch01 ehci_hcd
[    4.047893] usb usb2: SerialNumber: 0000:00:1d.7
[    4.094248] hub 2-0:1.0: USB hub found
[    4.139691] hub 2-0:1.0: 8 ports detected
[    4.184640] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    4.230449] ohci-pci: OHCI PCI platform driver
[    4.276271] uhci_hcd: USB Universal Host Controller Interface driver
[    4.322896] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    4.369265] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
[    4.415420] uhci_hcd 0000:00:1a.0: detected 2 ports
[    4.460328] uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000ff00
[    4.504621] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[    4.549002] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.593825] usb usb3: Product: UHCI Host Controller
[    4.638246] usb usb3: Manufacturer: Linux 3.19.0-rc6-patch01 uhci_hcd
[    4.682770] usb usb3: SerialNumber: 0000:00:1a.0
[    4.726688] Switched to clocksource tsc
[    4.726792] hub 3-0:1.0: USB hub found
[    4.726850] hub 3-0:1.0: 2 ports detected
[    4.727322] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    4.727326] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
[    4.727334] uhci_hcd 0000:00:1a.1: detected 2 ports
[    4.727372] uhci_hcd 0000:00:1a.1: irq 21, io base 0x0000fe00
[    4.727841] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    4.727842] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.727843] usb usb4: Product: UHCI Host Controller
[    4.727844] usb usb4: Manufacturer: Linux 3.19.0-rc6-patch01 uhci_hcd
[    4.727845] usb usb4: SerialNumber: 0000:00:1a.1
[    4.728157] hub 4-0:1.0: USB hub found
[    4.728231] hub 4-0:1.0: 2 ports detected
[    4.728554] uhci_hcd 0000:00:1a.2: UHCI Host Controller
[    4.728557] uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus number 5
[    4.728566] uhci_hcd 0000:00:1a.2: detected 2 ports
[    4.728596] uhci_hcd 0000:00:1a.2: irq 18, io base 0x0000fd00
[    4.729028] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[    4.729030] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.729031] usb usb5: Product: UHCI Host Controller
[    4.729031] usb usb5: Manufacturer: Linux 3.19.0-rc6-patch01 uhci_hcd
[    4.729032] usb usb5: SerialNumber: 0000:00:1a.2
[    4.729181] hub 5-0:1.0: USB hub found
[    4.729204] hub 5-0:1.0: 2 ports detected
[    4.729443] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    4.729447] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 6
[    4.729455] uhci_hcd 0000:00:1d.0: detected 2 ports
[    4.729483] uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000fc00
[    4.729813] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
[    4.729815] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.729816] usb usb6: Product: UHCI Host Controller
[    4.729817] usb usb6: Manufacturer: Linux 3.19.0-rc6-patch01 uhci_hcd
[    4.729817] usb usb6: SerialNumber: 0000:00:1d.0
[    4.730159] hub 6-0:1.0: USB hub found
[    4.730272] hub 6-0:1.0: 2 ports detected
[    4.730680] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    4.730683] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 7
[    4.730692] uhci_hcd 0000:00:1d.1: detected 2 ports
[    4.730730] uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000fb00
[    4.731138] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
[    4.731139] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.731140] usb usb7: Product: UHCI Host Controller
[    4.731144] usb usb7: Manufacturer: Linux 3.19.0-rc6-patch01 uhci_hcd
[    4.731144] usb usb7: SerialNumber: 0000:00:1d.1
[    4.731347] hub 7-0:1.0: USB hub found
[    4.731353] hub 7-0:1.0: 2 ports detected
[    4.731494] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    4.731498] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 8
[    4.731506] uhci_hcd 0000:00:1d.2: detected 2 ports
[    4.731533] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000fa00
[    4.731571] usb usb8: New USB device found, idVendor=1d6b, idProduct=0001
[    4.731572] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.731573] usb usb8: Product: UHCI Host Controller
[    4.731573] usb usb8: Manufacturer: Linux 3.19.0-rc6-patch01 uhci_hcd
[    4.731574] usb usb8: SerialNumber: 0000:00:1d.2
[    4.731777] hub 8-0:1.0: USB hub found
[    4.731783] hub 8-0:1.0: 2 ports detected
[    4.731922] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[    4.731927] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 9
[    4.731935] uhci_hcd 0000:00:1d.3: detected 2 ports
[    4.731963] uhci_hcd 0000:00:1d.3: irq 16, io base 0x0000f900
[    4.732002] usb usb9: New USB device found, idVendor=1d6b, idProduct=0001
[    4.732003] usb usb9: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.732003] usb usb9: Product: UHCI Host Controller
[    4.732004] usb usb9: Manufacturer: Linux 3.19.0-rc6-patch01 uhci_hcd
[    4.732005] usb usb9: SerialNumber: 0000:00:1d.3
[    4.732206] hub 9-0:1.0: USB hub found
[    4.732212] hub 9-0:1.0: 2 ports detected
[    4.732303] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    4.732303] i8042: PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
[    4.732465] serio: i8042 KBD port at 0x60,0x64 irq 1
[    4.732771] mousedev: PS/2 mouse device common for all mice
[    4.733180] rtc_cmos 00:01: RTC can wake from S4
[    4.733456] rtc_cmos 00:01: rtc core: registered rtc_cmos as rtc0
[    4.733505] rtc_cmos 00:01: alarms up to one month, 242 bytes nvram, hpet irqs
[    4.733551] device-mapper: uevent: version 1.0.3
[    4.733693] device-mapper: ioctl: 4.29.0-ioctl (2014-10-28) initialised: dm-devel@redhat.com
[    4.733768] TCP: cubic registered
[    4.733856] NET: Registered protocol family 10
[    4.734243] NET: Registered protocol family 17
[    4.734251] Key type dns_resolver registered
[    4.734859] registered taskstats version 1
[    4.736490] Key type trusted registered
[    4.739688] Key type encrypted registered
[    4.739691] AppArmor: AppArmor sha1 policy hashing enabled
[    4.739693] ima: No TPM chip found, activating TPM-bypass!
[    4.739709] evm: HMAC attrs: 0x1
[    4.740288]   Magic number: 3:611:743
[    4.770503] rtc_cmos 00:01: setting system clock to 2015-02-02 17:44:58 UTC (1422899098)
[    4.770547] hpet1: lost 1 rtc interrupts
[    4.858505] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    4.858505] EDD information not available.
[    4.858534] PM: Hibernation image not present or could not be loaded.
[    5.037836] usb 5-2: new low-speed USB device number 2 using uhci_hcd
[    5.119729] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input2
[    5.237731] usb 5-2: New USB device found, idVendor=04b4, idProduct=0101
[    5.237732] usb 5-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    5.237733] usb 5-2: Product: Cypress PS/2 Keyboard - PS/2 Mouse
[    5.237735] usb 5-2: Manufacturer: Cypress
[    8.912416] Freeing unused kernel memory: 1212K (ffffffff81d09000 - ffffffff81e38000)
[    8.959007] Write protecting the kernel read-only data: 12288k
[    9.006107] Freeing unused kernel memory: 1376K (ffff8800016a8000 - ffff880001800000)
[    9.054079] Freeing unused kernel memory: 824K (ffff880001b32000 - ffff880001c00000)
[    9.161478] systemd-udevd[133]: starting version 204
[    9.214036] mpt2sas version 18.100.00.00 loaded
[    9.263165] ahci 0000:00:1f.2: version 3.0
[    9.263230] mpt2sas 0000:01:00.0: enabling device (0000 -> 0002)
[    9.263457] mpt2sas0: 64 BIT PCI BUS DMA ADDRESSING SUPPORTED, total mem (16426844 kB)
[    9.263465] mpt2sas0: sending diag reset !!
[    9.263649] scsi host1: pata_jmicron
[    9.263778] scsi host2: pata_jmicron
[    9.263822] ata1: PATA max UDMA/100 cmd 0xef00 ctl 0xee00 bmdma 0xeb00 irq 17
[    9.263823] ata2: PATA max UDMA/100 cmd 0xed00 ctl 0xec00 bmdma 0xeb08 irq 17
[    9.422136] mpt2sas0: diag reset: FAILED
[    9.422137] mpt2sas0: _base_get_ioc_facts: failed getting to correct state
[    9.422215] mpt2sas0: failure at drivers/scsi/mpt2sas/mpt2sas_scsih.c:8192/_scsih_probe()!
[    9.507461] hidraw: raw HID events driver (C) Jiri Kosina
[    9.749326] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    9.749332] r8169 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM control
[    9.749697] r8169 0000:03:00.0 eth0: RTL8168d/8111d at 0xffffc900018f6000, 00:24:1d:d9:29:dd, XID 083000c0 IRQ 29
[    9.749698] r8169 0000:03:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[    9.970168] usbcore: registered new interface driver usbhid
[    9.970168] usbhid: USB HID core driver
[   10.143694] ahci 0000:00:1f.2: SSS flag set, parallel bus scan disabled
[   10.193546] input: Cypress Cypress PS/2 Keyboard - PS/2 Mouse as /devices/pci0000:00/0000:00:1a.2/usb5/5-2/5-2:1.0/0003:04B4:0101.0001/input/input3
[   10.206291] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 3 Gbps 0x3f impl SATA mode
[   10.206293] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pmp pio slum part ems apst 
[   10.247015] scsi host3: ahci
[   10.247421] scsi host4: ahci
[   10.247824] scsi host5: ahci
[   10.248198] scsi host6: ahci
[   10.248496] scsi host7: ahci
[   10.248789] scsi host8: ahci
[   10.248840] ata3: SATA max UDMA/133 abar m2048@0xfbffd000 port 0xfbffd100 irq 30
[   10.248841] ata4: SATA max UDMA/133 abar m2048@0xfbffd000 port 0xfbffd180 irq 30
[   10.248842] ata5: SATA max UDMA/133 abar m2048@0xfbffd000 port 0xfbffd200 irq 30
[   10.248844] ata6: SATA max UDMA/133 abar m2048@0xfbffd000 port 0xfbffd280 irq 30
[   10.248846] ata7: SATA max UDMA/133 abar m2048@0xfbffd000 port 0xfbffd300 irq 30
[   10.248848] ata8: SATA max UDMA/133 abar m2048@0xfbffd000 port 0xfbffd380 irq 30
[   10.249005] ahci 0000:02:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
[   10.249007] ahci 0000:02:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
[   10.249376] scsi host9: ahci
[   10.249553] scsi host10: ahci
[   10.249599] ata9: SATA max UDMA/133 abar m8192@0xfbcfe000 port 0xfbcfe100 irq 16
[   10.249603] ata10: SATA max UDMA/133 abar m8192@0xfbcfe000 port 0xfbcfe180 irq 16
[   10.566318] ata10: SATA link down (SStatus 0 SControl 300)
[   10.566376] ata9: SATA link down (SStatus 0 SControl 300)
[   10.738272] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   10.739755] ata3.00: ATA-8: WDC WD2000FYYZ-01UL1B2, 01.01K03, max UDMA/133
[   10.739759] ata3.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
[   10.740700] ata3.00: configured for UDMA/133
[   10.741032] scsi 3:0:0:0: Direct-Access     ATA      WDC WD2000FYYZ-0 1K03 PQ: 0 ANSI: 5
[   10.741426] sd 3:0:0:0: [sda] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
[   10.741455] sd 3:0:0:0: [sda] Write Protect is off
[   10.741456] sd 3:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   10.741466] sd 3:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   10.741529] sd 3:0:0:0: Attached scsi generic sg0 type 0
[   10.761291]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
[   10.762292] sd 3:0:0:0: [sda] Attached SCSI disk
[   11.230220] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   11.244072] ata4.00: ATA-8: Hitachi HDT721010SLA360, ST6OA31B, max UDMA/133
[   11.244076] ata4.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
[   11.245151] ata4.00: configured for UDMA/133
[   11.245342] scsi 4:0:0:0: Direct-Access     ATA      Hitachi HDT72101 A31B PQ: 0 ANSI: 5
[   11.245625] sd 4:0:0:0: [sdb] 1953525168 512-byte logical blocks: (1.00 TB/931 GiB)
[   11.245658] sd 4:0:0:0: Attached scsi generic sg1 type 0
[   11.245715] sd 4:0:0:0: [sdb] Write Protect is off
[   11.245717] sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   11.245757] sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   11.272549]  sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 >
[   11.273528] sd 4:0:0:0: [sdb] Attached SCSI disk
[   11.562350] ata5: SATA link down (SStatus 0 SControl 300)
[   12.058336] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   12.064853] ata6.00: ATA-8: WDC WD1200AAJS-00VTA0, 01.01B01, max UDMA/133
[   12.064857] ata6.00: 234441648 sectors, multi 0: LBA48 
[   12.072305] ata6.00: configured for UDMA/133
[   12.072428] scsi 6:0:0:0: Direct-Access     ATA      WDC WD1200AAJS-0 1B01 PQ: 0 ANSI: 5
[   12.072608] sd 6:0:0:0: [sdc] 234441648 512-byte logical blocks: (120 GB/111 GiB)
[   12.072671] sd 6:0:0:0: Attached scsi generic sg2 type 0
[   12.072774] sd 6:0:0:0: [sdc] Write Protect is off
[   12.072776] sd 6:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[   12.072889] sd 6:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   12.098511]  sdc: sdc1 sdc2 sdc3 sdc4
[   12.099361] sd 6:0:0:0: [sdc] Attached SCSI disk
[   12.316228] floppy0: no floppy controllers found
[   12.390447] ata7: SATA link down (SStatus 0 SControl 300)
[   12.710444] ata8: SATA link down (SStatus 0 SControl 300)
[   12.842769] random: nonblocking pool is initialized
[   13.326515] hid-generic 0003:04B4:0101.0001: input,hidraw0: USB HID v1.00 Keyboard [Cypress Cypress PS/2 Keyboard - PS/2 Mouse] on usb-0000:00:1a.2-2/input0
[   13.428831] input: Cypress Cypress PS/2 Keyboard - PS/2 Mouse as /devices/pci0000:00/0000:00:1a.2/usb5/5-2/5-2:1.1/0003:04B4:0101.0002/input/input4
[   13.536667] hid-generic 0003:04B4:0101.0002: input,hidraw1: USB HID v1.00 Mouse [Cypress Cypress PS/2 Keyboard - PS/2 Mouse] on usb-0000:00:1a.2-2/input1
[   18.656829] EXT4-fs (sdc4): mounting ext2 file system using the ext4 subsystem
[   18.738496] EXT4-fs (sdc4): mounted filesystem without journal. Opts: (null)
[   31.989616] Adding 9798652k swap on /dev/sdc2.  Priority:-1 extents:1 across:9798652k FS
[   32.220487] systemd-udevd[340]: starting version 204
[   33.338345] ACPI Warning: SystemIO range 0x0000000000000428-0x000000000000042f conflicts with OpRegion 0x000000000000042c-0x000000000000042d (\GP2C)
[   33.347951] audit: type=1400 audit(1422899127.104:2): apparmor="STATUS" operation="profile_load" name="/sbin/dhclient" pid=418 comm="apparmor_parser"
[   33.348035] audit: type=1400 audit(1422899127.104:3): apparmor="STATUS" operation="profile_load" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=418 comm="apparmor_parser"
[   33.348113] audit: type=1400 audit(1422899127.104:4): apparmor="STATUS" operation="profile_load" name="/usr/lib/connman/scripts/dhclient-script" pid=418 comm="apparmor_parser"
[   33.348756] audit: type=1400 audit(1422899127.104:5): apparmor="STATUS" operation="profile_replace" name="/sbin/dhclient" pid=419 comm="apparmor_parser"
[   33.348836] audit: type=1400 audit(1422899127.104:6): apparmor="STATUS" operation="profile_replace" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=419 comm="apparmor_parser"
[   33.348906] audit: type=1400 audit(1422899127.104:7): apparmor="STATUS" operation="profile_replace" name="/usr/lib/connman/scripts/dhclient-script" pid=419 comm="apparmor_parser"
[   34.213725]  (20141107/utaddress-258)
[   34.360745] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[   34.437028] lpc_ich: Resource conflict(s) found affecting gpio_ich
[   34.602093] lp: driver loaded but no devices found
[   34.678256] gpio_ich: GPIO from 436 to 511 on gpio_ich
[   34.754306] EDAC MC: Ver: 3.0.0
[   34.890701] ppdev: user-space parallel port driver
[   35.008734] parport_pc 00:03: reported by Plug and Play ACPI
[   35.084575] parport0: PC-style at 0x378
[   35.084750] EDAC MC0: Giving out device to module i7core_edac.c controller i7 core #0: DEV 0000:3f:03.0 (POLLED)
[   35.084797] EDAC PCI0: Giving out device to module i7core_edac controller EDAC PCI controller: DEV 0000:3f:03.0 (POLLED)
[   35.084800] EDAC i7core: Driver loaded, 1 memory controller(s) found.
[   35.398582] , irq 7 [PCSPP,TRISTATE]
[   35.641775] kvm: VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL does not work properly. Using workaround
[   35.652023] lp0: using parport0 (interrupt-driven).
[   36.400035] floppy0: no floppy controllers found
[   36.667726] sound hdaudioC0D2: autoconfig: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
[   36.748634] sound hdaudioC0D2:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   36.829735] sound hdaudioC0D2:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[   36.910577] sound hdaudioC0D2:    mono: mono_out=0x0
[   36.990968] sound hdaudioC0D2:    dig-out=0x1e/0x0
[   37.071647] sound hdaudioC0D2:    inputs:
[   37.151552] sound hdaudioC0D2:      Rear Mic=0x18
[   37.229922] sound hdaudioC0D2:      Front Mic=0x19
[   37.306592] sound hdaudioC0D2:      Line=0x1a
[   37.381109] sound hdaudioC0D2:      CD=0x1c
[   37.453601] sound hdaudioC0D2:    dig-in=0x1f
[   37.534434] input: HDA Intel MID Rear Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input5
[   37.605560] input: HDA Intel MID Front Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input6
[   37.676501] input: HDA Intel MID Line as /devices/pci0000:00/0000:00:1b.0/sound/card0/input7
[   37.747479] input: HDA Intel MID Line Out as /devices/pci0000:00/0000:00:1b.0/sound/card0/input8
[   38.764116] EXT4-fs (sdc4): re-mounted. Opts: errors=remount-ro
[   38.993360] init: failsafe main process (682) killed by TERM signal
[   39.569630] audit: type=1400 audit(1422899133.324:8): apparmor="STATUS" operation="profile_load" name="/usr/sbin/cups-browsed" pid=817 comm="apparmor_parser"
[   39.611845] audit: type=1400 audit(1422899133.364:9): apparmor="STATUS" operation="profile_load" name="/usr/sbin/tcpdump" pid=820 comm="apparmor_parser"
[   39.735729] audit: type=1400 audit(1422899133.488:10): apparmor="STATUS" operation="profile_replace" name="/sbin/dhclient" pid=814 comm="apparmor_parser"
[   39.735924] audit: type=1400 audit(1422899133.488:11): apparmor="STATUS" operation="profile_replace" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=814 comm="apparmor_parser"
[   39.736071] audit: type=1400 audit(1422899133.488:12): apparmor="STATUS" operation="profile_replace" name="/usr/lib/connman/scripts/dhclient-script" pid=814 comm="apparmor_parser"
[   39.751819] audit: type=1400 audit(1422899133.504:13): apparmor="STATUS" operation="profile_load" name="/usr/lib/lightdm/lightdm-guest-session" pid=813 comm="apparmor_parser"
[   39.752013] audit: type=1400 audit(1422899133.504:14): apparmor="STATUS" operation="profile_load" name="chromium" pid=813 comm="apparmor_parser"
[   39.878147] audit: type=1400 audit(1422899133.632:15): apparmor="STATUS" operation="profile_load" name="/usr/lib/cups/backend/cups-pdf" pid=831 comm="apparmor_parser"
[   39.878450] audit: type=1400 audit(1422899133.632:16): apparmor="STATUS" operation="profile_load" name="/usr/sbin/cupsd" pid=831 comm="apparmor_parser"
[   39.889346] init: cups main process (845) killed by HUP signal
[   39.889355] init: cups main process ended, respawning
[   39.911479] audit: type=1400 audit(1422899133.664:17): apparmor="STATUS" operation="profile_replace" name="/usr/lib/cups/backend/cups-pdf" pid=818 comm="apparmor_parser"
[   40.576739] Bluetooth: Core ver 2.20
[   40.576749] NET: Registered protocol family 31
[   40.576750] Bluetooth: HCI device and connection manager initialized
[   40.576753] Bluetooth: HCI socket layer initialized
[   40.576754] Bluetooth: L2CAP socket layer initialized
[   40.576758] Bluetooth: SCO socket layer initialized
[   41.042257] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   41.042258] Bluetooth: BNEP filters: protocol multicast
[   41.042262] Bluetooth: BNEP socket layer initialized
[   41.378940] Bluetooth: RFCOMM TTY layer initialized
[   41.447414] Bluetooth: RFCOMM socket layer initialized
[   41.447418] Bluetooth: RFCOMM ver 1.11
[   41.749802] r8169 0000:03:00.0 eth0: link down
[   41.749830] r8169 0000:03:00.0 eth0: link down
[   41.749835] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   44.134706] r8169 0000:03:00.0 eth0: link up
[   44.134711] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   46.908858] init: alsa-restore main process (974) terminated with status 99
[   46.969326] audit_printk_skb: 21 callbacks suppressed
[   46.969327] audit: type=1400 audit(1422899140.724:25): apparmor="STATUS" operation="profile_replace" name="/usr/sbin/cups-browsed" pid=1016 comm="apparmor_parser"
[   51.752526] init: plymouth-upstart-bridge main process ended, respawning
[   69.948863] audit: type=1400 audit(1422899163.700:26): apparmor="STATUS" operation="profile_replace" name="/usr/lib/cups/backend/cups-pdf" pid=2218 comm="apparmor_parser"
[   69.948869] audit: type=1400 audit(1422899163.700:27): apparmor="STATUS" operation="profile_replace" name="/usr/sbin/cupsd" pid=2218 comm="apparmor_parser"
[   69.949157] audit: type=1400 audit(1422899163.700:28): apparmor="STATUS" operation="profile_replace" name="/usr/sbin/cupsd" pid=2218 comm="apparmor_parser"

--------------070501030909050107030307--
