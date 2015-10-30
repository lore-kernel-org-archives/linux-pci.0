Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v8 00/61] PCI: Resource allocation cleanup for v4.4
To: Yinghai Lu <yinghai@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>
References: <1445979353-1728-1-git-send-email-yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
From: Khalid Aziz <khalid.aziz@oracle.com>
Message-ID: <5633E570.6040906@oracle.com>
Date: Fri, 30 Oct 2015 15:47:28 -0600
MIME-Version: 1.0
In-Reply-To: <1445979353-1728-1-git-send-email-yinghai@kernel.org>
Content-Type: multipart/mixed;
 boundary="------------080108050108070509050208"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------080108050108070509050208
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/2015 02:54 PM, Yinghai Lu wrote:
> Hi,
>
> After 5b28541552ef (PCI: Restrict 64-bit prefetchable bridge windows
> to 64-bit resources), we have several reports on resource allocation
> failure, and we try to fix the problem with resource clip, and find
> more problems.
>
> One is realloc fail with two graphics cards above 4G.
> One is from sparc that have problem with clip as we don't parse
> mem64 for it.
>
> Other report is about pci remove/rescan does not work on some setup
> when BIOS tend to allocate small bus size.
>
> This patchset enhance resource allocation to address those problems.
>
> patch 1-11: parse MEM64 for sparc and other system with OF
> patch 12-16: MMIO64 allocation enhancement
> 	treat non-pref mmio64 if parent bridges are all pcie.
> 	restore old pref allocation logic if hostbridge does not support mmio64.
> patch 17-19: FIXED resource handling during realloc
> 	don't realloc resource if device firmware does not support bar change.
> patch 20-23: bridge MMIO allocation with hotplug and last try.
> 	treat optional as required on first try when hotplug.
> 	MMIO size set to 0 for last try during realloc
> patch 24-57: enhancement for mmio resource allocation:
> 	optimize bus mmio alignment calculation.
> 	optimize bus mmio optional alignment calculation.
> 	add support for alt size to prefer small bus size to small bus alignment.
> 	treat ROM bar as optional resource.
> 	during allocation, will pick up best fit resource, and allocate near end.
> patch 58: add pci=assign_pref_bars to clear and assign pref bars.
> patch 59-60: don't clear resource when allocation fails
> patch 61: don't try io port allocation if root bus does not have io port.
>

Hi Yinghai,

I applied patches 1-8 and 11-16 to 4.3.0-rc7 to test on sparc platforms. 
I am seeing a "can't claim BAR" message on a T4:

pci 0000:04:00.0: can't claim BAR 6 [mem 0x84000000000-0x8400000ffff]: 
address conflict with 0000:04:00.0 [mem 0x84000000000-0x840007fffff]

I have attached boot up log, /proc/iomem, and output from "lspci -tv" 
and "lsspci -vvxxx".

These patches worked fine on a T7 and there were no PCI issues in the log.

Thanks,
Khalid


--------------080108050108070509050208
Content-Type: text/plain; charset=UTF-8;
 name="dmesg.4.3.0-rc7-pci.t4"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg.4.3.0-rc7-pci.t4"

PROMLIB: Sun IEEE Boot Prom 'OBP 4.38.1 2015/08/21 14:24'
PROMLIB: Root node compatible: sun4v
Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Initializing cgroup subsys cpuacct
Linux version 4.3.0-rc7-kh+ (khalid@ca-qasparc20.us.oracle.com) (gcc version 4.4.7 20120313 (Red Hat 4.4.7-4.0.13) (GCC) ) #24 SMP Fri Oct 30 15:41:41 EDT 2015
debug: ignoring loglevel setting.
bootconsole [earlyprom0] enabled
ARCH: SUN4V
Ethernet address: 00:21:28:f9:f6:4e
MM: PAGE_OFFSET is 0xfff8000000000000 (max_phys_bits == 47)
MM: VMALLOC [0x0000000100000000 --> 0x0006000000000000]
MM: VMEMMAP [0x0006000000000000 --> 0x000c000000000000]
Kernel: Using 3 locked TLB entries for main kernel image.
Remapping the kernel... done.
OF stdout device is: /virtual-devices@100/console@1
PROM: Built device tree with 371493 bytes of memory.
MDESC: Size is 107936 bytes.
PLATFORM: banner-name [SPARC T4-2]
PLATFORM: name [ORCL,SPARC-T4-2]
PLATFORM: hostid [85f9f64e]
PLATFORM: serial# [00f9f64e]
PLATFORM: stick-frequency [3b8f5850]
PLATFORM: mac-address [2128f9f64e]
PLATFORM: watchdog-resolution [1000 ms]
PLATFORM: watchdog-max-timeout [31536000000 ms]
PLATFORM: max-cpus [128]
Allocated 16384 bytes for kernel page tables.
Zone ranges:
  DMA      [mem 0x0000000020400000-0xffffffffffffffff]
  Normal   [mem 0x0000000000000000-0x0000001ffff3ffff]
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000020400000-0x000000005fdb7fff]
  node   0: [mem 0x000000005fdba000-0x000000005fdbbfff]
  node   0: [mem 0x0000000060000000-0x00000001ffffffff]
  node   1: [mem 0x0000000200000000-0x00000003ffffffff]
  node   0: [mem 0x0000000400000000-0x00000005ffffffff]
  node   1: [mem 0x0000000600000000-0x00000007ffffffff]
  node   0: [mem 0x0000000800000000-0x00000009ffffffff]
  node   1: [mem 0x0000000a00000000-0x0000000bffffffff]
  node   0: [mem 0x0000000c00000000-0x0000000dffffffff]
  node   1: [mem 0x0000000e00000000-0x0000000fffffffff]
  node   0: [mem 0x0000001000000000-0x00000011ffffffff]
  node   1: [mem 0x0000001200000000-0x00000013ffffffff]
  node   0: [mem 0x0000001400000000-0x00000015ffffffff]
  node   1: [mem 0x0000001600000000-0x00000017ffffffff]
  node   0: [mem 0x0000001800000000-0x00000019ffffffff]
  node   1: [mem 0x0000001a00000000-0x0000001bffffffff]
  node   0: [mem 0x0000001c00000000-0x0000001dffffffff]
  node   1: [mem 0x0000001e00000000-0x0000001fffe8dfff]
  node   1: [mem 0x0000001fffe9e000-0x0000001fffeb1fff]
  node   1: [mem 0x0000001ffff30000-0x0000001ffff3ffff]
Initmem setup node 0 [mem 0x0000000020400000-0x0000001dffffffff]
On node 0 totalpages: 8322269
  Normal zone: 73145 pages used for memmap
  Normal zone: 8322269 pages, LIFO batch:15
Initmem setup node 1 [mem 0x0000000200000000-0x0000001ffff3ffff]
On node 1 totalpages: 8388441
  Normal zone: 73727 pages used for memmap
  Normal zone: 8388441 pages, LIFO batch:15
Booting Linux...
CPU CAPS: [flush,stbar,swap,muldiv,v9,blkinit,n2,mul32]
CPU CAPS: [div32,v8plus,popc,vis,vis2,ASIBlkInit,fmaf,vis3]
CPU CAPS: [hpc,ima,pause,cbcond,aes,des,kasumi,camellia]
CPU CAPS: [md5,sha1,sha256,sha512,mpmul,montmul,montsqr,crc32c]
PERCPU: Embedded 9 pages/cpu @fff8001ddb000000 s32384 r8192 d33152 u131072
pcpu-alloc: s32384 r8192 d33152 u131072 alloc=1*4194304
pcpu-alloc: [0] 000 001 002 003 004 005 006 007 008 009 010 011 012 013 014 015 016 017 018 019 020 021 022 023 024 025 026 027 028 029 030 031 
pcpu-alloc: [0] 032 033 034 035 036 037 038 039 040 041 042 043 044 045 046 047 048 049 050 051 052 053 054 055 056 057 058 059 060 061 062 063 
pcpu-alloc: [1] 064 065 066 067 068 069 070 071 072 073 074 075 076 077 078 079 080 081 082 083 084 085 086 087 088 089 090 091 092 093 094 095 
pcpu-alloc: [1] 096 097 098 099 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 
SUN4V: Mondo queue sizes [cpu(16384) dev(16384) r(8192) nr(256)]
Built 2 zonelists in Node order, mobility grouping on.  Total pages: 16563838
Policy zone: Normal
Kernel command line: root=/dev/mapper/VolGroup-lv_root ro rd_NO_LUKS LANG=en_US.UTF-8 rd_NO_MD rd_LVM_LV=VolGroup/lv_swap SYSFONT=latarcyrheb-sun16 rd_LVM_LV=VolGroup/lv_root KEYBOARDTYPE=pc KEYTABLE=us rd_NO_DM debug ignore_loglevel ofpci_debug=1
PID hash table entries: 4096 (order: 2, 32768 bytes)
Sorting __ex_table...
Memory: 132447856K/133685680K available (5932K kernel code, 1014K rwdata, 2472K rodata, 544K init, 2004K bss, 1237824K reserved, 0K cma-reserved)
Hierarchical RCU implementation.
	Build-time adjustment of leaf fanout to 64.
	RCU restricting CPUs from NR_CPUS=1024 to nr_cpu_ids=128.
RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=128
NR_IRQS:2048 nr_irqs:2048 1
SUN4V: Using IRQ API major 3, cookie only virqs enabled
clocksource: stick: mask: 0xffffffffffffffff max_cycles: 0x1ccea542bf9, max_idle_ns: 881590497797 ns
clocksource: mult[801898] shift[23]
clockevent: mult[ffced917] shift[32]
Console: colour dummy device 80x25
console [tty0] enabled
bootconsole [earlyprom0] disabled
Calibrating delay using timer specific routine.. 2000.39 BogoMIPS (lpj=4000782)
pid_max: default: 131072 minimum: 1024
Security Framework initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
Dentry cache hash table entries: 16777216 (order: 14, 134217728 bytes)
Inode-cache hash table entries: 8388608 (order: 13, 67108864 bytes)
Mount-cache hash table entries: 262144 (order: 8, 2097152 bytes)
Mountpoint-cache hash table entries: 262144 (order: 8, 2097152 bytes)
Initializing cgroup subsys io
Initializing cgroup subsys memory
Initializing cgroup subsys devices
Initializing cgroup subsys freezer
Initializing cgroup subsys net_cls
Initializing cgroup subsys perf_event
Initializing cgroup subsys hugetlb
ftrace: allocating 20976 entries in 41 pages
Brought up 128 CPUs
devtmpfs: initialized
Performance events: 
Testing NMI watchdog ... OK.
Supported PMU type is 'niagara4'
ldc.c:v1.1 (July 22, 2008)
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
NET: Registered protocol family 16
VIO: Adding device channel-devices
VIO: Adding device vldc-port-0-0
VIO: Adding device vldc-port-0-1
VIO: Adding device vldc-port-0-2
VIO: Adding device vldc-port-1-0
VIO: Adding device vldc-port-2-0
VIO: Adding device vldc-port-3-0
VIO: Adding device vldc-port-3-1
VIO: Adding device vldc-port-3-2
VIO: Adding device vldc-port-3-3
VIO: Adding device vldc-port-3-4
VIO: Adding device vldc-port-3-6
VIO: Adding device vlds-port-0-0
VIO: Adding device ds-0
VIO: Adding device ds-1
pci_sun4v: Registered hvapi major[1] minor[0]
/pci@400: SUN4V PCI Bus Module
/pci@400: On NUMA node 0
/pci@400: PCI IO [io  0x85100000000-0x8510fffffff] offset 85100000000
/pci@400: PCI MEM [mem 0x84000000000-0x8407f7fffff] offset 84000000000
/pci@400: PCI MEM64 [mem 0x84100000000-0x847ffffffff] offset 80000000000
/pci@400: Unable to request IOMMU resource.
/pci@400: Imported 3 TSB entries from OBP
/pci@400: MSI Queue first[0] num[56] count[512] devino[0x6]
/pci@400: MSI first[0] num[512] mask[0x3ff] width[32]
/pci@400: MSI addr32[0x7f800000:0x800000] addr64[0xe00000003f800000:0x800000]
/pci@400: MSI queues at RA [0000001dd2200000]
PCI: Scanning PBM /pci@400
pci_sun4v f02a5770: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x85100000000-0x8510fffffff] (bus address [0x0000-0xfffffff])
pci_bus 0000:00: root bus resource [mem 0x84000000000-0x8407f7fffff] (bus address [0x00000000-0x7f7fffff])
pci_bus 0000:00: root bus resource [mem 0x84100000000-0x847ffffffff] (bus address [0x4100000000-0x47ffffffff])
pci_bus 0000:00: root bus resource [bus 00-0f]
PCI: scan_bus[/pci@400] bus no 0
  * /pci@400/pci@1
    create device, devfn: 8, type: pciex
    class: 0x60400 device name: 0000:00:01.0
    adding to system ...
pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
PCI: dev header type: 1
of_scan_pci_bridge(/pci@400/pci@1)
    Bridge bus range [1 --> 9]
    Bridge ranges[fff8001fffe39940] simba[0]
    RAW Range[81000000:00000000:00000000:81000000:00000000:00000000:00000000:00002000]
      Using flags[00000101] start[0000000000000000] size[0000000000002000]
    RAW Range[82000000:00000000:00000000:82000000:00000000:00000000:00000000:00c00000]
      Using flags[00000200] start[0000000000000000] size[0000000000c00000]
    bus name: PCI Bus 0000:01
PCI: scan_bus[/pci@400/pci@1] bus no 1
  * /pci@400/pci@1/pci@0
    create device, devfn: 0, type: pciex
    class: 0x60400 device name: 0000:01:00.0
    adding to system ...
pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
PCI: dev header type: 1
of_scan_pci_bridge(/pci@400/pci@1/pci@0)
    Bridge bus range [2 --> 9]
    Bridge ranges[fff8001fffe38800] simba[0]
    RAW Range[81000000:00000000:00000000:81000000:00000000:00000000:00000000:00002000]
      Using flags[00000101] start[0000000000000000] size[0000000000002000]
    RAW Range[82000000:00000000:00000000:82000000:00000000:00000000:00000000:00c00000]
      Using flags[00000200] start[0000000000000000] size[0000000000c00000]
    bus name: PCI Bus 0000:02
PCI: scan_bus[/pci@400/pci@1/pci@0] bus no 2
  * /pci@400/pci@1/pci@0/pci@0
    create device, devfn: 0, type: pciex
    class: 0x60400 device name: 0000:02:00.0
    adding to system ...
pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
PCI: dev header type: 1
of_scan_pci_bridge(/pci@400/pci@1/pci@0/pci@0)
    Bridge bus range [3 --> 4]
    Bridge ranges[fff8001fffe376c0] simba[0]
    RAW Range[81000000:00000000:00000000:81000000:00000000:00000000:00000000:00001000]
      Using flags[00000101] start[0000000000000000] size[0000000000001000]
    RAW Range[82000000:00000000:00000000:82000000:00000000:00000000:00000000:00900000]
      Using flags[00000200] start[0000000000000000] size[0000000000900000]
    bus name: PCI Bus 0000:03
PCI: scan_bus[/pci@400/pci@1/pci@0/pci@0] bus no 3
  * /pci@400/pci@1/pci@0/pci@0/pci@0
    create device, devfn: 0, type: pciex
    class: 0x60400 device name: 0000:03:00.0
    adding to system ...
pci 0000:03:00.0: supports D1 D2
pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
PCI: dev header type: 1
of_scan_pci_bridge(/pci@400/pci@1/pci@0/pci@0/pci@0)
    Bridge bus range [4 --> 4]
    Bridge ranges[fff8001fffe36380] simba[0]
    RAW Range[81000000:00000000:00000000:81000000:00000000:00000000:00000000:00001000]
      Using flags[00000101] start[0000000000000000] size[0000000000001000]
    RAW Range[82000000:00000000:00000000:82000000:00000000:00000000:00000000:00900000]
      Using flags[00000200] start[0000000000000000] size[0000000000900000]
    bus name: PCI Bus 0000:04
PCI: scan_bus[/pci@400/pci@1/pci@0/pci@0/pci@0] bus no 4
  * /pci@400/pci@1/pci@0/pci@0/pci@0/display@0
    create device, devfn: 0, type: display
    class: 0x30000 device name: 0000:04:00.0
    parse addresses (80 bytes) @ fff8001fffe34f40
  start: 84000000000, end: 840007fffff, i: 10
  start: 84000800000, end: 8400081ffff, i: 14
  start: 85100000000, end: 8510000007f, i: 18
  start: 84000000000, end: 8400000ffff, i: 30
    adding to system ...
pci 0000:04:00.0: supports D1 D2
pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
PCI: dev header type: 0
  * /pci@400/pci@1/pci@0/pci@4
    create device, devfn: 20, type: pciex
    class: 0x60400 device name: 0000:02:04.0
    adding to system ...
pci 0000:02:04.0: PME# supported from D0 D3hot D3cold
PCI: dev header type: 1
of_scan_pci_bridge(/pci@400/pci@1/pci@0/pci@4)
    Bridge bus range [5 --> 5]
    Bridge ranges[fff8001fffe339c0] simba[0]
    RAW Range[81000000:00000000:00001000:81000000:00000000:00001000:00000000:00001000]
      Using flags[00000101] start[0000000000001000] size[0000000000001000]
    RAW Range[82000000:00000000:00900000:82000000:00000000:00900000:00000000:00200000]
      Using flags[00000200] start[0000000000900000] size[0000000000200000]
    bus name: PCI Bus 0000:05
PCI: scan_bus[/pci@400/pci@1/pci@0/pci@4] bus no 5
  * /pci@400/pci@1/pci@0/pci@4/network@0
    create device, devfn: 0, type: network
    class: 0x20000 device name: 0000:05:00.0
    parse addresses (100 bytes) @ fff8001fffe324c0
  start: 84000900000, end: 8400091ffff, i: 10
  start: 84000920000, end: 8400093ffff, i: 14
  start: 85100001000, end: 8510000101f, i: 18
  start: 84000940000, end: 84000943fff, i: 1c
  start: 84000960000, end: 8400097ffff, i: 30
    adding to system ...
pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
pci 0000:05:00.0: reg 0x184: [mem 0x84000980000-0x84000983fff]
pci 0000:05:00.0: VF(n) BAR0 space: [mem 0x84000980000-0x8400099ffff] (contains BAR0 for 8 VFs)
pci 0000:05:00.0: reg 0x190: [mem 0x840009a0000-0x840009a3fff]
pci 0000:05:00.0: VF(n) BAR3 space: [mem 0x840009a0000-0x840009bffff] (contains BAR3 for 8 VFs)
PCI: dev header type: 0
  * /pci@400/pci@1/pci@0/pci@4/network@0,1
    create device, devfn: 1, type: network
    class: 0x20000 device name: 0000:05:00.1
    parse addresses (100 bytes) @ fff8001fffe30840
  start: 840009c0000, end: 840009dffff, i: 10
  start: 840009e0000, end: 840009fffff, i: 14
  start: 85100001020, end: 8510000103f, i: 18
  start: 84000944000, end: 84000947fff, i: 1c
  start: 84000a00000, end: 84000a1ffff, i: 30
    adding to system ...
pci 0000:05:00.1: PME# supported from D0 D3hot D3cold
pci 0000:05:00.1: reg 0x184: [mem 0x84000a20000-0x84000a23fff]
pci 0000:05:00.1: VF(n) BAR0 space: [mem 0x84000a20000-0x84000a3ffff] (contains BAR0 for 8 VFs)
pci 0000:05:00.1: reg 0x190: [mem 0x84000a40000-0x84000a43fff]
pci 0000:05:00.1: VF(n) BAR3 space: [mem 0x84000a40000-0x84000a5ffff] (contains BAR3 for 8 VFs)
PCI: dev header type: 0
  * /pci@400/pci@1/pci@0/pci@8
    create device, devfn: 40, type: pciex
    class: 0x60400 device name: 0000:02:08.0
    adding to system ...
pci 0000:02:08.0: PME# supported from D0 D3hot D3cold
PCI: dev header type: 1
of_scan_pci_bridge(/pci@400/pci@1/pci@0/pci@8)
    Bridge bus range [6 --> 6]
    Bridge ranges[          (null)] simba[0]
pci 0000:02:08.0: PCI bridge to [bus 06]
    bus name: PCI Bus 0000:06
PCI: scan_bus[/pci@400/pci@1/pci@0/pci@8] bus no 6
  * /pci@400/pci@1/pci@0/pci@b
    create device, devfn: 58, type: pciex
    class: 0x60400 device name: 0000:02:0b.0
    adding to system ...
pci 0000:02:0b.0: PME# supported from D0 D3hot D3cold
PCI: dev header type: 1
of_scan_pci_bridge(/pci@400/pci@1/pci@0/pci@b)
    Bridge bus range [7 --> 8]
    Bridge ranges[fff8001fffe2dd00] simba[0]
    RAW Range[82000000:00000000:00b00000:82000000:00000000:00b00000:00000000:00100000]
      Using flags[00000200] start[0000000000b00000] size[0000000000100000]
    bus name: PCI Bus 0000:07
PCI: scan_bus[/pci@400/pci@1/pci@0/pci@b] bus no 7
  * /pci@400/pci@1/pci@0/pci@b/pci@0
    create device, devfn: 0, type: pciex
    class: 0x60400 device name: 0000:07:00.0
    adding to system ...
pci 0000:07:00.0: supports D1
pci 0000:07:00.0: PME# supported from D0 D1 D3hot
PCI: dev header type: 1
of_scan_pci_bridge(/pci@400/pci@1/pci@0/pci@b/pci@0)
    Bridge bus range [8 --> 8]
    Bridge ranges[fff8001fffe2ca00] simba[0]
    RAW Range[82000000:00000000:00b00000:82000000:00000000:00b00000:00000000:00100000]
      Using flags[00000200] start[0000000000b00000] size[0000000000100000]
    bus name: PCI Bus 0000:08
PCI: scan_bus[/pci@400/pci@1/pci@0/pci@b/pci@0] bus no 8
  * /pci@400/pci@1/pci@0/pci@b/pci@0/usb@0
    create device, devfn: 0, type: ohci
    class: 0xc0310 device name: 0000:08:00.0
    parse addresses (20 bytes) @ fff8001fffe2b800
  start: 84000b00000, end: 84000b01fff, i: 10
    adding to system ...
pci 0000:08:00.0: supports D1 D2
pci 0000:08:00.0: PME# supported from D0 D1 D2 D3hot
PCI: dev header type: 0
  * /pci@400/pci@1/pci@0/pci@b/pci@0/usb@0,1
    create device, devfn: 1, type: ohci
    class: 0xc0310 device name: 0000:08:00.1
    parse addresses (20 bytes) @ fff8001fffe2a200
  start: 84000b02000, end: 84000b03fff, i: 10
    adding to system ...
pci 0000:08:00.1: supports D1 D2
pci 0000:08:00.1: PME# supported from D0 D1 D2 D3hot
PCI: dev header type: 0
  * /pci@400/pci@1/pci@0/pci@b/pci@0/usb@0,2
    create device, devfn: 2, type: ehci
    class: 0xc0320 device name: 0000:08:00.2
    parse addresses (20 bytes) @ fff8001fffe28c00
  start: 84000b04000, end: 84000b05fff, i: 10
    adding to system ...
pci 0000:08:00.2: supports D1 D2
pci 0000:08:00.2: PME# supported from D0 D1 D2 D3hot
PCI: dev header type: 0
  * /pci@400/pci@1/pci@0/pci@c
    create device, devfn: 60, type: pciex
    class: 0x60400 device name: 0000:02:0c.0
    adding to system ...
pci 0000:02:0c.0: PME# supported from D0 D3hot D3cold
PCI: dev header type: 1
of_scan_pci_bridge(/pci@400/pci@1/pci@0/pci@c)
    Bridge bus range [9 --> 9]
    Bridge ranges[          (null)] simba[0]
pci 0000:02:0c.0: PCI bridge to [bus 09]
    bus name: PCI Bus 0000:09
PCI: scan_bus[/pci@400/pci@1/pci@0/pci@c] bus no 9
  * /pci@400/pci@2
    create device, devfn: 10, type: pciex
    class: 0x60400 device name: 0000:00:02.0
    adding to system ...
pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
PCI: dev header type: 1
of_scan_pci_bridge(/pci@400/pci@2)
    Bridge bus range [10 --> 15]
    Bridge ranges[fff8001fffe1aa40] simba[0]
    RAW Range[81000000:00000000:00002000:81000000:00000000:00002000:00000000:00002000]
      Using flags[00000101] start[0000000000002000] size[0000000000002000]
    RAW Range[82000000:00000000:00c00000:82000000:00000000:00c00000:00000000:00200000]
      Using flags[00000200] start[0000000000c00000] size[0000000000200000]
    RAW Range[c3000000:00000041:00000000:c3000000:00000041:00000000:00000000:20000000]
      Using flags[0010220c] start[0000004100000000] size[0000000020000000]
    bus name: PCI Bus 0000:0a
PCI: scan_bus[/pci@400/pci@2] bus no 10
  * /pci@400/pci@2/pci@0
    create device, devfn: 0, type: pciex
    class: 0x60400 device name: 0000:0a:00.0
    adding to system ...
pci 0000:0a:00.0: PME# supported from D0 D3hot D3cold
PCI: dev header type: 1
of_scan_pci_bridge(/pci@400/pci@2/pci@0)
    Bridge bus range [11 --> 15]
    Bridge ranges[fff8001fffe19900] simba[0]
    RAW Range[81000000:00000000:00002000:81000000:00000000:00002000:00000000:00002000]
      Using flags[00000101] start[0000000000002000] size[0000000000002000]
    RAW Range[82000000:00000000:00c00000:82000000:00000000:00c00000:00000000:00200000]
      Using flags[00000200] start[0000000000c00000] size[0000000000200000]
    RAW Range[c3000000:00000041:00000000:c3000000:00000041:00000000:00000000:20000000]
      Using flags[0010220c] start[0000004100000000] size[0000000020000000]
    bus name: PCI Bus 0000:0b
PCI: scan_bus[/pci@400/pci@2/pci@0] bus no 11
  * /pci@400/pci@2/pci@0/pci@0
    create device, devfn: 0, type: pciex
    class: 0x60400 device name: 0000:0b:00.0
    adding to system ...
pci 0000:0b:00.0: PME# supported from D0 D3hot D3cold
PCI: dev header type: 1
of_scan_pci_bridge(/pci@400/pci@2/pci@0/pci@0)
    Bridge bus range [12 --> 12]
    Bridge ranges[          (null)] simba[0]
pci 0000:0b:00.0: PCI bridge to [bus 0c]
    bus name: PCI Bus 0000:0c
PCI: scan_bus[/pci@400/pci@2/pci@0/pci@0] bus no 12
  * /pci@400/pci@2/pci@0/pci@4
    create device, devfn: 20, type: pciex
    class: 0x60400 device name: 0000:0b:04.0
    adding to system ...
pci 0000:0b:04.0: PME# supported from D0 D3hot D3cold
PCI: dev header type: 1
of_scan_pci_bridge(/pci@400/pci@2/pci@0/pci@4)
    Bridge bus range [13 --> 13]
    Bridge ranges[          (null)] simba[0]
pci 0000:0b:04.0: PCI bridge to [bus 0d]
    bus name: PCI Bus 0000:0d
PCI: scan_bus[/pci@400/pci@2/pci@0/pci@4] bus no 13
  * /pci@400/pci@2/pci@0/pci@8
    create device, devfn: 40, type: pciex
    class: 0x60400 device name: 0000:0b:08.0
    adding to system ...
pci 0000:0b:08.0: PME# supported from D0 D3hot D3cold
PCI: dev header type: 1
of_scan_pci_bridge(/pci@400/pci@2/pci@0/pci@8)
    Bridge bus range [14 --> 14]
    Bridge ranges[fff8001fffe161c0] simba[0]
    RAW Range[81000000:00000000:00002000:81000000:00000000:00002000:00000000:00001000]
      Using flags[00000101] start[0000000000002000] size[0000000000001000]
    RAW Range[82000000:00000000:00c00000:82000000:00000000:00c00000:00000000:00100000]
      Using flags[00000200] start[0000000000c00000] size[0000000000100000]
    RAW Range[c3000000:00000041:00000000:c3000000:00000041:00000000:00000000:10000000]
      Using flags[0010220c] start[0000004100000000] size[0000000010000000]
    bus name: PCI Bus 0000:0e
PCI: scan_bus[/pci@400/pci@2/pci@0/pci@8] bus no 14
  * /pci@400/pci@2/pci@0/pci@8/SUNW,emlxs@0
    create device, devfn: 0, type: scsi-fcp
    class: 0xc0400 device name: 0000:0e:00.0
    parse addresses (80 bytes) @ fff8001fffe14f80
  start: 84100000000, end: 84100001fff, i: 10
  start: 84100004000, end: 84100007fff, i: 18
  start: 85100002000, end: 851000020ff, i: 20
  start: 84000c00000, end: 84000c3ffff, i: 30
    adding to system ...
PCI: dev header type: 0
  * /pci@400/pci@2/pci@0/pci@8/SUNW,emlxs@0,1
    create device, devfn: 1, type: scsi-fcp
    class: 0xc0400 device name: 0000:0e:00.1
    parse addresses (80 bytes) @ fff8001fffe61280
  start: 84100002000, end: 84100003fff, i: 10
  start: 84100008000, end: 8410000bfff, i: 18
  start: 85100002100, end: 851000021ff, i: 20
  start: 84000c40000, end: 84000c7ffff, i: 30
    adding to system ...
PCI: dev header type: 0
  * /pci@400/pci@2/pci@0/pci@e
    create device, devfn: 70, type: pciex
    class: 0x60400 device name: 0000:0b:0e.0
    adding to system ...
pci 0000:0b:0e.0: PME# supported from D0 D3hot D3cold
PCI: dev header type: 1
of_scan_pci_bridge(/pci@400/pci@2/pci@0/pci@e)
    Bridge bus range [15 --> 15]
    Bridge ranges[fff8001fffe5e140] simba[0]
    RAW Range[81000000:00000000:00003000:81000000:00000000:00003000:00000000:00001000]
      Using flags[00000101] start[0000000000003000] size[0000000000001000]
    RAW Range[82000000:00000000:00d00000:82000000:00000000:00d00000:00000000:00100000]
      Using flags[00000200] start[0000000000d00000] size[0000000000100000]
    RAW Range[c3000000:00000041:10000000:c3000000:00000041:10000000:00000000:10000000]
      Using flags[0010220c] start[0000004110000000] size[0000000010000000]
    bus name: PCI Bus 0000:0f
PCI: scan_bus[/pci@400/pci@2/pci@0/pci@e] bus no 15
  * /pci@400/pci@2/pci@0/pci@e/scsi@0
    create device, devfn: 0, type: scsi-sas
    class: 0x10700 device name: 0000:0f:00.0
    parse addresses (80 bytes) @ fff8001fffe5cb40
  start: 85100003000, end: 851000030ff, i: 10
  start: 84110000000, end: 84110003fff, i: 14
  start: 84110040000, end: 8411007ffff, i: 1c
  start: 84000d00000, end: 84000d7ffff, i: 30
    adding to system ...
pci 0000:0f:00.0: supports D1 D2
pci 0000:0f:00.0: reg 0x174: [mem 0x84110080000-0x84110083fff 64bit]
pci 0000:0f:00.0: VF(n) BAR0 space: [mem 0x84110080000-0x841100bffff 64bit] (contains BAR0 for 16 VFs)
pci 0000:0f:00.0: reg 0x17c: [mem 0x841100c0000-0x841100fffff 64bit]
pci 0000:0f:00.0: VF(n) BAR2 space: [mem 0x841100c0000-0x841104bffff 64bit] (contains BAR2 for 16 VFs)
PCI: dev header type: 0
PCI: Claiming 0000:00:01.0: Resource 13: 0000085100000000..0000085100001fff [101]
PCI: Claiming 0000:00:01.0: Resource 14: 0000084000000000..0000084000bfffff [200]
PCI: Claiming 0000:00:02.0: Resource 13: 0000085100002000..0000085100003fff [101]
PCI: Claiming 0000:00:02.0: Resource 14: 0000084000c00000..0000084000dfffff [200]
PCI: Claiming 0000:00:02.0: Resource 15: 0000084100000000..000008411fffffff [10220c]
PCI: Claiming 0000:01:00.0: Resource 13: 0000085100000000..0000085100001fff [101]
PCI: Claiming 0000:01:00.0: Resource 14: 0000084000000000..0000084000bfffff [200]
PCI: Claiming 0000:02:00.0: Resource 13: 0000085100000000..0000085100000fff [101]
PCI: Claiming 0000:02:00.0: Resource 14: 0000084000000000..00000840008fffff [200]
PCI: Claiming 0000:02:04.0: Resource 13: 0000085100001000..0000085100001fff [101]
PCI: Claiming 0000:02:04.0: Resource 14: 0000084000900000..0000084000afffff [200]
PCI: Claiming 0000:02:0b.0: Resource 14: 0000084000b00000..0000084000bfffff [200]
PCI: Claiming 0000:03:00.0: Resource 13: 0000085100000000..0000085100000fff [101]
PCI: Claiming 0000:03:00.0: Resource 14: 0000084000000000..00000840008fffff [200]
PCI: Claiming 0000:04:00.0: Resource 0: 0000084000000000..00000840007fffff [200]
PCI: Claiming 0000:04:00.0: Resource 1: 0000084000800000..000008400081ffff [200]
PCI: Claiming 0000:04:00.0: Resource 2: 0000085100000000..000008510000007f [101]
PCI: Claiming 0000:04:00.0: Resource 6: 0000084000000000..000008400000ffff [44200]
pci 0000:04:00.0: can't claim BAR 6 [mem 0x84000000000-0x8400000ffff]: address conflict with 0000:04:00.0 [mem 0x84000000000-0x840007fffff]
PCI: Claiming 0000:05:00.0: Resource 0: 0000084000900000..000008400091ffff [200]
PCI: Claiming 0000:05:00.0: Resource 1: 0000084000920000..000008400093ffff [200]
PCI: Claiming 0000:05:00.0: Resource 2: 0000085100001000..000008510000101f [101]
PCI: Claiming 0000:05:00.0: Resource 3: 0000084000940000..0000084000943fff [200]
PCI: Claiming 0000:05:00.0: Resource 6: 0000084000960000..000008400097ffff [44200]
PCI: Claiming 0000:05:00.0: Resource 7: 0000084000980000..000008400099ffff [40200]
PCI: Claiming 0000:05:00.0: Resource 10: 00000840009a0000..00000840009bffff [40200]
PCI: Claiming 0000:05:00.1: Resource 0: 00000840009c0000..00000840009dffff [200]
PCI: Claiming 0000:05:00.1: Resource 1: 00000840009e0000..00000840009fffff [200]
PCI: Claiming 0000:05:00.1: Resource 2: 0000085100001020..000008510000103f [101]
PCI: Claiming 0000:05:00.1: Resource 3: 0000084000944000..0000084000947fff [200]
PCI: Claiming 0000:05:00.1: Resource 6: 0000084000a00000..0000084000a1ffff [44200]
PCI: Claiming 0000:05:00.1: Resource 7: 0000084000a20000..0000084000a3ffff [40200]
PCI: Claiming 0000:05:00.1: Resource 10: 0000084000a40000..0000084000a5ffff [40200]
PCI: Claiming 0000:07:00.0: Resource 14: 0000084000b00000..0000084000bfffff [200]
PCI: Claiming 0000:08:00.0: Resource 0: 0000084000b00000..0000084000b01fff [200]
PCI: Claiming 0000:08:00.1: Resource 0: 0000084000b02000..0000084000b03fff [200]
PCI: Claiming 0000:08:00.2: Resource 0: 0000084000b04000..0000084000b05fff [200]
PCI: Claiming 0000:0a:00.0: Resource 13: 0000085100002000..0000085100003fff [101]
PCI: Claiming 0000:0a:00.0: Resource 14: 0000084000c00000..0000084000dfffff [200]
PCI: Claiming 0000:0a:00.0: Resource 15: 0000084100000000..000008411fffffff [10220c]
PCI: Claiming 0000:0b:08.0: Resource 13: 0000085100002000..0000085100002fff [101]
PCI: Claiming 0000:0b:08.0: Resource 14: 0000084000c00000..0000084000cfffff [200]
PCI: Claiming 0000:0b:08.0: Resource 15: 0000084100000000..000008410fffffff [10220c]
PCI: Claiming 0000:0b:0e.0: Resource 13: 0000085100003000..0000085100003fff [101]
PCI: Claiming 0000:0b:0e.0: Resource 14: 0000084000d00000..0000084000dfffff [200]
PCI: Claiming 0000:0b:0e.0: Resource 15: 0000084110000000..000008411fffffff [10220c]
PCI: Claiming 0000:0e:00.0: Resource 0: 0000084100000000..0000084100001fff [100204]
PCI: Claiming 0000:0e:00.0: Resource 2: 0000084100004000..0000084100007fff [100204]
PCI: Claiming 0000:0e:00.0: Resource 4: 0000085100002000..00000851000020ff [101]
PCI: Claiming 0000:0e:00.0: Resource 6: 0000084000c00000..0000084000c3ffff [44200]
PCI: Claiming 0000:0e:00.1: Resource 0: 0000084100002000..0000084100003fff [100204]
PCI: Claiming 0000:0e:00.1: Resource 2: 0000084100008000..000008410000bfff [100204]
PCI: Claiming 0000:0e:00.1: Resource 4: 0000085100002100..00000851000021ff [101]
PCI: Claiming 0000:0e:00.1: Resource 6: 0000084000c40000..0000084000c7ffff [44200]
PCI: Claiming 0000:0f:00.0: Resource 0: 0000085100003000..00000851000030ff [101]
PCI: Claiming 0000:0f:00.0: Resource 1: 0000084110000000..0000084110003fff [100204]
PCI: Claiming 0000:0f:00.0: Resource 3: 0000084110040000..000008411007ffff [100204]
PCI: Claiming 0000:0f:00.0: Resource 6: 0000084000d00000..0000084000d7ffff [44200]
PCI: Claiming 0000:0f:00.0: Resource 7: 0000084110080000..00000841100bffff [140204]
PCI: Claiming 0000:0f:00.0: Resource 9: 00000841100c0000..00000841104bffff [140204]
pci_bus 0000:00:  can't claim Video RAM area [mem 0x840000a0000-0x840000bffff]: address conflict with PCI Bus 0000:01 [mem 0x84000000000-0x84000bfffff]
pci_bus 0000:00:  can't claim System ROM [mem 0x840000f0000-0x840000fffff]: address conflict with PCI Bus 0000:01 [mem 0x84000000000-0x84000bfffff]
pci_bus 0000:00:  can't claim Video ROM [mem 0x840000c0000-0x840000c7fff]: address conflict with PCI Bus 0000:01 [mem 0x84000000000-0x84000bfffff]
/pci@500: SUN4V PCI Bus Module
/pci@500: On NUMA node 1
/pci@500: PCI IO [io  0x8d100000000-0x8d10fffffff] offset 8d100000000
/pci@500: PCI MEM [mem 0x8c000000000-0x8c07f7fffff] offset 8c000000000
/pci@500: PCI MEM64 [mem 0x8c100000000-0x8c7ffffffff] offset 88000000000
/pci@500: Unable to request IOMMU resource.
/pci@500: MSI Queue first[0] num[56] count[512] devino[0x6]
/pci@500: MSI first[0] num[512] mask[0x3ff] width[32]
/pci@500: MSI addr32[0x7f800000:0x800000] addr64[0xe00000003f800000:0x800000]
/pci@500: MSI queues at RA [0000001fd3600000]
PCI: Scanning PBM /pci@500
pci_sun4v f02b4a94: PCI host bridge to bus 0001:00
pci_bus 0001:00: root bus resource [io  0x8d100000000-0x8d10fffffff] (bus address [0x0000-0xfffffff])
pci_bus 0001:00: root bus resource [mem 0x8c000000000-0x8c07f7fffff] (bus address [0x00000000-0x7f7fffff])
pci_bus 0001:00: root bus resource [mem 0x8c100000000-0x8c7ffffffff] (bus address [0x4100000000-0x47ffffffff])
pci_bus 0001:00: root bus resource [bus 00-0a]
PCI: scan_bus[/pci@500] bus no 0
  * /pci@500/pci@1
    create device, devfn: 8, type: pciex
    class: 0x60400 device name: 0001:00:01.0
    adding to system ...
