Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-1b.atlantis.sk ([80.94.52.26]:32880 "EHLO
        smtp-1b.atlantis.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932299AbcI1TYC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Sep 2016 15:24:02 -0400
From: Ondrej Zary <linux@rainbow-software.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: 4.7 regression: ACPI: No IRQ available for PCI Interrupt Link [LNKD]. Try pci=noacpi or acpi=off
Date: Wed, 28 Sep 2016 21:23:47 +0200
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <201609251512.05657.linux@rainbow-software.org> <201609281902.31500.linux@rainbow-software.org> <76303bb8-7ae2-9a6b-8e5d-a144ae7c6009@codeaurora.org>
In-Reply-To: <76303bb8-7ae2-9a6b-8e5d-a144ae7c6009@codeaurora.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_EjB7X0yvjoJ7V1z"
Message-Id: <201609282123.48506.linux@rainbow-software.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Boundary-00=_EjB7X0yvjoJ7V1z
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 28 September 2016 20:22:40 Sinan Kaya wrote:
> On 9/28/2016 1:02 PM, Ondrej Zary wrote:
> >> Thanks, It sounds like you have more than one machine with similar
> >>
> >> > problems. Can you collect the log from the other machines with
> >> > 4.8-rc8?
> >> >
> >> > and also a boot log with 4.6 kernel where things are working?
> >
> > The attached logs are from another machine:
> >
> > dmesg-bad-debug.txt: 4.8-rc8 with your debug patch - bad
> >
> > dmesg-reverted.txt: 4.8-rc8 with patches (as per Rafael's suggestion)
> > reverted - good
> >
> > dmesg-3.6.txt: 4.6 (Debian kernel) - good
>
> I think I see a race condition for the SCI interrupt. I need another dump
> from 4.8-rc8 with the attached patch to confirm. Let's remove the previous
> one and apply this one.

dmesg-reverted.txt: 4.8-rc8 w/patches reverted (good)
$ head /proc/interrupts
           CPU0
  0:       8531    XT-PIC  timer
  1:          9    XT-PIC  i8042
  2:          0    XT-PIC  cascade
  8:          1    XT-PIC  rtc0
 11:        713    XT-PIC  acpi, uhci_hcd:usb1, uhci_hcd:usb2, nvkm, eth0
 12:        161    XT-PIC  i8042
 14:       4042    XT-PIC  pata_via
 15:          0    XT-PIC  pata_via
NMI:          0   Non-maskable interrupts

dmesg-bad-debug.txt: 4.8-rc8 (bad)
$ head /proc/interrupts
           CPU0
  0:       8027    XT-PIC  timer
  1:        286    XT-PIC  i8042
  2:          0    XT-PIC  cascade
  8:          1    XT-PIC  rtc0
 10:          0    XT-PIC  uhci_hcd:usb1, uhci_hcd:usb2
 11:          0    XT-PIC  acpi, nvkm, eth0
 12:        161    XT-PIC  i8042
 14:       4069    XT-PIC  pata_via
 15:          0    XT-PIC  pata_via

(I'm moving between different machines through the day - these logs are from 
different machine than the last ones).

-- 
Ondrej Zary

--Boundary-00=_EjB7X0yvjoJ7V1z
Content-Type: text/plain;
  charset="iso-8859-15";
  name="dmesg-bad-debug.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg-bad-debug.txt"

[    0.000000] Linux version 4.8.0-rc8+ (zary@gsql) (gcc version 4.7.2 (Debian 4.7.2-5) ) #112 SMP Wed Sep 28 21:09:56 CEST 2016
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
[    0.000000] free_area_init_node: node 0, pgdat c15b1840, node_mem_map dfbf0020
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
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-bad-debug root=/dev/sda1 ro resume=/dev/sda2
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
      .data : 0xc13d3d41 - 0xc15bf2e0   (1965 kB)
      .text : 0xc1000000 - 0xc13d3d41   (3919 kB)
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
[    0.000000] tsc: Detected 1199.440 MHz processor
[    0.008010] Calibrating delay loop (skipped), value calculated using timer frequency.. 2398.88 BogoMIPS (lpj=4797760)
[    0.008103] pid_max: default: 32768 minimum: 301
[    0.008175] ACPI: Core revision 20160422
[    0.013499] ACPI: 1 ACPI AML tables successfully acquired and loaded

[    0.013645] ACPI: setting ELCR to 0800 (from 0e00)
[    0.013763] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.013811] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.014640] Last level iTLB entries: 4KB 32, 2MB 0, 4MB 2
[    0.014712] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 8, 1GB 0
[    0.018403] Freeing SMP alternatives memory: 16K (c1644000 - c1648000)
[    0.020484] smpboot: Max logical packages: 1
[    0.020541] smpboot: weird, boot CPU (#0) not listed by the BIOS
[    0.020587] smpboot: SMP motherboard not detected
[    0.020630] smpboot: SMP disabled
[    0.020676] smpboot: Local APIC not detected. Using dummy APIC emulation.
[    0.020723] Performance Events: 
[    0.020769] no APIC, boot with the "lapic" boot parameter to force-enable it.
[    0.020851] no hardware sampling interrupt available.
[    0.020898] p6 PMU driver.
[    0.020946] ... version:                0
[    0.020988] ... bit width:              32
[    0.021030] ... generic registers:      2
[    0.021073] ... value mask:             00000000ffffffff
[    0.021116] ... max period:             000000007fffffff
[    0.021159] ... fixed-purpose events:   0
[    0.021201] ... event mask:             0000000000000003
[    0.022265] x86: Booted up 1 node, 1 CPUs
[    0.022336] smpboot: Total of 1 processors activated (2398.88 BogoMIPS)
[    0.022881] devtmpfs: initialized
[    0.024486] PM: Registering ACPI NVS region [mem 0x1fff0000-0x1fff2fff] (12288 bytes)
[    0.024731] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.025066] NET: Registered protocol family 16
[    0.025545] cpuidle: using governor ladder
[    0.025596] cpuidle: using governor menu
[    0.025752] clocksource: pit: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1601818034827 ns
[    0.025821] ACPI: bus type PCI registered
[    0.069024] PCI: PCI BIOS revision 2.10 entry at 0xfb200, last bus=1
[    0.069073] PCI: Using configuration type 1 for base access
[    0.072918] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[    0.073412] ACPI: Added _OSI(Module Device)
[    0.073469] ACPI: Added _OSI(Processor Device)
[    0.073515] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.073566] ACPI: Added _OSI(Processor Aggregator Device)
[    0.078154] ACPI: Interpreter enabled
[    0.078275] ACPI: (supports S0 S1 S4 S5)
[    0.078321] ACPI: Using PIC for interrupt routing
[    0.078420] PCI: Ignoring host bridge windows from ACPI; if necessary, use "pci=use_crs" and report a bug
[    0.085966] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.086046] acpi PNP0A03:00: _OSC: OS supports [Segments MSI]
[    0.086105] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.086166] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.086339] acpi PNP0A03:00: host bridge window [io  0x0cf8-0x0cff] (ignored)
[    0.086344] acpi PNP0A03:00: host bridge window [io  0x0000-0x0cf7 window] (ignored)
[    0.086348] acpi PNP0A03:00: host bridge window [io  0x0d00-0x3fff window] (ignored)
[    0.086352] acpi PNP0A03:00: host bridge window [io  0x4000-0x407f] (ignored)
[    0.086356] acpi PNP0A03:00: host bridge window [io  0x4080-0x40ff] (ignored)
[    0.086360] acpi PNP0A03:00: host bridge window [io  0x4100-0x4fff window] (ignored)
[    0.086364] acpi PNP0A03:00: host bridge window [io  0x5000-0x500f] (ignored)
[    0.086368] acpi PNP0A03:00: host bridge window [io  0x5010-0x5fff window] (ignored)
[    0.086372] acpi PNP0A03:00: host bridge window [io  0x6000-0x607f] (ignored)
[    0.086376] acpi PNP0A03:00: host bridge window [io  0x6080-0xffff window] (ignored)
[    0.086380] acpi PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff window] (ignored)
[    0.086385] acpi PNP0A03:00: host bridge window [mem 0x000c0000-0x000dffff window] (ignored)
[    0.086389] acpi PNP0A03:00: host bridge window [mem 0x20000000-0xffefffff window] (ignored)
[    0.086392] PCI: root bus 00: using default resources
[    0.086519] PCI host bridge to bus 0000:00
[    0.086573] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.086621] pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffff]
[    0.086671] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.086740] pci 0000:00:00.0: [1106:0691] type 00 class 0x060000
[    0.086761] pci 0000:00:00.0: reg 0x10: [mem 0xe0000000-0xe3ffffff pref]
[    0.087004] pci 0000:00:01.0: [1106:8598] type 01 class 0x060400
[    0.087054] pci 0000:00:01.0: supports D1
[    0.087196] pci 0000:00:07.0: [1106:0686] type 00 class 0x060100
[    0.087456] pci 0000:00:07.1: [1106:0571] type 00 class 0x01018a
[    0.087502] pci 0000:00:07.1: reg 0x20: [io  0xd000-0xd00f]
[    0.087523] pci 0000:00:07.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.087574] pci 0000:00:07.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.087622] pci 0000:00:07.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.087669] pci 0000:00:07.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.087883] pci 0000:00:07.2: [1106:3038] type 00 class 0x0c0300
[    0.087924] pci 0000:00:07.2: reg 0x20: [io  0xd400-0xd41f]
[    0.088121] pci 0000:00:07.2: System wakeup disabled by ACPI
[    0.088288] pci 0000:00:07.3: [1106:3038] type 00 class 0x0c0300
[    0.088331] pci 0000:00:07.3: reg 0x20: [io  0xd800-0xd81f]
[    0.088460] pci 0000:00:07.3: System wakeup disabled by ACPI
[    0.088623] pci 0000:00:07.4: [1106:3057] type 00 class 0x068000
[    0.088686] pci 0000:00:07.4: quirk: [io  0x6000-0x607f] claimed by vt82c686 HW-mon
[    0.088739] pci 0000:00:07.4: quirk: [io  0x5000-0x500f] claimed by vt82c686 SMB
[    0.088966] pci 0000:00:07.5: [1106:3058] type 00 class 0x040100
[    0.088985] pci 0000:00:07.5: reg 0x10: [io  0xdc00-0xdcff]
[    0.088996] pci 0000:00:07.5: reg 0x14: [io  0xe000-0xe003]
[    0.089007] pci 0000:00:07.5: reg 0x18: [io  0xe400-0xe403]
[    0.089234] pci 0000:00:0f.0: [10ec:8139] type 00 class 0x020000
[    0.089251] pci 0000:00:0f.0: reg 0x10: [io  0xe800-0xe8ff]
[    0.089262] pci 0000:00:0f.0: reg 0x14: [mem 0xe8000000-0xe80000ff]
[    0.089325] pci 0000:00:0f.0: supports D1 D2
[    0.089330] pci 0000:00:0f.0: PME# supported from D1 D2 D3hot
[    0.089574] pci 0000:01:00.0: [10de:002d] type 00 class 0x030000
[    0.089591] pci 0000:01:00.0: reg 0x10: [mem 0xe6000000-0xe6ffffff]
[    0.089602] pci 0000:01:00.0: reg 0x14: [mem 0xe4000000-0xe5ffffff pref]
[    0.089635] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    0.089775] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.089827] pci 0000:00:01.0:   bridge window [mem 0xe6000000-0xe7ffffff]
[    0.089834] pci 0000:00:01.0:   bridge window [mem 0xe4000000-0xe5ffffff pref]
[    0.089845] pci_bus 0000:00: on NUMA node 0
[    0.090231] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
[    0.090947] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[    0.091784] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
[    0.092620] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *9
[    0.095043] vgaarb: setting as boot device: PCI:0000:01:00.0
[    0.095105] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.095153] vgaarb: loaded
[    0.095197] vgaarb: bridge control possible 0000:01:00.0
[    0.095477] SCSI subsystem initialized
[    0.095687] libata version 3.00 loaded.
[    0.095702] ACPI: bus type USB registered
[    0.095823] usbcore: registered new interface driver usbfs
[    0.095898] usbcore: registered new interface driver hub
[    0.096042] usbcore: registered new device driver usb
[    0.096168] PCI: Using ACPI for IRQ routing
[    0.096222] PCI: pci_cache_line_size set to 32 bytes
[    0.096268] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.096273] e820: reserve RAM buffer [mem 0x1fff0000-0x1fffffff]
[    0.097240] clocksource: Switched to clocksource pit
[    0.116797] pnp: PnP ACPI init
[    0.117697] system 00:00: [mem 0x000ca800-0x000cbfff] has been reserved
[    0.117768] system 00:00: [mem 0x000f0000-0x000f7fff] could not be reserved
[    0.117817] system 00:00: [mem 0x000f8000-0x000fbfff] could not be reserved
[    0.117867] system 00:00: [mem 0x000fc000-0x000fffff] could not be reserved
[    0.117916] system 00:00: [mem 0x1fff0000-0x1fffffff] could not be reserved
[    0.117965] system 00:00: [mem 0xffff0000-0xffffffff] has been reserved
[    0.118013] system 00:00: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.118061] system 00:00: [mem 0x00100000-0x1ffeffff] could not be reserved
[    0.118110] system 00:00: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.118170] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.118649] system 00:01: [io  0x04d0-0x04d1] has been reserved
[    0.118707] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.118882] acpi_penalize_isa_irq:894 acpi_isa_irq_penalty[8]=0x110000 active = 1
[    0.118995] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.119282] acpi_penalize_isa_irq:894 acpi_isa_irq_penalty[6]=0x11005c active = 1
[    0.120439] pnp 00:03: [dma 2]
[    0.120465] acpi_penalize_isa_irq:894 acpi_isa_irq_penalty[6]=0x11105c active = 0
[    0.120589] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.121494] acpi_penalize_isa_irq:894 acpi_isa_irq_penalty[12]=0x20005c active = 1
[    0.121598] pnp 00:04: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.121661] acpi_penalize_isa_irq:894 acpi_isa_irq_penalty[1]=0x110005c active = 1
[    0.121761] pnp 00:05: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.121816] pnp: PnP ACPI: found 6 devices
[    0.121873] PnPBIOS: Disabled
[    0.161614] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.161745] clocksource: Switched to clocksource acpi_pm
[    0.161857] pci 0000:01:00.0: BAR 6: assigned [mem 0xe7000000-0xe700ffff pref]
[    0.161917] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.161970] pci 0000:00:01.0:   bridge window [mem 0xe6000000-0xe7ffffff]
[    0.162020] pci 0000:00:01.0:   bridge window [mem 0xe4000000-0xe5ffffff pref]
[    0.162078] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
[    0.162083] pci_bus 0000:00: resource 5 [mem 0x00000000-0xffffffff]
[    0.162088] pci_bus 0000:01: resource 1 [mem 0xe6000000-0xe7ffffff]
[    0.162093] pci_bus 0000:01: resource 2 [mem 0xe4000000-0xe5ffffff pref]
[    0.162202] NET: Registered protocol family 2
[    0.162858] TCP established hash table entries: 4096 (order: 2, 16384 bytes)
[    0.162984] TCP bind hash table entries: 4096 (order: 3, 32768 bytes)
[    0.163145] TCP: Hash tables configured (established 4096 bind 4096)
[    0.163276] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    0.163351] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    0.163623] NET: Registered protocol family 1
[    0.163735] pci 0000:00:01.0: disabling DAC on VIA PCI bridge
[    0.163790] pci 0000:00:07.0: Disabling VIA external APIC routing
[    0.164219] irq : 15
[    0.164265] acpi_irq_balance : 0
[    0.164307] link->irq.active : 0
[    0.164350] acpi_gbl_FADT.sci_interrupt : 11
[    0.164399] acpi_irq_get_penalty:512 adding SCI penalty: 0x1000000 
[    0.164443] acpi_irq_get_penalty(10) : 0x5c
[    0.164486] acpi_irq_get_penalty(15) : 0x10005c
[    0.165264] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
[    0.165314] PCI: setting IRQ 10 as level-triggered
[    0.165330] pci 0000:00:07.2: VIA VLink IRQ fixup, from 9 to 10
[    0.165727] pci 0000:00:07.3: VIA VLink IRQ fixup, from 9 to 10
[    0.165979] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.166036] PCI: CLS 32 bytes, default 32
[    0.167431] futex hash table entries: 256 (order: 1, 8192 bytes)
[    0.168656] workingset: timestamp_bits=30 max_order=17 bucket_order=0
[    0.176996] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.177070] io scheduler noop registered
[    0.177117] io scheduler deadline registered
[    0.177263] io scheduler cfq registered (default)
[    0.177980] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.178046] ACPI: Power Button [PWRB]
[    0.178251] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1
[    0.178304] ACPI: Sleep Button [SLPB]
[    0.178498] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    0.178549] ACPI: Power Button [PWRF]
[    0.178735] tsc: Marking TSC unstable due to TSC halts in idle
[    0.178910] Warning: Processor Platform Limit event detected, but not handled.
[    0.178960] Consider compiling CPUfreq support into your kernel.
[    0.179608] isapnp: Scanning for PnP cards...
[    0.265919] acpi_penalize_isa_irq:894 acpi_isa_irq_penalty[4]=0x1105c active = 0
[    0.265972] acpi_penalize_isa_irq:894 acpi_isa_irq_penalty[5]=0x1105c active = 0
[    0.266022] acpi_penalize_isa_irq:894 acpi_isa_irq_penalty[7]=0x1105c active = 0
[    0.266070] acpi_penalize_isa_irq:894 acpi_isa_irq_penalty[10]=0x105c active = 0
[    0.266125] acpi_irq_get_penalty:512 adding SCI penalty: 0x1000000 
[    0.266170] acpi_irq_get_penalty:512 adding SCI penalty: 0x1000000 
[    0.266219] acpi_penalize_isa_irq:894 acpi_isa_irq_penalty[11]=0x200105c active = 0
[    0.266268] acpi_penalize_isa_irq:894 acpi_isa_irq_penalty[12]=0x20105c active = 0
[    0.266320] acpi_penalize_isa_irq:894 acpi_isa_irq_penalty[15]=0x10105c active = 0
[    0.266588]  01:01: card 'SYM 53C416'
[    0.266635] isapnp: 1 Plug & Play card detected total
[    0.266864] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.268272] Non-volatile memory driver v1.3
[    0.268330] Linux agpgart interface v0.103
[    0.268452] [drm] Initialized drm 1.1.0 20060810
[    0.276121] loop: module loaded
[    0.276492] pata_via 0000:00:07.1: version 0.3.4
[    0.277723] scsi host0: pata_via
[    0.278144] scsi host1: pata_via
[    0.278340] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xd000 irq 14
[    0.278388] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xd008 irq 15
[    0.278609] 8139cp: 8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
[    0.278660] 8139cp 0000:00:0f.0: This (id 10ec:8139 rev 10) is not an 8139C+ compatible chip, use 8139too
[    0.278762] 8139too: 8139too Fast Ethernet driver 0.9.28
[    0.279101] irq : 11
[    0.279146] acpi_irq_balance : 0
[    0.279188] link->irq.active : 11
[    0.279230] acpi_gbl_FADT.sci_interrupt : 11
[    0.279279] acpi_irq_get_penalty:512 adding SCI penalty: 0x1000000 
[    0.279323] penalty[15] = 0x10105c
[    0.279369] penalty[14] = 0x10005c
[    0.279411] penalty[12] = 0x20105c
[    0.279454] acpi_irq_get_penalty:512 adding SCI penalty: 0x1000000 
[    0.279497] penalty[11] = 0x200105c
[    0.279539] penalty[10] = 0x105c
[    0.279582] penalty[7] = 0x1105c
[    0.279624] penalty[6] = 0x11105c
[    0.279666] penalty[5] = 0x1105c
[    0.279708] penalty[4] = 0x1105c
[    0.279750] penalty[3] = 0x1005c
[    0.279791] penalty[1] = 0x110005c
[    0.279833] irq : 11
[    0.279875] acpi_gbl_FADT.sci_interrupt : 11
[    0.279919] ACPI: No IRQ available for PCI Interrupt Link [LNKA]. Try pci=noacpi or acpi=off
[    0.279973] acpi_irq_get_penalty:512 adding SCI penalty: 0x1000000 
[    0.280128] 8139too 0000:00:0f.0: PCI INT A: no GSI
[    0.280875] 8139too 0000:00:0f.0 eth0: RealTek RTL8139 at 0x0001e800, 00:40:95:30:81:14, IRQ 11
[    0.280979] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.281024] ehci-pci: EHCI PCI platform driver
[    0.281111] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.281184] ohci-pci: OHCI PCI platform driver
[    0.281254] uhci_hcd: USB Universal Host Controller Interface driver
[    0.281573] uhci_hcd 0000:00:07.2: UHCI Host Controller
[    0.281639] uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
[    0.281747] uhci_hcd 0000:00:07.2: irq 10, io base 0x0000d400
[    0.282778] hub 1-0:1.0: USB hub found
[    0.282851] hub 1-0:1.0: 2 ports detected
[    0.283463] uhci_hcd 0000:00:07.3: UHCI Host Controller
[    0.283537] uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
[    0.283635] uhci_hcd 0000:00:07.3: irq 10, io base 0x0000d800
[    0.284402] hub 2-0:1.0: USB hub found
[    0.284472] hub 2-0:1.0: 2 ports detected
[    0.284958] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    0.285546] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.285610] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.286096] mousedev: PS/2 mouse device common for all mice
[    0.287066] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
[    0.287168] rtc_cmos 00:02: alarms up to one year, y3k, 242 bytes nvram
[    0.287708] NET: Registered protocol family 17
[    0.287911] Using IPI No-Shortcut mode
[    0.288508] registered taskstats version 1
[    0.289178] rtc_cmos 00:02: setting system clock to 2016-09-28 19:14:41 UTC (1475090081)
[    0.289332] PM: Checking hibernation image partition /dev/sda2
[    0.314384] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input3
[    0.502855] ata1.00: ATA-6: WDC WD800JB-00FMA0, 13.03G13, max UDMA/100
[    0.502916] ata1.00: 156301488 sectors, multi 16: LBA 
[    0.505837] ata1.00: configured for UDMA/100
[    0.506366] scsi 0:0:0:0: Direct-Access     ATA      WDC WD800JB-00FM 3G13 PQ: 0 ANSI: 5
[    0.507384] sd 0:0:0:0: [sda] 156301488 512-byte logical blocks: (80.0 GB/74.5 GiB)
[    0.507611] sd 0:0:0:0: [sda] Write Protect is off
[    0.507662] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.507718] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    0.557611]  sda: sda1 sda2 sda3
[    0.558732] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.184054] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x114a0ab08b1, max_idle_ns: 440795234663 ns
[    1.224978] random: fast init done
[    1.741100] input: PS/2 BYD TouchPad as /devices/platform/i8042/serio1/input/input5
[    1.744071] PM: Hibernation image partition 8:2 present
[    1.744074] PM: Looking for hibernation image.
[    1.744627] PM: Image not found (code -22)
[    1.744631] PM: Hibernation image not present or could not be loaded.
[    1.745231] EXT4-fs (sda1): mounting ext3 file system using the ext4 subsystem
[    1.793436] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[    1.793557] VFS: Mounted root (ext3 filesystem) readonly on device 8:1.
[    1.795054] Freeing unused kernel memory: 524K (c15c1000 - c1644000)
[    1.795406] Write protecting the kernel text: 3920k
[    1.795537] Write protecting the kernel read-only data: 1528k
[    4.608826] random: crng init done
[    4.944737] systemd-udevd[179]: starting version 215
[    6.869723] parport_pc: VIA 686A/8231 detected
[    6.869731] parport_pc: probing current configuration
[    6.869751] parport_pc: Current parallel port base: 0x0
[    6.869755] parport_pc: VIA parallel port disabled in BIOS
[    6.954387] agpgart: Detected VIA Apollo Pro 133 chipset
[    6.959133] agpgart-via 0000:00:00.0: AGP aperture is 64M @ 0xe0000000
[    7.166943] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    7.300691] wmi: Mapper loaded
[    7.820436] irq : 11
[    7.820501] acpi_irq_balance : 0
[    7.820543] link->irq.active : 11
[    7.820585] acpi_gbl_FADT.sci_interrupt : 11
[    7.820634] acpi_irq_get_penalty:512 adding SCI penalty: 0x1000000 
[    7.820679] penalty[15] = 0x10105c
[    7.820721] penalty[14] = 0x10005c
[    7.820763] penalty[12] = 0x20105c
[    7.820806] acpi_irq_get_penalty:512 adding SCI penalty: 0x1000000 
[    7.820849] penalty[11] = 0x200105c
[    7.820892] penalty[10] = 0x105c
[    7.820934] penalty[7] = 0x1105c
[    7.820975] penalty[6] = 0x11105c
[    7.821017] penalty[5] = 0x1105c
[    7.821059] penalty[4] = 0x1105c
[    7.821101] penalty[3] = 0x1005c
[    7.821143] penalty[1] = 0x110005c
[    7.821184] irq : 11
[    7.821227] acpi_gbl_FADT.sci_interrupt : 11
[    7.821272] ACPI: No IRQ available for PCI Interrupt Link [LNKA]. Try pci=noacpi or acpi=off
[    7.821326] acpi_irq_get_penalty:512 adding SCI penalty: 0x1000000 
[    7.821378] nouveau 0000:01:00.0: PCI INT A: no GSI
[    7.821679] irq : 11
[    7.821723] acpi_irq_balance : 0
[    7.821765] link->irq.active : 11
[    7.821807] acpi_gbl_FADT.sci_interrupt : 11
[    7.821851] acpi_irq_get_penalty:512 adding SCI penalty: 0x1000000 
[    7.821896] penalty[15] = 0x10105c
[    7.821938] penalty[14] = 0x10005c
[    7.821981] penalty[12] = 0x20105c
[    7.822024] acpi_irq_get_penalty:512 adding SCI penalty: 0x1000000 
[    7.822067] penalty[11] = 0x200105c
[    7.822113] penalty[10] = 0x105c
[    7.822154] penalty[7] = 0x1105c
[    7.822196] penalty[6] = 0x11105c
[    7.822243] penalty[5] = 0x1105c
[    7.822284] penalty[4] = 0x1105c
[    7.822326] penalty[3] = 0x1005c
[    7.822372] penalty[1] = 0x110005c
[    7.822413] irq : 11
[    7.822454] acpi_gbl_FADT.sci_interrupt : 11
[    7.822499] ACPI: No IRQ available for PCI Interrupt Link [LNKA]. Try pci=noacpi or acpi=off
[    7.822548] acpi_irq_get_penalty:512 adding SCI penalty: 0x1000000 
[    7.822597] nouveau 0000:01:00.0: PCI INT A: no GSI
[    7.822664] nouveau 0000:01:00.0: NVIDIA NV05 (20154000)
[    7.842612] nouveau 0000:01:00.0: bios: version 02.05.20.02.00
[    7.843003] nouveau 0000:01:00.0: bios: DCB table not found
[    7.843548] nouveau 0000:01:00.0: bios: DCB table not found
[    7.843781] nouveau 0000:01:00.0: bios: DCB table not found
[    7.843830] nouveau 0000:01:00.0: bios: DCB table not found
[    7.843907] nouveau 0000:01:00.0: bios: DCB table not found
[    7.845326] agpgart-via 0000:00:00.0: AGP 2.0 bridge
[    7.845411] agpgart-via 0000:00:00.0: putting AGP V2 device into 4x mode
[    7.845489] nouveau 0000:01:00.0: putting AGP V2 device into 4x mode
[    7.845578] nouveau 0000:01:00.0: tmr: unknown input clock freq
[    7.847830] nouveau 0000:01:00.0: fb: 32 MiB SDRAM
[    7.858980] [TTM] Zone  kernel: Available graphics memory: 256412 kiB
[    7.859052] [TTM] Initializing pool allocator
[    7.859512] nouveau 0000:01:00.0: DRM: VRAM: 31 MiB
[    7.859576] nouveau 0000:01:00.0: DRM: GART: 64 MiB
[    7.859628] nouveau 0000:01:00.0: DRM: BMP version 5.6
[    7.859676] nouveau 0000:01:00.0: DRM: No DCB data found in VBIOS
[    7.862836] nouveau 0000:01:00.0: DRM: Saving VGA fonts
[    7.896335] nouveau 0000:01:00.0: DRM: No DCB data found in VBIOS
[    7.897584] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    7.897643] [drm] Driver supports precise vblank timestamp query.
[    7.905373] nouveau 0000:01:00.0: DRM: MM: using M2MF for buffer copies
[    7.966269] nouveau 0000:01:00.0: DRM: allocated 1280x1024 fb: 0x4000, bo dd712000
[    7.967701] fbcon: nouveaufb (fb0) is primary device
[    8.254746] nouveau 0000:01:00.0: DRM: GPU lockup - switching to software fbcon
[    8.260881] Console: switching to colour frame buffer device 160x64
[    8.290325] nouveau 0000:01:00.0: fb0: nouveaufb frame buffer device
[    8.290432] [drm] Initialized nouveau 1.3.1 20120801 for 0000:01:00.0 on minor 0
[    9.573010] EXT4-fs (sda1): re-mounted. Opts: (null)
[   10.242369] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
[   11.856180] i2c /dev entries driver
[   17.021042] 8139too 0000:00:0f.0 eth0: link up, 10Mbps, half-duplex, lpa 0x0000
[   28.896048] ------------[ cut here ]------------
[   28.899660] WARNING: CPU: 0 PID: 0 at net/sched/sch_generic.c:316 dev_watchdog+0xaf/0x10b
[   28.903175] NETDEV WATCHDOG: eth0 (8139too): transmit queue 0 timed out
[   28.906680] Modules linked in: i2c_dev nouveau wmi video hwmon sg ttm via_agp parport_pc parport
[   28.910317] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.0-rc8+ #112
[   28.913847] Hardware name: VIA Technologies, Inc. VT82C694X/694X, BIOS 6.00 PG 02/19/2002
[   28.914297]  00000000 c11aaa70 df41ff44 00000000 c10347a1 0000013c 00000009 df5aa000
[   28.914297]  00000000 fffef740 df5aa240 c1034827 00000009 00000000 df41ff44 c1506e14
[   28.914297]  df41ff5c c131d566 c1506e4d 0000013c c1506e14 df5aa000 c14f7de4 00000000
[   28.914297] Call Trace:
[   28.914297]  [<c11aaa70>] ? dump_stack+0x44/0x58
[   28.914297]  [<c10347a1>] ? __warn+0xc1/0xd8
[   28.914297]  [<c1034827>] ? warn_slowpath_fmt+0x2b/0x30
[   28.914297]  [<c131d566>] ? dev_watchdog+0xaf/0x10b
[   28.914297]  [<c131d4b7>] ? netif_tx_lock+0x51/0x51
[   28.914297]  [<c10724d9>] ? call_timer_fn+0x49/0xee
[   28.914297]  [<c107271c>] ? __run_timers.part.29+0x10e/0x14a
[   28.914297]  [<c106f42c>] ? rcu_process_callbacks+0x178/0x385
[   28.914297]  [<c1072896>] ? run_timer_softirq+0x1e/0x43
[   28.914297]  [<c1037d44>] ? __do_softirq+0xb6/0x203
[   28.914297]  [<c1037c8e>] ? perf_trace_irq_handler_entry+0xd4/0xd4
[   28.914297]  [<c1013d1a>] ? do_softirq_own_stack+0x1a/0x1f
[   28.914297]  <IRQ>  [<c1037fba>] ? irq_exit+0x31/0x70
[   28.914297]  [<c10137e0>] ? do_IRQ+0x7a/0x8b
[   28.914297]  [<c13d2aec>] ? common_interrupt+0x2c/0x34
[   28.914297]  [<c12e5371>] ? cpuidle_enter_state+0xf8/0x1b4
[   28.914297]  [<c1059fff>] ? cpu_startup_entry+0x188/0x209
[   28.914297]  [<c15c1a12>] ? start_kernel+0x30f/0x312
[   28.996287] ---[ end trace a5bd32d2c6ab9c93 ]---
[   32.224093] 8139too 0000:00:0f.0 eth0: link up, 10Mbps, half-duplex, lpa 0x0000
[   44.000082] 8139too 0000:00:0f.0 eth0: link up, 10Mbps, half-duplex, lpa 0x0000
[   57.056107] 8139too 0000:00:0f.0 eth0: link up, 10Mbps, half-duplex, lpa 0x0000
[   69.088090] 8139too 0000:00:0f.0 eth0: link up, 10Mbps, half-duplex, lpa 0x0000

