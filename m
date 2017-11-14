Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:48825 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754051AbdKNJr7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Nov 2017 04:47:59 -0500
Received: by mail-lf0-f65.google.com with SMTP id r135so21540408lfe.5
        for <linux-pci@vger.kernel.org>; Tue, 14 Nov 2017 01:47:58 -0800 (PST)
Subject: Re: [PATCH ] dt-bindings: PCI: rcar: Add device tree support for
 r8a7743
To: Biju Das <biju.das@bp.renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: Simon Horman <horms@verge.net.au>,
        Chris Paterson <chris.paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <1510591074-59346-1-git-send-email-biju.das@bp.renesas.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <0d38fedf-c39c-8836-44e6-e23ee0a87668@cogentembedded.com>
Date: Tue, 14 Nov 2017 12:47:56 +0300
MIME-Version: 1.0
In-Reply-To: <1510591074-59346-1-git-send-email-biju.das@bp.renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

On 11/13/2017 7:37 PM, Biju Das wrote:

> Add support for r8a7743. The Renesas RZ/G1M(R8A7743)PCIe controller
> is identical to the R-Car Gen2 family.
> 
> No driver change is needed due to the fallback compatible value
> "renesas,pcie-rcar-gen2".
> Adding the SoC-specific compatible values here has three purposes:
> 1. Document which SoCs have this hardware module,
> 2. Allow checkpatch to validate compatible values.
> 3. Allow the driver to support SoC specific implementations in future
>     as necessary.
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> ---
>   Documentation/devicetree/bindings/pci/rcar-pci.txt | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> index 76ba3a6..2c43e38 100644
> --- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> @@ -1,13 +1,15 @@
>   * Renesas R-Car PCIe interface
>   
>   Required properties:
> -compatible: "renesas,pcie-r8a7779" for the R8A7779 SoC;
> +compatible: "renesas,pcie-r8a7743" for the R8A7743 SoC;
> +	    "renesas,pcie-r8a7779" for the R8A7779 SoC;
>   	    "renesas,pcie-r8a7790" for the R8A7790 SoC;
>   	    "renesas,pcie-r8a7791" for the R8A7791 SoC;
>   	    "renesas,pcie-r8a7793" for the R8A7793 SoC;
>   	    "renesas,pcie-r8a7795" for the R8A7795 SoC;
>   	    "renesas,pcie-r8a7796" for the R8A7796 SoC;
> -	    "renesas,pcie-rcar-gen2" for a generic R-Car Gen2 compatible device.
> +	    "renesas,pcie-rcar-gen2" for a generic R-Car Gen2 or
> +				     RZ-G1 compatible device.

    It's called RZ/G1.

[...]

MBR, Sergei
