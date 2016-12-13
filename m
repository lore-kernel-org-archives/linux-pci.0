Return-Path: <SRS0=TQzA=X4=redhat.com=jcm@kernel.org>
Return-Path: <SRS0=TQzA=X4=redhat.com=jcm@kernel.org>
Subject: Re: [PATCH v3] PCI/ACPI: xgene: Add ECAM quirk for X-Gene PCIe
 controller
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1480620053.4751.30.camel@redhat.com>
 <20161201194114.GA8263@bhelgaas-glaptop.roam.corp.google.com>
 <CADaLNDkVPRPSg0aU-sxHsiJbVvEn=LxcekDt6gfXBBhc+fzhjw@mail.gmail.com>
 <20161201230736.GA17948@bhelgaas-glaptop.roam.corp.google.com>
 <CADaLND=Ss8d-jv7wffbrtytrjj=SUnjDn9bognKUszhKguRV1A@mail.gmail.com>
 <d77e403c-81e9-114e-6ec6-bbffaa4ac36f@redhat.com>
 <20161202233943.GF9903@bhelgaas-glaptop.roam.corp.google.com>
 <62dd5462-4d68-b89f-2b45-0d58bbd96bcd@redhat.com>
 <20161205212140.GA18259@bhelgaas-glaptop.roam.corp.google.com>
 <aac9391d-8803-f5e8-f4e4-d7e56d54c05c@redhat.com>
 <20161206201835.GA19700@bhelgaas-glaptop.roam.corp.google.com>
Cc: Duc Dang <dhdang@apm.com>, Mark Salter <msalter@redhat.com>,
        Rafael Wysocki <rafael@kernel.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Arnd Bergmann
 <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomasz Nowicki <tn@semihalf.com>, patches <patches@apm.com>
From: Jon Masters <jcm@redhat.com>
Message-ID: <723507e2-b7c2-5d54-284d-67a0427ded7a@redhat.com>
Date: Tue, 13 Dec 2016 16:35:25 -0500
MIME-Version: 1.0
In-Reply-To: <20161206201835.GA19700@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: multipart/mixed;
 boundary="------------6BF4153A57A9BBE0BCB17F2D"
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------6BF4153A57A9BBE0BCB17F2D
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

On 12/06/2016 03:18 PM, Bjorn Helgaas wrote:

> I just merged pci/ecam into my "next" branch, so as long as tomorrow's
> linux-next boots out of the box, we should be set.  I made the following
> changes compared to v11:
> 
>   - dropped the x86 change to use acpi_resource_consumer()
>   - added parens around macro args used in arithmetic expressions
>   - renamed "seg" to "node" in THUNDER_PEM_RES and THUNDER_PEM_QUIRK
>   - incorporated (u64) cast and dropped "UL" postfix for THUNDER_PEM_QUIRK
> 
> Let me know if you see any issues.

Just following up. Please find attached a boot log from an HPE ProLiant m400
Moonshot X-Gene based cartridge running next-20161213 with pci/ecam branch.

Here is the /proc/iomem output as well:

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
  4000080000-4000c9ffff : Kernel code
  4000e20000-400171ffff : Kernel data
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

Thanks again, Bjorn. Looking forward to seeing this upstream.

Tested-by: Jon Masters <jcm@redhat.com>

-- 
Computer Architect | Sent from my Fedora powered laptop


