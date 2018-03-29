Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:44751 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752497AbeC2KDI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Mar 2018 06:03:08 -0400
Subject: Re: [PATCH v5 10/12] PCI: endpoint: Make sure that BAR_5 does not
 have 64-bit flag set when clearing
To: Niklas Cassel <niklas.cassel@axis.com>,
        <cyrille.pitchen@free-electrons.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20180328115018.31921-1-niklas.cassel@axis.com>
 <20180328115018.31921-11-niklas.cassel@axis.com>
CC: Niklas Cassel <niklass@axis.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <a2337a50-a881-3303-10a7-b65d11f5b9cb@ti.com>
Date: Thu, 29 Mar 2018 15:32:55 +0530
MIME-Version: 1.0
In-Reply-To: <20180328115018.31921-11-niklas.cassel@axis.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Wednesday 28 March 2018 05:20 PM, Niklas Cassel wrote:
> Since a 64-bit BAR consists of a BAR pair, and since there is no
> BAR after BAR_5, BAR_5 cannot be 64-bits wide.
> 
> This sanity check is done in pci_epc_clear_bar(), so that we don't need
> to do this sanity check in all epc->ops->clear_bar() implementations.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> Kishon made a review comment that he wanted this:
> https://marc.info/?l=linux-kernel&m=152161168226203
> 
> Personally, I don't think that this check is needed,
> since pci_epc_set_bar() already does this check,
> and no one should modify the flags after pci_epc_set_bar()
> has been called.
> 
> If everyone agrees, then this patch could be dropped.
> 
>  drivers/pci/endpoint/pci-epc-core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index eccc942043cb..b0ee42739c3c 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -285,7 +285,9 @@ void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no,
>  {
>  	unsigned long flags;
>  
> -	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
> +	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
> +	    (epf_bar->barno == BAR_5 &&
> +	     epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64))
>  		return;
>  
>  	if (!epc->ops->clear_bar)
> 
