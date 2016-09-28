Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Ondrej Zary <linux@rainbow-software.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: 4.7 regression: ACPI: No IRQ available for PCI Interrupt Link [LNKD]. Try pci=noacpi or acpi=off
Date: Wed, 28 Sep 2016 19:02:31 +0200
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <201609251512.05657.linux@rainbow-software.org> <201609281032.35190.linux@rainbow-software.org> <b404278b-d8e1-2b16-e044-c30d27ba8c25@codeaurora.org>
In-Reply-To: <b404278b-d8e1-2b16-e044-c30d27ba8c25@codeaurora.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ne/6XyV8J/SRmzo"
Message-Id: <201609281902.31500.linux@rainbow-software.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Boundary-00=_ne/6XyV8J/SRmzo
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 28 September 2016 16:11:39 Sinan Kaya wrote:
> On 9/28/2016 4:32 AM, Ondrej Zary wrote:
> >>> OK
> >>>
> >>> > > Sinan, can you help, please?
> >> >
> >> > Sure, let's see what's going on. I was writing an email.
> >> >
> >> > Can we apply this and collect the kernel log? It also helps to see the
> >> > kernel log from a working combination.
> >
> > This is from yet another machine with the same problem:
>
> Thanks, It sounds like you have more than one machine with similar
> problems. Can you collect the log from the other machines with 4.8-rc8?
>
> and also a boot log with 4.6 kernel where things are working?

The attached logs are from another machine:

dmesg-bad-debug.txt: 4.8-rc8 with your debug patch - bad

