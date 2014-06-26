Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2lp0210.outbound.protection.outlook.com ([207.46.163.210]:31469
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753333AbaFZFuK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 26 Jun 2014 01:50:10 -0400
Date: Thu, 26 Jun 2014 13:49:38 +0800
From: Shawn Guo <shawn.guo@freescale.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <r65037@freescale.com>,
	Marek =?utf-8?B?VmHFoXV0?= <marex@denx.de>,
	David =?iso-8859-1?Q?M=FCller_=28ELSOFT_AG=29?=
	<d.mueller@elsoft.ch>, Sascha Hauer <kernel@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Tim Harvey <tharvey@gateworks.com>,
	"Fabio Estevam" <fabio.estevam@freescale.com>
Subject: Re: [RFC] PCI: pci-imx6: Add delay to workaround kernel hang
Message-ID: <20140626054937.GB7859@dragon>
References: <1403637507-9424-1-git-send-email-festevam@gmail.com>
 <20140626031247.GN2224@dragon>
 <CAOMZO5A0pQfJRwb41046UpkbG6xH7c+EVu+YuY71Zuyq5gHaDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CAOMZO5A0pQfJRwb41046UpkbG6xH7c+EVu+YuY71Zuyq5gHaDA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 26, 2014 at 12:43:19AM -0300, Fabio Estevam wrote:
> On Thu, Jun 26, 2014 at 12:12 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
> > On Tue, Jun 24, 2014 at 04:18:27PM -0300, Fabio Estevam wrote:
> >> From: Fabio Estevam <fabio.estevam@freescale.com>
> >>
> >> When the mx6 PCI conctroller is initialized in the bootloader we see a kernel
> >> hang inside imx6_add_pcie_port().
> >>
> >> Adding a 30ms delay allows the kernel to boot.
> >
> > We may not want to add a random delay into the driver before we
> > understand the root cause of the issue.
> 
> Yes, that's why I sent this as RFC and also explained it below the ---
> line that I am actually trying to get some help with this issue.
> 
> >
> > Do you see this issue with FSL kernel?
> 
> Yes, it also hangs.
> 
> It is reproducible in 100% of the boots. Just need to use mainline
> U-boot (which has PCI driver enabled by default).
> I am using an Intel Wifi 7260 PCI card. This was also reported by
> other folks in the U-boot list.

Richard,

Can you schedule some time to look at this issue?  I think it will come
to us sooner or later if any our customer enables PCIe before launching
kernel?

Shawn

> 
> Below is the log with linux-next kernel and earlyprintk enabled:
> 
> U-Boot 2014.07-rc1-15766-g5f46552 (Jun 24 2014 - 17:41:55)
> 
> CPU:   Freescale i.MX6Q rev1.2 at 792 MHz
> Reset cause: POR
> Board: MX6-SabreSD
> I2C:   ready
> DRAM:  1 GiB
> MMC:   FSL_SDHC: 0, FSL_SDHC: 1, FSL_SDHC: 2
>   00:01.0     - 16c3:abcd - Bridge device
>    01:00.0    - 8086:08b1 - Network controller
> No panel detected: default to Hannstar-XGA
> Display: Hannstar-XGA (1024x768)
> In:    serial
> Out:   serial
> Err:   serial
> PMIC:  PFUZE100 ID=0x10
> Net:   FEC [PRIME]
> Hit any key to stop autoboot:  0
> Booting from net ...
> FEC Waiting for PHY auto negotiation to complete.. done
> Using FEC device
> TFTP from server 192.168.0.2; our IP address is 192.168.0.8
> Filename 'zImage'.
> Load address: 0x12000000
> Loading: #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #############################################################
>          1.7 MiB/s
> done
> Bytes transferred = 5302272 (50e800 hex)
> Using FEC device
> TFTP from server 192.168.0.2; our IP address is 192.168.0.8
> Filename 'imx6q-sabresd.dtb'.
> Load address: 0x18000000
> Loading: #######
>          1.5 MiB/s
> done
> Bytes transferred = 33744 (83d0 hex)
> Kernel image @ 0x12000000 [ 0x000000 - 0x50e800 ]
> ## Flattened Device Tree blob at 18000000
>    Booting using the fdt blob at 0x18000000
>    Using Device Tree in place at 18000000, end 1800b3cf
> 
> Starting kernel ...
> 
> Uncompressing Linux... done, booting the kernel.
> Booting Linux on physical CPU 0x0
> Linux version 3.16.0-rc2-next-20140625 (fabio@fabio-Latitude-E6410)
> (gcc version 4.7.3 (Ubuntu/Linaro 4.7.3-1ubuntu1) ) #1440 SMP Thu
> Jun 26 00:38:33 BRT 2014
> CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c5387d
> CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> Machine model: Freescale i.MX6 Quad SABRE Smart Device Board
> bootconsole [earlycon0] enabled
> cma: Reserved 16 MiB at 4f000000
> Memory policy: Data cache writealloc
> PERCPU: Embedded 8 pages/cpu @be7a6000 s8896 r8192 d15680 u32768
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260096
> Kernel command line: console=ttymxc0,115200 root=/dev/nfs ip=dhcp
> nfsroot=192.168.0.2:/tftpboot/rfs,v3,tcp earlyprintk
> PID hash table entries: 4096 (order: 2, 16384 bytes)
> Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Memory: 1004880K/1048576K available (6579K kernel code, 406K rwdata,
> 2264K rodata, 340K init, 8331K bss, 43696K reserved, 0K highmem)
> Virtual kernel memory layout:
>     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>     fixmap  : 0xffc00000 - 0xffe00000   (2048 kB)
>     vmalloc : 0xc0800000 - 0xff000000   (1000 MB)
>     lowmem  : 0x80000000 - 0xc0000000   (1024 MB)
>     pkmap   : 0x7fe00000 - 0x80000000   (   2 MB)
>     modules : 0x7f000000 - 0x7fe00000   (  14 MB)
>       .text : 0x80008000 - 0x808aafbc   (8844 kB)
>       .init : 0x808ab000 - 0x809002c0   ( 341 kB)
>       .data : 0x80902000 - 0x80967a40   ( 407 kB)
>        .bss : 0x80967a48 - 0x8118aa10   (8332 kB)
> SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
> Hierarchical RCU implementation.
> NR_IRQS:16 nr_irqs:16 16
> L2C-310 erratum 769419 enabled
> L2C-310 enabling early BRESP for Cortex-A9
> L2C-310 full line of zeros enabled for Cortex-A9
> L2C-310 ID prefetch enabled, offset 1 lines
> L2C-310 dynamic clock gating enabled, standby mode enabled
> L2C-310 cache controller enabled, 16 ways, 1024 kB
> L2C-310: CACHE_ID 0x410000c7, AUX_CTRL 0x76070001
> Switching to timer-based delay loop, resolution 15ns
> sched_clock: 32 bits at 66MHz, resolution 15ns, wraps every 65075262448ns
> Console: colour dummy device 80x30
> Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
> ... MAX_LOCKDEP_SUBCLASSES:  8
> ... MAX_LOCK_DEPTH:          48
> ... MAX_LOCKDEP_KEYS:        8191
> ... CLASSHASH_SIZE:          4096
> ... MAX_LOCKDEP_ENTRIES:     32768
> ... MAX_LOCKDEP_CHAINS:      65536
> ... CHAINHASH_SIZE:          32768
>  memory used by lock dependency info: 5167 kB
>  per task-struct memory footprint: 1152 bytes
> Calibrating delay loop (skipped), value calculated using timer
> frequency.. 132.00 BogoMIPS (lpj=660000)
> pid_max: default: 32768 minimum: 301
> Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
> Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
> CPU: Testing write buffer coherency: ok
> CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> Setting up static identity map for 0x10672328 - 0x10672398
> CPU1: Booted secondary processor
> CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
> CPU2: Booted secondary processor
> CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
> CPU3: Booted secondary processor
> CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
> Brought up 4 CPUs
> SMP: Total of 4 processors activated.
> CPU: All CPU(s) started in SVC mode.
> devtmpfs: initialized
> VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
> pinctrl core: initialized pinctrl subsystem
> regulator-dummy: no parameters
> NET: Registered protocol family 16
> DMA: preallocated 256 KiB pool for atomic coherent allocations
> CPU identified as i.MX6Q, silicon rev 1.2
> vdd1p1: 800 <--> 1375 mV at 1100 mV
> vdd3p0: 2800 <--> 3150 mV at 3000 mV
> vdd2p5: 2000 <--> 2750 mV at 2400 mV
> vddarm: 725 <--> 1450 mV at 1100 mV
> vddpu: 725 <--> 1450 mV at 1100 mV
> vddsoc: 725 <--> 1450 mV at 1175 mV
> hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint registers.
> hw-breakpoint: maximum watchpoint size is 4 bytes.
> imx6q-pinctrl 20e0000.iomuxc: initialized IMX pinctrl driver
> mxs-dma 110000.dma-apbh: initialized
> usb_otg_vbus: 5000 mV
> usb_h1_vbus: 5000 mV
> wm8962-supply: no parameters
> vgaarb: loaded
> SCSI subsystem initialized
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> i2c i2c-0: IMX I2C adapter registered
> i2c i2c-1: IMX I2C adapter registered
> i2c i2c-2: IMX I2C adapter registered
> Linux video capture interface: v2.00
> pps_core: LinuxPPS API ver. 1 registered
> pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti
> <giometti@linux.it>
> PTP clock support registered
> Advanced Linux Sound Architecture Driver Initialized.
> cfg80211: Calling CRDA to update world regulatory domain
> Switched to clocksource mxc_timer1
