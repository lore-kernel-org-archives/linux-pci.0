Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:43907 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbeC2Jmx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Mar 2018 05:42:53 -0400
Subject: Re: [PATCH v5 05/12] PCI: endpoint: Setting a BAR size > 4 GB is
 invalid if 64-bit flag is not set
To: Niklas Cassel <niklas.cassel@axis.com>,
        <cyrille.pitchen@free-electrons.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20180328115018.31921-1-niklas.cassel@axis.com>
 <20180328115018.31921-6-niklas.cassel@axis.com>
CC: Niklas Cassel <niklass@axis.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <71061f04-ab50-10d5-4e88-dadbe8fdbc5c@ti.com>
Date: Thu, 29 Mar 2018 15:12:41 +0530
MIME-Version: 1.0
In-Reply-To: <20180328115018.31921-6-niklas.cassel@axis.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Wednesday 28 March 2018 05:20 PM, Niklas Cassel wrote:
> Setting a BAR size > 4 GB is invalid if PCI_BASE_ADDRESS_MEM_TYPE_64
> flag is not set.
> 
> This sanity check is done in pci_epc_set_bar(), so that we don't need
> to do this sanity check in all epc->ops->set_bar() implementations.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/endpoint/pci-epc-core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 40eea20d21f9..8637822605ff 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -315,7 +315,9 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no,
>  	    (epf_bar->barno == BAR_5 &&
>  	     flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ||
>  	    (flags & PCI_BASE_ADDRESS_SPACE_IO &&
> -	     flags & PCI_BASE_ADDRESS_IO_MASK))
> +	     flags & PCI_BASE_ADDRESS_IO_MASK) ||
> +	    (upper_32_bits(epf_bar->size) &&
> +	     !(flags & PCI_BASE_ADDRESS_MEM_TYPE_64)))
>  		return -EINVAL;
>  
>  	if (!epc->ops->set_bar)
> 
