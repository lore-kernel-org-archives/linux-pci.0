Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:46641 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754192AbaJHJ6i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 8 Oct 2014 05:58:38 -0400
Date: Wed, 8 Oct 2014 10:58:33 +0100
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Zhudacai <zhudacai@hisilicon.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linuxarm <linuxarm@huawei.com>,
	"liguozhu@hisilicon.com" <liguozhu@hisilicon.com>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>,
	"zhudacai@huawei.com" <zhudacai@huawei.com>,
	zhanweitao <zhanweitao@huawei.com>
Subject: Re: PCIe test result in ARM64 and some problem follows.
Message-ID: <20141008095832.GE4652@e106497-lin.cambridge.arm.com>
References: <5434EBF2.3060300@hisilicon.com>
 <20141008091122.GB4652@e106497-lin.cambridge.arm.com>
 <5435049C.507@huawei.com>
MIME-Version: 1.0
In-Reply-To: <5435049C.507@huawei.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 08, 2014 at 10:32:12AM +0100, Yijing Wang wrote:
> >> But what more, There still have some problem about msi, and I have to hardcode it in my PCIe host driver.
> >> In arm32, we just use function as pcibios_add_bus to fix msi-chip.
> > 
> > You are not the only one to notice the lack of MSI support. The problem I faced was that the generic
> > PCIe framework leaves the MSI support at the latitude of arch code. We need to pull that code into
> > the framework, and there are discussions around how best to do that, but nothing has been implemented
> > yet.
> > 
> > One solution that others are using is to have your own version of pci_scan_root_bus() where after
> > the root bus is created you add your msi_chip information into the bus and then go about scanning.
> > 
> > If enough implementations do that then I hope to convince Bjorn that the generic code needs to change
> > to be able to pass the msi_chip information.
> > 
> > If you are interested in working on the generic framework, my plan currently is to split the creation
> > of the pci_host_bridge out of the pci_create_root_bus() function and add the msi_chip-related functions
> > to retrieve the chip as ops for the pci_host_bridge(). Then your driver would look like:
> 
> Hi Liviu, is there a pci_sys_data in arm64 like other platforms ?

Nope, and don't look for one because I don't plan to add one. The pci_sys_data is an arm32-specific structure
that forces the arch code to get in the way in order to setup operations. You can pretty much do most of
those things by using the PCI framework already, and use the sysdata pointer to store your host bridge
driver structure.

Best regards,
Liviu

