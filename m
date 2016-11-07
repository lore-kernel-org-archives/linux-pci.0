Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from [202.4.237.240] ([202.4.237.240]:50135 "EHLO
        kirsty.vergenet.net" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1750776AbcKGMT4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2016 07:19:56 -0500
Date: Mon, 7 Nov 2016 13:19:24 +0100
From: Simon Horman <horms@verge.net.au>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH/RFC] PCI: rcar: Restrict pci_fixup_irqs to the same PCI
 domain
Message-ID: <20161107121924.GA12319@verge.net.au>
References: <1478520048-25430-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478520048-25430-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 07, 2016 at 01:00:48PM +0100, Simon Horman wrote:
> From: Phil Edworthy <phil.edworthy@renesas.com>
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> 
> Phil, this is from the 3.3.2 BSP.
> Is it appropriate for mainline?

I see there is also an infrastructure patch (by you) required for this
change: one to add pci_fixup_irqs_local(). I'll hold off on posting that
pending your answer to the question above.

> ---
>  drivers/pci/host/pcie-rcar.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> index 62700d1896f4..06e7a75094c7 100644
> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -472,7 +472,7 @@ static int rcar_pcie_enable(struct rcar_pcie *pcie)
>  		return -ENODEV;
>  	}
>  
> -	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> +	pci_fixup_irqs_local(bus, pci_common_swizzle, of_irq_parse_and_map_pci);
>  
>  	pci_bus_size_bridges(bus);
>  	pci_bus_assign_resources(bus);
> -- 
> 2.7.0.rc3.207.g0ac5344
> 
