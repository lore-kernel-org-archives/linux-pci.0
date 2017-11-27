Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39694 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752902AbdK0QP5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Nov 2017 11:15:57 -0500
Date: Mon, 27 Nov 2017 16:16:23 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] PCI: endpoint: Fix error handling in
 pci_epc_epf_link()
Message-ID: <20171127161623.GA3435@red-moon>
References: <20171127154955.22214-1-niklas.cassel@axis.com>
 <20171127154955.22214-3-niklas.cassel@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171127154955.22214-3-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 27, 2017 at 04:49:54PM +0100, Niklas Cassel wrote:
> The error handling in pci_epc_epf_link() was broken,

s/was/is

(ie commit logs should be written in the present tense)

> since the clean up code for pci_epc_add_epf() did clear_bit(),

s/did/calls (see above)

> even though the matching set_bit() is done after pci_epc_add_epf().
> 
> Also, clear_bit() should be done before pci_epc_remove_epf(),
> since clean up code should normally do things in the reverse order.
> 
> Fixes: d74679911610 ("PCI: endpoint: Introduce configfs entry for configuring EP functions")
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> ---
>  drivers/pci/endpoint/pci-ep-cfs.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
> index 4f74386c1ced..e1f5adc9e113 100644
> --- a/drivers/pci/endpoint/pci-ep-cfs.c
> +++ b/drivers/pci/endpoint/pci-ep-cfs.c
> @@ -106,7 +106,7 @@ static int pci_epc_epf_link(struct config_item *epc_item,
>  	epf = epf_group->epf;
>  	ret = pci_epc_add_epf(epc, epf);
>  	if (ret)
> -		goto err_add_epf;
> +		return ret;
>  
>  	func_no = find_first_zero_bit(&epc_group->function_num_map,
>  				      sizeof(epc_group->function_num_map));
> @@ -120,10 +120,8 @@ static int pci_epc_epf_link(struct config_item *epc_item,
>  	return 0;
>  
>  err_epf_bind:
> -	pci_epc_remove_epf(epc, epf);
> -
> -err_add_epf:
>  	clear_bit(func_no, &epc_group->function_num_map);
> +	pci_epc_remove_epf(epc, epf);
>  
>  	return ret;
>  }
> -- 
> 2.14.2
> 
