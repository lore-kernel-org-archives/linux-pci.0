Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Ondrej Zary <linux@rainbow-software.org>
To: okaya@codeaurora.org
Subject: Re: 4.7 regression: ACPI: No IRQ available for PCI Interrupt Link [LNKD]. Try pci=noacpi or acpi=off
Date: Thu, 29 Sep 2016 15:49:07 +0200
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        wim@djo.tudelft.nl, ravikanth.nalla@hpe.com
References: <201609251512.05657.linux@rainbow-software.org> <201609291110.50176.linux@rainbow-software.org> <131b4220b509ed95dfbb35a441ccbc2c@codeaurora.org>
In-Reply-To: <131b4220b509ed95dfbb35a441ccbc2c@codeaurora.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_TvR7XjBEovwA707"
Message-Id: <201609291549.07784.linux@rainbow-software.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Boundary-00=_TvR7XjBEovwA707
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 29 September 2016, okaya@codeaurora.org wrote:
> On 2016-09-29 05:10, Ondrej Zary wrote:
> > On Thursday 29 September 2016, Sinan Kaya wrote:
> >> On 9/28/2016 3:23 PM, Ondrej Zary wrote:
> >> > On Wednesday 28 September 2016 20:22:40 Sinan Kaya wrote:
> >> >> On 9/28/2016 1:02 PM, Ondrej Zary wrote:
> >> >>>> Thanks, It sounds like you have more than one machine with similar
> >> >>>>
> >> >>>>> problems. Can you collect the log from the other machines with
> >> >>>>> 4.8-rc8?
> >> >>>>>
> >> >>>>> and also a boot log with 4.6 kernel where things are working?
> >> >>>
> >> >>> The attached logs are from another machine:
> >> >>>
> >> >>> dmesg-bad-debug.txt: 4.8-rc8 with your debug patch - bad
> >> >>>
> >> >>> dmesg-reverted.txt: 4.8-rc8 with patches (as per Rafael's
> >> >>> suggestion) reverted - good
> >> >>>
> >> >>> dmesg-3.6.txt: 4.6 (Debian kernel) - good
> >> >>
> >> >> I think I see a race condition for the SCI interrupt. I need another
> >> >> dump from 4.8-rc8 with the attached patch to confirm. Let's remove
> >> >> the previous one and apply this one.
> >> >
> >> > dmesg-reverted.txt: 4.8-rc8 w/patches reverted (good)
> >> > $ head /proc/interrupts
> >> >            CPU0
> >> >   0:       8531    XT-PIC  timer
> >> >   1:          9    XT-PIC  i8042
> >> >   2:          0    XT-PIC  cascade
> >> >   8:          1    XT-PIC  rtc0
> >> >  11:        713    XT-PIC  acpi, uhci_hcd:usb1, uhci_hcd:usb2, nvkm,
> >> > eth0 12:        161    XT-PIC  i8042
> >> >  14:       4042    XT-PIC  pata_via
> >> >  15:          0    XT-PIC  pata_via
> >> > NMI:          0   Non-maskable interrupts
> >> >
> >> > dmesg-bad-debug.txt: 4.8-rc8 (bad)
> >> > $ head /proc/interrupts
> >> >            CPU0
> >> >   0:       8027    XT-PIC  timer
> >> >   1:        286    XT-PIC  i8042
> >> >   2:          0    XT-PIC  cascade
> >> >   8:          1    XT-PIC  rtc0
> >> >  10:          0    XT-PIC  uhci_hcd:usb1, uhci_hcd:usb2
> >> >  11:          0    XT-PIC  acpi, nvkm, eth0
> >> >  12:        161    XT-PIC  i8042
> >> >  14:       4069    XT-PIC  pata_via
> >> >  15:          0    XT-PIC  pata_via
> >> >
> >> > (I'm moving between different machines through the day - these logs
> >> > are from different machine than the last ones).
> >>
> >> Can you try these patches on your machines please?
> >
> > It doesn't even boot :(
>
> Ok, since I have not seen the full boot log I am guessing that isa api
> gets called before the link objects are initialized.

Netconsole did not work (probably because it crashes too early?) and I don't 
have a null-modem cable.

> Can you appply the first three only (0001, 0002 and 0003) to see if it
> makes a difference?

It boots with first 3 patches only but the problem remains - see the attached 
log.

-- 
Ondrej Zary

--Boundary-00=_TvR7XjBEovwA707
Content-Type: text/plain;
  charset="iso-8859-15";
  name="dmesg-bad2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg-bad2.txt"

