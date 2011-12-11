Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:59480 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752260Ab1LKVhe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 11 Dec 2011 16:37:34 -0500
Message-ID: <4EE5220B.1090207@gmx.de>
Date: Sun, 11 Dec 2011 22:35:07 +0100
From: Helge Deller <deller@gmx.de>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
Subject: pci_is_pcie() returns true for PCI-cards?
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In my machine I'm running two dual-DVI PCI video cards (NVidia GeForce 7300 LE PCI, ATI FireMV 2200 PCI).
Both are PCI and not PCI-Express cards.

Somewhere after kernel 2.6.34 the nouveau and the radeon DRM drivers switched their
initialization code to set the GART/aperture size to 64MB (for PCI) or 512MB (for PCIE),
and the pci_is_pcie() function is used to determine if the graphics card is PCI or PCIE.

In my case this broke both drivers for me, since pci_is_pcie() strangely returns true for my PCI-only cards
and (being neither a graphic card or PCI bus expert) both drivers set up a 512MB GART and then fail to 
function correctly.

Now my question:
My assumption is, that pci_is_pcie() should return true for PCI-E cards only.
PCI-only cards should return false. Is this assumption correct?
If yes, there is probably a bug somewhere and maybe someone here has an idea what I could test to fix this bug?
If not, then the nouveau and radeon drivers should not use pci_is_pcie() to determine if this is a PCI or PCI-E card...

I did some testing with kernel 3.1.5.
For the nVidia card (PCI 01:00.0) I got:
- pci_is_pcie(dev->pdev) = 1
- pci_find_capability(dev->pdev, PCI_CAP_ID_EXP) = 120

lspci output:
00:00.0 Host bridge: Intel Corporation 4 Series Chipset DRAM Controller (rev 03)
00:01.0 PCI bridge: Intel Corporation 4 Series Chipset PCI Express Root Port (rev 03)
00:1b.0 Audio device: Intel Corporation N10/ICH 7 Family High Definition Audio Controller (rev 01)
00:1c.0 PCI bridge: Intel Corporation N10/ICH 7 Family PCI Express Port 1 (rev 01)
00:1c.1 PCI bridge: Intel Corporation N10/ICH 7 Family PCI Express Port 2 (rev 01)
00:1d.0 USB Controller: Intel Corporation N10/ICH7 Family USB UHCI Controller #1 (rev 01)
00:1d.1 USB Controller: Intel Corporation N10/ICH 7 Family USB UHCI Controller #2 (rev 01)
00:1d.2 USB Controller: Intel Corporation N10/ICH 7 Family USB UHCI Controller #3 (rev 01)
00:1d.3 USB Controller: Intel Corporation N10/ICH 7 Family USB UHCI Controller #4 (rev 01)
00:1d.7 USB Controller: Intel Corporation N10/ICH 7 Family USB2 EHCI Controller (rev 01)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1)
00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC Interface Bridge (rev 01)
00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE Controller (rev 01)
00:1f.2 IDE interface: Intel Corporation N10/ICH7 Family SATA IDE Controller (rev 01)
01:00.0 VGA compatible controller: nVidia Corporation G72 [GeForce 7300 LE] (rev a1)
02:00.0 Ethernet controller: Atheros Communications AR8121/AR8113/AR8114 Gigabit or Fast Ethernet (rev b0)
04:01.0 VGA compatible controller: ATI Technologies Inc RV280 [FireMV 2200 PCI] (rev 01)
04:01.1 Display controller: ATI Technologies Inc RV280 [FireMV 2200 PCI] (secondary) (rev 01)

dmesg:
Linux version 3.1.5+ (root@server) (gcc version 4.4.5 20101112 (Red Hat 4.4.5-2) (GCC) ) #10 SMP Sun Dec 11 00:34:14 CET 2011
Command line: ro root=/dev/sda1 rd_NO_LUKS rd_NO_LVM rd_NO_MD rd_NO_DM LANG=en_US.UTF-8 SYSFONT=latarcyrheb-sun16 KEYTABLE=de-latin1-nodeadkeys rhgb
KERNEL supported cpus:
  Intel GenuineIntel
  AMD AuthenticAMD
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000cff80000 (usable)
 BIOS-e820: 00000000cff80000 - 00000000cff8e000 (ACPI data)
 BIOS-e820: 00000000cff8e000 - 00000000cffd0000 (ACPI NVS)
 BIOS-e820: 00000000cffd0000 - 00000000d0000000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000230000000 (usable)
NX (Execute Disable) protection: active
DMI present.
DMI: System manufacturer System Product Name/P5G41-M LE, BIOS 0505    06/01/2010
e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> (reserved)
e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
No AGP bridge found
last_pfn = 0x230000 max_arch_pfn = 0x400000000
MTRR default type: uncachable
MTRR fixed ranges enabled:
  00000-9FFFF write-back
  A0000-BFFFF uncachable
  C0000-CBFFF write-protect
  CC000-DFFFF uncachable
  E0000-EFFFF write-through
  F0000-FFFFF write-protect
