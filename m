Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bbn0101.outbound.protection.outlook.com ([157.56.111.101]:31328
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751160AbbDZSU5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 26 Apr 2015 14:20:57 -0400
From: Varun Sethi <Varun.Sethi@freescale.com>
To: Marc Zyngier <marc.zyngier@arm.com>,
	Stuart Yoder <stuart.yoder@freescale.com>
CC: Will Deacon <Will.Deacon@arm.com>,
	"Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"Mingkai.Hu@freescale.com" <Mingkai.Hu@freescale.com>,
	Roy Zang <tie-fei.zang@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Scott Wood <scottwood@freescale.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 1/2] irqchip/gicv3-its: Support share device ID
Date: Sun, 26 Apr 2015 18:20:52 +0000
Message-ID: <BN1PR0301MB06276181976E880432B8C49AEAEA0@BN1PR0301MB0627.namprd03.prod.outlook.com>
References: <1429091364-31939-1-git-send-email-Minghuan.Lian@freescale.com>
	<1429091364-31939-2-git-send-email-Minghuan.Lian@freescale.com>
	<BN3PR0301MB1219110247416097623B4A7CEAE50@BN3PR0301MB1219.namprd03.prod.outlook.com>
	<DM2PR0301MB06402A7F6BF42B9A84669D94E2E50@DM2PR0301MB0640.namprd03.prod.outlook.com>
	<BN3PR0301MB121987D3E12F25B79E8C51EFEAE50@BN3PR0301MB1219.namprd03.prod.outlook.com>
	<20150416104008.GB25640@arm.com>
	<CY1PR0301MB0748D9259F32CBBC2C580BD187E30@CY1PR0301MB0748.namprd03.prod.outlook.com>
	<20150422170718.GG13019@arm.com>
	<CY1PR0301MB0748AFF942250831769C40E587EE0@CY1PR0301MB0748.namprd03.prod.outlook.com>
	<20150424161818.GC7313@arm.com>	<553A72D4.7000801@arm.com>
	<CY1PR0301MB074896DF1A06CDEC3A0E09B687EC0@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <20150425113930.7386a42a@arm.com>
In-Reply-To: <20150425113930.7386a42a@arm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Marc,