--Boundary-00=_EjB7X0yvjoJ7V1z
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
[    0.000000] free_area_init_node: node 0, pgdat c15b1c00, node_mem_map dfbf0020
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
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-reverted root=/dev/sda1 ro resume=/dev/sda2
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Initializing CPU#0
[    0.000000] Initializing HighMem for node 0 (00000000:00000000)
[    0.000000] Memory: 512284K/523832K available (3918K kernel code, 437K rwdata, 1520K rodata, 524K init, 412K bss, 11548K reserved, 0K cma-reserved, 0K highmem)
[    0.000000] virtual kernel memory layout:
    fixmap  : 0xfff17000 - 0xfffff000   ( 928 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xe07f0000 - 0xff7fe000   ( 496 MB)
    lowmem  : 0xc0000000 - 0xdfff0000   ( 511 MB)
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
[    0.000000] tsc: Detected 1199.503 MHz processor
[    0.004010] Calibrating delay loop (skipped), value calculated using timer frequency.. 2399.00 BogoMIPS (lpj=4798012)
[    0.004102] pid_max: default: 32768 minimum: 301
[    0.004173] ACPI: Core revision 20160422
[    0.009222] ACPI: 1 ACPI AML tables successfully acquired and loaded

[    0.009366] ACPI: setting ELCR to 0800 (from 0e00)
[    0.009481] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.009529] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.010375] Last level iTLB entries: 4KB 32, 2MB 0, 4MB 2
[    0.010444] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 8, 1GB 0
[    0.014109] Freeing SMP alternatives memory: 16K (c1644000 - c1648000)
[    0.016481] smpboot: Max logical packages: 1
[    0.016539] smpboot: weird, boot CPU (#0) not listed by the BIOS
[    0.016585] smpboot: SMP motherboard not detected
[    0.016627] smpboot: SMP disabled
[    0.016673] smpboot: Local APIC not detected. Using dummy APIC emulation.
[    0.016720] Performance Events: 
[    0.016766] no APIC, boot with the "lapic" boot parameter to force-enable it.
[    0.016848] no hardware sampling interrupt available.
[    0.016895] p6 PMU driver.
[    0.016943] ... version:                0
[    0.016985] ... bit width:              32
[    0.017030] ... generic registers:      2
[    0.017072] ... value mask:             00000000ffffffff
[    0.017117] ... max period:             000000007fffffff
[    0.017160] ... fixed-purpose events:   0
[    0.017202] ... event mask:             0000000000000003
[    0.018269] x86: Booted up 1 node, 1 CPUs
[    0.018341] smpboot: Total of 1 processors activated (2399.00 BogoMIPS)
[    0.018888] devtmpfs: initialized
[    0.020162] PM: Registering ACPI NVS region [mem 0x1fff0000-0x1fff2fff] (12288 bytes)
[    0.020408] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.020751] NET: Registered protocol family 16
[    0.021229] cpuidle: using governor ladder
[    0.021287] cpuidle: using governor menu
[    0.021442] clocksource: pit: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1601818034827 ns
[    0.021508] ACPI: bus type PCI registered
[    0.064935] PCI: PCI BIOS revision 2.10 entry at 0xfb200, last bus=1
[    0.064988] PCI: Using configuration type 1 for base access
[    0.068811] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[    0.069308] ACPI: Added _OSI(Module Device)
[    0.069362] ACPI: Added _OSI(Processor Device)
[    0.069406] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.069451] ACPI: Added _OSI(Processor Aggregator Device)
[    0.073956] ACPI: Interpreter enabled
[    0.074077] ACPI: (supports S0 S1 S4 S5)
[    0.074125] ACPI: Using PIC for interrupt routing
[    0.074224] PCI: Ignoring host bridge windows from ACPI; if necessary, use "pci=use_crs" and report a bug
[    0.081632] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.081712] acpi PNP0A03:00: _OSC: OS supports [Segments MSI]
[    0.081771] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.081831] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.082003] acpi PNP0A03:00: host bridge window [io  0x0cf8-0x0cff] (ignored)
[    0.082008] acpi PNP0A03:00: host bridge window [io  0x0000-0x0cf7 window] (ignored)
[    0.082012] acpi PNP0A03:00: host bridge window [io  0x0d00-0x3fff window] (ignored)
[    0.082016] acpi PNP0A03:00: host bridge window [io  0x4000-0x407f] (ignored)
[    0.082020] acpi PNP0A03:00: host bridge window [io  0x4080-0x40ff] (ignored)
[    0.082025] acpi PNP0A03:00: host bridge window [io  0x4100-0x4fff window] (ignored)
[    0.082029] acpi PNP0A03:00: host bridge window [io  0x5000-0x500f] (ignored)
[    0.082033] acpi PNP0A03:00: host bridge window [io  0x5010-0x5fff window] (ignored)
[    0.082037] acpi PNP0A03:00: host bridge window [io  0x6000-0x607f] (ignored)
[    0.082041] acpi PNP0A03:00: host bridge window [io  0x6080-0xffff window] (ignored)
[    0.082045] acpi PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff window] (ignored)
[    0.082050] acpi PNP0A03:00: host bridge window [mem 0x000c0000-0x000dffff window] (ignored)
[    0.082054] acpi PNP0A03:00: host bridge window [mem 0x20000000-0xffefffff window] (ignored)
[    0.082057] PCI: root bus 00: using default resources
[    0.082182] PCI host bridge to bus 0000:00
[    0.082232] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.082279] pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffff]
[    0.082327] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.082396] pci 0000:00:00.0: [1106:0691] type 00 class 0x060000
[    0.082418] pci 0000:00:00.0: reg 0x10: [mem 0xe0000000-0xe3ffffff pref]
[    0.082656] pci 0000:00:01.0: [1106:8598] type 01 class 0x060400
[    0.082706] pci 0000:00:01.0: supports D1
[    0.082848] pci 0000:00:07.0: [1106:0686] type 00 class 0x060100
[    0.083105] pci 0000:00:07.1: [1106:0571] type 00 class 0x01018a
[    0.083151] pci 0000:00:07.1: reg 0x20: [io  0xd000-0xd00f]
[    0.083172] pci 0000:00:07.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.083225] pci 0000:00:07.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.083272] pci 0000:00:07.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.083320] pci 0000:00:07.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.083533] pci 0000:00:07.2: [1106:3038] type 00 class 0x0c0300
[    0.083575] pci 0000:00:07.2: reg 0x20: [io  0xd400-0xd41f]
[    0.083698] pci 0000:00:07.2: System wakeup disabled by ACPI
[    0.083860] pci 0000:00:07.3: [1106:3038] type 00 class 0x0c0300
[    0.083902] pci 0000:00:07.3: reg 0x20: [io  0xd800-0xd81f]
[    0.084098] pci 0000:00:07.3: System wakeup disabled by ACPI
[    0.084265] pci 0000:00:07.4: [1106:3057] type 00 class 0x068000
[    0.084329] pci 0000:00:07.4: quirk: [io  0x6000-0x607f] claimed by vt82c686 HW-mon
[    0.084384] pci 0000:00:07.4: quirk: [io  0x5000-0x500f] claimed by vt82c686 SMB
[    0.084608] pci 0000:00:07.5: [1106:3058] type 00 class 0x040100
[    0.084626] pci 0000:00:07.5: reg 0x10: [io  0xdc00-0xdcff]
[    0.084637] pci 0000:00:07.5: reg 0x14: [io  0xe000-0xe003]
[    0.084649] pci 0000:00:07.5: reg 0x18: [io  0xe400-0xe403]
[    0.084876] pci 0000:00:0f.0: [10ec:8139] type 00 class 0x020000
[    0.084893] pci 0000:00:0f.0: reg 0x10: [io  0xe800-0xe8ff]
[    0.084904] pci 0000:00:0f.0: reg 0x14: [mem 0xe8000000-0xe80000ff]
[    0.084967] pci 0000:00:0f.0: supports D1 D2
[    0.084972] pci 0000:00:0f.0: PME# supported from D1 D2 D3hot
[    0.085215] pci 0000:01:00.0: [10de:002d] type 00 class 0x030000
[    0.085232] pci 0000:01:00.0: reg 0x10: [mem 0xe6000000-0xe6ffffff]
[    0.085243] pci 0000:01:00.0: reg 0x14: [mem 0xe4000000-0xe5ffffff pref]
[    0.085276] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    0.085414] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.085471] pci 0000:00:01.0:   bridge window [mem 0xe6000000-0xe7ffffff]
[    0.085477] pci 0000:00:01.0:   bridge window [mem 0xe4000000-0xe5ffffff pref]
[    0.085488] pci_bus 0000:00: on NUMA node 0
[    0.085864] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
[    0.086574] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[    0.087401] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
[    0.088227] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *9
[    0.090614] vgaarb: setting as boot device: PCI:0000:01:00.0
[    0.090671] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.090721] vgaarb: loaded
[    0.090764] vgaarb: bridge control possible 0000:01:00.0
[    0.091052] SCSI subsystem initialized
[    0.091256] libata version 3.00 loaded.
[    0.091273] ACPI: bus type USB registered
[    0.091394] usbcore: registered new interface driver usbfs
[    0.091471] usbcore: registered new interface driver hub
[    0.091553] usbcore: registered new device driver usb
[    0.091672] PCI: Using ACPI for IRQ routing
[    0.091724] PCI: pci_cache_line_size set to 32 bytes
[    0.091771] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.091777] e820: reserve RAM buffer [mem 0x1fff0000-0x1fffffff]
[    0.092795] clocksource: Switched to clocksource pit
[    0.112748] pnp: PnP ACPI init
[    0.113642] system 00:00: [mem 0x000ca800-0x000cbfff] has been reserved
[    0.113707] system 00:00: [mem 0x000f0000-0x000f7fff] could not be reserved
[    0.113756] system 00:00: [mem 0x000f8000-0x000fbfff] could not be reserved
[    0.113805] system 00:00: [mem 0x000fc000-0x000fffff] could not be reserved
[    0.113853] system 00:00: [mem 0x1fff0000-0x1fffffff] could not be reserved
[    0.113903] system 00:00: [mem 0xffff0000-0xffffffff] has been reserved
[    0.113950] system 00:00: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.114002] system 00:00: [mem 0x00100000-0x1ffeffff] could not be reserved
[    0.114050] system 00:00: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.114114] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.114583] system 00:01: [io  0x04d0-0x04d1] has been reserved
[    0.114642] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.114734] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.114994] pnp 00:03: [dma 2]
[    0.115096] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.116191] pnp 00:04: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.116305] pnp 00:05: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.116357] pnp: PnP ACPI: found 6 devices
[    0.116421] PnPBIOS: Disabled
[    0.156067] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.157336] clocksource: Switched to clocksource acpi_pm
[    0.157449] pci 0000:01:00.0: BAR 6: assigned [mem 0xe7000000-0xe700ffff pref]
[    0.157504] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.157556] pci 0000:00:01.0:   bridge window [mem 0xe6000000-0xe7ffffff]
[    0.157607] pci 0000:00:01.0:   bridge window [mem 0xe4000000-0xe5ffffff pref]
[    0.157665] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
[    0.157669] pci_bus 0000:00: resource 5 [mem 0x00000000-0xffffffff]
[    0.157675] pci_bus 0000:01: resource 1 [mem 0xe6000000-0xe7ffffff]
[    0.157679] pci_bus 0000:01: resource 2 [mem 0xe4000000-0xe5ffffff pref]
[    0.157789] NET: Registered protocol family 2
[    0.158362] TCP established hash table entries: 4096 (order: 2, 16384 bytes)
[    0.158479] TCP bind hash table entries: 4096 (order: 3, 32768 bytes)
[    0.158643] TCP: Hash tables configured (established 4096 bind 4096)
[    0.158772] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    0.158851] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    0.159134] NET: Registered protocol family 1
[    0.159374] pci 0000:00:01.0: disabling DAC on VIA PCI bridge
[    0.159430] pci 0000:00:07.0: Disabling VIA external APIC routing
[    0.160571] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
[    0.160622] PCI: setting IRQ 11 as level-triggered
[    0.160636] pci 0000:00:07.2: VIA VLink IRQ fixup, from 9 to 11
[    0.161041] pci 0000:00:07.3: VIA VLink IRQ fixup, from 9 to 11
[    0.161293] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.161350] PCI: CLS 32 bytes, default 32
[    0.162745] futex hash table entries: 256 (order: 1, 8192 bytes)
[    0.163839] workingset: timestamp_bits=30 max_order=17 bucket_order=0
[    0.172227] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.172305] io scheduler noop registered
[    0.172349] io scheduler deadline registered
[    0.172507] io scheduler cfq registered (default)
[    0.173233] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.173301] ACPI: Power Button [PWRB]
[    0.173508] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1
[    0.173560] ACPI: Sleep Button [SLPB]
[    0.173751] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    0.173803] ACPI: Power Button [PWRF]
[    0.173987] tsc: Marking TSC unstable due to TSC halts in idle
[    0.174189] Warning: Processor Platform Limit event detected, but not handled.
[    0.174242] Consider compiling CPUfreq support into your kernel.
[    0.174906] isapnp: Scanning for PnP cards...
[    0.261549]  01:01: card 'SYM 53C416'
[    0.261597] isapnp: 1 Plug & Play card detected total
[    0.261825] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.263081] Non-volatile memory driver v1.3
[    0.263140] Linux agpgart interface v0.103
[    0.263253] [drm] Initialized drm 1.1.0 20060810
[    0.270951] loop: module loaded
[    0.271307] pata_via 0000:00:07.1: version 0.3.4
[    0.272681] scsi host0: pata_via
[    0.273100] scsi host1: pata_via
[    0.273304] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xd000 irq 14
[    0.273352] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xd008 irq 15
[    0.273577] 8139cp: 8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
[    0.273631] 8139cp 0000:00:0f.0: This (id 10ec:8139 rev 10) is not an 8139C+ compatible chip, use 8139too
[    0.273732] 8139too: 8139too Fast Ethernet driver 0.9.28
[    0.274801] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
[    0.275559] 8139too 0000:00:0f.0 eth0: RealTek RTL8139 at 0x0001e800, 00:40:95:30:81:14, IRQ 11
[    0.275659] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.275706] ehci-pci: EHCI PCI platform driver
[    0.275793] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.275868] ohci-pci: OHCI PCI platform driver
[    0.275939] uhci_hcd: USB Universal Host Controller Interface driver
[    0.276722] uhci_hcd 0000:00:07.2: UHCI Host Controller
[    0.276792] uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
[    0.276893] uhci_hcd 0000:00:07.2: irq 11, io base 0x0000d400
[    0.277555] hub 1-0:1.0: USB hub found
[    0.277627] hub 1-0:1.0: 2 ports detected
[    0.278214] uhci_hcd 0000:00:07.3: UHCI Host Controller
[    0.278290] uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
[    0.278375] uhci_hcd 0000:00:07.3: irq 11, io base 0x0000d800
[    0.278997] hub 2-0:1.0: USB hub found
[    0.279066] hub 2-0:1.0: 2 ports detected
[    0.279539] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    0.280235] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.280295] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.280783] mousedev: PS/2 mouse device common for all mice
[    0.281749] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
[    0.281852] rtc_cmos 00:02: alarms up to one year, y3k, 242 bytes nvram
[    0.282387] NET: Registered protocol family 17
[    0.282593] Using IPI No-Shortcut mode
[    0.283036] registered taskstats version 1
[    0.283703] rtc_cmos 00:02: setting system clock to 2016-09-28 19:08:23 UTC (1475089703)
[    0.283866] PM: Checking hibernation image partition /dev/sda2
[    0.308156] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input3
[    0.498866] ata1.00: ATA-6: WDC WD800JB-00FMA0, 13.03G13, max UDMA/100
[    0.498926] ata1.00: 156301488 sectors, multi 16: LBA 
[    0.501848] ata1.00: configured for UDMA/100
[    0.502370] scsi 0:0:0:0: Direct-Access     ATA      WDC WD800JB-00FM 3G13 PQ: 0 ANSI: 5
[    0.503388] sd 0:0:0:0: [sda] 156301488 512-byte logical blocks: (80.0 GB/74.5 GiB)
[    0.503616] sd 0:0:0:0: [sda] Write Protect is off
[    0.503664] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.503722] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    0.549410]  sda: sda1 sda2 sda3
[    0.550539] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.184055] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x114a463e20c, max_idle_ns: 440795244235 ns
[    1.220974] random: fast init done
[    1.737116] input: PS/2 BYD TouchPad as /devices/platform/i8042/serio1/input/input5
[    1.740085] PM: Hibernation image partition 8:2 present
[    1.740087] PM: Looking for hibernation image.
[    1.740615] PM: Image not found (code -22)
[    1.740618] PM: Hibernation image not present or could not be loaded.
[    1.741202] EXT4-fs (sda1): mounting ext3 file system using the ext4 subsystem
[    1.785258] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[    1.785379] VFS: Mounted root (ext3 filesystem) readonly on device 8:1.
[    1.786877] Freeing unused kernel memory: 524K (c15c1000 - c1644000)
[    1.787229] Write protecting the kernel text: 3920k
[    1.787356] Write protecting the kernel read-only data: 1528k
[    4.572096] random: crng init done
[    4.936733] systemd-udevd[179]: starting version 215
[    6.795864] agpgart: Detected VIA Apollo Pro 133 chipset
[    6.804332] agpgart-via 0000:00:00.0: AGP aperture is 64M @ 0xe0000000
[    6.900951] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    7.130344] parport_pc: VIA 686A/8231 detected
[    7.130352] parport_pc: probing current configuration
[    7.130374] parport_pc: Current parallel port base: 0x0
[    7.130377] parport_pc: VIA parallel port disabled in BIOS
[    7.200485] wmi: Mapper loaded
[    7.871076] nouveau 0000:01:00.0: NVIDIA NV05 (20154000)
[    7.890581] nouveau 0000:01:00.0: bios: version 02.05.20.02.00
[    7.890993] nouveau 0000:01:00.0: bios: DCB table not found
[    7.891539] nouveau 0000:01:00.0: bios: DCB table not found
[    7.891794] nouveau 0000:01:00.0: bios: DCB table not found
[    7.891846] nouveau 0000:01:00.0: bios: DCB table not found
[    7.891928] nouveau 0000:01:00.0: bios: DCB table not found
[    7.893392] agpgart-via 0000:00:00.0: AGP 2.0 bridge
[    7.893474] agpgart-via 0000:00:00.0: putting AGP V2 device into 4x mode
[    7.893550] nouveau 0000:01:00.0: putting AGP V2 device into 4x mode
[    7.893637] nouveau 0000:01:00.0: tmr: unknown input clock freq
[    7.895889] nouveau 0000:01:00.0: fb: 32 MiB SDRAM
[    7.904312] [TTM] Zone  kernel: Available graphics memory: 256412 kiB
[    7.904362] [TTM] Initializing pool allocator
[    7.904896] nouveau 0000:01:00.0: DRM: VRAM: 31 MiB
[    7.904960] nouveau 0000:01:00.0: DRM: GART: 64 MiB
[    7.905009] nouveau 0000:01:00.0: DRM: BMP version 5.6
[    7.905057] nouveau 0000:01:00.0: DRM: No DCB data found in VBIOS
[    7.908302] nouveau 0000:01:00.0: DRM: Saving VGA fonts
[    7.963697] nouveau 0000:01:00.0: DRM: No DCB data found in VBIOS
[    7.965090] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    7.965154] [drm] Driver supports precise vblank timestamp query.
[    7.971540] nouveau 0000:01:00.0: DRM: MM: using M2MF for buffer copies
[    8.054321] nouveau 0000:01:00.0: DRM: allocated 1280x1024 fb: 0x4000, bo dd746000
[    8.057924] fbcon: nouveaufb (fb0) is primary device
[    8.289029] Console: switching to colour frame buffer device 160x64
[    8.294694] nouveau 0000:01:00.0: fb0: nouveaufb frame buffer device
[    8.294742] [drm] Initialized nouveau 1.3.1 20120801 for 0000:01:00.0 on minor 0
[    9.548621] EXT4-fs (sda1): re-mounted. Opts: (null)
[   10.217650] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
[   11.864788] i2c /dev entries driver
[   17.113542] 8139too 0000:00:0f.0 eth0: link up, 10Mbps, half-duplex, lpa 0x0000

--Boundary-00=_EjB7X0yvjoJ7V1z--
