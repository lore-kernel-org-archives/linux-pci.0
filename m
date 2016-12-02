Return-Path: <SRS0=N7dP=XR=semihalf.com=tn@kernel.org>
Return-Path: <SRS0=N7dP=XR=semihalf.com=tn@kernel.org>
Subject: Re: [PATCH v10 00/12] PCI: ARM64 ECAM quirks
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
References: <20161201075131.12247.2211.stgit@bhelgaas-glaptop.roam.corp.google.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Duc Dang <dhdang@apm.com>,
 Sinan Kaya <okaya@codeaurora.org>, Christopher Covington
 <cov@codeaurora.org>, Dongdong Liu <liudongdong3@huawei.com>
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <b59f12bb-fe22-e8ac-719c-d8fb12f31569@semihalf.com>
Date: Fri, 2 Dec 2016 15:20:28 +0100
MIME-Version: 1.0
In-Reply-To: <20161201075131.12247.2211.stgit@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 01.12.2016 09:29, Bjorn Helgaas wrote:
> This is what I've collected on my pci/ecam branch so far.  This is
> preliminary and probably doesn't even build since I made several
> changes, but at least it's a strawman.  I called it v10 to keep it
> separate from the previous postings of the various pieces.
>
>   ACPI: Add acpi_resource_consumer() to find device that claims a resource
>   PCI: Search ACPI namespace to ensure ECAM space is reserved
>   x86/PCI: Use acpi_resource_consumer() to search ACPI namespace for MMCFG
>
>     acpi_resource_consumer() takes a resource and returns an
>     acpi_device that has _CRS that contains the resource.  The idea is
>     that we call this on a resource from MCFG.  We *should* find a
>     PNP0C02 or other device that reserves that resource.  On x86 we
>     already do this in a more hand-coded way.  I probably wouldn't
>     merge the x86 patch for v4.10 but I included it here as an
>     example.
>
>     I don't think it's worth trying to fabricate ACPI devices or _CRS
>     resources to compensate for firmware that doesn't describe
>     everything.  This check will emit a warning if the MCFG region is
>     not reserved, and that's probably enough to motivate firmware
>     fixes for the next round of hardware.  The ECAM code itself does
>     reserve the region, so that part will be safe from other users.
>     Unreported non-ECAM register space is still a landmine and there's
>     no real way to look for it.
>
>   arm64: PCI: Manage controller-specific data on per-controller basis
>
>     Tomasz's fix for pci_acpi_scan_root(), unchanged.
>
>   PCI/ACPI: Extend pci_mcfg_lookup() to return ECAM config accessors
>   PCI/ACPI: Check for platform-specific MCFG quirks
>
>     Tomasz's quirk infrastructure.  I put this under
>     CONFIG_PCI_QUIRKS.
>
>   PCI/ACPI: Provide acpi_get_rc_resources() for ARM64 platform
>
>     Dongdong's interface to look up a _HID with a _UID matching the
>     segment.  I don't have an opinion on using _UID yet.  It's
>     encapsulated so it could be changed easily.  I put this under
>     CONFIG_PCI_QUIRKS && CONFIG_ARM64.
>
>   PCI: Add MCFG quirks for Qualcomm QDF2432 host controller
>
>     Christopher's Qualcomm quirks.  Basically unchanged except to put
>     the quirk ops under CONFIG_ACPI and CONFIG_PCI_QUIRKS.
>
>   PCI: Add MCFG quirks for HiSilicon Hip05/06/07 host controllers
>
>     Dongdong's HiSilicon quirks.  Here's where it gets interesting.  I
>     moved this to the existing pcie-hisi.c instead of adding
>     pcie-hisi-acpi.c.  I changed the Makefile so we always build
>     pcie-hisi.c on ARM64.  I added ifdefs so we get the quirk code if
>     CONFIG_ACPI and CONFIG_PCI_QUIRKS and we get the original platform
>     driver if CONFIG_PCI_HISI.  It's possible to have both, and if we
>     process the MCFG quirk we get the quirk code.
>
>     I'm confused about why the quirk accessors are so much different
>     than the original accessors.  hisi_pcie_acpi_rd_conf() looks much
>     different than hisi_pcie_cfg_read().  The original driver claims
>     Hipxx only supports 32-bit config accesses, but the quirk
>     accessors don't enforce that.
>
>   PCI: thunder-pem: Factor out resource lookup
>   PCI: Add MCFG quirks for Cavium ThunderX pass2.x host controller
>   PCI: Add MCFG quirks for Cavium ThunderX pass1.x host controller
>
>     Tomasz's ThunderX quirks.  I restructured the PEM init I could do
>     the same ifdef tricks as in hisi.  The quirks make a lot more
>     sense here -- they use the same accessors as the original platform
>     driver.  Only the initialization is different.
>
> The Makefile looks a little strange:
>
>   obj-$(CONFIG_ARM64) += pcie-hisi.o
>   obj-$(CONFIG_ARM64) += pci-thunder-ecam.o
>   obj-$(CONFIG_ARM64) += pci-thunder-pem.o

Hi Bjorn:

dmesg from ThunderX pass2.0 (1 socket board) + small fix:

diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
index d34d196..9e8fa4e 100644
--- a/drivers/acpi/pci_mcfg.c
+++ b/drivers/acpi/pci_mcfg.c
@@ -98,8 +98,8 @@ static struct mcfg_fixup mcfg_quirks[] = {
         { "CAVIUM", "THUNDERX", rev, seg, MCFG_BUS_ANY,                 \
         &pci_thunder_ecam_ops }
         /* SoC pass1.x */
-       THUNDER_PEM_QUIRK(2,  0),       /* off-chip devices */
-       THUNDER_PEM_QUIRK(2,  1),       /* off-chip devices */
+       THUNDER_PEM_QUIRK(2,  0UL),     /* off-chip devices */
+       THUNDER_PEM_QUIRK(2,  1UL),     /* off-chip devices */
         THUNDER_ECAM_QUIRK(2,  0),
         THUNDER_ECAM_QUIRK(2,  1),
         THUNDER_ECAM_QUIRK(2,  2),


EFI stub: Booting Linux Kernel...
EFI stub: Using DTB from configuration table
EFI stub: Exiting boot services and installing virtual address map...
Booting Linux on physical CPU 0x0
Linux version 4.9.0-rc7+ (tn@ThinkPad-Edge-E530) (gcc version 5.2.0 
(Cavium Inc. Version 0.99 build 401) ) #54 SMP PREEMPT Fri Dec 2 
12:56:56 CET 2016
Boot CPU: AArch64 Processor [431f0a10]
earlycon: pl11 at MMIO 0x000087e024000000 (options '')
bootconsole [pl11] enabled
efi: Getting EFI parameters from FDT:
efi: EFI v2.40 by Cavium Thunder cn88xx EFI 
ThunderX-Firmware-Release-1.22.12-build_04-2-g3ca4638 Nov 14 2016 09:57:1
efi:  ACPI=0xfffff000  ACPI 2.0=0xfffff014  SMBIOS 3.0=0x1ffaa58000
ACPI: Early table checksum verification disabled
ACPI: RSDP 0x00000000FFFFF014 000024 (v02 CAVIUM)
ACPI: XSDT 0x00000000FFFFE0E8 00006C (v01 CAVIUM THUNDERX 00000000 01000013)
ACPI: FACP 0x00000000FFFF7000 000114 (v06 CAVIUM THUNDERX 00000000 INTL 
20150717)
ACPI: DSDT 0x00000000FFFF8000 0020C5 (v02 CAVIUM THUNDERX 00000001 INTL 
20150717)
ACPI: APIC 0x00000000FFFFD000 000F68 (v03 CAVIUM THUNDERX 00000001 INTL 
20150717)
ACPI: SSDT 0x00000000FFFFC000 000158 (v02 CAVIUM CRB-1S   00000001 INTL 
20150717)
ACPI: DBG2 0x00000000FFFFB000 0000AA (v01 CAVIUM CN88XDBG 00000000 INTL 
20150717)
ACPI: GTDT 0x00000000FFFF5000 0000E0 (v02 CAVIUM THUNDERX 00000001 INTL 
20150717)
ACPI: IORT 0x00000000FFFF3000 0013D4 (v01 CAVIUM THUNDERX 00000001 INTL 
20150717)
ACPI: MCFG 0x00000000FFFF2000 00006C (v01 CAVIUM THUNDERX 00000001 INTL 
20150717)
ACPI: SLIT 0x00000000FFFF1000 000030 (v01 CAVIUM TEMPLATE 00000001 INTL 
20150717)
ACPI: SPCR 0x00000000FFFF0000 000050 (v02 CAVIUM THUNDERX 00000001 INTL 
20150717)
ACPI: SPCR: console: pl011,mmio,0x87e024000000,115200
ACPI: NUMA: Failed to initialise from firmware
NUMA: Faking a node at [mem 0x0000000000000000-0x0000001fffffffff]
NUMA: Adding memblock [0x1400000 - 0xfffeffff] on node 0
NUMA: Adding memblock [0xffff0000 - 0xffffffff] on node 0
NUMA: Adding memblock [0x100000000 - 0x1ffaa4ffff] on node 0
NUMA: Adding memblock [0x1ffaa50000 - 0x1ffaa7ffff] on node 0
NUMA: Adding memblock [0x1ffaa80000 - 0x1fffa3ffff] on node 0
NUMA: Adding memblock [0x1fffa40000 - 0x1fffa8ffff] on node 0
NUMA: Adding memblock [0x1fffa90000 - 0x1fffffffff] on node 0
NUMA: Initmem setup node 0 [mem 0x01400000-0x1fffffffff]
NUMA: NODE_DATA [mem 0x1fffffe200-0x1fffffffff]
Zone ranges:
   DMA      [mem 0x0000000001400000-0x00000000ffffffff]
   Normal   [mem 0x0000000100000000-0x0000001fffffffff]
Movable zone start for each node
Early memory node ranges
   node   0: [mem 0x0000000001400000-0x00000000fffeffff]
   node   0: [mem 0x00000000ffff0000-0x00000000ffffffff]
   node   0: [mem 0x0000000100000000-0x0000001ffaa4ffff]
   node   0: [mem 0x0000001ffaa50000-0x0000001ffaa7ffff]
   node   0: [mem 0x0000001ffaa80000-0x0000001fffa3ffff]
   node   0: [mem 0x0000001fffa40000-0x0000001fffa8ffff]
   node   0: [mem 0x0000001fffa90000-0x0000001fffffffff]
Initmem setup node 0 [mem 0x0000000001400000-0x0000001fffffffff]
psci: probing for conduit method from ACPI.
psci: PSCIv0.2 detected in firmware.
psci: Using standard PSCI v0.2 function IDs
psci: Trusted OS resident on physical CPU 0x0
percpu: Embedded 2 pages/cpu @ffff801ff76f0000 s48256 r8192 d74624 u131072
Detected VIPT I-cache on CPU0
CPU features: enabling workaround for Cavium erratum 27456
Built 1 zonelists in Node order, mobility grouping on.  Total pages: 2094784
Policy zone: Normal
Kernel command line: BOOT_IMAGE=(tftp)efi/Image_tn root=/dev/sda2 rw 
console=ttyAMA0 earlycon=pl011,0x87e024000000 kgdboc=ttyAMA0,115200 
uefi_debug acpi=force
log_buf_len individual max cpu contribution: 4096 bytes
log_buf_len total cpu_extra contributions: 192512 bytes
log_buf_len min size: 16384 bytes
log_buf_len: 262144 bytes
early log buf free: 10892(66%)
PID hash table entries: 4096 (order: -1, 32768 bytes)
software IO TLB [mem 0xfbfe0000-0xfffe0000] (64MB) mapped at 
[ffff8000fbfe0000-ffff8000fffdffff]
Memory: 133978304K/134197248K available (8572K kernel code, 722K rwdata, 
3136K rodata, 640K init, 647K bss, 218944K reserved, 0K cma-reserved)
Virtual kernel memory layout:
     modules : 0xffff000000000000 - 0xffff000008000000   (   128 MB)
     vmalloc : 0xffff000008000000 - 0xffff7bdfffff0000   (126847 GB)
       .text : 0xffff000008080000 - 0xffff0000088e0000   (  8576 KB)
     .rodata : 0xffff0000088e0000 - 0xffff000008c00000   (  3200 KB)
       .init : 0xffff000008c00000 - 0xffff000008ca0000   (   640 KB)
       .data : 0xffff000008ca0000 - 0xffff000008d54a00   (   723 KB)
        .bss : 0xffff000008d54a00 - 0xffff000008df6968   (   648 KB)
     fixed   : 0xffff7fdffe7d0000 - 0xffff7fdffec00000   (  4288 KB)
     PCI I/O : 0xffff7fdffee00000 - 0xffff7fdfffe00000   (    16 MB)
     vmemmap : 0xffff7fe000000000 - 0xffff800000000000   (   128 GB maximum)
               0xffff7fe000005000 - 0xffff7fe008000000   (   127 MB actual)
     memory  : 0xffff800001400000 - 0xffff802000000000   (131052 MB)
SLUB: HWalign=128, Order=0-3, MinObjects=0, CPUs=48, Nodes=1
Preemptible hierarchical RCU implementation.
RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=48
NR_IRQS:64 nr_irqs:64 0
GICv3: GIC: Using split EOI/Deactivate mode
ITS [mem 0x801000020000-0x80100003ffff]
ITS@0x0000801000020000: allocated 2097152 Devices @1fc1000000 (flat, esz 
8, psz 64K, shr 1)
GIC: using LPI property table @0x0000001fc0060000
ITS: Allocated 32512 chunks for LPIs
GICv3: CPU0: found redistributor 0 region 0:0x0000801080000000
CPU0: using LPI pending table @0x0000001fc0070000
arm_arch_timer: Architected cp15 timer(s) running at 100.00MHz (phys).
clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 
0x171024e7e0, max_idle_ns: 440795205315 ns
sched_clock: 56 bits at 100MHz, resolution 10ns, wraps every 4398046511100ns
Console: colour dummy device 80x25
Calibrating delay loop (skipped), value calculated using timer 
frequency.. 200.00 BogoMIPS (lpj=400000)
pid_max: default: 49152 minimum: 384
ACPI: Core revision 20160831
ACPI: 2 ACPI AML tables successfully acquired and loaded
Security Framework initialized
Dentry cache hash table entries: 16777216 (order: 11, 134217728 bytes)
Inode-cache hash table entries: 8388608 (order: 10, 67108864 bytes)
Mount-cache hash table entries: 262144 (order: 5, 2097152 bytes)
Mountpoint-cache hash table entries: 262144 (order: 5, 2097152 bytes)
ASID allocator initialised with 65536 entries
PCI/MSI: ITS@0x801000020000 domain created
Remapping and enabling EFI services.
   EFI remap 0x0000001ffaa52000 => 0000000020002000
   EFI remap 0x0000001ffaa53000 => 0000000020003000
   EFI remap 0x0000001ffaa57000 => 0000000020007000
   EFI remap 0x0000001fffa42000 => 0000000020032000
   EFI remap 0x0000001fffa56000 => 0000000020046000
   EFI remap 0x0000804000001000 => 0000000020081000
   EFI remap 0x000087e0d2001000 => 0000000020091000
Detected VIPT I-cache on CPU1
GICv3: CPU1: found redistributor 1 region 0:0x0000801080020000
CPU1: using LPI pending table @0x0000001fcd880000
CPU1: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU2
GICv3: CPU2: found redistributor 2 region 0:0x0000801080040000
CPU2: using LPI pending table @0x0000001fcd8a0000
CPU2: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU3
GICv3: CPU3: found redistributor 3 region 0:0x0000801080060000
CPU3: using LPI pending table @0x0000001fcd8b0000
CPU3: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU4
GICv3: CPU4: found redistributor 4 region 0:0x0000801080080000
CPU4: using LPI pending table @0x0000001fcd8f0000
CPU4: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU5
GICv3: CPU5: found redistributor 5 region 0:0x00008010800a0000
CPU5: using LPI pending table @0x0000001fcd900000
CPU5: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU6
GICv3: CPU6: found redistributor 6 region 0:0x00008010800c0000
CPU6: using LPI pending table @0x0000001fcd930000
CPU6: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU7
GICv3: CPU7: found redistributor 7 region 0:0x00008010800e0000
CPU7: using LPI pending table @0x0000001fcd940000
CPU7: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU8
GICv3: CPU8: found redistributor 8 region 0:0x0000801080100000
CPU8: using LPI pending table @0x0000001fcd960000
CPU8: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU9
GICv3: CPU9: found redistributor 9 region 0:0x0000801080120000
CPU9: using LPI pending table @0x0000001fcda00000
CPU9: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU10
GICv3: CPU10: found redistributor a region 0:0x0000801080140000
CPU10: using LPI pending table @0x0000001fcda10000
CPU10: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU11
GICv3: CPU11: found redistributor b region 0:0x0000801080160000
CPU11: using LPI pending table @0x0000001fcda60000
CPU11: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU12
GICv3: CPU12: found redistributor c region 0:0x0000801080180000
CPU12: using LPI pending table @0x0000001fcda70000
CPU12: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU13
GICv3: CPU13: found redistributor d region 0:0x00008010801a0000
CPU13: using LPI pending table @0x0000001fcdb10000
CPU13: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU14
GICv3: CPU14: found redistributor e region 0:0x00008010801c0000
CPU14: using LPI pending table @0x0000001fcdb20000
CPU14: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU15
GICv3: CPU15: found redistributor f region 0:0x00008010801e0000
CPU15: using LPI pending table @0x0000001fcdb40000
CPU15: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU16
GICv3: CPU16: found redistributor 100 region 0:0x0000801080200000
CPU16: using LPI pending table @0x0000001fcdb60000
CPU16: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU17
GICv3: CPU17: found redistributor 101 region 0:0x0000801080220000
CPU17: using LPI pending table @0x0000001fcdc20000
CPU17: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU18
GICv3: CPU18: found redistributor 102 region 0:0x0000801080240000
CPU18: using LPI pending table @0x0000001fcdc30000
CPU18: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU19
GICv3: CPU19: found redistributor 103 region 0:0x0000801080260000
CPU19: using LPI pending table @0x0000001fcdc60000
CPU19: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU20
GICv3: CPU20: found redistributor 104 region 0:0x0000801080280000
CPU20: using LPI pending table @0x0000001fcdc70000
CPU20: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU21
GICv3: CPU21: found redistributor 105 region 0:0x00008010802a0000
CPU21: using LPI pending table @0x0000001fcdc90000
CPU21: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU22
GICv3: CPU22: found redistributor 106 region 0:0x00008010802c0000
CPU22: using LPI pending table @0x0000001fcdcb0000
CPU22: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU23
GICv3: CPU23: found redistributor 107 region 0:0x00008010802e0000
CPU23: using LPI pending table @0x0000001fcdcc0000
CPU23: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU24
GICv3: CPU24: found redistributor 108 region 0:0x0000801080300000
CPU24: using LPI pending table @0x0000001fcdd80000
CPU24: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU25
GICv3: CPU25: found redistributor 109 region 0:0x0000801080320000
CPU25: using LPI pending table @0x0000001fcdd90000
CPU25: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU26
GICv3: CPU26: found redistributor 10a region 0:0x0000801080340000
CPU26: using LPI pending table @0x0000001fcddc0000
CPU26: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU27
GICv3: CPU27: found redistributor 10b region 0:0x0000801080360000
CPU27: using LPI pending table @0x0000001fcddd0000
CPU27: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU28
GICv3: CPU28: found redistributor 10c region 0:0x0000801080380000
CPU28: using LPI pending table @0x0000001fcde80000
CPU28: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU29
GICv3: CPU29: found redistributor 10d region 0:0x00008010803a0000
CPU29: using LPI pending table @0x0000001fcde90000
CPU29: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU30
GICv3: CPU30: found redistributor 10e region 0:0x00008010803c0000
CPU30: using LPI pending table @0x0000001fcdeb0000
CPU30: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU31
GICv3: CPU31: found redistributor 10f region 0:0x00008010803e0000
CPU31: using LPI pending table @0x0000001fcdef0000
CPU31: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU32
GICv3: CPU32: found redistributor 200 region 0:0x0000801080400000
CPU32: using LPI pending table @0x0000001fcdf10000
CPU32: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU33
GICv3: CPU33: found redistributor 201 region 0:0x0000801080420000
CPU33: using LPI pending table @0x0000001fcdf40000
CPU33: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU34
GICv3: CPU34: found redistributor 202 region 0:0x0000801080440000
CPU34: using LPI pending table @0x0000001fcdf50000
CPU34: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU35
GICv3: CPU35: found redistributor 203 region 0:0x0000801080460000
CPU35: using LPI pending table @0x0000001fcdf70000
CPU35: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU36
GICv3: CPU36: found redistributor 204 region 0:0x0000801080480000
CPU36: using LPI pending table @0x0000001fce010000
CPU36: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU37
GICv3: CPU37: found redistributor 205 region 0:0x00008010804a0000
CPU37: using LPI pending table @0x0000001fce060000
CPU37: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU38
GICv3: CPU38: found redistributor 206 region 0:0x00008010804c0000
CPU38: using LPI pending table @0x0000001fce070000
CPU38: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU39
GICv3: CPU39: found redistributor 207 region 0:0x00008010804e0000
CPU39: using LPI pending table @0x0000001fce110000
CPU39: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU40
GICv3: CPU40: found redistributor 208 region 0:0x0000801080500000
CPU40: using LPI pending table @0x0000001fce120000
CPU40: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU41
GICv3: CPU41: found redistributor 209 region 0:0x0000801080520000
CPU41: using LPI pending table @0x0000001fce140000
CPU41: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU42
GICv3: CPU42: found redistributor 20a region 0:0x0000801080540000
CPU42: using LPI pending table @0x0000001fce160000
CPU42: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU43
GICv3: CPU43: found redistributor 20b region 0:0x0000801080560000
CPU43: using LPI pending table @0x0000001fce170000
CPU43: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU44
GICv3: CPU44: found redistributor 20c region 0:0x0000801080580000
CPU44: using LPI pending table @0x0000001fce230000
CPU44: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU45
GICv3: CPU45: found redistributor 20d region 0:0x00008010805a0000
CPU45: using LPI pending table @0x0000001fce240000
CPU45: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU46
GICv3: CPU46: found redistributor 20e region 0:0x00008010805c0000
CPU46: using LPI pending table @0x0000001fce270000
CPU46: Booted secondary processor [431f0a10]
Detected VIPT I-cache on CPU47
GICv3: CPU47: found redistributor 20f region 0:0x00008010805e0000
CPU47: using LPI pending table @0x0000001fce290000
CPU47: Booted secondary processor [431f0a10]
Brought up 48 CPUs
SMP: Total of 48 processors activated.
CPU features: detected feature: GIC system register CPU interface
CPU features: detected feature: Software prefetching using PRFM
CPU: All CPU(s) started at EL2
alternatives: patching kernel code
devtmpfs: initialized
SMBIOS 3.0.0 present.
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, 
max_idle_ns: 7645041785100000 ns
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
cpuidle: using governor ladder
cpuidle: using governor menu
vdso: 2 pages (1 code @ ffff000008900000, 1 data @ ffff000008cb0000)
hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
DMA: preallocated 256 KiB pool for atomic allocations
ACPI: bus type PCI registered
Serial: AMBA PL011 UART driver
HugeTLB registered 2 MB page size, pre-allocated 0 pages
HugeTLB registered 512 MB page size, pre-allocated 0 pages
ACPI: Added _OSI(Module Device)
ACPI: Added _OSI(Processor Device)
ACPI: Added _OSI(3.0 _SCP Extensions)
ACPI: Added _OSI(Processor Aggregator Device)
ACPI: Interpreter enabled
ACPI: Using GIC for interrupt routing
ACPI: MCFG table detected, 4 entries
ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-1f])
acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments 
MSI]
acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug PME AER]
acpi PNP0A08:00: _OSC: OS now controls [PCIeCapability]
acpi PNP0A08:00: ECAM area [mem 0x848000000000-0x848001ffffff] reserved 
by THRX0001:00
acpi PNP0A08:00: ECAM at [mem 0x848000000000-0x848001ffffff] for [bus 00-1f]
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [mem 0x801000000000-0x807fffffffff 
window]
pci_bus 0000:00: root bus resource [mem 0x838000000000-0x841fffffffff 
window]
pci_bus 0000:00: root bus resource [mem 0x846000000000-0x847fffffffff 
window]
pci_bus 0000:00: root bus resource [mem 0x868000000000-0x87e023ffffff 
window]
pci_bus 0000:00: root bus resource [mem 0x87e026000000-0x87e0bfffffff 
window]
pci_bus 0000:00: root bus resource [mem 0x87e0c6000000-0x87ffffffffff 
window]
pci_bus 0000:00: root bus resource [bus 00-1f]
pci 0000:00:09.0: VF(n) BAR0 space: [mem 0x840000800000-0x8400008fffff 
64bit] (contains BAR0 for 1 VFs)
pci 0000:01:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable 
it with 'pcie_aspm=force'
pci 0000:02:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable 
it with 'pcie_aspm=force'
pci 0000:03:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable 
it with 'pcie_aspm=force'
pci 0000:04:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable 
it with 'pcie_aspm=force'
pci 0000:00:01.0: PCI bridge to [bus 01]
pci 0000:00:14.0: PCI bridge to [bus 02]
pci 0000:00:15.0: PCI bridge to [bus 03]
pci 0000:00:16.0: PCI bridge to [bus 04]
ACPI: PCI Root Bridge [PCI1] (domain 0001 [bus 00-1f])
acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments 
MSI]
acpi PNP0A08:01: _OSC: platform does not support [PCIeHotplug PME AER]
acpi PNP0A08:01: _OSC: OS now controls [PCIeCapability]
acpi PNP0A08:01: ECAM area [mem 0x849000000000-0x849001ffffff] reserved 
by THRX0001:01
acpi PNP0A08:01: ECAM at [mem 0x849000000000-0x849001ffffff] for [bus 00-1f]
PCI host bridge to bus 0001:00
pci_bus 0001:00: root bus resource [mem 0x810000000000-0x817fffffffff 
window]
pci_bus 0001:00: root bus resource [bus 00-1f]
ACPI: PCI Root Bridge [PCI2] (domain 0002 [bus 00-1f])
acpi PNP0A08:02: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments 
MSI]
acpi PNP0A08:02: _OSC: platform does not support [PCIeHotplug PME AER]
acpi PNP0A08:02: _OSC: OS now controls [PCIeCapability]
acpi PNP0A08:02: ECAM area [mem 0x84a000000000-0x84a001ffffff] reserved 
by THRX0001:02
acpi PNP0A08:02: ECAM at [mem 0x84a000000000-0x84a001ffffff] for [bus 00-1f]
PCI host bridge to bus 0002:00
pci_bus 0002:00: root bus resource [mem 0x842000000000-0x843fffffffff 
window]
pci_bus 0002:00: root bus resource [bus 00-1f]
pci 0002:01:00.0: VF(n) BAR0 space: [mem 0x8430a0000000-0x8430afffffff 
64bit] (contains BAR0 for 128 VFs)
pci 0002:01:00.0: VF(n) BAR4 space: [mem 0x8430e0000000-0x8430efffffff 
64bit] (contains BAR4 for 128 VFs)
pci 0002:01:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable 
it with 'pcie_aspm=force'
pci 0002:00:02.0: PCI bridge to [bus 01]
ACPI: PCI Root Bridge [PCI3] (domain 0003 [bus 00-1f])
acpi PNP0A08:03: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments 
MSI]
acpi PNP0A08:03: _OSC: platform does not support [PCIeHotplug PME AER]
acpi PNP0A08:03: _OSC: OS now controls [PCIeCapability]
acpi PNP0A08:03: ECAM area [mem 0x84b000000000-0x84b001ffffff] reserved 
by THRX0001:03
acpi PNP0A08:03: ECAM at [mem 0x84b000000000-0x84b001ffffff] for [bus 00-1f]
PCI host bridge to bus 0003:00
pci_bus 0003:00: root bus resource [mem 0x818000000000-0x81ffffffffff 
window]
pci_bus 0003:00: root bus resource [bus 00-1f]
ACPI: PCI Root Bridge [PEM0] (domain 0004 [bus 1f-57])
acpi PNP0A08:04: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments 
MSI]
acpi PNP0A08:04: _OSC: platform does not support [PCIeHotplug PME AER]
acpi PNP0A08:04: _OSC: OS now controls [PCIeCapability]
acpi PNP0A08:04: MCFG quirk: ECAM at [mem 0x88001f000000-0x880057ffffff] 
for [bus 1f-57] with thunder_pem_ecam_ops
acpi PNP0A08:04: ECAM area [mem 0x88001f000000-0x880057ffffff] reserved 
by THRX0002:00
acpi PNP0A08:04: ECAM at [mem 0x88001f000000-0x880057ffffff] for [bus 1f-57]
Remapped I/O 0x0000883000000000 to [io  0x0000-0xffff window]
PCI host bridge to bus 0004:1f
pci_bus 0004:1f: root bus resource [io  0x0000-0xffff window]
pci_bus 0004:1f: root bus resource [mem 0x881010000000-0x881fffffffff 
window] (bus address [0x10000000-0xfffffffff])
pci_bus 0004:1f: root bus resource [mem 0x882000000000-0x882fffffffff 
pref window] (bus address [0x1000000000-0x1fffffffff])
pci_bus 0004:1f: root bus resource [mem 0x87e0c0000000-0x87e0c0ffffff 
window]
pci_bus 0004:1f: root bus resource [bus 1f-57]
pci 0004:1f:00.0: Primary bus is hard wired to 0
pci 0004:20:00.0: can't set Max Payload Size to 256; if necessary, use 
"pci=pcie_bus_safe" and report a bug
pci 0004:20:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable 
it with 'pcie_aspm=force'
pci 0004:1f:00.0: Primary bus is hard wired to 0
pci 0004:1f:00.0: BAR 14: assigned [mem 0x881010000000-0x8810117fffff]
pci 0004:1f:00.0: BAR 6: assigned [mem 0x881011800000-0x88101180ffff pref]
pci 0004:1f:00.0: BAR 13: assigned [io  0x1000-0x1fff]
pci 0004:20:00.0: BAR 14: assigned [mem 0x881010000000-0x8810117fffff]
pci 0004:20:00.0: BAR 13: assigned [io  0x1000-0x1fff]
pci 0004:21:00.0: BAR 0: assigned [mem 0x881010000000-0x881010ffffff]
pci 0004:21:00.0: BAR 1: assigned [mem 0x881011000000-0x88101101ffff]
pci 0004:21:00.0: BAR 2: assigned [io  0x1000-0x107f]
pci 0004:20:00.0: PCI bridge to [bus 21]
pci 0004:20:00.0:   bridge window [io  0x1000-0x1fff]
pci 0004:20:00.0:   bridge window [mem 0x881010000000-0x8810117fffff]
pci 0004:1f:00.0: PCI bridge to [bus 20-57]
pci 0004:1f:00.0:   bridge window [io  0x1000-0x1fff]
pci 0004:1f:00.0:   bridge window [mem 0x881010000000-0x8810117fffff]
ACPI: PCI Interrupt Link [LN0A] (IRQs *48)
ACPI: PCI Interrupt Link [LN0B] (IRQs *49)
ACPI: PCI Interrupt Link [LN0C] (IRQs *50)
ACPI: PCI Interrupt Link [LN0D] (IRQs *51)
ACPI: PCI Root Bridge [PEM2] (domain 0006 [bus 8f-c7])
acpi PNP0A08:06: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments 
MSI]
acpi PNP0A08:06: _OSC: platform does not support [PCIeHotplug PME AER]
acpi PNP0A08:06: _OSC: OS now controls [PCIeCapability]
acpi PNP0A08:06: MCFG quirk: ECAM at [mem 0x88808f000000-0x8880c7ffffff] 
for [bus 8f-c7] with thunder_pem_ecam_ops
acpi PNP0A08:06: ECAM area [mem 0x88808f000000-0x8880c7ffffff] reserved 
by THRX0002:02
acpi PNP0A08:06: ECAM at [mem 0x88808f000000-0x8880c7ffffff] for [bus 8f-c7]
Remapped I/O 0x000088b000020000 to [io  0x10000-0x1ffff window]
PCI host bridge to bus 0006:8f
pci_bus 0006:8f: root bus resource [io  0x10000-0x1ffff window] (bus 
address [0x20000-0x2ffff])
pci_bus 0006:8f: root bus resource [mem 0x889010000000-0x889fffffffff 
window] (bus address [0x10000000-0xfffffffff])
pci_bus 0006:8f: root bus resource [mem 0x88a000000000-0x88afffffffff 
pref window] (bus address [0x1000000000-0x1fffffffff])
pci_bus 0006:8f: root bus resource [mem 0x87e0c2000000-0x87e0c2ffffff 
window]
pci_bus 0006:8f: root bus resource [bus 8f-c7]
pci 0006:8f:00.0: Primary bus is hard wired to 0
pci 0006:90:00.0: Max Payload Size set to 256 (was 128, max 512)
pci 0006:90:00.0: VF(n) BAR0 space: [mem 0x00000000-0x003fffff 64bit] 
(contains BAR0 for 64 VFs)
pci 0006:90:00.0: VF(n) BAR3 space: [mem 0x00000000-0x003fffff 64bit] 
(contains BAR3 for 64 VFs)
pci 0006:8f:00.0: Primary bus is hard wired to 0
pci 0006:8f:00.0: BAR 14: assigned [mem 0x889010000000-0x8890107fffff]
pci 0006:8f:00.0: BAR 15: assigned [mem 0x88a000000000-0x88a0000fffff 
64bit pref]
pci 0006:8f:00.0: BAR 6: assigned [mem 0x889010800000-0x88901080ffff pref]
pci 0006:8f:00.0: BAR 13: assigned [io  0x10000-0x10fff]
pci 0006:90:00.0: BAR 0: assigned [mem 0x88a000000000-0x88a00007ffff 
64bit pref]
pci 0006:90:00.0: BAR 7: assigned [mem 0x889010000000-0x8890103fffff 64bit]
pci 0006:90:00.0: BAR 10: assigned [mem 0x889010400000-0x8890107fffff 64bit]
pci 0006:90:00.0: BAR 4: assigned [mem 0x88a000080000-0x88a000083fff 
64bit pref]
pci 0006:90:00.0: BAR 2: assigned [io  0x10000-0x1001f]
pci 0006:8f:00.0: PCI bridge to [bus 90-c7]
pci 0006:8f:00.0:   bridge window [io  0x10000-0x10fff]
pci 0006:8f:00.0:   bridge window [mem 0x889010000000-0x8890107fffff]
pci 0006:8f:00.0:   bridge window [mem 0x88a000000000-0x88a0000fffff 
64bit pref]
ACPI: PCI Interrupt Link [LN0A] (IRQs *56)
ACPI: PCI Interrupt Link [LN0B] (IRQs *57)
ACPI: PCI Interrupt Link [LN0C] (IRQs *58)
ACPI: PCI Interrupt Link [LN0D] (IRQs *59)
ARMH0011:00: ttyAMA0 at MMIO 0x87e024000000 (irq = 10, base_baud = 0) is 
a SBSA
console [ttyAMA0] enabled
console [ttyAMA0] enabled
bootconsole [pl11] disabled
bootconsole [pl11] disabled
ARMH0011:01: ttyAMA1 at MMIO 0x87e025000000 (irq = 11, base_baud = 0) is 
a SBSA
vgaarb: device added: PCI:0004:21:00.0,decodes=io+mem,owns=none,locks=none
vgaarb: loaded
vgaarb: bridge control possible 0004:21:00.0
SCSI subsystem initialized
ACPI: bus type USB registered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti 
<giometti@linux.it>
PTP clock support registered
Registered efivars operations
clocksource: Switched to clocksource arch_sys_counter
VFS: Disk quotas dquot_6.6.0
VFS: Dquot-cache hash table entries: 8192 (order 0, 65536 bytes)
pnp: PnP ACPI init
system 00:00: [mem 0x848000000000-0x848001ffffff] could not be reserved
system 00:01: [mem 0x849000000000-0x849001ffffff] could not be reserved
system 00:02: [mem 0x84a000000000-0x84a001ffffff] could not be reserved
system 00:03: [mem 0x84b000000000-0x84b001ffffff] could not be reserved
system 00:04: [mem 0x87e0c0000000-0x87e0c0ffffff] could not be reserved
system 00:04: [mem 0x88001f000000-0x880057ffffff] could not be reserved
system 00:05: [mem 0x87e0c2000000-0x87e0c2ffffff] could not be reserved
system 00:05: [mem 0x88808f000000-0x8880c7ffffff] could not be reserved
pnp: PnP ACPI: found 6 devices
NET: Registered protocol family 2
TCP established hash table entries: 524288 (order: 6, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 4, 1048576 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
UDP hash table entries: 65536 (order: 5, 2097152 bytes)
UDP-Lite hash table entries: 65536 (order: 5, 2097152 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
kvm [1]: 16-bit VMID
kvm [1]: IDMAP page: 1cca000
kvm [1]: HYP VA range: 800000000000:ffffffffffff
kvm [1]: Hyp mode initialized successfully
kvm [1]: GICv3: no GICV resource entry
kvm [1]: disabling GICv2 emulation
kvm [1]: GIC system register CPU interface enabled
kvm [1]: vgic interrupt IRQ1
kvm [1]: Invalid trigger for IRQ4, assuming level low
kvm [1]: virtual timer IRQ4
futex hash table entries: 16384 (order: 5, 2097152 bytes)
audit: initializing netlink subsys (disabled)
audit: type=2000 audit(6.980:1): initialized
workingset: timestamp_bits=44 max_order=21 bucket_order=0
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
nfs4filelayout_init: NFSv4 File Layout Driver Registering...
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
fuse init (API version 7.26)
9p: Installing v9fs 9p2000 file system support
io scheduler noop registered
io scheduler cfq registered (default)
ACPI: PCI Interrupt Link [LN0A] enabled at IRQ 48
pcieport 0004:1f:00.0: enabling device (0506 -> 0507)
ACPI: PCI Interrupt Link [LN0A] enabled at IRQ 56
pcieport 0006:8f:00.0: enabling device (0506 -> 0507)
acpi-ged ACPI0013:00: GED listening GSI 32 @ IRQ 12
input: Power Button as 
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
ACPI: Power Button [PWRB]
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
msm_serial: driver initialized
Failed to find cpu0 device node
Unable to detect cache hierarchy from DT for CPU 0
loop: module loaded
ahci 0001:00:08.0: AHCI 0001.0300 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
ahci 0001:00:08.0: flags: 64bit ncq sntf ilck pm led clo only pmp fbs 
pio slum part ccc apst
ahci 0001:00:08.0: port 0 is not capable of FBS
scsi host0: ahci
ata1: SATA max UDMA/133 abar m2097152@0x814000000000 port 0x814000000100 
irq 14
ahci 0001:00:09.0: AHCI 0001.0300 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
ahci 0001:00:09.0: flags: 64bit ncq sntf ilck pm led clo only pmp fbs 
pio slum part ccc apst
ahci 0001:00:09.0: port 0 is not capable of FBS
scsi host1: ahci
ata2: SATA max UDMA/133 abar m2097152@0x815000000000 port 0x815000000100 
irq 15
ahci 0001:00:0a.0: AHCI 0001.0300 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
ahci 0001:00:0a.0: flags: 64bit ncq sntf ilck pm led clo only pmp fbs 
pio slum part ccc apst
ahci 0001:00:0a.0: port 0 is not capable of FBS
scsi host2: ahci
ata3: SATA max UDMA/133 abar m2097152@0x816000000000 port 0x816000000100 
irq 16
ahci 0001:00:0b.0: AHCI 0001.0300 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
ahci 0001:00:0b.0: flags: 64bit ncq sntf ilck pm led clo only pmp fbs 
pio slum part ccc apst
ahci 0001:00:0b.0: port 0 is not capable of FBS
scsi host3: ahci
ata4: SATA max UDMA/133 abar m2097152@0x817000000000 port 0x817000000100 
irq 17
libphy: Fixed MDIO Bus: probed
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
thunder-xcv, ver 1.0
thunder-BGX, ver 1.0
thunder-BGX 0000:01:10.0: BGX0 QLM mode: XLAUI
thunder-BGX 0000:01:10.0: MAC address set to: 40:8d:5c:ba:b8:ea
thunder-BGX 0000:01:10.1: BGX1 QLM mode: XFI
thunder-BGX 0000:01:10.1: MAC address set to: 40:8d:5c:ba:b8:eb
thunder-BGX 0000:01:10.1: MAC address set to: 40:8d:5c:ba:b8:ec
thunder-nic, ver 1.0
thunder-nic 0002:01:00.0: SRIOV enabled, number of VF available 36
thunder-nicvf, ver 1.0
thunder-nicvf 0002:01:00.1: enabling device (0004 -> 0006)
thunder-nicvf 0002:01:00.2: enabling device (0004 -> 0006)
thunder-nicvf 0002:01:00.3: enabling device (0004 -> 0006)
thunder-nicvf 0002:01:00.4: enabling device (0004 -> 0006)
thunder-nicvf 0002:01:00.5: enabling device (0004 -> 0006)
thunder-nicvf 0002:01:00.6: enabling device (0004 -> 0006)
ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata1.00: ATA-8: WDC WD5003ABYZ-011FA0, 01.01S03, max UDMA/133
ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
ata1.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      WDC WD5003ABYZ-0 1S03 PQ: 0 ANSI: 5
ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata2.00: ATA-9: WDC WD5000AZLX-00CL5A0, 01.01A01, max UDMA/133
ata2.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
ata2.00: configured for UDMA/133
sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/466 GiB)
scsi 1:0:0:0: Direct-Access     ATA      WDC WD5000AZLX-0 1A01 PQ: 0 ANSI: 5
ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata3.00: ATA-8: WDC WD5003ABYZ-011FA0, 01.01S03, max UDMA/133
ata3.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
ata3.00: configured for UDMA/133
thunder-nicvf 0002:01:00.7: enabling device (0004 -> 0006)
ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
sd 0:0:0:0: [sda] Write Protect is off
ata4.00: ATA-8: OCZ-VERTEX3, 2.25, max UDMA/133
ata4.00: 234441648 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
thunder-nicvf 0002:01:01.0: enabling device (0004 -> 0006)
ata4.00: configured for UDMA/133
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 1:0:0:0: [sdb] 976773168 512-byte logical blocks: (500 GB/466 GiB)
scsi 2:0:0:0: Direct-Access     ATA      WDC WD5003ABYZ-0 1S03 PQ: 0 ANSI: 5
sd 1:0:0:0: [sdb] 4096-byte physical blocks
thunder-nicvf 0002:01:01.1: enabling device (0004 -> 0006)
sd 1:0:0:0: [sdb] Write Protect is off
  sda: sda1 sda2 sda3
sd 0:0:0:0: [sda] Attached SCSI disk
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 2:0:0:0: [sdc] 976773168 512-byte logical blocks: (500 GB/466 GiB)
scsi 3:0:0:0: Direct-Access     ATA      OCZ-VERTEX3      2.25 PQ: 0 ANSI: 5
thunder-nicvf 0002:01:01.2: enabling device (0004 -> 0006)
sd 1:0:0:0: [sdb] Attached SCSI disk
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
thunder-nicvf 0002:01:01.3: enabling device (0004 -> 0006)
sd 3:0:0:0: [sdd] 234441648 512-byte logical blocks: (120 GB/112 GiB)
sd 3:0:0:0: [sdd] Write Protect is off
sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sdc: sdc1 sdc2 sdc3
  sdd: sdd1
sd 3:0:0:0: [sdd] Attached SCSI disk
sd 2:0:0:0: [sdc] Attached SCSI disk
thunder-nicvf 0002:01:01.4: enabling device (0004 -> 0006)
thunder-nicvf 0002:01:01.5: enabling device (0004 -> 0006)
thunder-nicvf 0002:01:01.6: enabling device (0004 -> 0006)
thunder-nicvf 0002:01:01.7: enabling device (0004 -> 0006)
thunder-nicvf 0002:01:02.0: enabling device (0004 -> 0006)
thunder-nicvf 0002:01:02.1: enabling device (0004 -> 0006)
thunder-nicvf 0002:01:02.2: enabling device (0004 -> 0006)
thunder-nicvf 0002:01:02.3: enabling device (0004 -> 0006)
thunder-nicvf 0002:01:02.4: enabling device (0004 -> 0006)
thunder-nicvf 0002:01:02.5: enabling device (0004 -> 0006)
thunder-nicvf 0002:01:02.6: enabling device (0004 -> 0006)
thunder-nicvf 0002:01:02.7: enabling device (0004 -> 0006)
thunder-nicvf 0002:01:03.0: enabling device (0004 -> 0006)
thunder-nicvf 0002:01:03.1: enabling device (0004 -> 0006)
thunder-nicvf 0002:01:03.2: enabling device (0004 -> 0006)
thunder-nicvf 0002:01:03.3: enabling device (0004 -> 0006)
thunder-nicvf 0002:01:03.4: enabling device (0004 -> 0006)
thunder-nicvf 0002:01:03.5: enabling device (0004 -> 0006)
thunder-nicvf 0002:01:03.6: enabling device (0004 -> 0006)
thunder-nicvf 0002:01:03.7: enabling device (0004 -> 0006)
thunder-nicvf 0002:01:04.0: enabling device (0004 -> 0006)
thunder-nicvf 0002:01:04.1: enabling device (0004 -> 0006)
thunder-nicvf 0002:01:04.2: enabling device (0004 -> 0006)
thunder-nicvf 0002:01:04.3: enabling device (0004 -> 0006)
thunder-nicvf 0002:01:04.4: enabling device (0004 -> 0006)
dmfe: Davicom DM9xxx net driver, version 1.36.4 (2002-01-17)
v1.01-e (2.4 port) Sep-11-2006  Donald Becker <becker@scyld.com>
   http://www.scyld.com/network/drivers.html
uli526x: ULi M5261/M5263 net driver, version 0.9.3 (2005-7-29)
e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
e1000: Copyright (c) 1999-2006 Intel Corporation.
e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
igb: Copyright (c) 2007-2014 Intel Corporation.
igbvf: Intel(R) Gigabit Virtual Function Network Driver - version 2.4.0-k
igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - version 4.4.0-k
ixgbe: Copyright (c) 1999-2016 Intel Corporation.
ixgbe 0006:90:00.0: enabling device (0000 -> 0002)
ixgbe 0006:90:00.0: Multiqueue Enabled: Rx Queue count = 48, Tx Queue 
count = 48
ixgbe 0006:90:00.0: PCI Express bandwidth of 32GT/s available
ixgbe 0006:90:00.0: (Speed:5.0GT/s, Width: x8, Encoding Loss:20%)
ixgbe 0006:90:00.0: MAC: 2, PHY: 18, SFP+: 5, PBA No: E68787-006
ixgbe 0006:90:00.0: 90:e2:ba:16:d1:86
ixgbe 0006:90:00.0: Intel(R) 10 Gigabit Network Connection
ixgbevf: Intel(R) 10 Gigabit PCI Express Virtual Function Network Driver 
- version 3.2.2-k
ixgbevf: Copyright (c) 2009 - 2015 Intel Corporation.
i40e: Intel(R) Ethernet Connection XL710 Network Driver - version 1.6.16-k
i40e: Copyright (c) 2013 - 2014 Intel Corporation.
ixgb: Intel(R) PRO/10GbE Network Driver - version 1.0.135-k2-NAPI
ixgb: Copyright (c) 1999-2008 Intel Corporation.
i40evf: Intel(R) 40-10 Gigabit Virtual Function Network Driver - version 
1.6.16-k
Copyright (c) 2013 - 2015 Intel Corporation.
Intel(R) Ethernet Switch Host Interface Driver - version 0.21.2-k
Copyright (c) 2013 - 2016 Intel Corporation.
sky2: driver version 1.30
usbcore: registered new interface driver asix
usbcore: registered new interface driver ax88179_178a
usbcore: registered new interface driver cdc_ether
usbcore: registered new interface driver net1080
usbcore: registered new interface driver cdc_subset
usbcore: registered new interface driver zaurus
usbcore: registered new interface driver cdc_ncm
VFIO - User Level meta-driver version: 0.3
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ehci-platform: EHCI generic platform driver
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci-pci: OHCI PCI platform driver
ohci-platform: OHCI generic platform driver
uhci_hcd: USB Universal Host Controller Interface driver
xhci_hcd 0000:00:10.0: xHCI Host Controller
xhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
xhci_hcd 0000:00:10.0: hcc params 0x0220f665 hci version 0x100 quirks 
0x00000010
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
xhci_hcd 0000:00:10.0: xHCI Host Controller
xhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 1 port detected
xhci_hcd 0000:00:11.0: xHCI Host Controller
xhci_hcd 0000:00:11.0: new USB bus registered, assigned bus number 3
xhci_hcd 0000:00:11.0: hcc params 0x0220f665 hci version 0x100 quirks 
0x00000010
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 1 port detected
xhci_hcd 0000:00:11.0: xHCI Host Controller
xhci_hcd 0000:00:11.0: new USB bus registered, assigned bus number 4
usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 1 port detected
usbcore: registered new interface driver usb-storage
mousedev: PS/2 mouse device common for all mice
device-mapper: ioctl: 4.35.0-ioctl (2016-06-23) initialised: 
dm-devel@redhat.com
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
sdhci-pltfm: SDHCI platform and OF driver helper
ledtrig-cpu: registered to indicate activity on CPUs
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
Netfilter messages via NETLINK v0.30.
nfnl_acct: registering with nfnetlink.
nf_conntrack version 0.5.0 (65536 buckets, 262144 max)
ip_set: protocol 6
IPVS: Registered protocols ()
IPVS: Connection hash table configured (size=4096, memory=64Kbytes)
IPVS: Creating netns size=1336 id=0
IPVS: ipvs loaded.
ip_tables: (C) 2000-2006 Netfilter Core Team
arp_tables: arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 17
bridge: filtering via arp/ip/ip6tables is no longer available by 
default. Update your scripts to load br_netfilter if you need this.
9pnet: Installing 9P2000 support
Key type dns_resolver registered
registered taskstats version 1
usb 3-1: new high-speed USB device number 2 using xhci_hcd
hctosys: unable to open rtc device (rtc0)
EXT4-fs (sda2): couldn't mount as ext3 due to feature incompatibilities
hub 3-1:1.0: USB hub found
random: fast init done
hub 3-1:1.0: 4 ports detected
usb 3-1: selecting invalid altsetting 1
hub 3-1:1.0: Using single TT (err -22)
EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
VFS: Mounted root (ext4 filesystem) on device 8:2.
devtmpfs: mounted
Freeing unused kernel memory: 640K (ffff800002000000 - ffff8000020a0000)
usb 4-1: new SuperSpeed USB device number 2 using xhci_hcd
hub 4-1:1.0: USB hub found
hub 4-1:1.0: 4 ports detected
systemd[1]: System time before build time, advancing clock.
usb 4-1.3: new SuperSpeed USB device number 3 using xhci_hcd
systemd[1]: systemd 229 running in system mode. (+PAM +AUDIT +SELINUX 
+IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS 
+ACL +XZ -LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN)
systemd[1]: Detected architecture arm64.

Welcome to Ubuntu 16.04.1 LTS!

root@ubuntu:~# cat /proc/iomem
01400000-fffeffff : System RAM
   01480000-01ffffff : Kernel code
   020a0000-0225ffff : Kernel data
ffff0000-ffffffff : reserved
100000000-1ffaa4ffff : System RAM
1ffaa50000-1ffaa7ffff : reserved
1ffaa80000-1fffa3ffff : System RAM
1fffa40000-1fffa8ffff : reserved
1fffa90000-1fffffffff : System RAM
801000000000-807fffffffff : PCI Bus 0000:00
810000000000-817fffffffff : PCI Bus 0001:00
   814000000000-8140001fffff : 0001:00:08.0
     814000000000-8140001fffff : ahci
   814000200000-8140002fffff : 0001:00:08.0
     814000200000-8140002fffff : ahci
   815000000000-8150001fffff : 0001:00:09.0
     815000000000-8150001fffff : ahci
   815000200000-8150002fffff : 0001:00:09.0
     815000200000-8150002fffff : ahci
   816000000000-8160001fffff : 0001:00:0a.0
     816000000000-8160001fffff : ahci
   816000200000-8160002fffff : 0001:00:0a.0
     816000200000-8160002fffff : ahci
   817000000000-8170001fffff : 0001:00:0b.0
     817000000000-8170001fffff : ahci
   817000200000-8170002fffff : 0001:00:0b.0
     817000200000-8170002fffff : ahci
818000000000-81ffffffffff : PCI Bus 0003:00
838000000000-841fffffffff : PCI Bus 0000:00
   838000000000-8380003fffff : 0000:03:00.0
   838000f00000-838000ffffff : 0000:03:00.0
   840000800000-8400008fffff : 0000:00:09.0
842000000000-843fffffffff : PCI Bus 0002:00
   842000000000-84200000ffff : 0002:00:03.0
   842000f00000-842000ffffff : 0002:00:03.0
   842040000000-84207fffffff : 0002:00:03.0
   843000000000-84303fffffff : 0002:01:00.0
     843000000000-84303fffffff : thunder-nic
   843060000000-8430600fffff : 0002:01:00.0
     843060000000-8430600fffff : thunder-nic
   8430a0000000-8430afffffff : 0002:01:00.0
     8430a0000000-8430a01fffff : 0002:01:00.1
       8430a0000000-8430a01fffff : thunder-nicvf
     8430a0200000-8430a03fffff : 0002:01:00.2
       8430a0200000-8430a03fffff : thunder-nicvf
     8430a0400000-8430a05fffff : 0002:01:00.3
       8430a0400000-8430a05fffff : thunder-nicvf
     8430a0600000-8430a07fffff : 0002:01:00.4
       8430a0600000-8430a07fffff : thunder-nicvf
     8430a0800000-8430a09fffff : 0002:01:00.5
       8430a0800000-8430a09fffff : thunder-nicvf
     8430a0a00000-8430a0bfffff : 0002:01:00.6
       8430a0a00000-8430a0bfffff : thunder-nicvf
     8430a0c00000-8430a0dfffff : 0002:01:00.7
       8430a0c00000-8430a0dfffff : thunder-nicvf
     8430a0e00000-8430a0ffffff : 0002:01:01.0
       8430a0e00000-8430a0ffffff : thunder-nicvf
     8430a1000000-8430a11fffff : 0002:01:01.1
       8430a1000000-8430a11fffff : thunder-nicvf
     8430a1200000-8430a13fffff : 0002:01:01.2
       8430a1200000-8430a13fffff : thunder-nicvf
     8430a1400000-8430a15fffff : 0002:01:01.3
       8430a1400000-8430a15fffff : thunder-nicvf
     8430a1600000-8430a17fffff : 0002:01:01.4
       8430a1600000-8430a17fffff : thunder-nicvf
     8430a1800000-8430a19fffff : 0002:01:01.5
       8430a1800000-8430a19fffff : thunder-nicvf
     8430a1a00000-8430a1bfffff : 0002:01:01.6
       8430a1a00000-8430a1bfffff : thunder-nicvf
     8430a1c00000-8430a1dfffff : 0002:01:01.7
       8430a1c00000-8430a1dfffff : thunder-nicvf
     8430a1e00000-8430a1ffffff : 0002:01:02.0
       8430a1e00000-8430a1ffffff : thunder-nicvf
     8430a2000000-8430a21fffff : 0002:01:02.1
       8430a2000000-8430a21fffff : thunder-nicvf
     8430a2200000-8430a23fffff : 0002:01:02.2
       8430a2200000-8430a23fffff : thunder-nicvf
     8430a2400000-8430a25fffff : 0002:01:02.3
       8430a2400000-8430a25fffff : thunder-nicvf
     8430a2600000-8430a27fffff : 0002:01:02.4
       8430a2600000-8430a27fffff : thunder-nicvf
     8430a2800000-8430a29fffff : 0002:01:02.5
       8430a2800000-8430a29fffff : thunder-nicvf
     8430a2a00000-8430a2bfffff : 0002:01:02.6
       8430a2a00000-8430a2bfffff : thunder-nicvf
     8430a2c00000-8430a2dfffff : 0002:01:02.7
       8430a2c00000-8430a2dfffff : thunder-nicvf
     8430a2e00000-8430a2ffffff : 0002:01:03.0
       8430a2e00000-8430a2ffffff : thunder-nicvf
     8430a3000000-8430a31fffff : 0002:01:03.1
       8430a3000000-8430a31fffff : thunder-nicvf
     8430a3200000-8430a33fffff : 0002:01:03.2
       8430a3200000-8430a33fffff : thunder-nicvf
     8430a3400000-8430a35fffff : 0002:01:03.3
       8430a3400000-8430a35fffff : thunder-nicvf
     8430a3600000-8430a37fffff : 0002:01:03.4
       8430a3600000-8430a37fffff : thunder-nicvf
     8430a3800000-8430a39fffff : 0002:01:03.5
       8430a3800000-8430a39fffff : thunder-nicvf
     8430a3a00000-8430a3bfffff : 0002:01:03.6
       8430a3a00000-8430a3bfffff : thunder-nicvf
     8430a3c00000-8430a3dfffff : 0002:01:03.7
       8430a3c00000-8430a3dfffff : thunder-nicvf
     8430a3e00000-8430a3ffffff : 0002:01:04.0
       8430a3e00000-8430a3ffffff : thunder-nicvf
     8430a4000000-8430a41fffff : 0002:01:04.1
       8430a4000000-8430a41fffff : thunder-nicvf
     8430a4200000-8430a43fffff : 0002:01:04.2
       8430a4200000-8430a43fffff : thunder-nicvf
     8430a4400000-8430a45fffff : 0002:01:04.3
       8430a4400000-8430a45fffff : thunder-nicvf
     8430a4600000-8430a47fffff : 0002:01:04.4
       8430a4600000-8430a47fffff : thunder-nicvf
   8430e0000000-8430efffffff : 0002:01:00.0
     8430e0000000-8430e01fffff : 0002:01:00.1
       8430e0000000-8430e01fffff : thunder-nicvf
     8430e0200000-8430e03fffff : 0002:01:00.2
       8430e0200000-8430e03fffff : thunder-nicvf
     8430e0400000-8430e05fffff : 0002:01:00.3
       8430e0400000-8430e05fffff : thunder-nicvf
     8430e0600000-8430e07fffff : 0002:01:00.4
       8430e0600000-8430e07fffff : thunder-nicvf
     8430e0800000-8430e09fffff : 0002:01:00.5
       8430e0800000-8430e09fffff : thunder-nicvf
     8430e0a00000-8430e0bfffff : 0002:01:00.6
       8430e0a00000-8430e0bfffff : thunder-nicvf
     8430e0c00000-8430e0dfffff : 0002:01:00.7
       8430e0c00000-8430e0dfffff : thunder-nicvf
     8430e0e00000-8430e0ffffff : 0002:01:01.0
       8430e0e00000-8430e0ffffff : thunder-nicvf
     8430e1000000-8430e11fffff : 0002:01:01.1
       8430e1000000-8430e11fffff : thunder-nicvf
     8430e1200000-8430e13fffff : 0002:01:01.2
       8430e1200000-8430e13fffff : thunder-nicvf
     8430e1400000-8430e15fffff : 0002:01:01.3
       8430e1400000-8430e15fffff : thunder-nicvf
     8430e1600000-8430e17fffff : 0002:01:01.4
       8430e1600000-8430e17fffff : thunder-nicvf
     8430e1800000-8430e19fffff : 0002:01:01.5
       8430e1800000-8430e19fffff : thunder-nicvf
     8430e1a00000-8430e1bfffff : 0002:01:01.6
       8430e1a00000-8430e1bfffff : thunder-nicvf
     8430e1c00000-8430e1dfffff : 0002:01:01.7
       8430e1c00000-8430e1dfffff : thunder-nicvf
     8430e1e00000-8430e1ffffff : 0002:01:02.0
       8430e1e00000-8430e1ffffff : thunder-nicvf
     8430e2000000-8430e21fffff : 0002:01:02.1
       8430e2000000-8430e21fffff : thunder-nicvf
     8430e2200000-8430e23fffff : 0002:01:02.2
       8430e2200000-8430e23fffff : thunder-nicvf
     8430e2400000-8430e25fffff : 0002:01:02.3
       8430e2400000-8430e25fffff : thunder-nicvf
     8430e2600000-8430e27fffff : 0002:01:02.4
       8430e2600000-8430e27fffff : thunder-nicvf
     8430e2800000-8430e29fffff : 0002:01:02.5
       8430e2800000-8430e29fffff : thunder-nicvf
     8430e2a00000-8430e2bfffff : 0002:01:02.6
       8430e2a00000-8430e2bfffff : thunder-nicvf
     8430e2c00000-8430e2dfffff : 0002:01:02.7
       8430e2c00000-8430e2dfffff : thunder-nicvf
     8430e2e00000-8430e2ffffff : 0002:01:03.0
       8430e2e00000-8430e2ffffff : thunder-nicvf
     8430e3000000-8430e31fffff : 0002:01:03.1
       8430e3000000-8430e31fffff : thunder-nicvf
     8430e3200000-8430e33fffff : 0002:01:03.2
       8430e3200000-8430e33fffff : thunder-nicvf
     8430e3400000-8430e35fffff : 0002:01:03.3
       8430e3400000-8430e35fffff : thunder-nicvf
     8430e3600000-8430e37fffff : 0002:01:03.4
       8430e3600000-8430e37fffff : thunder-nicvf
     8430e3800000-8430e39fffff : 0002:01:03.5
       8430e3800000-8430e39fffff : thunder-nicvf
     8430e3a00000-8430e3bfffff : 0002:01:03.6
       8430e3a00000-8430e3bfffff : thunder-nicvf
     8430e3c00000-8430e3dfffff : 0002:01:03.7
       8430e3c00000-8430e3dfffff : thunder-nicvf
     8430e3e00000-8430e3ffffff : 0002:01:04.0
       8430e3e00000-8430e3ffffff : thunder-nicvf
     8430e4000000-8430e41fffff : 0002:01:04.1
       8430e4000000-8430e41fffff : thunder-nicvf
     8430e4200000-8430e43fffff : 0002:01:04.2
       8430e4200000-8430e43fffff : thunder-nicvf
     8430e4400000-8430e45fffff : 0002:01:04.3
       8430e4400000-8430e45fffff : thunder-nicvf
     8430e4600000-8430e47fffff : 0002:01:04.4
       8430e4600000-8430e47fffff : thunder-nicvf
846000000000-847fffffffff : PCI Bus 0000:00
   846000000000-8467ffffffff : 0000:04:00.0
   846a00000000-846a000fffff : 0000:04:00.0
848000000000-848001ffffff : PCI ECAM
849000000000-849001ffffff : PCI ECAM
84a000000000-84a001ffffff : PCI ECAM
84b000000000-84b001ffffff : PCI ECAM
868000000000-87e023ffffff : PCI Bus 0000:00
   868000000000-8680001fffff : 0000:00:10.0
     868000000000-8680001fffff : xhci-hcd
   868000200000-8680002fffff : 0000:00:10.0
   869000000000-8690001fffff : 0000:00:11.0
     869000000000-8690001fffff : xhci-hcd
   869000200000-8690002fffff : 0000:00:11.0
   870000000000-8700007fffff : 0000:02:00.0
   870000f00000-870000ffffff : 0000:02:00.0
   87e005000000-87e0057fffff : 0000:01:01.3
     87e005000000-87e0057fffff : mdio_thunder
   87e006000000-87e0067fffff : 0000:01:00.1
   87e006f00000-87e006ffffff : 0000:01:00.1
   87e009000000-87e0097fffff : 0000:01:01.4
   87e009f00000-87e009ffffff : 0000:01:01.4
87e024000000-87e024000fff : ARMH0011:00
   87e024000000-87e024000fff : ARMH0011:00
87e025000000-87e025000fff : ARMH0011:01
   87e025000000-87e025000fff : ARMH0011:01
87e026000000-87e0bfffffff : PCI Bus 0000:00
   87e027000000-87e0277fffff : CAVA02A:00
   87e040000000-87e0400fffff : 0000:00:09.0
   87e050000000-87e0507fffff : 0000:01:06.0
   87e050f00000-87e050ffffff : 0000:01:06.0
   87e051000000-87e0517fffff : 0000:01:06.1
   87e051f00000-87e051ffffff : 0000:01:06.1
   87e052000000-87e0527fffff : 0000:01:06.2
   87e052f00000-87e052ffffff : 0000:01:06.2
   87e053000000-87e0537fffff : 0000:01:06.3
   87e053f00000-87e053ffffff : 0000:01:06.3
   87e054000000-87e0547fffff : 0000:01:06.4
   87e054f00000-87e054ffffff : 0000:01:06.4
   87e055000000-87e0557fffff : 0000:01:06.5
   87e055f00000-87e055ffffff : 0000:01:06.5
   87e056000000-87e0567fffff : 0000:01:06.6
   87e056f00000-87e056ffffff : 0000:01:06.6
   87e057000000-87e0577fffff : 0000:01:06.7
   87e057f00000-87e057ffffff : 0000:01:06.7
   87e058000000-87e0587fffff : 0000:01:07.0
   87e058f00000-87e058ffffff : 0000:01:07.0
   87e059000000-87e0597fffff : 0000:01:07.1
   87e059f00000-87e059ffffff : 0000:01:07.1
   87e05a000000-87e05a7fffff : 0000:01:07.2
   87e05af00000-87e05affffff : 0000:01:07.2
   87e05b000000-87e05b7fffff : 0000:01:07.3
   87e05bf00000-87e05bffffff : 0000:01:07.3
   87e05c000000-87e05c7fffff : 0000:01:07.4
   87e05cf00000-87e05cffffff : 0000:01:07.4
   87e05d000000-87e05d7fffff : 0000:01:07.5
   87e05df00000-87e05dffffff : 0000:01:07.5
   87e05e000000-87e05e7fffff : 0000:01:07.6
   87e05ef00000-87e05effffff : 0000:01:07.6
   87e05f000000-87e05f7fffff : 0000:01:07.7
   87e05ff00000-87e05fffffff : 0000:01:07.7
   87e088000000-87e0887fffff : 0000:01:0a.0
   87e088f00000-87e088ffffff : 0000:01:0a.0
   87e089000000-87e0897fffff : 0000:01:0a.1
   87e089f00000-87e089ffffff : 0000:01:0a.1
   87e08a000000-87e08a7fffff : 0000:01:0a.2
   87e08af00000-87e08affffff : 0000:01:0a.2
   87e08b000000-87e08b7fffff : 0000:01:0a.3
   87e08bf00000-87e08bffffff : 0000:01:0a.3
87e0c0000000-87e0c0ffffff : PCI Bus 0004:1f
   87e0c0f00000-87e0c0ffffff : 0004:1f:00.0
87e0c2000000-87e0c2ffffff : PCI Bus 0006:8f
   87e0c2f00000-87e0c2ffffff : 0006:8f:00.0
87e0c6000000-87ffffffffff : PCI Bus 0000:00
   87e0d0000000-87e0d07fffff : 0000:01:09.0
   87e0d0f00000-87e0d0ffffff : 0000:01:09.0
   87e0d1000000-87e0d17fffff : 0000:01:09.1
   87e0d1f00000-87e0d1ffffff : 0000:01:09.1
   87e0d2000000-87e0d27fffff : 0000:01:09.2
   87e0d2f00000-87e0d2ffffff : 0000:01:09.2
   87e0d3000000-87e0d37fffff : 0000:01:09.3
   87e0d3f00000-87e0d3ffffff : 0000:01:09.3
   87e0d4000000-87e0d47fffff : 0000:01:09.4
   87e0d4f00000-87e0d4ffffff : 0000:01:09.4
   87e0e0000000-87e0e03fffff : 0000:01:10.0
     87e0e0000000-87e0e03fffff : thunder-BGX
   87e0e0400000-87e0e07fffff : 0000:01:10.0
     87e0e0400000-87e0e07fffff : thunder-BGX
   87e0e1000000-87e0e13fffff : 0000:01:10.1
     87e0e1000000-87e0e13fffff : thunder-BGX
   87e0e1400000-87e0e17fffff : 0000:01:10.1
     87e0e1400000-87e0e17fffff : thunder-BGX
   87e0fc000000-87e0fc0fffff : 0000:01:00.0
   87e0fcf00000-87e0fcffffff : 0000:01:00.0
88001f000000-880057ffffff : PCI ECAM
881010000000-881fffffffff : PCI Bus 0004:1f
   881010000000-8810117fffff : PCI Bus 0004:20
     881010000000-8810117fffff : PCI Bus 0004:21
       881010000000-881010ffffff : 0004:21:00.0
       881011000000-88101101ffff : 0004:21:00.0
   881011800000-88101180ffff : 0004:1f:00.0
882000000000-882fffffffff : PCI Bus 0004:1f
88808f000000-8880c7ffffff : PCI ECAM
889010000000-889fffffffff : PCI Bus 0006:8f
   889010000000-8890107fffff : PCI Bus 0006:90
     889010000000-8890103fffff : 0006:90:00.0
     889010400000-8890107fffff : 0006:90:00.0
   889010800000-88901080ffff : 0006:8f:00.0
88a000000000-88afffffffff : PCI Bus 0006:8f
   88a000000000-88a0000fffff : PCI Bus 0006:90
     88a000000000-88a00007ffff : 0006:90:00.0
       88a000000000-88a00007ffff : ixgbe
     88a000080000-88a000083fff : 0006:90:00.0
       88a000080000-88a000083fff : ixgbe

Thanks,
Tomasz
