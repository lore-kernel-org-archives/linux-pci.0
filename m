Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50638 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754771AbbLDV0x (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 4 Dec 2015 16:26:53 -0500
Date: Fri, 4 Dec 2015 15:26:50 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
	linux-sh@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/4] PCI: rcar-gen2: Add device tree support for r8a7793
Message-ID: <20151204212649.GJ20125@localhost>
References: <1448954672-27236-1-git-send-email-horms+renesas@verge.net.au>
 <1448954672-27236-3-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1448954672-27236-3-git-send-email-horms+renesas@verge.net.au>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Simon,

On Tue, Dec 01, 2015 at 04:24:30PM +0900, Simon Horman wrote:
> Simply document new compat strings.
> There appears to be no need for a driver updates.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> index b19be08a8113..7c231b3e5872 100644
> --- a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> +++ b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> @@ -8,6 +8,7 @@ OHCI and EHCI controllers.
>  Required properties:
>  - compatible: "renesas,pci-r8a7790" for the R8A7790 SoC;
>  	      "renesas,pci-r8a7791" for the R8A7791 SoC;
> +	      "renesas,pci-r8a7793" for the R8A7793 SoC;

What's the benefit of adding a string here if the driver doesn't check
for it?  Since the driver doesn't look for it, there's no way to test
anything.

It doesn't seem like this file is an authoritative source of names, so
if we add it here, there's the possibility the r8a7793 will be
canceled or renamed, and then we'd have to update this if the driver
ever did need an r8a7793-specific quirk.  If we waited until the
driver actually needs a quirk, then we'd know exactly what name to
look for and we could update the driver, DT, and doc all together.

>  	      "renesas,pci-r8a7794" for the R8A7794 SoC;
>  	      "renesas,pci-gen2" for a generic R-Car Gen2 compatible device.
>  
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
