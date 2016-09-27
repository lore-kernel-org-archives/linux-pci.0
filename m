Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Ondrej Zary <linux@rainbow-software.org>,
        Sinan Kaya <okaya@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: 4.7 regression: ACPI: No IRQ available for PCI Interrupt Link [LNKD]. Try pci=noacpi or acpi=off
Date: Wed, 28 Sep 2016 00:58:15 +0200
Message-ID: <4220489.2ZUOL1U5cK@vostro.rjw.lan>
In-Reply-To: <201609280023.31987.linux@rainbow-software.org>
References: <201609251512.05657.linux@rainbow-software.org> <5551312.D3H9D4JOFc@vostro.rjw.lan> <201609280023.31987.linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, September 28, 2016 12:23:31 AM Ondrej Zary wrote:
> On Tuesday 27 September 2016 23:32:26 Rafael J. Wysocki wrote:
> > On Tuesday, September 27, 2016 11:02:22 PM Ondrej Zary wrote:
> > > On Monday 26 September 2016 14:23:01 Rafael J. Wysocki wrote:
> > > > On Sunday, September 25, 2016 03:12:05 PM Ondrej Zary wrote:
> > > > > Hello,
> > > > > I've upgraded kernel (Debian Squeeze - backports) from 4.6
> > > > > (4.6.4-1~bpo8+1) to 4.7 (4.7.2-1~bpo8+1) and IRQs stopped working
> > > > > with error messages like this:
> > > > >
> > > > > ACPI: No IRQ available for PCI Interrupt Link [LNKD]. Try pci=noacpi
> > > > > or acpi=off
> > > > >
> > > > > The same thing appeared on two different machines. Is it a
> > > > > known/fixed bug?
> > > >
> > > > Well, maybe.
> > > >
> > > > Can you try 4.8-rc8, please?
> > >
> > > Just tested 4.8-rc8 on another (3rd) machine with the same problem. The
> > > bug is still present in 4.8-rc8.
> >
> > The problem wasn't known then.
> >
> > > All machines are Pentium 3 PCI/ISA systems.
> >
> > This probably is related to the way the ISA IRQs are handled.
> >
> > Here's a list of commits to revert, in this order:
> >
> > f7eca374f000 ACPI,PCI,IRQ: separate ISA penalty calculation
> > 487cf917ed0d Revert "ACPI, PCI, IRQ: remove redundant code in
> > acpi_irq_penalty_init()" 4a6e68bf96c1 ACPI,PCI,IRQ: factor in PCI possible
> > 54794580f594 ACPI,PCI,IRQ: correct operator precedence
> > 9e5ed6d1fb87 ACPI,PCI,IRQ: remove SCI penalize function
> > 1fcb6a813c4f ACPI,PCI,IRQ: remove redundant code in acpi_irq_penalty_init()
> > 5c5087a55390 ACPI,PCI,IRQ: reduce static IRQ array size to 16
> > 103544d86976 ACPI,PCI,IRQ: reduce resource requirements
> >
> > Please try to revert the first 5 first and see if that helps.
> 
> Bisected it to this:
> 
> 103544d86976338057d6a91f721b49d3acc7df7f is the first bad commit
> commit 103544d86976338057d6a91f721b49d3acc7df7f
> Author: Sinan Kaya <okaya@codeaurora.org>
> Date:   Sun Apr 17 13:36:53 2016 -0400
> 
>     ACPI,PCI,IRQ: reduce resource requirements
> 
>     Code has been redesigned to calculate penalty requirements on the fly. This
>     significantly simplifies the implementation and removes some of the init
>     calls from x86 architecture.
> 
>     Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>     Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> :040000 040000 9bf16c388d23bb66e087809f069eafed18e46a8c bcac95fb33ee834aec7d23eab9eb0dc5e330c68c M      drivers

OK

Sinan, can you help, please?


