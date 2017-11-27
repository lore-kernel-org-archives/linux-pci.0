Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 27 Nov 2017 17:44:11 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] PCI: endpoint: Fix find_first_zero_bit() usage
Message-ID: <20171127174411.GA4123@red-moon>
References: <20171127154955.22214-1-niklas.cassel@axis.com>
 <20171127154955.22214-4-niklas.cassel@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171127154955.22214-4-niklas.cassel@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 27, 2017 at 04:49:55PM +0100, Niklas Cassel wrote:
> find_first_zero_bit()'s parameter 'size' is defined in bits,
> not in bytes.
> 
> Calling find_first_zero_bit() with the wrong size unit
> will lead to insidious bugs.
> 
> Fix this by calling find_first_zero_bit() with size BITS_PER_LONG,
> rather than sizeof().
> 
> Also add proper error handling for find_first_zero_bit(), since this
> was missing.

"Fix this by calling find_first_zero_bit() with size BITS_PER_LONG,
rather than sizeof() and add missing find_first_zero_bit() return
handling"

> Fixes: d74679911610 ("PCI: endpoint: Introduce configfs entry for configuring EP functions")
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> ---
>  drivers/pci/endpoint/pci-ep-cfs.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
> index e1f5adc9e113..0a22a7976580 100644
> --- a/drivers/pci/endpoint/pci-ep-cfs.c
> +++ b/drivers/pci/endpoint/pci-ep-cfs.c
> @@ -109,7 +109,12 @@ static int pci_epc_epf_link(struct config_item *epc_item,
>  		return ret;
>  
>  	func_no = find_first_zero_bit(&epc_group->function_num_map,
> -				      sizeof(epc_group->function_num_map));
> +				      BITS_PER_LONG);
> +	if (func_no >= BITS_PER_LONG) {
> +		ret = -EINVAL;
> +		dev_err(&epc->dev, "failed to link endpoint function device\n");

I would not log the error for the time being or make it more explicit:

dev_error(&epc->dev, "unsupported number of functions, failed to link
endpoint function device\n");

Side note: we _do_ know the max number of functions the epc supports
(epc->max_functions) when this code is called so we do know the
bitmap size - we can rework this code path based on that (@kishon,
thoughts ?).

Other than that:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> +		goto err_func_no;
> +	}
>  	set_bit(func_no, &epc_group->function_num_map);
>  	epf->func_no = func_no;
>  
> @@ -121,6 +126,7 @@ static int pci_epc_epf_link(struct config_item *epc_item,
>  
>  err_epf_bind:
>  	clear_bit(func_no, &epc_group->function_num_map);
> +err_func_no:
>  	pci_epc_remove_epf(epc, epf);
>  
>  	return ret;
> -- 
> 2.14.2
> 
