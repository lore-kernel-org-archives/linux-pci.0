Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-1b.atlantis.sk ([80.94.52.26]:50164 "EHLO
        smtp-1b.atlantis.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932469AbcI2Qst (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Sep 2016 12:48:49 -0400
From: Ondrej Zary <linux@rainbow-software.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: 4.7 regression: ACPI: No IRQ available for PCI Interrupt Link [LNKD]. Try pci=noacpi or acpi=off
Date: Thu, 29 Sep 2016 18:48:32 +0200
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        wim@djo.tudelft.nl, ravikanth.nalla@hpe.com
References: <201609251512.05657.linux@rainbow-software.org> <201609291549.07784.linux@rainbow-software.org> <e90fb01a-77e3-a094-9631-0b703972c750@codeaurora.org>
In-Reply-To: <e90fb01a-77e3-a094-9631-0b703972c750@codeaurora.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hXU7Xu/iY0F1QMk"
Message-Id: <201609291848.33803.linux@rainbow-software.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Boundary-00=_hXU7Xu/iY0F1QMk
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 29 September 2016 16:28:23 Sinan Kaya wrote:
> On 9/29/2016 9:49 AM, Ondrej Zary wrote:
> >> Ok, since I have not seen the full boot log I am guessing that isa api
> >>
> >> > gets called before the link objects are initialized.
> >
> > Netconsole did not work (probably because it crashes too early?) and I
> > don't have a null-modem cable.
>
> Probably, this is telling me that using the link list to determine
> penalties for ISA penalties is a bad idea as the ISA API seems to be called
> from arbitrary contexts even before the ACPI Link objects are created.
>
> I was trying to reuse the PCI execution path for ISA interrupts using the
> last two patches. I dropped the first and last two patches and restored the
> penalty PCI penalty assignment for the active interrupt only if the
> interrupt is a ISA interrupt with a new patch.
>
> >> > Can you appply the first three only (0001, 0002 and 0003) to see if it
> >> > makes a difference?
> >
> > It boots with first 3 patches only but the problem remains - see the
> > attached log.
>
> Let's see the new set. If this doesn't work, I'll have to provide you with
> another patch to get the penalty counts again. The original debug aids
> patch may not apply after these.

It boots but the IRQ problem still remains the same. See the attached logs:
dmesg-bad.txt: without the irq -> link->irq.active change
dmesg-bad2.txt: with the irq -> link->irq.active change
dmesg-bad2-debug.txt: as above with modified debug patch

@@ -876,8 +893,11 @@ void acpi_penalize_isa_irq(int irq, int active)
 {
        int penalty = active ? PIRQ_PENALTY_ISA_USED : PIRQ_PENALTY_PCI_USING;

-       if ((irq >= 0) && (irq < ARRAY_SIZE(acpi_isa_irq_penalty)))
+       if ((irq >= 0) && (irq < ARRAY_SIZE(acpi_isa_irq_penalty))) {
                acpi_isa_irq_penalty[irq] += penalty;
+               pr_info("%s:%d acpi_isa_irq_penalty[%d]=0x%x active = %d\n", 
__func__,
+                               __LINE__, irq,  acpi_irq_get_penalty(irq), 
active);
+       }
 }


-- 
Ondrej Zary

--Boundary-00=_hXU7Xu/iY0F1QMk
Content-Type: text/plain;
  charset="iso-8859-15";
  name="dmesg-bad2-debug.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg-bad2-debug.txt"

[    0.000000] Linux version 4.8.0-rc8+ (zary@gsql) (gcc version 4.7.2 (Debian 4.7.2-5) ) #126 SMP Thu Sep 29 18:41:27 CEST 2016
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
[    0.000000] free_area_init_node: node 0, pgdat c15b1a60, node_mem_map dfbf0020
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
[    0.000000] Memory: 512284K/523832K available (3921K kernel code, 437K rwdata, 1520K rodata, 524K init, 412K bss, 11548K reserved, 0K cma-reserved, 0K highmem)
[    0.000000] virtual kernel memory layout:
    fixmap  : 0xfff17000 - 0xfffff000   ( 928 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xe07f0000 - 0xff7fe000   ( 496 MB)
    lowmem  : 0xc0000000 - 0xdfff0000   ( 511 MB)
      .init : 0xc15c1000 - 0xc1644000   ( 524 kB)
      .data : 0xc13d4881 - 0xc15bf4e0   (1963 kB)
      .text : 0xc1000000 - 0xc13d4881   (3922 kB)
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
[    0.000000] tsc: Detected 1199.445 MHz processor
[    0.008010] Calibrating delay loop (skipped), value calculated using timer frequency.. 2398.89 BogoMIPS (lpj=4797780)
[    0.008109] pid_max: default: 32768 minimum: 301
[    0.008183] ACPI: Core revision 20160422
[    0.013693] ACPI: 1 ACPI AML tables successfully acquired and loaded

[    0.013834] ACPI: setting ELCR to 0800 (from 0e00)
[    0.013947] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.013994] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.014829] Last level iTLB entries: 4KB 32, 2MB 0, 4MB 2
[    0.014900] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 8, 1GB 0
[    0.018551] Freeing SMP alternatives memory: 16K (c1644000 - c1648000)
[    0.020481] smpboot: Max logical packages: 1
[    0.020544] smpboot: weird, boot CPU (#0) not listed by the BIOS
[    0.020588] smpboot: SMP motherboard not detected
[    0.020635] smpboot: SMP disabled
[    0.020680] smpboot: Local APIC not detected. Using dummy APIC emulation.
[    0.020733] Performance Events: 
[    0.020779] no APIC, boot with the "lapic" boot parameter to force-enable it.
[    0.020861] no hardware sampling interrupt available.
[    0.020908] p6 PMU driver.
[    0.020959] ... version:                0
[    0.021001] ... bit width:              32
[    0.021046] ... generic registers:      2
[    0.021089] ... value mask:             00000000ffffffff
[    0.021132] ... max period:             000000007fffffff
[    0.021176] ... fixed-purpose events:   0
[    0.021218] ... event mask:             0000000000000003
[    0.022287] x86: Booted up 1 node, 1 CPUs
[    0.022357] smpboot: Total of 1 processors activated (2398.89 BogoMIPS)
[    0.022900] devtmpfs: initialized
[    0.024634] PM: Registering ACPI NVS region [mem 0x1fff0000-0x1fff2fff] (12288 bytes)
[    0.024880] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.025216] NET: Registered protocol family 16
[    0.025697] cpuidle: using governor ladder
[    0.025748] cpuidle: using governor menu
[    0.025906] clocksource: pit: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1601818034827 ns
[    0.025975] ACPI: bus type PCI registered
[    0.069357] PCI: PCI BIOS revision 2.10 entry at 0xfb200, last bus=1
[    0.069406] PCI: Using configuration type 1 for base access
[    0.073256] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[    0.073759] ACPI: Added _OSI(Module Device)
[    0.073810] ACPI: Added _OSI(Processor Device)
[    0.073855] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.073901] ACPI: Added _OSI(Processor Aggregator Device)
[    0.078465] ACPI: Interpreter enabled
[    0.078586] ACPI: (supports S0 S1 S4 S5)
[    0.078636] ACPI: Using PIC for interrupt routing
[    0.078733] PCI: Ignoring host bridge windows from ACPI; if necessary, use "pci=use_crs" and report a bug
[    0.086295] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.086372] acpi PNP0A03:00: _OSC: OS supports [Segments MSI]
[    0.086429] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.086485] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.086654] acpi PNP0A03:00: host bridge window [io  0x0cf8-0x0cff] (ignored)
[    0.086659] acpi PNP0A03:00: host bridge window [io  0x0000-0x0cf7 window] (ignored)
[    0.086663] acpi PNP0A03:00: host bridge window [io  0x0d00-0x3fff window] (ignored)
[    0.086667] acpi PNP0A03:00: host bridge window [io  0x4000-0x407f] (ignored)
[    0.086671] acpi PNP0A03:00: host bridge window [io  0x4080-0x40ff] (ignored)
[    0.086675] acpi PNP0A03:00: host bridge window [io  0x4100-0x4fff window] (ignored)
[    0.086679] acpi PNP0A03:00: host bridge window [io  0x5000-0x500f] (ignored)
[    0.086683] acpi PNP0A03:00: host bridge window [io  0x5010-0x5fff window] (ignored)
[    0.086687] acpi PNP0A03:00: host bridge window [io  0x6000-0x607f] (ignored)
[    0.086692] acpi PNP0A03:00: host bridge window [io  0x6080-0xffff window] (ignored)
[    0.086696] acpi PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff window] (ignored)
[    0.086700] acpi PNP0A03:00: host bridge window [mem 0x000c0000-0x000dffff window] (ignored)
[    0.086705] acpi PNP0A03:00: host bridge window [mem 0x20000000-0xffefffff window] (ignored)
[    0.086708] PCI: root bus 00: using default resources
[    0.086824] PCI host bridge to bus 0000:00
[    0.086878] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.086925] pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffff]
[    0.086974] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.087044] pci 0000:00:00.0: [1106:0691] type 00 class 0x060000
[    0.087065] pci 0000:00:00.0: reg 0x10: [mem 0xe0000000-0xe3ffffff pref]
[    0.087310] pci 0000:00:01.0: [1106:8598] type 01 class 0x060400
[    0.087361] pci 0000:00:01.0: supports D1
[    0.087503] pci 0000:00:07.0: [1106:0686] type 00 class 0x060100
[    0.087763] pci 0000:00:07.1: [1106:0571] type 00 class 0x01018a
[    0.087809] pci 0000:00:07.1: reg 0x20: [io  0xd000-0xd00f]
[    0.087830] pci 0000:00:07.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.087881] pci 0000:00:07.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.087928] pci 0000:00:07.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.088035] pci 0000:00:07.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.088264] pci 0000:00:07.2: [1106:3038] type 00 class 0x0c0300
[    0.088305] pci 0000:00:07.2: reg 0x20: [io  0xd400-0xd41f]
[    0.088431] pci 0000:00:07.2: System wakeup disabled by ACPI
[    0.088598] pci 0000:00:07.3: [1106:3038] type 00 class 0x0c0300
[    0.088640] pci 0000:00:07.3: reg 0x20: [io  0xd800-0xd81f]
[    0.088763] pci 0000:00:07.3: System wakeup disabled by ACPI
[    0.088926] pci 0000:00:07.4: [1106:3057] type 00 class 0x068000
[    0.088989] pci 0000:00:07.4: quirk: [io  0x6000-0x607f] claimed by vt82c686 HW-mon
[    0.089042] pci 0000:00:07.4: quirk: [io  0x5000-0x500f] claimed by vt82c686 SMB
[    0.089268] pci 0000:00:07.5: [1106:3058] type 00 class 0x040100
[    0.089286] pci 0000:00:07.5: reg 0x10: [io  0xdc00-0xdcff]
[    0.089297] pci 0000:00:07.5: reg 0x14: [io  0xe000-0xe003]
[    0.089308] pci 0000:00:07.5: reg 0x18: [io  0xe400-0xe403]
[    0.089537] pci 0000:00:0f.0: [10ec:8139] type 00 class 0x020000
[    0.089554] pci 0000:00:0f.0: reg 0x10: [io  0xe800-0xe8ff]
[    0.089566] pci 0000:00:0f.0: reg 0x14: [mem 0xe8000000-0xe80000ff]
[    0.089628] pci 0000:00:0f.0: supports D1 D2
[    0.089633] pci 0000:00:0f.0: PME# supported from D1 D2 D3hot
[    0.089878] pci 0000:01:00.0: [10de:002d] type 00 class 0x030000
[    0.089895] pci 0000:01:00.0: reg 0x10: [mem 0xe6000000-0xe6ffffff]
[    0.089906] pci 0000:01:00.0: reg 0x14: [mem 0xe4000000-0xe5ffffff pref]
[    0.089938] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    0.090078] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.090136] pci 0000:00:01.0:   bridge window [mem 0xe6000000-0xe7ffffff]
[    0.090142] pci 0000:00:01.0:   bridge window [mem 0xe4000000-0xe5ffffff pref]
[    0.090153] pci_bus 0000:00: on NUMA node 0
[    0.090536] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
[    0.091250] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[    0.092164] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
[    0.092927] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *9
[    0.095365] vgaarb: setting as boot device: PCI:0000:01:00.0
[    0.095424] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.095477] vgaarb: loaded
[    0.095521] vgaarb: bridge control possible 0000:01:00.0
[    0.095793] SCSI subsystem initialized
[    0.096060] libata version 3.00 loaded.
[    0.096078] ACPI: bus type USB registered
[    0.096203] usbcore: registered new interface driver usbfs
[    0.096278] usbcore: registered new interface driver hub
[    0.096360] usbcore: registered new device driver usb
[    0.096481] PCI: Using ACPI for IRQ routing
[    0.096533] PCI: pci_cache_line_size set to 32 bytes
[    0.096581] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.096587] e820: reserve RAM buffer [mem 0x1fff0000-0x1fffffff]
[    0.097555] clocksource: Switched to clocksource pit
[    0.116758] pnp: PnP ACPI init
[    0.117671] system 00:00: [mem 0x000ca800-0x000cbfff] has been reserved
[    0.117740] system 00:00: [mem 0x000f0000-0x000f7fff] could not be reserved
[    0.117794] system 00:00: [mem 0x000f8000-0x000fbfff] could not be reserved
[    0.117843] system 00:00: [mem 0x000fc000-0x000fffff] could not be reserved
[    0.117891] system 00:00: [mem 0x1fff0000-0x1fffffff] could not be reserved
[    0.117940] system 00:00: [mem 0xffff0000-0xffffffff] has been reserved
[    0.117988] system 00:00: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.118036] system 00:00: [mem 0x00100000-0x1ffeffff] could not be reserved
[    0.118084] system 00:00: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.118145] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.118770] system 00:01: [io  0x04d0-0x04d1] has been reserved
[    0.118831] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.118879] acpi_penalize_isa_irq:899 acpi_isa_irq_penalty[8]=0x110000 active = 1
[    0.118984] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.119259] acpi_penalize_isa_irq:899 acpi_isa_irq_penalty[6]=0x11005c active = 1
[    0.120415] pnp 00:03: [dma 2]
[    0.120441] acpi_penalize_isa_irq:899 acpi_isa_irq_penalty[6]=0x11105c active = 0
[    0.120567] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.121466] acpi_penalize_isa_irq:899 acpi_isa_irq_penalty[12]=0x20005c active = 1
[    0.121569] pnp 00:04: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.121633] acpi_penalize_isa_irq:899 acpi_isa_irq_penalty[1]=0x110005c active = 1
[    0.121733] pnp 00:05: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.121786] pnp: PnP ACPI: found 6 devices
[    0.121840] PnPBIOS: Disabled
[    0.161590] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.161717] clocksource: Switched to clocksource acpi_pm
[    0.161826] pci 0000:01:00.0: BAR 6: assigned [mem 0xe7000000-0xe700ffff pref]
[    0.161882] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.161936] pci 0000:00:01.0:   bridge window [mem 0xe6000000-0xe7ffffff]
[    0.161984] pci 0000:00:01.0:   bridge window [mem 0xe4000000-0xe5ffffff pref]
[    0.162040] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
[    0.162045] pci_bus 0000:00: resource 5 [mem 0x00000000-0xffffffff]
[    0.162050] pci_bus 0000:01: resource 1 [mem 0xe6000000-0xe7ffffff]
[    0.162054] pci_bus 0000:01: resource 2 [mem 0xe4000000-0xe5ffffff pref]
[    0.162159] NET: Registered protocol family 2
[    0.162806] TCP established hash table entries: 4096 (order: 2, 16384 bytes)
[    0.162925] TCP bind hash table entries: 4096 (order: 3, 32768 bytes)
[    0.163088] TCP: Hash tables configured (established 4096 bind 4096)
[    0.163220] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    0.163296] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    0.163562] NET: Registered protocol family 1
[    0.163677] pci 0000:00:01.0: disabling DAC on VIA PCI bridge
[    0.163730] pci 0000:00:07.0: Disabling VIA external APIC routing
[    0.164159] irq : 15
[    0.164205] acpi_irq_balance : 0
[    0.164247] link->irq.active : 0
[    0.164290] acpi_gbl_FADT.sci_interrupt : 11
[    0.164340] acpi_irq_get_penalty:512 adding SCI penalty: 0x1000000 
[    0.164384] acpi_irq_get_penalty(10) : 0x5c
[    0.164426] acpi_irq_get_penalty(15) : 0x10005c
[    0.165204] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
[    0.165254] PCI: setting IRQ 10 as level-triggered
[    0.165270] pci 0000:00:07.2: VIA VLink IRQ fixup, from 9 to 10
[    0.165672] pci 0000:00:07.3: VIA VLink IRQ fixup, from 9 to 10
[    0.165918] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.165969] PCI: CLS 32 bytes, default 32
[    0.167364] futex hash table entries: 256 (order: 1, 8192 bytes)
[    0.168582] workingset: timestamp_bits=30 max_order=17 bucket_order=0
[    0.176955] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.177030] io scheduler noop registered
[    0.177077] io scheduler deadline registered
[    0.177224] io scheduler cfq registered (default)
[    0.177947] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.178013] ACPI: Power Button [PWRB]
[    0.178220] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1
[    0.178274] ACPI: Sleep Button [SLPB]
[    0.178468] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    0.178518] ACPI: Power Button [PWRF]
[    0.178706] tsc: Marking TSC unstable due to TSC halts in idle
[    0.178888] Warning: Processor Platform Limit event detected, but not handled.
[    0.178936] Consider compiling CPUfreq support into your kernel.
[    0.179605] isapnp: Scanning for PnP cards...
[    0.265917] acpi_penalize_isa_irq:899 acpi_isa_irq_penalty[4]=0x1105c active = 0
[    0.265969] acpi_penalize_isa_irq:899 acpi_isa_irq_penalty[5]=0x1105c active = 0
[    0.266019] acpi_penalize_isa_irq:899 acpi_isa_irq_penalty[7]=0x1105c active = 0
[    0.266068] acpi_penalize_isa_irq:899 acpi_isa_irq_penalty[10]=0x205c active = 0
[    0.266121] acpi_irq_get_penalty:512 adding SCI penalty: 0x1000000 
[    0.266166] acpi_penalize_isa_irq:899 acpi_isa_irq_penalty[11]=0x100105c active = 0
[    0.266219] acpi_penalize_isa_irq:899 acpi_isa_irq_penalty[12]=0x20105c active = 0
[    0.266267] acpi_penalize_isa_irq:899 acpi_isa_irq_penalty[15]=0x10105c active = 0
[    0.266533]  01:01: card 'SYM 53C416'
[    0.266578] isapnp: 1 Plug & Play card detected total
[    0.266810] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.268232] Non-volatile memory driver v1.3
[    0.268291] Linux agpgart interface v0.103
[    0.268410] [drm] Initialized drm 1.1.0 20060810
[    0.275960] loop: module loaded
[    0.276427] pata_via 0000:00:07.1: version 0.3.4
[    0.277673] scsi host0: pata_via
[    0.278093] scsi host1: pata_via
[    0.278291] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xd000 irq 14
[    0.278345] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xd008 irq 15
[    0.278568] 8139cp: 8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
[    0.278617] 8139cp 0000:00:0f.0: This (id 10ec:8139 rev 10) is not an 8139C+ compatible chip, use 8139too
[    0.278730] 8139too: 8139too Fast Ethernet driver 0.9.28
[    0.279069] irq : 11
[    0.279112] acpi_irq_balance : 0
[    0.279154] link->irq.active : 11
[    0.279201] acpi_gbl_FADT.sci_interrupt : 11
[    0.279249] acpi_irq_get_penalty:512 adding SCI penalty: 0x1000000 
[    0.279298] penalty[15] = 0x10105c
[    0.279339] penalty[14] = 0x10005c
[    0.279381] penalty[12] = 0x20105c
[    0.279425] acpi_irq_get_penalty:512 adding SCI penalty: 0x1000000 
[    0.279469] penalty[11] = 0x100105c
[    0.279514] penalty[10] = 0x205c
[    0.279556] penalty[7] = 0x1105c
[    0.279597] penalty[6] = 0x11105c
[    0.279642] penalty[5] = 0x1105c
[    0.279684] penalty[4] = 0x1105c
[    0.279726] penalty[3] = 0x1005c
[    0.279769] penalty[1] = 0x110005c
[    0.279810] irq : 11
[    0.279851] acpi_gbl_FADT.sci_interrupt : 11
[    0.279897] ACPI: No IRQ available for PCI Interrupt Link [LNKA]. Try pci=noacpi or acpi=off
[    0.279946] acpi_irq_get_penalty:512 adding SCI penalty: 0x1000000 
[    0.279996] 8139too 0000:00:0f.0: PCI INT A: no GSI
[    0.281154] 8139too 0000:00:0f.0 eth0: RealTek RTL8139 at 0x0001e800, 00:40:95:30:81:14, IRQ 11
[    0.281275] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.281326] ehci-pci: EHCI PCI platform driver
[    0.281418] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.281492] ohci-pci: OHCI PCI platform driver
[    0.281562] uhci_hcd: USB Universal Host Controller Interface driver
[    0.281899] uhci_hcd 0000:00:07.2: UHCI Host Controller
[    0.281960] uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
[    0.282064] uhci_hcd 0000:00:07.2: irq 10, io base 0x0000d400
[    0.282766] hub 1-0:1.0: USB hub found
[    0.282836] hub 1-0:1.0: 2 ports detected
[    0.283432] uhci_hcd 0000:00:07.3: UHCI Host Controller
[    0.283503] uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
[    0.283593] uhci_hcd 0000:00:07.3: irq 10, io base 0x0000d800
[    0.284359] hub 2-0:1.0: USB hub found
[    0.284428] hub 2-0:1.0: 2 ports detected
[    0.284914] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    0.285506] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.285569] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.286043] mousedev: PS/2 mouse device common for all mice
[    0.287002] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
[    0.287105] rtc_cmos 00:02: alarms up to one year, y3k, 242 bytes nvram
[    0.287644] NET: Registered protocol family 17
[    0.287847] Using IPI No-Shortcut mode
[    0.288433] registered taskstats version 1
[    0.289141] console [netcon0] enabled
[    0.289191] netconsole: network logging started
[    0.289309] rtc_cmos 00:02: setting system clock to 2016-09-29 16:44:29 UTC (1475167469)
[    0.289455] PM: Checking hibernation image partition /dev/sda2
[    0.314991] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input3
[    0.502848] ata1.00: ATA-6: WDC WD800JB-00FMA0, 13.03G13, max UDMA/100
[    0.502907] ata1.00: 156301488 sectors, multi 16: LBA 
[    0.505817] ata1.00: configured for UDMA/100
[    0.506346] scsi 0:0:0:0: Direct-Access     ATA      WDC WD800JB-00FM 3G13 PQ: 0 ANSI: 5
[    0.507364] sd 0:0:0:0: [sda] 156301488 512-byte logical blocks: (80.0 GB/74.5 GiB)
[    0.507587] sd 0:0:0:0: [sda] Write Protect is off
[    0.507635] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.507694] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    0.558247]  sda: sda1 sda2 sda3
[    0.559368] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.184054] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x114a0f5c37b, max_idle_ns: 440795210420 ns
[    1.225097] random: fast init done
[    1.741360] input: PS/2 BYD TouchPad as /devices/platform/i8042/serio1/input/input5
[    1.744307] PM: Hibernation image partition 8:2 present
[    1.744309] PM: Looking for hibernation image.
[    1.744842] PM: Image not found (code -22)
[    1.744846] PM: Hibernation image not present or could not be loaded.
[    1.745440] EXT4-fs (sda1): mounting ext3 file system using the ext4 subsystem
[    1.794030] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[    1.794156] VFS: Mounted root (ext3 filesystem) readonly on device 8:1.
[    1.795655] Freeing unused kernel memory: 524K (c15c1000 - c1644000)
[    1.796009] Write protecting the kernel text: 3924k
[    1.796364] Write protecting the kernel read-only data: 1524k
[    4.476933] random: crng init done
[    4.936716] systemd-udevd[179]: starting version 215
[    6.846042] agpgart: Detected VIA Apollo Pro 133 chipset
[    6.850762] agpgart-via 0000:00:00.0: AGP aperture is 64M @ 0xe0000000
[    6.867805] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    7.062401] parport_pc: VIA 686A/8231 detected
[    7.062410] parport_pc: probing current configuration
[    7.062430] parport_pc: Current parallel port base: 0x0
[    7.062434] parport_pc: VIA parallel port disabled in BIOS
[    7.084319] wmi: Mapper loaded
[    7.551659] irq : 11
[    7.551726] acpi_irq_balance : 0
[    7.551772] link->irq.active : 11
[    7.551814] acpi_gbl_FADT.sci_interrupt : 11
[    7.551863] acpi_irq_get_penalty:512 adding SCI penalty: 0x1000000 
[    7.551907] penalty[15] = 0x10105c
[    7.551950] penalty[14] = 0x10005c
[    7.551995] penalty[12] = 0x20105c
[    7.552151] acpi_irq_get_penalty:512 adding SCI penalty: 0x1000000 
[    7.552197] penalty[11] = 0x100105c
[    7.552239] penalty[10] = 0x205c
[    7.552284] penalty[7] = 0x1105c
[    7.552325] penalty[6] = 0x11105c
[    7.552367] penalty[5] = 0x1105c
[    7.552411] penalty[4] = 0x1105c
[    7.552453] penalty[3] = 0x1005c
[    7.552495] penalty[1] = 0x110005c
[    7.552538] irq : 11
[    7.552579] acpi_gbl_FADT.sci_interrupt : 11
[    7.552623] ACPI: No IRQ available for PCI Interrupt Link [LNKA]. Try pci=noacpi or acpi=off
[    7.552673] acpi_irq_get_penalty:512 adding SCI penalty: 0x1000000 
[    7.552725] nouveau 0000:01:00.0: PCI INT A: no GSI
[    7.553057] irq : 11
[    7.553103] acpi_irq_balance : 0
[    7.553145] link->irq.active : 11
[    7.553187] acpi_gbl_FADT.sci_interrupt : 11
[    7.553234] acpi_irq_get_penalty:512 adding SCI penalty: 0x1000000 
[    7.553277] penalty[15] = 0x10105c
[    7.553319] penalty[14] = 0x10005c
[    7.553363] penalty[12] = 0x20105c
[    7.553406] acpi_irq_get_penalty:512 adding SCI penalty: 0x1000000 
[    7.553452] penalty[11] = 0x100105c
[    7.553495] penalty[10] = 0x205c
[    7.553537] penalty[7] = 0x1105c
[    7.553582] penalty[6] = 0x11105c
[    7.553623] penalty[5] = 0x1105c
[    7.553665] penalty[4] = 0x1105c
[    7.553707] penalty[3] = 0x1005c
[    7.553749] penalty[1] = 0x110005c
[    7.553790] irq : 11
[    7.553831] acpi_gbl_FADT.sci_interrupt : 11
[    7.553875] ACPI: No IRQ available for PCI Interrupt Link [LNKA]. Try pci=noacpi or acpi=off
[    7.553923] acpi_irq_get_penalty:512 adding SCI penalty: 0x1000000 
[    7.553970] nouveau 0000:01:00.0: PCI INT A: no GSI
[    7.554037] nouveau 0000:01:00.0: NVIDIA NV05 (20154000)
[    7.573968] nouveau 0000:01:00.0: bios: version 02.05.20.02.00
[    7.574364] nouveau 0000:01:00.0: bios: DCB table not found
[    7.574909] nouveau 0000:01:00.0: bios: DCB table not found
[    7.575146] nouveau 0000:01:00.0: bios: DCB table not found
[    7.575195] nouveau 0000:01:00.0: bios: DCB table not found
[    7.575278] nouveau 0000:01:00.0: bios: DCB table not found
[    7.576722] agpgart-via 0000:00:00.0: AGP 2.0 bridge
[    7.576803] agpgart-via 0000:00:00.0: putting AGP V2 device into 4x mode
[    7.576879] nouveau 0000:01:00.0: putting AGP V2 device into 4x mode
[    7.576968] nouveau 0000:01:00.0: tmr: unknown input clock freq
[    7.579240] nouveau 0000:01:00.0: fb: 32 MiB SDRAM
[    7.589017] [TTM] Zone  kernel: Available graphics memory: 256412 kiB
[    7.589079] [TTM] Initializing pool allocator
[    7.589548] nouveau 0000:01:00.0: DRM: VRAM: 31 MiB
[    7.589613] nouveau 0000:01:00.0: DRM: GART: 64 MiB
[    7.589666] nouveau 0000:01:00.0: DRM: BMP version 5.6
[    7.589714] nouveau 0000:01:00.0: DRM: No DCB data found in VBIOS
[    7.593025] nouveau 0000:01:00.0: DRM: Saving VGA fonts
[    7.624638] nouveau 0000:01:00.0: DRM: No DCB data found in VBIOS
[    7.626019] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    7.626081] [drm] Driver supports precise vblank timestamp query.
[    7.631026] nouveau 0000:01:00.0: DRM: MM: using M2MF for buffer copies
[    7.685262] nouveau 0000:01:00.0: DRM: allocated 1280x1024 fb: 0x4000, bo dd6f6000
[    7.685832] fbcon: nouveaufb (fb0) is primary device
[    7.922634] nouveau 0000:01:00.0: DRM: GPU lockup - switching to software fbcon
[    7.928774] Console: switching to colour frame buffer device 160x64
[    7.939690] nouveau 0000:01:00.0: fb0: nouveaufb frame buffer device
[    7.940687] [drm] Initialized nouveau 1.3.1 20120801 for 0000:01:00.0 on minor 0
[    9.423690] EXT4-fs (sda1): re-mounted. Opts: (null)
[   10.093109] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
[   11.723412] i2c /dev entries driver
[   16.970446] 8139too 0000:00:0f.0 eth0: link up, 10Mbps, half-duplex, lpa 0x0000
[   28.896041] ------------[ cut here ]------------
[   28.899632] WARNING: CPU: 0 PID: 0 at net/sched/sch_generic.c:316 dev_watchdog+0xaf/0x10b
[   28.900015] NETDEV WATCHDOG: eth0 (8139too): transmit queue 0 timed out
[   28.900015] Modules linked in: i2c_dev nouveau wmi video parport_pc parport hwmon ttm sg via_agp
[   28.900015] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.0-rc8+ #126
[   28.900015] Hardware name: VIA Technologies, Inc. VT82C694X/694X, BIOS 6.00 PG 02/19/2002
[   28.900015]  00000000 c11aaa70 df41ff44 00000000 c10347a1 0000013c 00000009 df5aa000
[   28.900015]  00000000 fffef740 df5aa240 c1034827 00000009 00000000 df41ff44 c1507225
[   28.900015]  df41ff5c c131e096 c150725e 0000013c c1507225 df5aa000 c14f81fe 00000000
[   28.900015] Call Trace:
[   28.900015]  [<c11aaa70>] ? dump_stack+0x44/0x58
[   28.900015]  [<c10347a1>] ? __warn+0xc1/0xd8
[   28.900015]  [<c1034827>] ? warn_slowpath_fmt+0x2b/0x30
[   28.900015]  [<c131e096>] ? dev_watchdog+0xaf/0x10b
[   28.900015]  [<c131dfe7>] ? netif_tx_lock+0x51/0x51
[   28.900015]  [<c10724d9>] ? call_timer_fn+0x49/0xee
[   28.900015]  [<c107271c>] ? __run_timers.part.29+0x10e/0x14a
[   28.900015]  [<c1277be6>] ? scsi_finish_command+0xb9/0xd8
[   28.900015]  [<c1072896>] ? run_timer_softirq+0x1e/0x43
[   28.900015]  [<c1037d44>] ? __do_softirq+0xb6/0x203
[   28.900015]  [<c1037c8e>] ? perf_trace_irq_handler_entry+0xd4/0xd4
[   28.900015]  [<c1013d1a>] ? do_softirq_own_stack+0x1a/0x1f
[   28.900015]  <IRQ>  [<c1037fba>] ? irq_exit+0x31/0x70
[   28.900015]  [<c10137e0>] ? do_IRQ+0x7a/0x8b
[   28.900015]  [<c13d362c>] ? common_interrupt+0x2c/0x34
[   28.900015]  [<c120b656>] ? acpi_safe_halt+0x14/0x16
[   28.900015]  [<c120c2b6>] ? acpi_idle_enter+0x198/0x1b8
[   28.900015]  [<c12e6e8c>] ? menu_select+0x13b/0x3ef
[   28.900015]  [<c12e5e33>] ? cpuidle_enter_state+0x96/0x1b4
[   28.900015]  [<c1059fff>] ? cpu_startup_entry+0x188/0x209
[   28.900015]  [<c15c1a12>] ? start_kernel+0x30f/0x312
[   28.900015] ---[ end trace cc36e4a5e0095eab ]---
[   31.968198] 8139too 0000:00:0f.0 eth0: link up, 10Mbps, half-duplex, lpa 0x0000
[   44.000084] 8139too 0000:00:0f.0 eth0: link up, 10Mbps, half-duplex, lpa 0x0000
[   57.056087] 8139too 0000:00:0f.0 eth0: link up, 10Mbps, half-duplex, lpa 0x0000
[   69.088090] 8139too 0000:00:0f.0 eth0: link up, 10Mbps, half-duplex, lpa 0x0000