MTRR variable ranges enabled:
  0 base 000000000 mask E00000000 write-back
  1 base 200000000 mask FE0000000 write-back
  2 base 220000000 mask FF0000000 write-back
  3 base 0D0000000 mask FF0000000 uncachable
  4 base 0E0000000 mask FE0000000 uncachable
  5 disabled
  6 disabled
  7 disabled
x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
original variable MTRRs
reg 0, base: 0GB, range: 8GB, type WB
reg 1, base: 8GB, range: 512MB, type WB
reg 2, base: 8704MB, range: 256MB, type WB
reg 3, base: 3328MB, range: 256MB, type UC
reg 4, base: 3584MB, range: 512MB, type UC
total RAM covered: 8192M
Found optimal setting for mtrr clean up
 gran_size: 64K 	chunk_size: 64K 	num_reg: 6  	lose cover RAM: 0G
New variable MTRRs
reg 0, base: 0GB, range: 2GB, type WB
reg 1, base: 2GB, range: 1GB, type WB
reg 2, base: 3GB, range: 256MB, type WB
reg 3, base: 4GB, range: 4GB, type WB
reg 4, base: 8GB, range: 512MB, type WB
reg 5, base: 8704MB, range: 256MB, type WB
e820 update range: 00000000d0000000 - 0000000100000000 (usable) ==> (reserved)
last_pfn = 0xcff80 max_arch_pfn = 0x400000000
found SMP MP-table at [ffff8800000ff780] ff780
initial memory mapped : 0 - 20000000
Base memory trampoline at [ffff88000009a000] 9a000 size 20480
init_memory_mapping: 0000000000000000-00000000cff80000
 0000000000 - 00cfe00000 page 2M
 00cfe00000 - 00cff80000 page 4k
kernel direct mapping tables up to cff80000 @ 1fffa000-20000000
init_memory_mapping: 0000000100000000-0000000230000000
 0100000000 - 0230000000 page 2M
kernel direct mapping tables up to 230000000 @ cff76000-cff80000
ACPI: RSDP 00000000000fb800 00024 (v02 ACPIAM)
ACPI: XSDT 00000000cff80100 0005C (v01 A_M_I_ OEMXSDT  06001001 MSFT 00000097)
ACPI: FACP 00000000cff80290 000F4 (v03 A_M_I_ OEMFACP  06001001 MSFT 00000097)
ACPI: DSDT 00000000cff80440 073C9 (v01  A1419 A1419000 00000000 INTL 20060113)
ACPI: FACS 00000000cff8e000 00040
ACPI: APIC 00000000cff80390 0006C (v01 A_M_I_ OEMAPIC  06001001 MSFT 00000097)
ACPI: MCFG 00000000cff80400 0003C (v01 A_M_I_ OEMMCFG  06001001 MSFT 00000097)
ACPI: OEMB 00000000cff8e040 00089 (v01 A_M_I_ AMI_OEM  06001001 MSFT 00000097)
ACPI: HPET 00000000cff87810 00038 (v01 A_M_I_ OEMHPET  06001001 MSFT 00000097)
ACPI: GSCI 00000000cff8e0d0 02024 (v01 A_M_I_ GMCHSCI  06001001 MSFT 00000097)
ACPI: SSDT 00000000cff90700 00A7C (v01 DpgPmm    CpuPm 00000012 INTL 20060113)
ACPI: Local APIC address 0xfee00000
 [ffffea0000000000-ffffea0008bfffff] PMD -> [ffff880227600000-ffff88022f5fffff] on node 0
Zone PFN ranges:
  DMA      0x00000010 -> 0x00001000
  DMA32    0x00001000 -> 0x00100000
  Normal   0x00100000 -> 0x00230000
Movable zone start PFN for each node
early_node_map[3] active PFN ranges
    0: 0x00000010 -> 0x0000009f
    0: 0x00000100 -> 0x000cff80
    0: 0x00100000 -> 0x00230000
