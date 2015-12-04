Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49732 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754609AbbLDPBH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 4 Dec 2015 10:01:07 -0500
Date: Fri, 4 Dec 2015 09:00:59 -0600
From: Rob Herring <robh@kernel.org>
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
	linux-sh@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/4] PCI: rcar-gen2: add gen2 fallback compatibility
 string
Message-ID: <20151204150059.GA25543@rob-hp-laptop>
References: <1449096700-23304-1-git-send-email-horms+renesas@verge.net.au>
 <1449096700-23304-2-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1449096700-23304-2-git-send-email-horms+renesas@verge.net.au>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 03, 2015 at 07:51:37AM +0900, Simon Horman wrote:
> Add fallback compatibility string for R-Car Gen 2 family.
> This is in keeping with the fallback scheme being adopted wherever
> appropriate for drivers for Renesas SoCs.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Rob Herring <robh@kernel.org>

> 
> ---
> v2
> * Include "rcar-" in new compatibility string
> ---
>  Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt | 11 +++++++++--
>  drivers/pci/host/pci-rcar-gen2.c                        |  1 +
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> index 891463cb09c2..089a99dcdf10 100644
> --- a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> +++ b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> @@ -8,7 +8,14 @@ OHCI and EHCI controllers.
>  Required properties:
>  - compatible: "renesas,pci-r8a7790" for the R8A7790 SoC;
>  	      "renesas,pci-r8a7791" for the R8A7791 SoC;
> -	      "renesas,pci-r8a7794" for the R8A7794 SoC.
> +	      "renesas,pci-r8a7794" for the R8A7794 SoC;
> +	      "renesas,pci-rcar-gen2" for a generic R-Car Gen2 compatible device.
> +
> +
> +	      When compatible with the generic version, nodes must list the
> +	      SoC-specific version corresponding to the platform first
> +	      followed by the generic version.
> +
>  - reg:	A list of physical regions to access the device: the first is
>  	the operational registers for the OHCI/EHCI controllers and the
>  	second is for the bridge configuration and control registers.
> @@ -32,7 +39,7 @@ Optional properties:
>  Example SoC configuration:
>  
>  	pci0: pci@ee090000  {
> -		compatible = "renesas,pci-r8a7790";
> +		compatible = "renesas,pci-r8a7790", "renesas,pci-rcar-gen2";
>  		clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
>  		reg = <0x0 0xee090000 0x0 0xc00>,
>  		      <0x0 0xee080000 0x0 0x1100>;
> diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
> index 62951165dcbb..9980a4bdae7e 100644
> --- a/drivers/pci/host/pci-rcar-gen2.c
> +++ b/drivers/pci/host/pci-rcar-gen2.c
> @@ -430,6 +430,7 @@ static int rcar_pci_probe(struct platform_device *pdev)
>  }
>  
>  static struct of_device_id rcar_pci_of_match[] = {
> +	{ .compatible = "renesas,pci-rcar-gen2", },
>  	{ .compatible = "renesas,pci-r8a7790", },
>  	{ .compatible = "renesas,pci-r8a7791", },
>  	{ .compatible = "renesas,pci-r8a7794", },
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
