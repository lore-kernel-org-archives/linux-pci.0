Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout0.freenet.de ([195.4.92.90]:60859 "EHLO mout0.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933126AbbGUQpY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 21 Jul 2015 12:45:24 -0400
Subject: Re: Since Linux 4.1: A lot of AMD-Vi IO_PAGE_FAULTs
To: Joerg Roedel <joro@8bytes.org>
References: <55AE5F84.5020204@01019freenet.de>
 <1437492886.1391.847.camel@redhat.com> <20150721155635.GE10969@8bytes.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	iommu <iommu@lists.linux-foundation.org>
From: Andreas Hartmann <andihartmann@freenet.de>
Message-ID: <55AE7147.7070902@maya.org>
Date: Tue, 21 Jul 2015 18:20:23 +0200
MIME-Version: 1.0
In-Reply-To: <20150721155635.GE10969@8bytes.org>
Content-Type: multipart/mixed;
 boundary="------------080900020804030403040101"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------080900020804030403040101
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit

Hi Jörg,

I attached the dmesg output of the boot seuqence. This time after
reboot, the amount of IO_PAGE_FAULTs is not that much, but now, I got a
few ata3.00 errors.


Am 21.07.2015 um 17:56 schrieb Joerg Roedel:
> Hi Andreas,
> 
> On Tue, Jul 21, 2015 at 09:34:46AM -0600, Alex Williamson wrote:
>>> Since Linux 4.1, I'm getting a lot of IO_PAGE_FAULT like this one

To be more precise: The last kernel w/o this problem is 3.18.x - I never
used 3.19 or 4.0.

[...]

> These addresses are not returned from the address allocator of the AMD
> IOMMU driver. Hard to tell what went wrong here, can you probably get a
> complete boot-log (dmesg output after boot) and send it to me?
> 
> Please also boot with amd_iommu_dump on the kernel command line.


Thanks,
Andreas

--------------080900020804030403040101
Content-Type: text/plain; charset=UTF-8;
 name="dmesg.boot"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="dmesg.boot"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.1.2-1.1-desktop (geeko@buildhost) (gcc ver=
sion 4.8.1 20130909 [gcc-4_8-branch revision 202388] (SUSE Linux) ) #1 SM=
P PREEMPT Tue Jun 30 11:16:29 CEST 2015 (a46abf6)
[    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-4.1.2-1.1-desktop root=
=3D/dev/mapper/ssd1-newUsr resume=3D/dev/raid0/swap splash=3Dsilent quiet=
 showopts amd_iommu_dump
[    0.000000] tseg: 00cff00000
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000097fff] usa=
ble
[    0.000000] BIOS-e820: [mem 0x000000000009f800-0x000000000009ffff] res=
erved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] res=
erved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000cfd9ffff] usa=
ble
[    0.000000] BIOS-e820: [mem 0x00000000cfda0000-0x00000000cfdd0fff] ACP=
I NVS
[    0.000000] BIOS-e820: [mem 0x00000000cfdd1000-0x00000000cfdfffff] ACP=
I data
[    0.000000] BIOS-e820: [mem 0x00000000cfe00000-0x00000000cfefffff] res=
erved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] res=
erved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000ffffffff] res=
erved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000062effffff] usa=
ble
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.4 present.
[    0.000000] DMI: Gigabyte Technology Co., Ltd. GA-990XA-UD3/GA-990XA-U=
D3, BIOS F14b 01/24/2013
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> re=
served
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] AGP: No AGP bridge found
[    0.000000] e820: last_pfn =3D 0x62f000 max_arch_pfn =3D 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-C7FFF write-protect
[    0.000000]   C8000-FFFFF uncachable
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000000 mask FFFF80000000 write-back
[    0.000000]   1 base 000080000000 mask FFFFC0000000 write-back
[    0.000000]   2 base 0000C0000000 mask FFFFF0000000 write-back
[    0.000000]   3 base 0000CFE00000 mask FFFFFFE00000 uncachable
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] TOM2: 000000062f000000 aka 25328M
[    0.000000] PAT configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- UC =20
[    0.000000] e820: update [mem 0xcfe00000-0xffffffff] usable =3D=3D> re=
served
[    0.000000] e820: last_pfn =3D 0xcfda0 max_arch_pfn =3D 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000f4be0-0x000f4bef] mapped a=
t [ffff8800000f4be0]
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [ffff880000092000] 92000 size 24=
576
[    0.000000] Using GB pages for direct mapping
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] BRK [0x02225000, 0x02225fff] PGTABLE
[    0.000000] BRK [0x02226000, 0x02226fff] PGTABLE
[    0.000000] BRK [0x02227000, 0x02227fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x62ee00000-0x62effffff]
[    0.000000]  [mem 0x62ee00000-0x62effffff] page 2M
[    0.000000] BRK [0x02228000, 0x02228fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x620000000-0x62edfffff]
[    0.000000]  [mem 0x620000000-0x62edfffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x600000000-0x61fffffff]
[    0.000000]  [mem 0x600000000-0x61fffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x00100000-0xcfd9ffff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0x3fffffff] page 2M
[    0.000000]  [mem 0x40000000-0xbfffffff] page 1G
[    0.000000]  [mem 0xc0000000-0xcfbfffff] page 2M
[    0.000000]  [mem 0xcfc00000-0xcfd9ffff] page 4k
[    0.000000] init_memory_mapping: [mem 0x100000000-0x5ffffffff]
[    0.000000]  [mem 0x100000000-0x5ffffffff] page 1G
[    0.000000] RAMDISK: [mem 0x36a6c000-0x3752dfff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F6B00 000014 (v00 GBT   )
[    0.000000] ACPI: RSDT 0x00000000CFDD1000 000050 (v01 GBT    GBTUACPI =
42302E31 GBTU 01010101)
[    0.000000] ACPI: FACP 0x00000000CFDD1080 000074 (v01 GBT    GBTUACPI =
42302E31 GBTU 01010101)
[    0.000000] ACPI: DSDT 0x00000000CFDD1100 007A4B (v01 GBT    GBTUACPI =
00001000 MSFT 03000000)
[    0.000000] ACPI: FACS 0x00000000CFDA0000 000040
[    0.000000] ACPI: MSDM 0x00000000CFDD8C40 000055 (v03 GBT    GBTUACPI =
42302E31 GBTU 01010101)
[    0.000000] ACPI: HPET 0x00000000CFDD8CC0 000038 (v01 GBT    GBTUACPI =
42302E31 GBTU 00000098)
[    0.000000] ACPI: MCFG 0x00000000CFDD8D00 00003C (v01 GBT    GBTUACPI =
42302E31 GBTU 01010101)
[    0.000000] ACPI: EUDS 0x00000000CFDD8D80 000740 (v01 GBT             =
00000000      00000000)
[    0.000000] ACPI: MATS 0x00000000CFDD94C0 000034 (v01 GBT             =
00000000      00000000)
[    0.000000] ACPI: TAMG 0x00000000CFDD9530 000182 (v01 GBT    GBT   B0 =
5455312E BG?? 53450101)
[    0.000000] ACPI: APIC 0x00000000CFDD8B80 0000BC (v01 GBT    GBTUACPI =
42302E31 GBTU 01010101)
[    0.000000] ACPI: MATS 0x00000000CFDD96C0 006209 (v01        MATS RCM =
80000001 INTL 20061109)
[    0.000000] ACPI: SSDT 0x00000000CFDDF940 001714 (v01 AMD    POWERNOW =
00000001 AMD  00000001)
[    0.000000] ACPI: IVRS 0x00000000CFDE10D0 0000E0 (v01 AMD    RD890S   =
00202031 AMD  00000000)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000062efffff=
f]
[    0.000000] NODE_DATA(0) allocated [mem 0x62efea000-0x62effdfff]
[    0.000000]  [ffffea0000000000-ffffea0018bfffff] PMD -> [ffff880616600=
000-ffff88062e5fffff] on node 0
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000062effffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x0000000000097fff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000cfd9ffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000062effffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000062ef=
fffff]
[    0.000000] On node 0 totalpages: 6286647
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3991 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 13239 pages used for memmap
[    0.000000]   DMA32 zone: 847264 pages, LIFO batch:31
[    0.000000]   Normal zone: 84928 pages used for memmap
[    0.000000]   Normal zone: 5435392 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x05] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x06] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x07] dfl dfl lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 8, version 33, address 0xfec00000, GSI =
0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)=

[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x10b9a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x00098000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.000000] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xcfda0000-0xcfdd0fff]
[    0.000000] PM: Registered nosave memory: [mem 0xcfdd1000-0xcfdfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xcfe00000-0xcfefffff]
[    0.000000] PM: Registered nosave memory: [mem 0xcff00000-0xdfffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xe0000000-0xefffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf0000000-0xfebfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xffffffff]
[    0.000000] e820: [mem 0xcff00000-0xdfffffff] available for PCI device=
s
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource refined-jiffies: mask: 0xffffffff max_cycles: =
0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:8=
 nr_node_ids:1
[    0.000000] PERCPU: Embedded 33 pages/cpu @ffff88062ec00000 s97432 r81=
92 d29544 u262144
[    0.000000] pcpu-alloc: s97432 r8192 d29544 u262144 alloc=3D1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7=20
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  To=
tal pages: 6188395
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=3D/vmlinuz-4.1.2-1.1-deskt=
op root=3D/dev/mapper/ssd1-newUsr resume=3D/dev/raid0/swap splash=3Dsilen=
t quiet showopts amd_iommu_dump
[    0.000000] log_buf_len individual max cpu contribution: 32768 bytes
[    0.000000] log_buf_len total cpu_extra contributions: 229376 bytes
[    0.000000] log_buf_len min size: 262144 bytes
[    0.000000] log_buf_len: 524288 bytes
[    0.000000] early log buf free: 251924(96%)
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] xsave: enabled xstate_bv 0x7, cntxt size 0x340 using stand=
ard form
[    0.000000] AGP: Checking aperture...
[    0.000000] AGP: No AGP bridge found
[    0.000000] AGP: Node 0: aperture [bus addr 0xc4000000-0xc5ffffff] (32=
MB)
[    0.000000] Aperture pointing to e820 RAM. Ignoring.
[    0.000000] AGP: Your BIOS doesn't leave a aperture memory hole
[    0.000000] AGP: Please enable the IOMMU option in the BIOS setup
[    0.000000] AGP: This costs you 64MB of RAM
[    0.000000] AGP: Mapping aperture over RAM [mem 0xc4000000-0xc7ffffff]=
 (65536KB)
