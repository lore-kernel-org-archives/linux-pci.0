Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 9 May 2017 08:34:39 +0200
From: Peter Senna Tschudin <peter.senna@collabora.com>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: Regression: 442ec4c04d1: PCI: dwc: all: Split struct pcie_port
 into host-only and core structures
Message-ID: <20170509063439.GC9791@collabora.com>
References: <20170508150224.GA7458@collabora.com>
 <CAOMZO5DjFxAus3B03Om0xoqxKuY2TkbcjCY1YEUK9s_R8C_DNA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOMZO5DjFxAus3B03Om0xoqxKuY2TkbcjCY1YEUK9s_R8C_DNA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jesper Nilsson <jesper.nilsson@axis.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 Richard Zhu <hongxing.zhu@nxp.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Jingoo Han <jingoohan1@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Pratyush Anand <pratyush.anand@gmail.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Kishon Vijay Abraham I <kishon@ti.com>,
 Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Murali Karicheri <m-karicheri2@ti.com>,
 Niklas Cassel <niklas.cassel@axis.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Mingkai Hu <mingkai.hu@freescale.com>, Roy Zang <tie-fei.zang@freescale.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 08, 2017 at 10:30:13PM -0300, Fabio Estevam wrote:
> Hi Peter,
> 
> On Mon, May 8, 2017 at 12:02 PM, Peter Senna Tschudin
> <peter.senna@collabora.com> wrote:
> > Hello Kishon,
> >
> > Our iMX6 hardware (imx6q-b850v3.dts) is not booting with latest
> > linux-next and I could bisect until:
> >
> > commit 442ec4c04d1235f8c664a74004dae54a7a574d18
> > Author: Kishon Vijay Abraham I <kishon@ti.com>
> > Date:   Wed Feb 15 18:48:14 2017 +0530
> >
> >     PCI: dwc: all: Split struct pcie_port into host-only and core structures
> 
> I can reproduce the same problem on a custom imx6q board with a PCI bridge chip.
> 
> Other mx6 boards without PCI bridge boot fine.
> 
> I haven't bisected it, but the problem for me does not happen on 4.11.
> It happens only in linux-next.
> 
> The commit you mentioned above is from 4.11 and does not cause the
> problem on my tests.
> 
> Can you double check if you really have issues with 4.11?

Something that ocurred to me is that u-boot is initializing the PCI, and
the PCI networkd cards.  Ideally this should not affect anything, but
can this be related to the issue?

	U-Boot 2017.01 (Mar 29 2017 - 13:13:19 +0100)

	CPU:   Freescale i.MX6D rev1.5 at 792 MHz
	Reset cause: POR
	BOARD: General Electric B850v3
	I2C:   ready
	DRAM:  2 GiB
	MMC:   FSL_SDHC: 0, FSL_SDHC: 1, FSL_SDHC: 2
	SF: Detected n25q32 with page size 256 Bytes, erase size 4 KiB, total 4 MiB
	PCI:
	  00:01.0     - 16c3:abcd - Bridge device
	   01:00.0    - 10b5:8605 - Bridge device
	    02:01.0   - 10b5:8605 - Bridge device
	     03:00.0  - 8086:1533 - Network controller
	    02:02.0   - 10b5:8605 - Bridge device
	     04:00.0  - 8086:1533 - Network controller
	    02:03.0   - 10b5:8605 - Bridge device
	In:    serial
	Out:   serial
	Err:   serial
	Net:   e1000: 00:a0:c9:00:00:00
	       e1000: 00:40:97:29:04:44
	       e1000#0, e1000#1, FEC [PRIME]


It works fine with v4.10, but I have a similar problem on v4.11
(a351e9b9fc24e982ec2f0e76379a49826036da12), but it is not the same.
Similar as that system freezes on PCI initialization:

	Starting kernel ...

	Uncompressing Linux... done, booting the kernel.
	[    0.000000] Booting Linux on physical CPU 0x0
	[    0.000000] Linux version 4.11.0-dirty (peter@lenovo-peter.home) (gcc version 6.1.1 20160621 (Red Hat Cross 6.1.1-2) (GCC) ) #1
	...
	[    0.437377] PCI: CLS 0 bytes, default 64
	[    0.442000] hw perfevents: enabled with armv7_cortex_a9 PMU driver, 7 counters available
	[    0.450394] audit: initializing netlink subsys (disabled)
	[    0.454974] audit: type=2000 audit(0.420:1): state=initialized audit_enabled=0 res=1
	[    0.455546] workingset: timestamp_bits=30 max_order=19 bucket_order=0
	[    0.474842] bounce: pool size: 64 pages
	[    0.475825] io scheduler noop registered
	[    0.479762] io scheduler deadline registered
	[    0.484151] io scheduler cfq registered (default)
	[    0.488699] io scheduler mq-deadline registered
	[    0.494867] OF: PCI: host bridge /soc/pcie@0x01000000 ranges:
	[    0.498969] OF: PCI:   No bus range found for /soc/pcie@0x01000000, using [bus 00-ff]
	[    0.506847] OF: PCI:    IO 0x01f80000..0x01f8ffff -> 0x00000000
	[    0.512737] OF: PCI:   MEM 0x01000000..0x01efffff -> 0x01000000

	It freezes here...

But is different as this patch makes the the system to boot:

diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
index 801e46c..a562c14 100644
--- a/drivers/pci/dwc/pci-imx6.c
+++ b/drivers/pci/dwc/pci-imx6.c
@@ -523,6 +523,7 @@ static void imx6_pcie_host_init(struct pcie_port *pp)
 {
        struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
        struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
+       printk(KERN_ERR "DEBUG: %s\n", __func__);

        imx6_pcie_assert_core_reset(imx6_pcie);
        imx6_pcie_init_phy(imx6_pcie);

I'm using CONFIG_EARLY_PRINTK (and a few others that are needed on iMX6
in order to enable early_printk), and the patch only makes my system
boot if 'earlycon loglevel=15' is passed to kernel. Here is full output
with v4.11 with the patch applied, and with 'earlycon loglevel=15'
passed to kernel, with the "[    0.520080] DEBUG: imx6_pcie_host_init "
message:

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.11.0-dirty (peter@lenovo-peter.home) (gcc version 6.1.1 20160621 (Red Hat Cross 6.1.1-2) (GCC) ) #137 SMP Tue7
[    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] OF: fdt: Machine model: General Electric B850v3
[    0.000000] earlycon: ec_imx21 at MMIO 0x021ec000 (options '')
[    0.000000] bootconsole [ec_imx21] enabled
[    0.000000] cma: Reserved 128 MiB at 0x88000000
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] On node 0 totalpages: 524288
[    0.000000] free_area_init_node: node 0, pgdat 80d72000, node_mem_map eeff7000
[    0.000000]   Normal zone: 3584 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 458752 pages, LIFO batch:31
[    0.000000]   HighMem zone: 65536 pages, LIFO batch:15
[    0.000000] percpu: Embedded 17 pages/cpu @eefb3000 s37132 r8192 d24308 u69632
[    0.000000] pcpu-alloc: s37132 r8192 d24308 u69632 alloc=17*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 520704
[    0.000000] Kernel command line: root=/dev/mmcblk0p2 ro rootwait cma=128M video=DP-1:1024x768@60 video=HDMI-A-1:1024x768@60 earlycon logl0
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes)
[    0.000000] Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Memory: 1934692K/2097152K available (8192K kernel code, 489K rwdata, 2184K rodata, 1024K init, 301K bss, 31388K reserved, 131)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
[    0.000000]     lowmem  : 0x80000000 - 0xf0000000   (1792 MB)
[    0.000000]     pkmap   : 0x7fe00000 - 0x80000000   (   2 MB)
[    0.000000]     modules : 0x7f000000 - 0x7fe00000   (  14 MB)
[    0.000000]       .text : 0x80008000 - 0x80900000   (9184 kB)
[    0.000000]       .init : 0x80c00000 - 0x80d00000   (1024 kB)
[    0.000000]       .data : 0x80d00000 - 0x80d7a79c   ( 490 kB)
[    0.000000]        .bss : 0x80d7c000 - 0x80dc77e0   ( 302 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU debugfs-based tracing is enabled.
[    0.000000]  Build-time adjustment of leaf fanout to 32.
[    0.000000]  RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=2
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] L2C-310 errata 752271 769419 enabled
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
[    0.000000] L2C-310 ID prefetch enabled, offset 16 lines
[    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
[    0.000000] L2C-310 cache controller enabled, 16 ways, 1024 kB
[    0.000000] L2C-310: CACHE_ID 0x410000c7, AUX_CTRL 0x76470001
[    0.000000] Switching to timer-based delay loop, resolution 333ns
[    0.000008] sched_clock: 32 bits at 3000kHz, resolution 333ns, wraps every 715827882841ns
[    0.008183] clocksource: mxc_timer1: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 637086815595 ns
[    0.019540] Console: colour dummy device 80x30
[    0.022282] Calibrating delay loop (skipped), value calculated using timer frequency.. 6.00 BogoMIPS (lpj=30000)
[    0.032462] pid_max: default: 32768 minimum: 301
[    0.037162] Mount-cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.043760] Mountpoint-cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.051479] CPU: Testing write buffer coherency: ok
[    0.055764] ftrace: allocating 26500 entries in 78 pages
[    0.110144] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.113341] Setting up static identity map for 0x10100000 - 0x1010004c
[    0.120205] smp: Bringing up secondary CPUs ...
[    0.124674] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.124766] smp: Brought up 1 node, 2 CPUs
[    0.133750] SMP: Total of 2 processors activated (12.00 BogoMIPS).
[    0.139937] CPU: All CPU(s) started in SVC mode.
[    0.145503] devtmpfs: initialized
[    0.157365] VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
[    0.162338] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.172047] futex hash table entries: 512 (order: 3, 32768 bytes)
[    0.183864] pinctrl core: initialized pinctrl subsystem
[    0.187242] NET: Registered protocol family 16
[    0.192540] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.198685] CPU identified as i.MX6Q, silicon rev 1.5
[    0.218293] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint registers.
[    0.223452] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.230096] imx6q-pinctrl 20e0000.iomuxc: initialized IMX pinctrl driver
[    0.255639] mxs-dma 110000.dma-apbh: initialized
[    0.260025] vgaarb: loaded
[    0.260478] SCSI subsystem initialized
[    0.264013] libata version 3.00 loaded.
[    0.267925] usbcore: registered new interface driver usbfs
[    0.273201] usbcore: registered new interface driver hub
[    0.278526] usbcore: registered new device driver usb
[    0.284555] i2c i2c-0: IMX I2C adapter registered
[    0.288233] i2c i2c-0: can't use DMA, using PIO instead.
[    0.293892] i2c i2c-1: IMX I2C adapter registered
[    0.298233] i2c i2c-1: can't use DMA, using PIO instead.
[    0.303993] i2c i2c-2: IMX I2C adapter registered
[    0.308237] i2c i2c-2: can't use DMA, using PIO instead.
[    0.313626] pps_core: LinuxPPS API ver. 1 registered
[    0.318494] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.327642] PTP clock support registered
[    0.331780] Advanced Linux Sound Architecture Driver Initialized.
[    0.339544] clocksource: Switched to clocksource mxc_timer1
[    0.398977] NET: Registered protocol family 2
[    0.401102] TCP established hash table entries: 16384 (order: 4, 65536 bytes)
[    0.407750] TCP bind hash table entries: 16384 (order: 5, 131072 bytes)
[    0.414493] TCP: Hash tables configured (established 16384 bind 16384)
[    0.420897] UDP hash table entries: 1024 (order: 3, 32768 bytes)
[    0.426824] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes)
[    0.433424] NET: Registered protocol family 1
[    0.437568] PCI: CLS 0 bytes, default 64
[    0.442188] hw perfevents: enabled with armv7_cortex_a9 PMU driver, 7 counters available
[    0.450574] audit: initializing netlink subsys (disabled)
[    0.455158] audit: type=2000 audit(0.420:1): state=initialized audit_enabled=0 res=1
[    0.455748] workingset: timestamp_bits=30 max_order=19 bucket_order=0
[    0.474988] bounce: pool size: 64 pages
[    0.475970] io scheduler noop registered
[    0.479908] io scheduler deadline registered
[    0.484295] io scheduler cfq registered (default)
[    0.488843] io scheduler mq-deadline registered
[    0.495021] OF: PCI: host bridge /soc/pcie@0x01000000 ranges:
[    0.499114] OF: PCI:   No bus range found for /soc/pcie@0x01000000, using [bus 00-ff]
[    0.506994] OF: PCI:    IO 0x01f80000..0x01f8ffff -> 0x00000000
[    0.512884] OF: PCI:   MEM 0x01000000..0x01efffff -> 0x01000000
[    0.520080] DEBUG: imx6_pcie_host_init
[    0.739622] imx6q-pcie 1ffc000.pcie: link up
[    0.741037] imx6q-pcie 1ffc000.pcie: Link: Gen2 disabled
[    0.746343] imx6q-pcie 1ffc000.pcie: link up
[    0.750634] imx6q-pcie 1ffc000.pcie: Link up, Gen1
[    0.755502] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
[    0.761681] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.767140] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.773337] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
[    0.780203] pci_bus 0000:00: scanning bus
[    0.784213] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
[    0.790231] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
[    0.796466] pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
[    0.803207] pci 0000:00:00.0: calling pci_fixup_ide_bases+0x0/0x58
[    0.809376] pci 0000:00:00.0: supports D1
[    0.813356] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
[    0.819704] pci 0000:00:00.0: PME# disabled
[    0.824013] pci_bus 0000:00: fixups for bus
[    0.828040] PCI: bus0: Fast back to back transfers disabled
[    0.833630] pci 0000:00:00.0: scanning [bus 01-01] behind bridge, pass 0
[    0.840401] pci_bus 0000:01: scanning bus
[    0.844398] pci 0000:01:00.0: [10b5:8605] type 01 class 0x060400
[    0.850414] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff]
[    0.856750] pci 0000:01:00.0: calling pci_fixup_ide_bases+0x0/0x58
[    0.863193] pci 0000:01:00.0: supports D1 D2
[    0.867013] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.873659] pci 0000:01:00.0: PME# disabled
[    0.899642] pci_bus 0000:01: fixups for bus
[    0.901016] PCI: bus1: Fast back to back transfers disabled
[    0.906547] pci 0000:01:00.0: scanning [bus 00-00] behind bridge, pass 0
[    0.913262] pci 0000:01:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    0.921302] pci 0000:01:00.0: scanning [bus 00-00] behind bridge, pass 1
[    0.928187] pci_bus 0000:02: busn_res: can not insert [bus 02-ff] under [bus 01] (conflicts with (null) [bus 01])
[    0.938232] pci_bus 0000:02: scanning bus
[    0.942325] pci 0000:02:01.0: [10b5:8605] type 01 class 0x060400
[    0.948485] pci 0000:02:01.0: calling pci_fixup_ide_bases+0x0/0x58
[    0.954818] pci 0000:02:01.0: supports D1 D2
[    0.958651] pci 0000:02:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.965296] pci 0000:02:01.0: PME# disabled
[    0.969765] pci 0000:02:02.0: [10b5:8605] type 01 class 0x060400
[    0.975712] pci 0000:02:02.0: calling pci_fixup_ide_bases+0x0/0x58
[    0.982049] pci 0000:02:02.0: supports D1 D2
[    0.985882] pci 0000:02:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.992528] pci 0000:02:02.0: PME# disabled
[    0.996985] pci 0000:02:03.0: [10b5:8605] type 01 class 0x060400
[    1.002967] pci 0000:02:03.0: calling pci_fixup_ide_bases+0x0/0x58
[    1.009258] pci 0000:02:03.0: supports D1 D2
[    1.013133] pci 0000:02:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.019755] pci 0000:02:03.0: PME# disabled
[    1.024378] pci_bus 0000:02: fixups for bus
[    1.028215] PCI: bus2: Fast back to back transfers disabled
[    1.033683] pci 0000:02:01.0: scanning [bus 00-00] behind bridge, pass 0
[    1.040362] pci 0000:02:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    1.048392] pci 0000:02:02.0: scanning [bus 00-00] behind bridge, pass 0
[    1.055062] pci 0000:02:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    1.063105] pci 0000:02:03.0: scanning [bus 00-00] behind bridge, pass 0
[    1.069765] pci 0000:02:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    1.077795] pci 0000:02:01.0: scanning [bus 00-00] behind bridge, pass 1
[    1.084718] pci_bus 0000:03: scanning bus
[    1.088565] pci 0000:03:00.0: [8086:1533] type 00 class 0x020000
[    1.094522] pci 0000:03:00.0: calling quirk_f0_vpd_link+0x0/0x7c
[    1.100548] pci 0000:03:00.0: reg 0x10: [mem 0x00000000-0x0007ffff]
[    1.106815] pci 0000:03:00.0: reg 0x18: [io  0x0000-0x001f]
[    1.112357] pci 0000:03:00.0: reg 0x1c: [mem 0x00000000-0x00003fff]
[    1.118750] pci 0000:03:00.0: calling pci_fixup_ide_bases+0x0/0x58
[    1.125155] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    1.130857] pci 0000:03:00.0: PME# disabled
[    1.135562] pci_bus 0000:03: fixups for bus
[    1.139210] PCI: bus3: Fast back to back transfers disabled
[    1.144776] pci_bus 0000:03: bus scan returning with max=03
[    1.150336] pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
[    1.156938] pci_bus 0000:03: [bus 03] partially hidden behind bridge 0000:01 [bus 01]
[    1.164796] pci 0000:02:02.0: scanning [bus 00-00] behind bridge, pass 1
[    1.171735] pci_bus 0000:04: scanning bus
[    1.175565] pci 0000:04:00.0: [8086:1533] type 00 class 0x020000
[    1.181520] pci 0000:04:00.0: calling quirk_f0_vpd_link+0x0/0x7c
[    1.187529] pci 0000:04:00.0: reg 0x10: [mem 0x00000000-0x0007ffff]
[    1.193834] pci 0000:04:00.0: reg 0x18: [io  0x0000-0x001f]
[    1.199338] pci 0000:04:00.0: reg 0x1c: [mem 0x00000000-0x00003fff]
[    1.205769] pci 0000:04:00.0: calling pci_fixup_ide_bases+0x0/0x58
[    1.212155] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
[    1.217841] pci 0000:04:00.0: PME# disabled
[    1.222581] pci_bus 0000:04: fixups for bus
[    1.226209] PCI: bus4: Fast back to back transfers disabled
[    1.231765] pci_bus 0000:04: bus scan returning with max=04
[    1.237315] pci_bus 0000:04: busn_res: [bus 04-ff] end is updated to 04
[    1.243953] pci_bus 0000:04: [bus 04] partially hidden behind bridge 0000:01 [bus 01]
[    1.251789] pci 0000:02:03.0: scanning [bus 00-00] behind bridge, pass 1
[    1.258703] pci_bus 0000:05: scanning bus
[    1.262487] pci_bus 0000:05: fixups for bus
[    1.266629] PCI: bus5: Fast back to back transfers enabled
[    1.272130] pci_bus 0000:05: bus scan returning with max=05
[    1.277681] pci_bus 0000:05: busn_res: [bus 05-ff] end is updated to 05
[    1.284320] pci_bus 0000:05: [bus 05] partially hidden behind bridge 0000:01 [bus 01]
[    1.292152] pci_bus 0000:02: bus scan returning with max=05
[    1.297691] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 05
[    1.304324] pci_bus 0000:02: busn_res: can not insert [bus 02-05] under [bus 01] (conflicts with (null) [bus 01])
[    1.314596] pci_bus 0000:02: [bus 02-05] partially hidden behind bridge 0000:01 [bus 01]
[    1.322685] pci_bus 0000:01: bus scan returning with max=05
[    1.328228] pci 0000:00:00.0: bridge has subordinate 01 but max busn 05
[    1.334860] pci 0000:00:00.0: scanning [bus 01-01] behind bridge, pass 1
[    1.341557] pci_bus 0000:00: bus scan returning with max=01
[    1.347194] pci 0000:00:00.0: fixup irq: got 333
[    1.351742] pci 0000:00:00.0: assigning IRQ 333
[    1.356282] pci 0000:01:00.0: fixup irq: got 333
[    1.360872] pci 0000:01:00.0: assigning IRQ 333
[    1.365472] pci 0000:02:01.0: fixup irq: got 334
[    1.370010] pci 0000:02:01.0: assigning IRQ 334
[    1.374625] pci 0000:02:02.0: fixup irq: got 335
[    1.379122] pci 0000:02:02.0: assigning IRQ 335
[    1.383734] pci 0000:02:03.0: fixup irq: got 23
[    1.388169] pci 0000:02:03.0: assigning IRQ 23
[    1.392674] pci 0000:03:00.0: fixup irq: got 334
[    1.397217] pci 0000:03:00.0: assigning IRQ 334
[    1.401814] pci 0000:04:00.0: fixup irq: got 335
[    1.406352] pci 0000:04:00.0: assigning IRQ 335
[    1.411140] pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
[    1.417670] pci 0000:00:00.0: BAR 8: assigned [mem 0x01100000-0x014fffff]
[    1.424482] pci 0000:00:00.0: BAR 9: assigned [mem 0x01500000-0x016fffff pref]
[    1.431694] pci 0000:00:00.0: BAR 6: assigned [mem 0x01700000-0x0170ffff pref]
[    1.438895] pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x2fff]
[    1.445006] pci 0000:01:00.0: BAR 8: assigned [mem 0x01100000-0x013fffff]
[    1.451787] pci 0000:01:00.0: BAR 9: assigned [mem 0x01500000-0x016fffff 64bit pref]
[    1.459513] pci 0000:01:00.0: BAR 0: assigned [mem 0x01400000-0x01403fff]
[    1.466335] pci 0000:01:00.0: BAR 7: assigned [io  0x1000-0x2fff]
[    1.472411] pci 0000:02:01.0: BAR 8: assigned [mem 0x01100000-0x012fffff]
[    1.479176] pci 0000:02:01.0: BAR 9: assigned [mem 0x01500000-0x016fffff 64bit pref]
[    1.486935] pci 0000:02:02.0: BAR 8: assigned [mem 0x01300000-0x013fffff]
[    1.493721] pci 0000:02:01.0: BAR 7: assigned [io  0x1000-0x1fff]
[    1.499811] pci 0000:02:02.0: BAR 7: assigned [io  0x2000-0x2fff]
[    1.505887] pci 0000:03:00.0: BAR 0: assigned [mem 0x01100000-0x0117ffff]
[    1.512707] pci 0000:03:00.0: BAR 3: assigned [mem 0x01180000-0x01183fff]
[    1.519476] pci 0000:03:00.0: BAR 2: assigned [io  0x1000-0x101f]
[    1.525582] pci 0000:02:01.0: PCI bridge to [bus 03]
[    1.530529] pci 0000:02:01.0:   bridge window [io  0x1000-0x1fff]
[    1.536618] pci 0000:02:01.0:   bridge window [mem 0x01100000-0x012fffff]
[    1.543414] pci 0000:02:01.0:   bridge window [mem 0x01500000-0x016fffff 64bit pref]
[    1.551182] pci 0000:04:00.0: BAR 0: assigned [mem 0x01300000-0x0137ffff]
[    1.557930] pci 0000:04:00.0: BAR 3: assigned [mem 0x01380000-0x01383fff]
[    1.564734] pci 0000:04:00.0: BAR 2: assigned [io  0x2000-0x201f]
[    1.570820] pci 0000:02:02.0: PCI bridge to [bus 04]
[    1.575751] pci 0000:02:02.0:   bridge window [io  0x2000-0x2fff]
[    1.581873] pci 0000:02:02.0:   bridge window [mem 0x01300000-0x013fffff]
[    1.588667] pci 0000:02:03.0: PCI bridge to [bus 05]
[    1.593666] pci 0000:01:00.0: PCI bridge to [bus 02-05]
[    1.598806] pci 0000:01:00.0:   bridge window [io  0x1000-0x2fff]
[    1.604929] pci 0000:01:00.0:   bridge window [mem 0x01100000-0x013fffff]
[    1.611706] pci 0000:01:00.0:   bridge window [mem 0x01500000-0x016fffff 64bit pref]
[    1.619447] pci 0000:00:00.0: PCI bridge to [bus 01]
[    1.624393] pci 0000:00:00.0:   bridge window [io  0x1000-0x2fff]
[    1.630483] pci 0000:00:00.0:   bridge window [mem 0x01100000-0x014fffff]
[    1.637253] pci 0000:00:00.0:   bridge window [mem 0x01500000-0x016fffff pref]
[    1.644791] pcieport 0000:00:00.0: AER enabled with IRQ 301
[    1.650209] pcieport 0000:01:00.0: enabling device (0140 -> 0143)
[    1.656268] pcieport 0000:01:00.0: enabling bus mastering
[    1.662189] pcieport 0000:02:01.0: enabling device (0140 -> 0143)
[    1.667758] pcieport 0000:02:01.0: enabling bus mastering
[    1.673719] pcieport 0000:02:02.0: enabling device (0140 -> 0143)
[    1.679224] pcieport 0000:02:02.0: enabling bus mastering
[    1.685282] pcieport 0000:02:03.0: enabling bus mastering
[    1.690510] pci 0000:03:00.0: calling quirk_e100_interrupt+0x0/0x1f0
[    1.696266] pci 0000:04:00.0: calling quirk_e100_interrupt+0x0/0x1f0
[    1.703545] pwm-backlight backlight: backlight supply power not found, using dummy regulator
[    1.715529] imx-sdma 20ec000.sdma: loaded firmware 1.1
[    1.716036] 21ec000.serial: ttymxc2 at MMIO 0x21ec000 (irq = 69, base_baud = 5000000) is a IMX
[    1.729342] console [ttymxc2] enabled
[    1.729342] console [ttymxc2] enabled
[    1.733831] bootconsole [ec_imx21] disabled
[    1.733831] bootconsole [ec_imx21] disabled
[    1.742658] 21f0000.serial: ttymxc3 at MMIO 0x21f0000 (irq = 70, base_baud = 5000000) is a IMX
[    1.758535] etnaviv gpu-subsystem: bound 134000.gpu (ops 0x80947af8)
[    1.764948] etnaviv gpu-subsystem: bound 130000.gpu (ops 0x80947af8)
[    1.771335] etnaviv gpu-subsystem: bound 2204000.gpu (ops 0x80947af8)
[    1.777790] etnaviv-gpu 134000.gpu: model: GC320, revision: 5007
[    1.831594] etnaviv-gpu 130000.gpu: model: GC2000, revision: 5108
[    1.882155] etnaviv-gpu 2204000.gpu: model: GC355, revision: 1215
[    1.888267] etnaviv-gpu 2204000.gpu: Ignoring GPU with VG and FE2.0
[    1.894967] [drm] Initialized etnaviv 1.0.0 20151214 for gpu-subsystem on minor 0
[    1.903627] imx-ipuv3 2400000.ipu: IPUv3H probed
[    1.909122] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    1.915760] [drm] No driver support for vblank timestamp query.
[    1.921800] imx-drm display-subsystem: bound imx-ipuv3-crtc.2 (ops 0x80940bcc)
[    1.929124] imx-drm display-subsystem: bound imx-ipuv3-crtc.3 (ops 0x80940bcc)
[    1.936466] imx-drm display-subsystem: bound imx-ipuv3-crtc.6 (ops 0x80940bcc)
[    1.943796] imx-drm display-subsystem: bound imx-ipuv3-crtc.7 (ops 0x80940bcc)
[    1.951176] imx-drm display-subsystem: failed to bind 120000.hdmi (ops 0x80940d44): -517
[    1.959381] imx-drm display-subsystem: master bind failed: -517
[    1.965349] imx-ipuv3 2800000.ipu: IPUv3H probed
[    1.978695] brd: module loaded
[    1.988614] loop: module loaded
[    1.998057] da9063 2-0058: Device detected (chip-ID: 0x61, var-ID: 0x60)
[    2.030150] DA9063_BCORE1: Bringing 1380000uV into 1420000-1420000uV
[    2.043622] DA9063_BCORE2: Bringing 1380000uV into 1420000-1420000uV
[    2.058022] random: fast init done
[    2.063364] DA9063_BMEM: Bringing 1500000uV into 1800000-1800000uV
[    2.076596] DA9063_BIO: Bringing 3160000uV into 1800000-1800000uV
[    2.117375] ahci-imx 2200000.sata: fsl,transmit-level-mV not specified, using 00000024
[    2.125344] ahci-imx 2200000.sata: fsl,transmit-boost-mdB not specified, using 00000480
[    2.133373] ahci-imx 2200000.sata: fsl,transmit-atten-16ths not specified, using 00002000
[    2.141574] ahci-imx 2200000.sata: fsl,receive-eq-mdB not specified, using 05000000
[    2.152094] ahci-imx 2200000.sata: SSS flag set, parallel bus scan disabled
[    2.159086] ahci-imx 2200000.sata: AHCI 0001.0300 32 slots 1 ports 3 Gbps 0x1 impl platform mode
[    2.167913] ahci-imx 2200000.sata: flags: ncq sntf stag pm led clo only pmp pio slum part ccc apst
[    2.178159] scsi host0: ahci-imx
[    2.181635] ata1: SATA max UDMA/133 mmio [mem 0x02200000-0x02203fff] port 0x100 irq 73
[    2.192873] m25p80 spi0.0: n25q032 (4096 Kbytes)
[    2.197522] 3 ofpart partitions found on MTD device spi0.0
[    2.203048] Creating 3 MTD partitions on "spi0.0":
[    2.207850] 0x000000000000-0x0000000c0000 : "U-Boot"
[    2.213778] 0x0000000c0000-0x0000000d0000 : "env"
[    2.219365] 0x0000000d0000-0x000000200000 : "spare"
[    2.225192] spi_imx 2008000.ecspi: probed
[    2.230736] at25 spi4.0: 32 KByte at25 eeprom, pagesize 64
[    2.236247] spi_imx 2018000.ecspi: probed
[    2.241083] libphy: Fixed MDIO Bus: probed
[    2.246101] fec 2188000.ethernet: 2188000.ethernet supply phy not found, using dummy regulator
[    2.255166] pps pps0: new PPS source ptp0
[    2.263370] libphy: fec_enet_mii_bus: probed
[    2.268150] fec 2188000.ethernet eth0: registered PHC device 0
[    2.274216] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
[    2.281199] igb: Copyright (c) 2007-2014 Intel Corporation.
[    2.286866] igb 0000:03:00.0: enabling device (0140 -> 0142)
[    2.292622] igb 0000:03:00.0: enabling bus mastering
[    2.521069] ata1: SATA link down (SStatus 0 SControl 300)
[    2.526506] ahci-imx 2200000.sata: no device found, disabling link.
[    2.529628] pps pps1: new PPS source ptp1
[    2.529637] igb 0000:03:00.0: added PHC on eth1
[    2.529642] igb 0000:03:00.0: Intel(R) Gigabit Ethernet Network Connection
[    2.529649] igb 0000:03:00.0: eth1: (PCIe:2.5Gb/s:Width x1) 00:a0:c9:00:00:00
[    2.529726] igb 0000:03:00.0: eth1: PBA No: 000300-000
[    2.529732] igb 0000:03:00.0: Using MSI interrupts. 1 rx queue(s), 1 tx queue(s)
[    2.529824] igb 0000:04:00.0: enabling device (0140 -> 0142)
[    2.529915] igb 0000:04:00.0: enabling bus mastering
[    2.578559] ahci-imx 2200000.sata: pass ahci_imx..hotplug=1 to enable hotplug
[    2.764559] pps pps2: new PPS source ptp2
[    2.768581] igb 0000:04:00.0: added PHC on eth2
[    2.773144] igb 0000:04:00.0: Intel(R) Gigabit Ethernet Network Connection
[    2.780043] igb 0000:04:00.0: eth2: (PCIe:2.5Gb/s:Width x1) 00:40:97:29:04:44
[    2.787255] igb 0000:04:00.0: eth2: PBA No: 000300-000
[    2.792416] igb 0000:04:00.0: Using MSI interrupts. 1 rx queue(s), 1 tx queue(s)
[    2.800367] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.806902] ehci-pci: EHCI PCI platform driver
[    2.811431] ehci-mxc: Freescale On-Chip EHCI Host driver
[    2.816881] usbcore: registered new interface driver cdc_acm
[    2.822567] cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
[    2.830654] usbcore: registered new interface driver usb-storage
[    2.842020] ci_hdrc ci_hdrc.0: EHCI Host Controller
[    2.846924] ci_hdrc ci_hdrc.0: new USB bus registered, assigned bus number 1
[    2.879574] ci_hdrc ci_hdrc.0: USB 2.0 started, EHCI 1.00
[    2.885775] hub 1-0:1.0: USB hub found
[    2.889618] hub 1-0:1.0: 1 port detected
[    2.897826] ci_hdrc ci_hdrc.1: EHCI Host Controller
[    2.902761] ci_hdrc ci_hdrc.1: new USB bus registered, assigned bus number 2
[    2.939567] ci_hdrc ci_hdrc.1: USB 2.0 started, EHCI 1.00
[    2.945689] hub 2-0:1.0: USB hub found
[    2.949492] hub 2-0:1.0: 1 port detected
[    2.954278] usbcore: registered new interface driver usbtouchscreen
[    2.967299] input: da9063-onkey as /devices/soc0/soc/2100000.aips-bus/21a8000.i2c/i2c-2/2-0058/da9063-onkey/input/input0
[    2.982525] rtc-rx8010 2-0032: IRQ 183 supplied
[    2.991070] rtc-rx8010 2-0032: rtc core: registered rx8010 as rtc0
[    2.997757] snvs_rtc 20cc000.snvs:snvs-rtc-lp: rtc core: registered 20cc000.snvs:snvs-r as rtc1
[    3.006602] i2c /dev entries driver
[    3.012015] i2c i2c-0: Added multiplexed i2c bus 3
[    3.018575] at24 4-0050: 1024 byte 24c08 EEPROM, writable, 1 bytes/write
[    3.025458] i2c i2c-0: Added multiplexed i2c bus 4
[    3.030505] i2c i2c-0: Added multiplexed i2c bus 5
[    3.035635] i2c i2c-0: Added multiplexed i2c bus 6
[    3.040821] pca953x 7-0074: 7-0074 supply vcc not found, using dummy regulator
[    3.051956] GPIO line 502 (PCA9539-P06) hogged as output/low
[    3.058716] GPIO line 503 (PCA9539-P07) hogged as output/low
[    3.065536] GPIO line 504 (PCA9539-P10) hogged as output/low
[    3.072346] GPIO line 505 (PCA9539-P11) hogged as output/low
[    3.079138] GPIO line 506 (PCA9539-P12) hogged as output/low
[    3.085946] GPIO line 507 (PCA9539-P13) hogged as output/low
[    3.092754] GPIO line 508 (PCA9539-P14) hogged as output/low
[    3.099559] GPIO line 509 (PCA9539-P15) hogged as output/low
[    3.106345] GPIO line 510 (PCA9539-P16) hogged as output/low
[    3.113150] GPIO line 511 (PCA9539-P17) hogged as output/low
[    3.120518] i2c i2c-0: Added multiplexed i2c bus 7
[    3.125531] i2c i2c-0: Added multiplexed i2c bus 8
[    3.130568] i2c i2c-0: Added multiplexed i2c bus 9
[    3.135559] i2c i2c-0: Added multiplexed i2c bus 10
[    3.140481] pca954x 0-0070: registered 8 multiplexed busses for I2C mux pca9547
[    3.148524] i2c i2c-1: Added multiplexed i2c bus 11
[    3.153632] i2c i2c-1: Added multiplexed i2c bus 12
[    3.158705] i2c i2c-1: Added multiplexed i2c bus 13
[    3.163817] i2c i2c-1: Added multiplexed i2c bus 14
[    3.168937] i2c i2c-1: Added multiplexed i2c bus 15
[    3.174109] i2c i2c-1: Added multiplexed i2c bus 16
[    3.179193] i2c i2c-1: Added multiplexed i2c bus 17
[    3.184318] i2c i2c-1: Added multiplexed i2c bus 18
[    3.189206] pca954x 1-0070: registered 8 multiplexed busses for I2C mux pca9547
[    3.201006] imx2-wdt 20bc000.wdog: timeout 60 sec (nowayout=0)
[    3.207544] sdhci: Secure Digital Host Controller Interface driver
[    3.213760] sdhci: Copyright(c) Pierre Ossman
[    3.218121] sdhci-pltfm: SDHCI platform and OF driver helper
[    3.224690] sdhci-esdhc-imx 2198000.usdhc: could not get ultra high speed state, work on normal mode
[    3.259573] usb 1-1: new high-speed USB device number 2 using ci_hdrc
[    3.299572] mmc0: SDHCI controller on 2198000.usdhc [2198000.usdhc] using ADMA
[    3.308401] usbcore: registered new interface driver usbhid
[    3.309567] usb 2-1: new high-speed USB device number 2 using ci_hdrc
[    3.320470] usbhid: USB HID core driver
[    3.327081] mma8452 3-001c: registering fsl,mma8453 accelerometer; ID 0x3a
[    3.410591] mmc0: new DDR MMC card at address 0001
[    3.415849] mmcblk0: mmc0:0001 BGND3R 29.1 GiB
[    3.420631] mmcblk0boot0: mmc0:0001 BGND3R partition 1 4.00 MiB
[    3.426801] mmcblk0boot1: mmc0:0001 BGND3R partition 2 4.00 MiB
[    3.432905] sgtl5000 6-000a: sgtl5000 revision 0x11
[    3.432982] mmcblk0rpmb: mmc0:0001 BGND3R partition 3 4.00 MiB
[    3.444504]  mmcblk0: p1 p2 p3 p4 < p5 >
[    3.446177] sgtl5000 6-000a: Using internal LDO instead of VDDD: check ER1
[    3.456964] hub 1-1:1.0: USB hub found
[    3.461219] hub 1-1:1.0: 3 ports detected
[    3.475293] fsl-ssi-dai 2028000.ssi: No cache defaults, reading back from HW
[    3.496884] imx-sgtl5000 sound: sgtl5000 <-> 2028000.ssi mapping ok
[    3.505192] NET: Registered protocol family 10
[    3.510963] Segment Routing with IPv6
[    3.514701] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    3.521240] NET: Registered protocol family 17
[    3.525700] 8021q: 802.1Q VLAN Support v1.8
[    3.529944] Key type dns_resolver registered
[    3.536393] Registering SWP/SWPB emulation handler
[    3.536406] hub 2-1:1.0: USB hub found
[    3.536538] hub 2-1:1.0: 4 ports detected
[    3.559106] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    3.565764] [drm] No driver support for vblank timestamp query.
[    3.571772] imx-drm display-subsystem: bound imx-ipuv3-crtc.2 (ops 0x80940bcc)
[    3.579024] imx-drm display-subsystem: bound imx-ipuv3-crtc.3 (ops 0x80940bcc)
[    3.586301] imx-drm display-subsystem: bound imx-ipuv3-crtc.6 (ops 0x80940bcc)
[    3.593565] imx-drm display-subsystem: bound imx-ipuv3-crtc.7 (ops 0x80940bcc)
[    3.600990] dwhdmi-imx 120000.hdmi: Detected HDMI TX controller v1.30a with HDCP (DWC HDMI 3D TX PHY)
[    3.610641] imx-drm display-subsystem: bound 120000.hdmi (ops 0x80940d44)
[    3.617542] /soc/aips-bus@02000000/ldb/lvds-channel@0: could not find display-timings node
[    3.625839] /soc/aips-bus@02000000/ldb/lvds-channel@0: no timings specified
[    3.632960] imx-ldb 2000000.aips-bus:ldb: dual-channel mode, ignoring second output
[    3.640643] imx-drm display-subsystem: bound 2000000.aips-bus:ldb (ops 0x809408b0)
[    3.725015] Console: switching to colour frame buffer device 128x48
[    3.747978] imx-drm display-subsystem: fb0:  frame buffer device
[    3.754350] [drm] Initialized imx-drm 1.0.0 20120507 for display-subsystem on minor 1
[    3.762724] (NULL device *): hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[    3.775089] imx_thermal 2000000.aips-bus:tempmon: Extended Commercial CPU temperature grade - max:105C critical:100C passive:95C
[    3.849560] usb 2-1.1: new high-speed USB device number 3 using ci_hdrc
[    3.879565] usb 1-1.1: new full-speed USB device number 3 using ci_hdrc
[    3.949552] mmc1: SDHCI controller on 219c000.usdhc [219c000.usdhc] using ADMA
[    3.963290] rtc-rx8010 2-0032: setting system clock to 2017-05-09 07:22:12 UTC (1494314532)
[    3.972213] lvds_ppen: disabling
[    4.000083] DA9063_LDO5: disabling
[    4.006268] hub 2-1.1:1.0: USB hub found
[    4.010413] hub 2-1.1:1.0: 3 ports detected
[    4.018614] DA9063_LDO6: disabling
[    4.025896] DA9063_LDO7: disabling
[    4.033392] DA9063_LDO8: disabling
[    4.040814] DA9063_LDO9: disabling
[    4.048416] DA9063_LDO10: disabling
[    4.064439] input: Silicon Laboratories B850 2nd video audio interface as /devices/soc0/soc/2100000.aips-bus/2184000.usb/ci_hdrc.0/usb1/11
[    4.099577] ALSA device list:
[    4.102555]   #0: imx6q-ba16-sgtl5000
[    4.149722] hid-generic 0003:1901:0191.0001: input: USB HID v1.11 Device [Silicon Laboratories B850 2nd video audio interface] on usb-ci_2
[    4.166269] EXT4-fs (mmcblk0p2): mounting ext3 file system using the ext4 subsystem
[    4.187392] EXT4-fs (mmcblk0p2): mounted filesystem with ordered data mode. Opts: (null)
[    4.195554] VFS: Mounted root (ext3 filesystem) readonly on device 179:2.
[    4.207517] devtmpfs: mounted
[    4.211506] Freeing unused kernel memory: 1024K
[    4.269588] usb 1-1.3: new full-speed USB device number 4 using ci_hdrc
[    4.349641] systemd[1]: systemd 232 running in system mode. (+PAM -AUDIT -SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP -LIBCRYPTSETUP -G)
[    4.368028] systemd[1]: Detected architecture arm.
...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
