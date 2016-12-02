Return-Path: <SRS0=KiYe=XR=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=KiYe=XR=huawei.com=liudongdong3@kernel.org>
Subject: Re: [PATCH v10 00/12] PCI: ARM64 ECAM quirks
To: Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
References: <20161201075131.12247.2211.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20161201180130.GD30746@bhelgaas-glaptop.roam.corp.google.com>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gabriele Paoloni
	<gabriele.paoloni@huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tomasz Nowicki <tn@semihalf.com>, Duc Dang <dhdang@apm.com>,
        Sinan Kaya
	<okaya@codeaurora.org>,
        Christopher Covington <cov@codeaurora.org>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <466c00e6-f55b-89df-b95f-0e12bc3d189f@huawei.com>
Date: Fri, 2 Dec 2016 19:42:31 +0800
MIME-Version: 1.0
In-Reply-To: <20161201180130.GD30746@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>


Hi Bjorn

在 2016/12/2 2:01, Bjorn Helgaas 写道:
> On Thu, Dec 01, 2016 at 02:29:22AM -0600, Bjorn Helgaas wrote:
>> This is what I've collected on my pci/ecam branch so far.  This is
>> preliminary and probably doesn't even build since I made several
>> changes, but at least it's a strawman.  I called it v10 to keep it
>> separate from the previous postings of the various pieces.
>
> I don't want to spam the list with a zillion revisions, but I updated
> the branch with the build and acpi_resource_consumer() fixes, thanks
> to Dongdong, Tomasz, Rober, and Lorenzo.  Current head is:
>
> http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?id=f80edf4d6c05
>
> If you test this, please mention the SHA1 you're testing and collect
> the dmesg log and /proc/iomem contents.

I tested ok on HiSilicon D03 board except some compile warnings as below.
(commit 36532ac6c5253bcae6624e480b9d2467c2ae7dad)

drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type
   THUNDER_PEM_QUIRK(2,  0), /* off-chip devices */
   ^
drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression
drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for 'mcfg_quirks[44].cfgres.start')
drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type
drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression
drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for 'mcfg_quirks[44].cfgres.end')
drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type
drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression
drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for 'mcfg_quirks[45].cfgres.start')
drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type
drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression
drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for 'mcfg_quirks[45].cfgres.end')
drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type
drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression
drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for 'mcfg_quirks[46].cfgres.start')
drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type
drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression
drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for 'mcfg_quirks[46].cfgres.end')
drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type
drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression
drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for 'mcfg_quirks[47].cfgres.start')
drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type
drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression
drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for 'mcfg_quirks[47].cfgres.end')
drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type
drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression
drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for 'mcfg_quirks[48].cfgres.start')
drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type
drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression
drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for 'mcfg_quirks[48].cfgres.end')
drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type
drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression
drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for 'mcfg_quirks[49].cfgres.start')
drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type
drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression
drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for 'mcfg_quirks[49].cfgres.end')
drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type
   THUNDER_PEM_QUIRK(2,  1), /* off-chip devices */
   ^
drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression
drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for 'mcfg_quirks[50].cfgres.start')
drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type
drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression
drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for 'mcfg_quirks[50].cfgres.end')
drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type
drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression
drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for 'mcfg_quirks[51].cfgres.start')
drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type
drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression
drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for 'mcfg_quirks[51].cfgres.end')
drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type
drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression
drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for 'mcfg_quirks[52].cfgres.start')
drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type
drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression
drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for 'mcfg_quirks[52].cfgres.end')
drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type
drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression
drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for 'mcfg_quirks[53].cfgres.start')
drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type
drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression
drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for 'mcfg_quirks[53].cfgres.end')
drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type
drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression
drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for 'mcfg_quirks[54].cfgres.start')
drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type
drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression
drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for 'mcfg_quirks[54].cfgres.end')
drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type
drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression
drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for 'mcfg_quirks[55].cfgres.start')
drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type
drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression
drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for 'mcfg_quirks[55].cfgres.end')
>
> I'll post the full set again soon, hopefully including the X-Gene
> quirks.
>
> Bjorn
>
> .
>