[    0.000000] PM: Registered nosave memory: [mem 0xc4000000-0xc7ffffff]
[    0.000000] Memory: 24590172K/25146588K available (6819K kernel code, =
1120K rwdata, 4996K rodata, 1564K init, 1520K bss, 556416K reserved, 0K c=
ma-reserved)
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=3D512 to nr_cpu_ids=3D8=
=2E
[    0.000000] 	RCU kthread priority: 1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_i=
ds=3D8
[    0.000000] NR_IRQS:33024 nr_irqs:488 16
[    0.000000] 	Offload RCU callbacks from all CPUs
[    0.000000] 	Offload RCU callbacks from CPUs: 0-7.
[    0.000000] spurious 8259A interrupt: IRQ7.
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] clocksource hpet: mask: 0xffffffff max_cycles: 0xffffffff,=
 max_idle_ns: 133484873504 ns
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 4026.993 MHz processor
[    0.000020] Calibrating delay loop (skipped), value calculated using t=
imer frequency.. 8053.98 BogoMIPS (lpj=3D4026993)
[    0.000022] pid_max: default: 32768 minimum: 301
[    0.000029] ACPI: Core revision 20150410
[    0.004786] ACPI: All ACPI Tables successfully acquired
[    0.062420] Security Framework initialized
[    0.062433] AppArmor: AppArmor initialized
[    0.064272] Dentry cache hash table entries: 4194304 (order: 13, 33554=
432 bytes)
[    0.815776] Inode-cache hash table entries: 2097152 (order: 12, 167772=
16 bytes)
[    0.819137] Mount-cache hash table entries: 65536 (order: 7, 524288 by=
tes)
[    0.819176] Mountpoint-cache hash table entries: 65536 (order: 7, 5242=
88 bytes)
[    0.819548] Initializing cgroup subsys blkio
[    0.819551] Initializing cgroup subsys memory
[    0.819558] Initializing cgroup subsys devices
[    0.819561] Initializing cgroup subsys freezer
[    0.819563] Initializing cgroup subsys net_cls
[    0.819566] Initializing cgroup subsys perf_event
[    0.819568] Initializing cgroup subsys net_prio
[    0.819570] Initializing cgroup subsys hugetlb
[    0.819588] CPU: Physical Processor ID: 0
[    0.819589] CPU: Processor Core ID: 0
[    0.819590] mce: CPU supports 7 MCE banks
[    0.819596] LVT offset 1 assigned for vector 0xf9
[    0.819601] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
[    0.819602] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB =
0
[    0.819686] Freeing SMP alternatives memory: 24K (ffffffff820a1000 - f=
fffffff820a7000)
[    0.820253] ftrace: allocating 25803 entries in 101 pages
[    0.826708] AMD-Vi: device: 00:00.2 cap: 0040 seg: 0 flags: 3e info 13=
00
[    0.826709] AMD-Vi:        mmio-addr: 00000000fec30000
[    0.826720] AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 00:00.0 flags: 00=

[    0.826721] AMD-Vi:   DEV_RANGE_END		 devid: 00:00.2
[    0.826722] AMD-Vi:   DEV_SELECT			 devid: 00:02.0 flags: 00
[    0.826723] AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 01:00.0 flags: 00=

[    0.826724] AMD-Vi:   DEV_RANGE_END		 devid: 01:00.1
[    0.826725] AMD-Vi:   DEV_SELECT			 devid: 00:04.0 flags: 00
[    0.826726] AMD-Vi:   DEV_SELECT			 devid: 02:00.0 flags: 00
[    0.826727] AMD-Vi:   DEV_SELECT			 devid: 00:05.0 flags: 00
[    0.826727] AMD-Vi:   DEV_SELECT			 devid: 03:00.0 flags: 00
[    0.826728] AMD-Vi:   DEV_SELECT			 devid: 00:09.0 flags: 00
[    0.826729] AMD-Vi:   DEV_SELECT			 devid: 04:00.0 flags: 00
[    0.826730] AMD-Vi:   DEV_SELECT			 devid: 00:0a.0 flags: 00
[    0.826731] AMD-Vi:   DEV_SELECT			 devid: 05:00.0 flags: 00
[    0.826732] AMD-Vi:   DEV_SELECT			 devid: 00:11.0 flags: 00
[    0.826732] AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 00:12.0 flags: 00=

[    0.826733] AMD-Vi:   DEV_RANGE_END		 devid: 00:12.2
[    0.826734] AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 00:13.0 flags: 00=

[    0.826735] AMD-Vi:   DEV_RANGE_END		 devid: 00:13.2
[    0.826736] AMD-Vi:   DEV_SELECT			 devid: 00:14.0 flags: d7
[    0.826737] AMD-Vi:   DEV_SELECT			 devid: 00:14.2 flags: 00
[    0.826737] AMD-Vi:   DEV_SELECT			 devid: 00:14.3 flags: 00
[    0.826738] AMD-Vi:   DEV_SELECT			 devid: 00:14.4 flags: 00
[    0.826739] AMD-Vi:   DEV_ALIAS_RANGE		 devid: 06:00.0 flags: 00 devid=
_to: 00:14.4
[    0.826740] AMD-Vi:   DEV_RANGE_END		 devid: 06:1f.7
[    0.826746] AMD-Vi:   DEV_SELECT			 devid: 00:14.5 flags: 00
[    0.826747] AMD-Vi:   DEV_SELECT			 devid: 00:15.0 flags: 00
[    0.826748] AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 07:00.0 flags: 00=

[    0.826749] AMD-Vi:   DEV_RANGE_END		 devid: 07:1f.7
[    0.826753] AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 00:16.0 flags: 00=

[    0.826753] AMD-Vi:   DEV_RANGE_END		 devid: 00:16.2
[    0.826755] AMD-Vi:   DEV_SPECIAL(IOAPIC[8])		devid: 00:14.0
[    0.826756] AMD-Vi:   DEV_SPECIAL(HPET[0])		devid: 00:14.0
[    0.826757] AMD-Vi:   DEV_SPECIAL(IOAPIC[8])		devid: 00:00.1
[    0.899479] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    1.010947] smpboot: CPU0: AMD FX(tm)-8350 Eight-Core Processor (fam: =
15, model: 02, stepping: 00)
[    1.010964] Performance Events: Fam15h core perfctr, AMD PMU driver.
[    1.010968] ... version:                0
[    1.010969] ... bit width:              48
[    1.010969] ... generic registers:      6
[    1.010970] ... value mask:             0000ffffffffffff
[    1.010971] ... max period:             00007fffffffffff
[    1.010972] ... fixed-purpose events:   0
[    1.010973] ... event mask:             000000000000003f
[    1.019002] NMI watchdog: enabled on all CPUs, permanently consumes on=
e hw-PMU counter.
[    1.021046] x86: Booting SMP configuration:
[    1.021048] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
[    1.124041] x86: Booted up 1 node, 8 CPUs
[    1.124044] smpboot: Total of 8 processors activated (64431.88 BogoMIP=
S)
[    1.133802] devtmpfs: initialized
[    1.138802] PM: Registering ACPI NVS region [mem 0xcfda0000-0xcfdd0fff=
] (200704 bytes)
[    1.138889] clocksource jiffies: mask: 0xffffffff max_cycles: 0xffffff=
ff, max_idle_ns: 1911260446275000 ns
[    1.138986] pinctrl core: initialized pinctrl subsystem
[    1.139013] RTC time: 16:08:13, date: 07/21/15
[    1.139117] NET: Registered protocol family 16
[    1.141823] cpuidle: using governor ladder
[    1.144810] cpuidle: using governor menu
[    1.144888] ACPI: bus type PCI registered
[    1.144889] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    1.144962] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe00000=
00-0xefffffff] (base 0xe0000000)
[    1.144964] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E=
820
[    1.145239] PCI: Using configuration type 1 for base access
[    1.145830] mtrr: your CPUs had inconsistent variable MTRR settings
[    1.145831] mtrr: probably your BIOS does not setup all CPUs.
[    1.145832] mtrr: corrected configuration.
[    1.150232] ACPI: Added _OSI(Module Device)
[    1.150234] ACPI: Added _OSI(Processor Device)
[    1.150235] ACPI: Added _OSI(3.0 _SCP Extensions)
[    1.150236] ACPI: Added _OSI(Processor Aggregator Device)
[    1.162963] ACPI: Interpreter enabled
[    1.162970] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State=
 [\_S1_] (20150410/hwxface-580)
[    1.162975] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State=
 [\_S2_] (20150410/hwxface-580)
