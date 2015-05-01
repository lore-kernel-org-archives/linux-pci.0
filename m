Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0115.outbound.protection.outlook.com ([207.46.100.115]:56713
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753625AbbEAPXf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 1 May 2015 11:23:35 -0400
From: Stuart Yoder <stuart.yoder@freescale.com>
To: Will Deacon <will.deacon@arm.com>,
	Varun Sethi <Varun.Sethi@freescale.com>
CC: Marc Zyngier <Marc.Zyngier@arm.com>,
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
Subject: RE: [PATCH 1/2] irqchip/gicv3-its: Support share device ID
Date: Fri, 1 May 2015 15:23:31 +0000
Message-ID: <CY1PR0301MB074815BD2BF26823E50BE99487D50@CY1PR0301MB0748.namprd03.prod.outlook.com>
References: <CY1PR0301MB0748D9259F32CBBC2C580BD187E30@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <20150422170718.GG13019@arm.com>
 <CY1PR0301MB0748AFF942250831769C40E587EE0@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <20150424161818.GC7313@arm.com> <553A72D4.7000801@arm.com>
 <CY1PR0301MB074896DF1A06CDEC3A0E09B687EC0@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <20150425113930.7386a42a@arm.com>
 <BN1PR0301MB06276181976E880432B8C49AEAEA0@BN1PR0301MB0627.namprd03.prod.outlook.com>
 <553DEC20.3010400@arm.com>
 <BN1PR0301MB0627CD95FC31B221DAA644EDEAE90@BN1PR0301MB0627.namprd03.prod.outlook.com>
 <20150427170423.GC3310@arm.com>
In-Reply-To: <20150427170423.GC3310@arm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Will Deacon [mailto:will.deacon@arm.com]
> Sent: Monday, April 27, 2015 12:04 PM
> To: Sethi Varun-B16395
> Cc: Marc Zyngier; Yoder Stuart-B08248; Lian Minghuan-B31939; linux-pci@vger.kernel.org; Arnd Bergmann; Hu
> Mingkai-B21284; Zang Roy-R61911; Bjorn Helgaas; Wood Scott-B07421; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 1/2] irqchip/gicv3-its: Support share device ID
> 
> On Mon, Apr 27, 2015 at 02:08:10PM +0100, Varun Sethi wrote:
> > > >>> In the SMMU/GIC-500-ITS world the iommu isolation ID (the stream ID)
> > > >>> and the GIC-ITS device ID are in fact the same ID.
> > > >>
> > > >> The DeviceID is the "MSI group" you mention. This is what provides
> > > >> isolation at the ITS level.
> > > >>
> > > > [varun] True, in case of a transparent host bridge device Id won't
> > > > provide the necessary isolation.
> > >
> > > Well, it depends how you look at it. How necessary is this isolation, since
> > > we've already established that you couldn't distinguish between these
> > > devices at the IOMMU level?
> > >
> > [varun] Yes, the devices would fall in the same IOMMU group. So, devices
> > would end up sharing the interrupt?
> 
> Well, I think that's the crux of the issue here. If IOMMU groups are also
> needed to relay constraints to the IRQ subsystem, then perhaps we need a
> more general notion of device grouping and ID transformations between
> the different levels of group hierarchy.

I agree.  Have been thinking about it over the last few days...is is
a matter of renaming what we currently call an "IOMMU group"?   Or,
do we really need to separate general 'device grouping' and 'iommu groups'
in the Linux kernel?

Stuart
