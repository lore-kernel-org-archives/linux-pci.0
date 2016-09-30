Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Ondrej Zary <linux@rainbow-software.org>
To: okaya@codeaurora.org
Subject: Re: 4.7 regression: ACPI: No IRQ available for PCI Interrupt Link [LNKD]. Try pci=noacpi or acpi=off
Date: Fri, 30 Sep 2016 17:56:25 +0200
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        wim@djo.tudelft.nl, ravikanth.nalla@hpe.com
References: <201609251512.05657.linux@rainbow-software.org> <201609300844.24325.linux@rainbow-software.org> <677698369b23f5a6bcf3a66fed78802f@codeaurora.org>
In-Reply-To: <677698369b23f5a6bcf3a66fed78802f@codeaurora.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_pso7XzWd1mwstzT"
Message-Id: <201609301756.25894.linux@rainbow-software.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Boundary-00=_pso7XzWd1mwstzT
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 30 September 2016 15:14:42 okaya@codeaurora.org wrote:
> On 2016-09-30 02:44, Ondrej Zary wrote:
> > On Friday 30 September 2016, Sinan Kaya wrote:
> >> On 9/29/2016 2:00 PM, Ondrej Zary wrote:
> >> >> The previous two patches were in the right direction.
> >> >>
> >> >> > Can we also get the same output from 4.6 kernel with the attached
> >> >> > patch for the same machine you sent these?
> >> >
> >> > Here it is.
> >> >
> >> >> > Something about SCI still doesn't feel right.
> >> >> >
> >> >> > The IRQ assignment fails if the penalty is greater than
> >> >> > PIRQ_PENALTY_ISA_ALWAYS. This will happen if BIOS tells us to use
> >> >> > an IRQ and same IRQ is in use by the SCI.
> >>
> >> Thanks, I reverted penalize_sci function and dropped patch #1. Can you
> >> try
> >> this again?
> >
> > It seems to work, at least on one machine.
>
> Ok, that comfirms my suspicion. We are  having trouble detecting sci
> interrupt  type and we end up penalizing the wrong value.
>
> Can you try your other machines too?

Works on the 2nd one too.

> I need to do some research now.


-- 
Ondrej Zary

--Boundary-00=_pso7XzWd1mwstzT
Content-Type: text/plain;
  charset="iso-8859-15";
  name="dmesg-good.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg-good.txt"