[    1.162990] ACPI: (supports S0 S3 S4 S5)
[    1.162991] ACPI: Using IOAPIC for interrupt routing
[    1.163023] PCI: Using host bridge windows from ACPI; if necessary, us=
e "pci=3Dnocrs" and report a bug
[    1.168882] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    1.168888] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM Cl=
ockPM Segments MSI]
[    1.168893] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASP=
M
[    1.169268] PCI host bridge to bus 0000:00
[    1.169271] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.169273] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 wind=
ow]
[    1.169274] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff wind=
ow]
[    1.169276] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bf=
fff window]
[    1.169278] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000df=
fff window]
[    1.169279] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed44=
fff window]
[    1.169281] pci_bus 0000:00: root bus resource [mem 0xd0000000-0xfebff=
fff window]
[    1.169288] pci 0000:00:00.0: [1002:5a14] type 00 class 0x060000
[    1.169299] pci 0000:00:00.0: [Firmware Bug]: reg 0x1c: invalid BAR (c=
an't size)
[    1.169415] pci 0000:00:00.2: [1002:5a23] type 00 class 0x080600
[    1.169532] pci 0000:00:02.0: [1002:5a16] type 01 class 0x060400
[    1.169561] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    1.169632] pci 0000:00:02.0: System wakeup disabled by ACPI
[    1.169670] pci 0000:00:04.0: [1002:5a18] type 01 class 0x060400
[    1.169698] pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
[    1.169767] pci 0000:00:04.0: System wakeup disabled by ACPI
[    1.169804] pci 0000:00:05.0: [1002:5a19] type 01 class 0x060400
[    1.169831] pci 0000:00:05.0: PME# supported from D0 D3hot D3cold
[    1.169900] pci 0000:00:05.0: System wakeup disabled by ACPI
[    1.169937] pci 0000:00:09.0: [1002:5a1c] type 01 class 0x060400
[    1.169965] pci 0000:00:09.0: PME# supported from D0 D3hot D3cold
[    1.170037] pci 0000:00:09.0: System wakeup disabled by ACPI
[    1.170073] pci 0000:00:0a.0: [1002:5a1d] type 01 class 0x060400
[    1.170101] pci 0000:00:0a.0: PME# supported from D0 D3hot D3cold
[    1.170169] pci 0000:00:0a.0: System wakeup disabled by ACPI
[    1.170212] pci 0000:00:11.0: [1002:4391] type 00 class 0x010601
[    1.170225] pci 0000:00:11.0: reg 0x10: [io  0xff00-0xff07]
[    1.170232] pci 0000:00:11.0: reg 0x14: [io  0xfe00-0xfe03]
[    1.170238] pci 0000:00:11.0: reg 0x18: [io  0xfd00-0xfd07]
[    1.170245] pci 0000:00:11.0: reg 0x1c: [io  0xfc00-0xfc03]
[    1.170252] pci 0000:00:11.0: reg 0x20: [io  0xfb00-0xfb0f]
[    1.170259] pci 0000:00:11.0: reg 0x24: [mem 0xfdfff000-0xfdfff3ff]
[    1.170379] pci 0000:00:12.0: [1002:4397] type 00 class 0x0c0310
[    1.170389] pci 0000:00:12.0: reg 0x10: [mem 0xfdffe000-0xfdffefff]
[    1.170498] pci 0000:00:12.0: System wakeup disabled by ACPI
[    1.170537] pci 0000:00:12.2: [1002:4396] type 00 class 0x0c0320
[    1.170549] pci 0000:00:12.2: reg 0x10: [mem 0xfdffd000-0xfdffd0ff]
[    1.170604] pci 0000:00:12.2: supports D1 D2
[    1.170606] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
[    1.170673] pci 0000:00:12.2: System wakeup disabled by ACPI
[    1.170714] pci 0000:00:13.0: [1002:4397] type 00 class 0x0c0310
[    1.170724] pci 0000:00:13.0: reg 0x10: [mem 0xfdffc000-0xfdffcfff]
[    1.170831] pci 0000:00:13.0: System wakeup disabled by ACPI
[    1.170871] pci 0000:00:13.2: [1002:4396] type 00 class 0x0c0320
[    1.170883] pci 0000:00:13.2: reg 0x10: [mem 0xfdffb000-0xfdffb0ff]
[    1.170937] pci 0000:00:13.2: supports D1 D2
[    1.170939] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
[    1.171007] pci 0000:00:13.2: System wakeup disabled by ACPI
[    1.171046] pci 0000:00:14.0: [1002:4385] type 00 class 0x0c0500
[    1.171187] pci 0000:00:14.2: [1002:4383] type 00 class 0x040300
[    1.171201] pci 0000:00:14.2: reg 0x10: [mem 0xfdff4000-0xfdff7fff 64b=
it]
[    1.171248] pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
[    1.171317] pci 0000:00:14.2: System wakeup disabled by ACPI
[    1.171353] pci 0000:00:14.3: [1002:439d] type 00 class 0x060100
[    1.171494] pci 0000:00:14.4: [1002:4384] type 01 class 0x060401
[    1.171584] pci 0000:00:14.4: System wakeup disabled by ACPI
[    1.171619] pci 0000:00:14.5: [1002:4399] type 00 class 0x0c0310
[    1.171629] pci 0000:00:14.5: reg 0x10: [mem 0xfdffa000-0xfdffafff]
[    1.171737] pci 0000:00:14.5: System wakeup disabled by ACPI
[    1.171778] pci 0000:00:15.0: [1002:43a0] type 01 class 0x060400
[    1.171824] pci 0000:00:15.0: supports D1 D2
[    1.171894] pci 0000:00:15.0: System wakeup disabled by ACPI
[    1.171930] pci 0000:00:16.0: [1002:4397] type 00 class 0x0c0310
[    1.171940] pci 0000:00:16.0: reg 0x10: [mem 0xfdff9000-0xfdff9fff]
[    1.172048] pci 0000:00:16.0: System wakeup disabled by ACPI
[    1.172088] pci 0000:00:16.2: [1002:4396] type 00 class 0x0c0320
[    1.172101] pci 0000:00:16.2: reg 0x10: [mem 0xfdff8000-0xfdff80ff]
[    1.172156] pci 0000:00:16.2: supports D1 D2
[    1.172157] pci 0000:00:16.2: PME# supported from D0 D1 D2 D3hot
[    1.172225] pci 0000:00:16.2: System wakeup disabled by ACPI
[    1.172265] pci 0000:00:18.0: [1022:1600] type 00 class 0x060000
[    1.172363] pci 0000:00:18.1: [1022:1601] type 00 class 0x060000
[    1.172457] pci 0000:00:18.2: [1022:1602] type 00 class 0x060000
[    1.172550] pci 0000:00:18.3: [1022:1603] type 00 class 0x060000
[    1.172645] pci 0000:00:18.4: [1022:1604] type 00 class 0x060000
[    1.172740] pci 0000:00:18.5: [1022:1605] type 00 class 0x060000
[    1.172875] pci 0000:01:00.0: [1002:6759] type 00 class 0x030000
[    1.172890] pci 0000:01:00.0: reg 0x10: [mem 0xd0000000-0xdfffffff 64b=
it pref]
[    1.172900] pci 0000:01:00.0: reg 0x18: [mem 0xfdec0000-0xfdedffff 64b=
it]
[    1.172907] pci 0000:01:00.0: reg 0x20: [io  0xee00-0xeeff]
[    1.172919] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0001ffff pre=
f]
[    1.172952] pci 0000:01:00.0: supports D1 D2
[    1.173008] pci 0000:01:00.1: [1002:aa90] type 00 class 0x040300
[    1.173022] pci 0000:01:00.1: reg 0x10: [mem 0xfdefc000-0xfdefffff 64b=
it]
[    1.173082] pci 0000:01:00.1: supports D1 D2
[    1.175324] pci 0000:00:02.0: PCI bridge to [bus 01]
[    1.175328] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    1.175330] pci 0000:00:02.0:   bridge window [mem 0xfde00000-0xfdefff=
ff]
[    1.175333] pci 0000:00:02.0:   bridge window [mem 0xd0000000-0xdfffff=
ff 64bit pref]
[    1.175374] pci 0000:02:00.0: [1b6f:7023] type 00 class 0x0c0330
[    1.175390] pci 0000:02:00.0: reg 0x10: [mem 0xfddf8000-0xfddfffff 64b=
it]
[    1.175457] pci 0000:02:00.0: supports D1 D2
[    1.175458] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3col=
d
[    1.177321] pci 0000:00:04.0: PCI bridge to [bus 02]
[    1.177324] pci 0000:00:04.0:   bridge window [io  0xd000-0xdfff]
[    1.177326] pci 0000:00:04.0:   bridge window [mem 0xfdd00000-0xfddfff=
ff]
[    1.177329] pci 0000:00:04.0:   bridge window [mem 0xfdc00000-0xfdcfff=
ff 64bit pref]
[    1.177373] pci 0000:03:00.0: [168c:0030] type 00 class 0x028000
[    1.177390] pci 0000:03:00.0: reg 0x10: [mem 0xfdbc0000-0xfdbdffff 64b=
it]
[    1.177427] pci 0000:03:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pre=
f]
[    1.177470] pci 0000:03:00.0: supports D1
[    1.177472] pci 0000:03:00.0: PME# supported from D0 D1 D3hot
[    1.179316] pci 0000:00:05.0: PCI bridge to [bus 03]
[    1.179320] pci 0000:00:05.0:   bridge window [io  0xc000-0xcfff]
[    1.179322] pci 0000:00:05.0:   bridge window [mem 0xfdb00000-0xfdbfff=
ff]
[    1.179324] pci 0000:00:05.0:   bridge window [mem 0xfda00000-0xfdafff=
ff 64bit pref]
[    1.179368] pci 0000:04:00.0: [10ec:8168] type 00 class 0x020000
[    1.179381] pci 0000:04:00.0: reg 0x10: [io  0xbe00-0xbeff]
[    1.179401] pci 0000:04:00.0: reg 0x18: [mem 0xfd6ff000-0xfd6fffff 64b=
it pref]
[    1.179414] pci 0000:04:00.0: reg 0x20: [mem 0xfd6f8000-0xfd6fbfff 64b=
it pref]
[    1.179469] pci 0000:04:00.0: supports D1 D2
[    1.179470] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3col=
d
[    1.181316] pci 0000:00:09.0: PCI bridge to [bus 04]
[    1.181319] pci 0000:00:09.0:   bridge window [io  0xb000-0xbfff]
[    1.181321] pci 0000:00:09.0:   bridge window [mem 0xfd900000-0xfd9fff=
ff]
[    1.181324] pci 0000:00:09.0:   bridge window [mem 0xfd600000-0xfd6fff=
ff 64bit pref]
[    1.181366] pci 0000:05:00.0: [1b6f:7023] type 00 class 0x0c0330
[    1.181382] pci 0000:05:00.0: reg 0x10: [mem 0xfd3f8000-0xfd3fffff 64b=
it]
[    1.181450] pci 0000:05:00.0: supports D1 D2
[    1.181452] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3col=
d
[    1.183312] pci 0000:00:0a.0: PCI bridge to [bus 05]
[    1.183315] pci 0000:00:0a.0:   bridge window [io  0xa000-0xafff]
[    1.183317] pci 0000:00:0a.0:   bridge window [mem 0xfd300000-0xfd3fff=
ff]
[    1.183320] pci 0000:00:0a.0:   bridge window [mem 0xfd200000-0xfd2fff=
ff 64bit pref]
[    1.183361] pci 0000:06:06.0: [8086:1229] type 00 class 0x020000
[    1.183377] pci 0000:06:06.0: reg 0x10: [mem 0xfd8ff000-0xfd8fffff]
[    1.183387] pci 0000:06:06.0: reg 0x14: [io  0x9f00-0x9f3f]
[    1.183396] pci 0000:06:06.0: reg 0x18: [mem 0xfd8c0000-0xfd8dffff]
[    1.183430] pci 0000:06:06.0: reg 0x30: [mem 0x00000000-0x0000ffff pre=
f]
[    1.183459] pci 0000:06:06.0: supports D1 D2
[    1.183460] pci 0000:06:06.0: PME# supported from D0 D1 D2 D3hot D3col=
d
[    1.183517] pci 0000:06:0e.0: [1106:3044] type 00 class 0x0c0010
[    1.183534] pci 0000:06:0e.0: reg 0x10: [mem 0xfd8fe000-0xfd8fe7ff]
[    1.183544] pci 0000:06:0e.0: reg 0x14: [io  0x9e00-0x9e7f]
[    1.183616] pci 0000:06:0e.0: supports D2
[    1.183617] pci 0000:06:0e.0: PME# supported from D2 D3hot D3cold
[    1.183678] pci 0000:00:14.4: PCI bridge to [bus 06] (subtractive deco=
de)
[    1.183681] pci 0000:00:14.4:   bridge window [io  0x9000-0x9fff]
[    1.183684] pci 0000:00:14.4:   bridge window [mem 0xfd800000-0xfd8fff=
ff]
[    1.183687] pci 0000:00:14.4:   bridge window [mem 0xfd700000-0xfd7fff=
ff pref]
[    1.183688] pci 0000:00:14.4:   bridge window [io  0x0000-0x0cf7 windo=
w] (subtractive decode)
[    1.183690] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff windo=
w] (subtractive decode)
[    1.183691] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bff=
ff window] (subtractive decode)
[    1.183693] pci 0000:00:14.4:   bridge window [mem 0x000c0000-0x000dff=
ff window] (subtractive decode)
[    1.183694] pci 0000:00:14.4:   bridge window [mem 0xfed40000-0xfed44f=
ff window] (subtractive decode)
[    1.183696] pci 0000:00:14.4:   bridge window [mem 0xd0000000-0xfebfff=
ff window] (subtractive decode)
[    1.183736] pci 0000:00:15.0: PCI bridge to [bus 07]
[    1.183740] pci 0000:00:15.0:   bridge window [io  0x8000-0x8fff]
[    1.183742] pci 0000:00:15.0:   bridge window [mem 0xfd500000-0xfd5fff=
ff]
[    1.183746] pci 0000:00:15.0:   bridge window [mem 0xfd400000-0xfd4fff=
ff 64bit pref]
[    1.183776] pci_bus 0000:00: on NUMA node 0
[    1.184097] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 11) *0
[    1.184169] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11) *0
[    1.184239] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11) *0
[    1.184311] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11) *0
[    1.184380] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11) *0
[    1.184448] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11) *0
[    1.184516] ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 10 11) *0
[    1.184584] ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11) *0
[    1.185292] vgaarb: setting as boot device: PCI:0000:01:00.0
[    1.185294] vgaarb: device added: PCI:0000:01:00.0,decodes=3Dio+mem,ow=
ns=3Dio+mem,locks=3Dnone
[    1.185298] vgaarb: loaded
[    1.185299] vgaarb: bridge control possible 0000:01:00.0
[    1.185380] SCSI subsystem initialized
[    1.185434] libata version 3.00 loaded.
[    1.185439] ACPI: bus type USB registered
[    1.185457] usbcore: registered new interface driver usbfs
[    1.185467] usbcore: registered new interface driver hub
[    1.185492] usbcore: registered new device driver usb
[    1.185579] PCI: Using ACPI for IRQ routing
[    1.191594] PCI: pci_cache_line_size set to 64 bytes
[    1.191652] e820: reserve RAM buffer [mem 0x00098000-0x0009ffff]
[    1.191654] e820: reserve RAM buffer [mem 0xcfda0000-0xcfffffff]
[    1.191655] e820: reserve RAM buffer [mem 0x62f000000-0x62fffffff]
[    1.191763] NetLabel: Initializing
[    1.191764] NetLabel:  domain hash size =3D 128
[    1.191765] NetLabel:  protocols =3D UNLABELED CIPSOv4
[    1.191775] NetLabel:  unlabeled traffic allowed by default
[    1.191808] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    1.191810] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    1.193868] Switched to clocksource hpet
[    1.200824] AppArmor: AppArmor Filesystem Enabled
[    1.200867] pnp: PnP ACPI init
[    1.200961] system 00:00: [io  0x04d0-0x04d1] has been reserved
[    1.200964] system 00:00: [io  0x0220-0x0225] has been reserved
[    1.200965] system 00:00: [io  0x0290-0x0294] has been reserved
[    1.200968] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (acti=
ve)
[    1.201311] pnp 00:01: disabling [mem 0x00000000-0x00000fff window] be=
cause it overlaps 0000:01:00.0 BAR 6 [mem 0x00000000-0x0001ffff pref]
[    1.201315] pnp 00:01: disabling [mem 0x00000000-0x00000fff window dis=
abled] because it overlaps 0000:03:00.0 BAR 6 [mem 0x00000000-0x0000ffff =
pref]
[    1.201319] pnp 00:01: disabling [mem 0x00000000-0x00000fff window dis=
abled] because it overlaps 0000:06:06.0 BAR 6 [mem 0x00000000-0x0000ffff =
pref]
[    1.201344] system 00:01: [io  0x0900-0x091f] has been reserved
[    1.201346] system 00:01: [io  0x0228-0x022f] has been reserved
[    1.201347] system 00:01: [io  0x040b] has been reserved
[    1.201349] system 00:01: [io  0x04d6] has been reserved
[    1.201351] system 00:01: [io  0x0c00-0x0c01] has been reserved
[    1.201352] system 00:01: [io  0x0c14] has been reserved
[    1.201354] system 00:01: [io  0x0c50-0x0c52] has been reserved
[    1.201355] system 00:01: [io  0x0c6c-0x0c6d] has been reserved
[    1.201357] system 00:01: [io  0x0c6f] has been reserved
[    1.201358] system 00:01: [io  0x0cd0-0x0cd1] has been reserved
[    1.201360] system 00:01: [io  0x0cd2-0x0cd3] has been reserved
[    1.201361] system 00:01: [io  0x0cd4-0x0cdf] has been reserved
[    1.201363] system 00:01: [io  0x0800-0x08fe] could not be reserved
[    1.201364] system 00:01: [io  0x0a10-0x0a17] has been reserved
[    1.201366] system 00:01: [io  0x0b00-0x0b0f] has been reserved
[    1.201367] system 00:01: [io  0x0b10-0x0b1f] has been reserved
[    1.201369] system 00:01: [io  0x0b20-0x0b3f] has been reserved
[    1.201371] system 00:01: [mem 0xfee00400-0xfee00fff window] has been =
reserved
[    1.201373] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (acti=
ve)
[    1.201579] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)=