The dmesg and /proc/iomem information are as below.
root@(none)$ dmesg
[    0.000000] Booting Linux on physical CPU 0x10000
[    0.000000] Linux version 4.9.0-rc1-g1f58b0b-dirty (l00290354@linux-ioko) (gcc version 4.9.3 20150211 (prerelease) (20150316) ) #259 SMP PREEMPT Fri Dec 2 19:39:39 CST 2016
[    0.000000] Boot CPU: AArch64 Processor [411fd071]
[    0.000000] earlycon: hisilpcuart0 at MMIO 0x00000000a01b0000 (options '0,0x2f8')
[    0.000000] bootconsole [hisilpcuart0] enabled
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: EFI v2.60 by EDK II
[    0.000000] efi:  SMBIOS=0x3f110000  SMBIOS 3.0=0x39ce0000  ACPI=0x39db0000  ACPI 2.0=0x39db0014  MEMATTR=0x3c942018
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
[    0.009151] Console: colour dummy device 80x25
[    0.014188] Calibrating delay loop (skipped), value calculated using timer frequency.. 100.00 BogoMIPS (lpj=200000)
[    0.025963] pid_max: default: 32768 minimum: 301
[    0.031229] ACPI: Core revision 20160831
[    0.036781] ACPI: 1 ACPI AML tables successfully acquired and loaded

