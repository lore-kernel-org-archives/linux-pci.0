Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:23542 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751164AbdLNLHc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Dec 2017 06:07:32 -0500
Subject: Re: [PATCH v4 2/3] PCI: endpoint: Fix error handling in
 pci_epc_epf_link()
To: Niklas Cassel <niklas.cassel@axis.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20171212141634.5985-1-niklas.cassel@axis.com>
 <20171212141634.5985-3-niklas.cassel@axis.com>
CC: Niklas Cassel <niklass@axis.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <691e3693-9f18-6546-29d0-4cb155ef5bf6@ti.com>
Date: Thu, 14 Dec 2017 16:37:22 +0530
MIME-Version: 1.0
In-Reply-To: <20171212141634.5985-3-niklas.cassel@axis.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Niklas,

On Tuesday 12 December 2017 07:46 PM, Niklas Cassel wrote:
> The error handling in pci_epc_epf_link() is broken,
> since the clean up code for pci_epc_add_epf() calls clear_bit(),
> even though the matching set_bit() is done after pci_epc_add_epf().
> 
> Also, clear_bit() should be done before pci_epc_remove_epf(),
> since clean up code should normally do things in the reverse order.
> 
> Fixes: d74679911610 ("PCI: endpoint: Introduce configfs entry for configuring EP functions")
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  drivers/pci/endpoint/pci-ep-cfs.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
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

Actually the func_no should be populated before invoking pci_epc_add_epf. Once
that is done, the error handling should be fine.

Thanks
Kishon