[    1.202009] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 (active)=

[    1.202124] system 00:04: [mem 0xe0000000-0xefffffff] has been reserve=
d
[    1.202126] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (acti=
ve)
[    1.202417] system 00:05: [mem 0x000d9000-0x000dbfff] has been reserve=
d
[    1.202419] system 00:05: [mem 0x000f0000-0x000f7fff] could not be res=
erved
[    1.202421] system 00:05: [mem 0x000f8000-0x000fbfff] could not be res=
erved
[    1.202422] system 00:05: [mem 0x000fc000-0x000fffff] could not be res=
erved
[    1.202424] system 00:05: [mem 0xcfda0000-0xcfdfffff] could not be res=
erved
[    1.202426] system 00:05: [mem 0xffff0000-0xffffffff] has been reserve=
d
[    1.202427] system 00:05: [mem 0x00000000-0x0009ffff] could not be res=
erved
[    1.202429] system 00:05: [mem 0x00100000-0xcfd9ffff] could not be res=
erved
[    1.202430] system 00:05: [mem 0xcfe00000-0xcfefffff] has been reserve=
d
[    1.202432] system 00:05: [mem 0xcff00000-0xcfffffff] could not be res=
erved
[    1.202433] system 00:05: [mem 0xfec00000-0xfec00fff] could not be res=
erved
[    1.202435] system 00:05: [mem 0xfee00000-0xfee00fff] could not be res=
erved
[    1.202437] system 00:05: [mem 0xfff80000-0xfffeffff] has been reserve=
d
[    1.202439] system 00:05: Plug and Play ACPI device, IDs PNP0c01 (acti=
ve)
[    1.202462] pnp: PnP ACPI: found 6 devices
[    1.209005] clocksource acpi_pm: mask: 0xffffff max_cycles: 0xffffff, =
max_idle_ns: 2085701024 ns
[    1.209033] pci 0000:01:00.0: BAR 6: assigned [mem 0xfde00000-0xfde1ff=
ff pref]
[    1.209035] pci 0000:00:02.0: PCI bridge to [bus 01]
[    1.209037] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    1.209039] pci 0000:00:02.0:   bridge window [mem 0xfde00000-0xfdefff=
ff]
[    1.209042] pci 0000:00:02.0:   bridge window [mem 0xd0000000-0xdfffff=
ff 64bit pref]
[    1.209044] pci 0000:00:04.0: PCI bridge to [bus 02]
[    1.209046] pci 0000:00:04.0:   bridge window [io  0xd000-0xdfff]
[    1.209048] pci 0000:00:04.0:   bridge window [mem 0xfdd00000-0xfddfff=
ff]
[    1.209050] pci 0000:00:04.0:   bridge window [mem 0xfdc00000-0xfdcfff=
ff 64bit pref]
[    1.209053] pci 0000:03:00.0: BAR 6: assigned [mem 0xfdb00000-0xfdb0ff=
ff pref]
[    1.209055] pci 0000:00:05.0: PCI bridge to [bus 03]
[    1.209056] pci 0000:00:05.0:   bridge window [io  0xc000-0xcfff]
[    1.209059] pci 0000:00:05.0:   bridge window [mem 0xfdb00000-0xfdbfff=
ff]
[    1.209061] pci 0000:00:05.0:   bridge window [mem 0xfda00000-0xfdafff=
ff 64bit pref]
[    1.209063] pci 0000:00:09.0: PCI bridge to [bus 04]
[    1.209065] pci 0000:00:09.0:   bridge window [io  0xb000-0xbfff]
[    1.209067] pci 0000:00:09.0:   bridge window [mem 0xfd900000-0xfd9fff=
ff]
[    1.209069] pci 0000:00:09.0:   bridge window [mem 0xfd600000-0xfd6fff=
ff 64bit pref]
[    1.209072] pci 0000:00:0a.0: PCI bridge to [bus 05]
[    1.209073] pci 0000:00:0a.0:   bridge window [io  0xa000-0xafff]
[    1.209075] pci 0000:00:0a.0:   bridge window [mem 0xfd300000-0xfd3fff=
ff]
[    1.209077] pci 0000:00:0a.0:   bridge window [mem 0xfd200000-0xfd2fff=
ff 64bit pref]
[    1.209081] pci 0000:06:06.0: BAR 6: assigned [mem 0xfd700000-0xfd70ff=
ff pref]
[    1.209082] pci 0000:00:14.4: PCI bridge to [bus 06]
[    1.209084] pci 0000:00:14.4:   bridge window [io  0x9000-0x9fff]
[    1.209088] pci 0000:00:14.4:   bridge window [mem 0xfd800000-0xfd8fff=
ff]
[    1.209090] pci 0000:00:14.4:   bridge window [mem 0xfd700000-0xfd7fff=
ff pref]
[    1.209095] pci 0000:00:15.0: PCI bridge to [bus 07]
[    1.209096] pci 0000:00:15.0:   bridge window [io  0x8000-0x8fff]
[    1.209099] pci 0000:00:15.0:   bridge window [mem 0xfd500000-0xfd5fff=
ff]
[    1.209102] pci 0000:00:15.0:   bridge window [mem 0xfd400000-0xfd4fff=
ff 64bit pref]
[    1.209106] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    1.209108] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    1.209109] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff win=
dow]
[    1.209111] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000dffff win=
dow]
[    1.209112] pci_bus 0000:00: resource 8 [mem 0xfed40000-0xfed44fff win=
dow]
[    1.209113] pci_bus 0000:00: resource 9 [mem 0xd0000000-0xfebfffff win=
dow]
[    1.209115] pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
[    1.209116] pci_bus 0000:01: resource 1 [mem 0xfde00000-0xfdefffff]
[    1.209117] pci_bus 0000:01: resource 2 [mem 0xd0000000-0xdfffffff 64b=
it pref]
[    1.209119] pci_bus 0000:02: resource 0 [io  0xd000-0xdfff]
[    1.209120] pci_bus 0000:02: resource 1 [mem 0xfdd00000-0xfddfffff]
[    1.209122] pci_bus 0000:02: resource 2 [mem 0xfdc00000-0xfdcfffff 64b=
it pref]
[    1.209123] pci_bus 0000:03: resource 0 [io  0xc000-0xcfff]
[    1.209124] pci_bus 0000:03: resource 1 [mem 0xfdb00000-0xfdbfffff]
[    1.209126] pci_bus 0000:03: resource 2 [mem 0xfda00000-0xfdafffff 64b=
it pref]
[    1.209127] pci_bus 0000:04: resource 0 [io  0xb000-0xbfff]
[    1.209128] pci_bus 0000:04: resource 1 [mem 0xfd900000-0xfd9fffff]
[    1.209130] pci_bus 0000:04: resource 2 [mem 0xfd600000-0xfd6fffff 64b=
it pref]
[    1.209131] pci_bus 0000:05: resource 0 [io  0xa000-0xafff]
[    1.209132] pci_bus 0000:05: resource 1 [mem 0xfd300000-0xfd3fffff]
[    1.209134] pci_bus 0000:05: resource 2 [mem 0xfd200000-0xfd2fffff 64b=
it pref]
[    1.209135] pci_bus 0000:06: resource 0 [io  0x9000-0x9fff]
[    1.209136] pci_bus 0000:06: resource 1 [mem 0xfd800000-0xfd8fffff]
[    1.209138] pci_bus 0000:06: resource 2 [mem 0xfd700000-0xfd7fffff pre=
f]
[    1.209139] pci_bus 0000:06: resource 4 [io  0x0000-0x0cf7 window]
[    1.209141] pci_bus 0000:06: resource 5 [io  0x0d00-0xffff window]
[    1.209142] pci_bus 0000:06: resource 6 [mem 0x000a0000-0x000bffff win=
dow]
[    1.209143] pci_bus 0000:06: resource 7 [mem 0x000c0000-0x000dffff win=
dow]
[    1.209145] pci_bus 0000:06: resource 8 [mem 0xfed40000-0xfed44fff win=
dow]
[    1.209146] pci_bus 0000:06: resource 9 [mem 0xd0000000-0xfebfffff win=
dow]
[    1.209147] pci_bus 0000:07: resource 0 [io  0x8000-0x8fff]
[    1.209149] pci_bus 0000:07: resource 1 [mem 0xfd500000-0xfd5fffff]
[    1.209150] pci_bus 0000:07: resource 2 [mem 0xfd400000-0xfd4fffff 64b=
it pref]
[    1.209223] NET: Registered protocol family 2
[    1.209508] TCP established hash table entries: 262144 (order: 9, 2097=
152 bytes)
[    1.209975] TCP bind hash table entries: 65536 (order: 8, 1048576 byte=
s)
[    1.210185] TCP: Hash tables configured (established 262144 bind 65536=
)
[    1.210250] UDP hash table entries: 16384 (order: 7, 524288 bytes)
[    1.210393] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes=
)
[    1.210569] NET: Registered protocol family 1
[    1.469060] pci 0000:01:00.0: Video device with shadowed ROM
[    1.469477] pci 0000:06:06.0: Firmware left e100 interrupts enabled; d=
isabling
[    1.469483] PCI: CLS 64 bytes, default 64
[    1.469539] Unpacking initramfs...
[    1.599287] Freeing initrd memory: 11016K (ffff880036a6c000 - ffff8800=
3752e000)
[    1.599669] pci 0000:00:00.2: can't derive routing for PCI INT A
[    1.599670] pci 0000:00:00.2: PCI INT A: no GSI
[    1.600048] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
[    1.600049] AMD-Vi: Interrupt remapping enabled
[    1.610639] AMD-Vi: Lazy IO/TLB flushing enabled
[    1.682895] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.682897] software IO TLB [mem 0xcbda0000-0xcfda0000] (64MB) mapped =
at [ffff8800cbda0000-ffff8800cfd9ffff]
[    1.682949] perf: AMD NB counters detected
[    1.683057] microcode: CPU0: patch_level=3D0x0600081c
[    1.683065] microcode: CPU1: patch_level=3D0x0600081c
[    1.683072] microcode: CPU2: patch_level=3D0x0600081c
[    1.683080] microcode: CPU3: patch_level=3D0x0600081c
[    1.683086] microcode: CPU4: patch_level=3D0x0600081c
[    1.683090] microcode: CPU5: patch_level=3D0x0600081c
[    1.683097] microcode: CPU6: patch_level=3D0x0600081c
[    1.683103] microcode: CPU7: patch_level=3D0x0600081c
[    1.683156] microcode: Microcode Update Driver: v2.00 <tigran@aivazian=
=2Efsnet.co.uk>, Peter Oruba
[    1.683160] LVT offset 0 assigned for vector 0x400
[    1.683177] perf: AMD IBS detected (0x000000ff)
[    1.683199] Scanning for low memory corruption every 60 seconds
[    1.683545] futex hash table entries: 2048 (order: 5, 131072 bytes)
[    1.683592] audit: initializing netlink subsys (disabled)
[    1.683608] audit: type=3D2000 audit(1437494892.691:1): initialized
[    1.683878] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    1.683908] zpool: loaded
[    1.683910] zbud: loaded
[    1.684011] VFS: Disk quotas dquot_6.6.0
[    1.684034] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 by=
tes)
[    1.684277] Key type big_key registered
[    1.684593] Key type asymmetric registered
[    1.684596] Asymmetric key parser 'x509' registered
[    1.684616] Block layer SCSI generic (bsg) driver version 0.4 loaded (=
major 252)
[    1.684662] io scheduler noop registered
[    1.684664] io scheduler deadline registered
[    1.684680] io scheduler cfq registered (default)
[    1.685441] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    1.685458] pciehp: PCI Express Hot Plug Controller Driver version: 0.=
4
[    1.685478] vesafb: mode is 1600x1200x32, linelength=3D6400, pages=3D0=