dmesg-reverted.txt: 4.8-rc8 with patches (as per Rafael's suggestion) 
reverted - good

dmesg-3.6.txt: 4.6 (Debian kernel) - good


-- 
Ondrej Zary

--Boundary-00=_ne/6XyV8J/SRmzo
Content-Type: text/plain;
  charset="iso-8859-15";
  name="dmesg-bad-debug.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg-bad-debug.txt"

[    0.000000] Linux version 4.8.0-rc8+ (zary@gsql) (gcc version 4.7.2 (Debian 4.7.2-5) ) #110 SMP Wed Sep 28 18:39:32 CEST 2016
[    0.000000] x86/fpu: Legacy x87 FPU detected.
[    0.000000] x86/fpu: Using 'eager' FPU context switches.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001fffcfff] usable
[    0.000000] BIOS-e820: [mem 0x000000001fffd000-0x000000001fffefff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000001ffff000-0x000000001fffffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000ffff0000-0x00000000ffffffff] reserved
[    0.000000] Notice: NX (Execute Disable) protection missing in CPU!
[    0.000000] Legacy DMI 2.0 present.
[    0.000000] DMI: System Manufacturer System Name/P2B, BIOS ASUS P2B ACPI BIOS Revision 1014 Beta 003                        08/01/02
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x1fffd max_arch_pfn = 0x100000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-AFFFF uncachable
[    0.000000]   B0000-BFFFF write-combining
[    0.000000]   C0000-C7FFF write-protect
[    0.000000]   C8000-F7FFF uncachable
[    0.000000]   F8000-FCFFF write-protect
[    0.000000]   FD000-FFFFF uncachable
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask FE0000000 write-back
[    0.000000]   1 disabled
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 base 0D8000000 mask FF8000000 write-combining
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86/PAT: PAT not supported by CPU.
[    0.000000] x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC- UC  
[    0.000000] initial memory mapped: [mem 0x00000000-0x01bfffff]
[    0.000000] Base memory trampoline at [c009b000] 9b000 size 16384
[    0.000000] BRK [0x016b7000, 0x016b7fff] PGTABLE
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F7F90 000014 (v00 ASUS  )
[    0.000000] ACPI: RSDT 0x000000001FFFD000 00002C (v01 ASUS   P2B      42302E31 MSFT 31313031)
[    0.000000] ACPI: FACP 0x000000001FFFD080 000074 (v01 ASUS   P2B      42302E31 MSFT 31313031)
[    0.000000] ACPI: DSDT 0x000000001FFFD100 001BA8 (v01 ASUS   P2B      00001000 MSFT 01000001)
[    0.000000] ACPI: FACS 0x000000001FFFF000 000040
[    0.000000] ACPI: BOOT 0x000000001FFFD040 000028 (v01 ASUS   P2B      42302E31 MSFT 31313031)
[    0.000000] 0MB HIGHMEM available.
[    0.000000] 511MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 1fffd000
[    0.000000]   low ram: 0 - 1fffd000
[    0.000000] BRK [0x016b8000, 0x016b8fff] PGTABLE
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   Normal   [mem 0x0000000001000000-0x000000001fffcfff]
[    0.000000]   HighMem  empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000001fffcfff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000001fffcfff]
[    0.000000] On node 0 totalpages: 130971
[    0.000000] free_area_init_node: node 0, pgdat c15b1840, node_mem_map dfbfd020
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
[    0.000000]   Normal zone: 992 pages used for memmap
[    0.000000]   Normal zone: 126973 pages, LIFO batch:31
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
[    0.000000] e820: [mem 0x20000000-0xfffeffff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:1 nr_node_ids:1
[    0.000000] percpu: Embedded 19 pages/cpu @dfbe6000 s47980 r0 d29844 u77824
[    0.000000] pcpu-alloc: s47980 r0 d29844 u77824 alloc=19*4096
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 129947
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-test root=/dev/sda3 ro quiet drm_kms_helper.edid_firmware=VGA-1:edid-iiyama.bin video=VGA-1:1024x768
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Initializing CPU#0
[    0.000000] Initializing HighMem for node 0 (00000000:00000000)
[    0.000000] Memory: 512336K/523884K available (3918K kernel code, 436K rwdata, 1520K rodata, 524K init, 412K bss, 11548K reserved, 0K cma-reserved, 0K highmem)
[    0.000000] virtual kernel memory layout:
    fixmap  : 0xfff17000 - 0xfffff000   ( 928 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xe07fd000 - 0xff7fe000   ( 496 MB)
    lowmem  : 0xc0000000 - 0xdfffd000   ( 511 MB)
      .init : 0xc15c1000 - 0xc1644000   ( 524 kB)
      .data : 0xc13d3cc1 - 0xc15bf2e0   (1965 kB)
      .text : 0xc1000000 - 0xc13d3cc1   (3919 kB)
[    0.000000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 32.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=1
[    0.000000] NR_IRQS:2304 nr_irqs:32 16
[    0.000000] CPU 0 irqstacks, hard=df41c000 soft=df41e000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 1365.077 MHz processor
[    0.004006] Calibrating delay loop (skipped), value calculated using timer frequency.. 2730.15 BogoMIPS (lpj=5460308)
[    0.004014] pid_max: default: 32768 minimum: 301
[    0.004037] ACPI: Core revision 20160422
[    0.008736] ACPI: 1 ACPI AML tables successfully acquired and loaded

[    0.008749] ACPI: setting ELCR to 0200 (from 0e00)
[    0.008799] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.008802] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.009413] Last level iTLB entries: 4KB 32, 2MB 0, 4MB 2
[    0.009421] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 8, 1GB 0
[    0.012358] Freeing SMP alternatives memory: 16K (c1644000 - c1648000)
[    0.012620] smpboot: Max logical packages: 1
[    0.012625] smpboot: weird, boot CPU (#0) not listed by the BIOS
[    0.012627] smpboot: SMP motherboard not detected
[    0.012628] smpboot: SMP disabled
[    0.012631] smpboot: Local APIC not detected. Using dummy APIC emulation.
[    0.012634] Performance Events: 
[    0.012640] no APIC, boot with the "lapic" boot parameter to force-enable it.
[    0.012642] no hardware sampling interrupt available.
[    0.012646] p6 PMU driver.
[    0.012651] ... version:                0
[    0.012653] ... bit width:              32
[    0.012654] ... generic registers:      2
[    0.012656] ... value mask:             00000000ffffffff
[    0.012658] ... max period:             000000007fffffff
[    0.012659] ... fixed-purpose events:   0
[    0.012661] ... event mask:             0000000000000003
[    0.013422] x86: Booted up 1 node, 1 CPUs
[    0.013429] smpboot: Total of 1 processors activated (2730.15 BogoMIPS)
[    0.013754] devtmpfs: initialized
[    0.014437] PM: Registering ACPI NVS region [mem 0x1ffff000-0x1fffffff] (4096 bytes)
[    0.014568] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.014788] NET: Registered protocol family 16
[    0.015172] cpuidle: using governor ladder
[    0.015175] cpuidle: using governor menu
[    0.015309] Simple Boot Flag at 0x46 set to 0x1
[    0.015323] clocksource: pit: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1601818034827 ns
[    0.015335] ACPI: bus type PCI registered
[    0.019173] PCI: PCI BIOS revision 2.10 entry at 0xf0720, last bus=1
[    0.019176] PCI: Using configuration type 1 for base access
[    0.022424] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[    0.022764] ACPI: Added _OSI(Module Device)
[    0.022767] ACPI: Added _OSI(Processor Device)
[    0.022769] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.022772] ACPI: Added _OSI(Processor Aggregator Device)
[    0.024714] ACPI: Interpreter enabled
[    0.024768] ACPI: (supports S0 S1 S4 S5)
[    0.024771] ACPI: Using PIC for interrupt routing
[    0.024815] PCI: Ignoring host bridge windows from ACPI; if necessary, use "pci=use_crs" and report a bug
[    0.031717] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[    0.031893] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
[    0.032101] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
[    0.032266] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
[    0.032421] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.032433] acpi PNP0A03:00: _OSC: OS supports [Segments MSI]
[    0.032444] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.032452] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.032560] acpi PNP0A03:00: host bridge window [io  0x0cf8-0x0cff] (ignored)
[    0.032564] acpi PNP0A03:00: host bridge window [io  0x0000-0x0cf7 window] (ignored)
[    0.032568] acpi PNP0A03:00: host bridge window [io  0x0d00-0xffff window] (ignored)
[    0.032571] acpi PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff window] (ignored)
[    0.032575] acpi PNP0A03:00: host bridge window [mem 0x000c8000-0x000dffff window] (ignored)
[    0.032579] acpi PNP0A03:00: host bridge window [mem 0x20000000-0xfffdffff window] (ignored)
[    0.032581] PCI: root bus 00: using default resources
[    0.032687] PCI host bridge to bus 0000:00
[    0.032693] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.032697] pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffff]
[    0.032702] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.032722] pci 0000:00:00.0: [8086:7190] type 00 class 0x060000
[    0.032736] pci 0000:00:00.0: reg 0x10: [mem 0xe4000000-0xe7ffffff pref]
[    0.032898] pci 0000:00:01.0: [8086:7191] type 01 class 0x060400
[    0.033028] pci 0000:00:04.0: [8086:7110] type 00 class 0x060100
[    0.033203] pci 0000:00:04.1: [8086:7111] type 00 class 0x010180
[    0.033244] pci 0000:00:04.1: reg 0x20: [io  0xb800-0xb80f]
[    0.033264] pci 0000:00:04.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.033268] pci 0000:00:04.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.033271] pci 0000:00:04.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.033275] pci 0000:00:04.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.033390] pci 0000:00:04.2: [8086:7112] type 00 class 0x0c0300
[    0.033431] pci 0000:00:04.2: reg 0x20: [io  0xb400-0xb41f]
[    0.033507] pci 0000:00:04.2: System wakeup disabled by ACPI
[    0.033597] pci 0000:00:04.3: [8086:7113] type 00 class 0x068000
[    0.033602] * Found PM-Timer Bug on the chipset. Due to workarounds for a bug,
* this clock source is slow. Consider trying other clock sources
[    0.033668] pci 0000:00:04.3: quirk: [io  0xe400-0xe43f] claimed by PIIX4 ACPI
[    0.033674] pci 0000:00:04.3: quirk: [io  0xe800-0xe80f] claimed by PIIX4 SMB
[    0.033680] pci 0000:00:04.3: PIIX4 devres B PIO at 0290-0297
[    0.033818] pci 0000:00:09.0: [10b7:9001] type 00 class 0x020000
[    0.033831] pci 0000:00:09.0: reg 0x10: [io  0xb000-0xb03f]
[    0.033870] pci 0000:00:09.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    0.033977] pci 0000:00:0a.0: [10cd:1300] type 00 class 0x010000
[    0.033990] pci 0000:00:0a.0: reg 0x10: [io  0xa800-0xa8ff]
[    0.034000] pci 0000:00:0a.0: reg 0x14: [mem 0xd6000000-0xd60000ff]
[    0.034032] pci 0000:00:0a.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    0.034150] pci 0000:00:0b.0: [109e:0350] type 00 class 0x040000
[    0.034164] pci 0000:00:0b.0: reg 0x10: [mem 0xd7000000-0xd7000fff pref]
[    0.034377] pci 0000:01:00.0: [1002:514d] type 00 class 0x030000
[    0.034393] pci 0000:01:00.0: reg 0x10: [mem 0xd8000000-0xdfffffff pref]
[    0.034402] pci 0000:01:00.0: reg 0x14: [io  0xd800-0xd8ff]
[    0.034411] pci 0000:01:00.0: reg 0x18: [mem 0xd6800000-0xd680ffff]
[    0.034433] pci 0000:01:00.0: reg 0x30: [mem 0xd7fe0000-0xd7ffffff pref]
[    0.034464] pci 0000:01:00.0: supports D1 D2
[    0.034561] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.034567] pci 0000:00:01.0:   bridge window [io  0xd000-0xdfff]
[    0.034572] pci 0000:00:01.0:   bridge window [mem 0xd6800000-0xd6ffffff]
[    0.034577] pci 0000:00:01.0:   bridge window [mem 0xd7f00000-0xe3ffffff pref]
[    0.034586] pci_bus 0000:00: on NUMA node 0
[    0.037603] vgaarb: setting as boot device: PCI:0000:01:00.0
[    0.037608] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.037610] vgaarb: loaded
[    0.037612] vgaarb: bridge control possible 0000:01:00.0
[    0.037782] SCSI subsystem initialized
[    0.037897] libata version 3.00 loaded.
[    0.037908] ACPI: bus type USB registered
[    0.037966] usbcore: registered new interface driver usbfs
[    0.037993] usbcore: registered new interface driver hub
[    0.038030] usbcore: registered new device driver usb
[    0.038095] PCI: Using ACPI for IRQ routing
[    0.038102] PCI: pci_cache_line_size set to 32 bytes
[    0.038138] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.038142] e820: reserve RAM buffer [mem 0x1fffd000-0x1fffffff]
[    0.038877] clocksource: Switched to clocksource pit
[    0.052200] pnp: PnP ACPI init
[    0.052564] system 00:00: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.052572] system 00:00: [mem 0x000f0000-0x000fffff] could not be reserved
[    0.052577] system 00:00: [mem 0x00100000-0x1fffffff] could not be reserved
[    0.052583] system 00:00: [mem 0xfffe0000-0xffffffff] could not be reserved
[    0.052593] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.053257] system 00:01: [io  0xe400-0xe43f] has been reserved
[    0.053263] system 00:01: [io  0xe800-0xe80f] has been reserved
[    0.053268] system 00:01: [io  0x0294-0x0297] has been reserved
[    0.053273] system 00:01: [io  0x03f0-0x03f1] has been reserved
[    0.053277] system 00:01: [io  0x04d0-0x04d1] has been reserved
[    0.053286] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.053328] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[8]=0x110000 active = 1
[    0.053384] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.053834] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[6]=0x11005c active = 1
[    0.053839] pnp 00:03: [dma 2]
[    0.053861] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[6]=0x11105c active = 0
[    0.053917] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.054764] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[7]=0x11005c active = 1
[    0.054768] pnp 00:04: [dma 3]
[    0.054795] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[5]=0x1105c active = 0
[    0.054798] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[7]=0x11105c active = 0
[    0.054812] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[5]=0x1205c active = 0
[    0.054815] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[7]=0x11205c active = 0
[    0.054829] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[5]=0x1305c active = 0
[    0.054832] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[7]=0x11305c active = 0
[    0.054885] pnp 00:04: Plug and Play ACPI device, IDs PNP0401 (active)
[    0.055381] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[4]=0x11005c active = 1
[    0.055405] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[4]=0x11105c active = 0
[    0.055414] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[3]=0x1105c active = 0
[    0.055423] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[4]=0x11205c active = 0
[    0.055431] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[3]=0x1205c active = 0
[    0.055440] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[3]=0x1305c active = 0
[    0.055443] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[4]=0x11305c active = 0
[    0.055445] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[5]=0x1405c active = 0
[    0.055448] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[7]=0x11405c active = 0
[    0.055451] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[10]=0x105c active = 0
[    0.055454] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[12]=0x10105c active = 0
[    0.055529] pnp 00:05: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.056204] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[1]=0x1100000 active = 1
[    0.056251] pnp 00:06: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.056660] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[12]=0x20105c active = 1
[    0.056673] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[3]=0x1405c active = 0
[    0.056676] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[4]=0x11405c active = 0
[    0.056679] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[5]=0x1505c active = 0
[    0.056681] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[7]=0x11505c active = 0
[    0.056684] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[10]=0x205c active = 0
[    0.056687] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[12]=0x20205c active = 0
[    0.056753] pnp 00:07: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.056771] pnp: PnP ACPI: found 8 devices
[    0.056778] PnPBIOS: Disabled
[    0.095595] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.095636] clocksource: Switched to clocksource acpi_pm
[    0.095679] pci 0000:00:09.0: BAR 6: assigned [mem 0x20000000-0x2000ffff pref]
[    0.095687] pci 0000:00:0a.0: BAR 6: assigned [mem 0x20010000-0x2001ffff pref]
[    0.095695] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.095699] pci 0000:00:01.0:   bridge window [io  0xd000-0xdfff]
[    0.095706] pci 0000:00:01.0:   bridge window [mem 0xd6800000-0xd6ffffff]
[    0.095711] pci 0000:00:01.0:   bridge window [mem 0xd7f00000-0xe3ffffff pref]
[    0.095720] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
[    0.095724] pci_bus 0000:00: resource 5 [mem 0x00000000-0xffffffff]
[    0.095728] pci_bus 0000:01: resource 0 [io  0xd000-0xdfff]
[    0.095732] pci_bus 0000:01: resource 1 [mem 0xd6800000-0xd6ffffff]
[    0.095736] pci_bus 0000:01: resource 2 [mem 0xd7f00000-0xe3ffffff pref]
[    0.095816] NET: Registered protocol family 2
[    0.096204] TCP established hash table entries: 4096 (order: 2, 16384 bytes)
[    0.096251] TCP bind hash table entries: 4096 (order: 3, 32768 bytes)
[    0.096335] TCP: Hash tables configured (established 4096 bind 4096)
[    0.096413] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    0.096439] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    0.096591] NET: Registered protocol family 1
[    0.096627] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    0.096799] acpi_irq_get_penalty:512 adding SCI penalty: 16777216
[    0.096803] penalty[15] = 0x10005c
[    0.096804] penalty[14] = 0x10005c
[    0.096806] penalty[12] = 0x20205c
[    0.096807] penalty[11] = 0x5c
[    0.096809] penalty[10] = 0x205c
[    0.096811] acpi_irq_get_penalty:512 adding SCI penalty: 16777216
[    0.096813] penalty[9] = 0x100005c
[    0.096814] penalty[7] = 0x11505c
[    0.096816] penalty[6] = 0x11105c
[    0.096818] penalty[5] = 0x1505c
[    0.096819] penalty[4] = 0x11405c
[    0.096821] penalty[3] = 0x1405c
[    0.096823] ACPI: No IRQ available for PCI Interrupt Link [LNKD]. Try pci=noacpi or acpi=off
[    0.096870] acpi_irq_get_penalty:512 adding SCI penalty: 16777216
[    0.096875] pci 0000:00:04.2: PCI INT D: no GSI
[    0.096922] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.096926] PCI: CLS 32 bytes, default 32
[    0.098121] futex hash table entries: 256 (order: 1, 8192 bytes)
[    0.098940] workingset: timestamp_bits=30 max_order=17 bucket_order=0
[    0.105896] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.105904] io scheduler noop registered
[    0.105906] io scheduler deadline registered
[    0.105988] io scheduler cfq registered (default)
[    0.106528] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.106538] ACPI: Power Button [PWRB]
[    0.106683] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.106687] ACPI: Power Button [PWRF]
[    0.106786] tsc: Marking TSC unstable due to TSC halts in idle
[    0.106876] Warning: Processor Platform Limit event detected, but not handled.
[    0.106878] Consider compiling CPUfreq support into your kernel.
[    0.107321] isapnp: Scanning for PnP cards...
[    0.197568] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[5]=0x1605c active = 0
[    0.201162] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[5]=0x1705c active = 0
[    0.201165] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[7]=0x11605c active = 0
[    0.201168] acpi_irq_get_penalty:512 adding SCI penalty: 16777216
[    0.201171] acpi_irq_get_penalty:512 adding SCI penalty: 16777216
[    0.201173] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[9]=0x200105c active = 0
[    0.201176] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[10]=0x305c active = 0
[    0.204775] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[5]=0x1805c active = 0
[    0.204778] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[7]=0x11705c active = 0
[    0.204780] acpi_irq_get_penalty:512 adding SCI penalty: 16777216
[    0.204782] acpi_irq_get_penalty:512 adding SCI penalty: 16777216
[    0.204785] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[9]=0x300205c active = 0
[    0.204788] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[10]=0x405c active = 0
[    0.207619] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[5]=0x1905c active = 0
[    0.207622] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[7]=0x11805c active = 0
[    0.207624] acpi_irq_get_penalty:512 adding SCI penalty: 16777216
[    0.207626] acpi_irq_get_penalty:512 adding SCI penalty: 16777216
[    0.207628] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[9]=0x400305c active = 0
[    0.207631] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[10]=0x505c active = 0
[    0.209617] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[5]=0x1a05c active = 0
[    0.209620] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[7]=0x11905c active = 0
[    0.209622] acpi_irq_get_penalty:512 adding SCI penalty: 16777216
[    0.209625] acpi_irq_get_penalty:512 adding SCI penalty: 16777216
[    0.209627] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[9]=0x500405c active = 0
[    0.209630] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[10]=0x605c active = 0
[    0.212952] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[5]=0x1b05c active = 0
[    0.212955] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[7]=0x11a05c active = 0
[    0.212958] acpi_irq_get_penalty:512 adding SCI penalty: 16777216
[    0.212960] acpi_irq_get_penalty:512 adding SCI penalty: 16777216
[    0.212962] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[9]=0x600505c active = 0
[    0.212965] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[10]=0x705c active = 0
[    0.215411] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[5]=0x1c05c active = 0
[    0.215413] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[7]=0x11b05c active = 0
[    0.215416] acpi_irq_get_penalty:512 adding SCI penalty: 16777216
[    0.215418] acpi_irq_get_penalty:512 adding SCI penalty: 16777216
[    0.215420] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[9]=0x700605c active = 0
[    0.215423] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[10]=0x805c active = 0
[    0.217018] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[5]=0x1d05c active = 0
[    0.217021] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[7]=0x11c05c active = 0
[    0.217023] acpi_irq_get_penalty:512 adding SCI penalty: 16777216
[    0.217025] acpi_irq_get_penalty:512 adding SCI penalty: 16777216
[    0.217028] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[9]=0x800705c active = 0
[    0.217030] acpi_penalize_isa_irq:885 acpi_isa_irq_penalty[10]=0x905c active = 0
[    0.229518] pnp 01:01.00: increased option port range from 0x388-0x388 to 0x388-0x3f8
[    0.229523] pnp 01:01.00: increased option port range from 0x388-0x388 to 0x388-0x3f8
[    0.229528] pnp 01:01.00: increased option port range from 0x388-0x388 to 0x388-0x3f8
[    0.229622] pnp 01:01.02: added ioport region 0xe20-0xe20 to set 0
[    0.229627] pnp 01:01.02: added ioport region 0xa20-0xa20 to set 0
[    0.229630] pnp 01:01.02: added ioport region 0xe20-0xe80 to set 1
[    0.229634] pnp 01:01.02: added ioport region 0xa20-0xa80 to set 1
[    0.229694]  01:01: card 'Creative SB AWE64  PnP'
[    0.229696] isapnp: 1 Plug & Play card detected total
[    0.229823] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.250380] 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.271047] serial8250: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    0.291547] serial8250: ttyS2 at I/O 0x3e8 (irq = 4, base_baud = 115200) is a 16550A
[    0.312043] serial8250: ttyS3 at I/O 0x2e8 (irq = 3, base_baud = 115200) is a 16550A
[    0.312450] Non-volatile memory driver v1.3
[    0.312454] Linux agpgart interface v0.103
[    0.312510] [drm] Initialized drm 1.1.0 20060810
[    0.317848] loop: module loaded
[    0.317981] ata_piix 0000:00:04.1: version 2.13
[    0.318965] scsi host0: ata_piix
[    0.319243] scsi host1: ata_piix
[    0.319368] ata1: PATA max UDMA/33 cmd 0x1f0 ctl 0x3f6 bmdma 0xb800 irq 14
[    0.319373] ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xb808 irq 15
[    0.319627] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.319630] ehci-pci: EHCI PCI platform driver
[    0.319656] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.319676] ohci-pci: OHCI PCI platform driver
[    0.319700] uhci_hcd: USB Universal Host Controller Interface driver
[    0.319869] acpi_irq_get_penalty:512 adding SCI penalty: 16777216
[    0.319873] penalty[15] = 0x10005c
[    0.319874] penalty[14] = 0x10005c
[    0.319876] penalty[12] = 0x20205c
[    0.319877] penalty[11] = 0x5c
[    0.319879] penalty[10] = 0x905c
[    0.319881] acpi_irq_get_penalty:512 adding SCI penalty: 16777216
[    0.319883] penalty[9] = 0x800705c
[    0.319884] penalty[7] = 0x11c05c
[    0.319886] penalty[6] = 0x11105c
[    0.319888] penalty[5] = 0x1d05c
[    0.319889] penalty[4] = 0x11405c
[    0.319891] penalty[3] = 0x1405c
[    0.319893] ACPI: No IRQ available for PCI Interrupt Link [LNKD]. Try pci=noacpi or acpi=off
[    0.319940] acpi_irq_get_penalty:512 adding SCI penalty: 16777216
[    0.319945] uhci_hcd 0000:00:04.2: PCI INT D: no GSI
[    0.319971] uhci_hcd 0000:00:04.2: UHCI Host Controller
[    0.319987] uhci_hcd 0000:00:04.2: new USB bus registered, assigned bus number 1
[    0.320096] uhci_hcd 0000:00:04.2: irq 9, io base 0x0000b400
[    0.320833] hub 1-0:1.0: USB hub found
[    0.320852] hub 1-0:1.0: 2 ports detected
[    0.321233] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    0.324648] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.324663] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.325008] mousedev: PS/2 mouse device common for all mice
[    0.325436] rtc_cmos 00:02: RTC can wake from S4
[    0.325629] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
[    0.325656] rtc_cmos 00:02: alarms up to one month, 242 bytes nvram
[    0.326049] NET: Registered protocol family 17
[    0.326209] Using IPI No-Shortcut mode
[    0.326514] registered taskstats version 1
[    0.326921] rtc_cmos 00:02: setting system clock to 2016-09-28 18:42:34 UTC (1475088154)
[    0.326997] PM: Hibernation image not present or could not be loaded.
[    0.355482] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input2
[    0.483499] ata2.00: ATAPI: TOSHIBA DVD-ROM SD-M1212, 1R22, max UDMA/33
[    0.483512] ata2.01: ATAPI: ATAPI   COMBO48XMAX, VER 1.50, max UDMA/100
[    0.483622] ata1.00: ATA-7: SAMSUNG SP1213N, TL100-24, max UDMA/100
[    0.483626] ata1.00: 234493056 sectors, multi 16: LBA48 
[    0.486508] ata2.00: configured for UDMA/33
[    0.486816] ata1.00: configured for UDMA/33
[    0.487064] ata2.01: configured for UDMA/33
[    0.487361] scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG SP1213N  0-24 PQ: 0 ANSI: 5
[    0.488205] sd 0:0:0:0: [sda] 234493056 512-byte logical blocks: (120 GB/112 GiB)
[    0.488358] sd 0:0:0:0: [sda] Write Protect is off
[    0.488363] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.488426] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    0.492298] scsi 1:0:0:0: CD-ROM            TOSHIBA  DVD-ROM SD-M1212 1R22 PQ: 0 ANSI: 5
[    0.506153] scsi 1:0:1:0: CD-ROM            ATAPI    COMBO48XMAX      1.50 PQ: 0 ANSI: 5
[    0.525076]  sda: sda1 sda2 sda3
[    0.525905] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.046926] random: fast init done
[    1.120050] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x13ad41f0395, max_idle_ns: 440795258035 ns
[    1.935924] input: ImPS/2 BYD TouchPad as /devices/platform/i8042/serio1/input/input4
[    1.945228] EXT4-fs (sda3): mounting ext3 file system using the ext4 subsystem
[    1.965685] EXT4-fs (sda3): mounted filesystem with ordered data mode. Opts: (null)
[    1.965719] VFS: Mounted root (ext3 filesystem) readonly on device 8:3.
[    1.967438] Freeing unused kernel memory: 524K (c15c1000 - c1644000)
[    1.967664] Write protecting the kernel text: 3920k
[    1.967730] Write protecting the kernel read-only data: 1528k
[    4.322714] systemd-udevd[194]: starting version 215
[    5.925473] random: crng init done
[    7.622407] Adding 1048572k swap on /dev/sda2.  Priority:-1 extents:1 across:1048572k 
[    7.688916] EXT4-fs (sda3): re-mounted. Opts: (null)
[    8.149054] EXT4-fs (sda3): re-mounted. Opts: errors=remount-ro

