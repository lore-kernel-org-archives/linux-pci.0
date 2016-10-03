Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Ondrej Zary <linux@rainbow-software.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: 4.7 regression: ACPI: No IRQ available for PCI Interrupt Link [LNKD]. Try pci=noacpi or acpi=off
Date: Mon, 3 Oct 2016 09:25:57 +0200
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>, wim@djo.tudelft.nl,
        ravikanth.nalla@hpe.com
References: <201609251512.05657.linux@rainbow-software.org> <201610021853.19635.linux@rainbow-software.org> <fd149c27-d703-5338-2461-17621b4b1ae5@codeaurora.org>
In-Reply-To: <fd149c27-d703-5338-2461-17621b4b1ae5@codeaurora.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Ggg8XD4H7rIXqcO"
Message-Id: <201610030925.58304.linux@rainbow-software.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Boundary-00=_Ggg8XD4H7rIXqcO
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 03 October 2016, Sinan Kaya wrote:
> On 10/2/2016 12:53 PM, Ondrej Zary wrote:
> >> Can we have some testing coverage? and eventually have tested-by?
> >
> > Works on two affected machines. More tests tomorrow.
>
> Thanks, appreciate the feedback. Looking forward to hear your other test
> results.

The other two affected machines are working too.

-- 
Ondrej Zary

--Boundary-00=_Ggg8XD4H7rIXqcO
Content-Type: text/plain;
  charset="iso-8859-15";
  name="dmesg-ok_3.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg-ok_3.txt"

