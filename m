Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:20016 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753398Ab2DJTqu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Apr 2012 15:46:50 -0400
Message-ID: <4F848E10.1090703@snewbury.org.uk>
Date: Tue, 10 Apr 2012 20:46:24 +0100
From: Steven Newbury <steve@snewbury.org.uk>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: PCI resources above 4GB
References: <1333968563.5678.19.camel@infinity> <CAErSpo7hGvJSmq4U37XN9T7ZaYn55fyy9t3ER5BBCDdQ3XZxqw@mail.gmail.com> <4F84110E.3000400@snewbury.org.uk> <CAE9FiQVHf_pcXUspOtLXx4XminmzdWja3Ra2Wh5jQRbfNOQ1eQ@mail.gmail.com> <4F8467AA.90305@snewbury.org.uk> <CAE9FiQWaop0NE7ZJu6jVW3SnxLkOJ9hRKh4xMNk64XjCAMRMMw@mail.gmail.com> <4F848357.3060007@snewbury.org.uk> <CAE9FiQXTgh3X4x+xD1T0ipsEbhbPtctYucfGeuWK=cq7kHeZ1Q@mail.gmail.com>
In-Reply-To: <CAE9FiQXTgh3X4x+xD1T0ipsEbhbPtctYucfGeuWK=cq7kHeZ1Q@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------080002010004070902050706"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------080002010004070902050706
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/04/12 20:16, Yinghai Lu wrote:
> On Tue, Apr 10, 2012 at 12:00 PM, Steven Newbury
> <steve@snewbury.org.uk> wrote:
> 
>> Seems to be exactly the same.  When started docked (so I think
>> both 'cards' try to claim the same preferred addresses) the
>> integrated i965 GFX gets reassigned high: 120000000-12fffffff :
>> 0000:00:02.0
>> 
>> But it's quite possible the i915 module doesn't currently handle
>> this case and so fails to initialise.
>> 
>> I'm not sure why the Radeon doesn't get assigned a high address
>> when hot-plugged..?
> 
> bus layout with randon: 00:1e.0 03:01.0 03:01.4 03:08.0 05:00.0
> 
> the bridge 03:08.0 from PLX does not support 64bit pref mem So even
> 05.00.0 Radeon support that 64 pref mem, have to allocate 32bit mem
> range to it.
> 
I was afraid that'd be the case.

> the suitable range for that is 0xe0000000-0xefffffff. that is not
> bigger enough, because need to preallocate 64M optional for 03:01.0
> the cardbus. but that is optional.

Maybe this is a stupid question, but is there any way of enlarging the
PCI hole?
> 
> We should get 05:00.0 get assigned to 0xe00000000 and 03:01.0
> without assignment.
> 
> 
>> 
>> These are the only entries in /proc/iomem above 4GB:
>> 
>> 
>> Booted UNDOCKED, then hot-docked
>> 
>> 100000000-11fffffff : System RAM 120000000-1201fffff : PCI Bus
>> 0000:0b 120200000-1203fffff : PCI Bus 0000:0c 120400000-1205fffff
>> : PCI Bus 0000:09
>> 
>> 
>> Booted DOCKED
>> 
>> 100000000-11fffffff : System RAM 120000000-12fffffff :
>> 0000:00:02.0 130000000-1301fffff : PCI Bus 0000:0b 
>> 130200000-1303fffff : PCI Bus 0000:0c 130400000-1305fffff : PCI
>> Bus 0000:0d 130600000-1307fffff : PCI Bus 0000:09
> 
> whole dmesg wht pci debug enabled please.

CONFIG_PCI_DEBUG=y

full DOCKED dmesg attached
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+EjhAACgkQGcb56gMuC61svgCdGWjxL5mbf4Hj9YeJMtj/H5Dz
3SsAnRaCvWeNoO9tIJogIIsmMBfuV849
=6fU6
-----END PGP SIGNATURE-----

--------------080002010004070902050706
Content-Type: text/plain; charset=UTF-8;
 name="dmesg.docked"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg.docked"

Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Linux version 3.4.0-rc2-wl-00219-g61fa1b5 (root@infinity) (gcc version 4.6.2 (Gentoo 4.6.2 p1.4, pie-0.5.0) ) #87 SMP Tue Apr 10 19:44:31 BST 2012
Command line: BOOT_IMAGE=/vmlinuz-3.4.0-rc2-wl-00219-g61fa1b5 root=UUID=d761a2db-f951-4e9c-bed4-cf2381bb1af4 ro rootflags=subvol=ROOT real_init=/bin/systemd real_root=LABEL=GENTOO real_rootflags=subvol=ROOT,compress=lzo,inode_cache,space_cache,ssd pcie_aspm=force i915.modeset=1 i915.lvds_downclock=1 i915.lvds_use_ssc=1 i915.powersave=1 i915.i915_enable_fbc=1 i915.i915_enable_rc6=1 ioapicreroute pci=realloc resume=UUID=ae0f88ec-9e17-41f2-b8b3-685cce36e496 pci=nocrs
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000df65a800 (usable)
 BIOS-e820: 00000000df65a800 - 00000000e0000000 (reserved)
 BIOS-e820: 00000000f8000000 - 00000000fc000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fed18000 - 00000000fed1c000 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000fed90000 (reserved)
 BIOS-e820: 00000000feda0000 - 00000000feda6000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000120000000 (usable)
NX (Execute Disable) protection: active
DMI 2.4 present.
DMI: Dell Inc. Latitude D830                   /0HN341, BIOS A16 12/22/2011
e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> (reserved)
e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
No AGP bridge found
last_pfn = 0x120000 max_arch_pfn = 0x400000000
MTRR default type: uncachable
MTRR fixed ranges enabled:
  00000-9FFFF write-back
  A0000-BFFFF uncachable
  C0000-CFFFF write-protect
  D0000-EFFFF uncachable
  F0000-FFFFF write-protect
MTRR variable ranges enabled:
  0 base 000000000 mask F80000000 write-back
  1 base 080000000 mask FC0000000 write-back
  2 base 0C0000000 mask FE0000000 write-back
  3 base 100000000 mask FE0000000 write-back
  4 base 0DF800000 mask FFF800000 uncachable
  5 base 0DF700000 mask FFFF00000 uncachable
  6 disabled
  7 disabled
x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
original variable MTRRs
reg 0, base: 0GB, range: 2GB, type WB
reg 1, base: 2GB, range: 1GB, type WB
reg 2, base: 3GB, range: 512MB, type WB
reg 3, base: 4GB, range: 512MB, type WB
reg 4, base: 3576MB, range: 8MB, type UC
reg 5, base: 3575MB, range: 1MB, type UC
total RAM covered: 4087M
Found optimal setting for mtrr clean up
 gran_size: 64K 	chunk_size: 1G 	num_reg: 5  	lose cover RAM: 0G
New variable MTRRs
reg 0, base: 0GB, range: 4GB, type WB
reg 1, base: 3575MB, range: 1MB, type UC
reg 2, base: 3576MB, range: 8MB, type UC
reg 3, base: 3584MB, range: 512MB, type UC
reg 4, base: 4GB, range: 512MB, type WB
e820 update range: 00000000df700000 - 0000000100000000 (usable) ==> (reserved)
last_pfn = 0xdf65a max_arch_pfn = 0x400000000
initial memory mapped : 0 - 20000000
Base memory trampoline at [ffff88000009a000] 9a000 size 20480
init_memory_mapping: 0000000000000000-00000000df65a000
 0000000000 - 00df600000 page 2M
 00df600000 - 00df65a000 page 4k
kernel direct mapping tables up to df65a000 @ 1fffa000-20000000
init_memory_mapping: 0000000100000000-0000000120000000
 0100000000 - 0120000000 page 2M
kernel direct mapping tables up to 120000000 @ df654000-df65a000
RAMDISK: 374c2000 - 37a59000
ACPI: RSDP 00000000000fbb10 00024 (v02 DELL  )
ACPI: XSDT 00000000df65d200 0006C (v01 DELL    M08     27DB0C16 ASL  00000061)
ACPI: FACP 00000000df65d09c 000F4 (v04 DELL    M08     27DB0C16 ASL  00000061)
ACPI: DSDT 00000000df65d800 063B2 (v02 INT430 SYSFexxx 00001001 INTL 20050624)
ACPI: FACS 00000000df66c000 00040
ACPI: HPET 00000000df65d300 00038 (v01 DELL    M08     00000001 ASL  00000061)
ACPI: APIC 00000000df65d400 00068 (v01 DELL    M08     27DB0C16 ASL  00000047)
ACPI: ASF! 00000000df65d000 0007E (v32 DELL    M08     27DB0C16 ASL  00000061)
ACPI: MCFG 00000000df65d3c0 0003E (v16 DELL    M08     27DB0C16 ASL  00000061)
ACPI: TCPA 00000000df65d700 00032 (v01                 00000000 ASL  00000000)
ACPI: SLIC 00000000df65d49c 00176 (v01 DELL    M08     27DB0C16 ASL  00000061)
ACPI: BOOT 00000000df65cfc0 00028 (v01 DELL    M08     27DB0C16 ASL  00000061)
ACPI: SSDT 00000000df65b982 004CC (v01  PmRef    CpuPm 00003000 INTL 20050624)
ACPI: Local APIC address 0xfee00000
 [ffffea0000000000-ffffea00047fffff] PMD -> [ffff88011b600000-ffff88011f5fffff] on node 0
Zone PFN ranges:
  DMA      0x00000010 -> 0x00001000
  DMA32    0x00001000 -> 0x00100000
  Normal   0x00100000 -> 0x00120000
Movable zone start PFN for each node
Early memory PFN ranges
    0: 0x00000010 -> 0x0000009f
    0: 0x00000100 -> 0x000df65a
    0: 0x00100000 -> 0x00120000
On node 0 totalpages: 1045993
  DMA zone: 64 pages used for memmap
  DMA zone: 5 pages reserved
  DMA zone: 3914 pages, LIFO batch:0
  DMA32 zone: 16320 pages used for memmap
  DMA32 zone: 894618 pages, LIFO batch:31
  Normal zone: 2048 pages used for memmap
  Normal zone: 129024 pages, LIFO batch:31
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Using ACPI (MADT) for SMP configuration information
ACPI: HPET id: 0x8086a201 base: 0xfed00000
SMP: Allowing 2 CPUs, 0 hotplug CPUs
nr_irqs_gsi: 40
PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
PM: Registered nosave memory: 00000000000a0000 - 0000000000100000
PM: Registered nosave memory: 00000000df65a000 - 00000000df65b000
PM: Registered nosave memory: 00000000df65b000 - 00000000e0000000
PM: Registered nosave memory: 00000000e0000000 - 00000000f8000000
PM: Registered nosave memory: 00000000f8000000 - 00000000fc000000
PM: Registered nosave memory: 00000000fc000000 - 00000000fec00000
PM: Registered nosave memory: 00000000fec00000 - 00000000fec10000
PM: Registered nosave memory: 00000000fec10000 - 00000000fed18000
PM: Registered nosave memory: 00000000fed18000 - 00000000fed1c000
PM: Registered nosave memory: 00000000fed1c000 - 00000000fed20000
PM: Registered nosave memory: 00000000fed20000 - 00000000fed90000
PM: Registered nosave memory: 00000000fed90000 - 00000000feda0000
PM: Registered nosave memory: 00000000feda0000 - 00000000feda6000
PM: Registered nosave memory: 00000000feda6000 - 00000000fee00000
PM: Registered nosave memory: 00000000fee00000 - 00000000fee10000
PM: Registered nosave memory: 00000000fee10000 - 00000000ffe00000
PM: Registered nosave memory: 00000000ffe00000 - 0000000100000000
Allocating PCI resources starting at e0000000 (gap: e0000000:18000000)
setup_percpu: NR_CPUS:2 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:1
PERCPU: Embedded 26 pages/cpu @ffff88011fc00000 s76608 r8192 d21696 u1048576
pcpu-alloc: s76608 r8192 d21696 u1048576 alloc=1*2097152
pcpu-alloc: [0] 0 1 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1027556
Kernel command line: BOOT_IMAGE=/vmlinuz-3.4.0-rc2-wl-00219-g61fa1b5 root=UUID=d761a2db-f951-4e9c-bed4-cf2381bb1af4 ro rootflags=subvol=ROOT real_init=/bin/systemd real_root=LABEL=GENTOO real_rootflags=subvol=ROOT,compress=lzo,inode_cache,space_cache,ssd pcie_aspm=force i915.modeset=1 i915.lvds_downclock=1 i915.lvds_use_ssc=1 i915.powersave=1 i915.i915_enable_fbc=1 i915.i915_enable_rc6=1 ioapicreroute pci=realloc resume=UUID=ae0f88ec-9e17-41f2-b8b3-685cce36e496 pci=nocrs
PCIe ASPM is forcibly enabled
PID hash table entries: 4096 (order: 3, 32768 bytes)
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Checking aperture...
No AGP bridge found
Memory: 4031780k/4718592k available (3506k kernel code, 534620k absent, 152192k reserved, 3218k data, 612k init)
SLUB: Genslabs=15, HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
Hierarchical RCU implementation.
	RCU dyntick-idle grace-period acceleration is enabled.