pci 0001:00:01.0: PME# supported from D0 D3hot D3cold
PCI: dev header type: 1
of_scan_pci_bridge(/pci@500/pci@1)
    Bridge bus range [1 --> 5]
    Bridge ranges[fff8001fffe585c0] simba[0]
    RAW Range[81000000:00000000:00000000:81000000:00000000:00000000:00000000:00001000]
      Using flags[00000101] start[0000000000000000] size[0000000000001000]
    RAW Range[82000000:00000000:00000000:82000000:00000000:00000000:00000000:00200000]
      Using flags[00000200] start[0000000000000000] size[0000000000200000]
    bus name: PCI Bus 0001:01
PCI: scan_bus[/pci@500/pci@1] bus no 1
  * /pci@500/pci@1/pci@0
    create device, devfn: 0, type: pciex
    class: 0x60400 device name: 0001:01:00.0
    adding to system ...
pci 0001:01:00.0: PME# supported from D0 D3hot D3cold
PCI: dev header type: 1
of_scan_pci_bridge(/pci@500/pci@1/pci@0)
    Bridge bus range [2 --> 5]
    Bridge ranges[fff8001fffe57480] simba[0]
    RAW Range[81000000:00000000:00000000:81000000:00000000:00000000:00000000:00001000]
      Using flags[00000101] start[0000000000000000] size[0000000000001000]
    RAW Range[82000000:00000000:00000000:82000000:00000000:00000000:00000000:00200000]
      Using flags[00000200] start[0000000000000000] size[0000000000200000]
    bus name: PCI Bus 0001:02
PCI: scan_bus[/pci@500/pci@1/pci@0] bus no 2
  * /pci@500/pci@1/pci@0/pci@0
    create device, devfn: 0, type: pciex
    class: 0x60400 device name: 0001:02:00.0
    adding to system ...
pci 0001:02:00.0: PME# supported from D0 D3hot D3cold
PCI: dev header type: 1
of_scan_pci_bridge(/pci@500/pci@1/pci@0/pci@0)
    Bridge bus range [3 --> 3]
    Bridge ranges[          (null)] simba[0]
pci 0001:02:00.0: PCI bridge to [bus 03]
    bus name: PCI Bus 0001:03
PCI: scan_bus[/pci@500/pci@1/pci@0/pci@0] bus no 3
  * /pci@500/pci@1/pci@0/pci@5
    create device, devfn: 28, type: pciex
    class: 0x60400 device name: 0001:02:05.0
    adding to system ...
pci 0001:02:05.0: PME# supported from D0 D3hot D3cold
PCI: dev header type: 1
of_scan_pci_bridge(/pci@500/pci@1/pci@0/pci@5)
    Bridge bus range [4 --> 4]
    Bridge ranges[fff8001fffe55040] simba[0]
    RAW Range[81000000:00000000:00000000:81000000:00000000:00000000:00000000:00001000]
      Using flags[00000101] start[0000000000000000] size[0000000000001000]
    RAW Range[82000000:00000000:00000000:82000000:00000000:00000000:00000000:00200000]
      Using flags[00000200] start[0000000000000000] size[0000000000200000]
    bus name: PCI Bus 0001:04
PCI: scan_bus[/pci@500/pci@1/pci@0/pci@5] bus no 4
  * /pci@500/pci@1/pci@0/pci@5/network@0
    create device, devfn: 0, type: network
    class: 0x20000 device name: 0001:04:00.0
    parse addresses (100 bytes) @ fff8001fffe53b40
  start: 8c000000000, end: 8c00001ffff, i: 10
  start: 8c000020000, end: 8c00003ffff, i: 14
  start: 8d100000000, end: 8d10000001f, i: 18
  start: 8c000040000, end: 8c000043fff, i: 1c
  start: 8c000060000, end: 8c00007ffff, i: 30
    adding to system ...
pci 0001:04:00.0: PME# supported from D0 D3hot D3cold
pci 0001:04:00.0: reg 0x184: [mem 0x8c000080000-0x8c000083fff]
pci 0001:04:00.0: VF(n) BAR0 space: [mem 0x8c000080000-0x8c00009ffff] (contains BAR0 for 8 VFs)
pci 0001:04:00.0: reg 0x190: [mem 0x8c0000a0000-0x8c0000a3fff]
pci 0001:04:00.0: VF(n) BAR3 space: [mem 0x8c0000a0000-0x8c0000bffff] (contains BAR3 for 8 VFs)
PCI: dev header type: 0
  * /pci@500/pci@1/pci@0/pci@5/network@0,1
    create device, devfn: 1, type: network
    class: 0x20000 device name: 0001:04:00.1
    parse addresses (100 bytes) @ fff8001fffe51ec0
  start: 8c0000c0000, end: 8c0000dffff, i: 10
  start: 8c0000e0000, end: 8c0000fffff, i: 14
  start: 8d100000020, end: 8d10000003f, i: 18
  start: 8c000044000, end: 8c000047fff, i: 1c
  start: 8c000100000, end: 8c00011ffff, i: 30
    adding to system ...
pci 0001:04:00.1: PME# supported from D0 D3hot D3cold
pci 0001:04:00.1: reg 0x184: [mem 0x8c000120000-0x8c000123fff]
pci 0001:04:00.1: VF(n) BAR0 space: [mem 0x8c000120000-0x8c00013ffff] (contains BAR0 for 8 VFs)
pci 0001:04:00.1: reg 0x190: [mem 0x8c000140000-0x8c000143fff]
pci 0001:04:00.1: VF(n) BAR3 space: [mem 0x8c000140000-0x8c00015ffff] (contains BAR3 for 8 VFs)
PCI: dev header type: 0
  * /pci@500/pci@1/pci@0/pci@6
    create device, devfn: 30, type: pciex
    class: 0x60400 device name: 0001:02:06.0
    adding to system ...
pci 0001:02:06.0: PME# supported from D0 D3hot D3cold
PCI: dev header type: 1
of_scan_pci_bridge(/pci@500/pci@1/pci@0/pci@6)
    Bridge bus range [5 --> 5]
    Bridge ranges[          (null)] simba[0]
pci 0001:02:06.0: PCI bridge to [bus 05]
    bus name: PCI Bus 0001:05
PCI: scan_bus[/pci@500/pci@1/pci@0/pci@6] bus no 5
  * /pci@500/pci@2
    create device, devfn: 10, type: pciex
    class: 0x60400 device name: 0001:00:02.0
    adding to system ...
pci 0001:00:02.0: PME# supported from D0 D3hot D3cold
PCI: dev header type: 1
of_scan_pci_bridge(/pci@500/pci@2)
    Bridge bus range [6 --> 10]
    Bridge ranges[fff8001fffe4f340] simba[0]
    RAW Range[81000000:00000000:00001000:81000000:00000000:00001000:00000000:00001000]
      Using flags[00000101] start[0000000000001000] size[0000000000001000]
    RAW Range[82000000:00000000:00200000:82000000:00000000:00200000:00000000:00100000]
      Using flags[00000200] start[0000000000200000] size[0000000000100000]
    RAW Range[c3000000:00000041:00000000:c3000000:00000041:00000000:00000000:10000000]
      Using flags[0010220c] start[0000004100000000] size[0000000010000000]
    bus name: PCI Bus 0001:06
PCI: scan_bus[/pci@500/pci@2] bus no 6
  * /pci@500/pci@2/pci@0
    create device, devfn: 0, type: pciex
    class: 0x60400 device name: 0001:06:00.0
    adding to system ...
pci 0001:06:00.0: PME# supported from D0 D3hot D3cold
PCI: dev header type: 1
of_scan_pci_bridge(/pci@500/pci@2/pci@0)
    Bridge bus range [7 --> 10]
    Bridge ranges[fff8001fffe4e200] simba[0]
    RAW Range[81000000:00000000:00001000:81000000:00000000:00001000:00000000:00001000]
      Using flags[00000101] start[0000000000001000] size[0000000000001000]
    RAW Range[82000000:00000000:00200000:82000000:00000000:00200000:00000000:00100000]
      Using flags[00000200] start[0000000000200000] size[0000000000100000]
    RAW Range[c3000000:00000041:00000000:c3000000:00000041:00000000:00000000:10000000]
      Using flags[0010220c] start[0000004100000000] size[0000000010000000]
    bus name: PCI Bus 0001:07
PCI: scan_bus[/pci@500/pci@2/pci@0] bus no 7
  * /pci@500/pci@2/pci@0/pci@0
    create device, devfn: 0, type: pciex
    class: 0x60400 device name: 0001:07:00.0
    adding to system ...
pci 0001:07:00.0: PME# supported from D0 D3hot D3cold
PCI: dev header type: 1
of_scan_pci_bridge(/pci@500/pci@2/pci@0/pci@0)
    Bridge bus range [8 --> 8]
    Bridge ranges[          (null)] simba[0]
pci 0001:07:00.0: PCI bridge to [bus 08]
    bus name: PCI Bus 0001:08
PCI: scan_bus[/pci@500/pci@2/pci@0/pci@0] bus no 8
  * /pci@500/pci@2/pci@0/pci@6
    create device, devfn: 30, type: pciex
    class: 0x60400 device name: 0001:07:06.0
    adding to system ...
pci 0001:07:06.0: PME# supported from D0 D3hot D3cold
PCI: dev header type: 1
of_scan_pci_bridge(/pci@500/pci@2/pci@0/pci@6)
    Bridge bus range [9 --> 9]
    Bridge ranges[          (null)] simba[0]
pci 0001:07:06.0: PCI bridge to [bus 09]
    bus name: PCI Bus 0001:09
PCI: scan_bus[/pci@500/pci@2/pci@0/pci@6] bus no 9
  * /pci@500/pci@2/pci@0/pci@a
    create device, devfn: 50, type: pciex
    class: 0x60400 device name: 0001:07:0a.0
    adding to system ...
pci 0001:07:0a.0: PME# supported from D0 D3hot D3cold
PCI: dev header type: 1
of_scan_pci_bridge(/pci@500/pci@2/pci@0/pci@a)
    Bridge bus range [10 --> 10]
    Bridge ranges[fff8001fffe4aac0] simba[0]
    RAW Range[81000000:00000000:00001000:81000000:00000000:00001000:00000000:00001000]
      Using flags[00000101] start[0000000000001000] size[0000000000001000]
    RAW Range[82000000:00000000:00200000:82000000:00000000:00200000:00000000:00100000]
      Using flags[00000200] start[0000000000200000] size[0000000000100000]
    RAW Range[c3000000:00000041:00000000:c3000000:00000041:00000000:00000000:10000000]
      Using flags[0010220c] start[0000004100000000] size[0000000010000000]
    bus name: PCI Bus 0001:0a
PCI: scan_bus[/pci@500/pci@2/pci@0/pci@a] bus no 10
  * /pci@500/pci@2/pci@0/pci@a/network@0
    create device, devfn: 0, type: network
    class: 0x20000 device name: 0001:0a:00.0
    parse addresses (80 bytes) @ fff8001fffe496c0
  start: 8c100000000, end: 8c10007ffff, i: 10
  start: 8d100001000, end: 8d10000101f, i: 18
  start: 8c100080000, end: 8c100083fff, i: 20
  start: 8c000200000, end: 8c00027ffff, i: 30
    adding to system ...
pci 0001:0a:00.0: PME# supported from D0 D3hot
pci 0001:0a:00.0: reg 0x184: [mem 0x8c100084000-0x8c100087fff 64bit]
pci 0001:0a:00.0: VF(n) BAR0 space: [mem 0x8c100084000-0x8c100183fff 64bit] (contains BAR0 for 64 VFs)
pci 0001:0a:00.0: reg 0x190: [mem 0x8c100184000-0x8c100187fff 64bit]
pci 0001:0a:00.0: VF(n) BAR3 space: [mem 0x8c100184000-0x8c100283fff 64bit] (contains BAR3 for 64 VFs)
PCI: dev header type: 0
  * /pci@500/pci@2/pci@0/pci@a/network@0,1
    create device, devfn: 1, type: network
    class: 0x20000 device name: 0001:0a:00.1
    parse addresses (80 bytes) @ fff8001fffe47540
  start: 8c100300000, end: 8c10037ffff, i: 10
  start: 8d100001020, end: 8d10000103f, i: 18
  start: 8c100284000, end: 8c100287fff, i: 20
  start: 8c000280000, end: 8c0002fffff, i: 30
    adding to system ...
