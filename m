Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: Regression: 442ec4c04d1: PCI: dwc: all: Split struct pcie_port
 into host-only and core structures
To: Joao Pinto <Joao.Pinto@synopsys.com>, Peter Senna Tschudin
 <peter.senna@collabora.com>
References: <20170508150224.GA7458@collabora.com>
 <35b32db8-2b75-65c8-da81-f22d70b84b52@synopsys.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <4c28b2e2-4759-be0f-4466-cd53f0174e41@ti.com>
Date: Mon, 8 May 2017 20:50:53 +0530
MIME-Version: 1.0
In-Reply-To: <35b32db8-2b75-65c8-da81-f22d70b84b52@synopsys.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jesper Nilsson <jesper.nilsson@axis.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Jingoo Han <jingoohan1@gmail.com>, Pratyush Anand <pratyush.anand@gmail.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Murali Karicheri <m-karicheri2@ti.com>,
 Niklas Cassel <niklas.cassel@axis.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Mingkai Hu <mingkai.hu@freescale.com>, Roy Zang <tie-fei.zang@freescale.com>,
 linux-arm-kernel@lists.infradead.org, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="windows-1252"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Joao,

On Monday 08 May 2017 08:43 PM, Joao Pinto wrote:
> =

> Hi Peter,
> =

