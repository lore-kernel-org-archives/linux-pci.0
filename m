Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
To: Khuong Dinh <kdinh@apm.com>, lorenzo.pieralisi@arm.com,
 marc.zyngier@arm.com, msalter@redhat.com, bhelgaas@google.com,
 linux-pci@vger.kernel.org
References: <1493340847-25720-1-git-send-email-kdinh@apm.com>
 <55d52fce-be87-f055-e19b-4122015d5c94@redhat.com>
From: Jon Masters <jcm@jonmasters.org>
Message-ID: <3167d9b9-e8e5-d6bf-1b82-3d19f218bad6@jonmasters.org>
Date: Fri, 28 Apr 2017 12:36:48 -0400
MIME-Version: 1.0
In-Reply-To: <55d52fce-be87-f055-e19b-4122015d5c94@redhat.com>
Content-Type: multipart/mixed; boundary="------------602DED4F2879C21F927CAB2C"
Subject: Re: [PATCH v2 pci] PCI/MSI: pci-xgene-msi: Enable MSI support in ACPI
 boot for X-Gene v1
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: patches@apm.com, Duc Dang <dhdang@apm.com>, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, Jon Masters <jcm@redhat.com>,
 linux-arm-kernel@lists.infradead.org
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------602DED4F2879C21F927CAB2C
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

On 04/28/2017 01:11 AM, Jon Masters wrote:
> On 04/27/2017 08:54 PM, Khuong Dinh wrote:
>> From: Khuong Dinh <kdinh@apm.com>
>>
>> This patch makes pci-xgene-msi driver ACPI-aware and provides
>> MSI capability for X-Gene v1 PCIe controllers in ACPI boot mode.
>>
>> Signed-off-by: Khuong Dinh <kdinh@apm.com>
>> Signed-off-by: Duc Dang <dhdang@apm.com>
>> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Thanks. Currently testing. Will review and followup shortly.

Attaching boot logs before and after. I tested with an Intel e1000.
Before the patch I get fallback interrupts. Afterward, I get X-Gene MSI
interrupts working. Please followup with answers to Marc's question
about how you propose to guarantee boottime ordering of binding.

I urgently require that AppliedMicro complete upstreaming of this. It
should have been upstream a year ago. You're not the only ones with
patches like this left around - I'm coming for everyone else, too.

Tested-by: Jon Masters <jcm@jonmasters.org>


