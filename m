Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:51035 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759688Ab3EXCyd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 May 2013 22:54:33 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz11so1005230pad.30
        for <linux-pci@vger.kernel.org>; Thu, 23 May 2013 19:54:32 -0700 (PDT)
Date: Fri, 24 May 2013 10:54:24 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Liu Jiang <liuj97@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI: unset the resource if we can't get the correct
 CPU address
Message-ID: <20130524025424.GC23166@pek-khao-d1.corp.ad.wrs.com>
References: <1368536876-27307-1-git-send-email-haokexin@gmail.com>
 <1368536876-27307-3-git-send-email-haokexin@gmail.com>
 <519506BF.3010400@gmail.com>
 <20130517021128.GB13975@pek-khao-d1.corp.ad.wrs.com>
 <519643E8.3020102@gmail.com>
 <20130519022445.GA25698@pek-khao-d1.corp.ad.wrs.com>
 <CAErSpo6vTqgN3MFZ9TmAzHHhnzP5bUip=G=djd80RE-7upJ+gA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rqzD5py0kzyFAOWN"
In-Reply-To: <CAErSpo6vTqgN3MFZ9TmAzHHhnzP5bUip=G=djd80RE-7upJ+gA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--rqzD5py0kzyFAOWN
Content-Type: multipart/mixed; boundary="sHrvAb52M6C8blB9"
Content-Disposition: inline


--sHrvAb52M6C8blB9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2013 at 02:22:58PM -0600, Bjorn Helgaas wrote:
> On Sat, May 18, 2013 at 8:24 PM, Kevin Hao <haokexin@gmail.com> wrote:
> > On Fri, May 17, 2013 at 10:51:20PM +0800, Liu Jiang wrote:
> >> On Fri 17 May 2013 10:11:29 AM CST, Kevin Hao wrote:
> >> >On Fri, May 17, 2013 at 12:18:07AM +0800, Liu Jiang wrote:
> >> >>On Tue 14 May 2013 09:07:56 PM CST, Kevin Hao wrote:
> >> >>>In the current kernel, we just set the CPU address to the bus addre=
ss
> >> >>>if we can't find the match region for one specific bus address. If =
BAR
> >> >>>of one pci device is set to address which happens to be a legitimate
> >> >>>CPU address by firmware, the kernel will think this resource is leg=
al
> >> >>>and will not try to reassign later. In cases the CPU address and bus
> >> >>>address isn't equal, the device will not work. So we should check
> >> >>>if we can translate the bus address to CPU address correctly. If no=
t,
> >> >>>we should unset this resource and wish the kernel will reassign it
> >> >>>later.
> >> >>>
> >> >>>Since we will invoke pcibios_bus_to_resource unconditionally if we
> >> >>>don't goto fail, move it out of if/else wrap.
> >> >>>
> >> >>>Signed-off-by: Kevin Hao <haokexin@gmail.com>
> >> >>>---
> >> >>>  drivers/pci/probe.c | 9 ++++++---
> >> >>>  1 file changed, 6 insertions(+), 3 deletions(-)
> >> >>>
> >> >>>diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> >> >>>index 70f10fa..c96772f 100644
> >> >>>--- a/drivers/pci/probe.c
> >> >>>+++ b/drivers/pci/probe.c
> >> >>>@@ -250,12 +250,10 @@ int __pci_read_base(struct pci_dev *dev, enum=
 pci_bar_type type,
> >> >>>                   pci_write_config_dword(dev, pos + 4, 0);
> >> >>>                   region.start =3D 0;
> >> >>>                   region.end =3D sz64;
> >> >>>-                  pcibios_bus_to_resource(dev, res, &region);
> >> >>>                   bar_disabled =3D true;
> >> >>>           } else {
> >> >>>                   region.start =3D l64;
> >> >>>                   region.end =3D l64 + sz64;
> >> >>>-                  pcibios_bus_to_resource(dev, res, &region);
> >> >>>           }
> >> >>>   } else {
> >> >>>           sz =3D pci_size(l, sz, mask);
> >> >>>@@ -265,7 +263,12 @@ int __pci_read_base(struct pci_dev *dev, enum =
pci_bar_type type,
> >> >>>
> >> >>>           region.start =3D l;
> >> >>>           region.end =3D l + sz;
> >> >>>-          pcibios_bus_to_resource(dev, res, &region);
> >> >>>+  }
> >> >>>+
> >> >>>+  if (!pcibios_bus_to_resource(dev, res, &region)) {
> >> >>>+          res->flags |=3D IORESOURCE_UNSET;
> >> >>>+          res->end -=3D res->start;
> >> >>>+          res->start =3D 0;
> >> >>>   }
> >> >>>
> >> >>>   goto out;
> >> >>
> >> >>Hi Kevin,
> >> >>      Will this break subtractive decode PCI bridges and devices?
> >> >
> >> >No. A subtractive decode occurs only when no other pci bridge or devi=
ce
> >> >claim the transactions. As you can see that when we are trying to tra=
nslate
> >> >a bus address to cpu address we search the address regions of pci host
> >> >bridge instead of a pci bridge. The pci host bridge address regions s=
hould
> >> >cover all the bus address we can use for the pci device or bridge und=
er this
> >> >pci controller. This definitely also include the bus address regions =
used by
> >> >the expansion bus for subtractive decode. So if a pci device use a bu=
s address
> >> >that is unknown to this pci host bridge, there is definitely somethin=
g wrong
> >> >here. This is the case we are trying to fix.
> >> >
> >> Hi Kevin,
> >>       I'm not sure about this assumption "the pci host bridge
> >> address regions should cover
> >> all the bus address we can use for the pci device or bridge under
> >> this pci controller".
> >> I have a fear that it may cause regressions to some legacy x86
> >> platforms, such as an AMD
> >> platform with PCI based IOAPICs, though I have no evidences for it.
> >
> > Does any x86 expert can confirm whether the assumption that "the pci ho=
st
> > bridge address regions should cover all the bus address we can use for =
the
> > pci device or bridge under this pci host bridge" is true or not on x86?
> > It seems definitely wrong in logical. But things always happen out of
> > expectation in reality. :-)
>=20
> You're changing generic code, not x86-specific code, so you need the
> assumption to hold on all architectures.

Indeed.

>  I don't know off-hand
> whether it's true or not.

I think it should be true in general. If some architecture or platform
does break this assumption, we should fix it in architecture or platform
level, just as what you did for bug 31602.

>=20
> Can you save me some time by collecting a full dmesg showing the
> problem, and maybe one with your fix?

I attached the full kernel and lspci log for the current kernel and the
one applied my fix.

>  I know there are cases where we
> notice a BAR assignment that we think is incorrect, e.g.,
> https://bugzilla.kernel.org/show_bug.cgi?id=3D31602 (fixed by
> eb31aae8cb5) and we reassign it, and I want to know how your case is
> different from that.

The bug 31602 is that the bios doesn't report the memory region claimed
by the pci host controller correctly. In my case, the bootloader assign
a wrong bus address to the pci device and this bus address happens to
be a legal memory address for the kernel. In the current implementation
of pcibios_bus_to_resource, it can't detect this illegal bus address and
just use it as the memory address. So the pci subsystem doesn't reassign
the resource for this pci device and leave a illegal bus address set in
this pci device BAR, it definitely causes this device not work.

The bootloader assigned the following bus address to device 0000:01:00.0:
	Region 0: bus address at a0000000 (64-bit, non-prefetchable) [size=3D128]

In the current kernel, the pci host bridge use the following address region=
s:
  pci_bus 0000:00: root bus resource [mem 0xa0000000-0xbfffffff] (bus addre=
ss [0xe0000000-0xffffffff])

And no reassign for device 0000:01:00.0.

With my fix, the device 0000:01:00.0 is reassigned with the correct bus add=
ress:
  pci_bus 0000:00: root bus resource [mem 0xa0000000-0xbfffffff] (bus addre=
ss [0xe0000000-0xffffffff])
  pci 0000:01:00.0: BAR 6: assigned [mem 0xa0000000-0xa007ffff pref]
  pci 0000:01:00.0: BAR 2: assigned [mem 0xa0080000-0xa0083fff 64bit]
  pci 0000:01:00.0: BAR 0: assigned [mem 0xa0084000-0xa008407f 64bit]

