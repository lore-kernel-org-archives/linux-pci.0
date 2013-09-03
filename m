Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.162]:45864 "EHLO
	mail1.bemta3.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759703Ab3ICJys convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 3 Sep 2013 05:54:48 -0400
Date: Tue, 3 Sep 2013 11:55:00 +0200
From: Johannes Thumshirn <johannes.thumshirn@men.de>
To: Yinghai Lu <yinghai@kernel.org>
CC: Johannes Thumshirn <johannes.thumshirn@men.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: PCI reset problem
Message-ID: <20130903095500.GA15782@jtlinux>
References: <20130828133337.GA8544@jtlinux>
 <CAErSpo5sa2cJXOUhfe5VDzxwabf0Um42ZfBwOMhF1TbwCW9G=w@mail.gmail.com>
 <20130829082941.GA11203@jtlinux>
 <CAErSpo56RszdMQDOY8xCmz=1QP-osUGA71V56t9X9zY4rNAYew@mail.gmail.com>
 <20130829150723.GA32730@jtlinux>
 <CAErSpo5nTy7bkU2_ZMR_sROz-FJF28a==eUdE3e-wZoZfzQZBw@mail.gmail.com>
 <20130830080138.GA24908@jtlinux>
 <CAE9FiQWsyY2xnbOcd9L9=G0z50fZo-7OfaZovKVO3XzVuZODjA@mail.gmail.com>
 <20130902080057.GA14515@jtlinux>
 <CAE9FiQVb4GHFS6jwLbGKcPjF0HJ_mkACsj_kPrXvOKsjNDHd8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <CAE9FiQVb4GHFS6jwLbGKcPjF0HJ_mkACsj_kPrXvOKsjNDHd8g@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 02, 2013 at 03:18:48PM -0700, Yinghai Lu wrote:
> On Mon, Sep 2, 2013 at 1:00 AM, Johannes Thumshirn
> <johannes.thumshirn@men.de> wrote:
>
> > I've tested the board with your for-pci-busn-alloc-3.11 branch. Initial
> > enumeration is just as it was before. With the difference that a "sysfs-rescan"
> > now results in:
> >
> > root@generic-powerpc:~# lspci
> > 00:00.0 PCI bridge: Freescale Semiconductor Inc P4080 (rev 20)
> > root@generic-powerpc:~# echo 1 > /sys/bus/pci/rescan
> > pci_bus 0000:00: scanning bus
> > pcieport 0000:00:00.0: scanning [bus 01-01] behind bridge, pass 0
> > pcieport 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
> > pcieport 0000:00:00.0: rescan scaned bridge as broken one again ?
> > pci_bus 0000:00: bus scan returning with max=00
> > root@generic-powerpc:~# lspci
> > 00:00.0 PCI bridge: Freescale Semiconductor Inc P4080 (rev 20)
>
> please send out whole boot log with "debug ignore_loglevel initcall_debug" ?
> please make sure you have "CONFIG_PCI_DEBUG=y" in .config.
>
> Yinghai

---snip---
U-Boot 2013.01-00004-g3198ea1-dirty (Aug 29 2013 - 13:56:16) MEN XM51 1.1 (fallback)

CPU0:  P4080, Version: 2.0, (0x82000020)
Core:  E500MC, Version: 2.0, (0x80230020)
Clock Configuration:
       CPU0:1200 MHz, CPU1:1200 MHz, CPU2:1200 MHz, CPU3:1200 MHz,
       CPU4:1200 MHz, CPU5:1200 MHz, CPU6:1200 MHz, CPU7:1200 MHz,
       CCB:600  MHz,
       DDR:600  MHz (1200 MT/s data rate) (Asynchronous), LBC:37.500 MHz
       FMAN1: 450 MHz
       FMAN2: 450 MHz
       QMAN:  300 MHz
       PME:   450 MHz
L1:    D-cache 32 kB enabled
       I-cache 32 kB enabled
Reset Configuration Word (RCW):
       00000000: 4c580000 00000000 18185218 0000cccc
       00000010: 38404400 3c3c2000 fe800000 e1000000
       00000020: 00000000 00000000 00000000 c0ddd0f4
       00000030: a0000000 00000000 00000000 00000000
Board: MEN XM51
Reset Configuration Word (RCW):
		 00000000: 4c580000 00000000 18185218 0000cccc
		 00000010: 38404400 3c3c2000 fe800000 e1000000
		 00000020: 00000000 00000000 00000000 c0ddd0f4
		 00000030: a0000000 00000000 00000000 00000000
I2C:   ready
DRAM:  Initializing....using SPD
       (memory mapped)
              (memory mapped)
       Detected UDIMM
Detected UDIMM
       DDR: 2 GiB (DDR3, 64-bit, CL=8, ECC on)
       DDR Controller Interleaving Mode: cache line
Flash: 64 MiB
L2:    128 KB enabled
Corenet Platform Cache: 2048 KB enabled
SERDES: timeout resetting bank 3
SERDES: timeout resetting bank 2
PCIe1: Root Complex, x1, regs @ 0xfe200000
  01:00.0     - 12d8:400a - Bridge device
   02:01.0    - 12d8:400a - Bridge device
    03:00.0   - 1095:3132 - Mass storage controller
   02:02.0    - 12d8:400a - Bridge device
   02:03.0    - 12d8:400a - Bridge device
    05:00.0   - 12d8:400e - Serial bus controller
    05:00.1   - 12d8:400e - Serial bus controller
    05:00.2   - 12d8:400f - Serial bus controller
PCIe1: Bus 00 - 05
PCIe2: Root Complex, no link, regs @ 0xfe201000
PCIe2: Bus 06 - 06
PCIe3: Root Complex, no link, regs @ 0xfe202000
PCIe3: Bus 07 - 07
In:    serial
Out:   serial
Err:   serial
SERDES Reference Clocks: Bank1=100MHz
Board: name=XM51-00 rev=01.02.00 ser#=38
Net:   Fman1: Uploading microcode version 101.8.0
Failed to connect
Fman2: Uploading microcode version 101.8.0
Failed to connect
FM2@DTSEC3, FM2@DTSEC4 [PRIME]
Boot:  os=linux bootmethod=tftp
Auto-update from TFTP: failed, env. variable 'updatefile' not found
Hit any key to stop autoboot:  3  2  1  0
via TFTP:
FM2@DTSEC4 Waiting for PHY auto negotiation to complete......... TIMEOUT !
FM2@DTSEC4: No link.
Using FM2@DTSEC3 device
TFTP from server 10.0.0.1; our IP address is 10.0.0.10
Filename '/tftpboot/pMulti_XM51'.
Load address: 0x2000000
Loading: *#################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 ##########################################
	 4.3 MiB/s
done
Bytes transferred = 7199855 (6ddc6f hex)
WARNING: adjusting available memory to 30000000
## Booting kernel from Legacy Image at 02000000 ...
   Image Name:   XM51 Linux
   Created:      2013-09-02   7:48:35 UTC
   Image Type:   PowerPC Linux Multi-File Image (gzip compressed)
   Data Size:    7199791 Bytes = 6.9 MiB
   Load Address: 00000000
   Entry Point:  00000000
   Contents:
      Image 0: 3408358 Bytes = 3.3 MiB
      Image 1: 3767252 Bytes = 3.6 MiB
      Image 2: 24163 Bytes = 23.6 KiB
   Verifying Checksum ... OK
## Loading init Ramdisk from multi component Legacy Image at 02000000 ...
## Flattened Device Tree from multi component Image at 02000000
   Booting using the fdt at 0x026d7e0c
   Uncompressing Multi-File Image ... OK
   Loading Ramdisk to 2fc68000, end 2ffffbd4 ... OK
   Loading Device Tree to 00ff7000, end 00fffe62 ... OK
debug: ignoring loglevel setting.
Using P4080 DS machine description
Memory CAM mapping: 256/256/256 Mb, residual: 1280Mb
Linux version 3.11.0-rc7-00133-g33a99f2-dirty (jt@jtlinux) (gcc version 4.7.2 (GCC) ) #1 SMP Mon Sep 2 09:22:39 CEST 2013
Found initrd at 0xefc68000:0xeffffbd4
Found legacy serial port 0 for /soc@fe000000/serial@11c500
  mem=fe11c500, taddr=fe11c500, irq=0, clk=300000000, speed=0
Found legacy serial port 1 for /soc@fe000000/serial@11c600
  mem=fe11c600, taddr=fe11c600, irq=0, clk=300000000, speed=0
