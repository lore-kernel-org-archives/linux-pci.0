Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:58907 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858AbaJ2Bz0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 Oct 2014 21:55:26 -0400
Date: Wed, 29 Oct 2014 10:55:23 +0900
From: Simon Horman <horms@verge.net.au>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	'Phil Edworthy' <phil.edworthy@renesas.com>
Subject: Re: [PATCH] PCI: rcar: make local symbol static
Message-ID: <20141029015523.GA24918@verge.net.au>
References: <000201cfee66$b319ef90$194dceb0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000201cfee66$b319ef90$194dceb0$%han@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 23, 2014 at 11:11:47AM +0900, Jingoo Han wrote:
> Make local symbol static, because this is used only in this file.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>


Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/pci/host/pcie-rcar.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> index 61158e0..0df9b29 100644
> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -389,7 +389,7 @@ static void rcar_pcie_add_bus(struct pci_bus *bus)
>  	}
>  }
>  
> -struct hw_pci rcar_pci = {
> +static struct hw_pci rcar_pci = {
>  	.setup          = rcar_pcie_setup,
>  	.map_irq        = of_irq_parse_and_map_pci,
>  	.ops            = &rcar_pcie_ops,
> -- 
> 1.7.9.5
> 
> 
