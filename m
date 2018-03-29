Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:25285 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752254AbeC2Jkl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Mar 2018 05:40:41 -0400
Subject: Re: [PATCH v5 03/12] PCI: endpoint: Setting BAR_5 to 64-bits wide is
 invalid
To: Niklas Cassel <niklas.cassel@axis.com>,
        <cyrille.pitchen@free-electrons.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20180328115018.31921-1-niklas.cassel@axis.com>
 <20180328115018.31921-4-niklas.cassel@axis.com>
CC: Niklas Cassel <niklass@axis.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <8a247d0e-73ff-8524-4939-e0e444ff206e@ti.com>
Date: Thu, 29 Mar 2018 15:10:29 +0530
MIME-Version: 1.0
In-Reply-To: <20180328115018.31921-4-niklas.cassel@axis.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Wednesday 28 March 2018 05:20 PM, Niklas Cassel wrote:
> Since a 64-bit BAR consists of a BAR pair, and since there is no
> BAR after BAR_5, BAR_5 cannot be 64-bits wide.
> 
> This sanity check is done in pci_epc_set_bar(), so that we don't need
> to do this sanity check in all epc->ops->set_bar() implementations.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> ---
>  drivers/pci/endpoint/pci-epc-core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 784e33d6f229..109d75f0b7d2 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -310,7 +310,9 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no,
>  	int ret;
>  	unsigned long irq_flags;
>  
> -	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
> +	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
> +	    (epf_bar->barno == BAR_5 &&
> +	     epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64))
>  		return -EINVAL;

It's getting a bit lengthy. I'd prefer two separate ifs as that might be
legible. But otherwise

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
>  
>  	if (!epc->ops->set_bar)
> 
