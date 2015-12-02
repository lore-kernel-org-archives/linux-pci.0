Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:54799 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932335AbbLBA0y (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 1 Dec 2015 19:26:54 -0500
Date: Wed, 2 Dec 2015 09:26:50 +0900
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/4] PCI: rcar-gen2: Add generic compatibility string
Message-ID: <20151202002650.GI27457@verge.net.au>
References: <1448954672-27236-1-git-send-email-horms+renesas@verge.net.au>
 <1448954672-27236-2-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdVJvChiFTkeeJNBcPG2CsC3PxoEC4Lx0fHOeMMMPLew0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMuHMdVJvChiFTkeeJNBcPG2CsC3PxoEC4Lx0fHOeMMMPLew0g@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 01, 2015 at 09:41:49AM +0100, Geert Uytterhoeven wrote:
> On Tue, Dec 1, 2015 at 8:24 AM, Simon Horman <horms+renesas@verge.net.au> wrote:
> > Add fallback compatibility string for R-Car Gen 2 Family.
> > This is in keeping with the fallback scheme being adopted wherever
> > appropriate for drivers for Renesas SoCs.
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt | 11 +++++++++--
> >  drivers/pci/host/pci-rcar-gen2.c                        |  1 +
> >  2 files changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> > index 891463cb09c2..b19be08a8113 100644
> > --- a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> > +++ b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> > @@ -8,7 +8,14 @@ OHCI and EHCI controllers.
> >  Required properties:
> >  - compatible: "renesas,pci-r8a7790" for the R8A7790 SoC;
> >               "renesas,pci-r8a7791" for the R8A7791 SoC;
> > -             "renesas,pci-r8a7794" for the R8A7794 SoC.
> > +             "renesas,pci-r8a7794" for the R8A7794 SoC;
> > +             "renesas,pci-gen2" for a generic R-Car Gen2 compatible device.
> 
> Shouldn't that be "renesas,pci-rcar-gen" or "renesas,pci-rcar2"?
> 
> Else you'll be in trouble when Renesas starts focussing on airplanes
> (R-Plane Gen2), rockets (R-Rocket Gen2), or IoT (R-IoT Gen2).

Point taken.

I think renesas,pci-rcar-gen2 should work well enough.