> -----Original Message-----
> From: Marc Zyngier [mailto:marc.zyngier@arm.com]
> Sent: Saturday, April 25, 2015 4:10 PM
> To: Yoder Stuart-B08248
> Cc: Will Deacon; Sethi Varun-B16395; Lian Minghuan-B31939; linux-
> pci@vger.kernel.org; Arnd Bergmann; Hu Mingkai-B21284; Zang Roy-R61911;
> Bjorn Helgaas; Wood Scott-B07421; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 1/2] irqchip/gicv3-its: Support share device ID
> 
> On Fri, 24 Apr 2015 19:18:44 +0100
> Stuart Yoder <stuart.yoder@freescale.com> wrote:
> 
> Hi Stuart,
> 
> >
> >
> > > -----Original Message-----
> > > From: Marc Zyngier [mailto:marc.zyngier@arm.com]
> > > Sent: Friday, April 24, 2015 11:44 AM
> > > To: Will Deacon; Yoder Stuart-B08248
> > > Cc: Sethi Varun-B16395; Lian Minghuan-B31939;
> > > linux-pci@vger.kernel.org; Arnd Bergmann; Hu Mingkai-B21284; Zang
> > > Roy-R61911; Bjorn Helgaas; Wood Scott-B07421;
> > > linux-arm-kernel@lists.infradead.org
> > > Subject: Re: [PATCH 1/2] irqchip/gicv3-its: Support share device ID
> > >
> > > On 24/04/15 17:18, Will Deacon wrote:
> > > > On Wed, Apr 22, 2015 at 08:41:02PM +0100, Stuart Yoder wrote:
> > > >>>> However, there is an improvement we envision as possible due to
> > > >>>> the limited number of SMMU contexts (i.e. 64).  If there are
> > > >>>> 64 SMMU context registers it means that there is a max of
> > > >>>> 64 software contexts where things can be isolated.  But, say I
> > > >>>> have an SRIOV card with 64 VFs, and I want to assign 8 of the
> > > >>>> VFs to a KVM VM.  Those 8 PCI devices could share the same
> > > >>>> streamID/ITS-device-ID since they all share the same isolation
> > > >>>> context.
> > > >>>>
> > > >>>> What would be nice is at the time the 8 VFS are being added to
> > > >>>> the IOMMU domain is for the pcidevid -> streamID mapping table
> > > >>>> to be updated dynamically.  It simply lets us make more
> > > >>>> efficient use of the limited streamIDs we have.
> > > >>>>
> > > >>>> I think it is this improvement that Minghuan had in mind in
> > > >>>> this patch.
> > > >>>
> > > >>> Ok, but in this case it should be possible to use a single
> > > >>> context bank for all of the VF streamIDs by configuring the
> appropriate SMR, no?
> > > >>
> > > >> Yes, but there are limited SMRs.  In our case there are only
> > > >> 128 SMRs in SMMU-500 and we have potentially way more masters
> > > >> than that.
> > > >
> > > > Right, but you still only have 64 context banks at the end of the
> > > > day, so do you really anticipate having more than 128 masters
> > > > concurrently using the SMMU? If so, then we have devices sharing
> > > > context banks so we could consider reusing SMRs across masters,
> > > > but historically that's not been something that we've managed to solve.
> > > >
> > > >>> Wouldn't
> > > >>> that sort of thing be preferable to dynamic StreamID assignment?
> > > >>> It would certainly make life easier for the MSIs.
> > > >>
> > > >> It would be preferable, but given only 128 total stream IDS and
> > > >> 64 context registers it's potentially an issue.  On our LS2085
> > > >> SoC it is PCI and the fsl-mc bus (see description here:
> > > >> https://lkml.org/lkml/2015/3/5/795) that potentially have way
> > > >> more masters than streamIDS. So, for those busses we would
> > > >> essentially view a streamID as a "context ID"-- each SMR is
> > > >> associated with
> > > >> 1 context bank register.
> > > >>
> > > >> For PCI we have a programmable "PCI req ID"-to-"stream ID"
> > > >> mapping table in the PCI controller that is dynamically
> > > >> programmable.
> > > >>
> > > >> Looking at it like that means that we could have any number of
> > > >> masters but only 64 "contexts"
> > > >> and since the masters all all programmable it's seems feasbile to
> > > >> envision doing some bus/vendor specific set up when a device is
> > > >> added to an
> > > >> IOMMU domain.   One thing that would need to be conveyed
> > > >> to the SMMU driver if doing dynamic streamID setup is what
> > > >> streamIDs are available to be used.
> > > >
> > > > Ok, but this is going to make life difficult for the MSI people, I suspect.
> > > >
> > > > Marc...?
> > >
> > > We're really facing two conflicting requirements: in order to
> > > minimize SMR usage, we want to alias multiple ReqIDs to a single
> > > StreamID
> >
> > Another reason could be the isolation characteristics of the
> > hardware...see comment below about PCI bridges.
> >
> > > but in
> > > order to efficiently deal with MSIs, we want to see discrete
> > > DeviceIDs (the actual ReqIDs). I don't easily see how we reconcile the
> two.
> > >
> > > We can deal with the aliasing, provided that we extend the level of
> > > quirkiness that pci_for_each_dma_alias can deal with. But that
> > > doesn't solve any form of hotplug/SR-IOV behaviour.
> > >
[varun] Can you please elaborate on "extending the quirkiness of pci_for_each_dma_alias". How do you see the case for transparent host bridege being handled? We would see a device ID corresponding to the host bridge for masters behind that bridge.

> > > Somehow, we're going to end-up with grossly oversized ITTs, just to
> > > accommodate for the fact that we have no idea how many MSIs we're
> > > going to end-up needing. I'm not thrilled with that prospect.
> >
> > How can we avoid that in the face of hotplug?
> 
> Fortunately, hotplug is not always synonymous of aliasing. The ITS is built
> around the hypothesis that aliasing doesn't happen, and that you know
> upfront how many LPIs the device will be allowed to generate.
> 
> > And what are we really worried about regarding over-sized ITTs...bytes
> > of memory saved?
> 
> That's one thing, yes. But more fundamentally, how do you size your MSI
> capacity for a single alias? Do you evenly split your LPI space among all
> possible aliases? Assuming 64 aliases and 16 bits of interrupt ID space, you
> end up with 10 bit per alias. Is that always enough? Or do you need
> something more fine-grained?
> 
> > A fundamental thing built into the IOMMU subsystem in Linux is
> > representing iommu groups that can represent things like multiple PCI
> > devices that for hardware reasons cannot be isolated (and the example
> > I've seen given relates to devices behind PCI bridges).
> >
> > So, I think the thing we are facing here is that while the IOMMU
> > subsystem has accounted for reprsenting the isolation characteristics
> > of a system with iommu groups, there is no corresponding "msi group"
> > concept.
> >
> > In the SMMU/GIC-500-ITS world the iommu isolation ID (the stream ID)
> > and the GIC-ITS device ID are in fact the same ID.
> 
> The DeviceID is the "MSI group" you mention. This is what provides isolation
> at the ITS level.
> 
[varun] True, in case of a transparent host bridge device Id won't provide the necessary isolation.

> > Is there some way we could sanely correlate IOMMU group creation
> > (which establishes isolation granularity) with the creation of an ITT
> > for the GIC-ITS?
> 
> The problem you have is that your ITT already exists before you start
> "hotpluging" new devices. Take the following (made up) example:
> 
> System boots, device X is discovered, claims 64 MSIs. An ITT for device X is
> allocated, and sized for 64 LPIs. SR-IOV kick is, creates a new X'
> function that is aliased to X, claiming another 64 MSIs. Fail.
> 
> What do we do here? The ITT is live (X is generating interrupts), and there is
> no provision to resize it (I've come up with a horrible scheme, but that could
> fail as well). The only sane option would be to guess how many MSIs a given
> alias could possibly use. How wrong is this guess going to be?
> 
> The problem we have is that IOMMU groups are dynamic, while ITT allocation
> is completely static for a given DeviceID. The architecture doesn't give you
> any mechanism to resize it, and I have the ugly feeling that static allocation of
> the ID space to aliases is too rigid...

[varun] One way would be to restrict the number of stream Ids(device Ids) per PCIe controller. In our scheme we have a device id -> stream ID translation table, we can restrict the number of entries in the table. This would restrict number of virtual functions.

-Varun
