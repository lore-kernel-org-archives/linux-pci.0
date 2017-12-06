Return-Path: <SRS0=ebVz=DC=gmail.com=mingo.kernel.org@kernel.org>
Return-Path: <SRS0=ebVz=DC=gmail.com=mingo.kernel.org@kernel.org>
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 6 Dec 2017 17:16:49 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [regression] PCI early boot hang on certain AMD systems (was: Re:
 [GIT PULL] PCI changes for v4.15)
Message-ID: <20171206161649.7ievlr7adshlxlho@gmail.com>
References: <20171115185855.GA11685@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="yo2353snizqlekop"
In-Reply-To: <20171115185855.GA11685@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>


--yo2353snizqlekop
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


Hi,

* Bjorn Helgaas <helgaas@kernel.org> wrote:

> PCI changes:

> Christian König (4):
>       x86/PCI: Enable a 64bit BAR on AMD Family 15h (Models 00-1f, 30-3f, 60-7f)

In v4.15 one of my test systems broke, it hangs in early bootup, during early PCI 
setup:

[    2.262005] pci 0000:00:18.1: adding root bus resource [mem 0x1027000000-0xfcffffffff 64bit pref window] <--- new resource
[    2.270081] pci 0000:00:18.2: [1022:1602] type 00 class 0x060000
[    2.271081] pci 0000:00:18.3: [1022:1603] type 00 class 0x060000
[    2.272083] pci 0000:00:18.4: [1022:1604] type 00 class 0x060000
[    2.273079] pci 0000:00:18.5: [1022:1605] type 00 class 0x060000
[    2.274083] pci 0000:00:19.0: [1022:1600] type 00 class 0x060000
[    2.275089] pci 0000:00:19.1: [1022:1601] type 00 class 0x060000
[  hard hang ]

I have bisected the hang to:

  fa564ad96366: x86/PCI: Enable a 64bit BAR on AMD Family 15h (Models 00-1f, 30-3f, 60-7f)

Reverting the commit makes the system boot again. The 'new resource' line above is 
I believe the new BAR added by the commit.

I've attached the earlyprintk boot log of the hang, with a few printks added to 
pci_amd_enable_64bit_bar() of the relevant fields:

+       printk("res->start: %016llx\n", res->start);
+       printk("res->end:   %016llx\n", res->end);
+       printk("base:       %08x\n", base);
+       printk("high:       %08x\n", high);
+       printk("limit:      %08x\n", limit);
+       printk("slot:       %d\n", i);

[    2.261090] pci 0000:00:18.1: [1022:1601] type 00 class 0x060000
[    2.262005] pci 0000:00:18.1: adding root bus resource [mem 0x1027000000-0xfcffffffff 64bit pref window]
[    2.264001] res->start: 0000001027000000
[    2.265001] res->end:   000000fcffffffff
[    2.266001] base:       10270003
[    2.267001] high:       00000000
[    2.268001] limit:      fd000000
[    2.269001] slot:       1
[    2.270081] pci 0000:00:18.2: [1022:1602] type 00 class 0x060000
[    2.271081] pci 0000:00:18.3: [1022:1603] type 00 class 0x060000
[    2.272083] pci 0000:00:18.4: [1022:1604] type 00 class 0x060000
[    2.273079] pci 0000:00:18.5: [1022:1605] type 00 class 0x060000
[    2.274083] pci 0000:00:19.0: [1022:1600] type 00 class 0x060000
[    2.275089] pci 0000:00:19.1: [1022:1601] type 00 class 0x060000

On a sucessful bootup the system would continue with:

[    0.583060] pci 0000:00:19.2: [1022:1602] type 00 class 0x060000
[    0.584079] pci 0000:00:19.3: [1022:1603] type 00 class 0x060000
[    0.585084] pci 0000:00:19.4: [1022:1604] type 00 class 0x060000
[    0.586079] pci 0000:00:19.5: [1022:1605] type 00 class 0x060000
[    0.588039] pci 0000:00:1a.0: [1022:1600] type 00 class 0x060000
[    0.589090] pci 0000:00:1a.1: [1022:1601] type 00 class 0x060000
[    0.590079] pci 0000:00:1a.2: [1022:1602] type 00 class 0x060000
[    0.591080] pci 0000:00:1a.3: [1022:1603] type 00 class 0x060000
[    0.593006] pci 0000:00:1a.4: [1022:1604] type 00 class 0x060000
[    0.594079] pci 0000:00:1a.5: [1022:1605] type 00 class 0x060000
[    0.595082] pci 0000:00:1b.0: [1022:1600] type 00 class 0x060000
[    0.596087] pci 0000:00:1b.1: [1022:1601] type 00 class 0x060000
[    0.597083] pci 0000:00:1b.2: [1022:1602] type 00 class 0x060000
[    0.598080] pci 0000:00:1b.3: [1022:1603] type 00 class 0x060000
[    0.599085] pci 0000:00:1b.4: [1022:1604] type 00 class 0x060000
[    0.600079] pci 0000:00:1b.5: [1022:1605] type 00 class 0x060000
[    0.601124] pci 0000:03:00.0: [1000:0072] type 00 class 0x010700
[    0.602037] pci 0000:03:00.0: reg 0x10: [io  0xe000-0xe0ff]
[    0.603010] pci 0000:03:00.0: reg 0x14: [mem 0xdff3c000-0xdff3ffff 64bit]
[    0.604009] pci 0000:03:00.0: reg 0x1c: [mem 0xdff40000-0xdff7ffff 64bit]
[    0.605011] pci 0000:03:00.0: reg 0x30: [mem 0xdff80000-0xdfffffff pref]
...

cpuinfo:

 processor       : 31
 vendor_id       : AuthenticAMD
 cpu family      : 21
 model           : 1
 model name      : AMD Opteron(tm) Processor 6278
 stepping        : 2
 microcode       : 0x6000626
 cpu MHz         : 1427.124
 cache size      : 2048 KB
 physical id     : 1
 siblings        : 16
 core id         : 7
 cpu cores       : 8

board:

        Manufacturer: Supermicro
        Product Name: H8DG6/H8DGi

BIOS:

        Vendor: American Megatrends Inc.
        Version: 2.0b      
        Release Date: 03/01/2012

I've attached the lspci -v output and a successful full bootlog as well, with 
various debugging options enabled. Let me know if you need any other info.

Thanks,

	Ingo

--yo2353snizqlekop
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pci-hang.log"

