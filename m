Return-Path: <SRS0=utOo=XV=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=utOo=XV=huawei.com=liudongdong3@kernel.org>
Subject: Re: [PATCH v11 00/15] PCI: ARM64 ECAM quirks
To: Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
References: <20161205232117.3957.50546.stgit@bhelgaas-glaptop.roam.corp.google.com>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gabriele Paoloni
	<gabriele.paoloni@huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tomasz Nowicki <tn@semihalf.com>, Duc Dang <dhdang@apm.com>,
        Sinan Kaya
	<okaya@codeaurora.org>,
        Christopher Covington <cov@codeaurora.org>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <f880ae27-c3a8-d61c-c4b1-3af9da0f28a2@huawei.com>
Date: Tue, 6 Dec 2016 15:16:23 +0800
MIME-Version: 1.0
In-Reply-To: <20161205232117.3957.50546.stgit@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>



在 2016/12/6 7:25, Bjorn Helgaas 写道:
> Here's another try.  The biggest change is to add the APM X-Gene quirks.
>
> These are on my pci/ecam branch.  Please test and report any issues.
> Please also collect dmesg and /proc/iomem contents and I'll try to
> summarize the current ACPI firmware situation on ARM64 and update the
> writeup with recommendations for future platforms.

The dmesg and /proc/iomem information are as below on HiSilicon D03 board.
root@(none)$ dmesg
[    0.000000] Booting Linux on physical CPU 0x10000
[    0.000000] Linux version 4.9.0-rc1-g7e48b6b (l00290354@linux-ioko) (gcc version 4.9.3 20150211 (prerelease) (20150316) ) #261 SMP PREEMPT Tue Dec 6 11:32:41 CST 2016
[    0.000000] Boot CPU: AArch64 Processor [411fd071]
[    0.000000] earlycon: hisilpcuart0 at MMIO 0x00000000a01b0000 (options '0,0x2f8')
[    0.000000] bootconsole [hisilpcuart0] enabled
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: EFI v2.60 by EDK II
[    0.000000] efi:  SMBIOS=0x3f110000  SMBIOS 3.0=0x39ce0000  ACPI=0x39db0000  ACPI 2.0=0x39db0014  MEMATTR=0x3c943018
[    0.000000] cma: Reserved 16 MiB at 0x000000003e000000
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x0000000039DB0014 000024 (v02 HISI  )
[    0.000000] ACPI: XSDT 0x0000000039DA00E8 00004C (v01 HISI   HIP06    00000000      01000013)
[    0.000000] ACPI: FACP 0x0000000039CA0000 00010C (v05 HISI   HIP06    00000000 INTL 20151124)
[    0.000000] ACPI: DSDT 0x0000000039C60000 003B02 (v01 HISI   HIP06    00000000 INTL 20150619)
[    0.000000] ACPI: MCFG 0x0000000039CC0000 00005C (v01 HISI   HIP06    00000000 INTL 20151124)
[    0.000000] ACPI: GTDT 0x0000000039C90000 000098 (v02 HISI   HIP06    00000000 INTL 20151124)
[    0.000000] ACPI: APIC 0x0000000039C80000 000518 (v01 HISI   HIP06    00000000 INTL 20151124)
[    0.000000] ACPI: IORT 0x0000000039C70000 0002E8 (v00 HISI   HIP06    00000000 INTL 20150619)
[    0.000000] ACPI: NUMA: Failed to initialise from firmware
[    0.000000] NUMA: Faking a node at [mem 0x0000000000000000-0x00000027ffffffff]
[    0.000000] NUMA: Adding memblock [0x0 - 0x257ff] on node 0
[    0.000000] NUMA: Adding memblock [0x25800 - 0x319fffff] on node 0
[    0.000000] NUMA: Adding memblock [0x31a00000 - 0x31a6ffff] on node 0
[    0.000000] NUMA: Adding memblock [0x31a70000 - 0x31b5ffff] on node 0
[    0.000000] NUMA: Adding memblock [0x31b60000 - 0x31b6ffff] on node 0
[    0.000000] NUMA: Adding memblock [0x31b70000 - 0x31b7dfff] on node 0
[    0.000000] NUMA: Adding memblock [0x31b7e000 - 0x31b81fff] on node 0
[    0.000000] NUMA: Adding memblock [0x31b82000 - 0x39c0ffff] on node 0
[    0.000000] NUMA: Adding memblock [0x39c10000 - 0x3a11ffff] on node 0
[    0.000000] NUMA: Adding memblock [0x3a120000 - 0x3f10ffff] on node 0
[    0.000000] NUMA: Adding memblock [0x3f110000 - 0x3f13ffff] on node 0
[    0.000000] NUMA: Adding memblock [0x3f140000 - 0x3fbfffff] on node 0
[    0.000000] NUMA: Adding memblock [0x2040000000 - 0x27ffffffff] on node 0
[    0.000000] NUMA: Initmem setup node 0 [mem 0x00000000-0x27ffffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x27fffef500-0x27ffff0fff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000027ffffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x0000000000024fff]
[    0.000000]   node   0: [mem 0x0000000000026000-0x00000000319fffff]
[    0.000000]   node   0: [mem 0x0000000031a00000-0x0000000031a6ffff]
[    0.000000]   node   0: [mem 0x0000000031a70000-0x0000000031b5ffff]
[    0.000000]   node   0: [mem 0x0000000031b60000-0x0000000031b6ffff]
[    0.000000]   node   0: [mem 0x0000000031b70000-0x0000000031b7dfff]
[    0.000000]   node   0: [mem 0x0000000031b7e000-0x0000000031b81fff]
[    0.000000]   node   0: [mem 0x0000000031b82000-0x0000000039c0ffff]
[    0.000000]   node   0: [mem 0x0000000039c10000-0x000000003a11ffff]
[    0.000000]   node   0: [mem 0x000000003a120000-0x000000003f10ffff]
[    0.000000]   node   0: [mem 0x000000003f110000-0x000000003f13ffff]
[    0.000000]   node   0: [mem 0x000000003f140000-0x000000003fbfffff]
[    0.000000]   node   0: [mem 0x0000002040000000-0x00000027ffffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x00000027ffffffff]
[    0.000000] On node 0 totalpages: 8387583
[    0.000000]   DMA zone: 4080 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 261119 pages, LIFO batch:31
[    0.000000]   Normal zone: 126976 pages used for memmap
[    0.000000]   Normal zone: 8126464 pages, LIFO batch:31
[    0.000000] psci: probing for conduit method from ACPI.
[    0.000000] psci: PSCIv1.0 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] percpu: Embedded 21 pages/cpu @ffff8027ffe6c000 s48000 r8192 d29824 u86016
[    0.000000] pcpu-alloc: s48000 r8192 d29824 u86016 alloc=21*4096
[    0.000000] pcpu-alloc: [0] 00 [0] 01 [0] 02 [0] 03 [0] 04 [0] 05 [0] 06 [0] 07
[    0.000000] pcpu-alloc: [0] 08 [0] 09 [0] 10 [0] 11 [0] 12 [0] 13 [0] 14 [0] 15
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] CPU features: enabling workaround for ARM erratum 832075
[    0.000000] CPU features: enabling workaround for ARM erratum 834220
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 8256527
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: earlycon=hisilpcuart,mmio,0xa01b0000,0,0x2f8 console=ttyS0,115200 initrd=filesystem.cpio.gz acpi=force  pci=pcie_bus_perf
[    0.000000] log_buf_len individual max cpu contribution: 4096 bytes
[    0.000000] log_buf_len total cpu_extra contributions: 61440 bytes
[    0.000000] log_buf_len min size: 16384 bytes
[    0.000000] log_buf_len: 131072 bytes
[    0.000000] early log buf free: 10756(65%)
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] software IO TLB [mem 0x35c10000-0x39c10000] (64MB) mapped at [ffff800035c10000-ffff800039c0ffff]
[    0.000000] Memory: 32893844K/33550332K available (8508K kernel code, 868K rwdata, 3716K rodata, 1024K init, 287K bss, 640104K reserved, 16384K cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     modules : 0xffff000000000000 - 0xffff000008000000   (   128 MB)
[    0.000000]     vmalloc : 0xffff000008000000 - 0xffff7dffbfff0000   (129022 GB)
[    0.000000]       .text : 0xffff000008080000 - 0xffff0000088d0000   (  8512 KB)
[    0.000000]     .rodata : 0xffff0000088d0000 - 0xffff000008c80000   (  3776 KB)
[    0.000000]       .init : 0xffff000008c80000 - 0xffff000008d80000   (  1024 KB)
[    0.000000]       .data : 0xffff000008d80000 - 0xffff000008e59200   (   869 KB)
[    0.000000]        .bss : 0xffff000008e59200 - 0xffff000008ea0fc0   (   288 KB)
[    0.000000]     fixed   : 0xffff7dfffe7fd000 - 0xffff7dfffec00000   (  4108 KB)
[    0.000000]     PCI I/O : 0xffff7dfffee00000 - 0xffff7dffffe00000   (    16 MB)
[    0.000000]     vmemmap : 0xffff7e0000000000 - 0xffff800000000000   (  2048 GB maximum)
[    0.000000]               0xffff7e0000000000 - 0xffff7e00a0000000   (  2560 MB actual)
[    0.000000]     memory  : 0xffff800000000000 - 0xffff802800000000   (163840 MB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=16.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=16
[    0.000000] NR_IRQS:64 nr_irqs:64 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] ITS [mem 0xc6000000-0xc601ffff]
[    0.000000] ITS@0x00000000c6000000: allocated 524288 Devices @27df400000 (flat, esz 8, psz 16K, shr 1)
[    0.000000] ITS@0x00000000c6000000: allocated 2048 Virtual CPUs @27df814000 (flat, esz 8, psz 4K, shr 1)
[    0.000000] ITS@0x00000000c6000000: allocated 512 Interrupt Collections @27df811000 (flat, esz 8, psz 4K, shr 1)
[    0.000000] GIC: using LPI property table @0x00000027df830000
[    0.000000] ITS: Allocated 1792 chunks for LPIs
[    0.000000] GICv3: CPU0: found redistributor 10000 region 0:0x000000004d100000
[    0.000000] CPU0: using LPI pending table @0x00000027df840000
[    0.000000] arch_timer: cp15 timer(s) running at 50.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0xb8812736b, max_idle_ns: 440795202655 ns
[    0.000001] sched_clock: 56 bits at 50MHz, resolution 20ns, wraps every 4398046511100ns
[    0.009129] Console: colour dummy device 80x25
[    0.014161] Calibrating delay loop (skipped), value calculated using timer frequency.. 100.00 BogoMIPS (lpj=200000)
[    0.025922] pid_max: default: 32768 minimum: 301
[    0.031178] ACPI: Core revision 20160831
[    0.036722] ACPI: 1 ACPI AML tables successfully acquired and loaded

[    0.045689] Security Framework initialized
[    0.054740] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes)
[    0.076025] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    0.089758] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.097656] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.106805] ASID allocator initialised with 65536 entries
[    0.145006] PCI/MSI: ITS@0xc6000000 domain created
[    0.150462] Platform MSI: ITS@0xc6000000 domain created
[    0.156469] Remapping and enabling EFI services.
[    0.161712]   EFI remap 0x0000000031a00000 => 0000000020000000
[    0.168311]   EFI remap 0x0000000031b60000 => 0000000020070000
[    0.174904]   EFI remap 0x0000000039c10000 => 0000000020080000
[    0.181502]   EFI remap 0x0000000039c50000 => 00000000200c0000
[    0.188100]   EFI remap 0x0000000039cd0000 => 00000000200d0000
[    0.194694]   EFI remap 0x0000000039d50000 => 0000000020150000
[    0.201288]   EFI remap 0x0000000039dc0000 => 00000000201a0000
[    0.207890]   EFI remap 0x0000000039e10000 => 00000000201f0000
[    0.214483]   EFI remap 0x0000000039f20000 => 0000000020300000
[    0.221080]   EFI remap 0x0000000039f90000 => 0000000020370000
[    0.227682]   EFI remap 0x0000000039fe0000 => 00000000203c0000
[    0.234280]   EFI remap 0x000000003a030000 => 0000000020410000
[    0.240873]   EFI remap 0x000000003a080000 => 0000000020460000
[    0.247471]   EFI remap 0x000000003a0d0000 => 00000000204b0000
[    0.254069]   EFI remap 0x000000003f110000 => 0000000020500000
[    0.260663]   EFI remap 0x0000000078000000 => 0000000020530000
[    0.267258]   EFI remap 0x00000000a4000000 => 0000000020600000
[    0.273886]   EFI remap 0x00000000a6000000 => 0000000021600000
[    0.280484]   EFI remap 0x00000000d00e0000 => 0000000021610000
[    0.387578] Detected PIPT I-cache on CPU1
[    0.387593] GICv3: CPU1: found redistributor 10001 region 1:0x000000004d130000
[    0.387624] CPU1: using LPI pending table @0x00000027dc300000
[    0.387639] CPU1: Booted secondary processor [411fd071]
[    0.468292] Detected PIPT I-cache on CPU2
[    0.468300] GICv3: CPU2: found redistributor 10002 region 2:0x000000004d160000
[    0.468330] CPU2: using LPI pending table @0x00000027dc330000
[    0.468340] CPU2: Booted secondary processor [411fd071]
[    0.548998] Detected PIPT I-cache on CPU3
[    0.549006] GICv3: CPU3: found redistributor 10003 region 3:0x000000004d190000
[    0.549035] CPU3: using LPI pending table @0x00000027dc370000
[    0.549046] CPU3: Booted secondary processor [411fd071]
[    0.629654] Detected PIPT I-cache on CPU4
[    0.629667] GICv3: CPU4: found redistributor 10100 region 4:0x000000004d1c0000
[    0.629697] CPU4: using LPI pending table @0x00000027dc3a0000
[    0.629711] CPU4: Booted secondary processor [411fd071]
[    0.710354] Detected PIPT I-cache on CPU5
[    0.710362] GICv3: CPU5: found redistributor 10101 region 5:0x000000004d1f0000
[    0.710391] CPU5: using LPI pending table @0x00000027dc3d0000
[    0.710401] CPU5: Booted secondary processor [411fd071]
[    0.791096] Detected PIPT I-cache on CPU6
[    0.791104] GICv3: CPU6: found redistributor 10102 region 6:0x000000004d220000
[    0.791133] CPU6: using LPI pending table @0x00000027dbc20000
[    0.791143] CPU6: Booted secondary processor [411fd071]
[    0.871802] Detected PIPT I-cache on CPU7
[    0.871810] GICv3: CPU7: found redistributor 10103 region 7:0x000000004d250000
[    0.871839] CPU7: using LPI pending table @0x00000027dbc50000
[    0.871849] CPU7: Booted secondary processor [411fd071]
[    0.952618] Detected PIPT I-cache on CPU8
[    0.952631] GICv3: CPU8: found redistributor 10200 region 8:0x000000004d280000
[    0.952662] CPU8: using LPI pending table @0x00000027dbc80000
[    0.952675] CPU8: Booted secondary processor [411fd071]
[    1.033326] Detected PIPT I-cache on CPU9
[    1.033334] GICv3: CPU9: found redistributor 10201 region 9:0x000000004d2b0000
[    1.033364] CPU9: using LPI pending table @0x00000027dbcc0000
[    1.033374] CPU9: Booted secondary processor [411fd071]
[    1.114050] Detected PIPT I-cache on CPU10
[    1.114059] GICv3: CPU10: found redistributor 10202 region 10:0x000000004d2e0000
[    1.114088] CPU10: using LPI pending table @0x00000027dbcf0000
[    1.114098] CPU10: Booted secondary processor [411fd071]
[    1.194777] Detected PIPT I-cache on CPU11
[    1.194786] GICv3: CPU11: found redistributor 10203 region 11:0x000000004d310000
[    1.194815] CPU11: using LPI pending table @0x00000027dbd30000
[    1.194825] CPU11: Booted secondary processor [411fd071]
[    1.275514] Detected PIPT I-cache on CPU12
[    1.275528] GICv3: CPU12: found redistributor 10300 region 12:0x000000004d340000
[    1.275559] CPU12: using LPI pending table @0x00000027dbd60000
[    1.275572] CPU12: Booted secondary processor [411fd071]
[    1.356225] Detected PIPT I-cache on CPU13
[    1.356233] GICv3: CPU13: found redistributor 10301 region 13:0x000000004d370000
[    1.356263] CPU13: using LPI pending table @0x00000027dbdb0000
[    1.356273] CPU13: Booted secondary processor [411fd071]
[    1.436948] Detected PIPT I-cache on CPU14
[    1.436957] GICv3: CPU14: found redistributor 10302 region 14:0x000000004d3a0000
[    1.436986] CPU14: using LPI pending table @0x00000027dbde0000
[    1.436996] CPU14: Booted secondary processor [411fd071]
[    1.517651] Detected PIPT I-cache on CPU15
[    1.517660] GICv3: CPU15: found redistributor 10303 region 15:0x000000004d3d0000
[    1.517690] CPU15: using LPI pending table @0x00000027dbe10000
[    1.517699] CPU15: Booted secondary processor [411fd071]
[    1.517740] Brought up 16 CPUs
[    1.900501] SMP: Total of 16 processors activated.
[    1.905914] CPU features: detected feature: GIC system register CPU interface
[    1.913979] CPU features: detected feature: 32-bit EL0 Support
[    1.920635] CPU: All CPU(s) started at EL2
[    1.925343] alternatives: patching kernel code
[    1.935331] devtmpfs: initialized
[    1.939440] SMBIOS 3.0.0 present.
[    1.943307] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    1.954592] pinctrl core: initialized pinctrl subsystem
[    1.960951] NET: Registered protocol family 16
[    2.059114] cpuidle: using governor menu
[    2.063620] vdso: 2 pages (1 code @ ffff0000088d7000, 1 data @ ffff000008d84000)
[    2.072051] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    2.080284] DMA: preallocated 256 KiB pool for atomic allocations
[    2.087404] ACPI: bus type PCI registered
[    2.092067] Serial: AMBA PL011 UART driver
[    2.117017] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    2.124855] ACPI: Added _OSI(Module Device)
[    2.129611] ACPI: Added _OSI(Processor Device)
[    2.134659] ACPI: Added _OSI(3.0 _SCP Extensions)
[    2.140012] ACPI: Added _OSI(Processor Aggregator Device)
[    2.148077] ACPI: Interpreter enabled
[    2.152240] ACPI: Using GIC for interrupt routing
[    2.157602] ACPI: MCFG table detected, 3 entries
[    2.180043] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-1f])
[    2.187080] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    2.196543] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug PME AER]
[    2.205282] acpi PNP0A08:00: _OSC: OS now controls [PCIeCapability]
[    2.212420] acpi PNP0A08:00: MCFG quirk: ECAM at [mem 0xb0000000-0xb1ffffff] for [bus 00-1f] with hisi_pcie_ops
[    2.224524] acpi PNP0A08:00: ECAM area [mem 0xb0000000-0xb1ffffff] reserved by HISI0081:00
[    2.234149] acpi PNP0A08:00: ECAM at [mem 0xb0000000-0xb1ffffff] for [bus 00-1f]
[    2.242587] Remapped I/O 0x00000000b7ff0000 to [io  0x0000-0xffff window]
[    2.250473] PCI host bridge to bus 0000:00
[    2.255207] pci_bus 0000:00: root bus resource [mem 0xb2000000-0xb7feffff window]
[    2.263838] pci_bus 0000:00: root bus resource [io  0x0000-0xffff window]
[    2.271688] pci_bus 0000:00: root bus resource [bus 00-1f]
[    2.278039] pci 0000:00:00.0: [19e5:1610] type 01 class 0x060400
[    2.278049] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x0000ffff]
[    2.278087] pci 0000:00:00.0: supports D1 D2
[    2.278089] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
[    2.329441] pci 0000:00:00.0: BAR 0: assigned [mem 0xb2000000-0xb200ffff]
[    2.337272] pci 0000:00:00.0: PCI bridge to [bus 01]
[    2.343009] pci 0000:00:00.0: Max Payload Size set to  512/ 512 (was  128), Max Read Rq  512
[    2.352767] ACPI: PCI Root Bridge [PCI1] (domain 0001 [bus e0-ff])
[    2.359894] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    2.369463] acpi PNP0A08:01: _OSC: platform does not support [PCIeHotplug PME AER]
[    2.378315] acpi PNP0A08:01: _OSC: OS now controls [PCIeCapability]
[    2.385532] acpi PNP0A08:01: MCFG quirk: ECAM at [mem 0xbe000000-0xbfffffff] for [bus e0-ff] with hisi_pcie_ops
[    2.397799] acpi PNP0A08:01: ECAM area [mem 0xbe000000-0xbfffffff] reserved by HISI0081:01
[    2.407538] acpi PNP0A08:01: ECAM at [mem 0xbe000000-0xbfffffff] for [bus e0-ff]
[    2.416108] Remapped I/O 0x00000000bdff0000 to [io  0x10000-0x1ffff window]
[    2.424194] PCI host bridge to bus 0001:e0
[    2.428905] pci_bus 0001:e0: root bus resource [mem 0xb8000000-0xbdfeffff window]
[    2.437533] pci_bus 0001:e0: root bus resource [io  0x10000-0x1ffff window] (bus address [0x0000-0xffff])
[    2.448566] pci_bus 0001:e0: root bus resource [bus e0-ff]
[    2.454894] pci 0001:e0:00.0: [19e5:1610] type 01 class 0x060400
[    2.454902] pci 0001:e0:00.0: reg 0x10: [mem 0x00000000-0x00000fff]
[    2.454910] pci 0001:e0:00.0: reg 0x38: [mem 0xfffe0000-0xffffffff pref]
[    2.454938] pci 0001:e0:00.0: supports D1 D2
[    2.454940] pci 0001:e0:00.0: PME# supported from D0 D1 D3hot
[    2.455070] pci 0001:e1:00.0: [1000:005d] type 00 class 0x010400
[    2.455079] pci 0001:e1:00.0: reg 0x10: [io  0x10000-0x100ff]
[    2.455086] pci 0001:e1:00.0: reg 0x14: [mem 0xb8100000-0xb810ffff 64bit]
[    2.455093] pci 0001:e1:00.0: reg 0x1c: [mem 0xb8000000-0xb80fffff 64bit]
[    2.455101] pci 0001:e1:00.0: reg 0x30: [mem 0xfff00000-0xffffffff pref]
[    2.455151] pci 0001:e1:00.0: supports D1 D2
[    2.466911] pci 0001:e0:00.0: BAR 14: assigned [mem 0xb8000000-0xb82fffff]
[    2.474842] pci 0001:e0:00.0: BAR 6: assigned [mem 0xb8300000-0xb831ffff pref]
[    2.483164] pci 0001:e0:00.0: BAR 0: assigned [mem 0xb8320000-0xb8320fff]
[    2.490996] pci 0001:e0:00.0: BAR 13: assigned [io  0x10000-0x10fff]
[    2.498325] pci 0001:e1:00.0: BAR 3: assigned [mem 0xb8000000-0xb80fffff 64bit]
[    2.506753] pci 0001:e1:00.0: BAR 6: assigned [mem 0xb8100000-0xb81fffff pref]
[    2.515089] pci 0001:e1:00.0: BAR 1: assigned [mem 0xb8200000-0xb820ffff 64bit]
[    2.523513] pci 0001:e1:00.0: BAR 0: assigned [io  0x10000-0x100ff]
[    2.530749] pci 0001:e0:00.0: PCI bridge to [bus e1]
[    2.536476] pci 0001:e0:00.0:   bridge window [io  0x10000-0x10fff]
[    2.543720] pci 0001:e0:00.0:   bridge window [mem 0xb8000000-0xb82fffff]
[    2.551552] pci 0001:e0:00.0: Max Payload Size set to  512/ 512 (was  128), Max Read Rq  512
[    2.561283] pci 0001:e1:00.0: Max Payload Size set to  512/4096 (was  128), Max Read Rq  512
[    2.571060] ACPI: PCI Root Bridge [PCI2] (domain 0002 [bus 80-9f])
[    2.578184] acpi PNP0A08:02: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    2.587752] acpi PNP0A08:02: _OSC: platform does not support [PCIeHotplug PME AER]
[    2.596595] acpi PNP0A08:02: _OSC: OS now controls [PCIeCapability]
[    2.603816] acpi PNP0A08:02: MCFG quirk: ECAM at [mem 0xa8000000-0xa9ffffff] for [bus 80-9f] with hisi_pcie_ops
[    2.616078] acpi PNP0A08:02: ECAM area [mem 0xa8000000-0xa9ffffff] reserved by HISI0081:02
[    2.625841] acpi PNP0A08:02: ECAM at [mem 0xa8000000-0xa9ffffff] for [bus 80-9f]
[    2.634385] Remapped I/O 0x00000000afff0000 to [io  0x20000-0x2ffff window]
[    2.642469] PCI host bridge to bus 0002:80
[    2.647189] pci_bus 0002:80: root bus resource [mem 0xaa000000-0xaffeffff window]
[    2.655820] pci_bus 0002:80: root bus resource [io  0x20000-0x2ffff window] (bus address [0x0000-0xffff])
[    2.666862] pci_bus 0002:80: root bus resource [bus 80-9f]
[    2.673199] pci 0002:80:00.0: [19e5:1610] type 01 class 0x060400
[    2.673207] pci 0002:80:00.0: reg 0x10: [mem 0x00000000-0x0000ffff]
[    2.673237] pci 0002:80:00.0: supports D1 D2
[    2.673239] pci 0002:80:00.0: PME# supported from D0 D1 D3hot
[    2.673370] pci 0002:81:00.0: [10b5:8725] type 01 class 0x060400
[    2.673381] pci 0002:81:00.0: reg 0x10: [mem 0xaa200000-0xaa23ffff]
[    2.673453] pci 0002:81:00.0: PME# supported from D0 D3hot D3cold
[    2.685262] pci 0002:82:00.0: [10b5:8725] type 01 class 0x060400
[    2.685343] pci 0002:82:00.0: PME# supported from D0 D3hot D3cold
[    2.685444] pci 0002:82:01.0: [10b5:8725] type 01 class 0x060400
[    2.685525] pci 0002:82:01.0: PME# supported from D0 D3hot D3cold
[    2.685619] pci 0002:82:02.0: [10b5:8725] type 01 class 0x060400
[    2.685699] pci 0002:82:02.0: PME# supported from D0 D3hot D3cold
[    2.685800] pci 0002:82:08.0: [10b5:8725] type 01 class 0x060400
[    2.685880] pci 0002:82:08.0: PME# supported from D0 D3hot D3cold
[    2.686094] pci 0002:84:00.0: [19e5:1711] type 00 class 0x030000
[    2.686112] pci 0002:84:00.0: reg 0x10: [mem 0xac000000-0xadffffff pref]
[    2.686122] pci 0002:84:00.0: reg 0x14: [mem 0xaa000000-0xaa1fffff]
[    2.686221] pci 0002:84:00.0: supports D1
[    2.686223] pci 0002:84:00.0: PME# supported from D0 D1 D3hot
[    2.697355] pci 0002:80:00.0: BAR 14: assigned [mem 0xaa000000-0xae7fffff]
[    2.705290] pci 0002:80:00.0: BAR 15: assigned [mem 0xae800000-0xaebfffff 64bit pref]
[    2.714321] pci 0002:80:00.0: BAR 0: assigned [mem 0xaec00000-0xaec0ffff]
[    2.722153] pci 0002:80:00.0: BAR 13: assigned [io  0x20000-0x21fff]
[    2.729469] pci 0002:81:00.0: BAR 14: assigned [mem 0xaa000000-0xadffffff]
[    2.737392] pci 0002:81:00.0: BAR 15: assigned [mem 0xae800000-0xaebfffff 64bit pref]
[    2.746429] pci 0002:81:00.0: BAR 0: assigned [mem 0xae000000-0xae03ffff]
[    2.754264] pci 0002:81:00.0: BAR 13: assigned [io  0x20000-0x21fff]
[    2.761587] pci 0002:82:01.0: BAR 14: assigned [mem 0xaa000000-0xacffffff]
[    2.769512] pci 0002:82:00.0: BAR 14: assigned [mem 0xad000000-0xad1fffff]
[    2.777419] pci 0002:82:00.0: BAR 15: assigned [mem 0xae800000-0xae9fffff 64bit pref]
[    2.786431] pci 0002:82:01.0: BAR 15: assigned [mem 0xaea00000-0xaebfffff 64bit pref]
[    2.795460] pci 0002:82:00.0: BAR 13: assigned [io  0x20000-0x20fff]
[    2.802783] pci 0002:82:01.0: BAR 13: assigned [io  0x21000-0x21fff]
[    2.810091] pci 0002:82:00.0: PCI bridge to [bus 83]
[    2.815813] pci 0002:82:00.0:   bridge window [io  0x20000-0x20fff]
[    2.823022] pci 0002:82:00.0:   bridge window [mem 0xad000000-0xad1fffff]
[    2.830844] pci 0002:82:00.0:   bridge window [mem 0xae800000-0xae9fffff 64bit pref]
[    2.839754] pci 0002:84:00.0: BAR 0: assigned [mem 0xaa000000-0xabffffff pref]
[    2.848074] pci 0002:84:00.0: BAR 1: assigned [mem 0xac000000-0xac1fffff]
[    2.855892] pci 0002:82:01.0: PCI bridge to [bus 84]
[    2.861609] pci 0002:82:01.0:   bridge window [io  0x21000-0x21fff]
[    2.868824] pci 0002:82:01.0:   bridge window [mem 0xaa000000-0xacffffff]
[    2.876641] pci 0002:82:01.0:   bridge window [mem 0xaea00000-0xaebfffff 64bit pref]
[    2.885552] pci 0002:82:02.0: PCI bridge to [bus 85]
[    2.891272] pci 0002:82:08.0: PCI bridge to [bus 86]
[    2.896987] pci 0002:81:00.0: PCI bridge to [bus 82-86]
[    2.903005] pci 0002:81:00.0:   bridge window [io  0x20000-0x21fff]
[    2.910234] pci 0002:81:00.0:   bridge window [mem 0xaa000000-0xadffffff]
[    2.918067] pci 0002:81:00.0:   bridge window [mem 0xae800000-0xaebfffff 64bit pref]
[    2.926998] pci 0002:80:00.0: PCI bridge to [bus 81-86]
[    2.933025] pci 0002:80:00.0:   bridge window [io  0x20000-0x21fff]
[    2.940243] pci 0002:80:00.0:   bridge window [mem 0xaa000000-0xae7fffff]
[    2.948075] pci 0002:80:00.0:   bridge window [mem 0xae800000-0xaebfffff 64bit pref]
[    2.957001] pci 0002:80:00.0: Max Payload Size set to  512/ 512 (was  128), Max Read Rq  512
[    2.966723] pci 0002:81:00.0: Max Payload Size set to  512/1024 (was  128), Max Read Rq  128
[    2.976447] pci 0002:82:00.0: Max Payload Size set to  512/1024 (was  128), Max Read Rq  128
[    2.986191] pci 0002:82:01.0: Max Payload Size set to  512/1024 (was  128), Max Read Rq  128
[    2.995931] pci 0002:84:00.0: Max Payload Size set to  256/ 256 (was  128), Max Read Rq  256
[    3.005655] pci 0002:82:02.0: Max Payload Size set to  512/1024 (was  128), Max Read Rq  128
[    3.015393] pci 0002:82:08.0: Max Payload Size set to  512/1024 (was  128), Max Read Rq  128
[    3.025549] vgaarb: device added: PCI:0002:84:00.0,decodes=io+mem,owns=none,locks=none
[    3.034497] vgaarb: loaded
[    3.037549] vgaarb: bridge control possible 0002:84:00.0
[    3.043694] SCSI subsystem initialized
[    3.048016] libata version 3.00 loaded.
[    3.048093] ACPI: bus type USB registered
[    3.052669] usbcore: registered new interface driver usbfs
[    3.058888] usbcore: registered new interface driver hub
[    3.064941] usbcore: registered new device driver usb
[    3.070764] pps_core: LinuxPPS API ver. 1 registered
[    3.076374] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    3.086699] PTP clock support registered
[    3.091204] Registered efivars operations
[    3.095935] Advanced Linux Sound Architecture Driver Initialized.
[    3.103198] clocksource: Switched to clocksource arch_sys_counter
[    3.110185] VFS: Disk quotas dquot_6.6.0
[    3.114673] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    3.122588] pnp: PnP ACPI init
[    3.126233] system 00:00: [mem 0xa0090000-0xa009ffff] has been reserved
[    3.133740] system 00:00: [mem 0xb0000000-0xb1ffffff] could not be reserved
[    3.141639] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    3.141704] system 00:01: [mem 0xa0200000-0xa020ffff] has been reserved
[    3.149222] system 00:01: [mem 0xbe000000-0xbfffffff] could not be reserved
[    3.157139] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    3.157202] system 00:02: [mem 0xa00a0000-0xa00affff] has been reserved
[    3.164710] system 00:02: [mem 0xa8000000-0xa9ffffff] could not be reserved
[    3.172604] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    3.172612] pnp: PnP ACPI: found 3 devices
[    3.180083] NET: Registered protocol family 2
[    3.185559] TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
[    3.194711] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    3.202681] TCP: Hash tables configured (established 262144 bind 65536)
[    3.210322] UDP hash table entries: 16384 (order: 7, 524288 bytes)
[    3.217564] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes)
[    3.225356] NET: Registered protocol family 1
[    3.230488] RPC: Registered named UNIX socket transport module.
[    3.237217] RPC: Registered udp transport module.
[    3.242565] RPC: Registered tcp transport module.
[    3.247908] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    3.255230] pci 0001:e1:00.0: [Firmware Bug]: VPD access disabled
[    3.262162] PCI: CLS 0 bytes, default 128
[    3.262252] Unpacking initramfs...
[    3.649014] Freeing initrd memory: 27492K (ffff80001e520000 - ffff80001fff9000)
[    3.657578] kvm [1]: 8-bit VMID
[    3.661145] kvm [1]: IDMAP page: 8c6000
[    3.665489] kvm [1]: HYP VA range: 800000000000:ffffffffffff
[    3.672639] kvm [1]: Hyp mode initialized successfully
[    3.678492] kvm [1]: vgic-v2@fe020000
[    3.682672] kvm [1]: GIC system register CPU interface enabled
[    3.689472] kvm [1]: vgic interrupt IRQ1
[    3.693959] kvm [1]: virtual timer IRQ4
[    3.699944] futex hash table entries: 4096 (order: 7, 524288 bytes)
[    3.707148] audit: initializing netlink subsys (disabled)
[    3.713283] audit: type=2000 audit(3.068:1): initialized
[    3.719528] workingset: timestamp_bits=44 max_order=23 bucket_order=0
[    3.730723] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    3.737669] NFS: Registering the id_resolver key type
[    3.743390] Key type id_resolver registered
[    3.748115] Key type id_legacy registered
[    3.752648] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    3.760285] 9p: Installing v9fs 9p2000 file system support
[    3.767646] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
[    3.776005] io scheduler noop registered
[    3.780493] io scheduler cfq registered (default)
[    3.786034] libphy: mdio_driver_register: phy-bcm-ns2-pci
[    3.792498] pcieport 0000:00:00.0: can't derive routing for PCI INT A
[    3.799778] pcieport 0000:00:00.0: PCI INT A: no GSI
[    3.805440] pcieport 0001:e0:00.0: can't derive routing for PCI INT A
[    3.812736] pcieport 0001:e0:00.0: PCI INT A: no GSI
[    3.818379] pcieport 0002:80:00.0: can't derive routing for PCI INT A
[    3.825658] pcieport 0002:80:00.0: PCI INT A: no GSI
[    3.831294] pcieport 0002:80:00.0: can't derive routing for PCI INT A
[    3.838569] pcieport 0002:81:00.0: PCI INT A: no GSI
[    3.844358] pcieport 0002:80:00.0: can't derive routing for PCI INT A
[    3.851639] pcieport 0002:82:00.0: PCI INT A: no GSI
[    3.857395] pcieport 0002:80:00.0: can't derive routing for PCI INT A
[    3.864672] pcieport 0002:82:01.0: PCI INT A: no GSI
[    3.870426] pcieport 0002:80:00.0: can't derive routing for PCI INT A
[    3.877706] pcieport 0002:82:02.0: PCI INT A: no GSI
[    3.883456] pcieport 0002:80:00.0: can't derive routing for PCI INT A
[    3.890735] pcieport 0002:82:08.0: PCI INT A: no GSI
[    3.896709] ipmi message handler version 39.2
[    3.901658] ipmi device interface
[    3.905458] IPMI System Interface driver.
[    3.910064] ipmi_si: probing via SMBIOS
[    3.914404] ipmi_si: SMBIOS: io 0xe4 regsize 1 spacing 1 irq 0
[    3.921008] ipmi_si: Adding SMBIOS-specified bt state machine
[    3.927549] ipmi_si: Trying SMBIOS-specified bt state machine at i/o address 0xe4, slave address 0x0, irq 0
[    3.995245] IPMI BT: using default values
[    3.999783] IPMI BT: req2rsp=5 secs retries=2
[    4.207340] ipmi_si ipmi_si.0: Found new BMC (man_id: 0x0007db, prod_id: 0x0001, dev_id: 0x01)
[    4.217181] ipmi_si ipmi_si.0: IPMI bt interface initialized
[    4.224462] xenfs: not registering filesystem on non-xen platform
[    4.232736] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    4.240519] console [ttyS0] disabled
[    4.265944] serial8250.10: ttyS0 at I/O 0x2f8 (irq = 0, base_baud = 115200) is a 16550A
[    4.275069] console [ttyS0] enabled
[    4.282512] bootconsole [hisilpcuart0] disabled
[    4.292350] SuperH (H)SCI(F) driver initialized
[    4.296951] msm_serial: driver initialized
[    4.301280] Failed to find cpu0 device node
[    4.305463] Unable to detect cache hierarchy from DT for CPU 0
[    4.314331] loop: module loaded
[    4.317688] hisi_sas: driver version v1.6
[    4.455735] scsi host0: hisi_sas
[    4.591730] scsi host1: hisi_sas
[    4.727757] scsi host2: hisi_sas
[    4.732451] libphy: Fixed MDIO Bus: probed
[    4.736690] tun: Universal TUN/TAP device driver, 1.6
[    4.741742] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    4.827207] libphy: Hisilicon MII Bus: probed
[    5.707286] netif_napi_add() called with weight 256 on device eth%d
[    5.803822] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    5.809652] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    5.815603] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
[    5.822548] igb: Copyright (c) 2007-2014 Intel Corporation.
[    5.828140] igbvf: Intel(R) Gigabit Virtual Function Network Driver - version 2.4.0-k
[    5.835950] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    5.841882] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - version 4.4.0-k
[    5.849518] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[    5.855328] sky2: driver version 1.30
[    5.859170] VFIO - User Level meta-driver version: 0.3
[    5.865063] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    5.871579] ehci-pci: EHCI PCI platform driver
[    5.876044] ehci-platform: EHCI generic platform driver
[    5.881310] ehci-platform PNP0D20:00: EHCI Host Controller
[    5.886798] ehci-platform PNP0D20:00: new USB bus registered, assigned bus number 1
[    5.894545] ehci-platform PNP0D20:00: irq 6, io mem 0xa7020000
[    5.915203] ehci-platform PNP0D20:00: USB 2.0 started, EHCI 1.00
[    5.921487] hub 1-0:1.0: USB hub found
[    5.925247] hub 1-0:1.0: 2 ports detected
[    5.929487] ehci-exynos: EHCI EXYNOS driver
[    5.933695] ehci-msm: Qualcomm On-Chip EHCI Host Controller
[    5.939287] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    5.945462] ohci-pci: OHCI PCI platform driver
[    5.949932] ohci-platform: OHCI generic platform driver
[    5.955171] ohci-exynos: OHCI EXYNOS driver
[    5.959468] usbcore: registered new interface driver usb-storage
[    5.965733] mousedev: PS/2 mouse device common for all mice
[    6.097475] rtc-efi rtc-efi: rtc core: registered rtc-efi as rtc0
[    6.103714] i2c /dev entries driver
[    6.107668] sdhci: Secure Digital Host Controller Interface driver
[    6.113839] sdhci: Copyright(c) Pierre Ossman
[    6.118253] Synopsys Designware Multimedia Card Interface Driver
[    6.124326] sdhci-pltfm: SDHCI platform and OF driver helper
[    6.130265] ledtrig-cpu: registered to indicate activity on CPUs
[    6.136571] usbcore: registered new interface driver usbhid
[    6.142149] usbhid: USB HID core driver
[    6.146490] NET: Registered protocol family 17
[    6.150980] 9pnet: Installing 9P2000 support
[    6.155281] Key type dns_resolver registered
[    6.159799] registered taskstats version 1
[    6.227038] rtc-efi rtc-efi: setting system clock to 2016-12-06 11:30:25 UTC (1481023825)
[    6.235251] ALSA device list:
[    6.238219]   No soundcards found.
[    6.242270] Freeing unused kernel memory: 1024K (ffff800000c80000 - ffff800000d80000)
[    6.323209] usb 1-1: new high-speed USB device number 2 using ehci-platform
[    6.475822] hub 1-1:1.0: USB hub found
[    6.479639] hub 1-1:1.0: 4 ports detected
[    6.603202] usb 1-2: new high-speed USB device number 3 using ehci-platform
[    6.755814] hub 1-2:1.0: USB hub found
[    6.759639] hub 1-2:1.0: 4 ports detected
[    7.051201] usb 1-2.1: new full-speed USB device number 4 using ehci-platform
[    7.167848] input: Keyboard/Mouse KVM 1.1.0 as /devices/platform/PNP0D20:00/usb1/1-2/1-2.1/1-2.1:1.0/0003:12D1:0003.0001/input/input0
[    7.239434] hid-generic 0003:12D1:0003.0001: input: USB HID v1.10 Keyboard [Keyboard/Mouse KVM 1.1.0] on usb-PNP0D20:00-2.1/input0
[    7.252437] input: Keyboard/Mouse KVM 1.1.0 as /devices/platform/PNP0D20:00/usb1/1-2/1-2.1/1-2.1:1.1/0003:12D1:0003.0002/input/input1
[    7.264494] hid-generic 0003:12D1:0003.0002: input: USB HID v1.10 Mouse [Keyboard/Mouse KVM 1.1.0] on usb-PNP0D20:00-2.1/input1
root@(none)$ cat /proc/iomem
00000000-00024fff : reserved
00026000-319fffff : System RAM
   00080000-00c7ffff : Kernel code
   00d80000-00ea6fff : Kernel data
