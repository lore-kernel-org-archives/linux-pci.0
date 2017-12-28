Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 28 Dec 2017 09:21:17 -0500
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
Message-ID: <20171228142117.GA10658@chirva-slack.chirva-slack>
References: <20171218082011.GA24638@arch-chirva.localdomain>
 <20171218101131.GA5338@amd>
 <20171219083421.GB24638@arch-chirva.localdomain>
 <alpine.DEB.2.20.1712200124440.2282@nanos>
 <ec3a298b-27a3-f3fe-ea8d-a777669104ba@cn.fujitsu.com>
 <20171220131929.GC24638@arch-chirva.localdomain>
 <alpine.DEB.2.20.1712281145510.1688@nanos>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
In-Reply-To: <alpine.DEB.2.20.1712281145510.1688@nanos>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Thanks for all of this!

On Thu, Dec 28, 2017 at 12:00:47PM +0100, Thomas Gleixner wrote:
> On Wed, 20 Dec 2017, Alexandru Chirvasitu wrote:
> > On Wed, Dec 20, 2017 at 11:58:57AM +0800, Dou Liyang wrote:
> > > At 12/20/2017 08:31 AM, Thomas Gleixner wrote:
> > > > > I had never heard of 'bisect' before this casual mention (you might tell
> > > > > I am a bit out of my depth). I've since applied it to Linus' tree between
> > > > 
> > > > > bebc608 Linux 4.14 (good)
> > > > > 
> > > > > and
> > > > > 
> > > > > 4fbd8d1 Linux 4.15-rc1 (bad)
> > > > 
> > > > Is Linus current head 4.15-rc4 bad as well?
> > > > 
> > > [...]
> > 
> > Yes. Exactly the same symptoms on
> > 
> > 1291a0d5 Linux 4.15-rc4
> > 
> > compiled just now from Linus' tree. 
> 
> Ok, lets take a step back. The bisect/kexec attempts led us away from the
> initial problem which is the machine locking up after login, right?
>

Yes; sorry about that..

> Could you try the patch below on top of Linus tree (rc5+)?
> 
> Thanks,
> 
> 	tglx
> 
> 8<---------------
> --- a/arch/x86/kernel/apic/apic_flat_64.c
> +++ b/arch/x86/kernel/apic/apic_flat_64.c
> @@ -151,7 +151,7 @@ static struct apic apic_flat __ro_after_
>  	.apic_id_valid			= default_apic_id_valid,
>  	.apic_id_registered		= flat_apic_id_registered,
>  
> -	.irq_delivery_mode		= dest_LowestPrio,
> +	.irq_delivery_mode		= dest_Fixed,
>  	.irq_dest_mode			= 1, /* logical */
>  
>  	.disable_esr			= 0,
> --- a/arch/x86/kernel/apic/probe_32.c
> +++ b/arch/x86/kernel/apic/probe_32.c
> @@ -105,7 +105,7 @@ static struct apic apic_default __ro_aft
>  	.apic_id_valid			= default_apic_id_valid,
>  	.apic_id_registered		= default_apic_id_registered,
>  
> -	.irq_delivery_mode		= dest_LowestPrio,
> +	.irq_delivery_mode		= dest_Fixed,
>  	/* logical delivery broadcast to all CPUs: */
>  	.irq_dest_mode			= 1,
>  
> --- a/arch/x86/kernel/apic/x2apic_cluster.c
> +++ b/arch/x86/kernel/apic/x2apic_cluster.c
> @@ -184,7 +184,7 @@ static struct apic apic_x2apic_cluster _
>  	.apic_id_valid			= x2apic_apic_id_valid,
>  	.apic_id_registered		= x2apic_apic_id_registered,
>  
> -	.irq_delivery_mode		= dest_LowestPrio,
> +	.irq_delivery_mode		= dest_Fixed,
>  	.irq_dest_mode			= 1, /* logical */
>  
>  	.disable_esr			= 0,
> 

I tried both patches that you guys sent in the last couple of
messages. I applied them separately to the last 4.15-rc5 kernel I had
(the one for which I sent Dou the journalctl output). The diffs are
both to that version.

Results follow.


(1)

Dou's patch:

------------------------------------------------------------

    x86/vector: Replace the raw_spin_lock() with

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 7504491..e5bab02 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -726,6 +726,7 @@ static int apic_set_affinity(struct irq_data *irqd,
                             const struct cpumask *dest, bool force)
 {
        struct apic_chip_data *apicd = apic_chip_data(irqd);
+       unsigned long flags;
        int err;
 
        /*
@@ -740,13 +741,13 @@ static int apic_set_affinity(struct irq_data *irqd,
            (apicd->is_managed || apicd->can_reserve))
                return IRQ_SET_MASK_OK;
 
-       raw_spin_lock(&vector_lock);
+       raw_spin_lock_irqsave(&vector_lock, flags);
        cpumask_and(vector_searchmask, dest, cpu_online_mask);
        if (irqd_affinity_is_managed(irqd))
                err = assign_managed_vector(irqd, vector_searchmask);
        else
                err = assign_vector_locked(irqd, vector_searchmask);
-       raw_spin_unlock(&vector_lock);
+       raw_spin_unlock_irqrestore(&vector_lock, flags);
        return err ? err : IRQ_SET_MASK_OK;
 }

------------------------------------------------------------

With this, I still get the lockup messages after login, but not the
freezes!

The lockups register in the log, which I am attaching (see below for
attachment naming conventions).

The computer's still clearly impaired (ethernet won't connect again
for instance, and the CPU distress messages happen periodically
throughout the tty session), but at least it's logged now.

---

(2)

Thomas' patch:

------------------------------------------------------------

    apic patch from tglx

diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index aa85690..1f734d4 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -151,7 +151,7 @@ static struct apic apic_flat __ro_after_init = {
        .apic_id_valid                  = default_apic_id_valid,
        .apic_id_registered             = flat_apic_id_registered,
 
-       .irq_delivery_mode              = dest_LowestPrio,
+       .irq_delivery_mode              = dest_Fixed,
        .irq_dest_mode                  = 1, /* logical */
 
        .disable_esr                    = 0,
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index fa22017..765cded 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -105,7 +105,7 @@ static struct apic apic_default __ro_after_init = {
        .apic_id_valid                  = default_apic_id_valid,
        .apic_id_registered             = default_apic_id_registered,
 
-       .irq_delivery_mode              = dest_LowestPrio,
+       .irq_delivery_mode              = dest_Fixed,
        /* logical delivery broadcast to all CPUs: */
        .irq_dest_mode                  = 1,
 
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index 622f13c..39568bd 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -184,7 +184,7 @@ static struct apic apic_x2apic_cluster __ro_after_init = {
        .apic_id_valid                  = x2apic_apic_id_valid,
        .apic_id_registered             = x2apic_apic_id_registered,
 
-       .irq_delivery_mode              = dest_LowestPrio,
+       .irq_delivery_mode              = dest_Fixed,
        .irq_dest_mode                  = 1, /* logical */
 
        .disable_esr                    = 0,

------------------------------------------------------------

This gives me the same disabling lockups as before, i.e. I have to
reboot. Correspondingly, the log I'm attaching for this kernel won't
be of much use, because it's called with `journalctl --boot=-1` after
the fact.

Might still be of some use..

---

The log files I'm attaching comply with the following naming pattern:

'dou' means the log comes from the kernel patched with Dou's patch;

'thms' refers to Thomas' patch;

'jrnl' means it came from journalctl with various boot=? options; 

'dmesg' means it came from calling dmesg;

'noparams' means the kernel was called with no additional parameters;

'debug' means it was called with 'apic=debug'. 

---

P.S.

It was very considerate to send the attachment Dou, but that shouldn't
be necessary anymore; the issues I had with 'git apply' were
blank-space-related, and I've managed to resolve them.

So anything copy-pastable directly in the message body should do if I
try more patches.

Thank you!

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=log-jrnl-dou-noparam

-- Logs begin at Sat 2017-12-23 08:46:21 EST, end at Thu 2017-12-28 08:54:52 EST. --
Dec 28 08:51:33 D-69-91-141-110 kernel: Linux version 4.15.0-rc5-dou-p+ (root@axiomatic) (gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.5)) #1 SMP Thu Dec 28 08:40:40 EST 2017
Dec 28 08:51:33 D-69-91-141-110 kernel: x86/fpu: x87 FPU will use FXSAVE
Dec 28 08:51:33 D-69-91-141-110 kernel: e820: BIOS-provided physical RAM map:
Dec 28 08:51:33 D-69-91-141-110 kernel: BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
Dec 28 08:51:33 D-69-91-141-110 kernel: BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
Dec 28 08:51:33 D-69-91-141-110 kernel: BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
Dec 28 08:51:33 D-69-91-141-110 kernel: BIOS-e820: [mem 0x0000000000100000-0x00000000b7f9ffff] usable
Dec 28 08:51:33 D-69-91-141-110 kernel: BIOS-e820: [mem 0x00000000b7fa0000-0x00000000b7fadfff] ACPI data
Dec 28 08:51:33 D-69-91-141-110 kernel: BIOS-e820: [mem 0x00000000b7fae000-0x00000000b7feffff] ACPI NVS
Dec 28 08:51:33 D-69-91-141-110 kernel: BIOS-e820: [mem 0x00000000b7ff0000-0x00000000b7ffffff] reserved
Dec 28 08:51:33 D-69-91-141-110 kernel: BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
Dec 28 08:51:33 D-69-91-141-110 kernel: BIOS-e820: [mem 0x00000000ffb80000-0x00000000ffffffff] reserved
Dec 28 08:51:33 D-69-91-141-110 kernel: NX (Execute Disable) protection: active
Dec 28 08:51:33 D-69-91-141-110 kernel: random: fast init done
Dec 28 08:51:33 D-69-91-141-110 kernel: SMBIOS 2.4 present.
Dec 28 08:51:33 D-69-91-141-110 kernel: DMI: ASUSTeK Computer Inc. F5RL                /F5RL      , BIOS 210     06/12/2008
Dec 28 08:51:33 D-69-91-141-110 kernel: e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
Dec 28 08:51:33 D-69-91-141-110 kernel: e820: remove [mem 0x000a0000-0x000fffff] usable
Dec 28 08:51:33 D-69-91-141-110 kernel: e820: last_pfn = 0xb7fa0 max_arch_pfn = 0x1000000
Dec 28 08:51:33 D-69-91-141-110 kernel: MTRR default type: uncachable
Dec 28 08:51:33 D-69-91-141-110 kernel: MTRR fixed ranges enabled:
Dec 28 08:51:33 D-69-91-141-110 kernel:   00000-9FFFF write-back
Dec 28 08:51:33 D-69-91-141-110 kernel:   A0000-BFFFF uncachable
Dec 28 08:51:33 D-69-91-141-110 kernel:   C0000-CFFFF write-protect
Dec 28 08:51:33 D-69-91-141-110 kernel:   D0000-DFFFF uncachable
Dec 28 08:51:33 D-69-91-141-110 kernel:   E0000-EFFFF write-through
Dec 28 08:51:33 D-69-91-141-110 kernel:   F0000-FFFFF write-protect
Dec 28 08:51:33 D-69-91-141-110 kernel: MTRR variable ranges enabled:
Dec 28 08:51:33 D-69-91-141-110 kernel:   0 base 000000000 mask F80000000 write-back
Dec 28 08:51:33 D-69-91-141-110 kernel:   1 base 080000000 mask FE0000000 write-back
Dec 28 08:51:33 D-69-91-141-110 kernel:   2 base 0A0000000 mask FF0000000 write-back
Dec 28 08:51:33 D-69-91-141-110 kernel:   3 base 0B0000000 mask FF8000000 write-back
Dec 28 08:51:33 D-69-91-141-110 kernel:   4 base 0B8000000 mask FFC000000 write-back
Dec 28 08:51:33 D-69-91-141-110 kernel:   5 base 0BC000000 mask FFF000000 write-back
Dec 28 08:51:33 D-69-91-141-110 kernel:   6 base 0C0000000 mask FF0000000 write-combining
Dec 28 08:51:33 D-69-91-141-110 kernel:   7 disabled
Dec 28 08:51:33 D-69-91-141-110 kernel: x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
Dec 28 08:51:33 D-69-91-141-110 kernel: found SMP MP-table at [mem 0x000ff780-0x000ff78f] mapped at [(ptrval)]
Dec 28 08:51:33 D-69-91-141-110 kernel: initial memory mapped: [mem 0x00000000-0x12dfffff]
Dec 28 08:51:33 D-69-91-141-110 kernel: Base memory trampoline at [(ptrval)] 9b000 size 16384
Dec 28 08:51:33 D-69-91-141-110 kernel: BRK [0x129ce000, 0x129cefff] PGTABLE
Dec 28 08:51:33 D-69-91-141-110 kernel: BRK [0x129cf000, 0x129d0fff] PGTABLE
Dec 28 08:51:33 D-69-91-141-110 kernel: BRK [0x129d1000, 0x129d1fff] PGTABLE
Dec 28 08:51:33 D-69-91-141-110 kernel: BRK [0x129d2000, 0x129d2fff] PGTABLE
Dec 28 08:51:33 D-69-91-141-110 kernel: RAMDISK: [mem 0x35d37000-0x36e92fff]
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: Early table checksum verification disabled
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: RSDP 0x00000000000F8070 000014 (v00 ACPIAM)
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: RSDT 0x00000000B7FA0000 00003C (v01 A_M_I_ OEMRSDT  06000812 MSFT 00000097)
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: FACP 0x00000000B7FA0200 000084 (v02 A_M_I_ OEMFACP  06000812 MSFT 00000097)
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: DSDT 0x00000000B7FA0630 0075FA (v01 A0669  A0669000 00000000 INTL 20060113)
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: FACS 0x00000000B7FAE000 000040
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: APIC 0x00000000B7FA0390 00005C (v01 A_M_I_ OEMAPIC  06000812 MSFT 00000097)
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: MCFG 0x00000000B7FA03F0 00003C (v01 A_M_I_ OEMMCFG  06000812 MSFT 00000097)
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: SLIC 0x00000000B7FA0430 000176 (v01 A_M_I_ OEMSLIC  06000812 MSFT 00000097)
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: BOOT 0x00000000B7FA0600 000028 (v01 A_M_I_ OEMBOOT  06000812 MSFT 00000097)
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: OEMB 0x00000000B7FAE040 00005B (v01 A_M_I_ AMI_OEM  06000812 MSFT 00000097)
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: Local APIC address 0xfee00000
Dec 28 08:51:33 D-69-91-141-110 kernel: 2057MB HIGHMEM available.
Dec 28 08:51:33 D-69-91-141-110 kernel: 885MB LOWMEM available.
Dec 28 08:51:33 D-69-91-141-110 kernel:   mapped low ram: 0 - 375fe000
Dec 28 08:51:33 D-69-91-141-110 kernel:   low ram: 0 - 375fe000
Dec 28 08:51:33 D-69-91-141-110 kernel: Reserving 256MB of memory at 32MB for crashkernel (System RAM: 2943MB)
Dec 28 08:51:33 D-69-91-141-110 kernel: tsc: Fast TSC calibration using PIT
Dec 28 08:51:33 D-69-91-141-110 kernel: BRK [0x129d3000, 0x129d3fff] PGTABLE
Dec 28 08:51:33 D-69-91-141-110 kernel: Zone ranges:
Dec 28 08:51:33 D-69-91-141-110 kernel:   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
Dec 28 08:51:33 D-69-91-141-110 kernel:   Normal   [mem 0x0000000001000000-0x00000000375fdfff]
Dec 28 08:51:33 D-69-91-141-110 kernel:   HighMem  [mem 0x00000000375fe000-0x00000000b7f9ffff]
Dec 28 08:51:33 D-69-91-141-110 kernel: Movable zone start for each node
Dec 28 08:51:33 D-69-91-141-110 kernel: Early memory node ranges
Dec 28 08:51:33 D-69-91-141-110 kernel:   node   0: [mem 0x0000000000001000-0x000000000009efff]
Dec 28 08:51:33 D-69-91-141-110 kernel:   node   0: [mem 0x0000000000100000-0x00000000b7f9ffff]
Dec 28 08:51:33 D-69-91-141-110 kernel: Initmem setup node 0 [mem 0x0000000000001000-0x00000000b7f9ffff]
Dec 28 08:51:33 D-69-91-141-110 kernel: On node 0 totalpages: 753470
Dec 28 08:51:33 D-69-91-141-110 kernel:   DMA zone: 36 pages used for memmap
Dec 28 08:51:33 D-69-91-141-110 kernel:   DMA zone: 0 pages reserved
Dec 28 08:51:33 D-69-91-141-110 kernel:   DMA zone: 3998 pages, LIFO batch:0
Dec 28 08:51:33 D-69-91-141-110 kernel:   Normal zone: 1958 pages used for memmap
Dec 28 08:51:33 D-69-91-141-110 kernel:   Normal zone: 222718 pages, LIFO batch:31
Dec 28 08:51:33 D-69-91-141-110 kernel:   HighMem zone: 526754 pages, LIFO batch:31
Dec 28 08:51:33 D-69-91-141-110 kernel: Reserved but unavailable: 98 pages
Dec 28 08:51:33 D-69-91-141-110 kernel: Using APIC driver default
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: PM-Timer IO Port: 0x808
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: Local APIC address 0xfee00000
Dec 28 08:51:33 D-69-91-141-110 kernel: IOAPIC[0]: apic_id 2, version 33, address 0xfec00000, GSI 0-23
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: IRQ0 used by override.
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: IRQ9 used by override.
Dec 28 08:51:33 D-69-91-141-110 kernel: Using ACPI (MADT) for SMP configuration information
Dec 28 08:51:33 D-69-91-141-110 kernel: smpboot: Allowing 2 CPUs, 0 hotplug CPUs
Dec 28 08:51:33 D-69-91-141-110 kernel: PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
Dec 28 08:51:33 D-69-91-141-110 kernel: PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
Dec 28 08:51:33 D-69-91-141-110 kernel: PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
Dec 28 08:51:33 D-69-91-141-110 kernel: PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
Dec 28 08:51:33 D-69-91-141-110 kernel: e820: [mem 0xb8000000-0xfedfffff] available for PCI devices
Dec 28 08:51:33 D-69-91-141-110 kernel: clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
Dec 28 08:51:33 D-69-91-141-110 kernel: setup_percpu: NR_CPUS:32 nr_cpumask_bits:32 nr_cpu_ids:2 nr_node_ids:1
Dec 28 08:51:33 D-69-91-141-110 kernel: percpu: Embedded 24 pages/cpu @(ptrval) s65612 r0 d32692 u98304
Dec 28 08:51:33 D-69-91-141-110 kernel: pcpu-alloc: s65612 r0 d32692 u98304 alloc=24*4096
Dec 28 08:51:33 D-69-91-141-110 kernel: pcpu-alloc: [0] 0 [0] 1 
Dec 28 08:51:33 D-69-91-141-110 kernel: Built 1 zonelists, mobility grouping on.  Total pages: 751476
Dec 28 08:51:33 D-69-91-141-110 kernel: Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.15.0-rc5-dou-p+ root=UUID=5a437cd2-c27b-4829-a7ba-533eb741b148 ro 3 crashkernel=256M quiet
Dec 28 08:51:33 D-69-91-141-110 kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Dec 28 08:51:33 D-69-91-141-110 kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Dec 28 08:51:33 D-69-91-141-110 kernel: microcode: microcode updated early to revision 0xa4, date = 2010-10-02
Dec 28 08:51:33 D-69-91-141-110 kernel: Initializing CPU#0
Dec 28 08:51:33 D-69-91-141-110 kernel: Initializing HighMem for node 0 (000375fe:000b7fa0)
Dec 28 08:51:33 D-69-91-141-110 kernel: Initializing Movable for node 0 (00000000:00000000)
Dec 28 08:51:33 D-69-91-141-110 kernel: Memory: 2696356K/3013880K available (5865K kernel code, 593K rwdata, 1836K rodata, 604K init, 428K bss, 317524K reserved, 0K cma-reserved, 2107016K highmem)
Dec 28 08:51:33 D-69-91-141-110 kernel: virtual kernel memory layout:
                                            fixmap  : 0xffd36000 - 0xfffff000   (2852 kB)
                                          cpu_entry : 0xff800000 - 0xff8c1000   ( 772 kB)
                                            pkmap   : 0xff600000 - 0xff800000   (2048 kB)
                                            vmalloc : 0xf7dfe000 - 0xff5fe000   ( 120 MB)
                                            lowmem  : 0xc0000000 - 0xf75fe000   ( 885 MB)
                                              .init : 0xd282e000 - 0xd28c5000   ( 604 kB)
                                              .data : 0xd25ba464 - 0xd2820780   (2456 kB)
                                              .text : 0xd2000000 - 0xd25ba464   (5865 kB)
Dec 28 08:51:33 D-69-91-141-110 kernel: Checking if this processor honours the WP bit even in supervisor mode...Ok.
Dec 28 08:51:33 D-69-91-141-110 kernel: Hierarchical RCU implementation.
Dec 28 08:51:33 D-69-91-141-110 kernel:         RCU restricting CPUs from NR_CPUS=32 to nr_cpu_ids=2.
Dec 28 08:51:33 D-69-91-141-110 kernel: RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
Dec 28 08:51:33 D-69-91-141-110 kernel: NR_IRQS: 2304, nr_irqs: 440, preallocated irqs: 16
Dec 28 08:51:33 D-69-91-141-110 kernel: CPU 0 irqstacks, hard=(ptrval) soft=(ptrval)
Dec 28 08:51:33 D-69-91-141-110 kernel: Console: colour VGA+ 80x25
Dec 28 08:51:33 D-69-91-141-110 kernel: console [tty0] enabled
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: Core revision 20170831
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: 1 ACPI AML tables successfully acquired and loaded
Dec 28 08:51:33 D-69-91-141-110 kernel: APIC: Switch to symmetric I/O mode setup
Dec 28 08:51:33 D-69-91-141-110 kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Dec 28 08:51:33 D-69-91-141-110 kernel: ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
Dec 28 08:51:33 D-69-91-141-110 kernel: tsc: Fast TSC calibration using PIT
Dec 28 08:51:33 D-69-91-141-110 kernel: tsc: Detected 1662.618 MHz processor
Dec 28 08:51:33 D-69-91-141-110 kernel: Calibrating delay loop (skipped), value calculated using timer frequency.. 3325.23 BogoMIPS (lpj=6650472)
Dec 28 08:51:33 D-69-91-141-110 kernel: pid_max: default: 32768 minimum: 301
Dec 28 08:51:33 D-69-91-141-110 kernel: Security Framework initialized
Dec 28 08:51:33 D-69-91-141-110 kernel: Yama: becoming mindful.
Dec 28 08:51:33 D-69-91-141-110 kernel: AppArmor: AppArmor disabled by boot time parameter
Dec 28 08:51:33 D-69-91-141-110 kernel: Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
Dec 28 08:51:33 D-69-91-141-110 kernel: Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
Dec 28 08:51:33 D-69-91-141-110 kernel: CPU: Physical Processor ID: 0
Dec 28 08:51:33 D-69-91-141-110 kernel: CPU: Processor Core ID: 0
Dec 28 08:51:33 D-69-91-141-110 kernel: mce: CPU supports 6 MCE banks
Dec 28 08:51:33 D-69-91-141-110 kernel: process: using mwait in idle threads
Dec 28 08:51:33 D-69-91-141-110 kernel: Last level iTLB entries: 4KB 128, 2MB 4, 4MB 4
Dec 28 08:51:33 D-69-91-141-110 kernel: Last level dTLB entries: 4KB 256, 2MB 0, 4MB 32, 1GB 0
Dec 28 08:51:33 D-69-91-141-110 kernel: Freeing SMP alternatives memory: 24K
Dec 28 08:51:33 D-69-91-141-110 kernel: smpboot: CPU0: Intel(R) Core(TM)2 Duo CPU     T5450  @ 1.66GHz (family: 0x6, model: 0xf, stepping: 0xd)
Dec 28 08:51:33 D-69-91-141-110 kernel: Performance Events: PEBS fmt0+, Core2 events, Intel PMU driver.
Dec 28 08:51:33 D-69-91-141-110 kernel: core: PEBS disabled due to CPU errata
Dec 28 08:51:33 D-69-91-141-110 kernel: ... version:                2
Dec 28 08:51:33 D-69-91-141-110 kernel: ... bit width:              40
Dec 28 08:51:33 D-69-91-141-110 kernel: ... generic registers:      2
Dec 28 08:51:33 D-69-91-141-110 kernel: ... value mask:             000000ffffffffff
Dec 28 08:51:33 D-69-91-141-110 kernel: ... max period:             000000007fffffff
Dec 28 08:51:33 D-69-91-141-110 kernel: ... fixed-purpose events:   3
Dec 28 08:51:33 D-69-91-141-110 kernel: ... event mask:             0000000700000003
Dec 28 08:51:33 D-69-91-141-110 kernel: Hierarchical SRCU implementation.
Dec 28 08:51:33 D-69-91-141-110 kernel: NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
Dec 28 08:51:33 D-69-91-141-110 kernel: smp: Bringing up secondary CPUs ...
Dec 28 08:51:33 D-69-91-141-110 kernel: CPU 1 irqstacks, hard=c236e815 soft=1d7674f1
Dec 28 08:51:33 D-69-91-141-110 kernel: x86: Booting SMP configuration:
Dec 28 08:51:33 D-69-91-141-110 kernel: .... node  #0, CPUs:      #1
Dec 28 08:51:33 D-69-91-141-110 kernel: Initializing CPU#1
Dec 28 08:51:33 D-69-91-141-110 kernel: smp: Brought up 1 node, 2 CPUs
Dec 28 08:51:33 D-69-91-141-110 kernel: smpboot: Max logical packages: 1
Dec 28 08:51:33 D-69-91-141-110 kernel: smpboot: Total of 2 processors activated (6650.47 BogoMIPS)
Dec 28 08:51:33 D-69-91-141-110 kernel: devtmpfs: initialized
Dec 28 08:51:33 D-69-91-141-110 kernel: PM: Registering ACPI NVS region [mem 0xb7fae000-0xb7feffff] (270336 bytes)
Dec 28 08:51:33 D-69-91-141-110 kernel: clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
Dec 28 08:51:33 D-69-91-141-110 kernel: futex hash table entries: 512 (order: 3, 32768 bytes)
Dec 28 08:51:33 D-69-91-141-110 kernel: pinctrl core: initialized pinctrl subsystem
Dec 28 08:51:33 D-69-91-141-110 kernel: NET: Registered protocol family 16
Dec 28 08:51:33 D-69-91-141-110 kernel: audit: initializing netlink subsys (disabled)
Dec 28 08:51:33 D-69-91-141-110 kernel: audit: type=2000 audit(1514469084.036:1): state=initialized audit_enabled=0 res=1
Dec 28 08:51:33 D-69-91-141-110 kernel: cpuidle: using governor ladder
Dec 28 08:51:33 D-69-91-141-110 kernel: cpuidle: using governor menu
Dec 28 08:51:33 D-69-91-141-110 kernel: Simple Boot Flag at 0xff set to 0x1
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: bus type PCI registered
Dec 28 08:51:33 D-69-91-141-110 kernel: acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
Dec 28 08:51:33 D-69-91-141-110 kernel: PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
Dec 28 08:51:33 D-69-91-141-110 kernel: PCI: not using MMCONFIG
Dec 28 08:51:33 D-69-91-141-110 kernel: PCI: PCI BIOS area is rw and x. Use pci=nobios if you want it NX.
Dec 28 08:51:33 D-69-91-141-110 kernel: PCI: PCI BIOS revision 3.00 entry at 0xf0031, last bus=8
Dec 28 08:51:33 D-69-91-141-110 kernel: PCI: Using configuration type 1 for base access
Dec 28 08:51:33 D-69-91-141-110 kernel: mtrr: your CPUs had inconsistent variable MTRR settings
Dec 28 08:51:33 D-69-91-141-110 kernel: mtrr: probably your BIOS does not setup all CPUs.
Dec 28 08:51:33 D-69-91-141-110 kernel: mtrr: corrected configuration.
Dec 28 08:51:33 D-69-91-141-110 kernel: HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: Added _OSI(Module Device)
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: Added _OSI(Processor Device)
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: Added _OSI(3.0 _SCP Extensions)
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: Added _OSI(Processor Aggregator Device)
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: Executed 2 blocks of module-level executable AML code
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: Dynamic OEM Table Load:
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: SSDT 0x00000000F7175000 000C99 (v01 AMI    CPU1PM   00000001 INTL 20060113)
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: Dynamic OEM Table Load:
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: SSDT 0x00000000F7178000 000C99 (v01 AMI    CPU2PM   00000001 INTL 20060113)
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: EC: EC started
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: EC: interrupt blocked
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: \_SB_.PCI0.SBRG.EC0_: Used as first EC
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: \_SB_.PCI0.SBRG.EC0_: GPE=0x11, EC_CMD/EC_SC=0x66, EC_DATA=0x62
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: \_SB_.PCI0.SBRG.EC0_: Used as boot DSDT EC to handle transactions
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: Interpreter enabled
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: (supports S0 S3 S4 S5)
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: Using IOAPIC for interrupt routing
Dec 28 08:51:33 D-69-91-141-110 kernel: PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
Dec 28 08:51:33 D-69-91-141-110 kernel: PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in ACPI motherboard resources
Dec 28 08:51:33 D-69-91-141-110 kernel: PCI: Using MMCONFIG for extended config space
Dec 28 08:51:33 D-69-91-141-110 kernel: PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: Enabled 6 GPEs in block 00 to 1F
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
Dec 28 08:51:33 D-69-91-141-110 kernel: acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
Dec 28 08:51:33 D-69-91-141-110 kernel: acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
Dec 28 08:51:33 D-69-91-141-110 kernel: PCI host bridge to bus 0000:00
Dec 28 08:51:33 D-69-91-141-110 kernel: pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000dffff window]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci_bus 0000:00: root bus resource [mem 0xb8000000-0xffffffff window]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci_bus 0000:00: root bus resource [bus 00-ff]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:00.0: [1002:5a31] type 00 class 0x060000
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:01.0: [1002:5a3f] type 01 class 0x060400
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:04.0: [1002:5a36] type 01 class 0x060400
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:04.0: enabling Extended Tags
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:05.0: [1002:5a37] type 01 class 0x060400
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:05.0: enabling Extended Tags
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:05.0: PME# supported from D0 D3hot D3cold
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:06.0: [1002:5a38] type 01 class 0x060400
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:06.0: enabling Extended Tags
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:07.0: [1002:5a39] type 01 class 0x060400
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:07.0: enabling Extended Tags
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:12.0: [1002:4380] type 00 class 0x01018f
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:12.0: reg 0x10: [io  0xe800-0xe807]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:12.0: reg 0x14: [io  0xe400-0xe403]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:12.0: reg 0x18: [io  0xe000-0xe007]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:12.0: reg 0x1c: [io  0xdc00-0xdc03]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:12.0: reg 0x20: [io  0xd800-0xd80f]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:12.0: reg 0x24: [mem 0xfebffc00-0xfebfffff]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:12.0: set SATA to AHCI mode
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:13.0: [1002:4387] type 00 class 0x0c0310
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:13.0: reg 0x10: [mem 0xfebfe000-0xfebfefff]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:13.1: [1002:4388] type 00 class 0x0c0310
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:13.1: reg 0x10: [mem 0xfebfd000-0xfebfdfff]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:13.2: [1002:4389] type 00 class 0x0c0310
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:13.2: reg 0x10: [mem 0xfebfc000-0xfebfcfff]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:13.3: [1002:438a] type 00 class 0x0c0310
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:13.3: reg 0x10: [mem 0xfebfb000-0xfebfbfff]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:13.4: [1002:438b] type 00 class 0x0c0310
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:13.4: reg 0x10: [mem 0xfebfa000-0xfebfafff]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:13.5: [1002:4386] type 00 class 0x0c0320
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:13.5: reg 0x10: [mem 0xfebff800-0xfebff8ff]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:13.5: supports D1 D2
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:13.5: PME# supported from D0 D1 D2 D3hot
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:14.0: [1002:4385] type 00 class 0x0c0500
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:14.0: reg 0x10: [io  0x0b00-0x0b0f]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:14.1: [1002:438c] type 00 class 0x010182
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:14.1: reg 0x10: [io  0x0000-0x0007]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:14.1: reg 0x14: [io  0x0000-0x0003]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:14.1: reg 0x18: [io  0x0000-0x0007]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:14.1: reg 0x1c: [io  0x0000-0x0003]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:14.1: reg 0x20: [io  0xff00-0xff0f]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:14.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:14.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:14.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:14.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:14.2: [1002:4383] type 00 class 0x040300
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:14.2: reg 0x10: [mem 0xfebf4000-0xfebf7fff 64bit]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:14.3: [1002:438d] type 00 class 0x060100
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:14.4: [1002:4384] type 01 class 0x060401
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:01:05.0: [1002:5a62] type 00 class 0x030000
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:01:05.0: reg 0x10: [mem 0xc0000000-0xcfffffff pref]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:01:05.0: reg 0x14: [io  0x9800-0x98ff]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:01:05.0: reg 0x18: [mem 0xfa8f0000-0xfa8fffff]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:01:05.0: reg 0x30: [mem 0xfa8c0000-0xfa8dffff pref]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:01:05.0: supports D1 D2
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:01.0: PCI bridge to [bus 01]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:01.0:   bridge window [io  0x9000-0x9fff]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:01.0:   bridge window [mem 0xfa800000-0xfa8fffff]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:01.0:   bridge window [mem 0xbdf00000-0xddefffff pref]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:02:00.0: [168c:001c] type 00 class 0x020000
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:02:00.0: reg 0x10: [mem 0xfa9f0000-0xfa9fffff 64bit]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:02:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:04.0: PCI bridge to [bus 02]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:04.0:   bridge window [mem 0xfa900000-0xfa9fffff]
Dec 28 08:51:33 D-69-91-141-110 kernel: acpiphp: Slot [1] registered
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:05.0: PCI bridge to [bus 03-05]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:05.0:   bridge window [io  0xa000-0xbfff]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:05.0:   bridge window [mem 0xfaa00000-0xfe9fffff]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:05.0:   bridge window [mem 0xddf00000-0xdfefffff 64bit pref]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:06:00.0: [1969:2048] type 00 class 0x020000
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:06:00.0: reg 0x10: [mem 0xfeac0000-0xfeafffff 64bit]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:06:00.0: reg 0x30: [mem 0xfeaa0000-0xfeabffff pref]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:06:00.0: PME# supported from D3hot D3cold
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:06:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:06.0: PCI bridge to [bus 06]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:06.0:   bridge window [mem 0xfea00000-0xfeafffff]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:07.0: PCI bridge to [bus 07]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:14.4: PCI bridge to [bus 08] (subtractive decode)
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:14.4:   bridge window [io  0x0000-0x0cf7 window] (subtractive decode)
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:14.4:   bridge window [mem 0x000d0000-0x000dffff window] (subtractive decode)
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:14.4:   bridge window [mem 0xb8000000-0xffffffff window] (subtractive decode)
Dec 28 08:51:33 D-69-91-141-110 kernel: pci_bus 0000:00: on NUMA node 0
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 7 10 11 12)
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 12)
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 7 10 11 12)
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *10 11 12)
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 12) *0, disabled.
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 12) *0, disabled.
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 *11 12)
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 12) *0, disabled.
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: EC: interrupt unblocked
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: EC: event unblocked
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: \_SB_.PCI0.SBRG.EC0_: GPE=0x11, EC_CMD/EC_SC=0x66, EC_DATA=0x62
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: \_SB_.PCI0.SBRG.EC0_: Used as boot DSDT EC to handle transactions and events
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:01:05.0: vgaarb: setting as boot VGA device
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:01:05.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:01:05.0: vgaarb: bridge control possible
Dec 28 08:51:33 D-69-91-141-110 kernel: vgaarb: loaded
Dec 28 08:51:33 D-69-91-141-110 kernel: EDAC MC: Ver: 3.0.0
Dec 28 08:51:33 D-69-91-141-110 kernel: PCI: Using ACPI for IRQ routing
Dec 28 08:51:33 D-69-91-141-110 kernel: PCI: pci_cache_line_size set to 64 bytes
Dec 28 08:51:33 D-69-91-141-110 kernel: e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
Dec 28 08:51:33 D-69-91-141-110 kernel: e820: reserve RAM buffer [mem 0xb7fa0000-0xb7ffffff]
Dec 28 08:51:33 D-69-91-141-110 kernel: clocksource: Switched to clocksource refined-jiffies
Dec 28 08:51:33 D-69-91-141-110 kernel: VFS: Disk quotas dquot_6.6.0
Dec 28 08:51:33 D-69-91-141-110 kernel: VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Dec 28 08:51:33 D-69-91-141-110 kernel: pnp: PnP ACPI init
Dec 28 08:51:33 D-69-91-141-110 kernel: pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
Dec 28 08:51:33 D-69-91-141-110 kernel: system 00:01: [io  0x04d0-0x04d1] has been reserved
Dec 28 08:51:33 D-69-91-141-110 kernel: system 00:01: [io  0x040b] has been reserved
Dec 28 08:51:33 D-69-91-141-110 kernel: system 00:01: [io  0x04d6] has been reserved
Dec 28 08:51:33 D-69-91-141-110 kernel: system 00:01: [io  0x0c00-0x0c01] has been reserved
Dec 28 08:51:33 D-69-91-141-110 kernel: system 00:01: [io  0x0c14] has been reserved
Dec 28 08:51:33 D-69-91-141-110 kernel: system 00:01: [io  0x0c50-0x0c51] has been reserved
Dec 28 08:51:33 D-69-91-141-110 kernel: system 00:01: [io  0x0c52] has been reserved
Dec 28 08:51:33 D-69-91-141-110 kernel: system 00:01: [io  0x0c6c] has been reserved
Dec 28 08:51:33 D-69-91-141-110 kernel: system 00:01: [io  0x0c6f] has been reserved
Dec 28 08:51:33 D-69-91-141-110 kernel: system 00:01: [io  0x0cd0-0x0cd1] has been reserved
Dec 28 08:51:33 D-69-91-141-110 kernel: system 00:01: [io  0x0cd2-0x0cd3] has been reserved
Dec 28 08:51:33 D-69-91-141-110 kernel: system 00:01: [io  0x0cd4-0x0cd5] has been reserved
Dec 28 08:51:33 D-69-91-141-110 kernel: system 00:01: [io  0x0cd6-0x0cd7] has been reserved
Dec 28 08:51:33 D-69-91-141-110 kernel: system 00:01: [io  0x0cd8-0x0cdf] has been reserved
Dec 28 08:51:33 D-69-91-141-110 kernel: system 00:01: [io  0x0800-0x089f] has been reserved
Dec 28 08:51:33 D-69-91-141-110 kernel: system 00:01: [io  0x0b00-0x0b1f] could not be reserved
Dec 28 08:51:33 D-69-91-141-110 kernel: system 00:01: [io  0x0900-0x090f] has been reserved
Dec 28 08:51:33 D-69-91-141-110 kernel: system 00:01: [io  0x0910-0x091f] has been reserved
Dec 28 08:51:33 D-69-91-141-110 kernel: system 00:01: [io  0xfe00-0xfefe] has been reserved
Dec 28 08:51:33 D-69-91-141-110 kernel: system 00:01: [io  0x4000-0x40fe] has been reserved
Dec 28 08:51:33 D-69-91-141-110 kernel: system 00:01: [mem 0xfed45000-0xfed89fff] has been reserved
Dec 28 08:51:33 D-69-91-141-110 kernel: system 00:01: [mem 0xffb80000-0xffbfffff] has been reserved
Dec 28 08:51:33 D-69-91-141-110 kernel: system 00:01: [mem 0xfff80000-0xffffffff] has been reserved
Dec 28 08:51:33 D-69-91-141-110 kernel: system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
Dec 28 08:51:33 D-69-91-141-110 kernel: pnp 00:02: Plug and Play ACPI device, IDs PNP0303 PNP030b (active)
Dec 28 08:51:33 D-69-91-141-110 kernel: pnp 00:03: Plug and Play ACPI device, IDs SYN0a04 SYN0a00 SYN0002 PNP0f03 PNP0f13 PNP0f12 (active)
Dec 28 08:51:33 D-69-91-141-110 kernel: system 00:04: [io  0x0250-0x0253] has been reserved
Dec 28 08:51:33 D-69-91-141-110 kernel: system 00:04: [io  0x0256-0x025f] has been reserved
Dec 28 08:51:33 D-69-91-141-110 kernel: system 00:04: [mem 0xfec00000-0xfec00fff] could not be reserved
Dec 28 08:51:33 D-69-91-141-110 kernel: system 00:04: [mem 0xfee00000-0xfee00fff] has been reserved
Dec 28 08:51:33 D-69-91-141-110 kernel: system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
Dec 28 08:51:33 D-69-91-141-110 kernel: system 00:05: [mem 0xe0000000-0xefffffff] has been reserved
Dec 28 08:51:33 D-69-91-141-110 kernel: system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
Dec 28 08:51:33 D-69-91-141-110 kernel: system 00:06: [mem 0x00000000-0x0009ffff] could not be reserved
Dec 28 08:51:33 D-69-91-141-110 kernel: system 00:06: [mem 0x000c0000-0x000cffff] could not be reserved
Dec 28 08:51:33 D-69-91-141-110 kernel: system 00:06: [mem 0x000e0000-0x000fffff] could not be reserved
Dec 28 08:51:33 D-69-91-141-110 kernel: system 00:06: [mem 0x00100000-0xb7ffffff] could not be reserved
Dec 28 08:51:33 D-69-91-141-110 kernel: system 00:06: Plug and Play ACPI device, IDs PNP0c01 (active)
Dec 28 08:51:33 D-69-91-141-110 kernel: pnp: PnP ACPI: found 7 devices
Dec 28 08:51:33 D-69-91-141-110 kernel: PnPBIOS: Disabled
Dec 28 08:51:33 D-69-91-141-110 kernel: clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
Dec 28 08:51:33 D-69-91-141-110 kernel: clocksource: Switched to clocksource acpi_pm
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:01.0: PCI bridge to [bus 01]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:01.0:   bridge window [io  0x9000-0x9fff]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:01.0:   bridge window [mem 0xfa800000-0xfa8fffff]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:01.0:   bridge window [mem 0xbdf00000-0xddefffff pref]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:04.0: PCI bridge to [bus 02]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:04.0:   bridge window [mem 0xfa900000-0xfa9fffff]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:05.0: PCI bridge to [bus 03-05]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:05.0:   bridge window [io  0xa000-0xbfff]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:05.0:   bridge window [mem 0xfaa00000-0xfe9fffff]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:05.0:   bridge window [mem 0xddf00000-0xdfefffff 64bit pref]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:06.0: PCI bridge to [bus 06]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:06.0:   bridge window [mem 0xfea00000-0xfeafffff]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:07.0: PCI bridge to [bus 07]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:14.4: PCI bridge to [bus 08]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000dffff window]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci_bus 0000:00: resource 8 [mem 0xb8000000-0xffffffff window]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci_bus 0000:01: resource 0 [io  0x9000-0x9fff]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci_bus 0000:01: resource 1 [mem 0xfa800000-0xfa8fffff]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci_bus 0000:01: resource 2 [mem 0xbdf00000-0xddefffff pref]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci_bus 0000:02: resource 1 [mem 0xfa900000-0xfa9fffff]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci_bus 0000:03: resource 0 [io  0xa000-0xbfff]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci_bus 0000:03: resource 1 [mem 0xfaa00000-0xfe9fffff]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci_bus 0000:03: resource 2 [mem 0xddf00000-0xdfefffff 64bit pref]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci_bus 0000:06: resource 1 [mem 0xfea00000-0xfeafffff]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci_bus 0000:08: resource 4 [io  0x0000-0x0cf7 window]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci_bus 0000:08: resource 5 [io  0x0d00-0xffff window]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci_bus 0000:08: resource 6 [mem 0x000a0000-0x000bffff window]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci_bus 0000:08: resource 7 [mem 0x000d0000-0x000dffff window]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci_bus 0000:08: resource 8 [mem 0xb8000000-0xffffffff window]
Dec 28 08:51:33 D-69-91-141-110 kernel: NET: Registered protocol family 2
Dec 28 08:51:33 D-69-91-141-110 kernel: TCP established hash table entries: 8192 (order: 3, 32768 bytes)
Dec 28 08:51:33 D-69-91-141-110 kernel: TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
Dec 28 08:51:33 D-69-91-141-110 kernel: TCP: Hash tables configured (established 8192 bind 8192)
Dec 28 08:51:33 D-69-91-141-110 kernel: UDP hash table entries: 512 (order: 2, 16384 bytes)
Dec 28 08:51:33 D-69-91-141-110 kernel: UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
Dec 28 08:51:33 D-69-91-141-110 kernel: NET: Registered protocol family 1
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:00:01.0: MSI quirk detected; subordinate MSI disabled
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:01:05.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
Dec 28 08:51:33 D-69-91-141-110 kernel: pci 0000:06:00.0: [Firmware Bug]: disabling VPD access (can't determine size of non-standard VPD format)
Dec 28 08:51:33 D-69-91-141-110 kernel: PCI: CLS 64 bytes, default 64
Dec 28 08:51:33 D-69-91-141-110 kernel: Unpacking initramfs...
Dec 28 08:51:33 D-69-91-141-110 kernel: Freeing initrd memory: 17776K
Dec 28 08:51:33 D-69-91-141-110 kernel: Initialise system trusted keyrings
Dec 28 08:51:33 D-69-91-141-110 kernel: workingset: timestamp_bits=14 max_order=20 bucket_order=6
Dec 28 08:51:33 D-69-91-141-110 kernel: zbud: loaded
Dec 28 08:51:33 D-69-91-141-110 kernel: tsc: Refined TSC clocksource calibration: 1662.499 MHz
Dec 28 08:51:33 D-69-91-141-110 kernel: clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x17f6c559e9c, max_idle_ns: 440795215390 ns
Dec 28 08:51:33 D-69-91-141-110 kernel: clocksource: Switched to clocksource tsc
Dec 28 08:51:33 D-69-91-141-110 kernel: Key type asymmetric registered
Dec 28 08:51:33 D-69-91-141-110 kernel: Asymmetric key parser 'x509' registered
Dec 28 08:51:33 D-69-91-141-110 kernel: bounce: pool size: 64 pages
Dec 28 08:51:33 D-69-91-141-110 kernel: Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
Dec 28 08:51:33 D-69-91-141-110 kernel: io scheduler noop registered
Dec 28 08:51:33 D-69-91-141-110 kernel: io scheduler deadline registered
Dec 28 08:51:33 D-69-91-141-110 kernel: io scheduler cfq registered (default)
Dec 28 08:51:33 D-69-91-141-110 kernel: io scheduler mq-deadline registered
Dec 28 08:51:33 D-69-91-141-110 kernel: io scheduler kyber registered
Dec 28 08:51:33 D-69-91-141-110 kernel: intel_idle: does not run on family 6 model 15
Dec 28 08:51:33 D-69-91-141-110 kernel: tsc: Marking TSC unstable due to TSC halts in idle
Dec 28 08:51:33 D-69-91-141-110 kernel: clocksource: Switched to clocksource acpi_pm
Dec 28 08:51:33 D-69-91-141-110 kernel: isapnp: Scanning for PnP cards...
Dec 28 08:51:33 D-69-91-141-110 kernel: isapnp: No Plug & Play device found
Dec 28 08:51:33 D-69-91-141-110 kernel: Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
Dec 28 08:51:33 D-69-91-141-110 kernel: Linux agpgart interface v0.103
Dec 28 08:51:33 D-69-91-141-110 kernel: i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
Dec 28 08:51:33 D-69-91-141-110 kernel: i8042: Detected active multiplexing controller, rev 1.1
Dec 28 08:51:33 D-69-91-141-110 kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Dec 28 08:51:33 D-69-91-141-110 kernel: serio: i8042 AUX0 port at 0x60,0x64 irq 12
Dec 28 08:51:33 D-69-91-141-110 kernel: serio: i8042 AUX1 port at 0x60,0x64 irq 12
Dec 28 08:51:33 D-69-91-141-110 kernel: serio: i8042 AUX2 port at 0x60,0x64 irq 12
Dec 28 08:51:33 D-69-91-141-110 kernel: serio: i8042 AUX3 port at 0x60,0x64 irq 12
Dec 28 08:51:33 D-69-91-141-110 kernel: mousedev: PS/2 mouse device common for all mice
Dec 28 08:51:33 D-69-91-141-110 kernel: rtc_cmos 00:00: RTC can wake from S4
Dec 28 08:51:33 D-69-91-141-110 kernel: rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
Dec 28 08:51:33 D-69-91-141-110 kernel: rtc_cmos 00:00: alarms up to one month, y3k, 114 bytes nvram
Dec 28 08:51:33 D-69-91-141-110 kernel: ledtrig-cpu: registered to indicate activity on CPUs
Dec 28 08:51:33 D-69-91-141-110 kernel: NET: Registered protocol family 10
Dec 28 08:51:33 D-69-91-141-110 kernel: Segment Routing with IPv6
Dec 28 08:51:33 D-69-91-141-110 kernel: mip6: Mobile IPv6
Dec 28 08:51:33 D-69-91-141-110 kernel: NET: Registered protocol family 17
Dec 28 08:51:33 D-69-91-141-110 kernel: mpls_gso: MPLS GSO support
Dec 28 08:51:33 D-69-91-141-110 kernel: microcode: sig=0x6fd, pf=0x80, revision=0xa4
Dec 28 08:51:33 D-69-91-141-110 kernel: microcode: Microcode Update Driver: v2.2.
Dec 28 08:51:33 D-69-91-141-110 kernel: Using IPI No-Shortcut mode
Dec 28 08:51:33 D-69-91-141-110 kernel: registered taskstats version 1
Dec 28 08:51:33 D-69-91-141-110 kernel: Loading compiled-in X.509 certificates
Dec 28 08:51:33 D-69-91-141-110 kernel: zswap: loaded using pool lzo/zbud
Dec 28 08:51:33 D-69-91-141-110 kernel: ima: No TPM chip found, activating TPM-bypass! (rc=-19)
Dec 28 08:51:33 D-69-91-141-110 kernel: rtc_cmos 00:00: setting system clock to 2017-12-28 13:51:27 UTC (1514469087)
Dec 28 08:51:33 D-69-91-141-110 kernel: Freeing unused kernel memory: 604K
Dec 28 08:51:33 D-69-91-141-110 kernel: Write protecting the kernel text: 5868k
Dec 28 08:51:33 D-69-91-141-110 kernel: Write protecting the kernel read-only data: 1860k
Dec 28 08:51:33 D-69-91-141-110 kernel: NX-protecting the kernel data: 4372k
Dec 28 08:51:33 D-69-91-141-110 kernel: ------------[ cut here ]------------
Dec 28 08:51:33 D-69-91-141-110 kernel: x86/mm: Found insecure W+X mapping at address 6634b4f8/0xc00a0000
Dec 28 08:51:33 D-69-91-141-110 kernel: WARNING: CPU: 1 PID: 1 at arch/x86/mm/dump_pagetables.c:257 note_page+0x5ec/0x790
Dec 28 08:51:33 D-69-91-141-110 kernel: Modules linked in:
Dec 28 08:51:33 D-69-91-141-110 kernel: CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.15.0-rc5-dou-p+ #1
Dec 28 08:51:33 D-69-91-141-110 kernel: Hardware name: ASUSTeK Computer Inc. F5RL                /F5RL      , BIOS 210     06/12/2008
Dec 28 08:51:33 D-69-91-141-110 kernel: EIP: note_page+0x5ec/0x790
Dec 28 08:51:33 D-69-91-141-110 kernel: EFLAGS: 00210282 CPU: 1
Dec 28 08:51:33 D-69-91-141-110 kernel: EAX: 00000041 EBX: f70c7f54 ECX: 00000001 EDX: d28de544
Dec 28 08:51:33 D-69-91-141-110 kernel: ESI: 80000000 EDI: 00000000 EBP: f70c7f20 ESP: f70c7ef4
Dec 28 08:51:33 D-69-91-141-110 kernel:  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
Dec 28 08:51:33 D-69-91-141-110 kernel: CR0: 80050033 CR2: 00000000 CR3: 128ce000 CR4: 000006f0
Dec 28 08:51:33 D-69-91-141-110 kernel: Call Trace:
Dec 28 08:51:33 D-69-91-141-110 kernel:  ptdump_walk_pgd_level_core+0x15c/0x240
Dec 28 08:51:33 D-69-91-141-110 kernel:  ptdump_walk_pgd_level_checkwx+0x11/0x20
Dec 28 08:51:33 D-69-91-141-110 kernel:  mark_rodata_ro+0xd5/0xf1
Dec 28 08:51:33 D-69-91-141-110 kernel:  ? rest_init+0x90/0x90
Dec 28 08:51:33 D-69-91-141-110 kernel:  kernel_init+0x24/0xe0
Dec 28 08:51:33 D-69-91-141-110 kernel:  ret_from_fork+0x19/0x24
Dec 28 08:51:33 D-69-91-141-110 kernel: Code: fa ff ff 83 c2 0c c7 43 18 00 00 00 00 89 53 14 e9 1a fd ff ff 8b 43 0c c6 05 c4 76 80 d2 01 50 50 68 50 ee 6c d2 e8 84 5c 00 00 <0f> ff 83 c4 0c e9 6f fa ff ff ff 72 10 68 1c ed 6c d2 e8 57 f5
Dec 28 08:51:33 D-69-91-141-110 kernel: ---[ end trace 6363fd513ff6ba4e ]---
Dec 28 08:51:33 D-69-91-141-110 kernel: x86/mm: Checked W+X mappings: FAILED, 96 W+X pages found.
Dec 28 08:51:33 D-69-91-141-110 kernel: input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
Dec 28 08:51:33 D-69-91-141-110 kernel: Atheros(R) L2 Ethernet Driver - version 2.2.3
Dec 28 08:51:33 D-69-91-141-110 kernel: Copyright (c) 2007 Atheros Corporation.
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: bus type USB registered
Dec 28 08:51:33 D-69-91-141-110 kernel: usbcore: registered new interface driver usbfs
Dec 28 08:51:33 D-69-91-141-110 kernel: usbcore: registered new interface driver hub
Dec 28 08:51:33 D-69-91-141-110 kernel: SCSI subsystem initialized
Dec 28 08:51:33 D-69-91-141-110 kernel: usbcore: registered new device driver usb
Dec 28 08:51:33 D-69-91-141-110 kernel: ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
Dec 28 08:51:33 D-69-91-141-110 kernel: ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
Dec 28 08:51:33 D-69-91-141-110 kernel: ehci-pci: EHCI PCI platform driver
Dec 28 08:51:33 D-69-91-141-110 kernel: ehci-pci 0000:00:13.5: EHCI Host Controller
Dec 28 08:51:33 D-69-91-141-110 kernel: ehci-pci 0000:00:13.5: new USB bus registered, assigned bus number 1
Dec 28 08:51:33 D-69-91-141-110 kernel: ehci-pci 0000:00:13.5: applying AMD SB600/SB700 USB freeze workaround
Dec 28 08:51:33 D-69-91-141-110 kernel: ehci-pci 0000:00:13.5: debug port 1
Dec 28 08:51:33 D-69-91-141-110 kernel: ehci-pci 0000:00:13.5: irq 19, io mem 0xfebff800
Dec 28 08:51:33 D-69-91-141-110 kernel: libata version 3.00 loaded.
Dec 28 08:51:33 D-69-91-141-110 kernel: ehci-pci 0000:00:13.5: USB 2.0 started, EHCI 1.00
Dec 28 08:51:33 D-69-91-141-110 kernel: usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
Dec 28 08:51:33 D-69-91-141-110 kernel: usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Dec 28 08:51:33 D-69-91-141-110 kernel: usb usb1: Product: EHCI Host Controller
Dec 28 08:51:33 D-69-91-141-110 kernel: usb usb1: Manufacturer: Linux 4.15.0-rc5-dou-p+ ehci_hcd
Dec 28 08:51:33 D-69-91-141-110 kernel: usb usb1: SerialNumber: 0000:00:13.5
Dec 28 08:51:33 D-69-91-141-110 kernel: hub 1-0:1.0: USB hub found
Dec 28 08:51:33 D-69-91-141-110 kernel: hub 1-0:1.0: 10 ports detected
Dec 28 08:51:33 D-69-91-141-110 kernel: ahci 0000:00:12.0: version 3.0
Dec 28 08:51:33 D-69-91-141-110 kernel: ahci 0000:00:12.0: controller can't do 64bit DMA, forcing 32bit
Dec 28 08:51:33 D-69-91-141-110 kernel: ohci-pci: OHCI PCI platform driver
Dec 28 08:51:33 D-69-91-141-110 kernel: ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
Dec 28 08:51:33 D-69-91-141-110 kernel: ahci 0000:00:12.0: flags: ncq sntf ilck led clo pmp pio slum part ccc 
Dec 28 08:51:33 D-69-91-141-110 kernel: scsi host0: ahci
Dec 28 08:51:33 D-69-91-141-110 kernel: scsi host1: ahci
Dec 28 08:51:33 D-69-91-141-110 kernel: scsi host2: ahci
Dec 28 08:51:33 D-69-91-141-110 kernel: scsi host3: ahci
Dec 28 08:51:33 D-69-91-141-110 kernel: ata1: SATA max UDMA/133 abar m1024@0xfebffc00 port 0xfebffd00 irq 22
Dec 28 08:51:33 D-69-91-141-110 kernel: ata2: SATA max UDMA/133 abar m1024@0xfebffc00 port 0xfebffd80 irq 22
Dec 28 08:51:33 D-69-91-141-110 kernel: ata3: SATA max UDMA/133 abar m1024@0xfebffc00 port 0xfebffe00 irq 22
Dec 28 08:51:33 D-69-91-141-110 kernel: ata4: SATA max UDMA/133 abar m1024@0xfebffc00 port 0xfebffe80 irq 22
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI Warning: SystemIO range 0x0000000000000B00-0x0000000000000B08 conflicts with OpRegion 0x0000000000000B00-0x0000000000000B0F (\SMB0) (20170831/utaddress-247)
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
Dec 28 08:51:33 D-69-91-141-110 kernel: scsi host4: pata_atiixp
Dec 28 08:51:33 D-69-91-141-110 kernel: scsi host5: pata_atiixp
Dec 28 08:51:33 D-69-91-141-110 kernel: ata5: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xff00 irq 14
Dec 28 08:51:33 D-69-91-141-110 kernel: ata6: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xff08 irq 15
Dec 28 08:51:33 D-69-91-141-110 kernel: ohci-pci 0000:00:13.0: OHCI PCI host controller
Dec 28 08:51:33 D-69-91-141-110 kernel: ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 2
Dec 28 08:51:33 D-69-91-141-110 kernel: ohci-pci 0000:00:13.0: irq 16, io mem 0xfebfe000
Dec 28 08:51:33 D-69-91-141-110 kernel: (NULL device *): hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
Dec 28 08:51:33 D-69-91-141-110 kernel: thermal LNXTHERM:00: registered as thermal_zone0
Dec 28 08:51:33 D-69-91-141-110 kernel: ACPI: Thermal Zone [THRM] (74 C)
Dec 28 08:51:33 D-69-91-141-110 kernel: usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
Dec 28 08:51:33 D-69-91-141-110 kernel: usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Dec 28 08:51:33 D-69-91-141-110 kernel: usb usb2: Product: OHCI PCI host controller
Dec 28 08:51:33 D-69-91-141-110 kernel: usb usb2: Manufacturer: Linux 4.15.0-rc5-dou-p+ ohci_hcd
Dec 28 08:51:33 D-69-91-141-110 kernel: usb usb2: SerialNumber: 0000:00:13.0
Dec 28 08:51:33 D-69-91-141-110 kernel: hub 2-0:1.0: USB hub found
Dec 28 08:51:33 D-69-91-141-110 kernel: hub 2-0:1.0: 2 ports detected
Dec 28 08:51:33 D-69-91-141-110 kernel: ohci-pci 0000:00:13.1: OHCI PCI host controller
Dec 28 08:51:33 D-69-91-141-110 kernel: ohci-pci 0000:00:13.1: new USB bus registered, assigned bus number 3
Dec 28 08:51:33 D-69-91-141-110 kernel: ohci-pci 0000:00:13.1: irq 17, io mem 0xfebfd000
Dec 28 08:51:33 D-69-91-141-110 kernel: usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
Dec 28 08:51:33 D-69-91-141-110 kernel: usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Dec 28 08:51:33 D-69-91-141-110 kernel: usb usb3: Product: OHCI PCI host controller
Dec 28 08:51:33 D-69-91-141-110 kernel: usb usb3: Manufacturer: Linux 4.15.0-rc5-dou-p+ ohci_hcd
Dec 28 08:51:33 D-69-91-141-110 kernel: usb usb3: SerialNumber: 0000:00:13.1
Dec 28 08:51:33 D-69-91-141-110 kernel: hub 3-0:1.0: USB hub found
Dec 28 08:51:33 D-69-91-141-110 kernel: hub 3-0:1.0: 2 ports detected
Dec 28 08:51:33 D-69-91-141-110 kernel: ohci-pci 0000:00:13.2: OHCI PCI host controller
Dec 28 08:51:33 D-69-91-141-110 kernel: ohci-pci 0000:00:13.2: new USB bus registered, assigned bus number 4
Dec 28 08:51:33 D-69-91-141-110 kernel: ohci-pci 0000:00:13.2: irq 18, io mem 0xfebfc000
Dec 28 08:51:33 D-69-91-141-110 kernel: ata5.00: ATAPI: HL-DT-ST DVDRAM GSA-T40N, JR03, max UDMA/33
Dec 28 08:51:33 D-69-91-141-110 kernel: usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
Dec 28 08:51:33 D-69-91-141-110 kernel: usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Dec 28 08:51:33 D-69-91-141-110 kernel: usb usb4: Product: OHCI PCI host controller
Dec 28 08:51:33 D-69-91-141-110 kernel: usb usb4: Manufacturer: Linux 4.15.0-rc5-dou-p+ ohci_hcd
Dec 28 08:51:33 D-69-91-141-110 kernel: usb usb4: SerialNumber: 0000:00:13.2
Dec 28 08:51:33 D-69-91-141-110 kernel: hub 4-0:1.0: USB hub found
Dec 28 08:51:33 D-69-91-141-110 kernel: hub 4-0:1.0: 2 ports detected
Dec 28 08:51:33 D-69-91-141-110 kernel: ohci-pci 0000:00:13.3: OHCI PCI host controller
Dec 28 08:51:33 D-69-91-141-110 kernel: ohci-pci 0000:00:13.3: new USB bus registered, assigned bus number 5
Dec 28 08:51:33 D-69-91-141-110 kernel: ohci-pci 0000:00:13.3: irq 17, io mem 0xfebfb000
Dec 28 08:51:33 D-69-91-141-110 kernel: ata5.00: configured for UDMA/33
Dec 28 08:51:33 D-69-91-141-110 kernel: usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
Dec 28 08:51:33 D-69-91-141-110 kernel: usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Dec 28 08:51:33 D-69-91-141-110 kernel: usb usb5: Product: OHCI PCI host controller
Dec 28 08:51:33 D-69-91-141-110 kernel: usb usb5: Manufacturer: Linux 4.15.0-rc5-dou-p+ ohci_hcd
Dec 28 08:51:33 D-69-91-141-110 kernel: usb usb5: SerialNumber: 0000:00:13.3
Dec 28 08:51:33 D-69-91-141-110 kernel: hub 5-0:1.0: USB hub found
Dec 28 08:51:33 D-69-91-141-110 kernel: hub 5-0:1.0: 2 ports detected
Dec 28 08:51:33 D-69-91-141-110 kernel: ohci-pci 0000:00:13.4: OHCI PCI host controller
Dec 28 08:51:33 D-69-91-141-110 kernel: ohci-pci 0000:00:13.4: new USB bus registered, assigned bus number 6
Dec 28 08:51:33 D-69-91-141-110 kernel: ohci-pci 0000:00:13.4: irq 18, io mem 0xfebfa000
Dec 28 08:51:33 D-69-91-141-110 kernel: usb 1-4: new high-speed USB device number 2 using ehci-pci
Dec 28 08:51:33 D-69-91-141-110 kernel: ata2: SATA link down (SStatus 0 SControl 300)
Dec 28 08:51:33 D-69-91-141-110 kernel: ata3: SATA link down (SStatus 0 SControl 300)
Dec 28 08:51:33 D-69-91-141-110 kernel: ata4: SATA link down (SStatus 0 SControl 300)
Dec 28 08:51:33 D-69-91-141-110 kernel: usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
Dec 28 08:51:33 D-69-91-141-110 kernel: usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Dec 28 08:51:33 D-69-91-141-110 kernel: usb usb6: Product: OHCI PCI host controller
Dec 28 08:51:33 D-69-91-141-110 kernel: usb usb6: Manufacturer: Linux 4.15.0-rc5-dou-p+ ohci_hcd
Dec 28 08:51:33 D-69-91-141-110 kernel: usb usb6: SerialNumber: 0000:00:13.4
Dec 28 08:51:33 D-69-91-141-110 kernel: hub 6-0:1.0: USB hub found
Dec 28 08:51:33 D-69-91-141-110 kernel: hub 6-0:1.0: 2 ports detected
Dec 28 08:51:33 D-69-91-141-110 kernel: ata1: softreset failed (device not ready)
Dec 28 08:51:33 D-69-91-141-110 kernel: ata1: applying PMP SRST workaround and retrying
Dec 28 08:51:33 D-69-91-141-110 kernel: usb 1-4: New USB device found, idVendor=0bda, idProduct=0116
Dec 28 08:51:33 D-69-91-141-110 kernel: usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
Dec 28 08:51:33 D-69-91-141-110 kernel: usb 1-4: Product: USB2.0-CRW
Dec 28 08:51:33 D-69-91-141-110 kernel: usb 1-4: Manufacturer: Generic
Dec 28 08:51:33 D-69-91-141-110 kernel: usb 1-4: SerialNumber: 20021111153705700
Dec 28 08:51:33 D-69-91-141-110 kernel: usb-storage 1-4:1.0: USB Mass Storage device detected
Dec 28 08:51:33 D-69-91-141-110 kernel: scsi host6: usb-storage 1-4:1.0
Dec 28 08:51:33 D-69-91-141-110 kernel: usbcore: registered new interface driver usb-storage
Dec 28 08:51:33 D-69-91-141-110 kernel: usbcore: registered new interface driver uas
Dec 28 08:51:33 D-69-91-141-110 kernel: usb 1-7: new high-speed USB device number 3 using ehci-pci
Dec 28 08:51:33 D-69-91-141-110 kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Dec 28 08:51:33 D-69-91-141-110 kernel: ata1.00: ATA-8: ST9250827AS, 3.AAA, max UDMA/133
Dec 28 08:51:33 D-69-91-141-110 kernel: ata1.00: 488397168 sectors, multi 16: LBA48 NCQ (depth 31/32)
Dec 28 08:51:33 D-69-91-141-110 kernel: ata1.00: SB600 AHCI: limiting to 255 sectors per cmd
Dec 28 08:51:33 D-69-91-141-110 kernel: ata1.00: SB600 AHCI: limiting to 255 sectors per cmd
Dec 28 08:51:33 D-69-91-141-110 kernel: ata1.00: configured for UDMA/133
Dec 28 08:51:33 D-69-91-141-110 kernel: scsi 0:0:0:0: Direct-Access     ATA      ST9250827AS      A    PQ: 0 ANSI: 5
Dec 28 08:51:33 D-69-91-141-110 kernel: scsi 4:0:0:0: CD-ROM            HL-DT-ST DVDRAM GSA-T40N  JR03 PQ: 0 ANSI: 5
Dec 28 08:51:33 D-69-91-141-110 kernel: sd 0:0:0:0: [sda] 488397168 512-byte logical blocks: (250 GB/233 GiB)
Dec 28 08:51:33 D-69-91-141-110 kernel: sd 0:0:0:0: [sda] Write Protect is off
Dec 28 08:51:33 D-69-91-141-110 kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Dec 28 08:51:33 D-69-91-141-110 kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Dec 28 08:51:33 D-69-91-141-110 kernel: sr 4:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
Dec 28 08:51:33 D-69-91-141-110 kernel: cdrom: Uniform CD-ROM driver Revision: 3.20
Dec 28 08:51:33 D-69-91-141-110 kernel: sr 4:0:0:0: Attached scsi CD-ROM sr0
Dec 28 08:51:33 D-69-91-141-110 kernel:  sda: sda1 sda2 < sda5 >
Dec 28 08:51:33 D-69-91-141-110 kernel: sd 0:0:0:0: [sda] Attached SCSI disk
Dec 28 08:51:33 D-69-91-141-110 kernel: usb 1-7: New USB device found, idVendor=174f, idProduct=5a31
Dec 28 08:51:33 D-69-91-141-110 kernel: usb 1-7: New USB device strings: Mfr=2, Product=1, SerialNumber=3
Dec 28 08:51:33 D-69-91-141-110 kernel: usb 1-7: Product: USB 2.0 Camera
Dec 28 08:51:33 D-69-91-141-110 kernel: usb 1-7: Manufacturer: Sonix Technology Co., Ltd.
Dec 28 08:51:33 D-69-91-141-110 kernel: usb 1-7: SerialNumber: SN0001
Dec 28 08:51:33 D-69-91-141-110 kernel: psmouse serio4: synaptics: Touchpad model: 1, fw: 6.1, id: 0xa3a0b3, caps: 0xa04713/0x10008/0x0/0x0, board id: 0, fw id: 30712
Dec 28 08:51:33 D-69-91-141-110 kernel: input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio4/input/input8
Dec 28 08:51:33 D-69-91-141-110 kernel: PM: Starting manual resume from disk
Dec 28 08:51:33 D-69-91-141-110 kernel: PM: Image not found (code -22)
Dec 28 08:51:33 D-69-91-141-110 kernel: scsi 6:0:0:0: Direct-Access     Generic- xD/SDMMC/MS/Pro  1.00 PQ: 0 ANSI: 0 CCS
Dec 28 08:51:33 D-69-91-141-110 kernel: EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
Dec 28 08:51:33 D-69-91-141-110 kernel: sd 6:0:0:0: [sdb] 62333952 512-byte logical blocks: (31.9 GB/29.7 GiB)
Dec 28 08:51:33 D-69-91-141-110 kernel: sd 6:0:0:0: [sdb] Write Protect is off
Dec 28 08:51:33 D-69-91-141-110 kernel: sd 6:0:0:0: [sdb] Mode Sense: 03 00 00 00
Dec 28 08:51:33 D-69-91-141-110 kernel: sd 6:0:0:0: [sdb] No Caching mode page found
Dec 28 08:51:33 D-69-91-141-110 kernel: sd 6:0:0:0: [sdb] Assuming drive cache: write through
Dec 28 08:51:33 D-69-91-141-110 kernel:  sdb: sdb1
Dec 28 08:51:33 D-69-91-141-110 kernel: sd 6:0:0:0: [sdb] Attached SCSI removable disk
Dec 28 08:51:33 D-69-91-141-110 kernel: random: crng init done
Dec 28 08:51:33 D-69-91-141-110 kernel: ip_tables: (C) 2000-2006 Netfilter Core Team
Dec 28 08:51:33 D-69-91-141-110 systemd[1]: systemd 232 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
Dec 28 08:51:33 D-69-91-141-110 systemd[1]: Detected architecture x86.
Dec 28 08:51:33 D-69-91-141-110 systemd[1]: Set hostname to <D-69-91-141-110>.
Dec 28 08:51:33 D-69-91-141-110 systemd[1]: Configuration file /etc/systemd/system/kdump.service is marked executable. Please remove executable permission bits. Proceeding anyway.
Dec 28 08:51:33 D-69-91-141-110 systemd[1]: Listening on udev Control Socket.
Dec 28 08:51:33 D-69-91-141-110 systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
Dec 28 08:51:33 D-69-91-141-110 systemd[1]: Created slice User and Session Slice.
Dec 28 08:51:33 D-69-91-141-110 systemd[1]: Listening on Syslog Socket.
Dec 28 08:51:33 D-69-91-141-110 systemd[1]: Listening on fsck to fsckd communication Socket.
Dec 28 08:51:33 D-69-91-141-110 systemd[1]: Reached target Remote File Systems.
Dec 28 08:51:33 D-69-91-141-110 systemd-journald[188]: Journal started
Dec 28 08:51:33 D-69-91-141-110 systemd-journald[188]: Runtime journal (/run/log/journal/232ecae4e62643e0ac09bafad7167a6f) is 3.3M, max 26.5M, 23.1M free.
Dec 28 08:51:33 D-69-91-141-110 systemd[1]: Mounted POSIX Message Queue File System.
Dec 28 08:51:33 D-69-91-141-110 systemd[1]: Mounted Huge Pages File System.
Dec 28 08:51:33 D-69-91-141-110 systemd[1]: Mounted Debug File System.
Dec 28 08:51:33 D-69-91-141-110 kernel: EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
Dec 28 08:51:33 D-69-91-141-110 systemd[1]: Started Remount Root and Kernel File Systems.
Dec 28 08:51:33 D-69-91-141-110 systemd[1]: Starting Load/Save Random Seed...
Dec 28 08:51:33 D-69-91-141-110 systemd[1]: Starting Flush Journal to Persistent Storage...
Dec 28 08:51:33 D-69-91-141-110 systemd[1]: Starting udev Coldplug all Devices...
Dec 28 08:51:34 D-69-91-141-110 systemd[1]: Started Load/Save Random Seed.
Dec 28 08:51:34 D-69-91-141-110 systemd-journald[188]: Time spent on flushing to /var is 1.416564s for 661 entries.
Dec 28 08:51:34 D-69-91-141-110 systemd-journald[188]: System journal (/var/log/journal/232ecae4e62643e0ac09bafad7167a6f) is 800.1M, max 2.5G, 1.7G free.
Dec 28 08:51:46 D-69-91-141-110 kernel: input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input9
Dec 28 08:51:46 D-69-91-141-110 kernel: ACPI: Lid Switch [LID]
Dec 28 08:51:46 D-69-91-141-110 kernel: input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input10
Dec 28 08:51:46 D-69-91-141-110 kernel: ACPI: Power Button [PWRB]
Dec 28 08:51:46 D-69-91-141-110 kernel: input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input11
Dec 28 08:51:46 D-69-91-141-110 kernel: ACPI: Sleep Button [SLPB]
Dec 28 08:51:46 D-69-91-141-110 kernel: input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input12
Dec 28 08:51:46 D-69-91-141-110 kernel: ACPI: Power Button [PWRF]
Dec 28 08:51:46 D-69-91-141-110 kernel: ACPI: Battery Slot [BAT0] (battery absent)
Dec 28 08:51:46 D-69-91-141-110 kernel: ACPI: AC Adapter [AC0] (on-line)
Dec 28 08:51:46 D-69-91-141-110 kernel: ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
Dec 28 08:51:46 D-69-91-141-110 kernel: acpi device:02: registered as cooling_device2
Dec 28 08:51:46 D-69-91-141-110 kernel: input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A03:00/device:00/LNXVIDEO:00/input/input13
Dec 28 08:51:46 D-69-91-141-110 kernel: shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
Dec 28 08:51:46 D-69-91-141-110 kernel: sd 0:0:0:0: Attached scsi generic sg0 type 0
Dec 28 08:51:46 D-69-91-141-110 kernel: sr 4:0:0:0: Attached scsi generic sg1 type 5
Dec 28 08:51:46 D-69-91-141-110 kernel: sd 6:0:0:0: Attached scsi generic sg2 type 0
Dec 28 08:51:46 D-69-91-141-110 kernel: sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver v0.05
Dec 28 08:51:46 D-69-91-141-110 kernel: sp5100_tco: PCI Vendor ID: 0x1002, Device ID: 0x4385, Revision ID: 0x13
Dec 28 08:51:46 D-69-91-141-110 kernel: sp5100_tco: failed to find MMIO address, giving up.
Dec 28 08:51:46 D-69-91-141-110 kernel: asus_laptop: Asus Laptop Support version 0.42
Dec 28 08:51:46 D-69-91-141-110 kernel: asus_laptop:   F5RL model detected
Dec 28 08:51:46 D-69-91-141-110 kernel: input: Asus Laptop extra buttons as /devices/platform/asus_laptop/input/input14
Dec 28 08:51:46 D-69-91-141-110 kernel: cfg80211: Loading compiled-in X.509 certificates for regulatory database
Dec 28 08:51:46 D-69-91-141-110 kernel: intel_powerclamp: No package C-state available
Dec 28 08:51:46 D-69-91-141-110 kernel: cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
Dec 28 08:51:46 D-69-91-141-110 kernel: platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
Dec 28 08:51:46 D-69-91-141-110 kernel: cfg80211: failed to load regulatory.db
Dec 28 08:51:46 D-69-91-141-110 kernel: input: PC Speaker as /devices/platform/pcspkr/input/input15
Dec 28 08:51:46 D-69-91-141-110 kernel: snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC660-VD: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
Dec 28 08:51:46 D-69-91-141-110 kernel: snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
Dec 28 08:51:46 D-69-91-141-110 kernel: snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
Dec 28 08:51:46 D-69-91-141-110 kernel: snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
Dec 28 08:51:46 D-69-91-141-110 kernel: snd_hda_codec_realtek hdaudioC0D0:    inputs:
Dec 28 08:51:46 D-69-91-141-110 kernel: snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x19
Dec 28 08:51:46 D-69-91-141-110 kernel: snd_hda_codec_realtek hdaudioC0D0:      Mic=0x18
Dec 28 08:51:46 D-69-91-141-110 kernel: [drm] radeon kernel modesetting enabled.
Dec 28 08:51:46 D-69-91-141-110 kernel: [drm] initializing kernel modesetting (RS400 0x1002:0x5A62 0x1043:0x1402 0x00).
Dec 28 08:51:46 D-69-91-141-110 kernel: resource sanity check: requesting [mem 0x000c0000-0x000dffff], which spans more than PCI Bus 0000:00 [mem 0x000d0000-0x000dffff window]
Dec 28 08:51:46 D-69-91-141-110 kernel: caller pci_map_rom+0x58/0xf0 mapping multiple BARs
Dec 28 08:51:46 D-69-91-141-110 kernel: [drm] Generation 2 PCI interface, using max accessible memory
Dec 28 08:51:46 D-69-91-141-110 kernel: radeon 0000:01:05.0: VRAM: 128M 0x00000000B8000000 - 0x00000000BFFFFFFF (128M used)
Dec 28 08:51:46 D-69-91-141-110 kernel: radeon 0000:01:05.0: GTT: 512M 0x0000000080000000 - 0x000000009FFFFFFF
Dec 28 08:51:46 D-69-91-141-110 kernel: [drm] Detected VRAM RAM=128M, BAR=256M
Dec 28 08:51:46 D-69-91-141-110 kernel: [drm] RAM width 128bits DDR
Dec 28 08:51:46 D-69-91-141-110 kernel: [TTM] Zone  kernel: Available graphics memory: 303872 kiB
Dec 28 08:51:46 D-69-91-141-110 kernel: [TTM] Zone highmem: Available graphics memory: 1357380 kiB
Dec 28 08:51:46 D-69-91-141-110 kernel: [TTM] Initializing pool allocator
Dec 28 08:51:46 D-69-91-141-110 kernel: [TTM] Initializing DMA pool allocator
Dec 28 08:51:46 D-69-91-141-110 kernel: [drm] radeon: 128M of VRAM memory ready
Dec 28 08:51:46 D-69-91-141-110 kernel: [drm] radeon: 512M of GTT memory ready.
Dec 28 08:51:46 D-69-91-141-110 kernel: [drm] GART: num cpu pages 131072, num gpu pages 131072
Dec 28 08:51:46 D-69-91-141-110 kernel: [drm] radeon: 3 quad pipes, 1 z pipes initialized.
Dec 28 08:51:46 D-69-91-141-110 kernel: [drm] PCIE GART of 512M enabled (table at 0x0000000036700000).
Dec 28 08:51:46 D-69-91-141-110 kernel: radeon 0000:01:05.0: WB enabled
Dec 28 08:51:46 D-69-91-141-110 kernel: radeon 0000:01:05.0: fence driver on ring 0 use gpu addr 0x0000000080000000 and cpu addr 0xd2c14725
Dec 28 08:51:46 D-69-91-141-110 kernel: [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
Dec 28 08:51:46 D-69-91-141-110 kernel: [drm] Driver supports precise vblank timestamp query.
Dec 28 08:51:46 D-69-91-141-110 kernel: radeon 0000:01:05.0: radeon: MSI limited to 32-bit
Dec 28 08:51:46 D-69-91-141-110 kernel: [drm] radeon: irq initialized.
Dec 28 08:51:46 D-69-91-141-110 kernel: [drm] Loading R300 Microcode
Dec 28 08:51:46 D-69-91-141-110 kernel: ath5k 0000:02:00.0: can't disable ASPM; OS doesn't have ASPM control
Dec 28 08:51:46 D-69-91-141-110 kernel: ath5k 0000:02:00.0: registered as 'phy0'
Dec 28 08:51:46 D-69-91-141-110 kernel: [drm] radeon: ring at 0x0000000080001000
Dec 28 08:51:46 D-69-91-141-110 kernel: [drm] ring test succeeded in 1 usecs
Dec 28 08:51:46 D-69-91-141-110 kernel: [drm] ib test succeeded in 0 usecs
Dec 28 08:51:46 D-69-91-141-110 kernel: [drm] Panel ID String: AUO                     
Dec 28 08:51:46 D-69-91-141-110 kernel: [drm] Panel Size 1280x800
Dec 28 08:51:46 D-69-91-141-110 kernel: [drm] Radeon Display Connectors
Dec 28 08:51:46 D-69-91-141-110 kernel: [drm] Connector 0:
Dec 28 08:51:46 D-69-91-141-110 kernel: [drm]   VGA-1
Dec 28 08:51:46 D-69-91-141-110 kernel: [drm]   DDC: 0x68 0x68 0x68 0x68 0x68 0x68 0x68 0x68
Dec 28 08:51:46 D-69-91-141-110 kernel: [drm]   Encoders:
Dec 28 08:51:46 D-69-91-141-110 kernel: [drm]     CRT1: INTERNAL_DAC2
Dec 28 08:51:46 D-69-91-141-110 kernel: [drm] Connector 1:
Dec 28 08:51:46 D-69-91-141-110 kernel: [drm]   LVDS-1
Dec 28 08:51:46 D-69-91-141-110 kernel: [drm]   DDC: 0x198 0x198 0x19c 0x19c 0x1a0 0x1a0 0x1a4 0x1a4
Dec 28 08:51:46 D-69-91-141-110 kernel: [drm]   Encoders:
Dec 28 08:51:46 D-69-91-141-110 kernel: [drm]     LCD1: INTERNAL_LVDS
Dec 28 08:51:46 D-69-91-141-110 kernel: [drm] fb mappable at 0xC0040000
Dec 28 08:51:46 D-69-91-141-110 kernel: [drm] vram apper at 0xC0000000
Dec 28 08:51:46 D-69-91-141-110 kernel: [drm] size 4096000
Dec 28 08:51:46 D-69-91-141-110 kernel: [drm] fb depth is 24
Dec 28 08:51:46 D-69-91-141-110 kernel: [drm]    pitch is 5120
Dec 28 08:51:46 D-69-91-141-110 kernel: fbcon: radeondrmfb (fb0) is primary device
Dec 28 08:51:46 D-69-91-141-110 kernel: Console: switching to colour frame buffer device 160x50
Dec 28 08:51:46 D-69-91-141-110 kernel: radeon 0000:01:05.0: fb0: radeondrmfb frame buffer device
Dec 28 08:51:46 D-69-91-141-110 kernel: [drm] Initialized radeon 2.50.0 20080528 for 0000:01:05.0 on minor 0
Dec 28 08:51:46 D-69-91-141-110 kernel: ath: EEPROM regdomain: 0x60
Dec 28 08:51:46 D-69-91-141-110 kernel: ath: EEPROM indicates we should expect a direct regpair map
Dec 28 08:51:46 D-69-91-141-110 kernel: ath: Country alpha2 being used: 00
Dec 28 08:51:46 D-69-91-141-110 kernel: ath: Regpair used: 0x60
Dec 28 08:51:46 D-69-91-141-110 kernel: ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
Dec 28 08:51:46 D-69-91-141-110 kernel: ath5k: phy0: Atheros AR2425 chip found (MAC: 0xe2, PHY: 0x70)
Dec 28 08:51:46 D-69-91-141-110 kernel: input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:14.2/sound/card0/input16
Dec 28 08:51:46 D-69-91-141-110 kernel: input: HDA ATI SB Mic as /devices/pci0000:00/0000:00:14.2/sound/card0/input17
Dec 28 08:51:46 D-69-91-141-110 kernel: input: HDA ATI SB Headphone as /devices/pci0000:00/0000:00:14.2/sound/card0/input18
Dec 28 08:51:46 D-69-91-141-110 kernel: media: Linux media interface: v0.10
Dec 28 08:51:46 D-69-91-141-110 kernel: Linux video capture interface: v2.00
Dec 28 08:51:46 D-69-91-141-110 kernel: uvcvideo: Found UVC 1.00 device USB 2.0 Camera (174f:5a31)
Dec 28 08:51:46 D-69-91-141-110 kernel: uvcvideo 1-7:1.0: Entity type for entity Extension 4 was not initialized!
Dec 28 08:51:46 D-69-91-141-110 kernel: uvcvideo 1-7:1.0: Entity type for entity Processing 3 was not initialized!
Dec 28 08:51:46 D-69-91-141-110 kernel: uvcvideo 1-7:1.0: Entity type for entity Camera 1 was not initialized!
Dec 28 08:51:46 D-69-91-141-110 kernel: input: USB 2.0 Camera: USB 2.0 Camera as /devices/pci0000:00/0000:00:13.5/usb1/1-7/1-7:1.0/input/input19
Dec 28 08:51:46 D-69-91-141-110 kernel: usbcore: registered new interface driver uvcvideo
Dec 28 08:51:46 D-69-91-141-110 kernel: USB Video Class driver (1.1.1)
Dec 28 08:51:46 D-69-91-141-110 kernel: Adding 3929084k swap on /dev/sda5.  Priority:-2 extents:1 across:3929084k FS
Dec 28 08:51:46 D-69-91-141-110 kernel: FAT-fs (sdb1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
Dec 28 08:51:41 D-69-91-141-110 mtp-probe[273]: checking bus 1, device 3: "/sys/devices/pci0000:00/0000:00:13.5/usb1/1-7"
Dec 28 08:51:34 D-69-91-141-110 systemd[1]: Started udev Coldplug all Devices.
Dec 28 08:51:41 D-69-91-141-110 mtp-probe[270]: checking bus 1, device 2: "/sys/devices/pci0000:00/0000:00:13.5/usb1/1-4"
Dec 28 08:51:34 D-69-91-141-110 systemd[1]: Started Set the console keyboard layout.
Dec 28 08:51:41 D-69-91-141-110 mtp-probe[270]: bus: 1, device: 2 was not an MTP device
Dec 28 08:51:34 D-69-91-141-110 systemd[1]: Started Create Static Device Nodes in /dev.
Dec 28 08:51:41 D-69-91-141-110 mtp-probe[273]: bus: 1, device: 3 was not an MTP device
Dec 28 08:51:34 D-69-91-141-110 systemd[1]: Reached target Local File Systems (Pre).
Dec 28 08:51:34 D-69-91-141-110 systemd[1]: Reached target Local File Systems.
Dec 28 08:51:34 D-69-91-141-110 systemd[1]: Starting Raise network interfaces...
Dec 28 08:51:34 D-69-91-141-110 systemd[1]: Starting Set console font and keymap...
Dec 28 08:51:34 D-69-91-141-110 systemd[1]: Starting udev Kernel Device Manager...
Dec 28 08:51:35 D-69-91-141-110 systemd[1]: Started Set console font and keymap.
Dec 28 08:51:37 D-69-91-141-110 systemd[1]: Started udev Kernel Device Manager.
Dec 28 08:51:40 D-69-91-141-110 systemd[1]: Listening on Load/Save RF Kill Switch Status /dev/rfkill Watch.
Dec 28 08:51:41 D-69-91-141-110 systemd[1]: Created slice system-systemd\x2dbacklight.slice.
Dec 28 08:51:41 D-69-91-141-110 systemd[1]: Starting Load/Save Screen Backlight Brightness of backlight:acpi_video0...
Dec 28 08:51:41 D-69-91-141-110 systemd[1]: Started Raise network interfaces.
Dec 28 08:51:41 D-69-91-141-110 systemd[1]: Reached target Network.
Dec 28 08:51:41 D-69-91-141-110 systemd[1]: Reached target Network is Online.
Dec 28 08:51:41 D-69-91-141-110 systemd[1]: Starting Load/Save RF Kill Switch Status...
Dec 28 08:51:41 D-69-91-141-110 systemd[1]: Started Load/Save Screen Backlight Brightness of backlight:acpi_video0.
Dec 28 08:51:41 D-69-91-141-110 systemd[1]: Found device ST9250827AS 5.
Dec 28 08:51:41 D-69-91-141-110 systemd[1]: Activating swap /dev/disk/by-uuid/5e6263b1-75fa-4003-bc51-9dd4c11f7177...
Dec 28 08:51:43 D-69-91-141-110 systemd[1]: Reached target Sound Card.
Dec 28 08:51:43 D-69-91-141-110 systemd[1]: Activated swap /dev/disk/by-uuid/5e6263b1-75fa-4003-bc51-9dd4c11f7177.
Dec 28 08:51:43 D-69-91-141-110 systemd[1]: Reached target Swap.
Dec 28 08:51:44 D-69-91-141-110 systemd[1]: Started Load/Save RF Kill Switch Status.
Dec 28 08:51:45 D-69-91-141-110 systemd-udevd[244]: Process '/sbin/crda' failed with exit code 249.
Dec 28 08:51:46 D-69-91-141-110 systemd[1]: Started Flush Journal to Persistent Storage.
Dec 28 08:51:46 D-69-91-141-110 systemd[1]: Starting Create Volatile Files and Directories...
Dec 28 08:51:46 D-69-91-141-110 systemd-tmpfiles[421]: Cannot set file attribute for '/var/log/journal', value=0x00800000, mask=0x00800000: Operation not supported
Dec 28 08:51:46 D-69-91-141-110 systemd-tmpfiles[421]: Cannot set file attribute for '/var/log/journal/232ecae4e62643e0ac09bafad7167a6f', value=0x00800000, mask=0x00800000: Operation not supported
Dec 28 08:51:46 D-69-91-141-110 systemd[1]: Started Create Volatile Files and Directories.
Dec 28 08:51:47 D-69-91-141-110 systemd[1]: Starting Network Time Synchronization...
Dec 28 08:51:47 D-69-91-141-110 systemd[1]: Starting Update UTMP about System Boot/Shutdown...
Dec 28 08:51:47 D-69-91-141-110 systemd[1]: Started Update UTMP about System Boot/Shutdown.
Dec 28 08:51:47 D-69-91-141-110 systemd[1]: Started Network Time Synchronization.
Dec 28 08:51:47 D-69-91-141-110 systemd[1]: Reached target System Initialization.
Dec 28 08:51:47 D-69-91-141-110 systemd[1]: Started Daily Cleanup of Temporary Directories.
Dec 28 08:51:47 D-69-91-141-110 systemd[1]: Listening on D-Bus System Message Bus Socket.
Dec 28 08:51:47 D-69-91-141-110 systemd[1]: Listening on ACPID Listen Socket.
Dec 28 08:51:47 D-69-91-141-110 systemd[1]: Started ACPI Events Check.
Dec 28 08:51:47 D-69-91-141-110 systemd[1]: Reached target Paths.
Dec 28 08:51:47 D-69-91-141-110 systemd[1]: Listening on Avahi mDNS/DNS-SD Stack Activation Socket.
Dec 28 08:51:47 D-69-91-141-110 systemd[1]: Reached target Sockets.
Dec 28 08:51:47 D-69-91-141-110 systemd[1]: Reached target Basic System.
Dec 28 08:51:47 D-69-91-141-110 systemd[1]: Started ACPI event daemon.
Dec 28 08:51:47 D-69-91-141-110 systemd[1]: Starting Load dump capture kernel...
Dec 28 08:51:47 D-69-91-141-110 systemd[1]: Starting Login Service...
Dec 28 08:51:47 D-69-91-141-110 systemd[1]: Starting Modem Manager...
Dec 28 08:51:47 D-69-91-141-110 systemd[1]: Starting keep memory of all UPnP devices that announced themselves...
Dec 28 08:51:47 D-69-91-141-110 minissdpd[431]: setsockopt(udp, IP_ADD_MEMBERSHIP)(0.0.0.0): No such device
Dec 28 08:51:47 D-69-91-141-110 minissdpd[431]: Failed to add IPv4 multicast membership for interface 0.0.0.0.
Dec 28 08:51:47 D-69-91-141-110 systemd[1]: Started irqbalance daemon.
Dec 28 08:51:47 D-69-91-141-110 acpid[427]: starting up with netlink and the input layer
Dec 28 08:51:47 D-69-91-141-110 systemd[1]: Started Regular background program processing daemon.
Dec 28 08:51:47 D-69-91-141-110 systemd[1]: Starting Permit User Sessions...
Dec 28 08:51:47 D-69-91-141-110 systemd[1]: Starting OpenBSD Secure Shell server...
Dec 28 08:51:47 D-69-91-141-110 systemd[1]: Starting System Logging Service...
Dec 28 08:51:47 D-69-91-141-110 systemd[1]: Starting Restore /etc/resolv.conf if the system crashed before the ppp link was shut down...
Dec 28 08:51:47 D-69-91-141-110 systemd[1]: Starting /etc/rc.local Compatibility...
Dec 28 08:51:47 D-69-91-141-110 systemd[1]: Starting Save/Restore Sound Card State...
Dec 28 08:51:47 D-69-91-141-110 systemd[1]: Started D-Bus System Message Bus.
Dec 28 08:51:47 D-69-91-141-110 acpid[427]: 1 rule loaded
Dec 28 08:51:47 D-69-91-141-110 acpid[427]: waiting for events: event logging is off
Dec 28 08:51:47 D-69-91-141-110 cron[434]: (CRON) INFO (pidfile fd = 3)
Dec 28 08:51:48 D-69-91-141-110 cron[434]: (CRON) INFO (Running @reboot jobs)
Dec 28 08:51:49 D-69-91-141-110 ModemManager[430]: <info>  ModemManager (version 1.6.4) starting in system bus...
Dec 28 08:51:49 D-69-91-141-110 liblogging-stdlog[437]:  [origin software="rsyslogd" swVersion="8.24.0" x-pid="437" x-info="http://www.rsyslog.com"] start
Dec 28 08:51:50 D-69-91-141-110 sshd[436]: /etc/ssh/sshd_config line 19: Deprecated option KeyRegenerationInterval
Dec 28 08:51:50 D-69-91-141-110 sshd[436]: /etc/ssh/sshd_config line 20: Deprecated option ServerKeyBits
Dec 28 08:51:50 D-69-91-141-110 sshd[436]: /etc/ssh/sshd_config line 31: Deprecated option RSAAuthentication
Dec 28 08:51:50 D-69-91-141-110 sshd[436]: /etc/ssh/sshd_config line 38: Deprecated option RhostsRSAAuthentication
Dec 28 08:51:50 D-69-91-141-110 dbus[441]: [system] Successfully activated service 'org.freedesktop.systemd1'
Dec 28 08:51:50 D-69-91-141-110 systemd[1]: Starting LSB: Starts and stops Wicd...
Dec 28 08:51:50 D-69-91-141-110 systemd[1]: Starting Avahi mDNS/DNS-SD Stack...
Dec 28 08:51:50 D-69-91-141-110 systemd[1]: Reached target System Time Synchronized.
Dec 28 08:51:50 D-69-91-141-110 systemd[1]: apt-daily.timer: Adding 10h 44min 57.970991s random time.
Dec 28 08:51:50 D-69-91-141-110 systemd[1]: Started Daily apt download activities.
Dec 28 08:51:50 D-69-91-141-110 systemd[1]: anacron.timer: Adding 4min 45.337943s random time.
Dec 28 08:51:50 D-69-91-141-110 systemd[1]: Started Trigger anacron every hour.
Dec 28 08:51:50 D-69-91-141-110 systemd[1]: Started Run anacron jobs.
Dec 28 08:51:50 D-69-91-141-110 systemd[1]: anacron.timer: Adding 3min 50.414296s random time.
Dec 28 08:51:50 D-69-91-141-110 systemd[1]: anacron.timer: Adding 1min 58.221434s random time.
Dec 28 08:51:50 D-69-91-141-110 systemd[1]: apt-daily-upgrade.timer: Adding 31min 1.211607s random time.
Dec 28 08:51:50 D-69-91-141-110 systemd[1]: Started Daily apt upgrade and clean activities.
Dec 28 08:51:50 D-69-91-141-110 systemd[1]: Reached target Timers.
Dec 28 08:51:50 D-69-91-141-110 systemd[1]: Starting LSB: exim Mail Transport Agent...
Dec 28 08:51:50 D-69-91-141-110 systemd[1]: Started System Logging Service.
Dec 28 08:51:50 D-69-91-141-110 systemd[1]: Started keep memory of all UPnP devices that announced themselves.
Dec 28 08:51:50 D-69-91-141-110 systemd[1]: Started Permit User Sessions.
Dec 28 08:51:50 D-69-91-141-110 systemd[1]: Started Restore /etc/resolv.conf if the system crashed before the ppp link was shut down.
Dec 28 08:51:50 D-69-91-141-110 systemd[1]: Started /etc/rc.local Compatibility.
Dec 28 08:51:50 D-69-91-141-110 systemd[1]: Started Save/Restore Sound Card State.
Dec 28 08:51:50 D-69-91-141-110 systemd-logind[429]: New seat seat0.
Dec 28 08:51:50 D-69-91-141-110 systemd-logind[429]: Watching system buttons on /dev/input/event5 (Power Button)
Dec 28 08:51:50 D-69-91-141-110 systemd-logind[429]: Watching system buttons on /dev/input/event6 (Video Bus)
Dec 28 08:51:50 D-69-91-141-110 systemd-logind[429]: Watching system buttons on /dev/input/event3 (Power Button)
Dec 28 08:51:50 D-69-91-141-110 systemd-logind[429]: Watching system buttons on /dev/input/event2 (Lid Switch)
Dec 28 08:51:50 D-69-91-141-110 systemd-logind[429]: Watching system buttons on /dev/input/event4 (Sleep Button)
Dec 28 08:51:50 D-69-91-141-110 systemd[1]: Started Login Service.
Dec 28 08:51:50 D-69-91-141-110 systemd[1]: Started Getty on tty1.
Dec 28 08:51:50 D-69-91-141-110 sshd[462]: /etc/ssh/sshd_config line 19: Deprecated option KeyRegenerationInterval
Dec 28 08:51:50 D-69-91-141-110 sshd[462]: /etc/ssh/sshd_config line 20: Deprecated option ServerKeyBits
Dec 28 08:51:50 D-69-91-141-110 sshd[462]: /etc/ssh/sshd_config line 31: Deprecated option RSAAuthentication
Dec 28 08:51:50 D-69-91-141-110 sshd[462]: /etc/ssh/sshd_config line 38: Deprecated option RhostsRSAAuthentication
Dec 28 08:51:50 D-69-91-141-110 systemd[1]: Reached target Login Prompts.
Dec 28 08:51:50 D-69-91-141-110 sshd[462]: Server listening on 0.0.0.0 port 2200.
Dec 28 08:51:50 D-69-91-141-110 sshd[462]: Server listening on :: port 2200.
Dec 28 08:51:50 D-69-91-141-110 systemd[1]: Started OpenBSD Secure Shell server.
Dec 28 08:51:50 D-69-91-141-110 dbus[441]: [system] Activating via systemd: service name='org.freedesktop.PolicyKit1' unit='polkit.service'
Dec 28 08:51:50 D-69-91-141-110 anacron[459]: Anacron 2.3 started on 2017-12-28
Dec 28 08:51:51 D-69-91-141-110 anacron[459]: Normal exit (0 jobs run)
Dec 28 08:51:51 D-69-91-141-110 systemd[1]: anacron.timer: Adding 52.537572s random time.
Dec 28 08:51:51 D-69-91-141-110 systemd[1]: Starting Authorization Manager...
Dec 28 08:51:51 D-69-91-141-110 avahi-daemon[456]: Found user 'avahi' (UID 106) and group 'avahi' (GID 112).
Dec 28 08:51:51 D-69-91-141-110 avahi-daemon[456]: Successfully dropped root privileges.
Dec 28 08:51:51 D-69-91-141-110 avahi-daemon[456]: avahi-daemon 0.6.32 starting up.
Dec 28 08:51:51 D-69-91-141-110 systemd[1]: Started Avahi mDNS/DNS-SD Stack.
Dec 28 08:51:51 D-69-91-141-110 avahi-daemon[456]: Successfully called chroot().
Dec 28 08:51:51 D-69-91-141-110 avahi-daemon[456]: Successfully dropped remaining capabilities.
Dec 28 08:51:51 D-69-91-141-110 avahi-daemon[456]: No service file found in /etc/avahi/services.
Dec 28 08:51:51 D-69-91-141-110 avahi-daemon[456]: Network interface enumeration completed.
Dec 28 08:51:51 D-69-91-141-110 avahi-daemon[456]: Server startup complete. Host name is D-69-91-141-110.local. Local service cookie is 3814044347.
Dec 28 08:51:52 D-69-91-141-110 polkitd[470]: started daemon version 0.105 using authority implementation `local' version `0.105'
Dec 28 08:51:52 D-69-91-141-110 dbus[441]: [system] Successfully activated service 'org.freedesktop.PolicyKit1'
Dec 28 08:51:52 D-69-91-141-110 systemd[1]: Started Authorization Manager.
Dec 28 08:51:52 D-69-91-141-110 systemd[1]: Started Modem Manager.
Dec 28 08:51:53 D-69-91-141-110 systemd[1]: Started Load dump capture kernel.
Dec 28 08:51:55 D-69-91-141-110 wicd[455]: Starting Network connection manager: wicd.
Dec 28 08:51:55 D-69-91-141-110 systemd[1]: Started LSB: Starts and stops Wicd.
Dec 28 08:51:55 D-69-91-141-110 ModemManager[430]: <info>  Couldn't check support for device at '/sys/devices/pci0000:00/0000:00:04.0/0000:02:00.0': not supported by any plugin
Dec 28 08:51:55 D-69-91-141-110 ModemManager[430]: <info>  Couldn't check support for device at '/sys/devices/pci0000:00/0000:00:06.0/0000:06:00.0': not supported by any plugin
Dec 28 08:51:55 D-69-91-141-110 exim4[460]: Starting MTA: exim4.
Dec 28 08:51:55 D-69-91-141-110 systemd[1]: Started LSB: exim Mail Transport Agent.
Dec 28 08:51:55 D-69-91-141-110 systemd[1]: Reached target Multi-User System.
Dec 28 08:51:55 D-69-91-141-110 systemd[1]: Starting Update UTMP about System Runlevel Changes...
Dec 28 08:51:55 D-69-91-141-110 systemd[1]: Started Update UTMP about System Runlevel Changes.
Dec 28 08:51:55 D-69-91-141-110 systemd[1]: Startup finished in 6.326s (kernel) + 24.892s (userspace) = 31.219s.
Dec 28 08:51:55 D-69-91-141-110 kernel: NET: Registered protocol family 4
Dec 28 08:51:55 D-69-91-141-110 kernel: NET: Registered protocol family 3
Dec 28 08:51:55 D-69-91-141-110 kernel: NET: Registered protocol family 5
Dec 28 08:51:55 D-69-91-141-110 kernel: IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
Dec 28 08:52:01 D-69-91-141-110 login[463]: pam_unix(login:session): session opened for user chirvasitua by LOGIN(uid=0)
Dec 28 08:52:01 D-69-91-141-110 systemd[1]: Created slice User Slice of chirvasitua.
Dec 28 08:52:01 D-69-91-141-110 systemd[1]: Starting User Manager for UID 1000...
Dec 28 08:52:01 D-69-91-141-110 systemd-logind[429]: New session 1 of user chirvasitua.
Dec 28 08:52:01 D-69-91-141-110 systemd[1]: Started Session 1 of user chirvasitua.
Dec 28 08:52:01 D-69-91-141-110 systemd[750]: pam_unix(systemd-user:session): session opened for user chirvasitua by (uid=0)
Dec 28 08:52:01 D-69-91-141-110 systemd[750]: Reached target Timers.
Dec 28 08:52:01 D-69-91-141-110 kernel: spurious APIC interrupt through vector ff on CPU#0, should never happen.
Dec 28 08:52:01 D-69-91-141-110 kernel: IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
Dec 28 08:52:01 D-69-91-141-110 systemd[750]: Starting D-Bus User Message Bus Socket.
Dec 28 08:52:01 D-69-91-141-110 systemd[750]: Listening on GnuPG network certificate management daemon.
Dec 28 08:52:01 D-69-91-141-110 systemd[750]: Listening on GnuPG cryptographic agent (ssh-agent emulation).
Dec 28 08:52:01 D-69-91-141-110 systemd[750]: Reached target Paths.
Dec 28 08:52:01 D-69-91-141-110 systemd[750]: Listening on GnuPG cryptographic agent and passphrase cache (restricted).
Dec 28 08:52:01 D-69-91-141-110 systemd[750]: Listening on GnuPG cryptographic agent and passphrase cache.
Dec 28 08:52:01 D-69-91-141-110 systemd[750]: Listening on GnuPG cryptographic agent (access for web browsers).
Dec 28 08:52:01 D-69-91-141-110 systemd[750]: Listening on D-Bus User Message Bus Socket.
Dec 28 08:52:01 D-69-91-141-110 systemd[750]: Reached target Sockets.
Dec 28 08:52:01 D-69-91-141-110 systemd[750]: Reached target Basic System.
Dec 28 08:52:01 D-69-91-141-110 systemd[750]: Reached target Default.
Dec 28 08:52:01 D-69-91-141-110 systemd[750]: Startup finished in 279ms.
Dec 28 08:52:01 D-69-91-141-110 systemd[1]: Started User Manager for UID 1000.
Dec 28 08:52:09 D-69-91-141-110 su[798]: Successful su for root by chirvasitua
Dec 28 08:52:09 D-69-91-141-110 su[798]: + /dev/tty1 chirvasitua:root
Dec 28 08:52:09 D-69-91-141-110 su[798]: pam_unix(su:session): session opened for user root by chirvasitua(uid=1000)
Dec 28 08:52:09 D-69-91-141-110 su[798]: pam_systemd(su:session): Cannot create session: Already running in a session
Dec 28 08:52:22 D-69-91-141-110 kernel: INFO: rcu_sched detected stalls on CPUs/tasks:
Dec 28 08:52:22 D-69-91-141-110 kernel:         0-...!: (0 ticks this GP) idle=e64/0/0 softirq=5073/5073 fqs=0 
Dec 28 08:52:22 D-69-91-141-110 kernel:         (detected by 1, t=5252 jiffies, g=2134, c=2133, q=3355)
Dec 28 08:52:22 D-69-91-141-110 kernel: Sending NMI from CPU 1 to CPUs 0:
Dec 28 08:52:22 D-69-91-141-110 kernel: NMI backtrace for cpu 0
Dec 28 08:52:22 D-69-91-141-110 kernel: CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W        4.15.0-rc5-dou-p+ #1
Dec 28 08:52:22 D-69-91-141-110 kernel: Hardware name: ASUSTeK Computer Inc. F5RL                /F5RL      , BIOS 210     06/12/2008
Dec 28 08:52:22 D-69-91-141-110 kernel: EIP: tick_check_broadcast_expired+0x10/0x20
Dec 28 08:52:22 D-69-91-141-110 kernel: EFLAGS: 00000247 CPU: 0
Dec 28 08:52:22 D-69-91-141-110 kernel: EAX: 00000000 EBX: d2792180 ECX: d28bbf28 EDX: 0002ae62
Dec 28 08:52:22 D-69-91-141-110 kernel: ESI: d2792180 EDI: 00000000 EBP: d278df24 ESP: d278df24
Dec 28 08:52:22 D-69-91-141-110 kernel:  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
Dec 28 08:52:22 D-69-91-141-110 kernel: CR0: 80050033 CR2: 0a04ec30 CR3: 36d65d00 CR4: 000006f0
Dec 28 08:52:22 D-69-91-141-110 kernel: Call Trace:
Dec 28 08:52:22 D-69-91-141-110 kernel:  cpu_idle_poll+0x46/0x130
Dec 28 08:52:22 D-69-91-141-110 kernel:  do_idle+0x3d/0x1a0
Dec 28 08:52:22 D-69-91-141-110 kernel:  cpu_startup_entry+0x65/0x70
Dec 28 08:52:22 D-69-91-141-110 kernel:  rest_init+0x86/0x90
Dec 28 08:52:22 D-69-91-141-110 kernel:  start_kernel+0x371/0x38a
Dec 28 08:52:22 D-69-91-141-110 kernel:  i386_start_kernel+0x95/0x99
Dec 28 08:52:22 D-69-91-141-110 kernel:  startup_32_smp+0x164/0x168
Dec 28 08:52:22 D-69-91-141-110 kernel: Code: 91 4e 00 5b 5e 5d c3 8d 74 26 00 55 b8 60 26 90 d2 89 e5 5d c3 8d b6 00 00 00 00 55 64 a1 00 61 8b d2 89 e5 0f a3 05 58 26 90 d2 <0f> 92 c0 0f b6 c0 5d c3 90 8d b4 26 00 00 00 00 64 a1 00 61 8b
Dec 28 08:52:22 D-69-91-141-110 kernel: rcu_sched kthread starved for 5252 jiffies! g2134 c2133 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=0
Dec 28 08:52:22 D-69-91-141-110 kernel: rcu_sched       I    0     8      2 0x80000000
Dec 28 08:52:22 D-69-91-141-110 kernel: Call Trace:
Dec 28 08:52:22 D-69-91-141-110 kernel:  __schedule+0x3f9/0x880
Dec 28 08:52:22 D-69-91-141-110 kernel:  schedule+0x29/0x70
Dec 28 08:52:22 D-69-91-141-110 kernel:  schedule_timeout+0x12d/0x2f0
Dec 28 08:52:22 D-69-91-141-110 kernel:  ? __next_timer_interrupt+0xc0/0xc0
Dec 28 08:52:22 D-69-91-141-110 kernel:  rcu_gp_kthread+0x472/0x7a0
Dec 28 08:52:22 D-69-91-141-110 kernel:  kthread+0xd0/0x100
Dec 28 08:52:22 D-69-91-141-110 kernel:  ? call_rcu_sched+0x20/0x20
Dec 28 08:52:22 D-69-91-141-110 kernel:  ? kthread_associate_blkcg+0x90/0x90
Dec 28 08:52:22 D-69-91-141-110 kernel:  ret_from_fork+0x19/0x24
Dec 28 08:52:44 D-69-91-141-110 kernel: NMI watchdog: Watchdog detected hard LOCKUP on cpu 0
Dec 28 08:52:44 D-69-91-141-110 kernel: Modules linked in: appletalk ax25 ipx p8023 p8022 psnap llc nls_ascii nls_cp437 vfat fat uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_core videodev media snd_hda_codec_si3054 arc4 ath5k radeon snd_hda_codec_realtek snd_hda_codec_generic ath snd_hda_intel mac80211 snd_hda_codec snd_hda_core snd_hwdep snd_pcsp snd_pcm snd_timer coretemp ttm cfg80211 drm_kms_helper asus_laptop drm snd soundcore i2c_algo_bit joydev evdev sparse_keymap serio_raw rfkill fb_sys_fops syscopyarea sysfillrect sysimgblt sp5100_tco input_polldev sg shpchp video ac battery button acpi_cpufreq ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 fscrypto sr_mod cdrom sd_mod ata_generic uas usb_storage ohci_pci psmouse pata_atiixp i2c_piix4 ahci libahci ehci_pci ohci_hcd libata ehci_hcd usbcore
Dec 28 08:52:44 D-69-91-141-110 kernel:  scsi_mod atl2 thermal
Dec 28 08:52:44 D-69-91-141-110 kernel: CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W        4.15.0-rc5-dou-p+ #1
Dec 28 08:52:44 D-69-91-141-110 kernel: Hardware name: ASUSTeK Computer Inc. F5RL                /F5RL      , BIOS 210     06/12/2008
Dec 28 08:52:44 D-69-91-141-110 kernel: EIP: cpu_idle_poll+0x41/0x130
Dec 28 08:52:44 D-69-91-141-110 kernel: EFLAGS: 00000246 CPU: 0
Dec 28 08:52:44 D-69-91-141-110 kernel: EAX: 00000000 EBX: d2792180 ECX: d28bbf28 EDX: 0002af32
Dec 28 08:52:44 D-69-91-141-110 kernel: ESI: d2792180 EDI: 00000000 EBP: d278df38 ESP: d278df2c
Dec 28 08:52:44 D-69-91-141-110 kernel:  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
Dec 28 08:52:44 D-69-91-141-110 kernel: CR0: 80050033 CR2: b70cc480 CR3: 36d65d00 CR4: 000006f0
Dec 28 08:52:44 D-69-91-141-110 kernel: Call Trace:
Dec 28 08:52:44 D-69-91-141-110 kernel:  do_idle+0x3d/0x1a0
Dec 28 08:52:44 D-69-91-141-110 kernel:  cpu_startup_entry+0x65/0x70
Dec 28 08:52:44 D-69-91-141-110 kernel:  rest_init+0x86/0x90
Dec 28 08:52:44 D-69-91-141-110 kernel:  start_kernel+0x371/0x38a
Dec 28 08:52:44 D-69-91-141-110 kernel:  i386_start_kernel+0x95/0x99
Dec 28 08:52:44 D-69-91-141-110 kernel:  startup_32_smp+0x164/0x168
Dec 28 08:52:44 D-69-91-141-110 kernel: Code: 90 fb 64 8b 1d 3c 79 8b d2 8b 03 a8 08 74 13 eb 23 89 f6 8d bc 27 00 00 00 00 f3 90 8b 03 a8 08 75 12 a1 10 c5 81 d2 85 c0 75 ef <e8> aa 73 b1 ff 85 c0 75 e6 64 8b 3d 00 61 8b d2 66 66 66 66 90
Dec 28 08:52:44 D-69-91-141-110 kernel: perf: interrupt took too long (2611 > 2500), lowering kernel.perf_event_max_sample_rate to 76500
Dec 28 08:53:25 D-69-91-141-110 kernel: INFO: rcu_sched detected stalls on CPUs/tasks:
Dec 28 08:53:25 D-69-91-141-110 kernel:         0-...!: (0 ticks this GP) idle=340/0/0 softirq=5073/5073 fqs=1 
Dec 28 08:53:25 D-69-91-141-110 kernel:         (detected by 1, t=21007 jiffies, g=2134, c=2133, q=4647)
Dec 28 08:53:25 D-69-91-141-110 kernel: Sending NMI from CPU 1 to CPUs 0:
Dec 28 08:53:25 D-69-91-141-110 kernel: NMI backtrace for cpu 0 skipped: idling at cpu_idle_poll+0x32/0x130
Dec 28 08:53:25 D-69-91-141-110 kernel: rcu_sched kthread starved for 15755 jiffies! g2134 c2133 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=0
Dec 28 08:53:25 D-69-91-141-110 kernel: rcu_sched       I    0     8      2 0x80000000
Dec 28 08:53:25 D-69-91-141-110 kernel: Call Trace:
Dec 28 08:53:25 D-69-91-141-110 kernel:  __schedule+0x3f9/0x880
Dec 28 08:53:25 D-69-91-141-110 kernel:  schedule+0x29/0x70
Dec 28 08:53:25 D-69-91-141-110 kernel:  schedule_timeout+0x12d/0x2f0
Dec 28 08:53:25 D-69-91-141-110 kernel:  ? __next_timer_interrupt+0xc0/0xc0
Dec 28 08:53:25 D-69-91-141-110 kernel:  rcu_gp_kthread+0x472/0x7a0
Dec 28 08:53:25 D-69-91-141-110 kernel:  kthread+0xd0/0x100
Dec 28 08:53:25 D-69-91-141-110 kernel:  ? call_rcu_sched+0x20/0x20
Dec 28 08:53:25 D-69-91-141-110 kernel:  ? kthread_associate_blkcg+0x90/0x90
Dec 28 08:53:25 D-69-91-141-110 kernel:  ret_from_fork+0x19/0x24
Dec 28 08:53:46 D-69-91-141-110 kernel: INFO: rcu_sched detected stalls on CPUs/tasks:
Dec 28 08:53:46 D-69-91-141-110 kernel:         0-...!: (0 ticks this GP) idle=48c/0/0 softirq=5073/5073 fqs=0 
Dec 28 08:53:46 D-69-91-141-110 kernel:         (detected by 1, t=5252 jiffies, g=2135, c=2134, q=4341)
Dec 28 08:53:46 D-69-91-141-110 kernel: Sending NMI from CPU 1 to CPUs 0:
Dec 28 08:53:46 D-69-91-141-110 kernel: NMI backtrace for cpu 0
Dec 28 08:53:46 D-69-91-141-110 kernel: CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W        4.15.0-rc5-dou-p+ #1
Dec 28 08:53:46 D-69-91-141-110 kernel: Hardware name: ASUSTeK Computer Inc. F5RL                /F5RL      , BIOS 210     06/12/2008
Dec 28 08:53:46 D-69-91-141-110 kernel: EIP: tick_check_broadcast_expired+0x10/0x20
Dec 28 08:53:46 D-69-91-141-110 kernel: EFLAGS: 00000247 CPU: 0
Dec 28 08:53:46 D-69-91-141-110 kernel: EAX: 00000000 EBX: d2792180 ECX: d28bbf28 EDX: 0002b48a
Dec 28 08:53:46 D-69-91-141-110 kernel: ESI: d2792180 EDI: 00000000 EBP: d278df24 ESP: d278df24
Dec 28 08:53:46 D-69-91-141-110 kernel:  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
Dec 28 08:53:46 D-69-91-141-110 kernel: CR0: 80050033 CR2: b7b7f0c0 CR3: 36d65d00 CR4: 000006f0
Dec 28 08:53:46 D-69-91-141-110 kernel: Call Trace:
Dec 28 08:53:46 D-69-91-141-110 kernel:  cpu_idle_poll+0x46/0x130
Dec 28 08:53:46 D-69-91-141-110 kernel:  do_idle+0x3d/0x1a0
Dec 28 08:53:46 D-69-91-141-110 kernel:  cpu_startup_entry+0x65/0x70
Dec 28 08:53:46 D-69-91-141-110 kernel:  rest_init+0x86/0x90
Dec 28 08:53:47 D-69-91-141-110 kernel:  start_kernel+0x371/0x38a
Dec 28 08:53:47 D-69-91-141-110 kernel:  i386_start_kernel+0x95/0x99
Dec 28 08:53:47 D-69-91-141-110 kernel:  startup_32_smp+0x164/0x168
Dec 28 08:53:47 D-69-91-141-110 kernel: Code: 91 4e 00 5b 5e 5d c3 8d 74 26 00 55 b8 60 26 90 d2 89 e5 5d c3 8d b6 00 00 00 00 55 64 a1 00 61 8b d2 89 e5 0f a3 05 58 26 90 d2 <0f> 92 c0 0f b6 c0 5d c3 90 8d b4 26 00 00 00 00 64 a1 00 61 8b
Dec 28 08:53:47 D-69-91-141-110 kernel: rcu_sched kthread starved for 5252 jiffies! g2135 c2134 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=0
Dec 28 08:53:47 D-69-91-141-110 kernel: rcu_sched       I    0     8      2 0x80000000
Dec 28 08:53:47 D-69-91-141-110 kernel: Call Trace:
Dec 28 08:53:47 D-69-91-141-110 kernel:  __schedule+0x3f9/0x880
Dec 28 08:53:47 D-69-91-141-110 kernel:  schedule+0x29/0x70
Dec 28 08:53:47 D-69-91-141-110 kernel:  schedule_timeout+0x12d/0x2f0
Dec 28 08:53:47 D-69-91-141-110 kernel:  ? __next_timer_interrupt+0xc0/0xc0
Dec 28 08:53:47 D-69-91-141-110 kernel:  rcu_gp_kthread+0x472/0x7a0
Dec 28 08:53:47 D-69-91-141-110 kernel:  kthread+0xd0/0x100
Dec 28 08:53:47 D-69-91-141-110 kernel:  ? call_rcu_sched+0x20/0x20
Dec 28 08:53:47 D-69-91-141-110 kernel:  ? kthread_associate_blkcg+0x90/0x90
Dec 28 08:53:47 D-69-91-141-110 kernel:  ret_from_fork+0x19/0x24
Dec 28 08:54:37 D-69-91-141-110 systemd[1]: systemd-udevd.service: Watchdog timeout (limit 3min)!
Dec 28 08:54:37 D-69-91-141-110 systemd[1]: systemd-udevd.service: Killing process 219 (systemd-udevd) with signal SIGABRT.
Dec 28 08:54:49 D-69-91-141-110 kernel: INFO: rcu_sched detected stalls on CPUs/tasks:
Dec 28 08:54:49 D-69-91-141-110 kernel:         0-...!: (0 ticks this GP) idle=c14/0/0 softirq=5073/5073 fqs=1 
Dec 28 08:54:49 D-69-91-141-110 kernel:         (detected by 1, t=21007 jiffies, g=2135, c=2134, q=5751)
Dec 28 08:54:49 D-69-91-141-110 kernel: Sending NMI from CPU 1 to CPUs 0:
Dec 28 08:54:49 D-69-91-141-110 kernel: NMI backtrace for cpu 0
Dec 28 08:54:49 D-69-91-141-110 kernel: CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W        4.15.0-rc5-dou-p+ #1
Dec 28 08:54:49 D-69-91-141-110 kernel: Hardware name: ASUSTeK Computer Inc. F5RL                /F5RL      , BIOS 210     06/12/2008
Dec 28 08:54:49 D-69-91-141-110 kernel: EIP: tick_check_broadcast_expired+0x10/0x20
Dec 28 08:54:49 D-69-91-141-110 kernel: EFLAGS: 00000247 CPU: 0
Dec 28 08:54:49 D-69-91-141-110 kernel: EAX: 00000000 EBX: d2792180 ECX: d28bbf28 EDX: 0002bc12
Dec 28 08:54:49 D-69-91-141-110 kernel: ESI: d2792180 EDI: 00000000 EBP: d278df24 ESP: d278df24
Dec 28 08:54:49 D-69-91-141-110 kernel:  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
Dec 28 08:54:49 D-69-91-141-110 kernel: CR0: 80050033 CR2: 09f63608 CR3: 36d65d00 CR4: 000006f0
Dec 28 08:54:49 D-69-91-141-110 kernel: Call Trace:
Dec 28 08:54:49 D-69-91-141-110 kernel:  cpu_idle_poll+0x46/0x130
Dec 28 08:54:49 D-69-91-141-110 kernel:  do_idle+0x3d/0x1a0
Dec 28 08:54:49 D-69-91-141-110 kernel:  cpu_startup_entry+0x65/0x70
Dec 28 08:54:49 D-69-91-141-110 kernel:  rest_init+0x86/0x90
Dec 28 08:54:49 D-69-91-141-110 kernel:  start_kernel+0x371/0x38a
Dec 28 08:54:49 D-69-91-141-110 kernel:  i386_start_kernel+0x95/0x99
Dec 28 08:54:49 D-69-91-141-110 kernel:  startup_32_smp+0x164/0x168
Dec 28 08:54:49 D-69-91-141-110 kernel: Code: 91 4e 00 5b 5e 5d c3 8d 74 26 00 55 b8 60 26 90 d2 89 e5 5d c3 8d b6 00 00 00 00 55 64 a1 00 61 8b d2 89 e5 0f a3 05 58 26 90 d2 <0f> 92 c0 0f b6 c0 5d c3 90 8d b4 26 00 00 00 00 64 a1 00 61 8b
Dec 28 08:54:49 D-69-91-141-110 kernel: rcu_sched kthread starved for 15755 jiffies! g2135 c2134 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=0
Dec 28 08:54:49 D-69-91-141-110 kernel: rcu_sched       I    0     8      2 0x80000000
Dec 28 08:54:49 D-69-91-141-110 kernel: Call Trace:
Dec 28 08:54:49 D-69-91-141-110 kernel:  __schedule+0x3f9/0x880
Dec 28 08:54:49 D-69-91-141-110 kernel:  schedule+0x29/0x70
Dec 28 08:54:49 D-69-91-141-110 kernel:  schedule_timeout+0x12d/0x2f0
Dec 28 08:54:49 D-69-91-141-110 kernel:  ? __next_timer_interrupt+0xc0/0xc0
Dec 28 08:54:49 D-69-91-141-110 kernel:  rcu_gp_kthread+0x472/0x7a0
Dec 28 08:54:49 D-69-91-141-110 kernel:  kthread+0xd0/0x100
Dec 28 08:54:49 D-69-91-141-110 kernel:  ? call_rcu_sched+0x20/0x20
Dec 28 08:54:49 D-69-91-141-110 kernel:  ? kthread_associate_blkcg+0x90/0x90
Dec 28 08:54:49 D-69-91-141-110 kernel:  ret_from_fork+0x19/0x24
Dec 28 08:54:52 D-69-91-141-110 kernel: perf: interrupt took too long (3271 > 3263), lowering kernel.perf_event_max_sample_rate to 61000

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=log-jrnl-dou-debug

-- Logs begin at Sat 2017-12-23 09:37:31 EST, end at Thu 2017-12-28 09:10:46 EST. --
Dec 28 09:05:54 D-69-91-141-110 kernel: Linux version 4.15.0-rc5-dou-p+ (root@axiomatic) (gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.5)) #1 SMP Thu Dec 28 08:40:40 EST 2017
Dec 28 09:05:54 D-69-91-141-110 kernel: x86/fpu: x87 FPU will use FXSAVE
Dec 28 09:05:54 D-69-91-141-110 kernel: e820: BIOS-provided physical RAM map:
Dec 28 09:05:54 D-69-91-141-110 kernel: BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
Dec 28 09:05:54 D-69-91-141-110 kernel: BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
Dec 28 09:05:54 D-69-91-141-110 kernel: BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
Dec 28 09:05:54 D-69-91-141-110 kernel: BIOS-e820: [mem 0x0000000000100000-0x00000000b7f9ffff] usable
Dec 28 09:05:54 D-69-91-141-110 kernel: BIOS-e820: [mem 0x00000000b7fa0000-0x00000000b7fadfff] ACPI data
Dec 28 09:05:54 D-69-91-141-110 kernel: BIOS-e820: [mem 0x00000000b7fae000-0x00000000b7feffff] ACPI NVS
Dec 28 09:05:54 D-69-91-141-110 kernel: BIOS-e820: [mem 0x00000000b7ff0000-0x00000000b7ffffff] reserved
Dec 28 09:05:54 D-69-91-141-110 kernel: BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
Dec 28 09:05:54 D-69-91-141-110 kernel: BIOS-e820: [mem 0x00000000ffb80000-0x00000000ffffffff] reserved
Dec 28 09:05:54 D-69-91-141-110 kernel: NX (Execute Disable) protection: active
Dec 28 09:05:54 D-69-91-141-110 kernel: random: fast init done
Dec 28 09:05:54 D-69-91-141-110 kernel: SMBIOS 2.4 present.
Dec 28 09:05:54 D-69-91-141-110 kernel: DMI: ASUSTeK Computer Inc. F5RL                /F5RL      , BIOS 210     06/12/2008
Dec 28 09:05:54 D-69-91-141-110 kernel: e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
Dec 28 09:05:54 D-69-91-141-110 kernel: e820: remove [mem 0x000a0000-0x000fffff] usable
Dec 28 09:05:54 D-69-91-141-110 kernel: e820: last_pfn = 0xb7fa0 max_arch_pfn = 0x1000000
Dec 28 09:05:54 D-69-91-141-110 kernel: MTRR default type: uncachable
Dec 28 09:05:54 D-69-91-141-110 kernel: MTRR fixed ranges enabled:
Dec 28 09:05:54 D-69-91-141-110 kernel:   00000-9FFFF write-back
Dec 28 09:05:54 D-69-91-141-110 kernel:   A0000-BFFFF uncachable
Dec 28 09:05:54 D-69-91-141-110 kernel:   C0000-CFFFF write-protect
Dec 28 09:05:54 D-69-91-141-110 kernel:   D0000-DFFFF uncachable
Dec 28 09:05:54 D-69-91-141-110 kernel:   E0000-EFFFF write-through
Dec 28 09:05:54 D-69-91-141-110 kernel:   F0000-FFFFF write-protect
Dec 28 09:05:54 D-69-91-141-110 kernel: MTRR variable ranges enabled:
Dec 28 09:05:54 D-69-91-141-110 kernel:   0 base 000000000 mask F80000000 write-back
Dec 28 09:05:54 D-69-91-141-110 kernel:   1 base 080000000 mask FE0000000 write-back
Dec 28 09:05:54 D-69-91-141-110 kernel:   2 base 0A0000000 mask FF0000000 write-back
Dec 28 09:05:54 D-69-91-141-110 kernel:   3 base 0B0000000 mask FF8000000 write-back
Dec 28 09:05:54 D-69-91-141-110 kernel:   4 base 0B8000000 mask FFC000000 write-back
Dec 28 09:05:54 D-69-91-141-110 kernel:   5 base 0BC000000 mask FFF000000 write-back
Dec 28 09:05:54 D-69-91-141-110 kernel:   6 base 0C0000000 mask FF0000000 write-combining
Dec 28 09:05:54 D-69-91-141-110 kernel:   7 disabled
Dec 28 09:05:54 D-69-91-141-110 kernel: x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
Dec 28 09:05:54 D-69-91-141-110 kernel: Scan for SMP in [mem 0x00000000-0x000003ff]
Dec 28 09:05:54 D-69-91-141-110 kernel: Scan for SMP in [mem 0x0009fc00-0x0009ffff]
Dec 28 09:05:54 D-69-91-141-110 kernel: Scan for SMP in [mem 0x000f0000-0x000fffff]
Dec 28 09:05:54 D-69-91-141-110 kernel: found SMP MP-table at [mem 0x000ff780-0x000ff78f] mapped at [(ptrval)]
Dec 28 09:05:54 D-69-91-141-110 kernel:   mpc: fd2d0-fd434
Dec 28 09:05:54 D-69-91-141-110 kernel: initial memory mapped: [mem 0x00000000-0x05dfffff]
Dec 28 09:05:54 D-69-91-141-110 kernel: Base memory trampoline at [(ptrval)] 9b000 size 16384
Dec 28 09:05:54 D-69-91-141-110 kernel: BRK [0x05966000, 0x05966fff] PGTABLE
Dec 28 09:05:54 D-69-91-141-110 kernel: BRK [0x05967000, 0x05968fff] PGTABLE
Dec 28 09:05:54 D-69-91-141-110 kernel: BRK [0x05969000, 0x05969fff] PGTABLE
Dec 28 09:05:54 D-69-91-141-110 kernel: BRK [0x0596a000, 0x0596afff] PGTABLE
Dec 28 09:05:54 D-69-91-141-110 kernel: RAMDISK: [mem 0x35d37000-0x36e92fff]
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: Early table checksum verification disabled
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: RSDP 0x00000000000F8070 000014 (v00 ACPIAM)
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: RSDT 0x00000000B7FA0000 00003C (v01 A_M_I_ OEMRSDT  06000812 MSFT 00000097)
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: FACP 0x00000000B7FA0200 000084 (v02 A_M_I_ OEMFACP  06000812 MSFT 00000097)
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: DSDT 0x00000000B7FA0630 0075FA (v01 A0669  A0669000 00000000 INTL 20060113)
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: FACS 0x00000000B7FAE000 000040
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: APIC 0x00000000B7FA0390 00005C (v01 A_M_I_ OEMAPIC  06000812 MSFT 00000097)
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: MCFG 0x00000000B7FA03F0 00003C (v01 A_M_I_ OEMMCFG  06000812 MSFT 00000097)
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: SLIC 0x00000000B7FA0430 000176 (v01 A_M_I_ OEMSLIC  06000812 MSFT 00000097)
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: BOOT 0x00000000B7FA0600 000028 (v01 A_M_I_ OEMBOOT  06000812 MSFT 00000097)
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: OEMB 0x00000000B7FAE040 00005B (v01 A_M_I_ AMI_OEM  06000812 MSFT 00000097)
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: Local APIC address 0xfee00000
Dec 28 09:05:54 D-69-91-141-110 kernel: mapped APIC to         ffffc000 (        fee00000)
Dec 28 09:05:54 D-69-91-141-110 kernel: 2057MB HIGHMEM available.
Dec 28 09:05:54 D-69-91-141-110 kernel: 885MB LOWMEM available.
Dec 28 09:05:54 D-69-91-141-110 kernel:   mapped low ram: 0 - 375fe000
Dec 28 09:05:54 D-69-91-141-110 kernel:   low ram: 0 - 375fe000
Dec 28 09:05:54 D-69-91-141-110 kernel: Reserving 256MB of memory at 256MB for crashkernel (System RAM: 2943MB)
Dec 28 09:05:54 D-69-91-141-110 kernel: tsc: Fast TSC calibration using PIT
Dec 28 09:05:54 D-69-91-141-110 kernel: BRK [0x0596b000, 0x0596bfff] PGTABLE
Dec 28 09:05:54 D-69-91-141-110 kernel: Zone ranges:
Dec 28 09:05:54 D-69-91-141-110 kernel:   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
Dec 28 09:05:54 D-69-91-141-110 kernel:   Normal   [mem 0x0000000001000000-0x00000000375fdfff]
Dec 28 09:05:54 D-69-91-141-110 kernel:   HighMem  [mem 0x00000000375fe000-0x00000000b7f9ffff]
Dec 28 09:05:54 D-69-91-141-110 kernel: Movable zone start for each node
Dec 28 09:05:54 D-69-91-141-110 kernel: Early memory node ranges
Dec 28 09:05:54 D-69-91-141-110 kernel:   node   0: [mem 0x0000000000001000-0x000000000009efff]
Dec 28 09:05:54 D-69-91-141-110 kernel:   node   0: [mem 0x0000000000100000-0x00000000b7f9ffff]
Dec 28 09:05:54 D-69-91-141-110 kernel: Initmem setup node 0 [mem 0x0000000000001000-0x00000000b7f9ffff]
Dec 28 09:05:54 D-69-91-141-110 kernel: On node 0 totalpages: 753470
Dec 28 09:05:54 D-69-91-141-110 kernel:   DMA zone: 36 pages used for memmap
Dec 28 09:05:54 D-69-91-141-110 kernel:   DMA zone: 0 pages reserved
Dec 28 09:05:54 D-69-91-141-110 kernel:   DMA zone: 3998 pages, LIFO batch:0
Dec 28 09:05:54 D-69-91-141-110 kernel:   Normal zone: 1958 pages used for memmap
Dec 28 09:05:54 D-69-91-141-110 kernel:   Normal zone: 222718 pages, LIFO batch:31
Dec 28 09:05:54 D-69-91-141-110 kernel:   HighMem zone: 526754 pages, LIFO batch:31
Dec 28 09:05:54 D-69-91-141-110 kernel: Reserved but unavailable: 98 pages
Dec 28 09:05:54 D-69-91-141-110 kernel: Using APIC driver default
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: PM-Timer IO Port: 0x808
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: Local APIC address 0xfee00000
Dec 28 09:05:54 D-69-91-141-110 kernel: IOAPIC[0]: apic_id 2, version 33, address 0xfec00000, GSI 0-23
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Dec 28 09:05:54 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 2, APIC INT 02
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Dec 28 09:05:54 D-69-91-141-110 kernel: Int: type 0, pol 3, trig 3, bus 00, IRQ 09, APIC ID 2, APIC INT 09
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: IRQ0 used by override.
Dec 28 09:05:54 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 2, APIC INT 01
Dec 28 09:05:54 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 2, APIC INT 03
Dec 28 09:05:54 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 2, APIC INT 04
Dec 28 09:05:54 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 05, APIC ID 2, APIC INT 05
Dec 28 09:05:54 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 2, APIC INT 06
Dec 28 09:05:54 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 2, APIC INT 07
Dec 28 09:05:54 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 2, APIC INT 08
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: IRQ9 used by override.
Dec 28 09:05:54 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 0a, APIC ID 2, APIC INT 0a
Dec 28 09:05:54 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 0b, APIC ID 2, APIC INT 0b
Dec 28 09:05:54 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 2, APIC INT 0c
Dec 28 09:05:54 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 2, APIC INT 0d
Dec 28 09:05:54 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 2, APIC INT 0e
Dec 28 09:05:54 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 2, APIC INT 0f
Dec 28 09:05:54 D-69-91-141-110 kernel: Using ACPI (MADT) for SMP configuration information
Dec 28 09:05:54 D-69-91-141-110 kernel: smpboot: Allowing 2 CPUs, 0 hotplug CPUs
Dec 28 09:05:54 D-69-91-141-110 kernel: mapped IOAPIC to ffffb000 (fec00000)
Dec 28 09:05:54 D-69-91-141-110 kernel: PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
Dec 28 09:05:54 D-69-91-141-110 kernel: PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
Dec 28 09:05:54 D-69-91-141-110 kernel: PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
Dec 28 09:05:54 D-69-91-141-110 kernel: PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
Dec 28 09:05:54 D-69-91-141-110 kernel: e820: [mem 0xb8000000-0xfedfffff] available for PCI devices
Dec 28 09:05:54 D-69-91-141-110 kernel: clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
Dec 28 09:05:54 D-69-91-141-110 kernel: setup_percpu: NR_CPUS:32 nr_cpumask_bits:32 nr_cpu_ids:2 nr_node_ids:1
Dec 28 09:05:54 D-69-91-141-110 kernel: percpu: Embedded 24 pages/cpu @(ptrval) s65612 r0 d32692 u98304
Dec 28 09:05:54 D-69-91-141-110 kernel: pcpu-alloc: s65612 r0 d32692 u98304 alloc=24*4096
Dec 28 09:05:54 D-69-91-141-110 kernel: pcpu-alloc: [0] 0 [0] 1 
Dec 28 09:05:54 D-69-91-141-110 kernel: Built 1 zonelists, mobility grouping on.  Total pages: 751476
Dec 28 09:05:54 D-69-91-141-110 kernel: Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.15.0-rc5-dou-p+ root=UUID=5a437cd2-c27b-4829-a7ba-533eb741b148 ro 3 crashkernel=256M quiet apic=debug
Dec 28 09:05:54 D-69-91-141-110 kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Dec 28 09:05:54 D-69-91-141-110 kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Dec 28 09:05:54 D-69-91-141-110 kernel: microcode: microcode updated early to revision 0xa4, date = 2010-10-02
Dec 28 09:05:54 D-69-91-141-110 kernel: Initializing CPU#0
Dec 28 09:05:54 D-69-91-141-110 kernel: Initializing HighMem for node 0 (000375fe:000b7fa0)
Dec 28 09:05:54 D-69-91-141-110 kernel: Initializing Movable for node 0 (00000000:00000000)
Dec 28 09:05:54 D-69-91-141-110 kernel: Memory: 2696772K/3013880K available (5865K kernel code, 593K rwdata, 1836K rodata, 604K init, 428K bss, 317108K reserved, 0K cma-reserved, 2107016K highmem)
Dec 28 09:05:54 D-69-91-141-110 kernel: virtual kernel memory layout:
                                            fixmap  : 0xffd36000 - 0xfffff000   (2852 kB)
                                          cpu_entry : 0xff800000 - 0xff8c1000   ( 772 kB)
                                            pkmap   : 0xff600000 - 0xff800000   (2048 kB)
                                            vmalloc : 0xf7dfe000 - 0xff5fe000   ( 120 MB)
                                            lowmem  : 0xc0000000 - 0xf75fe000   ( 885 MB)
                                              .init : 0xc582e000 - 0xc58c5000   ( 604 kB)
                                              .data : 0xc55ba464 - 0xc5820780   (2456 kB)
                                              .text : 0xc5000000 - 0xc55ba464   (5865 kB)
Dec 28 09:05:54 D-69-91-141-110 kernel: Checking if this processor honours the WP bit even in supervisor mode...Ok.
Dec 28 09:05:54 D-69-91-141-110 kernel: Hierarchical RCU implementation.
Dec 28 09:05:54 D-69-91-141-110 kernel:         RCU restricting CPUs from NR_CPUS=32 to nr_cpu_ids=2.
Dec 28 09:05:54 D-69-91-141-110 kernel: RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
Dec 28 09:05:54 D-69-91-141-110 kernel: NR_IRQS: 2304, nr_irqs: 440, preallocated irqs: 16
Dec 28 09:05:54 D-69-91-141-110 kernel: CPU 0 irqstacks, hard=(ptrval) soft=(ptrval)
Dec 28 09:05:54 D-69-91-141-110 kernel: Console: colour VGA+ 80x25
Dec 28 09:05:54 D-69-91-141-110 kernel: console [tty0] enabled
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: Core revision 20170831
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: 1 ACPI AML tables successfully acquired and loaded
Dec 28 09:05:54 D-69-91-141-110 kernel: APIC: Switch to symmetric I/O mode setup
Dec 28 09:05:54 D-69-91-141-110 kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Dec 28 09:05:54 D-69-91-141-110 kernel: enabled ExtINT on CPU#0
Dec 28 09:05:54 D-69-91-141-110 kernel: ESR value before enabling vector: 0x00000040  after: 0x00000000
Dec 28 09:05:54 D-69-91-141-110 kernel: ENABLING IO-APIC IRQs
Dec 28 09:05:54 D-69-91-141-110 kernel: init IO_APIC IRQs
Dec 28 09:05:54 D-69-91-141-110 kernel:  apic 2 pin 0 not connected
Dec 28 09:05:54 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-1 -> 0xef -> IRQ 1 Mode:0 Active:0 Dest:1)
Dec 28 09:05:54 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-2 -> 0x30 -> IRQ 0 Mode:0 Active:0 Dest:1)
Dec 28 09:05:54 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-3 -> 0xef -> IRQ 3 Mode:0 Active:0 Dest:1)
Dec 28 09:05:54 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-4 -> 0xef -> IRQ 4 Mode:0 Active:0 Dest:1)
Dec 28 09:05:54 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-5 -> 0xef -> IRQ 5 Mode:0 Active:0 Dest:1)
Dec 28 09:05:54 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-6 -> 0xef -> IRQ 6 Mode:0 Active:0 Dest:1)
Dec 28 09:05:54 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-7 -> 0xef -> IRQ 7 Mode:0 Active:0 Dest:1)
Dec 28 09:05:54 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-8 -> 0xef -> IRQ 8 Mode:0 Active:0 Dest:1)
Dec 28 09:05:54 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-9 -> 0xef -> IRQ 9 Mode:1 Active:1 Dest:1)
Dec 28 09:05:54 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-10 -> 0xef -> IRQ 10 Mode:0 Active:0 Dest:1)
Dec 28 09:05:54 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-11 -> 0xef -> IRQ 11 Mode:0 Active:0 Dest:1)
Dec 28 09:05:54 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-12 -> 0xef -> IRQ 12 Mode:0 Active:0 Dest:1)
Dec 28 09:05:54 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-13 -> 0xef -> IRQ 13 Mode:0 Active:0 Dest:1)
Dec 28 09:05:54 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-14 -> 0xef -> IRQ 14 Mode:0 Active:0 Dest:1)
Dec 28 09:05:54 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-15 -> 0xef -> IRQ 15 Mode:0 Active:0 Dest:1)
Dec 28 09:05:54 D-69-91-141-110 kernel:  apic 2 pin 16 not connected
Dec 28 09:05:54 D-69-91-141-110 kernel:  apic 2 pin 17 not connected
Dec 28 09:05:54 D-69-91-141-110 kernel:  apic 2 pin 18 not connected
Dec 28 09:05:54 D-69-91-141-110 kernel:  apic 2 pin 19 not connected
Dec 28 09:05:54 D-69-91-141-110 kernel:  apic 2 pin 20 not connected
Dec 28 09:05:54 D-69-91-141-110 kernel:  apic 2 pin 21 not connected
Dec 28 09:05:54 D-69-91-141-110 kernel:  apic 2 pin 22 not connected
Dec 28 09:05:54 D-69-91-141-110 kernel:  apic 2 pin 23 not connected
Dec 28 09:05:54 D-69-91-141-110 kernel: ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
Dec 28 09:05:54 D-69-91-141-110 kernel: tsc: Fast TSC calibration using PIT
Dec 28 09:05:54 D-69-91-141-110 kernel: tsc: Detected 1662.460 MHz processor
Dec 28 09:05:54 D-69-91-141-110 kernel: Calibrating delay loop (skipped), value calculated using timer frequency.. 3324.92 BogoMIPS (lpj=6649840)
Dec 28 09:05:54 D-69-91-141-110 kernel: pid_max: default: 32768 minimum: 301
Dec 28 09:05:54 D-69-91-141-110 kernel: Security Framework initialized
Dec 28 09:05:54 D-69-91-141-110 kernel: Yama: becoming mindful.
Dec 28 09:05:54 D-69-91-141-110 kernel: AppArmor: AppArmor disabled by boot time parameter
Dec 28 09:05:54 D-69-91-141-110 kernel: Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
Dec 28 09:05:54 D-69-91-141-110 kernel: Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
Dec 28 09:05:54 D-69-91-141-110 kernel: CPU: Physical Processor ID: 0
Dec 28 09:05:54 D-69-91-141-110 kernel: CPU: Processor Core ID: 0
Dec 28 09:05:54 D-69-91-141-110 kernel: mce: CPU supports 6 MCE banks
Dec 28 09:05:54 D-69-91-141-110 kernel: process: using mwait in idle threads
Dec 28 09:05:54 D-69-91-141-110 kernel: Last level iTLB entries: 4KB 128, 2MB 4, 4MB 4
Dec 28 09:05:54 D-69-91-141-110 kernel: Last level dTLB entries: 4KB 256, 2MB 0, 4MB 32, 1GB 0
Dec 28 09:05:54 D-69-91-141-110 kernel: Freeing SMP alternatives memory: 24K
Dec 28 09:05:54 D-69-91-141-110 kernel: Using local APIC timer interrupts.
                                        calibrating APIC timer ...
Dec 28 09:05:54 D-69-91-141-110 kernel: ... lapic delta = 1039119
Dec 28 09:05:54 D-69-91-141-110 kernel: ... PM-Timer delta = 357974
Dec 28 09:05:54 D-69-91-141-110 kernel: ... PM-Timer result ok
Dec 28 09:05:54 D-69-91-141-110 kernel: ..... delta 1039119
Dec 28 09:05:54 D-69-91-141-110 kernel: ..... mult: 44629821
Dec 28 09:05:54 D-69-91-141-110 kernel: ..... calibration result: 665036
Dec 28 09:05:54 D-69-91-141-110 kernel: ..... CPU clock speed is 1662.2359 MHz.
Dec 28 09:05:54 D-69-91-141-110 kernel: ..... host bus clock speed is 166.1036 MHz.
Dec 28 09:05:54 D-69-91-141-110 kernel: smpboot: CPU0: Intel(R) Core(TM)2 Duo CPU     T5450  @ 1.66GHz (family: 0x6, model: 0xf, stepping: 0xd)
Dec 28 09:05:54 D-69-91-141-110 kernel: Performance Events: PEBS fmt0+, Core2 events, Intel PMU driver.
Dec 28 09:05:54 D-69-91-141-110 kernel: core: PEBS disabled due to CPU errata
Dec 28 09:05:54 D-69-91-141-110 kernel: ... version:                2
Dec 28 09:05:54 D-69-91-141-110 kernel: ... bit width:              40
Dec 28 09:05:54 D-69-91-141-110 kernel: ... generic registers:      2
Dec 28 09:05:54 D-69-91-141-110 kernel: ... value mask:             000000ffffffffff
Dec 28 09:05:54 D-69-91-141-110 kernel: ... max period:             000000007fffffff
Dec 28 09:05:54 D-69-91-141-110 kernel: ... fixed-purpose events:   3
Dec 28 09:05:54 D-69-91-141-110 kernel: ... event mask:             0000000700000003
Dec 28 09:05:54 D-69-91-141-110 kernel: Hierarchical SRCU implementation.
Dec 28 09:05:54 D-69-91-141-110 kernel: NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
Dec 28 09:05:54 D-69-91-141-110 kernel: smp: Bringing up secondary CPUs ...
Dec 28 09:05:54 D-69-91-141-110 kernel: CPU 1 irqstacks, hard=3c63b68a soft=7cca5353
Dec 28 09:05:54 D-69-91-141-110 kernel: x86: Booting SMP configuration:
Dec 28 09:05:54 D-69-91-141-110 kernel: .... node  #0, CPUs:      #1
Dec 28 09:05:54 D-69-91-141-110 kernel: Initializing CPU#1
Dec 28 09:05:54 D-69-91-141-110 kernel: masked ExtINT on CPU#1
Dec 28 09:05:54 D-69-91-141-110 kernel: smp: Brought up 1 node, 2 CPUs
Dec 28 09:05:54 D-69-91-141-110 kernel: smpboot: Max logical packages: 1
Dec 28 09:05:54 D-69-91-141-110 kernel: smpboot: Total of 2 processors activated (6649.84 BogoMIPS)
Dec 28 09:05:54 D-69-91-141-110 kernel: devtmpfs: initialized
Dec 28 09:05:54 D-69-91-141-110 kernel: PM: Registering ACPI NVS region [mem 0xb7fae000-0xb7feffff] (270336 bytes)
Dec 28 09:05:54 D-69-91-141-110 kernel: clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
Dec 28 09:05:54 D-69-91-141-110 kernel: futex hash table entries: 512 (order: 3, 32768 bytes)
Dec 28 09:05:54 D-69-91-141-110 kernel: pinctrl core: initialized pinctrl subsystem
Dec 28 09:05:54 D-69-91-141-110 kernel: NET: Registered protocol family 16
Dec 28 09:05:54 D-69-91-141-110 kernel: audit: initializing netlink subsys (disabled)
Dec 28 09:05:54 D-69-91-141-110 kernel: audit: type=2000 audit(1514469945.032:1): state=initialized audit_enabled=0 res=1
Dec 28 09:05:54 D-69-91-141-110 kernel: cpuidle: using governor ladder
Dec 28 09:05:54 D-69-91-141-110 kernel: cpuidle: using governor menu
Dec 28 09:05:54 D-69-91-141-110 kernel: Simple Boot Flag at 0xff set to 0x1
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: bus type PCI registered
Dec 28 09:05:54 D-69-91-141-110 kernel: acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
Dec 28 09:05:54 D-69-91-141-110 kernel: PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
Dec 28 09:05:54 D-69-91-141-110 kernel: PCI: not using MMCONFIG
Dec 28 09:05:54 D-69-91-141-110 kernel: PCI: PCI BIOS area is rw and x. Use pci=nobios if you want it NX.
Dec 28 09:05:54 D-69-91-141-110 kernel: PCI: PCI BIOS revision 3.00 entry at 0xf0031, last bus=8
Dec 28 09:05:54 D-69-91-141-110 kernel: PCI: Using configuration type 1 for base access
Dec 28 09:05:54 D-69-91-141-110 kernel: mtrr: your CPUs had inconsistent variable MTRR settings
Dec 28 09:05:54 D-69-91-141-110 kernel: mtrr: probably your BIOS does not setup all CPUs.
Dec 28 09:05:54 D-69-91-141-110 kernel: mtrr: corrected configuration.
Dec 28 09:05:54 D-69-91-141-110 kernel: HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: Added _OSI(Module Device)
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: Added _OSI(Processor Device)
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: Added _OSI(3.0 _SCP Extensions)
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: Added _OSI(Processor Aggregator Device)
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: Executed 2 blocks of module-level executable AML code
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: Dynamic OEM Table Load:
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: SSDT 0x00000000F7126000 000C99 (v01 AMI    CPU1PM   00000001 INTL 20060113)
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: Dynamic OEM Table Load:
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: SSDT 0x00000000F712C000 000C99 (v01 AMI    CPU2PM   00000001 INTL 20060113)
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: EC: EC started
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: EC: interrupt blocked
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: \_SB_.PCI0.SBRG.EC0_: Used as first EC
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: \_SB_.PCI0.SBRG.EC0_: GPE=0x11, EC_CMD/EC_SC=0x66, EC_DATA=0x62
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: \_SB_.PCI0.SBRG.EC0_: Used as boot DSDT EC to handle transactions
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: Interpreter enabled
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: (supports S0 S3 S4 S5)
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: Using IOAPIC for interrupt routing
Dec 28 09:05:54 D-69-91-141-110 kernel: PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
Dec 28 09:05:54 D-69-91-141-110 kernel: PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in ACPI motherboard resources
Dec 28 09:05:54 D-69-91-141-110 kernel: PCI: Using MMCONFIG for extended config space
Dec 28 09:05:54 D-69-91-141-110 kernel: PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: Enabled 6 GPEs in block 00 to 1F
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
Dec 28 09:05:54 D-69-91-141-110 kernel: acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
Dec 28 09:05:54 D-69-91-141-110 kernel: acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
Dec 28 09:05:54 D-69-91-141-110 kernel: PCI host bridge to bus 0000:00
Dec 28 09:05:54 D-69-91-141-110 kernel: pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000dffff window]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci_bus 0000:00: root bus resource [mem 0xb8000000-0xffffffff window]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci_bus 0000:00: root bus resource [bus 00-ff]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:00.0: [1002:5a31] type 00 class 0x060000
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:01.0: [1002:5a3f] type 01 class 0x060400
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:04.0: [1002:5a36] type 01 class 0x060400
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:04.0: enabling Extended Tags
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:05.0: [1002:5a37] type 01 class 0x060400
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:05.0: enabling Extended Tags
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:05.0: PME# supported from D0 D3hot D3cold
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:06.0: [1002:5a38] type 01 class 0x060400
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:06.0: enabling Extended Tags
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:07.0: [1002:5a39] type 01 class 0x060400
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:07.0: enabling Extended Tags
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:12.0: [1002:4380] type 00 class 0x01018f
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:12.0: reg 0x10: [io  0xe800-0xe807]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:12.0: reg 0x14: [io  0xe400-0xe403]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:12.0: reg 0x18: [io  0xe000-0xe007]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:12.0: reg 0x1c: [io  0xdc00-0xdc03]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:12.0: reg 0x20: [io  0xd800-0xd80f]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:12.0: reg 0x24: [mem 0xfebffc00-0xfebfffff]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:12.0: set SATA to AHCI mode
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:13.0: [1002:4387] type 00 class 0x0c0310
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:13.0: reg 0x10: [mem 0xfebfe000-0xfebfefff]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:13.1: [1002:4388] type 00 class 0x0c0310
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:13.1: reg 0x10: [mem 0xfebfd000-0xfebfdfff]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:13.2: [1002:4389] type 00 class 0x0c0310
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:13.2: reg 0x10: [mem 0xfebfc000-0xfebfcfff]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:13.3: [1002:438a] type 00 class 0x0c0310
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:13.3: reg 0x10: [mem 0xfebfb000-0xfebfbfff]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:13.4: [1002:438b] type 00 class 0x0c0310
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:13.4: reg 0x10: [mem 0xfebfa000-0xfebfafff]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:13.5: [1002:4386] type 00 class 0x0c0320
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:13.5: reg 0x10: [mem 0xfebff800-0xfebff8ff]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:13.5: supports D1 D2
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:13.5: PME# supported from D0 D1 D2 D3hot
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:14.0: [1002:4385] type 00 class 0x0c0500
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:14.0: reg 0x10: [io  0x0b00-0x0b0f]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:14.1: [1002:438c] type 00 class 0x010182
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:14.1: reg 0x10: [io  0x0000-0x0007]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:14.1: reg 0x14: [io  0x0000-0x0003]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:14.1: reg 0x18: [io  0x0000-0x0007]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:14.1: reg 0x1c: [io  0x0000-0x0003]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:14.1: reg 0x20: [io  0xff00-0xff0f]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:14.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:14.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:14.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:14.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:14.2: [1002:4383] type 00 class 0x040300
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:14.2: reg 0x10: [mem 0xfebf4000-0xfebf7fff 64bit]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:14.3: [1002:438d] type 00 class 0x060100
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:14.4: [1002:4384] type 01 class 0x060401
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:01:05.0: [1002:5a62] type 00 class 0x030000
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:01:05.0: reg 0x10: [mem 0xc0000000-0xcfffffff pref]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:01:05.0: reg 0x14: [io  0x9800-0x98ff]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:01:05.0: reg 0x18: [mem 0xfa8f0000-0xfa8fffff]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:01:05.0: reg 0x30: [mem 0xfa8c0000-0xfa8dffff pref]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:01:05.0: supports D1 D2
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:01.0: PCI bridge to [bus 01]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:01.0:   bridge window [io  0x9000-0x9fff]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:01.0:   bridge window [mem 0xfa800000-0xfa8fffff]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:01.0:   bridge window [mem 0xbdf00000-0xddefffff pref]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:02:00.0: [168c:001c] type 00 class 0x020000
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:02:00.0: reg 0x10: [mem 0xfa9f0000-0xfa9fffff 64bit]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:02:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:04.0: PCI bridge to [bus 02]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:04.0:   bridge window [mem 0xfa900000-0xfa9fffff]
Dec 28 09:05:54 D-69-91-141-110 kernel: acpiphp: Slot [1] registered
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:05.0: PCI bridge to [bus 03-05]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:05.0:   bridge window [io  0xa000-0xbfff]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:05.0:   bridge window [mem 0xfaa00000-0xfe9fffff]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:05.0:   bridge window [mem 0xddf00000-0xdfefffff 64bit pref]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:06:00.0: [1969:2048] type 00 class 0x020000
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:06:00.0: reg 0x10: [mem 0xfeac0000-0xfeafffff 64bit]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:06:00.0: reg 0x30: [mem 0xfeaa0000-0xfeabffff pref]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:06:00.0: PME# supported from D3hot D3cold
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:06:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:06.0: PCI bridge to [bus 06]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:06.0:   bridge window [mem 0xfea00000-0xfeafffff]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:07.0: PCI bridge to [bus 07]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:14.4: PCI bridge to [bus 08] (subtractive decode)
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:14.4:   bridge window [io  0x0000-0x0cf7 window] (subtractive decode)
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:14.4:   bridge window [mem 0x000d0000-0x000dffff window] (subtractive decode)
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:14.4:   bridge window [mem 0xb8000000-0xffffffff window] (subtractive decode)
Dec 28 09:05:54 D-69-91-141-110 kernel: pci_bus 0000:00: on NUMA node 0
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 7 10 11 12)
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 12)
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 7 10 11 12)
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *10 11 12)
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 12) *0, disabled.
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 12) *0, disabled.
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 *11 12)
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 12) *0, disabled.
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: EC: interrupt unblocked
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: EC: event unblocked
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: \_SB_.PCI0.SBRG.EC0_: GPE=0x11, EC_CMD/EC_SC=0x66, EC_DATA=0x62
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: \_SB_.PCI0.SBRG.EC0_: Used as boot DSDT EC to handle transactions and events
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:01:05.0: vgaarb: setting as boot VGA device
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:01:05.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:01:05.0: vgaarb: bridge control possible
Dec 28 09:05:54 D-69-91-141-110 kernel: vgaarb: loaded
Dec 28 09:05:54 D-69-91-141-110 kernel: EDAC MC: Ver: 3.0.0
Dec 28 09:05:54 D-69-91-141-110 kernel: PCI: Using ACPI for IRQ routing
Dec 28 09:05:54 D-69-91-141-110 kernel: PCI: pci_cache_line_size set to 64 bytes
Dec 28 09:05:54 D-69-91-141-110 kernel: e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
Dec 28 09:05:54 D-69-91-141-110 kernel: e820: reserve RAM buffer [mem 0xb7fa0000-0xb7ffffff]
Dec 28 09:05:54 D-69-91-141-110 kernel: clocksource: Switched to clocksource refined-jiffies
Dec 28 09:05:54 D-69-91-141-110 kernel: VFS: Disk quotas dquot_6.6.0
Dec 28 09:05:54 D-69-91-141-110 kernel: VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Dec 28 09:05:54 D-69-91-141-110 kernel: pnp: PnP ACPI init
Dec 28 09:05:54 D-69-91-141-110 kernel: pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
Dec 28 09:05:54 D-69-91-141-110 kernel: system 00:01: [io  0x04d0-0x04d1] has been reserved
Dec 28 09:05:54 D-69-91-141-110 kernel: system 00:01: [io  0x040b] has been reserved
Dec 28 09:05:54 D-69-91-141-110 kernel: system 00:01: [io  0x04d6] has been reserved
Dec 28 09:05:54 D-69-91-141-110 kernel: system 00:01: [io  0x0c00-0x0c01] has been reserved
Dec 28 09:05:54 D-69-91-141-110 kernel: system 00:01: [io  0x0c14] has been reserved
Dec 28 09:05:54 D-69-91-141-110 kernel: system 00:01: [io  0x0c50-0x0c51] has been reserved
Dec 28 09:05:54 D-69-91-141-110 kernel: system 00:01: [io  0x0c52] has been reserved
Dec 28 09:05:54 D-69-91-141-110 kernel: system 00:01: [io  0x0c6c] has been reserved
Dec 28 09:05:54 D-69-91-141-110 kernel: system 00:01: [io  0x0c6f] has been reserved
Dec 28 09:05:54 D-69-91-141-110 kernel: system 00:01: [io  0x0cd0-0x0cd1] has been reserved
Dec 28 09:05:54 D-69-91-141-110 kernel: system 00:01: [io  0x0cd2-0x0cd3] has been reserved
Dec 28 09:05:54 D-69-91-141-110 kernel: system 00:01: [io  0x0cd4-0x0cd5] has been reserved
Dec 28 09:05:54 D-69-91-141-110 kernel: system 00:01: [io  0x0cd6-0x0cd7] has been reserved
Dec 28 09:05:54 D-69-91-141-110 kernel: system 00:01: [io  0x0cd8-0x0cdf] has been reserved
Dec 28 09:05:54 D-69-91-141-110 kernel: system 00:01: [io  0x0800-0x089f] has been reserved
Dec 28 09:05:54 D-69-91-141-110 kernel: system 00:01: [io  0x0b00-0x0b1f] could not be reserved
Dec 28 09:05:54 D-69-91-141-110 kernel: system 00:01: [io  0x0900-0x090f] has been reserved
Dec 28 09:05:54 D-69-91-141-110 kernel: system 00:01: [io  0x0910-0x091f] has been reserved
Dec 28 09:05:54 D-69-91-141-110 kernel: system 00:01: [io  0xfe00-0xfefe] has been reserved
Dec 28 09:05:54 D-69-91-141-110 kernel: system 00:01: [io  0x4000-0x40fe] has been reserved
Dec 28 09:05:54 D-69-91-141-110 kernel: system 00:01: [mem 0xfed45000-0xfed89fff] has been reserved
Dec 28 09:05:54 D-69-91-141-110 kernel: system 00:01: [mem 0xffb80000-0xffbfffff] has been reserved
Dec 28 09:05:54 D-69-91-141-110 kernel: system 00:01: [mem 0xfff80000-0xffffffff] has been reserved
Dec 28 09:05:54 D-69-91-141-110 kernel: system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
Dec 28 09:05:54 D-69-91-141-110 kernel: pnp 00:02: Plug and Play ACPI device, IDs PNP0303 PNP030b (active)
Dec 28 09:05:54 D-69-91-141-110 kernel: pnp 00:03: Plug and Play ACPI device, IDs SYN0a04 SYN0a00 SYN0002 PNP0f03 PNP0f13 PNP0f12 (active)
Dec 28 09:05:54 D-69-91-141-110 kernel: system 00:04: [io  0x0250-0x0253] has been reserved
Dec 28 09:05:54 D-69-91-141-110 kernel: system 00:04: [io  0x0256-0x025f] has been reserved
Dec 28 09:05:54 D-69-91-141-110 kernel: system 00:04: [mem 0xfec00000-0xfec00fff] could not be reserved
Dec 28 09:05:54 D-69-91-141-110 kernel: system 00:04: [mem 0xfee00000-0xfee00fff] has been reserved
Dec 28 09:05:54 D-69-91-141-110 kernel: system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
Dec 28 09:05:54 D-69-91-141-110 kernel: system 00:05: [mem 0xe0000000-0xefffffff] has been reserved
Dec 28 09:05:54 D-69-91-141-110 kernel: system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
Dec 28 09:05:54 D-69-91-141-110 kernel: system 00:06: [mem 0x00000000-0x0009ffff] could not be reserved
Dec 28 09:05:54 D-69-91-141-110 kernel: system 00:06: [mem 0x000c0000-0x000cffff] could not be reserved
Dec 28 09:05:54 D-69-91-141-110 kernel: system 00:06: [mem 0x000e0000-0x000fffff] could not be reserved
Dec 28 09:05:54 D-69-91-141-110 kernel: system 00:06: [mem 0x00100000-0xb7ffffff] could not be reserved
Dec 28 09:05:54 D-69-91-141-110 kernel: system 00:06: Plug and Play ACPI device, IDs PNP0c01 (active)
Dec 28 09:05:54 D-69-91-141-110 kernel: pnp: PnP ACPI: found 7 devices
Dec 28 09:05:54 D-69-91-141-110 kernel: PnPBIOS: Disabled
Dec 28 09:05:54 D-69-91-141-110 kernel: clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
Dec 28 09:05:54 D-69-91-141-110 kernel: clocksource: Switched to clocksource acpi_pm
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:01.0: PCI bridge to [bus 01]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:01.0:   bridge window [io  0x9000-0x9fff]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:01.0:   bridge window [mem 0xfa800000-0xfa8fffff]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:01.0:   bridge window [mem 0xbdf00000-0xddefffff pref]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:04.0: PCI bridge to [bus 02]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:04.0:   bridge window [mem 0xfa900000-0xfa9fffff]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:05.0: PCI bridge to [bus 03-05]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:05.0:   bridge window [io  0xa000-0xbfff]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:05.0:   bridge window [mem 0xfaa00000-0xfe9fffff]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:05.0:   bridge window [mem 0xddf00000-0xdfefffff 64bit pref]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:06.0: PCI bridge to [bus 06]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:06.0:   bridge window [mem 0xfea00000-0xfeafffff]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:07.0: PCI bridge to [bus 07]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:14.4: PCI bridge to [bus 08]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000dffff window]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci_bus 0000:00: resource 8 [mem 0xb8000000-0xffffffff window]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci_bus 0000:01: resource 0 [io  0x9000-0x9fff]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci_bus 0000:01: resource 1 [mem 0xfa800000-0xfa8fffff]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci_bus 0000:01: resource 2 [mem 0xbdf00000-0xddefffff pref]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci_bus 0000:02: resource 1 [mem 0xfa900000-0xfa9fffff]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci_bus 0000:03: resource 0 [io  0xa000-0xbfff]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci_bus 0000:03: resource 1 [mem 0xfaa00000-0xfe9fffff]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci_bus 0000:03: resource 2 [mem 0xddf00000-0xdfefffff 64bit pref]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci_bus 0000:06: resource 1 [mem 0xfea00000-0xfeafffff]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci_bus 0000:08: resource 4 [io  0x0000-0x0cf7 window]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci_bus 0000:08: resource 5 [io  0x0d00-0xffff window]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci_bus 0000:08: resource 6 [mem 0x000a0000-0x000bffff window]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci_bus 0000:08: resource 7 [mem 0x000d0000-0x000dffff window]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci_bus 0000:08: resource 8 [mem 0xb8000000-0xffffffff window]
Dec 28 09:05:54 D-69-91-141-110 kernel: NET: Registered protocol family 2
Dec 28 09:05:54 D-69-91-141-110 kernel: TCP established hash table entries: 8192 (order: 3, 32768 bytes)
Dec 28 09:05:54 D-69-91-141-110 kernel: TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
Dec 28 09:05:54 D-69-91-141-110 kernel: TCP: Hash tables configured (established 8192 bind 8192)
Dec 28 09:05:54 D-69-91-141-110 kernel: UDP hash table entries: 512 (order: 2, 16384 bytes)
Dec 28 09:05:54 D-69-91-141-110 kernel: UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
Dec 28 09:05:54 D-69-91-141-110 kernel: NET: Registered protocol family 1
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:00:01.0: MSI quirk detected; subordinate MSI disabled
Dec 28 09:05:54 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-16 -> 0xef -> IRQ 16 Mode:1 Active:1 Dest:1)
Dec 28 09:05:54 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-17 -> 0xef -> IRQ 17 Mode:1 Active:1 Dest:1)
Dec 28 09:05:54 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-18 -> 0xef -> IRQ 18 Mode:1 Active:1 Dest:1)
Dec 28 09:05:54 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-17 -> 0xef -> IRQ 17 Mode:1 Active:1 Dest:1)
Dec 28 09:05:54 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-18 -> 0xef -> IRQ 18 Mode:1 Active:1 Dest:1)
Dec 28 09:05:54 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-19 -> 0xef -> IRQ 19 Mode:1 Active:1 Dest:1)
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:01:05.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
Dec 28 09:05:54 D-69-91-141-110 kernel: pci 0000:06:00.0: [Firmware Bug]: disabling VPD access (can't determine size of non-standard VPD format)
Dec 28 09:05:54 D-69-91-141-110 kernel: PCI: CLS 64 bytes, default 64
Dec 28 09:05:54 D-69-91-141-110 kernel: Unpacking initramfs...
Dec 28 09:05:54 D-69-91-141-110 kernel: Freeing initrd memory: 17776K
Dec 28 09:05:54 D-69-91-141-110 kernel: Initialise system trusted keyrings
Dec 28 09:05:54 D-69-91-141-110 kernel: workingset: timestamp_bits=14 max_order=20 bucket_order=6
Dec 28 09:05:54 D-69-91-141-110 kernel: zbud: loaded
Dec 28 09:05:54 D-69-91-141-110 kernel: tsc: Refined TSC clocksource calibration: 1662.499 MHz
Dec 28 09:05:54 D-69-91-141-110 kernel: clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x17f6c559e9c, max_idle_ns: 440795215390 ns
Dec 28 09:05:54 D-69-91-141-110 kernel: clocksource: Switched to clocksource tsc
Dec 28 09:05:54 D-69-91-141-110 kernel: Key type asymmetric registered
Dec 28 09:05:54 D-69-91-141-110 kernel: Asymmetric key parser 'x509' registered
Dec 28 09:05:54 D-69-91-141-110 kernel: bounce: pool size: 64 pages
Dec 28 09:05:54 D-69-91-141-110 kernel: Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
Dec 28 09:05:54 D-69-91-141-110 kernel: io scheduler noop registered
Dec 28 09:05:54 D-69-91-141-110 kernel: io scheduler deadline registered
Dec 28 09:05:54 D-69-91-141-110 kernel: io scheduler cfq registered (default)
Dec 28 09:05:54 D-69-91-141-110 kernel: io scheduler mq-deadline registered
Dec 28 09:05:54 D-69-91-141-110 kernel: io scheduler kyber registered
Dec 28 09:05:54 D-69-91-141-110 kernel: intel_idle: does not run on family 6 model 15
Dec 28 09:05:54 D-69-91-141-110 kernel: tsc: Marking TSC unstable due to TSC halts in idle
Dec 28 09:05:54 D-69-91-141-110 kernel: clocksource: Switched to clocksource acpi_pm
Dec 28 09:05:54 D-69-91-141-110 kernel: isapnp: Scanning for PnP cards...
Dec 28 09:05:54 D-69-91-141-110 kernel: isapnp: No Plug & Play device found
Dec 28 09:05:54 D-69-91-141-110 kernel: Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
Dec 28 09:05:54 D-69-91-141-110 kernel: Linux agpgart interface v0.103
Dec 28 09:05:54 D-69-91-141-110 kernel: i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
Dec 28 09:05:54 D-69-91-141-110 kernel: i8042: Detected active multiplexing controller, rev 1.1
Dec 28 09:05:54 D-69-91-141-110 kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Dec 28 09:05:54 D-69-91-141-110 kernel: serio: i8042 AUX0 port at 0x60,0x64 irq 12
Dec 28 09:05:54 D-69-91-141-110 kernel: serio: i8042 AUX1 port at 0x60,0x64 irq 12
Dec 28 09:05:54 D-69-91-141-110 kernel: serio: i8042 AUX2 port at 0x60,0x64 irq 12
Dec 28 09:05:54 D-69-91-141-110 kernel: serio: i8042 AUX3 port at 0x60,0x64 irq 12
Dec 28 09:05:54 D-69-91-141-110 kernel: mousedev: PS/2 mouse device common for all mice
Dec 28 09:05:54 D-69-91-141-110 kernel: rtc_cmos 00:00: RTC can wake from S4
Dec 28 09:05:54 D-69-91-141-110 kernel: rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
Dec 28 09:05:54 D-69-91-141-110 kernel: rtc_cmos 00:00: alarms up to one month, y3k, 114 bytes nvram
Dec 28 09:05:54 D-69-91-141-110 kernel: ledtrig-cpu: registered to indicate activity on CPUs
Dec 28 09:05:54 D-69-91-141-110 kernel: NET: Registered protocol family 10
Dec 28 09:05:54 D-69-91-141-110 kernel: Segment Routing with IPv6
Dec 28 09:05:54 D-69-91-141-110 kernel: mip6: Mobile IPv6
Dec 28 09:05:54 D-69-91-141-110 kernel: NET: Registered protocol family 17
Dec 28 09:05:54 D-69-91-141-110 kernel: mpls_gso: MPLS GSO support
Dec 28 09:05:54 D-69-91-141-110 kernel: microcode: sig=0x6fd, pf=0x80, revision=0xa4
Dec 28 09:05:54 D-69-91-141-110 kernel: microcode: Microcode Update Driver: v2.2.
Dec 28 09:05:54 D-69-91-141-110 kernel: ... APIC ID:      00000000 (0)
Dec 28 09:05:54 D-69-91-141-110 kernel: ... APIC VERSION: 00050014
Dec 28 09:05:54 D-69-91-141-110 kernel: 0000000000000000000000000000000000000000000000000000000000000000
Dec 28 09:05:54 D-69-91-141-110 kernel: 0000000000000000000000000000000000000000000000000000000000000000
Dec 28 09:05:54 D-69-91-141-110 kernel: 0000000000000000000000000000000000000000000000000000000000000000
Dec 28 09:05:54 D-69-91-141-110 kernel: number of MP IRQ sources: 15.
Dec 28 09:05:54 D-69-91-141-110 kernel: number of IO-APIC #2 registers: 24.
Dec 28 09:05:54 D-69-91-141-110 kernel: testing the IO APIC.......................
Dec 28 09:05:54 D-69-91-141-110 kernel: IO APIC #2......
Dec 28 09:05:54 D-69-91-141-110 kernel: .... register #00: 02000000
Dec 28 09:05:54 D-69-91-141-110 kernel: .......    : physical APIC id: 02
Dec 28 09:05:54 D-69-91-141-110 kernel: .......    : Delivery Type: 0
Dec 28 09:05:54 D-69-91-141-110 kernel: .......    : LTS          : 0
Dec 28 09:05:54 D-69-91-141-110 kernel: .... register #01: 00178021
Dec 28 09:05:54 D-69-91-141-110 kernel: .......     : max redirection entries: 17
Dec 28 09:05:54 D-69-91-141-110 kernel: .......     : PRQ implemented: 1
Dec 28 09:05:54 D-69-91-141-110 kernel: .......     : IO APIC version: 21
Dec 28 09:05:54 D-69-91-141-110 kernel: .... register #02: 02000000
Dec 28 09:05:54 D-69-91-141-110 kernel: .......     : arbitration: 02
Dec 28 09:05:54 D-69-91-141-110 kernel: .... register #03: 02178021
Dec 28 09:05:54 D-69-91-141-110 kernel: .......     : Boot DT    : 1
Dec 28 09:05:54 D-69-91-141-110 kernel: .... IRQ redirection table:
Dec 28 09:05:54 D-69-91-141-110 kernel: IOAPIC 0:
Dec 28 09:05:54 D-69-91-141-110 kernel:  pin00, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 28 09:05:54 D-69-91-141-110 kernel:  pin01, enabled , edge , high, V(23), IRR(0), S(0), logical , D(01), M(1)
Dec 28 09:05:54 D-69-91-141-110 kernel:  pin02, enabled , edge , high, V(30), IRR(0), S(0), logical , D(01), M(1)
Dec 28 09:05:54 D-69-91-141-110 kernel:  pin03, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 28 09:05:54 D-69-91-141-110 kernel:  pin04, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 28 09:05:54 D-69-91-141-110 kernel:  pin05, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 28 09:05:54 D-69-91-141-110 kernel:  pin06, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 28 09:05:54 D-69-91-141-110 kernel:  pin07, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 28 09:05:54 D-69-91-141-110 kernel:  pin08, enabled , edge , high, V(24), IRR(0), S(0), logical , D(01), M(1)
Dec 28 09:05:54 D-69-91-141-110 kernel:  pin09, enabled , level, low , V(21), IRR(0), S(0), logical , D(01), M(1)
Dec 28 09:05:54 D-69-91-141-110 kernel:  pin0a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 28 09:05:54 D-69-91-141-110 kernel:  pin0b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 28 09:05:54 D-69-91-141-110 kernel:  pin0c, enabled , edge , high, V(22), IRR(0), S(0), logical , D(01), M(1)
Dec 28 09:05:54 D-69-91-141-110 kernel:  pin0d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 28 09:05:54 D-69-91-141-110 kernel:  pin0e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 28 09:05:54 D-69-91-141-110 kernel:  pin0f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 28 09:05:54 D-69-91-141-110 kernel:  pin10, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 28 09:05:54 D-69-91-141-110 kernel:  pin11, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 28 09:05:54 D-69-91-141-110 kernel:  pin12, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 28 09:05:54 D-69-91-141-110 kernel:  pin13, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 28 09:05:54 D-69-91-141-110 kernel:  pin14, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 28 09:05:54 D-69-91-141-110 kernel:  pin15, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 28 09:05:54 D-69-91-141-110 kernel:  pin16, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 28 09:05:54 D-69-91-141-110 kernel:  pin17, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 28 09:05:54 D-69-91-141-110 kernel: IRQ to pin mappings:
Dec 28 09:05:54 D-69-91-141-110 kernel: IRQ0 -> 0:2
Dec 28 09:05:54 D-69-91-141-110 kernel: IRQ1 -> 0:1
Dec 28 09:05:54 D-69-91-141-110 kernel: IRQ3 -> 0:3
Dec 28 09:05:54 D-69-91-141-110 kernel: IRQ4 -> 0:4
Dec 28 09:05:54 D-69-91-141-110 kernel: IRQ5 -> 0:5
Dec 28 09:05:54 D-69-91-141-110 kernel: IRQ6 -> 0:6
Dec 28 09:05:54 D-69-91-141-110 kernel: IRQ7 -> 0:7
Dec 28 09:05:54 D-69-91-141-110 kernel: IRQ8 -> 0:8
Dec 28 09:05:54 D-69-91-141-110 kernel: IRQ9 -> 0:9
Dec 28 09:05:54 D-69-91-141-110 kernel: IRQ10 -> 0:10
Dec 28 09:05:54 D-69-91-141-110 kernel: IRQ11 -> 0:11
Dec 28 09:05:54 D-69-91-141-110 kernel: IRQ12 -> 0:12
Dec 28 09:05:54 D-69-91-141-110 kernel: IRQ13 -> 0:13
Dec 28 09:05:54 D-69-91-141-110 kernel: IRQ14 -> 0:14
Dec 28 09:05:54 D-69-91-141-110 kernel: IRQ15 -> 0:15
Dec 28 09:05:54 D-69-91-141-110 kernel: .................................... done.
Dec 28 09:05:54 D-69-91-141-110 kernel: Using IPI No-Shortcut mode
Dec 28 09:05:54 D-69-91-141-110 kernel: registered taskstats version 1
Dec 28 09:05:54 D-69-91-141-110 kernel: Loading compiled-in X.509 certificates
Dec 28 09:05:54 D-69-91-141-110 kernel: zswap: loaded using pool lzo/zbud
Dec 28 09:05:54 D-69-91-141-110 kernel: ima: No TPM chip found, activating TPM-bypass! (rc=-19)
Dec 28 09:05:54 D-69-91-141-110 kernel: rtc_cmos 00:00: setting system clock to 2017-12-28 14:05:48 UTC (1514469948)
Dec 28 09:05:54 D-69-91-141-110 kernel: Freeing unused kernel memory: 604K
Dec 28 09:05:54 D-69-91-141-110 kernel: Write protecting the kernel text: 5868k
Dec 28 09:05:54 D-69-91-141-110 kernel: Write protecting the kernel read-only data: 1860k
Dec 28 09:05:54 D-69-91-141-110 kernel: NX-protecting the kernel data: 4372k
Dec 28 09:05:54 D-69-91-141-110 kernel: ------------[ cut here ]------------
Dec 28 09:05:54 D-69-91-141-110 kernel: x86/mm: Found insecure W+X mapping at address aba355b0/0xc00a0000
Dec 28 09:05:54 D-69-91-141-110 kernel: WARNING: CPU: 1 PID: 1 at arch/x86/mm/dump_pagetables.c:257 note_page+0x5ec/0x790
Dec 28 09:05:54 D-69-91-141-110 kernel: Modules linked in:
Dec 28 09:05:54 D-69-91-141-110 kernel: CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.15.0-rc5-dou-p+ #1
Dec 28 09:05:54 D-69-91-141-110 kernel: Hardware name: ASUSTeK Computer Inc. F5RL                /F5RL      , BIOS 210     06/12/2008
Dec 28 09:05:54 D-69-91-141-110 kernel: EIP: note_page+0x5ec/0x790
Dec 28 09:05:54 D-69-91-141-110 kernel: EFLAGS: 00210282 CPU: 1
Dec 28 09:05:54 D-69-91-141-110 kernel: EAX: 00000041 EBX: f70c7f54 ECX: 00000001 EDX: c58de544
Dec 28 09:05:54 D-69-91-141-110 kernel: ESI: 80000000 EDI: 00000000 EBP: f70c7f20 ESP: f70c7ef4
Dec 28 09:05:54 D-69-91-141-110 kernel:  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
Dec 28 09:05:54 D-69-91-141-110 kernel: CR0: 80050033 CR2: 00000000 CR3: 058ce000 CR4: 000006f0
Dec 28 09:05:54 D-69-91-141-110 kernel: Call Trace:
Dec 28 09:05:54 D-69-91-141-110 kernel:  ptdump_walk_pgd_level_core+0x15c/0x240
Dec 28 09:05:54 D-69-91-141-110 kernel:  ptdump_walk_pgd_level_checkwx+0x11/0x20
Dec 28 09:05:54 D-69-91-141-110 kernel:  mark_rodata_ro+0xd5/0xf1
Dec 28 09:05:54 D-69-91-141-110 kernel:  ? rest_init+0x90/0x90
Dec 28 09:05:54 D-69-91-141-110 kernel:  kernel_init+0x24/0xe0
Dec 28 09:05:54 D-69-91-141-110 kernel:  ret_from_fork+0x19/0x24
Dec 28 09:05:54 D-69-91-141-110 kernel: Code: fa ff ff 83 c2 0c c7 43 18 00 00 00 00 89 53 14 e9 1a fd ff ff 8b 43 0c c6 05 c4 76 80 c5 01 50 50 68 50 ee 6c c5 e8 84 5c 00 00 <0f> ff 83 c4 0c e9 6f fa ff ff ff 72 10 68 1c ed 6c c5 e8 57 f5
Dec 28 09:05:54 D-69-91-141-110 kernel: ---[ end trace b8f17b3016591db6 ]---
Dec 28 09:05:54 D-69-91-141-110 kernel: x86/mm: Checked W+X mappings: FAILED, 96 W+X pages found.
Dec 28 09:05:54 D-69-91-141-110 kernel: input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
Dec 28 09:05:54 D-69-91-141-110 kernel: Atheros(R) L2 Ethernet Driver - version 2.2.3
Dec 28 09:05:54 D-69-91-141-110 kernel: Copyright (c) 2007 Atheros Corporation.
Dec 28 09:05:54 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-18 -> 0xef -> IRQ 18 Mode:1 Active:1 Dest:1)
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: bus type USB registered
Dec 28 09:05:54 D-69-91-141-110 kernel: usbcore: registered new interface driver usbfs
Dec 28 09:05:54 D-69-91-141-110 kernel: usbcore: registered new interface driver hub
Dec 28 09:05:54 D-69-91-141-110 kernel: usbcore: registered new device driver usb
Dec 28 09:05:54 D-69-91-141-110 kernel: ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
Dec 28 09:05:54 D-69-91-141-110 kernel: ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
Dec 28 09:05:54 D-69-91-141-110 kernel: ehci-pci: EHCI PCI platform driver
Dec 28 09:05:54 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-19 -> 0xef -> IRQ 19 Mode:1 Active:1 Dest:1)
Dec 28 09:05:54 D-69-91-141-110 kernel: ehci-pci 0000:00:13.5: EHCI Host Controller
Dec 28 09:05:54 D-69-91-141-110 kernel: ehci-pci 0000:00:13.5: new USB bus registered, assigned bus number 1
Dec 28 09:05:54 D-69-91-141-110 kernel: ehci-pci 0000:00:13.5: applying AMD SB600/SB700 USB freeze workaround
Dec 28 09:05:54 D-69-91-141-110 kernel: ehci-pci 0000:00:13.5: debug port 1
Dec 28 09:05:54 D-69-91-141-110 kernel: ehci-pci 0000:00:13.5: irq 19, io mem 0xfebff800
Dec 28 09:05:54 D-69-91-141-110 kernel: SCSI subsystem initialized
Dec 28 09:05:54 D-69-91-141-110 kernel: libata version 3.00 loaded.
Dec 28 09:05:54 D-69-91-141-110 kernel: ehci-pci 0000:00:13.5: USB 2.0 started, EHCI 1.00
Dec 28 09:05:54 D-69-91-141-110 kernel: usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
Dec 28 09:05:54 D-69-91-141-110 kernel: usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Dec 28 09:05:54 D-69-91-141-110 kernel: usb usb1: Product: EHCI Host Controller
Dec 28 09:05:54 D-69-91-141-110 kernel: usb usb1: Manufacturer: Linux 4.15.0-rc5-dou-p+ ehci_hcd
Dec 28 09:05:54 D-69-91-141-110 kernel: usb usb1: SerialNumber: 0000:00:13.5
Dec 28 09:05:54 D-69-91-141-110 kernel: hub 1-0:1.0: USB hub found
Dec 28 09:05:54 D-69-91-141-110 kernel: hub 1-0:1.0: 10 ports detected
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI Warning: SystemIO range 0x0000000000000B00-0x0000000000000B08 conflicts with OpRegion 0x0000000000000B00-0x0000000000000B0F (\SMB0) (20170831/utaddress-247)
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
Dec 28 09:05:54 D-69-91-141-110 kernel: ohci-pci: OHCI PCI platform driver
Dec 28 09:05:54 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-16 -> 0xef -> IRQ 16 Mode:1 Active:1 Dest:1)
Dec 28 09:05:54 D-69-91-141-110 kernel: ohci-pci 0000:00:13.0: OHCI PCI host controller
Dec 28 09:05:54 D-69-91-141-110 kernel: ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 2
Dec 28 09:05:54 D-69-91-141-110 kernel: ohci-pci 0000:00:13.0: irq 16, io mem 0xfebfe000
Dec 28 09:05:54 D-69-91-141-110 kernel: usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
Dec 28 09:05:54 D-69-91-141-110 kernel: usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Dec 28 09:05:54 D-69-91-141-110 kernel: usb usb2: Product: OHCI PCI host controller
Dec 28 09:05:54 D-69-91-141-110 kernel: usb usb2: Manufacturer: Linux 4.15.0-rc5-dou-p+ ohci_hcd
Dec 28 09:05:54 D-69-91-141-110 kernel: usb usb2: SerialNumber: 0000:00:13.0
Dec 28 09:05:54 D-69-91-141-110 kernel: hub 2-0:1.0: USB hub found
Dec 28 09:05:54 D-69-91-141-110 kernel: hub 2-0:1.0: 2 ports detected
Dec 28 09:05:54 D-69-91-141-110 kernel: scsi host0: pata_atiixp
Dec 28 09:05:54 D-69-91-141-110 kernel: scsi host1: pata_atiixp
Dec 28 09:05:54 D-69-91-141-110 kernel: ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xff00 irq 14
Dec 28 09:05:54 D-69-91-141-110 kernel: ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xff08 irq 15
Dec 28 09:05:54 D-69-91-141-110 kernel: ahci 0000:00:12.0: version 3.0
Dec 28 09:05:54 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-22 -> 0xef -> IRQ 22 Mode:1 Active:1 Dest:1)
Dec 28 09:05:54 D-69-91-141-110 kernel: ahci 0000:00:12.0: controller can't do 64bit DMA, forcing 32bit
Dec 28 09:05:54 D-69-91-141-110 kernel: ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
Dec 28 09:05:54 D-69-91-141-110 kernel: ahci 0000:00:12.0: flags: ncq sntf ilck led clo pmp pio slum part ccc 
Dec 28 09:05:54 D-69-91-141-110 kernel: scsi host2: ahci
Dec 28 09:05:54 D-69-91-141-110 kernel: scsi host3: ahci
Dec 28 09:05:54 D-69-91-141-110 kernel: scsi host4: ahci
Dec 28 09:05:54 D-69-91-141-110 kernel: scsi host5: ahci
Dec 28 09:05:54 D-69-91-141-110 kernel: ata3: SATA max UDMA/133 abar m1024@0xfebffc00 port 0xfebffd00 irq 22
Dec 28 09:05:54 D-69-91-141-110 kernel: ata4: SATA max UDMA/133 abar m1024@0xfebffc00 port 0xfebffd80 irq 22
Dec 28 09:05:54 D-69-91-141-110 kernel: ata5: SATA max UDMA/133 abar m1024@0xfebffc00 port 0xfebffe00 irq 22
Dec 28 09:05:54 D-69-91-141-110 kernel: ata6: SATA max UDMA/133 abar m1024@0xfebffc00 port 0xfebffe80 irq 22
Dec 28 09:05:54 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-17 -> 0xef -> IRQ 17 Mode:1 Active:1 Dest:1)
Dec 28 09:05:54 D-69-91-141-110 kernel: ohci-pci 0000:00:13.1: OHCI PCI host controller
Dec 28 09:05:54 D-69-91-141-110 kernel: ohci-pci 0000:00:13.1: new USB bus registered, assigned bus number 3
Dec 28 09:05:54 D-69-91-141-110 kernel: ohci-pci 0000:00:13.1: irq 17, io mem 0xfebfd000
Dec 28 09:05:54 D-69-91-141-110 kernel: (NULL device *): hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
Dec 28 09:05:54 D-69-91-141-110 kernel: thermal LNXTHERM:00: registered as thermal_zone0
Dec 28 09:05:54 D-69-91-141-110 kernel: ACPI: Thermal Zone [THRM] (78 C)
Dec 28 09:05:54 D-69-91-141-110 kernel: usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
Dec 28 09:05:54 D-69-91-141-110 kernel: usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Dec 28 09:05:54 D-69-91-141-110 kernel: usb usb3: Product: OHCI PCI host controller
Dec 28 09:05:54 D-69-91-141-110 kernel: usb usb3: Manufacturer: Linux 4.15.0-rc5-dou-p+ ohci_hcd
Dec 28 09:05:54 D-69-91-141-110 kernel: usb usb3: SerialNumber: 0000:00:13.1
Dec 28 09:05:54 D-69-91-141-110 kernel: hub 3-0:1.0: USB hub found
Dec 28 09:05:54 D-69-91-141-110 kernel: hub 3-0:1.0: 2 ports detected
Dec 28 09:05:54 D-69-91-141-110 kernel: ohci-pci 0000:00:13.2: OHCI PCI host controller
Dec 28 09:05:54 D-69-91-141-110 kernel: ohci-pci 0000:00:13.2: new USB bus registered, assigned bus number 4
Dec 28 09:05:54 D-69-91-141-110 kernel: ohci-pci 0000:00:13.2: irq 18, io mem 0xfebfc000
Dec 28 09:05:54 D-69-91-141-110 kernel: usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
Dec 28 09:05:54 D-69-91-141-110 kernel: usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Dec 28 09:05:54 D-69-91-141-110 kernel: usb usb4: Product: OHCI PCI host controller
Dec 28 09:05:54 D-69-91-141-110 kernel: usb usb4: Manufacturer: Linux 4.15.0-rc5-dou-p+ ohci_hcd
Dec 28 09:05:54 D-69-91-141-110 kernel: usb usb4: SerialNumber: 0000:00:13.2
Dec 28 09:05:54 D-69-91-141-110 kernel: hub 4-0:1.0: USB hub found
Dec 28 09:05:54 D-69-91-141-110 kernel: hub 4-0:1.0: 2 ports detected
Dec 28 09:05:54 D-69-91-141-110 kernel: ohci-pci 0000:00:13.3: OHCI PCI host controller
Dec 28 09:05:54 D-69-91-141-110 kernel: ohci-pci 0000:00:13.3: new USB bus registered, assigned bus number 5
Dec 28 09:05:54 D-69-91-141-110 kernel: ohci-pci 0000:00:13.3: irq 17, io mem 0xfebfb000
Dec 28 09:05:54 D-69-91-141-110 kernel: ata1.00: ATAPI: HL-DT-ST DVDRAM GSA-T40N, JR03, max UDMA/33
Dec 28 09:05:54 D-69-91-141-110 kernel: usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
Dec 28 09:05:54 D-69-91-141-110 kernel: usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Dec 28 09:05:54 D-69-91-141-110 kernel: usb usb5: Product: OHCI PCI host controller
Dec 28 09:05:54 D-69-91-141-110 kernel: usb usb5: Manufacturer: Linux 4.15.0-rc5-dou-p+ ohci_hcd
Dec 28 09:05:54 D-69-91-141-110 kernel: usb usb5: SerialNumber: 0000:00:13.3
Dec 28 09:05:54 D-69-91-141-110 kernel: hub 5-0:1.0: USB hub found
Dec 28 09:05:54 D-69-91-141-110 kernel: hub 5-0:1.0: 2 ports detected
Dec 28 09:05:54 D-69-91-141-110 kernel: ohci-pci 0000:00:13.4: OHCI PCI host controller
Dec 28 09:05:54 D-69-91-141-110 kernel: ohci-pci 0000:00:13.4: new USB bus registered, assigned bus number 6
Dec 28 09:05:54 D-69-91-141-110 kernel: ohci-pci 0000:00:13.4: irq 18, io mem 0xfebfa000
Dec 28 09:05:54 D-69-91-141-110 kernel: ata1.00: configured for UDMA/33
Dec 28 09:05:54 D-69-91-141-110 kernel: scsi 0:0:0:0: CD-ROM            HL-DT-ST DVDRAM GSA-T40N  JR03 PQ: 0 ANSI: 5
Dec 28 09:05:54 D-69-91-141-110 kernel: usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
Dec 28 09:05:54 D-69-91-141-110 kernel: usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Dec 28 09:05:54 D-69-91-141-110 kernel: usb usb6: Product: OHCI PCI host controller
Dec 28 09:05:54 D-69-91-141-110 kernel: usb usb6: Manufacturer: Linux 4.15.0-rc5-dou-p+ ohci_hcd
Dec 28 09:05:54 D-69-91-141-110 kernel: usb usb6: SerialNumber: 0000:00:13.4
Dec 28 09:05:54 D-69-91-141-110 kernel: hub 6-0:1.0: USB hub found
Dec 28 09:05:54 D-69-91-141-110 kernel: hub 6-0:1.0: 2 ports detected
Dec 28 09:05:54 D-69-91-141-110 kernel: usb 1-4: new high-speed USB device number 2 using ehci-pci
Dec 28 09:05:54 D-69-91-141-110 kernel: ata6: SATA link down (SStatus 0 SControl 300)
Dec 28 09:05:54 D-69-91-141-110 kernel: ata5: SATA link down (SStatus 0 SControl 300)
Dec 28 09:05:54 D-69-91-141-110 kernel: ata4: SATA link down (SStatus 0 SControl 300)
Dec 28 09:05:54 D-69-91-141-110 kernel: usb 1-4: New USB device found, idVendor=0bda, idProduct=0116
Dec 28 09:05:54 D-69-91-141-110 kernel: usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
Dec 28 09:05:54 D-69-91-141-110 kernel: usb 1-4: Product: USB2.0-CRW
Dec 28 09:05:54 D-69-91-141-110 kernel: usb 1-4: Manufacturer: Generic
Dec 28 09:05:54 D-69-91-141-110 kernel: usb 1-4: SerialNumber: 20021111153705700
Dec 28 09:05:54 D-69-91-141-110 kernel: usb-storage 1-4:1.0: USB Mass Storage device detected
Dec 28 09:05:54 D-69-91-141-110 kernel: scsi host6: usb-storage 1-4:1.0
Dec 28 09:05:54 D-69-91-141-110 kernel: usbcore: registered new interface driver usb-storage
Dec 28 09:05:54 D-69-91-141-110 kernel: usbcore: registered new interface driver uas
Dec 28 09:05:54 D-69-91-141-110 kernel: ata3: softreset failed (device not ready)
Dec 28 09:05:54 D-69-91-141-110 kernel: ata3: applying PMP SRST workaround and retrying
Dec 28 09:05:54 D-69-91-141-110 kernel: usb 1-7: new high-speed USB device number 3 using ehci-pci
Dec 28 09:05:54 D-69-91-141-110 kernel: ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Dec 28 09:05:54 D-69-91-141-110 kernel: ata3.00: ATA-8: ST9250827AS, 3.AAA, max UDMA/133
Dec 28 09:05:54 D-69-91-141-110 kernel: ata3.00: 488397168 sectors, multi 16: LBA48 NCQ (depth 31/32)
Dec 28 09:05:54 D-69-91-141-110 kernel: ata3.00: SB600 AHCI: limiting to 255 sectors per cmd
Dec 28 09:05:54 D-69-91-141-110 kernel: ata3.00: SB600 AHCI: limiting to 255 sectors per cmd
Dec 28 09:05:54 D-69-91-141-110 kernel: ata3.00: configured for UDMA/133
Dec 28 09:05:54 D-69-91-141-110 kernel: scsi 2:0:0:0: Direct-Access     ATA      ST9250827AS      A    PQ: 0 ANSI: 5
Dec 28 09:05:54 D-69-91-141-110 kernel: sd 2:0:0:0: [sda] 488397168 512-byte logical blocks: (250 GB/233 GiB)
Dec 28 09:05:54 D-69-91-141-110 kernel: sd 2:0:0:0: [sda] Write Protect is off
Dec 28 09:05:54 D-69-91-141-110 kernel: sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
Dec 28 09:05:54 D-69-91-141-110 kernel: sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Dec 28 09:05:54 D-69-91-141-110 kernel: sr 0:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
Dec 28 09:05:54 D-69-91-141-110 kernel: cdrom: Uniform CD-ROM driver Revision: 3.20
Dec 28 09:05:54 D-69-91-141-110 kernel: sr 0:0:0:0: Attached scsi CD-ROM sr0
Dec 28 09:05:54 D-69-91-141-110 kernel:  sda: sda1 sda2 < sda5 >
Dec 28 09:05:54 D-69-91-141-110 kernel: sd 2:0:0:0: [sda] Attached SCSI disk
Dec 28 09:05:54 D-69-91-141-110 kernel: usb 1-7: New USB device found, idVendor=174f, idProduct=5a31
Dec 28 09:05:54 D-69-91-141-110 kernel: usb 1-7: New USB device strings: Mfr=2, Product=1, SerialNumber=3
Dec 28 09:05:54 D-69-91-141-110 kernel: usb 1-7: Product: USB 2.0 Camera
Dec 28 09:05:54 D-69-91-141-110 kernel: usb 1-7: Manufacturer: Sonix Technology Co., Ltd.
Dec 28 09:05:54 D-69-91-141-110 kernel: usb 1-7: SerialNumber: SN0001
Dec 28 09:05:54 D-69-91-141-110 kernel: psmouse serio4: synaptics: Touchpad model: 1, fw: 6.1, id: 0xa3a0b3, caps: 0xa04713/0x10008/0x0/0x0, board id: 0, fw id: 30712
Dec 28 09:05:54 D-69-91-141-110 kernel: input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio4/input/input8
Dec 28 09:05:54 D-69-91-141-110 kernel: PM: Starting manual resume from disk
Dec 28 09:05:54 D-69-91-141-110 kernel: PM: Image not found (code -22)
Dec 28 09:05:54 D-69-91-141-110 kernel: scsi 6:0:0:0: Direct-Access     Generic- xD/SDMMC/MS/Pro  1.00 PQ: 0 ANSI: 0 CCS
Dec 28 09:05:54 D-69-91-141-110 kernel: sd 6:0:0:0: [sdb] 62333952 512-byte logical blocks: (31.9 GB/29.7 GiB)
Dec 28 09:05:54 D-69-91-141-110 kernel: sd 6:0:0:0: [sdb] Write Protect is off
Dec 28 09:05:54 D-69-91-141-110 kernel: sd 6:0:0:0: [sdb] Mode Sense: 03 00 00 00
Dec 28 09:05:54 D-69-91-141-110 kernel: sd 6:0:0:0: [sdb] No Caching mode page found
Dec 28 09:05:54 D-69-91-141-110 kernel: sd 6:0:0:0: [sdb] Assuming drive cache: write through
Dec 28 09:05:54 D-69-91-141-110 kernel:  sdb: sdb1
Dec 28 09:05:54 D-69-91-141-110 kernel: sd 6:0:0:0: [sdb] Attached SCSI removable disk
Dec 28 09:05:54 D-69-91-141-110 kernel: EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
Dec 28 09:05:54 D-69-91-141-110 kernel: random: crng init done
Dec 28 09:05:54 D-69-91-141-110 kernel: ip_tables: (C) 2000-2006 Netfilter Core Team
Dec 28 09:05:54 D-69-91-141-110 systemd[1]: systemd 232 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
Dec 28 09:05:54 D-69-91-141-110 systemd[1]: Detected architecture x86.
Dec 28 09:05:54 D-69-91-141-110 systemd[1]: Set hostname to <D-69-91-141-110>.
Dec 28 09:05:54 D-69-91-141-110 systemd[1]: Configuration file /etc/systemd/system/kdump.service is marked executable. Please remove executable permission bits. Proceeding anyway.
Dec 28 09:05:54 D-69-91-141-110 systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
Dec 28 09:05:54 D-69-91-141-110 systemd[1]: Listening on Syslog Socket.
Dec 28 09:05:54 D-69-91-141-110 systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
Dec 28 09:05:54 D-69-91-141-110 systemd[1]: Reached target Remote File Systems.
Dec 28 09:05:54 D-69-91-141-110 systemd[1]: Listening on Journal Socket (/dev/log).
Dec 28 09:05:54 D-69-91-141-110 systemd[1]: Listening on udev Control Socket.
Dec 28 09:05:54 D-69-91-141-110 systemd-journald[190]: Journal started
Dec 28 09:05:54 D-69-91-141-110 systemd-journald[190]: Runtime journal (/run/log/journal/232ecae4e62643e0ac09bafad7167a6f) is 3.3M, max 26.5M, 23.1M free.
Dec 28 09:05:54 D-69-91-141-110 systemd[1]: Started Load Kernel Modules.
Dec 28 09:05:54 D-69-91-141-110 systemd[1]: Starting Apply Kernel Variables...
Dec 28 09:05:55 D-69-91-141-110 systemd[1]: Mounted Huge Pages File System.
Dec 28 09:05:55 D-69-91-141-110 systemd[1]: Mounted Debug File System.
Dec 28 09:05:55 D-69-91-141-110 systemd[1]: Mounted POSIX Message Queue File System.
Dec 28 09:05:55 D-69-91-141-110 systemd[1]: Started Remount Root and Kernel File Systems.
Dec 28 09:05:55 D-69-91-141-110 kernel: EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
Dec 28 09:05:55 D-69-91-141-110 systemd[1]: Starting udev Coldplug all Devices...
Dec 28 09:05:55 D-69-91-141-110 systemd[1]: Starting Load/Save Random Seed...
Dec 28 09:05:55 D-69-91-141-110 systemd[1]: Starting Flush Journal to Persistent Storage...
Dec 28 09:05:55 D-69-91-141-110 systemd[1]: Started Apply Kernel Variables.
Dec 28 09:05:55 D-69-91-141-110 systemd[1]: Started udev Coldplug all Devices.
Dec 28 09:05:55 D-69-91-141-110 systemd[1]: Started Load/Save Random Seed.
Dec 28 09:05:55 D-69-91-141-110 systemd-journald[190]: Time spent on flushing to /var is 30.879ms for 799 entries.
Dec 28 09:05:55 D-69-91-141-110 systemd-journald[190]: System journal (/var/log/journal/232ecae4e62643e0ac09bafad7167a6f) is 792.1M, max 2.5G, 1.7G free.
Dec 28 09:06:06 D-69-91-141-110 kernel: ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
Dec 28 09:06:06 D-69-91-141-110 kernel: acpi device:02: registered as cooling_device2
Dec 28 09:06:06 D-69-91-141-110 kernel: input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A03:00/device:00/LNXVIDEO:00/input/input9
Dec 28 09:06:06 D-69-91-141-110 kernel: asus_laptop: Asus Laptop Support version 0.42
Dec 28 09:06:06 D-69-91-141-110 kernel: asus_laptop:   F5RL model detected
Dec 28 09:06:06 D-69-91-141-110 kernel: input: Asus Laptop extra buttons as /devices/platform/asus_laptop/input/input10
Dec 28 09:06:06 D-69-91-141-110 kernel: input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input11
Dec 28 09:06:06 D-69-91-141-110 kernel: ACPI: Lid Switch [LID]
Dec 28 09:06:06 D-69-91-141-110 kernel: input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input12
Dec 28 09:06:06 D-69-91-141-110 kernel: ACPI: Power Button [PWRB]
Dec 28 09:06:06 D-69-91-141-110 kernel: input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input13
Dec 28 09:06:06 D-69-91-141-110 kernel: ACPI: Sleep Button [SLPB]
Dec 28 09:06:06 D-69-91-141-110 kernel: input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input14
Dec 28 09:06:06 D-69-91-141-110 kernel: ACPI: Power Button [PWRF]
Dec 28 09:06:06 D-69-91-141-110 kernel: ACPI: AC Adapter [AC0] (on-line)
Dec 28 09:06:06 D-69-91-141-110 kernel: ACPI: Battery Slot [BAT0] (battery absent)
Dec 28 09:06:06 D-69-91-141-110 kernel: shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
Dec 28 09:06:06 D-69-91-141-110 kernel: sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver v0.05
Dec 28 09:06:06 D-69-91-141-110 kernel: sp5100_tco: PCI Vendor ID: 0x1002, Device ID: 0x4385, Revision ID: 0x13
Dec 28 09:06:06 D-69-91-141-110 kernel: sp5100_tco: failed to find MMIO address, giving up.
Dec 28 09:06:06 D-69-91-141-110 kernel: sr 0:0:0:0: Attached scsi generic sg0 type 5
Dec 28 09:06:06 D-69-91-141-110 kernel: sd 2:0:0:0: Attached scsi generic sg1 type 0
Dec 28 09:06:06 D-69-91-141-110 kernel: sd 6:0:0:0: Attached scsi generic sg2 type 0
Dec 28 09:06:06 D-69-91-141-110 kernel: intel_powerclamp: No package C-state available
Dec 28 09:06:06 D-69-91-141-110 kernel: cfg80211: Loading compiled-in X.509 certificates for regulatory database
Dec 28 09:06:06 D-69-91-141-110 kernel: cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
Dec 28 09:06:06 D-69-91-141-110 kernel: platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
Dec 28 09:06:06 D-69-91-141-110 kernel: cfg80211: failed to load regulatory.db
Dec 28 09:06:06 D-69-91-141-110 kernel: input: PC Speaker as /devices/platform/pcspkr/input/input15
Dec 28 09:06:06 D-69-91-141-110 kernel: ath5k 0000:02:00.0: can't disable ASPM; OS doesn't have ASPM control
Dec 28 09:06:06 D-69-91-141-110 kernel: ath5k 0000:02:00.0: registered as 'phy0'
Dec 28 09:06:06 D-69-91-141-110 kernel: [drm] radeon kernel modesetting enabled.
Dec 28 09:06:06 D-69-91-141-110 kernel: [drm] initializing kernel modesetting (RS400 0x1002:0x5A62 0x1043:0x1402 0x00).
Dec 28 09:06:06 D-69-91-141-110 kernel: resource sanity check: requesting [mem 0x000c0000-0x000dffff], which spans more than PCI Bus 0000:00 [mem 0x000d0000-0x000dffff window]
Dec 28 09:06:06 D-69-91-141-110 kernel: caller pci_map_rom+0x58/0xf0 mapping multiple BARs
Dec 28 09:06:06 D-69-91-141-110 kernel: [drm] Generation 2 PCI interface, using max accessible memory
Dec 28 09:06:06 D-69-91-141-110 kernel: radeon 0000:01:05.0: VRAM: 128M 0x00000000B8000000 - 0x00000000BFFFFFFF (128M used)
Dec 28 09:06:06 D-69-91-141-110 kernel: radeon 0000:01:05.0: GTT: 512M 0x0000000080000000 - 0x000000009FFFFFFF
Dec 28 09:06:06 D-69-91-141-110 kernel: [drm] Detected VRAM RAM=128M, BAR=256M
Dec 28 09:06:06 D-69-91-141-110 kernel: [drm] RAM width 128bits DDR
Dec 28 09:06:06 D-69-91-141-110 kernel: [TTM] Zone  kernel: Available graphics memory: 304080 kiB
Dec 28 09:06:06 D-69-91-141-110 kernel: [TTM] Zone highmem: Available graphics memory: 1357588 kiB
Dec 28 09:06:06 D-69-91-141-110 kernel: [TTM] Initializing pool allocator
Dec 28 09:06:06 D-69-91-141-110 kernel: [TTM] Initializing DMA pool allocator
Dec 28 09:06:06 D-69-91-141-110 kernel: [drm] radeon: 128M of VRAM memory ready
Dec 28 09:06:06 D-69-91-141-110 kernel: [drm] radeon: 512M of GTT memory ready.
Dec 28 09:06:06 D-69-91-141-110 kernel: [drm] GART: num cpu pages 131072, num gpu pages 131072
Dec 28 09:06:06 D-69-91-141-110 kernel: [drm] radeon: 3 quad pipes, 1 z pipes initialized.
Dec 28 09:06:06 D-69-91-141-110 kernel: [drm] PCIE GART of 512M enabled (table at 0x0000000036500000).
Dec 28 09:06:06 D-69-91-141-110 kernel: radeon 0000:01:05.0: WB enabled
Dec 28 09:06:06 D-69-91-141-110 kernel: radeon 0000:01:05.0: fence driver on ring 0 use gpu addr 0x0000000080000000 and cpu addr 0xd004d807
Dec 28 09:06:06 D-69-91-141-110 kernel: [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
Dec 28 09:06:06 D-69-91-141-110 kernel: [drm] Driver supports precise vblank timestamp query.
Dec 28 09:06:06 D-69-91-141-110 kernel: radeon 0000:01:05.0: radeon: MSI limited to 32-bit
Dec 28 09:06:06 D-69-91-141-110 kernel: [drm] radeon: irq initialized.
Dec 28 09:06:06 D-69-91-141-110 kernel: [drm] Loading R300 Microcode
Dec 28 09:06:06 D-69-91-141-110 kernel: ath: EEPROM regdomain: 0x60
Dec 28 09:06:06 D-69-91-141-110 kernel: ath: EEPROM indicates we should expect a direct regpair map
Dec 28 09:06:06 D-69-91-141-110 kernel: ath: Country alpha2 being used: 00
Dec 28 09:06:06 D-69-91-141-110 kernel: ath: Regpair used: 0x60
Dec 28 09:06:06 D-69-91-141-110 kernel: [drm] radeon: ring at 0x0000000080001000
Dec 28 09:06:06 D-69-91-141-110 kernel: [drm] ring test succeeded in 1 usecs
Dec 28 09:06:06 D-69-91-141-110 kernel: [drm] ib test succeeded in 0 usecs
Dec 28 09:06:06 D-69-91-141-110 kernel: [drm] Panel ID String: AUO                     
Dec 28 09:06:06 D-69-91-141-110 kernel: [drm] Panel Size 1280x800
Dec 28 09:06:06 D-69-91-141-110 kernel: [drm] Radeon Display Connectors
Dec 28 09:06:06 D-69-91-141-110 kernel: [drm] Connector 0:
Dec 28 09:06:06 D-69-91-141-110 kernel: [drm]   VGA-1
Dec 28 09:06:06 D-69-91-141-110 kernel: [drm]   DDC: 0x68 0x68 0x68 0x68 0x68 0x68 0x68 0x68
Dec 28 09:06:06 D-69-91-141-110 kernel: [drm]   Encoders:
Dec 28 09:06:06 D-69-91-141-110 kernel: [drm]     CRT1: INTERNAL_DAC2
Dec 28 09:06:06 D-69-91-141-110 kernel: [drm] Connector 1:
Dec 28 09:06:06 D-69-91-141-110 kernel: [drm]   LVDS-1
Dec 28 09:06:06 D-69-91-141-110 kernel: [drm]   DDC: 0x198 0x198 0x19c 0x19c 0x1a0 0x1a0 0x1a4 0x1a4
Dec 28 09:06:06 D-69-91-141-110 kernel: [drm]   Encoders:
Dec 28 09:06:06 D-69-91-141-110 kernel: [drm]     LCD1: INTERNAL_LVDS
Dec 28 09:06:06 D-69-91-141-110 kernel: ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
Dec 28 09:06:06 D-69-91-141-110 kernel: ath5k: phy0: Atheros AR2425 chip found (MAC: 0xe2, PHY: 0x70)
Dec 28 09:06:06 D-69-91-141-110 kernel: [drm] fb mappable at 0xC0040000
Dec 28 09:06:06 D-69-91-141-110 kernel: [drm] vram apper at 0xC0000000
Dec 28 09:06:06 D-69-91-141-110 kernel: [drm] size 4096000
Dec 28 09:06:06 D-69-91-141-110 kernel: [drm] fb depth is 24
Dec 28 09:06:06 D-69-91-141-110 kernel: [drm]    pitch is 5120
Dec 28 09:06:06 D-69-91-141-110 kernel: fbcon: radeondrmfb (fb0) is primary device
Dec 28 09:06:06 D-69-91-141-110 kernel: Console: switching to colour frame buffer device 160x50
Dec 28 09:06:06 D-69-91-141-110 kernel: radeon 0000:01:05.0: fb0: radeondrmfb frame buffer device
Dec 28 09:06:06 D-69-91-141-110 kernel: [drm] Initialized radeon 2.50.0 20080528 for 0000:01:05.0 on minor 0
Dec 28 09:06:06 D-69-91-141-110 kernel: snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC660-VD: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
Dec 28 09:06:06 D-69-91-141-110 kernel: snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
Dec 28 09:06:06 D-69-91-141-110 kernel: snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
Dec 28 09:06:06 D-69-91-141-110 kernel: snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
Dec 28 09:06:06 D-69-91-141-110 kernel: snd_hda_codec_realtek hdaudioC0D0:    inputs:
Dec 28 09:06:06 D-69-91-141-110 kernel: snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x19
Dec 28 09:06:06 D-69-91-141-110 kernel: snd_hda_codec_realtek hdaudioC0D0:      Mic=0x18
Dec 28 09:06:06 D-69-91-141-110 kernel: input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:14.2/sound/card0/input16
Dec 28 09:06:06 D-69-91-141-110 kernel: input: HDA ATI SB Mic as /devices/pci0000:00/0000:00:14.2/sound/card0/input17
Dec 28 09:06:06 D-69-91-141-110 kernel: input: HDA ATI SB Headphone as /devices/pci0000:00/0000:00:14.2/sound/card0/input18
Dec 28 09:06:06 D-69-91-141-110 kernel: Adding 3929084k swap on /dev/sda5.  Priority:-2 extents:1 across:3929084k FS
Dec 28 09:06:06 D-69-91-141-110 kernel: media: Linux media interface: v0.10
Dec 28 09:06:06 D-69-91-141-110 kernel: Linux video capture interface: v2.00
Dec 28 09:06:04 D-69-91-141-110 mtp-probe[276]: checking bus 1, device 3: "/sys/devices/pci0000:00/0000:00:13.5/usb1/1-7"
Dec 28 09:05:55 D-69-91-141-110 systemd[1]: Started Set the console keyboard layout.
Dec 28 09:06:04 D-69-91-141-110 mtp-probe[276]: bus: 1, device: 3 was not an MTP device
Dec 28 09:05:56 D-69-91-141-110 systemd[1]: Started Create Static Device Nodes in /dev.
Dec 28 09:06:04 D-69-91-141-110 mtp-probe[279]: checking bus 1, device 2: "/sys/devices/pci0000:00/0000:00:13.5/usb1/1-4"
Dec 28 09:05:56 D-69-91-141-110 systemd[1]: Reached target Local File Systems (Pre).
Dec 28 09:06:04 D-69-91-141-110 mtp-probe[279]: bus: 1, device: 2 was not an MTP device
Dec 28 09:05:56 D-69-91-141-110 systemd[1]: Reached target Local File Systems.
Dec 28 09:05:56 D-69-91-141-110 systemd[1]: Starting Set console font and keymap...
Dec 28 09:05:56 D-69-91-141-110 systemd[1]: Starting Raise network interfaces...
Dec 28 09:05:56 D-69-91-141-110 systemd[1]: Starting udev Kernel Device Manager...
Dec 28 09:05:56 D-69-91-141-110 systemd[1]: Started Set console font and keymap.
Dec 28 09:05:59 D-69-91-141-110 systemd[1]: Started udev Kernel Device Manager.
Dec 28 09:06:02 D-69-91-141-110 systemd[1]: Listening on Load/Save RF Kill Switch Status /dev/rfkill Watch.
Dec 28 09:06:03 D-69-91-141-110 systemd[1]: Started Raise network interfaces.
Dec 28 09:06:03 D-69-91-141-110 systemd[1]: Reached target Network.
Dec 28 09:06:03 D-69-91-141-110 systemd[1]: Reached target Network is Online.
Dec 28 09:06:04 D-69-91-141-110 systemd[1]: Starting Load/Save RF Kill Switch Status...
Dec 28 09:06:04 D-69-91-141-110 systemd[1]: Created slice system-systemd\x2dbacklight.slice.
Dec 28 09:06:04 D-69-91-141-110 systemd[1]: Starting Load/Save Screen Backlight Brightness of backlight:acpi_video0...
Dec 28 09:06:04 D-69-91-141-110 systemd[1]: Started Load/Save Screen Backlight Brightness of backlight:acpi_video0.
Dec 28 09:06:05 D-69-91-141-110 systemd[1]: Found device ST9250827AS 5.
Dec 28 09:06:05 D-69-91-141-110 systemd[1]: Activating swap /dev/disk/by-uuid/5e6263b1-75fa-4003-bc51-9dd4c11f7177...
Dec 28 09:06:05 D-69-91-141-110 systemd[1]: Activated swap /dev/disk/by-uuid/5e6263b1-75fa-4003-bc51-9dd4c11f7177.
Dec 28 09:06:05 D-69-91-141-110 systemd[1]: Reached target Swap.
Dec 28 09:06:05 D-69-91-141-110 systemd[1]: Reached target Sound Card.
Dec 28 09:06:05 D-69-91-141-110 systemd[1]: Started Flush Journal to Persistent Storage.
Dec 28 09:06:05 D-69-91-141-110 systemd[1]: Starting Create Volatile Files and Directories...
Dec 28 09:06:06 D-69-91-141-110 systemd[1]: Started Load/Save RF Kill Switch Status.
Dec 28 09:06:06 D-69-91-141-110 kernel: uvcvideo: Found UVC 1.00 device USB 2.0 Camera (174f:5a31)
Dec 28 09:06:06 D-69-91-141-110 kernel: uvcvideo 1-7:1.0: Entity type for entity Extension 4 was not initialized!
Dec 28 09:06:06 D-69-91-141-110 kernel: uvcvideo 1-7:1.0: Entity type for entity Processing 3 was not initialized!
Dec 28 09:06:06 D-69-91-141-110 kernel: uvcvideo 1-7:1.0: Entity type for entity Camera 1 was not initialized!
Dec 28 09:06:06 D-69-91-141-110 kernel: input: USB 2.0 Camera: USB 2.0 Camera as /devices/pci0000:00/0000:00:13.5/usb1/1-7/1-7:1.0/input/input19
Dec 28 09:06:06 D-69-91-141-110 kernel: usbcore: registered new interface driver uvcvideo
Dec 28 09:06:06 D-69-91-141-110 kernel: USB Video Class driver (1.1.1)
Dec 28 09:06:06 D-69-91-141-110 systemd-udevd[255]: Process '/sbin/crda' failed with exit code 249.
Dec 28 09:06:06 D-69-91-141-110 kernel: FAT-fs (sdb1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
Dec 28 09:06:06 D-69-91-141-110 systemd-tmpfiles[398]: Cannot set file attribute for '/var/log/journal', value=0x00800000, mask=0x00800000: Operation not supported
Dec 28 09:06:06 D-69-91-141-110 systemd-tmpfiles[398]: Cannot set file attribute for '/var/log/journal/232ecae4e62643e0ac09bafad7167a6f', value=0x00800000, mask=0x00800000: Operation not supported
Dec 28 09:06:06 D-69-91-141-110 systemd[1]: Started Create Volatile Files and Directories.
Dec 28 09:06:07 D-69-91-141-110 systemd[1]: Starting Network Time Synchronization...
Dec 28 09:06:07 D-69-91-141-110 systemd[1]: Starting Update UTMP about System Boot/Shutdown...
Dec 28 09:06:07 D-69-91-141-110 systemd[1]: Started Update UTMP about System Boot/Shutdown.
Dec 28 09:06:07 D-69-91-141-110 systemd[1]: Started Network Time Synchronization.
Dec 28 09:06:07 D-69-91-141-110 systemd[1]: Reached target System Initialization.
Dec 28 09:06:07 D-69-91-141-110 systemd[1]: Started ACPI Events Check.
Dec 28 09:06:07 D-69-91-141-110 systemd[1]: Reached target Paths.
Dec 28 09:06:07 D-69-91-141-110 systemd[1]: Listening on D-Bus System Message Bus Socket.
Dec 28 09:06:07 D-69-91-141-110 systemd[1]: Listening on Avahi mDNS/DNS-SD Stack Activation Socket.
Dec 28 09:06:07 D-69-91-141-110 systemd[1]: Listening on ACPID Listen Socket.
Dec 28 09:06:07 D-69-91-141-110 systemd[1]: Reached target Sockets.
Dec 28 09:06:07 D-69-91-141-110 systemd[1]: Started Daily Cleanup of Temporary Directories.
Dec 28 09:06:07 D-69-91-141-110 systemd[1]: Reached target Basic System.
Dec 28 09:06:07 D-69-91-141-110 systemd[1]: Started irqbalance daemon.
Dec 28 09:06:07 D-69-91-141-110 systemd[1]: Starting System Logging Service...
Dec 28 09:06:07 D-69-91-141-110 systemd[1]: Starting Restore /etc/resolv.conf if the system crashed before the ppp link was shut down...
Dec 28 09:06:07 D-69-91-141-110 systemd[1]: Started ACPI event daemon.
Dec 28 09:06:07 D-69-91-141-110 systemd[1]: Starting keep memory of all UPnP devices that announced themselves...
Dec 28 09:06:07 D-69-91-141-110 systemd[1]: Starting Login Service...
Dec 28 09:06:07 D-69-91-141-110 systemd[1]: Started Regular background program processing daemon.
Dec 28 09:06:07 D-69-91-141-110 systemd[1]: Started D-Bus System Message Bus.
Dec 28 09:06:07 D-69-91-141-110 minissdpd[419]: setsockopt(udp, IP_ADD_MEMBERSHIP)(0.0.0.0): No such device
Dec 28 09:06:07 D-69-91-141-110 minissdpd[419]: Failed to add IPv4 multicast membership for interface 0.0.0.0.
Dec 28 09:06:07 D-69-91-141-110 cron[421]: (CRON) INFO (pidfile fd = 3)
Dec 28 09:06:08 D-69-91-141-110 acpid[418]: starting up with netlink and the input layer
Dec 28 09:06:08 D-69-91-141-110 cron[421]: (CRON) INFO (Running @reboot jobs)
Dec 28 09:06:08 D-69-91-141-110 acpid[418]: 1 rule loaded
Dec 28 09:06:08 D-69-91-141-110 acpid[418]: waiting for events: event logging is off
Dec 28 09:06:08 D-69-91-141-110 liblogging-stdlog[414]:  [origin software="rsyslogd" swVersion="8.24.0" x-pid="414" x-info="http://www.rsyslog.com"] start
Dec 28 09:06:09 D-69-91-141-110 dbus[422]: [system] Successfully activated service 'org.freedesktop.systemd1'
Dec 28 09:06:09 D-69-91-141-110 systemd[1]: Starting /etc/rc.local Compatibility...
Dec 28 09:06:09 D-69-91-141-110 systemd[1]: Starting Load dump capture kernel...
Dec 28 09:06:09 D-69-91-141-110 systemd[1]: Starting Save/Restore Sound Card State...
Dec 28 09:06:09 D-69-91-141-110 systemd[1]: Starting Avahi mDNS/DNS-SD Stack...
Dec 28 09:06:09 D-69-91-141-110 systemd[1]: Starting Modem Manager...
Dec 28 09:06:09 D-69-91-141-110 systemd[1]: Starting LSB: Starts and stops Wicd...
Dec 28 09:06:09 D-69-91-141-110 systemd[1]: Starting Permit User Sessions...
Dec 28 09:06:09 D-69-91-141-110 systemd[1]: Starting OpenBSD Secure Shell server...
Dec 28 09:06:09 D-69-91-141-110 systemd[1]: Reached target System Time Synchronized.
Dec 28 09:06:09 D-69-91-141-110 systemd[1]: anacron.timer: Adding 52.301310s random time.
Dec 28 09:06:09 D-69-91-141-110 systemd[1]: Started Trigger anacron every hour.
Dec 28 09:06:09 D-69-91-141-110 systemd[1]: apt-daily.timer: Adding 11h 43min 5.610520s random time.
Dec 28 09:06:09 D-69-91-141-110 systemd[1]: Started Daily apt download activities.
Dec 28 09:06:09 D-69-91-141-110 systemd[1]: Started Run anacron jobs.
Dec 28 09:06:09 D-69-91-141-110 systemd[1]: anacron.timer: Adding 2.273500s random time.
Dec 28 09:06:09 D-69-91-141-110 systemd[1]: anacron.timer: Adding 1min 16.766802s random time.
Dec 28 09:06:09 D-69-91-141-110 systemd[1]: apt-daily-upgrade.timer: Adding 4min 52.520572s random time.
Dec 28 09:06:09 D-69-91-141-110 systemd[1]: Started Daily apt upgrade and clean activities.
Dec 28 09:06:09 D-69-91-141-110 systemd[1]: Reached target Timers.
Dec 28 09:06:09 D-69-91-141-110 systemd[1]: Starting LSB: exim Mail Transport Agent...
Dec 28 09:06:09 D-69-91-141-110 systemd[1]: Started System Logging Service.
Dec 28 09:06:09 D-69-91-141-110 systemd[1]: Started Restore /etc/resolv.conf if the system crashed before the ppp link was shut down.
Dec 28 09:06:09 D-69-91-141-110 systemd[1]: Started keep memory of all UPnP devices that announced themselves.
Dec 28 09:06:09 D-69-91-141-110 systemd[1]: Started Save/Restore Sound Card State.
Dec 28 09:06:09 D-69-91-141-110 systemd-logind[420]: New seat seat0.
Dec 28 09:06:09 D-69-91-141-110 systemd[1]: Started Login Service.
Dec 28 09:06:09 D-69-91-141-110 systemd-logind[420]: Watching system buttons on /dev/input/event7 (Power Button)
Dec 28 09:06:09 D-69-91-141-110 systemd-logind[420]: Watching system buttons on /dev/input/event2 (Video Bus)
Dec 28 09:06:09 D-69-91-141-110 systemd-logind[420]: Watching system buttons on /dev/input/event5 (Power Button)
Dec 28 09:06:09 D-69-91-141-110 systemd-logind[420]: Watching system buttons on /dev/input/event4 (Lid Switch)
Dec 28 09:06:09 D-69-91-141-110 systemd-logind[420]: Watching system buttons on /dev/input/event6 (Sleep Button)
Dec 28 09:06:09 D-69-91-141-110 systemd[1]: Started /etc/rc.local Compatibility.
Dec 28 09:06:09 D-69-91-141-110 systemd[1]: Started Permit User Sessions.
Dec 28 09:06:09 D-69-91-141-110 systemd[1]: Started Getty on tty1.
Dec 28 09:06:09 D-69-91-141-110 systemd[1]: Reached target Login Prompts.
Dec 28 09:06:09 D-69-91-141-110 avahi-daemon[430]: Found user 'avahi' (UID 106) and group 'avahi' (GID 112).
Dec 28 09:06:09 D-69-91-141-110 avahi-daemon[430]: Successfully dropped root privileges.
Dec 28 09:06:09 D-69-91-141-110 avahi-daemon[430]: avahi-daemon 0.6.32 starting up.
Dec 28 09:06:10 D-69-91-141-110 anacron[437]: Anacron 2.3 started on 2017-12-28
Dec 28 09:06:10 D-69-91-141-110 avahi-daemon[430]: Successfully called chroot().
Dec 28 09:06:10 D-69-91-141-110 avahi-daemon[430]: Successfully dropped remaining capabilities.
Dec 28 09:06:10 D-69-91-141-110 systemd[1]: Started Avahi mDNS/DNS-SD Stack.
Dec 28 09:06:10 D-69-91-141-110 anacron[437]: Normal exit (0 jobs run)
Dec 28 09:06:10 D-69-91-141-110 systemd[1]: anacron.timer: Adding 43.324901s random time.
Dec 28 09:06:10 D-69-91-141-110 avahi-daemon[430]: No service file found in /etc/avahi/services.
Dec 28 09:06:10 D-69-91-141-110 avahi-daemon[430]: Network interface enumeration completed.
Dec 28 09:06:10 D-69-91-141-110 avahi-daemon[430]: Server startup complete. Host name is D-69-91-141-110.local. Local service cookie is 3772764976.
Dec 28 09:06:11 D-69-91-141-110 ModemManager[431]: <info>  ModemManager (version 1.6.4) starting in system bus...
Dec 28 09:06:11 D-69-91-141-110 sshd[436]: /etc/ssh/sshd_config line 19: Deprecated option KeyRegenerationInterval
Dec 28 09:06:11 D-69-91-141-110 sshd[436]: /etc/ssh/sshd_config line 20: Deprecated option ServerKeyBits
Dec 28 09:06:11 D-69-91-141-110 sshd[436]: /etc/ssh/sshd_config line 31: Deprecated option RSAAuthentication
Dec 28 09:06:11 D-69-91-141-110 sshd[436]: /etc/ssh/sshd_config line 38: Deprecated option RhostsRSAAuthentication
Dec 28 09:06:12 D-69-91-141-110 dbus[422]: [system] Activating via systemd: service name='org.freedesktop.PolicyKit1' unit='polkit.service'
Dec 28 09:06:12 D-69-91-141-110 systemd[1]: Starting Authorization Manager...
Dec 28 09:06:13 D-69-91-141-110 sshd[468]: /etc/ssh/sshd_config line 19: Deprecated option KeyRegenerationInterval
Dec 28 09:06:13 D-69-91-141-110 sshd[468]: /etc/ssh/sshd_config line 20: Deprecated option ServerKeyBits
Dec 28 09:06:13 D-69-91-141-110 sshd[468]: /etc/ssh/sshd_config line 31: Deprecated option RSAAuthentication
Dec 28 09:06:13 D-69-91-141-110 sshd[468]: /etc/ssh/sshd_config line 38: Deprecated option RhostsRSAAuthentication
Dec 28 09:06:13 D-69-91-141-110 sshd[468]: Server listening on 0.0.0.0 port 2200.
Dec 28 09:06:13 D-69-91-141-110 sshd[468]: Server listening on :: port 2200.
Dec 28 09:06:13 D-69-91-141-110 systemd[1]: Started OpenBSD Secure Shell server.
Dec 28 09:06:13 D-69-91-141-110 polkitd[462]: started daemon version 0.105 using authority implementation `local' version `0.105'
Dec 28 09:06:13 D-69-91-141-110 dbus[422]: [system] Successfully activated service 'org.freedesktop.PolicyKit1'
Dec 28 09:06:13 D-69-91-141-110 systemd[1]: Started Authorization Manager.
Dec 28 09:06:14 D-69-91-141-110 systemd[1]: Started Modem Manager.
Dec 28 09:06:15 D-69-91-141-110 systemd[1]: Started Load dump capture kernel.
Dec 28 09:06:16 D-69-91-141-110 wicd[432]: Starting Network connection manager: wicd.
Dec 28 09:06:16 D-69-91-141-110 systemd[1]: Started LSB: Starts and stops Wicd.
Dec 28 09:06:16 D-69-91-141-110 kernel: NET: Registered protocol family 4
Dec 28 09:06:16 D-69-91-141-110 kernel: NET: Registered protocol family 3
Dec 28 09:06:16 D-69-91-141-110 kernel: NET: Registered protocol family 5
Dec 28 09:06:16 D-69-91-141-110 kernel: IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
Dec 28 09:06:16 D-69-91-141-110 ModemManager[431]: <info>  Couldn't check support for device at '/sys/devices/pci0000:00/0000:00:04.0/0000:02:00.0': not supported by any plugin
Dec 28 09:06:16 D-69-91-141-110 ModemManager[431]: <info>  Couldn't check support for device at '/sys/devices/pci0000:00/0000:00:06.0/0000:06:00.0': not supported by any plugin
Dec 28 09:06:16 D-69-91-141-110 exim4[438]: Starting MTA: exim4.
Dec 28 09:06:16 D-69-91-141-110 systemd[1]: Started LSB: exim Mail Transport Agent.
Dec 28 09:06:16 D-69-91-141-110 systemd[1]: Reached target Multi-User System.
Dec 28 09:06:16 D-69-91-141-110 systemd[1]: Starting Update UTMP about System Runlevel Changes...
Dec 28 09:06:16 D-69-91-141-110 systemd[1]: Started Update UTMP about System Runlevel Changes.
Dec 28 09:06:16 D-69-91-141-110 systemd[1]: Startup finished in 6.959s (kernel) + 24.592s (userspace) = 31.552s.
Dec 28 09:06:19 D-69-91-141-110 login[441]: pam_unix(login:session): session opened for user chirvasitua by LOGIN(uid=0)
Dec 28 09:06:19 D-69-91-141-110 systemd[1]: Created slice User Slice of chirvasitua.
Dec 28 09:06:19 D-69-91-141-110 systemd[1]: Starting User Manager for UID 1000...
Dec 28 09:06:19 D-69-91-141-110 systemd-logind[420]: New session 1 of user chirvasitua.
Dec 28 09:06:19 D-69-91-141-110 systemd[1]: Started Session 1 of user chirvasitua.
Dec 28 09:06:19 D-69-91-141-110 systemd[736]: pam_unix(systemd-user:session): session opened for user chirvasitua by (uid=0)
Dec 28 09:06:20 D-69-91-141-110 systemd[736]: Reached target Paths.
Dec 28 09:06:20 D-69-91-141-110 systemd[736]: Listening on GnuPG cryptographic agent and passphrase cache (restricted).
Dec 28 09:06:20 D-69-91-141-110 systemd[736]: Listening on GnuPG cryptographic agent (ssh-agent emulation).
Dec 28 09:06:20 D-69-91-141-110 systemd[736]: Listening on GnuPG cryptographic agent and passphrase cache.
Dec 28 09:06:20 D-69-91-141-110 systemd[736]: Reached target Timers.
Dec 28 09:06:20 D-69-91-141-110 systemd[736]: Starting D-Bus User Message Bus Socket.
Dec 28 09:06:20 D-69-91-141-110 systemd[736]: Listening on GnuPG network certificate management daemon.
Dec 28 09:06:20 D-69-91-141-110 systemd[736]: Listening on GnuPG cryptographic agent (access for web browsers).
Dec 28 09:06:20 D-69-91-141-110 systemd[736]: Listening on D-Bus User Message Bus Socket.
Dec 28 09:06:20 D-69-91-141-110 systemd[736]: Reached target Sockets.
Dec 28 09:06:20 D-69-91-141-110 systemd[736]: Reached target Basic System.
Dec 28 09:06:20 D-69-91-141-110 systemd[736]: Reached target Default.
Dec 28 09:06:20 D-69-91-141-110 systemd[736]: Startup finished in 280ms.
Dec 28 09:06:20 D-69-91-141-110 systemd[1]: Started User Manager for UID 1000.
Dec 28 09:06:23 D-69-91-141-110 su[780]: Successful su for root by chirvasitua
Dec 28 09:06:23 D-69-91-141-110 su[780]: + /dev/tty1 chirvasitua:root
Dec 28 09:06:23 D-69-91-141-110 su[780]: pam_unix(su:session): session opened for user root by chirvasitua(uid=1000)
Dec 28 09:06:23 D-69-91-141-110 su[780]: pam_systemd(su:session): Cannot create session: Already running in a session
Dec 28 09:06:24 D-69-91-141-110 kernel: spurious APIC interrupt through vector ff on CPU#0, should never happen.
Dec 28 09:06:24 D-69-91-141-110 kernel: IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
Dec 28 09:06:23 D-69-91-141-110 kernel: NMI watchdog: Watchdog detected hard LOCKUP on cpu 0
Dec 28 09:06:23 D-69-91-141-110 kernel: Modules linked in: appletalk ax25 ipx p8023 p8022 psnap llc nls_ascii nls_cp437 vfat fat uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_core videodev media snd_hda_codec_si3054 snd_hda_codec_realtek snd_hda_codec_generic arc4 radeon snd_hda_intel ath5k snd_hda_codec snd_hda_core snd_pcsp ath snd_hwdep mac80211 snd_pcm snd_timer cfg80211 snd soundcore ttm coretemp drm_kms_helper drm joydev sg evdev i2c_algo_bit sp5100_tco fb_sys_fops syscopyarea sysfillrect sysimgblt serio_raw shpchp battery ac button asus_laptop sparse_keymap rfkill input_polldev video acpi_cpufreq ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 fscrypto sr_mod cdrom sd_mod ata_generic uas usb_storage psmouse ohci_pci ahci libahci pata_atiixp libata i2c_piix4 ehci_pci ohci_hcd ehci_hcd scsi_mod
Dec 28 09:06:24 D-69-91-141-110 kernel:  usbcore atl2 thermal
Dec 28 09:06:24 D-69-91-141-110 kernel: CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W        4.15.0-rc5-dou-p+ #1
Dec 28 09:06:24 D-69-91-141-110 kernel: Hardware name: ASUSTeK Computer Inc. F5RL                /F5RL      , BIOS 210     06/12/2008
Dec 28 09:06:24 D-69-91-141-110 kernel: EIP: tick_check_broadcast_expired+0x16/0x20
Dec 28 09:06:24 D-69-91-141-110 kernel: EFLAGS: 00000247 CPU: 0
Dec 28 09:06:24 D-69-91-141-110 kernel: EAX: 00000001 EBX: c5792180 ECX: c58bbf28 EDX: 00024dfe
Dec 28 09:06:24 D-69-91-141-110 kernel: ESI: c5792180 EDI: 00000000 EBP: c578df24 ESP: c578df24
Dec 28 09:06:24 D-69-91-141-110 kernel:  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
Dec 28 09:06:24 D-69-91-141-110 kernel: CR0: 80050033 CR2: b7bbc0c0 CR3: 364686c0 CR4: 000006f0
Dec 28 09:06:24 D-69-91-141-110 kernel: Call Trace:
Dec 28 09:06:24 D-69-91-141-110 kernel:  cpu_idle_poll+0x46/0x130
Dec 28 09:06:24 D-69-91-141-110 kernel:  do_idle+0x3d/0x1a0
Dec 28 09:06:24 D-69-91-141-110 kernel:  cpu_startup_entry+0x65/0x70
Dec 28 09:06:24 D-69-91-141-110 kernel:  rest_init+0x86/0x90
Dec 28 09:06:24 D-69-91-141-110 kernel:  start_kernel+0x371/0x38a
Dec 28 09:06:24 D-69-91-141-110 kernel:  i386_start_kernel+0x95/0x99
Dec 28 09:06:24 D-69-91-141-110 kernel:  startup_32_smp+0x164/0x168
Dec 28 09:06:24 D-69-91-141-110 kernel: Code: c3 8d 74 26 00 55 b8 60 26 90 c5 89 e5 5d c3 8d b6 00 00 00 00 55 64 a1 00 61 8b c5 89 e5 0f a3 05 58 26 90 c5 0f 92 c0 0f b6 c0 <5d> c3 90 8d b4 26 00 00 00 00 64 a1 00 61 8b c5 0f a3 05 60 26
Dec 28 09:06:24 D-69-91-141-110 kernel: NMI watchdog: Watchdog detected hard LOCKUP on cpu 1
Dec 28 09:06:24 D-69-91-141-110 kernel: Modules linked in: appletalk ax25 ipx p8023 p8022 psnap llc nls_ascii nls_cp437 vfat fat uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_core videodev media snd_hda_codec_si3054 snd_hda_codec_realtek snd_hda_codec_generic arc4 radeon snd_hda_intel ath5k snd_hda_codec snd_hda_core snd_pcsp ath snd_hwdep mac80211 snd_pcm snd_timer cfg80211 snd soundcore ttm coretemp drm_kms_helper drm joydev sg evdev i2c_algo_bit sp5100_tco fb_sys_fops syscopyarea sysfillrect sysimgblt serio_raw shpchp battery ac button asus_laptop sparse_keymap rfkill input_polldev video acpi_cpufreq ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 fscrypto sr_mod cdrom sd_mod ata_generic uas usb_storage psmouse ohci_pci ahci libahci pata_atiixp libata i2c_piix4 ehci_pci ohci_hcd ehci_hcd scsi_mod
Dec 28 09:06:24 D-69-91-141-110 kernel:  usbcore atl2 thermal
Dec 28 09:06:24 D-69-91-141-110 kernel: CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W        4.15.0-rc5-dou-p+ #1
Dec 28 09:06:24 D-69-91-141-110 kernel: Hardware name: ASUSTeK Computer Inc. F5RL                /F5RL      , BIOS 210     06/12/2008
Dec 28 09:06:24 D-69-91-141-110 kernel: EIP: tick_check_broadcast_expired+0x16/0x20
Dec 28 09:06:24 D-69-91-141-110 kernel: EFLAGS: 00000247 CPU: 1
Dec 28 09:06:24 D-69-91-141-110 kernel: EAX: 00000001 EBX: f70dea80 ECX: c58bbf28 EDX: 00028c4a
Dec 28 09:06:24 D-69-91-141-110 kernel: ESI: f70dea80 EDI: 00000001 EBP: f70e5f1c ESP: f70e5f1c
Dec 28 09:06:24 D-69-91-141-110 kernel:  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
Dec 28 09:06:24 D-69-91-141-110 kernel: CR0: 80050033 CR2: b7f7c208 CR3: 36df7ee0 CR4: 000006f0
Dec 28 09:06:24 D-69-91-141-110 kernel: Call Trace:
Dec 28 09:06:24 D-69-91-141-110 kernel:  cpu_idle_poll+0x46/0x130
Dec 28 09:06:24 D-69-91-141-110 kernel:  do_idle+0x3d/0x1a0
Dec 28 09:06:24 D-69-91-141-110 kernel:  cpu_startup_entry+0x65/0x70
Dec 28 09:06:24 D-69-91-141-110 kernel:  start_secondary+0x16b/0x210
Dec 28 09:06:24 D-69-91-141-110 kernel:  startup_32_smp+0x164/0x168
Dec 28 09:06:24 D-69-91-141-110 kernel:  ? startup_32_smp+0x164/0x168
Dec 28 09:06:24 D-69-91-141-110 kernel: Code: c3 8d 74 26 00 55 b8 60 26 90 c5 89 e5 5d c3 8d b6 00 00 00 00 55 64 a1 00 61 8b c5 89 e5 0f a3 05 58 26 90 c5 0f 92 c0 0f b6 c0 <5d> c3 90 8d b4 26 00 00 00 00 64 a1 00 61 8b c5 0f a3 05 60 26

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=log-dmesg-dou-noparam

[    0.000000] Linux version 4.15.0-rc5-dou-p+ (root@axiomatic) (gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.5)) #1 SMP Thu Dec 28 08:40:40 EST 2017
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
[    0.000000] found SMP MP-table at [mem 0x000ff780-0x000ff78f] mapped at [(ptrval)]
[    0.000000] initial memory mapped: [mem 0x00000000-0x12dfffff]
[    0.000000] Base memory trampoline at [(ptrval)] 9b000 size 16384
[    0.000000] BRK [0x129ce000, 0x129cefff] PGTABLE
[    0.000000] BRK [0x129cf000, 0x129d0fff] PGTABLE
[    0.000000] BRK [0x129d1000, 0x129d1fff] PGTABLE
[    0.000000] BRK [0x129d2000, 0x129d2fff] PGTABLE
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
[    0.000000] 2057MB HIGHMEM available.
[    0.000000] 885MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 375fe000
[    0.000000]   low ram: 0 - 375fe000
[    0.000000] Reserving 256MB of memory at 32MB for crashkernel (System RAM: 2943MB)
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] BRK [0x129d3000, 0x129d3fff] PGTABLE
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
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
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
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.15.0-rc5-dou-p+ root=UUID=5a437cd2-c27b-4829-a7ba-533eb741b148 ro 3 crashkernel=256M quiet
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] microcode: microcode updated early to revision 0xa4, date = 2010-10-02
[    0.000000] Initializing CPU#0
[    0.000000] Initializing HighMem for node 0 (000375fe:000b7fa0)
[    0.000000] Initializing Movable for node 0 (00000000:00000000)
[    0.000000] Memory: 2696356K/3013880K available (5865K kernel code, 593K rwdata, 1836K rodata, 604K init, 428K bss, 317524K reserved, 0K cma-reserved, 2107016K highmem)
[    0.000000] virtual kernel memory layout:
                   fixmap  : 0xffd36000 - 0xfffff000   (2852 kB)
                 cpu_entry : 0xff800000 - 0xff8c1000   ( 772 kB)
                   pkmap   : 0xff600000 - 0xff800000   (2048 kB)
                   vmalloc : 0xf7dfe000 - 0xff5fe000   ( 120 MB)
                   lowmem  : 0xc0000000 - 0xf75fe000   ( 885 MB)
                     .init : 0xd282e000 - 0xd28c5000   ( 604 kB)
                     .data : 0xd25ba464 - 0xd2820780   (2456 kB)
                     .text : 0xd2000000 - 0xd25ba464   (5865 kB)
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
[    0.000000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.020000] tsc: Fast TSC calibration using PIT
[    0.024000] tsc: Detected 1662.618 MHz processor
[    0.024000] Calibrating delay loop (skipped), value calculated using timer frequency.. 3325.23 BogoMIPS (lpj=6650472)
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
[    0.032000] CPU 1 irqstacks, hard=c236e815 soft=1d7674f1
[    0.032000] x86: Booting SMP configuration:
[    0.032000] .... node  #0, CPUs:      #1
[    0.004000] Initializing CPU#1
[    0.032129] smp: Brought up 1 node, 2 CPUs
[    0.032129] smpboot: Max logical packages: 1
[    0.032129] smpboot: Total of 2 processors activated (6650.47 BogoMIPS)
[    0.033767] devtmpfs: initialized
[    0.033767] PM: Registering ACPI NVS region [mem 0xb7fae000-0xb7feffff] (270336 bytes)
[    0.033767] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.033767] futex hash table entries: 512 (order: 3, 32768 bytes)
[    0.033767] pinctrl core: initialized pinctrl subsystem
[    0.033767] NET: Registered protocol family 16
[    0.033767] audit: initializing netlink subsys (disabled)
[    0.036018] audit: type=2000 audit(1514469084.036:1): state=initialized audit_enabled=0 res=1
[    0.036176] cpuidle: using governor ladder
[    0.036176] cpuidle: using governor menu
[    0.036176] Simple Boot Flag at 0xff set to 0x1
[    0.036176] ACPI: bus type PCI registered
[    0.036176] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.036204] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.036207] PCI: not using MMCONFIG
[    0.036316] PCI: PCI BIOS area is rw and x. Use pci=nobios if you want it NX.
[    0.036410] PCI: PCI BIOS revision 3.00 entry at 0xf0031, last bus=8
[    0.036412] PCI: Using configuration type 1 for base access
[    0.036592] mtrr: your CPUs had inconsistent variable MTRR settings
[    0.036593] mtrr: probably your BIOS does not setup all CPUs.
[    0.036594] mtrr: corrected configuration.
[    0.038028] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.038028] ACPI: Added _OSI(Module Device)
[    0.038028] ACPI: Added _OSI(Processor Device)
[    0.038028] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.038028] ACPI: Added _OSI(Processor Aggregator Device)
[    0.038028] ACPI: Executed 2 blocks of module-level executable AML code
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
[    0.052227] ACPI: Enabled 6 GPEs in block 00 to 1F
[    0.062806] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.062813] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.062821] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.063242] PCI host bridge to bus 0000:00
[    0.063246] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.063248] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.063251] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.063253] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000dffff window]
[    0.063255] pci_bus 0000:00: root bus resource [mem 0xb8000000-0xffffffff window]
[    0.063258] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.063272] pci 0000:00:00.0: [1002:5a31] type 00 class 0x060000
[    0.063442] pci 0000:00:01.0: [1002:5a3f] type 01 class 0x060400
[    0.063620] pci 0000:00:04.0: [1002:5a36] type 01 class 0x060400
[    0.063654] pci 0000:00:04.0: enabling Extended Tags
[    0.063696] pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
[    0.063847] pci 0000:00:05.0: [1002:5a37] type 01 class 0x060400
[    0.063881] pci 0000:00:05.0: enabling Extended Tags
[    0.063921] pci 0000:00:05.0: PME# supported from D0 D3hot D3cold
[    0.064074] pci 0000:00:06.0: [1002:5a38] type 01 class 0x060400
[    0.064108] pci 0000:00:06.0: enabling Extended Tags
[    0.064148] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
[    0.064294] pci 0000:00:07.0: [1002:5a39] type 01 class 0x060400
[    0.064324] pci 0000:00:07.0: enabling Extended Tags
[    0.064364] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
[    0.064533] pci 0000:00:12.0: [1002:4380] type 00 class 0x01018f
[    0.064567] pci 0000:00:12.0: reg 0x10: [io  0xe800-0xe807]
[    0.064582] pci 0000:00:12.0: reg 0x14: [io  0xe400-0xe403]
[    0.064596] pci 0000:00:12.0: reg 0x18: [io  0xe000-0xe007]
[    0.064610] pci 0000:00:12.0: reg 0x1c: [io  0xdc00-0xdc03]
[    0.064625] pci 0000:00:12.0: reg 0x20: [io  0xd800-0xd80f]
[    0.064639] pci 0000:00:12.0: reg 0x24: [mem 0xfebffc00-0xfebfffff]
[    0.064673] pci 0000:00:12.0: set SATA to AHCI mode
[    0.064845] pci 0000:00:13.0: [1002:4387] type 00 class 0x0c0310
[    0.064873] pci 0000:00:13.0: reg 0x10: [mem 0xfebfe000-0xfebfefff]
[    0.065099] pci 0000:00:13.1: [1002:4388] type 00 class 0x0c0310
[    0.065127] pci 0000:00:13.1: reg 0x10: [mem 0xfebfd000-0xfebfdfff]
[    0.065350] pci 0000:00:13.2: [1002:4389] type 00 class 0x0c0310
[    0.065378] pci 0000:00:13.2: reg 0x10: [mem 0xfebfc000-0xfebfcfff]
[    0.065605] pci 0000:00:13.3: [1002:438a] type 00 class 0x0c0310
[    0.065633] pci 0000:00:13.3: reg 0x10: [mem 0xfebfb000-0xfebfbfff]
[    0.065858] pci 0000:00:13.4: [1002:438b] type 00 class 0x0c0310
[    0.065886] pci 0000:00:13.4: reg 0x10: [mem 0xfebfa000-0xfebfafff]
[    0.066117] pci 0000:00:13.5: [1002:4386] type 00 class 0x0c0320
[    0.066150] pci 0000:00:13.5: reg 0x10: [mem 0xfebff800-0xfebff8ff]
[    0.066277] pci 0000:00:13.5: supports D1 D2
[    0.066279] pci 0000:00:13.5: PME# supported from D0 D1 D2 D3hot
[    0.066424] pci 0000:00:14.0: [1002:4385] type 00 class 0x0c0500
[    0.066458] pci 0000:00:14.0: reg 0x10: [io  0x0b00-0x0b0f]
[    0.066673] pci 0000:00:14.1: [1002:438c] type 00 class 0x010182
[    0.066700] pci 0000:00:14.1: reg 0x10: [io  0x0000-0x0007]
[    0.066714] pci 0000:00:14.1: reg 0x14: [io  0x0000-0x0003]
[    0.066729] pci 0000:00:14.1: reg 0x18: [io  0x0000-0x0007]
[    0.066742] pci 0000:00:14.1: reg 0x1c: [io  0x0000-0x0003]
[    0.066757] pci 0000:00:14.1: reg 0x20: [io  0xff00-0xff0f]
[    0.066788] pci 0000:00:14.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.066790] pci 0000:00:14.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.066792] pci 0000:00:14.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.066794] pci 0000:00:14.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.066935] pci 0000:00:14.2: [1002:4383] type 00 class 0x040300
[    0.066974] pci 0000:00:14.2: reg 0x10: [mem 0xfebf4000-0xfebf7fff 64bit]
[    0.067079] pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
[    0.067220] pci 0000:00:14.3: [1002:438d] type 00 class 0x060100
[    0.067456] pci 0000:00:14.4: [1002:4384] type 01 class 0x060401
[    0.067743] pci 0000:01:05.0: [1002:5a62] type 00 class 0x030000
[    0.067760] pci 0000:01:05.0: reg 0x10: [mem 0xc0000000-0xcfffffff pref]
[    0.067768] pci 0000:01:05.0: reg 0x14: [io  0x9800-0x98ff]
[    0.067776] pci 0000:01:05.0: reg 0x18: [mem 0xfa8f0000-0xfa8fffff]
[    0.067800] pci 0000:01:05.0: reg 0x30: [mem 0xfa8c0000-0xfa8dffff pref]
[    0.067832] pci 0000:01:05.0: supports D1 D2
[    0.067916] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.067921] pci 0000:00:01.0:   bridge window [io  0x9000-0x9fff]
[    0.067925] pci 0000:00:01.0:   bridge window [mem 0xfa800000-0xfa8fffff]
[    0.067929] pci 0000:00:01.0:   bridge window [mem 0xbdf00000-0xddefffff pref]
[    0.068026] pci 0000:02:00.0: [168c:001c] type 00 class 0x020000
[    0.068066] pci 0000:02:00.0: reg 0x10: [mem 0xfa9f0000-0xfa9fffff 64bit]
[    0.068313] pci 0000:02:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.068324] pci 0000:00:04.0: PCI bridge to [bus 02]
[    0.068332] pci 0000:00:04.0:   bridge window [mem 0xfa900000-0xfa9fffff]
[    0.068440] acpiphp: Slot [1] registered
[    0.068446] pci 0000:00:05.0: PCI bridge to [bus 03-05]
[    0.068452] pci 0000:00:05.0:   bridge window [io  0xa000-0xbfff]
[    0.068456] pci 0000:00:05.0:   bridge window [mem 0xfaa00000-0xfe9fffff]
[    0.068462] pci 0000:00:05.0:   bridge window [mem 0xddf00000-0xdfefffff 64bit pref]
[    0.068538] pci 0000:06:00.0: [1969:2048] type 00 class 0x020000
[    0.068577] pci 0000:06:00.0: reg 0x10: [mem 0xfeac0000-0xfeafffff 64bit]
[    0.068639] pci 0000:06:00.0: reg 0x30: [mem 0xfeaa0000-0xfeabffff pref]
[    0.068720] pci 0000:06:00.0: PME# supported from D3hot D3cold
[    0.068806] pci 0000:06:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.068816] pci 0000:00:06.0: PCI bridge to [bus 06]
[    0.068823] pci 0000:00:06.0:   bridge window [mem 0xfea00000-0xfeafffff]
[    0.068882] pci 0000:00:07.0: PCI bridge to [bus 07]
[    0.069008] pci 0000:00:14.4: PCI bridge to [bus 08] (subtractive decode)
[    0.069022] pci 0000:00:14.4:   bridge window [io  0x0000-0x0cf7 window] (subtractive decode)
[    0.069024] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
[    0.069027] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    0.069029] pci 0000:00:14.4:   bridge window [mem 0x000d0000-0x000dffff window] (subtractive decode)
[    0.069032] pci 0000:00:14.4:   bridge window [mem 0xb8000000-0xffffffff window] (subtractive decode)
[    0.069063] pci_bus 0000:00: on NUMA node 0
[    0.069803] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 7 10 11 12)
[    0.069891] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 12)
[    0.069977] ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 7 10 11 12)
[    0.070062] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *10 11 12)
[    0.070148] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 12) *0, disabled.
[    0.070235] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 12) *0, disabled.
[    0.070321] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 *11 12)
[    0.070406] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 12) *0, disabled.
[    0.070738] ACPI: EC: interrupt unblocked
[    0.070748] ACPI: EC: event unblocked
[    0.070756] ACPI: \_SB_.PCI0.SBRG.EC0_: GPE=0x11, EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.070759] ACPI: \_SB_.PCI0.SBRG.EC0_: Used as boot DSDT EC to handle transactions and events
[    0.070867] pci 0000:01:05.0: vgaarb: setting as boot VGA device
[    0.070867] pci 0000:01:05.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.070867] pci 0000:01:05.0: vgaarb: bridge control possible
[    0.070867] vgaarb: loaded
[    0.070867] EDAC MC: Ver: 3.0.0
[    0.072036] PCI: Using ACPI for IRQ routing
[    0.072090] PCI: pci_cache_line_size set to 64 bytes
[    0.072170] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.072174] e820: reserve RAM buffer [mem 0xb7fa0000-0xb7ffffff]
[    0.072401] clocksource: Switched to clocksource refined-jiffies
[    0.095009] VFS: Disk quotas dquot_6.6.0
[    0.095080] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.095305] pnp: PnP ACPI init
[    0.095628] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.096080] system 00:01: [io  0x04d0-0x04d1] has been reserved
[    0.096083] system 00:01: [io  0x040b] has been reserved
[    0.096086] system 00:01: [io  0x04d6] has been reserved
[    0.096089] system 00:01: [io  0x0c00-0x0c01] has been reserved
[    0.096092] system 00:01: [io  0x0c14] has been reserved
[    0.096095] system 00:01: [io  0x0c50-0x0c51] has been reserved
[    0.096098] system 00:01: [io  0x0c52] has been reserved
[    0.096102] system 00:01: [io  0x0c6c] has been reserved
[    0.096105] system 00:01: [io  0x0c6f] has been reserved
[    0.096108] system 00:01: [io  0x0cd0-0x0cd1] has been reserved
[    0.096110] system 00:01: [io  0x0cd2-0x0cd3] has been reserved
[    0.096113] system 00:01: [io  0x0cd4-0x0cd5] has been reserved
[    0.096116] system 00:01: [io  0x0cd6-0x0cd7] has been reserved
[    0.096119] system 00:01: [io  0x0cd8-0x0cdf] has been reserved
[    0.096121] system 00:01: [io  0x0800-0x089f] has been reserved
[    0.096126] system 00:01: [io  0x0b00-0x0b1f] could not be reserved
[    0.096129] system 00:01: [io  0x0900-0x090f] has been reserved
[    0.096131] system 00:01: [io  0x0910-0x091f] has been reserved
[    0.096135] system 00:01: [io  0xfe00-0xfefe] has been reserved
[    0.096137] system 00:01: [io  0x4000-0x40fe] has been reserved
[    0.096143] system 00:01: [mem 0xfed45000-0xfed89fff] has been reserved
[    0.096146] system 00:01: [mem 0xffb80000-0xffbfffff] has been reserved
[    0.096149] system 00:01: [mem 0xfff80000-0xffffffff] has been reserved
[    0.096158] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.096243] pnp 00:02: Plug and Play ACPI device, IDs PNP0303 PNP030b (active)
[    0.096350] pnp 00:03: Plug and Play ACPI device, IDs SYN0a04 SYN0a00 SYN0002 PNP0f03 PNP0f13 PNP0f12 (active)
[    0.096490] system 00:04: [io  0x0250-0x0253] has been reserved
[    0.096493] system 00:04: [io  0x0256-0x025f] has been reserved
[    0.096497] system 00:04: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.096500] system 00:04: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.096507] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.096695] system 00:05: [mem 0xe0000000-0xefffffff] has been reserved
[    0.096702] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.097131] system 00:06: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.097134] system 00:06: [mem 0x000c0000-0x000cffff] could not be reserved
[    0.097137] system 00:06: [mem 0x000e0000-0x000fffff] could not be reserved
[    0.097140] system 00:06: [mem 0x00100000-0xb7ffffff] could not be reserved
[    0.097147] system 00:06: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.097332] pnp: PnP ACPI: found 7 devices
[    0.097340] PnPBIOS: Disabled
[    0.134724] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.134757] clocksource: Switched to clocksource acpi_pm
[    0.134820] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.134824] pci 0000:00:01.0:   bridge window [io  0x9000-0x9fff]
[    0.134829] pci 0000:00:01.0:   bridge window [mem 0xfa800000-0xfa8fffff]
[    0.134833] pci 0000:00:01.0:   bridge window [mem 0xbdf00000-0xddefffff pref]
[    0.134838] pci 0000:00:04.0: PCI bridge to [bus 02]
[    0.134842] pci 0000:00:04.0:   bridge window [mem 0xfa900000-0xfa9fffff]
[    0.134849] pci 0000:00:05.0: PCI bridge to [bus 03-05]
[    0.134852] pci 0000:00:05.0:   bridge window [io  0xa000-0xbfff]
[    0.134856] pci 0000:00:05.0:   bridge window [mem 0xfaa00000-0xfe9fffff]
[    0.134860] pci 0000:00:05.0:   bridge window [mem 0xddf00000-0xdfefffff 64bit pref]
[    0.134865] pci 0000:00:06.0: PCI bridge to [bus 06]
[    0.134869] pci 0000:00:06.0:   bridge window [mem 0xfea00000-0xfeafffff]
[    0.134876] pci 0000:00:07.0: PCI bridge to [bus 07]
[    0.134885] pci 0000:00:14.4: PCI bridge to [bus 08]
[    0.134904] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.134907] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.134909] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.134911] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000dffff window]
[    0.134914] pci_bus 0000:00: resource 8 [mem 0xb8000000-0xffffffff window]
[    0.134916] pci_bus 0000:01: resource 0 [io  0x9000-0x9fff]
[    0.134918] pci_bus 0000:01: resource 1 [mem 0xfa800000-0xfa8fffff]
[    0.134920] pci_bus 0000:01: resource 2 [mem 0xbdf00000-0xddefffff pref]
[    0.134923] pci_bus 0000:02: resource 1 [mem 0xfa900000-0xfa9fffff]
[    0.134926] pci_bus 0000:03: resource 0 [io  0xa000-0xbfff]
[    0.134928] pci_bus 0000:03: resource 1 [mem 0xfaa00000-0xfe9fffff]
[    0.134930] pci_bus 0000:03: resource 2 [mem 0xddf00000-0xdfefffff 64bit pref]
[    0.134932] pci_bus 0000:06: resource 1 [mem 0xfea00000-0xfeafffff]
[    0.134935] pci_bus 0000:08: resource 4 [io  0x0000-0x0cf7 window]
[    0.134938] pci_bus 0000:08: resource 5 [io  0x0d00-0xffff window]
[    0.134940] pci_bus 0000:08: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.134942] pci_bus 0000:08: resource 7 [mem 0x000d0000-0x000dffff window]
[    0.134944] pci_bus 0000:08: resource 8 [mem 0xb8000000-0xffffffff window]
[    0.135085] NET: Registered protocol family 2
[    0.135437] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.135497] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    0.135604] TCP: Hash tables configured (established 8192 bind 8192)
[    0.135735] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.135763] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.135884] NET: Registered protocol family 1
[    0.135905] pci 0000:00:01.0: MSI quirk detected; subordinate MSI disabled
[    0.135905] pci 0000:01:05.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.135905] pci 0000:06:00.0: [Firmware Bug]: disabling VPD access (can't determine size of non-standard VPD format)
[    0.135905] PCI: CLS 64 bytes, default 64
[    0.135905] Unpacking initramfs...
[    0.735461] Freeing initrd memory: 17776K
[    0.737187] Initialise system trusted keyrings
[    0.737377] workingset: timestamp_bits=14 max_order=20 bucket_order=6
[    0.737446] zbud: loaded
[    1.760165] tsc: Refined TSC clocksource calibration: 1662.499 MHz
[    1.760185] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x17f6c559e9c, max_idle_ns: 440795215390 ns
[    2.784660] clocksource: Switched to clocksource tsc
[    2.864736] Key type asymmetric registered
[    2.864739] Asymmetric key parser 'x509' registered
[    2.864759] bounce: pool size: 64 pages
[    2.864788] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
[    2.864845] io scheduler noop registered
[    2.864846] io scheduler deadline registered
[    2.864875] io scheduler cfq registered (default)
[    2.864877] io scheduler mq-deadline registered
[    2.864878] io scheduler kyber registered
[    2.865302] intel_idle: does not run on family 6 model 15
[    2.865536] tsc: Marking TSC unstable due to TSC halts in idle
[    2.865635] clocksource: Switched to clocksource acpi_pm
[    2.866027] isapnp: Scanning for PnP cards...
[    3.220519] isapnp: No Plug & Play device found
[    3.220647] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    3.221422] Linux agpgart interface v0.103
[    3.221976] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
[    3.224111] i8042: Detected active multiplexing controller, rev 1.1
[    3.225501] serio: i8042 KBD port at 0x60,0x64 irq 1
[    3.225509] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[    3.225563] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[    3.225611] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[    3.225656] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[    3.225894] mousedev: PS/2 mouse device common for all mice
[    3.225986] rtc_cmos 00:00: RTC can wake from S4
[    3.226167] rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
[    3.226196] rtc_cmos 00:00: alarms up to one month, y3k, 114 bytes nvram
[    3.226255] ledtrig-cpu: registered to indicate activity on CPUs
[    3.226809] NET: Registered protocol family 10
[    3.227237] Segment Routing with IPv6
[    3.227269] mip6: Mobile IPv6
[    3.227272] NET: Registered protocol family 17
[    3.227277] mpls_gso: MPLS GSO support
[    3.227557] microcode: sig=0x6fd, pf=0x80, revision=0xa4
[    3.227655] microcode: Microcode Update Driver: v2.2.
[    3.227663] Using IPI No-Shortcut mode
[    3.227937] registered taskstats version 1
[    3.227939] Loading compiled-in X.509 certificates
[    3.227961] zswap: loaded using pool lzo/zbud
[    3.228142] ima: No TPM chip found, activating TPM-bypass! (rc=-19)
[    3.228596] rtc_cmos 00:00: setting system clock to 2017-12-28 13:51:27 UTC (1514469087)
[    3.229335] Freeing unused kernel memory: 604K
[    3.229446] Write protecting the kernel text: 5868k
[    3.229551] Write protecting the kernel read-only data: 1860k
[    3.229552] NX-protecting the kernel data: 4372k
[    3.229706] ------------[ cut here ]------------
[    3.229714] x86/mm: Found insecure W+X mapping at address 6634b4f8/0xc00a0000
[    3.229733] WARNING: CPU: 1 PID: 1 at arch/x86/mm/dump_pagetables.c:257 note_page+0x5ec/0x790
[    3.229734] Modules linked in:
[    3.229738] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.15.0-rc5-dou-p+ #1
[    3.229794] Hardware name: ASUSTeK Computer Inc. F5RL                /F5RL      , BIOS 210     06/12/2008
[    3.229842] EIP: note_page+0x5ec/0x790
[    3.229844] EFLAGS: 00210282 CPU: 1
[    3.229846] EAX: 00000041 EBX: f70c7f54 ECX: 00000001 EDX: d28de544
[    3.229847] ESI: 80000000 EDI: 00000000 EBP: f70c7f20 ESP: f70c7ef4
[    3.229849]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[    3.229851] CR0: 80050033 CR2: 00000000 CR3: 128ce000 CR4: 000006f0
[    3.229852] Call Trace:
[    3.229901]  ptdump_walk_pgd_level_core+0x15c/0x240
[    3.229947]  ptdump_walk_pgd_level_checkwx+0x11/0x20
[    3.229993]  mark_rodata_ro+0xd5/0xf1
[    3.230039]  ? rest_init+0x90/0x90
[    3.230082]  kernel_init+0x24/0xe0
[    3.230127]  ret_from_fork+0x19/0x24
[    3.230171] Code: fa ff ff 83 c2 0c c7 43 18 00 00 00 00 89 53 14 e9 1a fd ff ff 8b 43 0c c6 05 c4 76 80 d2 01 50 50 68 50 ee 6c d2 e8 84 5c 00 00 <0f> ff 83 c4 0c e9 6f fa ff ff ff 72 10 68 1c ed 6c d2 e8 57 f5
[    3.230268] ---[ end trace 6363fd513ff6ba4e ]---
[    3.230377] x86/mm: Checked W+X mappings: FAILED, 96 W+X pages found.
[    3.261781] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    3.319387] Atheros(R) L2 Ethernet Driver - version 2.2.3
[    3.319390] Copyright (c) 2007 Atheros Corporation.
[    3.323558] ACPI: bus type USB registered
[    3.323608] usbcore: registered new interface driver usbfs
[    3.323628] usbcore: registered new interface driver hub
[    3.323639] SCSI subsystem initialized
[    3.323707] usbcore: registered new device driver usb
[    3.324785] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    3.325619] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    3.325939] ehci-pci: EHCI PCI platform driver
[    3.326207] ehci-pci 0000:00:13.5: EHCI Host Controller
[    3.326217] ehci-pci 0000:00:13.5: new USB bus registered, assigned bus number 1
[    3.326225] ehci-pci 0000:00:13.5: applying AMD SB600/SB700 USB freeze workaround
[    3.326244] ehci-pci 0000:00:13.5: debug port 1
[    3.326317] ehci-pci 0000:00:13.5: irq 19, io mem 0xfebff800
[    3.326935] libata version 3.00 loaded.
[    3.340101] ehci-pci 0000:00:13.5: USB 2.0 started, EHCI 1.00
[    3.340201] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    3.340204] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.340206] usb usb1: Product: EHCI Host Controller
[    3.340208] usb usb1: Manufacturer: Linux 4.15.0-rc5-dou-p+ ehci_hcd
[    3.340210] usb usb1: SerialNumber: 0000:00:13.5
[    3.340425] hub 1-0:1.0: USB hub found
[    3.340438] hub 1-0:1.0: 10 ports detected
[    3.340876] ahci 0000:00:12.0: version 3.0
[    3.341166] ahci 0000:00:12.0: controller can't do 64bit DMA, forcing 32bit
[    3.341293] ohci-pci: OHCI PCI platform driver
[    3.341326] ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
[    3.341330] ahci 0000:00:12.0: flags: ncq sntf ilck led clo pmp pio slum part ccc 
[    3.342974] scsi host0: ahci
[    3.343187] scsi host1: ahci
[    3.352084] scsi host2: ahci
[    3.364063] scsi host3: ahci
[    3.364185] ata1: SATA max UDMA/133 abar m1024@0xfebffc00 port 0xfebffd00 irq 22
[    3.364189] ata2: SATA max UDMA/133 abar m1024@0xfebffc00 port 0xfebffd80 irq 22
[    3.364192] ata3: SATA max UDMA/133 abar m1024@0xfebffc00 port 0xfebffe00 irq 22
[    3.364195] ata4: SATA max UDMA/133 abar m1024@0xfebffc00 port 0xfebffe80 irq 22
[    3.365296] ACPI Warning: SystemIO range 0x0000000000000B00-0x0000000000000B08 conflicts with OpRegion 0x0000000000000B00-0x0000000000000B0F (\SMB0) (20170831/utaddress-247)
[    3.365307] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[    3.376097] scsi host4: pata_atiixp
[    3.378829] scsi host5: pata_atiixp
[    3.378937] ata5: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xff00 irq 14
[    3.378939] ata6: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xff08 irq 15
[    3.379192] ohci-pci 0000:00:13.0: OHCI PCI host controller
[    3.379204] ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 2
[    3.379258] ohci-pci 0000:00:13.0: irq 16, io mem 0xfebfe000
[    3.421430] (NULL device *): hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[    3.422132] thermal LNXTHERM:00: registered as thermal_zone0
[    3.422135] ACPI: Thermal Zone [THRM] (74 C)
[    3.440161] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    3.440164] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.440167] usb usb2: Product: OHCI PCI host controller
[    3.440169] usb usb2: Manufacturer: Linux 4.15.0-rc5-dou-p+ ohci_hcd
[    3.440171] usb usb2: SerialNumber: 0000:00:13.0
[    3.440404] hub 2-0:1.0: USB hub found
[    3.440421] hub 2-0:1.0: 2 ports detected
[    3.440775] ohci-pci 0000:00:13.1: OHCI PCI host controller
[    3.440784] ohci-pci 0000:00:13.1: new USB bus registered, assigned bus number 3
[    3.440827] ohci-pci 0000:00:13.1: irq 17, io mem 0xfebfd000
[    3.504237] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[    3.504241] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.504243] usb usb3: Product: OHCI PCI host controller
[    3.504245] usb usb3: Manufacturer: Linux 4.15.0-rc5-dou-p+ ohci_hcd
[    3.504247] usb usb3: SerialNumber: 0000:00:13.1
[    3.504474] hub 3-0:1.0: USB hub found
[    3.504490] hub 3-0:1.0: 2 ports detected
[    3.504814] ohci-pci 0000:00:13.2: OHCI PCI host controller
[    3.504822] ohci-pci 0000:00:13.2: new USB bus registered, assigned bus number 4
[    3.504868] ohci-pci 0000:00:13.2: irq 18, io mem 0xfebfc000
[    3.560590] ata5.00: ATAPI: HL-DT-ST DVDRAM GSA-T40N, JR03, max UDMA/33
[    3.568478] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    3.568481] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.568483] usb usb4: Product: OHCI PCI host controller
[    3.568485] usb usb4: Manufacturer: Linux 4.15.0-rc5-dou-p+ ohci_hcd
[    3.568487] usb usb4: SerialNumber: 0000:00:13.2
[    3.568704] hub 4-0:1.0: USB hub found
[    3.568717] hub 4-0:1.0: 2 ports detected
[    3.568990] ohci-pci 0000:00:13.3: OHCI PCI host controller
[    3.568998] ohci-pci 0000:00:13.3: new USB bus registered, assigned bus number 5
[    3.569028] ohci-pci 0000:00:13.3: irq 17, io mem 0xfebfb000
[    3.584535] ata5.00: configured for UDMA/33
[    3.632105] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[    3.632108] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.632110] usb usb5: Product: OHCI PCI host controller
[    3.632112] usb usb5: Manufacturer: Linux 4.15.0-rc5-dou-p+ ohci_hcd
[    3.632114] usb usb5: SerialNumber: 0000:00:13.3
[    3.632330] hub 5-0:1.0: USB hub found
[    3.632343] hub 5-0:1.0: 2 ports detected
[    3.632610] ohci-pci 0000:00:13.4: OHCI PCI host controller
[    3.632618] ohci-pci 0000:00:13.4: new USB bus registered, assigned bus number 6
[    3.632648] ohci-pci 0000:00:13.4: irq 18, io mem 0xfebfa000
[    3.676063] usb 1-4: new high-speed USB device number 2 using ehci-pci
[    3.683223] ata2: SATA link down (SStatus 0 SControl 300)
[    3.687052] ata3: SATA link down (SStatus 0 SControl 300)
[    3.691362] ata4: SATA link down (SStatus 0 SControl 300)
[    3.696134] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
[    3.696137] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.696140] usb usb6: Product: OHCI PCI host controller
[    3.696142] usb usb6: Manufacturer: Linux 4.15.0-rc5-dou-p+ ohci_hcd
[    3.696144] usb usb6: SerialNumber: 0000:00:13.4
[    3.696354] hub 6-0:1.0: USB hub found
[    3.696369] hub 6-0:1.0: 2 ports detected
[    3.840118] ata1: softreset failed (device not ready)
[    3.840172] ata1: applying PMP SRST workaround and retrying
[    3.853686] usb 1-4: New USB device found, idVendor=0bda, idProduct=0116
[    3.853689] usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.853692] usb 1-4: Product: USB2.0-CRW
[    3.853694] usb 1-4: Manufacturer: Generic
[    3.853696] usb 1-4: SerialNumber: 20021111153705700
[    3.859416] usb-storage 1-4:1.0: USB Mass Storage device detected
[    3.859811] scsi host6: usb-storage 1-4:1.0
[    3.859947] usbcore: registered new interface driver usb-storage
[    3.860469] usbcore: registered new interface driver uas
[    3.984081] usb 1-7: new high-speed USB device number 3 using ehci-pci
[    4.000076] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    4.001203] ata1.00: ATA-8: ST9250827AS, 3.AAA, max UDMA/133
[    4.001205] ata1.00: 488397168 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    4.001210] ata1.00: SB600 AHCI: limiting to 255 sectors per cmd
[    4.001682] ata1.00: SB600 AHCI: limiting to 255 sectors per cmd
[    4.001684] ata1.00: configured for UDMA/133
[    4.001999] scsi 0:0:0:0: Direct-Access     ATA      ST9250827AS      A    PQ: 0 ANSI: 5
[    4.006117] scsi 4:0:0:0: CD-ROM            HL-DT-ST DVDRAM GSA-T40N  JR03 PQ: 0 ANSI: 5
[    4.023168] sd 0:0:0:0: [sda] 488397168 512-byte logical blocks: (250 GB/233 GiB)
[    4.023191] sd 0:0:0:0: [sda] Write Protect is off
[    4.023194] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    4.023229] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    4.039225] sr 4:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
[    4.039228] cdrom: Uniform CD-ROM driver Revision: 3.20
[    4.039583] sr 4:0:0:0: Attached scsi CD-ROM sr0
[    4.102253]  sda: sda1 sda2 < sda5 >
[    4.102938] sd 0:0:0:0: [sda] Attached SCSI disk
[    4.158741] usb 1-7: New USB device found, idVendor=174f, idProduct=5a31
[    4.158745] usb 1-7: New USB device strings: Mfr=2, Product=1, SerialNumber=3
[    4.158748] usb 1-7: Product: USB 2.0 Camera
[    4.158750] usb 1-7: Manufacturer: Sonix Technology Co., Ltd.
[    4.158752] usb 1-7: SerialNumber: SN0001
[    4.193699] psmouse serio4: synaptics: Touchpad model: 1, fw: 6.1, id: 0xa3a0b3, caps: 0xa04713/0x10008/0x0/0x0, board id: 0, fw id: 30712
[    4.235194] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio4/input/input8
[    4.762173] PM: Starting manual resume from disk
[    4.762406] PM: Image not found (code -22)
[    4.875771] scsi 6:0:0:0: Direct-Access     Generic- xD/SDMMC/MS/Pro  1.00 PQ: 0 ANSI: 0 CCS
[    5.075409] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[    5.542349] sd 6:0:0:0: [sdb] 62333952 512-byte logical blocks: (31.9 GB/29.7 GiB)
[    5.546305] sd 6:0:0:0: [sdb] Write Protect is off
[    5.546308] sd 6:0:0:0: [sdb] Mode Sense: 03 00 00 00
[    5.550302] sd 6:0:0:0: [sdb] No Caching mode page found
[    5.550358] sd 6:0:0:0: [sdb] Assuming drive cache: write through
[    5.572454]  sdb: sdb1
[    5.584935] sd 6:0:0:0: [sdb] Attached SCSI removable disk
[    6.373437] random: crng init done
[    6.816908] ip_tables: (C) 2000-2006 Netfilter Core Team
[    7.019202] systemd[1]: systemd 232 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
[    7.036136] systemd[1]: Detected architecture x86.
[    7.041405] systemd[1]: Set hostname to <D-69-91-141-110>.
[    8.409456] systemd[1]: Configuration file /etc/systemd/system/kdump.service is marked executable. Please remove executable permission bits. Proceeding anyway.
[    8.544915] systemd[1]: Listening on udev Control Socket.
[    8.545072] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
[    8.545352] systemd[1]: Created slice User and Session Slice.
[    8.545438] systemd[1]: Listening on Syslog Socket.
[    8.545500] systemd[1]: Listening on fsck to fsckd communication Socket.
[    8.545538] systemd[1]: Reached target Remote File Systems.
[    9.653413] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
[    9.944794] systemd-journald[188]: Received request to flush runtime journal from PID 1
[   14.308418] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input9
[   14.308442] ACPI: Lid Switch [LID]
[   14.308547] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input10
[   14.308579] ACPI: Power Button [PWRB]
[   14.308660] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input11
[   14.308677] ACPI: Sleep Button [SLPB]
[   14.308760] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input12
[   14.308777] ACPI: Power Button [PWRF]
[   14.312340] ACPI: Battery Slot [BAT0] (battery absent)
[   14.405188] ACPI: AC Adapter [AC0] (on-line)
[   14.405281] ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[   14.409980] acpi device:02: registered as cooling_device2
[   14.410075] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A03:00/device:00/LNXVIDEO:00/input/input13
[   14.523843] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   14.535927] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   14.535985] sr 4:0:0:0: Attached scsi generic sg1 type 5
[   14.536080] sd 6:0:0:0: Attached scsi generic sg2 type 0
[   14.667455] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver v0.05
[   14.667577] sp5100_tco: PCI Vendor ID: 0x1002, Device ID: 0x4385, Revision ID: 0x13
[   14.667613] sp5100_tco: failed to find MMIO address, giving up.
[   15.598062] asus_laptop: Asus Laptop Support version 0.42
[   15.598227] asus_laptop:   F5RL model detected
[   15.598544] input: Asus Laptop extra buttons as /devices/platform/asus_laptop/input/input14
[   15.689593] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[   15.837515] intel_powerclamp: No package C-state available
[   15.948403] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   15.970128] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[   15.970133] cfg80211: failed to load regulatory.db
[   16.101515] input: PC Speaker as /devices/platform/pcspkr/input/input15
[   16.569684] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC660-VD: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[   16.569698] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   16.569701] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[   16.569702] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[   16.569704] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[   16.569707] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x19
[   16.569710] snd_hda_codec_realtek hdaudioC0D0:      Mic=0x18
[   16.600351] [drm] radeon kernel modesetting enabled.
[   16.601226] [drm] initializing kernel modesetting (RS400 0x1002:0x5A62 0x1043:0x1402 0x00).
[   16.601305] resource sanity check: requesting [mem 0x000c0000-0x000dffff], which spans more than PCI Bus 0000:00 [mem 0x000d0000-0x000dffff window]
[   16.601315] caller pci_map_rom+0x58/0xf0 mapping multiple BARs
[   16.601472] [drm] Generation 2 PCI interface, using max accessible memory
[   16.601478] radeon 0000:01:05.0: VRAM: 128M 0x00000000B8000000 - 0x00000000BFFFFFFF (128M used)
[   16.601481] radeon 0000:01:05.0: GTT: 512M 0x0000000080000000 - 0x000000009FFFFFFF
[   16.601492] [drm] Detected VRAM RAM=128M, BAR=256M
[   16.601493] [drm] RAM width 128bits DDR
[   16.601651] [TTM] Zone  kernel: Available graphics memory: 303872 kiB
[   16.601653] [TTM] Zone highmem: Available graphics memory: 1357380 kiB
[   16.601655] [TTM] Initializing pool allocator
[   16.601663] [TTM] Initializing DMA pool allocator
[   16.601708] [drm] radeon: 128M of VRAM memory ready
[   16.601709] [drm] radeon: 512M of GTT memory ready.
[   16.601731] [drm] GART: num cpu pages 131072, num gpu pages 131072
[   16.625254] [drm] radeon: 3 quad pipes, 1 z pipes initialized.
[   16.625266] [drm] PCIE GART of 512M enabled (table at 0x0000000036700000).
[   16.625346] radeon 0000:01:05.0: WB enabled
[   16.625354] radeon 0000:01:05.0: fence driver on ring 0 use gpu addr 0x0000000080000000 and cpu addr 0xd2c14725
[   16.625358] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   16.625359] [drm] Driver supports precise vblank timestamp query.
[   16.625361] radeon 0000:01:05.0: radeon: MSI limited to 32-bit
[   16.625380] [drm] radeon: irq initialized.
[   16.625393] [drm] Loading R300 Microcode
[   16.666009] ath5k 0000:02:00.0: can't disable ASPM; OS doesn't have ASPM control
[   16.666259] ath5k 0000:02:00.0: registered as 'phy0'
[   16.745870] [drm] radeon: ring at 0x0000000080001000
[   16.745899] [drm] ring test succeeded in 1 usecs
[   16.746058] [drm] ib test succeeded in 0 usecs
[   16.746486] [drm] Panel ID String: AUO                     
[   16.746487] [drm] Panel Size 1280x800
[   16.746575] [drm] Radeon Display Connectors
[   16.746576] [drm] Connector 0:
[   16.746577] [drm]   VGA-1
[   16.746579] [drm]   DDC: 0x68 0x68 0x68 0x68 0x68 0x68 0x68 0x68
[   16.746580] [drm]   Encoders:
[   16.746582] [drm]     CRT1: INTERNAL_DAC2
[   16.746583] [drm] Connector 1:
[   16.746584] [drm]   LVDS-1
[   16.746586] [drm]   DDC: 0x198 0x198 0x19c 0x19c 0x1a0 0x1a0 0x1a4 0x1a4
[   16.746586] [drm]   Encoders:
[   16.746588] [drm]     LCD1: INTERNAL_LVDS
[   16.815131] [drm] fb mappable at 0xC0040000
[   16.815132] [drm] vram apper at 0xC0000000
[   16.815133] [drm] size 4096000
[   16.815134] [drm] fb depth is 24
[   16.815135] [drm]    pitch is 5120
[   16.815254] fbcon: radeondrmfb (fb0) is primary device
[   16.862642] Console: switching to colour frame buffer device 160x50
[   16.871053] radeon 0000:01:05.0: fb0: radeondrmfb frame buffer device
[   16.884094] [drm] Initialized radeon 2.50.0 20080528 for 0000:01:05.0 on minor 0
[   17.195340] ath: EEPROM regdomain: 0x60
[   17.195343] ath: EEPROM indicates we should expect a direct regpair map
[   17.195346] ath: Country alpha2 being used: 00
[   17.195347] ath: Regpair used: 0x60
[   17.247221] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
[   17.247718] ath5k: phy0: Atheros AR2425 chip found (MAC: 0xe2, PHY: 0x70)
[   17.365830] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:14.2/sound/card0/input16
[   17.366472] input: HDA ATI SB Mic as /devices/pci0000:00/0000:00:14.2/sound/card0/input17
[   17.366572] input: HDA ATI SB Headphone as /devices/pci0000:00/0000:00:14.2/sound/card0/input18
[   18.120562] media: Linux media interface: v0.10
[   18.307848] Linux video capture interface: v2.00
[   18.750725] uvcvideo: Found UVC 1.00 device USB 2.0 Camera (174f:5a31)
[   18.770331] uvcvideo 1-7:1.0: Entity type for entity Extension 4 was not initialized!
[   18.770335] uvcvideo 1-7:1.0: Entity type for entity Processing 3 was not initialized!
[   18.770337] uvcvideo 1-7:1.0: Entity type for entity Camera 1 was not initialized!
[   18.770483] input: USB 2.0 Camera: USB 2.0 Camera as /devices/pci0000:00/0000:00:13.5/usb1/1-7/1-7:1.0/input/input19
[   18.770610] usbcore: registered new interface driver uvcvideo
[   18.770612] USB Video Class driver (1.1.1)
[   18.892817] Adding 3929084k swap on /dev/sda5.  Priority:-2 extents:1 across:3929084k FS
[   20.118140] FAT-fs (sdb1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
[   31.519776] NET: Registered protocol family 4
[   31.531428] NET: Registered protocol family 3
[   31.556246] NET: Registered protocol family 5
[   31.650224] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
[   37.019011] spurious APIC interrupt through vector ff on CPU#0, should never happen.
[   37.019194] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   58.136014] INFO: rcu_sched detected stalls on CPUs/tasks:
[   58.136125] 	0-...!: (0 ticks this GP) idle=e64/0/0 softirq=5073/5073 fqs=0 
[   58.136245] 	(detected by 1, t=5252 jiffies, g=2134, c=2133, q=3355)
[   58.136361] Sending NMI from CPU 1 to CPUs 0:
[   57.569375] NMI backtrace for cpu 0
[   57.569375] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W        4.15.0-rc5-dou-p+ #1
[   57.569375] Hardware name: ASUSTeK Computer Inc. F5RL                /F5RL      , BIOS 210     06/12/2008
[   57.569375] EIP: tick_check_broadcast_expired+0x10/0x20
[   57.569375] EFLAGS: 00000247 CPU: 0
[   57.569375] EAX: 00000000 EBX: d2792180 ECX: d28bbf28 EDX: 0002ae62
[   57.569375] ESI: d2792180 EDI: 00000000 EBP: d278df24 ESP: d278df24
[   57.569375]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[   57.569375] CR0: 80050033 CR2: 0a04ec30 CR3: 36d65d00 CR4: 000006f0
[   57.569375] Call Trace:
[   57.569375]  cpu_idle_poll+0x46/0x130
[   57.569375]  do_idle+0x3d/0x1a0
[   57.569375]  cpu_startup_entry+0x65/0x70
[   57.569375]  rest_init+0x86/0x90
[   57.569375]  start_kernel+0x371/0x38a
[   57.569375]  i386_start_kernel+0x95/0x99
[   57.569375]  startup_32_smp+0x164/0x168
[   57.569375] Code: 91 4e 00 5b 5e 5d c3 8d 74 26 00 55 b8 60 26 90 d2 89 e5 5d c3 8d b6 00 00 00 00 55 64 a1 00 61 8b d2 89 e5 0f a3 05 58 26 90 d2 <0f> 92 c0 0f b6 c0 5d c3 90 8d b4 26 00 00 00 00 64 a1 00 61 8b
[   58.137362] rcu_sched kthread starved for 5252 jiffies! g2134 c2133 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=0
[   58.140004] rcu_sched       I    0     8      2 0x80000000
[   58.140004] Call Trace:
[   58.140004]  __schedule+0x3f9/0x880
[   58.140004]  schedule+0x29/0x70
[   58.140004]  schedule_timeout+0x12d/0x2f0
[   58.140004]  ? __next_timer_interrupt+0xc0/0xc0
[   58.140004]  rcu_gp_kthread+0x472/0x7a0
[   58.140004]  kthread+0xd0/0x100
[   58.140004]  ? call_rcu_sched+0x20/0x20
[   58.140004]  ? kthread_associate_blkcg+0x90/0x90
[   58.140004]  ret_from_fork+0x19/0x24
[   79.864801] NMI watchdog: Watchdog detected hard LOCKUP on cpu 0
[   79.864801] Modules linked in: appletalk ax25 ipx p8023 p8022 psnap llc nls_ascii nls_cp437 vfat fat uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_core videodev media snd_hda_codec_si3054 arc4 ath5k radeon snd_hda_codec_realtek snd_hda_codec_generic ath snd_hda_intel mac80211 snd_hda_codec snd_hda_core snd_hwdep snd_pcsp snd_pcm snd_timer coretemp ttm cfg80211 drm_kms_helper asus_laptop drm snd soundcore i2c_algo_bit joydev evdev sparse_keymap serio_raw rfkill fb_sys_fops syscopyarea sysfillrect sysimgblt sp5100_tco input_polldev sg shpchp video ac battery button acpi_cpufreq ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 fscrypto sr_mod cdrom sd_mod ata_generic uas usb_storage ohci_pci psmouse pata_atiixp i2c_piix4 ahci libahci ehci_pci ohci_hcd libata ehci_hcd usbcore
[   79.864801]  scsi_mod atl2 thermal
[   79.864801] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W        4.15.0-rc5-dou-p+ #1
[   79.864801] Hardware name: ASUSTeK Computer Inc. F5RL                /F5RL      , BIOS 210     06/12/2008
[   79.864801] EIP: cpu_idle_poll+0x41/0x130
[   79.864801] EFLAGS: 00000246 CPU: 0
[   79.864801] EAX: 00000000 EBX: d2792180 ECX: d28bbf28 EDX: 0002af32
[   79.864801] ESI: d2792180 EDI: 00000000 EBP: d278df38 ESP: d278df2c
[   79.864801]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[   79.864801] CR0: 80050033 CR2: b70cc480 CR3: 36d65d00 CR4: 000006f0
[   79.864801] Call Trace:
[   79.864801]  do_idle+0x3d/0x1a0
[   79.864801]  cpu_startup_entry+0x65/0x70
[   79.864801]  rest_init+0x86/0x90
[   79.864801]  start_kernel+0x371/0x38a
[   79.864801]  i386_start_kernel+0x95/0x99
[   79.864801]  startup_32_smp+0x164/0x168
[   79.864801] Code: 90 fb 64 8b 1d 3c 79 8b d2 8b 03 a8 08 74 13 eb 23 89 f6 8d bc 27 00 00 00 00 f3 90 8b 03 a8 08 75 12 a1 10 c5 81 d2 85 c0 75 ef <e8> aa 73 b1 ff 85 c0 75 e6 64 8b 3d 00 61 8b d2 66 66 66 66 90
[   80.031901] perf: interrupt took too long (2611 > 2500), lowering kernel.perf_event_max_sample_rate to 76500
[  121.156014] INFO: rcu_sched detected stalls on CPUs/tasks:
[  121.158283] 	0-...!: (0 ticks this GP) idle=340/0/0 softirq=5073/5073 fqs=1 
[  121.160004] 	(detected by 1, t=21007 jiffies, g=2134, c=2133, q=4647)
[  121.160004] Sending NMI from CPU 1 to CPUs 0:
[  120.932038] NMI backtrace for cpu 0 skipped: idling at cpu_idle_poll+0x32/0x130
[  121.160004] rcu_sched kthread starved for 15755 jiffies! g2134 c2133 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=0
[  121.160004] rcu_sched       I    0     8      2 0x80000000
[  121.160004] Call Trace:
[  121.160004]  __schedule+0x3f9/0x880
[  121.160004]  schedule+0x29/0x70
[  121.160004]  schedule_timeout+0x12d/0x2f0
[  121.160004]  ? __next_timer_interrupt+0xc0/0xc0
[  121.160004]  rcu_gp_kthread+0x472/0x7a0
[  121.160004]  kthread+0xd0/0x100
[  121.160004]  ? call_rcu_sched+0x20/0x20
[  121.160004]  ? kthread_associate_blkcg+0x90/0x90
[  121.160004]  ret_from_fork+0x19/0x24
[  142.164014] INFO: rcu_sched detected stalls on CPUs/tasks:
[  142.165971] 	0-...!: (0 ticks this GP) idle=48c/0/0 softirq=5073/5073 fqs=0 
[  142.167967] 	(detected by 1, t=5252 jiffies, g=2135, c=2134, q=4341)
[  142.168004] Sending NMI from CPU 1 to CPUs 0:
[  141.092060] NMI backtrace for cpu 0
[  141.092060] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W        4.15.0-rc5-dou-p+ #1
[  141.092060] Hardware name: ASUSTeK Computer Inc. F5RL                /F5RL      , BIOS 210     06/12/2008
[  141.092060] EIP: tick_check_broadcast_expired+0x10/0x20
[  141.092060] EFLAGS: 00000247 CPU: 0
[  141.092060] EAX: 00000000 EBX: d2792180 ECX: d28bbf28 EDX: 0002b48a
[  141.092060] ESI: d2792180 EDI: 00000000 EBP: d278df24 ESP: d278df24
[  141.092060]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[  141.092060] CR0: 80050033 CR2: b7b7f0c0 CR3: 36d65d00 CR4: 000006f0
[  141.092060] Call Trace:
[  141.092060]  cpu_idle_poll+0x46/0x130
[  141.092060]  do_idle+0x3d/0x1a0
[  141.092060]  cpu_startup_entry+0x65/0x70
[  141.092060]  rest_init+0x86/0x90
[  141.092060]  start_kernel+0x371/0x38a
[  141.092060]  i386_start_kernel+0x95/0x99
[  141.092060]  startup_32_smp+0x164/0x168
[  141.092060] Code: 91 4e 00 5b 5e 5d c3 8d 74 26 00 55 b8 60 26 90 d2 89 e5 5d c3 8d b6 00 00 00 00 55 64 a1 00 61 8b d2 89 e5 0f a3 05 58 26 90 d2 <0f> 92 c0 0f b6 c0 5d c3 90 8d b4 26 00 00 00 00 64 a1 00 61 8b
[  142.168004] rcu_sched kthread starved for 5252 jiffies! g2135 c2134 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=0
[  142.168004] rcu_sched       I    0     8      2 0x80000000
[  142.168004] Call Trace:
[  142.168004]  __schedule+0x3f9/0x880
[  142.168004]  schedule+0x29/0x70
[  142.168004]  schedule_timeout+0x12d/0x2f0
[  142.168004]  ? __next_timer_interrupt+0xc0/0xc0
[  142.168004]  rcu_gp_kthread+0x472/0x7a0
[  142.168004]  kthread+0xd0/0x100
[  142.168004]  ? call_rcu_sched+0x20/0x20
[  142.168004]  ? kthread_associate_blkcg+0x90/0x90
[  142.168004]  ret_from_fork+0x19/0x24
[  205.184014] INFO: rcu_sched detected stalls on CPUs/tasks:
[  205.188004] 	0-...!: (0 ticks this GP) idle=c14/0/0 softirq=5073/5073 fqs=1 
[  205.188004] 	(detected by 1, t=21007 jiffies, g=2135, c=2134, q=5751)
[  205.188004] Sending NMI from CPU 1 to CPUs 0:
[  204.642105] NMI backtrace for cpu 0
[  204.642105] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W        4.15.0-rc5-dou-p+ #1
[  204.642105] Hardware name: ASUSTeK Computer Inc. F5RL                /F5RL      , BIOS 210     06/12/2008
[  204.642105] EIP: tick_check_broadcast_expired+0x10/0x20
[  204.642105] EFLAGS: 00000247 CPU: 0
[  204.642105] EAX: 00000000 EBX: d2792180 ECX: d28bbf28 EDX: 0002bc12
[  204.642105] ESI: d2792180 EDI: 00000000 EBP: d278df24 ESP: d278df24
[  204.642105]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[  204.642105] CR0: 80050033 CR2: 09f63608 CR3: 36d65d00 CR4: 000006f0
[  204.642105] Call Trace:
[  204.642105]  cpu_idle_poll+0x46/0x130
[  204.642105]  do_idle+0x3d/0x1a0
[  204.642105]  cpu_startup_entry+0x65/0x70
[  204.642105]  rest_init+0x86/0x90
[  204.642105]  start_kernel+0x371/0x38a
[  204.642105]  i386_start_kernel+0x95/0x99
[  204.642105]  startup_32_smp+0x164/0x168
[  204.642105] Code: 91 4e 00 5b 5e 5d c3 8d 74 26 00 55 b8 60 26 90 d2 89 e5 5d c3 8d b6 00 00 00 00 55 64 a1 00 61 8b d2 89 e5 0f a3 05 58 26 90 d2 <0f> 92 c0 0f b6 c0 5d c3 90 8d b4 26 00 00 00 00 64 a1 00 61 8b
[  205.188004] rcu_sched kthread starved for 15755 jiffies! g2135 c2134 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=0
[  205.188004] rcu_sched       I    0     8      2 0x80000000
[  205.188004] Call Trace:
[  205.188004]  __schedule+0x3f9/0x880
[  205.188004]  schedule+0x29/0x70
[  205.188004]  schedule_timeout+0x12d/0x2f0
[  205.188004]  ? __next_timer_interrupt+0xc0/0xc0
[  205.188004]  rcu_gp_kthread+0x472/0x7a0
[  205.188004]  kthread+0xd0/0x100
[  205.188004]  ? call_rcu_sched+0x20/0x20
[  205.188004]  ? kthread_associate_blkcg+0x90/0x90
[  205.188004]  ret_from_fork+0x19/0x24
[  207.812046] perf: interrupt took too long (3271 > 3263), lowering kernel.perf_event_max_sample_rate to 61000
[  226.192015] INFO: rcu_sched detected stalls on CPUs/tasks:
[  226.196004] 	0-...!: (0 ticks this GP) idle=e10/0/0 softirq=5073/5073 fqs=0 
[  226.196004] 	(detected by 1, t=5252 jiffies, g=2136, c=2135, q=6407)
[  226.196004] Sending NMI from CPU 1 to CPUs 0:
[  225.764039] NMI backtrace for cpu 0
[  225.764039] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W        4.15.0-rc5-dou-p+ #1
[  225.764039] Hardware name: ASUSTeK Computer Inc. F5RL                /F5RL      , BIOS 210     06/12/2008
[  225.764039] EIP: tick_check_broadcast_expired+0x0/0x20
[  225.764039] EFLAGS: 00000246 CPU: 0
[  225.764039] EAX: 00000000 EBX: d2792180 ECX: d28bbf28 EDX: 0002be0e
[  225.764039] ESI: d2792180 EDI: 00000000 EBP: d278df38 ESP: d278df28
[  225.764039]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[  225.764039] CR0: 80050033 CR2: 09f63608 CR3: 36d65d00 CR4: 000006f0
[  225.764039] Call Trace:
[  225.764039]  ? cpu_idle_poll+0x46/0x130
[  225.764039]  do_idle+0x3d/0x1a0
[  225.764039]  cpu_startup_entry+0x65/0x70
[  225.764039]  rest_init+0x86/0x90
[  225.764039]  start_kernel+0x371/0x38a
[  225.764039]  i386_start_kernel+0x95/0x99
[  225.764039]  startup_32_smp+0x164/0x168
[  225.764039] Code: 00 00 e8 24 e8 ff ff 89 f2 b8 00 0e 79 d2 e8 28 91 4e 00 5b 5e 5d c3 8d 74 26 00 55 b8 60 26 90 d2 89 e5 5d c3 8d b6 00 00 00 00 <55> 64 a1 00 61 8b d2 89 e5 0f a3 05 58 26 90 d2 0f 92 c0 0f b6
[  226.196004] rcu_sched kthread starved for 5252 jiffies! g2136 c2135 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=0
[  226.196004] rcu_sched       I    0     8      2 0x80000000
[  226.196004] Call Trace:
[  226.196004]  __schedule+0x3f9/0x880
[  226.196004]  schedule+0x29/0x70
[  226.196004]  schedule_timeout+0x12d/0x2f0
[  226.196004]  ? __next_timer_interrupt+0xc0/0xc0
[  226.196004]  rcu_gp_kthread+0x472/0x7a0
[  226.196004]  kthread+0xd0/0x100
[  226.196004]  ? call_rcu_sched+0x20/0x20
[  226.196004]  ? kthread_associate_blkcg+0x90/0x90
[  226.196004]  ret_from_fork+0x19/0x24

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=log-jrnl-thms-debug

-- Logs begin at Sat 2017-12-23 09:37:31 EST, end at Thu 2017-12-28 09:10:46 EST. --
Dec 28 09:03:51 D-69-91-141-110 kernel: Linux version 4.15.0-rc5-thms-p+ (root@axiomatic) (gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.5)) #1 SMP Thu Dec 28 07:52:01 EST 2017
Dec 28 09:03:51 D-69-91-141-110 kernel: x86/fpu: x87 FPU will use FXSAVE
Dec 28 09:03:51 D-69-91-141-110 kernel: e820: BIOS-provided physical RAM map:
Dec 28 09:03:51 D-69-91-141-110 kernel: BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
Dec 28 09:03:51 D-69-91-141-110 kernel: BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
Dec 28 09:03:51 D-69-91-141-110 kernel: BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
Dec 28 09:03:51 D-69-91-141-110 kernel: BIOS-e820: [mem 0x0000000000100000-0x00000000b7f9ffff] usable
Dec 28 09:03:51 D-69-91-141-110 kernel: BIOS-e820: [mem 0x00000000b7fa0000-0x00000000b7fadfff] ACPI data
Dec 28 09:03:51 D-69-91-141-110 kernel: BIOS-e820: [mem 0x00000000b7fae000-0x00000000b7feffff] ACPI NVS
Dec 28 09:03:51 D-69-91-141-110 kernel: BIOS-e820: [mem 0x00000000b7ff0000-0x00000000b7ffffff] reserved
Dec 28 09:03:51 D-69-91-141-110 kernel: BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
Dec 28 09:03:51 D-69-91-141-110 kernel: BIOS-e820: [mem 0x00000000ffb80000-0x00000000ffffffff] reserved
Dec 28 09:03:51 D-69-91-141-110 kernel: NX (Execute Disable) protection: active
Dec 28 09:03:51 D-69-91-141-110 kernel: random: fast init done
Dec 28 09:03:51 D-69-91-141-110 kernel: SMBIOS 2.4 present.
Dec 28 09:03:51 D-69-91-141-110 kernel: DMI: ASUSTeK Computer Inc. F5RL                /F5RL      , BIOS 210     06/12/2008
Dec 28 09:03:51 D-69-91-141-110 kernel: e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
Dec 28 09:03:51 D-69-91-141-110 kernel: e820: remove [mem 0x000a0000-0x000fffff] usable
Dec 28 09:03:51 D-69-91-141-110 kernel: e820: last_pfn = 0xb7fa0 max_arch_pfn = 0x1000000
Dec 28 09:03:51 D-69-91-141-110 kernel: MTRR default type: uncachable
Dec 28 09:03:51 D-69-91-141-110 kernel: MTRR fixed ranges enabled:
Dec 28 09:03:51 D-69-91-141-110 kernel:   00000-9FFFF write-back
Dec 28 09:03:51 D-69-91-141-110 kernel:   A0000-BFFFF uncachable
Dec 28 09:03:51 D-69-91-141-110 kernel:   C0000-CFFFF write-protect
Dec 28 09:03:51 D-69-91-141-110 kernel:   D0000-DFFFF uncachable
Dec 28 09:03:51 D-69-91-141-110 kernel:   E0000-EFFFF write-through
Dec 28 09:03:51 D-69-91-141-110 kernel:   F0000-FFFFF write-protect
Dec 28 09:03:51 D-69-91-141-110 kernel: MTRR variable ranges enabled:
Dec 28 09:03:51 D-69-91-141-110 kernel:   0 base 000000000 mask F80000000 write-back
Dec 28 09:03:51 D-69-91-141-110 kernel:   1 base 080000000 mask FE0000000 write-back
Dec 28 09:03:51 D-69-91-141-110 kernel:   2 base 0A0000000 mask FF0000000 write-back
Dec 28 09:03:51 D-69-91-141-110 kernel:   3 base 0B0000000 mask FF8000000 write-back
Dec 28 09:03:51 D-69-91-141-110 kernel:   4 base 0B8000000 mask FFC000000 write-back
Dec 28 09:03:51 D-69-91-141-110 kernel:   5 base 0BC000000 mask FFF000000 write-back
Dec 28 09:03:51 D-69-91-141-110 kernel:   6 base 0C0000000 mask FF0000000 write-combining
Dec 28 09:03:51 D-69-91-141-110 kernel:   7 disabled
Dec 28 09:03:51 D-69-91-141-110 kernel: x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
Dec 28 09:03:51 D-69-91-141-110 kernel: Scan for SMP in [mem 0x00000000-0x000003ff]
Dec 28 09:03:51 D-69-91-141-110 kernel: Scan for SMP in [mem 0x0009fc00-0x0009ffff]
Dec 28 09:03:51 D-69-91-141-110 kernel: Scan for SMP in [mem 0x000f0000-0x000fffff]
Dec 28 09:03:51 D-69-91-141-110 kernel: found SMP MP-table at [mem 0x000ff780-0x000ff78f] mapped at [(ptrval)]
Dec 28 09:03:51 D-69-91-141-110 kernel:   mpc: fd2d0-fd434
Dec 28 09:03:51 D-69-91-141-110 kernel: initial memory mapped: [mem 0x00000000-0x0bdfffff]
Dec 28 09:03:51 D-69-91-141-110 kernel: Base memory trampoline at [(ptrval)] 9b000 size 16384
Dec 28 09:03:51 D-69-91-141-110 kernel: BRK [0x0b996000, 0x0b996fff] PGTABLE
Dec 28 09:03:51 D-69-91-141-110 kernel: BRK [0x0b997000, 0x0b998fff] PGTABLE
Dec 28 09:03:51 D-69-91-141-110 kernel: BRK [0x0b999000, 0x0b999fff] PGTABLE
Dec 28 09:03:51 D-69-91-141-110 kernel: BRK [0x0b99a000, 0x0b99afff] PGTABLE
Dec 28 09:03:51 D-69-91-141-110 kernel: RAMDISK: [mem 0x35d37000-0x36e92fff]
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: Early table checksum verification disabled
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: RSDP 0x00000000000F8070 000014 (v00 ACPIAM)
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: RSDT 0x00000000B7FA0000 00003C (v01 A_M_I_ OEMRSDT  06000812 MSFT 00000097)
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: FACP 0x00000000B7FA0200 000084 (v02 A_M_I_ OEMFACP  06000812 MSFT 00000097)
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: DSDT 0x00000000B7FA0630 0075FA (v01 A0669  A0669000 00000000 INTL 20060113)
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: FACS 0x00000000B7FAE000 000040
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: APIC 0x00000000B7FA0390 00005C (v01 A_M_I_ OEMAPIC  06000812 MSFT 00000097)
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: MCFG 0x00000000B7FA03F0 00003C (v01 A_M_I_ OEMMCFG  06000812 MSFT 00000097)
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: SLIC 0x00000000B7FA0430 000176 (v01 A_M_I_ OEMSLIC  06000812 MSFT 00000097)
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: BOOT 0x00000000B7FA0600 000028 (v01 A_M_I_ OEMBOOT  06000812 MSFT 00000097)
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: OEMB 0x00000000B7FAE040 00005B (v01 A_M_I_ AMI_OEM  06000812 MSFT 00000097)
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: Local APIC address 0xfee00000
Dec 28 09:03:51 D-69-91-141-110 kernel: mapped APIC to         ffffc000 (        fee00000)
Dec 28 09:03:51 D-69-91-141-110 kernel: 2057MB HIGHMEM available.
Dec 28 09:03:51 D-69-91-141-110 kernel: 885MB LOWMEM available.
Dec 28 09:03:51 D-69-91-141-110 kernel:   mapped low ram: 0 - 375fe000
Dec 28 09:03:51 D-69-91-141-110 kernel:   low ram: 0 - 375fe000
Dec 28 09:03:51 D-69-91-141-110 kernel: Reserving 256MB of memory at 256MB for crashkernel (System RAM: 2943MB)
Dec 28 09:03:51 D-69-91-141-110 kernel: tsc: Fast TSC calibration using PIT
Dec 28 09:03:51 D-69-91-141-110 kernel: BRK [0x0b99b000, 0x0b99bfff] PGTABLE
Dec 28 09:03:51 D-69-91-141-110 kernel: Zone ranges:
Dec 28 09:03:51 D-69-91-141-110 kernel:   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
Dec 28 09:03:51 D-69-91-141-110 kernel:   Normal   [mem 0x0000000001000000-0x00000000375fdfff]
Dec 28 09:03:51 D-69-91-141-110 kernel:   HighMem  [mem 0x00000000375fe000-0x00000000b7f9ffff]
Dec 28 09:03:51 D-69-91-141-110 kernel: Movable zone start for each node
Dec 28 09:03:51 D-69-91-141-110 kernel: Early memory node ranges
Dec 28 09:03:51 D-69-91-141-110 kernel:   node   0: [mem 0x0000000000001000-0x000000000009efff]
Dec 28 09:03:51 D-69-91-141-110 kernel:   node   0: [mem 0x0000000000100000-0x00000000b7f9ffff]
Dec 28 09:03:51 D-69-91-141-110 kernel: Initmem setup node 0 [mem 0x0000000000001000-0x00000000b7f9ffff]
Dec 28 09:03:51 D-69-91-141-110 kernel: On node 0 totalpages: 753470
Dec 28 09:03:51 D-69-91-141-110 kernel:   DMA zone: 36 pages used for memmap
Dec 28 09:03:51 D-69-91-141-110 kernel:   DMA zone: 0 pages reserved
Dec 28 09:03:51 D-69-91-141-110 kernel:   DMA zone: 3998 pages, LIFO batch:0
Dec 28 09:03:51 D-69-91-141-110 kernel:   Normal zone: 1958 pages used for memmap
Dec 28 09:03:51 D-69-91-141-110 kernel:   Normal zone: 222718 pages, LIFO batch:31
Dec 28 09:03:51 D-69-91-141-110 kernel:   HighMem zone: 526754 pages, LIFO batch:31
Dec 28 09:03:51 D-69-91-141-110 kernel: Reserved but unavailable: 98 pages
Dec 28 09:03:51 D-69-91-141-110 kernel: Using APIC driver default
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: PM-Timer IO Port: 0x808
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: Local APIC address 0xfee00000
Dec 28 09:03:51 D-69-91-141-110 kernel: IOAPIC[0]: apic_id 2, version 33, address 0xfec00000, GSI 0-23
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Dec 28 09:03:51 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 2, APIC INT 02
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Dec 28 09:03:51 D-69-91-141-110 kernel: Int: type 0, pol 3, trig 3, bus 00, IRQ 09, APIC ID 2, APIC INT 09
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: IRQ0 used by override.
Dec 28 09:03:51 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 2, APIC INT 01
Dec 28 09:03:51 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 2, APIC INT 03
Dec 28 09:03:51 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 2, APIC INT 04
Dec 28 09:03:51 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 05, APIC ID 2, APIC INT 05
Dec 28 09:03:51 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 2, APIC INT 06
Dec 28 09:03:51 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 2, APIC INT 07
Dec 28 09:03:51 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 2, APIC INT 08
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: IRQ9 used by override.
Dec 28 09:03:51 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 0a, APIC ID 2, APIC INT 0a
Dec 28 09:03:51 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 0b, APIC ID 2, APIC INT 0b
Dec 28 09:03:51 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 2, APIC INT 0c
Dec 28 09:03:51 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 2, APIC INT 0d
Dec 28 09:03:51 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 2, APIC INT 0e
Dec 28 09:03:51 D-69-91-141-110 kernel: Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 2, APIC INT 0f
Dec 28 09:03:51 D-69-91-141-110 kernel: Using ACPI (MADT) for SMP configuration information
Dec 28 09:03:51 D-69-91-141-110 kernel: smpboot: Allowing 2 CPUs, 0 hotplug CPUs
Dec 28 09:03:51 D-69-91-141-110 kernel: mapped IOAPIC to ffffb000 (fec00000)
Dec 28 09:03:51 D-69-91-141-110 kernel: PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
Dec 28 09:03:51 D-69-91-141-110 kernel: PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
Dec 28 09:03:51 D-69-91-141-110 kernel: PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
Dec 28 09:03:51 D-69-91-141-110 kernel: PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
Dec 28 09:03:51 D-69-91-141-110 kernel: e820: [mem 0xb8000000-0xfedfffff] available for PCI devices
Dec 28 09:03:51 D-69-91-141-110 kernel: clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
Dec 28 09:03:51 D-69-91-141-110 kernel: setup_percpu: NR_CPUS:32 nr_cpumask_bits:32 nr_cpu_ids:2 nr_node_ids:1
Dec 28 09:03:51 D-69-91-141-110 kernel: percpu: Embedded 24 pages/cpu @(ptrval) s65612 r0 d32692 u98304
Dec 28 09:03:51 D-69-91-141-110 kernel: pcpu-alloc: s65612 r0 d32692 u98304 alloc=24*4096
Dec 28 09:03:51 D-69-91-141-110 kernel: pcpu-alloc: [0] 0 [0] 1 
Dec 28 09:03:51 D-69-91-141-110 kernel: Built 1 zonelists, mobility grouping on.  Total pages: 751476
Dec 28 09:03:51 D-69-91-141-110 kernel: Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.15.0-rc5-thms-p+ root=UUID=5a437cd2-c27b-4829-a7ba-533eb741b148 ro 3 crashkernel=256M quiet apic=debug
Dec 28 09:03:51 D-69-91-141-110 kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Dec 28 09:03:51 D-69-91-141-110 kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Dec 28 09:03:51 D-69-91-141-110 kernel: microcode: microcode updated early to revision 0xa4, date = 2010-10-02
Dec 28 09:03:51 D-69-91-141-110 kernel: Initializing CPU#0
Dec 28 09:03:51 D-69-91-141-110 kernel: Initializing HighMem for node 0 (000375fe:000b7fa0)
Dec 28 09:03:51 D-69-91-141-110 kernel: Initializing Movable for node 0 (00000000:00000000)
Dec 28 09:03:51 D-69-91-141-110 kernel: Memory: 2696580K/3013880K available (5865K kernel code, 593K rwdata, 1836K rodata, 604K init, 428K bss, 317300K reserved, 0K cma-reserved, 2107016K highmem)
Dec 28 09:03:51 D-69-91-141-110 kernel: virtual kernel memory layout:
                                            fixmap  : 0xffd36000 - 0xfffff000   (2852 kB)
                                          cpu_entry : 0xff800000 - 0xff8c1000   ( 772 kB)
                                            pkmap   : 0xff600000 - 0xff800000   (2048 kB)
                                            vmalloc : 0xf7dfe000 - 0xff5fe000   ( 120 MB)
                                            lowmem  : 0xc0000000 - 0xf75fe000   ( 885 MB)
                                              .init : 0xcb82e000 - 0xcb8c5000   ( 604 kB)
                                              .data : 0xcb5ba424 - 0xcb820780   (2456 kB)
                                              .text : 0xcb000000 - 0xcb5ba424   (5865 kB)
Dec 28 09:03:51 D-69-91-141-110 kernel: Checking if this processor honours the WP bit even in supervisor mode...Ok.
Dec 28 09:03:51 D-69-91-141-110 kernel: Hierarchical RCU implementation.
Dec 28 09:03:51 D-69-91-141-110 kernel:         RCU restricting CPUs from NR_CPUS=32 to nr_cpu_ids=2.
Dec 28 09:03:51 D-69-91-141-110 kernel: RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
Dec 28 09:03:51 D-69-91-141-110 kernel: NR_IRQS: 2304, nr_irqs: 440, preallocated irqs: 16
Dec 28 09:03:51 D-69-91-141-110 kernel: CPU 0 irqstacks, hard=(ptrval) soft=(ptrval)
Dec 28 09:03:51 D-69-91-141-110 kernel: Console: colour VGA+ 80x25
Dec 28 09:03:51 D-69-91-141-110 kernel: console [tty0] enabled
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: Core revision 20170831
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: 1 ACPI AML tables successfully acquired and loaded
Dec 28 09:03:51 D-69-91-141-110 kernel: APIC: Switch to symmetric I/O mode setup
Dec 28 09:03:51 D-69-91-141-110 kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Dec 28 09:03:51 D-69-91-141-110 kernel: enabled ExtINT on CPU#0
Dec 28 09:03:51 D-69-91-141-110 kernel: ESR value before enabling vector: 0x00000040  after: 0x00000000
Dec 28 09:03:51 D-69-91-141-110 kernel: ENABLING IO-APIC IRQs
Dec 28 09:03:51 D-69-91-141-110 kernel: init IO_APIC IRQs
Dec 28 09:03:51 D-69-91-141-110 kernel:  apic 2 pin 0 not connected
Dec 28 09:03:51 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-1 -> 0xef -> IRQ 1 Mode:0 Active:0 Dest:1)
Dec 28 09:03:51 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-2 -> 0x30 -> IRQ 0 Mode:0 Active:0 Dest:1)
Dec 28 09:03:51 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-3 -> 0xef -> IRQ 3 Mode:0 Active:0 Dest:1)
Dec 28 09:03:51 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-4 -> 0xef -> IRQ 4 Mode:0 Active:0 Dest:1)
Dec 28 09:03:51 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-5 -> 0xef -> IRQ 5 Mode:0 Active:0 Dest:1)
Dec 28 09:03:51 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-6 -> 0xef -> IRQ 6 Mode:0 Active:0 Dest:1)
Dec 28 09:03:51 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-7 -> 0xef -> IRQ 7 Mode:0 Active:0 Dest:1)
Dec 28 09:03:51 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-8 -> 0xef -> IRQ 8 Mode:0 Active:0 Dest:1)
Dec 28 09:03:51 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-9 -> 0xef -> IRQ 9 Mode:1 Active:1 Dest:1)
Dec 28 09:03:51 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-10 -> 0xef -> IRQ 10 Mode:0 Active:0 Dest:1)
Dec 28 09:03:51 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-11 -> 0xef -> IRQ 11 Mode:0 Active:0 Dest:1)
Dec 28 09:03:51 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-12 -> 0xef -> IRQ 12 Mode:0 Active:0 Dest:1)
Dec 28 09:03:51 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-13 -> 0xef -> IRQ 13 Mode:0 Active:0 Dest:1)
Dec 28 09:03:51 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-14 -> 0xef -> IRQ 14 Mode:0 Active:0 Dest:1)
Dec 28 09:03:51 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-15 -> 0xef -> IRQ 15 Mode:0 Active:0 Dest:1)
Dec 28 09:03:51 D-69-91-141-110 kernel:  apic 2 pin 16 not connected
Dec 28 09:03:51 D-69-91-141-110 kernel:  apic 2 pin 17 not connected
Dec 28 09:03:51 D-69-91-141-110 kernel:  apic 2 pin 18 not connected
Dec 28 09:03:51 D-69-91-141-110 kernel:  apic 2 pin 19 not connected
Dec 28 09:03:51 D-69-91-141-110 kernel:  apic 2 pin 20 not connected
Dec 28 09:03:51 D-69-91-141-110 kernel:  apic 2 pin 21 not connected
Dec 28 09:03:51 D-69-91-141-110 kernel:  apic 2 pin 22 not connected
Dec 28 09:03:51 D-69-91-141-110 kernel:  apic 2 pin 23 not connected
Dec 28 09:03:51 D-69-91-141-110 kernel: ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
Dec 28 09:03:51 D-69-91-141-110 kernel: tsc: Fast TSC calibration using PIT
Dec 28 09:03:51 D-69-91-141-110 kernel: tsc: Detected 1662.405 MHz processor
Dec 28 09:03:51 D-69-91-141-110 kernel: Calibrating delay loop (skipped), value calculated using timer frequency.. 3324.81 BogoMIPS (lpj=6649620)
Dec 28 09:03:51 D-69-91-141-110 kernel: pid_max: default: 32768 minimum: 301
Dec 28 09:03:51 D-69-91-141-110 kernel: Security Framework initialized
Dec 28 09:03:51 D-69-91-141-110 kernel: Yama: becoming mindful.
Dec 28 09:03:51 D-69-91-141-110 kernel: AppArmor: AppArmor disabled by boot time parameter
Dec 28 09:03:51 D-69-91-141-110 kernel: Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
Dec 28 09:03:51 D-69-91-141-110 kernel: Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
Dec 28 09:03:51 D-69-91-141-110 kernel: CPU: Physical Processor ID: 0
Dec 28 09:03:51 D-69-91-141-110 kernel: CPU: Processor Core ID: 0
Dec 28 09:03:51 D-69-91-141-110 kernel: mce: CPU supports 6 MCE banks
Dec 28 09:03:51 D-69-91-141-110 kernel: process: using mwait in idle threads
Dec 28 09:03:51 D-69-91-141-110 kernel: Last level iTLB entries: 4KB 128, 2MB 4, 4MB 4
Dec 28 09:03:51 D-69-91-141-110 kernel: Last level dTLB entries: 4KB 256, 2MB 0, 4MB 32, 1GB 0
Dec 28 09:03:51 D-69-91-141-110 kernel: Freeing SMP alternatives memory: 24K
Dec 28 09:03:51 D-69-91-141-110 kernel: Using local APIC timer interrupts.
                                        calibrating APIC timer ...
Dec 28 09:03:51 D-69-91-141-110 kernel: ... lapic delta = 1039124
Dec 28 09:03:51 D-69-91-141-110 kernel: ... PM-Timer delta = 357975
Dec 28 09:03:51 D-69-91-141-110 kernel: ... PM-Timer result ok
Dec 28 09:03:51 D-69-91-141-110 kernel: ..... delta 1039124
Dec 28 09:03:51 D-69-91-141-110 kernel: ..... mult: 44630035
Dec 28 09:03:51 D-69-91-141-110 kernel: ..... calibration result: 665039
Dec 28 09:03:51 D-69-91-141-110 kernel: ..... CPU clock speed is 1662.2390 MHz.
Dec 28 09:03:51 D-69-91-141-110 kernel: ..... host bus clock speed is 166.1039 MHz.
Dec 28 09:03:51 D-69-91-141-110 kernel: smpboot: CPU0: Intel(R) Core(TM)2 Duo CPU     T5450  @ 1.66GHz (family: 0x6, model: 0xf, stepping: 0xd)
Dec 28 09:03:51 D-69-91-141-110 kernel: Performance Events: PEBS fmt0+, Core2 events, Intel PMU driver.
Dec 28 09:03:51 D-69-91-141-110 kernel: core: PEBS disabled due to CPU errata
Dec 28 09:03:51 D-69-91-141-110 kernel: ... version:                2
Dec 28 09:03:51 D-69-91-141-110 kernel: ... bit width:              40
Dec 28 09:03:51 D-69-91-141-110 kernel: ... generic registers:      2
Dec 28 09:03:51 D-69-91-141-110 kernel: ... value mask:             000000ffffffffff
Dec 28 09:03:51 D-69-91-141-110 kernel: ... max period:             000000007fffffff
Dec 28 09:03:51 D-69-91-141-110 kernel: ... fixed-purpose events:   3
Dec 28 09:03:51 D-69-91-141-110 kernel: ... event mask:             0000000700000003
Dec 28 09:03:51 D-69-91-141-110 kernel: Hierarchical SRCU implementation.
Dec 28 09:03:51 D-69-91-141-110 kernel: NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
Dec 28 09:03:51 D-69-91-141-110 kernel: smp: Bringing up secondary CPUs ...
Dec 28 09:03:51 D-69-91-141-110 kernel: CPU 1 irqstacks, hard=b9f0c8b3 soft=3254f1bc
Dec 28 09:03:51 D-69-91-141-110 kernel: x86: Booting SMP configuration:
Dec 28 09:03:51 D-69-91-141-110 kernel: .... node  #0, CPUs:      #1
Dec 28 09:03:51 D-69-91-141-110 kernel: Initializing CPU#1
Dec 28 09:03:51 D-69-91-141-110 kernel: masked ExtINT on CPU#1
Dec 28 09:03:51 D-69-91-141-110 kernel: smp: Brought up 1 node, 2 CPUs
Dec 28 09:03:51 D-69-91-141-110 kernel: smpboot: Max logical packages: 1
Dec 28 09:03:51 D-69-91-141-110 kernel: smpboot: Total of 2 processors activated (6649.62 BogoMIPS)
Dec 28 09:03:51 D-69-91-141-110 kernel: devtmpfs: initialized
Dec 28 09:03:51 D-69-91-141-110 kernel: PM: Registering ACPI NVS region [mem 0xb7fae000-0xb7feffff] (270336 bytes)
Dec 28 09:03:51 D-69-91-141-110 kernel: clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
Dec 28 09:03:51 D-69-91-141-110 kernel: futex hash table entries: 512 (order: 3, 32768 bytes)
Dec 28 09:03:51 D-69-91-141-110 kernel: pinctrl core: initialized pinctrl subsystem
Dec 28 09:03:51 D-69-91-141-110 kernel: NET: Registered protocol family 16
Dec 28 09:03:51 D-69-91-141-110 kernel: audit: initializing netlink subsys (disabled)
Dec 28 09:03:51 D-69-91-141-110 kernel: audit: type=2000 audit(1514469822.032:1): state=initialized audit_enabled=0 res=1
Dec 28 09:03:51 D-69-91-141-110 kernel: cpuidle: using governor ladder
Dec 28 09:03:51 D-69-91-141-110 kernel: cpuidle: using governor menu
Dec 28 09:03:51 D-69-91-141-110 kernel: Simple Boot Flag at 0xff set to 0x1
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: bus type PCI registered
Dec 28 09:03:51 D-69-91-141-110 kernel: acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
Dec 28 09:03:51 D-69-91-141-110 kernel: PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
Dec 28 09:03:51 D-69-91-141-110 kernel: PCI: not using MMCONFIG
Dec 28 09:03:51 D-69-91-141-110 kernel: PCI: PCI BIOS area is rw and x. Use pci=nobios if you want it NX.
Dec 28 09:03:51 D-69-91-141-110 kernel: PCI: PCI BIOS revision 3.00 entry at 0xf0031, last bus=8
Dec 28 09:03:51 D-69-91-141-110 kernel: PCI: Using configuration type 1 for base access
Dec 28 09:03:51 D-69-91-141-110 kernel: mtrr: your CPUs had inconsistent variable MTRR settings
Dec 28 09:03:51 D-69-91-141-110 kernel: mtrr: probably your BIOS does not setup all CPUs.
Dec 28 09:03:51 D-69-91-141-110 kernel: mtrr: corrected configuration.
Dec 28 09:03:51 D-69-91-141-110 kernel: HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: Added _OSI(Module Device)
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: Added _OSI(Processor Device)
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: Added _OSI(3.0 _SCP Extensions)
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: Added _OSI(Processor Aggregator Device)
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: Executed 2 blocks of module-level executable AML code
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: Dynamic OEM Table Load:
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: SSDT 0x00000000F7126000 000C99 (v01 AMI    CPU1PM   00000001 INTL 20060113)
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: Dynamic OEM Table Load:
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: SSDT 0x00000000F712C000 000C99 (v01 AMI    CPU2PM   00000001 INTL 20060113)
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: EC: EC started
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: EC: interrupt blocked
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: \_SB_.PCI0.SBRG.EC0_: Used as first EC
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: \_SB_.PCI0.SBRG.EC0_: GPE=0x11, EC_CMD/EC_SC=0x66, EC_DATA=0x62
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: \_SB_.PCI0.SBRG.EC0_: Used as boot DSDT EC to handle transactions
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: Interpreter enabled
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: (supports S0 S3 S4 S5)
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: Using IOAPIC for interrupt routing
Dec 28 09:03:51 D-69-91-141-110 kernel: PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
Dec 28 09:03:51 D-69-91-141-110 kernel: PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in ACPI motherboard resources
Dec 28 09:03:51 D-69-91-141-110 kernel: PCI: Using MMCONFIG for extended config space
Dec 28 09:03:51 D-69-91-141-110 kernel: PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: Enabled 6 GPEs in block 00 to 1F
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
Dec 28 09:03:51 D-69-91-141-110 kernel: acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
Dec 28 09:03:51 D-69-91-141-110 kernel: acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
Dec 28 09:03:51 D-69-91-141-110 kernel: PCI host bridge to bus 0000:00
Dec 28 09:03:51 D-69-91-141-110 kernel: pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000dffff window]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci_bus 0000:00: root bus resource [mem 0xb8000000-0xffffffff window]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci_bus 0000:00: root bus resource [bus 00-ff]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:00.0: [1002:5a31] type 00 class 0x060000
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:01.0: [1002:5a3f] type 01 class 0x060400
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:04.0: [1002:5a36] type 01 class 0x060400
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:04.0: enabling Extended Tags
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:05.0: [1002:5a37] type 01 class 0x060400
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:05.0: enabling Extended Tags
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:05.0: PME# supported from D0 D3hot D3cold
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:06.0: [1002:5a38] type 01 class 0x060400
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:06.0: enabling Extended Tags
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:07.0: [1002:5a39] type 01 class 0x060400
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:07.0: enabling Extended Tags
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:12.0: [1002:4380] type 00 class 0x01018f
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:12.0: reg 0x10: [io  0xe800-0xe807]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:12.0: reg 0x14: [io  0xe400-0xe403]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:12.0: reg 0x18: [io  0xe000-0xe007]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:12.0: reg 0x1c: [io  0xdc00-0xdc03]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:12.0: reg 0x20: [io  0xd800-0xd80f]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:12.0: reg 0x24: [mem 0xfebffc00-0xfebfffff]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:12.0: set SATA to AHCI mode
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:13.0: [1002:4387] type 00 class 0x0c0310
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:13.0: reg 0x10: [mem 0xfebfe000-0xfebfefff]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:13.1: [1002:4388] type 00 class 0x0c0310
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:13.1: reg 0x10: [mem 0xfebfd000-0xfebfdfff]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:13.2: [1002:4389] type 00 class 0x0c0310
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:13.2: reg 0x10: [mem 0xfebfc000-0xfebfcfff]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:13.3: [1002:438a] type 00 class 0x0c0310
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:13.3: reg 0x10: [mem 0xfebfb000-0xfebfbfff]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:13.4: [1002:438b] type 00 class 0x0c0310
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:13.4: reg 0x10: [mem 0xfebfa000-0xfebfafff]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:13.5: [1002:4386] type 00 class 0x0c0320
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:13.5: reg 0x10: [mem 0xfebff800-0xfebff8ff]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:13.5: supports D1 D2
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:13.5: PME# supported from D0 D1 D2 D3hot
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:14.0: [1002:4385] type 00 class 0x0c0500
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:14.0: reg 0x10: [io  0x0b00-0x0b0f]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:14.1: [1002:438c] type 00 class 0x010182
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:14.1: reg 0x10: [io  0x0000-0x0007]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:14.1: reg 0x14: [io  0x0000-0x0003]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:14.1: reg 0x18: [io  0x0000-0x0007]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:14.1: reg 0x1c: [io  0x0000-0x0003]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:14.1: reg 0x20: [io  0xff00-0xff0f]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:14.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:14.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:14.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:14.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:14.2: [1002:4383] type 00 class 0x040300
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:14.2: reg 0x10: [mem 0xfebf4000-0xfebf7fff 64bit]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:14.3: [1002:438d] type 00 class 0x060100
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:14.4: [1002:4384] type 01 class 0x060401
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:01:05.0: [1002:5a62] type 00 class 0x030000
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:01:05.0: reg 0x10: [mem 0xc0000000-0xcfffffff pref]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:01:05.0: reg 0x14: [io  0x9800-0x98ff]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:01:05.0: reg 0x18: [mem 0xfa8f0000-0xfa8fffff]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:01:05.0: reg 0x30: [mem 0xfa8c0000-0xfa8dffff pref]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:01:05.0: supports D1 D2
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:01.0: PCI bridge to [bus 01]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:01.0:   bridge window [io  0x9000-0x9fff]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:01.0:   bridge window [mem 0xfa800000-0xfa8fffff]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:01.0:   bridge window [mem 0xbdf00000-0xddefffff pref]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:02:00.0: [168c:001c] type 00 class 0x020000
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:02:00.0: reg 0x10: [mem 0xfa9f0000-0xfa9fffff 64bit]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:02:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:04.0: PCI bridge to [bus 02]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:04.0:   bridge window [mem 0xfa900000-0xfa9fffff]
Dec 28 09:03:51 D-69-91-141-110 kernel: acpiphp: Slot [1] registered
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:05.0: PCI bridge to [bus 03-05]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:05.0:   bridge window [io  0xa000-0xbfff]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:05.0:   bridge window [mem 0xfaa00000-0xfe9fffff]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:05.0:   bridge window [mem 0xddf00000-0xdfefffff 64bit pref]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:06:00.0: [1969:2048] type 00 class 0x020000
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:06:00.0: reg 0x10: [mem 0xfeac0000-0xfeafffff 64bit]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:06:00.0: reg 0x30: [mem 0xfeaa0000-0xfeabffff pref]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:06:00.0: PME# supported from D3hot D3cold
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:06:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:06.0: PCI bridge to [bus 06]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:06.0:   bridge window [mem 0xfea00000-0xfeafffff]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:07.0: PCI bridge to [bus 07]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:14.4: PCI bridge to [bus 08] (subtractive decode)
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:14.4:   bridge window [io  0x0000-0x0cf7 window] (subtractive decode)
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:14.4:   bridge window [mem 0x000d0000-0x000dffff window] (subtractive decode)
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:14.4:   bridge window [mem 0xb8000000-0xffffffff window] (subtractive decode)
Dec 28 09:03:51 D-69-91-141-110 kernel: pci_bus 0000:00: on NUMA node 0
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 7 10 11 12)
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 12)
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 7 10 11 12)
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *10 11 12)
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 12) *0, disabled.
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 12) *0, disabled.
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 *11 12)
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 12) *0, disabled.
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: EC: interrupt unblocked
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: EC: event unblocked
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: \_SB_.PCI0.SBRG.EC0_: GPE=0x11, EC_CMD/EC_SC=0x66, EC_DATA=0x62
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: \_SB_.PCI0.SBRG.EC0_: Used as boot DSDT EC to handle transactions and events
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:01:05.0: vgaarb: setting as boot VGA device
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:01:05.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:01:05.0: vgaarb: bridge control possible
Dec 28 09:03:51 D-69-91-141-110 kernel: vgaarb: loaded
Dec 28 09:03:51 D-69-91-141-110 kernel: EDAC MC: Ver: 3.0.0
Dec 28 09:03:51 D-69-91-141-110 kernel: PCI: Using ACPI for IRQ routing
Dec 28 09:03:51 D-69-91-141-110 kernel: PCI: pci_cache_line_size set to 64 bytes
Dec 28 09:03:51 D-69-91-141-110 kernel: e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
Dec 28 09:03:51 D-69-91-141-110 kernel: e820: reserve RAM buffer [mem 0xb7fa0000-0xb7ffffff]
Dec 28 09:03:51 D-69-91-141-110 kernel: clocksource: Switched to clocksource refined-jiffies
Dec 28 09:03:51 D-69-91-141-110 kernel: VFS: Disk quotas dquot_6.6.0
Dec 28 09:03:51 D-69-91-141-110 kernel: VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Dec 28 09:03:51 D-69-91-141-110 kernel: pnp: PnP ACPI init
Dec 28 09:03:51 D-69-91-141-110 kernel: pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
Dec 28 09:03:51 D-69-91-141-110 kernel: system 00:01: [io  0x04d0-0x04d1] has been reserved
Dec 28 09:03:51 D-69-91-141-110 kernel: system 00:01: [io  0x040b] has been reserved
Dec 28 09:03:51 D-69-91-141-110 kernel: system 00:01: [io  0x04d6] has been reserved
Dec 28 09:03:51 D-69-91-141-110 kernel: system 00:01: [io  0x0c00-0x0c01] has been reserved
Dec 28 09:03:51 D-69-91-141-110 kernel: system 00:01: [io  0x0c14] has been reserved
Dec 28 09:03:51 D-69-91-141-110 kernel: system 00:01: [io  0x0c50-0x0c51] has been reserved
Dec 28 09:03:51 D-69-91-141-110 kernel: system 00:01: [io  0x0c52] has been reserved
Dec 28 09:03:51 D-69-91-141-110 kernel: system 00:01: [io  0x0c6c] has been reserved
Dec 28 09:03:51 D-69-91-141-110 kernel: system 00:01: [io  0x0c6f] has been reserved
Dec 28 09:03:51 D-69-91-141-110 kernel: system 00:01: [io  0x0cd0-0x0cd1] has been reserved
Dec 28 09:03:51 D-69-91-141-110 kernel: system 00:01: [io  0x0cd2-0x0cd3] has been reserved
Dec 28 09:03:51 D-69-91-141-110 kernel: system 00:01: [io  0x0cd4-0x0cd5] has been reserved
Dec 28 09:03:51 D-69-91-141-110 kernel: system 00:01: [io  0x0cd6-0x0cd7] has been reserved
Dec 28 09:03:51 D-69-91-141-110 kernel: system 00:01: [io  0x0cd8-0x0cdf] has been reserved
Dec 28 09:03:51 D-69-91-141-110 kernel: system 00:01: [io  0x0800-0x089f] has been reserved
Dec 28 09:03:51 D-69-91-141-110 kernel: system 00:01: [io  0x0b00-0x0b1f] could not be reserved
Dec 28 09:03:51 D-69-91-141-110 kernel: system 00:01: [io  0x0900-0x090f] has been reserved
Dec 28 09:03:51 D-69-91-141-110 kernel: system 00:01: [io  0x0910-0x091f] has been reserved
Dec 28 09:03:51 D-69-91-141-110 kernel: system 00:01: [io  0xfe00-0xfefe] has been reserved
Dec 28 09:03:51 D-69-91-141-110 kernel: system 00:01: [io  0x4000-0x40fe] has been reserved
Dec 28 09:03:51 D-69-91-141-110 kernel: system 00:01: [mem 0xfed45000-0xfed89fff] has been reserved
Dec 28 09:03:51 D-69-91-141-110 kernel: system 00:01: [mem 0xffb80000-0xffbfffff] has been reserved
Dec 28 09:03:51 D-69-91-141-110 kernel: system 00:01: [mem 0xfff80000-0xffffffff] has been reserved
Dec 28 09:03:51 D-69-91-141-110 kernel: system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
Dec 28 09:03:51 D-69-91-141-110 kernel: pnp 00:02: Plug and Play ACPI device, IDs PNP0303 PNP030b (active)
Dec 28 09:03:51 D-69-91-141-110 kernel: pnp 00:03: Plug and Play ACPI device, IDs SYN0a04 SYN0a00 SYN0002 PNP0f03 PNP0f13 PNP0f12 (active)
Dec 28 09:03:51 D-69-91-141-110 kernel: system 00:04: [io  0x0250-0x0253] has been reserved
Dec 28 09:03:51 D-69-91-141-110 kernel: system 00:04: [io  0x0256-0x025f] has been reserved
Dec 28 09:03:51 D-69-91-141-110 kernel: system 00:04: [mem 0xfec00000-0xfec00fff] could not be reserved
Dec 28 09:03:51 D-69-91-141-110 kernel: system 00:04: [mem 0xfee00000-0xfee00fff] has been reserved
Dec 28 09:03:51 D-69-91-141-110 kernel: system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
Dec 28 09:03:51 D-69-91-141-110 kernel: system 00:05: [mem 0xe0000000-0xefffffff] has been reserved
Dec 28 09:03:51 D-69-91-141-110 kernel: system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
Dec 28 09:03:51 D-69-91-141-110 kernel: system 00:06: [mem 0x00000000-0x0009ffff] could not be reserved
Dec 28 09:03:51 D-69-91-141-110 kernel: system 00:06: [mem 0x000c0000-0x000cffff] could not be reserved
Dec 28 09:03:51 D-69-91-141-110 kernel: system 00:06: [mem 0x000e0000-0x000fffff] could not be reserved
Dec 28 09:03:51 D-69-91-141-110 kernel: system 00:06: [mem 0x00100000-0xb7ffffff] could not be reserved
Dec 28 09:03:51 D-69-91-141-110 kernel: system 00:06: Plug and Play ACPI device, IDs PNP0c01 (active)
Dec 28 09:03:51 D-69-91-141-110 kernel: pnp: PnP ACPI: found 7 devices
Dec 28 09:03:51 D-69-91-141-110 kernel: PnPBIOS: Disabled
Dec 28 09:03:51 D-69-91-141-110 kernel: clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
Dec 28 09:03:51 D-69-91-141-110 kernel: clocksource: Switched to clocksource acpi_pm
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:01.0: PCI bridge to [bus 01]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:01.0:   bridge window [io  0x9000-0x9fff]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:01.0:   bridge window [mem 0xfa800000-0xfa8fffff]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:01.0:   bridge window [mem 0xbdf00000-0xddefffff pref]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:04.0: PCI bridge to [bus 02]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:04.0:   bridge window [mem 0xfa900000-0xfa9fffff]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:05.0: PCI bridge to [bus 03-05]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:05.0:   bridge window [io  0xa000-0xbfff]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:05.0:   bridge window [mem 0xfaa00000-0xfe9fffff]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:05.0:   bridge window [mem 0xddf00000-0xdfefffff 64bit pref]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:06.0: PCI bridge to [bus 06]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:06.0:   bridge window [mem 0xfea00000-0xfeafffff]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:07.0: PCI bridge to [bus 07]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:14.4: PCI bridge to [bus 08]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000dffff window]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci_bus 0000:00: resource 8 [mem 0xb8000000-0xffffffff window]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci_bus 0000:01: resource 0 [io  0x9000-0x9fff]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci_bus 0000:01: resource 1 [mem 0xfa800000-0xfa8fffff]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci_bus 0000:01: resource 2 [mem 0xbdf00000-0xddefffff pref]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci_bus 0000:02: resource 1 [mem 0xfa900000-0xfa9fffff]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci_bus 0000:03: resource 0 [io  0xa000-0xbfff]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci_bus 0000:03: resource 1 [mem 0xfaa00000-0xfe9fffff]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci_bus 0000:03: resource 2 [mem 0xddf00000-0xdfefffff 64bit pref]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci_bus 0000:06: resource 1 [mem 0xfea00000-0xfeafffff]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci_bus 0000:08: resource 4 [io  0x0000-0x0cf7 window]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci_bus 0000:08: resource 5 [io  0x0d00-0xffff window]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci_bus 0000:08: resource 6 [mem 0x000a0000-0x000bffff window]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci_bus 0000:08: resource 7 [mem 0x000d0000-0x000dffff window]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci_bus 0000:08: resource 8 [mem 0xb8000000-0xffffffff window]
Dec 28 09:03:51 D-69-91-141-110 kernel: NET: Registered protocol family 2
Dec 28 09:03:51 D-69-91-141-110 kernel: TCP established hash table entries: 8192 (order: 3, 32768 bytes)
Dec 28 09:03:51 D-69-91-141-110 kernel: TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
Dec 28 09:03:51 D-69-91-141-110 kernel: TCP: Hash tables configured (established 8192 bind 8192)
Dec 28 09:03:51 D-69-91-141-110 kernel: UDP hash table entries: 512 (order: 2, 16384 bytes)
Dec 28 09:03:51 D-69-91-141-110 kernel: UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
Dec 28 09:03:51 D-69-91-141-110 kernel: NET: Registered protocol family 1
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:00:01.0: MSI quirk detected; subordinate MSI disabled
Dec 28 09:03:51 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-16 -> 0xef -> IRQ 16 Mode:1 Active:1 Dest:1)
Dec 28 09:03:51 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-17 -> 0xef -> IRQ 17 Mode:1 Active:1 Dest:1)
Dec 28 09:03:51 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-18 -> 0xef -> IRQ 18 Mode:1 Active:1 Dest:1)
Dec 28 09:03:51 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-17 -> 0xef -> IRQ 17 Mode:1 Active:1 Dest:1)
Dec 28 09:03:51 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-18 -> 0xef -> IRQ 18 Mode:1 Active:1 Dest:1)
Dec 28 09:03:51 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-19 -> 0xef -> IRQ 19 Mode:1 Active:1 Dest:1)
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:01:05.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
Dec 28 09:03:51 D-69-91-141-110 kernel: pci 0000:06:00.0: [Firmware Bug]: disabling VPD access (can't determine size of non-standard VPD format)
Dec 28 09:03:51 D-69-91-141-110 kernel: PCI: CLS 64 bytes, default 64
Dec 28 09:03:51 D-69-91-141-110 kernel: Unpacking initramfs...
Dec 28 09:03:51 D-69-91-141-110 kernel: Freeing initrd memory: 17776K
Dec 28 09:03:51 D-69-91-141-110 kernel: Initialise system trusted keyrings
Dec 28 09:03:51 D-69-91-141-110 kernel: workingset: timestamp_bits=14 max_order=20 bucket_order=6
Dec 28 09:03:51 D-69-91-141-110 kernel: zbud: loaded
Dec 28 09:03:51 D-69-91-141-110 kernel: tsc: Refined TSC clocksource calibration: 1662.500 MHz
Dec 28 09:03:51 D-69-91-141-110 kernel: clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x17f6c6790c8, max_idle_ns: 440795235729 ns
Dec 28 09:03:51 D-69-91-141-110 kernel: clocksource: Switched to clocksource tsc
Dec 28 09:03:51 D-69-91-141-110 kernel: Key type asymmetric registered
Dec 28 09:03:51 D-69-91-141-110 kernel: Asymmetric key parser 'x509' registered
Dec 28 09:03:51 D-69-91-141-110 kernel: bounce: pool size: 64 pages
Dec 28 09:03:51 D-69-91-141-110 kernel: Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
Dec 28 09:03:51 D-69-91-141-110 kernel: io scheduler noop registered
Dec 28 09:03:51 D-69-91-141-110 kernel: io scheduler deadline registered
Dec 28 09:03:51 D-69-91-141-110 kernel: io scheduler cfq registered (default)
Dec 28 09:03:51 D-69-91-141-110 kernel: io scheduler mq-deadline registered
Dec 28 09:03:51 D-69-91-141-110 kernel: io scheduler kyber registered
Dec 28 09:03:51 D-69-91-141-110 kernel: intel_idle: does not run on family 6 model 15
Dec 28 09:03:51 D-69-91-141-110 kernel: tsc: Marking TSC unstable due to TSC halts in idle
Dec 28 09:03:51 D-69-91-141-110 kernel: clocksource: Switched to clocksource acpi_pm
Dec 28 09:03:51 D-69-91-141-110 kernel: isapnp: Scanning for PnP cards...
Dec 28 09:03:51 D-69-91-141-110 kernel: isapnp: No Plug & Play device found
Dec 28 09:03:51 D-69-91-141-110 kernel: Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
Dec 28 09:03:51 D-69-91-141-110 kernel: Linux agpgart interface v0.103
Dec 28 09:03:51 D-69-91-141-110 kernel: i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
Dec 28 09:03:51 D-69-91-141-110 kernel: i8042: Detected active multiplexing controller, rev 1.1
Dec 28 09:03:51 D-69-91-141-110 kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Dec 28 09:03:51 D-69-91-141-110 kernel: serio: i8042 AUX0 port at 0x60,0x64 irq 12
Dec 28 09:03:51 D-69-91-141-110 kernel: serio: i8042 AUX1 port at 0x60,0x64 irq 12
Dec 28 09:03:51 D-69-91-141-110 kernel: serio: i8042 AUX2 port at 0x60,0x64 irq 12
Dec 28 09:03:51 D-69-91-141-110 kernel: serio: i8042 AUX3 port at 0x60,0x64 irq 12
Dec 28 09:03:51 D-69-91-141-110 kernel: mousedev: PS/2 mouse device common for all mice
Dec 28 09:03:51 D-69-91-141-110 kernel: rtc_cmos 00:00: RTC can wake from S4
Dec 28 09:03:51 D-69-91-141-110 kernel: rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
Dec 28 09:03:51 D-69-91-141-110 kernel: rtc_cmos 00:00: alarms up to one month, y3k, 114 bytes nvram
Dec 28 09:03:51 D-69-91-141-110 kernel: ledtrig-cpu: registered to indicate activity on CPUs
Dec 28 09:03:51 D-69-91-141-110 kernel: NET: Registered protocol family 10
Dec 28 09:03:51 D-69-91-141-110 kernel: Segment Routing with IPv6
Dec 28 09:03:51 D-69-91-141-110 kernel: mip6: Mobile IPv6
Dec 28 09:03:51 D-69-91-141-110 kernel: NET: Registered protocol family 17
Dec 28 09:03:51 D-69-91-141-110 kernel: mpls_gso: MPLS GSO support
Dec 28 09:03:51 D-69-91-141-110 kernel: microcode: sig=0x6fd, pf=0x80, revision=0xa4
Dec 28 09:03:51 D-69-91-141-110 kernel: microcode: Microcode Update Driver: v2.2.
Dec 28 09:03:51 D-69-91-141-110 kernel: ... APIC ID:      00000000 (0)
Dec 28 09:03:51 D-69-91-141-110 kernel: ... APIC VERSION: 00050014
Dec 28 09:03:51 D-69-91-141-110 kernel: 0000000000000000000000000000000000000000000000000000000000000000
Dec 28 09:03:51 D-69-91-141-110 kernel: 0000000000000000000000000000000000000000000000000000000000000000
Dec 28 09:03:51 D-69-91-141-110 kernel: 0000000000000000000000000000000000000000000000000000000000000000
Dec 28 09:03:51 D-69-91-141-110 kernel: number of MP IRQ sources: 15.
Dec 28 09:03:51 D-69-91-141-110 kernel: number of IO-APIC #2 registers: 24.
Dec 28 09:03:51 D-69-91-141-110 kernel: testing the IO APIC.......................
Dec 28 09:03:51 D-69-91-141-110 kernel: IO APIC #2......
Dec 28 09:03:51 D-69-91-141-110 kernel: .... register #00: 02000000
Dec 28 09:03:51 D-69-91-141-110 kernel: .......    : physical APIC id: 02
Dec 28 09:03:51 D-69-91-141-110 kernel: .......    : Delivery Type: 0
Dec 28 09:03:51 D-69-91-141-110 kernel: .......    : LTS          : 0
Dec 28 09:03:51 D-69-91-141-110 kernel: .... register #01: 00178021
Dec 28 09:03:51 D-69-91-141-110 kernel: .......     : max redirection entries: 17
Dec 28 09:03:51 D-69-91-141-110 kernel: .......     : PRQ implemented: 1
Dec 28 09:03:51 D-69-91-141-110 kernel: .......     : IO APIC version: 21
Dec 28 09:03:51 D-69-91-141-110 kernel: .... register #02: 02000000
Dec 28 09:03:51 D-69-91-141-110 kernel: .......     : arbitration: 02
Dec 28 09:03:51 D-69-91-141-110 kernel: .... register #03: 02178021
Dec 28 09:03:51 D-69-91-141-110 kernel: .......     : Boot DT    : 1
Dec 28 09:03:51 D-69-91-141-110 kernel: .... IRQ redirection table:
Dec 28 09:03:51 D-69-91-141-110 kernel: IOAPIC 0:
Dec 28 09:03:51 D-69-91-141-110 kernel:  pin00, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 28 09:03:51 D-69-91-141-110 kernel:  pin01, enabled , edge , high, V(23), IRR(0), S(0), logical , D(01), M(0)
Dec 28 09:03:51 D-69-91-141-110 kernel:  pin02, enabled , edge , high, V(30), IRR(0), S(0), logical , D(01), M(0)
Dec 28 09:03:51 D-69-91-141-110 kernel:  pin03, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 28 09:03:51 D-69-91-141-110 kernel:  pin04, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 28 09:03:51 D-69-91-141-110 kernel:  pin05, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 28 09:03:51 D-69-91-141-110 kernel:  pin06, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 28 09:03:51 D-69-91-141-110 kernel:  pin07, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 28 09:03:51 D-69-91-141-110 kernel:  pin08, enabled , edge , high, V(24), IRR(0), S(0), logical , D(01), M(0)
Dec 28 09:03:51 D-69-91-141-110 kernel:  pin09, enabled , level, low , V(21), IRR(0), S(0), logical , D(01), M(0)
Dec 28 09:03:51 D-69-91-141-110 kernel:  pin0a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 28 09:03:51 D-69-91-141-110 kernel:  pin0b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 28 09:03:51 D-69-91-141-110 kernel:  pin0c, enabled , edge , high, V(22), IRR(0), S(0), logical , D(01), M(0)
Dec 28 09:03:51 D-69-91-141-110 kernel:  pin0d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 28 09:03:51 D-69-91-141-110 kernel:  pin0e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 28 09:03:51 D-69-91-141-110 kernel:  pin0f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 28 09:03:51 D-69-91-141-110 kernel:  pin10, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 28 09:03:51 D-69-91-141-110 kernel:  pin11, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 28 09:03:51 D-69-91-141-110 kernel:  pin12, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 28 09:03:51 D-69-91-141-110 kernel:  pin13, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 28 09:03:51 D-69-91-141-110 kernel:  pin14, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 28 09:03:51 D-69-91-141-110 kernel:  pin15, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 28 09:03:51 D-69-91-141-110 kernel:  pin16, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 28 09:03:51 D-69-91-141-110 kernel:  pin17, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
Dec 28 09:03:51 D-69-91-141-110 kernel: IRQ to pin mappings:
Dec 28 09:03:51 D-69-91-141-110 kernel: IRQ0 -> 0:2
Dec 28 09:03:51 D-69-91-141-110 kernel: IRQ1 -> 0:1
Dec 28 09:03:51 D-69-91-141-110 kernel: IRQ3 -> 0:3
Dec 28 09:03:51 D-69-91-141-110 kernel: IRQ4 -> 0:4
Dec 28 09:03:51 D-69-91-141-110 kernel: IRQ5 -> 0:5
Dec 28 09:03:51 D-69-91-141-110 kernel: IRQ6 -> 0:6
Dec 28 09:03:51 D-69-91-141-110 kernel: IRQ7 -> 0:7
Dec 28 09:03:51 D-69-91-141-110 kernel: IRQ8 -> 0:8
Dec 28 09:03:51 D-69-91-141-110 kernel: IRQ9 -> 0:9
Dec 28 09:03:51 D-69-91-141-110 kernel: IRQ10 -> 0:10
Dec 28 09:03:51 D-69-91-141-110 kernel: IRQ11 -> 0:11
Dec 28 09:03:51 D-69-91-141-110 kernel: IRQ12 -> 0:12
Dec 28 09:03:51 D-69-91-141-110 kernel: IRQ13 -> 0:13
Dec 28 09:03:51 D-69-91-141-110 kernel: IRQ14 -> 0:14
Dec 28 09:03:51 D-69-91-141-110 kernel: IRQ15 -> 0:15
Dec 28 09:03:51 D-69-91-141-110 kernel: .................................... done.
Dec 28 09:03:51 D-69-91-141-110 kernel: Using IPI No-Shortcut mode
Dec 28 09:03:51 D-69-91-141-110 kernel: registered taskstats version 1
Dec 28 09:03:51 D-69-91-141-110 kernel: Loading compiled-in X.509 certificates
Dec 28 09:03:51 D-69-91-141-110 kernel: zswap: loaded using pool lzo/zbud
Dec 28 09:03:51 D-69-91-141-110 kernel: ima: No TPM chip found, activating TPM-bypass! (rc=-19)
Dec 28 09:03:51 D-69-91-141-110 kernel: rtc_cmos 00:00: setting system clock to 2017-12-28 14:03:45 UTC (1514469825)
Dec 28 09:03:51 D-69-91-141-110 kernel: Freeing unused kernel memory: 604K
Dec 28 09:03:51 D-69-91-141-110 kernel: Write protecting the kernel text: 5868k
Dec 28 09:03:51 D-69-91-141-110 kernel: Write protecting the kernel read-only data: 1860k
Dec 28 09:03:51 D-69-91-141-110 kernel: NX-protecting the kernel data: 4372k
Dec 28 09:03:51 D-69-91-141-110 kernel: ------------[ cut here ]------------
Dec 28 09:03:51 D-69-91-141-110 kernel: x86/mm: Found insecure W+X mapping at address 9265f696/0xc00a0000
Dec 28 09:03:51 D-69-91-141-110 kernel: WARNING: CPU: 1 PID: 1 at arch/x86/mm/dump_pagetables.c:257 note_page+0x5ec/0x790
Dec 28 09:03:51 D-69-91-141-110 kernel: Modules linked in:
Dec 28 09:03:51 D-69-91-141-110 kernel: CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.15.0-rc5-thms-p+ #1
Dec 28 09:03:51 D-69-91-141-110 kernel: Hardware name: ASUSTeK Computer Inc. F5RL                /F5RL      , BIOS 210     06/12/2008
Dec 28 09:03:51 D-69-91-141-110 kernel: EIP: note_page+0x5ec/0x790
Dec 28 09:03:51 D-69-91-141-110 kernel: EFLAGS: 00210282 CPU: 1
Dec 28 09:03:51 D-69-91-141-110 kernel: EAX: 00000041 EBX: f70c7f54 ECX: 00000001 EDX: cb8de544
Dec 28 09:03:51 D-69-91-141-110 kernel: ESI: 80000000 EDI: 00000000 EBP: f70c7f20 ESP: f70c7ef4
Dec 28 09:03:51 D-69-91-141-110 kernel:  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
Dec 28 09:03:51 D-69-91-141-110 kernel: CR0: 80050033 CR2: 00000000 CR3: 0b8ce000 CR4: 000006f0
Dec 28 09:03:51 D-69-91-141-110 kernel: Call Trace:
Dec 28 09:03:51 D-69-91-141-110 kernel:  ptdump_walk_pgd_level_core+0x15c/0x240
Dec 28 09:03:51 D-69-91-141-110 kernel:  ptdump_walk_pgd_level_checkwx+0x11/0x20
Dec 28 09:03:51 D-69-91-141-110 kernel:  mark_rodata_ro+0xd5/0xf1
Dec 28 09:03:51 D-69-91-141-110 kernel:  ? rest_init+0x90/0x90
Dec 28 09:03:51 D-69-91-141-110 kernel:  kernel_init+0x24/0xe0
Dec 28 09:03:51 D-69-91-141-110 kernel:  ret_from_fork+0x19/0x24
Dec 28 09:03:51 D-69-91-141-110 kernel: Code: fa ff ff 83 c2 0c c7 43 18 00 00 00 00 89 53 14 e9 1a fd ff ff 8b 43 0c c6 05 c4 76 80 cb 01 50 50 68 50 ee 6c cb e8 84 5c 00 00 <0f> ff 83 c4 0c e9 6f fa ff ff ff 72 10 68 1c ed 6c cb e8 57 f5
Dec 28 09:03:51 D-69-91-141-110 kernel: ---[ end trace 4bee51e11fb46bc2 ]---
Dec 28 09:03:51 D-69-91-141-110 kernel: x86/mm: Checked W+X mappings: FAILED, 96 W+X pages found.
Dec 28 09:03:51 D-69-91-141-110 kernel: input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
Dec 28 09:03:51 D-69-91-141-110 kernel: Atheros(R) L2 Ethernet Driver - version 2.2.3
Dec 28 09:03:51 D-69-91-141-110 kernel: Copyright (c) 2007 Atheros Corporation.
Dec 28 09:03:51 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-18 -> 0xef -> IRQ 18 Mode:1 Active:1 Dest:1)
Dec 28 09:03:51 D-69-91-141-110 kernel: SCSI subsystem initialized
Dec 28 09:03:51 D-69-91-141-110 kernel: libata version 3.00 loaded.
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: bus type USB registered
Dec 28 09:03:51 D-69-91-141-110 kernel: ahci 0000:00:12.0: version 3.0
Dec 28 09:03:51 D-69-91-141-110 kernel: usbcore: registered new interface driver usbfs
Dec 28 09:03:51 D-69-91-141-110 kernel: usbcore: registered new interface driver hub
Dec 28 09:03:51 D-69-91-141-110 kernel: usbcore: registered new device driver usb
Dec 28 09:03:51 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-22 -> 0xef -> IRQ 22 Mode:1 Active:1 Dest:1)
Dec 28 09:03:51 D-69-91-141-110 kernel: ahci 0000:00:12.0: controller can't do 64bit DMA, forcing 32bit
Dec 28 09:03:51 D-69-91-141-110 kernel: ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
Dec 28 09:03:51 D-69-91-141-110 kernel: ahci 0000:00:12.0: flags: ncq sntf ilck led clo pmp pio slum part ccc 
Dec 28 09:03:51 D-69-91-141-110 kernel: ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
Dec 28 09:03:51 D-69-91-141-110 kernel: ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
Dec 28 09:03:51 D-69-91-141-110 kernel: ehci-pci: EHCI PCI platform driver
Dec 28 09:03:51 D-69-91-141-110 kernel: scsi host0: ahci
Dec 28 09:03:51 D-69-91-141-110 kernel: scsi host1: ahci
Dec 28 09:03:51 D-69-91-141-110 kernel: scsi host2: ahci
Dec 28 09:03:51 D-69-91-141-110 kernel: scsi host3: ahci
Dec 28 09:03:51 D-69-91-141-110 kernel: ata1: SATA max UDMA/133 abar m1024@0xfebffc00 port 0xfebffd00 irq 22
Dec 28 09:03:51 D-69-91-141-110 kernel: ata2: SATA max UDMA/133 abar m1024@0xfebffc00 port 0xfebffd80 irq 22
Dec 28 09:03:51 D-69-91-141-110 kernel: ata3: SATA max UDMA/133 abar m1024@0xfebffc00 port 0xfebffe00 irq 22
Dec 28 09:03:51 D-69-91-141-110 kernel: ata4: SATA max UDMA/133 abar m1024@0xfebffc00 port 0xfebffe80 irq 22
Dec 28 09:03:51 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-19 -> 0xef -> IRQ 19 Mode:1 Active:1 Dest:1)
Dec 28 09:03:51 D-69-91-141-110 kernel: ehci-pci 0000:00:13.5: EHCI Host Controller
Dec 28 09:03:51 D-69-91-141-110 kernel: ehci-pci 0000:00:13.5: new USB bus registered, assigned bus number 1
Dec 28 09:03:51 D-69-91-141-110 kernel: ehci-pci 0000:00:13.5: applying AMD SB600/SB700 USB freeze workaround
Dec 28 09:03:51 D-69-91-141-110 kernel: ehci-pci 0000:00:13.5: debug port 1
Dec 28 09:03:51 D-69-91-141-110 kernel: ehci-pci 0000:00:13.5: irq 19, io mem 0xfebff800
Dec 28 09:03:51 D-69-91-141-110 kernel: ehci-pci 0000:00:13.5: USB 2.0 started, EHCI 1.00
Dec 28 09:03:51 D-69-91-141-110 kernel: usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
Dec 28 09:03:51 D-69-91-141-110 kernel: usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Dec 28 09:03:51 D-69-91-141-110 kernel: usb usb1: Product: EHCI Host Controller
Dec 28 09:03:51 D-69-91-141-110 kernel: usb usb1: Manufacturer: Linux 4.15.0-rc5-thms-p+ ehci_hcd
Dec 28 09:03:51 D-69-91-141-110 kernel: usb usb1: SerialNumber: 0000:00:13.5
Dec 28 09:03:51 D-69-91-141-110 kernel: hub 1-0:1.0: USB hub found
Dec 28 09:03:51 D-69-91-141-110 kernel: hub 1-0:1.0: 10 ports detected
Dec 28 09:03:51 D-69-91-141-110 kernel: ohci-pci: OHCI PCI platform driver
Dec 28 09:03:51 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-16 -> 0xef -> IRQ 16 Mode:1 Active:1 Dest:1)
Dec 28 09:03:51 D-69-91-141-110 kernel: ohci-pci 0000:00:13.0: OHCI PCI host controller
Dec 28 09:03:51 D-69-91-141-110 kernel: ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 2
Dec 28 09:03:51 D-69-91-141-110 kernel: ohci-pci 0000:00:13.0: irq 16, io mem 0xfebfe000
Dec 28 09:03:51 D-69-91-141-110 kernel: (NULL device *): hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
Dec 28 09:03:51 D-69-91-141-110 kernel: thermal LNXTHERM:00: registered as thermal_zone0
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: Thermal Zone [THRM] (77 C)
Dec 28 09:03:51 D-69-91-141-110 kernel: usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
Dec 28 09:03:51 D-69-91-141-110 kernel: usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Dec 28 09:03:51 D-69-91-141-110 kernel: usb usb2: Product: OHCI PCI host controller
Dec 28 09:03:51 D-69-91-141-110 kernel: usb usb2: Manufacturer: Linux 4.15.0-rc5-thms-p+ ohci_hcd
Dec 28 09:03:51 D-69-91-141-110 kernel: usb usb2: SerialNumber: 0000:00:13.0
Dec 28 09:03:51 D-69-91-141-110 kernel: hub 2-0:1.0: USB hub found
Dec 28 09:03:51 D-69-91-141-110 kernel: hub 2-0:1.0: 2 ports detected
Dec 28 09:03:51 D-69-91-141-110 kernel: scsi host4: pata_atiixp
Dec 28 09:03:51 D-69-91-141-110 kernel: scsi host5: pata_atiixp
Dec 28 09:03:51 D-69-91-141-110 kernel: ata5: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xff00 irq 14
Dec 28 09:03:51 D-69-91-141-110 kernel: ata6: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xff08 irq 15
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI Warning: SystemIO range 0x0000000000000B00-0x0000000000000B08 conflicts with OpRegion 0x0000000000000B00-0x0000000000000B0F (\SMB0) (20170831/utaddress-247)
Dec 28 09:03:51 D-69-91-141-110 kernel: ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
Dec 28 09:03:51 D-69-91-141-110 kernel: IOAPIC[0]: Set routing entry (2-17 -> 0xef -> IRQ 17 Mode:1 Active:1 Dest:1)
Dec 28 09:03:51 D-69-91-141-110 kernel: ohci-pci 0000:00:13.1: OHCI PCI host controller
Dec 28 09:03:51 D-69-91-141-110 kernel: ohci-pci 0000:00:13.1: new USB bus registered, assigned bus number 3
Dec 28 09:03:51 D-69-91-141-110 kernel: ohci-pci 0000:00:13.1: irq 17, io mem 0xfebfd000
Dec 28 09:03:51 D-69-91-141-110 kernel: usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
Dec 28 09:03:51 D-69-91-141-110 kernel: usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Dec 28 09:03:51 D-69-91-141-110 kernel: usb usb3: Product: OHCI PCI host controller
Dec 28 09:03:51 D-69-91-141-110 kernel: usb usb3: Manufacturer: Linux 4.15.0-rc5-thms-p+ ohci_hcd
Dec 28 09:03:51 D-69-91-141-110 kernel: usb usb3: SerialNumber: 0000:00:13.1
Dec 28 09:03:51 D-69-91-141-110 kernel: hub 3-0:1.0: USB hub found
Dec 28 09:03:51 D-69-91-141-110 kernel: hub 3-0:1.0: 2 ports detected
Dec 28 09:03:51 D-69-91-141-110 kernel: ohci-pci 0000:00:13.2: OHCI PCI host controller
Dec 28 09:03:51 D-69-91-141-110 kernel: ohci-pci 0000:00:13.2: new USB bus registered, assigned bus number 4
Dec 28 09:03:51 D-69-91-141-110 kernel: ohci-pci 0000:00:13.2: irq 18, io mem 0xfebfc000
Dec 28 09:03:51 D-69-91-141-110 kernel: usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
Dec 28 09:03:51 D-69-91-141-110 kernel: usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Dec 28 09:03:51 D-69-91-141-110 kernel: usb usb4: Product: OHCI PCI host controller
Dec 28 09:03:51 D-69-91-141-110 kernel: usb usb4: Manufacturer: Linux 4.15.0-rc5-thms-p+ ohci_hcd
Dec 28 09:03:51 D-69-91-141-110 kernel: usb usb4: SerialNumber: 0000:00:13.2
Dec 28 09:03:51 D-69-91-141-110 kernel: hub 4-0:1.0: USB hub found
Dec 28 09:03:51 D-69-91-141-110 kernel: hub 4-0:1.0: 2 ports detected
Dec 28 09:03:51 D-69-91-141-110 kernel: ohci-pci 0000:00:13.3: OHCI PCI host controller
Dec 28 09:03:51 D-69-91-141-110 kernel: ohci-pci 0000:00:13.3: new USB bus registered, assigned bus number 5
Dec 28 09:03:51 D-69-91-141-110 kernel: ohci-pci 0000:00:13.3: irq 17, io mem 0xfebfb000
Dec 28 09:03:51 D-69-91-141-110 kernel: ata5.00: ATAPI: HL-DT-ST DVDRAM GSA-T40N, JR03, max UDMA/33
Dec 28 09:03:51 D-69-91-141-110 kernel: usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
Dec 28 09:03:51 D-69-91-141-110 kernel: usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Dec 28 09:03:51 D-69-91-141-110 kernel: usb usb5: Product: OHCI PCI host controller
Dec 28 09:03:51 D-69-91-141-110 kernel: usb usb5: Manufacturer: Linux 4.15.0-rc5-thms-p+ ohci_hcd
Dec 28 09:03:51 D-69-91-141-110 kernel: usb usb5: SerialNumber: 0000:00:13.3
Dec 28 09:03:51 D-69-91-141-110 kernel: hub 5-0:1.0: USB hub found
Dec 28 09:03:51 D-69-91-141-110 kernel: hub 5-0:1.0: 2 ports detected
Dec 28 09:03:51 D-69-91-141-110 kernel: ohci-pci 0000:00:13.4: OHCI PCI host controller
Dec 28 09:03:51 D-69-91-141-110 kernel: ohci-pci 0000:00:13.4: new USB bus registered, assigned bus number 6
Dec 28 09:03:51 D-69-91-141-110 kernel: ohci-pci 0000:00:13.4: irq 18, io mem 0xfebfa000
Dec 28 09:03:51 D-69-91-141-110 kernel: ata5.00: configured for UDMA/33
Dec 28 09:03:51 D-69-91-141-110 kernel: ata2: SATA link down (SStatus 0 SControl 300)
Dec 28 09:03:51 D-69-91-141-110 kernel: ata4: SATA link down (SStatus 0 SControl 300)
Dec 28 09:03:51 D-69-91-141-110 kernel: ata3: SATA link down (SStatus 0 SControl 300)
Dec 28 09:03:51 D-69-91-141-110 kernel: usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
Dec 28 09:03:51 D-69-91-141-110 kernel: usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Dec 28 09:03:51 D-69-91-141-110 kernel: usb usb6: Product: OHCI PCI host controller
Dec 28 09:03:51 D-69-91-141-110 kernel: usb usb6: Manufacturer: Linux 4.15.0-rc5-thms-p+ ohci_hcd
Dec 28 09:03:51 D-69-91-141-110 kernel: usb usb6: SerialNumber: 0000:00:13.4
Dec 28 09:03:51 D-69-91-141-110 kernel: hub 6-0:1.0: USB hub found
Dec 28 09:03:51 D-69-91-141-110 kernel: hub 6-0:1.0: 2 ports detected
Dec 28 09:03:51 D-69-91-141-110 kernel: usb 1-4: new high-speed USB device number 2 using ehci-pci
Dec 28 09:03:51 D-69-91-141-110 kernel: ata1: softreset failed (device not ready)
Dec 28 09:03:51 D-69-91-141-110 kernel: ata1: applying PMP SRST workaround and retrying
Dec 28 09:03:51 D-69-91-141-110 kernel: usb 1-4: New USB device found, idVendor=0bda, idProduct=0116
Dec 28 09:03:51 D-69-91-141-110 kernel: usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
Dec 28 09:03:51 D-69-91-141-110 kernel: usb 1-4: Product: USB2.0-CRW
Dec 28 09:03:51 D-69-91-141-110 kernel: usb 1-4: Manufacturer: Generic
Dec 28 09:03:51 D-69-91-141-110 kernel: usb 1-4: SerialNumber: 20021111153705700
Dec 28 09:03:51 D-69-91-141-110 kernel: usb-storage 1-4:1.0: USB Mass Storage device detected
Dec 28 09:03:51 D-69-91-141-110 kernel: scsi host6: usb-storage 1-4:1.0
Dec 28 09:03:51 D-69-91-141-110 kernel: usbcore: registered new interface driver usb-storage
Dec 28 09:03:51 D-69-91-141-110 kernel: usbcore: registered new interface driver uas
Dec 28 09:03:51 D-69-91-141-110 kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Dec 28 09:03:51 D-69-91-141-110 kernel: ata1.00: ATA-8: ST9250827AS, 3.AAA, max UDMA/133
Dec 28 09:03:51 D-69-91-141-110 kernel: ata1.00: 488397168 sectors, multi 16: LBA48 NCQ (depth 31/32)
Dec 28 09:03:51 D-69-91-141-110 kernel: ata1.00: SB600 AHCI: limiting to 255 sectors per cmd
Dec 28 09:03:51 D-69-91-141-110 kernel: ata1.00: SB600 AHCI: limiting to 255 sectors per cmd
Dec 28 09:03:51 D-69-91-141-110 kernel: ata1.00: configured for UDMA/133
Dec 28 09:03:51 D-69-91-141-110 kernel: scsi 0:0:0:0: Direct-Access     ATA      ST9250827AS      A    PQ: 0 ANSI: 5
Dec 28 09:03:51 D-69-91-141-110 kernel: scsi 4:0:0:0: CD-ROM            HL-DT-ST DVDRAM GSA-T40N  JR03 PQ: 0 ANSI: 5
Dec 28 09:03:51 D-69-91-141-110 kernel: usb 1-7: new high-speed USB device number 3 using ehci-pci
Dec 28 09:03:51 D-69-91-141-110 kernel: sd 0:0:0:0: [sda] 488397168 512-byte logical blocks: (250 GB/233 GiB)
Dec 28 09:03:51 D-69-91-141-110 kernel: sd 0:0:0:0: [sda] Write Protect is off
Dec 28 09:03:51 D-69-91-141-110 kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Dec 28 09:03:51 D-69-91-141-110 kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Dec 28 09:03:51 D-69-91-141-110 kernel: sr 4:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
Dec 28 09:03:51 D-69-91-141-110 kernel: cdrom: Uniform CD-ROM driver Revision: 3.20
Dec 28 09:03:51 D-69-91-141-110 kernel: sr 4:0:0:0: Attached scsi CD-ROM sr0
Dec 28 09:03:51 D-69-91-141-110 kernel:  sda: sda1 sda2 < sda5 >
Dec 28 09:03:51 D-69-91-141-110 kernel: sd 0:0:0:0: [sda] Attached SCSI disk
Dec 28 09:03:51 D-69-91-141-110 kernel: usb 1-7: New USB device found, idVendor=174f, idProduct=5a31
Dec 28 09:03:51 D-69-91-141-110 kernel: usb 1-7: New USB device strings: Mfr=2, Product=1, SerialNumber=3
Dec 28 09:03:51 D-69-91-141-110 kernel: usb 1-7: Product: USB 2.0 Camera
Dec 28 09:03:51 D-69-91-141-110 kernel: usb 1-7: Manufacturer: Sonix Technology Co., Ltd.
Dec 28 09:03:51 D-69-91-141-110 kernel: usb 1-7: SerialNumber: SN0001
Dec 28 09:03:51 D-69-91-141-110 kernel: psmouse serio4: synaptics: Touchpad model: 1, fw: 6.1, id: 0xa3a0b3, caps: 0xa04713/0x10008/0x0/0x0, board id: 0, fw id: 30712
Dec 28 09:03:51 D-69-91-141-110 kernel: input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio4/input/input8
Dec 28 09:03:51 D-69-91-141-110 kernel: PM: Starting manual resume from disk
Dec 28 09:03:51 D-69-91-141-110 kernel: PM: Image not found (code -22)
Dec 28 09:03:51 D-69-91-141-110 kernel: scsi 6:0:0:0: Direct-Access     Generic- xD/SDMMC/MS/Pro  1.00 PQ: 0 ANSI: 0 CCS
Dec 28 09:03:51 D-69-91-141-110 kernel: sd 6:0:0:0: [sdb] 62333952 512-byte logical blocks: (31.9 GB/29.7 GiB)
Dec 28 09:03:51 D-69-91-141-110 kernel: sd 6:0:0:0: [sdb] Write Protect is off
Dec 28 09:03:51 D-69-91-141-110 kernel: sd 6:0:0:0: [sdb] Mode Sense: 03 00 00 00
Dec 28 09:03:51 D-69-91-141-110 kernel: sd 6:0:0:0: [sdb] No Caching mode page found
Dec 28 09:03:51 D-69-91-141-110 kernel: sd 6:0:0:0: [sdb] Assuming drive cache: write through
Dec 28 09:03:51 D-69-91-141-110 kernel:  sdb: sdb1
Dec 28 09:03:51 D-69-91-141-110 kernel: sd 6:0:0:0: [sdb] Attached SCSI removable disk
Dec 28 09:03:51 D-69-91-141-110 kernel: EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
Dec 28 09:03:51 D-69-91-141-110 kernel: random: crng init done
Dec 28 09:03:51 D-69-91-141-110 kernel: ip_tables: (C) 2000-2006 Netfilter Core Team
Dec 28 09:03:51 D-69-91-141-110 systemd[1]: systemd 232 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
Dec 28 09:03:51 D-69-91-141-110 systemd[1]: Detected architecture x86.
Dec 28 09:03:51 D-69-91-141-110 systemd[1]: Set hostname to <D-69-91-141-110>.
Dec 28 09:03:51 D-69-91-141-110 systemd[1]: Configuration file /etc/systemd/system/kdump.service is marked executable. Please remove executable permission bits. Proceeding anyway.
Dec 28 09:03:51 D-69-91-141-110 systemd[1]: Listening on udev Control Socket.
Dec 28 09:03:51 D-69-91-141-110 systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
Dec 28 09:03:51 D-69-91-141-110 systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
Dec 28 09:03:51 D-69-91-141-110 systemd[1]: Created slice System Slice.
Dec 28 09:03:51 D-69-91-141-110 systemd[1]: Mounting Huge Pages File System...
Dec 28 09:03:51 D-69-91-141-110 systemd[1]: Mounting Debug File System...
Dec 28 09:03:51 D-69-91-141-110 kernel: EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
Dec 28 09:03:51 D-69-91-141-110 systemd-journald[189]: Journal started
Dec 28 09:03:51 D-69-91-141-110 systemd-journald[189]: Runtime journal (/run/log/journal/232ecae4e62643e0ac09bafad7167a6f) is 3.3M, max 26.5M, 23.1M free.
Dec 28 09:03:51 D-69-91-141-110 systemd[1]: Starting Flush Journal to Persistent Storage...
Dec 28 09:03:52 D-69-91-141-110 systemd[1]: Started Create list of required static device nodes for the current kernel.
Dec 28 09:03:52 D-69-91-141-110 systemd[1]: Starting Create Static Device Nodes in /dev...
Dec 28 09:03:52 D-69-91-141-110 systemd[1]: Started Load/Save Random Seed.
Dec 28 09:03:52 D-69-91-141-110 systemd[1]: Started Apply Kernel Variables.
Dec 28 09:03:52 D-69-91-141-110 systemd[1]: Started udev Coldplug all Devices.
Dec 28 09:03:52 D-69-91-141-110 systemd-journald[189]: Time spent on flushing to /var is 30.426ms for 793 entries.

--XsQoSWH+UP9D9v3l--
