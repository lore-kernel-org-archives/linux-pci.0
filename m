Return-Path: <SRS0=KiYe=XR=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=KiYe=XR=huawei.com=liudongdong3@kernel.org>
Subject: Re: [PATCH v10 00/12] PCI: ARM64 ECAM quirks
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20161201075131.12247.2211.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <d3f1a4ca-99e6-f0a5-d20b-d2753058d93d@huawei.com>
 <8f4a67d4-549a-34e9-8ef7-ec99961d60e5@huawei.com>
 <20161201163105.GB19681@bhelgaas-glaptop.roam.corp.google.com>
CC: <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi
	<lorenzo.pieralisi@arm.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tomasz Nowicki <tn@semihalf.com>, Duc Dang <dhdang@apm.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        "Christopher
 Covington" <cov@codeaurora.org>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <42eec2b2-6ced-25a1-95d3-3b22e3b71bec@huawei.com>
Date: Fri, 2 Dec 2016 11:46:21 +0800
MIME-Version: 1.0
In-Reply-To: <20161201163105.GB19681@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn

在 2016/12/2 0:31, Bjorn Helgaas 写道:
> On Thu, Dec 01, 2016 at 10:04:48PM +0800, Dongdong Liu wrote:
>> ...
>> Aftet fixing the compile errors. I tested on HiSilicon D03 board. It works ok.
>> The dmesg is as below
>
> Thanks very much for testing this!  A few comments below.
>
>> root@(none)$ dmesg
>> [    0.000000] Booting Linux on physical CPU 0x10000
>> [    0.000000] Linux version 4.9.0-rc1-gaf05ef2-dirty (l00290354@linux-ioko) (gcc version 4.9.3 20150211 (prerelease) (20150316) ) #257 SMP PREEMPT Thu Dec 1 22:13:05 CST 2016
>> [    0.000000] Boot CPU: AArch64 Processor [411fd071]
>> [    0.000000] earlycon: hisilpcuart0 at MMIO 0x00000000a01b0000 (options '0,0x2f8')
>> [    0.000000] bootconsole [hisilpcuart0] enabled
>> [    0.000000] efi: Getting EFI parameters from FDT:
>> [    0.000000] efi: EFI v2.60 by EDK II
>> [    0.000000] efi:  SMBIOS=0x3f110000  SMBIOS 3.0=0x39ce0000  ACPI=0x39db0000  ACPI 2.0=0x39db0014  MEMATTR=0x3c945018
>
> On x86 we normally have info about the machine and BIOS, e.g.,
>
>   DMI: LENOVO 20FCS12V03/20FCS12V03, BIOS N1FET40W (1.14 ) 04/18/2016
>
> I think this comes from dmi_present(), and it looks like we should
> call that via arm64_dmi_init().  Any idea why we don't see that info?
> Is it just missing from the SMBIOS table?  I think it's useful to
> have for debugging problems.

I need to ask my colleagues about this, then reply.

>
>> [    2.109466] ACPI: MCFG table detected, 3 entries
>> [    2.132280] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-1f])
>> [    2.139416] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig Segments MSI]
>> [    2.147563] acpi PNP0A08:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
>
> Per the PCI Firmware spec, r3.2, sec 4.5.1, _OSC is required for host
> bridges that originate PCIe hierarchies.  So the lack of one here
> looks like a firmware defect.
Thanks for pointing out this. will fix this in UEFI.
>
>> [    2.155225] acpi PNP0A08:00: MCFG quirk: ECAM at [mem 0xb0000000-0xb1ffffff] for [bus 00-1f] with hisi_pcie_ops
>> [    2.167558] acpi PNP0A08:00: [Firmware Bug]: ECAM area [mem 0xb0000000-0xb1ffffff] not reserved in ACPI namespace
>
> This is what I expected.  Apparently your DSDT doesn't contain a
> PNP0C02 device that reserves the ECAM space, so we warn about it.  I
> expect that if you look at /proc/iomem, we should still see the
> reservation done by pci_ecam_create().
>
>> [    2.179629] acpi PNP0A08:00: ECAM at [mem 0xb0000000-0xb1ffffff] for [bus 00-1f]
>
>> [    2.297714] ACPI: PCI Root Bridge [PCI1] (domain 0001 [bus e0-ff])
>> [    2.320388] acpi PNP0A08:01: MCFG quirk: ECAM at [mem 0xbe000000-0xbfffffff] for [bus e0-ff] with hisi_pcie_ops
>> [    2.332547] acpi PNP0A08:01: [Firmware Bug]: ECAM area [mem 0xbe000000-0xbfffffff] not reserved in ACPI namespace
>> [    2.344507] acpi PNP0A08:01: ECAM at [mem 0xbe000000-0xbfffffff] for [bus e0-ff]
>
>> [    2.494568] ACPI: PCI Root Bridge [PCI2] (domain 0002 [bus 80-9f])
>> [    2.517222] acpi PNP0A08:02: MCFG quirk: ECAM at [mem 0xa8000000-0xa9ffffff] for [bus 80-9f] with hisi_pcie_ops
>> [    2.529349] acpi PNP0A08:02: [Firmware Bug]: ECAM area [mem 0xa8000000-0xa9ffffff] not reserved in ACPI namespace
>> [    2.541330] acpi PNP0A08:02: ECAM at [mem 0xa8000000-0xa9ffffff] for [bus 80-9f]
>
>> [    3.015076] system 00:00: [mem 0xa0090000-0xa009ffff] has been reserved
>> [    3.022595] system 00:00: [mem 0xb0000000-0xb01fffff] could not be reserved
>> [    3.030505] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
>
> Huh.  This PNP0C02 device reserves *part* of the PNP0A08:00 ECAM
> space, but not all of it.  Is this just a typo in the PNP0C02 _CRS,
> i.e., somebody wrote a size of "0x001fffff" instead of "0x01ffffff"?

