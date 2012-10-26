Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <508A544F.1030007@peak-system.com>
Date: Fri, 26 Oct 2012 11:13:51 +0200
From: Stephane Grosjean <s.grosjean@peak-system.com>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-acpi@vger.kernel.org, support@peak-system.com,
	Robert Hancock <hancockrwd@gmail.com>,
	linux-pci@vger.kernel.org
Subject: Re: Info about ACPI/PCI vs ISA
References: <5062BA8B.7090503@peak-system.com>
 <CAErSpo7vk6d1RCWQPFL9PqqwbH5u+F=uyPywCM_3sAVF3RW34g@mail.gmail.com>
In-Reply-To: <CAErSpo7vk6d1RCWQPFL9PqqwbH5u+F=uyPywCM_3sAVF3RW34g@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------030404090706000905080608"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------030404090706000905080608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi Bjorn,

Thanks for your answer. See my comments below...

Le 26/10/2012 10:29, Bjorn Helgaas a écrit :
> On Wed, Sep 26, 2012 at 2:19 AM, Stephane Grosjean
> <s.grosjean@peak-system.com> wrote:
>
>> I'm working on an issue with one of our PCI adapters.
>> This PCI adapter is a standard and well proven board, for many years:
>>
>> $ lspci -v
>> ...
>> 04:08.0 Network controller: PEAK-System Technik GmbH PCAN-PCI CAN-Bus
>> controller (rev 02)
>>      Subsystem: PEAK-System Technik GmbH 2 Channel CAN Bus SJC1000
>>      Flags: medium devsel, IRQ 11
>>      Memory at f0410000 (32-bit, non-prefetchable) [size=64K]
>>      Memory at f0400000 (32-bit, non-prefetchable) [size=64K]
>>      Kernel driver in use: pcan
>>
>>
> Where's the source for the "pcan" driver?  I see the pcan_usb driver
> in the tree, but that looks like something different from what you're
> looking at here.

The "pcan" driver is an out-ot-tree driver which offers a chardev 
interface, not a mainline driver. The "pcan_usb" (as well as 
peak_pci...) are our recent linux-can (only) drivers.
Since the "pcan" driver does exist since the old ages of 2.4 kernels, we 
need to continue to support it. See also below for more information 
about that...
> Does the device work under any version of Linux?  If so, please
> collect the complete dmesg log from the newest working version, and
> the same log from the broken version.

Yes it does! Anyway, you'll find the complete dmesg.txt attached to that 
e-mail. Hoping this could help.
> Does this adapter work in some systems but not others?  Under Windows
> but not under Linux?  You refer to the "good old" driver, so I infer
> that it works *somewhere* and I'm trying to figure out what's
> different about the case where it doesn't work.

This adapter works under Windows and Linux systems since several years ago.

But in case you want to check some things that could help:

1. you could find pieces of information into 
drivers/net/can/sja1000/peak_pci.c: this mainline driver handles things 
almost like the oot "pcan" driver does
2. you can also have a look to the sources of the "pcan" driver, by 
downloading the tarball from our website:

http://www.peak-system.com/fileadmin/media/linux/files/peak-linux-driver-7.7.tar.gz

In any cases, thanks for your help!

>> My questions are:
>>
>> - why does the system not succeed to "derive" routing for INTA? And why us?
> The derivation is based on ACPI _PRT tables.  Regrettably, we don't
> dump the _PRT contents in dmesg, so we'd need an acpidump to look
> further into that.

Well unfortunately, we are not able to provide this kind of information 
at this moment.

> Bjorn

Stephane.

