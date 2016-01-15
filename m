Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V3 00/21] MMCONFIG refactoring and support for ARM64 PCI
 hostbridge init based on ACPI
To: Tomasz Nowicki <tn@semihalf.com>, bhelgaas@google.com,
	arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com,
	rjw@rjwysocki.net, Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, Stefano.Stabellini@eu.citrix.com
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com
From: Hanjun Guo <hanjun.guo@linaro.org>
Message-ID: <5698D163.6050404@linaro.org>
Date: Fri, 15 Jan 2016 19:00:51 +0800
MIME-Version: 1.0
In-Reply-To: <1452691267-32240-1-git-send-email-tn@semihalf.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2016/1/13 21:20, Tomasz Nowicki wrote:
>  From the functionality point of view this series might be split into the
> following logic parts:
> 1. Make MMCONFIG code arch-agnostic which allows all architectures to collect
>     PCI config regions and used when necessary.
> 2. Move non-arch specific bits to the core code.
> 3. Use MMCONFIG code and implement generic ACPI based PCI host controller driver.
> 4. Enable above driver on ARM64
>
> Patches has been built on top of 4.4 and can be found here:
> git@github.com:semihalf-nowicki-tomasz/linux.git (pci-acpi-v3)
>
> NOTE, this patch set depends on Matthew's patches:
> http://www.spinics.net/lists/linux-pci/msg45950.html
> https://github.com/Vality/linux/tree/pci-fixes
>
> This has been tested on Cavium ThunderX server and QEMU.
> Any help in reviewing and testing is very appreciated.
>
> v2 -> v3
> - fix legacy IRQ assigning and IO ports registration
> - remove reference to arch specific companion device for ia64
> - move ACPI PCI host controller driver to pci_root.c
> - drop generic domain assignment for x86 and ia64 as I am not
>    able to run all necessary test variants
> - drop patch which cleaned legacy IRQ assignment since it belongs to
>    Mathew's series:
>    https://patchwork.ozlabs.org/patch/557504/
> - extend MCFG quirk code
> - rebased to 4.4