[    0.000000] Linux version 4.8.0-rc8+ (zary@gsql) (gcc version 4.7.2 (Debian 4.7.2-5) ) #122 SMP Thu Sep 29 15:42:41 CEST 2016
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
[    0.000000] free_area_init_node: node 0, pgdat c15b1a60, node_mem_map c770c020
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
[    0.000000] Memory: 114352K/122472K available (3921K kernel code, 437K rwdata, 1520K rodata, 524K init, 412K bss, 8120K reserved, 0K cma-reserved, 0K highmem)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xfff17000 - 0xfffff000   ( 928 kB)
[    0.000000]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[    0.000000]     vmalloc : 0xc7ffc000 - 0xff7fe000   ( 888 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc77fc000   ( 119 MB)
[    0.000000]       .init : 0xc15c1000 - 0xc1644000   ( 524 kB)
[    0.000000]       .data : 0xc13d4761 - 0xc15bf4e0   (1963 kB)
[    0.000000]       .text : 0xc1000000 - 0xc13d4761   (3921 kB)
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
[    0.000000] tsc: Detected 857.676 MHz processor
[    0.004009] Calibrating delay loop (skipped), value calculated using timer frequency.. 1715.35 BogoMIPS (lpj=3430704)
[    0.004022] pid_max: default: 32768 minimum: 301
[    0.004070] ACPI: Core revision 20160422
[    0.010358] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.010374] 
[    0.010382] ACPI: setting ELCR to 0200 (from 0e20)
[    0.010477] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.010483] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.011708] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.011719] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.017764] Freeing SMP alternatives memory: 16K (c1644000 - c1648000)
[    0.018383] smpboot: Max logical packages: 1
[    0.018393] smpboot: weird, boot CPU (#0) not listed by the BIOS
[    0.018396] smpboot: SMP motherboard not detected
[    0.018398] smpboot: SMP disabled
[    0.018405] smpboot: Local APIC not detected. Using dummy APIC emulation.
[    0.018411] Performance Events: 
[    0.018422] no APIC, boot with the "lapic" boot parameter to force-enable it.
[    0.018424] no hardware sampling interrupt available.
[    0.018432] AMD PMU driver.
[    0.018443] ... version:                0
[    0.018446] ... bit width:              48
[    0.018449] ... generic registers:      4
[    0.018452] ... value mask:             0000ffffffffffff
[    0.018455] ... max period:             00007fffffffffff
[    0.018458] ... fixed-purpose events:   0
[    0.018460] ... event mask:             000000000000000f
[    0.019871] x86: Booted up 1 node, 1 CPUs
[    0.019883] smpboot: Total of 1 processors activated (1715.35 BogoMIPS)
[    0.020596] devtmpfs: initialized
[    0.021748] PM: Registering ACPI NVS region [mem 0x077ff000-0x077fffff] (4096 bytes)
[    0.022017] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.022512] NET: Registered protocol family 16
[    0.023195] cpuidle: using governor ladder
[    0.023201] cpuidle: using governor menu
[    0.023311] Simple Boot Flag at 0x3a set to 0x1
[    0.023335] clocksource: pit: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1601818034827 ns
[    0.023358] ACPI: bus type PCI registered
[    0.030132] PCI: PCI BIOS revision 2.10 entry at 0xf10c0, last bus=1
[    0.030136] PCI: Using configuration type 1 for base access
[    0.036253] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[    0.036944] ACPI: Added _OSI(Module Device)
[    0.036950] ACPI: Added _OSI(Processor Device)
[    0.036954] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.036958] ACPI: Added _OSI(Processor Aggregator Device)
[    0.040959] ACPI: Interpreter enabled
[    0.041039] ACPI: (supports S0 S1 S4 S5)
[    0.041046] ACPI: Using PIC for interrupt routing
[    0.041155] PCI: Ignoring host bridge windows from ACPI; if necessary, use "pci=use_crs" and report a bug
[    0.054248] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[    0.054463] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
[    0.054657] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
[    0.054849] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
[    0.055060] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.055080] acpi PNP0A03:00: _OSC: OS supports [Segments MSI]
[    0.055100] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.055118] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.055273] acpi PNP0A03:00: host bridge window [io  0x0cf8-0x0cff] (ignored)
[    0.055281] acpi PNP0A03:00: host bridge window [io  0x0000-0x0cf7 window] (ignored)
[    0.055287] acpi PNP0A03:00: host bridge window [io  0x0d00-0xffff window] (ignored)
[    0.055293] acpi PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff window] (ignored)
[    0.055299] acpi PNP0A03:00: host bridge window [mem 0x000c8000-0x000dffff window] (ignored)
[    0.055305] acpi PNP0A03:00: host bridge window [mem 0x07800000-0xffffffff window] (ignored)
[    0.055309] PCI: root bus 00: using default resources
[    0.055549] PCI host bridge to bus 0000:00
[    0.055559] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.055565] pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffff]
[    0.055574] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.055619] pci 0000:00:00.0: [1106:0305] type 00 class 0x060000
[    0.055642] pci 0000:00:00.0: reg 0x10: [mem 0xf8000000-0xfbffffff pref]
[    0.056110] pci 0000:00:01.0: [1106:8305] type 01 class 0x060400
[    0.056180] pci 0000:00:01.0: supports D1
[    0.056280] pci 0000:00:01.0: System wakeup disabled by ACPI
[    0.056498] pci 0000:00:07.0: [1106:0686] type 00 class 0x060100
[    0.056838] pci 0000:00:07.1: [1106:0571] type 00 class 0x01018a
[    0.056889] pci 0000:00:07.1: reg 0x20: [io  0xd800-0xd80f]
[    0.056913] pci 0000:00:07.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.056919] pci 0000:00:07.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.056925] pci 0000:00:07.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.056930] pci 0000:00:07.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.057190] pci 0000:00:07.2: [1106:3038] type 00 class 0x0c0300
[    0.057237] pci 0000:00:07.2: reg 0x20: [io  0xd400-0xd41f]
[    0.057368] pci 0000:00:07.2: System wakeup disabled by ACPI
[    0.057565] pci 0000:00:07.3: [1106:3038] type 00 class 0x0c0300
[    0.057612] pci 0000:00:07.3: reg 0x20: [io  0xd000-0xd01f]
[    0.057744] pci 0000:00:07.3: System wakeup disabled by ACPI
[    0.057944] pci 0000:00:07.4: [1106:3057] type 00 class 0x068000
[    0.058015] pci 0000:00:07.4: quirk: [io  0xe200-0xe27f] claimed by vt82c686 HW-mon
[    0.058023] pci 0000:00:07.4: quirk: [io  0xe800-0xe80f] claimed by vt82c686 SMB
[    0.058272] pci 0000:00:07.5: [1106:3058] type 00 class 0x040100
[    0.058292] pci 0000:00:07.5: reg 0x10: [io  0xb800-0xb8ff]
[    0.058306] pci 0000:00:07.5: reg 0x14: [io  0xb400-0xb403]
[    0.058319] pci 0000:00:07.5: reg 0x18: [io  0xb000-0xb003]
[    0.058632] pci 0000:00:0e.0: [10ec:8139] type 00 class 0x020000
[    0.058654] pci 0000:00:0e.0: reg 0x10: [io  0xa400-0xa4ff]
[    0.058668] pci 0000:00:0e.0: reg 0x14: [mem 0xee800000-0xee8000ff]
[    0.058708] pci 0000:00:0e.0: reg 0x30: [mem 0x00000000-0x00007fff pref]
[    0.058746] pci 0000:00:0e.0: supports D1 D2
[    0.058752] pci 0000:00:0e.0: PME# supported from D1 D2 D3hot D3cold
[    0.059123] pci 0000:01:00.0: [5333:8a26] type 00 class 0x030000
[    0.059144] pci 0000:01:00.0: reg 0x10: [mem 0xef000000-0xef07ffff]
[    0.059157] pci 0000:01:00.0: reg 0x14: [mem 0xf0000000-0xf7ffffff pref]
[    0.059196] pci 0000:01:00.0: reg 0x30: [mem 0xefff0000-0xefffffff pref]
[    0.059242] pci 0000:01:00.0: supports D1 D2
[    0.059421] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.059432] pci 0000:00:01.0:   bridge window [mem 0xef000000-0xefdfffff]
[    0.059443] pci 0000:00:01.0:   bridge window [mem 0xeff00000-0xf7ffffff pref]
[    0.059456] pci_bus 0000:00: on NUMA node 0
[    0.062655] vgaarb: setting as boot device: PCI:0000:01:00.0
[    0.062665] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.062669] vgaarb: loaded
[    0.062674] vgaarb: bridge control possible 0000:01:00.0
[    0.063000] SCSI subsystem initialized
[    0.063282] libata version 3.00 loaded.
[    0.063321] ACPI: bus type USB registered
[    0.063475] usbcore: registered new interface driver usbfs
[    0.063530] usbcore: registered new interface driver hub
[    0.063593] usbcore: registered new device driver usb
[    0.063745] PCI: Using ACPI for IRQ routing
[    0.063760] PCI: pci_cache_line_size set to 32 bytes
[    0.063825] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.063832] e820: reserve RAM buffer [mem 0x077fc000-0x07ffffff]
[    0.065399] clocksource: Switched to clocksource pit
[    0.089361] pnp: PnP ACPI init
[    0.090015] system 00:00: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.090030] system 00:00: [mem 0x000f0000-0x000fffff] could not be reserved
[    0.090037] system 00:00: [mem 0x00100000-0x077fffff] could not be reserved
[    0.090045] system 00:00: [mem 0xfffe0000-0xffffffff] could not be reserved
[    0.090051] system 00:00: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.090071] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.090822] system 00:01: [io  0x03f0-0x03f1] has been reserved
[    0.090832] system 00:01: [io  0x04d0-0x04d1] has been reserved
[    0.090850] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.091103] system 00:02: [io  0xe400-0xe47f] has been reserved
[    0.091111] system 00:02: [io  0xe800-0xe80f] has been reserved
[    0.091118] system 00:02: [io  0xe200-0xe27f] has been reserved
[    0.091130] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.091507] pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.091895] pnp 00:04: [dma 2]
[    0.092031] pnp 00:04: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.092821] pnp 00:05: [dma 3]
[    0.093009] pnp 00:05: Plug and Play ACPI device, IDs PNP0401 (active)
[    0.093719] pnp 00:06: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.094478] pnp 00:07: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.095094] pnp 00:08: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.095354] pnp 00:09: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.095568] pnp: PnP ACPI: found 10 devices
[    0.095584] PnPBIOS: Disabled
[    0.138392] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.138462] clocksource: Switched to clocksource acpi_pm
[    0.138541] pci 0000:00:0e.0: BAR 6: assigned [mem 0x08000000-0x08007fff pref]
[    0.138556] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.138569] pci 0000:00:01.0:   bridge window [mem 0xef000000-0xefdfffff]
[    0.138578] pci 0000:00:01.0:   bridge window [mem 0xeff00000-0xf7ffffff pref]
[    0.138650] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
[    0.138657] pci_bus 0000:00: resource 5 [mem 0x00000000-0xffffffff]
[    0.138664] pci_bus 0000:01: resource 1 [mem 0xef000000-0xefdfffff]
[    0.138672] pci_bus 0000:01: resource 2 [mem 0xeff00000-0xf7ffffff pref]
[    0.138807] NET: Registered protocol family 2
[    0.139536] TCP established hash table entries: 1024 (order: 0, 4096 bytes)
[    0.139571] TCP bind hash table entries: 1024 (order: 1, 8192 bytes)
[    0.139617] TCP: Hash tables configured (established 1024 bind 1024)
[    0.139766] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    0.139802] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    0.140175] NET: Registered protocol family 1
[    0.140255] pci 0000:00:00.0: Applying VIA southbridge workaround
[    0.140270] pci 0000:00:01.0: disabling DAC on VIA PCI bridge
[    0.140284] pci 0000:00:07.0: Disabling VIA external APIC routing
[    0.140690] ACPI: No IRQ available for PCI Interrupt Link [LNKD]. Try pci=noacpi or acpi=off
[    0.140775] pci 0000:00:07.2: PCI INT D: no GSI
[    0.140995] ACPI: No IRQ available for PCI Interrupt Link [LNKD]. Try pci=noacpi or acpi=off
[    0.141055] pci 0000:00:07.3: PCI INT D: no GSI
[    0.141113] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.141120] PCI: CLS 32 bytes, default 32
[    0.143012] futex hash table entries: 256 (order: 1, 8192 bytes)
[    0.144692] workingset: timestamp_bits=30 max_order=15 bucket_order=0
[    0.158608] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.158623] io scheduler noop registered
[    0.158626] io scheduler deadline registered
[    0.158776] io scheduler cfq registered (default)
[    0.159922] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.159939] ACPI: Power Button [PWRB]
[    0.160447] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.160456] ACPI: Power Button [PWRF]
[    0.160635] tsc: Marking TSC unstable due to TSC halts in idle
[    0.160824] Warning: Processor Platform Limit event detected, but not handled.
[    0.160827] Consider compiling CPUfreq support into your kernel.
[    0.161769] isapnp: Scanning for PnP cards...
[    0.516469] isapnp: No Plug & Play device found
[    0.516788] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.537619] 00:06: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.558475] 00:07: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    0.560183] Non-volatile memory driver v1.3
[    0.560191] Linux agpgart interface v0.103
[    0.560355] [drm] Initialized drm 1.1.0 20060810
[    0.570966] loop: module loaded
[    0.571335] pata_via 0000:00:07.1: version 0.3.4
[    0.574456] scsi host0: pata_via
[    0.574986] scsi host1: pata_via
[    0.575223] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xd800 irq 14
[    0.575230] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xd808 irq 15
[    0.575475] 8139cp: 8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
[    0.575484] 8139cp 0000:00:0e.0: This (id 10ec:8139 rev 10) is not an 8139C+ compatible chip, use 8139too
[    0.575567] 8139too: 8139too Fast Ethernet driver 0.9.28
[    0.576743] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
[    0.576752] PCI: setting IRQ 10 as level-triggered
[    0.577749] 8139too 0000:00:0e.0 eth0: RealTek RTL8139 at 0x0001a400, 00:40:95:08:18:34, IRQ 10
[    0.577848] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.577851] ehci-pci: EHCI PCI platform driver
[    0.577924] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.577963] ohci-pci: OHCI PCI platform driver
[    0.578012] uhci_hcd: USB Universal Host Controller Interface driver
[    0.578385] ACPI: No IRQ available for PCI Interrupt Link [LNKD]. Try pci=noacpi or acpi=off
[    0.578466] uhci_hcd 0000:00:07.2: PCI INT D: no GSI
[    0.578515] uhci_hcd 0000:00:07.2: UHCI Host Controller
[    0.578567] uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
[    0.578640] uhci_hcd 0000:00:07.2: irq 9, io base 0x0000d400
[    0.580270] hub 1-0:1.0: USB hub found
[    0.580314] hub 1-0:1.0: 2 ports detected
[    0.581141] ACPI: No IRQ available for PCI Interrupt Link [LNKD]. Try pci=noacpi or acpi=off
[    0.581228] uhci_hcd 0000:00:07.3: PCI INT D: no GSI
[    0.581265] uhci_hcd 0000:00:07.3: UHCI Host Controller
[    0.581295] uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
[    0.581364] uhci_hcd 0000:00:07.3: irq 9, io base 0x0000d000
[    0.582355] hub 2-0:1.0: USB hub found
[    0.582392] hub 2-0:1.0: 2 ports detected
[    0.583089] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    0.583722] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.583757] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.584624] mousedev: PS/2 mouse device common for all mice
[    0.585434] rtc_cmos 00:03: RTC can wake from S4
[    0.585911] rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
[    0.585975] rtc_cmos 00:03: alarms up to one year, 242 bytes nvram
[    0.586784] NET: Registered protocol family 17
[    0.586943] Using IPI No-Shortcut mode
[    0.587683] registered taskstats version 1
[    0.588870] console [netcon0] enabled
[    0.588875] netconsole: network logging started
[    0.588965] rtc_cmos 00:03: setting system clock to 2016-09-29 13:45:19 UTC (1475156719)
[    0.589114] PM: Hibernation image not present or could not be loaded.
[    0.615687] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input2
[    0.738823] ata1.00: ATA-4: ST33210A, 3.02, max UDMA/33
[    0.738836] ata1.00: 6346368 sectors, multi 16: LBA 
[    0.743727] ata1.00: configured for UDMA/33
[    0.744558] scsi 0:0:0:0: Direct-Access     ATA      ST33210A         3.02 PQ: 0 ANSI: 5
[    0.745506] sd 0:0:0:0: [sda] 6346368 512-byte logical blocks: (3.25 GB/3.03 GiB)
[    0.745713] sd 0:0:0:0: [sda] Write Protect is off
[    0.745721] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.745805] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    0.772146]  sda: sda1 sda2 < sda5 >
[    0.773927] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.079169] random: fast init done
[    1.152065] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0xc5ce6d8a44, max_idle_ns: 440795234972 ns
[    2.210145] input: PS/2 BYD TouchPad as /devices/platform/i8042/serio1/input/input4
[    2.233551] EXT4-fs (sda1): mounting ext3 file system using the ext4 subsystem
[    2.259908] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[    2.259989] VFS: Mounted root (ext3 filesystem) readonly on device 8:1.
[    2.263117] Freeing unused kernel memory: 524K (c15c1000 - c1644000)
[    2.263442] Write protecting the kernel text: 3924k
[    2.263535] Write protecting the kernel read-only data: 1524k
[    4.386350] udevd (114): /proc/114/oom_adj is deprecated, please use /proc/114/oom_score_adj instead.
[    6.036430] random: crng init done
[    6.552131] Adding 112416k swap on /dev/sda5.  Priority:-1 extents:1 across:112416k 
[    6.571931] EXT4-fs (sda1): re-mounted. Opts: (null)
[    7.032913] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
[    8.977967] 8139too 0000:00:0e.0 eth0: link up, 100Mbps, full-duplex, lpa 0x45E1

--Boundary-00=_TvR7XjBEovwA707--