Found legacy serial port 2 for /soc@fe000000/serial@11d500
  mem=fe11d500, taddr=fe11d500, irq=0, clk=300000000, speed=0
Found legacy serial port 3 for /soc@fe000000/serial@11d600
  mem=fe11d600, taddr=fe11d600, irq=0, clk=300000000, speed=0
CPU maps initialized for 1 thread per core
 (thread shift is 0)
bootconsole [udbg0] enabled
setup_arch: bootmem
P4080 DS board from Freescale Semiconductor
arch: exit
Top of RAM: 0x80000000, Total RAM: 0x80000000
Memory hole size: 0MB
Zone ranges:
  DMA      [mem 0x00000000-0x2fffffff]
  Normal   empty
  HighMem  [mem 0x30000000-0x7fffffff]
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x00000000-0x7fffffff]
On node 0 totalpages: 524288
free_area_init_node: node 0, pgdat c0670540, node_mem_map c0fff000
  DMA zone: 1536 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 196608 pages, LIFO batch:31
  HighMem zone: 2560 pages used for memmap
  HighMem zone: 327680 pages, LIFO batch:31
MMU: Allocated 1088 bytes of context maps for 255 contexts
PERCPU: Embedded 7 pages/cpu @c200b000 s7168 r8192 d13312 u32768
pcpu-alloc: s7168 r8192 d13312 u32768 alloc=8*4096
pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6 [0] 7
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 522752
Kernel command line: root=/dev/ram rw console=ttyS0,115200 ip=10.0.0.10:10.0.0.1:192.1.1.22:255.255.255.0::eth0:off debug ignore_loglevel initcall_debug
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Sorting __ex_table...
Memory: 2002668K/2097152K available (4780K kernel code, 224K rwdata, 1396K rodata, 240K init, 309K bss, 94484K reserved, 1310712K highmem)
Kernel virtual memory layout:
  * 0xfff5f000..0xfffff000  : fixmap
  * 0xffc00000..0xffe00000  : highmem PTEs
  * 0xffbfe000..0xffc00000  : early ioremap
  * 0xf1000000..0xffbfe000  : vmalloc & ioremap
Hierarchical RCU implementation.
	RCU debugfs-based tracing is enabled.
NR_IRQS:512 nr_irqs:512 16
mpic: Setting up MPIC " OpenPIC  " version 1.2 at fe040000, max 8 CPUs
mpic: ISU size: 512, shift: 9, mask: 1ff
mpic: Initializing for 512 sources
time_init: decrementer frequency = 37.500000 MHz
time_init: processor frequency   = 1200.000000 MHz
clocksource: timebase mult[1aaaaaab] shift[24] registered
clockevent: decrementer mult[999999a] shift[32] cpu[0]
Console: colour dummy device 80x25
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
mpic: requesting IPIs...
calling  epapr_paravirt_init+0x0/0xf8 @ 1
initcall epapr_paravirt_init+0x0/0xf8 returned -19 after 0 usecs
calling  init_e500_pmu+0x0/0xc0 @ 1
e500 family performance monitor hardware support registered
initcall init_e500_pmu+0x0/0xc0 returned 0 after 3906 usecs
calling  spawn_ksoftirqd+0x0/0x44 @ 1
initcall spawn_ksoftirqd+0x0/0x44 returned 0 after 0 usecs
calling  init_workqueues+0x0/0x3b8 @ 1
initcall init_workqueues+0x0/0x3b8 returned 0 after 0 usecs
calling  check_cpu_stall_init+0x0/0x34 @ 1
initcall check_cpu_stall_init+0x0/0x34 returned 0 after 0 usecs
calling  migration_init+0x0/0x8c @ 1
initcall migration_init+0x0/0x8c returned 0 after 0 usecs
calling  cpu_stop_init+0x0/0xa8 @ 1
initcall cpu_stop_init+0x0/0xa8 returned 0 after 0 usecs
calling  rcu_scheduler_really_started+0x0/0x14 @ 1
initcall rcu_scheduler_really_started+0x0/0x14 returned 0 after 0 usecs
calling  rcu_spawn_gp_kthread+0x0/0xb0 @ 1
initcall rcu_spawn_gp_kthread+0x0/0xb0 returned 0 after 0 usecs
Brought up 8 CPUs
devtmpfs: initialized
calling  ipc_ns_init+0x0/0x2c @ 1
initcall ipc_ns_init+0x0/0x2c returned 0 after 0 usecs
calling  init_mmap_min_addr+0x0/0x18 @ 1
initcall init_mmap_min_addr+0x0/0x18 returned 0 after 0 usecs
calling  net_ns_init+0x0/0x1a8 @ 1
initcall net_ns_init+0x0/0x1a8 returned 0 after 0 usecs
calling  proc_ppc64_create+0x0/0x94 @ 1
initcall proc_ppc64_create+0x0/0x94 returned 0 after 0 usecs
calling  wq_sysfs_init+0x0/0x10 @ 1
initcall wq_sysfs_init+0x0/0x10 returned 0 after 0 usecs
calling  ksysfs_init+0x0/0xb0 @ 1
initcall ksysfs_init+0x0/0xb0 returned 0 after 0 usecs
calling  init_jiffies_clocksource+0x0/0xc @ 1
initcall init_jiffies_clocksource+0x0/0xc returned 0 after 0 usecs
calling  init_zero_pfn+0x0/0x20 @ 1
initcall init_zero_pfn+0x0/0x20 returned 0 after 0 usecs
calling  fsnotify_init+0x0/0x3c @ 1
initcall fsnotify_init+0x0/0x3c returned 0 after 0 usecs
calling  filelock_init+0x0/0xb4 @ 1
initcall filelock_init+0x0/0xb4 returned 0 after 0 usecs
calling  init_misc_binfmt+0x0/0x4c @ 1
initcall init_misc_binfmt+0x0/0x4c returned 0 after 0 usecs
calling  init_script_binfmt+0x0/0x30 @ 1
initcall init_script_binfmt+0x0/0x30 returned 0 after 0 usecs
calling  init_elf_binfmt+0x0/0x30 @ 1
initcall init_elf_binfmt+0x0/0x30 returned 0 after 0 usecs
calling  debugfs_init+0x0/0x80 @ 1
initcall debugfs_init+0x0/0x80 returned 0 after 0 usecs
calling  prandom_init+0x0/0xf8 @ 1
initcall prandom_init+0x0/0xf8 returned 0 after 0 usecs
calling  sock_init+0x0/0xb0 @ 1
initcall sock_init+0x0/0xb0 returned 0 after 0 usecs
calling  netlink_proto_init+0x0/0x1d4 @ 1
NET: Registered protocol family 16
initcall netlink_proto_init+0x0/0x1d4 returned 0 after 3906 usecs
calling  bdi_class_init+0x0/0x74 @ 1
initcall bdi_class_init+0x0/0x74 returned 0 after 0 usecs
calling  kobject_uevent_init+0x0/0xc @ 1
initcall kobject_uevent_init+0x0/0xc returned 0 after 0 usecs
calling  gpiolib_sysfs_init+0x0/0xb8 @ 1
initcall gpiolib_sysfs_init+0x0/0xb8 returned 0 after 0 usecs
calling  pcibus_class_init+0x0/0x14 @ 1
initcall pcibus_class_init+0x0/0x14 returned 0 after 0 usecs
calling  pci_driver_init+0x0/0xc @ 1
initcall pci_driver_init+0x0/0xc returned 0 after 0 usecs
calling  tty_class_init+0x0/0x58 @ 1
initcall tty_class_init+0x0/0x58 returned 0 after 0 usecs
calling  vtconsole_class_init+0x0/0x104 @ 1
initcall vtconsole_class_init+0x0/0x104 returned 0 after 3906 usecs
calling  spi_init+0x0/0xa0 @ 1
initcall spi_init+0x0/0xa0 returned 0 after 0 usecs
calling  i2c_init+0x0/0x94 @ 1
initcall i2c_init+0x0/0x94 returned 0 after 0 usecs
calling  vdso_init+0x0/0x504 @ 1
initcall vdso_init+0x0/0x504 returned 0 after 0 usecs
calling  powerpc_debugfs_init+0x0/0x40 @ 1
initcall powerpc_debugfs_init+0x0/0x40 returned 0 after 0 usecs
calling  ppc_init+0x0/0x60 @ 1

