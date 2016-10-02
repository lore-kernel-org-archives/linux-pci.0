Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Ondrej Zary <linux@rainbow-software.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: 4.7 regression: ACPI: No IRQ available for PCI Interrupt Link [LNKD]. Try pci=noacpi or acpi=off
Date: Sun, 2 Oct 2016 18:53:18 +0200
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>, wim@djo.tudelft.nl,
        ravikanth.nalla@hpe.com
References: <201609251512.05657.linux@rainbow-software.org> <CAJZ5v0gKFVEYFhyge8+_ZTSg_OK6uzBByivgbvEV-Up4Q3YSiw@mail.gmail.com> <dda55738-d52b-1cdd-8973-8dea3506a835@codeaurora.org>
In-Reply-To: <dda55738-d52b-1cdd-8973-8dea3506a835@codeaurora.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/tT8Xd3aZvVQBBz"
Message-Id: <201610021853.19635.linux@rainbow-software.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Boundary-00=_/tT8Xd3aZvVQBBz
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 01 October 2016 19:49:17 Sinan Kaya wrote:
> On 9/30/2016 5:27 PM, Rafael J. Wysocki wrote:
> >>> >> What's the drawback, if any?
> >> >
> >> > I don't see any drawback to be honest.
> >
> > I'd go for it then, if Bjorn doesn't hate it.
>
> I posted a follow up patch a minute ago.
>
> [PATCH 1/3] Revert "ACPI,PCI,IRQ: reduce static IRQ array size to 16"
> [PATCH 2/3] ACPI, PCI IRQ: add PCI_USING penalty for ISA interrupts
> [PATCH 3/3] Revert "ACPI,PCI,IRQ: remove SCI penalize function"
>
> Can we have some testing coverage? and eventually have tested-by?

Works on two affected machines. More tests tomorrow.

-- 
Ondrej Zary

--Boundary-00=_/tT8Xd3aZvVQBBz
Content-Type: text/plain;
  charset="iso-8859-15";
  name="dmesg-ok_1.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg-ok_1.txt"

[    0.000000] Linux version 4.8.0-rc8+ (zary@gsql) (gcc version 4.7.2 (Debian 4.7.2-5) ) #134 SMP Sun Oct 2 15:13:50 CEST 2016
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
[    0.000000] free_area_init_node: node 0, pgdat c15b17a0, node_mem_map dfbfd020
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
      .data : 0xc13d3d85 - 0xc15bf1e0   (1965 kB)
      .text : 0xc1000000 - 0xc13d3d85   (3919 kB)
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
[    0.000000] tsc: Detected 1364.991 MHz processor
[    0.004006] Calibrating delay loop (skipped), value calculated using timer frequency.. 2729.98 BogoMIPS (lpj=5459964)
[    0.004013] pid_max: default: 32768 minimum: 301
[    0.004036] ACPI: Core revision 20160422
[    0.008494] ACPI: 1 ACPI AML tables successfully acquired and loaded

