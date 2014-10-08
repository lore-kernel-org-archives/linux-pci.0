Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:10869 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754725AbaJHHuB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 8 Oct 2014 03:50:01 -0400
Message-ID: <5434EBF2.3060300@hisilicon.com>
Date: Wed, 8 Oct 2014 15:46:58 +0800
From: Zhudacai <zhudacai@hisilicon.com>
MIME-Version: 1.0
To: Liviu Dudau <Liviu.Dudau@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linuxarm <linuxarm@huawei.com>,
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
	wangyijing <wangyijing@huawei.com>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>, <zhudacai@huawei.com>,
	zhanweitao <zhanweitao@huawei.com>
Subject: PCIe test result in ARM64 and some problem follows.
Content-Type: text/plain; charset="GB2312"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Liviu,

I am an engineer from Hisilicon in ShenZhen China. I noticed that there is a patchset[1] about PCIe in ARM64.
So I just merged it in 3.16 linux kernel and tested it in our Arm64 board.

Hisilicon Arm64 Board PCIe is based on pcie-designware.c[2], and connected to a PCIe-SATA card.

As a result, it works very well.

But what more, There still have some problem about msi, and I have to hardcode it in my PCIe host driver.
In arm32, we just use function as pcibios_add_bus to fix msi-chip.

void pcibios_add_bus(struct pci_bus *bus)
{
       struct pci_sys_data *sys = bus->sysdata;
       if (sys->add_bus)
                 sys->add_bus(bus);
 }

However In arm64, there is no strcut like hw_pci, and I have no idea about how to fix up the msi.

So, I will be very appreciated if you can give some useful guidance.

Best regards.

Dacai

[1] https://lkml.org/lkml/2014/9/23/852
[2] http://thread.gmane.org/gmane.linux.kernel/1684318

The test log as  follows:

hisi-pcie b0000000.pcie: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [bus 00-0f]
pci_bus 0000:00: root bus resource [mem 0xb4100000-0xb4ffffff]
pci 0000:00:00.0: [19e5:0660] type 01 class 0x060400
pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x0fffffff]
pci 0000:00:00.0: supports D1 D2
pci 0000:00:00.0: PME# supported from D0 D1 D3hot
pci 0000:00:00.0: of_irq_parse_pci() failed with rc=-22
pci 0000:01:00.0: [197b:2362] type 00 class 0x010601
pci 0000:01:00.0: reg 0x10: [io  0x0000-0x0007]
pci 0000:01:00.0: reg 0x14: [io  0x0000-0x0003]
pci 0000:01:00.0: reg 0x18: [io  0x0000-0x0007]
pci 0000:01:00.0: reg 0x1c: [io  0x0000-0x0003]
pci 0000:01:00.0: reg 0x20: [io  0x0000-0x000f]
pci 0000:01:00.0: reg 0x24: [mem 0x00000000-0x000001ff]
pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
pci 0000:01:00.0: PME# supported from D3hot
pci 0000:01:00.0: of_irq_parse_pci() failed with rc=-22
pci 0000:00:00.0: BAR 0: can't assign mem (size 0x10000000)
pci 0000:00:00.0: BAR 8: assigned [mem 0xb4100000-0xb41fffff]
pci 0000:00:00.0: BAR 7: can't assign io (size 0x1000)
pci 0000:01:00.0: BAR 6: assigned [mem 0xb4100000-0xb410ffff pref]
pci 0000:01:00.0: BAR 5: assigned [mem 0xb4110000-0xb41101ff]
pci 0000:01:00.0: BAR 4: can't assign io (size 0x10)
pci 0000:01:00.0: BAR 0: can't assign io (size 0x8)
pci 0000:01:00.0: BAR 2: can't assign io (size 0x8)
pci 0000:01:00.0: BAR 1: can't assign io (size 0x4)
pci 0000:01:00.0: BAR 3: can't assign io (size 0x4)
pci 0000:00:00.0: PCI bridge to [bus 01]
pci 0000:00:00.0:   bridge window [mem 0xb4100000-0xb41fffff]
...........................................................
ahci 0000:01:00.0: version 3.0
ahci 0000:01:00.0: enabling device (0000 -> 0002)
ahci 0000:01:00.0: ITT 1 entries, 0 bits
ahci 0000:01:00.0: ID:0 pID:8448 vID:48
its_msi_setup_irq 1222,msi addr 0xb7010040,msi data 0x0,msi_phys 0xb7000000
ahci 0000:01:00.0: AHCI 0010.0100 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
ahci 0000:01:00.0: flags: 64bit ncq pm led clo pmp pio slum part
scsi0 : ahci
scsi1 : ahci
ata1: SATA max UDMA/133 abar m512@0xb4110000 port 0xb4110100 irq 48
ata2: SATA max UDMA/133 abar m512@0xb4110000 port 0xb4110180 irq 48
..............................................................
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-8: ST3250311SV, CV11, max UDMA/133
ata1.00: 488397168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata1.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      ST3250311SV      CV11 PQ: 0 ANSI: 5
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 0:0:0:0: [sda] 488397168 512-byte logical blocks: (250 GB/232 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO
 or FUA
 sda: sda1
sd 0:0:0:0: [sda] Attached SCSI disk
...........................................................
sh-4.2# lspci
00:00.0 Class 0604: 19e5:0660
01:00.0 Class 0106: 197b:2362
sh-4.2# ls /dev/sda
/dev/sda
sh-4.2# ls /dev/sda*
/dev/sda   /dev/sda1
sh-4.2# fdisk -l

Disk /dev/sda: 250.0 GB, 250059350016 bytes
255 heads, 63 sectors/track, 30401 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks  Id System
/dev/sda1               1        1217     9775521  83 Linux
............................................................