[    1.685479] vesafb: scrolling: redraw
[    1.685481] vesafb: Truecolor: size=3D0:8:8:8, shift=3D0:16:8:0
[    1.685500] vesafb: framebuffer at 0xd0000000, mapped to 0xffffc900038=
00000, using 7552k, total 7552k
[    1.724028] Console: switching to colour frame buffer device 200x75
[    1.762458] fb0: VESA VGA frame buffer device
[    1.762494] GHES: HEST is not enabled!
[    1.762540] Serial: 8250/16550 driver, 32 ports, IRQ sharing disabled
[    1.783013] 00:03: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200=
) is a 16550A
[    1.784537] Non-volatile memory driver v1.3
[    1.784567] Linux agpgart interface v0.103
[    1.785280] ahci 0000:00:11.0: version 3.0
[    1.785500] ahci 0000:00:11.0: AHCI 0001.0200 32 slots 6 ports 6 Gbps =
0x3f impl SATA mode
[    1.785502] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo p=
mp pio slum part=20
[    1.786287] scsi host0: ahci
[    1.786382] scsi host1: ahci
[    1.786474] scsi host2: ahci
[    1.786565] scsi host3: ahci
[    1.786655] scsi host4: ahci
[    1.786746] scsi host5: ahci
[    1.786788] ata1: SATA max UDMA/133 abar m1024@0xfdfff000 port 0xfdfff=
100 irq 19
[    1.786790] ata2: SATA max UDMA/133 abar m1024@0xfdfff000 port 0xfdfff=
180 irq 19
[    1.786791] ata3: SATA max UDMA/133 abar m1024@0xfdfff000 port 0xfdfff=
200 irq 19
[    1.786793] ata4: SATA max UDMA/133 abar m1024@0xfdfff000 port 0xfdfff=
280 irq 19
[    1.786795] ata5: SATA max UDMA/133 abar m1024@0xfdfff000 port 0xfdfff=
300 irq 19
[    1.786797] ata6: SATA max UDMA/133 abar m1024@0xfdfff000 port 0xfdfff=
380 irq 19
[    1.786832] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver=

[    1.786837] ehci-pci: EHCI PCI platform driver
[    1.786987] QUIRK: Enable AMD PLL fix
[    1.787003] ehci-pci 0000:00:12.2: EHCI Host Controller
[    1.787008] ehci-pci 0000:00:12.2: new USB bus registered, assigned bu=
s number 1
[    1.787012] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3=
 EHCI dummy qh workaround
[    1.787021] ehci-pci 0000:00:12.2: debug port 1
[    1.787056] ehci-pci 0000:00:12.2: irq 17, io mem 0xfdffd000
[    1.792233] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
[    1.792281] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    1.792283] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
[    1.792284] usb usb1: Product: EHCI Host Controller
[    1.792285] usb usb1: Manufacturer: Linux 4.1.2-1.1-desktop ehci_hcd
[    1.792287] usb usb1: SerialNumber: 0000:00:12.2
[    1.792406] hub 1-0:1.0: USB hub found
[    1.792412] hub 1-0:1.0: 5 ports detected
[    1.792694] ehci-pci 0000:00:13.2: EHCI Host Controller
[    1.792698] ehci-pci 0000:00:13.2: new USB bus registered, assigned bu=
s number 2
[    1.792701] ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3=
 EHCI dummy qh workaround
[    1.792708] ehci-pci 0000:00:13.2: debug port 1
[    1.792729] ehci-pci 0000:00:13.2: irq 17, io mem 0xfdffb000
[    1.798221] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
[    1.798252] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    1.798254] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
[    1.798255] usb usb2: Product: EHCI Host Controller
[    1.798256] usb usb2: Manufacturer: Linux 4.1.2-1.1-desktop ehci_hcd
[    1.798257] usb usb2: SerialNumber: 0000:00:13.2
[    1.798369] hub 2-0:1.0: USB hub found
[    1.798373] hub 2-0:1.0: 5 ports detected
[    1.798654] ehci-pci 0000:00:16.2: EHCI Host Controller
[    1.798658] ehci-pci 0000:00:16.2: new USB bus registered, assigned bu=
s number 3
[    1.798661] ehci-pci 0000:00:16.2: applying AMD SB700/SB800/Hudson-2/3=
 EHCI dummy qh workaround
[    1.798668] ehci-pci 0000:00:16.2: debug port 1
[    1.798689] ehci-pci 0000:00:16.2: irq 17, io mem 0xfdff8000
[    1.804214] ehci-pci 0000:00:16.2: USB 2.0 started, EHCI 1.00
[    1.804259] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    1.804261] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
[    1.804262] usb usb3: Product: EHCI Host Controller
[    1.804263] usb usb3: Manufacturer: Linux 4.1.2-1.1-desktop ehci_hcd
[    1.804264] usb usb3: SerialNumber: 0000:00:16.2
[    1.804374] hub 3-0:1.0: USB hub found
[    1.804378] hub 3-0:1.0: 4 ports detected
[    1.804491] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.804495] uhci_hcd: USB Universal Host Controller Interface driver
[    1.804537] i8042: PNP: No PS/2 controller found. Probing ports direct=
ly.
[    1.837134] i8042: Failed to disable AUX port, but continuing anyway..=
=2E Is this a SiS?
[    1.837139] i8042: If AUX port is really absent please use the 'i8042.=
noaux' option
[    2.086970] serio: i8042 KBD port at 0x60,0x64 irq 1
[    2.087084] mousedev: PS/2 mouse device common for all mice
[    2.087190] rtc_cmos 00:02: RTC can wake from S4
[    2.087293] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
[    2.087315] rtc_cmos 00:02: alarms up to one month, 242 bytes nvram, h=
pet irqs
[    2.087321] rtc_cmos: BIOS has alarm-disable quirk - RTC alarms disabl=
ed
[    2.087330] ledtrig-cpu: registered to indicate activity on CPUs
[    2.087348] hidraw: raw HID events driver (C) Jiri Kosina
[    2.087455] usbcore: registered new interface driver usbhid
[    2.087456] usbhid: USB HID core driver
[    2.087548] NET: Registered protocol family 10
[    2.088405] registered taskstats version 1
[    2.090888] ata4: SATA link down (SStatus 0 SControl 300)
[    2.090911] ata6: SATA link down (SStatus 0 SControl 300)
[    2.091395] Key type encrypted registered
[    2.091400] AppArmor: AppArmor sha1 policy hashing enabled
[    2.091701]   Magic number: 7:346:136
[    2.091712] misc autofs: hash matches
[    2.091840] rtc_cmos 00:02: setting system clock to 2015-07-21 16:08:1=
4 UTC (1437494894)
[    2.091898] PM: Checking hibernation image partition /dev/raid0/swap
[    2.093890] usb 1-4: new high-speed USB device number 2 using ehci-pci=

