Return-Path: <SRS0=xjg9=XR=redhat.com=jcm@kernel.org>
Return-Path: <SRS0=xjg9=XR=redhat.com=jcm@kernel.org>
Subject: Re: [PATCH v4 1/1] PCI/ACPI: xgene: Add ECAM quirk for X-Gene PCIe
 controller
To: Duc Dang <dhdang@apm.com>, Bjorn Helgaas <helgaas@kernel.org>
References: <20161201183350.GF30746@bhelgaas-glaptop.roam.corp.google.com>
 <f18738b7096fb06a5865214ddc299ce99630673b.1480644928.git.dhdang@apm.com>
Cc: Rafael Wysocki <rafael@kernel.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Arnd Bergmann
 <arnd@arndb.de>, Mark Salter <msalter@redhat.com>,
        linux-pci@vger.kernel.org,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomasz Nowicki <tn@semihalf.com>, patches <patches@apm.com>
From: Jon Masters <jcm@redhat.com>
Message-ID: <6d593615-e97f-8738-42be-1f8f4906d2f4@redhat.com>
Date: Fri, 2 Dec 2016 02:12:59 -0500
MIME-Version: 1.0
In-Reply-To: <f18738b7096fb06a5865214ddc299ce99630673b.1480644928.git.dhdang@apm.com>
Content-Type: multipart/mixed;
 boundary="------------1C47BCD760538FFBBFAD194D"
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------1C47BCD760538FFBBFAD194D
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

On 12/01/2016 09:27 PM, Duc Dang wrote:
> PCIe controllers in X-Gene SoCs is not ECAM compliant: software
> needs to configure additional controller's register to address
> device at bus:dev:function.
> 
> The quirk will discover controller MMIO register space and configure
> controller registers to select and address the target secondary device.
> 
> The quirk will only be applied for X-Gene PCIe MCFG table with
> OEM revison 1, 2, 3 or 4 (PCIe controller v1 and v2 on X-Gene SoCs).
> 
> Signed-off-by: Duc Dang <dhdang@apm.com>

So far I've tested this on an HPE ProLiant m400 (Moonshot) cartridge
and will test it on some other reference platforms soon. Bootlog for
the m400 attached in case Bjorn wants to see the output. Here's
what I see in /proc/iomem btw on that platform:

# cat /proc/iomem 
10520000-10523fff : APMC0D18:00
  10520000-10523fff : APMC0D18:00
10524000-10527fff : APMC0D17:00
10540000-1054a0ff : APMC0D01:00
  10546000-10546fff : APMC0D50:00
  1054a000-1054a00f : APMC0D12:03
    1054a000-1054a00f : APMC0D12:02
      1054a000-1054a00f : APMC0D12:01
        1054a000-1054a00f : APMC0D12:00
17000000-17000fff : APMC0D01:00
17001000-17001fff : APMC0D01:00
  17001000-170013ff : APMC0D15:00
    17001000-170013ff : APMC0D15:00
1701c000-1701cfff : APMC0D14:00
1a800000-1a800fff : APMC0D0D:00
  1a800000-1a800fff : APMC0D0D:00
1c000200-1c0002ff : APMC0D06:00
1c021000-1c0210ff : APMC0D08:00
  1c021000-1c02101f : serial
1c024000-1c024fff : APMC0D07:00
1f230000-1f230fff : APMC0D0D:00
  1f230000-1f230fff : APMC0D0D:00
1f23d000-1f23dfff : APMC0D0D:00
  1f23d000-1f23dfff : APMC0D0D:00
1f23e000-1f23efff : APMC0D0D:00
  1f23e000-1f23efff : APMC0D0D:00
1f2a0000-1f31ffff : APMC0D06:00
1f500000-1f50ffff : PCI Bus 0000:00
  1f500000-1f50ffff : PNP0A08:00
78800000-78800fff : APMC0D13:00
  78800000-78800fff : APMC0D12:03
    78800000-78800fff : APMC0D12:02
      78800000-78800fff : APMC0D12:01
        78800000-78800fff : APMC0D12:00
          78800000-78800fff : APMC0D11:00
          78800000-78800fff : APMC0D10:03
          78800000-78800fff : APMC0D10:02
          78800000-78800fff : APMC0D10:01
          78800000-78800fff : APMC0D10:00
79000000-798fffff : APMC0D0E:00
7c000000-7c1fffff : APMC0D12:00
7c200000-7c3fffff : APMC0D12:01
7c400000-7c5fffff : APMC0D12:02
7c600000-7c7fffff : APMC0D12:03
7e000000-7e000fff : APMC0D13:00
7e200000-7e200fff : APMC0D10:03
  7e200000-7e200fff : APMC0D10:02
    7e200000-7e200fff : APMC0D10:01
      7e200000-7e200fff : APMC0D10:00
7e600000-7e600fff : APMC0D11:00
7e700000-7e700fff : APMC0D10:03
  7e700000-7e700fff : APMC0D10:02
    7e700000-7e700fff : APMC0D10:01
      7e700000-7e700fff : APMC0D10:00
7e720000-7e720fff : APMC0D10:03
  7e720000-7e720fff : APMC0D10:02
    7e720000-7e720fff : APMC0D10:01
      7e720000-7e720fff : APMC0D10:00
