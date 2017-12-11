Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:44782 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752367AbdLKNam (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Dec 2017 08:30:42 -0500
From: Biju Das <biju.das@bp.renesas.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC: Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2] dt-bindings: PCI: rcar: Add device tree support for
 r8a7743
Date: Mon, 11 Dec 2017 13:30:37 +0000
Message-ID: <KL1PR06MB1702B0E1D37DC38E9E3835F1B8370@KL1PR06MB1702.apcprd06.prod.outlook.com>
References: <1510653543-53770-1-git-send-email-biju.das@bp.renesas.com>
In-Reply-To: <1510653543-53770-1-git-send-email-biju.das@bp.renesas.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn Helgaas,

Does this patch look okay to you?

Regards,
Biju

> -----Original Message-----
> From: Biju Das [mailto:biju.das@bp.renesas.com]
> Sent: 14 November 2017 09:59
> To: Bjorn Helgaas <bhelgaas@google.com>; Rob Herring
> <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>
> Cc: Simon Horman <horms@verge.net.au>; Magnus Damm
> <magnus.damm@gmail.com>; Chris Paterson <Chris.Paterson2@renesas.com>;
> Fabrizio Castro <fabrizio.castro@bp.renesas.com>; linux-pci@vger.kernel.o=
rg;
> linux-renesas-soc@vger.kernel.org; Biju Das <biju.das@bp.renesas.com>
> Subject: [PATCH v2] dt-bindings: PCI: rcar: Add device tree support for r=
8a7743
>
> Add support for r8a7743. The Renesas RZ/G1M(R8A7743)PCIe controller is
> identical to the R-Car Gen2 family.
>
> No driver change is needed due to the fallback compatible value "renesas,=
pcie-
> rcar-gen2".
> Adding the SoC-specific compatible values here has three purposes:
> 1. Document which SoCs have this hardware module, 2. Allow checkpatch to
> validate compatible values.
> 3. Allow the driver to support SoC specific implementations in future
>    as necessary.
>
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v1-->v2
>    Corrected RZ-G1 to RZ/G1.
>
>  Documentation/devicetree/bindings/pci/rcar-pci.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt
> b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> index 76ba3a6..1fb614e 100644
> --- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> @@ -1,13 +1,15 @@
>  * Renesas R-Car PCIe interface
>
>  Required properties:
> -compatible: "renesas,pcie-r8a7779" for the R8A7779 SoC;
> +compatible: "renesas,pcie-r8a7743" for the R8A7743 SoC;
> +    "renesas,pcie-r8a7779" for the R8A7779 SoC;
>      "renesas,pcie-r8a7790" for the R8A7790 SoC;
>      "renesas,pcie-r8a7791" for the R8A7791 SoC;
>      "renesas,pcie-r8a7793" for the R8A7793 SoC;
>      "renesas,pcie-r8a7795" for the R8A7795 SoC;
>      "renesas,pcie-r8a7796" for the R8A7796 SoC;
> -    "renesas,pcie-rcar-gen2" for a generic R-Car Gen2 compatible device.
> +    "renesas,pcie-rcar-gen2" for a generic R-Car Gen2 or
> +     RZ/G1 compatible device.
>      "renesas,pcie-rcar-gen3" for a generic R-Car Gen3 compatible device.
>
>      When compatible with the generic version, nodes must list the
> --
> 1.9.1



[https://www2.renesas.eu/media/email/unicef_2017.jpg]

This Christmas, instead of sending out cards, Renesas Electronics Europe ha=
ve decided to support Unicef with a donation. For further details click her=
e<https://www.unicef.org/> to find out about the valuable work they do, hel=
ping children all over the world.
We would like to take this opportunity to wish you a Merry Christmas and a =
prosperous New Year.



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
