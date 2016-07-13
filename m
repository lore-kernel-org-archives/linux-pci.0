Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:56191 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbcGMIbU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2016 04:31:20 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	nofooter <nofooter@xilinx.com>,
	"thomas.petazzoni@free-electrons.com"
	<thomas.petazzoni@free-electrons.com>
Subject: Re: Purpose of pci_remap_iospace
Date: Wed, 13 Jul 2016 10:30:57 +0200
Message-ID: <4235946.u1vYRsOpTR@wuerfel>
In-Reply-To: <8520D5D51A55D047800579B094147198258B8952@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <8520D5D51A55D047800579B094147198258B85DC@XAP-PVEXMBX01.xlnx.xilinx.com> <3927657.6zNCtCntSU@wuerfel> <8520D5D51A55D047800579B094147198258B8952@XAP-PVEXMBX01.xlnx.xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, July 13, 2016 8:11:56 AM CEST Bharat Kumar Gogada wrote:
> > Subject: Re: Purpose of pci_remap_iospace
> >
> > On Tuesday, July 12, 2016 6:57:10 AM CEST Bharat Kumar Gogada wrote:
> > > Hi,
> > >
> > > I have a query.
> > >
> > > Can any once explain the purpose of pci_remap_iospace function in root
> > port driver.
> > >
> > > What is its dependency with architecture ?
> > >
> > > Here is my understanding, the above API takes PCIe IO resource and its
> > > to be mapped CPU address from ranges property and remaps into virtual
> > address space.
> > >
> > > So my question is who uses this virtual addresses ?
> >
> > The inb()/outb() functions declared in asm/io.h
> >
> > > When End Point requests for IO BARs doesn't it get from the above
> > > resource range (first parameter of API) and do ioremap to access this
> > > region ?
> >
> > Device drivers generally do not ioremap() the I/O BARs but they use
> > inb()/outb() directly. They can also call pci_iomap() and do
> > ioread8()/iowrite8() on the pointer returned from that function, but
> > generally the call to pci_iomap() then returns a pointer into the virtual
> > address that is already mapped.
> >
> > > But why root complex driver is mapping this address region ?
> >
> > The PCI core does not know that the I/O space is memory mapped.
> > On x86 and a few others, I/O space is not memory mapped but requires the
> > use of special CPU instructions.
> >
> Thanks Arnd.
> 
> I'm facing issue in testing IO bars on our SoC.
> 
> I added following ranges in our device tree :
> ranges = <0x01000000 0x00000000 0x00000000 0x00000000 0xe0000000 0 0x00100000   //io
>              0x02000000 0x00000000 0xe0100000 0x00000000 0xe0100000 0 0x0ef00000>;   //non prefetchabe memory
> 
> And I'm using above API to map the res and cpu physical address in my driver.

I notice you have 1MB of I/O space here

> Kernel Boot log:
> [    2.345294] nwl-pcie fd0e0000.pcie: Link is UP
> [    2.345339] PCI host bridge /amba/pcie@fd0e0000 ranges:
> [    2.345356]   No bus range found for /amba/pcie@fd0e0000, using [bus 00-ff]
> [    2.345382]    IO 0xe0000000..0xe00fffff -> 0x00000000
> [    2.345401]   MEM 0xe0100000..0xeeffffff -> 0xe0100000
> [    2.345498] nwl-pcie fd0e0000.pcie: PCI host bridge to bus 0000:00
> [    2.345517] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    2.345533] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff]

and all of it gets mapped by the PCI core. Usually you only have 64K of I/O
space per host bridge, and the PCI core should perhaps not try to map
all of it, though I don't think this is actually your problem here.

> [    2.345550] pci_bus 0000:00: root bus resource [mem 0xe0100000-0xeeffffff]
> [    2.345770] pci 0000:00:00.0: cannot attach to SMMU, is it on the same bus?
> [    2.345786] iommu: Adding device 0000:00:00.0 to group 1
> [    2.346142] pci 0000:01:00.0: cannot attach to SMMU, is it on the same bus?
> [    2.346158] iommu: Adding device 0000:01:00.0 to group 1
> [    2.346213] pci 0000:00:00.0: BAR 8: assigned [mem 0xe0100000-0xe02fffff]
> [    2.346234] pci 0000:01:00.0: BAR 0: assigned [mem 0xe0100000-0xe01fffff 64bit]
> [    2.346268] pci 0000:01:00.0: BAR 2: assigned [mem 0xe0200000-0xe02fffff 64bit]
> [    2.346300] pci 0000:01:00.0: BAR 4: no space for [io  size 0x0040]
> [    2.346316] pci 0000:01:00.0: BAR 4: failed to assign [io  size 0x0040]
> [    2.346333] pci 0000:00:00.0: PCI bridge to [bus 01-0c]
> [    2.346350] pci 0000:00:00.0:   bridge window [mem 0xe0100000-0xe02fffff]
> 
> IO assignment fails.

I would guess that the I/O space is not registered correctly. Is this
drivers/pci/host/pcie-xilinx.c ? We have had problems with this in the
past, since almost nobody uses I/O space and it requires several
steps to all be done correctly.

The line "  IO 0xe0000000..0xe00fffff -> 0x00000000" from your log actually
comes from the driver parsing the DT, and that seems to be correct.

Can you add a printk to pci_add_resource_offset() to show which resources
actually get added and what the offset is? Also, please show the contents
of /proc/ioport and /proc/iomem.

	Arnd