--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt 
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt 
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391 
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
--
--------------030404090706000905080608
Content-Type: text/plain; charset=windows-1252;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg.txt"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.1.9-1.4-desktop (geeko@buildhost) (gcc version 4.6.2 (SUSE Linux) ) #1 SMP PREEMPT Fri Jan 27 08:55:10 UTC 2012 (efb5ff4)
[    0.000000] Disabled fast string operations
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009d800 (usable)
[    0.000000]  BIOS-e820: 000000000009d800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 0000000020000000 (usable)
[    0.000000]  BIOS-e820: 0000000020000000 - 0000000020200000 (reserved)
[    0.000000]  BIOS-e820: 0000000020200000 - 0000000040000000 (usable)
[    0.000000]  BIOS-e820: 0000000040000000 - 0000000040200000 (reserved)
[    0.000000]  BIOS-e820: 0000000040200000 - 00000000da47c000 (usable)
[    0.000000]  BIOS-e820: 00000000da47c000 - 00000000daeef000 (reserved)
[    0.000000]  BIOS-e820: 00000000daeef000 - 00000000daf9f000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000daf9f000 - 00000000dafff000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000dafff000 - 00000000db000000 (usable)
[    0.000000]  BIOS-e820: 00000000db000000 - 00000000dfa00000 (reserved)
[    0.000000]  BIOS-e820: 00000000f8000000 - 00000000fc000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed08000 - 00000000fed09000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed10000 - 00000000fed1a000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed1c000 - 00000000fed20000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffd80000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 000000011e600000 (usable)
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI 2.6 present.
[    0.000000] DMI: Intel Corporation SugarBay Platform/SCPT_CRB, BIOS LV_67G_Ver_T26 X64 04/05/2012
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> (reserved)
[    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
[    0.000000] last_pfn = 0x11e600 max_arch_pfn = 0x1000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask F80000000 write-back
[    0.000000]   1 base 080000000 mask FC0000000 write-back
[    0.000000]   2 base 0C0000000 mask FE0000000 write-back
[    0.000000]   3 base 0DC000000 mask FFC000000 uncachable
[    0.000000]   4 base 0DB000000 mask FFF000000 uncachable
[    0.000000]   5 base 100000000 mask FE0000000 write-back
[    0.000000]   6 base 11F000000 mask FFF000000 uncachable
[    0.000000]   7 base 11E800000 mask FFF800000 uncachable
[    0.000000]   8 base 11E600000 mask FFFE00000 uncachable
[    0.000000]   9 base 0FFC00000 mask FFFC00000 write-protect
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] found SMP MP-table at [c00f00e0] f00e0
[    0.000000] initial memory mapped : 0 - 01200000
[    0.000000] Base memory trampoline at [c0099000] 99000 size 16384
[    0.000000] init_memory_mapping: 0000000000000000-00000000371fe000
[    0.000000]  0000000000 - 0000200000 page 4k
[    0.000000]  0000200000 - 0037000000 page 2M
[    0.000000]  0037000000 - 00371fe000 page 4k
[    0.000000] kernel direct mapping tables up to 371fe000 @ 11f6000-1200000
[    0.000000] RAMDISK: 1f721000 - 1fff0000
[    0.000000] ACPI: RSDP 000f0100 00024 (v02 PTEC  )
[    0.000000] ACPI: XSDT daffe120 00084 (v01 PTEC   OEMTABLE 00000002 PTEC 00000002)
[    0.000000] ACPI: FACP dafee000 000F4 (v03 PTEC   OEMTABLE 00000002 PTL  00000002)
[    0.000000] ACPI: DSDT daff1000 09D2B (v02 PTEC    SNB-CPT 00000000 INTL 20061109)
[    0.000000] ACPI: FACS daf3e000 00040
[    0.000000] ACPI: SLIC daffd000 00176 (v01 PTEC   OEMTABLE 00000002 PTEC 00000001)
[    0.000000] ACPI: SSDT daffb000 01068 (v01 PTEC   PtidDevc 00001000 INTL 20061109)
[    0.000000] ACPI: ASF! daff0000 000A5 (v32 PTEC   OEMTABLE 00000002 PTL  00000002)
[    0.000000] ACPI: HPET dafed000 00038 (v01 PTEC   OEMTABLE 00000002 PTL  00000002)
[    0.000000] ACPI: APIC dafec000 00098 (v01 PTEC   OEMTABLE 00000002 PTL  00000002)
[    0.000000] ACPI: MCFG dafeb000 0003C (v01 PTEC   OEMTABLE 00000002 PTL  00000002)
[    0.000000] ACPI: SSDT dafea000 0090C (v01  PmRef  Cpu0Ist 00003000 INTL 20061109)
[    0.000000] ACPI: SSDT dafe9000 00996 (v01  PmRef    CpuPm 00003000 INTL 20061109)
[    0.000000] ACPI: UEFI dafe8000 0003E (v01 PTEC   OEMTABLE 00000002 PTL  00000002)
[    0.000000] ACPI: UEFI dafe7000 00042 (v01 PTL      COMBUF 00000001 PTL  00000001)
[    0.000000] ACPI: UEFI dafe6000 00256 (v01 PTEC   OEMTABLE 00000002 PTL  00000002)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-000000011e600000
[    0.000000] node 0 pfn: [0 - 11e600]
[    0.000000] remap_alloc: node 0 [11c200000-11e600000) -> [f4c00000-f7000000)
[    0.000000] Initmem setup node 0 0000000000000000-000000011e600000
[    0.000000]   NODE_DATA [0000000034c00000 - 0000000034c01fff] (remapped)
[    0.000000] 3700MB HIGHMEM available.
[    0.000000] 881MB LOWMEM available.
[    0.000000] max_low_pfn = 371fe, highstart_pfn = 371fe
[    0.000000] Low memory ends at vaddr f71fe000
[    0.000000] High memory starts at vaddr f71fe000
[    0.000000]   mapped low ram: 0 - 371fe000
[    0.000000]   low ram: 0 - 371fe000
[    0.000000] Node: 0, start_pfn: 10, end_pfn: 9d
[    0.000000]   Setting physnode_map array to node 0 for pfns:
[    0.000000]   10 
[    0.000000] Node: 0, start_pfn: 100, end_pfn: 20000
[    0.000000]   Setting physnode_map array to node 0 for pfns:
[    0.000000]   100 4100 8100 c100 10100 14100 18100 1c100 
[    0.000000] Node: 0, start_pfn: 20200, end_pfn: 40000
[    0.000000]   Setting physnode_map array to node 0 for pfns:
[    0.000000]   20200 24200 28200 2c200 30200 34200 38200 3c200 
[    0.000000] Node: 0, start_pfn: 40200, end_pfn: da47c
[    0.000000]   Setting physnode_map array to node 0 for pfns:
[    0.000000]   40200 44200 48200 4c200 50200 54200 58200 5c200 60200 64200 68200 6c200 70200 74200 78200 7c200 80200 84200 88200 8c200 90200 94200 98200 9c200 a0200 a4200 a8200 ac200 b0200 b4200 b8200 bc200 c0200 c4200 c8200 cc200 d0200 d4200 d8200 
[    0.000000] Node: 0, start_pfn: dafff, end_pfn: db000
[    0.000000]   Setting physnode_map array to node 0 for pfns:
[    0.000000]   dafff 
[    0.000000] Node: 0, start_pfn: 100000, end_pfn: 11e600
[    0.000000]   Setting physnode_map array to node 0 for pfns:
[    0.000000]   100000 104000 108000 10c000 110000 114000 118000 11c000 
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   Normal   0x00001000 -> 0x000371fe
[    0.000000]   HighMem  0x000371fe -> 0x0011e600
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[6] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009d
[    0.000000]     0: 0x00000100 -> 0x00020000
[    0.000000]     0: 0x00020200 -> 0x00040000
[    0.000000]     0: 0x00040200 -> 0x000da47c
[    0.000000]     0: 0x000dafff -> 0x000db000
[    0.000000]     0: 0x00100000 -> 0x0011e600
[    0.000000] On node 0 totalpages: 1017354
[    0.000000] free_area_init_node: node 0, pgdat f4c00000, node_mem_map f4c02200
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3949 pages, LIFO batch:0
[    0.000000]   Normal zone: 1732 pages used for memmap
[    0.000000]   Normal zone: 219450 pages, LIFO batch:31
[    0.000000]   HighMem zone: 7401 pages used for memmap
[    0.000000]   HighMem zone: 784790 pages, LIFO batch:31
[    0.000000] Using APIC driver default
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x04] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x06] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x0e] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 14, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a301 base: 0xfed00000
[    0.000000] SMP: Allowing 8 CPUs, 4 hotplug CPUs
[    0.000000] nr_irqs_gsi: 40
[    0.000000] PM: Registered nosave memory: 000000000009d000 - 000000000009e000
[    0.000000] PM: Registered nosave memory: 000000000009e000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
[    0.000000] PM: Registered nosave memory: 0000000020000000 - 0000000020200000
[    0.000000] Allocating PCI resources starting at dfa00000 (gap: dfa00000:18600000)
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:128 nr_cpumask_bits:128 nr_cpu_ids:8 nr_node_ids:1
[    0.000000] PERCPU: Embedded 13 pages/cpu @f4a00000 s30144 r0 d23104 u262144
[    0.000000] pcpu-alloc: s30144 r0 d23104 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1008189
[    0.000000] Policy zone: HighMem
[    0.000000] Kernel command line: root=/dev/disk/by-id/ata-SPCC_Solid_State_DiskB28_00000000000000000015-part2 resume=/dev/disk/by-id/ata-SPCC_Solid_State_DiskB28_00000000000000000015-part1 splash=silent quiet vga=0x31b
[    0.000000] bootsplash: silent mode.
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Initializing CPU#0
[    0.000000] xsave/xrstor: enabled xstate_bv 0x7, cntxt size 0x340
[    0.000000] allocated 18767616 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
[    0.000000] Initializing HighMem for node 0 (000371fe:0011e600)
[    0.000000] Memory: 3956396k/4691968k available (5190k kernel code, 76156k reserved, 3876k data, 488k init, 3131900k highmem)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xff5b4000 - 0xfffff000   (10540 kB)
[    0.000000]     pkmap   : 0xff200000 - 0xff400000   (2048 kB)
[    0.000000]     vmalloc : 0xf79fe000 - 0xff1fe000   ( 120 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf71fe000   ( 881 MB)
[    0.000000]       .init : 0xc0adb000 - 0xc0b55000   ( 488 kB)
[    0.000000]       .data : 0xc071198c - 0xc0adab00   (3876 kB)
[    0.000000]       .text : 0xc0200000 - 0xc071198c   (5190 kB)
[    0.000000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] NR_IRQS:8448 nr_irqs:744 16
[    0.000000] CPU 0 irqstacks, hard=f340a000 soft=f340c000
[    0.000000] Extended CMOS year: 2000
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] hpet clockevent registered
[    0.000000] Fast TSC calibration using PIT
[    0.001000] Detected 2793.544 MHz processor.
[    0.000001] Calibrating delay loop (skipped), value calculated using timer frequency.. 5587.08 BogoMIPS (lpj=2793544)
[    0.000004] pid_max: default: 32768 minimum: 301
[    0.000027] Security Framework initialized
[    0.000038] AppArmor: AppArmor initialized
[    0.000071] Mount-cache hash table entries: 512
[    0.000151] Initializing cgroup subsys cpuacct
[    0.000155] Initializing cgroup subsys memory
[    0.000162] Initializing cgroup subsys devices
[    0.000163] Initializing cgroup subsys freezer
[    0.000174] Initializing cgroup subsys net_cls
[    0.000175] Initializing cgroup subsys blkio
[    0.000180] Initializing cgroup subsys perf_event
[    0.000201] Disabled fast string operations
[    0.000203] CPU: Physical Processor ID: 0
[    0.000204] CPU: Processor Core ID: 0
[    0.000207] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.000208] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.000210] mce: CPU supports 9 MCE banks
[    0.000222] CPU0: Thermal monitoring enabled (TM1)
[    0.000229] using mwait in idle threads.
[    0.000957] ACPI: Core revision 20110623
[    0.007392] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.007724] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.017710] CPU0: Intel(R) Core(TM) i5-2300 CPU @ 2.80GHz stepping 07
[    0.118992] Performance Events: PEBS fmt1+, SandyBridge events, Intel PMU driver.
[    0.118997] ... version:                3
[    0.118998] ... bit width:              48
[    0.118999] ... generic registers:      8
[    0.119000] ... value mask:             0000ffffffffffff
[    0.119001] ... max period:             000000007fffffff
[    0.119002] ... fixed-purpose events:   3
[    0.119003] ... event mask:             00000007000000ff
[    0.127505] NMI watchdog enabled, takes one hw-pmu counter.
[    0.134982] CPU 1 irqstacks, hard=f354e000 soft=f3550000
[    0.134985] Booting Node   0, Processors  #1
[    0.134988] smpboot cpu 1: start_ip = 99000
[    0.145638] Initializing CPU#1
[    0.205859] Disabled fast string operations
[    0.225922] NMI watchdog enabled, takes one hw-pmu counter.
[    0.231832] CPU 2 irqstacks, hard=f3566000 soft=f3568000
[    0.231835]  #2
[    0.231837] smpboot cpu 2: start_ip = 99000
[    0.242158] Initializing CPU#2
[    0.302702] Disabled fast string operations
[    0.322767] NMI watchdog enabled, takes one hw-pmu counter.
[    0.328674] CPU 3 irqstacks, hard=f359c000 soft=f359e000
[    0.328677]  #3
[    0.328678] smpboot cpu 3: start_ip = 99000
[    0.339000] Initializing CPU#3
[    0.399544] Disabled fast string operations
[    0.419609] NMI watchdog enabled, takes one hw-pmu counter.
[    0.421506] Brought up 4 CPUs
[    0.421509] Total of 4 processors activated (22346.87 BogoMIPS).
[    0.423706] devtmpfs: initialized
[    0.423826] PM: Registering ACPI NVS region at daeef000 (720896 bytes)
[    0.423964] print_constraints: dummy: 
[    0.423994] RTC time:  7:32:29, date: 09/24/12
[    0.424028] NET: Registered protocol family 16
[    0.424193] ACPI: bus type pci registered
[    0.424249] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.424252] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.424253] PCI: Using MMCONFIG for extended config space
[    0.424254] PCI: Using configuration type 1 for base access
[    0.425105] bio: create slab <bio-0> at 0
[    0.425169] ACPI: Added _OSI(Module Device)
[    0.425170] ACPI: Added _OSI(Processor Device)
[    0.425172] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.425173] ACPI: Added _OSI(Processor Aggregator Device)
[    0.426885] ACPI: EC: Look up EC in DSDT
[    0.428846] ACPI: Executed 1 blocks of module-level executable AML code
[    0.438521] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.438978] ACPI: SSDT daee0798 00727 (v01  PmRef  Cpu0Cst 00003001 INTL 20061109)
[    0.439431] ACPI: Dynamic OEM Table Load:
[    0.439433] ACPI: SSDT   (null) 00727 (v01  PmRef  Cpu0Cst 00003001 INTL 20061109)
[    0.441806] ACPI: SSDT daee1a98 00303 (v01  PmRef    ApIst 00003000 INTL 20061109)
[    0.442309] ACPI: Dynamic OEM Table Load:
[    0.442311] ACPI: SSDT   (null) 00303 (v01  PmRef    ApIst 00003000 INTL 20061109)
[    0.444690] ACPI: SSDT daedfd98 00119 (v01  PmRef    ApCst 00003000 INTL 20061109)
[    0.445133] ACPI: Dynamic OEM Table Load:
[    0.445135] ACPI: SSDT   (null) 00119 (v01  PmRef    ApCst 00003000 INTL 20061109)
[    0.448271] ACPI: Interpreter enabled
[    0.448277] ACPI: (supports S0 S3 S4 S5)
[    0.448297] ACPI: Using IOAPIC for interrupt routing
[    0.457014] ACPI: Power Resource [FN00] (off)
[    0.457104] ACPI: Power Resource [FN01] (off)
[    0.457194] ACPI: Power Resource [FN02] (off)
[    0.457282] ACPI: Power Resource [FN03] (off)
[    0.457370] ACPI: Power Resource [FN04] (off)
[    0.458091] ACPI: ACPI Dock Station Driver: 1 docks/bays found
[    0.458093] HEST: Table not found.
[    0.458095] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.458793] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    0.459530] pci_root PNP0A08:00: host bridge window [io  0x0000-0x0cf7]
[    0.459533] pci_root PNP0A08:00: host bridge window [io  0x0d00-0xffff]
[    0.459534] pci_root PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff]
[    0.459537] pci_root PNP0A08:00: host bridge window [mem 0xdfa00000-0xfeafffff]
[    0.459539] pci_root PNP0A08:00: host bridge window [mem 0xfed40000-0xfed44fff]
[    0.459550] pci 0000:00:00.0: [8086:0100] type 0 class 0x000600
[    0.459581] pci 0000:00:02.0: [8086:0102] type 0 class 0x000300
[    0.459590] pci 0000:00:02.0: reg 10: [mem 0xf0000000-0xf03fffff 64bit]
[    0.459596] pci 0000:00:02.0: reg 18: [mem 0xe0000000-0xefffffff 64bit pref]
[    0.459600] pci 0000:00:02.0: reg 20: [io  0x4000-0x403f]
[    0.459648] pci 0000:00:16.0: [8086:1c3a] type 0 class 0x000780
[    0.459670] pci 0000:00:16.0: reg 10: [mem 0xf0705000-0xf070500f 64bit]
[    0.459731] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.459736] pci 0000:00:16.0: PME# disabled
[    0.459768] pci 0000:00:1a.0: [8086:1c2d] type 0 class 0x000c03
[    0.459788] pci 0000:00:1a.0: reg 10: [mem 0xf0709000-0xf07093ff]
[    0.459860] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    0.459864] pci 0000:00:1a.0: PME# disabled
[    0.459889] pci 0000:00:1b.0: [8086:1c20] type 0 class 0x000403
[    0.459904] pci 0000:00:1b.0: reg 10: [mem 0xf0700000-0xf0703fff 64bit]
[    0.459957] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.459961] pci 0000:00:1b.0: PME# disabled
[    0.459987] pci 0000:00:1c.0: [8086:1c10] type 1 class 0x000604
[    0.460089] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.460093] pci 0000:00:1c.0: PME# disabled
[    0.460132] pci 0000:00:1c.4: [8086:1c18] type 1 class 0x000604
[    0.460232] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.460238] pci 0000:00:1c.4: PME# disabled
[    0.460273] pci 0000:00:1c.5: [8086:1c1a] type 1 class 0x000604
[    0.460374] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    0.460379] pci 0000:00:1c.5: PME# disabled
[    0.460415] pci 0000:00:1d.0: [8086:1c26] type 0 class 0x000c03
[    0.460435] pci 0000:00:1d.0: reg 10: [mem 0xf0708000-0xf07083ff]
[    0.460510] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.460514] pci 0000:00:1d.0: PME# disabled
[    0.460534] pci 0000:00:1e.0: [8086:244e] type 1 class 0x000604
[    0.460591] pci 0000:00:1f.0: [8086:1c4e] type 0 class 0x000601
[    0.460700] pci 0000:00:1f.2: [8086:1c00] type 0 class 0x000101
[    0.460714] pci 0000:00:1f.2: reg 10: [io  0x40b8-0x40bf]
[    0.460722] pci 0000:00:1f.2: reg 14: [io  0x40cc-0x40cf]
[    0.460730] pci 0000:00:1f.2: reg 18: [io  0x40b0-0x40b7]
[    0.460738] pci 0000:00:1f.2: reg 1c: [io  0x40c8-0x40cb]
[    0.460746] pci 0000:00:1f.2: reg 20: [io  0x4090-0x409f]
[    0.460754] pci 0000:00:1f.2: reg 24: [io  0x4080-0x408f]
[    0.460790] pci 0000:00:1f.3: [8086:1c22] type 0 class 0x000c05
[    0.460805] pci 0000:00:1f.3: reg 10: [mem 0xf0704000-0xf07040ff 64bit]
[    0.460826] pci 0000:00:1f.3: reg 20: [io  0xefa0-0xefbf]
[    0.460858] pci 0000:00:1f.5: [8086:1c08] type 0 class 0x000101
[    0.460872] pci 0000:00:1f.5: reg 10: [io  0x40a8-0x40af]
[    0.460880] pci 0000:00:1f.5: reg 14: [io  0x40c4-0x40c7]
[    0.460888] pci 0000:00:1f.5: reg 18: [io  0x40a0-0x40a7]
[    0.460896] pci 0000:00:1f.5: reg 1c: [io  0x40c0-0x40c3]
[    0.460904] pci 0000:00:1f.5: reg 20: [io  0x4070-0x407f]
[    0.460912] pci 0000:00:1f.5: reg 24: [io  0x4060-0x406f]
[    0.461012] pci 0000:00:1c.0: PCI bridge to [bus 01-01]
[    0.461202] pci 0000:02:00.0: [8086:10d3] type 0 class 0x000200
[    0.461244] pci 0000:02:00.0: reg 10: [mem 0xf0600000-0xf061ffff]
[    0.461292] pci 0000:02:00.0: reg 18: [io  0x3000-0x301f]
[    0.461318] pci 0000:02:00.0: reg 1c: [mem 0xf0620000-0xf0623fff]
[    0.461390] pci 0000:02:00.0: reg 30: [mem 0xfffff800-0xffffffff pref]
[    0.461474] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.461484] pci 0000:02:00.0: PME# disabled
[    0.463528] pci 0000:00:1c.4: PCI bridge to [bus 02-02]
[    0.463533] pci 0000:00:1c.4:   bridge window [io  0x3000-0x3fff]
[    0.463537] pci 0000:00:1c.4:   bridge window [mem 0xf0600000-0xf06fffff]
[    0.463701] pci 0000:03:00.0: [8086:10d3] type 0 class 0x000200
[    0.463737] pci 0000:03:00.0: reg 10: [mem 0xf0500000-0xf051ffff]
[    0.463786] pci 0000:03:00.0: reg 18: [io  0x2000-0x201f]
[    0.463812] pci 0000:03:00.0: reg 1c: [mem 0xf0520000-0xf0523fff]
[    0.463884] pci 0000:03:00.0: reg 30: [mem 0xfffff800-0xffffffff pref]
[    0.463965] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    0.463975] pci 0000:03:00.0: PME# disabled
[    0.465522] pci 0000:00:1c.5: PCI bridge to [bus 03-03]
[    0.465527] pci 0000:00:1c.5:   bridge window [io  0x2000-0x2fff]
[    0.465531] pci 0000:00:1c.5:   bridge window [mem 0xf0500000-0xf05fffff]
[    0.465574] pci 0000:04:08.0: [001c:0001] type 0 class 0x000280
[    0.465587] pci 0000:04:08.0: reg 10: [mem 0xf0410000-0xf041ffff]
[    0.465597] pci 0000:04:08.0: reg 14: [mem 0xf0400000-0xf040ffff]
[    0.465670] pci 0000:00:1e.0: PCI bridge to [bus 04-04] (subtractive decode)
[    0.465675] pci 0000:00:1e.0:   bridge window [mem 0xf0400000-0xf04fffff]
[    0.465682] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7] (subtractive decode)
[    0.465683] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff] (subtractive decode)
[    0.465685] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
[    0.465687] pci 0000:00:1e.0:   bridge window [mem 0xdfa00000-0xfeafffff] (subtractive decode)
[    0.465689] pci 0000:00:1e.0:   bridge window [mem 0xfed40000-0xfed44fff] (subtractive decode)
[    0.465718] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.465888] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
[    0.466001] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
[    0.466050] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP05._PRT]
[    0.466094] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP06._PRT]
[    0.466370]  pci0000:00: Requesting ACPI _OSC control (0x1d)
[    0.466778]  pci0000:00: ACPI _OSC control (0x1d) granted
[    0.471267] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 10 *11 12 14 15)
[    0.471323] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 10 11 12 14 15) *7
[    0.471378] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 10 11 12 14 15) *7
[    0.471434] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 *10 11 12 14 15)
[    0.471487] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.471541] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.471594] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 *10 11 12 14 15)
[    0.471647] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 10 *11 12 14 15)
[    0.471712] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.471720] vgaarb: loaded
[    0.471721] vgaarb: bridge control possible 0000:00:02.0
[    0.471848] SCSI subsystem initialized
[    0.471880] libata version 3.00 loaded.
[    0.471918] usbcore: registered new interface driver usbfs
[    0.471930] usbcore: registered new interface driver hub
[    0.471947] usbcore: registered new device driver usb
[    0.472000] PCI: Using ACPI for IRQ routing
[    0.473486] PCI: pci_cache_line_size set to 64 bytes
[    0.473812] reserve RAM buffer: 000000000009d800 - 000000000009ffff 
[    0.473814] reserve RAM buffer: 00000000da47c000 - 00000000dbffffff 
[    0.473816] reserve RAM buffer: 00000000db000000 - 00000000dbffffff 
[    0.473818] reserve RAM buffer: 000000011e600000 - 000000011fffffff 
[    0.473892] NetLabel: Initializing
[    0.473893] NetLabel:  domain hash size = 128
[    0.473894] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.473902] NetLabel:  unlabeled traffic allowed by default
[    0.473911] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.473915] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.475932] Switching to clocksource hpet
[    0.476419] Switched to NOHz mode on CPU #0
[    0.476505] Switched to NOHz mode on CPU #1
[    0.476508] Switched to NOHz mode on CPU #2
[    0.476510] Switched to NOHz mode on CPU #3
[    0.477892] AppArmor: AppArmor Filesystem Enabled
[    0.477904] pnp: PnP ACPI init
[    0.477912] ACPI: bus type pnp registered
[    0.478295] pnp 00:00: [bus 00-3e]
[    0.478297] pnp 00:00: [io  0x0000-0x0cf7 window]
[    0.478299] pnp 00:00: [io  0x0cf8-0x0cff]
[    0.478300] pnp 00:00: [io  0x0d00-0xffff window]
[    0.478302] pnp 00:00: [mem 0x000a0000-0x000bffff window]
[    0.478304] pnp 00:00: [mem 0x000c0000-0x000c3fff window]
[    0.478305] pnp 00:00: [mem 0x000c4000-0x000c7fff window]
[    0.478307] pnp 00:00: [mem 0x000c8000-0x000cbfff window]
[    0.478308] pnp 00:00: [mem 0x000cc000-0x000cffff window]
[    0.478310] pnp 00:00: [mem 0x000d0000-0x000d3fff window]
[    0.478312] pnp 00:00: [mem 0x000d4000-0x000d7fff window]
[    0.478313] pnp 00:00: [mem 0x000d8000-0x000dbfff window]
[    0.478315] pnp 00:00: [mem 0x000dc000-0x000dffff window]
[    0.478316] pnp 00:00: [mem 0x000e0000-0x000e3fff window]
[    0.478318] pnp 00:00: [mem 0x000e4000-0x000e7fff window]
[    0.478319] pnp 00:00: [mem 0x000e8000-0x000ebfff window]
[    0.478321] pnp 00:00: [mem 0x000ec000-0x000effff window]
[    0.478322] pnp 00:00: [mem 0x000f0000-0x000fffff window]
[    0.478324] pnp 00:00: [mem 0xdfa00000-0xfeafffff window]
[    0.478325] pnp 00:00: [mem 0xfed40000-0xfed44fff window]
[    0.478368] pnp 00:00: Plug and Play ACPI device, IDs PNP0a08 PNP0a03 (active)
[    0.478398] pnp 00:01: [io  0x0000-0x001f]
[    0.478400] pnp 00:01: [io  0x0081-0x0091]
[    0.478401] pnp 00:01: [io  0x0093-0x009f]
[    0.478402] pnp 00:01: [io  0x00c0-0x00df]
[    0.478404] pnp 00:01: [dma 4]
[    0.478423] pnp 00:01: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.478431] pnp 00:02: [mem 0xff000000-0xffffffff]
[    0.478449] pnp 00:02: Plug and Play ACPI device, IDs INT0800 (active)
[    0.478519] pnp 00:03: [mem 0xfed00000-0xfed003ff]
[    0.478539] pnp 00:03: Plug and Play ACPI device, IDs PNP0103 (active)
[    0.478549] pnp 00:04: [io  0x00f0]
[    0.478555] pnp 00:04: [irq 13]
[    0.478574] pnp 00:04: Plug and Play ACPI device, IDs PNP0c04 (active)
[    0.478583] pnp 00:05: [io  0x002e-0x002f]
[    0.478585] pnp 00:05: [io  0x004e-0x004f]
[    0.478586] pnp 00:05: [io  0x0061]
[    0.478587] pnp 00:05: [io  0x0063]
[    0.478589] pnp 00:05: [io  0x0065]
[    0.478590] pnp 00:05: [io  0x0067]
[    0.478591] pnp 00:05: [io  0x0070]
[    0.478592] pnp 00:05: [io  0x0080]
[    0.478593] pnp 00:05: [io  0x0092]
[    0.478595] pnp 00:05: [io  0x00b2-0x00b3]
[    0.478597] pnp 00:05: [io  0x0680-0x069f]
[    0.478598] pnp 00:05: [io  0x1000-0x100f]
[    0.478600] pnp 00:05: [io  0xffff]
[    0.478601] pnp 00:05: [io  0xffff]
[    0.478602] pnp 00:05: [io  0x0400-0x0453]
[    0.478603] pnp 00:05: [io  0x0458-0x047f]
[    0.478605] pnp 00:05: [io  0x0500-0x057f]
[    0.478606] pnp 00:05: [io  0x164e-0x164f]
[    0.478644] system 00:05: [io  0x0680-0x069f] has been reserved
[    0.478646] system 00:05: [io  0x1000-0x100f] has been reserved
[    0.478648] system 00:05: [io  0xffff] has been reserved
[    0.478650] system 00:05: [io  0xffff] has been reserved
[    0.478651] system 00:05: [io  0x0400-0x0453] has been reserved
[    0.478653] system 00:05: [io  0x0458-0x047f] has been reserved
[    0.478655] system 00:05: [io  0x0500-0x057f] has been reserved
[    0.478657] system 00:05: [io  0x164e-0x164f] has been reserved
[    0.478659] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.478668] pnp 00:06: [io  0x0070-0x0077]
[    0.478672] pnp 00:06: [irq 8]
[    0.478691] pnp 00:06: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.478718] pnp 00:07: [io  0x0454-0x0457]
[    0.478749] system 00:07: [io  0x0454-0x0457] has been reserved
[    0.478751] system 00:07: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
[    0.478995] pnp 00:08: [io  0x0378-0x037f]
[    0.478999] pnp 00:08: [irq 7]
[    0.479078] pnp 00:08: Plug and Play ACPI device, IDs PNP0400 (active)
[    0.479230] pnp 00:09: [io  0x03f8-0x03ff]
[    0.479235] pnp 00:09: [irq 4]
[    0.479264] pnp 00:09: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.479429] pnp 00:0a: [io  0x02f8-0x02ff]
[    0.479433] pnp 00:0a: [irq 3]
[    0.479462] pnp 00:0a: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.479672] pnp 00:0b: [io  0x03e8-0x03ef]
[    0.479673] pnp 00:0b: IRQ 11 override to edge, high
[    0.479677] pnp 00:0b: [irq 11]
[    0.479716] pnp 00:0b: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.479878] pnp 00:0c: [io  0x02e8-0x02ef]
[    0.479879] pnp 00:0c: IRQ 11 override to edge, high
[    0.479881] pnp 00:0c: [irq 11]
[    0.479918] pnp 00:0c: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.480088] pnp 00:0d: [io  0x04f8-0x04ff]
[    0.480090] pnp 00:0d: IRQ 11 override to edge, high
[    0.480091] pnp 00:0d: [irq 11]
[    0.480128] pnp 00:0d: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.480291] pnp 00:0e: [io  0x04e8-0x04ef]
[    0.480293] pnp 00:0e: IRQ 11 override to edge, high
[    0.480294] pnp 00:0e: [irq 11]
[    0.480331] pnp 00:0e: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.480361] pnp 00:0f: [io  0x0060]
[    0.480363] pnp 00:0f: [io  0x0064]
[    0.480367] pnp 00:0f: [irq 1]
[    0.480390] pnp 00:0f: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.480422] pnp 00:10: [irq 12]
[    0.480444] pnp 00:10: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.480576] pnp 00:11: [mem 0xfed1c000-0xfed1ffff]
[    0.480578] pnp 00:11: [mem 0xfed10000-0xfed17fff]
[    0.480579] pnp 00:11: [mem 0xfed18000-0xfed18fff]
[    0.480581] pnp 00:11: [mem 0xfed19000-0xfed19fff]
[    0.480582] pnp 00:11: [mem 0xf8000000-0xfbffffff]
[    0.480583] pnp 00:11: [mem 0xfed20000-0xfed3ffff]
[    0.480585] pnp 00:11: [mem 0xfed90000-0xfed93fff]
[    0.480586] pnp 00:11: [mem 0xfed45000-0xfed8ffff]
[    0.480588] pnp 00:11: [mem 0xff000000-0xffffffff]
[    0.480589] pnp 00:11: [mem 0xfee00000-0xfeefffff]
[    0.480591] pnp 00:11: [mem 0x00000000-0xffffffffffffffff disabled]
[    0.480629] system 00:11: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.480631] system 00:11: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.480633] system 00:11: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.480635] system 00:11: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.480637] system 00:11: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.480639] system 00:11: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.480641] system 00:11: [mem 0xfed90000-0xfed93fff] has been reserved
[    0.480643] system 00:11: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.480646] system 00:11: [mem 0xff000000-0xffffffff] could not be reserved
[    0.480648] system 00:11: [mem 0xfee00000-0xfeefffff] could not be reserved
[    0.480650] system 00:11: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.480919] pnp 00:12: [mem 0x20000000-0x201fffff]
[    0.480920] pnp 00:12: [mem 0x40000000-0x401fffff]
[    0.480968] system 00:12: [mem 0x20000000-0x201fffff] has been reserved
[    0.480978] system 00:12: [mem 0x40000000-0x401fffff] has been reserved
[    0.480980] system 00:12: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.481003] pnp: PnP ACPI: found 19 devices
[    0.481004] ACPI: ACPI bus type pnp unregistered
[    0.517493] pci 0000:02:00.0: no compatible bridge window for [mem 0xfffff800-0xffffffff pref]
[    0.517496] pci 0000:03:00.0: no compatible bridge window for [mem 0xfffff800-0xffffffff pref]
[    0.517498] PCI: max bus depth: 1 pci_try_num: 2
[    0.517542] pci 0000:00:1c.4: BAR 15: assigned [mem 0xdfa00000-0xdfafffff pref]
[    0.517545] pci 0000:00:1c.5: BAR 15: assigned [mem 0xdfb00000-0xdfbfffff pref]
[    0.517547] pci 0000:00:1c.0: PCI bridge to [bus 01-01]
[    0.517565] pci 0000:02:00.0: BAR 6: assigned [mem 0xdfa00000-0xdfa007ff pref]
[    0.517567] pci 0000:00:1c.4: PCI bridge to [bus 02-02]
[    0.517570] pci 0000:00:1c.4:   bridge window [io  0x3000-0x3fff]
[    0.517577] pci 0000:00:1c.4:   bridge window [mem 0xf0600000-0xf06fffff]
[    0.517582] pci 0000:00:1c.4:   bridge window [mem 0xdfa00000-0xdfafffff pref]
[    0.517591] pci 0000:03:00.0: BAR 6: assigned [mem 0xdfb00000-0xdfb007ff pref]
[    0.517592] pci 0000:00:1c.5: PCI bridge to [bus 03-03]
[    0.517595] pci 0000:00:1c.5:   bridge window [io  0x2000-0x2fff]
[    0.517602] pci 0000:00:1c.5:   bridge window [mem 0xf0500000-0xf05fffff]
[    0.517607] pci 0000:00:1c.5:   bridge window [mem 0xdfb00000-0xdfbfffff pref]
[    0.517615] pci 0000:00:1e.0: PCI bridge to [bus 04-04]
[    0.517620] pci 0000:00:1e.0:   bridge window [mem 0xf0400000-0xf04fffff]
[    0.517637] pci 0000:00:1c.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    0.517643] pci 0000:00:1c.0: setting latency timer to 64
[    0.517650] pci 0000:00:1c.4: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    0.517655] pci 0000:00:1c.4: setting latency timer to 64
[    0.517664] pci 0000:00:1c.5: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[    0.517669] pci 0000:00:1c.5: setting latency timer to 64
[    0.517676] pci 0000:00:1e.0: setting latency timer to 64
[    0.517679] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    0.517681] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    0.517682] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    0.517684] pci_bus 0000:00: resource 7 [mem 0xdfa00000-0xfeafffff]
[    0.517686] pci_bus 0000:00: resource 8 [mem 0xfed40000-0xfed44fff]
[    0.517687] pci_bus 0000:02: resource 0 [io  0x3000-0x3fff]
[    0.517689] pci_bus 0000:02: resource 1 [mem 0xf0600000-0xf06fffff]
[    0.517691] pci_bus 0000:02: resource 2 [mem 0xdfa00000-0xdfafffff pref]
[    0.517692] pci_bus 0000:03: resource 0 [io  0x2000-0x2fff]
[    0.517694] pci_bus 0000:03: resource 1 [mem 0xf0500000-0xf05fffff]
[    0.517695] pci_bus 0000:03: resource 2 [mem 0xdfb00000-0xdfbfffff pref]
[    0.517697] pci_bus 0000:04: resource 1 [mem 0xf0400000-0xf04fffff]
[    0.517698] pci_bus 0000:04: resource 4 [io  0x0000-0x0cf7]
[    0.517700] pci_bus 0000:04: resource 5 [io  0x0d00-0xffff]
[    0.517701] pci_bus 0000:04: resource 6 [mem 0x000a0000-0x000bffff]
[    0.517703] pci_bus 0000:04: resource 7 [mem 0xdfa00000-0xfeafffff]
[    0.517705] pci_bus 0000:04: resource 8 [mem 0xfed40000-0xfed44fff]
[    0.517754] NET: Registered protocol family 2
[    0.517809] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.517998] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.518171] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[    0.518250] TCP: Hash tables configured (established 131072 bind 65536)
[    0.518252] TCP reno registered
[    0.518254] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.518258] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.518333] NET: Registered protocol family 1
[    0.518341] pci 0000:00:02.0: Boot video device
[    0.518529] PCI: CLS 64 bytes, default 64
[    0.518560] Unpacking initramfs...
[    0.664659] Freeing initrd memory: 9020k freed
[    0.667122] audit: initializing netlink socket (disabled)
[    0.667132] type=2000 audit(1348471948.508:1): initialized
[    0.686264] highmem bounce pool size: 64 pages
[    0.686269] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.693819] VFS: Disk quotas dquot_6.5.2
[    0.693846] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.694043] msgmni has been set to 1627
[    0.694208] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.694230] io scheduler noop registered
[    0.694232] io scheduler deadline registered
[    0.694246] io scheduler cfq registered (default)
[    0.694349] pcieport 0000:00:1c.0: setting latency timer to 64
[    0.694415] pcieport 0000:00:1c.0: irq 40 for MSI/MSI-X
[    0.694515] pcieport 0000:00:1c.4: setting latency timer to 64
[    0.694576] pcieport 0000:00:1c.4: irq 41 for MSI/MSI-X
[    0.694680] pcieport 0000:00:1c.5: setting latency timer to 64
[    0.694743] pcieport 0000:00:1c.5: irq 42 for MSI/MSI-X
[    0.694857] pcieport 0000:00:1c.0: Signaling PME through PCIe PME interrupt
[    0.694863] pcie_pme 0000:00:1c.0:pcie01: service driver pcie_pme loaded
[    0.694885] pcieport 0000:00:1c.4: Signaling PME through PCIe PME interrupt
[    0.694886] pci 0000:02:00.0: Signaling PME through PCIe PME interrupt
[    0.694891] pcie_pme 0000:00:1c.4:pcie01: service driver pcie_pme loaded
[    0.694911] pcieport 0000:00:1c.5: Signaling PME through PCIe PME interrupt
[    0.694913] pci 0000:03:00.0: Signaling PME through PCIe PME interrupt
[    0.694917] pcie_pme 0000:00:1c.5:pcie01: service driver pcie_pme loaded
[    0.694974] vesafb: mode is 1280x1024x32, linelength=5120, pages=11
[    0.694975] vesafb: scrolling: redraw
[    0.694976] vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.695817] vesafb: framebuffer at 0xe0000000, mapped to 0xf7a80000, using 10240k, total 65472k
[    0.695937] bootsplash 3.2.0-2010/03/31: looking for picture...
[    0.695938] bootsplash: silentjpeg size 109002 bytes
[    0.707623] bootsplash: ...found (1280x1024, 40442 bytes, v3).
[    0.817438] Console: switching to colour frame buffer device 156x60
[    0.926829] fb0: VESA VGA frame buffer device
[    0.926862] intel_idle: MWAIT substates: 0x1120
[    0.926863] intel_idle: v0.4 model 0x2A
[    0.926864] intel_idle: lapic_timer_reliable_states 0xffffffff
[    0.926916] ERST: Table is not found!
[    0.926917] GHES: HEST is not enabled!
[    0.926985] Serial: 8250/16550 driver, 8 ports, IRQ sharing disabled
[    0.947540] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.976835] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[    1.008772] serial8250: ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
[    1.040699] serial8250: ttyS3 at I/O 0x2e8 (irq = 3) is a 16550A
[    1.136706] 00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    1.165559] 00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[    1.194520] 00:0b: ttyS2 at I/O 0x3e8 (irq = 11) is a 16550A
[    1.223505] 00:0c: ttyS3 at I/O 0x2e8 (irq = 11) is a 16550A
[    1.252456] 00:0d: ttyS4 at I/O 0x4f8 (irq = 11) is a 16550A
[    1.281382] 00:0e: ttyS5 at I/O 0x4e8 (irq = 11) is a 16550A
[    1.290038] Non-volatile memory driver v1.3
[    1.290039] Linux agpgart interface v0.103
[    1.290135] agpgart-intel 0000:00:00.0: Intel Sandybridge Chipset
[    1.290184] agpgart-intel 0000:00:00.0: detected gtt size: 2097152K total, 262144K mappable
[    1.291134] agpgart-intel 0000:00:00.0: detected 65536K stolen memory
[    1.291242] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xe0000000
[    1.291368] ata_piix 0000:00:1f.2: version 2.13
[    1.291386] ata_piix 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    1.291391] ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
[    1.441602] ata_piix 0000:00:1f.2: setting latency timer to 64
[    1.441840] scsi0 : ata_piix
[    1.441912] scsi1 : ata_piix
[    1.441974] ata1: SATA max UDMA/133 cmd 0x40b8 ctl 0x40cc bmdma 0x4090 irq 19
[    1.441979] ata2: SATA max UDMA/133 cmd 0x40b0 ctl 0x40c8 bmdma 0x4098 irq 19
[    1.441993] ata_piix 0000:00:1f.5: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    1.441997] ata_piix 0000:00:1f.5: MAP [ P0 -- P1 -- ]
[    1.592347] ata_piix 0000:00:1f.5: SCR access via SIDPR is available but doesn't work
[    1.592359] ata_piix 0000:00:1f.5: setting latency timer to 64
[    1.592534] scsi2 : ata_piix
[    1.592588] scsi3 : ata_piix
[    1.592620] ata3: SATA max UDMA/133 cmd 0x40a8 ctl 0x40c4 bmdma 0x4070 irq 19
[    1.592621] ata4: SATA max UDMA/133 cmd 0x40a0 ctl 0x40c0 bmdma 0x4078 irq 19
[    1.592672] Fixed MDIO Bus: probed
[    1.592675] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.592686] ehci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.592698] ehci_hcd 0000:00:1a.0: setting latency timer to 64
[    1.592702] ehci_hcd 0000:00:1a.0: EHCI Host Controller
[    1.592717] ehci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
[    1.592748] ehci_hcd 0000:00:1a.0: debug port 2
[    1.596618] ehci_hcd 0000:00:1a.0: cache line size of 64 is not supported
[    1.596631] ehci_hcd 0000:00:1a.0: irq 16, io mem 0xf0709000
[    1.606315] ehci_hcd 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    1.606349] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    1.606352] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.606355] usb usb1: Product: EHCI Host Controller
[    1.606357] usb usb1: Manufacturer: Linux 3.1.9-1.4-desktop ehci_hcd
[    1.606367] usb usb1: SerialNumber: 0000:00:1a.0
[    1.606454] hub 1-0:1.0: USB hub found
[    1.606457] hub 1-0:1.0: 2 ports detected
[    1.606508] ehci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    1.606517] ehci_hcd 0000:00:1d.0: setting latency timer to 64
[    1.606520] ehci_hcd 0000:00:1d.0: EHCI Host Controller
[    1.606524] ehci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    1.606546] ehci_hcd 0000:00:1d.0: debug port 2
[    1.610420] ehci_hcd 0000:00:1d.0: cache line size of 64 is not supported
[    1.610433] ehci_hcd 0000:00:1d.0: irq 23, io mem 0xf0708000
[    1.620296] ehci_hcd 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    1.620324] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    1.620327] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.620329] usb usb2: Product: EHCI Host Controller
[    1.620332] usb usb2: Manufacturer: Linux 3.1.9-1.4-desktop ehci_hcd
[    1.620334] usb usb2: SerialNumber: 0000:00:1d.0
[    1.620417] hub 2-0:1.0: USB hub found
[    1.620419] hub 2-0:1.0: 2 ports detected
[    1.620465] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.620475] uhci_hcd: USB Universal Host Controller Interface driver
[    1.620494] Initializing USB Mass Storage driver...
[    1.620510] usbcore: registered new interface driver usb-storage
[    1.620511] USB Mass Storage support registered.
[    1.620519] usbcore: registered new interface driver ums-alauda
[    1.620527] usbcore: registered new interface driver ums-cypress
[    1.620535] usbcore: registered new interface driver ums-datafab
[    1.620542] usbcore: registered new interface driver ums-freecom
[    1.620550] usbcore: registered new interface driver ums-isd200
[    1.620558] usbcore: registered new interface driver ums-jumpshot
[    1.620566] usbcore: registered new interface driver ums-karma
[    1.620573] usbcore: registered new interface driver ums-onetouch
[    1.620581] usbcore: registered new interface driver ums-sddr09
[    1.620589] usbcore: registered new interface driver ums-sddr55
[    1.620596] usbcore: registered new interface driver ums-usbat
[    1.620641] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    1.623743] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.623763] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.623837] mousedev: PS/2 mouse device common for all mice
[    1.623924] rtc_cmos 00:06: RTC can wake from S4
[    1.624021] rtc_cmos 00:06: rtc core: registered rtc_cmos as rtc0
[    1.624047] rtc0: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[    1.624158] cpuidle: using governor ladder
[    1.624333] cpuidle: using governor menu
[    1.624533] usbcore: registered new interface driver usbhid
[    1.624534] usbhid: USB HID core driver
[    1.624661] TCP cubic registered
[    1.624879] NET: Registered protocol family 10
[    1.625284] lib80211: common routines for IEEE802.11 drivers
[    1.625285] lib80211_crypt: registered algorithm 'NULL'
[    1.625287] Registering the dns_resolver key type
[    1.625299] libceph: loaded (mon/osd proto 15/24, osdmap 5/6 5/6)
[    1.625306] Using IPI No-Shortcut mode
[    1.625519] PM: Checking hibernation image partition /dev/disk/by-id/ata-SPCC_Solid_State_DiskB28_00000000000000000015-part1
[    1.642726] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    1.666271] Refined TSC clocksource calibration: 2793.653 MHz.
[    1.666277] Switching to clocksource tsc
[    1.907911] usb 1-1: new high speed USB device number 2 using ehci_hcd
[    2.022083] usb 1-1: New USB device found, idVendor=8087, idProduct=0024
[    2.022088] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.022377] hub 1-1:1.0: USB hub found
[    2.022447] hub 1-1:1.0: 6 ports detected
[    2.124541] usb 2-1: new high speed USB device number 2 using ehci_hcd
[    2.238759] usb 2-1: New USB device found, idVendor=8087, idProduct=0024
[    2.238763] usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.239058] hub 2-1:1.0: USB hub found
[    2.239128] hub 2-1:1.0: 8 ports detected
[    2.447098] ata2.00: failed to resume link (SControl 0)
[    2.513095] usb 2-1.1: new low speed USB device number 3 using ehci_hcd
[    2.602598] usb 2-1.1: New USB device found, idVendor=046d, idProduct=c05b
[    2.602603] usb 2-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.602606] usb 2-1.1: Product: USB Optical Mouse
[    2.602608] usb 2-1.1: Manufacturer: Logitech
[    2.605641] input: Logitech USB Optical Mouse as /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.1/2-1.1:1.0/input/input1
[    2.605881] generic-usb 0003:046D:C05B.0001: input,hidraw0: USB HID v1.11 Mouse [Logitech USB Optical Mouse] on usb-0000:00:1d.0-1.1/input0
[    2.759635] ata1.01: failed to resume link (SControl 0)
[    2.910498] ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.910511] ata1.01: SATA link down (SStatus 0 SControl 0)
[    2.913754] ata1.00: ATA-8: SPCC Solid State DiskB28, 110512, max UDMA/133
[    2.913757] ata1.00: 62533296 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    2.916751] ata1.00: configured for UDMA/133
[    2.916926] scsi 0:0:0:0: Direct-Access     ATA      SPCC Solid State 1105 PQ: 0 ANSI: 5
[    2.917159] sd 0:0:0:0: [sda] 62533296 512-byte logical blocks: (32.0 GB/29.8 GiB)
[    2.917482] sd 0:0:0:0: [sda] Write Protect is off
[    2.917485] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.917558] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.918546]  sda: sda1 sda2
[    2.918963] sd 0:0:0:0: [sda] Attached SCSI disk
[    3.452628] ata2.01: failed to resume link (SControl 0)
[    3.464165] ata2.00: SATA link down (SStatus 4 SControl 0)
[    3.464179] ata2.01: SATA link down (SStatus 0 SControl 0)
[    3.464271] PM: Hibernation image not present or could not be loaded.
[    3.464285] registered taskstats version 1
[    3.468479]   Magic number: 12:41:522
[    3.468591] rtc_cmos 00:06: setting system clock to 2012-09-24 07:32:32 UTC (1348471952)
[    3.468827] Freeing unused kernel memory: 488k freed
[    3.469012] Write protecting the kernel text: 5192k
[    3.469077] Write protecting the kernel read-only data: 3536k
[    3.469078] NX-protecting the kernel data: 5048k
[    3.502350] udevd[105]: starting version 173
[    3.511657] ACPI: acpi_idle yielding to intel_idle
[    3.518335] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    3.518378] ACPI: Power Button [PWRF]
[    3.520079] [drm] Initialized drm 1.1.0 20060810
[    3.533986] ACPI: Fan [FAN0] (off)
[    3.534016] ACPI: Fan [FAN1] (off)
[    3.534040] ACPI: Fan [FAN2] (off)
[    3.534065] ACPI: Fan [FAN3] (off)
[    3.534089] ACPI: Fan [FAN4] (off)
[    3.534828] thermal LNXTHERM:00: registered as thermal_zone0
[    3.534835] ACPI: Thermal Zone [TZ00] (28 C)
[    3.534989] thermal LNXTHERM:01: registered as thermal_zone1
[    3.534995] ACPI: Thermal Zone [TZ01] (30 C)
[    3.535879] i915 0000:00:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    3.535882] i915 0000:00:02.0: setting latency timer to 64
[    3.548942] mtrr: no more MTRRs available
[    3.548944] [drm] MTRR allocation failed.  Graphics performance may suffer.
[    3.549195] i915 0000:00:02.0: irq 43 for MSI/MSI-X
[    3.549198] [drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
[    3.549200] [drm] Driver supports precise vblank timestamp query.
[    3.549226] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    3.883359] checking generic (e0000000 3ff0000) vs hw (e0000000 10000000)
[    3.883362] fb: conflicting fb hw usage inteldrmfb vs VESA VGA - removing generic driver
[    3.883374] Console: switching to colour dummy device 80x25
[    3.884075] fbcon: inteldrmfb (fb0) is primary device
[    4.216748] bootsplash: scaling image from 1280x1024 to 1920x1080
[    4.390276] bootsplash: scaling image from 1280x1024 to 1920x1080
[    4.438089] bootsplash: scaling image from 1280x1024 to 1920x1080
[    4.611545] bootsplash: scaling image from 1280x1024 to 1920x1080
[    4.644346] Console: switching to colour frame buffer device 236x63
[    4.659475] bootsplash: scaling image from 1280x1024 to 1920x1080
[    4.832898] bootsplash: scaling image from 1280x1024 to 1920x1080
[    4.865596] fb0: inteldrmfb frame buffer device
[    4.865598] drm: registered panic notifier
[    4.866096] acpi device:34: registered as cooling_device9
[    4.866271] input: Video Bus as /devices/LNXSYSTM:00/device:00/PNP0A08:00/LNXVIDEO:00/input/input3
[    4.866385] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    4.866409] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 0
[    4.989518] PM: Marking nosave pages: 000000000009d000 - 0000000000100000
[    4.989522] PM: Marking nosave pages: 0000000020000000 - 0000000020200000
[    4.989530] PM: Basic memory bitmaps created
[    5.006184] PM: Basic memory bitmaps freed
[    5.006190] video LNXVIDEO:00: Restoring backlight state
[    5.026396] PM: Starting manual resume from disk
[    5.026398] PM: Hibernation image partition 8:1 present
[    5.026399] PM: Looking for hibernation image.
[    5.026714] PM: Image not found (code -22)
[    5.026715] PM: Hibernation image not present or could not be loaded.
[    5.043999] bootsplash: status on console 0 changed to on
[    5.215694] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[    5.231391] EXT4-fs (sda2): re-mounted. Opts: acl,user_xattr
[    5.466642] systemd[1]: systemd 37 running in system mode. (+PAM +LIBWRAP +AUDIT +SELINUX +SYSVINIT +LIBCRYPTSETUP; suse)
[    5.491702] systemd[1]: Set hostname to <linux-ask8.site>.
[    5.726541] systemd-readahead-replay[358]: Bumped block_nr parameter of 8:0 to 16384. This is a temporary hack and should be removed one day.
[    5.882688] udevd[385]: starting version 173
[    5.923881] bootsplash: status on console 0 changed to on
[    5.941625] bootsplash: scaling image from 1280x1024 to 1920x1080
[    5.962768] mei: module is from the staging directory, the quality is unknown, you have been warned.
[    5.963141] mei 0000:00:16.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    5.963146] mei 0000:00:16.0: setting latency timer to 64
[    5.966837] e1000e: Intel(R) PRO/1000 Network Driver - 1.4.4-k
[    5.966839] e1000e: Copyright(c) 1999 - 2011 Intel Corporation.
[    5.966862] e1000e 0000:02:00.0: Disabling ASPM L0s 
[    5.967198] e1000e 0000:02:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    5.967217] udevd[415]: kernel-provided name 'ttyS6' and NAME= 'tts/6' disagree, please use SYMLINK+= or change the kernel to provide the proper name
[    5.967222] e1000e 0000:02:00.0: setting latency timer to 64
[    5.967394] e1000e 0000:02:00.0: (unregistered net_device): Failed to initialize MSI-X interrupts.  Falling back to MSI interrupts.
[    5.967464] e1000e 0000:02:00.0: irq 44 for MSI/MSI-X
[    5.967523] udevd[415]: kernel-provided name 'ttyS7' and NAME= 'tts/7' disagree, please use SYMLINK+= or change the kernel to provide the proper name
[    5.973310] iTCO_vendor_support: vendor-support=0
[    5.973492] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.06
[    5.973522] udevd[396]: kernel-provided name 'ttyS0' and NAME= 'tts/0' disagree, please use SYMLINK+= or change the kernel to provide the proper name
[    5.973582] iTCO_wdt: Found a Cougar Point TCO device (Version=2, TCOBASE=0x0460)
[    5.974246] udevd[396]: kernel-provided name 'ttyS1' and NAME= 'tts/1' disagree, please use SYMLINK+= or change the kernel to provide the proper name
[    5.974264] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    5.974598] udevd[396]: kernel-provided name 'ttyS2' and NAME= 'tts/2' disagree, please use SYMLINK+= or change the kernel to provide the proper name
[    5.975214] udevd[396]: kernel-provided name 'ttyS3' and NAME= 'tts/3' disagree, please use SYMLINK+= or change the kernel to provide the proper name
[    5.976342] udevd[396]: kernel-provided name 'ttyS4' and NAME= 'tts/4' disagree, please use SYMLINK+= or change the kernel to provide the proper name
[    5.977359] udevd[396]: kernel-provided name 'ttyS5' and NAME= 'tts/5' disagree, please use SYMLINK+= or change the kernel to provide the proper name
[    5.980895] input: PC Speaker as /devices/platform/pcspkr/input/input4
[    5.988573] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    6.056766] parport_pc 00:08: reported by Plug and Play ACPI
[    6.056812] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
[    6.069370] e1000e 0000:02:00.0: eth0: (PCI Express:2.5GT/s:Width x1) 00:03:1d:0a:7f:18
[    6.069372] e1000e 0000:02:00.0: eth0: Intel(R) PRO/1000 Network Connection
[    6.069518] e1000e 0000:02:00.0: eth0: MAC: 3, PHY: 8, PBA No: FFFFFF-0FF
[    6.069526] e1000e 0000:03:00.0: Disabling ASPM L0s 
[    6.069612] e1000e 0000:03:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    6.069635] e1000e 0000:03:00.0: setting latency timer to 64
[    6.069831] e1000e 0000:03:00.0: (unregistered net_device): Failed to initialize MSI-X interrupts.  Falling back to MSI interrupts.
[    6.069913] e1000e 0000:03:00.0: irq 45 for MSI/MSI-X
[    6.070681] snd_hda_intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[    6.070722] snd_hda_intel 0000:00:1b.0: irq 46 for MSI/MSI-X
[    6.070745] snd_hda_intel 0000:00:1b.0: setting latency timer to 64
[    6.085315] hda_codec: ALC888: BIOS auto-probing.
[    6.085318] ALSA patch_realtek.c:1228 SKU: Nid=0x1d sku_cfg=0x4004c601
[    6.085319] ALSA patch_realtek.c:1230 SKU: port_connectivity=0x1
[    6.085321] ALSA patch_realtek.c:1231 SKU: enable_pcbeep=0x0
[    6.085322] ALSA patch_realtek.c:1232 SKU: check_sum=0x00000004
[    6.085323] ALSA patch_realtek.c:1233 SKU: customization=0x000000c6
[    6.085324] ALSA patch_realtek.c:1234 SKU: external_amp=0x0
[    6.085326] ALSA patch_realtek.c:1235 SKU: platform_type=0x0
[    6.085327] ALSA patch_realtek.c:1236 SKU: swap=0x0
[    6.085328] ALSA patch_realtek.c:1237 SKU: override=0x1
[    6.085331] ALSA hda_codec.c:4895 autoconfig: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
[    6.085333] ALSA hda_codec.c:4899    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    6.085334] ALSA hda_codec.c:4903    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[    6.085336] ALSA hda_codec.c:4904    mono: mono_out=0x0
[    6.085337] ALSA hda_codec.c:4907    dig-out=0x1e/0x0
[    6.085338] ALSA hda_codec.c:4908    inputs:
[    6.085339] ALSA hda_codec.c:4912  Rear Mic=0x18
[    6.085341] ALSA hda_codec.c:4912  Front Mic=0x19
[    6.085342] ALSA hda_codec.c:4912  Line=0x1a
[    6.085343] ALSA hda_codec.c:4914 
[    6.087521] ALSA patch_realtek.c:1291 realtek: No valid SSID, checking pincfg 0x4004c601 for NID 0x1d
[    6.087523] ALSA patch_realtek.c:1307 realtek: Enabling init ASM_ID=0xc601 CODEC_ID=10ec0888
[    6.091401] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input5
[    6.091531] i801_smbus 0000:00:1f.3: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    6.144710] bootsplash: scaling image from 1280x1024 to 1920x1080
[    6.160322] ppdev: user-space parallel port driver
[    6.176013] e1000e 0000:03:00.0: eth1: (PCI Express:2.5GT/s:Width x1) 00:03:1d:0a:7f:19
[    6.176016] e1000e 0000:03:00.0: eth1: Intel(R) PRO/1000 Network Connection
[    6.176153] e1000e 0000:03:00.0: eth1: MAC: 3, PHY: 8, PBA No: FFFFFF-0FF
[    6.186824] pcan: Release_20120726_n (le)
[    6.186827] pcan: driver config [dbg] [mod] [isa] [pci] [dng] [par] [usb] [pcc] 
[    6.186828] pcan: DEBUG is switched on
[    6.186842] pcan: pcan_pci_init()
[    6.186866] pcan: pcan_pci_probe(f368f800)
[    6.186877] pci 0000:00:1e.0: can't derive routing for PCI INT A
[    6.186878] pcan 0000:04:08.0: PCI INT A: no GSI - using ISA IRQ 11
[    6.186887] pcan: create_one_pci_device(nChannel=0)
[    6.186890] pcan: pcan_pci_channel_init(), _pci_devices = 0
[    6.186891] pcan: pcan_create_filter_chain()
[    6.188794] udevd[390]: renamed network interface eth0 to eth3
[    6.191910] pcan: pci device minor 0 found
[    6.191912] pcan: sja1000_probe()
[    6.191914] pcan: CLKDIVIDER traced (0x00)
[    6.191916] pcan: Hopefully switched to PeliCAN mode
[    6.191928] pcan: CHIPSTATUS traced (0x3c)
[    6.191930] pcan: INTERRUPT_STATUS traced (0x00)
[    6.191932] pcan: RECEIVE_MSG_COUNTER traced (0x00)
[    6.191933] pcan: sja1000_probe() is OK
[    6.191935] pcan: create_one_pci_device(nChannel=1)
[    6.191938] pcan: pcan_pci_channel_init(), _pci_devices = 1
[    6.191939] pcan: pcan_create_filter_chain()
[    6.191943] pcan: pci device minor 1 found
[    6.191944] pcan: sja1000_probe()
[    6.191946] pcan: CLKDIVIDER traced (0x00)
[    6.191948] pcan: Hopefully switched to PeliCAN mode
[    6.191960] pcan: CHIPSTATUS traced (0x3c)
[    6.191962] pcan: INTERRUPT_STATUS traced (0x00)
[    6.191964] pcan: RECEIVE_MSG_COUNTER traced (0x00)
[    6.191965] pcan: sja1000_probe() is OK
[    6.191983] pcan: make_legacy_devices()
[    6.191985] pcan: pcan_create_isa_shared_irq_lists()
[    6.191986] pcan: pcan_usb_register_devices()
[    6.191987] pcan: pcan_usb_core_init() -------------------------------------------
[    6.192003] usbcore: registered new interface driver pcan
[    6.192004] pcan: pcan_usb_register_devices() is OK
[    6.192005] pcan: pcan_pccard_register_devices()
[    6.192007] pcan: pccard_init()
[    6.192018] pcan: pcan_pccard_register_devices() is OK
[    6.192020] pcan: dev_register()
[    6.192021] pcan: device_create(pcanpci%d, 250, 0)
[    6.192064] pcan: device_create(pcanpci%d, 250, 1)
[    6.192088] pcan: major 250.
[    6.208898] ifup[580]: Service network not started and mode 'auto' -> skipping
[    6.248221] bootsplash: scaling image from 1280x1024 to 1920x1080
[    6.298605] udevd[389]: renamed network interface eth1 to eth2
[    6.423542] bootsplash: scaling image from 1280x1024 to 1920x1080
[    6.467686] EXT4-fs (sda2): warning: mounting fs with errors, running e2fsck is recommended
[    6.469548] EXT4-fs (sda2): re-mounted. Opts: acl,user_xattr
[    6.475492] ifup[622]: Service network not started and mode 'auto' -> skipping
[    6.477174] boot.localnet[597]: Using boot-specified hostname 'linux-ask8.site'
[    6.477179] boot.localnet[597]: Setting up hostname 'linux-ask8'..done
[    6.477189] boot.localnet[597]: Setting up loopback interface RTNETLINK answers: File exists
[    6.477194] boot.localnet[597]: ..done
[    6.916148] Adding 2103292k swap on /dev/sda1.  Priority:0 extents:1 across:2103292k SS
[    6.989192] microcode: CPU0 sig=0x206a7, pf=0x2, revision=0x1a
[    6.990953] microcode: CPU1 sig=0x206a7, pf=0x2, revision=0x1a
[    6.991881] microcode: CPU2 sig=0x206a7, pf=0x2, revision=0x1a
[    6.993010] microcode: CPU3 sig=0x206a7, pf=0x2, revision=0x1a
[    6.993935] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    7.002836] cpufreq[642]: Loading CPUFreq modules..done
[    7.018482] microcode: CPU0 updated to revision 0x1b, date = 2011-07-14
[    7.018837] microcode: CPU1 updated to revision 0x1b, date = 2011-07-14
[    7.019194] microcode: CPU2 updated to revision 0x1b, date = 2011-07-14
[    7.019554] microcode: CPU3 updated to revision 0x1b, date = 2011-07-14
[    7.019847] microcode.ctl[640]: Checking/updating CPU microcode ..done
[    7.560773] e1000e 0000:02:00.0: irq 44 for MSI/MSI-X
[    7.611550] e1000e 0000:02:00.0: irq 44 for MSI/MSI-X
[    7.612037] ADDRCONF(NETDEV_UP): eth3: link is not ready
[    7.670747] RPC: Registered named UNIX socket transport module.
[    7.670749] RPC: Registered udp transport module.
[    7.670750] RPC: Registered tcp transport module.
[    7.670751] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    7.671808] FS-Cache: Loaded
[    7.674399] FS-Cache: Netfs 'nfs' registered for caching
[    7.678539] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[    7.688591] e1000e 0000:03:00.0: irq 45 for MSI/MSI-X
[    7.739369] e1000e 0000:03:00.0: irq 45 for MSI/MSI-X
[    7.739853] ADDRCONF(NETDEV_UP): eth2: link is not ready
[    7.876875] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
[    7.877218] NFSD: starting 90-second grace period
[    8.227165] bootsplash: status on console 0 changed to on
[    9.459978] EXT4-fs (sda2): re-mounted. Opts: acl,user_xattr,commit=0
[   11.846846] e1000e: eth3 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
[   11.847179] ADDRCONF(NETDEV_CHANGE): eth3: link becomes ready
[   11.847402] e1000e: eth3 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
[   11.863632] NET: Registered protocol family 17
[   18.529273] fuse init (API version 7.17)
[   22.047854] eth3: no IPv6 routers present
[  765.183567] pcan: pcan_open(), major/minor = 250/0.
[  765.183570] pcan: pcan_search_dev(), major,minor = 250,0.
[  765.183572] pcan: pcan_open_path, minor = 0, path = 0.
[  765.183593] pcan: sja1000_open(), minor = 0.
[  765.183602] pcan: pcan_open_path() is OK
[  845.633585] pcan: pcan_read_procmem()
[  845.633609] pcan: pcan_read_procmem()

--------------030404090706000905080608--
