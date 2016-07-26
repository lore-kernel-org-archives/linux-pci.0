Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-cys01nam02on0070.outbound.protection.outlook.com ([104.47.37.70]:20376
	"EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751462AbcGZPnh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jul 2016 11:43:37 -0400
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Bharat Kumar Gogada <bharatku@xilinx.com>,
	Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>, nofooter <nofooter@xilinx.com>,
	"Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
	"yinghai@kernel.org" <yinghai@kernel.org>
Subject: RE: Why does BIOS assign memory to 16 byte BAR
Date: Tue, 26 Jul 2016 15:43:29 +0000
Message-ID: <8520D5D51A55D047800579B094147198258BC2BB@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <8520D5D51A55D047800579B094147198258BB59B@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20160722151546.GA20646@localhost> <20160722155133.GB20646@localhost>
   <8520D5D51A55D047800579B094147198258BC23C@XAP-PVEXMBX01.xlnx.xilinx.com>
In-Reply-To: <8520D5D51A55D047800579B094147198258BC23C@XAP-PVEXMBX01.xlnx.xilinx.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Adding yinghai lu.

> > > > Subject: Re: Why does BIOS assign memory to 16 byte BAR
> > > >
> > > > On Fri, Jul 22, 2016 at 10:15:46AM -0500, Bjorn Helgaas wrote:
> > > > > Hi Bharat,
> > > > >
> > > > > On Fri, Jul 22, 2016 at 09:24:22AM +0000, Bharat Kumar Gogada wrote:
> > > > > > Hi,
> > > > > >
> > > > > > I'm observing that on x86 BIOS successfully assigns memory if
> > > > > > an End point requests BAR of size 16byte.
> > > > > >
> > > > > > But as per Spec:
> > > > > > The minimum memory address range requested by a BAR is 128
> > bytes.
> > > > >
> > > > > Can you provide the spec reference for this?  I don't see it in
> > > > > PCI r3.0.
> > > > >
> > > > > PCI r3.0, sec 6.2.5.1, shows bits 4-31 of a memory BAR as
> > > > > writable, which would correspond to a minimum size of 16 bytes.
> > > >
> > > > The reference above is to the conventional PCI spec.  I happened
> > > > to trip
> > > over
> > > > a note in PCIe r3.0, sec 1.3.2.2, that for a PCI Express endpoint,
> > > > "the
> > > minimum
> > > > memory address range requested by a BAR is 128 bytes."
> > > >
> > > > I don't think linux currently enforces this minimum.
> > > >
> > >
> > > Hi Bjorn Thanks for the reply.
> > >
> > > Here is what the issue we are seeing.
> > >
> > > We have total memory for BAR's on our SoC of 256 MB.
> > > When an End Point request individually 16 byte BAR's our root port
> > > assigns memory to BAR's successfully.
> > >
> > > But if I have an End point which has 4 BAR's each 32 bit and request
> > > as
> > > following:
> > > When 1st BAR requests 1GB BAR it fails due to lack of memory. (We
> > > are running this as part of SIG compliance test case) 2nd BAR
> > > requests 1MB and other 2 BAR's request 16byte, but these are not
> > > getting BAR's assigned. (Even though BAR space is available, since
> > > 1GB
> > failed,
> > > We have 256 MB still)
> > >
> > > We have only one End point connected to our root port.
> > >
> > > Here is the log:
> > > [    2.319289] nwl-pcie fd0e0000.pcie: Link is UP
> > > [    2.319332] PCI host bridge /amba/pcie@fd0e0000 ranges:
> > > [    2.319349]   No bus range found for /amba/pcie@fd0e0000, using [bus
> > 00-
> > > ff]
> > > [    2.319374]    IO 0xe0000000..0xe000ffff -> 0x00000000
> > > [    2.319415]   MEM 0xe0100000..0xefffffff -> 0xe0100000
> > > [    2.319431]   MEM 0x600000000..0x7ffffffff -> 0x600000000
> > > [    2.319539] nwl-pcie fd0e0000.pcie: PCI host bridge to bus 0000:00
> > > [    2.319557] pci_bus 0000:00: root bus resource [bus 00-ff]
> > > [    2.319573] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> > > [    2.319589] pci_bus 0000:00: root bus resource [mem 0xe0100000-
> > 0xefffffff]
> > > [    2.319606] pci_bus 0000:00: root bus resource [mem 0x600000000-
> > > 0x7ffffffff pref]
> > > [    2.319845] pci 0000:00:00.0: cannot attach to SMMU, is it on the same
> > bus?
> > > [    2.319861] iommu: Adding device 0000:00:00.0 to group 1
> > > [    2.320243] pci 0000:01:00.0: cannot attach to SMMU, is it on the same
> > bus?
> > > [    2.320258] iommu: Adding device 0000:01:00.0 to group 1
> > > [    2.320313] pci 0000:00:00.0: BAR 8: no space for [mem size 0x60000000]
> > > [    2.320331] pci 0000:00:00.0: BAR 8: failed to assign [mem size
> 0x60000000]
> > > [    2.320349] pci 0000:00:00.0: BAR 6: assigned [mem 0xe0100000-
> > 0xe01007ff
> > > pref]
> > > [    2.320374] pci 0000:01:00.0: BAR 0: no space for [mem size 0x40000000]
> > > [    2.320390] pci 0000:01:00.0: BAR 0: failed to assign [mem size
> 0x40000000]
> > > [    2.320407] pci 0000:01:00.0: BAR 4: no space for [mem size 0x00100000
> > > 64bit]
> > > [    2.320423] pci 0000:01:00.0: BAR 4: failed to assign [mem size
> 0x00100000
> > > 64bit]
> > > [    2.320446] pci 0000:01:00.0: BAR 2: no space for [mem size 0x00000010]
> > > [    2.320461] pci 0000:01:00.0: BAR 2: failed to assign [mem size
> 0x00000010]
> > > [    2.320477] pci 0000:01:00.0: BAR 3: no space for [mem size 0x00000010]
> > > [    2.320493] pci 0000:01:00.0: BAR 3: failed to assign [mem size
> 0x00000010]
> > > [    2.320509] pci 0000:00:00.0: PCI bridge to [bus 01-0c]
> > >
> > > Please let me know, what might might be the issue.
> > >
> >
> > Adding to the above will kernel allocate other memory BARs to an End
> > Point if one BAR assignment fails ?
> >
> > What if the End Point has multiple function and say first function BAR
> > assignment failed, will the kernel assign BAR's to second function on
> > same bus and device ?
> >
> After debugging in function pci_bus_alloc_from_region we have two
> resources, One which is taken as parameter (let's say resA), other is from
> pci_bus_for_each_resource (let's say resB).
> 
> The resA contains different start address from resB, I see that resB is
> obtained from device resource from bus->resource, but im unable to
> understand how resA (start address & size) gets its data.
> 
> Can any one help me understand this so that I might know reason why
> 16byte BAR allocation failing after 1GB request.
> 
> Regards,
> Bharat
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