[    0.008506] ACPI: setting ELCR to 0200 (from 0e00)
[    0.008556] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.008559] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.009173] Last level iTLB entries: 4KB 32, 2MB 0, 4MB 2
[    0.009179] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 8, 1GB 0
[    0.012058] Freeing SMP alternatives memory: 16K (c1644000 - c1648000)
[    0.012318] smpboot: Max logical packages: 1
[    0.012323] smpboot: weird, boot CPU (#0) not listed by the BIOS
[    0.012325] smpboot: SMP motherboard not detected
[    0.012326] smpboot: SMP disabled
[    0.012329] smpboot: Local APIC not detected. Using dummy APIC emulation.
[    0.012333] Performance Events: 
[    0.012338] no APIC, boot with the "lapic" boot parameter to force-enable it.
[    0.012340] no hardware sampling interrupt available.
[    0.012344] p6 PMU driver.
[    0.012349] ... version:                0
[    0.012351] ... bit width:              32
[    0.012352] ... generic registers:      2
[    0.012354] ... value mask:             00000000ffffffff
[    0.012356] ... max period:             000000007fffffff
[    0.012357] ... fixed-purpose events:   0
[    0.012358] ... event mask:             0000000000000003
[    0.013112] x86: Booted up 1 node, 1 CPUs
[    0.013120] smpboot: Total of 1 processors activated (2729.98 BogoMIPS)
[    0.013436] devtmpfs: initialized
[    0.014122] PM: Registering ACPI NVS region [mem 0x1ffff000-0x1fffffff] (4096 bytes)
[    0.014257] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.014476] NET: Registered protocol family 16
[    0.014860] cpuidle: using governor ladder
[    0.014863] cpuidle: using governor menu
[    0.014996] Simple Boot Flag at 0x46 set to 0x1
[    0.015010] clocksource: pit: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1601818034827 ns
[    0.015023] ACPI: bus type PCI registered
[    0.018861] PCI: PCI BIOS revision 2.10 entry at 0xf0720, last bus=1
[    0.018864] PCI: Using configuration type 1 for base access
[    0.022143] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[    0.022484] ACPI: Added _OSI(Module Device)
[    0.022487] ACPI: Added _OSI(Processor Device)
[    0.022490] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.022493] ACPI: Added _OSI(Processor Aggregator Device)
[    0.024405] ACPI: Interpreter enabled
[    0.024460] ACPI: (supports S0 S1 S4 S5)
[    0.024463] ACPI: Using PIC for interrupt routing
[    0.024507] PCI: Ignoring host bridge windows from ACPI; if necessary, use "pci=use_crs" and report a bug
[    0.031373] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[    0.031545] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
[    0.031707] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
[    0.031868] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
[    0.032066] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.032077] acpi PNP0A03:00: _OSC: OS supports [Segments MSI]
[    0.032088] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.032097] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.032203] acpi PNP0A03:00: host bridge window [io  0x0cf8-0x0cff] (ignored)
[    0.032207] acpi PNP0A03:00: host bridge window [io  0x0000-0x0cf7 window] (ignored)
[    0.032211] acpi PNP0A03:00: host bridge window [io  0x0d00-0xffff window] (ignored)
[    0.032215] acpi PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff window] (ignored)
[    0.032218] acpi PNP0A03:00: host bridge window [mem 0x000c8000-0x000dffff window] (ignored)
[    0.032222] acpi PNP0A03:00: host bridge window [mem 0x20000000-0xfffdffff window] (ignored)
[    0.032224] PCI: root bus 00: using default resources
[    0.032330] PCI host bridge to bus 0000:00
[    0.032335] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.032339] pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffff]
[    0.032344] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.032364] pci 0000:00:00.0: [8086:7190] type 00 class 0x060000
[    0.032377] pci 0000:00:00.0: reg 0x10: [mem 0xe4000000-0xe7ffffff pref]
[    0.032540] pci 0000:00:01.0: [8086:7191] type 01 class 0x060400
[    0.032670] pci 0000:00:04.0: [8086:7110] type 00 class 0x060100
[    0.032850] pci 0000:00:04.1: [8086:7111] type 00 class 0x010180
[    0.032891] pci 0000:00:04.1: reg 0x20: [io  0xb800-0xb80f]
[    0.032911] pci 0000:00:04.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.032915] pci 0000:00:04.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.032918] pci 0000:00:04.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.032922] pci 0000:00:04.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.033037] pci 0000:00:04.2: [8086:7112] type 00 class 0x0c0300
[    0.033078] pci 0000:00:04.2: reg 0x20: [io  0xb400-0xb41f]
[    0.033152] pci 0000:00:04.2: System wakeup disabled by ACPI
[    0.033242] pci 0000:00:04.3: [8086:7113] type 00 class 0x068000
[    0.033247] * Found PM-Timer Bug on the chipset. Due to workarounds for a bug,
* this clock source is slow. Consider trying other clock sources
[    0.033312] pci 0000:00:04.3: quirk: [io  0xe400-0xe43f] claimed by PIIX4 ACPI
[    0.033317] pci 0000:00:04.3: quirk: [io  0xe800-0xe80f] claimed by PIIX4 SMB
[    0.033323] pci 0000:00:04.3: PIIX4 devres B PIO at 0290-0297
[    0.033458] pci 0000:00:09.0: [10b7:9001] type 00 class 0x020000
[    0.033472] pci 0000:00:09.0: reg 0x10: [io  0xb000-0xb03f]
[    0.033510] pci 0000:00:09.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    0.033630] pci 0000:00:0a.0: [10cd:1300] type 00 class 0x010000
[    0.033643] pci 0000:00:0a.0: reg 0x10: [io  0xa800-0xa8ff]
[    0.033653] pci 0000:00:0a.0: reg 0x14: [mem 0xd6000000-0xd60000ff]
[    0.033684] pci 0000:00:0a.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    0.033792] pci 0000:00:0b.0: [109e:0350] type 00 class 0x040000
[    0.033805] pci 0000:00:0b.0: reg 0x10: [mem 0xd7000000-0xd7000fff pref]
[    0.034019] pci 0000:01:00.0: [1002:514d] type 00 class 0x030000
[    0.034034] pci 0000:01:00.0: reg 0x10: [mem 0xd8000000-0xdfffffff pref]
[    0.034043] pci 0000:01:00.0: reg 0x14: [io  0xd800-0xd8ff]
[    0.034052] pci 0000:01:00.0: reg 0x18: [mem 0xd6800000-0xd680ffff]
[    0.034074] pci 0000:01:00.0: reg 0x30: [mem 0xd7fe0000-0xd7ffffff pref]
[    0.034105] pci 0000:01:00.0: supports D1 D2
[    0.034202] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.034208] pci 0000:00:01.0:   bridge window [io  0xd000-0xdfff]
[    0.034213] pci 0000:00:01.0:   bridge window [mem 0xd6800000-0xd6ffffff]
[    0.034218] pci 0000:00:01.0:   bridge window [mem 0xd7f00000-0xe3ffffff pref]
[    0.034227] pci_bus 0000:00: on NUMA node 0
[    0.037220] vgaarb: setting as boot device: PCI:0000:01:00.0
[    0.037225] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.037226] vgaarb: loaded
[    0.037229] vgaarb: bridge control possible 0000:01:00.0
[    0.037399] SCSI subsystem initialized
[    0.037513] libata version 3.00 loaded.
[    0.037524] ACPI: bus type USB registered
[    0.037582] usbcore: registered new interface driver usbfs
[    0.037615] usbcore: registered new interface driver hub
[    0.037646] usbcore: registered new device driver usb
[    0.037710] PCI: Using ACPI for IRQ routing
[    0.037717] PCI: pci_cache_line_size set to 32 bytes
[    0.037752] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.037756] e820: reserve RAM buffer [mem 0x1fffd000-0x1fffffff]
[    0.038499] clocksource: Switched to clocksource pit
[    0.052124] pnp: PnP ACPI init
[    0.052486] system 00:00: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.052495] system 00:00: [mem 0x000f0000-0x000fffff] could not be reserved
[    0.052500] system 00:00: [mem 0x00100000-0x1fffffff] could not be reserved
[    0.052505] system 00:00: [mem 0xfffe0000-0xffffffff] could not be reserved
[    0.052515] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.053089] system 00:01: [io  0xe400-0xe43f] has been reserved
[    0.053095] system 00:01: [io  0xe800-0xe80f] has been reserved
[    0.053099] system 00:01: [io  0x0294-0x0297] has been reserved
[    0.053104] system 00:01: [io  0x03f0-0x03f1] has been reserved
[    0.053108] system 00:01: [io  0x04d0-0x04d1] has been reserved
[    0.053115] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.053193] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.053713] pnp 00:03: [dma 2]
[    0.053799] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.054648] pnp 00:04: [dma 3]
[    0.054749] pnp 00:04: Plug and Play ACPI device, IDs PNP0401 (active)
[    0.055356] pnp 00:05: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.056071] pnp 00:06: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.056548] pnp 00:07: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.056566] pnp: PnP ACPI: found 8 devices
[    0.056573] PnPBIOS: Disabled
[    0.095395] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.095436] clocksource: Switched to clocksource acpi_pm
[    0.095479] pci 0000:00:09.0: BAR 6: assigned [mem 0x20000000-0x2000ffff pref]
[    0.095487] pci 0000:00:0a.0: BAR 6: assigned [mem 0x20010000-0x2001ffff pref]
[    0.095495] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.095499] pci 0000:00:01.0:   bridge window [io  0xd000-0xdfff]
[    0.095506] pci 0000:00:01.0:   bridge window [mem 0xd6800000-0xd6ffffff]
[    0.095511] pci 0000:00:01.0:   bridge window [mem 0xd7f00000-0xe3ffffff pref]
[    0.095520] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
[    0.095524] pci_bus 0000:00: resource 5 [mem 0x00000000-0xffffffff]
[    0.095528] pci_bus 0000:01: resource 0 [io  0xd000-0xdfff]
[    0.095531] pci_bus 0000:01: resource 1 [mem 0xd6800000-0xd6ffffff]
[    0.095535] pci_bus 0000:01: resource 2 [mem 0xd7f00000-0xe3ffffff pref]
[    0.095616] NET: Registered protocol family 2
[    0.095999] TCP established hash table entries: 4096 (order: 2, 16384 bytes)
[    0.096054] TCP bind hash table entries: 4096 (order: 3, 32768 bytes)
[    0.096138] TCP: Hash tables configured (established 4096 bind 4096)
[    0.096217] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    0.096242] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    0.096390] NET: Registered protocol family 1
[    0.096426] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    0.097067] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
[    0.097071] PCI: setting IRQ 9 as level-triggered
[    0.097208] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.097212] PCI: CLS 32 bytes, default 32
[    0.098386] futex hash table entries: 256 (order: 1, 8192 bytes)
[    0.099192] workingset: timestamp_bits=30 max_order=17 bucket_order=0
[    0.106256] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.106263] io scheduler noop registered
[    0.106264] io scheduler deadline registered
[    0.106339] io scheduler cfq registered (default)
[    0.106886] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.106895] ACPI: Power Button [PWRB]
[    0.107042] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.107046] ACPI: Power Button [PWRF]
[    0.107141] tsc: Marking TSC unstable due to TSC halts in idle
[    0.107237] Warning: Processor Platform Limit event detected, but not handled.
[    0.107239] Consider compiling CPUfreq support into your kernel.
[    0.107674] isapnp: Scanning for PnP cards...
[    0.230293] pnp 01:01.00: increased option port range from 0x388-0x388 to 0x388-0x3f8
[    0.230298] pnp 01:01.00: increased option port range from 0x388-0x388 to 0x388-0x3f8
[    0.230303] pnp 01:01.00: increased option port range from 0x388-0x388 to 0x388-0x3f8
[    0.230390] pnp 01:01.02: added ioport region 0xe20-0xe20 to set 0
[    0.230395] pnp 01:01.02: added ioport region 0xa20-0xa20 to set 0
[    0.230398] pnp 01:01.02: added ioport region 0xe20-0xe80 to set 1
[    0.230402] pnp 01:01.02: added ioport region 0xa20-0xa80 to set 1
[    0.230463]  01:01: card 'Creative SB AWE64  PnP'
[    0.230465] isapnp: 1 Plug & Play card detected total
[    0.230595] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.251149] 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.271811] serial8250: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    0.292313] serial8250: ttyS2 at I/O 0x3e8 (irq = 4, base_baud = 115200) is a 16550A
[    0.312812] serial8250: ttyS3 at I/O 0x2e8 (irq = 3, base_baud = 115200) is a 16550A
[    0.313216] Non-volatile memory driver v1.3
[    0.313219] Linux agpgart interface v0.103
[    0.313275] [drm] Initialized drm 1.1.0 20060810
[    0.318637] loop: module loaded
[    0.318772] ata_piix 0000:00:04.1: version 2.13
[    0.319764] scsi host0: ata_piix
[    0.320120] scsi host1: ata_piix
[    0.320254] ata1: PATA max UDMA/33 cmd 0x1f0 ctl 0x3f6 bmdma 0xb800 irq 14
[    0.320259] ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xb808 irq 15
[    0.320512] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.320514] ehci-pci: EHCI PCI platform driver
[    0.320540] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.320559] ohci-pci: OHCI PCI platform driver
[    0.320584] uhci_hcd: USB Universal Host Controller Interface driver
[    0.320776] uhci_hcd 0000:00:04.2: UHCI Host Controller
[    0.320792] uhci_hcd 0000:00:04.2: new USB bus registered, assigned bus number 1
[    0.320834] uhci_hcd 0000:00:04.2: irq 9, io base 0x0000b400
[    0.321565] hub 1-0:1.0: USB hub found
[    0.321585] hub 1-0:1.0: 2 ports detected
[    0.321966] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    0.325068] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.325081] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.325433] mousedev: PS/2 mouse device common for all mice
[    0.325856] rtc_cmos 00:02: RTC can wake from S4
[    0.326052] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
[    0.326079] rtc_cmos 00:02: alarms up to one month, 242 bytes nvram
[    0.326471] NET: Registered protocol family 17
[    0.326630] Using IPI No-Shortcut mode
[    0.326936] registered taskstats version 1
[    0.327367] console [netcon0] enabled
[    0.327369] netconsole: network logging started
[    0.327416] rtc_cmos 00:02: setting system clock to 2016-10-02 15:16:15 UTC (1475421375)
[    0.327487] PM: Hibernation image not present or could not be loaded.
[    0.354265] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input2
[    0.482750] ata1.00: ATA-7: SAMSUNG SP1213N, TL100-24, max UDMA/100
[    0.482755] ata1.00: 234493056 sectors, multi 16: LBA48 
[    0.485533] ata1.00: configured for UDMA/33
[    0.485850] scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG SP1213N  0-24 PQ: 0 ANSI: 5
[    0.486505] sd 0:0:0:0: [sda] 234493056 512-byte logical blocks: (120 GB/112 GiB)
[    0.486654] sd 0:0:0:0: [sda] Write Protect is off
[    0.486659] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.487125] ata2.00: ATAPI: TOSHIBA DVD-ROM SD-M1212, 1R22, max UDMA/33
[    0.487137] ata2.01: ATAPI: ATAPI   COMBO48XMAX, VER 1.50, max UDMA/100
[    0.487255] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    0.492098] ata2.00: configured for UDMA/33
[    0.496710] ata2.01: configured for UDMA/33
[    0.501211] scsi 1:0:0:0: CD-ROM            TOSHIBA  DVD-ROM SD-M1212 1R22 PQ: 0 ANSI: 5
[    0.514120] scsi 1:0:1:0: CD-ROM            ATAPI    COMBO48XMAX      1.50 PQ: 0 ANSI: 5
[    0.524720]  sda: sda1 sda2 sda3
[    0.525610] sd 0:0:0:0: [sda] Attached SCSI disk
[    0.965029] random: fast init done
[    1.120052] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x13acf08ea1e, max_idle_ns: 440795203578 ns
[    1.937476] input: ImPS/2 BYD TouchPad as /devices/platform/i8042/serio1/input/input4
[    1.953069] EXT4-fs (sda3): mounting ext3 file system using the ext4 subsystem
[    1.973542] EXT4-fs (sda3): mounted filesystem with ordered data mode. Opts: (null)
[    1.973574] VFS: Mounted root (ext3 filesystem) readonly on device 8:3.
[    1.975293] Freeing unused kernel memory: 524K (c15c1000 - c1644000)
[    1.975525] Write protecting the kernel text: 3920k
[    1.975591] Write protecting the kernel read-only data: 1528k
[    4.330634] systemd-udevd[194]: starting version 215
[    6.040241] random: crng init done
[    7.495659] Adding 1048572k swap on /dev/sda2.  Priority:-1 extents:1 across:1048572k 
[    7.570604] EXT4-fs (sda3): re-mounted. Opts: (null)
[    8.040509] EXT4-fs (sda3): re-mounted. Opts: errors=remount-ro


