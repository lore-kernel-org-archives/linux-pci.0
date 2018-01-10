Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752661AbeAJX2A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Jan 2018 18:28:00 -0500
Date: Wed, 10 Jan 2018 17:27:57 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Biju Das <biju.das@bp.renesas.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2] dt-bindings: PCI: rcar: Add device tree support for
 r8a7743
Message-ID: <20180110232757.GG241460@bhelgaas-glaptop.roam.corp.google.com>
References: <1510653543-53770-1-git-send-email-biju.das@bp.renesas.com>
 <KL1PR06MB1702B0E1D37DC38E9E3835F1B8370@KL1PR06MB1702.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <KL1PR06MB1702B0E1D37DC38E9E3835F1B8370@KL1PR06MB1702.apcprd06.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 11, 2017 at 01:30:37PM +0000, Biju Das wrote:
> Hi Bjorn Helgaas,
> 
> Does this patch look okay to you?

It's OK by me, but Lorenzo (cc'd) would handle this now.

> > -----Original Message-----
> > From: Biju Das [mailto:biju.das@bp.renesas.com]
> > Sent: 14 November 2017 09:59
> > To: Bjorn Helgaas <bhelgaas@google.com>; Rob Herring
> > <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>
> > Cc: Simon Horman <horms@verge.net.au>; Magnus Damm
> > <magnus.damm@gmail.com>; Chris Paterson <Chris.Paterson2@renesas.com>;
> > Fabrizio Castro <fabrizio.castro@bp.renesas.com>; linux-pci@vger.kernel.org;
> > linux-renesas-soc@vger.kernel.org; Biju Das <biju.das@bp.renesas.com>
> > Subject: [PATCH v2] dt-bindings: PCI: rcar: Add device tree support for r8a7743
> >
> > Add support for r8a7743. The Renesas RZ/G1M(R8A7743)PCIe controller is
> > identical to the R-Car Gen2 family.
> >
> > No driver change is needed due to the fallback compatible value "renesas,pcie-
> > rcar-gen2".
> > Adding the SoC-specific compatible values here has three purposes:
> > 1. Document which SoCs have this hardware module, 2. Allow checkpatch to
> > validate compatible values.
> > 3. Allow the driver to support SoC specific implementations in future
> >    as necessary.
> >
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > v1-->v2
> >    Corrected RZ-G1 to RZ/G1.
> >
> >  Documentation/devicetree/bindings/pci/rcar-pci.txt | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt
> > b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> > index 76ba3a6..1fb614e 100644
> > --- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
> > +++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> > @@ -1,13 +1,15 @@
> >  * Renesas R-Car PCIe interface
> >
> >  Required properties:
> > -compatible: "renesas,pcie-r8a7779" for the R8A7779 SoC;
> > +compatible: "renesas,pcie-r8a7743" for the R8A7743 SoC;
> > +    "renesas,pcie-r8a7779" for the R8A7779 SoC;
> >      "renesas,pcie-r8a7790" for the R8A7790 SoC;
> >      "renesas,pcie-r8a7791" for the R8A7791 SoC;
> >      "renesas,pcie-r8a7793" for the R8A7793 SoC;
> >      "renesas,pcie-r8a7795" for the R8A7795 SoC;
> >      "renesas,pcie-r8a7796" for the R8A7796 SoC;
> > -    "renesas,pcie-rcar-gen2" for a generic R-Car Gen2 compatible device.
> > +    "renesas,pcie-rcar-gen2" for a generic R-Car Gen2 or
> > +     RZ/G1 compatible device.
> >      "renesas,pcie-rcar-gen3" for a generic R-Car Gen3 compatible device.
> >
> >      When compatible with the generic version, nodes must list the
> > --
> > 1.9.1
> 
> 
> 
> [https://www2.renesas.eu/media/email/unicef_2017.jpg]
> 
> This Christmas, instead of sending out cards, Renesas Electronics Europe have decided to support Unicef with a donation. For further details click here<https://www.unicef.org/> to find out about the valuable work they do, helping children all over the world.
> We would like to take this opportunity to wish you a Merry Christmas and a prosperous New Year.
> 
> 
> 
> Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