7e800000-7e800fff : APMC0D10:00
7e840000-7e840fff : APMC0D10:01
7e880000-7e880fff : APMC0D10:02
7e8c0000-7e8c0fff : APMC0D10:03
7e930000-7e930fff : APMC0D13:00
4000000000-4001ffffff : System RAM
  4000080000-4000c3ffff : Kernel code
  4000db0000-400165ffff : Kernel data
40023a0000-4ff733ffff : System RAM
4ff7340000-4ff77cffff : reserved
4ff77d0000-4ff79cffff : System RAM
4ff79d0000-4ff7e7ffff : reserved
4ff7e80000-4ff7e8ffff : System RAM
4ff7e90000-4ff7efffff : reserved
4ff7f10000-4ff800ffff : reserved
4ff8010000-4fffffffff : System RAM
a020000000-a03fffffff : PCI Bus 0000:00
  a020000000-a0201fffff : PCI Bus 0000:01
    a020000000-a0200fffff : 0000:01:00.0
      a020000000-a0200fffff : mlx4_core
    a020100000-a0201fffff : 0000:01:00.0
a060000000-a07fffffff : PCI Bus 0000:00
a0d0000000-a0dfffffff : PCI ECAM
a110000000-a14fffffff : PCI Bus 0000:00
  a110000000-a121ffffff : PCI Bus 0000:01
    a110000000-a111ffffff : 0000:01:00.0
      a110000000-a111ffffff : mlx4_core
    a112000000-a121ffffff : 0000:01:00.0

Adding a Tested-by for the record:

Tested-by: Jon Masters <jcm@redhat.com>

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop


--------------1C47BCD760538FFBBFAD194D
Content-Type: text/plain; charset=UTF-8;
 name="dmesg-4.9.0-rc7.ecam_jcm1+.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg-4.9.0-rc7.ecam_jcm1+.txt"

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.9.0-rc7.ecam_jcm1+ (root@hp-moonshot-02-c08.khw.lab.eng.bos.redhat.com) (gcc version 4.8.5 20150623 (Red Hat 4.8.5-11) (GCC) ) #1 SMP Fri Dec 2 01:13:24 EST 2016
[    0.000000] Boot CPU: AArch64 Processor [500f0001]
[    0.000000] earlycon: uart8250 at MMIO32 0x000000001c021000 (options '')
[    0.000000] bootconsole [uart8250] enabled
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: EFI v2.60 by HPE
[    0.000000] efi:  ACPI 2.0=0x4ff8000000  SMBIOS 3.0=0x4ff7a90000  MEMATTR=0x4ff2411818 
[    0.000000] cma: Reserved 512 MiB at 0x00000040e0000000
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x0000004FF8000000 000024 (v02 HP    )
[    0.000000] ACPI: XSDT 0x0000004FF7FF0000 000084 (v01 HP     ProLiant 00000001      01000013)
[    0.000000] ACPI: FACP 0x0000004FF7FB0000 000114 (v06 HPE    ProLiant 00000001 HP   00000001)
[    0.000000] ACPI: DSDT 0x0000004FF7F80000 0023CA (v05 HPE    DSDT     00000001 INTL 20160527)
[    0.000000] ACPI: SSDT 0x0000004FF7FE0000 000032 (v02 HPE    UARTCLKS 00000001      01000013)
[    0.000000] ACPI: BERT 0x0000004FF7FD0000 000030 (v01 HPE    ProLiant 00000002 INTL 20160527)
[    0.000000] ACPI: HEST 0x0000004FF7FC0000 0002A8 (v01 HPE    ProLiant 00000002 INTL 20160527)
[    0.000000] ACPI: DBG2 0x0000004FF7FA0000 0000A8 (v00 HPE    ProLiant 00000000 INTL 20160527)
[    0.000000] ACPI: GTDT 0x0000004FF7F90000 0000E0 (v02 HPE    ProLiant 00000001 INTL 20160527)
[    0.000000] ACPI: APIC 0x0000004FF7F70000 0002C4 (v03 HPE    ProLiant 00000001 HP   00000001)
[    0.000000] ACPI: MCFG 0x0000004FF7F60000 00003C (v01 APM    XGENE    00000001 HP   00000001)
[    0.000000] ACPI: SPMI 0x0000004FF7F50000 000041 (v05 HPE    ProLiant 00000001 HP   00000001)
[    0.000000] ACPI: RASF 0x0000004FF7F40000 000030 (v01 HPE    ProLiant 00000001 HP   00000001)
[    0.000000] ACPI: SPCR 0x0000004FF7F30000 000050 (v02 HPE    ProLiant 00000001 HP   00000001)
[    0.000000] ACPI: SSDT 0x0000004FF7F20000 000313 (v02 HPE    PCISSDT  00000002 HPAG 00020000)
[    0.000000] ACPI: SPCR: console: uart,mmio,0x1c021000,9600
[    0.000000] ACPI: NUMA: Failed to initialise from firmware
[    0.000000] NUMA: Faking a node at [mem 0x0000000000000000-0x0000004fffffffff]
[    0.000000] NUMA: Adding memblock [0x4000000000 - 0x4001ffffff] on node 0
[    0.000000] NUMA: Adding memblock [0x40023a0000 - 0x4ff733ffff] on node 0
[    0.000000] NUMA: Adding memblock [0x4ff7340000 - 0x4ff77cffff] on node 0
[    0.000000] NUMA: Adding memblock [0x4ff77d0000 - 0x4ff79cffff] on node 0
[    0.000000] NUMA: Adding memblock [0x4ff79d0000 - 0x4ff7e7ffff] on node 0
[    0.000000] NUMA: Adding memblock [0x4ff7e80000 - 0x4ff7e8ffff] on node 0
[    0.000000] NUMA: Adding memblock [0x4ff7e90000 - 0x4ff7efffff] on node 0
[    0.000000] NUMA: Adding memblock [0x4ff7f10000 - 0x4ff800ffff] on node 0
[    0.000000] NUMA: Adding memblock [0x4ff8010000 - 0x4fffffffff] on node 0
[    0.000000] NUMA: Initmem setup node 0 [mem 0x4000000000-0x4fffffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x4fffff2680-0x4fffffffff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000004000000000-0x00000040ffffffff]
[    0.000000]   Normal   [mem 0x0000004100000000-0x0000004fffffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000004000000000-0x0000004001ffffff]
[    0.000000]   node   0: [mem 0x00000040023a0000-0x0000004ff733ffff]
[    0.000000]   node   0: [mem 0x0000004ff7340000-0x0000004ff77cffff]
[    0.000000]   node   0: [mem 0x0000004ff77d0000-0x0000004ff79cffff]
[    0.000000]   node   0: [mem 0x0000004ff79d0000-0x0000004ff7e7ffff]
[    0.000000]   node   0: [mem 0x0000004ff7e80000-0x0000004ff7e8ffff]
[    0.000000]   node   0: [mem 0x0000004ff7e90000-0x0000004ff7efffff]
[    0.000000]   node   0: [mem 0x0000004ff7f10000-0x0000004ff800ffff]
[    0.000000]   node   0: [mem 0x0000004ff8010000-0x0000004fffffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000004000000000-0x0000004fffffffff]
[    0.000000] On node 0 totalpages: 1048517
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 65478 pages, LIFO batch:1
[    0.000000]   Normal zone: 960 pages used for memmap
[    0.000000]   Normal zone: 983039 pages, LIFO batch:1
[    0.000000] psci: is not implemented in ACPI.
[    0.000000] percpu: Embedded 3 pages/cpu @fffffe0fffdd0000 s117504 r8192 d70912 u196608
[    0.000000] pcpu-alloc: s117504 r8192 d70912 u196608 alloc=3*65536
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6 [0] 7 
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 1047493
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.9.0-rc7.ecam_jcm1+ root=/dev/mapper/rhel_hp--moonshot--02--c08-root ro crashkernel=auto rd.lvm.lv=rhel_hp-moonshot-02-c08/root rd.lvm.lv=rhel_hp-moonshot-02-c08/swap LANG=en_US.UTF-8 earlycon=uart8250,mmio32,0x1c021000 acpi=on console=ttyS0,115200
[    0.000000] PID hash table entries: 4096 (order: -1, 32768 bytes)
[    0.000000] software IO TLB [mem 0x40dbff0000-0x40dfff0000] (64MB) mapped at [fffffe00dbff0000-fffffe00dffeffff]
[    0.000000] Memory: 66372736K/67105088K available (8252K kernel code, 1588K rwdata, 3712K rodata, 1472K init, 6969K bss, 208064K reserved, 524288K cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     modules : 0xfffffc0000000000 - 0xfffffc0008000000   (   128 MB)
[    0.000000]     vmalloc : 0xfffffc0008000000 - 0xfffffdff5fff0000   (  2045 GB)
[    0.000000]       .text : 0xfffffc0008080000 - 0xfffffc0008890000   (  8256 KB)
[    0.000000]     .rodata : 0xfffffc0008890000 - 0xfffffc0008c40000   (  3776 KB)
[    0.000000]       .init : 0xfffffc0008c40000 - 0xfffffc0008db0000   (  1472 KB)
[    0.000000]       .data : 0xfffffc0008db0000 - 0xfffffc0008f3d200   (  1589 KB)
[    0.000000]        .bss : 0xfffffc0008f3d200 - 0xfffffc000960b640   (  6970 KB)
[    0.000000]     fixed   : 0xfffffdff7e7d0000 - 0xfffffdff7ec00000   (  4288 KB)
[    0.000000]     PCI I/O : 0xfffffdff7ee00000 - 0xfffffdff7fe00000   (    16 MB)
[    0.000000]     vmemmap : 0xfffffdff80000000 - 0xfffffe0000000000   (     2 GB maximum)
[    0.000000]               0xfffffdff80000000 - 0xfffffdff84000000   (    64 MB actual)
[    0.000000]     memory  : 0xfffffe0000000000 - 0xfffffe1000000000   ( 65536 MB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=4096 to nr_cpu_ids=8.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=8
[    0.000000] NR_IRQS:64 nr_irqs:64 0
[    0.000000] GIC: Using split EOI/Deactivate mode
[    0.000000] arm_arch_timer: Architected cp15 timer(s) running at 50.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0xb8812736b, max_idle_ns: 440795202655 ns
[    0.000002] sched_clock: 56 bits at 50MHz, resolution 20ns, wraps every 4398046511100ns
[    0.095756] Console: colour dummy device 80x25
[    0.148965] Calibrating delay loop (skipped), value calculated using timer frequency.. 100.00 BogoMIPS (lpj=50000)
[    0.272932] pid_max: default: 32768 minimum: 301
[    0.328254] ACPI: Core revision 20160831
[    0.377261] ACPI: 3 ACPI AML tables successfully acquired and loaded
[    0.453503] Security Framework initialized
[    0.502487] Yama: becoming mindful.
[    0.544196] SELinux:  Initializing.
[    0.586136] SELinux:  Starting in permissive mode
[    0.586869] Dentry cache hash table entries: 8388608 (order: 10, 67108864 bytes)
[    0.686272] Inode-cache hash table entries: 4194304 (order: 9, 33554432 bytes)
[    0.777994] Mount-cache hash table entries: 131072 (order: 4, 1048576 bytes)
[    0.862351] Mountpoint-cache hash table entries: 131072 (order: 4, 1048576 bytes)
[    0.952645] ftrace: allocating 30405 entries in 8 pages
[    1.039569] ASID allocator initialised with 65536 entries
[    1.105074] Remapping and enabling EFI services.
[    1.160335]   EFI remap 0x0000000010510000 => 0000000020000000
[    1.230115]   EFI remap 0x0000000010548000 => 0000000020018000
[    1.299898]   EFI remap 0x0000000017000000 => 0000000020020000
[    1.369577]   EFI remap 0x000000001c024000 => 0000000020034000
[    1.439257]   EFI remap 0x000000001f2a0000 => 0000000020040000
[    1.508938]   EFI remap 0x0000004002310000 => 0000000020050000
[    1.578618]   EFI remap 0x0000004ff7340000 => 00000000200b0000
[    1.648298]   EFI remap 0x0000004ff79d0000 => 0000000020540000
[    1.718341] Detected PIPT I-cache on CPU1
[    1.718373] CPU1: Booted secondary processor [500f0001]
[    1.718594] Detected PIPT I-cache on CPU2
[    1.718615] CPU2: Booted secondary processor [500f0001]
[    1.718842] Detected PIPT I-cache on CPU3
[    1.718856] CPU3: Booted secondary processor [500f0001]
[    1.719072] Detected PIPT I-cache on CPU4
[    1.719093] CPU4: Booted secondary processor [500f0001]
[    1.719300] Detected PIPT I-cache on CPU5
[    1.719313] CPU5: Booted secondary processor [500f0001]
[    1.719521] Detected PIPT I-cache on CPU6
[    1.719541] CPU6: Booted secondary processor [500f0001]
[    1.719755] Detected PIPT I-cache on CPU7
[    1.719768] CPU7: Booted secondary processor [500f0001]
[    1.719807] Brought up 8 CPUs
[    2.527052] SMP: Total of 8 processors activated.
[    2.583214] CPU features: detected feature: 32-bit EL0 Support
[    2.652997] CPU: All CPU(s) started at EL2
[    2.702850] devtmpfs: initialized
[    2.742885] SMBIOS 3.0.0 present.
[    2.782621] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    2.899666] atomic64_test: passed
[    2.939319] pinctrl core: initialized pinctrl subsystem
[    3.002210] NET: Registered protocol family 16
[    3.094849] cpuidle: using governor menu
[    3.141757] PCCT header not found.
[    3.182468] vdso: 2 pages (1 code @ fffffc00088b0000, 1 data @ fffffc0008dd0000)
[    3.270979] hw-breakpoint: found 4 breakpoint and 4 watchpoint registers.
[    3.352618] DMA: preallocated 256 KiB pool for atomic allocations
[    3.425557] ACPI: bus type PCI registered
[    3.473503] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    3.550649] Serial: AMBA PL011 UART driver
[    3.604874] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    3.680904] HugeTLB registered 512 MB page size, pre-allocated 0 pages
[    3.759544] ACPI: Added _OSI(Module Device)
[    3.809574] ACPI: Added _OSI(Processor Device)
[    3.862714] ACPI: Added _OSI(3.0 _SCP Extensions)
[    3.918979] ACPI: Added _OSI(Processor Aggregator Device)
[    3.983661] ACPI: Executed 1 blocks of module-level executable AML code
[    4.066666] ACPI: Interpreter enabled
[    4.110452] ACPI: Using GIC for interrupt routing
[    4.166749] ACPI: MCFG table detected, 1 entries
[    4.224566] ACPI: Power Resource [SCVR] (off)
[    4.280222] ACPI: PCI Root Bridge [PCI3] (domain 0000 [bus 00-ff])
[    4.354192] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    4.452277] acpi PNP0A08:00: _OSC: platform does not support [AER]
[    4.526392] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    4.618041] acpi PNP0A08:00: MCFG quirk: ECAM at [mem 0xa0d0000000-0xa0dfffffff] for [bus 00-ff] with xgene_v1_pcie_ecam_ops
[    4.752751] acpi PNP0A08:00: [Firmware Bug]: ECAM area [mem 0xa0d0000000-0xa0dfffffff] not reserved in ACPI namespace
[    4.879773] acpi PNP0A08:00: ECAM at [mem 0xa0d0000000-0xa0dfffffff] for [bus 00-ff]
[    4.972464] Remapped I/O 0x000000a100010000 to [io  0x0000-0xffff window]
[    5.053790] PCI host bridge to bus 0000:00
[    5.102777] pci_bus 0000:00: root bus resource [mem 0x1f500000-0x1f50ffff]
[    5.185045] pci_bus 0000:00: root bus resource [io  0x0000-0xffff window] (bus address [0x10000-0x1ffff])
[    5.299551] pci_bus 0000:00: root bus resource [mem 0xa020000000-0xa03fffffff window] (bus address [0x20000000-0x3fffffff])
[    5.432782] pci_bus 0000:00: root bus resource [mem 0xa060000000-0xa07fffffff window] (bus address [0x40000000-0x5fffffff])
[    5.566012] pci_bus 0000:00: root bus resource [mem 0xa110000000-0xa14fffffff window]
[    5.659719] pci_bus 0000:00: root bus resource [bus 00-ff]
[    5.725358] pci 0000:00:00.0: [10e8:e004] type 01 class 0x060400
[    5.725429] pci 0000:00:00.0: supports D1 D2
[    5.725769] pci 0000:01:00.0: [15b3:1007] type 00 class 0x020000
[    5.726099] pci 0000:01:00.0: reg 0x10: [mem 0xa020000000-0xa0200fffff 64bit]
[    5.726334] pci 0000:01:00.0: reg 0x18: [mem 0xa122000000-0xa123ffffff 64bit pref]
[    5.726782] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x000fffff pref]
[    5.728513] pci 0000:01:00.0: reg 0x134: [mem 0xa112000000-0xa113ffffff 64bit pref]
[    5.728516] pci 0000:01:00.0: VF(n) BAR2 space: [mem 0xa112000000-0xa121ffffff 64bit pref] (contains BAR2 for 8 VFs)
[    5.858575] pci_bus 0000:00: on NUMA node 0
[    5.858596] pci 0000:00:00.0: BAR 15: assigned [mem 0xa110000000-0xa121ffffff 64bit pref]
[    5.956467] pci 0000:00:00.0: BAR 14: assigned [mem 0xa020000000-0xa0201fffff]
[    6.042899] pci 0000:01:00.0: BAR 2: assigned [mem 0xa110000000-0xa111ffffff 64bit pref]
[    6.139875] pci 0000:01:00.0: BAR 9: assigned [mem 0xa112000000-0xa121ffffff 64bit pref]
[    6.236850] pci 0000:01:00.0: BAR 0: assigned [mem 0xa020000000-0xa0200fffff 64bit]
[    6.328628] pci 0000:01:00.0: BAR 6: assigned [mem 0xa020100000-0xa0201fffff pref]
[    6.419214] pci 0000:00:00.0: PCI bridge to [bus 01]
[    6.478604] pci 0000:00:00.0:   bridge window [mem 0xa020000000-0xa0201fffff]
[    6.563989] pci 0000:00:00.0:   bridge window [mem 0xa110000000-0xa121ffffff 64bit pref]
[    6.661311] vgaarb: loaded
[    6.693956] SCSI subsystem initialized
[    6.738878] libata version 3.00 loaded.
[    6.738926] ACPI: bus type USB registered
[    6.786909] usbcore: registered new interface driver usbfs
[    6.852553] usbcore: registered new interface driver hub
[    6.916134] usbcore: registered new device driver usb
[    6.976590] pps_core: LinuxPPS API ver. 1 registered
[    7.035977] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    7.145293] PTP clock support registered
[    7.192292] Registered efivars operations
[    7.240931] NetLabel: Initializing
[    7.281601] NetLabel:  domain hash size = 128
[    7.333709] NetLabel:  protocols = UNLABELED CIPSOv4
[    7.393122] NetLabel:  unlabeled traffic allowed by default
[    7.459934] clocksource: Switched to clocksource arch_sys_counter
[    7.549152] VFS: Disk quotas dquot_6.6.0
[    7.596123] VFS: Dquot-cache hash table entries: 8192 (order 0, 65536 bytes)
[    7.680705] pnp: PnP ACPI init
[    7.717581] pnp: PnP ACPI: found 0 devices
[    7.770079] NET: Registered protocol family 2
[    7.822577] TCP established hash table entries: 524288 (order: 6, 4194304 bytes)
[    7.912429] TCP bind hash table entries: 65536 (order: 4, 1048576 bytes)
[    7.992997] TCP: Hash tables configured (established 524288 bind 65536)
[    8.072192] UDP hash table entries: 32768 (order: 4, 1048576 bytes)
[    8.147724] UDP-Lite hash table entries: 32768 (order: 4, 1048576 bytes)
[    8.228576] NET: Registered protocol family 1
[    8.280729] PCI: CLS 64 bytes, default 128
[    8.280854] Unpacking initramfs...
[    9.184613] Freeing initrd memory: 40640K (fffffe0f83af0000 - fffffe0f862a0000)
[    9.272311] kvm [1]: 8-bit VMID
[    9.309861] kvm [1]: IDMAP page: 4000884000
[    9.359888] kvm [1]: HYP VA range: 20000000000:3ffffffffff
[    9.425594] kvm [1]: Hyp mode initialized successfully
[    9.487078] kvm [1]: GICV region size/alignment is unsafe, using trapping (reduced performance)
[    9.591201] kvm [1]: vgic-v2@780cf000
[    9.635096] kvm [1]: vgic interrupt IRQ1
[    9.682014] kvm [1]: virtual timer IRQ4
[    9.728216] alg: No test for __ecb-aes-neon (__driver-ecb-aes-neon)
[    9.807218] alg: No test for __ecb-aes-neon (cryptd(__driver-ecb-aes-neon))
[    9.891661] futex hash table entries: 2048 (order: 2, 262144 bytes)
[    9.966722] audit: initializing netlink subsys (disabled)
[   10.031339] audit: type=2000 audit(7.043:1): initialized
[   10.095074] Initialise system trusted keyrings
[   10.148374] workingset: timestamp_bits=37 max_order=20 bucket_order=0
[   10.228891] zbud: loaded
[   10.260564] SELinux:  Registering netfilter hooks
[   10.338070] alg: drbg: Test 0 failed for drbg_pr_ctr_aes128
[   10.409012] alg: drbg: Test 0 failed for drbg_nopr_ctr_aes128
[   10.477839] alg: drbg: Test 0 failed for drbg_nopr_ctr_aes192
[   10.546676] alg: drbg: Test 0 failed for drbg_nopr_ctr_aes256
[   10.616496] NET: Registered protocol family 38
[   10.669654] Key type asymmetric registered
[   10.718642] Asymmetric key parser 'x509' registered
[   10.777049] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
[   10.865626] io scheduler noop registered
[   10.912532] io scheduler deadline registered (default)
[   10.974027] io scheduler cfq registered
[   11.020433] xgene-gpio APMC0D14:00: X-Gene GPIO driver registered.
[   11.094468] pcieport 0000:00:00.0: can't derive routing for PCI INT A
[   11.171541] pcieport 0000:00:00.0: PCI INT A: no GSI
[   11.231078] pcie_pme: probe of 0000:00:00.0:pcie001 failed with error -22
[   11.312317] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   11.378990] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[   11.458322] acpi ACPI0007:00: CPPC data invalid or not present
[   11.528130] acpi ACPI0007:01: CPPC data invalid or not present
[   11.597937] acpi ACPI0007:02: CPPC data invalid or not present
[   11.667732] acpi ACPI0007:03: CPPC data invalid or not present
[   11.737570] acpi ACPI0007:04: CPPC data invalid or not present
[   11.807372] acpi ACPI0007:05: CPPC data invalid or not present
[   11.877171] acpi ACPI0007:06: CPPC data invalid or not present
[   11.946965] acpi ACPI0007:07: CPPC data invalid or not present
[   12.017272] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[   12.107120] console [ttyS0] disabled
[   12.169999] APMC0D08:00: ttyS0 at MMIO 0x1c021000 (irq = 23, base_baud = 3125000) is a U6_16550A
[   12.275162] console [ttyS0] enabled
[   12.282276] bootconsole [uart8250] disabled
[   12.290991] msm_serial: driver initialized
[   12.295331] Failed to find cpu0 device node
[   12.299499] Unable to detect cache hierarchy from DT for CPU 0
[   12.305469] hisi_sas: driver version v1.6
[   12.309689] xgene-ahci APMC0D0D:00: skip clock and PHY initialization
[   12.316107] xgene-ahci APMC0D0D:00: controller can't do NCQ, turning off CAP_NCQ
[   12.323490] xgene-ahci APMC0D0D:00: AHCI 0001.0300 32 slots 2 ports 6 Gbps 0x3 impl platform mode
[   12.332322] xgene-ahci APMC0D0D:00: flags: 64bit sntf pm only pmp fbs pio slum part ccc 
[   12.340380] xgene-ahci APMC0D0D:00: port 0 is not capable of FBS
[   12.346434] xgene-ahci APMC0D0D:00: port 1 is not capable of FBS
[   12.352901] scsi host0: xgene-ahci
[   12.356508] scsi host1: xgene-ahci
[   12.359998] ata1: SATA max UDMA/133 mmio [mem 0x1a800000-0x1a800fff] port 0x100 irq 24
[   12.367881] ata2: SATA max UDMA/133 mmio [mem 0x1a800000-0x1a800fff] port 0x180 irq 24
[   12.375908] libphy: Fixed MDIO Bus: probed
[   12.380221] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   12.386750] ehci-pci: EHCI PCI platform driver
[   12.391204] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   12.397361] ohci-pci: OHCI PCI platform driver
[   12.401799] uhci_hcd: USB Universal Host Controller Interface driver
[   12.408211] usbcore: registered new interface driver usbserial
[   12.414031] usbcore: registered new interface driver usbserial_generic
[   12.420538] usbserial: USB Serial support registered for generic
[   12.426614] mousedev: PS/2 mouse device common for all mice
[   12.432413] rtc-efi rtc-efi: rtc core: registered rtc-efi as rtc0
[   12.438724] device-mapper: uevent: version 1.0.3
[   12.443483] device-mapper: ioctl: 4.35.0-ioctl (2016-06-23) initialised: dm-devel@redhat.com
[   12.452521] EFI Variables Facility v0.08 2004-May-17
[   12.458529] hidraw: raw HID events driver (C) Jiri Kosina
[   12.463991] usbcore: registered new interface driver usbhid
[   12.469538] usbhid: USB HID core driver
[   12.473518] drop_monitor: Initializing network drop monitor service
[   12.479859] ip_tables: (C) 2000-2006 Netfilter Core Team
[   12.485173] Initializing XFRM netlink socket
[   12.489680] NET: Registered protocol family 10
[   12.494552] mip6: Mobile IPv6
[   12.497521] NET: Registered protocol family 17
[   12.502256] registered taskstats version 1
[   12.506364] Loading compiled-in X.509 certificates
[   12.514345] alg: No test for pkcs1pad(rsa,sha256) (pkcs1pad(rsa-generic,sha256))
[   12.523159] Loaded X.509 cert 'Build time autogenerated kernel key: 77693cf6411eaf44ab625b1d7d0930f7f0e46073'
[   12.533104] zswap: loaded using pool lzo/zbud
[   12.557452] Key type big_key registered
[   12.561445] rtc-efi rtc-efi: setting system clock to 2016-12-02 07:08:49 UTC (1480662529)
[   12.569616] PM: Hibernation image not present or could not be loaded.
[   12.680057] ata2: SATA link down (SStatus 0 SControl 4300)
[   13.002940] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 4300)
[   13.009409] ata1.00: ATA-9: XR0120GEBLT, HPS4, max UDMA/133
[   13.014958] ata1.00: 234441648 sectors, multi 16: LBA48 NCQ (depth 0/32)
[   13.021842] ata1.00: configured for UDMA/133
[   13.026398] scsi 0:0:0:0: Direct-Access     ATA      XR0120GEBLT      HPS4 PQ: 0 ANSI: 5
[   13.048217] sd 0:0:0:0: [sda] 234441648 512-byte logical blocks: (120 GB/112 GiB)
[   13.048233] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   13.060966] sd 0:0:0:0: [sda] 4096-byte physical blocks
[   13.066263] sd 0:0:0:0: [sda] Write Protect is off
[   13.071038] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   13.071065] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   13.082550]  sda: sda1 sda2 sda3
[   13.086305] sd 0:0:0:0: [sda] Attached SCSI disk
[   13.091001] Freeing unused kernel memory: 1472K (fffffe0000c40000 - fffffe0000db0000)
[   13.104494] random: systemd: uninitialized urandom read (16 bytes read)
[   13.111710] random: systemd: uninitialized urandom read (16 bytes read)
[   13.120229] systemd[1]: systemd 219 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 -SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
[   13.138467] systemd[1]: Detected architecture arm64.
[   13.143426] systemd[1]: Running in initial RAM disk.
[   13.160020] systemd[1]: Set hostname to <localhost.localdomain>.
[   13.209760] random: systemd: uninitialized urandom read (16 bytes read)
[   13.216398] random: systemd: uninitialized urandom read (16 bytes read)
[   13.223045] random: systemd: uninitialized urandom read (16 bytes read)
[   13.229734] random: systemd: uninitialized urandom read (16 bytes read)
[   13.237511] random: systemd: uninitialized urandom read (16 bytes read)
[   13.244368] random: systemd: uninitialized urandom read (16 bytes read)
[   13.251316] random: systemd: uninitialized urandom read (16 bytes read)
[   13.258995] random: systemd: uninitialized urandom read (16 bytes read)
[   13.279008] systemd[1]: Reached target Local File Systems.
[   13.284502] systemd[1]: Starting Local File Systems.
[   13.293970] systemd[1]: Reached target Timers.
[   13.298420] systemd[1]: Starting Timers.
[   13.305963] systemd[1]: Reached target Swap.
[   13.310236] systemd[1]: Starting Swap.
[   13.769659] mlx4_core: Mellanox ConnectX core driver v2.2-1 (Feb, 2014)
[   13.776270] mlx4_core: Initializing 0000:01:00.0
[   20.170768] mlx4_core 0000:01:00.0: PCIe BW is different than device's capability
[   20.178225] mlx4_core 0000:01:00.0: PCIe link speed is 5.0GT/s, device supports 8.0GT/s
[   20.186196] mlx4_core 0000:01:00.0: PCIe link width is x8, device supports x8
[   20.254285] mlx4_en: Mellanox ConnectX HCA Ethernet driver v2.2-1 (Feb 2014)
[   20.261527] mlx4_en 0000:01:00.0: Activating port:1
[   20.270054] mlx4_en: 0000:01:00.0: Port 1: Using 64 TX rings
[   20.275694] mlx4_en: 0000:01:00.0: Port 1: Using 4 RX rings
[   20.281248] mlx4_en: 0000:01:00.0: Port 1:   frag:0 - size:1522 prefix:0 stride:1536
[   20.289388] mlx4_en: 0000:01:00.0: Port 1: Initializing port
[   20.295382] mlx4_en 0000:01:00.0: registered PHC clock
[   20.301884] mlx4_en 0000:01:00.0: Activating port:2
[   20.311329] mlx4_en: 0000:01:00.0: Port 2: Using 64 TX rings
[   20.316970] mlx4_en: 0000:01:00.0: Port 2: Using 4 RX rings
[   20.322524] mlx4_en: 0000:01:00.0: Port 2:   frag:0 - size:1522 prefix:0 stride:1536
[   20.330486] mlx4_en: 0000:01:00.0: Port 2: Initializing port
[   20.340953] mlx4_core 0000:01:00.0 eno1: renamed from eth0
[   20.354060] mlx4_core 0000:01:00.0 eno1d1: renamed from eth1
[   20.509086] random: fast init done
[   20.939043] SGI XFS with ACLs, security attributes, no debug enabled
[   20.949572] XFS (dm-0): Mounting V5 Filesystem
[   20.996107] XFS (dm-0): Ending clean mount
[   21.316404] systemd-journald[184]: Received SIGTERM from PID 1 (systemd).
[   21.332768] systemd: 20 output lines suppressed due to ratelimiting
[   21.362297] audit: type=1404 audit(1480662538.300:2): enforcing=1 old_enforcing=0 auid=4294967295 ses=4294967295
[   21.406592] SELinux: 32768 avtab hash slots, 104865 rules.
[   21.436918] mlx4_en: eno1d1: Link Up
[   21.439508] SELinux: 32768 avtab hash slots, 104865 rules.
[   21.518982] SELinux:  8 users, 14 roles, 4983 types, 301 bools, 1 sens, 1024 cats
[   21.518988] SELinux:  91 classes, 104865 rules
[   21.527050] SELinux:  Permission validate_trans in class security not defined in policy.
[   21.535131] SELinux:  Permission module_load in class system not defined in policy.
[   21.542940] SELinux:  Class binder not defined in policy.
[   21.548315] SELinux:  Class cap_userns not defined in policy.
[   21.554034] SELinux:  Class cap2_userns not defined in policy.
[   21.559839] SELinux: the above unknown classes and permissions will be allowed
[   21.567040] SELinux:  Completing initialization.
[   21.567041] SELinux:  Setting up existing superblocks.
[   21.589001] audit: type=1403 audit(1480662538.527:3): policy loaded auid=4294967295 ses=4294967295
[   21.602317] systemd[1]: Successfully loaded SELinux policy in 240.116ms.
[   21.625267] systemd[1]: RTC configured in localtime, applying delta of -300 minutes to system time.
[   21.685435] systemd[1]: Relabelled /dev and /run in 47.567ms.
[   21.911601] systemd-journald[582]: Received request to flush runtime journal from PID 1
[   22.036041] xgene-slimpro-mbox APMC0D01:00: APM X-Gene SLIMpro MailBox registered
[   22.040712] input: Power Button as /devices/LNXSYSTM:00/PNP0C0C:00/input/input0
[   22.041340] ACPI: Power Button [PWRB]
[   22.049473] RPC: Registered named UNIX socket transport module.
[   22.049475] RPC: Registered udp transport module.
[   22.049476] RPC: Registered tcp transport module.
[   22.049476] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   22.159308] xgene-rng APMC0D18:00: Couldn't get the clock for RNG
[   22.165809] xgene-gpio-sb APMC0D15:00: Support 22 gpios, 6 irqs start from pin 8
[   22.173923] xgene-gpio-sb APMC0D15:00: X-Gene GPIO Standby driver registered
[   22.186216] xgene-slimpro-i2c APMC0D40:00: i2c mailbox channel request failed
[   22.217326] Adding 11722688k swap on /dev/mapper/rhel_hp--moonshot--02--c08-swap.  Priority:-1 extents:1 across:11722688k SSFS
[   22.218880] XFS (sda2): Mounting V5 Filesystem
[   22.282954] XFS (sda2): Ending clean mount
[   22.341950] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   22.463610] XFS (dm-2): Mounting V5 Filesystem
[   22.497399] XFS (dm-2): Ending clean mount
[   22.514725] <mlx4_ib> mlx4_ib_add: mlx4_ib: Mellanox ConnectX InfiniBand driver v2.2-1 (Feb 2014)
[   22.526908] <mlx4_ib> mlx4_ib_add: counter index 2 for port 1 allocated 1
[   22.538735] <mlx4_ib> mlx4_ib_add: counter index 3 for port 2 allocated 1
[   22.639341] audit: type=1305 audit(1480680539.576:4): audit_pid=757 old=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:auditd_t:s0 res=1
[   22.930086] IPv6: ADDRCONF(NETDEV_UP): eno1: link is not ready
[   22.940637] mlx4_en: eno1:   frag:0 - size:1522 prefix:0 stride:1536
[   23.001983] mlx4_en: eno1: Link Up
[   23.010286] IPv6: ADDRCONF(NETDEV_UP): eno1d1: link is not ready
[   23.017123] mlx4_en: eno1d1:   frag:0 - size:1522 prefix:0 stride:1536
[   23.036178] Rounding down aligned max_sectors from 4294967295 to 4294967168
[   23.089166] Loading iSCSI transport class v2.0-870.
[   23.140692] iscsi: registered transport (iser)
[   23.394165] RPC: Registered rdma transport module.
[   23.398973] RPC: Registered rdma backchannel transport module.
[   79.179310] random: crng init done

--------------1C47BCD760538FFBBFAD194D--
