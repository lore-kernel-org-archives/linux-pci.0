Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0104.outbound.protection.outlook.com ([65.55.169.104]:31472
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S934313AbbEOUEc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 15 May 2015 16:04:32 -0400
Date: Fri, 15 May 2015 13:04:22 -0700
From: Guenter Roeck <groeck@juniper.net>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: BAR 7 io space assignment errors
Message-ID: <20150515200422.GA29321@svl-evodev-groeck.juniper.net>
References: <20150515172836.GA27797@svl-evodev-groeck.juniper.net>
 <CAErSpo5R0WF7J1OCagXNB2PcFUnNDB3LD6Q8A3pi=YYswzsaLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CAErSpo5R0WF7J1OCagXNB2PcFUnNDB3LD6Q8A3pi=YYswzsaLw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Fri, May 15, 2015 at 02:25:34PM -0500, Bjorn Helgaas wrote:
> [+cc Yinghai]
> 
> Hi Guenter,
> 
> On Fri, May 15, 2015 at 12:28 PM, Guenter Roeck <groeck@juniper.net> wrote:
> > Hi all,
> >
> > ever since 3.18(ish), we see lots of pcie io range allocation error messages
> > when booting our systems.
> >
> > pcieport 0000:02:00.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
> > pcieport 0000:02:00.0: BAR 7: no space for [io  size 0x1000]
> > pcieport 0000:02:00.0: BAR 7: failed to assign [io  size 0x1000]
> >
> > This is repeated for each port.
> >
> > What we atually _want_ is no IO address range, but so far I have not been able to
> > tell this to the code (or to the bridge).
> 
> What information does the core have that we could use to figure out
> that you want no I/O space?  For example, does the host bridge have no
> I/O apertures?  Or are there no devices below 02:00.0 that require I/O
> space?  If you can post a complete dmesg log, that should contain this
> information.
> 
We know that we don't need IO space behind the bridge.

Question would be what information the core would need. I have tried
to pre-program PCI_IO_BASE and PCI_IO_LIMIT on the bridge ports,
but that doesn't seem to be the right solution (and it was just a
wild shot anyway ;-).

> Is the problem that some device doesn't work, or is it just extra
> annoying messages.  We should fix something in either case, of course,
> but it's more urgent if a device used to work but no longer does.
> 
Just the extra annoying messages. The messages below are just the beginning;
there are many more when the actual devices behind the bridge ports come
online.

Thanks,
Guenter

---

dmesg log:

