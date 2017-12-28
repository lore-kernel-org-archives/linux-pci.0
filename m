Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:44525 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752873AbdL1CvS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Dec 2017 21:51:18 -0500
Date: Wed, 27 Dec 2017 21:51:14 -0500
From: Alexandru Chirvasitu <achirvasub@gmail.com>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Dexuan Cui <decui@microsoft.com>, Pavel Machek <pavel@ucw.cz>,
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
Message-ID: <20171228025114.wdydzgppfikuo65z@D-69-91-141-110.dhcp4.washington.edu>
References: <1bd74ca3-afca-9d61-6911-61250f459891@cn.fujitsu.com>
 <20171222142053.3cbhi2nhh24w7yoo@D-69-91-141-110.dhcp4.washington.edu>
 <KL1P15301MB000676F3F8C9A5AC8C489E75BF020@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <20171222222917.GA1138@arch-chirva.localdomain>
 <KL1P15301MB00064E9E767F9395744F42A3BF030@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <alpine.DEB.2.20.1712231432210.1853@nanos>
 <20171223200112.GC1138@arch-chirva.localdomain>
 <548c814c-7e24-00c0-3436-26f2704cb427@cn.fujitsu.com>
 <20171227161801.GE1410@arch-chirva.localdomain>
 <308183d9-d8d6-0100-159b-8c8be8636b31@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mgubwa272adwpo32"
In-Reply-To: <308183d9-d8d6-0100-159b-8c8be8636b31@cn.fujitsu.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--mgubwa272adwpo32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 28, 2017 at 10:06:25AM +0800, Dou Liyang wrote:
> Hi Alexandru,
> 
> Thanks for testing !
> At 12/28/2017 12:18 AM, Alexandru Chirvasitu wrote:
> > As per instructions, I did the following:
> > 
> > (1)
> > 
> > Checked out
> > 
> > 464e1d5 Linux 4.15-rc5
> > 
> > (after getting my copy up to date, fetching, pulling ,etc.) and
> > compiled it as-is. Config attached (the one labeled 'np' for 'no
> > patch').
> > 
> > Result:
> > 
> > Boot with no extraparameters locks up after login, as before;
> > 
> > apic=debug does not panic, but locks up after login, as before;
> > 
> I also hope to see the log with "apic=debug" by "journalctl" command,
> though the logs don't have the lockup trace.

Ah, of course. Attached is the output of `journalctl --boot=-1` after
booting, getting locked up, and then rebooting a good kernel.

Slightly different version of 4.15-rc5; this one has both patches
applied, yours and Linus' for kexec, but the latter shouldn't make a
difference.

---

You'll see another trace in there that's been bugging me, about W=X
checking. I'm not qualified to judge how related they are, but during
these past few days I've compiled and tested many kernels, and many of
them have exhibited the W+X thing but *not* the lockups.

I hope to trace that one back to the original commit with another
bisect one of these days, but they do seem to be different issues.

> 
> Thanks,
> 	dou.
> > 
> 
> 
> 

--mgubwa272adwpo32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="4.15-rc5-apicdebug-journal"

-- Logs begin at Sat 2017-12-23 08:45:59 EST, end at Wed 2017-12-27 21:42:46 EST. --
Dec 27 21:39:03 D-69-91-141-110 kernel: Linux version 4.15.0-rc5-kex-fix+ (root@axiomatic) (gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.5)) #1 SMP Wed Dec 27 17:37:47 EST 2017
Dec 27 21:39:03 D-69-91-141-110 kernel: x86/fpu: x87 FPU will use FXSAVE
Dec 27 21:39:03 D-69-91-141-110 kernel: e820: BIOS-provided physical RAM map:
Dec 27 21:39:03 D-69-91-141-110 kernel: BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
Dec 27 21:39:03 D-69-91-141-110 kernel: BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
Dec 27 21:39:03 D-69-91-141-110 kernel: BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
Dec 27 21:39:03 D-69-91-141-110 kernel: BIOS-e820: [mem 0x0000000000100000-0x00000000b7f9ffff] usable
Dec 27 21:39:03 D-69-91-141-110 kernel: BIOS-e820: [mem 0x00000000b7fa0000-0x00000000b7fadfff] ACPI data
Dec 27 21:39:03 D-69-91-141-110 kernel: BIOS-e820: [mem 0x00000000b7fae000-0x00000000b7feffff] ACPI NVS
Dec 27 21:39:03 D-69-91-141-110 kernel: BIOS-e820: [mem 0x00000000b7ff0000-0x00000000b7ffffff] reserved
Dec 27 21:39:03 D-69-91-141-110 kernel: BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
Dec 27 21:39:03 D-69-91-141-110 kernel: BIOS-e820: [mem 0x00000000ffb80000-0x00000000ffffffff] reserved
Dec 27 21:39:03 D-69-91-141-110 kernel: NX (Execute Disable) protection: active
Dec 27 21:39:03 D-69-91-141-110 kernel: random: fast init done
Dec 27 21:39:03 D-69-91-141-110 kernel: SMBIOS 2.4 present.
Dec 27 21:39:03 D-69-91-141-110 kernel: DMI: ASUSTeK Computer Inc. F5RL                /F5RL      , BIOS 210     06/12/2008
Dec 27 21:39:03 D-69-91-141-110 kernel: e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
Dec 27 21:39:03 D-69-91-141-110 kernel: e820: remove [mem 0x000a0000-0x000fffff] usable
Dec 27 21:39:03 D-69-91-141-110 kernel: e820: last_pfn = 0xb7fa0 max_arch_pfn = 0x1000000
Dec 27 21:39:03 D-69-91-141-110 kernel: MTRR default type: uncachable
Dec 27 21:39:03 D-69-91-141-110 kernel: MTRR fixed ranges enabled:
Dec 27 21:39:03 D-69-91-141-110 kernel:   00000-9FFFF write-back
Dec 27 21:39:03 D-69-91-141-110 kernel:   A0000-BFFFF uncachable
Dec 27 21:39:03 D-69-91-141-110 kernel:   C0000-CFFFF write-protect
Dec 27 21:39:03 D-69-91-141-110 kernel:   D0000-DFFFF uncachable
Dec 27 21:39:03 D-69-91-141-110 kernel:   E0000-EFFFF write-through
Dec 27 21:39:03 D-69-91-141-110 kernel:   F0000-FFFFF write-protect
Dec 27 21:39:03 D-69-91-141-110 kernel: MTRR variable ranges enabled:
Dec 27 21:39:03 D-69-91-141-110 kernel:   0 base 000000000 mask F80000000 write-back
Dec 27 21:39:03 D-69-91-141-110 kernel:   1 base 080000000 mask FE0000000 write-back
Dec 27 21:39:03 D-69-91-141-110 kernel:   2 base 0A0000000 mask FF0000000 write-back
Dec 27 21:39:03 D-69-91-141-110 kernel:   3 base 0B0000000 mask FF8000000 write-back
Dec 27 21:39:03 D-69-91-141-110 kernel:   4 base 0B8000000 mask FFC000000 write-back
Dec 27 21:39:03 D-69-91-141-110 kernel:   5 base 0BC000000 mask FFF000000 write-back
Dec 27 21:39:03 D-69-91-141-110 kernel:   6 base 0C0000000 mask FF0000000 write-combining
Dec 27 21:39:03 D-69-91-141-110 kernel:   7 disabled
Dec 27 21:39:03 D-69-91-141-110 kernel: x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
Dec 27 21:39:03 D-69-91-141-110 kernel: Scan for SMP in [mem 0x00000000-0x000003ff]
Dec 27 21:39:03 D-69-91-141-110 kernel: Scan for SMP in [mem 0x0009fc00-0x0009ffff]
Dec 27 21:39:03 D-69-91-141-110 kernel: Scan for SMP in [mem 0x000f0000-0x000fffff]
Dec 27 21:39:03 D-69-91-141-110 kernel: found SMP MP-table at [mem 0x000ff780-0x000ff78f] mapped at [(ptrval)]
Dec 27 21:39:03 D-69-91-141-110 kernel:   mpc: fd2d0-fd434
Dec 27 21:39:03 D-69-91-141-110 kernel: initial memory mapped: [mem 0x00000000-0x02dfffff]
Dec 27 21:39:03 D-69-91-141-110 kernel: Base memory trampoline at [(ptrval)] 9b000 size 16384
Dec 27 21:39:03 D-69-91-141-110 kernel: BRK [0x0294e000, 0x0294efff] PGTABLE
Dec 27 21:39:03 D-69-91-141-110 kernel: BRK [0x0294f000, 0x02950fff] PGTABLE
Dec 27 21:39:03 D-69-91-141-110 kernel: BRK [0x02951000, 0x02951fff] PGTABLE
Dec 27 21:39:03 D-69-91-141-110 kernel: BRK [0x02952000, 0x02952fff] PGTABLE
Dec 27 21:39:03 D-69-91-141-110 kernel: RAMDISK: [mem 0x35d35000-0x36e91fff]
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: Early table checksum verification disabled
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: RSDP 0x00000000000F8070 000014 (v00 ACPIAM)
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: RSDT 0x00000000B7FA0000 00003C (v01 A_M_I_ OEMRSDT  06000812 MSFT 00000097)
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: FACP 0x00000000B7FA0200 000084 (v02 A_M_I_ OEMFACP  06000812 MSFT 00000097)
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: DSDT 0x00000000B7FA0630 0075FA (v01 A0669  A0669000 00000000 INTL 20060113)
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: FACS 0x00000000B7FAE000 000040
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: APIC 0x00000000B7FA0390 00005C (v01 A_M_I_ OEMAPIC  06000812 MSFT 00000097)
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: MCFG 0x00000000B7FA03F0 00003C (v01 A_M_I_ OEMMCFG  06000812 MSFT 00000097)
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: SLIC 0x00000000B7FA0430 000176 (v01 A_M_I_ OEMSLIC  06000812 MSFT 00000097)
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: BOOT 0x00000000B7FA0600 000028 (v01 A_M_I_ OEMBOOT  06000812 MSFT 00000097)
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: OEMB 0x00000000B7FAE040 00005B (v01 A_M_I_ AMI_OEM  06000812 MSFT 00000097)
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: Local APIC address 0xfee00000
Dec 27 21:39:03 D-69-91-141-110 kernel: mapped APIC to         ffffc000 (        fee00000)
Dec 27 21:39:03 D-69-91-141-110 kernel: 2057MB HIGHMEM available.
Dec 27 21:39:03 D-69-91-141-110 kernel: 885MB LOWMEM available.
Dec 27 21:39:03 D-69-91-141-110 kernel:   mapped low ram: 0 - 375fe000
Dec 27 21:39:03 D-69-91-141-110 kernel:   low ram: 0 - 375fe000
Dec 27 21:39:03 D-69-91-141-110 kernel: Reserving 256MB of memory at 256MB for crashkernel (System RAM: 2943MB)
Dec 27 21:39:03 D-69-91-141-110 kernel: tsc: Fast TSC calibration using PIT
Dec 27 21:39:03 D-69-91-141-110 kernel: BRK [0x02953000, 0x02953fff] PGTABLE
Dec 27 21:39:03 D-69-91-141-110 kernel: Zone ranges:
Dec 27 21:39:03 D-69-91-141-110 kernel:   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
Dec 27 21:39:03 D-69-91-141-110 kernel:   Normal   [mem 0x0000000001000000-0x00000000375fdfff]
Dec 27 21:39:03 D-69-91-141-110 kernel:   HighMem  [mem 0x00000000375fe000-0x00000000b7f9ffff]
Dec 27 21:39:03 D-69-91-141-110 kernel: Movable zone start for each node
Dec 27 21:39:03 D-69-91-141-110 kernel: Early memory node ranges
Dec 27 21:39:03 D-69-91-141-110 kernel:   node   0: [mem 0x0000000000001000-0x000000000009efff]
Dec 27 21:39:03 D-69-91-141-110 kernel:   node   0: [mem 0x0000000000100000-0x00000000b7f9ffff]
Dec 27 21:39:03 D-69-91-141-110 kernel: Initmem setup node 0 [mem 0x0000000000001000-0x00000000b7f9ffff]
Dec 27 21:39:03 D-69-91-141-110 kernel: On node 0 totalpages: 753470
Dec 27 21:39:03 D-69-91-141-110 kernel:   DMA zone: 36 pages used for memmap
Dec 27 21:39:03 D-69-91-141-110 kernel:   DMA zone: 0 pages reserved
Dec 27 21:39:03 D-69-91-141-110 kernel:   DMA zone: 3998 pages, LIFO batch:0
Dec 27 21:39:03 D-69-91-141-110 kernel:   Normal zone: 1958 pages used for memmap
Dec 27 21:39:03 D-69-91-141-110 kernel:   Normal zone: 222718 pages, LIFO batch:31
Dec 27 21:39:03 D-69-91-141-110 kernel:   HighMem zone: 526754 pages, LIFO batch:31
Dec 27 21:39:03 D-69-91-141-110 kernel: Reserved but unavailable: 98 pages
Dec 27 21:39:03 D-69-91-141-110 kernel: Using APIC driver default
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: PM-Timer IO Port: 0x808
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: Local APIC address 0xfee00000
Dec 27 21:39:03 D-69-91-141-110 kernel: IOAPIC[0]: apic_id 2, version 33, address 0xfec00000, GSI 0-23
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Dec 27 21:39:03 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 2, APIC INT 02
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Dec 27 21:39:03 D-69-91-141-110 kernel: Int: type 0, pol 3, trig 3, bus 00, IRQ 09, APIC ID 2, APIC INT 09
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: IRQ0 used by override.
Dec 27 21:39:03 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 2, APIC INT 01
Dec 27 21:39:03 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 2, APIC INT 03
Dec 27 21:39:03 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 2, APIC INT 04
Dec 27 21:39:03 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 05, APIC ID 2, APIC INT 05
Dec 27 21:39:03 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 2, APIC INT 06
Dec 27 21:39:03 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 2, APIC INT 07
Dec 27 21:39:03 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 2, APIC INT 08
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: IRQ9 used by override.
Dec 27 21:39:03 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 0a, APIC ID 2, APIC INT 0a
Dec 27 21:39:03 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 0b, APIC ID 2, APIC INT 0b
Dec 27 21:39:03 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 2, APIC INT 0c
Dec 27 21:39:03 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 2, APIC INT 0d
Dec 27 21:39:03 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 2, APIC INT 0e
Dec 27 21:39:03 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 2, APIC INT 0f
Dec 27 21:39:03 D-69-91-141-110 kernel: Using ACPI (MADT) for SMP configuration information
Dec 27 21:39:03 D-69-91-141-110 kernel: smpboot: Allowing 2 CPUs, 0 hotplug CPUs
Dec 27 21:39:03 D-69-91-141-110 kernel: mapped IOAPIC to ffffb000 (fec00000)
Dec 27 21:39:03 D-69-91-141-110 kernel: PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
Dec 27 21:39:03 D-69-91-141-110 kernel: PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
Dec 27 21:39:03 D-69-91-141-110 kernel: PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
Dec 27 21:39:03 D-69-91-141-110 kernel: PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
Dec 27 21:39:03 D-69-91-141-110 kernel: e820: [mem 0xb8000000-0xfedfffff] available for PCI devices
Dec 27 21:39:03 D-69-91-141-110 kernel: clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
Dec 27 21:39:03 D-69-91-141-110 kernel: setup_percpu: NR_CPUS:32 nr_cpumask_bits:32 nr_cpu_ids:2 nr_node_ids:1
Dec 27 21:39:03 D-69-91-141-110 kernel: percpu: Embedded 24 pages/cpu @(ptrval) s65612 r0 d32692 u98304
Dec 27 21:39:03 D-69-91-141-110 kernel: pcpu-alloc: s65612 r0 d32692 u98304 alloc=24*4096
Dec 27 21:39:03 D-69-91-141-110 kernel: pcpu-alloc: [0] 0 [0] 1 
Dec 27 21:39:03 D-69-91-141-110 kernel: Built 1 zonelists, mobility grouping on.  Total pages: 751476
Dec 27 21:39:03 D-69-91-141-110 kernel: Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.15.0-rc5-kex-fix+ root=UUID=5a437cd2-c27b-4829-a7ba-533eb741b148 ro 3 crashkernel=256M quiet apic=debug
Dec 27 21:39:03 D-69-91-141-110 kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Dec 27 21:39:03 D-69-91-141-110 kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Dec 27 21:39:03 D-69-91-141-110 kernel: microcode: microcode updated early to revision 0xa4, date = 2010-10-02
Dec 27 21:39:03 D-69-91-141-110 kernel: Initializing CPU#0
Dec 27 21:39:03 D-69-91-141-110 kernel: Initializing HighMem for node 0 (000375fe:000b7fa0)
Dec 27 21:39:03 D-69-91-141-110 kernel: Initializing Movable for node 0 (00000000:00000000)
Dec 27 21:39:03 D-69-91-141-110 kernel: Memory: 2696864K/3013880K available (5865K kernel code, 593K rwdata, 1836K rodata, 604K init, 428K bss, 317016K reserved, 0K cma-reserved, 2107016K highmem)
Dec 27 21:39:03 D-69-91-141-110 kernel: virtual kernel memory layout:
                                            fixmap  : 0xffd36000 - 0xfffff000   (2852 kB)
                                          cpu_entry : 0xff800000 - 0xff8c1000   ( 772 kB)
                                            pkmap   : 0xff600000 - 0xff800000   (2048 kB)
                                            vmalloc : 0xf7dfe000 - 0xff5fe000   ( 120 MB)
                                            lowmem  : 0xc0000000 - 0xf75fe000   ( 885 MB)
                                              .init : 0xc282e000 - 0xc28c5000   ( 604 kB)
                                              .data : 0xc25ba424 - 0xc2820780   (2456 kB)
                                              .text : 0xc2000000 - 0xc25ba424   (5865 kB)