[    0.000000] Linux version 4.8.0-rc8+ (zary@gsql) (gcc version 4.7.2 (Debian 4.7.2-5) ) #134 SMP Sun Oct 2 15:13:50 CEST 2016
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
[    0.000000] BRK [0x016b7000, 0x016b7fff] PGTABLE
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
[    0.000000] BRK [0x016b8000, 0x016b8fff] PGTABLE
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
[    0.000000] free_area_init_node: node 0, pgdat c15b17a0, node_mem_map c770c020
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
[    0.000000] Memory: 114352K/122472K available (3918K kernel code, 436K rwdata, 1520K rodata, 524K init, 412K bss, 8120K reserved, 0K cma-reserved, 0K highmem)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xfff17000 - 0xfffff000   ( 928 kB)
[    0.000000]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[    0.000000]     vmalloc : 0xc7ffc000 - 0xff7fe000   ( 888 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc77fc000   ( 119 MB)
[    0.000000]       .init : 0xc15c1000 - 0xc1644000   ( 524 kB)
[    0.000000]       .data : 0xc13d3d85 - 0xc15bf1e0   (1965 kB)
[    0.000000]       .text : 0xc1000000 - 0xc13d3d85   (3919 kB)
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
[    0.000000] tsc: Detected 857.683 MHz processor
[    0.004010] Calibrating delay loop (skipped), value calculated using timer frequency.. 1715.36 BogoMIPS (lpj=3430732)
[    0.004021] pid_max: default: 32768 minimum: 301
[    0.004069] ACPI: Core revision 20160422
[    0.011971] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.012018] 
[    0.012028] ACPI: setting ELCR to 0200 (from 0e20)
[    0.012126] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.012131] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.013357] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.013369] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.019262] Freeing SMP alternatives memory: 16K (c1644000 - c1648000)
[    0.019768] smpboot: Max logical packages: 1
[    0.019777] smpboot: weird, boot CPU (#0) not listed by the BIOS
[    0.019779] smpboot: SMP motherboard not detected
[    0.019781] smpboot: SMP disabled
[    0.019787] smpboot: Local APIC not detected. Using dummy APIC emulation.
[    0.019792] Performance Events: 
[    0.019802] no APIC, boot with the "lapic" boot parameter to force-enable it.
[    0.019804] no hardware sampling interrupt available.
[    0.019811] AMD PMU driver.
[    0.019819] ... version:                0
[    0.019821] ... bit width:              48
[    0.019824] ... generic registers:      4
[    0.019827] ... value mask:             0000ffffffffffff
[    0.019830] ... max period:             00007fffffffffff
[    0.019832] ... fixed-purpose events:   0
[    0.019835] ... event mask:             000000000000000f
[    0.021336] x86: Booted up 1 node, 1 CPUs
[    0.021349] smpboot: Total of 1 processors activated (1715.36 BogoMIPS)
[    0.021924] devtmpfs: initialized
[    0.023083] PM: Registering ACPI NVS region [mem 0x077ff000-0x077fffff] (4096 bytes)
[    0.023355] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.023880] NET: Registered protocol family 16
[    0.024783] cpuidle: using governor ladder
[    0.024792] cpuidle: using governor menu
[    0.024910] Simple Boot Flag at 0x3a set to 0x1
[    0.024936] clocksource: pit: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1601818034827 ns
[    0.024959] ACPI: bus type PCI registered
[    0.031767] PCI: PCI BIOS revision 2.10 entry at 0xf10c0, last bus=1
[    0.031770] PCI: Using configuration type 1 for base access
[    0.038024] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[    0.038745] ACPI: Added _OSI(Module Device)
[    0.038753] ACPI: Added _OSI(Processor Device)
[    0.038757] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.038761] ACPI: Added _OSI(Processor Aggregator Device)
[    0.042772] ACPI: Interpreter enabled
[    0.042858] ACPI: (supports S0 S1 S4 S5)
[    0.042864] ACPI: Using PIC for interrupt routing
[    0.042979] PCI: Ignoring host bridge windows from ACPI; if necessary, use "pci=use_crs" and report a bug
[    0.056413] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[    0.056624] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
[    0.056820] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
[    0.057014] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
[    0.057222] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.057242] acpi PNP0A03:00: _OSC: OS supports [Segments MSI]
[    0.057263] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.057279] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.057432] acpi PNP0A03:00: host bridge window [io  0x0cf8-0x0cff] (ignored)
[    0.057439] acpi PNP0A03:00: host bridge window [io  0x0000-0x0cf7 window] (ignored)
[    0.057446] acpi PNP0A03:00: host bridge window [io  0x0d00-0xffff window] (ignored)
[    0.057453] acpi PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff window] (ignored)
[    0.057459] acpi PNP0A03:00: host bridge window [mem 0x000c8000-0x000dffff window] (ignored)
[    0.057464] acpi PNP0A03:00: host bridge window [mem 0x07800000-0xffffffff window] (ignored)
[    0.057468] PCI: root bus 00: using default resources
[    0.057718] PCI host bridge to bus 0000:00
[    0.057727] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.057734] pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffff]
[    0.057743] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.057786] pci 0000:00:00.0: [1106:0305] type 00 class 0x060000
[    0.057811] pci 0000:00:00.0: reg 0x10: [mem 0xf8000000-0xfbffffff pref]
[    0.058170] pci 0000:00:01.0: [1106:8305] type 01 class 0x060400
[    0.058232] pci 0000:00:01.0: supports D1
[    0.058329] pci 0000:00:01.0: System wakeup disabled by ACPI
[    0.058540] pci 0000:00:07.0: [1106:0686] type 00 class 0x060100
[    0.058878] pci 0000:00:07.1: [1106:0571] type 00 class 0x01018a
[    0.058928] pci 0000:00:07.1: reg 0x20: [io  0xd800-0xd80f]
[    0.058952] pci 0000:00:07.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.058958] pci 0000:00:07.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.058963] pci 0000:00:07.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.058969] pci 0000:00:07.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.059233] pci 0000:00:07.2: [1106:3038] type 00 class 0x0c0300
[    0.059280] pci 0000:00:07.2: reg 0x20: [io  0xd400-0xd41f]
[    0.059413] pci 0000:00:07.2: System wakeup disabled by ACPI
[    0.059613] pci 0000:00:07.3: [1106:3038] type 00 class 0x0c0300
[    0.059659] pci 0000:00:07.3: reg 0x20: [io  0xd000-0xd01f]
[    0.059796] pci 0000:00:07.3: System wakeup disabled by ACPI
[    0.060134] pci 0000:00:07.4: [1106:3057] type 00 class 0x068000
[    0.060219] pci 0000:00:07.4: quirk: [io  0xe200-0xe27f] claimed by vt82c686 HW-mon
[    0.060226] pci 0000:00:07.4: quirk: [io  0xe800-0xe80f] claimed by vt82c686 SMB
[    0.060509] pci 0000:00:07.5: [1106:3058] type 00 class 0x040100
[    0.060531] pci 0000:00:07.5: reg 0x10: [io  0xb800-0xb8ff]
[    0.060544] pci 0000:00:07.5: reg 0x14: [io  0xb400-0xb403]
[    0.060558] pci 0000:00:07.5: reg 0x18: [io  0xb000-0xb003]
[    0.060878] pci 0000:00:0e.0: [10ec:8139] type 00 class 0x020000
[    0.060899] pci 0000:00:0e.0: reg 0x10: [io  0xa400-0xa4ff]
[    0.060914] pci 0000:00:0e.0: reg 0x14: [mem 0xee800000-0xee8000ff]
[    0.060954] pci 0000:00:0e.0: reg 0x30: [mem 0x00000000-0x00007fff pref]
[    0.060993] pci 0000:00:0e.0: supports D1 D2
[    0.060999] pci 0000:00:0e.0: PME# supported from D1 D2 D3hot D3cold
[    0.061368] pci 0000:01:00.0: [5333:8a26] type 00 class 0x030000
[    0.061390] pci 0000:01:00.0: reg 0x10: [mem 0xef000000-0xef07ffff]
[    0.061403] pci 0000:01:00.0: reg 0x14: [mem 0xf0000000-0xf7ffffff pref]
[    0.061441] pci 0000:01:00.0: reg 0x30: [mem 0xefff0000-0xefffffff pref]
[    0.061488] pci 0000:01:00.0: supports D1 D2
[    0.061667] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.061678] pci 0000:00:01.0:   bridge window [mem 0xef000000-0xefdfffff]
[    0.061686] pci 0000:00:01.0:   bridge window [mem 0xeff00000-0xf7ffffff pref]
[    0.061700] pci_bus 0000:00: on NUMA node 0
[    0.064743] vgaarb: setting as boot device: PCI:0000:01:00.0
[    0.064755] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.064758] vgaarb: loaded
[    0.064763] vgaarb: bridge control possible 0000:01:00.0
[    0.065093] SCSI subsystem initialized
[    0.065369] libata version 3.00 loaded.
[    0.065406] ACPI: bus type USB registered
[    0.065555] usbcore: registered new interface driver usbfs
[    0.065611] usbcore: registered new interface driver hub
[    0.065675] usbcore: registered new device driver usb
[    0.065821] PCI: Using ACPI for IRQ routing
[    0.065834] PCI: pci_cache_line_size set to 32 bytes
[    0.065898] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.065906] e820: reserve RAM buffer [mem 0x077fc000-0x07ffffff]
[    0.067405] clocksource: Switched to clocksource pit
[    0.088920] pnp: PnP ACPI init
[    0.089574] system 00:00: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.089586] system 00:00: [mem 0x000f0000-0x000fffff] could not be reserved
[    0.089594] system 00:00: [mem 0x00100000-0x077fffff] could not be reserved
[    0.089602] system 00:00: [mem 0xfffe0000-0xffffffff] could not be reserved
[    0.089609] system 00:00: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.089628] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.090180] system 00:01: [io  0x03f0-0x03f1] has been reserved
[    0.090190] system 00:01: [io  0x04d0-0x04d1] has been reserved
[    0.090203] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.090406] system 00:02: [io  0xe400-0xe47f] has been reserved
[    0.090415] system 00:02: [io  0xe800-0xe80f] has been reserved
[    0.090423] system 00:02: [io  0xe200-0xe27f] has been reserved
[    0.090433] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.090801] pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.091184] pnp 00:04: [dma 2]
[    0.091326] pnp 00:04: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.092115] pnp 00:05: [dma 3]
[    0.092307] pnp 00:05: Plug and Play ACPI device, IDs PNP0401 (active)
[    0.093208] pnp 00:06: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.093985] pnp 00:07: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.094380] pnp 00:08: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.094634] pnp 00:09: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.094849] pnp: PnP ACPI: found 10 devices
[    0.094864] PnPBIOS: Disabled
[    0.137675] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.137742] clocksource: Switched to clocksource acpi_pm
[    0.137822] pci 0000:00:0e.0: BAR 6: assigned [mem 0x08000000-0x08007fff pref]
[    0.137839] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.137852] pci 0000:00:01.0:   bridge window [mem 0xef000000-0xefdfffff]
[    0.137860] pci 0000:00:01.0:   bridge window [mem 0xeff00000-0xf7ffffff pref]
[    0.137875] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
[    0.137882] pci_bus 0000:00: resource 5 [mem 0x00000000-0xffffffff]
[    0.137890] pci_bus 0000:01: resource 1 [mem 0xef000000-0xefdfffff]
[    0.137896] pci_bus 0000:01: resource 2 [mem 0xeff00000-0xf7ffffff pref]
[    0.138030] NET: Registered protocol family 2
[    0.138756] TCP established hash table entries: 1024 (order: 0, 4096 bytes)
[    0.138790] TCP bind hash table entries: 1024 (order: 1, 8192 bytes)
[    0.138837] TCP: Hash tables configured (established 1024 bind 1024)
[    0.138989] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    0.139021] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    0.139277] NET: Registered protocol family 1
[    0.139354] pci 0000:00:00.0: Applying VIA southbridge workaround
[    0.139367] pci 0000:00:01.0: disabling DAC on VIA PCI bridge
[    0.139383] pci 0000:00:07.0: Disabling VIA external APIC routing
[    0.140382] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
[    0.140390] PCI: setting IRQ 9 as level-triggered
[    0.141183] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.141192] PCI: CLS 32 bytes, default 32
[    0.143136] futex hash table entries: 256 (order: 1, 8192 bytes)
[    0.144669] workingset: timestamp_bits=30 max_order=15 bucket_order=0
[    0.158476] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.158487] io scheduler noop registered
[    0.158490] io scheduler deadline registered
[    0.158640] io scheduler cfq registered (default)
[    0.159761] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.159783] ACPI: Power Button [PWRB]
[    0.160260] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.160269] ACPI: Power Button [PWRF]
[    0.160453] tsc: Marking TSC unstable due to TSC halts in idle
[    0.160632] Warning: Processor Platform Limit event detected, but not handled.
[    0.160635] Consider compiling CPUfreq support into your kernel.
[    0.161559] isapnp: Scanning for PnP cards...
[    0.516253] isapnp: No Plug & Play device found
[    0.516575] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.537399] 00:06: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.558254] 00:07: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    0.559834] Non-volatile memory driver v1.3
[    0.559845] Linux agpgart interface v0.103
[    0.559989] [drm] Initialized drm 1.1.0 20060810
[    0.570863] loop: module loaded
[    0.571261] pata_via 0000:00:07.1: version 0.3.4
[    0.574181] scsi host0: pata_via
[    0.574709] scsi host1: pata_via
[    0.574948] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xd800 irq 14
[    0.574955] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xd808 irq 15
[    0.575187] 8139cp: 8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
[    0.575198] 8139cp 0000:00:0e.0: This (id 10ec:8139 rev 10) is not an 8139C+ compatible chip, use 8139too
[    0.575282] 8139too: 8139too Fast Ethernet driver 0.9.28
[    0.576450] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
[    0.576462] PCI: setting IRQ 10 as level-triggered
[    0.577435] 8139too 0000:00:0e.0 eth0: RealTek RTL8139 at 0x0001a400, 00:40:95:08:18:34, IRQ 10
[    0.577528] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.577532] ehci-pci: EHCI PCI platform driver
[    0.577604] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.577643] ohci-pci: OHCI PCI platform driver
[    0.577690] uhci_hcd: USB Universal Host Controller Interface driver
[    0.578093] uhci_hcd 0000:00:07.2: UHCI Host Controller
[    0.578148] uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
[    0.578223] uhci_hcd 0000:00:07.2: irq 9, io base 0x0000d400
[    0.579658] hub 1-0:1.0: USB hub found
[    0.579696] hub 1-0:1.0: 2 ports detected
[    0.580743] uhci_hcd 0000:00:07.3: UHCI Host Controller
[    0.580780] uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
[    0.580849] uhci_hcd 0000:00:07.3: irq 9, io base 0x0000d000
[    0.581865] hub 2-0:1.0: USB hub found
[    0.581905] hub 2-0:1.0: 2 ports detected
[    0.582595] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    0.583230] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.583269] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.584199] mousedev: PS/2 mouse device common for all mice
[    0.585144] rtc_cmos 00:03: RTC can wake from S4
[    0.585610] rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
[    0.585665] rtc_cmos 00:03: alarms up to one year, 242 bytes nvram
[    0.586407] NET: Registered protocol family 17
[    0.586545] Using IPI No-Shortcut mode
[    0.587214] registered taskstats version 1
[    0.588387] console [netcon0] enabled
[    0.588424] netconsole: network logging started
[    0.588513] rtc_cmos 00:03: setting system clock to 2016-10-03 07:06:07 UTC (1475478367)
[    0.588671] PM: Hibernation image not present or could not be loaded.
[    0.616153] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input2
[    0.738804] ata1.00: ATA-4: ST33210A, 3.02, max UDMA/33
[    0.738816] ata1.00: 6346368 sectors, multi 16: LBA 
[    0.743693] ata1.00: configured for UDMA/33
[    0.744462] scsi 0:0:0:0: Direct-Access     ATA      ST33210A         3.02 PQ: 0 ANSI: 5
[    0.746012] sd 0:0:0:0: [sda] 6346368 512-byte logical blocks: (3.25 GB/3.03 GiB)
[    0.746278] sd 0:0:0:0: [sda] Write Protect is off
[    0.746287] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.746720] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    0.781209]  sda: sda1 sda2 < sda5 >
[    0.782975] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.079955] random: fast init done
[    1.152067] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0xc5ced73763, max_idle_ns: 440795207600 ns
[    2.210904] input: PS/2 BYD TouchPad as /devices/platform/i8042/serio1/input/input4
[    2.242576] EXT4-fs (sda1): mounting ext3 file system using the ext4 subsystem
[    2.280178] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[    2.280247] VFS: Mounted root (ext3 filesystem) readonly on device 8:1.
[    2.282737] Freeing unused kernel memory: 524K (c15c1000 - c1644000)
[    2.283048] Write protecting the kernel text: 3920k
[    2.283139] Write protecting the kernel read-only data: 1528k
[    4.373134] udevd (113): /proc/113/oom_adj is deprecated, please use /proc/113/oom_score_adj instead.
[    5.732859] random: crng init done
[    6.494459] Adding 112416k swap on /dev/sda5.  Priority:-1 extents:1 across:112416k 
[    6.514097] EXT4-fs (sda1): re-mounted. Opts: (null)
[    6.986433] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
[    8.886675] 8139too 0000:00:0e.0 eth0: link up, 100Mbps, full-duplex, lpa 0x45E1