> 
> > 
> > struct hisilicon_host_bridge {
> > 	struct pci_host_bridge bridge;
> > 	.....
> > };
> > 
> > struct pci_host_bridge_ops {
> > 	struct msi_chip *get_msi_chip(...);
> > 	...
> > };
> > 
> > struct pci_host_bridge_ops hb_ops = {
> > 	.get_msi_chip = hs_hb_get_msi_chip;
> > 	...
> > };
> > 
> > int hs_hb_probe(...)
> > {
> > 	struct hisilicon_host_bridge *hshb;
> > 
> > 	hshb = kzalloc(...);
> > 	...
> > 	pci_setup_host_bridge(&hshb->bridge, hb_ops);
> > 	...
> > 
> > 	pci_scan_root_bus(...., &hshb->bridge);
> > 	...
> > 	return 0;
> > }
> > 
> > 
> > 
> > 
> >>
> >> void pcibios_add_bus(struct pci_bus *bus)
> >> {
> >>        struct pci_sys_data *sys = bus->sysdata;
> >>        if (sys->add_bus)
> >>                  sys->add_bus(bus);
> >>  }
> >>
> >> However In arm64, there is no strcut like hw_pci, and I have no idea about how to fix up the msi.
> >>
> >> So, I will be very appreciated if you can give some useful guidance.
> >>
> >> Best regards.
> >>
> >> Dacai
> >>
> >> [1] https://lkml.org/lkml/2014/9/23/852
> >> [2] http://thread.gmane.org/gmane.linux.kernel/1684318
> >>
> >> The test log as  follows:
> >>
> >> hisi-pcie b0000000.pcie: PCI host bridge to bus 0000:00
> >> pci_bus 0000:00: root bus resource [bus 00-0f]
> >> pci_bus 0000:00: root bus resource [mem 0xb4100000-0xb4ffffff]
> >> pci 0000:00:00.0: [19e5:0660] type 01 class 0x060400
> >> pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x0fffffff]
> >> pci 0000:00:00.0: supports D1 D2
> >> pci 0000:00:00.0: PME# supported from D0 D1 D3hot
> >> pci 0000:00:00.0: of_irq_parse_pci() failed with rc=-22
> >> pci 0000:01:00.0: [197b:2362] type 00 class 0x010601
> >> pci 0000:01:00.0: reg 0x10: [io  0x0000-0x0007]
> >> pci 0000:01:00.0: reg 0x14: [io  0x0000-0x0003]
> >> pci 0000:01:00.0: reg 0x18: [io  0x0000-0x0007]
> >> pci 0000:01:00.0: reg 0x1c: [io  0x0000-0x0003]
> >> pci 0000:01:00.0: reg 0x20: [io  0x0000-0x000f]
> >> pci 0000:01:00.0: reg 0x24: [mem 0x00000000-0x000001ff]
> >> pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
> >> pci 0000:01:00.0: PME# supported from D3hot
> >> pci 0000:01:00.0: of_irq_parse_pci() failed with rc=-22
> >> pci 0000:00:00.0: BAR 0: can't assign mem (size 0x10000000)
> >> pci 0000:00:00.0: BAR 8: assigned [mem 0xb4100000-0xb41fffff]
> >> pci 0000:00:00.0: BAR 7: can't assign io (size 0x1000)
> >> pci 0000:01:00.0: BAR 6: assigned [mem 0xb4100000-0xb410ffff pref]
> >> pci 0000:01:00.0: BAR 5: assigned [mem 0xb4110000-0xb41101ff]
> >> pci 0000:01:00.0: BAR 4: can't assign io (size 0x10)
> >> pci 0000:01:00.0: BAR 0: can't assign io (size 0x8)
> >> pci 0000:01:00.0: BAR 2: can't assign io (size 0x8)
> >> pci 0000:01:00.0: BAR 1: can't assign io (size 0x4)
> >> pci 0000:01:00.0: BAR 3: can't assign io (size 0x4)
> > 
> > You don't seem to have declared in your DT your IO range, but
> > the devices you have need some IO space.
> > 
> > Best regards,
> > Liviu
> > 
> >> pci 0000:00:00.0: PCI bridge to [bus 01]
> >> pci 0000:00:00.0:   bridge window [mem 0xb4100000-0xb41fffff]
> >> ...........................................................
> >> ahci 0000:01:00.0: version 3.0
> >> ahci 0000:01:00.0: enabling device (0000 -> 0002)
> >> ahci 0000:01:00.0: ITT 1 entries, 0 bits
> >> ahci 0000:01:00.0: ID:0 pID:8448 vID:48
> >> its_msi_setup_irq 1222,msi addr 0xb7010040,msi data 0x0,msi_phys 0xb7000000
> >> ahci 0000:01:00.0: AHCI 0010.0100 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
> >> ahci 0000:01:00.0: flags: 64bit ncq pm led clo pmp pio slum part
> >> scsi0 : ahci
> >> scsi1 : ahci
> >> ata1: SATA max UDMA/133 abar m512@0xb4110000 port 0xb4110100 irq 48
> >> ata2: SATA max UDMA/133 abar m512@0xb4110000 port 0xb4110180 irq 48
> >> ..............................................................
> >> ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> >> ata1.00: ATA-8: ST3250311SV, CV11, max UDMA/133
> >> ata1.00: 488397168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> >> ata1.00: configured for UDMA/133
> >> scsi 0:0:0:0: Direct-Access     ATA      ST3250311SV      CV11 PQ: 0 ANSI: 5
> >> sd 0:0:0:0: Attached scsi generic sg0 type 0
> >> sd 0:0:0:0: [sda] 488397168 512-byte logical blocks: (250 GB/232 GiB)
> >> sd 0:0:0:0: [sda] Write Protect is off
> >> sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> >> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO
> >>  or FUA
> >>  sda: sda1
> >> sd 0:0:0:0: [sda] Attached SCSI disk
> >> ...........................................................
> >> sh-4.2# lspci
> >> 00:00.0 Class 0604: 19e5:0660
> >> 01:00.0 Class 0106: 197b:2362
> >> sh-4.2# ls /dev/sda
> >> /dev/sda
> >> sh-4.2# ls /dev/sda*
> >> /dev/sda   /dev/sda1
> >> sh-4.2# fdisk -l
> >>
> >> Disk /dev/sda: 250.0 GB, 250059350016 bytes
> >> 255 heads, 63 sectors/track, 30401 cylinders
> >> Units = cylinders of 16065 * 512 = 8225280 bytes
> >>
> >>    Device Boot      Start         End      Blocks  Id System
> >> /dev/sda1               1        1217     9775521  83 Linux
> >> ............................................................
> >>
> >>
> >>
> > 
> 
> 
> -- 
> Thanks!
> Yijing
> 
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

