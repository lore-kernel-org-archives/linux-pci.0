Return-Path: <SRS0=jDI6=QI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E58C282DA
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 17:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697EF21726
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 17:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfBARkL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Feb 2019 12:40:11 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35900 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbfBARkL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Feb 2019 12:40:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8432215BE;
        Fri,  1 Feb 2019 09:40:10 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 707703F589;
        Fri,  1 Feb 2019 09:40:08 -0800 (PST)
Date:   Fri, 1 Feb 2019 17:40:05 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: PCI: rcar: Add device tree support for
 r8a774c0
Message-ID: <20190201174005.GD22887@e107981-ln.cambridge.arm.com>
References: <1545134562-22450-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545134562-22450-1-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 18, 2018 at 12:02:42PM +0000, Fabrizio Castro wrote:
> Add PCIe support for the RZ/G2E (a.k.a. R8A774C0).
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v1->v2:
> * Dropped change to the description of "phys" optional property according
>   to Geert's comment
> 
>  Documentation/devicetree/bindings/pci/rcar-pci.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Hi Fabrizio,

Apologies for the delay in responding.

Should I take this patch via the PCI tree ?

Thanks,
Lorenzo

> 
> diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> index 976ef7b..6904882 100644
> --- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> @@ -3,6 +3,7 @@
>  Required properties:
>  compatible: "renesas,pcie-r8a7743" for the R8A7743 SoC;
>  	    "renesas,pcie-r8a7744" for the R8A7744 SoC;
> +	    "renesas,pcie-r8a774c0" for the R8A774C0 SoC;
>  	    "renesas,pcie-r8a7779" for the R8A7779 SoC;
>  	    "renesas,pcie-r8a7790" for the R8A7790 SoC;
>  	    "renesas,pcie-r8a7791" for the R8A7791 SoC;
> @@ -13,7 +14,8 @@ compatible: "renesas,pcie-r8a7743" for the R8A7743 SoC;
>  	    "renesas,pcie-r8a77990" for the R8A77990 SoC;
>  	    "renesas,pcie-rcar-gen2" for a generic R-Car Gen2 or
>  				     RZ/G1 compatible device.
> -	    "renesas,pcie-rcar-gen3" for a generic R-Car Gen3 compatible device.
> +	    "renesas,pcie-rcar-gen3" for a generic R-Car Gen3 or
> +				     RZ/G2 compatible device.
>  
>  	    When compatible with the generic version, nodes must list the
>  	    SoC-specific version corresponding to the platform first
> -- 
> 2.7.4
> 