On node 0 totalpages: 2096911
  DMA zone: 64 pages used for memmap
  DMA zone: 5 pages reserved
  DMA zone: 3914 pages, LIFO batch:0
  DMA32 zone: 16320 pages used for memmap
  DMA32 zone: 831424 pages, LIFO batch:31
  Normal zone: 19456 pages used for memmap
  Normal zone: 1225728 pages, LIFO batch:31
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Using ACPI (MADT) for SMP configuration information
ACPI: HPET id: 0x8086a201 base: 0xfed00000
SMP: Allowing 4 CPUs, 2 hotplug CPUs
nr_irqs_gsi: 40
PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
PM: Registered nosave memory: 00000000000a0000 - 00000000000e4000
PM: Registered nosave memory: 00000000000e4000 - 0000000000100000
PM: Registered nosave memory: 00000000cff80000 - 00000000cff8e000
PM: Registered nosave memory: 00000000cff8e000 - 00000000cffd0000
PM: Registered nosave memory: 00000000cffd0000 - 00000000d0000000
PM: Registered nosave memory: 00000000d0000000 - 00000000fee00000
PM: Registered nosave memory: 00000000fee00000 - 00000000fee01000
PM: Registered nosave memory: 00000000fee01000 - 00000000fff00000
PM: Registered nosave memory: 00000000fff00000 - 0000000100000000
Allocating PCI resources starting at d0000000 (gap: d0000000:2ee00000)
setup_percpu: NR_CPUS:4 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
PERCPU: Embedded 26 pages/cpu @ffff88022fc00000 s74688 r8192 d23616 u524288
pcpu-alloc: s74688 r8192 d23616 u524288 alloc=1*2097152
pcpu-alloc: [0] 0 1 2 3 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 2061066
Kernel command line: ro root=/dev/sda1 rd_NO_LUKS rd_NO_LVM rd_NO_MD rd_NO_DM LANG=en_US.UTF-8 SYSFONT=latarcyrheb-sun16 KEYTABLE=de-latin1-nodeadkeys rhgb
PID hash table entries: 4096 (order: 3, 32768 bytes)
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
xsave/xrstor: enabled xstate_bv 0x3, cntxt size 0x240
Checking aperture...
No AGP bridge found
Memory: 8162572k/9175040k available (7178k kernel code, 787396k absent, 225072k reserved, 6124k data, 808k init)
SLUB: Genslabs=15, HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
Hierarchical RCU implementation.
NR_IRQS:4352 nr_irqs:712 16
Extended CMOS year: 2000
Console: colour VGA+ 80x25
console [tty0] enabled
hpet clockevent registered
Fast TSC calibration using PIT
Detected 3067.130 MHz processor.
Calibrating delay loop (skipped), value calculated using timer frequency.. 6134.26 BogoMIPS (lpj=3067130)
pid_max: default: 32768 minimum: 301
Security Framework initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
Mount-cache hash table entries: 256
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
mce: CPU supports 6 MCE banks
CPU0: Thermal monitoring enabled (TM2)
using mwait in idle threads.
ACPI: Core revision 20110623
ftrace: allocating 31883 entries in 126 pages
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
CPU0: Intel(R) Core(TM)2 Duo CPU     E7600  @ 3.06GHz stepping 0a
Performance Events: PEBS fmt0+, Core2 events, Intel PMU driver.
... version:                2
... bit width:              40
... generic registers:      2
... value mask:             000000ffffffffff
... max period:             000000007fffffff
... fixed-purpose events:   3
... event mask:             0000000700000003
Booting Node   0, Processors  #1
smpboot cpu 1: start_ip = 9a000
Brought up 2 CPUs
Total of 2 processors activated (12267.37 BogoMIPS).
devtmpfs: initialized
PM: Registering ACPI NVS region at cff8e000 (270336 bytes)
RTC time:  1:05:22, date: 12/11/11
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf0000000-0xf3ffffff] (base 0xf0000000)
PCI: not using MMCONFIG
PCI: Using configuration type 1 for base access
bio: create slab <bio-0> at 0
ACPI: Added _OSI(Module Device)
ACPI: Added _OSI(Processor Device)
ACPI: Added _OSI(3.0 _SCP Extensions)
ACPI: Added _OSI(Processor Aggregator Device)
ACPI: EC: Look up EC in DSDT
ACPI: Executed 1 blocks of module-level executable AML code
ACPI: SSDT 00000000cff90100 002FB (v01 DpgPmm  P001Ist 00000011 INTL 20060113)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT           (null) 002FB (v01 DpgPmm  P001Ist 00000011 INTL 20060113)
ACPI: SSDT 00000000cff90400 002FB (v01 DpgPmm  P002Ist 00000012 INTL 20060113)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT           (null) 002FB (v01 DpgPmm  P002Ist 00000012 INTL 20060113)
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf0000000-0xf3ffffff] (base 0xf0000000)
PCI: MMCONFIG at [mem 0xf0000000-0xf3ffffff] reserved in ACPI motherboard resources
ACPI: No dock devices found.
HEST: Table not found.
PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
pci_root PNP0A08:00: host bridge window [io  0x0000-0x0cf7]
pci_root PNP0A08:00: host bridge window [io  0x0d00-0xffff]
pci_root PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff]
pci_root PNP0A08:00: host bridge window [mem 0x000d0000-0x000dffff]
pci_root PNP0A08:00: host bridge window [mem 0xd0000000-0xefffffff]
pci_root PNP0A08:00: host bridge window [mem 0xf4000000-0xffffffff]
pci 0000:00:00.0: [8086:2e30] type 0 class 0x000600
pci 0000:00:01.0: [8086:2e31] type 1 class 0x000604
pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
pci 0000:00:01.0: PME# disabled
pci 0000:00:1b.0: [8086:27d8] type 0 class 0x000403
pci 0000:00:1b.0: reg 10: [mem 0xfbffc000-0xfbffffff 64bit]
pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1b.0: PME# disabled
pci 0000:00:1c.0: [8086:27d0] type 1 class 0x000604
pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.0: PME# disabled
pci 0000:00:1c.1: [8086:27d2] type 1 class 0x000604
pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.1: PME# disabled
pci 0000:00:1d.0: [8086:27c8] type 0 class 0x000c03
pci 0000:00:1d.0: reg 20: [io  0xc480-0xc49f]
pci 0000:00:1d.1: [8086:27c9] type 0 class 0x000c03
pci 0000:00:1d.1: reg 20: [io  0xc800-0xc81f]
pci 0000:00:1d.2: [8086:27ca] type 0 class 0x000c03
pci 0000:00:1d.2: reg 20: [io  0xc880-0xc89f]
pci 0000:00:1d.3: [8086:27cb] type 0 class 0x000c03
pci 0000:00:1d.3: reg 20: [io  0xcc00-0xcc1f]
pci 0000:00:1d.7: [8086:27cc] type 0 class 0x000c03
pci 0000:00:1d.7: reg 10: [mem 0xfbffbc00-0xfbffbfff]
pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
pci 0000:00:1d.7: PME# disabled
pci 0000:00:1e.0: [8086:244e] type 1 class 0x000604
pci 0000:00:1f.0: [8086:27b8] type 0 class 0x000601
pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0294 (mask 0003)
pci 0000:00:1f.1: [8086:27df] type 0 class 0x000101
pci 0000:00:1f.1: reg 10: [io  0x0000-0x0007]
pci 0000:00:1f.1: reg 14: [io  0x0000-0x0003]
pci 0000:00:1f.1: reg 18: [io  0x08f0-0x08f7]
pci 0000:00:1f.1: reg 1c: [io  0x08f8-0x08fb]
pci 0000:00:1f.1: reg 20: [io  0xffa0-0xffaf]
pci 0000:00:1f.2: [8086:27c0] type 0 class 0x000101
pci 0000:00:1f.2: reg 10: [io  0xc400-0xc407]
pci 0000:00:1f.2: reg 14: [io  0xc080-0xc083]
pci 0000:00:1f.2: reg 18: [io  0xc000-0xc007]
pci 0000:00:1f.2: reg 1c: [io  0xbc00-0xbc03]
pci 0000:00:1f.2: reg 20: [io  0xb880-0xb88f]
pci 0000:00:1f.2: PME# supported from D3hot
pci 0000:00:1f.2: PME# disabled
pci 0000:01:00.0: [10de:01d1] type 0 class 0x000300
pci 0000:01:00.0: reg 10: [mem 0xfd000000-0xfdffffff]
pci 0000:01:00.0: reg 14: [mem 0xd0000000-0xdfffffff 64bit pref]
pci 0000:01:00.0: reg 1c: [mem 0xfc000000-0xfcffffff 64bit]
pci 0000:01:00.0: reg 30: [mem 0xfe9e0000-0xfe9fffff pref]
pci 0000:01:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
pci 0000:00:01.0: PCI bridge to [bus 01-01]
pci 0000:00:01.0:   bridge window [mem 0xfc000000-0xfe9fffff]
pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
pci 0000:00:1c.0: PCI bridge to [bus 03-03]
pci 0000:02:00.0: [1969:1026] type 0 class 0x000200
pci 0000:02:00.0: reg 10: [mem 0xfeac0000-0xfeafffff 64bit]
pci 0000:02:00.0: reg 18: [io  0xdc00-0xdc7f]
pci 0000:02:00.0: PME# supported from D3hot D3cold
pci 0000:02:00.0: PME# disabled
pci 0000:02:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
pci 0000:00:1c.1: PCI bridge to [bus 02-02]
pci 0000:00:1c.1:   bridge window [io  0xd000-0xdfff]
pci 0000:00:1c.1:   bridge window [mem 0xfea00000-0xfeafffff]
pci 0000:04:01.0: [1002:5965] type 0 class 0x000300
pci 0000:04:01.0: reg 10: [mem 0xe8000000-0xebffffff pref]
pci 0000:04:01.0: reg 14: [io  0xe000-0xe0ff]
pci 0000:04:01.0: reg 18: [mem 0xfebe0000-0xfebeffff]
pci 0000:04:01.0: reg 30: [mem 0xfebc0000-0xfebdffff pref]
pci 0000:04:01.0: supports D1 D2
pci 0000:04:01.1: [1002:5d45] type 0 class 0x000380
pci 0000:04:01.1: reg 10: [mem 0xec000000-0xefffffff pref]
pci 0000:04:01.1: reg 14: [mem 0xfebf0000-0xfebfffff]
pci 0000:04:01.1: supports D1 D2
pci 0000:00:1e.0: PCI bridge to [bus 04-04] (subtractive decode)
pci 0000:00:1e.0:   bridge window [io  0xe000-0xefff]
pci 0000:00:1e.0:   bridge window [mem 0xfeb00000-0xfebfffff]
pci 0000:00:1e.0:   bridge window [mem 0xe8000000-0xefffffff 64bit pref]
pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7] (subtractive decode)
pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff] (subtractive decode)
pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
pci 0000:00:1e.0:   bridge window [mem 0x000d0000-0x000dffff] (subtractive decode)
pci 0000:00:1e.0:   bridge window [mem 0xd0000000-0xefffffff] (subtractive decode)
pci 0000:00:1e.0:   bridge window [mem 0xf4000000-0xffffffff] (subtractive decode)
pci_bus 0000:00: on NUMA node 0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P5._PRT]
 pci0000:00: Requesting ACPI _OSC control (0x1d)
 pci0000:00: ACPI _OSC request failed (AE_NOT_FOUND), returned control mask: 0x1d
