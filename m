Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Ondrej Zary <linux@rainbow-software.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: 4.7 regression: ACPI: No IRQ available for PCI Interrupt Link [LNKD]. Try pci=noacpi or acpi=off
Date: Fri, 30 Sep 2016 08:44:23 +0200
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        wim@djo.tudelft.nl, ravikanth.nalla@hpe.com
References: <201609251512.05657.linux@rainbow-software.org> <201609292000.56943.linux@rainbow-software.org> <34355440-197d-44c7-b27d-535267d1161c@codeaurora.org>
In-Reply-To: <34355440-197d-44c7-b27d-535267d1161c@codeaurora.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Ing7XK9g/gz1xEd"
Message-Id: <201609300844.24325.linux@rainbow-software.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Boundary-00=_Ing7XK9g/gz1xEd
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 30 September 2016, Sinan Kaya wrote:
> On 9/29/2016 2:00 PM, Ondrej Zary wrote:
> >> The previous two patches were in the right direction.
> >>
> >> > Can we also get the same output from 4.6 kernel with the attached
> >> > patch for the same machine you sent these?
> >
> > Here it is.
> >
> >> > Something about SCI still doesn't feel right.
> >> >
> >> > The IRQ assignment fails if the penalty is greater than
> >> > PIRQ_PENALTY_ISA_ALWAYS. This will happen if BIOS tells us to use an
> >> > IRQ and same IRQ is in use by the SCI.
>
> Thanks, I reverted penalize_sci function and dropped patch #1. Can you try
> this again?

It seems to work, at least on one machine.

-- 
Ondrej Zary

--Boundary-00=_Ing7XK9g/gz1xEd
Content-Type: text/plain;
  charset="iso-8859-15";
  name="dmesg-good.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg-good.txt"