NR_IRQS:4352 nr_irqs:512 16
Extended CMOS year: 2000
Console: colour VGA+ 80x25
console [tty0] enabled
allocated 16777216 bytes of page_cgroup
please try 'cgroup_disable=memory' option if you don't want memory cgroups
hpet clockevent registered
Fast TSC calibration using PIT
Detected 2394.026 MHz processor.
Calibrating delay loop (skipped), value calculated using timer frequency.. 4788.05 BogoMIPS (lpj=2394026)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 256
Initializing cgroup subsys debug
Initializing cgroup subsys cpuacct
Initializing cgroup subsys memory
Initializing cgroup subsys devices
Initializing cgroup subsys freezer
Initializing cgroup subsys blkio
Initializing cgroup subsys perf_event
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
mce: CPU supports 6 MCE banks
CPU0: Thermal monitoring enabled (TM2)
using mwait in idle threads.
ACPI: Core revision 20120320
ftrace: allocating 16999 entries in 67 pages
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
CPU0: Intel(R) Core(TM)2 Duo CPU     T7700  @ 2.40GHz stepping 0b
Performance Events: PEBS fmt0+, 4-deep LBR, Core2 events, Intel PMU driver.
PEBS disabled due to CPU errata.
... version:                2
... bit width:              40
... generic registers:      2
... value mask:             000000ffffffffff
... max period:             000000007fffffff
... fixed-purpose events:   3
... event mask:             0000000700000003
Testing tracer nop: PASSED
Booting Node   0, Processors  #1 Ok.
Brought up 2 CPUs
----------------
| NMI testsuite:
--------------------
  remote IPI:  ok  |
   local IPI:  ok  |
--------------------
Good, all   2 testcases passed! |
---------------------------------
Total of 2 processors activated (9576.10 BogoMIPS).
devtmpfs: initialized
atomic64 test passed for x86-64 platform with CX8 and with SSE
dummy: 
NET: Registered protocol family 16
ACPI: bus type pci registered
dca service started, version 1.12.1
PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
PCI: Using configuration type 1 for base access
dmi type 0xB1 record - unknown flag
bio: create slab <bio-0> at 0
ACPI: Added _OSI(Module Device)
ACPI: Added _OSI(Processor Device)
ACPI: Added _OSI(3.0 _SCP Extensions)
ACPI: Added _OSI(Processor Aggregator Device)
ACPI: EC: Look up EC in DSDT
[Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
ACPI: SSDT 00000000df66c080 00043 (v01  LMPWR  DELLLOM 00001001 INTL 20050624)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT           (null) 00043 (v01  LMPWR  DELLLOM 00001001 INTL 20050624)
ACPI: SSDT 00000000df65c4b8 002C8 (v01  PmRef  Cpu0Ist 00003000 INTL 20050624)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT           (null) 002C8 (v01  PmRef  Cpu0Ist 00003000 INTL 20050624)
ACPI: SSDT 00000000df65be4e 005E5 (v01  PmRef  Cpu0Cst 00003001 INTL 20050624)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT           (null) 005E5 (v01  PmRef  Cpu0Cst 00003001 INTL 20050624)
ACPI: SSDT 00000000df65c780 000C4 (v01  PmRef  Cpu1Ist 00003000 INTL 20050624)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT           (null) 000C4 (v01  PmRef  Cpu1Ist 00003000 INTL 20050624)
ACPI: SSDT 00000000df65c433 00085 (v01  PmRef  Cpu1Cst 00003000 INTL 20050624)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT           (null) 00085 (v01  PmRef  Cpu1Cst 00003000 INTL 20050624)
ACPI: Interpreter enabled
ACPI: (supports S0 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: ACPI Dock Station Driver: 3 docks/bays found
PCI: Ignoring host bridge windows from ACPI; if necessary, use "pci=use_crs" and report a bug
ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
pci_root PNP0A03:00: host bridge window [io  0x0000-0x0cf7] (ignored)
pci_root PNP0A03:00: host bridge window [io  0x0d00-0xffff] (ignored)
pci_root PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff] (ignored)
pci_root PNP0A03:00: host bridge window [mem 0x000d0000-0x000dffff] (ignored)
pci_root PNP0A03:00: host bridge window [mem 0xe0000000-0xf7ffffff] (ignored)
pci_root PNP0A03:00: host bridge window [mem 0xfc000000-0xfebfffff] (ignored)
pci_root PNP0A03:00: host bridge window [mem 0xfec10000-0xfecfffff] (ignored)
pci_root PNP0A03:00: host bridge window [mem 0xfed1c000-0xfed1ffff] (ignored)
pci_root PNP0A03:00: host bridge window [mem 0xfed90000-0xfed9ffff] (ignored)
pci_root PNP0A03:00: host bridge window [mem 0xfed40000-0xfed44fff] (ignored)
pci_root PNP0A03:00: host bridge window [mem 0xfeda7000-0xfedfffff] (ignored)
pci_root PNP0A03:00: host bridge window [mem 0xfee10000-0xff9fffff] (ignored)
pci_root PNP0A03:00: host bridge window [mem 0xffc00000-0xffdfffff] (ignored)
PCI: root bus 00: using default resources
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
pci_bus 0000:00: root bus resource [mem 0x00000000-0xfffffffff]
pci_bus 0000:00: busn_res: [bus 00-ff] for root bus
pci_bus 0000:00: root bus resource [bus 00-ff]
pci_bus 0000:00: scanning bus pass 0
pci 0000:00:00.0: [8086:2a00] type 00 class 0x060000
pci 0000:00:00.0: calling quirk_mmio_always_on+0x0/0xa
pci 0000:00:02.0: [8086:2a02] type 00 class 0x030000
pci 0000:00:02.0: reg 10: [mem 0xf6e00000-0xf6efffff 64bit]
pci 0000:00:02.0: reg 18: [mem 0xc0000000-0xcfffffff 64bit pref]
pci 0000:00:02.0: reg 20: [io  0xeff8-0xefff]
pci 0000:00:02.1: [8086:2a03] type 00 class 0x038000
pci 0000:00:02.1: reg 10: [mem 0xf6f00000-0xf6ffffff 64bit]
pci 0000:00:1a.0: [8086:2834] type 00 class 0x0c0300
pci 0000:00:1a.0: reg 20: [io  0x6f20-0x6f3f]
pci 0000:00:1a.1: [8086:2835] type 00 class 0x0c0300
pci 0000:00:1a.1: reg 20: [io  0x6f00-0x6f1f]
pci 0000:00:1a.7: [8086:283a] type 00 class 0x0c0320
pci 0000:00:1a.7: reg 10: [mem 0xfed1c400-0xfed1c7ff]
pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
pci 0000:00:1a.7: PME# disabled
pci 0000:00:1b.0: [8086:284b] type 00 class 0x040300
pci 0000:00:1b.0: reg 10: [mem 0xf6dfc000-0xf6dfffff 64bit]
pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1b.0: PME# disabled
pci 0000:00:1c.0: [8086:283f] type 01 class 0x060400
pci 0000:00:1c.0: calling pci_fixup_transparent_bridge+0x0/0x1d
pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.0: PME# disabled
pci 0000:00:1c.1: [8086:2841] type 01 class 0x060400
pci 0000:00:1c.1: calling pci_fixup_transparent_bridge+0x0/0x1d
pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.1: PME# disabled
pci 0000:00:1c.3: [8086:2845] type 01 class 0x060400
pci 0000:00:1c.3: calling pci_fixup_transparent_bridge+0x0/0x1d
pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.3: PME# disabled
pci 0000:00:1c.5: [8086:2849] type 01 class 0x060400
pci 0000:00:1c.5: calling pci_fixup_transparent_bridge+0x0/0x1d
pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.5: PME# disabled
pci 0000:00:1d.0: [8086:2830] type 00 class 0x0c0300
pci 0000:00:1d.0: reg 20: [io  0x6f80-0x6f9f]
pci 0000:00:1d.1: [8086:2831] type 00 class 0x0c0300
pci 0000:00:1d.1: reg 20: [io  0x6f60-0x6f7f]
pci 0000:00:1d.2: [8086:2832] type 00 class 0x0c0300
pci 0000:00:1d.2: reg 20: [io  0x6f40-0x6f5f]
pci 0000:00:1d.7: [8086:2836] type 00 class 0x0c0320
pci 0000:00:1d.7: reg 10: [mem 0xfed1c000-0xfed1c3ff]
pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
pci 0000:00:1d.7: PME# disabled
pci 0000:00:1e.0: [8086:2448] type 01 class 0x060401
pci 0000:00:1e.0: calling pci_fixup_transparent_bridge+0x0/0x1d
pci 0000:00:1f.0: [8086:2815] type 00 class 0x060100
pci 0000:00:1f.0: calling ich_force_enable_hpet+0x0/0x16f
pci 0000:00:1f.0: calling quirk_ich7_lpc+0x0/0x62
pci 0000:00:1f.0: quirk: [io  0x1000-0x107f] claimed by ICH6 ACPI/GPIO/TCO
pci 0000:00:1f.0: quirk: [io  0x1080-0x10bf] claimed by ICH6 GPIO
pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0900 (mask 007f)
pci 0000:00:1f.0: ICH7 LPC Generic IO decode 3 PIO at 0c80 (mask 003f)
pci 0000:00:1f.1: [8086:2850] type 00 class 0x01018a
pci 0000:00:1f.1: reg 10: [io  0x01f0-0x01f7]
pci 0000:00:1f.1: reg 14: [io  0x03f4-0x03f7]
pci 0000:00:1f.1: reg 18: [io  0x0170-0x0177]
pci 0000:00:1f.1: reg 1c: [io  0x0374-0x0377]
pci 0000:00:1f.1: reg 20: [io  0x6fa0-0x6faf]
pci 0000:00:1f.2: [8086:2829] type 00 class 0x010601
pci 0000:00:1f.2: reg 10: [io  0x6eb0-0x6eb7]
pci 0000:00:1f.2: reg 14: [io  0x6eb8-0x6ebb]
pci 0000:00:1f.2: reg 18: [io  0x6ec0-0x6ec7]
pci 0000:00:1f.2: reg 1c: [io  0x6ec8-0x6ecb]
pci 0000:00:1f.2: reg 20: [io  0x6ee0-0x6eff]
pci 0000:00:1f.2: reg 24: [mem 0xf6dfb800-0xf6dfbfff]
pci 0000:00:1f.2: PME# supported from D3hot
pci 0000:00:1f.2: PME# disabled
pci 0000:00:1f.3: [8086:283e] type 00 class 0x0c0500
pci 0000:00:1f.3: reg 10: [mem 0xf6dfb700-0xf6dfb7ff]
pci 0000:00:1f.3: reg 20: [io  0x10c0-0x10df]
pci_bus 0000:00: fixups for bus pass 0
pci 0000:00:1c.0: scanning [bus 0b-0b] behind bridge, pass 0
pci 0000:00:1c.0: check if busn 0b-0b is in busn_res: [bus 00-ff]
pci_bus 0000:0b: busn_res: [bus 0b] is inserted under [bus 00-ff]
pci_bus 0000:0b: scanning bus pass 0
pci_bus 0000:0b: fixups for bus pass 0
pci 0000:00:1c.0: PCI bridge to [bus 0b-0b]
pci_bus 0000:0b: bus scan returning with max=0b pass 0
pci 0000:00:1c.1: scanning [bus 0c-0c] behind bridge, pass 0
pci 0000:00:1c.1: check if busn 0c-0c is in busn_res: [bus 00-ff]
pci_bus 0000:0c: busn_res: [bus 0c] is inserted under [bus 00-ff]
pci_bus 0000:0c: scanning bus pass 0
pci 0000:0c:00.0: [8086:4229] type 00 class 0x028000
pci 0000:0c:00.0: reg 10: [mem 0xf6cfe000-0xf6cfffff 64bit]
pci 0000:0c:00.0: PME# supported from D0 D3hot D3cold
pci 0000:0c:00.0: PME# disabled
pci_bus 0000:0c: fixups for bus pass 0
pci 0000:00:1c.1: PCI bridge to [bus 0c-0c]
pci 0000:00:1c.1:   bridge window [mem 0xf6c00000-0xf6cfffff]
pci_bus 0000:0c: bus scan returning with max=0c pass 0
pci 0000:00:1c.3: scanning [bus 0d-0e] behind bridge, pass 0
pci 0000:00:1c.3: check if busn 0d-0e is in busn_res: [bus 00-ff]
pci_bus 0000:0d: busn_res: [bus 0d-0e] is inserted under [bus 00-ff]
pci_bus 0000:0d: scanning bus pass 0
pci_bus 0000:0d: fixups for bus pass 0
pci 0000:00:1c.3: PCI bridge to [bus 0d-0e]
pci 0000:00:1c.3:   bridge window [io  0xd000-0xdfff]
pci 0000:00:1c.3:   bridge window [mem 0xf6a00000-0xf6bfffff]
pci 0000:00:1c.3:   bridge window [mem 0xd0000000-0xd01fffff 64bit pref]
pci_bus 0000:0d: bus scan returning with max=0d pass 0
pci 0000:00:1c.5: scanning [bus 09-09] behind bridge, pass 0
pci 0000:00:1c.5: check if busn 09-09 is in busn_res: [bus 00-ff]
pci_bus 0000:09: busn_res: [bus 09] is inserted under [bus 00-ff]
pci_bus 0000:09: scanning bus pass 0
pci 0000:09:00.0: [14e4:1673] type 00 class 0x020000
pci 0000:09:00.0: reg 10: [mem 0xf69f0000-0xf69fffff 64bit]
pci 0000:09:00.0: PME# supported from D3hot D3cold
pci 0000:09:00.0: PME# disabled
pci_bus 0000:09: fixups for bus pass 0
pci 0000:00:1c.5: PCI bridge to [bus 09-09]
pci 0000:00:1c.5:   bridge window [mem 0xf6900000-0xf69fffff]
pci_bus 0000:09: bus scan returning with max=09 pass 0
pci 0000:00:1e.0: scanning [bus 03-05] behind bridge, pass 0
pci 0000:00:1e.0: check if busn 03-05 is in busn_res: [bus 00-ff]
pci_bus 0000:03: busn_res: [bus 03-05] is inserted under [bus 00-ff]
pci_bus 0000:03: scanning bus pass 0
pci 0000:03:01.0: [1217:7135] type 02 class 0x060700
pci 0000:03:01.0: reg 10: [mem 0x00000000-0x00000fff]
pci 0000:03:01.0: supports D1 D2
pci 0000:03:01.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:03:01.0: PME# disabled
pci 0000:03:01.4: [1217:00f7] type 00 class 0x0c0010
pci 0000:03:01.4: reg 10: [mem 0xf68ff000-0xf68fffff]
pci 0000:03:01.4: reg 14: [mem 0xf68fe800-0xf68fefff]
pci 0000:03:01.4: supports D1 D2
pci 0000:03:01.4: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:03:01.4: PME# disabled
pci 0000:03:08.0: [10b5:8112] type 01 class 0x060400
pci 0000:03:08.0: supports D1
pci 0000:03:08.0: PME# supported from D0 D1 D3hot
pci 0000:03:08.0: PME# disabled
pci_bus 0000:03: fixups for bus pass 0
pci 0000:00:1e.0: PCI bridge to [bus 03-05] (subtractive decode)
pci 0000:00:1e.0:   bridge window [io  0xc000-0xcfff]
pci 0000:00:1e.0:   bridge window [mem 0xf6600000-0xf68fffff]
pci 0000:00:1e.0:   bridge window [mem 0xd0200000-0xefffffff 64bit pref]
pci 0000:00:1e.0:   bridge window [io  0x0000-0xffff] (subtractive decode)
pci 0000:00:1e.0:   bridge window [mem 0x00000000-0xfffffffff] (subtractive decode)
pci 0000:03:01.0: scanning [bus 04-04] behind bridge, pass 0
pci 0000:03:01.0: check if busn 04-04 is in busn_res: [bus 03-05]
pci 0000:03:08.0: scanning [bus 05-05] behind bridge, pass 0
pci 0000:03:08.0: check if busn 05-05 is in busn_res: [bus 03-05]
pci_bus 0000:05: busn_res: [bus 05] is inserted under [bus 03-05]
pci_bus 0000:05: scanning bus pass 0
pci 0000:05:00.0: [1002:68e1] type 00 class 0x030000
pci 0000:05:00.0: reg 10: [mem 0xe0000000-0xefffffff 64bit pref]
pci 0000:05:00.0: reg 18: [mem 0xf66e0000-0xf66fffff 64bit]
pci 0000:05:00.0: reg 20: [io  0xce00-0xceff]
pci 0000:05:00.0: reg 30: [mem 0xf6700000-0xf671ffff pref]
pci 0000:05:00.0: supports D1 D2
pci 0000:05:00.1: [1002:aa68] type 00 class 0x040300
pci 0000:05:00.1: reg 10: [mem 0xf66dc000-0xf66dffff 64bit]
pci 0000:05:00.1: supports D1 D2
pci_bus 0000:05: fixups for bus pass 0
pci 0000:03:08.0: PCI bridge to [bus 05-05]
pci 0000:03:08.0:   bridge window [io  0xc000-0xcfff]
pci 0000:03:08.0:   bridge window [mem 0xf6600000-0xf67fffff]
pci 0000:03:08.0:   bridge window [mem 0xd0200000-0xefffffff pref]
pci_bus 0000:05: bus scan returning with max=05 pass 0
pci_bus 0000:03: bus scan returning with max=05 pass 0
pci_bus 0000:00: bus scan returning with max=0e pass 0
pci_bus 0000:00: scanning bus pass 1
pci 0000:00:1c.0: scanning [bus 0b-0b] behind bridge, pass 1
pci_bus 0000:0b: scanning bus pass 1
pci_bus 0000:0b: fixups for bus pass 1
pci 0000:00:1c.0: PCI bridge to [bus 0b-0b]
pci_bus 0000:0b: bus scan returning with max=0b pass 1
pci 0000:00:1c.1: scanning [bus 0c-0c] behind bridge, pass 1
pci_bus 0000:0c: scanning bus pass 1
pci_bus 0000:0c: fixups for bus pass 1
pci 0000:00:1c.1: PCI bridge to [bus 0c-0c]
pci 0000:00:1c.1:   bridge window [mem 0xf6c00000-0xf6cfffff]
pci_bus 0000:0c: bus scan returning with max=0c pass 1
pci 0000:00:1c.3: scanning [bus 0d-0e] behind bridge, pass 1
pci_bus 0000:0d: scanning bus pass 1
pci_bus 0000:0d: fixups for bus pass 1
pci 0000:00:1c.3: PCI bridge to [bus 0d-0e]
pci 0000:00:1c.3:   bridge window [io  0xd000-0xdfff]
pci 0000:00:1c.3:   bridge window [mem 0xf6a00000-0xf6bfffff]
pci 0000:00:1c.3:   bridge window [mem 0xd0000000-0xd01fffff 64bit pref]
pci_bus 0000:0d: bus scan returning with max=0d pass 1
pci 0000:00:1c.5: scanning [bus 09-09] behind bridge, pass 1
pci_bus 0000:09: scanning bus pass 1
pci_bus 0000:09: fixups for bus pass 1
pci 0000:00:1c.5: PCI bridge to [bus 09-09]
pci 0000:00:1c.5:   bridge window [mem 0xf6900000-0xf69fffff]
pci_bus 0000:09: bus scan returning with max=09 pass 1
pci 0000:00:1e.0: scanning [bus 03-05] behind bridge, pass 1
pci_bus 0000:03: scanning bus pass 1
pci_bus 0000:03: fixups for bus pass 1
pci 0000:00:1e.0: PCI bridge to [bus 03-05] (subtractive decode)
pci 0000:00:1e.0:   bridge window [io  0xc000-0xcfff]
pci 0000:00:1e.0:   bridge window [mem 0xf6600000-0xf68fffff]
pci 0000:00:1e.0:   bridge window [mem 0xd0200000-0xefffffff 64bit pref]
pci 0000:00:1e.0:   bridge window [io  0x0000-0xffff] (subtractive decode)
pci 0000:00:1e.0:   bridge window [mem 0x00000000-0xfffffffff] (subtractive decode)
pci 0000:03:01.0: scanning [bus 04-04] behind bridge, pass 1
pci 0000:03:01.0: find free busn in res: [bus 03-05]
pci 0000:03:01.0: found free busn 0 in res: [bus 03-05] top
pci 0000:03:01.0: find free busn in res: [bus 03-05]
pci 0000:03:01.0: found free busn 0 in res: [bus 03-05] top
pci_bus 0000:03: busn_res: extended 03 to [bus 03-08]
pci_bus 0000:06: busn_res: [bus 06-08] is updated under [bus 03-08]
pci_bus 0000:06: busn_res: [bus 06-08] end updated to [bus 06-08]
pci 0000:03:08.0: scanning [bus 05-05] behind bridge, pass 1
pci_bus 0000:05: scanning bus pass 1
pci_bus 0000:05: fixups for bus pass 1
pci 0000:03:08.0: PCI bridge to [bus 05-05]
pci 0000:03:08.0:   bridge window [io  0xc000-0xcfff]
pci 0000:03:08.0:   bridge window [mem 0xf6600000-0xf67fffff]
pci 0000:03:08.0:   bridge window [mem 0xd0200000-0xefffffff pref]
pci_bus 0000:05: bus scan returning with max=05 pass 1
pci_bus 0000:03: bus scan returning with max=08 pass 1
pci_bus 0000:00: bus scan returning with max=0e pass 1
pci_bus 0000:00: on NUMA node 0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP06._PRT]
 pci0000:00: Requesting ACPI _OSC control (0x1d)
 pci0000:00: ACPI _OSC request failed (AE_NOT_FOUND), returned control mask: 0x1d
