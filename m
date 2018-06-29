Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34640 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932868AbeF2Np2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Jun 2018 09:45:28 -0400
Date: Fri, 29 Jun 2018 14:47:15 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: use after free in
 pci_epf_unregister_driver()
Message-ID: <20180629134715.GG9643@red-moon>
References: <20180531062148.qnhcnnibz2ql6soa@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180531062148.qnhcnnibz2ql6soa@kili.mountain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 31, 2018 at 09:21:48AM +0300, Dan Carpenter wrote:
> We need to use list_for_each_entry_safe() because the
> pci_ep_cfs_remove_epf_group() function frees "group".
> 
> Fixes: ef1433f717a2 ("PCI: endpoint: Create configfs entry for each pci_epf_device_id table entry")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c

Applied to pci/controller-fixes to be tentatively merged for -rc4,
thanks.

Lorenzo

> index 523a8cab3bfb..bf53fad636a5 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -145,10 +145,10 @@ EXPORT_SYMBOL_GPL(pci_epf_alloc_space);
>   */
>  void pci_epf_unregister_driver(struct pci_epf_driver *driver)
>  {
> -	struct config_group *group;
> +	struct config_group *group, *tmp;
>  
>  	mutex_lock(&pci_epf_mutex);
> -	list_for_each_entry(group, &driver->epf_group, group_entry)
> +	list_for_each_entry_safe(group, tmp, &driver->epf_group, group_entry)
>  		pci_ep_cfs_remove_epf_group(group);
>  	list_del(&driver->epf_group);
>  	mutex_unlock(&pci_epf_mutex);