31a00000-31a6ffff : reserved
31a70000-31b5ffff : System RAM
31b60000-31b6ffff : reserved
31b70000-31b7dfff : System RAM
31b7e000-31b81fff : reserved
31b82000-39c0ffff : System RAM
39c10000-3a11ffff : reserved
3a120000-3f10ffff : System RAM
3f110000-3f13ffff : reserved
3f140000-3fbfffff : System RAM
603c0000-603cffff : HISI0141:00
   603c0000-603cffff : HISI0141:00
a0080000-a008ffff : HISI0152:02
   a0080000-a008ffff : HISI0152:01
     a0080000-a008ffff : HISI0152:00
a0090000-a009ffff : pnp 00:00
a00a0000-a00affff : pnp 00:02
a01b0000-a01b0fff : HISI0191:00
   a01b0000-a01b0fff : HISI0191:00
a0200000-a020ffff : pnp 00:01
a2000000-a200ffff : HISI0162:01
   a2000000-a200ffff : HISI0162:01
a3000000-a300ffff : HISI0162:02
   a3000000-a300ffff : HISI0162:02
a7020000-a702ffff : PNP0D20:00
   a7020000-a702ffff : PNP0D20:00
a8000000-a9ffffff : PCI ECAM
aa000000-affeffff : PCI Bus 0002:80
   aa000000-ae7fffff : PCI Bus 0002:81
     aa000000-adffffff : PCI Bus 0002:82
       aa000000-acffffff : PCI Bus 0002:84
         aa000000-abffffff : 0002:84:00.0
         ac000000-ac1fffff : 0002:84:00.0
       ad000000-ad1fffff : PCI Bus 0002:83
     ae000000-ae03ffff : 0002:81:00.0
   ae800000-aebfffff : PCI Bus 0002:81
     ae800000-aebfffff : PCI Bus 0002:82
       ae800000-ae9fffff : PCI Bus 0002:83
       aea00000-aebfffff : PCI Bus 0002:84
   aec00000-aec0ffff : 0002:80:00.0