ACPI _OSC control for PCIe not granted, disabling ASPM
ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7) *3
ACPI: PCI Interrupt Link [LNKC] (IRQs 9 *10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
vgaarb: device added: PCI:0000:05:00.0,decodes=io+mem,owns=none,locks=none
vgaarb: loaded
vgaarb: bridge control possible 0000:05:00.0
vgaarb: no bridge control possible 0000:00:02.0
PCI: Using ACPI for IRQ routing
PCI: pci_cache_line_size set to 64 bytes
pci 0000:00:1c.3: address space collision: [mem 0xd0000000-0xd01fffff 64bit pref] conflicts with System RAM [mem 0x00100000-0xdf65a7ff]
pci 0000:00:1e.0: address space collision: [mem 0xd0200000-0xefffffff 64bit pref] conflicts with System RAM [mem 0x00100000-0xdf65a7ff]
pci 0000:03:08.0: address space collision: [mem 0xd0200000-0xefffffff pref] conflicts with System RAM [mem 0x00100000-0xdf65a7ff]
pci 0000:00:02.0: BAR 0: reserving [mem 0xf6e00000-0xf6efffff flags 0x140204] (d=0, p=0)
pci 0000:00:02.0: BAR 2: reserving [mem 0xc0000000-0xcfffffff flags 0x14220c] (d=0, p=0)
pci 0000:00:02.0: address space collision: [mem 0xc0000000-0xcfffffff 64bit pref] conflicts with System RAM [mem 0x00100000-0xdf65a7ff]
pci 0000:00:02.0: BAR 4: reserving [io  0xeff8-0xefff flags 0x40101] (d=0, p=0)
pci 0000:00:02.1: BAR 0: reserving [mem 0xf6f00000-0xf6ffffff flags 0x140204] (d=0, p=0)
pci 0000:00:1a.0: BAR 4: reserving [io  0x6f20-0x6f3f flags 0x40101] (d=0, p=0)
pci 0000:00:1a.1: BAR 4: reserving [io  0x6f00-0x6f1f flags 0x40101] (d=0, p=0)
pci 0000:00:1a.7: BAR 0: reserving [mem 0xfed1c400-0xfed1c7ff flags 0x40200] (d=0, p=0)
pci 0000:00:1b.0: BAR 0: reserving [mem 0xf6dfc000-0xf6dfffff flags 0x140204] (d=0, p=0)
pci 0000:00:1d.0: BAR 4: reserving [io  0x6f80-0x6f9f flags 0x40101] (d=0, p=0)
pci 0000:00:1d.1: BAR 4: reserving [io  0x6f60-0x6f7f flags 0x40101] (d=0, p=0)
pci 0000:00:1d.2: BAR 4: reserving [io  0x6f40-0x6f5f flags 0x40101] (d=0, p=0)
pci 0000:00:1d.7: BAR 0: reserving [mem 0xfed1c000-0xfed1c3ff flags 0x40200] (d=0, p=0)
pci 0000:00:1f.1: BAR 0: reserving [io  0x01f0-0x01f7 flags 0x110] (d=0, p=0)
pci 0000:00:1f.1: BAR 1: reserving [io  0x03f6 flags 0x110] (d=0, p=0)
pci 0000:00:1f.1: BAR 2: reserving [io  0x0170-0x0177 flags 0x110] (d=0, p=0)
pci 0000:00:1f.1: BAR 3: reserving [io  0x0376 flags 0x110] (d=0, p=0)
pci 0000:00:1f.1: BAR 4: reserving [io  0x6fa0-0x6faf flags 0x40101] (d=0, p=0)
pci 0000:00:1f.2: BAR 0: reserving [io  0x6eb0-0x6eb7 flags 0x40101] (d=0, p=0)
pci 0000:00:1f.2: BAR 1: reserving [io  0x6eb8-0x6ebb flags 0x40101] (d=0, p=0)
pci 0000:00:1f.2: BAR 2: reserving [io  0x6ec0-0x6ec7 flags 0x40101] (d=0, p=0)
pci 0000:00:1f.2: BAR 3: reserving [io  0x6ec8-0x6ecb flags 0x40101] (d=0, p=0)
pci 0000:00:1f.2: BAR 4: reserving [io  0x6ee0-0x6eff flags 0x40101] (d=0, p=0)
pci 0000:00:1f.2: BAR 5: reserving [mem 0xf6dfb800-0xf6dfbfff flags 0x40200] (d=0, p=0)
pci 0000:00:1f.3: BAR 0: reserving [mem 0xf6dfb700-0xf6dfb7ff flags 0x40200] (d=0, p=0)
pci 0000:00:1f.3: BAR 4: reserving [io  0x10c0-0x10df flags 0x40101] (d=0, p=0)
pci 0000:0c:00.0: BAR 0: reserving [mem 0xf6cfe000-0xf6cfffff flags 0x140204] (d=0, p=0)
pci 0000:09:00.0: BAR 0: reserving [mem 0xf69f0000-0xf69fffff flags 0x140204] (d=0, p=0)
pci 0000:03:01.4: BAR 0: reserving [mem 0xf68ff000-0xf68fffff flags 0x40200] (d=0, p=0)
pci 0000:03:01.4: BAR 1: reserving [mem 0xf68fe800-0xf68fefff flags 0x40200] (d=0, p=0)
pci 0000:05:00.1: BAR 0: reserving [mem 0xf66dc000-0xf66dffff flags 0x140204] (d=0, p=0)
pci 0000:05:00.0: BAR 0: reserving [mem 0xe0000000-0xefffffff flags 0x14220c] (d=1, p=1)
pci 0000:05:00.0: no compatible bridge window for [mem 0xe0000000-0xefffffff 64bit pref]
pci 0000:05:00.0: BAR 2: reserving [mem 0xf66e0000-0xf66fffff flags 0x140204] (d=1, p=1)
pci 0000:05:00.0: BAR 4: reserving [io  0xce00-0xceff flags 0x40101] (d=1, p=1)
reserve RAM buffer: 000000000009f000 - 000000000009ffff 
reserve RAM buffer: 00000000df65a800 - 00000000dfffffff 
HPET: 3 timers in total, 0 timers will be used for per-cpu timer
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 3 comparators, 64-bit 14.318180 MHz counter
Switching to clocksource hpet
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp 00:00: [bus 00-ff]
pnp 00:00: [io  0x0000-0x0cf7 window]
pnp 00:00: [io  0x0cf8-0x0cff]
pnp 00:00: [io  0x0d00-0xffff window]
pnp 00:00: [mem 0x000a0000-0x000bffff window]
pnp 00:00: [mem 0x000d0000-0x000dffff window]
pnp 00:00: [mem 0xe0000000-0xf7ffffff window]
pnp 00:00: [mem 0xfc000000-0xfebfffff window]
pnp 00:00: [mem 0xfec10000-0xfecfffff window]
pnp 00:00: [mem 0xfed1c000-0xfed1ffff window]
pnp 00:00: [mem 0xfed90000-0xfed9ffff window]
pnp 00:00: [mem 0xfed40000-0xfed44fff window]
pnp 00:00: [mem 0xfeda7000-0xfedfffff window]
pnp 00:00: [mem 0xfee10000-0xff9fffff window]
pnp 00:00: [mem 0xffc00000-0xffdfffff window]
pnp 00:00: Plug and Play ACPI device, IDs PNP0a03 (active)
pnp 00:01: [irq 12]
pnp 00:01: Plug and Play ACPI device, IDs PNP0f13 (active)
pnp 00:02: [io  0x0060]
pnp 00:02: [io  0x0064]
pnp 00:02: [io  0x0062]
pnp 00:02: [io  0x0066]
pnp 00:02: [irq 1]
pnp 00:02: Plug and Play ACPI device, IDs PNP0303 (active)
pnp 00:03: [io  0x0070-0x0071]
pnp 00:03: [irq 8]
pnp 00:03: [io  0x0072-0x0077]
pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (active)
pnp 00:04: [io  0x0061]
pnp 00:04: [io  0x0063]
pnp 00:04: [io  0x0065]
pnp 00:04: [io  0x0067]
pnp 00:04: Plug and Play ACPI device, IDs PNP0800 (active)
pnp 00:05: [io  0x002e-0x002f]
pnp 00:05: [io  0x0c80-0x0caf]
pnp 00:05: [io  0x0cc0-0x0cff]
pnp 00:05: [io  0x004e-0x004f]
system 00:05: [io  0x0c80-0x0caf] has been reserved
system 00:05: [io  0x0cc0-0x0cff] could not be reserved
system 00:05: Plug and Play ACPI device, IDs PNP0c01 (active)
pnp 00:06: [dma 4]
pnp 00:06: [io  0x0000-0x000f]
pnp 00:06: [io  0x0080-0x0085]
pnp 00:06: [io  0x0087-0x008f]
pnp 00:06: [io  0x00c0-0x00df]
pnp 00:06: [io  0x0010-0x001f]
pnp 00:06: [io  0x0090-0x0091]
pnp 00:06: [io  0x0093-0x009f]
pnp 00:06: Plug and Play ACPI device, IDs PNP0200 (active)
pnp 00:07: [io  0x00f0-0x00ff]
pnp 00:07: [irq 13]
pnp 00:07: Plug and Play ACPI device, IDs PNP0c04 (active)
pnp 00:08: [mem 0xfed00000-0xfed003ff]
system 00:08: [mem 0xfed00000-0xfed003ff] has been reserved
system 00:08: Plug and Play ACPI device, IDs PNP0103 PNP0c01 (active)
pnp 00:09: [irq 4]
pnp 00:09: [io  0x03f8-0x03ff]
pnp 00:09: Plug and Play ACPI device, IDs PNP0501 (active)
pnp 00:0a: [dma 1]
pnp 00:0a: [irq 7]
pnp 00:0a: [io  0x0378-0x037f]
pnp 00:0a: [io  0x0778-0x077b]
pnp 00:0a: Plug and Play ACPI device, IDs PNP0401 (active)
pnp 00:0b: [mem 0xfed40000-0xfed44fff]
pnp 00:0b: [io  0x0cb0-0x0cbb]
system 00:0b: [io  0x0cb0-0x0cbb] has been reserved
system 00:0b: [mem 0xfed40000-0xfed44fff] has been reserved
system 00:0b: Plug and Play ACPI device, IDs PNP0c01 (active)
pnp 00:0c: [io  0x0900-0x097f]
pnp 00:0c: [io  0x0092]
pnp 00:0c: [io  0x00b2-0x00b3]
pnp 00:0c: [io  0x0020-0x0021]
pnp 00:0c: [io  0x00a0-0x00a1]
pnp 00:0c: [irq 0 disabled]
pnp 00:0c: [io  0x04d0-0x04d1]
pnp 00:0c: [io  0x1000-0x1005]
pnp 00:0c: [io  0x1008-0x100f]
pnp 00:0c: disabling [io  0x1000-0x1005] because it overlaps 0000:00:1f.0 BAR 13 [io  0x1000-0x107f]
pnp 00:0c: disabling [io  0x1008-0x100f] because it overlaps 0000:00:1f.0 BAR 13 [io  0x1000-0x107f]
system 00:0c: [io  0x0900-0x097f] has been reserved
system 00:0c: [io  0x04d0-0x04d1] has been reserved
system 00:0c: Plug and Play ACPI device, IDs PNP0c01 (active)
pnp 00:0d: [io  0xf400-0xf4fe]
pnp 00:0d: [io  0x0086]
pnp 00:0d: [io  0x1006-0x1007]
pnp 00:0d: [io  0x100a-0x1059]
pnp 00:0d: [io  0x1060-0x107f]
pnp 00:0d: [io  0x1080-0x10bf]
pnp 00:0d: [io  0x10c0-0x10df]
pnp 00:0d: [io  0x1010-0x102f]
pnp 00:0d: [io  0x0809]
pnp 00:0d: disabling [io  0x1006-0x1007] because it overlaps 0000:00:1f.0 BAR 13 [io  0x1000-0x107f]
pnp 00:0d: disabling [io  0x100a-0x1059] because it overlaps 0000:00:1f.0 BAR 13 [io  0x1000-0x107f]
pnp 00:0d: disabling [io  0x1060-0x107f] because it overlaps 0000:00:1f.0 BAR 13 [io  0x1000-0x107f]
pnp 00:0d: disabling [io  0x1010-0x102f] because it overlaps 0000:00:1f.0 BAR 13 [io  0x1000-0x107f]
system 00:0d: [io  0xf400-0xf4fe] has been reserved
system 00:0d: [io  0x1080-0x10bf] has been reserved
system 00:0d: [io  0x10c0-0x10df] has been reserved
system 00:0d: [io  0x0809] has been reserved
system 00:0d: Plug and Play ACPI device, IDs PNP0c01 (active)
pnp 00:0e: [mem 0x00000000-0x0009efff]
pnp 00:0e: [mem 0x0009f000-0x0009ffff]
pnp 00:0e: [mem 0x000c0000-0x000cffff]
pnp 00:0e: [mem 0x000e0000-0x000fffff]
pnp 00:0e: [mem 0x00100000-0xdf65a7ff]
pnp 00:0e: [mem 0xdf65a800-0xdf6fffff]
pnp 00:0e: [mem 0xdf700000-0xdf7fffff]
pnp 00:0e: [mem 0xdf700000-0xdfefffff]
pnp 00:0e: [mem 0xffe00000-0xffffffff]
pnp 00:0e: [mem 0xffa00000-0xffbfffff]
pnp 00:0e: [mem 0xfec00000-0xfec0ffff]
pnp 00:0e: [mem 0xfee00000-0xfee0ffff]
pnp 00:0e: [mem 0xfed20000-0xfed3ffff]
pnp 00:0e: [mem 0xfed45000-0xfed8ffff]
pnp 00:0e: [mem 0xfeda0000-0xfeda3fff]
pnp 00:0e: [mem 0xfeda4000-0xfeda4fff]
pnp 00:0e: [mem 0xfeda5000-0xfeda5fff]
pnp 00:0e: [mem 0xfeda6000-0xfeda6fff]
pnp 00:0e: [mem 0xfed18000-0xfed1bfff]
pnp 00:0e: [mem 0xf8000000-0xfbffffff]
pnp 00:0e: disabling [mem 0x00000000-0x0009efff] because it overlaps 0000:00:02.0 BAR 2 [mem 0x00000000-0x0fffffff 64bit pref]
pnp 00:0e: disabling [mem 0x0009f000-0x0009ffff] because it overlaps 0000:00:02.0 BAR 2 [mem 0x00000000-0x0fffffff 64bit pref]
pnp 00:0e: disabling [mem 0x000c0000-0x000cffff] because it overlaps 0000:00:02.0 BAR 2 [mem 0x00000000-0x0fffffff 64bit pref]
pnp 00:0e: disabling [mem 0x000e0000-0x000fffff] because it overlaps 0000:00:02.0 BAR 2 [mem 0x00000000-0x0fffffff 64bit pref]
pnp 00:0e: disabling [mem 0x00100000-0xdf65a7ff] because it overlaps 0000:00:02.0 BAR 2 [mem 0x00000000-0x0fffffff 64bit pref]
pnp 00:0e: disabling [mem 0x00000000-0x0009efff disabled] because it overlaps 0000:05:00.0 BAR 0 [mem 0x00000000-0x0fffffff 64bit pref]
pnp 00:0e: disabling [mem 0x0009f000-0x0009ffff disabled] because it overlaps 0000:05:00.0 BAR 0 [mem 0x00000000-0x0fffffff 64bit pref]
pnp 00:0e: disabling [mem 0x000c0000-0x000cffff disabled] because it overlaps 0000:05:00.0 BAR 0 [mem 0x00000000-0x0fffffff 64bit pref]
pnp 00:0e: disabling [mem 0x000e0000-0x000fffff disabled] because it overlaps 0000:05:00.0 BAR 0 [mem 0x00000000-0x0fffffff 64bit pref]
pnp 00:0e: disabling [mem 0x00100000-0xdf65a7ff disabled] because it overlaps 0000:05:00.0 BAR 0 [mem 0x00000000-0x0fffffff 64bit pref]
system 00:0e: [mem 0xdf65a800-0xdf6fffff] has been reserved
system 00:0e: [mem 0xdf700000-0xdf7fffff] has been reserved
system 00:0e: [mem 0xdf700000-0xdfefffff] could not be reserved
system 00:0e: [mem 0xffe00000-0xffffffff] has been reserved
system 00:0e: [mem 0xffa00000-0xffbfffff] has been reserved
system 00:0e: [mem 0xfec00000-0xfec0ffff] could not be reserved
system 00:0e: [mem 0xfee00000-0xfee0ffff] has been reserved
system 00:0e: [mem 0xfed20000-0xfed3ffff] has been reserved
system 00:0e: [mem 0xfed45000-0xfed8ffff] has been reserved
system 00:0e: [mem 0xfeda0000-0xfeda3fff] has been reserved
system 00:0e: [mem 0xfeda4000-0xfeda4fff] has been reserved
system 00:0e: [mem 0xfeda5000-0xfeda5fff] has been reserved
system 00:0e: [mem 0xfeda6000-0xfeda6fff] has been reserved
system 00:0e: [mem 0xfed18000-0xfed1bfff] has been reserved
system 00:0e: [mem 0xf8000000-0xfbffffff] has been reserved
system 00:0e: Plug and Play ACPI device, IDs PNP0c01 (active)
pnp: PnP ACPI: found 15 devices
ACPI: ACPI bus type pnp unregistered
PCI: max bus depth: 2 pci_try_num: 3
pci 0000:00:02.0: BAR 2: assigned [mem 0x120000000-0x12fffffff 64bit pref]
pci 0000:00:02.0: BAR 2: set to [mem 0x120000000-0x12fffffff 64bit pref] (PCI address [0x120000000-0x12fffffff])
pci 0000:00:1e.0: BAR 15: can't assign mem pref (size 0x18000000)
pci 0000:00:1c.0: BAR 14: assigned [mem 0xe0000000-0xe01fffff]
pci 0000:00:1c.0: BAR 15: assigned [mem 0x130000000-0x1301fffff 64bit pref]
pci 0000:00:1c.1: BAR 15: assigned [mem 0x130200000-0x1303fffff 64bit pref]
pci 0000:00:1c.3: BAR 15: assigned [mem 0x130400000-0x1305fffff 64bit pref]
pci 0000:00:1c.5: BAR 15: assigned [mem 0x130600000-0x1307fffff 64bit pref]
pci 0000:00:1c.0: BAR 13: assigned [io  0x2000-0x2fff]
pci 0000:00:1c.1: BAR 13: assigned [io  0x3000-0x3fff]
pci 0000:00:1c.5: BAR 13: assigned [io  0x4000-0x4fff]
pci 0000:00:1c.0: PCI bridge to [bus 0b-0b]
pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
pci 0000:00:1c.0:   bridge window [mem 0xe0000000-0xe01fffff]
pci 0000:00:1c.0:   bridge window [mem 0x130000000-0x1301fffff 64bit pref]
pci 0000:00:1c.1: PCI bridge to [bus 0c-0c]
pci 0000:00:1c.1:   bridge window [io  0x3000-0x3fff]
pci 0000:00:1c.1:   bridge window [mem 0xf6c00000-0xf6cfffff]
pci 0000:00:1c.1:   bridge window [mem 0x130200000-0x1303fffff 64bit pref]
pci 0000:00:1c.3: PCI bridge to [bus 0d-0e]
pci 0000:00:1c.3:   bridge window [io  0xd000-0xdfff]
pci 0000:00:1c.3:   bridge window [mem 0xf6a00000-0xf6bfffff]
pci 0000:00:1c.3:   bridge window [mem 0x130400000-0x1305fffff 64bit pref]
pci 0000:00:1c.5: PCI bridge to [bus 09-09]
pci 0000:00:1c.5:   bridge window [io  0x4000-0x4fff]
pci 0000:00:1c.5:   bridge window [mem 0xf6900000-0xf69fffff]
pci 0000:00:1c.5:   bridge window [mem 0x130600000-0x1307fffff 64bit pref]
pci 0000:03:08.0: BAR 15: can't assign mem pref (size 0x10000000)
pci 0000:03:01.0: BAR 0: assigned [mem 0xe4000000-0xe4000fff]
pci 0000:03:01.0: BAR 0: set to [mem 0xe4000000-0xe4000fff] (PCI address [0xe4000000-0xe4000fff])
pci 0000:03:01.0: BAR 15: assigned [mem 0xe8000000-0xebffffff pref]
pci 0000:03:01.0: BAR 16: assigned [mem 0xec000000-0xefffffff]
pci 0000:03:01.0: BAR 13: assigned [io  0x1400-0x14ff]
pci 0000:03:01.0: BAR 14: assigned [io  0x1800-0x18ff]
pci 0000:03:01.0: CardBus bridge to [bus 06-08]
pci 0000:03:01.0:   bridge window [io  0x1400-0x14ff]
pci 0000:03:01.0:   bridge window [io  0x1800-0x18ff]
pci 0000:03:01.0:   bridge window [mem 0xe8000000-0xebffffff pref]
pci 0000:03:01.0:   bridge window [mem 0xec000000-0xefffffff]
pci 0000:05:00.0: BAR 0: can't assign mem pref (size 0x10000000)
pci 0000:05:00.0: BAR 0: trying firmware assignment [mem 0xe0000000-0xefffffff 64bit pref]
pci 0000:05:00.0: BAR 0: [mem 0xe0000000-0xefffffff 64bit pref] conflicts with PCI Bus 0000:0b [mem 0xe0000000-0xe01fffff]
pci 0000:03:08.0: PCI bridge to [bus 05-05]
pci 0000:03:08.0:   bridge window [io  0xc000-0xcfff]
pci 0000:03:08.0:   bridge window [mem 0xf6600000-0xf67fffff]
pci 0000:00:1e.0: PCI bridge to [bus 03-08]
pci 0000:00:1e.0:   bridge window [io  0xc000-0xcfff]
pci 0000:00:1e.0:   bridge window [mem 0xf6600000-0xf68fffff]
PCI: No. 2 try to assign unassigned res
pci 0000:00:1e.0: BAR 15: can't assign mem pref (size 0x10000000)
pci 0000:00:1c.0: PCI bridge to [bus 0b-0b]
pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
pci 0000:00:1c.0:   bridge window [mem 0xe0000000-0xe01fffff]
pci 0000:00:1c.0:   bridge window [mem 0x130000000-0x1301fffff 64bit pref]
pci 0000:00:1c.1: PCI bridge to [bus 0c-0c]
pci 0000:00:1c.1:   bridge window [io  0x3000-0x3fff]
pci 0000:00:1c.1:   bridge window [mem 0xf6c00000-0xf6cfffff]
pci 0000:00:1c.1:   bridge window [mem 0x130200000-0x1303fffff 64bit pref]
pci 0000:00:1c.3: PCI bridge to [bus 0d-0e]
pci 0000:00:1c.3:   bridge window [io  0xd000-0xdfff]
pci 0000:00:1c.3:   bridge window [mem 0xf6a00000-0xf6bfffff]
pci 0000:00:1c.3:   bridge window [mem 0x130400000-0x1305fffff 64bit pref]
pci 0000:00:1c.5: PCI bridge to [bus 09-09]
pci 0000:00:1c.5:   bridge window [io  0x4000-0x4fff]
pci 0000:00:1c.5:   bridge window [mem 0xf6900000-0xf69fffff]
pci 0000:00:1c.5:   bridge window [mem 0x130600000-0x1307fffff 64bit pref]
pci 0000:03:08.0: BAR 15: can't assign mem pref (size 0x10000000)
pci 0000:03:01.0: CardBus bridge to [bus 06-08]
pci 0000:03:01.0:   bridge window [io  0x1400-0x14ff]
pci 0000:03:01.0:   bridge window [io  0x1800-0x18ff]
pci 0000:03:01.0:   bridge window [mem 0xe8000000-0xebffffff pref]
pci 0000:03:01.0:   bridge window [mem 0xec000000-0xefffffff]
pci 0000:05:00.0: BAR 0: can't assign mem pref (size 0x10000000)
pci 0000:05:00.0: BAR 0: trying firmware assignment [mem 0xe0000000-0xefffffff 64bit pref]
pci 0000:05:00.0: BAR 0: [mem 0xe0000000-0xefffffff 64bit pref] conflicts with PCI Bus 0000:0b [mem 0xe0000000-0xe01fffff]
pci 0000:03:08.0: PCI bridge to [bus 05-05]
pci 0000:03:08.0:   bridge window [io  0xc000-0xcfff]
pci 0000:03:08.0:   bridge window [mem 0xf6600000-0xf67fffff]
pci 0000:00:1e.0: PCI bridge to [bus 03-08]
pci 0000:00:1e.0:   bridge window [io  0xc000-0xcfff]
pci 0000:00:1e.0:   bridge window [mem 0xf6600000-0xf68fffff]
PCI: No. 3 try to assign unassigned res
pci 0000:00:1e.0: BAR 15: can't assign mem pref (size 0x10000000)
pci 0000:00:1c.0: PCI bridge to [bus 0b-0b]
pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
pci 0000:00:1c.0:   bridge window [mem 0xe0000000-0xe01fffff]
pci 0000:00:1c.0:   bridge window [mem 0x130000000-0x1301fffff 64bit pref]
pci 0000:00:1c.1: PCI bridge to [bus 0c-0c]
pci 0000:00:1c.1:   bridge window [io  0x3000-0x3fff]
pci 0000:00:1c.1:   bridge window [mem 0xf6c00000-0xf6cfffff]
pci 0000:00:1c.1:   bridge window [mem 0x130200000-0x1303fffff 64bit pref]
pci 0000:00:1c.3: PCI bridge to [bus 0d-0e]
pci 0000:00:1c.3:   bridge window [io  0xd000-0xdfff]
pci 0000:00:1c.3:   bridge window [mem 0xf6a00000-0xf6bfffff]
pci 0000:00:1c.3:   bridge window [mem 0x130400000-0x1305fffff 64bit pref]
pci 0000:00:1c.5: PCI bridge to [bus 09-09]
pci 0000:00:1c.5:   bridge window [io  0x4000-0x4fff]
pci 0000:00:1c.5:   bridge window [mem 0xf6900000-0xf69fffff]
pci 0000:00:1c.5:   bridge window [mem 0x130600000-0x1307fffff 64bit pref]
pci 0000:03:08.0: BAR 15: can't assign mem pref (size 0x10000000)
pci 0000:03:01.0: CardBus bridge to [bus 06-08]
pci 0000:03:01.0:   bridge window [io  0x1400-0x14ff]
pci 0000:03:01.0:   bridge window [io  0x1800-0x18ff]
pci 0000:03:01.0:   bridge window [mem 0xe8000000-0xebffffff pref]
pci 0000:03:01.0:   bridge window [mem 0xec000000-0xefffffff]
pci 0000:05:00.0: BAR 0: can't assign mem pref (size 0x10000000)
pci 0000:05:00.0: BAR 0: trying firmware assignment [mem 0xe0000000-0xefffffff 64bit pref]
pci 0000:05:00.0: BAR 0: [mem 0xe0000000-0xefffffff 64bit pref] conflicts with PCI Bus 0000:0b [mem 0xe0000000-0xe01fffff]
pci 0000:03:08.0: PCI bridge to [bus 05-05]
pci 0000:03:08.0:   bridge window [io  0xc000-0xcfff]
pci 0000:03:08.0:   bridge window [mem 0xf6600000-0xf67fffff]
pci 0000:00:1e.0: PCI bridge to [bus 03-08]
pci 0000:00:1e.0:   bridge window [io  0xc000-0xcfff]
pci 0000:00:1e.0:   bridge window [mem 0xf6600000-0xf68fffff]
pci 0000:00:1e.0: setting latency timer to 64
pci 0000:03:01.0: enabling device (0000 -> 0003)
pci 0000:03:01.0: enabling bus mastering
pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
pci_bus 0000:00: resource 5 [mem 0x00000000-0xfffffffff]
pci_bus 0000:0b: resource 0 [io  0x2000-0x2fff]
pci_bus 0000:0b: resource 1 [mem 0xe0000000-0xe01fffff]
pci_bus 0000:0b: resource 2 [mem 0x130000000-0x1301fffff 64bit pref]
pci_bus 0000:0c: resource 0 [io  0x3000-0x3fff]
pci_bus 0000:0c: resource 1 [mem 0xf6c00000-0xf6cfffff]
pci_bus 0000:0c: resource 2 [mem 0x130200000-0x1303fffff 64bit pref]
pci_bus 0000:0d: resource 0 [io  0xd000-0xdfff]
pci_bus 0000:0d: resource 1 [mem 0xf6a00000-0xf6bfffff]
pci_bus 0000:0d: resource 2 [mem 0x130400000-0x1305fffff 64bit pref]
pci_bus 0000:09: resource 0 [io  0x4000-0x4fff]
pci_bus 0000:09: resource 1 [mem 0xf6900000-0xf69fffff]
pci_bus 0000:09: resource 2 [mem 0x130600000-0x1307fffff 64bit pref]
pci_bus 0000:03: resource 0 [io  0xc000-0xcfff]
pci_bus 0000:03: resource 1 [mem 0xf6600000-0xf68fffff]
pci_bus 0000:03: resource 4 [io  0x0000-0xffff]
pci_bus 0000:03: resource 5 [mem 0x00000000-0xfffffffff]
pci_bus 0000:06: resource 0 [io  0x1400-0x14ff]
pci_bus 0000:06: resource 1 [io  0x1800-0x18ff]
pci_bus 0000:06: resource 2 [mem 0xe8000000-0xebffffff pref]
pci_bus 0000:06: resource 3 [mem 0xec000000-0xefffffff]
pci_bus 0000:05: resource 0 [io  0xc000-0xcfff]
pci_bus 0000:05: resource 1 [mem 0xf6600000-0xf67fffff]
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP: reno registered
UDP hash table entries: 2048 (order: 4, 65536 bytes)
UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes)
NET: Registered protocol family 1
pci 0000:00:02.0: calling pci_fixup_video+0x0/0x94
pci 0000:00:02.0: Boot video device
pci 0000:00:1a.0: calling quirk_usb_early_handoff+0x0/0x5f8
pci 0000:00:1a.1: calling quirk_usb_early_handoff+0x0/0x5f8
pci 0000:00:1a.7: calling quirk_usb_early_handoff+0x0/0x5f8
pci 0000:00:1d.0: calling quirk_usb_early_handoff+0x0/0x5f8
pci 0000:00:1d.1: calling quirk_usb_early_handoff+0x0/0x5f8
pci 0000:00:1d.2: calling quirk_usb_early_handoff+0x0/0x5f8
pci 0000:00:1d.7: calling quirk_usb_early_handoff+0x0/0x5f8
pci 0000:03:01.0: calling quirk_cardbus_legacy+0x0/0x17
pci 0000:05:00.0: calling pci_fixup_video+0x0/0x94
PCI: CLS 64 bytes, default 64
Trying to unpack rootfs image as initramfs...
Freeing initrd memory: 5724k freed
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Placing 64MB software IO TLB between ffff8800db654000 - ffff8800df654000
software IO TLB at phys 0xdb654000 - 0xdf654000
Simple Boot Flag at 0x79 set to 0x1
sha1_ssse3: Using SSSE3 optimized SHA-1 implementation
audit: initializing netlink socket (disabled)
type=2000 audit(1334090223.077:1): initialized
Testing tracer function: PASSED
Testing dynamic ftrace: PASSED
Testing dynamic ftrace ops #1: (1 0 1 1 0) (1 1 2 1 0) (2 1 3 1 9) (2 2 4 1 159) PASSED
Testing dynamic ftrace ops #2: (1 0 1 4 0) (1 1 2 139 0) (2 1 3 2 75) (2 2 4 156 228) PASSED
Testing tracer wakeup: PASSED
Testing tracer wakeup_rt: 
Refined TSC clocksource calibration: 2393.999 MHz.
Switching to clocksource tsc
PASSED
Testing tracer function_graph: PASSED
HugeTLB registered 2 MB page size, pre-allocated 0 pages
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
msgmni has been set to 7885
alg: No test for snappy (snappy-generic)
alg: No test for stdrng (krng)
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler cfq registered (default)
list_sort_test: start testing list_sort()
crc32: CRC_LE_BITS = 64, CRC_BE BITS = 64
crc32: self tests passed, processed 225944 bytes in 198667 nsec
crc32c: CRC_LE_BITS = 64
crc32c: self tests passed, processed 225944 bytes in 99363 nsec
pcieport 0000:00:1c.0: irq 40 for MSI/MSI-X
pcieport 0000:00:1c.1: irq 41 for MSI/MSI-X
pcieport 0000:00:1c.3: irq 42 for MSI/MSI-X
pcieport 0000:00:1c.5: irq 43 for MSI/MSI-X
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
pciehp: PCI Express Hot Plug Controller Driver version: 0.4
cpcihp_zt5550: ZT5550 CompactPCI Hot Plug Driver version: 0.2
cpcihp_generic: Generic port I/O CompactPCI Hot Plug Driver version: 0.1
cpcihp_generic: not configured, disabling.
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
pci_bus 0000:03: dev 07, created physical slot 1
acpiphp: Slot [1] registered
pci_bus 0000:03: dev 08, created physical slot 2
acpiphp: Slot [2] registered
pci_bus 0000:0d: dev 00, created physical slot 1-1
acpiphp: Slot [1-1] registered
acpiphp_ibm: ibm_acpiphp_init: acpi_walk_namespace failed
intel_idle: does not run on family 6 model 15
ACPI: AC Adapter [AC] (on-line)
input: Lid Switch as /devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input0
ACPI: Lid Switch [LID]
input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input1
ACPI: Power Button [PBTN]
input: Sleep Button as /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input2
ACPI: Sleep Button [SBTN]
ACPI: Requesting acpi_cpufreq
Monitor-Mwait will be used to enter C-1 state
Monitor-Mwait will be used to enter C-2 state
Monitor-Mwait will be used to enter C-3 state
Marking TSC unstable due to TSC halts in idle
ACPI: acpi_idle registered with cpuidle
Switching to clocksource hpet
thermal LNXTHERM:00: registered as thermal_zone0
ACPI: Thermal Zone [THM] (58 C)
GHES: HEST is not enabled!
ioatdma: Intel(R) QuickData Technology Driver 4.00
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Battery Slot [BAT1] (battery absent)
brd: module loaded
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
i8042: PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mousedev: PS/2 mouse device common for all mice
rtc_cmos 00:03: RTC can wake from S4
rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
i2c /dev entries driver
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.07
iTCO_wdt: Found a ICH8M TCO device (Version=2, TCOBASE=0x1060)
iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
iTCO_vendor_support: vendor-support=0
device-mapper: ioctl: 4.22.0-ioctl (2011-10-19) initialised: dm-devel@redhat.com
cpuidle: using governor ladder
cpuidle: using governor menu
TCP: cubic registered
NET: Registered protocol family 10
NET: Registered protocol family 17
sctp: Hash tables configured (established 65536 bind 65536)
input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input3
Registering the dns_resolver key type
PM: Checking hibernation image partition UUID=ae0f88ec-9e17-41f2-b8b3-685cce36e496
PM: Hibernation image not present or could not be loaded.
registered taskstats version 1
Running tests on trace events:
Testing event kfree_skb: OK
Testing event consume_skb: OK
Testing event skb_copy_datagram_iovec: OK
Testing event net_dev_xmit: OK
Testing event net_dev_queue: OK
Testing event netif_receive_skb: OK
Testing event netif_rx: OK
Testing event napi_poll: OK
Testing event sock_rcvqueue_full: OK
Testing event sock_exceed_buf_limit: OK
Testing event udp_fail_queue_rcv_skb: OK
Testing event regmap_reg_write: OK
Testing event regmap_reg_read: OK
Testing event regmap_reg_read_cache: OK
Testing event regmap_hw_read_start: OK
Testing event regmap_hw_read_done: OK
Testing event regmap_hw_write_start: OK
Testing event regmap_hw_write_done: OK
Testing event regcache_sync: OK
Testing event regmap_cache_only: OK
Testing event regmap_cache_bypass: OK
Testing event regulator_enable: OK
Testing event regulator_enable_delay: OK
Testing event regulator_enable_complete: OK
Testing event regulator_disable: OK
Testing event regulator_disable_complete: OK
Testing event regulator_set_voltage: OK
Testing event regulator_set_voltage_complete: OK
Testing event block_rq_abort: OK
Testing event block_rq_requeue: OK
Testing event block_rq_complete: OK
Testing event block_rq_insert: OK
Testing event block_rq_issue: OK
Testing event block_bio_bounce: OK
Testing event block_bio_complete: OK
Testing event block_bio_backmerge: OK
Testing event block_bio_frontmerge: OK
Testing event block_bio_queue: OK
Testing event block_getrq: OK
Testing event block_sleeprq: OK
Testing event block_plug: OK
Testing event block_unplug: OK
Testing event block_split: OK
Testing event block_bio_remap: OK
Testing event block_rq_remap: OK
Testing event writeback_nothread: OK
Testing event writeback_queue: OK
Testing event writeback_exec: OK
Testing event writeback_start: OK
Testing event writeback_written: OK
Testing event writeback_wait: OK
Testing event writeback_pages_written: OK
Testing event writeback_nowork: OK
Testing event writeback_wake_background: OK
Testing event writeback_wake_thread: OK
Testing event writeback_wake_forker_thread: OK
Testing event writeback_bdi_register: OK
Testing event writeback_bdi_unregister: OK
Testing event writeback_thread_start: OK
Testing event writeback_thread_stop: OK
Testing event wbc_writepage: OK
Testing event writeback_queue_io: OK
Testing event global_dirty_state: OK
Testing event bdi_dirty_ratelimit: OK
Testing event balance_dirty_pages: OK
Testing event writeback_congestion_wait: OK
Testing event writeback_wait_iff_congested: OK
Testing event writeback_single_inode_requeue: OK
Testing event writeback_single_inode: OK
Testing event mm_compaction_isolate_migratepages: OK
Testing event mm_compaction_isolate_freepages: OK
Testing event mm_compaction_migratepages: OK
Testing event kmalloc: OK
Testing event kmem_cache_alloc: OK
Testing event kmalloc_node: OK
Testing event kmem_cache_alloc_node: OK
Testing event kfree: OK
Testing event kmem_cache_free: OK
Testing event mm_page_free: OK
Testing event mm_page_free_batched: OK
Testing event mm_page_alloc: OK
Testing event mm_page_alloc_zone_locked: OK
Testing event mm_page_pcpu_drain: OK
Testing event mm_page_alloc_extfrag: OK
Testing event mm_vmscan_kswapd_sleep: OK
Testing event mm_vmscan_kswapd_wake: OK
Testing event mm_vmscan_wakeup_kswapd: OK
Testing event mm_vmscan_direct_reclaim_begin: OK
Testing event mm_vmscan_memcg_reclaim_begin: OK
Testing event mm_vmscan_memcg_softlimit_reclaim_begin: OK
Testing event mm_vmscan_direct_reclaim_end: OK
Testing event mm_vmscan_memcg_reclaim_end: OK
Testing event mm_vmscan_memcg_softlimit_reclaim_end: OK
Testing event mm_shrink_slab_start: OK
Testing event mm_shrink_slab_end: OK
Testing event mm_vmscan_lru_isolate: OK
Testing event mm_vmscan_memcg_isolate: OK
Testing event mm_vmscan_writepage: OK
Testing event mm_vmscan_lru_shrink_inactive: OK
Testing event replace_swap_token: OK
Testing event put_swap_token: OK
Testing event disable_swap_token: OK
Testing event update_swap_token_priority: OK
Testing event oom_score_adj_update: OK
Testing event rpm_suspend: OK
Testing event rpm_resume: OK
Testing event rpm_idle: OK
Testing event rpm_return_int: OK
Testing event cpu_idle: OK
Testing event cpu_frequency: OK
Testing event machine_suspend: OK
Testing event clock_enable: OK
Testing event clock_disable: OK
Testing event clock_set_rate: OK
Testing event power_domain_target: OK
Testing event ftrace_test_filter: OK
Testing event module_load: OK
Testing event module_free: OK
Testing event module_get: OK
Testing event module_put: OK
Testing event module_request: OK
Testing event sched_kthread_stop: OK
Testing event sched_kthread_stop_ret: OK
Testing event sched_wakeup: OK
Testing event sched_wakeup_new: OK
Testing event sched_switch: OK
Testing event sched_migrate_task: OK
Testing event sched_process_free: OK
Testing event sched_process_exit: OK
Testing event sched_wait_task: OK
Testing event sched_process_wait: OK
Testing event sched_process_fork: OK
Testing event sched_process_exec: OK
Testing event sched_stat_wait: OK
Testing event sched_stat_sleep: OK
Testing event sched_stat_iowait: OK
Testing event sched_stat_blocked: OK
Testing event sched_stat_runtime: OK
Testing event sched_pi_setprio: OK
Testing event rcu_utilization: OK
Testing event workqueue_queue_work: OK
Testing event workqueue_activate_work: OK
Testing event workqueue_execute_start: OK
Testing event workqueue_execute_end: OK
Testing event signal_generate: OK
Testing event signal_deliver: OK
Testing event timer_init: OK
Testing event timer_start: OK
Testing event timer_expire_entry: OK
Testing event timer_expire_exit: OK
Testing event timer_cancel: OK
Testing event hrtimer_init: OK
Testing event hrtimer_start: OK
Testing event hrtimer_expire_entry: OK
Testing event hrtimer_expire_exit: OK
Testing event hrtimer_cancel: OK
Testing event itimer_state: OK
Testing event itimer_expire: OK
Testing event irq_handler_entry: OK
Testing event irq_handler_exit: OK
Testing event softirq_entry: OK
Testing event softirq_exit: OK
Testing event softirq_raise: OK
Testing event console: OK
Testing event task_newtask: OK
Testing event task_rename: OK
Testing event mce_record: OK
Testing event sys_enter: OK
Testing event sys_exit: OK
Testing event emulate_vsyscall: OK
Running tests on trace event systems:
Testing event system skb: OK
Testing event system net: OK
Testing event system napi: OK
Testing event system sock: OK
Testing event system udp: OK
Testing event system regmap: OK
Testing event system regulator: OK
Testing event system block: OK
Testing event system writeback: OK
Testing event system compaction: OK
Testing event system kmem: OK
Testing event system vmscan: OK
Testing event system oom: OK
Testing event system rpm: OK
Testing event system power: OK
Testing event system test: OK
Testing event system module: OK
Testing event system sched: OK
Testing event system rcu: OK
Testing event system workqueue: OK
Testing event system signal: OK
Testing event system timer: OK
Testing event system irq: OK
Testing event system printk: OK
Testing event system task: OK
Testing event system mce: OK
Testing event system raw_syscalls: OK
Testing event system vsyscall: OK
Testing event system syscalls: OK
Running tests on all trace events:
Testing all events: 
event trace: Could not enable event function
OK
Running tests again, along with the function tracer
Running tests on trace events:
Testing event kfree_skb: OK
Testing event consume_skb: OK
Testing event skb_copy_datagram_iovec: OK
Testing event net_dev_xmit: OK
Testing event net_dev_queue: OK
Testing event netif_receive_skb: OK
Testing event netif_rx: OK
Testing event napi_poll: OK
Testing event sock_rcvqueue_full: OK
Testing event sock_exceed_buf_limit: OK
Testing event udp_fail_queue_rcv_skb: OK
Testing event regmap_reg_write: OK
Testing event regmap_reg_read: OK
Testing event regmap_reg_read_cache: OK
Testing event regmap_hw_read_start: OK
Testing event regmap_hw_read_done: OK
Testing event regmap_hw_write_start: OK
Testing event regmap_hw_write_done: OK
Testing event regcache_sync: OK
Testing event regmap_cache_only: OK
Testing event regmap_cache_bypass: OK
Testing event regulator_enable: OK
Testing event regulator_enable_delay: OK
Testing event regulator_enable_complete: OK
Testing event regulator_disable: OK
Testing event regulator_disable_complete: OK
Testing event regulator_set_voltage: OK
Testing event regulator_set_voltage_complete: OK
Testing event block_rq_abort: OK
Testing event block_rq_requeue: OK
Testing event block_rq_complete: OK
Testing event block_rq_insert: OK
Testing event block_rq_issue: OK
Testing event block_bio_bounce: OK
Testing event block_bio_complete: OK
Testing event block_bio_backmerge: OK
Testing event block_bio_frontmerge: OK
Testing event block_bio_queue: OK
Testing event block_getrq: OK
Testing event block_sleeprq: OK
Testing event block_plug: OK
Testing event block_unplug: OK
Testing event block_split: OK
Testing event block_bio_remap: OK
Testing event block_rq_remap: OK
Testing event writeback_nothread: OK
Testing event writeback_queue: OK
Testing event writeback_exec: OK
Testing event writeback_start: OK
Testing event writeback_written: OK
Testing event writeback_wait: OK
Testing event writeback_pages_written: OK
Testing event writeback_nowork: OK
Testing event writeback_wake_background: OK
Testing event writeback_wake_thread: OK
Testing event writeback_wake_forker_thread: OK
Testing event writeback_bdi_register: OK
Testing event writeback_bdi_unregister: OK
Testing event writeback_thread_start: OK
Testing event writeback_thread_stop: OK
Testing event wbc_writepage: OK
Testing event writeback_queue_io: OK
Testing event global_dirty_state: OK
Testing event bdi_dirty_ratelimit: OK
Testing event balance_dirty_pages: OK
Testing event writeback_congestion_wait: OK
Testing event writeback_wait_iff_congested: OK
Testing event writeback_single_inode_requeue: OK
Testing event writeback_single_inode: OK
Testing event mm_compaction_isolate_migratepages: OK
Testing event mm_compaction_isolate_freepages: OK
Testing event mm_compaction_migratepages: OK
Testing event kmalloc: OK
Testing event kmem_cache_alloc: OK
Testing event kmalloc_node: OK
Testing event kmem_cache_alloc_node: OK
Testing event kfree: OK
Testing event kmem_cache_free: OK
Testing event mm_page_free: OK
Testing event mm_page_free_batched: OK
Testing event mm_page_alloc: OK
Testing event mm_page_alloc_zone_locked: OK
Testing event mm_page_pcpu_drain: OK
Testing event mm_page_alloc_extfrag: OK
Testing event mm_vmscan_kswapd_sleep: OK
Testing event mm_vmscan_kswapd_wake: OK
Testing event mm_vmscan_wakeup_kswapd: OK
Testing event mm_vmscan_direct_reclaim_begin: OK
Testing event mm_vmscan_memcg_reclaim_begin: OK
Testing event mm_vmscan_memcg_softlimit_reclaim_begin: OK
Testing event mm_vmscan_direct_reclaim_end: OK
Testing event mm_vmscan_memcg_reclaim_end: OK
Testing event mm_vmscan_memcg_softlimit_reclaim_end: OK
Testing event mm_shrink_slab_start: OK
Testing event mm_shrink_slab_end: OK
Testing event mm_vmscan_lru_isolate: OK
Testing event mm_vmscan_memcg_isolate: OK
Testing event mm_vmscan_writepage: OK
Testing event mm_vmscan_lru_shrink_inactive: OK
Testing event replace_swap_token: OK
Testing event put_swap_token: OK
Testing event disable_swap_token: OK
Testing event update_swap_token_priority: OK
Testing event oom_score_adj_update: OK
Testing event rpm_suspend: OK
Testing event rpm_resume: OK
Testing event rpm_idle: OK
Testing event rpm_return_int: OK
Testing event cpu_idle: OK
Testing event cpu_frequency: OK
Testing event machine_suspend: OK
Testing event clock_enable: OK
Testing event clock_disable: OK
Testing event clock_set_rate: OK
Testing event power_domain_target: OK
Testing event ftrace_test_filter: OK
Testing event module_load: OK
Testing event module_free: OK
Testing event module_get: OK
Testing event module_put: OK
Testing event module_request: OK
Testing event sched_kthread_stop: OK
Testing event sched_kthread_stop_ret: OK
Testing event sched_wakeup: OK
Testing event sched_wakeup_new: OK
Testing event sched_switch: OK
Testing event sched_migrate_task: OK
Testing event sched_process_free: OK
Testing event sched_process_exit: OK
Testing event sched_wait_task: OK
Testing event sched_process_wait: OK
Testing event sched_process_fork: OK
Testing event sched_process_exec: OK
Testing event sched_stat_wait: OK
Testing event sched_stat_sleep: OK
Testing event sched_stat_iowait: OK
Testing event sched_stat_blocked: OK
Testing event sched_stat_runtime: OK
Testing event sched_pi_setprio: OK
Testing event rcu_utilization: OK
Testing event workqueue_queue_work: OK
Testing event workqueue_activate_work: OK
Testing event workqueue_execute_start: OK
Testing event workqueue_execute_end: OK
Testing event signal_generate: OK
Testing event signal_deliver: OK
Testing event timer_init: OK
Testing event timer_start: OK
Testing event timer_expire_entry: OK
Testing event timer_expire_exit: OK
Testing event timer_cancel: OK
Testing event hrtimer_init: OK
Testing event hrtimer_start: OK
Testing event hrtimer_expire_entry: OK
Testing event hrtimer_expire_exit: OK
Testing event hrtimer_cancel: OK
Testing event itimer_state: OK
Testing event itimer_expire: OK
Testing event irq_handler_entry: OK
Testing event irq_handler_exit: OK
Testing event softirq_entry: OK
Testing event softirq_exit: OK
Testing event softirq_raise: OK
Testing event console: OK
Testing event task_newtask: OK
Testing event task_rename: OK
Testing event mce_record: OK
Testing event sys_enter: OK
Testing event sys_exit: OK
Testing event emulate_vsyscall: OK
Running tests on trace event systems:
Testing event system skb: OK
Testing event system net: OK
Testing event system napi: OK
Testing event system sock: OK
Testing event system udp: OK
Testing event system regmap: OK
Testing event system regulator: OK
Testing event system block: OK
Testing event system writeback: OK
Testing event system compaction: OK
Testing event system kmem: OK
Testing event system vmscan: OK
Testing event system oom: OK
Testing event system rpm: OK
Testing event system power: OK
Testing event system test: OK
Testing event system module: OK
Testing event system sched: OK
Testing event system rcu: OK
Testing event system workqueue: OK
Testing event system signal: OK
Testing event system timer: OK
Testing event system irq: OK
Testing event system printk: OK
Testing event system task: OK
Testing event system mce: OK
Testing event system raw_syscalls: OK
Testing event system vsyscall: OK
Testing event system syscalls: OK
Running tests on all trace events:
Testing all events: 
event trace: Could not enable event function
OK
Testing ftrace filter: OK
rtc_cmos 00:03: setting system clock to 2012-04-10 20:37:06 UTC (1334090226)
Freeing unused kernel memory: 612k freed
Write protecting the kernel read-only data: 6144k
Freeing unused kernel memory: 572k freed
Freeing unused kernel memory: 696k freed
udevd[496]: starting version 182
Linux agpgart interface v0.103
[drm] Initialized drm 1.1.0 20060810
agpgart-intel 0000:00:00.0: Intel 965GM Chipset
agpgart-intel 0000:00:00.0: detected gtt size: 524288K total, 262144K mappable
agpgart-intel 0000:00:00.0: detected 8192K stolen memory
agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0x20000000
[drm] radeon defaulting to kernel modesetting.
[drm] radeon kernel modesetting enabled.
i915 0000:00:02.0: setting latency timer to 64
radeon 0000:05:00.0: enabling device (0000 -> 0003)
i915: probe of 0000:00:02.0 failed with error -5
radeon 0000:05:00.0: enabling bus mastering
[drm] initializing kernel modesetting (CEDAR 0x1002:0x68E1 0x1787:0x3000).
[drm] register mmio base: 0xF66E0000
[drm] register mmio size: 131072
ATOM BIOS: B9127JMA.MFK
[drm] GPU not posted. posting now...
radeon 0000:05:00.0: VRAM: 512M 0x0000000000000000 - 0x000000001FFFFFFF (512M used)
radeon 0000:05:00.0: GTT: 512M 0x0000000020000000 - 0x000000003FFFFFFF
mtrr: zero sized request
[drm] Detected VRAM RAM=512M, BAR=0M
[drm] RAM width 64bits DDR
[TTM] Zone  kernel: Available graphics memory: 2019692 kiB
[TTM] Initializing pool allocator
[TTM] Initializing DMA pool allocator
radeon_bo_create:132 alloc size 0M bigger than 0Mb limit
radeon 0000:05:00.0: Fatal error during GPU init
[drm] radeon: finishing device.
radeon 0000:05:00.0: no bo for sa manager
[TTM] Trying to take down uninitialized memory manager type 1
[TTM] Finalizing pool allocator
[TTM] Finalizing DMA pool allocator
[TTM] Zone  kernel: Used memory at exit: 0 kiB
[drm] radeon: ttm finalized
vga_switcheroo: disabled
radeon: probe of 0000:05:00.0 failed with error -12
dracut: Starting plymouth daemon
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
uhci_hcd: USB Universal Host Controller Interface driver
uhci_hcd 0000:00:1a.0: enabling bus mastering
uhci_hcd 0000:00:1a.0: setting latency timer to 64
uhci_hcd 0000:00:1a.0: UHCI Host Controller
uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1a.0: irq 20, io base 0x00006f20
usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: UHCI Host Controller
usb usb1: Manufacturer: Linux 3.4.0-rc2-wl-00219-g61fa1b5 uhci_hcd
usb usb1: SerialNumber: 0000:00:1a.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
uhci_hcd 0000:00:1a.1: enabling bus mastering
uhci_hcd 0000:00:1a.1: setting latency timer to 64
uhci_hcd 0000:00:1a.1: UHCI Host Controller
uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1a.1: irq 21, io base 0x00006f00
usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 3.4.0-rc2-wl-00219-g61fa1b5 uhci_hcd
usb usb2: SerialNumber: 0000:00:1a.1
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
Warning! ehci_hcd should always be loaded before uhci_hcd and ohci_hcd, not after
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ehci_hcd 0000:00:1a.7: enabling bus mastering
ehci_hcd 0000:00:1a.7: setting latency timer to 64
ehci_hcd 0000:00:1a.7: EHCI Host Controller
ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 3
ehci_hcd 0000:00:1a.7: debug port 1
yenta_cardbus 0000:03:01.0: CardBus bridge found [1028:01fe]
yenta_cardbus 0000:03:01.0: O2: enabling read prefetch/write burst. If you experience problems or performance issues, use the yenta_socket parameter 'o2_speedup=off'
ehci_hcd 0000:00:1a.7: cache line size of 64 is not supported
ehci_hcd 0000:00:1a.7: irq 22, io mem 0xfed1c400
SCSI subsystem initialized
libata version 3.00 loaded.
ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00
usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: EHCI Host Controller
usb usb3: Manufacturer: Linux 3.4.0-rc2-wl-00219-g61fa1b5 ehci_hcd
usb usb3: SerialNumber: 0000:00:1a.7
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 4 ports detected
ehci_hcd 0000:00:1d.7: enabling bus mastering
ehci_hcd 0000:00:1d.7: setting latency timer to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: cache line size of 64 is not supported
ehci_hcd 0000:00:1d.7: irq 20, io mem 0xfed1c000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
usb usb4: New USB device found, idVendor=1d6b, idProduct=0002
usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: EHCI Host Controller
usb usb4: Manufacturer: Linux 3.4.0-rc2-wl-00219-g61fa1b5 ehci_hcd
usb usb4: SerialNumber: 0000:00:1d.7
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
uhci_hcd 0000:00:1d.0: enabling bus mastering
uhci_hcd 0000:00:1d.0: setting latency timer to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.0: irq 20, io base 0x00006f80
usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb5: Product: UHCI Host Controller
usb usb5: Manufacturer: Linux 3.4.0-rc2-wl-00219-g61fa1b5 uhci_hcd
usb usb5: SerialNumber: 0000:00:1d.0
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: enabling bus mastering
uhci_hcd 0000:00:1d.1: setting latency timer to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 6
uhci_hcd 0000:00:1d.1: irq 21, io base 0x00006f60
usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb6: Product: UHCI Host Controller
usb usb6: Manufacturer: Linux 3.4.0-rc2-wl-00219-g61fa1b5 uhci_hcd
usb usb6: SerialNumber: 0000:00:1d.1
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 2 ports detected
ata_piix 0000:00:1f.1: version 2.13
ata_piix 0000:00:1f.1: setting latency timer to 64
scsi0 : ata_piix
scsi1 : ata_piix
ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x6fa0 irq 14
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x6fa8 irq 15
ahci 0000:00:1f.2: version 3.0
ahci 0000:00:1f.2: irq 44 for MSI/MSI-X
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 3 ports 3 Gbps 0x5 impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq sntf pm led clo pio slum part ccc ems 
ahci 0000:00:1f.2: setting latency timer to 64
ata2: port disabled--ignoring
scsi2 : ahci
scsi3 : ahci
scsi4 : ahci
ata3: SATA max UDMA/133 abar m2048@0xf6dfb800 port 0xf6dfb900 irq 44
ata4: DUMMY
ata5: SATA max UDMA/133 abar m2048@0xf6dfb800 port 0xf6dfba00 irq 44
uhci_hcd 0000:00:1d.2: enabling bus mastering
uhci_hcd 0000:00:1d.2: setting latency timer to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 7
uhci_hcd 0000:00:1d.2: irq 22, io base 0x00006f40
usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb7: Product: UHCI Host Controller
usb usb7: Manufacturer: Linux 3.4.0-rc2-wl-00219-g61fa1b5 uhci_hcd
usb usb7: SerialNumber: 0000:00:1d.2
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 2 ports detected
yenta_cardbus 0000:03:01.0: ISA IRQ mask 0x0cb8, PCI irq 19
yenta_cardbus 0000:03:01.0: Socket status: 30000006
yenta_cardbus 0000:03:01.0: pcmcia: parent PCI bridge window: [io  0xc000-0xcfff]
yenta_cardbus 0000:03:01.0: pcmcia: parent PCI bridge window: [mem 0xf6600000-0xf68fffff]
pcmcia_socket pcmcia_socket0: cs: memory probe 0xf6600000-0xf68fffff: excluding 0xf6600000-0xf680ffff 0xf68d0000-0xf68fffff
firewire_ohci 0000:03:01.4: added OHCI v1.10 device as card 0, 8 IR + 8 IT contexts, quirks 0x10
ata1.00: ATA-7: ST980813AS, 3.ADB, max UDMA/133
ata1.00: 156301488 sectors, multi 8: LBA48 NCQ (depth 0/32)
ata1.00: configured for UDMA/100
scsi 0:0:0:0: Direct-Access     ATA      ST980813AS       3.AD PQ: 0 ANSI: 5
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata5: SATA link down (SStatus 0 SControl 300)
ata3.00: ATA-8: OCZ-AGILITY3, 2.13, max UDMA/133
ata3.00: 234441648 sectors, multi 8: LBA48 NCQ (depth 31/32), AA
ata3.00: configured for UDMA/133
scsi 2:0:0:0: Direct-Access     ATA      OCZ-AGILITY3     2.13 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 156301488 512-byte logical blocks: (80.0 GB/74.5 GiB)
sd 2:0:0:0: [sdb] 234441648 512-byte logical blocks: (120 GB/111 GiB)
sd 2:0:0:0: [sdb] Write Protect is off
sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb: sdb1 sdb2 sdb3
sd 2:0:0:0: [sdb] Attached SCSI disk
 sda: sda1 sda2 sda3
