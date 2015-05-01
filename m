Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38656 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753386AbbEAP07 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 1 May 2015 11:26:59 -0400
Date: Fri, 1 May 2015 16:26:52 +0100
From: Will Deacon <will.deacon@arm.com>
To: Stuart Yoder <stuart.yoder@freescale.com>
Cc: Varun Sethi <Varun.Sethi@freescale.com>,
	Marc Zyngier <Marc.Zyngier@arm.com>,
	"Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"Mingkai.Hu@freescale.com" <Mingkai.Hu@freescale.com>,
	Roy Zang <tie-fei.zang@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Scott Wood <scottwood@freescale.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 1/2] irqchip/gicv3-its: Support share device ID
Message-ID: <20150501152651.GA25524@arm.com>
References: <CY1PR0301MB0748AFF942250831769C40E587EE0@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <20150424161818.GC7313@arm.com>
 <553A72D4.7000801@arm.com>
 <CY1PR0301MB074896DF1A06CDEC3A0E09B687EC0@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <20150425113930.7386a42a@arm.com>
 <BN1PR0301MB06276181976E880432B8C49AEAEA0@BN1PR0301MB0627.namprd03.prod.outlook.com>
 <553DEC20.3010400@arm.com>
 <BN1PR0301MB0627CD95FC31B221DAA644EDEAE90@BN1PR0301MB0627.namprd03.prod.outlook.com>
 <20150427170423.GC3310@arm.com>
 <CY1PR0301MB074815BD2BF26823E50BE99487D50@CY1PR0301MB0748.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CY1PR0301MB074815BD2BF26823E50BE99487D50@CY1PR0301MB0748.namprd03.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 01, 2015 at 04:23:31PM +0100, Stuart Yoder wrote:
> 
> 
> > -----Original Message-----
> > From: Will Deacon [mailto:will.deacon@arm.com]
> > Sent: Monday, April 27, 2015 12:04 PM
> > To: Sethi Varun-B16395
> > Cc: Marc Zyngier; Yoder Stuart-B08248; Lian Minghuan-B31939; linux-pci@vger.kernel.org; Arnd Bergmann; Hu
> > Mingkai-B21284; Zang Roy-R61911; Bjorn Helgaas; Wood Scott-B07421; linux-arm-kernel@lists.infradead.org
> > Subject: Re: [PATCH 1/2] irqchip/gicv3-its: Support share device ID
> > 
> > On Mon, Apr 27, 2015 at 02:08:10PM +0100, Varun Sethi wrote:
> > > > >>> In the SMMU/GIC-500-ITS world the iommu isolation ID (the stream ID)
> > > > >>> and the GIC-ITS device ID are in fact the same ID.
> > > > >>
> > > > >> The DeviceID is the "MSI group" you mention. This is what provides
> > > > >> isolation at the ITS level.
> > > > >>
> > > > > [varun] True, in case of a transparent host bridge device Id won't
> > > > > provide the necessary isolation.
> > > >
> > > > Well, it depends how you look at it. How necessary is this isolation, since
> > > > we've already established that you couldn't distinguish between these
> > > > devices at the IOMMU level?
> > > >
> > > [varun] Yes, the devices would fall in the same IOMMU group. So, devices
> > > would end up sharing the interrupt?
> > 
> > Well, I think that's the crux of the issue here. If IOMMU groups are also
> > needed to relay constraints to the IRQ subsystem, then perhaps we need a
> > more general notion of device grouping and ID transformations between
> > the different levels of group hierarchy.
> 
> I agree.  Have been thinking about it over the last few days...is is
> a matter of renaming what we currently call an "IOMMU group"?   Or,
> do we really need to separate general 'device grouping' and 'iommu groups'
> in the Linux kernel?

It depends. Right now, the IOMMU drivers are responsible for creating the
IOMMU groups and I don't think that's general enough for what we need in
practice. If we move the group creation to be done as part of the bus, then
that would be the first step in having an abstraction that could be re-used
by the interrupt code imo. It would also move us a step closer to having
a generic device group description for platform-bus devices (i.e. as part
of the devicetree).

I suspect the only way we'll really find out is by prototyping stuff and
sending patches.

Will
