Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2nam02on0087.outbound.protection.outlook.com ([104.47.38.87]:62277
	"EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750852AbcGMPRQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2016 11:17:16 -0400
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	nofooter <nofooter@xilinx.com>,
	"thomas.petazzoni@free-electrons.com"
	<thomas.petazzoni@free-electrons.com>
Subject: RE: Purpose of pci_remap_iospace
Date: Wed, 13 Jul 2016 15:16:21 +0000
Message-ID: <8520D5D51A55D047800579B094147198258B8B85@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <8520D5D51A55D047800579B094147198258B85DC@XAP-PVEXMBX01.xlnx.xilinx.com>
 <4235946.u1vYRsOpTR@wuerfel>
 <8520D5D51A55D047800579B094147198258B8B06@XAP-PVEXMBX01.xlnx.xilinx.com>
 <4264647.cRxqIJ3z77@wuerfel>
In-Reply-To: <4264647.cRxqIJ3z77@wuerfel>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Subject: Re: Purpose of pci_remap_iospace
>
> On Wednesday, July 13, 2016 12:30:44 PM CEST Bharat Kumar Gogada wrote:
> >  > On Wednesday, July 13, 2016 8:11:56 AM CEST Bharat Kumar Gogada
> wrote:
> > > > > Subject: Re: Purpose of pci_remap_iospace
> > >
> > > I notice you have 1MB of I/O space here
> > >
> > > > Kernel Boot log:
> > > > [    2.345294] nwl-pcie fd0e0000.pcie: Link is UP
> > > > [    2.345339] PCI host bridge /amba/pcie@fd0e0000 ranges:
> > > > [    2.345356]   No bus range found for /amba/pcie@fd0e0000, using
> [bus
> > > 00-ff]
> > > > [    2.345382]    IO 0xe0000000..0xe00fffff -> 0x00000000
> > > > [    2.345401]   MEM 0xe0100000..0xeeffffff -> 0xe0100000
> > > > [    2.345498] nwl-pcie fd0e0000.pcie: PCI host bridge to bus 0000:00
> > > > [    2.345517] pci_bus 0000:00: root bus resource [bus 00-ff]
> > > > [    2.345533] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff]
> > >
> > > and all of it gets mapped by the PCI core. Usually you only have 64K
> > > of I/O space per host bridge, and the PCI core should perhaps not
> > > try to map all of it, though I don't think this is actually your problem here.
> > >
> > > > [    2.345550] pci_bus 0000:00: root bus resource [mem 0xe0100000-
> > > 0xeeffffff]
> > > > [    2.345770] pci 0000:00:00.0: cannot attach to SMMU, is it on the same
> > > bus?
> > > > [    2.345786] iommu: Adding device 0000:00:00.0 to group 1
> > > > [    2.346142] pci 0000:01:00.0: cannot attach to SMMU, is it on the same
> > > bus?
> > > > [    2.346158] iommu: Adding device 0000:01:00.0 to group 1
> > > > [    2.346213] pci 0000:00:00.0: BAR 8: assigned [mem 0xe0100000-
> > > 0xe02fffff]
> > > > [    2.346234] pci 0000:01:00.0: BAR 0: assigned [mem 0xe0100000-
> 0xe01fffff
> > > 64bit]
> > > > [    2.346268] pci 0000:01:00.0: BAR 2: assigned [mem 0xe0200000-
> 0xe02fffff
> > > 64bit]
> > > > [    2.346300] pci 0000:01:00.0: BAR 4: no space for [io  size 0x0040]
> > > > [    2.346316] pci 0000:01:00.0: BAR 4: failed to assign [io  size 0x0040]
> > > > [    2.346333] pci 0000:00:00.0: PCI bridge to [bus 01-0c]
> > > > [    2.346350] pci 0000:00:00.0:   bridge window [mem 0xe0100000-
> > > 0xe02fffff]
> > > >
> > > > IO assignment fails.
> > >
> > > I would guess that the I/O space is not registered correctly. Is
> > > this drivers/pci/host/pcie-xilinx.c ? We have had problems with this
> > > in the past, since almost nobody uses I/O space and it requires
> > > several steps to all be done correctly.
> > >
> > Thanks Arnd.
> >
> > we are testing using drivers/pci/host/pcie-xilinx-nwl.c.
>
> According to Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt,
> this hardware does not support I/O space.

We received a newer IP version with IO support, so we are trying to test this feature.
>
> Is this on ARM or microblaze?

It is ARM 64-bit.

> This has neither the PCI memory nor the I/O resource, it looks like you never
> call pci_add_resource_offset() to start with, or maybe it fails for some
> reason.

I see that above API is used in ARM drivers, do we need to do it in ARM64 also ?

Regards,
Bharat



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