b0000000-b1ffffff : PCI ECAM
b2000000-b7feffff : PCI Bus 0000:00
   b2000000-b200ffff : 0000:00:00.0
b8000000-bdfeffff : PCI Bus 0001:e0
   b8000000-b82fffff : PCI Bus 0001:e1
     b8000000-b80fffff : 0001:e1:00.0
     b8100000-b81fffff : 0001:e1:00.0
     b8200000-b820ffff : 0001:e1:00.0
   b8300000-b831ffff : 0001:e0:00.0
   b8320000-b8320fff : 0001:e0:00.0
be000000-bfffffff : PCI ECAM
c0080000-c008ffff : HISI0152:05
   c0080000-c008ffff : HISI0152:04
     c0080000-c008ffff : HISI0152:03
c3000000-c300ffff : HISI0162:00
   c3000000-c300ffff : HISI0162:00
c4000000-c40fffff : HISI00D1:00
c5000000-c588ffff : HISI00B2:00
   c5000000-c588ffff : HISI00B2:00
c7000000-c705ffff : HISI00B2:00
   c7000000-c705ffff : HISI00B2:00
2040000000-27ffffffff : System RAM

>
> Changes from v10 to v11:
>
> - Discard "consumer" resources from PNP0A03 host bridge windows (arm64
>   only).  This allows using consumer PNP0A03 descriptors (rather than the
>   PNP0C02 workaround used on x86) for bridge register space.
>
> - Add APM X-Gene MCFG quirks.
>
> - If ACPI and quirks are enabled, always build ThunderX, X-Gene, and
>   HiSilicon drivers on ARM64.  Add internal ifdefs so we only compile the
>   parts necessary for ACPI (the ECAM init and accessors).
>
> - s/node/seg/ in ThunderX MCFG quirk macros.
>
> - Move ECAM check for ACPI device reservation from pci_ecam_create() to
>   that arm64-specific pci_acpi_setup_ecam_mapping().
>
> - Add local "struct device *dev" pointers for brevity.
>
> - Miscellaneous build fixes.
>
> ---
>
> Bjorn Helgaas (6):
>       ACPI: Add acpi_resource_consumer() to find device that claims a resource
>       x86/PCI: Use acpi_resource_consumer() to search ACPI namespace for MMCFG
>       arm64: PCI: Add local struct device pointers
>       arm64: PCI: Search ACPI namespace to ensure ECAM space is reserved
>       arm64: PCI: Exclude ACPI "consumer" resources from host bridge windows
>       PCI: thunder-pem: Factor out resource lookup
>
> Christopher Covington (1):
>       PCI: Add MCFG quirks for Qualcomm QDF2432 host controller
>
> Dongdong Liu (2):
>       PCI/ACPI: Provide acpi_get_rc_resources() for ARM64 platform
>       PCI: Add MCFG quirks for HiSilicon Hip05/06/07 host controllers
>
> Duc Dang (1):
>       PCI: Add MCFG quirks for X-Gene host controller
>
> Tomasz Nowicki (5):
>       arm64: PCI: Manage controller-specific data on per-controller basis
>       PCI/ACPI: Extend pci_mcfg_lookup() to return ECAM config accessors
>       PCI/ACPI: Check for platform-specific MCFG quirks
>       PCI: Add MCFG quirks for Cavium ThunderX pass2.x host controller
>       PCI: Add MCFG quirks for Cavium ThunderX pass1.x host controller
>
>
>  arch/arm64/kernel/pci.c             |   68 ++++++++-----
>  arch/x86/pci/mmconfig-shared.c      |   69 ++-----------
>  drivers/acpi/pci_mcfg.c             |  190 ++++++++++++++++++++++++++++++++++-
>  drivers/acpi/resource.c             |   57 +++++++++++
>  drivers/pci/ecam.c                  |   12 ++
>  drivers/pci/host/Kconfig            |   10 +-
>  drivers/pci/host/Makefile           |    8 +
>  drivers/pci/host/pci-thunder-ecam.c |    9 +-
>  drivers/pci/host/pci-thunder-pem.c  |   94 +++++++++++++----
>  drivers/pci/host/pci-xgene.c        |  126 ++++++++++++++++++++++-
>  drivers/pci/host/pcie-hisi.c        |  101 +++++++++++++++++++
>  drivers/pci/pci-acpi.c              |   76 ++++++++++++++
>  drivers/pci/pci.h                   |    5 +
>  include/linux/acpi.h                |    7 +
>  include/linux/pci-acpi.h            |    4 +
>  include/linux/pci-ecam.h            |    9 ++
>  16 files changed, 718 insertions(+), 127 deletions(-)
>
> .
>