--------------6BF4153A57A9BBE0BCB17F2D
Content-Type: text/plain; charset=UTF-8;
 name="dmesg-next-20161213.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg-next-20161213.txt"

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.9.0-next-20161213.next20161213_jcm1 (root@hp-moonshot-02-c08.khw.lab.eng.bos.redhat.com) (gcc version 4.8.5 20150623 (Red Hat 4.8.5-11) (GCC) ) #1 SMP Tue Dec 13 15:42:15 EST 2016
[    0.000000] Boot CPU: AArch64 Processor [500f0001]
[    0.000000] earlycon: uart8250 at MMIO32 0x000000001c021000 (options '')
[    0.000000] bootconsole [uart8250] enabled
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: EFI v2.60 by HPE
[    0.000000] efi:  ACPI 2.0=0x4ff8000000  SMBIOS 3.0=0x4ff7a90000  MEMATTR=0x4ff2410698  RNG=0x4ff7e7f518 
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
[    0.000000] percpu: Embedded 3 pages/cpu @fffffe0fffdd0000 s117248 r8192 d71168 u196608
[    0.000000] pcpu-alloc: s117248 r8192 d71168 u196608 alloc=3*65536
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6 [0] 7 
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 1047493
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.9.0-next-20161213.next20161213_jcm1 root=/dev/mapper/rhel_hp--moonshot--02--c08-root ro crashkernel=auto rd.lvm.lv=rhel_hp-moonshot-02-c08/root rd.lvm.lv=rhel_hp-moonshot-02-c08/swap LANG=en_US.UTF-8 acpi=on earlycon=uart8250,mmio32,0x1c021000 console=ttyS0,9600
[    0.000000] PID hash table entries: 4096 (order: -1, 32768 bytes)
[    0.000000] software IO TLB [mem 0x40dbff0000-0x40dfff0000] (64MB) mapped at [fffffe00dbff0000-fffffe00dffeffff]
[    0.000000] Memory: 66377408K/67105088K available (8572K kernel code, 1626K rwdata, 3776K rodata, 1536K init, 7219K bss, 203392K reserved, 524288K cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     modules : 0xfffffc0000000000 - 0xfffffc0008000000   (   128 MB)
[    0.000000]     vmalloc : 0xfffffc0008000000 - 0xfffffdff5fff0000   (  2045 GB)
[    0.000000]       .text : 0xfffffc0008080000 - 0xfffffc00088e0000   (  8576 KB)
[    0.000000]     .rodata : 0xfffffc00088e0000 - 0xfffffc0008ca0000   (  3840 KB)
[    0.000000]       .init : 0xfffffc0008ca0000 - 0xfffffc0008e20000   (  1536 KB)
[    0.000000]       .data : 0xfffffc0008e20000 - 0xfffffc0008fb6a00   (  1627 KB)
[    0.000000]        .bss : 0xfffffc0008fb6a00 - 0xfffffc00096c38d0   (  7220 KB)
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
[    0.095859] Console: colour dummy device 80x25
[    0.149059] Calibrating delay loop (skipped), value calculated using timer frequency.. 100.00 BogoMIPS (lpj=50000)
[    0.273029] pid_max: default: 32768 minimum: 301
[    0.328350] ACPI: Core revision 20160930
[    0.377378] ACPI: 3 ACPI AML tables successfully acquired and loaded
[    0.453514] Security Framework initialized
[    0.502501] Yama: becoming mindful.
[    0.544208] SELinux:  Initializing.
[    0.586151] SELinux:  Starting in permissive mode
[    0.586902] Dentry cache hash table entries: 8388608 (order: 10, 67108864 bytes)
[    0.686317] Inode-cache hash table entries: 4194304 (order: 9, 33554432 bytes)
[    0.778042] Mount-cache hash table entries: 131072 (order: 4, 1048576 bytes)
[    0.862396] Mountpoint-cache hash table entries: 131072 (order: 4, 1048576 bytes)
[    0.952631] ftrace: allocating 31238 entries in 8 pages
[    1.040528] ASID allocator initialised with 65536 entries
[    1.105893] Remapping and enabling EFI services.
[    1.161155]   EFI remap 0x0000000010510000 => 0000000020000000
[    1.230941]   EFI remap 0x0000000010548000 => 0000000020018000
[    1.300723]   EFI remap 0x0000000017000000 => 0000000020020000
[    1.370507]   EFI remap 0x000000001c024000 => 0000000020034000
[    1.440187]   EFI remap 0x000000001f2a0000 => 0000000020040000
[    1.509867]   EFI remap 0x0000004002310000 => 0000000020050000
[    1.579547]   EFI remap 0x0000004ff7340000 => 00000000200b0000
[    1.649331]   EFI remap 0x0000004ff79d0000 => 0000000020540000
[    1.719184] smp: Bringing up secondary CPUs ...
[    1.773561] Detected PIPT I-cache on CPU1
[    1.773591] CPU1: Booted secondary processor [500f0001]
[    1.773810] Detected PIPT I-cache on CPU2
[    1.773831] CPU2: Booted secondary processor [500f0001]
[    1.774052] Detected PIPT I-cache on CPU3
[    1.774065] CPU3: Booted secondary processor [500f0001]
[    1.774263] Detected PIPT I-cache on CPU4
[    1.774283] CPU4: Booted secondary processor [500f0001]
[    1.774502] Detected PIPT I-cache on CPU5
[    1.774516] CPU5: Booted secondary processor [500f0001]
[    1.774715] Detected PIPT I-cache on CPU6
[    1.774735] CPU6: Booted secondary processor [500f0001]
[    1.774947] Detected PIPT I-cache on CPU7
[    1.774960] CPU7: Booted secondary processor [500f0001]
[    1.774998] smp: Brought up 1 node, 8 CPUs
[    2.595763] SMP: Total of 8 processors activated.
[    2.651925] CPU features: detected feature: 32-bit EL0 Support
[    2.863045] CPU: All CPU(s) started at EL2
[    2.912933] devtmpfs: initialized
[    2.952981] SMBIOS 3.0.0 present.
[    2.992611] DMI: HPE ProLiant m400 Server/ProLiant m400 Server, BIOS U02 06/25/2016
[    3.084336] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    3.201380] atomic64_test: passed
[    3.241036] pinctrl core: initialized pinctrl subsystem
[    3.303945] NET: Registered protocol family 16
[    3.357675] cpuidle: using governor menu
[    3.404583] PCCT header not found.
[    3.445296] vdso: 2 pages (1 code @ fffffc0008900000, 1 data @ fffffc0008e40000)
[    3.533818] hw-breakpoint: found 4 breakpoint and 4 watchpoint registers.
[    3.615473] DMA: preallocated 256 KiB pool for atomic allocations
[    3.688440] ACPI: bus type PCI registered
[    3.736390] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    3.813544] Serial: AMBA PL011 UART driver
[    3.865355] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    3.941388] HugeTLB registered 512 MB page size, pre-allocated 0 pages
[    4.020035] ACPI: Added _OSI(Module Device)
[    4.070067] ACPI: Added _OSI(Processor Device)
[    4.123208] ACPI: Added _OSI(3.0 _SCP Extensions)
[    4.179473] ACPI: Added _OSI(Processor Aggregator Device)
[    4.244129] ACPI: Executed 1 blocks of module-level executable AML code
[    4.327259] ACPI: Interpreter enabled
[    4.371051] ACPI: Using GIC for interrupt routing
[    4.427339] ACPI: MCFG table detected, 1 entries
[    4.485254] ACPI: Power Resource [SCVR] (off)
[    4.540968] ACPI: PCI Root Bridge [PCI3] (domain 0000 [bus 00-ff])
[    4.614943] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    4.713012] acpi PNP0A08:00: _OSC: platform does not support [AER]
[    4.787128] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    4.878780] acpi PNP0A08:00: MCFG quirk: ECAM at [mem 0xa0d0000000-0xa0dfffffff] for [bus 00-ff] with xgene_v1_pcie_ecam_ops
[    5.013499] acpi PNP0A08:00: [Firmware Bug]: ECAM area [mem 0xa0d0000000-0xa0dfffffff] not reserved in ACPI namespace
[    5.140522] acpi PNP0A08:00: ECAM at [mem 0xa0d0000000-0xa0dfffffff] for [bus 00-ff]
[    5.233212] Remapped I/O 0x000000a100010000 to [io  0x0000-0xffff window]
[    5.314538] PCI host bridge to bus 0000:00
[    5.363532] pci_bus 0000:00: root bus resource [io  0x0000-0xffff window] (bus address [0x10000-0x1ffff])
[    5.478041] pci_bus 0000:00: root bus resource [mem 0xa020000000-0xa03fffffff window] (bus address [0x20000000-0x3fffffff])
[    5.611273] pci_bus 0000:00: root bus resource [mem 0xa060000000-0xa07fffffff window] (bus address [0x40000000-0x5fffffff])
[    5.744502] pci_bus 0000:00: root bus resource [mem 0xa110000000-0xa14fffffff window]
[    5.838210] pci_bus 0000:00: root bus resource [bus 00-ff]
[    5.903849] pci 0000:00:00.0: [10e8:e004] type 01 class 0x060400
[    5.903922] pci 0000:00:00.0: supports D1 D2
[    5.904276] pci 0000:01:00.0: [15b3:1007] type 00 class 0x020000
[    5.904601] pci 0000:01:00.0: reg 0x10: [mem 0xa020000000-0xa0200fffff 64bit]
[    5.904846] pci 0000:01:00.0: reg 0x18: [mem 0xa122000000-0xa123ffffff 64bit pref]
[    5.905278] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x000fffff pref]
[    5.907014] pci 0000:01:00.0: reg 0x134: [mem 0xa112000000-0xa113ffffff 64bit pref]
[    5.907016] pci 0000:01:00.0: VF(n) BAR2 space: [mem 0xa112000000-0xa121ffffff 64bit pref] (contains BAR2 for 8 VFs)
[    6.037078] pci_bus 0000:00: on NUMA node 0
[    6.037098] pci 0000:00:00.0: BAR 15: assigned [mem 0xa110000000-0xa121ffffff 64bit pref]
[    6.134970] pci 0000:00:00.0: BAR 14: assigned [mem 0xa020000000-0xa0201fffff]
[    6.221401] pci 0000:01:00.0: BAR 2: assigned [mem 0xa110000000-0xa111ffffff 64bit pref]
[    6.318379] pci 0000:01:00.0: BAR 9: assigned [mem 0xa112000000-0xa121ffffff 64bit pref]
[    6.415273] pci 0000:01:00.0: BAR 0: assigned [mem 0xa020000000-0xa0200fffff 64bit]
[    6.507043] pci 0000:01:00.0: BAR 6: assigned [mem 0xa020100000-0xa0201fffff pref]
[    6.597633] pci 0000:00:00.0: PCI bridge to [bus 01]
[    6.657022] pci 0000:00:00.0:   bridge window [mem 0xa020000000-0xa0201fffff]
[    6.742414] pci 0000:00:00.0:   bridge window [mem 0xa110000000-0xa121ffffff 64bit pref]
[    6.839684] vgaarb: loaded
[    6.872357] SCSI subsystem initialized
[    6.917272] libata version 3.00 loaded.
[    6.917319] ACPI: bus type USB registered
[    6.965300] usbcore: registered new interface driver usbfs
[    7.030944] usbcore: registered new interface driver hub
[    7.094523] usbcore: registered new device driver usb
[    7.154974] pps_core: LinuxPPS API ver. 1 registered
[    7.214363] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    7.323672] PTP clock support registered
[    7.370675] Registered efivars operations
[    7.419358] NetLabel: Initializing
[    7.460028] NetLabel:  domain hash size = 128
[    7.512133] NetLabel:  protocols = UNLABELED CIPSOv4
[    7.571547] NetLabel:  unlabeled traffic allowed by default
[    7.638361] clocksource: Switched to clocksource arch_sys_counter
[    7.728243] VFS: Disk quotas dquot_6.6.0
[    7.775223] VFS: Dquot-cache hash table entries: 8192 (order 0, 65536 bytes)
[    7.859807] pnp: PnP ACPI init
[    7.896705] pnp: PnP ACPI: found 0 devices
[    8.091440] NET: Registered protocol family 2
[    8.143915] TCP established hash table entries: 524288 (order: 6, 4194304 bytes)
[    8.233776] TCP bind hash table entries: 65536 (order: 4, 1048576 bytes)
[    8.314326] TCP: Hash tables configured (established 524288 bind 65536)
[    8.393534] UDP hash table entries: 32768 (order: 4, 1048576 bytes)
[    8.469053] UDP-Lite hash table entries: 32768 (order: 4, 1048576 bytes)
[    8.549917] NET: Registered protocol family 1
[    8.602063] PCI: CLS 64 bytes, default 128
[    8.602177] Unpacking initramfs...
[    9.396621] Freeing initrd memory: 35200K
[    9.444989] kvm [1]: 8-bit VMID
[    9.482540] kvm [1]: IDMAP page: 40008ce000
[    9.532565] kvm [1]: HYP VA range: 20000000000:3ffffffffff
[    9.598280] kvm [1]: Hyp mode initialized successfully
[    9.659763] kvm [1]: GICV region size/alignment is unsafe, using trapping (reduced performance)
[    9.763887] kvm [1]: vgic-v2@780cf000
[    9.807757] kvm [1]: vgic interrupt IRQ1
[    9.854665] kvm [1]: virtual timer IRQ4
[    9.916744] futex hash table entries: 2048 (order: 2, 262144 bytes)
[    9.991796] audit: initializing netlink subsys (disabled)
[   10.056453] audit: type=2000 audit(6.770:1): initialized
[   10.056630] Initialise system trusted keyrings
[   10.056778] workingset: timestamp_bits=37 max_order=20 bucket_order=0
[   10.059968] zbud: loaded
[   10.061498] SELinux:  Registering netfilter hooks
[   10.135674] alg: acomp: Compression test 1 failed for lzo-scomp: output len = 27
[   10.135777] alg: drbg: Test 0 failed for drbg_pr_ctr_aes128
[   10.139874] alg: drbg: Test 0 failed for drbg_nopr_ctr_aes128
[   10.139966] alg: drbg: Test 0 failed for drbg_nopr_ctr_aes192
[   10.140039] alg: drbg: Test 0 failed for drbg_nopr_ctr_aes256
[   10.141015] NET: Registered protocol family 38
[   10.141020] Key type asymmetric registered
[   10.141022] Asymmetric key parser 'x509' registered
[   10.141066] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
[   10.141127] io scheduler noop registered
[   10.141129] io scheduler deadline registered (default)
[   10.141158] io scheduler cfq registered
[   11.044288] xgene-gpio APMC0D14:00: X-Gene GPIO driver registered.
[   11.118317] pcieport 0000:00:00.0: can't derive routing for PCI INT A
[   11.195387] pcieport 0000:00:00.0: PCI INT A: no GSI
[   11.254927] pcie_pme: probe of 0000:00:00.0:pcie001 failed with error -22
[   11.336367] acpi ACPI0007:00: CPPC data invalid or not present
[   11.406182] acpi ACPI0007:01: CPPC data invalid or not present
[   11.475988] acpi ACPI0007:02: CPPC data invalid or not present
[   11.545790] acpi ACPI0007:03: CPPC data invalid or not present
[   11.615591] acpi ACPI0007:04: CPPC data invalid or not present
[   11.685386] acpi ACPI0007:05: CPPC data invalid or not present
[   11.755183] acpi ACPI0007:06: CPPC data invalid or not present
[   11.824979] acpi ACPI0007:07: CPPC data invalid or not present
[   11.895296] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[   11.985565] console [ttyS0] disabled
[   12.048458] APMC0D08:00: ttyS0 at MMIO 0x1c021000 (irq = 23, base_baud = 3125000) is a U6_16550A
[   12.153622] console [ttyS0] enabled
[   12.237185] bootconsole [uart8250] disabled
[   12.337600] msm_serial: driver initialized
[   12.387004] cacheinfo: Unable to detect cache hierarchy for CPU 0
[   12.460306] hisi_sas: driver version v1.6
[   12.508614] xgene-ahci APMC0D0D:00: skip clock and PHY initialization
[   12.585926] xgene-ahci APMC0D0D:00: controller can't do NCQ, turning off CAP_NCQ
[   12.674726] xgene-ahci APMC0D0D:00: AHCI 0001.0300 32 slots 2 ports 6 Gbps 0x3 impl platform mode
[   12.781242] xgene-ahci APMC0D0D:00: flags: 64bit sntf pm only pmp fbs pio slum part ccc 
[   12.878376] xgene-ahci APMC0D0D:00: port 0 is not capable of FBS
[   12.950530] xgene-ahci APMC0D0D:00: port 1 is not capable of FBS
[   13.023086] scsi host0: xgene-ahci
[   13.064107] scsi host1: xgene-ahci
[   13.104993] ata1: SATA max UDMA/133 mmio [mem 0x1a800000-0x1a800fff] port 0x100 irq 24
[   13.200036] ata2: SATA max UDMA/133 mmio [mem 0x1a800000-0x1a800fff] port 0x180 irq 24
[   13.295220] libphy: Fixed MDIO Bus: probed
[   13.344622] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   13.423035] ehci-pci: EHCI PCI platform driver
[   13.476382] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   13.550566] ohci-pci: OHCI PCI platform driver
[   13.603485] ata2: SATA link down (SStatus 0 SControl 4300)
[   13.669714] uhci_hcd: USB Universal Host Controller Interface driver
[   13.746061] usbcore: registered new interface driver usbserial
[   13.816074] usbcore: registered new interface driver usbserial_generic
[   13.894431] usbserial: USB Serial support registered for generic
[   13.918368] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 4300)
[   13.918575] ata1.00: ATA-9: XR0120GEBLT, HPS4, max UDMA/133
[   13.918577] ata1.00: 234441648 sectors, multi 16: LBA48 NCQ (depth 0/32)
[   13.918793] ata1.00: configured for UDMA/133
[   13.919075] scsi 0:0:0:0: Direct-Access     ATA      XR0120GEBLT      HPS4 PQ: 0 ANSI: 5
[   14.337526] mousedev: PS/2 mouse device common for all mice
[   14.337731] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   14.337813] sd 0:0:0:0: [sda] 234441648 512-byte logical blocks: (120 GB/112 GiB)
[   14.337816] sd 0:0:0:0: [sda] 4096-byte physical blocks
[   14.337844] sd 0:0:0:0: [sda] Write Protect is off
[   14.337847] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   14.337878] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   14.340377]  sda: sda1 sda2 sda3
[   14.340976] sd 0:0:0:0: [sda] Attached SCSI disk
[   14.882043] rtc-efi rtc-efi: rtc core: registered rtc-efi as rtc0
[   14.955405] device-mapper: uevent: version 1.0.3
[   15.010948] device-mapper: ioctl: 4.35.0-ioctl (2016-06-23) initialised: dm-devel@redhat.com
[   15.112879] EFI Variables Facility v0.08 2004-May-17
[   15.173571] hidraw: raw HID events driver (C) Jiri Kosina
[   15.238435] usbcore: registered new interface driver usbhid
[   15.305312] usbhid: USB HID core driver
[   15.351500] drop_monitor: Initializing network drop monitor service
[   15.426836] ip_tables: (C) 2000-2006 Netfilter Core Team
[   15.490607] Initializing XFRM netlink socket
[   15.542068] NET: Registered protocol family 10
[   15.595815] Segment Routing with IPv6
[   15.639769] mip6: Mobile IPv6
[   15.675345] NET: Registered protocol family 17
[   15.728962] registered taskstats version 1
[   15.778126] Loading compiled-in X.509 certificates
[   15.838950] alg: No test for pkcs1pad(rsa,sha256) (pkcs1pad(rsa-generic,sha256))
[   15.929166] Loaded X.509 cert 'Build time autogenerated kernel key: 1fab4053cdef4de1ccc5ce05e1cbfed5d5537af3'
[   16.048260] zswap: loaded using pool lzo/zbud
[   16.121521] Key type big_key registered
[   16.167696] rtc-efi rtc-efi: setting system clock to 2016-12-13 21:36:35 UTC (1481664995)
[   16.265895] PM: Hibernation image not present or could not be loaded.
[   16.266097] Freeing unused kernel memory: 1536K
[   16.326138] random: systemd: uninitialized urandom read (16 bytes read)
[   16.406164] random: systemd: uninitialized urandom read (16 bytes read)
[   16.487457] systemd[1]: systemd 219 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 -SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
[   16.703839] systemd[1]: Detected architecture arm64.
[   16.763425] systemd[1]: Running in initial RAM disk.
[   16.933524] systemd[1]: Set hostname to <localhost.localdomain>.
[   17.048780] random: systemd: uninitialized urandom read (16 bytes read)
[   17.128253] random: systemd: uninitialized urandom read (16 bytes read)
[   17.207713] random: systemd: uninitialized urandom read (16 bytes read)
[   17.287210] random: systemd: uninitialized urandom read (16 bytes read)
[   17.367813] random: systemd: uninitialized urandom read (16 bytes read)
[   17.447496] random: systemd: uninitialized urandom read (16 bytes read)
[   17.527253] random: systemd: uninitialized urandom read (16 bytes read)
[   17.607728] random: systemd: uninitialized urandom read (16 bytes read)
[   17.742418] systemd[1]: Created slice Root Slice.
[   17.798887] systemd[1]: Starting Root Slice.
[   17.906399] systemd[1]: Listening on udev Kernel Socket.
[   17.970171] systemd[1]: Starting udev Kernel Socket.
[   18.086397] systemd[1]: Listening on udev Control Socket.
[   18.151212] systemd[1]: Starting udev Control Socket.
[   19.673565] mlx4_core: Mellanox ConnectX core driver v2.2-1 (Feb, 2014)
[   19.789919] mlx4_core: Initializing 0000:01:00.0
[   26.231135] mlx4_core 0000:01:00.0: PCIe BW is different than device's capability
[   26.320967] mlx4_core 0000:01:00.0: PCIe link speed is 5.0GT/s, device supports 8.0GT/s
[   26.417049] mlx4_core 0000:01:00.0: PCIe link width is x8, device supports x8
[   26.564318] mlx4_en: Mellanox ConnectX HCA Ethernet driver v2.2-1 (Feb 2014)
[   26.649193] mlx4_en 0000:01:00.0: Activating port:1
[   26.711378] mlx4_en: 0000:01:00.0: Port 1: Using 64 TX rings
[   26.779299] mlx4_en: 0000:01:00.0: Port 1: Using 4 RX rings
[   26.846181] mlx4_en: 0000:01:00.0: Port 1:   frag:0 - size:1522 prefix:0 stride:1536
[   26.939499] mlx4_en: 0000:01:00.0: Port 1: Initializing port
[   27.007785] mlx4_en 0000:01:00.0: registered PHC clock
[   27.070877] mlx4_en 0000:01:00.0: Activating port:2
[   27.133993] mlx4_en: 0000:01:00.0: Port 2: Using 64 TX rings
[   27.201915] mlx4_en: 0000:01:00.0: Port 2: Using 4 RX rings
[   27.268798] mlx4_en: 0000:01:00.0: Port 2:   frag:0 - size:1522 prefix:0 stride:1536
[   27.362021] mlx4_en: 0000:01:00.0: Port 2: Initializing port
[   27.434754] mlx4_core 0000:01:00.0 eno1: renamed from eth0
[   27.512496] mlx4_core 0000:01:00.0 eno1d1: renamed from eth1
[   27.735069] random: fast init done
[   28.250283] SGI XFS with ACLs, security attributes, no debug enabled
[   28.329275] XFS (dm-0): Mounting V5 Filesystem
[   28.425520] XFS (dm-0): Ending clean mount
[   28.505469] mlx4_en: eno1d1: Link Up
[   28.798515] systemd-journald[278]: Received SIGTERM from PID 1 (systemd).
[   28.816777] systemd: 20 output lines suppressed due to ratelimiting
[   28.843206] audit: type=1404 audit(1481665008.174:2): enforcing=1 old_enforcing=0 auid=4294967295 ses=4294967295
[   29.275766] SELinux: 32768 avtab hash slots, 104865 rules.
[   29.311159] SELinux: 32768 avtab hash slots, 104865 rules.
[   29.396915] SELinux:  8 users, 14 roles, 4983 types, 301 bools, 1 sens, 1024 cats
[   29.396921] SELinux:  91 classes, 104865 rules
[   29.405995] SELinux:  Permission validate_trans in class security not defined in policy.
[   29.534735] SELinux:  Permission module_load in class system not defined in policy.
[   29.693475] SELinux:  Class binder not defined in policy.
[   29.824717] SELinux:  Class cap_userns not defined in policy.
[   29.960328] SELinux:  Class cap2_userns not defined in policy.
[   30.096987] SELinux:  Class sctp_socket not defined in policy.
[   30.233647] SELinux:  Class icmp_socket not defined in policy.
[   30.370305] SELinux:  Class ax25_socket not defined in policy.
[   30.506963] SELinux:  Class ipx_socket not defined in policy.
[   30.642581] SELinux:  Class netrom_socket not defined in policy.
[   30.781326] SELinux:  Class bridge_socket not defined in policy.
[   30.920071] SELinux:  Class atmpvc_socket not defined in policy.
[   31.058818] SELinux:  Class x25_socket not defined in policy.
[   31.194433] SELinux:  Class rose_socket not defined in policy.
[   31.331091] SELinux:  Class decnet_socket not defined in policy.
[   31.469842] SELinux:  Class atmsvc_socket not defined in policy.
[   31.608584] SELinux:  Class rds_socket not defined in policy.
[   31.744199] SELinux:  Class irda_socket not defined in policy.
[   31.880859] SELinux:  Class pppox_socket not defined in policy.
[   32.018561] SELinux:  Class llc_socket not defined in policy.
[   32.154176] SELinux:  Class ib_socket not defined in policy.
[   32.288749] SELinux:  Class mpls_socket not defined in policy.
[   32.425408] SELinux:  Class can_socket not defined in policy.
[   32.561024] SELinux:  Class tipc_socket not defined in policy.
[   32.697683] SELinux:  Class bluetooth_socket not defined in policy.
[   32.839559] SELinux:  Class iucv_socket not defined in policy.
[   32.976219] SELinux:  Class rxrpc_socket not defined in policy.
[   33.113920] SELinux:  Class isdn_socket not defined in policy.
[   33.250580] SELinux:  Class phonet_socket not defined in policy.
[   33.389325] SELinux:  Class ieee802154_socket not defined in policy.
[   33.532248] SELinux:  Class caif_socket not defined in policy.
[   33.656387] SELinux:  Class alg_socket not defined in policy.
[   33.725348] SELinux:  Class nfc_socket not defined in policy.
[   33.794301] SELinux:  Class vsock_socket not defined in policy.
[   33.865345] SELinux:  Class kcm_socket not defined in policy.
[   33.934298] SELinux:  Class qipcrtr_socket not defined in policy.
[   34.007429] SELinux: the above unknown classes and permissions will be allowed
[   34.094131] SELinux:  Completing initialization.
[   34.094132] SELinux:  Setting up existing superblocks.
[   34.115577] audit: type=1403 audit(1481665013.447:3): policy loaded auid=4294967295 ses=4294967295
[   34.119916] systemd[1]: Successfully loaded SELinux policy in 5.276847s.
[   34.223152] systemd[1]: RTC configured in localtime, applying delta of -300 minutes to system time.
[   34.274091] systemd[1]: Relabelled /dev and /run in 47.393ms.
[   34.696398] systemd-journald[579]: Received request to flush runtime journal from PID 1
[   34.824700] RPC: Registered named UNIX socket transport module.
[   34.954590] RPC: Registered udp transport module.
[   34.954592] RPC: Registered tcp transport module.
[   34.954593] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   35.206778] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   35.569775] input: Power Button as /devices/LNXSYSTM:00/PNP0C0C:00/input/input0
[   35.572132] xgene-slimpro-mbox APMC0D01:00: APM X-Gene SLIMpro MailBox registered
[   35.865673] ACPI: Power Button [PWRB]
[   35.985733] xgene-gpio-sb APMC0D15:00: Support 22 gpios, 6 irqs start from pin 8
[   36.132022] xgene-gpio-sb APMC0D15:00: X-Gene GPIO Standby driver registered
[   36.282950] xgene-rng APMC0D18:00: Couldn't get the clock for RNG
[   36.422797] xgene-slimpro-i2c APMC0D40:00: i2c mailbox channel request failed
[   36.591693] Adding 11722688k swap on /dev/mapper/rhel_hp--moonshot--02--c08-swap.  Priority:-1 extents:1 across:11722688k SSFS
[   36.787069] XFS (sda2): Mounting V5 Filesystem
[   36.868688] <mlx4_ib> mlx4_ib_add: mlx4_ib: Mellanox ConnectX InfiniBand driver v2.2-1 (Feb 2014)
[   36.869195] <mlx4_ib> mlx4_ib_add: counter index 2 for port 1 allocated 1
[   36.869196] <mlx4_ib> mlx4_ib_add: counter index 3 for port 2 allocated 1
[   37.308253] Rounding down aligned max_sectors from 4294967295 to 4294967168
[   37.350909] Loading iSCSI transport class v2.0-870.
[   37.392750] iscsi: registered transport (iser)
[   37.637247] RPC: Registered rdma transport module.
[   37.637249] RPC: Registered rdma backchannel transport module.
[   38.038304] XFS (dm-2): Mounting V5 Filesystem
[   38.079284] XFS (sda2): Ending clean mount
[   38.297433] XFS (dm-2): Ending clean mount
[   43.639471] IPv6: ADDRCONF(NETDEV_UP): eno1: link is not ready
[   43.710421] mlx4_en: eno1:   frag:0 - size:1522 prefix:0 stride:1536
[   43.838542] mlx4_en: eno1: Link Up
[   43.838572] IPv6: ADDRCONF(NETDEV_UP): eno1: link is not ready
[   43.908671] IPv6: ADDRCONF(NETDEV_CHANGE): eno1: link becomes ready
[   43.991371] IPv6: ADDRCONF(NETDEV_UP): eno1d1: link is not ready
[   44.064245] mlx4_en: eno1d1:   frag:0 - size:1522 prefix:0 stride:1536
[   90.846478] random: crng init done

--------------6BF4153A57A9BBE0BCB17F2D--