--Boundary-00=_hXU7Xu/iY0F1QMk
Content-Type: text/plain;
  charset="iso-8859-15";
  name="dmesg-bad2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg-bad2.txt"

[    0.000000] Linux version 4.8.0-rc8+ (zary@gsql) (gcc version 4.7.2 (Debian 4.7.2-5) ) #125 SMP Thu Sep 29 18:30:14 CEST 2016
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
[    0.000000] free_area_init_node: node 0, pgdat c15b1a60, node_mem_map dfbf0020
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
[    0.000000] Memory: 512284K/523832K available (3921K kernel code, 437K rwdata, 1520K rodata, 524K init, 412K bss, 11548K reserved, 0K cma-reserved, 0K highmem)
[    0.000000] virtual kernel memory layout:
    fixmap  : 0xfff17000 - 0xfffff000   ( 928 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xe07f0000 - 0xff7fe000   ( 496 MB)
    lowmem  : 0xc0000000 - 0xdfff0000   ( 511 MB)
      .init : 0xc15c1000 - 0xc1644000   ( 524 kB)
      .data : 0xc13d4761 - 0xc15bf4e0   (1963 kB)
      .text : 0xc1000000 - 0xc13d4761   (3921 kB)
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
[    0.000000] tsc: Detected 1199.492 MHz processor
[    0.004011] Calibrating delay loop (skipped), value calculated using timer frequency.. 2398.98 BogoMIPS (lpj=4797968)
[    0.004102] pid_max: default: 32768 minimum: 301
[    0.004172] ACPI: Core revision 20160422
[    0.009465] ACPI: 1 ACPI AML tables successfully acquired and loaded

[    0.009610] ACPI: setting ELCR to 0800 (from 0e00)
[    0.009724] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.009771] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.010608] Last level iTLB entries: 4KB 32, 2MB 0, 4MB 2
[    0.010679] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 8, 1GB 0
[    0.014331] Freeing SMP alternatives memory: 16K (c1644000 - c1648000)
[    0.016482] smpboot: Max logical packages: 1
[    0.016540] smpboot: weird, boot CPU (#0) not listed by the BIOS
[    0.016583] smpboot: SMP motherboard not detected
[    0.016625] smpboot: SMP disabled
[    0.016669] smpboot: Local APIC not detected. Using dummy APIC emulation.
[    0.016717] Performance Events: 
[    0.016762] no APIC, boot with the "lapic" boot parameter to force-enable it.
[    0.016845] no hardware sampling interrupt available.
[    0.016891] p6 PMU driver.
[    0.016941] ... version:                0
[    0.016983] ... bit width:              32
[    0.017028] ... generic registers:      2
[    0.017071] ... value mask:             00000000ffffffff
[    0.017114] ... max period:             000000007fffffff
[    0.017158] ... fixed-purpose events:   0
[    0.017199] ... event mask:             0000000000000003
[    0.018257] x86: Booted up 1 node, 1 CPUs
[    0.018326] smpboot: Total of 1 processors activated (2398.98 BogoMIPS)
[    0.018869] devtmpfs: initialized
[    0.020384] PM: Registering ACPI NVS region [mem 0x1fff0000-0x1fff2fff] (12288 bytes)
[    0.020631] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.020963] NET: Registered protocol family 16
[    0.021442] cpuidle: using governor ladder
[    0.021493] cpuidle: using governor menu
[    0.021649] clocksource: pit: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1601818034827 ns
[    0.021715] ACPI: bus type PCI registered
[    0.065271] PCI: PCI BIOS revision 2.10 entry at 0xfb200, last bus=1
[    0.065322] PCI: Using configuration type 1 for base access
[    0.069136] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[    0.069635] ACPI: Added _OSI(Module Device)
[    0.069690] ACPI: Added _OSI(Processor Device)
[    0.069734] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.069778] ACPI: Added _OSI(Processor Aggregator Device)
[    0.074304] ACPI: Interpreter enabled
[    0.074424] ACPI: (supports S0 S1 S4 S5)
[    0.074470] ACPI: Using PIC for interrupt routing
[    0.074566] PCI: Ignoring host bridge windows from ACPI; if necessary, use "pci=use_crs" and report a bug
[    0.082064] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.082142] acpi PNP0A03:00: _OSC: OS supports [Segments MSI]
[    0.082200] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.082256] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.082423] acpi PNP0A03:00: host bridge window [io  0x0cf8-0x0cff] (ignored)
[    0.082428] acpi PNP0A03:00: host bridge window [io  0x0000-0x0cf7 window] (ignored)
[    0.082432] acpi PNP0A03:00: host bridge window [io  0x0d00-0x3fff window] (ignored)
[    0.082436] acpi PNP0A03:00: host bridge window [io  0x4000-0x407f] (ignored)
[    0.082440] acpi PNP0A03:00: host bridge window [io  0x4080-0x40ff] (ignored)
[    0.082444] acpi PNP0A03:00: host bridge window [io  0x4100-0x4fff window] (ignored)
[    0.082448] acpi PNP0A03:00: host bridge window [io  0x5000-0x500f] (ignored)
[    0.082452] acpi PNP0A03:00: host bridge window [io  0x5010-0x5fff window] (ignored)
[    0.082456] acpi PNP0A03:00: host bridge window [io  0x6000-0x607f] (ignored)
[    0.082460] acpi PNP0A03:00: host bridge window [io  0x6080-0xffff window] (ignored)
[    0.082464] acpi PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff window] (ignored)
[    0.082468] acpi PNP0A03:00: host bridge window [mem 0x000c0000-0x000dffff window] (ignored)
[    0.082473] acpi PNP0A03:00: host bridge window [mem 0x20000000-0xffefffff window] (ignored)
[    0.082475] PCI: root bus 00: using default resources
[    0.082590] PCI host bridge to bus 0000:00
[    0.082640] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.082686] pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffff]
[    0.082737] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.082805] pci 0000:00:00.0: [1106:0691] type 00 class 0x060000
[    0.082826] pci 0000:00:00.0: reg 0x10: [mem 0xe0000000-0xe3ffffff pref]
[    0.083069] pci 0000:00:01.0: [1106:8598] type 01 class 0x060400
[    0.083119] pci 0000:00:01.0: supports D1
[    0.083261] pci 0000:00:07.0: [1106:0686] type 00 class 0x060100
[    0.083518] pci 0000:00:07.1: [1106:0571] type 00 class 0x01018a
[    0.083564] pci 0000:00:07.1: reg 0x20: [io  0xd000-0xd00f]
[    0.083585] pci 0000:00:07.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.083636] pci 0000:00:07.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.083686] pci 0000:00:07.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.083731] pci 0000:00:07.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.083951] pci 0000:00:07.2: [1106:3038] type 00 class 0x0c0300
[    0.084061] pci 0000:00:07.2: reg 0x20: [io  0xd400-0xd41f]
[    0.084193] pci 0000:00:07.2: System wakeup disabled by ACPI
[    0.084363] pci 0000:00:07.3: [1106:3038] type 00 class 0x0c0300
[    0.084405] pci 0000:00:07.3: reg 0x20: [io  0xd800-0xd81f]
[    0.084527] pci 0000:00:07.3: System wakeup disabled by ACPI
[    0.084689] pci 0000:00:07.4: [1106:3057] type 00 class 0x068000
[    0.084752] pci 0000:00:07.4: quirk: [io  0x6000-0x607f] claimed by vt82c686 HW-mon
[    0.084804] pci 0000:00:07.4: quirk: [io  0x5000-0x500f] claimed by vt82c686 SMB
[    0.085030] pci 0000:00:07.5: [1106:3058] type 00 class 0x040100
[    0.085047] pci 0000:00:07.5: reg 0x10: [io  0xdc00-0xdcff]
[    0.085058] pci 0000:00:07.5: reg 0x14: [io  0xe000-0xe003]
[    0.085069] pci 0000:00:07.5: reg 0x18: [io  0xe400-0xe403]
[    0.085296] pci 0000:00:0f.0: [10ec:8139] type 00 class 0x020000
[    0.085313] pci 0000:00:0f.0: reg 0x10: [io  0xe800-0xe8ff]
[    0.085325] pci 0000:00:0f.0: reg 0x14: [mem 0xe8000000-0xe80000ff]
[    0.085388] pci 0000:00:0f.0: supports D1 D2
[    0.085393] pci 0000:00:0f.0: PME# supported from D1 D2 D3hot
[    0.085637] pci 0000:01:00.0: [10de:002d] type 00 class 0x030000
[    0.085654] pci 0000:01:00.0: reg 0x10: [mem 0xe6000000-0xe6ffffff]
[    0.085665] pci 0000:01:00.0: reg 0x14: [mem 0xe4000000-0xe5ffffff pref]
[    0.085698] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    0.085837] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.085888] pci 0000:00:01.0:   bridge window [mem 0xe6000000-0xe7ffffff]
[    0.085894] pci 0000:00:01.0:   bridge window [mem 0xe4000000-0xe5ffffff pref]
[    0.085905] pci_bus 0000:00: on NUMA node 0
[    0.086280] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
[    0.086979] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[    0.087795] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
[    0.088606] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *9
[    0.091022] vgaarb: setting as boot device: PCI:0000:01:00.0
[    0.091082] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.091133] vgaarb: loaded
[    0.091176] vgaarb: bridge control possible 0000:01:00.0
[    0.091445] SCSI subsystem initialized
[    0.091647] libata version 3.00 loaded.
[    0.091662] ACPI: bus type USB registered
[    0.091782] usbcore: registered new interface driver usbfs
[    0.091860] usbcore: registered new interface driver hub
[    0.091938] usbcore: registered new device driver usb
[    0.092099] PCI: Using ACPI for IRQ routing
[    0.092152] PCI: pci_cache_line_size set to 32 bytes
[    0.092197] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.092203] e820: reserve RAM buffer [mem 0x1fff0000-0x1fffffff]
[    0.093166] clocksource: Switched to clocksource pit
[    0.112764] pnp: PnP ACPI init
[    0.113674] system 00:00: [mem 0x000ca800-0x000cbfff] has been reserved
[    0.113740] system 00:00: [mem 0x000f0000-0x000f7fff] could not be reserved
[    0.113788] system 00:00: [mem 0x000f8000-0x000fbfff] could not be reserved
[    0.113839] system 00:00: [mem 0x000fc000-0x000fffff] could not be reserved
[    0.113887] system 00:00: [mem 0x1fff0000-0x1fffffff] could not be reserved
[    0.113937] system 00:00: [mem 0xffff0000-0xffffffff] has been reserved
[    0.113984] system 00:00: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.114033] system 00:00: [mem 0x00100000-0x1ffeffff] could not be reserved
[    0.114081] system 00:00: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.114143] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.114600] system 00:01: [io  0x04d0-0x04d1] has been reserved
[    0.114653] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.114747] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.115168] pnp 00:03: [dma 2]
[    0.115285] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.116231] pnp 00:04: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.116343] pnp 00:05: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.116397] pnp: PnP ACPI: found 6 devices
[    0.116457] PnPBIOS: Disabled
[    0.156089] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.157325] clocksource: Switched to clocksource acpi_pm
[    0.157436] pci 0000:01:00.0: BAR 6: assigned [mem 0xe7000000-0xe700ffff pref]
[    0.157492] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.157544] pci 0000:00:01.0:   bridge window [mem 0xe6000000-0xe7ffffff]
[    0.157592] pci 0000:00:01.0:   bridge window [mem 0xe4000000-0xe5ffffff pref]
[    0.157648] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
[    0.157653] pci_bus 0000:00: resource 5 [mem 0x00000000-0xffffffff]
[    0.157658] pci_bus 0000:01: resource 1 [mem 0xe6000000-0xe7ffffff]
[    0.157662] pci_bus 0000:01: resource 2 [mem 0xe4000000-0xe5ffffff pref]
[    0.157770] NET: Registered protocol family 2
[    0.158334] TCP established hash table entries: 4096 (order: 2, 16384 bytes)
[    0.158456] TCP bind hash table entries: 4096 (order: 3, 32768 bytes)
[    0.158616] TCP: Hash tables configured (established 4096 bind 4096)
[    0.158750] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    0.158947] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    0.159235] NET: Registered protocol family 1
[    0.159346] pci 0000:00:01.0: disabling DAC on VIA PCI bridge
[    0.159400] pci 0000:00:07.0: Disabling VIA external APIC routing
[    0.160552] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
[    0.160604] PCI: setting IRQ 10 as level-triggered
[    0.160619] pci 0000:00:07.2: VIA VLink IRQ fixup, from 9 to 10
[    0.161020] pci 0000:00:07.3: VIA VLink IRQ fixup, from 9 to 10
[    0.161266] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.161318] PCI: CLS 32 bytes, default 32
[    0.162704] futex hash table entries: 256 (order: 1, 8192 bytes)
[    0.163790] workingset: timestamp_bits=30 max_order=17 bucket_order=0
[    0.172195] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.172269] io scheduler noop registered
[    0.172312] io scheduler deadline registered
[    0.172466] io scheduler cfq registered (default)
[    0.173191] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.173262] ACPI: Power Button [PWRB]
[    0.173467] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1
[    0.173518] ACPI: Sleep Button [SLPB]
[    0.173709] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    0.173764] ACPI: Power Button [PWRF]
[    0.173949] tsc: Marking TSC unstable due to TSC halts in idle
[    0.174153] Warning: Processor Platform Limit event detected, but not handled.
[    0.174205] Consider compiling CPUfreq support into your kernel.
[    0.174890] isapnp: Scanning for PnP cards...
[    0.261499]  01:01: card 'SYM 53C416'
[    0.261546] isapnp: 1 Plug & Play card detected total
[    0.261775] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.263053] Non-volatile memory driver v1.3
[    0.263109] Linux agpgart interface v0.103
[    0.263222] [drm] Initialized drm 1.1.0 20060810
[    0.270929] loop: module loaded
[    0.271285] pata_via 0000:00:07.1: version 0.3.4
[    0.272655] scsi host0: pata_via
[    0.273069] scsi host1: pata_via
[    0.273263] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xd000 irq 14
[    0.273314] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xd008 irq 15
[    0.273536] 8139cp: 8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
[    0.273585] 8139cp 0000:00:0f.0: This (id 10ec:8139 rev 10) is not an 8139C+ compatible chip, use 8139too
[    0.273697] 8139too: 8139too Fast Ethernet driver 0.9.28
[    0.274038] ACPI: No IRQ available for PCI Interrupt Link [LNKA]. Try pci=noacpi or acpi=off
[    0.274093] 8139too 0000:00:0f.0: PCI INT A: no GSI
[    0.274826] 8139too 0000:00:0f.0 eth0: RealTek RTL8139 at 0x0001e800, 00:40:95:30:81:14, IRQ 11
[    0.274923] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.274968] ehci-pci: EHCI PCI platform driver
[    0.275054] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.275130] ohci-pci: OHCI PCI platform driver
[    0.275199] uhci_hcd: USB Universal Host Controller Interface driver
[    0.275493] uhci_hcd 0000:00:07.2: UHCI Host Controller
[    0.275556] uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
[    0.275661] uhci_hcd 0000:00:07.2: irq 10, io base 0x0000d400
[    0.276773] hub 1-0:1.0: USB hub found
[    0.276848] hub 1-0:1.0: 2 ports detected
[    0.277464] uhci_hcd 0000:00:07.3: UHCI Host Controller
[    0.277537] uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
[    0.277630] uhci_hcd 0000:00:07.3: irq 10, io base 0x0000d800
[    0.278206] hub 2-0:1.0: USB hub found
[    0.278271] hub 2-0:1.0: 2 ports detected
[    0.278799] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    0.279398] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.279459] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.279937] mousedev: PS/2 mouse device common for all mice
[    0.281032] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
[    0.281138] rtc_cmos 00:02: alarms up to one year, y3k, 242 bytes nvram
[    0.281676] NET: Registered protocol family 17
[    0.281884] Using IPI No-Shortcut mode
[    0.282331] registered taskstats version 1
[    0.283023] console [netcon0] enabled
[    0.283072] netconsole: network logging started
[    0.283193] rtc_cmos 00:02: setting system clock to 2016-09-29 16:36:02 UTC (1475166962)
[    0.283335] PM: Checking hibernation image partition /dev/sda2
[    0.307755] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input3
[    0.438869] ata1.00: ATA-6: WDC WD800JB-00FMA0, 13.03G13, max UDMA/100
[    0.438929] ata1.00: 156301488 sectors, multi 16: LBA 
[    0.441852] ata1.00: configured for UDMA/100
[    0.442387] scsi 0:0:0:0: Direct-Access     ATA      WDC WD800JB-00FM 3G13 PQ: 0 ANSI: 5
[    0.443392] sd 0:0:0:0: [sda] 156301488 512-byte logical blocks: (80.0 GB/74.5 GiB)
[    0.443615] sd 0:0:0:0: [sda] Write Protect is off
[    0.443663] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.443720] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    0.490652]  sda: sda1 sda2 sda3
[    0.491815] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.184053] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x114a3be0fb7, max_idle_ns: 440795249339 ns
[    1.252252] random: fast init done
[    1.733264] input: PS/2 BYD TouchPad as /devices/platform/i8042/serio1/input/input5
[    1.736216] PM: Hibernation image partition 8:2 present
[    1.736219] PM: Looking for hibernation image.
[    1.736743] PM: Image not found (code -22)
[    1.736747] PM: Hibernation image not present or could not be loaded.
[    1.737334] EXT4-fs (sda1): mounting ext3 file system using the ext4 subsystem
[    1.776381] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[    1.776507] VFS: Mounted root (ext3 filesystem) readonly on device 8:1.
[    1.777998] Freeing unused kernel memory: 524K (c15c1000 - c1644000)
[    1.778351] Write protecting the kernel text: 3924k
[    1.778478] Write protecting the kernel read-only data: 1524k
[    4.625461] random: crng init done
[    4.936714] systemd-udevd[180]: starting version 215
[    6.761284] parport_pc: VIA 686A/8231 detected
[    6.761292] parport_pc: probing current configuration
[    6.761312] parport_pc: Current parallel port base: 0x0
[    6.761316] parport_pc: VIA parallel port disabled in BIOS
[    6.836814] agpgart: Detected VIA Apollo Pro 133 chipset
[    6.845928] agpgart-via 0000:00:00.0: AGP aperture is 64M @ 0xe0000000
[    6.991633] wmi: Mapper loaded
[    7.484461] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    7.593048] ACPI: No IRQ available for PCI Interrupt Link [LNKA]. Try pci=noacpi or acpi=off
[    7.593130] nouveau 0000:01:00.0: PCI INT A: no GSI
[    7.593423] ACPI: No IRQ available for PCI Interrupt Link [LNKA]. Try pci=noacpi or acpi=off
[    7.593474] nouveau 0000:01:00.0: PCI INT A: no GSI
[    7.593546] nouveau 0000:01:00.0: NVIDIA NV05 (20154000)
[    7.613314] nouveau 0000:01:00.0: bios: version 02.05.20.02.00
[    7.614462] nouveau 0000:01:00.0: bios: DCB table not found
[    7.617561] nouveau 0000:01:00.0: bios: DCB table not found
[    7.617820] nouveau 0000:01:00.0: bios: DCB table not found
[    7.617873] nouveau 0000:01:00.0: bios: DCB table not found
[    7.617957] nouveau 0000:01:00.0: bios: DCB table not found
[    7.619214] agpgart-via 0000:00:00.0: AGP 2.0 bridge
[    7.619292] agpgart-via 0000:00:00.0: putting AGP V2 device into 4x mode
[    7.619369] nouveau 0000:01:00.0: putting AGP V2 device into 4x mode
[    7.619455] nouveau 0000:01:00.0: tmr: unknown input clock freq
[    7.621853] nouveau 0000:01:00.0: fb: 32 MiB SDRAM
[    7.630178] [TTM] Zone  kernel: Available graphics memory: 256412 kiB
[    7.630231] [TTM] Initializing pool allocator
[    7.630756] nouveau 0000:01:00.0: DRM: VRAM: 31 MiB
[    7.630820] nouveau 0000:01:00.0: DRM: GART: 64 MiB
[    7.630872] nouveau 0000:01:00.0: DRM: BMP version 5.6
[    7.630920] nouveau 0000:01:00.0: DRM: No DCB data found in VBIOS
[    7.639141] nouveau 0000:01:00.0: DRM: Saving VGA fonts
[    7.694581] nouveau 0000:01:00.0: DRM: No DCB data found in VBIOS
[    7.697494] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    7.697560] [drm] Driver supports precise vblank timestamp query.
[    7.708621] nouveau 0000:01:00.0: DRM: MM: using M2MF for buffer copies
[    7.762606] nouveau 0000:01:00.0: DRM: allocated 1280x1024 fb: 0x4000, bo de4a4000
[    7.763171] fbcon: nouveaufb (fb0) is primary device
[    7.985474] nouveau 0000:01:00.0: DRM: GPU lockup - switching to software fbcon
[    7.991724] Console: switching to colour frame buffer device 160x64
[    8.003660] nouveau 0000:01:00.0: fb0: nouveaufb frame buffer device
[    8.004706] [drm] Initialized nouveau 1.3.1 20120801 for 0000:01:00.0 on minor 0
[    9.472647] EXT4-fs (sda1): re-mounted. Opts: (null)
[   10.133739] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
[   11.772526] i2c /dev entries driver
[   17.157830] 8139too 0000:00:0f.0 eth0: link up, 10Mbps, half-duplex, lpa 0x0000
[   29.920088] ------------[ cut here ]------------
[   29.923812] WARNING: CPU: 0 PID: 1443 at net/sched/sch_generic.c:316 dev_watchdog+0xaf/0x10b
[   29.927521] NETDEV WATCHDOG: eth0 (8139too): transmit queue 0 timed out
[   29.931158] Modules linked in: i2c_dev nouveau sg wmi video hwmon ttm via_agp parport_pc parport
[   29.934905] CPU: 0 PID: 1443 Comm: startpar Not tainted 4.8.0-rc8+ #125
[   29.938548] Hardware name: VIA Technologies, Inc. VT82C694X/694X, BIOS 6.00 PG 02/19/2002
[   29.938885]  00000000 c11aaa70 df41ff44 00000000 c10347a1 0000013c 00000009 df5aa000
[   29.938885]  00000000 fffef840 df5aa240 c1034827 00000009 00000000 df41ff44 c15070f4
[   29.938885]  df41ff5c c131df86 c150712d 0000013c c15070f4 df5aa000 c14f80cd 00000000
[   29.938885] Call Trace:
[   29.938885]  [<c11aaa70>] ? dump_stack+0x44/0x58
[   29.938885]  [<c10347a1>] ? __warn+0xc1/0xd8
[   29.938885]  [<c1034827>] ? warn_slowpath_fmt+0x2b/0x30
[   29.938885]  [<c131df86>] ? dev_watchdog+0xaf/0x10b
[   29.938885]  [<c131ded7>] ? netif_tx_lock+0x51/0x51
[   29.938885]  [<c10724d9>] ? call_timer_fn+0x49/0xee
[   29.938885]  [<c107271c>] ? __run_timers.part.29+0x10e/0x14a
[   29.938885]  [<c1277ae2>] ? scsi_finish_command+0xb9/0xd8
[   29.938885]  [<c1072896>] ? run_timer_softirq+0x1e/0x43
[   29.938885]  [<c1037d44>] ? __do_softirq+0xb6/0x203
[   29.938885]  [<c1037c8e>] ? perf_trace_irq_handler_entry+0xd4/0xd4
[   29.938885]  [<c1013d1a>] ? do_softirq_own_stack+0x1a/0x1f
[   29.938885]  <IRQ>  [<c1037fba>] ? irq_exit+0x31/0x70
[   29.938885]  [<c10137e0>] ? do_IRQ+0x7a/0x8b
[   29.938885]  [<c13d350c>] ? common_interrupt+0x2c/0x34
[   30.011554] ---[ end trace 65b862c034d27b07 ]---
[   33.248109] 8139too 0000:00:0f.0 eth0: link up, 10Mbps, half-duplex, lpa 0x0000
[   46.048123] 8139too 0000:00:0f.0 eth0: link up, 10Mbps, half-duplex, lpa 0x0000
[   58.080108] 8139too 0000:00:0f.0 eth0: link up, 10Mbps, half-duplex, lpa 0x0000

