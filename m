Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:41858 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752448AbdLWEuJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Dec 2017 23:50:09 -0500
Date: Fri, 22 Dec 2017 23:51:39 -0500
From: Alexandru Chirvasitu <achirvasub@gmail.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Mikael Pettersson <mikpelinux@gmail.com>,
        Josh Poulson <jopoulso@microsoft.com>,
        "Mihai Costache (Cloudbase Solutions SRL)" <v-micos@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Simon Xiao <sixiao@microsoft.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        KY Srinivasan <kys@microsoft.com>
Subject: Re: PROBLEM: 4.15.0-rc3 APIC causes lockups on Core 2 Duo laptop
Message-ID: <20171223045139.GB1138@arch-chirva.localdomain>
References: <alpine.DEB.2.20.1712200124440.2282@nanos>
 <ec3a298b-27a3-f3fe-ea8d-a777669104ba@cn.fujitsu.com>
 <20171220131929.GC24638@arch-chirva.localdomain>
 <20171220194506.GD24638@arch-chirva.localdomain>
 <20171221022356.GE24638@arch-chirva.localdomain>
 <1bd74ca3-afca-9d61-6911-61250f459891@cn.fujitsu.com>
 <20171222142053.3cbhi2nhh24w7yoo@D-69-91-141-110.dhcp4.washington.edu>
 <KL1P15301MB000676F3F8C9A5AC8C489E75BF020@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <20171222222917.GA1138@arch-chirva.localdomain>
 <KL1P15301MB00064E9E767F9395744F42A3BF030@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="eAbsdosE1cNLO4uF"
In-Reply-To: <KL1P15301MB00064E9E767F9395744F42A3BF030@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I was just now trying to track down my other issue, whereby somewhere
along the tree kexec stops working properly. In the process of doing
that I realized I had initially made one change to the original 4.9
config beyond oldconfig: I'd turned off WX debugging.

I've now compiled a bunch of versions with WX debugging back on, and
new behavior arises. I am attaching the joournalctl log of a booted
4.13 kernel (from Linus' tree, commit 569dbb8).

It boots and logs me in, but returns a call trace I wasn't seeing
without the WX debugging. I am sending over in case it provides any
information.

The trace bears the 23:24:09 timestamp.

On Sat, Dec 23, 2017 at 01:35:12AM +0000, Dexuan Cui wrote:
> > From: Alexandru Chirvasitu [mailto:achirvasub@gmail.com]
> > Sent: Friday, December 22, 2017 14:29
> > 
> > The output of that precise command run just now on a freshly-compiled
> > copy of that commit is attached.
> > 
> > On Fri, Dec 22, 2017 at 09:31:28PM +0000, Dexuan Cui wrote:
> > > > From: Alexandru Chirvasitu [mailto:achirvasub@gmail.com]
> > > > Sent: Friday, December 22, 2017 06:21
> > > >
> > > > In the absence of logs, the best I can do at the moment is attach a
> > > > picture of the screen I am presented with on the apic=debug boot
> > > > attempt.
> > > > Alex
> > >
> > > The panic happens in irq_matrix_assign_system+0x4e/0xd0 in your picture.
> > > IMO we should find which line of code causes the panic. I suppose
> > > "objdump -D kernel/irq/matrix.o" can help to do that.
> > >
> > > Thanks,
> > > -- Dexuan
> 
> The BUG_ON panic happens at line 147:
>                    BUG_ON(!test_and_clear_bit(bit, cm->alloc_map));
> 
> I'm sure Thomas and Dou know it better than me. 
> 
> 137 void irq_matrix_assign_system(struct irq_matrix *m, unsigned int bit,
> 138                               bool replace)
> 139 {
> 140         struct cpumap *cm = this_cpu_ptr(m->maps);
> 141
> 142         BUG_ON(bit > m->matrix_bits);
> 143         BUG_ON(m->online_maps > 1 || (m->online_maps && !replace));
> 144
> 145         set_bit(bit, m->system_map);
> 146         if (replace) {
> 147                 BUG_ON(!test_and_clear_bit(bit, cm->alloc_map));
> 148                 cm->allocated--;
> 149                 m->total_allocated--;
> 150         }
> 151         if (bit >= m->alloc_start && bit < m->alloc_end)
> 152                 m->systembits_inalloc++;
> 153
> 154         trace_irq_matrix_assign_system(bit, m);
> 155 }
> 
> -- Dexuan
> 

--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="journal-4.13-dec22-23_48"

-- Logs begin at Thu 2017-12-14 19:59:20 EST, end at Fri 2017-12-22 23:45:29 EST. --
Dec 22 23:24:09 D-69-91-141-110 kernel: random: get_random_bytes called from start_kernel+0x32/0x3a0 with crng_init=0
Dec 22 23:24:09 D-69-91-141-110 kernel: Linux version 4.13.0 (root@axiomatic) (gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.5)) #1 SMP Fri Dec 22 22:18:58 EST 2017
Dec 22 23:24:09 D-69-91-141-110 kernel: x86/fpu: x87 FPU will use FXSAVE
Dec 22 23:24:09 D-69-91-141-110 kernel: e820: BIOS-provided physical RAM map:
Dec 22 23:24:09 D-69-91-141-110 kernel: BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
Dec 22 23:24:09 D-69-91-141-110 kernel: BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
Dec 22 23:24:09 D-69-91-141-110 kernel: BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
Dec 22 23:24:09 D-69-91-141-110 kernel: BIOS-e820: [mem 0x0000000000100000-0x00000000b7f9ffff] usable
Dec 22 23:24:09 D-69-91-141-110 kernel: BIOS-e820: [mem 0x00000000b7fa0000-0x00000000b7fadfff] ACPI data
Dec 22 23:24:09 D-69-91-141-110 kernel: BIOS-e820: [mem 0x00000000b7fae000-0x00000000b7feffff] ACPI NVS
Dec 22 23:24:09 D-69-91-141-110 kernel: BIOS-e820: [mem 0x00000000b7ff0000-0x00000000b7ffffff] reserved
Dec 22 23:24:09 D-69-91-141-110 kernel: BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
Dec 22 23:24:09 D-69-91-141-110 kernel: BIOS-e820: [mem 0x00000000ffb80000-0x00000000ffffffff] reserved
Dec 22 23:24:09 D-69-91-141-110 kernel: NX (Execute Disable) protection: active
Dec 22 23:24:09 D-69-91-141-110 kernel: random: fast init done
Dec 22 23:24:09 D-69-91-141-110 kernel: SMBIOS 2.4 present.
Dec 22 23:24:09 D-69-91-141-110 kernel: DMI: ASUSTeK Computer Inc. F5RL                /F5RL      , BIOS 210     06/12/2008
Dec 22 23:24:09 D-69-91-141-110 kernel: tsc: Fast TSC calibration using PIT
Dec 22 23:24:09 D-69-91-141-110 kernel: e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
Dec 22 23:24:09 D-69-91-141-110 kernel: e820: remove [mem 0x000a0000-0x000fffff] usable
Dec 22 23:24:09 D-69-91-141-110 kernel: e820: last_pfn = 0xb7fa0 max_arch_pfn = 0x1000000
Dec 22 23:24:09 D-69-91-141-110 kernel: MTRR default type: uncachable
Dec 22 23:24:09 D-69-91-141-110 kernel: MTRR fixed ranges enabled:
Dec 22 23:24:09 D-69-91-141-110 kernel:   00000-9FFFF write-back
Dec 22 23:24:09 D-69-91-141-110 kernel:   A0000-BFFFF uncachable
Dec 22 23:24:09 D-69-91-141-110 kernel:   C0000-CFFFF write-protect
Dec 22 23:24:09 D-69-91-141-110 kernel:   D0000-DFFFF uncachable
Dec 22 23:24:09 D-69-91-141-110 kernel:   E0000-EFFFF write-through
Dec 22 23:24:09 D-69-91-141-110 kernel:   F0000-FFFFF write-protect
Dec 22 23:24:09 D-69-91-141-110 kernel: MTRR variable ranges enabled:
Dec 22 23:24:09 D-69-91-141-110 kernel:   0 base 000000000 mask F80000000 write-back
Dec 22 23:24:09 D-69-91-141-110 kernel:   1 base 080000000 mask FE0000000 write-back
Dec 22 23:24:09 D-69-91-141-110 kernel:   2 base 0A0000000 mask FF0000000 write-back
Dec 22 23:24:09 D-69-91-141-110 kernel:   3 base 0B0000000 mask FF8000000 write-back
Dec 22 23:24:09 D-69-91-141-110 kernel:   4 base 0B8000000 mask FFC000000 write-back
Dec 22 23:24:09 D-69-91-141-110 kernel:   5 base 0BC000000 mask FFF000000 write-back
Dec 22 23:24:09 D-69-91-141-110 kernel:   6 base 0C0000000 mask FF0000000 write-combining
Dec 22 23:24:09 D-69-91-141-110 kernel:   7 disabled
Dec 22 23:24:09 D-69-91-141-110 kernel: x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT  
Dec 22 23:24:09 D-69-91-141-110 kernel: found SMP MP-table at [mem 0x000ff780-0x000ff78f] mapped at [c00ff780]
Dec 22 23:24:09 D-69-91-141-110 kernel: initial memory mapped: [mem 0x00000000-0x12dfffff]
Dec 22 23:24:09 D-69-91-141-110 kernel: Base memory trampoline at [c009b000] 9b000 size 16384
Dec 22 23:24:09 D-69-91-141-110 kernel: BRK [0x12a13000, 0x12a13fff] PGTABLE
Dec 22 23:24:09 D-69-91-141-110 kernel: BRK [0x12a14000, 0x12a15fff] PGTABLE
Dec 22 23:24:09 D-69-91-141-110 kernel: BRK [0x12a16000, 0x12a16fff] PGTABLE
Dec 22 23:24:09 D-69-91-141-110 kernel: BRK [0x12a17000, 0x12a17fff] PGTABLE
Dec 22 23:24:09 D-69-91-141-110 kernel: RAMDISK: [mem 0x35cbf000-0x36e56fff]
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: Early table checksum verification disabled
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: RSDP 0x00000000000F8070 000014 (v00 ACPIAM)
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: RSDT 0x00000000B7FA0000 00003C (v01 A_M_I_ OEMRSDT  06000812 MSFT 00000097)
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: FACP 0x00000000B7FA0200 000084 (v02 A_M_I_ OEMFACP  06000812 MSFT 00000097)
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: DSDT 0x00000000B7FA0630 0075FA (v01 A0669  A0669000 00000000 INTL 20060113)
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: FACS 0x00000000B7FAE000 000040
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: APIC 0x00000000B7FA0390 00005C (v01 A_M_I_ OEMAPIC  06000812 MSFT 00000097)
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: MCFG 0x00000000B7FA03F0 00003C (v01 A_M_I_ OEMMCFG  06000812 MSFT 00000097)
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: SLIC 0x00000000B7FA0430 000176 (v01 A_M_I_ OEMSLIC  06000812 MSFT 00000097)
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: BOOT 0x00000000B7FA0600 000028 (v01 A_M_I_ OEMBOOT  06000812 MSFT 00000097)
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: OEMB 0x00000000B7FAE040 00005B (v01 A_M_I_ AMI_OEM  06000812 MSFT 00000097)
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: Local APIC address 0xfee00000
Dec 22 23:24:09 D-69-91-141-110 kernel: 2053MB HIGHMEM available.
Dec 22 23:24:09 D-69-91-141-110 kernel: 889MB LOWMEM available.
Dec 22 23:24:09 D-69-91-141-110 kernel:   mapped low ram: 0 - 379fe000
Dec 22 23:24:09 D-69-91-141-110 kernel:   low ram: 0 - 379fe000
Dec 22 23:24:09 D-69-91-141-110 kernel: Reserving 256MB of memory at 32MB for crashkernel (System RAM: 2943MB)
Dec 22 23:24:09 D-69-91-141-110 kernel: Zone ranges:
Dec 22 23:24:09 D-69-91-141-110 kernel:   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
Dec 22 23:24:09 D-69-91-141-110 kernel:   Normal   [mem 0x0000000001000000-0x00000000379fdfff]
Dec 22 23:24:09 D-69-91-141-110 kernel:   HighMem  [mem 0x00000000379fe000-0x00000000b7f9ffff]
Dec 22 23:24:09 D-69-91-141-110 kernel: Movable zone start for each node
Dec 22 23:24:09 D-69-91-141-110 kernel: Early memory node ranges
Dec 22 23:24:09 D-69-91-141-110 kernel:   node   0: [mem 0x0000000000001000-0x000000000009efff]
Dec 22 23:24:09 D-69-91-141-110 kernel:   node   0: [mem 0x0000000000100000-0x00000000b7f9ffff]
Dec 22 23:24:09 D-69-91-141-110 kernel: Initmem setup node 0 [mem 0x0000000000001000-0x00000000b7f9ffff]
Dec 22 23:24:09 D-69-91-141-110 kernel: On node 0 totalpages: 753470
Dec 22 23:24:09 D-69-91-141-110 kernel: free_area_init_node: node 0, pgdat d28127c0, node_mem_map f42df024
Dec 22 23:24:09 D-69-91-141-110 kernel:   DMA zone: 36 pages used for memmap
Dec 22 23:24:09 D-69-91-141-110 kernel:   DMA zone: 0 pages reserved
Dec 22 23:24:09 D-69-91-141-110 kernel:   DMA zone: 3998 pages, LIFO batch:0
Dec 22 23:24:09 D-69-91-141-110 kernel:   Normal zone: 1967 pages used for memmap
Dec 22 23:24:09 D-69-91-141-110 kernel:   Normal zone: 223742 pages, LIFO batch:31
Dec 22 23:24:09 D-69-91-141-110 kernel:   HighMem zone: 525730 pages, LIFO batch:31
Dec 22 23:24:09 D-69-91-141-110 kernel: Using APIC driver default
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: PM-Timer IO Port: 0x808
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: Local APIC address 0xfee00000
Dec 22 23:24:09 D-69-91-141-110 kernel: IOAPIC[0]: apic_id 2, version 33, address 0xfec00000, GSI 0-23
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: IRQ0 used by override.
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: IRQ9 used by override.
Dec 22 23:24:09 D-69-91-141-110 kernel: Using ACPI (MADT) for SMP configuration information
Dec 22 23:24:09 D-69-91-141-110 kernel: smpboot: Allowing 2 CPUs, 0 hotplug CPUs
Dec 22 23:24:09 D-69-91-141-110 kernel: PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
Dec 22 23:24:09 D-69-91-141-110 kernel: PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
Dec 22 23:24:09 D-69-91-141-110 kernel: PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
Dec 22 23:24:09 D-69-91-141-110 kernel: PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
Dec 22 23:24:09 D-69-91-141-110 kernel: e820: [mem 0xb8000000-0xfedfffff] available for PCI devices
Dec 22 23:24:09 D-69-91-141-110 kernel: Booting paravirtualized kernel on bare hardware
Dec 22 23:24:09 D-69-91-141-110 kernel: clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
Dec 22 23:24:09 D-69-91-141-110 kernel: setup_percpu: NR_CPUS:32 nr_cpumask_bits:32 nr_cpu_ids:2 nr_node_ids:1
Dec 22 23:24:09 D-69-91-141-110 kernel: percpu: Embedded 22 pages/cpu @f79cf000 s61004 r0 d29108 u90112
Dec 22 23:24:09 D-69-91-141-110 kernel: pcpu-alloc: s61004 r0 d29108 u90112 alloc=22*4096
Dec 22 23:24:09 D-69-91-141-110 kernel: pcpu-alloc: [0] 0 [0] 1 
Dec 22 23:24:09 D-69-91-141-110 kernel: Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 751467
Dec 22 23:24:09 D-69-91-141-110 kernel: Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.13.0 root=UUID=5a437cd2-c27b-4829-a7ba-533eb741b148 ro 3 crashkernel=256M quiet
Dec 22 23:24:09 D-69-91-141-110 kernel: PID hash table entries: 4096 (order: 2, 16384 bytes)
Dec 22 23:24:09 D-69-91-141-110 kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Dec 22 23:24:09 D-69-91-141-110 kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Dec 22 23:24:09 D-69-91-141-110 kernel: microcode: microcode updated early to revision 0xa4, date = 2010-10-02
Dec 22 23:24:09 D-69-91-141-110 kernel: Initializing CPU#0
Dec 22 23:24:09 D-69-91-141-110 kernel: Initializing HighMem for node 0 (000379fe:000b7fa0)
Dec 22 23:24:09 D-69-91-141-110 kernel: Initializing Movable for node 0 (00000000:00000000)
Dec 22 23:24:09 D-69-91-141-110 kernel: Memory: 2695840K/3013880K available (5929K kernel code, 615K rwdata, 1824K rodata, 796K init, 452K bss, 318040K reserved, 0K cma-reserved, 2102920K highmem)
Dec 22 23:24:09 D-69-91-141-110 kernel: virtual kernel memory layout:
                                            fixmap  : 0xffd16000 - 0xfffff000   (2980 kB)
                                            pkmap   : 0xffa00000 - 0xffc00000   (2048 kB)
                                            vmalloc : 0xf81fe000 - 0xff9fe000   ( 120 MB)
                                            lowmem  : 0xc0000000 - 0xf79fe000   ( 889 MB)
                                              .init : 0xd283c000 - 0xd2903000   ( 796 kB)
                                              .data : 0xd25ca56d - 0xd282dd40   (2445 kB)
                                              .text : 0xd2000000 - 0xd25ca56d   (5929 kB)
