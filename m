Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:22917 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752708AbeB0Knx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Feb 2018 05:43:53 -0500
Subject: Re: [PATCH v3 2/2] pci: endpoint: Fix kernel panic after put_device()
To: Rolf Evers-Fischer <embedded24@evers-fischer.de>
References: <20180227100231.22561-1-embedded24@evers-fischer.de>
 <20180227100231.22561-3-embedded24@evers-fischer.de>
CC: <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andy.shevchenko@gmail.com>,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <ab1fb0a5-f1b0-f53d-d986-b5ee62ca6f75@ti.com>
Date: Tue, 27 Feb 2018 16:13:41 +0530
MIME-Version: 1.0
In-Reply-To: <20180227100231.22561-3-embedded24@evers-fischer.de>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Tuesday 27 February 2018 03:32 PM, Rolf Evers-Fischer wrote:
> From: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
> 
> 'put_device()' calls the relase function 'pci_epf_dev_release()',
> which already frees 'epf->name' and 'epf'.
> 
> Therefore we must not free them again after 'put_device()'.
> 
> Fixes: 5e8cb4033807 ("PCI: endpoint: Add EP core layer to enable EP controller and EP functions")
> 
> Signed-off-by: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/endpoint/pci-epf-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 1f2506f32bb9..1878a6776519 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -232,7 +232,7 @@ struct pci_epf *pci_epf_create(const char *name)
>  
>  put_dev:
>  	put_device(dev);
> -	kfree(epf->name);
> +	return ERR_PTR(ret);
>  
>  free_epf:
>  	kfree(epf);
> 
