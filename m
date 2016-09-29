Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Ondrej Zary <linux@rainbow-software.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: 4.7 regression: ACPI: No IRQ available for PCI Interrupt Link [LNKD]. Try pci=noacpi or acpi=off
Date: Thu, 29 Sep 2016 20:00:56 +0200
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        wim@djo.tudelft.nl, ravikanth.nalla@hpe.com
References: <201609251512.05657.linux@rainbow-software.org> <201609291848.33803.linux@rainbow-software.org> <701eeb2f-bfc2-d541-4f6f-34be200ea44a@codeaurora.org>
In-Reply-To: <701eeb2f-bfc2-d541-4f6f-34be200ea44a@codeaurora.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_YbV7XJV5aNN1Cxt"
Message-Id: <201609292000.56943.linux@rainbow-software.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Boundary-00=_YbV7XJV5aNN1Cxt
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 29 September 2016 19:18:43 Sinan Kaya wrote:
> On 9/29/2016 12:48 PM, Ondrej Zary wrote:
> >> Let's see the new set. If this doesn't work, I'll have to provide you
> >> with
> >>
> >> > another patch to get the penalty counts again. The original debug aids
> >> > patch may not apply after these.
> >
> > It boots but the IRQ problem still remains the same. See the attached
> > logs: dmesg-bad.txt: without the irq -> link->irq.active change
> > dmesg-bad2.txt: with the irq -> link->irq.active change
> > dmesg-bad2-debug.txt: as above with modified debug patch
> >
> > @@ -876,8 +893,11 @@ void acpi_penalize_isa_irq(int irq, int active)
> >  {
> >         int penalty = active ? PIRQ_PENALTY_ISA_USED :
> > PIRQ_PENALTY_PCI_USING;
> >
> > -       if ((irq >= 0) && (irq < ARRAY_SIZE(acpi_isa_irq_penalty)))
> > +       if ((irq >= 0) && (irq < ARRAY_SIZE(acpi_isa_irq_penalty))) {
> >                 acpi_isa_irq_penalty[irq] += penalty;
> > +               pr_info("%s:%d acpi_isa_irq_penalty[%d]=0x%x active =
> > %d\n", __func__,
> > +                               __LINE__, irq, 
> > acpi_irq_get_penalty(irq), active);
> > +       }
> >  }
>
> The previous two patches were in the right direction.
>
> Can we also get the same output from 4.6 kernel with the attached patch for
> the same machine you sent these?

Here it is.

> Something about SCI still doesn't feel right.
>
> The IRQ assignment fails if the penalty is greater than
> PIRQ_PENALTY_ISA_ALWAYS. This will happen if BIOS tells us to use an IRQ
> and same IRQ is in use by the SCI.

-- 
Ondrej Zary

--Boundary-00=_YbV7XJV5aNN1Cxt
Content-Type: text/plain;
  charset="iso-8859-15";
  name="dmesg-4.6-debug.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg-4.6-debug.txt"