--Boundary-00=_hXU7Xu/iY0F1QMk
Content-Type: text/plain;
  charset="iso-8859-15";
  name="dmesg-bad.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg-bad.txt"

[    0.000000] Linux version 4.8.0-rc8+ (zary@gsql) (gcc version 4.7.2 (Debian 4.7.2-5) ) #124 SMP Thu Sep 29 18:26:52 CEST 2016
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
[    0.000000] free_area_init_node: node 0, pgdat c15b1a60, node_mem_map dfbf0020
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
[    0.000000] Memory: 512284K/523832K available (3921K kernel code, 437K rwdata, 1520K rodata, 524K init, 412K bss, 11548K reserved, 0K cma-reserved, 0K highmem)
[    0.000000] virtual kernel memory layout:
    fixmap  : 0xfff17000 - 0xfffff000   ( 928 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xe07f0000 - 0xff7fe000   ( 496 MB)
    lowmem  : 0xc0000000 - 0xdfff0000   ( 511 MB)
      .init : 0xc15c1000 - 0xc1644000   ( 524 kB)
      .data : 0xc13d4761 - 0xc15bf4e0   (1963 kB)
      .text : 0xc1000000 - 0xc13d4761   (3921 kB)
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
[    0.000000] tsc: Detected 1199.492 MHz processor
[    0.008010] Calibrating delay loop (skipped), value calculated using timer frequency.. 2398.98 BogoMIPS (lpj=4797968)
[    0.008103] pid_max: default: 32768 minimum: 301
[    0.008172] ACPI: Core revision 20160422
[    0.013492] ACPI: 1 ACPI AML tables successfully acquired and loaded

[    0.013640] ACPI: setting ELCR to 0800 (from 0e00)
[    0.013757] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.013804] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.014646] Last level iTLB entries: 4KB 32, 2MB 0, 4MB 2
[    0.014715] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 8, 1GB 0
[    0.018357] Freeing SMP alternatives memory: 16K (c1644000 - c1648000)
[    0.020483] smpboot: Max logical packages: 1
[    0.020547] smpboot: weird, boot CPU (#0) not listed by the BIOS
[    0.020591] smpboot: SMP motherboard not detected
[    0.020636] smpboot: SMP disabled
[    0.020680] smpboot: Local APIC not detected. Using dummy APIC emulation.
[    0.020734] Performance Events: 
[    0.020780] no APIC, boot with the "lapic" boot parameter to force-enable it.
[    0.020865] no hardware sampling interrupt available.
[    0.020912] p6 PMU driver.
[    0.020960] ... version:                0
[    0.021002] ... bit width:              32
[    0.021048] ... generic registers:      2
[    0.021090] ... value mask:             00000000ffffffff
[    0.021134] ... max period:             000000007fffffff
[    0.021177] ... fixed-purpose events:   0
[    0.021218] ... event mask:             0000000000000003
[    0.022279] x86: Booted up 1 node, 1 CPUs
[    0.022353] smpboot: Total of 1 processors activated (2398.98 BogoMIPS)
[    0.022899] devtmpfs: initialized
[    0.024417] PM: Registering ACPI NVS region [mem 0x1fff0000-0x1fff2fff] (12288 bytes)
[    0.024665] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.025002] NET: Registered protocol family 16
[    0.025477] cpuidle: using governor ladder
[    0.025527] cpuidle: using governor menu
[    0.025682] clocksource: pit: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1601818034827 ns
[    0.025747] ACPI: bus type PCI registered
[    0.069002] PCI: PCI BIOS revision 2.10 entry at 0xfb200, last bus=1
[    0.069052] PCI: Using configuration type 1 for base access
[    0.072875] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[    0.073373] ACPI: Added _OSI(Module Device)
[    0.073426] ACPI: Added _OSI(Processor Device)
[    0.073470] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.073514] ACPI: Added _OSI(Processor Aggregator Device)
[    0.078047] ACPI: Interpreter enabled
[    0.078170] ACPI: (supports S0 S1 S4 S5)
[    0.078216] ACPI: Using PIC for interrupt routing
[    0.078317] PCI: Ignoring host bridge windows from ACPI; if necessary, use "pci=use_crs" and report a bug
[    0.085815] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.085894] acpi PNP0A03:00: _OSC: OS supports [Segments MSI]
[    0.085951] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.086008] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.086179] acpi PNP0A03:00: host bridge window [io  0x0cf8-0x0cff] (ignored)
[    0.086184] acpi PNP0A03:00: host bridge window [io  0x0000-0x0cf7 window] (ignored)
[    0.086188] acpi PNP0A03:00: host bridge window [io  0x0d00-0x3fff window] (ignored)
[    0.086192] acpi PNP0A03:00: host bridge window [io  0x4000-0x407f] (ignored)
[    0.086196] acpi PNP0A03:00: host bridge window [io  0x4080-0x40ff] (ignored)
[    0.086200] acpi PNP0A03:00: host bridge window [io  0x4100-0x4fff window] (ignored)
[    0.086204] acpi PNP0A03:00: host bridge window [io  0x5000-0x500f] (ignored)
[    0.086208] acpi PNP0A03:00: host bridge window [io  0x5010-0x5fff window] (ignored)
[    0.086212] acpi PNP0A03:00: host bridge window [io  0x6000-0x607f] (ignored)
[    0.086216] acpi PNP0A03:00: host bridge window [io  0x6080-0xffff window] (ignored)
[    0.086221] acpi PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff window] (ignored)
[    0.086225] acpi PNP0A03:00: host bridge window [mem 0x000c0000-0x000dffff window] (ignored)
[    0.086229] acpi PNP0A03:00: host bridge window [mem 0x20000000-0xffefffff window] (ignored)
[    0.086232] PCI: root bus 00: using default resources
[    0.086347] PCI host bridge to bus 0000:00
[    0.086396] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.086442] pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffff]
[    0.086491] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.086560] pci 0000:00:00.0: [1106:0691] type 00 class 0x060000
[    0.086581] pci 0000:00:00.0: reg 0x10: [mem 0xe0000000-0xe3ffffff pref]
[    0.086822] pci 0000:00:01.0: [1106:8598] type 01 class 0x060400
[    0.086873] pci 0000:00:01.0: supports D1
[    0.087015] pci 0000:00:07.0: [1106:0686] type 00 class 0x060100
[    0.087271] pci 0000:00:07.1: [1106:0571] type 00 class 0x01018a
[    0.087316] pci 0000:00:07.1: reg 0x20: [io  0xd000-0xd00f]
[    0.087337] pci 0000:00:07.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.087390] pci 0000:00:07.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.087437] pci 0000:00:07.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.087486] pci 0000:00:07.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.087700] pci 0000:00:07.2: [1106:3038] type 00 class 0x0c0300
[    0.087742] pci 0000:00:07.2: reg 0x20: [io  0xd400-0xd41f]
[    0.087864] pci 0000:00:07.2: System wakeup disabled by ACPI
[    0.088098] pci 0000:00:07.3: [1106:3038] type 00 class 0x0c0300
[    0.088140] pci 0000:00:07.3: reg 0x20: [io  0xd800-0xd81f]
[    0.088271] pci 0000:00:07.3: System wakeup disabled by ACPI
[    0.088433] pci 0000:00:07.4: [1106:3057] type 00 class 0x068000
[    0.088496] pci 0000:00:07.4: quirk: [io  0x6000-0x607f] claimed by vt82c686 HW-mon
[    0.088548] pci 0000:00:07.4: quirk: [io  0x5000-0x500f] claimed by vt82c686 SMB
[    0.088771] pci 0000:00:07.5: [1106:3058] type 00 class 0x040100
[    0.088790] pci 0000:00:07.5: reg 0x10: [io  0xdc00-0xdcff]
[    0.088801] pci 0000:00:07.5: reg 0x14: [io  0xe000-0xe003]
[    0.088812] pci 0000:00:07.5: reg 0x18: [io  0xe400-0xe403]
[    0.089039] pci 0000:00:0f.0: [10ec:8139] type 00 class 0x020000
[    0.089056] pci 0000:00:0f.0: reg 0x10: [io  0xe800-0xe8ff]
[    0.089068] pci 0000:00:0f.0: reg 0x14: [mem 0xe8000000-0xe80000ff]
[    0.089130] pci 0000:00:0f.0: supports D1 D2
[    0.089135] pci 0000:00:0f.0: PME# supported from D1 D2 D3hot
[    0.089380] pci 0000:01:00.0: [10de:002d] type 00 class 0x030000
[    0.089398] pci 0000:01:00.0: reg 0x10: [mem 0xe6000000-0xe6ffffff]
[    0.089409] pci 0000:01:00.0: reg 0x14: [mem 0xe4000000-0xe5ffffff pref]
[    0.089441] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    0.089581] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.089633] pci 0000:00:01.0:   bridge window [mem 0xe6000000-0xe7ffffff]
[    0.089639] pci 0000:00:01.0:   bridge window [mem 0xe4000000-0xe5ffffff pref]
[    0.089650] pci_bus 0000:00: on NUMA node 0
[    0.090028] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
[    0.090741] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[    0.091567] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
[    0.092369] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *9
[    0.094786] vgaarb: setting as boot device: PCI:0000:01:00.0
[    0.094846] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.094893] vgaarb: loaded
[    0.094937] vgaarb: bridge control possible 0000:01:00.0
[    0.095205] SCSI subsystem initialized
[    0.095409] libata version 3.00 loaded.
[    0.095425] ACPI: bus type USB registered
[    0.095545] usbcore: registered new interface driver usbfs
[    0.095620] usbcore: registered new interface driver hub
[    0.095701] usbcore: registered new device driver usb
[    0.095823] PCI: Using ACPI for IRQ routing
[    0.095877] PCI: pci_cache_line_size set to 32 bytes
[    0.095923] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.095929] e820: reserve RAM buffer [mem 0x1fff0000-0x1fffffff]
[    0.096985] clocksource: Switched to clocksource pit
[    0.116785] pnp: PnP ACPI init
[    0.117693] system 00:00: [mem 0x000ca800-0x000cbfff] has been reserved
[    0.117762] system 00:00: [mem 0x000f0000-0x000f7fff] could not be reserved
[    0.117811] system 00:00: [mem 0x000f8000-0x000fbfff] could not be reserved
[    0.117860] system 00:00: [mem 0x000fc000-0x000fffff] could not be reserved
[    0.117909] system 00:00: [mem 0x1fff0000-0x1fffffff] could not be reserved
[    0.117957] system 00:00: [mem 0xffff0000-0xffffffff] has been reserved
[    0.118005] system 00:00: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.118052] system 00:00: [mem 0x00100000-0x1ffeffff] could not be reserved
[    0.118100] system 00:00: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.118159] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.118611] system 00:01: [io  0x04d0-0x04d1] has been reserved
[    0.118665] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.118758] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.119167] pnp 00:03: [dma 2]
[    0.119287] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.120253] pnp 00:04: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.120367] pnp 00:05: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.120421] pnp: PnP ACPI: found 6 devices
[    0.120480] PnPBIOS: Disabled
[    0.160105] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.161333] clocksource: Switched to clocksource acpi_pm
[    0.161443] pci 0000:01:00.0: BAR 6: assigned [mem 0xe7000000-0xe700ffff pref]
[    0.161500] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.161554] pci 0000:00:01.0:   bridge window [mem 0xe6000000-0xe7ffffff]
[    0.161602] pci 0000:00:01.0:   bridge window [mem 0xe4000000-0xe5ffffff pref]
[    0.161661] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
[    0.161666] pci_bus 0000:00: resource 5 [mem 0x00000000-0xffffffff]
[    0.161671] pci_bus 0000:01: resource 1 [mem 0xe6000000-0xe7ffffff]
[    0.161675] pci_bus 0000:01: resource 2 [mem 0xe4000000-0xe5ffffff pref]
[    0.161782] NET: Registered protocol family 2
[    0.162347] TCP established hash table entries: 4096 (order: 2, 16384 bytes)
[    0.162467] TCP bind hash table entries: 4096 (order: 3, 32768 bytes)
[    0.162629] TCP: Hash tables configured (established 4096 bind 4096)
[    0.162763] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    0.162842] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    0.163252] NET: Registered protocol family 1
[    0.163369] pci 0000:00:01.0: disabling DAC on VIA PCI bridge
[    0.163423] pci 0000:00:07.0: Disabling VIA external APIC routing
[    0.164559] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
[    0.164612] PCI: setting IRQ 10 as level-triggered
[    0.164628] pci 0000:00:07.2: VIA VLink IRQ fixup, from 9 to 10
[    0.165029] pci 0000:00:07.3: VIA VLink IRQ fixup, from 9 to 10
[    0.165276] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.165331] PCI: CLS 32 bytes, default 32
[    0.166714] futex hash table entries: 256 (order: 1, 8192 bytes)
[    0.167799] workingset: timestamp_bits=30 max_order=17 bucket_order=0
[    0.176202] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.176277] io scheduler noop registered
[    0.176320] io scheduler deadline registered
[    0.176473] io scheduler cfq registered (default)
[    0.177199] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.177267] ACPI: Power Button [PWRB]
[    0.177472] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1
[    0.177526] ACPI: Sleep Button [SLPB]
[    0.177718] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    0.177769] ACPI: Power Button [PWRF]
[    0.177954] tsc: Marking TSC unstable due to TSC halts in idle
[    0.178163] Warning: Processor Platform Limit event detected, but not handled.
[    0.178216] Consider compiling CPUfreq support into your kernel.
[    0.178892] isapnp: Scanning for PnP cards...
[    0.265523]  01:01: card 'SYM 53C416'
[    0.265571] isapnp: 1 Plug & Play card detected total
[    0.265800] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.267074] Non-volatile memory driver v1.3
[    0.267135] Linux agpgart interface v0.103
[    0.267248] [drm] Initialized drm 1.1.0 20060810
[    0.274932] loop: module loaded
[    0.275284] pata_via 0000:00:07.1: version 0.3.4
[    0.276659] scsi host0: pata_via
[    0.277081] scsi host1: pata_via
[    0.277281] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xd000 irq 14
[    0.277333] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xd008 irq 15
[    0.277556] 8139cp: 8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
[    0.277608] 8139cp 0000:00:0f.0: This (id 10ec:8139 rev 10) is not an 8139C+ compatible chip, use 8139too
[    0.277718] 8139too: 8139too Fast Ethernet driver 0.9.28
[    0.278061] ACPI: No IRQ available for PCI Interrupt Link [LNKA]. Try pci=noacpi or acpi=off
[    0.278116] 8139too 0000:00:0f.0: PCI INT A: no GSI
[    0.278846] 8139too 0000:00:0f.0 eth0: RealTek RTL8139 at 0x0001e800, 00:40:95:30:81:14, IRQ 11
[    0.278944] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.278990] ehci-pci: EHCI PCI platform driver
[    0.279077] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.279154] ohci-pci: OHCI PCI platform driver
[    0.279229] uhci_hcd: USB Universal Host Controller Interface driver
[    0.279524] uhci_hcd 0000:00:07.2: UHCI Host Controller
[    0.279587] uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
[    0.279692] uhci_hcd 0000:00:07.2: irq 10, io base 0x0000d400
[    0.280828] hub 1-0:1.0: USB hub found
[    0.280910] hub 1-0:1.0: 2 ports detected
[    0.281530] uhci_hcd 0000:00:07.3: UHCI Host Controller
[    0.281605] uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
[    0.281698] uhci_hcd 0000:00:07.3: irq 10, io base 0x0000d800
[    0.282274] hub 2-0:1.0: USB hub found
[    0.282340] hub 2-0:1.0: 2 ports detected
[    0.282860] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    0.283461] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.283522] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.283991] mousedev: PS/2 mouse device common for all mice
[    0.285074] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
[    0.285179] rtc_cmos 00:02: alarms up to one year, y3k, 242 bytes nvram
[    0.285717] NET: Registered protocol family 17
[    0.285920] Using IPI No-Shortcut mode
[    0.286370] registered taskstats version 1
[    0.287063] console [netcon0] enabled
[    0.287112] netconsole: network logging started
[    0.287232] rtc_cmos 00:02: setting system clock to 2016-09-29 16:31:08 UTC (1475166668)
[    0.287374] PM: Checking hibernation image partition /dev/sda2
[    0.311994] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input3
[    0.502877] ata1.00: ATA-6: WDC WD800JB-00FMA0, 13.03G13, max UDMA/100
[    0.502938] ata1.00: 156301488 sectors, multi 16: LBA 
[    0.505859] ata1.00: configured for UDMA/100
[    0.506388] scsi 0:0:0:0: Direct-Access     ATA      WDC WD800JB-00FM 3G13 PQ: 0 ANSI: 5
[    0.507400] sd 0:0:0:0: [sda] 156301488 512-byte logical blocks: (80.0 GB/74.5 GiB)
[    0.507620] sd 0:0:0:0: [sda] Write Protect is off
[    0.507668] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.507726] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    0.555047]  sda: sda1 sda2 sda3
[    0.556262] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.184053] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x114a3be0fb7, max_idle_ns: 440795249339 ns
[    1.232747] random: fast init done
[    1.741269] input: PS/2 BYD TouchPad as /devices/platform/i8042/serio1/input/input5
[    1.744220] PM: Hibernation image partition 8:2 present
[    1.744223] PM: Looking for hibernation image.
[    1.744767] PM: Image not found (code -22)
[    1.744771] PM: Hibernation image not present or could not be loaded.
[    1.745366] EXT4-fs (sda1): mounting ext3 file system using the ext4 subsystem
[    1.799133] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[    1.799256] VFS: Mounted root (ext3 filesystem) readonly on device 8:1.
[    1.800937] Freeing unused kernel memory: 524K (c15c1000 - c1644000)
[    1.801395] Write protecting the kernel text: 3924k
[    1.801532] Write protecting the kernel read-only data: 1524k
[    4.658477] random: crng init done
[    4.936283] systemd-udevd[179]: starting version 215
[    6.767543] parport_pc: VIA 686A/8231 detected
[    6.767552] parport_pc: probing current configuration
[    6.767571] parport_pc: Current parallel port base: 0x0
[    6.767574] parport_pc: VIA parallel port disabled in BIOS
[    6.851340] agpgart: Detected VIA Apollo Pro 133 chipset
[    6.857264] agpgart-via 0000:00:00.0: AGP aperture is 64M @ 0xe0000000
[    6.973145] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    7.364233] wmi: Mapper loaded
[    7.837078] ACPI: No IRQ available for PCI Interrupt Link [LNKA]. Try pci=noacpi or acpi=off
[    7.837224] nouveau 0000:01:00.0: PCI INT A: no GSI
[    7.838655] ACPI: No IRQ available for PCI Interrupt Link [LNKA]. Try pci=noacpi or acpi=off
[    7.838739] nouveau 0000:01:00.0: PCI INT A: no GSI
[    7.838811] nouveau 0000:01:00.0: NVIDIA NV05 (20154000)
[    7.871384] nouveau 0000:01:00.0: bios: version 02.05.20.02.00
[    7.883856] nouveau 0000:01:00.0: bios: DCB table not found
[    7.887675] nouveau 0000:01:00.0: bios: DCB table not found
[    7.888481] nouveau 0000:01:00.0: bios: DCB table not found
[    7.888545] nouveau 0000:01:00.0: bios: DCB table not found
[    7.888629] nouveau 0000:01:00.0: bios: DCB table not found
[    7.891190] agpgart-via 0000:00:00.0: AGP 2.0 bridge
[    7.891277] agpgart-via 0000:00:00.0: putting AGP V2 device into 4x mode
[    7.891354] nouveau 0000:01:00.0: putting AGP V2 device into 4x mode
[    7.891444] nouveau 0000:01:00.0: tmr: unknown input clock freq
[    7.899714] nouveau 0000:01:00.0: fb: 32 MiB SDRAM
[    7.917981] [TTM] Zone  kernel: Available graphics memory: 256412 kiB
[    7.918050] [TTM] Initializing pool allocator
[    7.918654] nouveau 0000:01:00.0: DRM: VRAM: 31 MiB
[    7.918718] nouveau 0000:01:00.0: DRM: GART: 64 MiB
[    7.918768] nouveau 0000:01:00.0: DRM: BMP version 5.6
[    7.918815] nouveau 0000:01:00.0: DRM: No DCB data found in VBIOS
[    7.924358] nouveau 0000:01:00.0: DRM: Saving VGA fonts
[    7.984377] nouveau 0000:01:00.0: DRM: No DCB data found in VBIOS
[    7.985558] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    7.985621] [drm] Driver supports precise vblank timestamp query.
[    7.991966] nouveau 0000:01:00.0: DRM: MM: using M2MF for buffer copies
[    8.043514] nouveau 0000:01:00.0: DRM: allocated 1280x1024 fb: 0x4000, bo de4fc400
[    8.044274] fbcon: nouveaufb (fb0) is primary device
[    8.272448] nouveau 0000:01:00.0: DRM: GPU lockup - switching to software fbcon
[    8.278558] Console: switching to colour frame buffer device 160x64
[    8.290185] nouveau 0000:01:00.0: fb0: nouveaufb frame buffer device
[    8.290288] [drm] Initialized nouveau 1.3.1 20120801 for 0000:01:00.0 on minor 0
[    9.354120] EXT4-fs (sda1): re-mounted. Opts: (null)
[   10.023567] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
[   11.645642] i2c /dev entries driver
[   17.066328] 8139too 0000:00:0f.0 eth0: link up, 10Mbps, half-duplex, lpa 0x0000
[   29.920064] ------------[ cut here ]------------
[   29.923645] WARNING: CPU: 0 PID: 0 at net/sched/sch_generic.c:316 dev_watchdog+0xaf/0x10b
[   29.927114] NETDEV WATCHDOG: eth0 (8139too): transmit queue 0 timed out
[   29.930603] Modules linked in: i2c_dev nouveau wmi video hwmon ttm sg via_agp parport_pc parport
[   29.934256] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.0-rc8+ #124
[   29.937775] Hardware name: VIA Technologies, Inc. VT82C694X/694X, BIOS 6.00 PG 02/19/2002
[   29.938210]  00000000 c11aaa70 df41ff44 00000000 c10347a1 0000013c 00000009 df5aa000
[   29.938210]  00000000 fffef840 df5aa240 c1034827 00000009 00000000 df41ff44 c15070f4
[   29.938210]  df41ff5c c131df86 c150712d 0000013c c15070f4 df5aa000 c14f80cd 00000000
[   29.938210] Call Trace:
[   29.938210]  [<c11aaa70>] ? dump_stack+0x44/0x58
[   29.938210]  [<c10347a1>] ? __warn+0xc1/0xd8
[   29.938210]  [<c1034827>] ? warn_slowpath_fmt+0x2b/0x30
[   29.938210]  [<c131df86>] ? dev_watchdog+0xaf/0x10b
[   29.938210]  [<c131ded7>] ? netif_tx_lock+0x51/0x51
[   29.938210]  [<c10724d9>] ? call_timer_fn+0x49/0xee
[   29.938210]  [<c107271c>] ? __run_timers.part.29+0x10e/0x14a
[   29.938210]  [<c106f42c>] ? rcu_process_callbacks+0x178/0x385
[   29.938210]  [<c1072896>] ? run_timer_softirq+0x1e/0x43
[   29.938210]  [<c1037d44>] ? __do_softirq+0xb6/0x203
[   29.938210]  [<c1037c8e>] ? perf_trace_irq_handler_entry+0xd4/0xd4
[   29.938210]  [<c1013d1a>] ? do_softirq_own_stack+0x1a/0x1f
[   29.938210]  <IRQ>  [<c1037fba>] ? irq_exit+0x31/0x70
[   29.938210]  [<c10137e0>] ? do_IRQ+0x7a/0x8b
[   29.938210]  [<c13d350c>] ? common_interrupt+0x2c/0x34
[   29.938210]  [<c120b552>] ? acpi_safe_halt+0x14/0x16
[   29.938210]  [<c120c1b2>] ? acpi_idle_enter+0x198/0x1b8
[   29.938210]  [<c12e6d88>] ? menu_select+0x13b/0x3ef
[   29.938210]  [<c12e5d2f>] ? cpuidle_enter_state+0x96/0x1b4
[   29.938210]  [<c1059fff>] ? cpu_startup_entry+0x188/0x209
[   29.938210]  [<c15c1a12>] ? start_kernel+0x30f/0x312
[   30.031237] ---[ end trace 9e485b176e886f72 ]---
[   33.248102] 8139too 0000:00:0f.0 eth0: link up, 10Mbps, half-duplex, lpa 0x0000
[   46.048084] 8139too 0000:00:0f.0 eth0: link up, 10Mbps, half-duplex, lpa 0x0000
[   58.080090] 8139too 0000:00:0f.0 eth0: link up, 10Mbps, half-duplex, lpa 0x0000
[   70.112084] 8139too 0000:00:0f.0 eth0: link up, 10Mbps, half-duplex, lpa 0x0000
[  106.976088] 8139too 0000:00:0f.0 eth0: link up, 10Mbps, half-duplex, lpa 0x0000

--Boundary-00=_hXU7Xu/iY0F1QMk--