--------------602DED4F2879C21F927CAB2C
Content-Type: text/plain; charset=UTF-8;
 name="dmesg_4.11.0-rc8.xgene_msix1+_nomsi.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg_4.11.0-rc8.xgene_msix1+_nomsi.txt"

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.11.0-rc8.xgene_msix1+ (root@mustang4.bos.jonmasters.org) (gcc version 4.8.5 20150623 (Red Hat 4.8.5-14) (GCC) ) #1 SMP Fri Apr 28 04:44:20 EDT 2017
[    0.000000] Boot CPU: AArch64 Processor [500f0001]
[    0.000000] earlycon: uart8250 at MMIO32 0x000000001c020000 (options '')
[    0.000000] bootconsole [uart8250] enabled
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: EFI v2.40 by X-Gene Mustang Board EFI Aug 19 2016 18:02:24
[    0.000000] efi:  ACPI=0x43fa82d000  ACPI 2.0=0x43fa82d014  SMBIOS 3.0=0x43fa82b000  ESRT=0x43ff053d18 
[    0.000000] esrt: Reserving ESRT space from 0x00000043ff053d18 to 0x00000043ff053d78.
[    0.000000] cma: Reserved 512 MiB at 0x00000040e0000000
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000043FA82D014 000024 (v02 APM   )
[    0.000000] ACPI: XSDT 0x00000043FA82C0E8 000084 (v01 APM    XGENE    00000003      01000013)
[    0.000000] ACPI: FACP 0x00000043FA822000 00010C (v05 APM    XGENE    00000003 INTL 20140724)
[    0.000000] ACPI: DSDT 0x00000043FA823000 005837 (v05 APM    APM88xxx 00000001 INTL 20140724)
[    0.000000] ACPI: DBG2 0x00000043FA829000 0000AA (v00 APMC0D XGENEDBG 00000000 INTL 20140724)
[    0.000000] ACPI: GTDT 0x00000043FA820000 000060 (v02 APM    XGENE    00000001 INTL 20140724)
[    0.000000] ACPI: MCFG 0x00000043FA81F000 00003C (v01 APM    XGENE    00000002 INTL 20140724)
[    0.000000] ACPI: SPCR 0x00000043FA81E000 000050 (v02 APMC0D XGENESPC 00000000 INTL 20140724)
[    0.000000] ACPI: SSDT 0x00000043FA81D000 00002D (v02 APM    XGENE    00000001 INTL 20140724)
[    0.000000] ACPI: BERT 0x00000043FA81C000 000030 (v01 APM    XGENE    00000002 INTL 20140724)
[    0.000000] ACPI: HEST 0x00000043FA81B000 0002A8 (v01 APM    XGENE    00000002 INTL 20140724)
[    0.000000] ACPI: APIC 0x00000043FA81A000 0002A4 (v03 APM    XGENE    00000003      01000013)
[    0.000000] ACPI: SSDT 0x00000043FA819000 000063 (v02 REDHAT MACADDRS 00000001      01000013)
[    0.000000] ACPI: SSDT 0x00000043FA818000 000032 (v02 REDHAT UARTCLKS 00000001      01000013)
[    0.000000] ACPI: PCCT 0x00000043FA817000 000300 (v01 APM    XGENE    00000003      01000013)
[    0.000000] ACPI: SPCR: console: uart,mmio,0x1c020000,115200
[    0.000000] ACPI: NUMA: Failed to initialise from firmware
[    0.000000] NUMA: Faking a node at [mem 0x0000000000000000-0x00000043ffffffff]
[    0.000000] NUMA: Adding memblock [0x4000000000 - 0x40001fffff] on node 0
[    0.000000] NUMA: Adding memblock [0x4000200000 - 0x43fa7cffff] on node 0
[    0.000000] NUMA: Adding memblock [0x43fa7d0000 - 0x43faa1ffff] on node 0
[    0.000000] NUMA: Adding memblock [0x43faa20000 - 0x43ff9cffff] on node 0
[    0.000000] NUMA: Adding memblock [0x43ff9d0000 - 0x43ffa1ffff] on node 0
[    0.000000] NUMA: Adding memblock [0x43ffa20000 - 0x43ffffffff] on node 0
[    0.000000] NUMA: Initmem setup node 0 [mem 0x4000000000-0x43ffffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x43ffffe200-0x43ffffffff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000004000000000-0x00000040ffffffff]
[    0.000000]   Normal   [mem 0x0000004100000000-0x00000043ffffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000004000000000-0x00000040001fffff]
[    0.000000]   node   0: [mem 0x0000004000200000-0x00000043fa7cffff]
[    0.000000]   node   0: [mem 0x00000043fa7d0000-0x00000043faa1ffff]
[    0.000000]   node   0: [mem 0x00000043faa20000-0x00000043ff9cffff]
[    0.000000]   node   0: [mem 0x00000043ff9d0000-0x00000043ffa1ffff]
[    0.000000]   node   0: [mem 0x00000043ffa20000-0x00000043ffffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000004000000000-0x00000043ffffffff]
[    0.000000] On node 0 totalpages: 262144
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 65536 pages, LIFO batch:1
[    0.000000]   Normal zone: 192 pages used for memmap
[    0.000000]   Normal zone: 196608 pages, LIFO batch:1
[    0.000000] psci: is not implemented in ACPI.
[    0.000000] percpu: Embedded 3 pages/cpu @ffff8003ffdf0000 s124312 r8192 d64104 u196608
[    0.000000] pcpu-alloc: s124312 r8192 d64104 u196608 alloc=3*65536
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6 [0] 7 
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 261888
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.11.0-rc8.xgene_msix1+ root=/dev/mapper/rhelp_dhcp--171-root ro crashkernel=auto rd.lvm.lv=rhelp_dhcp-171/root rd.lvm.lv=rhelp_dhcp-171/swap LANG=en_US.UTF-8 acpi=force earlycon=uart8250,mmio32,0x1c020000 console=ttyS0,115200
[    0.000000] PID hash table entries: 4096 (order: -1, 32768 bytes)
[    0.000000] software IO TLB [mem 0x40dbff0000-0x40dfff0000] (64MB) mapped at [ffff8000dbff0000-ffff8000dffeffff]
[    0.000000] Memory: 16109888K/16777216K available (7420K kernel code, 1354K rwdata, 3200K rodata, 1216K init, 7286K bss, 143040K reserved, 524288K cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     modules : 0xffff000000000000 - 0xffff000008000000   (   128 MB)
[    0.000000]     vmalloc : 0xffff000008000000 - 0xffff7bdfffff0000   (126847 GB)
[    0.000000]       .text : 0xffff000008080000 - 0xffff0000087c0000   (  7424 KB)
[    0.000000]     .rodata : 0xffff0000087c0000 - 0xffff000008af0000   (  3264 KB)
[    0.000000]       .init : 0xffff000008af0000 - 0xffff000008c20000   (  1216 KB)
[    0.000000]       .data : 0xffff000008c20000 - 0xffff000008d72a00   (  1355 KB)
[    0.000000]        .bss : 0xffff000008d72a00 - 0xffff0000094902d4   (  7287 KB)
[    0.000000]     fixed   : 0xffff7fdffe7d0000 - 0xffff7fdffec00000   (  4288 KB)
[    0.000000]     PCI I/O : 0xffff7fdffee00000 - 0xffff7fdfffe00000   (    16 MB)
[    0.000000]     vmemmap : 0xffff7fe000000000 - 0xffff800000000000   (   128 GB maximum)
[    0.000000]               0xffff7fe000000000 - 0xffff7fe001000000   (    16 MB actual)
[    0.000000]     memory  : 0xffff800000000000 - 0xffff800400000000   ( 16384 MB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=4096 to nr_cpu_ids=8.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=8
[    0.000000] NR_IRQS:64 nr_irqs:64 0
[    0.000000] GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: No distributor detected at @ffff000008050000, giving up
[    0.000000] arm_arch_timer: Architected cp15 timer(s) running at 50.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0xb8812736b, max_idle_ns: 440795202655 ns
[    0.000002] sched_clock: 56 bits at 50MHz, resolution 20ns, wraps every 4398046511100ns
[    0.008382] Console: colour dummy device 80x25
[    0.013031] Calibrating delay loop (skipped), value calculated using timer frequency.. 100.00 BogoMIPS (lpj=500000)
[    0.023774] pid_max: default: 32768 minimum: 301
[    0.028553] ACPI: Core revision 20170119
[    0.036208] ACPI Error: Method parse/execution failed [\_SB.ET00._STA] (Node ffff8003c0195c08), AE_CTRL_PARSE_CONTINUE (20170119/psparse-543)
[    0.049249] ACPI Error: Invalid zero thread count in method (20170119/dsmethod-790)
[    0.057204] ACPI Error: Invalid OwnerId: 0x00 (20170119/utownerid-186)
[    0.063972] ACPI Error: Method parse/execution failed [\_SB.ET01._STA] (Node ffff8003c0195eb0), AE_CTRL_PARSE_CONTINUE (20170119/psparse-543)
[    0.077125] ACPI Error: Invalid zero thread count in method (20170119/dsmethod-790)
[    0.084966] ACPI Error: Invalid OwnerId: 0x00 (20170119/utownerid-186)
[    0.092086] ACPI: 4 ACPI AML tables successfully acquired and loaded
[    0.098656] Security Framework initialized
[    0.102953] SELinux:  Initializing.
[    0.106548] SELinux:  Starting in permissive mode
[    0.106747] Dentry cache hash table entries: 2097152 (order: 8, 16777216 bytes)
[    0.116984] Inode-cache hash table entries: 1048576 (order: 7, 8388608 bytes)
[    0.125658] Mount-cache hash table entries: 32768 (order: 2, 262144 bytes)
[    0.132758] Mountpoint-cache hash table entries: 32768 (order: 2, 262144 bytes)
[    0.140711] ftrace: allocating 26814 entries in 7 pages
[    0.205140] ASID allocator initialised with 65536 entries
[    0.211274] Remapping and enabling EFI services.
[    0.216029]   EFI remap 0x0000000010510000 => 0000000020000000
[    0.222058]   EFI remap 0x0000000010548000 => 0000000020018000
[    0.228081]   EFI remap 0x0000000017000000 => 0000000020020000
[    0.234066]   EFI remap 0x000000001c025000 => 0000000020035000
[    0.240084] UEFI Runtime regions are not aligned to 64 KB -- buggy firmware?
[    0.240089] ------------[ cut here ]------------
[    0.252134] WARNING: CPU: 0 PID: 1 at arch/arm64/kernel/efi.c:34 efi_create_mapping+0x4c/0x104
[    0.261010] Modules linked in:

[    0.265699] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.11.0-rc8.xgene_msix1+ #1
[    0.273313] Hardware name: APM X-Gene Mustang board (DT)
[    0.278750] task: ffff8003c1bc0000 task.stack: ffff8003c1c00000
[    0.284827] PC is at efi_create_mapping+0x4c/0x104
[    0.289772] LR is at efi_create_mapping+0x4c/0x104
[    0.294664] pc : [<ffff000008af51f0>] lr : [<ffff000008af51f0>] pstate: 60000045
[    0.302261] sp : ffff8003c1c03d20
[    0.305710] x29: ffff8003c1c03d20 x28: 0000000000000000 
[    0.311183] x27: ffff000008c53000 x26: ffff000008d429c8 
[    0.316639] x25: ffff000008d42000 x24: 0000000000000000 
[    0.322102] x23: ffff000008a4c8f0 x22: ffff000008c60000 
[    0.327600] x21: ffff000008c53000 x20: ffff000008d429c8 
[    0.333038] x19: ffff8003f96ab348 x18: 000000003eca74e7 
[    0.338485] x17: 0000000000000000 x16: 0000000000000000 
[    0.343992] x15: ffff000008c53000 x14: 000000004e2b17ac 
[    0.349464] x13: ffff0000089ca500 x12: 0000000000040b00 
[    0.354988] x11: ffff8003c1c039e0 x10: ffff8003c1c039e0 
[    0.360435] x9 : 0000000000000073 x8 : 6620796767756220 
[    0.365898] x7 : 2d2d20424b203436 x6 : ffff000009274718 
[    0.371362] x5 : ffff8003ffdf7530 x4 : 0000000000000000 
[    0.376834] x3 : 0000000000000000 x2 : 0000000000040b00 
[    0.382316] x1 : 0000000000040b00 x0 : 0000000000000040 

[    0.389363] ---[ end trace 4a6935def63e1e16 ]---
[    0.394126] Call trace:
[    0.396626] Exception stack(0xffff8003c1c03b30 to 0xffff8003c1c03c60)
[    0.403246] 3b20:                                   ffff8003f96ab348 0001000000000000
[    0.411302] 3b40: ffff8003c1c03d20 ffff000008af51f0 0000000060000045 ffff000008d429c8
[    0.419331] 3b60: 0000000000000000 0000000000000000 ffff8003c1c03d20 ffff8003c1c03d20
[    0.427377] 3b80: ffff8003c1c03ce0 00000000ffffffc8 ffff8003c1c03be0 ffff00000812f6b8
[    0.435449] 3ba0: ffff000008c53000 00000000ffffffc8 ffff8003c1c03c00 ffff0000089be038
[    0.443487] 3bc0: ffff8003c1c03d20 ffff8003c1c03d20 ffff8003c1c03ce0 00000000ffffffc8
[    0.451585] 3be0: ffff8003c1c03c70 0000000000040b00 0000000000000040 0000000000040b00
[    0.459666] 3c00: 0000000000040b00 0000000000000000 0000000000000000 ffff8003ffdf7530
[    0.467729] 3c20: ffff000009274718 2d2d20424b203436 6620796767756220 0000000000000073
[    0.475784] 3c40: ffff8003c1c039e0 ffff8003c1c039e0 0000000000040b00 ffff0000089ca500
[    0.483840] [<ffff000008af51f0>] efi_create_mapping+0x4c/0x104
[    0.489858] [<ffff000008b3db98>] arm_enable_runtime_services+0x154/0x238
[    0.496817] [<ffff000008083698>] do_one_initcall+0x54/0x15c
[    0.502634] [<ffff000008af0d18>] kernel_init_freeable+0xe4/0x25c
[    0.508816] [<ffff0000087ae430>] kernel_init+0x18/0x108
[    0.514202] [<ffff0000080833c0>] ret_from_fork+0x10/0x50
[    0.519621]   EFI remap 0x00000043fa7df000 => 000000002004f000
[    0.525659]   EFI remap 0x00000043fa82e000 => 000000002006e000
[    0.531673]   EFI remap 0x00000043ff9d6000 => 0000000020266000
[    0.537700]   EFI remap 0x00000043ff9ea000 => 000000002027a000
[    0.543899] smp: Bringing up secondary CPUs ...
[    0.548738] Detected PIPT I-cache on CPU1
[    0.548766] CPU1: Booted secondary processor [500f0001]
[    0.548987] Detected PIPT I-cache on CPU2
[    0.549008] CPU2: Booted secondary processor [500f0001]
[    0.549225] Detected PIPT I-cache on CPU3
[    0.549239] CPU3: Booted secondary processor [500f0001]
[    0.549432] Detected PIPT I-cache on CPU4
[    0.549452] CPU4: Booted secondary processor [500f0001]
[    0.549653] Detected PIPT I-cache on CPU5
[    0.549667] CPU5: Booted secondary processor [500f0001]
[    0.549861] Detected PIPT I-cache on CPU6
[    0.549882] CPU6: Booted secondary processor [500f0001]
[    0.550086] Detected PIPT I-cache on CPU7
[    0.550100] CPU7: Booted secondary processor [500f0001]
[    0.550142] smp: Brought up 1 node, 8 CPUs
[    0.621892] SMP: Total of 8 processors activated.
[    0.626806] CPU features: detected feature: 32-bit EL0 Support
[    0.632944] CPU: All CPU(s) started at EL2
[    0.637984] devtmpfs: initialized
[    0.641749] SMBIOS 3.0.0 present.
[    0.645224] DMI: AppliedMicro X-Gene Mustang Board/X-Gene Mustang Board, BIOS 3.06.15 Aug 19 2016
[    0.654642] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.664967] futex hash table entries: 2048 (order: 2, 262144 bytes)
[    0.671981] pinctrl core: initialized pinctrl subsystem
[    0.677705] NET: Registered protocol family 16
[    0.682714] cpuidle: using governor menu
[    0.686960] Detected 8 PCC Subspaces
[    0.690784] Registering PCC driver as Mailbox controller
[    0.696410] vdso: 2 pages (1 code @ ffff0000087e0000, 1 data @ ffff000008c40000)
[    0.704152] hw-breakpoint: found 4 breakpoint and 4 watchpoint registers.
[    0.713765] DMA: preallocated 256 KiB pool for atomic allocations
[    0.720154] ACPI: bus type PCI registered
[    0.724382] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.731202] Serial: AMBA PL011 UART driver
[    0.737465] HugeTLB registered 512 MB page size, pre-allocated 0 pages
[    0.744898] ACPI: Added _OSI(Module Device)
[    0.749274] ACPI: Added _OSI(Processor Device)
[    0.753882] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.758804] ACPI: Added _OSI(Processor Aggregator Device)
[    0.773904] ACPI: Interpreter enabled
[    0.777753] ACPI: Using GIC for interrupt routing
[    0.782685] ACPI: MCFG table detected, 1 entries
[    0.787684] HEST: Table parsing has been initialized.
[    0.795411] ACPI: Power Resource [SCVR] (on)
[    0.830232] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.836749] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.845539] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
[    0.853915] acpi PNP0A08:00: MCFG quirk: ECAM at [mem 0xe0d0000000-0xe0dfffffff] for [bus 00-ff] with xgene_v1_pcie_ecam_ops
[    0.866664] acpi PNP0A08:00: [Firmware Bug]: ECAM area [mem 0xe0d0000000-0xe0dfffffff] not reserved in ACPI namespace
[    0.877881] acpi PNP0A08:00: ECAM at [mem 0xe0d0000000-0xe0dfffffff] for [bus 00-ff]
[    0.886116] Remapped I/O 0x000000e010000000 to [io  0x0000-0xffff window]
[    0.893327] PCI host bridge to bus 0000:00
[    0.897628] pci_bus 0000:00: root bus resource [io  0x0000-0xffff window] (bus address [0x10000000-0x1000ffff])
[    0.908283] pci_bus 0000:00: root bus resource [mem 0xe040000000-0xe07fffffff window] (bus address [0x40000000-0x7fffffff])
[    0.919920] pci_bus 0000:00: root bus resource [mem 0xf000000000-0xffffffffff window]
[    0.928114] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.933821] pci 0000:00:00.0: [10e8:e004] type 01 class 0x060400
[    0.933899] pci 0000:00:00.0: supports D1 D2
[    0.934059] pci 0000:01:00.0: [8086:10d3] type 00 class 0x020000
[    0.934092] pci 0000:01:00.0: reg 0x10: [mem 0xe040080000-0xe04009ffff]
[    0.934108] pci 0000:01:00.0: reg 0x14: [mem 0xe040000000-0xe04007ffff]
[    0.934125] pci 0000:01:00.0: reg 0x18: [io  0x0000-0x001f]
[    0.934141] pci 0000:01:00.0: reg 0x1c: [mem 0xe0400a0000-0xe0400a3fff]
[    0.934186] pci 0000:01:00.0: reg 0x30: [mem 0xfffc0000-0xffffffff pref]
[    0.934326] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    0.963877] pci 0000:00:00.0: BAR 14: assigned [mem 0xe040000000-0xe0400fffff]
[    0.971433] pci 0000:00:00.0: BAR 13: assigned [io  0x1000-0x1fff]
[    0.977908] pci 0000:01:00.0: BAR 1: assigned [mem 0xe040000000-0xe04007ffff]
[    0.985417] pci 0000:01:00.0: BAR 6: assigned [mem 0xe040080000-0xe0400bffff pref]
[    0.993304] pci 0000:01:00.0: BAR 0: assigned [mem 0xe0400c0000-0xe0400dffff]
[    1.000812] pci 0000:01:00.0: BAR 3: assigned [mem 0xe0400e0000-0xe0400e3fff]
[    1.008298] pci 0000:01:00.0: BAR 2: assigned [io  0x1000-0x101f]
[    1.014701] pci 0000:00:00.0: PCI bridge to [bus 01]
[    1.019893] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
[    1.026276] pci 0000:00:00.0:   bridge window [mem 0xe040000000-0xe0400fffff]
[    1.034419] vgaarb: loaded
[    1.037393] SCSI subsystem initialized
[    1.041366] libata version 3.00 loaded.
[    1.041403] ACPI: bus type USB registered
[    1.045616] usbcore: registered new interface driver usbfs
[    1.051373] usbcore: registered new interface driver hub
[    1.056947] usbcore: registered new device driver usb
[    1.062355] Registered efivars operations
[    1.066820] NetLabel: Initializing
[    1.070418] NetLabel:  domain hash size = 128
[    1.074997] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    1.080980] NetLabel:  unlabeled traffic allowed by default
[    1.086945] clocksource: Switched to clocksource arch_sys_counter
[    1.111811] VFS: Disk quotas dquot_6.6.0
[    1.115980] VFS: Dquot-cache hash table entries: 8192 (order 0, 65536 bytes)
[    1.123569] pnp: PnP ACPI init
[    1.127405] pnp: PnP ACPI: found 0 devices
[    1.134249] NET: Registered protocol family 2
[    1.139069] TCP established hash table entries: 131072 (order: 4, 1048576 bytes)
[    1.147156] TCP bind hash table entries: 65536 (order: 4, 1048576 bytes)
[    1.154513] TCP: Hash tables configured (established 131072 bind 65536)
[    1.161541] UDP hash table entries: 8192 (order: 2, 262144 bytes)
[    1.168029] UDP-Lite hash table entries: 8192 (order: 2, 262144 bytes)
[    1.175030] NET: Registered protocol family 1
[    1.179607] PCI: CLS 64 bytes, default 128
[    1.179708] Unpacking initramfs...
[    1.863109] Freeing initrd memory: 32640K
[    1.867699] kvm [1]: 8-bit VMID
[    1.870944] kvm [1]: IDMAP page: 40009b7000
[    1.875301] kvm [1]: HYP VA range: 800000000000:ffffffffffff
[    1.881276] kvm [1]: Hyp mode initialized successfully
[    1.886624] kvm [1]: GICV region size/alignment is unsafe, using trapping (reduced performance)
[    1.895748] kvm [1]: vgic-v2@780cf000
[    1.899646] kvm [1]: vgic interrupt IRQ1
[    1.903757] kvm [1]: virtual timer IRQ4
[    1.923421] audit: initializing netlink subsys (disabled)
[    1.929159] audit: type=2000 audit(1.470:1): state=initialized audit_enabled=0 res=1
[    1.929303] Initialise system trusted keyrings
[    1.929373] workingset: timestamp_bits=44 max_order=18 bucket_order=0
[    1.931445] zbud: loaded
[    1.931829] SELinux:  Registering netfilter hooks
[    2.011199] NET: Registered protocol family 38
[    2.015847] Key type asymmetric registered
[    2.020145] Asymmetric key parser 'x509' registered
[    2.025283] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    2.033081] io scheduler noop registered
[    2.037167] io scheduler deadline registered (default)
[    2.042536] io scheduler cfq registered
[    2.046565] io scheduler mq-deadline registered
[    2.051474] atomic64_test: passed
[    2.055189] xgene-gpio APMC0D14:00: X-Gene GPIO driver registered.
[    2.062003] pcieport 0000:00:00.0: AER enabled with IRQ 83
[    2.067787] pcieport 0000:00:00.0: Signaling PME with IRQ 83
[    2.073972] input: Power Button as /devices/LNXSYSTM:00/PNP0C0C:00/input/input0
[    2.081619] ACPI: Power Button [PWRB]
[    2.085922] GHES: Failed to map GSI to IRQ for generic hardware error source: 2
[    2.093593] GHES: probe of GHES.2 failed with error 82
[    2.098936] GHES: Failed to map GSI to IRQ for generic hardware error source: 3
[    2.106588] GHES: probe of GHES.3 failed with error 82
[    2.111936] GHES: Failed to map GSI to IRQ for generic hardware error source: 4
[    2.119608] GHES: probe of GHES.4 failed with error 82
[    2.125011] GHES: Failed to map GSI to IRQ for generic hardware error source: 5
[    2.132659] GHES: probe of GHES.5 failed with error 82
[    2.138017] GHES: Failed to map GSI to IRQ for generic hardware error source: 6
[    2.145633] GHES: probe of GHES.6 failed with error 82
[    2.151042] GHES: Failed to map GSI to IRQ for generic hardware error source: 7
[    2.158724] GHES: probe of GHES.7 failed with error 82
[    2.164126] GHES: Failed to map GSI to IRQ for generic hardware error source: 8
[    2.171797] GHES: probe of GHES.8 failed with error 82
[    2.177160] GHES: Failed to map GSI to IRQ for generic hardware error source: 9
[    2.184845] GHES: probe of GHES.9 failed with error 82
[    2.190233] GHES: Failed to enable APEI firmware first mode.
[    2.196297] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    2.203376] console [ttyS0] disabled
[    2.227246] APMC0D08:00: ttyS0 at MMIO 0x1c020000 (irq = 22, base_baud = 3125000) is a U6_16550A
[    2.236527] console [ttyS0] enabled
[    2.243657] bootconsole [uart8250] disabled
[    2.272506] APMC0D08:01: ttyS1 at MMIO 0x1c021000 (irq = 23, base_baud = 3125000) is a U6_16550A
[    2.281671] cacheinfo: Unable to detect cache hierarchy for CPU 0
[    2.287755] rdac: device handler registered
[    2.291963] hp_sw: device handler registered
[    2.296209] emc: device handler registered
[    2.300380] alua: device handler registered
[    2.304688] libphy: Fixed MDIO Bus: probed
[    2.308849] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.315346] ehci-pci: EHCI PCI platform driver
[    2.319790] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.325941] ohci-pci: OHCI PCI platform driver
[    2.330377] uhci_hcd: USB Universal Host Controller Interface driver
[    2.336788] xhci-hcd 808622B7:00: xHCI Host Controller
[    2.341980] xhci-hcd 808622B7:00: new USB bus registered, assigned bus number 1
[    2.349425] xhci-hcd 808622B7:00: hcc params 0x0220f06d hci version 0x100 quirks 0x00010010
[    2.357756] xhci-hcd 808622B7:00: irq 29, io mem 0x19000000
[    2.363370] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    2.370130] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.377318] usb usb1: Product: xHCI Host Controller
[    2.382169] usb usb1: Manufacturer: Linux 4.11.0-rc8.xgene_msix1+ xhci-hcd
[    2.389010] usb usb1: SerialNumber: 808622B7:00
[    2.393727] hub 1-0:1.0: USB hub found
[    2.397479] hub 1-0:1.0: 1 port detected
[    2.401480] xhci-hcd 808622B7:00: xHCI Host Controller
[    2.406677] xhci-hcd 808622B7:00: new USB bus registered, assigned bus number 2
[    2.413986] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    2.422078] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[    2.428836] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.436020] usb usb2: Product: xHCI Host Controller
[    2.440875] usb usb2: Manufacturer: Linux 4.11.0-rc8.xgene_msix1+ xhci-hcd
[    2.447720] usb usb2: SerialNumber: 808622B7:00
[    2.452398] hub 2-0:1.0: USB hub found
[    2.456137] hub 2-0:1.0: 1 port detected
[    2.460168] xhci-hcd 808622B7:01: xHCI Host Controller
[    2.465356] xhci-hcd 808622B7:01: new USB bus registered, assigned bus number 3
[    2.472759] xhci-hcd 808622B7:01: hcc params 0x0220f06d hci version 0x100 quirks 0x00010010
[    2.481087] xhci-hcd 808622B7:01: irq 30, io mem 0x19800000
[    2.486684] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[    2.493443] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.500630] usb usb3: Product: xHCI Host Controller
[    2.505482] usb usb3: Manufacturer: Linux 4.11.0-rc8.xgene_msix1+ xhci-hcd
[    2.512327] usb usb3: SerialNumber: 808622B7:01
[    2.517049] hub 3-0:1.0: USB hub found
[    2.520789] hub 3-0:1.0: 1 port detected
[    2.524790] xhci-hcd 808622B7:01: xHCI Host Controller
[    2.529976] xhci-hcd 808622B7:01: new USB bus registered, assigned bus number 4
[    2.537284] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    2.545370] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003
[    2.552128] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.559317] usb usb4: Product: xHCI Host Controller
[    2.564168] usb usb4: Manufacturer: Linux 4.11.0-rc8.xgene_msix1+ xhci-hcd
[    2.571013] usb usb4: SerialNumber: 808622B7:01
[    2.575716] hub 4-0:1.0: USB hub found
[    2.579464] hub 4-0:1.0: 1 port detected
[    2.583505] usbcore: registered new interface driver usbserial
[    2.589324] usbcore: registered new interface driver usbserial_generic
[    2.595826] usbserial: USB Serial support registered for generic
[    2.601884] mousedev: PS/2 mouse device common for all mice
[    2.607620] rtc-efi rtc-efi: rtc core: registered rtc-efi as rtc0
[    2.613906] EFI Variables Facility v0.08 2004-May-17
[    2.619081] hidraw: raw HID events driver (C) Jiri Kosina
[    2.624514] usbcore: registered new interface driver usbhid
[    2.630067] usbhid: USB HID core driver
[    2.633953] drop_monitor: Initializing network drop monitor service
[    2.640280] Initializing XFRM netlink socket
[    2.644691] NET: Registered protocol family 10
[    2.649496] Segment Routing with IPv6
[    2.653160] NET: Registered protocol family 17
[    2.657841] registered taskstats version 1
[    2.661921] Loading compiled-in X.509 certificates
[    2.669794] alg: No test for pkcs1pad(rsa,sha1) (pkcs1pad(rsa-generic,sha1))
[    2.678237] Loaded X.509 cert 'Build time autogenerated kernel key: 98aa1b1964f4052ba920878b6f8348e178459895'
[    2.688204] zswap: loaded using pool lzo/zbud
[    2.713270] Key type big_key registered
[    2.717168] BERT: [Firmware Bug]: table invalid.
[    2.721839] rtc-efi rtc-efi: setting system clock to 2017-04-28 16:00:41 UTC (1493395241)
[    2.757884] Freeing unused kernel memory: 1216K
[    2.767418] random: systemd: uninitialized urandom read (16 bytes read)
[    2.774589] random: systemd: uninitialized urandom read (16 bytes read)
[    2.781211] random: systemd: uninitialized urandom read (16 bytes read)
[    2.789666] systemd[1]: systemd 219 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 -SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
[    2.807890] systemd[1]: Detected architecture arm64.
[    2.812833] systemd[1]: Running in initial RAM disk.
[    2.847031] systemd[1]: Set hostname to <localhost.localdomain>.
[    2.979499] random: systemd: uninitialized urandom read (16 bytes read)
[    2.986233] random: systemd: uninitialized urandom read (16 bytes read)
[    2.993080] random: systemd: uninitialized urandom read (16 bytes read)
[    3.000078] random: systemd: uninitialized urandom read (16 bytes read)
[    3.010094] random: systemd: uninitialized urandom read (16 bytes read)
[    3.017557] random: systemd: uninitialized urandom read (16 bytes read)
[    3.025329] random: systemd: uninitialized urandom read (16 bytes read)
[    3.087174] systemd[1]: Reached target Swap.
[    3.091495] systemd[1]: Starting Swap.
[    3.117069] systemd[1]: Reached target Timers.
[    3.121551] systemd[1]: Starting Timers.
[    3.157062] systemd[1]: Reached target Local File Systems.
[    3.162579] systemd[1]: Starting Local File Systems.
[    4.087490] device-mapper: uevent: version 1.0.3
[    4.092424] device-mapper: ioctl: 4.35.0-ioctl (2016-06-23) initialised: dm-devel@redhat.com
[    4.400761] libphy: APM X-Gene MDIO bus: probed
[    4.444412] pps_core: LinuxPPS API ver. 1 registered
[    4.449417] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    4.450547] xgene-ahci APMC0D0D:00: skip clock and PHY initialization
[    4.450561] xgene-ahci APMC0D0D:00: controller can't do NCQ, turning off CAP_NCQ
[    4.450629] xgene-ahci APMC0D0D:00: AHCI 0001.0300 32 slots 2 ports 6 Gbps 0x3 impl platform mode
[    4.450643] xgene-ahci APMC0D0D:00: flags: 64bit sntf pm only pmp fbs pio slum part ccc 
[    4.450670] xgene-ahci APMC0D0D:00: port 0 is not capable of FBS
[    4.491029] sdhci: Secure Digital Host Controller Interface driver
[    4.491033] sdhci: Copyright(c) Pierre Ossman
[    4.512024] PTP clock support registered
[    4.512754] xgene-ahci APMC0D0D:00: port 1 is not capable of FBS
[    4.525820] scsi host0: xgene-ahci
[    4.529855] scsi host1: xgene-ahci
[    4.533507] ata1: SATA max UDMA/133 mmio [mem 0x1a400000-0x1a400fff] port 0x100 irq 27
[    4.534007] mmc0: SDHCI controller on ACPI [APMC0D0C:00] using PIO
[    4.547673] ata2: SATA max UDMA/133 mmio [mem 0x1a400000-0x1a400fff] port 0x180 irq 27
[    4.548138] xgene-enet APMC0D05:00: clocks have been setup already
[    4.553893] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    4.553894] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    4.554194] e1000e 0000:01:00.0: enabling device (0000 -> 0002)
[    4.554351] e1000e 0000:01:00.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    4.554379] e1000e 0000:01:00.0 0000:01:00.0 (uninitialized): Failed to initialize MSI-X interrupts.  Falling back to MSI interrupts.
[    4.554394] e1000e 0000:01:00.0 0000:01:00.0 (uninitialized): Failed to initialize MSI interrupts.  Falling back to legacy interrupts.
[    4.617549] e1000e 0000:01:00.0 0000:01:00.0 (uninitialized): registered PHC clock
[    4.647217] xgene-enet APMC0D30:00: clocks have been setup already
[    4.665238] xgene-ahci APMC0D0D:01: skip clock and PHY initialization
[    4.671721] xgene-ahci APMC0D0D:01: controller can't do NCQ, turning off CAP_NCQ
[    4.679178] xgene-ahci APMC0D0D:01: AHCI 0001.0300 32 slots 2 ports 6 Gbps 0x3 impl platform mode
[    4.688066] xgene-ahci APMC0D0D:01: flags: 64bit sntf pm only pmp fbs pio slum part ccc 
[    4.693143] e1000e 0000:01:00.0 eth2: (PCI Express:2.5GT/s:Width x1) 68:05:ca:46:ce:08
[    4.693146] e1000e 0000:01:00.0 eth2: Intel(R) PRO/1000 Network Connection
[    4.693162] e1000e 0000:01:00.0 eth2: MAC: 3, PHY: 8, PBA No: E46981-008
[    4.696649] e1000e 0000:01:00.0 enp1s0: renamed from eth2
[    4.722971] xgene-ahci APMC0D0D:01: port 0 is not capable of FBS
[    4.729089] xgene-ahci APMC0D0D:01: port 1 is not capable of FBS
[    4.736197] scsi host2: xgene-ahci
[    4.740144] scsi host3: xgene-ahci
[    4.743793] ata3: SATA max UDMA/133 mmio [mem 0x1a800000-0x1a800fff] port 0x100 irq 28
[    4.751735] ata4: SATA max UDMA/133 mmio [mem 0x1a800000-0x1a800fff] port 0x180 irq 28
[    4.857119] xgene-enet APMC0D30:01: clocks have been setup already
[    4.874076] xgene-enet APMC0D31:00: clocks have been setup already
[    5.088466] ata3: SATA link down (SStatus 0 SControl 4300)
[    5.099014] ata4: SATA link down (SStatus 0 SControl 4300)
[    5.217012] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 4300)
[    5.223552] ata1.00: ATA-8: Corsair Neutron GTX SSD, M311, max UDMA/133
[    5.230179] ata1.00: 234441648 sectors, multi 1: LBA48 NCQ (depth 0/32)
[    5.236797] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 4300)
[    5.243335] ata2.00: ATA-8: Corsair Neutron GTX SSD, M311, max UDMA/133
[    5.249961] ata2.00: 234441648 sectors, multi 1: LBA48 NCQ (depth 0/32)
[    5.256600] ata1.00: configured for UDMA/133
[    5.261153] ata2.00: configured for UDMA/133
[    5.261162] scsi 0:0:0:0: Direct-Access     ATA      Corsair Neutron  M311 PQ: 0 ANSI: 5
[    5.357513] scsi 1:0:0:0: Direct-Access     ATA      Corsair Neutron  M311 PQ: 0 ANSI: 5
[    5.357514] sd 0:0:0:0: [sda] 234441648 512-byte logical blocks: (120 GB/112 GiB)
[    5.357539] sd 0:0:0:0: [sda] Write Protect is off
[    5.357542] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    5.357575] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.360081]  sda: sda1 sda2 sda3
[    5.360645] sd 0:0:0:0: [sda] Attached SCSI disk
[    5.487441] sd 1:0:0:0: [sdb] 234441648 512-byte logical blocks: (120 GB/112 GiB)
[    5.494939] sd 1:0:0:0: [sdb] Write Protect is off
[    5.499723] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    5.499757] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.511144]  sdb: sdb1
[    5.513907] sd 1:0:0:0: [sdb] Attached SCSI disk
[    5.962036] random: fast init done
[    6.345919] SGI XFS with ACLs, security attributes, no debug enabled
[    6.356572] XFS (dm-0): Mounting V5 Filesystem
[    6.398617] XFS (dm-0): Ending clean mount
[    6.973554] systemd-journald[198]: Received SIGTERM from PID 1 (systemd).
[    6.989018] systemd: 20 output lines suppressed due to ratelimiting
[    7.019839] audit: type=1404 audit(1493395245.790:2): enforcing=1 old_enforcing=0 auid=4294967295 ses=4294967295
[    7.106438] SELinux: 32768 avtab hash slots, 105786 rules.
[    7.137061] SELinux: 32768 avtab hash slots, 105786 rules.
[    7.216426] SELinux:  8 users, 14 roles, 4990 types, 304 bools, 1 sens, 1024 cats
[    7.216433] SELinux:  94 classes, 105786 rules
[    7.223909] SELinux:  Class sctp_socket not defined in policy.
[    7.229741] SELinux:  Class icmp_socket not defined in policy.
[    7.235543] SELinux:  Class ax25_socket not defined in policy.
[    7.241349] SELinux:  Class ipx_socket not defined in policy.
[    7.247069] SELinux:  Class netrom_socket not defined in policy.
[    7.253043] SELinux:  Class atmpvc_socket not defined in policy.
[    7.259021] SELinux:  Class x25_socket not defined in policy.
[    7.264736] SELinux:  Class rose_socket not defined in policy.
[    7.270540] SELinux:  Class decnet_socket not defined in policy.
[    7.276513] SELinux:  Class atmsvc_socket not defined in policy.
[    7.282490] SELinux:  Class rds_socket not defined in policy.
[    7.288207] SELinux:  Class irda_socket not defined in policy.
[    7.294008] SELinux:  Class pppox_socket not defined in policy.
[    7.299898] SELinux:  Class llc_socket not defined in policy.
[    7.305613] SELinux:  Class can_socket not defined in policy.
[    7.311330] SELinux:  Class tipc_socket not defined in policy.
[    7.317135] SELinux:  Class bluetooth_socket not defined in policy.
[    7.323368] SELinux:  Class iucv_socket not defined in policy.
[    7.329172] SELinux:  Class rxrpc_socket not defined in policy.
[    7.335059] SELinux:  Class isdn_socket not defined in policy.
[    7.340863] SELinux:  Class phonet_socket not defined in policy.
[    7.346836] SELinux:  Class ieee802154_socket not defined in policy.
[    7.353159] SELinux:  Class caif_socket not defined in policy.
[    7.358965] SELinux:  Class alg_socket not defined in policy.
[    7.364679] SELinux:  Class nfc_socket not defined in policy.
[    7.370397] SELinux:  Class vsock_socket not defined in policy.
[    7.376284] SELinux:  Class kcm_socket not defined in policy.
[    7.382002] SELinux:  Class qipcrtr_socket not defined in policy.
[    7.388066] SELinux:  Class smc_socket not defined in policy.
[    7.393780] SELinux: the above unknown classes and permissions will be allowed
[    7.400979] SELinux:  Completing initialization.
[    7.400980] SELinux:  Setting up existing superblocks.
[    7.450804] audit: type=1403 audit(1493395246.220:3): policy loaded auid=4294967295 ses=4294967295
[    7.455100] systemd[1]: Successfully loaded SELinux policy in 435.279ms.
[    7.470770] systemd[1]: RTC configured in localtime, applying delta of -240 minutes to system time.
[    7.497588] ip_tables: (C) 2000-2006 Netfilter Core Team
[    7.502902] systemd[1]: Inserted module 'ip_tables'
[    7.552579] systemd[1]: Relabelled /dev and /run in 42.787ms.
[    8.005378] systemd-journald[616]: Received request to flush runtime journal from PID 1
[    8.167863] xgene-slimpro-mbox APMC0D01:00: APM X-Gene SLIMpro MailBox registered
[    8.172785] RPC: Registered named UNIX socket transport module.
[    8.172790] RPC: Registered udp transport module.
[    8.172794] RPC: Registered tcp transport module.
[    8.172797] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    8.197228] xgene-rng APMC0D18:00: Couldn't get the clock for RNG
[    8.204225] xgene-gpio-sb APMC0D15:00: Support 22 gpios, 6 irqs start from pin 8
[    8.213102] xgene-gpio-sb APMC0D15:00: X-Gene GPIO Standby driver registered
[    8.223510] xgene-slimpro-i2c APMC0D40:00: i2c mailbox channel request failed
[    8.289837] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    8.295454] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    8.387796] xgene-slimpro-hwmon APMC0D29:00: APM X-Gene SoC HW monitor driver registered
[    8.518644] Adding 8388544k swap on /dev/mapper/rhelp_dhcp--171-swap.  Priority:-1 extents:1 across:8388544k SSFS
[    8.531009] XFS (sda2): Mounting V5 Filesystem
[    8.551661] XFS (sda2): Ending clean mount
[    8.640881] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[    8.702746] XFS (dm-2): Mounting V5 Filesystem
[    8.721803] XFS (dm-2): Ending clean mount
[    9.540607] IPv6: ADDRCONF(NETDEV_UP): enp1s0: link is not ready
[    9.637501] IPv6: ADDRCONF(NETDEV_UP): enp1s0: link is not ready
[    9.650581] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[    9.656789] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[    9.669293] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
[    9.675510] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
[    9.687727] IPv6: ADDRCONF(NETDEV_UP): eth2: link is not ready
[    9.693923] IPv6: ADDRCONF(NETDEV_UP): eth2: link is not ready
[    9.706099] IPv6: ADDRCONF(NETDEV_UP): eth3: link is not ready
[    9.712318] IPv6: ADDRCONF(NETDEV_UP): eth3: link is not ready
[    9.730562] IPv6: ADDRCONF(NETDEV_UP): enp1s0: link is not ready
[    9.737469] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[    9.744174] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
[    9.751066] IPv6: ADDRCONF(NETDEV_UP): eth2: link is not ready
[    9.757808] IPv6: ADDRCONF(NETDEV_UP): eth3: link is not ready
[   10.687474] xgene-enet APMC0D30:00 eth1: Link is Down
[   10.692580] xgene-enet APMC0D05:00 eth0: Link is Down
[   10.767324] xgene-enet APMC0D30:01 eth2: Link is Down
[   12.418373] e1000e: enp1s0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
[   12.426374] IPv6: ADDRCONF(NETDEV_CHANGE): enp1s0: link becomes ready
[   13.808268] xgene-enet APMC0D05:00 eth0: Link is Up - 1Gbps/Full - flow control off
[   13.815925] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[  108.537236] random: crng init done