--Boundary-00=_Ggg8XD4H7rIXqcO
Content-Type: text/plain;
  charset="iso-8859-15";
  name="dmesg-ok_4.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg-ok_4.txt"

[    0.000000] Linux version 4.8.0-rc8+ (zary@gsql) (gcc version 4.7.2 (Debian 4.7.2-5) ) #134 SMP Sun Oct 2 15:13:50 CEST 2016
[    0.000000] x86/fpu: Legacy x87 FPU detected.
[    0.000000] x86/fpu: Using 'eager' FPU context switches.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000003ffeffff] usable
[    0.000000] BIOS-e820: [mem 0x000000003fff0000-0x000000003fff2fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000003fff3000-0x000000003fffffff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000ffff0000-0x00000000ffffffff] reserved
[    0.000000] Notice: NX (Execute Disable) protection missing in CPU!
[    0.000000] SMBIOS 2.3 present.
[    0.000000] DMI: VIA Technologies, Inc. VT82C694X/Advance-10E/B/F, BIOS 6.00 PG 01/31/2004
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x3fff0 max_arch_pfn = 0x100000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-AFFFF uncachable
[    0.000000]   B0000-BFFFF write-combining
[    0.000000]   C0000-CCFFF write-protect
[    0.000000]   CD000-EFFFF uncachable
[    0.000000]   F0000-F7FFF write-through
[    0.000000]   F8000-F8FFF uncachable
[    0.000000]   F9000-FFFFF write-through
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask FC0000000 write-back
[    0.000000]   1 base 0D0000000 mask FF8000000 write-combining
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86/PAT: PAT not supported by CPU.
[    0.000000] x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC- UC  
[    0.000000] initial memory mapped: [mem 0x00000000-0x01bfffff]
[    0.000000] Base memory trampoline at [c009b000] 9b000 size 16384
[    0.000000] BRK [0x016b7000, 0x016b7fff] PGTABLE
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F7C80 000014 (v00 QDIGRP)
[    0.000000] ACPI: RSDT 0x000000003FFF3000 000028 (v01 QDIGRP AWRDACPI 42302E31 AWRD 00000000)
[    0.000000] ACPI: FACP 0x000000003FFF3040 000074 (v01 QDIGRP AWRDACPI 42302E31 AWRD 00000000)
[    0.000000] ACPI: DSDT 0x000000003FFF30C0 0023A5 (v01 QDIGRP AWRDACPI 00001000 MSFT 0100000C)
[    0.000000] ACPI: FACS 0x000000003FFF0000 000040
[    0.000000] 135MB HIGHMEM available.
[    0.000000] 887MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 377fe000
[    0.000000]   low ram: 0 - 377fe000
[    0.000000] BRK [0x016b8000, 0x016b8fff] PGTABLE
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   Normal   [mem 0x0000000001000000-0x00000000377fdfff]
[    0.000000]   HighMem  [mem 0x00000000377fe000-0x000000003ffeffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000003ffeffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000003ffeffff]
[    0.000000] On node 0 totalpages: 262030
[    0.000000] free_area_init_node: node 0, pgdat c15b17a0, node_mem_map f6ffe020
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
[    0.000000]   Normal zone: 1744 pages used for memmap
[    0.000000]   Normal zone: 223230 pages, LIFO batch:31
[    0.000000]   HighMem zone: 34802 pages, LIFO batch:7
[    0.000000] Using APIC driver default
[    0.000000] ACPI: PM-Timer IO Port: 0x4008
[    0.000000] smpboot: Allowing 1 CPUs, 0 hotplug CPUs
[    0.000000] Local APIC disabled by BIOS -- you can enable it with "lapic"
[    0.000000] APIC: disable apic facility
[    0.000000] APIC: switched to apic NOOP
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.000000] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.000000] e820: [mem 0x40000000-0xfffeffff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:1 nr_node_ids:1
[    0.000000] percpu: Embedded 19 pages/cpu @f6fe4000 s47980 r0 d29844 u77824
[    0.000000] pcpu-alloc: s47980 r0 d29844 u77824 alloc=19*4096
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260254
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-test root=/dev/sda1 ro quiet
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Initializing CPU#0
[    0.000000] Initializing HighMem for node 0 (000377fe:0003fff0)
[    0.000000] Initializing Movable for node 0 (00000000:00000000)
[    0.000000] Memory: 1032068K/1048120K available (3918K kernel code, 436K rwdata, 1520K rodata, 524K init, 412K bss, 16052K reserved, 0K cma-reserved, 139208K highmem)
[    0.000000] virtual kernel memory layout:
    fixmap  : 0xfff17000 - 0xfffff000   ( 928 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf7ffe000 - 0xff7fe000   ( 120 MB)
    lowmem  : 0xc0000000 - 0xf77fe000   ( 887 MB)
      .init : 0xc15c1000 - 0xc1644000   ( 524 kB)
      .data : 0xc13d3d85 - 0xc15bf1e0   (1965 kB)
      .text : 0xc1000000 - 0xc13d3d85   (3919 kB)
[    0.000000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 32.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=1
[    0.000000] NR_IRQS:2304 nr_irqs:32 16
[    0.000000] CPU 0 irqstacks, hard=f681c000 soft=f681e000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 902.053 MHz processor
[    0.008010] Calibrating delay loop (skipped), value calculated using timer frequency.. 1804.10 BogoMIPS (lpj=3608212)
[    0.008021] pid_max: default: 32768 minimum: 301
[    0.008052] ACPI: Core revision 20160422
[    0.012435] ACPI: 1 ACPI AML tables successfully acquired and loaded

[    0.012456] ACPI: setting ELCR to 0800 (from 0e20)
[    0.012545] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.012551] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.013471] Last level iTLB entries: 4KB 32, 2MB 0, 4MB 2
[    0.013481] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 8, 1GB 0
[    0.017743] Freeing SMP alternatives memory: 16K (c1644000 - c1648000)
[    0.020534] smpboot: Max logical packages: 1
[    0.020544] smpboot: weird, boot CPU (#0) not listed by the BIOS
[    0.020546] smpboot: SMP motherboard not detected
[    0.020548] smpboot: SMP disabled
[    0.020553] smpboot: Local APIC not detected. Using dummy APIC emulation.
[    0.020559] Performance Events: 
[    0.020567] no APIC, boot with the "lapic" boot parameter to force-enable it.
[    0.020570] no hardware sampling interrupt available.
[    0.020576] p6 PMU driver.
[    0.020584] ... version:                0
[    0.020586] ... bit width:              32
[    0.020589] ... generic registers:      2
[    0.020592] ... value mask:             00000000ffffffff
[    0.020594] ... max period:             000000007fffffff
[    0.020596] ... fixed-purpose events:   0
[    0.020598] ... event mask:             0000000000000003
[    0.021840] x86: Booted up 1 node, 1 CPUs
[    0.021850] smpboot: Total of 1 processors activated (1804.10 BogoMIPS)
[    0.022415] devtmpfs: initialized
[    0.023353] PM: Registering ACPI NVS region [mem 0x3fff0000-0x3fff2fff] (12288 bytes)
[    0.023589] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.024061] NET: Registered protocol family 16
[    0.024660] cpuidle: using governor ladder
[    0.024669] cpuidle: using governor menu
[    0.024826] clocksource: pit: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1601818034827 ns
[    0.024850] ACPI: bus type PCI registered
[    0.068233] PCI: PCI BIOS revision 2.10 entry at 0xfb110, last bus=1
[    0.068239] PCI: Using configuration type 1 for base access
[    0.073296] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[    0.074000] ACPI: Added _OSI(Module Device)
[    0.074006] ACPI: Added _OSI(Processor Device)
[    0.074010] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.074014] ACPI: Added _OSI(Processor Aggregator Device)
[    0.079139] ACPI: Interpreter enabled
[    0.079223] ACPI: (supports S0 S3 S4 S5)
[    0.079228] ACPI: Using PIC for interrupt routing
[    0.079305] PCI: Ignoring host bridge windows from ACPI; if necessary, use "pci=use_crs" and report a bug
[    0.091312] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.091335] acpi PNP0A03:00: _OSC: OS supports [Segments MSI]
[    0.091353] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.091366] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.091533] acpi PNP0A03:00: host bridge window [io  0x0cf8-0x0cff] (ignored)
[    0.091540] acpi PNP0A03:00: host bridge window [io  0x0000-0x0cf7 window] (ignored)
[    0.091545] acpi PNP0A03:00: host bridge window [io  0x0d00-0x3fff window] (ignored)
[    0.091551] acpi PNP0A03:00: host bridge window [io  0x4000-0x407f] (ignored)
[    0.091556] acpi PNP0A03:00: host bridge window [io  0x4080-0x40ff] (ignored)
[    0.091561] acpi PNP0A03:00: host bridge window [io  0x4100-0x4fff window] (ignored)
[    0.091566] acpi PNP0A03:00: host bridge window [io  0x5000-0x500f] (ignored)
[    0.091572] acpi PNP0A03:00: host bridge window [io  0x5010-0x5fff window] (ignored)
[    0.091577] acpi PNP0A03:00: host bridge window [io  0x6000-0x607f] (ignored)
[    0.091582] acpi PNP0A03:00: host bridge window [io  0x6080-0xffff window] (ignored)
[    0.091588] acpi PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff window] (ignored)
[    0.091593] acpi PNP0A03:00: host bridge window [mem 0x000c0000-0x000dffff window] (ignored)
[    0.091599] acpi PNP0A03:00: host bridge window [mem 0x40000000-0xffefffff window] (ignored)
[    0.091603] PCI: root bus 00: using default resources
[    0.091791] PCI host bridge to bus 0000:00
[    0.091801] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.091807] pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffff]
[    0.091815] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.091843] pci 0000:00:00.0: [1106:0691] type 00 class 0x060000
[    0.091864] pci 0000:00:00.0: reg 0x10: [mem 0xd0000000-0xd7ffffff pref]
[    0.092274] pci 0000:00:01.0: [1106:8598] type 01 class 0x060400
[    0.092354] pci 0000:00:01.0: supports D1
[    0.092584] pci 0000:00:07.0: [1106:0686] type 00 class 0x060100
[    0.092954] pci 0000:00:07.1: [1106:0571] type 00 class 0x01018a
[    0.093007] pci 0000:00:07.1: reg 0x20: [io  0xb000-0xb00f]
[    0.093031] pci 0000:00:07.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.093036] pci 0000:00:07.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.093042] pci 0000:00:07.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.093047] pci 0000:00:07.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.093314] pci 0000:00:07.2: [1106:3038] type 00 class 0x0c0300
[    0.093364] pci 0000:00:07.2: reg 0x20: [io  0xb400-0xb41f]
[    0.093549] pci 0000:00:07.2: System wakeup disabled by ACPI
[    0.093723] pci 0000:00:07.3: [1106:3038] type 00 class 0x0c0300
[    0.093773] pci 0000:00:07.3: reg 0x20: [io  0xb800-0xb81f]
[    0.093964] pci 0000:00:07.3: System wakeup disabled by ACPI
[    0.094155] pci 0000:00:07.4: [1106:3057] type 00 class 0x060000
[    0.094234] pci 0000:00:07.4: quirk: [io  0x6000-0x607f] claimed by vt82c686 HW-mon
[    0.094242] pci 0000:00:07.4: quirk: [io  0x5000-0x500f] claimed by vt82c686 SMB
[    0.094530] pci 0000:00:08.0: [10ec:8139] type 00 class 0x020000
[    0.094552] pci 0000:00:08.0: reg 0x10: [io  0xcc00-0xccff]
[    0.094566] pci 0000:00:08.0: reg 0x14: [mem 0xeb004000-0xeb0040ff]
[    0.094649] pci 0000:00:08.0: supports D1 D2
[    0.094655] pci 0000:00:08.0: PME# supported from D1 D2 D3hot D3cold
[    0.094918] pci 0000:00:09.0: [1106:3038] type 00 class 0x0c0300
[    0.094966] pci 0000:00:09.0: reg 0x20: [io  0xd000-0xd01f]
[    0.095027] pci 0000:00:09.0: supports D1 D2
[    0.095033] pci 0000:00:09.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.095292] pci 0000:00:09.1: [1106:3038] type 00 class 0x0c0300
[    0.095342] pci 0000:00:09.1: reg 0x20: [io  0xd400-0xd41f]
[    0.095404] pci 0000:00:09.1: supports D1 D2
[    0.095410] pci 0000:00:09.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.095662] pci 0000:00:09.2: [1106:3104] type 00 class 0x0c0320
[    0.095686] pci 0000:00:09.2: reg 0x10: [mem 0xeb000000-0xeb0000ff]
[    0.095774] pci 0000:00:09.2: supports D1 D2
[    0.095780] pci 0000:00:09.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.096133] pci 0000:00:09.3: [1106:3044] type 00 class 0x0c0010
[    0.096160] pci 0000:00:09.3: reg 0x10: [mem 0xeb001000-0xeb0017ff]
[    0.096173] pci 0000:00:09.3: reg 0x14: [io  0xd800-0xd87f]
[    0.096272] pci 0000:00:09.3: supports D2
[    0.096279] pci 0000:00:09.3: PME# supported from D2 D3hot D3cold
[    0.096567] pci 0000:00:0a.0: [10ec:8139] type 00 class 0x020000
[    0.096590] pci 0000:00:0a.0: reg 0x10: [io  0xdc00-0xdcff]
[    0.096604] pci 0000:00:0a.0: reg 0x14: [mem 0xeb002000-0xeb0020ff]
[    0.096688] pci 0000:00:0a.0: supports D1 D2
[    0.096694] pci 0000:00:0a.0: PME# supported from D1 D2 D3hot D3cold
[    0.096949] pci 0000:00:0b.0: [1274:5880] type 00 class 0x040100
[    0.096971] pci 0000:00:0b.0: reg 0x10: [io  0xe000-0xe03f]
[    0.097059] pci 0000:00:0b.0: supports D2
[    0.097308] pci 0000:00:0d.0: [9004:7178] type 00 class 0x010000
[    0.097329] pci 0000:00:0d.0: reg 0x10: [io  0xe400-0xe4ff]
[    0.097343] pci 0000:00:0d.0: reg 0x14: [mem 0xeb003000-0xeb003fff]
[    0.097383] pci 0000:00:0d.0: reg 0x30: [mem 0x00000000-0x00007fff pref]
[    0.097772] pci 0000:01:00.0: [1002:4153] type 00 class 0x030000
[    0.097796] pci 0000:01:00.0: reg 0x10: [mem 0xd8000000-0xdfffffff pref]
[    0.097809] pci 0000:01:00.0: reg 0x14: [io  0xa000-0xa0ff]
[    0.097821] pci 0000:01:00.0: reg 0x18: [mem 0xe9000000-0xe900ffff]
[    0.097853] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    0.097914] pci 0000:01:00.0: supports D1 D2
[    0.098061] pci 0000:01:00.1: [1002:4173] type 00 class 0x038000
[    0.098080] pci 0000:01:00.1: reg 0x10: [mem 0xe0000000-0xe7ffffff pref]
[    0.098092] pci 0000:01:00.1: reg 0x14: [mem 0xe9010000-0xe901ffff]
[    0.098168] pci 0000:01:00.1: supports D1 D2
[    0.098346] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.098357] pci 0000:00:01.0:   bridge window [io  0xa000-0xafff]
[    0.098364] pci 0000:00:01.0:   bridge window [mem 0xe8000000-0xe9ffffff]
[    0.098372] pci 0000:00:01.0:   bridge window [mem 0xd8000000-0xe7ffffff pref]
[    0.098390] pci_bus 0000:00: on NUMA node 0
[    0.098902] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
[    0.099277] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
[    0.099657] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
[    0.100132] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *9
[    0.103172] vgaarb: setting as boot device: PCI:0000:01:00.0
[    0.103179] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.103182] vgaarb: loaded
[    0.103186] vgaarb: bridge control possible 0000:01:00.0
[    0.103459] SCSI subsystem initialized
[    0.103673] libata version 3.00 loaded.
[    0.103703] ACPI: bus type USB registered
[    0.103813] usbcore: registered new interface driver usbfs
[    0.103857] usbcore: registered new interface driver hub
[    0.103927] usbcore: registered new device driver usb
[    0.104115] PCI: Using ACPI for IRQ routing
[    0.104128] PCI: pci_cache_line_size set to 32 bytes
[    0.104201] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.104207] e820: reserve RAM buffer [mem 0x3fff0000-0x3fffffff]
[    0.105401] clocksource: Switched to clocksource pit
[    0.127044] pnp: PnP ACPI init
[    0.127892] system 00:00: [mem 0x000d0800-0x000d3fff] has been reserved
[    0.127904] system 00:00: [mem 0x000f0000-0x000f7fff] could not be reserved
[    0.127911] system 00:00: [mem 0x000f8000-0x000fbfff] could not be reserved
[    0.127917] system 00:00: [mem 0x000fc000-0x000fffff] could not be reserved
[    0.127924] system 00:00: [mem 0x3fff0000-0x3fffffff] could not be reserved
[    0.127931] system 00:00: [mem 0xffff0000-0xffffffff] has been reserved
[    0.127938] system 00:00: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.127945] system 00:00: [mem 0x00100000-0x3ffeffff] could not be reserved
[    0.127952] system 00:00: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.127969] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.128570] system 00:01: [io  0x04d0-0x04d1] has been reserved
[    0.128587] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.128727] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.129154] pnp 00:03: [dma 2]
[    0.129288] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.130280] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.131408] pnp 00:05: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.132960] pnp 00:06: [dma 3]
[    0.133164] pnp 00:06: Plug and Play ACPI device, IDs PNP0401 (active)
[    0.133456] pnp 00:07: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.133650] pnp 00:08: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.133672] pnp: PnP ACPI: found 9 devices
[    0.133683] PnPBIOS: Disabled
[    0.176355] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.176419] clocksource: Switched to clocksource acpi_pm
[    0.176503] pci 0000:00:0d.0: BAR 6: assigned [mem 0x40000000-0x40007fff pref]
[    0.176522] pci 0000:01:00.0: BAR 6: assigned [mem 0xe8000000-0xe801ffff pref]
[    0.176530] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.176537] pci 0000:00:01.0:   bridge window [io  0xa000-0xafff]
[    0.176546] pci 0000:00:01.0:   bridge window [mem 0xe8000000-0xe9ffffff]
[    0.176554] pci 0000:00:01.0:   bridge window [mem 0xd8000000-0xe7ffffff pref]
[    0.176568] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
[    0.176574] pci_bus 0000:00: resource 5 [mem 0x00000000-0xffffffff]
[    0.176580] pci_bus 0000:01: resource 0 [io  0xa000-0xafff]
[    0.176586] pci_bus 0000:01: resource 1 [mem 0xe8000000-0xe9ffffff]
[    0.176591] pci_bus 0000:01: resource 2 [mem 0xd8000000-0xe7ffffff pref]
[    0.176701] NET: Registered protocol family 2
[    0.177313] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.177425] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    0.177620] TCP: Hash tables configured (established 8192 bind 8192)
[    0.177880] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.177988] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.178372] NET: Registered protocol family 1
[    0.178454] pci 0000:00:01.0: disabling DAC on VIA PCI bridge
[    0.178468] pci 0000:00:07.0: Disabling VIA external APIC routing
[    0.179772] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
[    0.179780] PCI: setting IRQ 11 as level-triggered
[    0.179797] pci 0000:00:07.2: VIA VLink IRQ fixup, from 9 to 11
[    0.180264] pci 0000:00:07.3: VIA VLink IRQ fixup, from 9 to 11
[    0.181403] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
[    0.182376] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
[    0.182381] PCI: setting IRQ 5 as level-triggered
[    0.182952] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.182962] PCI: CLS 32 bytes, default 32
[    0.184715] futex hash table entries: 256 (order: 1, 8192 bytes)
[    0.186006] workingset: timestamp_bits=30 max_order=18 bucket_order=0
[    0.197447] bounce: pool size: 64 pages
[    0.197651] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.197657] io scheduler noop registered
[    0.197660] io scheduler deadline registered
[    0.197795] io scheduler cfq registered (default)
[    0.198657] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.198672] ACPI: Power Button [PWRB]
[    0.198899] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.198906] ACPI: Power Button [PWRF]
[    0.199071] tsc: Marking TSC unstable due to TSC halts in idle
[    0.199213] Warning: Processor Platform Limit event detected, but not handled.
[    0.199215] Consider compiling CPUfreq support into your kernel.
[    0.200124] isapnp: Scanning for PnP cards...
[    0.554722] isapnp: No Plug & Play device found
[    0.554944] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.575776] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.596741] 00:05: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    0.598207] Non-volatile memory driver v1.3
[    0.598214] Linux agpgart interface v0.103
[    0.598312] [drm] Initialized drm 1.1.0 20060810
[    0.606698] loop: module loaded
[    0.607050] pata_via 0000:00:07.1: version 0.3.4
[    0.608618] scsi host0: pata_via
[    0.609072] scsi host1: pata_via
[    0.609289] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xb000 irq 14
[    0.609296] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xb008 irq 15
[    0.609498] 8139cp: 8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
[    0.609508] 8139cp 0000:00:08.0: This (id 10ec:8139 rev 10) is not an 8139C+ compatible chip, use 8139too
[    0.609538] 8139cp 0000:00:0a.0: This (id 10ec:8139 rev 10) is not an 8139C+ compatible chip, use 8139too
[    0.609606] 8139too: 8139too Fast Ethernet driver 0.9.28
[    0.610709] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
[    0.610717] PCI: setting IRQ 10 as level-triggered
[    0.611497] 8139too 0000:00:08.0 eth0: RealTek RTL8139 at 0x0001cc00, 00:80:1e:12:3d:b9, IRQ 10
[    0.612966] 8139too 0000:00:0a.0 eth1: RealTek RTL8139 at 0x0001dc00, 00:e0:4c:78:06:b8, IRQ 5
[    0.613050] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.613054] ehci-pci: EHCI PCI platform driver
[    0.613386] ehci-pci 0000:00:09.2: EHCI Host Controller
[    0.613415] ehci-pci 0000:00:09.2: new USB bus registered, assigned bus number 1
[    0.613520] ehci-pci 0000:00:09.2: irq 11, io mem 0xeb000000
[    0.628103] ehci-pci 0000:00:09.2: USB 2.0 started, EHCI 1.00
[    0.628842] hub 1-0:1.0: USB hub found
[    0.628880] hub 1-0:1.0: 4 ports detected
[    0.629429] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.629454] ohci-pci: OHCI PCI platform driver
[    0.629507] uhci_hcd: USB Universal Host Controller Interface driver
[    0.629824] uhci_hcd 0000:00:07.2: UHCI Host Controller
[    0.629853] uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 2
[    0.629906] uhci_hcd 0000:00:07.2: irq 11, io base 0x0000b400
[    0.630679] hub 2-0:1.0: USB hub found
[    0.630719] hub 2-0:1.0: 2 ports detected
[    0.631393] uhci_hcd 0000:00:07.3: UHCI Host Controller
[    0.631423] uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 3
[    0.631476] uhci_hcd 0000:00:07.3: irq 11, io base 0x0000b800
[    0.632389] hub 3-0:1.0: USB hub found
[    0.632425] hub 3-0:1.0: 2 ports detected
[    0.633120] uhci_hcd 0000:00:09.0: UHCI Host Controller
[    0.633151] uhci_hcd 0000:00:09.0: new USB bus registered, assigned bus number 4
[    0.633204] uhci_hcd 0000:00:09.0: irq 11, io base 0x0000d000
[    0.633987] hub 4-0:1.0: USB hub found
[    0.634028] hub 4-0:1.0: 2 ports detected
[    0.634696] uhci_hcd 0000:00:09.1: UHCI Host Controller
[    0.634725] uhci_hcd 0000:00:09.1: new USB bus registered, assigned bus number 5
[    0.634781] uhci_hcd 0000:00:09.1: irq 5, io base 0x0000d400
[    0.635565] hub 5-0:1.0: USB hub found
[    0.635607] hub 5-0:1.0: 2 ports detected
[    0.636346] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    0.636977] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.637005] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.637645] mousedev: PS/2 mouse device common for all mice
[    0.638861] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
[    0.638919] rtc_cmos 00:02: alarms up to one year, y3k, 242 bytes nvram
[    0.639544] NET: Registered protocol family 17
[    0.639720] Using IPI No-Shortcut mode
[    0.640537] registered taskstats version 1
[    0.641538] console [netcon0] enabled
[    0.641541] netconsole: network logging started
[    0.641625] rtc_cmos 00:02: setting system clock to 2016-10-03 07:16:03 UTC (1475478963)
[    0.641753] PM: Hibernation image not present or could not be loaded.
[    0.660402] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input2
[    0.956076] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    0.956139] usb 2-1: new full-speed USB device number 2 using uhci_hcd
[    0.976705] ata1.00: ATA-6: ST3120026A, 8.01, max UDMA/100
[    0.976713] ata1.00: 234441648 sectors, multi 16: LBA48 
[    0.976738] ata1.01: ATAPI: PLEXTOR CD-R   PX-W4824A, 1.07, max UDMA/33
[    1.000701] ata1.00: configured for UDMA/100
[    1.000789] random: fast init done
[    1.005660] ata1.01: configured for UDMA/33
[    1.006515] scsi 0:0:0:0: Direct-Access     ATA      ST3120026A       8.01 PQ: 0 ANSI: 5
[    1.007901] sd 0:0:0:0: [sda] 234441648 512-byte logical blocks: (120 GB/112 GiB)
[    1.008311] sd 0:0:0:0: [sda] Write Protect is off
[    1.008323] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.008452] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.050815]  sda: sda1 sda2 < sda5 >
[    1.051549] scsi 0:0:1:0: CD-ROM            PLEXTOR  CD-R   PX-W4824A 1.07 PQ: 0 ANSI: 5
[    1.062312] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.106869] hub 1-1:1.0: USB hub found
[    1.107302] hub 1-1:1.0: 4 ports detected
[    1.184083] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0xd00a82d1f3, max_idle_ns: 440795238111 ns
[    1.232847] usb 1-2: new high-speed USB device number 3 using ehci-pci
[    1.252485] ata2.01: ATAPI: HL-DT-ST DVDRAM GSA-4167B, DL13, max UDMA/33
[    1.276452] ata2.01: configured for UDMA/33
[    1.284209] scsi 1:0:1:0: CD-ROM            HL-DT-ST DVDRAM GSA-4167B DL13 PQ: 0 ANSI: 5
[    1.381174] hub 1-2:1.0: USB hub found
[    1.381360] hub 1-2:1.0: 7 ports detected
[    1.500091] usb 1-4: new high-speed USB device number 4 using ehci-pci
[    2.130993] input: ImPS/2 BYD TouchPad as /devices/platform/i8042/serio1/input/input4
[    2.154352] EXT4-fs (sda1): couldn't mount as ext3 due to feature incompatibilities
[    2.155056] EXT4-fs (sda1): couldn't mount as ext2 due to feature incompatibilities
[    2.196994] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[    2.197063] VFS: Mounted root (ext4 filesystem) readonly on device 8:1.
[    2.198903] Freeing unused kernel memory: 524K (c15c1000 - c1644000)
[    2.199262] Write protecting the kernel text: 3920k
[    2.199367] Write protecting the kernel read-only data: 1528k
[    4.216841] systemd-udevd[174]: starting version 215
[    5.407957] random: crng init done
[    7.986027] Adding 2094076k swap on /dev/sda5.  Priority:-1 extents:1 across:2094076k 
[    8.134463] EXT4-fs (sda1): re-mounted. Opts: (null)
[    8.464721] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
[   12.681358] 8139too 0000:00:0a.0 eth1: link down
[   25.169518] 8139too 0000:00:08.0 eth0: link up, 100Mbps, full-duplex, lpa 0x41E1


--Boundary-00=_Ggg8XD4H7rIXqcO--
