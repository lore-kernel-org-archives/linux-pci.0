Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34293 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752566AbbIXUHY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 24 Sep 2015 16:07:24 -0400
Date: Thu, 24 Sep 2015 15:07:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	horms@verge.net.au, bhelgaas@google.com,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-sh@vger.kernel.org
Subject: Re: [PATCH] pci-rcar-gen2: add R8A7794 support
Message-ID: <20150924200720.GD10481@localhost>
References: <2525770.ZsLzbliFPH@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2525770.ZsLzbliFPH@wasted.cogentembedded.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Sep 12, 2015 at 02:06:09AM +0300, Sergei Shtylyov wrote:
> Add Renesas R8A7794 SoC support to the Renesas R-Car gen2 PCI driver.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied with Simon's ack to for-linus for v4.3, thanks!

I applied this for v4.3 instead of v4.4 because this is new hardware
and I think the chance of breaking anything is minimal.

> ---
> The patch is against the 'next' branch of Bjorn Helgaas' 'pci.git' repo.
> 
>  Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt |    3 ++-
>  drivers/pci/host/pci-rcar-gen2.c                        |    1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> Index: pci/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> ===================================================================
> --- pci.orig/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> +++ pci/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> @@ -7,7 +7,8 @@ OHCI and EHCI controllers.
>  
>  Required properties:
>  - compatible: "renesas,pci-r8a7790" for the R8A7790 SoC;
> -	      "renesas,pci-r8a7791" for the R8A7791 SoC.
> +	      "renesas,pci-r8a7791" for the R8A7791 SoC;
> +	      "renesas,pci-r8a7794" for the R8A7794 SoC.
>  - reg:	A list of physical regions to access the device: the first is
>  	the operational registers for the OHCI/EHCI controllers and the
>  	second is for the bridge configuration and control registers.
> Index: pci/drivers/pci/host/pci-rcar-gen2.c
> ===================================================================
> --- pci.orig/drivers/pci/host/pci-rcar-gen2.c
> +++ pci/drivers/pci/host/pci-rcar-gen2.c
> @@ -362,6 +362,7 @@ static int rcar_pci_probe(struct platfor
>  static struct of_device_id rcar_pci_of_match[] = {
>  	{ .compatible = "renesas,pci-r8a7790", },
>  	{ .compatible = "renesas,pci-r8a7791", },
> +	{ .compatible = "renesas,pci-r8a7794", },
>  	{ },
>  };
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