Dec 31 16:00:35 fpc0 kernel: Using P2020 PTXPMB machine description
Dec 31 16:00:35 fpc0 kernel: Memory CAM mapping: 256/256/256 Mb, residual: 3328Mb
Dec 31 16:00:35 fpc0 kernel: Initializing cgroup subsys cpuset
Dec 31 16:00:35 fpc0 kernel: Initializing cgroup subsys cpu
Dec 31 16:00:35 fpc0 kernel: Initializing cgroup subsys cpuacct
Dec 31 16:00:35 fpc0 kernel: Linux version 4.0.2-juniper-00581-ge031ee2-dirty (groeck@svl-evodev-groeck) (gcc version 4.8.2 (GCC) ) #1 SMP PREEMPT Thu May 14 23:53:42 PDT 2015
Dec 31 16:00:35 fpc0 kernel: Found initrd at 0xdce1a000:0xeffff8b0
Dec 31 16:00:35 fpc0 kernel: Found legacy serial port 0 for /soc/uart0
Dec 31 16:00:35 fpc0 kernel:   mem=fff704500, taddr=fff704500, irq=0, clk=400000002, speed=0
Dec 31 16:00:35 fpc0 kernel: Found legacy serial port 1 for /soc/uart1
Dec 31 16:00:35 fpc0 kernel:   mem=fff704600, taddr=fff704600, irq=0, clk=400000002, speed=0
Dec 31 16:00:35 fpc0 kernel: CPU maps initialized for 1 thread per core
Dec 31 16:00:35 fpc0 kernel:  (thread shift is 0)
Dec 31 16:00:35 fpc0 kernel: bootconsole [udbg0] enabled
Dec 31 16:00:35 fpc0 kernel: CPLD at 0xfff000000 size 0x10000
Dec 31 16:00:35 fpc0 kernel: P2020 PTX PMB board from Juniper Networks
Dec 31 16:00:35 fpc0 kernel: Top of RAM: 0x100000000, Total RAM: 0x100000000
Dec 31 16:00:35 fpc0 kernel: Memory hole size: 0MB
Dec 31 16:00:35 fpc0 kernel: Zone ranges:
Dec 31 16:00:35 fpc0 kernel:   DMA      [mem 0x0000000000000000-0x000000002fffffff]
Dec 31 16:00:35 fpc0 kernel:   Normal   empty
Dec 31 16:00:35 fpc0 kernel:   HighMem  [mem 0x0000000030000000-0x00000000ffffffff]
Dec 31 16:00:35 fpc0 kernel: Movable zone start for each node
Dec 31 16:00:35 fpc0 kernel: Early memory node ranges
Dec 31 16:00:35 fpc0 kernel:   node   0: [mem 0x0000000000000000-0x00000000ffffffff]
Dec 31 16:00:35 fpc0 kernel: Initmem setup node 0 [mem 0x0000000000000000-0x00000000ffffffff]
Dec 31 16:00:35 fpc0 kernel: On node 0 totalpages: 1048576
Dec 31 16:00:35 fpc0 kernel: free_area_init_node: node 0, pgdat c06bc820, node_mem_map dadec000
Dec 31 16:00:35 fpc0 kernel:   DMA zone: 1536 pages used for memmap
Dec 31 16:00:35 fpc0 kernel:   DMA zone: 0 pages reserved
Dec 31 16:00:35 fpc0 kernel:   DMA zone: 196608 pages, LIFO batch:31
Dec 31 16:00:35 fpc0 kernel:   HighMem zone: 851968 pages, LIFO batch:31
Dec 31 16:00:35 fpc0 kernel: MMU: Allocated 1088 bytes of context maps for 255 contexts
Dec 31 16:00:35 fpc0 kernel: PERCPU: Embedded 10 pages/cpu @dadc1000 s10896 r8192 d21872 u40960
Dec 31 16:00:35 fpc0 kernel: pcpu-alloc: s10896 r8192 d21872 u40960 alloc=10*4096
Dec 31 16:00:35 fpc0 kernel: pcpu-alloc: [0] 0 [0] 1 
Dec 31 16:00:35 fpc0 kernel: Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1047040
Dec 31 16:00:35 fpc0 kernel: Kernel command line: root=/dev/ram rw ramdisk_size=10000000 raid=noautodetect console=ttyS0,9600 cache-sram-size=0x10000 ip=128.0.0.16:128.0.0.4:128.0.0.4:192.0.0.0:fpc0:eth0:off
Dec 31 16:00:35 fpc0 kernel: PID hash table entries: 4096 (order: 2, 16384 bytes)
Dec 31 16:00:35 fpc0 kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Dec 31 16:00:35 fpc0 kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Dec 31 16:00:35 fpc0 kernel: Sorting __ex_table...
Dec 31 16:00:35 fpc0 kernel: Memory: 3773792K/4194304K available (5292K kernel code, 272K rwdata, 1108K rodata, 276K init, 418K bss, 420512K reserved, 0K cma-reserved, 3407868K highmem)
Dec 31 16:00:35 fpc0 kernel: Kernel virtual memory layout:
Dec 31 16:00:35 fpc0 kernel:   * 0xfffbf000..0xfffff000  : fixmap
Dec 31 16:00:35 fpc0 kernel:   * 0xffc00000..0xffe00000  : highmem PTEs
Dec 31 16:00:35 fpc0 kernel:   * 0xffbed000..0xffc00000  : early ioremap
Dec 31 16:00:35 fpc0 kernel:   * 0xf1000000..0xffbed000  : vmalloc & ioremap
Dec 31 16:00:35 fpc0 kernel: SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
Dec 31 16:00:35 fpc0 kernel: Preemptible hierarchical RCU implementation.
Dec 31 16:00:35 fpc0 kernel:         Additional per-CPU info printed with stalls.
Dec 31 16:00:35 fpc0 kernel: NR_IRQS:512 nr_irqs:512 16
Dec 31 16:00:35 fpc0 kernel: mpic: Setting up MPIC " OpenPIC  " version 1.2 at fff740000, max 2 CPUs
Dec 31 16:00:35 fpc0 kernel: mpic: ISU size: 256, shift: 8, mask: ff
Dec 31 16:00:35 fpc0 kernel: mpic: Initializing for 256 sources
Dec 31 16:00:35 fpc0 kernel: time_init: decrementer frequency = 50.000000 MHz
Dec 31 16:00:35 fpc0 kernel: time_init: processor frequency   = 1200.000006 MHz
Dec 31 16:00:35 fpc0 kernel: clocksource: timebase mult[14000000] shift[24] registered
Dec 31 16:00:35 fpc0 kernel: clockevent: decrementer mult[ccccccd] shift[32] cpu[0]
Dec 31 16:00:35 fpc0 kernel: Console: colour dummy device 80x25
Dec 31 16:00:35 fpc0 kernel: kmemleak: Kernel memory leak detector disabled
Dec 31 16:00:35 fpc0 kernel: kmemleak: Early log buffer exceeded (746), please increase DEBUG_KMEMLEAK_EARLY_LOG_SIZE
Dec 31 16:00:35 fpc0 kernel: pid_max: default: 32768 minimum: 301
Dec 31 16:00:35 fpc0 kernel: Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
Dec 31 16:00:35 fpc0 kernel: Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
Dec 31 16:00:35 fpc0 kernel: Initializing cgroup subsys blkio
Dec 31 16:00:35 fpc0 kernel: Initializing cgroup subsys devices
Dec 31 16:00:35 fpc0 kernel: Initializing cgroup subsys freezer
Dec 31 16:00:35 fpc0 kernel: Initializing cgroup subsys debug
Dec 31 16:00:35 fpc0 kernel: mpic: requesting IPIs...
Dec 31 16:00:35 fpc0 kernel: Brought up 2 CPUs
Dec 31 16:00:35 fpc0 kernel: devtmpfs: initialized
Dec 31 16:00:35 fpc0 kernel: NET: Registered protocol family 16
Dec 31 16:00:35 fpc0 kernel: Found FSL PCI host bridge at 0x0000000fff70a000. Firmware bus number: 0->0
Dec 31 16:00:35 fpc0 kernel: PCI host bridge /pcie@a000 (primary) ranges:
Dec 31 16:00:35 fpc0 kernel:  MEM 0x0000000c00000000..0x0000000c3fffffff -> 0x0000000080000000 
Dec 31 16:00:35 fpc0 kernel:   IO 0x0000000fffc00000..0x0000000fffc0ffff -> 0x0000000000000000
Dec 31 16:00:35 fpc0 kernel: /pcie@a000: PCICSRBAR @ 0xfff00000
Dec 31 16:00:35 fpc0 kernel: /pcie@a000: Setup 64-bit PCI DMA window
Dec 31 16:00:35 fpc0 kernel: /pcie@a000: WARNING: Outbound window cfg leaves gaps in memory map. Adjusting the memory map could reduce unnecessary bounce buffering.
Dec 31 16:00:35 fpc0 kernel: /pcie@a000: DMA window size is 0x80000000
Dec 31 16:00:35 fpc0 kernel: software IO TLB [mem 0x16cfd000-0x1acfd000] (64MB) mapped at [d6cfd000-dacfcfff]
Dec 31 16:00:35 fpc0 kernel: PCI: Probing PCI hardware
Dec 31 16:00:35 fpc0 kernel: fsl-pci fff70a000.pcie: PCI host bridge to bus 0000:00
Dec 31 16:00:35 fpc0 kernel: pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
Dec 31 16:00:35 fpc0 kernel: pci_bus 0000:00: root bus resource [mem 0xc00000000-0xc3fffffff] (bus address [0x80000000-0xbfffffff])
Dec 31 16:00:35 fpc0 kernel: pci_bus 0000:00: root bus resource [bus 00-ff]
Dec 31 16:00:35 fpc0 kernel: pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to ff
Dec 31 16:00:35 fpc0 kernel: pci 0000:00:00.0: [1957:0071] type 01 class 0x0b2000
Dec 31 16:00:35 fpc0 kernel: pci 0000:00:00.0: reg 0x10: [mem 0xfff00000-0xffffffff]
Dec 31 16:00:35 fpc0 kernel: pci 0000:00:00.0: supports D1 D2
Dec 31 16:00:35 fpc0 kernel: pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
Dec 31 16:00:35 fpc0 kernel: pci 0000:01:00.0: [111d:807a] type 01 class 0x060400
Dec 31 16:00:35 fpc0 kernel: pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
Dec 31 16:00:35 fpc0 kernel: pci 0000:00:00.0: PCI bridge to [bus 01-ff]
Dec 31 16:00:35 fpc0 kernel: pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
Dec 31 16:00:35 fpc0 kernel: pci 0000:00:00.0:   bridge window [mem 0xc00000000-0xc3fffffff]
Dec 31 16:00:35 fpc0 kernel: pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:00.0: [111d:807a] type 01 class 0x060400
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:01.0: [111d:807a] type 01 class 0x060400
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:01.0: PME# supported from D0 D3hot D3cold
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:02.0: [111d:807a] type 01 class 0x060400
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:02.0: PME# supported from D0 D3hot D3cold
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:03.0: [111d:807a] type 01 class 0x060400
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:03.0: PME# supported from D0 D3hot D3cold
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:04.0: [111d:807a] type 01 class 0x060400
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:04.0: PME# supported from D0 D3hot D3cold
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:06.0: [111d:807a] type 01 class 0x060400
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:06.0: PME# supported from D0 D3hot D3cold
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:07.0: [111d:807a] type 01 class 0x060400
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:07.0: PME# supported from D0 D3hot D3cold
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:08.0: [111d:807a] type 01 class 0x060400
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:08.0: PME# supported from D0 D3hot D3cold
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:09.0: [111d:807a] type 01 class 0x060400
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:09.0: PME# supported from D0 D3hot D3cold
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:0c.0: [111d:807a] type 01 class 0x060400
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:0c.0: PME# supported from D0 D3hot D3cold
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:0d.0: [111d:807a] type 01 class 0x060400
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:0d.0: PME# supported from D0 D3hot D3cold
Dec 31 16:00:35 fpc0 kernel: pci 0000:01:00.0: PCI bridge to [bus 02-ff]
Dec 31 16:00:35 fpc0 kernel: pci 0000:01:00.0:   bridge window [mem 0xc00000000-0xc2fffffff]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:00.0: PCI bridge to [bus 40-4f]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:00.0:   bridge window [mem 0xc04000000-0xc07ffffff]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:01.0: PCI bridge to [bus 90-9f]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:01.0:   bridge window [mem 0xc08000000-0xc0bffffff]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:02.0: PCI bridge to [bus 80-8f]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:02.0:   bridge window [mem 0xc00000000-0xc03ffffff]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:03.0: PCI bridge to [bus 50-5f]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:03.0:   bridge window [mem 0xc0c000000-0xc0fffffff]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:04.0: PCI bridge to [bus 30-3f]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:04.0:   bridge window [mem 0xc28000000-0xc2bffffff]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:06.0: PCI bridge to [bus 70-7f]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:06.0:   bridge window [mem 0xc1c000000-0xc1fffffff]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:07.0: PCI bridge to [bus 60-6f]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:07.0:   bridge window [mem 0xc14000000-0xc17ffffff]
Dec 31 16:00:35 fpc0 kernel: pci 0000:20:00.0: [1304:0004] type 00 class 0xff0000
Dec 31 16:00:35 fpc0 kernel: pci 0000:20:00.0: reg 0x10: [mem 0x00000000-0x03ffffff]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:08.0: PCI bridge to [bus 20-2f]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:08.0:   bridge window [mem 0xc20000000-0xc23ffffff]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:09.0: PCI bridge to [bus 10-1f]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:09.0:   bridge window [mem 0xc24000000-0xc27ffffff]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:0c.0: PCI bridge to [bus b0-bf]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:0c.0:   bridge window [mem 0xc18000000-0xc1bffffff]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:0d.0: PCI bridge to [bus a0-af]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:0d.0:   bridge window [mem 0xc10000000-0xc13ffffff]
Dec 31 16:00:35 fpc0 kernel: pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to ff
Dec 31 16:00:35 fpc0 kernel: PCI: Cannot allocate resource region 0 of PCI bridge 1, will remap
Dec 31 16:00:35 fpc0 kernel: PCI: Cannot allocate resource region 0 of device 0000:00:00.0, will remap
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:00.0: bridge window [io  0x1000-0x0fff] to [bus 40-4f] add_size 1000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:00.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 40-4f] add_size 200000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 90-9f] add_size 1000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:01.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 90-9f] add_size 200000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 80-8f] add_size 1000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 80-8f] add_size 200000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:03.0: bridge window [io  0x1000-0x0fff] to [bus 50-5f] add_size 1000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:03.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 50-5f] add_size 200000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:04.0: bridge window [io  0x1000-0x0fff] to [bus 30-3f] add_size 1000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:04.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 30-3f] add_size 200000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:06.0: bridge window [io  0x1000-0x0fff] to [bus 70-7f] add_size 1000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:06.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 70-7f] add_size 200000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:07.0: bridge window [io  0x1000-0x0fff] to [bus 60-6f] add_size 1000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:07.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 60-6f] add_size 200000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:08.0: bridge window [io  0x1000-0x0fff] to [bus 20-2f] add_size 1000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:08.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 20-2f] add_size 200000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:09.0: bridge window [io  0x1000-0x0fff] to [bus 10-1f] add_size 1000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:09.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 10-1f] add_size 200000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:0c.0: bridge window [io  0x1000-0x0fff] to [bus b0-bf] add_size 1000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:0c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus b0-bf] add_size 200000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:0d.0: bridge window [io  0x1000-0x0fff] to [bus a0-af] add_size 1000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:0d.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus a0-af] add_size 200000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:00.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:01.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:02.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:03.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:04.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:06.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:07.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:08.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:09.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:0c.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:0d.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
Dec 31 16:00:35 fpc0 kernel: pci 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-ff] add_size b000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:00.0: res[9]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 200000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:01.0: res[9]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 200000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:02.0: res[9]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 200000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:03.0: res[9]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 200000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:04.0: res[9]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 200000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:06.0: res[9]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 200000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:07.0: res[9]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 200000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:08.0: res[9]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 200000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:09.0: res[9]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 200000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:0c.0: res[9]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 200000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:0d.0: res[9]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 200000
Dec 31 16:00:35 fpc0 kernel: pci 0000:01:00.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 02-ff] add_size 1600000
Dec 31 16:00:35 fpc0 kernel: pci 0000:01:00.0: res[9]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 1600000
Dec 31 16:00:35 fpc0 kernel: pci 0000:00:00.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 01-ff] add_size 1600000
Dec 31 16:00:35 fpc0 kernel: pci 0000:00:00.0: res[9]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 1600000
Dec 31 16:00:35 fpc0 kernel: pci 0000:00:00.0: BAR 0: no space for [mem size 0x00100000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:00:00.0: BAR 0: failed to assign [mem size 0x00100000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:00:00.0: BAR 9: no space for [mem size 0x01600000 64bit pref]
Dec 31 16:00:35 fpc0 kernel: pci 0000:00:00.0: BAR 9: failed to assign [mem size 0x01600000 64bit pref]
Dec 31 16:00:35 fpc0 kernel: pci 0000:00:00.0: BAR 0: no space for [mem size 0x00100000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:00:00.0: BAR 0: failed to assign [mem size 0x00100000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:00:00.0: BAR 9: no space for [mem size 0x01600000 64bit pref]
Dec 31 16:00:35 fpc0 kernel: pci 0000:00:00.0: BAR 9: failed to assign [mem size 0x01600000 64bit pref]
Dec 31 16:00:35 fpc0 kernel: pci 0000:01:00.0: res[9]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 1600000
Dec 31 16:00:35 fpc0 kernel: pci 0000:01:00.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size b000
Dec 31 16:00:35 fpc0 kernel: pci 0000:01:00.0: BAR 9: assigned [mem 0xc30000000-0xc315fffff 64bit pref]
Dec 31 16:00:35 fpc0 kernel: pci 0000:01:00.0: BAR 7: no space for [io  size 0xb000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:01:00.0: BAR 7: failed to assign [io  size 0xb000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:01:00.0: BAR 7: no space for [io  size 0xb000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:01:00.0: BAR 7: failed to assign [io  size 0xb000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:00.0: res[9]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 200000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:01.0: res[9]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 200000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:02.0: res[9]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 200000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:03.0: res[9]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 200000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:04.0: res[9]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 200000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:06.0: res[9]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 200000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:07.0: res[9]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 200000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:08.0: res[9]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 200000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:09.0: res[9]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 200000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:0c.0: res[9]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 200000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:0d.0: res[9]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 200000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:00.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:01.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:02.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:03.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:04.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:06.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:07.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:08.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:09.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:0c.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:0d.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:00.0: BAR 9: assigned [mem 0xc30000000-0xc301fffff 64bit pref]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:01.0: BAR 9: assigned [mem 0xc30200000-0xc303fffff 64bit pref]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:02.0: BAR 9: assigned [mem 0xc30400000-0xc305fffff 64bit pref]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:03.0: BAR 9: assigned [mem 0xc30600000-0xc307fffff 64bit pref]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:04.0: BAR 9: assigned [mem 0xc30800000-0xc309fffff 64bit pref]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:06.0: BAR 9: assigned [mem 0xc30a00000-0xc30bfffff 64bit pref]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:07.0: BAR 9: assigned [mem 0xc30c00000-0xc30dfffff 64bit pref]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:08.0: BAR 9: assigned [mem 0xc30e00000-0xc30ffffff 64bit pref]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:09.0: BAR 9: assigned [mem 0xc31000000-0xc311fffff 64bit pref]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:0c.0: BAR 9: assigned [mem 0xc31200000-0xc313fffff 64bit pref]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:0d.0: BAR 9: assigned [mem 0xc31400000-0xc315fffff 64bit pref]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:00.0: BAR 7: no space for [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:00.0: BAR 7: failed to assign [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:01.0: BAR 7: no space for [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:01.0: BAR 7: failed to assign [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:02.0: BAR 7: no space for [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:02.0: BAR 7: failed to assign [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:03.0: BAR 7: no space for [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:03.0: BAR 7: failed to assign [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:04.0: BAR 7: no space for [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:04.0: BAR 7: failed to assign [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:06.0: BAR 7: no space for [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:06.0: BAR 7: failed to assign [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:07.0: BAR 7: no space for [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:07.0: BAR 7: failed to assign [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:08.0: BAR 7: no space for [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:08.0: BAR 7: failed to assign [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:09.0: BAR 7: no space for [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:09.0: BAR 7: failed to assign [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:0c.0: BAR 7: no space for [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:0c.0: BAR 7: failed to assign [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:0d.0: BAR 7: no space for [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:0d.0: BAR 7: failed to assign [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:0d.0: BAR 7: no space for [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:0d.0: BAR 7: failed to assign [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:0c.0: BAR 7: no space for [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:0c.0: BAR 7: failed to assign [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:09.0: BAR 7: no space for [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:09.0: BAR 7: failed to assign [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:08.0: BAR 7: no space for [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:08.0: BAR 7: failed to assign [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:07.0: BAR 7: no space for [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:07.0: BAR 7: failed to assign [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:06.0: BAR 7: no space for [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:06.0: BAR 7: failed to assign [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:04.0: BAR 7: no space for [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:04.0: BAR 7: failed to assign [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:03.0: BAR 7: no space for [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:03.0: BAR 7: failed to assign [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:02.0: BAR 7: no space for [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:02.0: BAR 7: failed to assign [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:01.0: BAR 7: no space for [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:01.0: BAR 7: failed to assign [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:00.0: BAR 7: no space for [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:00.0: BAR 7: failed to assign [io  size 0x1000]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:00.0: PCI bridge to [bus 40-4f]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:00.0:   bridge window [mem 0xc04000000-0xc07ffffff]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:00.0:   bridge window [mem 0xc30000000-0xc301fffff 64bit pref]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:01.0: PCI bridge to [bus 90-9f]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:01.0:   bridge window [mem 0xc08000000-0xc0bffffff]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:01.0:   bridge window [mem 0xc30200000-0xc303fffff 64bit pref]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:02.0: PCI bridge to [bus 80-8f]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:02.0:   bridge window [mem 0xc00000000-0xc03ffffff]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:02.0:   bridge window [mem 0xc30400000-0xc305fffff 64bit pref]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:03.0: PCI bridge to [bus 50-5f]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:03.0:   bridge window [mem 0xc0c000000-0xc0fffffff]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:03.0:   bridge window [mem 0xc30600000-0xc307fffff 64bit pref]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:04.0: PCI bridge to [bus 30-3f]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:04.0:   bridge window [mem 0xc28000000-0xc2bffffff]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:04.0:   bridge window [mem 0xc30800000-0xc309fffff 64bit pref]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:06.0: PCI bridge to [bus 70-7f]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:06.0:   bridge window [mem 0xc1c000000-0xc1fffffff]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:06.0:   bridge window [mem 0xc30a00000-0xc30bfffff 64bit pref]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:07.0: PCI bridge to [bus 60-6f]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:07.0:   bridge window [mem 0xc14000000-0xc17ffffff]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:07.0:   bridge window [mem 0xc30c00000-0xc30dfffff 64bit pref]
Dec 31 16:00:35 fpc0 kernel: pci 0000:20:00.0: BAR 0: assigned [mem 0xc20000000-0xc23ffffff]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:08.0: PCI bridge to [bus 20-2f]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:08.0:   bridge window [mem 0xc20000000-0xc23ffffff]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:08.0:   bridge window [mem 0xc30e00000-0xc30ffffff 64bit pref]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:09.0: PCI bridge to [bus 10-1f]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:09.0:   bridge window [mem 0xc24000000-0xc27ffffff]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:09.0:   bridge window [mem 0xc31000000-0xc311fffff 64bit pref]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:0c.0: PCI bridge to [bus b0-bf]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:0c.0:   bridge window [mem 0xc18000000-0xc1bffffff]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:0c.0:   bridge window [mem 0xc31200000-0xc313fffff 64bit pref]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:0d.0: PCI bridge to [bus a0-af]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:0d.0:   bridge window [mem 0xc10000000-0xc13ffffff]
Dec 31 16:00:35 fpc0 kernel: pci 0000:02:0d.0:   bridge window [mem 0xc31400000-0xc315fffff 64bit pref]
Dec 31 16:00:35 fpc0 kernel: pci 0000:01:00.0: PCI bridge to [bus 02-ff]
Dec 31 16:00:35 fpc0 kernel: pci 0000:01:00.0:   bridge window [mem 0xc00000000-0xc2fffffff]
Dec 31 16:00:35 fpc0 kernel: pci 0000:01:00.0:   bridge window [mem 0xc30000000-0xc315fffff 64bit pref]
Dec 31 16:00:35 fpc0 kernel: pci 0000:00:00.0: PCI bridge to [bus 01-ff]
Dec 31 16:00:35 fpc0 kernel: pci 0000:00:00.0:   bridge window [mem 0xc00000000-0xc3fffffff]
Dec 31 16:00:35 fpc0 kernel: pci_bus 0000:00: Some PCI device resources are unassigned, try booting with pci=realloc
Dec 31 16:00:35 fpc0 kernel: pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
Dec 31 16:00:35 fpc0 kernel: pci_bus 0000:00: resource 5 [mem 0xc00000000-0xc3fffffff]
Dec 31 16:00:35 fpc0 kernel: pci_bus 0000:01: resource 1 [mem 0xc00000000-0xc3fffffff]
Dec 31 16:00:35 fpc0 kernel: pci_bus 0000:02: resource 1 [mem 0xc00000000-0xc2fffffff]
Dec 31 16:00:35 fpc0 kernel: pci_bus 0000:02: resource 2 [mem 0xc30000000-0xc315fffff 64bit pref]
Dec 31 16:00:35 fpc0 kernel: pci_bus 0000:40: resource 1 [mem 0xc04000000-0xc07ffffff]
Dec 31 16:00:35 fpc0 kernel: pci_bus 0000:40: resource 2 [mem 0xc30000000-0xc301fffff 64bit pref]
Dec 31 16:00:35 fpc0 kernel: pci_bus 0000:90: resource 1 [mem 0xc08000000-0xc0bffffff]
Dec 31 16:00:35 fpc0 kernel: pci_bus 0000:90: resource 2 [mem 0xc30200000-0xc303fffff 64bit pref]
Dec 31 16:00:35 fpc0 kernel: pci_bus 0000:80: resource 1 [mem 0xc00000000-0xc03ffffff]
Dec 31 16:00:35 fpc0 kernel: pci_bus 0000:80: resource 2 [mem 0xc30400000-0xc305fffff 64bit pref]
Dec 31 16:00:35 fpc0 kernel: pci_bus 0000:50: resource 1 [mem 0xc0c000000-0xc0fffffff]
Dec 31 16:00:35 fpc0 kernel: pci_bus 0000:50: resource 2 [mem 0xc30600000-0xc307fffff 64bit pref]
Dec 31 16:00:35 fpc0 kernel: pci_bus 0000:30: resource 1 [mem 0xc28000000-0xc2bffffff]
Dec 31 16:00:35 fpc0 kernel: pci_bus 0000:30: resource 2 [mem 0xc30800000-0xc309fffff 64bit pref]
Dec 31 16:00:35 fpc0 kernel: pci_bus 0000:70: resource 1 [mem 0xc1c000000-0xc1fffffff]
Dec 31 16:00:35 fpc0 kernel: pci_bus 0000:70: resource 2 [mem 0xc30a00000-0xc30bfffff 64bit pref]
Dec 31 16:00:35 fpc0 kernel: pci_bus 0000:60: resource 1 [mem 0xc14000000-0xc17ffffff]
Dec 31 16:00:35 fpc0 kernel: pci_bus 0000:60: resource 2 [mem 0xc30c00000-0xc30dfffff 64bit pref]
Dec 31 16:00:35 fpc0 kernel: pci_bus 0000:20: resource 1 [mem 0xc20000000-0xc23ffffff]
Dec 31 16:00:35 fpc0 kernel: pci_bus 0000:20: resource 2 [mem 0xc30e00000-0xc30ffffff 64bit pref]
Dec 31 16:00:35 fpc0 kernel: pci_bus 0000:10: resource 1 [mem 0xc24000000-0xc27ffffff]
Dec 31 16:00:35 fpc0 kernel: pci_bus 0000:10: resource 2 [mem 0xc31000000-0xc311fffff 64bit pref]
Dec 31 16:00:35 fpc0 kernel: pci_bus 0000:b0: resource 1 [mem 0xc18000000-0xc1bffffff]
Dec 31 16:00:35 fpc0 kernel: pci_bus 0000:b0: resource 2 [mem 0xc31200000-0xc313fffff 64bit pref]
Dec 31 16:00:35 fpc0 kernel: pci_bus 0000:a0: resource 1 [mem 0xc10000000-0xc13ffffff]
Dec 31 16:00:35 fpc0 kernel: pci_bus 0000:a0: resource 2 [mem 0xc31400000-0xc315fffff 64bit pref]
Dec 31 16:00:35 fpc0 kernel: Setting up Freescale MSI support
Dec 31 16:00:35 fpc0 kernel: Freescale Elo series DMA driver
Dec 31 16:00:35 fpc0 kernel: fsl-elo-dma fff70c300.dma0: #0 (fsl,eloplus-dma-channel), irq 76
Dec 31 16:00:35 fpc0 kernel: fsl-elo-dma fff70c300.dma0: #1 (fsl,eloplus-dma-channel), irq 77
Dec 31 16:00:35 fpc0 kernel: fsl-elo-dma fff70c300.dma0: #2 (fsl,eloplus-dma-channel), irq 78
Dec 31 16:00:35 fpc0 kernel: fsl-elo-dma fff70c300.dma0: #3 (fsl,eloplus-dma-channel), irq 79
Dec 31 16:00:35 fpc0 kernel: fsl-elo-dma fff721300.dma1: #0 (fsl,eloplus-dma-channel), irq 20
Dec 31 16:00:35 fpc0 kernel: fsl-elo-dma fff721300.dma1: #1 (fsl,eloplus-dma-channel), irq 21
Dec 31 16:00:35 fpc0 kernel: fsl-elo-dma fff721300.dma1: #2 (fsl,eloplus-dma-channel), irq 22
Dec 31 16:00:35 fpc0 kernel: fsl-elo-dma fff721300.dma1: #3 (fsl,eloplus-dma-channel), irq 23
Dec 31 16:00:35 fpc0 kernel: vgaarb: loaded
Dec 31 16:00:35 fpc0 kernel: SCSI subsystem initialized
Dec 31 16:00:35 fpc0 kernel: pps_core: LinuxPPS API ver. 1 registered
Dec 31 16:00:35 fpc0 kernel: pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
Dec 31 16:00:35 fpc0 kernel: PTP clock support registered
Dec 31 16:00:35 fpc0 kernel: Switched to clocksource timebase
Dec 31 16:00:35 fpc0 kernel: NET: Registered protocol family 2
Dec 31 16:00:35 fpc0 kernel: TCP established hash table entries: 8192 (order: 3, 32768 bytes)
Dec 31 16:00:35 fpc0 kernel: TCP bind hash table entries: 8192 (order: 4, 98304 bytes)
Dec 31 16:00:35 fpc0 kernel: TCP: Hash tables configured (established 8192 bind 8192)
Dec 31 16:00:35 fpc0 kernel: TCP: reno registered
Dec 31 16:00:35 fpc0 kernel: UDP hash table entries: 512 (order: 2, 16384 bytes)
Dec 31 16:00:35 fpc0 kernel: UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
Dec 31 16:00:35 fpc0 kernel: NET: Registered protocol family 1
Dec 31 16:00:35 fpc0 kernel: RPC: Registered named UNIX socket transport module.
Dec 31 16:00:35 fpc0 kernel: RPC: Registered udp transport module.
Dec 31 16:00:35 fpc0 kernel: RPC: Registered tcp transport module.
Dec 31 16:00:35 fpc0 kernel: RPC: Registered tcp NFSv4.1 backchannel transport module.
Dec 31 16:00:35 fpc0 kernel: PCI: CLS 0 bytes, default 32
Dec 31 16:00:35 fpc0 kernel: Trying to unpack rootfs image as initramfs...
Dec 31 16:00:35 fpc0 kernel: Freeing initrd memory: 313236K (dce1a000 - effff000)
Dec 31 16:00:35 fpc0 kernel: futex hash table entries: 512 (order: 2, 16384 bytes)
Dec 31 16:00:35 fpc0 kernel: audit: initializing netlink subsys (disabled)
Dec 31 16:00:35 fpc0 kernel: audit: type=2000 audit(19.136:1): initialized
Dec 31 16:00:35 fpc0 kernel: squashfs: version 4.0 (2009/01/31) Phillip Lougher
Dec 31 16:00:35 fpc0 kernel: NFS: Registering the id_resolver key type
Dec 31 16:00:35 fpc0 kernel: Key type id_resolver registered
Dec 31 16:00:35 fpc0 kernel: Key type id_legacy registered
Dec 31 16:00:35 fpc0 kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Dec 31 16:00:35 fpc0 kernel: fuse init (API version 7.23)
Dec 31 16:00:35 fpc0 kernel: bounce: pool size: 64 pages
Dec 31 16:00:35 fpc0 kernel: io scheduler noop registered
Dec 31 16:00:35 fpc0 kernel: io scheduler deadline registered
Dec 31 16:00:35 fpc0 kernel: io scheduler cfq registered (default)
Dec 31 16:00:35 fpc0 kernel: pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Dec 31 16:00:35 fpc0 kernel: Serial: 8250/16550 driver, 2 ports, IRQ sharing enabled
Dec 31 16:00:35 fpc0 kernel: console [ttyS0] disabled
Dec 31 16:00:35 fpc0 kernel: serial8250.0: ttyS0 at MMIO 0xfff704500 (irq = 42, base_baud = 25000000) is a 16550A
Dec 31 16:00:35 fpc0 kernel: console [ttyS0] enabled
Dec 31 16:00:35 fpc0 kernel: bootconsole [udbg0] disabled
Dec 31 16:00:35 fpc0 kernel: serial8250.0: ttyS1 at MMIO 0xfff704600 (irq = 42, base_baud = 25000000) is a 16550A
Dec 31 16:00:35 fpc0 kernel: Generic non-volatile memory driver v1.1
Dec 31 16:00:35 fpc0 kernel: brd: module loaded
Dec 31 16:00:35 fpc0 kernel: loop: module loaded
Dec 31 16:00:35 fpc0 kernel: ptxpmb-cpld fff000000.cpld: Revision 0x07 carrier type 0x10 [FPC]
Dec 31 16:00:35 fpc0 kernel: st: Version 20101219, fixed bufsize 32768, s/g segs 256
Dec 31 16:00:35 fpc0 kernel: 1 ofpart partitions found on MTD device fff100000.nvram
Dec 31 16:00:35 fpc0 kernel: Creating 1 MTD partitions on "fff100000.nvram":
Dec 31 16:00:35 fpc0 kernel: 0x000000000000-0x000000040000 : "nvram"
Dec 31 16:00:35 fpc0 kernel: ftl_cs: FTL header not found.
Dec 31 16:00:35 fpc0 kernel: fff800000.flash: Found 1 x16 devices at 0x0 in 8-bit bank. Manufacturer ID 0x000020 Chip ID 0x000056
Dec 31 16:00:35 fpc0 kernel: Amd/Fujitsu Extended Query Table at 0x0040
Dec 31 16:00:35 fpc0 kernel:   Amd/Fujitsu Extended Query version 1.1.
Dec 31 16:00:35 fpc0 kernel: fff800000.flash: Swapping erase regions for top-boot CFI table.
Dec 31 16:00:35 fpc0 kernel: number of CFI chips: 1
Dec 31 16:00:35 fpc0 kernel: 2 ofpart partitions found on MTD device fff800000.flash
Dec 31 16:00:35 fpc0 kernel: Creating 2 MTD partitions on "fff800000.flash":
Dec 31 16:00:35 fpc0 kernel: 0x000000000000-0x000000380000 : "unused"
Dec 31 16:00:35 fpc0 kernel: ftl_cs: FTL header not found.
Dec 31 16:00:35 fpc0 kernel: 0x000000380000-0x000000400000 : "uboot"
Dec 31 16:00:35 fpc0 kernel: ftl_cs: FTL header not found.
Dec 31 16:00:35 fpc0 kernel: ffff80000.flash: Found 1 x16 devices at 0x0 in 8-bit bank. Manufacturer ID 0x000001 Chip ID 0x0000da
Dec 31 16:00:35 fpc0 kernel: NOR chip too large to fit in mapping. Attempting to cope...
Dec 31 16:00:35 fpc0 kernel: Amd/Fujitsu Extended Query Table at 0x0040
Dec 31 16:00:35 fpc0 kernel:   Amd/Fujitsu Extended Query version 1.3.
Dec 31 16:00:35 fpc0 kernel: ffff80000.flash: Swapping erase regions for top-boot CFI table.
Dec 31 16:00:35 fpc0 kernel: number of CFI chips: 1
Dec 31 16:00:35 fpc0 kernel: Reducing visibility of 1024KiB chip to 512KiB
Dec 31 16:00:35 fpc0 kernel: 1 ofpart partitions found on MTD device ffff80000.flash
Dec 31 16:00:35 fpc0 kernel: Creating 1 MTD partitions on "ffff80000.flash":
Dec 31 16:00:35 fpc0 kernel: 0x000000000000-0x000000080000 : "uboot"
Dec 31 16:00:35 fpc0 kernel: ftl_cs: FTL header not found.
Dec 31 16:00:35 fpc0 kernel: libphy: Fixed MDIO Bus: probed
Dec 31 16:00:35 fpc0 kernel: libphy: Freescale PowerQUICC MII Bus: probed
Dec 31 16:00:35 fpc0 kernel: fsl-gianfar fff724000.dTSEC0: enabled errata workarounds, flags: 0x4
Dec 31 16:00:35 fpc0 kernel: fsl-gianfar fff724000.dTSEC0 eth0: mac: 02:00:00:00:00:10
Dec 31 16:00:35 fpc0 kernel: fsl-gianfar fff724000.dTSEC0 eth0: Running with NAPI enabled
Dec 31 16:00:35 fpc0 kernel: fsl-gianfar fff724000.dTSEC0 eth0: RX BD ring size for Q[0]: 256
Dec 31 16:00:35 fpc0 kernel: fsl-gianfar fff724000.dTSEC0 eth0: TX BD ring size for Q[0]: 256
Dec 31 16:00:35 fpc0 kernel: fsl-gianfar fff725000.dTSEC1: enabled errata workarounds, flags: 0x4
Dec 31 16:00:35 fpc0 kernel: fsl-gianfar fff725000.dTSEC1 eth1: mac: 02:00:01:00:00:10
Dec 31 16:00:35 fpc0 kernel: fsl-gianfar fff725000.dTSEC1 eth1: Running with NAPI enabled
Dec 31 16:00:35 fpc0 kernel: fsl-gianfar fff725000.dTSEC1 eth1: RX BD ring size for Q[0]: 256
Dec 31 16:00:35 fpc0 kernel: fsl-gianfar fff725000.dTSEC1 eth1: TX BD ring size for Q[0]: 256
Dec 31 16:00:35 fpc0 kernel: fsl-gianfar fff726000.dTSEC2: enabled errata workarounds, flags: 0x4
Dec 31 16:00:35 fpc0 kernel: fsl-gianfar fff726000.dTSEC2 eth2: mac: 02:00:00:00:00:10
Dec 31 16:00:35 fpc0 kernel: fsl-gianfar fff726000.dTSEC2 eth2: Running with NAPI enabled
Dec 31 16:00:35 fpc0 kernel: fsl-gianfar fff726000.dTSEC2 eth2: RX BD ring size for Q[0]: 256
Dec 31 16:00:35 fpc0 kernel: fsl-gianfar fff726000.dTSEC2 eth2: TX BD ring size for Q[0]: 256
Dec 31 16:00:35 fpc0 kernel: i2c /dev entries driver
Dec 31 16:00:35 fpc0 kernel: mpc-i2c fff703000.i2c-master-0: timeout 1000000 us
Dec 31 16:00:35 fpc0 kernel: mpc-i2c fff703100.i2c-master-1: timeout 1000000 us
Dec 31 16:00:35 fpc0 kernel: at24 2-0051: 256 byte 24c02 EEPROM, writable, 1 bytes/write
Dec 31 16:00:35 fpc0 kernel: at24 2-0052: 256 byte 24c02 EEPROM, writable, 1 bytes/write
Dec 31 16:00:35 fpc0 kernel: i2c i2c-2: Added multiplexed i2c bus 3
Dec 31 16:00:35 fpc0 kernel: i2c i2c-2: Added multiplexed i2c bus 4
Dec 31 16:00:35 fpc0 kernel: i2c i2c-2: Added multiplexed i2c bus 5
Dec 31 16:00:35 fpc0 kernel: i2c i2c-2: Added multiplexed i2c bus 6
Dec 31 16:00:35 fpc0 kernel: i2c i2c-2: Added multiplexed i2c bus 7
Dec 31 16:00:35 fpc0 kernel: i2c i2c-2: Added multiplexed i2c bus 8
Dec 31 16:00:35 fpc0 kernel: i2c i2c-2: Added multiplexed i2c bus 9
Dec 31 16:00:35 fpc0 kernel: i2c i2c-2: Added multiplexed i2c bus 10
Dec 31 16:00:35 fpc0 kernel: pca954x 2-0076: registered 8 multiplexed busses for I2C switch pca9548
Dec 31 16:00:35 fpc0 kernel: i2c i2c-0: Added multiplexed i2c bus 2
Dec 31 16:00:35 fpc0 kernel: i2c i2c-0: Added multiplexed i2c bus 11
Dec 31 16:00:35 fpc0 kernel: i2c i2c-0: Added multiplexed i2c bus 12
Dec 31 16:00:35 fpc0 kernel: i2c i2c-0: Added multiplexed i2c bus 13
Dec 31 16:00:35 fpc0 kernel: i2c i2c-0: Added multiplexed i2c bus 14
Dec 31 16:00:35 fpc0 kernel: i2c i2c-0: Added multiplexed i2c bus 15
Dec 31 16:00:35 fpc0 kernel: i2c i2c-0: Added multiplexed i2c bus 16
Dec 31 16:00:35 fpc0 kernel: i2c i2c-0: Added multiplexed i2c bus 17
Dec 31 16:00:35 fpc0 kernel: platform max1139@35: Driver iio_hwmon requests probe deferral
Dec 31 16:00:35 fpc0 kernel: random: nonblocking pool is initialized
Dec 31 16:00:35 fpc0 kernel: booke_wdt: powerpc book-e watchdog driver loaded
Dec 31 16:00:35 fpc0 kernel: jnx-ptxpmb-wdt jnx-ptxpmb-wdt: initialized
Dec 31 16:00:35 fpc0 kernel: nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
Dec 31 16:00:35 fpc0 kernel: ipip: IPv4 over IPv4 tunneling driver
Dec 31 16:00:35 fpc0 kernel: ip_tables: (C) 2000-2006 Netfilter Core Team
Dec 31 16:00:35 fpc0 kernel: ipt_CLUSTERIP: ClusterIP Version 0.8 loaded successfully
Dec 31 16:00:35 fpc0 kernel: arp_tables: (C) 2002 David S. Miller
Dec 31 16:00:35 fpc0 kernel: TCP: cubic registered
Dec 31 16:00:35 fpc0 kernel: Initializing XFRM netlink socket
Dec 31 16:00:35 fpc0 kernel: NET: Registered protocol family 10
Dec 31 16:00:35 fpc0 kernel: sit: IPv6 over IPv4 tunneling driver
Dec 31 16:00:35 fpc0 kernel: NET: Registered protocol family 17
Dec 31 16:00:35 fpc0 kernel: NET: Registered protocol family 15
Dec 31 16:00:35 fpc0 kernel: bridge: automatic filtering via arp/ip/ip6tables has been deprecated. Update your scripts to load br_netfilter if you need this.
Dec 31 16:00:35 fpc0 kernel: Ebtables v2.0 registered
Dec 31 16:00:35 fpc0 kernel: 8021q: 802.1Q VLAN Support v1.8
Dec 31 16:00:35 fpc0 kernel: Key type dns_resolver registered
Dec 31 16:00:35 fpc0 kernel: registered taskstats version 1
Dec 31 16:00:35 fpc0 kernel: IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
Dec 31 16:00:35 fpc0 kernel: fsl-gianfar fff724000.dTSEC0 eth0: Link is Up - 100Mbps/Half - flow control off
Dec 31 16:00:35 fpc0 kernel: IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
Dec 31 16:00:35 fpc0 kernel: IP-Config: Complete:
Dec 31 16:00:35 fpc0 kernel:      device=eth0, hwaddr=02:00:00:00:00:10, ipaddr=128.0.0.16, mask=192.0.0.0, gw=128.0.0.4
Dec 31 16:00:35 fpc0 kernel:      host=fpc0, domain=, nis-domain=(none)
Dec 31 16:00:35 fpc0 kernel:      bootserver=128.0.0.4, rootserver=128.0.0.4, rootpath=
Dec 31 16:00:35 fpc0 kernel: Freeing unused kernel memory: 276K (c0643000 - c0688000)