[    2.245705] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.245724] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.245742] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.245760] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.246477] ata2.00: ATA-8: ST3000DM001-1CH166, CC24, max UDMA/133
[    2.246479] ata2.00: 5860533168 sectors, multi 0: LBA48 NCQ (depth 31/=
32), AA
[    2.246893] ata3.00: ATA-9: ST3000DM001-1CH166, CC29, max UDMA/133
[    2.246894] ata3.00: 5860533168 sectors, multi 0: LBA48 NCQ (depth 31/=
32), AA
[    2.247314] ata2.00: configured for UDMA/133
[    2.247776] ata3.00: configured for UDMA/133
[    2.253824] ata5.00: ATAPI: HL-DT-ST BD-RE  BH10LS38, 1.00, max UDMA/1=
33
[    2.257634] ata1.00: ATA-8: Corsair Force GT, 1.3.3, max UDMA/133
[    2.257636] ata1.00: 468862128 sectors, multi 16: LBA48 NCQ (depth 31/=
32), AA
[    2.257796] ata5.00: configured for UDMA/133
[    2.267524] ata1.00: configured for UDMA/133
[    2.267655] scsi 0:0:0:0: Direct-Access     ATA      Corsair Force GT =
3    PQ: 0 ANSI: 5
[    2.267846] sd 0:0:0:0: [sda] 468862128 512-byte logical blocks: (240 =
GB/223 GiB)
[    2.267940] scsi 1:0:0:0: Direct-Access     ATA      ST3000DM001-1CH1 =
CC24 PQ: 0 ANSI: 5
[    2.267945] sd 0:0:0:0: [sda] Write Protect is off
[    2.267948] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.267977] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enable=
d, doesn't support DPO or FUA
[    2.268139] sd 1:0:0:0: [sdb] 5860533168 512-byte logical blocks: (3.0=
0 TB/2.72 TiB)
[    2.268140] sd 1:0:0:0: [sdb] 4096-byte physical blocks
[    2.268219] sd 1:0:0:0: [sdb] Write Protect is off
[    2.268221] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    2.268235] scsi 2:0:0:0: Direct-Access     ATA      ST3000DM001-1CH1 =
CC29 PQ: 0 ANSI: 5
[    2.268248] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enable=
d, doesn't support DPO or FUA
[    2.268383]  sda: sda1 sda2
[    2.268403] sd 2:0:0:0: [sdc] 5860533168 512-byte logical blocks: (3.0=
0 TB/2.72 TiB)
[    2.268405] sd 2:0:0:0: [sdc] 4096-byte physical blocks
[    2.268470] sd 2:0:0:0: [sdc] Write Protect is off
[    2.268473] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    2.268502] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enable=
d, doesn't support DPO or FUA
[    2.268708] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.277068] scsi 4:0:0:0: CD-ROM            HL-DT-ST BD-RE  BH10LS38  =
1.00 PQ: 0 ANSI: 5
[    2.303747]  sdb: sdb1 sdb2
[    2.304011] sd 1:0:0:0: [sdb] Attached SCSI disk
[    2.309718]  sdc: sdc1 sdc2
[    2.309964] sd 2:0:0:0: [sdc] Attached SCSI disk
[    2.309973] PM: Hibernation image not present or could not be loaded.
[    2.310383] Freeing unused kernel memory: 1564K (ffffffff81f1a000 - ff=
ffffff820a1000)
[    2.310384] Write protecting the kernel read-only data: 14336k
[    2.310880] Freeing unused kernel memory: 1360K (ffff8800016ac000 - ff=
ff880001800000)
[    2.311199] Freeing unused kernel memory: 1148K (ffff880001ce1000 - ff=
ff880001e00000)
[    2.335902] AVX version of gcm_enc/dec engaged.
[    2.335904] AES CTR mode by8 optimization enabled
[    2.340199] device-mapper: uevent: version 1.0.3
[    2.340260] device-mapper: ioctl: 4.31.0-ioctl (2015-3-12) initialised=
: dm-devel@redhat.com
[    2.347216] md: raid0 personality registered for level 0
[    2.348333] md: raid1 personality registered for level 1
[    2.349470] md: raid10 personality registered for level 10
[    2.366562] raid6: sse2x1   gen()  7250 MB/s
[    2.383533] raid6: sse2x1   xor()  5494 MB/s
[    2.400512] raid6: sse2x2   gen() 11695 MB/s
[    2.417501] raid6: sse2x2   xor()  7902 MB/s
[    2.434469] raid6: sse2x4   gen() 13546 MB/s
[    2.451457] raid6: sse2x4   xor()  6962 MB/s
[    2.451458] raid6: using algorithm sse2x4 gen() 13546 MB/s
[    2.451459] raid6: .... xor() 6962 MB/s, rmw enabled
[    2.451460] raid6: using ssse3x2 recovery algorithm
[    2.451635] async_tx: api initialized (async)
[    2.451910] xor: automatically using best checksumming function:
[    2.461444]    avx       :  4480.000 MB/sec
[    2.462438] md: raid6 personality registered for level 6
[    2.462439] md: raid5 personality registered for level 5
[    2.462440] md: raid4 personality registered for level 4
[    2.466477] hp_sw: device handler registered
[    2.467494] rdac: device handler registered
[    2.468522] alua: device handler registered
[    2.469512] emc: device handler registered
[    2.472323] systemd-udevd[233]: starting version 208
[    2.480619] ACPI: acpi_idle registered with cpuidle
[    2.490732] ohci-pci: OHCI PCI platform driver
[    2.490939] ohci-pci 0000:00:12.0: OHCI PCI host controller
[    2.490945] ohci-pci 0000:00:12.0: new USB bus registered, assigned bu=
s number 4
[    2.490981] ohci-pci 0000:00:12.0: irq 18, io mem 0xfdffe000
[    2.545409] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    2.545412] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
[    2.545414] usb usb4: Product: OHCI PCI host controller
[    2.545415] usb usb4: Manufacturer: Linux 4.1.2-1.1-desktop ohci_hcd
[    2.545416] usb usb4: SerialNumber: 0000:00:12.0
[    2.545642] hub 4-0:1.0: USB hub found
[    2.545652] hub 4-0:1.0: 5 ports detected
[    2.545959] ohci-pci 0000:00:13.0: OHCI PCI host controller
[    2.545964] ohci-pci 0000:00:13.0: new USB bus registered, assigned bu=
s number 5
[    2.545983] ohci-pci 0000:00:13.0: irq 18, io mem 0xfdffc000
[    2.600358] usb usb5: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    2.600361] usb usb5: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
[    2.600362] usb usb5: Product: OHCI PCI host controller
[    2.600364] usb usb5: Manufacturer: Linux 4.1.2-1.1-desktop ohci_hcd
[    2.600365] usb usb5: SerialNumber: 0000:00:13.0
[    2.600501] hub 5-0:1.0: USB hub found
[    2.600511] hub 5-0:1.0: 5 ports detected
[    2.600800] ohci-pci 0000:00:14.5: OHCI PCI host controller
[    2.600804] ohci-pci 0000:00:14.5: new USB bus registered, assigned bu=
s number 6
[    2.600822] ohci-pci 0000:00:14.5: irq 18, io mem 0xfdffa000
[    2.607070] md: bind<sdc2>
[    2.639955] md: bind<sdb2>
[    2.642054] md/raid1:md0: active with 2 out of 2 mirrors
[    2.642163] created bitmap (22 pages) for device md0
[    2.642611] md0: bitmap initialized from disk: read 2 pages, set 0 of =
44710 bits
[    2.655363] usb usb6: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    2.655366] usb usb6: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
[    2.655367] usb usb6: Product: OHCI PCI host controller
[    2.655369] usb usb6: Manufacturer: Linux 4.1.2-1.1-desktop ohci_hcd
[    2.655370] usb usb6: SerialNumber: 0000:00:14.5
[    2.655555] hub 6-0:1.0: USB hub found
[    2.655563] hub 6-0:1.0: 2 ports detected
[    2.655808] ohci-pci 0000:00:16.0: OHCI PCI host controller
[    2.655813] ohci-pci 0000:00:16.0: new USB bus registered, assigned bu=
s number 7
[    2.655830] ohci-pci 0000:00:16.0: irq 18, io mem 0xfdff9000
[    2.683270] tsc: Refined TSC clocksource calibration: 4026.928 MHz
[    2.683277] clocksource tsc: mask: 0xffffffffffffffff max_cycles: 0x3a=
0bba24476, max_idle_ns: 440795259958 ns
[    2.686227] md0: detected capacity change from 0 to 3000382058496
[    2.692059] random: nonblocking pool is initialized
[    2.710285] usb usb7: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    2.710287] usb usb7: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
[    2.710289] usb usb7: Product: OHCI PCI host controller
[    2.710290] usb usb7: Manufacturer: Linux 4.1.2-1.1-desktop ohci_hcd
[    2.710292] usb usb7: SerialNumber: 0000:00:16.0
[    2.710416] hub 7-0:1.0: USB hub found
[    2.710424] hub 7-0:1.0: 4 ports detected
[    2.785728] usb 1-4: New USB device found, idVendor=3D0bda, idProduct=3D=
0151
[    2.785730] usb 1-4: New USB device strings: Mfr=3D1, Product=3D2, Ser=
ialNumber=3D3
[    2.785732] usb 1-4: Product: USB2.0-CRW
[    2.785733] usb 1-4: Manufacturer: Generic
[    2.785734] usb 1-4: SerialNumber: 20060413092100000
[    2.804182] md: linear personality registered for level -1
[    3.032899] usb 7-3: new low-speed USB device number 2 using ohci-pci
[    3.185789] usb 7-3: New USB device found, idVendor=3D046a, idProduct=3D=
0001
[    3.185796] usb 7-3: New USB device strings: Mfr=3D1, Product=3D0, Ser=
ialNumber=3D0
[    3.185801] usb 7-3: Manufacturer: Cherry GmbH
[    3.195203] input: Cherry GmbH as /devices/pci0000:00/0000:00:16.0/usb=
7/7-3/7-3:1.0/0003:046A:0001.0001/input/input1
[    3.245925] hid-generic 0003:046A:0001.0001: input,hidraw0: USB HID v1=
=2E11 Keyboard [Cherry GmbH] on usb-0000:00:16.0-3/input0
[    3.682381] Switched to clocksource tsc
[   13.476204] PM: Marking nosave pages: [mem 0x00000000-0x00000fff]
[   13.476207] PM: Marking nosave pages: [mem 0x00098000-0x000fffff]
[   13.476210] PM: Marking nosave pages: [mem 0xcfda0000-0xffffffff]
[   13.476524] PM: Marking nosave pages: [mem 0xc4000000-0xc7ffffff]
[   13.476771] PM: Basic memory bitmaps created
[   13.477447] PM: Basic memory bitmaps freed
[   13.539965] PM: Starting manual resume from disk
[   13.539968] PM: Hibernation image partition 254:21 present
[   13.539969] PM: Looking for hibernation image.
[   13.540340] PM: Image not found (code -22)
[   13.540341] PM: Hibernation image not present or could not be loaded.
[   13.562069] EXT4-fs (dm-9): mounted filesystem with ordered data mode.=
 Opts: (null)
[   13.663282] systemd[1]: systemd 208 running in system mode. (+PAM +LIB=
WRAP +AUDIT +SELINUX -IMA +SYSVINIT +LIBCRYPTSETUP +GCRYPT +ACL +XZ)
[   13.663713] systemd[1]: Set hostname to <dualc>.
[   13.678916] LVM: Logical Volume autoactivation enabled.
[   13.678934] LVM: Activation generator successfully completed.
[   13.703781] systemd[1]: [/etc/systemd/system/proxy.service:19] Unknown=
 lvalue 'Requires' in section 'Service'
[   13.732378] systemd[1]: Starting Replay Read-Ahead Data...
[   13.732958] systemd[1]: Starting Collect Read-Ahead Data...
[   13.733247] systemd[1]: Starting System Time Synchronized.
[   13.733257] systemd[1]: Reached target System Time Synchronized.
[   13.733273] systemd[1]: Starting Syslog Socket.
[   13.733303] systemd[1]: Listening on Syslog Socket.
[   13.733317] systemd[1]: Starting Remote File Systems (Pre).
[   13.733330] systemd[1]: Reached target Remote File Systems (Pre).
[   13.733338] systemd[1]: Starting Remote File Systems.
[   13.733344] systemd[1]: Reached target Remote File Systems.
[   13.733365] systemd[1]: Starting Delayed Shutdown Socket.
[   13.733380] systemd[1]: Listening on Delayed Shutdown Socket.
[   13.733401] systemd[1]: Starting /dev/initctl Compatibility Named Pipe=
=2E
[   13.733416] systemd[1]: Listening on /dev/initctl Compatibility Named =
Pipe.
[   13.733422] systemd[1]: Starting LVM2 metadata daemon socket.
[   13.733443] systemd[1]: Listening on LVM2 metadata daemon socket.
[   13.733458] systemd[1]: Starting udev Kernel Socket.
[   13.733476] systemd[1]: Listening on udev Kernel Socket.
[   13.733485] systemd[1]: Starting udev Control Socket.
[   13.733499] systemd[1]: Listening on udev Control Socket.
[   13.733510] systemd[1]: Expecting device dev-disk-by\x2did-ata\x2dCors=
air_Force_GT_1203820100000989041B\x2dpart2.device...
[   13.733516] systemd[1]: Expecting device dev-mapper-cr_ata\x2dCorsair_=
Force_GT_1203820100000989041B\x2dpart2.device...
[   13.733526] systemd[1]: Expecting device dev-md0.device...
[   13.733533] systemd[1]: Expecting device dev-mapper-cr_md0.device...
[   13.733543] systemd[1]: Starting Dispatch Password Requests to Console=
 Directory Watch.