Tested this patch set (and Matthew's) on a HP RX2660 IA64 machine,
with the CONFIG_ACPI_PCI_HOST_GENERIC disabled on IA64 ( it's a minor
comment needs to be addressed in my previous email), it can boot
the system ok with NIC working properly, with the /pro/ioports [1] and
the boot log [2] if anyone needs refer to it.

For this patch set, on IA64 machine,

Tested-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun

[1]
node11:~ # cat /proc/ioports
000003c0-000003df : vga+
01000000-0100ffff : PCI Bus 0000:00
   01001000-010010ff : 0000:00:03.0
02000000-0200ffff : PCI Bus 0000:01
   02001000-020010ff : 0000:01:01.0
03000000-0300ffff : PCI Bus 0000:02
   03001000-0300103f : 0000:02:01.1
   03001040-0300107f : 0000:02:01.0
04000000-0400ffff : PCI Bus 0000:03
   04001000-040010ff : 0000:03:01.1
   04001100-040011ff : 0000:03:01.0
05000000-0500ffff : PCI Bus 0000:04
   05001000-0500103f : 0000:04:01.1
   05001040-0500107f : 0000:04:01.0

[2] boot log
Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Initializing cgroup subsys cpuacct
Linux version 4.4.0.1-0.7-default (root@node11) (gcc version 4.3.4 
[gcc-4_3-branch revision 152973] (SUSE Linux) ) #60 SMP Fri Jan 15 
17:19:02 EST 2016
EFI v2.00 by HP:
efi:  SALsystab=0x3ee7a000  ACPI 2.0=0x3fde6000  SMBIOS=0x3ee7c000 
HCDP=0x3fde4000
booting generic kernel on platform hpzx1
PCDP: v3 at 0x3fde4000
PCDP: VGA console
ACPI: Early table checksum verification disabled
ACPI: RSDP 0x000000003FDE6000 000028 (v02 HP    )
ACPI: XSDT 0x000000003FDE602C 0000BC (v01 HP     rx2660   00000000 HP 
00000000)
ACPI: FACP 0x000000003FDF7268 0000F4 (v03 HP     rx2660   00000000 HP 
00000000)
ACPI BIOS Warning (bug): 32/64X length mismatch in FADT/Gpe0Block: 32/16 
(20150930/tbfadt-623)
ACPI BIOS Warning (bug): 32/64X length mismatch in FADT/Gpe1Block: 32/16 
(20150930/tbfadt-623)
ACPI: DSDT 0x000000003FDE61C8 00E566 (v01 HP     rx2660   00000007 INTL 
20050309)
ACPI: FACS 0x000000003FDF7360 000040
ACPI: SPCR 0x000000003FDF73A0 000050 (v01 HP              00000000 HP 
00000000)
ACPI: DBGP 0x000000003FDF73F0 000034 (v01 HP     rx2660   00000000 HP 
00000000)
ACPI: APIC 0x000000003FDF7810 0000E8 (v01 HP     rx2660   00000000 HP 
00000000)
ACPI: SPMI 0x000000003FDF7428 000050 (v04 HP     rx2660   00000000 HP 
00000000)
ACPI: CPEP 0x000000003FDF76E0 000034 (v01 HP     rx2660   00000000 HP 
00000000)
ACPI: SSDT 0x000000003FDF4738 0004B3 (v01 HP     rx2660   00000006 INTL 
20050309)
ACPI: SSDT 0x000000003FDF4BF8 000456 (v01 HP     rx2660   00000006 INTL 
20050309)
ACPI: SSDT 0x000000003FDF5058 000866 (v01 HP     rx2660   00000006 INTL 
20050309)
ACPI: SSDT 0x000000003FDF58C8 000866 (v01 HP     rx2660   00000006 INTL 
20050309)
ACPI: SSDT 0x000000003FDF6138 000866 (v01 HP     rx2660   00000006 INTL 
20050309)
ACPI: SSDT 0x000000003FDF69A8 000138 (v01 HP     rx2660   00000006 INTL 
20050309)
ACPI: SSDT 0x000000003FDF6AE8 0000E0 (v01 HP     rx2660   00000006 INTL 
20050309)
ACPI: SSDT 0x000000003FDF6BD8 00013C (v01 HP     rx2660   00000006 INTL 
20050309)
ACPI: SSDT 0x000000003FDF6D18 0000E0 (v01 HP     rx2660   00000006 INTL 
20050309)
ACPI: SSDT 0x000000003FDF6E08 00013C (v01 HP     rx2660   00000006 INTL 
20050309)
ACPI: SSDT 0x000000003FDF6F48 0000E0 (v01 HP     rx2660   00000006 INTL 
20050309)
ACPI: SSDT 0x000000003FDF7038 00013C (v01 HP     rx2660   00000006 INTL 
20050309)
ACPI: SSDT 0x000000003FDF7178 0000E0 (v01 HP     rx2660   00000006 INTL 
20050309)
ACPI: Local APIC address c0000000fee00000
4 CPUs available, 8 CPUs total
SMP: Allowing 8 CPUs, 4 hotplug CPUs
Reserving 512MB of memory at 128MB for crashkernel (System RAM: 16347MB)
Initial ramdisk at: 0xe0000100fe2af000 (13610859 bytes)
SAL 3.20: HP version 4.11
SAL Platform features: None
SAL: AP wakeup using external interrupt vector 0xff
MCA related initialization done
Virtual mem_map starts at 0xa07fffffc7c80000
Zone ranges:
   DMA      [mem 0x0000000001000000-0x00000000ffffffff]
   Normal   [mem 0x0000000100000000-0x00000100ffffffff]
Movable zone start for each node
Early memory node ranges
   node   0: [mem 0x0000000001000000-0x000000003e67ffff]
   node   0: [mem 0x000000003eaf0000-0x000000003ee6ffff]
   node   0: [mem 0x000000003fc00000-0x000000003fd6ffff]
   node   0: [mem 0x0000000100000000-0x00000003ffffffff]
   node   0: [mem 0x0000010040000000-0x00000100ff1effff]
   node   0: [mem 0x00000100ff200000-0x00000100ffffffff]
Initmem setup node 0 [mem 0x0000000001000000-0x00000100ffffffff]
On node 0 totalpages: 261558
free_area_init_node: node 0, pgdat e000000001a00000, node_mem_map 
a07fffffc7c83800
   DMA zone: 56 pages used for memmap
   DMA zone: 0 pages reserved
   DMA zone: 15799 pages, LIFO batch:1
   Normal zone: 14336 pages used for memmap
   Normal zone: 245759 pages, LIFO batch:1
pcpu-alloc: s33560 r8192 d220392 u262144 alloc=4*65536
pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6 [0] 7
Built 1 zonelists in Node order, mobility grouping on.  Total pages: 247166
Policy zone: Normal
Kernel command line: 
BOOT_IMAGE=dev000:\efi\SuSE\vmlinuz-4.4.0.1-0.7-default 
root=/dev/disk/by-id/scsi-35000cca00a9965f4-part2  splash=silent 
crashkernel=1024M-:512M
PID hash table entries: 4096 (order: -1, 32768 bytes)
Sorting __ex_table...
Memory: 16146944K/16739712K available (10928K kernel code, 5820K rwdata, 
1828K rodata, 1280K init, 8346K bss, 592768K reserved, 0K cma-reserved)
Hierarchical RCU implementation.
	Build-time adjustment of leaf fanout to 64.
	RCU restricting CPUs from NR_CPUS=4096 to nr_cpu_ids=8.
RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=8
NR_IRQS:1024
ACPI: Local APIC address c0000000fee00000
GSI 25 (level, low) -> CPU 0 (0x0000) vector 49
CPU 0: base freq=266.116MHz, ITC ratio=6/4, ITC freq=399.174MHz+/-150ppm
clocksource: itc: mask: 0xffffffffffffffff max_cycles: 0x5c0fd820f3, 
max_idle_ns: 440795212316 ns
Console: colour VGA+ 80x25
console [tty0] enabled
Calibrating delay loop... 2834.43 BogoMIPS (lpj=5668864)
pid_max: default: 32768 minimum: 301
ACPI: Core revision 20150930
ACPI: 14 ACPI AML tables successfully acquired and loaded
Security Framework initialized
SELinux:  Disabled at boot.
AppArmor: AppArmor disabled by boot time parameter
Dentry cache hash table entries: 2097152 (order: 8, 16777216 bytes)
Inode-cache hash table entries: 1048576 (order: 7, 8388608 bytes)
Mount-cache hash table entries: 32768 (order: 2, 262144 bytes)
Mountpoint-cache hash table entries: 32768 (order: 2, 262144 bytes)
Initializing cgroup subsys devices
Initializing cgroup subsys freezer
Initializing cgroup subsys net_cls
Boot processor id 0x0/0x0
Fixed BSP b0 value from CPU 1
CPU 1: synchronized ITC with CPU 0 (last diff -6 cycles, maxerr 172 cycles)
CPU 1: base freq=266.116MHz, ITC ratio=6/4, ITC freq=399.174MHz+/-150ppm
CPU 2: synchronized ITC with CPU 0 (last diff -6 cycles, maxerr 173 cycles)
CPU 2: base freq=266.116MHz, ITC ratio=6/4, ITC freq=399.174MHz+/-150ppm
CPU 3: synchronized ITC with CPU 0 (last diff -6 cycles, maxerr 173 cycles)
CPU 3: base freq=266.116MHz, ITC ratio=6/4, ITC freq=399.174MHz+/-150ppm
Brought up 4 CPUs
Total of 4 processors activated (11337.72 BogoMIPS).
devtmpfs: initialized
SMBIOS 2.4 present.
DMI: hp server rx2660                   , BIOS 04.11 
                                         10/20/2008
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, 
max_idle_ns: 7645041785100000 ns
NET: Registered protocol family 16
ACPI: bus type PCI registered
ACPI: Added _OSI(Module Device)
ACPI: Added _OSI(Processor Device)
ACPI: Added _OSI(3.0 _SCP Extensions)
ACPI: Added _OSI(Processor Aggregator Device)
\_SB_:_OSC invalid UUID
_OSC request data:1 e
ACPI: Interpreter enabled
ACPI: (supports S0 S5)
ACPI: Using IOSAPIC for interrupt routing
ACPI: PCI Root Bridge [L000] (domain 0000 [bus 00])
acpi HWP0002:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments 
MSI]
acpi HWP0002:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
debug: resource flag 0x200201, name PCI Bus 0000:00 with resouce 
[0xff5e2000 - 0xff5e2007]
debug: resource flag 0x200105, name PCI Bus 0000:00 with resouce 
[0x1000000 - 0x100ffff]debug: resource flag 0x200201, name PCI Bus 
0000:00 with resouce [0xa0000 - 0xfffff]
debug: resource flag 0x200201, name PCI Bus 0000:00 with resouce 
[0x80000000 - 0x8fffffff]debug: resource flag 0x200201, name PCI Bus 
0000:00 with resouce [0x80004000000 - 0x800ffffffff]
acpi HWP0002:00: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x1000000-0x100ffff window] (bus 
address [0x0000-0xffff])
pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000fffff window]
pci_bus 0000:00: root bus resource [mem 0x80000000-0x8fffffff window]
pci_bus 0000:00: root bus resource [mem 0x80004000000-0x800ffffffff window]
pci_bus 0000:00: root bus resource [bus 00]
pci 0000:00:01.0: [103c:1303] type 00 class 0xff0000
pci 0000:00:01.1: [103c:1302] type 00 class 0x078000
pci 0000:00:01.1: reg 0x14: [mem 0x88034000-0x88034fff 64bit]
pci 0000:00:01.1: reg 0x1c: [mem 0x80080000000-0x8008001ffff 64bit pref]
pci 0000:00:01.2: [103c:1048] type 00 class 0x070002
pci 0000:00:01.2: reg 0x14: [mem 0x88033000-0x88033fff 64bit]
pci 0000:00:02.0: [1033:0035] type 00 class 0x0c0310
pci 0000:00:02.0: reg 0x10: [mem 0x88032000-0x88032fff]
pci 0000:00:02.0: supports D1 D2
pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
pci 0000:00:02.1: [1033:0035] type 00 class 0x0c0310
pci 0000:00:02.1: reg 0x10: [mem 0x88031000-0x88031fff]
pci 0000:00:02.1: supports D1 D2
pci 0000:00:02.1: PME# supported from D0 D1 D2 D3hot
pci 0000:00:02.2: [1033:00e0] type 00 class 0x0c0320
pci 0000:00:02.2: reg 0x10: [mem 0x88030000-0x880300ff]
pci 0000:00:02.2: supports D1 D2
pci 0000:00:02.2: PME# supported from D0 D1 D2 D3hot
pci 0000:00:03.0: [1002:515e] type 00 class 0x030000
pci 0000:00:03.0: reg 0x10: [mem 0x80000000-0x87ffffff pref]
pci 0000:00:03.0: reg 0x14: [io  0x1001000-0x10010ff]
pci 0000:00:03.0: reg 0x18: [mem 0x88020000-0x8802ffff]
pci 0000:00:03.0: reg 0x30: [mem 0x88000000-0x8801ffff pref]
pci 0000:00:03.0: supports D1 D2
ACPI: PCI Root Bridge [L002] (domain 0000 [bus 01])
acpi HWP0002:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments 
MSI]
acpi HWP0002:01: _OSC failed (AE_NOT_FOUND); disabling ASPM
debug: resource flag 0x200105, name PCI Bus 0000:01 with resouce 
[0x2000000 - 0x200ffff]
debug: resource flag 0x200201, name PCI Bus 0000:01 with resouce 
[0xa0000000 - 0xafffffff]debug: resource flag 0x200201, name PCI Bus 
0000:01 with resouce [0x80204000000 - 0x802ffffffff]
acpi HWP0002:01: PCI host bridge to bus 0000:01
pci_bus 0000:01: root bus resource [io  0x2000000-0x200ffff window] (bus 
address [0x0000-0xffff])
pci_bus 0000:01: root bus resource [mem 0xa0000000-0xafffffff window]
pci_bus 0000:01: root bus resource [mem 0x80204000000-0x802ffffffff window]
pci_bus 0000:01: root bus resource [bus 01]
pci 0000:01:01.0: [1000:0054] type 00 class 0x010000
pci 0000:01:01.0: reg 0x10: [io  0x2001000-0x20010ff]
pci 0000:01:01.0: reg 0x14: [mem 0xa0470000-0xa0473fff 64bit]
pci 0000:01:01.0: reg 0x1c: [mem 0xa0460000-0xa046ffff 64bit]
pci 0000:01:01.0: reg 0x30: [mem 0xa0000000-0xa03fffff pref]
pci 0000:01:01.0: supports D1 D2
pci 0000:01:02.0: [14e4:1648] type 00 class 0x020000
pci 0000:01:02.0: reg 0x10: [mem 0xa0450000-0xa045ffff 64bit]
pci 0000:01:02.0: reg 0x30: [mem 0xa0420000-0xa043ffff pref]
pci 0000:01:02.0: PME# supported from D3hot D3cold
pci 0000:01:02.1: [14e4:1648] type 00 class 0x020000
pci 0000:01:02.1: reg 0x10: [mem 0xa0440000-0xa044ffff 64bit]
pci 0000:01:02.1: reg 0x30: [mem 0xa0400000-0xa041ffff pref]
pci 0000:01:02.1: PME# supported from D3hot D3cold
ACPI: PCI Root Bridge [L003] (domain 0000 [bus 02])
acpi HWP0002:02: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments 
MSI]
acpi HWP0002:02: _OSC failed (AE_NOT_FOUND); disabling ASPM
debug: resource flag 0x200105, name PCI Bus 0000:02 with resouce 
[0x3000000 - 0x300ffff]
debug: resource flag 0x200201, name PCI Bus 0000:02 with resouce 
[0xb0000000 - 0xbfffffff]debug: resource flag 0x200201, name PCI Bus 
0000:02 with resouce [0x80304000000 - 0x803ffffffff]
acpi HWP0002:02: PCI host bridge to bus 0000:02
pci_bus 0000:02: root bus resource [io  0x3000000-0x300ffff window] (bus 
address [0x0000-0xffff])
pci_bus 0000:02: root bus resource [mem 0xb0000000-0xbfffffff window]
pci_bus 0000:02: root bus resource [mem 0x80304000000-0x803ffffffff window]
pci_bus 0000:02: root bus resource [bus 02]
pci 0000:02:01.0: [8086:1079] type 00 class 0x020000
pci 0000:02:01.0: reg 0x10: [mem 0xb0120000-0xb013ffff 64bit]
pci 0000:02:01.0: reg 0x18: [mem 0xb00c0000-0xb00fffff 64bit]
pci 0000:02:01.0: reg 0x20: [io  0x3001040-0x300107f]
pci 0000:02:01.0: reg 0x30: [mem 0xb0080000-0xb00bffff pref]
pci 0000:02:01.0: PME# supported from D0 D3hot
pci 0000:02:01.1: [8086:1079] type 00 class 0x020000
pci 0000:02:01.1: reg 0x10: [mem 0xb0100000-0xb011ffff 64bit]
pci 0000:02:01.1: reg 0x18: [mem 0xb0040000-0xb007ffff 64bit]
pci 0000:02:01.1: reg 0x20: [io  0x3001000-0x300103f]
pci 0000:02:01.1: reg 0x30: [mem 0xb0000000-0xb003ffff pref]
pci 0000:02:01.1: PME# supported from D0 D3hot
ACPI: PCI Root Bridge [L006] (domain 0000 [bus 03])
acpi HWP0002:03: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments 
MSI]
acpi HWP0002:03: _OSC failed (AE_NOT_FOUND); disabling ASPM
debug: resource flag 0x200105, name PCI Bus 0000:03 with resouce 
[0x4000000 - 0x400ffff]
debug: resource flag 0x200201, name PCI Bus 0000:03 with resouce 
[0xe0000000 - 0xefffffff]debug: resource flag 0x200201, name PCI Bus 
0000:03 with resouce [0x80604000000 - 0x806ffffffff]
acpi HWP0002:03: PCI host bridge to bus 0000:03
pci_bus 0000:03: root bus resource [io  0x4000000-0x400ffff window] (bus 
address [0x0000-0xffff])
pci_bus 0000:03: root bus resource [mem 0xe0000000-0xefffffff window]
pci_bus 0000:03: root bus resource [mem 0x80604000000-0x806ffffffff window]
pci_bus 0000:03: root bus resource [bus 03]
pci 0000:03:01.0: [1000:0030] type 00 class 0x010000
pci 0000:03:01.0: reg 0x10: [io  0x4001100-0x40011ff]
pci 0000:03:01.0: reg 0x14: [mem 0xe0260000-0xe027ffff 64bit]
pci 0000:03:01.0: reg 0x1c: [mem 0xe0240000-0xe025ffff 64bit]
pci 0000:03:01.0: reg 0x30: [mem 0xe0100000-0xe01fffff pref]
pci 0000:03:01.0: supports D1 D2
pci 0000:03:01.1: [1000:0030] type 00 class 0x010000
pci 0000:03:01.1: reg 0x10: [io  0x4001000-0x40010ff]
pci 0000:03:01.1: reg 0x14: [mem 0xe0220000-0xe023ffff 64bit]
pci 0000:03:01.1: reg 0x1c: [mem 0xe0200000-0xe021ffff 64bit]
pci 0000:03:01.1: reg 0x30: [mem 0xe0000000-0xe00fffff pref]
pci 0000:03:01.1: supports D1 D2
ACPI: PCI Root Bridge [L007] (domain 0000 [bus 04])
acpi HWP0002:04: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments 
MSI]
acpi HWP0002:04: _OSC failed (AE_NOT_FOUND); disabling ASPM
debug: resource flag 0x200105, name PCI Bus 0000:04 with resouce 
[0x5000000 - 0x500ffff]
debug: resource flag 0x200201, name PCI Bus 0000:04 with resouce 
[0xf0000000 - 0xfdffffff]debug: resource flag 0x200201, name PCI Bus 
0000:04 with resouce [0x80704000000 - 0x807ffffffff]
acpi HWP0002:04: PCI host bridge to bus 0000:04
pci_bus 0000:04: root bus resource [io  0x5000000-0x500ffff window] (bus 
address [0x0000-0xffff])
pci_bus 0000:04: root bus resource [mem 0xf0000000-0xfdffffff window]
pci_bus 0000:04: root bus resource [mem 0x80704000000-0x807ffffffff window]
pci_bus 0000:04: root bus resource [bus 04]
pci 0000:04:01.0: [8086:1079] type 00 class 0x020000
pci 0000:04:01.0: reg 0x10: [mem 0xf0120000-0xf013ffff 64bit]
pci 0000:04:01.0: reg 0x18: [mem 0xf00c0000-0xf00fffff 64bit]
pci 0000:04:01.0: reg 0x20: [io  0x5001040-0x500107f]
pci 0000:04:01.0: reg 0x30: [mem 0xf0080000-0xf00bffff pref]
pci 0000:04:01.0: PME# supported from D0 D3hot
pci 0000:04:01.1: [8086:1079] type 00 class 0x020000
pci 0000:04:01.1: reg 0x10: [mem 0xf0100000-0xf011ffff 64bit]
pci 0000:04:01.1: reg 0x18: [mem 0xf0040000-0xf007ffff 64bit]
pci 0000:04:01.1: reg 0x20: [io  0x5001000-0x500103f]
pci 0000:04:01.1: reg 0x30: [mem 0xf0000000-0xf003ffff pref]
pci 0000:04:01.1: PME# supported from D0 D3hot
ACPI: Enabled 2 GPEs in block 10 to 1F
vgaarb: setting as boot device: PCI:0000:00:03.0
vgaarb: device added: PCI:0000:00:03.0,decodes=io+mem,owns=io+mem,locks=none
vgaarb: loaded
vgaarb: bridge control possible 0000:00:03.0
IOC: zx2 2.0 HPA 0xfed01000 IOVA space 1024Mb at 0x40000000
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
clocksource: Switched to clocksource itc
pnp: PnP ACPI init
GSI 24 (level, low) -> CPU 1 (0x0200) vector 50
pnp 00:00: Plug and Play ACPI device, IDs PNP0501 (active)
pnp: PnP ACPI: found 1 devices
NET: Registered protocol family 2
TCP established hash table entries: 131072 (order: 4, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 4, 1048576 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
UDP hash table entries: 8192 (order: 2, 262144 bytes)
UDP-Lite hash table entries: 8192 (order: 2, 262144 bytes)
NET: Registered protocol family 1
GSI 17 (level, low) -> CPU 2 (0x0400) vector 51
GSI 17 (level, low) -> CPU 2 (0x0400) vector 51 unregistered
GSI 18 (level, low) -> CPU 3 (0x0600) vector 51
GSI 18 (level, low) -> CPU 3 (0x0600) vector 51 unregistered
GSI 19 (level, low) -> CPU 0 (0x0000) vector 51
GSI 19 (level, low) -> CPU 0 (0x0000) vector 51 unregistered
pci 0000:00:03.0: Video device with shadowed ROM
PCI: CLS 128 bytes, default 128
Unpacking initramfs...
Freeing initrd memory: 13248kB freed
perfmon: version 2.0 IRQ 238
perfmon: Montecito PMU detected, 27 PMCs, 35 PMDs, 12 counters (47 bits)
PAL Information Facility v0.5
perfmon: added sampling format default_format
perfmon_default_smpl: default_format v2.0 registered
futex hash table entries: 2048 (order: 2, 262144 bytes)
audit: initializing netlink subsys (disabled)
audit: type=2000 audit(1452897622.516:1): initialized
HugeTLB registered 256 MB page size, pre-allocated 0 pages
VFS: Disk quotas dquot_6.6.0
VFS: Dquot-cache hash table entries: 8192 (order 0, 65536 bytes)
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
00:00: ttyS0 at MMIO 0xff5e2000 (irq = 50, base_baud = 115200) is a 16550A
GSI 16 (level, low) -> CPU 1 (0x0200) vector 51
0000:00:01.2: ttyS1 at MMIO 0x88033000 (irq = 54, base_baud = 115200) is 
a 16550A
EFI Time Services Driver v0.4
libphy: Fixed MDIO Bus: probed
mousedev: PS/2 mouse device common for all mice
EFI Variables Facility v0.08 2004-May-17
registered taskstats version 1
Freeing unused kernel memory: 1280K (e000000004d80000 - e000000004ec0000)
thermal LNXTHERM:00: registered as thermal_zone0
ACPI: Thermal Zone [THM0] (27 C)
SCSI subsystem initialized
Fusion MPT base driver 3.04.20
Copyright (c) 1999-2008 LSI Corporation
Fusion MPT SPI Host driver 3.04.20
GSI 49 (level, low) -> CPU 2 (0x0400) vector 52
mptbase: ioc0: Initiating bringup
ioc0: LSI53C1030 C0: Capabilities={Initiator,Target}
scsi host0: ioc0: LSI53C1030 C0, FwRev=01032346h, Ports=1, MaxQ=255, IRQ=55
GSI 50 (level, low) -> CPU 3 (0x0600) vector 53
mptbase: ioc1: Initiating bringup
ioc1: LSI53C1030 C0: Capabilities={Initiator,Target}
scsi host1: ioc1: LSI53C1030 C0, FwRev=01032346h, Ports=1, MaxQ=255, IRQ=56
random: nonblocking pool is initialized
Fusion MPT SAS Host driver 3.04.20
GSI 27 (level, low) -> CPU 0 (0x0000) vector 54
mptbase: ioc2: Initiating bringup
ioc2: LSISAS1068 B0: Capabilities={Initiator}
scsi host2: ioc2: LSISAS1068 B0, FwRev=01172a00h, Ports=1, MaxQ=163, IRQ=57
mptsas: ioc2: attaching ssp device: fw_channel 0, fw_id 8, phy 0, 
sas_addr 0x5000cca00a9965f5
scsi 2:0:0:0: Direct-Access     HP       DG0146FARVU      HPD6 PQ: 0 ANSI: 5
mptsas: ioc2: attaching ssp device: fw_channel 0, fw_id 7, phy 1, 
sas_addr 0x5000cca00a99675d
scsi 2:0:1:0: Direct-Access     HP       DG0146FARVU      HPD6 PQ: 0 ANSI: 5
udevd (181): /proc/181/oom_adj is deprecated, please use 
/proc/181/oom_score_adj instead.
udevd version 128 started
sd 2:0:0:0: [sda] 286749488 512-byte logical blocks: (146 GB/136 GiB)
sd 2:0:1:0: [sdb] 286749488 512-byte logical blocks: (146 GB/136 GiB)
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Mode Sense: eb 00 10 08
sd 2:0:1:0: [sdb] Write Protect is off
sd 2:0:1:0: [sdb] Mode Sense: eb 00 10 08
sd 2:0:0:0: [sda] Write cache: disabled, read cache: enabled, supports 
DPO and FUA
sd 2:0:1:0: [sdb] Write cache: disabled, read cache: enabled, supports 
DPO and FUA
  sda: sda1 sda2
  sdb: sdb1 sdb2 sdb3 sdb4 sdb5 sdb6 sdb7
sd 2:0:0:0: [sda] Attached SCSI disk
sd 2:0:1:0: [sdb] Attached SCSI disk
EXT4-fs (sda2): mounting ext3 file system using the ext4 subsystem
EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: 
acl,user_xattr
EXT4-fs (sda2): re-mounted. Opts: acl,user_xattr
udevd version 128 started
ipmi message handler version 39.2
e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
e1000: Copyright (c) 1999-2006 Intel Corporation.
GSI 38 (level, low) -> CPU 1 (0x0200) vector 55
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
ACPI: Power Button [PWRF]
input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN:00/input/input1
ACPI: Sleep Button [SLPF]
e1000 0000:02:01.0 eth0: (PCI-X:133MHz:64-bit) 00:24:81:77:73:a4
e1000 0000:02:01.0 eth0: Intel(R) PRO/1000 Network Connection
GSI 39 (level, low) -> CPU 2 (0x0400) vector 56
ipmi_si IPI0001:00: ipmi_si: probing via ACPI
ipmi_si IPI0001:00: [mem 0xff5bc000-0xff5bc003] regsize 1 spacing 1 irq 0
ipmi_si: Adding ACPI-specified kcs state machine
IPMI System Interface driver.
ipmi_si: probing via SPMI
ipmi_si: SPMI: mem 0xff5bc000 regsize 1 spacing 1 irq 0
ipmi_si: Adding SPMI-specified kcs state machine duplicate interface
ipmi_si: Trying ACPI-specified kcs state machine at mem address 
0xff5bc000, slave address 0x0, irq 0
e1000 0000:02:01.1 eth1: (PCI-X:133MHz:64-bit) 00:24:81:77:73:a5
e1000 0000:02:01.1 eth1: Intel(R) PRO/1000 Network Connection
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti 
<giometti@linux.it>
Fusion MPT misc device (ioctl) driver 3.04.20
GSI 60 (level, low) -> CPU 3 (0x0600) vector 57
mptctl: Registered with Fusion MPT base driver
mptctl: /dev/mptctl @ (major,minor=10,220)
sd 2:0:0:0: Attached scsi generic sg0 type 0
sd 2:0:1:0: Attached scsi generic sg1 type 0
PTP clock support registered
ipmi_si IPI0001:00: Found new BMC (man_id: 0x00000b, prod_id: 0x8201, 
dev_id: 0x32)
ipmi_si IPI0001:00: IPMI kcs interface initialized
ACPI: bus type USB registered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
tg3.c:v3.137 (May 11, 2014)
GSI 29 (level, low) -> CPU 0 (0x0000) vector 58
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
e1000 0000:04:01.0 eth2: (PCI-X:133MHz:64-bit) 00:24:81:77:75:70
e1000 0000:04:01.0 eth2: Intel(R) PRO/1000 Network Connection
GSI 61 (level, low) -> CPU 1 (0x0200) vector 59
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ehci-pci: EHCI PCI platform driver
GSI 19 (level, low) -> CPU 2 (0x0400) vector 60
ehci-pci 0000:00:02.2: EHCI Host Controller
ehci-pci 0000:00:02.2: new USB bus registered, assigned bus number 1
ehci-pci 0000:00:02.2: irq 53, io mem 0x88030000
ehci-pci 0000:00:02.2: USB 2.0 started, EHCI 1.00
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 4.4.0.1-0.7-default ehci_hcd
usb usb1: SerialNumber: 0000:00:02.2
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 5 ports detected
ohci-pci: OHCI PCI platform driver
GSI 17 (level, low) -> CPU 3 (0x0600) vector 61
ohci-pci 0000:00:02.0: OHCI PCI host controller
ohci-pci 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci-pci 0000:00:02.0: irq 51, io mem 0x88032000
e1000 0000:04:01.1 eth3: (PCI-X:133MHz:64-bit) 00:24:81:77:75:71
e1000 0000:04:01.1 eth3: Intel(R) PRO/1000 Network Connection
e1000 0000:02:01.0 eth0_rename: renamed from eth0
usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: OHCI PCI host controller
usb usb2: Manufacturer: Linux 4.4.0.1-0.7-default ohci_hcd
usb usb2: SerialNumber: 0000:00:02.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
GSI 18 (level, low) -> CPU 0 (0x0000) vector 62
ohci-pci 0000:00:02.1: OHCI PCI host controller
ohci-pci 0000:00:02.1: new USB bus registered, assigned bus number 3
ohci-pci 0000:00:02.1: irq 52, io mem 0x88031000
e1000 0000:02:01.1 eth1_rename: renamed from eth1
e1000 0000:04:01.1 eth5: renamed from eth3
e1000 0000:04:01.0 eth4: renamed from eth2
tg3 0000:01:02.0 eth0: Tigon3 [partno(BCM95700A6) rev 2100] 
(PCIX:66MHz:64-bit) MAC address 00:22:64:94:09:3f
tg3 0000:01:02.0 eth0: attached PHY is 5704 (10/100/1000Base-T Ethernet) 
(WireSpeed[1], EEE[0])
tg3 0000:01:02.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
tg3 0000:01:02.0 eth0: dma_rwctrl[769f0000] dma_mask[64-bit]
e1000 0000:02:01.1 eth3: renamed from eth1_rename
GSI 30 (level, low) -> CPU 1 (0x0200) vector 63
usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: OHCI PCI host controller
usb usb3: Manufacturer: Linux 4.4.0.1-0.7-default ohci_hcd
usb usb3: SerialNumber: 0000:00:02.1
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
e1000 0000:02:01.0 eth2: renamed from eth0_rename
tg3 0000:01:02.1 eth1: Tigon3 [partno(BCM95700A6) rev 2100] 
(PCIX:66MHz:64-bit) MAC address 00:22:64:94:09:3e
tg3 0000:01:02.1 eth1: attached PHY is 5704 (10/100/1000Base-T Ethernet) 
(WireSpeed[1], EEE[0])
tg3 0000:01:02.1 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
tg3 0000:01:02.1 eth1: dma_rwctrl[769f0000] dma_mask[64-bit]
usb 1-2: new high-speed USB device number 3 using ehci-pci
usb 2-1: new full-speed USB device number 2 using ohci-pci
Adding 2104448k swap on /dev/sdb2.  Priority:-1 extents:1 across:2104448k
usb 1-2: New USB device found, idVendor=03f0, idProduct=0126
usb 1-2: New USB device strings: Mfr=51, Product=80, SerialNumber=67
usb 1-2: Product: INTEGRITY SERVER
usb 1-2: Manufacturer: HEWLETT PACKARD
usb 1-2: SerialNumber: A60020000001
usb 2-1: New USB device found, idVendor=03f0, idProduct=1126
usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=63
usb 2-1: Product: Virtual Management Device
usb 2-1: Manufacturer: HP
usb 2-1: SerialNumber: 0022649407fa
hidraw: raw HID events driver (C) Jiri Kosina
usb-storage 1-2:1.0: USB Mass Storage device detected
scsi host3: usb-storage 1-2:1.0
usbcore: registered new interface driver usb-storage
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
usb 3-2: new low-speed USB device number 2 using ohci-pci
input: HP Virtual Management Device as 
/devices/LNXSYSTM:00/LNXSYBUS:00/HWP0001:00/HWP0002:00/pci0000:00/0000:00:02.0/usb2/2-1/2-1:1.0/0003:03F0:1126.0001/input/input2
hid-generic 0003:03F0:1126.0001: input,hidraw0: USB HID v1.11 Keyboard 
[HP Virtual Management Device] on usb-0000:00:02.0-1/input0
input: HP Virtual Management Device as 
/devices/LNXSYSTM:00/LNXSYBUS:00/HWP0001:00/HWP0002:00/pci0000:00/0000:00:02.0/usb2/2-1/2-1:1.1/0003:03F0:1126.0002/input/input3
hid-generic 0003:03F0:1126.0002: input,hidraw1: USB HID v1.01 Mouse [HP 
Virtual Management Device] on usb-0000:00:02.0-1/input1
usb 3-2: New USB device found, idVendor=0557, idProduct=2221
usb 3-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 3-2: Product: UC-10KM V1.3.121
usb 3-2: Manufacturer: ATEN
usb 3-2: SerialNumber: USB Composite device
input: ATEN UC-10KM V1.3.121 as 
/devices/LNXSYSTM:00/LNXSYBUS:00/HWP0001:00/HWP0002:00/pci0000:00/0000:00:02.1/usb3/3-2/3-2:1.0/0003:0557:2221.0003/input/input4
hid-generic 0003:0557:2221.0003: input,hidraw2: USB HID v1.10 Keyboard 
[ATEN UC-10KM V1.3.121] on usb-0000:00:02.1-2/input0
input: ATEN UC-10KM V1.3.121 as 
/devices/LNXSYSTM:00/LNXSYBUS:00/HWP0001:00/HWP0002:00/pci0000:00/0000:00:02.1/usb3/3-2/3-2:1.1/0003:0557:2221.0004/input/input5
hid-generic 0003:0557:2221.0004: input,hidraw3: USB HID v1.10 Mouse 
[ATEN UC-10KM V1.3.121] on usb-0000:00:02.1-2/input1
device-mapper: uevent: version 1.0.3
device-mapper: ioctl: 4.34.0-ioctl (2015-10-28) initialised: 
dm-devel@redhat.com
loop: module loaded
scsi 3:0:0:0: CD-ROM            TEAC     DVD-ROM DW-224EV K.DA PQ: 0 ANSI: 0
scsi 3:0:0:0: Attached scsi generic sg2 type 5
sr 3:0:0:0: [sr0] scsi3-mmc drive: 24x/24x cd/rw xa/form2 cdda tray
cdrom: Uniform CD-ROM driver Revision: 3.20
sr 3:0:0:0: Attached scsi CD-ROM sr0
fuse init (API version 7.23)
ip_local_port_range: prefer different parity for start/end values.
hangcheck_timer: disagrees about version of symbol module_layout
tg3 0000:01:02.0 eth0: Link is up at 1000 Mbps, full duplex
tg3 0000:01:02.0 eth0: Flow control is off for TX and off for RX
NET: Registered protocol family 10
IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
tg3 0000:01:02.1 eth1: Link is up at 1000 Mbps, full duplex
tg3 0000:01:02.1 eth1: Flow control is off for TX and off for RX
IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: starting 90-second grace period (net a0000001014af100)
GSI 20 (level, low) -> CPU 2 (0x0400) vector 64
gnome-settings-(4170): floating-point assist fault at ip 
2000000006b7bdc2, isr 0000020000001001
gnome-settings-(4170): floating-point assist fault at ip 
2000000006b7bdc2, isr 0000020000001001
gnome-settings-(4170): floating-point assist fault at ip 
2000000006b7bdc2, isr 0000020000001001
gnome-settings-(4170): floating-point assist fault at ip 
2000000006b7bdc2, isr 0000020000001001
gnome-settings-(4170): floating-point assist fault at ip 
2000000006b7bdc2, isr 0000020000001001
gdm-simple-gree(4179): unaligned access to 0x600fffffffadf34c, 
ip=0x20000000012216a0