[    0.000000] Linux version 4.14.0-rc3-00004-gfa564ad96366-dirty (mingo@fomalhaut) (gcc version 5.3.1 20160406 (Red Hat 5.3.1-6) (GCC)) #27 SMP Wed Dec 6 16:56:40 CET 2017
[    0.000000] Command line: BOOT_IMAGE=/boot/bzImage root=/dev/sda2 ro rd.md=0 rd.lvm=0 rd.dm=0 earlyprintk=serial,ttyS2,115200 console=ttyS2,115200 console=tty ignore_loglevel sysrq_always_enabled nmi_watchdog=2 SYSFONT=latarcyrheb-sun16 KEYTABLE=us rd.luks=0 LANG=en_US.UTF-8 debug
[    0.000000] random: get_random_u32 called from bsp_init_amd+0x18f/0x250 with crng_init=0
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x00000000000997ff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000099800-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e6000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000d7e7ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000d7e8e000-0x00000000d7e8ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000d7e90000-0x00000000d7eb3fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000d7eb4000-0x00000000d7edffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000d7ee0000-0x00000000d7ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffe00000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x0000001026ffffff] usable
[    0.000000] bootconsole [earlyser0] enabled
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] random: fast init done
[    0.000000] SMBIOS 2.6 present.
[    0.000000] DMI: Supermicro H8DG6/H8DGi/H8DG6/H8DGi, BIOS 2.0b       03/01/2012
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] AGP: No AGP bridge found
[    0.000000] e820: last_pfn = 0x1027000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-EFFFF uncachable
[    0.000000]   F0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000000 mask FFFF80000000 write-back
[    0.000000]   1 base 000080000000 mask FFFFC0000000 write-back
[    0.000000]   2 base 0000C0000000 mask FFFFF0000000 write-back
[    0.000000]   3 base 0000D0000000 mask FFFFF8000000 write-back
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] TOM2: 0000001027000000 aka 66160M
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000000] e820: update [mem 0xd8000000-0xffffffff] usable ==> reserved
[    0.000000] e820: last_pfn = 0xd7e80 max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000ff780-0x000ff78f] mapped at [ffffffffff200780]
[    0.000000] Base memory trampoline at [ffff880000093000] 93000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x02a5f000, 0x02a5ffff] PGTABLE
[    0.000000] BRK [0x02a60000, 0x02a60fff] PGTABLE
[    0.000000] BRK [0x02a61000, 0x02a61fff] PGTABLE
[    0.000000] BRK [0x02a62000, 0x02a62fff] PGTABLE
[    0.000000] RAMDISK: [mem 0x35f96000-0x36fc2fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000FA5D0 000024 (v02 ACPIAM)
[    0.000000] ACPI: XSDT 0x00000000D7E90100 000084 (v01 SMCI            20120301 MSFT 00000097)
[    0.000000] ACPI: FACP 0x00000000D7E90290 0000F4 (v03 030112 FACP1736 20120301 MSFT 00000097)
[    0.000000] ACPI BIOS Warning (bug): 32/64X length mismatch in FADT/Gpe0Block: 64/32 (20170728/tbfadt-603)
[    0.000000] ACPI: DSDT 0x00000000D7E906B0 006F89 (v01 1BC11  1BC11000 00000000 INTL 20051117)
[    0.000000] ACPI: FACS 0x00000000D7EB4000 000040
[    0.000000] ACPI: FACS 0x00000000D7EB4000 000040
[    0.000000] ACPI: APIC 0x00000000D7E90390 000158 (v01 030112 APIC1736 20120301 MSFT 00000097)
[    0.000000] ACPI: MCFG 0x00000000D7E904F0 00003C (v01 030112 OEMMCFG  20120301 MSFT 00000097)
[    0.000000] ACPI: OEMB 0x00000000D7EB4040 0000BC (v01 030112 OEMB1736 20120301 MSFT 00000097)
[    0.000000] ACPI: HPET 0x00000000D7E9A6B0 000038 (v01 030112 OEMHPET  20120301 MSFT 00000097)
[    0.000000] ACPI: SRAT 0x00000000D7E9A6F0 000320 (v02 AMD    AGESA    00000001 AMD  00000001)
[    0.000000] ACPI: SLIT 0x00000000D7E9AA10 00003C (v01 AMD    AGESA    00000001 AMD  00000001)
[    0.000000] ACPI: SSDT 0x00000000D7E9AA50 005BE4 (v01 A M I  POWERNOW 00000001 AMD  00000001)
[    0.000000] ACPI: EINJ 0x00000000D7EA0640 000130 (v01 AMIER  AMI_EINJ 20120301 MSFT 00000097)
[    0.000000] ACPI: BERT 0x00000000D7EA07D0 000030 (v01 AMIER  AMI_BERT 20120301 MSFT 00000097)
[    0.000000] ACPI: ERST 0x00000000D7EA0800 0001B0 (v01 AMIER  AMI_ERST 20120301 MSFT 00000097)
[    0.000000] ACPI: HEST 0x00000000D7EA09B0 0000A8 (v01 AMIER  ABC_HEST 20120301 MSFT 00000097)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] SRAT: PXM 0 -> APIC 0x20 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x21 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x22 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x23 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x24 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x25 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x26 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x27 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x28 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x29 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x2a -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x2b -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x2c -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x2d -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x2e -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x2f -> Node 1
[    0.000000] SRAT: PXM 2 -> APIC 0x40 -> Node 2
[    0.000000] SRAT: PXM 2 -> APIC 0x41 -> Node 2
[    0.000000] SRAT: PXM 2 -> APIC 0x42 -> Node 2
[    0.000000] SRAT: PXM 2 -> APIC 0x43 -> Node 2
[    0.000000] SRAT: PXM 2 -> APIC 0x44 -> Node 2
[    0.000000] SRAT: PXM 2 -> APIC 0x45 -> Node 2
[    0.000000] SRAT: PXM 2 -> APIC 0x46 -> Node 2
[    0.000000] SRAT: PXM 2 -> APIC 0x47 -> Node 2
[    0.000000] SRAT: PXM 3 -> APIC 0x48 -> Node 3
[    0.000000] SRAT: PXM 3 -> APIC 0x49 -> Node 3
[    0.000000] SRAT: PXM 3 -> APIC 0x4a -> Node 3
[    0.000000] SRAT: PXM 3 -> APIC 0x4b -> Node 3
[    0.000000] SRAT: PXM 3 -> APIC 0x4c -> Node 3
[    0.000000] SRAT: PXM 3 -> APIC 0x4d -> Node 3
[    0.000000] SRAT: PXM 3 -> APIC 0x4e -> Node 3
[    0.000000] SRAT: PXM 3 -> APIC 0x4f -> Node 3
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x00100000-0xd7ffffff]
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x427ffffff]
[    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x428000000-0x827ffffff]
[    0.000000] ACPI: SRAT: Node 2 PXM 2 [mem 0x828000000-0xc27ffffff]
[    0.000000] ACPI: SRAT: Node 3 PXM 3 [mem 0xc28000000-0x1026ffffff]
[    0.000000] NUMA: Initialized distance table, cnt=4
[    0.000000] NUMA: Node 0 [mem 0x00000000-0x0009ffff] + [mem 0x00100000-0xd7ffffff] -> [mem 0x00000000-0xd7ffffff]
[    0.000000] NUMA: Node 0 [mem 0x00000000-0xd7ffffff] + [mem 0x100000000-0x427ffffff] -> [mem 0x00000000-0x427ffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x427fee000-0x427ffffff]
[    0.000000] NODE_DATA(1) allocated [mem 0x827fee000-0x827ffffff]
[    0.000000] NODE_DATA(2) allocated [mem 0xc27fee000-0xc27ffffff]
[    0.000000] NODE_DATA(3) allocated [mem 0x1026feb000-0x1026ffcfff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x0000001026ffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x0000000000098fff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000d7e7ffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x0000000427ffffff]
[    0.000000]   node   1: [mem 0x0000000428000000-0x0000000827ffffff]
[    0.000000]   node   2: [mem 0x0000000828000000-0x0000000c27ffffff]
[    0.000000]   node   3: [mem 0x0000000c28000000-0x0000001026ffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x0000000427ffffff]
[    0.000000] On node 0 totalpages: 4193816
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3992 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 13754 pages used for memmap
[    0.000000]   DMA32 zone: 880256 pages, LIFO batch:31
[    0.000000]   Normal zone: 51712 pages used for memmap
[    0.000000]   Normal zone: 3309568 pages, LIFO batch:31
[    0.000000] Initmem setup node 1 [mem 0x0000000428000000-0x0000000827ffffff]
[    0.000000] On node 1 totalpages: 4194304
[    0.000000]   Normal zone: 65536 pages used for memmap
[    0.000000]   Normal zone: 4194304 pages, LIFO batch:31
[    0.000000] Initmem setup node 2 [mem 0x0000000828000000-0x0000000c27ffffff]
[    0.000000] On node 2 totalpages: 4194304
[    0.000000]   Normal zone: 65536 pages used for memmap
[    0.000000]   Normal zone: 4194304 pages, LIFO batch:31
[    0.000000] Initmem setup node 3 [mem 0x0000000c28000000-0x0000001026ffffff]
[    0.000000] On node 3 totalpages: 4190208
[    0.000000]   Normal zone: 65472 pages used for memmap
[    0.000000]   Normal zone: 4190208 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 0, version 33, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8300 base: 0xfed00000
[    0.000000] smpboot: Allowing 32 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x00099000-0x00099fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009a000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000e5fff]
[    0.000000] PM: Registered nosave memory: [mem 0x000e6000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xd7e80000-0xd7e8dfff]
[    0.000000] PM: Registered nosave memory: [mem 0xd7e8e000-0xd7e8ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xd7e90000-0xd7eb3fff]
[    0.000000] PM: Registered nosave memory: [mem 0xd7eb4000-0xd7edffff]
[    0.000000] PM: Registered nosave memory: [mem 0xd7ee0000-0xd7ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xd8000000-0xdfffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xe0000000-0xefffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf0000000-0xffdfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xffe00000-0xffffffff]
[    0.000000] e820: [mem 0xf0000000-0xffdfffff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:128 nr_cpumask_bits:128 nr_cpu_ids:32 nr_node_ids:4
[    0.000000] percpu: Embedded 37 pages/cpu @ffff880417c00000 s112216 r8192 d31144 u262144
[    0.000000] pcpu-alloc: s112216 r8192 d31144 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [1] 08 09 10 11 12 13 14 15 
[    0.000000] pcpu-alloc: [2] 16 17 18 19 20 21 22 23 [3] 24 25 26 27 28 29 30 31 
[    0.000000] Built 4 zonelists, mobility grouping on.  Total pages: 16510537
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: nokpti BOOT_IMAGE=/boot/bzImage root=/dev/sda2 ro rd.md=0 rd.lvm=0 rd.dm=0 earlyprintk=serial,ttyS2,115200 console=ttyS2,115200 console=tty ignore_loglevel sysrq_always_enabled nmi_watchdog=2 SYSFONT=latarcyrheb-sun16 KEYTABLE=us rd.luks=0 LANG=en_US.UTF-8 debug
[    0.000000] sysrq: sysrq always enabled.
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] AGP: Checking aperture...
[    0.000000] AGP: No AGP bridge found
[    0.000000] AGP: Node 0: aperture [bus addr 0x00000000-0x01ffffff] (32MB)
[    0.000000] AGP: Your BIOS doesn't leave an aperture memory hole
[    0.000000] AGP: Please enable the IOMMU option in the BIOS setup
[    0.000000] AGP: This costs you 64MB of RAM
[    0.000000] AGP: Mapping aperture over RAM [mem 0xcc000000-0xcfffffff] (65536KB)
[    0.000000] PM: Registered nosave memory: [mem 0xcc000000-0xcfffffff]
[    0.000000] Memory: 65861668K/67090528K available (10408K kernel code, 1673K rwdata, 4276K rodata, 1756K init, 4992K bss, 1228860K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=32, Nodes=4
[    0.000000] ftrace: allocating 39238 entries in 154 pages
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=128 to nr_cpu_ids=32.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=32
[    0.000000] NR_IRQS: 8448, nr_irqs: 680, preallocated irqs: 16
[    0.000000] spurious 8259A interrupt: IRQ7.
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] bootconsole [earlyser0] disabled
[    0.000000] console [ttyS2] enabled
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    0.000000] hpet clockevent registered
[    0.001000] tsc: Fast TSC calibration using PIT
[    0.002000] tsc: Detected 2399.961 MHz processor
[    0.003000] Calibrating delay loop (skipped), value calculated using timer frequency.. 4799.92 BogoMIPS (lpj=2399961)
[    0.004003] pid_max: default: 32768 minimum: 301
[    0.005023] ACPI: Core revision 20170728
[    0.010660] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    0.011079] Security Framework initialized
[    0.012003] SELinux:  Initializing.
[    0.013022] SELinux:  Starting in permissive mode
[    0.037958] Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes)
[    0.050059] Inode-cache hash table entries: 4194304 (order: 13, 33554432 bytes)
[    0.051390] Mount-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.053332] Mountpoint-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.055291] CPU: Physical Processor ID: 0
[    0.056002] CPU: Processor Core ID: 0
[    0.057003] mce: CPU supports 7 MCE banks
[    0.058007] LVT offset 1 assigned for vector 0xf9
[    0.059007] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
[    0.060002] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB 0
[    0.061122] Freeing SMP alternatives memory: 44K
[    0.063132] smpboot: Max logical packages: 2
[    0.064013] Switched APIC routing to physical flat.
[    0.065358] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.076000] smpboot: CPU0: AMD Opteron(tm) Processor 6278 (family: 0x15, model: 0x1, stepping: 0x2)
[    0.076138] Performance Events: Fam15h core perfctr, AMD PMU driver.
[    0.077002] ... version:                0
[    0.078001] ... bit width:              48
[    0.079001] ... generic registers:      6
[    0.080001] ... value mask:             0000ffffffffffff
[    0.081001] ... max period:             00007fffffffffff
[    0.082001] ... fixed-purpose events:   0
[    0.083001] ... event mask:             000000000000003f
[    0.084069] Hierarchical SRCU implementation.
[    0.086546] MCE: In-kernel MCE decoding enabled.
[    0.087359] smp: Bringing up secondary CPUs ...
[    0.088106] x86: Booting SMP configuration:
[    0.089002] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7
[    0.524003] .... node  #1, CPUs:    #8  #9 #10 #11 #12 #13 #14 #15
[    1.021003] .... node  #2, CPUs:   #16 #17 #18 #19 #20 #21 #22 #23
[    1.518003] .... node  #3, CPUs:   #24 #25 #26 #27 #28 #29 #30 #31
[    2.014104] smp: Brought up 4 nodes, 32 CPUs
[    2.016002] ----------------
[    2.017001] | NMI testsuite:
[    2.018001] --------------------
[    2.019001]   remote IPI:  ok  |
[    2.020001]    local IPI:  ok  |
[    2.021013] --------------------
[    2.022002] Good, all   2 testcases passed! |
[    2.023001] ---------------------------------
[    2.024006] smpboot: Total of 32 processors activated (153578.75 BogoMIPS)
[    2.030715] devtmpfs: initialized
[    2.031332] PM: Registering ACPI NVS region [mem 0xd7eb4000-0xd7edffff] (180224 bytes)
[    2.032139] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    2.033041] futex hash table entries: 8192 (order: 7, 524288 bytes)
[    2.035102] xor: automatically using best checksumming function   avx       
[    2.036037] RTC time: 14:53:11, date: 12/06/17
[    2.039659] NET: Registered protocol family 16
[    2.040335] cpuidle: using governor ladder
[    2.041011] cpuidle: using governor menu
[    2.043178] ACPI: bus type PCI registered
[    2.044003] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    2.045090] dca service started, version 1.12.1
[    2.046015] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    2.047004] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    2.048017] PCI: Using configuration type 1 for base access
[    2.053250] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    2.054005] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    2.072012] raid6: sse2x1   gen()  2824 MB/s
[    2.090002] raid6: sse2x1   xor()  3550 MB/s
[    2.108002] raid6: sse2x2   gen()  7187 MB/s
[    2.126005] raid6: sse2x2   xor()  5214 MB/s
[    2.144006] raid6: sse2x4   gen()  9121 MB/s
[    2.162005] raid6: sse2x4   xor()  4761 MB/s
[    2.163002] raid6: using algorithm sse2x4 gen() 9121 MB/s
[    2.164001] raid6: .... xor() 4761 MB/s, rmw enabled
[    2.165001] raid6: using ssse3x2 recovery algorithm
[    2.166123] ACPI: Added _OSI(Module Device)
[    2.167002] ACPI: Added _OSI(Processor Device)
[    2.168001] ACPI: Added _OSI(3.0 _SCP Extensions)
[    2.169002] ACPI: Added _OSI(Processor Aggregator Device)
[    2.170174] ACPI: Executed 2 blocks of module-level executable AML code
[    2.181168] ACPI: Interpreter enabled
[    2.182022] ACPI: (supports S0 S1 S4 S5)
[    2.183002] ACPI: Using IOAPIC for interrupt routing
[    2.184059] HEST: Table parsing has been initialized.
[    2.185003] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    2.187140] ACPI: Enabled 5 GPEs in block 00 to 1F
[    2.198836] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-03])
[    2.199006] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    2.200005] acpi PNP0A08:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    2.201355] PCI host bridge to bus 0000:00
[    2.202003] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    2.203002] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    2.204002] pci_bus 0000:00: root bus resource [io  0x03b0-0x03bb window]
[    2.205002] pci_bus 0000:00: root bus resource [io  0x03c0-0x03df window]
[    2.206002] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    2.207002] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    2.208002] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000dffff window]
[    2.209002] pci_bus 0000:00: root bus resource [mem 0xde000000-0xdfffffff window]
[    2.210002] pci_bus 0000:00: root bus resource [mem 0xdd000000-0xddffffff window]
[    2.211002] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed44fff]
[    2.212002] pci_bus 0000:00: root bus resource [bus 00-03]
[    2.213011] pci 0000:00:00.0: [1002:5a10] type 00 class 0x060000
[    2.214140] pci 0000:00:0c.0: [1002:5a20] type 01 class 0x060400
[    2.215019] pci 0000:00:0c.0: enabling Extended Tags
[    2.216023] pci 0000:00:0c.0: PME# supported from D0 D3hot D3cold
[    2.217088] pci 0000:00:0d.0: [1002:5a1e] type 01 class 0x060400
[    2.218018] pci 0000:00:0d.0: enabling Extended Tags
[    2.219036] pci 0000:00:0d.0: PME# supported from D0 D3hot D3cold
[    2.220092] pci 0000:00:11.0: [1002:4390] type 00 class 0x01018f
[    2.221031] pci 0000:00:11.0: reg 0x10: [io  0xc000-0xc007]
[    2.222010] pci 0000:00:11.0: reg 0x14: [io  0xb000-0xb003]
[    2.223017] pci 0000:00:11.0: reg 0x18: [io  0xa000-0xa007]
[    2.224009] pci 0000:00:11.0: reg 0x1c: [io  0x9000-0x9003]
[    2.225009] pci 0000:00:11.0: reg 0x20: [io  0x8000-0x800f]
[    2.226010] pci 0000:00:11.0: reg 0x24: [mem 0xdfdf8400-0xdfdf87ff]
[    2.227022] pci 0000:00:11.0: set SATA to AHCI mode
[    2.228117] pci 0000:00:12.0: [1002:4397] type 00 class 0x0c0310
[    2.229018] pci 0000:00:12.0: reg 0x10: [mem 0xdfdf7000-0xdfdf7fff]
[    2.231030] pci 0000:00:12.1: [1002:4398] type 00 class 0x0c0310
[    2.232018] pci 0000:00:12.1: reg 0x10: [mem 0xdfdf6000-0xdfdf6fff]
[    2.233143] pci 0000:00:12.2: [1002:4396] type 00 class 0x0c0320
[    2.234021] pci 0000:00:12.2: reg 0x10: [mem 0xdfdf8800-0xdfdf88ff]
[    2.235079] pci 0000:00:12.2: supports D1 D2
[    2.236002] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
[    2.237092] pci 0000:00:13.0: [1002:4397] type 00 class 0x0c0310
[    2.238018] pci 0000:00:13.0: reg 0x10: [mem 0xdfdfa000-0xdfdfafff]
[    2.239139] pci 0000:00:13.1: [1002:4398] type 00 class 0x0c0310
[    2.240018] pci 0000:00:13.1: reg 0x10: [mem 0xdfdf9000-0xdfdf9fff]
[    2.241145] pci 0000:00:13.2: [1002:4396] type 00 class 0x0c0320
[    2.242021] pci 0000:00:13.2: reg 0x10: [mem 0xdfdf8c00-0xdfdf8cff]
[    2.243079] pci 0000:00:13.2: supports D1 D2
[    2.244002] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
[    2.245099] pci 0000:00:14.0: [1002:4385] type 00 class 0x0c0500
[    2.246168] pci 0000:00:14.1: [1002:439c] type 00 class 0x01018a
[    2.247020] pci 0000:00:14.1: reg 0x10: [io  0x0000-0x0007]
[    2.248009] pci 0000:00:14.1: reg 0x14: [io  0x0000-0x0003]
[    2.249009] pci 0000:00:14.1: reg 0x18: [io  0x0000-0x0007]
[    2.250009] pci 0000:00:14.1: reg 0x1c: [io  0x0000-0x0003]
[    2.251009] pci 0000:00:14.1: reg 0x20: [io  0xff00-0xff0f]
[    2.252020] pci 0000:00:14.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    2.253002] pci 0000:00:14.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    2.254002] pci 0000:00:14.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    2.255003] pci 0000:00:14.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    2.256101] pci 0000:00:14.3: [1002:439d] type 00 class 0x060100
[    2.257174] pci 0000:00:14.4: [1002:4384] type 01 class 0x060401
[    2.258123] pci 0000:00:14.5: [1002:4399] type 00 class 0x0c0310
[    2.259018] pci 0000:00:14.5: reg 0x10: [mem 0xdfdfb000-0xdfdfbfff]
[    2.260144] pci 0000:00:18.0: [1022:1600] type 00 class 0x060000
[    2.261090] pci 0000:00:18.1: [1022:1601] type 00 class 0x060000
[    2.262005] pci 0000:00:18.1: adding root bus resource [mem 0x1027000000-0xfcffffffff 64bit pref window]
[    2.264001] res->start: 0000001027000000
[    2.265001] res->end:   000000fcffffffff
[    2.266001] base:       10270003
[    2.267001] high:       00000000
[    2.268001] limit:      fd000000
[    2.269001] slot:       1
[    2.270081] pci 0000:00:18.2: [1022:1602] type 00 class 0x060000
[    2.271081] pci 0000:00:18.3: [1022:1603] type 00 class 0x060000
[    2.272083] pci 0000:00:18.4: [1022:1604] type 00 class 0x060000
[    2.273079] pci 0000:00:18.5: [1022:1605] type 00 class 0x060000
[    2.274083] pci 0000:00:19.0: [1022:1600] type 00 class 0x060000
[    2.275089] pci 0000:00:19.1: [1022:1601] type 00 class 0x060000