[   13.733573] systemd[1]: Started Dispatch Password Requests to Console =
Directory Watch.
[   13.733582] systemd[1]: Starting Paths.
[   13.733589] systemd[1]: Reached target Paths.
[   13.733599] systemd[1]: Starting Journal Socket.
[   13.733631] systemd[1]: Listening on Journal Socket.
[   13.733650] systemd[1]: Mounting Huge Pages File System...
[   13.733957] systemd[1]: Mounting POSIX Message Queue File System...
[   13.734270] systemd[1]: Starting Create dynamic rule for /dev/root lin=
k...
[   13.734609] systemd[1]: Starting LSB: Set default boot entry if called=
=2E..
[   13.734898] systemd[1]: Starting Journal Service...
[   13.735225] systemd[1]: Started Journal Service.
[   13.756511] systemd-journald[671]: Vacuuming done, freed 0 bytes
[   13.796200] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   13.796242] sd 1:0:0:0: Attached scsi generic sg1 type 0
[   13.796301] sd 2:0:0:0: Attached scsi generic sg2 type 0
[   13.796346] scsi 4:0:0:0: Attached scsi generic sg3 type 5
[   13.811927] systemd-udevd[713]: starting version 208
[   13.859631] acpi-cpufreq: overriding BIOS provided _PSD data
[   13.860774] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PN=
P0C0C:00/input/input2
[   13.860949] ACPI: Power Button [PWRB]
[   13.861207] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/in=
put/input3
[   13.861280] ACPI: Power Button [PWRF]
[   13.862229] wmi: Mapper loaded
[   13.876262] shpchp: Standard Hot Plug PCI Controller Driver version: 0=
=2E4
[   13.879195] xhci_hcd 0000:02:00.0: xHCI Host Controller
[   13.879218] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bu=
s number 8
[   13.879297] xhci_hcd 0000:02:00.0: hcc params 0x040050af hci version 0=
x100 quirks 0x00080490
[   13.879662] usb usb8: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[   13.879666] usb usb8: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
[   13.879669] usb usb8: Product: xHCI Host Controller
[   13.879672] usb usb8: Manufacturer: Linux 4.1.2-1.1-desktop xhci-hcd
[   13.879674] usb usb8: SerialNumber: 0000:02:00.0
[   13.880658] hub 8-0:1.0: USB hub found
[   13.880671] hub 8-0:1.0: 2 ports detected
[   13.881859] AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[   13.881861] AMD IOMMUv2 functionality not available on this system
[   13.882751] xhci_hcd 0000:02:00.0: xHCI Host Controller
[   13.882756] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bu=
s number 9
[   13.882811] usb usb9: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003
[   13.882814] usb usb9: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
[   13.882816] usb usb9: Product: xHCI Host Controller
[   13.882819] usb usb9: Manufacturer: Linux 4.1.2-1.1-desktop xhci-hcd
[   13.882821] usb usb9: SerialNumber: 0000:02:00.0
[   13.883058] hub 9-0:1.0: USB hub found
[   13.883069] hub 9-0:1.0: 2 ports detected
[   13.883396] xhci_hcd 0000:05:00.0: xHCI Host Controller
[   13.883403] xhci_hcd 0000:05:00.0: new USB bus registered, assigned bu=
s number 10
[   13.883492] xhci_hcd 0000:05:00.0: hcc params 0x040050af hci version 0=
x100 quirks 0x00080490
[   13.883591] usb usb10: New USB device found, idVendor=3D1d6b, idProduc=
t=3D0002
[   13.883594] usb usb10: New USB device strings: Mfr=3D3, Product=3D2, S=
erialNumber=3D1
[   13.883596] usb usb10: Product: xHCI Host Controller
[   13.883597] usb usb10: Manufacturer: Linux 4.1.2-1.1-desktop xhci-hcd
[   13.883599] usb usb10: SerialNumber: 0000:05:00.0
[   13.883867] hub 10-0:1.0: USB hub found
[   13.883877] hub 10-0:1.0: 2 ports detected
[   13.883980] xhci_hcd 0000:05:00.0: xHCI Host Controller
[   13.883983] xhci_hcd 0000:05:00.0: new USB bus registered, assigned bu=
s number 11
[   13.884021] usb usb11: New USB device found, idVendor=3D1d6b, idProduc=
t=3D0003
[   13.884023] usb usb11: New USB device strings: Mfr=3D3, Product=3D2, S=
erialNumber=3D1
[   13.884025] usb usb11: Product: xHCI Host Controller
[   13.884026] usb usb11: Manufacturer: Linux 4.1.2-1.1-desktop xhci-hcd
[   13.884028] usb usb11: SerialNumber: 0000:05:00.0
[   13.884507] hub 11-0:1.0: USB hub found
[   13.884520] hub 11-0:1.0: 2 ports detected
[   13.900332] ACPI Warning: SystemIO range 0x0000000000000B00-0x00000000=
00000B07 conflicts with OpRegion 0x0000000000000B00-0x0000000000000B0F (\=
SOR1) (20150410/utaddress-254)
[   13.900338] ACPI: If an ACPI driver is available for this device, you =
should use it instead of the native driver
[   13.900659] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver v0.05
[   13.900721] sp5100_tco: PCI Revision ID: 0x42
[   13.900749] sp5100_tco: Using 0xfed80b00 for watchdog MMIO address
[   13.900759] sp5100_tco: Last reboot was not triggered by watchdog.
[   13.900805] sp5100_tco: initialized (0xffffc90003150b00). heartbeat=3D=
60 sec (nowayout=3D0)
[   13.901992] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
[   13.901994] e100: Copyright(c) 1999-2006 Intel Corporation
[   13.906718] MCE: In-kernel MCE decoding enabled.
[   13.908716] EDAC MC: Ver: 3.0.0
[   13.909008] input: PC Speaker as /devices/platform/pcspkr/input/input4=

[   13.909910] AMD64 EDAC driver v3.4.0
[   13.909936] EDAC amd64: DRAM ECC disabled.
[   13.909944] EDAC amd64: ECC disabled in the BIOS or no ECC capability,=
 module will not load.
 Either enable ECC checking or force module loading by setting 'ecc_enabl=
e_override'.
 (Note that use of the override may cause unknown side effects.)
[   13.931402] e100 0000:06:06.0 eth0: addr 0xfd8ff000, irq 20, MAC addr =
00:02:b3:8f:f9:11
[   13.936759] usb-storage 1-4:1.0: USB Mass Storage device detected
[   13.939401] scsi host6: usb-storage 1-4:1.0
[   13.939544] usbcore: registered new interface driver usb-storage
[   13.940828] kvm: Nested Virtualization enabled
[   13.940832] kvm: Nested Paging enabled
[   13.957415] snd_hda_intel 0000:01:00.1: Handle VGA-switcheroo audio cl=
ient
[   13.965755] input: HDA ATI HDMI HDMI/DP,pcm=3D3 as /devices/pci0000:00=
/0000:00:02.0/0000:01:00.1/sound/card1/input5
[   13.967576] sr 4:0:0:0: [sr0] scsi3-mmc drive: 40x/40x writer dvd-ram =
cd/rw xa/form2 cdda tray
[   13.967581] cdrom: Uniform CD-ROM driver Revision: 3.20
[   13.967746] sr 4:0:0:0: Attached scsi CD-ROM sr0
[   13.970666] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC889: =
line_outs=3D4 (0x14/0x15/0x16/0x17/0x0) type:line
[   13.970670] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=3D0 (0x=
0/0x0/0x0/0x0/0x0)
[   13.970672] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=3D1 (0x1b/0x=
0/0x0/0x0/0x0)
[   13.970674] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=3D0x0=

[   13.970676] snd_hda_codec_realtek hdaudioC0D0:    dig-out=3D0x11/0x1e
[   13.970677] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[   13.970680] snd_hda_codec_realtek hdaudioC0D0:      Front Mic=3D0x19
[   13.970681] snd_hda_codec_realtek hdaudioC0D0:      Rear Mic=3D0x18
[   13.970683] snd_hda_codec_realtek hdaudioC0D0:      Line=3D0x1a
[   13.984404] firewire_ohci 0000:06:0e.0: added OHCI v1.10 device as car=
d 0, 4 IR + 8 IT contexts, quirks 0x11
[   13.989250] input: HDA ATI SB Front Mic as /devices/pci0000:00/0000:00=
:14.2/sound/card0/input6
[   13.989358] input: HDA ATI SB Rear Mic as /devices/pci0000:00/0000:00:=
14.2/sound/card0/input7
[   13.989453] input: HDA ATI SB Line as /devices/pci0000:00/0000:00:14.2=
/sound/card0/input8
[   13.989545] input: HDA ATI SB Line Out Front as /devices/pci0000:00/00=
00:00:14.2/sound/card0/input9
[   13.989637] input: HDA ATI SB Line Out Surround as /devices/pci0000:00=
/0000:00:14.2/sound/card0/input10
[   13.989732] input: HDA ATI SB Line Out CLFE as /devices/pci0000:00/000=
0:00:14.2/sound/card0/input11
[   13.989821] input: HDA ATI SB Line Out Side as /devices/pci0000:00/000=
0:00:14.2/sound/card0/input12
[   13.989913] input: HDA ATI SB Front Headphone as /devices/pci0000:00/0=
000:00:14.2/sound/card0/input13
[   14.036347] <6>[fglrx] Maximum main memory to use for locked dma buffe=
rs: 23513 MBytes.
[   14.036807] <6>[fglrx]   vendor: 1002 device: 6759 revision: 0 count: =
1
[   14.037328] <6>[fglrx] IOMMU is enabled, CrossFire are not supported o=
n this platform
[   14.037332] <6>[fglrx] Disable IOMMU in BIOS options or kernel boot pa=
rameters to support CF
[   14.037918] <6>[fglrx] ioport: bar 4, base 0xee00, size: 0x100
[   14.038641] <6>[fglrx] Kernel PAT support is enabled
[   14.038664] <6>[fglrx] module loaded - fglrx 15.20.3 [Jun 22 2015] wit=
h 1 minors
[   14.056720] EXT4-fs (dm-10): mounted filesystem with ordered data mode=
=2E Opts: acl,user_xattr
[   14.116940] EXT4-fs (dm-2): mounted filesystem without journal. Opts: =
acl,user_xattr
[   14.118115] EXT4-fs (dm-11): mounted filesystem with ordered data mode=
=2E Opts: acl,user_xattr
[   14.145952] EXT4-fs (sda1): mounted filesystem with ordered data mode.=
 Opts: acl,user_xattr
[   14.183189] usb 8-1: new low-speed USB device number 2 using xhci_hcd
[   14.329462] usb 8-1: New USB device found, idVendor=3D046d, idProduct=3D=
c03e
[   14.329469] usb 8-1: New USB device strings: Mfr=3D1, Product=3D2, Ser=
ialNumber=3D0
[   14.329473] usb 8-1: Product: USB-PS/2 Optical Mouse
[   14.329477] usb 8-1: Manufacturer: Logitech
[   14.329646] usb 8-1: ep 0x81 - rounding interval to 64 microframes, ep=
 desc says 80 microframes
[   14.342873] input: Logitech USB-PS/2 Optical Mouse as /devices/pci0000=
:00/0000:00:04.0/0000:02:00.0/usb8/8-1/8-1:1.0/0003:046D:C03E.0002/input/=
input14
[   14.343056] hid-generic 0003:046D:C03E.0002: input,hidraw1: USB HID v1=
=2E10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:02:00.0-1/input=
0
[   14.407313] EXT4-fs (dm-3): mounted filesystem without journal. Opts: =
acl,user_xattr
[   14.484227] EXT4-fs (dm-4): mounted filesystem without journal. Opts: =
acl,user_xattr
[   14.484962] firewire_core 0000:06:0e.0: created device fw0: GUID 0049e=
55043900400, S400
[   14.552339] SGI XFS with ACLs, security attributes, realtime, no debug=
 enabled
