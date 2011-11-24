Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:57857 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464Ab1KXDcu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2011 22:32:50 -0500
MIME-Version: 1.0
In-Reply-To: <20111123180134.GJ9581@n2100.arm.linux.org.uk>
References: <CAHM4w1kc+5aYWH-09BPTXZdo8+iguFjORKs7mMhG7hea2UU8yQ@mail.gmail.com>
	<CAHM4w1nZ7GgutiuDiTCKu9wUuphn8qOiWgmCYVXXvwW1q8CgoA@mail.gmail.com>
	<20111122150613.GA322@google.com>
	<CAHM4w1nsNTQmAL-0d76O9cYXjNbiq-0f60Y3emWO2yf7HyFWDg@mail.gmail.com>
	<20111123162937.GF25780@google.com>
	<20111123180134.GJ9581@n2100.arm.linux.org.uk>
Date: Thu, 24 Nov 2011 09:02:50 +0530
Message-ID: <CAHM4w1nrrcd7TXhnAsujYER6g+r9xtRe6bCfXfSF5Yk26kg0Ng@mail.gmail.com>
Subject: Re: Crash with sata_sil24 driver
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tejun Heo <tj@kernel.org>, linux-pci@vger.kernel.org,
	linux-ide@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 23, 2011 at 11:31 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Nov 23, 2011 at 08:29:37AM -0800, Tejun Heo wrote:
>> On Wed, Nov 23, 2011 at 10:49:00AM +0530, Pratyush Anand wrote:
>> > On Tue, Nov 22, 2011 at 8:36 PM, Tejun Heo <tj@kernel.org> wrote:
>> > > On Tue, Nov 22, 2011 at 04:40:40PM +0530, Pratyush Anand wrote:
>> > >> > My question is.
>> > >> > does sil24_init_controller insure perfact initilization?
>> > >> > or we missing to check some status register which might be needed
>> > >> > before ata_host_activate.
>> > >> > ---------------------------------------------------------------------
>> > >> > Modules linked in:
>> > >> > CPU: 0    Not tainted  (2.6.37-lsp-3.2.2-rc-dirty #7)
>> > >> > PC is at sil24_scr_read+0x38/0x50
>> > >> > LR is at sil24_port_base+0x14/0x2c
>> > >> > pc : [<80255e10>]    lr : [<80255d44>]    psr: 80000013
>
> It would help if the _full_ set of kernel crash messages were included.
> This one has the top chopped off it which normally says _why_ it happened.
> I'm not about to waste my time by guessing...
>
> Please provide the _full_ crash log, including the lines which come before
> "Modules linked in:"
>
> And no, pci_iomap is not asynchronous.  That'd just be damned stupid and
> would break virtually all drivers.
>

Please find complete crash log

Uncompressing Linux... done, booting the kernel.
Linux version 2.6.37-lsp-3.2.2-rc-dirty (mohitku@dlhl1045) (gcc
version 4.5.1 20100731 (STMicroelectronics/Linux Base 4.5.1-87) (GCC)
) #7 SMP Mo
n Nov 21 09:49:41 IST 2011
CPU: ARMv7 Processor [412fc091] revision 1 (ARMv7), cr=10c53c7f
CPU: VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine: ST-SPEAR1340-EVB
Memory policy: ECC disabled, Data cache writealloc
PERCPU: Embedded 7 pages/cpu @80ec3000 s4736 r8192 d15744 u32768
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 256032
Kernel command line: console=ttyAMA0,115200 root=/dev/nfs
nfsroot=10.199.16.23:/opt/STM/STLinux-2.4/devkit/armv7/target
ip=10.199.16.147:10.199.1
6.23::255.255.255.0::eth0
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1008MB = 1008MB total
Memory: 1016204k/1016204k available, 15988k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
    vmalloc : 0xbf800000 - 0xf6c00000   ( 884 MB)
    lowmem  : 0x80000000 - 0xbf000000   (1008 MB)
    pkmap   : 0x7fe00000 - 0x80000000   (   2 MB)
    modules : 0x7f000000 - 0x7fe00000   (  14 MB)
      .init : 0x80008000 - 0x80035000   ( 180 kB)
      .text : 0x80035000 - 0x804e1000   (4784 kB)
      .data : 0x804e2000 - 0x80540720   ( 378 kB)
SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
Hierarchical RCU implementation.
NR_IRQS:476
Console: colour dummy device 80x30
Calibrating delay loop... 996.14 BogoMIPS (lpj=4980736)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
Calibrating local timer... 249.98MHz.
CPU1: Booted secondary processor
Brought up 2 CPUs
SMP: Total of 2 processors activated (1992.29 BogoMIPS).
NET: Registered protocol family 16
L310 cache controller enabled
l2x0: 8 ways, CACHE_ID 0x410000c5, AUX_CTRL 0x72a60001, Cache size: 524288 B
Serial: AMBA PL011 UART driver
uart: ttyAMA0 at MMIO 0xe0000000 (irq = 67) is a PL011 rev2
console [ttyAMA0] enabled
dw_pcie dw_pcie.0: link down
PCI: bus0: Fast back to back transfers disabled
PCI: bus1: Fast back to back transfers disabled
pci 0000:00:00.0: BAR 0: can't assign mem (size 0x80000000)
pci 0000:00:00.0: BAR 8: assigned [mem 0x80100000-0x801fffff]
pci 0000:00:00.0: BAR 6: assigned [mem 0x80010000-0x8001ffff pref]
pci 0000:00:00.0: BAR 7: assigned [io  0x80000-0x80fff]
pci 0000:01:00.0: BAR 2: assigned [mem 0x80100000-0x80101fff 64bit]
pci 0000:01:00.0: BAR 2: set to [mem 0x80100000-0x80101fff 64bit] (PCI
address [0x80100000-0x80101fff])
pci 0000:01:00.0: BAR 0: assigned [mem 0x80102000-0x8010207f 64bit]
pci 0000:01:00.0: BAR 0: set to [mem 0x80102000-0x8010207f 64bit] (PCI
address [0x80102000-0x8010207f])
pci 0000:01:00.0: BAR 4: assigned [io  0x80000-0x8007f]
pci 0000:01:00.0: BAR 4: set to [io  0x80000-0x8007f] (PCI address
[0x80000-0x8007f])
pci 0000:00:00.0: PCI bridge to [bus 01-01]
pci 0000:00:00.0:   bridge window [io  0x80000-0x80fff]
pci 0000:00:00.0:   bridge window [mem 0x80100000-0x801fffff]
pci 0000:00:00.0:   bridge window [mem pref disabled]
pcie init successful
plgpio plgpio: Initialization successful
bio: create slab <bio-0> at 0
dw_dmac.0: DesignWare DMA Controller, 8 channels
dw_dmac.1: DesignWare DMA Controller, 8 channels
vgaarb: loaded
SCSI subsystem initialized
ssp-pl022 ssp-pl022: ARM PL022 driver, device ID: 0x00241022
pl022: mapped registers from 0xe0100000 to bf922000
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
stmpe-i2c 1-0041: stmpe801 detected, chip id: 0x108
Trying to install interrupt handler for IRQ443
Advanced Linux Sound Architecture Driver Version 1.0.23.
Switching to clocksource tmr1
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 8, 1310720 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
UDP hash table entries: 512 (order: 2, 24576 bytes)
UDP-Lite hash table entries: 512 (order: 2, 24576 bytes)
NET: Registered protocol family 1
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
pwm pwm: Initialization successful
JFFS2 version 2.2. (NAND) �© 2001-2006 Red Hat, Inc.
msgmni has been set to 1984
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: enabling device 0000:00:00.0 (0140 -> 0143)
clcd-db9000 clcd-db9000: got a 1024x768x32 LCD
clcd-db9000 clcd-db9000: db9000fb_probe: Core ID reg: 0x0000450E
[C3 INFO] - Crypto Channel Controller (c) ST Microelectronics
[C3 INFO] - Driver version = 2.0
[C3 INFO] - Built on Nov 21 2011 at 09:40:44
[C3 INFO] - C3 device found (HID: ffff8000)
[C3 INFO] - Using scatter & gather for AES operations (threshold: 4096 bytes)
[C3 Info]:Allocating AES [CBC,CTR,RFC3686(CTR)], SHA 1, HMAC(SHA 1) algorithms
[C3 Info]:Note: All operations are Asynchronous
[C3 Info]:C3 cbc(aes) registered
[C3 Info]:C3 ctr(aes) registered
[C3 Info]:C3 rfc3686(ctr(aes)) registered
[C3 Info]:C3 sha1 registered
[C3 Info]:C3 hmac(sha1) registered
adc adc: registeration successful
uart-pl011 uart: no DMA platform data
brd: module loaded
spear_cec spear_cec.0: spear_cec:registered�·at�·0xbf9b2000
spear_cec spear_cec.1: spear_cec:registered�·at�·0xbf9b6000
st: Version 20100829, fixed bufsize 32768, s/g segs 256
osst :I: Tape driver with OnStream support version 0.99.4
osst :I: $Id: osst.c,v 1.73 2005/01/01 21:13:34 wriede Exp $
SCSI Media Changer driver v0.25
PCI: enabling device 0000:01:00.0 (0140 -> 0143)
scsi0 : sata_sil24
Unhandled fault: imprecise external abort (0x1406) at 0x80511104
Internal error: : 1406 [#1] SMP
last sysfs file:
Modules linked in:
CPU: 0    Not tainted  (2.6.37-lsp-3.2.2-rc-dirty #7)
PC is at sil24_scr_read+0x38/0x50
LR is at sil24_port_base+0x14/0x2c
pc : [<80255e10>]    lr : [<80255d44>]    psr: 80000013
sp : be841d10  ip : be841cf8  fp : be841d24
r10: be839810  r9 : 00000080  r8 : be934000
r7 : 00000000  r6 : 00000002  r5 : be9354bc  r4 : 00000002
r3 : 00000000  r2 : be9354bc  r1 : 00000002  r0 : bf9c1f00
Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c53c7d  Table: 0000404a  DAC: 00000017
Process swapper (pid: 1, stack limit = 0xbe8402f0)
Stack: (0xbe841d10 to 0xbe842000)
1d00:                                     be9353b0 be9354bc be841d44 be841d28
1d20: 8023e498 80255de4 00000006 be9353b0 00000000 be839810 be841d7c be841d48
1d40: 80244514 8023e464 be841d7c be841d58 80248d28 be839810 00000000 be839810
1d60: 00000000 be934000 00000080 be839810 be841dbc be841d80 802447c8 80244500
1d80: be9354d0 000001af be841db0 be841d98 80249a64 be839810 000001af 80524ad8
1da0: 00000001 be839818 00000080 be87d860 be841dfc be841dc0 8024499c 802446ac
1dc0: 00000080 8049960f be839810 801b0488 80244c44 be87d800 be87d860 be94d650
1de0: be839810 802563fc 00000000 00000000 be841e4c be841e00 80256558 802448e0
1e00: 80524ad8 80110e10 80524a58 000e048e 00000000 0000001f 00000007 0000003f
1e20: 80524d3c 00000000 be841e0c 00000000 be87d800 be87d860 80524a58 00000000
1e40: be841e5c be841e50 801b5ce4 80256408 be841e94 be841e60 801b6c0c 801b5ccc
1e60: 801118bc 80524a58 be87d800 803db4b0 8020e900 be87d860 be87d860 80524a88
1e80: 80524a88 00000000 be841eb4 be841e98 8020ebbc 801b6bac be87d860 be87d894
1ea0: 80524a88 00000000 be841ed4 be841eb8 8020ecd4 8020eb18 8020ec6c 80524a88
1ec0: 8020ec6c 00000000 be841efc be841ed8 8020ddb0 8020ec78 be863108 be8995e0
1ee0: 8019bc38 80524a88 be8316c0 80513db8 be841f0c be841f00 8020e894 8020dd68
1f00: be841f3c be841f10 8020e4bc 8020e880 8049960f be841f20 80524a88 80513db8
1f20: 80562a54 80524a88 00000000 00000000 be841f6c be841f40 8020f158 8020e414
1f40: 80524acc 80524a58 80513db8 80562a54 80524a88 00000000 00000000 00000000
1f60: be841f8c be841f70 801b6e94 8020f0b4 8002ad08 804f5bc0 80562a54 80021f18
1f80: be841f9c be841f90 80021f34 801b6e50 be841fd4 be841fa0 80035698 80021f24
1fa0: 804f5bc0 80562a54 be841fd4 be841fb8 8009490c 8002ad08 804f5bc0 80562a54
1fc0: 00000013 00000000 be841ff4 be841fd8 80008b5c 800355e4 00000000 00000000
1fe0: 80008a08 8005fcfc 00000000 be841ff8 8005fcfc 80008a14 2194c965 c26a40a0
Backtrace:
[<80255dd8>] (sil24_scr_read+0x0/0x50) from [<8023e498>]
(sata_scr_read+0x40/0x4c)
 r5:be9354bc r4:be9353b0
[<8023e458>] (sata_scr_read+0x0/0x4c) from [<80244514>]
(sata_link_init_spd+0x20/0x1ac)
 r6:be839810 r5:00000000 r4:be9353b0 r3:00000006
[<802444f4>] (sata_link_init_spd+0x0/0x1ac) from [<802447c8>]
(ata_host_register+0x128/0x234)
[<802446a0>] (ata_host_register+0x0/0x234) from [<8024499c>]
(ata_host_activate+0xc8/0xf4)
[<802448d4>] (ata_host_activate+0x0/0xf4) from [<80256558>]
(sil24_init_one+0x15c/0x1a8)
[<802563fc>] (sil24_init_one+0x0/0x1a8) from [<801b5ce4>]
(local_pci_probe+0x24/0x28)
 r7:00000000 r6:80524a58 r5:be87d860 r4:be87d800
[<801b5cc0>] (local_pci_probe+0x0/0x28) from [<801b6c0c>]
(pci_device_probe+0x6c/0x98)
[<801b6ba0>] (pci_device_probe+0x0/0x98) from [<8020ebbc>]
(driver_probe_device+0xb0/0x160)
 r8:00000000 r7:80524a88 r6:80524a88 r5:be87d860 r4:be87d860
[<8020eb0c>] (driver_probe_device+0x0/0x160) from [<8020ecd4>]
(__driver_attach+0x68/0x8c)
 r7:00000000 r6:80524a88 r5:be87d894 r4:be87d860
[<8020ec6c>] (__driver_attach+0x0/0x8c) from [<8020ddb0>]
(bus_for_each_dev+0x54/0x84)
 r6:00000000 r5:8020ec6c r4:80524a88 r3:8020ec6c
[<8020dd5c>] (bus_for_each_dev+0x0/0x84) from [<8020e894>]
(driver_attach+0x20/0x28)
 r6:80513db8 r5:be8316c0 r4:80524a88
[<8020e874>] (driver_attach+0x0/0x28) from [<8020e4bc>]
(bus_add_driver+0xb4/0x234)
[<8020e408>] (bus_add_driver+0x0/0x234) from [<8020f158>]
(driver_register+0xb0/0x138)
[<8020f0a8>] (driver_register+0x0/0x138) from [<801b6e94>]
(__pci_register_driver+0x50/0xcc)
[<801b6e44>] (__pci_register_driver+0x0/0xcc) from [<80021f34>]
(sil24_init+0x1c/0x28)
 r7:80021f18 r6:80562a54 r5:804f5bc0 r4:8002ad08
[<80021f18>] (sil24_init+0x0/0x28) from [<80035698>]
(do_one_initcall+0xc0/0x194)
[<800355d8>] (do_one_initcall+0x0/0x194) from [<80008b5c>]
(kernel_init+0x154/0x21c)
 r8:00000000 r7:00000013 r6:80562a54 r5:804f5bc0 r4:8002ad08
[<80008a08>] (kernel_init+0x0/0x21c) from [<8005fcfc>] (do_exit+0x0/0x5f8)
 r6:8005fcfc r5:80008a08 r4:00000000 r3:00000000
Code: e2800c1f e7933104 e7903103 f57ff05f (e3a00000)
---[ end trace 98e8e27f91855523 ]---
Kernel panic - not syncing: Attempted to kill init!
Backtrace:
[<8003e9fc>] (dump_backtrace+0x0/0x10c) from [<803bd99c>] (dump_stack+0x18/0x1c)
 r6:be83c000 r5:8050e0b0 r4:80542150 r3:60000113
[<803bd984>] (dump_stack+0x0/0x1c) from [<803bd9fc>] (panic+0x5c/0x17c)
[<803bd9a0>] (panic+0x0/0x17c) from [<8005fd64>] (do_exit+0x68/0x5f8)
 r3:8050e0b0 r2:00000000 r1:00000001 r0:80473617
 r7:00000000
[<8005fcfc>] (do_exit+0x0/0x5f8) from [<8003ee5c>] (die+0x2a0/0x2e0)
 r7:00000000
[<8003ebbc>] (die+0x0/0x2e0) from [<8003eef0>] (arm_notify_die+0x54/0x58)
[<8003ee9c>] (arm_notify_die+0x0/0x58) from [<80035428>]
(do_DataAbort+0x8c/0xa0)
[<8003539c>] (do_DataAbort+0x0/0xa0) from [<8003a6cc>] (__dabt_svc+0x4c/0x60)
Exception stack(0xbe841cc8 to 0xbe841d10)
1cc0:                   bf9c1f00 00000002 be9354bc 00000000 00000002 be9354bc
1ce0: 00000002 00000000 be934000 00000080 be839810 be841d24 be841cf8 be841d10
1d00: 80255d44 80255e10 80000013 ffffffff
 r8:be934000 r7:00000000 r6:00000002 r5:be841cfc r4:ffffffff
[<80255dd8>] (sil24_scr_read+0x0/0x50) from [<8023e498>]
(sata_scr_read+0x40/0x4c)
 r5:be9354bc r4:be9353b0
[<8023e458>] (sata_scr_read+0x0/0x4c) from [<80244514>]
(sata_link_init_spd+0x20/0x1ac)
 r6:be839810 r5:00000000 r4:be9353b0 r3:00000006
[<802444f4>] (sata_link_init_spd+0x0/0x1ac) from [<802447c8>]
(ata_host_register+0x128/0x234)
[<802446a0>] (ata_host_register+0x0/0x234) from [<8024499c>]
(ata_host_activate+0xc8/0xf4)
[<802448d4>] (ata_host_activate+0x0/0xf4) from [<80256558>]
(sil24_init_one+0x15c/0x1a8)
[<802563fc>] (sil24_init_one+0x0/0x1a8) from [<801b5ce4>]
(local_pci_probe+0x24/0x28)
 r7:00000000 r6:80524a58 r5:be87d860 r4:be87d800
[<801b5cc0>] (local_pci_probe+0x0/0x28) from [<801b6c0c>]
(pci_device_probe+0x6c/0x98)
[<801b6ba0>] (pci_device_probe+0x0/0x98) from [<8020ebbc>]
(driver_probe_device+0xb0/0x160)
 r8:00000000 r7:80524a88 r6:80524a88 r5:be87d860 r4:be87d860
[<8020eb0c>] (driver_probe_device+0x0/0x160) from [<8020ecd4>]
(__driver_attach+0x68/0x8c)
 r7:00000000 r6:80524a88 r5:be87d894 r4:be87d860
[<8020ec6c>] (__driver_attach+0x0/0x8c) from [<8020ddb0>]
(bus_for_each_dev+0x54/0x84)
 r6:00000000 r5:8020ec6c r4:80524a88 r3:8020ec6c
[<8020dd5c>] (bus_for_each_dev+0x0/0x84) from [<8020e894>]
(driver_attach+0x20/0x28)
 r6:80513db8 r5:be8316c0 r4:80524a88
[<8020e874>] (driver_attach+0x0/0x28) from [<8020e4bc>]
(bus_add_driver+0xb4/0x234)
[<8020e408>] (bus_add_driver+0x0/0x234) from [<8020f158>]
(driver_register+0xb0/0x138)
[<8020f0a8>] (driver_register+0x0/0x138) from [<801b6e94>]
(__pci_register_driver+0x50/0xcc)
[<801b6e44>] (__pci_register_driver+0x0/0xcc) from [<80021f34>]
(sil24_init+0x1c/0x28)
 r7:80021f18 r6:80562a54 r5:804f5bc0 r4:8002ad08
[<80021f18>] (sil24_init+0x0/0x28) from [<80035698>]
(do_one_initcall+0xc0/0x194)
[<800355d8>] (do_one_initcall+0x0/0x194) from [<80008b5c>]
(kernel_init+0x154/0x21c)
 r8:00000000 r7:00000013 r6:80562a54 r5:804f5bc0 r4:8002ad08
[<80008a08>] (kernel_init+0x0/0x21c) from [<8005fcfc>] (do_exit+0x0/0x5f8)
 r6:8005fcfc r5:80008a08 r4:00000000 r3:00000000
CPU1: stopping
Backtrace:
[<8003e9fc>] (dump_backtrace+0x0/0x10c) from [<803bd99c>] (dump_stack+0x18/0x1c)
 r6:800338b4 r5:80567748 r4:00000000 r3:60000193
[<803bd984>] (dump_stack+0x0/0x1c) from [<80035338>] (do_IPI+0xac/0x110)
[<8003528c>] (do_IPI+0x0/0x110) from [<8003a714>] (__irq_svc+0x34/0xc0)
Exception stack(0xbe859f70 to 0xbe859fb8)
9f60:                                     be859f88 00000000 be859fb8 00000000
9f80: 8050f564 00000001 be858000 80540940 00000000 412fc091 00000000 be859fc4
9fa0: be859fc8 be859fb8 8003bdc4 8003bdc8 60000013 ffffffff
 r7:80540940 r6:00000006 r5:fec80100 r4:ffffffff
[<8003bd9c>] (default_idle+0x0/0x30) from [<8003bf98>] (cpu_idle+0x70/0xbc)
[<8003bf28>] (cpu_idle+0x0/0xbc) from [<803bb1bc>]
(secondary_start_kernel+0x100/0x110)
[<803bb0bc>] (secondary_start_kernel+0x0/0x110) from [<003bab8c>] (0x3bab8c)
 r6:10c03c7d r5:0000001f r4:3e85c06a r3:803bab74
