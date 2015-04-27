Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57244 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753218AbbD0RE1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 27 Apr 2015 13:04:27 -0400
Date: Mon, 27 Apr 2015 18:04:23 +0100
From: Will Deacon <will.deacon@arm.com>
To: Varun Sethi <Varun.Sethi@freescale.com>
Cc: Marc Zyngier <Marc.Zyngier@arm.com>,
	Stuart Yoder <stuart.yoder@freescale.com>,
	"Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"Mingkai.Hu@freescale.com" <Mingkai.Hu@freescale.com>,
	Roy Zang <tie-fei.zang@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Scott Wood <scottwood@freescale.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] irqchip/gicv3-its: Support share device ID
Message-ID: <20150427170423.GC3310@arm.com>
References: <CY1PR0301MB0748D9259F32CBBC2C580BD187E30@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <20150422170718.GG13019@arm.com>
 <CY1PR0301MB0748AFF942250831769C40E587EE0@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <20150424161818.GC7313@arm.com>
 <553A72D4.7000801@arm.com>
 <CY1PR0301MB074896DF1A06CDEC3A0E09B687EC0@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <20150425113930.7386a42a@arm.com>
 <BN1PR0301MB06276181976E880432B8C49AEAEA0@BN1PR0301MB0627.namprd03.prod.outlook.com>
 <553DEC20.3010400@arm.com>
 <BN1PR0301MB0627CD95FC31B221DAA644EDEAE90@BN1PR0301MB0627.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BN1PR0301MB0627CD95FC31B221DAA644EDEAE90@BN1PR0301MB0627.namprd03.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 27, 2015 at 02:08:10PM +0100, Varun Sethi wrote:
> > >>> In the SMMU/GIC-500-ITS world the iommu isolation ID (the stream ID)
> > >>> and the GIC-ITS device ID are in fact the same ID.
> > >>
> > >> The DeviceID is the "MSI group" you mention. This is what provides
> > >> isolation at the ITS level.
> > >>
> > > [varun] True, in case of a transparent host bridge device Id won't
> > > provide the necessary isolation.
> > 
> > Well, it depends how you look at it. How necessary is this isolation, since
> > we've already established that you couldn't distinguish between these
> > devices at the IOMMU level?
> > 
> [varun] Yes, the devices would fall in the same IOMMU group. So, devices
> would end up sharing the interrupt?

Well, I think that's the crux of the issue here. If IOMMU groups are also
needed to relay constraints to the IRQ subsystem, then perhaps we need a
more general notion of device grouping and ID transformations between
the different levels of group hierarchy.

Will