[   14.553852] XFS (dm-5): Mounting V4 Filesystem
[   14.608070] XFS (dm-5): Ending clean mount
[   14.655754] EXT4-fs (dm-6): mounted filesystem without journal. Opts: =
acl,user_xattr
[   14.684307] EXT4-fs (dm-7): mounted filesystem without journal. Opts: =
acl,user_xattr
[   14.747561] EXT4-fs (dm-8): mounted filesystem without journal. Opts: =
acl,user_xattr
[   14.907465] Adding 8388604k swap on /dev/mapper/raid0-swap.  Priority:=
-1 extents:1 across:8388604k FS
[   14.910351] XFS (dm-22): Mounting V4 Filesystem
[   14.945668] scsi 6:0:0:0: Direct-Access     Generic- Compact Flash    =
1.00 PQ: 0 ANSI: 0 CCS
[   14.945916] sd 6:0:0:0: Attached scsi generic sg4 type 0
[   14.952909] scsi 6:0:0:1: Direct-Access     Generic- SM/xD-Picture    =
1.00 PQ: 0 ANSI: 0 CCS
[   14.953034] sd 6:0:0:1: Attached scsi generic sg5 type 0
[   14.960656] scsi 6:0:0:2: Direct-Access     Generic- SD/MMC           =
1.00 PQ: 0 ANSI: 0 CCS
[   14.960788] sd 6:0:0:2: Attached scsi generic sg6 type 0
[   14.969140] scsi 6:0:0:3: Direct-Access     Generic- MS/MS-Pro        =
1.00 PQ: 0 ANSI: 0 CCS
[   14.969691] sd 6:0:0:3: Attached scsi generic sg7 type 0
[   14.978273] sd 6:0:0:0: [sdd] Attached SCSI removable disk
[   14.988864] sd 6:0:0:1: [sde] Attached SCSI removable disk
[   14.998469] sd 6:0:0:2: [sdf] Attached SCSI removable disk
[   15.008088] sd 6:0:0:3: [sdg] Attached SCSI removable disk
[   15.195068] XFS (dm-28): Mounting V4 Filesystem
[   15.596355] XFS (dm-13): Mounting V4 Filesystem
[   15.629840] EXT4-fs (dm-20): mounted filesystem with ordered data mode=
=2E Opts: acl,user_xattr
[   15.642956] XFS (dm-15): Mounting V4 Filesystem
[   15.753325] XFS (dm-14): Mounting V4 Filesystem
[   15.989882] XFS (dm-22): Ending clean mount
[   16.138038] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:11.0 domai=
n=3D0x0008 address=3D0x4027971700618000 flags=3D0x0010]
[   16.138378] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:11.0 domai=
n=3D0x0008 address=3D0x4027971700618040 flags=3D0x0010]
[   16.138708] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:11.0 domai=
n=3D0x0008 address=3D0x4027971700618080 flags=3D0x0010]
[   16.157439] XFS (dm-28): Ending clean mount
[   16.877253] floppy0: no floppy controllers found
[   46.677498] ata3.00: exception Emask 0x0 SAct 0x1e0000 SErr 0x0 action=
 0x6 frozen
[   46.677738] ata3.00: failed command: WRITE FPDMA QUEUED
[   46.677906] ata3.00: cmd 61/00:88:17:8f:27/08:00:14:00:00/40 tag 17 nc=
q 1048576 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[   46.678408] ata3.00: status: { DRDY }
[   46.678522] ata3.00: failed command: WRITE FPDMA QUEUED
[   46.678688] ata3.00: cmd 61/00:90:17:97:27/08:00:14:00:00/40 tag 18 nc=
q 1048576 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[   46.679147] ata3.00: status: { DRDY }
[   46.679260] ata3.00: failed command: WRITE FPDMA QUEUED
[   46.679448] ata3.00: cmd 61/30:98:24:9a:26/07:00:8c:00:00/40 tag 19 nc=
q 942080 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[   46.691879] ata3.00: status: { DRDY }
[   46.703885] ata3.00: failed command: WRITE FPDMA QUEUED
[   46.715701] ata3.00: cmd 61/e0:a0:54:a1:26/06:00:8c:00:00/40 tag 20 nc=
q 901120 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[   46.739165] ata3.00: status: { DRDY }
[   46.750696] ata3: hard resetting link
[   47.260764] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   47.262572] ata3.00: configured for UDMA/133
[   47.262600] ata3.00: device reported invalid CHS sector 0
[   47.262659] ata3.00: device reported invalid CHS sector 0
[   47.262670] ata3.00: device reported invalid CHS sector 0
[   47.262689] ata3.00: device reported invalid CHS sector 0
[   47.262724] ata3: EH complete
[   47.271755] XFS (dm-13): Ending clean mount
[   47.542578] XFS (dm-15): Ending clean mount
[   47.573983] XFS (dm-14): Ending clean mount
[   47.581867] systemd-journald[671]: Received request to flush runtime j=
ournal from PID 1
[   47.624412] audit: type=3D1400 audit(1437494940.083:2): apparmor=3D"ST=
ATUS" operation=3D"profile_load" name=3D"/{usr/,}bin/ping" pid=3D1199 com=
m=3D"apparmor_parser"
[   47.640195] audit: type=3D1400 audit(1437494940.099:3): apparmor=3D"ST=
ATUS" operation=3D"profile_load" name=3D"/sbin/klogd" pid=3D1208 comm=3D"=
apparmor_parser"
[   47.648912] audit: type=3D1400 audit(1437494940.107:4): apparmor=3D"ST=
ATUS" operation=3D"profile_load" name=3D"/sbin/syslog-ng" pid=3D1212 comm=
=3D"apparmor_parser"
[   47.657773] audit: type=3D1400 audit(1437494940.116:5): apparmor=3D"ST=
ATUS" operation=3D"profile_load" name=3D"/sbin/syslogd" pid=3D1216 comm=3D=
"apparmor_parser"
[   47.670660] audit: type=3D1400 audit(1437494940.129:6): apparmor=3D"ST=
ATUS" operation=3D"profile_load" name=3D"/usr/lib/apache2/mpm-prefork/apa=
che2" pid=3D1221 comm=3D"apparmor_parser"
[   47.670668] audit: type=3D1400 audit(1437494940.129:7): apparmor=3D"ST=
ATUS" operation=3D"profile_load" name=3D"DEFAULT_URI" pid=3D1221 comm=3D"=
apparmor_parser"
[   47.670673] audit: type=3D1400 audit(1437494940.129:8): apparmor=3D"ST=
ATUS" operation=3D"profile_load" name=3D"HANDLING_UNTRUSTED_INPUT" pid=3D=
1221 comm=3D"apparmor_parser"
[   47.670679] audit: type=3D1400 audit(1437494940.129:9): apparmor=3D"ST=
ATUS" operation=3D"profile_load" name=3D"phpsysinfo" pid=3D1221 comm=3D"a=
pparmor_parser"
[   47.677579] audit: type=3D1400 audit(1437494940.136:10): apparmor=3D"S=
TATUS" operation=3D"profile_load" name=3D"/usr/lib/dovecot/anvil" pid=3D1=
225 comm=3D"apparmor_parser"
[   47.686647] audit: type=3D1400 audit(1437494940.145:11): apparmor=3D"S=
TATUS" operation=3D"profile_load" name=3D"/usr/lib/dovecot/auth" pid=3D12=
29 comm=3D"apparmor_parser"
[   47.916852] it87: Found IT8720F chip at 0x228, revision 8
[   47.916878] it87: Routing internal VCCH to in7
[   47.916882] it87: Beeping is supported
[   48.193901] <6>[fglrx] Firegl kernel thread PID: 1840
[   48.193985] <6>[fglrx] Firegl kernel thread PID: 1841
[   48.194063] <6>[fglrx] Firegl kernel thread PID: 1842
[   48.194172] <6>[fglrx] IRQ 28 Enabled
[   48.261580] <6>[fglrx] Reserved FB block: Shared offset:0, size:100000=
0=20
[   48.261586] <6>[fglrx] Reserved FB block: Unshared offset:f7b4000, siz=
e:4000=20
[   48.261587] <6>[fglrx] Reserved FB block: Unshared offset:f7b8000, siz=
e:548000=20
[   48.261588] <6>[fglrx] Reserved FB block: Unshared offset:3fff3000, si=
ze:d000=20
[   66.833962] fuse init (API version 7.23)
[   79.574883] tun: Universal TUN/TAP device driver, 1.6
[   79.574890] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[   84.830242] bridge: automatic filtering via arp/ip/ip6tables has been =
deprecated. Update your scripts to load br_netfilter if you need this.
[   84.835380] device tap0 entered promiscuous mode
[   84.838052] device tap1 entered promiscuous mode
[   84.840604] device tap2 entered promiscuous mode
[   84.844187] device tap3 entered promiscuous mode
[   84.848473] device tap4 entered promiscuous mode
[   84.852358] device tap11 entered promiscuous mode
[   91.976694] device tap5 entered promiscuous mode
[   91.979799] device tap6 entered promiscuous mode
[   91.982923] device tap9 entered promiscuous mode
[   97.991404] ata1.00: configured for UDMA/133
[   97.991411] ata1: EH complete
[   97.995681] RPC: Registered named UNIX socket transport module.
[   97.995684] RPC: Registered udp transport module.
[   97.995685] RPC: Registered tcp transport module.
[   97.995686] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   97.999686] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   98.053937] VFIO - User Level meta-driver version: 0.3
[   98.058156] firewire_ohci 0000:06:0e.0: removed fw-ohci device
[   98.174346] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state rec=
overy directory
[   98.174499] NFSD: starting 90-second grace period (net ffffffff81ed7c0=
0)
[  100.177429] ip_tables: (C) 2000-2006 Netfilter Core Team
[  100.190442] nf_conntrack version 0.5.0 (65536 buckets, 262144 max)
[  100.435527] br0: port 1(tap0) entered forwarding state
[  100.435536] br0: port 1(tap0) entered forwarding state
[  100.438351] br1: port 2(tap6) entered forwarding state
[  100.438357] br1: port 2(tap6) entered forwarding state
[  100.438455] br0: port 5(tap4) entered forwarding state
[  100.438458] br0: port 5(tap4) entered forwarding state
[  100.778246] kvm: zapping shadow pages for mmio generation wraparound
[  100.864462] kvm: zapping shadow pages for mmio generation wraparound
[  102.970656] kvm [9802]: vcpu0 unimplemented perfctr wrmsr: 0xc0010004 =
data 0xffff
[  105.361778] kvm [9800]: vcpu0 unimplemented perfctr wrmsr: 0xc0010004 =
data 0xffff
[  105.542200] br0: port 2(tap1) entered forwarding state
[  105.542208] br0: port 2(tap1) entered forwarding state
[  105.700420] vfio-pci 0000:06:06.0: enabling device (0000 -> 0003)
[  109.158570] kvm: zapping shadow pages for mmio generation wraparound
[  110.614762] br1: port 1(tap5) entered forwarding state
[  110.614770] br1: port 1(tap5) entered forwarding state
[  110.630890] br0: port 4(tap3) entered forwarding state
[  110.630901] br0: port 4(tap3) entered forwarding state
[  111.062493] kvm: zapping shadow pages for mmio generation wraparound
[  111.146884] kvm: zapping shadow pages for mmio generation wraparound
[  112.169430] kvm [9887]: vcpu0 unimplemented perfctr wrmsr: 0xc0010004 =
data 0xabcd
[  113.199284] kvm [10000]: vcpu0 unimplemented perfctr wrmsr: 0xc0010004=
 data 0xffff
[  115.510642] kvm [9996]: vcpu0 unhandled rdmsr: 0xc0010112
[  115.642579] kvm [9996]: vcpu0 unhandled rdmsr: 0xc0011021
[  115.679777] kvm [9996]: vcpu0 unimplemented perfctr wrmsr: 0xc0010004 =
data 0xffff
[  119.736038] kvm [9996]: vcpu0 unhandled rdmsr: 0x3a
[  119.736044] kvm [9996]: vcpu0 unhandled rdmsr: 0xd90

--------------080900020804030403040101--