initcall ppc_init+0x0/0x60 returned 0 after 3906 usecs
calling  setup_rstcr+0x0/0xdc @ 1
initcall setup_rstcr+0x0/0xdc returned 0 after 0 usecs
calling  of_add_fixed_phys+0x0/0xdc @ 1
initcall of_add_fixed_phys+0x0/0xdc returned 0 after 0 usecs
calling  fsl_pci_init+0x0/0x10 @ 1
initcall fsl_pci_init+0x0/0x10 returned 0 after 0 usecs
calling  __machine_initcall_p2041_rdb_swiotlb_setup_bus_notifier+0x0/0x24 @ 1
initcall __machine_initcall_p2041_rdb_swiotlb_setup_bus_notifier+0x0/0x24 returned 0 after 0 usecs
calling  __machine_initcall_p2041_rdb_corenet_ds_publish_devices+0x0/0x24 @ 1
initcall __machine_initcall_p2041_rdb_corenet_ds_publish_devices+0x0/0x24 returned 0 after 0 usecs
calling  __machine_initcall_p3041_ds_swiotlb_setup_bus_notifier+0x0/0x24 @ 1
initcall __machine_initcall_p3041_ds_swiotlb_setup_bus_notifier+0x0/0x24 returned 0 after 0 usecs
calling  __machine_initcall_p3041_ds_corenet_ds_publish_devices+0x0/0x24 @ 1
initcall __machine_initcall_p3041_ds_corenet_ds_publish_devices+0x0/0x24 returned 0 after 0 usecs
calling  __machine_initcall_p4080_ds_swiotlb_setup_bus_notifier+0x0/0x24 @ 1
initcall __machine_initcall_p4080_ds_swiotlb_setup_bus_notifier+0x0/0x24 returned 0 after 0 usecs
calling  __machine_initcall_p4080_ds_corenet_ds_publish_devices+0x0/0x24 @ 1
Found FSL PCI host bridge at 0x00000000fe200000. Firmware bus number: 0->5
PCI host bridge /pcie@fe200000 (primary) ranges:
 MEM 0x0000000080000000..0x000000009fffffff -> 0x0000000080000000
  IO 0x00000000f8000000..0x00000000f800ffff -> 0x0000000000000000