> =C0s 4:02 PM de 5/8/2017, Peter Senna Tschudin escreveu:
>> Hello Kishon,
>>
>> Our iMX6 hardware (imx6q-b850v3.dts) is not booting with latest
>> linux-next and I could bisect until:
>>
>> commit 442ec4c04d1235f8c664a74004dae54a7a574d18
>> Author: Kishon Vijay Abraham I <kishon@ti.com>
>> Date:   Wed Feb 15 18:48:14 2017 +0530
>>
>>     PCI: dwc: all: Split struct pcie_port into host-only and core struct=
ures
>>
>> Which seem to be causing our issues. Our device (imx6q-b850v3.dts) boots
>> fine with 4.10, and also boots if we disable pcie with:
>>
>> diff --git a/arch/arm/boot/dts/imx6q-b850v3.dts b/arch/arm/boot/dts/imx6=
q-b850v3.dts
>> index 2c1e98e..e655fd7 100644
>> --- a/arch/arm/boot/dts/imx6q-b850v3.dts
>> +++ b/arch/arm/boot/dts/imx6q-b850v3.dts
>> @@ -212,3 +212,8 @@
>>                 };
>>         };
>>  };
>> +
>> +&pcie {
>> +        status =3D "disabled";
>> +};
>>
>> But otherwise our system freezes while initializing PCI, see dmesg with
>> some more information. Is this something specific of our system/dt or
>> can this be a bug that is affecting others as well?
>>
>> Kind Regards,
>>
>> Peter
>>
>> Starting kernel ...
>>
>> Uncompressing Linux... done, booting the kernel.
>> [    0.000000] Booting Linux on physical CPU 0x0
>> [    0.000000] Linux version 4.11.0-next-20170508-dirty (peter@lenovo-pe=
ter.home) (gcc version 6.1.1 20160621 (Red Hat Cross 6.1.1-2) (GCC) 7
>> [    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=
=3D10c5387d
>> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing in=
struction cache
>> [    0.000000] OF: fdt: Machine model: General Electric B850v3
>> [    0.000000] earlycon: ec_imx21 at MMIO 0x021ec000 (options '')
>> [    0.000000] bootconsole [ec_imx21] enabled
>> [    0.000000] Memory policy: Data cache writealloc
>> [    0.000000] cma: Reserved 128 MiB at 0x88000000
>> [    0.000000] On node 0 totalpages: 524288
>> [    0.000000] free_area_init_node: node 0, pgdat 80d74fc0, node_mem_map=
 eeff7000
>> [    0.000000]   Normal zone: 3584 pages used for memmap
>> [    0.000000]   Normal zone: 0 pages reserved
>> [    0.000000]   Normal zone: 458752 pages, LIFO batch:31
>> [    0.000000]   HighMem zone: 65536 pages, LIFO batch:15
>> [    0.000000] percpu: Embedded 17 pages/cpu @eefb3000 s37900 r8192 d235=
40 u69632
>> [    0.000000] pcpu-alloc: s37900 r8192 d23540 u69632 alloc=3D17*4096
>> [    0.000000] pcpu-alloc: [0] 0 [0] 1
>> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  T=
otal pages: 520704
>> [    0.000000] Kernel command line: root=3D/dev/mmcblk0p2 ro rootwait cm=
a=3D128M video=3DDP-1:1024x768@60 video=3DHDMI-A-1:1024x768@60 earlycon log=
l0
>> [    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
>> [    0.000000] Dentry cache hash table entries: 262144 (order: 8, 104857=
6 bytes)
>> [    0.000000] Inode-cache hash table entries: 131072 (order: 7, 524288 =
bytes)
>> [    0.000000] Memory: 1934676K/2097152K available (8192K kernel code, 5=
02K rwdata, 2220K rodata, 1024K init, 309K bss, 31404K reserved, 131)
>> [    0.000000] Virtual kernel memory layout:
>> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>> [    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
>> [    0.000000]     vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
>> [    0.000000]     lowmem  : 0x80000000 - 0xf0000000   (1792 MB)
>> [    0.000000]     pkmap   : 0x7fe00000 - 0x80000000   (   2 MB)
>> [    0.000000]     modules : 0x7f000000 - 0x7fe00000   (  14 MB)
>> [    0.000000]       .text : 0x80008000 - 0x80900000   (9184 kB)
>> [    0.000000]       .init : 0x80c00000 - 0x80d00000   (1024 kB)
>> [    0.000000]       .data : 0x80d00000 - 0x80d7d874   ( 503 kB)
>> [    0.000000]        .bss : 0x80d7f000 - 0x80dcc6c0   ( 310 kB)
>> [    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D2=
, Nodes=3D1
>> [    0.000000] ftrace: allocating 28081 entries in 83 pages
>> [    0.000000] Hierarchical RCU implementation.
>> [    0.000000]  RCU debugfs-based tracing is enabled.
>> [    0.000000]  RCU restricting CPUs from NR_CPUS=3D4 to nr_cpu_ids=3D2.
>> [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_=
ids=3D2
>> [    0.000000] NR_IRQS:16 nr_irqs:16 16
>> [    0.000000] L2C-310 errata 752271 769419 enabled
>> [    0.000000] L2C-310 enabling early BRESP for Cortex-A9
>> [    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
>> [    0.000000] L2C-310 ID prefetch enabled, offset 16 lines
>> [    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
>> [    0.000000] L2C-310 cache controller enabled, 16 ways, 1024 kB
>> [    0.000000] L2C-310: CACHE_ID 0x410000c7, AUX_CTRL 0x76470001
>> [    0.000000] Switching to timer-based delay loop, resolution 333ns
>> [    0.000007] sched_clock: 32 bits at 3000kHz, resolution 333ns, wraps =
every 715827882841ns
>> [    0.008183] clocksource: mxc_timer1: mask: 0xffffffff max_cycles: 0xf=
fffffff, max_idle_ns: 637086815595 ns
>> [    0.019149] Console: colour dummy device 80x30
>> [    0.022277] Calibrating delay loop (skipped), value calculated using =
timer frequency.. 6.00 BogoMIPS (lpj=3D30000)
>> [    0.032459] pid_max: default: 32768 minimum: 301
>> [    0.037145] Mount-cache hash table entries: 4096 (order: 2, 16384 byt=
es)
>> [    0.043765] Mountpoint-cache hash table entries: 4096 (order: 2, 1638=
4 bytes)
>> [    0.051388] CPU: Testing write buffer coherency: ok
>> [    0.056014] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
>> [    0.061774] Setting up static identity map for 0x10100000 - 0x10100054
>> [    0.068619] smp: Bringing up secondary CPUs ...
>> [    0.073110] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
>> [    0.073195] smp: Brought up 1 node, 2 CPUs
>> [    0.082212] SMP: Total of 2 processors activated (12.00 BogoMIPS).
>> [    0.088397] CPU: All CPU(s) started in SVC mode.
>> [    0.093925] devtmpfs: initialized
>> [    0.106030] VFP support v0.3: implementor 41 architecture 3 part 30 v=
ariant 9 rev 4
>> [    0.110962] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffff=
ffff, max_idle_ns: 19112604462750000 ns
>> [    0.120713] futex hash table entries: 512 (order: 3, 32768 bytes)
>> [    0.132529] pinctrl core: initialized pinctrl subsystem
>> [    0.135868] NET: Registered protocol family 16
>> [    0.141371] DMA: preallocated 256 KiB pool for atomic coherent alloca=
tions
>> [    0.147347] CPU identified as i.MX6Q, silicon rev 1.5
>> [    0.157099] vdd1p1: supplied by regulator-dummy
>> [    0.159154] vdd3p0: supplied by regulator-dummy
>> [    0.163643] vdd2p5: supplied by regulator-dummy
>> [    0.168222] vddarm: supplied by regulator-dummy
>> [    0.172734] vddpu: supplied by regulator-dummy
>> [    0.177183] vddsoc: supplied by regulator-dummy
>> [    0.188863] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 wat=
chpoint registers.
>> [    0.194018] hw-breakpoint: maximum watchpoint size is 4 bytes.
>> [    0.200687] imx6q-pinctrl 20e0000.iomuxc: initialized IMX pinctrl dri=
ver
>> [    0.225818] mxs-dma 110000.dma-apbh: initialized
>> [    0.229977] vgaarb: loaded
>> [    0.230724] SCSI subsystem initialized
>> [    0.234208] libata version 3.00 loaded.
>> [    0.238082] usbcore: registered new interface driver usbfs
>> [    0.243402] usbcore: registered new interface driver hub
>> [    0.248696] usbcore: registered new device driver usb
>> [    0.254761] i2c i2c-0: IMX I2C adapter registered
>> [    0.258390] i2c i2c-0: can't use DMA, using PIO instead.
>> [    0.264098] i2c i2c-1: IMX I2C adapter registered
>> [    0.268390] i2c i2c-1: can't use DMA, using PIO instead.
>> [    0.274206] i2c i2c-2: IMX I2C adapter registered
>> [    0.278396] i2c i2c-2: can't use DMA, using PIO instead.
>> [    0.283829] pps_core: LinuxPPS API ver. 1 registered
>> [    0.288657] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodol=
fo Giometti <giometti@linux.it>
>> [    0.297822] PTP clock support registered
>> [    0.301979] Advanced Linux Sound Architecture Driver Initialized.
>> [    0.309622] clocksource: Switched to clocksource mxc_timer1
>> [    0.370378] NET: Registered protocol family 2
>> [    0.372439] TCP established hash table entries: 16384 (order: 4, 6553=
6 bytes)
>> [    0.379153] TCP bind hash table entries: 16384 (order: 5, 131072 byte=
s)
>> [    0.385901] TCP: Hash tables configured (established 16384 bind 16384)
>> [    0.392300] UDP hash table entries: 1024 (order: 3, 32768 bytes)
>> [    0.398227] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes)
>> [    0.404824] NET: Registered protocol family 1
>> [    0.408971] PCI: CLS 0 bytes, default 64
>> [    0.413582] hw perfevents: no interrupt-affinity property for /soc/pm=
u, guessing.
>> [    0.420576] hw perfevents: enabled with armv7_cortex_a9 PMU driver, 7=
 counters available
>> [    0.429443] audit: initializing netlink subsys (disabled)
>> [    0.434049] audit: type=3D2000 audit(0.424:1): state=3Dinitialized au=
dit_enabled=3D0 res=3D1
>> [    0.434655] workingset: timestamp_bits=3D30 max_order=3D19 bucket_ord=
er=3D0
>> [    0.445347] bounce: pool size: 64 pages
>> [    0.445354] io scheduler noop registered
>> [    0.445358] io scheduler deadline registered
>> [    0.445392] io scheduler cfq registered (default)
>> [    0.445396] io scheduler mq-deadline registered
>> [    0.445400] io scheduler kyber registered
>> [    0.501998] OF: PCI: host bridge /soc/pcie@1ffc000 ranges:
>> [    0.507275] OF: PCI:    IO 0x01f80000..0x01f8ffff -> 0x00000000
>> [    0.513202] OF: PCI:   MEM 0x01000000..0x01efffff -> 0x01000000
>> [    0.739697] imx6q-pcie 1ffc000.pcie: link up
>> [    0.741115] imx6q-pcie 1ffc000.pcie: Link: Gen2 disabled
>> [    0.746421] imx6q-pcie 1ffc000.pcie: Link up, Gen1
>> [    0.751343] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
>> [    0.757475] pci_bus 0000:00: root bus resource [bus 00-ff]
>> [    0.762974] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
>> [    0.769128] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01ef=
ffff]
>> [    0.776052] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
>> [    0.782044] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
>> [    0.788279] pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pr=
ef]
>> [    0.795041] pci 0000:00:00.0: supports D1
>> [    0.798971] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
>> [    0.805503] PCI: bus0: Fast back to back transfers disabled
>> [    0.811079] pci 0000:01:00.0: [10b5:8605] type 01 class 0x060400
>> [    0.817034] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff]
>> [    0.823778] pci 0000:01:00.0: supports D1 D2
>> [    0.827418] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3co=
ld
>> [    0.859773] PCI: bus1: Fast back to back transfers disabled
>> [    0.862502] pci 0000:01:00.0: bridge configuration invalid ([bus 00-0=
0]), reconfiguring
>> [    0.870810] pci_bus 0000:02: busn_res: can not insert [bus 02-ff] und=
er [bus 01] (conflicts with (null) [bus 01])
>> [    0.880800] Unhandled fault: external abort on non-linefetch (0x1008)=
 at 0xf0a40000
>> [    0.888416] pgd =3D 80004000
>> [    0.891112] [f0a40000] *pgd=3D7e01d811, *pte=3D01f40243, *ppte=3D01f4=
0013
>> [    0.897384] Internal error: : 1008 [#1] SMP ARM
>> [    0.901903] Modules linked in:
>> [    0.904951] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.11.0-next-201=
70508-dirty #106
>> [    0.912775] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
>> [    0.919302] task: ee908000 task.stack: ee906000
>> [    0.923836] PC is at dw_pcie_read+0x60/0x8c
>> [    0.928005] LR is at dw_pcie_rd_conf+0x188/0x1e0
>> [    0.932616] pc : [<804125b8>]    lr : [<80413308>]    psr: 60000093
>> [    0.932616] sp : ee907af0  ip : ee907b00  fp : ee907afc
>> [    0.944096] r10: 00000000  r9 : eea28b10  r8 : 00000000
>> [    0.949317] r7 : 00000000  r6 : 00000000  r5 : f0a40000  r4 : eea28b28
>> [    0.955840] r3 : 00000000  r2 : ee907b6c  r1 : 00000004  r0 : f0a40000
>> [    0.962368] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Seg=
ment none
>> [    0.969589] Control: 10c5387d  Table: 1000404a  DAC: 00000051
>> [    0.975330] Process swapper/0 (pid: 1, stack limit =3D 0xee906210)
>> [    0.981333] Stack: (0xee907af0 to 0xee908000)
>> [    0.985686] 7ae0:                                     ee907b54 ee907b=
00 80413308 80412564
>> [    0.993864] 7b00: 01f40000 00000000 02000000 00000000 00040000 804126=
ec 01f40000 00000000
>> [    1.002041] 7b20: 804126ec 00000004 ee907b44 80413180 ee907bd4 600000=
13 00000000 00000002
>> [    1.010220] 7b40: 00000000 eeb1be00 ee907b8c ee907b58 803f3eac 804131=
8c ee907b6c 80412564
>> [    1.018397] 7b60: 00000000 00000000 ee907b84 00000000 00000000 000000=
00 ee907bd4 0000ea60
>> [    1.026577] 7b80: ee907bcc ee907b90 803f6598 803f3e40 eea28b10 000000=
00 ee907bfc 80400974
>> [    1.034754] 7ba0: 00000000 00000000 eeb1be00 00000000 00000000 000000=
02 00000000 00000001
>> [    1.042932] 7bc0: ee907bf4 ee907bd0 803f7f08 803f6570 ee907bfc 80db80=
b4 00000008 eeb1be00
>> [    1.051109] 7be0: eea16000 00000000 ee907c14 ee907bf8 803f7fec 803f7e=
c4 00000008 eeb1be00
>> [    1.059287] 7c00: eea16000 00000002 ee907c3c ee907c18 803f902c 803f7f=
88 eeb1bc00 eeb1be00
>> [    1.067466] 7c20: eea16000 00000001 00000002 00000000 ee907c94 ee907c=
40 803f8d58 803f9008
>> [    1.075643] 7c40: 8010e080 802097c8 80a57698 00000001 00000000 000000=
00 00000000 00000000
>> [    1.083821] 7c60: 00000001 00ff0201 ee907c94 eea16000 eeb1bc00 eeb1bc=
14 00000001 00000001
>> [    1.091999] 7c80: 00000001 00000001 ee907cbc ee907c98 803f9088 803f8a=
b4 eeb1ba00 eeb1bc00
>> [    1.100177] 7ca0: eea15c00 00000000 00000001 00000001 ee907d14 ee907c=
c0 803f8ca0 803f9008
>> [    1.108355] 7cc0: 8010e080 802097c8 80a57698 00000000 00000000 000000=
00 00000000 00000000
>> [    1.116533] 7ce0: 00000001 00010100 ee907d14 eea15c00 eeb1ba00 eeb1ba=
14 00000000 00000000
>> [    1.124712] 7d00: ee803e10 00000000 ee907d3c ee907d18 803f9088 803f8a=
b4 00000000 eeb1ba00
>> [    1.132890] 7d20: 80d308b4 ee907d70 ee907d70 ee803e10 ee907d5c ee907d=
40 803f92d4 803f9008
>> [    1.141069] 7d40: ee907d70 80d308b4 eea28b28 80d3082c ee907da4 ee907d=
60 80413d20 803f9274
>> [    1.149247] 7d60: ee907d70 80d308b4 8016f3bc eefd9ef8 ee907d70 ee907d=
70 ee803e00 00000000
>> [    1.157425] 7d80: eea28b10 ee803e10 ee01a490 ee803e00 eefd9ef8 80c006=
60 ee907ddc ee907da8
>> [    1.165603] 7da0: 8041479c 80413adc 00010080 80a886e4 ee01a490 ee803e=
10 ee803e10 80d308fc
>> [    1.173781] 7dc0: 00000000 00000000 80d308fc 00000000 ee907df4 ee907d=
e0 804e10e8 8041441c
>> [    1.181959] 7de0: 80dc0d30 ee803e10 ee907e1c ee907df8 804df498 804e10=
b0 ee803e10 80d308fc
>> [    1.190136] 7e00: ee803e44 00000000 00000000 80c6a83c ee907e3c ee907e=
20 804df610 804df2b4
>> [    1.198313] 7e20: 00000000 80d308fc 804df53c 00000000 ee907e64 ee907e=
40 804dd74c 804df548
>> [    1.206493] 7e40: ee947058 ee8f8434 ee94706c 80d308fc ee01a380 80d408=
50 ee907e74 ee907e68
>> [    1.214669] 7e60: 804def1c 804dd6dc ee907e9c ee907e78 804dea5c 804def=
00 80a88880 ee907e88
>> [    1.222848] 7e80: 80d308fc ffffe000 80c6a834 80b29414 ee907eb4 ee907e=
a0 804dfe9c 804de958
>> [    1.231026] 7ea0: 80c2c07c ffffe000 ee907ec4 ee907eb8 804e1090 804dfe=
20 ee907edc ee907ec8
>> [    1.239204] 7ec0: 80c2c0bc 804e105c 80a58f90 ffffe000 ee907f4c ee907e=
e0 80101c78 80c2c088
>> [    1.247383] 7ee0: 80c00684 803b9664 80b2a200 000000b9 ee907f4c ee907f=
00 80142b54 80c0066c
>> [    1.255559] 7f00: 8015ddd4 00000006 00000006 00000000 80b29414 80ab86=
44 efffea30 efffea38
>> [    1.263739] 7f20: 00000000 00000006 80d7f000 80c99e94 80d7f000 80c6a8=
34 80b29414 000000b9
>> [    1.271916] 7f40: ee907f94 ee907f50 80c00eb0 80101c38 00000006 000000=
06 00000000 80c00660
>> [    1.280093] 7f60: 00000000 00000007 8088ee80 00000000 8088ee80 000000=
00 00000000 00000000
>> [    1.288272] 7f80: 00000000 00000000 ee907fac ee907f98 8088ee98 80c00d=
88 00000000 8088ee80
>> [    1.296450] 7fa0: 00000000 ee907fb0 801080f8 8088ee8c 00000000 000000=
00 00000000 00000000
>> [    1.304627] 7fc0: 00000000 00000000 00000000 00000000 00000000 000000=
00 00000000 00000000
>> [    1.312805] 7fe0: 00000000 00000000 00000000 00000000 00000013 000000=
00 ffffffff ffffffff
>> [    1.320978] Backtrace:
>> [    1.323425] [<80412558>] (dw_pcie_read) from [<80413308>] (dw_pcie_rd=
_conf+0x188/0x1e0)
>> [    1.331433] [<80413180>] (dw_pcie_rd_conf) from [<803f3eac>] (pci_bus=
_read_config_dword+0x78/0xa0)
>> [    1.340387]  r10:eeb1be00 r9:00000000 r8:00000002 r7:00000000 r6:6000=
0013 r5:ee907bd4
>> [    1.348210]  r4:80413180
>> [    1.350744] [<803f3e34>] (pci_bus_read_config_dword) from [<803f6598>=
] (pci_bus_read_dev_vendor_id+0x34/0x104)
>> [    1.360740]  r6:0000ea60 r5:ee907bd4 r4:00000000
>> [    1.365358] [<803f6564>] (pci_bus_read_dev_vendor_id) from [<803f7f08=
>] (pci_scan_single_device+0x50/0xc4)
>> [    1.375011]  r10:00000001 r9:00000000 r8:00000002 r7:00000000 r6:0000=
0000 r5:eeb1be00
>> [    1.382835]  r4:00000000
>> [    1.385366] [<803f7eb8>] (pci_scan_single_device) from [<803f7fec>] (=
pci_scan_slot+0x70/0x118)
>> [    1.393975]  r7:00000000 r6:eea16000 r5:eeb1be00 r4:00000008
>> [    1.399634] [<803f7f7c>] (pci_scan_slot) from [<803f902c>] (pci_scan_=
child_bus+0x30/0x108)
>> [    1.407895]  r7:00000002 r6:eea16000 r5:eeb1be00 r4:00000008
>> [    1.413551] [<803f8ffc>] (pci_scan_child_bus) from [<803f8d58>] (pci_=
scan_bridge+0x2b0/0x554)
>> [    1.422078]  r9:00000000 r8:00000002 r7:00000001 r6:eea16000 r5:eeb1b=
e00 r4:eeb1bc00
>> [    1.429820] [<803f8aa8>] (pci_scan_bridge) from [<803f9088>] (pci_sca=
n_child_bus+0x8c/0x108)
>> [    1.438261]  r10:00000001 r9:00000001 r8:00000001 r7:00000001 r6:eeb1=
bc14 r5:eeb1bc00
>> [    1.446085]  r4:eea16000
>> [    1.448612] [<803f8ffc>] (pci_scan_child_bus) from [<803f8ca0>] (pci_=
scan_bridge+0x1f8/0x554)
>> [    1.457138]  r9:00000001 r8:00000001 r7:00000000 r6:eea15c00 r5:eeb1b=
c00 r4:eeb1ba00
>> [    1.464881] [<803f8aa8>] (pci_scan_bridge) from [<803f9088>] (pci_sca=
n_child_bus+0x8c/0x108)
>> [    1.473321]  r10:00000000 r9:ee803e10 r8:00000000 r7:00000000 r6:eeb1=
ba14 r5:eeb1ba00
>> [    1.481145]  r4:eea15c00
>> [    1.483675] [<803f8ffc>] (pci_scan_child_bus) from [<803f92d4>] (pci_=
scan_root_bus_msi+0x6c/0xd4)
>> [    1.492549]  r9:ee803e10 r8:ee907d70 r7:ee907d70 r6:80d308b4 r5:eeb1b=
a00 r4:00000000
>> [    1.500292] [<803f9268>] (pci_scan_root_bus_msi) from [<80413d20>] (d=
w_pcie_host_init+0x250/0x4f8)
>> [    1.509249]  r5:80d3082c r4:eea28b28
>> [    1.512822] [<80413ad0>] (dw_pcie_host_init) from [<8041479c>] (imx6_=
pcie_probe+0x38c/0x540)
>> [    1.521259]  r10:80c00660 r9:eefd9ef8 r8:ee803e00 r7:ee01a490 r6:ee80=
3e10 r5:eea28b10
>> [    1.529083]  r4:00000000
>> [    1.531619] [<80414410>] (imx6_pcie_probe) from [<804e10e8>] (platfor=
m_drv_probe+0x44/0x7c)
>> [    1.539963]  r9:00000000 r8:80d308fc r7:00000000 r6:00000000 r5:80d30=
8fc r4:ee803e10
>> [    1.547709] [<804e10a4>] (platform_drv_probe) from [<804df498>] (real=
ly_probe+0x1f0/0x294)
>> [    1.555967]  r5:ee803e10 r4:80dc0d30
>> [    1.559540] [<804df2a8>] (really_probe) from [<804df610>] (__driver_a=
ttach+0xd4/0xd8)
>> [    1.567367]  r9:80c6a83c r8:00000000 r7:00000000 r6:ee803e44 r5:80d30=
8fc r4:ee803e10
>> [    1.575113] [<804df53c>] (__driver_attach) from [<804dd74c>] (bus_for=
_each_dev+0x7c/0xb0)
>> [    1.583286]  r7:00000000 r6:804df53c r5:80d308fc r4:00000000
>> [    1.588945] [<804dd6d0>] (bus_for_each_dev) from [<804def1c>] (driver=
_attach+0x28/0x30)
>> [    1.596945]  r6:80d40850 r5:ee01a380 r4:80d308fc
>> [    1.601560] [<804deef4>] (driver_attach) from [<804dea5c>] (bus_add_d=
river+0x110/0x220)
>> [    1.609564] [<804de94c>] (bus_add_driver) from [<804dfe9c>] (driver_r=
egister+0x88/0x104)
>> [    1.617652]  r7:80b29414 r6:80c6a834 r5:ffffe000 r4:80d308fc
>> [    1.623311] [<804dfe14>] (driver_register) from [<804e1090>] (__platf=
orm_driver_register+0x40/0x54)
>> [    1.632353]  r5:ffffe000 r4:80c2c07c
>> [    1.635931] [<804e1050>] (__platform_driver_register) from [<80c2c0bc=
>] (imx6_pcie_init+0x40/0x54)
>> [    1.644890] [<80c2c07c>] (imx6_pcie_init) from [<80101c78>] (do_one_i=
nitcall+0x4c/0x17c)
>> [    1.652983] [<80101c2c>] (do_one_initcall) from [<80c00eb0>] (kernel_=
init_freeable+0x134/0x1f4)
>> [    1.661675]  r8:000000b9 r7:80b29414 r6:80c6a834 r5:80d7f000 r4:80c99=
e94
>> [    1.668385] [<80c00d7c>] (kernel_init_freeable) from [<8088ee98>] (ke=
rnel_init+0x18/0x124)
>> [    1.676641]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:0000=
0000 r5:8088ee80
>> [    1.684464]  r4:00000000
>> [    1.687000] [<8088ee80>] (kernel_init) from [<801080f8>] (ret_from_fo=
rk+0x14/0x3c)
>> [    1.694558]  r5:8088ee80 r4:00000000
>> [    1.698131] Code: ee073f9a e1a00003 e5821000 e89da800 (e5901000)
>> [    1.704224] ---[ end trace dc8f87ab88f61701 ]---
>> [    1.708894] Kernel panic - not syncing: Attempted to kill init! exitc=
ode=3D0x0000000b
>> [    1.708894]
>> [    1.717974] CPU1: stopping
>> [    1.720663] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D         4=
.11.0-next-20170508-dirty #106
>> [    1.729705] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
>> [    1.736230] Backtrace:
>> [    1.738676] [<8010c7d0>] (dump_backtrace) from [<8010cad4>] (show_sta=
ck+0x20/0x24)
>> [    1.746239]  r7:00000001 r6:60000193 r5:00000000 r4:80d2f200
>> [    1.751902] [<8010cab4>] (show_stack) from [<803b1970>] (dump_stack+0=
x94/0xb0)
>> [    1.759120] [<803b18dc>] (dump_stack) from [<8010f708>] (handle_IPI+0=
x28c/0x334)
>> [    1.766510]  r7:00000001 r6:80ca1e0c r5:ee92df38 r4:80d7f310
>> [    1.772167] [<8010f47c>] (handle_IPI) from [<801015a4>] (gic_handle_i=
rq+0xa8/0xc4)
>> [    1.779735]  r10:80d0432c r9:f4000100 r8:80d2f648 r7:ee92df38 r6:0000=
03ff r5:000003eb
>> [    1.787561]  r4:f400010c r3:00000000
>> [    1.791134] [<801014fc>] (gic_handle_irq) from [<80894a6c>] (__irq_sv=
c+0x6c/0x90)
>> [    1.798609] Exception stack(0xee92df38 to 0xee92df80)
>> [    1.803657] df20:                                                    =
   0000062c 6e329000
>> [    1.811839] df40: 00000000 8011bd60 ee92c000 00000000 80d03cf8 80d03c=
ac 80d16f9f 80a5d91c
>> [    1.820016] df60: 00000000 ee92df94 ee92df98 ee92df88 80108a00 80108a=
04 60000013 ffffffff
>> [    1.828194]  r10:00000000 r9:ee92c000 r8:80d16f9f r7:ee92df6c r6:ffff=
ffff r5:60000013
>> [    1.836019]  r4:80108a04
>> [    1.838552] [<801089c4>] (arch_cpu_idle) from [<8089424c>] (default_i=
dle_call+0x30/0x3c)
>> [    1.846647] [<8089421c>] (default_idle_call) from [<8015ed88>] (do_id=
le+0xc4/0x14c)
>> [    1.854296] [<8015ecc4>] (do_idle) from [<8015f09c>] (cpu_startup_ent=
ry+0x28/0x2c)
>> [    1.861864]  r9:412fc09a r8:1000406a r7:80d7f320 r6:10c0387d r5:00000=
001 r4:00000087
>> [    1.869609] [<8015f074>] (cpu_startup_entry) from [<8010f1ec>] (secon=
dary_start_kernel+0x148/0x174)
>> [    1.878656] [<8010f0a4>] (secondary_start_kernel) from [<1010196c>] (=
0x1010196c)
>> [    1.886046]  r5:00000051 r4:7e92006a
>> [    1.889619] ---[ end Kernel panic - not syncing: Attempted to kill in=
it! exitcode=3D0x0000000b
>> [    1.889619]
>>
> =

> Could you please check if you specific SoC driver is implementing the
> dw_pcie_ops structure? You can see an example here:
> =

> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/tree/driv=
ers/pci/dwc/pcie-designware-plat.c?h=3Dnext#n89
> =

> The hang in the boot could be achieved by not declaring this op's structu=
re.

just checked pci-imx6.c has both dw_pcie_ops and dw_pcie_host_ops.

Thanks
Kishon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
