Return-Path: <SRS0=Cddw=OF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98C0C43441
	for <linux-pci@archiver.kernel.org>; Mon, 26 Nov 2018 16:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D7F20862
	for <linux-pci@archiver.kernel.org>; Mon, 26 Nov 2018 16:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="AOf3e4CM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D7F20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbeK0DLZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:11:25 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:37118 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbeK0DLY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Nov 2018 22:11:24 -0500
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 03B4D5C0096;
        Mon, 26 Nov 2018 17:16:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1543249006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=03al7ZmPSKOYeSQYZ5FdnbPG2dEihHyuUBzYRkoVxnc=;
        b=AOf3e4CMA1yja+tT3dmS3QWVxfPcVm/ALov6wLkP+v8JmFR6EZU8vvO1FJmOPBd9bau4Fy
        rGzLLsTvjkONHLxCsh4NL1bFKSJ73iHWrmKgzvZbgHp4umkG7hd8gz5ZgCEkFgvKNwM2tq
        jWkTOmJnw+MmnkRWB0IOObCT8aRxfhk=
From:   Stefan Agner <stefan@agner.ch>
To:     hongxing.zhu@nxp.com, l.stach@pengutronix.de,
        leonard.crestez@nxp.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com
Cc:     lorenzo.pieralisi@arm.com, tpiepho@impinj.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org
Subject: PCI: imx6: crash when using Thumb2
Date:   Mon, 26 Nov 2018 17:16:45 +0100
Message-Id: <20181126161645.8177-1-stefan@agner.ch>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

During debugging of the DBI register length limitation I encountered
another issue which only seem to appear when building a Thumb2 kernel.
I added a print in dw_pcie_read and compared all reads between Thumb2
and ARM, the two kernel seem to read exactly the same offsets. The
only difference is that the Thumb2 kernel crashes when reading that
particular register...

Booting Linux on physical CPU 0x0
Linux version 4.19.4-00044-ged7a0cc2ef01-dirty (ags@trochilidae) (gcc version 7.2.1 20171011 (Linaro GCC 7.2-2017.11)) #459 SMP PREEMPT Mon Nov 26 16:28:46 CET 2018
CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=50c5387d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
OF: fdt: Machine model: Toradex Apalis iMX6Q/D Module on Apalis Evaluation Board
earlycon: ec_imx21 at MMIO 0x02020000 (options '115200n8')
bootconsole [ec_imx21] enabled
Memory policy: Data cache writealloc
cma: Reserved 64 MiB at 0x4c000000
random: get_random_bytes called from start_kernel+0x85/0x338 with crng_init=0
percpu: Embedded 16 pages/cpu @(ptrval) s36108 r8192 d21236 u65536
Built 1 zonelists, mobility grouping on.  Total pages: 260608
Kernel command line: root=LABEL=otaroot rootfstype=ext4 earlycon video=LVDS-1:e hw_random.default_quality=100 console=tty1 console=ttymxc0,115200 ostree=/ostree/boot.1/torizon/43498cf0ceac1b957d061dfefdf6268380a412eac513fac22177b8b4a523f35b/0
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 957960K/1048576K available (7168K kernel code, 421K rwdata, 3388K rodata, 1024K init, 419K bss, 25080K reserved, 65536K cma-reserved, 196608K highmem)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
    vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
    lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
    modules : 0xbf800000 - 0xbfe00000   (   6 MB)
      .text : 0x(ptrval) - 0x(ptrval)   (8160 kB)
      .init : 0x(ptrval) - 0x(ptrval)   (1024 kB)
      .data : 0x(ptrval) - 0x(ptrval)   ( 422 kB)
       .bss : 0x(ptrval) - 0x(ptrval)   ( 420 kB)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
rcu: Preemptible hierarchical RCU implementation.
 Tasks RCU enabled.
NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
L2C-310 errata 752271 769419 enabled
L2C-310 enabling early BRESP for Cortex-A9
L2C-310 full line of zeros enabled for Cortex-A9
L2C-310 ID prefetch enabled, offset 16 lines
L2C-310 dynamic clock gating enabled, standby mode enabled
L2C-310 cache controller enabled, 16 ways, 1024 kB
L2C-310: CACHE_ID 0x410000c7, AUX_CTRL 0x76470001
Switching to timer-based delay loop, resolution 333ns
sched_clock: 32 bits at 3000kHz, resolution 333ns, wraps every 715827882841ns
clocksource: mxc_timer1: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 637086815595 ns
Console: colour dummy device 80x30
console [tty1] enabled
Calibrating delay loop (skipped), value calculated using timer frequency.. 6.00 BogoMIPS (lpj=30000)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
CPU: Testing write buffer coherency: ok
CPU0: Spectre v2: using BPIALL workaround
CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
Setting up static identity map for 0x10100000 - 0x10100054
rcu: Hierarchical SRCU implementation.
smp: Bringing up secondary CPUs ...
CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
CPU1: Spectre v2: using BPIALL workaround
CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
CPU2: Spectre v2: using BPIALL workaround
CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
CPU3: Spectre v2: using BPIALL workaround
smp: Brought up 1 node, 4 CPUs
SMP: Total of 4 processors activated (24.00 BogoMIPS).
CPU: All CPU(s) started in SVC mode.
devtmpfs: initialized
VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
futex hash table entries: 1024 (order: 4, 65536 bytes)
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
cpuidle: using governor menu
CPU identified as i.MX6Q, silicon rev 1.5
vdd1p1: supplied by regulator-dummy
vdd3p0: supplied by regulator-dummy
vdd2p5: supplied by regulator-dummy
vddarm: supplied by regulator-dummy
vddpu: supplied by regulator-dummy
vddsoc: supplied by regulator-dummy
No ATAGs?
hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint registers.
hw-breakpoint: maximum watchpoint size is 4 bytes.
imx6q-pinctrl 20e0000.iomuxc: initialized IMX pinctrl driver
Serial: AMBA PL011 UART driver
mxs-dma 110000.dma-apbh: initialized
usb_host_vbus: supplied by usb_host_vbus_hub
vgaarb: loaded
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
i2c i2c-0: IMX I2C adapter registered
i2c i2c-0: can't use DMA, using PIO instead.
stmpe-i2c 2-0041: stmpe811 detected, chip id: 0x811
i2c i2c-2: IMX I2C adapter registered
i2c i2c-2: can't use DMA, using PIO instead.
gpio-81 (scl): enforced open drain please flag it properly in DT/ACPI DSDT/board file
i2c i2c-1: IMX I2C adapter registered
i2c i2c-1: can't use DMA, using PIO instead.
media: Linux media interface: v0.10
videodev: Linux video capture interface: v2.00
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
PTP clock support registered
Advanced Linux Sound Architecture Driver Initialized.
Bluetooth: Core ver 2.22
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO socket layer initialized
clocksource: Switched to clocksource mxc_timer1
VFS: Disk quotas dquot_6.6.0
VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
NET: Registered protocol family 2
tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 6144 bytes)
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
UDP hash table entries: 512 (order: 2, 16384 bytes)
UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
Trying to unpack rootfs image as initramfs...
Freeing initrd memory: 2516K
hw perfevents: no interrupt-affinity property for /pmu, guessing.
hw perfevents: enabled with armv7_cortex_a9 PMU driver, 7 counters available
Initialise system trusted keyrings
workingset: timestamp_bits=30 max_order=18 bucket_order=0
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
jffs2: version 2.2. (NAND) © 2001-2006 Red Hat, Inc.
fuse init (API version 7.27)
Key type asymmetric registered
Asymmetric key parser 'x509' registered
bounce: pool size: 64 pages
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
io scheduler mq-deadline registered
io scheduler kyber registered
imx6q-pcie 1ffc000.pcie: Linked as a consumer to regulator.12
imx6q-pcie 1ffc000.pcie: host bridge /soc/pcie@1ffc000 ranges:
imx6q-pcie 1ffc000.pcie:    IO 0x01f80000..0x01f8ffff -> 0x00000000
imx6q-pcie 1ffc000.pcie:   MEM 0x01000000..0x01efffff -> 0x01000000
dw_pcie_read, addr f09bc710, size 4
[...]
dw_pcie_read, addr f09bc72c, size 4
imx6q-pcie 1ffc000.pcie: Link up
imx6q-pcie 1ffc000.pcie: Link: Gen2 disabled
dw_pcie_read, addr f09bc080, size 4
imx6q-pcie 1ffc000.pcie: Link up, Gen1
imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [bus 00-ff]
pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
dw_pcie_read, addr f09bc000, size 4
[...]
dw_pcie_read, addr f09bc004, size 2
PCI: bus0: Fast back to back transfers disabled
dw_pcie_read, addr f09bc018, size 4
[...]
dw_pcie_read, addr f09bc082, size 2
pci 0000:01:00.0: 2.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s x1 link at 0000:00:00.0 (capable of 7.876 Gb/s with 8 GT/s x1 link)
dw_pcie_read, addr f09bc72c, size 4
[...]
dw_pcie_read, addr f09bc908, size 4
PCI: bus1: Fast back to back transfers disabled
dw_pcie_read, addr f09bc72c, size 4
[...]
dw_pcie_read, addr f09bc908, size 4
pci 0000:01:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
dw_pcie_read, addr f09bc72c, size 4
[...]
dw_pcie_read, addr f09bc72c, size 4
dw_pcie_read, addr f09bc908, size 4
dw_pcie_read, addr f0a80000, size 4
Unhandled fault: external abort on non-linefetch (0x1008) at 0xf0a80000
pgd = (ptrval)
[f0a80000] *pgd=3c5b1811, *pte=01f40243, *ppte=01f40013
Internal error: : 1008 [#1] PREEMPT SMP THUMB2
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.4-00044-ged7a0cc2ef01-dirty #459
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
PC is at dw_pcie_read+0x36/0x54
LR is at dw_pcie_read+0x19/0x54
pc : [<c034ab8e>]    lr : [<c034ab71>]    psr: 600000b3
sp : ec077b80  ip : 00000020  fp : 00000000
r10: ec077be0  r9 : ec531c10  r8 : 00000004
r7 : 00000000  r6 : ec077be0  r5 : 00000004  r4 : f0a80000
r3 : c0619ba3  r2 : c0619ba3  r1 : 00000002  r0 : 00000000
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA Thumb  Segment none
Control: 50c5387d  Table: 1000404a  DAC: 00000051
Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
Stack: (0xec077b80 to 0xec078000)
7b80: ec531c28 00000000 f0a80000 c034b3e7 01f40000 00000000 02000000 00000000
7ba0: 00040000 c0c67cc0 0000000a 00000000 c0dbe52c c0d04d08 c034b2f9 c0d1b650
7bc0: ec077c38 00000000 40000013 00000002 00000000 c03366cb ec077be0 00000010
7be0: 00000000 c0619ba3 ec077c30 c0d04d08 ec077c38 00000000 0000ea60 ec5c4400
7c00: ec085068 c033898f 00000002 c0322f29 c0336e17 c0d04d08 00000000 00000000
7c20: ec5c4400 00000000 ec085068 00000002 00000000 c0338e39 c0619ba3 c0619ba3
7c40: 00000001 ec5c4400 00000000 00000000 c0d04d08 c0338ea7 00000002 ec5c4400
7c60: ec085000 00000000 c0a81f0c c0339aaf 00000033 c0336e17 00000000 c0738cff
7c80: 00000002 c0336e17 00ff0201 ec5c4000 ec085000 ec5c4400 00000001 c0d04d08
7ca0: ec085068 00000002 00000000 c03398c9 ec5c4000 ec5c4478 00000000 00000000
7cc0: 00000000 00000001 c0a46ddc 00000001 00ff0201 c0619ba3 01400000 ec5c4000
7ce0: ec085000 00000001 ec5c4014 00000001 00000001 00000000 00000000 c0339bc9
7d00: 00000001 c011dd81 ec36bc00 00000001 00000001 c0339269 0011cc11 ec36bc00
7d20: ec084800 ec5c4000 00000000 c0d04d08 ec084868 00000001 000000ff c033994b
7d40: ec36bc00 00000000 00000000 00000000 00000000 00000001 c0a46ddc 00000001
7d60: 00ff0100 c0619ba3 01470000 ec36bc00 ec36bc14 ec084800 ec36bc14 00000000
7d80: 00000000 00000000 00000000 c0339b59 00000000 ec531c10 ec5aea40 00000001
7da0: 00000000 c0619ba3 00000000 ec531e00 00000000 ec5aebc0 ec1aee10 ec531fb0
7dc0: 00000000 ec531fb0 ec531e00 c0339d81 c033a32d ec531c28 00000000 c034ba41
7de0: 00000000 00000000 ef7df370 c0a85048 c0a70710 c0a85020 c0a84e4c ec41cc10
7e00: ec1aee10 ec531c10 ef7df370 ec1aee00 c0d1b760 00000000 00000000 c034c2fb
7e20: 00000000 00000000 ec1aee10 00000000 c0d1b760 00000000 00000000 c03e8351
7e40: c0dc7414 ec1aee10 c0dc7418 c03e7123 ec1aee10 c0d1b760 ec1aee44 c0d04d08
7e60: 00000000 c0c4a83c c0c5e820 c03e72b9 c0d04d08 c0738cff c08390cc ec1aee10
7e80: c0d1b760 ec1aee44 c0d04d08 00000000 c0c4a83c c0c5e820 00000000 c03e73ff
7ea0: 00000000 c0d1b760 c03e7391 c03e5e17 00000000 ec007b58 ec191fb4 c0619ba3
7ec0: ec007b6c c0d1b760 ec41cb80 00000000 c0d2eb58 c03e6933 c0a854e4 c0d1b760
7ee0: c0d04d08 c0d1b760 c0d04d08 ffffe000 c0c163fb c03e7995 c0d1b74c c0d69780
7f00: c0d04d08 c01026d7 c0c004fb 00000100 00000100 c012d500 c0abc94c c0c004fb
7f20: 00000000 00000006 00000006 c0a4caac 00000000 c0d04d08 c0a564cc c0a4cb20
7f40: 00000000 efffea7d efffea84 c0619ba3 00000000 c0619ba3 c0d69780 00000007
7f60: c0d69780 c0c4a834 c0d69780 00000100 c0c4a83c c0c00b59 00000006 00000006
7f80: 00000000 c0c004fb 00000000 c073429d 00000000 00000000 00000000 00000000
7fa0: 00000000 c07342a3 00000000 c01010f9 00000000 00000000 00000000 00000000
7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
7fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[<c034ab8e>] (dw_pcie_read) from [<c034b3e7>] (dw_pcie_rd_conf+0xef/0x120)
[<c034b3e7>] (dw_pcie_rd_conf) from [<c03366cb>] (pci_bus_read_config_dword+0x47/0x70)
[<c03366cb>] (pci_bus_read_config_dword) from [<c033898f>] (pci_bus_generic_read_dev_vendor_id+0x17/0xf4)
[<c033898f>] (pci_bus_generic_read_dev_vendor_id) from [<c0338e39>] (pci_scan_single_device+0x41/0x88)
[<c0338e39>] (pci_scan_single_device) from [<c0338ea7>] (pci_scan_slot+0x27/0x98)
[<c0338ea7>] (pci_scan_slot) from [<c0339aaf>] (pci_scan_child_bus_extend+0x2b/0x1c0)
[<c0339aaf>] (pci_scan_child_bus_extend) from [<c03398c9>] (pci_scan_bridge_extend+0x1ed/0x394)
[<c03398c9>] (pci_scan_bridge_extend) from [<c0339bc9>] (pci_scan_child_bus_extend+0x145/0x1c0)
[<c0339bc9>] (pci_scan_child_bus_extend) from [<c033994b>] (pci_scan_bridge_extend+0x26f/0x394)
[<c033994b>] (pci_scan_bridge_extend) from [<c0339b59>] (pci_scan_child_bus_extend+0xd5/0x1c0)
[<c0339b59>] (pci_scan_child_bus_extend) from [<c0339d81>] (pci_scan_root_bus_bridge+0x39/0x84)
[<c0339d81>] (pci_scan_root_bus_bridge) from [<c034ba41>] (dw_pcie_host_init+0x1e5/0x364)
[<c034ba41>] (dw_pcie_host_init) from [<c034c2fb>] (imx6_pcie_probe+0x22f/0x394)
[<c034c2fb>] (imx6_pcie_probe) from [<c03e8351>] (platform_drv_probe+0x2d/0x60)
[<c03e8351>] (platform_drv_probe) from [<c03e7123>] (really_probe+0x12f/0x1cc)
[<c03e7123>] (really_probe) from [<c03e72b9>] (driver_probe_device+0x3d/0x114)
[<c03e72b9>] (driver_probe_device) from [<c03e73ff>] (__driver_attach+0x6f/0x70)
[<c03e73ff>] (__driver_attach) from [<c03e5e17>] (bus_for_each_dev+0x3b/0x64)
[<c03e5e17>] (bus_for_each_dev) from [<c03e6933>] (bus_add_driver+0xff/0x164)
[<c03e6933>] (bus_add_driver) from [<c03e7995>] (driver_register+0x35/0x9c)
[<c03e7995>] (driver_register) from [<c01026d7>] (do_one_initcall+0x3f/0x128)
[<c01026d7>] (do_one_initcall) from [<c0c00b59>] (kernel_init_freeable+0x115/0x180)
[<c0c00b59>] (kernel_init_freeable) from [<c07342a3>] (kernel_init+0x7/0xd0)
[<c07342a3>] (kernel_init) from [<c01010f9>] (ret_from_fork+0x11/0x38)
Exception stack(0xec077fb0 to 0xec077ff8)
7fa0:                                     00000000 00000000 00000000 00000000
7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
Code: f3bf 8f4f 6033 bd70 (6823) f3bf
---[ end trace e82f75a9f4dd9bc8 ]---
note: swapper/0[1] exited with preempt_count 1
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    5.697939]
CPU1: stopping
CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D           4.19.4-00044-ged7a0cc2ef01-dirty #459
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[<c010d4f5>] (unwind_backtrace) from [<c01099fb>] (show_stack+0xb/0xc)
[<c01099fb>] (show_stack) from [<c0726a49>] (dump_stack+0x5d/0x6c)
[<c0726a49>] (dump_stack) from [<c010c34d>] (handle_IPI+0x149/0x158)
[<c010c34d>] (handle_IPI) from [<c0322f59>] (gic_handle_irq+0x6d/0x70)
[<c0322f59>] (gic_handle_irq) from [<c0101a65>] (__irq_svc+0x65/0xac)
Exception stack(0xec0b9f60 to 0xec0b9fa8)
9f60: 00000000 00000b10 ef7ad4cc c01145a1 ffffe000 c0d04d30 c0d04d6c 00000002
9f80: 00000000 c0d04d08 c0c675b0 c0a673b0 c0d04de4 ec0b9fb0 c01072dd c01072de
9fa0: 40000033 ffffffff
[<c0101a65>] (__irq_svc) from [<c01072de>] (arch_cpu_idle+0x22/0x24)
[<c01072de>] (arch_cpu_idle) from [<c01360f7>] (do_idle+0x14b/0x1dc)
[<c01360f7>] (do_idle) from [<c0136397>] (cpu_startup_entry+0x13/0x14)
[<c0136397>] (cpu_startup_entry) from [<10102491>] (0x10102491)
CPU2: stopping
CPU: 2 PID: 0 Comm: swapper/2 Tainted: G      D           4.19.4-00044-ged7a0cc2ef01-dirty #459
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[<c010d4f5>] (unwind_backtrace) from [<c01099fb>] (show_stack+0xb/0xc)
[<c01099fb>] (show_stack) from [<c0726a49>] (dump_stack+0x5d/0x6c)
[<c0726a49>] (dump_stack) from [<c010c34d>] (handle_IPI+0x149/0x158)
[<c010c34d>] (handle_IPI) from [<c0322f59>] (gic_handle_irq+0x6d/0x70)
[<c0322f59>] (gic_handle_irq) from [<c0101a65>] (__irq_svc+0x65/0xac)
Exception stack(0xec0bbf60 to 0xec0bbfa8)
bf60: 00000000 00000810 ef7bd4cc c01145a1 ffffe000 c0d04d30 c0d04d6c 00000004
bf80: 00000000 c0d04d08 c0c675b0 c0a673b0 c0d04de4 ec0bbfb0 c01072dd c01072de
bfa0: 40000033 ffffffff
[<c0101a65>] (__irq_svc) from [<c01072de>] (arch_cpu_idle+0x22/0x24)
[<c01072de>] (arch_cpu_idle) from [<c01360f7>] (do_idle+0x14b/0x1dc)
[<c01360f7>] (do_idle) from [<c0136397>] (cpu_startup_entry+0x13/0x14)
[<c0136397>] (cpu_startup_entry) from [<10102491>] (0x10102491)
CPU3: stopping
CPU: 3 PID: 0 Comm: swapper/3 Tainted: G      D           4.19.4-00044-ged7a0cc2ef01-dirty #459
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[<c010d4f5>] (unwind_backtrace) from [<c01099fb>] (show_stack+0xb/0xc)
[<c01099fb>] (show_stack) from [<c0726a49>] (dump_stack+0x5d/0x6c)
[<c0726a49>] (dump_stack) from [<c010c34d>] (handle_IPI+0x149/0x158)
[<c010c34d>] (handle_IPI) from [<c0322f59>] (gic_handle_irq+0x6d/0x70)
[<c0322f59>] (gic_handle_irq) from [<c0101a65>] (__irq_svc+0x65/0xac)
Exception stack(0xec0bdf60 to 0xec0bdfa8)
df60: 00000000 00000630 ef7cd4cc c01145a1 ffffe000 c0d04d30 c0d04d6c 00000008
df80: 00000000 c0d04d08 c0c675b0 c0a673b0 c0d04de4 ec0bdfb0 c01072dd c01072de
dfa0: 40000033 ffffffff
[<c0101a65>] (__irq_svc) from [<c01072de>] (arch_cpu_idle+0x22/0x24)
[<c01072de>] (arch_cpu_idle) from [<c01360f7>] (do_idle+0x14b/0x1dc)
[<c01360f7>] (do_idle) from [<c0136397>] (cpu_startup_entry+0x13/0x14)
[<c0136397>] (cpu_startup_entry) from [<10102491>] (0x10102491)
---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
 ]---

The patches I have ontop of 4.19.4 are all unrelated. I also can
reproduce the issue on a vanilla 4.18 kernel. Not really sure what
is going on here or how to debug that issue... Anybody else seen
this?

--
Stefan
