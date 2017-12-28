Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33468 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbdL1QDr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Dec 2017 11:03:47 -0500
Date: Thu, 28 Dec 2017 11:05:22 -0500
From: Alexandru Chirvasitu <achirvasub@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Mikael Pettersson <mikpelinux@gmail.com>,
        Josh Poulson <jopoulso@microsoft.com>,
        Mihai Costache <v-micos@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Simon Xiao <sixiao@microsoft.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devel@linuxdriverproject.org, KY Srinivasan <kys@microsoft.com>
Subject: Re: PROBLEM: 4.15.0-rc3 APIC causes lockups on Core 2 Duo laptop
Message-ID: <20171228160522.GC10658@chirva-slack.chirva-slack>
References: <20171218082011.GA24638@arch-chirva.localdomain>
 <20171218101131.GA5338@amd>
 <20171219083421.GB24638@arch-chirva.localdomain>
 <alpine.DEB.2.20.1712200124440.2282@nanos>
 <ec3a298b-27a3-f3fe-ea8d-a777669104ba@cn.fujitsu.com>
 <20171220131929.GC24638@arch-chirva.localdomain>
 <alpine.DEB.2.20.1712281145510.1688@nanos>
 <20171228142117.GA10658@chirva-slack.chirva-slack>
 <alpine.DEB.2.20.1712281531120.1899@nanos>
 <20171228154835.GB10658@chirva-slack.chirva-slack>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="NMuMz9nt05w80d4+"