--------------602DED4F2879C21F927CAB2C
Content-Type: text/plain; charset=UTF-8;
 name="dmesg_4.11.0-rc8.xgene_msix2+_msi.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg_4.11.0-rc8.xgene_msix2+_msi.txt"

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.11.0-rc8.xgene_msix2+ (root@mustang4.bos.jonmasters.org) (gcc version 4.8.5 20150623 (Red Hat 4.8.5-14) (GCC) ) #2 SMP Fri Apr 28 12:06:14 EDT 2017
[    0.000000] Boot CPU: AArch64 Processor [500f0001]
[    0.000000] earlycon: uart8250 at MMIO32 0x000000001c020000 (options '')
[    0.000000] bootconsole [uart8250] enabled
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: EFI v2.40 by X-Gene Mustang Board EFI Aug 19 2016 18:02:24
[    0.000000] efi:  ACPI=0x43fa82d000  ACPI 2.0=0x43fa82d014  SMBIOS 3.0=0x43fa82b000  ESRT=0x43ff053d18 
[    0.000000] esrt: Reserving ESRT space from 0x00000043ff053d18 to 0x00000043ff053d78.
[    0.000000] cma: Reserved 512 MiB at 0x00000040e0000000
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000043FA82D014 000024 (v02 APM   )
[    0.000000] ACPI: XSDT 0x00000043FA82C0E8 000084 (v01 APM    XGENE    00000003      01000013)
[    0.000000] ACPI: FACP 0x00000043FA822000 00010C (v05 APM    XGENE    00000003 INTL 20140724)
[    0.000000] ACPI: DSDT 0x00000043FA823000 005837 (v05 APM    APM88xxx 00000001 INTL 20140724)
[    0.000000] ACPI: DBG2 0x00000043FA829000 0000AA (v00 APMC0D XGENEDBG 00000000 INTL 20140724)
[    0.000000] ACPI: GTDT 0x00000043FA820000 000060 (v02 APM    XGENE    00000001 INTL 20140724)
[    0.000000] ACPI: MCFG 0x00000043FA81F000 00003C (v01 APM    XGENE    00000002 INTL 20140724)
[    0.000000] ACPI: SPCR 0x00000043FA81E000 000050 (v02 APMC0D XGENESPC 00000000 INTL 20140724)
[    0.000000] ACPI: SSDT 0x00000043FA81D000 00002D (v02 APM    XGENE    00000001 INTL 20140724)
[    0.000000] ACPI: BERT 0x00000043FA81C000 000030 (v01 APM    XGENE    00000002 INTL 20140724)
[    0.000000] ACPI: HEST 0x00000043FA81B000 0002A8 (v01 APM    XGENE    00000002 INTL 20140724)
[    0.000000] ACPI: APIC 0x00000043FA81A000 0002A4 (v03 APM    XGENE    00000003      01000013)
[    0.000000] ACPI: SSDT 0x00000043FA819000 000063 (v02 REDHAT MACADDRS 00000001      01000013)
[    0.000000] ACPI: SSDT 0x00000043FA818000 000032 (v02 REDHAT UARTCLKS 00000001      01000013)
[    0.000000] ACPI: PCCT 0x00000043FA817000 000300 (v01 APM    XGENE    00000003      01000013)
[    0.000000] ACPI: SPCR: console: uart,mmio,0x1c020000,115200
[    0.000000] ACPI: NUMA: Failed to initialise from firmware
[    0.000000] NUMA: Faking a node at [mem 0x0000000000000000-0x00000043ffffffff]
[    0.000000] NUMA: Adding memblock [0x4000000000 - 0x40001fffff] on node 0
[    0.000000] NUMA: Adding memblock [0x4000200000 - 0x43fa7cffff] on node 0
[    0.000000] NUMA: Adding memblock [0x43fa7d0000 - 0x43faa1ffff] on node 0
[    0.000000] NUMA: Adding memblock [0x43faa20000 - 0x43ff9cffff] on node 0
[    0.000000] NUMA: Adding memblock [0x43ff9d0000 - 0x43ffa1ffff] on node 0
[    0.000000] NUMA: Adding memblock [0x43ffa20000 - 0x43ffffffff] on node 0
[    0.000000] NUMA: Initmem setup node 0 [mem 0x4000000000-0x43ffffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x43ffffe200-0x43ffffffff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000004000000000-0x00000040ffffffff]
[    0.000000]   Normal   [mem 0x0000004100000000-0x00000043ffffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000004000000000-0x00000040001fffff]
[    0.000000]   node   0: [mem 0x0000004000200000-0x00000043fa7cffff]
[    0.000000]   node   0: [mem 0x00000043fa7d0000-0x00000043faa1ffff]
[    0.000000]   node   0: [mem 0x00000043faa20000-0x00000043ff9cffff]
[    0.000000]   node   0: [mem 0x00000043ff9d0000-0x00000043ffa1ffff]
[    0.000000]   node   0: [mem 0x00000043ffa20000-0x00000043ffffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000004000000000-0x00000043ffffffff]
[    0.000000] On node 0 totalpages: 262144
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 65536 pages, LIFO batch:1
[    0.000000]   Normal zone: 192 pages used for memmap
[    0.000000]   Normal zone: 196608 pages, LIFO batch:1
[    0.000000] psci: is not implemented in ACPI.
[    0.000000] percpu: Embedded 3 pages/cpu @ffff8003ffdf0000 s124312 r8192 d64104 u196608
[    0.000000] pcpu-alloc: s124312 r8192 d64104 u196608 alloc=3*65536
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6 [0] 7 
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 261888
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.11.0-rc8.xgene_msix2+ root=/dev/mapper/rhelp_dhcp--171-root ro crashkernel=auto rd.lvm.lv=rhelp_dhcp-171/root rd.lvm.lv=rhelp_dhcp-171/swap LANG=en_US.UTF-8 acpi=force earlycon=uart8250,mmio32,0x1c020000 console=ttyS0,115200
[    0.000000] PID hash table entries: 4096 (order: -1, 32768 bytes)
[    0.000000] software IO TLB [mem 0x40dbff0000-0x40dfff0000] (64MB) mapped at [ffff8000dbff0000-ffff8000dffeffff]
[    0.000000] Memory: 16109888K/16777216K available (7420K kernel code, 1354K rwdata, 3200K rodata, 1216K init, 7286K bss, 143040K reserved, 524288K cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     modules : 0xffff000000000000 - 0xffff000008000000   (   128 MB)
[    0.000000]     vmalloc : 0xffff000008000000 - 0xffff7bdfffff0000   (126847 GB)
[    0.000000]       .text : 0xffff000008080000 - 0xffff0000087c0000   (  7424 KB)
[    0.000000]     .rodata : 0xffff0000087c0000 - 0xffff000008af0000   (  3264 KB)
[    0.000000]       .init : 0xffff000008af0000 - 0xffff000008c20000   (  1216 KB)
[    0.000000]       .data : 0xffff000008c20000 - 0xffff000008d72a00   (  1355 KB)
[    0.000000]        .bss : 0xffff000008d72a00 - 0xffff0000094902d4   (  7287 KB)
[    0.000000]     fixed   : 0xffff7fdffe7d0000 - 0xffff7fdffec00000   (  4288 KB)
[    0.000000]     PCI I/O : 0xffff7fdffee00000 - 0xffff7fdfffe00000   (    16 MB)
[    0.000000]     vmemmap : 0xffff7fe000000000 - 0xffff800000000000   (   128 GB maximum)
[    0.000000]               0xffff7fe000000000 - 0xffff7fe001000000   (    16 MB actual)
[    0.000000]     memory  : 0xffff800000000000 - 0xffff800400000000   ( 16384 MB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=4096 to nr_cpu_ids=8.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=8
[    0.000000] NR_IRQS:64 nr_irqs:64 0
[    0.000000] GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: No distributor detected at @ffff000008050000, giving up
[    0.000000] arm_arch_timer: Architected cp15 timer(s) running at 50.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0xb8812736b, max_idle_ns: 440795202655 ns
[    0.000002] sched_clock: 56 bits at 50MHz, resolution 20ns, wraps every 4398046511100ns
[    0.008379] Console: colour dummy device 80x25
[    0.012950] Calibrating delay loop (skipped), value calculated using timer frequency.. 100.00 BogoMIPS (lpj=500000)
[    0.023693] pid_max: default: 32768 minimum: 301
[    0.028471] ACPI: Core revision 20170119
[    0.036063] ACPI Error: Method parse/execution failed [\_SB.ET00._STA] (Node ffff8003c0195c08), AE_CTRL_PARSE_CONTINUE (20170119/psparse-543)
[    0.049121] ACPI Error: Invalid zero thread count in method (20170119/dsmethod-790)
[    0.056989] ACPI Error: Invalid OwnerId: 0x00 (20170119/utownerid-186)
[    0.063808] ACPI Error: Method parse/execution failed [\_SB.ET01._STA] (Node ffff8003c0195eb0), AE_CTRL_PARSE_CONTINUE (20170119/psparse-543)
[    0.076952] ACPI Error: Invalid zero thread count in method (20170119/dsmethod-790)
[    0.084871] ACPI Error: Invalid OwnerId: 0x00 (20170119/utownerid-186)
[    0.092015] ACPI: 4 ACPI AML tables successfully acquired and loaded
[    0.098567] Security Framework initialized
[    0.102838] SELinux:  Initializing.
[    0.106408] SELinux:  Starting in permissive mode
[    0.106607] Dentry cache hash table entries: 2097152 (order: 8, 16777216 bytes)
[    0.116844] Inode-cache hash table entries: 1048576 (order: 7, 8388608 bytes)
[    0.125552] Mount-cache hash table entries: 32768 (order: 2, 262144 bytes)
[    0.132626] Mountpoint-cache hash table entries: 32768 (order: 2, 262144 bytes)
[    0.140570] ftrace: allocating 26815 entries in 7 pages
[    0.203748] ASID allocator initialised with 65536 entries
[    0.209911] Remapping and enabling EFI services.
[    0.214705]   EFI remap 0x0000000010510000 => 0000000020000000
[    0.220700]   EFI remap 0x0000000010548000 => 0000000020018000
[    0.226689]   EFI remap 0x0000000017000000 => 0000000020020000
[    0.232657]   EFI remap 0x000000001c025000 => 0000000020035000
[    0.238736] UEFI Runtime regions are not aligned to 64 KB -- buggy firmware?
[    0.238741] ------------[ cut here ]------------
[    0.250727] WARNING: CPU: 0 PID: 1 at arch/arm64/kernel/efi.c:34 efi_create_mapping+0x4c/0x104
[    0.259532] Modules linked in:

[    0.264214] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.11.0-rc8.xgene_msix2+ #2
[    0.271827] Hardware name: APM X-Gene Mustang board (DT)
[    0.277238] task: ffff8003c1bc0000 task.stack: ffff8003c1c00000
[    0.283324] PC is at efi_create_mapping+0x4c/0x104
[    0.288269] LR is at efi_create_mapping+0x4c/0x104
[    0.293127] pc : [<ffff000008af51f0>] lr : [<ffff000008af51f0>] pstate: 60000045
[    0.300784] sp : ffff8003c1c03d20
[    0.304207] x29: ffff8003c1c03d20 x28: 0000000000000000 
[    0.309655] x27: ffff000008c53000 x26: ffff000008d429c8 
[    0.315110] x25: ffff000008d42000 x24: 0000000000000000 
[    0.320556] x23: ffff000008a4c910 x22: ffff000008c60000 
[    0.325994] x21: ffff000008c53000 x20: ffff000008d429c8 
[    0.331484] x19: ffff8003f96ab348 x18: 00000000b6a2110e 
[    0.337008] x17: 0000000000000000 x16: 0000000000000000 
[    0.342437] x15: ffff000008c53000 x14: 00000000cb9aed1d 
[    0.347944] x13: ffff0000089ca500 x12: 0000000000040b00 
[    0.353425] x11: ffff8003c1c039e0 x10: ffff8003c1c039e0 
[    0.358889] x9 : 0000000000000073 x8 : 6620796767756220 
[    0.364352] x7 : 2d2d20424b203436 x6 : ffff000009274718 
[    0.369825] x5 : ffff8003ffdf7530 x4 : 0000000000000000 
[    0.375280] x3 : 0000000000000000 x2 : 0000000000040b00 
[    0.380769] x1 : 0000000000040b00 x0 : 0000000000000040 

[    0.387782] ---[ end trace 9580655578fda7c1 ]---
[    0.392519] Call trace:
[    0.395045] Exception stack(0xffff8003c1c03b30 to 0xffff8003c1c03c60)
[    0.401735] 3b20:                                   ffff8003f96ab348 0001000000000000
[    0.409730] 3b40: ffff8003c1c03d20 ffff000008af51f0 0000000060000045 ffff000008d429c8
[    0.417828] 3b60: 0000000000000000 0000000000000000 ffff8003c1c03d20 ffff8003c1c03d20
[    0.425857] 3b80: ffff8003c1c03ce0 00000000ffffffc8 ffff8003c1c03be0 ffff00000812f6b8
[    0.433946] 3ba0: ffff000008c53000 00000000ffffffc8 ffff8003c1c03c00 ffff0000089be038
[    0.442053] 3bc0: ffff8003c1c03d20 ffff8003c1c03d20 ffff8003c1c03ce0 00000000ffffffc8
[    0.450126] 3be0: ffff8003c1c03c70 0000000000040b00 0000000000000040 0000000000040b00
[    0.458207] 3c00: 0000000000040b00 0000000000000000 0000000000000000 ffff8003ffdf7530
[    0.466227] 3c20: ffff000009274718 2d2d20424b203436 6620796767756220 0000000000000073
[    0.474282] 3c40: ffff8003c1c039e0 ffff8003c1c039e0 0000000000040b00 ffff0000089ca500
[    0.482321] [<ffff000008af51f0>] efi_create_mapping+0x4c/0x104
[    0.488270] [<ffff000008b3db98>] arm_enable_runtime_services+0x154/0x238
[    0.495238] [<ffff000008083698>] do_one_initcall+0x54/0x15c
[    0.501030] [<ffff000008af0d18>] kernel_init_freeable+0xe4/0x25c
[    0.507221] [<ffff0000087ae488>] kernel_init+0x18/0x108
[    0.512606] [<ffff0000080833c0>] ret_from_fork+0x10/0x50
[    0.518077]   EFI remap 0x00000043fa7df000 => 000000002004f000
[    0.524089]   EFI remap 0x00000043fa82e000 => 000000002006e000
[    0.530085]   EFI remap 0x00000043ff9d6000 => 0000000020266000
[    0.536148]   EFI remap 0x00000043ff9ea000 => 000000002027a000
[    0.542320] smp: Bringing up secondary CPUs ...
[    0.547164] Detected PIPT I-cache on CPU1
[    0.547192] CPU1: Booted secondary processor [500f0001]
[    0.547411] Detected PIPT I-cache on CPU2
[    0.547433] CPU2: Booted secondary processor [500f0001]
[    0.547646] Detected PIPT I-cache on CPU3
[    0.547660] CPU3: Booted secondary processor [500f0001]
[    0.547854] Detected PIPT I-cache on CPU4
[    0.547875] CPU4: Booted secondary processor [500f0001]
[    0.548076] Detected PIPT I-cache on CPU5
[    0.548090] CPU5: Booted secondary processor [500f0001]
[    0.548281] Detected PIPT I-cache on CPU6
[    0.548302] CPU6: Booted secondary processor [500f0001]
[    0.548505] Detected PIPT I-cache on CPU7
[    0.548519] CPU7: Booted secondary processor [500f0001]
[    0.548562] smp: Brought up 1 node, 8 CPUs
[    0.620493] SMP: Total of 8 processors activated.
[    0.625425] CPU features: detected feature: 32-bit EL0 Support
[    0.631511] CPU: All CPU(s) started at EL2
[    0.636531] devtmpfs: initialized
[    0.640271] SMBIOS 3.0.0 present.
[    0.643745] DMI: AppliedMicro X-Gene Mustang Board/X-Gene Mustang Board, BIOS 3.06.15 Aug 19 2016
[    0.653110] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.663392] futex hash table entries: 2048 (order: 2, 262144 bytes)
[    0.670383] pinctrl core: initialized pinctrl subsystem
[    0.676091] NET: Registered protocol family 16
[    0.681082] cpuidle: using governor menu
[    0.685276] Detected 8 PCC Subspaces
[    0.689040] Registering PCC driver as Mailbox controller
[    0.694649] vdso: 2 pages (1 code @ ffff0000087e0000, 1 data @ ffff000008c40000)
[    0.702382] hw-breakpoint: found 4 breakpoint and 4 watchpoint registers.
[    0.711945] DMA: preallocated 256 KiB pool for atomic allocations
[    0.718368] ACPI: bus type PCI registered
[    0.722572] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.729340] Serial: AMBA PL011 UART driver
[    0.735597] HugeTLB registered 512 MB page size, pre-allocated 0 pages
[    0.743073] ACPI: Added _OSI(Module Device)
[    0.747432] ACPI: Added _OSI(Processor Device)
[    0.752083] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.757005] ACPI: Added _OSI(Processor Aggregator Device)
[    0.772090] ACPI: Interpreter enabled
[    0.775913] ACPI: Using GIC for interrupt routing
[    0.780864] ACPI: MCFG table detected, 1 entries
[    0.785858] HEST: Table parsing has been initialized.
[    0.793565] ACPI: Power Resource [SCVR] (on)
[    0.828517] xgene-msi APMC0D0E:00: APM X-Gene PCIe MSI driver loaded
[    0.835285] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.841791] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.850585] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
[    0.859017] acpi PNP0A08:00: MCFG quirk: ECAM at [mem 0xe0d0000000-0xe0dfffffff] for [bus 00-ff] with xgene_v1_pcie_ecam_ops
[    0.871645] acpi PNP0A08:00: [Firmware Bug]: ECAM area [mem 0xe0d0000000-0xe0dfffffff] not reserved in ACPI namespace
[    0.882851] acpi PNP0A08:00: ECAM at [mem 0xe0d0000000-0xe0dfffffff] for [bus 00-ff]
[    0.891009] Remapped I/O 0x000000e010000000 to [io  0x0000-0xffff window]
[    0.898264] PCI host bridge to bus 0000:00
[    0.902574] pci_bus 0000:00: root bus resource [io  0x0000-0xffff window] (bus address [0x10000000-0x1000ffff])
[    0.913134] pci_bus 0000:00: root bus resource [mem 0xe040000000-0xe07fffffff window] (bus address [0x40000000-0x7fffffff])
[    0.924779] pci_bus 0000:00: root bus resource [mem 0xf000000000-0xffffffffff window]
[    0.932964] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.938697] pci 0000:00:00.0: [10e8:e004] type 01 class 0x060400
[    0.938776] pci 0000:00:00.0: supports D1 D2
[    0.938937] pci 0000:01:00.0: [8086:10d3] type 00 class 0x020000
[    0.938970] pci 0000:01:00.0: reg 0x10: [mem 0xe040080000-0xe04009ffff]
[    0.938986] pci 0000:01:00.0: reg 0x14: [mem 0xe040000000-0xe04007ffff]
[    0.939003] pci 0000:01:00.0: reg 0x18: [io  0x0000-0x001f]
[    0.939019] pci 0000:01:00.0: reg 0x1c: [mem 0xe0400a0000-0xe0400a3fff]
[    0.939065] pci 0000:01:00.0: reg 0x30: [mem 0xfffc0000-0xffffffff pref]
[    0.939205] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    0.968751] pci 0000:00:00.0: BAR 14: assigned [mem 0xe040000000-0xe0400fffff]
[    0.976281] pci 0000:00:00.0: BAR 13: assigned [io  0x1000-0x1fff]
[    0.982748] pci 0000:01:00.0: BAR 1: assigned [mem 0xe040000000-0xe04007ffff]
[    0.990222] pci 0000:01:00.0: BAR 6: assigned [mem 0xe040080000-0xe0400bffff pref]
[    0.998135] pci 0000:01:00.0: BAR 0: assigned [mem 0xe0400c0000-0xe0400dffff]
[    1.005583] pci 0000:01:00.0: BAR 3: assigned [mem 0xe0400e0000-0xe0400e3fff]
[    1.013044] pci 0000:01:00.0: BAR 2: assigned [io  0x1000-0x101f]
[    1.019447] pci 0000:00:00.0: PCI bridge to [bus 01]
[    1.024681] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
[    1.031099] pci 0000:00:00.0:   bridge window [mem 0xe040000000-0xe0400fffff]
[    1.039197] vgaarb: loaded
[    1.042181] SCSI subsystem initialized
[    1.046203] libata version 3.00 loaded.
[    1.046240] ACPI: bus type USB registered
[    1.050444] usbcore: registered new interface driver usbfs
[    1.056204] usbcore: registered new interface driver hub
[    1.061821] usbcore: registered new device driver usb
[    1.067216] Registered efivars operations
[    1.071684] NetLabel: Initializing
[    1.075256] NetLabel:  domain hash size = 128
[    1.079777] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    1.085747] NetLabel:  unlabeled traffic allowed by default
[    1.091744] clocksource: Switched to clocksource arch_sys_counter
[    1.116637] VFS: Disk quotas dquot_6.6.0
[    1.120816] VFS: Dquot-cache hash table entries: 8192 (order 0, 65536 bytes)
[    1.128374] pnp: PnP ACPI init
[    1.132213] pnp: PnP ACPI: found 0 devices
[    1.139026] NET: Registered protocol family 2
[    1.143824] TCP established hash table entries: 131072 (order: 4, 1048576 bytes)
[    1.151892] TCP bind hash table entries: 65536 (order: 4, 1048576 bytes)
[    1.159275] TCP: Hash tables configured (established 131072 bind 65536)
[    1.166293] UDP hash table entries: 8192 (order: 2, 262144 bytes)
[    1.172798] UDP-Lite hash table entries: 8192 (order: 2, 262144 bytes)
[    1.179867] NET: Registered protocol family 1
[    1.184479] PCI: CLS 64 bytes, default 128
[    1.184578] Unpacking initramfs...
[    1.868130] Freeing initrd memory: 32640K
[    1.872713] kvm [1]: 8-bit VMID
[    1.875992] kvm [1]: IDMAP page: 40009b7000
[    1.880358] kvm [1]: HYP VA range: 800000000000:ffffffffffff
[    1.886375] kvm [1]: Hyp mode initialized successfully
[    1.891755] kvm [1]: GICV region size/alignment is unsafe, using trapping (reduced performance)
[    1.900915] kvm [1]: vgic-v2@780cf000
[    1.904807] kvm [1]: vgic interrupt IRQ1
[    1.908909] kvm [1]: virtual timer IRQ4
[    1.928681] audit: initializing netlink subsys (disabled)
[    1.934412] audit: type=2000 audit(1.470:1): state=initialized audit_enabled=0 res=1
[    1.934540] Initialise system trusted keyrings
[    1.934609] workingset: timestamp_bits=44 max_order=18 bucket_order=0
[    1.936691] zbud: loaded
[    1.937062] SELinux:  Registering netfilter hooks
[    2.016448] NET: Registered protocol family 38
[    2.021088] Key type asymmetric registered
[    2.025420] Asymmetric key parser 'x509' registered
[    2.030583] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    2.038391] io scheduler noop registered
[    2.042467] io scheduler deadline registered (default)
[    2.047931] io scheduler cfq registered
[    2.051950] io scheduler mq-deadline registered
[    2.056870] atomic64_test: passed
[    2.060612] xgene-gpio APMC0D14:00: X-Gene GPIO driver registered.
[    2.067387] pcieport 0000:00:00.0: AER enabled with IRQ 83
[    2.073172] pcieport 0000:00:00.0: Signaling PME with IRQ 83
[    2.079355] input: Power Button as /devices/LNXSYSTM:00/PNP0C0C:00/input/input0
[    2.087026] ACPI: Power Button [PWRB]
[    2.091368] GHES: Failed to map GSI to IRQ for generic hardware error source: 2
[    2.099018] GHES: probe of GHES.2 failed with error 82
[    2.104386] GHES: Failed to map GSI to IRQ for generic hardware error source: 3
[    2.112068] GHES: probe of GHES.3 failed with error 82
[    2.117497] GHES: Failed to map GSI to IRQ for generic hardware error source: 4
[    2.125101] GHES: probe of GHES.4 failed with error 82
[    2.130452] GHES: Failed to map GSI to IRQ for generic hardware error source: 5
[    2.138036] GHES: probe of GHES.5 failed with error 82
[    2.143461] GHES: Failed to map GSI to IRQ for generic hardware error source: 6
[    2.151121] GHES: probe of GHES.6 failed with error 82
[    2.156510] GHES: Failed to map GSI to IRQ for generic hardware error source: 7
[    2.164189] GHES: probe of GHES.7 failed with error 82
[    2.169574] GHES: Failed to map GSI to IRQ for generic hardware error source: 8
[    2.177249] GHES: probe of GHES.8 failed with error 82
[    2.182604] GHES: Failed to map GSI to IRQ for generic hardware error source: 9
[    2.190284] GHES: probe of GHES.9 failed with error 82
[    2.195693] GHES: Failed to enable APEI firmware first mode.
[    2.201771] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    2.208814] console [ttyS0] disabled
[    2.232712] APMC0D08:00: ttyS0 at MMIO 0x1c020000 (irq = 22, base_baud = 3125000) is a U6_16550A
[    2.241919] console [ttyS0] enabled
[    2.249007] bootconsole [uart8250] disabled
[    2.277886] APMC0D08:01: ttyS1 at MMIO 0x1c021000 (irq = 23, base_baud = 3125000) is a U6_16550A
[    2.287044] cacheinfo: Unable to detect cache hierarchy for CPU 0
[    2.293126] rdac: device handler registered
[    2.297348] hp_sw: device handler registered
[    2.301595] emc: device handler registered
[    2.305766] alua: device handler registered
[    2.310077] libphy: Fixed MDIO Bus: probed
[    2.314237] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.320734] ehci-pci: EHCI PCI platform driver
[    2.325177] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.331327] ohci-pci: OHCI PCI platform driver
[    2.335764] uhci_hcd: USB Universal Host Controller Interface driver
[    2.342182] xhci-hcd 808622B7:00: xHCI Host Controller
[    2.347366] xhci-hcd 808622B7:00: new USB bus registered, assigned bus number 1
[    2.354792] xhci-hcd 808622B7:00: hcc params 0x0220f06d hci version 0x100 quirks 0x00010010
[    2.363122] xhci-hcd 808622B7:00: irq 29, io mem 0x19000000
[    2.368735] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    2.375494] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.382682] usb usb1: Product: xHCI Host Controller
[    2.387533] usb usb1: Manufacturer: Linux 4.11.0-rc8.xgene_msix2+ xhci-hcd
[    2.394375] usb usb1: SerialNumber: 808622B7:00
[    2.399097] hub 1-0:1.0: USB hub found
[    2.402848] hub 1-0:1.0: 1 port detected
[    2.406851] xhci-hcd 808622B7:00: xHCI Host Controller
[    2.412034] xhci-hcd 808622B7:00: new USB bus registered, assigned bus number 2
[    2.419332] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    2.427425] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[    2.434184] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.441368] usb usb2: Product: xHCI Host Controller
[    2.446223] usb usb2: Manufacturer: Linux 4.11.0-rc8.xgene_msix2+ xhci-hcd
[    2.453069] usb usb2: SerialNumber: 808622B7:00
[    2.457761] hub 2-0:1.0: USB hub found
[    2.461501] hub 2-0:1.0: 1 port detected
[    2.465534] xhci-hcd 808622B7:01: xHCI Host Controller
[    2.470715] xhci-hcd 808622B7:01: new USB bus registered, assigned bus number 3
[    2.478113] xhci-hcd 808622B7:01: hcc params 0x0220f06d hci version 0x100 quirks 0x00010010
[    2.486441] xhci-hcd 808622B7:01: irq 30, io mem 0x19800000
[    2.492041] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[    2.498793] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.505984] usb usb3: Product: xHCI Host Controller
[    2.510836] usb usb3: Manufacturer: Linux 4.11.0-rc8.xgene_msix2+ xhci-hcd
[    2.517682] usb usb3: SerialNumber: 808622B7:01
[    2.522397] hub 3-0:1.0: USB hub found
[    2.526137] hub 3-0:1.0: 1 port detected
[    2.530122] xhci-hcd 808622B7:01: xHCI Host Controller
[    2.535305] xhci-hcd 808622B7:01: new USB bus registered, assigned bus number 4
[    2.542607] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    2.550692] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003
[    2.557451] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.564640] usb usb4: Product: xHCI Host Controller
[    2.569491] usb usb4: Manufacturer: Linux 4.11.0-rc8.xgene_msix2+ xhci-hcd
[    2.576334] usb usb4: SerialNumber: 808622B7:01
[    2.581037] hub 4-0:1.0: USB hub found
[    2.584788] hub 4-0:1.0: 1 port detected
[    2.588828] usbcore: registered new interface driver usbserial
[    2.594649] usbcore: registered new interface driver usbserial_generic
[    2.601150] usbserial: USB Serial support registered for generic
[    2.607208] mousedev: PS/2 mouse device common for all mice
[    2.612948] rtc-efi rtc-efi: rtc core: registered rtc-efi as rtc0
[    2.619241] EFI Variables Facility v0.08 2004-May-17
[    2.624405] hidraw: raw HID events driver (C) Jiri Kosina
[    2.629836] usbcore: registered new interface driver usbhid
[    2.635388] usbhid: USB HID core driver
[    2.639274] drop_monitor: Initializing network drop monitor service
[    2.645602] Initializing XFRM netlink socket
[    2.650006] NET: Registered protocol family 10
[    2.654800] Segment Routing with IPv6
[    2.658462] NET: Registered protocol family 17
[    2.663153] registered taskstats version 1
[    2.667231] Loading compiled-in X.509 certificates
[    2.675102] alg: No test for pkcs1pad(rsa,sha1) (pkcs1pad(rsa-generic,sha1))
[    2.683548] Loaded X.509 cert 'Build time autogenerated kernel key: 98aa1b1964f4052ba920878b6f8348e178459895'
[    2.693521] zswap: loaded using pool lzo/zbud
[    2.717703] Key type big_key registered
[    2.721594] BERT: [Firmware Bug]: table invalid.
[    2.726272] rtc-efi rtc-efi: setting system clock to 2017-04-28 16:24:34 UTC (1493396674)
[    2.759039] Freeing unused kernel memory: 1216K
[    2.768550] random: systemd: uninitialized urandom read (16 bytes read)
[    2.775743] random: systemd: uninitialized urandom read (16 bytes read)
[    2.782366] random: systemd: uninitialized urandom read (16 bytes read)
[    2.790811] systemd[1]: systemd 219 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 -SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
[    2.809044] systemd[1]: Detected architecture arm64.
[    2.814004] systemd[1]: Running in initial RAM disk.
[    2.851832] systemd[1]: Set hostname to <localhost.localdomain>.
[    2.970013] random: systemd: uninitialized urandom read (16 bytes read)
[    2.976652] random: systemd: uninitialized urandom read (16 bytes read)
[    2.983295] random: systemd: uninitialized urandom read (16 bytes read)
[    2.989979] random: systemd: uninitialized urandom read (16 bytes read)
[    2.997677] random: systemd: uninitialized urandom read (16 bytes read)
[    3.004524] random: systemd: uninitialized urandom read (16 bytes read)
[    3.011427] random: systemd: uninitialized urandom read (16 bytes read)
[    3.051810] systemd[1]: Reached target Timers.
[    3.056250] systemd[1]: Starting Timers.
[    3.091786] systemd[1]: Created slice Root Slice.
[    3.096483] systemd[1]: Starting Root Slice.
[    3.131780] systemd[1]: Listening on udev Kernel Socket.
[    3.137083] systemd[1]: Starting udev Kernel Socket.
[    4.102501] device-mapper: uevent: version 1.0.3
[    4.107414] device-mapper: ioctl: 4.35.0-ioctl (2016-06-23) initialised: dm-devel@redhat.com
[    4.412199] xgene-ahci APMC0D0D:00: skip clock and PHY initialization
[    4.418619] xgene-ahci APMC0D0D:00: controller can't do NCQ, turning off CAP_NCQ
[    4.426125] xgene-ahci APMC0D0D:00: AHCI 0001.0300 32 slots 2 ports 6 Gbps 0x3 impl platform mode
[    4.434987] xgene-ahci APMC0D0D:00: flags: 64bit sntf pm only pmp fbs pio slum part ccc 
[    4.434998] xgene-ahci APMC0D0D:00: port 0 is not capable of FBS
[    4.470653] pps_core: LinuxPPS API ver. 1 registered
[    4.475669] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    4.491986] xgene-ahci APMC0D0D:00: port 1 is not capable of FBS
[    4.507826] PTP clock support registered
[    4.521307] sdhci: Secure Digital Host Controller Interface driver
[    4.527512] sdhci: Copyright(c) Pierre Ossman
[    4.577139] mmc0: SDHCI controller on ACPI [APMC0D0C:00] using PIO
[    4.612188] scsi host0: xgene-ahci
[    4.615838] scsi host1: xgene-ahci
[    4.619314] ata1: SATA max UDMA/133 mmio [mem 0x1a400000-0x1a400fff] port 0x100 irq 27
[    4.621598] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    4.621602] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    4.621841] e1000e 0000:01:00.0: enabling device (0000 -> 0002)
[    4.622056] e1000e 0000:01:00.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    4.654091] ata2: SATA max UDMA/133 mmio [mem 0x1a400000-0x1a400fff] port 0x180 irq 27
[    4.662326] xgene-ahci APMC0D0D:01: skip clock and PHY initialization
[    4.668755] xgene-ahci APMC0D0D:01: controller can't do NCQ, turning off CAP_NCQ
[    4.676203] xgene-ahci APMC0D0D:01: AHCI 0001.0300 32 slots 2 ports 6 Gbps 0x3 impl platform mode
[    4.685069] xgene-ahci APMC0D0D:01: flags: 64bit sntf pm only pmp fbs pio slum part ccc 
[    4.693201] xgene-ahci APMC0D0D:01: port 0 is not capable of FBS
[    4.693880] e1000e 0000:01:00.0 0000:01:00.0 (uninitialized): registered PHC clock
[    4.706842] xgene-ahci APMC0D0D:01: port 1 is not capable of FBS
[    4.714376] scsi host2: xgene-ahci
[    4.718239] scsi host3: xgene-ahci
[    4.721961] ata3: SATA max UDMA/133 mmio [mem 0x1a800000-0x1a800fff] port 0x100 irq 28
[    4.729850] ata4: SATA max UDMA/133 mmio [mem 0x1a800000-0x1a800fff] port 0x180 irq 28
[    4.738769] libphy: APM X-Gene MDIO bus: probed
[    4.791711] e1000e 0000:01:00.0 eth0: (PCI Express:2.5GT/s:Width x1) 68:05:ca:46:ce:08
[    4.799622] e1000e 0000:01:00.0 eth0: Intel(R) PRO/1000 Network Connection
[    4.806511] e1000e 0000:01:00.0 eth0: MAC: 3, PHY: 8, PBA No: E46981-008
[    4.808607] xgene-enet APMC0D05:00: clocks have been setup already
[    4.821883] e1000e 0000:01:00.0 enp1s0: renamed from eth0
[    5.011899] xgene-enet APMC0D30:00: clocks have been setup already
[    5.063242] ata3: SATA link down (SStatus 0 SControl 4300)
[    5.068752] ata4: SATA link down (SStatus 0 SControl 4300)
[    5.121895] xgene-enet APMC0D30:01: clocks have been setup already
[    5.136261] xgene-enet APMC0D31:00: clocks have been setup already
[    5.331836] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 4300)
[    5.338118] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 4300)
[    5.344486] ata2.00: ATA-8: Corsair Neutron GTX SSD, M311, max UDMA/133
[    5.351098] ata2.00: 234441648 sectors, multi 1: LBA48 NCQ (depth 0/32)
[    5.357813] ata1.00: ATA-8: Corsair Neutron GTX SSD, M311, max UDMA/133
[    5.364432] ata1.00: 234441648 sectors, multi 1: LBA48 NCQ (depth 0/32)
[    5.371105] ata2.00: configured for UDMA/133
[    5.375470] ata1.00: configured for UDMA/133
[    5.380021] scsi 0:0:0:0: Direct-Access     ATA      Corsair Neutron  M311 PQ: 0 ANSI: 5
[    5.482145] sd 0:0:0:0: [sda] 234441648 512-byte logical blocks: (120 GB/112 GiB)
[    5.482607] scsi 1:0:0:0: Direct-Access     ATA      Corsair Neutron  M311 PQ: 0 ANSI: 5
[    5.498165] sd 0:0:0:0: [sda] Write Protect is off
[    5.502945] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    5.502986] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.514451]  sda: sda1 sda2 sda3
[    5.518153] sd 0:0:0:0: [sda] Attached SCSI disk
[    5.602396] sd 1:0:0:0: [sdb] 234441648 512-byte logical blocks: (120 GB/112 GiB)
[    5.609881] sd 1:0:0:0: [sdb] Write Protect is off
[    5.614681] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    5.614739] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.626189]  sdb: sdb1
[    5.628980] sd 1:0:0:0: [sdb] Attached SCSI disk
[    6.113010] random: fast init done
[    6.461233] SGI XFS with ACLs, security attributes, no debug enabled
[    6.471638] XFS (dm-0): Mounting V5 Filesystem
[    6.501907] XFS (dm-0): Ending clean mount
[    7.216272] systemd-journald[201]: Received SIGTERM from PID 1 (systemd).
[    7.263513] systemd: 20 output lines suppressed due to ratelimiting
[    7.301701] audit: type=1404 audit(1493396679.060:2): enforcing=1 old_enforcing=0 auid=4294967295 ses=4294967295
[    7.410911] SELinux: 32768 avtab hash slots, 105786 rules.
[    7.516206] SELinux: 32768 avtab hash slots, 105786 rules.
[    7.718524] SELinux:  8 users, 14 roles, 4990 types, 304 bools, 1 sens, 1024 cats
[    7.718542] SELinux:  94 classes, 105786 rules
[    7.741338] SELinux:  Class sctp_socket not defined in policy.
[    7.747177] SELinux:  Class icmp_socket not defined in policy.
[    7.753000] SELinux:  Class ax25_socket not defined in policy.
[    7.758809] SELinux:  Class ipx_socket not defined in policy.
[    7.764542] SELinux:  Class netrom_socket not defined in policy.
[    7.770524] SELinux:  Class atmpvc_socket not defined in policy.
[    7.776515] SELinux:  Class x25_socket not defined in policy.
[    7.782247] SELinux:  Class rose_socket not defined in policy.
[    7.788056] SELinux:  Class decnet_socket not defined in policy.
[    7.794048] SELinux:  Class atmsvc_socket not defined in policy.
[    7.800028] SELinux:  Class rds_socket not defined in policy.
[    7.805760] SELinux:  Class irda_socket not defined in policy.
[    7.811568] SELinux:  Class pppox_socket not defined in policy.
[    7.817473] SELinux:  Class llc_socket not defined in policy.
[    7.823204] SELinux:  Class can_socket not defined in policy.
[    7.828926] SELinux:  Class tipc_socket not defined in policy.
[    7.834744] SELinux:  Class bluetooth_socket not defined in policy.
[    7.840984] SELinux:  Class iucv_socket not defined in policy.
[    7.846802] SELinux:  Class rxrpc_socket not defined in policy.
[    7.852707] SELinux:  Class isdn_socket not defined in policy.
[    7.858514] SELinux:  Class phonet_socket not defined in policy.
[    7.864504] SELinux:  Class ieee802154_socket not defined in policy.
[    7.870831] SELinux:  Class caif_socket not defined in policy.
[    7.876649] SELinux:  Class alg_socket not defined in policy.
[    7.882381] SELinux:  Class nfc_socket not defined in policy.
[    7.888103] SELinux:  Class vsock_socket not defined in policy.
[    7.894008] SELinux:  Class kcm_socket not defined in policy.
[    7.899730] SELinux:  Class qipcrtr_socket not defined in policy.
[    7.905822] SELinux:  Class smc_socket not defined in policy.
[    7.911545] SELinux: the above unknown classes and permissions will be allowed
[    7.918772] SELinux:  Completing initialization.
[    7.918776] SELinux:  Setting up existing superblocks.
[    7.993509] audit: type=1403 audit(1493396679.760:3): policy loaded auid=4294967295 ses=4294967295
[    8.002331] systemd[1]: Successfully loaded SELinux policy in 701.052ms.
[    8.029233] systemd[1]: RTC configured in localtime, applying delta of -240 minutes to system time.
[    8.076262] ip_tables: (C) 2000-2006 Netfilter Core Team
[    8.081619] systemd[1]: Inserted module 'ip_tables'
[    8.199798] systemd[1]: Relabelled /dev and /run in 108.385ms.
[    8.666128] systemd-journald[618]: Received request to flush runtime journal from PID 1
[    8.793125] xgene-slimpro-i2c APMC0D40:00: i2c mailbox channel request failed
[    8.809689] RPC: Registered named UNIX socket transport module.
[    8.815634] RPC: Registered udp transport module.
[    8.820316] RPC: Registered tcp transport module.
[    8.825018] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    8.872038] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    8.877502] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    8.883774] xgene-slimpro-hwmon APMC0D29:00: APM X-Gene SoC HW monitor driver registered
[    8.892777] xgene-rng APMC0D18:00: Couldn't get the clock for RNG
[    8.899408] xgene-slimpro-mbox APMC0D01:00: APM X-Gene SLIMpro MailBox registered
[    8.910481] xgene-gpio-sb APMC0D15:00: Support 22 gpios, 6 irqs start from pin 8
[    8.918470] xgene-gpio-sb APMC0D15:00: X-Gene GPIO Standby driver registered
[    9.044885] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[    9.118751] XFS (sda2): Mounting V5 Filesystem
[    9.125864] Adding 8388544k swap on /dev/mapper/rhelp_dhcp--171-swap.  Priority:-1 extents:1 across:8388544k SSFS
[    9.141179] XFS (sda2): Ending clean mount
[    9.286221] XFS (dm-2): Mounting V5 Filesystem
[    9.305151] XFS (dm-2): Ending clean mount
[   10.242361] IPv6: ADDRCONF(NETDEV_UP): enp1s0: link is not ready
[   10.339596] IPv6: ADDRCONF(NETDEV_UP): enp1s0: link is not ready
[   10.367672] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   10.374758] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   10.403220] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
[   10.410389] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
[   10.437608] IPv6: ADDRCONF(NETDEV_UP): eth2: link is not ready
[   10.444895] IPv6: ADDRCONF(NETDEV_UP): eth2: link is not ready
[   10.471938] IPv6: ADDRCONF(NETDEV_UP): eth3: link is not ready
[   10.478809] IPv6: ADDRCONF(NETDEV_UP): eth3: link is not ready
[   10.562700] IPv6: ADDRCONF(NETDEV_UP): enp1s0: link is not ready
[   10.571438] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   10.580052] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
[   10.588624] IPv6: ADDRCONF(NETDEV_UP): eth2: link is not ready
[   10.597191] IPv6: ADDRCONF(NETDEV_UP): eth3: link is not ready
[   11.412166] xgene-enet APMC0D05:00 eth0: Link is Down
[   11.492472] xgene-enet APMC0D30:00 eth1: Link is Down
[   11.497600] xgene-enet APMC0D30:01 eth2: Link is Down
[   14.533303] e1000e: enp1s0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
[   14.541337] IPv6: ADDRCONF(NETDEV_CHANGE): enp1s0: link becomes ready
[   14.548556] xgene-enet APMC0D05:00 eth0: Link is Up - 1Gbps/Full - flow control off
[   14.556244] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready

--------------602DED4F2879C21F927CAB2C
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--------------602DED4F2879C21F927CAB2C--
