Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:41696 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932994AbaJ2QJz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Oct 2014 12:09:55 -0400
Received: by mail-ie0-f171.google.com with SMTP id x19so3297733ier.2
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2014 09:09:54 -0700 (PDT)
Date: Wed, 29 Oct 2014 10:09:52 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-pci@vger.kernel.org, 'Simon Horman' <horms@verge.net.au>,
	'Phil Edworthy' <phil.edworthy@renesas.com>
Subject: Re: [PATCH] PCI: rcar: make local symbol static
Message-ID: <20141029160952.GB12090@google.com>
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

Applied to pci/host-rcar for v3.19 with Simon's ack, thanks!

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