--yo2353snizqlekop
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci.txt"

00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890 Northbridge only dual slot (2x16) PCI-e GFX Hydra part (rev 02)
	Subsystem: Super Micro Computer Inc Device bc11
	Flags: fast devsel
	Capabilities: <access denied>

00:0c.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890S PCI Express bridge for GPP2 port 1 (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0, IRQ 16
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: dff00000-dfffffff
	Capabilities: <access denied>
	Kernel driver in use: pcieport

00:0d.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890 PCI to PCI bridge (external gfx1 port B) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0, IRQ 17
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: dfe00000-dfefffff
	Capabilities: <access denied>
	Kernel driver in use: pcieport

00:11.0 SATA controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 SATA Controller [IDE mode] (prog-if 01 [AHCI 1.0])
	Subsystem: Super Micro Computer Inc Device bc11
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 22
	I/O ports at c000 [size=8]
	I/O ports at b000 [size=4]
	I/O ports at a000 [size=8]
	I/O ports at 9000 [size=4]
	I/O ports at 8000 [size=16]
	Memory at dfdf8400 (32-bit, non-prefetchable) [size=1K]
	Capabilities: <access denied>
	Kernel driver in use: ahci

00:12.0 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI0 Controller (prog-if 10 [OHCI])
	Subsystem: Super Micro Computer Inc Device bc11
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 16
	Memory at dfdf7000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: ohci-pci

00:12.1 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0 USB OHCI1 Controller (prog-if 10 [OHCI])
	Subsystem: Super Micro Computer Inc Device bc11
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 16
	Memory at dfdf6000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: ohci-pci

00:12.2 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB EHCI Controller (prog-if 20 [EHCI])
	Subsystem: Super Micro Computer Inc Device bc11
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 17
	Memory at dfdf8800 (32-bit, non-prefetchable) [size=256]
	Capabilities: <access denied>
	Kernel driver in use: ehci-pci

00:13.0 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI0 Controller (prog-if 10 [OHCI])
	Subsystem: Super Micro Computer Inc Device bc11
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 18
	Memory at dfdfa000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: ohci-pci

00:13.1 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0 USB OHCI1 Controller (prog-if 10 [OHCI])
	Subsystem: Super Micro Computer Inc Device bc11
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 18
	Memory at dfdf9000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: ohci-pci

00:13.2 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB EHCI Controller (prog-if 20 [EHCI])
	Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB EHCI Controller
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 19
	Memory at dfdf8c00 (32-bit, non-prefetchable) [size=256]
	Capabilities: <access denied>
	Kernel driver in use: ehci-pci

00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 SMBus Controller (rev 3d)
	Subsystem: Super Micro Computer Inc Device bc11
	Flags: 66MHz, medium devsel
	Capabilities: <access denied>
	Kernel driver in use: piix4_smbus

00:14.1 IDE interface: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 IDE Controller (prog-if 8a [Master SecP PriP])
	Subsystem: Super Micro Computer Inc Device bc11
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 16
	I/O ports at 01f0 [size=8]
	I/O ports at 03f4
	I/O ports at 0170 [size=8]
	I/O ports at 0374
	I/O ports at ff00 [size=16]
	Capabilities: <access denied>
	Kernel driver in use: pata_atiixp

00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 LPC host controller
	Subsystem: Super Micro Computer Inc Device bc11
	Flags: bus master, 66MHz, medium devsel, latency 0

00:14.4 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 PCI to PCI Bridge (prog-if 01 [Subtractive decode])
	Flags: bus master, 66MHz, medium devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	Memory behind bridge: def00000-df7fffff
	Prefetchable memory behind bridge: dd000000-ddffffff

00:14.5 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI2 Controller (prog-if 10 [OHCI])
	Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Device 4396
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 18
	Memory at dfdfb000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: ohci-pci

00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 0
	Flags: fast devsel
	Capabilities: <access denied>

00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 1
	Flags: fast devsel

00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 2
	Flags: fast devsel

00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 3
	Flags: fast devsel
	Capabilities: <access denied>
	Kernel driver in use: k10temp

00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 4
	Flags: fast devsel
	Kernel driver in use: fam15h_power

00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 5
	Flags: fast devsel

00:19.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 0
	Flags: fast devsel
	Capabilities: <access denied>

00:19.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 1
	Flags: fast devsel

00:19.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 2
	Flags: fast devsel

00:19.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 3
	Flags: fast devsel
	Capabilities: <access denied>
	Kernel driver in use: k10temp

00:19.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 4
	Flags: fast devsel

00:19.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 5
	Flags: fast devsel

00:1a.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 0
	Flags: fast devsel
	Capabilities: <access denied>

00:1a.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 1
	Flags: fast devsel

00:1a.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 2
	Flags: fast devsel

00:1a.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 3
	Flags: fast devsel
	Capabilities: <access denied>
	Kernel driver in use: k10temp

00:1a.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 4
	Flags: fast devsel
	Kernel driver in use: fam15h_power

00:1a.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 5
	Flags: fast devsel

00:1b.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 0
	Flags: fast devsel
	Capabilities: <access denied>

00:1b.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 1
	Flags: fast devsel

00:1b.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 2
	Flags: fast devsel

00:1b.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 3
	Flags: fast devsel
	Capabilities: <access denied>
	Kernel driver in use: k10temp

00:1b.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 4
	Flags: fast devsel

00:1b.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 5
	Flags: fast devsel

01:04.0 VGA compatible controller: Matrox Electronics Systems Ltd. MGA G200eW WPCM450 (rev 0a) (prog-if 00 [VGA controller])
	Subsystem: Super Micro Computer Inc Device bc11
	Flags: bus master, medium devsel, latency 64, IRQ 10
	Memory at dd000000 (32-bit, prefetchable) [size=16M]
	Memory at deffc000 (32-bit, non-prefetchable) [size=16K]
	Memory at df000000 (32-bit, non-prefetchable) [size=8M]
	[virtual] Expansion ROM at 000c0000 [disabled] [size=128K]
	Capabilities: <access denied>

02:00.0 Ethernet controller: Intel Corporation 82576 Gigabit Network Connection (rev 01)
	Subsystem: Super Micro Computer Inc Device 10c9
	Flags: bus master, fast devsel, latency 0, IRQ 17
	Memory at dfee0000 (32-bit, non-prefetchable) [size=128K]
	Memory at dfec0000 (32-bit, non-prefetchable) [size=128K]
	I/O ports at d800 [size=32]
	Memory at dfe9c000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at dfea0000 [disabled] [size=128K]
	Capabilities: <access denied>
	Kernel driver in use: igb

02:00.1 Ethernet controller: Intel Corporation 82576 Gigabit Network Connection (rev 01)
	Subsystem: Super Micro Computer Inc Device 10c9
	Flags: bus master, fast devsel, latency 0, IRQ 18
	Memory at dfe60000 (32-bit, non-prefetchable) [size=128K]
	Memory at dfe40000 (32-bit, non-prefetchable) [size=128K]
	I/O ports at d400 [size=32]
	Memory at dfe1c000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at dfe20000 [disabled] [size=128K]
	Capabilities: <access denied>
	Kernel driver in use: igb

03:00.0 Serial Attached SCSI controller: LSI Logic / Symbios Logic SAS2008 PCI-Express Fusion-MPT SAS-2 [Falcon] (rev 03)
	Subsystem: Super Micro Computer Inc Device 0400
	Flags: bus master, fast devsel, latency 0, IRQ 16
	I/O ports at e000 [size=256]
	Memory at dff3c000 (64-bit, non-prefetchable) [size=16K]
	Memory at dff40000 (64-bit, non-prefetchable) [size=256K]
	Expansion ROM at dff80000 [disabled] [size=512K]
	Capabilities: <access denied>
	Kernel driver in use: mpt3sas

40:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890 Northbridge only dual slot (2x16) PCI-e GFX Hydra part (rev 02)
	Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] RD890 Northbridge only dual slot (2x16) PCI-e GFX Hydra part
	Flags: fast devsel
	Capabilities: <access denied>


--yo2353snizqlekop
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="boot.log"

