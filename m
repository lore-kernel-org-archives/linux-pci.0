Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0109.outbound.protection.outlook.com ([65.55.169.109]:36800
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750810AbbDQCe3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Apr 2015 22:34:29 -0400
From: "Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>
To: Varun Sethi <Varun.Sethi@freescale.com>,
	Marc Zyngier <marc.zyngier@arm.com>
CC: Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	Stuart Yoder <stuart.yoder@freescale.com>,
	Scott Wood <scottwood@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Mingkai.Hu@freescale.com" <Mingkai.Hu@freescale.com>,
	Roy Zang <tie-fei.zang@freescale.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 1/2] irqchip/gicv3-its: Support share device ID
Date: Fri, 17 Apr 2015 02:34:26 +0000
Message-ID: <DM2PR0301MB06408F3AFF35144FCA6ADF26E2E30@DM2PR0301MB0640.namprd03.prod.outlook.com>
References: <1429091364-31939-1-git-send-email-Minghuan.Lian@freescale.com>
	<1429091364-31939-2-git-send-email-Minghuan.Lian@freescale.com>
 <20150415173654.431f5d89@arm.com>
 <DM2PR0301MB0640576D29E70392C41444DFE2E40@DM2PR0301MB0640.namprd03.prod.outlook.com>
 <552F8910.9000701@arm.com>
 <DM2PR0301MB0640C59C08CBEB4F2F392BAEE2E40@DM2PR0301MB0640.namprd03.prod.outlook.com>
 <552FA20E.3060202@arm.com>
 <BN3PR0301MB1219F18B03194B3F4E7A5751EAE40@BN3PR0301MB1219.namprd03.prod.outlook.com>
In-Reply-To: <BN3PR0301MB1219F18B03194B3F4E7A5751EAE40@BN3PR0301MB1219.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Marc and Varun,

Thank you very much for your valuable comments.
I will study further and try to find a better way to support ls2085 msi.

Thanks,
Minghuan

> -----Original Message-----
> From: Sethi Varun-B16395
> Sent: Friday, April 17, 2015 2:38 AM
> To: Marc Zyngier; Lian Minghuan-B31939
> Cc: Jason Cooper; Arnd Bergmann; linux-pci@vger.kernel.org; Will Deacon;T
> Yoder Stuart-B08248; Wood Scott-B07421; Bjorn Helgaas; Hu Mingkai-B21284;
> Zang Roy-R61911; Thomas Gleixner; linux-arm-kernel@lists.infradead.org
> Subject: RE: [PATCH 1/2] irqchip/gicv3-its: Support share device ID
> 
> Hi Minghuan,
> 
> > -----Original Message-----
> > From: linux-arm-kernel [mailto:linux-arm-kernel-
> > bounces@lists.infradead.org] On Behalf Of Marc Zyngier
> > Sent: Thursday, April 16, 2015 5:21 PM
> > To: Lian Minghuan-B31939
> > Cc: Jason Cooper; Arnd Bergmann; linux-pci@vger.kernel.org; Will
> > Deacon; Yoder Stuart-B08248; Wood Scott-B07421; Bjorn Helgaas; Hu
> > Mingkai-B21284; Zang Roy-R61911; Thomas Gleixner;
> > linux-arm-kernel@lists.infradead.org
> > Subject: Re: [PATCH 1/2] irqchip/gicv3-its: Support share device ID
> >
> > Minghuan,
> >
> > On 16/04/15 11:57, Minghuan.Lian@freescale.com wrote:
> >
> > Please include the relevant people (Will Deacon for questions about
> > the SMMU), and avoid top posting, it makes it very hard to follow a
> discussion.
> >
> > > I still have a couple of questions,
> > > 1. If I add a new flag and all PCI DEVID will be replaced with a
> > > fixed ID,  does SMMU can work correctly? For example, If we insert
> > > an Ethernet card with two ports, a port is assigned to kvm1, another
> > > port is assigned to kvm2. In this case, we should use one or two fixed ID?
> >
> > That completely depends on what the SMMU sees. If it sees the same ID,
> > you won't be able to perform any form of isolation. But I have no idea
> > how your hardware works, so maybe explaining in details how this is
> > constructed will help.
> >
> 
> We would need separate stream IDs and iommu groups for endpoints, to
> assign them to different VMs. We would have to set up the stream ID to
> device ID translation table during device probe, via add_device callback.
> While setting the device id for the interrupt translation table, you would have
> to get streamID corresponding to a given PCIe device ID. Again, I don't think
> that we should consider the TBUID, while setting the ITT device id.
> 
> -Varun