[    0.000000] Linux version 4.8.0-rc8+ (zary@gsql) (gcc version 4.7.2 (Debian 4.7.2-5) ) #131 SMP Fri Sep 30 17:47:43 CEST 2016
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
[    0.000000] BRK [0x016b6000, 0x016b6fff] PGTABLE
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
[    0.000000] BRK [0x016b7000, 0x016b7fff] PGTABLE
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
[    0.000000] free_area_init_node: node 0, pgdat c15b13e0, node_mem_map dfbf0020
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
[    0.000000] Memory: 512288K/523832K available (3918K kernel code, 435K rwdata, 1520K rodata, 524K init, 412K bss, 11544K reserved, 0K cma-reserved, 0K highmem)
[    0.000000] virtual kernel memory layout:
    fixmap  : 0xfff17000 - 0xfffff000   ( 928 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xe07f0000 - 0xff7fe000   ( 496 MB)
    lowmem  : 0xc0000000 - 0xdfff0000   ( 511 MB)
      .init : 0xc15c0000 - 0xc1643000   ( 524 kB)
      .data : 0xc13d3d65 - 0xc15bee20   (1964 kB)
      .text : 0xc1000000 - 0xc13d3d65   (3919 kB)
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
[    0.000000] tsc: Detected 1199.463 MHz processor
[    0.008010] Calibrating delay loop (skipped), value calculated using timer frequency.. 2398.92 BogoMIPS (lpj=4797852)
[    0.008103] pid_max: default: 32768 minimum: 301
[    0.008175] ACPI: Core revision 20160422
[    0.013495] ACPI: 1 ACPI AML tables successfully acquired and loaded

[    0.013636] ACPI: setting ELCR to 0400 (from 0e00)
[    0.013751] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.013798] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.014639] Last level iTLB entries: 4KB 32, 2MB 0, 4MB 2
[    0.014709] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 8, 1GB 0
[    0.018335] Freeing SMP alternatives memory: 16K (c1643000 - c1647000)
[    0.020475] smpboot: Max logical packages: 1
[    0.020536] smpboot: weird, boot CPU (#0) not listed by the BIOS
[    0.020583] smpboot: SMP motherboard not detected
[    0.020625] smpboot: SMP disabled
[    0.020669] smpboot: Local APIC not detected. Using dummy APIC emulation.
[    0.020717] Performance Events: 
[    0.020763] no APIC, boot with the "lapic" boot parameter to force-enable it.
[    0.020846] no hardware sampling interrupt available.
[    0.020891] p6 PMU driver.
[    0.020940] ... version:                0
[    0.020982] ... bit width:              32
[    0.021027] ... generic registers:      2
[    0.021069] ... value mask:             00000000ffffffff
[    0.021111] ... max period:             000000007fffffff
[    0.021157] ... fixed-purpose events:   0
[    0.021199] ... event mask:             0000000000000003
[    0.022236] x86: Booted up 1 node, 1 CPUs
[    0.022307] smpboot: Total of 1 processors activated (2398.92 BogoMIPS)
[    0.022848] devtmpfs: initialized
[    0.024381] PM: Registering ACPI NVS region [mem 0x1fff0000-0x1fff2fff] (12288 bytes)
[    0.024628] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.024961] NET: Registered protocol family 16
[    0.025437] cpuidle: using governor ladder
[    0.025486] cpuidle: using governor menu
[    0.025639] clocksource: pit: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1601818034827 ns
[    0.025704] ACPI: bus type PCI registered
[    0.068892] PCI: PCI BIOS revision 2.10 entry at 0xfb200, last bus=1
[    0.068941] PCI: Using configuration type 1 for base access
[    0.072796] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[    0.073288] ACPI: Added _OSI(Module Device)
[    0.073339] ACPI: Added _OSI(Processor Device)
[    0.073386] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.073429] ACPI: Added _OSI(Processor Aggregator Device)
[    0.077966] ACPI: Interpreter enabled
[    0.078083] ACPI: (supports S0 S1 S4 S5)
[    0.078131] ACPI: Using PIC for interrupt routing
[    0.078230] PCI: Ignoring host bridge windows from ACPI; if necessary, use "pci=use_crs" and report a bug
[    0.085722] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.085799] acpi PNP0A03:00: _OSC: OS supports [Segments MSI]
[    0.085854] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.085909] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.086076] acpi PNP0A03:00: host bridge window [io  0x0cf8-0x0cff] (ignored)
[    0.086081] acpi PNP0A03:00: host bridge window [io  0x0000-0x0cf7 window] (ignored)
[    0.086085] acpi PNP0A03:00: host bridge window [io  0x0d00-0x3fff window] (ignored)
[    0.086089] acpi PNP0A03:00: host bridge window [io  0x4000-0x407f] (ignored)
[    0.086093] acpi PNP0A03:00: host bridge window [io  0x4080-0x40ff] (ignored)
[    0.086097] acpi PNP0A03:00: host bridge window [io  0x4100-0x4fff window] (ignored)
[    0.086101] acpi PNP0A03:00: host bridge window [io  0x5000-0x500f] (ignored)
[    0.086105] acpi PNP0A03:00: host bridge window [io  0x5010-0x5fff window] (ignored)
[    0.086108] acpi PNP0A03:00: host bridge window [io  0x6000-0x607f] (ignored)
[    0.086112] acpi PNP0A03:00: host bridge window [io  0x6080-0xffff window] (ignored)
[    0.086117] acpi PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff window] (ignored)
[    0.086121] acpi PNP0A03:00: host bridge window [mem 0x000c0000-0x000dffff window] (ignored)
[    0.086125] acpi PNP0A03:00: host bridge window [mem 0x20000000-0xffefffff window] (ignored)
[    0.086129] PCI: root bus 00: using default resources
[    0.086246] PCI host bridge to bus 0000:00
[    0.086296] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.086341] pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffff]
[    0.086390] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.086458] pci 0000:00:00.0: [1106:0691] type 00 class 0x060000
[    0.086479] pci 0000:00:00.0: reg 0x10: [mem 0xe0000000-0xe3ffffff pref]
[    0.086725] pci 0000:00:01.0: [1106:8598] type 01 class 0x060400
[    0.086777] pci 0000:00:01.0: supports D1
[    0.086921] pci 0000:00:07.0: [1106:0686] type 00 class 0x060100
[    0.087186] pci 0000:00:07.1: [1106:0571] type 00 class 0x01018a
[    0.087230] pci 0000:00:07.1: reg 0x20: [io  0xd000-0xd00f]
[    0.087251] pci 0000:00:07.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.087301] pci 0000:00:07.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.087350] pci 0000:00:07.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.087395] pci 0000:00:07.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.087620] pci 0000:00:07.2: [1106:3038] type 00 class 0x0c0300
[    0.087661] pci 0000:00:07.2: reg 0x20: [io  0xd400-0xd41f]
[    0.087786] pci 0000:00:07.2: System wakeup disabled by ACPI
[    0.087945] pci 0000:00:07.3: [1106:3038] type 00 class 0x0c0300
[    0.088057] pci 0000:00:07.3: reg 0x20: [io  0xd800-0xd81f]
[    0.088191] pci 0000:00:07.3: System wakeup disabled by ACPI
[    0.088359] pci 0000:00:07.4: [1106:3057] type 00 class 0x068000
[    0.088423] pci 0000:00:07.4: quirk: [io  0x6000-0x607f] claimed by vt82c686 HW-mon
[    0.088474] pci 0000:00:07.4: quirk: [io  0x5000-0x500f] claimed by vt82c686 SMB
[    0.088700] pci 0000:00:07.5: [1106:3058] type 00 class 0x040100
[    0.088717] pci 0000:00:07.5: reg 0x10: [io  0xdc00-0xdcff]
[    0.088728] pci 0000:00:07.5: reg 0x14: [io  0xe000-0xe003]
[    0.088739] pci 0000:00:07.5: reg 0x18: [io  0xe400-0xe403]
[    0.088969] pci 0000:00:10.0: [10ec:8139] type 00 class 0x020000
[    0.088986] pci 0000:00:10.0: reg 0x10: [io  0xe800-0xe8ff]
[    0.088997] pci 0000:00:10.0: reg 0x14: [mem 0xe8000000-0xe80000ff]
[    0.089060] pci 0000:00:10.0: supports D1 D2
[    0.089065] pci 0000:00:10.0: PME# supported from D1 D2 D3hot
[    0.089309] pci 0000:01:00.0: [10de:002d] type 00 class 0x030000
[    0.089326] pci 0000:01:00.0: reg 0x10: [mem 0xe6000000-0xe6ffffff]
[    0.089337] pci 0000:01:00.0: reg 0x14: [mem 0xe4000000-0xe5ffffff pref]
[    0.089369] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    0.089510] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.089566] pci 0000:00:01.0:   bridge window [mem 0xe6000000-0xe7ffffff]
[    0.089573] pci 0000:00:01.0:   bridge window [mem 0xe4000000-0xe5ffffff pref]
[    0.089584] pci_bus 0000:00: on NUMA node 0
[    0.089966] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
[    0.090712] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
[    0.091459] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *9
[    0.092291] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
[    0.094684] vgaarb: setting as boot device: PCI:0000:01:00.0
[    0.094743] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.094790] vgaarb: loaded
[    0.094834] vgaarb: bridge control possible 0000:01:00.0
[    0.095102] SCSI subsystem initialized
[    0.095307] libata version 3.00 loaded.
[    0.095321] ACPI: bus type USB registered
[    0.095441] usbcore: registered new interface driver usbfs
[    0.095517] usbcore: registered new interface driver hub
[    0.095595] usbcore: registered new device driver usb
[    0.095719] PCI: Using ACPI for IRQ routing
[    0.095776] PCI: pci_cache_line_size set to 32 bytes
[    0.095822] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.095827] e820: reserve RAM buffer [mem 0x1fff0000-0x1fffffff]
[    0.096886] clocksource: Switched to clocksource pit
[    0.116708] pnp: PnP ACPI init
[    0.117606] system 00:00: [mem 0x000ca800-0x000cbfff] has been reserved
[    0.117669] system 00:00: [mem 0x000f0000-0x000f7fff] could not be reserved
[    0.117718] system 00:00: [mem 0x000f8000-0x000fbfff] could not be reserved
[    0.117766] system 00:00: [mem 0x000fc000-0x000fffff] could not be reserved
[    0.117814] system 00:00: [mem 0x1fff0000-0x1fffffff] could not be reserved
[    0.117862] system 00:00: [mem 0xffff0000-0xffffffff] has been reserved
[    0.117909] system 00:00: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.117956] system 00:00: [mem 0x00100000-0x1ffeffff] could not be reserved
[    0.118004] system 00:00: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.118063] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.118517] system 00:01: [io  0x04d0-0x04d1] has been reserved
[    0.118572] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.118666] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.118927] pnp 00:03: [dma 2]
[    0.119028] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.120141] pnp 00:04: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.120254] pnp 00:05: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.120306] pnp: PnP ACPI: found 6 devices
[    0.120367] PnPBIOS: Disabled
[    0.160106] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.161358] clocksource: Switched to clocksource acpi_pm
[    0.161467] pci 0000:01:00.0: BAR 6: assigned [mem 0xe7000000-0xe700ffff pref]
[    0.161526] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.161578] pci 0000:00:01.0:   bridge window [mem 0xe6000000-0xe7ffffff]
[    0.161626] pci 0000:00:01.0:   bridge window [mem 0xe4000000-0xe5ffffff pref]
[    0.161686] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
[    0.161691] pci_bus 0000:00: resource 5 [mem 0x00000000-0xffffffff]
[    0.161696] pci_bus 0000:01: resource 1 [mem 0xe6000000-0xe7ffffff]
[    0.161700] pci_bus 0000:01: resource 2 [mem 0xe4000000-0xe5ffffff pref]
[    0.161809] NET: Registered protocol family 2
[    0.162383] TCP established hash table entries: 4096 (order: 2, 16384 bytes)
[    0.162502] TCP bind hash table entries: 4096 (order: 3, 32768 bytes)
[    0.162664] TCP: Hash tables configured (established 4096 bind 4096)
[    0.162795] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    0.162876] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    0.163267] NET: Registered protocol family 1
[    0.163390] pci 0000:00:01.0: disabling DAC on VIA PCI bridge
[    0.163443] pci 0000:00:07.0: Disabling VIA external APIC routing
[    0.164594] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
[    0.164645] PCI: setting IRQ 11 as level-triggered
[    0.165178] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.165233] PCI: CLS 32 bytes, default 32
[    0.166618] futex hash table entries: 256 (order: 1, 8192 bytes)
[    0.167702] workingset: timestamp_bits=30 max_order=17 bucket_order=0
[    0.176200] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.176276] io scheduler noop registered
[    0.176319] io scheduler deadline registered
[    0.176472] io scheduler cfq registered (default)
[    0.177199] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.177264] ACPI: Power Button [PWRB]
[    0.177472] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1
[    0.177525] ACPI: Sleep Button [SLPB]
[    0.177718] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    0.177775] ACPI: Power Button [PWRF]
[    0.177959] tsc: Marking TSC unstable due to TSC halts in idle
[    0.178166] Warning: Processor Platform Limit event detected, but not handled.
[    0.178219] Consider compiling CPUfreq support into your kernel.
[    0.178894] isapnp: Scanning for PnP cards...
[    0.265526]  01:01: card 'SYM 53C416'
[    0.265573] isapnp: 1 Plug & Play card detected total
[    0.265801] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.267083] Non-volatile memory driver v1.3
[    0.267138] Linux agpgart interface v0.103
[    0.267247] [drm] Initialized drm 1.1.0 20060810
[    0.275011] loop: module loaded
[    0.275365] pata_via 0000:00:07.1: version 0.3.4
[    0.276741] scsi host0: pata_via
[    0.277152] scsi host1: pata_via
[    0.277354] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xd000 irq 14
[    0.277403] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xd008 irq 15
[    0.277628] 8139cp: 8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
[    0.277680] 8139cp 0000:00:10.0: This (id 10ec:8139 rev 10) is not an 8139C+ compatible chip, use 8139too
[    0.277792] 8139too: 8139too Fast Ethernet driver 0.9.28
[    0.278847] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
[    0.279601] 8139too 0000:00:10.0 eth0: RealTek RTL8139 at 0x0001e800, 00:40:95:30:81:14, IRQ 11
[    0.279704] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.279750] ehci-pci: EHCI PCI platform driver
[    0.279840] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.279917] ohci-pci: OHCI PCI platform driver
[    0.279987] uhci_hcd: USB Universal Host Controller Interface driver
[    0.280773] uhci_hcd 0000:00:07.2: UHCI Host Controller
[    0.280844] uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
[    0.280946] uhci_hcd 0000:00:07.2: irq 11, io base 0x0000d400
[    0.281611] hub 1-0:1.0: USB hub found
[    0.281680] hub 1-0:1.0: 2 ports detected
[    0.282265] uhci_hcd 0000:00:07.3: UHCI Host Controller
[    0.282337] uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
[    0.282423] uhci_hcd 0000:00:07.3: irq 11, io base 0x0000d800
[    0.283037] hub 2-0:1.0: USB hub found
[    0.283105] hub 2-0:1.0: 2 ports detected
[    0.283579] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    0.284268] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.284327] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.284810] mousedev: PS/2 mouse device common for all mice
[    0.285780] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
[    0.285881] rtc_cmos 00:02: alarms up to one year, y3k, 242 bytes nvram
[    0.286418] NET: Registered protocol family 17
[    0.286626] Using IPI No-Shortcut mode
[    0.287084] registered taskstats version 1
[    0.287818] console [netcon0] enabled
[    0.287870] netconsole: network logging started
[    0.287991] rtc_cmos 00:02: setting system clock to 2016-09-30 15:52:41 UTC (1475250761)
[    0.288212] PM: Checking hibernation image partition /dev/sda2
[    0.311925] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input3
[    0.502849] ata1.00: ATA-6: WDC WD800JB-00FMA0, 13.03G13, max UDMA/100
[    0.502909] ata1.00: 156301488 sectors, multi 16: LBA 
[    0.505829] ata1.00: configured for UDMA/100
[    0.506349] scsi 0:0:0:0: Direct-Access     ATA      WDC WD800JB-00FM 3G13 PQ: 0 ANSI: 5
[    0.507365] sd 0:0:0:0: [sda] 156301488 512-byte logical blocks: (80.0 GB/74.5 GiB)
[    0.507583] sd 0:0:0:0: [sda] Write Protect is off
[    0.507631] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.507689] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    0.557652]  sda: sda1 sda2 sda3
[    0.558774] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.184052] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x114a205d4d6, max_idle_ns: 440795204040 ns
[    1.227921] random: fast init done
[    1.741876] input: PS/2 BYD TouchPad as /devices/platform/i8042/serio1/input/input5
[    1.744824] PM: Hibernation image partition 8:2 present
[    1.744826] PM: Looking for hibernation image.
[    1.745352] PM: Image not found (code -22)
[    1.745356] PM: Hibernation image not present or could not be loaded.
[    1.745942] EXT4-fs (sda1): mounting ext3 file system using the ext4 subsystem
[    1.785224] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[    1.785348] VFS: Mounted root (ext3 filesystem) readonly on device 8:1.
[    1.786842] Freeing unused kernel memory: 524K (c15c0000 - c1643000)
[    1.787199] Write protecting the kernel text: 3920k
[    1.787323] Write protecting the kernel read-only data: 1528k
[    4.650945] random: crng init done
[    4.963723] systemd-udevd[179]: starting version 215
[    6.855788] agpgart: Detected VIA Apollo Pro 133 chipset
[    6.870355] agpgart-via 0000:00:00.0: AGP aperture is 64M @ 0xe0000000
[    7.092113] wmi: Mapper loaded
[    7.177739] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    7.217611] parport_pc: VIA 686A/8231 detected
[    7.217618] parport_pc: probing current configuration
[    7.217637] parport_pc: Current parallel port base: 0x0
[    7.217640] parport_pc: VIA parallel port disabled in BIOS
[    7.411060] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
[    7.411129] PCI: setting IRQ 10 as level-triggered
[    7.411540] nouveau 0000:01:00.0: NVIDIA NV05 (20154000)
[    7.462262] nouveau 0000:01:00.0: bios: version 02.05.20.02.00
[    7.557840] nouveau 0000:01:00.0: bios: DCB table not found
[    7.558071] nouveau 0000:01:00.0: bios: DCB table not found
[    7.558186] nouveau 0000:01:00.0: bios: DCB table not found
[    7.558233] nouveau 0000:01:00.0: bios: DCB table not found
[    7.558316] nouveau 0000:01:00.0: bios: DCB table not found
[    7.565103] agpgart-via 0000:00:00.0: AGP 2.0 bridge
[    7.565190] agpgart-via 0000:00:00.0: putting AGP V2 device into 4x mode
[    7.565266] nouveau 0000:01:00.0: putting AGP V2 device into 4x mode
[    7.565351] nouveau 0000:01:00.0: tmr: unknown input clock freq
[    7.567618] nouveau 0000:01:00.0: fb: 32 MiB SDRAM
[    7.582871] [TTM] Zone  kernel: Available graphics memory: 256414 kiB
[    7.582938] [TTM] Initializing pool allocator
[    7.583369] nouveau 0000:01:00.0: DRM: VRAM: 31 MiB
[    7.583435] nouveau 0000:01:00.0: DRM: GART: 64 MiB
[    7.583485] nouveau 0000:01:00.0: DRM: BMP version 5.6
[    7.583533] nouveau 0000:01:00.0: DRM: No DCB data found in VBIOS
[    7.586669] nouveau 0000:01:00.0: DRM: Saving VGA fonts
[    7.618355] nouveau 0000:01:00.0: DRM: No DCB data found in VBIOS
[    7.619748] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    7.619814] [drm] Driver supports precise vblank timestamp query.
[    7.625009] nouveau 0000:01:00.0: DRM: MM: using M2MF for buffer copies
[    7.656497] nouveau 0000:01:00.0: DRM: allocated 1280x1024 fb: 0x4000, bo dd6e4000
[    7.657051] fbcon: nouveaufb (fb0) is primary device
[    7.843721] Console: switching to colour frame buffer device 160x64
[    7.845996] nouveau 0000:01:00.0: fb0: nouveaufb frame buffer device
[    7.847022] [drm] Initialized nouveau 1.3.1 20120801 for 0000:01:00.0 on minor 0
[    9.639713] EXT4-fs (sda1): re-mounted. Opts: (null)
[   10.309077] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
[   11.949970] i2c /dev entries driver
[   17.236428] 8139too 0000:00:10.0 eth0: link up, 10Mbps, half-duplex, lpa 0x0000

--Boundary-00=_pso7XzWd1mwstzT--