[    0.000000] Linux version 4.8.0-rc8+ (zary@gsql) (gcc version 4.7.2 (Debian 4.7.2-5) ) #130 SMP Fri Sep 30 08:33:00 CEST 2016
[    0.000000] x86/fpu: Legacy x87 FPU detected.
[    0.000000] x86/fpu: Using 'eager' FPU context switches.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000077fbfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000077fc000-0x00000000077fefff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000077ff000-0x00000000077fffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000ffff0000-0x00000000ffffffff] reserved
[    0.000000] Notice: NX (Execute Disable) protection missing in CPU!
[    0.000000] SMBIOS 2.3 present.
[    0.000000] DMI: System Manufacturer System Name/A7VL133, BIOS ASUS A7VL133-VM ACPI BIOS Revision 1008 06/10/2002
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x77fc max_arch_pfn = 0x100000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-AFFFF uncachable
[    0.000000]   B0000-BFFFF write-combining
[    0.000000]   C0000-FFFFF uncachable
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask FFC000000 write-back
[    0.000000]   1 base 004000000 mask FFE000000 write-back
[    0.000000]   2 base 006000000 mask FFF000000 write-back
[    0.000000]   3 base 007000000 mask FFF800000 write-back
[    0.000000]   4 base 0F0000000 mask FF8000000 write-combining
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 base 0F8000000 mask FFC000000 write-combining
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT  
[    0.000000] initial memory mapped: [mem 0x00000000-0x01bfffff]
[    0.000000] Base memory trampoline at [c009b000] 9b000 size 16384
[    0.000000] BRK [0x016b6000, 0x016b6fff] PGTABLE
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F6DA0 000014 (v00 ASUS  )
[    0.000000] ACPI: RSDT 0x00000000077FC000 00002C (v01 ASUS   A7VL133  30303031 MSFT 31313031)
[    0.000000] ACPI: FACP 0x00000000077FC080 000074 (v01 ASUS   A7VL133  30303031 MSFT 31313031)
[    0.000000] ACPI: DSDT 0x00000000077FC100 0027F0 (v01 ASUS   A7VL133  00001000 MSFT 0100000B)
[    0.000000] ACPI: FACS 0x00000000077FF000 000040
[    0.000000] ACPI: BOOT 0x00000000077FC040 000028 (v01 ASUS   A7VL133  30303031 MSFT 31313031)
[    0.000000] 0MB HIGHMEM available.
[    0.000000] 119MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 077fc000
[    0.000000]   low ram: 0 - 077fc000
[    0.000000] BRK [0x016b7000, 0x016b7fff] PGTABLE
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   Normal   [mem 0x0000000001000000-0x00000000077fbfff]
[    0.000000]   HighMem  empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000077fbfff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x00000000077fbfff]
[    0.000000] On node 0 totalpages: 30618
[    0.000000] free_area_init_node: node 0, pgdat c15b13e0, node_mem_map c770c020
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
[    0.000000]   Normal zone: 208 pages used for memmap
[    0.000000]   Normal zone: 26620 pages, LIFO batch:7
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
[    0.000000] e820: [mem 0x07800000-0xfffeffff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:1 nr_node_ids:1
[    0.000000] percpu: Embedded 19 pages/cpu @c76f6000 s47980 r0 d29844 u77824
[    0.000000] pcpu-alloc: s47980 r0 d29844 u77824 alloc=19*4096
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 30378
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-test root=/dev/sda1 ro quiet
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Initializing CPU#0
[    0.000000] Initializing HighMem for node 0 (00000000:00000000)
[    0.000000] Memory: 114356K/122472K available (3918K kernel code, 435K rwdata, 1520K rodata, 524K init, 412K bss, 8116K reserved, 0K cma-reserved, 0K highmem)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xfff17000 - 0xfffff000   ( 928 kB)
[    0.000000]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[    0.000000]     vmalloc : 0xc7ffc000 - 0xff7fe000   ( 888 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc77fc000   ( 119 MB)
[    0.000000]       .init : 0xc15c0000 - 0xc1643000   ( 524 kB)
[    0.000000]       .data : 0xc13d3d65 - 0xc15bee20   (1964 kB)
[    0.000000]       .text : 0xc1000000 - 0xc13d3d65   (3919 kB)
[    0.000000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 32.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=1
[    0.000000] NR_IRQS:2304 nr_irqs:32 16
[    0.000000] CPU 0 irqstacks, hard=c701c000 soft=c701e000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 857.640 MHz processor
[    0.004010] Calibrating delay loop (skipped), value calculated using timer frequency.. 1715.28 BogoMIPS (lpj=3430560)
[    0.004021] pid_max: default: 32768 minimum: 301
[    0.004069] ACPI: Core revision 20160422
[    0.010203] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.010216] 
[    0.010226] ACPI: setting ELCR to 0200 (from 0e20)
[    0.010325] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.010331] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.011602] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.011613] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.017690] Freeing SMP alternatives memory: 16K (c1643000 - c1647000)
[    0.018287] smpboot: Max logical packages: 1
[    0.018297] smpboot: weird, boot CPU (#0) not listed by the BIOS
[    0.018300] smpboot: SMP motherboard not detected
[    0.018302] smpboot: SMP disabled
[    0.018308] smpboot: Local APIC not detected. Using dummy APIC emulation.
[    0.018316] Performance Events: 
[    0.018326] no APIC, boot with the "lapic" boot parameter to force-enable it.
[    0.018328] no hardware sampling interrupt available.
[    0.018336] AMD PMU driver.
[    0.018345] ... version:                0
[    0.018347] ... bit width:              48
[    0.018350] ... generic registers:      4
[    0.018353] ... value mask:             0000ffffffffffff
[    0.018356] ... max period:             00007fffffffffff
[    0.018359] ... fixed-purpose events:   0
[    0.018361] ... event mask:             000000000000000f
[    0.019714] x86: Booted up 1 node, 1 CPUs
[    0.019726] smpboot: Total of 1 processors activated (1715.28 BogoMIPS)
[    0.020320] devtmpfs: initialized
[    0.021359] PM: Registering ACPI NVS region [mem 0x077ff000-0x077fffff] (4096 bytes)
[    0.021646] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.022152] NET: Registered protocol family 16
[    0.022852] cpuidle: using governor ladder
[    0.022861] cpuidle: using governor menu
[    0.022971] Simple Boot Flag at 0x3a set to 0x1
[    0.022994] clocksource: pit: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1601818034827 ns
[    0.023018] ACPI: bus type PCI registered
[    0.029993] PCI: PCI BIOS revision 2.10 entry at 0xf10c0, last bus=1
[    0.029997] PCI: Using configuration type 1 for base access
[    0.036278] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[    0.036999] ACPI: Added _OSI(Module Device)
[    0.037006] ACPI: Added _OSI(Processor Device)
[    0.037009] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.037013] ACPI: Added _OSI(Processor Aggregator Device)
[    0.041192] ACPI: Interpreter enabled
[    0.041277] ACPI: (supports S0 S1 S4 S5)
[    0.041283] ACPI: Using PIC for interrupt routing
[    0.041393] PCI: Ignoring host bridge windows from ACPI; if necessary, use "pci=use_crs" and report a bug
[    0.054618] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[    0.054832] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
[    0.055024] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
[    0.055214] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
[    0.055423] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.055443] acpi PNP0A03:00: _OSC: OS supports [Segments MSI]
[    0.055465] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.055481] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.055634] acpi PNP0A03:00: host bridge window [io  0x0cf8-0x0cff] (ignored)
[    0.055641] acpi PNP0A03:00: host bridge window [io  0x0000-0x0cf7 window] (ignored)
[    0.055647] acpi PNP0A03:00: host bridge window [io  0x0d00-0xffff window] (ignored)
[    0.055656] acpi PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff window] (ignored)
[    0.055662] acpi PNP0A03:00: host bridge window [mem 0x000c8000-0x000dffff window] (ignored)
[    0.055668] acpi PNP0A03:00: host bridge window [mem 0x07800000-0xffffffff window] (ignored)
[    0.055672] PCI: root bus 00: using default resources
[    0.055915] PCI host bridge to bus 0000:00
[    0.055924] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.055930] pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffff]
[    0.056048] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.056094] pci 0000:00:00.0: [1106:0305] type 00 class 0x060000
[    0.056120] pci 0000:00:00.0: reg 0x10: [mem 0xf8000000-0xfbffffff pref]
[    0.056494] pci 0000:00:01.0: [1106:8305] type 01 class 0x060400
[    0.056557] pci 0000:00:01.0: supports D1
[    0.056653] pci 0000:00:01.0: System wakeup disabled by ACPI
[    0.056869] pci 0000:00:07.0: [1106:0686] type 00 class 0x060100
[    0.057212] pci 0000:00:07.1: [1106:0571] type 00 class 0x01018a
[    0.057262] pci 0000:00:07.1: reg 0x20: [io  0xd800-0xd80f]
[    0.057286] pci 0000:00:07.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.057291] pci 0000:00:07.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.057297] pci 0000:00:07.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.057302] pci 0000:00:07.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.057563] pci 0000:00:07.2: [1106:3038] type 00 class 0x0c0300
[    0.057610] pci 0000:00:07.2: reg 0x20: [io  0xd400-0xd41f]
[    0.057744] pci 0000:00:07.2: System wakeup disabled by ACPI
[    0.057940] pci 0000:00:07.3: [1106:3038] type 00 class 0x0c0300
[    0.057987] pci 0000:00:07.3: reg 0x20: [io  0xd000-0xd01f]
[    0.058122] pci 0000:00:07.3: System wakeup disabled by ACPI
[    0.058332] pci 0000:00:07.4: [1106:3057] type 00 class 0x068000
[    0.058406] pci 0000:00:07.4: quirk: [io  0xe200-0xe27f] claimed by vt82c686 HW-mon
[    0.058414] pci 0000:00:07.4: quirk: [io  0xe800-0xe80f] claimed by vt82c686 SMB
[    0.058670] pci 0000:00:07.5: [1106:3058] type 00 class 0x040100
[    0.058692] pci 0000:00:07.5: reg 0x10: [io  0xb800-0xb8ff]
[    0.058705] pci 0000:00:07.5: reg 0x14: [io  0xb400-0xb403]
[    0.058718] pci 0000:00:07.5: reg 0x18: [io  0xb000-0xb003]
[    0.059041] pci 0000:00:0e.0: [10ec:8139] type 00 class 0x020000
[    0.059061] pci 0000:00:0e.0: reg 0x10: [io  0xa400-0xa4ff]
[    0.059075] pci 0000:00:0e.0: reg 0x14: [mem 0xee800000-0xee8000ff]
[    0.059116] pci 0000:00:0e.0: reg 0x30: [mem 0x00000000-0x00007fff pref]
[    0.059155] pci 0000:00:0e.0: supports D1 D2
[    0.059161] pci 0000:00:0e.0: PME# supported from D1 D2 D3hot D3cold
[    0.059542] pci 0000:01:00.0: [5333:8a26] type 00 class 0x030000
[    0.059564] pci 0000:01:00.0: reg 0x10: [mem 0xef000000-0xef07ffff]
[    0.059577] pci 0000:01:00.0: reg 0x14: [mem 0xf0000000-0xf7ffffff pref]
[    0.059615] pci 0000:01:00.0: reg 0x30: [mem 0xefff0000-0xefffffff pref]
[    0.059663] pci 0000:01:00.0: supports D1 D2
[    0.059843] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.059855] pci 0000:00:01.0:   bridge window [mem 0xef000000-0xefdfffff]
[    0.059863] pci 0000:00:01.0:   bridge window [mem 0xeff00000-0xf7ffffff pref]
[    0.059877] pci_bus 0000:00: on NUMA node 0
[    0.062893] vgaarb: setting as boot device: PCI:0000:01:00.0
[    0.062903] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.062905] vgaarb: loaded
[    0.062909] vgaarb: bridge control possible 0000:01:00.0
[    0.063197] SCSI subsystem initialized
[    0.063418] libata version 3.00 loaded.
[    0.063448] ACPI: bus type USB registered
[    0.063580] usbcore: registered new interface driver usbfs
[    0.063633] usbcore: registered new interface driver hub
[    0.063693] usbcore: registered new device driver usb
[    0.063836] PCI: Using ACPI for IRQ routing
[    0.063846] PCI: pci_cache_line_size set to 32 bytes
[    0.063902] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.063909] e820: reserve RAM buffer [mem 0x077fc000-0x07ffffff]
[    0.065488] clocksource: Switched to clocksource pit
[    0.089009] pnp: PnP ACPI init
[    0.089649] system 00:00: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.089661] system 00:00: [mem 0x000f0000-0x000fffff] could not be reserved
[    0.089669] system 00:00: [mem 0x00100000-0x077fffff] could not be reserved
[    0.089676] system 00:00: [mem 0xfffe0000-0xffffffff] could not be reserved
[    0.089683] system 00:00: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.089700] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.090224] system 00:01: [io  0x03f0-0x03f1] has been reserved
[    0.090233] system 00:01: [io  0x04d0-0x04d1] has been reserved
[    0.090245] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.090442] system 00:02: [io  0xe400-0xe47f] has been reserved
[    0.090451] system 00:02: [io  0xe800-0xe80f] has been reserved
[    0.090458] system 00:02: [io  0xe200-0xe27f] has been reserved
[    0.090468] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.090982] pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.091357] pnp 00:04: [dma 2]
[    0.091503] pnp 00:04: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.092283] pnp 00:05: [dma 3]
[    0.092474] pnp 00:05: Plug and Play ACPI device, IDs PNP0401 (active)
[    0.093177] pnp 00:06: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.093933] pnp 00:07: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.094336] pnp 00:08: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.094743] pnp 00:09: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.095003] pnp: PnP ACPI: found 10 devices
[    0.095017] PnPBIOS: Disabled
[    0.137906] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.137981] clocksource: Switched to clocksource acpi_pm
[    0.138063] pci 0000:00:0e.0: BAR 6: assigned [mem 0x08000000-0x08007fff pref]
[    0.138080] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.138093] pci 0000:00:01.0:   bridge window [mem 0xef000000-0xefdfffff]
[    0.138101] pci 0000:00:01.0:   bridge window [mem 0xeff00000-0xf7ffffff pref]
[    0.138115] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
[    0.138122] pci_bus 0000:00: resource 5 [mem 0x00000000-0xffffffff]
[    0.138129] pci_bus 0000:01: resource 1 [mem 0xef000000-0xefdfffff]
[    0.138135] pci_bus 0000:01: resource 2 [mem 0xeff00000-0xf7ffffff pref]
[    0.138271] NET: Registered protocol family 2
[    0.139097] TCP established hash table entries: 1024 (order: 0, 4096 bytes)
[    0.139130] TCP bind hash table entries: 1024 (order: 1, 8192 bytes)
[    0.139179] TCP: Hash tables configured (established 1024 bind 1024)
[    0.139331] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    0.139367] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    0.139620] NET: Registered protocol family 1
[    0.139698] pci 0000:00:00.0: Applying VIA southbridge workaround
[    0.139711] pci 0000:00:01.0: disabling DAC on VIA PCI bridge
[    0.139725] pci 0000:00:07.0: Disabling VIA external APIC routing
[    0.140839] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
[    0.140847] PCI: setting IRQ 9 as level-triggered
[    0.141520] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.141528] PCI: CLS 32 bytes, default 32
[    0.143467] futex hash table entries: 256 (order: 1, 8192 bytes)
[    0.145182] workingset: timestamp_bits=30 max_order=15 bucket_order=0
[    0.159115] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.159128] io scheduler noop registered
[    0.159131] io scheduler deadline registered
[    0.159281] io scheduler cfq registered (default)
[    0.160585] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.160603] ACPI: Power Button [PWRB]
[    0.160884] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.160890] ACPI: Power Button [PWRF]
[    0.161043] tsc: Marking TSC unstable due to TSC halts in idle
[    0.161218] Warning: Processor Platform Limit event detected, but not handled.
[    0.161221] Consider compiling CPUfreq support into your kernel.
[    0.162012] isapnp: Scanning for PnP cards...
[    0.516643] isapnp: No Plug & Play device found
[    0.516957] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.537774] 00:06: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.558633] 00:07: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    0.560296] Non-volatile memory driver v1.3
[    0.560305] Linux agpgart interface v0.103
[    0.560441] [drm] Initialized drm 1.1.0 20060810
[    0.571028] loop: module loaded
[    0.571428] pata_via 0000:00:07.1: version 0.3.4
[    0.574468] scsi host0: pata_via
[    0.574940] scsi host1: pata_via
[    0.575170] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xd800 irq 14
[    0.575177] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xd808 irq 15
[    0.575388] 8139cp: 8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
[    0.575398] 8139cp 0000:00:0e.0: This (id 10ec:8139 rev 10) is not an 8139C+ compatible chip, use 8139too
[    0.575478] 8139too: 8139too Fast Ethernet driver 0.9.28
[    0.576583] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
[    0.576591] PCI: setting IRQ 10 as level-triggered
[    0.577575] 8139too 0000:00:0e.0 eth0: RealTek RTL8139 at 0x0001a400, 00:40:95:08:18:34, IRQ 10
[    0.577669] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.577673] ehci-pci: EHCI PCI platform driver
[    0.577746] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.577785] ohci-pci: OHCI PCI platform driver
[    0.577833] uhci_hcd: USB Universal Host Controller Interface driver
[    0.578259] uhci_hcd 0000:00:07.2: UHCI Host Controller
[    0.578315] uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
[    0.578390] uhci_hcd 0000:00:07.2: irq 9, io base 0x0000d400
[    0.579859] hub 1-0:1.0: USB hub found
[    0.579897] hub 1-0:1.0: 2 ports detected
[    0.580994] uhci_hcd 0000:00:07.3: UHCI Host Controller
[    0.581031] uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
[    0.581099] uhci_hcd 0000:00:07.3: irq 9, io base 0x0000d000
[    0.582101] hub 2-0:1.0: USB hub found
[    0.582136] hub 2-0:1.0: 2 ports detected
[    0.582832] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    0.583481] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.583516] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.584454] mousedev: PS/2 mouse device common for all mice
[    0.585365] rtc_cmos 00:03: RTC can wake from S4
[    0.585859] rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
[    0.585918] rtc_cmos 00:03: alarms up to one year, 242 bytes nvram
[    0.586718] NET: Registered protocol family 17
[    0.586869] Using IPI No-Shortcut mode
[    0.587607] registered taskstats version 1
[    0.588721] console [netcon0] enabled
[    0.588725] netconsole: network logging started
[    0.588806] rtc_cmos 00:03: setting system clock to 2016-09-30 06:38:37 UTC (1475217517)
[    0.588951] PM: Hibernation image not present or could not be loaded.
[    0.617127] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input2
[    0.738822] ata1.00: ATA-4: ST33210A, 3.02, max UDMA/33
[    0.738834] ata1.00: 6346368 sectors, multi 16: LBA 
[    0.743753] ata1.00: configured for UDMA/33
[    0.744506] scsi 0:0:0:0: Direct-Access     ATA      ST33210A         3.02 PQ: 0 ANSI: 5
[    0.745423] sd 0:0:0:0: [sda] 6346368 512-byte logical blocks: (3.25 GB/3.03 GiB)
[    0.745624] sd 0:0:0:0: [sda] Write Protect is off
[    0.745633] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.745718] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    0.773501]  sda: sda1 sda2 < sda5 >
[    0.775131] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.072931] random: fast init done
[    1.152066] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0xc5cc4d10eb, max_idle_ns: 440795203494 ns
[    2.211004] input: PS/2 BYD TouchPad as /devices/platform/i8042/serio1/input/input4
[    2.234872] EXT4-fs (sda1): mounting ext3 file system using the ext4 subsystem
[    2.261225] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[    2.261299] VFS: Mounted root (ext3 filesystem) readonly on device 8:1.
[    2.264363] Freeing unused kernel memory: 524K (c15c0000 - c1643000)
[    2.264730] Write protecting the kernel text: 3920k
[    2.264823] Write protecting the kernel read-only data: 1528k
[    4.398241] udevd (114): /proc/114/oom_adj is deprecated, please use /proc/114/oom_score_adj instead.
[    5.643782] random: crng init done
[    6.508948] Adding 112416k swap on /dev/sda5.  Priority:-1 extents:1 across:112416k 
[    6.529101] EXT4-fs (sda1): re-mounted. Opts: (null)
[    7.000945] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
[    8.901745] 8139too 0000:00:0e.0 eth0: link up, 100Mbps, full-duplex, lpa 0x45E1

--Boundary-00=_Ing7XK9g/gz1xEd--