ACPI _OSC control for PCIe not granted, disabling ASPM
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 *4 5 6 7 10 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 *6 7 10 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs *3 4 5 6 7 10 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs *11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 *7 10 12 14 15)
vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=none,locks=none
vgaarb: device added: PCI:0000:04:01.0,decodes=io+mem,owns=io+mem,locks=none
vgaarb: loaded
vgaarb: bridge control possible 0000:04:01.0
vgaarb: bridge control possible 0000:01:00.0
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
wmi: Mapper loaded
Advanced Linux Sound Architecture Driver Version 1.0.24.
PCI: Using ACPI for IRQ routing
PCI: pci_cache_line_size set to 64 bytes
reserve RAM buffer: 000000000009fc00 - 000000000009ffff 
reserve RAM buffer: 00000000cff80000 - 00000000cfffffff 
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
HPET: 3 timers in total, 0 timers will be used for per-cpu timer
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 3 comparators, 64-bit 14.318180 MHz counter
Switching to clocksource hpet
Switched to NOHz mode on CPU #0
Switched to NOHz mode on CPU #1
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp 00:00: [bus 00-ff]
pnp 00:00: [io  0x0cf8-0x0cff]
pnp 00:00: [io  0x0000-0x0cf7 window]
pnp 00:00: [io  0x0d00-0xffff window]
pnp 00:00: [mem 0x000a0000-0x000bffff window]
pnp 00:00: [mem 0x000d0000-0x000dffff window]
pnp 00:00: [mem 0xd0000000-0xefffffff window]
pnp 00:00: [mem 0xf4000000-0xffffffff window]
pnp 00:00: Plug and Play ACPI device, IDs PNP0a08 PNP0a03 (active)
pnp 00:01: [mem 0xfed14000-0xfed19fff]
system 00:01: [mem 0xfed14000-0xfed19fff] has been reserved
system 00:01: Plug and Play ACPI device, IDs PNP0c01 (active)
pnp 00:02: [dma 4]
pnp 00:02: [io  0x0000-0x000f]
pnp 00:02: [io  0x0081-0x0083]
pnp 00:02: [io  0x0087]
pnp 00:02: [io  0x0089-0x008b]
pnp 00:02: [io  0x008f]
pnp 00:02: [io  0x00c0-0x00df]
pnp 00:02: Plug and Play ACPI device, IDs PNP0200 (active)
pnp 00:03: [io  0x0070-0x0071]
pnp 00:03: [irq 8]
pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (active)
pnp 00:04: [io  0x0061]
pnp 00:04: Plug and Play ACPI device, IDs PNP0800 (active)
pnp 00:05: [io  0x00f0-0x00ff]
pnp 00:05: [irq 13]
pnp 00:05: Plug and Play ACPI device, IDs PNP0c04 (active)
pnp 00:06: [io  0x0000-0xffffffffffffffff disabled]
pnp 00:06: [io  0x0000-0xffffffffffffffff disabled]
pnp 00:06: [io  0x0290-0x0297]
system 00:06: [io  0x0290-0x0297] has been reserved
system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
pnp 00:07: [io  0x0010-0x001f]
pnp 00:07: [io  0x0022-0x003f]
pnp 00:07: [io  0x0044-0x005f]
pnp 00:07: [io  0x0062-0x0063]
pnp 00:07: [io  0x0065-0x006f]
pnp 00:07: [io  0x0072-0x007f]
pnp 00:07: [io  0x0080]
pnp 00:07: [io  0x0084-0x0086]
pnp 00:07: [io  0x0088]
pnp 00:07: [io  0x008c-0x008e]
pnp 00:07: [io  0x0090-0x009f]
pnp 00:07: [io  0x00a2-0x00bf]
pnp 00:07: [io  0x00e0-0x00ef]
pnp 00:07: [io  0x0400-0x041f]
pnp 00:07: [io  0x04d0-0x04d1]
pnp 00:07: [io  0x0800-0x087f]
pnp 00:07: [io  0x0400-0x03ff disabled]
pnp 00:07: [io  0x0480-0x04bf]
pnp 00:07: [mem 0xfed1c000-0xfed1ffff]
pnp 00:07: [mem 0xfed20000-0xfed8ffff]
system 00:07: [io  0x0400-0x041f] has been reserved
system 00:07: [io  0x04d0-0x04d1] has been reserved
system 00:07: [io  0x0800-0x087f] has been reserved
system 00:07: [io  0x0480-0x04bf] has been reserved
system 00:07: [mem 0xfed1c000-0xfed1ffff] has been reserved
system 00:07: [mem 0xfed20000-0xfed8ffff] has been reserved
system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
pnp 00:08: [mem 0xfed00000-0xfed003ff]
pnp 00:08: Plug and Play ACPI device, IDs PNP0103 (active)
pnp 00:09: [mem 0xffb00000-0xffbfffff]
pnp 00:09: [mem 0xfff00000-0xffffffff]
pnp 00:09: Plug and Play ACPI device, IDs INT0800 (active)
pnp 00:0a: [mem 0xffc00000-0xffefffff]
system 00:0a: [mem 0xffc00000-0xffefffff] has been reserved
system 00:0a: Plug and Play ACPI device, IDs PNP0c02 (active)
pnp 00:0b: [io  0x0060]
pnp 00:0b: [io  0x0064]
pnp 00:0b: [mem 0xfec00000-0xfec00fff]
pnp 00:0b: [mem 0xfee00000-0xfee00fff]
system 00:0b: [mem 0xfec00000-0xfec00fff] could not be reserved
system 00:0b: [mem 0xfee00000-0xfee00fff] has been reserved
system 00:0b: Plug and Play ACPI device, IDs PNP0c02 (active)
pnp 00:0c: [mem 0xf0000000-0xf3ffffff]
system 00:0c: [mem 0xf0000000-0xf3ffffff] has been reserved
system 00:0c: Plug and Play ACPI device, IDs PNP0c02 (active)
pnp 00:0d: [mem 0x00000000-0x0009ffff]
pnp 00:0d: [mem 0x000c0000-0x000cffff]
pnp 00:0d: [mem 0x000e0000-0x000fffff]
pnp 00:0d: [mem 0x00100000-0xcfffffff]
pnp 00:0d: [mem 0xf0000000-0xffffffff]
system 00:0d: [mem 0x00000000-0x0009ffff] could not be reserved
system 00:0d: [mem 0x000c0000-0x000cffff] could not be reserved
system 00:0d: [mem 0x000e0000-0x000fffff] could not be reserved
system 00:0d: [mem 0x00100000-0xcfffffff] could not be reserved
system 00:0d: [mem 0xf0000000-0xffffffff] could not be reserved
system 00:0d: Plug and Play ACPI device, IDs PNP0c01 (active)
pnp: PnP ACPI: found 14 devices
ACPI: ACPI bus type pnp unregistered
PCI: max bus depth: 1 pci_try_num: 2
pci 0000:00:1c.1: BAR 15: assigned [mem 0xe0000000-0xe01fffff 64bit pref]
pci 0000:00:1c.0: BAR 14: assigned [mem 0xe0200000-0xe03fffff]
pci 0000:00:1c.0: BAR 15: assigned [mem 0xe0400000-0xe05fffff 64bit pref]
pci 0000:00:1c.0: BAR 13: assigned [io  0x1000-0x1fff]
pci 0000:00:01.0: PCI bridge to [bus 01-01]
pci 0000:00:01.0:   bridge window [mem 0xfc000000-0xfe9fffff]
pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
pci 0000:00:1c.0: PCI bridge to [bus 03-03]
pci 0000:00:1c.0:   bridge window [io  0x1000-0x1fff]
pci 0000:00:1c.0:   bridge window [mem 0xe0200000-0xe03fffff]
pci 0000:00:1c.0:   bridge window [mem 0xe0400000-0xe05fffff 64bit pref]
pci 0000:00:1c.1: PCI bridge to [bus 02-02]
pci 0000:00:1c.1:   bridge window [io  0xd000-0xdfff]
pci 0000:00:1c.1:   bridge window [mem 0xfea00000-0xfeafffff]
pci 0000:00:1c.1:   bridge window [mem 0xe0000000-0xe01fffff 64bit pref]
pci 0000:00:1e.0: PCI bridge to [bus 04-04]
pci 0000:00:1e.0:   bridge window [io  0xe000-0xefff]
pci 0000:00:1e.0:   bridge window [mem 0xfeb00000-0xfebfffff]
pci 0000:00:1e.0:   bridge window [mem 0xe8000000-0xefffffff 64bit pref]
pci 0000:00:01.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
pci 0000:00:01.0: setting latency timer to 64
pci 0000:00:1c.0: enabling device (0104 -> 0107)
pci 0000:00:1c.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
pci 0000:00:1c.0: setting latency timer to 64
pci 0000:00:1c.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
pci 0000:00:1c.1: setting latency timer to 64
pci 0000:00:1e.0: setting latency timer to 64
pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000dffff]
pci_bus 0000:00: resource 8 [mem 0xd0000000-0xefffffff]
pci_bus 0000:00: resource 9 [mem 0xf4000000-0xffffffff]
pci_bus 0000:01: resource 1 [mem 0xfc000000-0xfe9fffff]
pci_bus 0000:01: resource 2 [mem 0xd0000000-0xdfffffff 64bit pref]
pci_bus 0000:03: resource 0 [io  0x1000-0x1fff]
pci_bus 0000:03: resource 1 [mem 0xe0200000-0xe03fffff]
pci_bus 0000:03: resource 2 [mem 0xe0400000-0xe05fffff 64bit pref]
pci_bus 0000:02: resource 0 [io  0xd000-0xdfff]
pci_bus 0000:02: resource 1 [mem 0xfea00000-0xfeafffff]
pci_bus 0000:02: resource 2 [mem 0xe0000000-0xe01fffff 64bit pref]
pci_bus 0000:04: resource 0 [io  0xe000-0xefff]
pci_bus 0000:04: resource 1 [mem 0xfeb00000-0xfebfffff]
pci_bus 0000:04: resource 2 [mem 0xe8000000-0xefffffff 64bit pref]
pci_bus 0000:04: resource 4 [io  0x0000-0x0cf7]
pci_bus 0000:04: resource 5 [io  0x0d00-0xffff]
pci_bus 0000:04: resource 6 [mem 0x000a0000-0x000bffff]
pci_bus 0000:04: resource 7 [mem 0x000d0000-0x000dffff]
pci_bus 0000:04: resource 8 [mem 0xd0000000-0xefffffff]
pci_bus 0000:04: resource 9 [mem 0xf4000000-0xffffffff]
NET: Registered protocol family 2
IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
UDP hash table entries: 4096 (order: 5, 131072 bytes)
UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
pci 0000:04:01.0: Boot video device
PCI: CLS 32 bytes, default 64
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Placing 64MB software IO TLB between ffff8800cbf76000 - ffff8800cff76000
software IO TLB at phys 0xcbf76000 - 0xcff76000
microcode: CPU0 sig=0x1067a, pf=0x1, revision=0xa07
microcode: CPU1 sig=0x1067a, pf=0x1, revision=0xa07
microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
audit: initializing netlink socket (disabled)
type=2000 audit(1323565521.172:1): initialized
HugeTLB registered 2 MB page size, pre-allocated 0 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
fuse init (API version 7.17)
Btrfs loaded
msgmni has been set to 15942
SELinux:  Registering netfilter hooks
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
pcieport 0000:00:01.0: setting latency timer to 64
pcieport 0000:00:01.0: irq 40 for MSI/MSI-X
pcieport 0000:00:1c.0: setting latency timer to 64
pcieport 0000:00:1c.0: irq 41 for MSI/MSI-X
pcieport 0000:00:1c.1: setting latency timer to 64
pcieport 0000:00:1c.1: irq 42 for MSI/MSI-X
intel_idle: MWAIT substates: 0x22220
intel_idle: does not run on family 6 model 23
input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input0
ACPI: Power Button [PWRB]
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
ACPI: Power Button [PWRF]
ACPI: acpi_idle registered with cpuidle
ERST: Table is not found!
GHES: HEST is not enabled!
EINJ: Table is not found!
ERST DBG: ERST support is disabled.
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
Non-volatile memory driver v1.3
Linux agpgart interface v0.103
[drm] Initialized drm 1.1.0 20060810
[drm] radeon defaulting to kernel modesetting.
[drm] radeon kernel modesetting enabled.
radeon 0000:04:01.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[drm] initializing kernel modesetting (RV280 0x1002:0x5965 0x1002:0x2002).
[drm] register mmio base: 0xFEBE0000
[drm] register mmio size: 65536
[drm] Generation 2 PCI interface, using max accessible memory
radeon 0000:04:01.0: VRAM: 64M 0x00000000E8000000 - 0x00000000EBFFFFFF (64M used)
radeon 0000:04:01.0: GTT: 512M 0x00000000C8000000 - 0x00000000E7FFFFFF
[drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
[drm] Driver supports precise vblank timestamp query.
[drm] radeon: irq initialized.
[drm] Detected VRAM RAM=64M, BAR=64M
[drm] RAM width 64bits DDR
[TTM] Zone  kernel: Available graphics memory: 4081286 kiB.
[TTM] Zone   dma32: Available graphics memory: 2097152 kiB.
[TTM] Initializing pool allocator.
[drm] radeon: 64M of VRAM memory ready
[drm] radeon: 512M of GTT memory ready.
[drm] GART: num cpu pages 131072, num gpu pages 131072
radeon 0000:04:01.0: WB enabled
[drm] Loading R200 Microcode
[drm] radeon: ring at 0x00000000C8001000
[drm] ring test succeeded in 3 usecs
[drm] radeon: ib pool ready.
[drm] ib test succeeded in 0 usecs
[drm] Radeon Display Connectors
[drm] Connector 0:
[drm]   DVI-I
[drm]   HPD2
[drm]   DDC: 0x60 0x60 0x60 0x60 0x60 0x60 0x60 0x60
[drm]   Encoders:
[drm]     CRT1: INTERNAL_DAC1
[drm]     DFP2: INTERNAL_DVO1
[drm] Connector 1:
[drm]   DVI-I
[drm]   HPD1
[drm]   DDC: 0x64 0x64 0x64 0x64 0x64 0x64 0x64 0x64
[drm]   Encoders:
[drm]     CRT2: INTERNAL_DAC2
[drm]     DFP1: INTERNAL_TMDS1
[drm] Radeon display connector DVI-I-1: Found valid EDID
[drm] Radeon display connector DVI-I-2: Found valid EDID
[drm] fb mappable at 0xE8040000
[drm] vram apper at 0xE8000000
[drm] size 8294400
[drm] fb depth is 24
[drm]    pitch is 7680
fbcon: radeondrmfb (fb0) is primary device
Console: switching to colour frame buffer device 240x67
fb0: radeondrmfb frame buffer device
drm: registered panic notifier
[drm] Initialized radeon 2.11.0 20080528 for 0000:04:01.0 on minor 0
nouveau 0000:01:00.0: enabling device (0000 -> 0002)
nouveau 0000:01:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
nouveau 0000:01:00.0: setting latency timer to 64
[drm] nouveau 0000:01:00.0: Detected an NV40 generation card (0x046100a3)
[drm] nouveau 0000:01:00.0: Attempting to load BIOS image from PRAMIN
[drm] nouveau 0000:01:00.0: ... BIOS signature not found
[drm] nouveau 0000:01:00.0: Attempting to load BIOS image from PROM
[drm] nouveau 0000:01:00.0: ... appears to be valid
[drm] nouveau 0000:01:00.0: BIT BIOS found
[drm] nouveau 0000:01:00.0: Bios version 05.72.22.19
[drm] nouveau 0000:01:00.0: TMDS table version 1.1
[drm] nouveau 0000:01:00.0: BIT table 'd' not found
[drm] nouveau 0000:01:00.0: Found Display Configuration Block version 3.0
[drm] nouveau 0000:01:00.0: Raw DCB entry 0: 01000300 00000028
[drm] nouveau 0000:01:00.0: Raw DCB entry 1: 01000302 00000000
[drm] nouveau 0000:01:00.0: Raw DCB entry 2: 02011310 00000028
[drm] nouveau 0000:01:00.0: Raw DCB entry 3: 04011312 00000000
[drm] nouveau 0000:01:00.0: Raw DCB entry 4: 020223f1 00c0c083
[drm] nouveau 0000:01:00.0: DCB connector table: VHER 0x30 5 10 2
[drm] nouveau 0000:01:00.0:   0: 0x00001130: type 0x30 idx 0 tag 0x07
[drm] nouveau 0000:01:00.0:   1: 0x00002130: type 0x30 idx 1 tag 0x08
[drm] nouveau 0000:01:00.0:   2: 0x00000210: type 0x10 idx 2 tag 0xff
[drm] nouveau 0000:01:00.0:   3: 0x00000211: type 0x11 idx 3 tag 0xff
[drm] nouveau 0000:01:00.0:   4: 0x00000213: type 0x13 idx 4 tag 0xff
[drm] nouveau 0000:01:00.0: Adaptor not initialised, running VBIOS init tables.
[drm] nouveau 0000:01:00.0: Parsing VBIOS init table 0 at offset 0xE09E
[drm] nouveau 0000:01:00.0: Parsing VBIOS init table 1 at offset 0xE3BB
[drm] nouveau 0000:01:00.0: Parsing VBIOS init table 2 at offset 0xE942
[drm] nouveau 0000:01:00.0: Parsing VBIOS init table 3 at offset 0xEA9A
[drm] nouveau 0000:01:00.0: Parsing VBIOS init table 4 at offset 0xEC4A
[drm] nouveau 0000:01:00.0: mem timing table length unknown: 14
[drm] nouveau 0000:01:00.0: timingset 255 does not exist
[drm] nouveau 0000:01:00.0: 1 available performance level(s)
[drm] nouveau 0000:01:00.0: 0: memory 648MHz core 450MHz fanspeed 100%
[drm] nouveau 0000:01:00.0: c: memory 391MHz core 200MHz
[drm] nouveau 0000:01:00.0: Detected 128MiB VRAM
HELGE: pci_find_capability(dev->pdev, PCI_CAP_ID_EXP) = 120
HELGE: pci_is_pcie(dev->pdev) = 1
HELGE: Overriding pci_is_pcie() result to force 64MB GART
[drm] nouveau 0000:01:00.0: 64 MiB GART (aperture)
[drm] nouveau 0000:01:00.0: Saving VGA fonts
Refined TSC clocksource calibration: 3066.666 MHz.
[drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
[drm] No driver support for vblank timestamp query.
[drm] nouveau 0000:01:00.0: Setting dpms mode 3 on vga encoder (output 0)
[drm] nouveau 0000:01:00.0: Setting dpms mode 3 on tmds encoder (output 1)
[drm] nouveau 0000:01:00.0: Setting dpms mode 3 on vga encoder (output 2)
[drm] nouveau 0000:01:00.0: Setting dpms mode 3 on tmds encoder (output 3)
[drm] nouveau 0000:01:00.0: Setting dpms mode 3 on TV encoder (output 4)
Switching to clocksource tsc
[drm] nouveau 0000:01:00.0: Load detected on output B
[drm] nouveau 0000:01:00.0: allocated 1920x1080 fb: 0x49000, bo ffff880225a1e800
fb1: nouveaufb frame buffer device
[drm] Initialized nouveau 0.0.16 20090420 for 0000:01:00.0 on minor 1
...

