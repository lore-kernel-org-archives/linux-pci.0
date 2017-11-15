Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:56070 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932442AbdKON3H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Nov 2017 08:29:07 -0500
Date: Wed, 15 Nov 2017 05:29:01 -0800
From: Simon Horman <horms@verge.net.au>
To: Biju Das <biju.das@bp.renesas.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Chris Paterson <chris.paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: PCI: rcar: Add device tree support for
 r8a7743
Message-ID: <20171115132901.eoxy6hhons7eed4l@verge.net.au>
References: <1510653543-53770-1-git-send-email-biju.das@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1510653543-53770-1-git-send-email-biju.das@bp.renesas.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 14, 2017 at 09:59:03AM +0000, Biju Das wrote:
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
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
> v1-->v2
>    Corrected RZ-G1 to RZ/G1.
> 
>  Documentation/devicetree/bindings/pci/rcar-pci.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> index 76ba3a6..1fb614e 100644
> --- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> @@ -1,13 +1,15 @@
>  * Renesas R-Car PCIe interface
>  
>  Required properties:
> -compatible: "renesas,pcie-r8a7779" for the R8A7779 SoC;
> +compatible: "renesas,pcie-r8a7743" for the R8A7743 SoC;
> +	    "renesas,pcie-r8a7779" for the R8A7779 SoC;
>  	    "renesas,pcie-r8a7790" for the R8A7790 SoC;
>  	    "renesas,pcie-r8a7791" for the R8A7791 SoC;
>  	    "renesas,pcie-r8a7793" for the R8A7793 SoC;
>  	    "renesas,pcie-r8a7795" for the R8A7795 SoC;
>  	    "renesas,pcie-r8a7796" for the R8A7796 SoC;
> -	    "renesas,pcie-rcar-gen2" for a generic R-Car Gen2 compatible device.
> +	    "renesas,pcie-rcar-gen2" for a generic R-Car Gen2 or
> +				     RZ/G1 compatible device.
>  	    "renesas,pcie-rcar-gen3" for a generic R-Car Gen3 compatible device.
>  
>  	    When compatible with the generic version, nodes must list the
> -- 
> 1.9.1
> 