As you can see in the current kernel the pci subsystem doesn't detect
this wrong bus address and don't try a reassign what it should do.
My patches is trying to fix this issue.

Thanks,
Kevin
>=20
> Bjorn

--sHrvAb52M6C8blB9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="not-work.txt"
Content-Transfer-Encoding: quoted-printable

Using P2020RDB-PC machine description
Memory CAM mapping: 256/256/256 Mb, residual: 256Mb
Linux version 3.10.0-rc2-00088-g6ae7b7f (kevin@pek-khao-d1) (gcc version 4.=
6.3 (Wind River Linux Sourcery CodeBench 4.6a-99) ) #101 SMP Fri May 24 10:=
00:45 CST 2013
Found legacy serial port 0 for /soc@ffe00000/serial@4500
  mem=3Dffe04500, taddr=3Dffe04500, irq=3D0, clk=3D600000000, speed=3D0
Found legacy serial port 1 for /soc@ffe00000/serial@4600
  mem=3Dffe04600, taddr=3Dffe04600, irq=3D0, clk=3D600000000, speed=3D0
CPU maps initialized for 1 thread per core
 (thread shift is 0)
bootconsole [udbg0] enabled
mpc85xx_rdb_setup_arch: Could not find Quicc Engine node
MPC85xx RDB board from Freescale Semiconductor
Top of RAM: 0x40000000, Total RAM: 0x40000000
Memory hole size: 0MB
Zone ranges:
  DMA      [mem 0x00000000-0x2fffffff]
  Normal   empty
  HighMem  [mem 0x30000000-0x3fffffff]
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x00000000-0x3fffffff]
On node 0 totalpages: 262144
free_area_init_node: node 0, pgdat c07965e0, node_mem_map c0816000
  DMA zone: 1536 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 196608 pages, LIFO batch:31
  HighMem zone: 512 pages used for memmap
  HighMem zone: 65536 pages, LIFO batch:15
MMU: Allocated 1088 bytes of context maps for 255 contexts
PERCPU: Embedded 7 pages/cpu @c101d000 s6752 r8192 d13728 u32768
pcpu-alloc: s6752 r8192 d13728 u32768 alloc=3D8*4096
pcpu-alloc: [0] 0 [0] 1=20
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260608
Kernel command line: root=3D/dev/nfs rw nfsroot=3D128.224.178.20:/export/px=
eboot/vlm-boards/21080/rootfs ip=3D128.224.178.28:128.224.178.20:128.224.17=
8.1:255.255.254.0:unknown:eth2:off console=3DttyS0,115200 enforcing=3D0
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Sorting __ex_table...
High memory: 262140k
Memory: 965152k/1048576k available (7540k kernel code, 83424k reserved, 300=
k data, 429k bss, 264k init)
Kernel virtual memory layout:
  * 0xfff5f000..0xfffff000  : fixmap
  * 0xffc00000..0xffe00000  : highmem PTEs
  * 0xffbfd000..0xffc00000  : early ioremap
  * 0xf1000000..0xffbfd000  : vmalloc & ioremap
SLUB: HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D2, Nodes=3D1
Hierarchical RCU implementation.
	RCU restricting CPUs from NR_CPUS=3D8 to nr_cpu_ids=3D2.
NR_IRQS:512 nr_irqs:512 16
mpic: Resetting
mpic: Setting up MPIC " OpenPIC  " version 1.2 at ffe40000, max 2 CPUs
mpic: ISU size: 256, shift: 8, mask: ff
mpic: Initializing for 256 sources
mpc85xx_rdb_pic_init: Could not find qe-ic node
time_init: decrementer frequency =3D 75.000000 MHz
time_init: processor frequency   =3D 1200.000000 MHz
clocksource: timebase mult[d555555] shift[24] registered
clockevent: decrementer mult[13333333] shift[32] cpu[0]
Console: colour dummy device 80x25
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
mpic: requesting IPIs...
Brought up 2 CPUs
devtmpfs: initialized
NET: Registered protocol family 16
Found FSL PCI host bridge at 0x00000000ffe09000. Firmware bus number: 0->1
PCI host bridge /pcie@ffe09000 (primary) ranges:
 MEM 0x00000000a0000000..0x00000000bfffffff -> 0x00000000e0000000=20
  IO 0x00000000ffc10000..0x00000000ffc1ffff -> 0x0000000000000000
/pcie@ffe09000: PCICSRBAR @ 0xdff00000
Found FSL PCI host bridge at 0x00000000ffe0a000. Firmware bus number: 0->0
PCI host bridge /pcie@ffe0a000  ranges:
 MEM 0x0000000080000000..0x000000009fffffff -> 0x00000000e0000000=20
  IO 0x00000000ffc00000..0x00000000ffc0ffff -> 0x0000000000000000
/pcie@ffe0a000: PCICSRBAR @ 0xdff00000
PCI: Probing PCI hardware
PCI: Memory resource 0 not set for host bridge /pcie@ffe09000 (domain 0)
PCI: Memory resource 0 not set for host bridge /pcie@ffe09000 (domain 0)
fsl-pci ffe09000.pcie: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
pci_bus 0000:00: root bus resource [mem 0xa0000000-0xbfffffff] (bus address=
 [0xe0000000-0xffffffff])
