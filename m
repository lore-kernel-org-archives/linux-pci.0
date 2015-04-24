Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0140.outbound.protection.outlook.com ([65.55.169.140]:40397
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751270AbbDXSJl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 Apr 2015 14:09:41 -0400
From: Stuart Yoder <stuart.yoder@freescale.com>
To: Will Deacon <will.deacon@arm.com>
CC: Varun Sethi <Varun.Sethi@freescale.com>,
	"Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"Mingkai.Hu@freescale.com" <Mingkai.Hu@freescale.com>,
	Roy Zang <tie-fei.zang@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Scott Wood <scottwood@freescale.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"marc.zyngier@arm.com" <marc.zyngier@arm.com>
Subject: RE: [PATCH 1/2] irqchip/gicv3-its: Support share device ID
Date: Fri, 24 Apr 2015 18:09:39 +0000
Message-ID: <CY1PR0301MB0748B347C19F976FBF22CB7C87EC0@CY1PR0301MB0748.namprd03.prod.outlook.com>
References: <1429091364-31939-1-git-send-email-Minghuan.Lian@freescale.com>
 <1429091364-31939-2-git-send-email-Minghuan.Lian@freescale.com>
 <BN3PR0301MB1219110247416097623B4A7CEAE50@BN3PR0301MB1219.namprd03.prod.outlook.com>
 <DM2PR0301MB06402A7F6BF42B9A84669D94E2E50@DM2PR0301MB0640.namprd03.prod.outlook.com>
 <BN3PR0301MB121987D3E12F25B79E8C51EFEAE50@BN3PR0301MB1219.namprd03.prod.outlook.com>
 <20150416104008.GB25640@arm.com>
 <CY1PR0301MB0748D9259F32CBBC2C580BD187E30@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <20150422170718.GG13019@arm.com>
 <CY1PR0301MB0748AFF942250831769C40E587EE0@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <20150424161818.GC7313@arm.com>
In-Reply-To: <20150424161818.GC7313@arm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Will Deacon [mailto:will.deacon@arm.com]
> Sent: Friday, April 24, 2015 11:18 AM
> To: Yoder Stuart-B08248
> Cc: Sethi Varun-B16395; Lian Minghuan-B31939; linux-pci@vger.kernel.org; Arnd Bergmann; Hu Mingkai-B21284;
> Zang Roy-R61911; Bjorn Helgaas; Wood Scott-B07421; linux-arm-kernel@lists.infradead.org; marc.zyngier@arm.com
> Subject: Re: [PATCH 1/2] irqchip/gicv3-its: Support share device ID
> 
> On Wed, Apr 22, 2015 at 08:41:02PM +0100, Stuart Yoder wrote:
> > > > However, there is an improvement we envision as possible due to
> > > > the limited number of SMMU contexts (i.e. 64).  If there are
> > > > 64 SMMU context registers it means that there is a max of
> > > > 64 software contexts where things can be isolated.  But, say I have
> > > > an SRIOV card with 64 VFs, and I want to assign 8 of the VFs
> > > > to a KVM VM.  Those 8 PCI devices could share the same
> > > > streamID/ITS-device-ID since they all share the same isolation
> > > > context.
> > > >
> > > > What would be nice is at the time the 8 VFS are being added
> > > > to the IOMMU domain is for the pcidevid -> streamID mapping
> > > > table to be updated dynamically.  It simply lets us make
> > > > more efficient use of the limited streamIDs we have.
> > > >
> > > > I think it is this improvement that Minghuan had in mind
> > > > in this patch.
> > >
> > > Ok, but in this case it should be possible to use a single context bank for
> > > all of the VF streamIDs by configuring the appropriate SMR, no?
> >
> > Yes, but there are limited SMRs.  In our case there are only
> > 128 SMRs in SMMU-500 and we have potentially way more masters than
> > that.
> 
> Right, but you still only have 64 context banks at the end of the day, so do
> you really anticipate having more than 128 masters concurrently using the
> SMMU?

Yes.  We anticiapte quite possibly quite a few more than 128 masters sharing
the 64 context banks.

> If so, then we have devices sharing context banks so we could consider
> reusing SMRs across masters, but historically that's not been something that
> we've managed to solve.

But isn't that what iommu groups are all about?... multiple masters that share
an IOMMU context because of the isolation characteristics of the hardware
like PCI devices behind a PCI bridge.   All the devices might be in
one iommu group.

What is not solved?

Stuart