Good catch, will fix this in UEFI.

>
>> [    3.030567] system 00:01: [mem 0xa0200000-0xa020ffff] has been reserved
>> [    3.038058] system 00:01: [mem 0xbe000000-0xbe1fffff] could not be reserved
>> [    3.045967] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
>
> Same here?  This reserves part of the PNP0A08:01 ECAM space.
will fix this in UEFI.
>
>> [    3.046031] system 00:02: [mem 0xa00a0000-0xa00affff] has been reserved
>> [    3.053529] system 00:02: [mem 0xa8000000-0xa81fffff] could not be reserved
>> [    3.061424] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
>
> And here for PNP0A08:02?
will fix this in UEFI.
>
>> [    3.681559] pcieport 0000:00:00.0: can't derive routing for PCI INT A
>> [    3.688840] pcieport 0000:00:00.0: PCI INT A: no GSI
>
> Is something wrong with your _PRT?

Yes, we have not added _PRT in our PCI DSDT Table. Our platform can not use _PRT
to describle the INTX interrupts. we will send a RFC PATCH to discuss this.

>
>> [    3.694505] pcieport 0001:e0:00.0: can't derive routing for PCI INT A
>> [    3.701786] pcieport 0001:e0:00.0: PCI INT A: no GSI
>> [    3.707428] pcieport 0002:80:00.0: can't derive routing for PCI INT A
>> [    3.714707] pcieport 0002:80:00.0: PCI INT A: no GSI
>> [    3.720344] pcieport 0002:80:00.0: can't derive routing for PCI INT A
>> [    3.727624] pcieport 0002:81:00.0: PCI INT A: no GSI
>> [    3.733413] pcieport 0002:80:00.0: can't derive routing for PCI INT A
>> [    3.740694] pcieport 0002:82:00.0: PCI INT A: no GSI
>> [    3.746451] pcieport 0002:80:00.0: can't derive routing for PCI INT A
>> [    3.753735] pcieport 0002:82:01.0: PCI INT A: no GSI
>> [    3.759489] pcieport 0002:80:00.0: can't derive routing for PCI INT A
>> [    3.766772] pcieport 0002:82:02.0: PCI INT A: no GSI
>> [    3.772524] pcieport 0002:80:00.0: can't derive routing for PCI INT A
>> [    3.779807] pcieport 0002:82:08.0: PCI INT A: no GSI
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> .
>

After fix the length of the reserve resource in _CRS and add _OSC in UEFI, the new dmesg and /proc/iomem are as below.