pci 0001:0a:00.1: PME# supported from D0 D3hot
pci 0001:0a:00.1: reg 0x184: [mem 0x8c100380000-0x8c100383fff 64bit]
pci 0001:0a:00.1: VF(n) BAR0 space: [mem 0x8c100380000-0x8c10047ffff 64bit] (contains BAR0 for 64 VFs)
pci 0001:0a:00.1: reg 0x190: [mem 0x8c100480000-0x8c100483fff 64bit]
pci 0001:0a:00.1: VF(n) BAR3 space: [mem 0x8c100480000-0x8c10057ffff 64bit] (contains BAR3 for 64 VFs)
PCI: dev header type: 0
PCI: Claiming 0001:00:01.0: Resource 13: 000008d100000000..000008d100000fff [101]
PCI: Claiming 0001:00:01.0: Resource 14: 000008c000000000..000008c0001fffff [200]
PCI: Claiming 0001:00:02.0: Resource 13: 000008d100001000..000008d100001fff [101]
PCI: Claiming 0001:00:02.0: Resource 14: 000008c000200000..000008c0002fffff [200]
PCI: Claiming 0001:00:02.0: Resource 15: 000008c100000000..000008c10fffffff [10220c]
PCI: Claiming 0001:01:00.0: Resource 13: 000008d100000000..000008d100000fff [101]
PCI: Claiming 0001:01:00.0: Resource 14: 000008c000000000..000008c0001fffff [200]
PCI: Claiming 0001:02:05.0: Resource 13: 000008d100000000..000008d100000fff [101]
PCI: Claiming 0001:02:05.0: Resource 14: 000008c000000000..000008c0001fffff [200]
PCI: Claiming 0001:04:00.0: Resource 0: 000008c000000000..000008c00001ffff [200]
PCI: Claiming 0001:04:00.0: Resource 1: 000008c000020000..000008c00003ffff [200]
PCI: Claiming 0001:04:00.0: Resource 2: 000008d100000000..000008d10000001f [101]
PCI: Claiming 0001:04:00.0: Resource 3: 000008c000040000..000008c000043fff [200]
PCI: Claiming 0001:04:00.0: Resource 6: 000008c000060000..000008c00007ffff [44200]
PCI: Claiming 0001:04:00.0: Resource 7: 000008c000080000..000008c00009ffff [40200]
PCI: Claiming 0001:04:00.0: Resource 10: 000008c0000a0000..000008c0000bffff [40200]
PCI: Claiming 0001:04:00.1: Resource 0: 000008c0000c0000..000008c0000dffff [200]
PCI: Claiming 0001:04:00.1: Resource 1: 000008c0000e0000..000008c0000fffff [200]
PCI: Claiming 0001:04:00.1: Resource 2: 000008d100000020..000008d10000003f [101]
PCI: Claiming 0001:04:00.1: Resource 3: 000008c000044000..000008c000047fff [200]
PCI: Claiming 0001:04:00.1: Resource 6: 000008c000100000..000008c00011ffff [44200]
PCI: Claiming 0001:04:00.1: Resource 7: 000008c000120000..000008c00013ffff [40200]
PCI: Claiming 0001:04:00.1: Resource 10: 000008c000140000..000008c00015ffff [40200]
PCI: Claiming 0001:06:00.0: Resource 13: 000008d100001000..000008d100001fff [101]
PCI: Claiming 0001:06:00.0: Resource 14: 000008c000200000..000008c0002fffff [200]
PCI: Claiming 0001:06:00.0: Resource 15: 000008c100000000..000008c10fffffff [10220c]
PCI: Claiming 0001:07:0a.0: Resource 13: 000008d100001000..000008d100001fff [101]
PCI: Claiming 0001:07:0a.0: Resource 14: 000008c000200000..000008c0002fffff [200]
PCI: Claiming 0001:07:0a.0: Resource 15: 000008c100000000..000008c10fffffff [10220c]
PCI: Claiming 0001:0a:00.0: Resource 0: 000008c100000000..000008c10007ffff [100204]
PCI: Claiming 0001:0a:00.0: Resource 2: 000008d100001000..000008d10000101f [101]
PCI: Claiming 0001:0a:00.0: Resource 4: 000008c100080000..000008c100083fff [100204]
PCI: Claiming 0001:0a:00.0: Resource 6: 000008c000200000..000008c00027ffff [44200]
PCI: Claiming 0001:0a:00.0: Resource 7: 000008c100084000..000008c100183fff [140204]
PCI: Claiming 0001:0a:00.0: Resource 10: 000008c100184000..000008c100283fff [140204]
PCI: Claiming 0001:0a:00.1: Resource 0: 000008c100300000..000008c10037ffff [100204]
PCI: Claiming 0001:0a:00.1: Resource 2: 000008d100001020..000008d10000103f [101]
PCI: Claiming 0001:0a:00.1: Resource 4: 000008c100284000..000008c100287fff [100204]
PCI: Claiming 0001:0a:00.1: Resource 6: 000008c000280000..000008c0002fffff [44200]
PCI: Claiming 0001:0a:00.1: Resource 7: 000008c100380000..000008c10047ffff [140204]
PCI: Claiming 0001:0a:00.1: Resource 10: 000008c100480000..000008c10057ffff [140204]
pci_bus 0001:00:  can't claim Video RAM area [mem 0x8c0000a0000-0x8c0000bffff]: address conflict with PCI Bus 0001:01 [mem 0x8c000000000-0x8c0001fffff]
pci_bus 0001:00:  can't claim System ROM [mem 0x8c0000f0000-0x8c0000fffff]: address conflict with PCI Bus 0001:01 [mem 0x8c000000000-0x8c0001fffff]
pci_bus 0001:00:  can't claim Video ROM [mem 0x8c0000c0000-0x8c0000c7fff]: address conflict with PCI Bus 0001:01 [mem 0x8c000000000-0x8c0001fffff]
vgaarb: device added: PCI:0000:04:00.0,decodes=io+mem,owns=none,locks=none
vgaarb: loaded
vgaarb: bridge control possible 0000:04:00.0
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
SUN4V: Reboot data supported (maj=1,min=0).
ds.c:v1.0 (Jul 11, 2007)
clocksource: Switched to clocksource stick
ds-1: Registered pri service.
ds-1: Registered var-config-backup service.
NET: Registered protocol family 2
TCP established hash table entries: 524288 (order: 9, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 7, 1048576 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
UDP hash table entries: 65536 (order: 8, 2097152 bytes)
UDP-Lite hash table entries: 65536 (order: 8, 2097152 bytes)
NET: Registered protocol family 1
PCI: Enabling device: (0000:08:00.2), cmd 2
PCI: CLS mismatch (64 != 512), using 64 bytes
Trying to unpack rootfs image as initramfs...
Freeing initrd memory: 31520K (fff8000064000000 - fff8000065ec8000)
futex hash table entries: 32768 (order: 8, 2097152 bytes)
audit: initializing netlink subsys (disabled)
audit: type=2000 audit(2.451:1): initialized
Initialise system trusted keyring
HugeTLB registered 8 MB page size, pre-allocated 0 pages
VFS: Disk quotas dquot_6.6.0
VFS: Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
SELinux:  Registering netfilter hooks
Key type asymmetric registered
Asymmetric key parser 'x509' registered
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
io scheduler noop registered
io scheduler deadline registered (default)
io scheduler cfq registered
f02993d8: ttyS0 at I/O 0x0 (irq = 1, base_baud = 115200) is a SUN4V HCONS
console [ttyHV0] enabled
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
n2rng.c:v0.2 (July 27, 2011)
n2rng f029907c: Registered RNG HVAPI major 2 minor 0
n2rng f029907c: Found multi-unit-capable RNG, units: 2
n2rng f029907c: Selftest passed on unit 0
n2rng f029907c: Selftest passed on unit 1
n2rng f029907c: RNG ready
brd: module loaded
loop: module loaded
zram: Added device: zram0
libphy: Fixed MDIO Bus: probed
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ehci-pci 0000:08:00.2: EHCI Host Controller
ehci-pci 0000:08:00.2: new USB bus registered, assigned bus number 1
ehci-pci 0000:08:00.2: irq 5, io mem 0x84000b04000
ehci-pci 0000:08:00.2: USB 2.0 started, EHCI 1.00
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 4.3.0-rc7-kh+ ehci_hcd
usb usb1: SerialNumber: 0000:08:00.2
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 5 ports detected
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci-pci: OHCI PCI platform driver
ohci-pci 0000:08:00.0: OHCI PCI host controller
ohci-pci 0000:08:00.0: new USB bus registered, assigned bus number 2
ohci-pci 0000:08:00.0: irq 6, io mem 0x84000b00000
usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: OHCI PCI host controller
usb usb2: Manufacturer: Linux 4.3.0-rc7-kh+ ohci_hcd
usb usb2: SerialNumber: 0000:08:00.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ohci-pci 0000:08:00.1: OHCI PCI host controller
ohci-pci 0000:08:00.1: new USB bus registered, assigned bus number 3
ohci-pci 0000:08:00.1: irq 4, io mem 0x84000b02000
usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: OHCI PCI host controller
usb usb3: Manufacturer: Linux 4.3.0-rc7-kh+ ohci_hcd
usb usb3: SerialNumber: 0000:08:00.1
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd: USB Universal Host Controller Interface driver
usb 1-2: new high-speed USB device number 2 using ehci-pci
mousedev: PS/2 mouse device common for all mice
rtc-sun4v rtc-sun4v: rtc core: registered sun4v as rtc0
hidraw: raw HID events driver (C) Jiri Kosina
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
drop_monitor: Initializing network drop monitor service
Initializing XFRM netlink socket
NET: Registered protocol family 17
Key type dns_resolver registered
registered taskstats version 1
Loading compiled-in X.509 certificates
Problem loading in-kernel X.509 certificate (-76)
ima: No TPM chip found, activating TPM-bypass!
rtc-sun4v rtc-sun4v: setting system clock to 2015-10-30 21:31:07 UTC (1446240667)
usb 1-2: New USB device found, idVendor=04b4, idProduct=6560
usb 1-2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
hub 1-2:1.0: USB hub found
hub 1-2:1.0: 4 ports detected
dracut: dracut-004-388.0.2.el6
dracut: rd_NO_LUKS: removing cryptoluks activation
dm_mod: module verification failed: signature and/or required key missing - tainting kernel
device-mapper: uevent: version 1.0.3
device-mapper: ioctl: 4.33.0-ioctl (2015-8-18) initialised: dm-devel@redhat.com
usb 1-2.3: new high-speed USB device number 3 using ehci-pci
udev: starting version 147
usb 1-2.3: New USB device found, idVendor=046b, idProduct=ff01
usb 1-2.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 1-2.3: Product: Generic Hub
usb 1-2.3: Manufacturer: American Megatrends Inc.
hub 1-2.3:1.0: USB hub found
hub 1-2.3:1.0: 3 ports detected
dracut: Starting plymouth daemon
dracut: rd_NO_DM: removing DM RAID activation
usb 1-2.4: new low-speed USB device number 4 using ehci-pci
dracut: rd_NO_MD: removing MD RAID activation
sha256_sparc64: Using sparc64 sha256 opcode optimized SHA-256/SHA-224 implementation
Loading iSCSI transport class v2.0-870.
iscsi: registered transport (qla4xxx)
QLogic iSCSI HBA Driver
md5_sparc64: Using sparc64 md5 opcode optimized MD5 implementation
NET: Registered protocol family 10
sha1_sparc64: Using sparc64 sha1 opcode optimized SHA-1 implementation
crc32c_sparc64: Using sparc64 crc32c opcode optimized CRC32C implementation
aes_sparc64: Using sparc64 aes opcodes optimized AES implementation
camellia_sparc64: Using sparc64 camellia opcodes optimized CAMELLIA implementation
sha512_sparc64: Using sparc64 sha512 opcode optimized SHA-512/SHA-384 implementation
des_sparc64: Using sparc64 des opcodes optimized DES implementation
usb 1-2.4: New USB device found, idVendor=046b, idProduct=ff10
usb 1-2.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 1-2.4: Product: Virtual Keyboard and Mouse
usb 1-2.4: Manufacturer: American Megatrends Inc.
input: American Megatrends Inc. Virtual Keyboard and Mouse as /devices/root/f02a5770/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:0b.0/0000:07:00.0/0000:08:00.2/usb1/1-2/1-2.4/1-2.4:1.0/0003:046B:FF10.0001/input/input0
hid-generic 0003:046B:FF10.0001: input,hidraw0: USB HID v1.10 Keyboard [American Megatrends Inc. Virtual Keyboard and Mouse] on usb-0000:08:00.2-2.4/input0
input: American Megatrends Inc. Virtual Keyboard and Mouse as /devices/root/f02a5770/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:0b.0/0000:07:00.0/0000:08:00.2/usb1/1-2/1-2.4/1-2.4:1.1/0003:046B:FF10.0002/input/input1
hid-generic 0003:046B:FF10.0002: input,hidraw1: USB HID v1.10 Mouse [American Megatrends Inc. Virtual Keyboard and Mouse] on usb-0000:08:00.2-2.4/input1
usb 1-2.3.2: new high-speed USB device number 5 using ehci-pci
usb 1-2.3.2: New USB device found, idVendor=046b, idProduct=ff20
usb 1-2.3.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 1-2.3.2: Product: Virtual Cdrom Device
usb 1-2.3.2: Manufacturer: American Megatrends Inc.
usb 1-2.3.3: new high-speed USB device number 6 using ehci-pci
libcxgbi:libcxgbi_init_module: Chelsio iSCSI driver library libcxgbi v0.9.1-ko (Apr. 2015)
libcxgbi:libcxgbi_init_module: tag itt 0x1fff, 13 bits, age 0xf, 4 bits.
usb 1-2.3.3: New USB device found, idVendor=0430, idProduct=a4a2
usb 1-2.3.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 1-2.3.3: Product: Virtual Eth Device
usb 1-2.3.3: Manufacturer: SunMicro
libcxgbi:ddp_setup_host_page_size: system PAGE 8192, ddp idx 1.
Chelsio T3 iSCSI Driver cxgb3i v2.0.1-ko (Apr. 2015)
iscsi: registered transport (cxgb3i)
Chelsio T4/T5 iSCSI Driver cxgb4i v0.9.5-ko (Apr. 2015)
iscsi: registered transport (cxgb4i)
cnic: QLogic cnicDriver v2.5.22 (July 20, 2015)
QLogic NetXtreme II iSCSI Driver bnx2i v2.7.10.1 (Jul 16, 2014)
iscsi: registered transport (bnx2i)
iscsi: registered transport (be2iscsi)
In beiscsi_module_init, tt=00000000102e40e0
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
PTP clock support registered
igb: Intel(R) Gigabit Ethernet Network Driver - version 5.3.0-k
igb: Copyright (c) 2007-2014 Intel Corporation.
PCI: Enabling device: (0000:05:00.0), cmd 146
igb 0000:05:00.0: added PHC on eth0
igb 0000:05:00.0: Intel(R) Gigabit Ethernet Network Connection
igb 0000:05:00.0: eth0: (PCIe:2.5Gb/s:Width x4) 00:21:28:f9:f6:4e
igb 0000:05:00.0: eth0: PBA No: Unknown
igb 0000:05:00.0: Using legacy interrupts. 1 rx queue(s), 1 tx queue(s)
PCI: Enabling device: (0000:05:00.1), cmd 146
igb 0000:05:00.1: added PHC on eth1
igb 0000:05:00.1: Intel(R) Gigabit Ethernet Network Connection
igb 0000:05:00.1: eth1: (PCIe:2.5Gb/s:Width x4) 00:21:28:f9:f6:4f
igb 0000:05:00.1: eth1: PBA No: Unknown
igb 0000:05:00.1: Using legacy interrupts. 1 rx queue(s), 1 tx queue(s)
PCI: Enabling device: (0001:04:00.0), cmd 146
igb 0001:04:00.0: added PHC on eth2
igb 0001:04:00.0: Intel(R) Gigabit Ethernet Network Connection
igb 0001:04:00.0: eth2: (PCIe:2.5Gb/s:Width x4) 00:21:28:f9:f6:50
igb 0001:04:00.0: eth2: PBA No: Unknown
igb 0001:04:00.0: Using legacy interrupts. 1 rx queue(s), 1 tx queue(s)
PCI: Enabling device: (0001:04:00.1), cmd 146
igb 0001:04:00.1: added PHC on eth3
igb 0001:04:00.1: Intel(R) Gigabit Ethernet Network Connection
igb 0001:04:00.1: eth3: (PCIe:2.5Gb/s:Width x4) 00:21:28:f9:f6:51
igb 0001:04:00.1: eth3: PBA No: Unknown
igb 0001:04:00.1: Using legacy interrupts. 1 rx queue(s), 1 tx queue(s)
Emulex LightPulse Fibre Channel SCSI driver 10.7.0.0.
Copyright(c) 2004-2015 Emulex.  All rights reserved.
scsi host0: Emulex LPe12000-S PCIe Fibre Channel Adapter  on PCI bus 0e device 00 irq 5
scsi host1: Emulex LPe12000-S PCIe Fibre Channel Adapter  on PCI bus 0e device 01 irq 7
mpt2sas version 20.100.00.00 loaded
mpt2sas0: 32 BIT PCI BUS DMA ADDRESSING SUPPORTED, total mem (132479920 kB)
mpt2sas0: MSI-X vectors supported: 1, no of cores: 128, max_msix_vectors: 8
mpt2sas0: IO-APIC enabled: IRQ 6
mpt2sas0: iomem(0x0000084110000000), mapped(0x0000084110000000), size(16384)
mpt2sas0: ioport(0x0000085100003000), size(256)
mpt2sas0: Allocated physical memory: size(2231 kB)
mpt2sas0: Current Controller Queue Depth(1469), Max Controller Queue Depth(1600)
mpt2sas0: Scatter Gather Elements per IO(128)
mpt2sas0: LSISAS2008: FWVersion(09.00.00.00), ChipRevision(0x03), BiosVersion(00.00.00.00)
mpt2sas0: Protocol=(Initiator,Target), Capabilities=(Raid,TLR,EEDP,Snapshot Buffer,Diag Trace Buffer,Task Set Full,NCQ)
scsi host2: Fusion MPT SAS Host
mpt2sas0: sending port enable !!
mpt2sas0: host_add: handle(0x0001), sas_addr(0x50800200011410e8), phys(8)
mpt2sas0: port enable: SUCCESS
scsi 2:0:0:0: Direct-Access     HITACHI  H106060SDSUN600G A2B0 PQ: 0 ANSI: 6
scsi 2:0:0:0: SSP: handle(0x0009), sas_addr(0x5000cca02593bc51), phy(0), device_name(0xa0cc005053bc9325)
scsi 2:0:0:0: SSP: enclosure_logical_id(0x50800200011410e8), slot(0)
scsi 2:0:1:0: CD-ROM            TEAC     DV-W28SS-V       1.0B PQ: 0 ANSI: 0
scsi 2:0:1:0: SATA: handle(0x000a), sas_addr(0x4433221107000000), phy(7), device_name(0x0000000000000000)
scsi 2:0:1:0: SATA: enclosure_logical_id(0x50800200011410e8), slot(7)
scsi 2:0:1:0: atapi(y), ncq(n), asyn_notify(n), smart(n), fua(n), sw_preserve(n)
scsi 2:0:2:0: Direct-Access     ATA      SEAGATE ST95000N SF03 PQ: 0 ANSI: 5
scsi 2:0:2:0: SATA: handle(0x000b), sas_addr(0x4433221102000000), phy(2), device_name(0xc50050002c5b2703)
scsi 2:0:2:0: SATA: enclosure_logical_id(0x50800200011410e8), slot(2)
scsi 2:0:2:0: atapi(n), ncq(y), asyn_notify(n), smart(y), fua(y), sw_preserve(y)
scsi 2:0:3:0: Direct-Access     HITACHI  H106060SDSUN600G A2B0 PQ: 0 ANSI: 6
scsi 2:0:3:0: SSP: handle(0x000c), sas_addr(0x5000cca02593ca7d), phy(1), device_name(0xa0cc00507fca9325)
scsi 2:0:3:0: SSP: enclosure_logical_id(0x50800200011410e8), slot(1)
scsi 2:0:4:0: Direct-Access     HITACHI  H106060SDSUN600G A2B0 PQ: 0 ANSI: 6
scsi 2:0:4:0: SSP: handle(0x000d), sas_addr(0x5000cca025934549), phy(3), device_name(0xa0cc00504b459325)
scsi 2:0:4:0: SSP: enclosure_logical_id(0x50800200011410e8), slot(3)
ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - version 4.0.1-k
ixgbe: Copyright (c) 1999-2015 Intel Corporation.
PCI: Enabling device: (0001:0a:00.0), cmd 146
ixgbe 0001:0a:00.0: Failed to allocate MSI-X interrupts. Err: -22
ixgbe 0001:0a:00.0: Disabling SR-IOV support
ixgbe 0001:0a:00.0: Disabling RSS support
ixgbe 0001:0a:00.0: Failed to allocate MSI interrupt, falling back to legacy. Error: -22
ixgbe 0001:0a:00.0: Multiqueue Disabled: Rx Queue count = 1, Tx Queue count = 1
ixgbe 0001:0a:00.0: PCI Express bandwidth of 32GT/s available
ixgbe 0001:0a:00.0: (Speed:5.0GT/s, Width: x8, Encoding Loss:20%)
ixgbe 0001:0a:00.0: MAC: 2, PHY: 17, SFP+: 5, PBA No: E70856-008
ixgbe 0001:0a:00.0: 90:e2:ba:14:31:88
ixgbe 0001:0a:00.0: Intel(R) 10 Gigabit Network Connection
PCI: Enabling device: (0001:0a:00.1), cmd 146
ixgbe 0001:0a:00.1: Failed to allocate MSI-X interrupts. Err: -22
ixgbe 0001:0a:00.1: Disabling SR-IOV support
ixgbe 0001:0a:00.1: Disabling RSS support
ixgbe 0001:0a:00.1: Failed to allocate MSI interrupt, falling back to legacy. Error: -22
ixgbe 0001:0a:00.1: Multiqueue Disabled: Rx Queue count = 1, Tx Queue count = 1
ixgbe 0001:0a:00.1: PCI Express bandwidth of 32GT/s available
ixgbe 0001:0a:00.1: (Speed:5.0GT/s, Width: x8, Encoding Loss:20%)
ixgbe 0001:0a:00.1: MAC: 2, PHY: 17, SFP+: 6, PBA No: E70856-008
ixgbe 0001:0a:00.1: 90:e2:ba:14:31:89
ixgbe 0001:0a:00.1: Intel(R) 10 Gigabit Network Connection
usb-storage 1-2.3.2:1.0: USB Mass Storage device detected
scsi host3: usb-storage 1-2.3.2:1.0
usbcore: registered new interface driver usb-storage
sd 2:0:0:0: [sda] 1172123568 512-byte logical blocks: (600 GB/558 GiB)
sd 2:0:4:0: [sdd] 1172123568 512-byte logical blocks: (600 GB/558 GiB)
sd 2:0:3:0: [sdc] 1172123568 512-byte logical blocks: (600 GB/558 GiB)
sd 2:0:2:0: [sdb] 976773168 512-byte logical blocks: (500 GB/465 GiB)
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Mode Sense: e7 00 10 08
sd 2:0:3:0: [sdc] Write Protect is off
sd 2:0:3:0: [sdc] Mode Sense: e7 00 10 08
sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
sd 2:0:3:0: [sdc] Write cache: disabled, read cache: enabled, supports DPO and FUA
 sda: sda1 sda3
 sdc: sdc3 sdc4 sdc5 sdc6 sdc7
sd 2:0:0:0: [sda] Attached SCSI disk
sd 2:0:3:0: [sdc] Attached SCSI disk
sd 2:0:2:0: [sdb] Write Protect is off
sd 2:0:2:0: [sdb] Mode Sense: 7f 00 00 08
sd 2:0:2:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sdb: sdb1 sdb2 sdb3
sd 2:0:4:0: [sdd] Write Protect is off
sd 2:0:4:0: [sdd] Mode Sense: e7 00 10 08
sd 2:0:4:0: [sdd] Write cache: disabled, read cache: enabled, supports DPO and FUA
 sdd:
sd 2:0:4:0: [sdd] Attached SCSI disk
sd 2:0:2:0: [sdb] Attached SCSI disk
sr 2:0:1:0: [sr0] out of memory.
cdrom: Uniform CD-ROM driver Revision: 3.20
sr 2:0:1:0: Attached scsi CD-ROM sr0
dracut: Scanning devices sdb2  for LVM logical volumes VolGroup/lv_swap VolGroup/lv_root 
random: lvm urandom read with 112 bits of entropy available
random: nonblocking pool is initialized
scsi 3:0:0:0: CD-ROM            AMI      Virtual CDROM    1.00 PQ: 0 ANSI: 0 CCS
sr 3:0:0:0: [sr1] out of memory.
sr 3:0:0:0: Attached scsi CD-ROM sr1
dracut: inactive '/dev/VolGroup/lv_root' [454.85 GiB] inherit
dracut: inactive '/dev/VolGroup/lv_swap' [9.91 GiB] inherit
EXT4-fs (dm-0): mounted filesystem with ordered data mode. Opts: (null)
dracut: Mounted root filesystem /dev/mapper/VolGroup-lv_root
dracut: Loading SELinux policy
SELinux: 65536 avtab hash slots, 305186 rules.
SELinux: 65536 avtab hash slots, 305186 rules.
SELinux:  9 users, 12 roles, 4200 types, 234 bools, 1 sens, 1024 cats
SELinux:  81 classes, 305186 rules
SELinux:  Permission execmod in class dir not defined in policy.
SELinux:  Permission execmod in class lnk_file not defined in policy.
SELinux:  Permission execmod in class blk_file not defined in policy.
SELinux:  Permission execmod in class sock_file not defined in policy.
SELinux:  Permission execmod in class fifo_file not defined in policy.
SELinux:  Class netlink_iscsi_socket not defined in policy.
SELinux:  Class netlink_fib_lookup_socket not defined in policy.
SELinux:  Class netlink_connector_socket not defined in policy.
SELinux:  Class netlink_netfilter_socket not defined in policy.
SELinux:  Class netlink_generic_socket not defined in policy.
SELinux:  Class netlink_scsitransport_socket not defined in policy.
SELinux:  Class netlink_rdma_socket not defined in policy.
SELinux:  Class netlink_crypto_socket not defined in policy.
SELinux:  Permission syslog in class capability2 not defined in policy.
SELinux:  Permission wake_alarm in class capability2 not defined in policy.
SELinux:  Permission block_suspend in class capability2 not defined in policy.
SELinux:  Permission audit_read in class capability2 not defined in policy.
SELinux:  Permission attach_queue in class tun_socket not defined in policy.
SELinux:  Class binder not defined in policy.
SELinux: the above unknown classes and permissions will be allowed
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
audit: type=1403 audit(1446240688.159:2): policy loaded auid=4294967295 ses=4294967295
dracut: 
dracut: Switching root
udev: starting version 147
sd 2:0:0:0: Attached scsi generic sg0 type 0
sr 2:0:1:0: Attached scsi generic sg1 type 5
sd 2:0:2:0: Attached scsi generic sg2 type 0
sd 2:0:3:0: Attached scsi generic sg3 type 0
sd 2:0:4:0: Attached scsi generic sg4 type 0
sr 3:0:0:0: Attached scsi generic sg5 type 5
cdc_ether 1-2.3.3:2.0 usb0: register 'cdc_ether' at usb-0000:08:00.2-2.3.3, CDC Ethernet Device, 02:21:28:57:47:17
usbcore: registered new interface driver cdc_ether
device-mapper: ioctl: device doesn't appear to be in the dev hash table.
EXT4-fs (dm-0): re-mounted. Opts: (null)
EXT4-fs (sdb1): mounting ext3 file system using the ext4 subsystem
EXT4-fs (sdb1): mounted filesystem with ordered data mode. Opts: (null)
Adding 10387448k swap on /dev/mapper/VolGroup-lv_swap.  Priority:-1 extents:1 across:10387448k FS
IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
igb 0000:05:00.0 eth0: igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
audit: type=1305 audit(1446240711.047:3): audit_pid=3147 old=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:auditd_t:s0 res=1
8021q: 802.1Q VLAN Support v1.8
8021q: adding VLAN 0 to HW filter on device eth0
bnx2fc: QLogic NetXtreme II FCoE Driver bnx2fc v2.4.2 (Dec 11, 2013)
cdc_ether 1-2.3.3:2.0 usb0: kevent 12 may have been dropped
IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
8021q: adding VLAN 0 to HW filter on device eth1
IPv6: ADDRCONF(NETDEV_UP): eth2: link is not ready
8021q: adding VLAN 0 to HW filter on device eth2
IPv6: ADDRCONF(NETDEV_UP): eth3: link is not ready
8021q: adding VLAN 0 to HW filter on device eth3
ip_tables: (C) 2000-2006 Netfilter Core Team
nf_conntrack version 0.5.0 (65536 buckets, 262144 max)
igb 0000:05:00.1 eth1: igb: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
igb 0001:04:00.1 eth3: igb: eth3 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
IPv6: ADDRCONF(NETDEV_CHANGE): eth3: link becomes ready
Process accounting resumed

--------------080108050108070509050208
Content-Type: text/plain; charset=UTF-8;
 name="iomem.4.3.0-rc7-pci.t4"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="iomem.4.3.0-rc7-pci.t4"

20400000-5fdb7fff : System RAM
5fdba000-5fdbbfff : System RAM
60000000-1fffe8dfff : System RAM
  60004000-605cf0bf : Kernel code
  605cf0c0-6093790f : Kernel data
  609ca000-60bbf040 : Kernel bss
1fffe9e000-1fffeb1fff : System RAM
1ffff30000-1ffff3ffff : System RAM
84000000000-8407f7fffff : /pci@400
  84000000000-84000bfffff : PCI Bus 0000:01
    84000000000-84000bfffff : PCI Bus 0000:02
      84000000000-840008fffff : PCI Bus 0000:03
        84000000000-840008fffff : PCI Bus 0000:04
          84000000000-840007fffff : 0000:04:00.0
          84000800000-8400081ffff : 0000:04:00.0
      84000900000-84000afffff : PCI Bus 0000:05
        84000900000-8400091ffff : 0000:05:00.0
          84000900000-8400091ffff : igb
        84000920000-8400093ffff : 0000:05:00.0
          84000920000-8400093ffff : igb
        84000940000-84000943fff : 0000:05:00.0
          84000940000-84000943fff : igb
        84000944000-84000947fff : 0000:05:00.1
          84000944000-84000947fff : igb
        84000960000-8400097ffff : 0000:05:00.0
        84000980000-8400099ffff : 0000:05:00.0
        840009a0000-840009bffff : 0000:05:00.0
        840009c0000-840009dffff : 0000:05:00.1
          840009c0000-840009dffff : igb
        840009e0000-840009fffff : 0000:05:00.1
          840009e0000-840009fffff : igb
        84000a00000-84000a1ffff : 0000:05:00.1
        84000a20000-84000a3ffff : 0000:05:00.1
        84000a40000-84000a5ffff : 0000:05:00.1
      84000b00000-84000bfffff : PCI Bus 0000:07
        84000b00000-84000bfffff : PCI Bus 0000:08
          84000b00000-84000b01fff : 0000:08:00.0
          84000b00000-84000b01fff : ohci_hcd
          84000b02000-84000b03fff : 0000:08:00.1
          84000b02000-84000b03fff : ohci_hcd
          84000b04000-84000b05fff : 0000:08:00.2
          84000b04000-84000b05fff : ehci_hcd
  84000c00000-84000dfffff : PCI Bus 0000:0a
    84000c00000-84000dfffff : PCI Bus 0000:0b
      84000c00000-84000cfffff : PCI Bus 0000:0e
        84000c00000-84000c3ffff : 0000:0e:00.0
        84000c40000-84000c7ffff : 0000:0e:00.1
      84000d00000-84000dfffff : PCI Bus 0000:0f
        84000d00000-84000d7ffff : 0000:0f:00.0
84100000000-847ffffffff : /pci@400
  84100000000-8411fffffff : PCI Bus 0000:0a
    84100000000-8411fffffff : PCI Bus 0000:0b
      84100000000-8410fffffff : PCI Bus 0000:0e
        84100000000-84100001fff : 0000:0e:00.0
          84100000000-84100001fff : lpfc
        84100002000-84100003fff : 0000:0e:00.1
          84100002000-84100003fff : lpfc
        84100004000-84100007fff : 0000:0e:00.0
          84100004000-84100007fff : lpfc
        84100008000-8410000bfff : 0000:0e:00.1
          84100008000-8410000bfff : lpfc
      84110000000-8411fffffff : PCI Bus 0000:0f
        84110000000-84110003fff : 0000:0f:00.0
          84110000000-84110003fff : mpt2sas
        84110040000-8411007ffff : 0000:0f:00.0
          84110040000-8411007ffff : mpt2sas
        84110080000-841100bffff : 0000:0f:00.0
        841100c0000-841104bffff : 0000:0f:00.0
8c000000000-8c07f7fffff : /pci@500
  8c000000000-8c0001fffff : PCI Bus 0001:01
    8c000000000-8c0001fffff : PCI Bus 0001:02
      8c000000000-8c0001fffff : PCI Bus 0001:04
        8c000000000-8c00001ffff : 0001:04:00.0
          8c000000000-8c00001ffff : igb
        8c000020000-8c00003ffff : 0001:04:00.0
          8c000020000-8c00003ffff : igb
        8c000040000-8c000043fff : 0001:04:00.0
          8c000040000-8c000043fff : igb
        8c000044000-8c000047fff : 0001:04:00.1
          8c000044000-8c000047fff : igb
        8c000060000-8c00007ffff : 0001:04:00.0
        8c000080000-8c00009ffff : 0001:04:00.0
        8c0000a0000-8c0000bffff : 0001:04:00.0
        8c0000c0000-8c0000dffff : 0001:04:00.1
          8c0000c0000-8c0000dffff : igb
        8c0000e0000-8c0000fffff : 0001:04:00.1
          8c0000e0000-8c0000fffff : igb
        8c000100000-8c00011ffff : 0001:04:00.1
        8c000120000-8c00013ffff : 0001:04:00.1
        8c000140000-8c00015ffff : 0001:04:00.1
  8c000200000-8c0002fffff : PCI Bus 0001:06
    8c000200000-8c0002fffff : PCI Bus 0001:07
      8c000200000-8c0002fffff : PCI Bus 0001:0a
        8c000200000-8c00027ffff : 0001:0a:00.0
        8c000280000-8c0002fffff : 0001:0a:00.1
8c100000000-8c7ffffffff : /pci@500
  8c100000000-8c10fffffff : PCI Bus 0001:06
    8c100000000-8c10fffffff : PCI Bus 0001:07
      8c100000000-8c10fffffff : PCI Bus 0001:0a
        8c100000000-8c10007ffff : 0001:0a:00.0
          8c100000000-8c10007ffff : ixgbe
        8c100080000-8c100083fff : 0001:0a:00.0
          8c100080000-8c100083fff : ixgbe
        8c100084000-8c100183fff : 0001:0a:00.0
        8c100184000-8c100283fff : 0001:0a:00.0
        8c100284000-8c100287fff : 0001:0a:00.1
          8c100284000-8c100287fff : ixgbe
        8c100300000-8c10037ffff : 0001:0a:00.1
          8c100300000-8c10037ffff : ixgbe
        8c100380000-8c10047ffff : 0001:0a:00.1
        8c100480000-8c10057ffff : 0001:0a:00.1

--------------080108050108070509050208
Content-Type: text/plain; charset=UTF-8;
 name="lspci.t4-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="lspci.t4-1"

-+-[0001:00]-+-01.0-[01-05]----00.0-[02-05]--+-00.0-[03]--
 |           |                               +-05.0-[04]--+-00.0  Intel Corporation 82576 Gigabit Network Connection
 |           |                               |            \-00.1  Intel Corporation 82576 Gigabit Network Connection
 |           |                               \-06.0-[05]--
 |           \-02.0-[06-0a]----00.0-[07-0a]--+-00.0-[08]--
 |                                           +-06.0-[09]--
 |                                           \-0a.0-[0a]--+-00.0  Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection
 |                                                        \-00.1  Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection
 \-[0000:00]-+-01.0-[01-09]----00.0-[02-09]--+-00.0-[03-04]----00.0-[04]----00.0  ASPEED Technology, Inc. ASPEED Graphics Family
             |                               +-04.0-[05]--+-00.0  Intel Corporation 82576 Gigabit Network Connection
             |                               |            \-00.1  Intel Corporation 82576 Gigabit Network Connection
             |                               +-08.0-[06]--
             |                               +-0b.0-[07-08]----00.0-[08]--+-00.0  NEC Corporation OHCI USB Controller
             |                               |                            +-00.1  NEC Corporation OHCI USB Controller
             |                               |                            \-00.2  NEC Corporation uPD72010x USB 2.0 Controller
             |                               \-0c.0-[09]--
             \-02.0-[0a-0f]----00.0-[0b-0f]--+-00.0-[0c]--
                                             +-04.0-[0d]--
                                             +-08.0-[0e]--+-00.0  Emulex Corporation Saturn-X: LightPulse Fibre Channel Host Adapter
                                             |            \-00.1  Emulex Corporation Saturn-X: LightPulse Fibre Channel Host Adapter
                                             \-0e.0-[0f]----00.0  LSI Logic / Symbios Logic SAS2008 PCI-Express Fusion-MPT SAS-2 [Falcon]

--------------080108050108070509050208
Content-Type: text/plain; charset=UTF-8;
 name="lspci.t4-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="lspci.t4-2"

0000:00:01.0 PCI bridge: Oracle/SUN Device 8186 (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=09, sec-latency=0
	I/O behind bridge: 00000000-00001fff
	Memory behind bridge: 00000000-00bfffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] Express (v2) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x8, ASPM unknown, Latency L0 <2us, L1 <4us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 05, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [138 v1] Vendor Specific Information: ID=1112 Rev=1 Len=014 <?>
	Capabilities: [14c v1] #00
00: 8e 10 86 81 07 00 10 00 01 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 09 00 01 11 00 00
20: 00 00 b0 00 f1 ff 01 00 4d 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00
40: 01 60 03 c8 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 42 00 01 80 00 00 00 00 00 00 82 50 39 00
70: 00 00 82 70 00 00 00 00 00 00 00 01 00 00 00 00
80: 00 00 00 00 20 00 00 00 00 00 00 00 00 00 00 00
90: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:02.0 PCI bridge: Oracle/SUN Device 8186 (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Bus: primary=00, secondary=0a, subordinate=0f, sec-latency=0
	I/O behind bridge: 00002000-00003fff
	Memory behind bridge: 00c00000-00dfffff
	Prefetchable memory behind bridge: 0000004100000000-000000411fffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] Express (v2) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #1, Speed 5GT/s, Width x8, ASPM unknown, Latency L0 <2us, L1 <4us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 05, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [138 v1] Vendor Specific Information: ID=1112 Rev=1 Len=014 <?>
	Capabilities: [14c v1] #00
00: 8e 10 86 81 07 00 10 00 01 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 0a 0f 00 21 31 00 00
20: c0 00 d0 00 01 00 f1 1f 41 00 00 00 41 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00
40: 01 60 03 c8 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 42 00 01 80 00 00 00 00 00 00 82 50 39 01
70: 00 00 82 70 00 00 00 00 00 00 00 01 00 00 00 00
80: 00 00 00 00 20 00 00 00 00 00 00 00 00 00 00 00
90: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:01:00.0 PCI bridge: Integrated Device Technology, Inc. [IDT] Device 8077 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=01, secondary=02, subordinate=09, sec-latency=0
	I/O behind bridge: 00000000-00001fff
	Memory behind bridge: 00000000-00bfffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Upstream Port, MSI 00
		DevCap:	MaxPayload 2048 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-SlotPowerLimit 0.000W
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x8, ASPM L0s L1, Latency L0 <4us, L1 <4us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x8, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [c0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] #00 [0000]
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [200 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=4
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=04 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
			Port Arbitration Table <?>
	Capabilities: [330 v1] #12
00: 1d 11 77 80 07 00 10 00 02 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 01 02 09 00 01 11 00 00
20: 00 00 b0 00 f1 ff 01 00 ff ff ff ff 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00
40: 10 c0 52 00 24 80 00 00 00 00 00 00 82 6c 01 00
50: 00 00 82 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 d0 03 c8 08 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 0d 00 00 00 00 00 00 00 00 00 00 00 1d 11 77 80

0000:02:00.0 PCI bridge: Integrated Device Technology, Inc. [IDT] Device 8077 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=02, secondary=03, subordinate=04, sec-latency=0
	I/O behind bridge: 00000000-00000fff
	Memory behind bridge: 00000000-008fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Downstream Port (Slot-), MSI 00
		DevCap:	MaxPayload 2048 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag+ RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #10, Speed 5GT/s, Width x4, ASPM L0s L1, Latency L0 <4us, L1 <4us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -3.5dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [c0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [200 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=4
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=04 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
			Port Arbitration Table <?>
	Capabilities: [320 v1] #00
	Capabilities: [330 v1] #12
00: 1d 11 77 80 07 00 10 00 02 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 02 03 04 00 01 01 00 00
20: 00 00 80 00 f1 ff 01 00 ff ff ff ff 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00
40: 10 c0 62 00 24 80 00 00 00 00 00 00 42 6c 39 0a
50: 00 00 11 20 00 00 00 00 00 00 40 00 00 00 00 00
60: 00 00 00 00 20 00 00 00 00 00 00 00 00 00 00 00
70: 42 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 d0 03 c8 08 00 00 00 00 00 00 00 00 00 00 00
d0: 05 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 0d 00 00 00 00 00 00 00 00 00 00 00 1d 11 77 80

0000:02:04.0 PCI bridge: Integrated Device Technology, Inc. [IDT] Device 8077 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=02, secondary=05, subordinate=05, sec-latency=0
	I/O behind bridge: 00001000-00001fff
	Memory behind bridge: 00900000-00afffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Downstream Port (Slot-), MSI 00
		DevCap:	MaxPayload 2048 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag+ RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #4, Speed 5GT/s, Width x4, ASPM L0s L1, Latency L0 <4us, L1 <4us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd+
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -3.5dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [c0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [200 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=4
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=04 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
			Port Arbitration Table <?>
	Capabilities: [320 v1] #00
	Capabilities: [330 v1] #12
00: 1d 11 77 80 07 00 10 00 02 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 02 05 05 00 11 11 00 00
20: 90 00 a0 00 f1 ff 01 00 ff ff ff ff 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00
40: 10 c0 62 00 24 80 00 00 00 00 00 00 42 6c 39 04
50: 00 00 41 20 00 00 00 00 00 00 40 00 00 00 00 00
60: 00 00 00 00 20 00 00 00 20 00 00 00 00 00 00 00
70: 42 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 d0 03 c8 08 00 00 00 00 00 00 00 00 00 00 00
d0: 05 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 0d 00 00 00 00 00 00 00 00 00 00 00 1d 11 77 80

0000:02:08.0 PCI bridge: Integrated Device Technology, Inc. [IDT] Device 8077 (rev 02) (prog-if 00 [Normal decode])
	Physical Slot: 8
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=02, secondary=06, subordinate=06, sec-latency=0
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 2048 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag+ RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #8, Speed 5GT/s, Width x8, ASPM L0s L1, Latency L0 <4us, L1 <4us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #6, PowerLimit 0.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -3.5dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [c0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [200 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=4
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=04 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
			Port Arbitration Table <?>
	Capabilities: [320 v1] #00
	Capabilities: [330 v1] #12
00: 1d 11 77 80 07 00 10 00 02 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 02 06 06 00 f1 01 00 00
20: f0 ff 00 00 f1 ff 01 00 ff ff ff ff 00 00 00 00
30: ff ff 00 00 40 00 00 00 00 00 00 00 00 00 00 00
40: 10 c0 62 01 24 80 00 00 00 00 00 00 82 6c 39 08
50: 00 00 01 00 00 00 30 00 00 00 40 00 00 00 00 00
60: 00 00 00 00 20 00 00 00 00 00 00 00 00 00 00 00
70: 42 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 d0 03 c8 08 00 00 00 00 00 00 00 00 00 00 00
d0: 05 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 0d 00 00 00 00 00 00 00 00 00 00 00 1d 11 77 80

0000:02:0b.0 PCI bridge: Integrated Device Technology, Inc. [IDT] Device 8077 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=02, secondary=07, subordinate=08, sec-latency=0
	Memory behind bridge: 00b00000-00bfffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Downstream Port (Slot-), MSI 00
		DevCap:	MaxPayload 2048 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag+ RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #11, Speed 5GT/s, Width x4, ASPM L0s L1, Latency L0 <4us, L1 <4us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -3.5dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [c0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [200 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=4
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=04 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
			Port Arbitration Table <?>
	Capabilities: [320 v1] #00
	Capabilities: [330 v1] #12
00: 1d 11 77 80 07 00 10 00 02 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 02 07 08 00 f1 01 00 00
20: b0 00 b0 00 f1 ff 01 00 ff ff ff ff 00 00 00 00
30: ff ff 00 00 40 00 00 00 00 00 00 00 00 00 00 00
40: 10 c0 62 00 24 80 00 00 00 00 00 00 42 6c 39 0b
50: 00 00 11 20 00 00 00 00 00 00 40 00 00 00 00 00
60: 00 00 00 00 20 00 00 00 00 00 00 00 00 00 00 00
70: 42 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 d0 03 c8 08 00 00 00 00 00 00 00 00 00 00 00
d0: 05 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 0d 00 00 00 00 00 00 00 00 00 00 00 1d 11 77 80

0000:02:0c.0 PCI bridge: Integrated Device Technology, Inc. [IDT] Device 8077 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=02, secondary=09, subordinate=09, sec-latency=0
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 2048 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag+ RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #12, Speed 5GT/s, Width x8, ASPM L0s L1, Latency L0 <4us, L1 <4us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #8, PowerLimit 0.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -3.5dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [c0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [200 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=4
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=04 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
			Port Arbitration Table <?>
	Capabilities: [320 v1] #00
	Capabilities: [330 v1] #12
00: 1d 11 77 80 07 00 10 00 02 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 02 09 09 00 f1 01 00 00
20: f0 ff 00 00 f1 ff 01 00 ff ff ff ff 00 00 00 00
30: ff ff 00 00 40 00 00 00 00 00 00 00 00 00 00 00
40: 10 c0 62 01 24 80 00 00 00 00 00 00 82 6c 39 0c
50: 00 00 01 00 00 00 40 00 00 00 40 00 00 00 00 00
60: 00 00 00 00 20 00 00 00 00 00 00 00 00 00 00 00
70: 42 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 d0 03 c8 08 00 00 00 00 00 00 00 00 00 00 00
d0: 05 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 0d 00 00 00 00 00 00 00 00 00 00 00 1d 11 77 80

0000:03:00.0 PCI bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=03, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 00000000-00000fff
	Memory behind bridge: 00000000-008fffff
	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] Express (v1) PCI/PCI-X Bridge, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ BrConfRtry-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <2us, L1 <2us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
	Capabilities: [a4] Subsystem: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
00: 03 1a 50 11 07 00 10 00 02 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 03 04 04 00 01 01 20 02
20: 00 00 80 00 f1 ff 01 00 ff ff ff ff 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 00 01 00 00
40: 00 00 00 00 60 61 82 01 00 00 00 00 00 00 00 00
50: 05 78 80 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 11 78 00 00 00 00 00 00
70: 01 00 00 00 00 00 00 00 01 80 c3 ff 08 00 00 00
80: 10 a4 71 00 00 80 00 00 10 28 10 00 11 dc 00 01
90: 00 00 11 10 00 00 00 00 c0 03 00 00 00 00 00 00
a0: 00 00 00 00 0d 00 00 00 03 1a 50 11 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:04:00.0 VGA compatible controller: ASPEED Technology, Inc. ASPEED Graphics Family (rev 10) (prog-if 00 [VGA controller])
	Subsystem: ASPEED Technology, Inc. ASPEED Graphics Family
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 00000004
	Region 0: Memory at <unassigned> (32-bit, non-prefetchable) [size=8M]
	Region 1: Memory at 00800000 (32-bit, non-prefetchable) [size=128K]
	Region 2: I/O ports at 00000000 [size=128]
	[virtual] Expansion ROM at 84000000000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
00: 03 1a 00 20 03 00 10 02 10 00 00 03 00 00 00 00
10: 00 00 00 00 00 00 80 00 01 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 03 1a 00 20
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 01 00 00
40: 01 00 c3 ff 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:05:00.0 Ethernet controller: Intel Corporation 82576 Gigabit Network Connection (rev 01)
	Subsystem: Oracle/SUN Device 4848
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 00000004
	Region 0: Memory at 00900000 (32-bit, non-prefetchable) [size=128K]
	Region 1: Memory at 00920000 (32-bit, non-prefetchable) [size=128K]
	Region 2: I/O ports at 00001000 [disabled] [size=32]
	Region 3: Memory at 00940000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at 00960000 [disabled] [size=128K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [70] MSI-X: Enable- Count=10 Masked-
		Vector table: BAR=3 offset=00000000
		PBA: BAR=3 offset=00002000
	Capabilities: [a0] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #4, Speed 2.5GT/s, Width x4, ASPM L0s L1, Latency L0 <4us, L1 <64us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 14, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [140 v1] Device Serial Number 00-21-28-ff-ff-f9-f6-4e
	Capabilities: [150 v1] Alternative Routing-ID Interpretation (ARI)
		ARICap:	MFVC- ACS-, Next Function: 1
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [160 v1] Single Root I/O Virtualization (SR-IOV)
		IOVCap:	Migration-, Interrupt Message Number: 000
		IOVCtl:	Enable- Migration- Interrupt- MSE- ARIHierarchy+
		IOVSta:	Migration-
		Initial VFs: 8, Total VFs: 8, Number of VFs: 8, Function Dependency Link: 00
		VF offset: 128, stride: 2, Device ID: 10ca
		Supported Page Size: 00000553, System Page Size: 00000002
		Region 0: Memory at 00980000 (32-bit, non-prefetchable)
		Region 3: Memory at 009a0000 (32-bit, non-prefetchable)
		VF Migration: offset: 00000000, BIR: 0
	Kernel driver in use: igb
00: 86 80 c9 10 46 01 10 00 01 00 00 02 10 00 80 00
10: 00 00 90 00 00 00 92 00 01 10 00 00 00 00 94 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 8e 10 48 48
30: 00 00 96 00 40 00 00 00 00 00 00 00 00 01 00 00
40: 01 50 23 c8 00 20 00 1a 00 00 00 00 00 00 00 00
50: 05 70 80 01 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 11 a0 09 00 03 00 00 00 03 20 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 10 00 02 00 c2 8c 00 10 10 28 19 00 41 6c 03 04
b0: 00 00 41 10 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 1f 00 00 00 05 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:05:00.1 Ethernet controller: Intel Corporation 82576 Gigabit Network Connection (rev 01)
	Subsystem: Oracle/SUN Device 4848
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 00000005
	Region 0: Memory at 009c0000 (32-bit, non-prefetchable) [size=128K]
	Region 1: Memory at 009e0000 (32-bit, non-prefetchable) [size=128K]
	Region 2: I/O ports at 00001020 [disabled] [size=32]
	Region 3: Memory at 00944000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at 00a00000 [disabled] [size=128K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [70] MSI-X: Enable- Count=10 Masked-
		Vector table: BAR=3 offset=00000000
		PBA: BAR=3 offset=00002000
	Capabilities: [a0] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #4, Speed 2.5GT/s, Width x4, ASPM L0s L1, Latency L0 <4us, L1 <64us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 14, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [140 v1] Device Serial Number 00-21-28-ff-ff-f9-f6-4e
	Capabilities: [150 v1] Alternative Routing-ID Interpretation (ARI)
		ARICap:	MFVC- ACS-, Next Function: 0
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [160 v1] Single Root I/O Virtualization (SR-IOV)
		IOVCap:	Migration-, Interrupt Message Number: 000
		IOVCtl:	Enable- Migration- Interrupt- MSE- ARIHierarchy-
		IOVSta:	Migration-
		Initial VFs: 8, Total VFs: 8, Number of VFs: 8, Function Dependency Link: 01
		VF offset: 128, stride: 2, Device ID: 10ca
		Supported Page Size: 00000553, System Page Size: 00000002
		Region 0: Memory at 00a20000 (32-bit, non-prefetchable)
		Region 3: Memory at 00a40000 (32-bit, non-prefetchable)
		VF Migration: offset: 00000000, BIR: 0
	Kernel driver in use: igb
00: 86 80 c9 10 46 01 10 00 01 00 00 02 10 00 80 00
10: 00 00 9c 00 00 00 9e 00 21 10 00 00 00 40 94 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 8e 10 48 48
30: 00 00 a0 00 40 00 00 00 00 00 00 00 00 02 00 00
40: 01 50 23 c8 00 20 00 1a 00 00 00 00 00 00 00 00
50: 05 70 80 01 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 11 a0 09 00 03 00 00 00 03 20 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 10 00 02 00 c2 8c 00 10 10 28 19 00 41 6c 03 04
b0: 00 00 41 10 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 1f 00 00 00 05 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:07:00.0 PCI bridge: PLX Technology, Inc. PEX8112 x1 Lane PCI Express-to-PCI Bridge (rev aa) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=07, secondary=08, subordinate=08, sec-latency=0
	Memory behind bridge: 00b00000-00bfffff
	Prefetchable memory behind bridge: 00000000-ffffffff
	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0+,D1+,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [60] Express (v1) PCI/PCI-X Bridge, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE- FLReset-
		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- BrConfRtry-
			MaxPayload 128 bytes, MaxReadReq 4096 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <1us, L1 <16us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
	Capabilities: [100 v1] Power Budgeting <?>
00: b5 10 12 81 07 00 10 00 aa 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 07 08 08 00 f0 00 20 02
20: b0 00 b0 00 00 00 f0 ff 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 01 00 00
40: 01 50 02 5a 00 00 00 00 11 20 0e 00 00 00 00 00
50: 05 60 80 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 71 00 20 00 00 00 07 50 00 00 11 4c 02 00
70: 00 00 11 00 80 0c 00 00 00 00 40 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 33 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:08:00.0 USB controller: NEC Corporation OHCI USB Controller (rev 43) (prog-if 10 [OHCI])
	Subsystem: NEC Corporation USB Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64 (250ns min, 10500ns max), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 00000006
	Region 0: Memory at 00b00000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: ohci-pci
00: 33 10 35 00 06 00 10 02 43 10 03 0c 10 40 80 00
10: 00 00 b0 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 33 10 35 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 01 01 2a
40: 01 00 02 7e 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 05 33 b0 6c 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:08:00.1 USB controller: NEC Corporation OHCI USB Controller (rev 43) (prog-if 10 [OHCI])
	Subsystem: NEC Corporation USB Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64 (250ns min, 10500ns max), Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 00000004
	Region 0: Memory at 00b02000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: ohci-pci
00: 33 10 35 00 06 00 10 02 43 10 03 0c 10 40 00 00
10: 00 20 b0 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 33 10 35 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 02 01 2a
40: 01 00 02 7e 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:08:00.2 USB controller: NEC Corporation uPD72010x USB 2.0 Controller (rev 04) (prog-if 20 [EHCI])
	Subsystem: NEC Corporation uPD72010x USB 2.0 Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64 (4000ns min, 8500ns max), Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 00000005
	Region 0: Memory at 00b04000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: ehci-pci
00: 33 10 e0 00 16 00 10 02 04 20 03 0c 10 40 00 00
10: 00 40 b0 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 33 10 e0 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 03 10 22
40: 01 00 02 7e 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 20 20 3f 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 05 33 b0 6c 00 00 00 00 01 00 00 00 00 00 00 c0
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:0a:00.0 PCI bridge: Integrated Device Technology, Inc. [IDT] Device 8077 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=0a, secondary=0b, subordinate=0f, sec-latency=0
	I/O behind bridge: 00002000-00003fff
	Memory behind bridge: 00c00000-00dfffff
	Prefetchable memory behind bridge: 0000004100000000-000000411fffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Upstream Port, MSI 00
		DevCap:	MaxPayload 2048 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-SlotPowerLimit 0.000W
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x8, ASPM L0s L1, Latency L0 <4us, L1 <4us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x8, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [c0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] #00 [0000]
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [200 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=4
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=04 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
			Port Arbitration Table <?>
	Capabilities: [330 v1] #12
00: 1d 11 77 80 07 00 10 00 02 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 0a 0b 0f 00 21 31 00 00
20: c0 00 d0 00 01 00 f1 1f 41 00 00 00 41 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00
40: 10 c0 52 00 24 80 00 00 00 00 00 00 82 6c 01 00
50: 00 00 82 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 d0 03 c8 08 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 0d 00 00 00 00 00 00 00 00 00 00 00 1d 11 77 80

0000:0b:00.0 PCI bridge: Integrated Device Technology, Inc. [IDT] Device 8077 (rev 02) (prog-if 00 [Normal decode])
	Physical Slot: 0
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=0b, secondary=0c, subordinate=0c, sec-latency=0
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 2048 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag+ RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #12, Speed 5GT/s, Width x4, ASPM L0s L1, Latency L0 <4us, L1 <4us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #4, PowerLimit 0.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -3.5dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [c0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [200 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=4
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=04 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
			Port Arbitration Table <?>
	Capabilities: [320 v1] #00
	Capabilities: [330 v1] #12
00: 1d 11 77 80 07 00 10 00 02 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 0b 0c 0c 00 f1 01 00 00
20: f0 ff 00 00 f1 ff 01 00 ff ff ff ff 00 00 00 00
30: ff ff 00 00 40 00 00 00 00 00 00 00 00 00 00 00
40: 10 c0 62 01 24 80 00 00 00 00 00 00 42 6c 39 0c
50: 00 00 01 00 00 00 20 00 00 00 40 00 00 00 00 00
60: 00 00 00 00 20 00 00 00 00 00 00 00 00 00 00 00
70: 42 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 d0 03 c8 08 00 00 00 00 00 00 00 00 00 00 00
d0: 05 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 0d 00 00 00 00 00 00 00 00 00 00 00 1d 11 77 80

0000:0b:04.0 PCI bridge: Integrated Device Technology, Inc. [IDT] Device 8077 (rev 02) (prog-if 00 [Normal decode])
	Physical Slot: 4
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=0b, secondary=0d, subordinate=0d, sec-latency=0
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 2048 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag+ RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #4, Speed 5GT/s, Width x8, ASPM L0s L1, Latency L0 <4us, L1 <4us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #2, PowerLimit 0.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -3.5dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [c0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [200 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=4
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=04 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
			Port Arbitration Table <?>
	Capabilities: [320 v1] #00
	Capabilities: [330 v1] #12
00: 1d 11 77 80 07 00 10 00 02 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 0b 0d 0d 00 f1 01 00 00
20: f0 ff 00 00 f1 ff 01 00 ff ff ff ff 00 00 00 00
30: ff ff 00 00 40 00 00 00 00 00 00 00 00 00 00 00
40: 10 c0 62 01 24 80 00 00 00 00 00 00 82 6c 39 04
50: 00 00 01 00 00 00 10 00 00 00 40 00 00 00 00 00
60: 00 00 00 00 20 00 00 00 00 00 00 00 00 00 00 00
70: 42 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 d0 03 c8 08 00 00 00 00 00 00 00 00 00 00 00
d0: 05 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 0d 00 00 00 00 00 00 00 00 00 00 00 1d 11 77 80

0000:0b:08.0 PCI bridge: Integrated Device Technology, Inc. [IDT] Device 8077 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=0b, secondary=0e, subordinate=0e, sec-latency=0
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: 00c00000-00cfffff
	Prefetchable memory behind bridge: 0000004100000000-000000410fffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 2048 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag+ RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #8, Speed 5GT/s, Width x8, ASPM L0s L1, Latency L0 <4us, L1 <4us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x8, TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState+
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -3.5dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [c0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [200 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=4
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=04 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
			Port Arbitration Table <?>
	Capabilities: [320 v1] #00
	Capabilities: [330 v1] #12
00: 1d 11 77 80 07 00 10 00 02 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 0b 0e 0e 00 21 21 00 00
20: c0 00 c0 00 01 00 f1 0f 41 00 00 00 41 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00
40: 10 c0 62 01 24 80 00 00 00 00 00 00 82 6c 39 08
50: 00 00 81 20 00 00 00 00 00 00 40 01 00 00 00 00
60: 00 00 00 00 20 00 00 00 00 00 00 00 00 00 00 00
70: 42 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 d0 03 c8 08 00 00 00 00 00 00 00 00 00 00 00
d0: 05 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 0d 00 00 00 00 00 00 00 00 00 00 00 1d 11 77 80

0000:0b:0e.0 PCI bridge: Integrated Device Technology, Inc. [IDT] Device 8077 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=0b, secondary=0f, subordinate=0f, sec-latency=0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: 00d00000-00dfffff
	Prefetchable memory behind bridge: 0000004110000000-000000411fffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Downstream Port (Slot-), MSI 00
		DevCap:	MaxPayload 2048 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag+ RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #14, Speed 5GT/s, Width x8, ASPM L0s L1, Latency L0 <4us, L1 <4us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x8, TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd+
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -3.5dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [c0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [200 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=4
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=04 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
			Port Arbitration Table <?>
	Capabilities: [320 v1] #00
	Capabilities: [330 v1] #12
00: 1d 11 77 80 07 00 10 00 02 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 0b 0f 0f 00 31 31 00 00
20: d0 00 d0 00 01 10 f1 1f 41 00 00 00 41 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00
40: 10 c0 62 00 24 80 00 00 00 00 00 00 82 6c 39 0e
50: 00 00 82 20 00 00 00 00 00 00 40 00 00 00 00 00
60: 00 00 00 00 20 00 00 00 20 00 00 00 00 00 00 00
70: 42 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 d0 03 c8 08 00 00 00 00 00 00 00 00 00 00 00
d0: 05 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 0d 00 00 00 00 00 00 00 00 00 00 00 1d 11 77 80

0000:0e:00.0 Fibre Channel: Emulex Corporation Saturn-X: LightPulse Fibre Channel Host Adapter (rev 03)
	Subsystem: Emulex Corporation Device fc42
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 00000005
	Region 0: Memory at 4100000000 (64-bit, non-prefetchable) [size=8K]
	Region 2: Memory at 4100004000 (64-bit, non-prefetchable) [size=16K]
	Region 4: I/O ports at 00002000 [disabled] [size=256]
	Expansion ROM at 00c00000 [disabled] [size=256K]
	Capabilities: [58] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] MSI: Enable- Count=1/16 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [78] MSI-X: Enable- Count=32 Masked-
		Vector table: BAR=2 offset=00002000
		PBA: BAR=2 offset=00003000
	Capabilities: [84] Vital Product Data
		Product Name: Sun StorageTek 8Gb FC PCIe HBA, dual port, Emulex
		Read-only fields:
			[PN] Part number: 371-4306-01
			[SN] Serial number: 0999VM0-12120020F1
			[V0] Vendor specific: VM21180036
			[EC] Engineering changes: R50
			[MN] Manufacture ID: 53 55 4e 20 4d 49 43 52 4f 53 59 53 54 45 4d 53 2c 20 49 4e 43 2e
			[V1] Vendor specific: Sun StorageTek LPe12002-S 8Gb 2-port PCIe FC HBA
			[V2] Vendor specific: LPe12002-S
			[V3] Vendor specific: T2:78,T3:7C,T7:73,TB:73,TFF:78
			[V4] Vendor specific: 0
			[RV] Reserved: checksum good, 16 byte(s) reserved
		End
	Capabilities: [94] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 2048 bytes, PhantFunc 0, Latency L0s <1us, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x8, ASPM L0s, Latency L0 <1us, L1 <64us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [12c v1] Power Budgeting <?>
	Kernel driver in use: lpfc
00: df 10 40 fc 46 00 10 00 03 00 04 0c 10 00 80 00
10: 04 00 00 00 41 00 00 00 04 40 00 00 41 00 00 00
20: 01 20 00 00 00 00 00 00 00 00 00 00 df 10 42 fc
30: 00 00 c0 00 58 00 00 00 00 00 00 00 ff 01 00 00
40: 08 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 01 60 03 00 00 00 00 00
60: 05 78 88 01 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 11 84 1f 00 02 20 00 00
80: 02 30 00 00 03 94 fc 80 00 00 00 78 00 00 00 00
90: 00 00 00 00 10 00 02 00 24 8f 00 00 10 28 09 00
a0: 82 44 03 00 00 00 81 10 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 1f 00 00 00 00 00 00 00
c0: 00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:0e:00.1 Fibre Channel: Emulex Corporation Saturn-X: LightPulse Fibre Channel Host Adapter (rev 03)
	Subsystem: Emulex Corporation Device fc42
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 00000007
	Region 0: Memory at 4100002000 (64-bit, non-prefetchable) [size=8K]
	Region 2: Memory at 4100008000 (64-bit, non-prefetchable) [size=16K]
	Region 4: I/O ports at 00002100 [disabled] [size=256]
	Expansion ROM at 00c40000 [disabled] [size=256K]
	Capabilities: [58] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] MSI: Enable- Count=1/16 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [78] MSI-X: Enable- Count=32 Masked-
		Vector table: BAR=2 offset=00002000
		PBA: BAR=2 offset=00003000
	Capabilities: [84] Vital Product Data
		Product Name: Sun StorageTek 8Gb FC PCIe HBA, dual port, Emulex
		Read-only fields:
			[PN] Part number: 371-4306-01
			[SN] Serial number: 0999VM0-12120020F1
			[V0] Vendor specific: VM21180036
			[EC] Engineering changes: R50
			[MN] Manufacture ID: 53 55 4e 20 4d 49 43 52 4f 53 59 53 54 45 4d 53 2c 20 49 4e 43 2e
			[V1] Vendor specific: Sun StorageTek LPe12002-S 8Gb 2-port PCIe FC HBA
			[V2] Vendor specific: LPe12002-S
			[V3] Vendor specific: T2:78,T3:7C,T7:73,TB:73,TFF:78
			[V4] Vendor specific: 1
			[RV] Reserved: checksum good, 16 byte(s) reserved
		End
	Capabilities: [94] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 2048 bytes, PhantFunc 0, Latency L0s <1us, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x8, ASPM L0s, Latency L0 <1us, L1 <64us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [12c v1] Power Budgeting <?>
	Kernel driver in use: lpfc
00: df 10 40 fc 46 00 10 00 03 00 04 0c 10 00 80 00
10: 04 20 00 00 41 00 00 00 04 80 00 00 41 00 00 00
20: 01 21 00 00 00 00 00 00 00 00 00 00 df 10 42 fc
30: 00 00 c4 00 58 00 00 00 00 00 00 00 ff 02 00 00
40: 08 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 01 60 03 00 00 00 00 00
60: 05 78 88 01 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 11 84 1f 00 02 20 00 00
80: 02 30 00 00 03 94 fc 80 00 00 00 78 00 00 00 00
90: 00 00 00 00 10 00 02 00 24 8f 00 00 10 28 09 00
a0: 82 44 03 00 00 00 81 10 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 1f 00 00 00 00 00 00 00
c0: 00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:0f:00.0 Serial Attached SCSI controller: LSI Logic / Symbios Logic SAS2008 PCI-Express Fusion-MPT SAS-2 [Falcon] (rev 03)
	Subsystem: LSI Logic / Symbios Logic SAS2008 PCI-Express Fusion-MPT SAS-2 [Falcon]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 512 bytes
	Interrupt: pin A routed to IRQ 00000006
	Region 0: I/O ports at 00003000 [disabled] [size=256]
	Region 1: Memory at 4110000000 (64-bit, non-prefetchable) [size=16K]
	Region 3: Memory at 4110040000 (64-bit, non-prefetchable) [size=256K]
	Expansion ROM at 00d00000 [disabled] [size=512K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [68] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 4096 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x8, ASPM L0s, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [d0] Vital Product Data
		Unknown small resource type 00, will not decode more.
	Capabilities: [a8] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [c0] MSI-X: Enable- Count=15 Masked-
		Vector table: BAR=1 offset=00002000
		PBA: BAR=1 offset=00003800
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [138 v1] Power Budgeting <?>
	Capabilities: [150 v1] Single Root I/O Virtualization (SR-IOV)
		IOVCap:	Migration-, Interrupt Message Number: 000
		IOVCtl:	Enable- Migration- Interrupt- MSE- ARIHierarchy+
		IOVSta:	Migration-
		Initial VFs: 16, Total VFs: 16, Number of VFs: 16, Function Dependency Link: 00
		VF offset: 1, stride: 1, Device ID: 0072
		Supported Page Size: 00000553, System Page Size: 00000002
		Region 0: Memory at 0000004110080000 (64-bit, non-prefetchable)
		Region 2: Memory at 00000041100c0000 (64-bit, non-prefetchable)
		VF Migration: offset: 00000000, BIR: 0
	Capabilities: [190 v1] Alternative Routing-ID Interpretation (ARI)
		ARICap:	MFVC- ACS-, Next Function: 0
		ARICtl:	MFVC- ACS-, Function Group: 0
	Kernel driver in use: mpt2sas
00: 00 10 72 00 06 00 10 00 03 00 07 01 80 00 00 00
10: 01 30 00 00 04 00 00 10 41 00 00 00 04 00 04 10
20: 41 00 00 00 00 00 00 00 00 00 00 00 00 10 72 00
30: 00 00 d0 00 50 00 00 00 00 00 00 00 00 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 68 03 06 08 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 0f 00 00 10 d0 02 00 25 80 00 10
70: 10 28 09 00 82 04 00 00 00 00 82 10 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 16 00 00 00
90: 00 00 00 00 00 00 00 00 02 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 05 c0 80 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 11 00 0e 00 01 20 00 00 01 38 00 00 00 00 00 00
d0: 03 a8 00 80 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0001:00:01.0 PCI bridge: Oracle/SUN Device 8186 (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=05, sec-latency=0
	I/O behind bridge: 00000000-00000fff
	Memory behind bridge: 00000000-001fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] Express (v2) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x8, ASPM unknown, Latency L0 <2us, L1 <4us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 05, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [138 v1] Vendor Specific Information: ID=1112 Rev=1 Len=014 <?>
	Capabilities: [14c v1] #00
00: 8e 10 86 81 07 00 10 00 01 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 05 00 01 01 00 00
20: 00 00 10 00 f1 ff 01 00 4d 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00
40: 01 60 03 c8 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 42 00 01 80 00 00 00 00 00 00 82 50 39 00
70: 00 00 82 70 00 00 00 00 00 00 00 01 00 00 00 00
80: 00 00 00 00 20 00 00 00 00 00 00 00 00 00 00 00
90: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0001:00:02.0 PCI bridge: Oracle/SUN Device 8186 (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Bus: primary=00, secondary=06, subordinate=0a, sec-latency=0
	I/O behind bridge: 00001000-00001fff
	Memory behind bridge: 00200000-002fffff
	Prefetchable memory behind bridge: 0000004100000000-000000410fffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] Express (v2) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #1, Speed 5GT/s, Width x8, ASPM unknown, Latency L0 <2us, L1 <4us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 05, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [138 v1] Vendor Specific Information: ID=1112 Rev=1 Len=014 <?>
	Capabilities: [14c v1] #00
00: 8e 10 86 81 07 00 10 00 01 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 06 0a 00 11 11 00 00
20: 20 00 20 00 01 00 f1 0f 41 00 00 00 41 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00
40: 01 60 03 c8 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 42 00 01 80 00 00 00 00 00 00 82 50 39 01
70: 00 00 82 70 00 00 00 00 00 00 00 01 00 00 00 00
80: 00 00 00 00 20 00 00 00 00 00 00 00 00 00 00 00
90: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0001:01:00.0 PCI bridge: Integrated Device Technology, Inc. [IDT] Device 8077 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=01, secondary=02, subordinate=05, sec-latency=0
	I/O behind bridge: 00000000-00000fff
	Memory behind bridge: 00000000-001fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Upstream Port, MSI 00
		DevCap:	MaxPayload 2048 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-SlotPowerLimit 0.000W
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #2, Speed 5GT/s, Width x8, ASPM L0s L1, Latency L0 <4us, L1 <4us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x8, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [c0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] #00 [0000]
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [200 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=4
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=04 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
			Port Arbitration Table <?>
	Capabilities: [330 v1] #12
00: 1d 11 77 80 07 00 10 00 02 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 01 02 05 00 01 01 00 00
20: 00 00 10 00 f1 ff 01 00 ff ff ff ff 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00
40: 10 c0 52 00 24 80 00 00 00 00 00 00 82 6c 01 02
50: 00 00 82 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 d0 03 c8 08 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 0d 00 00 00 00 00 00 00 00 00 00 00 1d 11 77 80

0001:02:00.0 PCI bridge: Integrated Device Technology, Inc. [IDT] Device 8077 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=02, secondary=03, subordinate=03, sec-latency=0
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 2048 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag+ RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #14, Speed 5GT/s, Width x8, ASPM L0s L1, Latency L0 <4us, L1 <4us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #9, PowerLimit 0.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -3.5dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [c0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [200 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=4
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=04 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
			Port Arbitration Table <?>
	Capabilities: [320 v1] #00
	Capabilities: [330 v1] #12
00: 1d 11 77 80 07 00 10 00 02 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 02 03 03 00 f1 01 00 00
20: f0 ff 00 00 f1 ff 01 00 ff ff ff ff 00 00 00 00
30: ff ff 00 00 40 00 00 00 00 00 00 00 00 00 00 00
40: 10 c0 62 01 24 80 00 00 00 00 00 00 82 6c 39 0e
50: 00 00 01 00 00 00 48 00 00 00 40 00 00 00 00 00
60: 00 00 00 00 20 00 00 00 00 00 00 00 00 00 00 00
70: 42 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 d0 03 c8 08 00 00 00 00 00 00 00 00 00 00 00
d0: 05 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 0d 00 00 00 00 00 00 00 00 00 00 00 1d 11 77 80

0001:02:05.0 PCI bridge: Integrated Device Technology, Inc. [IDT] Device 8077 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=02, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 00000000-00000fff
	Memory behind bridge: 00000000-001fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Downstream Port (Slot-), MSI 00
		DevCap:	MaxPayload 2048 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag+ RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #5, Speed 5GT/s, Width x4, ASPM L0s L1, Latency L0 <4us, L1 <4us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd+
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -3.5dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [c0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [200 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=4
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=04 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
			Port Arbitration Table <?>
	Capabilities: [320 v1] #00
	Capabilities: [330 v1] #12
00: 1d 11 77 80 07 00 10 00 02 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 02 04 04 00 01 01 00 00
20: 00 00 10 00 f1 ff 01 00 ff ff ff ff 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00
40: 10 c0 62 00 24 80 00 00 00 00 00 00 42 6c 39 05
50: 00 00 41 20 00 00 00 00 00 00 40 00 00 00 00 00
60: 00 00 00 00 20 00 00 00 20 00 00 00 00 00 00 00
70: 42 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 d0 03 c8 08 00 00 00 00 00 00 00 00 00 00 00
d0: 05 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 0d 00 00 00 00 00 00 00 00 00 00 00 1d 11 77 80

0001:02:06.0 PCI bridge: Integrated Device Technology, Inc. [IDT] Device 8077 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=02, secondary=05, subordinate=05, sec-latency=0
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 2048 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag+ RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #6, Speed 5GT/s, Width x8, ASPM L0s L1, Latency L0 <4us, L1 <4us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #7, PowerLimit 0.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -3.5dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [c0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [200 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=4
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=04 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
			Port Arbitration Table <?>
	Capabilities: [320 v1] #00
	Capabilities: [330 v1] #12
00: 1d 11 77 80 07 00 10 00 02 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 02 05 05 00 f1 01 00 00
20: f0 ff 00 00 f1 ff 01 00 ff ff ff ff 00 00 00 00
30: ff ff 00 00 40 00 00 00 00 00 00 00 00 00 00 00
40: 10 c0 62 01 24 80 00 00 00 00 00 00 82 6c 39 06
50: 00 00 01 00 00 00 38 00 00 00 40 00 00 00 00 00
60: 00 00 00 00 20 00 00 00 00 00 00 00 00 00 00 00
70: 42 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 d0 03 c8 08 00 00 00 00 00 00 00 00 00 00 00
d0: 05 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 0d 00 00 00 00 00 00 00 00 00 00 00 1d 11 77 80

0001:04:00.0 Ethernet controller: Intel Corporation 82576 Gigabit Network Connection (rev 01)
	Subsystem: Oracle/SUN Device 4848
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 0000000a
	Region 0: Memory at <unassigned> (32-bit, non-prefetchable) [size=128K]
	Region 1: Memory at 00020000 (32-bit, non-prefetchable) [size=128K]
	Region 2: I/O ports at <unassigned> [disabled] [size=32]
	Region 3: Memory at 00040000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at 00060000 [disabled] [size=128K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [70] MSI-X: Enable- Count=10 Masked-
		Vector table: BAR=3 offset=00000000
		PBA: BAR=3 offset=00002000
	Capabilities: [a0] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #5, Speed 2.5GT/s, Width x4, ASPM L0s L1, Latency L0 <4us, L1 <64us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 14, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [140 v1] Device Serial Number 00-21-28-ff-ff-f9-f6-50
	Capabilities: [150 v1] Alternative Routing-ID Interpretation (ARI)
		ARICap:	MFVC- ACS-, Next Function: 1
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [160 v1] Single Root I/O Virtualization (SR-IOV)
		IOVCap:	Migration-, Interrupt Message Number: 000
		IOVCtl:	Enable- Migration- Interrupt- MSE- ARIHierarchy+
		IOVSta:	Migration-
		Initial VFs: 8, Total VFs: 8, Number of VFs: 8, Function Dependency Link: 00
		VF offset: 128, stride: 2, Device ID: 10ca
		Supported Page Size: 00000553, System Page Size: 00000002
		Region 0: Memory at 00080000 (32-bit, non-prefetchable)
		Region 3: Memory at 000a0000 (32-bit, non-prefetchable)
		VF Migration: offset: 00000000, BIR: 0
	Kernel driver in use: igb
00: 86 80 c9 10 46 01 10 00 01 00 00 02 10 00 80 00
10: 00 00 00 00 00 00 02 00 01 00 00 00 00 00 04 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 8e 10 48 48
30: 00 00 06 00 40 00 00 00 00 00 00 00 00 01 00 00
40: 01 50 23 c8 00 20 00 1a 00 00 00 00 00 00 00 00
50: 05 70 80 01 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 11 a0 09 00 03 00 00 00 03 20 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 10 00 02 00 c2 8c 00 10 10 28 19 00 41 6c 03 05
b0: 00 00 41 10 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 1f 00 00 00 05 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0001:04:00.1 Ethernet controller: Intel Corporation 82576 Gigabit Network Connection (rev 01)
	Subsystem: Oracle/SUN Device 4848
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 0000000b
	Region 0: Memory at 000c0000 (32-bit, non-prefetchable) [size=128K]
	Region 1: Memory at 000e0000 (32-bit, non-prefetchable) [size=128K]
	Region 2: I/O ports at 00000020 [disabled] [size=32]
	Region 3: Memory at 00044000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at 00100000 [disabled] [size=128K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [70] MSI-X: Enable- Count=10 Masked-
		Vector table: BAR=3 offset=00000000
		PBA: BAR=3 offset=00002000
	Capabilities: [a0] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #5, Speed 2.5GT/s, Width x4, ASPM L0s L1, Latency L0 <4us, L1 <64us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 14, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [140 v1] Device Serial Number 00-21-28-ff-ff-f9-f6-50
	Capabilities: [150 v1] Alternative Routing-ID Interpretation (ARI)
		ARICap:	MFVC- ACS-, Next Function: 0
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [160 v1] Single Root I/O Virtualization (SR-IOV)
		IOVCap:	Migration-, Interrupt Message Number: 000
		IOVCtl:	Enable- Migration- Interrupt- MSE- ARIHierarchy-
		IOVSta:	Migration-
		Initial VFs: 8, Total VFs: 8, Number of VFs: 8, Function Dependency Link: 01
		VF offset: 128, stride: 2, Device ID: 10ca
		Supported Page Size: 00000553, System Page Size: 00000002
		Region 0: Memory at 00120000 (32-bit, non-prefetchable)
		Region 3: Memory at 00140000 (32-bit, non-prefetchable)
		VF Migration: offset: 00000000, BIR: 0
	Kernel driver in use: igb
00: 86 80 c9 10 46 01 10 00 01 00 00 02 10 00 80 00
10: 00 00 0c 00 00 00 0e 00 21 00 00 00 00 40 04 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 8e 10 48 48
30: 00 00 10 00 40 00 00 00 00 00 00 00 00 02 00 00
40: 01 50 23 c8 00 20 00 1a 00 00 00 00 00 00 00 00
50: 05 70 80 01 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 11 a0 09 00 03 00 00 00 03 20 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 10 00 02 00 c2 8c 00 10 10 28 19 00 41 6c 03 05
b0: 00 00 41 10 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 1f 00 00 00 05 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0001:06:00.0 PCI bridge: Integrated Device Technology, Inc. [IDT] Device 8077 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=06, secondary=07, subordinate=0a, sec-latency=0
	I/O behind bridge: 00001000-00001fff
	Memory behind bridge: 00200000-002fffff
	Prefetchable memory behind bridge: 0000004100000000-000000410fffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Upstream Port, MSI 00
		DevCap:	MaxPayload 2048 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-SlotPowerLimit 0.000W
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #2, Speed 5GT/s, Width x8, ASPM L0s L1, Latency L0 <4us, L1 <4us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x8, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [c0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] #00 [0000]
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [200 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=4
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=04 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
			Port Arbitration Table <?>
	Capabilities: [330 v1] #12
00: 1d 11 77 80 07 00 10 00 02 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 06 07 0a 00 11 11 00 00
20: 20 00 20 00 01 00 f1 0f 41 00 00 00 41 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00
40: 10 c0 52 00 24 80 00 00 00 00 00 00 82 6c 01 02
50: 00 00 82 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 d0 03 c8 08 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 0d 00 00 00 00 00 00 00 00 00 00 00 1d 11 77 80

0001:07:00.0 PCI bridge: Integrated Device Technology, Inc. [IDT] Device 8077 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=07, secondary=08, subordinate=08, sec-latency=0
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 2048 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag+ RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #13, Speed 5GT/s, Width x4, ASPM L0s L1, Latency L0 <4us, L1 <4us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #5, PowerLimit 0.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -3.5dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [c0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [200 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=4
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=04 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
			Port Arbitration Table <?>
	Capabilities: [320 v1] #00
	Capabilities: [330 v1] #12
00: 1d 11 77 80 07 00 10 00 02 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 07 08 08 00 f1 01 00 00
20: f0 ff 00 00 f1 ff 01 00 ff ff ff ff 00 00 00 00
30: ff ff 00 00 40 00 00 00 00 00 00 00 00 00 00 00
40: 10 c0 62 01 24 80 00 00 00 00 00 00 42 6c 39 0d
50: 00 00 01 00 00 00 28 00 00 00 40 00 00 00 00 00
60: 00 00 00 00 20 00 00 00 00 00 00 00 00 00 00 00
70: 42 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 d0 03 c8 08 00 00 00 00 00 00 00 00 00 00 00
d0: 05 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 0d 00 00 00 00 00 00 00 00 00 00 00 1d 11 77 80

0001:07:06.0 PCI bridge: Integrated Device Technology, Inc. [IDT] Device 8077 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=07, secondary=09, subordinate=09, sec-latency=0
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 2048 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag+ RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #6, Speed 5GT/s, Width x8, ASPM L0s L1, Latency L0 <4us, L1 <4us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #3, PowerLimit 0.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -3.5dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [c0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [200 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=4
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=04 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
			Port Arbitration Table <?>
	Capabilities: [320 v1] #00
	Capabilities: [330 v1] #12
00: 1d 11 77 80 07 00 10 00 02 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 07 09 09 00 f1 01 00 00
20: f0 ff 00 00 f1 ff 01 00 ff ff ff ff 00 00 00 00
30: ff ff 00 00 40 00 00 00 00 00 00 00 00 00 00 00
40: 10 c0 62 01 24 80 00 00 00 00 00 00 82 6c 39 06
50: 00 00 01 00 00 00 18 00 00 00 40 00 00 00 00 00
60: 00 00 00 00 20 00 00 00 00 00 00 00 00 00 00 00
70: 42 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 d0 03 c8 08 00 00 00 00 00 00 00 00 00 00 00
d0: 05 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 0d 00 00 00 00 00 00 00 00 00 00 00 1d 11 77 80

0001:07:0a.0 PCI bridge: Integrated Device Technology, Inc. [IDT] Device 8077 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=07, secondary=0a, subordinate=0a, sec-latency=0
	I/O behind bridge: 00001000-00001fff
	Memory behind bridge: 00200000-002fffff
	Prefetchable memory behind bridge: 0000004100000000-000000410fffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 2048 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag+ RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #10, Speed 5GT/s, Width x8, ASPM L0s L1, Latency L0 <4us, L1 <4us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x8, TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #1, PowerLimit 0.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState+
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd+
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -3.5dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [c0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [200 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=4
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=04 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
			Port Arbitration Table <?>
	Capabilities: [320 v1] #00
	Capabilities: [330 v1] #12
00: 1d 11 77 80 07 00 10 00 02 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 07 0a 0a 00 11 11 00 00
20: 20 00 20 00 01 00 f1 0f 41 00 00 00 41 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00
40: 10 c0 62 01 24 80 00 00 00 00 00 00 82 6c 39 0a
50: 00 00 82 20 00 00 08 00 00 00 40 01 00 00 00 00
60: 00 00 00 00 20 00 00 00 20 00 00 00 00 00 00 00
70: 42 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 d0 03 c8 08 00 00 00 00 00 00 00 00 00 00 00
d0: 05 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 0d 00 00 00 00 00 00 00 00 00 00 00 1d 11 77 80

0001:0a:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection (rev 01)
	Subsystem: Oracle/SUN Ethernet Server Adapter X520-2
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 0000000c
	Region 0: Memory at 4100000000 (64-bit, non-prefetchable) [size=512K]
	Region 2: I/O ports at 00001000 [disabled] [size=32]
	Region 4: Memory at 4100080000 (64-bit, non-prefetchable) [size=16K]
	Expansion ROM at 00200000 [disabled] [size=512K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [70] MSI-X: Enable- Count=64 Masked-
		Vector table: BAR=4 offset=00000000
		PBA: BAR=4 offset=00002000
	Capabilities: [a0] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #10, Speed 5GT/s, Width x8, ASPM L0s, Latency L0 unlimited, L1 <32us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [140 v1] Device Serial Number 90-e2-ba-ff-ff-14-31-88
	Capabilities: [150 v1] Alternative Routing-ID Interpretation (ARI)
		ARICap:	MFVC- ACS-, Next Function: 1
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [160 v1] Single Root I/O Virtualization (SR-IOV)
		IOVCap:	Migration-, Interrupt Message Number: 000
		IOVCtl:	Enable- Migration- Interrupt- MSE- ARIHierarchy+
		IOVSta:	Migration-
		Initial VFs: 64, Total VFs: 64, Number of VFs: 64, Function Dependency Link: 00
		VF offset: 128, stride: 2, Device ID: 10ed
		Supported Page Size: 00000553, System Page Size: 00000002
		Region 0: Memory at 0000004100084000 (64-bit, non-prefetchable)
		Region 3: Memory at 0000004100184000 (64-bit, non-prefetchable)
		VF Migration: offset: 00000000, BIR: 0
	Kernel driver in use: ixgbe
00: 86 80 fb 10 46 01 10 00 01 00 00 02 10 00 80 00
10: 04 00 00 00 41 00 00 00 01 10 00 00 00 00 00 00
20: 04 00 08 00 41 00 00 00 00 00 00 00 8e 10 11 7b
30: 00 00 20 00 40 00 00 00 00 00 00 00 00 01 00 00
40: 01 50 23 48 00 20 00 36 00 00 00 00 00 00 00 00
50: 05 70 80 01 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 11 a0 3f 00 04 00 00 00 04 20 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 10 00 02 00 c2 8c 00 10 10 28 09 00 82 f4 02 0a
b0: 00 00 82 10 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 1f 00 00 00 00 00 00 00 00 00 00 00
d0: 02 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0001:0a:00.1 Ethernet controller: Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection (rev 01)
	Subsystem: Oracle/SUN Ethernet Server Adapter X520-2
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 0000000d
	Region 0: Memory at 4100300000 (64-bit, non-prefetchable) [size=512K]
	Region 2: I/O ports at 00001020 [disabled] [size=32]
	Region 4: Memory at 4100284000 (64-bit, non-prefetchable) [size=16K]
	Expansion ROM at 00280000 [disabled] [size=512K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [70] MSI-X: Enable- Count=64 Masked-
		Vector table: BAR=4 offset=00000000
		PBA: BAR=4 offset=00002000
	Capabilities: [a0] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #10, Speed 5GT/s, Width x8, ASPM L0s, Latency L0 unlimited, L1 <32us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [140 v1] Device Serial Number 90-e2-ba-ff-ff-14-31-88
	Capabilities: [150 v1] Alternative Routing-ID Interpretation (ARI)
		ARICap:	MFVC- ACS-, Next Function: 0
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [160 v1] Single Root I/O Virtualization (SR-IOV)
		IOVCap:	Migration-, Interrupt Message Number: 000
		IOVCtl:	Enable- Migration- Interrupt- MSE- ARIHierarchy-
		IOVSta:	Migration-
		Initial VFs: 64, Total VFs: 64, Number of VFs: 64, Function Dependency Link: 01
		VF offset: 128, stride: 2, Device ID: 10ed
		Supported Page Size: 00000553, System Page Size: 00000002
		Region 0: Memory at 0000004100380000 (64-bit, non-prefetchable)
		Region 3: Memory at 0000004100480000 (64-bit, non-prefetchable)
		VF Migration: offset: 00000000, BIR: 0
	Kernel driver in use: ixgbe
00: 86 80 fb 10 46 01 10 00 01 00 00 02 10 00 80 00
10: 04 00 30 00 41 00 00 00 21 10 00 00 00 00 00 00
20: 04 40 28 00 41 00 00 00 00 00 00 00 8e 10 11 7b
30: 00 00 28 00 40 00 00 00 00 00 00 00 00 02 00 00
40: 01 50 23 48 00 20 00 36 00 00 00 00 00 00 00 00
50: 05 70 80 01 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 11 a0 3f 00 04 00 00 00 04 20 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 10 00 02 00 c2 8c 00 10 10 28 09 00 82 f4 02 0a
b0: 00 00 82 10 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 1f 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


--------------080108050108070509050208--