> > > [    0.000000] Linux version 4.8.0-rc8+ (zary@gsql) (gcc version 4.7.2
> > > (Debian 4.7.2-5) ) #84 SMP Tue Sep 27 22:37:05 CEST 2016 [    0.000000]
> > > x86/fpu: Legacy x87 FPU detected.
> > > [    0.000000] x86/fpu: Using 'eager' FPU context switches.
> > > [    0.000000] e820: BIOS-provided physical RAM map:
> > > [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff]
> > > usable [    0.000000] BIOS-e820: [mem
> > > 0x000000000009fc00-0x000000000009ffff] reserved [    0.000000] BIOS-e820:
> > > [mem 0x00000000000f0000-0x00000000000fffff] reserved [    0.000000]
> > > BIOS-e820: [mem 0x0000000000100000-0x000000001ffeffff] usable [   
> > > 0.000000] BIOS-e820: [mem 0x000000001fff0000-0x000000001fff2fff] ACPI NVS
> > > [    0.000000] BIOS-e820: [mem 0x000000001fff3000-0x000000001fffffff]
> > > ACPI data [    0.000000] BIOS-e820: [mem
> > > 0x00000000ffff0000-0x00000000ffffffff] reserved [    0.000000] Notice: NX
> > > (Execute Disable) protection missing in CPU! [    0.000000] SMBIOS 2.2
> > > present.
> > > [    0.000000] DMI: VIA Technologies, Inc. VT82C694X/694X, BIOS 6.00 PG
> > > 02/19/2002 [    0.000000] e820: update [mem 0x00000000-0x00000fff] usable
> > > ==> reserved [    0.000000] e820: remove [mem 0x000a0000-0x000fffff]
> > > usable
> > > [    0.000000] e820: last_pfn = 0x1fff0 max_arch_pfn = 0x100000
> > > [    0.000000] MTRR default type: uncachable
> > > [    0.000000] MTRR fixed ranges enabled:
> > > [    0.000000]   00000-9FFFF write-back
> > > [    0.000000]   A0000-AFFFF uncachable
> > > [    0.000000]   B0000-BFFFF write-combining
> > > [    0.000000]   C0000-C9FFF write-protect
> > > [    0.000000]   CA000-EFFFF uncachable
> > > [    0.000000]   F0000-F7FFF write-through
> > > [    0.000000]   F8000-F8FFF uncachable
> > > [    0.000000]   F9000-FFFFF write-through
> > > [    0.000000] MTRR variable ranges enabled:
> > > [    0.000000]   0 base 000000000 mask FE0000000 write-back
> > > [    0.000000]   1 base 0E0000000 mask FFC000000 write-combining
> > > [    0.000000]   2 disabled
> > > [    0.000000]   3 disabled
> > > [    0.000000]   4 disabled
> > > [    0.000000]   5 disabled
> > > [    0.000000]   6 disabled
> > > [    0.000000]   7 disabled
> > > [    0.000000] x86/PAT: PAT not supported by CPU.
> > > [    0.000000] x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC-
> > > UC [    0.000000] initial memory mapped: [mem 0x00000000-0x01bfffff] [   
> > > 0.000000] Base memory trampoline at [c009b000] 9b000 size 16384 [   
> > > 0.000000] BRK [0x016b1000, 0x016b1fff] PGTABLE
> > > [    0.000000] ACPI: Early table checksum verification disabled
> > > [    0.000000] ACPI: RSDP 0x00000000000F6C00 000014 (v00 VIA694)
> > > [    0.000000] ACPI: RSDT 0x000000001FFF3000 000028 (v01 VIA694 AWRDACPI
> > > 42302E31 AWRD 00000000) [    0.000000] ACPI: FACP 0x000000001FFF3040
> > > 000074 (v01 VIA694 AWRDACPI 42302E31 AWRD 00000000) [    0.000000] ACPI:
> > > DSDT 0x000000001FFF30C0 002587 (v01 VIA694 AWRDACPI 00001000 MSFT
> > > 0100000C) [    0.000000] ACPI: FACS 0x000000001FFF0000 000040
> > > [    0.000000] 0MB HIGHMEM available.
> > > [    0.000000] 511MB LOWMEM available.
> > > [    0.000000]   mapped low ram: 0 - 1fff0000
> > > [    0.000000]   low ram: 0 - 1fff0000
> > > [    0.000000] BRK [0x016b2000, 0x016b2fff] PGTABLE
> > > [    0.000000] Zone ranges:
> > > [    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> > > [    0.000000]   Normal   [mem 0x0000000001000000-0x000000001ffeffff]
> > > [    0.000000]   HighMem  empty
> > > [    0.000000] Movable zone start for each node
> > > [    0.000000] Early memory node ranges
> > > [    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
> > > [    0.000000]   node   0: [mem 0x0000000000100000-0x000000001ffeffff]
> > > [    0.000000] Initmem setup node 0 [mem
> > > 0x0000000000001000-0x000000001ffeffff] [    0.000000] On node 0
> > > totalpages: 130958
> > > [    0.000000] free_area_init_node: node 0, pgdat c15ad140, node_mem_map
> > > dfbf0020 [    0.000000]   DMA zone: 32 pages used for memmap
> > > [    0.000000]   DMA zone: 0 pages reserved
> > > [    0.000000]   DMA zone: 3998 pages, LIFO batch:0
> > > [    0.000000]   Normal zone: 992 pages used for memmap
> > > [    0.000000]   Normal zone: 126960 pages, LIFO batch:31
> > > [    0.000000] Using APIC driver default
> > > [    0.000000] ACPI: PM-Timer IO Port: 0x4008
> > > [    0.000000] smpboot: Allowing 1 CPUs, 0 hotplug CPUs
> > > [    0.000000] Local APIC disabled by BIOS -- you can enable it with
> > > "lapic" [    0.000000] APIC: disable apic facility
> > > [    0.000000] APIC: switched to apic NOOP
> > > [    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
> > > [    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
> > > [    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
> > > [    0.000000] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
> > > [    0.000000] e820: [mem 0x20000000-0xfffeffff] available for PCI
> > > devices [    0.000000] clocksource: refined-jiffies: mask: 0xffffffff
> > > max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns [    0.000000]
> > > setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:1 nr_node_ids:1 [   
> > > 0.000000] percpu: Embedded 19 pages/cpu @dfbd9000 s47980 r0 d29844 u77824
> > > [    0.000000] pcpu-alloc: s47980 r0 d29844 u77824 alloc=19*4096 [   
> > > 0.000000] pcpu-alloc: [0] 0
> > > [    0.000000] Built 1 zonelists in Zone order, mobility grouping on. 
> > > Total pages: 129934 [    0.000000] Kernel command line:
> > > BOOT_IMAGE=/boot/vmlinuz-4.8.0-rc8+ root=/dev/sda1 ro resume=/dev/sda2 [ 
> > >   0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes) [   
> > > 0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
> > > [    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072
> > > bytes) [    0.000000] Initializing CPU#0
> > > [    0.000000] Initializing HighMem for node 0 (00000000:00000000)
> > > [    0.000000] Memory: 512308K/523832K available (3909K kernel code, 438K
> > > rwdata, 1512K rodata, 520K init, 412K bss, 11524K reserved, 0K
> > > cma-reserved, 0K highmem)
> > > [    0.000000] virtual kernel memory layout:
> > >     fixmap  : 0xfff17000 - 0xfffff000   ( 928 kB)
> > >     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
> > >     vmalloc : 0xe07f0000 - 0xff7fe000   ( 496 MB)
> > >     lowmem  : 0xc0000000 - 0xdfff0000   ( 511 MB)
> > >       .init : 0xc15bc000 - 0xc163e000   ( 520 kB)
> > >       .data : 0xc13d1a45 - 0xc15baba0   (1956 kB)
> > >       .text : 0xc1000000 - 0xc13d1a45   (3910 kB)
> > > [    0.000000] Checking if this processor honours the WP bit even in
> > > supervisor mode...Ok. [    0.000000] SLUB: HWalign=32, Order=0-3,
> > > MinObjects=0, CPUs=1, Nodes=1 [    0.000000] Hierarchical RCU
> > > implementation.
> > > [    0.000000] 	Build-time adjustment of leaf fanout to 32.
> > > [    0.000000] 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=1.
> > > [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32,
> > > nr_cpu_ids=1 [    0.000000] NR_IRQS:2304 nr_irqs:32 16
> > > [    0.000000] CPU 0 irqstacks, hard=df41c000 soft=df41e000
> > > [    0.000000] Console: colour VGA+ 80x25
> > > [    0.000000] console [tty0] enabled
> > > [    0.000000] tsc: Fast TSC calibration using PIT
> > > [    0.000000] tsc: Detected 1199.320 MHz processor
> > > [    0.008010] Calibrating delay loop (skipped), value calculated using
> > > timer frequency.. 2398.64 BogoMIPS (lpj=4797280) [    0.008105] pid_max:
> > > default: 32768 minimum: 301
> > > [    0.008178] ACPI: Core revision 20160422
> > > [    0.013685] ACPI: 1 ACPI AML tables successfully acquired and loaded
> > >
> > > [    0.013826] ACPI: setting ELCR to 0800 (from 0e00)
> > > [    0.013944] Mount-cache hash table entries: 1024 (order: 0, 4096
> > > bytes) [    0.013991] Mountpoint-cache hash table entries: 1024 (order:
> > > 0, 4096 bytes) [    0.014824] Last level iTLB entries: 4KB 32, 2MB 0, 4MB
> > > 2
> > > [    0.014892] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 8, 1GB 0
> > > [    0.018506] Freeing SMP alternatives memory: 16K (c163e000 - c1642000)
> > > [    0.020479] smpboot: Max logical packages: 1
> > > [    0.020539] smpboot: weird, boot CPU (#0) not listed by the BIOS
> > > [    0.020582] smpboot: SMP motherboard not detected
> > > [    0.020624] smpboot: SMP disabled
> > > [    0.020669] smpboot: Local APIC not detected. Using dummy APIC
> > > emulation. [    0.020716] Performance Events:
> > > [    0.020762] no APIC, boot with the "lapic" boot parameter to
> > > force-enable it. [    0.020842] no hardware sampling interrupt available.
> > > [    0.020891] p6 PMU driver.
> > > [    0.020938] ... version:                0
> > > [    0.020983] ... bit width:              32
> > > [    0.021025] ... generic registers:      2
> > > [    0.021067] ... value mask:             00000000ffffffff
> > > [    0.021114] ... max period:             000000007fffffff
> > > [    0.021156] ... fixed-purpose events:   0
> > > [    0.021198] ... event mask:             0000000000000003
> > > [    0.022255] x86: Booted up 1 node, 1 CPUs
> > > [    0.022322] smpboot: Total of 1 processors activated (2398.64
> > > BogoMIPS) [    0.022867] devtmpfs: initialized
> > > [    0.024554] PM: Registering ACPI NVS region [mem
> > > 0x1fff0000-0x1fff2fff] (12288 bytes) [    0.024796] clocksource: jiffies:
> > > mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
> > > [    0.025130] NET: Registered protocol family 16
> > > [    0.025602] cpuidle: using governor ladder
> > > [    0.025650] cpuidle: using governor menu
> > > [    0.025804] clocksource: pit: mask: 0xffffffff max_cycles: 0xffffffff,
> > > max_idle_ns: 1601818034827 ns [    0.025873] ACPI: bus type PCI
> > > registered
> > > [    0.069121] PCI: PCI BIOS revision 2.10 entry at 0xfb200, last bus=1
> > > [    0.069171] PCI: Using configuration type 1 for base access
> > > [    0.072932] HugeTLB registered 4 MB page size, pre-allocated 0 pages
> > > [    0.073415] ACPI: Added _OSI(Module Device)
> > > [    0.073465] ACPI: Added _OSI(Processor Device)
> > > [    0.073510] ACPI: Added _OSI(3.0 _SCP Extensions)
> > > [    0.073554] ACPI: Added _OSI(Processor Aggregator Device)
> > > [    0.078216] ACPI: Interpreter enabled
> > > [    0.078337] ACPI: (supports S0 S1 S4 S5)
> > > [    0.078384] ACPI: Using PIC for interrupt routing
> > > [    0.078482] PCI: Ignoring host bridge windows from ACPI; if necessary,
> > > use "pci=use_crs" and report a bug [    0.086125] ACPI: PCI Root Bridge
> > > [PCI0] (domain 0000 [bus 00-ff]) [    0.086201] acpi PNP0A03:00: _OSC: OS
> > > supports [Segments MSI] [    0.086258] acpi PNP0A03:00: _OSC failed
> > > (AE_NOT_FOUND); disabling ASPM [    0.086313] acpi PNP0A03:00: fail to
> > > add MMCONFIG information, can't access extended PCI configuration space
> > > under this bridge. [    0.086488] acpi PNP0A03:00: host bridge window [io
> > >  0x0cf8-0x0cff] (ignored) [    0.086494] acpi PNP0A03:00: host bridge
> > > window [io  0x0000-0x0cf7 window] (ignored) [    0.086498] acpi
> > > PNP0A03:00: host bridge window [io  0x0d00-0x3fff window] (ignored) [   
> > > 0.086502] acpi PNP0A03:00: host bridge window [io  0x4000-0x407f]
> > > (ignored) [    0.086506] acpi PNP0A03:00: host bridge window [io 
> > > 0x4080-0x40ff] (ignored) [    0.086511] acpi PNP0A03:00: host bridge
> > > window [io  0x4100-0x4fff window] (ignored) [    0.086515] acpi
> > > PNP0A03:00: host bridge window [io  0x5000-0x500f] (ignored) [   
> > > 0.086519] acpi PNP0A03:00: host bridge window [io  0x5010-0x5fff window]
> > > (ignored) [    0.086523] acpi PNP0A03:00: host bridge window [io 
> > > 0x6000-0x607f] (ignored) [    0.086527] acpi PNP0A03:00: host bridge
> > > window [io  0x6080-0xffff window] (ignored) [    0.086532] acpi
> > > PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff window]
> > > (ignored) [    0.086537] acpi PNP0A03:00: host bridge window [mem
> > > 0x000c0000-0x000dffff window] (ignored) [    0.086541] acpi PNP0A03:00:
> > > host bridge window [mem 0x20000000-0xffefffff window] (ignored) [   
> > > 0.086544] PCI: root bus 00: using default resources
> > > [    0.086666] PCI host bridge to bus 0000:00
> > > [    0.086717] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> > > [    0.086764] pci_bus 0000:00: root bus resource [mem
> > > 0x00000000-0xffffffff] [    0.086814] pci_bus 0000:00: root bus resource
> > > [bus 00-ff]
> > > [    0.086882] pci 0000:00:00.0: [1106:0691] type 00 class 0x060000
> > > [    0.086904] pci 0000:00:00.0: reg 0x10: [mem 0xe0000000-0xe3ffffff
> > > pref] [    0.087143] pci 0000:00:01.0: [1106:8598] type 01 class 0x060400
> > > [    0.087195] pci 0000:00:01.0: supports D1
> > > [    0.087350] pci 0000:00:07.0: [1106:0686] type 00 class 0x060100
> > > [    0.087597] pci 0000:00:07.1: [1106:0571] type 00 class 0x01018a
> > > [    0.087642] pci 0000:00:07.1: reg 0x20: [io  0xd000-0xd00f]
> > > [    0.087663] pci 0000:00:07.1: legacy IDE quirk: reg 0x10: [io 
> > > 0x01f0-0x01f7] [    0.087714] pci 0000:00:07.1: legacy IDE quirk: reg
> > > 0x14: [io  0x03f6] [    0.087765] pci 0000:00:07.1: legacy IDE quirk: reg
> > > 0x18: [io  0x0170-0x0177] [    0.087812] pci 0000:00:07.1: legacy IDE
> > > quirk: reg 0x1c: [io  0x0376] [    0.088125] pci 0000:00:07.2:
> > > [1106:3038] type 00 class 0x0c0300 [    0.088168] pci 0000:00:07.2: reg
> > > 0x20: [io  0xd400-0xd41f]
> > > [    0.088301] pci 0000:00:07.2: System wakeup disabled by ACPI
> > > [    0.088463] pci 0000:00:07.3: [1106:3038] type 00 class 0x0c0300
> > > [    0.088504] pci 0000:00:07.3: reg 0x20: [io  0xd800-0xd81f]
> > > [    0.088633] pci 0000:00:07.3: System wakeup disabled by ACPI
> > > [    0.088789] pci 0000:00:07.4: [1106:3057] type 00 class 0x068000
> > > [    0.088853] pci 0000:00:07.4: quirk: [io  0x6000-0x607f] claimed by
> > > vt82c686 HW-mon [    0.088908] pci 0000:00:07.4: quirk: [io 
> > > 0x5000-0x500f] claimed by vt82c686 SMB [    0.089142] pci 0000:00:07.5:
> > > [1106:3058] type 00 class 0x040100 [    0.089160] pci 0000:00:07.5: reg
> > > 0x10: [io  0xdc00-0xdcff]
> > > [    0.089172] pci 0000:00:07.5: reg 0x14: [io  0xe000-0xe003]
> > > [    0.089183] pci 0000:00:07.5: reg 0x18: [io  0xe400-0xe403]
> > > [    0.089412] pci 0000:00:0f.0: [10ec:8139] type 00 class 0x020000
> > > [    0.089429] pci 0000:00:0f.0: reg 0x10: [io  0xe800-0xe8ff]
> > > [    0.089441] pci 0000:00:0f.0: reg 0x14: [mem 0xe8000000-0xe80000ff]
> > > [    0.089504] pci 0000:00:0f.0: supports D1 D2
> > > [    0.089509] pci 0000:00:0f.0: PME# supported from D1 D2 D3hot
> > > [    0.089749] pci 0000:01:00.0: [10de:002d] type 00 class 0x030000
> > > [    0.089766] pci 0000:01:00.0: reg 0x10: [mem 0xe6000000-0xe6ffffff]
> > > [    0.089777] pci 0000:01:00.0: reg 0x14: [mem 0xe4000000-0xe5ffffff
> > > pref] [    0.089810] pci 0000:01:00.0: reg 0x30: [mem
> > > 0x00000000-0x0000ffff pref] [    0.089958] pci 0000:00:01.0: PCI bridge
> > > to [bus 01]
> > > [    0.090014] pci 0000:00:01.0:   bridge window [mem
> > > 0xe6000000-0xe7ffffff] [    0.090020] pci 0000:00:01.0:   bridge window
> > > [mem 0xe4000000-0xe5ffffff pref] [    0.090032] pci_bus 0000:00: on NUMA
> > > node 0
> > > [    0.090426] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11
> > > 12 14 15) [    0.091138] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6
> > > 7 10 11 12 14 15) *0, disabled. [    0.092038] ACPI: PCI Interrupt Link
> > > [LNKC] (IRQs 1 3 4 5 6 7 *10 11 12 14 15) [    0.092804] ACPI: PCI
> > > Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *9 [    0.095235]
> > > vgaarb: setting as boot device: PCI:0000:01:00.0
> > > [    0.095293] vgaarb: device added:
> > > PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none [    0.095341]
> > > vgaarb: loaded
> > > [    0.095386] vgaarb: bridge control possible 0000:01:00.0
> > > [    0.095661] SCSI subsystem initialized
> > > [    0.095878] libata version 3.00 loaded.
> > > [    0.095896] ACPI: bus type USB registered
> > > [    0.096073] usbcore: registered new interface driver usbfs
> > > [    0.096148] usbcore: registered new interface driver hub
> > > [    0.096230] usbcore: registered new device driver usb
> > > [    0.096350] PCI: Using ACPI for IRQ routing
> > > [    0.096402] PCI: pci_cache_line_size set to 32 bytes
> > > [    0.096449] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
> > > [    0.096455] e820: reserve RAM buffer [mem 0x1fff0000-0x1fffffff]
> > > [    0.097427] clocksource: Switched to clocksource pit
> > > [    0.116833] pnp: PnP ACPI init
> > > [    0.117738] system 00:00: [mem 0x000ca800-0x000cbfff] has been
> > > reserved [    0.117805] system 00:00: [mem 0x000f0000-0x000f7fff] could
> > > not be reserved [    0.117857] system 00:00: [mem 0x000f8000-0x000fbfff]
> > > could not be reserved [    0.117905] system 00:00: [mem
> > > 0x000fc000-0x000fffff] could not be reserved [    0.117954] system 00:00:
> > > [mem 0x1fff0000-0x1fffffff] could not be reserved [    0.118002] system
> > > 00:00: [mem 0xffff0000-0xffffffff] has been reserved [    0.118050]
> > > system 00:00: [mem 0x00000000-0x0009ffff] could not be reserved [   
> > > 0.118097] system 00:00: [mem 0x00100000-0x1ffeffff] could not be reserved
> > > [    0.118145] system 00:00: [mem 0xfee00000-0xfee00fff] has been
> > > reserved [    0.118203] system 00:00: Plug and Play ACPI device, IDs
> > > PNP0c01 (active) [    0.118842] system 00:01: [io  0x04d0-0x04d1] has
> > > been reserved [    0.118907] system 00:01: Plug and Play ACPI device, IDs
> > > PNP0c02 (active) [    0.119009] pnp 00:02: Plug and Play ACPI device, IDs
> > > PNP0b00 (active) [    0.119293] pnp 00:03: [dma 2]
> > > [    0.119384] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
> > > [    0.120364] pnp 00:04: Plug and Play ACPI device, IDs PNP0f13 (active)
> > > [    0.120478] pnp 00:05: Plug and Play ACPI device, IDs PNP0303 (active)
> > > [    0.120532] pnp: PnP ACPI: found 6 devices
> > > [    0.120592] PnPBIOS: Disabled
> > > [    0.160276] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff,
> > > max_idle_ns: 2085701024 ns [    0.161542] clocksource: Switched to
> > > clocksource acpi_pm
> > > [    0.161652] pci 0000:01:00.0: BAR 6: assigned [mem
> > > 0xe7000000-0xe700ffff pref] [    0.161709] pci 0000:00:01.0: PCI bridge
> > > to [bus 01]
> > > [    0.161761] pci 0000:00:01.0:   bridge window [mem
> > > 0xe6000000-0xe7ffffff] [    0.161809] pci 0000:00:01.0:   bridge window
> > > [mem 0xe4000000-0xe5ffffff pref] [    0.161866] pci_bus 0000:00: resource
> > > 4 [io  0x0000-0xffff]
> > > [    0.161871] pci_bus 0000:00: resource 5 [mem 0x00000000-0xffffffff]
> > > [    0.161877] pci_bus 0000:01: resource 1 [mem 0xe6000000-0xe7ffffff]
> > > [    0.161881] pci_bus 0000:01: resource 2 [mem 0xe4000000-0xe5ffffff
> > > pref] [    0.161988] NET: Registered protocol family 2
> > > [    0.162559] TCP established hash table entries: 4096 (order: 2, 16384
> > > bytes) [    0.162763] TCP bind hash table entries: 4096 (order: 3, 32768
> > > bytes) [    0.162929] TCP: Hash tables configured (established 4096 bind
> > > 4096) [    0.163066] UDP hash table entries: 256 (order: 1, 8192 bytes) [
> > >    0.163145] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes) [   
> > > 0.163420] NET: Registered protocol family 1
> > > [    0.163533] pci 0000:00:01.0: disabling DAC on VIA PCI bridge
> > > [    0.163587] pci 0000:00:07.0: Disabling VIA external APIC routing
> > > [    0.164770] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
> > > [    0.164825] PCI: setting IRQ 10 as level-triggered
> > > [    0.164840] pci 0000:00:07.2: VIA VLink IRQ fixup, from 9 to 10
> > > [    0.165239] pci 0000:00:07.3: VIA VLink IRQ fixup, from 9 to 10
> > > [    0.165485] pci 0000:01:00.0: Video device with shadowed ROM at [mem
> > > 0x000c0000-0x000dffff] [    0.165537] PCI: CLS 32 bytes, default 32
> > > [    0.166920] futex hash table entries: 256 (order: 1, 8192 bytes)
> > > [    0.168009] workingset: timestamp_bits=30 max_order=17 bucket_order=0
> > > [    0.176534] Block layer SCSI generic (bsg) driver version 0.4 loaded
> > > (major 253) [    0.176609] io scheduler noop registered
> > > [    0.176651] io scheduler deadline registered
> > > [    0.176801] io scheduler cfq registered (default)
> > > [    0.177529] input: Power Button as
> > > /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0 [    0.177600]
> > > ACPI: Power Button [PWRB]
> > > [    0.177798] input: Sleep Button as
> > > /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1 [    0.177850]
> > > ACPI: Sleep Button [SLPB]
> > > [    0.178049] input: Power Button as
> > > /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2 [    0.178100] ACPI: Power
> > > Button [PWRF]
> > > [    0.178286] tsc: Marking TSC unstable due to TSC halts in idle
> > > [    0.178460] Warning: Processor Platform Limit event detected, but not
> > > handled. [    0.178508] Consider compiling CPUfreq support into your
> > > kernel. [    0.179151] isapnp: Scanning for PnP cards...
> > > [    0.265736]  01:01: card 'SYM 53C416'
> > > [    0.265784] isapnp: 1 Plug & Play card detected total
> > > [    0.266013] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> > > [    0.267275] Non-volatile memory driver v1.3
> > > [    0.267329] Linux agpgart interface v0.103
> > > [    0.267439] [drm] Initialized drm 1.1.0 20060810
> > > [    0.275183] loop: module loaded
> > > [    0.275542] pata_via 0000:00:07.1: version 0.3.4
> > > [    0.276904] scsi host0: pata_via
> > > [    0.277327] scsi host1: pata_via
> > > [    0.277527] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xd000
> > > irq 14 [    0.277575] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma
> > > 0xd008 irq 15 [    0.277737] 8139cp: 8139cp: 10/100 PCI Ethernet driver
> > > v1.3 (Mar 22, 2004) [    0.277787] 8139cp 0000:00:0f.0: This (id
> > > 10ec:8139 rev 10) is not an 8139C+ compatible chip, use 8139too [   
> > > 0.277890] 8139too: 8139too Fast Ethernet driver 0.9.28
> > > [    0.278232] ACPI: No IRQ available for PCI Interrupt Link [LNKA]. Try
> > > pci=noacpi or acpi=off [    0.278288] 8139too 0000:00:0f.0: PCI INT A: no
> > > GSI
> > > [    0.279038] 8139too 0000:00:0f.0 eth0: RealTek RTL8139 at 0x0001e800,
> > > 00:40:95:30:81:14, IRQ 11 [    0.279138] ehci_hcd: USB 2.0 'Enhanced'
> > > Host Controller (EHCI) Driver [    0.279183] ehci-pci: EHCI PCI platform
> > > driver
> > > [    0.279278] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> > > [    0.279357] ohci-pci: OHCI PCI platform driver
> > > [    0.279427] uhci_hcd: USB Universal Host Controller Interface driver
> > > [    0.279720] uhci_hcd 0000:00:07.2: UHCI Host Controller
> > > [    0.279788] uhci_hcd 0000:00:07.2: new USB bus registered, assigned
> > > bus number 1 [    0.279894] uhci_hcd 0000:00:07.2: irq 10, io base
> > > 0x0000d400 [    0.281011] hub 1-0:1.0: USB hub found
> > > [    0.281092] hub 1-0:1.0: 2 ports detected
> > > [    0.281721] uhci_hcd 0000:00:07.3: UHCI Host Controller
> > > [    0.281797] uhci_hcd 0000:00:07.3: new USB bus registered, assigned
> > > bus number 2 [    0.281893] uhci_hcd 0000:00:07.3: irq 10, io base
> > > 0x0000d800 [    0.282482] hub 2-0:1.0: USB hub found
> > > [    0.282595] hub 2-0:1.0: 2 ports detected
> > > [    0.283075] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at
> > > 0x60,0x64 irq 1,12 [    0.283667] serio: i8042 KBD port at 0x60,0x64 irq
> > > 1
> > > [    0.283730] serio: i8042 AUX port at 0x60,0x64 irq 12
> > > [    0.284331] mousedev: PS/2 mouse device common for all mice
> > > [    0.285296] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
> > > [    0.285400] rtc_cmos 00:02: alarms up to one year, y3k, 242 bytes
> > > nvram [    0.285934] NET: Registered protocol family 17
> > > [    0.286133] Using IPI No-Shortcut mode
> > > [    0.286584] registered taskstats version 1
> > > [    0.287266] rtc_cmos 00:02: setting system clock to 2016-09-27
> > > 20:43:04 UTC (1475008984) [    0.287418] PM: Checking hibernation image
> > > partition /dev/sda2 [    0.311773] input: AT Translated Set 2 keyboard as
> > > /devices/platform/i8042/serio0/input/input3 [    0.502870] ata1.00:
> > > ATA-6: WDC WD800JB-00FMA0, 13.03G13, max UDMA/100 [    0.502930] ata1.00:
> > > 156301488 sectors, multi 16: LBA
> > > [    0.505854] ata1.00: configured for UDMA/100
> > > [    0.506375] scsi 0:0:0:0: Direct-Access     ATA      WDC WD800JB-00FM
> > > 3G13 PQ: 0 ANSI: 5 [    0.507373] sd 0:0:0:0: [sda] 156301488 512-byte
> > > logical blocks: (80.0 GB/74.5 GiB) [    0.507596] sd 0:0:0:0: [sda] Write
> > > Protect is off
> > > [    0.507648] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> > > [    0.507707] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
> > > enabled, doesn't support DPO or FUA [    0.553107]  sda: sda1 sda2 sda3
> > > [    0.554228] sd 0:0:0:0: [sda] Attached SCSI disk
> > > [    1.184053] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:
> > > 0x1149995dc85, max_idle_ns: 440795227643 ns [    1.226056] random: fast
> > > init done
> > > [    1.737001] input: PS/2 BYD TouchPad as
> > > /devices/platform/i8042/serio1/input/input5 [    1.739929] PM:
> > > Hibernation image partition 8:2 present
> > > [    1.739931] PM: Looking for hibernation image.
> > > [    1.740502] PM: Image not found (code -22)
> > > [    1.740506] PM: Hibernation image not present or could not be loaded.
> > > [    1.741097] EXT4-fs (sda1): mounting ext3 file system using the ext4
> > > subsystem [    1.780634] EXT4-fs (sda1): mounted filesystem with ordered
> > > data mode. Opts: (null) [    1.780754] VFS: Mounted root (ext3
> > > filesystem) readonly on device 8:1. [    1.782233] Freeing unused kernel
> > > memory: 520K (c15bc000 - c163e000) [    1.782586] Write protecting the
> > > kernel text: 3912k
> > > [    1.782711] Write protecting the kernel read-only data: 1516k
> > > [    4.713077] random: crng init done
> > > [    4.875889] systemd-udevd[179]: starting version 215
> > > [    6.732786] agpgart: Detected VIA Apollo Pro 133 chipset
> > > [    6.741940] agpgart-via 0000:00:00.0: AGP aperture is 64M @ 0xe0000000
> > > [    6.933193] parport_pc: VIA 686A/8231 detected
> > > [    6.933202] parport_pc: probing current configuration
> > > [    6.933228] parport_pc: Current parallel port base: 0x0
> > > [    6.933233] parport_pc: VIA parallel port disabled in BIOS
> > > [    6.946452] sd 0:0:0:0: Attached scsi generic sg0 type 0
> > > [    7.370173] wmi: Mapper loaded
> > > [    7.853618] ACPI: No IRQ available for PCI Interrupt Link [LNKA]. Try
> > > pci=noacpi or acpi=off [    7.853697] nouveau 0000:01:00.0: PCI INT A: no
> > > GSI
> > > [    7.853990] ACPI: No IRQ available for PCI Interrupt Link [LNKA]. Try
> > > pci=noacpi or acpi=off [    7.854041] nouveau 0000:01:00.0: PCI INT A: no
> > > GSI
> > > [    7.854108] nouveau 0000:01:00.0: NVIDIA NV05 (20154000)
> > > [    7.886851] nouveau 0000:01:00.0: bios: version 02.05.20.02.00
> > > [    7.898215] nouveau 0000:01:00.0: bios: DCB table not found
> > > [    7.900378] nouveau 0000:01:00.0: bios: DCB table not found
> > > [    7.900929] nouveau 0000:01:00.0: bios: DCB table not found
> > > [    7.900985] nouveau 0000:01:00.0: bios: DCB table not found
> > > [    7.901070] nouveau 0000:01:00.0: bios: DCB table not found
> > > [    7.902468] agpgart-via 0000:00:00.0: AGP 2.0 bridge
> > > [    7.902545] agpgart-via 0000:00:00.0: putting AGP V2 device into 4x
> > > mode [    7.902621] nouveau 0000:01:00.0: putting AGP V2 device into 4x
> > > mode [    7.902709] nouveau 0000:01:00.0: tmr: unknown input clock freq [
> > >    7.906600] nouveau 0000:01:00.0: fb: 32 MiB SDRAM
> > > [    7.929267] [TTM] Zone  kernel: Available graphics memory: 256422 kiB
> > > [    7.929337] [TTM] Initializing pool allocator
> > > [    7.929915] nouveau 0000:01:00.0: DRM: VRAM: 31 MiB
> > > [    7.929979] nouveau 0000:01:00.0: DRM: GART: 64 MiB
> > > [    7.930029] nouveau 0000:01:00.0: DRM: BMP version 5.6
> > > [    7.930076] nouveau 0000:01:00.0: DRM: No DCB data found in VBIOS
> > > [    7.935501] nouveau 0000:01:00.0: DRM: Saving VGA fonts
> > > [    8.000369] nouveau 0000:01:00.0: DRM: No DCB data found in VBIOS
> > > [    8.005083] [drm] Supports vblank timestamp caching Rev 2
> > > (21.10.2013). [    8.005149] [drm] Driver supports precise vblank
> > > timestamp query. [    8.015551] nouveau 0000:01:00.0: DRM: MM: using M2MF
> > > for buffer copies [    8.052291] nouveau 0000:01:00.0: DRM: allocated
> > > 1280x1024 fb: 0x4000, bo dd760400 [    8.052887] fbcon: nouveaufb (fb0)
> > > is primary device
> > > [    8.282416] nouveau 0000:01:00.0: DRM: GPU lockup - switching to
> > > software fbcon [    8.288553] Console: switching to colour frame buffer
> > > device 160x64 [    8.304464] nouveau 0000:01:00.0: fb0: nouveaufb frame
> > > buffer device [    8.304564] [drm] Initialized nouveau 1.3.1 20120801 for
> > > 0000:01:00.0 on minor 0 [    9.418370] EXT4-fs (sda1): re-mounted. Opts:
> > > (null)
> > > [   10.079477] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
> > > [   11.701457] i2c /dev entries driver
> > > [   17.047969] 8139too 0000:00:0f.0 eth0: link up, 10Mbps, half-duplex,
> > > lpa 0x0000 [   28.896052] ------------[ cut here ]------------
> > > [   28.899751] WARNING: CPU: 0 PID: 0 at net/sched/sch_generic.c:316
> > > dev_watchdog+0xaf/0x10b [   28.900021] NETDEV WATCHDOG: eth0 (8139too):
> > > transmit queue 0 timed out [   28.900021] Modules linked in: i2c_dev
> > > nouveau wmi video hwmon ttm sg parport_pc parport via_agp [   28.900021]
> > > CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.0-rc8+ #84 [   28.900021]
> > > Hardware name: VIA Technologies, Inc. VT82C694X/694X, BIOS 6.00 PG
> > > 02/19/2002 [   28.900021]  00000000 c11aa094 df41ff44 00000000 c1033dc5
> > > 0000013c 00000009 df5aa000 [   28.900021]  00000000 fffef740 df5aa240
> > > c1033e4b 00000009 00000000 df41ff44 c1502916 [   28.900021]  df41ff5c
> > > c131b446 c150294f 0000013c c1502916 df5aa000 c14f38cc 00000000 [  
> > > 28.900021] Call Trace:
> > > [   28.900021]  [<c11aa094>] ? dump_stack+0x44/0x58
> > > [   28.900021]  [<c1033dc5>] ? __warn+0xc1/0xd8
> > > [   28.900021]  [<c1033e4b>] ? warn_slowpath_fmt+0x2b/0x30
> > > [   28.900021]  [<c131b446>] ? dev_watchdog+0xaf/0x10b
> > > [   28.900021]  [<c131b397>] ? netif_tx_lock+0x51/0x51
> > > [   28.900021]  [<c1071afd>] ? call_timer_fn+0x49/0xee
> > > [   28.900021]  [<c1071d40>] ? __run_timers.part.29+0x10e/0x14a
> > > [   28.900021]  [<c1276f9a>] ? scsi_finish_command+0xb9/0xd8
> > > [   28.900021]  [<c1071eba>] ? run_timer_softirq+0x1e/0x43
> > > [   28.900021]  [<c1037368>] ? __do_softirq+0xb6/0x203
> > > [   28.900021]  [<c10372b2>] ? perf_trace_irq_handler_entry+0xd4/0xd4
> > > [   28.900021]  [<c101338a>] ? do_softirq_own_stack+0x1a/0x1f
> > > [   28.900021]  <IRQ>  [<c10375de>] ? irq_exit+0x31/0x70
> > > [   28.900021]  [<c1012e50>] ? do_IRQ+0x7a/0x8b
> > > [   28.900021]  [<c13d080c>] ? common_interrupt+0x2c/0x34
> > > [   28.900021]  [<c12e324d>] ? cpuidle_enter_state+0xf8/0x1b4
> > > [   28.900021]  [<c1059623>] ? cpu_startup_entry+0x188/0x209
> > > [   28.900021]  [<c15bca12>] ? start_kernel+0x30f/0x312
> > > [   28.900021] ---[ end trace d2a6e90b9c4ffc81 ]---
> > > [   31.968232] 8139too 0000:00:0f.0 eth0: link up, 10Mbps, half-duplex,
> > > lpa 0x0000 [   44.000081] 8139too 0000:00:0f.0 eth0: link up, 10Mbps,
> > > half-duplex, lpa 0x0000 [   57.056093] 8139too 0000:00:0f.0 eth0: link
> > > up, 10Mbps, half-duplex, lpa 0x0000 [   69.088087] 8139too 0000:00:0f.0
> > > eth0: link up, 10Mbps, half-duplex, lpa 0x0000 [  104.928090] 8139too
> > > 0000:00:0f.0 eth0: link up, 10Mbps, half-duplex, lpa 0x0000 [ 
> > > 172.000086] 8139too 0000:00:0f.0 eth0: link up, 10Mbps, half-duplex, lpa
> > > 0x0000 [  306.144086] 8139too 0000:00:0f.0 eth0: link up, 10Mbps,
> > > half-duplex, lpa 0x0000 [  367.328086] 8139too 0000:00:0f.0 eth0: link
> > > up, 10Mbps, half-duplex, lpa 0x0000 [  434.144088] 8139too 0000:00:0f.0
> > > eth0: link up, 10Mbps, half-duplex, lpa 0x0000 [  568.288086] 8139too
> > > 0000:00:0f.0 eth0: link up, 10Mbps, half-duplex, lpa 0x0000 [ 
> > > 636.128083] 8139too 0000:00:0f.0 eth0: link up, 10Mbps, half-duplex, lpa
> > > 0x0000 [  702.176086] 8139too 0000:00:0f.0 eth0: link up, 10Mbps,
> > > half-duplex, lpa 0x0000