--Boundary-00=_/tT8Xd3aZvVQBBz
Content-Type: text/plain;
  charset="iso-8859-15";
  name="dmesg-ok_2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg-ok_2.txt"

[    0.000000] Linux version 4.8.0-rc8+ (zary@gsql) (gcc version 4.7.2 (Debian 4.7.2-5) ) #134 SMP Sun Oct 2 15:13:50 CEST 2016
[    0.000000] x86/fpu: Legacy x87 FPU detected.
[    0.000000] x86/fpu: Using 'eager' FPU context switches.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001ffeffff] usable
[    0.000000] BIOS-e820: [mem 0x000000001fff0000-0x000000001fff2fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000001fff3000-0x000000001fffffff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000ffff0000-0x00000000ffffffff] reserved
[    0.000000] Notice: NX (Execute Disable) protection missing in CPU!
[    0.000000] SMBIOS 2.2 present.
[    0.000000] DMI: VIA Technologies, Inc. VT82C694X/694X, BIOS 6.00 PG 02/19/2002
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x1fff0 max_arch_pfn = 0x100000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-AFFFF uncachable
[    0.000000]   B0000-BFFFF write-combining
[    0.000000]   C0000-C9FFF write-protect
[    0.000000]   CA000-EFFFF uncachable
[    0.000000]   F0000-F7FFF write-through
[    0.000000]   F8000-F8FFF uncachable
[    0.000000]   F9000-FFFFF write-through
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask FE0000000 write-back
[    0.000000]   1 base 0E0000000 mask FFC000000 write-combining
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
[    0.000000] ACPI: RSDP 0x00000000000F6C00 000014 (v00 VIA694)
[    0.000000] ACPI: RSDT 0x000000001FFF3000 000028 (v01 VIA694 AWRDACPI 42302E31 AWRD 00000000)
[    0.000000] ACPI: FACP 0x000000001FFF3040 000074 (v01 VIA694 AWRDACPI 42302E31 AWRD 00000000)
[    0.000000] ACPI: DSDT 0x000000001FFF30C0 002587 (v01 VIA694 AWRDACPI 00001000 MSFT 0100000C)
[    0.000000] ACPI: FACS 0x000000001FFF0000 000040
[    0.000000] 0MB HIGHMEM available.
[    0.000000] 511MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 1fff0000
[    0.000000]   low ram: 0 - 1fff0000
[    0.000000] BRK [0x016b8000, 0x016b8fff] PGTABLE
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   Normal   [mem 0x0000000001000000-0x000000001ffeffff]
[    0.000000]   HighMem  empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000001ffeffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000001ffeffff]
[    0.000000] On node 0 totalpages: 130958
[    0.000000] free_area_init_node: node 0, pgdat c15b17a0, node_mem_map dfbf0020
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
[    0.000000]   Normal zone: 992 pages used for memmap
[    0.000000]   Normal zone: 126960 pages, LIFO batch:31
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
[    0.000000] e820: [mem 0x20000000-0xfffeffff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:1 nr_node_ids:1
[    0.000000] percpu: Embedded 19 pages/cpu @dfbd9000 s47980 r0 d29844 u77824
[    0.000000] pcpu-alloc: s47980 r0 d29844 u77824 alloc=19*4096
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 129934
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-test root=/dev/sda1 ro resume=/dev/sda2
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Initializing CPU#0
[    0.000000] Initializing HighMem for node 0 (00000000:00000000)
[    0.000000] Memory: 512284K/523832K available (3918K kernel code, 436K rwdata, 1520K rodata, 524K init, 412K bss, 11548K reserved, 0K cma-reserved, 0K highmem)
[    0.000000] virtual kernel memory layout:
    fixmap  : 0xfff17000 - 0xfffff000   ( 928 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xe07f0000 - 0xff7fe000   ( 496 MB)
    lowmem  : 0xc0000000 - 0xdfff0000   ( 511 MB)
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
[    0.000000] CPU 0 irqstacks, hard=df41c000 soft=df41e000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 1199.302 MHz processor
[    0.008010] Calibrating delay loop (skipped), value calculated using timer frequency.. 2398.60 BogoMIPS (lpj=4797208)
[    0.008106] pid_max: default: 32768 minimum: 301
[    0.008178] ACPI: Core revision 20160422
[    0.013522] ACPI: 1 ACPI AML tables successfully acquired and loaded

[    0.013664] ACPI: setting ELCR to 0800 (from 0e00)
[    0.013778] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.013825] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.014667] Last level iTLB entries: 4KB 32, 2MB 0, 4MB 2
[    0.014735] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 8, 1GB 0
[    0.018354] Freeing SMP alternatives memory: 16K (c1644000 - c1648000)
[    0.020477] smpboot: Max logical packages: 1
[    0.020536] smpboot: weird, boot CPU (#0) not listed by the BIOS
[    0.020580] smpboot: SMP motherboard not detected
[    0.020622] smpboot: SMP disabled
[    0.020669] smpboot: Local APIC not detected. Using dummy APIC emulation.
[    0.020716] Performance Events: 
[    0.020763] no APIC, boot with the "lapic" boot parameter to force-enable it.
[    0.020844] no hardware sampling interrupt available.
[    0.020895] p6 PMU driver.
[    0.020942] ... version:                0
[    0.020987] ... bit width:              32
[    0.021029] ... generic registers:      2
[    0.021071] ... value mask:             00000000ffffffff
[    0.021115] ... max period:             000000007fffffff
[    0.021159] ... fixed-purpose events:   0
[    0.021201] ... event mask:             0000000000000003
[    0.022250] x86: Booted up 1 node, 1 CPUs
[    0.022320] smpboot: Total of 1 processors activated (2398.60 BogoMIPS)
[    0.022862] devtmpfs: initialized
[    0.024395] PM: Registering ACPI NVS region [mem 0x1fff0000-0x1fff2fff] (12288 bytes)
[    0.024647] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.024978] NET: Registered protocol family 16
[    0.025462] cpuidle: using governor ladder
[    0.025512] cpuidle: using governor menu
[    0.025665] clocksource: pit: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1601818034827 ns
[    0.025729] ACPI: bus type PCI registered
[    0.068902] PCI: PCI BIOS revision 2.10 entry at 0xfb200, last bus=1
[    0.068953] PCI: Using configuration type 1 for base access
[    0.072801] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[    0.073293] ACPI: Added _OSI(Module Device)
[    0.073344] ACPI: Added _OSI(Processor Device)
[    0.073389] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.073433] ACPI: Added _OSI(Processor Aggregator Device)
[    0.077984] ACPI: Interpreter enabled
[    0.078106] ACPI: (supports S0 S1 S4 S5)
[    0.078152] ACPI: Using PIC for interrupt routing
[    0.078252] PCI: Ignoring host bridge windows from ACPI; if necessary, use "pci=use_crs" and report a bug
[    0.085771] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.085850] acpi PNP0A03:00: _OSC: OS supports [Segments MSI]
[    0.085907] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.085964] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.086137] acpi PNP0A03:00: host bridge window [io  0x0cf8-0x0cff] (ignored)
[    0.086141] acpi PNP0A03:00: host bridge window [io  0x0000-0x0cf7 window] (ignored)
[    0.086146] acpi PNP0A03:00: host bridge window [io  0x0d00-0x3fff window] (ignored)
[    0.086149] acpi PNP0A03:00: host bridge window [io  0x4000-0x407f] (ignored)
[    0.086153] acpi PNP0A03:00: host bridge window [io  0x4080-0x40ff] (ignored)
[    0.086157] acpi PNP0A03:00: host bridge window [io  0x4100-0x4fff window] (ignored)
[    0.086161] acpi PNP0A03:00: host bridge window [io  0x5000-0x500f] (ignored)
[    0.086165] acpi PNP0A03:00: host bridge window [io  0x5010-0x5fff window] (ignored)
[    0.086169] acpi PNP0A03:00: host bridge window [io  0x6000-0x607f] (ignored)
[    0.086173] acpi PNP0A03:00: host bridge window [io  0x6080-0xffff window] (ignored)
[    0.086178] acpi PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff window] (ignored)
[    0.086182] acpi PNP0A03:00: host bridge window [mem 0x000c0000-0x000dffff window] (ignored)
[    0.086186] acpi PNP0A03:00: host bridge window [mem 0x20000000-0xffefffff window] (ignored)
[    0.086190] PCI: root bus 00: using default resources
[    0.086307] PCI host bridge to bus 0000:00
[    0.086356] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.086403] pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffff]
[    0.086451] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.086519] pci 0000:00:00.0: [1106:0691] type 00 class 0x060000
[    0.086540] pci 0000:00:00.0: reg 0x10: [mem 0xe0000000-0xe3ffffff pref]
[    0.086788] pci 0000:00:01.0: [1106:8598] type 01 class 0x060400
[    0.086838] pci 0000:00:01.0: supports D1
[    0.086984] pci 0000:00:07.0: [1106:0686] type 00 class 0x060100
[    0.087249] pci 0000:00:07.1: [1106:0571] type 00 class 0x01018a
[    0.087293] pci 0000:00:07.1: reg 0x20: [io  0xd000-0xd00f]
[    0.087314] pci 0000:00:07.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.087364] pci 0000:00:07.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.087416] pci 0000:00:07.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.087462] pci 0000:00:07.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.087685] pci 0000:00:07.2: [1106:3038] type 00 class 0x0c0300
[    0.087726] pci 0000:00:07.2: reg 0x20: [io  0xd400-0xd41f]
[    0.087852] pci 0000:00:07.2: System wakeup disabled by ACPI
[    0.088086] pci 0000:00:07.3: [1106:3038] type 00 class 0x0c0300
[    0.088128] pci 0000:00:07.3: reg 0x20: [io  0xd800-0xd81f]
[    0.088261] pci 0000:00:07.3: System wakeup disabled by ACPI
[    0.088426] pci 0000:00:07.4: [1106:3057] type 00 class 0x068000
[    0.088488] pci 0000:00:07.4: quirk: [io  0x6000-0x607f] claimed by vt82c686 HW-mon
[    0.088541] pci 0000:00:07.4: quirk: [io  0x5000-0x500f] claimed by vt82c686 SMB
[    0.088766] pci 0000:00:07.5: [1106:3058] type 00 class 0x040100
[    0.088783] pci 0000:00:07.5: reg 0x10: [io  0xdc00-0xdcff]
[    0.088794] pci 0000:00:07.5: reg 0x14: [io  0xe000-0xe003]
[    0.088805] pci 0000:00:07.5: reg 0x18: [io  0xe400-0xe403]
[    0.089033] pci 0000:00:0f.0: [10ec:8139] type 00 class 0x020000
[    0.089050] pci 0000:00:0f.0: reg 0x10: [io  0xe800-0xe8ff]
[    0.089061] pci 0000:00:0f.0: reg 0x14: [mem 0xe8000000-0xe80000ff]
[    0.089124] pci 0000:00:0f.0: supports D1 D2
[    0.089130] pci 0000:00:0f.0: PME# supported from D1 D2 D3hot
[    0.089375] pci 0000:01:00.0: [10de:002d] type 00 class 0x030000
[    0.089391] pci 0000:01:00.0: reg 0x10: [mem 0xe6000000-0xe6ffffff]
[    0.089402] pci 0000:01:00.0: reg 0x14: [mem 0xe4000000-0xe5ffffff pref]
[    0.089435] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    0.089577] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.089633] pci 0000:00:01.0:   bridge window [mem 0xe6000000-0xe7ffffff]
[    0.089640] pci 0000:00:01.0:   bridge window [mem 0xe4000000-0xe5ffffff pref]
[    0.089651] pci_bus 0000:00: on NUMA node 0
[    0.090036] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
[    0.090746] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[    0.091577] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
[    0.092409] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *9
[    0.094837] vgaarb: setting as boot device: PCI:0000:01:00.0
[    0.094895] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.094942] vgaarb: loaded
[    0.094985] vgaarb: bridge control possible 0000:01:00.0
[    0.095253] SCSI subsystem initialized
[    0.095453] libata version 3.00 loaded.
[    0.095468] ACPI: bus type USB registered
[    0.095590] usbcore: registered new interface driver usbfs
[    0.095667] usbcore: registered new interface driver hub
[    0.095747] usbcore: registered new device driver usb
[    0.095868] PCI: Using ACPI for IRQ routing
[    0.095921] PCI: pci_cache_line_size set to 32 bytes
[    0.095966] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.096029] e820: reserve RAM buffer [mem 0x1fff0000-0x1fffffff]
[    0.097006] clocksource: Switched to clocksource pit
[    0.116750] pnp: PnP ACPI init
[    0.117657] system 00:00: [mem 0x000ca800-0x000cbfff] has been reserved
[    0.117723] system 00:00: [mem 0x000f0000-0x000f7fff] could not be reserved
[    0.117771] system 00:00: [mem 0x000f8000-0x000fbfff] could not be reserved
[    0.117825] system 00:00: [mem 0x000fc000-0x000fffff] could not be reserved
[    0.117873] system 00:00: [mem 0x1fff0000-0x1fffffff] could not be reserved
[    0.117923] system 00:00: [mem 0xffff0000-0xffffffff] has been reserved
[    0.117971] system 00:00: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.118019] system 00:00: [mem 0x00100000-0x1ffeffff] could not be reserved
[    0.118068] system 00:00: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.118126] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.118583] system 00:01: [io  0x04d0-0x04d1] has been reserved
[    0.118639] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.118734] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.119136] pnp 00:03: [dma 2]
[    0.119260] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.120233] pnp 00:04: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.120346] pnp 00:05: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.120399] pnp: PnP ACPI: found 6 devices
[    0.120458] PnPBIOS: Disabled
[    0.160174] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.161435] clocksource: Switched to clocksource acpi_pm
[    0.161548] pci 0000:01:00.0: BAR 6: assigned [mem 0xe7000000-0xe700ffff pref]
[    0.161604] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.161658] pci 0000:00:01.0:   bridge window [mem 0xe6000000-0xe7ffffff]
[    0.161711] pci 0000:00:01.0:   bridge window [mem 0xe4000000-0xe5ffffff pref]
[    0.161768] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
[    0.161772] pci_bus 0000:00: resource 5 [mem 0x00000000-0xffffffff]
[    0.161777] pci_bus 0000:01: resource 1 [mem 0xe6000000-0xe7ffffff]
[    0.161781] pci_bus 0000:01: resource 2 [mem 0xe4000000-0xe5ffffff pref]
[    0.161890] NET: Registered protocol family 2
[    0.162457] TCP established hash table entries: 4096 (order: 2, 16384 bytes)
[    0.162577] TCP bind hash table entries: 4096 (order: 3, 32768 bytes)
[    0.162738] TCP: Hash tables configured (established 4096 bind 4096)
[    0.162871] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    0.162950] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    0.163346] NET: Registered protocol family 1
[    0.163464] pci 0000:00:01.0: disabling DAC on VIA PCI bridge
[    0.163517] pci 0000:00:07.0: Disabling VIA external APIC routing
[    0.164679] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
[    0.164732] PCI: setting IRQ 11 as level-triggered
[    0.164745] pci 0000:00:07.2: VIA VLink IRQ fixup, from 9 to 11
[    0.165145] pci 0000:00:07.3: VIA VLink IRQ fixup, from 9 to 11
[    0.165391] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.165443] PCI: CLS 32 bytes, default 32
[    0.166834] futex hash table entries: 256 (order: 1, 8192 bytes)
[    0.167921] workingset: timestamp_bits=30 max_order=17 bucket_order=0
[    0.176497] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.176577] io scheduler noop registered
[    0.176620] io scheduler deadline registered
[    0.176775] io scheduler cfq registered (default)
[    0.177500] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.177569] ACPI: Power Button [PWRB]
[    0.177781] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1
[    0.177833] ACPI: Sleep Button [SLPB]
[    0.178026] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    0.178077] ACPI: Power Button [PWRF]
[    0.178267] tsc: Marking TSC unstable due to TSC halts in idle
[    0.178443] Warning: Processor Platform Limit event detected, but not handled.
[    0.178491] Consider compiling CPUfreq support into your kernel.
[    0.179147] isapnp: Scanning for PnP cards...
[    0.265720]  01:01: card 'SYM 53C416'
[    0.265771] isapnp: 1 Plug & Play card detected total
[    0.266000] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.267282] Non-volatile memory driver v1.3
[    0.267337] Linux agpgart interface v0.103
[    0.267449] [drm] Initialized drm 1.1.0 20060810
[    0.275252] loop: module loaded
[    0.275612] pata_via 0000:00:07.1: version 0.3.4
[    0.276981] scsi host0: pata_via
[    0.277399] scsi host1: pata_via
[    0.277607] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xd000 irq 14
[    0.277657] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xd008 irq 15
[    0.277880] 8139cp: 8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
[    0.277934] 8139cp 0000:00:0f.0: This (id 10ec:8139 rev 10) is not an 8139C+ compatible chip, use 8139too
[    0.278045] 8139too: 8139too Fast Ethernet driver 0.9.28
[    0.279121] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
[    0.279880] 8139too 0000:00:0f.0 eth0: RealTek RTL8139 at 0x0001e800, 00:40:95:30:81:14, IRQ 11
[    0.279987] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.280140] ehci-pci: EHCI PCI platform driver
[    0.280563] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.280640] ohci-pci: OHCI PCI platform driver
[    0.280710] uhci_hcd: USB Universal Host Controller Interface driver
[    0.281056] uhci_hcd 0000:00:07.2: UHCI Host Controller
[    0.281121] uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
[    0.281224] uhci_hcd 0000:00:07.2: irq 11, io base 0x0000d400
[    0.281894] hub 1-0:1.0: USB hub found
[    0.281962] hub 1-0:1.0: 2 ports detected
[    0.282552] uhci_hcd 0000:00:07.3: UHCI Host Controller
[    0.282624] uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
[    0.282711] uhci_hcd 0000:00:07.3: irq 11, io base 0x0000d800
[    0.283324] hub 2-0:1.0: USB hub found
[    0.283391] hub 2-0:1.0: 2 ports detected
[    0.283866] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    0.284574] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.284635] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.285112] mousedev: PS/2 mouse device common for all mice
[    0.286079] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
[    0.286175] rtc_cmos 00:02: alarms up to one year, y3k, 242 bytes nvram
[    0.286711] NET: Registered protocol family 17
[    0.286917] Using IPI No-Shortcut mode
[    0.287364] registered taskstats version 1
[    0.288164] console [netcon0] enabled
[    0.288219] netconsole: network logging started
[    0.288329] rtc_cmos 00:02: setting system clock to 2016-10-02 16:42:42 UTC (1475426562)
[    0.288480] PM: Checking hibernation image partition /dev/sda2
[    0.312766] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input3
[    0.502851] ata1.00: ATA-6: WDC WD800JB-00FMA0, 13.03G13, max UDMA/100
[    0.502913] ata1.00: 156301488 sectors, multi 16: LBA 
[    0.505835] ata1.00: configured for UDMA/100
[    0.506357] scsi 0:0:0:0: Direct-Access     ATA      WDC WD800JB-00FM 3G13 PQ: 0 ANSI: 5
[    0.507371] sd 0:0:0:0: [sda] 156301488 512-byte logical blocks: (80.0 GB/74.5 GiB)
[    0.507588] sd 0:0:0:0: [sda] Write Protect is off
[    0.507637] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.507695] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    0.552887]  sda: sda1 sda2 sda3
[    0.554010] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.184052] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1149885dbc2, max_idle_ns: 440795234021 ns
[    1.234626] random: fast init done
[    1.744896] input: PS/2 BYD TouchPad as /devices/platform/i8042/serio1/input/input5
[    1.747848] PM: Hibernation image partition 8:2 present
[    1.747851] PM: Looking for hibernation image.
[    1.748397] PM: Image not found (code -22)
[    1.748401] PM: Hibernation image not present or could not be loaded.
[    1.749007] EXT4-fs (sda1): mounting ext3 file system using the ext4 subsystem
[    1.797056] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[    1.797177] VFS: Mounted root (ext3 filesystem) readonly on device 8:1.
[    1.798673] Freeing unused kernel memory: 524K (c15c1000 - c1644000)
[    1.799028] Write protecting the kernel text: 3920k
[    1.799154] Write protecting the kernel read-only data: 1528k
[    4.728859] random: crng init done
[    4.964730] systemd-udevd[179]: starting version 215
[    6.772151] agpgart: Detected VIA Apollo Pro 133 chipset
[    6.786507] agpgart-via 0000:00:00.0: AGP aperture is 64M @ 0xe0000000
[    6.983848] sg: loading out-of-tree module taints kernel.
[    6.985410] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    7.013467] parport_pc: VIA 686A/8231 detected
[    7.013475] parport_pc: probing current configuration
[    7.013494] parport_pc: Current parallel port base: 0x0
[    7.013498] parport_pc: VIA parallel port disabled in BIOS
[    7.351838] wmi: Mapper loaded
[    7.832874] nouveau 0000:01:00.0: NVIDIA NV05 (20154000)
[    7.856647] nouveau 0000:01:00.0: bios: version 02.05.20.02.00
[    7.870232] nouveau 0000:01:00.0: bios: DCB table not found
[    7.870772] nouveau 0000:01:00.0: bios: DCB table not found
[    7.871004] nouveau 0000:01:00.0: bios: DCB table not found
[    7.871025] nouveau 0000:01:00.0: bios: DCB table not found
[    7.871075] nouveau 0000:01:00.0: bios: DCB table not found
[    7.872682] agpgart-via 0000:00:00.0: AGP 2.0 bridge
[    7.872734] agpgart-via 0000:00:00.0: putting AGP V2 device into 4x mode
[    7.872778] nouveau 0000:01:00.0: putting AGP V2 device into 4x mode
[    7.872834] nouveau 0000:01:00.0: tmr: unknown input clock freq
[    7.878604] nouveau 0000:01:00.0: fb: 32 MiB SDRAM
[    7.894677] [TTM] Zone  kernel: Available graphics memory: 256412 kiB
[    7.894742] [TTM] Initializing pool allocator
[    7.895252] nouveau 0000:01:00.0: DRM: VRAM: 31 MiB
[    7.895317] nouveau 0000:01:00.0: DRM: GART: 64 MiB
[    7.895369] nouveau 0000:01:00.0: DRM: BMP version 5.6
[    7.895417] nouveau 0000:01:00.0: DRM: No DCB data found in VBIOS
[    7.899535] nouveau 0000:01:00.0: DRM: Saving VGA fonts
[    7.953779] nouveau 0000:01:00.0: DRM: No DCB data found in VBIOS
[    7.954990] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    7.955047] [drm] Driver supports precise vblank timestamp query.
[    7.960510] nouveau 0000:01:00.0: DRM: MM: using M2MF for buffer copies
[    7.994137] nouveau 0000:01:00.0: DRM: allocated 1280x1024 fb: 0x4000, bo de65a000
[    7.994693] fbcon: nouveaufb (fb0) is primary device
[    8.255543] Console: switching to colour frame buffer device 160x64
[    8.267605] nouveau 0000:01:00.0: fb0: nouveaufb frame buffer device
[    8.267653] [drm] Initialized nouveau 1.3.1 20120801 for 0000:01:00.0 on minor 0
[    9.684799] EXT4-fs (sda1): re-mounted. Opts: (null)
[   10.353918] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
[   11.987035] i2c /dev entries driver
[   17.344370] 8139too 0000:00:0f.0 eth0: link up, 10Mbps, half-duplex, lpa 0x0000

--Boundary-00=_/tT8Xd3aZvVQBBz--
