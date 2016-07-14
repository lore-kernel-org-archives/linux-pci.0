Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:43458 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750897AbcGNOz2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 14 Jul 2016 10:55:28 -0400
Date: Thu, 14 Jul 2016 15:56:24 +0100
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
Message-ID: <20160714145624.GB30657@red-moon>
References: <8520D5D51A55D047800579B094147198258B85DC@XAP-PVEXMBX01.xlnx.xilinx.com>
 <3927657.6zNCtCntSU@wuerfel>
 <8520D5D51A55D047800579B094147198258B8952@XAP-PVEXMBX01.xlnx.xilinx.com>
 <4235946.u1vYRsOpTR@wuerfel>
 <8520D5D51A55D047800579B094147198258B8B06@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20160713134642.GA29309@red-moon>
 <8520D5D51A55D047800579B094147198258B8F73@XAP-PVEXMBX01.xlnx.xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8520D5D51A55D047800579B094147198258B8F73@XAP-PVEXMBX01.xlnx.xilinx.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 14, 2016 at 01:32:13PM +0000, Bharat Kumar Gogada wrote:

[...]

> Hi Lorenzo,
> 
> I missed something in my device tree now I corrected it.
> 
> ranges = <0x01000000 0x00000000 0xe0000000 0x00000000 0xe0000000 0 0x00010000   //io

You have not missed anything, you changed the PCI bus address at
which your host bridge responds to IO space and it must match
your configuration. At what PCI bus address your host bridge
maps IO space ?

>                      0x02000000 0x00000000 0xe0100000 0x00000000 0xe0100000 0 0x0ef00000>; //non prefetchabe memory
> 
> [    2.389498] nwl-pcie fd0e0000.pcie: Link is UP
> [    2.389541] PCI host bridge /amba/pcie@fd0e0000 ranges:
> [    2.389558]   No bus range found for /amba/pcie@fd0e0000, using [bus 00-ff]
> [    2.389583]    IO 0xe0000000..0xe000ffff -> 0xe0000000
> [    2.389624]   MEM 0xe0100000..0xeeffffff -> 0xe0100000
> [    2.389803] nwl-pcie fd0e0000.pcie: PCI host bridge to bus 0000:00
> [    2.389822] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    2.389839] pci_bus 0000:00: root bus resource [io  0x0000-0xffff] (bus address [0xe0000000-0xe000ffff])
> [    2.389863] pci_bus 0000:00: root bus resource [mem 0xe0100000-0xeeffffff]
> [    2.390094] pci 0000:00:00.0: cannot attach to SMMU, is it on the same bus?
> [    2.390110] iommu: Adding device 0000:00:00.0 to group 1
> [    2.390274] pci 0000:01:00.0: reg 0x20: initial BAR value 0x00000000 invalid
> [    2.390481] pci 0000:01:00.0: cannot attach to SMMU, is it on the same bus?
> [    2.390496] iommu: Adding device 0000:01:00.0 to group 1
> [    2.390533] in pci_bridge_check_ranges io 101
> [    2.390545] in pci_bridge_check_ranges io 2 101
> [    2.390575] pci 0000:00:00.0: BAR 8: assigned [mem 0xe0100000-0xe02fffff]
> [    2.390592] pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]
> [    2.390609] pci 0000:00:00.0: BAR 6: assigned [mem 0xe0300000-0xe03007ff pref]
> [    2.390636] pci 0000:01:00.0: BAR 0: assigned [mem 0xe0100000-0xe01fffff 64bit]
> [    2.390669] pci 0000:01:00.0: BAR 2: assigned [mem 0xe0200000-0xe02fffff 64bit]
> [    2.390702] pci 0000:01:00.0: BAR 4: assigned [io  0x1000-0x103f]
> [    2.390721] pci 0000:00:00.0: PCI bridge to [bus 01-0c]
> [    2.390785] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
> [    2.390823] pci 0000:00:00.0:   bridge window [mem 0xe0100000-0xe02fffff]
> 
> Lspci on bridge:
> 00:00.0 PCI bridge: Xilinx Corporation Device a024 (prog-if 00 [Normal decode])
>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Interrupt: pin A routed to IRQ 224
>         Bus: primary=00, secondary=01, subordinate=0c, sec-latency=0
>         I/O behind bridge: e0001000-e0001fff
>         Memory behind bridge: e0100000-e02fffff
> 
> Here my IO space is showing 4k, but what I'm providing is 4k ?(In above boot log also IO space length 4k)
> 
> Lspci on EP:
> 01:00.0 Memory controller: Xilinx Corporation Device d024
>         Subsystem: Xilinx Corporation Device 0007
>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Interrupt: pin A routed to IRQ 224
>         Region 0: Memory at e0100000 (64-bit, non-prefetchable) [disabled] [size=1M]
>         Region 2: Memory at e0200000 (64-bit, non-prefetchable) [disabled] [size=1M]
>         Region 4: I/O ports at 1000 [disabled] [size=64]
> 
> On EP from where it is getting this 1000 address, it should be within
> I/O behind bridge range know ?


The CPU physical address in the DT range for PCI IO range is the
address at which your host bridge responds to PCI IO space cycle
(through memory mapped accesses, to emulate x86 IO port behaviour).

The PCI bus address in the range is the address your
host bridge will convert the incoming physical CPU address
and drive the PCI bus transactions.

Is your host bridge programmed with its address decoder
set-up according to what I say above (and your DT bindings) ?

If yes, on to the virtual address space.

On ARM, for IO space, we map the cpu physical address I
mention above to a chunk of virtual address space allocated
for PCI IO space, that's what pci_remap_iospace() is meant
for.

That physical address is mapped to a fixed virtual address range
(starting with PCI_IOBASE).

The value you see in the IO bar above is an offset into that chunk
of virtual addresses so that, when you do eg inb(offset) in a driver
the code behind it translates that access to a memory mapped access into
the virtual address space allocated to PCI IO space (that you
previously mapped through pci_remap_iospace()).

The offset allocated starts from 0x1000, since that's the
value of PCIBIOS_MIN_IO, that the code assigning resources
use to preserve the range [0..PCIBIOS_MIN_IO] so that it
is not allocated to devices/bridges (ie legacy ISA space).

Does it help ? Your set-up _seems_ correct, what I am worried
about is fiddling about with the DT PCI bus address that is used
to drive PCI IO cycles. That depends on your host bridge address
decoder programmed values and that must match the DT ranges.

Lorenzo

> 
> 
> Thanks & Regards,
> Bharat
> 
> 
> 
> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
> 