root@(none)$ dmesg
[    0.000000] Booting Linux on physical CPU 0x10000
[    0.000000] Linux version 4.9.0-rc1-gaf05ef2-dirty (l00290354@linux-ioko) (gcc version 4.9.3 20150211 (prerelease) (20150316) ) #257 SMP PREEMPT Thu Dec 1 22:13:05 CST 2016
[    0.000000] Boot CPU: AArch64 Processor [411fd071]
[    0.000000] earlycon: hisilpcuart0 at MMIO 0x00000000a01b0000 (options '0,0x2f8')
[    0.000000] bootconsole [hisilpcuart0] enabled
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: EFI v2.60 by EDK II
[    0.000000] efi:  SMBIOS=0x3f110000  SMBIOS 3.0=0x39ce0000  ACPI=0x39db0000  ACPI 2.0=0x39db0014  MEMATTR=0x3ca44018
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
[    0.000000] NUMA: Adding memblock [0x25800 - 0x31a0ffff] on node 0
[    0.000000] NUMA: Adding memblock [0x31a10000 - 0x31a7ffff] on node 0
[    0.000000] NUMA: Adding memblock [0x31a80000 - 0x31b5ffff] on node 0
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
[    0.000000]   node   0: [mem 0x0000000000026000-0x0000000031a0ffff]
[    0.000000]   node   0: [mem 0x0000000031a10000-0x0000000031a7ffff]
[    0.000000]   node   0: [mem 0x0000000031a80000-0x0000000031b5ffff]
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
[    0.000000] Kernel command line: earlycon=hisilpcuart,mmio,0xa01b0000,0,0x2f8 console=ttyS0,115200 initrd=filesystem.cpio.gz acpi=force pcie_aspm=off pci=pcie_bus_perf
[    0.000000] PCIe ASPM is disabled
[    0.000000] log_buf_len individual max cpu contribution: 4096 bytes
[    0.000000] log_buf_len total cpu_extra contributions: 61440 bytes
[    0.000000] log_buf_len min size: 16384 bytes
[    0.000000] log_buf_len: 131072 bytes
[    0.000000] early log buf free: 10700(65%)
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] software IO TLB [mem 0x35c10000-0x39c10000] (64MB) mapped at [ffff800035c10000-ffff800039c0ffff]
[    0.000000] Memory: 32894040K/33550332K available (8380K kernel code, 864K rwdata, 3680K rodata, 1024K init, 286K bss, 639908K reserved, 16384K cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     modules : 0xffff000000000000 - 0xffff000008000000   (   128 MB)
[    0.000000]     vmalloc : 0xffff000008000000 - 0xffff7dffbfff0000   (129022 GB)
[    0.000000]       .text : 0xffff000008080000 - 0xffff0000088b0000   (  8384 KB)
[    0.000000]     .rodata : 0xffff0000088b0000 - 0xffff000008c50000   (  3712 KB)
[    0.000000]       .init : 0xffff000008c50000 - 0xffff000008d50000   (  1024 KB)
[    0.000000]       .data : 0xffff000008d50000 - 0xffff000008e28200   (   865 KB)
[    0.000000]        .bss : 0xffff000008e28200 - 0xffff000008e6fdc0   (   287 KB)
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
[    0.000002] sched_clock: 56 bits at 50MHz, resolution 20ns, wraps every 4398046511100ns
[    0.009146] Console: colour dummy device 80x25
[    0.014187] Calibrating delay loop (skipped), value calculated using timer frequency.. 100.00 BogoMIPS (lpj=200000)
[    0.025977] pid_max: default: 32768 minimum: 301
[    0.031217] ACPI: Core revision 20160831
[    0.036750] ACPI: 1 ACPI AML tables successfully acquired and loaded

[    0.045688] Security Framework initialized
[    0.054722] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes)
[    0.075995] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    0.089710] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.097589] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.106741] ASID allocator initialised with 65536 entries
[    0.144929] PCI/MSI: ITS@0xc6000000 domain created
[    0.150379] Platform MSI: ITS@0xc6000000 domain created
[    0.156364] Remapping and enabling EFI services.
[    0.161601]   EFI remap 0x0000000031a10000 => 0000000020000000
[    0.168193]   EFI remap 0x0000000031b60000 => 0000000020070000
[    0.174784]   EFI remap 0x0000000039c10000 => 0000000020080000
[    0.181378]   EFI remap 0x0000000039c50000 => 00000000200c0000
[    0.187969]   EFI remap 0x0000000039cd0000 => 00000000200d0000
[    0.194562]   EFI remap 0x0000000039d50000 => 0000000020150000
[    0.201154]   EFI remap 0x0000000039dc0000 => 00000000201a0000
[    0.207749]   EFI remap 0x0000000039e10000 => 00000000201f0000
[    0.214340]   EFI remap 0x0000000039f20000 => 0000000020300000
[    0.220934]   EFI remap 0x0000000039f90000 => 0000000020370000
[    0.227530]   EFI remap 0x0000000039fe0000 => 00000000203c0000
[    0.234121]   EFI remap 0x000000003a030000 => 0000000020410000
[    0.240713]   EFI remap 0x000000003a080000 => 0000000020460000
[    0.247306]   EFI remap 0x000000003a0d0000 => 00000000204b0000
[    0.253897]   EFI remap 0x000000003f110000 => 0000000020500000
[    0.260490]   EFI remap 0x0000000078000000 => 0000000020530000
[    0.267082]   EFI remap 0x00000000a4000000 => 0000000020600000
[    0.273707]   EFI remap 0x00000000a6000000 => 0000000021600000
[    0.280299]   EFI remap 0x00000000d00e0000 => 0000000021610000
[    0.387360] Detected PIPT I-cache on CPU1
[    0.387375] GICv3: CPU1: found redistributor 10001 region 1:0x000000004d130000
[    0.387405] CPU1: using LPI pending table @0x00000027dc300000
[    0.387420] CPU1: Booted secondary processor [411fd071]
[    0.468061] Detected PIPT I-cache on CPU2
[    0.468069] GICv3: CPU2: found redistributor 10002 region 2:0x000000004d160000
[    0.468098] CPU2: using LPI pending table @0x00000027dc330000
[    0.468109] CPU2: Booted secondary processor [411fd071]
[    0.548781] Detected PIPT I-cache on CPU3
[    0.548789] GICv3: CPU3: found redistributor 10003 region 3:0x000000004d190000
[    0.548819] CPU3: using LPI pending table @0x00000027dc370000
[    0.548830] CPU3: Booted secondary processor [411fd071]
[    0.629484] Detected PIPT I-cache on CPU4
[    0.629496] GICv3: CPU4: found redistributor 10100 region 4:0x000000004d1c0000
[    0.629527] CPU4: using LPI pending table @0x00000027dc3a0000
[    0.629540] CPU4: Booted secondary processor [411fd071]
[    0.710225] Detected PIPT I-cache on CPU5
[    0.710233] GICv3: CPU5: found redistributor 10101 region 5:0x000000004d1f0000
[    0.710262] CPU5: using LPI pending table @0x00000027dc3d0000
[    0.710272] CPU5: Booted secondary processor [411fd071]
[    0.790947] Detected PIPT I-cache on CPU6
[    0.790954] GICv3: CPU6: found redistributor 10102 region 6:0x000000004d220000
[    0.790984] CPU6: using LPI pending table @0x00000027dbc20000
[    0.790995] CPU6: Booted secondary processor [411fd071]
[    0.871682] Detected PIPT I-cache on CPU7
[    0.871690] GICv3: CPU7: found redistributor 10103 region 7:0x000000004d250000
[    0.871719] CPU7: using LPI pending table @0x00000027dbc50000
[    0.871729] CPU7: Booted secondary processor [411fd071]
[    0.952477] Detected PIPT I-cache on CPU8
[    0.952490] GICv3: CPU8: found redistributor 10200 region 8:0x000000004d280000
[    0.952521] CPU8: using LPI pending table @0x00000027dbc80000
[    0.952535] CPU8: Booted secondary processor [411fd071]
[    1.033196] Detected PIPT I-cache on CPU9
[    1.033204] GICv3: CPU9: found redistributor 10201 region 9:0x000000004d2b0000
[    1.033234] CPU9: using LPI pending table @0x00000027dbcc0000
[    1.033244] CPU9: Booted secondary processor [411fd071]
[    1.113941] Detected PIPT I-cache on CPU10
[    1.113949] GICv3: CPU10: found redistributor 10202 region 10:0x000000004d2e0000
[    1.113979] CPU10: using LPI pending table @0x00000027dbcf0000
[    1.113989] CPU10: Booted secondary processor [411fd071]
[    1.194654] Detected PIPT I-cache on CPU11
[    1.194663] GICv3: CPU11: found redistributor 10203 region 11:0x000000004d310000
[    1.194692] CPU11: using LPI pending table @0x00000027dbd30000
[    1.194702] CPU11: Booted secondary processor [411fd071]
[    1.275406] Detected PIPT I-cache on CPU12
[    1.275420] GICv3: CPU12: found redistributor 10300 region 12:0x000000004d340000
[    1.275451] CPU12: using LPI pending table @0x00000027dbd60000
[    1.275464] CPU12: Booted secondary processor [411fd071]
[    1.356145] Detected PIPT I-cache on CPU13
[    1.356154] GICv3: CPU13: found redistributor 10301 region 13:0x000000004d370000
[    1.356184] CPU13: using LPI pending table @0x00000027dbdb0000
[    1.356193] CPU13: Booted secondary processor [411fd071]
[    1.436861] Detected PIPT I-cache on CPU14
[    1.436870] GICv3: CPU14: found redistributor 10302 region 14:0x000000004d3a0000
[    1.436899] CPU14: using LPI pending table @0x00000027dbde0000
[    1.436910] CPU14: Booted secondary processor [411fd071]
[    1.517556] Detected PIPT I-cache on CPU15
[    1.517565] GICv3: CPU15: found redistributor 10303 region 15:0x000000004d3d0000
[    1.517595] CPU15: using LPI pending table @0x00000027dbe10000
[    1.517605] CPU15: Booted secondary processor [411fd071]
[    1.517645] Brought up 16 CPUs
[    1.902431] SMP: Total of 16 processors activated.
[    1.907882] CPU features: detected feature: GIC system register CPU interface
[    1.915997] CPU features: detected feature: 32-bit EL0 Support
[    1.922681] CPU: All CPU(s) started at EL2
[    1.927341] alternatives: patching kernel code
[    1.937312] devtmpfs: initialized
[    1.941430] SMBIOS 3.0.0 present.
[    1.945313] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    1.956636] pinctrl core: initialized pinctrl subsystem
[    1.963030] NET: Registered protocol family 16
[    1.989072] cpuidle: using governor menu
[    1.993660] vdso: 2 pages (1 code @ ffff0000088b7000, 1 data @ ffff000008d54000)
[    2.002215] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    2.010555] DMA: preallocated 256 KiB pool for atomic allocations
[    2.017674] ACPI: bus type PCI registered
[    2.022352] Serial: AMBA PL011 UART driver
[    2.055313] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    2.063178] ACPI: Added _OSI(Module Device)
[    2.067949] ACPI: Added _OSI(Processor Device)
[    2.072994] ACPI: Added _OSI(3.0 _SCP Extensions)
[    2.078330] ACPI: Added _OSI(Processor Aggregator Device)
[    2.086411] ACPI: Interpreter enabled
[    2.090590] ACPI: Using GIC for interrupt routing
[    2.095976] ACPI: MCFG table detected, 3 entries
[    2.118730] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-1f])
[    2.125783] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig Segments MSI]
[    2.133904] acpi PNP0A08:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
[    2.145015] acpi PNP0A08:00: MCFG quirk: ECAM at [mem 0xb0000000-0xb1ffffff] for [bus 00-1f] with hisi_pcie_ops
[    2.157151] acpi PNP0A08:00: ECAM area [mem 0xb0000000-0xb1ffffff] reserved by HISI0081:00
[    2.166792] acpi PNP0A08:00: ECAM at [mem 0xb0000000-0xb1ffffff] for [bus 00-1f]
[    2.175253] Remapped I/O 0x00000000b7ff0000 to [io  0x0000-0xffff window]
[    2.183158] PCI host bridge to bus 0000:00
[    2.187889] pci_bus 0000:00: root bus resource [mem 0xb2000000-0xb7feffff window]
[    2.196523] pci_bus 0000:00: root bus resource [io  0x0000-0xffff window]
[    2.204362] pci_bus 0000:00: root bus resource [bus 00-1f]
[    2.210690] pci 0000:00:00.0: [19e5:1610] type 01 class 0x060400
[    2.210700] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x0000ffff]
[    2.210738] pci 0000:00:00.0: supports D1 D2
[    2.210741] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
[    2.262093] pci 0000:00:00.0: BAR 0: assigned [mem 0xb2000000-0xb200ffff]
[    2.269936] pci 0000:00:00.0: PCI bridge to [bus 01]
[    2.275655] pci 0000:00:00.0: Max Payload Size set to  512/ 512 (was  128), Max Read Rq  512
[    2.285430] ACPI: PCI Root Bridge [PCI1] (domain 0001 [bus e0-ff])
[    2.292570] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig Segments MSI]
[    2.300775] acpi PNP0A08:01: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
[    2.312037] acpi PNP0A08:01: MCFG quirk: ECAM at [mem 0xbe000000-0xbfffffff] for [bus e0-ff] with hisi_pcie_ops
[    2.324304] acpi PNP0A08:01: ECAM area [mem 0xbe000000-0xbfffffff] reserved by HISI0081:01
[    2.334076] acpi PNP0A08:01: ECAM at [mem 0xbe000000-0xbfffffff] for [bus e0-ff]
[    2.342631] Remapped I/O 0x00000000bdff0000 to [io  0x10000-0x1ffff window]
[    2.350737] PCI host bridge to bus 0001:e0
[    2.355457] pci_bus 0001:e0: root bus resource [mem 0xb8000000-0xbdfeffff window]
[    2.364093] pci_bus 0001:e0: root bus resource [io  0x10000-0x1ffff window] (bus address [0x0000-0xffff])
[    2.375126] pci_bus 0001:e0: root bus resource [bus e0-ff]
[    2.381456] pci 0001:e0:00.0: [19e5:1610] type 01 class 0x060400
[    2.381464] pci 0001:e0:00.0: reg 0x10: [mem 0x00000000-0x00000fff]
[    2.381471] pci 0001:e0:00.0: reg 0x38: [mem 0xfffe0000-0xffffffff pref]
[    2.381498] pci 0001:e0:00.0: supports D1 D2
[    2.381500] pci 0001:e0:00.0: PME# supported from D0 D1 D3hot
[    2.381627] pci 0001:e1:00.0: [1000:005d] type 00 class 0x010400
[    2.381636] pci 0001:e1:00.0: reg 0x10: [io  0x10000-0x100ff]
[    2.381643] pci 0001:e1:00.0: reg 0x14: [mem 0xb8100000-0xb810ffff 64bit]
[    2.381650] pci 0001:e1:00.0: reg 0x1c: [mem 0xb8000000-0xb80fffff 64bit]
[    2.381658] pci 0001:e1:00.0: reg 0x30: [mem 0xfff00000-0xffffffff pref]
[    2.381707] pci 0001:e1:00.0: supports D1 D2
[    2.381787] pci 0001:e0:00.0: BAR 14: assigned [mem 0xb8000000-0xb82fffff]
[    2.389710] pci 0001:e0:00.0: BAR 6: assigned [mem 0xb8300000-0xb831ffff pref]
[    2.398049] pci 0001:e0:00.0: BAR 0: assigned [mem 0xb8320000-0xb8320fff]
[    2.405886] pci 0001:e0:00.0: BAR 13: assigned [io  0x10000-0x10fff]
[    2.413222] pci 0001:e1:00.0: BAR 3: assigned [mem 0xb8000000-0xb80fffff 64bit]
[    2.421646] pci 0001:e1:00.0: BAR 6: assigned [mem 0xb8100000-0xb81fffff pref]
[    2.429974] pci 0001:e1:00.0: BAR 1: assigned [mem 0xb8200000-0xb820ffff 64bit]
[    2.438421] pci 0001:e1:00.0: BAR 0: assigned [io  0x10000-0x100ff]
[    2.445651] pci 0001:e0:00.0: PCI bridge to [bus e1]
[    2.451370] pci 0001:e0:00.0:   bridge window [io  0x10000-0x10fff]
[    2.458610] pci 0001:e0:00.0:   bridge window [mem 0xb8000000-0xb82fffff]
[    2.466436] pci 0001:e0:00.0: Max Payload Size set to  512/ 512 (was  128), Max Read Rq  512
[    2.476176] pci 0001:e1:00.0: Max Payload Size set to  512/4096 (was  128), Max Read Rq  512
[    2.485944] ACPI: PCI Root Bridge [PCI2] (domain 0002 [bus 80-9f])
[    2.493080] acpi PNP0A08:02: _OSC: OS supports [ExtendedConfig Segments MSI]
[    2.501290] acpi PNP0A08:02: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
[    2.512537] acpi PNP0A08:02: MCFG quirk: ECAM at [mem 0xa8000000-0xa9ffffff] for [bus 80-9f] with hisi_pcie_ops
[    2.524803] acpi PNP0A08:02: ECAM area [mem 0xa8000000-0xa9ffffff] reserved by HISI0081:02
[    2.534585] acpi PNP0A08:02: ECAM at [mem 0xa8000000-0xa9ffffff] for [bus 80-9f]
[    2.543138] Remapped I/O 0x00000000afff0000 to [io  0x20000-0x2ffff window]
[    2.551225] PCI host bridge to bus 0002:80
[    2.555948] pci_bus 0002:80: root bus resource [mem 0xaa000000-0xaffeffff window]
[    2.564593] pci_bus 0002:80: root bus resource [io  0x20000-0x2ffff window] (bus address [0x0000-0xffff])
[    2.575642] pci_bus 0002:80: root bus resource [bus 80-9f]
[    2.581986] pci 0002:80:00.0: [19e5:1610] type 01 class 0x060400
[    2.581993] pci 0002:80:00.0: reg 0x10: [mem 0x00000000-0x0000ffff]
[    2.582023] pci 0002:80:00.0: supports D1 D2
[    2.582025] pci 0002:80:00.0: PME# supported from D0 D1 D3hot
[    2.582152] pci 0002:81:00.0: [10b5:8725] type 01 class 0x060400
[    2.582162] pci 0002:81:00.0: reg 0x10: [mem 0xaa200000-0xaa23ffff]
[    2.582234] pci 0002:81:00.0: PME# supported from D0 D3hot D3cold
[    2.582381] pci 0002:82:00.0: [10b5:8725] type 01 class 0x060400
[    2.582462] pci 0002:82:00.0: PME# supported from D0 D3hot D3cold
[    2.582560] pci 0002:82:01.0: [10b5:8725] type 01 class 0x060400
[    2.582640] pci 0002:82:01.0: PME# supported from D0 D3hot D3cold
[    2.582735] pci 0002:82:02.0: [10b5:8725] type 01 class 0x060400
[    2.582816] pci 0002:82:02.0: PME# supported from D0 D3hot D3cold
[    2.582914] pci 0002:82:08.0: [10b5:8725] type 01 class 0x060400
[    2.582995] pci 0002:82:08.0: PME# supported from D0 D3hot D3cold
[    2.583207] pci 0002:84:00.0: [19e5:1711] type 00 class 0x030000
[    2.583225] pci 0002:84:00.0: reg 0x10: [mem 0xac000000-0xadffffff pref]
[    2.583235] pci 0002:84:00.0: reg 0x14: [mem 0xaa000000-0xaa1fffff]
[    2.583335] pci 0002:84:00.0: supports D1
[    2.583336] pci 0002:84:00.0: PME# supported from D0 D1 D3hot
[    2.583560] pci 0002:80:00.0: BAR 14: assigned [mem 0xaa000000-0xae7fffff]
[    2.591498] pci 0002:80:00.0: BAR 15: assigned [mem 0xae800000-0xaebfffff 64bit pref]
[    2.600547] pci 0002:80:00.0: BAR 0: assigned [mem 0xaec00000-0xaec0ffff]
[    2.608375] pci 0002:80:00.0: BAR 13: assigned [io  0x20000-0x21fff]
[    2.615720] pci 0002:81:00.0: BAR 14: assigned [mem 0xaa000000-0xadffffff]
[    2.623640] pci 0002:81:00.0: BAR 15: assigned [mem 0xae800000-0xaebfffff 64bit pref]
[    2.632677] pci 0002:81:00.0: BAR 0: assigned [mem 0xae000000-0xae03ffff]
[    2.640507] pci 0002:81:00.0: BAR 13: assigned [io  0x20000-0x21fff]
[    2.647831] pci 0002:82:01.0: BAR 14: assigned [mem 0xaa000000-0xacffffff]
[    2.655751] pci 0002:82:00.0: BAR 14: assigned [mem 0xad000000-0xad1fffff]
[    2.663674] pci 0002:82:00.0: BAR 15: assigned [mem 0xae800000-0xae9fffff 64bit pref]
[    2.672702] pci 0002:82:01.0: BAR 15: assigned [mem 0xaea00000-0xaebfffff 64bit pref]
[    2.681724] pci 0002:82:00.0: BAR 13: assigned [io  0x20000-0x20fff]
[    2.689049] pci 0002:82:01.0: BAR 13: assigned [io  0x21000-0x21fff]
[    2.696372] pci 0002:82:00.0: PCI bridge to [bus 83]
[    2.702087] pci 0002:82:00.0:   bridge window [io  0x20000-0x20fff]
[    2.709295] pci 0002:82:00.0:   bridge window [mem 0xad000000-0xad1fffff]
[    2.717105] pci 0002:82:00.0:   bridge window [mem 0xae800000-0xae9fffff 64bit pref]
[    2.726030] pci 0002:84:00.0: BAR 0: assigned [mem 0xaa000000-0xabffffff pref]
[    2.734349] pci 0002:84:00.0: BAR 1: assigned [mem 0xac000000-0xac1fffff]
[    2.742173] pci 0002:82:01.0: PCI bridge to [bus 84]
[    2.747897] pci 0002:82:01.0:   bridge window [io  0x21000-0x21fff]
[    2.755111] pci 0002:82:01.0:   bridge window [mem 0xaa000000-0xacffffff]
[    2.762937] pci 0002:82:01.0:   bridge window [mem 0xaea00000-0xaebfffff 64bit pref]
[    2.771850] pci 0002:82:02.0: PCI bridge to [bus 85]
[    2.777572] pci 0002:82:08.0: PCI bridge to [bus 86]
[    2.783296] pci 0002:81:00.0: PCI bridge to [bus 82-86]
[    2.789316] pci 0002:81:00.0:   bridge window [io  0x20000-0x21fff]
[    2.796539] pci 0002:81:00.0:   bridge window [mem 0xaa000000-0xadffffff]
[    2.804365] pci 0002:81:00.0:   bridge window [mem 0xae800000-0xaebfffff 64bit pref]
[    2.813297] pci 0002:80:00.0: PCI bridge to [bus 81-86]
[    2.819315] pci 0002:80:00.0:   bridge window [io  0x20000-0x21fff]
[    2.826557] pci 0002:80:00.0:   bridge window [mem 0xaa000000-0xae7fffff]
[    2.834388] pci 0002:80:00.0:   bridge window [mem 0xae800000-0xaebfffff 64bit pref]
[    2.843323] pci 0002:80:00.0: Max Payload Size set to  512/ 512 (was  128), Max Read Rq  512
[    2.853060] pci 0002:81:00.0: Max Payload Size set to  512/1024 (was  128), Max Read Rq  128
[    2.862794] pci 0002:82:00.0: Max Payload Size set to  512/1024 (was  128), Max Read Rq  128
[    2.872514] pci 0002:82:01.0: Max Payload Size set to  512/1024 (was  128), Max Read Rq  128
[    2.882246] pci 0002:84:00.0: Max Payload Size set to  256/ 256 (was  128), Max Read Rq  256
[    2.891970] pci 0002:82:02.0: Max Payload Size set to  512/1024 (was  128), Max Read Rq  128
[    2.901703] pci 0002:82:08.0: Max Payload Size set to  512/1024 (was  128), Max Read Rq  128
[    2.911870] vgaarb: device added: PCI:0002:84:00.0,decodes=io+mem,owns=none,locks=none
[    2.920840] vgaarb: loaded
[    2.923904] vgaarb: bridge control possible 0002:84:00.0
[    2.930049] SCSI subsystem initialized
[    2.934393] libata version 3.00 loaded.
[    2.934467] ACPI: bus type USB registered
[    2.939057] usbcore: registered new interface driver usbfs
[    2.945280] usbcore: registered new interface driver hub
[    2.951340] usbcore: registered new device driver usb
[    2.957162] pps_core: LinuxPPS API ver. 1 registered
[    2.962785] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    2.973128] PTP clock support registered
[    2.977637] Registered efivars operations
[    2.982364] Advanced Linux Sound Architecture Driver Initialized.
[    2.989635] clocksource: Switched to clocksource arch_sys_counter
[    2.996604] VFS: Disk quotas dquot_6.6.0
[    3.001064] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    3.008968] pnp: PnP ACPI init
[    3.012598] system 00:00: [mem 0xa0090000-0xa009ffff] has been reserved
[    3.020087] system 00:00: [mem 0xb0000000-0xb1ffffff] could not be reserved
[    3.027988] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    3.028053] system 00:01: [mem 0xa0200000-0xa020ffff] has been reserved
[    3.035544] system 00:01: [mem 0xbe000000-0xbfffffff] could not be reserved
[    3.043426] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    3.043490] system 00:02: [mem 0xa00a0000-0xa00affff] has been reserved
[    3.050985] system 00:02: [mem 0xa8000000-0xa9ffffff] could not be reserved
[    3.058871] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    3.058877] pnp: PnP ACPI: found 3 devices
[    3.066430] NET: Registered protocol family 2
[    3.071880] TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
[    3.081036] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    3.088972] TCP: Hash tables configured (established 262144 bind 65536)
[    3.096572] UDP hash table entries: 16384 (order: 7, 524288 bytes)
[    3.103786] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes)
[    3.111527] NET: Registered protocol family 1
[    3.116639] RPC: Registered named UNIX socket transport module.
[    3.123325] RPC: Registered udp transport module.
[    3.128635] RPC: Registered tcp transport module.
[    3.133960] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    3.141254] pci 0001:e1:00.0: [Firmware Bug]: VPD access disabled
[    3.148171] PCI: CLS 0 bytes, default 128
[    3.148266] Unpacking initramfs...
[    3.534560] Freeing initrd memory: 27492K (ffff80001e520000 - ffff80001fff9000)
[    3.543097] kvm [1]: 8-bit VMID
[    3.546649] kvm [1]: IDMAP page: 89f000
[    3.550983] kvm [1]: HYP VA range: 800000000000:ffffffffffff
[    3.558078] kvm [1]: Hyp mode initialized successfully
[    3.563910] kvm [1]: vgic-v2@fe020000
[    3.568074] kvm [1]: GIC system register CPU interface enabled
[    3.574880] kvm [1]: vgic interrupt IRQ1
[    3.579356] kvm [1]: virtual timer IRQ4
[    3.585377] futex hash table entries: 4096 (order: 7, 524288 bytes)
[    3.592592] audit: initializing netlink subsys (disabled)
[    3.598734] audit: type=2000 audit(2.952:1): initialized
[    3.604972] workingset: timestamp_bits=44 max_order=23 bucket_order=0
[    3.616133] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    3.623103] NFS: Registering the id_resolver key type
[    3.628831] Key type id_resolver registered
[    3.633561] Key type id_legacy registered
[    3.638094] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    3.645751] 9p: Installing v9fs 9p2000 file system support
[    3.653177] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
[    3.661550] io scheduler noop registered
[    3.666053] io scheduler cfq registered (default)
[    3.671602] libphy: mdio_driver_register: phy-bcm-ns2-pci
[    3.678064] pcieport 0000:00:00.0: can't derive routing for PCI INT A
[    3.685351] pcieport 0000:00:00.0: PCI INT A: no GSI
[    3.691018] pcieport 0001:e0:00.0: can't derive routing for PCI INT A
[    3.698318] pcieport 0001:e0:00.0: PCI INT A: no GSI
[    3.703965] pcieport 0002:80:00.0: can't derive routing for PCI INT A
[    3.711246] pcieport 0002:80:00.0: PCI INT A: no GSI
[    3.716886] pcieport 0002:80:00.0: can't derive routing for PCI INT A
[    3.724166] pcieport 0002:81:00.0: PCI INT A: no GSI
[    3.729961] pcieport 0002:80:00.0: can't derive routing for PCI INT A
[    3.737244] pcieport 0002:82:00.0: PCI INT A: no GSI
[    3.743007] pcieport 0002:80:00.0: can't derive routing for PCI INT A
[    3.750290] pcieport 0002:82:01.0: PCI INT A: no GSI
[    3.756053] pcieport 0002:80:00.0: can't derive routing for PCI INT A
[    3.763335] pcieport 0002:82:02.0: PCI INT A: no GSI
[    3.769092] pcieport 0002:80:00.0: can't derive routing for PCI INT A
[    3.776373] pcieport 0002:82:08.0: PCI INT A: no GSI
[    3.782349] ipmi message handler version 39.2
[    3.787286] ipmi device interface
[    3.791064] IPMI System Interface driver.
[    3.795645] ipmi_si: probing via SMBIOS
[    3.799993] ipmi_si: SMBIOS: io 0xe4 regsize 1 spacing 1 irq 0
[    3.806586] ipmi_si: Adding SMBIOS-specified bt state machine
[    3.813101] ipmi_si: Trying SMBIOS-specified bt state machine at i/o address 0xe4, slave address 0x0, irq 0
[    3.881680] IPMI BT: using default values
[    3.886214] IPMI BT: req2rsp=5 secs retries=2
[    4.113770] ipmi_si ipmi_si.0: Found new BMC (man_id: 0x0007db, prod_id: 0x0001, dev_id: 0x01)
[    4.123577] ipmi_si ipmi_si.0: IPMI bt interface initialized
[    4.130827] xenfs: not registering filesystem on non-xen platform
[    4.139096] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    4.146871] console [ttyS0] disabled
[    4.172274] serial8250.10: ttyS0 at I/O 0x2f8 (irq = 0, base_baud = 115200) is a 16550A
[    4.181363] console [ttyS0] enabled
[    4.188789] bootconsole [hisilpcuart0] disabled
[    4.198609] SuperH (H)SCI(F) driver initialized
[    4.203210] msm_serial: driver initialized
[    4.207530] Failed to find cpu0 device node
[    4.211714] Unable to detect cache hierarchy from DT for CPU 0
[    4.220570] loop: module loaded
[    4.223922] hisi_sas: driver version v1.6
[    4.362191] scsi host0: hisi_sas
[    4.498201] scsi host1: hisi_sas
[    4.634214] scsi host2: hisi_sas
[    4.638933] libphy: Fixed MDIO Bus: probed
[    4.643181] tun: Universal TUN/TAP device driver, 1.6
[    4.648232] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    4.733642] libphy: Hisilicon MII Bus: probed
[    5.613723] netif_napi_add() called with weight 256 on device eth%d
[    5.710164] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    5.715994] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    5.721947] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
[    5.728894] igb: Copyright (c) 2007-2014 Intel Corporation.
[    5.734485] igbvf: Intel(R) Gigabit Virtual Function Network Driver - version 2.4.0-k
[    5.742293] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    5.748223] sky2: driver version 1.30
[    5.752082] VFIO - User Level meta-driver version: 0.3
[    5.757982] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    5.764500] ehci-pci: EHCI PCI platform driver
[    5.768992] ehci-platform: EHCI generic platform driver
[    5.774259] ehci-platform PNP0D20:00: EHCI Host Controller
[    5.779752] ehci-platform PNP0D20:00: new USB bus registered, assigned bus number 1
[    5.787498] ehci-platform PNP0D20:00: irq 6, io mem 0xa7020000
[    5.809639] ehci-platform PNP0D20:00: USB 2.0 started, EHCI 1.00
[    5.815920] hub 1-0:1.0: USB hub found
[    5.819682] hub 1-0:1.0: 2 ports detected
[    5.823910] ehci-exynos: EHCI EXYNOS driver
[    5.828121] ehci-msm: Qualcomm On-Chip EHCI Host Controller
[    5.833714] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    5.839900] ohci-pci: OHCI PCI platform driver
[    5.844369] ohci-platform: OHCI generic platform driver
[    5.849607] ohci-exynos: OHCI EXYNOS driver
[    5.853894] usbcore: registered new interface driver usb-storage
[    5.860146] mousedev: PS/2 mouse device common for all mice
[    5.991841] rtc-efi rtc-efi: rtc core: registered rtc-efi as rtc0
[    5.998075] i2c /dev entries driver
[    6.002024] sdhci: Secure Digital Host Controller Interface driver
[    6.008192] sdhci: Copyright(c) Pierre Ossman
[    6.012602] Synopsys Designware Multimedia Card Interface Driver
[    6.018673] sdhci-pltfm: SDHCI platform and OF driver helper
[    6.024619] ledtrig-cpu: registered to indicate activity on CPUs
[    6.030911] usbcore: registered new interface driver usbhid
[    6.036479] usbhid: USB HID core driver
[    6.040800] NET: Registered protocol family 17
[    6.045288] 9pnet: Installing 9P2000 support
[    6.049583] Key type dns_resolver registered
[    6.054105] registered taskstats version 1
[    6.121345] rtc-efi rtc-efi: setting system clock to 2016-12-02 11:17:35 UTC (1480677455)
[    6.129557] ALSA device list:
[    6.132530]   No soundcards found.
[    6.136579] Freeing unused kernel memory: 1024K (ffff800000c50000 - ffff800000d50000)
[    6.213643] usb 1-1: new high-speed USB device number 2 using ehci-platform
[    6.366266] hub 1-1:1.0: USB hub found
[    6.370087] hub 1-1:1.0: 4 ports detected
[    6.493638] usb 1-2: new high-speed USB device number 3 using ehci-platform
[    6.646262] hub 1-2:1.0: USB hub found
[    6.650087] hub 1-2:1.0: 4 ports detected
[    6.941637] usb 1-2.1: new full-speed USB device number 4 using ehci-platform
[    7.058410] input: Keyboard/Mouse KVM 1.1.0 as /devices/platform/PNP0D20:00/usb1/1-2/1-2.1/1-2.1:1.0/0003:12D1:0003.0001/input/input0
[    7.129870] hid-generic 0003:12D1:0003.0001: input: USB HID v1.10 Keyboard [Keyboard/Mouse KVM 1.1.0] on usb-PNP0D20:00-2.1/input0
[    7.142758] input: Keyboard/Mouse KVM 1.1.0 as /devices/platform/PNP0D20:00/usb1/1-2/1-2.1/1-2.1:1.1/0003:12D1:0003.0002/input/input1
[    7.154837] hid-generic 0003:12D1:0003.0002: input: USB HID v1.10 Mouse [Keyboard/Mouse KVM 1.1.0] on usb-PNP0D20:00-2.1/input1
root@(none)$ cat /proc/iomem
00000000-00024fff : reserved
00026000-31a0ffff : System RAM
   00080000-00c4ffff : Kernel code
   00d50000-00e75fff : Kernel data
31a10000-31a7ffff : reserved
31a80000-31b5ffff : System RAM
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
