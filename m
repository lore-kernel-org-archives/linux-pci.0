Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:35570 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077AbbEAAgF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Apr 2015 20:36:05 -0400
Date: Fri, 1 May 2015 09:36:00 +0900
From: Simon Horman <horms@verge.net.au>
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: geert@linux-m68k.org, linux-sh@vger.kernel.org,
	magnus.damm@gmail.com, laurent.pinchart+renesas@ideasonboard.com,
	kuninori.morimoto.gx@renesas.com, linus.walleij@linaro.org,
	devicetree@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 15/15] PCI: rcar: document r8a7793 DT bindings
Message-ID: <20150501003600.GC13754@verge.net.au>
References: <1430403544-26742-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1430403544-26742-16-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1430403544-26742-16-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[CC Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org ]

On Thu, Apr 30, 2015 at 04:19:04PM +0200, Ulrich Hecht wrote:
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: devicetree@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt | 1 +
>  1 file changed, 1 insertion(+)

I suppose this one is for the PCI subsystem and thus Bjorn Helgaas (CCed).

> diff --git a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> index d8ef5bf..8b156fe 100644
> --- a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> +++ b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> @@ -8,6 +8,7 @@ OHCI and EHCI controllers.
>  Required properties:
>  - compatible: "renesas,pci-r8a7790" for the R8A7790 SoC;
>  	      "renesas,pci-r8a7791" for the R8A7791 SoC.
> +	      "renesas,pci-r8a7793" for the R8A7793 SoC.
>  - reg:	A list of physical regions to access the device: the first is
>  	the operational registers for the OHCI/EHCI controllers and the
>  	second is for the bridge configuration and control registers.
> -- 
> 2.3.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