[    0.045753] Security Framework initialized
[    0.054796] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes)
[    0.076108] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    0.089846] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.097742] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.106894] ASID allocator initialised with 65536 entries
[    0.145095] PCI/MSI: ITS@0xc6000000 domain created
[    0.150546] Platform MSI: ITS@0xc6000000 domain created
[    0.156550] Remapping and enabling EFI services.
[    0.161792]   EFI remap 0x0000000031a00000 => 0000000020000000
[    0.168390]   EFI remap 0x0000000031b60000 => 0000000020070000
[    0.174988]   EFI remap 0x0000000039c10000 => 0000000020080000
[    0.181585]   EFI remap 0x0000000039c50000 => 00000000200c0000
[    0.188178]   EFI remap 0x0000000039cd0000 => 00000000200d0000
[    0.194776]   EFI remap 0x0000000039d50000 => 0000000020150000
[    0.201373]   EFI remap 0x0000000039dc0000 => 00000000201a0000
[    0.207971]   EFI remap 0x0000000039e10000 => 00000000201f0000
[    0.214564]   EFI remap 0x0000000039f20000 => 0000000020300000
[    0.221162]   EFI remap 0x0000000039f90000 => 0000000020370000
[    0.227762]   EFI remap 0x0000000039fe0000 => 00000000203c0000
[    0.234359]   EFI remap 0x000000003a030000 => 0000000020410000
[    0.240956]   EFI remap 0x000000003a080000 => 0000000020460000
[    0.247550]   EFI remap 0x000000003a0d0000 => 00000000204b0000
[    0.254143]   EFI remap 0x000000003f110000 => 0000000020500000
[    0.260741]   EFI remap 0x0000000078000000 => 0000000020530000
[    0.267339]   EFI remap 0x00000000a4000000 => 0000000020600000
[    0.273975]   EFI remap 0x00000000a6000000 => 0000000021600000
[    0.280568]   EFI remap 0x00000000d00e0000 => 0000000021610000
[    0.387658] Detected PIPT I-cache on CPU1
[    0.387673] GICv3: CPU1: found redistributor 10001 region 1:0x000000004d130000
[    0.387704] CPU1: using LPI pending table @0x00000027dc300000
[    0.387718] CPU1: Booted secondary processor [411fd071]
[    0.468344] Detected PIPT I-cache on CPU2
[    0.468352] GICv3: CPU2: found redistributor 10002 region 2:0x000000004d160000
[    0.468381] CPU2: using LPI pending table @0x00000027dc330000
[    0.468391] CPU2: Booted secondary processor [411fd071]
[    0.549078] Detected PIPT I-cache on CPU3
[    0.549086] GICv3: CPU3: found redistributor 10003 region 3:0x000000004d190000
[    0.549115] CPU3: using LPI pending table @0x00000027dc370000
[    0.549125] CPU3: Booted secondary processor [411fd071]
[    0.629744] Detected PIPT I-cache on CPU4
[    0.629755] GICv3: CPU4: found redistributor 10100 region 4:0x000000004d1c0000
[    0.629786] CPU4: using LPI pending table @0x00000027dc3a0000
[    0.629800] CPU4: Booted secondary processor [411fd071]
[    0.710450] Detected PIPT I-cache on CPU5
[    0.710458] GICv3: CPU5: found redistributor 10101 region 5:0x000000004d1f0000
[    0.710487] CPU5: using LPI pending table @0x00000027dc3d0000
[    0.710497] CPU5: Booted secondary processor [411fd071]
[    0.791173] Detected PIPT I-cache on CPU6
[    0.791181] GICv3: CPU6: found redistributor 10102 region 6:0x000000004d220000
[    0.791211] CPU6: using LPI pending table @0x00000027dbc20000
[    0.791221] CPU6: Booted secondary processor [411fd071]
[    0.871868] Detected PIPT I-cache on CPU7
[    0.871876] GICv3: CPU7: found redistributor 10103 region 7:0x000000004d250000
[    0.871904] CPU7: using LPI pending table @0x00000027dbc50000
[    0.871914] CPU7: Booted secondary processor [411fd071]
[    0.952671] Detected PIPT I-cache on CPU8
[    0.952683] GICv3: CPU8: found redistributor 10200 region 8:0x000000004d280000
[    0.952714] CPU8: using LPI pending table @0x00000027dbc80000
[    0.952728] CPU8: Booted secondary processor [411fd071]
[    1.033372] Detected PIPT I-cache on CPU9
[    1.033380] GICv3: CPU9: found redistributor 10201 region 9:0x000000004d2b0000
[    1.033410] CPU9: using LPI pending table @0x00000027dbcc0000
[    1.033420] CPU9: Booted secondary processor [411fd071]
[    1.114066] Detected PIPT I-cache on CPU10
[    1.114074] GICv3: CPU10: found redistributor 10202 region 10:0x000000004d2e0000
[    1.114103] CPU10: using LPI pending table @0x00000027dbcf0000
[    1.114113] CPU10: Booted secondary processor [411fd071]
[    1.194801] Detected PIPT I-cache on CPU11
[    1.194810] GICv3: CPU11: found redistributor 10203 region 11:0x000000004d310000
[    1.194840] CPU11: using LPI pending table @0x00000027dbd30000
[    1.194850] CPU11: Booted secondary processor [411fd071]
[    1.275527] Detected PIPT I-cache on CPU12
[    1.275540] GICv3: CPU12: found redistributor 10300 region 12:0x000000004d340000
[    1.275571] CPU12: using LPI pending table @0x00000027dbd60000
[    1.275585] CPU12: Booted secondary processor [411fd071]
[    1.356231] Detected PIPT I-cache on CPU13
[    1.356239] GICv3: CPU13: found redistributor 10301 region 13:0x000000004d370000
[    1.356268] CPU13: using LPI pending table @0x00000027dbdb0000
[    1.356278] CPU13: Booted secondary processor [411fd071]
[    1.436937] Detected PIPT I-cache on CPU14
[    1.436946] GICv3: CPU14: found redistributor 10302 region 14:0x000000004d3a0000
[    1.436975] CPU14: using LPI pending table @0x00000027dbde0000
[    1.436985] CPU14: Booted secondary processor [411fd071]
[    1.517656] Detected PIPT I-cache on CPU15
[    1.517664] GICv3: CPU15: found redistributor 10303 region 15:0x000000004d3d0000
[    1.517694] CPU15: using LPI pending table @0x00000027dbe10000
[    1.517704] CPU15: Booted secondary processor [411fd071]
[    1.517744] Brought up 16 CPUs
[    1.902893] SMP: Total of 16 processors activated.
[    1.908347] CPU features: detected feature: GIC system register CPU interface
[    1.916460] CPU features: detected feature: 32-bit EL0 Support
[    1.923155] CPU: All CPU(s) started at EL2
[    1.927814] alternatives: patching kernel code
[    1.937777] devtmpfs: initialized
[    1.941919] SMBIOS 3.0.0 present.
[    1.945799] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    1.957134] pinctrl core: initialized pinctrl subsystem
[    1.963526] NET: Registered protocol family 16
[    2.193616] cpuidle: using governor menu
[    2.198197] vdso: 2 pages (1 code @ ffff0000088b7000, 1 data @ ffff000008d54000)
[    2.206747] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    2.215097] DMA: preallocated 256 KiB pool for atomic allocations
[    2.222123] ACPI: bus type PCI registered
[    2.226733] Serial: AMBA PL011 UART driver
[    2.251622] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    2.259366] ACPI: Added _OSI(Module Device)
[    2.264179] ACPI: Added _OSI(Processor Device)
[    2.269297] ACPI: Added _OSI(3.0 _SCP Extensions)
[    2.274717] ACPI: Added _OSI(Processor Aggregator Device)
[    2.282835] ACPI: Interpreter enabled
[    2.287049] ACPI: Using GIC for interrupt routing
[    2.292504] ACPI: MCFG table detected, 3 entries
[    2.315378] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-1f])
[    2.322521] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig Segments MSI]
[    2.330752] acpi PNP0A08:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
[    2.342018] acpi PNP0A08:00: MCFG quirk: ECAM at [mem 0xb0000000-0xb1ffffff] for [bus 00-1f] with hisi_pcie_ops
[    2.354271] acpi PNP0A08:00: ECAM area [mem 0xb0000000-0xb1ffffff] reserved by HISI0081:00
[    2.363996] acpi PNP0A08:00: ECAM at [mem 0xb0000000-0xb1ffffff] for [bus 00-1f]
[    2.372554] Remapped I/O 0x00000000b7ff0000 to [io  0x0000-0xffff window]
[    2.380346] PCI host bridge to bus 0000:00
[    2.385008] pci_bus 0000:00: root bus resource [mem 0xb2000000-0xb7feffff window]
[    2.393531] pci_bus 0000:00: root bus resource [io  0x0000-0xffff window]
[    2.401260] pci_bus 0000:00: root bus resource [bus 00-1f]
[    2.407514] pci 0000:00:00.0: [19e5:1610] type 01 class 0x060400
[    2.407525] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x0000ffff]
[    2.407564] pci 0000:00:00.0: supports D1 D2
[    2.407566] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
[    2.458916] pci 0000:00:00.0: BAR 0: assigned [mem 0xb2000000-0xb200ffff]
[    2.466641] pci 0000:00:00.0: PCI bridge to [bus 01]
[    2.472296] pci 0000:00:00.0: Max Payload Size set to  512/ 512 (was  128), Max Read Rq  512
[    2.481939] ACPI: PCI Root Bridge [PCI1] (domain 0001 [bus e0-ff])
[    2.488972] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig Segments MSI]
[    2.497067] acpi PNP0A08:01: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
[    2.508154] acpi PNP0A08:01: MCFG quirk: ECAM at [mem 0xbe000000-0xbfffffff] for [bus e0-ff] with hisi_pcie_ops
[    2.520271] acpi PNP0A08:01: ECAM area [mem 0xbe000000-0xbfffffff] reserved by HISI0081:01
[    2.529906] acpi PNP0A08:01: ECAM at [mem 0xbe000000-0xbfffffff] for [bus e0-ff]
[    2.538342] Remapped I/O 0x00000000bdff0000 to [io  0x10000-0x1ffff window]
[    2.546313] PCI host bridge to bus 0001:e0
[    2.550974] pci_bus 0001:e0: root bus resource [mem 0xb8000000-0xbdfeffff window]
[    2.559479] pci_bus 0001:e0: root bus resource [io  0x10000-0x1ffff window] (bus address [0x0000-0xffff])
[    2.570366] pci_bus 0001:e0: root bus resource [bus e0-ff]
[    2.576619] pci 0001:e0:00.0: [19e5:1610] type 01 class 0x060400
[    2.576627] pci 0001:e0:00.0: reg 0x10: [mem 0x00000000-0x00000fff]
[    2.576635] pci 0001:e0:00.0: reg 0x38: [mem 0xfffe0000-0xffffffff pref]
[    2.576662] pci 0001:e0:00.0: supports D1 D2
[    2.576664] pci 0001:e0:00.0: PME# supported from D0 D1 D3hot
[    2.576793] pci 0001:e1:00.0: [1000:005d] type 00 class 0x010400
[    2.576801] pci 0001:e1:00.0: reg 0x10: [io  0x10000-0x100ff]
[    2.576809] pci 0001:e1:00.0: reg 0x14: [mem 0xb8100000-0xb810ffff 64bit]
[    2.576816] pci 0001:e1:00.0: reg 0x1c: [mem 0xb8000000-0xb80fffff 64bit]
[    2.576824] pci 0001:e1:00.0: reg 0x30: [mem 0xfff00000-0xffffffff pref]
[    2.576874] pci 0001:e1:00.0: supports D1 D2
[    2.576954] pci 0001:e0:00.0: BAR 14: assigned [mem 0xb8000000-0xb82fffff]
[    2.584780] pci 0001:e0:00.0: BAR 6: assigned [mem 0xb8300000-0xb831ffff pref]
[    2.593001] pci 0001:e0:00.0: BAR 0: assigned [mem 0xb8320000-0xb8320fff]
[    2.600718] pci 0001:e0:00.0: BAR 13: assigned [io  0x10000-0x10fff]
[    2.607958] pci 0001:e1:00.0: BAR 3: assigned [mem 0xb8000000-0xb80fffff 64bit]
[    2.616272] pci 0001:e1:00.0: BAR 6: assigned [mem 0xb8100000-0xb81fffff pref]
[    2.624479] pci 0001:e1:00.0: BAR 1: assigned [mem 0xb8200000-0xb820ffff 64bit]
[    2.632798] pci 0001:e1:00.0: BAR 0: assigned [io  0x10000-0x100ff]
[    2.639943] pci 0001:e0:00.0: PCI bridge to [bus e1]
[    2.645584] pci 0001:e0:00.0:   bridge window [io  0x10000-0x10fff]
[    2.652711] pci 0001:e0:00.0:   bridge window [mem 0xb8000000-0xb82fffff]
[    2.660439] pci 0001:e0:00.0: Max Payload Size set to  512/ 512 (was  128), Max Read Rq  512
[    2.670045] pci 0001:e1:00.0: Max Payload Size set to  512/4096 (was  128), Max Read Rq  512
[    2.679689] ACPI: PCI Root Bridge [PCI2] (domain 0002 [bus 80-9f])
[    2.686723] acpi PNP0A08:02: _OSC: OS supports [ExtendedConfig Segments MSI]
[    2.694818] acpi PNP0A08:02: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
[    2.705902] acpi PNP0A08:02: MCFG quirk: ECAM at [mem 0xa8000000-0xa9ffffff] for [bus 80-9f] with hisi_pcie_ops
[    2.717989] acpi PNP0A08:02: ECAM area [mem 0xa8000000-0xa9ffffff] reserved by HISI0081:02
[    2.727615] acpi PNP0A08:02: ECAM at [mem 0xa8000000-0xa9ffffff] for [bus 80-9f]
[    2.736049] Remapped I/O 0x00000000afff0000 to [io  0x20000-0x2ffff window]
[    2.744024] PCI host bridge to bus 0002:80
[    2.748685] pci_bus 0002:80: root bus resource [mem 0xaa000000-0xaffeffff window]
[    2.757205] pci_bus 0002:80: root bus resource [io  0x20000-0x2ffff window] (bus address [0x0000-0xffff])
[    2.768097] pci_bus 0002:80: root bus resource [bus 80-9f]
[    2.774344] pci 0002:80:00.0: [19e5:1610] type 01 class 0x060400
[    2.774351] pci 0002:80:00.0: reg 0x10: [mem 0x00000000-0x0000ffff]
[    2.774381] pci 0002:80:00.0: supports D1 D2
[    2.774383] pci 0002:80:00.0: PME# supported from D0 D1 D3hot
[    2.774514] pci 0002:81:00.0: [10b5:8725] type 01 class 0x060400
[    2.774525] pci 0002:81:00.0: reg 0x10: [mem 0xaa200000-0xaa23ffff]
[    2.774598] pci 0002:81:00.0: PME# supported from D0 D3hot D3cold
[    2.774749] pci 0002:82:00.0: [10b5:8725] type 01 class 0x060400
[    2.774831] pci 0002:82:00.0: PME# supported from D0 D3hot D3cold
[    2.774926] pci 0002:82:01.0: [10b5:8725] type 01 class 0x060400
[    2.775007] pci 0002:82:01.0: PME# supported from D0 D3hot D3cold
[    2.775103] pci 0002:82:02.0: [10b5:8725] type 01 class 0x060400
[    2.775184] pci 0002:82:02.0: PME# supported from D0 D3hot D3cold
[    2.775282] pci 0002:82:08.0: [10b5:8725] type 01 class 0x060400
[    2.775363] pci 0002:82:08.0: PME# supported from D0 D3hot D3cold
[    2.775574] pci 0002:84:00.0: [19e5:1711] type 00 class 0x030000
[    2.775591] pci 0002:84:00.0: reg 0x10: [mem 0xac000000-0xadffffff pref]
[    2.775602] pci 0002:84:00.0: reg 0x14: [mem 0xaa000000-0xaa1fffff]
[    2.775702] pci 0002:84:00.0: supports D1
[    2.775704] pci 0002:84:00.0: PME# supported from D0 D1 D3hot
[    2.775932] pci 0002:80:00.0: BAR 14: assigned [mem 0xaa000000-0xae7fffff]
[    2.783759] pci 0002:80:00.0: BAR 15: assigned [mem 0xae800000-0xaebfffff 64bit pref]
[    2.792668] pci 0002:80:00.0: BAR 0: assigned [mem 0xaec00000-0xaec0ffff]
[    2.800381] pci 0002:80:00.0: BAR 13: assigned [io  0x20000-0x21fff]
[    2.807611] pci 0002:81:00.0: BAR 14: assigned [mem 0xaa000000-0xadffffff]
[    2.815429] pci 0002:81:00.0: BAR 15: assigned [mem 0xae800000-0xaebfffff 64bit pref]
[    2.824331] pci 0002:81:00.0: BAR 0: assigned [mem 0xae000000-0xae03ffff]
[    2.832058] pci 0002:81:00.0: BAR 13: assigned [io  0x20000-0x21fff]
[    2.839281] pci 0002:82:01.0: BAR 14: assigned [mem 0xaa000000-0xacffffff]
[    2.847089] pci 0002:82:00.0: BAR 14: assigned [mem 0xad000000-0xad1fffff]
[    2.854919] pci 0002:82:00.0: BAR 15: assigned [mem 0xae800000-0xae9fffff 64bit pref]
[    2.863818] pci 0002:82:01.0: BAR 15: assigned [mem 0xaea00000-0xaebfffff 64bit pref]
[    2.872725] pci 0002:82:00.0: BAR 13: assigned [io  0x20000-0x20fff]
[    2.879955] pci 0002:82:01.0: BAR 13: assigned [io  0x21000-0x21fff]
[    2.887184] pci 0002:82:00.0: PCI bridge to [bus 83]
[    2.892832] pci 0002:82:00.0:   bridge window [io  0x20000-0x20fff]
[    2.899964] pci 0002:82:00.0:   bridge window [mem 0xad000000-0xad1fffff]
[    2.907674] pci 0002:82:00.0:   bridge window [mem 0xae800000-0xae9fffff 64bit pref]
[    2.916488] pci 0002:84:00.0: BAR 0: assigned [mem 0xaa000000-0xabffffff pref]
[    2.924703] pci 0002:84:00.0: BAR 1: assigned [mem 0xac000000-0xac1fffff]
[    2.932418] pci 0002:82:01.0: PCI bridge to [bus 84]
[    2.938055] pci 0002:82:01.0:   bridge window [io  0x21000-0x21fff]
[    2.945178] pci 0002:82:01.0:   bridge window [mem 0xaa000000-0xacffffff]
[    2.952907] pci 0002:82:01.0:   bridge window [mem 0xaea00000-0xaebfffff 64bit pref]
[    2.961707] pci 0002:82:02.0: PCI bridge to [bus 85]
[    2.967353] pci 0002:82:08.0: PCI bridge to [bus 86]
[    2.973005] pci 0002:81:00.0: PCI bridge to [bus 82-86]
[    2.978949] pci 0002:81:00.0:   bridge window [io  0x20000-0x21fff]
[    2.986071] pci 0002:81:00.0:   bridge window [mem 0xaa000000-0xadffffff]
[    2.993783] pci 0002:81:00.0:   bridge window [mem 0xae800000-0xaebfffff 64bit pref]
[    3.002589] pci 0002:80:00.0: PCI bridge to [bus 81-86]
[    3.008526] pci 0002:80:00.0:   bridge window [io  0x20000-0x21fff]
[    3.015647] pci 0002:80:00.0:   bridge window [mem 0xaa000000-0xae7fffff]
[    3.023364] pci 0002:80:00.0:   bridge window [mem 0xae800000-0xaebfffff 64bit pref]
[    3.032169] pci 0002:80:00.0: Max Payload Size set to  512/ 512 (was  128), Max Read Rq  512
[    3.041766] pci 0002:81:00.0: Max Payload Size set to  512/1024 (was  128), Max Read Rq  128
[    3.051365] pci 0002:82:00.0: Max Payload Size set to  512/1024 (was  128), Max Read Rq  128
[    3.060961] pci 0002:82:01.0: Max Payload Size set to  512/1024 (was  128), Max Read Rq  128
[    3.070563] pci 0002:84:00.0: Max Payload Size set to  256/ 256 (was  128), Max Read Rq  256
[    3.080146] pci 0002:82:02.0: Max Payload Size set to  512/1024 (was  128), Max Read Rq  128
[    3.089748] pci 0002:82:08.0: Max Payload Size set to  512/1024 (was  128), Max Read Rq  128
[    3.099769] vgaarb: device added: PCI:0002:84:00.0,decodes=io+mem,owns=none,locks=none
[    3.108717] vgaarb: loaded
[    3.111768] vgaarb: bridge control possible 0002:84:00.0
[    3.117919] SCSI subsystem initialized
[    3.122244] libata version 3.00 loaded.
[    3.122322] ACPI: bus type USB registered
[    3.126926] usbcore: registered new interface driver usbfs
[    3.133179] usbcore: registered new interface driver hub
[    3.139270] usbcore: registered new device driver usb
[    3.145122] pps_core: LinuxPPS API ver. 1 registered
[    3.150754] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    3.161136] PTP clock support registered
[    3.165659] Registered efivars operations
[    3.170389] Advanced Linux Sound Architecture Driver Initialized.
[    3.177625] clocksource: Switched to clocksource arch_sys_counter
[    3.184576] VFS: Disk quotas dquot_6.6.0
[    3.189037] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    3.196917] pnp: PnP ACPI init
[    3.200549] system 00:00: [mem 0xa0090000-0xa009ffff] has been reserved
[    3.208026] system 00:00: [mem 0xb0000000-0xb1ffffff] could not be reserved
[    3.215895] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    3.215960] system 00:01: [mem 0xa0200000-0xa020ffff] has been reserved
[    3.223435] system 00:01: [mem 0xbe000000-0xbfffffff] could not be reserved
[    3.231303] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    3.231368] system 00:02: [mem 0xa00a0000-0xa00affff] has been reserved
[    3.238842] system 00:02: [mem 0xa8000000-0xa9ffffff] could not be reserved
[    3.246710] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    3.246717] pnp: PnP ACPI: found 3 devices
[    3.254213] NET: Registered protocol family 2
[    3.259664] TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
[    3.268853] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    3.276795] TCP: Hash tables configured (established 262144 bind 65536)
[    3.284389] UDP hash table entries: 16384 (order: 7, 524288 bytes)
[    3.291603] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes)
[    3.299348] NET: Registered protocol family 1
[    3.304456] RPC: Registered named UNIX socket transport module.
[    3.311145] RPC: Registered udp transport module.
[    3.316457] RPC: Registered tcp transport module.
[    3.321768] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    3.329061] pci 0001:e1:00.0: [Firmware Bug]: VPD access disabled
[    3.335960] PCI: CLS 0 bytes, default 128
[    3.336049] Unpacking initramfs...
[    3.722561] Freeing initrd memory: 27492K (ffff80001e520000 - ffff80001fff9000)
[    3.731095] kvm [1]: 8-bit VMID
[    3.734651] kvm [1]: IDMAP page: 89f000
[    3.738985] kvm [1]: HYP VA range: 800000000000:ffffffffffff
[    3.746090] kvm [1]: Hyp mode initialized successfully
[    3.751923] kvm [1]: vgic-v2@fe020000
[    3.756085] kvm [1]: GIC system register CPU interface enabled
[    3.762895] kvm [1]: vgic interrupt IRQ1
[    3.767338] kvm [1]: virtual timer IRQ4
[    3.773322] futex hash table entries: 4096 (order: 7, 524288 bytes)
[    3.780529] audit: initializing netlink subsys (disabled)
[    3.786666] audit: type=2000 audit(3.140:1): initialized
[    3.792914] workingset: timestamp_bits=44 max_order=23 bucket_order=0
[    3.804097] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    3.811051] NFS: Registering the id_resolver key type
[    3.816774] Key type id_resolver registered
[    3.821498] Key type id_legacy registered
[    3.826029] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    3.833672] 9p: Installing v9fs 9p2000 file system support
[    3.840990] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
[    3.849350] io scheduler noop registered
[    3.853838] io scheduler cfq registered (default)
[    3.859375] libphy: mdio_driver_register: phy-bcm-ns2-pci
[    3.865858] pcieport 0000:00:00.0: can't derive routing for PCI INT A
[    3.873136] pcieport 0000:00:00.0: PCI INT A: no GSI
[    3.878800] pcieport 0001:e0:00.0: can't derive routing for PCI INT A
[    3.886093] pcieport 0001:e0:00.0: PCI INT A: no GSI
[    3.891734] pcieport 0002:80:00.0: can't derive routing for PCI INT A
[    3.899012] pcieport 0002:80:00.0: PCI INT A: no GSI
[    3.904649] pcieport 0002:80:00.0: can't derive routing for PCI INT A
[    3.911924] pcieport 0002:81:00.0: PCI INT A: no GSI
[    3.917720] pcieport 0002:80:00.0: can't derive routing for PCI INT A
[    3.924996] pcieport 0002:82:00.0: PCI INT A: no GSI
[    3.930753] pcieport 0002:80:00.0: can't derive routing for PCI INT A
[    3.938030] pcieport 0002:82:01.0: PCI INT A: no GSI
[    3.943786] pcieport 0002:80:00.0: can't derive routing for PCI INT A
[    3.951063] pcieport 0002:82:02.0: PCI INT A: no GSI
[    3.956812] pcieport 0002:80:00.0: can't derive routing for PCI INT A
[    3.964090] pcieport 0002:82:08.0: PCI INT A: no GSI
[    3.970064] ipmi message handler version 39.2
[    3.974988] ipmi device interface
[    3.978761] IPMI System Interface driver.
[    3.983345] ipmi_si: probing via SMBIOS
[    3.987677] ipmi_si: SMBIOS: io 0xe4 regsize 1 spacing 1 irq 0
[    3.994265] ipmi_si: Adding SMBIOS-specified bt state machine
[    4.000766] ipmi_si: Trying SMBIOS-specified bt state machine at i/o address 0xe4, slave address 0x0, irq 0
[    4.069672] IPMI BT: using default values
[    4.074195] IPMI BT: req2rsp=5 secs retries=2
[    4.277762] ipmi_si ipmi_si.0: Found new BMC (man_id: 0x0007db, prod_id: 0x0001, dev_id: 0x01)
[    4.287559] ipmi_si ipmi_si.0: IPMI bt interface initialized
[    4.294811] xenfs: not registering filesystem on non-xen platform
[    4.303084] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    4.310866] console [ttyS0] disabled
[    4.336261] serial8250.10: ttyS0 at I/O 0x2f8 (irq = 0, base_baud = 115200) is a 16550A
[    4.345346] console [ttyS0] enabled
[    4.352768] bootconsole [hisilpcuart0] disabled
[    4.362587] SuperH (H)SCI(F) driver initialized
[    4.367188] msm_serial: driver initialized
[    4.371517] Failed to find cpu0 device node
[    4.375702] Unable to detect cache hierarchy from DT for CPU 0
[    4.384605] loop: module loaded
[    4.387964] hisi_sas: driver version v1.6
[    4.526172] scsi host0: hisi_sas
[    4.666170] scsi host1: hisi_sas
[    4.802186] scsi host2: hisi_sas
[    4.806904] libphy: Fixed MDIO Bus: probed
[    4.811147] tun: Universal TUN/TAP device driver, 1.6
[    4.816197] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    4.901635] libphy: Hisilicon MII Bus: probed
[    5.781718] netif_napi_add() called with weight 256 on device eth%d
[    5.878175] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    5.884003] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    5.889956] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
[    5.896901] igb: Copyright (c) 2007-2014 Intel Corporation.
[    5.902491] igbvf: Intel(R) Gigabit Virtual Function Network Driver - version 2.4.0-k
[    5.910305] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    5.916235] sky2: driver version 1.30
[    5.920085] VFIO - User Level meta-driver version: 0.3
[    5.925956] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    5.932473] ehci-pci: EHCI PCI platform driver
[    5.936938] ehci-platform: EHCI generic platform driver
[    5.942204] ehci-platform PNP0D20:00: EHCI Host Controller
[    5.947692] ehci-platform PNP0D20:00: new USB bus registered, assigned bus number 1
[    5.955441] ehci-platform PNP0D20:00: irq 6, io mem 0xa7020000
[    5.973635] ehci-platform PNP0D20:00: USB 2.0 started, EHCI 1.00
[    5.979947] hub 1-0:1.0: USB hub found
[    5.983707] hub 1-0:1.0: 2 ports detected
[    5.987945] ehci-exynos: EHCI EXYNOS driver
[    5.992153] ehci-msm: Qualcomm On-Chip EHCI Host Controller
[    5.997740] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    6.003917] ohci-pci: OHCI PCI platform driver
[    6.008384] ohci-platform: OHCI generic platform driver
[    6.013627] ohci-exynos: OHCI EXYNOS driver
[    6.017915] usbcore: registered new interface driver usb-storage
[    6.024184] mousedev: PS/2 mouse device common for all mice
[    6.155910] rtc-efi rtc-efi: rtc core: registered rtc-efi as rtc0
[    6.162144] i2c /dev entries driver
[    6.166106] sdhci: Secure Digital Host Controller Interface driver
[    6.172274] sdhci: Copyright(c) Pierre Ossman
[    6.176688] Synopsys Designware Multimedia Card Interface Driver
[    6.182760] sdhci-pltfm: SDHCI platform and OF driver helper
[    6.188706] ledtrig-cpu: registered to indicate activity on CPUs
[    6.195002] usbcore: registered new interface driver usbhid
[    6.200569] usbhid: USB HID core driver
[    6.204901] NET: Registered protocol family 17
[    6.209389] 9pnet: Installing 9P2000 support
[    6.213693] Key type dns_resolver registered
[    6.218220] registered taskstats version 1
[    6.285444] rtc-efi rtc-efi: setting system clock to 2016-12-02 19:27:20 UTC (1480706840)
[    6.293660] ALSA device list:
[    6.296629]   No soundcards found.
[    6.300685] Freeing unused kernel memory: 1024K (ffff800000c50000 - ffff800000d50000)
[    6.313634] usb 1-1: new high-speed USB device number 2 using ehci-platform
[    6.466335] hub 1-1:1.0: USB hub found
[    6.470155] hub 1-1:1.0: 4 ports detected
[    6.593629] usb 1-2: new high-speed USB device number 3 using ehci-platform
[    6.746330] hub 1-2:1.0: USB hub found
[    6.750156] hub 1-2:1.0: 4 ports detected
[    7.041629] usb 1-2.1: new full-speed USB device number 4 using ehci-platform
[    7.158255] input: Keyboard/Mouse KVM 1.1.0 as /devices/platform/PNP0D20:00/usb1/1-2/1-2.1/1-2.1:1.0/0003:12D1:0003.0001/input/input0
[    7.229870] hid-generic 0003:12D1:0003.0001: input: USB HID v1.10 Keyboard [Keyboard/Mouse KVM 1.1.0] on usb-PNP0D20:00-2.1/input0
[    7.242699] input: Keyboard/Mouse KVM 1.1.0 as /devices/platform/PNP0D20:00/usb1/1-2/1-2.1/1-2.1:1.1/0003:12D1:0003.0002/input/input1
[    7.254754] hid-generic 0003:12D1:0003.0002: input: USB HID v1.10 Mouse [Keyboard/Mouse KVM 1.1.0] on usb-PNP0D20:00-2.1/input1
root@(none)$ cat /proc/iomem
00000000-00024fff : reserved
00026000-319fffff : System RAM
   00080000-00c4ffff : Kernel code
   00d50000-00e75fff : Kernel data
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


Thanks,
Dongdong
