Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:22263 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752547AbdLNNOU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Dec 2017 08:14:20 -0500
Subject: Re: [PATCH v5 3/3] PCI: endpoint: Fix find_first_zero_bit() usage
To: Niklas Cassel <niklas.cassel@axis.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20171214130147.1790-1-niklas.cassel@axis.com>
 <20171214130147.1790-4-niklas.cassel@axis.com>
CC: Niklas Cassel <niklass@axis.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <a34e50a0-b018-d3fd-51fe-4f416c629a44@ti.com>
Date: Thu, 14 Dec 2017 18:43:26 +0530
MIME-Version: 1.0
In-Reply-To: <20171214130147.1790-4-niklas.cassel@axis.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Thursday 14 December 2017 06:31 PM, Niklas Cassel wrote:
> find_first_zero_bit()'s parameter 'size' is defined in bits,
> not in bytes.
> 
> Calling find_first_zero_bit() with the wrong size unit
> will lead to insidious bugs.
> 
> Fix this by calling find_first_zero_bit() with size BITS_PER_LONG,
> rather than sizeof() and add missing find_first_zero_bit() return
> handling.
> 
> Fixes: d74679911610 ("PCI: endpoint: Introduce configfs entry for configuring EP functions")
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/endpoint/pci-ep-cfs.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
> index e8f65eb51c1a..c9a2fb9dd49d 100644
> --- a/drivers/pci/endpoint/pci-ep-cfs.c
> +++ b/drivers/pci/endpoint/pci-ep-cfs.c
> @@ -103,7 +103,10 @@ static int pci_epc_epf_link(struct config_item *epc_item,
>  	struct pci_epf *epf = epf_group->epf;
>  
>  	func_no = find_first_zero_bit(&epc_group->function_num_map,
> -				      sizeof(epc_group->function_num_map));
> +				      BITS_PER_LONG);
> +	if (func_no >= BITS_PER_LONG)
> +		return -EINVAL;
> +
>  	set_bit(func_no, &epc_group->function_num_map);
>  	epf->func_no = func_no;
>  
> 
