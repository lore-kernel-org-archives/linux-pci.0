Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Ondrej Zary <linux@rainbow-software.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: 4.7 regression: ACPI: No IRQ available for PCI Interrupt Link [LNKD]. Try pci=noacpi or acpi=off
Date: Wed, 28 Sep 2016 10:32:34 +0200
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <201609251512.05657.linux@rainbow-software.org> <4220489.2ZUOL1U5cK@vostro.rjw.lan> <d3fd8f7a-520d-d204-87d8-e9f59fb8f180@codeaurora.org>
In-Reply-To: <d3fd8f7a-520d-d204-87d8-e9f59fb8f180@codeaurora.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201609281032.35190.linux@rainbow-software.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 28 September 2016, Sinan Kaya wrote:
> On 9/27/2016 6:58 PM, Rafael J. Wysocki wrote:
> >> :040000 040000 9bf16c388d23bb66e087809f069eafed18e46a8c
> >> : bcac95fb33ee834aec7d23eab9eb0dc5e330c68c M      drivers
> >
> > OK
> >
> > Sinan, can you help, please?
>
> Sure, let's see what's going on. I was writing an email.
>
> Can we apply this and collect the kernel log? It also helps to see the
> kernel log from a working combination.

This is from yet another machine with the same problem:

[    0.000000] Linux version 4.8.0-rc8+ (zary@gsql) (gcc version 4.7.2 (Debian 4.7.2-5) ) #100 SMP Wed Sep 28 10:19:26 CEST 2016
[    0.000000] x86/fpu: Legacy x87 FPU detected.
[    0.000000] x86/fpu: Using 'eager' FPU context switches.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000006ffbfff] usable
[    0.000000] BIOS-e820: [mem 0x0000000006ffc000-0x0000000006ffefff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000006fff000-0x0000000006ffffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000ffff0000-0x00000000ffffffff] reserved
[    0.000000] Notice: NX (Execute Disable) protection missing in CPU!
[    0.000000] SMBIOS 2.3 present.
[    0.000000] DMI: System Manufacturer System Name/A7VL133, BIOS ASUS A7VL133-VM ACPI BIOS Revision 1008 06/10/2002
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x6ffc max_arch_pfn = 0x100000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-FFFFF uncachable
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask FFC000000 write-back
[    0.000000]   1 base 004000000 mask FFE000000 write-back
[    0.000000]   2 base 006000000 mask FFF000000 write-back
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 base 0F8000000 mask FFC000000 write-combining
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT  
[    0.000000] initial memory mapped: [mem 0x00000000-0x01bfffff]
[    0.000000] Base memory trampoline at [c009b000] 9b000 size 16384
[    0.000000] BRK [0x016b7000, 0x016b7fff] PGTABLE
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F6DA0 000014 (v00 ASUS  )
[    0.000000] ACPI: RSDT 0x0000000006FFC000 00002C (v01 ASUS   A7VL133  30303031 MSFT 31313031)
[    0.000000] ACPI: FACP 0x0000000006FFC080 000074 (v01 ASUS   A7VL133  30303031 MSFT 31313031)
[    0.000000] ACPI: DSDT 0x0000000006FFC100 0027F0 (v01 ASUS   A7VL133  00001000 MSFT 0100000B)
[    0.000000] ACPI: FACS 0x0000000006FFF000 000040
[    0.000000] ACPI: BOOT 0x0000000006FFC040 000028 (v01 ASUS   A7VL133  30303031 MSFT 31313031)
[    0.000000] 0MB HIGHMEM available.
[    0.000000] 111MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 06ffc000
[    0.000000]   low ram: 0 - 06ffc000
[    0.000000] BRK [0x016b8000, 0x016b8fff] PGTABLE
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   Normal   [mem 0x0000000001000000-0x0000000006ffbfff]
[    0.000000]   HighMem  empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x0000000006ffbfff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x0000000006ffbfff]
[    0.000000] On node 0 totalpages: 28570
[    0.000000] free_area_init_node: node 0, pgdat c15b1840, node_mem_map c6f1c020
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
[    0.000000]   Normal zone: 192 pages used for memmap
[    0.000000]   Normal zone: 24572 pages, LIFO batch:3
[    0.000000] Using APIC driver default
[    0.000000] ACPI: PM-Timer IO Port: 0xe408
[    0.000000] smpboot: Allowing 1 CPUs, 0 hotplug CPUs
[    0.000000] Local APIC disabled by BIOS -- you can enable it with "lapic"
[    0.000000] APIC: disable apic facility
[    0.000000] APIC: switched to apic NOOP
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.000000] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.000000] e820: [mem 0x07000000-0xfffeffff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:1 nr_node_ids:1
[    0.000000] percpu: Embedded 19 pages/cpu @c6f06000 s47980 r0 d29844 u77824
[    0.000000] pcpu-alloc: s47980 r0 d29844 u77824 alloc=19*4096
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 28346
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-test root=/dev/sda1 ro quiet
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Initializing CPU#0
[    0.000000] Initializing HighMem for node 0 (00000000:00000000)
[    0.000000] Memory: 106224K/114280K available (3918K kernel code, 436K rwdata, 1520K rodata, 524K init, 412K bss, 8056K reserved, 0K cma-reserved, 0K highmem)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xfff17000 - 0xfffff000   ( 928 kB)
[    0.000000]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[    0.000000]     vmalloc : 0xc77fc000 - 0xff7fe000   ( 896 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc6ffc000   ( 111 MB)
[    0.000000]       .init : 0xc15c1000 - 0xc1644000   ( 524 kB)
[    0.000000]       .data : 0xc13d3cc1 - 0xc15bf2e0   (1965 kB)
[    0.000000]       .text : 0xc1000000 - 0xc13d3cc1   (3919 kB)
[    0.000000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 32.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=1
[    0.000000] NR_IRQS:2304 nr_irqs:32 16
[    0.000000] CPU 0 irqstacks, hard=c681c000 soft=c681e000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 857.600 MHz processor
[    0.004010] Calibrating delay loop (skipped), value calculated using timer frequency.. 1715.20 BogoMIPS (lpj=3430400)
[    0.004022] pid_max: default: 32768 minimum: 301
[    0.004068] ACPI: Core revision 20160422
[    0.010184] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.010197] 
[    0.010206] ACPI: setting ELCR to 0200 (from 0e20)
[    0.010294] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.010300] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.011345] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.011355] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.017561] Freeing SMP alternatives memory: 16K (c1644000 - c1648000)
[    0.018157] smpboot: Max logical packages: 1
[    0.018168] smpboot: weird, boot CPU (#0) not listed by the BIOS
[    0.018171] smpboot: SMP motherboard not detected
[    0.018173] smpboot: SMP disabled
[    0.018181] smpboot: Local APIC not detected. Using dummy APIC emulation.
[    0.018187] Performance Events: 
[    0.018197] no APIC, boot with the "lapic" boot parameter to force-enable it.
[    0.018200] no hardware sampling interrupt available.
[    0.018207] AMD PMU driver.
[    0.018218] ... version:                0
[    0.018222] ... bit width:              48
[    0.018224] ... generic registers:      4
[    0.018227] ... value mask:             0000ffffffffffff
[    0.018230] ... max period:             00007fffffffffff
[    0.018233] ... fixed-purpose events:   0
[    0.018236] ... event mask:             000000000000000f
[    0.019597] x86: Booted up 1 node, 1 CPUs
[    0.019609] smpboot: Total of 1 processors activated (1715.20 BogoMIPS)
[    0.020276] devtmpfs: initialized
[    0.021405] PM: Registering ACPI NVS region [mem 0x06fff000-0x06ffffff] (4096 bytes)
[    0.021676] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.022170] NET: Registered protocol family 16
[    0.022847] cpuidle: using governor ladder
[    0.022857] cpuidle: using governor menu
[    0.022964] Simple Boot Flag at 0x3a set to 0x1
[    0.022988] clocksource: pit: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1601818034827 ns
[    0.023009] ACPI: bus type PCI registered
[    0.029726] PCI: PCI BIOS revision 2.10 entry at 0xf10c0, last bus=1
[    0.029734] PCI: Using configuration type 1 for base access
[    0.035763] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[    0.036523] ACPI: Added _OSI(Module Device)
[    0.036530] ACPI: Added _OSI(Processor Device)
[    0.036534] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.036538] ACPI: Added _OSI(Processor Aggregator Device)
[    0.040657] ACPI: Interpreter enabled
[    0.040744] ACPI: (supports S0 S1 S4 S5)
[    0.040753] ACPI: Using PIC for interrupt routing
[    0.040871] PCI: Ignoring host bridge windows from ACPI; if necessary, use "pci=use_crs" and report a bug
[    0.054034] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[    0.054245] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
[    0.054444] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
[    0.054640] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
[    0.054855] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.054877] acpi PNP0A03:00: _OSC: OS supports [Segments MSI]
[    0.054898] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.054914] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.055070] acpi PNP0A03:00: host bridge window [io  0x0cf8-0x0cff] (ignored)
[    0.055077] acpi PNP0A03:00: host bridge window [io  0x0000-0x0cf7 window] (ignored)
[    0.055085] acpi PNP0A03:00: host bridge window [io  0x0d00-0xffff window] (ignored)
[    0.055092] acpi PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff window] (ignored)
[    0.055097] acpi PNP0A03:00: host bridge window [mem 0x000c8000-0x000dffff window] (ignored)
[    0.055104] acpi PNP0A03:00: host bridge window [mem 0x07000000-0xffffffff window] (ignored)
[    0.055108] PCI: root bus 00: using default resources
[    0.055345] PCI host bridge to bus 0000:00
[    0.055354] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.055361] pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffff]
[    0.055371] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.055417] pci 0000:00:00.0: [1106:0305] type 00 class 0x060000
[    0.055444] pci 0000:00:00.0: reg 0x10: [mem 0xf8000000-0xfbffffff pref]
[    0.055810] pci 0000:00:01.0: [1106:8305] type 01 class 0x060400
[    0.055872] pci 0000:00:01.0: supports D1
[    0.056082] pci 0000:00:01.0: System wakeup disabled by ACPI
[    0.056321] pci 0000:00:07.0: [1106:0686] type 00 class 0x060100
[    0.056689] pci 0000:00:07.1: [1106:0571] type 00 class 0x01018a
[    0.056741] pci 0000:00:07.1: reg 0x20: [io  0xd800-0xd80f]
[    0.056766] pci 0000:00:07.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.056771] pci 0000:00:07.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.056777] pci 0000:00:07.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.056782] pci 0000:00:07.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.057053] pci 0000:00:07.2: [1106:3038] type 00 class 0x0c0300
[    0.057100] pci 0000:00:07.2: reg 0x20: [io  0xd400-0xd41f]
[    0.057243] pci 0000:00:07.2: System wakeup disabled by ACPI
[    0.057436] pci 0000:00:07.3: [1106:3038] type 00 class 0x0c0300
[    0.057482] pci 0000:00:07.3: reg 0x20: [io  0xd000-0xd01f]
[    0.057625] pci 0000:00:07.3: System wakeup disabled by ACPI
[    0.057836] pci 0000:00:07.4: [1106:3057] type 00 class 0x068000
[    0.057912] pci 0000:00:07.4: quirk: [io  0xe200-0xe27f] claimed by vt82c686 HW-mon
[    0.057920] pci 0000:00:07.4: quirk: [io  0xe800-0xe80f] claimed by vt82c686 SMB
[    0.058190] pci 0000:00:07.5: [1106:3058] type 00 class 0x040100
[    0.058211] pci 0000:00:07.5: reg 0x10: [io  0xb800-0xb8ff]
[    0.058224] pci 0000:00:07.5: reg 0x14: [io  0xb400-0xb403]
[    0.058237] pci 0000:00:07.5: reg 0x18: [io  0xb000-0xb003]
[    0.058555] pci 0000:00:0e.0: [10ec:8139] type 00 class 0x020000
[    0.058576] pci 0000:00:0e.0: reg 0x10: [io  0xa400-0xa4ff]
[    0.058590] pci 0000:00:0e.0: reg 0x14: [mem 0xee800000-0xee8000ff]
[    0.058631] pci 0000:00:0e.0: reg 0x30: [mem 0x00000000-0x00007fff pref]
[    0.058671] pci 0000:00:0e.0: supports D1 D2
[    0.058677] pci 0000:00:0e.0: PME# supported from D1 D2 D3hot D3cold
[    0.059066] pci 0000:01:00.0: [5333:8a26] type 00 class 0x030000
[    0.059088] pci 0000:01:00.0: reg 0x10: [mem 0xef000000-0xef07ffff]
[    0.059101] pci 0000:01:00.0: reg 0x14: [mem 0xf0000000-0xf7ffffff pref]
[    0.059140] pci 0000:01:00.0: reg 0x30: [mem 0xefff0000-0xefffffff pref]
[    0.059187] pci 0000:01:00.0: supports D1 D2
[    0.059361] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.059372] pci 0000:00:01.0:   bridge window [mem 0xef000000-0xefdfffff]
[    0.059381] pci 0000:00:01.0:   bridge window [mem 0xeff00000-0xf7ffffff pref]
[    0.059394] pci_bus 0000:00: on NUMA node 0
[    0.062505] vgaarb: setting as boot device: PCI:0000:01:00.0
[    0.062519] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.062522] vgaarb: loaded
[    0.062526] vgaarb: bridge control possible 0000:01:00.0
[    0.062863] SCSI subsystem initialized
[    0.063130] libata version 3.00 loaded.
[    0.063166] ACPI: bus type USB registered
[    0.063311] usbcore: registered new interface driver usbfs
[    0.063363] usbcore: registered new interface driver hub
[    0.063430] usbcore: registered new device driver usb
[    0.063583] PCI: Using ACPI for IRQ routing
[    0.063597] PCI: pci_cache_line_size set to 32 bytes
[    0.063658] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.063666] e820: reserve RAM buffer [mem 0x06ffc000-0x07ffffff]
[    0.065228] clocksource: Switched to clocksource pit
[    0.089545] pnp: PnP ACPI init
[    0.090193] system 00:00: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.090206] system 00:00: [mem 0x000f0000-0x000fffff] could not be reserved
[    0.090213] system 00:00: [mem 0x00100000-0x06ffffff] could not be reserved
[    0.090221] system 00:00: [mem 0xfffe0000-0xffffffff] could not be reserved
[    0.090228] system 00:00: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.090247] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.090961] system 00:01: [io  0x03f0-0x03f1] has been reserved
[    0.090972] system 00:01: [io  0x04d0-0x04d1] has been reserved
[    0.090988] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.091223] system 00:02: [io  0xe400-0xe47f] has been reserved
[    0.091232] system 00:02: [io  0xe800-0xe80f] has been reserved
[    0.091239] system 00:02: [io  0xe200-0xe27f] has been reserved
[    0.091249] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.091507] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[8]=0x110000 active = 1
[    0.091628] pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.092009] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[6]=0x11005c active = 1
[    0.092019] pnp 00:04: [dma 2]
[    0.092052] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[6]=0x11105c active = 0
[    0.092162] pnp 00:04: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.092939] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[7]=0x11005c active = 1
[    0.092947] pnp 00:05: [dma 3]
[    0.092992] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[5]=0x1105c active = 0
[    0.092997] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[7]=0x11105c active = 0
[    0.093019] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[5]=0x1205c active = 0
[    0.093023] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[7]=0x11205c active = 0
[    0.093044] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[5]=0x1305c active = 0
[    0.093049] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[7]=0x11305c active = 0
[    0.093167] pnp 00:05: Plug and Play ACPI device, IDs PNP0401 (active)
[    0.093653] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[4]=0x11005c active = 1
[    0.093691] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[4]=0x11105c active = 0
[    0.093705] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[3]=0x1105c active = 0
[    0.093719] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[4]=0x11205c active = 0
[    0.093732] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[3]=0x1205c active = 0
[    0.093745] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[3]=0x1305c active = 0
[    0.093750] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[4]=0x11305c active = 0
[    0.093754] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[5]=0x1405c active = 0
[    0.093758] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[7]=0x11405c active = 0
[    0.093763] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[10]=0x105c active = 0
[    0.093767] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[12]=0x10105c active = 0
[    0.093927] pnp 00:06: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.094485] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[3]=0x11305c active = 1
[    0.094521] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[3]=0x11405c active = 0
[    0.094535] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[4]=0x11405c active = 0
[    0.094548] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[3]=0x11505c active = 0
[    0.094561] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[4]=0x11505c active = 0
[    0.094574] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[3]=0x11605c active = 0
[    0.094579] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[4]=0x11605c active = 0
[    0.094583] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[5]=0x1505c active = 0
[    0.094587] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[7]=0x11505c active = 0
[    0.094592] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[10]=0x205c active = 0
[    0.094596] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[12]=0x10205c active = 0
[    0.094735] pnp 00:07: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.095186] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[1]=0x1100000 active = 1
[    0.095309] pnp 00:08: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.095458] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[12]=0x20205c active = 1
[    0.095560] pnp 00:09: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.095767] pnp: PnP ACPI: found 10 devices
[    0.095783] PnPBIOS: Disabled
[    0.138561] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.138631] clocksource: Switched to clocksource acpi_pm
[    0.138719] pci 0000:00:0e.0: BAR 6: assigned [mem 0x08000000-0x08007fff pref]
[    0.138733] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.138746] pci 0000:00:01.0:   bridge window [mem 0xef000000-0xefdfffff]
[    0.138809] pci 0000:00:01.0:   bridge window [mem 0xeff00000-0xf7ffffff pref]
[    0.138825] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
[    0.138831] pci_bus 0000:00: resource 5 [mem 0x00000000-0xffffffff]
[    0.138839] pci_bus 0000:01: resource 1 [mem 0xef000000-0xefdfffff]
[    0.138845] pci_bus 0000:01: resource 2 [mem 0xeff00000-0xf7ffffff pref]
[    0.138987] NET: Registered protocol family 2
[    0.139741] TCP established hash table entries: 1024 (order: 0, 4096 bytes)
[    0.139775] TCP bind hash table entries: 1024 (order: 1, 8192 bytes)
[    0.139823] TCP: Hash tables configured (established 1024 bind 1024)
[    0.139978] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    0.140121] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    0.140394] NET: Registered protocol family 1
[    0.140472] pci 0000:00:00.0: Applying VIA southbridge workaround
[    0.140485] pci 0000:00:01.0: disabling DAC on VIA PCI bridge
[    0.140500] pci 0000:00:07.0: Disabling VIA external APIC routing
[    0.140936] acpi_irq_get_penalty:512 adding SCI penalty: 16777216
[    0.140942] penalty[15] = 0x10005c
[    0.140944] penalty[14] = 0x10005c
[    0.140947] penalty[12] = 0x20205c
[    0.140950] penalty[11] = 0x5c
[    0.140953] penalty[10] = 0x205c
[    0.140957] acpi_irq_get_penalty:512 adding SCI penalty: 16777216
[    0.140960] penalty[9] = 0x100005c
[    0.140962] penalty[7] = 0x11505c
[    0.140966] penalty[6] = 0x11105c
[    0.140969] penalty[5] = 0x1505c
[    0.140971] penalty[4] = 0x11605c
[    0.140974] penalty[3] = 0x11605c
[    0.140978] ACPI: No IRQ available for PCI Interrupt Link [LNKD]. Try pci=noacpi or acpi=off
[    0.141058] acpi_irq_get_penalty:512 adding SCI penalty: 16777216
[    0.141068] pci 0000:00:07.2: PCI INT D: no GSI
[    0.141312] acpi_irq_get_penalty:512 adding SCI penalty: 16777216
[    0.141316] penalty[15] = 0x10005c
[    0.141319] penalty[14] = 0x10005c
[    0.141321] penalty[12] = 0x20205c
[    0.141324] penalty[11] = 0x5c
[    0.141327] penalty[10] = 0x205c
[    0.141330] acpi_irq_get_penalty:512 adding SCI penalty: 16777216
[    0.141333] penalty[9] = 0x100005c
[    0.141336] penalty[7] = 0x11505c
[    0.141338] penalty[6] = 0x11105c
[    0.141341] penalty[5] = 0x1505c
[    0.141344] penalty[4] = 0x11605c
[    0.141348] penalty[3] = 0x11605c
[    0.141351] ACPI: No IRQ available for PCI Interrupt Link [LNKD]. Try pci=noacpi or acpi=off
[    0.141409] acpi_irq_get_penalty:512 adding SCI penalty: 16777216
[    0.141415] pci 0000:00:07.3: PCI INT D: no GSI
[    0.141478] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.141483] PCI: CLS 32 bytes, default 32
[    0.143494] futex hash table entries: 256 (order: 1, 8192 bytes)
[    0.145297] workingset: timestamp_bits=30 max_order=15 bucket_order=0
[    0.159183] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.159199] io scheduler noop registered
[    0.159202] io scheduler deadline registered
[    0.159355] io scheduler cfq registered (default)
[    0.160660] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.160679] ACPI: Power Button [PWRB]
[    0.160964] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.160970] ACPI: Power Button [PWRF]
[    0.161146] tsc: Marking TSC unstable due to TSC halts in idle
[    0.161338] Warning: Processor Platform Limit event detected, but not handled.
[    0.161341] Consider compiling CPUfreq support into your kernel.
[    0.162248] isapnp: Scanning for PnP cards...
[    0.517039] isapnp: No Plug & Play device found
[    0.517342] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.538160] 00:06: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.559014] 00:07: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    0.560699] Non-volatile memory driver v1.3
[    0.560710] Linux agpgart interface v0.103
[    0.560832] [drm] Initialized drm 1.1.0 20060810
[    0.571352] loop: module loaded
[    0.571762] pata_via 0000:00:07.1: version 0.3.4
[    0.574838] scsi host0: pata_via
[    0.575344] scsi host1: pata_via
[    0.575585] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xd800 irq 14
[    0.575594] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xd808 irq 15
[    0.575826] 8139cp: 8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
[    0.575835] 8139cp 0000:00:0e.0: This (id 10ec:8139 rev 10) is not an 8139C+ compatible chip, use 8139too
[    0.575919] 8139too: 8139too Fast Ethernet driver 0.9.28
[    0.577052] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
[    0.577062] PCI: setting IRQ 10 as level-triggered
[    0.578035] 8139too 0000:00:0e.0 eth0: RealTek RTL8139 at 0x0001a400, 00:40:95:08:18:34, IRQ 10
[    0.578127] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.578131] ehci-pci: EHCI PCI platform driver
[    0.578206] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.578248] ohci-pci: OHCI PCI platform driver
[    0.578299] uhci_hcd: USB Universal Host Controller Interface driver
[    0.578691] acpi_irq_get_penalty:512 adding SCI penalty: 16777216
[    0.578697] penalty[15] = 0x10005c
[    0.578700] penalty[14] = 0x10005c
[    0.578703] penalty[12] = 0x20205c
[    0.578705] penalty[11] = 0x5c
[    0.578708] penalty[10] = 0x205c
[    0.578712] acpi_irq_get_penalty:512 adding SCI penalty: 16777216
[    0.578715] penalty[9] = 0x100005c
[    0.578718] penalty[7] = 0x11505c
[    0.578720] penalty[6] = 0x11105c
[    0.578723] penalty[5] = 0x1505c
[    0.578725] penalty[4] = 0x11605c
[    0.578728] penalty[3] = 0x11605c
[    0.578732] ACPI: No IRQ available for PCI Interrupt Link [LNKD]. Try pci=noacpi or acpi=off
[    0.578808] acpi_irq_get_penalty:512 adding SCI penalty: 16777216
[    0.578816] uhci_hcd 0000:00:07.2: PCI INT D: no GSI
[    0.578860] uhci_hcd 0000:00:07.2: UHCI Host Controller
[    0.578909] uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
[    0.578984] uhci_hcd 0000:00:07.2: irq 9, io base 0x0000d400
[    0.580387] hub 1-0:1.0: USB hub found
[    0.580465] hub 1-0:1.0: 2 ports detected
[    0.581316] acpi_irq_get_penalty:512 adding SCI penalty: 16777216
[    0.581326] penalty[15] = 0x10005c
[    0.581329] penalty[14] = 0x10005c
[    0.581332] penalty[12] = 0x20205c
[    0.581334] penalty[11] = 0x5c
[    0.581337] penalty[10] = 0x205c
[    0.581341] acpi_irq_get_penalty:512 adding SCI penalty: 16777216
[    0.581344] penalty[9] = 0x100005c
[    0.581346] penalty[7] = 0x11505c
[    0.581349] penalty[6] = 0x11105c
[    0.581352] penalty[5] = 0x1505c
[    0.581354] penalty[4] = 0x11605c
[    0.581357] penalty[3] = 0x11605c
[    0.581361] ACPI: No IRQ available for PCI Interrupt Link [LNKD]. Try pci=noacpi or acpi=off
[    0.581438] acpi_irq_get_penalty:512 adding SCI penalty: 16777216
[    0.581446] uhci_hcd 0000:00:07.3: PCI INT D: no GSI
[    0.581486] uhci_hcd 0000:00:07.3: UHCI Host Controller
[    0.581516] uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
[    0.581586] uhci_hcd 0000:00:07.3: irq 9, io base 0x0000d000
[    0.582600] hub 2-0:1.0: USB hub found
[    0.582638] hub 2-0:1.0: 2 ports detected
[    0.583338] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    0.583973] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.584010] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.584986] mousedev: PS/2 mouse device common for all mice
[    0.585896] rtc_cmos 00:03: RTC can wake from S4
[    0.586419] rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
[    0.586512] rtc_cmos 00:03: alarms up to one year, 242 bytes nvram
[    0.587333] NET: Registered protocol family 17
[    0.587494] Using IPI No-Shortcut mode
[    0.588475] registered taskstats version 1
[    0.589475] rtc_cmos 00:03: setting system clock to 2016-09-28 08:21:05 UTC (1475050865)
[    0.589623] PM: Hibernation image not present or could not be loaded.
[    0.616362] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input2
[    0.738820] ata1.00: ATA-4: ST33210A, 3.02, max UDMA/33
[    0.738831] ata1.00: 6346368 sectors, multi 16: LBA 
[    0.743732] ata1.00: configured for UDMA/33
[    0.744539] scsi 0:0:0:0: Direct-Access     ATA      ST33210A         3.02 PQ: 0 ANSI: 5
[    0.745531] sd 0:0:0:0: [sda] 6346368 512-byte logical blocks: (3.25 GB/3.03 GiB)
[    0.745740] sd 0:0:0:0: [sda] Write Protect is off
[    0.745749] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.745835] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    0.772855]  sda: sda1 sda2 < sda5 >
[    0.774617] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.078722] random: fast init done
[    1.152069] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0xc5c9f0f1ca, max_idle_ns: 440795218091 ns
[    2.211907] input: PS/2 BYD TouchPad as /devices/platform/i8042/serio1/input/input4
[    2.234159] EXT4-fs (sda1): mounting ext3 file system using the ext4 subsystem
[    2.271764] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[    2.271839] VFS: Mounted root (ext3 filesystem) readonly on device 8:1.
[    2.274668] Freeing unused kernel memory: 524K (c15c1000 - c1644000)
[    2.274995] Write protecting the kernel text: 3920k
[    2.275086] Write protecting the kernel read-only data: 1528k
[    4.398129] udevd (114): /proc/114/oom_adj is deprecated, please use /proc/114/oom_score_adj instead.
[    5.637243] random: crng init done
[    6.630603] Adding 112416k swap on /dev/sda5.  Priority:-1 extents:1 across:112416k 
[    6.653208] EXT4-fs (sda1): re-mounted. Opts: (null)
[    7.122483] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
[    9.045160] 8139too 0000:00:0e.0 eth0: link up, 100Mbps, full-duplex, lpa 0x45E1

