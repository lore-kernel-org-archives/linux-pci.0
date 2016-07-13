Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36884 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751002AbcGMNZC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 13 Jul 2016 09:25:02 -0400
Date: Wed, 13 Jul 2016 14:24:35 +0100
From: "Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	nofooter <nofooter@xilinx.com>,
	"thomas.petazzoni@free-electrons.com"
	<thomas.petazzoni@free-electrons.com>
Subject: Re: Purpose of pci_remap_iospace
Message-ID: <20160713132435.GM8609@e106497-lin.cambridge.arm.com>
References: <8520D5D51A55D047800579B094147198258B85DC@XAP-PVEXMBX01.xlnx.xilinx.com>
 <3927657.6zNCtCntSU@wuerfel>
 <8520D5D51A55D047800579B094147198258B8952@XAP-PVEXMBX01.xlnx.xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <8520D5D51A55D047800579B094147198258B8952@XAP-PVEXMBX01.xlnx.xilinx.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 13, 2016 at 08:11:56AM +0000, Bharat Kumar Gogada wrote:
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
> 
> Kernel Boot log:
> [    2.345294] nwl-pcie fd0e0000.pcie: Link is UP
> [    2.345339] PCI host bridge /amba/pcie@fd0e0000 ranges:
> [    2.345356]   No bus range found for /amba/pcie@fd0e0000, using [bus 00-ff]
> [    2.345382]    IO 0xe0000000..0xe00fffff -> 0x00000000
> [    2.345401]   MEM 0xe0100000..0xeeffffff -> 0xe0100000
> [    2.345498] nwl-pcie fd0e0000.pcie: PCI host bridge to bus 0000:00
> [    2.345517] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    2.345533] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff]
> [    2.345550] pci_bus 0000:00: root bus resource [mem 0xe0100000-0xeeffffff]
> [    2.345770] pci 0000:00:00.0: cannot attach to SMMU, is it on the same bus?
> [    2.345786] iommu: Adding device 0000:00:00.0 to group 1
> [    2.346142] pci 0000:01:00.0: cannot attach to SMMU, is it on the same bus?
> [    2.346158] iommu: Adding device 0000:01:00.0 to group 1
> [    2.346213] pci 0000:00:00.0: BAR 8: assigned [mem 0xe0100000-0xe02fffff]
> [    2.346234] pci 0000:01:00.0: BAR 0: assigned [mem 0xe0100000-0xe01fffff 64bit]
> [    2.346268] pci 0000:01:00.0: BAR 2: assigned [mem 0xe0200000-0xe02fffff 64bit]
> [    2.346300] pci 0000:01:00.0: BAR 4: no space for [io  size 0x0040]

Can you try to print the value of ret in pci_assign_resource() when it is printing the above message?

I would tr debugging that function and the __pci_assign_resource() function to figure out
where it fails. Maybe due to IO region being 1MB?

Best regards,
Liviu

> [    2.346316] pci 0000:01:00.0: BAR 4: failed to assign [io  size 0x0040]
> [    2.346333] pci 0000:00:00.0: PCI bridge to [bus 01-0c]
> [    2.346350] pci 0000:00:00.0:   bridge window [mem 0xe0100000-0xe02fffff]
> 
> IO assignment fails.
> 
> On End Point:
> 01:00.0 Memory controller: Xilinx Corporation Device a024
>         Subsystem: Xilinx Corporation Device 0007
>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Interrupt: pin A routed to IRQ 224
>         Region 0: Memory at e0100000 (64-bit, non-prefetchable) [disabled] [size=1M]
>         Region 2: Memory at e0200000 (64-bit, non-prefetchable) [disabled] [size=1M]
>         Region 4: I/O ports at <unassigned> [disabled]
> 
> When I tested on x86 machine the same End Point I/O address is assigned, but it is a IO port mapped address.
> 
> So my doubt is why the memory mapped IO addresses are not assigned to EP on SoC ?
> 
> Do we need to have port mapped addresses on SoC also for PCI IO bars ?
> 
> Please let me know If I'm doing something wrong or missing something.
> 
> Thanks & Regards,
> Bharat
> 
> 
> 
> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
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