/pcie@fe200000: PCICSRBAR @ 0xff000000
initcall __machine_initcall_p4080_ds_corenet_ds_publish_devices+0x0/0x24 returned 0 after 19531 usecs
calling  __machine_initcall_p5020_ds_swiotlb_setup_bus_notifier+0x0/0x24 @ 1
initcall __machine_initcall_p5020_ds_swiotlb_setup_bus_notifier+0x0/0x24 returned 0 after 0 usecs
calling  __machine_initcall_p5020_ds_corenet_ds_publish_devices+0x0/0x24 @ 1
initcall __machine_initcall_p5020_ds_corenet_ds_publish_devices+0x0/0x24 returned 0 after 0 usecs
calling  __machine_initcall_p5040_ds_swiotlb_setup_bus_notifier+0x0/0x24 @ 1
initcall __machine_initcall_p5040_ds_swiotlb_setup_bus_notifier+0x0/0x24 returned 0 after 0 usecs
calling  __machine_initcall_p5040_ds_corenet_ds_publish_devices+0x0/0x24 @ 1
initcall __machine_initcall_p5040_ds_corenet_ds_publish_devices+0x0/0x24 returned 0 after 0 usecs
calling  mpc8xxx_add_gpiochips+0x0/0x20c @ 1
initcall mpc8xxx_add_gpiochips+0x0/0x20c returned 0 after 3906 usecs
calling  topology_init+0x0/0x110 @ 1
initcall topology_init+0x0/0x110 returned 0 after 3906 usecs
calling  swiotlb_late_init+0x0/0x58 @ 1
initcall swiotlb_late_init+0x0/0x58 returned 0 after 11718 usecs
calling  pcibios_init+0x0/0x114 @ 1
PCI: Probing PCI hardware
fsl-pci fe200000.pcie: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
pci_bus 0000:00: root bus resource [mem 0x80000000-0x9fffffff]
pci_bus 0000:00: root bus resource [bus 00-ff]
pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to ff
pci_bus 0000:00: scanning bus
pci 0000:00:00.0: [1957:0401] type 01 class 0x0b2000
pci 0000:00:00.0: ignoring class 0x0b2000 (doesn't match header type 01)
pci 0000:00:00.0: calling fixup_hide_host_resource_fsl+0x0/0x6c
calling  fixup_hide_host_resource_fsl+0x0/0x6c @ 1 for 0000:00:00.0
pci fixup fixup_hide_host_resource_fsl+0x0/0x6c returned after 0 usecs for 0000:00:00.0
pci 0000:00:00.0: calling pcibios_fixup_resources+0x0/0x128
calling  pcibios_fixup_resources+0x0/0x128 @ 1 for 0000:00:00.0
pci fixup pcibios_fixup_resources+0x0/0x128 returned after 0 usecs for 0000:00:00.0
pci 0000:00:00.0: calling quirk_fsl_pcie_header+0x0/0x84
calling  quirk_fsl_pcie_header+0x0/0x84 @ 1 for 0000:00:00.0
pci fixup quirk_fsl_pcie_header+0x0/0x84 returned after 0 usecs for 0000:00:00.0
pci 0000:00:00.0: supports D1 D2
pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:00.0: PME# disabled
pci 0000:00:00.0: scanning [bus 01-05] behind bridge, pass 0
pci 0000:00:00.0: check if busn 01-05 is in busn_res: [bus 00-ff]
pci_bus 0000:00: fixups for bus
pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
pci_bus 0000:01: busn_res: [bus 01-08] is updated under [bus 00-ff]
pci_bus 0000:01: scanning bus
pci_bus 0000:01: fixups for bus
pci 0000:00:00.0: PCI bridge to [bus 01-08]
pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
pci 0000:00:00.0:   bridge window [mem 0x80000000-0x801fffff]
pci_bus 0000:01: bus scan returning with max=01
pci_bus 0000:01: busn_res: [bus 01-08] end is updated to 01
pci_bus 0000:00: bus scan returning with max=01
pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 01
PCI 0000:00 Cannot reserve Legacy IO [io  0x0000-0x0fff]
pci 0000:00:00.0: PCI bridge to [bus 01]
pci 0000:00:00.0:   bridge window [io  0x0000-0xffff]
pci 0000:00:00.0:   bridge window [mem 0x80000000-0x9fffffff]
pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
pci_bus 0000:00: resource 5 [mem 0x80000000-0x9fffffff]
pci_bus 0000:01: resource 0 [io  0x0000-0xffff]
pci_bus 0000:01: resource 1 [mem 0x80000000-0x9fffffff]
initcall pcibios_init+0x0/0x114 returned 0 after 144531 usecs
calling  add_system_ram_resources+0x0/0xe8 @ 1
initcall add_system_ram_resources+0x0/0xe8 returned 0 after 0 usecs
calling  fsl_of_msi_init+0x0/0x10 @ 1
Setting up Freescale MSI support
Setting up Freescale MSI support
Setting up Freescale MSI support
initcall fsl_of_msi_init+0x0/0x10 returned 0 after 7812 usecs
calling  param_sysfs_init+0x0/0x1b4 @ 1
initcall param_sysfs_init+0x0/0x1b4 returned 0 after 11718 usecs
calling  pm_sysrq_init+0x0/0x30 @ 1
initcall pm_sysrq_init+0x0/0x30 returned 0 after 0 usecs
calling  default_bdi_init+0x0/0xa4 @ 1
initcall default_bdi_init+0x0/0xa4 returned 0 after 0 usecs
calling  init_bio+0x0/0x114 @ 1
bio: create slab <bio-0> at 0
initcall init_bio+0x0/0x114 returned 0 after 3906 usecs
calling  fsnotify_notification_init+0x0/0xa8 @ 1
initcall fsnotify_notification_init+0x0/0xa8 returned 0 after 0 usecs
calling  cryptomgr_init+0x0/0xc @ 1
initcall cryptomgr_init+0x0/0xc returned 0 after 0 usecs
calling  blk_settings_init+0x0/0x30 @ 1
initcall blk_settings_init+0x0/0x30 returned 0 after 0 usecs
calling  blk_ioc_init+0x0/0x44 @ 1
initcall blk_ioc_init+0x0/0x44 returned 0 after 0 usecs
calling  blk_softirq_init+0x0/0x90 @ 1
initcall blk_softirq_init+0x0/0x90 returned 0 after 0 usecs
calling  blk_iopoll_setup+0x0/0x90 @ 1
initcall blk_iopoll_setup+0x0/0x90 returned 0 after 0 usecs
calling  genhd_device_init+0x0/0x98 @ 1
initcall genhd_device_init+0x0/0x98 returned 0 after 0 usecs
calling  gpiolib_debugfs_init+0x0/0x44 @ 1
initcall gpiolib_debugfs_init+0x0/0x44 returned 0 after 0 usecs
calling  pci_slot_init+0x0/0x64 @ 1
initcall pci_slot_init+0x0/0x64 returned 0 after 0 usecs
calling  misc_init+0x0/0xe0 @ 1
initcall misc_init+0x0/0xe0 returned 0 after 0 usecs
calling  init_scsi+0x0/0xa4 @ 1
SCSI subsystem initialized
initcall init_scsi+0x0/0xa4 returned 0 after 3906 usecs
calling  ata_init+0x0/0x354 @ 1
libata version 3.00 loaded.
initcall ata_init+0x0/0x354 returned 0 after 3906 usecs
calling  phy_init+0x0/0x48 @ 1
initcall phy_init+0x0/0x48 returned 0 after 0 usecs
calling  usb_init+0x0/0x190 @ 1
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
initcall usb_init+0x0/0x190 returned 0 after 7812 usecs
calling  serio_init+0x0/0x4c @ 1
initcall serio_init+0x0/0x4c returned 0 after 0 usecs
calling  input_init+0x0/0x13c @ 1
initcall input_init+0x0/0x13c returned 0 after 0 usecs
calling  rtc_init+0x0/0x80 @ 1
initcall rtc_init+0x0/0x80 returned 0 after 0 usecs
calling  hwmon_init+0x0/0x64 @ 1
initcall hwmon_init+0x0/0x64 returned 0 after 0 usecs
calling  proto_init+0x0/0xc @ 1
initcall proto_init+0x0/0xc returned 0 after 0 usecs
calling  net_dev_init+0x0/0x1ec @ 1
initcall net_dev_init+0x0/0x1ec returned 0 after 0 usecs
calling  neigh_init+0x0/0xac @ 1
initcall neigh_init+0x0/0xac returned 0 after 0 usecs
calling  fib_rules_init+0x0/0xd8 @ 1
initcall fib_rules_init+0x0/0xd8 returned 0 after 0 usecs
calling  genl_init+0x0/0xa8 @ 1
initcall genl_init+0x0/0xa8 returned 0 after 0 usecs
calling  dma_init+0x0/0x8 @ 1
initcall dma_init+0x0/0x8 returned 0 after 0 usecs
calling  add_rtc+0x0/0x134 @ 1
initcall add_rtc+0x0/0x134 returned -19 after 0 usecs
calling  clocksource_done_booting+0x0/0x64 @ 1
Switched to clocksource timebase
initcall clocksource_done_booting+0x0/0x64 returned 0 after 2870 usecs
calling  init_pipe_fs+0x0/0x70 @ 1
initcall init_pipe_fs+0x0/0x70 returned 0 after 63 usecs
calling  eventpoll_init+0x0/0xe4 @ 1
initcall eventpoll_init+0x0/0xe4 returned 0 after 28 usecs
calling  anon_inode_init+0x0/0x80 @ 1
initcall anon_inode_init+0x0/0x80 returned 0 after 27 usecs
calling  blk_scsi_ioctl_init+0x0/0xc8 @ 1
initcall blk_scsi_ioctl_init+0x0/0xc8 returned 0 after 0 usecs
calling  chr_dev_init+0x0/0xf8 @ 1
initcall chr_dev_init+0x0/0xf8 returned 0 after 8229 usecs
calling  firmware_class_init+0x0/0x5c @ 1
initcall firmware_class_init+0x0/0x5c returned 0 after 86 usecs
calling  sysctl_core_init+0x0/0x44 @ 1
initcall sysctl_core_init+0x0/0x44 returned 0 after 19 usecs
calling  inet_init+0x0/0x2e0 @ 1
NET: Registered protocol family 2
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP: reno registered
UDP hash table entries: 512 (order: 2, 16384 bytes)
UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
initcall inet_init+0x0/0x2e0 returned 0 after 30198 usecs
calling  ipv4_offload_init+0x0/0x6c @ 1
initcall ipv4_offload_init+0x0/0x6c returned 0 after 0 usecs
calling  af_unix_init+0x0/0x70 @ 1
NET: Registered protocol family 1
initcall af_unix_init+0x0/0x70 returned 0 after 2986 usecs
calling  ipv6_offload_init+0x0/0x8c @ 1
initcall ipv6_offload_init+0x0/0x8c returned 0 after 1 usecs
calling  init_sunrpc+0x0/0x84 @ 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
initcall init_sunrpc+0x0/0x84 returned 0 after 16240 usecs
calling  pci_apply_final_quirks+0x0/0x134 @ 1
PCI: CLS 32 bytes, default 64
initcall pci_apply_final_quirks+0x0/0x134 returned 0 after 2626 usecs
calling  populate_rootfs+0x0/0x218 @ 1
Trying to unpack rootfs image as initramfs...
rootfs image is not initramfs (no cpio magic); looks like an initrd
Freeing initrd memory: 3676K (efc68000 - effff000)
initcall populate_rootfs+0x0/0x218 returned 0 after 25026 usecs
calling  register_powersave_nap_sysctl+0x0/0x2c @ 1
initcall register_powersave_nap_sysctl+0x0/0x2c returned 0 after 23 usecs
calling  rtc_init+0x0/0x7c @ 1
initcall rtc_init+0x0/0x7c returned -19 after 0 usecs
calling  serial_dev_init+0x0/0x16c @ 1
initcall serial_dev_init+0x0/0x16c returned 0 after 206 usecs
calling  audit_classes_init+0x0/0x6c @ 1
initcall audit_classes_init+0x0/0x6c returned 0 after 3 usecs
calling  fsl_lbc_init+0x0/0x10 @ 1
initcall fsl_lbc_init+0x0/0x10 returned 0 after 314 usecs
calling  proc_execdomains_init+0x0/0x40 @ 1
initcall proc_execdomains_init+0x0/0x40 returned 0 after 7 usecs
calling  ioresources_init+0x0/0x68 @ 1
initcall ioresources_init+0x0/0x68 returned 0 after 5 usecs
calling  uid_cache_init+0x0/0xbc @ 1
initcall uid_cache_init+0x0/0xbc returned 0 after 18 usecs
calling  init_posix_timers+0x0/0x1fc @ 1
initcall init_posix_timers+0x0/0x1fc returned 0 after 13 usecs
calling  init_posix_cpu_timers+0x0/0xe4 @ 1
initcall init_posix_cpu_timers+0x0/0xe4 returned 0 after 0 usecs
calling  init_sched_debug_procfs+0x0/0x50 @ 1
initcall init_sched_debug_procfs+0x0/0x50 returned 0 after 3 usecs
calling  timekeeping_init_ops+0x0/0x2c @ 1
initcall timekeeping_init_ops+0x0/0x2c returned 0 after 0 usecs
calling  init_clocksource_sysfs+0x0/0x98 @ 1
initcall init_clocksource_sysfs+0x0/0x98 returned 0 after 178 usecs
calling  init_timer_list_procfs+0x0/0x50 @ 1
initcall init_timer_list_procfs+0x0/0x50 returned 0 after 5 usecs
calling  alarmtimer_init+0x0/0x198 @ 1
initcall alarmtimer_init+0x0/0x198 returned 0 after 213 usecs
calling  clockevents_init_sysfs+0x0/0xf4 @ 1
initcall clockevents_init_sysfs+0x0/0xf4 returned 0 after 692 usecs
calling  futex_init+0x0/0x80 @ 1
initcall futex_init+0x0/0x80 returned 0 after 4 usecs
calling  proc_dma_init+0x0/0x40 @ 1
initcall proc_dma_init+0x0/0x40 returned 0 after 6 usecs
calling  proc_modules_init+0x0/0x44 @ 1
initcall proc_modules_init+0x0/0x44 returned 0 after 2 usecs
calling  kallsyms_init+0x0/0x44 @ 1
initcall kallsyms_init+0x0/0x44 returned 0 after 6 usecs
calling  crash_save_vmcoreinfo_init+0x0/0x438 @ 1
initcall crash_save_vmcoreinfo_init+0x0/0x438 returned 0 after 55 usecs
calling  crash_notes_memory_init+0x0/0x4c @ 1
initcall crash_notes_memory_init+0x0/0x4c returned 0 after 9 usecs
calling  ikconfig_init+0x0/0x64 @ 1
initcall ikconfig_init+0x0/0x64 returned 0 after 3 usecs
calling  audit_init+0x0/0x178 @ 1
audit: initializing netlink socket (disabled)
type=2000 audit(1.560:1): initialized
initcall audit_init+0x0/0x178 returned 0 after 7308 usecs
calling  hung_task_init+0x0/0x74 @ 1
initcall hung_task_init+0x0/0x74 returned 0 after 52 usecs
calling  rcutree_trace_init+0x0/0x1bc @ 1
initcall rcutree_trace_init+0x0/0x1bc returned 0 after 48 usecs
calling  utsname_sysctl_init+0x0/0x2c @ 1
initcall utsname_sysctl_init+0x0/0x2c returned 0 after 11 usecs
calling  perf_event_sysfs_init+0x0/0xb8 @ 1
initcall perf_event_sysfs_init+0x0/0xb8 returned 0 after 243 usecs
calling  init_per_zone_wmark_min+0x0/0xd4 @ 1
initcall init_per_zone_wmark_min+0x0/0xd4 returned 0 after 459 usecs
calling  kswapd_init+0x0/0x2c @ 1
initcall kswapd_init+0x0/0x2c returned 0 after 71 usecs
calling  setup_vmstat+0x0/0xe4 @ 1
initcall setup_vmstat+0x0/0xe4 returned 0 after 26 usecs
calling  mm_sysfs_init+0x0/0x48 @ 1
initcall mm_sysfs_init+0x0/0x48 returned 0 after 7 usecs
calling  mm_compute_batch_init+0x0/0x74 @ 1
initcall mm_compute_batch_init+0x0/0x74 returned 0 after 0 usecs
calling  slab_proc_init+0x0/0x44 @ 1
initcall slab_proc_init+0x0/0x44 returned 0 after 3 usecs
calling  init_reserve_notifier+0x0/0x8 @ 1
initcall init_reserve_notifier+0x0/0x8 returned 0 after 0 usecs
calling  init_admin_reserve+0x0/0x38 @ 1
initcall init_admin_reserve+0x0/0x38 returned 0 after 0 usecs
calling  init_user_reserve+0x0/0x38 @ 1
initcall init_user_reserve+0x0/0x38 returned 0 after 0 usecs
calling  proc_vmalloc_init+0x0/0x44 @ 1
initcall proc_vmalloc_init+0x0/0x44 returned 0 after 2 usecs
calling  memblock_init_debugfs+0x0/0x90 @ 1
initcall memblock_init_debugfs+0x0/0x90 returned 0 after 12 usecs
calling  init_emergency_pool+0x0/0x80 @ 1
bounce pool size: 64 pages
initcall init_emergency_pool+0x0/0x80 returned 0 after 2372 usecs
calling  procswaps_init+0x0/0x44 @ 1
initcall procswaps_init+0x0/0x44 returned 0 after 3 usecs
calling  slab_proc_init+0x0/0x8 @ 1
initcall slab_proc_init+0x0/0x8 returned 0 after 0 usecs
calling  cpucache_init+0x0/0x6c @ 1
initcall cpucache_init+0x0/0x6c returned 0 after 2 usecs
calling  fcntl_init+0x0/0x44 @ 1
initcall fcntl_init+0x0/0x44 returned 0 after 15 usecs
calling  proc_filesystems_init+0x0/0x40 @ 1
initcall proc_filesystems_init+0x0/0x40 returned 0 after 3 usecs
calling  dio_init+0x0/0x44 @ 1
initcall dio_init+0x0/0x44 returned 0 after 9 usecs
calling  fsnotify_mark_init+0x0/0x58 @ 1
initcall fsnotify_mark_init+0x0/0x58 returned 0 after 47 usecs
calling  dnotify_init+0x0/0x98 @ 1
initcall dnotify_init+0x0/0x98 returned 0 after 24 usecs
calling  inotify_user_setup+0x0/0x88 @ 1
initcall inotify_user_setup+0x0/0x88 returned 0 after 21 usecs
calling  aio_setup+0x0/0x78 @ 1
initcall aio_setup+0x0/0x78 returned 0 after 22 usecs
calling  proc_locks_init+0x0/0x44 @ 1
initcall proc_locks_init+0x0/0x44 returned 0 after 4 usecs
calling  init_mbcache+0x0/0x2c @ 1
initcall init_mbcache+0x0/0x2c returned 0 after 0 usecs
calling  proc_cmdline_init+0x0/0x40 @ 1
initcall proc_cmdline_init+0x0/0x40 returned 0 after 2 usecs
calling  proc_consoles_init+0x0/0x44 @ 1
initcall proc_consoles_init+0x0/0x44 returned 0 after 2 usecs
calling  proc_cpuinfo_init+0x0/0x40 @ 1
initcall proc_cpuinfo_init+0x0/0x40 returned 0 after 2 usecs
calling  proc_devices_init+0x0/0x44 @ 1
initcall proc_devices_init+0x0/0x44 returned 0 after 2 usecs
calling  proc_interrupts_init+0x0/0x44 @ 1
initcall proc_interrupts_init+0x0/0x44 returned 0 after 2 usecs
calling  proc_loadavg_init+0x0/0x40 @ 1
initcall proc_loadavg_init+0x0/0x40 returned 0 after 2 usecs
calling  proc_meminfo_init+0x0/0x40 @ 1
initcall proc_meminfo_init+0x0/0x40 returned 0 after 2 usecs
calling  proc_stat_init+0x0/0x40 @ 1
initcall proc_stat_init+0x0/0x40 returned 0 after 3 usecs
calling  proc_uptime_init+0x0/0x40 @ 1
initcall proc_uptime_init+0x0/0x40 returned 0 after 2 usecs
calling  proc_version_init+0x0/0x40 @ 1
initcall proc_version_init+0x0/0x40 returned 0 after 2 usecs
calling  proc_softirqs_init+0x0/0x40 @ 1
initcall proc_softirqs_init+0x0/0x40 returned 0 after 2 usecs
calling  proc_kcore_init+0x0/0x90 @ 1
initcall proc_kcore_init+0x0/0x90 returned 0 after 4 usecs
calling  proc_kmsg_init+0x0/0x40 @ 1
initcall proc_kmsg_init+0x0/0x40 returned 0 after 3 usecs
calling  proc_page_init+0x0/0x68 @ 1
initcall proc_page_init+0x0/0x68 returned 0 after 5 usecs
calling  init_devpts_fs+0x0/0x84 @ 1
initcall init_devpts_fs+0x0/0x84 returned 0 after 46 usecs
calling  init_ext3_fs+0x0/0x98 @ 1
initcall init_ext3_fs+0x0/0x98 returned 0 after 25 usecs
calling  init_ext2_fs+0x0/0x88 @ 1
initcall init_ext2_fs+0x0/0x88 returned 0 after 13 usecs
calling  journal_init+0x0/0xe8 @ 1
initcall journal_init+0x0/0xe8 returned 0 after 40 usecs
calling  init_cramfs_fs+0x0/0x4c @ 1
initcall init_cramfs_fs+0x0/0x4c returned 0 after 14 usecs
calling  init_ramfs_fs+0x0/0xc @ 1
initcall init_ramfs_fs+0x0/0xc returned 0 after 1 usecs
calling  init_fat_fs+0x0/0x6c @ 1
initcall init_fat_fs+0x0/0x6c returned 0 after 27 usecs
calling  init_vfat_fs+0x0/0xc @ 1
initcall init_vfat_fs+0x0/0xc returned 0 after 1 usecs
calling  init_msdos_fs+0x0/0xc @ 1
initcall init_msdos_fs+0x0/0xc returned 0 after 1 usecs
calling  init_iso9660_fs+0x0/0xa0 @ 1
initcall init_iso9660_fs+0x0/0xa0 returned 0 after 17 usecs
calling  init_nfs_fs+0x0/0x158 @ 1
initcall init_nfs_fs+0x0/0x158 returned 0 after 172 usecs
calling  init_nfs_v2+0x0/0x2c @ 1
initcall init_nfs_v2+0x0/0x2c returned 0 after 0 usecs
calling  init_nfs_v3+0x0/0x2c @ 1
initcall init_nfs_v3+0x0/0x2c returned 0 after 0 usecs
calling  init_nfs_v4+0x0/0x54 @ 1
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
initcall init_nfs_v4+0x0/0x54 returned 0 after 9089 usecs
calling  init_nfsd+0x0/0x10c @ 1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
initcall init_nfsd+0x0/0x10c returned 0 after 4971 usecs
calling  init_nlm+0x0/0x64 @ 1
initcall init_nlm+0x0/0x64 returned 0 after 8 usecs
calling  init_nls_iso8859_1+0x0/0xc @ 1
initcall init_nls_iso8859_1+0x0/0xc returned 0 after 0 usecs
calling  init_nls_utf8+0x0/0x2c @ 1
initcall init_nls_utf8+0x0/0x2c returned 0 after 0 usecs
calling  init_ntfs_fs+0x0/0x200 @ 1
NTFS driver 2.1.30 [Flags: R/O].
initcall init_ntfs_fs+0x0/0x200 returned 0 after 2940 usecs
calling  init_jffs2_fs+0x0/0xe4 @ 1
jffs2: version 2.2. (NAND) © 2001-2006 Red Hat, Inc.
initcall init_jffs2_fs+0x0/0xe4 returned 0 after 4805 usecs
calling  init_udf_fs+0x0/0x88 @ 1
initcall init_udf_fs+0x0/0x88 returned 0 after 10 usecs
calling  ipc_init+0x0/0x38 @ 1
msgmni has been set to 1487
initcall ipc_init+0x0/0x38 returned 0 after 2461 usecs
calling  ipc_sysctl_init+0x0/0x2c @ 1
initcall ipc_sysctl_init+0x0/0x2c returned 0 after 12 usecs
calling  init_mqueue_fs+0x0/0xcc @ 1
initcall init_mqueue_fs+0x0/0xcc returned 0 after 60 usecs
calling  key_proc_init+0x0/0x58 @ 1
initcall key_proc_init+0x0/0x58 returned 0 after 5 usecs
calling  crypto_wq_init+0x0/0x50 @ 1
initcall crypto_wq_init+0x0/0x50 returned 0 after 66 usecs
calling  crypto_algapi_init+0x0/0x24 @ 1
initcall crypto_algapi_init+0x0/0x24 returned 0 after 4 usecs
calling  skcipher_module_init+0x0/0x54 @ 1
initcall skcipher_module_init+0x0/0x54 returned 0 after 0 usecs
calling  chainiv_module_init+0x0/0xc @ 1
initcall chainiv_module_init+0x0/0xc returned 0 after 1 usecs
calling  eseqiv_module_init+0x0/0xc @ 1
initcall eseqiv_module_init+0x0/0xc returned 0 after 0 usecs
calling  hmac_module_init+0x0/0xc @ 1
initcall hmac_module_init+0x0/0xc returned 0 after 0 usecs
calling  crypto_null_mod_init+0x0/0x68 @ 1
initcall crypto_null_mod_init+0x0/0x68 returned 0 after 219 usecs
calling  md4_mod_init+0x0/0xc @ 1
initcall md4_mod_init+0x0/0xc returned 0 after 64 usecs
calling  md5_mod_init+0x0/0xc @ 1
initcall md5_mod_init+0x0/0xc returned 0 after 52 usecs
calling  sha1_generic_mod_init+0x0/0xc @ 1
initcall sha1_generic_mod_init+0x0/0xc returned 0 after 50 usecs
calling  sha256_generic_mod_init+0x0/0x10 @ 1
initcall sha256_generic_mod_init+0x0/0x10 returned 0 after 100 usecs
calling  sha512_generic_mod_init+0x0/0x10 @ 1
initcall sha512_generic_mod_init+0x0/0x10 returned 0 after 100 usecs
calling  crypto_cbc_module_init+0x0/0xc @ 1
initcall crypto_cbc_module_init+0x0/0xc returned 0 after 1 usecs
calling  crypto_pcbc_module_init+0x0/0xc @ 1
initcall crypto_pcbc_module_init+0x0/0xc returned 0 after 0 usecs
calling  des_generic_mod_init+0x0/0x10 @ 1
initcall des_generic_mod_init+0x0/0x10 returned 0 after 98 usecs
calling  aes_init+0x0/0xc @ 1
initcall aes_init+0x0/0xc returned 0 after 53 usecs
calling  deflate_mod_init+0x0/0xc @ 1
initcall deflate_mod_init+0x0/0xc returned 0 after 51 usecs
calling  crc32c_mod_init+0x0/0xc @ 1
initcall crc32c_mod_init+0x0/0xc returned 0 after 51 usecs
calling  crypto_authenc_module_init+0x0/0xc @ 1
initcall crypto_authenc_module_init+0x0/0xc returned 0 after 0 usecs
calling  crypto_authenc_esn_module_init+0x0/0xc @ 1
initcall crypto_authenc_esn_module_init+0x0/0xc returned 0 after 0 usecs
calling  krng_mod_init+0x0/0xc @ 1
initcall krng_mod_init+0x0/0xc returned 0 after 54 usecs
calling  proc_genhd_init+0x0/0x68 @ 1
initcall proc_genhd_init+0x0/0x68 returned 0 after 11 usecs
calling  noop_init+0x0/0xc @ 1
io scheduler noop registered
initcall noop_init+0x0/0xc returned 0 after 2553 usecs
calling  deadline_init+0x0/0xc @ 1
io scheduler deadline registered
initcall deadline_init+0x0/0xc returned 0 after 2886 usecs
calling  cfq_init+0x0/0xa8 @ 1
io scheduler cfq registered (default)
initcall cfq_init+0x0/0xa8 returned 0 after 3311 usecs
calling  libcrc32c_mod_init+0x0/0x50 @ 1
initcall libcrc32c_mod_init+0x0/0x50 returned 0 after 4 usecs
calling  percpu_counter_startup+0x0/0x48 @ 1
initcall percpu_counter_startup+0x0/0x48 returned 0 after 0 usecs
calling  pci_proc_init+0x0/0x94 @ 1
initcall pci_proc_init+0x0/0x94 returned 0 after 15 usecs
calling  pcie_portdrv_init+0x0/0x94 @ 1
initcall pcie_portdrv_init+0x0/0x94 returned 0 after 224 usecs
calling  aer_service_init+0x0/0x44 @ 1
initcall aer_service_init+0x0/0x44 returned 0 after 79 usecs
calling  pty_init+0x0/0x248 @ 1
initcall pty_init+0x0/0x248 returned 0 after 138 usecs
calling  sysrq_init+0x0/0x110 @ 1
initcall sysrq_init+0x0/0x110 returned 0 after 11 usecs
calling  serial8250_init+0x0/0x1b0 @ 1
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0xfe11c500 (irq = 36) is a 16550A
console [ttyS0] enabled, bootconsole disabled
console [ttyS0] enabled, bootconsole disabled
serial8250.0: ttyS1 at MMIO 0xfe11c600 (irq = 36) is a 16550A
serial8250.0: ttyS2 at MMIO 0xfe11d500 (irq = 37) is a 16550A
serial8250.0: ttyS3 at MMIO 0xfe11d600 (irq = 37) is a 16550A
initcall serial8250_init+0x0/0x1b0 returned 0 after 36130 usecs
calling  serial_pci_driver_init+0x0/0x18 @ 1
initcall serial_pci_driver_init+0x0/0x18 returned 0 after 105 usecs
calling  ehv_bc_init+0x0/0x1a4 @ 1
ePAPR hypervisor byte channel driver
initcall ehv_bc_init+0x0/0x1a4 returned -19 after 3320 usecs
calling  rand_initialize+0x0/0x48 @ 1
initcall rand_initialize+0x0/0x48 returned 0 after 31 usecs
calling  nvram_init+0x0/0x6c @ 1
Generic non-volatile memory driver v1.1
initcall nvram_init+0x0/0x6c returned 0 after 3619 usecs
calling  topology_sysfs_init+0x0/0x90 @ 1
initcall topology_sysfs_init+0x0/0x90 returned 0 after 80 usecs
calling  brd_init+0x0/0x1ec @ 1
brd: module loaded
initcall brd_init+0x0/0x1ec returned 0 after 6182 usecs
calling  loop_init+0x0/0x160 @ 1
loop: module loaded
initcall loop_init+0x0/0x160 returned 0 after 4294 usecs
calling  at24_init+0x0/0x60 @ 1
initcall at24_init+0x0/0x60 returned 0 after 80 usecs
calling  spi_transport_init+0x0/0xb0 @ 1
initcall spi_transport_init+0x0/0xb0 returned 0 after 136 usecs
calling  sym2_init+0x0/0x134 @ 1
initcall sym2_init+0x0/0x134 returned 0 after 102 usecs
calling  init_st+0x0/0x1a8 @ 1
st: Version 20101219, fixed bufsize 32768, s/g segs 256
initcall init_st+0x0/0x1a8 returned 0 after 4989 usecs
calling  init_sd+0x0/0x1a8 @ 1
initcall init_sd+0x0/0x1a8 returned 0 after 172 usecs
calling  init_sr+0x0/0x68 @ 1
initcall init_sr+0x0/0x68 returned 0 after 72 usecs
calling  init_sg+0x0/0x158 @ 1
initcall init_sg+0x0/0x158 returned 0 after 98 usecs
calling  sil24_pci_driver_init+0x0/0x18 @ 1
initcall sil24_pci_driver_init+0x0/0x18 returned 0 after 94 usecs
calling  init_mtd+0x0/0x118 @ 1
initcall init_mtd+0x0/0x118 returned 0 after 447 usecs
calling  ofpart_parser_init+0x0/0x5c @ 1
initcall ofpart_parser_init+0x0/0x5c returned 0 after 0 usecs
calling  cmdline_parser_init+0x0/0x24 @ 1
initcall cmdline_parser_init+0x0/0x24 returned 0 after 0 usecs
calling  init_mtdblock+0x0/0xc @ 1
initcall init_mtdblock+0x0/0xc returned 0 after 2 usecs
calling  cfi_probe_init+0x0/0x2c @ 1
initcall cfi_probe_init+0x0/0x2c returned 0 after 0 usecs
calling  of_flash_driver_init+0x0/0x10 @ 1
ee000000.flash: Found 1 x16 devices at 0x0 in 16-bit bank. Manufacturer ID 0x000089 Chip ID 0x00891f
Intel/Sharp Extended Query Table at 0x010A
Intel/Sharp Extended Query Table at 0x010A
Intel/Sharp Extended Query Table at 0x010A
Intel/Sharp Extended Query Table at 0x010A
Intel/Sharp Extended Query Table at 0x010A
Using buffer write method
Using auto-unlock on power-up/resume
cfi_cmdset_0001: Erase suspend on write enabled
erase region 0: offset=0x0,size=0x20000,blocks=255
erase region 1: offset=0x1fe0000,size=0x8000,blocks=4
initcall of_flash_driver_init+0x0/0x10 returned 0 after 48398 usecs
calling  m25p80_driver_init+0x0/0xc @ 1
initcall m25p80_driver_init+0x0/0xc returned 0 after 76 usecs
calling  fsl_espi_driver_init+0x0/0x10 @ 1
fsl_espi fe110000.spi: master is unqueued, this is deprecated
fsl_espi fe110000.spi: at 0xf10c2000 (irq = 53)
initcall fsl_espi_driver_init+0x0/0x10 returned 0 after 9939 usecs
calling  fsl_spi_init+0x0/0x10 @ 1
initcall fsl_spi_init+0x0/0x10 returned 0 after 172 usecs
calling  spi_gpio_driver_init+0x0/0x10 @ 1
initcall spi_gpio_driver_init+0x0/0x10 returned 0 after 151 usecs
calling  net_olddevs_init+0x0/0x90 @ 1
initcall net_olddevs_init+0x0/0x90 returned 0 after 8 usecs
calling  vsc82xx_init+0x0/0x10 @ 1
initcall vsc82xx_init+0x0/0x10 returned 0 after 278 usecs
calling  fixed_mdio_bus_init+0x0/0x114 @ 1
libphy: Fixed MDIO Bus: probed
initcall fixed_mdio_bus_init+0x0/0x114 returned 0 after 2921 usecs
calling  mdio_mux_gpio_driver_init+0x0/0x10 @ 1
initcall mdio_mux_gpio_driver_init+0x0/0x10 returned 0 after 173 usecs
calling  mdio_mux_mmioreg_driver_init+0x0/0x10 @ 1
initcall mdio_mux_mmioreg_driver_init+0x0/0x10 returned 0 after 149 usecs
calling  fsl_pq_mdio_driver_init+0x0/0x10 @ 1
initcall fsl_pq_mdio_driver_init+0x0/0x10 returned 0 after 149 usecs
calling  xgmac_mdio_driver_init+0x0/0x10 @ 1
initcall xgmac_mdio_driver_init+0x0/0x10 returned 0 after 149 usecs
calling  cdrom_init+0x0/0x3c @ 1
initcall cdrom_init+0x0/0x3c returned 0 after 10 usecs
calling  ehci_hcd_init+0x0/0xb8 @ 1
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
initcall ehci_hcd_init+0x0/0xb8 returned 0 after 5252 usecs
calling  ehci_pci_init+0x0/0x90 @ 1
ehci-pci: EHCI PCI platform driver
initcall ehci_pci_init+0x0/0x90 returned 0 after 3154 usecs
calling  i8042_init+0x0/0x120 @ 1
initcall i8042_init+0x0/0x120 returned -19 after 116 usecs
calling  serport_init+0x0/0x4c @ 1
initcall serport_init+0x0/0x4c returned 0 after 0 usecs
calling  cmos_init+0x0/0x60 @ 1
initcall cmos_init+0x0/0x60 returned -19 after 224 usecs
calling  ds1307_driver_init+0x0/0x10 @ 1
initcall ds1307_driver_init+0x0/0x10 returned 0 after 78 usecs
calling  ds3232_driver_init+0x0/0x10 @ 1
initcall ds3232_driver_init+0x0/0x10 returned 0 after 71 usecs
calling  rx8581_driver_init+0x0/0x10 @ 1
initcall rx8581_driver_init+0x0/0x10 returned 0 after 70 usecs
calling  i2c_dev_init+0x0/0xec @ 1
i2c /dev entries driver
initcall i2c_dev_init+0x0/0xec returned 0 after 2202 usecs
calling  mpc_i2c_driver_init+0x0/0x10 @ 1
mpc-i2c fe118100.i2c: timeout 1000000 us
at24 0-0054: 32768 byte 24c256 EEPROM, writable, 1 bytes/write
rtc-rx8581 0-0051: chip found, driver version 0.1
rtc-rx8581 0-0051: Unable to read device flags
rtc-rx8581 0-0051: rtc core: registered rtc-rx8581 as rtc0
mpc-i2c fe118000.i2c: timeout 1000000 us
mpc-i2c fe119000.i2c: timeout 1000000 us
mpc-i2c fe119100.i2c: timeout 1000000 us
initcall mpc_i2c_driver_init+0x0/0x10 returned 0 after 35747 usecs
calling  lm75_driver_init+0x0/0x10 @ 1
lm75 0-0057: hwmon0: sensor 'lm75'
initcall lm75_driver_init+0x0/0x10 returned 0 after 3709 usecs
calling  lm90_driver_init+0x0/0x10 @ 1
initcall lm90_driver_init+0x0/0x10 returned 0 after 85 usecs
calling  caam_driver_init+0x0/0x10 @ 1
initcall caam_driver_init+0x0/0x10 returned 0 after 178 usecs
calling  caam_algapi_init+0x0/0x27c @ 1
initcall caam_algapi_init+0x0/0x27c returned -19 after 104 usecs
calling  caam_algapi_hash_init+0x0/0x1a4 @ 1
initcall caam_algapi_hash_init+0x0/0x1a4 returned -19 after 81 usecs
calling  caam_rng_init+0x0/0x160 @ 1
initcall caam_rng_init+0x0/0x160 returned -19 after 81 usecs
calling  hid_init+0x0/0x6c @ 1
initcall hid_init+0x0/0x6c returned 0 after 114 usecs
calling  hid_generic_init+0x0/0x18 @ 1
initcall hid_generic_init+0x0/0x18 returned 0 after 87 usecs
calling  hid_init+0x0/0x70 @ 1
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
initcall hid_init+0x0/0x70 returned 0 after 6737 usecs
calling  staging_init+0x0/0x8 @ 1
initcall staging_init+0x0/0x8 returned 0 after 0 usecs
calling  fsl_hypervisor_init+0x0/0x360 @ 1
Freescale hypervisor management driver
fsl-hv: no hypervisor found
initcall fsl_hypervisor_init+0x0/0x360 returned -19 after 5893 usecs
calling  sock_diag_init+0x0/0xc @ 1
initcall sock_diag_init+0x0/0xc returned 0 after 14 usecs
calling  flow_cache_init_global+0x0/0x1b4 @ 1
initcall flow_cache_init_global+0x0/0x1b4 returned 0 after 53 usecs
calling  sysctl_ipv4_init+0x0/0xc4 @ 1
initcall sysctl_ipv4_init+0x0/0xc4 returned 0 after 71 usecs
calling  ipip_init+0x0/0xb4 @ 1
ipip: IPv4 over IPv4 tunneling driver
initcall ipip_init+0x0/0xb4 returned 0 after 3721 usecs
calling  ah4_init+0x0/0x94 @ 1
initcall ah4_init+0x0/0x94 returned 0 after 1 usecs
calling  esp4_init+0x0/0x90 @ 1
initcall esp4_init+0x0/0x90 returned 0 after 0 usecs
calling  ipcomp4_init+0x0/0x90 @ 1
initcall ipcomp4_init+0x0/0x90 returned 0 after 0 usecs
calling  ipip_init+0x0/0xdc @ 1
initcall ipip_init+0x0/0xdc returned 0 after 1 usecs
calling  xfrm4_beet_init+0x0/0x10 @ 1
initcall xfrm4_beet_init+0x0/0x10 returned 0 after 0 usecs
calling  tunnel4_init+0x0/0x90 @ 1
initcall tunnel4_init+0x0/0x90 returned 0 after 0 usecs
calling  xfrm4_transport_init+0x0/0x10 @ 1
initcall xfrm4_transport_init+0x0/0x10 returned 0 after 0 usecs
calling  xfrm4_mode_tunnel_init+0x0/0x10 @ 1
initcall xfrm4_mode_tunnel_init+0x0/0x10 returned 0 after 0 usecs
calling  inet_diag_init+0x0/0xa4 @ 1
initcall inet_diag_init+0x0/0xa4 returned 0 after 1 usecs
calling  tcp_diag_init+0x0/0xc @ 1
initcall tcp_diag_init+0x0/0xc returned 0 after 0 usecs
calling  cubictcp_register+0x0/0xa0 @ 1
TCP: cubic registered
initcall cubictcp_register+0x0/0xa0 returned 0 after 1959 usecs
calling  xfrm_user_init+0x0/0x68 @ 1
Initializing XFRM netlink socket
initcall xfrm_user_init+0x0/0x68 returned 0 after 2898 usecs
calling  inet6_init+0x0/0x2c8 @ 1
NET: Registered protocol family 10
initcall inet6_init+0x0/0x2c8 returned 0 after 3498 usecs
calling  xfrm6_transport_init+0x0/0x10 @ 1
initcall xfrm6_transport_init+0x0/0x10 returned 0 after 0 usecs
calling  xfrm6_mode_tunnel_init+0x0/0x10 @ 1
initcall xfrm6_mode_tunnel_init+0x0/0x10 returned 0 after 0 usecs
calling  xfrm6_beet_init+0x0/0x10 @ 1
initcall xfrm6_beet_init+0x0/0x10 returned 0 after 0 usecs
calling  sit_init+0x0/0xf0 @ 1
sit: IPv6 over IPv4 tunneling driver
initcall sit_init+0x0/0xf0 returned 0 after 3678 usecs
calling  packet_init+0x0/0x60 @ 1
NET: Registered protocol family 17
initcall packet_init+0x0/0x60 returned 0 after 3077 usecs
calling  ipsec_pfkey_init+0x0/0xa0 @ 1
NET: Registered protocol family 15
initcall ipsec_pfkey_init+0x0/0xa0 returned 0 after 3071 usecs
calling  init_rpcsec_gss+0x0/0x94 @ 1
initcall init_rpcsec_gss+0x0/0x94 returned 0 after 21 usecs
calling  sctp_init+0x0/0x534 @ 1
sctp: Hash tables configured (established 65536 bind 65536)
initcall sctp_init+0x0/0x534 returned 0 after 6472 usecs
calling  init_dns_resolver+0x0/0x128 @ 1
Key type dns_resolver registered
initcall init_dns_resolver+0x0/0x128 returned 0 after 2910 usecs
calling  kexec_setup+0x0/0x158 @ 1
initcall kexec_setup+0x0/0x158 returned 0 after 12 usecs
calling  init_oops_id+0x0/0x5c @ 1
initcall init_oops_id+0x0/0x5c returned 0 after 4 usecs
calling  sched_init_debug+0x0/0x40 @ 1
initcall sched_init_debug+0x0/0x40 returned 0 after 9 usecs
calling  pm_qos_power_init+0x0/0x7c @ 1
initcall pm_qos_power_init+0x0/0x7c returned 0 after 375 usecs
calling  printk_late_init+0x0/0x84 @ 1
initcall printk_late_init+0x0/0x84 returned 0 after 0 usecs
calling  tk_debug_sleep_time_init+0x0/0x58 @ 1
initcall tk_debug_sleep_time_init+0x0/0x58 returned 0 after 7 usecs
calling  prandom_reseed+0x0/0xc8 @ 1
initcall prandom_reseed+0x0/0xc8 returned 0 after 48 usecs
calling  pci_resource_alignment_sysfs_init+0x0/0x14 @ 1
initcall pci_resource_alignment_sysfs_init+0x0/0x14 returned 0 after 4 usecs
calling  pci_sysfs_init+0x0/0x70 @ 1
initcall pci_sysfs_init+0x0/0x70 returned 0 after 21 usecs
calling  random_int_secret_init+0x0/0x34 @ 1
initcall random_int_secret_init+0x0/0x34 returned 0 after 18 usecs
calling  deferred_probe_initcall+0x0/0x84 @ 1
initcall deferred_probe_initcall+0x0/0x84 returned 0 after 95 usecs
calling  rtc_hctosys+0x0/0x11c @ 1
rtc-rx8581 0-0051: Unable to read device flags
rtc-rx8581 0-0051: hctosys: unable to read the hardware clock
initcall rtc_hctosys+0x0/0x11c returned -5 after 9595 usecs
calling  tcp_congestion_default+0x0/0xc @ 1
initcall tcp_congestion_default+0x0/0xc returned 0 after 1 usecs
calling  tcp_fastopen_init+0x0/0x38 @ 1
initcall tcp_fastopen_init+0x0/0x38 returned 0 after 24 usecs
calling  ip_auto_config+0x0/0x1020 @ 1
initcall ip_auto_config+0x0/0x1020 returned -19 after 11763116 usecs
calling  clk_disable_unused+0x0/0xf4 @ 1
initcall clk_disable_unused+0x0/0xf4 returned 0 after 1 usecs
calling  initialize_hashrnd+0x0/0x30 @ 1
initcall initialize_hashrnd+0x0/0x30 returned 0 after 7 usecs
async_waiting @ 1
async_continuing @ 1 after 0 usec
RAMDISK: gzip image found at block 0
kjournald starting.  Commit interval 5 seconds
EXT3-fs (ram0): using internal journal
EXT3-fs (ram0): mounted filesystem with writeback data mode
VFS: Mounted root (ext3 filesystem) on device 1:0.
async_waiting @ 1
async_continuing @ 1 after 0 usec
Freeing unused kernel memory: 240K (c060c000 - c0648000)
INIT: version 2.88 booting
Starting udev
Starting Bootlog daemon: bootlogd: cannot allocate pseudo tty: No such file or directory
bootlogd.
Configuring network interfaces... ifconfig: SIOCGIFFLAGS: No such device
ifconfig: SIOCSIFADDR: No such device
route: SIOCADDRT: No such device
rtc-rx8581 0-0051: Unable to read device flags
hwclock: RTC_RD_TIME: Input/output error
Fri Dec 14 13:17:00 UTC 2012
rtc-rx8581 0-0051: Unable to read control register
hwclock: RTC_SETrtc-rx8581 0-0051: Unable to read device flags
_TIME: Input/outINIT: Entering runlevel: 5
rtc-rx8581 0-0051: Unable to read device flags
hwclock: RTC_RD_TIME: Input/output error
Starting syslogd/klogd: done
Stopping Bootlog daemon: bootlogd.

ELDK 5.3 generic-powerpc ttyS0

generic-powerpc login: root
root@generic-powerpc:~# lspci
00:00.0 PCI bridge: Freescale Semiconductor Inc P4080 (rev 20)
root@generic-powerpc:~# echo 1 > /sys/bus/pci/rescan
pci_bus 0000:00: scanning bus
pcieport 0000:00:00.0: scanning [bus 01-01] behind bridge, pass 0
pcieport 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
pcieport 0000:00:00.0: rescan scaned bridge as broken one again ?
pci_bus 0000:00: bus scan returning with max=00
root@generic-powerpc:~# lspci
00:00.0 PCI bridge: Freescale Semiconductor Inc P4080 (rev 20)
root@generic-powerpc:~# ~.Connected.
Connected.

Disconnected.

---snip---

As far as I can see with my layman's eyes is, it finds the subordinate busses
1-5 behind the bridge but then somehow looses them again in the enumeration
phase.

Thanks,
Johannes
