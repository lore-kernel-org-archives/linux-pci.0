Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bn0108.outbound.protection.outlook.com ([157.56.110.108]:41869
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751115AbbDZS0o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 26 Apr 2015 14:26:44 -0400
From: Varun Sethi <Varun.Sethi@freescale.com>
To: Stuart Yoder <stuart.yoder@freescale.com>,
	Will Deacon <will.deacon@arm.com>
CC: "Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"Mingkai.Hu@freescale.com" <Mingkai.Hu@freescale.com>,
	"Roy Zang" <tie-fei.zang@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Scott Wood" <scottwood@freescale.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 1/2] irqchip/gicv3-its: Support share device ID
Date: Sun, 26 Apr 2015 18:26:35 +0000
Message-ID: <BN1PR0301MB0627DCBB2B0D5AE7B5C397DEEAEA0@BN1PR0301MB0627.namprd03.prod.outlook.com>
References: <1429091364-31939-1-git-send-email-Minghuan.Lian@freescale.com>
 <1429091364-31939-2-git-send-email-Minghuan.Lian@freescale.com>
 <BN3PR0301MB1219110247416097623B4A7CEAE50@BN3PR0301MB1219.namprd03.prod.outlook.com>
 <DM2PR0301MB06402A7F6BF42B9A84669D94E2E50@DM2PR0301MB0640.namprd03.prod.outlook.com>
 <BN3PR0301MB121987D3E12F25B79E8C51EFEAE50@BN3PR0301MB1219.namprd03.prod.outlook.com>
 <20150416104008.GB25640@arm.com>
 <CY1PR0301MB0748D9259F32CBBC2C580BD187E30@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <20150422170718.GG13019@arm.com>
 <CY1PR0301MB0748AFF942250831769C40E587EE0@CY1PR0301MB0748.namprd03.prod.outlook.com>
In-Reply-To: <CY1PR0301MB0748AFF942250831769C40E587EE0@CY1PR0301MB0748.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Will/Stuart,

> -----Original Message-----
> From: Yoder Stuart-B08248
> Sent: Thursday, April 23, 2015 1:11 AM
> To: Will Deacon
> Cc: Sethi Varun-B16395; Lian Minghuan-B31939; linux-pci@vger.kernel.org;
> Arnd Bergmann; Hu Mingkai-B21284; Zang Roy-R61911; Bjorn Helgaas; Wood
> Scott-B07421; linux-arm-kernel@lists.infradead.org
> Subject: RE: [PATCH 1/2] irqchip/gicv3-its: Support share device ID
> 
> 
> 
> > -----Original Message-----
> > From: Will Deacon [mailto:will.deacon@arm.com]
> > Sent: Wednesday, April 22, 2015 12:07 PM
> > To: Yoder Stuart-B08248
> > Cc: Sethi Varun-B16395; Lian Minghuan-B31939;
> > linux-pci@vger.kernel.org; Arnd Bergmann; Hu Mingkai-B21284; Zang
> > Roy-R61911; Bjorn Helgaas; Wood Scott-B07421;
> > linux-arm-kernel@lists.infradead.org
> > Subject: Re: [PATCH 1/2] irqchip/gicv3-its: Support share device ID
> >
> > Hi Stuart,
> >
> > First of, thanks for taking the time to explain this in more detail.
> > Comments inline.
> >
> > On Fri, Apr 17, 2015 at 03:19:08PM +0100, Stuart Yoder wrote:
> > > > On Wed, Apr 15, 2015 at 02:18:13PM +0100, Varun Sethi wrote:
> > > > > Yes, deviceid=stream id (i.e. ICID + other bits). I am not sure
> > > > > if TBU ID would also be forwarded as a part of stream id to GIC.
> > > > > My understanding is that TBU ID is forwarded (as a part of the
> > > > > stream ID) to the TCU in case of a TBU translation miss. In case
> > > > > of the LS2085 PCIe controller you would have to setup the PCIe
> > > > > device ID to stream ID translation table. We may have to
> > > > > restrict the number of entries based on the available number of
> contexts.
> > > >
> > > > Unfortunately, I'm having a really hard time parsing this thread
> > > > (some parts of it simply don't make sense; others use
> > > > non-architectural terms and overall I don't get a feeling for the
> problem).
> > > >
> > > > Please could you explain your system design step by step so that I
> > > > can understand (a) what you've built and (b) why the current
> > > > design of Linux is causing you problems?
> > > >
> > > > Sorry if I'm just being thick, but it's important that we get this right.
> > >
> > > I'll try to summarize some key points about the system...
> > >
> > > System is using a single SMMU-500 (1 TCU, 6 TBUs) and GICv3-ITS.
> > > There are PCI, fsl-mc, and platform devices that do DMA.  Devices on
> > > the PCI and fsl-mc bus generate message interrupts.
> >
> > Ah cool, so you have multiple buses sharing a single SMMU? That's
> > going to necessitate some ID remapping in the device-tree. Perhaps you
> > could comment on Mark Rutland's proposal if it does/doesn't work for you:
> >
> >
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/33319
> > 9.html
> 
> Thanks for the pointer, I had not seen that before.  Will read and comment
> on it.
> 
> > > The flow a message interrupt would take is this:
> > >
> > >     --------------
> > >       PCI device
> > >     --------------
> > >           |
> > >           | pcidevid + MSI msg
> > >           |
> > >           V
> > >     --------------
> > >     PCI controller
> > >       pcidevid ->
> > >       streamID
> > >       mapping
> > >     --------------
> > >           |
> > >           | streamID + MSI msg
> > >           |
> > >           V
> > >     --------------
> > >         SMMU
> > >     --------------
> > >           |
> > >           | streamID + MSI msg
> > >           |
> > >           V
> > >     --------------
> > >        CCN-504 (Dickens)
> > >     --------------
> > >           |
> > >           | streamID + MSI msg
> > >           |
> > >           V
> >
> > The streamID here as the same as the one coming out of the SMMU, right?
> 
> Yes.
> 
> > (just trying to out why you have the CCN-504 in the picture).
> 
> It really isn't relevant I guess, just the picture I had in my head.
> 
> > >     --------------
> > >       GICv3 ITS    streamID == ITS deviceID
> > >     --------------
> > >
> > > So, the way things work (at least initially) is that each PCI device
> > > maps to a single streamID, and thus each device has a separate ITT
> > > in the ITS.  So, things should be cool.
> > >
> > > However, there is an improvement we envision as possible due to the
> > > limited number of SMMU contexts (i.e. 64).  If there are
> > > 64 SMMU context registers it means that there is a max of
> > > 64 software contexts where things can be isolated.  But, say I have
> > > an SRIOV card with 64 VFs, and I want to assign 8 of the VFs to a
> > > KVM VM.  Those 8 PCI devices could share the same
> > > streamID/ITS-device-ID since they all share the same isolation
> > > context.
> > >
> > > What would be nice is at the time the 8 VFS are being added to the
> > > IOMMU domain is for the pcidevid -> streamID mapping table to be
> > > updated dynamically.  It simply lets us make more efficient use of
> > > the limited streamIDs we have.
> > >
> > > I think it is this improvement that Minghuan had in mind in this
> > > patch.
> >
> > Ok, but in this case it should be possible to use a single context
> > bank for all of the VF streamIDs by configuring the appropriate SMR, no?
> 
> Yes, but there are limited SMRs.  In our case there are only
> 128 SMRs in SMMU-500 and we have potentially way more masters than
> that.
> 
> > Wouldn't
> > that sort of thing be preferable to dynamic StreamID assignment? It
> > would certainly make life easier for the MSIs.
> 
> It would be preferable, but given only 128 total stream IDS and
> 64 context registers it's potentially an issue.  On our LS2085 SoC it is PCI and
> the fsl-mc bus (see description here:
> https://lkml.org/lkml/2015/3/5/795) that potentially have way more masters
> than streamIDS. So, for those busses we would essentially view a streamID
> as a "context ID"-- each SMR is associated with
> 1 context bank register.
> 
[varun]  On thing to note here is that we would also be hooking up DMA API with the SMMU driver. In that case we would typically require one context per device. We would have to restrict the number of available stream IDs.

-Varun