In-Reply-To: <20171228154835.GB10658@chirva-slack.chirva-slack>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 28, 2017 at 10:48:35AM -0500, Alexandru Chirvasitu wrote:
> On Thu, Dec 28, 2017 at 03:48:15PM +0100, Thomas Gleixner wrote:
> > On Thu, 28 Dec 2017, Alexandru Chirvasitu wrote:
> > > On Thu, Dec 28, 2017 at 12:00:47PM +0100, Thomas Gleixner wrote:
> > > > Ok, lets take a step back. The bisect/kexec attempts led us away from the
> > > > initial problem which is the machine locking up after login, right?
> > > >
> > > 
> > > Yes; sorry about that..
> > 
> > Nothing to be sorry about.
> > 
> > >     x86/vector: Replace the raw_spin_lock() with
> > > 
> > > diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
> > > index 7504491..e5bab02 100644
> > > --- a/arch/x86/kernel/apic/vector.c
> > > +++ b/arch/x86/kernel/apic/vector.c
> > > @@ -726,6 +726,7 @@ static int apic_set_affinity(struct irq_data *irqd,
> > >                              const struct cpumask *dest, bool force)
> > >  {
> > >         struct apic_chip_data *apicd = apic_chip_data(irqd);
> > > +       unsigned long flags;
> > >         int err;
> > >  
> > >         /*
> > > @@ -740,13 +741,13 @@ static int apic_set_affinity(struct irq_data *irqd,
> > >             (apicd->is_managed || apicd->can_reserve))
> > >                 return IRQ_SET_MASK_OK;
> > >  
> > > -       raw_spin_lock(&vector_lock);
> > > +       raw_spin_lock_irqsave(&vector_lock, flags);
> > >         cpumask_and(vector_searchmask, dest, cpu_online_mask);
> > >         if (irqd_affinity_is_managed(irqd))
> > >                 err = assign_managed_vector(irqd, vector_searchmask);
> > >         else
> > >                 err = assign_vector_locked(irqd, vector_searchmask);
> > > -       raw_spin_unlock(&vector_lock);
> > > +       raw_spin_unlock_irqrestore(&vector_lock, flags);
> > >         return err ? err : IRQ_SET_MASK_OK;
> > >  }
> > > 
> > > With this, I still get the lockup messages after login, but not the
> > > freezes!
> > 
> > That's really interesting. There should be no code path which calls into
> > that with interrupts enabled. I assume you never ran that kernel with
> > CONFIG_PROVE_LOCKING=y.
> >
> 
> Correct. That option is not set in .config.
> 
> > Find below a debug patch which should show us the call chain for that
> > case. Please apply that on top of Dou's patch so the machine stays
> > accessible. Plain output from dmesg is sufficient.
> > 
> > > The lockups register in the log, which I am attaching (see below for
> > > attachment naming conventions).
> > 
> > Hmm. That's RCU lockups and that backtrace on the CPU which gets the stall
> > looks very familiar. I'd like to see the above result first and then I'll
> > send you another pile of patches which might cure that RCU issue.
> > 
> > Thanks,
> > 
> > 	tglx
> > 
> > 8<-------------------
> > --- a/arch/x86/kernel/apic/vector.c
> > +++ b/arch/x86/kernel/apic/vector.c
> > @@ -729,6 +729,8 @@ static int apic_set_affinity(struct irq_
> >  	unsigned long flags;
> >  	int err;
> >  
> > +	WARN_ON_ONCE(!irqs_disabled());
> > +
> >  	/*
> >  	 * Core code can call here for inactive interrupts. For inactive
> >  	 * interrupts which use managed or reservation mode there is no
> > 
> > 
> > 
> 
> Bit of a step back here: the kernel treated with Dou's patch no longer
> logs me in reliably as before, with or without this newest patch on
> top..
> 
> So now I sometimes get immediate lockups and freezes upon trying to
> log in, and other times I get logged in but get a freeze seconds
> later.
> 
> In no case can I roam around long nough to get a dmesg, and I no
> longer get the non-freezing lockups from before. I can't imagine what
> I could possibly have changed..
> 
> Here's the output of `git log --pretty=oneline -5` on the branch I'm
> working in.
> 
> --------------------
> 
> f2c02af5cc1d620c039b21fab0ca5948a06daf90 2nd tglx patch
> 7715575170bacf3566d400b9f2210a10ce152880 x86/vector: Replace the raw_spin_lock() with raw_spin_lock_irqsave()
> 8d9d56caf33d78bfe6b6087767b1b84acee58458 x86-32: fix kexec with stack canary (CONFIG_CC_STACKPROTECTOR)
> a197e9dea4ccb72e1a6457fac15329bd5319e719 irq/matrix: Remove the overused BUGON() in irq_matrix_assign_system()
> 464e1d5f23cca236b930ef068c328a64cab78fb1 Linux 4.15-rc5
> 
> --------------------
> 
> 7715575170bacf3566d400b9f2210a10ce152880, which is the kernel with
> Dou's patch, logged me in and allowed me to produce the dmesg from
> before. I did this a couple of times back then. I no longer can, for
> some reason, as it's reverted back to the no-go lockups from before.
> 
> And the next one, f2c02af5cc1d620c039b21fab0ca5948a06daf90, where I
> applied the patch you just sent, behaves identically.
> 
>

Actually, it decided to cooperate for just long enough for me to get
the dmesg out. Attached.

This is from the kernel you asked about: Dou's patch + yours, i.e. the
latest one in that git log I just sent, booted up with 'apic=debug'.

--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=log

[    0.000000] Linux version 4.15.0-rc5-dou-thms-p2+ (root@axiomatic) (gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.5)) #1 SMP Thu Dec 28 10:06:24 EST 2017
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000b7f9ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000b7fa0000-0x00000000b7fadfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000b7fae000-0x00000000b7feffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000b7ff0000-0x00000000b7ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffb80000-0x00000000ffffffff] reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] random: fast init done
[    0.000000] SMBIOS 2.4 present.
[    0.000000] DMI: ASUSTeK Computer Inc. F5RL                /F5RL      , BIOS 210     06/12/2008
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0xb7fa0 max_arch_pfn = 0x1000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-CFFFF write-protect
[    0.000000]   D0000-DFFFF uncachable
[    0.000000]   E0000-EFFFF write-through
[    0.000000]   F0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask F80000000 write-back
[    0.000000]   1 base 080000000 mask FE0000000 write-back
[    0.000000]   2 base 0A0000000 mask FF0000000 write-back
[    0.000000]   3 base 0B0000000 mask FF8000000 write-back
[    0.000000]   4 base 0B8000000 mask FFC000000 write-back
[    0.000000]   5 base 0BC000000 mask FFF000000 write-back
[    0.000000]   6 base 0C0000000 mask FF0000000 write-combining
[    0.000000]   7 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000000] Scan for SMP in [mem 0x00000000-0x000003ff]
[    0.000000] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
[    0.000000] Scan for SMP in [mem 0x000f0000-0x000fffff]
[    0.000000] found SMP MP-table at [mem 0x000ff780-0x000ff78f] mapped at [(ptrval)]
[    0.000000]   mpc: fd2d0-fd434
[    0.000000] initial memory mapped: [mem 0x00000000-0x16dfffff]
[    0.000000] Base memory trampoline at [(ptrval)] 9b000 size 16384
[    0.000000] BRK [0x169ee000, 0x169eefff] PGTABLE
[    0.000000] BRK [0x169ef000, 0x169f0fff] PGTABLE
[    0.000000] BRK [0x169f1000, 0x169f1fff] PGTABLE
[    0.000000] BRK [0x169f2000, 0x169f2fff] PGTABLE
[    0.000000] RAMDISK: [mem 0x35d37000-0x36e92fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F8070 000014 (v00 ACPIAM)
[    0.000000] ACPI: RSDT 0x00000000B7FA0000 00003C (v01 A_M_I_ OEMRSDT  06000812 MSFT 00000097)
[    0.000000] ACPI: FACP 0x00000000B7FA0200 000084 (v02 A_M_I_ OEMFACP  06000812 MSFT 00000097)
[    0.000000] ACPI: DSDT 0x00000000B7FA0630 0075FA (v01 A0669  A0669000 00000000 INTL 20060113)
[    0.000000] ACPI: FACS 0x00000000B7FAE000 000040
[    0.000000] ACPI: APIC 0x00000000B7FA0390 00005C (v01 A_M_I_ OEMAPIC  06000812 MSFT 00000097)
[    0.000000] ACPI: MCFG 0x00000000B7FA03F0 00003C (v01 A_M_I_ OEMMCFG  06000812 MSFT 00000097)
[    0.000000] ACPI: SLIC 0x00000000B7FA0430 000176 (v01 A_M_I_ OEMSLIC  06000812 MSFT 00000097)
[    0.000000] ACPI: BOOT 0x00000000B7FA0600 000028 (v01 A_M_I_ OEMBOOT  06000812 MSFT 00000097)
[    0.000000] ACPI: OEMB 0x00000000B7FAE040 00005B (v01 A_M_I_ AMI_OEM  06000812 MSFT 00000097)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] mapped APIC to         ffffc000 (        fee00000)
[    0.000000] 2057MB HIGHMEM available.
[    0.000000] 885MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 375fe000
[    0.000000]   low ram: 0 - 375fe000
[    0.000000] Reserving 256MB of memory at 96MB for crashkernel (System RAM: 2943MB)
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] BRK [0x169f3000, 0x169f3fff] PGTABLE
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   Normal   [mem 0x0000000001000000-0x00000000375fdfff]
[    0.000000]   HighMem  [mem 0x00000000375fe000-0x00000000b7f9ffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000b7f9ffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x00000000b7f9ffff]
[    0.000000] On node 0 totalpages: 753470
[    0.000000]   DMA zone: 36 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
[    0.000000]   Normal zone: 1958 pages used for memmap
[    0.000000]   Normal zone: 222718 pages, LIFO batch:31
[    0.000000]   HighMem zone: 526754 pages, LIFO batch:31
[    0.000000] Reserved but unavailable: 98 pages
[    0.000000] Using APIC driver default
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] IOAPIC[0]: apic_id 2, version 33, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 2, APIC INT 02
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] Int: type 0, pol 3, trig 3, bus 00, IRQ 09, APIC ID 2, APIC INT 09
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 2, APIC INT 01
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 2, APIC INT 03
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 2, APIC INT 04
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 05, APIC ID 2, APIC INT 05
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 2, APIC INT 06
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 2, APIC INT 07
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 2, APIC INT 08
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0a, APIC ID 2, APIC INT 0a
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0b, APIC ID 2, APIC INT 0b
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 2, APIC INT 0c
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 2, APIC INT 0d
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 2, APIC INT 0e
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 2, APIC INT 0f
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] mapped IOAPIC to ffffb000 (fec00000)
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.000000] e820: [mem 0xb8000000-0xfedfffff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:32 nr_cpumask_bits:32 nr_cpu_ids:2 nr_node_ids:1
[    0.000000] percpu: Embedded 24 pages/cpu @(ptrval) s65612 r0 d32692 u98304
[    0.000000] pcpu-alloc: s65612 r0 d32692 u98304 alloc=24*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 751476
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.15.0-rc5-dou-thms-p2+ root=UUID=5a437cd2-c27b-4829-a7ba-533eb741b148 ro 3 crashkernel=256M quiet apic=debug
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] microcode: microcode updated early to revision 0xa4, date = 2010-10-02
[    0.000000] Initializing CPU#0
[    0.000000] Initializing HighMem for node 0 (000375fe:000b7fa0)
[    0.000000] Initializing Movable for node 0 (00000000:00000000)
[    0.000000] Memory: 2696228K/3013880K available (5865K kernel code, 593K rwdata, 1836K rodata, 604K init, 428K bss, 317652K reserved, 0K cma-reserved, 2107016K highmem)
[    0.000000] virtual kernel memory layout:
                   fixmap  : 0xffd36000 - 0xfffff000   (2852 kB)
                 cpu_entry : 0xff800000 - 0xff8c1000   ( 772 kB)
                   pkmap   : 0xff600000 - 0xff800000   (2048 kB)
                   vmalloc : 0xf7dfe000 - 0xff5fe000   ( 120 MB)
                   lowmem  : 0xc0000000 - 0xf75fe000   ( 885 MB)
                     .init : 0xd682e000 - 0xd68c5000   ( 604 kB)
                     .data : 0xd65ba464 - 0xd6820780   (2456 kB)
                     .text : 0xd6000000 - 0xd65ba464   (5865 kB)
[    0.000000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=32 to nr_cpu_ids=2.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[    0.000000] NR_IRQS: 2304, nr_irqs: 440, preallocated irqs: 16
[    0.000000] CPU 0 irqstacks, hard=(ptrval) soft=(ptrval)
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] ACPI: Core revision 20170831
[    0.000000] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.000000] APIC: Switch to symmetric I/O mode setup
[    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.000000] enabled ExtINT on CPU#0
[    0.000000] ESR value before enabling vector: 0x00000040  after: 0x00000000
[    0.000000] ENABLING IO-APIC IRQs
[    0.000000] init IO_APIC IRQs
[    0.000000]  apic 2 pin 0 not connected
[    0.000000] IOAPIC[0]: Set routing entry (2-1 -> 0xef -> IRQ 1 Mode:0 Active:0 Dest:1)
[    0.000000] IOAPIC[0]: Set routing entry (2-2 -> 0x30 -> IRQ 0 Mode:0 Active:0 Dest:1)
[    0.000000] IOAPIC[0]: Set routing entry (2-3 -> 0xef -> IRQ 3 Mode:0 Active:0 Dest:1)
[    0.000000] IOAPIC[0]: Set routing entry (2-4 -> 0xef -> IRQ 4 Mode:0 Active:0 Dest:1)
[    0.000000] IOAPIC[0]: Set routing entry (2-5 -> 0xef -> IRQ 5 Mode:0 Active:0 Dest:1)
[    0.000000] IOAPIC[0]: Set routing entry (2-6 -> 0xef -> IRQ 6 Mode:0 Active:0 Dest:1)
[    0.000000] IOAPIC[0]: Set routing entry (2-7 -> 0xef -> IRQ 7 Mode:0 Active:0 Dest:1)
[    0.000000] IOAPIC[0]: Set routing entry (2-8 -> 0xef -> IRQ 8 Mode:0 Active:0 Dest:1)
[    0.000000] IOAPIC[0]: Set routing entry (2-9 -> 0xef -> IRQ 9 Mode:1 Active:1 Dest:1)
[    0.000000] IOAPIC[0]: Set routing entry (2-10 -> 0xef -> IRQ 10 Mode:0 Active:0 Dest:1)
[    0.000000] IOAPIC[0]: Set routing entry (2-11 -> 0xef -> IRQ 11 Mode:0 Active:0 Dest:1)
[    0.000000] IOAPIC[0]: Set routing entry (2-12 -> 0xef -> IRQ 12 Mode:0 Active:0 Dest:1)
[    0.000000] IOAPIC[0]: Set routing entry (2-13 -> 0xef -> IRQ 13 Mode:0 Active:0 Dest:1)
[    0.000000] IOAPIC[0]: Set routing entry (2-14 -> 0xef -> IRQ 14 Mode:0 Active:0 Dest:1)
[    0.000000] IOAPIC[0]: Set routing entry (2-15 -> 0xef -> IRQ 15 Mode:0 Active:0 Dest:1)
[    0.000000]  apic 2 pin 16 not connected
[    0.000000]  apic 2 pin 17 not connected
[    0.000000]  apic 2 pin 18 not connected
[    0.000000]  apic 2 pin 19 not connected
[    0.000000]  apic 2 pin 20 not connected
[    0.000000]  apic 2 pin 21 not connected
[    0.000000]  apic 2 pin 22 not connected
[    0.000000]  apic 2 pin 23 not connected
[    0.000000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.020000] tsc: Fast TSC calibration using PIT
[    0.024000] tsc: Detected 1662.592 MHz processor
[    0.024000] Calibrating delay loop (skipped), value calculated using timer frequency.. 3325.18 BogoMIPS (lpj=6650368)
[    0.024000] pid_max: default: 32768 minimum: 301
[    0.024000] Security Framework initialized
[    0.024000] Yama: becoming mindful.
[    0.024000] AppArmor: AppArmor disabled by boot time parameter
[    0.024000] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.024000] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.024000] CPU: Physical Processor ID: 0
[    0.024000] CPU: Processor Core ID: 0
[    0.024000] mce: CPU supports 6 MCE banks
[    0.024000] process: using mwait in idle threads
[    0.024000] Last level iTLB entries: 4KB 128, 2MB 4, 4MB 4
[    0.024000] Last level dTLB entries: 4KB 256, 2MB 0, 4MB 32, 1GB 0
[    0.024000] Freeing SMP alternatives memory: 24K
[    0.028181] Using local APIC timer interrupts.
               calibrating APIC timer ...
[    0.032000] ... lapic delta = 1039124
[    0.032000] ... PM-Timer delta = 357975
[    0.032000] ... PM-Timer result ok
[    0.032000] ..... delta 1039124
[    0.032000] ..... mult: 44630035
[    0.032000] ..... calibration result: 665039
[    0.032000] ..... CPU clock speed is 1662.2390 MHz.
[    0.032000] ..... host bus clock speed is 166.1039 MHz.
[    0.032000] smpboot: CPU0: Intel(R) Core(TM)2 Duo CPU     T5450  @ 1.66GHz (family: 0x6, model: 0xf, stepping: 0xd)
[    0.032000] Performance Events: PEBS fmt0+, Core2 events, Intel PMU driver.
[    0.032000] core: PEBS disabled due to CPU errata
[    0.032000] ... version:                2
[    0.032000] ... bit width:              40
[    0.032000] ... generic registers:      2
[    0.032000] ... value mask:             000000ffffffffff
[    0.032000] ... max period:             000000007fffffff
[    0.032000] ... fixed-purpose events:   3
[    0.032000] ... event mask:             0000000700000003
[    0.032000] Hierarchical SRCU implementation.
[    0.032000] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.032000] smp: Bringing up secondary CPUs ...
[    0.032000] CPU 1 irqstacks, hard=25bf07ed soft=e308ee92
[    0.032000] x86: Booting SMP configuration:
[    0.032000] .... node  #0, CPUs:      #1
[    0.004000] Initializing CPU#1
[    0.004000] masked ExtINT on CPU#1
[    0.032128] smp: Brought up 1 node, 2 CPUs
[    0.032128] smpboot: Max logical packages: 1
[    0.032128] smpboot: Total of 2 processors activated (6650.36 BogoMIPS)
[    0.033772] devtmpfs: initialized
[    0.033772] PM: Registering ACPI NVS region [mem 0xb7fae000-0xb7feffff] (270336 bytes)
[    0.033772] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.033772] futex hash table entries: 512 (order: 3, 32768 bytes)
[    0.033772] pinctrl core: initialized pinctrl subsystem
[    0.033772] NET: Registered protocol family 16
[    0.033772] audit: initializing netlink subsys (disabled)
[    0.036019] audit: type=2000 audit(1514476480.036:1): state=initialized audit_enabled=0 res=1
[    0.036177] cpuidle: using governor ladder
[    0.036177] cpuidle: using governor menu
[    0.036177] Simple Boot Flag at 0xff set to 0x1
[    0.036177] ACPI: bus type PCI registered
[    0.036177] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.036213] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.036217] PCI: not using MMCONFIG
[    0.036363] PCI: PCI BIOS area is rw and x. Use pci=nobios if you want it NX.
[    0.036457] PCI: PCI BIOS revision 3.00 entry at 0xf0031, last bus=8
[    0.036458] PCI: Using configuration type 1 for base access
[    0.036650] mtrr: your CPUs had inconsistent variable MTRR settings
[    0.036651] mtrr: probably your BIOS does not setup all CPUs.
[    0.036652] mtrr: corrected configuration.
[    0.038085] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.038085] ACPI: Added _OSI(Module Device)
[    0.038085] ACPI: Added _OSI(Processor Device)
[    0.038085] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.038085] ACPI: Added _OSI(Processor Aggregator Device)
[    0.038085] ACPI: Executed 2 blocks of module-level executable AML code
[    0.048008] ACPI: Dynamic OEM Table Load:
[    0.048008] ACPI: SSDT 0x00000000F7175000 000C99 (v01 AMI    CPU1PM   00000001 INTL 20060113)
[    0.048008] ACPI: Dynamic OEM Table Load:
[    0.048008] ACPI: SSDT 0x00000000F7178000 000C99 (v01 AMI    CPU2PM   00000001 INTL 20060113)
[    0.048008] ACPI: EC: EC started
[    0.048008] ACPI: EC: interrupt blocked
[    0.048008] ACPI: \_SB_.PCI0.SBRG.EC0_: Used as first EC
[    0.048008] ACPI: \_SB_.PCI0.SBRG.EC0_: GPE=0x11, EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.048008] ACPI: \_SB_.PCI0.SBRG.EC0_: Used as boot DSDT EC to handle transactions
[    0.048008] ACPI: Interpreter enabled
[    0.048008] ACPI: (supports S0 S3 S4 S5)
[    0.048008] ACPI: Using IOAPIC for interrupt routing
[    0.048008] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.048008] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in ACPI motherboard resources
[    0.048008] PCI: Using MMCONFIG for extended config space
[    0.048008] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.052274] ACPI: Enabled 6 GPEs in block 00 to 1F
[    0.062880] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.062888] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.062895] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.063315] PCI host bridge to bus 0000:00
[    0.063319] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.063322] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.063324] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.063327] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000dffff window]
[    0.063329] pci_bus 0000:00: root bus resource [mem 0xb8000000-0xffffffff window]
[    0.063332] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.063347] pci 0000:00:00.0: [1002:5a31] type 00 class 0x060000
[    0.063515] pci 0000:00:01.0: [1002:5a3f] type 01 class 0x060400
[    0.063694] pci 0000:00:04.0: [1002:5a36] type 01 class 0x060400
[    0.063728] pci 0000:00:04.0: enabling Extended Tags
[    0.063770] pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
[    0.063920] pci 0000:00:05.0: [1002:5a37] type 01 class 0x060400
[    0.063954] pci 0000:00:05.0: enabling Extended Tags
[    0.063994] pci 0000:00:05.0: PME# supported from D0 D3hot D3cold
[    0.064147] pci 0000:00:06.0: [1002:5a38] type 01 class 0x060400
[    0.064181] pci 0000:00:06.0: enabling Extended Tags
[    0.064221] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
[    0.064366] pci 0000:00:07.0: [1002:5a39] type 01 class 0x060400
[    0.064395] pci 0000:00:07.0: enabling Extended Tags
[    0.064436] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
[    0.064605] pci 0000:00:12.0: [1002:4380] type 00 class 0x01018f
[    0.064639] pci 0000:00:12.0: reg 0x10: [io  0xe800-0xe807]
[    0.064654] pci 0000:00:12.0: reg 0x14: [io  0xe400-0xe403]
[    0.064668] pci 0000:00:12.0: reg 0x18: [io  0xe000-0xe007]
[    0.064683] pci 0000:00:12.0: reg 0x1c: [io  0xdc00-0xdc03]
[    0.064697] pci 0000:00:12.0: reg 0x20: [io  0xd800-0xd80f]
[    0.064712] pci 0000:00:12.0: reg 0x24: [mem 0xfebffc00-0xfebfffff]
[    0.064747] pci 0000:00:12.0: set SATA to AHCI mode
[    0.064918] pci 0000:00:13.0: [1002:4387] type 00 class 0x0c0310
[    0.064946] pci 0000:00:13.0: reg 0x10: [mem 0xfebfe000-0xfebfefff]
[    0.065172] pci 0000:00:13.1: [1002:4388] type 00 class 0x0c0310
[    0.065200] pci 0000:00:13.1: reg 0x10: [mem 0xfebfd000-0xfebfdfff]
[    0.065424] pci 0000:00:13.2: [1002:4389] type 00 class 0x0c0310
[    0.065452] pci 0000:00:13.2: reg 0x10: [mem 0xfebfc000-0xfebfcfff]
[    0.065679] pci 0000:00:13.3: [1002:438a] type 00 class 0x0c0310
[    0.065707] pci 0000:00:13.3: reg 0x10: [mem 0xfebfb000-0xfebfbfff]
[    0.065933] pci 0000:00:13.4: [1002:438b] type 00 class 0x0c0310
[    0.065961] pci 0000:00:13.4: reg 0x10: [mem 0xfebfa000-0xfebfafff]
[    0.066196] pci 0000:00:13.5: [1002:4386] type 00 class 0x0c0320
[    0.066229] pci 0000:00:13.5: reg 0x10: [mem 0xfebff800-0xfebff8ff]
[    0.066355] pci 0000:00:13.5: supports D1 D2
[    0.066358] pci 0000:00:13.5: PME# supported from D0 D1 D2 D3hot
[    0.066502] pci 0000:00:14.0: [1002:4385] type 00 class 0x0c0500
[    0.066537] pci 0000:00:14.0: reg 0x10: [io  0x0b00-0x0b0f]
[    0.066752] pci 0000:00:14.1: [1002:438c] type 00 class 0x010182
[    0.066780] pci 0000:00:14.1: reg 0x10: [io  0x0000-0x0007]
[    0.066794] pci 0000:00:14.1: reg 0x14: [io  0x0000-0x0003]
[    0.066809] pci 0000:00:14.1: reg 0x18: [io  0x0000-0x0007]
[    0.066823] pci 0000:00:14.1: reg 0x1c: [io  0x0000-0x0003]
[    0.066837] pci 0000:00:14.1: reg 0x20: [io  0xff00-0xff0f]
[    0.066868] pci 0000:00:14.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.066870] pci 0000:00:14.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.066873] pci 0000:00:14.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.066875] pci 0000:00:14.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.067015] pci 0000:00:14.2: [1002:4383] type 00 class 0x040300
[    0.067054] pci 0000:00:14.2: reg 0x10: [mem 0xfebf4000-0xfebf7fff 64bit]
[    0.067160] pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
[    0.067300] pci 0000:00:14.3: [1002:438d] type 00 class 0x060100
[    0.067537] pci 0000:00:14.4: [1002:4384] type 01 class 0x060401
[    0.067823] pci 0000:01:05.0: [1002:5a62] type 00 class 0x030000
[    0.067840] pci 0000:01:05.0: reg 0x10: [mem 0xc0000000-0xcfffffff pref]
[    0.067848] pci 0000:01:05.0: reg 0x14: [io  0x9800-0x98ff]
[    0.067856] pci 0000:01:05.0: reg 0x18: [mem 0xfa8f0000-0xfa8fffff]
[    0.067880] pci 0000:01:05.0: reg 0x30: [mem 0xfa8c0000-0xfa8dffff pref]
[    0.067912] pci 0000:01:05.0: supports D1 D2
[    0.067997] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.068007] pci 0000:00:01.0:   bridge window [io  0x9000-0x9fff]
[    0.068011] pci 0000:00:01.0:   bridge window [mem 0xfa800000-0xfa8fffff]
[    0.068014] pci 0000:00:01.0:   bridge window [mem 0xbdf00000-0xddefffff pref]
[    0.068108] pci 0000:02:00.0: [168c:001c] type 00 class 0x020000
[    0.068148] pci 0000:02:00.0: reg 0x10: [mem 0xfa9f0000-0xfa9fffff 64bit]
[    0.068396] pci 0000:02:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.068408] pci 0000:00:04.0: PCI bridge to [bus 02]
[    0.068415] pci 0000:00:04.0:   bridge window [mem 0xfa900000-0xfa9fffff]
[    0.068523] acpiphp: Slot [1] registered
[    0.068529] pci 0000:00:05.0: PCI bridge to [bus 03-05]
[    0.068535] pci 0000:00:05.0:   bridge window [io  0xa000-0xbfff]
[    0.068539] pci 0000:00:05.0:   bridge window [mem 0xfaa00000-0xfe9fffff]
[    0.068545] pci 0000:00:05.0:   bridge window [mem 0xddf00000-0xdfefffff 64bit pref]
[    0.068621] pci 0000:06:00.0: [1969:2048] type 00 class 0x020000
[    0.068660] pci 0000:06:00.0: reg 0x10: [mem 0xfeac0000-0xfeafffff 64bit]
[    0.068722] pci 0000:06:00.0: reg 0x30: [mem 0xfeaa0000-0xfeabffff pref]
[    0.068803] pci 0000:06:00.0: PME# supported from D3hot D3cold
[    0.068890] pci 0000:06:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.068900] pci 0000:00:06.0: PCI bridge to [bus 06]
[    0.068908] pci 0000:00:06.0:   bridge window [mem 0xfea00000-0xfeafffff]
[    0.068966] pci 0000:00:07.0: PCI bridge to [bus 07]
[    0.069092] pci 0000:00:14.4: PCI bridge to [bus 08] (subtractive decode)
[    0.069105] pci 0000:00:14.4:   bridge window [io  0x0000-0x0cf7 window] (subtractive decode)
[    0.069108] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
[    0.069110] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    0.069113] pci 0000:00:14.4:   bridge window [mem 0x000d0000-0x000dffff window] (subtractive decode)
[    0.069115] pci 0000:00:14.4:   bridge window [mem 0xb8000000-0xffffffff window] (subtractive decode)
[    0.069146] pci_bus 0000:00: on NUMA node 0
[    0.069888] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 7 10 11 12)
[    0.069977] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 12)
[    0.070063] ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 7 10 11 12)
[    0.070148] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *10 11 12)
[    0.070234] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 12) *0, disabled.
[    0.070321] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 12) *0, disabled.
[    0.070407] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 *11 12)
[    0.070493] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 12) *0, disabled.
[    0.070823] ACPI: EC: interrupt unblocked
[    0.070832] ACPI: EC: event unblocked
[    0.070841] ACPI: \_SB_.PCI0.SBRG.EC0_: GPE=0x11, EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.070844] ACPI: \_SB_.PCI0.SBRG.EC0_: Used as boot DSDT EC to handle transactions and events
[    0.070947] pci 0000:01:05.0: vgaarb: setting as boot VGA device
[    0.070947] pci 0000:01:05.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.070947] pci 0000:01:05.0: vgaarb: bridge control possible
[    0.070947] vgaarb: loaded
[    0.070947] EDAC MC: Ver: 3.0.0
[    0.072081] PCI: Using ACPI for IRQ routing
[    0.072143] PCI: pci_cache_line_size set to 64 bytes
[    0.072223] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.072226] e820: reserve RAM buffer [mem 0xb7fa0000-0xb7ffffff]
[    0.072454] clocksource: Switched to clocksource refined-jiffies
[    0.095197] VFS: Disk quotas dquot_6.6.0
[    0.095264] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.095492] pnp: PnP ACPI init
[    0.095817] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.096281] system 00:01: [io  0x04d0-0x04d1] has been reserved
[    0.096284] system 00:01: [io  0x040b] has been reserved
[    0.096289] system 00:01: [io  0x04d6] has been reserved
[    0.096292] system 00:01: [io  0x0c00-0x0c01] has been reserved
[    0.096294] system 00:01: [io  0x0c14] has been reserved
[    0.096297] system 00:01: [io  0x0c50-0x0c51] has been reserved
[    0.096300] system 00:01: [io  0x0c52] has been reserved
[    0.096302] system 00:01: [io  0x0c6c] has been reserved
[    0.096305] system 00:01: [io  0x0c6f] has been reserved
[    0.096307] system 00:01: [io  0x0cd0-0x0cd1] has been reserved
[    0.096311] system 00:01: [io  0x0cd2-0x0cd3] has been reserved
[    0.096313] system 00:01: [io  0x0cd4-0x0cd5] has been reserved
[    0.096316] system 00:01: [io  0x0cd6-0x0cd7] has been reserved
[    0.096319] system 00:01: [io  0x0cd8-0x0cdf] has been reserved
[    0.096323] system 00:01: [io  0x0800-0x089f] has been reserved
[    0.096327] system 00:01: [io  0x0b00-0x0b1f] could not be reserved
[    0.096329] system 00:01: [io  0x0900-0x090f] has been reserved
[    0.096332] system 00:01: [io  0x0910-0x091f] has been reserved
[    0.096335] system 00:01: [io  0xfe00-0xfefe] has been reserved
[    0.096338] system 00:01: [io  0x4000-0x40fe] has been reserved
[    0.096344] system 00:01: [mem 0xfed45000-0xfed89fff] has been reserved
[    0.096347] system 00:01: [mem 0xffb80000-0xffbfffff] has been reserved
[    0.096350] system 00:01: [mem 0xfff80000-0xffffffff] has been reserved
[    0.096359] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.096442] pnp 00:02: Plug and Play ACPI device, IDs PNP0303 PNP030b (active)
[    0.096553] pnp 00:03: Plug and Play ACPI device, IDs SYN0a04 SYN0a00 SYN0002 PNP0f03 PNP0f13 PNP0f12 (active)
[    0.096691] system 00:04: [io  0x0250-0x0253] has been reserved
[    0.096694] system 00:04: [io  0x0256-0x025f] has been reserved
[    0.096697] system 00:04: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.096700] system 00:04: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.096707] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.096896] system 00:05: [mem 0xe0000000-0xefffffff] has been reserved
[    0.096904] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.097333] system 00:06: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.097337] system 00:06: [mem 0x000c0000-0x000cffff] could not be reserved
[    0.097340] system 00:06: [mem 0x000e0000-0x000fffff] could not be reserved
[    0.097343] system 00:06: [mem 0x00100000-0xb7ffffff] could not be reserved
[    0.097350] system 00:06: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.097535] pnp: PnP ACPI: found 7 devices
[    0.097544] PnPBIOS: Disabled
[    0.134932] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.134963] clocksource: Switched to clocksource acpi_pm
[    0.135027] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.135032] pci 0000:00:01.0:   bridge window [io  0x9000-0x9fff]
[    0.135037] pci 0000:00:01.0:   bridge window [mem 0xfa800000-0xfa8fffff]
[    0.135040] pci 0000:00:01.0:   bridge window [mem 0xbdf00000-0xddefffff pref]
[    0.135046] pci 0000:00:04.0: PCI bridge to [bus 02]
[    0.135050] pci 0000:00:04.0:   bridge window [mem 0xfa900000-0xfa9fffff]
[    0.135057] pci 0000:00:05.0: PCI bridge to [bus 03-05]
[    0.135060] pci 0000:00:05.0:   bridge window [io  0xa000-0xbfff]
[    0.135064] pci 0000:00:05.0:   bridge window [mem 0xfaa00000-0xfe9fffff]
[    0.135068] pci 0000:00:05.0:   bridge window [mem 0xddf00000-0xdfefffff 64bit pref]
[    0.135073] pci 0000:00:06.0: PCI bridge to [bus 06]
[    0.135077] pci 0000:00:06.0:   bridge window [mem 0xfea00000-0xfeafffff]
[    0.135084] pci 0000:00:07.0: PCI bridge to [bus 07]
[    0.135093] pci 0000:00:14.4: PCI bridge to [bus 08]
[    0.135112] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.135115] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.135117] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.135119] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000dffff window]
[    0.135122] pci_bus 0000:00: resource 8 [mem 0xb8000000-0xffffffff window]
[    0.135124] pci_bus 0000:01: resource 0 [io  0x9000-0x9fff]
[    0.135127] pci_bus 0000:01: resource 1 [mem 0xfa800000-0xfa8fffff]
[    0.135129] pci_bus 0000:01: resource 2 [mem 0xbdf00000-0xddefffff pref]
[    0.135132] pci_bus 0000:02: resource 1 [mem 0xfa900000-0xfa9fffff]
[    0.135134] pci_bus 0000:03: resource 0 [io  0xa000-0xbfff]
[    0.135136] pci_bus 0000:03: resource 1 [mem 0xfaa00000-0xfe9fffff]
[    0.135138] pci_bus 0000:03: resource 2 [mem 0xddf00000-0xdfefffff 64bit pref]
[    0.135141] pci_bus 0000:06: resource 1 [mem 0xfea00000-0xfeafffff]
[    0.135144] pci_bus 0000:08: resource 4 [io  0x0000-0x0cf7 window]
[    0.135146] pci_bus 0000:08: resource 5 [io  0x0d00-0xffff window]
[    0.135149] pci_bus 0000:08: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.135151] pci_bus 0000:08: resource 7 [mem 0x000d0000-0x000dffff window]
[    0.135153] pci_bus 0000:08: resource 8 [mem 0xb8000000-0xffffffff window]
[    0.135289] NET: Registered protocol family 2
[    0.135648] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.135709] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    0.135820] TCP: Hash tables configured (established 8192 bind 8192)
[    0.135950] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.135983] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.135983] NET: Registered protocol family 1
[    0.135983] pci 0000:00:01.0: MSI quirk detected; subordinate MSI disabled
[    0.135983] IOAPIC[0]: Set routing entry (2-16 -> 0xef -> IRQ 16 Mode:1 Active:1 Dest:1)
[    0.135983] IOAPIC[0]: Set routing entry (2-17 -> 0xef -> IRQ 17 Mode:1 Active:1 Dest:1)
[    0.135983] IOAPIC[0]: Set routing entry (2-18 -> 0xef -> IRQ 18 Mode:1 Active:1 Dest:1)
[    0.135983] IOAPIC[0]: Set routing entry (2-17 -> 0xef -> IRQ 17 Mode:1 Active:1 Dest:1)
[    0.135983] IOAPIC[0]: Set routing entry (2-18 -> 0xef -> IRQ 18 Mode:1 Active:1 Dest:1)
[    0.135983] IOAPIC[0]: Set routing entry (2-19 -> 0xef -> IRQ 19 Mode:1 Active:1 Dest:1)
[    0.135983] pci 0000:01:05.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.135983] pci 0000:06:00.0: [Firmware Bug]: disabling VPD access (can't determine size of non-standard VPD format)
[    0.135983] PCI: CLS 64 bytes, default 64
[    0.135983] Unpacking initramfs...
[    0.736192] Freeing initrd memory: 17776K
[    0.737930] Initialise system trusted keyrings
[    0.738091] workingset: timestamp_bits=14 max_order=20 bucket_order=6
[    0.738149] zbud: loaded
[    1.760144] tsc: Refined TSC clocksource calibration: 1662.500 MHz
[    1.760163] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x17f6c6790c8, max_idle_ns: 440795235729 ns
[    2.784299] clocksource: Switched to clocksource tsc
[    2.860929] Key type asymmetric registered
[    2.860932] Asymmetric key parser 'x509' registered
[    2.860952] bounce: pool size: 64 pages
[    2.860979] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
[    2.861034] io scheduler noop registered
[    2.861035] io scheduler deadline registered
[    2.861065] io scheduler cfq registered (default)
[    2.861067] io scheduler mq-deadline registered
[    2.861068] io scheduler kyber registered
[    2.861495] intel_idle: does not run on family 6 model 15
[    2.861729] tsc: Marking TSC unstable due to TSC halts in idle
[    2.861851] clocksource: Switched to clocksource acpi_pm
[    2.862239] isapnp: Scanning for PnP cards...
[    3.216719] isapnp: No Plug & Play device found
[    3.216848] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    3.217619] Linux agpgart interface v0.103
[    3.218173] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
[    3.220828] i8042: Detected active multiplexing controller, rev 1.1
[    3.222268] serio: i8042 KBD port at 0x60,0x64 irq 1
[    3.222276] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[    3.222335] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[    3.222380] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[    3.222431] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[    3.222666] mousedev: PS/2 mouse device common for all mice
[    3.222757] rtc_cmos 00:00: RTC can wake from S4
[    3.222945] rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
[    3.222973] rtc_cmos 00:00: alarms up to one month, y3k, 114 bytes nvram
[    3.223032] ledtrig-cpu: registered to indicate activity on CPUs
[    3.223578] NET: Registered protocol family 10
[    3.223988] Segment Routing with IPv6
[    3.224044] mip6: Mobile IPv6
[    3.224047] NET: Registered protocol family 17
[    3.224052] mpls_gso: MPLS GSO support
[    3.224337] microcode: sig=0x6fd, pf=0x80, revision=0xa4
[    3.224437] microcode: Microcode Update Driver: v2.2.
[    3.224461] ... APIC ID:      00000000 (0)
[    3.224462] ... APIC VERSION: 00050014
[    3.224464] 0000000000000000000000000000000000000000000000000000000000000000
[    3.224471] 0000000000000000000000000000000000000000000000000000000000000000
[    3.224477] 0000000000000000000000000000000000000000000000000000000000000000
[    3.224484] number of MP IRQ sources: 15.
[    3.224486] number of IO-APIC #2 registers: 24.
[    3.224487] testing the IO APIC.......................
[    3.224494] IO APIC #2......
[    3.224495] .... register #00: 02000000
[    3.224496] .......    : physical APIC id: 02
[    3.224497] .......    : Delivery Type: 0
[    3.224498] .......    : LTS          : 0
[    3.224499] .... register #01: 00178021
[    3.224500] .......     : max redirection entries: 17
[    3.224501] .......     : PRQ implemented: 1
[    3.224502] .......     : IO APIC version: 21
[    3.224503] .... register #02: 02000000
[    3.224504] .......     : arbitration: 02
[    3.224505] .... register #03: 02178021
[    3.224506] .......     : Boot DT    : 1
[    3.224507] .... IRQ redirection table:
[    3.224508] IOAPIC 0:
[    3.224515]  pin00, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.224520]  pin01, enabled , edge , high, V(23), IRR(0), S(0), logical , D(01), M(1)
[    3.224526]  pin02, enabled , edge , high, V(30), IRR(0), S(0), logical , D(01), M(1)
[    3.224531]  pin03, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.224537]  pin04, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.224542]  pin05, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.224547]  pin06, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.224553]  pin07, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.224558]  pin08, enabled , edge , high, V(24), IRR(0), S(0), logical , D(01), M(1)
[    3.224563]  pin09, enabled , level, low , V(21), IRR(0), S(0), logical , D(01), M(1)
[    3.224569]  pin0a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.224574]  pin0b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.224580]  pin0c, enabled , edge , high, V(22), IRR(0), S(0), logical , D(01), M(1)
[    3.224585]  pin0d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.224590]  pin0e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.224596]  pin0f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.224601]  pin10, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.224606]  pin11, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.224612]  pin12, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.224617]  pin13, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.224623]  pin14, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.224628]  pin15, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.224633]  pin16, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.224638]  pin17, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[    3.224639] IRQ to pin mappings:
[    3.224641] IRQ0 -> 0:2
[    3.224644] IRQ1 -> 0:1
[    3.224647] IRQ3 -> 0:3
[    3.224649] IRQ4 -> 0:4
[    3.224652] IRQ5 -> 0:5
[    3.224655] IRQ6 -> 0:6
[    3.224657] IRQ7 -> 0:7
[    3.224659] IRQ8 -> 0:8
[    3.224661] IRQ9 -> 0:9
[    3.224664] IRQ10 -> 0:10
[    3.224666] IRQ11 -> 0:11
[    3.224669] IRQ12 -> 0:12
[    3.224671] IRQ13 -> 0:13
[    3.224674] IRQ14 -> 0:14
[    3.224676] IRQ15 -> 0:15
[    3.224679] .................................... done.
[    3.224680] Using IPI No-Shortcut mode
[    3.224962] registered taskstats version 1
[    3.224963] Loading compiled-in X.509 certificates
[    3.224986] zswap: loaded using pool lzo/zbud
[    3.225136] ima: No TPM chip found, activating TPM-bypass! (rc=-19)
[    3.225587] rtc_cmos 00:00: setting system clock to 2017-12-28 15:54:43 UTC (1514476483)
[    3.226331] Freeing unused kernel memory: 604K
[    3.226440] Write protecting the kernel text: 5868k
[    3.226544] Write protecting the kernel read-only data: 1860k
[    3.226545] NX-protecting the kernel data: 4372k
[    3.226699] ------------[ cut here ]------------
[    3.226706] x86/mm: Found insecure W+X mapping at address c16f461c/0xc00a0000
[    3.226723] WARNING: CPU: 0 PID: 1 at arch/x86/mm/dump_pagetables.c:257 note_page+0x5ec/0x790
[    3.226724] Modules linked in:
[    3.226729] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.15.0-rc5-dou-thms-p2+ #1
[    3.226784] Hardware name: ASUSTeK Computer Inc. F5RL                /F5RL      , BIOS 210     06/12/2008
[    3.226833] EIP: note_page+0x5ec/0x790
[    3.226834] EFLAGS: 00210282 CPU: 0
[    3.226836] EAX: 00000041 EBX: f70c7f54 ECX: 00000001 EDX: d68de544
[    3.226837] ESI: 80000000 EDI: 00000000 EBP: f70c7f20 ESP: f70c7ef4
[    3.226839]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[    3.226841] CR0: 80050033 CR2: ff9ff000 CR3: 168ce000 CR4: 000006f0
[    3.226842] Call Trace:
[    3.226891]  ptdump_walk_pgd_level_core+0x15c/0x240
[    3.226938]  ptdump_walk_pgd_level_checkwx+0x11/0x20
[    3.226983]  mark_rodata_ro+0xd5/0xf1
[    3.227030]  ? rest_init+0x90/0x90
[    3.227074]  kernel_init+0x24/0xe0
[    3.227119]  ret_from_fork+0x19/0x24
[    3.227163] Code: fa ff ff 83 c2 0c c7 43 18 00 00 00 00 89 53 14 e9 1a fd ff ff 8b 43 0c c6 05 c4 76 80 d6 01 50 50 68 50 ee 6c d6 e8 84 5c 00 00 <0f> ff 83 c4 0c e9 6f fa ff ff ff 72 10 68 1c ed 6c d6 e8 57 f5
[    3.227260] ---[ end trace 90f1997524bd5f15 ]---
[    3.227367] x86/mm: Checked W+X mappings: FAILED, 96 W+X pages found.
[    3.258107] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    3.318212] Atheros(R) L2 Ethernet Driver - version 2.2.3
[    3.318219] Copyright (c) 2007 Atheros Corporation.
[    3.318631] IOAPIC[0]: Set routing entry (2-18 -> 0xef -> IRQ 18 Mode:1 Active:1 Dest:1)
[    3.320519] SCSI subsystem initialized
[    3.324534] ACPI: bus type USB registered
[    3.324610] usbcore: registered new interface driver usbfs
[    3.324628] usbcore: registered new interface driver hub
[    3.324681] usbcore: registered new device driver usb
[    3.326226] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    3.326953] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    3.327247] ehci-pci: EHCI PCI platform driver
[    3.327470] IOAPIC[0]: Set routing entry (2-19 -> 0xef -> IRQ 19 Mode:1 Active:1 Dest:1)
[    3.327532] ehci-pci 0000:00:13.5: EHCI Host Controller
[    3.327544] ehci-pci 0000:00:13.5: new USB bus registered, assigned bus number 1
[    3.327554] ehci-pci 0000:00:13.5: applying AMD SB600/SB700 USB freeze workaround
[    3.327583] ehci-pci 0000:00:13.5: debug port 1
[    3.327681] ehci-pci 0000:00:13.5: irq 19, io mem 0xfebff800
[    3.328429] libata version 3.00 loaded.
[    3.340123] ehci-pci 0000:00:13.5: USB 2.0 started, EHCI 1.00
[    3.340259] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    3.340262] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.340264] usb usb1: Product: EHCI Host Controller
[    3.340266] usb usb1: Manufacturer: Linux 4.15.0-rc5-dou-thms-p2+ ehci_hcd
[    3.340268] usb usb1: SerialNumber: 0000:00:13.5
[    3.340492] hub 1-0:1.0: USB hub found
[    3.340505] hub 1-0:1.0: 10 ports detected
[    3.340933] ahci 0000:00:12.0: version 3.0
[    3.341142] IOAPIC[0]: Set routing entry (2-22 -> 0xef -> IRQ 22 Mode:1 Active:1 Dest:1)
[    3.341208] ahci 0000:00:12.0: controller can't do 64bit DMA, forcing 32bit
[    3.341377] ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
[    3.341380] ahci 0000:00:12.0: flags: ncq sntf ilck led clo pmp pio slum part ccc 
[    3.341381] ohci-pci: OHCI PCI platform driver
[    3.343207] scsi host0: ahci
[    3.352079] scsi host1: ahci
[    3.352339] scsi host2: ahci
[    3.360050] scsi host3: ahci
[    3.360165] ata1: SATA max UDMA/133 abar m1024@0xfebffc00 port 0xfebffd00 irq 22
[    3.360169] ata2: SATA max UDMA/133 abar m1024@0xfebffc00 port 0xfebffd80 irq 22
[    3.360172] ata3: SATA max UDMA/133 abar m1024@0xfebffc00 port 0xfebffe00 irq 22
[    3.360175] ata4: SATA max UDMA/133 abar m1024@0xfebffc00 port 0xfebffe80 irq 22
[    3.360289] ACPI Warning: SystemIO range 0x0000000000000B00-0x0000000000000B08 conflicts with OpRegion 0x0000000000000B00-0x0000000000000B0F (\SMB0) (20170831/utaddress-247)
[    3.360300] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[    3.360563] IOAPIC[0]: Set routing entry (2-16 -> 0xef -> IRQ 16 Mode:1 Active:1 Dest:1)
[    3.366253] scsi host4: pata_atiixp
[    3.379884] scsi host5: pata_atiixp
[    3.380055] ata5: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xff00 irq 14
[    3.380057] ata6: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xff08 irq 15
[    3.380415] ohci-pci 0000:00:13.0: OHCI PCI host controller
[    3.380435] ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 2
[    3.380487] ohci-pci 0000:00:13.0: irq 16, io mem 0xfebfe000
[    3.417837] (NULL device *): hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[    3.418800] thermal LNXTHERM:00: registered as thermal_zone0
[    3.418803] ACPI: Thermal Zone [THRM] (77 C)
[    3.444153] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    3.444156] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.444158] usb usb2: Product: OHCI PCI host controller
[    3.444160] usb usb2: Manufacturer: Linux 4.15.0-rc5-dou-thms-p2+ ohci_hcd
[    3.444162] usb usb2: SerialNumber: 0000:00:13.0
[    3.444393] hub 2-0:1.0: USB hub found
[    3.444408] hub 2-0:1.0: 2 ports detected
[    3.444731] IOAPIC[0]: Set routing entry (2-17 -> 0xef -> IRQ 17 Mode:1 Active:1 Dest:1)
[    3.444768] ohci-pci 0000:00:13.1: OHCI PCI host controller
[    3.444777] ohci-pci 0000:00:13.1: new USB bus registered, assigned bus number 3
[    3.444820] ohci-pci 0000:00:13.1: irq 17, io mem 0xfebfd000
[    3.508158] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[    3.508161] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.508163] usb usb3: Product: OHCI PCI host controller
[    3.508165] usb usb3: Manufacturer: Linux 4.15.0-rc5-dou-thms-p2+ ohci_hcd
[    3.508167] usb usb3: SerialNumber: 0000:00:13.1
[    3.508394] hub 3-0:1.0: USB hub found
[    3.508407] hub 3-0:1.0: 2 ports detected
[    3.508723] ohci-pci 0000:00:13.2: OHCI PCI host controller
[    3.508732] ohci-pci 0000:00:13.2: new USB bus registered, assigned bus number 4
[    3.508781] ohci-pci 0000:00:13.2: irq 18, io mem 0xfebfc000
[    3.560675] ata5.00: ATAPI: HL-DT-ST DVDRAM GSA-T40N, JR03, max UDMA/33
[    3.573319] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    3.573322] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.573325] usb usb4: Product: OHCI PCI host controller
[    3.573327] usb usb4: Manufacturer: Linux 4.15.0-rc5-dou-thms-p2+ ohci_hcd
[    3.573328] usb usb4: SerialNumber: 0000:00:13.2
[    3.573546] hub 4-0:1.0: USB hub found
[    3.573560] hub 4-0:1.0: 2 ports detected
[    3.573824] ohci-pci 0000:00:13.3: OHCI PCI host controller
[    3.573833] ohci-pci 0000:00:13.3: new USB bus registered, assigned bus number 5
[    3.573860] ohci-pci 0000:00:13.3: irq 17, io mem 0xfebfb000
[    3.588514] ata5.00: configured for UDMA/33
[    3.636125] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[    3.636128] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.636130] usb usb5: Product: OHCI PCI host controller
[    3.636132] usb usb5: Manufacturer: Linux 4.15.0-rc5-dou-thms-p2+ ohci_hcd
[    3.636134] usb usb5: SerialNumber: 0000:00:13.3
[    3.636343] hub 5-0:1.0: USB hub found
[    3.636357] hub 5-0:1.0: 2 ports detected
[    3.636629] ohci-pci 0000:00:13.4: OHCI PCI host controller
[    3.636639] ohci-pci 0000:00:13.4: new USB bus registered, assigned bus number 6
[    3.636666] ohci-pci 0000:00:13.4: irq 18, io mem 0xfebfa000
[    3.676057] usb 1-4: new high-speed USB device number 2 using ehci-pci
[    3.679169] ata3: SATA link down (SStatus 0 SControl 300)
[    3.679205] ata4: SATA link down (SStatus 0 SControl 300)
[    3.679243] ata2: SATA link down (SStatus 0 SControl 300)
[    3.700133] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
[    3.700136] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.700138] usb usb6: Product: OHCI PCI host controller
[    3.700140] usb usb6: Manufacturer: Linux 4.15.0-rc5-dou-thms-p2+ ohci_hcd
[    3.700142] usb usb6: SerialNumber: 0000:00:13.4
[    3.700353] hub 6-0:1.0: USB hub found
[    3.700366] hub 6-0:1.0: 2 ports detected
[    3.836093] ata1: softreset failed (device not ready)
[    3.836147] ata1: applying PMP SRST workaround and retrying
[    3.852671] usb 1-4: New USB device found, idVendor=0bda, idProduct=0116
[    3.852674] usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.852676] usb 1-4: Product: USB2.0-CRW
[    3.852678] usb 1-4: Manufacturer: Generic
[    3.852680] usb 1-4: SerialNumber: 20021111153705700
[    3.858380] usb-storage 1-4:1.0: USB Mass Storage device detected
[    3.858824] scsi host6: usb-storage 1-4:1.0
[    3.858960] usbcore: registered new interface driver usb-storage
[    3.859620] usbcore: registered new interface driver uas
[    3.984057] usb 1-7: new high-speed USB device number 3 using ehci-pci
[    3.996101] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    3.996578] ata1.00: ATA-8: ST9250827AS, 3.AAA, max UDMA/133
[    3.996581] ata1.00: 488397168 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    3.996585] ata1.00: SB600 AHCI: limiting to 255 sectors per cmd
[    3.997056] ata1.00: SB600 AHCI: limiting to 255 sectors per cmd
[    3.997058] ata1.00: configured for UDMA/133
[    3.997378] scsi 0:0:0:0: Direct-Access     ATA      ST9250827AS      A    PQ: 0 ANSI: 5
[    4.001647] scsi 4:0:0:0: CD-ROM            HL-DT-ST DVDRAM GSA-T40N  JR03 PQ: 0 ANSI: 5
[    4.019009] sd 0:0:0:0: [sda] 488397168 512-byte logical blocks: (250 GB/233 GiB)
[    4.019035] sd 0:0:0:0: [sda] Write Protect is off
[    4.019038] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    4.019072] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    4.039588] sr 4:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
[    4.039590] cdrom: Uniform CD-ROM driver Revision: 3.20
[    4.040108] sr 4:0:0:0: Attached scsi CD-ROM sr0
[    4.097489]  sda: sda1 sda2 < sda5 >
[    4.098242] sd 0:0:0:0: [sda] Attached SCSI disk
[    4.162719] usb 1-7: New USB device found, idVendor=174f, idProduct=5a31
[    4.162724] usb 1-7: New USB device strings: Mfr=2, Product=1, SerialNumber=3
[    4.162727] usb 1-7: Product: USB 2.0 Camera
[    4.162729] usb 1-7: Manufacturer: Sonix Technology Co., Ltd.
[    4.162731] usb 1-7: SerialNumber: SN0001
[    4.222215] psmouse serio4: synaptics: Touchpad model: 1, fw: 6.1, id: 0xa3a0b3, caps: 0xa04713/0x10008/0x0/0x0, board id: 0, fw id: 30712
[    4.263765] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio4/input/input8
[    4.757443] PM: Starting manual resume from disk
[    4.757679] PM: Image not found (code -22)
[    4.871750] scsi 6:0:0:0: Direct-Access     Generic- xD/SDMMC/MS/Pro  1.00 PQ: 0 ANSI: 0 CCS
[    5.386287] sd 6:0:0:0: [sdb] 62333952 512-byte logical blocks: (31.9 GB/29.7 GiB)
[    5.390272] sd 6:0:0:0: [sdb] Write Protect is off
[    5.390275] sd 6:0:0:0: [sdb] Mode Sense: 03 00 00 00
[    5.394270] sd 6:0:0:0: [sdb] No Caching mode page found
[    5.394320] sd 6:0:0:0: [sdb] Assuming drive cache: write through
[    5.416916]  sdb: sdb1
[    5.432407] sd 6:0:0:0: [sdb] Attached SCSI removable disk
[    5.702605] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[    6.320080] random: crng init done
[    7.512048] ip_tables: (C) 2000-2006 Netfilter Core Team
[    7.712917] systemd[1]: systemd 232 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
[    7.732158] systemd[1]: Detected architecture x86.
[    7.746203] systemd[1]: Set hostname to <D-69-91-141-110>.
[    9.114242] systemd[1]: Configuration file /etc/systemd/system/kdump.service is marked executable. Please remove executable permission bits. Proceeding anyway.
[    9.249731] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    9.249942] systemd[1]: Listening on Journal Audit Socket.
[    9.250045] systemd[1]: Listening on Journal Socket.
[    9.250124] systemd[1]: Listening on udev Kernel Socket.
[    9.250162] systemd[1]: Reached target Remote File Systems.
[    9.250238] systemd[1]: Listening on Journal Socket (/dev/log).
[   10.233568] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
[   10.460990] systemd-journald[186]: Received request to flush runtime journal from PID 1
[   10.814415] systemd-journald[186]: File /var/log/journal/232ecae4e62643e0ac09bafad7167a6f/system.journal corrupted or uncleanly shut down, renaming and replacing.
[   15.120812] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   15.354243] ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[   15.358192] acpi device:02: registered as cooling_device2
[   15.358286] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A03:00/device:00/LNXVIDEO:00/input/input9
[   15.360809] ACPI: Battery Slot [BAT0] (battery absent)
[   15.366165] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input10
[   15.366184] ACPI: Lid Switch [LID]
[   15.366338] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input11
[   15.366366] ACPI: Power Button [PWRB]
[   15.366448] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input12
[   15.366466] ACPI: Sleep Button [SLPB]
[   15.366555] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input13
[   15.366572] ACPI: Power Button [PWRF]
[   15.805367] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[   16.075198] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   16.120563] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[   16.120566] cfg80211: failed to load regulatory.db
[   16.549660] ath5k 0000:02:00.0: can't disable ASPM; OS doesn't have ASPM control
[   16.549871] ath5k 0000:02:00.0: registered as 'phy0'
[   16.559842] ACPI: AC Adapter [AC0] (on-line)
[   16.592437] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver v0.05
[   16.592547] sp5100_tco: PCI Vendor ID: 0x1002, Device ID: 0x4385, Revision ID: 0x13
[   16.592577] sp5100_tco: failed to find MMIO address, giving up.
[   16.636328] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   16.636400] sr 4:0:0:0: Attached scsi generic sg1 type 5
[   16.636463] sd 6:0:0:0: Attached scsi generic sg2 type 0
[   16.710725] [drm] radeon kernel modesetting enabled.
[   16.711378] [drm] initializing kernel modesetting (RS400 0x1002:0x5A62 0x1043:0x1402 0x00).
[   16.711449] resource sanity check: requesting [mem 0x000c0000-0x000dffff], which spans more than PCI Bus 0000:00 [mem 0x000d0000-0x000dffff window]
[   16.711460] caller pci_map_rom+0x58/0xf0 mapping multiple BARs
[   16.711629] [drm] Generation 2 PCI interface, using max accessible memory
[   16.711635] radeon 0000:01:05.0: VRAM: 128M 0x00000000B8000000 - 0x00000000BFFFFFFF (128M used)
[   16.711638] radeon 0000:01:05.0: GTT: 512M 0x0000000080000000 - 0x000000009FFFFFFF
[   16.711651] [drm] Detected VRAM RAM=128M, BAR=256M
[   16.711652] [drm] RAM width 128bits DDR
[   16.711778] [TTM] Zone  kernel: Available graphics memory: 303808 kiB
[   16.711779] [TTM] Zone highmem: Available graphics memory: 1357316 kiB
[   16.711781] [TTM] Initializing pool allocator
[   16.711789] [TTM] Initializing DMA pool allocator
[   16.711835] [drm] radeon: 128M of VRAM memory ready
[   16.711837] [drm] radeon: 512M of GTT memory ready.
[   16.711856] [drm] GART: num cpu pages 131072, num gpu pages 131072
[   16.734181] [drm] radeon: 3 quad pipes, 1 z pipes initialized.
[   16.734199] [drm] PCIE GART of 512M enabled (table at 0x0000000036580000).
[   16.734310] radeon 0000:01:05.0: WB enabled
[   16.734317] radeon 0000:01:05.0: fence driver on ring 0 use gpu addr 0x0000000080000000 and cpu addr 0x59b9d544
[   16.734323] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   16.734324] [drm] Driver supports precise vblank timestamp query.
[   16.734327] radeon 0000:01:05.0: radeon: MSI limited to 32-bit
[   16.734354] [drm] radeon: irq initialized.
[   16.734368] [drm] Loading R300 Microcode
[   16.874141] [drm] radeon: ring at 0x0000000080001000
[   16.874170] [drm] ring test succeeded in 0 usecs
[   16.874330] [drm] ib test succeeded in 0 usecs
[   16.874726] [drm] Panel ID String: AUO                     
[   16.874728] [drm] Panel Size 1280x800
[   16.874816] [drm] Radeon Display Connectors
[   16.874817] [drm] Connector 0:
[   16.874818] [drm]   VGA-1
[   16.874821] [drm]   DDC: 0x68 0x68 0x68 0x68 0x68 0x68 0x68 0x68
[   16.874822] [drm]   Encoders:
[   16.874823] [drm]     CRT1: INTERNAL_DAC2
[   16.874824] [drm] Connector 1:
[   16.874825] [drm]   LVDS-1
[   16.874827] [drm]   DDC: 0x198 0x198 0x19c 0x19c 0x1a0 0x1a0 0x1a4 0x1a4
[   16.874828] [drm]   Encoders:
[   16.874829] [drm]     LCD1: INTERNAL_LVDS
[   16.944628] [drm] fb mappable at 0xC0040000
[   16.944630] [drm] vram apper at 0xC0000000
[   16.944631] [drm] size 4096000
[   16.944632] [drm] fb depth is 24
[   16.944633] [drm]    pitch is 5120
[   16.944776] fbcon: radeondrmfb (fb0) is primary device
[   16.991113] Console: switching to colour frame buffer device 160x50
[   16.999330] radeon 0000:01:05.0: fb0: radeondrmfb frame buffer device
[   17.010704] [drm] Initialized radeon 2.50.0 20080528 for 0000:01:05.0 on minor 0
[   17.138694] ath: EEPROM regdomain: 0x60
[   17.138698] ath: EEPROM indicates we should expect a direct regpair map
[   17.138702] ath: Country alpha2 being used: 00
[   17.138703] ath: Regpair used: 0x60
[   17.314154] asus_laptop: Asus Laptop Support version 0.42
[   17.314310] asus_laptop:   F5RL model detected
[   17.314625] input: Asus Laptop extra buttons as /devices/platform/asus_laptop/input/input14
[   17.375159] input: PC Speaker as /devices/platform/pcspkr/input/input15
[   17.457671] intel_powerclamp: No package C-state available
[   17.488471] intel_powerclamp: No package C-state available
[   17.502095] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
[   17.502596] ath5k: phy0: Atheros AR2425 chip found (MAC: 0xe2, PHY: 0x70)
[   18.862371] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC660-VD: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[   18.862376] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   18.862379] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[   18.862381] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[   18.862382] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[   18.862386] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x19
[   18.862388] snd_hda_codec_realtek hdaudioC0D0:      Mic=0x18
[   19.125186] media: Linux media interface: v0.10
[   19.137851] Linux video capture interface: v2.00
[   19.221028] uvcvideo: Found UVC 1.00 device USB 2.0 Camera (174f:5a31)
[   19.240622] uvcvideo 1-7:1.0: Entity type for entity Extension 4 was not initialized!
[   19.240627] uvcvideo 1-7:1.0: Entity type for entity Processing 3 was not initialized!
[   19.240629] uvcvideo 1-7:1.0: Entity type for entity Camera 1 was not initialized!
[   19.240779] input: USB 2.0 Camera: USB 2.0 Camera as /devices/pci0000:00/0000:00:13.5/usb1/1-7/1-7:1.0/input/input19
[   19.240911] usbcore: registered new interface driver uvcvideo
[   19.240913] USB Video Class driver (1.1.1)
[   19.409794] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:14.2/sound/card0/input16
[   19.410438] input: HDA ATI SB Mic as /devices/pci0000:00/0000:00:14.2/sound/card0/input17
[   19.410545] input: HDA ATI SB Headphone as /devices/pci0000:00/0000:00:14.2/sound/card0/input18
[   20.218900] Adding 3929084k swap on /dev/sda5.  Priority:-2 extents:1 across:3929084k FS
[   20.722335] FAT-fs (sdb1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
[   30.756833] NET: Registered protocol family 4
[   30.800318] NET: Registered protocol family 3
[   30.847827] NET: Registered protocol family 5
[   30.969398] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
[   36.017942] spurious APIC interrupt through vector ff on CPU#0, should never happen.
[   36.018215] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   38.345348] NMI watchdog: Watchdog detected hard LOCKUP on cpu 0
[   38.345348] Modules linked in: appletalk ax25 ipx p8023 p8022 psnap llc nls_ascii nls_cp437 vfat fat snd_hda_codec_si3054 uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_core videodev media snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel snd_hda_codec snd_hda_core arc4 snd_hwdep snd_pcsp coretemp asus_laptop snd_pcm snd_timer evdev sparse_keymap joydev serio_raw input_polldev snd soundcore radeon sg sp5100_tco ac ath5k ath mac80211 ttm drm_kms_helper drm cfg80211 i2c_algo_bit fb_sys_fops rfkill syscopyarea sysfillrect sysimgblt button battery video shpchp acpi_cpufreq ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 fscrypto sr_mod cdrom sd_mod ata_generic uas usb_storage psmouse ohci_pci pata_atiixp i2c_piix4 ahci libahci ehci_pci ohci_hcd libata ehci_hcd usbcore
[   38.345348]  scsi_mod atl2 thermal
[   38.345348] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W        4.15.0-rc5-dou-thms-p2+ #1
[   38.345348] Hardware name: ASUSTeK Computer Inc. F5RL                /F5RL      , BIOS 210     06/12/2008
[   38.345348] EIP: tick_check_broadcast_expired+0x16/0x20
[   38.345348] EFLAGS: 00000247 CPU: 0
[   38.345348] EAX: 00000001 EBX: d6792180 ECX: d68bbf28 EDX: 0002ac3a
[   38.345348] ESI: d6792180 EDI: 00000000 EBP: d678df24 ESP: d678df24
[   38.345348]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[   38.345348] CR0: 80050033 CR2: b7f05500 CR3: 36f2ec80 CR4: 000006f0
[   38.345348] Call Trace:
[   38.345348]  cpu_idle_poll+0x46/0x130
[   38.345348]  do_idle+0x3d/0x1a0
[   38.345348]  cpu_startup_entry+0x65/0x70
[   38.345348]  rest_init+0x86/0x90
[   38.345348]  start_kernel+0x371/0x38a
[   38.345348]  i386_start_kernel+0x95/0x99
[   38.345348]  startup_32_smp+0x164/0x168
[   38.345348] Code: c3 8d 74 26 00 55 b8 60 26 90 d6 89 e5 5d c3 8d b6 00 00 00 00 55 64 a1 00 61 8b d6 89 e5 0f a3 05 58 26 90 d6 0f 92 c0 0f b6 c0 <5d> c3 90 8d b4 26 00 00 00 00 64 a1 00 61 8b d6 0f a3 05 60 26
[   38.345348] NMI watchdog: Watchdog detected hard LOCKUP on cpu 1
[   38.345348] Modules linked in: appletalk ax25 ipx p8023 p8022 psnap llc nls_ascii nls_cp437 vfat fat snd_hda_codec_si3054 uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_core videodev media snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel snd_hda_codec snd_hda_core arc4 snd_hwdep snd_pcsp coretemp asus_laptop snd_pcm snd_timer evdev sparse_keymap joydev serio_raw input_polldev snd soundcore radeon sg sp5100_tco ac ath5k ath mac80211 ttm drm_kms_helper drm cfg80211 i2c_algo_bit fb_sys_fops rfkill syscopyarea sysfillrect sysimgblt button battery video shpchp acpi_cpufreq ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 fscrypto sr_mod cdrom sd_mod ata_generic uas usb_storage psmouse ohci_pci pata_atiixp i2c_piix4 ahci libahci ehci_pci ohci_hcd libata ehci_hcd usbcore
[   38.345348]  scsi_mod atl2 thermal
[   38.345348] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W        4.15.0-rc5-dou-thms-p2+ #1
[   38.345348] Hardware name: ASUSTeK Computer Inc. F5RL                /F5RL      , BIOS 210     06/12/2008
[   38.345348] EIP: cpu_idle_poll+0x32/0x130
[   38.345348] EFLAGS: 00000202 CPU: 1
[   38.345348] EAX: 00000001 EBX: f70dea80 ECX: d68bbf28 EDX: 00021396
[   38.345348] ESI: f70dea80 EDI: 00000001 EBP: f70e5f30 ESP: f70e5f24
[   38.345348]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[   38.345348] CR0: 80050033 CR2: 08e487e0 CR3: 320041a0 CR4: 000006f0
[   38.345348] Call Trace:
[   38.345348]  do_idle+0x3d/0x1a0
[   38.345348]  cpu_startup_entry+0x65/0x70
[   38.345348]  start_secondary+0x16b/0x210
[   38.345348]  startup_32_smp+0x164/0x168
[   38.345348]  ? startup_32_smp+0x164/0x168
[   38.345348] Code: a5 09 b0 ff 64 8b 3d 00 61 8b d6 66 66 66 66 90 fb 64 8b 1d 3c 79 8b d6 8b 03 a8 08 74 13 eb 23 89 f6 8d bc 27 00 00 00 00 f3 90 <8b> 03 a8 08 75 12 a1 10 c5 81 d6 85 c0 75 ef e8 aa 73 b1 ff 85

--NMuMz9nt05w80d4+--
