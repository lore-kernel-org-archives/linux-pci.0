Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1blp0182.outbound.protection.outlook.com ([207.46.163.182]:19465
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750740AbaAUFkW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jan 2014 00:40:22 -0500
From: "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	"bhelgaas@google.com" <bhelgaas@google.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"galak@codeaurora.org" <galak@codeaurora.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH 2/2] fsl/pci: The new pci suspend/resume implementation
Date: Tue, 21 Jan 2014 05:40:17 +0000
Message-ID: <fac9007cecb54cad99d371ac08698467@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1389081848-26506-1-git-send-email-dongsheng.wang@freescale.com>
 <1389081848-26506-2-git-send-email-dongsheng.wang@freescale.com>
 <4984978.bktZCpdLkC@vostro.rjw.lan>
 <5ca123d4b32b49719cd9e8506916a9cf@BN1PR03MB188.namprd03.prod.outlook.com>
In-Reply-To: <5ca123d4b32b49719cd9e8506916a9cf@BN1PR03MB188.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Any more comments? :)

Thanks,
-Dongsheng

> -----Original Message-----
> From: Linuxppc-dev [mailto:linuxppc-dev-
> bounces+b40534=freescale.com@lists.ozlabs.org] On Behalf Of
> Dongsheng.Wang@freescale.com
> Sent: Wednesday, January 08, 2014 3:13 PM
> To: Rafael J. Wysocki
> Cc: linuxppc-dev@lists.ozlabs.org; galak@codeaurora.org; Wood Scott-B07421;
> linux-pci@vger.kernel.org; bhelgaas@google.com
> Subject: RE: [PATCH 2/2] fsl/pci: The new pci suspend/resume implementation
> 
> 
> 
> > -----Original Message-----
> > From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > Sent: Wednesday, January 08, 2014 4:42 AM
> > To: Wang Dongsheng-B40534
> > Cc: bhelgaas@google.com; Wood Scott-B07421; galak@codeaurora.org; Zang Roy-
> > R61911; linux-pci@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH 2/2] fsl/pci: The new pci suspend/resume implementation
> >
> > On Tuesday, January 07, 2014 04:04:08 PM Dongsheng Wang wrote:
> > > From: Wang Dongsheng <dongsheng.wang@freescale.com>
> > >
> > > The new suspend/resume implementation, send pme turnoff message
> > > in suspend, and send pme exit message in resume.
> > >
> > > Add a PME handler, to response PME & message interrupt.
> > >
> > > Change platform_driver->suspend/resume to syscore->suspend/resume.
> >
> > Can you please first describe the problem you're trying to address?
> >
> If we do nothing in suspend/resume, some platform PCIe ip-block can't guarantee
> the link back to L0 state from sleep, then, when we read the EP device will hang.
> Only we send pme turnoff message in pci controller suspend, and send pme exit
> message in resume, the link state will be normal.
> 
> When we send pme turnoff message in pci controller suspend, the links will into
> l2/l3
> ready, then, host cannot communicate with ep device, but pci-driver will call
> back EP
> device to save them state. So we need to change platform_driver->suspend/resume
> to
> syscore->suspend/resume.
> 
> Thanks,
> -Dongsheng
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 