Dec 22 23:24:09 D-69-91-141-110 kernel: Checking if this processor honours the WP bit even in supervisor mode...Ok.
Dec 22 23:24:09 D-69-91-141-110 kernel: ftrace: allocating 27069 entries in 53 pages
Dec 22 23:24:09 D-69-91-141-110 kernel: Hierarchical RCU implementation.
Dec 22 23:24:09 D-69-91-141-110 kernel:         RCU restricting CPUs from NR_CPUS=32 to nr_cpu_ids=2.
Dec 22 23:24:09 D-69-91-141-110 kernel: RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
Dec 22 23:24:09 D-69-91-141-110 kernel: NR_IRQS: 2304, nr_irqs: 440, preallocated irqs: 16
Dec 22 23:24:09 D-69-91-141-110 kernel: CPU 0 irqstacks, hard=f74a8000 soft=f74aa000
Dec 22 23:24:09 D-69-91-141-110 kernel: Console: colour VGA+ 80x25
Dec 22 23:24:09 D-69-91-141-110 kernel: console [tty0] enabled
Dec 22 23:24:09 D-69-91-141-110 kernel: tsc: Fast TSC calibration using PIT
Dec 22 23:24:09 D-69-91-141-110 kernel: tsc: Detected 1662.551 MHz processor
Dec 22 23:24:09 D-69-91-141-110 kernel: Calibrating delay loop (skipped), value calculated using timer frequency.. 3325.10 BogoMIPS (lpj=6650204)
Dec 22 23:24:09 D-69-91-141-110 kernel: pid_max: default: 32768 minimum: 301
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: Core revision 20170531
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: 1 ACPI AML tables successfully acquired and loaded
Dec 22 23:24:09 D-69-91-141-110 kernel: Security Framework initialized
Dec 22 23:24:09 D-69-91-141-110 kernel: Yama: becoming mindful.
Dec 22 23:24:09 D-69-91-141-110 kernel: AppArmor: AppArmor disabled by boot time parameter
Dec 22 23:24:09 D-69-91-141-110 kernel: Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
Dec 22 23:24:09 D-69-91-141-110 kernel: Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
Dec 22 23:24:09 D-69-91-141-110 kernel: CPU: Physical Processor ID: 0
Dec 22 23:24:09 D-69-91-141-110 kernel: CPU: Processor Core ID: 0
Dec 22 23:24:09 D-69-91-141-110 kernel: mce: CPU supports 6 MCE banks
Dec 22 23:24:09 D-69-91-141-110 kernel: process: using mwait in idle threads
Dec 22 23:24:09 D-69-91-141-110 kernel: Last level iTLB entries: 4KB 128, 2MB 4, 4MB 4
Dec 22 23:24:09 D-69-91-141-110 kernel: Last level dTLB entries: 4KB 256, 2MB 0, 4MB 32, 1GB 0
Dec 22 23:24:09 D-69-91-141-110 kernel: Freeing SMP alternatives memory: 28K
Dec 22 23:24:09 D-69-91-141-110 kernel: smpboot: Max logical packages: 1
Dec 22 23:24:09 D-69-91-141-110 kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Dec 22 23:24:09 D-69-91-141-110 kernel: ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
Dec 22 23:24:09 D-69-91-141-110 kernel: smpboot: CPU0: Intel(R) Core(TM)2 Duo CPU     T5450  @ 1.66GHz (family: 0x6, model: 0xf, stepping: 0xd)
Dec 22 23:24:09 D-69-91-141-110 kernel: Performance Events: PEBS fmt0+, Core2 events, Intel PMU driver.
Dec 22 23:24:09 D-69-91-141-110 kernel: core: PEBS disabled due to CPU errata
Dec 22 23:24:09 D-69-91-141-110 kernel: ... version:                2
Dec 22 23:24:09 D-69-91-141-110 kernel: ... bit width:              40
Dec 22 23:24:09 D-69-91-141-110 kernel: ... generic registers:      2
Dec 22 23:24:09 D-69-91-141-110 kernel: ... value mask:             000000ffffffffff
Dec 22 23:24:09 D-69-91-141-110 kernel: ... max period:             000000007fffffff
Dec 22 23:24:09 D-69-91-141-110 kernel: ... fixed-purpose events:   3
Dec 22 23:24:09 D-69-91-141-110 kernel: ... event mask:             0000000700000003
Dec 22 23:24:09 D-69-91-141-110 kernel: Hierarchical SRCU implementation.
Dec 22 23:24:09 D-69-91-141-110 kernel: smp: Bringing up secondary CPUs ...
Dec 22 23:24:09 D-69-91-141-110 kernel: CPU 1 irqstacks, hard=f7550000 soft=f7552000
Dec 22 23:24:09 D-69-91-141-110 kernel: x86: Booting SMP configuration:
Dec 22 23:24:09 D-69-91-141-110 kernel: .... node  #0, CPUs:      #1
Dec 22 23:24:09 D-69-91-141-110 kernel: Initializing CPU#1
Dec 22 23:24:09 D-69-91-141-110 kernel: smp: Brought up 1 node, 2 CPUs
Dec 22 23:24:09 D-69-91-141-110 kernel: smpboot: Total of 2 processors activated (6650.26 BogoMIPS)
Dec 22 23:24:09 D-69-91-141-110 kernel: NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
Dec 22 23:24:09 D-69-91-141-110 kernel: devtmpfs: initialized
Dec 22 23:24:09 D-69-91-141-110 kernel: PM: Registering ACPI NVS region [mem 0xb7fae000-0xb7feffff] (270336 bytes)
Dec 22 23:24:09 D-69-91-141-110 kernel: clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
Dec 22 23:24:09 D-69-91-141-110 kernel: futex hash table entries: 512 (order: 3, 32768 bytes)
Dec 22 23:24:09 D-69-91-141-110 kernel: pinctrl core: initialized pinctrl subsystem
Dec 22 23:24:09 D-69-91-141-110 kernel: NET: Registered protocol family 16
Dec 22 23:24:09 D-69-91-141-110 kernel: cpuidle: using governor ladder
Dec 22 23:24:09 D-69-91-141-110 kernel: cpuidle: using governor menu
Dec 22 23:24:09 D-69-91-141-110 kernel: Simple Boot Flag at 0xff set to 0x1
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: bus type PCI registered
Dec 22 23:24:09 D-69-91-141-110 kernel: acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
Dec 22 23:24:09 D-69-91-141-110 kernel: PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
Dec 22 23:24:09 D-69-91-141-110 kernel: PCI: not using MMCONFIG
Dec 22 23:24:09 D-69-91-141-110 kernel: PCI: PCI BIOS area is rw and x. Use pci=nobios if you want it NX.
Dec 22 23:24:09 D-69-91-141-110 kernel: PCI: PCI BIOS revision 3.00 entry at 0xf0031, last bus=8
Dec 22 23:24:09 D-69-91-141-110 kernel: PCI: Using configuration type 1 for base access
Dec 22 23:24:09 D-69-91-141-110 kernel: mtrr: your CPUs had inconsistent variable MTRR settings
Dec 22 23:24:09 D-69-91-141-110 kernel: mtrr: probably your BIOS does not setup all CPUs.
Dec 22 23:24:09 D-69-91-141-110 kernel: mtrr: corrected configuration.
Dec 22 23:24:09 D-69-91-141-110 kernel: HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: Added _OSI(Module Device)
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: Added _OSI(Processor Device)
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: Added _OSI(3.0 _SCP Extensions)
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: Added _OSI(Processor Aggregator Device)
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: Executed 2 blocks of module-level executable AML code
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: Dynamic OEM Table Load:
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: SSDT 0x00000000F74D7000 000C99 (v01 AMI    CPU1PM   00000001 INTL 20060113)
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: Dynamic OEM Table Load:
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: SSDT 0x00000000F753C000 000C99 (v01 AMI    CPU2PM   00000001 INTL 20060113)
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: EC: EC started
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: EC: interrupt blocked
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: \_SB_.PCI0.SBRG.EC0_: Used as first EC
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: \_SB_.PCI0.SBRG.EC0_: GPE=0x11, EC_CMD/EC_SC=0x66, EC_DATA=0x62
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: \_SB_.PCI0.SBRG.EC0_: Used as boot DSDT EC to handle transactions
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: Interpreter enabled
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: (supports S0 S3 S4 S5)
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: Using IOAPIC for interrupt routing
Dec 22 23:24:09 D-69-91-141-110 kernel: PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
Dec 22 23:24:09 D-69-91-141-110 kernel: PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in ACPI motherboard resources
Dec 22 23:24:09 D-69-91-141-110 kernel: PCI: Using MMCONFIG for extended config space
Dec 22 23:24:09 D-69-91-141-110 kernel: PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
Dec 22 23:24:09 D-69-91-141-110 kernel: acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
Dec 22 23:24:09 D-69-91-141-110 kernel: acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
Dec 22 23:24:09 D-69-91-141-110 kernel: PCI host bridge to bus 0000:00
Dec 22 23:24:09 D-69-91-141-110 kernel: pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000dffff window]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci_bus 0000:00: root bus resource [mem 0xb8000000-0xffffffff window]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci_bus 0000:00: root bus resource [bus 00-ff]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:00.0: [1002:5a31] type 00 class 0x060000
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:01.0: [1002:5a3f] type 01 class 0x060400
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:04.0: [1002:5a36] type 01 class 0x060400
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:05.0: [1002:5a37] type 01 class 0x060400
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:05.0: PME# supported from D0 D3hot D3cold
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:06.0: [1002:5a38] type 01 class 0x060400
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:07.0: [1002:5a39] type 01 class 0x060400
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:12.0: [1002:4380] type 00 class 0x01018f
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:12.0: reg 0x10: [io  0xe800-0xe807]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:12.0: reg 0x14: [io  0xe400-0xe403]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:12.0: reg 0x18: [io  0xe000-0xe007]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:12.0: reg 0x1c: [io  0xdc00-0xdc03]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:12.0: reg 0x20: [io  0xd800-0xd80f]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:12.0: reg 0x24: [mem 0xfebffc00-0xfebfffff]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:12.0: set SATA to AHCI mode
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:13.0: [1002:4387] type 00 class 0x0c0310
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:13.0: reg 0x10: [mem 0xfebfe000-0xfebfefff]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:13.1: [1002:4388] type 00 class 0x0c0310
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:13.1: reg 0x10: [mem 0xfebfd000-0xfebfdfff]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:13.2: [1002:4389] type 00 class 0x0c0310
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:13.2: reg 0x10: [mem 0xfebfc000-0xfebfcfff]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:13.3: [1002:438a] type 00 class 0x0c0310
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:13.3: reg 0x10: [mem 0xfebfb000-0xfebfbfff]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:13.4: [1002:438b] type 00 class 0x0c0310
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:13.4: reg 0x10: [mem 0xfebfa000-0xfebfafff]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:13.5: [1002:4386] type 00 class 0x0c0320
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:13.5: reg 0x10: [mem 0xfebff800-0xfebff8ff]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:13.5: supports D1 D2
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:13.5: PME# supported from D0 D1 D2 D3hot
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:14.0: [1002:4385] type 00 class 0x0c0500
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:14.0: reg 0x10: [io  0x0b00-0x0b0f]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:14.1: [1002:438c] type 00 class 0x010182
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:14.1: reg 0x10: [io  0x0000-0x0007]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:14.1: reg 0x14: [io  0x0000-0x0003]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:14.1: reg 0x18: [io  0x0000-0x0007]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:14.1: reg 0x1c: [io  0x0000-0x0003]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:14.1: reg 0x20: [io  0xff00-0xff0f]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:14.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:14.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:14.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:14.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:14.2: [1002:4383] type 00 class 0x040300
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:14.2: reg 0x10: [mem 0xfebf4000-0xfebf7fff 64bit]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:14.3: [1002:438d] type 00 class 0x060100
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:14.4: [1002:4384] type 01 class 0x060401
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:01:05.0: [1002:5a62] type 00 class 0x030000
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:01:05.0: reg 0x10: [mem 0xc0000000-0xcfffffff pref]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:01:05.0: reg 0x14: [io  0x9800-0x98ff]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:01:05.0: reg 0x18: [mem 0xfa8f0000-0xfa8fffff]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:01:05.0: reg 0x30: [mem 0xfa8c0000-0xfa8dffff pref]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:01:05.0: supports D1 D2
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:01.0: PCI bridge to [bus 01]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:01.0:   bridge window [io  0x9000-0x9fff]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:01.0:   bridge window [mem 0xfa800000-0xfa8fffff]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:01.0:   bridge window [mem 0xbdf00000-0xddefffff pref]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:02:00.0: [168c:001c] type 00 class 0x020000
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:02:00.0: reg 0x10: [mem 0xfa9f0000-0xfa9fffff 64bit]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:02:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:04.0: PCI bridge to [bus 02]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:04.0:   bridge window [mem 0xfa900000-0xfa9fffff]
Dec 22 23:24:09 D-69-91-141-110 kernel: acpiphp: Slot [1] registered
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:05.0: PCI bridge to [bus 03-05]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:05.0:   bridge window [io  0xa000-0xbfff]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:05.0:   bridge window [mem 0xfaa00000-0xfe9fffff]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:05.0:   bridge window [mem 0xddf00000-0xdfefffff 64bit pref]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:06:00.0: [1969:2048] type 00 class 0x020000
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:06:00.0: reg 0x10: [mem 0xfeac0000-0xfeafffff 64bit]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:06:00.0: reg 0x30: [mem 0xfeaa0000-0xfeabffff pref]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:06:00.0: PME# supported from D3hot D3cold
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:06:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:06.0: PCI bridge to [bus 06]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:06.0:   bridge window [mem 0xfea00000-0xfeafffff]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:07.0: PCI bridge to [bus 07]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:14.4: PCI bridge to [bus 08] (subtractive decode)
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:14.4:   bridge window [io  0x0000-0x0cf7 window] (subtractive decode)
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:14.4:   bridge window [mem 0x000d0000-0x000dffff window] (subtractive decode)
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:14.4:   bridge window [mem 0xb8000000-0xffffffff window] (subtractive decode)
Dec 22 23:24:09 D-69-91-141-110 kernel: pci_bus 0000:00: on NUMA node 0
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 7 10 11 12)
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 12)
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 7 10 11 12)
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *10 11 12)
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 12) *0, disabled.
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 12) *0, disabled.
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 *11 12)
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 12) *0, disabled.
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: Enabled 2 GPEs in block 00 to 1F
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: EC: interrupt unblocked
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: EC: event unblocked
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: \_SB_.PCI0.SBRG.EC0_: GPE=0x11, EC_CMD/EC_SC=0x66, EC_DATA=0x62
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: \_SB_.PCI0.SBRG.EC0_: Used as boot DSDT EC to handle transactions and events
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:01:05.0: vgaarb: setting as boot VGA device
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:01:05.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:01:05.0: vgaarb: bridge control possible
Dec 22 23:24:09 D-69-91-141-110 kernel: vgaarb: loaded
Dec 22 23:24:09 D-69-91-141-110 kernel: EDAC MC: Ver: 3.0.0
Dec 22 23:24:09 D-69-91-141-110 kernel: PCI: Using ACPI for IRQ routing
Dec 22 23:24:09 D-69-91-141-110 kernel: PCI: pci_cache_line_size set to 64 bytes
Dec 22 23:24:09 D-69-91-141-110 kernel: e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
Dec 22 23:24:09 D-69-91-141-110 kernel: e820: reserve RAM buffer [mem 0xb7fa0000-0xb7ffffff]
Dec 22 23:24:09 D-69-91-141-110 kernel: clocksource: Switched to clocksource refined-jiffies
Dec 22 23:24:09 D-69-91-141-110 kernel: VFS: Disk quotas dquot_6.6.0
Dec 22 23:24:09 D-69-91-141-110 kernel: VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Dec 22 23:24:09 D-69-91-141-110 kernel: pnp: PnP ACPI init
Dec 22 23:24:09 D-69-91-141-110 kernel: pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
Dec 22 23:24:09 D-69-91-141-110 kernel: system 00:01: [io  0x04d0-0x04d1] has been reserved
Dec 22 23:24:09 D-69-91-141-110 kernel: system 00:01: [io  0x040b] has been reserved
Dec 22 23:24:09 D-69-91-141-110 kernel: system 00:01: [io  0x04d6] has been reserved
Dec 22 23:24:09 D-69-91-141-110 kernel: system 00:01: [io  0x0c00-0x0c01] has been reserved
Dec 22 23:24:09 D-69-91-141-110 kernel: system 00:01: [io  0x0c14] has been reserved
Dec 22 23:24:09 D-69-91-141-110 kernel: system 00:01: [io  0x0c50-0x0c51] has been reserved
Dec 22 23:24:09 D-69-91-141-110 kernel: system 00:01: [io  0x0c52] has been reserved
Dec 22 23:24:09 D-69-91-141-110 kernel: system 00:01: [io  0x0c6c] has been reserved
Dec 22 23:24:09 D-69-91-141-110 kernel: system 00:01: [io  0x0c6f] has been reserved
Dec 22 23:24:09 D-69-91-141-110 kernel: system 00:01: [io  0x0cd0-0x0cd1] has been reserved
Dec 22 23:24:09 D-69-91-141-110 kernel: system 00:01: [io  0x0cd2-0x0cd3] has been reserved
Dec 22 23:24:09 D-69-91-141-110 kernel: system 00:01: [io  0x0cd4-0x0cd5] has been reserved
Dec 22 23:24:09 D-69-91-141-110 kernel: system 00:01: [io  0x0cd6-0x0cd7] has been reserved
Dec 22 23:24:09 D-69-91-141-110 kernel: system 00:01: [io  0x0cd8-0x0cdf] has been reserved
Dec 22 23:24:09 D-69-91-141-110 kernel: system 00:01: [io  0x0800-0x089f] has been reserved
Dec 22 23:24:09 D-69-91-141-110 kernel: system 00:01: [io  0x0b00-0x0b1f] could not be reserved
Dec 22 23:24:09 D-69-91-141-110 kernel: system 00:01: [io  0x0900-0x090f] has been reserved
Dec 22 23:24:09 D-69-91-141-110 kernel: system 00:01: [io  0x0910-0x091f] has been reserved
Dec 22 23:24:09 D-69-91-141-110 kernel: system 00:01: [io  0xfe00-0xfefe] has been reserved
Dec 22 23:24:09 D-69-91-141-110 kernel: system 00:01: [io  0x4000-0x40fe] has been reserved
Dec 22 23:24:09 D-69-91-141-110 kernel: system 00:01: [mem 0xfed45000-0xfed89fff] has been reserved
Dec 22 23:24:09 D-69-91-141-110 kernel: system 00:01: [mem 0xffb80000-0xffbfffff] has been reserved
Dec 22 23:24:09 D-69-91-141-110 kernel: system 00:01: [mem 0xfff80000-0xffffffff] has been reserved
Dec 22 23:24:09 D-69-91-141-110 kernel: system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
Dec 22 23:24:09 D-69-91-141-110 kernel: pnp 00:02: Plug and Play ACPI device, IDs PNP0303 PNP030b (active)
Dec 22 23:24:09 D-69-91-141-110 kernel: pnp 00:03: Plug and Play ACPI device, IDs SYN0a04 SYN0a00 SYN0002 PNP0f03 PNP0f13 PNP0f12 (active)
Dec 22 23:24:09 D-69-91-141-110 kernel: system 00:04: [io  0x0250-0x0253] has been reserved
Dec 22 23:24:09 D-69-91-141-110 kernel: system 00:04: [io  0x0256-0x025f] has been reserved
Dec 22 23:24:09 D-69-91-141-110 kernel: system 00:04: [mem 0xfec00000-0xfec00fff] could not be reserved
Dec 22 23:24:09 D-69-91-141-110 kernel: system 00:04: [mem 0xfee00000-0xfee00fff] has been reserved
Dec 22 23:24:09 D-69-91-141-110 kernel: system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
Dec 22 23:24:09 D-69-91-141-110 kernel: system 00:05: [mem 0xe0000000-0xefffffff] has been reserved
Dec 22 23:24:09 D-69-91-141-110 kernel: system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
Dec 22 23:24:09 D-69-91-141-110 kernel: system 00:06: [mem 0x00000000-0x0009ffff] could not be reserved
Dec 22 23:24:09 D-69-91-141-110 kernel: system 00:06: [mem 0x000c0000-0x000cffff] could not be reserved
Dec 22 23:24:09 D-69-91-141-110 kernel: system 00:06: [mem 0x000e0000-0x000fffff] could not be reserved
Dec 22 23:24:09 D-69-91-141-110 kernel: system 00:06: [mem 0x00100000-0xb7ffffff] could not be reserved
Dec 22 23:24:09 D-69-91-141-110 kernel: system 00:06: Plug and Play ACPI device, IDs PNP0c01 (active)
Dec 22 23:24:09 D-69-91-141-110 kernel: pnp: PnP ACPI: found 7 devices
Dec 22 23:24:09 D-69-91-141-110 kernel: PnPBIOS: Disabled
Dec 22 23:24:09 D-69-91-141-110 kernel: clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
Dec 22 23:24:09 D-69-91-141-110 kernel: clocksource: Switched to clocksource acpi_pm
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:01.0: PCI bridge to [bus 01]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:01.0:   bridge window [io  0x9000-0x9fff]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:01.0:   bridge window [mem 0xfa800000-0xfa8fffff]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:01.0:   bridge window [mem 0xbdf00000-0xddefffff pref]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:04.0: PCI bridge to [bus 02]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:04.0:   bridge window [mem 0xfa900000-0xfa9fffff]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:05.0: PCI bridge to [bus 03-05]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:05.0:   bridge window [io  0xa000-0xbfff]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:05.0:   bridge window [mem 0xfaa00000-0xfe9fffff]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:05.0:   bridge window [mem 0xddf00000-0xdfefffff 64bit pref]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:06.0: PCI bridge to [bus 06]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:06.0:   bridge window [mem 0xfea00000-0xfeafffff]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:07.0: PCI bridge to [bus 07]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:14.4: PCI bridge to [bus 08]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000dffff window]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci_bus 0000:00: resource 8 [mem 0xb8000000-0xffffffff window]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci_bus 0000:01: resource 0 [io  0x9000-0x9fff]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci_bus 0000:01: resource 1 [mem 0xfa800000-0xfa8fffff]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci_bus 0000:01: resource 2 [mem 0xbdf00000-0xddefffff pref]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci_bus 0000:02: resource 1 [mem 0xfa900000-0xfa9fffff]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci_bus 0000:03: resource 0 [io  0xa000-0xbfff]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci_bus 0000:03: resource 1 [mem 0xfaa00000-0xfe9fffff]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci_bus 0000:03: resource 2 [mem 0xddf00000-0xdfefffff 64bit pref]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci_bus 0000:06: resource 1 [mem 0xfea00000-0xfeafffff]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci_bus 0000:08: resource 4 [io  0x0000-0x0cf7 window]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci_bus 0000:08: resource 5 [io  0x0d00-0xffff window]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci_bus 0000:08: resource 6 [mem 0x000a0000-0x000bffff window]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci_bus 0000:08: resource 7 [mem 0x000d0000-0x000dffff window]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci_bus 0000:08: resource 8 [mem 0xb8000000-0xffffffff window]
Dec 22 23:24:09 D-69-91-141-110 kernel: NET: Registered protocol family 2
Dec 22 23:24:09 D-69-91-141-110 kernel: TCP established hash table entries: 8192 (order: 3, 32768 bytes)
Dec 22 23:24:09 D-69-91-141-110 kernel: TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
Dec 22 23:24:09 D-69-91-141-110 kernel: TCP: Hash tables configured (established 8192 bind 8192)
Dec 22 23:24:09 D-69-91-141-110 kernel: UDP hash table entries: 512 (order: 2, 16384 bytes)
Dec 22 23:24:09 D-69-91-141-110 kernel: UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
Dec 22 23:24:09 D-69-91-141-110 kernel: NET: Registered protocol family 1
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:00:01.0: MSI quirk detected; subordinate MSI disabled
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:01:05.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
Dec 22 23:24:09 D-69-91-141-110 kernel: pci 0000:06:00.0: [Firmware Bug]: disabling VPD access (can't determine size of non-standard VPD format)
Dec 22 23:24:09 D-69-91-141-110 kernel: PCI: CLS 64 bytes, default 64
Dec 22 23:24:09 D-69-91-141-110 kernel: Unpacking initramfs...
Dec 22 23:24:09 D-69-91-141-110 kernel: Freeing initrd memory: 18016K
Dec 22 23:24:09 D-69-91-141-110 kernel: audit: initializing netlink subsys (disabled)
Dec 22 23:24:09 D-69-91-141-110 kernel: audit: type=2000 audit(1514003042.842:1): state=initialized audit_enabled=0 res=1
Dec 22 23:24:09 D-69-91-141-110 kernel: workingset: timestamp_bits=14 max_order=20 bucket_order=6
Dec 22 23:24:09 D-69-91-141-110 kernel: zbud: loaded
Dec 22 23:24:09 D-69-91-141-110 kernel: bounce: pool size: 64 pages
Dec 22 23:24:09 D-69-91-141-110 kernel: Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
Dec 22 23:24:09 D-69-91-141-110 kernel: io scheduler noop registered
Dec 22 23:24:09 D-69-91-141-110 kernel: io scheduler deadline registered
Dec 22 23:24:09 D-69-91-141-110 kernel: io scheduler cfq registered (default)
Dec 22 23:24:09 D-69-91-141-110 kernel: io scheduler mq-deadline registered
Dec 22 23:24:09 D-69-91-141-110 kernel: io scheduler kyber registered
Dec 22 23:24:09 D-69-91-141-110 kernel: intel_idle: does not run on family 6 model 15
Dec 22 23:24:09 D-69-91-141-110 kernel: tsc: Marking TSC unstable due to TSC halts in idle
Dec 22 23:24:09 D-69-91-141-110 kernel: GHES: HEST is not enabled!
Dec 22 23:24:09 D-69-91-141-110 kernel: isapnp: Scanning for PnP cards...
Dec 22 23:24:09 D-69-91-141-110 kernel: isapnp: No Plug & Play device found
Dec 22 23:24:09 D-69-91-141-110 kernel: Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
Dec 22 23:24:09 D-69-91-141-110 kernel: Linux agpgart interface v0.103
Dec 22 23:24:09 D-69-91-141-110 kernel: i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
Dec 22 23:24:09 D-69-91-141-110 kernel: i8042: Detected active multiplexing controller, rev 1.1
Dec 22 23:24:09 D-69-91-141-110 kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Dec 22 23:24:09 D-69-91-141-110 kernel: serio: i8042 AUX0 port at 0x60,0x64 irq 12
Dec 22 23:24:09 D-69-91-141-110 kernel: serio: i8042 AUX1 port at 0x60,0x64 irq 12
Dec 22 23:24:09 D-69-91-141-110 kernel: serio: i8042 AUX2 port at 0x60,0x64 irq 12
Dec 22 23:24:09 D-69-91-141-110 kernel: serio: i8042 AUX3 port at 0x60,0x64 irq 12
Dec 22 23:24:09 D-69-91-141-110 kernel: mousedev: PS/2 mouse device common for all mice
Dec 22 23:24:09 D-69-91-141-110 kernel: rtc_cmos 00:00: RTC can wake from S4
Dec 22 23:24:09 D-69-91-141-110 kernel: rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
Dec 22 23:24:09 D-69-91-141-110 kernel: rtc_cmos 00:00: alarms up to one month, y3k, 114 bytes nvram
Dec 22 23:24:09 D-69-91-141-110 kernel: ledtrig-cpu: registered to indicate activity on CPUs
Dec 22 23:24:09 D-69-91-141-110 kernel: NET: Registered protocol family 10
Dec 22 23:24:09 D-69-91-141-110 kernel: Segment Routing with IPv6
Dec 22 23:24:09 D-69-91-141-110 kernel: mip6: Mobile IPv6
Dec 22 23:24:09 D-69-91-141-110 kernel: NET: Registered protocol family 17
Dec 22 23:24:09 D-69-91-141-110 kernel: mpls_gso: MPLS GSO support
Dec 22 23:24:09 D-69-91-141-110 kernel: microcode: sig=0x6fd, pf=0x80, revision=0xa4
Dec 22 23:24:09 D-69-91-141-110 kernel: microcode: Microcode Update Driver: v2.2.
Dec 22 23:24:09 D-69-91-141-110 kernel: Using IPI No-Shortcut mode
Dec 22 23:24:09 D-69-91-141-110 kernel: registered taskstats version 1
Dec 22 23:24:09 D-69-91-141-110 kernel: zswap: loaded using pool lzo/zbud
Dec 22 23:24:09 D-69-91-141-110 kernel: ima: No TPM chip found, activating TPM-bypass! (rc=-19)
Dec 22 23:24:09 D-69-91-141-110 kernel: rtc_cmos 00:00: setting system clock to 2017-12-23 04:24:03 UTC (1514003043)
Dec 22 23:24:09 D-69-91-141-110 kernel: PM: Hibernation image not present or could not be loaded.
Dec 22 23:24:09 D-69-91-141-110 kernel: Freeing unused kernel memory: 796K
Dec 22 23:24:09 D-69-91-141-110 kernel: Write protecting the kernel text: 5932k
Dec 22 23:24:09 D-69-91-141-110 kernel: Write protecting the kernel read-only data: 1828k
Dec 22 23:24:09 D-69-91-141-110 kernel: NX-protecting the kernel data: 4308k
Dec 22 23:24:09 D-69-91-141-110 kernel: x86/mm: Found insecure W+X mapping at address c00a0000/0xc00a0000
Dec 22 23:24:09 D-69-91-141-110 kernel: ------------[ cut here ]------------
Dec 22 23:24:09 D-69-91-141-110 kernel: WARNING: CPU: 0 PID: 1 at arch/x86/mm/dump_pagetables.c:236 note_page+0x5f4/0x7b0
Dec 22 23:24:09 D-69-91-141-110 kernel: Modules linked in:
Dec 22 23:24:09 D-69-91-141-110 kernel: CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.13.0 #1
Dec 22 23:24:09 D-69-91-141-110 kernel: Hardware name: ASUSTeK Computer Inc. F5RL                /F5RL      , BIOS 210     06/12/2008
Dec 22 23:24:09 D-69-91-141-110 kernel: task: f74f9340 task.stack: f74fa000
Dec 22 23:24:09 D-69-91-141-110 kernel: EIP: note_page+0x5f4/0x7b0
Dec 22 23:24:09 D-69-91-141-110 kernel: EFLAGS: 00210286 CPU: 0
Dec 22 23:24:09 D-69-91-141-110 kernel: EAX: 00000041 EBX: f74fbf74 ECX: d2921804 EDX: 00000000
Dec 22 23:24:09 D-69-91-141-110 kernel: ESI: 00000000 EDI: 00000002 EBP: 00000000 ESP: f74fbf14
Dec 22 23:24:09 D-69-91-141-110 kernel:  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
Dec 22 23:24:09 D-69-91-141-110 kernel: CR0: 80050033 CR2: ff9ff000 CR3: 1290d000 CR4: 000006f0
Dec 22 23:24:09 D-69-91-141-110 kernel: Call Trace:
Dec 22 23:24:09 D-69-91-141-110 kernel:  ? ptdump_walk_pgd_level_core+0x1e5/0x2f0
Dec 22 23:24:09 D-69-91-141-110 kernel:  ? rest_init+0xa0/0xa0
Dec 22 23:24:09 D-69-91-141-110 kernel:  ? kernel_init+0x2b/0xe2
Dec 22 23:24:09 D-69-91-141-110 kernel:  ? ret_from_fork+0x19/0x24
Dec 22 23:24:09 D-69-91-141-110 kernel: Code: fc ff ff 83 c2 0c c7 43 18 00 00 00 00 89 53 14 e9 e2 fb ff ff 8b 42 0c c6 05 85 5b 81 d2 01 50 50 68 40 78 6d d2 e8 03 08 06 00 <0f> ff 83 c4 0c e9 78 fa ff ff ff 72 10 68 28 77 6d d2 e8 ec 07
Dec 22 23:24:09 D-69-91-141-110 kernel: ---[ end trace 0df8afcff5530a5e ]---
Dec 22 23:24:09 D-69-91-141-110 kernel: x86/mm: Checked W+X mappings: FAILED, 96 W+X pages found.
Dec 22 23:24:09 D-69-91-141-110 kernel: input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
Dec 22 23:24:09 D-69-91-141-110 kernel: Atheros(R) L2 Ethernet Driver - version 2.2.3
Dec 22 23:24:09 D-69-91-141-110 kernel: Copyright (c) 2007 Atheros Corporation.
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: bus type USB registered
Dec 22 23:24:09 D-69-91-141-110 kernel: usbcore: registered new interface driver usbfs
Dec 22 23:24:09 D-69-91-141-110 kernel: usbcore: registered new interface driver hub
Dec 22 23:24:09 D-69-91-141-110 kernel: usbcore: registered new device driver usb
Dec 22 23:24:09 D-69-91-141-110 kernel: ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
Dec 22 23:24:09 D-69-91-141-110 kernel: ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
Dec 22 23:24:09 D-69-91-141-110 kernel: ehci-pci: EHCI PCI platform driver
Dec 22 23:24:09 D-69-91-141-110 kernel: ehci-pci 0000:00:13.5: EHCI Host Controller
Dec 22 23:24:09 D-69-91-141-110 kernel: ehci-pci 0000:00:13.5: new USB bus registered, assigned bus number 1
Dec 22 23:24:09 D-69-91-141-110 kernel: ehci-pci 0000:00:13.5: debug port 1
Dec 22 23:24:09 D-69-91-141-110 kernel: ehci-pci 0000:00:13.5: irq 19, io mem 0xfebff800
Dec 22 23:24:09 D-69-91-141-110 kernel: SCSI subsystem initialized
Dec 22 23:24:09 D-69-91-141-110 kernel: libata version 3.00 loaded.
Dec 22 23:24:09 D-69-91-141-110 kernel: ehci-pci 0000:00:13.5: USB 2.0 started, EHCI 1.00
Dec 22 23:24:09 D-69-91-141-110 kernel: usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
Dec 22 23:24:09 D-69-91-141-110 kernel: usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Dec 22 23:24:09 D-69-91-141-110 kernel: usb usb1: Product: EHCI Host Controller
Dec 22 23:24:09 D-69-91-141-110 kernel: usb usb1: Manufacturer: Linux 4.13.0 ehci_hcd
Dec 22 23:24:09 D-69-91-141-110 kernel: usb usb1: SerialNumber: 0000:00:13.5
Dec 22 23:24:09 D-69-91-141-110 kernel: hub 1-0:1.0: USB hub found
Dec 22 23:24:09 D-69-91-141-110 kernel: hub 1-0:1.0: 10 ports detected
Dec 22 23:24:09 D-69-91-141-110 kernel: ohci-pci: OHCI PCI platform driver
Dec 22 23:24:09 D-69-91-141-110 kernel: ohci-pci 0000:00:13.0: OHCI PCI host controller
Dec 22 23:24:09 D-69-91-141-110 kernel: ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 2
Dec 22 23:24:09 D-69-91-141-110 kernel: ohci-pci 0000:00:13.0: irq 16, io mem 0xfebfe000
Dec 22 23:24:09 D-69-91-141-110 kernel: usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
Dec 22 23:24:09 D-69-91-141-110 kernel: usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Dec 22 23:24:09 D-69-91-141-110 kernel: usb usb2: Product: OHCI PCI host controller
Dec 22 23:24:09 D-69-91-141-110 kernel: usb usb2: Manufacturer: Linux 4.13.0 ohci_hcd
Dec 22 23:24:09 D-69-91-141-110 kernel: usb usb2: SerialNumber: 0000:00:13.0
Dec 22 23:24:09 D-69-91-141-110 kernel: hub 2-0:1.0: USB hub found
Dec 22 23:24:09 D-69-91-141-110 kernel: hub 2-0:1.0: 2 ports detected
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI Warning: SystemIO range 0x0000000000000B00-0x0000000000000B08 conflicts with OpRegion 0x0000000000000B00-0x0000000000000B0F (\SMB0) (20170531/utaddress-247)
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
Dec 22 23:24:09 D-69-91-141-110 kernel: scsi host0: pata_atiixp
Dec 22 23:24:09 D-69-91-141-110 kernel: scsi host1: pata_atiixp
Dec 22 23:24:09 D-69-91-141-110 kernel: ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xff00 irq 14
Dec 22 23:24:09 D-69-91-141-110 kernel: ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xff08 irq 15
Dec 22 23:24:09 D-69-91-141-110 kernel: ahci 0000:00:12.0: version 3.0
Dec 22 23:24:09 D-69-91-141-110 kernel: ahci 0000:00:12.0: controller can't do 64bit DMA, forcing 32bit
Dec 22 23:24:09 D-69-91-141-110 kernel: ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
Dec 22 23:24:09 D-69-91-141-110 kernel: ahci 0000:00:12.0: flags: ncq sntf ilck led clo pmp pio slum part ccc 
Dec 22 23:24:09 D-69-91-141-110 kernel: scsi host2: ahci
Dec 22 23:24:09 D-69-91-141-110 kernel: scsi host3: ahci
Dec 22 23:24:09 D-69-91-141-110 kernel: scsi host4: ahci
Dec 22 23:24:09 D-69-91-141-110 kernel: scsi host5: ahci
Dec 22 23:24:09 D-69-91-141-110 kernel: ata3: SATA max UDMA/133 abar m1024@0xfebffc00 port 0xfebffd00 irq 22
Dec 22 23:24:09 D-69-91-141-110 kernel: ata4: SATA max UDMA/133 abar m1024@0xfebffc00 port 0xfebffd80 irq 22
Dec 22 23:24:09 D-69-91-141-110 kernel: ata5: SATA max UDMA/133 abar m1024@0xfebffc00 port 0xfebffe00 irq 22
Dec 22 23:24:09 D-69-91-141-110 kernel: ata6: SATA max UDMA/133 abar m1024@0xfebffc00 port 0xfebffe80 irq 22
Dec 22 23:24:09 D-69-91-141-110 kernel: ohci-pci 0000:00:13.1: OHCI PCI host controller
Dec 22 23:24:09 D-69-91-141-110 kernel: ohci-pci 0000:00:13.1: new USB bus registered, assigned bus number 3
Dec 22 23:24:09 D-69-91-141-110 kernel: ohci-pci 0000:00:13.1: irq 17, io mem 0xfebfd000
Dec 22 23:24:09 D-69-91-141-110 kernel: (NULL device *): hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
Dec 22 23:24:09 D-69-91-141-110 kernel: thermal LNXTHERM:00: registered as thermal_zone0
Dec 22 23:24:09 D-69-91-141-110 kernel: ACPI: Thermal Zone [THRM] (76 C)
Dec 22 23:24:09 D-69-91-141-110 kernel: usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
Dec 22 23:24:09 D-69-91-141-110 kernel: usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Dec 22 23:24:09 D-69-91-141-110 kernel: usb usb3: Product: OHCI PCI host controller
Dec 22 23:24:09 D-69-91-141-110 kernel: usb usb3: Manufacturer: Linux 4.13.0 ohci_hcd
Dec 22 23:24:09 D-69-91-141-110 kernel: usb usb3: SerialNumber: 0000:00:13.1
Dec 22 23:24:09 D-69-91-141-110 kernel: hub 3-0:1.0: USB hub found
Dec 22 23:24:09 D-69-91-141-110 kernel: hub 3-0:1.0: 2 ports detected
Dec 22 23:24:09 D-69-91-141-110 kernel: ohci-pci 0000:00:13.2: OHCI PCI host controller
Dec 22 23:24:09 D-69-91-141-110 kernel: ohci-pci 0000:00:13.2: new USB bus registered, assigned bus number 4
Dec 22 23:24:09 D-69-91-141-110 kernel: ohci-pci 0000:00:13.2: irq 18, io mem 0xfebfc000
Dec 22 23:24:09 D-69-91-141-110 kernel: usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
Dec 22 23:24:09 D-69-91-141-110 kernel: usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Dec 22 23:24:09 D-69-91-141-110 kernel: usb usb4: Product: OHCI PCI host controller
Dec 22 23:24:09 D-69-91-141-110 kernel: usb usb4: Manufacturer: Linux 4.13.0 ohci_hcd
Dec 22 23:24:09 D-69-91-141-110 kernel: usb usb4: SerialNumber: 0000:00:13.2
Dec 22 23:24:09 D-69-91-141-110 kernel: hub 4-0:1.0: USB hub found
Dec 22 23:24:09 D-69-91-141-110 kernel: hub 4-0:1.0: 2 ports detected
Dec 22 23:24:09 D-69-91-141-110 kernel: ohci-pci 0000:00:13.3: OHCI PCI host controller
Dec 22 23:24:09 D-69-91-141-110 kernel: ohci-pci 0000:00:13.3: new USB bus registered, assigned bus number 5
Dec 22 23:24:09 D-69-91-141-110 kernel: ohci-pci 0000:00:13.3: irq 17, io mem 0xfebfb000
Dec 22 23:24:09 D-69-91-141-110 kernel: ata1.00: ATAPI: HL-DT-ST DVDRAM GSA-T40N, JR03, max UDMA/33
Dec 22 23:24:09 D-69-91-141-110 kernel: usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
Dec 22 23:24:09 D-69-91-141-110 kernel: usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Dec 22 23:24:09 D-69-91-141-110 kernel: usb usb5: Product: OHCI PCI host controller
Dec 22 23:24:09 D-69-91-141-110 kernel: usb usb5: Manufacturer: Linux 4.13.0 ohci_hcd
Dec 22 23:24:09 D-69-91-141-110 kernel: usb usb5: SerialNumber: 0000:00:13.3
Dec 22 23:24:09 D-69-91-141-110 kernel: hub 5-0:1.0: USB hub found
Dec 22 23:24:09 D-69-91-141-110 kernel: hub 5-0:1.0: 2 ports detected
Dec 22 23:24:09 D-69-91-141-110 kernel: ohci-pci 0000:00:13.4: OHCI PCI host controller
Dec 22 23:24:09 D-69-91-141-110 kernel: ohci-pci 0000:00:13.4: new USB bus registered, assigned bus number 6
Dec 22 23:24:09 D-69-91-141-110 kernel: ohci-pci 0000:00:13.4: irq 18, io mem 0xfebfa000
Dec 22 23:24:09 D-69-91-141-110 kernel: ata1.00: configured for UDMA/33
Dec 22 23:24:09 D-69-91-141-110 kernel: scsi 0:0:0:0: CD-ROM            HL-DT-ST DVDRAM GSA-T40N  JR03 PQ: 0 ANSI: 5
Dec 22 23:24:09 D-69-91-141-110 kernel: usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
Dec 22 23:24:09 D-69-91-141-110 kernel: usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Dec 22 23:24:09 D-69-91-141-110 kernel: usb usb6: Product: OHCI PCI host controller
Dec 22 23:24:09 D-69-91-141-110 kernel: usb usb6: Manufacturer: Linux 4.13.0 ohci_hcd
Dec 22 23:24:09 D-69-91-141-110 kernel: usb usb6: SerialNumber: 0000:00:13.4
Dec 22 23:24:09 D-69-91-141-110 kernel: hub 6-0:1.0: USB hub found
Dec 22 23:24:09 D-69-91-141-110 kernel: hub 6-0:1.0: 2 ports detected
Dec 22 23:24:09 D-69-91-141-110 kernel: usb 1-4: new high-speed USB device number 2 using ehci-pci
Dec 22 23:24:09 D-69-91-141-110 kernel: ata5: SATA link down (SStatus 0 SControl 300)
Dec 22 23:24:09 D-69-91-141-110 kernel: ata6: SATA link down (SStatus 0 SControl 300)
Dec 22 23:24:09 D-69-91-141-110 kernel: ata4: SATA link down (SStatus 0 SControl 300)
Dec 22 23:24:09 D-69-91-141-110 kernel: usb 1-4: New USB device found, idVendor=0bda, idProduct=0116
Dec 22 23:24:09 D-69-91-141-110 kernel: usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
Dec 22 23:24:09 D-69-91-141-110 kernel: usb 1-4: Product: USB2.0-CRW
Dec 22 23:24:09 D-69-91-141-110 kernel: usb 1-4: Manufacturer: Generic
Dec 22 23:24:09 D-69-91-141-110 kernel: usb 1-4: SerialNumber: 20021111153705700
Dec 22 23:24:09 D-69-91-141-110 kernel: usb-storage 1-4:1.0: USB Mass Storage device detected
Dec 22 23:24:09 D-69-91-141-110 kernel: scsi host6: usb-storage 1-4:1.0
Dec 22 23:24:09 D-69-91-141-110 kernel: usbcore: registered new interface driver usb-storage
Dec 22 23:24:09 D-69-91-141-110 kernel: usbcore: registered new interface driver uas
Dec 22 23:24:09 D-69-91-141-110 kernel: clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x17f6f6905fe, max_idle_ns: 440795236614 ns
Dec 22 23:24:09 D-69-91-141-110 kernel: ata3: softreset failed (device not ready)
Dec 22 23:24:09 D-69-91-141-110 kernel: ata3: applying PMP SRST workaround and retrying
Dec 22 23:24:09 D-69-91-141-110 kernel: usb 1-7: new high-speed USB device number 3 using ehci-pci
Dec 22 23:24:09 D-69-91-141-110 kernel: ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Dec 22 23:24:09 D-69-91-141-110 kernel: ata3.00: ATA-8: ST9250827AS, 3.AAA, max UDMA/133
Dec 22 23:24:09 D-69-91-141-110 kernel: ata3.00: 488397168 sectors, multi 16: LBA48 NCQ (depth 31/32)
Dec 22 23:24:09 D-69-91-141-110 kernel: ata3.00: SB600 AHCI: limiting to 255 sectors per cmd
Dec 22 23:24:09 D-69-91-141-110 kernel: ata3.00: SB600 AHCI: limiting to 255 sectors per cmd
Dec 22 23:24:09 D-69-91-141-110 kernel: ata3.00: configured for UDMA/133
Dec 22 23:24:09 D-69-91-141-110 kernel: scsi 2:0:0:0: Direct-Access     ATA      ST9250827AS      A    PQ: 0 ANSI: 5
Dec 22 23:24:09 D-69-91-141-110 kernel: sd 2:0:0:0: [sda] 488397168 512-byte logical blocks: (250 GB/233 GiB)
Dec 22 23:24:09 D-69-91-141-110 kernel: sd 2:0:0:0: [sda] Write Protect is off
Dec 22 23:24:09 D-69-91-141-110 kernel: sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
Dec 22 23:24:09 D-69-91-141-110 kernel: sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Dec 22 23:24:09 D-69-91-141-110 kernel: sr 0:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
Dec 22 23:24:09 D-69-91-141-110 kernel: cdrom: Uniform CD-ROM driver Revision: 3.20
Dec 22 23:24:09 D-69-91-141-110 kernel: sr 0:0:0:0: Attached scsi CD-ROM sr0
Dec 22 23:24:09 D-69-91-141-110 kernel: usb 1-7: New USB device found, idVendor=174f, idProduct=5a31
Dec 22 23:24:09 D-69-91-141-110 kernel: usb 1-7: New USB device strings: Mfr=2, Product=1, SerialNumber=3
Dec 22 23:24:09 D-69-91-141-110 kernel: usb 1-7: Product: USB 2.0 Camera
Dec 22 23:24:09 D-69-91-141-110 kernel: usb 1-7: Manufacturer: Sonix Technology Co., Ltd.
Dec 22 23:24:09 D-69-91-141-110 kernel: usb 1-7: SerialNumber: SN0001
Dec 22 23:24:09 D-69-91-141-110 kernel:  sda: sda1 sda2 < sda5 >
Dec 22 23:24:09 D-69-91-141-110 kernel: sd 2:0:0:0: [sda] Attached SCSI disk
Dec 22 23:24:09 D-69-91-141-110 kernel: psmouse serio4: synaptics: Touchpad model: 1, fw: 6.1, id: 0xa3a0b3, caps: 0xa04713/0x10008/0x0/0x0, board id: 0, fw id: 30712
Dec 22 23:24:09 D-69-91-141-110 kernel: input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio4/input/input8
Dec 22 23:24:09 D-69-91-141-110 kernel: PM: Starting manual resume from disk
Dec 22 23:24:09 D-69-91-141-110 kernel: PM: Hibernation image partition 8:5 present
Dec 22 23:24:09 D-69-91-141-110 kernel: PM: Looking for hibernation image.
Dec 22 23:24:09 D-69-91-141-110 kernel: PM: Image not found (code -22)
Dec 22 23:24:09 D-69-91-141-110 kernel: PM: Hibernation image not present or could not be loaded.
Dec 22 23:24:09 D-69-91-141-110 kernel: scsi 6:0:0:0: Direct-Access     Generic- xD/SDMMC/MS/Pro  1.00 PQ: 0 ANSI: 0 CCS
Dec 22 23:24:09 D-69-91-141-110 kernel: sd 6:0:0:0: [sdb] 62333952 512-byte logical blocks: (31.9 GB/29.7 GiB)
Dec 22 23:24:09 D-69-91-141-110 kernel: sd 6:0:0:0: [sdb] Write Protect is off
Dec 22 23:24:09 D-69-91-141-110 kernel: sd 6:0:0:0: [sdb] Mode Sense: 03 00 00 00
Dec 22 23:24:09 D-69-91-141-110 kernel: sd 6:0:0:0: [sdb] No Caching mode page found
Dec 22 23:24:09 D-69-91-141-110 kernel: sd 6:0:0:0: [sdb] Assuming drive cache: write through
Dec 22 23:24:09 D-69-91-141-110 kernel:  sdb: sdb1
Dec 22 23:24:09 D-69-91-141-110 kernel: sd 6:0:0:0: [sdb] Attached SCSI removable disk
Dec 22 23:24:09 D-69-91-141-110 kernel: EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
Dec 22 23:24:09 D-69-91-141-110 kernel: random: crng init done
Dec 22 23:24:09 D-69-91-141-110 kernel: ip_tables: (C) 2000-2006 Netfilter Core Team
Dec 22 23:24:09 D-69-91-141-110 systemd[1]: systemd 232 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
Dec 22 23:24:09 D-69-91-141-110 systemd[1]: Detected architecture x86.
Dec 22 23:24:09 D-69-91-141-110 systemd[1]: Set hostname to <D-69-91-141-110>.
Dec 22 23:24:09 D-69-91-141-110 systemd[1]: Listening on Syslog Socket.
Dec 22 23:24:09 D-69-91-141-110 systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
Dec 22 23:24:09 D-69-91-141-110 systemd[1]: Created slice System Slice.
Dec 22 23:24:09 D-69-91-141-110 systemd[1]: Mounting Huge Pages File System...
Dec 22 23:24:09 D-69-91-141-110 systemd[1]: Listening on udev Kernel Socket.
Dec 22 23:24:09 D-69-91-141-110 systemd[1]: Reached target Remote File Systems.
Dec 22 23:24:09 D-69-91-141-110 systemd[1]: Created slice system-getty.slice.
Dec 22 23:24:09 D-69-91-141-110 systemd-journald[186]: Journal started
Dec 22 23:24:09 D-69-91-141-110 systemd-journald[186]: Runtime journal (/run/log/journal/232ecae4e62643e0ac09bafad7167a6f) is 3.3M, max 26.5M, 23.1M free.
Dec 22 23:24:10 D-69-91-141-110 systemd[1]: Mounted Huge Pages File System.
Dec 22 23:24:10 D-69-91-141-110 systemd[1]: Mounted Debug File System.
Dec 22 23:24:10 D-69-91-141-110 systemd[1]: Mounted POSIX Message Queue File System.
Dec 22 23:24:10 D-69-91-141-110 systemd[1]: Started Apply Kernel Variables.
Dec 22 23:24:10 D-69-91-141-110 kernel: EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
Dec 22 23:24:10 D-69-91-141-110 systemd[1]: Started Remount Root and Kernel File Systems.
Dec 22 23:24:10 D-69-91-141-110 systemd[1]: Starting Flush Journal to Persistent Storage...
Dec 22 23:24:10 D-69-91-141-110 systemd[1]: Starting Load/Save Random Seed...
Dec 22 23:24:10 D-69-91-141-110 systemd[1]: Starting udev Coldplug all Devices...
Dec 22 23:24:10 D-69-91-141-110 systemd-journald[186]: Time spent on flushing to /var is 26.577ms for 655 entries.
Dec 22 23:24:10 D-69-91-141-110 systemd-journald[186]: System journal (/var/log/journal/232ecae4e62643e0ac09bafad7167a6f) is 688.1M, max 2.5G, 1.8G free.
Dec 22 23:24:18 D-69-91-141-110 kernel: ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
Dec 22 23:24:18 D-69-91-141-110 kernel: input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input9
Dec 22 23:24:18 D-69-91-141-110 kernel: ACPI: Lid Switch [LID]
Dec 22 23:24:18 D-69-91-141-110 kernel: input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input10
Dec 22 23:24:18 D-69-91-141-110 kernel: ACPI: Power Button [PWRB]
Dec 22 23:24:18 D-69-91-141-110 kernel: input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input11
Dec 22 23:24:18 D-69-91-141-110 kernel: ACPI: Sleep Button [SLPB]
Dec 22 23:24:18 D-69-91-141-110 kernel: input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input12
Dec 22 23:24:18 D-69-91-141-110 kernel: ACPI: Power Button [PWRF]
Dec 22 23:24:18 D-69-91-141-110 kernel: acpi device:02: registered as cooling_device2
Dec 22 23:24:18 D-69-91-141-110 kernel: input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A03:00/device:00/LNXVIDEO:00/input/input13
Dec 22 23:24:18 D-69-91-141-110 kernel: ACPI: Battery Slot [BAT0] (battery absent)
Dec 22 23:24:18 D-69-91-141-110 kernel: sr 0:0:0:0: Attached scsi generic sg0 type 5
Dec 22 23:24:18 D-69-91-141-110 kernel: sd 2:0:0:0: Attached scsi generic sg1 type 0
Dec 22 23:24:18 D-69-91-141-110 kernel: sd 6:0:0:0: Attached scsi generic sg2 type 0
Dec 22 23:24:18 D-69-91-141-110 kernel: shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
Dec 22 23:24:18 D-69-91-141-110 kernel: sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver v0.05
Dec 22 23:24:18 D-69-91-141-110 kernel: sp5100_tco: PCI Vendor ID: 0x1002, Device ID: 0x4385, Revision ID: 0x13
Dec 22 23:24:18 D-69-91-141-110 kernel: sp5100_tco: failed to find MMIO address, giving up.
Dec 22 23:24:18 D-69-91-141-110 kernel: ACPI: AC Adapter [AC0] (on-line)
Dec 22 23:24:18 D-69-91-141-110 kernel: asus_laptop: Asus Laptop Support version 0.42
Dec 22 23:24:18 D-69-91-141-110 kernel: asus_laptop:   F5RL model detected
Dec 22 23:24:18 D-69-91-141-110 kernel: input: Asus Laptop extra buttons as /devices/platform/asus_laptop/input/input14
Dec 22 23:24:18 D-69-91-141-110 kernel: input: PC Speaker as /devices/platform/pcspkr/input/input15
Dec 22 23:24:18 D-69-91-141-110 kernel: snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC660-VD: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
Dec 22 23:24:18 D-69-91-141-110 kernel: snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
Dec 22 23:24:18 D-69-91-141-110 kernel: snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
Dec 22 23:24:18 D-69-91-141-110 kernel: snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
Dec 22 23:24:18 D-69-91-141-110 kernel: snd_hda_codec_realtek hdaudioC0D0:    inputs:
Dec 22 23:24:18 D-69-91-141-110 kernel: snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x19
Dec 22 23:24:18 D-69-91-141-110 kernel: snd_hda_codec_realtek hdaudioC0D0:      Mic=0x18
Dec 22 23:24:18 D-69-91-141-110 kernel: intel_powerclamp: No package C-state available
Dec 22 23:24:18 D-69-91-141-110 kernel: intel_powerclamp: No package C-state available
Dec 22 23:24:18 D-69-91-141-110 kernel: ath5k 0000:02:00.0: can't disable ASPM; OS doesn't have ASPM control
Dec 22 23:24:18 D-69-91-141-110 kernel: ath5k 0000:02:00.0: registered as 'phy0'
Dec 22 23:24:18 D-69-91-141-110 kernel: input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:14.2/sound/card0/input16
Dec 22 23:24:18 D-69-91-141-110 kernel: input: HDA ATI SB Mic as /devices/pci0000:00/0000:00:14.2/sound/card0/input17
Dec 22 23:24:18 D-69-91-141-110 kernel: input: HDA ATI SB Headphone as /devices/pci0000:00/0000:00:14.2/sound/card0/input18
Dec 22 23:24:18 D-69-91-141-110 kernel: ath: EEPROM regdomain: 0x60
Dec 22 23:24:18 D-69-91-141-110 kernel: ath: EEPROM indicates we should expect a direct regpair map
Dec 22 23:24:18 D-69-91-141-110 kernel: ath: Country alpha2 being used: 00
Dec 22 23:24:18 D-69-91-141-110 kernel: ath: Regpair used: 0x60
Dec 22 23:24:18 D-69-91-141-110 kernel: [drm] radeon kernel modesetting enabled.
Dec 22 23:24:18 D-69-91-141-110 kernel: [drm] initializing kernel modesetting (RS400 0x1002:0x5A62 0x1043:0x1402 0x00).
Dec 22 23:24:18 D-69-91-141-110 kernel: [drm] Generation 2 PCI interface, using max accessible memory
Dec 22 23:24:18 D-69-91-141-110 kernel: radeon 0000:01:05.0: VRAM: 128M 0x00000000B8000000 - 0x00000000BFFFFFFF (128M used)
Dec 22 23:24:18 D-69-91-141-110 kernel: radeon 0000:01:05.0: GTT: 512M 0x0000000080000000 - 0x000000009FFFFFFF
Dec 22 23:24:18 D-69-91-141-110 kernel: [drm] Detected VRAM RAM=128M, BAR=256M
Dec 22 23:24:18 D-69-91-141-110 kernel: [drm] RAM width 128bits DDR
Dec 22 23:24:18 D-69-91-141-110 kernel: [TTM] Zone  kernel: Available graphics memory: 305880 kiB
Dec 22 23:24:18 D-69-91-141-110 kernel: [TTM] Zone highmem: Available graphics memory: 1357340 kiB
Dec 22 23:24:18 D-69-91-141-110 kernel: [TTM] Initializing pool allocator
Dec 22 23:24:18 D-69-91-141-110 kernel: [TTM] Initializing DMA pool allocator
Dec 22 23:24:18 D-69-91-141-110 kernel: [drm] radeon: 128M of VRAM memory ready
Dec 22 23:24:18 D-69-91-141-110 kernel: [drm] radeon: 512M of GTT memory ready.
Dec 22 23:24:18 D-69-91-141-110 kernel: [drm] GART: num cpu pages 131072, num gpu pages 131072
Dec 22 23:24:18 D-69-91-141-110 kernel: ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
Dec 22 23:24:18 D-69-91-141-110 kernel: ath5k: phy0: Atheros AR2425 chip found (MAC: 0xe2, PHY: 0x70)
Dec 22 23:24:18 D-69-91-141-110 kernel: [drm] radeon: 3 quad pipes, 1 z pipes initialized.
Dec 22 23:24:18 D-69-91-141-110 kernel: [drm] PCIE GART of 512M enabled (table at 0x0000000033980000).
Dec 22 23:24:18 D-69-91-141-110 kernel: radeon 0000:01:05.0: WB enabled
Dec 22 23:24:18 D-69-91-141-110 kernel: radeon 0000:01:05.0: fence driver on ring 0 use gpu addr 0x0000000080000000 and cpu addr 0xf38e2000
Dec 22 23:24:18 D-69-91-141-110 kernel: [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
Dec 22 23:24:18 D-69-91-141-110 kernel: [drm] Driver supports precise vblank timestamp query.
Dec 22 23:24:18 D-69-91-141-110 kernel: radeon 0000:01:05.0: radeon: MSI limited to 32-bit
Dec 22 23:24:18 D-69-91-141-110 kernel: [drm] radeon: irq initialized.
Dec 22 23:24:18 D-69-91-141-110 kernel: [drm] Loading R300 Microcode
Dec 22 23:24:18 D-69-91-141-110 kernel: [drm] radeon: ring at 0x0000000080001000
Dec 22 23:24:18 D-69-91-141-110 kernel: [drm] ring test succeeded in 0 usecs
Dec 22 23:24:18 D-69-91-141-110 kernel: [drm] ib test succeeded in 0 usecs
Dec 22 23:24:18 D-69-91-141-110 kernel: [drm] Panel ID String: AUO                     
Dec 22 23:24:18 D-69-91-141-110 kernel: [drm] Panel Size 1280x800
Dec 22 23:24:18 D-69-91-141-110 kernel: [drm] Radeon Display Connectors
Dec 22 23:24:18 D-69-91-141-110 kernel: [drm] Connector 0:
Dec 22 23:24:18 D-69-91-141-110 kernel: [drm]   VGA-1
Dec 22 23:24:18 D-69-91-141-110 kernel: [drm]   DDC: 0x68 0x68 0x68 0x68 0x68 0x68 0x68 0x68
Dec 22 23:24:18 D-69-91-141-110 kernel: [drm]   Encoders:
Dec 22 23:24:18 D-69-91-141-110 kernel: [drm]     CRT1: INTERNAL_DAC2
Dec 22 23:24:18 D-69-91-141-110 kernel: [drm] Connector 1:
Dec 22 23:24:18 D-69-91-141-110 kernel: [drm]   LVDS-1
Dec 22 23:24:18 D-69-91-141-110 kernel: [drm]   DDC: 0x198 0x198 0x19c 0x19c 0x1a0 0x1a0 0x1a4 0x1a4
Dec 22 23:24:18 D-69-91-141-110 kernel: [drm]   Encoders:
Dec 22 23:24:18 D-69-91-141-110 kernel: [drm]     LCD1: INTERNAL_LVDS
Dec 22 23:24:18 D-69-91-141-110 kernel: [drm] fb mappable at 0xC0040000
Dec 22 23:24:18 D-69-91-141-110 kernel: [drm] vram apper at 0xC0000000
Dec 22 23:24:18 D-69-91-141-110 kernel: [drm] size 4096000
Dec 22 23:24:18 D-69-91-141-110 kernel: [drm] fb depth is 24
Dec 22 23:24:18 D-69-91-141-110 kernel: [drm]    pitch is 5120
Dec 22 23:24:18 D-69-91-141-110 kernel: fbcon: radeondrmfb (fb0) is primary device
Dec 22 23:24:18 D-69-91-141-110 kernel: Console: switching to colour frame buffer device 160x50
Dec 22 23:24:18 D-69-91-141-110 kernel: radeon 0000:01:05.0: fb0: radeondrmfb frame buffer device
Dec 22 23:24:18 D-69-91-141-110 kernel: [drm] Initialized radeon 2.50.0 20080528 for 0000:01:05.0 on minor 0
Dec 22 23:24:18 D-69-91-141-110 kernel: media: Linux media interface: v0.10
Dec 22 23:24:18 D-69-91-141-110 mtp-probe[281]: checking bus 1, device 2: "/sys/devices/pci0000:00/0000:00:13.5/usb1/1-4"
Dec 22 23:24:10 D-69-91-141-110 systemd[1]: Started Load/Save Random Seed.
Dec 22 23:24:18 D-69-91-141-110 mtp-probe[281]: bus: 1, device: 2 was not an MTP device
Dec 22 23:24:10 D-69-91-141-110 systemd[1]: Started udev Coldplug all Devices.
Dec 22 23:24:18 D-69-91-141-110 mtp-probe[280]: checking bus 1, device 3: "/sys/devices/pci0000:00/0000:00:13.5/usb1/1-7"
Dec 22 23:24:11 D-69-91-141-110 systemd[1]: Started Create Static Device Nodes in /dev.
Dec 22 23:24:18 D-69-91-141-110 mtp-probe[280]: bus: 1, device: 3 was not an MTP device
Dec 22 23:24:11 D-69-91-141-110 systemd[1]: Starting udev Kernel Device Manager...
Dec 22 23:24:11 D-69-91-141-110 systemd[1]: Started Set the console keyboard layout.
Dec 22 23:24:11 D-69-91-141-110 systemd[1]: Reached target Local File Systems (Pre).
Dec 22 23:24:11 D-69-91-141-110 systemd[1]: Reached target Local File Systems.
Dec 22 23:24:11 D-69-91-141-110 systemd[1]: Starting Set console font and keymap...
Dec 22 23:24:11 D-69-91-141-110 systemd[1]: Starting Raise network interfaces...
Dec 22 23:24:13 D-69-91-141-110 systemd[1]: Started Set console font and keymap.
Dec 22 23:24:14 D-69-91-141-110 systemd[1]: Started udev Kernel Device Manager.
Dec 22 23:24:17 D-69-91-141-110 systemd[1]: Listening on Load/Save RF Kill Switch Status /dev/rfkill Watch.
Dec 22 23:24:17 D-69-91-141-110 systemd[1]: Starting Load/Save RF Kill Switch Status...
Dec 22 23:24:18 D-69-91-141-110 systemd[1]: Created slice system-systemd\x2dbacklight.slice.
Dec 22 23:24:18 D-69-91-141-110 systemd[1]: Starting Load/Save Screen Backlight Brightness of backlight:acpi_video0...
Dec 22 23:24:18 D-69-91-141-110 systemd[1]: Started Flush Journal to Persistent Storage.
Dec 22 23:24:18 D-69-91-141-110 systemd[1]: Starting Create Volatile Files and Directories...
Dec 22 23:24:18 D-69-91-141-110 kernel: Linux video capture interface: v2.00
Dec 22 23:24:18 D-69-91-141-110 systemd[1]: Started Load/Save Screen Backlight Brightness of backlight:acpi_video0.
Dec 22 23:24:19 D-69-91-141-110 kernel: uvcvideo: Found UVC 1.00 device USB 2.0 Camera (174f:5a31)
Dec 22 23:24:19 D-69-91-141-110 kernel: uvcvideo 1-7:1.0: Entity type for entity Extension 4 was not initialized!
Dec 22 23:24:19 D-69-91-141-110 kernel: uvcvideo 1-7:1.0: Entity type for entity Processing 3 was not initialized!
Dec 22 23:24:19 D-69-91-141-110 kernel: uvcvideo 1-7:1.0: Entity type for entity Camera 1 was not initialized!
Dec 22 23:24:19 D-69-91-141-110 kernel: input: USB 2.0 Camera: USB 2.0 Camera as /devices/pci0000:00/0000:00:13.5/usb1/1-7/1-7:1.0/input/input19
Dec 22 23:24:19 D-69-91-141-110 kernel: usbcore: registered new interface driver uvcvideo
Dec 22 23:24:19 D-69-91-141-110 kernel: USB Video Class driver (1.1.1)
Dec 22 23:24:19 D-69-91-141-110 systemd[1]: Found device ST9250827AS 5.
Dec 22 23:24:19 D-69-91-141-110 systemd[1]: Reached target Sound Card.
Dec 22 23:24:19 D-69-91-141-110 systemd[1]: Activating swap /dev/disk/by-uuid/5e6263b1-75fa-4003-bc51-9dd4c11f7177...
Dec 22 23:24:19 D-69-91-141-110 systemd[1]: Started Raise network interfaces.
Dec 22 23:24:19 D-69-91-141-110 systemd[1]: Reached target Network.
Dec 22 23:24:19 D-69-91-141-110 systemd[1]: Reached target Network is Online.
Dec 22 23:24:19 D-69-91-141-110 systemd-tmpfiles[316]: Cannot set file attribute for '/var/log/journal', value=0x00800000, mask=0x00800000: Operation not supported
Dec 22 23:24:19 D-69-91-141-110 systemd-tmpfiles[316]: Cannot set file attribute for '/var/log/journal/232ecae4e62643e0ac09bafad7167a6f', value=0x00800000, mask=0x00800000: Operation not supported
Dec 22 23:24:19 D-69-91-141-110 systemd[1]: Started Create Volatile Files and Directories.
Dec 22 23:24:19 D-69-91-141-110 systemd[1]: Starting Network Time Synchronization...
Dec 22 23:24:19 D-69-91-141-110 systemd[1]: Starting Update UTMP about System Boot/Shutdown...
Dec 22 23:24:19 D-69-91-141-110 systemd[1]: Started Network Time Synchronization.
Dec 22 23:24:19 D-69-91-141-110 systemd[1]: Reached target System Time Synchronized.
Dec 22 23:24:20 D-69-91-141-110 kernel: Adding 3929084k swap on /dev/sda5.  Priority:-1 extents:1 across:3929084k FS
Dec 22 23:24:20 D-69-91-141-110 systemd[1]: Activated swap /dev/disk/by-uuid/5e6263b1-75fa-4003-bc51-9dd4c11f7177.
Dec 22 23:24:20 D-69-91-141-110 systemd[1]: Reached target Swap.
Dec 22 23:24:20 D-69-91-141-110 systemd[1]: Started Update UTMP about System Boot/Shutdown.
Dec 22 23:24:20 D-69-91-141-110 systemd[1]: Reached target System Initialization.
Dec 22 23:24:20 D-69-91-141-110 systemd[1]: anacron.timer: Adding 1min 35.433723s random time.
Dec 22 23:24:20 D-69-91-141-110 systemd[1]: Started Trigger anacron every hour.
Dec 22 23:24:20 D-69-91-141-110 systemd[1]: Listening on Avahi mDNS/DNS-SD Stack Activation Socket.
Dec 22 23:24:20 D-69-91-141-110 systemd[1]: Listening on D-Bus System Message Bus Socket.
Dec 22 23:24:20 D-69-91-141-110 systemd[1]: apt-daily.timer: Adding 9h 59min 35.098534s random time.
Dec 22 23:24:20 D-69-91-141-110 systemd[1]: Started Daily apt download activities.
Dec 22 23:24:20 D-69-91-141-110 systemd[1]: apt-daily-upgrade.timer: Adding 49min 2.698238s random time.
Dec 22 23:24:20 D-69-91-141-110 systemd[1]: Started Daily apt upgrade and clean activities.
Dec 22 23:24:20 D-69-91-141-110 systemd[1]: Started Daily Cleanup of Temporary Directories.
Dec 22 23:24:20 D-69-91-141-110 systemd[1]: Reached target Timers.
Dec 22 23:24:20 D-69-91-141-110 systemd[1]: Listening on ACPID Listen Socket.
Dec 22 23:24:20 D-69-91-141-110 systemd[1]: Reached target Sockets.
Dec 22 23:24:20 D-69-91-141-110 kernel: FAT-fs (sdb1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
Dec 22 23:24:20 D-69-91-141-110 systemd[1]: Started ACPI Events Check.
Dec 22 23:24:20 D-69-91-141-110 systemd[1]: Reached target Paths.
Dec 22 23:24:20 D-69-91-141-110 systemd[1]: Reached target Basic System.
Dec 22 23:24:20 D-69-91-141-110 systemd[1]: Starting Permit User Sessions...
Dec 22 23:24:20 D-69-91-141-110 systemd[1]: Starting OpenBSD Secure Shell server...
Dec 22 23:24:20 D-69-91-141-110 systemd[1]: Started Regular background program processing daemon.
Dec 22 23:24:20 D-69-91-141-110 systemd[1]: Starting /etc/rc.local Compatibility...
Dec 22 23:24:20 D-69-91-141-110 systemd[1]: Starting Save/Restore Sound Card State...
Dec 22 23:24:20 D-69-91-141-110 systemd[1]: Starting Restore /etc/resolv.conf if the system crashed before the ppp link was shut down...
Dec 22 23:24:20 D-69-91-141-110 systemd[1]: Starting Login Service...
Dec 22 23:24:20 D-69-91-141-110 systemd[1]: Starting Modem Manager...
Dec 22 23:24:20 D-69-91-141-110 systemd[1]: Started D-Bus System Message Bus.
Dec 22 23:24:20 D-69-91-141-110 cron[390]: (CRON) INFO (pidfile fd = 3)
Dec 22 23:24:21 D-69-91-141-110 cron[390]: (CRON) INFO (Running @reboot jobs)
Dec 22 23:24:22 D-69-91-141-110 systemd-udevd[252]: Process '/sbin/crda' failed with exit code 249.
Dec 22 23:24:22 D-69-91-141-110 sshd[389]: /etc/ssh/sshd_config line 19: Deprecated option KeyRegenerationInterval
Dec 22 23:24:22 D-69-91-141-110 sshd[389]: /etc/ssh/sshd_config line 20: Deprecated option ServerKeyBits
Dec 22 23:24:22 D-69-91-141-110 sshd[389]: /etc/ssh/sshd_config line 31: Deprecated option RSAAuthentication
Dec 22 23:24:22 D-69-91-141-110 sshd[389]: /etc/ssh/sshd_config line 38: Deprecated option RhostsRSAAuthentication
Dec 22 23:24:23 D-69-91-141-110 ModemManager[395]: <info>  ModemManager (version 1.6.4) starting in system bus...
Dec 22 23:24:24 D-69-91-141-110 dbus[396]: [system] Successfully activated service 'org.freedesktop.systemd1'
Dec 22 23:24:24 D-69-91-141-110 systemd[1]: Starting LSB: Starts and stops Wicd...
Dec 22 23:24:24 D-69-91-141-110 systemd[1]: Starting keep memory of all UPnP devices that announced themselves...
Dec 22 23:24:24 D-69-91-141-110 systemd[1]: Starting Avahi mDNS/DNS-SD Stack...
Dec 22 23:24:24 D-69-91-141-110 systemd[1]: Started Run anacron jobs.
Dec 22 23:24:24 D-69-91-141-110 systemd[1]: anacron.timer: Adding 25.623927s random time.
Dec 22 23:24:24 D-69-91-141-110 systemd[1]: anacron.timer: Adding 2min 20.752785s random time.
Dec 22 23:24:24 D-69-91-141-110 systemd[1]: Starting System Logging Service...
Dec 22 23:24:24 D-69-91-141-110 systemd[1]: Starting LSB: exim Mail Transport Agent...
Dec 22 23:24:24 D-69-91-141-110 systemd[1]: Started irqbalance daemon.
Dec 22 23:24:24 D-69-91-141-110 systemd[1]: Started ACPI event daemon.
Dec 22 23:24:24 D-69-91-141-110 systemd[1]: Started Load/Save RF Kill Switch Status.
Dec 22 23:24:24 D-69-91-141-110 systemd[1]: Started Permit User Sessions.
Dec 22 23:24:24 D-69-91-141-110 systemd[1]: Started /etc/rc.local Compatibility.
Dec 22 23:24:24 D-69-91-141-110 systemd[1]: Started Restore /etc/resolv.conf if the system crashed before the ppp link was shut down.
Dec 22 23:24:24 D-69-91-141-110 systemd-logind[394]: New seat seat0.
Dec 22 23:24:24 D-69-91-141-110 sshd[452]: /etc/ssh/sshd_config line 19: Deprecated option KeyRegenerationInterval
Dec 22 23:24:24 D-69-91-141-110 sshd[452]: /etc/ssh/sshd_config line 20: Deprecated option ServerKeyBits
Dec 22 23:24:24 D-69-91-141-110 sshd[452]: /etc/ssh/sshd_config line 31: Deprecated option RSAAuthentication
Dec 22 23:24:24 D-69-91-141-110 sshd[452]: /etc/ssh/sshd_config line 38: Deprecated option RhostsRSAAuthentication
Dec 22 23:24:24 D-69-91-141-110 systemd-logind[394]: Watching system buttons on /dev/input/event5 (Power Button)
Dec 22 23:24:24 D-69-91-141-110 systemd-logind[394]: Watching system buttons on /dev/input/event6 (Video Bus)
Dec 22 23:24:24 D-69-91-141-110 systemd-logind[394]: Watching system buttons on /dev/input/event3 (Power Button)
Dec 22 23:24:24 D-69-91-141-110 systemd-logind[394]: Watching system buttons on /dev/input/event2 (Lid Switch)
Dec 22 23:24:24 D-69-91-141-110 systemd-logind[394]: Watching system buttons on /dev/input/event4 (Sleep Button)
Dec 22 23:24:24 D-69-91-141-110 systemd[1]: Started Login Service.
Dec 22 23:24:24 D-69-91-141-110 sshd[452]: Server listening on 0.0.0.0 port 2200.
Dec 22 23:24:24 D-69-91-141-110 sshd[452]: Server listening on :: port 2200.
Dec 22 23:24:24 D-69-91-141-110 systemd[1]: Started Getty on tty1.
Dec 22 23:24:24 D-69-91-141-110 systemd[1]: Reached target Login Prompts.
Dec 22 23:24:24 D-69-91-141-110 systemd[1]: Started OpenBSD Secure Shell server.
Dec 22 23:24:24 D-69-91-141-110 systemd-logind[394]: Watching system buttons on /dev/input/event3 (Power Button)
Dec 22 23:24:24 D-69-91-141-110 systemd-logind[394]: Watching system buttons on /dev/input/event2 (Lid Switch)
Dec 22 23:24:24 D-69-91-141-110 systemd-logind[394]: Watching system buttons on /dev/input/event5 (Power Button)
Dec 22 23:24:24 D-69-91-141-110 systemd-logind[394]: Watching system buttons on /dev/input/event4 (Sleep Button)
Dec 22 23:24:24 D-69-91-141-110 systemd[1]: Started Save/Restore Sound Card State.
Dec 22 23:24:24 D-69-91-141-110 systemd-logind[394]: Watching system buttons on /dev/input/event6 (Video Bus)
Dec 22 23:24:24 D-69-91-141-110 dbus[396]: [system] Activating via systemd: service name='org.freedesktop.PolicyKit1' unit='polkit.service'
Dec 22 23:24:24 D-69-91-141-110 systemd[1]: Starting Authorization Manager...
Dec 22 23:24:24 D-69-91-141-110 anacron[446]: Anacron 2.3 started on 2017-12-22
Dec 22 23:24:24 D-69-91-141-110 minissdpd[444]: setsockopt(udp, IP_ADD_MEMBERSHIP)(0.0.0.0): No such device
Dec 22 23:24:24 D-69-91-141-110 minissdpd[444]: Failed to add IPv4 multicast membership for interface 0.0.0.0.
Dec 22 23:24:24 D-69-91-141-110 systemd[1]: Started keep memory of all UPnP devices that announced themselves.
Dec 22 23:24:24 D-69-91-141-110 avahi-daemon[445]: Found user 'avahi' (UID 106) and group 'avahi' (GID 112).
Dec 22 23:24:24 D-69-91-141-110 avahi-daemon[445]: Successfully dropped root privileges.
Dec 22 23:24:24 D-69-91-141-110 avahi-daemon[445]: avahi-daemon 0.6.32 starting up.
Dec 22 23:24:24 D-69-91-141-110 acpid[450]: starting up with netlink and the input layer
Dec 22 23:24:24 D-69-91-141-110 systemd[1]: Started Avahi mDNS/DNS-SD Stack.
Dec 22 23:24:24 D-69-91-141-110 avahi-daemon[445]: Successfully called chroot().
Dec 22 23:24:24 D-69-91-141-110 avahi-daemon[445]: Successfully dropped remaining capabilities.
Dec 22 23:24:24 D-69-91-141-110 avahi-daemon[445]: No service file found in /etc/avahi/services.
Dec 22 23:24:25 D-69-91-141-110 avahi-daemon[445]: Network interface enumeration completed.
Dec 22 23:24:25 D-69-91-141-110 avahi-daemon[445]: Server startup complete. Host name is D-69-91-141-110.local. Local service cookie is 1892923288.
Dec 22 23:24:25 D-69-91-141-110 acpid[450]: 1 rule loaded
Dec 22 23:24:25 D-69-91-141-110 acpid[450]: waiting for events: event logging is off
Dec 22 23:24:25 D-69-91-141-110 anacron[446]: Normal exit (0 jobs run)
Dec 22 23:24:25 D-69-91-141-110 systemd[1]: anacron.timer: Adding 1min 12.550439s random time.
Dec 22 23:24:25 D-69-91-141-110 liblogging-stdlog[447]:  [origin software="rsyslogd" swVersion="8.24.0" x-pid="447" x-info="http://www.rsyslog.com"] start
Dec 22 23:24:25 D-69-91-141-110 systemd[1]: Started System Logging Service.
Dec 22 23:24:26 D-69-91-141-110 polkitd[458]: started daemon version 0.105 using authority implementation `local' version `0.105'
Dec 22 23:24:26 D-69-91-141-110 dbus[396]: [system] Successfully activated service 'org.freedesktop.PolicyKit1'
Dec 22 23:24:26 D-69-91-141-110 systemd[1]: Started Authorization Manager.
Dec 22 23:24:27 D-69-91-141-110 systemd[1]: Started Modem Manager.
Dec 22 23:24:29 D-69-91-141-110 wicd[442]: Starting Network connection manager: wicd.
Dec 22 23:24:29 D-69-91-141-110 systemd[1]: Started LSB: Starts and stops Wicd.
Dec 22 23:24:29 D-69-91-141-110 exim4[448]: Starting MTA: exim4.
Dec 22 23:24:29 D-69-91-141-110 systemd[1]: Started LSB: exim Mail Transport Agent.
Dec 22 23:24:29 D-69-91-141-110 systemd[1]: Reached target Multi-User System.
Dec 22 23:24:29 D-69-91-141-110 systemd[1]: Starting Update UTMP about System Runlevel Changes...
Dec 22 23:24:29 D-69-91-141-110 systemd[1]: Started Update UTMP about System Runlevel Changes.
Dec 22 23:24:29 D-69-91-141-110 systemd[1]: Startup finished in 4.975s (kernel) + 22.383s (userspace) = 27.359s.
Dec 22 23:24:29 D-69-91-141-110 ModemManager[395]: <info>  Couldn't check support for device at '/sys/devices/pci0000:00/0000:00:04.0/0000:02:00.0': not supported by any plugin
Dec 22 23:24:29 D-69-91-141-110 ModemManager[395]: <info>  Couldn't check support for device at '/sys/devices/pci0000:00/0000:00:06.0/0000:06:00.0': not supported by any plugin
Dec 22 23:24:29 D-69-91-141-110 kernel: NET: Registered protocol family 4
Dec 22 23:24:29 D-69-91-141-110 kernel: NET: Registered protocol family 3
Dec 22 23:24:29 D-69-91-141-110 kernel: NET: Registered protocol family 5
Dec 22 23:24:29 D-69-91-141-110 kernel: IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
Dec 22 23:24:35 D-69-91-141-110 kernel: atl2: eth0 NIC Link is Up<100 Mbps Full Duplex>
Dec 22 23:24:35 D-69-91-141-110 kernel: IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
Dec 22 23:24:35 D-69-91-141-110 kernel: IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
Dec 22 23:24:35 D-69-91-141-110 login[453]: pam_unix(login:session): session opened for user chirvasitua by LOGIN(uid=0)
Dec 22 23:24:35 D-69-91-141-110 systemd[1]: Created slice User Slice of chirvasitua.
Dec 22 23:24:35 D-69-91-141-110 systemd[1]: Starting User Manager for UID 1000...
Dec 22 23:24:35 D-69-91-141-110 systemd-logind[394]: New session 1 of user chirvasitua.
Dec 22 23:24:35 D-69-91-141-110 systemd[1]: Started Session 1 of user chirvasitua.
Dec 22 23:24:35 D-69-91-141-110 systemd[747]: pam_unix(systemd-user:session): session opened for user chirvasitua by (uid=0)
Dec 22 23:24:35 D-69-91-141-110 systemd[747]: Listening on GnuPG cryptographic agent (access for web browsers).
Dec 22 23:24:35 D-69-91-141-110 systemd[747]: Reached target Timers.
Dec 22 23:24:35 D-69-91-141-110 systemd[747]: Listening on GnuPG network certificate management daemon.
Dec 22 23:24:35 D-69-91-141-110 systemd[747]: Starting D-Bus User Message Bus Socket.
Dec 22 23:24:35 D-69-91-141-110 systemd[747]: Reached target Paths.
Dec 22 23:24:35 D-69-91-141-110 systemd[747]: Listening on GnuPG cryptographic agent and passphrase cache.
Dec 22 23:24:35 D-69-91-141-110 systemd[747]: Listening on GnuPG cryptographic agent (ssh-agent emulation).
Dec 22 23:24:35 D-69-91-141-110 systemd[747]: Listening on GnuPG cryptographic agent and passphrase cache (restricted).
Dec 22 23:24:35 D-69-91-141-110 systemd[747]: Listening on D-Bus User Message Bus Socket.
Dec 22 23:24:35 D-69-91-141-110 systemd[747]: Reached target Sockets.
Dec 22 23:24:35 D-69-91-141-110 systemd[747]: Reached target Basic System.
Dec 22 23:24:35 D-69-91-141-110 systemd[747]: Reached target Default.
Dec 22 23:24:35 D-69-91-141-110 systemd[747]: Startup finished in 279ms.
Dec 22 23:24:35 D-69-91-141-110 systemd[1]: Started User Manager for UID 1000.
Dec 22 23:24:36 D-69-91-141-110 avahi-daemon[445]: Joining mDNS multicast group on interface eth0.IPv6 with address fe80::222:15ff:feb0:c505.
Dec 22 23:24:36 D-69-91-141-110 avahi-daemon[445]: New relevant interface eth0.IPv6 for mDNS.
Dec 22 23:24:36 D-69-91-141-110 avahi-daemon[445]: Registering new address record for fe80::222:15ff:feb0:c505 on eth0.*.
Dec 22 23:24:37 D-69-91-141-110 dhclient[782]: Internet Systems Consortium DHCP Client 4.3.5
Dec 22 23:24:37 D-69-91-141-110 dhclient[782]: Copyright 2004-2016 Internet Systems Consortium.
Dec 22 23:24:37 D-69-91-141-110 dhclient[782]: All rights reserved.
Dec 22 23:24:37 D-69-91-141-110 dhclient[782]: For info, please visit https://www.isc.org/software/dhcp/
Dec 22 23:24:37 D-69-91-141-110 dhclient[782]: 
Dec 22 23:24:37 D-69-91-141-110 dhclient[782]: Listening on LPF/wlan0/00:22:43:18:84:7f
Dec 22 23:24:37 D-69-91-141-110 dhclient[782]: Sending on   LPF/wlan0/00:22:43:18:84:7f
Dec 22 23:24:37 D-69-91-141-110 dhclient[782]: Sending on   Socket/fallback
Dec 22 23:24:37 D-69-91-141-110 dhclient[782]: DHCPRELEASE on wlan0 to 192.168.1.1 port 67
Dec 22 23:24:37 D-69-91-141-110 dhclient[782]: send_packet: Network is unreachable
Dec 22 23:24:37 D-69-91-141-110 dhclient[782]: send_packet: please consult README file regarding broadcast address.
Dec 22 23:24:37 D-69-91-141-110 dhclient[782]: dhclient.c:2733: Failed to send 300 byte long packet over fallback interface.
Dec 22 23:24:37 D-69-91-141-110 kernel: IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
Dec 22 23:24:37 D-69-91-141-110 dhclient[806]: Internet Systems Consortium DHCP Client 4.3.5
Dec 22 23:24:37 D-69-91-141-110 dhclient[806]: Copyright 2004-2016 Internet Systems Consortium.
Dec 22 23:24:37 D-69-91-141-110 dhclient[806]: All rights reserved.
Dec 22 23:24:37 D-69-91-141-110 dhclient[806]: For info, please visit https://www.isc.org/software/dhcp/
Dec 22 23:24:37 D-69-91-141-110 dhclient[806]: 
Dec 22 23:24:37 D-69-91-141-110 dhclient[806]: Listening on LPF/eth0/00:22:15:b0:c5:05
Dec 22 23:24:37 D-69-91-141-110 dhclient[806]: Sending on   LPF/eth0/00:22:15:b0:c5:05
Dec 22 23:24:37 D-69-91-141-110 dhclient[806]: Sending on   Socket/fallback
Dec 22 23:24:37 D-69-91-141-110 dhclient[806]: DHCPRELEASE on eth0 to 192.168.1.1 port 67
Dec 22 23:24:37 D-69-91-141-110 dhclient[806]: send_packet: Network is unreachable
Dec 22 23:24:37 D-69-91-141-110 dhclient[806]: send_packet: please consult README file regarding broadcast address.
Dec 22 23:24:37 D-69-91-141-110 dhclient[806]: dhclient.c:2733: Failed to send 300 byte long packet over fallback interface.
Dec 22 23:24:38 D-69-91-141-110 avahi-daemon[445]: Interface eth0.IPv6 no longer relevant for mDNS.
Dec 22 23:24:38 D-69-91-141-110 avahi-daemon[445]: Leaving mDNS multicast group on interface eth0.IPv6 with address fe80::222:15ff:feb0:c505.
Dec 22 23:24:38 D-69-91-141-110 avahi-daemon[445]: Withdrawing address record for fe80::222:15ff:feb0:c505 on eth0.
Dec 22 23:24:38 D-69-91-141-110 kernel: atl2: eth0 NIC Link is Up<100 Mbps Full Duplex>
Dec 22 23:24:38 D-69-91-141-110 kernel: IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
Dec 22 23:24:38 D-69-91-141-110 kernel: IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
Dec 22 23:24:38 D-69-91-141-110 dhclient[836]: Internet Systems Consortium DHCP Client 4.3.5
Dec 22 23:24:38 D-69-91-141-110 dhclient[836]: Copyright 2004-2016 Internet Systems Consortium.
Dec 22 23:24:38 D-69-91-141-110 dhclient[836]: All rights reserved.
Dec 22 23:24:38 D-69-91-141-110 dhclient[836]: For info, please visit https://www.isc.org/software/dhcp/
Dec 22 23:24:38 D-69-91-141-110 dhclient[836]: 
Dec 22 23:24:38 D-69-91-141-110 dhclient[836]: Listening on LPF/eth0/00:22:15:b0:c5:05
Dec 22 23:24:38 D-69-91-141-110 dhclient[836]: Sending on   LPF/eth0/00:22:15:b0:c5:05
Dec 22 23:24:38 D-69-91-141-110 dhclient[836]: Sending on   Socket/fallback
Dec 22 23:24:38 D-69-91-141-110 dhclient[836]: DHCPRELEASE on eth0 to 192.168.1.1 port 67
Dec 22 23:24:38 D-69-91-141-110 dhclient[836]: send_packet: Network is unreachable
Dec 22 23:24:38 D-69-91-141-110 dhclient[836]: send_packet: please consult README file regarding broadcast address.
Dec 22 23:24:38 D-69-91-141-110 dhclient[836]: dhclient.c:2733: Failed to send 300 byte long packet over fallback interface.
Dec 22 23:24:38 D-69-91-141-110 kernel: atl2: eth0 NIC Link is Up<100 Mbps Full Duplex>
Dec 22 23:24:38 D-69-91-141-110 kernel: IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
Dec 22 23:24:38 D-69-91-141-110 kernel: IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
Dec 22 23:24:40 D-69-91-141-110 avahi-daemon[445]: Joining mDNS multicast group on interface eth0.IPv6 with address fe80::222:15ff:feb0:c505.
Dec 22 23:24:40 D-69-91-141-110 avahi-daemon[445]: New relevant interface eth0.IPv6 for mDNS.
Dec 22 23:24:40 D-69-91-141-110 avahi-daemon[445]: Registering new address record for fe80::222:15ff:feb0:c505 on eth0.*.
Dec 22 23:24:40 D-69-91-141-110 avahi-daemon[445]: Joining mDNS multicast group on interface eth0.IPv4 with address 192.168.1.162.
Dec 22 23:24:40 D-69-91-141-110 avahi-daemon[445]: New relevant interface eth0.IPv4 for mDNS.
Dec 22 23:24:40 D-69-91-141-110 avahi-daemon[445]: Registering new address record for 192.168.1.162 on eth0.IPv4.
Dec 22 23:24:40 D-69-91-141-110 su[845]: Successful su for root by chirvasitua
Dec 22 23:24:40 D-69-91-141-110 su[845]: + /dev/tty1 chirvasitua:root
Dec 22 23:24:40 D-69-91-141-110 su[845]: pam_unix(su:session): session opened for user root by chirvasitua(uid=1000)
Dec 22 23:24:40 D-69-91-141-110 su[845]: pam_systemd(su:session): Cannot create session: Already running in a session
Dec 22 23:24:50 D-69-91-141-110 systemd[747]: Time has been changed
Dec 22 23:24:50 D-69-91-141-110 systemd-timesyncd[379]: Synchronized to time server 66.85.74.226:123 (2.debian.pool.ntp.org).
Dec 22 23:24:51 D-69-91-141-110 systemd[1]: Time has been changed
Dec 22 23:24:51 D-69-91-141-110 systemd[1]: apt-daily.timer: Adding 3h 44min 7.752066s random time.
Dec 22 23:24:51 D-69-91-141-110 systemd[1]: anacron.timer: Adding 4min 35.396963s random time.
Dec 22 23:24:51 D-69-91-141-110 systemd[1]: apt-daily-upgrade.timer: Adding 27min 15.194996s random time.
Dec 22 23:27:45 D-69-91-141-110 su[845]: pam_unix(su:session): session closed for user root
Dec 22 23:28:48 D-69-91-141-110 kernel: fuse init (API version 7.26)
Dec 22 23:28:51 D-69-91-141-110 dbus[396]: [system] Activating via systemd: service name='org.freedesktop.RealtimeKit1' unit='rtkit-daemon.service'
Dec 22 23:28:51 D-69-91-141-110 systemd[1]: Starting RealtimeKit Scheduling Policy Service...
Dec 22 23:28:51 D-69-91-141-110 dbus[396]: [system] Successfully activated service 'org.freedesktop.RealtimeKit1'
Dec 22 23:28:51 D-69-91-141-110 rtkit-daemon[1008]: Successfully called chroot.
Dec 22 23:28:51 D-69-91-141-110 systemd[1]: Started RealtimeKit Scheduling Policy Service.
Dec 22 23:28:51 D-69-91-141-110 rtkit-daemon[1008]: Successfully dropped privileges.
Dec 22 23:28:51 D-69-91-141-110 rtkit-daemon[1008]: Successfully limited resources.
Dec 22 23:28:51 D-69-91-141-110 rtkit-daemon[1008]: Running.
Dec 22 23:28:51 D-69-91-141-110 rtkit-daemon[1008]: Watchdog thread running.
Dec 22 23:28:51 D-69-91-141-110 rtkit-daemon[1008]: Canary thread running.
Dec 22 23:28:52 D-69-91-141-110 rtkit-daemon[1008]: Successfully made thread 1007 of process 1007 (n/a) owned by '1000' high priority at nice level -11.
Dec 22 23:28:52 D-69-91-141-110 rtkit-daemon[1008]: Supervising 1 threads of 1 processes of 1 users.
Dec 22 23:28:54 D-69-91-141-110 rtkit-daemon[1008]: Supervising 1 threads of 1 processes of 1 users.
Dec 22 23:28:54 D-69-91-141-110 rtkit-daemon[1008]: Successfully made thread 1019 of process 1007 (n/a) owned by '1000' RT at priority 5.
Dec 22 23:28:54 D-69-91-141-110 rtkit-daemon[1008]: Supervising 2 threads of 1 processes of 1 users.
Dec 22 23:28:54 D-69-91-141-110 rtkit-daemon[1008]: Supervising 2 threads of 1 processes of 1 users.
Dec 22 23:28:54 D-69-91-141-110 rtkit-daemon[1008]: Successfully made thread 1020 of process 1007 (n/a) owned by '1000' RT at priority 5.
Dec 22 23:28:54 D-69-91-141-110 rtkit-daemon[1008]: Supervising 3 threads of 1 processes of 1 users.
Dec 22 23:28:54 D-69-91-141-110 rtkit-daemon[1008]: Supervising 3 threads of 1 processes of 1 users.
Dec 22 23:28:54 D-69-91-141-110 rtkit-daemon[1008]: Successfully made thread 1021 of process 1007 (n/a) owned by '1000' RT at priority 5.
Dec 22 23:28:54 D-69-91-141-110 rtkit-daemon[1008]: Supervising 4 threads of 1 processes of 1 users.
Dec 22 23:36:33 D-69-91-141-110 kernel: perf: interrupt took too long (2503 > 2500), lowering kernel.perf_event_max_sample_rate to 79750
Dec 22 23:39:07 D-69-91-141-110 systemd[1]: Starting Cleanup of Temporary Directories...
Dec 22 23:39:07 D-69-91-141-110 systemd[1]: Started Cleanup of Temporary Directories.
Dec 22 23:40:12 D-69-91-141-110 kernel: perf: interrupt took too long (3166 > 3128), lowering kernel.perf_event_max_sample_rate to 63000
Dec 22 23:44:32 D-69-91-141-110 sshd[2220]: rexec line 19: Deprecated option KeyRegenerationInterval
Dec 22 23:44:32 D-69-91-141-110 sshd[2220]: rexec line 20: Deprecated option ServerKeyBits
Dec 22 23:44:32 D-69-91-141-110 sshd[2220]: rexec line 31: Deprecated option RSAAuthentication
Dec 22 23:44:32 D-69-91-141-110 sshd[2220]: rexec line 38: Deprecated option RhostsRSAAuthentication
Dec 22 23:44:32 D-69-91-141-110 sshd[2220]: reprocess config line 31: Deprecated option RSAAuthentication
Dec 22 23:44:32 D-69-91-141-110 sshd[2220]: reprocess config line 38: Deprecated option RhostsRSAAuthentication
Dec 22 23:44:32 D-69-91-141-110 sshd[2220]: Accepted publickey for chirvasitua from 192.168.1.1 port 49684 ssh2: RSA SHA256:biMNha0qY8Q+ITiN9qqg5brpX9l6qlCRhuIHdXpKKZc
Dec 22 23:44:33 D-69-91-141-110 sshd[2220]: pam_unix(sshd:session): session opened for user chirvasitua by (uid=0)
Dec 22 23:44:33 D-69-91-141-110 systemd-logind[394]: New session 3 of user chirvasitua.
Dec 22 23:44:33 D-69-91-141-110 systemd[1]: Started Session 3 of user chirvasitua.
Dec 22 23:44:36 D-69-91-141-110 su[2245]: Successful su for root by chirvasitua
Dec 22 23:44:36 D-69-91-141-110 su[2245]: + /dev/pts/0 chirvasitua:root
Dec 22 23:44:36 D-69-91-141-110 su[2245]: pam_unix(su:session): session opened for user root by chirvasitua(uid=1000)
Dec 22 23:44:36 D-69-91-141-110 su[2245]: pam_systemd(su:session): Cannot create session: Already running in a session
Dec 22 23:45:29 D-69-91-141-110 kernel: perf: interrupt took too long (3992 > 3957), lowering kernel.perf_event_max_sample_rate to 50000

--eAbsdosE1cNLO4uF--
