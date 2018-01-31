Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:38482 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751435AbeAaIXa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Jan 2018 03:23:30 -0500
Received: from mail-pf0-f198.google.com ([209.85.192.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1egng0-0004Ps-6e
        for linux-pci@vger.kernel.org; Wed, 31 Jan 2018 08:23:28 +0000
Received: by mail-pf0-f198.google.com with SMTP id b75so13844626pfk.22
        for <linux-pci@vger.kernel.org>; Wed, 31 Jan 2018 00:23:28 -0800 (PST)
From: Kai Heng Feng <kai.heng.feng@canonical.com>
Message-Id: <4D112585-48B0-4D6D-9176-A9768FD5AC7A@canonical.com>
Content-Type: multipart/mixed;
        boundary="Apple-Mail=_8295673B-FB6E-43DE-AFE1-DCF7415117AD"
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: Thunderbolt PCIe card doesn't get enumerated at cold boot
Date: Wed, 31 Jan 2018 16:23:21 +0800
In-Reply-To: <20180131075347.GR27654@lahna.fi.intel.com>
Cc: linux-pci@vger.kernel.org, Ethan Hsieh <ethan.hsieh@canonical.com>,
        thunderbolt-software@lists.01.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
References: <8831781F-8027-4875-AF82-835FBE40F5F0@canonical.com>
 <20180130102319.GE27654@lahna.fi.intel.com>
 <C4051028-A6AD-4B78-97E2-AE1BC34694EB@canonical.com>
 <20180130103745.GG27654@lahna.fi.intel.com>
 <A4805FBC-E94C-4EA6-9DC3-290FE3BB43E9@canonical.com>
 <20180131075347.GR27654@lahna.fi.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--Apple-Mail=_8295673B-FB6E-43DE-AFE1-DCF7415117AD
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


Kai-Heng

> On 31 Jan 2018, at 3:53 PM, Mika Westerberg =
<mika.westerberg@linux.intel.com> wrote:
>=20
> On Wed, Jan 31, 2018 at 03:37:32PM +0800, Kai Heng Feng wrote:
>>=20
>>> On 30 Jan 2018, at 6:37 PM, Mika Westerberg =
<mika.westerberg@intel.com> wrote:
>>>>=20
>>>> Yes it is. It=E2=80=99s a PCIe add-in-card. It is Alpine Ridge.
>>>>=20
>>>> Wondering if TBT requires special support from PCH or ACPI?
>>>> I am asking this because the very same card can=E2=80=99t get =
detected on a Ryzen
>>>> platform.
>>>=20
>>> Yes, it needs to have BIOS support and in addition you need to have
>>> those side band signals connected properly. BIOS support is needed =
for
>>> ACPI hotplug.
>>=20
>> Sounds like there are two different kind of supports:
>> - Basic TBT support.
>> - ACPI hotplug support in addition to basic support.
>=20
> I think those ACPI methods should be part of the basic support.
>=20
>> What do I need to check if the motherboard fully support them?
>> I guess there are special ACPI methods for them?
>=20
> I would start by installing Windows + TBT driver and see if it works. =
If
> it does, then we need to figure out what we do differently in Linux. =
If
> it does not, then there is something missing from the BIOS/HW side.

Thanks. I=E2=80=99ll see if Windows works here.

>=20
>>> Unless it is in native PCIe hotplug mode but even then you need to =
have
>>> BIOS support.
>>=20
>> How do I check this for the TBT add-in-card?
>=20
> When it is in native mode, you can see from dmesg that the BIOS has
> enabled native PCIe hotplug when _OSI method is called. If you can't
> find it, you can send me the dmesg and I'll check it.

Now sure which string to grep, but looks like hotplug is supported.
Still attach dmesg to let you confirm it=E2=80=99s working.

Kai-Heng

--Apple-Mail=_8295673B-FB6E-43DE-AFE1-DCF7415117AD
Content-Disposition: attachment;
	filename=dmesg
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="dmesg"
Content-Transfer-Encoding: 7bit

[    0.000000] Linux version 4.15.0-041500rc9-generic (kernel@tangerine) (gcc version 7.2.0 (Ubuntu 7.2.0-8ubuntu3)) #201801212130 SMP Mon Jan 22 02:31:37 UTC 2018
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.15.0-041500rc9-generic root=UUID=f37cd625-3317-4753-ad72-c8642fa7418e ro quiet splash systemd.debug-shell vt.handoff=7
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000064732fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000064733000-0x0000000064733fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000064734000-0x0000000064734fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000064735000-0x000000007821dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000007821e000-0x000000007b046fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007b047000-0x000000007b0c3fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000007b0c4000-0x000000007b5bdfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007b5be000-0x000000007bbe7fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007bbe8000-0x000000007bcfefff] type 20
[    0.000000] BIOS-e820: [mem 0x000000007bcff000-0x000000007bcfffff] usable
[    0.000000] BIOS-e820: [mem 0x000000007bd00000-0x000000007fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f0000000-0x00000000f7ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000107bffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.60 by American Megatrends
[    0.000000] efi:  ACPI 2.0=0x7b060000  ACPI=0x7b060000  SMBIOS=0xf0000  SMBIOS 3.0=0xf0020  ESRT=0x7b9bd118  MEMATTR=0x76414018 
[    0.000000] random: fast init done
[    0.000000] SMBIOS 3.1.1 present.
[    0.000000] DMI: Dell Inc. Precision 3630/      , BIOS 0.1.5 01/16/2018
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x107c000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: write-back
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0080000000 mask 7F80000000 uncachable
[    0.000000]   1 base 007E000000 mask 7FFE000000 uncachable
[    0.000000]   2 base 007D800000 mask 7FFF800000 uncachable
[    0.000000]   3 base 4000000000 mask 6000000000 write-combining
[    0.000000]   4 base 6000000000 mask 6000000000 uncachable
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000000] e820: last_pfn = 0x7bd00 max_arch_pfn = 0x400000000
[    0.000000] esrt: Reserving ESRT space from 0x000000007b9bd118 to 0x000000007b9bd150.
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [        (ptrval)] 99000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x3dcd3a000, 0x3dcd3afff] PGTABLE
[    0.000000] BRK [0x3dcd3b000, 0x3dcd3bfff] PGTABLE
[    0.000000] BRK [0x3dcd3c000, 0x3dcd3cfff] PGTABLE
[    0.000000] BRK [0x3dcd3d000, 0x3dcd3dfff] PGTABLE
[    0.000000] BRK [0x3dcd3e000, 0x3dcd3efff] PGTABLE
[    0.000000] BRK [0x3dcd3f000, 0x3dcd3ffff] PGTABLE
[    0.000000] BRK [0x3dcd40000, 0x3dcd40fff] PGTABLE
[    0.000000] BRK [0x3dcd41000, 0x3dcd41fff] PGTABLE
[    0.000000] BRK [0x3dcd42000, 0x3dcd42fff] PGTABLE
[    0.000000] BRK [0x3dcd43000, 0x3dcd43fff] PGTABLE
[    0.000000] Secure boot could not be determined
[    0.000000] RAMDISK: [mem 0x31bb6000-0x34dd2fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x000000007B060000 000024 (v02 DELL  )
[    0.000000] ACPI: XSDT 0x000000007B0600A8 0000D4 (v01 DELL   CBX3     01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x000000007B0A2718 000114 (v06 DELL   CBX3     01072009 AMI  00010013)
[    0.000000] ACPI: DSDT 0x000000007B060210 042503 (v02 DELL   CBX3     01072009 INTL 20160527)
[    0.000000] ACPI: FACS 0x000000007B5BCF80 000040
[    0.000000] ACPI: APIC 0x000000007B0A2830 0000F4 (v04 DELL   CBX3     01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 0x000000007B0A2928 000044 (v01 DELL   CBX3     01072009 AMI  00010013)
[    0.000000] ACPI: FIDT 0x000000007B0A2970 00009C (v01 DELL   CBX3     01072009 AMI  00010013)
[    0.000000] ACPI: MCFG 0x000000007B0A2A10 00003C (v01 DELL   CBX3     01072009 MSFT 00000097)
[    0.000000] ACPI: SSDT 0x000000007B0A2A50 0017CB (v02 CpuRef CpuSsdt  00003000 INTL 20160527)
[    0.000000] ACPI: SSDT 0x000000007B0A4220 0033D4 (v02 SaSsdt SaSsdt   00003000 INTL 20160527)
[    0.000000] ACPI: HPET 0x000000007B0A75F8 000038 (v01 INTEL  CBX3     00000002      01000013)
[    0.000000] ACPI: SSDT 0x000000007B0A7630 000FC3 (v02 INTEL  Ther_Rvp 00001000 INTL 20160527)
[    0.000000] ACPI: SSDT 0x000000007B0A85F8 000AFE (v02 INTEL  DELL_TB  00000000 INTL 20160527)
[    0.000000] ACPI: UEFI 0x000000007B0A90F8 000042 (v01 DELL\x CBX3     00000002      01000013)
[    0.000000] ACPI: LPIT 0x000000007B0A9140 00005C (v01 INTEL  CBX3     00000002      01000013)
[    0.000000] ACPI: SSDT 0x000000007B0A91A0 0027DE (v02 INTEL  PtidDevc 00001000 INTL 20160527)
[    0.000000] ACPI: SSDT 0x000000007B0AB980 000FFE (v02 INTEL  TbtTypeC 00000000 INTL 20160527)
[    0.000000] ACPI: DBGP 0x000000007B0AC980 000034 (v01 DELL\x CBX3     00000002      01000013)
[    0.000000] ACPI: DBG2 0x000000007B0AC9B8 000054 (v00 DELL\x CBX3     00000002      01000013)
[    0.000000] ACPI: SSDT 0x000000007B0ACA10 0019C4 (v02 DELL\x UsbCTabl 00001000 INTL 20160527)
[    0.000000] ACPI: SLIC 0x000000007B0AE3D8 000176 (v03 DELL   CBX3     01072009 MSFT 00010013)
[    0.000000] ACPI: DMAR 0x000000007B0AE550 0000CC (v01 INTEL  EDK2     00000002      01000013)
[    0.000000] ACPI: BGRT 0x000000007B0AE620 000038 (v00                 01072009 AMI  00010013)
[    0.000000] ACPI: TPM2 0x000000007B0AE658 000034 (v03 DELL\x CBX3     00000001 AMI  00000000)
[    0.000000] ACPI: ASF! 0x000000007B0AE690 000074 (v32 DELL\x CBX3     00000002      01000013)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000107bffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x107bfd5000-0x107bffffff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000107bffffff]
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x0000000064732fff]
[    0.000000]   node   0: [mem 0x0000000064735000-0x000000007821dfff]
[    0.000000]   node   0: [mem 0x000000007bcff000-0x000000007bcfffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000107bffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000107bffffff]
[    0.000000] On node 0 totalpages: 16728507
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 23 pages reserved
[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 7625 pages used for memmap
[    0.000000]   DMA32 zone: 487965 pages, LIFO batch:31
[    0.000000]   Normal zone: 253696 pages used for memmap
[    0.000000]   Normal zone: 16236544 pages, LIFO batch:31
[    0.000000] Reserved but unavailable: 99 pages
[    0.000000] ACPI: PM-Timer IO Port: 0x1808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 12 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x64733000-0x64733fff]
[    0.000000] PM: Registered nosave memory: [mem 0x64734000-0x64734fff]
[    0.000000] PM: Registered nosave memory: [mem 0x7821e000-0x7b046fff]
[    0.000000] PM: Registered nosave memory: [mem 0x7b047000-0x7b0c3fff]
[    0.000000] PM: Registered nosave memory: [mem 0x7b0c4000-0x7b5bdfff]
[    0.000000] PM: Registered nosave memory: [mem 0x7b5be000-0x7bbe7fff]
[    0.000000] PM: Registered nosave memory: [mem 0x7bbe8000-0x7bcfefff]
[    0.000000] PM: Registered nosave memory: [mem 0x7bd00000-0x7fffffff]
[    0.000000] PM: Registered nosave memory: [mem 0x80000000-0xefffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf0000000-0xf7ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf8000000-0xfdffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfe000000-0xfe010fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfe011000-0xfebfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec01000-0xfedfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.000000] e820: [mem 0x80000000-0xefffffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:12 nr_cpu_ids:12 nr_node_ids:1
[    0.000000] percpu: Embedded 46 pages/cpu @        (ptrval) s151552 r8192 d28672 u262144
[    0.000000] pcpu-alloc: s151552 r8192 d28672 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 -- -- -- -- 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 16467099
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.15.0-041500rc9-generic root=UUID=f37cd625-3317-4753-ad72-c8642fa7418e ro quiet splash systemd.debug-shell vt.handoff=7
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 65677320K/66914028K available (12300K kernel code, 2469K rwdata, 4192K rodata, 2388K init, 2416K bss, 1236708K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=12, Nodes=1
[    0.000000] Kernel/User page tables isolation: enabled
[    0.000000] ftrace: allocating 39020 entries in 153 pages
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=12.
[    0.000000] 	Tasks RCU enabled.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=12
[    0.000000] NR_IRQS: 524544, nr_irqs: 2152, preallocated irqs: 16
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] ACPI: Core revision 20170831
[    0.000000] ACPI Warning: Unsupported module-level executable opcode 0x70 at table offset 0x33F54 (20170831/psloop-247)
[    0.000000] ACPI Warning: Unsupported module-level executable opcode 0x70 at table offset 0x33F5D (20170831/psloop-247)
[    0.000000] ACPI Warning: Unsupported module-level executable opcode 0x70 at table offset 0x34648 (20170831/psloop-247)
[    0.000000] ACPI Warning: Unsupported module-level executable opcode 0x70 at table offset 0x34651 (20170831/psloop-247)
[    0.000000] ACPI Warning: Unsupported module-level executable opcode 0x70 at table offset 0x34D3C (20170831/psloop-247)
[    0.000000] ACPI Warning: Unsupported module-level executable opcode 0x70 at table offset 0x34D45 (20170831/psloop-247)
[    0.000000] ACPI Warning: Unsupported module-level executable opcode 0x70 at table offset 0x35431 (20170831/psloop-247)
[    0.000000] ACPI Warning: Unsupported module-level executable opcode 0x70 at table offset 0x3543A (20170831/psloop-247)
[    0.000000] ACPI Warning: Unsupported module-level executable opcode 0x70 at table offset 0x35B25 (20170831/psloop-247)
[    0.000000] ACPI Warning: Unsupported module-level executable opcode 0x70 at table offset 0x35B2E (20170831/psloop-247)
[    0.000000] ACPI Warning: Unsupported module-level executable opcode 0x70 at table offset 0x35B51 (20170831/psloop-247)
[    0.000000] ACPI Warning: Unsupported module-level executable opcode 0x70 at table offset 0x35B5A (20170831/psloop-247)
[    0.000000] ACPI: 8 ACPI AML tables successfully acquired and loaded
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
[    0.000000] hpet clockevent registered
[    0.004000] APIC: Switch to symmetric I/O mode setup
[    0.004000] DMAR: Host address width 39
[    0.004000] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.004000] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 19e2ff0505e
[    0.004000] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.004000] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
[    0.004000] DMAR: RMRR base: 0x00000078f7c000 end: 0x00000078f9bfff
[    0.004000] DMAR: RMRR base: 0x0000007d800000 end: 0x0000007fffffff
[    0.004000] DMAR: ANDD device: 1 name: \_SB.PCI0.I2C0
[    0.004000] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.004000] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.004000] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.004000] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.004000] x2apic enabled
[    0.004000] Switched APIC routing to cluster x2apic.
[    0.016000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.036000] tsc: Detected 3200.000 MHz processor
[    0.036000] tsc: Detected 3192.000 MHz TSC
[    0.036000] Calibrating delay loop (skipped), value calculated using timer frequency.. 6384.00 BogoMIPS (lpj=12768000)
[    0.036000] pid_max: default: 32768 minimum: 301
[    0.036000] Security Framework initialized
[    0.036000] Yama: becoming mindful.
[    0.036000] AppArmor: AppArmor initialized
[    0.043045] Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes)
[    0.046094] Inode-cache hash table entries: 4194304 (order: 13, 33554432 bytes)
[    0.046203] Mount-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.046298] Mountpoint-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.046441] CPU: Physical Processor ID: 0
[    0.046441] CPU: Processor Core ID: 0
[    0.046445] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.046445] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.046449] mce: CPU supports 12 MCE banks
[    0.046457] CPU0: Thermal monitoring enabled (TM1)
[    0.046476] process: using mwait in idle threads
[    0.046478] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.046478] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.046479] Spectre V2 mitigation: Vulnerable: Minimal generic ASM retpoline
[    0.046480] Spectre V2 mitigation: Filling RSB on context switch
[    0.046797] Freeing SMP alternatives memory: 36K
[    0.048462] TSC deadline timer enabled
[    0.048468] smpboot: CPU0: Genuine Intel(R) CPU 0000 @ 3.20GHz (family: 0x6, model: 0x9e, stepping: 0xa)
[    0.048511] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.048534] ... version:                4
[    0.048534] ... bit width:              48
[    0.048534] ... generic registers:      4
[    0.048535] ... value mask:             0000ffffffffffff
[    0.048535] ... max period:             00007fffffffffff
[    0.048536] ... fixed-purpose events:   3
[    0.048536] ... event mask:             000000070000000f
[    0.048563] Hierarchical SRCU implementation.
[    0.049656] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.049664] smp: Bringing up secondary CPUs ...
[    0.049711] x86: Booting SMP configuration:
[    0.049712] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11
[    0.052500] smp: Brought up 1 node, 12 CPUs
[    0.052500] smpboot: Max logical packages: 1
[    0.052500] smpboot: Total of 12 processors activated (76608.00 BogoMIPS)
[    0.057125] devtmpfs: initialized
[    0.057125] x86/mm: Memory block size: 2048MB
[    0.057125] evm: security.selinux
[    0.057125] evm: security.SMACK64
[    0.057125] evm: security.SMACK64EXEC
[    0.057125] evm: security.SMACK64TRANSMUTE
[    0.057125] evm: security.SMACK64MMAP
[    0.057125] evm: security.apparmor
[    0.057125] evm: security.ima
[    0.057125] evm: security.capability
[    0.057125] PM: Registering ACPI NVS region [mem 0x64733000-0x64733fff] (4096 bytes)
[    0.057125] PM: Registering ACPI NVS region [mem 0x7b0c4000-0x7b5bdfff] (5218304 bytes)
[    0.057125] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.057125] futex hash table entries: 4096 (order: 6, 262144 bytes)
[    0.057125] pinctrl core: initialized pinctrl subsystem
[    0.057125] RTC time:  8:18:49, date: 01/31/18
[    0.057249] NET: Registered protocol family 16
[    0.057320] audit: initializing netlink subsys (disabled)
[    0.057324] audit: type=2000 audit(1517386729.056:1): state=initialized audit_enabled=0 res=1
[    0.057324] cpuidle: using governor ladder
[    0.057324] cpuidle: using governor menu
[    0.057324] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.057324] ACPI: bus type PCI registered
[    0.057324] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.057324] PCI: MMCONFIG for domain 0000 [bus 00-7f] at [mem 0xf0000000-0xf7ffffff] (base 0xf0000000)
[    0.057324] PCI: MMCONFIG at [mem 0xf0000000-0xf7ffffff] reserved in E820
[    0.057324] PCI: Using configuration type 1 for base access
[    0.060161] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.060161] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.060162] ACPI: Added _OSI(Module Device)
[    0.060162] ACPI: Added _OSI(Processor Device)
[    0.060162] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.060162] ACPI: Added _OSI(Processor Aggregator Device)
[    0.069209] ACPI: Executed 46 blocks of module-level executable AML code
[    0.151050] ACPI: Dynamic OEM Table Load:
[    0.151050] ACPI: SSDT 0xFFFF9403B4314000 000708 (v02 PmRef  Cpu0Ist  00003000 INTL 20160527)
[    0.151050] ACPI: Executed 1 blocks of module-level executable AML code
[    0.151050] ACPI: \_SB_.PR00: _OSC native thermal LVT Acked
[    0.151050] ACPI: Dynamic OEM Table Load:
[    0.151050] ACPI: SSDT 0xFFFF9403B39AD000 000386 (v02 PmRef  Cpu0Cst  00003001 INTL 20160527)
[    0.151050] ACPI: Executed 1 blocks of module-level executable AML code
[    0.151050] ACPI: Dynamic OEM Table Load:
[    0.151050] ACPI: SSDT 0xFFFF9403B38F7C00 00010A (v02 PmRef  Cpu0Hwp  00003000 INTL 20160527)
[    0.151050] ACPI: Executed 1 blocks of module-level executable AML code
[    0.151050] ACPI: Dynamic OEM Table Load:
[    0.151050] ACPI: SSDT 0xFFFF9403B4376000 000724 (v02 PmRef  HwpLvt   00003000 INTL 20160527)
[    0.151050] ACPI: Executed 1 blocks of module-level executable AML code
[    0.152446] ACPI: Dynamic OEM Table Load:
[    0.152452] ACPI: SSDT 0xFFFF9403B3829000 000EF1 (v02 PmRef  ApIst    00003000 INTL 20160527)
[    0.153338] ACPI: Executed 1 blocks of module-level executable AML code
[    0.153349] ACPI: Dynamic OEM Table Load:
[    0.153349] ACPI: SSDT 0xFFFF9403B38EC800 000317 (v02 PmRef  ApHwp    00003000 INTL 20160527)
[    0.153349] ACPI: Executed 1 blocks of module-level executable AML code
[    0.153349] ACPI: Dynamic OEM Table Load:
[    0.153349] ACPI: SSDT 0xFFFF9403B38ED400 00030A (v02 PmRef  ApCst    00003000 INTL 20160527)
[    0.153349] ACPI: Executed 1 blocks of module-level executable AML code
[    0.157857] ACPI: Interpreter enabled
[    0.157892] ACPI: (supports S0 S3 S4 S5)
[    0.157893] ACPI: Using IOAPIC for interrupt routing
[    0.157928] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.159145] ACPI: GPE 0x20 active on init
[    0.160001] ACPI: GPE 0x61 active on init
[    0.160027] ACPI Error: No handler for Region [RCH2] (0000000009de8c54) [GenericSerialBus] (20170831/evregion-166)
[    0.160033] ACPI Error: Region GenericSerialBus (ID=9) has no handler (20170831/exfldio-299)
[    0.160039] 
               Initialized Local Variables for Method [PAS1]:
[    0.160040]   Local0: 0000000065a0e1c2 <Obj>           Integer 0000000000000001
[    0.160043] No Arguments are initialized for method [PAS1]
[    0.160044] ACPI Error: Method parse/execution failed \_SB.PCI0.I2C0.PAS1, AE_NOT_EXIST (20170831/psparse-550)
[    0.160050] ACPI Error: Method parse/execution failed \_GPE._L20, AE_NOT_EXIST (20170831/psparse-550)
[    0.160056] ACPI Exception: AE_NOT_EXIST, while evaluating GPE method [_L20] (20170831/evgpe-646)
[    0.160001] ACPI: Enabled 9 GPEs in block 00 to 7F
[    0.165328] ACPI: Power Resource [WRST] (on)
[    0.165387] ACPI: Power Resource [DRST] (on)
[    0.175428] ACPI: Power Resource [USBC] (on)
[    0.178455] ACPI: Power Resource [V0PR] (on)
[    0.178648] ACPI: Power Resource [V1PR] (on)
[    0.178835] ACPI: Power Resource [V2PR] (on)
[    0.190245] ACPI: Power Resource [WRST] (on)
[    0.195529] ACPI: Power Resource [FN00] (off)
[    0.195616] ACPI: Power Resource [FN01] (off)
[    0.195700] ACPI: Power Resource [FN02] (off)
[    0.195783] ACPI: Power Resource [FN03] (off)
[    0.195866] ACPI: Power Resource [FN04] (off)
[    0.196541] ACPI: Power Resource [PIN] (off)
[    0.197021] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7e])
[    0.197025] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.197222] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug PME AER]
[    0.197408] acpi PNP0A08:00: _OSC: OS now controls [PCIeCapability]
[    0.197408] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    0.198324] PCI host bridge to bus 0000:00
[    0.198326] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.198327] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.198328] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.198328] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000c3fff window]
[    0.198329] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7fff window]
[    0.198329] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000cbfff window]
[    0.198330] pci_bus 0000:00: root bus resource [mem 0x000cc000-0x000cffff window]
[    0.198331] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3fff window]
[    0.198331] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff window]
[    0.198332] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff window]
[    0.198333] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff window]
[    0.198333] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7fff window]
[    0.198334] pci_bus 0000:00: root bus resource [mem 0x000e8000-0x000ebfff window]
[    0.198334] pci_bus 0000:00: root bus resource [mem 0x000ec000-0x000effff window]
[    0.198335] pci_bus 0000:00: root bus resource [mem 0x80000000-0xefffffff window]
[    0.198336] pci_bus 0000:00: root bus resource [mem 0x4000000000-0x7fffffffff window]
[    0.198337] pci_bus 0000:00: root bus resource [mem 0xfc800000-0xfe7fffff window]
[    0.198337] pci_bus 0000:00: root bus resource [bus 00-7e]
[    0.198343] pci 0000:00:00.0: [8086:3ec2] type 00 class 0x060000
[    0.198694] pci 0000:00:02.0: [8086:3e92] type 00 class 0x030000
[    0.198702] pci 0000:00:02.0: reg 0x10: [mem 0x604a000000-0x604affffff 64bit]
[    0.198706] pci 0000:00:02.0: reg 0x18: [mem 0x4000000000-0x400fffffff 64bit pref]
[    0.198709] pci 0000:00:02.0: reg 0x20: [io  0x3000-0x303f]
[    0.198893] pci 0000:00:08.0: [8086:1911] type 00 class 0x088000
[    0.198902] pci 0000:00:08.0: reg 0x10: [mem 0x604b11a000-0x604b11afff 64bit]
[    0.199114] pci 0000:00:12.0: [8086:a379] type 00 class 0x118000
[    0.199146] pci 0000:00:12.0: reg 0x10: [mem 0x604b119000-0x604b119fff 64bit]
[    0.199410] pci 0000:00:14.0: [8086:a36d] type 00 class 0x0c0330
[    0.199441] pci 0000:00:14.0: reg 0x10: [mem 0x604b100000-0x604b10ffff 64bit]
[    0.199543] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.199721] pci 0000:00:14.2: [8086:a36f] type 00 class 0x050000
[    0.199747] pci 0000:00:14.2: reg 0x10: [mem 0x604b114000-0x604b115fff 64bit]
[    0.199761] pci 0000:00:14.2: reg 0x18: [mem 0x604b118000-0x604b118fff 64bit]
[    0.204191] pci 0000:00:15.0: [8086:a368] type 00 class 0x0c8000
[    0.204847] pci 0000:00:15.0: reg 0x10: [mem 0x604b117000-0x604b117fff 64bit]
[    0.206971] pci 0000:00:16.0: [8086:a360] type 00 class 0x078000
[    0.207001] pci 0000:00:16.0: reg 0x10: [mem 0x604b116000-0x604b116fff 64bit]
[    0.207089] pci 0000:00:16.0: PME# supported from D3hot
[    0.207284] pci 0000:00:16.3: [8086:a363] type 00 class 0x070002
[    0.207307] pci 0000:00:16.3: reg 0x10: [io  0x3080-0x3087]
[    0.207315] pci 0000:00:16.3: reg 0x14: [mem 0xae324000-0xae324fff]
[    0.207540] pci 0000:00:17.0: [8086:a352] type 00 class 0x010601
[    0.207568] pci 0000:00:17.0: reg 0x10: [mem 0xae320000-0xae321fff]
[    0.207579] pci 0000:00:17.0: reg 0x14: [mem 0xae323000-0xae3230ff]
[    0.207589] pci 0000:00:17.0: reg 0x18: [io  0x3070-0x3077]
[    0.207600] pci 0000:00:17.0: reg 0x1c: [io  0x3060-0x3063]
[    0.207611] pci 0000:00:17.0: reg 0x20: [io  0x3040-0x305f]
[    0.207622] pci 0000:00:17.0: reg 0x24: [mem 0xae322000-0xae3227ff]
[    0.207682] pci 0000:00:17.0: PME# supported from D3hot
[    0.207900] pci 0000:00:1b.0: [8086:a340] type 01 class 0x060400
[    0.208035] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.208066] pci 0000:00:1b.0: PTM enabled (root), 4dns granularity
[    0.208274] pci 0000:00:1b.4: [8086:a32c] type 01 class 0x060400
[    0.208403] pci 0000:00:1b.4: PME# supported from D0 D3hot D3cold
[    0.208430] pci 0000:00:1b.4: PTM enabled (root), 4dns granularity
[    0.208635] pci 0000:00:1c.0: [8086:a338] type 01 class 0x060400
[    0.208750] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.208955] pci 0000:00:1c.4: [8086:a33c] type 01 class 0x060400
[    0.209091] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.209120] pci 0000:00:1c.4: PTM enabled (root), 4dns granularity
[    0.209324] pci 0000:00:1d.0: [8086:a330] type 01 class 0x060400
[    0.209439] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.209630] pci 0000:00:1d.2: [8086:a332] type 01 class 0x060400
[    0.209765] pci 0000:00:1d.2: PME# supported from D0 D3hot D3cold
[    0.209798] pci 0000:00:1d.2: PTM enabled (root), 4dns granularity
[    0.210020] pci 0000:00:1f.0: [8086:a309] type 00 class 0x060100
[    0.210417] pci 0000:00:1f.3: [8086:a348] type 00 class 0x040300
[    0.210485] pci 0000:00:1f.3: reg 0x10: [mem 0x604b110000-0x604b113fff 64bit]
[    0.210549] pci 0000:00:1f.3: reg 0x20: [mem 0x604b000000-0x604b0fffff 64bit]
[    0.210688] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.210951] pci 0000:00:1f.4: [8086:a323] type 00 class 0x0c0500
[    0.211009] pci 0000:00:1f.4: reg 0x10: [mem 0x00000000-0x000000ff 64bit]
[    0.211082] pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
[    0.211290] pci 0000:00:1f.5: [8086:a324] type 00 class 0x0c8000
[    0.211310] pci 0000:00:1f.5: reg 0x10: [mem 0xfe010000-0xfe010fff]
[    0.211496] pci 0000:00:1f.6: [8086:15bb] type 00 class 0x020000
[    0.211553] pci 0000:00:1f.6: reg 0x10: [mem 0xae300000-0xae31ffff]
[    0.211789] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
[    0.212087] pci 0000:01:00.0: [144d:a804] type 00 class 0x010802
[    0.212127] pci 0000:01:00.0: reg 0x10: [mem 0xae200000-0xae203fff 64bit]
[    0.224063] pci 0000:00:1b.0: PCI bridge to [bus 01]
[    0.224070] pci 0000:00:1b.0:   bridge window [mem 0xae200000-0xae2fffff]
[    0.224216] pci 0000:00:1b.4: PCI bridge to [bus 02-6c]
[    0.224222] pci 0000:00:1b.4:   bridge window [mem 0x80000000-0xae0fffff]
[    0.224229] pci 0000:00:1b.4:   bridge window [mem 0x6000000000-0x6049ffffff 64bit pref]
[    0.224367] acpiphp: Slot [1] registered
[    0.224377] pci 0000:00:1c.0: PCI bridge to [bus 6d]
[    0.224559] pci 0000:6e:00.0: [8086:2526] type 00 class 0x028000
[    0.224592] pci 0000:6e:00.0: reg 0x10: [mem 0xae100000-0xae103fff 64bit]
[    0.224728] pci 0000:6e:00.0: PME# supported from D0 D3hot D3cold
[    0.240070] pci 0000:00:1c.4: PCI bridge to [bus 6e]
[    0.240077] pci 0000:00:1c.4:   bridge window [mem 0xae100000-0xae1fffff]
[    0.240215] acpiphp: Slot [1-1] registered
[    0.240223] pci 0000:00:1d.0: PCI bridge to [bus 6f]
[    0.240379] pci 0000:70:00.0: [1b21:1080] type 01 class 0x060400
[    0.240511] pci 0000:70:00.0: supports D1 D2
[    0.240512] pci 0000:70:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.256044] pci 0000:00:1d.2: PCI bridge to [bus 70-71]
[    0.256202] pci 0000:70:00.0: PCI bridge to [bus 71]
[    0.257907] ACPI Exception: AE_NOT_FOUND, Evaluating _PRS (20170831/pci_link-176)
[    0.257917] ACPI Exception: AE_NOT_FOUND, Evaluating _PRS (20170831/pci_link-176)
[    0.257925] ACPI Exception: AE_NOT_FOUND, Evaluating _PRS (20170831/pci_link-176)
[    0.257932] ACPI Exception: AE_NOT_FOUND, Evaluating _PRS (20170831/pci_link-176)
[    0.257940] ACPI Exception: AE_NOT_FOUND, Evaluating _PRS (20170831/pci_link-176)
[    0.257947] ACPI Exception: AE_NOT_FOUND, Evaluating _PRS (20170831/pci_link-176)
[    0.257954] ACPI Exception: AE_NOT_FOUND, Evaluating _PRS (20170831/pci_link-176)
[    0.257962] ACPI Exception: AE_NOT_FOUND, Evaluating _PRS (20170831/pci_link-176)
[    0.260006] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.260006] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.260007] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.260007] vgaarb: loaded
[    0.260114] SCSI subsystem initialized
[    0.260126] libata version 3.00 loaded.
[    0.260126] ACPI: bus type USB registered
[    0.260126] usbcore: registered new interface driver usbfs
[    0.260126] usbcore: registered new interface driver hub
[    0.260126] usbcore: registered new device driver usb
[    0.260126] EDAC MC: Ver: 3.0.0
[    0.260206] Registered efivars operations
[    0.283607] PCI: Using ACPI for IRQ routing
[    0.293290] PCI: pci_cache_line_size set to 64 bytes
[    0.293479] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
[    0.293479] e820: reserve RAM buffer [mem 0x64733000-0x67ffffff]
[    0.293480] e820: reserve RAM buffer [mem 0x7821e000-0x7bffffff]
[    0.293481] e820: reserve RAM buffer [mem 0x7bd00000-0x7bffffff]
[    0.293535] NetLabel: Initializing
[    0.293536] NetLabel:  domain hash size = 128
[    0.293536] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.293545] NetLabel:  unlabeled traffic allowed by default
[    0.293554] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.293554] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[    0.294212] clocksource: Switched to clocksource hpet
[    0.299126] VFS: Disk quotas dquot_6.6.0
[    0.299139] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.299200] AppArmor: AppArmor Filesystem Enabled
[    0.299211] pnp: PnP ACPI init
[    0.299466] system 00:00: [io  0x0a00-0x0a3f] has been reserved
[    0.299467] system 00:00: [io  0x0a40-0x0a7f] has been reserved
[    0.299470] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.300530] pnp 00:01: [dma 0 disabled]
[    0.300560] pnp 00:01: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.300700] system 00:02: [io  0x0680-0x069f] has been reserved
[    0.300701] system 00:02: [io  0x164e-0x164f] has been reserved
[    0.300703] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.300716] pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.300798] system 00:04: [io  0x1854-0x1857] has been reserved
[    0.300800] system 00:04: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
[    0.300916] system 00:05: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.300917] system 00:05: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.300918] system 00:05: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.300919] system 00:05: [mem 0xf0000000-0xf7ffffff] has been reserved
[    0.300920] system 00:05: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.300921] system 00:05: [mem 0xfed90000-0xfed93fff] could not be reserved
[    0.300921] system 00:05: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.300922] system 00:05: [mem 0xfee00000-0xfeefffff] could not be reserved
[    0.300924] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.301123] system 00:06: [io  0x1800-0x18fe] could not be reserved
[    0.301124] system 00:06: [mem 0xfd000000-0xfd69ffff] has been reserved
[    0.301125] system 00:06: [mem 0xfd6c0000-0xfd6cffff] has been reserved
[    0.301126] system 00:06: [mem 0xfd6f0000-0xfdffffff] has been reserved
[    0.301126] system 00:06: [mem 0xfe000000-0xfe01ffff] could not be reserved
[    0.301127] system 00:06: [mem 0xfe200000-0xfe7fffff] has been reserved
[    0.301128] system 00:06: [mem 0xff000000-0xffffffff] has been reserved
[    0.301130] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.301401] system 00:07: [io  0x2000-0x20fe] has been reserved
[    0.301403] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.302413] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.303230] pnp: PnP ACPI: found 9 devices
[    0.313534] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.313555] pci 0000:00:1b.4: bridge window [io  0x1000-0x0fff] to [bus 02-6c] add_size 1000
[    0.313606] pci 0000:00:1b.4: BAR 13: assigned [io  0x4000-0x4fff]
[    0.313610] pci 0000:00:1f.4: BAR 0: assigned [mem 0x4010000000-0x40100000ff 64bit]
[    0.313649] pci 0000:00:1b.0: PCI bridge to [bus 01]
[    0.313654] pci 0000:00:1b.0:   bridge window [mem 0xae200000-0xae2fffff]
[    0.313664] pci 0000:00:1b.4: PCI bridge to [bus 02-6c]
[    0.313666] pci 0000:00:1b.4:   bridge window [io  0x4000-0x4fff]
[    0.313671] pci 0000:00:1b.4:   bridge window [mem 0x80000000-0xae0fffff]
[    0.313674] pci 0000:00:1b.4:   bridge window [mem 0x6000000000-0x6049ffffff 64bit pref]
[    0.313681] pci 0000:00:1c.0: PCI bridge to [bus 6d]
[    0.313696] pci 0000:00:1c.4: PCI bridge to [bus 6e]
[    0.313701] pci 0000:00:1c.4:   bridge window [mem 0xae100000-0xae1fffff]
[    0.313711] pci 0000:00:1d.0: PCI bridge to [bus 6f]
[    0.313724] pci 0000:70:00.0: PCI bridge to [bus 71]
[    0.313739] pci 0000:00:1d.2: PCI bridge to [bus 70-71]
[    0.313753] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.313754] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.313755] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.313756] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff window]
[    0.313756] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff window]
[    0.313757] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff window]
[    0.313757] pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff window]
[    0.313758] pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff window]
[    0.313759] pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff window]
[    0.313759] pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff window]
[    0.313760] pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff window]
[    0.313761] pci_bus 0000:00: resource 15 [mem 0x000e4000-0x000e7fff window]
[    0.313761] pci_bus 0000:00: resource 16 [mem 0x000e8000-0x000ebfff window]
[    0.313762] pci_bus 0000:00: resource 17 [mem 0x000ec000-0x000effff window]
[    0.313763] pci_bus 0000:00: resource 18 [mem 0x80000000-0xefffffff window]
[    0.313764] pci_bus 0000:00: resource 19 [mem 0x4000000000-0x7fffffffff window]
[    0.313764] pci_bus 0000:00: resource 20 [mem 0xfc800000-0xfe7fffff window]
[    0.313765] pci_bus 0000:01: resource 1 [mem 0xae200000-0xae2fffff]
[    0.313766] pci_bus 0000:02: resource 0 [io  0x4000-0x4fff]
[    0.313766] pci_bus 0000:02: resource 1 [mem 0x80000000-0xae0fffff]
[    0.313767] pci_bus 0000:02: resource 2 [mem 0x6000000000-0x6049ffffff 64bit pref]
[    0.313768] pci_bus 0000:6e: resource 1 [mem 0xae100000-0xae1fffff]
[    0.313905] NET: Registered protocol family 2
[    0.314087] TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.314511] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.314587] TCP: Hash tables configured (established 524288 bind 65536)
[    0.314629] UDP hash table entries: 32768 (order: 8, 1048576 bytes)
[    0.314743] UDP-Lite hash table entries: 32768 (order: 8, 1048576 bytes)
[    0.314854] NET: Registered protocol family 1
[    0.314861] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.314996] PCI: CLS 64 bytes, default 64
[    0.315016] Unpacking initramfs...
[    0.907506] Freeing initrd memory: 51316K
[    0.907567] DMAR: ACPI device "device:80" under DMAR at fed91000 as 00:15.0
[    0.907578] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.907580] software IO TLB [mem 0x6f9b4000-0x739b4000] (64MB) mapped at [00000000d05de938-000000000dfe67a8]
[    0.908311] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2e02c4a121d, max_idle_ns: 440795236083 ns
[    0.908984] Scanning for low memory corruption every 60 seconds
[    0.909677] Initialise system trusted keyrings
[    0.909682] Key type blacklist registered
[    0.909814] workingset: timestamp_bits=36 max_order=24 bucket_order=0
[    0.910511] zbud: loaded
[    0.910766] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.910989] fuse init (API version 7.26)
[    0.916855] Key type asymmetric registered
[    0.916855] Asymmetric key parser 'x509' registered
[    0.916873] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
[    0.916980] io scheduler noop registered
[    0.916981] io scheduler deadline registered
[    0.917007] io scheduler cfq registered (default)
[    0.918645] dpc 0000:00:1b.0:pcie010: DPC error containment capabilities: Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
[    0.918661] dpc 0000:00:1b.4:pcie010: DPC error containment capabilities: Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
[    0.918675] dpc 0000:00:1c.4:pcie010: DPC error containment capabilities: Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
[    0.918695] dpc 0000:00:1d.2:pcie010: DPC error containment capabilities: Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
[    0.918731] efifb: invalid framebuffer address
[    0.918735] intel_idle: MWAIT substates: 0x11142120
[    0.918735] intel_idle: v0.4.1 model 0x9E
[    0.919635] intel_idle: lapic_timer_reliable_states 0xffffffff
[    0.919718] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
[    0.919734] ACPI: Sleep Button [SLPB]
[    0.919754] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    0.919768] ACPI: Power Button [PWRB]
[    0.919785] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    0.919900] ACPI: Power Button [PWRF]
[    0.982420] (NULL device *): hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[    1.040350] thermal LNXTHERM:00: registered as thermal_zone0
[    1.040351] ACPI: Thermal Zone [TZ00] (28 C)
[    1.040538] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    1.062562] 00:01: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    1.066311] serial 0000:00:16.3: enabling device (0000 -> 0003)
[    1.087700] 0000:00:16.3: ttyS4 at I/O 0x3080 (irq = 19, base_baud = 115200) is a 16550A
[    1.088195] Linux agpgart interface v0.103
[    1.115484] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFC, rev-id 1)
[    1.126446] tpm tpm0: A TPM error (2314) occurred continue selftest
[    1.478599] loop: module loaded
[    1.478995] nvme nvme0: pci function 0000:01:00.0
[    1.479041] libphy: Fixed MDIO Bus: probed
[    1.479041] tun: Universal TUN/TAP device driver, 1.6
[    1.479132] PPP generic driver version 2.4.2
[    1.479232] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.479233] ehci-pci: EHCI PCI platform driver
[    1.479241] ehci-platform: EHCI generic platform driver
[    1.479246] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.479248] ohci-pci: OHCI PCI platform driver
[    1.479253] ohci-platform: OHCI generic platform driver
[    1.479257] uhci_hcd: USB Universal Host Controller Interface driver
[    1.479305] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.479308] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    1.480527] xhci_hcd 0000:00:14.0: hcc params 0x20007fc1 hci version 0x110 quirks 0x00009810
[    1.480532] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    1.480685] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    1.480686] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.480687] usb usb1: Product: xHCI Host Controller
[    1.480688] usb usb1: Manufacturer: Linux 4.15.0-041500rc9-generic xhci-hcd
[    1.480688] usb usb1: SerialNumber: 0000:00:14.0
[    1.480812] hub 1-0:1.0: USB hub found
[    1.480833] hub 1-0:1.0: 16 ports detected
[    1.482224] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.482226] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    1.482228] xhci_hcd 0000:00:14.0: Host supports USB 3.1 Enhanced SuperSpeed
[    1.482253] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[    1.482254] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.482255] usb usb2: Product: xHCI Host Controller
[    1.482256] usb usb2: Manufacturer: Linux 4.15.0-041500rc9-generic xhci-hcd
[    1.482256] usb usb2: SerialNumber: 0000:00:14.0
[    1.482390] hub 2-0:1.0: USB hub found
[    1.482414] hub 2-0:1.0: 10 ports detected
[    1.483212] usb: port power management may be unreliable
[    1.483329] i8042: PNP: No PS/2 controller found.
[    1.483537] mousedev: PS/2 mouse device common for all mice
[    1.484050] rtc_cmos 00:03: RTC can wake from S4
[    1.485150] rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
[    1.485340] rtc_cmos 00:03: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[    1.485343] i2c /dev entries driver
[    1.485372] device-mapper: uevent: version 1.0.3
[    1.485487] device-mapper: ioctl: 4.37.0-ioctl (2017-09-20) initialised: dm-devel@redhat.com
[    1.485490] intel_pstate: Intel P-state driver initializing
[    1.489250] intel_pstate: HWP enabled
[    1.490791] ledtrig-cpu: registered to indicate activity on CPUs
[    1.490792] EFI Variables Facility v0.08 2004-May-17
[    1.519603] NET: Registered protocol family 10
[    1.524731] Segment Routing with IPv6
[    1.524741] NET: Registered protocol family 17
[    1.525011] Key type dns_resolver registered
[    1.527130] RAS: Correctable Errors collector initialized.
[    1.527192] microcode: sig=0x906ea, pf=0x2, revision=0x80
[    1.528174] microcode: Microcode Update Driver: v2.2.
[    1.528194] sched_clock: Marking stable (1528136343, 0)->(1506915809, 21220534)
[    1.529040] registered taskstats version 1
[    1.529044] Loading compiled-in X.509 certificates
[    1.531007] Loaded X.509 cert 'Build time autogenerated kernel key: 23b93d546b1936f6416ab3acc17713eca1331f99'
[    1.531018] zswap: loaded using pool lzo/zbud
[    1.533721] Key type big_key registered
[    1.533723] Key type trusted registered
[    1.534857] Key type encrypted registered
[    1.534858] AppArmor: AppArmor sha1 policy hashing enabled
[    1.647476] evm: HMAC attrs: 0x1
[    1.649028]   Magic number: 2:417:322
[    1.649031] misc mcelog: hash matches
[    1.649056] tty tty47: hash matches
[    1.649457] rtc_cmos 00:03: setting system clock to 2018-01-31 08:18:51 UTC (1517386731)
[    1.649679] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    1.649679] EDD information not available.
[    1.651283] Freeing unused kernel memory: 2388K
[    1.651284] Write protecting the kernel read-only data: 20480k
[    1.651796] Freeing unused kernel memory: 2008K
[    1.654244] Freeing unused kernel memory: 1952K
[    1.658181] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.658181] x86/mm: Checking user space page tables
[    1.661679] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.720199]  nvme0n1: p1 p2 p3
[    1.751685] acpi PNP0C14:02: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
[    1.751721] acpi PNP0C14:03: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
[    1.751774] wmi_bus wmi_bus-PNP0C14:04: WQBC data block query control method not found
[    1.751775] acpi PNP0C14:04: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
[    1.758224] ahci 0000:00:17.0: version 3.0
[    1.758799] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 4 ports 6 Gbps 0xf impl SATA mode
[    1.758801] ahci 0000:00:17.0: flags: 64bit ncq sntf pm clo only pio slum part ems deso sadm sds apst 
[    1.760896] pps_core: LinuxPPS API ver. 1 registered
[    1.760896] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    1.761690] PTP clock support registered
[    1.764089] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    1.764089] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.796732] scsi host0: ahci
[    1.796989] scsi host1: ahci
[    1.797314] scsi host2: ahci
[    1.797506] scsi host3: ahci
[    1.797538] ata1: SATA max UDMA/133 abar m2048@0xae322000 port 0xae322100 irq 135
[    1.797563] ata2: SATA max UDMA/133 abar m2048@0xae322000 port 0xae322180 irq 135
[    1.797572] ata3: SATA max UDMA/133 abar m2048@0xae322000 port 0xae322200 irq 135
[    1.797583] ata4: SATA max UDMA/133 abar m2048@0xae322000 port 0xae322280 irq 135
[    1.797987] e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    1.816167] usb 1-9: new low-speed USB device number 2 using xhci_hcd
[    1.916521] clocksource: Switched to clocksource tsc
[    1.922076] e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered PHC clock
[    1.967511] usb 1-9: New USB device found, idVendor=046d, idProduct=c05a
[    1.967512] usb 1-9: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.967512] usb 1-9: Product: USB Optical Mouse
[    1.967513] usb 1-9: Manufacturer: Logitech
[    2.008817] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) d8:9e:f3:79:dc:e5
[    2.008818] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connection
[    2.008976] e1000e 0000:00:1f.6 eth0: MAC: 13, PHY: 12, PBA No: FFFFFF-0FF
[    2.009815] e1000e 0000:00:1f.6 eno1: renamed from eth0
[    2.012083] [drm] Memory usable by graphics device = 4096M
[    2.012087] [drm] Replacing VGA console driver
[    2.018280] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    2.018280] [drm] Driver supports precise vblank timestamp query.
[    2.020426] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    2.021432] [drm] Finished loading DMC firmware i915/kbl_dmc_ver1_01.bin (v1.1)
[    2.096009] usb 1-11: new low-speed USB device number 3 using xhci_hcd
[    2.110418] ata3: SATA link down (SStatus 4 SControl 300)
[    2.110444] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.110461] ata4: SATA link down (SStatus 4 SControl 300)
[    2.110488] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.111320] ata1.00: ATA-9: ST2000DM001-1ER164, CC27, max UDMA/133
[    2.111322] ata1.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    2.112407] ata1.00: configured for UDMA/133
[    2.112494] scsi 0:0:0:0: Direct-Access     ATA      ST2000DM001-1ER1 CC27 PQ: 0 ANSI: 5
[    2.112613] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    2.112618] sd 0:0:0:0: [sda] 3907029168 512-byte logical blocks: (2.00 TB/1.82 TiB)
[    2.112619] sd 0:0:0:0: [sda] 4096-byte physical blocks
[    2.112623] sd 0:0:0:0: [sda] Write Protect is off
[    2.112624] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.112630] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.112671] ata2.00: ATAPI: HL-DT-ST BD-RE BU40N, A101, max UDMA/100
[    2.113581] ata2.00: configured for UDMA/100
[    2.116765] scsi 1:0:0:0: CD-ROM            HL-DT-ST BD-RE BU40N      A101 PQ: 0 ANSI: 5
[    2.142162] sr 1:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
[    2.142163] cdrom: Uniform CD-ROM driver Revision: 3.20
[    2.142225] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    2.142260] sr 1:0:0:0: Attached scsi generic sg1 type 5
[    2.186667]  sda:
[    2.186756] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.249268] usb 1-11: New USB device found, idVendor=046d, idProduct=c31c
[    2.249269] usb 1-11: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.249269] usb 1-11: Product: USB Keyboard
[    2.249270] usb 1-11: Manufacturer: Logitech
[    2.294444] [drm] failed to retrieve link info, disabling eDP
[    2.296639] [drm] Initialized i915 1.6.0 20171023 for 0000:00:02.0 on minor 0
[    2.298547] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    2.299302] acpi device:04: registered as cooling_device17
[    2.299679] acpi device:06: registered as cooling_device18
[    2.300061] acpi device:0f: registered as cooling_device19
[    2.300140] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input3
[    2.380004] usb 1-14: new full-speed USB device number 4 using xhci_hcd
[    2.529179] usb 1-14: New USB device found, idVendor=8087, idProduct=0025
[    2.529180] usb 1-14: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.531629] hidraw: raw HID events driver (C) Jiri Kosina
[    2.540353] usbcore: registered new interface driver usbhid
[    2.540354] usbhid: USB HID core driver
[    2.541191] input: Logitech USB Optical Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-9/1-9:1.0/0003:046D:C05A.0001/input/input4
[    2.541241] hid-generic 0003:046D:C05A.0001: input,hidraw0: USB HID v1.11 Mouse [Logitech USB Optical Mouse] on usb-0000:00:14.0-9/input0
[    2.541309] input: Logitech USB Keyboard as /devices/pci0000:00/0000:00:14.0/usb1/1-11/1-11:1.0/0003:046D:C31C.0002/input/input5
[    2.600247] hid-generic 0003:046D:C31C.0002: input,hidraw1: USB HID v1.10 Keyboard [Logitech USB Keyboard] on usb-0000:00:14.0-11/input0
[    2.600324] input: Logitech USB Keyboard as /devices/pci0000:00/0000:00:14.0/usb1/1-11/1-11:1.1/0003:046D:C31C.0003/input/input6
[    2.660253] hid-generic 0003:046D:C31C.0003: input,hidraw2: USB HID v1.10 Device [Logitech USB Keyboard] on usb-0000:00:14.0-11/input1
[    3.215868] fbcon: inteldrmfb (fb0) is primary device
[    3.245304] Console: switching to colour frame buffer device 240x67
[    3.264152] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    3.708372] [drm] RC6 on
[    4.432002] raid6: sse2x1   gen() 12960 MB/s
[    4.500004] raid6: sse2x1   xor()  7592 MB/s
[    4.568005] raid6: sse2x2   gen() 14977 MB/s
[    4.636002] raid6: sse2x2   xor()  9848 MB/s
[    4.704003] raid6: sse2x4   gen() 17067 MB/s
[    4.772004] raid6: sse2x4   xor() 10379 MB/s
[    4.840002] raid6: avx2x1   gen() 29772 MB/s
[    4.908003] raid6: avx2x1   xor() 20422 MB/s
[    4.976001] raid6: avx2x2   gen() 36791 MB/s
[    5.044001] raid6: avx2x2   xor() 22347 MB/s
[    5.112002] raid6: avx2x4   gen() 41122 MB/s
[    5.180001] raid6: avx2x4   xor() 23631 MB/s
[    5.180002] raid6: using algorithm avx2x4 gen() 41122 MB/s
[    5.180002] raid6: .... xor() 23631 MB/s, rmw enabled
[    5.180003] raid6: using avx2x2 recovery algorithm
[    5.182289] xor: automatically using best checksumming function   avx       
[    5.191392] Btrfs loaded, crc32c=crc32c-intel
[    5.302183] EXT4-fs (nvme0n1p3): mounted filesystem with ordered data mode. Opts: (null)
[    5.428834] systemd[1]: systemd 229 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN)
[    5.448135] systemd[1]: Detected architecture x86-64.
[    5.448234] systemd[1]: Set hostname to <u-Precision-3630>.
[    5.483065] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    5.483118] systemd[1]: Listening on Syslog Socket.
[    5.483227] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    5.483244] systemd[1]: Listening on Journal Socket (/dev/log).
[    5.483294] systemd[1]: Created slice System Slice.
[    5.483539] systemd[1]: Started Early root shell on /dev/tty9 FOR DEBUGGING ONLY.
[    5.483649] systemd[1]: Listening on udev Control Socket.
[    5.493921] lp: driver loaded but no devices found
[    5.494591] random: crng init done
[    5.495343] ppdev: user-space parallel port driver
[    5.519178] EXT4-fs (nvme0n1p3): re-mounted. Opts: errors=remount-ro
[    5.523534] systemd-journald[403]: Received request to flush runtime journal from PID 1
[    5.592996] (NULL device *): hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[    5.596819] intel-lpss 0000:00:15.0: enabling device (0100 -> 0102)
[    5.641671] RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters, 655360 ms ovfl timer
[    5.641672] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    5.641672] RAPL PMU: hw unit of domain package 2^-14 Joules
[    5.641673] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    5.641673] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    5.641673] RAPL PMU: hw unit of domain psys 2^-14 Joules
[    5.641723] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    5.642666] input: Dell AIO WMI hotkeys as /devices/virtual/input/input7
[    5.648287] Bluetooth: Core ver 2.22
[    5.648296] NET: Registered protocol family 31
[    5.648297] Bluetooth: HCI device and connection manager initialized
[    5.648299] Bluetooth: HCI socket layer initialized
[    5.648300] Bluetooth: L2CAP socket layer initialized
[    5.648303] Bluetooth: SCO socket layer initialized
[    5.648322] input: Dell WMI hotkeys as /devices/platform/PNP0C14:04/wmi_bus/wmi_bus-PNP0C14:04/9DBB5994-A997-11DA-B012-B622A1EF5492/input/input8
[    5.650445] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    5.656704] usbcore: registered new interface driver btusb
[    5.657255] AVX2 version of gcm_enc/dec engaged.
[    5.657255] AES CTR mode by8 optimization enabled
[    5.660154] Bluetooth: hci0: Bootloader revision 0.1 build 42 week 52 2015
[    5.661161] Bluetooth: hci0: Device revision is 2
[    5.661161] Bluetooth: hci0: Secure boot is enabled
[    5.661162] Bluetooth: hci0: OTP lock is disabled
[    5.661162] Bluetooth: hci0: API lock is disabled
[    5.661163] Bluetooth: hci0: Debug lock is disabled
[    5.661163] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[    5.662554] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    5.664842] Bluetooth: hci0: Found device firmware: intel/ibt-18-16-1.sfi
[    5.665439] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    5.665650] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    5.665652] cfg80211: failed to load regulatory.db
[    5.671591] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.2)
[    5.671790] Intel(R) Wireless WiFi driver for Linux
[    5.671791] Copyright(c) 2003- 2015 Intel Corporation
[    5.671848] iwlwifi 0000:6e:00.0: enabling device (0100 -> 0102)
[    5.675861] iwlwifi 0000:6e:00.0: Direct firmware load for iwlwifi-9260-th-b0-jf-b0-34.ucode failed with error -2
[    5.678575] iwlwifi 0000:6e:00.0: loaded firmware version 33.610294.0 op_mode iwlmvm
[    5.699536] iwlwifi 0000:6e:00.0: Detected Intel(R) Dual Band Wireless AC 9260, REV=0x324
[    5.709802] snd_hda_intel 0000:00:1f.3: enabling device (0100 -> 0102)
[    5.709964] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
[    5.710733] intel_rapl: Found RAPL domain package
[    5.710734] intel_rapl: Found RAPL domain core
[    5.710735] intel_rapl: Found RAPL domain uncore
[    5.710735] intel_rapl: Found RAPL domain dram
[    5.752704] iwlwifi 0000:6e:00.0: base HW address: 34:13:e8:90:a8:e9
[    5.776784] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC3234: line_outs=1 (0x1b/0x0/0x0/0x0/0x0) type:line
[    5.776785] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=1 (0x14/0x0/0x0/0x0/0x0)
[    5.776786] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
[    5.776786] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[    5.776787] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[    5.776788] snd_hda_codec_realtek hdaudioC0D0:      Headphone Mic=0x1a
[    5.776788] snd_hda_codec_realtek hdaudioC0D0:      Headset Mic=0x19
[    5.844313] snd_hda_codec_realtek hdaudioC0D0: Failed to find dell wmi symbol dell_micmute_led_set
[    5.844975] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
[    5.845165] (NULL device *): hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[    5.845182] thermal thermal_zone3: failed to read out thermal zone (-61)
[    5.845735] iwlwifi 0000:6e:00.0 wlp110s0: renamed from wlan0
[    5.882235] audit: type=1400 audit(1517386735.727:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/ippusbxd" pid=986 comm="apparmor_parser"
[    5.882468] audit: type=1400 audit(1517386735.727:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/cups-browsed" pid=984 comm="apparmor_parser"
[    5.882618] audit: type=1400 audit(1517386735.727:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/snapd/snap-confine" pid=983 comm="apparmor_parser"
[    5.882620] audit: type=1400 audit(1517386735.727:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/snapd/snap-confine//mount-namespace-capture-helper" pid=983 comm="apparmor_parser"
[    5.883117] audit: type=1400 audit(1517386735.727:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/lightdm/lightdm-guest-session" pid=978 comm="apparmor_parser"
[    5.883119] audit: type=1400 audit(1517386735.727:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/lightdm/lightdm-guest-session//chromium" pid=978 comm="apparmor_parser"
[    5.883284] audit: type=1400 audit(1517386735.727:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/tcpdump" pid=988 comm="apparmor_parser"
[    5.883341] audit: type=1400 audit(1517386735.727:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/sbin/dhclient" pid=979 comm="apparmor_parser"
[    5.883342] audit: type=1400 audit(1517386735.727:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=979 comm="apparmor_parser"
[    5.883344] audit: type=1400 audit(1517386735.727:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/NetworkManager/nm-dhcp-helper" pid=979 comm="apparmor_parser"
[    5.906676] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    5.906677] Bluetooth: BNEP filters: protocol multicast
[    5.906679] Bluetooth: BNEP socket layer initialized
[    5.971248] IPv6: ADDRCONF(NETDEV_UP): wlp110s0: link is not ready
[    6.168777] IPv6: ADDRCONF(NETDEV_UP): wlp110s0: link is not ready
[    6.171214] IPv6: ADDRCONF(NETDEV_UP): eno1: link is not ready
[    6.468282] IPv6: ADDRCONF(NETDEV_UP): eno1: link is not ready
[    6.531007] IPv6: ADDRCONF(NETDEV_UP): wlp110s0: link is not ready
[    6.866010] Bluetooth: hci0: Waiting for firmware download to complete
[    6.866141] Bluetooth: hci0: Firmware loaded in 1179763 usecs
[    6.866218] Bluetooth: hci0: Waiting for device to boot
[    6.878173] Bluetooth: hci0: Device booted in 11721 usecs
[    6.879998] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-18-16-1.ddc
[    6.884198] Bluetooth: hci0: Applying Intel DDC parameters completed
[    7.483744] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[    7.483748] Bluetooth: HIDP socket layer initialized
[    7.484157] hid-generic 0005:1345:7100.0004: unknown main item tag 0x0
[    7.484226] input: Bluetooth Keyboard as /devices/pci0000:00/0000:00:14.0/usb1/1-14/1-14:1.0/bluetooth/hci0/hci0:256/0005:1345:7100.0004/input/input11
[    7.484372] hid-generic 0005:1345:7100.0004: input,hidraw3: BLUETOOTH HID v1.02 Keyboard [Bluetooth Keyboard] on 34:13:e8:90:a8:ed
[    7.521568] Bluetooth: RFCOMM TTY layer initialized
[    7.521573] Bluetooth: RFCOMM socket layer initialized
[    7.521576] Bluetooth: RFCOMM ver 1.11
[    8.925942] input: HDA Intel PCH Headphone Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input9
[    8.925974] input: HDA Intel PCH Line Out as /devices/pci0000:00/0000:00:1f.3/sound/card0/input10
[    8.926002] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input12
[    8.926026] input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input13
[    8.926051] input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input14
[    8.926077] input: HDA Intel PCH HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input15
[    8.926101] input: HDA Intel PCH HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input16
[   45.764641] wlp110s0: authenticate with a4:56:30:be:51:10
[   45.876687] wlp110s0: send auth to a4:56:30:be:51:10 (try 1/3)
[   45.916791] wlp110s0: authenticated
[   45.920078] wlp110s0: associate with a4:56:30:be:51:10 (try 1/3)
[   45.921442] wlp110s0: RX AssocResp from a4:56:30:be:51:10 (capab=0x111 status=0 aid=5)
[   45.923812] wlp110s0: associated
[   45.932112] iwlwifi 0000:6e:00.0: Unhandled alg: 0x707
[   45.937120] IPv6: ADDRCONF(NETDEV_CHANGE): wlp110s0: link becomes ready

--Apple-Mail=_8295673B-FB6E-43DE-AFE1-DCF7415117AD
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii




--Apple-Mail=_8295673B-FB6E-43DE-AFE1-DCF7415117AD--