[    0.000000] Linux version 4.15.0-rc2-00394-gc4260477990a-dirty (mingo@fomalhaut) (gcc version 5.3.1 20160406 (Red Hat 5.3.1-6) (GCC)) #28 SMP Wed Dec 6 17:02:38 CET 2017
[    0.000000] Command line: BOOT_IMAGE=/boot/bzImage root=/dev/sda2 ro rd.md=0 rd.lvm=0 rd.dm=0 earlyprintk=serial,ttyS2,115200 console=ttyS2,115200 console=tty ignore_loglevel sysrq_always_enabled nmi_watchdog=2 SYSFONT=latarcyrheb-sun16 KEYTABLE=us rd.luks=0 LANG=en_US.UTF-8 debug
[    0.000000] random: get_random_u32 called from bsp_init_amd+0x17b/0x230 with crng_init=0
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x00000000000997ff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000099800-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e6000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000d7e7ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000d7e8e000-0x00000000d7e8ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000d7e90000-0x00000000d7eb3fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000d7eb4000-0x00000000d7edffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000d7ee0000-0x00000000d7ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffe00000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x0000001026ffffff] usable
[    0.000000] bootconsole [earlyser0] enabled
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] random: fast init done
[    0.000000] SMBIOS 2.6 present.
[    0.000000] DMI: Supermicro H8DG6/H8DGi/H8DG6/H8DGi, BIOS 2.0b       03/01/2012
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] AGP: No AGP bridge found
[    0.000000] e820: last_pfn = 0x1027000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-EFFFF uncachable
[    0.000000]   F0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000000 mask FFFF80000000 write-back
[    0.000000]   1 base 000080000000 mask FFFFC0000000 write-back
[    0.000000]   2 base 0000C0000000 mask FFFFF0000000 write-back
[    0.000000]   3 base 0000D0000000 mask FFFFF8000000 write-back
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] TOM2: 0000001027000000 aka 66160M
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000000] e820: update [mem 0xd8000000-0xffffffff] usable ==> reserved
[    0.000000] e820: last_pfn = 0xd7e80 max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000ff780-0x000ff78f] mapped at [        (ptrval)]
[    0.000000] Base memory trampoline at [        (ptrval)] 93000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x03011000, 0x03011fff] PGTABLE
[    0.000000] BRK [0x03012000, 0x03012fff] PGTABLE
[    0.000000] BRK [0x03013000, 0x03013fff] PGTABLE
[    0.000000] BRK [0x03014000, 0x03014fff] PGTABLE
[    0.000000] RAMDISK: [mem 0x35f96000-0x36fc2fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000FA5D0 000024 (v02 ACPIAM)
[    0.000000] ACPI: XSDT 0x00000000D7E90100 000084 (v01 SMCI            20120301 MSFT 00000097)
[    0.000000] ACPI: FACP 0x00000000D7E90290 0000F4 (v03 030112 FACP1736 20120301 MSFT 00000097)
[    0.000000] ACPI BIOS Warning (bug): 32/64X length mismatch in FADT/Gpe0Block: 64/32 (20170831/tbfadt-603)
[    0.000000] ACPI: DSDT 0x00000000D7E906B0 006F89 (v01 1BC11  1BC11000 00000000 INTL 20051117)
[    0.000000] ACPI: FACS 0x00000000D7EB4000 000040
[    0.000000] ACPI: FACS 0x00000000D7EB4000 000040
[    0.000000] ACPI: APIC 0x00000000D7E90390 000158 (v01 030112 APIC1736 20120301 MSFT 00000097)
[    0.000000] ACPI: MCFG 0x00000000D7E904F0 00003C (v01 030112 OEMMCFG  20120301 MSFT 00000097)
[    0.000000] ACPI: OEMB 0x00000000D7EB4040 0000BC (v01 030112 OEMB1736 20120301 MSFT 00000097)
[    0.000000] ACPI: HPET 0x00000000D7E9A6B0 000038 (v01 030112 OEMHPET  20120301 MSFT 00000097)
[    0.000000] ACPI: SRAT 0x00000000D7E9A6F0 000320 (v02 AMD    AGESA    00000001 AMD  00000001)
[    0.000000] ACPI: SLIT 0x00000000D7E9AA10 00003C (v01 AMD    AGESA    00000001 AMD  00000001)
[    0.000000] ACPI: SSDT 0x00000000D7E9AA50 005BE4 (v01 A M I  POWERNOW 00000001 AMD  00000001)
[    0.000000] ACPI: EINJ 0x00000000D7EA0640 000130 (v01 AMIER  AMI_EINJ 20120301 MSFT 00000097)
[    0.000000] ACPI: BERT 0x00000000D7EA07D0 000030 (v01 AMIER  AMI_BERT 20120301 MSFT 00000097)
[    0.000000] ACPI: ERST 0x00000000D7EA0800 0001B0 (v01 AMIER  AMI_ERST 20120301 MSFT 00000097)
[    0.000000] ACPI: HEST 0x00000000D7EA09B0 0000A8 (v01 AMIER  ABC_HEST 20120301 MSFT 00000097)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] SRAT: PXM 0 -> APIC 0x20 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x21 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x22 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x23 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x24 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x25 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x26 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x27 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x28 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x29 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x2a -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x2b -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x2c -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x2d -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x2e -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x2f -> Node 1
[    0.000000] SRAT: PXM 2 -> APIC 0x40 -> Node 2
[    0.000000] SRAT: PXM 2 -> APIC 0x41 -> Node 2
[    0.000000] SRAT: PXM 2 -> APIC 0x42 -> Node 2
[    0.000000] SRAT: PXM 2 -> APIC 0x43 -> Node 2
[    0.000000] SRAT: PXM 2 -> APIC 0x44 -> Node 2
[    0.000000] SRAT: PXM 2 -> APIC 0x45 -> Node 2
[    0.000000] SRAT: PXM 2 -> APIC 0x46 -> Node 2
[    0.000000] SRAT: PXM 2 -> APIC 0x47 -> Node 2
[    0.000000] SRAT: PXM 3 -> APIC 0x48 -> Node 3
[    0.000000] SRAT: PXM 3 -> APIC 0x49 -> Node 3
[    0.000000] SRAT: PXM 3 -> APIC 0x4a -> Node 3
[    0.000000] SRAT: PXM 3 -> APIC 0x4b -> Node 3
[    0.000000] SRAT: PXM 3 -> APIC 0x4c -> Node 3
[    0.000000] SRAT: PXM 3 -> APIC 0x4d -> Node 3
[    0.000000] SRAT: PXM 3 -> APIC 0x4e -> Node 3
[    0.000000] SRAT: PXM 3 -> APIC 0x4f -> Node 3
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x00100000-0xd7ffffff]
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x427ffffff]
[    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x428000000-0x827ffffff]
[    0.000000] ACPI: SRAT: Node 2 PXM 2 [mem 0x828000000-0xc27ffffff]
[    0.000000] ACPI: SRAT: Node 3 PXM 3 [mem 0xc28000000-0x1026ffffff]
[    0.000000] NUMA: Initialized distance table, cnt=4
[    0.000000] NUMA: Node 0 [mem 0x00000000-0x0009ffff] + [mem 0x00100000-0xd7ffffff] -> [mem 0x00000000-0xd7ffffff]
[    0.000000] NUMA: Node 0 [mem 0x00000000-0xd7ffffff] + [mem 0x100000000-0x427ffffff] -> [mem 0x00000000-0x427ffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x427fee000-0x427ffffff]
[    0.000000] NODE_DATA(1) allocated [mem 0x827fee000-0x827ffffff]
[    0.000000] NODE_DATA(2) allocated [mem 0xc27fee000-0xc27ffffff]
[    0.000000] NODE_DATA(3) allocated [mem 0x1026feb000-0x1026ffcfff]
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x0000001026ffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x0000000000098fff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000d7e7ffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x0000000427ffffff]
[    0.000000]   node   1: [mem 0x0000000428000000-0x0000000827ffffff]
[    0.000000]   node   2: [mem 0x0000000828000000-0x0000000c27ffffff]
[    0.000000]   node   3: [mem 0x0000000c28000000-0x0000001026ffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x0000000427ffffff]
[    0.000000] On node 0 totalpages: 4193816
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3992 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 13754 pages used for memmap
[    0.000000]   DMA32 zone: 880256 pages, LIFO batch:31
[    0.000000]   Normal zone: 51712 pages used for memmap
[    0.000000]   Normal zone: 3309568 pages, LIFO batch:31
[    0.000000] Initmem setup node 1 [mem 0x0000000428000000-0x0000000827ffffff]
[    0.000000] On node 1 totalpages: 4194304
[    0.000000]   Normal zone: 65536 pages used for memmap
[    0.000000]   Normal zone: 4194304 pages, LIFO batch:31
[    0.000000] Initmem setup node 2 [mem 0x0000000828000000-0x0000000c27ffffff]
[    0.000000] On node 2 totalpages: 4194304
[    0.000000]   Normal zone: 65536 pages used for memmap
[    0.000000]   Normal zone: 4194304 pages, LIFO batch:31
[    0.000000] Initmem setup node 3 [mem 0x0000000c28000000-0x0000001026ffffff]
[    0.000000] On node 3 totalpages: 4190208
[    0.000000]   Normal zone: 65472 pages used for memmap
[    0.000000]   Normal zone: 4190208 pages, LIFO batch:31
[    0.000000] Reserved but unavailable: 104 pages
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 0, version 33, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8300 base: 0xfed00000
[    0.000000] smpboot: Allowing 32 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x00099000-0x00099fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009a000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000e5fff]
[    0.000000] PM: Registered nosave memory: [mem 0x000e6000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xd7e80000-0xd7e8dfff]
[    0.000000] PM: Registered nosave memory: [mem 0xd7e8e000-0xd7e8ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xd7e90000-0xd7eb3fff]
[    0.000000] PM: Registered nosave memory: [mem 0xd7eb4000-0xd7edffff]
[    0.000000] PM: Registered nosave memory: [mem 0xd7ee0000-0xd7ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xd8000000-0xdfffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xe0000000-0xefffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf0000000-0xffdfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xffe00000-0xffffffff]
[    0.000000] e820: [mem 0xf0000000-0xffdfffff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:128 nr_cpumask_bits:128 nr_cpu_ids:32 nr_node_ids:4
[    0.000000] percpu: Embedded 44 pages/cpu @        (ptrval) s141848 r8192 d30184 u262144
[    0.000000] pcpu-alloc: s141848 r8192 d30184 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [1] 08 09 10 11 12 13 14 15 
[    0.000000] pcpu-alloc: [2] 16 17 18 19 20 21 22 23 [3] 24 25 26 27 28 29 30 31 
[    0.000000] Built 4 zonelists, mobility grouping on.  Total pages: 16510537
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: nokpti BOOT_IMAGE=/boot/bzImage root=/dev/sda2 ro rd.md=0 rd.lvm=0 rd.dm=0 earlyprintk=serial,ttyS2,115200 console=ttyS2,115200 console=tty ignore_loglevel sysrq_always_enabled nmi_watchdog=2 SYSFONT=latarcyrheb-sun16 KEYTABLE=us rd.luks=0 LANG=en_US.UTF-8 debug
[    0.000000] sysrq: sysrq always enabled.
[    0.000000] AGP: Checking aperture...
[    0.000000] AGP: No AGP bridge found
[    0.000000] AGP: Node 0: aperture [bus addr 0x00000000-0x01ffffff] (32MB)
[    0.000000] AGP: Your BIOS doesn't leave an aperture memory hole
[    0.000000] AGP: Please enable the IOMMU option in the BIOS setup
[    0.000000] AGP: This costs you 64MB of RAM
[    0.000000] AGP: Mapping aperture over RAM [mem 0xcc000000-0xcfffffff] (65536KB)
[    0.000000] PM: Registered nosave memory: [mem 0xcc000000-0xcfffffff]
[    0.000000] Memory: 65854920K/67090528K available (12316K kernel code, 1680K rwdata, 4308K rodata, 1772K init, 4980K bss, 1235608K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=32, Nodes=4
[    0.000000] ftrace: allocating 39587 entries in 155 pages
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=128 to nr_cpu_ids=32.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=32
[    0.000000] NR_IRQS: 8448, nr_irqs: 680, preallocated irqs: 16
[    0.000000] spurious 8259A interrupt: IRQ7.
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] bootconsole [earlyser0] disabled
[    0.000000] console [ttyS2] enabled
[    0.000000] ACPI: Core revision 20170831
[    0.000000] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    0.000000] hpet clockevent registered
[    0.001000] APIC: Switch to symmetric I/O mode setup
[    0.002000] Switched APIC routing to physical flat.
[    0.003000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.008000] tsc: Fast TSC calibration using PIT
[    0.009000] tsc: Detected 2399.902 MHz processor
[    0.010000] Calibrating delay loop (skipped), value calculated using timer frequency.. 4799.80 BogoMIPS (lpj=2399902)
[    0.011001] pid_max: default: 32768 minimum: 301
[    0.012094] Security Framework initialized
[    0.013002] SELinux:  Initializing.
[    0.014022] SELinux:  Starting in permissive mode
[    0.037750] Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes)
[    0.048875] Inode-cache hash table entries: 4194304 (order: 13, 33554432 bytes)
[    0.049378] Mount-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.051247] Mountpoint-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.053272] CPU: Physical Processor ID: 0
[    0.054001] CPU: Processor Core ID: 0
[    0.055002] mce: CPU supports 7 MCE banks
[    0.056006] LVT offset 1 assigned for vector 0xf9
[    0.057006] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
[    0.058001] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB 0
[    0.059115] Freeing SMP alternatives memory: 44K
[    0.062000] smpboot: CPU0: AMD Opteron(tm) Processor 6278 (family: 0x15, model: 0x1, stepping: 0x2)
[    0.062143] Performance Events: Fam15h core perfctr, AMD PMU driver.
[    0.063002] ... version:                0
[    0.064001] ... bit width:              48
[    0.065001] ... generic registers:      6
[    0.066001] ... value mask:             0000ffffffffffff
[    0.067001] ... max period:             00007fffffffffff
[    0.068001] ... fixed-purpose events:   0
[    0.069001] ... event mask:             000000000000003f
[    0.070067] Hierarchical SRCU implementation.
[    0.072528] MCE: In-kernel MCE decoding enabled.
[    0.073353] smp: Bringing up secondary CPUs ...
[    0.074107] x86: Booting SMP configuration:
[    0.075002] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7
[    0.092003] .... node  #1, CPUs:    #8  #9 #10 #11 #12 #13 #14 #15
[    0.112002] .... node  #2, CPUs:   #16 #17 #18 #19 #20 #21 #22 #23
[    0.191002] .... node  #3, CPUs:   #24 #25 #26 #27 #28 #29 #30 #31
[    0.210108] smp: Brought up 4 nodes, 32 CPUs
[    0.212002] smpboot: Max logical packages: 2
[    0.213002] ----------------
[    0.214001] | NMI testsuite:
[    0.215001] --------------------
[    0.216001]   remote IPI:  ok  |
[    0.217001]    local IPI:  ok  |
[    0.218008] --------------------
[    0.219001] Good, all   2 testcases passed! |
[    0.220001] ---------------------------------
[    0.221006] smpboot: Total of 32 processors activated (153586.49 BogoMIPS)
[    0.228553] devtmpfs: initialized
[    0.229294] PM: Registering ACPI NVS region [mem 0xd7eb4000-0xd7edffff] (180224 bytes)
[    0.230151] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.231036] futex hash table entries: 8192 (order: 7, 524288 bytes)
[    0.232350] xor: automatically using best checksumming function   avx       
[    0.233038] RTC time: 15:00:17, date: 12/06/17
[    0.236132] NET: Registered protocol family 16
[    0.237203] audit: initializing netlink subsys (disabled)
[    0.238033] audit: type=2000 audit(1512572415.238:1): state=initialized audit_enabled=0 res=1
[    0.247009] cpuidle: using governor ladder
[    0.251049] cpuidle: using governor menu
[    0.256183] ACPI: bus type PCI registered
[    0.260003] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.267111] dca service started, version 1.12.1
[    0.271015] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.281003] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    0.288016] PCI: Using configuration type 1 for base access
[    0.298061] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.305006] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.328644] raid6: sse2x1   gen()  2253 MB/s
[    0.349634] raid6: sse2x1   xor()  3326 MB/s
[    0.370631] raid6: sse2x2   gen()  6957 MB/s
[    0.391628] raid6: sse2x2   xor()  5150 MB/s
[    0.412632] raid6: sse2x4   gen()  8691 MB/s
[    0.433633] raid6: sse2x4   xor()  3175 MB/s
[    0.438002] raid6: using algorithm sse2x4 gen() 8691 MB/s
[    0.443001] raid6: .... xor() 3175 MB/s, rmw enabled
[    0.449002] raid6: using ssse3x2 recovery algorithm
[    0.454132] ACPI: Added _OSI(Module Device)
[    0.458002] ACPI: Added _OSI(Processor Device)
[    0.463002] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.468001] ACPI: Added _OSI(Processor Aggregator Device)
[    0.473209] ACPI: Executed 2 blocks of module-level executable AML code
[    0.489743] ACPI: Interpreter enabled
[    0.490021] ACPI: (supports S0 S1 S4 S5)
[    0.491002] ACPI: Using IOAPIC for interrupt routing
[    0.492061] HEST: Table parsing has been initialized.
[    0.493003] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.494278] ACPI: Enabled 5 GPEs in block 00 to 1F
[    0.506362] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-03])
[    0.507006] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.508005] acpi PNP0A08:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.510262] PCI host bridge to bus 0000:00
[    0.511003] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.512004] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.513002] pci_bus 0000:00: root bus resource [io  0x03b0-0x03bb window]
[    0.514002] pci_bus 0000:00: root bus resource [io  0x03c0-0x03df window]
[    0.515002] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.516002] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.517002] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000dffff window]
[    0.518002] pci_bus 0000:00: root bus resource [mem 0xde000000-0xdfffffff window]
[    0.519002] pci_bus 0000:00: root bus resource [mem 0xdd000000-0xddffffff window]
[    0.520002] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed44fff]
[    0.521002] pci_bus 0000:00: root bus resource [bus 00-03]
[    0.522012] pci 0000:00:00.0: [1002:5a10] type 00 class 0x060000
[    0.524139] pci 0000:00:0c.0: [1002:5a20] type 01 class 0x060400
[    0.525019] pci 0000:00:0c.0: enabling Extended Tags
[    0.526023] pci 0000:00:0c.0: PME# supported from D0 D3hot D3cold
[    0.527086] pci 0000:00:0d.0: [1002:5a1e] type 01 class 0x060400
[    0.529003] pci 0000:00:0d.0: enabling Extended Tags
[    0.530023] pci 0000:00:0d.0: PME# supported from D0 D3hot D3cold
[    0.531098] pci 0000:00:11.0: [1002:4390] type 00 class 0x01018f
[    0.532044] pci 0000:00:11.0: reg 0x10: [io  0xc000-0xc007]
[    0.533009] pci 0000:00:11.0: reg 0x14: [io  0xb000-0xb003]
[    0.534009] pci 0000:00:11.0: reg 0x18: [io  0xa000-0xa007]
[    0.535010] pci 0000:00:11.0: reg 0x1c: [io  0x9000-0x9003]
[    0.536010] pci 0000:00:11.0: reg 0x20: [io  0x8000-0x800f]
[    0.537010] pci 0000:00:11.0: reg 0x24: [mem 0xdfdf8400-0xdfdf87ff]
[    0.538022] pci 0000:00:11.0: set SATA to AHCI mode
[    0.539106] pci 0000:00:12.0: [1002:4397] type 00 class 0x0c0310
[    0.540018] pci 0000:00:12.0: reg 0x10: [mem 0xdfdf7000-0xdfdf7fff]
[    0.541136] pci 0000:00:12.1: [1002:4398] type 00 class 0x0c0310
[    0.542018] pci 0000:00:12.1: reg 0x10: [mem 0xdfdf6000-0xdfdf6fff]
[    0.543137] pci 0000:00:12.2: [1002:4396] type 00 class 0x0c0320
[    0.544021] pci 0000:00:12.2: reg 0x10: [mem 0xdfdf8800-0xdfdf88ff]
[    0.546067] pci 0000:00:12.2: supports D1 D2
[    0.547002] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
[    0.548087] pci 0000:00:13.0: [1002:4397] type 00 class 0x0c0310
[    0.549021] pci 0000:00:13.0: reg 0x10: [mem 0xdfdfa000-0xdfdfafff]
[    0.550132] pci 0000:00:13.1: [1002:4398] type 00 class 0x0c0310
[    0.551018] pci 0000:00:13.1: reg 0x10: [mem 0xdfdf9000-0xdfdf9fff]
[    0.552140] pci 0000:00:13.2: [1002:4396] type 00 class 0x0c0320
[    0.553021] pci 0000:00:13.2: reg 0x10: [mem 0xdfdf8c00-0xdfdf8cff]
[    0.554080] pci 0000:00:13.2: supports D1 D2
[    0.555002] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
[    0.556089] pci 0000:00:14.0: [1002:4385] type 00 class 0x0c0500
[    0.557165] pci 0000:00:14.1: [1002:439c] type 00 class 0x01018a
[    0.558020] pci 0000:00:14.1: reg 0x10: [io  0x0000-0x0007]
[    0.559009] pci 0000:00:14.1: reg 0x14: [io  0x0000-0x0003]
[    0.560011] pci 0000:00:14.1: reg 0x18: [io  0x0000-0x0007]
[    0.561009] pci 0000:00:14.1: reg 0x1c: [io  0x0000-0x0003]
[    0.562009] pci 0000:00:14.1: reg 0x20: [io  0xff00-0xff0f]
[    0.564020] pci 0000:00:14.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.565002] pci 0000:00:14.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.566002] pci 0000:00:14.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.567002] pci 0000:00:14.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.568123] pci 0000:00:14.3: [1002:439d] type 00 class 0x060100
[    0.570123] pci 0000:00:14.4: [1002:4384] type 01 class 0x060401
[    0.571122] pci 0000:00:14.5: [1002:4399] type 00 class 0x0c0310
[    0.572018] pci 0000:00:14.5: reg 0x10: [mem 0xdfdfb000-0xdfdfbfff]
[    0.574136] pci 0000:00:18.0: [1022:1600] type 00 class 0x060000
[    0.575086] pci 0000:00:18.1: [1022:1601] type 00 class 0x060000
[    0.576080] pci 0000:00:18.2: [1022:1602] type 00 class 0x060000
[    0.577078] pci 0000:00:18.3: [1022:1603] type 00 class 0x060000
[    0.578089] pci 0000:00:18.4: [1022:1604] type 00 class 0x060000
[    0.579077] pci 0000:00:18.5: [1022:1605] type 00 class 0x060000
[    0.580079] pci 0000:00:19.0: [1022:1600] type 00 class 0x060000
[    0.581087] pci 0000:00:19.1: [1022:1601] type 00 class 0x060000
[    0.583060] pci 0000:00:19.2: [1022:1602] type 00 class 0x060000
[    0.584079] pci 0000:00:19.3: [1022:1603] type 00 class 0x060000
[    0.585084] pci 0000:00:19.4: [1022:1604] type 00 class 0x060000
[    0.586079] pci 0000:00:19.5: [1022:1605] type 00 class 0x060000
[    0.588039] pci 0000:00:1a.0: [1022:1600] type 00 class 0x060000
[    0.589090] pci 0000:00:1a.1: [1022:1601] type 00 class 0x060000
[    0.590079] pci 0000:00:1a.2: [1022:1602] type 00 class 0x060000
[    0.591080] pci 0000:00:1a.3: [1022:1603] type 00 class 0x060000
[    0.593006] pci 0000:00:1a.4: [1022:1604] type 00 class 0x060000
[    0.594079] pci 0000:00:1a.5: [1022:1605] type 00 class 0x060000
[    0.595082] pci 0000:00:1b.0: [1022:1600] type 00 class 0x060000
[    0.596087] pci 0000:00:1b.1: [1022:1601] type 00 class 0x060000
[    0.597083] pci 0000:00:1b.2: [1022:1602] type 00 class 0x060000
[    0.598080] pci 0000:00:1b.3: [1022:1603] type 00 class 0x060000
[    0.599085] pci 0000:00:1b.4: [1022:1604] type 00 class 0x060000
[    0.600079] pci 0000:00:1b.5: [1022:1605] type 00 class 0x060000
[    0.601124] pci 0000:03:00.0: [1000:0072] type 00 class 0x010700
[    0.602037] pci 0000:03:00.0: reg 0x10: [io  0xe000-0xe0ff]
[    0.603010] pci 0000:03:00.0: reg 0x14: [mem 0xdff3c000-0xdff3ffff 64bit]
[    0.604009] pci 0000:03:00.0: reg 0x1c: [mem 0xdff40000-0xdff7ffff 64bit]
[    0.605011] pci 0000:03:00.0: reg 0x30: [mem 0xdff80000-0xdfffffff pref]
[    0.606005] pci 0000:03:00.0: enabling Extended Tags
[    0.607040] pci 0000:03:00.0: supports D1 D2
[    0.608019] pci 0000:03:00.0: reg 0x174: [mem 0x00000000-0x00003fff 64bit]
[    0.609003] pci 0000:03:00.0: VF(n) BAR0 space: [mem 0x00000000-0x0003ffff 64bit] (contains BAR0 for 16 VFs)
[    0.610032] pci 0000:03:00.0: reg 0x17c: [mem 0x00000000-0x0003ffff 64bit]
[    0.611002] pci 0000:03:00.0: VF(n) BAR2 space: [mem 0x00000000-0x003fffff 64bit] (contains BAR2 for 16 VFs)
[    0.615015] pci 0000:00:0c.0: PCI bridge to [bus 03]
[    0.616005] pci 0000:00:0c.0:   bridge window [io  0xe000-0xefff]
[    0.617003] pci 0000:00:0c.0:   bridge window [mem 0xdff00000-0xdfffffff]
[    0.618068] pci 0000:02:00.0: [8086:10c9] type 00 class 0x020000
[    0.619021] pci 0000:02:00.0: reg 0x10: [mem 0xdfee0000-0xdfefffff]
[    0.621009] pci 0000:02:00.0: reg 0x14: [mem 0xdfec0000-0xdfedffff]
[    0.622009] pci 0000:02:00.0: reg 0x18: [io  0xd800-0xd81f]
[    0.623008] pci 0000:02:00.0: reg 0x1c: [mem 0xdfe9c000-0xdfe9ffff]
[    0.624021] pci 0000:02:00.0: reg 0x30: [mem 0xdfea0000-0xdfebffff pref]
[    0.625056] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.626029] pci 0000:02:00.0: reg 0x184: [mem 0x00000000-0x00003fff 64bit]
[    0.627002] pci 0000:02:00.0: VF(n) BAR0 space: [mem 0x00000000-0x0001ffff 64bit] (contains BAR0 for 8 VFs)
[    0.628017] pci 0000:02:00.0: reg 0x190: [mem 0x00000000-0x00003fff 64bit]
[    0.629003] pci 0000:02:00.0: VF(n) BAR3 space: [mem 0x00000000-0x0001ffff 64bit] (contains BAR3 for 8 VFs)
[    0.631015] pci 0000:02:00.1: [8086:10c9] type 00 class 0x020000
[    0.632021] pci 0000:02:00.1: reg 0x10: [mem 0xdfe60000-0xdfe7ffff]
[    0.633008] pci 0000:02:00.1: reg 0x14: [mem 0xdfe40000-0xdfe5ffff]
[    0.634008] pci 0000:02:00.1: reg 0x18: [io  0xd400-0xd41f]
[    0.635008] pci 0000:02:00.1: reg 0x1c: [mem 0xdfe1c000-0xdfe1ffff]
[    0.636021] pci 0000:02:00.1: reg 0x30: [mem 0xdfe20000-0xdfe3ffff pref]
[    0.637054] pci 0000:02:00.1: PME# supported from D0 D3hot D3cold
[    0.638025] pci 0000:02:00.1: reg 0x184: [mem 0x00000000-0x00003fff 64bit]
[    0.639002] pci 0000:02:00.1: VF(n) BAR0 space: [mem 0x00000000-0x0001ffff 64bit] (contains BAR0 for 8 VFs)
[    0.640016] pci 0000:02:00.1: reg 0x190: [mem 0x00000000-0x00003fff 64bit]
[    0.641002] pci 0000:02:00.1: VF(n) BAR3 space: [mem 0x00000000-0x0001ffff 64bit] (contains BAR3 for 8 VFs)
[    0.645017] pci 0000:00:0d.0: PCI bridge to [bus 02]
[    0.646004] pci 0000:00:0d.0:   bridge window [io  0xd000-0xdfff]
[    0.647003] pci 0000:00:0d.0:   bridge window [mem 0xdfe00000-0xdfefffff]
[    0.648051] pci 0000:01:04.0: [102b:0532] type 00 class 0x030000
[    0.649026] pci 0000:01:04.0: reg 0x10: [mem 0xdd000000-0xddffffff pref]
[    0.650012] pci 0000:01:04.0: reg 0x14: [mem 0xdeffc000-0xdeffffff]
[    0.651014] pci 0000:01:04.0: reg 0x18: [mem 0xdf000000-0xdf7fffff]
[    0.652176] pci 0000:00:14.4: PCI bridge to [bus 01] (subtractive decode)
[    0.653006] pci 0000:00:14.4:   bridge window [mem 0xdef00000-0xdf7fffff]
[    0.654004] pci 0000:00:14.4:   bridge window [mem 0xdd000000-0xddffffff pref]
[    0.655002] pci 0000:00:14.4:   bridge window [io  0x0000-0x03af window] (subtractive decode)
[    0.656002] pci 0000:00:14.4:   bridge window [io  0x03e0-0x0cf7 window] (subtractive decode)
[    0.657002] pci 0000:00:14.4:   bridge window [io  0x03b0-0x03bb window] (subtractive decode)
[    0.658002] pci 0000:00:14.4:   bridge window [io  0x03c0-0x03df window] (subtractive decode)
[    0.659002] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
[    0.660002] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    0.661002] pci 0000:00:14.4:   bridge window [mem 0x000d0000-0x000dffff window] (subtractive decode)
[    0.662002] pci 0000:00:14.4:   bridge window [mem 0xde000000-0xdfffffff window] (subtractive decode)
[    0.663002] pci 0000:00:14.4:   bridge window [mem 0xdd000000-0xddffffff window] (subtractive decode)
[    0.664002] pci 0000:00:14.4:   bridge window [mem 0xfed40000-0xfed44fff] (subtractive decode)
[    0.666252] ACPI: PCI Root Bridge [PC40] (domain 0000 [bus 40])
[    0.667004] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.668205] acpi PNP0A08:01: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
[    0.669007] acpi PNP0A08:01: [Firmware Bug]: no _PXM; falling back to node 2 from hardware (may be inconsistent with ACPI node numbers)
[    0.670242] PCI host bridge to bus 0000:40
[    0.671003] pci_bus 0000:40: root bus resource [bus 40]
[    0.672009] pci 0000:40:00.0: [1002:5a10] type 00 class 0x060000
[    0.673205] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 7 10 *11 12 14 15)
[    0.674052] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 7 *10 11 12 14 15)
[    0.675048] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 7 10 *11 12 14 15)
[    0.677043] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 7 *10 11 12 14 15)
[    0.678050] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 7 *10 11 12 14 15)
[    0.679048] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 7 10 11 12 14 15) *0, disabled.
[    0.680047] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 7 *10 11 12 14 15)
[    0.681047] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 7 10 11 12 14 15) *0, disabled.
[    0.682174] pci 0000:01:04.0: vgaarb: setting as boot VGA device
[    0.683000] pci 0000:01:04.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.683003] pci 0000:01:04.0: vgaarb: bridge control possible
[    0.684001] vgaarb: loaded
[    0.686035] SCSI subsystem initialized
[    0.688027] libata version 3.00 loaded.
[    0.689029] ACPI: bus type USB registered
[    0.690018] usbcore: registered new interface driver usbfs
[    0.691009] usbcore: registered new interface driver hub
[    0.692097] usbcore: registered new device driver usb
[    0.693021] pps_core: LinuxPPS API ver. 1 registered
[    0.694001] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.695004] PTP clock support registered
[    0.696084] EDAC MC: Ver: 3.0.0
[    0.697107] PCI: Using ACPI for IRQ routing
[    0.707085] PCI: pci_cache_line_size set to 64 bytes
[    0.708067] e820: reserve RAM buffer [mem 0x00099800-0x0009ffff]
[    0.709002] e820: reserve RAM buffer [mem 0xd7e80000-0xd7ffffff]
[    0.710002] e820: reserve RAM buffer [mem 0x1027000000-0x1027ffffff]
[    0.711105] Bluetooth: Core ver 2.22
[    0.712007] NET: Registered protocol family 31
[    0.713001] Bluetooth: HCI device and connection manager initialized
[    0.714002] Bluetooth: HCI socket layer initialized
[    0.715002] Bluetooth: L2CAP socket layer initialized
[    0.716006] Bluetooth: SCO socket layer initialized
[    0.717003] NetLabel: Initializing
[    0.718001] NetLabel:  domain hash size = 128
[    0.719001] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.720017] NetLabel:  unlabeled traffic allowed by default
[    0.722150] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    0.723002] hpet0: 4 comparators, 32-bit 14.318180 MHz counter
[    0.726187] clocksource: Switched to clocksource hpet
[    0.749628] VFS: Disk quotas dquot_6.6.0
[    0.753760] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.760894] pnp: PnP ACPI init
[    0.764280] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.771329] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.778479] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.785311] system 00:03: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.792435] system 00:03: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.799204] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.806422] system 00:04: [io  0x0ca2-0x0ca3] has been reserved
[    0.812498] system 00:04: [io  0x0550-0x0551] has been reserved
[    0.818572] system 00:04: [io  0x04d0-0x04d1] has been reserved
[    0.824647] system 00:04: [io  0x040b] has been reserved
[    0.830108] system 00:04: [io  0x04d6] has been reserved
[    0.835595] system 00:04: [io  0x0c00-0x0c01] has been reserved
[    0.841669] system 00:04: [io  0x0c14] has been reserved
[    0.847137] system 00:04: [io  0x0c50-0x0c51] has been reserved
[    0.853236] system 00:04: [io  0x0c52] has been reserved
[    0.858718] system 00:04: [io  0x0c6c] has been reserved
[    0.864179] system 00:04: [io  0x0c6f] has been reserved
[    0.869663] system 00:04: [io  0x0cd0-0x0cd1] has been reserved
[    0.875741] system 00:04: [io  0x0cd2-0x0cd3] has been reserved
[    0.881815] system 00:04: [io  0x0cd4-0x0cd5] has been reserved
[    0.887890] system 00:04: [io  0x0cd6-0x0cd7] has been reserved
[    0.893968] system 00:04: [io  0x0cd8-0x0cdf] has been reserved
[    0.900042] system 00:04: [io  0x0800-0x089f] has been reserved
[    0.906119] system 00:04: [io  0x0b00-0x0b0f] has been reserved
[    0.912194] system 00:04: [io  0x0b20-0x0b3f] has been reserved
[    0.918268] system 00:04: [io  0x0900-0x090f] has been reserved
[    0.924345] system 00:04: [io  0x0910-0x091f] has been reserved
[    0.930421] system 00:04: [io  0xfe00-0xfefe] has been reserved
[    0.936495] system 00:04: [mem 0xffb80000-0xffbfffff] has been reserved
[    0.943264] system 00:04: [mem 0xfec10000-0xfec1001f] has been reserved
[    0.950063] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.957222] pnp 00:05: [dma 0 disabled]
[    0.961255] pnp 00:05: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.968148] pnp 00:06: [dma 0 disabled]
[    0.972199] pnp 00:06: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.979101] system 00:07: [io  0x0a00-0x0a0f] has been reserved
[    0.985172] system 00:07: [io  0x0a10-0x0a1f] has been reserved
[    0.991248] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.998368] pnp 00:08: [dma 0 disabled]
[    1.002405] pnp 00:08: Plug and Play ACPI device, IDs PNP0501 (active)
[    1.009196] system 00:09: [io  0x164e-0x164f] has been reserved
[    1.015273] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.022308] system 00:0a: [mem 0xe0000000-0xefffffff] has been reserved
[    1.029081] system 00:0a: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.036191] pnp 00:0b: disabling [mem 0x000c0000-0x000cffff] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x003fffff 64bit]
[    1.048431] pnp 00:0b: disabling [mem 0x000e0000-0x000fffff] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x003fffff 64bit]
[    1.060688] system 00:0b: [mem 0xfec00000-0xffffffff] could not be reserved
[    1.067802] system 00:0b: Plug and Play ACPI device, IDs PNP0c01 (active)
[    1.074859] system 00:0c: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.081897] system 00:0d: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.088944] pnp: PnP ACPI: found 14 devices
[    1.100342] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    1.109491] pci 0000:03:00.0: BAR 9: no space for [mem size 0x00400000 64bit]
[    1.118295] pci 0000:03:00.0: BAR 9: failed to assign [mem size 0x00400000 64bit]
[    1.126010] pci 0000:03:00.0: BAR 7: no space for [mem size 0x00040000 64bit]
[    1.133323] pci 0000:03:00.0: BAR 7: failed to assign [mem size 0x00040000 64bit]
[    1.141064] pci 0000:00:0c.0: PCI bridge to [bus 03]
[    1.146176] pci 0000:00:0c.0:   bridge window [io  0xe000-0xefff]
[    1.152426] pci 0000:00:0c.0:   bridge window [mem 0xdff00000-0xdfffffff]
[    1.159372] pci 0000:02:00.0: BAR 7: no space for [mem size 0x00020000 64bit]
[    1.166655] pci 0000:02:00.0: BAR 7: failed to assign [mem size 0x00020000 64bit]
[    1.174370] pci 0000:02:00.0: BAR 10: no space for [mem size 0x00020000 64bit]
[    1.181822] pci 0000:02:00.0: BAR 10: failed to assign [mem size 0x00020000 64bit]
[    1.189624] pci 0000:02:00.1: BAR 7: no space for [mem size 0x00020000 64bit]
[    1.196913] pci 0000:02:00.1: BAR 7: failed to assign [mem size 0x00020000 64bit]
[    1.204625] pci 0000:02:00.1: BAR 10: no space for [mem size 0x00020000 64bit]
[    1.212078] pci 0000:02:00.1: BAR 10: failed to assign [mem size 0x00020000 64bit]
[    1.219879] pci 0000:00:0d.0: PCI bridge to [bus 02]
[    1.224993] pci 0000:00:0d.0:   bridge window [io  0xd000-0xdfff]
[    1.231233] pci 0000:00:0d.0:   bridge window [mem 0xdfe00000-0xdfefffff]
[    1.238180] pci 0000:00:14.4: PCI bridge to [bus 01]
[    1.243301] pci 0000:00:14.4:   bridge window [mem 0xdef00000-0xdf7fffff]
[    1.250242] pci 0000:00:14.4:   bridge window [mem 0xdd000000-0xddffffff pref]
[    1.257725] pci_bus 0000:00: Some PCI device resources are unassigned, try booting with pci=realloc
[    1.267008] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    1.273338] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    1.279690] pci_bus 0000:00: resource 6 [io  0x03b0-0x03bb window]
[    1.286016] pci_bus 0000:00: resource 7 [io  0x03c0-0x03df window]
[    1.292343] pci_bus 0000:00: resource 8 [io  0x0d00-0xffff window]
[    1.298672] pci_bus 0000:00: resource 9 [mem 0x000a0000-0x000bffff window]
[    1.305700] pci_bus 0000:00: resource 10 [mem 0x000d0000-0x000dffff window]
[    1.312816] pci_bus 0000:00: resource 11 [mem 0xde000000-0xdfffffff window]
[    1.319930] pci_bus 0000:00: resource 12 [mem 0xdd000000-0xddffffff window]
[    1.327046] pci_bus 0000:00: resource 13 [mem 0xfed40000-0xfed44fff]
[    1.333548] pci_bus 0000:03: resource 0 [io  0xe000-0xefff]
[    1.339268] pci_bus 0000:03: resource 1 [mem 0xdff00000-0xdfffffff]
[    1.345689] pci_bus 0000:02: resource 0 [io  0xd000-0xdfff]
[    1.351409] pci_bus 0000:02: resource 1 [mem 0xdfe00000-0xdfefffff]
[    1.357822] pci_bus 0000:01: resource 1 [mem 0xdef00000-0xdf7fffff]
[    1.364236] pci_bus 0000:01: resource 2 [mem 0xdd000000-0xddffffff pref]
[    1.371093] pci_bus 0000:01: resource 4 [io  0x0000-0x03af window]
[    1.377428] pci_bus 0000:01: resource 5 [io  0x03e0-0x0cf7 window]
[    1.383756] pci_bus 0000:01: resource 6 [io  0x03b0-0x03bb window]
[    1.390091] pci_bus 0000:01: resource 7 [io  0x03c0-0x03df window]
[    1.396427] pci_bus 0000:01: resource 8 [io  0x0d00-0xffff window]
[    1.402762] pci_bus 0000:01: resource 9 [mem 0x000a0000-0x000bffff window]
[    1.409810] pci_bus 0000:01: resource 10 [mem 0x000d0000-0x000dffff window]
[    1.416925] pci_bus 0000:01: resource 11 [mem 0xde000000-0xdfffffff window]
[    1.424065] pci_bus 0000:01: resource 12 [mem 0xdd000000-0xddffffff window]
[    1.431180] pci_bus 0000:01: resource 13 [mem 0xfed40000-0xfed44fff]
[    1.437816] NET: Registered protocol family 2
[    1.442705] TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
[    1.451888] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    1.459039] TCP: Hash tables configured (established 524288 bind 65536)
[    1.465950] UDP hash table entries: 32768 (order: 8, 1048576 bytes)
[    1.472748] UDP-Lite hash table entries: 32768 (order: 8, 1048576 bytes)
[    1.480079] NET: Registered protocol family 1
[    1.484975] RPC: Registered named UNIX socket transport module.
[    1.491048] RPC: Registered udp transport module.
[    1.495899] RPC: Registered tcp transport module.
[    1.500752] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    2.529264] pci 0000:01:04.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    2.537866] PCI: CLS 64 bytes, default 64
[    2.542079] Trying to unpack rootfs image as initramfs...
[    2.866106] Freeing initrd memory: 16564K
[    2.871246] PCI-DMA: Disabling AGP.
[    2.876492] PCI-DMA: aperture base @ cc000000 size 65536 KB
[    2.882226] PCI-DMA: using GART IOMMU.
[    2.886128] PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
[    2.897941] amd_uncore: AMD NB counters detected
[    2.904290] LVT offset 0 assigned for vector 0x400
[    2.909999] perf: AMD IBS detected (0x000000ff)
[    2.914691] kvm: no hardware support
[    2.919302] kvm: Nested Virtualization enabled
[    2.923913] kvm: Nested Paging enabled
[    2.937495] Initialise system trusted keyrings
[    2.942294] workingset: timestamp_bits=53 max_order=24 bucket_order=0
[    2.951354] 9p: Installing v9fs 9p2000 file system support
[    2.957115] SELinux:  Registering netfilter hooks
[    3.451289] NET: Registered protocol family 38
[    3.465998] async_tx: api initialized (async)
[    3.470519] Key type asymmetric registered
[    3.474762] Asymmetric key parser 'x509' registered
[    3.479873] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
[    3.487699] io scheduler noop registered
[    3.491769] io scheduler deadline registered
[    3.496268] io scheduler cfq registered (default)
[    3.501128] io scheduler mq-deadline registered
[    3.505808] io scheduler kyber registered
[    3.510755] atomic64_test: passed for x86-64 platform with CX8 and with SSE
[    3.518498] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    3.527135] ACPI: Power Button [PWRB]
[    3.531017] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    3.538653] ACPI: Power Button [PWRF]
[    3.548209] ERST: Failed to get Error Log Address Range.
[    3.553719] [Firmware Warn]: GHES: Poll interval is 0 for generic hardware error source: 1, disabled.
[    3.563203] GHES: Failed to enable APEI firmware first mode.
[    3.569028] ioatdma: Intel(R) QuickData Technology Driver 4.00
[    3.592594] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    3.619670] 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    3.647907] 00:06: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    3.676095] 00:08: ttyS2 at I/O 0x3e8 (irq = 7, base_baud = 115200) is a 16550A
[    3.684184] Non-volatile memory driver v1.3
[    3.688592] Linux agpgart interface v0.103
[    3.699619] brd: module loaded
[    3.706662] loop: module loaded
[    3.710175] mpt3sas version 17.100.00.00 loaded
[    3.714986] mpt3sas 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM control
[    3.723076] mpt2sas_cm0: 64 BIT PCI BUS DMA ADDRESSING SUPPORTED, total mem (65937480 kB)
[    3.790572] mpt2sas_cm0: CurrentHostPageSize is 0: Setting default host page size to 4k
[    3.798834] mpt2sas_cm0: MSI-X vectors supported: 1, no of cores: 32, max_msix_vectors: -1
[    3.807402] mpt2sas0-msix0: PCI-MSI-X enabled: IRQ 24
[    3.812614] mpt2sas_cm0: iomem(0x00000000dff3c000), mapped(0x00000000ed024e23), size(16384)
[    3.821200] mpt2sas_cm0: ioport(0x000000000000e000), size(256)
[    3.886201] mpt2sas_cm0: CurrentHostPageSize is 0: Setting default host page size to 4k
[    3.894451] mpt2sas_cm0: sending message unit reset !!
[    3.901359] mpt2sas_cm0: message unit reset: SUCCESS
[    3.935027] tsc: Refined TSC clocksource calibration: 2400.007 MHz
[    3.941487] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x22983e30402, max_idle_ns: 440795260848 ns
[    3.962673] mpt2sas_cm0: Allocated physical memory: size(8199 kB)
[    3.968926] mpt2sas_cm0: Current Controller Queue Depth(3640),Max Controller Queue Depth(3712)
[    3.977772] mpt2sas_cm0: Scatter Gather Elements per IO(128)
[    4.031864] mpt2sas_cm0: LSISAS2008: FWVersion(12.00.00.00), ChipRevision(0x03), BiosVersion(07.23.01.00)
[    4.041672] mpt2sas_cm0: Protocol=(
[    4.041673] Initiator
[    4.045310] ,Target
[    4.047729] ), 
[    4.049972] Capabilities=(
[    4.051870] TLR
[    4.054723] ,EEDP
[    4.056620] ,Snapshot Buffer
[    4.058690] ,Diag Trace Buffer
[    4.061717] ,Task Set Full
[    4.064942] ,NCQ
[    4.067793] )
[    4.071590] scsi host0: Fusion MPT SAS Host
[    4.076376] mpt2sas_cm0: sending port enable !!
[    4.076495] ahci 0000:00:11.0: version 3.0
[    4.076767] ahci 0000:00:11.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
[    4.076770] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part ccc 
[    4.077654] scsi host1: ahci
[    4.077902] scsi host2: ahci
[    4.078245] scsi host3: ahci
[    4.078576] scsi host4: ahci
[    4.078616] ata1: SATA max UDMA/133 abar m1024@0xdfdf8400 port 0xdfdf8500 irq 22
[    4.078618] ata2: SATA max UDMA/133 abar m1024@0xdfdf8400 port 0xdfdf8580 irq 22
[    4.078621] ata3: SATA max UDMA/133 abar m1024@0xdfdf8400 port 0xdfdf8600 irq 22
[    4.078623] ata4: SATA max UDMA/133 abar m1024@0xdfdf8400 port 0xdfdf8680 irq 22
[    4.080159] scsi host5: pata_atiixp
[    4.080504] scsi host6: pata_atiixp
[    4.080537] ata5: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xff00 irq 14
[    4.080538] ata6: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xff08 irq 15
[    4.080710] libphy: Fixed MDIO Bus: probed
[    4.080764] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
[    4.080764] e100: Copyright(c) 1999-2006 Intel Corporation
[    4.080784] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    4.080784] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    4.080810] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
[    4.080811] igb: Copyright (c) 2007-2014 Intel Corporation.
[    4.211467] mpt2sas_cm0: host_add: handle(0x0001), sas_addr(0x5003048003e10c00), phys(8)
[    4.221133] mpt2sas_cm0: port enable: SUCCESS
[    4.227428] scsi 0:0:0:0: Direct-Access     ATA      ST32000645NS     0004 PQ: 0 ANSI: 6
[    4.235773] scsi 0:0:0:0: SATA: handle(0x0009), sas_addr(0x4433221100000000), phy(0), device_name(0x5000c500408cec91)
[    4.236764] scsi 0:0:0:0: enclosure logical id (0x5003048003e10c00), slot(31) 
[    4.251757] ata5.00: ATAPI: ATAPI   iHAS324   B, AL19, max UDMA/100
[    4.257234] ata5.00: configured for UDMA/100
[    4.265088] scsi 0:0:0:0: atapi(n), ncq(y), asyn_notify(n), smart(y), fua(y), sw_preserve(y)
[    4.275915] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    4.283573] sd 0:0:0:0: [sda] 3907029168 512-byte logical blocks: (2.00 TB/1.82 TiB)
[    4.294323] igb 0000:02:00.0: added PHC on eth0
[    4.299029] igb 0000:02:00.0: Intel(R) Gigabit Ethernet Network Connection
[    4.306058] igb 0000:02:00.0: eth0: (PCIe:2.5Gb/s:Width x4) 00:25:90:78:8c:54
[    4.313349] igb 0000:02:00.0: eth0: PBA No: Unknown
[    4.318381] igb 0000:02:00.0: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
[    4.343659] sd 0:0:0:0: [sda] Write Protect is off
[    4.348618] sd 0:0:0:0: [sda] Mode Sense: 7f 00 00 08
[    4.368341] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    4.390333] ata2: SATA link down (SStatus 0 SControl 300)
[    4.395932] ata1: SATA link down (SStatus 0 SControl 300)
[    4.401531] ata3: SATA link down (SStatus 0 SControl 300)
[    4.407151] ata4: SATA link down (SStatus 0 SControl 300)
[    4.416384] scsi 5:0:0:0: CD-ROM            ATAPI    iHAS324   B      AL19 PQ: 0 ANSI: 5
[    4.454258] sr 5:0:0:0: [sr0] scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
[    4.463125] cdrom: Uniform CD-ROM driver Revision: 3.20
[    4.463221]  sda: sda1 sda2
[    4.471808] sr 5:0:0:0: Attached scsi CD-ROM sr0
[    4.476812] sr 5:0:0:0: Attached scsi generic sg1 type 5
[    4.540217] igb 0000:02:00.1: added PHC on eth1
[    4.544931] igb 0000:02:00.1: Intel(R) Gigabit Ethernet Network Connection
[    4.551973] igb 0000:02:00.1: eth1: (PCIe:2.5Gb/s:Width x4) 00:25:90:78:8c:55
[    4.559270] igb 0000:02:00.1: eth1: PBA No: Unknown
[    4.564305] igb 0000:02:00.1: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
[    4.564405] sd 0:0:0:0: [sda] Attached SCSI disk
[    4.576995] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - version 5.1.0-k
[    4.584888] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[    4.591086] ixgb: Intel(R) PRO/10GbE Network Driver - version 1.0.135-k2-NAPI
[    4.598380] ixgb: Copyright (c) 1999-2008 Intel Corporation.
[    4.604385] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    4.611068] ehci-pci: EHCI PCI platform driver
[    4.615906] ehci-pci 0000:00:12.2: EHCI Host Controller
[    4.621436] ehci-pci 0000:00:12.2: new USB bus registered, assigned bus number 1
[    4.629064] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    4.638029] ehci-pci 0000:00:12.2: debug port 1
[    4.642741] ehci-pci 0000:00:12.2: irq 17, io mem 0xdfdf8800
[    4.655136] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
[    4.661096] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    4.668045] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.675537] usb usb1: Product: EHCI Host Controller
[    4.680558] usb usb1: Manufacturer: Linux 4.15.0-rc2-00394-gc4260477990a-dirty ehci_hcd
[    4.688793] usb usb1: SerialNumber: 0000:00:12.2
[    4.693771] hub 1-0:1.0: USB hub found
[    4.697706] hub 1-0:1.0: 6 ports detected
[    4.702296] ehci-pci 0000:00:13.2: EHCI Host Controller
[    4.707834] ehci-pci 0000:00:13.2: new USB bus registered, assigned bus number 2
[    4.715471] ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    4.724431] ehci-pci 0000:00:13.2: debug port 1
[    4.729159] ehci-pci 0000:00:13.2: irq 19, io mem 0xdfdf8c00
[    4.741136] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
[    4.747113] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    4.754065] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.761516] usb usb2: Product: EHCI Host Controller
[    4.766544] usb usb2: Manufacturer: Linux 4.15.0-rc2-00394-gc4260477990a-dirty ehci_hcd
[    4.774777] usb usb2: SerialNumber: 0000:00:13.2
[    4.779732] hub 2-0:1.0: USB hub found
[    4.783631] hub 2-0:1.0: 6 ports detected
[    4.788067] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    4.794435] ohci-pci: OHCI PCI platform driver
[    4.799237] ohci-pci 0000:00:12.0: OHCI PCI host controller
[    4.805118] ohci-pci 0000:00:12.0: new USB bus registered, assigned bus number 3
[    4.812772] ohci-pci 0000:00:12.0: irq 16, io mem 0xdfdf7000
[    4.874214] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[    4.881158] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.888639] usb usb3: Product: OHCI PCI host controller
[    4.894009] usb usb3: Manufacturer: Linux 4.15.0-rc2-00394-gc4260477990a-dirty ohci_hcd
[    4.902243] usb usb3: SerialNumber: 0000:00:12.0
[    4.907996] hub 3-0:1.0: USB hub found
[    4.911932] hub 3-0:1.0: 3 ports detected
[    4.916454] ohci-pci 0000:00:12.1: OHCI PCI host controller
[    4.922316] ohci-pci 0000:00:12.1: new USB bus registered, assigned bus number 4
[    4.929959] ohci-pci 0000:00:12.1: irq 16, io mem 0xdfdf6000
[    4.991222] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    4.998185] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.005661] usb usb4: Product: OHCI PCI host controller
[    5.011051] usb usb4: Manufacturer: Linux 4.15.0-rc2-00394-gc4260477990a-dirty ohci_hcd
[    5.019293] usb usb4: SerialNumber: 0000:00:12.1
[    5.024116] clocksource: Switched to clocksource tsc
[    5.024267] hub 4-0:1.0: USB hub found
[    5.024280] hub 4-0:1.0: 3 ports detected
[    5.024539] ohci-pci 0000:00:13.0: OHCI PCI host controller
[    5.024609] ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 5
[    5.024634] ohci-pci 0000:00:13.0: irq 18, io mem 0xdfdfa000
[    5.080232] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[    5.087173] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.094618] usb usb5: Product: OHCI PCI host controller
[    5.099992] usb usb5: Manufacturer: Linux 4.15.0-rc2-00394-gc4260477990a-dirty ohci_hcd
[    5.108224] usb usb5: SerialNumber: 0000:00:13.0
[    5.113165] hub 5-0:1.0: USB hub found
[    5.117063] hub 5-0:1.0: 3 ports detected
[    5.121562] ohci-pci 0000:00:13.1: OHCI PCI host controller
[    5.127417] ohci-pci 0000:00:13.1: new USB bus registered, assigned bus number 6
[    5.135058] ohci-pci 0000:00:13.1: irq 18, io mem 0xdfdf9000
[    5.196108] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
[    5.203043] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.210486] usb usb6: Product: OHCI PCI host controller
[    5.215861] usb usb6: Manufacturer: Linux 4.15.0-rc2-00394-gc4260477990a-dirty ohci_hcd
[    5.224085] usb usb6: SerialNumber: 0000:00:13.1
[    5.229015] hub 6-0:1.0: USB hub found
[    5.232914] hub 6-0:1.0: 3 ports detected
[    5.237408] ohci-pci 0000:00:14.5: OHCI PCI host controller
[    5.243260] ohci-pci 0000:00:14.5: new USB bus registered, assigned bus number 7
[    5.250898] ohci-pci 0000:00:14.5: irq 18, io mem 0xdfdfb000
[    5.312219] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
[    5.319179] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.326623] usb usb7: Product: OHCI PCI host controller
[    5.331989] usb usb7: Manufacturer: Linux 4.15.0-rc2-00394-gc4260477990a-dirty ohci_hcd
[    5.340221] usb usb7: SerialNumber: 0000:00:14.5
[    5.345182] hub 7-0:1.0: USB hub found
[    5.349105] hub 7-0:1.0: 2 ports detected
[    5.353484] uhci_hcd: USB Universal Host Controller Interface driver
[    5.360067] usbcore: registered new interface driver usbserial_generic
[    5.366748] usbserial: USB Serial support registered for generic
[    5.372923] i8042: PNP: No PS/2 controller found.
[    5.377769] i8042: Probing ports directly.
[    5.385152] serio: i8042 KBD port at 0x60,0x64 irq 1
[    5.390270] serio: i8042 AUX port at 0x60,0x64 irq 12
[    5.395690] mousedev: PS/2 mouse device common for all mice
[    5.401572] rtc_cmos 00:02: RTC can wake from S4
[    5.406533] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
[    5.412807] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    5.420712] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
[    5.428804] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0xb20
[    5.437850] IR NEC protocol handler initialized
[    5.442541] IR RC5(x/sz) protocol handler initialized
[    5.447762] IR RC6 protocol handler initialized
[    5.452432] IR JVC protocol handler initialized
[    5.457103] IR Sony protocol handler initialized
[    5.461889] IR SANYO protocol handler initialized
[    5.466733] IR Sharp protocol handler initialized
[    5.471579] IR MCE Keyboard/mouse protocol handler initialized
[    5.477557] IR XMP protocol handler initialized
[    5.483052] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver v0.05
[    5.489588] sp5100_tco: PCI Vendor ID: 0x1002, Device ID: 0x4385, Revision ID: 0x3d
[    5.497480] sp5100_tco: failed to find MMIO address, giving up.
[    5.504194] device-mapper: uevent: version 1.0.3
[    5.509162] device-mapper: ioctl: 4.37.0-ioctl (2017-09-20) initialised: dm-devel@redhat.com
[    5.518169] EDAC amd64: Node 0: DRAM ECC enabled.
[    5.523027] EDAC amd64: F15h detected (node 0).
[    5.527731] EDAC MC: DCT0 chip selects:
[    5.531728] EDAC amd64: MC: 0:     0MB 1:     0MB
[    5.536581] EDAC amd64: MC: 2:  4096MB 3:  4096MB
[    5.541424] EDAC amd64: MC: 4:     0MB 5:     0MB
[    5.546271] EDAC amd64: MC: 6:     0MB 7:     0MB
[    5.551115] EDAC MC: DCT1 chip selects:
[    5.555093] EDAC amd64: MC: 0:     0MB 1:     0MB
[    5.559938] EDAC amd64: MC: 2:  4096MB 3:  4096MB
[    5.564783] EDAC amd64: MC: 4:     0MB 5:     0MB
[    5.569626] EDAC amd64: MC: 6:     0MB 7:     0MB
[    5.574474] EDAC amd64: using x8 syndromes.
[    5.578798] EDAC amd64: MCT channel count: 2
[    5.583321] EDAC MC0: Giving out device to module amd64_edac controller F15h: DEV 0000:00:18.3 (INTERRUPT)
[    5.593300] EDAC amd64: Node 1: DRAM ECC enabled.
[    5.598151] EDAC amd64: F15h detected (node 1).
[    5.602852] EDAC MC: DCT0 chip selects:
[    5.606826] EDAC amd64: MC: 0:     0MB 1:     0MB
[    5.611670] EDAC amd64: MC: 2:  4096MB 3:  4096MB
[    5.616517] EDAC amd64: MC: 4:     0MB 5:     0MB
[    5.621360] EDAC amd64: MC: 6:     0MB 7:     0MB
[    5.626213] EDAC MC: DCT1 chip selects:
[    5.630191] EDAC amd64: MC: 0:     0MB 1:     0MB
[    5.635048] EDAC amd64: MC: 2:  4096MB 3:  4096MB
[    5.639891] EDAC amd64: MC: 4:     0MB 5:     0MB
[    5.644762] EDAC amd64: MC: 6:     0MB 7:     0MB
[    5.649623] EDAC amd64: using x8 syndromes.
[    5.653974] EDAC amd64: MCT channel count: 2
[    5.658491] EDAC MC1: Giving out device to module amd64_edac controller F15h: DEV 0000:00:19.3 (INTERRUPT)
[    5.668467] EDAC amd64: Node 2: DRAM ECC enabled.
[    5.673311] EDAC amd64: F15h detected (node 2).
[    5.678015] EDAC MC: DCT0 chip selects:
[    5.681996] EDAC amd64: MC: 0:     0MB 1:     0MB
[    5.686840] EDAC amd64: MC: 2:  4096MB 3:  4096MB
[    5.691684] EDAC amd64: MC: 4:     0MB 5:     0MB
[    5.692095] usb 7-1: new full-speed USB device number 2 using ohci-pci
[    5.703201] EDAC amd64: MC: 6:     0MB 7:     0MB
[    5.708073] EDAC MC: DCT1 chip selects:
[    5.712086] EDAC amd64: MC: 0:     0MB 1:     0MB
[    5.716940] EDAC amd64: MC: 2:  4096MB 3:  4096MB
[    5.721784] EDAC amd64: MC: 4:     0MB 5:     0MB
[    5.726630] EDAC amd64: MC: 6:     0MB 7:     0MB
[    5.731476] EDAC amd64: using x8 syndromes.
[    5.735800] EDAC amd64: MCT channel count: 2
[    5.740330] EDAC MC2: Giving out device to module amd64_edac controller F15h: DEV 0000:00:1a.3 (INTERRUPT)
[    5.750304] EDAC amd64: Node 3: DRAM ECC enabled.
[    5.755153] EDAC amd64: F15h detected (node 3).
[    5.759856] EDAC MC: DCT0 chip selects:
[    5.763828] EDAC amd64: MC: 0:     0MB 1:     0MB
[    5.768674] EDAC amd64: MC: 2:  4096MB 3:  4096MB
[    5.773526] EDAC amd64: MC: 4:     0MB 5:     0MB
[    5.778370] EDAC amd64: MC: 6:     0MB 7:     0MB
[    5.783216] EDAC MC: DCT1 chip selects:
[    5.787195] EDAC amd64: MC: 0:     0MB 1:     0MB
[    5.792058] EDAC amd64: MC: 2:  4096MB 3:  4096MB
[    5.796928] EDAC amd64: MC: 4:     0MB 5:     0MB
[    5.801798] EDAC amd64: MC: 6:     0MB 7:     0MB
[    5.806670] EDAC amd64: using x8 syndromes.
[    5.811019] EDAC amd64: MCT channel count: 2
[    5.815537] EDAC MC3: Giving out device to module amd64_edac controller F15h: DEV 0000:00:1b.3 (INTERRUPT)
[    5.825425] EDAC PCI0: Giving out device to module amd64_edac controller EDAC PCI controller: DEV 0000:00:18.2 (POLLED)
[    5.836433] AMD64 EDAC driver v3.5.0
[    5.840378] hidraw: raw HID events driver (C) Jiri Kosina
[    5.846013] usbcore: registered new interface driver usbhid
[    5.851729] usbhid: USB HID core driver
[    5.852261] usb 7-1: New USB device found, idVendor=0557, idProduct=2221
[    5.852263] usb 7-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    5.852264] usb 7-1: Product: Hermon USB hidmouse Device
[    5.852265] usb 7-1: Manufacturer: Winbond Electronics Corp
[    5.858528] input: Winbond Electronics Corp Hermon USB hidmouse Device as /devices/pci0000:00/0000:00:14.5/usb7/7-1/7-1:1.0/0003:0557:2221.0001/input/input5
[    5.858759] hid-generic 0003:0557:2221.0001: input,hidraw0: USB HID v1.00 Mouse [Winbond Electronics Corp Hermon USB hidmouse Device] on usb-0000:00:14.5-1/input0
[    5.862513] input: Winbond Electronics Corp Hermon USB hidmouse Device as /devices/pci0000:00/0000:00:14.5/usb7/7-1/7-1:1.1/0003:0557:2221.0002/input/input6
[    5.914368] hid-generic 0003:0557:2221.0002: input,hidraw1: USB HID v1.00 Keyboard [Winbond Electronics Corp Hermon USB hidmouse Device] on usb-0000:00:14.5-1/input1
[    5.939719] drop_monitor: Initializing network drop monitor service
[    5.946222] ip_tables: (C) 2000-2006 Netfilter Core Team
[    5.952063] Initializing XFRM netlink socket
[    5.956649] NET: Registered protocol family 10
[    5.961821] Segment Routing with IPv6
[    5.965647] mip6: Mobile IPv6
[    5.968760] NET: Registered protocol family 17
[    5.973346] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    5.978805] Bluetooth: BNEP filters: protocol multicast
[    5.984178] Bluetooth: BNEP socket layer initialized
[    5.989290] 9pnet: Installing 9P2000 support
[    5.993739] Key type dns_resolver registered
[    6.002144] microcode: CPU0: patch_level=0x06000626
[    6.007177] microcode: CPU1: patch_level=0x06000626
[    6.012198] microcode: CPU2: patch_level=0x06000626
[    6.017224] microcode: CPU3: patch_level=0x06000626
[    6.022329] microcode: CPU4: patch_level=0x06000626
[    6.027361] microcode: CPU5: patch_level=0x06000626
[    6.032474] microcode: CPU6: patch_level=0x06000626
[    6.037519] microcode: CPU7: patch_level=0x06000626
[    6.042629] microcode: CPU8: patch_level=0x06000626
[    6.047670] microcode: CPU9: patch_level=0x06000626
[    6.052809] microcode: CPU10: patch_level=0x06000626
[    6.057929] microcode: CPU11: patch_level=0x06000626
[    6.063125] microcode: CPU12: patch_level=0x06000626
[    6.068243] microcode: CPU13: patch_level=0x06000626
[    6.073438] microcode: CPU14: patch_level=0x06000626
[    6.078558] microcode: CPU15: patch_level=0x06000626
[    6.083757] microcode: CPU16: patch_level=0x06000626
[    6.088880] microcode: CPU17: patch_level=0x06000626
[    6.094076] microcode: CPU18: patch_level=0x06000626
[    6.099219] microcode: CPU19: patch_level=0x06000626
[    6.104414] microcode: CPU20: patch_level=0x06000626
[    6.109534] microcode: CPU21: patch_level=0x06000626
[    6.114726] microcode: CPU22: patch_level=0x06000626
[    6.119873] microcode: CPU23: patch_level=0x06000626
[    6.125074] microcode: CPU24: patch_level=0x06000626
[    6.130194] microcode: CPU25: patch_level=0x06000626
[    6.135386] microcode: CPU26: patch_level=0x06000626
[    6.140518] microcode: CPU27: patch_level=0x06000626
[    6.145716] microcode: CPU28: patch_level=0x06000626
[    6.150841] microcode: CPU29: patch_level=0x06000626
[    6.156038] microcode: CPU30: patch_level=0x06000626
[    6.161180] microcode: CPU31: patch_level=0x06000626
[    6.166417] microcode: Microcode Update Driver: v2.2.
[    6.166424] AVX version of gcm_enc/dec engaged.
[    6.176288] AES CTR mode by8 optimization enabled
[    6.196664] sched_clock: Marking stable (6196628921, 0)->(7677575367, -1480946446)
[    6.205207] registered taskstats version 1
[    6.209452] Loading compiled-in X.509 certificates
[    6.214705] APEI: Can not request [mem 0xd7ea0770-0xd7ea07c3] for APEI BERT registers
[    6.222781]   Magic number: 13:40:32
[    6.226573] tty ttydf: hash matches
[    6.230327] console [netcon0] enabled
[    6.234166] netconsole: network logging started
[    6.238980] rtc_cmos 00:02: setting system clock to 2017-12-06 15:00:24 UTC (1512572424)
[    6.248358] acpi_cpufreq: overriding BIOS provided _PSD data
[    6.262264] Freeing unused kernel memory: 1772K
[    6.266940] Write protecting the kernel read-only data: 20480k
[    6.274035] Freeing unused kernel memory: 1984K
[    6.283346] Freeing unused kernel memory: 1836K
[    6.298022] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    6.304619] rodata_test: all tests were successful
[    6.398745] dracut: dracut-018-35.git20120510.fc17
[    6.455714] dracut: rd.luks=0: removing cryptoluks activation
[    6.476997] udevd[382]: starting version 182
[    6.595451] dracut: Starting plymouth daemon
[    6.675614] dracut: rd.dm=0: removing DM RAID activation
[    6.697537] dracut: rd.md=0: removing MD RAID activation
[    6.870388] igb 0000:02:00.1 p13p2: renamed from eth1
[    6.881337] igb 0000:02:00.0 p13p1: renamed from eth0
[    6.963859] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
[    7.138838] dracut: Checking ext4: /dev/sda2

--yo2353snizqlekop--
