Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 14 Jul 2016 16:20:44 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	nofooter <nofooter@xilinx.com>,
	"thomas.petazzoni@free-electrons.com"
	<thomas.petazzoni@free-electrons.com>
Subject: Re: Purpose of pci_remap_iospace
Message-ID: <20160714152044.GC30657@red-moon>
References: <8520D5D51A55D047800579B094147198258B85DC@XAP-PVEXMBX01.xlnx.xilinx.com>
 <3927657.6zNCtCntSU@wuerfel>
 <8520D5D51A55D047800579B094147198258B8952@XAP-PVEXMBX01.xlnx.xilinx.com>
 <4235946.u1vYRsOpTR@wuerfel>
 <8520D5D51A55D047800579B094147198258B8B06@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20160713134642.GA29309@red-moon>
 <8520D5D51A55D047800579B094147198258B8F73@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20160714145624.GB30657@red-moon>
 <8520D5D51A55D047800579B094147198258B8FC3@XAP-PVEXMBX01.xlnx.xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8520D5D51A55D047800579B094147198258B8FC3@XAP-PVEXMBX01.xlnx.xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 14, 2016 at 03:05:40PM +0000, Bharat Kumar Gogada wrote:

[...]

> > On Thu, Jul 14, 2016 at 01:32:13PM +0000, Bharat Kumar Gogada wrote:
> > > ranges = <0x01000000 0x00000000 0xe0000000 0x00000000 0xe0000000 0
> > 0x00010000   //io
> >
> > You have not missed anything, you changed the PCI bus address at which
> > your host bridge responds to IO space and it must match your configuration.
> > At what PCI bus address your host bridge maps IO space ?
> >
> > >                      0x02000000 0x00000000 0xe0100000 0x00000000
> > > 0xe0100000 0 0x0ef00000>; //non prefetchabe memory
> > >
> > > [    2.389498] nwl-pcie fd0e0000.pcie: Link is UP
> > > [    2.389541] PCI host bridge /amba/pcie@fd0e0000 ranges:
> > > [    2.389558]   No bus range found for /amba/pcie@fd0e0000, using [bus
> > 00-ff]
> > > [    2.389583]    IO 0xe0000000..0xe000ffff -> 0xe0000000
> > > [    2.389624]   MEM 0xe0100000..0xeeffffff -> 0xe0100000
> > > [    2.389803] nwl-pcie fd0e0000.pcie: PCI host bridge to bus 0000:00
> > > [    2.389822] pci_bus 0000:00: root bus resource [bus 00-ff]
> > > [    2.389839] pci_bus 0000:00: root bus resource [io  0x0000-0xffff] (bus
> > address [0xe0000000-0xe000ffff])
> > > [    2.389863] pci_bus 0000:00: root bus resource [mem 0xe0100000-
> > 0xeeffffff]
> > > [    2.390094] pci 0000:00:00.0: cannot attach to SMMU, is it on the same
> > bus?
> > > [    2.390110] iommu: Adding device 0000:00:00.0 to group 1
> > > [    2.390274] pci 0000:01:00.0: reg 0x20: initial BAR value 0x00000000 invalid
> > > [    2.390481] pci 0000:01:00.0: cannot attach to SMMU, is it on the same
> > bus?
> > > [    2.390496] iommu: Adding device 0000:01:00.0 to group 1
> > > [    2.390533] in pci_bridge_check_ranges io 101
> > > [    2.390545] in pci_bridge_check_ranges io 2 101
> > > [    2.390575] pci 0000:00:00.0: BAR 8: assigned [mem 0xe0100000-
> > 0xe02fffff]
> > > [    2.390592] pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]
> > > [    2.390609] pci 0000:00:00.0: BAR 6: assigned [mem 0xe0300000-
> > 0xe03007ff pref]
> > > [    2.390636] pci 0000:01:00.0: BAR 0: assigned [mem 0xe0100000-0xe01fffff
> > 64bit]
> > > [    2.390669] pci 0000:01:00.0: BAR 2: assigned [mem 0xe0200000-0xe02fffff
> > 64bit]
> > > [    2.390702] pci 0000:01:00.0: BAR 4: assigned [io  0x1000-0x103f]
> > > [    2.390721] pci 0000:00:00.0: PCI bridge to [bus 01-0c]
> > > [    2.390785] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
> > > [    2.390823] pci 0000:00:00.0:   bridge window [mem 0xe0100000-
> > 0xe02fffff]
> > >
> Thanks a lot Loenzo for your kind and clear explanation, I will dig
> through hardware and correct my device tree.
> 
> From above log why IO space is allocated as only 4k even though I'm
> allocating 64k through device tree ?

You are not allocating anything in the device tree, you are just
defining the physical memory window at which your PCI host bridge
address decoders "map" PCI IO cycles.

PCI core code, while assigning resources, sizes the PCI bridge
IO window BAR by sizing the downstream PCI devices BARs:

See:

pbus_size_io()

PCI core won't allocate an IO window to your PCI bridge window BARs
bigger than what's necessary (according to downstream devices), keeping
alignment in mind.

Is that clear ?

> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

This disclaimer should disappear if you want to discuss patches on
public mailing lists.

Thanks,
Lorenzo