Dec 27 21:39:03 D-69-91-141-110 kernel: Checking if this processor honours the WP bit even in supervisor mode...Ok.
Dec 27 21:39:03 D-69-91-141-110 kernel: Hierarchical RCU implementation.
Dec 27 21:39:03 D-69-91-141-110 kernel:         RCU restricting CPUs from NR_CPUS=32 to nr_cpu_ids=2.
Dec 27 21:39:03 D-69-91-141-110 kernel: RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
Dec 27 21:39:03 D-69-91-141-110 kernel: NR_IRQS: 2304, nr_irqs: 440, preallocated irqs: 16
Dec 27 21:39:03 D-69-91-141-110 kernel: CPU 0 irqstacks, hard=(ptrval) soft=(ptrval)
Dec 27 21:39:03 D-69-91-141-110 kernel: Console: colour VGA+ 80x25
Dec 27 21:39:03 D-69-91-141-110 kernel: console [tty0] enabled
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: Core revision 20170831
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: 1 ACPI AML tables successfully acquired and loaded
Dec 27 21:39:03 D-69-91-141-110 kernel: APIC: Switch to symmetric I/O mode setup
Dec 27 21:39:03 D-69-91-141-110 kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Dec 27 21:39:03 D-69-91-141-110 kernel: enabled ExtINT on CPU#0
Dec 27 21:39:03 D-69-91-141-110 kernel: ESR value before enabling vector: 0x00000040  after: 0x00000000
Dec 27 21:39:03 D-69-91-141-110 kernel: ENABLING IO-APIC IRQs
Dec 27 21:39:03 D-69-91-141-110 kernel: init IO_APIC IRQs
Dec 27 21:39:03 D-69-91-141-110 kernel:  apic 2 pin 0 not connected
Dec 27 21:39:03 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-1 -> 0xef -> IRQ 1 Mode:0 Active:0 Dest:1)
Dec 27 21:39:03 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-2 -> 0x30 -> IRQ 0 Mode:0 Active:0 Dest:1)
Dec 27 21:39:03 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-3 -> 0xef -> IRQ 3 Mode:0 Active:0 Dest:1)
Dec 27 21:39:03 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-4 -> 0xef -> IRQ 4 Mode:0 Active:0 Dest:1)
Dec 27 21:39:03 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-5 -> 0xef -> IRQ 5 Mode:0 Active:0 Dest:1)
Dec 27 21:39:03 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-6 -> 0xef -> IRQ 6 Mode:0 Active:0 Dest:1)
Dec 27 21:39:03 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-7 -> 0xef -> IRQ 7 Mode:0 Active:0 Dest:1)
Dec 27 21:39:03 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-8 -> 0xef -> IRQ 8 Mode:0 Active:0 Dest:1)
Dec 27 21:39:03 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-9 -> 0xef -> IRQ 9 Mode:1 Active:1 Dest:1)
Dec 27 21:39:03 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-10 -> 0xef -> IRQ 10 Mode:0 Active:0 Dest:1)
Dec 27 21:39:03 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-11 -> 0xef -> IRQ 11 Mode:0 Active:0 Dest:1)
Dec 27 21:39:03 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-12 -> 0xef -> IRQ 12 Mode:0 Active:0 Dest:1)
Dec 27 21:39:03 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-13 -> 0xef -> IRQ 13 Mode:0 Active:0 Dest:1)
Dec 27 21:39:03 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-14 -> 0xef -> IRQ 14 Mode:0 Active:0 Dest:1)
Dec 27 21:39:03 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-15 -> 0xef -> IRQ 15 Mode:0 Active:0 Dest:1)
Dec 27 21:39:03 D-69-91-141-110 kernel:  apic 2 pin 16 not connected
Dec 27 21:39:03 D-69-91-141-110 kernel:  apic 2 pin 17 not connected
Dec 27 21:39:03 D-69-91-141-110 kernel:  apic 2 pin 18 not connected
Dec 27 21:39:03 D-69-91-141-110 kernel:  apic 2 pin 19 not connected
Dec 27 21:39:03 D-69-91-141-110 kernel:  apic 2 pin 20 not connected
Dec 27 21:39:03 D-69-91-141-110 kernel:  apic 2 pin 21 not connected
Dec 27 21:39:03 D-69-91-141-110 kernel:  apic 2 pin 22 not connected
Dec 27 21:39:03 D-69-91-141-110 kernel:  apic 2 pin 23 not connected
Dec 27 21:39:03 D-69-91-141-110 kernel: ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
Dec 27 21:39:03 D-69-91-141-110 kernel: tsc: Fast TSC calibration using PIT
Dec 27 21:39:03 D-69-91-141-110 kernel: tsc: Detected 1662.471 MHz processor
Dec 27 21:39:03 D-69-91-141-110 kernel: Calibrating delay loop (skipped), value calculated using timer frequency.. 3324.94 BogoMIPS (lpj=6649884)
Dec 27 21:39:03 D-69-91-141-110 kernel: pid_max: default: 32768 minimum: 301
Dec 27 21:39:03 D-69-91-141-110 kernel: Security Framework initialized
Dec 27 21:39:03 D-69-91-141-110 kernel: Yama: becoming mindful.
Dec 27 21:39:03 D-69-91-141-110 kernel: AppArmor: AppArmor disabled by boot time parameter
Dec 27 21:39:03 D-69-91-141-110 kernel: Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
Dec 27 21:39:03 D-69-91-141-110 kernel: Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
Dec 27 21:39:03 D-69-91-141-110 kernel: CPU: Physical Processor ID: 0
Dec 27 21:39:03 D-69-91-141-110 kernel: CPU: Processor Core ID: 0
Dec 27 21:39:03 D-69-91-141-110 kernel: mce: CPU supports 6 MCE banks
Dec 27 21:39:03 D-69-91-141-110 kernel: process: using mwait in idle threads
Dec 27 21:39:03 D-69-91-141-110 kernel: Last level iTLB entries: 4KB 128, 2MB 4, 4MB 4
Dec 27 21:39:03 D-69-91-141-110 kernel: Last level dTLB entries: 4KB 256, 2MB 0, 4MB 32, 1GB 0
Dec 27 21:39:03 D-69-91-141-110 kernel: Freeing SMP alternatives memory: 24K
Dec 27 21:39:03 D-69-91-141-110 kernel: Using local APIC timer interrupts.
                                        calibrating APIC timer ...
