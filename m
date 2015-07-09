Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:33632 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753939AbbGIVYe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jul 2015 17:24:34 -0400
Received: by obbgp5 with SMTP id gp5so67611627obb.0
        for <linux-pci@vger.kernel.org>; Thu, 09 Jul 2015 14:24:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1481643.dA4ocqzitg@wuerfel>
References: <46305464.n5SOjGAhJb@wuerfel> <cover.1435688121.git.dhdang@apm.com>
 <CADaLNDmpkdHT7B1fSEu9qtoVcj4ookvxh=BA4EUCvG=pp80s=A@mail.gmail.com> <1481643.dA4ocqzitg@wuerfel>
From: Duc Dang <dhdang@apm.com>
Date: Thu, 9 Jul 2015 14:24:04 -0700
Message-ID: <CADaLNDmARPFtBUuz0sOKMZDtAzgn3Q03P=ZkHsKDUAPZp6NPVA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] pci: xgene: Add multiple memory ranges support
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Kumar Gala <galak@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	linux-kernel@vger.kernel.org, Tanmay Inamdar <tinamdar@apm.com>,
	patches <patches@apm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 9, 2015 at 4:47 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Monday 06 July 2015 16:28:43 Duc Dang wrote:
> > On Tue, Jun 30, 2015 at 11:22 AM, Duc Dang <dhdang@apm.com> wrote:
> > > This patch set adds 1 large (up to 64GB) memory window for each PCIe
> > > controller nodes in X-Gene device tree and fix PCIe controller driver
> > > to handle multiple memory ranges correctly. These changes are required
> > > to support PCIe devices that has huge BAR.
> > >
> > > v2 changes:
> > >         1. Separate device-tree changes and driver changes into different
> > >         patches
> > >         2. Explicitly define new large window as 64-bit prefetchable in dts
> > >         3. Use IORESOURCE_PREFETCH flag to determine which PCIe controller
> > >         register to be used to configure the memory ranges.
> > >
> > >  arch/arm64/boot/dts/apm/apm-storm.dtsi | 23 ++++++++++++++---------
> > >  drivers/pci/host/pci-xgene.c           | 12 ++++++++++--
> > >  2 files changed, 24 insertions(+), 11 deletions(-)
> >
> > Hi Arnd, Bjorn,
> >
> > Do you have additional comment on this v2 patch set?
> >
> >
>
> The changes look ok to me now, but I'd mention in the changelog about
> the fact that one of the windows is prefetchable and the other one
> is not, and that only prefetchable BARs are now using the 64-bit
> window.

Thanks, Arnd.

I posted v3 patch to clarify each PCIe node will have 2 memory windows:
1 non-prefetchable 32-bit memory window and
1 prefetchable 64-bit window

>
>         Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Regards,
Duc Dang.
