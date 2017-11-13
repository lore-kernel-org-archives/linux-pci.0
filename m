Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:57282 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752399AbdKMTLM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Nov 2017 14:11:12 -0500
MIME-Version: 1.0
In-Reply-To: <1510591074-59346-1-git-send-email-biju.das@bp.renesas.com>
References: <1510591074-59346-1-git-send-email-biju.das@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Nov 2017 20:11:11 +0100
Message-ID: <CAMuHMdVDxFCZ=QULonGZ2_pcbO1L1ycxeiYiT=FCTSgJ58kviQ@mail.gmail.com>
Subject: Re: [PATCH ] dt-bindings: PCI: rcar: Add device tree support for r8a7743
To: Biju Das <biju.das@bp.renesas.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Simon Horman <horms@verge.net.au>,
        Chris Paterson <chris.paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Biju,

On Mon, Nov 13, 2017 at 5:37 PM, Biju Das <biju.das@bp.renesas.com> wrote:
> Add support for r8a7743. The Renesas RZ/G1M(R8A7743)PCIe controller
> is identical to the R-Car Gen2 family.
>
> No driver change is needed due to the fallback compatible value
> "renesas,pcie-rcar-gen2".
> Adding the SoC-specific compatible values here has three purposes:
> 1. Document which SoCs have this hardware module,
> 2. Allow checkpatch to validate compatible values.
> 3. Allow the driver to support SoC specific implementations in future
>    as necessary.
>
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Thanks for your patch!

With the below fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> @@ -1,13 +1,15 @@
>  * Renesas R-Car PCIe interface
>
>  Required properties:
> -compatible: "renesas,pcie-r8a7779" for the R8A7779 SoC;
> +compatible: "renesas,pcie-r8a7743" for the R8A7743 SoC;
> +           "renesas,pcie-r8a7779" for the R8A7779 SoC;
>             "renesas,pcie-r8a7790" for the R8A7790 SoC;
>             "renesas,pcie-r8a7791" for the R8A7791 SoC;
>             "renesas,pcie-r8a7793" for the R8A7793 SoC;
>             "renesas,pcie-r8a7795" for the R8A7795 SoC;
>             "renesas,pcie-r8a7796" for the R8A7796 SoC;
> -           "renesas,pcie-rcar-gen2" for a generic R-Car Gen2 compatible device.
> +           "renesas,pcie-rcar-gen2" for a generic R-Car Gen2 or
> +                                    RZ-G1 compatible device.

RZ/G1

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