pci_bus 0000:00: root bus resource [bus 00-ff]
pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to ff
pci 0000:00:00.0: [1957:0070] type 01 class 0x0b2000
pci 0000:00:00.0: ignoring class 0x0b2000 (doesn't match header type 01)
pci 0000:00:00.0: supports D1 D2
pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:01:00.0: [1095:3132] type 00 class 0x018000
pci 0000:01:00.0: reg 10: [mem 0xa0000000-0xa000007f 64bit]
pci 0000:01:00.0: reg 18: [mem 0xa0004000-0xa0007fff 64bit]
pci 0000:01:00.0: reg 20: [io  0x1000-0x107f]
pci 0000:01:00.0: reg 30: [mem 0x00000000-0x0007ffff pref]
pci 0000:01:00.0: supports D1 D2
pci 0000:00:00.0: PCI bridge to [bus 01-ff]
pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
pci 0000:00:00.0:   bridge window [mem 0xa0000000-0xa00fffff]
pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 01
PCI: Memory resource 0 not set for host bridge /pcie@ffe0a000 (domain 1)
PCI: Memory resource 0 not set for host bridge /pcie@ffe0a000 (domain 1)
fsl-pci ffe0a000.pcie: PCI host bridge to bus 0001:02
pci_bus 0001:02: root bus resource [io  0x20000-0x2ffff] (bus address [0x00=
00-0xffff])
pci_bus 0001:02: root bus resource [mem 0x80000000-0x9fffffff] (bus address=
 [0xe0000000-0xffffffff])
pci_bus 0001:02: root bus resource [bus 02-ff]
pci_bus 0001:02: busn_res: [bus 02-ff] end is updated to ff
pci 0001:02:00.0: [1957:0070] type 01 class 0x0b2000
pci 0001:02:00.0: ignoring class 0x0b2000 (doesn't match header type 01)
pci 0001:02:00.0: supports D1 D2
pci 0001:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0001:02:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0001:02:00.0: PCI bridge to [bus 03-ff]
pci 0001:02:00.0:   bridge window [io  0x20000-0x20fff]
pci 0001:02:00.0:   bridge window [mem 0x00000000-0x000fffff]
pci 0001:02:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
pci_bus 0001:03: busn_res: [bus 03-ff] end is updated to 03
pci_bus 0001:02: busn_res: [bus 02-ff] end is updated to 03
PCI 0000:00 Cannot reserve Legacy IO [io  0x0000-0x0fff]
PCI 0001:02 Cannot reserve Legacy IO [io  0x20000-0x20fff]
pci 0000:00:00.0: BAR 9: can't assign mem pref (size 0x100000)
pci 0000:01:00.0: BAR 6: assigned [mem 0xa0080000-0xa00fffff pref]
pci 0000:00:00.0: PCI bridge to [bus 01]
pci 0000:00:00.0:   bridge window [io  0x0000-0xffff]
pci 0000:00:00.0:   bridge window [mem 0xa0000000-0xbfffffff]
pci 0001:02:00.0: PCI bridge to [bus 03]
pci 0001:02:00.0:   bridge window [io  0x20000-0x2ffff]
pci 0001:02:00.0:   bridge window [mem 0x80000000-0x9fffffff]
Some PCI device resources are unassigned, try booting with pci=3Drealloc
pci 0000:00:00.0: enabling device (0106 -> 0107)
pci 0001:02:00.0: enabling device (0106 -> 0107)
pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
pci_bus 0000:00: resource 5 [mem 0xa0000000-0xbfffffff]
pci_bus 0000:01: resource 0 [io  0x0000-0xffff]
pci_bus 0000:01: resource 1 [mem 0xa0000000-0xbfffffff]
pci_bus 0001:02: resource 4 [io  0x20000-0x2ffff]
pci_bus 0001:02: resource 5 [mem 0x80000000-0x9fffffff]
pci_bus 0001:03: resource 0 [io  0x20000-0x2ffff]
pci_bus 0001:03: resource 1 [mem 0x80000000-0x9fffffff]
Setting up Freescale MSI support
Registering qe_ic with sysfs...
bio: create slab <bio-0> at 0
Freescale Elo / Elo Plus DMA driver
fsl-elo-dma ffe0c300.dma: #0 (fsl,eloplus-dma-channel), irq 76
fsl-elo-dma ffe0c300.dma: #1 (fsl,eloplus-dma-channel), irq 77
fsl-elo-dma ffe0c300.dma: #2 (fsl,eloplus-dma-channel), irq 78
fsl-elo-dma ffe0c300.dma: #3 (fsl,eloplus-dma-channel), irq 79
fsl-elo-dma ffe21300.dma: #0 (fsl,eloplus-dma-channel), irq 20
fsl-elo-dma ffe21300.dma: #1 (fsl,eloplus-dma-channel), irq 21
fsl-elo-dma ffe21300.dma: #2 (fsl,eloplus-dma-channel), irq 22
fsl-elo-dma ffe21300.dma: #3 (fsl,eloplus-dma-channel), irq 23
vgaarb: loaded
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giome=
tti@linux.it>
PTP clock support registered
EDAC MC: Ver: 3.0.0
Advanced Linux Sound Architecture Driver Initialized.
Switching to clocksource timebase
NET: Registered protocol family 2
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP: reno registered
UDP hash table entries: 512 (order: 2, 16384 bytes)
UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
PCI: CLS 32 bytes, default 32
audit: initializing netlink socket (disabled)
type=3D2000 audit(0.304:1): initialized
bounce pool size: 64 pages
HugeTLB registered 4 MB page size, pre-allocated 0 pages
HugeTLB registered 16 MB page size, pre-allocated 0 pages
HugeTLB registered 64 MB page size, pre-allocated 0 pages
HugeTLB registered 256 MB page size, pre-allocated 0 pages
HugeTLB registered 1 GB page size, pre-allocated 0 pages
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.30 [Flags: R/O].
jffs2: version 2.2. (NAND) \xffffffc2\xffffffa9 2001-2006 Red Hat, Inc.
msgmni has been set to 1501
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
Freescale Display Interface Unit (DIU) framebuffer driver
Serial: 8250/16550 driver, 2 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0xffe04500 (irq =3D 42) is a 16550A
console [ttyS0] enabled, bootconsole disabled
serial8250.0: ttyS1 at MMIO 0xffe04600 (irq =3D 42) is a 16550A
Generic non-volatile memory driver v1.1
brd: module loaded
loop: module loaded
nbd: registered device at major 43
st: Version 20101219, fixed bufsize 32768, s/g segs 256
ef000000.nor: Found 1 x16 devices at 0x0 in 16-bit bank. Manufacturer ID 0x=
000001 Chip ID 0x002101
Amd/Fujitsu Extended Query Table at 0x0040
  Amd/Fujitsu Extended Query version 1.3.
number of CFI chips: 1
5 ofpart partitions found on MTD device ef000000.nor
Creating 5 MTD partitions on "ef000000.nor":
0x000000000000-0x000000040000 : "NOR Vitesse-7385 Firmware"
ftl_cs: FTL header not found.
0x000000040000-0x000000080000 : "NOR DTB Image"
ftl_cs: FTL header not found.
0x000000080000-0x000000400000 : "NOR Linux Kernel Image"
ftl_cs: FTL header not found.
0x000000400000-0x000000f00000 : "NOR JFFS2 Root File System"
ftl_cs: FTL header not found.
0x000000f00000-0x000001000000 : "NOR U-Boot Image"
ftl_cs: FTL header not found.
NAND device: Manufacturer ID: 0xec, Chip ID: 0x75 (Samsung NAND 32MiB 3,3V =
8-bit), 32MiB, page size: 512, OOB size: 16
Bad block table found at page 65504, version 0x01
Bad block table found at page 65472, version 0x01
6 ofpart partitions found on MTD device ff800000.flash
Creating 6 MTD partitions on "ff800000.flash":
0x000000000000-0x000000100000 : "NAND U-Boot Image"
ftl_cs: FTL header not found.
0x000000100000-0x000000200000 : "NAND DTB Image"
ftl_cs: FTL header not found.
0x000000200000-0x000000600000 : "NAND Linux Kernel Image"
ftl_cs: FTL header not found.
0x000000600000-0x000000a00000 : "NAND Compressed RFS Image"
ftl_cs: FTL header not found.
0x000000a00000-0x000001100000 : "NAND JFFS2 Root File System"
ftl_cs: FTL header not found.
0x000001100000-0x000002000000 : "NAND Writable User area"
ftl_cs: FTL header not found.
eLBC NAND device at 0xff800000, bank 1
fsl_espi ffe07000.spi: master is unqueued, this is deprecated
m25p80 spi32766.0: found s25fl129p1, expected m25p80
m25p80 spi32766.0: s25fl129p1 (16384 Kbytes)
5 ofpart partitions found on MTD device spi32766.0
Creating 5 MTD partitions on "spi32766.0":
0x000000000000-0x000000080000 : "SPI U-Boot Image"
ftl_cs: FTL header not found.
0x000000080000-0x000000100000 : "SPI DTB Image"
ftl_cs: FTL header not found.
0x000000100000-0x000000500000 : "SPI Linux Kernel Image"
ftl_cs: FTL header not found.
0x000000500000-0x000000900000 : "SPI Compressed RFS Image"
ftl_cs: FTL header not found.
0x000000900000-0x000001000000 : "SPI JFFS2 RFS"
ftl_cs: FTL header not found.
fsl_espi ffe07000.spi: at 0xf10c0000 (irq =3D 59)
libphy: Fixed MDIO Bus: probed
libphy: Freescale PowerQUICC MII Bus: probed
libphy: Freescale PowerQUICC MII Bus: probed
fsl-gianfar ffe24000.ethernet eth0: mac: 00:04:9f:02:7f:3c
fsl-gianfar ffe24000.ethernet eth0: Running with NAPI enabled
fsl-gianfar ffe24000.ethernet eth0: RX BD ring size for Q[0]: 256
fsl-gianfar ffe24000.ethernet eth0: TX BD ring size for Q[0]: 256
fsl-gianfar ffe25000.ethernet eth1: mac: 00:04:9f:02:7f:3b
fsl-gianfar ffe25000.ethernet eth1: Running with NAPI enabled
fsl-gianfar ffe25000.ethernet eth1: RX BD ring size for Q[0]: 256
fsl-gianfar ffe25000.ethernet eth1: TX BD ring size for Q[0]: 256
fsl-gianfar ffe26000.ethernet eth2: mac: 00:04:9f:02:7f:3a
fsl-gianfar ffe26000.ethernet eth2: Running with NAPI enabled
fsl-gianfar ffe26000.ethernet eth2: RX BD ring size for Q[0]: 256
fsl-gianfar ffe26000.ethernet eth2: TX BD ring size for Q[0]: 256
pps pps0: new PPS source ptp0
ucc_geth_driver: QE UCC Gigabit Ethernet Controller
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host Controller
fsl-ehci fsl-ehci.0: new USB bus registered, assigned bus number 1
fsl-ehci fsl-ehci.0: irq 28, io mem 0xffe22000
fsl-ehci fsl-ehci.0: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
usbcore: registered new interface driver usb-storage
i2c /dev entries driver
mpc-i2c ffe03000.i2c: timeout 1000000 us
mpc-i2c ffe03100.i2c: timeout 1000000 us
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
sdhci-pltfm: SDHCI platform and OF driver helper
mmc0: SDHCI controller on ffe2e000.sdhc [ffe2e000.sdhc] using DMA
talitos ffe30000.crypto: hwrng
talitos ffe30000.crypto: fsl,sec3.1 algorithms registered in /proc/crypto
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
snd-soc-p1022ds: missing/invalid global utils node
ipip: IPv4 over IPv4 tunneling driver
TCP: cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 10
sit: IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
Key type dns_resolver registered
/home/kevin/git/linux/drivers/rtc/hctosys.c: unable to open rtc device (rtc=
0)
snd-soc-p1022rdk: missing/invalid global utils node
IPv6: ADDRCONF(NETDEV_UP): eth2: link is not ready
mmc0: new high speed SDHC card at address e624
mmcblk0: mmc0:e624 SU04G 3.69 GiB=20
 mmcblk0: p1
usb 1-1: new high-speed USB device number 2 using fsl-ehci
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 4 ports detected
usb 1-1.3: new high-speed USB device number 3 using fsl-ehci
usb-storage 1-1.3:1.0: USB Mass Storage device detected
scsi0 : usb-storage 1-1.3:1.0
scsi 0:0:0:0: Direct-Access              freescale        PMAP PQ: 0 ANSI: =
0 CCS
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 0:0:0:0: [sda] 7831552 512-byte logical blocks: (4.00 GB/3.73 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 23 00 00 00
sd 0:0:0:0: [sda] No Caching mode page present
sd 0:0:0:0: [sda] Assuming drive cache: write through
sd 0:0:0:0: [sda] No Caching mode page present
sd 0:0:0:0: [sda] Assuming drive cache: write through
 sda: sda4
sd 0:0:0:0: [sda] No Caching mode page present
sd 0:0:0:0: [sda] Assuming drive cache: write through
sd 0:0:0:0: [sda] Attached SCSI removable disk
libphy: mdio@ffe24520:01 - Link is Up - 1000/Full
IPv6: ADDRCONF(NETDEV_CHANGE): eth2: link becomes ready
IP-Config: Complete:
     device=3Deth2, hwaddr=3D00:04:9f:02:7f:3a, ipaddr=3D128.224.178.28, ma=
sk=3D255.255.254.0, gw=3D128.224.178.1
     host=3Dunknown, domain=3D, nis-domain=3D(none)
     bootserver=3D128.224.178.20, rootserver=3D128.224.178.20, rootpath=3D
ALSA device list:
  No soundcards found.
VFS: Mounted root (nfs filesystem) on device 0:17.
Freeing unused kernel memory: 264K (c071b000 - c075d000)
block nbd2: Attempted send on closed socket
block nbd8: Attempted send on closed socket
end_request: I/O error, dev nbd8, sector 2
EXT3-fs (nbd8): error: unable to read superblock
end_request: I/O error, dev nbd2, sector 2
EXT3-fs (nbd2): error: unable to read superblock
block nbd8: Attempted send on closed socket
end_request: I/O error, dev nbd8, sector 2
EXT2-fs (nbd8): error: unable to read superblock
block nbd8: Attempted send on closed socket
end_request: I/O error, dev nbd8, sector 0
FAT-fs (nbd8): unable to read boot sector
block nbd15: Attempted send on closed socket
end_request: I/O error, dev nbd15, sector 2
EXT3-fs (nbd15): error: unable to read superblock
block nbd2: Attempted send on closed socket
end_request: I/O error, dev nbd2, sector 2
EXT2-fs (nbd2): error: unable to read superblock
block nbd15: Attempted send on closed socket
end_request: I/O error, dev nbd15, sector 2
EXT2-fs (nbd15): error: unable to read superblock
block nbd15: Attempted send on closed socket
end_request: I/O error, dev nbd15, sector 0
FAT-fs (nbd15): unable to read boot sector
block nbd2: Attempted send on closed socket
end_request: I/O error, dev nbd2, sector 0
FAT-fs (nbd2): unable to read boot sector
block nbd0: Attempted send on closed socket
end_request: I/O error, dev nbd0, sector 2
EXT3-fs (nbd0): error: unable to read superblock
block nbd0: Attempted send on closed socket
EXT2-fs (nbd0): error: unable to read superblock
block nbd5: Attempted send on closed socket
EXT3-fs (nbd5): error: unable to read superblock
block nbd5: Attempted send on closed socket
EXT2-fs (nbd5): error: unable to read superblock
block nbd0: Attempted send on closed socket
FAT-fs (nbd0): unable to read boot sector
block nbd5: Attempted send on closed socket
FAT-fs (nbd5): unable to read boot sector
block nbd14: Attempted send on closed socket
EXT3-fs (nbd14): error: unable to read superblock
block nbd6: Attempted send on closed socket
EXT3-fs (nbd6): error: unable to read superblock
block nbd12: Attempted send on closed socket
EXT3-fs (nbd12): error: unable to read superblock
block nbd6: Attempted send on closed socket
EXT2-fs (nbd6): error: unable to read superblock
block nbd14: Attempted send on closed socket
EXT2-fs (nbd14): error: unable to read superblock
block nbd14: Attempted send on closed socket
FAT-fs (nbd14): unable to read boot sector
block nbd13: Attempted send on closed socket
EXT3-fs (nbd13): error: unable to read superblock
block nbd7: Attempted send on closed socket
block nbd13: Attempted send on closed socket
EXT2-fs (nbd13): error: unable to read superblock
EXT3-fs (nbd7): error: unable to read superblock
block nbd1: Attempted send on closed socket
block nbd13: Attempted send on closed socket
FAT-fs (nbd13): unable to read boot sector
EXT3-fs (nbd1): error: unable to read superblock
block nbd6: Attempted send on closed socket
FAT-fs (nbd6): unable to read boot sector
block nbd10: Attempted send on closed socket
block nbd11: Attempted send on closed socket
EXT3-fs (nbd11): error: unable to read superblock
EXT3-fs (nbd10): error: unable to read superblock
block nbd7: Attempted send on closed socket
EXT2-fs (nbd7): error: unable to read superblock
block nbd12: Attempted send on closed socket
block nbd11: Attempted send on closed socket
EXT2-fs (nbd11): error: unable to read superblock
EXT2-fs (nbd12): error: unable to read superblock
block nbd11: Attempted send on closed socket
FAT-fs (nbd11): unable to read boot sector
block nbd9: Attempted send on closed socket
EXT3-fs (nbd9): error: unable to read superblock
block nbd12: Attempted send on closed socket
FAT-fs (nbd12): unable to read boot sector
block nbd1: Attempted send on closed socket
EXT2-fs (nbd1): error: unable to read superblock
block nbd10: Attempted send on closed socket
EXT2-fs (nbd10): error: unable to read superblock
block nbd3: Attempted send on closed socket
EXT3-fs (nbd3): error: unable to read superblock
block nbd9: Attempted send on closed socket
EXT2-fs (nbd9): error: unable to read superblock
block nbd7: Attempted send on closed socket
FAT-fs (nbd7): unable to read boot sector
block nbd4: Attempted send on closed socket
EXT3-fs (nbd4): error: unable to read superblock
block nbd4: Attempted send on closed socket
EXT2-fs (nbd4): error: unable to read superblock
block nbd3: Attempted send on closed socket
EXT2-fs (nbd3): error: unable to read superblock
block nbd9: Attempted send on closed socket
FAT-fs (nbd9): unable to read boot sector
block nbd3: Attempted send on closed socket
FAT-fs (nbd3): unable to read boot sector
block nbd10: Attempted send on closed socket
FAT-fs (nbd10): unable to read boot sector
block nbd4: Attempted send on closed socket
FAT-fs (nbd4): unable to read boot sector
block nbd1: Attempted send on closed socket
FAT-fs (nbd1): unable to read boot sector
EXT3-fs (mmcblk0): error: can't find ext3 filesystem on dev mmcblk0.
EXT2-fs (mmcblk0): error: can't find an ext2 filesystem on dev mmcblk0.
FAT-fs (mmcblk0): bogus number of reserved sectors
FAT-fs (mmcblk0): Can't find a valid FAT filesystem
cramfs: wrong magic
NTFS-fs error (device mmcblk0): read_ntfs_boot_sector(): Primary boot secto=
r is invalid.
NTFS-fs error (device mmcblk0): read_ntfs_boot_sector(): Mount option error=
s=3Drecover not used. Aborting without trying to recover.
NTFS-fs error (device mmcblk0): ntfs_fill_super(): Not an NTFS volume.
FAT-fs (sda): Invalid FSINFO signature: 0x00000000, 0x00000000 (sector =3D =
1)
FAT-fs (sda): codepage cp437 not found
EXT2-fs (mmcblk0p1): warning: mounting unchecked fs, running e2fsck is reco=
mmended
EXT2-fs (sda4): warning: mounting unchecked fs, running e2fsck is recommend=
ed




root@unknown:~# lspci -vvv
0000:00:00.0 PCI bridge: Freescale Semiconductor Inc P2020E (rev 21) (prog-=
if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Region 0: Memory at <ignored> (32-bit, non-prefetchable)
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
	I/O behind bridge: 00000000-00000fff
	Memory behind bridge: e0000000-ffffffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [4c] Express (v1) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x4, ASPM L0s, Latency L0 <2us, L1 u=
nlimited
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 128 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLActive- BWMgmt-=
 ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-

0000:01:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial A=
TA Raid II Controller (rev 01)
	Subsystem: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 24
	Region 0: Memory at a0000000 (64-bit, non-prefetchable) [size=3D128]
	Region 2: Memory at a0004000 (64-bit, non-prefetchable) [size=3D16K]
	Region 4: I/O ports at 1000 [size=3D128]
	[virtual] Expansion ROM at a0080000 [disabled] [size=3D512K]
	Capabilities: [54] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D1 PME-
	Capabilities: [5c] MSI: Enable- Count=3D1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] Express (v1) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 1024 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 unlimited,=
 L1 unlimited
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt-=
 ABWMgmt-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-

0001:02:00.0 PCI bridge: Freescale Semiconductor Inc P2020E (rev 21) (prog-=
if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Region 0: Memory at <ignored> (32-bit, non-prefetchable)
	Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-latency=3D0
	I/O behind bridge: 00000000-00000fff
	Memory behind bridge: e0000000-ffffffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [4c] Express (v1) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x4, ASPM L0s, Latency L0 <2us, L1 u=
nlimited
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 128 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLActive- BWMgmt-=
 ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-


--sHrvAb52M6C8blB9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="work.txt"
Content-Transfer-Encoding: quoted-printable

Using P2020RDB-PC machine description
Memory CAM mapping: 256/256/256 Mb, residual: 256Mb
Linux version 3.10.0-rc2-00090-g7120175 (kevin@pek-khao-d1) (gcc version 4.=
6.3 (Wind River Linux Sourcery CodeBench 4.6a-99) ) #102 SMP Fri May 24 10:=
13:04 CST 2013
Found legacy serial port 0 for /soc@ffe00000/serial@4500
  mem=3Dffe04500, taddr=3Dffe04500, irq=3D0, clk=3D600000000, speed=3D0
Found legacy serial port 1 for /soc@ffe00000/serial@4600
  mem=3Dffe04600, taddr=3Dffe04600, irq=3D0, clk=3D600000000, speed=3D0
CPU maps initialized for 1 thread per core
 (thread shift is 0)
bootconsole [udbg0] enabled
mpc85xx_rdb_setup_arch: Could not find Quicc Engine node
MPC85xx RDB board from Freescale Semiconductor
Top of RAM: 0x40000000, Total RAM: 0x40000000
Memory hole size: 0MB
Zone ranges:
  DMA      [mem 0x00000000-0x2fffffff]
  Normal   empty
  HighMem  [mem 0x30000000-0x3fffffff]
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x00000000-0x3fffffff]
On node 0 totalpages: 262144
free_area_init_node: node 0, pgdat c0798800, node_mem_map c0818000
  DMA zone: 1536 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 196608 pages, LIFO batch:31
  HighMem zone: 512 pages used for memmap
  HighMem zone: 65536 pages, LIFO batch:15
MMU: Allocated 1088 bytes of context maps for 255 contexts
PERCPU: Embedded 7 pages/cpu @c101f000 s6752 r8192 d13728 u32768
pcpu-alloc: s6752 r8192 d13728 u32768 alloc=3D8*4096
pcpu-alloc: [0] 0 [0] 1=20
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260608
Kernel command line: root=3D/dev/nfs rw nfsroot=3D128.224.178.20:/export/px=
eboot/vlm-boards/21080/rootfs ip=3D128.224.178.28:128.224.178.20:128.224.17=
8.1:255.255.254.0:unknown:eth2:off console=3DttyS0,115200 enforcing=3D0
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Sorting __ex_table...
High memory: 262140k
Memory: 965144k/1048576k available (7548k kernel code, 83432k reserved, 300=
k data, 429k bss, 264k init)
Kernel virtual memory layout:
  * 0xfff5f000..0xfffff000  : fixmap
  * 0xffc00000..0xffe00000  : highmem PTEs
  * 0xffbfd000..0xffc00000  : early ioremap
  * 0xf1000000..0xffbfd000  : vmalloc & ioremap
SLUB: HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D2, Nodes=3D1
Hierarchical RCU implementation.
	RCU restricting CPUs from NR_CPUS=3D8 to nr_cpu_ids=3D2.
NR_IRQS:512 nr_irqs:512 16
mpic: Resetting
mpic: Setting up MPIC " OpenPIC  " version 1.2 at ffe40000, max 2 CPUs
mpic: ISU size: 256, shift: 8, mask: ff
mpic: Initializing for 256 sources
mpc85xx_rdb_pic_init: Could not find qe-ic node
time_init: decrementer frequency =3D 75.000000 MHz
time_init: processor frequency   =3D 1200.000000 MHz
clocksource: timebase mult[d555555] shift[24] registered
clockevent: decrementer mult[13333333] shift[32] cpu[0]
Console: colour dummy device 80x25
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
mpic: requesting IPIs...
Brought up 2 CPUs
devtmpfs: initialized
NET: Registered protocol family 16
Found FSL PCI host bridge at 0x00000000ffe09000. Firmware bus number: 0->1
PCI host bridge /pcie@ffe09000 (primary) ranges:
 MEM 0x00000000a0000000..0x00000000bfffffff -> 0x00000000e0000000=20
  IO 0x00000000ffc10000..0x00000000ffc1ffff -> 0x0000000000000000
/pcie@ffe09000: PCICSRBAR @ 0xdff00000
Found FSL PCI host bridge at 0x00000000ffe0a000. Firmware bus number: 0->0
PCI host bridge /pcie@ffe0a000  ranges:
 MEM 0x0000000080000000..0x000000009fffffff -> 0x00000000e0000000=20
  IO 0x00000000ffc00000..0x00000000ffc0ffff -> 0x0000000000000000
/pcie@ffe0a000: PCICSRBAR @ 0xdff00000
PCI: Probing PCI hardware
PCI: Memory resource 0 not set for host bridge /pcie@ffe09000 (domain 0)
PCI: Memory resource 0 not set for host bridge /pcie@ffe09000 (domain 0)
fsl-pci ffe09000.pcie: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
pci_bus 0000:00: root bus resource [mem 0xa0000000-0xbfffffff] (bus address=
 [0xe0000000-0xffffffff])
pci_bus 0000:00: root bus resource [bus 00-ff]
pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to ff
pci 0000:00:00.0: [1957:0070] type 01 class 0x0b2000
pci 0000:00:00.0: ignoring class 0x0b2000 (doesn't match header type 01)
pci 0000:00:00.0: supports D1 D2
pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:01:00.0: [1095:3132] type 00 class 0x018000
pci 0000:01:00.0: reg 10: [mem 0x00000000-0x0000007f 64bit]
pci 0000:01:00.0: reg 18: [mem 0x00000000-0x00003fff 64bit]
pci 0000:01:00.0: reg 20: [io  0x1000-0x107f]
pci 0000:01:00.0: reg 30: [mem 0x00000000-0x0007ffff pref]
pci 0000:01:00.0: supports D1 D2
pci 0000:00:00.0: PCI bridge to [bus 01-ff]
pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
pci 0000:00:00.0:   bridge window [mem 0xa0000000-0xa00fffff]
pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 01
PCI: Memory resource 0 not set for host bridge /pcie@ffe0a000 (domain 1)
PCI: Memory resource 0 not set for host bridge /pcie@ffe0a000 (domain 1)
fsl-pci ffe0a000.pcie: PCI host bridge to bus 0001:02
pci_bus 0001:02: root bus resource [io  0x20000-0x2ffff] (bus address [0x00=
00-0xffff])
pci_bus 0001:02: root bus resource [mem 0x80000000-0x9fffffff] (bus address=
 [0xe0000000-0xffffffff])
pci_bus 0001:02: root bus resource [bus 02-ff]
pci_bus 0001:02: busn_res: [bus 02-ff] end is updated to ff
pci 0001:02:00.0: [1957:0070] type 01 class 0x0b2000
pci 0001:02:00.0: ignoring class 0x0b2000 (doesn't match header type 01)
pci 0001:02:00.0: supports D1 D2
pci 0001:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0001:02:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0001:02:00.0: PCI bridge to [bus 03-ff]
pci 0001:02:00.0:   bridge window [io  0x20000-0x20fff]
pci 0001:02:00.0:   bridge window [mem 0x00000000-0x000fffff]
pci 0001:02:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
pci_bus 0001:03: busn_res: [bus 03-ff] end is updated to 03
pci_bus 0001:02: busn_res: [bus 02-ff] end is updated to 03
PCI 0000:00 Cannot reserve Legacy IO [io  0x0000-0x0fff]
PCI 0001:02 Cannot reserve Legacy IO [io  0x20000-0x20fff]
pci 0000:00:00.0: BAR 9: can't assign mem pref (size 0x100000)
pci 0000:01:00.0: BAR 6: assigned [mem 0xa0000000-0xa007ffff pref]
pci 0000:01:00.0: BAR 2: assigned [mem 0xa0080000-0xa0083fff 64bit]
pci 0000:01:00.0: BAR 0: assigned [mem 0xa0084000-0xa008407f 64bit]
pci 0000:00:00.0: PCI bridge to [bus 01]
pci 0000:00:00.0:   bridge window [io  0x0000-0xffff]
pci 0000:00:00.0:   bridge window [mem 0xa0000000-0xbfffffff]
pci 0001:02:00.0: PCI bridge to [bus 03]
pci 0001:02:00.0:   bridge window [io  0x20000-0x2ffff]
pci 0001:02:00.0:   bridge window [mem 0x80000000-0x9fffffff]
Some PCI device resources are unassigned, try booting with pci=3Drealloc
pci 0000:00:00.0: enabling device (0106 -> 0107)
pci 0001:02:00.0: enabling device (0106 -> 0107)
pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
pci_bus 0000:00: resource 5 [mem 0xa0000000-0xbfffffff]
pci_bus 0000:01: resource 0 [io  0x0000-0xffff]
pci_bus 0000:01: resource 1 [mem 0xa0000000-0xbfffffff]
pci_bus 0001:02: resource 4 [io  0x20000-0x2ffff]
pci_bus 0001:02: resource 5 [mem 0x80000000-0x9fffffff]
pci_bus 0001:03: resource 0 [io  0x20000-0x2ffff]
pci_bus 0001:03: resource 1 [mem 0x80000000-0x9fffffff]
Setting up Freescale MSI support
Registering qe_ic with sysfs...
bio: create slab <bio-0> at 0
Freescale Elo / Elo Plus DMA driver
fsl-elo-dma ffe0c300.dma: #0 (fsl,eloplus-dma-channel), irq 76
fsl-elo-dma ffe0c300.dma: #1 (fsl,eloplus-dma-channel), irq 77
fsl-elo-dma ffe0c300.dma: #2 (fsl,eloplus-dma-channel), irq 78
fsl-elo-dma ffe0c300.dma: #3 (fsl,eloplus-dma-channel), irq 79
fsl-elo-dma ffe21300.dma: #0 (fsl,eloplus-dma-channel), irq 20
fsl-elo-dma ffe21300.dma: #1 (fsl,eloplus-dma-channel), irq 21
fsl-elo-dma ffe21300.dma: #2 (fsl,eloplus-dma-channel), irq 22
fsl-elo-dma ffe21300.dma: #3 (fsl,eloplus-dma-channel), irq 23
vgaarb: loaded
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giome=
tti@linux.it>
PTP clock support registered
EDAC MC: Ver: 3.0.0
Advanced Linux Sound Architecture Driver Initialized.
Switching to clocksource timebase
NET: Registered protocol family 2
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP: reno registered
UDP hash table entries: 512 (order: 2, 16384 bytes)
UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
PCI: CLS 32 bytes, default 32
audit: initializing netlink socket (disabled)
type=3D2000 audit(0.312:1): initialized
bounce pool size: 64 pages
HugeTLB registered 4 MB page size, pre-allocated 0 pages
HugeTLB registered 16 MB page size, pre-allocated 0 pages
HugeTLB registered 64 MB page size, pre-allocated 0 pages
HugeTLB registered 256 MB page size, pre-allocated 0 pages
HugeTLB registered 1 GB page size, pre-allocated 0 pages
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.30 [Flags: R/O].
jffs2: version 2.2. (NAND) \xffffffc2\xffffffa9 2001-2006 Red Hat, Inc.
msgmni has been set to 1501
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
Freescale Display Interface Unit (DIU) framebuffer driver
Serial: 8250/16550 driver, 2 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0xffe04500 (irq =3D 42) is a 16550A
console [ttyS0] enabled, bootconsole disabled
serial8250.0: ttyS1 at MMIO 0xffe04600 (irq =3D 42) is a 16550A
Generic non-volatile memory driver v1.1
brd: module loaded
loop: module loaded
nbd: registered device at major 43
st: Version 20101219, fixed bufsize 32768, s/g segs 256
sata_sil24 0000:01:00.0: version 1.1
scsi0 : sata_sil24
scsi1 : sata_sil24
ata1: SATA max UDMA/100 host m128@0xa0084000 port 0xa0080000 irq 24
ata2: SATA max UDMA/100 host m128@0xa0084000 port 0xa0082000 irq 24
ef000000.nor: Found 1 x16 devices at 0x0 in 16-bit bank. Manufacturer ID 0x=
000001 Chip ID 0x002101
Amd/Fujitsu Extended Query Table at 0x0040
  Amd/Fujitsu Extended Query version 1.3.
number of CFI chips: 1
5 ofpart partitions found on MTD device ef000000.nor
Creating 5 MTD partitions on "ef000000.nor":
0x000000000000-0x000000040000 : "NOR Vitesse-7385 Firmware"
ftl_cs: FTL header not found.
0x000000040000-0x000000080000 : "NOR DTB Image"
ftl_cs: FTL header not found.
0x000000080000-0x000000400000 : "NOR Linux Kernel Image"
ftl_cs: FTL header not found.
0x000000400000-0x000000f00000 : "NOR JFFS2 Root File System"
ftl_cs: FTL header not found.
0x000000f00000-0x000001000000 : "NOR U-Boot Image"
ftl_cs: FTL header not found.
NAND device: Manufacturer ID: 0xec, Chip ID: 0x75 (Samsung NAND 32MiB 3,3V =
8-bit), 32MiB, page size: 512, OOB size: 16
Bad block table found at page 65504, version 0x01
Bad block table found at page 65472, version 0x01
6 ofpart partitions found on MTD device ff800000.flash
Creating 6 MTD partitions on "ff800000.flash":
0x000000000000-0x000000100000 : "NAND U-Boot Image"
ftl_cs: FTL header not found.
0x000000100000-0x000000200000 : "NAND DTB Image"
ftl_cs: FTL header not found.
0x000000200000-0x000000600000 : "NAND Linux Kernel Image"
ftl_cs: FTL header not found.
0x000000600000-0x000000a00000 : "NAND Compressed RFS Image"
ftl_cs: FTL header not found.
0x000000a00000-0x000001100000 : "NAND JFFS2 Root File System"
ftl_cs: FTL header not found.
0x000001100000-0x000002000000 : "NAND Writable User area"
ftl_cs: FTL header not found.
eLBC NAND device at 0xff800000, bank 1
fsl_espi ffe07000.spi: master is unqueued, this is deprecated
m25p80 spi32766.0: found s25fl129p1, expected m25p80
m25p80 spi32766.0: s25fl129p1 (16384 Kbytes)
5 ofpart partitions found on MTD device spi32766.0
Creating 5 MTD partitions on "spi32766.0":
0x000000000000-0x000000080000 : "SPI U-Boot Image"
ftl_cs: FTL header not found.
0x000000080000-0x000000100000 : "SPI DTB Image"
ftl_cs: FTL header not found.
0x000000100000-0x000000500000 : "SPI Linux Kernel Image"
ftl_cs: FTL header not found.
0x000000500000-0x000000900000 : "SPI Compressed RFS Image"
ftl_cs: FTL header not found.
0x000000900000-0x000001000000 : "SPI JFFS2 RFS"
ftl_cs: FTL header not found.
fsl_espi ffe07000.spi: at 0xf10bc000 (irq =3D 59)
libphy: Fixed MDIO Bus: probed
libphy: Freescale PowerQUICC MII Bus: probed
libphy: Freescale PowerQUICC MII Bus: probed
fsl-gianfar ffe24000.ethernet eth0: mac: 00:04:9f:02:7f:3c
fsl-gianfar ffe24000.ethernet eth0: Running with NAPI enabled
fsl-gianfar ffe24000.ethernet eth0: RX BD ring size for Q[0]: 256
fsl-gianfar ffe24000.ethernet eth0: TX BD ring size for Q[0]: 256
fsl-gianfar ffe25000.ethernet eth1: mac: 00:04:9f:02:7f:3b
fsl-gianfar ffe25000.ethernet eth1: Running with NAPI enabled
fsl-gianfar ffe25000.ethernet eth1: RX BD ring size for Q[0]: 256
fsl-gianfar ffe25000.ethernet eth1: TX BD ring size for Q[0]: 256
fsl-gianfar ffe26000.ethernet eth2: mac: 00:04:9f:02:7f:3a
fsl-gianfar ffe26000.ethernet eth2: Running with NAPI enabled
fsl-gianfar ffe26000.ethernet eth2: RX BD ring size for Q[0]: 256
fsl-gianfar ffe26000.ethernet eth2: TX BD ring size for Q[0]: 256
pps pps0: new PPS source ptp0
ucc_geth_driver: QE UCC Gigabit Ethernet Controller
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host Controller
fsl-ehci fsl-ehci.0: new USB bus registered, assigned bus number 1
fsl-ehci fsl-ehci.0: irq 28, io mem 0xffe22000
fsl-ehci fsl-ehci.0: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
usbcore: registered new interface driver usb-storage
i2c /dev entries driver
mpc-i2c ffe03000.i2c: timeout 1000000 us
mpc-i2c ffe03100.i2c: timeout 1000000 us
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
sdhci-pltfm: SDHCI platform and OF driver helper
mmc0: SDHCI controller on ffe2e000.sdhc [ffe2e000.sdhc] using DMA
talitos ffe30000.crypto: hwrng
talitos ffe30000.crypto: fsl,sec3.1 algorithms registered in /proc/crypto
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
snd-soc-p1022ds: missing/invalid global utils node
ipip: IPv4 over IPv4 tunneling driver
TCP: cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 10
sit: IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
Key type dns_resolver registered
/home/kevin/git/linux/drivers/rtc/hctosys.c: unable to open rtc device (rtc=
0)
snd-soc-p1022rdk: missing/invalid global utils node
mmc0: new high speed SDHC card at address e624
mmcblk0: mmc0:e624 SU04G 3.69 GiB=20
 mmcblk0: p1
IPv6: ADDRCONF(NETDEV_UP): eth2: link is not ready
usb 1-1: new high-speed USB device number 2 using fsl-ehci
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 4 ports detected
usb 1-1.3: new high-speed USB device number 3 using fsl-ehci
usb-storage 1-1.3:1.0: USB Mass Storage device detected
scsi2 : usb-storage 1-1.3:1.0
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata1.00: ATA-8: ST500DM002-1BC142, JC4B, max UDMA/133
ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata1.00: configured for UDMA/100
scsi 0:0:0:0: Direct-Access     ATA      ST500DM002-1BC14 JC4B PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/465 GiB)
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't suppor=
t DPO or FUA
scsi 2:0:0:0: Direct-Access              freescale        PMAP PQ: 0 ANSI: =
0 CCS
sd 2:0:0:0: Attached scsi generic sg1 type 0
sd 2:0:0:0: [sdb] 7831552 512-byte logical blocks: (4.00 GB/3.73 GiB)
 sda: sda1 sda2
sd 2:0:0:0: [sdb] Write Protect is off
sd 0:0:0:0: [sda] Attached SCSI disk
sd 2:0:0:0: [sdb] Mode Sense: 23 00 00 00
sd 2:0:0:0: [sdb] No Caching mode page present
sd 2:0:0:0: [sdb] Assuming drive cache: write through
sd 2:0:0:0: [sdb] No Caching mode page present
sd 2:0:0:0: [sdb] Assuming drive cache: write through
 sdb: sdb4
sd 2:0:0:0: [sdb] No Caching mode page present
sd 2:0:0:0: [sdb] Assuming drive cache: write through
sd 2:0:0:0: [sdb] Attached SCSI removable disk
ata2: SATA link down (SStatus 0 SControl 0)
libphy: mdio@ffe24520:01 - Link is Up - 1000/Full
IPv6: ADDRCONF(NETDEV_CHANGE): eth2: link becomes ready
IP-Config: Complete:
     device=3Deth2, hwaddr=3D00:04:9f:02:7f:3a, ipaddr=3D128.224.178.28, ma=
sk=3D255.255.254.0, gw=3D128.224.178.1
     host=3Dunknown, domain=3D, nis-domain=3D(none)
     bootserver=3D128.224.178.20, rootserver=3D128.224.178.20, rootpath=3D
ALSA device list:
  No soundcards found.
VFS: Mounted root (nfs filesystem) on device 0:17.
Freeing unused kernel memory: 264K (c071d000 - c075f000)
block nbd15: Attempted send on closed socket
end_request: I/O error, dev nbd15, sector 2
EXT3-fs (nbd15): error: unable to read superblock
block nbd14: Attempted send on closed socket
end_request: I/O error, dev nbd14, sector 2
EXT3-fs (nbd14): error: unable to read superblock
block nbd12: Attempted send on closed socket
end_request: I/O error, dev nbd12, sector 2
EXT3-fs (nbd12): error: unable to read superblock
block nbd14: Attempted send on closed socket
block nbd3: Attempted send on closed socket
end_request: I/O error, dev nbd3, sector 2
EXT3-fs (nbd3): error: unable to read superblock
end_request: I/O error, dev nbd14, sector 2
EXT2-fs (nbd14): error: unable to read superblock
block nbd12: Attempted send on closed socket
end_request: I/O error, dev nbd12, sector 2
EXT2-fs (nbd12): error: unable to read superblock
block nbd14: Attempted send on closed socket
block nbd3: Attempted send on closed socket
end_request: I/O error, dev nbd3, sector 2
EXT2-fs (nbd3): error: unable to read superblock
end_request: I/O error, dev nbd14, sector 0
FAT-fs (nbd14): unable to read boot sector
block nbd3: Attempted send on closed socket
end_request: I/O error, dev nbd3, sector 0
FAT-fs (nbd3): unable to read boot sector
block nbd0: Attempted send on closed socket
end_request: I/O error, dev nbd0, sector 2
EXT3-fs (nbd0): error: unable to read superblock
block nbd12: Attempted send on closed socket
block nbd1: Attempted send on closed socket
EXT3-fs (nbd1): error: unable to read superblock
FAT-fs (nbd12): unable to read boot sector
block nbd15: Attempted send on closed socket
EXT2-fs (nbd15): error: unable to read superblock
block nbd4: Attempted send on closed socket
EXT3-fs (nbd4): error: unable to read superblock
block nbd1: Attempted send on closed socket
EXT2-fs (nbd1): error: unable to read superblock
block nbd4: Attempted send on closed socket
EXT2-fs (nbd4): error: unable to read superblock
block nbd0: Attempted send on closed socket
EXT2-fs (nbd0): error: unable to read superblock
block nbd13: Attempted send on closed socket
EXT3-fs (nbd13): error: unable to read superblock
block nbd15: Attempted send on closed socket
FAT-fs (nbd15): unable to read boot sector
block nbd2: Attempted send on closed socket
EXT3-fs (nbd2): error: unable to read superblock
block nbd1: Attempted send on closed socket
FAT-fs (nbd1): unable to read boot sector
block nbd4: Attempted send on closed socket
block nbd2: Attempted send on closed socket
EXT2-fs (nbd2): error: unable to read superblock
FAT-fs (nbd4): unable to read boot sector
block nbd0: Attempted send on closed socket
FAT-fs (nbd0): unable to read boot sector
block nbd6: Attempted send on closed socket
EXT3-fs (nbd6): error: unable to read superblock
block nbd2: Attempted send on closed socket
block nbd6: Attempted send on closed socket
EXT2-fs (nbd6): error: unable to read superblock
FAT-fs (nbd2): unable to read boot sector
block nbd11: Attempted send on closed socket
EXT3-fs (nbd11): error: unable to read superblock
block nbd11: Attempted send on closed socket
EXT2-fs (nbd11): error: unable to read superblock
block nbd8: Attempted send on closed socket
EXT3-fs (nbd8): error: unable to read superblock
block nbd8: Attempted send on closed socket
block nbd10: Attempted send on closed socket
EXT3-fs (nbd10): error: unable to read superblock
EXT2-fs (nbd8): error: unable to read superblock
block nbd9: Attempted send on closed socket
EXT3-fs (nbd9): error: unable to read superblock
block nbd9: Attempted send on closed socket
EXT2-fs (nbd9): error: unable to read superblock
block nbd9: Attempted send on closed socket
FAT-fs (nbd9): unable to read boot sector
block nbd7: Attempted send on closed socket
EXT3-fs (nbd7): error: unable to read superblock
block nbd11: Attempted send on closed socket
FAT-fs (nbd11): unable to read boot sector
block nbd7: Attempted send on closed socket
EXT2-fs (nbd7): error: unable to read superblock
block nbd13: Attempted send on closed socket
EXT2-fs (nbd13): error: unable to read superblock
block nbd8: Attempted send on closed socket
FAT-fs (nbd8): unable to read boot sector
block nbd6: Attempted send on closed socket
FAT-fs (nbd6): unable to read boot sector
block nbd10: Attempted send on closed socket
EXT2-fs (nbd10): error: unable to read superblock
block nbd5: Attempted send on closed socket
EXT3-fs (nbd5): error: unable to read superblock
block nbd10: Attempted send on closed socket
FAT-fs (nbd10): unable to read boot sector
block nbd13: Attempted send on closed socket
block nbd5: Attempted send on closed socket
EXT2-fs (nbd5): error: unable to read superblock
FAT-fs (nbd13): unable to read boot sector
block nbd5: Attempted send on closed socket
FAT-fs (nbd5): unable to read boot sector
block nbd7: Attempted send on closed socket
FAT-fs (nbd7): unable to read boot sector
EXT3-fs (mmcblk0): error: can't find ext3 filesystem on dev mmcblk0.
EXT2-fs (mmcblk0): error: can't find an ext2 filesystem on dev mmcblk0.
FAT-fs (mmcblk0): bogus number of reserved sectors
FAT-fs (mmcblk0): Can't find a valid FAT filesystem
EXT3-fs (sda): error: can't find ext3 filesystem on dev sda.
EXT2-fs (sda): error: can't find an ext2 filesystem on dev sda.
FAT-fs (sda): bogus number of reserved sectors
FAT-fs (sda): Can't find a valid FAT filesystem
cramfs: wrong magic
cramfs: wrong magic
NTFS-fs error (device mmcblk0): read_ntfs_boot_sector(): Primary boot secto=
r is invalid.
NTFS-fs error (device mmcblk0): read_ntfs_boot_sector(): Mount option error=
s=3Drecover not used. Aborting without trying to recover.
NTFS-fs error (device mmcblk0): ntfs_fill_super(): Not an NTFS volume.
NTFS-fs error (device sda): read_ntfs_boot_sector(): Primary boot sector is=
 invalid.
NTFS-fs error (device sda): read_ntfs_boot_sector(): Mount option errors=3D=
recover not used. Aborting without trying to recover.
NTFS-fs error (device sda): ntfs_fill_super(): Not an NTFS volume.
FAT-fs (sdb): Invalid FSINFO signature: 0x00000000, 0x00000000 (sector =3D =
1)
FAT-fs (sdb): codepage cp437 not found
EXT2-fs (mmcblk0p1): warning: mounting unchecked fs, running e2fsck is reco=
mmended
kjournald starting.  Commit interval 5 seconds
EXT3-fs (sda1): using internal journal
EXT3-fs (sda1): recovery complete
EXT3-fs (sda1): mounted filesystem with writeback data mode
EXT2-fs (sdb4): warning: mounting unchecked fs, running e2fsck is recommend=
ed




root@unknown:~# lspci -vvv=20
0000:00:00.0 PCI bridge: Freescale Semiconductor Inc P2020E (rev 21) (prog-=
if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Region 0: Memory at <ignored> (32-bit, non-prefetchable)
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
	I/O behind bridge: 00000000-00000fff
	Memory behind bridge: e0000000-ffffffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [4c] Express (v1) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x4, ASPM L0s, Latency L0 <2us, L1 u=
nlimited
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 128 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLActive- BWMgmt-=
 ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-

0000:01:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial A=
TA Raid II Controller (rev 01)
	Subsystem: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 24
	Region 0: Memory at a0084000 (64-bit, non-prefetchable) [size=3D128]
	Region 2: Memory at a0080000 (64-bit, non-prefetchable) [size=3D16K]
	Region 4: I/O ports at 1000 [size=3D128]
	[virtual] Expansion ROM at a0000000 [disabled] [size=3D512K]
	Capabilities: [54] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D1 PME-
	Capabilities: [5c] MSI: Enable- Count=3D1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] Express (v1) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 1024 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 4096 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 unlimited,=
 L1 unlimited
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt-=
 ABWMgmt-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Kernel driver in use: sata_sil24

0001:02:00.0 PCI bridge: Freescale Semiconductor Inc P2020E (rev 21) (prog-=
if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Region 0: Memory at <ignored> (32-bit, non-prefetchable)
	Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-latency=3D0
	I/O behind bridge: 00000000-00000fff
	Memory behind bridge: e0000000-ffffffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [4c] Express (v1) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x4, ASPM L0s, Latency L0 <2us, L1 u=
nlimited
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 128 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLActive- BWMgmt-=
 ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-


--sHrvAb52M6C8blB9--

--rqzD5py0kzyFAOWN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJRntZgAAoJEJNY7TDerrFx61MIAJHs5p4f6Dkd/x4MqmBVqV0P
g0QCChQwN3DqkwusVI/auZhRp+1pxxkNp7xV1WeuG7KVRafkDt1DAPrSypOYl3tu
pihVRr8sAM/iFrPWoG6coEDyw9t4z1TNWH4zpYnTs0ojP2pScJgNBh1m7ywkewbl
YQ6eeF4pVg+RBCTARvvAeq+jYnqYoFC+7SPruJ1lONZmgALPdxi24GEXqktPTPah
XUh6Is5dyw22y2kALY4/Lsk501xU45IK3x5OCX83WLD58Bl9W1qn86sjAv3rQHEp
W2tKBobMthMhJOm27qtkN/0ZIvMf/1QRrVQXmjFfs7iQtEeIai15k3cnr37M78M=
=wVVE
-----END PGP SIGNATURE-----

--rqzD5py0kzyFAOWN--
