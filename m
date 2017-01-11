Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751480AbdAKSyn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Jan 2017 13:54:43 -0500
Date: Wed, 11 Jan 2017 12:54:39 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 pci/next] PCI: rcar: Add compatible string for r8a7796
Message-ID: <20170111185439.GH14532@bhelgaas-glaptop.roam.corp.google.com>
References: <1482259026-7180-1-git-send-email-ykaneko0929@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1482259026-7180-1-git-send-email-ykaneko0929@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 21, 2016 at 03:37:06AM +0900, Yoshihiro Kaneko wrote:
> From: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
> 
> This patch adds support for r8a7796.
> 
> Signed-off-by: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied to pci/host-rcar for v4.11 with acks from Simon and Rob, thanks!

> ---
> 
> This patch is based on the next branch of the pci tree.
> 
> v2 [Yoshihiro Kaneko]
> * As suggested by Geert Uytterhoeven
>   Dropped the update of the driver.
> 
>  Documentation/devicetree/bindings/pci/rcar-pci.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> index eee518d..34712d6 100644
> --- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> @@ -6,6 +6,7 @@ compatible: "renesas,pcie-r8a7779" for the R8A7779 SoC;
>  	    "renesas,pcie-r8a7791" for the R8A7791 SoC;
>  	    "renesas,pcie-r8a7793" for the R8A7793 SoC;
>  	    "renesas,pcie-r8a7795" for the R8A7795 SoC;
> +	    "renesas,pcie-r8a7796" for the R8A7796 SoC;
>  	    "renesas,pcie-rcar-gen2" for a generic R-Car Gen2 compatible device.
>  	    "renesas,pcie-rcar-gen3" for a generic R-Car Gen3 compatible device.
>  
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