sd 0:0:0:0: [sda] Attached SCSI disk
Btrfs loaded
device label GENTOO devid 1 transid 345262 /dev/sdb3
usb 3-3: new high-speed USB device number 3 using ehci_hcd
usb 3-3: New USB device found, idVendor=413c, idProduct=0058
usb 3-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
hub 3-3:1.0: USB hub found
hub 3-3:1.0: 4 ports detected
usb 4-2: new high-speed USB device number 2 using ehci_hcd
firewire_core 0000:03:01.4: created device fw0: GUID 314fc00002643c70, S400
usb 4-2: New USB device found, idVendor=14cd, idProduct=125b
usb 4-2: New USB device strings: Mfr=1, Product=3, SerialNumber=2
usb 4-2: Product:  AutoRUN/Partition 
usb 4-2: Manufacturer:  Generic 
usb 4-2: SerialNumber: 125B20100608
usbcore: registered new interface driver libusual
Initializing USB Mass Storage driver...
scsi5 : usb-storage 4-2:1.0
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
dracut: Checking, if btrfs device complete
device label GENTOO devid 1 transid 345262 /dev/sdb3
btrfs: disk space caching is enabled
Btrfs detected SSD devices, enabling SSD mode
dracut: Checking, if btrfs device complete
device label GENTOO devid 1 transid 345262 /dev/sdb3
btrfs: disk space caching is enabled
Btrfs detected SSD devices, enabling SSD mode
dracut: Checking, if btrfs device complete
device label GENTOO devid 1 transid 345262 /dev/sdb3
btrfs: disk space caching is enabled
usb 1-2: new full-speed USB device number 2 using uhci_hcd
Btrfs detected SSD devices, enabling SSD mode
PM: Marking nosave pages: [mem 0x0009f000-0x000fffff]
PM: Marking nosave pages: [mem 0xdf65a000-0xffffffff]
PM: Basic memory bitmaps created
PM: Basic memory bitmaps freed
PM: Starting manual resume from disk
PM: Hibernation image partition 8:18 present
PM: Looking for hibernation image.
PM: Image not found (code -22)
PM: Hibernation image not present or could not be loaded.
device label GENTOO devid 1 transid 345262 /dev/sdb3
btrfs: disk space caching is enabled
Btrfs detected SSD devices, enabling SSD mode
dracut: Checking btrfs: /dev/disk/by-uuid/d761a2db-f951-4e9c-bed4-cf2381bb1af4
dracut: trying to mount /dev/disk/by-uuid/d761a2db-f951-4e9c-bed4-cf2381bb1af4
device label GENTOO devid 1 transid 345262 /dev/sdb3
btrfs: disk space caching is enabled
usb 1-2: New USB device found, idVendor=413c, idProduct=8140
usb 1-2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
Btrfs detected SSD devices, enabling SSD mode
dracut: btrfs: /dev/disk/by-uuid/d761a2db-f951-4e9c-bed4-cf2381bb1af4 is clean
usb 3-3.2: new high-speed USB device number 4 using ehci_hcd
usb 3-3.2: New USB device found, idVendor=413c, idProduct=0058
usb 3-3.2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
hub 3-3.2:1.0: USB hub found
hub 3-3.2:1.0: 4 ports detected
usb 7-1: new full-speed USB device number 2 using uhci_hcd
usb 7-1: New USB device found, idVendor=0b97, idProduct=7761
usb 7-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
hub 7-1:1.0: USB hub found
hub 7-1:1.0: 4 ports detected
scsi 5:0:0:0: Direct-Access     Mass     Storage Device        PQ: 0 ANSI: 0 CCS
sd 5:0:0:0: [sdc] 31116287 512-byte logical blocks: (15.9 GB/14.8 GiB)
sd 5:0:0:0: [sdc] Write Protect is off
sd 5:0:0:0: [sdc] Mode Sense: 03 00 00 00
sd 5:0:0:0: [sdc] No Caching mode page present
sd 5:0:0:0: [sdc] Assuming drive cache: write through
sd 5:0:0:0: [sdc] No Caching mode page present
sd 5:0:0:0: [sdc] Assuming drive cache: write through
 sdc: unknown partition table