[    0.000000] Linux version 4.6.0+ (zary@gsql) (gcc version 4.7.2 (Debian 4.7.2-5) ) #128 SMP Thu Sep 29 19:56:02 CEST 2016
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
[    0.000000] initial memory mapped: [mem 0x00000000-0x01bfffff]
[    0.000000] Base memory trampoline at [c009b000] 9b000 size 16384
[    0.000000] BRK [0x0169b000, 0x0169bfff] PGTABLE
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
[    0.000000] BRK [0x0169c000, 0x0169cfff] PGTABLE
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
[    0.000000] free_area_init_node: node 0, pgdat c1599c40, node_mem_map dfbf0020
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
[    0.000000] percpu: Embedded 18 pages/cpu @dfbda000 s41676 r0 d32052 u73728
[    0.000000] pcpu-alloc: s41676 r0 d32052 u73728 alloc=18*4096
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 129934
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-test root=/dev/sda1 ro resume=/dev/sda2
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Initializing CPU#0
[    0.000000] Initializing HighMem for node 0 (00000000:00000000)
[    0.000000] Memory: 512400K/523832K available (3856K kernel code, 429K rwdata, 1496K rodata, 512K init, 408K bss, 11432K reserved, 0K cma-reserved, 0K highmem)
[    0.000000] virtual kernel memory layout:
    fixmap  : 0xfff17000 - 0xfffff000   ( 928 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xe07f0000 - 0xff7fe000   ( 496 MB)
    lowmem  : 0xc0000000 - 0xdfff0000   ( 511 MB)
      .init : 0xc15a9000 - 0xc1629000   ( 512 kB)
      .data : 0xc13c4417 - 0xc15a75e0   (1932 kB)
      .text : 0xc1000000 - 0xc13c4417   (3857 kB)
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
[    0.004009] Calibrating delay loop (skipped), value calculated using timer frequency.. 2398.60 BogoMIPS (lpj=4797208)
[    0.004101] pid_max: default: 32768 minimum: 301
[    0.004175] ACPI: Core revision 20160108
[    0.009459] ACPI: 1 ACPI AML tables successfully acquired and loaded

[    0.009603] ACPI: setting ELCR to 0800 (from 0e00)
[    0.009725] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.009772] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.010615] Last level iTLB entries: 4KB 32, 2MB 0, 4MB 2
[    0.010688] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 8, 1GB 0
[    0.014254] Freeing SMP alternatives memory: 16K (c1629000 - c162d000)
[    0.016474] smpboot: Max logical packages: 1
[    0.016535] smpboot: weird, boot CPU (#0) not listed by the BIOS
[    0.016579] smpboot: SMP motherboard not detected
[    0.016621] smpboot: SMP disabled
[    0.016666] smpboot: Local APIC not detected. Using dummy APIC emulation.
[    0.016746] Performance Events: 
[    0.016792] no APIC, boot with the "lapic" boot parameter to force-enable it.
[    0.016875] no hardware sampling interrupt available.
[    0.016920] p6 PMU driver.
[    0.016973] ... version:                0
[    0.017015] ... bit width:              32
[    0.017062] ... generic registers:      2
[    0.017104] ... value mask:             00000000ffffffff
[    0.017147] ... max period:             000000007fffffff
[    0.017193] ... fixed-purpose events:   0
[    0.017234] ... event mask:             0000000000000003
[    0.018186] x86: Booted up 1 node, 1 CPUs
[    0.018248] smpboot: Total of 1 processors activated (2398.60 BogoMIPS)
[    0.018779] devtmpfs: initialized
[    0.020295] PM: Registering ACPI NVS region [mem 0x1fff0000-0x1fff2fff] (12288 bytes)
[    0.020635] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.021134] NET: Registered protocol family 16
[    0.021645] cpuidle: using governor ladder
[    0.021697] cpuidle: using governor menu
[    0.021886] clocksource: pit: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1601818034827 ns
[    0.021971] ACPI: bus type PCI registered
[    0.065345] PCI: PCI BIOS revision 2.10 entry at 0xfb200, last bus=1
[    0.065393] PCI: Using configuration type 1 for base access
[    0.069220] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[    0.069778] ACPI: Added _OSI(Module Device)
[    0.069829] ACPI: Added _OSI(Processor Device)
[    0.069873] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.069919] ACPI: Added _OSI(Processor Aggregator Device)
[    0.074506] ACPI: Interpreter enabled
[    0.074626] ACPI: (supports S0 S1 S4 S5)
[    0.074672] ACPI: Using PIC for interrupt routing
[    0.074779] PCI: Ignoring host bridge windows from ACPI; if necessary, use "pci=use_crs" and report a bug
[    0.082302] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.082379] acpi PNP0A03:00: _OSC: OS supports [Segments MSI]
[    0.082436] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.082494] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.082666] acpi PNP0A03:00: host bridge window [io  0x0cf8-0x0cff] (ignored)
[    0.082674] acpi PNP0A03:00: host bridge window [io  0x0000-0x0cf7 window] (ignored)
[    0.082680] acpi PNP0A03:00: host bridge window [io  0x0d00-0x3fff window] (ignored)
[    0.082686] acpi PNP0A03:00: host bridge window [io  0x4000-0x407f] (ignored)
[    0.082692] acpi PNP0A03:00: host bridge window [io  0x4080-0x40ff] (ignored)
[    0.082698] acpi PNP0A03:00: host bridge window [io  0x4100-0x4fff window] (ignored)
[    0.082704] acpi PNP0A03:00: host bridge window [io  0x5000-0x500f] (ignored)
[    0.082710] acpi PNP0A03:00: host bridge window [io  0x5010-0x5fff window] (ignored)
[    0.082716] acpi PNP0A03:00: host bridge window [io  0x6000-0x607f] (ignored)
[    0.082722] acpi PNP0A03:00: host bridge window [io  0x6080-0xffff window] (ignored)
[    0.082728] acpi PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff window] (ignored)
[    0.082734] acpi PNP0A03:00: host bridge window [mem 0x000c0000-0x000dffff window] (ignored)
[    0.082741] acpi PNP0A03:00: host bridge window [mem 0x20000000-0xffefffff window] (ignored)
[    0.082746] PCI: root bus 00: using default resources
[    0.082883] PCI host bridge to bus 0000:00
[    0.082933] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.082980] pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffff]
[    0.083028] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.083096] pci 0000:00:00.0: [1106:0691] type 00 class 0x060000
[    0.083120] pci 0000:00:00.0: reg 0x10: [mem 0xe0000000-0xe3ffffff pref]
[    0.083371] pci 0000:00:01.0: [1106:8598] type 01 class 0x060400
[    0.083429] pci 0000:00:01.0: supports D1
[    0.083603] pci 0000:00:07.0: [1106:0686] type 00 class 0x060100
[    0.083850] pci 0000:00:07.1: [1106:0571] type 00 class 0x01018a
[    0.083897] pci 0000:00:07.1: reg 0x20: [io  0xd000-0xd00f]
[    0.083920] pci 0000:00:07.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.084034] pci 0000:00:07.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.084081] pci 0000:00:07.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.084129] pci 0000:00:07.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.084366] pci 0000:00:07.2: [1106:3038] type 00 class 0x0c0300
[    0.084411] pci 0000:00:07.2: reg 0x20: [io  0xd400-0xd41f]
[    0.084540] pci 0000:00:07.2: System wakeup disabled by ACPI
[    0.084695] pci 0000:00:07.3: [1106:3038] type 00 class 0x0c0300
[    0.084739] pci 0000:00:07.3: reg 0x20: [io  0xd800-0xd81f]
[    0.084873] pci 0000:00:07.3: System wakeup disabled by ACPI
[    0.085034] pci 0000:00:07.4: [1106:3057] type 00 class 0x068000
[    0.085101] pci 0000:00:07.4: quirk: [io  0x6000-0x607f] claimed by vt82c686 HW-mon
[    0.085153] pci 0000:00:07.4: quirk: [io  0x5000-0x500f] claimed by vt82c686 SMB
[    0.085395] pci 0000:00:07.5: [1106:3058] type 00 class 0x040100
[    0.085417] pci 0000:00:07.5: reg 0x10: [io  0xdc00-0xdcff]
[    0.085430] pci 0000:00:07.5: reg 0x14: [io  0xe000-0xe003]
[    0.085443] pci 0000:00:07.5: reg 0x18: [io  0xe400-0xe403]
[    0.085670] pci 0000:00:0f.0: [10ec:8139] type 00 class 0x020000
[    0.085691] pci 0000:00:0f.0: reg 0x10: [io  0xe800-0xe8ff]
[    0.085705] pci 0000:00:0f.0: reg 0x14: [mem 0xe8000000-0xe80000ff]
[    0.085774] pci 0000:00:0f.0: supports D1 D2
[    0.085781] pci 0000:00:0f.0: PME# supported from D1 D2 D3hot
[    0.086043] pci 0000:01:00.0: [10de:002d] type 00 class 0x030000
[    0.086064] pci 0000:01:00.0: reg 0x10: [mem 0xe6000000-0xe6ffffff]
[    0.086077] pci 0000:01:00.0: reg 0x14: [mem 0xe4000000-0xe5ffffff pref]
[    0.086112] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    0.086268] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.086325] pci 0000:00:01.0:   bridge window [mem 0xe6000000-0xe7ffffff]
[    0.086334] pci 0000:00:01.0:   bridge window [mem 0xe4000000-0xe5ffffff pref]
[    0.086347] pci_bus 0000:00: on NUMA node 0
[    0.086700] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
[    0.087419] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[    0.088314] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
[    0.089073] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *9
[    0.091477] vgaarb: setting as boot device: PCI:0000:01:00.0
[    0.091535] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.091583] vgaarb: loaded
[    0.091626] vgaarb: bridge control possible 0000:01:00.0
[    0.092045] SCSI subsystem initialized
[    0.092266] libata version 3.00 loaded.
[    0.092291] ACPI: bus type USB registered
[    0.092424] usbcore: registered new interface driver usbfs
[    0.092501] usbcore: registered new interface driver hub
[    0.092583] usbcore: registered new device driver usb
[    0.092745] PCI: Using ACPI for IRQ routing
[    0.092800] PCI: pci_cache_line_size set to 32 bytes
[    0.092849] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.092856] e820: reserve RAM buffer [mem 0x1fff0000-0x1fffffff]
[    0.093920] clocksource: Switched to clocksource pit
[    0.112232] pnp: PnP ACPI init
[    0.113113] system 00:00: [mem 0x000ca800-0x000cbfff] has been reserved
[    0.113175] system 00:00: [mem 0x000f0000-0x000f7fff] could not be reserved
[    0.113226] system 00:00: [mem 0x000f8000-0x000fbfff] could not be reserved
[    0.113274] system 00:00: [mem 0x000fc000-0x000fffff] could not be reserved
[    0.113323] system 00:00: [mem 0x1fff0000-0x1fffffff] could not be reserved
[    0.113371] system 00:00: [mem 0xffff0000-0xffffffff] has been reserved
[    0.113419] system 00:00: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.113468] system 00:00: [mem 0x00100000-0x1ffeffff] could not be reserved
[    0.113515] system 00:00: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.113574] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.114060] system 00:01: [io  0x04d0-0x04d1] has been reserved
[    0.114247] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.114303] acpi_penalize_isa_irq:845 acpi_isa_irq_penalty[8]=0x110000 active = 1
[    0.114411] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.114667] acpi_penalize_isa_irq:845 acpi_isa_irq_penalty[6]=0x11005c active = 1
[    0.114725] pnp 00:03: [dma 2]
[    0.114752] acpi_penalize_isa_irq:845 acpi_isa_irq_penalty[6]=0x11105c active = 0
[    0.116002] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.116902] acpi_penalize_isa_irq:845 acpi_isa_irq_penalty[12]=0x20005c active = 1
[    0.117021] pnp 00:04: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.117090] acpi_penalize_isa_irq:845 acpi_isa_irq_penalty[1]=0x110005c active = 1
[    0.117194] pnp 00:05: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.117249] pnp: PnP ACPI: found 6 devices
[    0.117327] PnPBIOS: Disabled by ACPI PNP
[    0.157217] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.157340] clocksource: Switched to clocksource acpi_pm
[    0.157457] pci 0000:01:00.0: BAR 6: assigned [mem 0xe7000000-0xe700ffff pref]
[    0.157512] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.157564] pci 0000:00:01.0:   bridge window [mem 0xe6000000-0xe7ffffff]
[    0.157612] pci 0000:00:01.0:   bridge window [mem 0xe4000000-0xe5ffffff pref]
[    0.157670] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
[    0.157677] pci_bus 0000:00: resource 5 [mem 0x00000000-0xffffffff]
[    0.157684] pci_bus 0000:01: resource 1 [mem 0xe6000000-0xe7ffffff]
[    0.157690] pci_bus 0000:01: resource 2 [mem 0xe4000000-0xe5ffffff pref]
[    0.157835] NET: Registered protocol family 2
[    0.158471] TCP established hash table entries: 4096 (order: 2, 16384 bytes)
[    0.158588] TCP bind hash table entries: 4096 (order: 3, 32768 bytes)
[    0.158747] TCP: Hash tables configured (established 4096 bind 4096)
[    0.158885] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    0.158963] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    0.159262] NET: Registered protocol family 1
[    0.159397] pci 0000:00:01.0: disabling DAC on VIA PCI bridge
[    0.159453] pci 0000:00:07.0: Disabling VIA external APIC routing
[    0.159779] irq : 15
[    0.159824] acpi_irq_balance : 0
[    0.159867] link->irq.active : 0
[    0.159909] acpi_gbl_FADT.sci_interrupt : 11
[    0.159951] acpi_irq_get_penalty(11) : 0x5c
[    0.159997] acpi_irq_get_penalty(15) : 0x10005c
[    0.160138] penalty[15] = 0x10005c
[    0.160186] penalty[14] = 0x10005c
[    0.160227] penalty[12] = 0x20005c
[    0.160269] penalty[11] = 0x5c
[    0.160314] penalty[10] = 0x5c
[    0.160356] penalty[7] = 0x1005c
[    0.160398] penalty[6] = 0x11105c
[    0.160442] penalty[5] = 0x1005c
[    0.160483] penalty[4] = 0x1005c
[    0.160525] penalty[3] = 0x1005c
[    0.160566] penalty[1] = 0x110005c
[    0.160607] irq : 11
[    0.160648] acpi_gbl_FADT.sci_interrupt : 11
[    0.161439] acpi_irq_get_penalty(11) : 0x105c
[    0.161485] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
[    0.161532] PCI: setting IRQ 11 as level-triggered
[    0.161548] pci 0000:00:07.2: VIA VLink IRQ fixup, from 9 to 11
[    0.161948] pci 0000:00:07.3: VIA VLink IRQ fixup, from 9 to 11
[    0.162195] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.162251] PCI: CLS 32 bytes, default 32
[    0.163852] futex hash table entries: 256 (order: 1, 8192 bytes)
[    0.165148] workingset: timestamp_bits=28 max_order=17 bucket_order=0
[    0.174569] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.174650] io scheduler noop registered
[    0.174701] io scheduler deadline registered
[    0.174863] io scheduler cfq registered (default)
[    0.175278] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.175341] ACPI: Power Button [PWRB]
[    0.175543] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1
[    0.175595] ACPI: Sleep Button [SLPB]
[    0.175803] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    0.175854] ACPI: Power Button [PWRF]
[    0.176155] tsc: Marking TSC unstable due to TSC halts in idle
[    0.176353] Warning: Processor Platform Limit event detected, but not handled.
[    0.176401] Consider compiling CPUfreq support into your kernel.
[    0.176941] isapnp: Scanning for PnP cards...
[    0.263362] acpi_penalize_isa_irq:845 acpi_isa_irq_penalty[4]=0x1105c active = 0
[    0.263415] acpi_penalize_isa_irq:845 acpi_isa_irq_penalty[5]=0x1105c active = 0
[    0.263464] acpi_penalize_isa_irq:845 acpi_isa_irq_penalty[7]=0x1105c active = 0
[    0.263514] acpi_penalize_isa_irq:845 acpi_isa_irq_penalty[10]=0x105c active = 0
[    0.263562] acpi_penalize_isa_irq:845 acpi_isa_irq_penalty[11]=0x205c active = 0
[    0.263616] acpi_penalize_isa_irq:845 acpi_isa_irq_penalty[12]=0x20105c active = 0
[    0.263664] acpi_penalize_isa_irq:845 acpi_isa_irq_penalty[15]=0x10105c active = 0
[    0.263946]  01:01: card 'SYM 53C416'
[    0.263995] isapnp: 1 Plug & Play card detected total
[    0.264315] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.265613] Non-volatile memory driver v1.3
[    0.265671] Linux agpgart interface v0.103
[    0.265787] [drm] Initialized drm 1.1.0 20060810
[    0.273582] loop: module loaded
[    0.273985] pata_via 0000:00:07.1: version 0.3.4
[    0.275255] scsi host0: pata_via
[    0.275708] scsi host1: pata_via
[    0.275922] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xd000 irq 14
[    0.275971] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xd008 irq 15
[    0.276314] 8139cp: 8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
[    0.276367] 8139cp 0000:00:0f.0: This (id 10ec:8139 rev 10) is not an 8139C+ compatible chip, use 8139too
[    0.276476] 8139too: 8139too Fast Ethernet driver 0.9.28
[    0.276811] irq : 11
[    0.276856] acpi_irq_balance : 0
[    0.276898] link->irq.active : 11
[    0.276940] acpi_gbl_FADT.sci_interrupt : 11
[    0.276985] penalty[15] = 0x10105c
[    0.277026] penalty[14] = 0x10005c
[    0.277068] penalty[12] = 0x20105c
[    0.277111] penalty[11] = 0x205c
[    0.277153] penalty[10] = 0x105c
[    0.277195] penalty[7] = 0x1105c
[    0.277238] penalty[6] = 0x11105c
[    0.277279] penalty[5] = 0x1105c
[    0.277321] penalty[4] = 0x1105c
[    0.277364] penalty[3] = 0x1005c
[    0.277406] penalty[1] = 0x110005c
[    0.277447] irq : 11
[    0.277490] acpi_gbl_FADT.sci_interrupt : 11
[    0.278259] acpi_irq_get_penalty(11) : 0x305c
[    0.278305] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
[    0.279067] 8139too 0000:00:0f.0 eth0: RealTek RTL8139 at 0x0001e800, 00:40:95:30:81:14, IRQ 11
[    0.279193] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.279243] ehci-pci: EHCI PCI platform driver
[    0.279340] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.279417] ohci-pci: OHCI PCI platform driver
[    0.279492] uhci_hcd: USB Universal Host Controller Interface driver
[    0.279805] uhci_hcd 0000:00:07.2: UHCI Host Controller
[    0.279868] uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
[    0.279964] uhci_hcd 0000:00:07.2: irq 11, io base 0x0000d400
[    0.281114] hub 1-0:1.0: USB hub found
[    0.281193] hub 1-0:1.0: 2 ports detected
[    0.281810] uhci_hcd 0000:00:07.3: UHCI Host Controller
[    0.281887] uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
[    0.281984] uhci_hcd 0000:00:07.3: irq 11, io base 0x0000d800
[    0.282578] hub 2-0:1.0: USB hub found
[    0.282651] hub 2-0:1.0: 2 ports detected
[    0.283159] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    0.283752] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.283815] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.284428] mousedev: PS/2 mouse device common for all mice
[    0.285425] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
[    0.285531] rtc_cmos 00:02: alarms up to one year, y3k, 242 bytes nvram
[    0.286183] NET: Registered protocol family 17
[    0.286429] Using IPI No-Shortcut mode
[    0.286983] registered taskstats version 1
[    0.287740] console [netcon0] enabled
[    0.287791] netconsole: network logging started
[    0.287915] rtc_cmos 00:02: setting system clock to 2016-09-29 17:58:45 UTC (1475171925)
[    0.288180] PM: Checking hibernation image partition /dev/sda2
[    0.312622] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input3
[    0.494866] ata1.00: ATA-6: WDC WD800JB-00FMA0, 13.03G13, max UDMA/100
[    0.494928] ata1.00: 156301488 sectors, multi 16: LBA 
[    0.497847] ata1.00: configured for UDMA/100
[    0.498361] scsi 0:0:0:0: Direct-Access     ATA      WDC WD800JB-00FM 3G13 PQ: 0 ANSI: 5
[    0.499361] sd 0:0:0:0: [sda] 156301488 512-byte logical blocks: (80.0 GB/74.5 GiB)
[    0.499585] sd 0:0:0:0: [sda] Write Protect is off
[    0.499634] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.499691] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    0.544694]  sda: sda1 sda2 sda3
[    0.545783] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.160053] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1149885dbc2, max_idle_ns: 440795234021 ns
[    1.737430] input: PS/2 BYD TouchPad as /devices/platform/i8042/serio1/input/input5
[    1.740361] PM: Hibernation image partition 8:2 present
[    1.740367] PM: Looking for hibernation image.
[    1.740900] PM: Image not found (code -22)
[    1.740906] PM: Hibernation image not present or could not be loaded.
[    1.741560] EXT4-fs (sda1): mounting ext3 file system using the ext4 subsystem
[    1.788876] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[    1.789004] VFS: Mounted root (ext3 filesystem) readonly on device 8:1.
[    1.790443] Freeing unused kernel memory: 512K (c15a9000 - c1629000)
[    1.790832] Write protecting the kernel text: 3860k
[    1.790974] Write protecting the kernel read-only data: 1500k
[    3.535103] random: nonblocking pool is initialized
[    4.692690] systemd-udevd[166]: starting version 215
[    9.060335] EXT4-fs (sda1): re-mounted. Opts: (null)
[    9.738355] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
[   16.490698] 8139too 0000:00:0f.0 eth0: link up, 10Mbps, half-duplex, lpa 0x0000

--Boundary-00=_YbV7XJV5aNN1Cxt--