--Boundary-00=_ne/6XyV8J/SRmzo
Content-Type: text/plain;
  charset="iso-8859-15";
  name="dmesg-4.6.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg-4.6.txt"

[    0.000000] Linux version 4.6.0-0.bpo.1-686 (debian-kernel@lists.debian.org) (gcc version 4.9.2 (Debian 4.9.2-10) ) #1 SMP Debian 4.6.4-1~bpo8+1 (2016-08-11)
[    0.000000] x86/fpu: Legacy x87 FPU detected.
[    0.000000] x86/fpu: Using 'eager' FPU context switches.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001fffcfff] usable
[    0.000000] BIOS-e820: [mem 0x000000001fffd000-0x000000001fffefff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000001ffff000-0x000000001fffffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000ffff0000-0x00000000ffffffff] reserved
[    0.000000] Notice: NX (Execute Disable) protection missing in CPU!
[    0.000000] Legacy DMI 2.0 present.
[    0.000000] DMI: System Manufacturer System Name/P2B, BIOS ASUS P2B ACPI BIOS Revision 1014 Beta 003                        08/01/02
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x1fffd max_arch_pfn = 0x100000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-AFFFF uncachable
[    0.000000]   B0000-BFFFF write-combining
[    0.000000]   C0000-C7FFF write-protect
[    0.000000]   C8000-F7FFF uncachable
[    0.000000]   F8000-FCFFF write-protect
[    0.000000]   FD000-FFFFF uncachable
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask FE0000000 write-back
[    0.000000]   1 disabled
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 base 0D8000000 mask FF8000000 write-combining
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86/PAT: PAT not supported by CPU.
[    0.000000] initial memory mapped: [mem 0x00000000-0x01bfffff]
[    0.000000] Base memory trampoline at [c009b000] 9b000 size 16384
[    0.000000] BRK [0x018bc000, 0x018bcfff] PGTABLE
[    0.000000] RAMDISK: [mem 0x1eb88000-0x1fb1efff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F7F90 000014 (v00 ASUS  )
[    0.000000] ACPI: RSDT 0x000000001FFFD000 00002C (v01 ASUS   P2B      42302E31 MSFT 31313031)
[    0.000000] ACPI: FACP 0x000000001FFFD080 000074 (v01 ASUS   P2B      42302E31 MSFT 31313031)
[    0.000000] ACPI: DSDT 0x000000001FFFD100 001BA8 (v01 ASUS   P2B      00001000 MSFT 01000001)
[    0.000000] ACPI: FACS 0x000000001FFFF000 000040
[    0.000000] ACPI: BOOT 0x000000001FFFD040 000028 (v01 ASUS   P2B      42302E31 MSFT 31313031)
[    0.000000] 0MB HIGHMEM available.
[    0.000000] 511MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 1fffd000
[    0.000000]   low ram: 0 - 1fffd000
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   Normal   [mem 0x0000000001000000-0x000000001fffcfff]
[    0.000000]   HighMem  empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000001fffcfff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000001fffcfff]
[    0.000000] On node 0 totalpages: 130971
[    0.000000] free_area_init_node: node 0, pgdat c1775600, node_mem_map dfb7d024
[    0.000000]   DMA zone: 36 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
[    0.000000]   Normal zone: 1116 pages used for memmap
[    0.000000]   Normal zone: 126973 pages, LIFO batch:31
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
[    0.000000] e820: [mem 0x20000000-0xfffeffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:32 nr_cpumask_bits:32 nr_cpu_ids:1 nr_node_ids:1
[    0.000000] percpu: Embedded 18 pages/cpu @dfb67000 s41676 r0 d32052 u73728
[    0.000000] pcpu-alloc: s41676 r0 d32052 u73728 alloc=18*4096
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 129819
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.6.0-0.bpo.1-686 root=UUID=f9e42749-d46b-465f-911a-46fa2db271ad ro quiet drm_kms_helper.edid_firmware=VGA-1:edid-iiyama.bin video=VGA-1:1024x768
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Initializing CPU#0
[    0.000000] Initializing HighMem for node 0 (00000000:00000000)
[    0.000000] Memory: 493792K/523884K available (5424K kernel code, 664K rwdata, 1632K rodata, 688K init, 468K bss, 30092K reserved, 0K cma-reserved, 0K highmem)
[    0.000000] virtual kernel memory layout:
    fixmap  : 0xffd36000 - 0xfffff000   (2852 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xe07fd000 - 0xff7fe000   ( 496 MB)
    lowmem  : 0xc0000000 - 0xdfffd000   ( 511 MB)
      .init : 0xc178d000 - 0xc1839000   ( 688 kB)
      .data : 0xc154c632 - 0xc178c000   (2302 kB)
      .text : 0xc1000000 - 0xc154c632   (5425 kB)
[    0.000000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 32.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=32 to nr_cpu_ids=1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=1
[    0.000000] NR_IRQS:2304 nr_irqs:32 16
[    0.000000] CPU 0 irqstacks, hard=de42c000 soft=de42e000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 1364.997 MHz processor
[    0.004021] Calibrating delay loop (skipped), value calculated using timer frequency.. 2729.99 BogoMIPS (lpj=5459988)
[    0.004031] pid_max: default: 32768 minimum: 301
[    0.004082] ACPI: Core revision 20160108
[    0.009394] ACPI: 1 ACPI AML tables successfully acquired and loaded

[    0.009411] ACPI: setting ELCR to 0200 (from 0e00)
[    0.009475] Security Framework initialized
[    0.009482] Yama: disabled by default; enable with sysctl kernel.yama.*
[    0.009505] AppArmor: AppArmor disabled by boot time parameter
[    0.009534] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.009540] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.010311] Disabling memory control group subsystem
[    0.010425] mce: CPU supports 5 MCE banks
[    0.010464] Last level iTLB entries: 4KB 32, 2MB 0, 4MB 2
[    0.010470] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 8, 1GB 0
[    0.017077] Freeing SMP alternatives memory: 24K (c1839000 - c183f000)
[    0.019801] ftrace: allocating 23042 entries in 46 pages
[    0.032388] smpboot: Max logical packages: 1
[    0.032406] smpboot: weird, boot CPU (#0) not listed by the BIOS
[    0.032409] smpboot: SMP motherboard not detected
[    0.032412] smpboot: SMP disabled
[    0.032416] smpboot: Local APIC not detected. Using dummy APIC emulation.
[    0.032447] Performance Events: 
[    0.032456] no APIC, boot with the "lapic" boot parameter to force-enable it.
[    0.032460] no hardware sampling interrupt available.
[    0.032465] p6 PMU driver.
[    0.032472] ... version:                0
[    0.032475] ... bit width:              32
[    0.032478] ... generic registers:      2
[    0.032481] ... value mask:             00000000ffffffff
[    0.032485] ... max period:             000000007fffffff
[    0.032488] ... fixed-purpose events:   0
[    0.032491] ... event mask:             0000000000000003
[    0.037491] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.037559] x86: Booted up 1 node, 1 CPUs
[    0.037565] smpboot: Total of 1 processors activated (2729.99 BogoMIPS)
[    0.037913] devtmpfs: initialized
[    0.038555] PM: Registering ACPI NVS region [mem 0x1ffff000-0x1fffffff] (4096 bytes)
[    0.038754] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.038867] pinctrl core: initialized pinctrl subsystem
[    0.039294] NET: Registered protocol family 16
[    0.039683] cpuidle: using governor ladder
[    0.039692] cpuidle: using governor menu
[    0.039800] Simple Boot Flag at 0x46 set to 0x1
[    0.039824] clocksource: pit: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1601818034827 ns
[    0.039935] ACPI: bus type PCI registered
[    0.039943] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.043822] PCI: PCI BIOS revision 2.10 entry at 0xf0720, last bus=1
[    0.043827] PCI: Using configuration type 1 for base access
[    0.046101] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[    0.046803] ACPI: Added _OSI(Module Device)
[    0.046812] ACPI: Added _OSI(Processor Device)
[    0.046816] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.046820] ACPI: Added _OSI(Processor Aggregator Device)
[    0.048956] ACPI: Interpreter enabled
[    0.049019] ACPI: (supports S0 S1 S4 S5)
[    0.049024] ACPI: Using PIC for interrupt routing
[    0.049072] PCI: Ignoring host bridge windows from ACPI; if necessary, use "pci=use_crs" and report a bug
[    0.056938] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[    0.057135] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
[    0.057321] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
[    0.057506] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
[    0.057681] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.057697] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI]
[    0.057711] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.057722] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.057847] acpi PNP0A03:00: host bridge window [io  0x0cf8-0x0cff] (ignored)
[    0.057853] acpi PNP0A03:00: host bridge window [io  0x0000-0x0cf7 window] (ignored)
[    0.057859] acpi PNP0A03:00: host bridge window [io  0x0d00-0xffff window] (ignored)
[    0.057865] acpi PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff window] (ignored)
[    0.057870] acpi PNP0A03:00: host bridge window [mem 0x000c8000-0x000dffff window] (ignored)
[    0.057875] acpi PNP0A03:00: host bridge window [mem 0x20000000-0xfffdffff window] (ignored)
[    0.057879] PCI: root bus 00: using default resources
[    0.058084] PCI host bridge to bus 0000:00
[    0.058092] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.058098] pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffff]
[    0.058105] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.058125] pci 0000:00:00.0: [8086:7190] type 00 class 0x060000
[    0.058143] pci 0000:00:00.0: reg 0x10: [mem 0xe4000000-0xe7ffffff pref]
[    0.058328] pci 0000:00:01.0: [8086:7191] type 01 class 0x060400
[    0.058468] pci 0000:00:04.0: [8086:7110] type 00 class 0x060100
[    0.058658] pci 0000:00:04.1: [8086:7111] type 00 class 0x010180
[    0.058702] pci 0000:00:04.1: reg 0x20: [io  0xb800-0xb80f]
[    0.058725] pci 0000:00:04.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.058731] pci 0000:00:04.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.058736] pci 0000:00:04.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.058741] pci 0000:00:04.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.058864] pci 0000:00:04.2: [8086:7112] type 00 class 0x0c0300
[    0.058908] pci 0000:00:04.2: reg 0x20: [io  0xb400-0xb41f]
[    0.058988] pci 0000:00:04.2: System wakeup disabled by ACPI
[    0.059093] pci 0000:00:04.3: [8086:7113] type 00 class 0x068000
[    0.059100] * Found PM-Timer Bug on the chipset. Due to workarounds for a bug,
* this clock source is slow. Consider trying other clock sources
[    0.059173] pci 0000:00:04.3: can't claim BAR 13 [io  0xe400-0xe43f]: address conflict with ACPI CPU throttle [io  0xe410-0xe415]
[    0.059181] pci 0000:00:04.3: quirk: [io  0xe800-0xe80f] claimed by PIIX4 SMB
[    0.059189] pci 0000:00:04.3: PIIX4 devres B PIO at 0290-0297
[    0.059330] pci 0000:00:09.0: [10b7:9001] type 00 class 0x020000
[    0.059346] pci 0000:00:09.0: reg 0x10: [io  0xb000-0xb03f]
[    0.059387] pci 0000:00:09.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    0.059512] pci 0000:00:0a.0: [10cd:1300] type 00 class 0x010000
[    0.059528] pci 0000:00:0a.0: reg 0x10: [io  0xa800-0xa8ff]
[    0.059540] pci 0000:00:0a.0: reg 0x14: [mem 0xd6000000-0xd60000ff]
[    0.059574] pci 0000:00:0a.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    0.059697] pci 0000:00:0b.0: [109e:0350] type 00 class 0x040000
[    0.059713] pci 0000:00:0b.0: reg 0x10: [mem 0xd7000000-0xd7000fff pref]
[    0.059950] pci 0000:01:00.0: [1002:514d] type 00 class 0x030000
[    0.059968] pci 0000:01:00.0: reg 0x10: [mem 0xd8000000-0xdfffffff pref]
[    0.059979] pci 0000:01:00.0: reg 0x14: [io  0xd800-0xd8ff]
[    0.060028] pci 0000:01:00.0: reg 0x18: [mem 0xd6800000-0xd680ffff]
[    0.060055] pci 0000:01:00.0: reg 0x30: [mem 0xd7fe0000-0xd7ffffff pref]
[    0.060090] pci 0000:01:00.0: supports D1 D2
[    0.060205] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.060213] pci 0000:00:01.0:   bridge window [io  0xd000-0xdfff]
[    0.060219] pci 0000:00:01.0:   bridge window [mem 0xd6800000-0xd6ffffff]
[    0.060226] pci 0000:00:01.0:   bridge window [mem 0xd7f00000-0xe3ffffff pref]
[    0.060236] pci_bus 0000:00: on NUMA node 0
[    0.063561] vgaarb: setting as boot device: PCI:0000:01:00.0
[    0.063570] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.063573] vgaarb: loaded
[    0.063577] vgaarb: bridge control possible 0000:01:00.0
[    0.063874] PCI: Using ACPI for IRQ routing
[    0.063883] PCI: pci_cache_line_size set to 32 bytes
[    0.063925] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.063931] e820: reserve RAM buffer [mem 0x1fffd000-0x1fffffff]
[    0.064609] clocksource: Switched to clocksource pit
[    0.089424] VFS: Disk quotas dquot_6.6.0
[    0.089496] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.089898] pnp: PnP ACPI init
[    0.090294] system 00:00: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.090304] system 00:00: [mem 0x000f0000-0x000fffff] could not be reserved
[    0.090310] system 00:00: [mem 0x00100000-0x1fffffff] could not be reserved
[    0.090317] system 00:00: [mem 0xfffe0000-0xffffffff] could not be reserved
[    0.090330] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.090945] system 00:01: [io  0xe400-0xe43f] could not be reserved
[    0.090953] system 00:01: [io  0xe800-0xe80f] has been reserved
[    0.090959] system 00:01: [io  0x0294-0x0297] has been reserved
[    0.090965] system 00:01: [io  0x03f0-0x03f1] has been reserved
[    0.090971] system 00:01: [io  0x04d0-0x04d1] has been reserved
[    0.090979] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.091077] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.091649] pnp 00:03: [dma 2]
[    0.091740] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.092667] pnp 00:04: [dma 3]
[    0.092777] pnp 00:04: Plug and Play ACPI device, IDs PNP0401 (active)
[    0.093465] pnp 00:05: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.094271] pnp 00:06: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.094811] pnp 00:07: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.094832] pnp: PnP ACPI: found 8 devices
[    0.094855] PnPBIOS: Disabled by ACPI PNP
[    0.134355] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.134407] clocksource: Switched to clocksource acpi_pm
[    0.134450] pci 0000:00:04.3: BAR 13: [io  size 0x0040] has bogus alignment
[    0.134471] pci 0000:00:09.0: BAR 6: assigned [mem 0x20000000-0x2000ffff pref]
[    0.134479] pci 0000:00:0a.0: BAR 6: assigned [mem 0x20010000-0x2001ffff pref]
[    0.134488] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.134495] pci 0000:00:01.0:   bridge window [io  0xd000-0xdfff]
[    0.134504] pci 0000:00:01.0:   bridge window [mem 0xd6800000-0xd6ffffff]
[    0.134510] pci 0000:00:01.0:   bridge window [mem 0xd7f00000-0xe3ffffff pref]
[    0.134521] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
[    0.134527] pci_bus 0000:00: resource 5 [mem 0x00000000-0xffffffff]
[    0.134532] pci_bus 0000:01: resource 0 [io  0xd000-0xdfff]
[    0.134537] pci_bus 0000:01: resource 1 [mem 0xd6800000-0xd6ffffff]
[    0.134543] pci_bus 0000:01: resource 2 [mem 0xd7f00000-0xe3ffffff pref]
[    0.134647] NET: Registered protocol family 2
[    0.135127] TCP established hash table entries: 4096 (order: 2, 16384 bytes)
[    0.135176] TCP bind hash table entries: 4096 (order: 3, 32768 bytes)
[    0.135259] TCP: Hash tables configured (established 4096 bind 4096)
[    0.135335] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    0.135361] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    0.135642] NET: Registered protocol family 1
[    0.135696] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    0.136474] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
[    0.136482] PCI: setting IRQ 9 as level-triggered
[    0.136637] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.136643] PCI: CLS 32 bytes, default 32
[    0.136834] Unpacking initramfs...
[    1.039778] Freeing initrd memory: 15964K (deb88000 - dfb1f000)
[    1.041185] futex hash table entries: 256 (order: 2, 16384 bytes)
[    1.041271] audit: initializing netlink subsys (disabled)
[    1.041327] audit: type=2000 audit(1475088988.038:1): initialized
[    1.041958] Initialise system trusted keyring
[    1.042261] workingset: timestamp_bits=12 max_order=17 bucket_order=5
[    1.042320] zbud: loaded
[    1.453856] Key type asymmetric registered
[    1.453869] Asymmetric key parser 'x509' registered
[    1.453955] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    1.454069] io scheduler noop registered
[    1.454077] io scheduler deadline registered
[    1.454099] io scheduler cfq registered (default)
[    1.454352] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    1.454372] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    1.454418] intel_idle: does not run on family 6 model 11
[    1.454473] GHES: HEST is not enabled!
[    1.454531] isapnp: Scanning for PnP cards...
[    1.577454] pnp 01:01.00: increased option port range from 0x388-0x388 to 0x388-0x3f8
[    1.577461] pnp 01:01.00: increased option port range from 0x388-0x388 to 0x388-0x3f8
[    1.577467] pnp 01:01.00: increased option port range from 0x388-0x388 to 0x388-0x3f8
[    1.577570] pnp 01:01.02: added ioport region 0xe20-0xe20 to set 0
[    1.577576] pnp 01:01.02: added ioport region 0xa20-0xa20 to set 0
[    1.577582] pnp 01:01.02: added ioport region 0xe20-0xe80 to set 1
[    1.577587] pnp 01:01.02: added ioport region 0xa20-0xa80 to set 1
[    1.577655]  01:01: card 'Creative SB AWE64  PnP'
[    1.577660] isapnp: 1 Plug & Play card detected total
[    1.577814] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.598381] 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    1.619069] serial8250: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    1.639574] serial8250: ttyS2 at I/O 0x3e8 (irq = 4, base_baud = 115200) is a 16550A
[    1.660079] serial8250: ttyS3 at I/O 0x2e8 (irq = 3, base_baud = 115200) is a 16550A
[    1.660447] Linux agpgart interface v0.103
[    1.660643] agpgart-intel 0000:00:00.0: Intel 440BX Chipset
[    1.663978] agpgart-intel 0000:00:00.0: AGP aperture is 64M @ 0xe4000000
[    1.664424] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    1.667651] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.667669] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.668121] mousedev: PS/2 mouse device common for all mice
[    1.668261] rtc_cmos 00:02: RTC can wake from S4
[    1.668454] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
[    1.668483] rtc_cmos 00:02: alarms up to one month, 242 bytes nvram
[    1.668565] ledtrig-cpu: registered to indicate activity on CPUs
[    1.669487] NET: Registered protocol family 10
[    1.670100] mip6: Mobile IPv6
[    1.670116] NET: Registered protocol family 17
[    1.670130] mpls_gso: MPLS GSO support
[    1.670586] microcode: CPU0 sig=0x6b1, pf=0x10, revision=0x1c
[    1.670679] microcode: Microcode Update Driver: v2.01 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    1.670708] Using IPI No-Shortcut mode
[    1.671074] registered taskstats version 1
[    1.671109] Loading compiled-in X.509 certificates
[    1.676507] alg: No test for pkcs1pad(rsa,sha256) (pkcs1pad(rsa-generic,sha256))
[    1.678863] Loaded X.509 cert 'Debian Project: Ben Hutchings: 008a018dca80932630'
[    1.678930] zswap: loaded using pool lzo/zbud
[    1.679512] rtc_cmos 00:02: setting system clock to 2016-09-28 18:56:28 UTC (1475088988)
[    1.679644] PM: Hibernation image not present or could not be loaded.
[    1.682207] Freeing unused kernel memory: 688K (c178d000 - c1839000)
[    1.682324] Write protecting the kernel text: 5428k
[    1.682389] Write protecting the kernel read-only data: 1636k
[    1.697898] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    1.720514] systemd-udevd[68]: starting version 215
[    1.721588] random: systemd-udevd urandom read with 6 bits of entropy available
[    1.786059] floppy: module verification failed: signature and/or required key missing - tainting kernel
[    1.807536] 3c59x: Donald Becker and others.
[    1.807569] 0000:00:09.0: 3Com PCI 3c900 Boomerang 10Mbps Combo at 0001b000.
[    1.835912] SCSI subsystem initialized
[    1.839927] ACPI: bus type USB registered
[    1.848968] usbcore: registered new interface driver usbfs
[    1.849038] usbcore: registered new interface driver hub
[    1.849106] usbcore: registered new device driver usb
[    1.850782] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.851947] uhci_hcd: USB Universal Host Controller Interface driver
[    1.868152] Floppy drive(s): fd0 is 1.44M, fd1 is 1.2M
[    1.884954] libata version 3.00 loaded.
[    1.888185] FDC 0 is a post-1991 82077
[    1.915191] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
[    5.191651] tsc: Refined TSC clocksource calibration: 1364.999 MHz
[    5.191666] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x13acf81e477, max_idle_ns: 440795209386 ns
[    5.237040] advansys 0000:00:0a.0: firmware: direct-loading firmware advansys/mcode.bin
[    5.239578] scsi host0: AdvanSys SCSI 3.5: PCI Ultra: IO 0xA800-0xA80F, IRQ 0x9
[    5.240493] uhci_hcd 0000:00:04.2: UHCI Host Controller
[    5.240522] uhci_hcd 0000:00:04.2: new USB bus registered, assigned bus number 1
[    5.240537] uhci_hcd 0000:00:04.2: detected 2 ports
[    5.240570] uhci_hcd 0000:00:04.2: irq 9, io base 0x0000b400
[    5.240841] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
[    5.240847] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.240852] usb usb1: Product: UHCI Host Controller
[    5.240857] usb usb1: Manufacturer: Linux 4.6.0-0.bpo.1-686 uhci_hcd
[    5.240862] usb usb1: SerialNumber: 0000:00:04.2
[    5.241476] hub 1-0:1.0: USB hub found
[    5.241605] hub 1-0:1.0: 2 ports detected
[    5.241930] ata_piix 0000:00:04.1: version 2.13
[    5.246895] scsi host1: ata_piix
[    5.247422] scsi host2: ata_piix
[    5.247592] ata1: PATA max UDMA/33 cmd 0x1f0 ctl 0x3f6 bmdma 0xb800 irq 14
[    5.247598] ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xb808 irq 15
[    5.292062] blk_update_request: I/O error, dev fd0, sector 0
[    5.292112] floppy: error -5 while reading block 0
[    5.336074] blk_update_request: I/O error, dev fd1, sector 0
[    5.336123] floppy: error -5 while reading block 0
[    5.407512] ata2.00: ATAPI: TOSHIBA DVD-ROM SD-M1212, 1R22, max UDMA/33
[    5.407530] ata2.01: ATAPI: ATAPI   COMBO48XMAX, VER 1.50, max UDMA/100
[    5.407642] ata1.00: ATA-7: SAMSUNG SP1213N, TL100-24, max UDMA/100
[    5.407648] ata1.00: 234493056 sectors, multi 16: LBA48 
[    5.410333] ata1.00: configured for UDMA/33
[    5.412383] ata2.00: configured for UDMA/33
[    5.417014] ata2.01: configured for UDMA/33
[    5.633723] psmouse serio1: hgpk: ID: 10 00 64
[    6.188125] clocksource: Switched to clocksource tsc
[    6.715330] scsi 1:0:0:0: Direct-Access     ATA      SAMSUNG SP1213N  0-24 PQ: 0 ANSI: 5
[    6.718103] scsi 2:0:0:0: CD-ROM            TOSHIBA  DVD-ROM SD-M1212 1R22 PQ: 0 ANSI: 5
[    6.726655] scsi 2:0:1:0: CD-ROM            ATAPI    COMBO48XMAX      1.50 PQ: 0 ANSI: 5
[    6.742284] sd 1:0:0:0: [sda] 234493056 512-byte logical blocks: (120 GB/112 GiB)
[    6.742490] sd 1:0:0:0: [sda] Write Protect is off
[    6.742497] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    6.742551] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    6.750462] input: ImPS/2 BYD TouchPad as /devices/platform/i8042/serio1/input/input2
[    6.763212] sr 2:0:0:0: [sr0] scsi3-mmc drive: 32x/32x cd/rw xa/form2 cdda tray
[    6.763226] cdrom: Uniform CD-ROM driver Revision: 3.20
[    6.763740] sr 2:0:0:0: Attached scsi CD-ROM sr0
[    6.772980] sr 2:0:1:0: [sr1] scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
[    6.773472] sr 2:0:1:0: Attached scsi CD-ROM sr1
[    6.775211] sd 1:0:0:0: Attached scsi generic sg0 type 0
[    6.775317] sr 2:0:0:0: Attached scsi generic sg1 type 5
[    6.775409] sr 2:0:1:0: Attached scsi generic sg2 type 5
[    6.782512]  sda: sda1 sda2 sda3
[    6.783453] sd 1:0:0:0: [sda] Attached SCSI disk
[    7.135083] PM: Starting manual resume from disk
[    7.135103] PM: Hibernation image partition 8:2 present
[    7.135107] PM: Looking for hibernation image.
[    7.135659] PM: Image not found (code -22)
[    7.135666] PM: Hibernation image not present or could not be loaded.
[    7.532688] random: nonblocking pool is initialized
[    7.553907] EXT4-fs (sda3): mounting ext3 file system using the ext4 subsystem
[    7.591627] EXT4-fs (sda3): mounted filesystem with ordered data mode. Opts: (null)
[   10.355875] systemd-udevd[328]: starting version 215
[   11.619994] media: Linux media interface: v0.10
[   11.685887] parport_pc 00:04: reported by Plug and Play ACPI
[   11.686032] parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE,EPP]
[   11.690402] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   11.701721] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input3
[   11.701738] ACPI: Power Button [PWRB]
[   11.701904] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input4
[   11.701910] ACPI: Power Button [PWRF]
[   11.780807] parport1: PC-style at 0x278 [PCSPP,TRISTATE]
[   11.780838] parport1: irq 0 detected
[   11.838897] piix4_smbus 0000:00:04.3: SMBus Host Controller at 0xe800, revision 0
[   11.850093] tsc: Marking TSC unstable due to TSC halts in idle
[   11.855564] clocksource: Switched to clocksource acpi_pm
[   11.876508] Linux video capture interface: v2.00
[   11.916287] blk_update_request: I/O error, dev fd0, sector 0
[   11.916338] floppy: error -5 while reading block 0
[   11.960429] blk_update_request: I/O error, dev fd1, sector 0
[   11.960479] floppy: error -5 while reading block 0
[   12.008383] input: PC Speaker as /devices/platform/pcspkr/input/input5
[   12.104140] [drm] Initialized drm 1.1.0 20060810
[   12.234841] bttv: driver version 0.9.19 loaded
[   12.234855] bttv: using 8 buffers with 2080k (520 pages) each for capture
[   12.234858] bttv: Host bridge needs ETBF enabled
[   12.234939] bttv: Bt8xx card found (0)
[   12.235679] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
[   12.235686] PCI: setting IRQ 10 as level-triggered
[   12.235709] bttv: 0: Bt848 (rev 18) at 0000:00:0b.0, irq: 10, latency: 32, mmio: 0xd7000000
[   12.239358] bttv: 0: using: Bt848 Capture 14MHz [card=163,insmod option]
[   12.239391] bttv: 0: enabling ETBF (430FX/VP3 compatibility)
[   12.239611] bttv: 0: tuner absent
[   12.239671] bttv: 0: Setting PLL: 14318181 => 35468950 (needs up to 100ms)
[   12.268124] bttv: PLL set ok
[   12.268366] bttv: 0: registered device video0
[   12.268460] bttv: 0: registered device vbi0
[   12.546460] ppdev: user-space parallel port driver
[   13.025157] [drm] radeon kernel modesetting enabled.
[   13.026125] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
[   13.026132] PCI: setting IRQ 11 as level-triggered
[   13.027255] [drm] initializing kernel modesetting (R200 0x1002:0x514D 0x148C:0x2054 0x00).
[   13.027286] [drm] register mmio base: 0xD6800000
[   13.027289] [drm] register mmio size: 65536
[   13.028148] agpgart-intel 0000:00:00.0: AGP 1.0 bridge
[   13.028167] agpgart-intel 0000:00:00.0: putting AGP V2 device into 2x mode
[   13.028188] radeon 0000:01:00.0: putting AGP V2 device into 2x mode
[   13.028196] radeon 0000:01:00.0: GTT: 64M 0xE4000000 - 0xE7FFFFFF
[   13.028207] radeon 0000:01:00.0: VRAM: 128M 0x00000000D8000000 - 0x00000000DFFFFFFF (64M used)
[   13.028284] [drm] Detected VRAM RAM=128M, BAR=128M
[   13.028288] [drm] RAM width 128bits DDR
[   13.028450] [TTM] Zone  kernel: Available graphics memory: 255234 kiB
[   13.028455] [TTM] Initializing pool allocator
[   13.028534] [drm] radeon: 64M of VRAM memory ready
[   13.028539] [drm] radeon: 64M of GTT memory ready.
[   13.029879] radeon 0000:01:00.0: WB disabled
[   13.029898] radeon 0000:01:00.0: fence driver on ring 0 use gpu addr 0x00000000e4000000 and cpu addr 0xe081c000
[   13.029905] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   13.029908] [drm] Driver supports precise vblank timestamp query.
[   13.029934] [drm] radeon: irq initialized.
[   13.029977] [drm] Loading R200 Microcode
[   13.176476] radeon 0000:01:00.0: firmware: direct-loading firmware radeon/R200_cp.bin
[   13.176803] [drm] radeon: ring at 0x00000000E4001000
[   13.176832] [drm] ring test succeeded in 1 usecs
[   13.177086] [drm] ib test succeeded in 0 usecs
[   13.178410] [drm] Radeon Display Connectors
[   13.178420] [drm] Connector 0:
[   13.178423] [drm]   VGA-1
[   13.178428] [drm]   DDC: 0x60 0x60 0x60 0x60 0x60 0x60 0x60 0x60
[   13.178431] [drm]   Encoders:
[   13.178434] [drm]     CRT1: INTERNAL_DAC1
[   13.178438] [drm] Connector 1:
[   13.178440] [drm]   DVI-D-1
[   13.178443] [drm]   HPD1
[   13.178448] [drm]   DDC: 0x64 0x64 0x64 0x64 0x64 0x64 0x64 0x64
[   13.178451] [drm]   Encoders:
[   13.178454] [drm]     DFP1: INTERNAL_TMDS1
[   13.215232] platform VGA-1: firmware: direct-loading firmware edid-iiyama.bin
[   13.215929] [drm] Got external EDID base block and 0 extensions from "edid-iiyama.bin" for connector "VGA-1"
[   13.248105] [drm:drm_edid_block_valid [drm]] *ERROR* EDID checksum is invalid, remainder is 244
[   13.248149] Raw EDID:
[   13.248185]  	00 ff ff ff ff ff ff 00 26 cd 48 17 51 ac 31 01
[   13.248220]  	0e 0b 01 01 0e 20 18 94 c8 00 b8 a0 57 49 9b 26
[   13.248254]  	10 48 4c 3f ef 80 31 4a 49 4f a9 40 81 8f 61 59
[   13.248288]  	01 01 01 01 01 01 00 00 00 fe 00 00 00 00 00 00
[   13.248322]  	00 00 00 00 00 00 00 00 00 00 00 fe 00 00 00 00
[   13.248356]  	00 00 00 00 00 00 00 00 00 00 00 00 00 fe 00 00
[   13.248390]  	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fe
[   13.248423]  	0c 00 00 00 00 00 00 00 00 00 00 00 00 00 00 e1
[   13.277207] [drm:drm_edid_block_valid [drm]] *ERROR* EDID checksum is invalid, remainder is 244
[   13.277254] Raw EDID:
[   13.277289]  	00 ff ff ff ff ff ff 00 26 cd 48 17 51 ac 31 01
[   13.277325]  	0e 0b 01 01 0e 20 18 94 c8 00 b8 a0 57 49 9b 26
[   13.277361]  	10 48 4c 3f ef 80 31 4a 49 4f a9 40 81 8f 61 59
[   13.277398]  	01 01 01 01 01 01 00 00 00 fe 00 00 00 00 00 00
[   13.277433]  	00 00 00 00 00 00 00 00 00 00 00 fe 00 00 00 00
[   13.277470]  	00 00 00 00 00 00 00 00 00 00 00 00 00 fe 00 00
[   13.277505]  	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fe
[   13.277541]  	0c 00 00 00 00 00 00 00 00 00 00 00 00 00 00 e1
[   13.307210] [drm:drm_edid_block_valid [drm]] *ERROR* EDID checksum is invalid, remainder is 244
[   13.307264] Raw EDID:
[   13.307301]  	00 ff ff ff ff ff ff 00 26 cd 48 17 51 ac 31 01
[   13.307337]  	0e 0b 01 01 0e 20 18 94 c8 00 b8 a0 57 49 9b 26
[   13.307373]  	10 48 4c 3f ef 80 31 4a 49 4f a9 40 81 8f 61 59
[   13.307408]  	01 01 01 01 01 01 00 00 00 fe 00 00 00 00 00 00
[   13.307445]  	00 00 00 00 00 00 00 00 00 00 00 fe 00 00 00 00
[   13.307480]  	00 00 00 00 00 00 00 00 00 00 00 00 00 fe 00 00
[   13.307516]  	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fe
[   13.307552]  	0c 00 00 00 00 00 00 00 00 00 00 00 00 00 00 e1
[   13.354770] [drm:drm_edid_block_valid [drm]] *ERROR* EDID checksum is invalid, remainder is 244
[   13.354825] Raw EDID:
[   13.354862]  	00 ff ff ff ff ff ff 00 26 cd 48 17 51 ac 31 01
[   13.354899]  	0e 0b 01 01 0e 20 18 94 c8 00 b8 a0 57 49 9b 26
[   13.354935]  	10 48 4c 3f ef 80 31 4a 49 4f a9 40 81 8f 61 59
[   13.354970]  	01 01 01 01 01 01 00 00 00 fe 00 00 00 00 00 00
[   13.355006]  	00 00 00 00 00 00 00 00 00 00 00 fe 00 00 00 00
[   13.355042]  	00 00 00 00 00 00 00 00 00 00 00 00 00 fe 00 00
[   13.355078]  	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fe
[   13.355114]  	0c 00 00 00 00 00 00 00 00 00 00 00 00 00 00 e1
[   13.355155] radeon 0000:01:00.0: DVI-D-1: EDID block 0 invalid.
[   13.355573] [drm:radeon_dvi_detect [radeon]] *ERROR* DVI-D-1: probed a monitor but no|invalid EDID
[   13.542079] [drm] fb mappable at 0xD8040000
[   13.542089] [drm] vram apper at 0xD8000000
[   13.542092] [drm] size 3145728
[   13.542096] [drm] fb depth is 24
[   13.542099] [drm]    pitch is 4096
[   13.542743] fbcon: radeondrmfb (fb0) is primary device
[   13.666095] Console: switching to colour frame buffer device 128x48
[   13.683804] radeon 0000:01:00.0: fb0: radeondrmfb frame buffer device
[   13.683825] [drm] Initialized radeon 2.43.0 20080528 for 0000:01:00.0 on minor 0
[   13.923232] Adding 1048572k swap on /dev/sda2.  Priority:-1 extents:1 across:1048572k FS
[   14.215756] EXT4-fs (sda3): re-mounted. Opts: (null)
[   15.695493] EXT4-fs (sda3): re-mounted. Opts: errors=remount-ro
[   16.495658] device-mapper: uevent: version 1.0.3
[   16.497041] device-mapper: ioctl: 4.34.0-ioctl (2015-10-28) initialised: dm-devel@redhat.com
[   16.799373] lp0: using parport0 (interrupt-driven).
[   16.800840] lp1: using parport1 (polling).
[   16.889228] loop: module loaded
[   17.022545] w83781d: Found a W83781D chip at 0x290
[   17.597067] sbawe 01:01.00: [irq 5]
[   17.597083] sbawe 01:01.00: [dma 1]
[   17.597089] sbawe 01:01.00: [dma 5]
[   17.597103] sbawe 01:01.00: [io  0x0220-0x022f]
[   17.597111] sbawe 01:01.00: [io  0x0330-0x0331]
[   17.597120] sbawe 01:01.00: [io  0x0388-0x038b]
[   17.599438] sbawe 01:01.00: activated
[   17.599448] sbawe 01:01.02: [io  0x0620-0x0623]
[   17.599456] sbawe 01:01.02: [io  0x0a20-0x0a23]
[   17.599464] sbawe 01:01.02: [io  0x0e20-0x0e23]
[   17.601710] sbawe 01:01.02: activated
[   17.652094] EMU8000 [0x620]: 512 KiB on-board DRAM detected
[   19.180711] fuse init (API version 7.24)
[   21.756729] FAT-fs (sda1): utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
[   21.858427] FAT-fs (sda1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
[   22.867383] eth0:  setting half-duplex.
[   23.717991] platform VGA-1: firmware: direct-loading firmware edid-iiyama.bin
[   23.718526] [drm] Got external EDID base block and 0 extensions from "edid-iiyama.bin" for connector "VGA-1"
[   23.847833] [drm:radeon_dvi_detect [radeon]] *ERROR* DVI-D-1: probed a monitor but no|invalid EDID
[   33.505269] /dev/vmmon[1902]: Module vmmon: registered with major=10 minor=165
[   33.505297] /dev/vmmon[1902]: Module vmmon: initialized
[   33.774009] /dev/vmci[1912]: VMCI: Driver initialized.
[   33.775258] /dev/vmci[1912]: Module vmci: registered with major=10 minor=58
[   33.775270] /dev/vmci[1912]: Module vmci: initialized
[   34.861891] platform VGA-1: firmware: direct-loading firmware edid-iiyama.bin
[   34.862513] [drm] Got external EDID base block and 0 extensions from "edid-iiyama.bin" for connector "VGA-1"
[   34.986158] [drm:radeon_dvi_detect [radeon]] *ERROR* DVI-D-1: probed a monitor but no|invalid EDID
[   35.021149] /dev/vmnet: open called by PID 1968 (vmnet-bridge)
[   35.021173] /dev/vmnet: hub 0 does not exist, allocating memory.
[   35.021229] /dev/vmnet: port on hub 0 successfully opened
[   35.021261] bridge-eth0: up
[   35.021269] bridge-eth0: attached
[   35.190680] platform VGA-1: firmware: direct-loading firmware edid-iiyama.bin
[   35.191284] [drm] Got external EDID base block and 0 extensions from "edid-iiyama.bin" for connector "VGA-1"
[   35.346853] [drm:radeon_dvi_detect [radeon]] *ERROR* DVI-D-1: probed a monitor but no|invalid EDID
[   36.489789] /dev/vmnet: open called by PID 2015 (vmnet-dhcpd)
[   36.489815] /dev/vmnet: hub 1 does not exist, allocating memory.
[   36.489865] /dev/vmnet: port on hub 1 successfully opened
[   36.693868] /dev/vmnet: open called by PID 2017 (vmnet-netifup)
[   36.693903] /dev/vmnet: port on hub 1 successfully opened
[   36.940293] /dev/vmnet: open called by PID 2019 (vmnet-dhcpd)
[   36.940323] /dev/vmnet: hub 8 does not exist, allocating memory.
[   36.940381] /dev/vmnet: port on hub 8 successfully opened
[   37.188528] /dev/vmnet: open called by PID 2028 (vmnet-natd)
[   37.188565] /dev/vmnet: port on hub 8 successfully opened
[   37.353293] /dev/vmnet: open called by PID 2030 (vmnet-netifup)
[   37.353333] /dev/vmnet: port on hub 8 successfully opened
[   41.486843] platform VGA-1: firmware: direct-loading firmware edid-iiyama.bin
[   41.487454] [drm] Got external EDID base block and 0 extensions from "edid-iiyama.bin" for connector "VGA-1"
[   41.606640] [drm:radeon_dvi_detect [radeon]] *ERROR* DVI-D-1: probed a monitor but no|invalid EDID
[   41.728136] platform VGA-1: firmware: direct-loading firmware edid-iiyama.bin
[   41.728793] [drm] Got external EDID base block and 0 extensions from "edid-iiyama.bin" for connector "VGA-1"
[   41.848582] [drm:radeon_dvi_detect [radeon]] *ERROR* DVI-D-1: probed a monitor but no|invalid EDID
[   41.968521] platform VGA-1: firmware: direct-loading firmware edid-iiyama.bin
[   41.969129] [drm] Got external EDID base block and 0 extensions from "edid-iiyama.bin" for connector "VGA-1"
[   42.101880] [drm:radeon_dvi_detect [radeon]] *ERROR* DVI-D-1: probed a monitor but no|invalid EDID
[   50.247288] systemd-logind[2180]: New seat seat0.
[   50.272662] systemd-logind[2180]: Watching system buttons on /dev/input/event3 (Power Button)
[   50.272890] systemd-logind[2180]: Watching system buttons on /dev/input/event2 (Power Button)
[   50.291427] systemd-logind[2180]: Failed to start user service: Unknown unit: user@1000.service
[   50.307693] systemd-logind[2180]: New session c1 of user rainbow.
[   55.626314] platform VGA-1: firmware: direct-loading firmware edid-iiyama.bin
[   55.626845] [drm] Got external EDID base block and 0 extensions from "edid-iiyama.bin" for connector "VGA-1"
[   55.747297] [drm:radeon_dvi_detect [radeon]] *ERROR* DVI-D-1: probed a monitor but no|invalid EDID
[   55.867910] platform VGA-1: firmware: direct-loading firmware edid-iiyama.bin
[   55.868916] [drm] Got external EDID base block and 0 extensions from "edid-iiyama.bin" for connector "VGA-1"
[   55.987477] [drm:radeon_dvi_detect [radeon]] *ERROR* DVI-D-1: probed a monitor but no|invalid EDID
[   56.107247] platform VGA-1: firmware: direct-loading firmware edid-iiyama.bin
[   56.107855] [drm] Got external EDID base block and 0 extensions from "edid-iiyama.bin" for connector "VGA-1"
[   56.226627] [drm:radeon_dvi_detect [radeon]] *ERROR* DVI-D-1: probed a monitor but no|invalid EDID
[   97.010370] SGI XFS with ACLs, security attributes, realtime, no debug enabled
[   97.077658] JFS: nTxBlock = 3988, nTxLock = 31904
[   97.191115] ntfs: driver 2.1.32 [Flags: R/O MODULE].
[   97.384418] QNX4 filesystem 0.2.3 registered.
[   97.556056] raid6: mmxx1    gen()  1302 MB/s
[   97.624061] raid6: mmxx2    gen()  1561 MB/s
[   97.692074] raid6: sse1x1   gen()  1152 MB/s
[   97.760064] raid6: sse1x2   gen()  1522 MB/s
[   97.828165] raid6: int32x1  gen()   420 MB/s
[   97.896057] raid6: int32x1  xor()   208 MB/s
[   97.964139] raid6: int32x2  gen()   539 MB/s
[   98.032076] raid6: int32x2  xor()   297 MB/s
[   98.100153] raid6: int32x4  gen()   466 MB/s
[   98.168082] raid6: int32x4  xor()   291 MB/s
[   98.236134] raid6: int32x8  gen()   428 MB/s
[   98.304042] raid6: int32x8  xor()   263 MB/s
[   98.304046] raid6: using algorithm mmxx2 gen() 1561 MB/s
[   98.304050] raid6: using intx1 recovery algorithm
[   99.244489] xor: measuring software checksum speed
[   99.284036]    pIII_sse  :  3069.000 MB/sec
[   99.324034]    prefetch64-sse:  3294.000 MB/sec
[   99.324039] xor: using function: prefetch64-sse (3294.000 MB/sec)
[   99.576155] Btrfs loaded

--Boundary-00=_ne/6XyV8J/SRmzo
Content-Type: text/plain;
  charset="iso-8859-15";
  name="dmesg-reverted.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg-reverted.txt"

[    0.000000] Linux version 4.8.0-rc8+ (zary@gsql) (gcc version 4.7.2 (Debian 4.7.2-5) ) #111 SMP Wed Sep 28 18:50:17 CEST 2016
[    0.000000] x86/fpu: Legacy x87 FPU detected.
[    0.000000] x86/fpu: Using 'eager' FPU context switches.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001fffcfff] usable
[    0.000000] BIOS-e820: [mem 0x000000001fffd000-0x000000001fffefff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000001ffff000-0x000000001fffffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000ffff0000-0x00000000ffffffff] reserved
[    0.000000] Notice: NX (Execute Disable) protection missing in CPU!
[    0.000000] Legacy DMI 2.0 present.
[    0.000000] DMI: System Manufacturer System Name/P2B, BIOS ASUS P2B ACPI BIOS Revision 1014 Beta 003                        08/01/02
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x1fffd max_arch_pfn = 0x100000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-AFFFF uncachable
[    0.000000]   B0000-BFFFF write-combining
[    0.000000]   C0000-C7FFF write-protect
[    0.000000]   C8000-F7FFF uncachable
[    0.000000]   F8000-FCFFF write-protect
[    0.000000]   FD000-FFFFF uncachable
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask FE0000000 write-back
[    0.000000]   1 disabled
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 base 0D8000000 mask FF8000000 write-combining
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86/PAT: PAT not supported by CPU.
[    0.000000] x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC- UC  
[    0.000000] initial memory mapped: [mem 0x00000000-0x01bfffff]
[    0.000000] Base memory trampoline at [c009b000] 9b000 size 16384
[    0.000000] BRK [0x016b7000, 0x016b7fff] PGTABLE
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F7F90 000014 (v00 ASUS  )
[    0.000000] ACPI: RSDT 0x000000001FFFD000 00002C (v01 ASUS   P2B      42302E31 MSFT 31313031)
[    0.000000] ACPI: FACP 0x000000001FFFD080 000074 (v01 ASUS   P2B      42302E31 MSFT 31313031)
[    0.000000] ACPI: DSDT 0x000000001FFFD100 001BA8 (v01 ASUS   P2B      00001000 MSFT 01000001)
[    0.000000] ACPI: FACS 0x000000001FFFF000 000040
[    0.000000] ACPI: BOOT 0x000000001FFFD040 000028 (v01 ASUS   P2B      42302E31 MSFT 31313031)
[    0.000000] 0MB HIGHMEM available.
[    0.000000] 511MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 1fffd000
[    0.000000]   low ram: 0 - 1fffd000
[    0.000000] BRK [0x016b8000, 0x016b8fff] PGTABLE
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   Normal   [mem 0x0000000001000000-0x000000001fffcfff]
[    0.000000]   HighMem  empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000001fffcfff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000001fffcfff]
[    0.000000] On node 0 totalpages: 130971
[    0.000000] free_area_init_node: node 0, pgdat c15b1c00, node_mem_map dfbfd020
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
[    0.000000]   Normal zone: 992 pages used for memmap
[    0.000000]   Normal zone: 126973 pages, LIFO batch:31
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
[    0.000000] e820: [mem 0x20000000-0xfffeffff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:1 nr_node_ids:1
[    0.000000] percpu: Embedded 19 pages/cpu @dfbe6000 s47980 r0 d29844 u77824
[    0.000000] pcpu-alloc: s47980 r0 d29844 u77824 alloc=19*4096
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 129947
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-test root=/dev/sda3 ro quiet drm_kms_helper.edid_firmware=VGA-1:edid-iiyama.bin video=VGA-1:1024x768
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Initializing CPU#0
[    0.000000] Initializing HighMem for node 0 (00000000:00000000)
[    0.000000] Memory: 512336K/523884K available (3918K kernel code, 437K rwdata, 1520K rodata, 524K init, 412K bss, 11548K reserved, 0K cma-reserved, 0K highmem)
[    0.000000] virtual kernel memory layout:
    fixmap  : 0xfff17000 - 0xfffff000   ( 928 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xe07fd000 - 0xff7fe000   ( 496 MB)
    lowmem  : 0xc0000000 - 0xdfffd000   ( 511 MB)
      .init : 0xc15c1000 - 0xc1644000   ( 524 kB)
      .data : 0xc13d3be1 - 0xc15bf6a0   (1966 kB)
      .text : 0xc1000000 - 0xc13d3be1   (3918 kB)
[    0.000000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 32.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=1
[    0.000000] NR_IRQS:2304 nr_irqs:32 16
[    0.000000] CPU 0 irqstacks, hard=df41c000 soft=df41e000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 1365.047 MHz processor
[    0.004006] Calibrating delay loop (skipped), value calculated using timer frequency.. 2730.09 BogoMIPS (lpj=5460188)
[    0.004014] pid_max: default: 32768 minimum: 301
[    0.004036] ACPI: Core revision 20160422
[    0.008470] ACPI: 1 ACPI AML tables successfully acquired and loaded

[    0.008483] ACPI: setting ELCR to 0200 (from 0e00)
[    0.008532] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.008536] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.009150] Last level iTLB entries: 4KB 32, 2MB 0, 4MB 2
[    0.009157] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 8, 1GB 0
[    0.012097] Freeing SMP alternatives memory: 16K (c1644000 - c1648000)
[    0.012358] smpboot: Max logical packages: 1
[    0.012364] smpboot: weird, boot CPU (#0) not listed by the BIOS
[    0.012365] smpboot: SMP motherboard not detected
[    0.012367] smpboot: SMP disabled
[    0.012370] smpboot: Local APIC not detected. Using dummy APIC emulation.
[    0.012374] Performance Events: 
[    0.012379] no APIC, boot with the "lapic" boot parameter to force-enable it.
[    0.012381] no hardware sampling interrupt available.
[    0.012385] p6 PMU driver.
[    0.012390] ... version:                0
[    0.012391] ... bit width:              32
[    0.012393] ... generic registers:      2
[    0.012395] ... value mask:             00000000ffffffff
[    0.012397] ... max period:             000000007fffffff
[    0.012398] ... fixed-purpose events:   0
[    0.012400] ... event mask:             0000000000000003
[    0.013162] x86: Booted up 1 node, 1 CPUs
[    0.013169] smpboot: Total of 1 processors activated (2730.09 BogoMIPS)
[    0.013490] devtmpfs: initialized
[    0.014174] PM: Registering ACPI NVS region [mem 0x1ffff000-0x1fffffff] (4096 bytes)
[    0.014306] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.014524] NET: Registered protocol family 16
[    0.014901] cpuidle: using governor ladder
[    0.014905] cpuidle: using governor menu
[    0.015039] Simple Boot Flag at 0x46 set to 0x1
[    0.015052] clocksource: pit: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1601818034827 ns
[    0.015065] ACPI: bus type PCI registered
[    0.018903] PCI: PCI BIOS revision 2.10 entry at 0xf0720, last bus=1
[    0.018906] PCI: Using configuration type 1 for base access
[    0.022164] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[    0.022504] ACPI: Added _OSI(Module Device)
[    0.022507] ACPI: Added _OSI(Processor Device)
[    0.022509] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.022512] ACPI: Added _OSI(Processor Aggregator Device)
[    0.024396] ACPI: Interpreter enabled
[    0.024450] ACPI: (supports S0 S1 S4 S5)
[    0.024453] ACPI: Using PIC for interrupt routing
[    0.024496] PCI: Ignoring host bridge windows from ACPI; if necessary, use "pci=use_crs" and report a bug
[    0.031263] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[    0.031434] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
[    0.031593] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
[    0.031752] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
[    0.031905] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.031916] acpi PNP0A03:00: _OSC: OS supports [Segments MSI]
[    0.031928] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.031937] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.032085] acpi PNP0A03:00: host bridge window [io  0x0cf8-0x0cff] (ignored)
[    0.032089] acpi PNP0A03:00: host bridge window [io  0x0000-0x0cf7 window] (ignored)
[    0.032093] acpi PNP0A03:00: host bridge window [io  0x0d00-0xffff window] (ignored)
[    0.032097] acpi PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff window] (ignored)
[    0.032101] acpi PNP0A03:00: host bridge window [mem 0x000c8000-0x000dffff window] (ignored)
[    0.032104] acpi PNP0A03:00: host bridge window [mem 0x20000000-0xfffdffff window] (ignored)
[    0.032107] PCI: root bus 00: using default resources
[    0.032213] PCI host bridge to bus 0000:00
[    0.032219] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.032223] pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffff]
[    0.032228] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.032248] pci 0000:00:00.0: [8086:7190] type 00 class 0x060000
[    0.032261] pci 0000:00:00.0: reg 0x10: [mem 0xe4000000-0xe7ffffff pref]
[    0.032423] pci 0000:00:01.0: [8086:7191] type 01 class 0x060400
[    0.032551] pci 0000:00:04.0: [8086:7110] type 00 class 0x060100
[    0.032725] pci 0000:00:04.1: [8086:7111] type 00 class 0x010180
[    0.032766] pci 0000:00:04.1: reg 0x20: [io  0xb800-0xb80f]
[    0.032786] pci 0000:00:04.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.032790] pci 0000:00:04.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.032793] pci 0000:00:04.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.032797] pci 0000:00:04.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.032911] pci 0000:00:04.2: [8086:7112] type 00 class 0x0c0300
[    0.032953] pci 0000:00:04.2: reg 0x20: [io  0xb400-0xb41f]
[    0.033026] pci 0000:00:04.2: System wakeup disabled by ACPI
[    0.033116] pci 0000:00:04.3: [8086:7113] type 00 class 0x068000
[    0.033121] * Found PM-Timer Bug on the chipset. Due to workarounds for a bug,
* this clock source is slow. Consider trying other clock sources
[    0.033188] pci 0000:00:04.3: quirk: [io  0xe400-0xe43f] claimed by PIIX4 ACPI
[    0.033193] pci 0000:00:04.3: quirk: [io  0xe800-0xe80f] claimed by PIIX4 SMB
[    0.033199] pci 0000:00:04.3: PIIX4 devres B PIO at 0290-0297
[    0.033334] pci 0000:00:09.0: [10b7:9001] type 00 class 0x020000
[    0.033348] pci 0000:00:09.0: reg 0x10: [io  0xb000-0xb03f]
[    0.033386] pci 0000:00:09.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    0.033492] pci 0000:00:0a.0: [10cd:1300] type 00 class 0x010000
[    0.033506] pci 0000:00:0a.0: reg 0x10: [io  0xa800-0xa8ff]
[    0.033516] pci 0000:00:0a.0: reg 0x14: [mem 0xd6000000-0xd60000ff]
[    0.033547] pci 0000:00:0a.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    0.033665] pci 0000:00:0b.0: [109e:0350] type 00 class 0x040000
[    0.033680] pci 0000:00:0b.0: reg 0x10: [mem 0xd7000000-0xd7000fff pref]
[    0.033892] pci 0000:01:00.0: [1002:514d] type 00 class 0x030000
[    0.033907] pci 0000:01:00.0: reg 0x10: [mem 0xd8000000-0xdfffffff pref]
[    0.033916] pci 0000:01:00.0: reg 0x14: [io  0xd800-0xd8ff]
[    0.033925] pci 0000:01:00.0: reg 0x18: [mem 0xd6800000-0xd680ffff]
[    0.033948] pci 0000:01:00.0: reg 0x30: [mem 0xd7fe0000-0xd7ffffff pref]
[    0.033979] pci 0000:01:00.0: supports D1 D2
[    0.034076] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.034082] pci 0000:00:01.0:   bridge window [io  0xd000-0xdfff]
[    0.034087] pci 0000:00:01.0:   bridge window [mem 0xd6800000-0xd6ffffff]
[    0.034092] pci 0000:00:01.0:   bridge window [mem 0xd7f00000-0xe3ffffff pref]
[    0.034101] pci_bus 0000:00: on NUMA node 0
[    0.037062] vgaarb: setting as boot device: PCI:0000:01:00.0
[    0.037067] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.037068] vgaarb: loaded
[    0.037071] vgaarb: bridge control possible 0000:01:00.0
[    0.037240] SCSI subsystem initialized
[    0.037353] libata version 3.00 loaded.
[    0.037365] ACPI: bus type USB registered
[    0.037424] usbcore: registered new interface driver usbfs
[    0.037452] usbcore: registered new interface driver hub
[    0.037490] usbcore: registered new device driver usb
[    0.037555] PCI: Using ACPI for IRQ routing
[    0.037561] PCI: pci_cache_line_size set to 32 bytes
[    0.037597] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.037601] e820: reserve RAM buffer [mem 0x1fffd000-0x1fffffff]
[    0.038338] clocksource: Switched to clocksource pit
[    0.052096] pnp: PnP ACPI init
[    0.052457] system 00:00: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.052465] system 00:00: [mem 0x000f0000-0x000fffff] could not be reserved
[    0.052470] system 00:00: [mem 0x00100000-0x1fffffff] could not be reserved
[    0.052475] system 00:00: [mem 0xfffe0000-0xffffffff] could not be reserved
[    0.052487] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.053049] system 00:01: [io  0xe400-0xe43f] has been reserved
[    0.053054] system 00:01: [io  0xe800-0xe80f] has been reserved
[    0.053059] system 00:01: [io  0x0294-0x0297] has been reserved
[    0.053064] system 00:01: [io  0x03f0-0x03f1] has been reserved
[    0.053068] system 00:01: [io  0x04d0-0x04d1] has been reserved
[    0.053076] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.053159] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.053585] pnp 00:03: [dma 2]
[    0.053739] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.054584] pnp 00:04: [dma 3]
[    0.054694] pnp 00:04: Plug and Play ACPI device, IDs PNP0401 (active)
[    0.055294] pnp 00:05: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.055996] pnp 00:06: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.056466] pnp 00:07: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.056484] pnp: PnP ACPI: found 8 devices
[    0.056491] PnPBIOS: Disabled
[    0.095289] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.095331] clocksource: Switched to clocksource acpi_pm
[    0.095374] pci 0000:00:09.0: BAR 6: assigned [mem 0x20000000-0x2000ffff pref]
[    0.095382] pci 0000:00:0a.0: BAR 6: assigned [mem 0x20010000-0x2001ffff pref]
[    0.095390] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.095394] pci 0000:00:01.0:   bridge window [io  0xd000-0xdfff]
[    0.095401] pci 0000:00:01.0:   bridge window [mem 0xd6800000-0xd6ffffff]
[    0.095406] pci 0000:00:01.0:   bridge window [mem 0xd7f00000-0xe3ffffff pref]
[    0.095415] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
[    0.095419] pci_bus 0000:00: resource 5 [mem 0x00000000-0xffffffff]
[    0.095423] pci_bus 0000:01: resource 0 [io  0xd000-0xdfff]
[    0.095427] pci_bus 0000:01: resource 1 [mem 0xd6800000-0xd6ffffff]
[    0.095431] pci_bus 0000:01: resource 2 [mem 0xd7f00000-0xe3ffffff pref]
[    0.095510] NET: Registered protocol family 2
[    0.095893] TCP established hash table entries: 4096 (order: 2, 16384 bytes)
[    0.095940] TCP bind hash table entries: 4096 (order: 3, 32768 bytes)
[    0.096024] TCP: Hash tables configured (established 4096 bind 4096)
[    0.096103] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    0.096128] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    0.096280] NET: Registered protocol family 1
[    0.096317] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    0.096955] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
[    0.096959] PCI: setting IRQ 9 as level-triggered
[    0.097097] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.097101] PCI: CLS 32 bytes, default 32
[    0.098279] futex hash table entries: 256 (order: 1, 8192 bytes)
[    0.099086] workingset: timestamp_bits=30 max_order=17 bucket_order=0
[    0.106007] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.106015] io scheduler noop registered
[    0.106017] io scheduler deadline registered
[    0.106097] io scheduler cfq registered (default)
[    0.106636] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.106645] ACPI: Power Button [PWRB]
[    0.106790] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.106795] ACPI: Power Button [PWRF]
[    0.106891] tsc: Marking TSC unstable due to TSC halts in idle
[    0.106980] Warning: Processor Platform Limit event detected, but not handled.
[    0.106981] Consider compiling CPUfreq support into your kernel.
[    0.107420] isapnp: Scanning for PnP cards...
[    0.230225] pnp 01:01.00: increased option port range from 0x388-0x388 to 0x388-0x3f8
[    0.230230] pnp 01:01.00: increased option port range from 0x388-0x388 to 0x388-0x3f8
[    0.230235] pnp 01:01.00: increased option port range from 0x388-0x388 to 0x388-0x3f8
[    0.230330] pnp 01:01.02: added ioport region 0xe20-0xe20 to set 0
[    0.230334] pnp 01:01.02: added ioport region 0xa20-0xa20 to set 0
[    0.230338] pnp 01:01.02: added ioport region 0xe20-0xe80 to set 1
[    0.230342] pnp 01:01.02: added ioport region 0xa20-0xa80 to set 1
[    0.230402]  01:01: card 'Creative SB AWE64  PnP'
[    0.230405] isapnp: 1 Plug & Play card detected total
[    0.230532] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.251089] 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.271750] serial8250: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    0.292251] serial8250: ttyS2 at I/O 0x3e8 (irq = 4, base_baud = 115200) is a 16550A
[    0.312746] serial8250: ttyS3 at I/O 0x2e8 (irq = 3, base_baud = 115200) is a 16550A
[    0.313153] Non-volatile memory driver v1.3
[    0.313157] Linux agpgart interface v0.103
[    0.313212] [drm] Initialized drm 1.1.0 20060810
[    0.318553] loop: module loaded
[    0.318686] ata_piix 0000:00:04.1: version 2.13
[    0.319675] scsi host0: ata_piix
[    0.319952] scsi host1: ata_piix
[    0.320151] ata1: PATA max UDMA/33 cmd 0x1f0 ctl 0x3f6 bmdma 0xb800 irq 14
[    0.320156] ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xb808 irq 15
[    0.320411] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.320414] ehci-pci: EHCI PCI platform driver
[    0.320440] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.320459] ohci-pci: OHCI PCI platform driver
[    0.320484] uhci_hcd: USB Universal Host Controller Interface driver
[    0.320676] uhci_hcd 0000:00:04.2: UHCI Host Controller
[    0.320691] uhci_hcd 0000:00:04.2: new USB bus registered, assigned bus number 1
[    0.320735] uhci_hcd 0000:00:04.2: irq 9, io base 0x0000b400
[    0.321473] hub 1-0:1.0: USB hub found
[    0.321492] hub 1-0:1.0: 2 ports detected
[    0.321869] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    0.325079] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.325093] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.325439] mousedev: PS/2 mouse device common for all mice
[    0.325868] rtc_cmos 00:02: RTC can wake from S4
[    0.326060] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
[    0.326087] rtc_cmos 00:02: alarms up to one month, 242 bytes nvram
[    0.326482] NET: Registered protocol family 17
[    0.326643] Using IPI No-Shortcut mode
[    0.326945] registered taskstats version 1
[    0.327358] rtc_cmos 00:02: setting system clock to 2016-09-28 18:53:17 UTC (1475088797)
[    0.327435] PM: Hibernation image not present or could not be loaded.
[    0.354302] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input2
[    0.482749] ata1.00: ATA-7: SAMSUNG SP1213N, TL100-24, max UDMA/100
[    0.482754] ata1.00: 234493056 sectors, multi 16: LBA48 
[    0.485386] ata1.00: configured for UDMA/33
[    0.485703] scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG SP1213N  0-24 PQ: 0 ANSI: 5
[    0.486359] sd 0:0:0:0: [sda] 234493056 512-byte logical blocks: (120 GB/112 GiB)
[    0.486507] sd 0:0:0:0: [sda] Write Protect is off
[    0.486512] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.486574] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    0.487138] ata2.00: ATAPI: TOSHIBA DVD-ROM SD-M1212, 1R22, max UDMA/33
[    0.487150] ata2.01: ATAPI: ATAPI   COMBO48XMAX, VER 1.50, max UDMA/100
[    0.491925] ata2.00: configured for UDMA/33
[    0.496564] ata2.01: configured for UDMA/33
[    0.501093] scsi 1:0:0:0: CD-ROM            TOSHIBA  DVD-ROM SD-M1212 1R22 PQ: 0 ANSI: 5
[    0.514124] scsi 1:0:1:0: CD-ROM            ATAPI    COMBO48XMAX      1.50 PQ: 0 ANSI: 5
[    0.521421]  sda: sda1 sda2 sda3
[    0.522279] sd 0:0:0:0: [sda] Attached SCSI disk
[    0.960162] random: fast init done
[    1.120051] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x13ad257ca30, max_idle_ns: 440795244238 ns
[    1.935964] input: ImPS/2 BYD TouchPad as /devices/platform/i8042/serio1/input/input4
[    1.949908] EXT4-fs (sda3): mounting ext3 file system using the ext4 subsystem
[    1.970348] EXT4-fs (sda3): mounted filesystem with ordered data mode. Opts: (null)
[    1.970382] VFS: Mounted root (ext3 filesystem) readonly on device 8:3.
[    1.972222] Freeing unused kernel memory: 524K (c15c1000 - c1644000)
[    1.972493] Write protecting the kernel text: 3920k
[    1.972562] Write protecting the kernel read-only data: 1528k
[    4.327352] systemd-udevd[194]: starting version 215
[    5.904101] random: crng init done
[    7.617164] Adding 1048572k swap on /dev/sda2.  Priority:-1 extents:1 across:1048572k 
[    7.685443] EXT4-fs (sda3): re-mounted. Opts: (null)
[    8.153707] EXT4-fs (sda3): re-mounted. Opts: errors=remount-ro

--Boundary-00=_ne/6XyV8J/SRmzo--