sd 5:0:0:0: [sdc] No Caching mode page present
sd 5:0:0:0: [sdc] Assuming drive cache: write through
sd 5:0:0:0: [sdc] Attached SCSI removable disk
device label distfiles devid 1 transid 2378 /dev/sdc
usb 7-1.2: new full-speed USB device number 3 using uhci_hcd
usb 7-1.2: New USB device found, idVendor=0b97, idProduct=7772
usb 7-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 7-1.2: Product: O2Micro CCID SC Reader
usb 7-1.2: Manufacturer: O2
btrfs bad tree block start 67108864 58720256
failed mirror was 1
btrfs read error corrected: ino 1 off 58720256 (dev /dev/sdb3 sector 131072)
dracut: Remounting /dev/disk/by-uuid/d761a2db-f951-4e9c-bed4-cf2381bb1af4 with -o subvol=ROOT,ro
device label GENTOO devid 1 transid 345265 /dev/sdb3
btrfs: disk space caching is enabled
Btrfs detected SSD devices, enabling SSD mode
dracut: Mounted root filesystem /dev/sdb3
dracut: Switching root
btrfs: use lzo compression
btrfs: enabling inode map caching
btrfs: use ssd allocation scheme
btrfs: disk space caching is enabled
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
FS-Cache: Loaded
udevd[866]: starting version 182
NFS: Registering the id_resolver key type
FS-Cache: Netfs 'nfs' registered for caching
loop: module loaded
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
tg3.c:v3.123 (March 21, 2012)
cfg80211: Calling CRDA to update world regulatory domain
wmi: Mapper loaded
parport_pc 00:0a: reported by Plug and Play ACPI
parport0: PC-style at 0x378 (0x778), irq 7, dma 1 [PCSPP,TRISTATE
tg3 0000:09:00.0: eth0: Tigon3 [partno(BCM95755m) rev a002] (PCI Express) MAC address 00:1d:09:bc:69:2c
tg3 0000:09:00.0: eth0: attached PHY is 5755 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])
tg3 0000:09:00.0: eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
tg3 0000:09:00.0: eth0: dma_rwctrl[76180000] dma_mask[64-bit]
,COMPAT,ECP,DMA]
iwl4965: Intel(R) Wireless WiFi 4965 driver for Linux, in-tree:
iwl4965: Copyright(c) 2003-2011 Intel Corporation
iwl4965 0000:0c:00.0: Detected Intel(R) Wireless WiFi Link 4965AGN, REV=0x4
iwl4965 0000:0c:00.0: device EEPROM VER=0x36, CALIB=0x5
iwl4965 0000:0c:00.0: Tunable channels: 13 802.11bg, 19 802.11a channels
iwl4965 0000:0c:00.0: irq 45 for MSI/MSI-X
snd_hda_intel 0000:00:1b.0: irq 46 for MSI/MSI-X
input: PC Speaker as /devices/platform/pcspkr/input/input4
Bluetooth: Core ver 2.16
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO socket layer initialized
input: HDA Intel Line as /devices/pci0000:00/0000:00:1b.0/sound/card0/input5
input: HDA Intel Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input6
snd_hda_intel 0000:05:00.1: irq 47 for MSI/MSI-X
usbcore: registered new interface driver btusb
microcode: CPU0 sig=0x6fb, pf=0x80, revision=0xb3
WARNING! power/level is deprecated; use power/control instead
HDMI status: Codec=0 Pin=3 Presence_Detect=0 ELD_Valid=0
input: HD-Audio Generic HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1e.0/0000:03:08.0/0000:05:00.1/sound/card1/input7
dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.2)
iwl4965 0000:0c:00.0: RF_KILL bit toggled to enable radio.
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
input: Dell WMI hotkeys as /devices/virtual/input/input8
microcode: CPU1 sig=0x6fb, pf=0x80, revision=0xb3
iwl4965 0000:0c:00.0: loaded firmware version 228.61.2.24
Registered led device: phy0-led
cfg80211: World regulatory domain updated:
cfg80211:   (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
cfg80211:   (2457000 KHz - 2482000 KHz @ 20000 KHz), (300 mBi, 2000 mBm)
cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz), (300 mBi, 2000 mBm)
cfg80211:   (5170000 KHz - 5250000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
cfg80211:   (5735000 KHz - 5835000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
device label distfiles devid 1 transid 2378 /dev/sdc
ieee80211 phy0: Selected rate control algorithm 'iwl-4965-rs'
btrfs: use zlib compression
btrfs: enabling inode map caching
btrfs: use ssd allocation scheme
btrfs: disk space caching is enabled
Adding 8005628k swap on /dev/sdb2.  Priority:0 extents:1 across:8005628k SS
PHC: Got new VIDs through sysfs VID interface.
PHC: Got new VIDs through sysfs VID interface.
PHC: Got new VIDs through sysfs VID interface.
PHC: Got new VIDs through sysfs VID interface.
input: DualPoint Stick as /devices/platform/i8042/serio1/input/input9
input: AlpsPS/2 ALPS DualPoint TouchPad as /devices/platform/i8042/serio1/input/input10
ADDRCONF(NETDEV_UP): wlan0: link is not ready
tg3 0000:09:00.0: irq 48 for MSI/MSI-X
ADDRCONF(NETDEV_UP): eth0: link is not ready
sd 0:0:0:0: [sda] Synchronizing SCSI cache
sd 0:0:0:0: [sda] Stopping disk
tg3 0000:09:00.0: eth0: Link is up at 1000 Mbps, full duplex
tg3 0000:09:00.0: eth0: Flow control is on for TX and on for RX
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
ata1.00: configured for UDMA/100
sd 0:0:0:0: [sda] Starting disk
ata1.00: configured for UDMA/100
ata1: EH complete
ata3.00: configured for UDMA/133
ata3: EH complete
sd 0:0:0:0: [sda] Synchronizing SCSI cache
sd 0:0:0:0: [sda] Stopping disk
uhci_hcd 0000:00:1a.1: enabling bus mastering
uhci_hcd 0000:00:1a.1: setting latency timer to 64
uhci_hcd 0000:00:1d.0: enabling bus mastering
uhci_hcd 0000:00:1d.0: setting latency timer to 64
uhci_hcd 0000:00:1d.1: enabling bus mastering
uhci_hcd 0000:00:1d.1: setting latency timer to 64
wlan0: authenticate with e0:91:f5:04:7b:e8
wlan0: send auth to e0:91:f5:04:7b:e8 (try 1/3)
wlan0: authenticated
wlan0: associate with e0:91:f5:04:7b:e8 (try 1/3)
wlan0: RX AssocResp from e0:91:f5:04:7b:e8 (capab=0x411 status=0 aid=2)
wlan0: associated
ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
cfg80211: Calling CRDA for country: GB
cfg80211: Regulatory domain changed to country: GB
cfg80211:   (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
cfg80211:   (2402000 KHz - 2482000 KHz @ 40000 KHz), (N/A, 2000 mBm)
cfg80211:   (5170000 KHz - 5250000 KHz @ 40000 KHz), (N/A, 2000 mBm)
cfg80211:   (5250000 KHz - 5330000 KHz @ 40000 KHz), (N/A, 2000 mBm)
cfg80211:   (5490000 KHz - 5710000 KHz @ 40000 KHz), (N/A, 2700 mBm)
ICMPv6 RA: ndisc_router_discovery() failed to add default route.
ICMPv6 RA: ndisc_router_discovery() failed to add default route.

--------------080002010004070902050706
Content-Type: application/pgp-signature;
 name="dmesg.docked.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg.docked.sig"

iEYEABECAAYFAk+EjhAACgkQGcb56gMuC63btgCgriomRw+jJKqqmB/jK4HG9JMwoGcAn3+j
vtyPhwK8P6gcYU5hyTATjO1k
--------------080002010004070902050706--