Dec 27 21:39:03 D-69-91-141-110 kernel: ... lapic delta = 1039120
Dec 27 21:39:03 D-69-91-141-110 kernel: ... PM-Timer delta = 357974
Dec 27 21:39:03 D-69-91-141-110 kernel: ... PM-Timer result ok
Dec 27 21:39:03 D-69-91-141-110 kernel: ..... delta 1039120
Dec 27 21:39:03 D-69-91-141-110 kernel: ..... mult: 44629864
Dec 27 21:39:03 D-69-91-141-110 kernel: ..... calibration result: 665036
Dec 27 21:39:03 D-69-91-141-110 kernel: ..... CPU clock speed is 1662.2362 MHz.
Dec 27 21:39:03 D-69-91-141-110 kernel: ..... host bus clock speed is 166.1036 MHz.
Dec 27 21:39:03 D-69-91-141-110 kernel: smpboot: CPU0: Intel(R) Core(TM)2 Duo CPU     T5450  @ 1.66GHz (family: 0x6, model: 0xf, stepping: 0xd)
Dec 27 21:39:03 D-69-91-141-110 kernel: Performance Events: PEBS fmt0+, Core2 events, Intel PMU driver.
Dec 27 21:39:03 D-69-91-141-110 kernel: core: PEBS disabled due to CPU errata
Dec 27 21:39:03 D-69-91-141-110 kernel: ... version:                2
Dec 27 21:39:03 D-69-91-141-110 kernel: ... bit width:              40
Dec 27 21:39:03 D-69-91-141-110 kernel: ... generic registers:      2
Dec 27 21:39:03 D-69-91-141-110 kernel: ... value mask:             000000ffffffffff
Dec 27 21:39:03 D-69-91-141-110 kernel: ... max period:             000000007fffffff
Dec 27 21:39:03 D-69-91-141-110 kernel: ... fixed-purpose events:   3
Dec 27 21:39:03 D-69-91-141-110 kernel: ... event mask:             0000000700000003
Dec 27 21:39:03 D-69-91-141-110 kernel: Hierarchical SRCU implementation.
Dec 27 21:39:03 D-69-91-141-110 kernel: NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
Dec 27 21:39:03 D-69-91-141-110 kernel: smp: Bringing up secondary CPUs ...
Dec 27 21:39:03 D-69-91-141-110 kernel: CPU 1 irqstacks, hard=8d99e3d3 soft=b97fb22f
Dec 27 21:39:03 D-69-91-141-110 kernel: x86: Booting SMP configuration:
Dec 27 21:39:03 D-69-91-141-110 kernel: .... node  #0, CPUs:      #1
Dec 27 21:39:03 D-69-91-141-110 kernel: Initializing CPU#1
Dec 27 21:39:03 D-69-91-141-110 kernel: masked ExtINT on CPU#1
Dec 27 21:39:03 D-69-91-141-110 kernel: smp: Brought up 1 node, 2 CPUs
Dec 27 21:39:03 D-69-91-141-110 kernel: smpboot: Max logical packages: 1
Dec 27 21:39:03 D-69-91-141-110 kernel: smpboot: Total of 2 processors activated (6649.88 BogoMIPS)
Dec 27 21:39:03 D-69-91-141-110 kernel: devtmpfs: initialized
Dec 27 21:39:03 D-69-91-141-110 kernel: PM: Registering ACPI NVS region [mem 0xb7fae000-0xb7feffff] (270336 bytes)
Dec 27 21:39:03 D-69-91-141-110 kernel: clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
Dec 27 21:39:03 D-69-91-141-110 kernel: futex hash table entries: 512 (order: 3, 32768 bytes)
Dec 27 21:39:03 D-69-91-141-110 kernel: pinctrl core: initialized pinctrl subsystem
Dec 27 21:39:03 D-69-91-141-110 kernel: NET: Registered protocol family 16
Dec 27 21:39:03 D-69-91-141-110 kernel: audit: initializing netlink subsys (disabled)
Dec 27 21:39:03 D-69-91-141-110 kernel: audit: type=2000 audit(1514428734.036:1): state=initialized audit_enabled=0 res=1
Dec 27 21:39:03 D-69-91-141-110 kernel: cpuidle: using governor ladder
Dec 27 21:39:03 D-69-91-141-110 kernel: cpuidle: using governor menu
Dec 27 21:39:03 D-69-91-141-110 kernel: Simple Boot Flag at 0xff set to 0x1
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: bus type PCI registered
Dec 27 21:39:03 D-69-91-141-110 kernel: acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
Dec 27 21:39:03 D-69-91-141-110 kernel: PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
Dec 27 21:39:03 D-69-91-141-110 kernel: PCI: not using MMCONFIG
Dec 27 21:39:03 D-69-91-141-110 kernel: PCI: PCI BIOS area is rw and x. Use pci=nobios if you want it NX.
Dec 27 21:39:03 D-69-91-141-110 kernel: PCI: PCI BIOS revision 3.00 entry at 0xf0031, last bus=8
Dec 27 21:39:03 D-69-91-141-110 kernel: PCI: Using configuration type 1 for base access
Dec 27 21:39:03 D-69-91-141-110 kernel: mtrr: your CPUs had inconsistent variable MTRR settings
Dec 27 21:39:03 D-69-91-141-110 kernel: mtrr: probably your BIOS does not setup all CPUs.
Dec 27 21:39:03 D-69-91-141-110 kernel: mtrr: corrected configuration.
Dec 27 21:39:03 D-69-91-141-110 kernel: HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: Added _OSI(Module Device)
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: Added _OSI(Processor Device)
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: Added _OSI(3.0 _SCP Extensions)
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: Added _OSI(Processor Aggregator Device)
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: Executed 2 blocks of module-level executable AML code
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: Dynamic OEM Table Load:
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: SSDT 0x00000000F7126000 000C99 (v01 AMI    CPU1PM   00000001 INTL 20060113)
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: Dynamic OEM Table Load:
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: SSDT 0x00000000F712C000 000C99 (v01 AMI    CPU2PM   00000001 INTL 20060113)
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: EC: EC started
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: EC: interrupt blocked
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: \_SB_.PCI0.SBRG.EC0_: Used as first EC
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: \_SB_.PCI0.SBRG.EC0_: GPE=0x11, EC_CMD/EC_SC=0x66, EC_DATA=0x62
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: \_SB_.PCI0.SBRG.EC0_: Used as boot DSDT EC to handle transactions
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: Interpreter enabled
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: (supports S0 S3 S4 S5)
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: Using IOAPIC for interrupt routing
Dec 27 21:39:03 D-69-91-141-110 kernel: PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
Dec 27 21:39:03 D-69-91-141-110 kernel: PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in ACPI motherboard resources
Dec 27 21:39:03 D-69-91-141-110 kernel: PCI: Using MMCONFIG for extended config space
Dec 27 21:39:03 D-69-91-141-110 kernel: PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: Enabled 6 GPEs in block 00 to 1F
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
Dec 27 21:39:03 D-69-91-141-110 kernel: acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
Dec 27 21:39:03 D-69-91-141-110 kernel: acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
Dec 27 21:39:03 D-69-91-141-110 kernel: PCI host bridge to bus 0000:00
Dec 27 21:39:03 D-69-91-141-110 kernel: pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000dffff window]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci_bus 0000:00: root bus resource [mem 0xb8000000-0xffffffff window]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci_bus 0000:00: root bus resource [bus 00-ff]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:00.0: [1002:5a31] type 00 class 0x060000
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:01.0: [1002:5a3f] type 01 class 0x060400
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:04.0: [1002:5a36] type 01 class 0x060400
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:04.0: enabling Extended Tags
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:05.0: [1002:5a37] type 01 class 0x060400
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:05.0: enabling Extended Tags
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:05.0: PME# supported from D0 D3hot D3cold
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:06.0: [1002:5a38] type 01 class 0x060400
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:06.0: enabling Extended Tags
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:07.0: [1002:5a39] type 01 class 0x060400
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:07.0: enabling Extended Tags
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:12.0: [1002:4380] type 00 class 0x01018f
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:12.0: reg 0x10: [io  0xe800-0xe807]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:12.0: reg 0x14: [io  0xe400-0xe403]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:12.0: reg 0x18: [io  0xe000-0xe007]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:12.0: reg 0x1c: [io  0xdc00-0xdc03]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:12.0: reg 0x20: [io  0xd800-0xd80f]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:12.0: reg 0x24: [mem 0xfebffc00-0xfebfffff]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:12.0: set SATA to AHCI mode
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:13.0: [1002:4387] type 00 class 0x0c0310
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:13.0: reg 0x10: [mem 0xfebfe000-0xfebfefff]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:13.1: [1002:4388] type 00 class 0x0c0310
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:13.1: reg 0x10: [mem 0xfebfd000-0xfebfdfff]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:13.2: [1002:4389] type 00 class 0x0c0310
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:13.2: reg 0x10: [mem 0xfebfc000-0xfebfcfff]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:13.3: [1002:438a] type 00 class 0x0c0310
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:13.3: reg 0x10: [mem 0xfebfb000-0xfebfbfff]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:13.4: [1002:438b] type 00 class 0x0c0310
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:13.4: reg 0x10: [mem 0xfebfa000-0xfebfafff]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:13.5: [1002:4386] type 00 class 0x0c0320
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:13.5: reg 0x10: [mem 0xfebff800-0xfebff8ff]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:13.5: supports D1 D2
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:13.5: PME# supported from D0 D1 D2 D3hot
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:14.0: [1002:4385] type 00 class 0x0c0500
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:14.0: reg 0x10: [io  0x0b00-0x0b0f]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:14.1: [1002:438c] type 00 class 0x010182
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:14.1: reg 0x10: [io  0x0000-0x0007]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:14.1: reg 0x14: [io  0x0000-0x0003]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:14.1: reg 0x18: [io  0x0000-0x0007]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:14.1: reg 0x1c: [io  0x0000-0x0003]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:14.1: reg 0x20: [io  0xff00-0xff0f]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:14.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:14.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:14.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:14.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:14.2: [1002:4383] type 00 class 0x040300
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:14.2: reg 0x10: [mem 0xfebf4000-0xfebf7fff 64bit]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:14.3: [1002:438d] type 00 class 0x060100
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:14.4: [1002:4384] type 01 class 0x060401
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:01:05.0: [1002:5a62] type 00 class 0x030000
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:01:05.0: reg 0x10: [mem 0xc0000000-0xcfffffff pref]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:01:05.0: reg 0x14: [io  0x9800-0x98ff]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:01:05.0: reg 0x18: [mem 0xfa8f0000-0xfa8fffff]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:01:05.0: reg 0x30: [mem 0xfa8c0000-0xfa8dffff pref]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:01:05.0: supports D1 D2
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:01.0: PCI bridge to [bus 01]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:01.0:   bridge window [io  0x9000-0x9fff]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:01.0:   bridge window [mem 0xfa800000-0xfa8fffff]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:01.0:   bridge window [mem 0xbdf00000-0xddefffff pref]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:02:00.0: [168c:001c] type 00 class 0x020000
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:02:00.0: reg 0x10: [mem 0xfa9f0000-0xfa9fffff 64bit]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:02:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:04.0: PCI bridge to [bus 02]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:04.0:   bridge window [mem 0xfa900000-0xfa9fffff]
Dec 27 21:39:03 D-69-91-141-110 kernel: acpiphp: Slot [1] registered
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:05.0: PCI bridge to [bus 03-05]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:05.0:   bridge window [io  0xa000-0xbfff]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:05.0:   bridge window [mem 0xfaa00000-0xfe9fffff]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:05.0:   bridge window [mem 0xddf00000-0xdfefffff 64bit pref]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:06:00.0: [1969:2048] type 00 class 0x020000
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:06:00.0: reg 0x10: [mem 0xfeac0000-0xfeafffff 64bit]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:06:00.0: reg 0x30: [mem 0xfeaa0000-0xfeabffff pref]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:06:00.0: PME# supported from D3hot D3cold
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:06:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:06.0: PCI bridge to [bus 06]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:06.0:   bridge window [mem 0xfea00000-0xfeafffff]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:07.0: PCI bridge to [bus 07]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:14.4: PCI bridge to [bus 08] (subtractive decode)
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:14.4:   bridge window [io  0x0000-0x0cf7 window] (subtractive decode)
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:14.4:   bridge window [mem 0x000d0000-0x000dffff window] (subtractive decode)
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:14.4:   bridge window [mem 0xb8000000-0xffffffff window] (subtractive decode)
Dec 27 21:39:03 D-69-91-141-110 kernel: pci_bus 0000:00: on NUMA node 0
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 7 10 11 12)
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 12)
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 7 10 11 12)
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *10 11 12)
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 12) *0, disabled.
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 12) *0, disabled.
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 *11 12)
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 12) *0, disabled.
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: EC: interrupt unblocked
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: EC: event unblocked
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: \_SB_.PCI0.SBRG.EC0_: GPE=0x11, EC_CMD/EC_SC=0x66, EC_DATA=0x62
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: \_SB_.PCI0.SBRG.EC0_: Used as boot DSDT EC to handle transactions and events
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:01:05.0: vgaarb: setting as boot VGA device
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:01:05.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:01:05.0: vgaarb: bridge control possible
Dec 27 21:39:03 D-69-91-141-110 kernel: vgaarb: loaded
Dec 27 21:39:03 D-69-91-141-110 kernel: EDAC MC: Ver: 3.0.0
Dec 27 21:39:03 D-69-91-141-110 kernel: PCI: Using ACPI for IRQ routing
Dec 27 21:39:03 D-69-91-141-110 kernel: PCI: pci_cache_line_size set to 64 bytes
Dec 27 21:39:03 D-69-91-141-110 kernel: e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
Dec 27 21:39:03 D-69-91-141-110 kernel: e820: reserve RAM buffer [mem 0xb7fa0000-0xb7ffffff]
Dec 27 21:39:03 D-69-91-141-110 kernel: clocksource: Switched to clocksource refined-jiffies
Dec 27 21:39:03 D-69-91-141-110 kernel: VFS: Disk quotas dquot_6.6.0
Dec 27 21:39:03 D-69-91-141-110 kernel: VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Dec 27 21:39:03 D-69-91-141-110 kernel: pnp: PnP ACPI init
Dec 27 21:39:03 D-69-91-141-110 kernel: pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
Dec 27 21:39:03 D-69-91-141-110 kernel: system 00:01: [io  0x04d0-0x04d1] has been reserved
Dec 27 21:39:03 D-69-91-141-110 kernel: system 00:01: [io  0x040b] has been reserved
Dec 27 21:39:03 D-69-91-141-110 kernel: system 00:01: [io  0x04d6] has been reserved
Dec 27 21:39:03 D-69-91-141-110 kernel: system 00:01: [io  0x0c00-0x0c01] has been reserved
Dec 27 21:39:03 D-69-91-141-110 kernel: system 00:01: [io  0x0c14] has been reserved
Dec 27 21:39:03 D-69-91-141-110 kernel: system 00:01: [io  0x0c50-0x0c51] has been reserved
Dec 27 21:39:03 D-69-91-141-110 kernel: system 00:01: [io  0x0c52] has been reserved
Dec 27 21:39:03 D-69-91-141-110 kernel: system 00:01: [io  0x0c6c] has been reserved
Dec 27 21:39:03 D-69-91-141-110 kernel: system 00:01: [io  0x0c6f] has been reserved
Dec 27 21:39:03 D-69-91-141-110 kernel: system 00:01: [io  0x0cd0-0x0cd1] has been reserved
Dec 27 21:39:03 D-69-91-141-110 kernel: system 00:01: [io  0x0cd2-0x0cd3] has been reserved
Dec 27 21:39:03 D-69-91-141-110 kernel: system 00:01: [io  0x0cd4-0x0cd5] has been reserved
Dec 27 21:39:03 D-69-91-141-110 kernel: system 00:01: [io  0x0cd6-0x0cd7] has been reserved
Dec 27 21:39:03 D-69-91-141-110 kernel: system 00:01: [io  0x0cd8-0x0cdf] has been reserved
Dec 27 21:39:03 D-69-91-141-110 kernel: system 00:01: [io  0x0800-0x089f] has been reserved
Dec 27 21:39:03 D-69-91-141-110 kernel: system 00:01: [io  0x0b00-0x0b1f] could not be reserved
Dec 27 21:39:03 D-69-91-141-110 kernel: system 00:01: [io  0x0900-0x090f] has been reserved
Dec 27 21:39:03 D-69-91-141-110 kernel: system 00:01: [io  0x0910-0x091f] has been reserved
Dec 27 21:39:03 D-69-91-141-110 kernel: system 00:01: [io  0xfe00-0xfefe] has been reserved
Dec 27 21:39:03 D-69-91-141-110 kernel: system 00:01: [io  0x4000-0x40fe] has been reserved
Dec 27 21:39:03 D-69-91-141-110 kernel: system 00:01: [mem 0xfed45000-0xfed89fff] has been reserved
Dec 27 21:39:03 D-69-91-141-110 kernel: system 00:01: [mem 0xffb80000-0xffbfffff] has been reserved
Dec 27 21:39:03 D-69-91-141-110 kernel: system 00:01: [mem 0xfff80000-0xffffffff] has been reserved
Dec 27 21:39:03 D-69-91-141-110 kernel: system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
Dec 27 21:39:03 D-69-91-141-110 kernel: pnp 00:02: Plug and Play ACPI device, IDs PNP0303 PNP030b (active)
Dec 27 21:39:03 D-69-91-141-110 kernel: pnp 00:03: Plug and Play ACPI device, IDs SYN0a04 SYN0a00 SYN0002 PNP0f03 PNP0f13 PNP0f12 (active)
Dec 27 21:39:03 D-69-91-141-110 kernel: system 00:04: [io  0x0250-0x0253] has been reserved
Dec 27 21:39:03 D-69-91-141-110 kernel: system 00:04: [io  0x0256-0x025f] has been reserved
Dec 27 21:39:03 D-69-91-141-110 kernel: system 00:04: [mem 0xfec00000-0xfec00fff] could not be reserved
Dec 27 21:39:03 D-69-91-141-110 kernel: system 00:04: [mem 0xfee00000-0xfee00fff] has been reserved
Dec 27 21:39:03 D-69-91-141-110 kernel: system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
Dec 27 21:39:03 D-69-91-141-110 kernel: system 00:05: [mem 0xe0000000-0xefffffff] has been reserved
Dec 27 21:39:03 D-69-91-141-110 kernel: system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
Dec 27 21:39:03 D-69-91-141-110 kernel: system 00:06: [mem 0x00000000-0x0009ffff] could not be reserved
Dec 27 21:39:03 D-69-91-141-110 kernel: system 00:06: [mem 0x000c0000-0x000cffff] could not be reserved
Dec 27 21:39:03 D-69-91-141-110 kernel: system 00:06: [mem 0x000e0000-0x000fffff] could not be reserved
Dec 27 21:39:03 D-69-91-141-110 kernel: system 00:06: [mem 0x00100000-0xb7ffffff] could not be reserved
Dec 27 21:39:03 D-69-91-141-110 kernel: system 00:06: Plug and Play ACPI device, IDs PNP0c01 (active)
Dec 27 21:39:03 D-69-91-141-110 kernel: pnp: PnP ACPI: found 7 devices
Dec 27 21:39:03 D-69-91-141-110 kernel: PnPBIOS: Disabled
Dec 27 21:39:03 D-69-91-141-110 kernel: clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
Dec 27 21:39:03 D-69-91-141-110 kernel: clocksource: Switched to clocksource acpi_pm
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:01.0: PCI bridge to [bus 01]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:01.0:   bridge window [io  0x9000-0x9fff]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:01.0:   bridge window [mem 0xfa800000-0xfa8fffff]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:01.0:   bridge window [mem 0xbdf00000-0xddefffff pref]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:04.0: PCI bridge to [bus 02]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:04.0:   bridge window [mem 0xfa900000-0xfa9fffff]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:05.0: PCI bridge to [bus 03-05]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:05.0:   bridge window [io  0xa000-0xbfff]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:05.0:   bridge window [mem 0xfaa00000-0xfe9fffff]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:05.0:   bridge window [mem 0xddf00000-0xdfefffff 64bit pref]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:06.0: PCI bridge to [bus 06]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:06.0:   bridge window [mem 0xfea00000-0xfeafffff]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:07.0: PCI bridge to [bus 07]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:14.4: PCI bridge to [bus 08]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000dffff window]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci_bus 0000:00: resource 8 [mem 0xb8000000-0xffffffff window]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci_bus 0000:01: resource 0 [io  0x9000-0x9fff]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci_bus 0000:01: resource 1 [mem 0xfa800000-0xfa8fffff]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci_bus 0000:01: resource 2 [mem 0xbdf00000-0xddefffff pref]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci_bus 0000:02: resource 1 [mem 0xfa900000-0xfa9fffff]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci_bus 0000:03: resource 0 [io  0xa000-0xbfff]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci_bus 0000:03: resource 1 [mem 0xfaa00000-0xfe9fffff]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci_bus 0000:03: resource 2 [mem 0xddf00000-0xdfefffff 64bit pref]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci_bus 0000:06: resource 1 [mem 0xfea00000-0xfeafffff]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci_bus 0000:08: resource 4 [io  0x0000-0x0cf7 window]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci_bus 0000:08: resource 5 [io  0x0d00-0xffff window]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci_bus 0000:08: resource 6 [mem 0x000a0000-0x000bffff window]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci_bus 0000:08: resource 7 [mem 0x000d0000-0x000dffff window]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci_bus 0000:08: resource 8 [mem 0xb8000000-0xffffffff window]
Dec 27 21:39:03 D-69-91-141-110 kernel: NET: Registered protocol family 2
Dec 27 21:39:03 D-69-91-141-110 kernel: TCP established hash table entries: 8192 (order: 3, 32768 bytes)
Dec 27 21:39:03 D-69-91-141-110 kernel: TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
Dec 27 21:39:03 D-69-91-141-110 kernel: TCP: Hash tables configured (established 8192 bind 8192)
Dec 27 21:39:03 D-69-91-141-110 kernel: UDP hash table entries: 512 (order: 2, 16384 bytes)
Dec 27 21:39:03 D-69-91-141-110 kernel: UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
Dec 27 21:39:03 D-69-91-141-110 kernel: NET: Registered protocol family 1
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:00:01.0: MSI quirk detected; subordinate MSI disabled
Dec 27 21:39:03 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-16 -> 0xef -> IRQ 16 Mode:1 Active:1 Dest:1)
Dec 27 21:39:03 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-17 -> 0xef -> IRQ 17 Mode:1 Active:1 Dest:1)
Dec 27 21:39:03 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-18 -> 0xef -> IRQ 18 Mode:1 Active:1 Dest:1)
Dec 27 21:39:03 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-17 -> 0xef -> IRQ 17 Mode:1 Active:1 Dest:1)
Dec 27 21:39:03 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-18 -> 0xef -> IRQ 18 Mode:1 Active:1 Dest:1)
Dec 27 21:39:03 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-19 -> 0xef -> IRQ 19 Mode:1 Active:1 Dest:1)
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:01:05.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
Dec 27 21:39:03 D-69-91-141-110 kernel: pci 0000:06:00.0: [Firmware Bug]: disabling VPD access (can't determine size of non-standard VPD format)
Dec 27 21:39:03 D-69-91-141-110 kernel: PCI: CLS 64 bytes, default 64
Dec 27 21:39:03 D-69-91-141-110 kernel: Unpacking initramfs...
Dec 27 21:39:03 D-69-91-141-110 kernel: Freeing initrd memory: 17780K
Dec 27 21:39:03 D-69-91-141-110 kernel: Initialise system trusted keyrings
Dec 27 21:39:03 D-69-91-141-110 kernel: workingset: timestamp_bits=14 max_order=20 bucket_order=6
Dec 27 21:39:03 D-69-91-141-110 kernel: zbud: loaded
Dec 27 21:39:03 D-69-91-141-110 kernel: tsc: Refined TSC clocksource calibration: 1662.500 MHz
Dec 27 21:39:03 D-69-91-141-110 kernel: clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x17f6c6790c8, max_idle_ns: 440795235729 ns
Dec 27 21:39:03 D-69-91-141-110 kernel: clocksource: Switched to clocksource tsc
Dec 27 21:39:03 D-69-91-141-110 kernel: Key type asymmetric registered
Dec 27 21:39:03 D-69-91-141-110 kernel: Asymmetric key parser 'x509' registered
Dec 27 21:39:03 D-69-91-141-110 kernel: bounce: pool size: 64 pages
Dec 27 21:39:03 D-69-91-141-110 kernel: Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
Dec 27 21:39:03 D-69-91-141-110 kernel: io scheduler noop registered
Dec 27 21:39:03 D-69-91-141-110 kernel: io scheduler deadline registered
Dec 27 21:39:03 D-69-91-141-110 kernel: io scheduler cfq registered (default)
Dec 27 21:39:03 D-69-91-141-110 kernel: io scheduler mq-deadline registered
Dec 27 21:39:03 D-69-91-141-110 kernel: io scheduler kyber registered
Dec 27 21:39:03 D-69-91-141-110 kernel: intel_idle: does not run on family 6 model 15
Dec 27 21:39:03 D-69-91-141-110 kernel: tsc: Marking TSC unstable due to TSC halts in idle
Dec 27 21:39:03 D-69-91-141-110 kernel: clocksource: Switched to clocksource acpi_pm
Dec 27 21:39:03 D-69-91-141-110 kernel: isapnp: Scanning for PnP cards...
Dec 27 21:39:03 D-69-91-141-110 kernel: isapnp: No Plug & Play device found
Dec 27 21:39:03 D-69-91-141-110 kernel: Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
Dec 27 21:39:03 D-69-91-141-110 kernel: Linux agpgart interface v0.103
Dec 27 21:39:03 D-69-91-141-110 kernel: i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
Dec 27 21:39:03 D-69-91-141-110 kernel: i8042: Detected active multiplexing controller, rev 1.1
Dec 27 21:39:03 D-69-91-141-110 kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Dec 27 21:39:03 D-69-91-141-110 kernel: serio: i8042 AUX0 port at 0x60,0x64 irq 12
Dec 27 21:39:03 D-69-91-141-110 kernel: serio: i8042 AUX1 port at 0x60,0x64 irq 12
Dec 27 21:39:03 D-69-91-141-110 kernel: serio: i8042 AUX2 port at 0x60,0x64 irq 12
Dec 27 21:39:03 D-69-91-141-110 kernel: serio: i8042 AUX3 port at 0x60,0x64 irq 12
Dec 27 21:39:03 D-69-91-141-110 kernel: mousedev: PS/2 mouse device common for all mice
Dec 27 21:39:03 D-69-91-141-110 kernel: rtc_cmos 00:00: RTC can wake from S4
Dec 27 21:39:03 D-69-91-141-110 kernel: rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
Dec 27 21:39:03 D-69-91-141-110 kernel: rtc_cmos 00:00: alarms up to one month, y3k, 114 bytes nvram
Dec 27 21:39:03 D-69-91-141-110 kernel: ledtrig-cpu: registered to indicate activity on CPUs
Dec 27 21:39:03 D-69-91-141-110 kernel: NET: Registered protocol family 10
Dec 27 21:39:03 D-69-91-141-110 kernel: Segment Routing with IPv6
Dec 27 21:39:03 D-69-91-141-110 kernel: mip6: Mobile IPv6
Dec 27 21:39:03 D-69-91-141-110 kernel: NET: Registered protocol family 17
Dec 27 21:39:03 D-69-91-141-110 kernel: mpls_gso: MPLS GSO support
Dec 27 21:39:03 D-69-91-141-110 kernel: microcode: sig=0x6fd, pf=0x80, revision=0xa4
Dec 27 21:39:03 D-69-91-141-110 kernel: microcode: Microcode Update Driver: v2.2.
Dec 27 21:39:03 D-69-91-141-110 kernel: ... APIC ID:      00000000 (0)
Dec 27 21:39:03 D-69-91-141-110 kernel: ... APIC VERSION: 00050014
Dec 27 21:39:03 D-69-91-141-110 kernel: 0000000000000000000000000000000000000000000000000000000000000000
Dec 27 21:39:03 D-69-91-141-110 kernel: 0000000000000000000000000000000000000000000000000000000000000000
Dec 27 21:39:03 D-69-91-141-110 kernel: 0000000000000000000000000000000000000000000000000000000000000000
Dec 27 21:39:03 D-69-91-141-110 kernel: number of MP IRQ sources: 15.
Dec 27 21:39:03 D-69-91-141-110 kernel: number of IO-APIC #2 registers: 24.
Dec 27 21:39:03 D-69-91-141-110 kernel: testing the IO APIC.......................
Dec 27 21:39:03 D-69-91-141-110 kernel: IO APIC #2......
Dec 27 21:39:03 D-69-91-141-110 kernel: .... register #00: 02000000
Dec 27 21:39:03 D-69-91-141-110 kernel: .......    : physical APIC id: 02
Dec 27 21:39:03 D-69-91-141-110 kernel: .......    : Delivery Type: 0
Dec 27 21:39:03 D-69-91-141-110 kernel: .......    : LTS          : 0
Dec 27 21:39:03 D-69-91-141-110 kernel: .... register #01: 00178021
Dec 27 21:39:03 D-69-91-141-110 kernel: .......     : max redirection entries: 17
Dec 27 21:39:03 D-69-91-141-110 kernel: .......     : PRQ implemented: 1
Dec 27 21:39:03 D-69-91-141-110 kernel: .......     : IO APIC version: 21
Dec 27 21:39:03 D-69-91-141-110 kernel: .... register #02: 02000000
Dec 27 21:39:03 D-69-91-141-110 kernel: .......     : arbitration: 02
Dec 27 21:39:03 D-69-91-141-110 kernel: .... register #03: 02178021
Dec 27 21:39:03 D-69-91-141-110 kernel: .......     : Boot DT    : 1
Dec 27 21:39:03 D-69-91-141-110 kernel: .... IRQ redirection table:
Dec 27 21:39:03 D-69-91-141-110 kernel: IOAPIC 0:
Dec 27 21:39:03 D-69-91-141-110 kernel:  pin00, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 27 21:39:03 D-69-91-141-110 kernel:  pin01, enabled , edge , high, V(23), IRR(0), S(0), logical , D(01), M(1)
Dec 27 21:39:03 D-69-91-141-110 kernel:  pin02, enabled , edge , high, V(30), IRR(0), S(0), logical , D(01), M(1)
Dec 27 21:39:03 D-69-91-141-110 kernel:  pin03, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 27 21:39:03 D-69-91-141-110 kernel:  pin04, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 27 21:39:03 D-69-91-141-110 kernel:  pin05, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 27 21:39:03 D-69-91-141-110 kernel:  pin06, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 27 21:39:03 D-69-91-141-110 kernel:  pin07, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 27 21:39:03 D-69-91-141-110 kernel:  pin08, enabled , edge , high, V(24), IRR(0), S(0), logical , D(01), M(1)
Dec 27 21:39:03 D-69-91-141-110 kernel:  pin09, enabled , level, low , V(21), IRR(0), S(0), logical , D(01), M(1)
Dec 27 21:39:03 D-69-91-141-110 kernel:  pin0a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 27 21:39:03 D-69-91-141-110 kernel:  pin0b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 27 21:39:03 D-69-91-141-110 kernel:  pin0c, enabled , edge , high, V(22), IRR(0), S(0), logical , D(01), M(1)
Dec 27 21:39:03 D-69-91-141-110 kernel:  pin0d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 27 21:39:03 D-69-91-141-110 kernel:  pin0e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 27 21:39:03 D-69-91-141-110 kernel:  pin0f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 27 21:39:03 D-69-91-141-110 kernel:  pin10, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 27 21:39:03 D-69-91-141-110 kernel:  pin11, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 27 21:39:03 D-69-91-141-110 kernel:  pin12, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 27 21:39:03 D-69-91-141-110 kernel:  pin13, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 27 21:39:03 D-69-91-141-110 kernel:  pin14, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 27 21:39:03 D-69-91-141-110 kernel:  pin15, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 27 21:39:03 D-69-91-141-110 kernel:  pin16, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 27 21:39:03 D-69-91-141-110 kernel:  pin17, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 27 21:39:03 D-69-91-141-110 kernel: IRQ to pin mappings:
Dec 27 21:39:03 D-69-91-141-110 kernel: IRQ0 -> 0:2
Dec 27 21:39:03 D-69-91-141-110 kernel: IRQ1 -> 0:1
Dec 27 21:39:03 D-69-91-141-110 kernel: IRQ3 -> 0:3
Dec 27 21:39:03 D-69-91-141-110 kernel: IRQ4 -> 0:4
Dec 27 21:39:03 D-69-91-141-110 kernel: IRQ5 -> 0:5
Dec 27 21:39:03 D-69-91-141-110 kernel: IRQ6 -> 0:6
Dec 27 21:39:03 D-69-91-141-110 kernel: IRQ7 -> 0:7
Dec 27 21:39:03 D-69-91-141-110 kernel: IRQ8 -> 0:8
Dec 27 21:39:03 D-69-91-141-110 kernel: IRQ9 -> 0:9
Dec 27 21:39:03 D-69-91-141-110 kernel: IRQ10 -> 0:10
Dec 27 21:39:03 D-69-91-141-110 kernel: IRQ11 -> 0:11
Dec 27 21:39:03 D-69-91-141-110 kernel: IRQ12 -> 0:12
Dec 27 21:39:03 D-69-91-141-110 kernel: IRQ13 -> 0:13
Dec 27 21:39:03 D-69-91-141-110 kernel: IRQ14 -> 0:14
Dec 27 21:39:03 D-69-91-141-110 kernel: IRQ15 -> 0:15
Dec 27 21:39:03 D-69-91-141-110 kernel: .................................... done.
Dec 27 21:39:03 D-69-91-141-110 kernel: Using IPI No-Shortcut mode
Dec 27 21:39:03 D-69-91-141-110 kernel: registered taskstats version 1
Dec 27 21:39:03 D-69-91-141-110 kernel: Loading compiled-in X.509 certificates
Dec 27 21:39:03 D-69-91-141-110 kernel: zswap: loaded using pool lzo/zbud
Dec 27 21:39:03 D-69-91-141-110 kernel: ima: No TPM chip found, activating TPM-bypass! (rc=-19)
Dec 27 21:39:03 D-69-91-141-110 kernel: rtc_cmos 00:00: setting system clock to 2017-12-28 02:38:57 UTC (1514428737)
Dec 27 21:39:03 D-69-91-141-110 kernel: Freeing unused kernel memory: 604K
Dec 27 21:39:03 D-69-91-141-110 kernel: Write protecting the kernel text: 5868k
Dec 27 21:39:03 D-69-91-141-110 kernel: Write protecting the kernel read-only data: 1860k
Dec 27 21:39:03 D-69-91-141-110 kernel: NX-protecting the kernel data: 4372k
Dec 27 21:39:03 D-69-91-141-110 kernel: ------------[ cut here ]------------
Dec 27 21:39:03 D-69-91-141-110 kernel: x86/mm: Found insecure W+X mapping at address 329d7c5f/0xc00a0000
Dec 27 21:39:03 D-69-91-141-110 kernel: WARNING: CPU: 1 PID: 1 at arch/x86/mm/dump_pagetables.c:257 note_page+0x5ec/0x790
Dec 27 21:39:03 D-69-91-141-110 kernel: Modules linked in:
Dec 27 21:39:03 D-69-91-141-110 kernel: CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.15.0-rc5-kex-fix+ #1
Dec 27 21:39:03 D-69-91-141-110 kernel: Hardware name: ASUSTeK Computer Inc. F5RL                /F5RL      , BIOS 210     06/12/2008
Dec 27 21:39:03 D-69-91-141-110 kernel: EIP: note_page+0x5ec/0x790
Dec 27 21:39:03 D-69-91-141-110 kernel: EFLAGS: 00210282 CPU: 1
Dec 27 21:39:03 D-69-91-141-110 kernel: EAX: 00000041 EBX: f70c7f54 ECX: 00000001 EDX: c28de544
Dec 27 21:39:03 D-69-91-141-110 kernel: ESI: 80000000 EDI: 00000000 EBP: f70c7f20 ESP: f70c7ef4
Dec 27 21:39:03 D-69-91-141-110 kernel:  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
Dec 27 21:39:03 D-69-91-141-110 kernel: CR0: 80050033 CR2: 00000000 CR3: 028ce000 CR4: 000006f0
Dec 27 21:39:03 D-69-91-141-110 kernel: Call Trace:
Dec 27 21:39:03 D-69-91-141-110 kernel:  ptdump_walk_pgd_level_core+0x15c/0x240
Dec 27 21:39:03 D-69-91-141-110 kernel:  ptdump_walk_pgd_level_checkwx+0x11/0x20
Dec 27 21:39:03 D-69-91-141-110 kernel:  mark_rodata_ro+0xd5/0xf1
Dec 27 21:39:03 D-69-91-141-110 kernel:  ? rest_init+0x90/0x90
Dec 27 21:39:03 D-69-91-141-110 kernel:  kernel_init+0x24/0xe0
Dec 27 21:39:03 D-69-91-141-110 kernel:  ret_from_fork+0x19/0x24
Dec 27 21:39:03 D-69-91-141-110 kernel: Code: fa ff ff 83 c2 0c c7 43 18 00 00 00 00 89 53 14 e9 1a fd ff ff 8b 43 0c c6 05 c4 76 80 c2 01 50 50 68 50 ee 6c c2 e8 84 5c 00 00 <0f> ff 83 c4 0c e9 6f fa ff ff ff 72 10 68 1c ed 6c c2 e8 57 f5
Dec 27 21:39:03 D-69-91-141-110 kernel: ---[ end trace 05da460748261f52 ]---
Dec 27 21:39:03 D-69-91-141-110 kernel: x86/mm: Checked W+X mappings: FAILED, 96 W+X pages found.
Dec 27 21:39:03 D-69-91-141-110 kernel: input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
Dec 27 21:39:03 D-69-91-141-110 kernel: SCSI subsystem initialized
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: bus type USB registered
Dec 27 21:39:03 D-69-91-141-110 kernel: usbcore: registered new interface driver usbfs
Dec 27 21:39:03 D-69-91-141-110 kernel: usbcore: registered new interface driver hub
Dec 27 21:39:03 D-69-91-141-110 kernel: usbcore: registered new device driver usb
Dec 27 21:39:03 D-69-91-141-110 kernel: ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
Dec 27 21:39:03 D-69-91-141-110 kernel: ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
Dec 27 21:39:03 D-69-91-141-110 kernel: ehci-pci: EHCI PCI platform driver
Dec 27 21:39:03 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-19 -> 0xef -> IRQ 19 Mode:1 Active:1 Dest:1)
Dec 27 21:39:03 D-69-91-141-110 kernel: ehci-pci 0000:00:13.5: EHCI Host Controller
Dec 27 21:39:03 D-69-91-141-110 kernel: ehci-pci 0000:00:13.5: new USB bus registered, assigned bus number 1
Dec 27 21:39:03 D-69-91-141-110 kernel: ehci-pci 0000:00:13.5: applying AMD SB600/SB700 USB freeze workaround
Dec 27 21:39:03 D-69-91-141-110 kernel: ehci-pci 0000:00:13.5: debug port 1
Dec 27 21:39:03 D-69-91-141-110 kernel: Atheros(R) L2 Ethernet Driver - version 2.2.3
Dec 27 21:39:03 D-69-91-141-110 kernel: Copyright (c) 2007 Atheros Corporation.
Dec 27 21:39:03 D-69-91-141-110 kernel: ehci-pci 0000:00:13.5: irq 19, io mem 0xfebff800
Dec 27 21:39:03 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-18 -> 0xef -> IRQ 18 Mode:1 Active:1 Dest:1)
Dec 27 21:39:03 D-69-91-141-110 kernel: libata version 3.00 loaded.
Dec 27 21:39:03 D-69-91-141-110 kernel: ehci-pci 0000:00:13.5: USB 2.0 started, EHCI 1.00
Dec 27 21:39:03 D-69-91-141-110 kernel: usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
Dec 27 21:39:03 D-69-91-141-110 kernel: usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Dec 27 21:39:03 D-69-91-141-110 kernel: usb usb1: Product: EHCI Host Controller
Dec 27 21:39:03 D-69-91-141-110 kernel: usb usb1: Manufacturer: Linux 4.15.0-rc5-kex-fix+ ehci_hcd
Dec 27 21:39:03 D-69-91-141-110 kernel: usb usb1: SerialNumber: 0000:00:13.5
Dec 27 21:39:03 D-69-91-141-110 kernel: hub 1-0:1.0: USB hub found
Dec 27 21:39:03 D-69-91-141-110 kernel: hub 1-0:1.0: 10 ports detected
Dec 27 21:39:03 D-69-91-141-110 kernel: ahci 0000:00:12.0: version 3.0
Dec 27 21:39:03 D-69-91-141-110 kernel: ohci-pci: OHCI PCI platform driver
Dec 27 21:39:03 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-22 -> 0xef -> IRQ 22 Mode:1 Active:1 Dest:1)
Dec 27 21:39:03 D-69-91-141-110 kernel: ahci 0000:00:12.0: controller can't do 64bit DMA, forcing 32bit
Dec 27 21:39:03 D-69-91-141-110 kernel: ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
Dec 27 21:39:03 D-69-91-141-110 kernel: ahci 0000:00:12.0: flags: ncq sntf ilck led clo pmp pio slum part ccc 
Dec 27 21:39:03 D-69-91-141-110 kernel: scsi host0: ahci
Dec 27 21:39:03 D-69-91-141-110 kernel: scsi host1: ahci
Dec 27 21:39:03 D-69-91-141-110 kernel: scsi host2: ahci
Dec 27 21:39:03 D-69-91-141-110 kernel: scsi host3: ahci
Dec 27 21:39:03 D-69-91-141-110 kernel: ata1: SATA max UDMA/133 abar m1024@0xfebffc00 port 0xfebffd00 irq 22
Dec 27 21:39:03 D-69-91-141-110 kernel: ata2: SATA max UDMA/133 abar m1024@0xfebffc00 port 0xfebffd80 irq 22
Dec 27 21:39:03 D-69-91-141-110 kernel: ata3: SATA max UDMA/133 abar m1024@0xfebffc00 port 0xfebffe00 irq 22
Dec 27 21:39:03 D-69-91-141-110 kernel: ata4: SATA max UDMA/133 abar m1024@0xfebffc00 port 0xfebffe80 irq 22
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI Warning: SystemIO range 0x0000000000000B00-0x0000000000000B08 conflicts with OpRegion 0x0000000000000B00-0x0000000000000B0F (\SMB0) (20170831/utaddress-247)
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
Dec 27 21:39:03 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-16 -> 0xef -> IRQ 16 Mode:1 Active:1 Dest:1)
Dec 27 21:39:03 D-69-91-141-110 kernel: scsi host4: pata_atiixp
Dec 27 21:39:03 D-69-91-141-110 kernel: scsi host5: pata_atiixp
Dec 27 21:39:03 D-69-91-141-110 kernel: ata5: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xff00 irq 14
Dec 27 21:39:03 D-69-91-141-110 kernel: ata6: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xff08 irq 15
Dec 27 21:39:03 D-69-91-141-110 kernel: ohci-pci 0000:00:13.0: OHCI PCI host controller
Dec 27 21:39:03 D-69-91-141-110 kernel: ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 2
Dec 27 21:39:03 D-69-91-141-110 kernel: ohci-pci 0000:00:13.0: irq 16, io mem 0xfebfe000
Dec 27 21:39:03 D-69-91-141-110 kernel: (NULL device *): hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
Dec 27 21:39:03 D-69-91-141-110 kernel: thermal LNXTHERM:00: registered as thermal_zone0
Dec 27 21:39:03 D-69-91-141-110 kernel: ACPI: Thermal Zone [THRM] (76 C)
Dec 27 21:39:03 D-69-91-141-110 kernel: usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
Dec 27 21:39:03 D-69-91-141-110 kernel: usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Dec 27 21:39:03 D-69-91-141-110 kernel: usb usb2: Product: OHCI PCI host controller
Dec 27 21:39:03 D-69-91-141-110 kernel: usb usb2: Manufacturer: Linux 4.15.0-rc5-kex-fix+ ohci_hcd
Dec 27 21:39:03 D-69-91-141-110 kernel: usb usb2: SerialNumber: 0000:00:13.0
Dec 27 21:39:03 D-69-91-141-110 kernel: hub 2-0:1.0: USB hub found
Dec 27 21:39:03 D-69-91-141-110 kernel: hub 2-0:1.0: 2 ports detected
Dec 27 21:39:03 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-17 -> 0xef -> IRQ 17 Mode:1 Active:1 Dest:1)
Dec 27 21:39:03 D-69-91-141-110 kernel: ohci-pci 0000:00:13.1: OHCI PCI host controller
Dec 27 21:39:03 D-69-91-141-110 kernel: ohci-pci 0000:00:13.1: new USB bus registered, assigned bus number 3
Dec 27 21:39:03 D-69-91-141-110 kernel: ohci-pci 0000:00:13.1: irq 17, io mem 0xfebfd000
Dec 27 21:39:03 D-69-91-141-110 kernel: usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
Dec 27 21:39:03 D-69-91-141-110 kernel: usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Dec 27 21:39:03 D-69-91-141-110 kernel: usb usb3: Product: OHCI PCI host controller
Dec 27 21:39:03 D-69-91-141-110 kernel: usb usb3: Manufacturer: Linux 4.15.0-rc5-kex-fix+ ohci_hcd
Dec 27 21:39:03 D-69-91-141-110 kernel: usb usb3: SerialNumber: 0000:00:13.1
Dec 27 21:39:03 D-69-91-141-110 kernel: hub 3-0:1.0: USB hub found
Dec 27 21:39:03 D-69-91-141-110 kernel: hub 3-0:1.0: 2 ports detected
Dec 27 21:39:03 D-69-91-141-110 kernel: ohci-pci 0000:00:13.2: OHCI PCI host controller
Dec 27 21:39:03 D-69-91-141-110 kernel: ohci-pci 0000:00:13.2: new USB bus registered, assigned bus number 4
Dec 27 21:39:03 D-69-91-141-110 kernel: ohci-pci 0000:00:13.2: irq 18, io mem 0xfebfc000
Dec 27 21:39:03 D-69-91-141-110 kernel: ata5.00: ATAPI: HL-DT-ST DVDRAM GSA-T40N, JR03, max UDMA/33
Dec 27 21:39:03 D-69-91-141-110 kernel: ata5.00: configured for UDMA/33
Dec 27 21:39:03 D-69-91-141-110 kernel: usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
Dec 27 21:39:03 D-69-91-141-110 kernel: usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Dec 27 21:39:03 D-69-91-141-110 kernel: usb usb4: Product: OHCI PCI host controller
Dec 27 21:39:03 D-69-91-141-110 kernel: usb usb4: Manufacturer: Linux 4.15.0-rc5-kex-fix+ ohci_hcd
Dec 27 21:39:03 D-69-91-141-110 kernel: usb usb4: SerialNumber: 0000:00:13.2
Dec 27 21:39:03 D-69-91-141-110 kernel: hub 4-0:1.0: USB hub found
Dec 27 21:39:03 D-69-91-141-110 kernel: hub 4-0:1.0: 2 ports detected
Dec 27 21:39:03 D-69-91-141-110 kernel: ohci-pci 0000:00:13.3: OHCI PCI host controller
Dec 27 21:39:03 D-69-91-141-110 kernel: ohci-pci 0000:00:13.3: new USB bus registered, assigned bus number 5
Dec 27 21:39:03 D-69-91-141-110 kernel: ohci-pci 0000:00:13.3: irq 17, io mem 0xfebfb000
Dec 27 21:39:03 D-69-91-141-110 kernel: usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
Dec 27 21:39:03 D-69-91-141-110 kernel: usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Dec 27 21:39:03 D-69-91-141-110 kernel: usb usb5: Product: OHCI PCI host controller
Dec 27 21:39:03 D-69-91-141-110 kernel: usb usb5: Manufacturer: Linux 4.15.0-rc5-kex-fix+ ohci_hcd
Dec 27 21:39:03 D-69-91-141-110 kernel: usb usb5: SerialNumber: 0000:00:13.3
Dec 27 21:39:03 D-69-91-141-110 kernel: hub 5-0:1.0: USB hub found
Dec 27 21:39:03 D-69-91-141-110 kernel: hub 5-0:1.0: 2 ports detected
Dec 27 21:39:03 D-69-91-141-110 kernel: ohci-pci 0000:00:13.4: OHCI PCI host controller
Dec 27 21:39:03 D-69-91-141-110 kernel: ohci-pci 0000:00:13.4: new USB bus registered, assigned bus number 6
Dec 27 21:39:03 D-69-91-141-110 kernel: ohci-pci 0000:00:13.4: irq 18, io mem 0xfebfa000
Dec 27 21:39:03 D-69-91-141-110 kernel: usb 1-4: new high-speed USB device number 2 using ehci-pci
Dec 27 21:39:03 D-69-91-141-110 kernel: ata4: SATA link down (SStatus 0 SControl 300)
Dec 27 21:39:03 D-69-91-141-110 kernel: ata3: SATA link down (SStatus 0 SControl 300)
Dec 27 21:39:03 D-69-91-141-110 kernel: ata2: SATA link down (SStatus 0 SControl 300)
Dec 27 21:39:03 D-69-91-141-110 kernel: usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
Dec 27 21:39:03 D-69-91-141-110 kernel: usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Dec 27 21:39:03 D-69-91-141-110 kernel: usb usb6: Product: OHCI PCI host controller
Dec 27 21:39:03 D-69-91-141-110 kernel: usb usb6: Manufacturer: Linux 4.15.0-rc5-kex-fix+ ohci_hcd
Dec 27 21:39:03 D-69-91-141-110 kernel: usb usb6: SerialNumber: 0000:00:13.4
Dec 27 21:39:03 D-69-91-141-110 kernel: hub 6-0:1.0: USB hub found
Dec 27 21:39:03 D-69-91-141-110 kernel: hub 6-0:1.0: 2 ports detected
Dec 27 21:39:03 D-69-91-141-110 kernel: usb 1-4: New USB device found, idVendor=0bda, idProduct=0116
Dec 27 21:39:03 D-69-91-141-110 kernel: usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
Dec 27 21:39:03 D-69-91-141-110 kernel: usb 1-4: Product: USB2.0-CRW
Dec 27 21:39:03 D-69-91-141-110 kernel: usb 1-4: Manufacturer: Generic
Dec 27 21:39:03 D-69-91-141-110 kernel: usb 1-4: SerialNumber: 20021111153705700
Dec 27 21:39:03 D-69-91-141-110 kernel: usb-storage 1-4:1.0: USB Mass Storage device detected
Dec 27 21:39:03 D-69-91-141-110 kernel: scsi host6: usb-storage 1-4:1.0
Dec 27 21:39:03 D-69-91-141-110 kernel: usbcore: registered new interface driver usb-storage
Dec 27 21:39:03 D-69-91-141-110 kernel: usbcore: registered new interface driver uas
Dec 27 21:39:03 D-69-91-141-110 kernel: ata1: softreset failed (device not ready)
Dec 27 21:39:03 D-69-91-141-110 kernel: ata1: applying PMP SRST workaround and retrying
Dec 27 21:39:03 D-69-91-141-110 kernel: usb 1-7: new high-speed USB device number 3 using ehci-pci
Dec 27 21:39:03 D-69-91-141-110 kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Dec 27 21:39:03 D-69-91-141-110 kernel: ata1.00: ATA-8: ST9250827AS, 3.AAA, max UDMA/133
Dec 27 21:39:03 D-69-91-141-110 kernel: ata1.00: 488397168 sectors, multi 16: LBA48 NCQ (depth 31/32)
Dec 27 21:39:03 D-69-91-141-110 kernel: ata1.00: SB600 AHCI: limiting to 255 sectors per cmd
Dec 27 21:39:03 D-69-91-141-110 kernel: ata1.00: SB600 AHCI: limiting to 255 sectors per cmd
Dec 27 21:39:03 D-69-91-141-110 kernel: ata1.00: configured for UDMA/133
Dec 27 21:39:03 D-69-91-141-110 kernel: scsi 0:0:0:0: Direct-Access     ATA      ST9250827AS      A    PQ: 0 ANSI: 5
Dec 27 21:39:03 D-69-91-141-110 kernel: scsi 4:0:0:0: CD-ROM            HL-DT-ST DVDRAM GSA-T40N  JR03 PQ: 0 ANSI: 5
Dec 27 21:39:03 D-69-91-141-110 kernel: sd 0:0:0:0: [sda] 488397168 512-byte logical blocks: (250 GB/233 GiB)
Dec 27 21:39:03 D-69-91-141-110 kernel: sd 0:0:0:0: [sda] Write Protect is off
Dec 27 21:39:03 D-69-91-141-110 kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Dec 27 21:39:03 D-69-91-141-110 kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Dec 27 21:39:03 D-69-91-141-110 kernel: sr 4:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
Dec 27 21:39:03 D-69-91-141-110 kernel: cdrom: Uniform CD-ROM driver Revision: 3.20
Dec 27 21:39:03 D-69-91-141-110 kernel: sr 4:0:0:0: Attached scsi CD-ROM sr0
Dec 27 21:39:03 D-69-91-141-110 kernel:  sda: sda1 sda2 < sda5 >
Dec 27 21:39:03 D-69-91-141-110 kernel: sd 0:0:0:0: [sda] Attached SCSI disk
Dec 27 21:39:03 D-69-91-141-110 kernel: usb 1-7: New USB device found, idVendor=174f, idProduct=5a31
Dec 27 21:39:03 D-69-91-141-110 kernel: usb 1-7: New USB device strings: Mfr=2, Product=1, SerialNumber=3
Dec 27 21:39:03 D-69-91-141-110 kernel: usb 1-7: Product: USB 2.0 Camera
Dec 27 21:39:03 D-69-91-141-110 kernel: usb 1-7: Manufacturer: Sonix Technology Co., Ltd.
Dec 27 21:39:03 D-69-91-141-110 kernel: usb 1-7: SerialNumber: SN0001
Dec 27 21:39:03 D-69-91-141-110 kernel: psmouse serio4: synaptics: Touchpad model: 1, fw: 6.1, id: 0xa3a0b3, caps: 0xa04713/0x10008/0x0/0x0, board id: 0, fw id: 30712
Dec 27 21:39:03 D-69-91-141-110 kernel: input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio4/input/input8
Dec 27 21:39:03 D-69-91-141-110 kernel: PM: Starting manual resume from disk
Dec 27 21:39:03 D-69-91-141-110 kernel: PM: Image not found (code -22)
Dec 27 21:39:03 D-69-91-141-110 kernel: scsi 6:0:0:0: Direct-Access     Generic- xD/SDMMC/MS/Pro  1.00 PQ: 0 ANSI: 0 CCS
Dec 27 21:39:03 D-69-91-141-110 kernel: EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
Dec 27 21:39:03 D-69-91-141-110 kernel: sd 6:0:0:0: [sdb] 62333952 512-byte logical blocks: (31.9 GB/29.7 GiB)
Dec 27 21:39:03 D-69-91-141-110 kernel: sd 6:0:0:0: [sdb] Write Protect is off
Dec 27 21:39:03 D-69-91-141-110 kernel: sd 6:0:0:0: [sdb] Mode Sense: 03 00 00 00
Dec 27 21:39:03 D-69-91-141-110 kernel: sd 6:0:0:0: [sdb] No Caching mode page found
Dec 27 21:39:03 D-69-91-141-110 kernel: sd 6:0:0:0: [sdb] Assuming drive cache: write through
Dec 27 21:39:03 D-69-91-141-110 kernel:  sdb: sdb1
Dec 27 21:39:03 D-69-91-141-110 kernel: sd 6:0:0:0: [sdb] Attached SCSI removable disk
Dec 27 21:39:03 D-69-91-141-110 kernel: random: crng init done
Dec 27 21:39:03 D-69-91-141-110 kernel: ip_tables: (C) 2000-2006 Netfilter Core Team
Dec 27 21:39:03 D-69-91-141-110 systemd[1]: systemd 232 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
Dec 27 21:39:03 D-69-91-141-110 systemd[1]: Detected architecture x86.
Dec 27 21:39:03 D-69-91-141-110 systemd[1]: Set hostname to <D-69-91-141-110>.
Dec 27 21:39:03 D-69-91-141-110 systemd[1]: Configuration file /etc/systemd/system/kdump.service is marked executable. Please remove executable permission bits. Proceeding anyway.
Dec 27 21:39:03 D-69-91-141-110 systemd[1]: Listening on Syslog Socket.
Dec 27 21:39:03 D-69-91-141-110 systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
Dec 27 21:39:03 D-69-91-141-110 systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
Dec 27 21:39:03 D-69-91-141-110 systemd[1]: Started Forward Password Requests to Wall Directory Watch.
Dec 27 21:39:03 D-69-91-141-110 systemd[1]: Created slice System Slice.
Dec 27 21:39:03 D-69-91-141-110 systemd[1]: Created slice User and Session Slice.
Dec 27 21:39:03 D-69-91-141-110 systemd-journald[183]: Journal started
Dec 27 21:39:03 D-69-91-141-110 systemd-journald[183]: Runtime journal (/run/log/journal/232ecae4e62643e0ac09bafad7167a6f) is 3.3M, max 26.5M, 23.2M free.
Dec 27 21:39:03 D-69-91-141-110 systemd[1]: Started Apply Kernel Variables.
Dec 27 21:39:03 D-69-91-141-110 systemd[1]: Started Create list of required static device nodes for the current kernel.
Dec 27 21:39:03 D-69-91-141-110 systemd[1]: Starting Create Static Device Nodes in /dev...
Dec 27 21:39:03 D-69-91-141-110 systemd[1]: Mounted Huge Pages File System.
Dec 27 21:39:03 D-69-91-141-110 systemd[1]: Mounted Debug File System.
Dec 27 21:39:03 D-69-91-141-110 systemd[1]: Mounted POSIX Message Queue File System.
Dec 27 21:39:03 D-69-91-141-110 kernel: EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
Dec 27 21:39:03 D-69-91-141-110 systemd[1]: Started Remount Root and Kernel File Systems.
Dec 27 21:39:03 D-69-91-141-110 systemd[1]: Starting Load/Save Random Seed...
Dec 27 21:39:03 D-69-91-141-110 systemd[1]: Starting udev Coldplug all Devices...
Dec 27 21:39:03 D-69-91-141-110 systemd[1]: Starting Flush Journal to Persistent Storage...
Dec 27 21:39:04 D-69-91-141-110 systemd[1]: Started Load/Save Random Seed.
Dec 27 21:39:04 D-69-91-141-110 systemd[1]: Started udev Coldplug all Devices.
Dec 27 21:39:04 D-69-91-141-110 systemd-journald[183]: Time spent on flushing to /var is 1.410051s for 799 entries.

--mgubwa272adwpo32--
