Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49960 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751932AbbLDPB7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 4 Dec 2015 10:01:59 -0500
Date: Fri, 4 Dec 2015 09:01:50 -0600
From: Rob Herring <robh@kernel.org>
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
	linux-sh@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/4] PCI: rcar-gen2: add device tree support for
 r8a7793
Message-ID: <20151204150150.GA26773@rob-hp-laptop>
References: <1449096700-23304-1-git-send-email-horms+renesas@verge.net.au>
 <1449096700-23304-3-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1449096700-23304-3-git-send-email-horms+renesas@verge.net.au>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 03, 2015 at 07:51:38AM +0900, Simon Horman wrote:
> Simply document new compatibility string.
> As a previous patch adds a generic R-Car Gen2 compatibility string
> there appears to be no need for a driver updates.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Rob Herring <robh@kernel.org>

> 
> ---
> * The r8a7792 is omitted from this change as the hardware in question
>   does not appear to be present on that SoC.
> 
> v2
> * No change
> ---
>  Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> index 089a99dcdf10..9c50e0c9d6da 100644
> --- a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> +++ b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> @@ -8,6 +8,7 @@ OHCI and EHCI controllers.
>  Required properties:
>  - compatible: "renesas,pci-r8a7790" for the R8A7790 SoC;
>  	      "renesas,pci-r8a7791" for the R8A7791 SoC;
> +	      "renesas,pci-r8a7793" for the R8A7793 SoC;
>  	      "renesas,pci-r8a7794" for the R8A7794 SoC;
>  	      "renesas,pci-rcar-gen2" for a generic R-Car Gen2 compatible device.
>  
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