No IRQ problems when I move the ethernet card to another PCI slot:
[    0.000000] Linux version 4.8.0-rc8+ (zary@gsql) (gcc version 4.7.2 (Debian 4.7.2-5) ) #100 SMP Wed Sep 28 10:19:26 CEST 2016
[    0.000000] x86/fpu: Legacy x87 FPU detected.
[    0.000000] x86/fpu: Using 'eager' FPU context switches.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000006ffbfff] usable
[    0.000000] BIOS-e820: [mem 0x0000000006ffc000-0x0000000006ffefff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000006fff000-0x0000000006ffffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000ffff0000-0x00000000ffffffff] reserved
[    0.000000] Notice: NX (Execute Disable) protection missing in CPU!
[    0.000000] SMBIOS 2.3 present.
[    0.000000] DMI: System Manufacturer System Name/A7VL133, BIOS ASUS A7VL133-VM ACPI BIOS Revision 1008 06/10/2002
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x6ffc max_arch_pfn = 0x100000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-FFFFF uncachable
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask FFC000000 write-back
[    0.000000]   1 base 004000000 mask FFE000000 write-back
[    0.000000]   2 base 006000000 mask FFF000000 write-back
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 base 0F8000000 mask FFC000000 write-combining
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT  
[    0.000000] initial memory mapped: [mem 0x00000000-0x01bfffff]
[    0.000000] Base memory trampoline at [c009b000] 9b000 size 16384
[    0.000000] BRK [0x016b7000, 0x016b7fff] PGTABLE
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F6DA0 000014 (v00 ASUS  )
[    0.000000] ACPI: RSDT 0x0000000006FFC000 00002C (v01 ASUS   A7VL133  30303031 MSFT 31313031)
[    0.000000] ACPI: FACP 0x0000000006FFC080 000074 (v01 ASUS   A7VL133  30303031 MSFT 31313031)
[    0.000000] ACPI: DSDT 0x0000000006FFC100 0027F0 (v01 ASUS   A7VL133  00001000 MSFT 0100000B)
[    0.000000] ACPI: FACS 0x0000000006FFF000 000040
[    0.000000] ACPI: BOOT 0x0000000006FFC040 000028 (v01 ASUS   A7VL133  30303031 MSFT 31313031)
[    0.000000] 0MB HIGHMEM available.
[    0.000000] 111MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 06ffc000
[    0.000000]   low ram: 0 - 06ffc000
[    0.000000] BRK [0x016b8000, 0x016b8fff] PGTABLE
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   Normal   [mem 0x0000000001000000-0x0000000006ffbfff]
[    0.000000]   HighMem  empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x0000000006ffbfff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x0000000006ffbfff]
[    0.000000] On node 0 totalpages: 28570
[    0.000000] free_area_init_node: node 0, pgdat c15b1840, node_mem_map c6f1c020
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
[    0.000000]   Normal zone: 192 pages used for memmap
[    0.000000]   Normal zone: 24572 pages, LIFO batch:3
[    0.000000] Using APIC driver default
[    0.000000] ACPI: PM-Timer IO Port: 0xe408
[    0.000000] smpboot: Allowing 1 CPUs, 0 hotplug CPUs
[    0.000000] Local APIC disabled by BIOS -- you can enable it with "lapic"
[    0.000000] APIC: disable apic facility
[    0.000000] APIC: switched to apic NOOP
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.000000] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.000000] e820: [mem 0x07000000-0xfffeffff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:1 nr_node_ids:1
[    0.000000] percpu: Embedded 19 pages/cpu @c6f06000 s47980 r0 d29844 u77824
[    0.000000] pcpu-alloc: s47980 r0 d29844 u77824 alloc=19*4096
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 28346
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-test root=/dev/sda1 ro quiet
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Initializing CPU#0
[    0.000000] Initializing HighMem for node 0 (00000000:00000000)
[    0.000000] Memory: 106224K/114280K available (3918K kernel code, 436K rwdata, 1520K rodata, 524K init, 412K bss, 8056K reserved, 0K cma-reserved, 0K highmem)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xfff17000 - 0xfffff000   ( 928 kB)
[    0.000000]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[    0.000000]     vmalloc : 0xc77fc000 - 0xff7fe000   ( 896 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc6ffc000   ( 111 MB)
[    0.000000]       .init : 0xc15c1000 - 0xc1644000   ( 524 kB)
[    0.000000]       .data : 0xc13d3cc1 - 0xc15bf2e0   (1965 kB)
[    0.000000]       .text : 0xc1000000 - 0xc13d3cc1   (3919 kB)
[    0.000000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 32.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=1
[    0.000000] NR_IRQS:2304 nr_irqs:32 16
[    0.000000] CPU 0 irqstacks, hard=c681c000 soft=c681e000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 857.704 MHz processor
[    0.004010] Calibrating delay loop (skipped), value calculated using timer frequency.. 1715.40 BogoMIPS (lpj=3430816)
[    0.004022] pid_max: default: 32768 minimum: 301
[    0.004071] ACPI: Core revision 20160422
[    0.010224] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.010240] 
[    0.010249] ACPI: setting ELCR to 0200 (from 0c20)
[    0.010344] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.010350] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.011572] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.011582] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.017658] Freeing SMP alternatives memory: 16K (c1644000 - c1648000)
[    0.018159] smpboot: Max logical packages: 1
[    0.018167] smpboot: weird, boot CPU (#0) not listed by the BIOS
[    0.018170] smpboot: SMP motherboard not detected
[    0.018172] smpboot: SMP disabled
[    0.018178] smpboot: Local APIC not detected. Using dummy APIC emulation.
[    0.018184] Performance Events: 
[    0.018192] no APIC, boot with the "lapic" boot parameter to force-enable it.
[    0.018195] no hardware sampling interrupt available.
[    0.018201] AMD PMU driver.
[    0.018210] ... version:                0
[    0.018213] ... bit width:              48
[    0.018215] ... generic registers:      4
[    0.018218] ... value mask:             0000ffffffffffff
[    0.018221] ... max period:             00007fffffffffff
[    0.018224] ... fixed-purpose events:   0
[    0.018227] ... event mask:             000000000000000f
[    0.019460] x86: Booted up 1 node, 1 CPUs
[    0.019474] smpboot: Total of 1 processors activated (1715.40 BogoMIPS)
[    0.020170] devtmpfs: initialized
[    0.021311] PM: Registering ACPI NVS region [mem 0x06fff000-0x06ffffff] (4096 bytes)
[    0.021593] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.022112] NET: Registered protocol family 16
[    0.022794] cpuidle: using governor ladder
[    0.022802] cpuidle: using governor menu
[    0.022914] Simple Boot Flag at 0x3a set to 0x1
[    0.022940] clocksource: pit: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1601818034827 ns
[    0.022963] ACPI: bus type PCI registered
[    0.029946] PCI: PCI BIOS revision 2.10 entry at 0xf10c0, last bus=1
[    0.029952] PCI: Using configuration type 1 for base access
[    0.036035] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[    0.036762] ACPI: Added _OSI(Module Device)
[    0.036768] ACPI: Added _OSI(Processor Device)
[    0.036772] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.036776] ACPI: Added _OSI(Processor Aggregator Device)
[    0.040978] ACPI: Interpreter enabled
[    0.041065] ACPI: (supports S0 S1 S4 S5)
[    0.041072] ACPI: Using PIC for interrupt routing
[    0.041182] PCI: Ignoring host bridge windows from ACPI; if necessary, use "pci=use_crs" and report a bug
[    0.054351] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[    0.054571] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    0.054775] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
[    0.054972] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
[    0.055186] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.055207] acpi PNP0A03:00: _OSC: OS supports [Segments MSI]
[    0.055228] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.055244] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.055399] acpi PNP0A03:00: host bridge window [io  0x0cf8-0x0cff] (ignored)
[    0.055406] acpi PNP0A03:00: host bridge window [io  0x0000-0x0cf7 window] (ignored)
[    0.055412] acpi PNP0A03:00: host bridge window [io  0x0d00-0xffff window] (ignored)
[    0.055419] acpi PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff window] (ignored)
[    0.055424] acpi PNP0A03:00: host bridge window [mem 0x000c8000-0x000dffff window] (ignored)
[    0.055431] acpi PNP0A03:00: host bridge window [mem 0x07000000-0xffffffff window] (ignored)
[    0.055435] PCI: root bus 00: using default resources
[    0.055669] PCI host bridge to bus 0000:00
[    0.055679] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.055685] pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffff]
[    0.055694] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.055738] pci 0000:00:00.0: [1106:0305] type 00 class 0x060000
[    0.055763] pci 0000:00:00.0: reg 0x10: [mem 0xf8000000-0xfbffffff pref]
[    0.056254] pci 0000:00:01.0: [1106:8305] type 01 class 0x060400
[    0.056324] pci 0000:00:01.0: supports D1
[    0.056430] pci 0000:00:01.0: System wakeup disabled by ACPI
[    0.056648] pci 0000:00:07.0: [1106:0686] type 00 class 0x060100
[    0.056992] pci 0000:00:07.1: [1106:0571] type 00 class 0x01018a
[    0.057044] pci 0000:00:07.1: reg 0x20: [io  0xd800-0xd80f]
[    0.057069] pci 0000:00:07.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.057074] pci 0000:00:07.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.057079] pci 0000:00:07.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.057085] pci 0000:00:07.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.057350] pci 0000:00:07.2: [1106:3038] type 00 class 0x0c0300
[    0.057398] pci 0000:00:07.2: reg 0x20: [io  0xd400-0xd41f]
[    0.057534] pci 0000:00:07.2: System wakeup disabled by ACPI
[    0.057726] pci 0000:00:07.3: [1106:3038] type 00 class 0x0c0300
[    0.057772] pci 0000:00:07.3: reg 0x20: [io  0xd000-0xd01f]
[    0.057911] pci 0000:00:07.3: System wakeup disabled by ACPI
[    0.058114] pci 0000:00:07.4: [1106:3057] type 00 class 0x068000
[    0.058189] pci 0000:00:07.4: quirk: [io  0xe200-0xe27f] claimed by vt82c686 HW-mon
[    0.058198] pci 0000:00:07.4: quirk: [io  0xe800-0xe80f] claimed by vt82c686 SMB
[    0.058459] pci 0000:00:07.5: [1106:3058] type 00 class 0x040100
[    0.058480] pci 0000:00:07.5: reg 0x10: [io  0xb800-0xb8ff]
[    0.058493] pci 0000:00:07.5: reg 0x14: [io  0xb400-0xb403]
[    0.058506] pci 0000:00:07.5: reg 0x18: [io  0xb000-0xb003]
[    0.058826] pci 0000:00:0f.0: [10ec:8139] type 00 class 0x020000
[    0.058847] pci 0000:00:0f.0: reg 0x10: [io  0xa400-0xa4ff]
[    0.058860] pci 0000:00:0f.0: reg 0x14: [mem 0xee800000-0xee8000ff]
[    0.058901] pci 0000:00:0f.0: reg 0x30: [mem 0x00000000-0x00007fff pref]
[    0.058940] pci 0000:00:0f.0: supports D1 D2
[    0.058946] pci 0000:00:0f.0: PME# supported from D1 D2 D3hot D3cold
[    0.059325] pci 0000:01:00.0: [5333:8a26] type 00 class 0x030000
[    0.059346] pci 0000:01:00.0: reg 0x10: [mem 0xef000000-0xef07ffff]
[    0.059359] pci 0000:01:00.0: reg 0x14: [mem 0xf0000000-0xf7ffffff pref]
[    0.059398] pci 0000:01:00.0: reg 0x30: [mem 0xefff0000-0xefffffff pref]
[    0.059445] pci 0000:01:00.0: supports D1 D2
[    0.059621] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.059632] pci 0000:00:01.0:   bridge window [mem 0xef000000-0xefdfffff]
[    0.059642] pci 0000:00:01.0:   bridge window [mem 0xeff00000-0xf7ffffff pref]
[    0.059655] pci_bus 0000:00: on NUMA node 0
[    0.062726] vgaarb: setting as boot device: PCI:0000:01:00.0
[    0.062738] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.062740] vgaarb: loaded
[    0.062744] vgaarb: bridge control possible 0000:01:00.0
[    0.063093] SCSI subsystem initialized
[    0.063371] libata version 3.00 loaded.
[    0.063409] ACPI: bus type USB registered
[    0.063558] usbcore: registered new interface driver usbfs
[    0.063611] usbcore: registered new interface driver hub
[    0.063680] usbcore: registered new device driver usb
[    0.063831] PCI: Using ACPI for IRQ routing
[    0.063845] PCI: pci_cache_line_size set to 32 bytes
[    0.063909] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.063917] e820: reserve RAM buffer [mem 0x06ffc000-0x07ffffff]
[    0.065500] clocksource: Switched to clocksource pit
[    0.089303] pnp: PnP ACPI init
[    0.089966] system 00:00: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.089980] system 00:00: [mem 0x000f0000-0x000fffff] could not be reserved
[    0.089987] system 00:00: [mem 0x00100000-0x06ffffff] could not be reserved
[    0.089994] system 00:00: [mem 0xfffe0000-0xffffffff] could not be reserved
[    0.090001] system 00:00: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.090019] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.090752] system 00:01: [io  0x03f0-0x03f1] has been reserved
[    0.090762] system 00:01: [io  0x04d0-0x04d1] has been reserved
[    0.090779] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.091016] system 00:02: [io  0xe400-0xe47f] has been reserved
[    0.091024] system 00:02: [io  0xe800-0xe80f] has been reserved
[    0.091031] system 00:02: [io  0xe200-0xe27f] has been reserved
[    0.091041] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.091311] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[8]=0x110000 active = 1
[    0.091433] pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.091820] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[6]=0x11005c active = 1
[    0.091830] pnp 00:04: [dma 2]
[    0.091863] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[6]=0x11105c active = 0
[    0.091975] pnp 00:04: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.092749] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[7]=0x11005c active = 1
[    0.092757] pnp 00:05: [dma 3]
[    0.092802] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[5]=0x1105c active = 0
[    0.092807] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[7]=0x11105c active = 0
[    0.092830] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[5]=0x1205c active = 0
[    0.092835] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[7]=0x11205c active = 0
[    0.092858] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[5]=0x1305c active = 0
[    0.092863] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[7]=0x11305c active = 0
[    0.092985] pnp 00:05: Plug and Play ACPI device, IDs PNP0401 (active)
[    0.093472] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[4]=0x11005c active = 1
[    0.093511] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[4]=0x11105c active = 0
[    0.093526] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[3]=0x1105c active = 0
[    0.093539] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[4]=0x11205c active = 0
[    0.093552] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[3]=0x1205c active = 0
[    0.093565] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[3]=0x1305c active = 0
[    0.093570] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[4]=0x11305c active = 0
[    0.093574] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[5]=0x1405c active = 0
[    0.093579] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[7]=0x11405c active = 0
[    0.093583] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[10]=0x105c active = 0
[    0.093588] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[12]=0x10105c active = 0
[    0.093748] pnp 00:06: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.094311] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[3]=0x11305c active = 1
[    0.094349] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[3]=0x11405c active = 0
[    0.094364] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[4]=0x11405c active = 0
[    0.094377] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[3]=0x11505c active = 0
[    0.094390] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[4]=0x11505c active = 0
[    0.094403] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[3]=0x11605c active = 0
[    0.094408] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[4]=0x11605c active = 0
[    0.094413] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[5]=0x1505c active = 0
[    0.094417] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[7]=0x11505c active = 0
[    0.094422] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[10]=0x205c active = 0
[    0.094426] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[12]=0x10205c active = 0
[    0.094722] pnp 00:07: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.095087] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[1]=0x1100000 active = 1
[    0.095202] pnp 00:08: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.095351] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[12]=0x20205c active = 1
[    0.095456] pnp 00:09: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.095669] pnp: PnP ACPI: found 10 devices
[    0.095684] PnPBIOS: Disabled
[    0.138327] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.138394] clocksource: Switched to clocksource acpi_pm
[    0.138478] pci 0000:00:0f.0: BAR 6: assigned [mem 0x08000000-0x08007fff pref]
[    0.138546] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.138559] pci 0000:00:01.0:   bridge window [mem 0xef000000-0xefdfffff]
[    0.138567] pci 0000:00:01.0:   bridge window [mem 0xeff00000-0xf7ffffff pref]
[    0.138582] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
[    0.138588] pci_bus 0000:00: resource 5 [mem 0x00000000-0xffffffff]
[    0.138595] pci_bus 0000:01: resource 1 [mem 0xef000000-0xefdfffff]
[    0.138601] pci_bus 0000:01: resource 2 [mem 0xeff00000-0xf7ffffff pref]
[    0.138734] NET: Registered protocol family 2
[    0.139467] TCP established hash table entries: 1024 (order: 0, 4096 bytes)
[    0.139499] TCP bind hash table entries: 1024 (order: 1, 8192 bytes)
[    0.139546] TCP: Hash tables configured (established 1024 bind 1024)
[    0.139695] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    0.139731] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    0.139989] NET: Registered protocol family 1
[    0.140180] pci 0000:00:00.0: Applying VIA southbridge workaround
[    0.140194] pci 0000:00:01.0: disabling DAC on VIA PCI bridge
[    0.140209] pci 0000:00:07.0: Disabling VIA external APIC routing
[    0.141111] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
[    0.141120] PCI: setting IRQ 5 as level-triggered
[    0.141821] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.141828] PCI: CLS 32 bytes, default 32
[    0.143758] futex hash table entries: 256 (order: 1, 8192 bytes)
[    0.145391] workingset: timestamp_bits=30 max_order=15 bucket_order=0
[    0.159112] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.159124] io scheduler noop registered
[    0.159127] io scheduler deadline registered
[    0.159279] io scheduler cfq registered (default)
[    0.160529] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.160550] ACPI: Power Button [PWRB]
[    0.160845] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.160853] ACPI: Power Button [PWRF]
[    0.161033] tsc: Marking TSC unstable due to TSC halts in idle
[    0.161222] Warning: Processor Platform Limit event detected, but not handled.
[    0.161224] Consider compiling CPUfreq support into your kernel.
[    0.162142] isapnp: Scanning for PnP cards...
[    0.516729] isapnp: No Plug & Play device found
[    0.517050] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.537878] 00:06: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.558719] 00:07: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    0.560392] Non-volatile memory driver v1.3
[    0.560403] Linux agpgart interface v0.103
[    0.560533] [drm] Initialized drm 1.1.0 20060810
[    0.571177] loop: module loaded
[    0.571577] pata_via 0000:00:07.1: version 0.3.4
[    0.574532] scsi host0: pata_via
[    0.575050] scsi host1: pata_via
[    0.575294] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xd800 irq 14
[    0.575302] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xd808 irq 15
[    0.575540] 8139cp: 8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
[    0.575549] 8139cp 0000:00:0f.0: This (id 10ec:8139 rev 10) is not an 8139C+ compatible chip, use 8139too
[    0.575633] 8139too: 8139too Fast Ethernet driver 0.9.28
[    0.576791] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
[    0.576801] PCI: setting IRQ 10 as level-triggered
[    0.577784] 8139too 0000:00:0f.0 eth0: RealTek RTL8139 at 0x0001a400, 00:40:95:08:18:34, IRQ 10
[    0.577878] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.577884] ehci-pci: EHCI PCI platform driver
[    0.577958] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.578000] ohci-pci: OHCI PCI platform driver
[    0.578050] uhci_hcd: USB Universal Host Controller Interface driver
[    0.578491] uhci_hcd 0000:00:07.2: UHCI Host Controller
[    0.578539] uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
[    0.578624] uhci_hcd 0000:00:07.2: irq 5, io base 0x0000d400
[    0.580177] hub 1-0:1.0: USB hub found
[    0.580268] hub 1-0:1.0: 2 ports detected
[    0.581151] uhci_hcd 0000:00:07.3: UHCI Host Controller
[    0.581187] uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
[    0.581257] uhci_hcd 0000:00:07.3: irq 5, io base 0x0000d000
[    0.582242] hub 2-0:1.0: USB hub found
[    0.582278] hub 2-0:1.0: 2 ports detected
[    0.582973] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    0.583598] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.583636] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.584562] mousedev: PS/2 mouse device common for all mice
[    0.585431] rtc_cmos 00:03: RTC can wake from S4
[    0.585934] rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
[    0.586017] rtc_cmos 00:03: alarms up to one year, 242 bytes nvram
[    0.586772] NET: Registered protocol family 17
[    0.586909] Using IPI No-Shortcut mode
[    0.587561] registered taskstats version 1
[    0.588603] rtc_cmos 00:03: setting system clock to 2016-09-28 08:28:58 UTC (1475051338)
[    0.588757] PM: Hibernation image not present or could not be loaded.
[    0.617033] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input2
[    0.738836] ata1.00: ATA-4: ST33210A, 3.02, max UDMA/33
[    0.738849] ata1.00: 6346368 sectors, multi 16: LBA 
[    0.743726] ata1.00: configured for UDMA/33
[    0.744375] scsi 0:0:0:0: Direct-Access     ATA      ST33210A         3.02 PQ: 0 ANSI: 5
[    0.745371] sd 0:0:0:0: [sda] 6346368 512-byte logical blocks: (3.25 GB/3.03 GiB)
[    0.745570] sd 0:0:0:0: [sda] Write Protect is off
[    0.745581] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.745667] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    0.772809]  sda: sda1 sda2 < sda5 >
[    0.774448] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.082625] random: fast init done
[    1.152066] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0xc5d014da3d, max_idle_ns: 440795221743 ns
[    2.212784] input: PS/2 BYD TouchPad as /devices/platform/i8042/serio1/input/input4
[    2.234158] EXT4-fs (sda1): mounting ext3 file system using the ext4 subsystem
[    2.271701] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[    2.271774] VFS: Mounted root (ext3 filesystem) readonly on device 8:1.
[    2.274774] Freeing unused kernel memory: 524K (c15c1000 - c1644000)
[    2.275178] Write protecting the kernel text: 3920k
[    2.275270] Write protecting the kernel read-only data: 1528k
[    4.408748] udevd (114): /proc/114/oom_adj is deprecated, please use /proc/114/oom_score_adj instead.
[    5.696720] random: crng init done
[    6.430485] Adding 112416k swap on /dev/sda5.  Priority:-1 extents:1 across:112416k 
[    6.449765] EXT4-fs (sda1): re-mounted. Opts: (null)
[    6.922465] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
[    8.856611] 8139too 0000:00:0f.0 eth0: link up, 100Mbps, full-duplex, lpa 0x45E1


-- 
Ondrej Zary
