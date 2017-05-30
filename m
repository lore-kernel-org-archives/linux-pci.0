Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:33397 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750896AbdE3IwW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 May 2017 04:52:22 -0400
Received: by mail-yw0-f175.google.com with SMTP id p73so36958653ywp.0
        for <linux-pci@vger.kernel.org>; Tue, 30 May 2017 01:52:22 -0700 (PDT)
MIME-Version: 1.0
From: Carlo Pisani <carlojpisani@gmail.com>
Date: Tue, 30 May 2017 10:52:21 +0200
Message-ID: <CA+QBN9ANaDgcTDVeMA45m7gkH65x2OMBaa4y_xg5t4KX7WavZw@mail.gmail.com>
Subject: PowerPC405 DHT-Walnut, PCI_IO problems
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

hi
it's my first post here, so I want to say hello to everyone.
I am a student of Politecnico of Milano (italy), who needs to use a
PowerPC405GP based board, loaded with uboot v1.2. This board derives
from the Development Board made by IBM under the name "Walnut".

Here (1) you can see a picture of the board

The difference between "Walnut" and "DHT-Walnut" are
Walnut has a soldered PS/2 keyboard controller, DHT-Walnut doesn't have
Walnut has a soldered fpga, DHT-Walnut doesn't have
Walnut has a soldered RTC-chip, DHT-Walnut doesn't have
Walnut has no soldered pATA chip, Walnut comes with PDC20265

So, as these two boards are similar, I am using the profile "Walnut".

I started with linux 2.6.22, which was the last kernel known of having
been tested, and everything (including PDC20265) works as expected!

Unfortunately this kernel is "too old" for modern stage3-glibc rootfs (gentoo)
So I moved into more modern kernels, and I switched into 2.6.39, and
4.11 where I found problems with PCI_IO

Moving from 2.6.22 required a special support: arch/powerpc/boot/cuboot-walnut.c

which provides

void my_platform_init(void);
void walnut_init(void *mac0);
void platform_init(unsigned long r3, unsigned long r4, unsigned long
r5, unsigned long r6, unsigned long r7);


This way the kenrel can boot from uboot v1.2, but there are problems
with the soldered PDC20265 128 Pin, PQFP ASIC chip by Promise
Technologies. This chip is a PCI bus (32-bit PCI interface compliant
to PCI Rev 2.2) mastering ATA/ATAPI controller which supports complete
UDMA/100 specifications. Its datasheet says it communicates with the
PCI bus using a burst bus mastering and advanced scatter/gather engine
for better overall system performance.

On Kernel 2.6.22 I can grab the following

----------------- dmesg: ----------------------------------------------------
PCI: Probing PCI hardware
PCI: Cannot allocate resource region 4 of device 0000:00:04.0

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20265: IDE controller at PCI slot 0000:00:04.0
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit DISABLED Primary PCI Mode Secondary PCI Mode.
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:pio, hdd:pio

----------------- lspci: ----------------------------------------------------
00:04.0 Class 0101: Device 105a:0d30 (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Device 105a:4d33
        Flags: bus master, medium devsel, latency 128, IRQ 31
        I/O ports at 121f0 [size=8]
        I/O ports at 123f4 [size=1]
        I/O ports at 12170 [size=8]
        I/O ports at 12374 [size=1]
        I/O ports at 13000 [size=64]
        Memory at 81000000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at <ignored> [disabled]
        Capabilities: [58] Power Management version 1
        Kernel driver in use: Promise_Old_IDE

See what is reported by kernel 4.11

----------------- dmesg: ----------------------------------------------------
PCI host bridge /plb/pci@ec000000 (primary) ranges:
 MEM 0x0000000080000000..0x000000009fffffff -> 0x0000000080000000
  IO 0x00000000b0000000..0xffc10000b000ffff -> 0x0000000000000000
4xx PCI DMA offset set to 0x00000000
4xx PCI DMA window base to 0x0000000000000000
DMA window size 0x0000000080000000
PCI: Probing PCI hardware
PCI host bridge to bus 0008:00
pci_bus 0008:00: root bus resource [io  0x0000-0xffffff]
pci_bus 0008:00: root bus resource [mem 0x80000000-0x9fffffff]
pci_bus 0008:00: root bus resource [bus 00-ff]
PCI: Hiding 4xx host bridge resources 0008:00:00.0
pci 0008:00:04.0: [Firmware Bug]: reg 0x10: invalid BAR (can't size)
pci 0008:00:04.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
pci 0008:00:04.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
pci 0008:00:04.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
pci 0008:00:04.0: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
pci 0008:00:04.0: legacy IDE quirk: reg 0x14: [io  0x03f6]
pci 0008:00:04.0: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
pci 0008:00:04.0: legacy IDE quirk: reg 0x1c: [io  0x0376]
pci 0008:00:00.0: of_irq_parse_pci: failed with rc=-22
pci 0008:00:03.0: BAR 1: assigned [mem 0x80000000-0x807fffff pref]
pci 0008:00:04.0: BAR 5: assigned [mem 0x80800000-0x8081ffff]
pci 0008:00:03.0: BAR 6: assigned [mem 0x80820000-0x8082ffff pref]
pci 0008:00:03.0: BAR 0: assigned [mem 0x80830000-0x80833fff]
pci 0008:00:04.0: BAR 6: assigned [mem 0x80834000-0x80837fff pref]
pci 0008:00:02.0: BAR 0: assigned [mem 0x80838000-0x80838fff]
pci 0008:00:02.1: BAR 0: assigned [mem 0x80839000-0x808390ff]
pci 0008:00:04.0: BAR 4: assigned [io  0x1000-0x103f]
pci 0008:00:03.0: vgaarb: setting as boot VGA device
pci 0008:00:03.0: vgaarb: VGA device added:
decodes=io+mem,owns=io+mem,locks=none
pci 0008:00:03.0: vgaarb: bridge control possible

pata_pdc202xx_old 0008:00:04.0: can't enable device: BAR 0 [io  size
0x0008] not assigned
pata_pdc202xx_old: probe of 0008:00:04.0 failed with error -22

--------------- devicetree lines about PCI
------------------------------------------------
ranges = <
0x02000000 0x00000000 0x80000000
0x80000000 0x00000000 0x20000000

0x01000000 0x00000000 0x00000000
0x00001000 0x00000000 0x00001000>;


It seems to me a problem related to "legacy PCI_IO", but I am not sure
about the meaning of "quirks"

I am lost, I am neither an expert of PCI, nor of linux, I don't know
if the problem is related to

a) the boot-wrapper I need to support in order to make dht-walnut to
bootstrap (cuImage, uImage legacy) -> arch/powerpc/boot/cuboot-$board
b) the DeviceTree setup (arch/powerpc/boot/dts/walnut.dts)
c) something wrong with new kernels


I can say that everything PCI_MEM_ONLY (e.g. MGA Matrox1 ) I tried worked

any tips/tricks/advice/opinion?

thanks
Carlo


(1) a picture of the board
http://elinux.org/images/5/5a/Com1191.jpg
