Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:22245 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752255AbdLNNN4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Dec 2017 08:13:56 -0500
Subject: Re: [PATCH v5 2/3] PCI: endpoint: Populate func_no before calling
 pci_epc_add_epf()
To: Niklas Cassel <niklas.cassel@axis.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20171214130147.1790-1-niklas.cassel@axis.com>
 <20171214130147.1790-3-niklas.cassel@axis.com>
CC: Niklas Cassel <niklass@axis.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <9c3a6048-1f1f-55c8-6c42-75392365e12c@ti.com>
Date: Thu, 14 Dec 2017 18:43:00 +0530
MIME-Version: 1.0
In-Reply-To: <20171214130147.1790-3-niklas.cassel@axis.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Thursday 14 December 2017 06:31 PM, Niklas Cassel wrote:
> func_no is a member of struct pci_epf.
> struct pci_epf is used as an argument to pci_epc_add_epf(),
> therefore func_no should be populated before calling pci_epc_add_epf().
> 
> Fixes: d74679911610 ("PCI: endpoint: Introduce configfs entry for configuring EP functions")
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> Suggested-by: Kishon Vijay Abraham I <kishon@ti.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/endpoint/pci-ep-cfs.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
> index 4f74386c1ced..e8f65eb51c1a 100644
> --- a/drivers/pci/endpoint/pci-ep-cfs.c
> +++ b/drivers/pci/endpoint/pci-ep-cfs.c
> @@ -97,22 +97,20 @@ static int pci_epc_epf_link(struct config_item *epc_item,
>  {
>  	int ret;
>  	u32 func_no = 0;
> -	struct pci_epc *epc;
> -	struct pci_epf *epf;
>  	struct pci_epf_group *epf_group = to_pci_epf_group(epf_item);
>  	struct pci_epc_group *epc_group = to_pci_epc_group(epc_item);
> -
> -	epc = epc_group->epc;
> -	epf = epf_group->epf;
> -	ret = pci_epc_add_epf(epc, epf);
> -	if (ret)
> -		goto err_add_epf;
> +	struct pci_epc *epc = epc_group->epc;
> +	struct pci_epf *epf = epf_group->epf;
>  
>  	func_no = find_first_zero_bit(&epc_group->function_num_map,
>  				      sizeof(epc_group->function_num_map));
>  	set_bit(func_no, &epc_group->function_num_map);
>  	epf->func_no = func_no;
>  
> +	ret = pci_epc_add_epf(epc, epf);
> +	if (ret)
> +		goto err_add_epf;
> +
>  	ret = pci_epf_bind(epf);
>  	if (ret)
>  		goto err_epf_bind;
> 
